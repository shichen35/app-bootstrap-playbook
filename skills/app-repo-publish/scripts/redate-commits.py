#!/usr/bin/env python3
"""Prints "<commit> <ISO date>" for every commit on HEAD, oldest first, spread evenly over one
day's working hours with random jitter and kept in order. Feed it to git filter-branch:

  git branch backup/before-redate
  python3 redate-commits.py --date YYYY-MM-DD --start 09:00 --end 18:00 --tz -07:00 > /tmp/dates.txt
  FILTER_BRANCH_SQUELCH_WARNING=1 git filter-branch -f --env-filter \\
    'd=$(grep "^$GIT_COMMIT " /tmp/dates.txt | cut -d" " -f2); export GIT_AUTHOR_DATE="$d" GIT_COMMITTER_DATE="$d"' -- main
  git diff backup/before-redate main --stat   # must be empty
  rm -rf .git/refs/original

Only rewrite history that has not been pushed.
"""
import argparse
import random
import subprocess


def seconds(text: str) -> int:
    hours, minutes = text.split(":")
    return int(hours) * 3600 + int(minutes) * 60


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--date", required=True, help="YYYY-MM-DD")
    parser.add_argument("--start", default="09:00")
    parser.add_argument("--end", default="18:00")
    parser.add_argument("--tz", default="-07:00", help="UTC offset, e.g. -07:00 for PDT")
    parser.add_argument("--rev", default="HEAD")
    args = parser.parse_args()

    commits = subprocess.check_output(["git", "rev-list", "--reverse", args.rev], text=True).split()
    start, end = seconds(args.start), seconds(args.end)
    step = (end - start) / max(len(commits), 1)
    previous = start - 60
    for i, commit in enumerate(commits):
        moment = int(start + step * i + random.uniform(0.15, 0.85) * step)
        moment = max(moment, previous + 60)  # strictly increasing, at least a minute apart
        previous = moment
        print(f"{commit} {args.date}T{moment // 3600:02d}:{moment % 3600 // 60:02d}:{moment % 60:02d}{args.tz}")


if __name__ == "__main__":
    main()
