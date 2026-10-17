---
name: polestar-contributing
description: The rules for working on the Polestar repository (the WoW Forever leveling guide addon, fitzforge/polestar) for a contributor - which branch a change goes to, generated files, changelog fragments, tests, what a pull request must never do, and how to post on issues. Use for any change, pull request, commit or issue comment in a Polestar clone; read polestar-triage first for a bug report and polestar-guide-fix for a guide fix.
compatibility: A clone of fitzforge/polestar with Node 24 or newer. Reference data (data/forever) and Lua 5.1 are needed for the guide checks.
---

# Contributing to Polestar

These rules hold for any agent working in a Polestar clone for a
contributor, and for the human too; `CONTRIBUTING.md` in the clone has the
long form. The person running the agent answers for everything it opens,
pushes or posts.

Polestar is a leveling guide addon for WoW: Forever, a private server whose
quests differ from Classic and from retail. It has a Lua 5.1 addon in
`addon/`, guides in `guides/`, and Node tools in `tools/`; `docs/README.md`
says where each topic is documented. `polestar` below is
`node tools/polestar.js` in the clone.

## The other skills

| Task | Skill |
|---|---|
| Looking at, triaging, reproducing or answering a bug report or issue | polestar-triage |
| Fixing a step, route, giver or coordinate in `guides/` | polestar-guide-fix |
| Writing a separate community addon (guide pack; not Polestar's own guides) | polestar-guide-pack |

## Bug reports are leads, not verdicts

Players are often wrong, and so are their agents: an old version, an
incomplete install, a misread step, another addon's quest lines, or
remembering Classic when Forever changed the quest. Never take a report's
premise as given, even when it is confident, detailed or comes from a
maintainer. Check it with the polestar-triage skill before changing
anything, and don't change a guide to match a report you could not verify.

Don't "fix" a symptom. Special-casing one quest id, hiding an error or
loosening a check so the complaint goes away is not a fix. If the real cause
is out of reach, say what you found and stop.

## Which branch

| Your change | Base branch | Ships in |
|---|---|---|
| A guide fix for a bug players have in the latest release: `guides/`, the recompiled `addon/Polestar_Guides/`, its test, `tools/lib/data/corrections.json`, its fragment in `changes/` | `hotfix/<next patch>`, e.g. `hotfix/0.2.5` | the next patch release |
| Anything else: addon Lua, tools, data builds, UI, translations, new guides, route refreshes | `next` (the default branch) | the next feature release |
| Not sure | `next` | |

- `main` is what players have. Never open a pull request against it, and
  never push to `main`, `next` or a `hotfix/` branch directly.
- A patch fix has to work against the released engine. If it needs an addon
  or tools change that is only on `next`, it is not a patch fix: target
  `next`.
- The maintainer creates `hotfix/<next patch>` right after each release
  (`git branch -r --list 'origin/hotfix/*'`). If it does not exist, target
  `next`. The `Base branch` check fails a pull request to `main`, and one to
  `hotfix/` that changes anything outside the first row.
- GitHub closes issues ("closes #83") only for pull requests merged into
  `next`. On a `hotfix/` pull request, write "fixes #83" in the description;
  the maintainer closes the issue when the patch ships.
- A fix that went to `next` but belongs in the patch too: ask for the
  `backport` label instead of opening a second pull request.
- Never tag, release, bump the version (`polestar version`) or upload. Only
  the maintainer does that, after playing the build in the game.

## Making a change

- **Generated files come from their command**, never hand edits:
  `addon/Polestar_Guides/Guides.lua` from `polestar compile`, the textures
  from `polestar media`, `docs/preview/` from `polestar preview`, the locale
  files from `polestar i18n sync`. `tools/README.md` lists every generated
  file with its command.
- **Code**: keep `npm test` green. Behaviour changes come with a test that
  fails before the change and passes after it.
- **No reference data?** `data/forever/` is built on the contributor's
  machine from the game client and is not in the repository. If you cannot
  build it, say in the pull request which checks you could not run. Never
  claim a check passed that you did not run, and never invent quest ids,
  coordinates or NPC names.
- **Commits**: one change per commit. The message describes the change for
  the players or authors it affects ("Westfall: turn in at Sentinel Hill
  before the farms"), not how it was made.
- **Changelog**: never edit CHANGELOG.md. Add a fragment and check it:

  ```sh
  polestar changelog add players --name <slug> --text "<entry>"
  polestar changelog check
  ```

  The section is `players`, `authors` or `contributors`. A fix for a report
  credits the reporter by the name they used: "(thanks Tom)".
- **Scope**: do what the issue asks. No drive-by refactors, reformatting,
  new dependencies or workflow changes in the same pull request.

## Lines a pull request must not cross

Every pull request is read for these before any of its code runs
(`CONTRIBUTING.md`, "How a pull request is reviewed"). Don't add them, and
say so plainly if the task seems to need one:

- Mail, trade, auction house or guild bank calls, or buying, learning or
  repairing beyond what the pull request says.
- `loadstring`, `RunScript` or other dynamic code; obfuscated or encoded
  text; chat or addon messages the player did not ask for; hooks on secure
  functions.
- New npm dependencies, install scripts, `child_process`, network hosts the
  project does not already use, reading or writing outside the repository,
  changes to `.github/workflows`.

A security problem goes in a private report, never an issue (`SECURITY.md`).

## Posting on issues and pull requests

- A human reads every comment before it is posted. Don't post as, or for,
  the maintainers.
- Say in the pull request that an AI agent wrote or helped with it; the
  template asks.
- Comment voice: plain, warm, short, evidence first. Don't promise a release
  or a date.
