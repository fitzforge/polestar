# Changelog

## 0.2.4 (unreleased)

### For players

- The target, quest item and Hearthstone buttons take their keys in the
  options: Questing, Buttons, Key bindings. Click a row, press a key (with
  Alt, Ctrl or Shift if you like, or a side mouse button); right-click
  clears it. These are the same bindings as Key Bindings > AddOns.
- Quests Forever renamed carry their Forever names in the guides: Chastise
  (once A Lack of Fear), Dark Sacrifice (once Devouring Plague), Look to the
  Stars, Onu is Meditating and the others Wowhead Forever lists as renamed.
- The leveling guides follow the refreshed simulator route and take
  Forever's new quests on it. Alliance: Shipment to Stormwind and An Apple
  Treat in Elwynn Forest, Crown of the Earth and the Temple of the Moon in
  Darnassus, Fishin' Time in Stormwind, Expanding Horizons and Making Do
  between Darkshore and Stormwind, a Wetlands loop out of Menethil at 30
  (From the Ashes, Crocs of the Sky, Stopping the Cycle and the rest),
  Hillsbrad's Hoard, Seeking Caitlin, Shared Fury and the Gleaming Crescent
  Necklace in Ashenvale, Carved Centaur Totems in Desolace and My Little
  Friends across Arathi, Desolace and Stranglethorn. Horde: Beren's Peril and
  the Offering Stone in Silverpine, Va'xug Firefure in Stonetalon, Gloomrise
  north of Thunder Bluff, Stop the Screeching at Freewind Post, Traditions of
  the Bluff, The Kolkar of Desolace and Draenethyst Crystals; the Tauren
  start no longer walks to Durotar. Elite quests on the way (Aggor the Young,
  Riptear, Carnage, The Offering of Blood) are optional.
- A Class category in the guide menu, after Leveling, with 65 guides for the
  class quest chains of every class: Druid forms and Cure Poison, Rhok'delar
  and The Hunter's Charm, the Mage robes, orbs and wands, Verigan's Fist and
  the Paladin's Tyr's Watch and Lumina Windsinger chains, the Priest spell
  quests and Benediction, Ravenholdt, Poisons and the Rogue's key and horn
  chains, the Shaman totems and Darkreaver, the Warlock pets (felhunter,
  incubus) and orbs, and the Warrior's armour and weapon chains. The four
  class mounts (Paladin Warhorse and Charger, Warlock Felsteed and
  Dreadsteed) moved there from Collectibles.
- Class quests on the leveling route: every start takes its level 1 class
  letter to the trainer; Night Elf and Tauren Druids learn Cure Poison on
  the way (Darkshore, the Barrens), Mages do Mirror Lake (Alliance) and The
  Balnir Farmstead (Undead), Hunters' taming quests say they teach Tame
  Beast and Beast Training (Orc and Troll Hunters hand Training the Beast in
  before leaving Durotar), Undead Paladins take Coming to Terms, Call of Fire
  names the Totem of Charged Flames it gives Shamans, Rogues may do The
  Touch of Zanzil in Stormwind and Alliance Warlocks the incubus. The
  Warlock felhunter chain left the Horde 30-40 guides for its Class guide,
  and the leveling guides point at the Class guides for the long chains they
  leave out.
- The guide window says when a goal needs a group, under the goal in violet:
  "Elite: group advised" (also rare elite and boss), "Dungeon: Dire Maul",
  "Raid: Molten Core" or the guide's own "Group of 3 advised"; once per card
  when several goals share it. The guide menu tags guides with group content
  on their route "Group" in the list, on the Continue cards and in the
  details.
- The Deathcharger guide's arrow points at Stratholme's Service Entrance
  (41.5,17.7), not at the spot its Era map position falls on Forever's
  redrawn Eastern Plaguelands map.
- Without the Codex, Lookup and Dungeons say which case it is: not installed
  (get the Polestar zip from CurseForge or the GitHub Releases page, not
  GitHub's "Source code" download) or turned off in the AddOns list.

### For guide authors

- `category Class` files a guide under the new Class category (class quest
  chains, mounts and weapons; pair it with a `class` header), listed after
  Leveling in the guide menu with the trainer icon.
- `data build` applies Wowhead Forever's "Renamed from Y" notes too: a quest
  whose title is still Y takes Forever's name (its `source` gains
  `wowhead:title`). It also reads Wowhead Forever's class quest pages, so
  Forever's XP and level changes reach class quests that no zone list shows.
