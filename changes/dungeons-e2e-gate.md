---
section: contributors
---
- A release gate for dungeons in the route: forge-addontest `dungeons_e2e`
  (run with `--ignored`) plays the shipped leveling route 1-60 from every
  start with dungeons skipped, run and asked, and turned on and off
  mid-route, and checks that Skip is exactly the solo route, that every run
  comes with its quests picked up before and handed in after, that no step
  comes twice or goes back, and that the quest log stays under 40.
  `DUNGEONS_E2E_LEVELS` takes the calibrated level model's output; a run the
  model reaches under its dungeon's floor is a warning. The report lists
  each scenario's route and dungeons.
