# Route feel

How a leveling route feels to play, measured on the compiled guides: how much a
player walks back and forth, how well the route picks up quests on the way, and
how organised the quest log stays. The flow audit (`tools/flow-audit.js`) plays
every start and class through the guides and counts what a player notices; the
route-feel gate compares a candidate with the guides that shipped and fails when
a guide or a branch got worse without a stated reason.

Hours to 60 are the level model's question ([forge/model.md](forge/model.md)).
This page is about the walk between the quests.

## Running it

The audit reads compiled guides (`forge guide compile`), both packs when the
route choices are wanted:

```sh
forge guide compile --out build/Polestar_Guides
forge guide compile experimental --out build/Polestar_Experimental
node tools/flow-audit.js run --addon build --faction Horde --out horde.json --md horde.md
```

`--md` writes a readable report: every guide ranked by its flow score, the strict
walk next to the Dynamic Questing walk, the organisation numbers per guide, and
examples per guide. `--start` and `--class` narrow the branches; `--route`,
`--dungeons` and `--dungeon-quests` pick the way to play (below).

The gate runs the audit in every mode on both trees (each tree's guides compiled
into its own folder, both packs, from its own checkout), then compares:

```sh
node tools/flow-audit.js modes --addon shipped-build --out-dir flow/shipped
node tools/flow-audit.js modes --addon candidate-build --out-dir flow/candidate
node tools/flow-audit.js gate flow/shipped flow/candidate --table
```

