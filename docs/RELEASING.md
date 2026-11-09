# Releasing

Releases are built on a maintainer's machine, not in CI: the data addons are
generated from the game client's tables and local sources that are not in the
repository. CI (`.github/workflows/ci.yml`) runs the test suite on every push
and pull request against a fresh clone, where the tests that need built data
skip with a reason.

## What ships

`forge release pack` writes three files to `dist/` ([forge/release.md](forge/release.md)
has every release command):

| File | Contents |
|---|---|
| `Polestar-<version>.zip` | `Polestar` (with `LICENSE` and a player `README.txt`), `Polestar_Guides`, always `Polestar_Nav` (Polestar's walking router, started from Shortest Path Forever by Cillian Berragan, and Polestar's walking maps with `PACK.json`, its own GPL-3.0-or-later `LICENSE` and `CREDITS.md`; `forge nav check` must pass), `Polestar_QuestDB` / `Polestar_ItemDB` when built, and always `Polestar_Codex` (with its `LICENSE-DATA.txt`) |
| `Polestar_Recorder-<version>.zip` | `Polestar_Recorder` (optional, with `LICENSE`) |
| `SHA256SUMS` | checksums of both zips, in the format `sha256sum -c` reads |

Addon folders sit at the top level of each zip, so a player (or an addon
manager) extracts straight into `Interface/AddOns/`. The zips are
reproducible: the same sources give byte-identical archives, on every
machine.

Community addons are packed by their authors with `forge release pack` in the
pack folder (`<pack>/dist/<folder>-<version>.zip`, version from its
`pack.json`); see docs/PACKS.md.

## Version

