---
section: contributors
---
- A pull request that changes only documentation runs the documentation
  checks (wording, names, SVGs) in about a minute and a half instead of the
  whole suite; the required `Tests` check still reports on it. A change to a
  document the Rust tests read (docs/API.md, docs/GUIDE_FORMAT.md,
  docs/PACK_FORMAT.md, docs/PACKS.md, README.md, THIRD_PARTY.md) now runs
  them (docs/CI.md, "Lanes").
