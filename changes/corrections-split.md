---
section: contributors
---
- data/corrections.json keeps the fixes an independent source backs,
  each naming it in `source` (an in-game check or issue, a recording, the
  client, EG Link, CMaNGOS, the Forever TrinityCore DB, QuestieDB, pfQuest or
  Factoruide); the others move to a private overlay,
  data/local/corrections-private.json, which `data build` merges over it when
  present (`--corrections-private <file>`, `--no-corrections-private`).
