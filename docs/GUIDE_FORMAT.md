# Polestar guide format (v1)

Every line of the format on one page, with an example each:
[GUIDE_CHEATSHEET.md](GUIDE_CHEATSHEET.md). This page has the full rules.

Guides are written as `.guide` text files in a guide pack (Polestar's own:
`guides/`; a community pack: any folder holding a `pack.json`, see
[PACKS.md](PACKS.md)) and compiled to Lua by `node tools/polestar.js compile`.
The compiler fills in names, titles and coordinates from the reference data in
`data/forever/`, so a line can be as short as `accept 783`. Anything you write
explicitly wins over the data. Without the reference data the compiler stops
with one error, unless `--no-data` says to compile guides that give every
title, name and place themselves. Worked examples of every goal are in the
Cookbook at the end of this page.

```
guide joe-routes/northshire
title Northshire Valley
faction Alliance
race Human
levels 1-6
zone Elwynn Forest
next joe-routes/elwynn

step Deputy Willem
  accept 783                          -- He stands at the abbey gate
  turnin 783
  accept 7
  accept 33
  accept 5261 npc 196

step Kobold camp
  tip Pull one kobold at a time until level 3.
  kill 6 x10 quest 7.1
  collect 750 x8 quest 33.1 optional

step Back to the abbey
  turnin 7
  train only Warrior,Paladin          -- Llane Beshere is inside the abbey
  level 4
```

## Lexical rules

- UTF-8, one guide per file. Blank lines are ignored.
- `#` starts an author comment (dropped) when it is the first non-blank
  character of a line or follows whitespace outside a quoted string.
- ` -- ` (space, two dashes, space) starts a **player-facing note** for the
  goal on that line; the rest of the line is the note.
- Header lines and `step` lines start in column 0. Lines inside a step are
  indented (any spaces or tabs).
- Tokens are whitespace-separated. `"double quoted"` is one token, with `\"`
  and `\\` escapes. Keywords are case-insensitive; IDs are integers.

## Header

Every line before the first `step`.

| Key | Required | Value |
|---|---|---|
| `guide` | yes, first line | id: `[a-z0-9_-]+` parts joined by single `/` (none leading or trailing), unique across all guides; it starts with the pack's id and `/` (`joe-routes/elwynn`; Polestar's own guides: `forever/`) |
| `title` | yes | rest of line |
| `levels` | yes | `<min>-<max>` |
| `zone` | yes | default zone: map name from `data/forever/zones.json`, or `map <uiMapID>` |
| `faction` | no | `Alliance` or `Horde` |
| `race` | no | comma list (see Conditions) |
| `class` | no | comma list |
| `next` | no | id of the guide that follows, or several ids separated by commas: a **route choice**. The player picks where to level next in the "Choose your path" window; the first id is the author's default. Every option must be the guide's own faction. |
| `category` | no | default `Leveling`; others: `Class` (class quest chains, mounts and weapons; pair with a `class` header), `Professions`, `Reputation`, `Legacy`, `Exploration`, `Collectibles`, `Dungeons` |
| `folder` | no | the guide menu folder this guide is listed under, any category (e.g. `Mounts · Level 40`, `Companion pets · Vendors`). Guides sharing a folder sort by faction (yours first), then level. Without it: the category's folder (Leveling: by faction and level band). |
| `keywords` | no | comma list of extra words the guide menu search matches (e.g. the colours a mount guide covers); an empty entry is an error, a repeated one a warning |
| `collects` | no | comma list of item ids this guide obtains (a mount guide: every colour it sells). Compiled as `collects = { ... }`; the Lookup module opens this guide for those items instead of building one. Malformed or repeated ids are errors; an id missing from `items.json` is a warning. |
| `reward` | no (a warning on a `Class` guide without it) | what the guide's goal gives, shown first in the guide menu's details with its icon and the game's tooltip. Repeatable, one entry per line: `reward item <item> ["Name"] [quality] ...` (entries as in `choose`; several on one line are a choice of one), `reward spell <spellId> "Spell name"` (a mount, a form, a demon, an ability; the name is required; the id is the spell the player ends up with, as the Forever client's `SpellName` table has it: `reward spell 691 "Summon Felhunter"`, not the quest's "Teach" spell) or `reward text <words>` (anything without an id: reputation, experience). A spell written as `reward text` shows a glyph instead of its icon and no tooltip, and tests/guides-class.test.js fails on one for the guide's class. The details list the entries given outright under "Reward", then the choices under "Choose one", each group in header order. An item's name defaults to `items.json`; an id missing there needs its name. Compiled as `reward = { { item, itemName, quality, choice }, { spell, spellName }, { text } }`. |
| `why` | no (a warning on a `Class` guide without it) | one short line in the guide menu's details: why the goal is worth doing, in the author's words |
| `author` | no | default: the pack's author (`pack.json`) |
| `version` | no | integer, default `1` |
| `coords` | no | `era` (default) or `live`: the map frame of coordinates typed in this guide (`@x,y`, `goto`, `explore`). Era-frame ones compile with `f = "e"`; on a map without Era bounds they compile live. `record draft` writes `coords live`. |
| `pitch` | no | one line selling the zone, shown on its card in the route choice window (required, as a warning, when the guide is a route option) |
| `pro` / `con` | no | repeatable: one advantage / disadvantage per line, shown under the pitch. Keep them short, factual and true for every race that can choose the route. |

A route choice, as excerpts of two guides' headers (a pack's Tirisfal guide
offering our Barrens or its own Silverpine):

