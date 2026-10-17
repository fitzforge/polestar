---
section: contributors
---
- Nav asks the router with the player's faction (`Compat.GetPlayerFaction`,
  opts.profile), chooses walks by the router's cost and shows and times them
  by its yards (`walkCost` returns cost, yards; `Walk.LegPath` returns yards,
  hubs). `Travel.WalkCostHook(fn)` lets a planner rule scale walk costs;
  `leg.hubs` carries the hostile towns a walk enters (journey line,
  `Travel.TakeWarning` for the arrow). `Nav.HandedOff()` is also true while
  Shortest Path Forever runs a journey not Polestar's
  (`Nav.handoff.Yielding()`).
