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
follow `x.y.z`, with an optional fourth number for urgent hotfixes; `0.x` releases are betas.

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

Branches: every pull request goes to `next`. A feature release is cut from
`next` as `release/<version>` when it freezes; the data build, the bake, the
gates, release candidates and the maintainer's in-game test happen there, and
only fixes for that release go in, while `next` keeps taking pull requests. A
patch release (`x.y.Z` or a fourth number for an urgent hotfix) is cut as
`hotfix/<version>` from the latest release's tag, with only its fixes. Either
one ships the same way: `main` is fast-forwarded to it and tagged, then it is
merged back into `next` and the branch deleted. Below, "the release branch"
is that `release/` or `hotfix/` branch. A feature release may go out as
release candidates first; see [Release candidates](#release-candidates).
CONTRIBUTING.md ("Branches") tells contributors which branch pull requests go
to.

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

1. Cut the release branch and work from a clean checkout of it, with the game
   client installed (the data build reads its tables and installed addons):
   `git switch -c release/0.2.0 origin/next` (a patch:
   `git switch -c hotfix/0.2.1 v0.2.0`), then push it. Pull requests keep
   collecting on `next` (the default branch); `main` holds the latest release
   and moves only in step 7. Releases come in batches, when the maintainer
   decides.

2. Set the version and rebuild the data, the data addons and the guides:

   ```sh
   forge release version 0.2.0
   forge data build --kb --questie <AddOns folder of the QuestieDB to use>   # fetches the sources first (forge data sources)
   forge data questdb
   forge data itemdb && forge data gear
   forge data sources --only builders && forge data codex   # release-safe inputs only
   forge release credits                     # Guiding Stars: data/credits.json + merged or folded PRs + issues (needs gh) + translators; --release-ref <branch> when HEAD isn't the release
   forge guide lint
   forge guide compile
   forge guide lint experimental && forge guide compile experimental   # Polestar Experimental (alpha guides)
   ```

   `experimental/` holds Polestar Experimental: guides for Forever's new
   zones in testing, a pack of Polestar's own that ships in the zip as
   `Polestar_Experimental`, loaded on demand and off until a player chooses
   one of its guides at a route choice or switches it on under Options >
   Community guides (PACK_FORMAT.md, "Polestar's own extra packs"). `forge
   release version` sets its `pack.json` with `guides/pack.json`, and `forge
   release pack` builds it again and stops on an error in it. `forge guide
   compile` reads it too: Polestar_Guides carries the index of the
   experimental guides our route choices offer, so compile both after an
   edit to either.

   `Polestar_QuestDB` is not in the repository (it is ignored, like the
   Codex): build it with `forge data questdb` on every release machine
   before `forge release pack`, or the zip goes out without it. The language
   folders (`Polestar_<locale>`: guide texts and names) are committed; rebuild
   their names with `forge data names` when the data changed, and their
   subzone names with `forge data subzones` when the walking maps did.

   Compile after `forge release version`, never before: `forge release
   version` writes the TOCs, but the guide pack's version in
   `Polestar_Guides/Pack.lua` comes from the compile. The Engine maps a save
   to changed guides (steps added behind the player, moved steps) only when
   the save's pack version differs from the pack's, so a pack still carrying
   the last release's version skips that mapping for every save made on it.
   Check before packing, and on the zip: `Pack.lua`'s `version` and every
   `Polestar_Guides*` TOC equal the release version (a test build carries
   its `x.y.z-rcN` the same way).

   After the last change to a leveling guide, regenerate
   `addon/Polestar/Core/LegacySteps.lua` with every release players may
   update from as an `--old` (each `vX.Y.Z` tag's `guides`, the last release
   included): `git archive <tag> guides | tar -x -C <dir>/<tag>`, then
   `node tools/legacy-steps.js --old <dir>/v0.3.4/guides ... --old
   <dir>/<last release>/guides`, and commit it. The mapping above reads a
   save's changed steps from it: a step it does not list keeps no check-off,
   skip or saved view, and nothing in its stretch passes behind the player;
   its `ns.LegacyMovedIn` (the quests each guide now offers that a release
   offered in another guide) keeps old-route progress from placing a player.
   0.3.7.2 changed 23 guide files without a new one, and 0.4.0's had no
   0.3.7.x in it (#2350).

   Don't regenerate `addon/Polestar/Nav/TravelData.lua` (`forge data
   travel`) on a release build unless its output keeps every portal and
   every flight point of the committed file (the Forever ones need the
   Forever build's TaxiNodes and TaxiPath in `data/sources`: `forge data
   sources --only builders`): check `git diff` before committing.

   Pass `--questie` explicitly on a release build. Without it the build
   picks the first QuestieDB it finds among the installed clients, so a
   client update or a second install (Forever moved from the
   `_classic_beta_` folder to its own `_forever_` product on 2026-11-08) can
   change the quest data under a release without any change in the
   repository. Use the QuestieDB version the last release's Codex records in
   `Polestar_Codex/Meta.lua`, unless the release moves to a newer one on
   purpose; the data build's statistics check stops a build whose QuestieDB
   changed underneath it.

   A newer QuestieDB can narrow quests' races: its generated Forever quest
   base takes a web-database scrape's race lists, which can leave out races
   that take the quest in game (1.0.14 narrowed 75 quests; corrections set
   them back). Before a release moves to one, build it once into a copy of
   `data/forever` (`--out <copy>`), lint every guide on that build, and read
   the statistics report's `quests.races.*` lines. Build into a copy, never
   an empty folder: the knowledge base adds the Forever world database's
   class trainers to the `trainers.json` it finds in the output folder, and
   the statistics check compiles the guides with the files already there.

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

   Run `credits` on the commit the release ships, before it reaches
   `next`: contributors' pull requests batched into the release's
   integration branch (merged at their exact head commits) are still open
   on GitHub until that push, and count only because their head is on the
   release ref. The ref is the checkout's `HEAD`; from another checkout name
   it with `--release-ref` (e.g. `--release-ref origin/dev-040`). Drafts
   count the same way, only when their head is on the ref. A pull request
   whose author pushed again after the batch doesn't count (and GitHub won't
   mark it merged) until the batch merges its new head. Issues that such an
   open pull request closes count for their reporters as fixed. Check the
   printed line: "N by merged pull requests alone" against the total shows
   how many contributors the batches add.

   Before `credits`, add new Ko-fi supporters to `data/credits.json`
   (names only, highest total first; amounts are never stored), and anyone
   whose idea shipped though someone else built it to its `ideas`
   (`{ "name": "<login>", "ref": <pull request or issue> }`; the changelog's
   "idea by" and "idea first proposed by" credits are the list to check). The
   translators come from the locales' `translators` (rust/crates/forge-guide/
   src/locales.rs and tools/lib/i18n/locales.js). The bug
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

   Then the timing budgets, enforced, with nothing else running on the
   machine (no build, no other suite, the game closed). CI on GitHub's
   shared runners only warns on them (CI.md, "Timing budgets"), so this
   run is where a slower settings drag, recorder burst, tooltip or route
   plan stops a release. It runs every forge-addontest test that uses
   `assert_timing!` and the Node tests that use `assertTiming` (`--list`
   names them), one at a time:

   ```sh
   rust/scripts/timing-budgets.sh
   ```

   Then the reported-problems gate: every player-reported problem that was
   fixed stays fixed. It runs the tests `tests/reported-gate.json` names for
   each confirmed report, the whole of `tests/guides-reported.test.js`, the
   judge's player-report seeds on the shipped guides and the danger gate
   (`tools/danger-gate.js`) on the candidate's calibrated level model, and
   names the reports whose tests fail:

   ```sh
   npm run test:reported -- --levels <Alliance.json>,<Horde.json>
   ```

   A fix for a report adds the report to `tests/reported-gate.json` with the
   test that pins it (`tests/reported-gate.test.js` checks every test named
   there exists).

   Then the pin coverage guard: every issue closed as completed has a test
   that names it (in `tests/reported-gate.json`, or a test mentioning `#N`),
   and every route, guide and place record still names a quest some guide
   has. The gaps known when the guard came in are listed with why in
   `tests/pin-coverage.json`; anything else fails:

   ```sh
   node tools/pin-coverage.js      # reads the closed issues with gh
   ```

   A new unpinned fix gets its test (or, when nothing can be checked, an
   entry saying why); a listed gap that is closed now leaves the list
   (`node tools/pin-coverage.js --offline --prune`, in the pull request
   that closes it). `tests/pin-coverage.test.js` checks the list in the
   suite: no record matching nothing beyond it, no entry a test names.

   Then the imperfect players: the guides played by players who skip a
   step, lose a quest item before its hand-in, did a quest before the guide
   offers it, update mid-guide from the last release (its save opened on
   the new guides through `Core/LegacySteps.lua`), or start the route at a
   guide with nothing from the guides before it. None may be stuck: held on
   a step they can never complete. Give `--from` the last release's guides:

   ```sh
   git archive v<last release> guides | tar -x -C <dir>
   node tools/polestar.js playtest --persona all --from <dir>/guides
   ```

   A stuck play names the guide, the persona and what it did ("skips step
   89", "loses Thunder Applejack after getting it"). Fix the step (a `when
   has <item>` gate, a goal that gets the item again, the LegacySteps
   regeneration for an update), never the persona. `forge guide lint`
   already refuses the patterns it can see in the lines (the play checks in
   GUIDE_FORMAT.md's "Validation"); this catches the ones only play shows.

   Then the levels guard: every leveling guide's `levels` header says the
   levels the route brings a player there (per faction where a guide is
   shared). `data/route-levels.json` holds each guide's arrival and exit
   from the level model; refresh it from the same model runs the danger
   gate read, then run its test:

   ```sh
   node tools/route-levels.js --levels <Alliance.json>,<Horde.json>
   node --test tests/route-levels.test.js
   ```

   The refresh prints every guide whose arrival or exit moved by half a
   level or more. A header passes when its first level is the arrival
   floored or rounded and its last the exit floored or rounded (57.7 reads
   57 or 58). A failing guide gets its header fixed by hand (in the guide
   and its `forge/seed/` copy, with its pitch if the pitch quotes the range,
   `guides/GENERATED.json` and `forge/seed/SEED.json` rehashed, `forge guide
   check-generated` clean), or, when the header is right for players on
   other evidence, a `keep` row with the reason. On a release candidate fix
   only the guides the test names; never rewrite every header at once.
   Commit the refreshed snapshot with the release.

4. Pack and check the archives:

   ```sh
   rm -rf dist && forge release pack     # stops naming any leveling guide whose legs are stale or missing; add --bake --grid <canon grid> --leffe <Leffe's maps> to bake them
   (cd dist && sha256sum -c SHA256SUMS)
   unzip -l dist/Polestar-0.2.0.zip      # Polestar_Codex/ with its LICENSE-DATA.txt, Polestar_Nav/ with its LICENSE and CREDITS.md, and Polestar_Experimental/ are listed
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
   `Polestar_QuestDB` and the other local packs are ignored) on the release
   branch, bring `main` up to it, tag, push, then merge it back into `next`.
   The maintainer's pushes pass the branch rules (see
   [Branch rules](#branch-rules)):

   ```sh
   forge changelog build 0.2.0     # writes "## 0.2.0 (<today>)", deletes the fragments
   git add CHANGELOG.md changes package.json guides/pack.json experimental/pack.json addon/Polestar addon/Polestar_Guides addon/Polestar_Experimental addon/Polestar_ItemDB addon/Polestar_Nav addon/Polestar_Recorder
   git commit -m "Release: 0.2.0"
   git switch main && git merge --ff-only release/0.2.0
   git tag -a v0.2.0 -m "Polestar 0.2.0" main
   git push origin main v0.2.0
   git switch next && git merge --no-ff release/0.2.0 -m "Merge release 0.2.0 back into next"
   git push origin next && git push origin --delete release/0.2.0
   ```

   These pushes of `main`, `next` and the tag go past the branch rules on
   the maintainer's admin bypass, and only with the maintainer's go for that
   release; git prints "Bypassed rule violations" for them. Any other push
   that prints it (a branch, a tag deletion) is a mistake: stop and ask
   before going on.

8. Write the release notes. `forge release notes` drafts all three from the
   version's CHANGELOG.md section into `dist/` (not committed), each
   paragraph and list item joined onto one line, since GitHub shows every
   line break of a release's notes:

   ```sh
   forge release notes 0.2.0
   ```

   It writes `notes-0.2.0.md` (GitHub), `notes-curseforge-0.2.0.md` and
   `notes-discord-0.2.0.txt`. Each starts with a `[[REPLACE ...]]` line:
   write the opening paragraph there, saying what changes for players. The
   drafts carry every player and author entry word for word; cut them
   down to what changed for players first (guides, routes, features,
   fixes), then for guide authors, and add the special thanks by hand.
   Hours to 60 are the simulator's model estimates and are written as such,
   with the world they come from; any other speed claim says "in our
   testing". Never "our biggest update yet", "biggest ever", "massive
   update" or any other size or hype claim, in any of the texts. Promise
   only what works in the zip that ships, data packs included.

   Then the two Discord texts, built from the final notes (not the
   fragments), each post under 3,900 characters, covering the addon and
   the Polestar Client and Recorder together:

   - `dist/discord-announcement-0.2.0.md`: ONE post for the announcements
     channel: a plain "Polestar 0.2.0 is out" headline, an opening on what
     changes for players, every player-facing feature in grouped bullets
     (Routes, Guide window, Arrow and travel, Play together, Quality of
     life, Polestar Client and Recorder), how to update and where the full
     notes are.
   - `dist/notes-discord-0.2.0.txt`: the patch notes in as few posts as
     fit: post 1 "# Polestar 0.2.0 Patch Notes", the date, the notes'
     first sentence in bold, the rest of the opening and "## How to
     update"; then "## For players" over as many posts as it takes; the
     last post the thanks. Leave out the contributor section.

9. Close the issues the release fixes (its issue list and the milestone's
   closed-by-PR issues still open) BEFORE publishing: the Discord release
   notifier tells only the issues already closed when the release is
   published, and an issue closed afterwards is told "will ship in the next
   update" and announced again with the next release. Then publish the
   release with the three files from step 4. The release script
   (`GO-<version>.sh`) runs these in that order and refuses to publish when
   the notes, the CurseForge text or the Discord texts contain "biggest
   update", "biggest ever" or "massive update" (any case), next to its
   check for other addons' names:

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
| `next` | changes by pull request only, with `Tests`, `Format, lints, tests` and `Base branch` passing; no force push, no deletion |
| `release/**`, `hotfix/**`, `feature/**` | changes by pull request only, with green CI; only admins create them |
| `main` | only maintainers update it; no force push, no deletion |

Repository admins bypass them, which the release steps rely on (cutting the
release branch and the pushes of step 7). Branches are deleted when their
pull request merges.

## Release candidates

A feature release with a large change (a new engine, a new data build) can
go to testers first. Build it as in [Steps](#steps) with the version
`0.3.0-rc.1` and do steps 1 to 6, then:

- leave the fragments in `changes/`: only the final release runs
  `forge changelog build`. `forge changelog show` prints what the
  candidate carries, for its notes;
- tag `v0.3.0-rc.1` on the release branch; `main` does not move for a candidate;
- publish with `gh release create v0.3.0-rc.1 --verify-tag --prerelease`
  (never `--latest`), so `releases/latest` stays on the last release. The
  Discord workflow then pings the tester role in the testers channel instead
  of telling bug threads their fix is out (tools/discord-bot/README.md);
- upload to CurseForge as release type Beta, which only players who opt in
  get.

Fixes for the candidate go to its release branch (and on into `next` when it
is merged back) and out as `-rc.2`. When a candidate brings no new bugs,
set the version to `0.3.0` and release it with the full steps.
