# Golden: forge sim calibrate

- Inputs (synthetic, our own): `sim/world-{horde,alliance}.json` (40 quests each: id, title,
  level, xp, tier; the QuestXP table rows of the game's data), `journal/Data/QuestRewards.lua`
  (a made-up `FOREVER_QUEST_XP_FALLBACK` table in the dungeon journal's layout),
  `recordings/*.json` (made-up kill events).
- Expected: `params.expected.json`, written by the JavaScript calibrate (tools/lib/sim/calibrate.js
  at rust-core 651ee7536, its `questXpFits`, `recordingFits` and `ratioFit`, assembled as
  `saveParamsFile` writes it, `fit.at` pinned) with `regen.js`:
  `node regen.js <checkout with tools/> <this folder> <this folder>/journal > params.expected.json`,
  then the journal path replaced by `<golden>/`.
- One deliberate difference from the JS: `fit.sources.questXp.forever.file` is the journal's folder
  name and the file in it (`journal/Data/QuestRewards.lua` here), not an absolute install path; the
  expected file has that form.
