---
section: contributors
---
- `sim compare` and `sim bench` take `--class`, so a chain written for one
  class can be measured: they passed `cls: null` whatever was given, and a
  quest open to fewer than five classes is left out without one, so a Priest
  or Mage chain scored as if its own quests were not there. With a class the
  chain's `only <Class>` goals and the class's quests count, its kill-speed
  prior applies, the best-found row comes from that class's `sim run` result,
  and the files are `compare-<faction>-<race>-<class>[-<pack id>].json` and
  `bench-<faction>-<race>-<class>.*`, so the class-agnostic ones are left
  alone. A name that is not a class is refused instead of silently dropping
  every class quest (thanks XrayAlpha).
