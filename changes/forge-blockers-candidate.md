---
section: forge
---
- The level fit leaves a quest's accept where it is when other work of the
  quest stays before the work it moves to a later visit (Duskwood's Totem of
  Infliction: the fingers and venom on the first visit, the ghoul fangs on
  the second, no longer collected for a quest not yet taken).
- The seed's elite drops are optional with a grouping tip, as the pack check
  asks now that the data marks the mobs elite (players' recordings show
  Broodmother Valraxx and Modr as elites): Valraxx's Bloody Parchment (A
  Darker Truth) and the Goaz watchers' quests in the Wetlands.
- The legs stage walks on the grid through the build's own data/local/nav4,
  as the walks stage does, so a `--grid` outside the checkout bakes on the
  walk graphs the prepare stage built instead of failing with "no walk
  graph".
- After each stage the build hands the memory it freed back to the system,
  so a round's second walks pass no longer stacks on the routes stage's
  leftovers.
