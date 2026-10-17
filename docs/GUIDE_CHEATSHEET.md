# Guide format on one page

Every line a `.guide` file can hold, with what it does and a short example.
The full rules, the checks `polestar lint` runs and worked examples are in
[GUIDE_FORMAT.md](GUIDE_FORMAT.md); packs are in [PACKS.md](PACKS.md).
`polestar find <text>` looks up the ids the examples use.

A guide is a header (lines in column 0) followed by steps; the lines inside a
step are indented. Words are separated by spaces, `"double quotes"` hold
several words as one, and keywords ignore case.

## Header

Before the first `step`. `guide`, `title`, `levels` and `zone` are required.

| Header line | What it does | Example |
|---|---|---|
| `guide <id>` | First line: the guide's id, starting with your pack id and `/` | `guide joe-routes/goldshire` |
| `title <text>` | The name players see in the guide menu | `title Goldshire to Westfall` |
| `levels <min>-<max>` | The character levels the guide is for | `levels 5-10` |
| `zone <Name>` | The zone the guide's coordinates are in, until a step names another | `zone Elwynn Forest` |
| `zone map <uiMapID>` | The same, by map id | `zone map 1429` |
| `faction <Faction>` | Only for `Alliance` or `Horde` characters | `faction Alliance` |
| `race <Race>, ...` | Only for these races (see Conditions) | `race Human, Dwarf` |
| `class <Class>, ...` | Only for these classes | `class Warrior, Paladin` |
| `category <Category>` | The guide menu category: `Leveling` (default), `Class`, `Professions`, `Reputation`, `Legacy`, `Exploration`, `Collectibles` or `Dungeons` | `category Professions` |
| `folder <text>` | The guide menu folder to list it under | `folder Mounts · Level 40` |
| `keywords <word>, ...` | Extra words the guide menu search finds it by | `keywords wolf, meat` |
| `collects <item>, ...` | Items the guide obtains; Lookup opens this guide for them | `collects 750` |
| `reward item <item> ...` | What the guide's goal gives, shown with its icon in the guide menu; several items on one line are a choice of one; repeatable | `reward item 1251 2581` |
| `reward spell <id> "Name"` | A spell the goal teaches (a mount, a form, a demon) | `reward spell 5784 "Summon Felsteed"` |
| `reward text <words>` | A reward without an id | `reward text Shen'dralar reputation` |
| `why <text>` | One short line in the guide menu: why the goal is worth doing (Class guides need it and `reward`) | `why Your own mount at 40.` |
| `author <name>` | Credits a guide to someone other than the pack's author | `author Joe` |
| `version <N>` | A whole number you raise when the guide changes (default 1) | `version 2` |
| `coords era` / `coords live` | The map frame of the coordinates you type (default `era`; `record draft` writes `live`) | `coords live` |
| `skip none` | A leveling guide whose every step is done: no grey quest is left out, and nothing behind the player when the guide catches up (other categories already do every step) | `skip none` |

## Steps and text

| Line | What it does | Example |
|---|---|---|
| `step [title]` | Starts a step; it is done when its goals are | `step Kobold camp` |
| `tip <text>` | A note for the whole step, shown in the guide window | `tip Pull one kobold at a time.` |
| `zone <Name>` / `zone map <uiMapID>` | Inside a step: the zone for coordinates from here on, also for the steps after it (after a step with `only` that sets one, name the zone again) | `zone Elwynn Forest` |
| `only <condition>, ...` | Inside a step: the step is only for matching characters | `only Hunter` |
| `note <text>` | A line of information; never holds the player up | `note The camp is busy at night.` |
| `level <N>` | Reach level N, grinding if need be | `level 2` |
| `# <text>` | A note for you and other authors; players never see it | `# check the patrol route` |
| `<goal> -- <text>` | Shows the text under that goal | `accept 783 -- He stands at the abbey gate` |

## Places and travel

| Line | What it does | Example |
|---|---|---|
| `goto <x>,<y> ["Label"]` | Walk to a spot; checked off on arrival, when a later goal of the step is done, or, ending its step, when the next step's quest work is done | `goto 47.6,35.1 "Kobold camp"` |
| `r <yards>` | How close `goto` counts as arrived (default 8) | `goto 42.9,65.6 "Goldshire" r 30` |
| `@<x>,<y>` | Places any goal at these coordinates instead of the data's | `talk 197 @48.9,41.6` |
| `map <uiMapID>` | The map this goal's `@` coordinates are on | `kill 69 map 1429 @45,40` |
| `era` / `live` | The map frame of this goal's coordinates, overriding `coords` | `goto 40,60 live` |
| `explore <x>,<y> ["Area"]` | Discover the map area at these coordinates | `explore 41,65 "Goldshire"` |
| `sethome "<Location>"` | Bind the hearthstone at an inn, named as the game reports it | `sethome "Goldshire"` |
| `sethome nearest` | Bind at the nearest inn of the player's faction | `sethome nearest` |
| `hearth "<Location>"` | Use the hearthstone; done on landing there | `hearth "Goldshire"` |
| `getfp "<Flight point>"` | Learn a flight path from its flight master | `getfp "Stormwind"` |
| `fly "<Town>"` | Take a flight; done on landing there | `fly "Stormwind"` |

`polestar find --kind inn` and `polestar find --kind flight` list the names
`sethome`, `hearth`, `getfp` and `fly` take.

## Quests

