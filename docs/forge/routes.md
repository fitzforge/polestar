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
4. improves the order with **local edits**, one at a time, best first, until none saves time;
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

A training teaches the class ranks between the last one trained and the character's level, at the
rank levels of the world's training table (1, 4, 6, 8, 10 and every even level on). Every class
trainer teaches every rank, a starting valley's too: the world DB's per-trainer spell lists stop at 6
for the starting areas, but in game those trainers teach the higher ranks (Fitz). A training with
nothing new to teach does nothing: the seed leaves it out (v1's own included: Northshire at 3.06, a
second Goldshire training at 9.73), and the search never makes one.

A town need not have every class's trainer (Razor Hill has no Mage trainer; Goldshire none for Hunters
or Druids). A training there also costs, for each of the race's classes it has no trainer for, that
class's share (one over the race's classes) of a round trip to the nearest hub with its trainer in the
town's region. A class with no trainer in the town's region at all (Darnassus has no Paladin, Mage or
Warlock trainer on Teldrassil; Undercity no Hunter, Shaman or Druid trainer in the Eastern Kingdoms)
costs its share of a round trip by the model's travel (flights, boats) to the nearest town that trains
it. The writer writes `train class only <the classes it has>` there and the others at their nearest
pass.

A stop is added:

- where a town has a new rank to teach;
- where the order passes within 600 yd of a town, or where a long leg passes a town and the town adds
  at most 90 seconds (within 400 yd of the straight line);
- never when one of v1's own trainings comes within the next level.

Each added stop then moves (up to 40 steps either way) to the cheapest place where the character has
the same new ranks. A stop that lands next to another training is dropped: that one covers it.

A rank never waits more than 4 levels for its training (the route benchmark, Human 12-30: the level 20, 22 and
24 ranks waited from the 19.3 training in Lakeshire to 25.7 at Goldshire). Where the character
reaches a level with a new rank and the order's next training comes 4 or more levels later, a
training at the nearest town that teaches it goes right after the first stop at a flight master within
80 steps: a trip from the route's own flight path, priced by the model. No flight master passed, no
stop.

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
| `insert` | adds a quest whose giver the route passes (within 500 yd, at a level that opens it). Every later step of it goes to its cheapest place in its own zone within 200 steps, else to the cheapest place of the route's next visit to that zone. The accept goes to the cheapest pass (of the 8 cheapest) from which its later steps can follow: the cheapest pass outright can come after the route's last visit to its work's zone (c13 Orc's Goblin Invaders, `zone-left`: passed at 26.9 after the route's only Stonetalon visit, and at 23.5 before it) |
| `ride` | moves the riding step to the first visit to the riding trainer at level 40 or above |
| `drop` | removes a quest that costs a trip. A quest whose every stop is on the way to other quests is never dropped |
| `chain insert` | adds a quest the route passes with the quests it opens, each inserted as `insert` does after the hand-in that opens it (up to 6): a chain valued together, not its head alone (the route benchmark's rule 1: Goblin Invaders, Meats to Orgrimmar, Blood Feeders dropped as low-value alone, their follow-ups then `chain-not-open`) |
| `zone block` | adds a zone's open chains as one visit: per map, the quests that may be added whose every step is on it and whose level window is open, with the quests they open (3 to 12), after the stop within 3000 yd of their givers where most of them are open and on level; the block walks them nearest first, then the route goes on (Stonetalon south at 17-19, where a benchmark guide goes) |
| `drop trip` | drops together the quests of a trip off the continent and back whose every step is on the trip and that are 3 or more levels under the character there (the route benchmark's rule 2: the 16-19 Silverpine trip from the Barrens) |
| `drop grind` | drops a v1 grind checkpoint that guards no gate (below) |
| `gate later` | moves a v1 grind checkpoint that gates an accept (not a training) to just before the first accept it gates, when no training or other grind is between: the hand-ins before it count first (Feralas' level-45 grind before Shay's escort and the Feathermoon hand-ins) |
| `join` | takes a quest on an earlier visit to its giver (a stop within 120 yd, the route gone 400 yd away since, the quest open then), tried on the latest and the earliest such visit. Each of its objectives goes right after the first other quest's work on the same ground (sites within 200 yd, where pooled kills do it; mobs no more than the model's work gap over the character), else stays; its turn-in goes to the first visit to its ender after its work, else stays. A quest whose every objective is carried in the bags (cloth donations) and whose ender is its giver is handed in right after its accept |
| `stay later` | moves a whole zone stay (6 or more quest steps) past the stays after it, up to four zone stays of that size (a town stop between does not count; 12 stays in all), so a zone is entered nearer its quests' level instead of with a grind before early work (a benchmark guide enters Desolace at 33.2 and Stranglethorn at 35.3, after Hillsbrad, the low half of Arathi and the Shimmering Flats; our c12 Orc at 30.0 and 33.5, with 288 and 410 model minutes of grind there on the quests both take; benchmark guides enter the Plaguelands once at ~56, ours at 52.4). The stays it passes come earlier, and none of their objectives may then be more than 2 levels under its quest |
| `stay split` | takes the quests of a zone stay that are 3 or more levels under the character there (their XP cut, or grey soon; at least 3, each wholly in the stay) and does them, in their order, at the start of one of the first 3 earlier stays where none of them is more than 2 levels above the character: a zone's low half as its own visit on level (a benchmark guide does Arathi's low half at 31-32 and its high half at 38; our c12 Orc all of it at 38.3). Like `stay later`, not held to the straight-walk rule |

