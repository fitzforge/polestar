# Profession guides: how they are built, and the rules they keep

Polestar's profession guides (`guides/forever/professions/`) are generated, never hand-edited:

| Guides | Built by | From |
|---|---|---|
| Alchemy, Blacksmithing, Enchanting, Engineering, Leatherworking, Tailoring | `node tools/polestar.js profession draft <Profession> --out` | its route file, `tools/lib/professions/routes/<profession>.json`, through `route.js` (see "Route files") |
| Cooking, First Aid | `node tools/polestar.js profession gathering build` | their route files through `route.js`, like the crafting professions |
| Mining, Herbalism, Skinning, Fishing | `node tools/polestar.js profession gathering build` | `tools/lib/professions/gathering/` |
| Herbalism + Alchemy, Mining + Blacksmithing, Mining + Engineering, Skinning + Leatherworking, Fishing + Cooking, Tailoring + Enchanting | `node tools/polestar.js profession gathering build` | `tools/lib/professions/pairs.js` over the two above (Fishing + Cooking: `pair-fishing.js` over `gathering/fish-rounds.js`) |

Every rule below is held by a test (`tests/profession-route.test.js`, `tests/profession-audit.test.js`,
`tests/profession-pairs.test.js`, `tests/profession-gathering.test.js`, `tests/profession-getit.test.js`)
or by the generator throwing at build time. A new profession guide, or a change to a generator, keeps all
of them.

## Route files

A crafting profession's route is curated, not planned: `tools/lib/professions/routes/<profession>.json`
lists the bands to craft and everything a first-timer needs around them, and `route.js` turns it into
the guide. Every fact in it is checked against data/forever when the guide is built; `checkRoute` stops
the build on any fact the data does not bear out:
a recipe that is not the profession's, a band's materials that are not its count times the recipe's
reagents, a recipe learned after its band starts, a band past the recipe's grey (unless `colours` gives
the colour players' recordings show), a trainer or vendor who does not serve the side or does not
train or sell the thing, a quest not in the data, a material with no way to get it, a recipe item with no
way to get it (vendors in `recipes`, a band's quest, or fork plans), a tool `tools` does not list, a
recipe that needs a camp-only station (Spinning Wheel, Loom, Tanning Rack, Sewing Machine: no town has
one, so no step could lead a player to it), a rank book or quest the data does not give that rank.

| Field | What it holds |
|---|---|
| `profession`, `intro` | The profession's name; the header's paragraphs |
| `tools` | `{ item, at: "learn", vendors: { Alliance, Horde } }`: a tool bought on the first trainer visit; the vendors are the ones by each trainer (checked; the step itself takes the nearest seller). `{ item, at: "craft" }`: a tool the profession makes itself (Arclight Spanner, the runed rods); a band or make crafts it before the first recipe that needs it, or the build stops |
| `recipes` | recipe item -> `{ Alliance: [vendors], Horde: [vendors], note? }`: patterns, formulas, schematics, cookbook recipes and manuals vendors sell (checked: each sells it and serves the side; both sides need one) |
| `sections` | One per rank: `{ rank, from, to, level, cost?, teachers: { Alliance, Horde }, route }`. `teachers` are the trainers who teach that rank's recipes: the trainer a player starts with teaches only the first ones (Blacksmithing: up to 50), and a recipe may be taught by fewer trainers than its rank (Mithril Coif: Brikk Keencraft only). A rank from a book: `by: { book, vendors: { Alliance, Horde } }` (`level` is the route's: the data's is Classic's); from a quest: `by: { quest: { Alliance, Horde } }` (`level` is the quest's). A rank only a trainer inside a dungeon teaches: `dungeon: true` (or the dungeon's name), with `outside: { Alliance, Horde }` when someone outside trains it too |
| band | `{ from, to, recipe, count, mats, keep?, note?, quests?, alternative? }`: craft `count` of `recipe` from `from` to `to`; `mats` is item -> count (checked); `keep` and `note` are its one-line tip; `quests` hand over its plans (their items join the get); `alternative` is another recipe for the same points, kept for reference |
| make | `{ make, count, mats, for }`: parts crafted for a later band (no skill points) |
| fork | `{ fork, ways: [{ name, plans?, why?, route }] }`: from here the route goes one of several ways; a way with `plans` (world drops) is taken when the player buys them at the Auction House, the last way is the one that always works |
| `materials` | item -> its ways in order: `gather` (the gathering guides' loops; a bar: its ore's), `drop` (farm spots), `disenchant`, `vendor`, `auction`. A material listed here is got, never treated as one of the route's parts even when a recipe of the profession makes it (Mote of Magic) |
| `vendors`, `smelt`, `colours` | Who sells a vendor good (checked); a bar's smelting extras (Coal for Steel, from a Mining skill); a recipe's grey where recordings show the client table is wrong, with the evidence |
| `taught` | Recipes the data marks as from an item that trainers teach (Enchant Boots - Minor Stamina): learned from the section's teachers |
| disenchant band | `{ disenchant: true, from, to }` (Enchanting): disenchanting the green items in the bags first, since each gives a point below 20 and fewer up to 60; the crafts after it carry on from wherever it leaves the skill |

