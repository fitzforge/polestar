---
section: contributors
---
- More tests for every settings control in forge-addontest. Each effect check
  (`settings_effects`) also checks that a control's effect follows a profile
  switch both ways and comes back after a reload; a check whose reads change
  the game world opts out of the first with `once = true`, and one that a
  reload cannot rebuild with `reload = false` and a reason.
  `settings_roundtrip` checks that every control reads back what it writes, at
  once and after a reload; that Reset page puts every setting back and Undo
  restores it; that Reset all clears every control; that a profile string
  carries every setting, every moved frame's position and the skin's variant;
  that child and detail rows are greyed out while their switch is off; and
  that the slash commands set what the rows show. `settings_smoke` sets every
  control to its values with no guide loaded, in combat, while hidden, while
  paused, on the gamepad interface and on its open page, covers every Look
  page in every look, walks 2,000 seeded random changes between guide actions
  and reloads, and sets every pair of the 40 most connected switches.
