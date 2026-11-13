---
section: authors
---
- `when taxi "<Flight point>"`: a step for characters who know that flight
  path, and `when !taxi` for those who don't, so a guide can send the ones
  with the path onto the flight and walk the others, whatever their race. The
  flight point is named as for `getfp`. Polestar counts a path as known once
  it has seen it learnt or on a flight map, so the `!taxi` way should work for
  everyone. A pack that uses it needs Polestar 0.4.0 (pack format 10).