| Line | What it does | Example |
|---|---|---|
| `accept <quest> ["Title"]` | Take a quest; the giver and title come from the data | `accept 783` |
| `turnin <quest> ["Title"]` | Hand a quest in | `turnin 783` |
| `lvl <N>` | On `accept`: the level the quest needs, shown beside it | `accept 7 lvl 2` |
| `complete <quest> ["Title"]` | Finish every objective of a quest | `complete 7` |
| `npc <id>` | Which NPC gives or takes the quest, when the data knows several | `accept 5261 npc 196` |
| `object <id>` / `item <id>` | The same for a quest started or ended at an object, or started by an item | `accept 9400 object 1617` |
| `"<text>"` | Right after an id: the quest title, or the name of the NPC, object or item, for content missing from the data; after the modifiers: the text players see instead of the generated one | `accept 9201 "The First Step"` |
| `xp <N>` / `money <amount>` | On `turnin`: what it pays (`money 1g50s`, `7s` or copper) | `turnin 9201 xp 210 money 1s` |
| `choose <item> ...` / `reward <item> ...` | On `turnin`: the rewards to pick from, and the ones given outright | `turnin 5261 choose 159 2589 reward 4306` |
| `direct` | On `turnin`: handed in straight from the giver's window, with no `accept` (Distracting Jarven, the cloth donations). Buy or collect what it asks for with `buy`/`collect`: the quest never enters the log, so nothing tracks objectives for it | `turnin 9300 direct` |

## Killing and collecting

| Line | What it does | Example |
|---|---|---|
| `kill <npc>` / `kill "<Name>"` | Kill a mob; `quest Q.O` ties it to a quest objective | `kill 6 x10 quest 7.1` |
| `x<N>` | How many (kills, items, purchases, crafts) | `kill "Cloth Kobold" x5 @65,75` |
| `quest <quest>.<objective>` | Counts the goal by that quest objective, numbered as the quest log lists them (`quest <quest>` alone lets the data find it) | `interact 1617 quest 9400.1` |
| `collect <item> ["Name"]` | Gather or loot items; without `quest`, counted in the bags | `collect 750 x8` |
| `nearest` | On `collect`: the closest place mobs drop the item, by level and faction | `collect 4306 x10 nearest` |
| `interact <object>` | Click a game object | `interact 2843` |
| `use <item>` | Use an item | `use 1210 @47.6,35.1` |

## People, items and errands

| Line | What it does | Example |
|---|---|---|
| `talk <npc>` | Speak to an NPC | `talk 197` |
| `train class` | Visit the nearest trainer of the player's class | `train class only Warrior,Mage` |
| `train <npc>` | Visit that trainer | `train 911 only Warrior,Paladin` |
| `vendor nearest` / `vendor <npc>` | Sell and repair, at the closest vendor or that one | `vendor nearest` |
| `buy <item> ["Name"]` | Buy an item; `nearest` picks the closest vendor selling it | `buy 159 x5 nearest` |

## Professions

| Line | What it does | Example |
|---|---|---|
| `train <Profession> [Rank]` | Learn a profession or its next rank (`Apprentice`, `Journeyman`, `Expert`, `Artisan`) at the nearest trainer | `train Mining Journeyman` |
| `skill <Profession> <N>` | Reach skill N (quote names of two words) | `skill "First Aid" 40` |
| `learn <spell> ["Name"]` | Learn a recipe; from a trainer, or with `nearest` from the closest vendor of its recipe | `learn 3276` |
| `craft <spell> ["Name"]` | Craft a recipe, `x<N>` times | `craft 3275 x5` |
| `until <N>` | On `craft`: until the profession reaches N | `craft 3275 until 40` |

## Reputation and challenges

| Line | What it does | Example |
|---|---|---|
| `rep <Faction> <Standing>` | Reach a standing (`Neutral` to `Exalted`) with a faction, by name or id | `rep Stormwind Friendly` |
| `achieve <id> "Name"` | Complete an achievement or Legacy Challenge | `achieve 9001 "Kobold Catcher"` |
| `criteria <n>` | On `achieve`: one criterion of it | `achieve 9001 "Kobold Catcher" criteria 2` |

## Conditions

`race`, `class` and `only` take a comma list of names. Names in one group
match any of them; the groups must all match: `only Warrior,Paladin,Dwarf`
is a Dwarf who is a Warrior or a Paladin.

| Line | What it does | Example |
|---|---|---|
| `only <condition>, ...` | After a goal: the goal is only for matching characters | `kill 299 only Hunter` |
| `Warrior` `Paladin` `Hunter` `Rogue` `Priest` `Shaman` `Mage` `Warlock` `Druid` | Classes | `only Warrior,Paladin` |
| `!<Class>` | Every class but this one | `only !Hunter` |
| `Human` `Dwarf` `Gnome` `NightElf` `Orc` `Troll` `Tauren` `Undead` (or `Scourge`) `Skyborne` | Races; Skyborne plays on both sides | `only Dwarf,Gnome` |
| `Alliance` `Horde` | Factions | `only Alliance,Mage` |

## Route choices and optional steps

| Header line | What it does | Example |
|---|---|---|
| `next <id>, <id>, ...` | Several guides after this one: the player picks one, the first is your suggestion | `next joe-routes/westfall, joe-routes/redridge` |
| `pitch <text>` | On a guide offered as a choice: one line on its card | `pitch Short walks between quests.` |
| `pro <text>` / `con <text>` | One advantage or drawback per line, under the pitch | `pro Ends at a flight point` |

| Line | What it does | Example |
|---|---|---|
| `optional` | After a goal: the step can be finished without it | `kill 299 optional` |
| `group [N]` | After a goal: it needs a group (of N players, 2-40); the guide window says so. Elites, dungeon and raid quests are found from the data without it | `kill 299 group 3` |

## Handing over with `next`

| Header line | What it does | Example |
|---|---|---|
| `next <id>` | The guide that follows when this one ends: one of yours or one of Polestar's (`polestar find --kind guide <zone>` lists them with who can follow them) | `next joe-routes/westfall` |
