# Polestar guide format, compact

Every line a `.guide` file can hold. The full rules and every lint check are
in Polestar's `docs/GUIDE_FORMAT.md`.

## Layout

- One guide per file, UTF-8. A header (lines in column 0), then steps; the
  lines inside a step are indented.
- Words are separated by spaces; `"double quotes"` hold several words as one
  (`\"` and `\\` escape). Keywords ignore case; ids are whole numbers.
- `#` starts a note for authors (dropped) at the start of a line or after a
  space outside quotes.
- ` -- ` (space, two dashes, space) after a goal starts a note players see
  under that goal: `accept 783 -- He stands at the abbey gate`.

## Header

Before the first `step`. `guide`, `title`, `levels` and `zone` are required.

| Line | Value |
|---|---|
| `guide <id>` | First line. The pack id, a slash, a name: `joe-routes/westfall` (`a-z`, `0-9`, `_`, `-`, `/`) |
| `title <text>` | The name in the guide menu |
| `levels <min>-<max>` | `levels 10-15` |
| `zone <Name>` / `zone map <uiMapID>` | The zone coordinates are in until a step names another |
| `faction <Faction>` | `Alliance` or `Horde`: only that side is offered the guide |
| `race <Race>, ...` | Only these races (Conditions) |
| `class <Class>, ...` | Only these classes |
| `next <id>, ...` | The guide that follows. Several ids: the player chooses, the first is the default; each must suit this guide's characters (`polestar find <zone> --kind guide --race <Race>`) |
| `category <Category>` | `Leveling` (default), `Class`, `Professions`, `Reputation`, `Legacy`, `Exploration`, `Collectibles`, `Dungeons` |
| `folder <text>` | The guide menu folder to list it under |
| `keywords <word>, ...` | Extra words the guide menu search matches |
| `collects <item>, ...` | Item ids the guide obtains |
| `reward item <item> ...` / `reward spell <id> "Name"` / `reward text <words>` | Repeatable: what the guide's goal gives, first in the guide menu's details (several items on one line: a choice of one). Lint warns on a `Class` guide without it |
| `why <text>` | One short line in the guide menu's details: why the goal is worth doing (lint warns on a `Class` guide without it) |
| `author <name>` | Default: `pack.json`'s author |
| `version <N>` | A whole number, raised when the guide changes (default 1) |
| `coords era` / `coords live` | The map frame of typed coordinates (default `era`) |
| `skip none` | A leveling guide whose every step is done (no grey quest left out, nothing skipped when it catches up) |
| `pitch <text>` | On a guide offered by a `next` choice: one line on its card (lint warns when missing) |
| `pro <text>` / `con <text>` | Repeatable: one advantage or drawback per line under the pitch |

## Steps

`step [title]` starts a step. It holds at least one goal and is done when
every goal in it that is not `optional` is; its goals are open together.

| Line | What it does |
|---|---|
| `step [title]` | Starts a step |
| `tip <text>` | A note for the whole step |
| `zone <Name>` / `zone map <uiMapID>` | The zone for coordinates from here on, in later steps too |
| `only <condition>, ...` | The step is only for matching characters |

## Goals

`<verb> <arguments> <modifiers> [-- note]`. Every goal also takes
`optional`, `only`, `"text"`, `group` and, except where the last column says
otherwise, the place modifiers `@x,y`, `map`, `r`, `era` / `live`.

