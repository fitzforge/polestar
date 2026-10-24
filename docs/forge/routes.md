# How a route is made

This page explains how Forge turns the shipped guides into a leveling route. A route is the order of
quest steps one character plays from level 1 to 60. Forge starts from the order players already know
(v1) and keeps only small edits that make it faster. Every edit is checked against the rules players
asked for. Every quest the route leaves out is listed with the reason.

For the time model that prices a route (how long a kill, a walk or a flight takes), read
[model.md](model.md). For the whole pipeline, start at [FORGE.md](../FORGE.md).

The code is in `rust/crates/forge-sim`. The `forge build` routes stage and the `forge sim` commands
both call it.

## Words used on this page

- **Start**: one leveling start, by race and faction. There are ten: Orc, Troll, Tauren, Undead and
  Skyborne for the Horde; Human, Dwarf, Gnome, Night Elf and Skyborne for the Alliance. Troll plays
  Orc's guides and Gnome plays Dwarf's, so their routes are the same.
- **v1**: the shipped guides as players use them (the current guides).
- **Step**: one thing the route asks for. The kinds are *accept* a quest, *task* (do one objective at
  its place), *turn in* a quest, *level* (grind to a level) and *train* (visit the class trainers).
- **Order**: the list of steps for one start.
- **Cut**: one run that makes a route for a start, with its files.
- **Model hours**: hours to level 60 as the model prices them. They are good for comparing two orders.
  They are not a promise of real play time.

## The steps, in short

For each start, the routes stage:

1. turns v1's guides into an order (the **seed**);
2. applies the overrides file and v1's deliberate orders;
3. adds class training stops;
4. improves the order with **local edits**, one at a time, best first, and stops at the **knee**;
5. adds **worthwhile pickups**: quests the route walks past that pay for their detour;
6. scores the result in several models and writes the route, the **skip ledger** and the **edit
   ledger**.