```
# guides/tirisfal.guide
next forever/horde/02-the-barrens, joe-routes/silverpine

# guides/silverpine.guide
pitch Undercity's backyard: a compact forest with the Forsaken's own story and short walks between quests.
pro Ends in the Undercity, where the next guide starts: no zeppelin ride
con Hunters, Shamans and Druids have no trainer here: they train next in Orgrimmar at about 22
```

Characters arrive at a route option from any of its predecessors, so its
turn-ins of earlier quests must not assume one starting zone; the engine skips
a turn-in or objective for a quest the character never had (see ARCHITECTURE,
"Route choice").

## Steps

```
step [title]
  <directive | goal> ...
```

Step directives:

| Directive | Effect |
|---|---|
| `zone <Name>` / `zone map <uiMapID>` | Current zone for coordinates from here on (sticky across later steps, also when its step has `only`: after a class trip, the next step everyone sees names its zone again). |
| `only <cond>[,<cond>...]` | The step applies only to matching characters. |
| `tip <text>` | Player-facing step note (compiled to `step.note`). |

A step must contain at least one goal.

## Goals

```
<verb> <positional args> <modifiers...> [-- note]
```

| Verb | Positional | Notes |
|---|---|---|
| `accept` | `<questId> ["Title"]` | Title and quest giver from data; a quoted title overrides it (required if the quest is not in data). |
| `turnin` | `<questId> ["Title"]` | Turn-in NPC/object from data. |
| `complete` | `<questId> ["Title"]` | Finish all objectives. |
| `kill` | `<npcId>` or `"Target name"` | Pair with `quest Q.O` to track a quest objective. |
| `collect` | `<itemId> ["Item name"]` | Pair with `quest Q.O`; otherwise tracked by bag count `xN`. `collect <item> xN nearest` (no `quest`) compiles to farm spots: clusters of normal or rare mobs that drop the item at 2% or more, outside towns and guard posts, each with the zone's safety (`A`/`H` faction zone, `AH` contested), mob level range, items per kill and spawn count; at most 16 per continent, spread over safety and 10-level bands. The engine picks one by the player's level, faction and travel time. |
| `goto` | `<x>,<y> ["Label"]` | Coordinates are mandatory here. A label that is a subzone's name as the game spells it (`"Fargodeep Mine"`, not `"Fargodeep Mine's mouth"`) gets its area ("Places by ID"); at a cave's or mine's mouth the goto then also counts as arrived once the player walks into it past the point (in that subzone and indoors). |
| `talk` | `<npcId>` | |
| `interact` | `<objectId>` | Click a game object. |
| `use` | `<itemId> ["Item name"]` | |
| `sethome` | `"Location"` or `nearest` | Inn location as the game names it (the bind location it reports), e.g. `"Goldshire"`. `sethome nearest` binds at the nearest own-faction inn when the step comes up. Lint warns about a location no inn has (`polestar find --kind inn`). Completes on every client language: binding at the inn's innkeeper, or a bind location the client names as the inn's area (see "Places by ID"). |
| `hearth` | `"Location"` | Done when the zone or subzone where you land has that name: an inn's location or the zone it is in, in the client's language when the compiler finds its area ("Places by ID"). Lint warns about any other name. |
| `getfp` | `"Location"` | Discover a flight path: the flight point's name (`"Stormwind, Elwynn"`) or its part before the comma (`"Stormwind"`). The compiler adds its taxi node, so it completes on every client language ("Places by ID"). Lint warns about a name no flight point has (`polestar find --kind flight`). |
| `fly` | `"Location"` | Take a flight: the flight point's town (`"Stormwind"`), as the flight map picks the node by it. Done when the zone or subzone where you land has that name (in the client's language when the compiler finds its area, "Places by ID"); where the landing area is named differently (`"Stormwind City"`), the goal checks off only through a later goal of its step. Lint warns about a name that is no flight point's town, inn location or zone they are in. |
| `train` | `[npcId]`, `<Profession> [Rank]`, or `class` | `train First Aid` / `train Mining Expert`: the nearest own-faction trainer of that profession and rank (`Apprentice`, `Journeyman`, `Expert`, `Artisan`; ranks taught by a book or quest point at its vendor or quest giver). Without a rank: the highest rank whose minimum skill (0/50/125/225) the last earlier `skill` (or `craft … until`) target for that profession in the guide reaches, Apprentice when there is none, and always above a rank the guide already trained. `train class`: the nearest trainer of the player's class. Resolved at runtime from the player's faction and position. |
| `buy` | `<itemId> ["Item name"]` | Use `xN` for quantity. Add `nearest` to send the player to the closest own-faction vendor selling it. |
| `vendor` | `[npcId]` or `nearest` | Sell junk / repair; `nearest` picks the closest own-faction vendor. |
| `level` | `<N>` | Reach level N (grind if needed). |
| `note` | `<text...>` | Informational line; never blocks. Quotes optional. |
| `skill` | `<Profession> <N>` | Reach skill rank N (`Alchemy`, `Blacksmithing`, `Enchanting`, `Engineering`, `Herbalism`, `Leatherworking`, `Mining`, `Skinning`, `Tailoring`, `Cooking`, `Fishing`, `First Aid`, quoted when multi-word). |
| `learn` | `<spellId> ["Name"]` | Learn a recipe or spell (trainer or recipe item); name from `professions.json`. A trainer-taught spell points at every trainer of its rank (a smart target; `npc <id>` fixes one); `learn <spellId> nearest` for a recipe sold by vendors sends the player to the closest own-faction vendor of the recipe item. |
| `craft` | `<spellId> ["Name"]` | Craft a recipe; `x<N>` crafts, or `until <N>` = until the recipe's profession reaches N. |
| `rep` | `<Faction> <Standing>` | Reach a standing (`Neutral`, `Friendly`, `Honored`, `Revered`, `Exalted`) with a faction named in `factions.json`, or `rep <factionId> <Standing>`. |
| `explore` | `<x>,<y> ["Area"]` | Discover the map area at those coordinates (current zone). |
| `achieve` | `<achievementId> ["Name"]` | Complete an achievement / Legacy Challenge; `criteria <n>` targets one criterion. |

