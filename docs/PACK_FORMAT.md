# Community addon format

The contract between a community addon and Polestar, for anyone building
tools of their own. Authors who use Polestar's tools never write any of this
by hand: they write `pack.json` and `.guide` files
([GUIDE_FORMAT.md](GUIDE_FORMAT.md)) and `polestar compile` writes the rest.
The handbook is [PACKS.md](PACKS.md).

> [!TIP]
> Building a tool that generates guides? The simplest path is to write a
> pack (`pack.json` and `.guide` files) and let `polestar lint`,
> `polestar playtest` and `polestar pack` check and build it. Write the
> addon described below yourself only when that is not an option.

**On this page:** [`pack.json`](#packjson) ·
[The addon](#the-addon) · [TOC fields](#toc-fields) ·
[Rules Polestar enforces](#rules-polestar-enforces) ·
[Format 3](#format-3) · [Versioning](#versioning)

A community addon is an addon for World of Warcraft: Forever that depends
on Polestar and registers guides with it. It is built from a pack: a folder
with a `pack.json` and `.guide` files. In the format, every such addon is a
pack; Polestar's own guides are a pack too (`Polestar_Guides`, pack id
`guides`).

## `pack.json`

The pack's manifest, in the root of the pack's folder. Every tool works on
the pack folder given as its one argument (`polestar lint ../joe-routes`) or
with `--pack <dir>`, else on the nearest `pack.json` in the current folder or
a parent.

```json
{
	"id": "joe-routes",
	"title": "Joe's Routes",
	"author": "Joe",
	"version": "1.2.0",
	"license": "CC-BY-4.0",
	"website": "https://github.com/joe/joe-routes",
	"source": "Written from my own play",
	"folder": "PolestarPack_JoesRoutes"
}
```

| Key | Required | Value |
|---|---|---|
| `id` | yes | the pack id: `^[a-z0-9][a-z0-9-]{1,31}$` (2 to 32 lower-case letters, digits and hyphens, starting with a letter or digit), not reserved (below) |
| `title` | yes | shown to players; at most 64 characters |
| `author` | yes | shown to players; at most 64 characters |
| `version` | yes | one word of letters, digits, `.`, `+` and `-`, starting with a letter or digit, at most 32 characters (`1.2.0`) |
| `license` | yes | the licence of the pack's guides, as an SPDX id where one exists (`CC-BY-4.0`, `CC0-1.0`, `MIT`, `GPL-3.0-only`); at most 64 characters |
| `website` | no | `https://` or `http://` address; at most 200 characters |
| `source` | no | where the guides come from, in the author's words; at most 200 characters |
| `notes` | no | one line for the AddOns list, shown when the player points at the pack there; at most 200 characters (default "Community addon for Polestar by <author>") |
| `folder` | no | the addon's folder name: 1 to 64 letters, digits, `_` and `-`, not `Polestar` and not starting with `Polestar_` (in any case); default `PolestarPack_` and the title in CamelCase (`Joe's Routes` → `PolestarPack_JoesRoutes`), or the id when the title has no letters or digits |

Every value is a string on one line. A missing required field, or a value
that breaks these rules, is a lint error; an unknown key is a warning; a `|`
in a displayed value is a warning (it prints literally in game).

The pack folder holds `pack.json`, the `.guide` files in any layout,
`drafts/` (Recorder drafts, compiled only with `--include-drafts`) and `dist/`
(build output). The compiler reads every `.guide` file under the folder
except in `dist/`, `drafts/`, `node_modules/` and folders whose name starts
with a dot.

## The addon

`polestar compile` writes `dist/<folder>/` (ours: `addon/Polestar_Guides/`):

```
PolestarPack_JoesRoutes/
  PolestarPack_JoesRoutes.toc
  Pack.lua           Polestar.RegisterPack({ ... })
  MapFrames.lua      Polestar.RegisterMapFrames({ ... }, "joe-routes")
  Guides.lua         one Polestar.RegisterGuide({ ... }) per guide
  LICENSE-DATA.txt   the reference data sources the guides draw on
  LICENSE.txt        the pack folder's LICENSE, copied as is (only when it has one)
PolestarPack_JoesRoutes_deDE/   one texts addon per language the pack translates
  PolestarPack_JoesRoutes_deDE.toc
  Texts.lua          Polestar.RegisterGuideTexts("deDE", "joe-routes", { ... })
  LICENSE.txt        as above
```

**Texts addons.** A pack whose `locales/<locale>/` folder holds translations
(docs/TRANSLATING.md, "Guide texts") gets, beside its folder, one
load-on-demand addon per language, `<folder>_<locale>`. Polestar loads the
client's own once the pack's files are in, and no other: a German client
never reads the French texts. Its TOC carries `## LoadOnDemand: 1`,
`## Dependencies: Polestar`, `## X-Polestar-Texts: <pack id>` and
`## X-Polestar-Locale: <locale>` with the generated-folder marker, and
`Texts.lua` makes one call:

```lua
Polestar.RegisterGuideTexts("deDE", "joe-routes", {
	pack = { ["Joe's Routes"] = "Joes Routen" },   -- the pack's title and notes, its guides' folders
	guides = { ["joe-routes/elwynn"] = { ["{npc:240} stands outside the inn."] = "{npc:240} steht vor dem Gasthaus." } },
})
```

Each table maps a text's English, name tokens and all, to its translation;
a text without one shows in English. `compile`, `install` and `dev` write
and replace a texts addon folder by the same rule as the pack folder (its
marker and `X-Polestar-Texts`), and remove the one of a language the pack no
longer translates; `pack` puts each into the zip as a folder of its own.

The file set is fixed: a new guide changes `Guides.lua`, never the file list,
so `/reload` shows every change and only a pack's first install needs a
restart of the game (`LICENSE.txt` is a text file the game never loads); so
does the first texts addon of a language, below.
Each guide's table is built inside its own function in `Guides.lua`, so Lua
5.1's constant limit applies per guide.

### TOC fields

```
## Interface: 16001
## Title: Polestar Community: Joe's Routes
## Notes: Community addon for Polestar by Joe
## Author: Joe
## Version: 1.2.0
## Category: Quests
## Group: Polestar
## Dependencies: Polestar
## X-Polestar-Pack: joe-routes
## X-Polestar-Format: 3
## X-Polestar-Needs: 0.2.5
## X-License: CC-BY-4.0
## X-Website: https://github.com/joe/joe-routes
# Generated by `node tools/polestar.js compile` from pack.json and the .guide files. Do not edit: rebuild with that command.

Pack.lua
MapFrames.lua
Guides.lua
```

| Field | Value |
|---|---|
| `Interface` | copied from `addon/Polestar/Polestar.toc` at build time |
| `Title` | "Polestar Community: " and `pack.json` `title` (the title alone when it already starts so), so the AddOns list reads the addon as a community addon. Community addons built before this prefix carry "Polestar Pack: " until rebuilt; Polestar recognises both. Polestar's own menus show the title without it. Polestar's own pack (`guides`) gets no prefix |
| `Author`, `Version` | from `pack.json` |
| `Notes` | `pack.json` `notes`, else "Community addon for Polestar by <author>" |
| `Category` | `Quests`, Polestar's category in the AddOns list |
| `Group` | `Polestar`: the AddOns list shows the pack under Polestar's own entry, beside Polestar's own addons. Not written for Polestar's own pack |
| `Dependencies` | `Polestar`: the client loads Polestar first |
| `X-Polestar-Pack` | the pack id. Polestar lists every addon carrying it on the Community guides page, loaded or not |
| `X-Polestar-Format` | the pack format (below) |
| `X-Polestar-Needs` | the first Polestar version that reads that format, so an older Polestar can say which version the pack needs |
| `X-License` | `pack.json` `license` |
| `X-Website` | `pack.json` `website`, only when given |

The comment line is the **generated-folder marker**, and with
`X-Polestar-Pack` it makes the folder rule: `compile` (its output folder),
`install` (`dist/<folder>/` and the folder in AddOns, where a symlink is
replaced without the check) and `dev` (the folder
in AddOns) write a pack folder only when it is absent, empty, or carrying
the generated marker and no other pack's id. Anything else is refused: a
folder without the marker as "not a generated community addon", one generated
for another pack as holding that pack, with the hint to set `folder` in
`pack.json`. `pack` builds a community addon's zip in memory, and `play` writes
into a new temporary folder, so neither touches an existing pack folder.

## Rules Polestar enforces

`Core/Guides.lua` applies these at registration; lint reports the same ones
before a pack is built (`tests/packs-parity.test.js` holds the two together).

1. **Ids.** Pack ids match `^[a-z0-9][a-z0-9-]{1,31}$`; `guides`, `forever`,
   `lookup`, `draft` and `polestar` are reserved. Every guide id starts with
   `<pack id>/`, except in Polestar's own packs: `guides` (the addon
   `Polestar_Guides`) owns `forever/` and `draft/`, and Polestar's internal
   `lookup` pack owns `lookup/`.
2. **No overrides.** A guide id outside its pack's prefix is refused. A pack
   may register one of its own ids again, which replaces that guide.
3. **Clashes.** A pack whose id is already registered is refused whole, and
   the problem names both addons; a pack with a reserved id is refused whole
   with "Pack id <id> is reserved for Polestar.". Either way the guides and
   map frames its files register for that id while it loads are dropped,
   never given to the holder, and the dropped guides are counted in the
   problem. A pack with a malformed id, no `format` or a required field
   missing is refused too ("Pack id <id> is not valid: …", "The pack is
   missing <field>."), and its guides are dropped without a problem each.
   A guide registered before its pack is refused (listed once the pack
   registers); one for a pack that never registers is ignored, since there
   is no row to list it on.
4. **Map frames.** A pack may add Era map frames for maps Polestar's lack; for
   a map both cover, Polestar's win whatever the load order (lint warns when
   the bounds differ). Frames for a pack that is not registered, or was
   refused, are dropped.
5. **Format.** A pack declaring a format Polestar does not read is refused
   whole, with the status `too-new` and "Needs Polestar <X-Polestar-Needs> or
   newer." ("Needs a newer Polestar." when its TOC has no
   `X-Polestar-Needs`). An unknown verb or a malformed field inside a known
   format refuses only that guide.
6. **Visible problems.** Every refusal is recorded against its pack with a
   kind: `pack-refused` (the pack), `guide-refused` (one guide, with its id),
   `no-guides` (the addon loaded but registered no guides, usually a Lua error
   in its files). The Community guides page shows them.
7. **Text prints literally.** Every string a pack registers is escaped once,
   at registration (`|` doubled), so colour and link codes do not work. A
   guide's ids (`id`, `pack`, `next`, `nextChoices`) are left as written.
8. **Missing guides keep their place.** Saved tabs of a guide whose pack is
   missing or switched off reopen in their old place when it comes back.
9. **Packs on disk.** At login Polestar lists every addon whose TOC carries
   `X-Polestar-Pack`, loaded or not, with a status. A registered pack is
   `on`, `off` (switched off on the Community guides page), `refused`, `too-new`
   (a newer format) or `broken` (registered no guides). One that never
   registered is, in this order of precedence, `too-new`, `disabled` (turned
   off in the AddOns list), `not-loaded` (the client did not load it: out of
   date, a dependency missing) or `broken`.

Only guides of packs that are on are shown, searched and suggested.
Suggestions come from Polestar's guides unless the player picks a pack under
**Suggest guides from** on the Community guides page; only packs with Leveling
guides are offered there, and Polestar's guides fill in where the chosen pack
has nothing for the character.

## Format 3

The format the compiler writes. Format 2 is format 1 with the two `group`
keys (a guide's and a goal's) and a guide's `reward` and `why`, marked
"format 2" below; Polestar 0.2.4 and later read it. Format 3 is format 2
with **name tokens** in the texts and a guide's `names`, marked "format 3"
below; Polestar 0.2.5 and later read it. A format 1 or 2 pack is the same
without them and keeps loading.

**Name tokens** (format 3). The game's names inside the texts a player reads
(a guide's `title`, `why`, `pitch`, `pros`, `cons` and reward `text`; a
step's `title` and `note`; a goal's `note` and `text`) are written
`{kind:id}`: `{npc:240}`, `{object:68}`, `{item:1528}`, `{quest:176}`,
`{zone:1429}` (a uiMapID), `{area:87}` (an AreaTable ID), `{spell:5487}`,
`{faction:72}`, `{skill:182}` (a profession's skill line). Polestar shows
each as the game names it in the client's language (Polestar.Names, the
client's map and area names, the profession's translation), else as the
guide's `names` give it, so an English client reads the text as its author
wrote it (a text that spells a name otherwise, "Dendrite" for Dendrite
Starblaze, is in the guide's `written` with the author's words). The
compiler writes the tokens (GUIDE_FORMAT.md, "Names in
texts"); an older Polestar would show them as written, hence the format.

### `RegisterPack(meta)`

```lua
local ADDON = ...
Polestar.RegisterPack({
	addon = ADDON, id = "joe-routes", format = 3,
	title = "Joe's Routes", author = "Joe", version = "1.2.0", license = "CC-BY-4.0",
	website = "https://github.com/joe/joe-routes", source = "Written from my own play",
})
```

| Field | Required | Value |
|---|---|---|
| `addon` | yes | the addon's folder name (the file's first vararg) |
| `id` | yes | the pack id (rule 1) |
| `format` | yes | `3` (`1` or `2` for a pack of that format) |
| `title`, `author`, `version`, `license` | yes | non-empty strings |
| `website`, `source`, `notes` | no | strings |

Returns `ok, err`. Call it once, in the first file the TOC loads, before any
guide.

### `RegisterGuide(def)`

One table per guide; returns `ok, err`.

```lua
Polestar.RegisterGuide({
	id = "joe-routes/elwynn", pack = "joe-routes",
	title = "Elwynn Forest", faction = "Alliance", minLevel = 5, maxLevel = 10,
	category = "Leveling", zone = 1429, zoneName = "Elwynn Forest",
	next = "forever/alliance/02-westfall", author = "Joe", version = 1,
	steps = {
		{ title = "Goldshire", goals = {
			{ t = "accept", quest = 62, title = "The Fargodeep Mine", npc = 240, npcName = "Marshal Dughan", minLevel = 4, qlvl = 7, map = 1429, x = 42.11, y = 65.93, f = "e" },
		} },
	},
})
```

Guide keys (the compiler writes them in this order):

| Key | Required | Value |
|---|---|---|
| `id` | yes | the guide id, under the pack's prefix |
| `pack` | yes | the registered pack id |
| `title` | yes | string |
| `faction` | no | `"Alliance"` or `"Horde"`; absent: either |
| `races` | no | list of race file names (`"Human"`, `"Scourge"`, `"NightElf"`, …); absent: any |
| `classes` | no | list of class file names (`"WARRIOR"`, …); absent: any |
| `minLevel`, `maxLevel` | no | numbers |
| `category` | no | `"Leveling"` (default), `"Class"`, `"Professions"`, `"Reputation"`, `"Legacy"`, `"Exploration"`, `"Collectibles"`, `"Dungeons"`; the compiler passes another name through with a warning |
| `folder` | no | the guide menu folder |
| `keywords` | no | list of extra search words |
| `collects` | no | list of item ids the guide obtains |
| `reward` | no | format 2: what the guide's goal gives, shown first in the guide menu's details, in order: `{ item = 20536, itemName = "Soul Harvester", quality = 3, choice = true }` (an item; `choice` when one of several to choose from; the name shows in the client's quality colour when the item is cached, else the compiled `quality`'s), `{ spell = 23161, spellName = "Summon Dreadsteed" }` or `{ text = "Shen'dralar reputation" }`; an entry with none of `item`, `spell` or `text` refuses the guide |
| `why` | no | format 2: one line on why the goal is worth doing, shown under the reward |
| `zone`, `zoneName` | no | the default zone's uiMapID and name |
| `next` | no | the id of the guide that follows: one of the pack's or one of Polestar's |
| `nextChoices` | no | list of guide ids offered as a route choice (the first is the default) |
| `pitch` | no | one line for the route choice card |
| `pros`, `cons` | no | lists of short lines under the pitch |
| `author` | no | string; the compiler writes the pack's author when the guide names none |
| `version` | no | number |
| `everyStep` | no | `true` (`skip none`): a leveling guide whose every step is done; Polestar never leaves out its grey quests nor catches up past its steps |
| `group` | no | `true` (format 2): a goal of the guide's route that is not `optional` needs a group; the guide menu shows a "Group" chip |
| `names` | no | format 3: `{ ["npc:240"] = "Marshal Dughan", ... }`, the English of every name token the guide's texts hold (a token it lacks is shown as written) |
| `written` | no | format 3: `{ ["Back to {npc:3649}"] = "Back to Dendrite", ... }`, a text whose names its tokens' English in `names` would spell otherwise, with the author's words an English client reads |
| `steps` | yes | list of steps, at least one |

Step keys: `title` (optional), `note` (optional, player-facing), `only`
(optional: `{ classes = { ... }, races = { ... }, factions = { ... } }`, AND
across keys, OR within; Polestar also reads an entry `"!X"` as "not X", but
the compiler writes positive lists only) and `goals` (at least one).

Goal keys common to every verb: `t` (the verb), `text` (display text),
`note`, `optional` (`true`: never blocks the step), `only` (as on a step),
`map`, `x`, `y` (0 to 100, together), `z` (optional, with them: the height
of the NPC or object the point stands for, below), `f` (`"e"`: the Era map
frame; absent: the live frame), `r` (arrival radius in yards), `spots`
(every place the goal's target spawns, below; with `map`), `group` (format
2: the goal needs a group, below).

| Verb `t` | Required | Optional |
|---|---|---|
| `accept` | `quest`, `title` | `npc`/`npcName`, `object`/`objName`, `item`/`itemName`, `minLevel`, `qlvl`, `pre`, `preAll`, `closedBy`, `preTitles` |
| `turnin` | `quest`, `title` | `npc`/`npcName`, `object`/`objName`, `rewards = { choices = { { item, itemName, quality } }, items = { ... }, xp, money }`, `direct` |
| `complete` | `quest`, `title` | — |
| `kill` | `target` | `title`, `npc`, `count`, `quest`, `oi`, `spread` |
| `collect` | `item`, `itemName` | `title`, `count`, `quest`, `oi`, `spread`, `from`, `fromAlso`, `fromId`, `fromAlsoId`, `fromKind`, `fromRank`, `fromFaction`, `candidates` |
| `goto` | `map`, `x`, `y` | `text`, `r`, `area` |
| `talk` | `npc`, `npcName` | — |
| `interact` | `object`, `objName` | `title`, `quest`, `oi`, `spread` |
| `use` | `item`, `itemName` | `title`, `quest`, `oi` |
| `sethome` | `location`, or `candidates` | `npc`, `npcName`, `area` |
| `hearth` | `location` | `area` |
| `getfp` | `location` | `npc`, `npcName`, `node`, `area` |
| `fly` | `location` | `area` |
| `train` | — | `npc`, `npcName`, `class`, `skill`, `skillLine`, `rank`, `rankMax`, `candidates` |
| `buy` | `item`, `itemName` | `count`, `npc`, `npcName`, `candidates` |
| `vendor` | — | `npc`, `npcName`, `candidates` |
| `level` | `level` | — |
| `note` | `text` | — |
| `skill` | `skill`, `level` | `skillLine` |
| `learn` | `spell`, `spellName` | `skillLine`, `npc`/`npcName`, `item`/`itemName`, `candidates` |
| `craft` | `spell`, `spellName` | `item`/`itemName`, `count`, `untilSkill`, `skillLine`, `reagents = { { item, itemName, count } }` |
| `rep` | `faction`, `factionName`, `standing` (1 to 8) | — |
| `explore` | `map`, `x`, `y` | `text` |
| `achieve` | `achievement`, `achievementName` | `criteria` |

The fields:

| Field | Value |
|---|---|
| `quest`, `npc`, `object`, `item`, `spell`, `faction`, `achievement` | numeric ids |
| `title`, `npcName`, `objName`, `itemName`, `spellName`, `factionName`, `achievementName`, `target` | names |
| `count` | number to collect, kill or buy; on `craft`, the number of items to make |
| `oi` | 1-based quest objective index (`C_QuestLog.GetQuestObjectives`) |
| `minLevel` | the level an `accept` needs; `qlvl` the quest's level (number or string) |
| `pre` | prerequisite quest ids, any one suffices; `preAll` every one needed |
| `closedBy` | quest ids that close this one once taken or done |
| `preTitles` | `{ [questId] = title }` for the quests those name |
| `profLine`, `profName`, `profRank` | on any goal of a quest only characters with a profession can take: its skill line id, name and the rank it needs; the goal is hidden from characters without it |
| `location` | an inn, flight point or zone name as the game shows it |
| `class` | `true` on `train`: the nearest trainer of the player's class |
| `skill` | a profession name; `skillLine` its skill line id |
| `rank`, `rankMax` | on `train`: the profession rank (1 Apprentice to 4 Artisan; Polestar also reads a rank name or a skill cap) and its skill cap (written by the compiler, not read by Polestar) |
| `level` | on `level`: the level to reach; on `skill`: the skill to reach |
| `untilSkill` | on `craft`: craft until the profession reaches this skill |
| `reagents` | `{ { item, itemName, count } }` |
| `standing` | 1 Hated to 8 Exalted |
| `criteria` | an achievement's criterion index |
| `z` | the height (world z, yards) of the NPC or object the goal's `x`,`y` stands for, so the walking route ends on its floor (an Undercity quarter rather than the street above it). Polestar 0.2.4 and later pass it to the walking engine while the arrow leads to that point, and ask again without it when the route found with it fails or ends more than 30 yards above or below it. A spot (`spots`) and a smart target's candidate (`candidates`) may carry their own `z`, which Polestar 0.2.5 and later pass the same way when the arrow leads there (#180). The compiler fills it in (GUIDE_FORMAT.md, "Heights"); a hand-written pack may leave it out. Older Polestar ignores it, so it does not change the format |
| `area` | the AreaTable area ID (`C_Map.GetAreaInfo`) of the place a `sethome`, `hearth`, `fly` or `getfp` location or a `goto` label names. Polestar 0.2.5 and later complete a `hearth` or `fly` when the zone or subzone text is that area's name in the client's language, accept a `sethome` bind location that reads so, count a `goto` arrived when the player goes indoors in that subzone (a cave or mine past its mouth; never for a zone), and show that name in place of the English one. The compiler fills it in (GUIDE_FORMAT.md, "Places by ID"); without it the goal matches by its English name. Older Polestar ignores it, so it does not change the format |
| `node` | on `getfp`: the taxi node ID (`C_TaxiMap` `nodeID`) of its flight point. Polestar 0.2.5 and later count the goal done once the flight map lists that node as known, instead of comparing names. Filled in like `area`; older Polestar ignores it |
| `spots` | spawn places `{ { x, y, z, r, n, alt } }`: centre in the goal's map and frame, its height (optional, see `z`), radius in yards, spawn count; `alt = true` for another place the target spawns, which the arrow takes only when the player moves on to it (the world map marks it) |
| `spread` | `true` with `spots`: an area objective, searched spot by spot |
| `from`, `fromAlso`, `fromKind`, `fromRank`, `fromFaction` | a `collect`'s main source: name, a second source of the same kind dropping it at 50% or more, `"npc"` or `"object"`, rank (1 elite, 2 rare elite, 3 boss, 4 rare), faction `"A"`, `"H"` or `"AH"` |
| `fromId`, `fromAlsoId` | the ids of `from` and `fromAlso` (of kind `fromKind`): Polestar names them in the client's language (`Polestar.Names`), keeping `from`/`fromAlso` where it has no name; older Polestar ignores them |
| `candidates` | smart targets: `{ { npc, npcName, map, x, y, z, f, faction, races, classes, lvl, rate, spawns } }` (`z` optional, see `z`); Polestar picks the nearest usable one at runtime |
| `rewards` | `{ choices = { { item, itemName, quality } }, items = { ... }, xp, money }` (money in copper) |
| `direct` | `true` on a `turnin`: the quest is handed in straight from the giver's window and never enters the quest log, so the goal needs no `accept` before it and carries no objectives. Polestar counts it done on the hand-in itself and stores that, so a repeatable stays done after a reload |
| `group` | format 2: the goal needs a group, shown under it in the guide window: `{ kind = "elite", rank = 1 }` (rank 1 elite, 2 rare elite, 3 boss: "Elite: group advised"), `{ kind = "dungeon", name = "Dire Maul" }` ("Dungeon: Dire Maul"), `{ kind = "raid", name = "Molten Core" }` ("Raid: Molten Core"), `{ kind = "group", size = 3 }` ("Group of 3 advised"; without `size`, "Group advised"). The compiler derives it or takes the author's `group [N]` (GUIDE_FORMAT.md, "Group content"); Polestar shows nothing for a kind it does not know |

Polestar 0.1.0 reads every verb above; 0.2.4 and later read the `group`
keys; 0.2.4 and later read `z`; 0.2.5 and later read `area`, `node` and
`direct`. ARCHITECTURE.md ("Guide data") describes when the Engine counts each
goal done.

### `RegisterMapFrames(frames, packId)`

```lua
Polestar.RegisterMapFrames({
	era = {
		[1429] = { c = 0, left = 1535.417, right = -1935.417, top = -7939.583, bottom = -10254.166 },
	},
}, "joe-routes")
```

The Era world bounds of every map the pack's guides place a goal or a
candidate on, where the reference data has them: `c` the continent,
`left`/`right` world Y, `top`/`bottom` world X. For a map Polestar already
covers, Polestar's bounds win (rule 4). Call it after `RegisterPack`: the
frames of a pack that is not registered are dropped.

## Versioning

- The format number changes when a verb, a field or a field's meaning is
  added or changed. Polestar ignores keys it does not know; an unknown verb
  refuses the guide.
- Polestar keeps reading every format it has shipped, so a published pack
  keeps working when Polestar updates.
- The compiler writes the first Polestar version that reads the pack's format
  into the TOC as `X-Polestar-Needs`. Format 1 is read by Polestar 0.1.0 and
  later, format 2 (the `group`, `reward` and `why` keys) by 0.2.4 and later.
- A pack in a format this Polestar does not read registers nothing; the
  Community guides page shows it as `too-new` with "Needs Polestar <version> or
  newer." (rule 5).
