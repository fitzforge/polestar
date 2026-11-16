---
section: contributors
---
- `polestar playtest --persona` plays the guides as imperfect players: one
  who skips a step, loses a quest item, did a quest before the guide offers
  it, updates mid-guide from the last release, or starts the route at a
  guide with nothing from the guides before it. A play is stuck when the
  guide holds the player on a step they can never finish. With the pin
  coverage guard (`tools/pin-coverage.js`: every fixed issue has a test,
  every route and guide record still matches a guide) it is a release step.