Both trees must be audited with the same options (the same `--dynamic`, legs or
`--no-legs`; straight lines while a candidate's legs are stale); the gate refuses
two audits of different `--dynamic` versions. The audit is light: a few seconds
per branch, a few minutes per faction and mode.

`--level-offset D` (default 0; fractional or negative too) plays a character
always D levels ahead of the walk's modelled one: `when level` steps, level
goals, min levels and the While-here mob gate read that level, while XP and the
levels reported stay modelled. `--level-offset-profile FILE` instead plays a lead
that changes with the level: a JSON list `[[level, offset], ...]` by modelled
level, linear between its points (the first point's offset below it, the last
one's above it), e.g. `[[5, -0.5], [25, 0.4], [35, 1.7], [45, 0.5]]` for a player
behind the model in the start zones and ahead of it in the 30s. The audit records
the offset or the profile; the gate refuses to compare two audits of different
offsets.

## How a branch is played

A branch is one start (race) and one class: the race's first leveling guide, then
each guide's `next`, to the end of the chain. A step or goal whose `only` leaves
out the branch's race, class or faction is not played (a guide both factions play
keeps the other side's lines). Two walks per branch:

- The **strict walk** does exactly the guide's lines, in order: it walks to each
  goal (the baked leg when there is one, else a straight line; flights, boats,
  portals and hearths are not walked), does it and moves on. `along` goals are
  done where the walk first passes their spot, as a step there would be.
- The **dynamic walk** (Dynamic Questing, `--dynamic 037`, the default) is a
  player who also takes the "While you're here" lines the addon shows: work of a
  later step whose spawn area the walk comes near (mobs at most 1 level above
  the character, the addon's `HERE_MOBS_ABOVE`; `--dynamic 036`: 2, as 0.3.6
  offered), hand-ins of finished quests within the addon's budget, and the
  follow-ups an early hand-in's NPC gives.
  `--dynamic 042` is 037 plus the rest of what the addon does on the way: a
  later step's accept of the loaded guide as a pick-up line ("Take X from Y",
  weighed as a hand-in; quest level at most 2 over the character, its min level
  and prerequisites met, no group, escort or timed quest, room in the log), the
  later accepts auto-accept takes at an NPC window the player opens anyway, and
  the hand-in of a finished quest the loaded guide no longer hands in, at its
  ender in passing. It is not the default yet: audits compare only within one
  version.
  The tables are the dynamic walk's; the report shows both.

The walk keeps a clock (7 yards a second on foot, flights at 30, 4 minutes for a
boat or portal, a fixed time per goal), a level from quest and kill XP, the quest
log, and the character state the guides gate on, so each `when` reads as it would
in game for a player following the route from the start:

| Condition | On the walk |
|---|---|
| `level`, `onquest`, `complete`, `turnedin`, `available`, `done` | as the walk stands at that step |
| `taxi` | the flight paths learnt on the walk (its `getfp` lines, the flights taken), so a `taxi` / `!taxi` pair plays one side |
| `bound` | the inn of the walk's last `sethome` |
| `has` | the items the walk got (collected, bought, a quest's starting item), with their count |
| `zone` | the zone of the walk's last goal |
| `knows` | never holds: the walk learns no spells, so a fresh character does the training steps |
| `dungeon` | the dungeons the mode runs |
| `group`, `money`, `skill`, `prof`, `item`, `rep` | never hold: the solo route, no optional purchases |

## Modes: every way to play the route

| Mode | What the player chose |
|---|---|
| `skip` | Dungeons in my route off, the default route |
| `riverglades`, `shendralas`, `hyjal`, ... | the route choice a guide's `next` offers (an experimental zone), the default everywhere else; each choice the faction's guides offer gets a mode |
| `riverglades+shendralas` | every route choice the faction's guides offer, taken together |
| `run` | Dungeons in my route on, every dungeon quest: every `when dungeon` step, `when dungeon "<X>" all` too |
| `run-way` | Dungeons in my route on, only the quests on my way: the `when dungeon` steps without `all` |
| `run+<choice>`, `run-way+<choice>` | either with a route choice |

`modes` plays the default route and the route choices; `--with-dungeons` adds the
`run` modes, for a release that ships dungeons in the route (both trees with the
same flag). It writes one audit per mode and faction (`<mode>-<faction>.json`);
the gate pairs the files of the two folders by name. A player who answers per
dungeon (Ask me, or a dungeon's own style in "Dungeons on your way") plays a mix
of the `run` modes; they play each choice whole (`--dungeons` with map ids plays a
few dungeons).

## What it counts

Per guide the numbers are means over the branches that play it (the maximum in
brackets in the report); a finding carries its share, the branches that meet it.

### Back and forth

| Count | Definition |
|---|---|
| Passed givers | A giver within 40 yards of the walk (the hub tier: 120) offering a quest the character can take then (level, prerequisites, not closed), that the guide takes later, after walking more than 150 yards away and at least 3 minutes later |
| Passed enders | The ender of a finished quest within 40 yards of the walk, handed in later the same way |
| Deferred work | The walk crosses a spawn area of a quest in the log (mobs at most 1 level above the character, as While you're here offers them) and the guide comes back for that objective later |
| Missed merges | As deferred work, for a quest not yet taken whose giver the walk had already passed |
| Backtracks | A stop within 60 yards of one left less than 30 minutes before, after the walk went more than 150 yards away; **avoidable** when every goal there could have been done on the earlier visit (each one is a finding above) |
| Hub revisits | A hub (3 or more quest NPCs within 120 yards) visited again within 20 minutes; avoidable as for backtracks |
| Hub zigzag | The yards walked through a hub's stops beyond the shortest order of the same stops between the same way in and out |
| Ground walked twice | Walked ground within 25 yards of ground walked 3 to 45 minutes before, outside hubs |
| Reversals | Two consecutive legs of 60 yards or more, outside field work, turning back by more than 120 degrees |
| Thin hub visits | A visit to a hub with one accept or hand-in |
| Wasted walking | The detours of avoidable stops, the ground walked twice and the hub zigzag, in minutes |

The **flow score** is per 10 quests handed in, so long and short guides compare:
10 x (wasted walking minutes + passed givers within 40 yards + passed enders +
deferred work + missed merges + avoidable backtracks + reversals + thin hub
visits) / quests. Lower is better.

### Organisation

| Count | Definition |
|---|---|
| Carried | A quest handed in by a later guide than the one that picked it up; its span counts the guides from pick-up to hand-in, both included |
| Carried far | Carried through a whole guide (a span of 3 or more), or held 2 hours or more |
| Hours carried | The time each carried quest stays in the log, summed |
| Deliveries | A carried quest with no objectives (a letter into the next zone) is marked as one: the report lists them apart, since one handed in by the next guide is carried by design (the gate counts every carried quest) |
| Early pick-ups | A quest picked up an hour or more before its first objective is worked |
| Never handed in | A quest picked up and not handed in by the end of the chain |
| Quest log | Its peak, and its mean over time |
| Hand-ins per town visit | The accepts and hand-ins a hub visit makes, on average |

### Dungeons in the route

With dungeons in the route, the audit also lists what the `when dungeon` steps cost:

| Count | Definition |
|---|---|
| Dungeon trips | Stops that are there only for dungeon steps (every goal that holds them is a dungeon step's), with the stops before and after them: a pick-up trip, a hand-in trip (a return for a hand-in), or an errand of both. Their cost is the travel of the trip and on to the next stop, less the walk from the stop before to the stop after; only trips longer than 60 yards of walking count |
| Door detours | The same for a run (the steps with the door, `enter`): the walk to the door and back to the route |
| Pick-up to run | For each dungeon quest, the minutes and guides from its pick-up to its first objective (the run, mostly), and from there to its hand-in |

## The gate

`gate` compares each mode's candidate audit with the shipped one and fails on any
of these, unless `data/flow-gate.json` states a reason for it. With dungeons in
the route the guides take the dungeon quests (every one, or those on the way), so
the travel that adds (the dungeon trips, the door detours, more walking, quests
carried to their run) is expected: the report shows it and the gate does not hold
it against the route.

| Check | Per | Worse when | Modes |
|---|---|---|---|
| `score` | guide | the flow score rises by more than 0.3 | solo |
| `backtracks_avoidable` | guide | the mean avoidable backtracks rise by more than 0.25 (a quarter of the guide's branches with one more) | solo, Run |
| `passed_givers_near` | guide | the mean givers passed within 40 yards rise by more than 0.25 | solo, Run |
| `passed_enders` | guide | the mean enders passed with the quest done rise by more than 0.25 | Run (in the solo route the score holds them) |
| `back_and_forth` | branch | its avoidable backtracks and avoidable hub revisits rise at all | solo, Run |
| `wasted_min` | branch | its wasted walking rises by more than 5 minutes (3% when that is more) | solo |
| `carried_far` | branch | its quests carried far rise at all | solo |
| `carried_hours` | branch | its hours carried rise by more than 5% and an hour | solo |
| `never_handed` | branch | it picks up more quests it never hands in | solo, Run |
| `log_cap` | branch | its quest log holds more than the game's 40 at any point, whatever the shipped guides did | every mode |

"Solo" is dungeons off, with or without a route choice; "Run" is dungeons on,
in either style. A guide the shipped guides don't have (a new or renamed guide), or one whose
quests changed by more than a quarter (split, merged, content moved between
guides), is compared through the branches only: its own numbers would measure a
different guide. The gate lists both. The tolerances keep small knock-on changes
out: a branch arriving a little higher or lower at a guide changes which
While-here lines it takes.

A stated reason is a row in `data/flow-gate.json`'s `reasons`:

```json
{ "check": "passed_givers_near", "guide": "forever/horde/30-40/01-hillsbrad-foothills", "mode": "*", "faction": "Horde",
  "reason": "Bracers of Binding is taken on the 38-39 visit, where it is done, instead of carried for 11 hours" }
```

`check` and the guide (for a guide check) or the branch (`"Orc/WARRIOR"`, for a
branch check) name what it accepts; `"*"` accepts every guide or branch, and a
`mode` or `faction` left out or `"*"` holds in all of them (`"run*"`: every mode with dungeons on). The reason says why
the route is better that way for players, in the evidence's own terms (levels,
time carried, a dangerous spot, a fixed report).

A route change often trades one count for another: a pick-up moved to the visit
where the quest is done shortens the time it is carried and adds a passed giver
where the walk went by it earlier. The gate shows both, and the reason says which
one the route chose.

## Flow diff: what one change does to the route

The audit above walks the compiled guides with its own model of the player.
`flow-diff` instead plays the route through the engine itself, on the tree
before a change and the tree after it, so it also sees what an engine fix
changes (a walk the engine now passes, a step it now skips). It is the check
for a pull request that moves a quest: to a later step, into another guide,
into a new step.

```sh
node tools/polestar.js flow-diff --base origin/next                 # the working tree against next
node tools/polestar.js flow-diff --base v0.4.0 --head my-branch --guides horde/30-40 --md flow.md
```

Each tree is checked out from git (only the addon, tools, tests' stub world,
guides and data), compiled with its own compiler and played with its own
playtest: the plain playtest's simulated player, one race and class per
guide (a start guide's race, else the first start race whose route reaches
the guide; Warrior unless `--class` or the guide's class header says
otherwise), each guide arriving with what the guides before it leave done or
in the log. Both trees play against the same reference data (`--data`). A
play whose guide and engine didn't change comes from the cache. `--guides`
reports the guides whose id contains one of its texts (and plays each start's
route up to them); `--skip-quest` plays a player who skips quests (a drop that
never came, a quest left out), as the guide window's "Skip this quest" does.
`--level-offset n` (also `playtest --level-offset n`) plays a character n whole
levels ahead of each guide's level (negative: behind, never below 1): it starts
at the guide's minimum level + n, and a level goal or an accept waiting for a
level raises it to that level + n; its plays are cached apart from plain ones.

Per guide that plays differently (or whose steps changed), and per branch (a
start's default route, guide after guide):

| Count | Definition |
|---|---|
| Zone visits | The zones of the goals the player acts on, in order, consecutive repeats merged |
| Revisits | A visit to a zone the branch had been in and left before, in this guide or an earlier one; new when a guide goes back into a zone more often than the base did on that branch |
| One-quest trips | A visited step whose work is one quest and lies more than `--trip-yd` yards (default 300) or a zone from the work of the steps before and after it, with no flight, hearth or boat between; new when the base had no such trip for that quest, in any guide |
| Empty walks | A walk to a place no work follows within `--trip-yd` that adds more than `--trip-yd` to the way from the work before to the work after (a stop with nothing for the player, #2154); counted with the trips, by zone and step title |
| Carried | Per quest, the guides from its accept to its hand-in on the branch; the largest span over the branches is compared |
| Travel | Minutes walking (7 yd/s: the baked leg into a step when it runs from where the player stands to the goal and both trees have the guide's legs fresh, else the straight line) and flying (taxi distance x 1.25 at 30 yd/s, plus 30 s), as the flow audit prices them |
| Moved quests | An accept or hand-in written in another step: the steps of each guide are matched base to head in order (same title, same quests), so a step put in before it moves nothing, while a pick-up moved to a later visit of a town of the same name does |

It prints a short markdown table for the pull request body, with lists of the
new and gone revisits and trips, the quests carried longer and the moved
quests (`--md` writes it to a file, `--out` writes everything as JSON). It
exits 1 when the change adds a revisit or a trip that `data/flow-diff-allow.json`
does not name with a reason:

```json
{ "kind": "revisit", "guide": "forever/horde/30-40/05-arathi-highlands", "zone": "Hillsbrad Foothills",
  "reason": "Back to Tarren Mill for the hand-ins Krusk and the magus give out, as the shipped route does" }
```

A trip is named by `quest` (a one-quest trip) or `step` (an empty walk's step
title). The reason says why the route is better that way for players.
