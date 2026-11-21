# CI and the on-demand runs

Every pull request runs CI on GitHub (`ci.yml`, `forge.yml` and the
workflows its paths start; see [Lanes](#lanes)). The heavy checks a batch of work needs before
it is merged also run on GitHub, on any pushed branch, started by hand: the
**on-demand workflows**. GitHub's standard runners are free for a public
repository, so a batch's suites, playtests and gates need not hold a local
machine for an hour.

## Lanes

What a pull request starts depends on what it changes. `Tests` (`ci.yml`),
`Format, lints, tests` (`forge.yml`) and `Base branch` (`pr-base.yml`), the
checks `next` requires, report on every pull request; the other workflows
start only on their paths. A newer push to a pull request cancels the runs
of the older one (`tests/ci-lane.test.js` holds every pull request workflow
to it).

`Tests` picks its lane from the files the pull request changes
(`tools/ci-lane.js`, run from the base branch's copy so a pull request cannot
pick its own): **documentation** alone (anything under `docs/` or
`.github/ISSUE_TEMPLATE/`, a `.md` at the root or under `.github/`) that no
Node test and no check of `ci.yml` reads runs only the checks every tracked
file gets (wording, names, SVGs: about a minute and a half). Anything else,
anything unsure, and every push to `main` or `next` runs the **full** lane:
forge built, the Node suite, the changelog, translation and preview checks.
Markdown in the code folders (`changes/`, `tools/`, `tests/`, `skills/`,
`addon/`, `guides/`, ...) is a fragment, template, fixture or shipped file,
so it runs the full lane.

`forge.yml` runs the Rust and Lua suites (format, Clippy, the Rust tests with
the addon's Lua tests, the documented commands; the minimum Rust version and
the wasm32 build) when the pull request changes a path they read
(`FORGE_PATHS` in `tools/ci-lane.js`, from the base branch's copy too: the
Rust code, the addon, the data, the guides, the Lua stub and compiler
fixtures, and the documents the Rust tests read). Otherwise its `Forge lane`
job says skip, `Format, lints, tests` passes in seconds and MSRV and wasm32
are skipped. Pushes to `main` and `next` run them on the same paths.

| Change | `Tests` | `forge.yml` (Format, lints, tests incl. the addon's Lua tests; MSRV; wasm32) | Other |
|---|---|---|---|
| Documentation only (`docs/CI.md`, `CONTRIBUTING.md`, an issue form) | docs lane | skipped (the check passes) | `Base branch`, `Public text`, `Generated guides` |
| A document a Rust test reads (`docs/FORGE.md`, `docs/forge/`, `docs/API.md`, `docs/GUIDE_FORMAT.md`, `docs/PACK_FORMAT.md`, `docs/PACKS.md`, `README.md`, `THIRD_PARTY.md`) | docs lane | yes | as above |
| Addon Lua (`addon/`) | full | yes | `Textures` for `addon/Polestar/Theme/` |
| Rust (`rust/`) | full | yes | `Client` for `rust/crates/polestar-recording/` |
| A guide (`guides/`) | full | yes | |
| Corrections (`forever-db/`) | full | yes | `Data corrections` |
| Node tools and tests (`tools/`, `tests/`) | full | for `tests/lua/`, `tests/fixtures/dsl/` | `Textures` for `tools/media/` |

`tests/ci-lane.test.js` checks that `FORGE_PATHS` covers every document a
Rust test reads and that `forge.yml`'s push trigger lists the same paths.

## Merge queue

The workflows are ready for GitHub's merge queue on `next`: every check
`next` requires also reports for a merge group (`merge_group`), the commit
the queue builds from `next`'s tip and the pull requests ahead in it, so two
pull requests that each pass alone are tested together before either lands.

| Check | For a pull request | For a merge group |
|---|---|---|
| `Tests` | `ci.yml` | `ci.yml`, its lane from what the group changes on top of `next` |
| `Format, lints, tests` | `forge.yml` | `forge.yml`, the same |
| `Base branch` | `pr-base.yml` (`pull_request_target`) | `merge-queue.yml`: GitHub starts no `pull_request_target` run for a group, and a group only holds pull requests already based on `next` |

The release builds of `forge.yml` stay on pushes. With the queue on, a pull
request joins it with `gh pr merge --merge --auto` (or the "Merge when
ready" button): GitHub adds it once its own checks pass and merges it when
the group's do; a group that fails leaves the queue and the pull requests
behind it are tested again without it. `tests/ci-lane.test.js` holds every
required check to a workflow that starts on `merge_group`.

## Timing budgets

Some tests hold a figure read off a clock to a budget: a settings slider's
repaint, a recorder burst, a tooltip, a route plan (forge-addontest's
`assert_timing!`, the Node tests' `assertTiming`). The budgets are set on a
quiet machine; GitHub's shared runners are neither quiet nor alike, so CI
sets `POLESTAR_TIMING_BUDGETS=warn` (`ci.yml`, `forge.yml`,
`ondemand-suites.yml`) and a figure over its budget there is a warning
annotation on the run, not a failure. Everything else those tests check
(allocations, counts, what shows) still fails as usual. Anywhere the
variable is not `warn` (a local run, the release gate) the budgets fail the
test. The release gate runs them alone, enforced, with
`rust/scripts/timing-budgets.sh` ([RELEASING.md](RELEASING.md#steps), step 3);
`--list` names the tests it finds. A new timing assertion uses
`assert_timing!`/`assertTiming`, never a plain `assert!`.

## The on-demand workflows

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
  travel builds, legs bakes, replays of the arrow on recorded sessions, the sweeps that read
  recordings, the quiet performance run.
- The timing budgets, enforced (`rust/scripts/timing-budgets.sh`, alone on
  a quiet machine): on GitHub they only warn ([Timing budgets](#timing-budgets)).
- Deploys, releases and anything that needs a credential.