v1's grind checkpoints stay when they guard a gate the model cannot see: their guide step or the next
one trains (the level-20 grind before the Orgrimmar class quests), takes a class quest, or takes a
quest whose minimum level the checkpoint reaches. The others may be dropped (`drop grind`): the
quests around them give the XP (the route benchmark's rule 3: 72 grind minutes in our Barrens 12-21.5
against none in a benchmark guide).

Every candidate edit must pass all of these:

- the quest's own order holds (accept before its tasks, tasks before the turn-in);
- every deliberate order, feasibility rule and override holds ([section 4](#4-feasibility-rules),
  [section 5](#5-deliberate-orders));
- it adds no second training right after a training;
- a move does not lengthen the straight walk over the stretch it changes by more than 100 yd. A
  reviewer reads a guide by its straight legs, and a longer one splits a visit. A `stay later` or
  `stay split` moves whole stays or a stay's own quests as a visit of their own, so it is not held
  to this (the model prices its travel);
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

What an edit is priced in: the route's **cost**, its hours to 60 with every grinding hour counted
`grindWeight` times (2.5, a policy parameter of the simulator's, not a measurement). Grinding is the
worst way to level for a player (Fitz: 72 minutes of it is terrible), so a route grinds only where
no quest is nearly as good: a quest that gives XP faster than grinding's weighted price is worth its
detour even when grinding itself is a little faster. In the model a level-30-40 grind earns ~390 XP
a minute and the route's own questing there ~420, so priced in plain hours the search left quests at
360-470 XP a minute as `low-value` and ground instead (c12 Orc: 30.7 h of grinding, 14 blocks over 15
minutes). Every rule below that speaks of "the hours to 60" (the 10 seconds an edit must save, a
pass's allowance, no start slower on a shared tail) reads them as cost, and so do the edit list's
`hours`, `savedMin`, `curve` and `free` hours. The hours blocks (`v1`, `improved` and the others)
stay real hours.

### Where the descent stops, and the knee

The descent runs until no edit saves 10 seconds, or 400 edits. That gives a curve of hours against the
number of edits. Most of the gain comes from the first few dozen edits, and the rest is many small ones.

By default the route keeps **every edit** the descent made (`--cut all`). Each saves at least 10
seconds, and the route check (`forge judge check`, [judge.md](judge.md#the-route-gate-forge-judge-check))
reads the written guides for what a player would trip on, so the small edits no longer need a person to
read each one. On c4 keeping every edit saved Orc about 0.9 h and Human about 1.5 h of model time over
the knee.

`--cut knee` keeps the edits up to the **knee** of the curve instead: the point furthest above the
straight line from "no edits" to "all edits" (the Kneedle method). That is the fewest edits for most of
the gain, for a route someone wants to review edit by edit. On recent cuts the knee was 40 to 75 edits,
against 75 to 180 edits to converge.

The cap of 400 edits has not been reached (c4: at most 181 for a shared tail, 79 for an own cut). If a
descent does reach it, the log says so and the edit ledger has `"capped": true`: raise the cap.

`forge sim route --budget K` keeps exactly K edits, whatever `--cut` says.

The route file's `cut` says which cut was used. Its `edits` field holds the curve, the edit counts for
50 %, 75 % and 90 % of the gain (`for50`, `for75`, `for90`), the `knee` (always worked out, whatever the
cut), the `budget` (the edits kept), `capped`, and every edit in plain words. Edits not kept are listed
with `"kept": false`.

### The free search and the hybrid

`forge build --search free` (and `forge sim route` without `--edits`) runs the free search instead: a
tournament of members counted in tries, with bigger moves (move a block, ruin and recreate a stretch,
same-place grouping, exact in-hub order). `--search hybrid` runs the free search, then the edit descent
from its order, in memory. The build's free search takes `--tries` (2,000,000) over `--members` (24).
Both are deterministic for a given rng, whatever the thread count. The build's default stays
`--search edits`.

A free-search move keeps every rule the edit descent keeps: the replay's (no added no-op, late
hand-in, hearth line on cooldown, quest log over its bound, guard raised), the checker's (deliberate
orders, item needs and lock keys, `after` and `stay` records, together, keep, skip, southward,
escorts), and the descent's own: no training right after a training, a reorder adds at most 100 yd to
the straight walk over the stretch it changes, v1's grind checkpoints that guard a gate stay, no quest on the way is
dropped, and no objective is moved earlier to more than 2 levels under its quest's level. On a shared
tail, no start may be slower for a kept move.

A free or hybrid route's edit list starts with the free search's difference from the seed: each
quest added (`insert`), dropped (`drop`) or reordered (`free move`, with how many quest events it
moved), with no minutes of their own; `edits.free` gives the hours before and after the free search.
In hybrid mode the descent's edits follow.

## 3. The guards

Guards are the judge's own complaints, counted on the order. A kept edit may not raise them. In the
build (`--guard current`) the bound is the current order's counts. With `--guard seed` (the default of
`forge sim route`) the bound is the seed's counts. `--guard off` turns guards off.

| Guard | What it counts |
|---|---|
| Avoidable returns | a later visit to an area for a step that could have been done the first time. A visit ends when the route goes 400 yd away. The total never rises above the bound; and area by area against the current order, a return added to an area is kept only when the edit saves 5 minutes more for each one it adds (a return removed elsewhere does not pay for it) |
| Passed by | quests whose giver a walked leg passes (within 500 yd) while the quest is open and in its level window, never taken or taken only after going 1000 yd away |
| Split work | coming back to a place (within 600 yd of an earlier stop, after going 600 yd away) for work or training that the earlier visit could have done. Never above v1's count in each zone (or the current order's, if higher) |
| Area visits | separate visits to each area. Never more than v1 makes there (or the current order, if it already makes more) |
| Training gaps | the order is at a trainer town more than 4 levels after the last class training |
| Training shifts | every v1 training stays within 2 levels of where v1 has it |
| Grind before hand-in | a grind while a finished quest waits to be handed in on the same trip (within 600 yd and 15 steps) |
| Training bounces | a training whose town is near neither the step before nor the step after (a training due, section 1, is a trip to the trainer by design and not counted) |
| Elite or rare camps | tasks that kill an elite or rare mob |
| Left ready | accepts and hand-ins done on a return to a hub although they were ready when the route last left it (the check's `left-ready`, below) |
| Walked past | hand-ins whose ender a walked leg passed within 50 yd while they were ready, the route then going 200 yd from the ender before handing in (the check's `walked-past`) |
| Low trips | trips off the continent and back whose quest steps are at least two thirds for quests 3 or more levels under the character, taken while a quest no more than 2 levels under it is in the log with a step left on the continent the route leaves (the route benchmark's rule 2: stay on the continent while on-level quests are open there) |

Only walked legs count for passed-by and walked past. Flights, boats and hearths do not walk past anyone.

A **hub** is read as `forge judge check` reads it: the order's NPC places (accepts, hand-ins,
trainings) linked within 120 yd, so Brill's Holland and Zygand (166 yd apart) are one hub through
Dillinger. A step is at a hub when its place is one of the hub's or, for work, within 120 yd of one;
a **visit** is a run of consecutive steps at one hub (a grind checkpoint neither ends nor joins
one). The route has left a visit at the first step 200 yd from every place of the hub. An accept is
ready when the character is at its minimum level and no more than 5 levels under the quest, its
prerequisites are handed in and nothing closes it; a hand-in when its quest is in the log and every
objective step of it is done. Legs are straight lines between steps (the walk store holds yards,
not paths). The code is `forge-sim/src/hubs.rs`.

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
- **Locked objects.** An item that only comes out of locked objects (objects.json `lock.item`, from the
  data corrections: Benedict's Chest) is got after the first task that kills a mob dropping the key or
  collects it (Benedict's Key from Lieutenant Benedict, before The Admiral's Orders).
- **Escorts.** An escort is walked from its giver. Between its accept and its escort task, only talks
  within 40 yd of the giver may come.
- **Timed quests.** While a timed quest runs, every leg is walked (no hearth, flight or boat). A kept
  edit never adds a late hand-in.
- **Bag items.** An item dropped by more than 20 kinds of mob (cloth for donations) is taken from the
  bags: no trip, no work.
- **Quest log.** See [model.md](model.md#quest-log).

A rule that v1's own order already breaks cannot be a rule for that start. It is left out and named in
the route file's `feasibility` list (as a `note`) and on the console.
A route-fixes `after` rule v1's order breaks with both steps on one map is kept instead: the later
step (and its quest's turn-in) moves to just after the step it needs, before the search, and the
route's `feasibility` list names the move.
A `together` rule v1's order breaks is kept the same way: the `b` step moves next to the `a` step
(with the steps of b's quest that must stay on its side), so a "do these together" record pulls a
step earlier as well as later. A `together` rule's task without an objective index means the
quest's first objective's place.

## 5. Deliberate orders

Many orders in v1 are there on purpose: player reports fixed them. They live under `deliberate` in the
checkout's `data/route-fixes.json` and every cut keeps them. Each entry has a `why` naming the
report.

| Key | Meaning |
|---|---|
| `pairs` | every step `a` comes before every step `b` (kinds `accept`, `task`, `turnin`) when both are in the order |
| `after` | one step after another, like an item need. A task is named by its objective's index in the quest (0-based, as `collect … quest Q.N` counts from 1): the task that objective is worked at; an index the quest has no objective or task for leaves the rule out (never another quest's task) |
| `stay` | the step keeps v1's neighbours: after the quest step v1 does just before it and before the one just after |
| `together` | step `b` right after step `a`, with only steps at b's place (within 40 yd) between |
| `southward` | on one map, until a given step, the route only goes south (with a tolerance in yards) |
| `keep` | the quest stays in the route |
| `never` | the quest is never added (its giver does not offer it) |
| `optional` | v1 marks it optional (rare-drop start): not counted on, out of the route |

A pair that v1's own order breaks for a start is left out for that start, named in the route file's
`feasibility` notes, and listed in the build's fixes ledger as `left out` (`fixes.md`; `forge build
--strict` fails on it). An override pair v1 breaks is kept instead: b's steps move after a's, and
with them the steps between of the quests that need b's quest handed in, theirs in turn (a pair
that moved Buzzbox 827's hand-in after Fruit of the Sea had left Buzzbox 411, 323 and 525 taken
before 827 was handed in, doing nothing: the route benchmark, Darkshore).

## 6. Worthwhile pickups

First the **stay on the continent** pass (the route benchmark's rule 2): each low trip (the guard
above) is taken out by the cheapest edit that removes it: its low quests, its every quest, or every
quest with the continent's best zone block in its place. It is kept when the order keeps its rules,
no guard rises and the hours to 60 rise by at most 15 minutes (two zeppelins and two hearths for
quests at 40-60 % XP are the worst place for them); its edit is `stay on continent`, counted in
`stayOnContinent`.

Then the pickup pass looks at every quest the route passes by and never takes (the judge's
passed-by rule). Each one is **worthwhile** or **rightly skipped**.

A quest is worthwhile when all of these hold:

- it may be added ([section 7](#7-which-quests-may-be-added));
- it is in its level window where it is passed, and not grey by its turn-in;
- its XP per minute of added time is at least the route's own XP per minute at that level, or at least
  half of it when the detour is under 60 seconds.

The added time is measured, not guessed: the order is replayed with the quest in it, and the time
outside grinding is compared (the detour plus its work). A quest not worthwhile alone is valued with
the quests it opens (a `chain insert`, above): the chain's XP over the chain's added time
(the route benchmark's rule 1). Its edit says which quests came with it. A quest refused because its place breaks a
rule names the rule (`breaks a rule where it is passed: deliberate pair …`, `escort: …`, `feasibility:
…`); only a deliberate record is a `player-report`. The places tried are the cheapest few, until one
keeps the rules.

Worthwhile quests are then inserted where they are passed, best rate first. The accept goes at one of
the 9 cheapest places that keep the rules. The pickup is kept only when the hours to 60 rise by at most
2 minutes and no judge guard (returns, passed-by, training gaps) gets worse. A pickup that fails is
listed in the skip ledger as `judge-refused`, with the guard or the minutes that stopped it.

Then the **hub pickup** pass takes what the route stands next to. A quest the order takes on a later
visit to its giver, although it was open on an earlier visit, is moved there by a `join` (its work
goes beside other work on its ground, its turn-in to the next visit to its ender). The move is kept
when the hours to 60 rise by at most 3 minutes (taking what the player stands next to is worth a
little model time) and no judge guard gets worse. One quest is tried at a
time, against the order as it is then. The shared route's tail gets the same pass (the 3 minutes are
summed over the starts). Kept moves are listed as `hub pickup` edits; the edit list's `hubPickups`
counts them.

Then the **bag ties**: a quest done from the bags (the cloth donations: every objective an item
so many kinds of mob drop that the player carries it, its ender at its giver) is taken, done and
handed in at once where the order still leaves its hand-in for a later trip (FlowDiag, c13: Runecloth
7826 accepted at step 1788, handed in at 1803; the pickup refused it for the avoidable return its
guard then counts at the later visit, which is there for other quests). Kept when the order keeps
its rules, no guard rises beyond its bound and the hours to 60 rise by at most 30 seconds (a tie);
listed as `bag tie` edits, counted in `bagTies`.

Last, the **camp gather** pass joins a camp worked in two halves in one visit (an NPC step or a
nearby sub-area in the middle). It reads a camp as `forge judge check`'s `merge` rule does: two
objective steps form one camp when their spawn areas come within 150 yd (an objective's area is
its compiled guide goal's spawn spots, the ones the check reads; a quest v1 never had, its site),
the later one's quest is in the log at the earlier one, and no stop between them is 300 yd from
both areas (at most 40 steps apart). The later objective moves right after the earlier one, or the
earlier right before the later. The steps that were between them then come after, or before, the
joined work. The order's rules keep an accept before the work it opens and a hand-in after the work
it needs, so a quest opened only by the in-between step is never joined early. A move is kept under
the same 3-minute and guard terms as a hub pickup. Kept moves are listed as `camp gather` edits; the
edit list's `campGathers` counts them. The shared tail gets the same pass.

Then the **hub batch** (the route benchmark's rule 6: Razor Hill 5 visits in a benchmark guide
against 8 in ours, Bloodhoof 6 against 9-10; it comes back to a hub when several hand-ins are ready
together). A return to a hub
for at most 2 accepts and hand-ins, a hand-in among them, is folded into the next visit to that hub;
so is a whole visit of quest steps and trainings whose next visit to the hub comes within a level
(c13 Alliance: Stormwind and Ironforge at 58.6 and again at 59.4, mostly cloth, a boat each way).
It is kept when the order keeps its rules, no guard rises (left ready and walked past included), the
hub's visits drop and the hours to 60 rise by at most 3 minutes; work between the two visits may
come up to half a level lower for the delayed XP. Kept moves are listed as `hub batch` edits; the edit
list's `hubBatches` counts them. The shared tail gets the same pass. Its guard is the planner's
straight-line count; the written check (below) undoes a batch whose steps it finds walked past.

Then the **hub sweep** (Fitz in Brill, c12: sent to pick up a quest past three quest givers he
would come back to, past ready hand-ins, and back and forth in town). Each accept or hand-in the
left-ready and walked-past counts point at moves into the visit where it was ready (at one of the
3 places in it with the least straight detour, after what it needs) or onto the walked leg that
passes its NPC; a ready accept whose giver a leg passes within 50 yd moves onto that leg too (the
planner's own count; the check counts hand-ins). A move is kept when the order keeps its rules, no
guard rises, the counts drop and the hours to 60 rise by at most 3 minutes: the route still comes
back later when that is cheaper by more. (The hub passes price a move by its exact replay: the
windowed estimate can be minutes off for a hand-in moved earlier.) A move refused is tried again,
up to three times, after another move is kept. When a move is refused because it leaves its own quest's
next step behind (an accept moved onto a leg, its hand-in then passed on the way), the two moves
are tried together. Last, each visit's stops go in the order of the shortest straight walk from
the stop before the visit, through its places, to the stop after it (exact over orders of up to 16
places, a place's steps together, the steps of one quest and of quests a chain or a deliberate
order links kept in order), when that walks 20 yd less and adds at most 30 seconds. Kept moves are
listed as `hub sweep`, `on the way` and `hub loop` edits; the edit list's `hubSweeps` counts them.
The shared tail gets the same pass. The left-ready and walked-past counts read a flight, boat or
zeppelin leg as the walk to its departure flight master or dock and the walk from its arrival one
(c13: Grom'gol, Brackenwall, the Steamwheedle boat, Theramore were walked past unseen).

Then **trainings at the hub**: a training whose steps either side are both work away from its town
(beyond 120 yd) splits the field work (c13 Shadowglen: the level-4 training between the cave's
tasks). It moves to right before the stretch's first task, else right after its last, within a
minute; a kept move never puts one there again. Listed as `train at the hub`, counted in
`trainsAtHub`. A lead-in's hand-in also stays ahead of its follow-up's accept (the quest data's
`next`), as a deliberate pair: the hub loop no longer swaps them (c13 Teldrassil).

A deliberate `together` pair whose task has its kill work at several camps is done at its camp
nearest its pair (the Raptor Horns with Vrang's hides in the Dry Hills, #274), so the two are one
visit.

A task's other places come from the world (a task's `alts`: a buy's other friendly vendors, an
object's other spawn sites; world points, so the walks stage walks them). On the route profiles a
buy is made on the way: a stop at one of its vendors within an hour of play before the accept
buys it (no trip at the task; c13 flew from Dustwallow to the Crossroads for Soothing Spices where
v1 buys them in Ratchet on the way in), else at the vendor that costs least from where the route is
and on to its next stop. The route's `buy` items name where (the stop's step, the vendor). An
object task with no other quest's task within 70 yd of its site takes the other site that has one,
nearest its giver (the Well Stones at Winterhoof by Rite of Vision's totem, not at Thunderhorn).

A start may play shared guides in its own part (`shared::own_guides`; Fitz, 2026-10-27): Night Elves
do Darkshore with Teldrassil, then join at Westfall. Their goal stream puts 03-darkshore's goals
before the first Westfall goal, so their own cut holds them; the shared tail stays the same for every
start, and a Night Elf's tail steps from 03-darkshore are left out (no return at 15).

On c12's orders (walks off, no travel plan) the sweep took the left-ready count from 85-127 per
start to 45-74, walked past from 29-35 to 15-26 and the accepts passed on the way from 39-61 to
16-23, within ±0.25 model hours.

Then **hub revisits**: a hub the route passes only out of its quests' level window is visited again
at the level they open (c13 Orc passed Ratchet only at 29.6-30.3, leaving the Shimmering Flats chains
at 36-37; Human's Arathi chains of Sully Balloo and the Thandol Span). Per giver of quests that may
be added, the 3 nearest stops of the route where one of the quests within 120 yd of it is open and the
character is at its window's floor (its minimum level, or two under its level) to 2 over it, 500 yd or
more from the giver; after the stop the route goes to the giver and takes those quests as `chain insert`
does (none before the stop), at least 2 of them, and what is ready at the hub then moves into that
visit (the hub sweep's fixes, up to 8). A revisit is kept when it removes 5 minutes of grinding or
more, keeps every rule (no step doing nothing, no late hand-in, no v1 hearth line on cooldown, the quest
log, trainings, the feedback guards), and its cost change plus 5 minutes for each flow count it raises
(avoidable returns, passed-by, split work, left ready, walked past) is at most 10 minutes: an extra
visit is worth it when the chains' XP pays for the walking it adds. Kept revisits are listed as `hub
revisit` edits, counted in `hubRevisits`. The shared tail gets the same pass.

Then **defer hard work** (the route benchmark's grind rule G1: Orc's route grinds 30.7 hours, 14
blocks over 15 minutes, 11 of them the model's own before an accept or work taken too early: Kodo
Roundup at 30.6, 56 minutes; Chapter I at 33.9, 165). For each grind of the model's own over 15
minutes, the step it grinds for and its quest's steps after it go to where questing reaches that
level, each at its cheapest place from there; the quests of the order that need it handed in (theirs
in turn) wait with it, else they would be taken before it opens them. Grind is priced as a cost: the move is kept when the
route time plus the minutes of grind over 15 per block drops (by a minute or more), the order keeps
its rules, no guard rises and the hours to 60 rise by at most 10 minutes; its edit is `defer hard
work`, counted in `deferredWork`.

Then **grind top-ups**: the grind left is explicit and in pieces. The model's own grind of a minute or
more before an accept or work becomes a checkpoint at the last camp of the zone stay before it (its
last objective step there), else right before the step. A grind to an accept's minimum level (the
model lets an accept through 2 levels early and grinds there; the game refuses the quest) becomes a
level step right before the accept however short it is (4971 at 52.75, minimum 53). A checkpoint over 15 minutes is split into
top-ups of at most that, spread over the camps before it in its zone stay, and over the stays
before it (within 80 steps, not past another checkpoint) when its own has too few camps (Burning
Steppes' 51-52 grind came at the start of its stay). Each top-up grinds its share on top of the level
questing reaches there. A camp with a hand-in waiting near it (a quest done, handed in within 15 steps
and 600 yd: the guard of #617, grind after the trip's hand-ins) has its top-up after that hand-in
instead (c14 Human: every split of the Un'Goro 49.5-51 grind, 488 minutes, was refused for a piece
right before such a hand-in). Kept when the grind it splits or surfaces is smaller, no guard rises and
the hours to 60 rise by at most 3 minutes, a split by at most the minutes over 15 it removes, up to
10 minutes (flow over hours); its edit is
`grind top-up`, counted in `grindTopUps`. Each hours block reports `grindBlocks`: the longest, how
many are over 15 and 30 minutes, the model's own minutes, the minutes over 15 and the minutes per
10-level band.

When a cut is written, a breadcrumb is handed in before its follow-up is taken whenever the order
takes the follow-up first at the same stop (within 40 yd): taking the follow-up first closes the
breadcrumb in the game (2872/2873, 3763/3764).

Last, **the written check** (`forge build` only). The planner's counts read straight lines between its
own steps; the player walks the written guide, with its flight and dock walks, spawn spots, zone
gotos and class detours (c13: the planner counted 9 walked past on Orc's order, the check 40 on the
written guides). So the routes stage writes each start's guides as the guides stage does (into
`<out>/.forge/flow/<start>`) and reads `forge judge check`'s `walked-past`, `dup-trip`, `bounce` and
`feel-return` (avoidable returns v1 does not make) on them, every class merged as the check counts
them. Each finding goes back to the route as a move: a hub batch whose steps it names is undone; an
avoidable return's work moves as one block right after the visit before; else its accepts and
hand-ins move earlier, right after the last quest line of the stop the walk passed (else right before
the first where it went on to). Each move is kept like a hub sweep move, within 3 minutes. The routes
and guides are written again and checked again; the round is kept when the check finds fewer, at
most three rounds, else the routes go back to the round before. The shared route's tail gets it (the
findings of every start of the faction); a faction of one start, its own route. Kept moves are listed
as `written check` and `hub batch undone` edits, counted in `writtenCheck`; the build log names each
round's counts per rule. A start resumed from its finished search's checkpoint is checked the same
way (its hub batches are not checkpointed, so none is undone).

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
- when an item starts it, the item is sold or drops at 25 % or better from an ordinary mob or an
  object (a rare mob's drop does not count: Gruff Swiftbite's Gold Pickup Schedule);
- our quest facts are sure of it. Quests with objectives at low or medium confidence, or flagged
  "verify in game", are never added;
- it is not on the deliberate `never` or `optional` list, and not skipped by an override.

v1's own quests are kept whatever these rules say. The route file's `added` list gives, for each added
quest, why it was allowed.

## 8. The shared 12-60 route and join points

The routes are one start zone per race (levels 1 to about 12; Skyborne to about 15) and then one
shared route per faction to 60, from the Barrens (Horde) and Westfall (Alliance) on. `forge build`
makes it whenever a faction has more than one start (`--starts all`):

1. Every start is cut on its own first (its own route, written to `routes/own/`), and keeps of it
   every step from its guides before its **join**: its first step from a `02-the-barrens` guide
   for the Horde (Orc and Troll's own `orc-troll/02-the-barrens` and the others'
   `horde/02-the-barrens` alike), from `02-westfall` for the Alliance. The split is by guide goal,
   not by position, so an edit of the own cut that moved a later guide's step before the join
   does not lose it.
2. From there, one order: the first start's own tail (the **canonical** start: Orc, Human). It holds
   every Barrens (Westfall) quest of the canonical start. A start's own quests of the shared guides
   the tail lacks (the shared Barrens guide's early quests Orc does in its own Barrens guide, a
   line `only Tauren`) are put back where they add the least detour, after the tail's steps that
   come before them in its own order.
3. The local edits of [section 2](#2-local-edits-with-a-budget) improve that tail. An edit is kept only
   when **no start gets slower**. The cut (every edit, or the knee) is taken on the sum over the starts.
   With `--search free` the free search improves the tail instead (every start a character, a move
   kept only when no start gets slower); `--search hybrid` runs the free search, then the edits. The
   own cuts of step 1 are searched the same way.
4. Each start plays the shared tail with its own travel plan for its own part and the canonical
   start's plan for the tail. A plan item on a step that does nothing for that start (a hand-in of a
   quest it never took) moves to the next step that does something.
5. Each start's route (its own part + the tail, the tail's steps it does not play left out) is
   reported against its own v1, written by the writer and judged like any route. `routes/starts.json`
   lists every start's v1, own-cut and shared hours to 30 and 60. The route file's `shared.joinAt`
   names the join guide.

`forge sim widen` makes the same shared tail from v1's own orders (not from the own cuts), for study.

`forge sim widen --diagnose` compares, for each start, its own v1 order against its prefix plus the
canonical tail, guide by guide. It shows the gap, levels, grind and travel minutes, hearths and
no-op steps. Use it before changing the join.

What we found with it (before the start-zone structure): joined at the first shared guide, a start
lost the shared guide's quests the canonical tail did not have (Tauren's early Barrens quests, which
Orc does in its own Barrens guide; six of the other Alliance starts' Westfall quests). The builds then
joined after the Barrens and Westfall guides (about level 19-20). Putting a start's own quests back
(step 2) lets the join come before them again.

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
`walk` legs, `getfp` and, with `--deathskips`, `deathskip` (the graveyard `gy`, the `spot` died at and
one of its mobs `npc`, the Spirit Healer `pt`; [model.md](model.md#deathskips)). The writer reads this
([writer.md](writer.md)).

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
(`move`, `fold`, `fold later`, `insert`, `pickup`, `hub pickup`, `bag tie`, `camp gather`, `hub batch`, `hub sweep`, `on the way`, `hub loop`, `train at the hub`, `written check`, `hub batch undone`, `drop`, and `free move` from the free search), the steps it moved (`t`, quest, task index),
`from` and `to` (positions in the order before the edit), the `text` in plain words, the `reason`, the
minutes saved (`savedMin`; negative for a pickup that costs time), the guards it passed, and `revert`:
the one line for the overrides file that undoes it.

## 10. Reason codes

| Code | Meaning |
|---|---|
| `override` | an override skips it |
| `missing-info` | Forge does not know enough to count on it: the row's `missing` says what |
| `elite/group` | elite or group work, or a dungeon, raid or battleground quest |
| `chain-not-open` | a quest before it is not in the route, or it would do nothing where it is passed, or a quest before it is left out of the world (so it is not in the character's run either) |
| `zone-left` | the route never passes its giver at a level that opens it, or its work or turn-in leads off the route |
| `low-value` | its XP does not pay for its detour, it was dropped from v1 because its trip cost more than its XP, or it is repeatable, has no reward or is a trade-goods hand-in |
| `level` | passed only where it is too low, too high or grey (also when the route stands at its giver only out of its level window: `numbers` give the levels there and where it opens), or it is endgame |
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

The routes stage uses the average profile, an edit descent of up to 400 edits with every edit kept
(`forge build --cut knee` keeps the knee's instead; `--search free|hybrid` searches as above; changing
either reruns the routes stage),
`--guard current` and 16 held-out draws. Its log prints, per start, v1's hours, the cut's hours, the
number of edits and of skipped quests.

Walked legs the walk store has no walk for are priced as the straight line × detour only within the
store's pair radius (the walks document's `radius`, 4000 yd); each route's hours report them
(`walkMisses`). Beyond the radius the straight line may cross a sea or a range (c13 Human walked
5841 yd from Dustwallow to Feathermoon on Sardor Isle and 4299 yd from the Emerald Sanctuary to
Everlook, both straight), so there the leg goes by the network: walks between nodes (flight paths,
docks, inns), boats and known flights; only a leg the network cannot make either is walked straight.
Both kinds of leg are listed as misses. The routes stage writes them to `routes/walk-misses.json`
(point ids of its world), and `forge build` merges them into `walks/extra-pairs.json` by their ends'
places (a union, sorted, so it stops changing; places, not ids, so a correction that adds places
keeps them). The next build's walks stage routes those pairs too (`--walk-pairs FILE` names another
file; the file is part of the walks stage's key), and a routed walk shorter than the network wins.

Islands a faction reaches by boat or flight are their own walk region (forge-world's
`SEA_ISLANDS`): no walk is asked or priced across the water to them. Sardor Isle (Feathermoon) is
one for the Alliance, which has its dock and flight path; the grid's land has no way from it to the
mainland, and of the land cut off from the mainland only it and Teldrassil hold a flight path, dock
or inn. Islands with no dock (the Isle of Dread, Ranazjar Isle, Fenris Isle, the Echo Isles) stay
in their continent's region: the walk store routes the swim there.

### Resuming a killed run

A routes stage can run for most of an hour. If it dies (out of memory, a reboot, a kill), the next
`forge build` with the same inputs picks up where it was instead of starting again. Its searches
checkpoint into `out/.forge/routes-resume/`:

- each search unit (a start's route; with a shared route, each start's own cut `own-<start>` and the
  faction's tail `shared-<faction>`) saves its finished search as soon as it is done, so a rerun
  finishes and writes that start from it without searching;
- the free search saves its members (each one's order, random generator and counters) at a meeting
  every 2 minutes and after its last round, and resumes from the last one saved;
- the edit descent saves the edits it kept so far every 2 minutes and at its end, and replays them
  (one exact replay each, no estimates) before it searches on.

A resumed route is the same route an uninterrupted run makes, file for file but the search's wall
time: the members rebuilt from a checkpoint play on exactly as they would have, and each replayed
edit is checked against the hours it reached (one that does not match starts that descent over).
The checkpoints belong to the routes stage key, which names every input and the forge binary
itself: a build with other inputs or a rebuilt forge empties the folder and starts afresh. They are
removed once the stage is done. The log names what it reuses: `resuming Orc from checkpoint
(1500000 tries done)`, `resuming own-Troll edit descent from checkpoint (37 edits done)`, `resuming
Human from checkpoint (search done, 2000000 tries)`.

`forge sim route` does the same in `.<name>.resume/` beside its `--out` file, keyed by its
arguments, seed, inputs and binary; `--threads` is left out of the key (the route does not depend on
it), so a run killed for memory can be resumed with fewer threads.

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
| `--search edits\|free\|hybrid` | `edits` with `--edits`, else `free` | how the route is searched (above) |
| `--budget K` | off | keep exactly K edits |
| `--cut all\|knee` | `all` | without `--budget`: keep every edit, or the knee's |
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
forge sim widen --faction Horde --starts Orc,Tauren,Undead,Skyborne --join-at 02-the-barrens --out horde-shared.json
forge sim widen --faction Horde --starts Orc,Tauren,Undead,Skyborne --join-at 02-the-barrens --diagnose --out horde-diagnose.json
```

`widen` also takes `--edits`, `--budget`, `--cut`, `--members`, `--threads` and `--param`. Its console prints,
per start, v1's own hours, v1's prefix plus the canonical tail, the knee and the converged hours (the row's
`kept` is the hours with the edits the cut kept). Each
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
| A rerun after a kill searched from the start | the stage key changed (other inputs, or forge rebuilt), or the run died before its first checkpoint | expected: checkpoints are kept only for the same key; the first is written 2 minutes into a search |

## 15. Changing it

| To change | Look in |
|---|---|
| the routes stage and its defaults | `forge-sim/src/stage.rs` (`RouteOpts::forge`) |
| the steps of a cut | `forge-sim/src/route.rs` (`prepare`, `improve`) |
| the seed and training stops | `forge-sim/src/order.rs` (`seed_order`, `place_trains`) |
| edit kinds, the knee | `forge-sim/src/search/edits.rs` |
| the windowed replay and the free search | `forge-sim/src/search.rs` |
| pickups and long trips | `forge-sim/src/search/passby.rs` |
| guards | `forge-sim/src/guards.rs`; hubs, left ready, walked past and the loop order in `forge-sim/src/hubs.rs` |
| who may be added | `forge-sim/src/insertable.rs` |
| item needs | `forge-sim/src/needs.rs` |
| ledgers, reason codes, `why` | `forge-sim/src/ledger.rs` |
| the shared route | `forge-sim/src/widen.rs`, `forge-sim/src/shared.rs` |
| deliberate orders, overrides | `data/route-fixes.json` (read by `forge-sim/src/fixes.rs`) |
| checkpoints and resuming a killed run | `forge-sim/src/resume.rs`; tested in `forge-sim/tests/resume.rs` |
| the commands | `forge/src/cli/sim.rs` |

The tests `tests/overrides.rs` and `tests/feedback_guards.rs` in `forge-sim` pin the overrides and the
feedback guards. They need the game data and skip themselves without it. When you add a reason code,
add it to the table above and to `ledger.rs`'s `skips`.
