#!/usr/bin/env python3
"""Adds translations to a String Catalog.

Usage: tools/translate.py <catalog.xcstrings> [lang] < translations.json
translations.json maps each source key to its translation (lang defaults to zh-Hans). Keys
missing from the catalog are added (for strings Xcode cannot extract, such as Info.plist keys).
List the untranslated keys first with:
  python3 -c "import json;c=json.load(open('App/Localizable.xcstrings'));print(json.dumps([k for k,v in c['strings'].items() if 'zh-Hans' not in v.get('localizations',{})],ensure_ascii=False))"
"""
import json
import sys

path = sys.argv[1]
lang = sys.argv[2] if len(sys.argv) > 2 else "zh-Hans"
catalog = json.load(open(path))
for key, text in json.load(sys.stdin).items():
    entry = catalog["strings"].setdefault(key, {})
    entry.setdefault("localizations", {})[lang] = {"stringUnit": {"state": "translated", "value": text}}
with open(path, "w") as f:
    json.dump(catalog, f, ensure_ascii=False, indent=2, separators=(",", " : "), sort_keys=True)
    f.write("\n")
