# CI and the on-demand runs

Every pull request runs CI on GitHub (`ci.yml`, `forge.yml` and the
workflows its paths start). The heavy checks a batch of work needs before
it is merged also run on GitHub, on any pushed branch or commit, started by
hand: the **on-demand workflows**. GitHub's standard runners are free for a
public repository, so a batch's suites, playtests and gates need not hold a
local machine for an hour.

| Workflow | What it runs |
|---|---|
| `ondemand-batch.yml` | the three below in one run: start this once per batch of work, not per item |
| `ondemand-suites.yml` | the Node suite (four shards), the Rust workspace (format, lints, tests, documented commands), the addon's Lua tests (forge-addontest) and CI's changelog, translations and previews checks |
| `ondemand-guides.yml` | guide compile (every compile check, as annotations), `playtest --honest`, then `playtest` per guide group (every start zone, each faction's 12-30, 30-40, 40-50 and 50-60, class, professions, reputation, collectibles, exploration, miscellaneous, legacy), per class when you name some |
| `ondemand-gates.yml` | the gates on committed files (generated guides not hand-edited, corrections, the public database's guard, one version everywhere, walking maps against `PACK.json`, changelog, translations, wording and parse tests) and the gates that need reference data (lint, prerequisite order, reported cases and their todos, route patterns, the guide-end sweep for fresh characters) |

They use no secret, write nothing outside the run, and run only when started
(`workflow_dispatch`, and `workflow_call` from the batch workflow): pushing a
branch starts none of them.

## Starting a run

GitHub runs a `workflow_dispatch` workflow only when the file is on the
repository's default branch, `next`: these become usable once they are merged
there. Start them from `next` and name the code to test with `ref`, so a
branch that does not have the files yet is tested too. The branch must be
pushed to GitHub.

```sh
gh workflow run ondemand-batch.yml --ref next -f ref=my-branch -f base=next
gh workflow run ondemand-guides.yml --ref next -f ref=my-branch -f groups=horde/30-40,class/ -f classes=Warrior,Mage
gh workflow run ondemand-suites.yml --ref next -f ref=my-branch -f data=public
gh run list --workflow ondemand-batch.yml -L 3      # then gh run watch <id>, gh run view <id> --log-failed
```

Each job's summary lists its findings; the log has the full output.

## Reference data on GitHub

`data/forever` is not in the repository. The guide, gate and (with
`data=public`) suite runs build it on the runner from public sources only,
as `data-corrections.yml` does: pfQuest, the CMaNGOS dump, the client tables
(the Actions cache `wago-cache.yml` fills) and the checkout's own
`forever-db/corrections`, plus `professions.json` from the same data. Forever's
quest data is not in it (Forge reads that from an installed addon:
[forge/data.md](forge/data.md#the-public-data-pack)), and nothing from
recordings is: it holds about 4,400 quests where the full build holds about
5,400, and 10,400 NPCs where it holds 13,700.

**What that means today:** on this data 140 of the 260 guide files have
compile errors (about 3,100; none on the full data), every leveling guide
among them, nearly all for quests, items and NPCs the data does not hold, and
`playtest` plays nothing from a set of guides that does not compile. So the
compile, `playtest` and data-gate jobs report those groups as not played (a
failure, never a pass); of the playtest groups only exploration compiles
whole. The same build with Forever's quest data added leaves 6 compile errors
in 4 files: the jobs become useful for the leveling route once the data the
runner builds holds the guides' quests (the public data pack, `forge data
fetch`, is not published yet).

A finding on this data can be the data's, not the guide's. With `base` (the
branch the batch started from), each check runs on the base as well and fails
only on findings the base does not have; line and step numbers are left out of
the comparison, so an inserted step does not make every later finding new. The
data stays inside the run (the Actions cache, never an artifact).

The suites run with `data=none` (the default) exactly as CI does: the tests
that read `data/forever` skip with a reason.

## What stays local

- The release data (`forge data build --kb`: Forever's quest data, recordings,
  the private corrections) and every gate run on it before a release
  ([RELEASING.md](RELEASING.md)).
- Anything that reads recordings, the game client, the walking grid, Leffe's
  maps or other files not in the repository: route builds, navigation and
  travel builds, legs bakes, the sweeps that read recordings.
- Deploys, releases and anything that needs a credential.
