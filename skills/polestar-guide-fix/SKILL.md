---
name: polestar-guide-fix
description: Fixes a confirmed wrong step in Polestar's own leveling guides (guides/forever) and takes it to a pull request on the right branch, with its test, the recompiled guides and the changelog entry. Use when changing a step, route, quest order, giver or coordinate in guides/ for a reported or found bug. Run the polestar-triage skill first when the bug comes from a report.
compatibility: A Polestar clone with data/forever built (polestar data build), Node 24 or newer, and Lua 5.1 or LuaJIT for playtest. Without the data, the fix can still be sent, saying which checks did not run.
---

# Fixing a step in Polestar's guides

`polestar` below is `node tools/polestar.js` in the clone. CONTRIBUTING.md
("Fixing a guide", "Branches") is the long form; docs/GUIDE_CHEATSHEET.md
has the guide format on one page.

## 0. Is it confirmed?

Fix only what you have shown is wrong. If the bug came from a report and
nobody has checked it yet, run the polestar-triage skill
(`skills/polestar-triage/SKILL.md`) first. A fix needs a verdict of
"confirmed" or "partly right" and the evidence behind it.

## 1. Pick the branch

| The fix | Base branch |
|---|---|
| Changes only `guides/`, the recompiled `addon/Polestar_Guides/`, `tests/guides-*.test.js`, `tools/lib/data/corrections.json` and its changelog fragment in `changes/`, for a bug in the latest release | `hotfix/<next patch>`, for example `hotfix/0.2.5` |
| Needs anything else (addon Lua, tools, a data addon), or the bug is only on `next` | `next` |
| Not sure | `next` |

```sh
git fetch origin
git branch -r --list 'origin/hotfix/*'     # the open patch branch, if any
git switch -c fix/<short-name> origin/hotfix/0.2.5    # or origin/next
```

A patch fix has to work with the released addon. If it needs an addon or
tools change that is only on `next`, it belongs on `next`. Never base a
branch on `main`.

## 2. Find the step and read why it is there

```sh
git grep -n "accept 184" guides/
polestar find 184
```

Read the comments at the top of the guide before moving anything. They say
where the route comes from and why it goes the way it does. A fix that
changes the route updates them too, so a later route refresh keeps it.

## 2b. Name the pattern and sweep for it

A confirmed report is one instance of a pattern. Before fixing it, name the
pattern in one line, for example "the first accept sends you past a giver
standing next to you" or "an `interact` goal for an objective that is
really a cast or /sit". Then look for the same thing in every guide, the
other faction's counterpart and the code path behind it (`git grep` on the
verb or quest pattern, `polestar lint`). Fix every real instance together,
or list the rest on the issue. The fix, its test and its changelog entry
cover the pattern, not only the step that was reported.

## 3. Make the change

- Look up every quest, NPC, object and item id, and every inn and flight
  point name, with `polestar find` before writing it. Never write one from
  memory: Forever's ids and givers differ from Classic.
- Leave out what the compiler fills in. `accept 184` is enough: the title,
  giver and coordinates come from the data. Type coordinates only for
  `goto`, `explore` or a place the data does not know.
- When the guide is wrong because the data is (a giver, a spawn, a drop),
  correct `tools/lib/data/corrections.json` as well, so the simulator and
  the next route refresh see it.
- Change only what the fix needs: no reformatting, and no "while I'm here"
  edits to other steps.

## 4. Pin it with a test

Add a case to `tests/guides-reported.test.js` (cave mouths go in
`tests/guides-caves.test.js`). It checks what the player gets, such as the
goal order or where the arrow leads, never the guide's wording. Name the
report in the test's title, following the cases already there. The test
should fail on the old guide and pass on the fixed one.

## 5. Check it

```sh
polestar lint
polestar playtest --filter <guide file or id>
polestar compile                            # rewrites addon/Polestar_Guides/Guides.lua
node --test tests/guides-reported.test.js
npm test
```

Commit the recompiled `addon/Polestar_Guides/` with the fix. Lint and
playtest must pass, and so must every class playtest plays.

Guides.lua is only ever the file `polestar compile` writes: never edit it by
hand and never splice in hunks from another compile. A spliced hunk can be
valid Lua that loads without an error while the game never sees its goals (a
goal left between a step's `title` and its `goals = {`, a step's goals left
open so the next step becomes one of its goals).

If a guide you did not touch changes in Guides.lua, your local data is older
or newer than the branch's. Keep only your change: compile the guides before
and after it with the same data, and merge that difference into the
committed file:

```sh
tmp=$(mktemp -d)
git archive <base branch> guides | tar -x -C "$tmp"   # the guides your change starts from
polestar compile --guides "$tmp/guides" --out "$tmp/before"
polestar compile --out "$tmp/after"
git merge-file addon/Polestar_Guides/Guides.lua "$tmp/before/Guides.lua" "$tmp/after/Guides.lua"
```

A conflict means your data differs from the branch's in the lines your change
touches: rebuild the data, or say so in the pull request and leave
Guides.lua to the maintainer.

## 6. Changelog and commit

- The changelog entry is a fragment in `changes/`, never an edit to
  CHANGELOG.md. It goes under "For players": say what the player sees now,
  and credit the reporter by the name they reported under:

  ```sh
  polestar changelog add players --name <guide>-<what> --text "<entry> (thanks Tom)."
  polestar changelog check
  ```

  The same fragment works on `next` and on a `hotfix/` branch; the release
  puts it under its version.
- One change per commit. The message is written for the player:
  "Westfall: turn in at Sentinel Hill before the farms", not "fix step 13".

## 7. The pull request

- Base it on the branch from step 1. The template asks for the verdict and
  its evidence, and which checks ran and which did not.
- Issues: write "closes #N" on `next`, or "fixes #N" on a `hotfix/` branch
  (GitHub does not close issues for those, so the maintainer does it when
  the patch ships).
- Say that an AI agent wrote or helped with it. The person running the
  agent reads the diff and the description before opening the pull request.
