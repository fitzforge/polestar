---
section: players
---
- Registering the guides at login makes about 3 MiB less short-lived garbage
  for the collector to clear up: the checks that walk every step and goal now
  share one table of key names instead of building a new one per goal (#60).
