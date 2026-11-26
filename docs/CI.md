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
to it). None of them runs on the maintainers' machine: a pull request never
waits on it. `Base branch` also fails a commit made as the maintainers'
account whose author or committer email is not the account's GitHub noreply
address (read through the API; contributors' own addresses are not checked).

`Tests` picks its lane from the files the pull request changes
(`tools/ci-lane.js`, run from the base branch's copy so a pull request cannot
pick its own). Each changed file falls in an area: documentation, a guide
(with its compile output: the guide packs, each language's `Texts.lua`),
the addon's Lua, data (`data/`, `forever-db/`), Rust, a changelog fragment,
or none.

- **docs**: documentation alone (anything under `docs/` or
  `.github/ISSUE_TEMPLATE/`, a `.md` at the root or under `.github/`) that
  no Node test and no check of `ci.yml` reads runs only the checks every
  tracked file gets (wording, names, SVGs: about a minute and a half).
- **part**: guides, Lua, data, fragments, Node test files and documentation
  only. forge comes
  from the Actions cache (keyed by `rust/` and the Lua it embeds; next's
  runs fill it), and the job runs the Node test files those changes can
  break (`tools/testsel.js`'s selection, from the base's copy), the
  changelog and translation checks, `forge guide check-generated` for a
  guide and the preview renders for Lua.
- **full**: Rust (the Node tests check what forge's commands answer), the
  Node tools and tests, workflows, anything unsure, and every push to
  `main` or `next`: forge built on a cache miss, the whole Node suite and
  every check.

`forge.yml`'s `Forge lane` job says one of three:

- **run** for Rust, the compiler's fixtures and the documents the Rust tests
  read (`RUST_PATHS`): format, Clippy, the Rust tests, the documented
  commands, the minimum Rust version, the wasm32 build, and the addon's Lua
  tests.
- **addon** for the rest of what the suites read (`FORGE_PATHS`: the addon,
  the guides, the data): the addon's Lua tests alone. Their test binaries
  are cached like forge (keyed by `rust/` and the stub's `simulate.lua`,
  which they embed), so no Rust is built unless
  the cache has none for this code.
- **skip** for anything else: `Format, lints, tests` passes in seconds.

The addon's Lua tests run in four shards at once (`Addon tests 1/4`: the
crate's unit tests and the scenes; `2/4` to `4/4`: addontest's tests dealt
out in turn) from one build (`Addon tests
build`); `Format, lints, tests` waits for every job its lane runs and fails
when one did not pass. Pushes to `main` and `next` run everything on
`FORGE_PATHS` and save the caches the pull requests after them read.

| Change | `Tests` | `forge.yml` | Other |
|---|---|---|---|
| Documentation only (`docs/CI.md`, `CONTRIBUTING.md`, an issue form) | docs | skip | `Base branch`, `Public text`, `Generated guides` |
| A document a Node test reads (`docs/GUIDE_CHEATSHEET.md`) | part | skip | as above |
| A document a Rust test reads (`docs/FORGE.md`, `docs/forge/`, `docs/API.md`, `docs/GUIDE_FORMAT.md`, `docs/PACK_FORMAT.md`, `docs/PACKS.md`, `README.md`, `THIRD_PARTY.md`) | docs | run | as above |
| Addon Lua (`addon/`, `tests/lua/`) | part | addon | `Textures` for `addon/Polestar/Theme/` |
| A guide with its compile (`guides/`, `addon/Polestar_Guides*/`, `Texts.lua`) | part | addon | |
| Data (`data/`, `forever-db/`) | part | addon | `Data corrections` |
| A changelog fragment (`changes/`) | part | skip | |
| Rust (`rust/`) | full | run | `Client` for `rust/crates/polestar-recording/` |
| A Node test file (`tests/*.test.js`) | part (the file itself) | skip | |
| Node tools, the tests' helpers and fixtures (`tools/`, `tests/helpers/`, `tests/fixtures/`) | full | addon for `tests/lua/`, run for `tests/fixtures/dsl/` | `Textures` for `tools/media/` |

A guide or data change can break a Rust test that reads the guides or the
data; the push run on `next` after the merge runs those.
`tests/ci-lane.test.js` checks that `RUST_PATHS` covers every document a
Rust test reads and that `forge.yml`'s push trigger lists `FORGE_PATHS`.

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

The post-merge gates (`next-gates.yml`, [After a merge](#after-a-merge))
run on a runner of our own. There `tests/perf.test.js` (step change, guide
open, catch-up, a walking frame, a quest-log burst, a gathering guide's
play) runs alone after the Node suite, with its budgets enforced. Those
budgets scale with the load its reference timing sees, and in warn mode
their figures went 3x over for two days unnoticed (#3730, #4065).
`POLESTAR_PERF_WARN` (comma-separated figure names) lets a figure known to
be over only warn while its issue is open. The workflow names the issue
beside it, and the fix takes the figure out of the list.

## Memory budgets

Some tests hold what the addon costs in memory, as the client counts it
(Lua 5.1, `collectgarbage("count")`), to a budget in KiB: the core at login
and the settings window (forge-addontest's `options_memory`), the guide pack
(`guides_memory`), the quest database (`questdb_memory`), the walking maps
(`nav_memory`), the names packs (`names_memory`), what a session builds once
(`memory_session`), the new-in-Forever quest ids (`new_in_forever`) and the
baked legs (`tests/legs-memory.test.js`). These figures don't depend on the
machine's speed, so they fail everywhere, CI included.

**Each budget is the figure measured on the frozen tree plus 3 %, and the
budgets move once per release, at the code freeze.** Then every memory test
runs three times on the release branch (the highest figure of the three
counts), and one pull request sets every budget with less room than that to
the figure plus 3 %, rounded up, with one table: budget, measured, old
budget, new budget, headroom. A budget more than 10 % over its figure comes
down to the figure plus 3 % in the same pull request; one 3 to 10 % over it
stays. Between freezes no budget is raised: a change that crosses one finds
what grew and trims it, or waits for the freeze.

The login figure depends on where the checkout is: the harness loads every
file by its absolute path, and each file's chunk name and the loader's file
lists keep that path, about 0.7 KiB for each character. The post-merge
runner's checkout path is 63 characters long, 25 to 35 more than a short
local one, so it reads the login 17 to 25 KiB higher. The login budget is
set on the runner's figure: measure it with the checkout mounted at a path
of the runner's length, or add that difference to a local run. The other
figures move by 5 KiB at most.

Not budgets of this kind: what one action allocates (a drag step, a hover,
a lookup, a step change: `settings_session`, `settings_perf`,
`settings_hover_perf`, the session's churn, `codex-lookup.test.js`), which
keeps its own margin for run-to-run spread, and the fixed limits (a round
repeated keeps no more, a switched-off pack costs nothing at login, a race's
legs stay under 1 MiB resident), which are design limits, not figures.

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

## Reference data

The tests that read `data/forever` used to skip in CI, so two pull requests
that each passed alone could break the data-dependent suites together. Now
every pull request's tests run with reference data, in two places:

| Where | Data | Who | Fails on |
|---|---|---|---|
| `Tests` (`ci.yml`, GitHub's runners) | the public data `ci-data.yml` built on `next` | every pull request, forks too | a failure next's run on the same data does not have |
| `Release data` (`ci-release-data.yml`, the maintainers' self-hosted runner) | the release data | pull requests from this repository's own branches that change the data (`data/`, `forever-db/`), not drafts; each push to a `release/` branch (the freeze); a run started by hand | any failure |

**Public data.** On every push to `next`, `ci-data.yml` builds the public
data (below), runs the whole Node suite on it and saves both in the Actions
cache (`public-data-<sha>`): the data, the client tables beside it and the
suite's failures (`.ci/baseline.jsonl`). A pull request's `Tests` restores
the entry of the commit it merges into (else the newest), runs its lane's
tests with it, and `tools/ci-failures.js` fails the job only on failures the
baseline lacks: a test that fails on the public data on `next` too is the
data's, not the change's. The data is built from `next`'s corrections, so
a pull request's own corrections show in it after the merge. Pushes run
without it (`ci-data.yml` is their data run). The baseline lists the tests
that pass on `next` as well, so a failing test it lacks is one `next`'s run
never ran. That is not always the pull request's: the newest baseline can be
older than the commit the pull request merges into (a run takes over half
an hour, and a newer push replaces a waiting one), so a test merged to
`next` in between is missing from it too. `tools/ci-tests.sh` runs those tests
again in the base checkout on the same data: one that fails there too is
`next`'s, and passes the job; one that passes there is a new failure. Only a
failing test the base does not have either (one the pull request adds or
renames) has nothing to be held to: for this repository's own branches it
is a warning, since the release data's runs check it (`Release data` when the
pull request changes the data, the post-merge gates after the merge); for a
fork it fails.

**Release data.** The release data is built from recordings and private
sources and is never published: it stays on the maintainers' machine, where
two self-hosted runners hold a read-only copy: one for pull requests
(labels `self-hosted`, `polestar-data`) and one for the gates on the merged
tree (`polestar-gates`: [After a merge](#after-a-merge) and the weekly
route run), so the gates never queue behind pull requests. Only code from
this repository's own branches runs there: the `Release data` job runs for
a pull request whose head branch is in this repository and that changes
the data (`data/`, `forever-db/`) once it is not a draft (marking a draft
ready starts it; a newer push cancels the older run), on each push to a
`release/` branch (the cut at freeze and any fix on the frozen tree: the
whole suite) and when started by hand; the gates run on pushes to `next`.
Every other pull request gets the release data's tests after the merge, in
the post-merge gates. Each runner checks every job
before it starts and refuses anything else (a fork's pull request, a push to a branch
other than `next`, `main`, `release/*` or `hotfix/*`, any other event), each
job runs in a fresh sandbox (the data and toolchains
read-only, no credentials of the machine, the job's own folder its only
writable one) and a runner is registered for one job at a time
(ephemeral). What a fork's pull request can and cannot read:

- it runs on GitHub's runners only, with the public data and a read-only
  token, never on the self-hosted runner;
- it can read what the Actions cache holds for `next`: forge, the addon's
  test binaries and the public data, all built from public sources;
- it cannot read the release data, the recordings or anything on the
  maintainers' machine: none of it is in the repository, an artifact or the
  cache.

Anyone with write access can push a branch whose pull request runs on the
self-hosted runner, so its code can read the release data; write access is
given with that in mind. A fork's change gets the release data's tests after
a maintainer merges it (the post-merge gates) or pushes it to a branch here.

`Release data` is not a required check: the runners are on one machine that
may be off. When it is off the job waits in the queue and the pull request
can still merge on `Tests`.

### How the public data is built

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

The on-demand suites run with `data=none` (the default) as before: the tests
that read `data/forever` skip with a reason.

## Guide texts

The guide translations (`guides/locales/`, docs/TRANSLATING.md "Guide
texts") are checked with `forge i18n guides check`: a translation that drops
or adds a line break (`\n`) or a `{kind:id}` name token, a stale translation
(its English changed: the guide was edited without `forge i18n guides
sync`), or a texts file no guide has. The check reads the reference data, so
it runs where the data is:

| Where | Languages | Fails on |
|---|---|---|
| `Tests` (public data) | those whose texts the pull request changes; every language when it changes a guide | an error the base's own texts do not have on the same data (`tools/ci-guide-texts.sh`) |
| `Release data` | the same, for a pull request that changes the data; every language at freeze | any error |
| Post-merge gates | every language | any error |

The public-text rule (CONTRIBUTING.md, "Commits and pull requests") holds
for the words players read as well: the `prose` rules of
`tools/lib/public-text.json` (no wording that says a route follows or was
checked against another guide, no claim about an update's size) cover the
guides, the fix records' words, the changelog fragments
(`changes/`), the Client's release notes and the CurseForge description, in
every lane (`tests/wording.test.js`), and pull request titles, descriptions
and commit messages (`Public text`).

## Route integrity

Triage after triage must not leave a route broken by something a fix took
out (#3654). A pull request from this repository's own branches that edits
a leveling guide and changes the data (its records in `data/`: route fixes,
guide fixes, places) gets these checks in its `Release data` job, against
the branch it merges into, on the release data (`tools/ci-route-gate.sh`):

| Check | Fails on |
|---|---|
| playtest of the edited guides and the next 3 of each one's chain | a stuck or failing play |
| `playtest --honest` on both trees | a failing finding the base does not have (step numbers left out when they are matched) |
| what the edited guides lose: every accept, hand-in, complete, kill and collect, and where each quest is now | a quest that leaves the route and is not named in the pull request's description; say there where its XP and time now come from |
| the level model, one class, both trees, the chain's factions | a guide end reached more than 0.3 level lower |

The headers against `data/route-levels.json` (`tests/route-levels.test.js`)
and the prerequisite order (`tests/prereq-order.test.js`) run with the
tests a guide change selects. The table goes to the run's summary and to
one comment on the pull request, kept up to date as it is pushed again. A
guide change without data records, and a fork's, gets the playtest and the
levels after the merge (the post-merge gates and the weekly run below).

Every Monday `route-health.yml` runs the whole route on the release data:
every leveling guide played, the level model for every race and class on
`next` and on the last release, and the flow diff against the release
(`polestar flow-diff`: zone visits, one-quest trips, carried quests, travel,
moved quests), the release's guides played on the data that release shipped
with (the runner's `$POLESTAR_DATA/releases/<tag>/`, RELEASING.md step 11).
The table goes to the open issue labelled `route-health`; a flow check that
could not run says so there. A stuck play or a guide end more than 0.3 level
lower than in the release also files a `next-gates` issue.

## After a merge

![Post-merge gates](https://github.com/fitzforge/polestar/actions/workflows/next-gates.yml/badge.svg?branch=next)

Every push to `next` runs `next-gates.yml` on the merged tree, on the
release data, on the self-hosted runner ([Reference data](#reference-data)):
the checks that only make sense on the tree two pull requests make
together.

| Gate | What fails it |
|---|---|
| Node suite on the release data | any failing test among those that read the data: the guide suites, danger, levels, guide ends, while-here (`tools/ci-data-tests.js`; `ci.yml`'s push run has the rest), all but `perf.test.js` |
| Perf budgets | `tests/perf.test.js` alone, its timing budgets enforced ([Timing budgets](#timing-budgets)): a figure over its scaled budget, but one `POLESTAR_PERF_WARN` names while its issue is open (now `burst`, #4066) |
| Guide lint | a lint error, leveling or experimental guides |
| Addon tests | any of forge-addontest's tests, all of them (the cached test binaries) |
| Playtest | a guide stuck or failing, leveling or experimental |
| Route speed | a time to the arrow's first walking route over 5 s in its 7 cases, or a settled route that differs from 0.4.2's |
| Arrow corner cadence | a case whose corner lag is worse than 0.4.1.1's (mean over 3 degrees worse and 6 or more, max over 45 and 10 worse), 24 cases |
| Arrow stretches | a guide stretch the arrow does not walk to its end; the table compares with 0.4.2's runs |

The route-speed, cadence and stretch gates' harnesses and baselines come
from the release gates and live with the runner (`$POLESTAR_GATES`), not in
the repository. A gate that cannot run (no data, no harness) fails like one
that finds something: nothing is skipped quietly.

Each gate runs whatever the others did; the run's summary has a row per
gate. A failing run turns the badge above red and files an issue labelled
`next-gates` with that table (or comments on the open one); the next run
that passes every gate closes it. Runs go one at a time, to the end: a newer
push waits, and the newest waiting push replaces an older one, so on a busy
day one run covers several merges.

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
