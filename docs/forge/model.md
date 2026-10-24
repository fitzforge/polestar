# The time model

This page explains how Forge prices a route: how long each kill, walk, flight, hearth and hand-in
takes, and so how many hours a character needs to reach 60. The route search ([routes.md](routes.md))
keeps an edit only when this model says it is faster. The judge measures guides in the same model
([judge.md](judge.md)). For the whole pipeline, start at [FORGE.md](../FORGE.md).

The code is in `rust/crates/forge-sim`: `eval.rs` (the evaluator), `run.rs` (the compiled character
and its tables), `travel.rs`, `params.rs`, `profile.rs` and `xp.rs`.

All hours on this page are **model hours**. They are good for comparing two orders of the same
quests. They are not a promise of real play time: most time parameters are still estimates, and only
quest XP is fitted so far.

## v1's evaluator

The model is v1's evaluator, ported to Rust step for step. With routed walks off and v1's parameters
it gives the same hours as the old JavaScript one, event by event (level within 5e-7, time within
1 ms). The test `tests/parity.rs` pins this. Keeping v1's model means a Forge route and a v1 guide
are always measured with the same ruler.

On top of v1's model, the route profiles turn on a few rules v1 did not have: walked escorts and
timed quests, bag items, along credit, class training stops and v1's travel plan. Each is described
below. Two more fidelity terms (camps and spots) exist but are off in the build.

Every route file reports the same two orders (v1 and the cut) in three models:

| Field | Model |
|---|---|
| `v1`, `improved` | the route's own: the profile, routed walks, the rules above |
| `v1Gate`, `improvedGate` | the gate's: v1's evaluator exactly (walks off, class factor 1, no training stops) |
| `v1Other`, `improvedOther` | the route's own with camps and spots switched (on if the search had them off) |

Check that a cut is faster than v1 in all three before you trust it.

## Steps

The evaluator plays an order one step at a time and keeps the time, level, XP, quest log and
counters.

| Step | What happens |
|---|---|
| accept | Needs the prerequisites and a level of at least the quest's minimum level − 2 and its level − 7. Travel to the giver. If the character is under the minimum level, grind to it; if more than 5 levels under the quest, grind to quest level − 5. A quest started by an item first works that item's task. Then talk. |
| task | One objective at its place. Skipped if earlier kills already covered it. Travel there, then do the work: kills, uses, an escort or a purchase. |
| turn in | Needs every task done (and any quest that must be handed in first). Travel to the ender, talk, gain the quest XP. |
| level | Grind to a level (with a fraction: `level 12.4`), at the grind rate for the current level. |
| train | Travel to a town's class trainers and train. |

A step that cannot be done (prerequisite missing, level too low, log full, place unreachable, quest
not active) changes nothing. It only counts as a **no-op**. A kept edit may never add a no-op. After the
last step the character grinds out to 60.

## Costs

The parameters below are the priors in `params.rs`. `data/sim/params.json` replaces their means where
it has a fitted value (its `calibrated` list, for example `questEstScale` and `questXpScale`). `--param name=value`
overrides any of them for one run.

| Parameter | Prior | Used for |
|---|---|---|
| `runSpeed` | 7 yd/s | walking speed |
| `mountLevel`, `mountMul` | 40, 1.6 | from level 40, walking is 1.6 times faster |
| `detour0`, `detour1` | 1.35, 1.3 | straight line × detour where there is no routed walk (Eastern Kingdoms, Kalimdor) |
| `routeMul` | 1 | × routed walk yards |
| `killSec1`, `killSec60` | 11 s, 30 s | time to kill an even-level mob at level 1 and level 60 |
| `killUp`, `killDown` | 0.1, 0.05 | per level the mob is above or below the character |
| `eliteTime` | 3.5 | × kill time for an elite |
| `classFactor` | 1 | × kill time; the profile sets it |
| `spacing` | 1 | × yards between mobs |
| `extraKill` | 0.043 | share of extra kills (pulls you did not need) |
| `dropMul` | 1 | ÷ kills needed for item drops |
| `talkSec` | 6 s | each accept, hand-in, purchase, flight path learned, bind |
| `interactSec` | 8 s | each object used |
| `escortSec` | 240 s | each escort or event |
| `flightOverhead` | 20 s | each flight |
| `transportWait` | 1 | × the average wait for a boat, zeppelin or tram |
| `hearthCast`, `hearthCooldown` | 10 s, 3600 s | the hearthstone |
| `levelOverhead` | 60 s | each level-up (vendor, repairs, training) |
| `trainSec` | 60 s | each training stop |
| `grindEff` | 0.7 | × the best grind rate |
| `gateGap`, `dangerGap` | 2, 5 | the accept window (above) |
| `deathRisk` | 300 s | each dangerous zone a walk crosses |
| `questXpScale`, `questEstScale` | 1, 1 | × recorded quest XP; × estimated quest XP |