The version lives in `package.json`, in `guides/pack.json` (the manifest of
our guides' pack: `forge guide compile` writes its version into `Polestar_Guides.toc`)
and in the `## Version` line of every addon TOC. One command sets them all:

```sh
forge release version            # print it; exit 1 if guides/pack.json or a TOC disagrees
forge release version 0.2.0      # set package.json, guides/pack.json and every addon TOC
```

Data addons rebuilt later take the version from `package.json`. Versions
follow `x.y.z`; `0.x` releases are betas.

## What a release holds

Feature releases are built from the full local data build of the steps below.
[THIRD_PARTY.md](../THIRD_PARTY.md) ("Distributing Polestar") lists what
that puts in the zip: QuestieDB facts in `Polestar_Guides`, `Polestar_QuestDB`
and `Polestar_Codex`, nothing from AtlasLoot, RareScanner or DungeonJournal,
and never the zone crossings pack (`forge release pack` leaves it out). The Codex is part of
Polestar (Lookup, Dungeons and Rares read it): `forge release pack` stops when
`Polestar_Codex` is not built, or was built with `--local-extras`, or names
one of those three among its sources. It warns when the Codex was built from
another data build than `data/forever` (its `Meta.lua` `builtAt` against
`data/forever/meta.json`'s): the pick-up guides' quest chains, NPC roles and
the Dungeons journal read the Codex, so data fixes made since reach players
only once `forge data codex` rebuilds it. Shipping an older Codex on purpose
is allowed; the warning says what stays behind.

All releases are built from `next`. A patch release (`x.y.Z`) is a smaller,
sooner release following the same steps with a patch version bump.
A feature release may go out as release candidates first; see
[Release candidates](#release-candidates). CONTRIBUTING.md ("Branches") tells
contributors which branch pull requests go to.

## After merging contributor PRs

Contributors edit source files and run only the tests for what they changed.
They do not compile `Guides.lua`, regenerate the UI previews, sync locale
files or rebuild the textures. After merging a PR that touches any of those
sources, run:

```sh
node tools/polestar.js regen
```

This runs `compile + i18n sync + preview + media` in order. Pass
`--no-<step>` to skip one you know is unaffected. `compile` needs the
reference data (`data/forever`); the other three do not.

Run `regen` once per merge or batch, then push the regenerated files on
`next`. You do not need to run it before every commit, only before pushing
a batch to `next` or starting the release steps below.

## On-demand runs on GitHub

A batch of work (an integration branch, a triage round) gets its full
suites, guide compile and playtests, and gates once, on GitHub's runners,
before it goes to `next`: the on-demand workflows, described in
[CI.md](CI.md). Start one run per batch, not per item, on the pushed
branch:

```sh
git push origin <branch>
gh workflow run ondemand-batch.yml --ref <branch> -f base=next   # everything, compared with next
gh workflow run ondemand-guides.yml --ref <branch> -f base=next -f groups=horde/30-40 -f classes=Warrior,Mage
gh workflow run ondemand-suites.yml --ref <branch>               # suites only (-f addontest=false ...)
gh workflow run ondemand-gates.yml --ref <branch> -f base=next   # gates only
gh run list --workflow ondemand-batch.yml --branch <branch> -L 3
gh run watch <id>; gh run view <id> --log-failed; gh run download <id> -p 'logs-*'
```

`--ref` is the branch whose code (and whose copy of the workflow) runs; it
must hold the workflow files, which every branch made from `next` does.
`workflow_dispatch` only offers workflows that are on the default branch
(`next`); until they are there, or to test a branch that predates them,
push the branch as `ci/<name>` instead: a push to `ci/**` runs the whole
batch on it, compared with `next` (`git push origin <branch>:ci/<name>`,
then delete `ci/<name>` when done). The `ref` input tests another branch or
tag of this repository with the workflow of the branch the run started
on.

Read the summary of each job first (findings new against the base), then
the `logs-*` artifacts for the full output. A finding that also shows on the
base is not the batch's. What the public reference data lacks, and what
stays local, is in [CI.md](CI.md#what-stays-local): the release data's gates,
the skip-ahead sweep and the upgrade harness still run locally before a
release.

### Security rules for the on-demand workflows

The repository is public and these workflows run code from branches, so
every one of them keeps these rules (a change to them is reviewed against
this list):

- Started only by `workflow_dispatch` (people with write access), by
  `workflow_call` from `ondemand-batch.yml`, and by a push to `ci/**` (also
  write access only). Never `pull_request_target`, never a fork's code: the
  code under test must be a branch or tag of this repository
  (`.github/actions/ondemand-ref` refuses pull request refs and bare
  commits) and is pinned to its commit once per run.
- `permissions: {}` at the top of each workflow and `contents: read` on
  each job, the minimum a checkout needs; no job asks for more.
- No secrets: none is read, and every checkout sets
  `persist-credentials: false`, so the code under test never holds the
  run's token.
- GitHub-hosted runners only (`ubuntu-latest`), never self-hosted.
- Every third-party action is pinned to a full commit SHA (the tag in a
  comment). The QuestieDB download is pinned by version and SHA-256.
- Caches: the Rust caches are written only by these runs (on branches of
  this repository, so a fork's pull request can neither write nor read them
  where these runs restore them); the client tables cache is restore-only
  (`wago-cache.yml` on `next` writes it); the forge binary and the public
  data pass from a run's first job to its others through one entry keyed by
  the run's id and attempt, read back by that exact key and never by a
  prefix.
- Artifacts hold logs only (test, compile, playtest and gate output), kept
  14 days: no data, no tokens, no environment dumps.
- Concurrency groups per workflow and branch: a new start waits for the
  running one (and replaces an older waiting one), so runs cannot pile up.

## Steps

These are the steps of a feature release. Replace `0.2.0` with the new
version throughout.

1. Start from a clean, up-to-date `next` with the game client installed
   (the data build reads its tables and installed addons). Work and pull
   requests for the coming release collect on `next` (the default branch,
   pushed as it goes); `main` holds the latest release and moves only in
   step 7. Releases come in batches, when the maintainer decides.

2. Set the version and rebuild the data, the data addons and the guides:

   ```sh
   forge release version 0.2.0
   forge data build --kb --questie <AddOns folder of the QuestieDB to use>   # fetches the sources first (forge data sources)
   forge data questdb
   forge data itemdb && forge data gear
   forge data sources --only builders && forge data codex   # release-safe inputs only
   forge release credits                     # Guiding Stars: data/credits.json + merged or folded PRs + issues (needs gh)
   forge guide lint
   forge guide compile
   ```

   `Polestar_QuestDB` is not in the repository (it is ignored, like the
   Codex): build it with `forge data questdb` on every release machine
   before `forge release pack`, or the zip goes out without it. The language
   folders (`Polestar_<locale>`: guide texts and names) are committed; rebuild
   their names with `forge data names` when the data changed.

   Pass `--questie` explicitly on a release build. Without it the build
   picks the first QuestieDB it finds among the installed clients, so a
   client update or a second install (Forever moved from the
   `_classic_beta_` folder to its own `_forever_` product on 2026-11-08) can
   change the quest data under a release without any change in the
   repository. Use the QuestieDB version the last release's Codex records in
   `Polestar_Codex/Meta.lua`, unless the release moves to a newer one on
   purpose; the data build's statistics check stops a build whose QuestieDB
   changed underneath it.

   `forge i18n guides sync` and `forge guide compile` read the client's
   AreaTable from `data/sources/wago/<build>/AreaTable.csv`, found beside
   the reference data (`<data>/../sources`). Without it they still run, but
   place names stop being `{area:N}` tokens: sync then rewrites every
   language's guide-text keys and moves their translations to the "No longer
   in the guide" blocks (0.3.5 shipped that way). Run them in a checkout
   where `data/forever` is a real folder (not a symlink into a tree without
   `sources`) and `data/sources` holds the AreaTable; compile prints
   `areas: N of M place goals got an area (AreaTable <build>)`. Before
   packing, compare each `addon/Polestar_<locale>/Texts.lua`'s entry count
   with the last release's: a large drop means translations went missing.

   Before `credits`, add new Ko-fi supporters to `data/credits.json`
   (names only, highest total first; amounts are never stored). The bug
   reporters column counts a reporter's useful reports from the issues: the
   Discord name the bot filed it under ("**Reported by <name> on
   [Discord](...)**"), else the GitHub login that opened it. A report counts
   when it is labelled `confirmed` or `fix-merged`, or was closed as completed
   by a fix (a pull request that closed it, a `released:*` label, or a
   maintainer's comment saying it's fixed); never one closed as a duplicate or
   not planned, labelled `duplicate`, `invalid`, `wontfix` or `resolution:*`,
   still labelled `needs-info` or `stale`, or a feature request (`enhancement`
   without `bug`). The top 40 by count show, ties to whoever reported first.
   Check the printed list before committing it: add anyone who asks to be left
   out, by login or name, to `exclude` (the maintainer's Discord name is
   there too), and map a person's second name (a Discord name and a GitHub
   login) onto one with `names`.

3. Run the whole suite with the data built (nothing skips for missing data
   now):

   ```sh
   node --test "tests/**/*.test.js"
   ```

4. Pack and check the archives:

   ```sh
   rm -rf dist && forge release pack     # stops naming any guide whose legs are stale; add --bake --grid <canon grid> --leffe <Leffe's maps> to bake them
   (cd dist && sha256sum -c SHA256SUMS)
   unzip -l dist/Polestar-0.2.0.zip      # Polestar_Codex/ with its LICENSE-DATA.txt, and Polestar_Nav/ with its LICENSE and CREDITS.md, are listed
   forge nav check                       # Polestar_Nav's walking maps match its PACK.json
   ```

5. Smoke-test the zips as a player gets them: unpack both into an empty
   AddOns folder and load the addons from there under Lua 5.1, with the stub
   client the addon tests use (`POLESTAR_ADDON_DIR` points the test at
   another addon folder):

   ```sh
   smoke=$(mktemp -d)
   unzip -q dist/Polestar-0.2.0.zip -d "$smoke/AddOns"
   unzip -q dist/Polestar_Recorder-0.2.0.zip -d "$smoke/AddOns"
   (cd rust && POLESTAR_ADDON_DIR="$smoke/AddOns" cargo test --release -p forge-addontest --test addontest release::)
   rm -rf "$smoke"
   ```

   The test loads every addon of the release in client order, logs in, and
   checks that the guides registered, a guide opened, the data addons loaded
   and every TOC carries the release version.

6. Then install the zip into the game itself (remove the old `Polestar*`
   folders first), restart it fully and test what the release changes: play
   the first steps of a guide, and search, Dungeons and Rares when the Codex
   changed. This is a gate: nothing is tagged, pushed or uploaded (steps 7 to
   10) until the maintainer has played the release on their own client and
   said it is good. If the servers are down, the release waits.

   When the gamepad support changed (`UI/Gamepad.lua`, `UI/GamepadGuide.lua`,
   `Bindings.xml`), play it with a gamepad too: `/console taintLog 1`, then
   with "Browse the guide with the gamepad" on and again with the options
   open, walk into a fight and out of it (the windows give the gamepad back
   as it starts and take it again after), bind a button and a chord on the
   Key bindings tab, use the quest item from focus mode, and `/reload`.
   Then `/console taintLog 0`: `Logs/taint.log` names no Polestar file and
   the chat shows no `ADDON_ACTION_BLOCKED` or `ADDON_ACTION_FORBIDDEN`.

   Then once more with the game's gamepad interface on (Options, Gamepad,
   Enable Gamepad UI), with `taintLog` at 0 (on this client it breaks every
   addon's `hooksecurefunc` post-hooks, so a logged pass shows Polestar
   misbehaving where nothing is wrong): `/polestar` is unknown, the minimap
   button shows; open the options from it, move through them and close them
   with B, browse the guide, and let a route choice or a new character's
   welcome show by itself: it takes no button until the Browse the guide
   button is pressed. Open and close the world map, a quest giver's window,
   a vendor, the flight map and the talents with the gamepad. LB and RB +
   the D-pad keep targeting while no Polestar window holds the gamepad, and
   no "AddOn blocked" warning shows.

7. Assemble the changelog from the fragments in `changes/` (CONTRIBUTING.md,
   "Commits and pull requests"), then commit it with the version bump and
   the regenerated files that are tracked (`git status` lists them;
   `Polestar_QuestDB` and the other local packs are ignored) on `next`,
   bring `main` up to it, tag and push both. The maintainer's pushes pass
   the branch rules (see [Branch rules](#branch-rules)):

   ```sh
   forge changelog build 0.2.0     # writes "## 0.2.0 (<today>)", deletes the fragments
   git add CHANGELOG.md changes package.json guides/pack.json addon/Polestar addon/Polestar_Guides addon/Polestar_ItemDB addon/Polestar_Nav addon/Polestar_Recorder
   git commit -m "Release: 0.2.0"
   git switch main && git merge --ff-only next && git switch next
   git tag -a v0.2.0 -m "Polestar 0.2.0" main
   git push origin main next v0.2.0
   ```

8. Write the release notes. `forge release notes` drafts all three from the
   version's CHANGELOG.md section into `dist/` (not committed), each
   paragraph and list item joined onto one line, since GitHub shows every
   line break of a release's notes:

   ```sh
   forge release notes 0.2.0
   ```

   It writes `notes-0.2.0.md` (GitHub), `notes-curseforge-0.2.0.md` and
   `notes-discord-0.2.0.txt` (posts of at most 2,000 characters). Each
   starts with a `[[REPLACE ...]]` line: write the opening paragraph there.
   The drafts carry every player and author entry word for word; cut them
   down to what changed for players first (guides, routes, features,
   fixes), then for guide authors, and add the special thanks by hand.
   Hours to 60 are the simulator's model estimates and are written as such,
   with the world they come from.

9. Publish the release with the three files from step 4:

   ```sh
   gh release create v0.2.0 --verify-tag --title "Polestar 0.2.0" \
     --notes-file dist/notes-0.2.0.md --latest \
     dist/Polestar-0.2.0.zip dist/Polestar_Recorder-0.2.0.zip dist/SHA256SUMS
   ```

   A release is a full release, marked Latest, from 0.2.1 on, so the
   repository's Releases box and `releases/latest` point at it; the 0.x
   version and the notes say it is a beta.

10. Upload `dist/Polestar-0.2.0.zip` to CurseForge (Forever 1.60.1, release
    type Release: CurseForge's app lists a project only once it has one) and
    refresh the project description: the steps and settings are in
    [docs/curseforge/README.md](curseforge/README.md).


## Patch releases

A patch release (`x.y.Z`) uses the same steps as a feature release, with a
patch version bump. Every fix goes to `next` first; a patch release is just
a sooner release from `next`.

## The other releases: Forge, the open database, LibForeverData, the data pack

Four kinds of release are separate from the addon. Each is published on
its own schedule from `next`, never marked Latest (the addon's `v*` stays the
Latest release), and tells no Discord thread: the release notifier only acts
on addon tags (`v<digit>…`), and none of them counts as "the release before"
an addon release.

| Release | Tag | Who publishes it | What it holds |
|---|---|---|---|
| Forge | `forge-v<rust/Cargo.toml version>` | `.github/workflows/forge.yml` on the tag: builds Linux, Windows and macOS, checks the tag against the workspace version | `polestar-forge-<os>.tar.gz/.zip` and `SHA256SUMS` ([FORGE.md](FORGE.md), "Install") |
| The open Forever database | `data-v<forever-db/index.json version>` | `.github/workflows/data-release.yml`: `forge data publish --check`, then the zip and the SQLite | `forever-db-<version>.zip`, `forever-db-<version>.sqlite.zst`, `SHA256SUMS` ([forge/data.md](forge/data.md)) |
| LibForeverData | `lib-v<api>.<forever-db version>` | `.github/workflows/lib-release.yml`: the same guard, the library, its Lua test | `LibForeverData-<version>.zip` |
| The data pack | the fixed `data-pack` release (its assets are replaced) | the maintainer: `forge data pack --out dist --walks-from <a build with Leffe's maps>`, then `gh release upload data-pack dist/polestar-data-pack.* --clobber` | the contributors' data: client tables, the public KB, the walk stores including the walks on Leffe's maps (never his maps) |

Order for a release that changes them all: Forge first (contributors need
the new Forge to read the new pack), then the data pack from a build of that
commit, then `data-v` and `lib-v` (same `forever-db` version). Tag with
`git tag -a <tag> -m <tag> && git push origin <tag>`; the workflows do the
rest. The data pack's first publish creates the release:
`gh release create data-pack --title "Polestar data pack" --notes "…" --latest=false`.

## Branch rules

GitHub's rulesets for the repository, under Settings, Rules:

| Branch | Rules |
|---|---|
| `next` | changes by pull request only, with `Tests` and `Base branch` passing; no force push, no deletion |
| `main` | only maintainers update it; no force push, no deletion |

Repository admins bypass both, which the release steps rely on (the
pushes of step 7). Branches are deleted when their pull request merges.

## Release candidates

A feature release with a large change (a new engine, a new data build) can
go to testers first. Build it as in [Steps](#steps) with the version
`0.3.0-rc.1` and do steps 1 to 6, then:

- leave the fragments in `changes/`: only the final release runs
  `forge changelog build`. `forge changelog show` prints what the
  candidate carries, for its notes;
- tag `v0.3.0-rc.1` on `next`; `main` does not move for a candidate;
- publish with `gh release create v0.3.0-rc.1 --verify-tag --prerelease`
  (never `--latest`), so `releases/latest` stays on the last release. The
  Discord workflow then pings the tester role in the testers channel instead
  of telling bug threads their fix is out (tools/discord-bot/README.md);
- upload to CurseForge as release type Beta, which only players who opt in
  get.

Fixes go to `next` and out as `-rc.2`. When a candidate brings no new bugs,
set the version to `0.3.0` and release it with the full steps.
