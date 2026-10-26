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
objective), `train` or `level`. It also has the quest `q`, the world point
`pt`, the level `lvl`, the travel `items` that lead to it (walks, flights,
rides, hearths, binds, flight paths), and `from`. `from` is the v1 line the
event came from (`guides/forever/....guide:LINE`), `inserted` for a quest the
route added, or `train stop` for an added training stop.

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
  chain, and it never changes them.
- **`train class`** sends the player to the nearest trainer of their own class,
  picked by the addon at runtime. A route's training stop is written as a step
  `Class trainer` with `train class`, unless v1's next steps train there anyway.

A shared guide is played by every race, but a route is for one start. In a
shared guide the writer marks its changes `only <the route's races>` and leaves
v1's lines for the other races. A hearth the route's races are not bound for
goes for them. For everyone else v1's line stays. Two lines for complementary
race lists become one line for everyone.

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

- **The chain** is v1's: from the guide holding the route's first line, through
  each guide's `next`.
- **Steps split.** v1's goal lines go in the route's order. Consecutive lines
  of one v1 step stay one step. A goal line the route does not name goes with
  the next line of its step that the route does name. A step with no named lines
  goes whole before the piece holding the next named line.
- **Added quests** get their own steps where the route puts them:
  `accept Q` at the giver, each objective once at its first task, then
  `turnin Q`. If v1 treats the turn-in as optional, the work for it is
  `optional` too. An added quest whose items have no source in the world is
  not written, and the summary names it.
- **Dropped quests** lose all their lines. A quest v1 offers only after an
  optional start the route does not take is kept, for the player who finds
  that start.
- **Guide boundaries** go where the fewest lines land outside their own v1
  guide. Each guide keeps its header. A piece in another zone gets a `zone` line.
- **A comment block** follows each changed guide's header. It names the route,
  v1's and the improved hours to 60 in the model, the quests added and left out
  there, and how many goals moved in from other guides. v1's own comments above
  it describe v1's order; the block says so.

### 3. Fix-ups (`src/post.rs`)

- An item that runs out (a timed item) keeps its chain together: events between
  getting it and handing it in move after the turn-in.
- An item-started accept goes right after the step that collects the item.
- A line that works or hands in a quest the route does not take, and landed
  before its accept, moves to right after the accept.
- An item turn-in that the chain reaches before any line that gets the item
  moves after the last such line.
- Hearths and duplicate `only` lines are fixed per audience (see the layout above).
- A tip or note carried from a guide played at riding level (40) into one
  played below it no longer tells you to ride: "ride" becomes "head", "riding"
  becomes "walking". Rides on boats, zeppelins, trams and flights stay. v1's own
  lines of that guide are not touched.
- Steps left with no goal go.

### 4. Travel

The route's own legs are written between two route events: walks to nodes,
flights (back-to-back flights become one `fly`), boats, zeppelins, trams,
portals and hearths. A lift counts as part of the walk.

- Where the route kept v1's order, v1's travel lines stay.
- Where the route changed the order, v1's travel lines in that gap
  (`fly`, `hearth`, boat and zeppelin `goto`s, waypoint steps) become the other
  races'. The exception is v1's line for the route's own flight: it stays, and
  the route writes no second one.
- A v1 step the route did not place is written where a leg passes its zone, and
  walked to when it is in another zone or far away.
- A class-only detour into another zone (a flight to a class trainer, say)
  comes back before the next route step. The way back is from the flight master
  it flew to, else the known flight master nearest the route, else on foot.
- A `getfp` is written at each flight master the route reaches, in an
  `Inn and flight master` step when it arrives there.

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
- **R2 `use <item>`**: a quest done by using an item gets its `use` line.
- **R3 guards**: travel steps for quests carried from an earlier guide get
  `when onquest`. A hearth to an inn bound in an earlier guide gets
  `when bound "<inn>"`, and a walk there `when !bound "<inn>"` follows as a fallback.
- **R4 fractional levels**: a route grind written on a v1 `level` line keeps
  its fraction (`level 15.91`), unless a quest the route takes before its next
  grind needs more than that.

`--format-0-3` adds the pack format 5 lines (Polestar 0.3.0): R5 `when group`,
R6 `task` and `cast`, R7 `abandon` when the log would pass 40 (the game's quest log), R8 `skipto` over
blocks kept for one carried quest. `--no-engine` writes none of these and uses
no route legs: the old JavaScript writer's output, byte for byte.
`--no-along`, `--no-use`, `--no-when` and `--no-level` turn off single rules.

R2 and R6 read the checkout's quest-mechanics files under `data/local/mechanics/`
when they are there. R6's `cast` reads spell names from the game's data under
`data/sources`. Without these files those rules write nothing.

Before the engine features the writer applies the fix records to the guides it
wrote, by anchor (a quest's goal), so a hand fix survives every re-cut. Each
record comes back `applied`, `redundant` (the guides already say it),
`not for this start`, `stale` (its quest is in the route, but no line anchors
it) or `conflicting`; `forge writer apply-route` prints the counts and the lines
it changed, and `forge build` writes them to `guides/<start>.fixes.json` for the
fixes ledger ([FORGE.md](../FORGE.md#fixing-a-generated-guide) has the formats).

With the engine features on, the writer ends with a travel check: the judge's
honest R1 on the written chain. It logs each R1 failure v1 does not have, then
the count.

## Text: what the writer writes itself

The writer writes no new tips or prose. Titles, tips and notes are v1's,
moved with their lines. Apart from the riding fix above, v1's text stays exactly
as written, so its translations under `guides/locales/` still match: they are
keyed by the English text. The writer has no phrase templates yet. New lines
follow these fixed patterns:

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
| grind | `level N.FF` (the share of the level, whole percent) |

Lines that changed have no translation until a translator adds one. Lint lists
them as warnings. That is expected after a rewrite.

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
| `--no-along`, `--no-use`, `--no-when`, `--no-level` | Turn off one engine rule |
| `--no-route-legs` | The old writer's travel, then its travel repair |
| `--no-repair` | With `--no-route-legs`: no travel repair |

After a `forge build --out out`, `out/.forge/root` and `out/.forge/sim` hold the
exact root, world and walk store that build used, and `out/routes/` holds the
routes. `forge build` itself writes each start to `out/guides/<start>/`.

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
- **Changing the writer**: placement is in `src/apply.rs`, the passes in
  `src/post.rs`, travel repair in `src/travel.rs`, engine lines in
  `src/engine.rs`. `--no-engine` output must stay byte-identical to the old
  JavaScript writer's, so new behaviour goes behind an option that is on by
  default, the way `RunOpts` and `engine::Opts` work now.

### Tests

```sh
cd rust && cargo test --release -p forge-writer
```

The apply-route and engine tests run on small guides. The travel-repair tests
need the game's data in the checkout and skip without it, naming the missing
input.