- Goals carry `group` (format 2 of the pack format; Polestar 0.2.4 reads it,
  older versions show such a pack as needing 0.2.4): the compiler derives it
  from elite kills and elite-only drops, from the solo filter's dungeon and
  raid quests and from instance maps, and the new `group [N]` modifier
  (`kill 1234 group 3`) says it outright. A guide with group content on its
  route carries `group = true`. `compile` now writes format 2 for every pack.

### For contributors

- The solo filter's dungeon and raid rule (`instanceQuest` in
  `tools/lib/sim/solo.js`) is shared with the compiler's group content
  (`tools/lib/dsl/group.js`), and `preview` renders the group line
  (`docs/preview/guide-group.svg`).

## 0.2.3 (2026-10-14)

### For players

- Clearing the guide menu's search takes its Codex matches away: they no
  longer stay drawn over the guide list (they did after searching for an
  item or mount, then clearing the search or changing tabs).

## 0.2.2 (2026-10-14)

### For players

- The release now includes the Codex (the `Polestar_Codex` folder, part of
  Polestar), so Lookup, Dungeons and Rares work: search items, mounts, pets,
  recipes, NPCs and quests and see where to get them; every dungeon and raid
  with its levels, entrance, bosses and their loot, and its quests; rares and
  treasures with their spawns and drops. It is built from the game's own data
  tables, the quest and creature databases Polestar already uses, and our
  recordings. If it is missing or disabled, Lookup, Dungeons and Rares say
  so: reinstall Polestar or enable it in the AddOns list, then /reload.
- The Codex knows more: the battleground war mounts and tabards show their
  PvP rank and reputation, the Orange Murloc Egg and Green Helper Box are
  companions, Molten Core and the other raids list their bosses' loot, more
  rares are known, and every dungeon and raid points at its real entrance
  (the Deadmines at Moonbrook), not the spot where a ghost returns.
- Distances can read in metres: Options, Arrow & routes, Distances.
- The starting zones follow Forever's new quest chains: a follow-up is taken
  once the quest before it is handed in, where the guides offered several
  links of a chain at once (Northshire's book chain and Jason Mathers'
  murloc quests in Elwynn Forest, Dun Morogh, Teldrassil, Durotar and
  Mulgore). The Big Picture and what follows it stay optional extras, as
  Shinyfinder Narf is elite.
- Profession quests are optional and say who they are for: Rough Wolf Pelts
  (skinners), A Pain in the Neck (enchanters) and The Quarry's Smith
  (blacksmiths). Other characters could not take or finish them.
- The Skyborne start points at the Ley Line, the Elemental Convergence and
  Raan's campfire again: their ids changed in Forever's data.
- The world map's zone level ranges are rebuilt from Questie 12.1.0's
  Forever creatures (Mulgore reads 3-11, no longer 3-27).
- Reading ahead with Next no longer stops quest automation for the step you
  are on: its quests are still accepted and handed in while the window shows
  a later step.
- The optional Recorder also notes what the Codex learns only in play, while
  it is on: rares you see (on nameplates, as target or mouseover, or on the
  minimap), treasures, what each corpse or chest drops and how often, the
  dungeons you enter and where, and boss encounters, plus the rewards quest
  windows offer. To share a recording, send the `Polestar_Recorder.lua` file
  from your SavedVariables folder (CONTRIBUTING.md says where); it is imported
  without your character's name or realm.

### For guide authors

- `codex build` uses only inputs Polestar may redistribute: the dungeons and
  raids (levels, entrances, bosses) come from the Forever client's tables
  (`Map`, `DungeonEncounter`, `LFGDungeons`, `MapDifficulty`,
  `ContentTuning`), boss loot from the drops in `items.json`, mounts and
  companions from `Mount` and `BattlePetSpecies`, rares from npc ranks.
  `--local-extras` adds AtlasLoot, RareScanner and DungeonJournal for a
  local-only comparison build. `pack` ships the Codex with its
  `LICENSE-DATA.txt` and refuses to run without a release-safe one.
- A release `codex build` measures itself against the last `--local-extras`
  build, entity by entity (`data/local/codex-parity.md`, `codex parity`), and
  lists what only play can fill with the Recorder event that fills it.
- `codex wowhead` fetches, one page at a time, Wowhead Forever's facts for
  what the parity report lists as missing (NPC level, rank, positions and
  drops with counts; object contents; item tooltip requirements) into
  `data/sources/wowhead/codex/`, which a release `codex build` reads. The
  parity report now checks every internal-only fact against Forever (the
  client, Wowhead) and says whether it is a gap of ours, not in Forever, or
  unverified.