In the model, the improved routes reach 60 a few hours sooner than v1, and the gain is checked
against held-out parameter draws (see
[model.md](model.md#counters-parameter-draws-and-the-held-out-gain)); each build's report has the
numbers for its own data.

## 1. The v1 seed

Forge reads the input guides, follows each start's guide chain the way the judge walks it, and gets
one goal per guide line: accept, complete, turn in, reach a level. Each goal becomes steps:

- *accept* and *turn in* stay as they are;
- *complete* becomes one task step per objective place in the route model. When the guide line names
  one objective, only that objective's task is worked there. The written guide keeps the guide's own
  `complete` line as it was, so a bare `complete` still leads the arrow to the giver; only objectives
  the route adds get their own place;
- *level N* becomes a grind checkpoint with its fractional target (for example `level 12.4`);
- v1's own `train class` lines become training steps.

The seed keeps only steps that do something in the model. A repeated objective line or the accept of
a quest the character cannot have is dropped. Each step remembers where it came from: the guide file
and line, `inserted`, or `train stop`.

Quests that v1 marks optional because they start from a rare drop (deliberate orders, `optional`)
are taken out. The route does not count on them.

### Training stops

The route is class-agnostic (see [model.md](model.md#class-profiles-and-the-class-agnostic-route)),
so class training is a stop at a **town**: a hub with four or more class trainers. Trainer halls within
600 yd on one map count as one town, so capitals count. A starting valley is a town only for its own
race, and only until the character has left it.

A stop is added:

- at a new even level (new ranks come at even levels), not within a level of the last training;
- where the order passes within 600 yd of a town, or where a long leg passes a town and the town adds
  at most 90 seconds (within 400 yd of the straight line);
- never when one of v1's own trainings comes within the next level.

Each added stop then moves (up to 40 steps either way) to the cheapest place where the character has
the same new ranks. A stop that lands next to another training is dropped: that one covers it.

### v1's travel plan

The route keeps v1's travel habits. It hearths only at v1's hearth lines, binds at v1's `sethome`
lines and learns flight paths at v1's `getfp` lines (and when a step stops near a flight master). This keeps
the improved route close to what the guides already say. See [model.md](model.md#hearth-and-binds).

## 2. Local edits with a budget

The search starts from the seed and makes one **edit** at a time. It always takes the edit that saves
the most time. This is steepest descent. The edits are local on purpose. A player who knows v1 should
recognise the new route.

| Edit | What it does |
|---|---|
| `move` | moves a step within its zone stay (the run of steps on one map), to one of its 3 cheapest places |
| `fold` | moves a step (or the steps at its place) to an earlier visit to the same place (within 200 yd): a return is folded away |
| `fold later` | the same, into the next visit |
| `insert` | adds a quest whose giver the route passes (within 500 yd, at a level that opens it). Every later step of it goes to its cheapest place in its own zone |
| `drop` | removes a quest that costs a trip. A quest whose every stop is on the way to other quests is never dropped |

v1's grind checkpoints stay. They often stand for a gate the model cannot see (a class chain at 20, for
example).

Every candidate edit must pass all of these:

- the quest's own order holds (accept before its tasks, tasks before the turn-in);
- every deliberate order, feasibility rule and override holds ([section 4](#4-feasibility-rules),
  [section 5](#5-deliberate-orders));
- it adds no second training right after a training;
- a move does not lengthen the straight walk over the stretch it changes by more than 100 yd. A
  reviewer reads a guide by its straight legs, and a longer one splits a visit;
- no objective moves earlier to where the character is more than 2 levels under the quest;
- no step becomes a no-op. A quest is left out only by a `drop` edit, never by moving its accept
  before its prerequisite;
- no timed quest is handed in late, and no v1 hearth line is met while the hearthstone cools down;
- the quest log never goes over its bound ([model.md](model.md#quest-log));
- the guards ([section 3](#3-the-guards)).

How an edit is priced: the order is replayed from a saved state just before the change, for 80 steps
past it. The rest is estimated from the current route at equal total XP. The best estimates are then
replayed exactly, 32 at a time. An edit is kept only when the exact replay saves at least 10 seconds.
Shorter gains are not worth a reviewer's time. The windowed replay is adapted from Factoruide (MIT,
used with Joel's permission); see `rust/NOTICE.md`.

### The knee

The descent runs until no edit saves 10 seconds, or 400 edits. That gives a curve of hours against the
number of edits. Most of the gain comes from the first few dozen edits. The cut keeps the edits up to
the **knee** of the curve: the point furthest above the straight line from "no edits" to "all edits"
(the Kneedle method). On recent cuts the knee is 40 to 52 edits, against 168 to 185 edits to converge.
The rest are small gains that would make the route harder to review.

`forge sim route --budget K` keeps exactly K edits instead.

The route file's `edits` field holds the curve, the edit counts for 50 %, 75 % and 90 % of the gain
(`for50`, `for75`, `for90`), the `knee`, the `budget` used and every edit in plain words. Edits past the
budget are listed with `"kept": false`.

### The free search (research only)

`forge sim route` without `--edits` runs the older free search instead: a tournament of 8 members
counted in tries, with bigger moves (move a block, ruin and recreate a stretch, same-place grouping,
exact in-hub order). It finds faster orders but changes far more of v1. The build does not use it. It
is deterministic for a given `--rng`, whatever the thread count.

## 3. The guards

Guards are the judge's own complaints, counted on the order. A kept edit may not raise them. In the
build (`--guard current`) the bound is the current order's counts. With `--guard seed` (the default of
`forge sim route`) the bound is the seed's counts. `--guard off` turns guards off.

| Guard | What it counts |
|---|---|
| Avoidable returns | a later visit to an area for a step that could have been done the first time. A visit ends when the route goes 400 yd away |
| Passed by | quests whose giver a walked leg passes (within 500 yd) while the quest is open and in its level window, never taken or taken only after going 1000 yd away |
| Split work | coming back to a place (within 600 yd of an earlier stop, after going 600 yd away) for work or training that the earlier visit could have done. Never above v1's count in each zone (or the current order's, if higher) |
| Area visits | separate visits to each area. Never more than v1 makes there (or the current order, if it already makes more) |
| Training gaps | the order is at a trainer town more than 4 levels after the last class training |
| Training shifts | every v1 training stays within 2 levels of where v1 has it |
| Grind before hand-in | a grind while a finished quest waits to be handed in on the same trip (within 600 yd and 15 steps) |
| Training bounces | a training whose town is near neither the step before nor the step after |
| Elite or rare camps | tasks that kill an elite or rare mob |

Only walked legs count for passed-by. Flights, boats and hearths do not walk past anyone.

The guards follow the judge's rules on the order itself, so they run in milliseconds. The judge
stays the reference for the reported numbers: see [judge.md](judge.md). `forge sim guards` prints
the guard counts of a chain, and `--export DIR` writes the order as the judge's goal stream so you can
compare.

## 4. Feasibility rules

These rules keep the route playable. Route profiles turn them on. The gate's model leaves them off, so
it stays equal to v1's model.

- **Item needs.** A step that needs an item (an objective item, a quest-starting item, a required
  item) that no mob or object drops and no vendor sells comes after the quest that rewards it. Rewards
  come from EG Link's quest scans. When the scans do not name the item, the provider is a quest of the
  same zone whose title shares a word with the item's name.
- **Escorts.** An escort is walked from its giver. Between its accept and its escort task, only talks
  within 40 yd of the giver may come.
- **Timed quests.** While a timed quest runs, every leg is walked (no hearth, flight or boat). A kept
  edit never adds a late hand-in.
- **Bag items.** An item dropped by more than 20 kinds of mob (cloth for donations) is taken from the
  bags: no trip, no work.
- **Quest log.** See [model.md](model.md#quest-log).

A rule that v1's own order already breaks cannot be a rule for that start. It is left out and named in
the route file's `feasibility` list (as a `note`) and on the console.

## 5. Deliberate orders

Many orders in v1 are there on purpose: player reports fixed them. They live under `deliberate` in the
checkout's `data/route-fixes.json` and every cut keeps them. Each entry has a `why` naming the
report.

| Key | Meaning |
|---|---|
| `pairs` | every step `a` comes before every step `b` (kinds `accept`, `task`, `turnin`) when both are in the order |
| `after` | one step after another, like an item need. A task may be named by its index in the quest |
| `stay` | the step keeps v1's neighbours: after the quest step v1 does just before it and before the one just after |
| `together` | step `b` right after step `a`, with only steps at b's place (within 40 yd) between |
| `southward` | on one map, until a given step, the route only goes south (with a tolerance in yards) |
| `keep` | the quest stays in the route |
| `never` | the quest is never added (its giver does not offer it) |
| `optional` | v1 marks it optional (rare-drop start): not counted on, out of the route |

A pair that v1's own order breaks for a start is left out for that start, named in the route file's
`feasibility` notes, and listed in the build's fixes ledger as `left out` (`fixes.md`; `forge build
--strict` fails on it).

## 6. Worthwhile pickups

After the knee, the pickup pass looks at every quest the route passes by and never takes (the judge's
passed-by rule). Each one is **worthwhile** or **rightly skipped**.

A quest is worthwhile when all of these hold:

- it may be added ([section 7](#7-which-quests-may-be-added));
- it is in its level window where it is passed, and not grey by its turn-in;
- its XP per minute of added time is at least the route's own XP per minute at that level, or at least
  half of it when the detour is under 60 seconds.

The added time is measured, not guessed: the order is replayed with the quest in it, and the time
outside grinding is compared (the detour plus its work).

Worthwhile quests are then inserted where they are passed, best rate first. The accept goes at one of
the 9 cheapest places that keep the rules. The pickup is kept only when the hours to 60 rise by at most
2 minutes and no judge guard (returns, passed-by, training gaps) gets worse. A pickup that fails is
listed in the skip ledger as `judge-refused`, with the guard or the minutes that stopped it.

The route file's `edits.passby` field reports, for v1 and for the cut: the worthwhile and skipped quests
with their reasons, and the **long single-quest trips**: stretches for one quest only that take more
than 3 minutes for less than half the route's XP rate.

## 7. Which quests may be added

An insert or a pickup may only add a quest a solo player can count on:

- solo: no elite work, and no quest that needs one;
- not in a dungeon, raid or battleground;
- not a holiday or event quest, not a profession quest, not repeatable, not reputation-gated;
- it has a recorded XP reward (an estimate would give XP to token and reward quests that give none);
- every objective item has a known source, and it is not a trade-goods hand-in (10 or more of a
  non-quest item);
- when an item starts it, the item is sold or drops at 25 % or better;
- our quest facts are sure of it. Quests with objectives at low or medium confidence, or flagged
  "verify in game", are never added;
- it is not on the deliberate `never` list, and not skipped by an override.

v1's own quests are kept whatever these rules say. The route file's `added` list gives, for each added
quest, why it was allowed.

## 8. The shared 12-60 route and join points

The routes are one start route per race (levels 1 to about 12) and then one shared route per faction
to 60. `forge build` makes it whenever a faction has more than one start (`--starts all`):

1. Every start is cut on its own first (its own route, written to `routes/own/`), and keeps of it
   every step from its guides up to its **join**: the shared `horde/02-the-barrens` for the Horde,
   `alliance/02-westfall` for the Alliance. The split is by guide, not by position, so an edit of
   the own cut that moved a later guide's step before the join does not lose it.
2. From there, one order: the first start's own tail (the **canonical** start: Orc, Human).
3. The local edits of [section 2](#2-local-edits-with-a-budget) improve that tail. An edit is kept only
   when **no start gets slower**. The knee is taken on the sum over the starts.
4. Each start plays the shared tail with its own travel plan for its own part and the canonical
   start's plan for the tail. A plan item on a step that does nothing for that start (a hand-in of a
   quest it never took) moves to the next step that does something.
5. Each start's route (its own part + the tail, the tail's steps it does not play left out) is
   reported against its own v1, written by the writer and judged like any route. `routes/starts.json`
   lists every start's v1, own-cut and shared hours to 30 and 60.

`forge sim widen` makes the same shared tail from v1's own orders (not from the own cuts), for study.

`forge sim widen --diagnose` compares, for each start, its own v1 order against its prefix plus the
canonical tail, guide by guide. It shows the gap, levels, grind and travel minutes, hearths and
no-op steps. Use it before changing the join.

What we found with it:

- **Horde**: Orc's race folder has its own Barrens guide. The other starts do the early Barrens quests
  inside the shared Barrens guide. Joining after the shared Barrens guide (`--join-after
  horde/02-the-barrens`, about level 19-20) fixes that. The shared order from Silverpine on then costs
  no Horde start anything; each start comes out 0.2 to 0.5 model hours faster than its own cut.
- **Alliance**: Human's v1 tail is faster for every Alliance start. But Human plays part of
  Westfall's quests from its own Elwynn guide and the others inside `alliance/02-westfall`, so with
  the own cuts a join before Westfall dropped six of the others' Westfall quests (the first all-10
  build, RsSim.md "forge all-10"); `forge build` joins after Westfall.

`forge sim shared` is the older version: it runs the free search on each start, then on one order
scored over every start × the slow, average and fast class profiles. It reports, per start and
profile, the join level, v1, the start's own best, the shared order and the hours lost.

## 9. What a cut writes

`forge build` writes these under `<out>/routes/`; `forge sim route --out DIR/NAME.json` writes them
beside the given file. NAME is the start's stem (`Orc`, `Skyborne-horde`, `NightElf`, ...).

| File | What it holds |
|---|---|
| `NAME.json` | the route: hours for v1 and the cut in several models, guards, added and dropped quests, feasibility rules, the edit curve and list, and `order` |
| `NAME.skips.json`, `NAME-skips.md` | the skip ledger |
| `NAME.edits.json`, `NAME-ledger.md` | the edit ledger |
| `NAME.judge-v1.json`, `NAME.judge-improved.json` | v1's order and the cut as the judge's goal stream |

Each `order` entry has `t` (`accept`, `task`, `turnin`, `level`, `train`), `lvl` (the level before the
step), the quest id `q`, the task index in the quest, the place `pt`, `from` (the guide file and line,
`inserted` or `train stop`), and for `level` steps the fractional `target`. `items` lists what the
model decided on the way: `bind` (with `used` when a hearth to it follows, and `returns`: later separate
visits to that town), `hearth`, `network` legs (flights, boats, zeppelins, trams, with the path), long
`walk` legs and `getfp`. The writer reads this ([writer.md](writer.md)).

The hours blocks (`v1`, `improved`, and `v1Gate`, `improvedGate`, `v1Other`, `improvedOther`) each give
`hours30`, `hours60`, quests, grind and travel hours, zone returns, hearths, flights, trainings, the log
peak, late hand-ins and along kills. `holdout` and `inSample` give the gain over v1 under parameter
draws ([model.md](model.md#counters-parameter-draws-and-the-held-out-gain)).

### The skip ledger

One row per quest the start could do but the route does not take. That covers quests passed by,
quests available but not taken, quests dropped from v1 and quests left out of the world. Other-faction
quests, quests for other races and unused quests are not listed.

Each row has the quest id and title, its level and XP, the guide where it would fit (the guide of the
stop nearest its giver, or its zone), a `reason` code, a `detail` sentence, the `numbers` behind it
and the deciding `source`. A timed quest also has `timerMin`.

The `source` is one of `game data`, `server data` (facts from an open server database), `mechanics facts`,
`player report`, `data corrections`, `route model` or `route-fixes.json`.

A `missing-info` row also has `missing`: a list of what Forge does not know, each with `fix`, the file a
fix goes into:

| What is missing | Where the fix goes |
|---|---|
| objectives, quest giver, turn-in NPC, or who can take it (races, classes, side) is uncertain | `forever-db/corrections/quests.json`, `<id>.set.<field>` |
| the sources disagree (to verify in game) | the same file |
| the giver's, turn-in's or objective's place is unknown | the same file: the NPC's or object's spawns |
| an item source is unknown | the same file: the item's drops or vendors |
| how the quest works is known only at medium confidence, and that drives the route | our mechanics facts |

The ledgers are recomputed from the data on every cut. Nothing is cached as a decision: fix the data
or add an override, and the next cut judges the quest again.

### The edit ledger

One row per edit the cut keeps against v1, pickups included. Each row has the number `n`, the `kind`
(`move`, `fold`, `fold later`, `insert`, `pickup`, `drop`), the steps it moved (`t`, quest, task index),
`from` and `to` (positions in the order before the edit), the `text` in plain words, the `reason`, the
minutes saved (`savedMin`; negative for a pickup that costs time), the guards it passed, and `revert`:
the one line for the overrides file that undoes it.

## 10. Reason codes

| Code | Meaning |
|---|---|
| `override` | an override skips it |
| `missing-info` | Forge does not know enough to count on it: the row's `missing` says what |
| `elite/group` | elite or group work, or a dungeon, raid or battleground quest |
| `chain-not-open` | a quest before it is not in the route, or it would do nothing where it is passed |
| `zone-left` | the route never passes its giver at a level that opens it, or its work or turn-in leads off the route |
| `low-value` | its XP does not pay for its detour, it was dropped from v1 because its trip cost more than its XP, or it is repeatable, has no reward or is a trade-goods hand-in |
| `level` | passed only where it is too low, too high or grey, or it is endgame |
| `rare-drop` | it starts from a rare drop (v1 marks it optional) |
| `pvp/event/profession/rep` | PvP, holiday or event, profession or reputation quest |
| `judge-refused` | worthwhile, but picking it up raised a judge guard or cost more than 2 minutes |
| `player-report` | a player report says it is not offered, or a deliberate order rules it out |
| `dropped` | in v1's order, but does nothing in the cut's replay: its chain or level is not open where v1 has it |
| `other` | none of the above: read `detail` |

## 11. Overrides

Overrides are for a maintainer who knows better than the model. They live under `overrides` in the
checkout's `data/route-fixes.json`, beside the deliberate orders; the build reads the file at run time,
never from inside `forge`. Set `POLESTAR_ROUTE_FIXES` to the path of another file to use that one
instead. Every cut honours them as hard rules, and the ledgers show `override` as the reason. The file
is part of the routes stage's cache key, so changing it rebuilds the routes.

```json
"overrides": {
	"include": [
		{ "q": 1234, "after": ["turnin", 1200], "reason": "players take it here", "issue": 456 }
	],
	"skip": [
		{ "q": 2345, "reason": "the giver is not there in Forever", "issue": "#457" }
	],
	"revert": [
		{ "s": ["task", 3456, 0], "reason": "keep the cave visit where v1 has it", "issue": 458 },
		{ "q": 4567, "edit": "drop", "reason": "keep it", "issue": "" },
		{ "q": 5678, "edit": "insert", "reason": "not worth it", "issue": "" }
	],
	"pairs": [
		{ "a": ["accept", 100], "b": ["task", 101], "why": "take 100 before working 101" }
	]
}
```

(The quest ids above are made up.)

- **`include`**: the quest goes into the route and stays. Its accept goes right after the `after` step
  (kind and quest) when given, else after the stop nearest its giver. Its tasks and turn-in go at
  their cheapest places within 300 steps after it.
- **`skip`**: the quest is never in the route, never inserted and never picked up.
- **`revert`** undoes one edit. Copy the `revert` line from the edit ledger:
  - `{"s": [kind, quest, task index]}` keeps that step between v1's neighbours (undoes a move or fold).
    Leave out the task index to hold every task of the quest;
  - `{"q": id, "edit": "drop"}` keeps a quest the cut dropped;
  - `{"q": id, "edit": "insert"}` undoes an insert or pickup (the same as a skip).
- **`pairs`**: precedence rules in the shape of `deliberate.pairs`. v1's order is first made to keep them,
  then every edit keeps them.

`reason` and `issue` are shown in the ledgers. `issue` may be a number or a string like `"#457"`.
Quests the start cannot take are ignored.

## 12. Asking why

`forge sim why` tells you where a quest is in a cut and which edits moved it, or, when it is not in the
route, its skip row with what is missing and where the fix goes:

```sh
forge sim why 1234 --start Orc --dir out/routes
```

It reads `Orc.json`, `Orc.skips.json` and `Orc.edits.json` from `--dir`, else `<O>/routes` for
`--out O` (a `forge build` output, e.g. `--out forge-out`), else `POLESTAR_ROUTES`.

`forge sim skips` merges the skip ledgers of every start in a folder into one markdown table, one row
per quest, with the starts it applies to:

```sh
forge sim skips --dir out/routes
forge sim skips --reason missing-info --dir out/routes
```

With `--reason missing-info` this is the "help us with these quests" list for players.

## 13. Running it

The normal way is the build. It runs every stage, and the routes stage reruns only when its inputs
change:

```sh
forge build --guides guides --out out --starts Orc,Human
```

The routes stage uses the average profile, an edit budget of up to 400 edits cut at the knee,
`--guard current` and 16 held-out draws. Its log prints, per start, v1's hours, the cut's hours, the
number of edits and of skipped quests.

To cut one start by hand, use `forge sim route`. By default (`--seed guides`) its seed is the goal
stream of the current guides (`--guides DIR`, default `<root>/guides`), made as `forge build` makes it;
`--seed <file>` takes a chain as a `{"goals": [...]}` document. Only when `POLESTAR_V1_SEEDS` is set
does the default read saved `v1-<faction>-<race>-on.json` chains from that folder instead; nothing
else needs it. To match the build:

```sh
forge sim route --faction Horde --start Orc --edits 400 --guard current --world-dir out/.forge/sim --out cuts/Orc.json
```

| Flag | Default | Meaning |
|---|---|---|
| `--faction`, `--start` | required | the faction and the race |
| `--seed guides\|FILE` | `guides` | the seed chain |
| `--out FILE` | required | the route file; the ledgers go beside it |
| `--edits N` | off | the edit budget search with at most N edits (else the free search) |
| `--budget K` | the knee | keep exactly K edits |
| `--guard off\|current\|seed` | `seed` | the guards' bound |
| `--profile avg\|slow\|fast\|gate` | `avg` | the class profile ([model.md](model.md#class-profiles-and-the-class-agnostic-route)) |
| `--walks on\|off` | `on` | routed walks, or straight lines × detour |
| `--param name=value` | none | a model parameter, repeatable (`--param camps=1 --param spots=1`) |
| `--tries N`, `--members M`, `--share-every S`, `--rng R` | 20000, 8, 250, 1 | the free search |
| `--search-draws K`, `--holdout N` | 0, 16 | parameter draws to search under, and to report under |
| `--threads T` | 8 | threads; the result does not depend on it |
| `--root DIR`, `--world-dir DIR` | `.`, `DIR/data/sim` | the checkout, and the folder with `world-<faction>.json`, `walks-<faction>.bin` and `params.json` |

The shared tail, with the Horde join used above (each start's seed made from the guides, as for `route`):

```sh
forge sim widen --faction Horde --starts Orc,Tauren,Undead,Skyborne --join-after horde/02-the-barrens --out horde-shared.json
forge sim widen --faction Horde --starts Orc,Tauren,Undead,Skyborne --join-after horde/02-the-barrens --diagnose --out horde-diagnose.json
```

`widen` also takes `--edits`, `--budget`, `--members`, `--threads` and `--param`. Its console prints,
per start, v1's own hours, v1's prefix plus the canonical tail, the knee and the converged hours. Each
edit in its output has `byStart`: every start's hours and minutes saved.

## 14. When it goes wrong

| Symptom | Likely cause | What to do |
|---|---|---|
| `seed ...: No such file` | a `--seed` file, or (with `POLESTAR_V1_SEEDS` set) that folder, without the chain | pass another `--seed`, or unset `POLESTAR_V1_SEEDS` to seed from the guides |
| `knowledge base: ...` | our quest facts are not where Forge looks | set `POLESTAR_KB`, or build the data first ([data.md](data.md)) |
| `warning: walks-....bin was built on world ...` | the walks are older than the world | rebuild the walks ([nav.md](nav.md)); hours are not comparable until then |
| `v1 breaks deliberate pair: ...: left out` (also in `fixes.md` as `left out`) | the guides changed, or a pair is wrong for this start | check the pair's `why`; fix the pair or the guide |
| `v1 breaks together / southward ...: left out` | the same for a `together` or `southward` rule | the same |
| A quest you expect is missing | read its skip row | `forge sim why <quest> --start S --dir out/routes`; fix the data, or add an `include` |
| An edit makes the guide worse to play | the model does not see the problem | copy its `revert` line into `overrides` in `data/route-fixes.json`; if a guard should have caught it, report it |
| A player says a quest is not offered | the route still counts on it | add a `skip` override with the issue number, or a `never` entry under `deliberate` |
| Few or no edits kept | the guards or rules refuse them | compare `guardsV1` and `guardsImproved`; `search.guardRejected` counts refused gains (free search) |
| The routes stage did not rerun | its inputs did not change | it reruns when the data, world, walks, guides, quest facts, `params.json` or `data/route-fixes.json` change |

## 15. Changing it

| To change | Look in |
|---|---|
| the routes stage and its defaults | `forge-sim/src/stage.rs` (`RouteOpts::forge`) |
| the steps of a cut | `forge-sim/src/route.rs` (`prepare`, `improve`) |
| the seed and training stops | `forge-sim/src/order.rs` (`seed_order`, `place_trains`) |
| edit kinds, the knee | `forge-sim/src/search/edits.rs` |
| the windowed replay and the free search | `forge-sim/src/search.rs` |
| pickups and long trips | `forge-sim/src/search/passby.rs` |
| guards | `forge-sim/src/guards.rs` |
| who may be added | `forge-sim/src/insertable.rs` |
| item needs | `forge-sim/src/needs.rs` |
| ledgers, reason codes, `why` | `forge-sim/src/ledger.rs` |
| the shared route | `forge-sim/src/widen.rs`, `forge-sim/src/shared.rs` |
| deliberate orders, overrides | `data/route-fixes.json` (read by `forge-sim/src/fixes.rs`) |
| the commands | `forge/src/cli/sim.rs` |

The tests `tests/overrides.rs` and `tests/feedback_guards.rs` in `forge-sim` pin the overrides and the
feedback guards. They need the game data and skip themselves without it. When you add a reason code,
add it to the table above and to `ledger.rs`'s `skips`.
