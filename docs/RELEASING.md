# Releasing

Releases are built on a maintainer's machine, not in CI: the data addons are
generated from the game client's tables and local sources that are not in the
repository. CI (`.github/workflows/ci.yml`) runs the test suite on every push
and pull request against a fresh clone, where the tests that need built data
skip with a reason.

## What ships

`node tools/polestar.js pack` writes three files to `dist/`:

| File | Contents |
|---|---|
| `Polestar-<version>.zip` | `Polestar` (with `LICENSE` and a player `README.txt`), `Polestar_Guides`, always `Polestar_Nav` (Shortest Path Forever's walking router and maps by Cillian Berragan, with its own GPL-3.0-or-later `LICENSE`, `CREDITS.md` and `UPSTREAM.json`; `nav check` must pass), `Polestar_QuestDB` / `Polestar_ItemDB` when built, and always `Polestar_Codex` (with its `LICENSE-DATA.txt`) |
| `Polestar_Recorder-<version>.zip` | `Polestar_Recorder` (optional, with `LICENSE`) |
| `SHA256SUMS` | checksums of both zips, in the format `sha256sum -c` reads |

Addon folders sit at the top level of each zip, so a player (or an addon
manager) extracts straight into `Interface/AddOns/`. The zips are
reproducible: the same sources give byte-identical archives.

Guide packs are packed by their authors with `polestar pack` in the pack
folder (`<pack>/dist/<folder>-<version>.zip`, version from its `pack.json`);
see docs/PACKS.md.

## Version

The version lives in `package.json`, in `guides/pack.json` (the manifest of
our guides' pack: `compile` writes its version into `Polestar_Guides.toc`)
and in the `## Version` line of every addon TOC. One command sets them all:

```sh
node tools/polestar.js version            # print it; exit 1 if guides/pack.json or a TOC disagrees
node tools/polestar.js version 0.2.0      # set package.json, guides/pack.json and every addon TOC
```

Data addons rebuilt later take the version from `package.json`. Versions
follow `x.y.z`; `0.x` releases are betas.

## What a release holds

Feature releases are built from the full local data build of the steps below.
[THIRD_PARTY.md](../THIRD_PARTY.md) ("Distributing Polestar") lists what
that puts in the zip: QuestieDB facts in the guide pack, `Polestar_QuestDB`
and `Polestar_Codex`, nothing from AtlasLoot, RareScanner or DungeonJournal,
and never the zone crossings pack (`pack` leaves it out). The Codex is part of
Polestar (Lookup, Dungeons and Rares read it): `pack` stops when
`Polestar_Codex` is not built, or was built with `--local-extras`, or names
one of those three among its sources.

## Two kinds of release

| Release | Version | Carries | Built from | Steps |
|---|---|---|---|---|
| Feature | `0.x.0` | everything on `next`: the addon, the tools, the data addons, guides | a full data build | [Steps](#steps) |
| Patch | `0.x.y` | guide fixes for the latest release, nothing else | the last release's data addons, the guides recompiled | [Patch releases](#patch-releases) |

A feature release may go out first as release candidates, `0.3.0-rc.1`,
`-rc.2` and so on, for testers: see [Release candidates](#release-candidates).
CONTRIBUTING.md ("Branches") tells contributors which branch a pull
request goes to.

## Steps

These are the steps of a feature release. Replace `0.2.0` with the new
version throughout.

1. Start from a clean, up-to-date `next` with the game client installed
   (the data build reads its tables and installed addons). Work and pull
   requests for the coming release collect on `next` (the default branch,
   pushed as it goes); `main` holds the latest release and moves only in
   step 7. Releases come in batches, when the maintainer decides. If a
   `hotfix/` branch holds fixes that were never released, merge it into
   `next` first, then delete it.

2. Set the version and rebuild the data, the data addons and the guides:

   ```sh
   node tools/polestar.js version 0.2.0
   node tools/polestar.js data build
   node tools/polestar.js questdb build
   node tools/polestar.js itemdb build && node tools/polestar.js gear build
   node tools/polestar.js codex build        # release-safe; never --local-extras here
   node tools/polestar.js lint
   node tools/polestar.js compile
   ```

3. Run the whole suite with the data built (nothing skips for missing data
   now):

   ```sh
   node --test "tests/**/*.test.js"
   ```

4. Pack and check the archives:

   ```sh
   rm -rf dist && node tools/polestar.js pack
   (cd dist && sha256sum -c SHA256SUMS)
   unzip -l dist/Polestar-0.2.0.zip      # Polestar_Codex/ with its LICENSE-DATA.txt, and Polestar_Nav/ with its LICENSE and CREDITS.md, are listed
   node tools/polestar.js nav check      # Polestar_Nav matches its UPSTREAM.json
   ```

5. Smoke-test the zips as a player gets them: unpack both into an empty
   AddOns folder and load the addons from there under Lua 5.1, with the stub
   client the tests use (`POLESTAR_ADDON_DIR` points the test loader at
   another addon folder):

   ```sh
   smoke=$(mktemp -d)
   unzip -q dist/Polestar-0.2.0.zip -d "$smoke/AddOns"
   unzip -q dist/Polestar_Recorder-0.2.0.zip -d "$smoke/AddOns"
   POLESTAR_ADDON_DIR="$smoke/AddOns" node --test tests/release.test.js
   rm -rf "$smoke"
   ```

   The test loads every addon in the folder in client order, logs in, and
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
   node tools/polestar.js changelog build 0.2.0     # writes "## 0.2.0 (<today>)", deletes the fragments
   git add CHANGELOG.md changes package.json guides/pack.json addon/Polestar addon/Polestar_Guides addon/Polestar_ItemDB addon/Polestar_Nav addon/Polestar_Recorder
   git commit -m "Release: 0.2.0"
   git switch main && git merge --ff-only next && git switch next
   git tag -a v0.2.0 -m "Polestar 0.2.0" main
   git push origin main next v0.2.0
   ```

8. Write the release notes. `release notes` drafts all three from the
   version's CHANGELOG.md section into `dist/` (not committed), each
   paragraph and list item joined onto one line, since GitHub shows every
   line break of a release's notes:

   ```sh
   node tools/polestar.js release notes 0.2.0
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

11. Cut the next patch's branch from the new tag and push it, so guide
    fixes for this release have a base:

    ```sh
    git switch -c hotfix/0.2.1 v0.2.0 && git push -u origin hotfix/0.2.1 && git switch next
    ```

## Patch releases

A patch ships guide fixes on top of the latest release without the full
data build. Its branch, `hotfix/<version>`, is cut from the release's tag
(step 11 above), and guide fix pull requests are merged into it; the
`Base branch` check refuses a pull request there that changes anything a
patch may not carry. The example is `0.2.5` after `0.2.4`.

The patch is built with the release's own tools, which the branch has, and
run by `release patch` from a `next` checkout, which has the reference data
and the release tooling. Work in a worktree of the branch:

1. Check out the branch beside this one and run the patch build:

   ```sh
   git fetch origin
   git worktree add ../polestar-0.2.5 origin/hotfix/0.2.5 -B hotfix/0.2.5
   node tools/polestar.js release patch 0.2.5 --root ../polestar-0.2.5
   ```

   In the worktree it checks that the branch holds only what a patch may
   carry (`release scope`: the guides, the compiled guides, their tests,
   the data corrections, the changelog and its fragments), puts back the
   data addons the last release shipped (from its GitHub release, or
   `--zip <file>`), sets the version, lints and compiles with that
   checkout's tools and this checkout's `data/forever`, then lists the
   compiled guides that differ from the release. It stops when:

   - the branch has a path a patch may not carry: that change belongs on
     `next` and in a feature release;
   - `tools/lib/data/corrections.json` changed: run
     `node tools/polestar.js data build` in the worktree, then again with
     `--data-built`;
   - a compiled guide changed though its source did not: this checkout's
     `data/forever` was built from newer data than the release's; the same
     fix, `data build` in the worktree and `--data-built`.

   When the fixes bring a quest, NPC or object id the release did not have,
   rerun `codex build` in the worktree (the Codex reads our guides) and,
   once the release ships `Polestar_Names_<locale>`, `i18n names`.

2. In the worktree, run steps 3 to 6 above: the suite, pack, the zip smoke
   test and the in-game gate. In the game, play the steps the fixes changed.
   The suite reads the worktree's own `data/`, which a new worktree lacks;
   unless you ran `data build` there, link this checkout's for it
   (`ln -s "$PWD/data/forever" ../polestar-0.2.5/data/forever` from the
   `next` checkout), so the tests that need data run instead of skipping.

3. Assemble the patch's changelog, commit, bring `main` up to the branch,
   tag and push:

   ```sh
   cd ../polestar-0.2.5
   node ../polestar/tools/polestar.js changelog build 0.2.5 --root .
   git add CHANGELOG.md changes package.json guides/pack.json addon/Polestar addon/Polestar_Guides addon/Polestar_ItemDB addon/Polestar_Nav addon/Polestar_Recorder
   git commit -m "Release: 0.2.5"
   git push origin hotfix/0.2.5
   git fetch origin main && git push origin hotfix/0.2.5:main
   git tag -a v0.2.5 -m "Polestar 0.2.5" hotfix/0.2.5 && git push origin v0.2.5
   ```

   (`../polestar` stands for the `next` checkout.) Pushing the branch to
   `main` is a fast-forward: the branch was cut from the release `main`
   holds.

4. Close the issues the patch fixes, as completed, before publishing: their
   pull requests went to the `hotfix/` branch, so GitHub did not close
   them, and the release workflow tells the Discord threads of issues
   closed by the time the release is published.

5. Steps 8 to 10 above, with `release notes 0.2.5 --root .`: the notes, the
   GitHub release, CurseForge.

6. Publishing the release opens a pull request merging `main` into `next`
   (`.github/workflows/merge-back.yml`). Merge it with a merge commit, never
   a squash. It can stop on `addon/Polestar_Guides/Guides.lua`, which both
   branches regenerate: resolve it locally, taking `next`'s side, then run
   `node tools/polestar.js compile` on `next` and commit the result with the
   merge. The version files take `0.2.5`; the next feature release sets its
   own in step 2. Pull requests opened by a workflow start no checks:
   close and reopen it to run them.

   A release runs the workflows of its tagged commit. Patches cut from a
   release older than these workflows (every 0.2.x patch) run without
   them: run "Merge back" and "Discord release notes" by hand, from `next`,
   with the patch's tag (Actions, the workflow, Run workflow).

7. Remove the worktree, delete `hotfix/0.2.5` on GitHub and cut
   `hotfix/0.2.6` from `v0.2.5`, as in step 11.

## Fixes merged into `next` that a patch should carry

A guide fix merged into `next` that belongs in the coming patch gets the
`backport` label, before or after the merge. `.github/workflows/backport.yml`
then opens a pull request cherry-picking it onto the one open `hotfix/`
branch (it comments instead when there is none, or several). That pull
request goes through the same review and `Base branch` check as any other;
close and reopen it to start its checks. A fix that needs anything `next`
has and the release lacks is not a patch fix: leave the label off.

## Branch rules

GitHub's rulesets for the repository, under Settings, Rules:

| Branch | Rules |
|---|---|
| `next` | changes by pull request only, with `Tests` and `Base branch` passing; no force push, no deletion |
| `hotfix/**` | changes by pull request only, with `Tests` and `Base branch` passing; only maintainers create one; no force push |
| `main` | only maintainers update it; no force push, no deletion |

Repository admins bypass all three, which the release steps rely on (the
pushes of steps 7 and 11, and of patch step 3). Branches are deleted when
their pull request merges.

## Release candidates

A feature release with a large change (a new engine, a new data build) can
go to testers first. Build it as in [Steps](#steps) with the version
`0.3.0-rc.1` and do steps 1 to 6, then:

- leave the fragments in `changes/`: only the final release runs
  `changelog build`. `node tools/polestar.js changelog show` prints what the
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
