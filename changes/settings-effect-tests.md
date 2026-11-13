---
section: contributors
---
- The settings window's controls have tests that they change the live
  addon: each effect check (forge-addontest `settings_effects`, one group
  per page in `tests/addontest/effects/`) reads what the addon draws or
  does, sets the control to another value, reads it changed, sets it back
  and reads it restored, and a control without one fails the run.
  `settings_coverage` fails when a control of a past release's window can
  no longer be reached, and `settings_migration` loads real saved settings
  from several characters.