The steps, one action each, each answering on its own what to do, where (a place the arrow and the map
pin lead to, or any station with the nearest pinned), how many, and what finishes it:

- **Learn <Profession>** (`train`), then **Buy a <tool>** (`buy … nearest`).
- **Get N <material>**: one material, its ways as the window's choice rows; sized to the crafts up to the
  next trainer visit (bands of one material that only a recipe visit separates share it). A fork way's
  steps and every band have their own section, so a get's count is what the bags must hold.
- **Buy N <vendor good>**: a section's vendor goods at one stop.
- **Train <Rank> <Profession>** after the first gets of its section (one trip trains it and learns the
  first recipe); **Learn <recipe>** (`learn <spell> npc <the section's teachers>`, or from plans in the bags).
  On that visit the player also learns every recipe a later band of the rank uses that the skill already
  allows (outside forks), so no recipe takes a second trip that the first could have taught.
- A rank from a book: **Buy <book> · <vendor>**, then **Read <book>** (`train <Profession> <Rank>`); from a
  quest: **Get N <item>** for each item the quest asks, the feeder each side's trainer hands out (**Accept** and
  **Hand in** it: the data shows the quest only after it), then **Accept**, **Complete** (an event or kill
  objective; `by.tip` is its heads-up) and **Hand in** the quest; inside a dungeon: **Go to <dungeon>** (its
  busiest entrance) and **Train <Rank> <Profession> · <trainer>** with a grouping heads-up, or, when someone
  outside trains it, **Train <Rank> <Profession> · <outside trainer>** per side.
- **Buy <Pattern: X> · <vendor>** (`buy <item> x1 npc <id>`, or `nearest` over several; one step per side
  where the sides' vendors differ; `when !knows <spell>`) on the trip before the band that needs it, then
  **Learn <recipe>** from the pattern in the bags.
- **Go to an anvil** (`goto … nearest` over the stations of the recipe's spell focus, `stations.json`, in
  towns with a trainer or tool seller), before a craft that needs one unless the step before was a craft
  there; the engine finishes it on arrival at any of them. A cooking fire's step is also finished by placing a
  Basic Campfire Kit (`use 279981 either` beside the fires, each `either`).
- **Disenchant your green items until N** (`skill … either` beside `task "No green items left to break" either`).
- **Craft N <recipe> until <skill>**; **Craft N <part>** for parts, and for a tool the profession makes.
- **Buy <plans> at the Auction House** (`auction … either` beside a "none listed" task; plans two ways share
  are bought once), **Hand in <quest>**. A fork way holds while all its plans are known (or, learned later,
  in the bags) and no earlier way does; a way whose plans are a subset of an earlier way's (Radiant Boots
  without the Radiant Leggings) comes after it.

