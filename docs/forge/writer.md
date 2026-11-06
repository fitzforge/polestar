# The writer

The writer turns a route into guides. A route is the simulator's improved
quest order for one start (see [routes.md](routes.md)). The writer puts that
order into v1's guides, the current guides Polestar ships. It keeps v1's own
lines, tips and layout wherever it can. The result is a normal guides folder.
The compiler lints it and builds it into the addon's pack, and the judge
compares it with v1 (see [judge.md](judge.md)).

The writer is the `forge-writer` crate (`rust/crates/forge-writer`). It runs
as `forge writer apply-route`, and `forge build` runs it as its `guides` stage
for every start. The compiler is `forge-guide` (`forge guide compile|lint`).
See [FORGE.md](../FORGE.md) for the whole pipeline.

## Written for how Polestar plays

A route is only as good as the way the addon plays it, so the writer writes for the engine
(`addon/Polestar/Core/Engine.lua`, [GUIDE_FORMAT.md](../GUIDE_FORMAT.md)):

- **One area, all its work.** Quest objectives count from the quest log wherever the mob dies, so
  work on the same ground (plainstriders, raptors and zhevra across the northern Barrens) is one
  step. In a step with several field goals the arrow leads to the first open one in written order,
  so a merged area is written with `loop`: its gotos become one search circuit for every goal in
  the step.
- **On the way.** A long leg that passes an open objective's spawns gets an `along until <label>`
  step for it (up to six listed at once; only goals the game counts anywhere: quest kills,
  collects, interacts and uses, bag counts, accepts and hand-ins).