**Smart targets.** `nearest` (and the profession/class forms of `train`) compile to a
*candidate set* instead of one NPC: every matching NPC in the data with its faction.
At runtime the engine keeps the candidates the character may use (faction, and race
or class where it matters) and picks the cheapest by travel time from where the
player stands, re-deciding on zone changes. Explicit npc ids stay fixed. Profession
guides should use these forms instead of per-race branches.
Sources: profession trainers from `professions.json`; class trainers from
`trainers.json` (`node tools/polestar.js trainers build`: `train <npcId> only <Class>`
goals in `guides/`, recorded trainer visits, and a curated list verified against
`npcs.json`; without the file, the curated list); innkeepers from the `innkeeper`
and `vendor nearest` from the `repair` role in `npcs.json`; `buy … nearest` from the
item's `vendors`; `collect … nearest` from the item's droppers (see `collect`);
`learn … nearest` from the recipe item's `vendors`; a trainer-taught `learn`
from the profession rank's trainers in `professions.json`. Only
factions the goal can apply to are kept, and each set keeps one candidate per town
(within 250 yards), nearest to the previous goal first.
Smart targets take no coordinates.

Modifiers, in any order after the positional arguments:

| Modifier | Meaning |
|---|---|
| `@x,y` or `@ x,y` | Coordinates (0–100) in the current zone. |
| `map <uiMapID>` | Zone for this goal's `@` coordinates only. |
| `npc <id>` / `object <id>` / `item <id>` | Explicit entity (e.g. which quest giver). |
| `quest <id>` / `quest <id>.<objective>` | Quest objective link (1-based objective, numbered in the order the game's quest log lists them; `polestar find <quest id>` prints them). |
| `x<N>` | Count. |
| `"text"` | Display text override (for `goto`: the label). A quoted token directly after the entity id of `kill`, `talk`, `interact`, `train` or `vendor` (like `collect`/`use`/`buy`) names that entity instead, for new Forever content missing from the data. |
| `r <yards>` | Arrival radius (`goto`, default 8). |
| `lvl <N>` | Minimum level shown on an `accept`. |
| `optional` | Never blocks the step. |
| `group [N]` | Needs a group, of `N` players (2–40) when given (`kill 1234 group 3`, `accept 7583 group 5`). The guide window says "Group of 3 advised" (or "Group advised") under the goal. Overrides what the compiler derives: see "Group content". |
| `only <cond>[,<cond>...]` | Goal applies only to matching characters. |
| `era` / `live` | Map frame of this goal's typed coordinates, overriding `coords`. |
| `choose <item> ["Name"] [quality] ...` | `turnin` only: the reward choices, shown under the turn-in and in its tooltip. Each entry is an item id, optionally its quoted name and a quality word (`poor` `common` `uncommon` `rare` `epic` `legendary` `artifact` `heirloom`); entries follow one another (`choose 6480 918 "Deviate Hide Pack" common`). Names and qualities default to `items.json`; an id missing there needs its name. Display only: a named unknown id is not a warning. |
| `reward <item> ["Name"] [quality] ...` | `turnin` only: items given outright, same entries as `choose`. |
| `xp <N>` | `turnin` only: the XP it pays. Shown with the rewards, and used for the route-level check when the quest has no `xp` in the data. |
| `money <amount>` | `turnin` only: copper (`money 350`) or `1g50s` / `7s` / `25c` forms. |
| `direct` | `turnin` only: the quest is handed in straight from the giver's window, with no `accept` (Distracting Jarven 308, the repeat cloth donations). It needs no earlier accept, and its availability, prerequisites and exclusive quests are checked as an `accept`'s are. The quest never enters the log, so it carries no objectives: get what it asks for with a plain `buy` or `collect` (without `quest`). The goal checks off on the hand-in itself and stays checked after a `/reload`, so a repeatable does not come back as undone. |

## Conditions

Comma-separated names, case-insensitive:

- Classes: `Warrior Paladin Hunter Rogue Priest Shaman Mage Warlock Druid`.
  A class may be negated with `!` (`only !Hunter`).
- Races: `Human Dwarf Gnome NightElf Orc Troll Tauren Undead Skyborne` (compiled
  to the client's race file names, UnitRace's second return; `Undead` →
  `Scourge`). Skyborne plays on both sides: a guide's `faction` or an `only`
  faction picks the side. Unknown race names are passed through with a warning
  (new Forever races).
- Factions: `Alliance Horde`.

Classes OR together, races OR together, factions OR together; the three groups
AND. `only Warrior,Paladin,Dwarf` = (Warrior or Paladin) and Dwarf.

## What the compiler fills in

| Missing | Filled from |
|---|---|
| quest title | `quests.json` |
| quest giver / turn-in target | `start` / `end` of the quest; `npc`/`object` modifiers pick one explicitly |
| coordinates | the target's spawns, trying maps in order: the current zone, then maps the guide already used (most recent first), then anywhere. On the chosen map: the spawn nearest the previous goal when that goal is on the same map, else the centroid of the highest-priority candidate |
| `kill` target name | `npcs.json` |
| `collect` coordinates | every drop source with spawns, ranked as above (zone, used maps, nearness), then by drop chance. On the chosen map only the likely sources count (at least half the best chance there). Where elites (rank 1-3, hostile) drop the item beside normal mobs or objects, each at 1% or more, only the normal ones count, whatever the elites' chance, and a place of theirs with more elite spawns than its own within its radius (at least 70 yd) is an alternative spot: the point and the arrow lead to the normal mobs, not into the elite camp. An item only elites drop there keeps them |
| `collect` source `from`, `fromAlso`, `fromId`, `fromAlsoId`, `fromKind`, `fromRank`, `fromFaction` | a `collect` (quest objectives too) whose item has one source with spawns, or one that drops it at 50% or more, and at most 8 sources at 2% or more (not cloth that drops everywhere); where normal mobs or objects and elites both drop it at 1% or more, only the normal ones are named, as the arrow leads to them: the source's name, a second source of the same kind at 50% or more, their ids, `npc` or `object`, the NPC's rank (1 elite, 2 rare elite, 3 boss, 4 rare) and faction (`A`, `H`, `AH`; none for a hostile mob). The goal line names it, in the client's language by its id: "Kill Grell or Grellkin for Fel Moss" for an enemy, "Collect Oats from Sack of Oats" otherwise (nothing added for an object named as the item); with author `text` the line under it says "Kill Aean Swiftriver (rare elite)" or "From <name>"; a quest started by that item reads as one line ("Runed Scroll: kill Aean Swiftriver (rare elite)") |
| profession, recipe, trainer | `professions.json` (skill line, recipe name, created item, reagents, recipe item; a trainer-taught `learn` gets every trainer of the rank that teaches it, both factions (a smart target), unless `npc <id>` names one). Classic profession names resolve without it. |
| faction | `factions.json` by name (lowest id on ties) or id |
| objective index | the quest's objective whose `id` matches the npc/item, when `quest Q` has no `.O` |
| count | the linked objective's count |
| Era frame flag `f = "e"` | when coordinates come from Era-frame data, or were typed in an `era` guide/goal |
| spawn areas `spots` | every goal placed at an NPC or object that spawns at more than one place, and hand-placed `@x,y` goals whose target the data also knows: see "Spawn areas" below |
| group content `group` | elite work, dungeon and raid quests and goals on an instance map: see "Group content" below |
| height `z` | a goal at an NPC or object: the height of that NPC's or object's spawn (`spawnz.json`), so the walk ends on its floor: see "Heights" below |
| place area `area` | `sethome`, `hearth`, `fly` and `getfp` (their location) and `goto` (its label): the AreaTable area of that name, so the goal completes and reads right on every client language: see "Places by ID" below |
| taxi node `node` | `getfp`: its flight point's taxi node (`travel.json`): see "Places by ID" below |
| name tokens `{kind:id}`, `names` | the game's names in every text a player reads, so each shows in the client's language: see "Names in texts" below |
| (a note dropped) | a goal's `--` note that only names the goal's own NPC, object, target or item (`accept 6181 -- Quartermaster Lewis`): the goal shows that name already, in the client's language |

**Names in texts.** A text the player reads (the guide's `title`, `why`,
`pitch`, `pros`, `cons` and `reward text`; a step's title and `tip`; a goal's
`--` note and display text) names quests, NPCs, places and items in English.
The compiler writes each name it can tell apart as a token, `{kind:id}`, so
the addon shows the game's own name there on every client language
(docs/TRANSLATING.md, "Guide texts"), and a translator writes only the words
around it. It looks, longest name first and with its exact case, for: the
names the step's own goals give (quests, givers and enders, targets, items,
collect sources, smart-target candidates, rewards, reagents, quest objectives,
spells, factions, professions), then the whole guide's, the zones of its maps
and the AreaTable areas in them, then any zone and any open-world area whose
name is unique, the professions and their reagents, and any NPC, object or
item of the data whose name has two words or an apostrophe, then the
client's spell names (the Forever `SpellName` table of the client build
`meta.json` names, cached beside the data: any spell of two words or more, or
with an apostrophe or colon; a one-word class or profession ability only in
Class and Professions guides, or after "cast" or "your"; none another thing
of the game shares, no profession rank spell, no spell owning something
("Blizzard's designers"), and no one-word spell used as a verb: taking an
object or opening a sentence that goes on in lower case, "Polymorph a
naga"; nor a name of a faction of the client's `Faction` table, "Burning
Blade"). A place, NPC or
object the game names with a leading "The" matches without it ("Molsen
Farm" is the game's "The Molsen Farm"), and a zone or area ending "City"
without that ("Stormwind"). An NPC of the step's or the guide's own goals
also matches by its first name ("Dalinda" for Dalinda Malem) where that
word has four letters or more, no other NPC of the step (or guide) shares it,
no other NPC of the data starts with it ("Defias" stays words), and the word
after it is not the rest of the NPC's name ("Lashtail raptors"). Other
languages show the game's name there, and an English client reads the
author's own words (the compiled guide's `written`). A name in its
English plural ("Harvest Watchers"), in lower case ("the Jansen Stead") or
inside a longer word stays words, as does a name right next to a capitalised
word or before "of <Capitalised>" that would make it a longer name the data
lacks ("Rot Hide" gnolls, "Young Wetlands Crocolisks", "Cleft of Shadow",
"Elixirs of Shadow Power"; a possessive, a profession rank or a sentence's
opening word does not count),
and a one-word name the pack's texts
also use as a lower-case word ("Barracks"), and two names a space apart (a
name the data lacks, "Longshore Murloc Gills"). You may write a token
yourself, `{npc:240}`: its kind and id must be in the data. `i18n guides
stats` counts the tokens, by kind and by where the compiler found them.

