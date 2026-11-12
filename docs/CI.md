# CI and the on-demand runs

Every pull request runs CI on GitHub (`ci.yml`, `forge.yml` and the
workflows its paths start). The heavy checks a batch of work needs before
it is merged also run on GitHub, on any pushed branch, started by hand: the
**on-demand workflows**. GitHub's standard runners are free for a public
repository, so a batch's suites, playtests and gates need not hold a local
machine for an hour.

| Workflow | What it runs |
|---|---|
| `ondemand-batch.yml` | the three below in one run: start this once per batch of work, not per item |
| `ondemand-suites.yml` | the Node suite (four shards), the Rust workspace (format, lints, tests, documented commands), the addon's Lua tests (forge-addontest, four test threads) and CI's changelog, translations and previews checks |
| `ondemand-guides.yml` | guide compile (every compile check, as annotations), `playtest --honest`, then `playtest` per guide group (every start zone, each faction's 12-30, 30-40, 40-50 and 50-60, class, professions, reputation, collectibles, exploration, miscellaneous, legacy), per class when you name some |
| `ondemand-gates.yml` | the gates on committed files (generated guides not hand-edited, corrections, the public database's guard, one version everywhere, walking maps against `PACK.json`, changelog, translations, wording and parse tests); the guide pack's memory budgets (`guides_memory`, measured alone) and the engine's skip-ahead and upgrade cases; and the gates that need reference data (lint, prerequisite order, reported cases and their todos, route patterns, the guide-end sweep for fresh characters) |

They run only when started: `workflow_dispatch` (people with write access),
`workflow_call` from the batch workflow, and the batch on a push to a
branch named `ci/<anything>`. Pushing any other branch starts none of them.
Every job's full output is in the run's artifacts (`logs-*`, kept 14 days);
each job's summary lists its findings. A step fails when any command in it
fails, one piped into `tee` included: every step runs under `bash` with
pipefail, and `tests/workflows.test.js` checks that a job setting its own
`defaults.run` names that shell again.

## Starting a run

The maintainer (or the integrator of a batch) starts a run on a pushed
branch; [RELEASING.md](RELEASING.md#on-demand-runs-on-github) has the
commands and the security rules these workflows keep.

## Reference data on GitHub

`data/forever` is not in the repository. The guide, gate and (with
`data=public`) suite runs build it on the runner from public sources
(`.github/actions/public-data`): pfQuest, the CMaNGOS dump, the client
tables (the Actions cache `wago-cache.yml` fills), QuestieDB's Forever store
from its public GitHub release (the version the release data uses, pinned
by SHA-256 in the action; it is unpacked on the runner and never enters the
repository or an artifact) and the checkout's own `forever-db/corrections`,
plus `professions.json` from the same data.

It is close to the release data but not equal to it: no recordings, no
private corrections, no web facts (quest XP and zone lists), and no Forever
TrinityCore extract (where `professions.json` takes the sniffed trainer
lists from; a forge that refuses to build it without them leaves the
profession guides' craft and learn lines unresolved there). Measured on
2026-11-11 on `next` (QuestieDB 1.0.10): 5,410 quests and 13,664 NPCs, where
the release data holds about 5,400 and 13,700, and 4 compile errors in the
whole pack (without QuestieDB: about 3,600 in 142 files).

A finding on this data can be the data's, not the guide's. With `base` (the
branch the batch started from), each check runs on the base as well (its
data built by the head's forge from the base's corrections) and fails only
on findings the base does not have; line and step numbers are left out of
the comparison, so an inserted step does not make every later finding new.
A guide folder or playtest group that does not compile on this data (on
`next` today: the class guides, 4 errors) is not played, and that is a
finding only when the base does play it; its compile errors are compared
like any other.

The suites run with `data=none` (the default) exactly as CI does: the tests
that read `data/forever` skip with a reason.

## What stays local

- The release data (`forge data build --kb`: recordings, the private
  corrections, the knowledge base) and every gate run on it before a release
  ([RELEASING.md](RELEASING.md)).
- The skip-ahead sweep and the upgrade harness: their states come from the
  calibrated level model on the walking grid and from players' recorded
  saves. On GitHub the engine's skip-ahead and upgrade cases (forge-addontest)
  run instead.
- Anything that reads recordings, the game client, the walking grid, Leffe's
  maps or other files not in the repository: route builds, navigation and
  travel builds, legs bakes, ArrowGuard replays, the sweeps that read
  recordings, the quiet performance run.
- Deploys, releases and anything that needs a credential.
