# 08 · Performance: design first, then measure

Start by writing the target scale into the requirements (for the Example App: 50,000 journal entries and several years of Monthly Logs, with smooth list scrolling and search and no background battery drain). Then design and verify against the checklist below.

## Design checklist

**Data and I/O**
- Load lists from the database one page at a time (Room `PagingSource` / SwiftData `FetchDescriptor` with `fetchLimit` + offset); never read every entry at once.
- Run full-text search on the database's built-in full-text index (SQLite FTS), updated incrementally on write, rather than matching entries one by one in memory.
- Coalesce writes: debounce consecutive edits (e.g. 300 ms) and write them in one transaction. Bulk operations such as import and Migration each run in a single transaction.
- Do file I/O (export, backup, attachments) only on background threads or tasks.
- Don't run a timer per entry. Schedule reminders only for the next few due (iOS caps pending local notifications at 64), and schedule the next batch once those fire.

**State and UI**
- Mutate business state on one serial context only (a Swift actor / a single-threaded Kotlin dispatcher). Background callbacks just enqueue, and changes are applied in batches.
- Publish immutable snapshots in which unchanged rows reuse the same object (structural sharing). The UI compares by id + revision, never by full row contents.
- Observe a version number, not an array of thousands of rows (`@Observable` notifies on every assignment, even when the value hasn't changed).
- Compare list rows by id + revision (Compose strong skipping / SwiftUI `Equatable` views).
- If a filter change doesn't affect ordering, patch in place; otherwise re-project. Tests ensure both paths produce the same result.
- Load detail data only while it's visible; compute charts and statistics only for the visible range (e.g. the last 12 months).
- Refresh widget and notification summaries only when their content changes, and enforce a minimum interval.

**Background**
- Android: run sync and backup through WorkManager with constraints (charging, Wi-Fi). Reminders that use exact alarms need to explain why and handle a denied permission.
- iOS: long-running background work isn't available. Use `BGAppRefreshTask` for lightweight sync, and `beginBackgroundTask` only to finish writes already in flight.

## How to measure

- Large datasets: script-generate 50,000 demo entries spanning 3 years, then time cold start, first screen, scrolling to the bottom, and the first search result.
- Background CPU and battery: measure once before and once after adding ads and sync; there should be no visible difference.
- UI: frame rate while scrolling and editing; capture one trace with the platform profiler (Perfetto / Instruments).
- Record the findings in the "Decision" of the matching item in `performance-research.md`, or open a new ADR.

## Lessons

- "Not implementing this yet" still needs a decision and a trigger ("FTS handles search fine up to 50,000 entries; revisit sharding the database if users report more than 200,000").
- `@Observable` notifies on every assignment, even when the value hasn't changed. Wrap assignments in `assignIfChanged`.
