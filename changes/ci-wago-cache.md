---
section: contributors
---
- CI no longer downloads the client tables from wago.tools on every run: a
  weekly workflow caches them, the texture and data-corrections checks read
  the cache offline, and the texture check runs only when a generator or its
  inputs change. `polestar media --offline` reads the cached tables only, and
  a wago.tools 429 or 5xx is retried before it fails a download.
