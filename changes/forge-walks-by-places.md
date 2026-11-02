---
section: forge
---
- `forge build`'s walks stage is keyed by what the walks are made of (each
  world's places and the zones' danger, the walkers' answer versions, the
  walking maps), not by the data at large: a data fix that moves and adds no
  place skips it, and one that adds places (#735's kill camp) routes only the
  new places' pairs, the walk stores answering the rest by their ends. The
  walks files carry the world's `walksKey`, which the routes stage, the
  writer and `--walks-from` check them against, and the extra walk pairs
  (`walks/extra-pairs.json`) are kept by their places, so a correction that
  shifts point ids no longer points them at other places.
