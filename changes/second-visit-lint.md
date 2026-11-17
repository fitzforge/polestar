---
section: forge
---
- `forge guide lint` flags an accept in Polestar's leveling guides whose
  prerequisite only an earlier guide's visit to the same zone brings, unless
  the guide brings the prerequisite back itself before it (steps
  `when !turnedin`) or data/route-fixes.json records why it stays out
  (`overrides.leftout`, checked by `forge data check-corrections`).