- `data build` keeps the droppers of pfQuest's reference loot tables (raid
  and boss loot) at an unknown rate instead of dropping them: Molten Core's
  tier pieces now name their bosses.
- A skill for coding agents, `skills/polestar-guide-pack/`: the workflow from
  `new` to `pack` (look up every id with `find`, then lint and playtest until
  both pass) and the guide format on one page. `new` copies it into the pack's
  `.agents/skills/` and `.claude/skills/`, and the pack's AGENTS.md points to
  it.
- `data build` reads Wowhead's Forever zone quest lists (cached a day in
  `data/sources/wowhead/`) and applies Forever's change notes: "Experience X
  instead of Y", "Level X instead of Y" and "Requires level X instead of Y"
  set X where the data still holds the old value (Scaring Shaky now gives
  3300 XP, not 820). Quests still without XP take Wowhead's. `--no-wowhead`
  skips it; guide pack workflows and Codespaces build with it.
- The Recorder records finds (`rare`, `treasure`, `slain`, `drop`, `enter`,
  `encounter` events; docs/ARCHITECTURE.md, "Recordings") and the quest
  frames' `items`, `choices` and `rewardMoney`. `record import` and `data
  build` turn them into npc ranks, levels, the `rare` role and spawns; drop
  chances from loot windows over kills, merged across sessions, with their
  counts in items' `seen` (10 kills or more replace the existing chance);
  `chest`/`herb`/`mine` objects with their spawns; quest `rewards`; and the
  new `instances.json` (entrances, encounters and their bosses).
- npcs and objects inside dungeons and raids carry `instances` (instance map
  ids), from QuestieDB's areas and the Forever `AreaTable` and `Map` tables
  (`Map` is now read with the Forever tables) plus recordings.

### For contributors

- `record import --anonymize` for a file a player sent in: character names and
  realms are dropped, a short hash keys the character (its sessions still
  group together) and no raw copy is archived.
- `npm test` passes on Windows: AtlasLoot's missing-file warnings and the
  install test's file names use `/` there too (thanks @CDVolvik).

## 0.2.1 (2026-10-14)

### For players

- Quests with several objectives check off the right one: a goal counted the
  objective at its place in the quest's text instead of its place in the quest
  log, so in The Guns of Northwatch "Kill Cannoneer Smythe" showed the 10/10
  medals and Captain Fairmount never ticked. 135 goals in 46 quests of the
  leveling guides now count the objective they name.
- A new character's welcome survives the intro cinematic: the cinematic
  closed it as it started and it never came back. It now waits for the
  cinematic to end, or comes back on the page it was on.
- The welcome is redesigned: three pages under a starlit hero (two for a
  later character), with step dots. It shows the guide window, the arrow and
  every guide at a glance; setup shows each choice's description and the
  colour schemes as cards that apply as you click; the last page shows your
  first guide on its zone painting, the beta note, the Discord invite as a
  link that opens it ready to copy, and what guide packs are.
- The guide menu lists only the guides your character can follow on your own
  faction: an Undead no longer sees the Orc and Troll Durotar and Barrens
  guides there. The other faction's button and All still list every guide.
- Guide packs page: the problem report box grows to fit long problem
  messages.
- Options > Guide packs says plainly what a guide pack is: someone else's
  guides in a separate addon, supported by its author. Its link opens
  docs/GUIDE_PACKS.md, a new page on packs for players and for authors.
- Search ranks an item first as covered by a guide only when a guide Lookup
  would open for it collects it: one of Polestar's own, or one from the pack
  chosen under Suggest guides from.
- Polestar is open source: the code, the guides and the tools that build
  them are on GitHub under the GPL-3.0.
- Report a problem from the game: the bug in the guide window, beside Skip,
  opens a report on the step on screen. Say what went wrong and Polestar
  writes the rest (the step and each goal's state and position, where you
  stand, your race, class and level, the versions and any errors it caught),
  sized to fit one Discord message, for you to copy and paste on the Polestar
  Discord (the game can't open links: "Get the invite" gives the invite once
  if you haven't joined yet). The guide window's menu and `/polestar report`
  open it too.
- The Polestar Discord is one click away: Discord's mark at the foot of the
  hub's and the settings' sidebars, and `/polestar discord`, give its invite
  to copy.

### For guide authors

- A pack reads as a pack in the game's AddOns list: its TOC title is
  "Polestar Pack: <title>", it sits under Polestar's entry next to
  Polestar's own addons, and without `notes` in `pack.json` its line is
  "Guide pack for Polestar by <author>". Polestar's menus show the title
  as written.
- docs/GUIDE_PACKS.md: what a pack is, the steps from `new` to publishing,
  what the tools require and what we ask of authors.
- `playtest` plays a step for a class none of the guide's races can be, and a
  guide with a `class` header, as the first race on the guide's side that can
  be that class: an `only Druid` step in a Horde guide is played as a Tauren.
- `play` and `dev --play` stop the Lua session and exit when it cannot start,
  instead of waiting on it; the page redraws on its own after a rebuild.
- `new` keeps the port of an http origin (`http://host:3000/...`) in the
  pack's workflow and dev container.
