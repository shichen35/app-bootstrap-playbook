Measure and optimize the performance of {{APP_NAME}}:

- Target: at {{scale, e.g. 50,000 entries, 3 years of Monthly Logs}}, the UI stays smooth and background CPU and battery use stay acceptable.
- First, check the implementation item by item against the design in doc/performance-research.md, and list every mismatch.
- Measure {{cold start and search with a large dataset, frame rate while scrolling and editing, background CPU (before and after adding ads)}}, and capture one trace with {{Perfetto / Instruments}}.
- One commit per optimization. Record before and after numbers in the "decision" of the matching item in performance-research.md, or in a new ADR. For anything deferred, state what would trigger it.
