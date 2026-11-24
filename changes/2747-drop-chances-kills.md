---
section: contributors
---
- Recorded drop chances of quest items count the kills a player could loot
  while the item was wanted, not the loot windows they opened, which read the
  chance 1.2 to 3 times high. The kills and drops go in time order (a kill is
  recorded 3 s after the death), a scalp whose loot window an older Recorder
  missed still counts by its objective tick, and every player's drops and
  kills are pooled, since players stop at the objective's count and those
  with many kills are the unlucky ones (Grizzled Scalp read 9.09%; it is
  38.97%). The data build uses them again for quest drops, and Lookup's and
  the tooltips' chances read the same. (#2747)
