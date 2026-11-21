---
section: players
---
- After a step change, a spot change or a new waypoint, the arrow points
  straight at the place at once, with its hourglass turning, until the
  walking route arrives (as in 0.4.1.1). The walk's rough line is drawn on
  the map within a frame.
- The walking route arrives sooner after a step change or a spot change:
  a step completed by the kill that ends a fight is searched at full speed
  once the fight is over, and when the game runs below 60 fps (30 fps in
  the background) the search keeps the same speed per second instead of
  slowing down with the frame rate.
