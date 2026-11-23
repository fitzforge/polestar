---
section: contributors
---
- CI runs the tests that read the reference data instead of skipping them:
  every pull request on public data built on next (failing only where next
  passes), and pull requests from this repository's branches on the release
  data as well, on the maintainers' runner (#3310).
