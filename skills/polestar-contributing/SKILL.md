---
name: polestar-contributing
description: The rules for working on the Polestar repository (the WoW Forever leveling guide addon, fitzforge/polestar) for a contributor - checking that no one else is already fixing an issue, that every pull request goes to next (patch fixes arrive by backport), linking the issue, generated files, changelog fragments, tests, what a pull request must never do, and how to post on issues. Use for any change, pull request, commit or issue comment in a Polestar clone; read polestar-triage first for a bug report and polestar-guide-fix for a guide fix.
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

## Before you start on an issue

Many contributors' agents work on the same reports at once, and two pull
requests for one bug waste both. Before you write any code for an issue:

1. **Is someone already on it?** Run all three, and read what they find:

   ```sh
   gh issue view <N> --comments          # a "Pull requests for this issue" comment, the has-pr label, "I'm on this"
   gh pr list --state open --search "<N>"
   gh pr list --state open --search "<quest id or guide name>"
   ```

   An open pull request that covers the issue means you don't open another.
   Tell the person running you, and offer to review it, try it, or add
   the missing part on that pull request (a comment, which a human reads
   first). A different fix for the same bug is a review comment on theirs,
   not a second pull request.
2. **Is it checked?** Start from issues labelled `confirmed` or
   `patch-candidate`; triage anything else first (polestar-triage).
3. **Claim it visibly.** Draft a short "I'm looking at this" comment for
   the person running you to post, and open the pull request early (a draft
   while unfinished).
4. **Link every issue it fixes** so the workflow lists the pull request on
   the issue and labels it `has-pr`: the number in the title (`(#302)`), or
   "closes #302" in the description, once per issue. "See #302" or
   "refs #302" is only a link.
   Don't link an issue you are not fixing: a Discord reporter is told a fix
   is open when the first pull request for their issue appears.
5. **The label `overlap`** on your pull request means another open pull
   request addresses the same issue; its comment names it. Compare them and
   say on yours what each covers. The maintainer merges one: correct and
   complete first, then the earlier one.

A claim with no commit or reply for a week is free to take over: say so on
the issue first. CONTRIBUTING.md, "Before you start", is the long form.

## Which branch

| Your change | Base branch | Ships in |
|---|---|---|
| Anything: guide fixes, addon Lua, tools, data builds, UI, translations, new guides, route refreshes | `next` (the default branch) | the next feature release |
| A guide-only fix players need sooner: `guides/`, the recompiled `addon/Polestar_Guides/`, its test, `tools/lib/data/corrections.json`, its fragment in `changes/` | `next` as well; the maintainer labels it `backport` after it merges | the next patch release too |

- Never open a pull request against `main` or a `hotfix/` branch, and never
  push to `main`, `next` or a `hotfix/` branch directly. The `Base branch`
  check fails a contributor's pull request to either.
- The `backport` label opens the patch pull request on the open `hotfix/`
  branch on its own. Don't open a second pull request for it; if you think
  your fix belongs in the patch, say so in the description.
- A patch fix has to work against the released addon. If it needs an addon
  or tools change that is only on `next`, it waits for the feature release.
- Never tag, release, bump the version (`polestar version`) or upload. Only
  the maintainer does that, after playing the build in the game.

## Making a change

- **Generated files come from their command**, never hand edits:
  `addon/Polestar_Guides/Guides.lua` from `polestar compile`, the textures
  from `polestar media`, `docs/preview/` from `polestar preview`, the locale
  files from `polestar i18n sync`. `tools/README.md` lists every generated
  file with its command.
- **Code**: run only the tests for what you changed:
  `node --test tests/<file>.test.js`. You don't need the whole suite; CI
  runs it on your pull request and tells you if anything else broke.
  Behaviour changes come with a test that fails before the change and
  passes after it.
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