- **Pick up what you stand next to.** A quest open at a giver the route stands at is taken there,
  and its work goes with work on the same ground (the planner's `join` and pickup pass).
- **No pointless trips.** No step sends a player somewhere to do nothing, twice to the same place
  for one visit's work, or back to a place just left.
- **One sweep per hub.** A town or camp is walked once from the side you come in to the side you
  leave by, each NPC once, with everything ready there done there; a giver or ender with something
  ready beside the road is visited on the way (the hub tour below).

`forge judge check` holds every build to these (`merge`, `along`, `arrow-order`, `next-to`,
`dup-trip`, `bounce`, `hub-order`, `walked-past`, `left-ready`).

## What goes in

| Input | What it is | Default |
|---|---|---|
| route | `<start>.json` from the routes stage: `faction`, `start`, `dataHash`, `order`, `diff.added`, `diff.dropped`, and v1's and the improved hours | required |
| world | `world-<faction>.json`, the simulator world whose point ids the route uses | required (`--world`) |
| walk store | `walks-<faction>.bin`, walking yards between world points (around hills, not straight lines) | beside the world file |
| v1's guides | a guides folder holding `forever/` | `<root>/guides` |
| game data | `quests.json`, `npcs.json`, `objects.json`, `items.json`, `zones.json`, `map-frames.json` and the compiler's data | `<root>/data/forever` |
| fix records | `data/places.json` (arrow points, roads, objectives' own lines) and `data/guide-fixes.json` (tips, level gates) | `<checkout>/data/` (`--checkout`, default `--root`) |

Each `order` item is one event: `t` is `accept`, `turnin`, `task` (work on an
objective), `train`, `level` (with its fractional grind `target`) or `ride`
(riding training at the trainer `npc`). It also has the quest `q`, the world
point `pt`, the level `lvl` before the event, the travel `items` that lead to
it (walks, flights, rides, hearths, binds, flight paths), and `from`. `from`
is the v1 line the event came from (`guides/forever/....guide:LINE`),
`inserted` for a quest the route added (or a riding trainer v1 has no line
for: a `Riding trainer` step, or a grind top-up), or `train stop` for an added
training stop. A `level` line is written at its `target`. A top-up the route
inserts (a `level` item with no v1 line, at the point the planner chose: after
the work at a camp, before a hub's hand-ins; `min` its model minutes) is a step
of its own there, which a player already at that level skips, unless (with
route travel, after the area steps are made):

- the step right before it works quest objectives for everyone: its `level`
  line goes into that step, and the player kills on there until the level;
- a top-up step was kept before it in the zone stay, with no flight, hearth or
  boat between: the two become the later one, when the earlier gates no accept
  and the two come to at most 15 minutes (right after one another, always);
- it is under 5 minutes and gates no accept: its `level` line goes into the
  next farm step of the stay (within 8 steps), else it is left out (quest XP
  mostly covers it, the rest goes to the next top-up).

The planner's accept level rule (routes.md, "accept gates") puts such a top-up
right before an accept the route would take under its quest's minimum level
when no later stop by the giver comes at that level before the quest's work. It
gates that accept, so the rules above never fold it away or leave it out, and
its tip names the quest (`tip Top up here to level 3: Lazy Peons, at <area>,
needs level 3.`).

c14's Human route wrote about 90 `Level` steps, one per piece of each split
grind, before this.

The route's `dataHash` must equal the world's. A route found on one world uses
that world's point ids, so the writer refuses a different world.

## The shipped layout

v1's leveling guides are laid out like this, and the writer keeps the layout:

- **Start guides** belong to one start's races (`race Orc,Troll`) and live under
  the race's folder, for example `forever/horde/orc-troll/01-durotar.guide`.
- **The shared chain** is the faction's guides with no `race` header, for
  example `forever/horde/02-the-barrens.guide` to `07-ashenvale.guide`, then
  `30-40/`, `40-50/` and `50-60/`. Every race of the faction plays them.
- **`next`** links each guide to the one after it. A start's last guide hands
  over to the shared chain. The writer follows v1's `next` lines to find the
  chain, and changes them in one case only: a start's own guide just before
  the shared chain that has no line of the start's route (Orc and Troll's
  `orc-troll/02-the-barrens`, whose quests the shared route takes in the
  shared guides) keeps only its class steps and class lines (the shared guides
  do not carry those races' class chains); with none, it is left out of the
  written guides and the guide before it hands over to the shared chain, with
  the start's arrival at its end.
- **A shared guide in a start's own part.** When a start's route plays a
  shared guide before the join (Night Elves do Darkshore to about 14 as part
  of their own start), its run's writing of that guide becomes one of the
  start's own guides, `<start folder>/<NN>-<stem>`
  (`forever/alliance/nightelf/02-darkshore`), with the start's `race` header,
  between the start's guide before it and the join guide. The shared guide
  stays the same for the other starts.
- **`train class`** sends the player to the nearest trainer of their own class,
  picked by the addon at runtime. A route's training stop is written as a step
  `Class trainer` with `train class`, unless v1's next steps train there anyway
  (not past an added quest's event away from the stop: Korran at the Crossroads
  between the Orgrimmar training and Regthar, c19p, trains in Orgrimmar first).
  One trainer visit per route training: v1's own training steps the route did
  not place, in the events after it up to about a level and a half on, come
  with it (Orgrimmar for most classes, Thunder Bluff for Druids and Paladins),
  on the trainer's continent, and a step with other work than training only
  from the trainer's own town (the Druids' Heeding the Call stays at Dolanaar);
  the route's own line is then only for the classes they leave out. Those steps
  are at the stop: the route's way on leaves after them, and classes flown off
  to their own trainer fly on from there to where the way on's flight lands,
  the others' way `only` theirs (Orgrimmar -> Thunder Bluff -> Crossroads for
  Druids and Paladins, not back to Orgrimmar first). A v1 step
  that only travels to a trainer and trains, left over where the route plans
  its training elsewhere, goes. v1's training line the route trains by in
  another city (its Stormwind trainer for v1's Ironforge line) is written at
  the route's trainer when the rest of v1's step is the route's elsewhere.
  At a route training stop in a town with no trainer for some classes (Razor
  Hill has no Mage trainer), those classes train at the route's next pass by
  one of theirs within a level and a half (Sen'jin Village), else as before;
  a class that trained at most two levels before gets no trip of its own from
  there (the Rogues and Warlocks at Thunder Bluff at 28.7, trained in
  Orgrimmar at 26.8). A stop where the route already stands (within 300 yd)
  reads the zone the step before named (Thunder Bluff's Shaman stop is on
  Mulgore's map, and said Mulgore in the city), and a class trained once in a town
  visit (no flight, hearth or goto step between) is not trained again there
  (the route's Shaman stop, then v1's Spirit Rise step).
- **Riding at 40** (`post::riding_at_level`, on the guides as written, the travel repair's ways
  and the adopted shared guides included): a step that trains at a riding
  trainer (the data's "... Riding Instructor" or "... Riding Trainer", the
  Gnomes' "Mechanostrider Pilot") holds only from level 40 (`when level>=40`):
  the planner plays riding at 40 or later only (c19p: 42.5 to 50 in every
  start's model, about 43 in the check's walk), but a player can be behind the
  model; so does a "Riding at 40" step with notes alone (the Skyborne's, whose
  trainer is on Zephras Isle). A riding line in a step with other work goes
  into a "Riding at 40" step of its own right after it, with the step's `only`
  and zone. The way there and back for its characters is gated with it: the
  travel-only steps right before it with its `only`, and right after it, else
  further on up to everyone's next step the travel-only steps of theirs or of
  some of their classes, past steps for other races or for some classes of
  every race (the Taurens' flight back to Gadgetzan after the Undead's and the
  Druids' trips; the Undead's ways back from Brill, the Paladins', the
  Warlocks' and the others'); with no way back before everyone's next step
  (the Humans' walk to Eastvale), the way there alone: under 40 they stay with
  everyone. A step between for theirs and another race's, or another step of
  theirs that is not travel, leaves the riding step as it was: gated alone it
  left them where the way there ends, and the next way failed.
- **Route fixes' optional quests** (`post::optional_by_fixes`, the guides as written): each goal
  line but the hand-in of a quest `deliberate.optional` lists (the rare-drop chains: The Green
  Hills of Stranglethorn and its chapters, Study of the Elements: Rock) is written `optional`, so
  no step waits on the drop; the hand-in applies only to a player who has the quest done.
- **Weapon skills** (forge-writer `weapons.rs`, #655): where a guide already
  stops in Stormwind, Ironforge, Darnassus, Orgrimmar, Thunder Bluff or
  Undercity at level 10 or later, each class with a weapon skill that city's
  weapon master teaches gets a step after the last step it plays there beside
  the master (within 60 yd), else after its last step there (before
  it, when that step ends on the way out; Ansekhwa after Eyahn on Thunder
  Bluff's central rise, not after Elder Rise and back): `train <master>` with
  `when money>=10s` (Polearms `when level>=20`, `when money>=1g`) and
  `when !skill "<Skill>" 1`, so a character who cannot pay, starts with the
  skill or learned it earlier never sees it. Warriors: Two-Handed Axes, Maces,
  Swords, Polearms; Paladins: Two-Handed Swords, Axes; Hunters: Staves,
  Polearms; Rogues: Swords; Priests and Warlocks: Staves (Forever's trainer
  data: Sayoc teaches no Staves, Ansekhwa no Guns). Each skill once per class
  in a start's own guides and once in the shared guides; a visit only some
  races make offers it to them, a later one to the rest. The level is the
  route's at the quests everyone does there; never a trip of its own.

A shared guide is played by every race, but a route is for one start. In a
shared guide the writer marks its changes `only <the route's races>` and leaves
v1's lines for the other races. A hearth the route's races are not bound for
goes for them. For everyone else v1's line stays. Two lines for complementary
race lists become one line for everyone.

A route of the faction's shared route (`shared` in the route) is the same for
every start from its `joinAt` guide on (the Barrens, Westfall: a guide stem in
any folder). The shared guides whose route steps all come at or after that
guide's first step are written for everyone, the same for every start.

### One shared route

With the route's own legs (`src/shared.rs`), every start of a faction gets the same shared guides,
byte for byte, as `forge guide publish` needs: one shared route per faction. The writer reads the
faction's routes beside the one it writes (`routes/<Start>.json`, the same `shared.canonical`) and
builds one shared order:

- the canonical start's tail from `shared.joinStep`, its events in its own race guide moved to the
  same line of the shared guide (Orc and Troll's own Barrens guide ends at the Crossroads at 12), an
  event with no such line written as an added one;
- every other start's quest events after the shared event they follow there, without their travel,
  when they stand within 400 yards of the shared events around them. A quest a start carries in
  from its own guides whose shared-route events need a detour is left out for that start (the log
  names them: the planner's to put on the shared route). An event whose later chain event (same
  quest or same group) already stands earlier in the shared order goes no later than that one: at
  the last slot back from there where the player stands at a shared accept or hand-in beside its
  place, never before a shared hand-in its start made before it (Alba's Testing the Wells at the
  first Sentinel Hill stop beside Scout Galiaan, not after its own vials; Tauren's Monogrammed Sash
  before The Captain's Cutlass another start's route added, c18g). Nearness is judged where the
  chain puts an event; where starts disagree on an event's slot, it goes where most of them have
  it (ties: the earlier start), and each start's own chain is kept in order around that (Testing
  the Wells handed in after Blanchy's oats, as the Dwarves, Gnomes and Skyborne have it).

The canonical start's run on that order writes the shared guides, its travel repair and engine
passes included (the chain they play runs on through the start's own guide the route has no line in
any more, Orc's own Barrens guide, to the shared ones); each start's run writes its own guides on its
share of it and takes the shared guides from the canonical run. A quest only some
starts do there, or one the data's race mask closes to some races, gets `only <their races>` (added
to a line's own classes); a line of a quest ahead of its accept on the shared chain, or of one some
starts carry in, goes to a step `when onquest Q`. The travel steps that open the join guide go to the
end of the start's own last guide; a start's own way to the join (its hearth, the zeppelin's tip)
is its own route's, not the canonical start's, and leads to the shared order's first event, wherever
the start's own first shared event falls (the Gnomes' tram leads to the Jansen Stead, not to Ozwin at
Saldean's Farm after the walk in). That way is written at the end of the start's own guide, before
v1's steps waiting there for a place it passes, which it takes at their places along it, the flight
paths it walks by learnt there first (the tram to Stormwind, Stormwind's flight master, the class
quests there, the Mages' Mirror Lake on the walk on to Westfall).

Each race's and class's own way is written for them alone: the shared guides are played as every
race of the faction (from its v1 start guides on; a v1 start-guide step whose quest lines the shared
guides now have learns no flight path there, as the shared guides learn it: Orc and Troll's Ratchet,
c18g), and as each class some shared line is `only`, and
each travel failure (the honest playtest's R1) gets that player's way, `only <race>` or `only
<race>,<class>`, as the travel repair writes it; a travel line that is not theirs is `only` the
others. For a class's way the others include its races' other classes: a line the Orcs alone see
becomes `only Orc,!Shaman` for the Orc Shamans' way, and a line others see too stays theirs on a
line of its own beside it (`only Troll,Tauren,...`); such lines side by side with the same classes
are then one line for all their races. `only` lists are read one way everywhere, the writer's
repair and the judge alike (`forge_guide::conditions::Audience`: races, classes and factions each
one-of, all three together, `!Class` every class but that one). A race's riding trainer or the Undercity zeppelin for one race's quest is never everyone's
walk. In a run of such travel steps, the same step for several races with the same classes is one
step `only` all of them, and a step for every race is everyone's. Travel steps alike but for their
audiences (the step's `only` and the goals' own) whose audiences together are every character of the
faction are one step for everyone, at the first one's place, else the last one's, when no character
passes a step of its own on the way (the per-race and per-class copies of one Tirisfal goto and
zeppelin out of the Eastern Plaguelands). The starts are played twice when the first pass wrote ways,
so a start played before another's way changed a line it plays is played on it again; and on a
shared guide a flight from no flight master is repaired even where the start's v1 breaks there too
(the Dwarves' `fly "Astranaar"` from Maestra's Post).

`forge build` writes a faction's starts at once (the routes stage's written check, the guides
stage) with one `native::SharedCache` per faction: the canonical start's run, the races' and
classes' ways on the shared guides and the walk store are made once, by the first start that needs
them, and every other start waits for them instead of making them again (the canonical start
claims its run before it makes it, so the other starts' own runs go on beside it). Each is kept by
its exact inputs, so every start's tree is the one it writes alone.

## How it works

### 1. Read v1's lines, typed

Each guide is read as a header plus steps. Each step line is typed by its first
word (`src/guide.rs`):

| Kind | Head words | Split rule |
|---|---|---|
| goal | `accept`, `turnin`, `complete`, `kill`, `collect`, `goto`, `talk`, `interact`, `use`, `sethome`, `hearth`, `getfp`, `fly`, `train`, `buy`, `vendor`, `level`, `note`, `skill`, `learn`, `craft`, `rep`, `explore`, `achieve`, `die`, `enter`, `equip` | moves with the route |
| every piece | `only`, `when`, `zone`, `loop` | repeated on every piece of a split step |
| first piece | `tip`, `label`, `along`, `image` | kept on the first piece only |
| other | anything else | stays with its step |

Every line keeps its exact text and where it came from (file and line). The
writer moves v1's lines; it does not re-render them. That is why its output can
be compared byte for byte with the old JavaScript writer.

### 2. Put the goals in the route's order

- **The hub tour** (with route legs, `src/hub.rs`) first walks each town or camp the way leveling
  guides players trust do (#736, #737, #739, #740). A hub is the route's quest NPCs linked within
  120 yd. On a walk between two events, a giver or ender with a ready accept, hand-in or talk within
  50 yd of the straight leg is visited on the way (Simmer's Fields of Grief between Calvin and Gordo).
  At each visit to a hub, the hub's later accepts and hand-ins that are ready join it, and so do its
  talks the route comes back for after leaving (200 yd away): Dillinger's A Putrid Task with Holland
  and Zygand, Aramis' A Light in the Darkness on the way back from the cave. Ready is an accept on
  level (in a start zone a level over its minimum: the model runs ahead of real play there, Gordo's
  Task) with every prerequisite handed in, taken by the route within 1.5 levels (1 on the way), or a
  hand-in with every task done; never ahead of an event the route fixes' `deliberate` or `overrides`
  `pairs` put before it, and a hand-in taken on the way never ahead of a hand-in such a pair puts
  first (Testing the Wells after Blanchy's oats, c18g). A hand-in the route comes back for after
  leaving, at an NPC outside the hub but within 200 yd of where the visit stands, joins the visit too
  (Ozwin's isosprings at the Saldean's Farm stop, 160 yd off, not after the walk to Furlbrow's and
  back, c19), unless the route comes back to that NPC later anyway. A task done with an item at a hub NPC's own spot (within 10 yd: Kaga
  Wildhoof's campfire, Gremlock's cooking lesson) is part of the visit. Then the visit's NPCs are
  walked in the shortest order from where the route comes in to where it goes next, each NPC once
  unless the quests' own order makes a second stop shorter, the pairs kept; a delivery whose item runs
  out within 15 minutes (the Scalding Mornbrew) is handed in first. A bind goes with the visit's event
  nearest the inn. Events move only earlier and, but for the next rule, only among one v1 guide's
  events; a line a class's own
  step waits for goes last in its visit, after every stop that does not wait for it, so the class
  step closes the visit (Perrine's Chest after Brill's turn-ins); a hearth or flight stays the
  visit's way in. A visit of other starts' events alone (their quests in the shared order) takes
  nothing: Scout Galiaan's hand-in stays at the Humans' own Sentinel Hill stop, not at the Dwarves'
  stop for Alba's vials. **Ready where the travel leaves you**: before that, at the flight master a
  flight of the route leaves from, and where a flight, a deathskip or a hearth lands the player when
  the event it is for is more than 120 yd away, each hand-in ready then at an NPC within 120 yd of
  that spot, which the route comes back for only after leaving, is done there (from any guide of the
  chain): before the flight, or on landing, the travel going with the first of them, and with them the
  follow-ups they open at the same NPC, however much later the route takes them (Sen'jin Village's
  hand-ins on the deathskip's landing before Kolkar Crag; Nathaniel Dumah's beside Chillwind Camp's
  flight master before the flight to Southshore, with A Plague Upon Thee's second part, c19). The
  log names each moved event (`hub tour: ...`).
- **The chain** is v1's: from the guide holding the route's first line, through
  each guide's `next`.
- **Steps split.** v1's goal lines go in the route's order. Consecutive lines
  of one v1 step stay one step. A goal line the route does not name goes with
  the next line of its step that the route names (NPC lines between two named
  lines the route does in the other order go with the one it does later: the
  class scrolls and training between Sarvis' Rattling the Rattlecages and
  Elreth's The Damned stay with Sarvis); a collect of an item that a
  named kill of its step drops goes with that kill (the Warlocks' Rattlecage
  skulls with Rattling the Rattlecages, #345), when the route takes its quest
  before it. An optional line the route does not model goes after the step's
  first piece; an optional collect, after the piece nearest where its item
  drops; an optional accept or hand-in, after the route's last piece nearest
  its NPC, never between two lines at one NPC (Clavicus' cloth donations, c16
  Stormwind). A step with no named lines
  goes whole before the piece holding the next named line (for a class's own steps, the line of
  that step the route does first). Such a step far (more than 300 yd) from the town visit it
  would split, with a stop of that visit after it, goes after the visit's last stop, with the
  steps of its kind written after it (the Shamans' flight to Islen and hearth back; Dokimi's
  crates between two Ratchet stops), not past one of its quests' lines nor the route's travel. A
  v1 step that only buys what the route buys at a line of its own, or only learns a flight path
  or binds (not a guide's last step), is not written. A guide is not cut between two pieces at
  one place with no travel between (it costs four pieces left out of their guide). A later piece the
  route works more than 400 yd from the step's first piece is named for its
  own area (else its target), not for v1's place. A piece titled for an NPC
  of v1's step that none of its lines is at, its first line at another NPC,
  is named for that NPC (Deputy Willem's accept, not "Eagan Peltskinner").
  Pieces of the same place
  that end up next to each other become one step, unless the first travels on
  or is for some characters only, or the second has a tip, label, condition
  or zone of its own. A first piece that ends with v1's boat or zeppelin goto
  still joins; the goto goes last, after the town's last piece. With route
  legs, within one town visit (300 yd, no travel between), a training whose
  classes a later training of the visit covers goes: one training stop per
  visit, the later one.
- **Added quests** get their own steps where the route puts them:
  `accept Q` at the giver, each objective once at its first task, then
  `turnin Q`. If v1 treats the turn-in as optional, the work for it is
  `optional` too. An added quest whose items have no source in the world is
  not written, and the summary names it.
- **A goal worked at v1's optional line** ("kill them on the way"), whose
  required line v1 writes later, is required at the route's line: the later
  line is written once only (Mazzranache's four parts, all optional at the
  route's work and the finishing step gone).
- **Dropped quests** lose all their lines. A quest v1 offers only after an
  optional start the route does not take is kept, for the player who finds
  that start.
- **Guide boundaries** go where the fewest lines land outside their own v1
  guide. Each guide keeps its header. A piece in another zone gets a `zone` line.
  A piece the cut moves out of a shared guide into a guide only the route's
  races play keeps a copy at the start of its own guide for the other races
  (`only <them>`).
- **Tasks the guide leaves to the turn-in** (a bag hand-in, an item with no
  source): their travel goes on to the route's next event, which is reached by
  way of it. A task index the world has no objective for writes nothing.
- **One leg per route event.** An event whose task is several objective lines
  takes its travel with its first line; the others follow there, not after the
  same leg again (The Hammer May Fall's ogres and Boulder'gor).
- **The header** reads the route, not the seed. `levels` is the route's level where the guide
  begins to where it ends (the highest level reached by then, a grind's target too), each rounded:
  a start's own part of a zone the shared route visits later (the Night Elves' Darkshore) reads
  12-14, not the shared guide's 16-21; a guide with nothing of the route's reads the level it is
  played at (Troll's class stop at the Crossroads, 12-12). The shared guides read the canonical
  start's levels. A short comment says Forge's route search and guide writer made the guide and
  where fixes go (data/route-fixes.json, data/guide-fixes.json, forever-db corrections), with the
  quests added and left out there. The seed's notes above the first step, which describe how the
  hand-made guide was put together, are not written; its section rules are.

### 3. Fix-ups (`src/post.rs`)

- An item that runs out (a timed item) keeps its chain together: events between
  getting it and handing it in move after the turn-in. When the getter is a
  task of the spender's own quest and the route passes its place (within 300
  yards of the straight walk) on the way to the spender's next events, the
  getter goes there instead (Kerlonian's chest, its horn good for 25 minutes,
  taken where the route escorts him, not at 19 with a walk back).
- An item-started accept goes right after the step that collects the item.
- A line that works or hands in a quest the route does not take, and landed
  before its accept, moves to right after the accept (a hand-in, to the next
  step by its ender). An optional hand-in with no later step by its ender is
  not written, nor the rest of its quest: next to the accept it made a trip of
  its own (c17 Horde: the OOX-17/TN and OOX-09/HL rewards flown to Booty Bay
  from Tanaris and the Hinterlands, the escort after the hand-in).
- A quest started by an item that only drops, rarely or at an unknown chance,
  is optional: its collect and its accept, and the accepts of the quests
  after it in its chain (Nibbled-On Book, then Book Inventory); their
  hand-ins wait only for a player who holds them. A quest the route adds that
  a dropped item starts (Message in a Bottle) gets the item's collect first,
  and its accept is optional.
- A line of a class quest in a step for everyone gets its classes (`only
  Priest`). With route legs, a step whose every goal is then some classes' is
  theirs (`only Shaman`, the Brine hand-in in the Barrens between two
  Ashenvale steps), and the next step for everyone names the zone the others
  are in (else they read Alonso's goto in the Barrens, #383).
- A quest the route does not take itself (a class's own chain) whose accept is
  written before the hand-in of a prerequisite (the data's `pre`, all of them,
  and `preAny`, one of them; not its `parent`, which stays in the log: Chapter
  I-IV inside The Green Hills of Stranglethorn) goes after that hand-in with
  every line of the quest before it (with the `level` line gating its accept),
  in steps of their own after the hand-in's step and the steps right after it
  that are everyone's accepts and hand-ins at its NPCs (Darsok's Letter to
  Jin'Zil before the Warlocks' Ken'zigla trip), each with its v1 step's title,
  `only` and zone; the step after them names the zone it read before (a
  flight's step: the zone it lands in). Its follow-ups follow the same
  way, so the chain keeps the
  seed's order (Call of Fire 1526, then 1527; The Binding after Creature of the
  Void). This runs last, after every other move. An objective line written twice
  is written once only when the two are for some of the same characters (the
  Paladins' own Shadowvale elixir bottles, 95314). v1's accept or hand-in for
  other characters than the route's line of the same event goes after it only
  into a step its characters see (not the Paladins' accept of 99152 into the
  `only !Paladin` Hilda step); a line's `only` is read before a closing
  `optional` too.
- An untimed item whose vendor (the `npc` of v1's buy line) stands at the
  route's visit of the buy line's step, within its last 12 pieces, is bought in
  that visit, not where the world puts its task (the Southshore Stout in
  Tarren Mill before Valik).
- A class's own step whose lines all wait for a level (held) gets no trip of
  its own there and back (the Rogues' flight from Ratchet to Orgrimmar for
  Shenthul at 19); a held accept's later lines from another v1 step keep that
  step's title, `only` and zone (Ken'zigla's hand-in of 1510 not in Gazrog's
  step).
- An item turn-in that the chain reaches before any line that gets the item
  moves after the last such line, unless the route works the quest itself
  (also where the guide leaves the work to v1's optional bag turn-in, the
  Scourgestones). The route's accepts after it in its step that need it handed
  in go with it (The Final Message to the Wildhammer after the feathers).
- v1's `level` grind the route does not name, at a point where the route is
  more than a level below it (it reaches the level later, on quests), is
  written at the route's level there: a catch-up for a player behind, not a
  grind ahead of the route. With route legs, v1's `level` grind lines the
  route does not name are not written at all, nor a v1 step left with only
  such lines and notes.
- Hearths and duplicate `only` lines are fixed per audience (see the layout above).
- A tip or note carried from a guide played at riding level (40) into one
  played below it no longer tells you to ride: "ride" becomes "head", "riding"
  becomes "walking". Rides on boats, zeppelins, trams and flights stay, and so
  does learning to ride (the riding trainer, the skill, a mount). v1's own
  lines of that guide are not touched.
- Steps left with no goal go. With route legs, so does a section rule
  (`# ---- Menethil Harbor`) with no step under it before the next rule, and a
  step's tip that another tip of the step already says word for word at its
  start ("Captain Stoutfist stands in Menethil Keep.").
- With route legs, a tip sentence that walks the player back along the road
  ("Walk back west along the road") right after a step that flew them on goes.
  A plain `sethome`/`getfp` in a step where v1's line with its NPC says the
  same goes (one bind line at Goldshire, not two).
- v1's bind stop (a step that only binds, learns a flight path and travels)
  that the route has already left, when v1's order reaches it, goes: the
  route binds where it means to (Ironforge's "the last guide binds here" after
  the route flew on from Aerie Peak to Southshore's boat).
- With route legs, a seed note that a quest is not on the route or to skip it
  (`note ... Skip it.`, "not on this route") goes where the route takes that
  quest: in the step that accepts it, or for any quest the route takes.
- With route legs, a `train class` in the step right after one that trains
  the same classes or more goes (the route's Ironforge trainer, then v1's
  Kharanos step; three Orgrimmar steps in a row, each training); a step it
  leaves with only some classes' lines is theirs (`only Hunter,Shaman,Priest`),
  one it leaves with nothing goes. A class the route's training stop has no
  trainer for, with no pass by that class's trainer within 1.5 levels, trains
  at the route's next training event instead.
- With route legs, consecutive steps that work quest objectives (kill,
  collect, interact; each target a camp of three spawns or more, also one only
  some characters work, which keeps its `only`, though it alone never makes a
  step's own two quests an area step; events and
  bag counts ride along, and so do one object or a race's own objective, at
  their own points; section comments and along steps between them go before,
  unless the along list ends at one of them) whose targets
  share the ground become one step, `<Area>: kill these as you meet them`,
  with all their tips and goals: two of their spawns within 150 yards near the
  route's work points for them (those within 700 yards; the ground of every
  step merged so far; spawns on the live map count too, Redridge's gnolls; a
  line with no objective number is worked at its target's task), or the later
  one's targets in numbers on the earlier
  one's ground, worked there (the eggs on the makrura's beach). A step's zone is
  its zone line, else where its work is. Accepts stay
  in their place among the goals; a step with a hand-in is not merged (the
  oats stay with Verna's hand-in, #621), but a stop at an NPC on the merged
  ground that hands in none of the group's quests does not break the merge
  (Lakeridge Highway's camps around a Three Corners stop). The first step's label stays, and
  references to the others' go to it. Every goal keeps its own place: no
  search circuit, which would move each goal's camp (the compiler's low-band,
  not-strays and object-spawn choices, #385, #289) to shared spots.
- With route legs, consecutive steps whose every goal is an accept or turn-in
  at one and the same NPC are one step, the first's (Teeri's two steps).
- With route legs, a step right after one with the same title and the same
  `only` (section comments between), with no travel, label, condition, loop
  or along list of its own, whose first placed goal stands within 200 yards
  of the other's, is the same place: one step, the first's. Its tips lose
  their way in ("Follow the road north to Razor Hill"): the player is there.
  (Not v1's "Stormwind class quests" pieces at Agent Kearnen in Westfall and
  Rohan in Ironforge: titled alike, far apart.)
- With route legs, consecutive steps at one hub are one visit, the
  first's: every goal an NPC's (an accept, a hand-in, a training, a bind, a
  flight path, a vendor or a buy), each later step with a giver or ender within
  120 yards of the visit's, for the same characters, with no travel, label,
  condition, loop or along list of its own. Their lines keep the hub tour's
  order; later tips lose their way in; an `along` list between two of them goes
  after the visit (Brill's Holland, Dillinger, Johaan and Zygand, written from
  v1's four steps, #740).
- Then, with route legs, a step's field goals (kill, collect, interact for a
  quest objective, for everyone, not optional; not in a loop or along step)
  run as a sweep from where the step is entered: the nearest target's ground
  first, then the nearest from there, so the arrow leads to the nearest work.
  A named target (fewer than three spawns) that is elite, or three levels over
  the easiest mobs of the step's camps, goes last (Maggot Eye at 11 on the far
  hill, after the Rot Hides just north of Brill, Fitz). Area steps are always
  swept; other steps when the first goal is more than the judge's
  `arrow-order` slack (200 yards) farther than another, or a hard target comes
  before a camp. Only lines with no other goal between them move among
  themselves: an accept or hand-in between stays, and so do the goals on each
  side of it (Yaw Sharpmane's hunts in turn). A quest with an `interact` keeps
  its goals' order; a tip naming a target follows its target. A goal of a quest
  the step itself accepts stays after that accept (the Felbind after the Flute
  of Xavaric's accept in Jadefire Run). A goal for a whole quest, with no
  objective number (`kill 423 quest 246`), is a field goal too (Lakeridge
  Highway's gnolls, poachers and thrashers).
- **On the way**, for the next rule, is a detour, not a distance (Fitz): from
  where the quest finishes to the loop's next goal (its spot nearest there),
  going by the NPC adds at most 40 yards (`ON_THE_WAY_YD`; walking yards when
  the walk store has all three legs, else straight). An NPC near the loop but
  behind or beside the way it goes fails. The finish must be predictable: the
  bound holds from **every** spot the quest's last goal may be finished at (one
  for a named mob or a single object: Sarkoth); in a spread camp where it
  depends on where the last one drops, the hand-in stays where it is. Hana'zua
  between Sarkoth and the Vile Familiars: 150 + 228 - 348 = 29 yards.
- Then, with route legs, **a hand-in the walk comes back for goes into the
  loop** (`hand_ins_into_loops`; Fitz, c19r Durotar: Sarkoth's hand-in written
  after the Burning Blade Coven). A step of two or more field goals (not a
  loop, along or `only` step) that finishes quest Q (its last goal of Q, no
  line of Q between it and Q's hand-in, within 40 steps) takes Q's hand-in, and
  the follow-up accepts right after it at the same NPC, right after Q's last
  goal when all of these hold:
  - it saves a trip: the hand-in's step hands in or takes nothing else (a hub
    the route passes anyway keeps it: the Den after the valley loop); after
    Q's last goal the walk goes 250 yards or more from the NPC (on the loop's
    later goals or the steps before the hand-in) or travels (fly, hearth,
    die); and the loop does not end within 150 yards of the NPC with the very
    next step handing Q in (Those Blasted Troggs! at the end of Dun Morogh's
    trogg loop stays);
  - it is on the way: the 40-yard detour above from every spot Q's last goal
    may finish at, on to the loop's next goal (or to the place after the loop
    when Q's goal is its last).

  The hand-in's step, left with no goal, goes. The rule only takes a hand-in
  into a loop where it removes a walk back and adds at most 40 yards, so a
  route's walking never grows from it and no walk-back or duplicate trip is
  added. On release-030's compiled guides, of the 174 loop hand-ins written
  in a later step with the NPC within 150 yards of the loop's ground and the
  loop reaching 250 yards away, these conditions move none by straight yards:
  116 are at a hub step the route visits anyway, 17 work the quest again
  before the hand-in, 12 are not area steps, 11 save no trip (the walk store
  decides Searing Gorge's Flawless Flame, on the ledge below Thorium Point),
  9 are detours over 40 yards from some spot they may finish at (Buzzbox 323
  in Darkshore: the Moonstalker fangs drop all over the shore), 5 end their
  loop at the NPC with the hand-in next (Those Blasted Troggs!), 4 finish the
  quest on a goal that is not a field goal. Sarkoth is not among them: those
  guides already hand it in right after the kill, inside the valley loop.
- Last, **one line per goal in a step** (`post::one_goal_each`, #843): a
  `kill`, `collect`, `use` or `interact` a step lists twice (the same target
  for the same quest objective and characters; `optional`, coordinates and
  `live` aside) is one line: the first required one, else the first, with its
  own note, else a copy's. The merges above bring them together: v1's
  optional "on the way" boars and leopards of Dun Morogh's Brewnall Village
  beside the required kills the route works there.

### 4. Travel

The route's own legs are written between two route events: walks to nodes,
flights (back-to-back flights become one `fly`), boats, zeppelins, trams,
portals and hearths. A lift counts as part of the walk.

- Where the route kept v1's order, v1's travel lines stay.
- Where the route changed the order, v1's travel lines in that gap
  (`fly`, `hearth`, boat and zeppelin `goto`s, waypoint steps) become the other
  races'. The exceptions: v1's line for the route's own flight stays, and the
  route writes no second one; a waypoint step within 250 yards of the place
  the next piece works (a cave's mouth, Shadowthread Cave's, #328) stays: it
  is the way in. v1's `fly` to where the route already stands (within 300
  yards of the flight master) is the other races'; a step that is only a goto
  to the same place as the next one's goto goes.
- A route deathskip (`--deathskips`) is a `Deathskip to <graveyard>` step before
  the way there: a tip naming the mobs and spot to die at (a death elsewhere may
  go to another graveyard), then `die "<graveyard>"` at its Spirit Healer. The
  way after it is written as for a walk: a player without "Use deathskips"
  passes the step and travels on from where they are.
- A v1 step the route did not place is written where a leg passes its zone, and
  walked to when it is in another zone or far away; far in the same zone of a
  guide other races share, it is not (its own goals lead there; a goto step
  for the route's races alone was a bare bounce between the others' steps).
- A class-only detour into another zone (a flight to a class trainer, say)
  comes back before the next route step, and before everyone's next leg of
  the route's way, where it starts, also when that is in the next guide (the
  Shamans' Ironforge trainer at the end of Duskwood). Classes that walked off follow everyone's
  walk from where they are. The way back is from the flight master it flew
  to, else the known flight master nearest the route, else on foot; a flight
  back to a flight master away from where the route goes on walks on to it,
  and a class that flew to the flight master the route goes on from stays
  there; one nearer where it goes on than the flight master back walks from
  there (the Paladins flown from Thelsamar to Ironforge, the route at its
  gates). When the route's own way goes to a class's own stop (the Warriors'
  flight to Ratchet for The Affray), the other classes stay where they were
  and come on the same way before the route goes on. The classes away over
  the route's training stop come back to where the route goes on from it, not
  to the trainer (the Warlocks from Stormwind to Rainer, not via Goldshire).
- A class's own v1 step that the route's order leaves away from its place,
  with no travel of its own, gets that class's flight there (Spirit Rise in
  Thunder Bluff after the Crossroads), or the boat or zeppelin when its place
  (else its zone's flight master) is over the sea, with a flight toward the
  dock first when that saves the walk, else the walk into the dock's zone; one
  that flies from where no flight master is gets the walk to the nearest one
  first. Classes away on a detour of their own are left as they are; a class
  that flew off to the other continent is not flown back over the sea.
  A class's own v1 hearth back to the inn everyone is bound at stays: it is
  that class's way back (the Shamans' hearth to Grom'gol after Islen).
- A step's gotos after its last named line are its way out, written with its
  last piece, also when another line (a vendor) comes before them: a goal
  the route moved elsewhere does not take v1's travel with it.
- With route legs, v1's accept of a quest the route does not take itself (a
  class's or race's own: Venya's imp quest, Sarvis' scroll for Aramis) goes
  to the earliest step with a goal within 40 yards of its giver (the line's
  `npc`, else the quest's one giver) where it is takeable: the route's level
  there is its minimum or more, its prerequisites are handed in before, and
  the step is for the same characters. Its `only` (the step's, when the line
  has none) goes with it. Its hand-in goes to the first step after the accept
  and its work (with the hand-ins of the quests taken inside it, its children
  by `parent`: The Green Hills of Stranglethorn after its chapters) with a goal
  by the ender, when that is earlier. A step left with no goal and no label
  goes. Run twice, so a moved hand-in opens its follow-up there too (Aramis'
  Holy Light).
- A class's own accept (a class step, or a line `only <classes>`) the route is
  not yet level for waits, with its quest's lines after it, for the route's
  next step in the giver's zone at that level (the Paladins' Tome of Divinity,
  level 12, not at Goldshire at 10). A class step of such accepts waits the
  same way for the route's next event in its zone at that level. Neither waits
  into a guide for other players: in a start's own guide before the shared
  guides it stays where it is, behind a `level <need>` line (the Dwarf
  Paladins' Tome of Divinity in Dun Morogh), since the shared guides are the
  canonical start's writing.
- A v1 step the route did not place goes before the route's next v1 line, but
  when that line is in another zone than the step's own place, on the route's
  nearer pass through the step's zone: a recent one (any one, over the sea, or
  one at most two levels back: v1's Orgrimmar training step at the route's
  Orgrimmar stop, not after the Feralas work that followed it) where its
  quests are taken by then, else the next one at most two levels on
  (the Undead Paladins' Bandarion Keep quests before the Barrens, the Paladins'
  Undercity trainer at the route's Undercity stop). v1's way steps and travel
  only steps stay where they are; a step whose work the route did or dropped
  elsewhere leaves no travel behind (the Barrens' Kolkar camps goto). A step that names its zone is walked to at
  its lines in that zone only (v1's Orgrimmar training step, whose Warrior quest
  has a giver in Thunder Bluff too, is no walk to Thunder Bluff); a way into a zone the route is already in
  goes (the Great Lift between two Mirage Raceway stops). A city beside or
  under the route's zone, within 600 yd, counts as the same place (the
  Undercity's Magic Quarter from the Ruins of Lordaeron). It does not go back
  past a piece written since that has a line of one of its quests (the Druids'
  Body and Heart hand-in stays after the Moonkin Stone). Over the sea, with no
  pass there, it goes before the route's crossing: after the route's last piece
  on its continent when only the way over is written since, or when its v1
  step before is written there, recently, and the route is within a top-up of
  its level (the Druids' Cat Form run from Auberdine, not after the boat and
  Stormwind's work). A step handing in a quest whose work is an earlier v1 step
  not yet written waits for the route's first pass through its zone after that
  step's place (the Warlocks' Binding at Gakin after the Heartswood, at the
  next Stormwind stop, not a boat there and back).
- v1's quests the planner left out for their value or a chain the route does
  not open (`<Start>.skips.json` beside the route, reasons `low-value` and
  `chain-not-open`) that no route event takes are not written (Swelling
  Forces); optional ones and class or race steps stay. An untagged `collect` or
  `use` line (no `quest`) belongs to the accept before it in its step, else to
  the step's one quest: it goes when that quest is dropped (The Blackwood
  Corrupted's bowl and samples).
- Such a step that the route leaves away from its place goes back to the
  route's piece at that place, when one is near: for a step at an NPC only the
  route's piece just before it; for field work with no NPC (Perrine's Chest at
  the Scarlet camp, found by where its target spawns) any of the last eight,
  with no travel or line of its quests between. It also goes right after v1's
  step before it that accepts its quest (the Warriors' Singed Scales right
  after Uzzek's Far Watch accept, not after the Crossroads).
- An accept of a quest the route does not take, ahead of a prerequisite handed
  in in a later guide for the same players, goes there with its quest's lines,
  after that hand-in; the quests its own hand-in opens follow it, and the
  quest's lines already in that guide before the hand-in go after it too (News
  of Dogran and Ken'zigla's Draught after Gan'rul's hand-in in the next guide).
- A v1 step the route did not place with nothing for everyone, only some races'
  lines (and a flight path), is those races' step: no walk there for the rest
  (v1's "To the Undercity" for the Skyborne's Sylvanas).
- v1's steps waiting on the way are written in the zone they are for, when
  the route's path gets there (after a hearth, at the inn before the way on);
  a class's own flight off is written at the flight master the path walks
  away from, when that flight master flies there. A step for other races
  than some of the route's does not gate the route's way to it.
- The route's own boat or zeppelin step replaces v1's goto to the same pier
  written since the last travel line in a step for everyone: it is the last
  thing in that town.
- A walk to an island (Feathermoon Stronghold) is written as the flight toward
  its boat, then the boat. At a guide's start the walk is from where the route
  was in the guide before; a leg to where the guide before already left
  everyone is not written again.
- A walk from one zone into another goes over the zone crossings it passes
  (the world's crossings: `data/crossings.json` under the routes' rule, see
  [routes.md](routes.md)): when the straight arrow would cross a border with
  no way over it, or is longer than 4,000 yards, each crossing's end in the
  zone it leads into is written first as an `Into <zone>` goto step (the
  Timbermaw tunnel's Winterspring mouth on the walk from the Emerald Sanctuary
  to Everlook: the way in, not a stop out to one side). Only a walk that is
  one: such a walk that a flight between known flight paths, or the tram or a
  boat on the continent, makes quicker by the route's estimates (a walk at 7
  yd/s over the crossings, a flight at 25 yd/s plus a minute) goes that way
  (Stormwind to Menethil for the Lightforge Ingots is flown, not walked through
  Redridge, Riverglades and Loch Modan). A route walk through a flight master the path only
  walks by (a waypoint of the sim's network, not where it flies from) is one
  walk when the walk straight on, over the zone crossings, is no longer and it
  leads to no boat (Camp Taurajo to the Shady Rest Inn, not north by Brackenwall
  Village's master and back south); one where the path learns that master's
  flight path (its `getfp`), far from the leg's end, stops there: the walk's
  goto step is the master's, with the `getfp` (Gadgetzan's on the way from
  Freewind Post to Steamwheedle Port). The travel repair's own walks
  cost at least the way over the crossings, a walk no crossing joins is no
  walk (Azshara into Winterspring), and its walks get the same steps.
- A walk into Riverglades, a zone players do not find the way into on the map,
  gets a tip naming Redridge Pass; a walk out of it names the way into the zone
  it goes to (the Swamp of Sorrows by Redridge Pass, the Badlands north of
  Twilight's Shroud, Redridge, the Burning Steppes by Blackrock Pass: Warcraft
  Wiki's Riverglades, adjacent regions).
- An item-started accept the route takes before the rest of its v1 step, moved
  to that step's next event, leaves its travel to the event that now comes
  first (the tram and the Ironforge flight to Southshore go before Marshal
  Redpath, not a second way of v1's by Menethil's boat with the route's
  flights after it).
- Travel to an event from elsewhere than the event before it in the same v1
  step stays: that event was done where the player stood (the cloth hand-ins
  at Thunder Bluff after the bag tasks: the Light's Hope flight, the Undercity
  zeppelin and the Orgrimmar flight are written). Unless the event is where the
  event before leaves the player (same zone, within 1,500 yards: a walk no
  flight beats): then it is a hop within the step too (the Tainted Ooze jars at
  Jaedenar stay in the Oozes step). The step after a flight's step reads the
  zone it lands in.
- A route leg that starts more than 600 yards from where the guide leaves the
  player (or on another continent) is never replayed from its own start: none
  when it ends within 600 yards of the player, else the way from the player's
  place (the crossing, the flight, else the walk).
- A bag hand-in the route does where it stands (a task of v1's `optional` line
  with no travel of its own, whose point, the item's drop camp, the route's
  next leg does not leave from: the leg leaves from where the route stood
  before it) is not walked to: written where the route stands when v1 places it
  in that zone, else, when v1 places it in the zone the leg ends in, right
  before the leg's event, which it then takes (the Ironforge cloth donations
  after the tram from Stormwind, not walks to the Wetlands and Searing Gorge).
- In a shared guide, v1's lines of a quest the route takes in its races' own
  guide (the Orcs' and Trolls' Barrens quests) are the other races'.
- A `getfp` is written at each flight master the route reaches, in an
  `Inn and flight master` step when it arrives there. v1's `getfp` for other
  races alone (the Skyborne's Rut'theran Village) is not the route's: its own
  is still written.
- v1's step that only learns a flight path, over the sea from where the route
  is, gets no crossing (v1's Ratchet stop between Theramore and Booty Bay, which
  the route reaches by air): the route learns that flight path where its own way
  passes. Nor is v1's hand-in of a quest the route does not take (optional, or
  not in its order) written in another zone than the route's (The Collector to
  Marshal Dughan in Goldshire, in mid-Westfall).
- The repair's flight away from the next goal (its flight master, then the goal
  farther than from where it left) goes, and its `Fly to` step with it when the
  flight master's goto is all that is left; a flight to a training stop (`train
  class` next) is for the training and stays (Thorium Point to Ironforge).
- The repair's way on from where a class trip left the player is that trip's
  classes': when the last step the player plays before it is some classes' own
  (`only Warrior,Hunter,...`, v1's Orgrimmar training) and the other classes
  went their own way meanwhile (a step of theirs alone with travel), the way is
  `only` the trip's classes (the flight from Orgrimmar to the Crossroads after
  the training, not shown to the Druids and Paladins already back at the
  Crossroads from Thunder Bluff, c19 Horde 30-40/03-arathi-highlands:449).

`--no-route-legs` writes the old JavaScript writer's travel instead. It then
runs that writer's travel repair: the honest playtest's R1 (see
[judge.md](judge.md)) plays the written chain as a Warrior of the route's race,
and a travel line that starts where the player is not goes to the other races.
`--no-repair` turns the repair off.

### 5. Engine features

The newer addon engine (Polestar 0.2.6, pack format 4) reads lines that v1's
guides predate. The writer adds them where the route needs them
(`src/engine.rs`). These R-numbers are the writer's own, in order of how much
they matter to the player. They are not the judge's honest rules.

- **R1 `along until <label>`**: work the route does while walking past,
  before the step that lists it, is listed "along the way" from the accept on.
  Work whose spawns line the walk on to the turn-in is listed from its stop's
  step: before that step when the quest was taken earlier, so the stop's own
  end (a cave's mouth) stays the last place before the turn-in. Either way the
  walk has to come within 60 yards of one of the objective's own spawn points,
  not just near the edge of its spawn area: a wide pumpkin field 130 yards off
  the road is not "on the way" (#737). Work whose spawns lie on the ground of
  a step the list would run past (spot centres within the judge's `merge`
  overlap, 150 yards, of a required field goal of a step for the same
  characters, not a `loop`, `when` or `along` step) goes into that step,
  beside its nearest goal, and the list ends there: the Rot Hide Graverobbers
  and their ichor north of Brill are worked in the Doom Weed step. Not ahead
  of an order the route fixes keep.
- **R2 `use <item>`**: a quest done by using an item gets its `use` line, at
  the item's place nearest the route's work. A use that gives no credit itself
  (a bowl filled at a moonwell) is not bound to the objective; one that makes
  an item a line collects goes right before that line (the empty bowl at the
  Auberdine moonwell, not at the furbolg camp after the filled bowl, #302).
  One use per quest and item, however often the mechanics list it (A Matter
  of Time's Temporal Displacer, #843).
- **R3 guards**: travel steps for quests carried from an earlier guide get
  `when onquest`, except a step that also trains, learns a flight path or
  binds, or holds lines for some races or classes only (the Ironforge training
  is everyone's). So do the hand-ins of quests the player may have passed by:
  one taken `optional`, from an item that drops (`accept Q item N`, or a quest
  only an item starts), or listed along the way, and every quest that needs one
  of those first. A step that only hands them in (and walks there) gets `when
  onquest`; beside other work, the hand-in lines become a step of their own
  with the step's title, `when onquest`, in the same place, and the rest of the
  step goes on after it (a hand-in already `optional` there never holds the
  step and stays). A hand-in of such a quest at the NPC another goal of the
  step is at (an accept or hand-in there) stays in the step, `optional`: the
  player stands there anyway. A hearth to an inn bound in an earlier guide gets
  `when bound "<inn>"`, and a walk there `when !bound "<inn>"` follows as a fallback.
  A way step for everyone into the zone of a `when onquest` step right after
  it (past other way steps) becomes that step's first goal, so only those on
  the quest walk it (the walk into Ashenvale for Forest Song after the flight
  to Talrendis Point).
- **R4 fractional levels**: a route grind written on a v1 `level` line keeps
  its fraction (`level 15.91`), unless a quest the route takes before its next
  grind needs more than that.
- **R9 where**: a goal at an NPC or object (an accept, hand-in, talk, click,
  kill or collect, a trainer or vendor) whose spawns mostly stand below ground,
  upstairs, on a building's top floor, indoors or under water gets that on its
  `--` note, on a step's first goal at it: "below ground" (a cellar, a basement,
  a cave), "inside Fargodeep Mine" (a cave's or mine's area name), "upstairs",
  "on the top floor", "inside" (not at a trainer, vendor, innkeeper or flight
  master), "underwater". The walking grid's floors at the spawn's height decide
  it (an indoor floor with the open ground over it, walkable or under a
  building's floor, is below ground; one with a building's floors under it is
  upstairs), the height from classic-db (`spawnz.json`), else from the Forever
  server's own spawns (`data/sources/forever-tdb/extract.json`). A goal at an
  NPC who walks around (`moves.json`; the compiler circles his walk on the map)
  gets "<Name> walks around <area>: look inside the circle on the map"; an
  accept, hand-in or talk at an NPC found at a few places within 150 yards of
  each other (the compiler's spawn spots) gets "<Name> walks around <area>: the
  map marks where to look". A note
  that says it already, a step tip that says he walks, and the capitals (all of
  the Undercity is below ground) get none.
- **R10 warnings**: a quest's notes in the knowledge base
  (`data/local/mechanics/quest-notes.json`) that warn of an ambush, an attack
  when you loot or click, stealthed mobs or adds go on the first step that
  does the quest's work, as one tip `Careful: <the notes>` (at most two, ambushes
  first, server data before players' reports; never a note about a follow-up).
- **Groups**: the elite and group quests the route takes (its `groups`, each
  order entry's `group`; [routes.md](routes.md#group-quests)) are asked. Every
  step that is not `along` and holds a line of a family's quest (accept, work,
  hand-in, in any guide of the chain) gets `when group <root>`: in place when
  the step holds only that family's lines and no `when`, else those lines move
  to a copy of the step right after it, headed `when group <root>` (R5's
  placement; several families, in the step's order: Sprogger's hand-in of
  8553 before his accept of 8554). The family's work is never listed along the way. Its first step
  that does the root's work (else its accept step) gets one tip: "These are
  elite mobs: grouping up is encouraged, look for people to do it with." then
  how hard (size 1: "Sarkoth is a level 10 elite: most classes solo it at
  level 12, but you may need help."; size 2 or more: "Sarkoth (level 10 elite)
  needs a group of 3.", several mobs "A, B and others (level 10 elites) need a
  group of 3.", no mob placed: the quest's title, "Challenge Overlord
  Mok'Morokk needs a group of 3.") and "Skip it if you are alone: the route has
  you grind the XP back.". With size 2 or more the family's `kill` and
  `collect` lines get `group N`. Each `soloFallback` becomes a step right after
  the step holding its order entry `after`: written as a grind top-up (step
  `Level N.FF`, at the camp of the work before it, never an elite one or a
  family's), its first line `when !group <root>`, its tip "If you skipped
  <title>, grind here to level N.FF to stay on the route's plan."; one step per
  family, never folded with the route's top-ups. With no camp by the player
  or in their zone (a city stop), it goes after the route's next work at a
  camp, there. Fallbacks one after another at one camp, with only group
  players' steps between, are one step at the highest level, its tip naming
  every title (with several families, no `when !group`: it holds for whoever
  is under its level). The group player is at that level already, so it does
  nothing for them. On by default (`forge build`);
  `--no-groups` turns it off. Under `--format-0-3`, R5 still asks the other
  group and dungeon quests.

`--format-0-3` adds the pack format 5 lines (Polestar 0.3.0): R5 `when group`,
R6 `task` and `cast`, R7 `abandon` when the log would pass 40 (the game's quest log), R8 `skipto` over
blocks kept for one carried quest. `--no-engine` writes none of these and uses
no route legs: the old JavaScript writer's output, byte for byte.
`--no-along`, `--no-use`, `--no-when`, `--no-level`, `--no-tips` (R9),
`--no-warnings` (R10) and `--no-groups` turn off single rules.

R2 and R6 read the checkout's quest-mechanics files under `data/local/mechanics/`
when they are there, R10 its quest notes. R6's `cast` reads spell names from the
game's data under `data/sources`. Without these files those rules write
nothing; R9 writes nothing without the walking grid (`data/local/nav4`) but the
walk notes.

Before the engine features the writer applies the fix records to the guides it
wrote, by anchor (a quest's goal), so a hand fix survives every re-cut. A fix's
tip is its step's tip: it replaces the step's first tip, and the step's other tips go. Each
record comes back `applied`, `redundant` (the guides already say it),
`not for this start`, `stale` (its quest is in the route, but no line anchors
it) or `conflicting`; `forge writer apply-route` prints the counts and the lines
it changed, and `forge build` writes them to `guides/<start>.fixes.json` for the
fixes ledger ([FORGE.md](../FORGE.md#fixing-a-generated-guide) has the formats).

With the engine features on, the writer ends with a travel check: the judge's
honest R1 on the written chain. It logs each R1 failure v1 does not have, then
the count.

## Text: what the writer writes itself

Step titles, tips and notes are v1's, moved with their lines (the guide's own
`title` follows the rules under "Guide titles" below). A held class step is
titled for its giver in the step's zone (the line's `npc`, else the giver with a
spawn there). A tip sentence or clause naming an NPC of another piece of the same
v1 step goes to that piece, from any of the step's tip lines, starting with a
capital. Apart from the riding
fix above, v1's text stays exactly as written, so its translations under
`guides/locales/` still match: they are keyed by the English text. The writer's
own words are R9's notes and R10's warnings (above); new lines follow these
fixed patterns:

| For | Lines written |
|---|---|
| added accept / turn-in | step titled with the giver's or ender's name (else the quest title, else `Quest Q`); `accept Q` / `turnin Q` |
| added objective | step titled with the quest title; `kill`, `collect`, `interact` or `talk <id> quest Q.N @x,y map M` at the spawn nearest the route's point; an event objective is `goto x,y` and `complete Q` |
| training stop | step `Class trainer`; `train class` |
| zone change | `zone <Zone>` |
| flight | `goto x,y "<Name> flight master"` (when not standing there), `fly "<Destination>"` |
| hearth | `hearth "<Inn>"`; with R3: step `Hearth to <Inn>` + `when bound "<Inn>"`, then step `To <Inn>` + `when !bound "<Inn>"` + `goto` |
| ride | `goto x,y "<Boat or zeppelin>"` at the dock |
| arrival | step `Inn and flight master`; `getfp "<Name>"` |
| engine rules | `along until <label>`, `label <label>`, `when onquest Q`, `use <item> quest Q.N`, `when group Q`, `task "Emote at <target>"` / `task "Wait for <target>"`, `cast <spell> "<target>"`, `abandon Q`, `skipto <label> when !onquest Q` |
| where and walks (R9) | the goal's note `-- <Name>, upstairs` (or the phrase alone, or after the author's note with `; `); `-- <Name> walks around <area>: look inside the circle on the map` |
| warnings (R10) | `tip Careful: <the quest notes' words>` after the step's opening lines |
| grind | `level N.FF` (the share of the level, whole percent) |
| grind top-up (inserted `level`) | step `Level N.FF`; `when level<N.FF`, `tip Top up here to level N.FF before the hand-ins at <place>: they take you to level N+1.`, `goto x,y "<the mob worked before it>"` at the route's point, `level N.FF -- grind on <mob>`. The camp: hostile mobs no more than 6 levels under the player (of an item's droppers, the one nearest the work's place), by the player or the route's nearest in their zone, else the route's next camp; never a capital city's map. When the mob named has no spawn within 400 yd of that point (the work's lower mob is under the player's level, an on-level dropper of the same item lives elsewhere: Darkshore's Elder Darkshore Threshers, #924), the `goto` is that mob's spawn nearest the point |
| group family | `when group <root>` on its steps, `tip These are elite mobs: ...` on its first work step, `group N` on its kills and collections (size 2 or more) |
| solo fallback | step `Level N.FF`; `when !group <root>`, `when level<N.FF`, `tip If you skipped <title>, grind here to level N.FF to stay on the route's plan.`, `goto x,y "<mob>"` (placed as a top-up's), `level N.FF -- grind on <mob>` |

Lines that changed have no translation until a translator adds one. Lint lists
them as warnings. That is expected after a rewrite.

### Guide titles

A leveling guide's `title` names the zones it quests in (`src/titles.rs`, on the
guides as written, after riding at 40). v1's title is a list of places
("Wetlands, Hillsbrad Foothills, Ironforge & Stormwind City"); the writer keeps
its order and words and leaves places out, never adds one:

- **No capitals**: Orgrimmar, Undercity, Thunder Bluff, Stormwind City, Ironforge
  and Darnassus are stops for training and hand-ins, not where a guide quests.
  A guide that is only capitals keeps them.
- **No zone the guide hardly quests in**: a zone with under 5% of the guide's
  quest goals and at most 3 of them goes ("Arathi Highlands, Badlands & The
  Barrens", 1 goal in the Barrens: "Arathi Highlands & Badlands"; "Silithus,
  Un'Goro Crater & Eastern Plaguelands", none in the first two: "Eastern
  Plaguelands"). Quest goals are the lines that accept, hand in or work a quest
  (`accept`, `turnin`, `complete`, a goal with `quest Q`), each in the zone the
  header's `zone` or its step's last `zone` line names. Both limits hold
  together: a big guide's 11 of 236 (Feralas in Western Plaguelands) is under
  5% but a real visit, and a small guide's 3 of 60 is 5%. The writer never
  leaves out every zone: then the one with most goals stays. A part that is no
  zone ("the Plaguelands") stays.

With nothing left out, the title stays exactly as written. The thresholds
reproduce every zone list shipped by hand on 2026-11-04 from the titles before
it, and change no other one. A changed title has no translation until one is
added, like any changed line. A race's lead-in to the shared guide of its zone
(the Orcs' and Trolls' Barrens) gets no title of its own: `forge guide publish`
merges it into that guide ([routes.md](routes.md#publishing-every-start)).

## Running it

```sh
forge writer apply-route out/routes/Orc.json --world out/.forge/sim/world-horde.json --root out/.forge/root --out out/try/Orc
forge writer apply-route out/routes/Human.json --world out/.forge/sim/world-alliance.json --root out/.forge/root --out out/try/Human --format-0-3
```

| Flag | Meaning |
|---|---|
| `<route.json>` or `--route FILE` | The route |
| `--world FILE` | The simulator world the route was found on |
| `--out DIR` | The written guides folder. **It is deleted and rewritten**: v1's whole folder is copied there, then the changed guides are written over the copies |
| `--guides DIR` | v1's guides (default `<root>/guides`) |
| `--data DIR` | The game data (default `<root>/data/forever`) |
| `--root DIR` | The checkout whose `data/forever`, `data/sources` and `data/local` are read (default: the nearest folder above here with `data/forever`) |
| `--walks FILE` | The walk store (default `walks-<faction>.bin` beside the world) |
| `--format-0-3` | Add the pack format 5 lines (R5-R8) |
| `--no-engine` | No engine lines and no route legs (the old writer's output) |
| `--no-along`, `--no-use`, `--no-when`, `--no-level`, `--no-tips`, `--no-warnings` | Turn off one engine rule |
| `--no-route-legs` | The old writer's travel, then its travel repair |
| `--no-repair` | With `--no-route-legs`: no travel repair |

After a `forge build --out out`, `out/.forge/root` and `out/.forge/sim` hold the
exact root, world and walk store that build used, and `out/routes/` holds the
routes. `forge build` itself writes each start to `out/guides/<start>/`.

`forge writer apply-routes <out>/routes --sim <out>/.forge/sim --root <out>/.forge/root --out <dir>`
writes every start of a build's routes the way the guides stage does: the
default options, each faction's shared guides made once for its starts, and the
two factions at once. It writes `<dir>/<Start>/`, `<Start>.fixes.json`,
`<Start>.log` and `<Start>.status` (`ok`, or why the start was not written).
`--starts Orc,Human` writes only those. It is the writer-only rewrite of a
round's routes, and the writer gate uses it.

The command prints a summary:

```
apply-route: <n> guides rewritten in <out>; <n> quests added, <n> dropped, <n> goals moved between guides, <n> route lines not placed
```

On stderr it logs the rest: lines it could not place, the engine rule counts
(`engine: R1 along …, R2 use …`, and how many passing legs the walk store
confirmed), and the travel check (`travel check: <n> R1 failures v1 does not
have on the route's chain`). Without a walk store it says so and uses straight
lines.

The library entry is `forge_writer::run(&RunInputs, &RunOpts)`. It does no file
access, so it also builds for the browser planner. `forge_writer::native::run_paths`
reads the files and writes `--out`.

## Into the addon pack

The written folder is an ordinary guides folder. Lint it, compile it, then
judge it:

```sh
forge guide lint --guides out/guides/Orc --data out/data/forever
forge guide compile --guides out/guides/Orc --data out/data/forever --out out/addon/Polestar_Guides
forge judge report --route out/routes/Orc.json --guides out/guides --root out/.forge/root --sim out/.forge/sim --out out/review
```

Run `forge guide` inside a Polestar checkout. It finds the checkout by
`addon/Polestar/Polestar.toc` and `guides/pack.json`, or you pass `--root`. It
reads the pack's manifest from `<root>/guides/pack.json`.

| Flag | Meaning |
|---|---|
| `compile` / `lint` | Write the addon files / only check |
| `--guides DIR` | The guides folder (default `<root>/guides`) |
| `--data DIR` | The game data (default `<root>/data/forever`) |
| `--out DIR` | The pack's main addon folder (default `<root>/addon/Polestar_Guides`, **the checkout's own pack**). Race parts are written next to it, and its translations into the language folders (`Polestar_deDE`, …) beside the game's names |
| `--format text\|json\|github` | How diagnostics print (`github`: annotations for CI) |
| `--quiet` | Hide warnings |
| `--force` | Write the files even with errors |
| `--sim DIR` | Lint only: read `world-<faction>.json`'s excluded quests for the solo policy |
| `--time` | Print phase times |

`compile` writes the TOC, `Pack.lua`, `MapFrames.lua`, `Guides.lua`, the race
parts and the texts addons. Its output is byte-identical to the old JavaScript
compiler's. Both commands exit 1 on any error. Their last line is the summary
(`lint ok: … files, … guides: 0 errors, … warnings` or
`compiled … guides (… steps) from … files; … warnings`). The full rules are in
[GUIDE_FORMAT.md](../GUIDE_FORMAT.md) ("Validation") and the pack layout is in
[PACK_FORMAT.md](../PACK_FORMAT.md).

Always pass `--out` when you compile a written tree. Otherwise it replaces the
checkout's own `addon/Polestar_Guides`.

## When something goes wrong

- **`the route was cut on another world (dataHash …)`**: the world file is not
  the one the route was found on. Use the world from the same build
  (`out/.forge/sim/world-<faction>.json`), or find the route again.
- **`apply-route: no guide <file>`**: the route's `from` lines name a guide
  missing from `--guides`. The route was found on other v1 guides. Find it again
  on the guides you pass.
- **Many "route lines not placed"**: the route cites v1 line numbers that moved,
  because v1 was edited after the route was found. Find the route again.
- **`quests added (… not written: no source for their items)`**: the world has
  no source for an added quest's items. Check that quest's objectives in the
  game's data or in our own corrections.
- **A new honest R1 on a continent change with no travel line**: often a route
  leg that loops or a long walk the simulator priced as a walk. The writer
  writes the route's way as it is. Fix the route (see [routes.md](routes.md)),
  not the guide.
- **Lint errors after writing**: run `forge guide lint --guides <written>`.
  Lines the writer moved keep their text, so an error usually means a moved line
  now sits before what it needs, such as a turn-in before its accept. Find which
  pass moved it with `--no-engine`, `--no-route-legs` or one of the `--no-…`
  rule flags.
- **Lint warnings about stale translations**: expected for changed lines. See above.
- **Changing the writer**: run [the writer gate](#the-writer-gate) before it
  merges. Placement is in `src/apply.rs`, the passes in
  `src/post.rs`, travel repair in `src/travel.rs`, engine lines in
  `src/engine.rs`, the where-notes and warnings in `src/tips.rs`. `--no-engine` output must stay byte-identical to the old
  JavaScript writer's, so new behaviour goes behind an option that is on by
  default, the way `RunOpts` and `engine::Opts` work now.

### Tests

```sh
cd rust && cargo test --release -p forge-writer
```

The apply-route and engine tests run on small guides. The travel-repair tests
need the game's data in the checkout and skip without it, naming the missing
input.

### The writer gate

No writer change merges unless the gate passes. The unit tests run on small
guides; most writer bugs only show on a whole route: a pass that moves lines
another pass placed, travel that misses a ride, a hand-in in another start's
shared guide. The gate writes the saved routes of the last finished rounds with
the writer before the change and with the changed one, judges both with the same
judge, and fails when the change adds a blocker.

```sh
rust/scripts/writer-gate.sh                       # this checkout against routes-opt, the 3 newest rounds
rust/scripts/writer-gate.sh --sets c17 --starts NightElf,Skyborne-alliance   # a quick look while working
rust/scripts/writer-gate.sh --base <commit>       # against another writer
```

It reads each round's `out/routes` (the saved search's routes), `out/.forge/sim`
(world and walks) and `out/data`, and the guides at the commit in the round's
`commit.txt`. Nothing is searched again. Both writers apply this checkout's
places, guide fixes and route fixes. Each start is written as `forge build`'s
guides stage writes it (`forge writer apply-routes`, the shared guides once per
faction). Then `forge judge check` and `forge judge seed-tests` run on every
start's tree. `forge writer gate-diff` compares the two runs per start by what
each finding is, not by where it sits:

- a judge blocker: rule, guide file, the text of the line it names and its
  message. Line numbers, coordinates, yards and minutes are left out of the key,
  so a blocker that only moved is the same blocker, and another quest or place
  is a new one;
- a player-report check that fails on the start's tree;
- a places or guide-fixes record that no longer applies (`stale`,
  `conflicting`);
- a start the writer refused (an error, or a tree the pack check refuses).

A finding the new writer has more often than the old one, or for more classes,
fails the gate. Findings that went away are listed too. Warnings are counted per
rule and shown, but they never fail the gate. The report is
`<run>/gate.md` (and `gate.json`). The exit code is 0 for a pass, 1 for a fail
and 2 when the gate could not run.

One forge process runs at a time. Each one uses every core: the writer runs the
two factions on threads, and the judge uses `--threads 16`, holding about 10 GB
for ten starts. If its memory-capped slot kills it, it runs again on 6 threads.
Everything runs at `nice 19` through the machine's slot scripts. The previous
writer's binary, trees and judging are cached under `$GATE` (default
`scratch/Routes/gate`), keyed by its commit, the records and the judge's code.
An older commit without `apply-routes` is built with this checkout's command
line on top of its own writer. After the first run, a gate run only writes and
judges the new writer's trees. On an idle machine that takes about 8 minutes of
writing, 1 minute of checking and up to 8 minutes of player-report checks per
round. The player-report checks run only for starts whose tree changed. Use
`--sets c17 --starts …` while working, and all three rounds before a merge.

A start the previous writer refused, for example a crash on that round's route,
has no baseline. The new writer's findings there are listed under "Not compared"
and do not fail the gate. The refusal that went away is listed under "Gone".

The gate catches what a change breaks on routes the writer has already written.
It does not catch a bug that only a new route brings out: c17's OOX hand-ins
were the c16 writer's behaviour, met for the first time on c17's routes. Those
are caught by the round's check and its review. Once they are fixed, that
round's routes become a gate set and hold the fix.

A new blocker is either a bug the change brought in, or a fix that is right and
shows a real problem the old writer hid. Read each new line in `gate.md`.
Fix the first kind. Name the second kind in the change's commit message. New
rounds become gate sets as soon as they are built (the newest three by default).
