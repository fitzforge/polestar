# The judge

The judge checks a set of guides the way a player would meet them. It
answers three questions about a leveling chain:

- Can a player actually do every line as written, with nothing given for free?
- Where does the route waste time: quests walked past, trips back to a place
  the player just left, long detours to a trainer?
- Did a change make things worse than v1 (the shipped guides) somewhere?

It lives in the `forge-judge` crate (`rust/crates/forge-judge`) and runs as
`forge judge`. `forge build` runs it as its last stage (`report`) on every
written start. See [FORGE.md](../FORGE.md) for the whole pipeline,
[writer.md](writer.md) for how the guides it judges are written, and
[model.md](model.md) for the simulator that supplies the levels and hours.

All hours in this page are **model hours**: time as the simulator prices it,
not a stopwatch on a real character.

## The pieces

| Piece | Module | What it does | Command |
|---|---|---|---|
| Engine replay | `engine` | A headless copy of the addon's step selection and done rules | none (library, seed tests, tests) |
| Honest playtest | `honest` | Plays compiled guides from their lines and the data only; rules R1-R10 | `forge judge` |
| Walk | `walk`, `levels` | The chain's goals in the order played, with level and time per goal | `forge judge` |
| Passed by | `passedby` | Quests the walk goes past while they are open, and does not take | `forge judge` |
| Avoidable returns | `returns` | Trips back to an area for work that could have been done last time | `forge judge` |
| Guide-text metrics | `guidetext` | Route-quality numbers read off the guide text | none (library, tests) |
| Seed tests | `seed` | Checks written from player reports, run on any guides folder | `forge judge seed-tests` |
| Report | `report` | v1 against the written guides, per start | `forge judge report` |
| Sim cases | `cases` | Reported route problems as properties of a route's action list | none (library, tests) |

The library builds without the file system too (`--no-default-features`, for
the browser planner); the `native` feature adds the folder readers and the CLI.

## Engine replay

`engine` is a line-by-line copy of the addon's `Core/Engine.lua` rules for
which step is current and when a goal is done:

- `only` (class, race, faction; `!x` excludes) and `when` decide which steps apply.
- Each verb has its done rule. `optional` and `note` goals never hold a step.
- Unavailable quests are marked (closed, prerequisite never coming, level gates),
  `along` steps are passed over and listed under later steps, `skipto` jumps.
- When a guide ends, `next` hands over: the one option, else the recommended one.

`Replay` plays a character through the guides against a lenient stub world:
any quest can be taken, objectives finish when acted on, items come from
nowhere. Each loop it completes the first open goal that is not optional. A goal
that stays open after the act is ticked if it is manual; otherwise the play is
stuck there, and either stops or skips the step (`OnStuck::Stop` / `Skip`).
The clock runs like the addon's test stub (0.6 s per act), so goals finish in
the same order as in a real Lua play.

The replay finds guides the addon cannot play at all (stuck goals, goals with
no location). Because the world is lenient, it does **not** find guides that are
merely wrong: that is what the honest playtest is for.

There is no command for the replay by itself. It runs inside the seed tests,
and its parity test against the real addon is `tests/engine_parity.rs`.

## Honest playtest

The honest playtest plays the compiled guides from their lines and the game's
data, with **nothing free**. The character gains a quest, an item, a flight path
or a place only through a line that gives it. Each rule a line breaks is a
finding. The line is then played as if it had worked, so one cause gives one
finding, not a cascade.

### Who plays

A chain starts at each guide that no `next` leads into and follows each guide's
first `next` option without a `when`. Each chain is played by a set of
*personas* (one race, faction and class): every race the first guide is for,
each class an `only` in the guide names, and one class no `only` names. With
`--class` you pick the classes instead.

### The rules