### Kills

The time for one kill at character level L on a mob of level M is:

$$t_{kill} = \Big(killSec1 + (killSec60 - killSec1)\tfrac{L-1}{59}\Big) \cdot f(M-L) \cdot classFactor + \frac{gap \cdot spacing}{runSpeed}$$

where f is 1 + 0.1 per level above, and 1 − 0.05 per level below (never under 0.5), and *gap* is the
yards between mobs at that site. An elite takes `eliteTime` times longer and gives twice the XP.

The kills needed are the objective's count × (1 + `extraKill`). For an item, the count is the items
over the drop chance per kill, ÷ `dropMul`. Kills of one mob also count for another open quest's
objective on the same mob within 100 yd (shared kill credit).

Kill XP is v1's formula: (5L + 45) for an even-level mob, +5 % per level above (up to 4), less below,
and nothing for grey mobs. The model levels up as XP comes in, so the kill time changes mid-camp.

### Grinding

The grind rate at level L is the best XP per second over mobs at L, L+1 and L+2, with the grind camps'
spacing at that level, × `grindEff`. A `level` step and the grind out to 60 use it.

### Quest XP

A quest's full XP is its recorded reward × `questXpScale`. When the reward is not recorded, it is
estimated from the game's quest XP table by level and tier, × `questEstScale` × `questXpScale`.
Repeatable quests without a reward give nothing. At the hand-in the character gets a share by how many
levels it is over the quest: all of it up to 5 levels over, then 80, 60, 40 and 20 %, and 10 % from 10
levels over.

### Walking

A walk between two places is the routed walk from the walk store (`walks-<faction>.bin`, see
[nav.md](nav.md)) × `routeMul` when it has one. Otherwise it is the straight line × the continent's
detour. Seconds are yards ÷ `runSpeed` (× `mountMul` once mounted). Across continents there is no walk.

A walk that crosses zones 5 or more levels above the character (not counting the two end zones) adds
`deathRisk` for each such zone.

### Flights, boats and other transport

For a leg of 400 yd or more, the model also tries the transport network: walk to one of the 3 nearest
nodes, travel the network, walk from one of the 3 nodes nearest the end. It takes whichever is
cheaper. The network uses only flight paths the character knows: each flight costs its time plus
`flightOverhead`; a boat, zeppelin or tram costs its ride plus its wait × `transportWait`. Network
legs carry no danger.

Flight paths are learned when a step stops within 200 yd of a flight master (one talk). The network is
priced per set of known flight paths, so it changes as the character learns them.

### Hearth and binds

When the hearthstone is ready and a leg costs more than 2 minutes, the model may hearth: `hearthCast`
plus the travel from the bound inn. It then waits `hearthCooldown` before the next.

- In the gate's model, the character binds at every inn it stops at, and hearths whenever that is
  more than 30 seconds faster.
- In the route profiles, the character follows **v1's travel plan**: it binds only at v1's `sethome`
  lines, hearths only at v1's hearth lines (unless the hearth is more than 2 minutes worse than
  travelling), and learns flight paths at v1's `getfp` lines too. A plan line is attached to the quest
  step right after it in v1's guide, so it moves with that step when the route changes.

A v1 hearth line met while the stone cools down is skipped and counted (`planHearthsOnCooldown`). A
kept edit never adds one. So the route's hearths are always at least an hour apart.

### Training and level-ups

Each level-up costs `levelOverhead`. In the route profiles the training stops pay for training
themselves, so the per-level overhead drops to `levelOverhead` − `trainSec` / 2 (30 s): only vendoring
and repairs remain.

## Class profiles and the class-agnostic route

The route is planned for a class **profile**, not a class:

| Profile | `classFactor` | Who |
|---|---|---|
| `avg` | the mean over the faction's classes: 0.96875 (Horde), 0.98125 (Alliance) | the build |
| `slow` | 1.15 | the slowest killer (Warrior) |
| `fast` | 0.8 | the fastest killer (Hunter) |
| `gate` | 1 | v1's evaluator as the gate runs it |

