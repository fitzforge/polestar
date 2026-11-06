---
section: contributors
---
- Forge's writer engine tests on full local data (`POLESTAR_V1` set,
  `--include-ignored`) keep one copy of the data per running test instead of
  one per test run so far: a whole run peaks at about 1 GB with one test
  thread (2.4 GB with four), down from about 14 GB.
