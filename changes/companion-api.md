---
section: authors
---
- Addons that build guides of their own have a supported API: docs/API.md
  lists the calls they may rely on (`Polestar.Lookup.RegisterPlanner`,
  `Lookup.BuildGuide`, `Polestar.RegisterGuide`, `Engine.SetGuide`, the quest
  state in `Polestar.Compat`, the `GUIDE_CHANGED` message) with what each
  takes, returns and fires, and `Polestar.API.version` goes up by one whenever
  a release breaks one of them. `Polestar.API.ReplaceSteps(guideId, steps)`
  gives a guide new steps in its own tab, keeping the player's place, done
  steps, ticks and skips (matched by the steps' goals), so a guide that plans
  its own route no longer needs a new guide id each time its plan changes.