The class factors are v1's priors: Warrior 1.15, Paladin 1.1, Priest 1.05, Rogue, Shaman and Druid 1.0,
Mage 0.9, Warlock 0.85, Hunter 0.8. The faction's classes are the eight it plays in Forever.

The other class parts are handled the same way for every class:

- **Class quests are out.** The character is compiled with no class, so quests open to only one to
  four classes are closed. Class chains live in their own Class guides.
- **Training is a stop.** A `train class` step at a town's trainers, at even levels, where the route
  passes a town ([routes.md](routes.md#training-stops)).

The shared route is scored over all three of `slow`, `avg` and `fast`, so it does not favour one kind
of class ([routes.md](routes.md#8-the-shared-12-60-route-and-join-points)).

## Fidelity terms: camps and spots

These two terms are off in the build. Turn them on with `--param camps=1 --param spots=1`.

- **Camps.** Kill work is done at a hunting ground: the objective's camps within 250 yd of each other,
  pooled. Grounds of fewer than 3 mobs and rare camps (respawn over an hour) are left out while another
  exists. The kill time uses the ground's mob level and the yards between its mobs. The mobs that are up
  are killed at the kill rate; after that, one more each time one respawns. The model remembers what
  each ground has left. Without spots, the ground cheapest from the objective's place is used.
- **Spots.** A task goes to the ground that costs least from here, through its work, to where the
  order goes next (looking up to 4 steps ahead; else the quest's ender). This idea comes from
  Factoruide (MIT, used with Joel's permission); see `rust/NOTICE.md`.

With camps on, v1's orders cost about 14 model hours more (low-chance drops spread over many mobs cost
the most). Spots win back about one hour. The cuts gain about as much either way, and each model's cut
is also faster than v1 in the other model. That is why `v1Other` and `improvedOther` are reported.

## Along credit

Route profiles turn on **along credit**. A walked leg that passes within 150 yd of the place of an open
quest's unfinished kill objective (not elite, not the leg's own destination) kills 25 % of what that
objective needs on the way. It pays their kill time and gets their XP, plus the pull out of the line
beyond 60 yd. It only does this when the pull costs no more per kill than that camp's own spacing. The
work left at the objective's own step shrinks, and an objective finished this way needs no trip.

The 25 % share is a modelling estimate, not yet checked against recordings. The route file reports
`alongKills`.

## Quest log

The game's quest log holds 40 quests (or the world's own limit). When it is full, an accept gives up
an open quest at least 6 levels below the character. If there is none, the accept is a no-op.

The route keeps room for the class quests the writer adds: a kept edit never raises the log peak above
38, or above v1's own peak when v1 already goes higher. The route file reports `logPeak`, `logSkipped`
and `logAbandoned`.

## Timed quests and escorts

In the route profiles:

- while a timed quest runs, every leg is walked: no hearth, flight or boat. The model checks each
  hand-in against the quest's limit and counts late ones (`late`). A kept edit never adds one;
- an escort's own task is always walked from the giver;
- an item dropped by more than 20 kinds of mob (cloth for donations) is taken from the bags: no trip,
  no work.

These rules are off in the gate's model, so the gate stays equal to v1's model.

## Counters, parameter draws and the held-out gain

The priors are uncertain. A route that wins under one guess of the parameters might lose under
another. Forge checks this in two ways.

**Counters.** Almost every second the model spends is a count × a parameter: kills × kill time, walked
yards × detour ÷ speed, talks × `talkSec`, and so on. The evaluator keeps these counts
(`Counters` in `eval.rs`): kills by level weight (elite or not), kill gap yards, respawn waits, talks,
uses, escorts, trainings, level-ups, hearth casts, danger crossings, walked yards (routed or straight,
by continent, mounted or not), network seconds and grind XP by level. Priced under the route's own
parameters, the counters give its time exactly. Under another parameter set they give it as a dot
product, without a replay. The order's decisions and levels are held, so this is an estimate: over 8
draws it came within −4.1 % to +2.1 % of a full replay (`tests/counters.rs`).

**Parameter draws.** A draw samples the time parameters around their means (normal, cut to their
bounds; `SPREAD` in `params.rs`). `params.json`'s fitted mean and spread are used where it has them.
The class factor, levels and the policy parameters are not drawn.

**The held-out gain.** When you pick the best of many candidates by a noisy score, the winner looks
better than it is (the optimizer's curse). So every cut reports its gain over v1 on draws the search
never saw. These 16 **held-out draws** use one fixed seed, the same for every route. For each draw,
v1 and the cut are both replayed in full. The route file's `holdout` gives the mean, min and max gain,
the share of draws where the cut wins (`sharePositive`), the mean gain by counters alone and v1's mean
hours.

On recent cuts the held-out gain is 2.3 to 3.4 model hours, and the cut wins on every draw.

`--search-draws K` makes the search itself run under K draws (scored as their sum). `inSample` then
reports the gain on those draws, and `holdout` still reports the 16 others. `--holdout N` changes the
number of held-out draws.

## Determinism

The same inputs always give the same route, on any machine, with any number of threads, native or in
the browser.

- The evaluator does nothing random. The only random numbers are the parameter draws and the free
  search's moves, from a seeded SplitMix64 generator (`rng.rs`).
- Normal draws use the pure-Rust `libm`. The model uses no other transcendental function, so native
  and WebAssembly builds compute the same bits.
- The network's travel times are kept in 32-bit floats, as v1 did. The table for a set of known flight
  paths is always built from the same parent set, so a route's times never depend on what was priced
  before.
- The free search is counted in tries, not seconds. Its members meet every 250 tries, and ties go to
  the lowest member. The edit descent shares candidates across threads but always takes the same one.

`sim-hash` (a binary of forge-sim: `src/bin/sim-hash.rs`) prints a hash of a route's every step and
its hours, for v1's Orc order and after a short search. `tests/wasm/run.sh` (run from `rust/`) builds it
natively and for `wasm32-wasip1`, runs both (the wasm under node's WASI), and compares: on the goldens
with walks off, camps off and on; with `POLESTAR_SIMDIR` and `POLESTAR_SIM_JS` on a local sim dir and
seed, walks on too. The hashes are equal. The library also builds for the browser:

```sh
cargo check -p forge-sim --lib --no-default-features --target wasm32-unknown-unknown
```

(run from `rust/`, with that target installed).

The property tests in `tests/props.rs` check that replays are deterministic, that a saved state resumes
exactly, that time and level never go back, and that the search's windowed replay of every move kind
equals a replay from scratch.

## How to run and inspect it

Most of the time you read the model's answers in a route file ([routes.md](routes.md#9-what-a-cut-writes)).
To try another parameter or model on one start, rerun the cut with `forge sim route` and compare the
hours blocks:

```sh
forge sim route --faction Horde --start Orc --seed v1-horde-orc-on.json --edits 400 --guard current --param camps=1 --param spots=1 --out cuts-camps/Orc.json
forge sim route --faction Horde --start Orc --seed v1-horde-orc-on.json --edits 400 --guard current --profile slow --out cuts-slow/Orc.json
```

`--walks off` prices every walk as a straight line × detour. `--profile gate --walks off` is v1's
evaluator exactly.

`forge sim replay` (a developer command) replays a saved reference event stream and prints the
first event where the model differs from it.

## When it goes wrong

| Symptom | Likely cause | What to do |
|---|---|---|
| Hours jump after a data rebuild | the world or the walks changed | compare `dataHash` in the route files; rebuild the walks if the console warns they were built on another world |
| `v1` hours differ from the gate's | the route profile differs from v1's evaluator (walks, class factor, training stops, the rules above) | the gate measures v1's evaluator exactly: compare `v1Gate` |
| A route depends on the thread count or machine | a determinism bug | run `tests/wasm/run.sh` and `tests/props.rs`; look for a new float function or unordered sum |
| `holdout` gain much lower than the in-model gain | the cut relies on one parameter guess | look at `meanByCounters` and the min; search under draws (`--search-draws`) |
| A kill objective costs hours | a low drop chance spread over many mobs | check the item's drops in the data; try `--param camps=1` to see it at its camps |
| `late` above 0 in v1 | v1 itself hands a timed quest in late | not an error: kept edits only may not add more |

When you change the model, keep v1's model reachable: a new term gets a parameter that is 0 (off) in
the priors, and the gate's profile must keep its hours equal to v1's (`tests/parity.rs`). Add the
term's counts to `Counters` so draws price it, and check `tests/counters.rs` and `tests/props.rs`.