| Rule | Checks | Severity |
|---|---|---|
| R1 travel | A continent change needs a travel line (hearth, `die`, a boat/zeppelin `goto`). A zone change farther than 600 yd needs one too. `fly` needs both flight paths learnt and a flight master within 200 yd. `hearth` needs the inn you are bound at. Goals of an `along` step do not move the player. | fail |
| R2 accept | An item-started quest needs the item in the bags. The giver stands within 80 yd. | fail |
| R3 items | `collect` needs a source in the data within 400 yd. Quest items drop only while a quest needs them. `use` needs the item in the bags. | fail / warn |
| R4 NPCs | Givers and enders come from the data. A step titled with an NPC's name has a goal at that NPC. With several givers and no `npc`, none is 500 yd nearer. | fail |
| R5 turn-in | The quest is held, every objective is credited, and every extra step the quest needs (use an item, escort, buy, ...) has a line since the accept. | fail / warn |
| R6 gating | The data closes the quest to this race or class and no `only` gates the line (fail). An `only` on a quest the data opens to everyone (warn). | fail / warn |
| R7 numbers | Counts and quest levels in a goal or its tip match the data (`x10` for an objective of 8; "Kill 6" for 8). | fail / warn |
| R8 grinds | Two `level` gates in a row with no quest work between them. | fail |
| R9 quest log | The log holds at most 20 quests at every point (`LOG_MAX`, a guide rule kept well under the game's 40-quest log that the model and the writer use); the peak is reported. | fail |
| R10 loose ends | Every accept is turned in or abandoned later on the chain. | fail |

Default mode runs R1-R10. It merges equal findings across personas and chains,
plays each start's chain through the shared guides, and lets `buy` lines cover
buy steps. It also adds a far-walk check to R1: a plain `goto` into another zone
more than 4,000 yd away is a walk across zones, not a way in.

`--legacy` gives R1-R5 exactly as the Node playtest (`polestar playtest --honest`) printed them:
one row per persona, with the old quirks. The report uses legacy mode so its
numbers stay comparable with earlier runs.

R5's extra steps come from a quest knowledge base when the checkout has one
(`data/local/kb/forever-kb.sqlite`). Without it, R5 checks objectives only.

### Reading a finding

```
<rule> <severity> <file>:<line> (<race> <class>) step <n> "<step title>": <reason>
  repair: <what to change>
```

That is the rule, severity, file and line, the persona, the step number and
title, why the line fails, and a suggested fix. With `--json`, each finding also
carries every persona that met it and, for R1, where the player stood, the
flight paths they knew and where they were bound. The writer's travel repair
reads those fields (see [writer.md](writer.md)).

## The walk, passed by and avoidable returns

The walk lists the chain's goals in the order a player meets them. The chain is
the race's first leveling guide, then each `next`. Each goal gets a level and a
time from the simulator's evaluator (`levels::SimLevels`), using the sim
folder's world and `params.json`. `--levels FILE` replays the levels from a
saved judge dump instead. With neither, the walk is skipped.

An `along` goal is done the way the addon plays it: when a later goal works the
same objective, or at the step its `until` label names. `forge judge report
--along-walked` walks to it where the step stands instead, as the old judge did.

**Passed by.** The walk is replayed on foot. Every straight leg between two
located goals on one continent is sampled every 50 yd. Flights, hearths, boats
and deaths are not walked. At each sample, every quest giver within 500 yd is
checked: can this character take the quest solo, right now, at this level, for
XP? A quest found that way is listed once, at the first pass, as either **never
done** or **done later at level N**. "Later" means the walk took it only after
going more than 1,000 yd away from that giver, or to another continent.

**Avoidable returns.** Areas come from the quest atlas: each quest goal sits in
the area of its giver, ender or objective camp. A visit to an area lasts until
the walk goes more than 400 yd from the area's camps. Each quest goal on a later
visit is judged against the state when the player last left: could it have been
done then? The counts:

- **avoidable returns**: later visits with at least one goal that could have
  been done on the last visit;
- **wasted trips**: returns where every quest goal could have been done before,
  and there is no service (trainer, vendor, inn, flight master) to justify the trip;
- **left behind**: quests open at a departure and never taken;
- **same mob**: the same mob camp worked on two visits when one would do.

## Guide-text metrics

`guidetext::score` reads a chain as a player follows it and gives the numbers
the old quality gate tracked. The key names are kept exactly, so old and new
results can be compared:

- **pingpong**: zone visits (`rawTransitions`, `substantialVisits`), short
  A→B→A hops (`shortABA`), returns to a zone within 3 levels
  (`returnsWithin3Levels`), `continentChanges`;
- **log**: quest-log size along the route, quests still in the log at the end;
- **missed**: quests not taken whose giver stands within 150 or 300 yd of a hub
  goal at a fitting level (`le150.eligible`, `le300.eligible`);
- **overlap**: quest pairs that share a mob or site but are worked on separate
  visits (`mergeableNow`);
- **bandSplit**: how the simulator's level bands split pairs that share a hub or mob.

It needs the simulator's run and its exported routes as input, so it has no
command of its own. It runs in the seeded-defect test and in
`tests/guidetext_parity.rs`.

## Seed tests

The seed tests are checks written from **player reports** against v1's guides:
"the arrow sent me onto the hill above the mine", "no guide sends you to the
refugees for Stop the Spread". Each pins the fix: a quest taken on the walk
that passes its giver, a turn-in before a follow-up, a cave mouth before a
target inside a cave, and so on. They are the old Node tests
(`tests/guides-reported.test.js`, `tests/guides-caves.test.js`) ported to Rust,
with the same names. That way a written guide tree reports pass or fail for
each test, exactly as the Node run would.

Tests that play a guide run on the engine replay above. Each test compiles the
guides it needs with the game's data, and records failed assertions instead of
stopping. One failure does not hide the others.

A failing seed test on a written tree means the route broke a fix a player asked
for, or moved it to a place the test does not expect. Read the test's name and
its failure lines, then the guide lines it names.

```sh
forge judge seed-tests --guides out/guides/Orc --root out/.forge/root --lint
forge judge seed-tests --guides guides --filter caves
```

`--guides` is a folder holding `forever/`. `--data` defaults to
`<root>/data/forever`. `--filter TEXT` runs only tests whose name contains
TEXT. `--lint` adds the compiler's error and warning counts and the first
errors. `--json` prints `{ tests: [...], lint }`. The command exits 1 when a
test fails.

## Running the judge

<!-- ci -->
```sh
forge judge --help
forge judge report --help
forge judge seed-tests --help
forge judge route-status --help
forge judge feedback --help
```

### One pack: `forge judge`

```sh
forge judge guides --faction Horde --race Orc --class Warrior
forge judge out/guides/Orc --faction Horde --race Orc --root out/.forge/root --sim out/.forge/sim --to 30 --json
```

The first argument is a guides folder (holding `forever/`). `--faction` and
`--race` are required. Other flags:

| Flag | Meaning |
|---|---|
| `--class C` | Play only this class (`Warrior`); default: each guide's own choice of classes |
| `--to N` | Cut the walk at level N (default 61, i.e. all of 1-60) |
| `--sim DIR` | Folder with `world-<faction>.json` and `params.json` (default `<root>/data/sim`) |
| `--levels FILE` | Levels from a saved judge dump instead of the simulator |
| `--root DIR` | Checkout with `data/forever` (default: the nearest folder above the pack, then above here) |
| `--data DIR` | The game data (default `<root>/data/forever`) |
| `--legacy` | Honest R1-R5 only, as the old playtest printed them |
| `--json` | One JSON document: `honest { played, findings }`, `walk { chain, goals, endLevel, hours, background, passedBy, returns }`, timings |

Text output is every finding (two lines each), then a count per rule and
severity, then one walk line:

```
walk: <guides> guides, <goals> goals, level <end level>, <hours> h; passed by <n> (<never> never, <later> later); avoidable returns <n>, left behind <n>, same mob <n> (<ms> ms)
```

### v1 against the written guides: `forge judge report`

```sh
forge judge report --routes out/routes --guides out/guides --root out/.forge/root --sim out/.forge/sim --out out/review
forge judge report --route out/routes/Orc.json --guides out/guides --root out/.forge/root --sim out/.forge/sim --json
```

| Flag | Meaning |
|---|---|
| `--route FILE` (repeatable) / `--routes DIR` | The routes (the simulator's `<start>.json`; in a folder, files like `.skips.json` are ignored) |
| `--guides DIR` | The written guides; `<DIR>/<start>` is used when it holds `forever/` |
| `--stream FILE` | The route's goal stream (default `<route>.judge-improved.json` when it exists; only with one route) |
| `--base DIR` | The current guides to compare against (default `<root>/guides`) |
| `--root`, `--data`, `--sim` | As above; `--sim` must hold a world built on `--data` |
| `--out DIR` | Write `report.md` and `report.json` there (else print the markdown, or the JSON with `--json`) |
| `--along-walked` | Walk to `along` goals where their steps stand |
| `--no-checks` | Skip the seed tests and lint |

`forge build` writes the same two files to the top of its `--out` folder.
After a build, `<out>/.forge/root` and `<out>/.forge/sim` are a consistent root
and sim folder for these commands.

### The dashboard's route status: `forge judge route-status`

```sh
forge judge route-status --report out/report.json --out data/local/dashboard/routes.json
```

Reads a judge report and writes, per start, the base and new hours to 30 and
60, passed-by quests and avoidable returns to 60, honest fails, the seed tests
and lint, and the routes stage's skips (`<start>.skips.json` beside the route:
those for missing information, and all). The file is written whole and then
renamed, so the dashboard never reads half of it. Without `--out` it prints
to stdout.

### Player reports into the route: `forge judge feedback`

```sh
forge judge feedback --out out/route-fixes.json --report out/feedback.json
forge judge feedback --out out/route-fixes.json --offline
```

Turns `data/local/research/RouteFeedback.json` (insert, drop and constraint
inputs mined from player reports) and the GitHub issues labelled `guide`
into route-fixes override lines: `include`, `skip` and `pairs`, each with its
source (`F01`, `#647`) and whether the sim already honours it. The issues come
from `gh api` and are cached in `data/local/research/guide-issues.json`;
`--offline` reads only the cache, so the output is the same for the same
inputs. An issue can carry a fenced `route-override` JSON block, read as
given. Specs the reader does not understand are listed as manual, and issues
no feedback row cites as untriaged; neither is guessed. `--out` is
`data/route-fixes.json` with those overrides added; point the sim at it with
`POLESTAR_ROUTE_FIXES`.

## Reading report.md and report.json

`report.md` begins with a **Sources** line: the current guides' folder, the data folder and
when it was built, the sim folder, the root, and each faction world's
`dataHash` (the data it was built from). If two runs differ, compare this line
first.

Then one table with four rows per start: `guides` and `written`, each cut at 30 and
at 60. The `to` column shows `30` and `61`; 61 means "everything below 61", the
whole 1-60 walk.

| Column (report.json key) | Meaning | Better |
|---|---|---|
| hours (`hours`) | Model hours to reach the cut | lower |
| level (`endLevel`) | Level at the end of the walk | — |
| quests (`questsDone`) | Quests turned in | — |
| zone changes (`zoneChanges`) | Times the walk enters another zone | lower |
| passed by (never/later) (`passedBy`, `pbNever`, `pbLater`) | Quests walked past while open | lower |
| returns (wasted) (`returns`, `wastedTrips`) | Avoidable returns; trips that were all waste | lower |
| left behind (`leftBehind`) | Quests open at a departure, never taken | lower |
| same mob (`sameMob`) | A mob camp worked on two visits when one would do | lower |
| area visits (`areaVisits`) | Visits to quest areas (`qPerVisit` = quests per visit) | fewer, fuller |
| deaths (`deaths`) | `die` goals (deliberate deaths for travel) | — |
| trains (trips) (`trains`, `trainTrips`) | Training goals; trips whose only purpose is training, going back on yourself | fewer trips |
| grind min (`grindMin`) | Minutes spent on `level` goals | lower |
| log peak (`logPeak`) | Most quests held at once | ≤ 20 |

Then, per start:

- **Checks** (`checks`; v1's are in `v1_checks`): seed tests passed and failed
  (failing test names listed), lint errors and warnings, and the first lint
  errors. A written tree should have no more failures than v1.
- **Honest** (`honest_v1`, `honest_written`: fail counts by rule, legacy R1-R5,
  all classes of the race, on the chain's guides only). `honest_new` lists the
  distinct failures v1 does not have, matched by rule and reason with distances
  removed, so a "1,210 yd" against a "1,190 yd" counts as the same.
  `honest_new_warrior_r1` is the new R1 travel failures of the Warrior, printed
  in full. These are the first things to fix.
- **Stream vs written** (`stream`, when the route has a goal stream): the
  simulator's own order and the written guides' walk, priced by the same
  evaluator. `orderH30`/`orderH60` against `writtenH30`/`writtenH60` show how
  much of the route's gain survived the writing. `inBoth`, `outOfOrder`,
  `onlyInOrder`, `onlyWritten` compare their quest events (`accept Q`,
  `turnin Q`, `work Q`); out of order is what falls outside the longest common
  order. `losses` is the written walk's extra minutes before each common event,
  biggest first: where the written guides lose time against the plan.

A healthy written start: hours lower than v1 at 30 and 60, passed by and
returns no worse, no new honest failures, no new seed-test failures, lint 0
errors, and written hours close to the stream's.

## What the judge cannot see

We test the checks by seeding one defect at a time into the shipped Orc and
Human chains (`tests/seeded.rs`). About 7 in 10 seeded defects are caught,
almost always by the rule written for them. These still pass every check:

- back-and-forth inside one zone (R1 only looks at zone and continent changes):
  a `talk` to an escort NPC after the escort, a hearth followed by a walk back;
- a trainer or flight master that is not the nearest one on the route;
- required kills of rare or wandering mobs (only lint knows elites);
- a dropped class quest chain (the passed-by list only covers quests any class can do);
- a tip copied from another step (R7 reads only numbers);
- a repeated `buy`, `collect` or `train class`;
- the cost of deliberate deaths (no check models resurrection sickness).

A player review is still the final check for these.

## When something goes wrong

- **`walk: skipped (no sim world …)`**: there is no `world-<faction>.json` under
  `<root>/data/sim`. Pass `--sim` (after a build: `out/.forge/sim`).
- **Hours or levels that make no sense**: the sim world was built on other data
  than `--data`. The report reads the world as given; check the `dataHash` values
  in the Sources line against the data you meant.
- **`no data/forever above the pack or here; pass --root`**: run from a checkout,
  or pass `--root`.
- **Many R5 findings that look wrong**: check whether the knowledge base is
  present. Its extra steps are what R5 asks for beyond the objectives.
- **Honest findings on lines you did not touch**: a moved goal cascades. A
  later turn-in now misses its objective, a new walk leg passes other givers.
  Fix the first finding in the chain, then run again.
- **A seed test fails on v1 itself**: the data changed under the guides (a
  quest id, a spawn). Run `forge judge seed-tests --guides guides` and fix v1 first.
- **Changing a rule**: rules live in `src/honest/play.rs` (R1-R5) and
  `src/honest/rules.rs` (R6-R10), and their distances are the constants at the
  top of `src/honest.rs`. Legacy output must stay row-for-row equal to the old
  JavaScript, so new behaviour goes behind `!opts.legacy`. Add a small test
  guide in `src/honest/tests.rs` that fails before your change and passes after.

### Tests

```sh
cd rust && cargo test --release -p forge-judge -- --test-threads=2
```

Parity tests compare against saved JavaScript references and skip, with a note,
when their inputs are absent. The seeded-defect test accepts
`POLESTAR_SEEDED_N=<sites per class>` and `POLESTAR_SEEDED_ONLY=<class,...>`.
