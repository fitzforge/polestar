---
section: players
---
- Target button, target list and step key: a right-click now targets and pings
  for your group (the left click only targets), and the new key bindings
  "Target and ping" and "Step button and ping" do the same from the
  keyboard. It works in a fight too. It replaces the "Ping what they target"
  setting, which is gone (thanks uNBEx for the idea).
- Pressing the game's ping key no longer makes Polestar "blocked from an
  action only available to the Blizzard UI": its secure buttons now answer
  the left and the right mouse button only, so the ping key on another mouse
  button no longer fires them or the code behind them (thanks Dizzm, #4252).
- The target button, the step key and the target list no longer draw
  "Polestar has been blocked from an action only available to the Blizzard UI:
  SetRaidTarget()" on a click: Polestar no longer puts a raid icon back itself
  after a press (the game refused that call even when you were not in a
  fight). The icon comes from the button's own secure macro, as before; when
  the press finds none of its names in a fight, the icon it puts on the target
  you already had stays (thanks Drasi, #4449).
