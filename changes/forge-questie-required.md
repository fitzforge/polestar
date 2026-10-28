---
section: forge
---
- `forge build` finds QuestieDB in any client's AddOns folder that has its
  Forever store: the live client first, then a leftover beta folder (also one
  without its flavor file) or a test server install. It stops when there is
  none, unless you pass `--no-questie`: building without it quietly left out
  about a sixth of the quests. The data stage also stops when a build has over
  5% fewer quests than the previous one, naming what is missing by source
  (`--accept-fewer-quests` takes it).