| Line | What it does | Also takes |
|---|---|---|
| `accept <quest> ["Title"]` | Take a quest; giver, title and place from the data | `npc`, `object`, `item`, `lvl` |
| `turnin <quest> ["Title"]` | Hand a quest in | `npc`, `object`, `choose`, `reward`, `xp`, `money`, `direct` |
| `complete <quest> ["Title"]` | Finish every objective of a quest with nothing more specific to track | |
| `kill <npc>` / `kill "<Name>"` | Kill a mob; with `quest Q.O` the quest log counts it, without it the player ticks it | `npc`, `quest`, `xN` |
| `collect <item> ["Name"]` | Loot or gather items; without `quest`, counted in the bags | `quest`, `xN`, `nearest` |
| `goto <x>,<y> ["Label"]` | Walk there; for travel and places the data has no target for | `map`, `r`, `era` / `live` only |
| `talk <npc>` | Speak to an NPC | |
| `interact <object>` | Click a game object | `quest` |
| `use <item> ["Name"]` | Use an item | `quest` |
| `sethome "<Location>"` / `sethome nearest` | Bind the hearthstone at an inn (`polestar find --kind inn`) | `npc` |
| `hearth "<Location>"` | Use the hearthstone; done on landing there | no place modifiers |
| `getfp "<Flight point>"` | Learn a flight path (`polestar find --kind flight`) | `npc` |
| `fly "<Town>"` | Take a flight; done on landing | no place modifiers |
| `train class` / `train <npc>` / `train <Profession> [Rank]` | Visit a trainer: the nearest of the player's class, that one, or the nearest of a profession | `npc` |
| `buy <item> ["Name"]` | Buy an item; `nearest` picks the closest vendor selling it | `npc`, `xN`, `nearest` |
| `vendor nearest` / `vendor <npc>` | Sell and repair | `npc` |
| `level <N>` | Reach level N, grinding if need be | no place modifiers |
| `note <text>` | A line of information; never holds the step. With `only`, quote the text | no `"text"`, no `group` |
| `skill <Profession> <N>` | Reach skill N (`"First Aid"` quoted) | |
| `learn <spell> ["Name"]` | Learn a recipe or spell | `npc`, `item`, `nearest` |
| `craft <spell> ["Name"]` | Craft a recipe | `xN`, `until` |
| `rep <Faction> <Standing>` | Reach a standing, `Hated` to `Exalted`, with a faction by name or id | |
| `explore <x>,<y> ["Area"]` | Discover the map area there | `map`, `r`, `era` / `live` only |
| `achieve <id> "Name"` | Complete an achievement or Legacy Challenge; the name is required | `criteria` |

`nearest`, `train class` and `train <Profession>` pick the NPC or place when
the step comes up, by the player's faction and position; they take no
coordinates and no `npc` (except `train <Profession> npc <id>`).
`collect <item> xN nearest` needs its `xN` and no `quest`.

## Modifiers

After the arguments, in any order.

| Modifier | Meaning |
|---|---|
| `@x,y` | Coordinates 0-100 on the current zone's map, in place of the data's |
| `map <uiMapID>` | The map of this goal's `@` coordinates |
| `r <yards>` | How close counts as arrived (`goto`, default 8) |
| `era` / `live` | The map frame of this goal's typed coordinates |
| `npc <id>` / `object <id>` / `item <id>` | Which NPC, object or item, when the data knows several |
| `quest <id>.<n>` | The quest objective this goal counts, numbered as `polestar find <id> --kind quest` lists them (`quest <id>` alone lets the data pick) |
| `x<N>` | How many: kills, items, purchases, crafts |
| `"text"` | Right after an id: the name or title, for content missing from the data; later: the text players see |
| `lvl <N>` | On `accept`: the level the quest needs |
| `optional` | Never holds the step |
| `group [N]` | Needs a group (of N players, 2-40); the guide window says so. Elites, dungeon and raid quests are found from the data without it |
| `only <condition>, ...` | The goal is only for matching characters |
| `nearest` | The closest vendor, trainer or drop place, picked in game |
| `until <N>` | On `craft`: until the profession reaches N |
| `criteria <n>` | On `achieve`: one criterion |
| `choose <item> ...` / `reward <item> ...` | On `turnin`: the rewards to pick from, the ones given outright |
| `xp <N>` / `money <amount>` | On `turnin`: what it pays (`money 1g50s`) |
| `direct` | On `turnin`: handed in from the giver's window with no `accept`, so it needs none. The quest never enters the log: get what it asks for with a plain `buy` or `collect` |

## Conditions

For `race`, `class` and `only`: a comma list. Names in one group match any of
them; the groups must all match (`only Warrior,Paladin,Dwarf` is a Dwarf
Warrior or Paladin).

- Classes: `Warrior` `Paladin` `Hunter` `Rogue` `Priest` `Shaman` `Mage`
  `Warlock` `Druid`; `!Hunter` is every class but Hunters.
- Races: `Human` `Dwarf` `Gnome` `NightElf` `Orc` `Troll` `Tauren` `Undead`
  (or `Scourge`) `Skyborne` (Skyborne plays on both sides).
- Factions: `Alliance` `Horde`.

## Lint errors that come up most

- A `turnin`, `complete` or objective goal for a quest no earlier goal
  accepts, in this guide or one that leads to it with `next` (a `direct`
  turn-in is the exception; `complete` and objectives for one are an error).
- An unknown id without a quoted name; an unknown verb or modifier.
- A required kill of an elite in a `Leveling` guide.
- A `next` guide none of this guide's characters can follow.

Lint also warns when a quest is accepted and never handed in, when
`quest Q.O` names no objective of the quest (the message lists them), and
when typed coordinates are more than 50 yards from every place the target
spawns.