- `lint` reports a `|` in a second or later `pro` or `con` at that entry's own
  line, once for each entry that has one.
- `compile` no longer reads `data/forever/dungeons.json`: a quest only
  DungeonJournal knows gives its title and `lvl` in the guide, so nothing from
  DungeonJournal reaches a guide pack.
- `find` and `lint` number a quest's objectives as the game lists them in the
  quest log: creatures, objects, items, kill credits, then exploration, with
  QuestieDB's exceptions. `quest Q.O` in a guide written before 0.2.1 may
  point at another objective: check each against `find <quest>`.

### For contributors

- THIRD_PARTY.md, docs/RELEASING.md and the README say what a release holds
  from each data source: QuestieDB facts in the guides and the quest markers,
  credited; never the Codex or the zone crossings pack.
- Two more independent route searches (the fourth on the data 0.2.0 ships
  with) back the README's numbers and docs/SIMULATION.md; the charts compare
  the guides with those of 0.1.0.
- The README charts display again: an SVG's generated header no longer holds
  `--`, which XML comments forbid, and a test checks every committed SVG for
  it.
- docs/curseforge holds the CurseForge listing: the description to paste,
  the summary, the project settings and what to upload where. `readme
  brand` draws the project avatar and, with `rsvg-convert` installed, writes
  the listing's PNGs (avatar, banner, route charts) beside it.
- `preview` draws a multi-line edit box's text wrapped from the top, and the
  report window and the Discord invite are scenes of their own, held to the
  text-fit audit. THIRD_PARTY.md credits Discord's mark, the one piece of
  art Polestar ships that it did not draw.

## 0.2.0 (2026-10-14)

### For players

- Guide packs: guides written by other players load beside Polestar's own.
  A Guide packs page in Options (`/polestar packs`) shows each pack, turns it
  on or off and reports its problems.
- A centred welcome greets each new character by name, with the guide
  Polestar suggests; its Set up page appears only on the account's first
  character.
- The leveling guides of both factions are reworked: quests that block a solo
  player are dropped or made optional, rare drops are optional, flight paths
  and training come at the right levels, and Forever's own additions, fixed
  points and level tips are in.
- Class quests are in the leveling guides of both factions, at the start and
  level where each class gets them: Shaman totems, Warlock demons, Hunter
  pets and Beast Training, Paladin and Priest spells, Warrior stances, Druid
  forms and Rogue poisons.
- Each training stop in the leveling guides is for the classes whose trainer
  stands there, with stops of their own for Horde Druids (Thunder Bluff),
  Undead Paladins (Brill, the Undercity, Thunder Bluff), Alliance Shamans
  (Ironforge) and Alliance Druids (Stormwind, Darnassus), no Horde gap of more
  than about five levels, and riding at 40 from each race's own riding
  trainer. Alliance guides add training in Ironforge on the way out of Dun
  Morogh, and in Stormwind after Duskwood and on the way to Stranglethorn,
  drop it in Auberdine, which has no class trainer, and take every race to the
  Sentinel Hill flight path.
- Alliance 40-50 grinds less: Keeping Pace on the ride through the Shimmering
  Flats into Tanaris, and The Curse of the Tides, Pearl Diving and Return to
  Corporal Kaleb on one loop through northern Stranglethorn.
- Stranglethorn Vale and Un'Goro Crater, which were split into parts, are now
  one guide per stay in the zone. Inn names are the ones the game reports, so
  binding and hearthing check off; Northwatch Hold's step names its levels;
  and no travel step comes before goals that lead there themselves.