Tips are at most one short line (120 characters) of why or a heads-up ("Keep all 60: the bracers at 95 and
115 use them"), never an instruction: an action is a step or a goal. Costs and totals go in the header.

## Profession guide rules

1. **Every material has a Get it way.** A material the Auction House sells is written both ways (a
   `collect … gather` and an `auction`), so Gather, Buy and Mix all work (docs/GUIDE_FORMAT.md,
   "Materials"). A mob drop is a `collect … nearest` farm the engine picks by travel plus the time to
   finish there at the player's level, never among mobs two or more levels above, picked again on a zone
   or level change. A long farm reads as what it is ("most of it drops as you level 15-30, or the Auction
   House"), never as thousands of kills.
2. **Loops.** A farming loop's `lvl` is its strongest creature: never a placeholder ("lvl 2" among
   level 15-55 creatures, "lvl 9999"), never a creature above the player that another loop avoids. Loops
   are offered per zone and picked where the player stands (the window's "Other" for the next), with a
   lap a player can walk (rounds are capped; a 12 km lap is a bug), and zones are ranked by what stands
   up at once at a level the band allows (a zone with three times the Mithril beats a nearer, thinner one).
3. **Material maths.** Intermediates made for points are counted once and used later (bolts, bars, cured
   hides, powders: plan.js `later`). Gathered and dropped materials are counted for 9 players in 10;
   bought goods at the expected crafts. A stretch asking for more than 300 of one material is a flag:
   the cheaper path wins. Recipe colours come from the client's tables; a recipe choice that players'
   recordings contradict (what they actually crafted at that skill) is looked at again.
4. **Trainers.** One trainer per side for each bracket of a rank few trainers teach, no city hopping; an
   intermediate's recipe is learned on the visit before its material first appears (Bolt of Silk Cloth
   with the shirts at 104). Every pinned trainer or vendor serves that side and teaches or sells the
   thing; a new Forever trainer is added only where recordings show players training there.
5. **Honest forks.** Where one way cannot finish (Blacksmithing at 250: the plans from Magnus Frostwake or
   the Auction House; Tailoring past 265), the route forks with a `when` per path, and each path reaches
   300 or its last step says what is left and why.
6. **Specialisations at the skill the data asks** (Armorsmith/Weaponsmith, Gnomish/Goblin,
   Dragonscale/Elemental/Tribal at 225), and the cheapest start the data allows (Light Leather from
   Ruined Leather Scraps for Leatherworking 1-20).
7. **Gathering and crafting blend** (the paired guides): the arrow stays on the loop while gathering (a
   gathering step's loops are its one target); a gathering step holds until the next crafting stretch's
   materials are in the bags; a crafting step comes only after the steps that supply its materials (or
   the player chose to buy them); level gates are asked once.
8. **Why lines.** Every Get it and gathering step leads with its count and what it is for ("57 Wool Cloth
   for Tailoring 75-150: 40 Woolen Capes"); a paired step adds what the gathering on the way already gave
   ("from your skinning on the way: 40 of 60").
9. **The guide window.** Profession guides are `kind profession` (no XP or pace, no hand-in rows); a
   paired guide names both skills in `skills` (gathering first) for two skill bars; a step gated on a
   level says so ("step 31 needs level 35 (Artisan …)").
10. **Audit before shipping.** The audit's band and loop checks and the guard tests run on every
    profession guide, the paired ones included: no MUST finding, lint clean, the playtest of both factions
    without a stuck step.

## The paired guides (pairs.js)

The core rule: each crafting stretch is one cycle. A gathering loop sized to the next crafting batch
(which also raises the gathering skill), then that batch crafted from what was just gathered, and both
professions' ranks trained on one visit when both are due.

- **Sources.** The crafting side is the crafting guide's draft (its plan, steps, trainers, forks and counts),
  the gathering side the gathering guide's plan (bands and loops). Nothing is re-planned: a fix to either
  single guide reaches the pair on the next build.
- **Sizing.** For each crafting stretch the materials the gathering side gives (herbs; leather; ore and
  stone, bars counted as the ore they are smelted from) are what the stretch asks for, less what earlier
  gathering left in the bags. How far the gathering skill rises on them is the gathering guide's own
  numbers: skill-ups per node on the band's loops and what players' recorded gathers gave per node.
- **Steps.** A gathering step's loop target is the stretch's main material (`collect … gather` with `yield`
  loops of the band the skill is in); the other materials are bag counts (`anywhere`), each with its
  `auction`. When the next stretch needs a tier the skill cannot gather yet, catch-up steps (a `skill`
  goal on the gathering guide's loops) come first; a floor step guards each change of band. Counts are
  cumulative within a crafting section, as the engine's section counts expect. The gathering skill
  reaches 300 before the last crafting stretch (a section the crafting skill has passed is done).
- **Trainers.** A gathering rank or smelt that falls due is trained at the next crafting trainer visit
  (one trip); otherwise it gets its own step where the gathering guide trains it. The smelts a bar needs
  are learned before the stretch that smelts it.
- **Tailoring + Enchanting** flows the other way: both guides are built from their route files and kept as
  their steps are; each rank bracket runs Tailoring's steps, then Enchanting's. Learn Enchanting comes with
  Learn Tailoring, an Enchanting rank with the Tailoring rank of the same bracket (one trip; Annora's keeps its
  own), Enchanting's disenchanting step stays after its rod, and Tailoring's last fork comes after
  Enchanting 225-300 (a way may stop short of 300). Each Enchanting get of a dust or essence says how much the
  bracket's own Tailoring greens give when disenchanted (`data/disenchant.json`: the client's disenchant bands
  with the server's loot; `tailoring-item-levels.json`: the client's item levels); the rest is looted or bought.
- **Fishing + Cooking** (`pair-fishing.js`) is blended the same way. Its track is the Fishing bands
  (`gathering/fish-rounds.js`): per band and faction, every water of the side that gives the band's fish
  as a farming loop of its stands (where players stood when they caught fish, `fishing-waters.json`), a
  catch its node; the arrow takes the one water that gets the fish soonest, travel included. A stand is
  left out near a hostile creature above the band's level (an elite counts three levels higher), the other
  faction's towns and guards (an NPC of a side at level 50 or more with three spawns on the map) and boat
  docks; a loop's lap adds 20 s for each hostile creature by a stand that is not grey to the loop's level
  and three minutes for each death recorded within 30 yd of a stand, per catch, so the quieter water wins
  a close call. Its draft is each band's `cook` stretches (per stretch the first of its recipes whose fish
  the band's water gives or the bags hold: Brilliant Smallfish or Slitherskin Mackerel to 50 in the starting
  areas, Longjaw Mud Snapper to 100 in the capitals to Fishing 130, Bristle Whisker Catfish to 175 on catfish
  water to 205, Mithril Headed Trout to 225 on trout water after Nat Pagle, then in Feralas to 300 the kept
  trout to 250, Filet of Redgill to 285 and Nightfin Soup), cut into the Cooking ranks' sections; where the
  starting areas' fish differ, each group's stretches are a variant (`variant <only>`: the same state for
  each, the least of what they leave after). Fishing's ranks are their own steps (Journeyman at a trainer
  from level 10, Expert from its book, Artisan from Nat Pagle). It has no skill floor steps between bands.
- **Header.** `kind profession` and `skills <Gathering>, <Crafting>`; a paired guide's sections alternate
  between its two skills, each rising in order (lint checks each profession's order on its own).
- **The Materials way.** A material a paired guide gathers itself (`collect … gather` beside an
  `auction`) is gathered by default, whatever Options' default for new guides says: the guide is there to
  level the gathering skill too. Mix's per-item pick (Buy) and Buy all still buy it.
