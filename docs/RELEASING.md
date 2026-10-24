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
one of those three among its sources.

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
   forge data build --kb                     # fetches the sources first (forge data sources)
   forge data questdb
   forge data itemdb && forge data gear
   forge data sources --only builders && forge data codex   # release-safe inputs only
   forge release credits                     # Guiding Stars: data/credits.json + merged PRs (needs gh)
   forge guide lint
   forge guide compile
   ```

   `Polestar_QuestDB` is not in the repository (it is ignored, like the
   Codex): build it with `forge data questdb` on every release machine
   before `forge release pack`, or the zip goes out without it. The language
   folders (`Polestar_<locale>`: guide texts and names) are committed; rebuild
   their names with `forge data names` when the data changed.

   Before `credits`, add new Ko-fi supporters to `data/credits.json`
   (names only, highest total first; amounts are never stored).

3. Run the whole suite with the data built (nothing skips for missing data
   now):

   ```sh
   node --test "tests/**/*.test.js"
   ```

4. Pack and check the archives:

   ```sh
   rm -rf dist && forge release pack
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
   (cd rust && POLESTAR_ADDON_DIR="$smoke/AddOns" cargo test --release -p forge-addontest --test release)
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