- Collectible, Legacy and reputation guides have clearer notes (warlock mount
  hand-offs, Merchant's Favor camps, Timbermaw and Cenarion Circle standings)
  and mark optional extras as such. Gathering loops in Mulgore and Redridge
  point at the nodes, and an exploration area the game names twice is listed
  once.
- The guide arrow knows every place a target spawns: the map marks the other
  places, fainter ("It also spawns here"), and a click on the arrow, the arrow
  button or a mark moves on to the next one.
- Quest markers cover every place a quest's mobs and objects spawn (before: at
  most 8 areas per mob per map), and a kill no longer redraws them all. Quest
  nameplate icons sit beside the health bar you see, on replacement
  nameplates as well as the game's own.
- Guide window: each tab shows its guide's level range; a narrow tab cuts the
  title, not the range.
- Windows fit their text in any font: a page's subtitle wraps to two lines
  inside the header, no text runs past a window's edge in the game font or in
  Inter, and the hub's search placeholder picks the first of its wordings
  that fits the box.
- Beta wording everywhere, and British spelling in the interface.
- The Recorder's command is `/psrec`, replacing `/lsrec`; `/polestarrec`
  still works.
- The README starts with a quick start for players, a download button and
  screenshots from the game.

### For guide authors

- Guide packs: write your own guides in a pack of your own, with `new` to
  start one from a template, `lint`, `playtest`, `dev` (rebuilds into the game
  on every save), `play` (the real addon in the browser), `compile`,
  `install` and `pack` (the release zip). See docs/PACKS.md.
- Lint checks the places of `sethome`, `hearth`, `fly` and `getfp`, and warns
  on a `goto` whose next goal is within 200 yards; route drafts no longer
  write one.
- `lint`, `compile`, `dev`, `play`, `install` and `pack` stop with one clear
  message when the reference data is missing.
- `dev` reports a deleted `pack.json`, keeps the last good build and builds
  again once it is back.
- `find` lists inns and flight points as guide lines.
- `sim compare` takes the pack folder as its argument, like the other pack
  commands.
- Docs: the guide format on one page (docs/GUIDE_CHEATSHEET.md), and what the
  `fly` check accepts.

### For contributors

- A second, independent route search checks the first; the README's numbers
  and charts show both.
- `version` sets `guides/pack.json` too, so the guides addon's TOC carries
  the release version after compile; docs/RELEASING.md separates private test
  builds from public releases.
- The UI renders in docs/preview show this release's windows and come out
  byte for byte the same from any checkout: textures go through a zlib
  encoder of the preview's own (Node's zlib gives different bytes from one
  Node to the next), quest markers are built in quest ID order (LuaJIT walked
  the quest log in another order and stacked overlapping markers
  differently), the test client's `date()` is UTC, `preview` refuses local
  inputs unless they render outside the repository, and the guide menu scenes
  load frozen copies of six compiled guides, so they change only with the UI,
  never with a guide recompile.
- CI runs `npm test` on pushes and pull requests, and fails when the committed
  textures differ from a fresh `media` build or the committed UI renders
  differ from fresh ones.
- `--help` prints a command's usage and never runs it; test helpers live in
  tests/helpers; one copy of each client helper in Core/Compat; every AddOns
  and WTF folder lookup goes through tools/lib/addons.js
  (`$WOW_FOREVER_ADDONS` first, then the detected clients); `.gitattributes`
  and `.editorconfig`.
- A docs map (docs/README.md), READMEs in the main folders, CONTRIBUTING.md
  and issue forms for wrong steps and bugs.
- The design system is docs/DESIGN.md, which now also says who the windows
  are for and what they must do (formerly PRODUCT.md and docs/UI_BRIEF.md).
- The tools share one copy of each foundation: the repository's folders
  (tools/lib/paths.js), the argument parser (tools/lib/cli.js), the XP rules
  (tools/lib/game/xp.js) and the races and classes with their mask bits
  (tools/lib/game/races.js).
- Fields the addon sets on game frames share one prefix, `ps`, explained in
  addon/README.md.

## 0.1.0 (2026-10-13)

The first public beta. One addon for the whole of WoW: Forever, with 164
guides: 63 leveling guides that take both factions from 1 to 60 from every
race's starting zone (Zephras Isle for the Skyborne included), the twelve
professions from 1 to 300, 17 reputations, 7 exploration guides, the Legacy
challenges and 64 collectible guides, one per mount and per pet. Around them:
a 3D waypoint arrow with a travel planner, quest markers on the map, an
upgrade indicator on item tooltips, a search for where any item, mount or pet
comes from, a dungeon quest journal, rare alerts and quality-of-life helpers.
The leveling routes come from a simulator that plays millions of complete
1-60 routes for each start and keeps the one that reaches 60 soonest under
its model.