**Spawn areas.** Mobs, quest objects and some NPCs spawn at more than one
place, and a player who finds nothing where the arrow led must be able to try
the others. So a goal placed at an NPC or object gets every place its target
spawns: `spots = { { x, y, r, n, alt }, ... }`, each the centre (map percent,
in the goal's own `map` and frame `f`), radius in yards covering its spawns,
and spawn count of one cluster of the target's spawns (for `collect`: the
likely sources' spawns on that map, mobs, objects and nodes, as chosen above).
Every known spawn on the goal's map lies in a spot (the reference data's
evenly spread points and the ones its per-map cap left out, `more` in
docs/ARCHITECTURE.md, "Reference data"). Spots with `alt = true` are the
other places it spawns: the arrow never picks one on its own, but the world
map marks them (fainter) and moving on by hand reaches them (the arrow button,
a click on the arrow, a click on a mark). The clusters come from the quest
database's clustering (`tools/lib/questdb/cluster.js`). Same map only. The goal
keeps its `x`/`y` as the default point. A target with a single spawn on the map
gets no `spots`.

- **Places** (6 spawns or fewer: a named NPC or a quest object that appears at
  one of a few places, or the handful of mobs an objective needs): every place
  is a spot the arrow may pick, spawns within 70 yd of each other being one
  place, radius at least 15 yd. Places within 250 yd of their centre work as
  camps (below); further apart, kill, collect and interact goals search them
  like an area objective (`spread = true`, a walk from the goal's point).
- **Camps** (90% of the spawns within 250 yd of their centre): clusters of
  70 yd, widened for thinly spread mobs to twice the median spacing between
  neighbouring spawns (at most 250 yd); radius at least 15 yd. The arrow picks
  among the clusters of two or more (all of them when none has two), nearest
  to the goal's `x`/`y` first, at most 6; lone spawns and clusters past the 6
  follow as alternatives. At runtime the waypoint is the spot nearest the
  player and the arrow counts the whole area as arrived.
- **Area objectives** (spawns reaching further: raptors all over the northern
  Barrens) also get `spread = true`. Clusters as for camps; every cluster
  counts, lone spawns too, each at least as wide as the spacing between spawns
  (40-150 yd); beyond 12 the searched ones are spread evenly over the area
  (farthest-point picks from the cluster nearest the goal's point), ordered as
  a walk from the goal's point, and the rest follow as alternatives. At runtime
  the player searches spot by spot: the arrow says "Search here" inside a spot
  (never "Arrived"), moves on to the nearest spot not visited lately once the
  player leaves it, and the map shades every region the spots cover.
- **Hand-placed** (`@x,y`): the author's point is the spot the arrow takes,
  wide enough for any place of the target it stands in, and every other place
  the data knows follows as an alternative. Only where the data agrees: a point
  more than 50 yd from every spawn of an NPC to meet, or more than 250 yd from
  every spawn of a mob or object to kill, collect or click, places the target
  where the data does not (Forever moved it) and gets no `spots`. A route
  through gathering nodes lists every node place of the zone wherever its
  point lies.

See docs/ARCHITECTURE.md, Smart logic, "Spawn areas".

**Heights.** In stacked places (the Undercity's quarters under its streets, a
tower's floors) a point on the map is several places, and the walking route
ends on whichever floor its engine picks. So a goal whose point stands for an
NPC or object gets that entity's height, `z` (world yards), from
`data/forever/spawnz.json` (CMaNGOS classic-db's spawn positions, which
`data build` writes): the z of the entity's nearest spawn on the goal's
instance map (its world point's, in the goal's frame), when that spawn is
within 15 yards of the point. Nothing is guessed: an NPC only Forever has, or
one Forever moved more than 15 yards, gets none, and without `spawnz.json` no
goal gets one. These goals can get one, their point being the NPC's or
object's (its spawn, or your `@x,y` at it):

- `accept` and `turnin` at their NPC or object (not a quest from an item);
- `talk`, `kill` (the spawn nearest the previous goal; a point at the centre
  of many spawns is seldom within 15 yards of one), `interact`;
- `buy`, `train`, `vendor`, `sethome`, `getfp` and `learn` naming an `npc`.

`goto` and `explore` (places), `collect` (a farming spot among the item's
sources), `use` and smart targets (`nearest`, class and profession trainers:
the engine picks the NPC at runtime) never get one, nor does the arrow carry
it to a spawn area other than the goal's own point. `compile` prints how many
goals got one ("heights: N of M NPC or object goals got z"). In the game the
walk is searched with the height and asked again without it when that finds
no route or one ending more than 30 yards above or below it.

**Places by ID.** The game names places in the player's language
("Sombre-Comté" on a French client for "Darkshire") and guides name them in
English, so the compiler gives a goal that names a place that place's ID, and
Polestar compares IDs, or names the game gives in the same language:

- `area`: on `sethome`, `hearth`, `fly` and `getfp` the area their location
  names, on `goto` the one its label names, from the client's AreaTable (the
  newest Forever build `data build` caches in `data/sources/wago/`): of the
  areas with that name (any case), the one in the goal's zone when the goal
  has a map, else the open world's (Eastern Kingdoms and Kalimdor, not
  Forever's copies of a town elsewhere). A name two areas share there gets
  none. In the game a `hearth` or `fly` is done when the zone or subzone text
  is that area's name in the client's language (`C_Map.GetAreaInfo`), a
  `goto` also when the player goes indoors in that subzone (a cave or mine,
  never a zone), and the guide window shows that name.
- `node`: on `getfp`, the taxi node of its flight master (`npc`), else of the
  one flight point (`travel.json`) of that name or town serving every faction
  the goal applies to (Booty Bay has one per faction, so a goal for both gets
  none). In the game the goal is done once the flight map lists that node as
  known.
- `sethome` completes by its inn: `travel build` gives every inn its area,
  and binding at the innkeeper the goal names (or the innkeeper of the inn its
  location names) completes it.

A name with no single match gets nothing and the goal keeps matching by its
English name, as before; the guide sources do not change. `compile` prints
how many got one ("areas: N of M place goals got an area", "nodes: N of M
getfp goals got a taxi node").

## Group content

Every goal that needs a group says so in the guide window, under the goal
(once per card when several goals share it), and a guide with such a goal on
its route (not `optional`) carries a "Group" chip in the guide menu. The
compiler writes `group` on the goal, first match wins:

1. the author's `group [N]`: `{ kind = "group", size = N }` ("Group of N
   advised"; "Group advised" without `N`);
2. a dungeon or raid: a goal with a quest (`accept`, `turnin`, `complete`, or
   an objective goal with `quest`) that the simulator's solo filter counts as
   a dungeon or raid quest (tools/lib/sim/solo.js): the quest's area in
   `quests.json` lies in an instance, and its giver, its ender or one of its
   objectives has no open-world spawn (a breadcrumb into the instance stays an
   open-world quest); or a goal placed on a map drawn only on an instance:
   `{ kind = "dungeon" | "raid", name = "Dire Maul" }` ("Dungeon: Dire Maul",
   "Raid: Molten Core");
3. elite work, the same test as the Leveling-guide elite rule (Validation): a
   `kill` of an npc of rank 1–3 hostile to a side the goal applies to, or a
   `collect` whose every located dropper is one: `{ kind = "elite", rank }`
   ("Elite: group advised", "Rare elite: group advised", "Boss: group
   advised").

The instances come from the Forever client's `Map.csv`, `AreaTable.csv` and
`UiMapAssignment.csv` in the `sources` folder beside the data folder
(`data/sources/wago/<build>/` for `data/forever`; `data build` and `codex
build` cache them). Without them only `group [N]` and elite work apply. The
guide's `group = true` is set when any goal that is not `optional` has `group`.

## Validation

Errors fail `compile` and `lint`; warnings print.

Errors:
- syntax errors, unknown verbs or modifiers, malformed IDs or coordinates
- duplicate guide ids; `next` pointing to an unknown guide
- a `next` guide (or route option) no character of this guide can follow: of
  the other faction, or whose `race` or `class` leaves none of this guide's
  characters (no race in common, no class in common, or no race of this guide
  that can be one of its classes): `no Human character can follow
  forever/alliance/dwarf-gnome/01-dun-morogh (it is for Dwarf/Gnome only)`.
  A partial overlap is fine
- a step with no goals
- quest, npc, item or object id unknown in data **and** no explicit name/title
- profession, faction or spell unknown in data **and** no quoted name; a faction
  not in `factions.json` also needs its id (`rep <factionId> "Name" <Standing>`);
  `achieve` always needs its quoted name
- `rep` standing outside 1–8 / Hated–Exalted; `craft` with both `xN` and `until`
- empty quoted strings (names, titles, labels, notes)
- `era`/`live` on a goal without typed coordinates
- `choose`/`reward` without item ids, an item listed twice, a reward item missing from `items.json` without a name; malformed `money` or `xp`; a `group` size that is not a whole number from 2 to 40
- a smart target (`nearest`, `train <Profession>`, `train class`, `collect … nearest`) with no candidate
  in the data or with coordinates; `collect … nearest` without `xN` or with `quest`;
  `nearest`/`train class` with an `npc` (`train <Profession> npc <id>` keeps that
  trainer); an unknown profession in `train`
- `turnin`/`complete`/objective goals for a quest that is never accepted earlier
  in this guide or in a guide that chains into it via `next`, unless the turn-in
  is `direct` (for a repeatable quest its giver also takes back, the hint
  suggests `turnin <id> direct`)
- `turnin … direct` for a quest the chain accepts earlier (drop `direct`), and
  `complete` or an objective goal for a quest handed in `direct`
- `accept` for a quest whose `races`/`classes` exclude every character the
  step or goal can apply to
- coordinates outside 0–100
- required elite work in a `Leveling` guide (a warning in other packs; elite work may appear there only as
  an `optional` extra, with the tip `<Target> is elite: grouping up is advised.`):
  a non-`optional` `kill` of an npc of rank 1–3 (elite, rare elite, boss) hostile
  to a side the goal applies to (a friendly one is a talk credit), or `collect` of
  an item whose every located dropper is such an npc; `lint` also errors on a
  non-`optional` quest goal of a quest the cached simulator world (below) excludes
  as `elite`, unless the goal was already reported as elite

Warnings:
- an `accept` whose prerequisites (`pre`, any one suffices) are none of them turned in earlier in the chain
- an `accept` above the level the route plausibly reaches (when XP data exists)
- an `accept` of a quest whose `excl` (exclusive) quest is accepted or turned in
  earlier in the chain: the game does not offer it while that quest is in the
  log or done
- a non-`optional` `accept` never turned in later in the guide or the guides
  after it, checked for every route choice; when a next guide's race or class
  leaves out the characters still holding the quest, the warning says so (its
  turn-ins do not count for them)
- `complete` on a quest with no objectives: the turn-in is the action; use `turnin`
- explicit coordinates more than 50 yards from every known spawn of the entity
- ids missing from data but given explicit names/coordinates (new Forever content)
- objective-capable goals with no coordinates
- `quest Q.O` past the quest's objectives (the warning lists them as
  `7.1 = kill Kobold Vermin x10`), or an objective goal whose target is none
  of the quest's objectives
- a `craft` before any `learn` of that spell earlier in the chain (free starter
  recipes excepted); `until <N>` past the recipe's grey skill
- a coordinate on a map other than the step's zone that the guide never sets as
  a zone (catches a target resolved onto another continent)
- coordinates without `map` on a zone set in a step for some characters only,
  when the other characters who see them are in another zone (a class trip's
  `zone Moonglade` holding for the rest of Darkshore)
- profession, faction or spell missing from data but given a quoted name
- a `goto` right before a goal that already leads to the same place: the next
  goal (notes skipped) is located within 200 yards of the goto point, measured to
  the edge of its nearest spawn area (see `goto` under "Places")
- a quest item that vanishes after a while (items.json `duration`, from the
  Forever client's ItemSparse) carried longer than it lasts: from the goal
  that gets it (an `accept` whose quest hands it over, a `collect`, a `buy`)
  to a later `turnin` that needs it or `use` of it, timed from the latest
  goal that got more of it (`buy 13320 x2` serves two turn-ins, the second
  measured from the purchase), with the simulator's travel and kill times
  over the guide's goals (docs/SIMULATION.md, "Keeping the guides' fixes"):
  ``item 10439 (Durnan's Scalding Mornbrew) lasts 5 minutes, but the route
  takes about 11:29 from here to the `turnin` that spends it (line 196)``.
  Goals for other characters and `optional` ones are left out, so the
  estimate errs short
- a smart target with no candidate for a faction the goal applies to (and, for
  `train class`, for a class that faction's allowed races can be); a `train
  <Profession>` whose default rank needs more skill than any earlier `skill` target
- a `sethome`, `hearth`, `getfp` or `fly` location the game never reports,
  ignoring case: `sethome` against the inns' bind locations, `hearth`
  against those and the zones the inns are in, `getfp` against the flight
  points' names and their part before the comma (these three as the addon
  matches them); `fly` against the flight points' towns (the name the flight
  map picks the node by, even where the landing area is named differently),
  the inns' locations and the zones they are in. The hint names the closest
  known places (`did you mean "Feathermoon Stronghold"?`). Inns and flight
  points come from `data/forever/travel.json`; without it (or without the
  inns or the flight points in it) those goals are not checked
- a `|` in text the player sees (`title`, `folder`, `pitch`, `pro`, `con`,
  `author`, step titles and tips, goal texts and notes, quoted names): it
  prints literally in game
- another pack's Era frame for a map Polestar's guides also use, with other
  bounds: in game Polestar's wins, so coordinates on that map may be off
- `lint` only, with a simulator world cached in `data/sim` (or `--sim <dir>`): a
  non-`optional` quest goal in a `Leveling` guide on a quest the solo filter
  excludes (dungeon, raid, pvp, rare drop, reputation, repeatable or profession;
  `elite` is an error, above); a `turnin … direct` is no repeatable to grind
  and is left out of the repeatable check

These quest checks count a goal only for the characters its `only` (and the
quest's own race and class masks) leaves. Most messages carry a `hint:` line
saying how to fix them.

## Output

`compile` writes the pack's addon folder (Polestar's: `addon/Polestar_Guides/`;
another pack's: `dist/<folder>/`): the generated TOC, `Pack.lua`,
`MapFrames.lua` (Era bounds for referenced maps), `Guides.lua` (one
`RegisterGuide` per guide, each in its own function) and `LICENSE-DATA.txt`,
plus the pack folder's `LICENSE` copied as `LICENSE.txt` when it has one, and
beside it a texts addon per language the pack's `locales/` translates
(docs/TRANSLATING.md, "Guide texts").
[PACK_FORMAT.md](PACK_FORMAT.md) describes them. Output is deterministic: the
same inputs give byte-identical files.

## Cookbook

Worked examples, from guides that lint clean and play to the end. Every id
here was looked up with `polestar find`; look up yours the same way.

### Quests: `accept`, `complete`, `collect`, `turnin`

```
step Goldshire
  tip Marshal Dughan and Remy stand in front of the inn.
  accept 62
  accept 47

step Fargodeep Mine
  goto 39.5,80.0 "Fargodeep Mine"
  complete 62                          -- Walk through the mine
  collect 773 x10 quest 47.1           -- Gold Dust from the kobolds

step Back in Goldshire
  turnin 62
  turnin 47
```

The compiler fills in each quest's title, giver, turn-in NPC and coordinates.
`quest 47.1` ties the collect to the quest's first objective, so the guide
window counts it from the quest log. `complete` finishes every objective of a
quest with nothing more specific to track.

### Killing: `kill`

```
  kill 299 x8 optional                -- Young Wolves around the camp
  kill 6 x10 quest 7.1
```

A `kill` with `quest Q.O` counts from the quest log; without it the player
ticks it ("Patterns" below). Kill, collect and interact goals get spawn areas
from the data, so the arrow leads to the nearest camp.
`polestar find <quest id>` lists a quest's objectives as
`7.1 = kill Kobold Vermin x10`: the `7.1` is the `quest 7.1` to write.

### Places: `goto`, `explore`

```
  goto 39.5,80.0 "Fargodeep Mine"
  goto 46.0,55.0 live "Lift to the bluff"
  explore 39.5,80.0 "Fargodeep Mine"
```

Typed coordinates are in the Era map frame unless the guide says `coords
live` or the goal says `live`. In game, `/polestar where` gives your own
position as `zone map <id>` and `goto <x>,<y> live`, ready to paste, and the
`@x,y live` form for any other goal.

Use `goto` for travel and approach waypoints (a boat dock, a pass, a cave mouth
on a long ride) and for objectives the data has no location for. Kill, drop,
NPC and object goals carry their own location, so the arrow leads to them
directly; lint warns on a `goto` whose next goal is located within 200 yards of
it. It keeps a `goto` followed by another `goto`, by a goal without a location,
an `optional` one, one for other characters (`only`) or one on another map, a
kill or drop whose target spawns nowhere in the data (an instance boss placed at
its entrance), and gotos in steps with `fly` or `hearth`.

### People and things: `talk`, `interact`, `use`

```
  talk 295 optional
  interact 176793 quest 5545.1        -- Bundles of wood lie under the trees
  use 5411 quest 754.1 @51.8,68.4     -- Winterhoof Cleansing Totem
```

### Travel: `sethome`, `hearth`, `getfp`, `fly`

```
  sethome "Goldshire" npc 295         -- Innkeeper Farley, inside
  hearth "Goldshire"
  getfp "Thunder Bluff" npc 2995      -- Tal, on the top of the bluff
  fly "Crossroads"
```

Locations are written as the game names them; `polestar find --kind inn` and
`polestar find --kind flight` list the names (every inn and flight point,
with coordinates). `sethome nearest` binds at the nearest inn of the
player's faction instead.

### Errands: `train`, `buy`, `vendor`, `level`, `note`

```
  vendor nearest
  buy 159 x5 nearest                  -- Refreshing Spring Water
  train class
  level 9
  note You can train First Aid with any trainer of it in a city.
```

`nearest` and `train class` pick the trainer or vendor at runtime, by the
player's faction and where they stand.

### Professions: `train`, `learn`, `craft`, `skill`

```
step First Aid
  train First Aid
  learn 3275
  craft 3275 until 40
  skill "First Aid" 40
```

### Reputation and challenges: `rep`, `achieve`

```
  rep Stormwind Friendly optional
  achieve 6 "Level 10" optional
```

`achieve` always needs the achievement's quoted name.

### Class- and race-only steps

A header `race` or `class` limits the whole guide; `only` limits one step or
one goal:

```
guide joe-routes/mulgore
title Bloodhoof Village
faction Horde
race Tauren
levels 6-10
zone Mulgore

step Hunters only
  only Hunter
  train class                         -- your next spells

step Class quests
  note "Your class quest starts in Thunder Bluff." only Warrior,Shaman
```

A goal's `only` comes after its arguments, so a `note` with one needs its text
in quotes. `only !Hunter` is every class but Hunters. Playtest plays each
class a guide names, plus one it never names.

### Route choices

`next` with several ids lets the player choose where to level next; the first
is the default. Each option needs a `pitch`, and may have `pro` and `con`
lines:

```
guide joe-routes/mulgore
next joe-routes/thunder-bluff, forever/horde/02-the-barrens

guide joe-routes/thunder-bluff
pitch Train, shop and take the flight to the Crossroads.
pro Every trainer in one city
con A long ride down the lift
next forever/horde/02-the-barrens
```

### Optional extras

`optional` goals never hold the step: side quests, a rare, a reputation along
the way. An elite in a Leveling guide belongs here, with the tip
"<Name> is elite: grouping up is advised."

```
  accept 184 optional                -- Only if you looted a Westfall Deed: right-click it
  kill 299 x8 optional
```

### Handing over to our guides

A pack's guide may end by handing over to any of Polestar's guides. Pick one
its characters can follow: `polestar find --kind guide <zone>` prints each
guide's level range and who it is for, and `--race`/`--class` keep only the
ones such a character can follow:

```sh
polestar find --kind guide westfall --race Human
#   next forever/alliance/02-westfall  # Westfall (12-17), Alliance
#   # its next: forever/alliance/03-darkshore
#   next forever/collectibles/pets/chicken-egg  # Chicken Egg (1-60), Alliance
#   …  (the other collectible guides set in Westfall follow)
```

A guide for Humans cannot hand over to the Dwarf and Gnome guide
(`… # Dun Morogh (1-13), Dwarf/Gnome only`): lint stops it. Start the next
guide near the level yours ends at, and put its id in `next`:

```
next forever/alliance/02-westfall
```

Lint and playtest load Polestar's guides beside yours, so the handover is
checked and played: a hand-over that does not land on our guide with
something to do, or lands on one that does not apply to the character
(`no Human can follow it`), is reported as stuck at the hand-over. Turn-ins
in our guide of quests your guide accepted count too.

### With an AI assistant

An assistant can draft guides from your own notes and routes;
[PACKS.md](PACKS.md) ("With an AI assistant") explains how, and the ground
rule: its ids and coordinates are guesses until `find`, lint and playtest
confirm them.

### Patterns

**Several objectives at once.** The goals of one step are open together:
each counts as soon as it is done, in any order, and the step ends when every
goal that holds it is done. The arrow leads to the first open one (click a
row to aim at another). Put objectives the player works in the same area in
one step:

```
step Kobolds and wolves
  kill 6 x10 quest 7.1                -- Kobold Vermin
  collect 750 x8 quest 33.1           -- Tough Wolf Meat, from the wolves
```

**An optional side chain.** Mark every goal of the side quest `optional`:
it never holds a step, the player may dismiss it, and lint does not ask for
its turn-in. Keep it in steps that also have a goal that holds them: a step
of `optional` goals only is done at once, and the guide moves past it.

```
step Deputy Willem
  turnin 783
  accept 7
  accept 5261 optional                -- a short errand to Eagan Peltskinner

step Kobolds
  kill 6 x10 quest 7.1
  turnin 5261 optional                -- Eagan stands by the path
```

**Leveling up before moving on.** `level <N>` holds its step until the
character reaches level N. End a guide with it when the next guide's zone
needs a level the route may not reach by itself:

```
step Ready for Westfall
  level 12
```

**A bare `kill <npc>`** (no `quest`) is a check-off: Polestar does not count
the kills, so the player ticks the goal in the guide window, and until they
do it holds the step, unless it is `optional`. Tie a kill that serves a quest
to the objective with `quest Q.O` so the quest log counts it.
