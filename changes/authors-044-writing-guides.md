---
section: authors
---
- Writing guides for 0.4.4, in one place: docs/GUIDE_PACKS.md, "Writing
  guides for Polestar 0.4.4" and "Moving a pack to 0.4.4", with a whole
  profession guide and a dungeon guide in GUIDE_FORMAT.md's Cookbook.
- Leveling guides: a step of only `goto`s, a `fly` or an `enter` is now a
  hidden hint for the step after it. The arrow goes by it only while it is
  on the way, and a player who is past it or has a faster way goes straight
  to the work. A run of them at the end of a guide stays visible. To keep
  one a step, add `keep <kind> <reason>` (`door`, `instance`, `boarding`,
  `phasing` or `safety`). Check your leveling guides for steps that must
  stay; nothing else needs changing, and an older Polestar shows them as
  written.
- Actions are rows, tips say why: `use <item> quest N.M` for an item an
  objective needs (the quest item button shows it), `use <item> anywhere`
  for one used where you stand, and the same rows with `optional` for an
  action only some players take. Lint now stops Polestar's own guides on a
  tip that orders an action no row of its step does; `# tip-ok: <why>` on
  the line above marks a tip that is right as written. Community packs
  aren't checked, but the same rule makes them easier to follow.
- Profession guides (`category Professions`) show the skill instead of XP
  and read best one action a step: Learn, Buy the tool, Get N (a `collect …
  gather` and an `auction` together, which the player picks between), Go to
  the station (`goto … nearest`, which needs Polestar 0.4.4), Craft until N,
  Train. Dungeon guides (`category Dungeons`, titled as the Dungeons page
  names the dungeon) show the dungeon itself; end the way there with `enter`
  at its entrance.
- Gone, so drop any README or tip text that mentions them: the "How do you
  want to get them?" materials card, the Materials window (`/polestar
  materials`) and the Gather, Buy and Mix choice. No guide line named them,
  and `collect … gather` with `auction` keeps working: players pick on each
  Get step.
