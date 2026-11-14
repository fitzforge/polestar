# Dungeons in the route: held back for 0.4.1

The changelog fragments here are for dungeons woven into the leveling routes
(`when dungeon` steps, "Dungeons in my route", the Install question, the
guide window's dungeon notices, Discovery's answer per dungeon). The feature
is built but held back: `ns.dungeonRoute` in addon/Polestar/Core/Init.lua is
`false`, so every dungeon reads as skipped and nothing offers the choice.
`forge changelog` skips this folder (a hidden name), so these entries are in
no release notes until they move back up.

To ship it:

1. Set `ns.dungeonRoute = true` in addon/Polestar/Core/Init.lua.
2. Move these fragments back: `git mv changes/.0.4.1/*.md changes/` (not
   this README), and check them against what ships.
3. Put the Install page back in the texts that name it: "Groups (group
   quests)" becomes "Groups and dungeons (dungeons in your route, group
   quests)" in README.md's Install paragraph (and in changes/install-flow.md
   if it has not shipped yet).
4. Take out the "held back" notes: docs/GUIDE_FORMAT.md ("Dungeon steps"),
   docs/GUIDE_CHEATSHEET.md (`when dungeon`), docs/ARCHITECTURE.md,
   docs/DESIGN.md (Install's Groups page) and
   skills/polestar-guide-pack/SKILL.md.
5. "Dungeons in my route" in Polestar_Options/UI/Options.lua: its `new` tag
   becomes the release that ships it; settings-controls.json already lists
   it under 0.4.1.
6. The tests that turn the switch on (`Polestar.dungeonRoute = true`) can
   drop that line; the `held_back_*` tests go (dungeon-route-held.rs,
   engine-dungeon-route.rs, engine-when-dungeon.rs, ui-options.rs, ui.rs,
   ui-welcome.rs), and tests/acceptance-packs.test.js names the page
   "Groups and dungeons" again.
