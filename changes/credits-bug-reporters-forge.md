---
section: forge
---
- `forge release credits` also fetches the repository's issues and writes
  the top 40 bug reporters to `Core/Credits.lua` (`bugReporters`): the
  Discord name the bot filed a report under, else the GitHub login, counted
  when the report is labelled `confirmed` or `fix-merged` or was closed as
  completed by a fix, never when it is a duplicate, not planned, invalid,
  still waiting on `needs-info`, or a feature request. `exclude` and `names`
  in `data/credits.json` now take Discord names as well as logins
  (docs/forge/release.md, "The credits").
