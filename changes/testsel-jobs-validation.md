---
section: contributors
---
- The test runner rejects invalid or missing `--jobs` counts instead of
  silently skipping selected tests. Direct callers of `runFiles` also
  receive an error for invalid worker counts (thanks philippgreitsch, and
  shacklef00rd, #2076).
