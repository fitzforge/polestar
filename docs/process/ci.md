# What CI runs, where, and why

The working rules behind docs/CI.md (which has the details of each
workflow). Written for 0.4.3 (#3310), after 0.4.2's regressions got past a
CI that was green on every pull request ([0.4.2-lessons.md](0.4.2-lessons.md)).

## The three rules

1. **A pull request runs the checks for what it changes.** Updating a guide
   or the addon never builds forge or runs the Rust suites; a Rust change
   runs them all. The lane comes from the base branch's own copy of
   `tools/ci-lane.js`, so a pull request cannot pick its own.
2. **Every pull request's tests run with reference data.** The tests that
   read `data/forever` used to skip in CI; now they run on the public data
   for every pull request, and on the release data as well for pull
   requests from this repository's own branches.
3. **The merged tree is gated after every merge.** Two pull requests that
   were each green alone are tested together on `next`, on the release
   data, by the gates that need the whole tree. A failure is never silent:
   the run fails, the badge in docs/CI.md turns red and an issue is filed.

## What a pull request runs

| It changes | `Tests` | `Format, lints, tests` | Data |
|---|---|---|---|
| documentation only | the wording, name and image checks | passes at once | none |
| guides (with their compile), addon Lua, data, changelog fragments, Node test files | forge from the cache, the Node test files those changes can break, changelog and translation checks, check-generated for guides, the guide texts of the languages touched, the preview renders for Lua | the addon's Lua tests in four shards from cached test binaries | public data; release data too for this repository's branches |
| Rust | everything | everything: format, Clippy, the Rust tests, documented commands, MSRV, wasm32, the Lua tests | as above |
| the Node tools, the tests' helpers, workflows, anything unsure | everything | the Lua tests when it touches what they read | as above |

Contributors and agents keep forge (Rust) changes in their own small pull
request: a route or addon pull request that carries Rust runs the whole
Rust lane, which takes far longer.

What it changed, measured on GitHub's runners from the first job's start to
the last one's end (time waiting in GitHub's queue left out):

| Pull request | Before (21 Nov) | After (22 Nov) |
|---|---|---|
| a guide only | 21.3 min (#3544), data tests skipped | 5.6 min (#3709), data tests run on the public data |
| addon Lua only | 21.5 min (#3524) | 7.7 min (#3710) |

Before, the slowest check was `Format, lints, tests`: the whole Rust suite
(16 min of tests) on every guide, data and Lua change. The queue is the
other half of the wait: the repository's plan runs 20 jobs at once across
all pull requests, so fewer and shorter jobs per pull request also shorten
everyone's queue.

## Reference data, and what stays private

The release data is built from players' recordings and private sources and
is never published. Where each kind of data is:

| Data | Built from | Where it is | Who reads it |
|---|---|---|---|
| public data | public sources only (pfQuest, the CMaNGOS dump, the client tables, QuestieDB's Forever store, our committed corrections) | GitHub's Actions cache, built on every push to `next` | every pull request, forks included |
| release data | the release's data build (recordings, private corrections, the knowledge base) | the maintainers' machine only | the self-hosted runner's jobs |

The public data is close to the release data but not equal to it: some
tests fail on it on `next` too. `next`'s run on it records those failures,
and a pull request fails only on failures `next` does not have.

The self-hosted runner holds a read-only copy of the release data. It takes
only code from this repository: pull requests whose head branch is here,
and pushes to `next`, `main`, `release/*` and `hotfix/*`. It checks every job
before the job starts and refuses anything else, runs each job in a fresh
sandbox (the data and toolchains read-only, none of the machine's
credentials) and is registered for one job at a time.

What a fork's pull request can and cannot read:

- it runs on GitHub's runners only, with a read-only token;
- it can read the Actions cache: forge, the addon's test binaries and the
  public data, all built from public sources;
- it cannot read the release data, the recordings or anything else on the
  maintainers' machine, which are in no repository, artifact or cache.

Anyone with write access can push a branch here, and that branch's pull
request runs on the self-hosted runner and can read the release data. Write
access is given with that in mind. A fork's change meets the release data
after it is merged (the post-merge gates), or when a maintainer pushes it to
a branch here.

## After a merge

Every push to `next` runs the post-merge gates on the release data: the
whole Node suite, guide texts, guide lint, all of the addon's Lua tests,
playtest, the route-speed gate, the arrow's corner cadence and the arrow
through guide stretches. They run one at a time, to the end; on a busy day
one run covers several merges. A failing run files an issue labelled
`next-gates` (or comments on the open one) and the next passing run closes
it. Whoever merged since the last green run looks first.

## Routes don't break quietly

Triage after triage must not leave a route broken by something a fix took
out (#3654). A guide pull request from this repository's branches gets a
route check on the release data against `next`: the edited guides and the
next three of their chain played, the honest playtest on both trees, the
level model on both (no guide end more than 0.3 level lower), and a table
of every accept, hand-in, kill and collect the guides lose with where each
quest went. A quest that leaves the route must be named in the pull
request's description with where its XP and time now come from. The table
is posted on the pull request. Every Monday a whole-route run (every guide
played, the level model for every race and class, the flow against the
last release) posts its table to the `route-health` issue and files an
issue on a regression.

## The runners

Two self-hosted runners share the maintainers' machine for now, at low
priority, 14 GB between them on top of the machine's other heavy work:

- `polestar-data` (8 GB) takes the pull requests' `Release data` jobs:
  this repository's own branches, not drafts (marking a draft ready starts
  it), and a newer push cancels the older run. It was 6 GB until the first
  night, when branches still running two data test files at once went over
  it twice;
- `polestar-gates` (6 GB) takes only the post-merge gates and the weekly
  route run, so they never wait behind pull requests.

Both stop taking new jobs while the machine's pause file is there (when the
maintainer needs the machine free); a job already running finishes unless
the runners are stopped. When they are off, `Release data` waits in the
queue; it is not a required check, so a pull request can still merge on
`Tests`, and the post-merge gates run when the runners are back. They move
to a machine of their own when there is one.
