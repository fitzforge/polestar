---
name: polestar-contributing
description: The rules for working on the Polestar repository (the WoW Forever leveling guide addon, fitzforge/polestar) for a contributor - checking that no one else is already fixing an issue, that every pull request goes to next, linking the issue, generated files, changelog fragments, tests, what a pull request must never do, and how to post on issues. Use for any change, pull request, commit or issue comment in a Polestar clone; read polestar-triage first for a bug report and polestar-guide-fix for a guide fix.
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
2. **Is it checked?** Start from issues labelled `confirmed`; triage
   anything else first (polestar-triage).
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

Every pull request goes to **`next`**, the repository's default branch.
Never to `main`; the `Base branch` check fails those.

- Never push to `main` or `next` directly.
- A patch release is just a smaller, sooner release from `next` (version
  bump `x.y.Z`). All fixes go to `next`; there is one branch, one release path.
- Never tag, release, bump the version (`forge release version`) or upload. Only
  the maintainer does that, after playing the build in the game.

## What to run (and not run)

Run only the checks for what you changed. CI runs the full suite on every
pull request and tells you if anything else broke.

| What you changed | What you run |
|---|---|
| A guide step (edit to an existing `.guide` file) | `forge guide lint` and `polestar playtest --filter <guide>` (need reference data; say so in PR if unavailable); for a reported-bug fix, also `node --test tests/guides-reported.test.js` |
| A new or renamed guide file | Same lint and playtest; note in PR that `Guides.lua` needs recompiling — maintainer does it after merge |
| Addon Lua (`addon/Polestar/`) | `node --test tests/<area>.test.js` for the area you changed (find it: `grep -rl <module-name> tests/*.test.js`) |
| A tool or its library (`tools/`) | That tool's tests (`node --test "tests/<tool>*.test.js"`) |
| `tools/media/` (texture generators) | `polestar media` to see the textures; CI verifies the generators work |
| Player-facing English strings (`L["..."]`) | The area's tests (addon Lua row above); `i18n sync` is run by the maintainer — nothing extra from you |
| `forever-db/corrections/`, `data/mechanics-public.json`, `data/route-fixes.json` | `forge data check-corrections` (and `node --test tests/data-corrections.test.js` for corrections) |
| A changelog fragment in `changes/` | `forge changelog check` |

## Making a change

- **Do not commit generated files** unless your change is to their generator:
  - After the Forge cutover: the leveling guides listed in `guides/GENERATED.json` (first line `# Generated by forge build`, under `guides/forever/alliance/` and `guides/forever/horde/`), that file itself, and `forge/seed/` — written by Polestar Forge on the maintainer's machine; CI fails a pull request that edits them. Their fixes go into `forever-db/corrections/`, `data/mechanics-public.json` or `data/route-fixes.json` (docs/FORGE.md, "Fixing a generated guide"). Before the cutover (no `GENERATED.json`) the leveling guides are hand-edited on `next` and the cutover keeps those edits.
  - `addon/Polestar_Guides/Guides.lua` — compiled from `guides/` + `data/forever`; maintainer runs `polestar regen` after merge
  - `docs/preview/*.svg` — rendered from addon Lua; maintainer runs `polestar regen` after merge
  - `addon/Polestar/Media/*.tga` — generated from `tools/media/`; maintainer runs `polestar regen` after merge
  - Locale files (`addon/Polestar*/`) — synced from English strings; maintainer runs `forge i18n sync` after merge
  - Exception: if your change IS to the generator (`tools/lib/dsl/`, `tools/preview/`, `tools/media/`, or the English string set), commit the regenerated output so reviewers can see the diff.
- **Code**: behaviour changes come with a test that fails before the change and passes after it.
- **Data fixes**: a quest fact goes in `forever-db/corrections/`, how a quest is done in
  `data/mechanics-public.json`, whether the route takes a quest or keeps an order players asked for in `data/route-fixes.json`. Which file
  for what, with a worked example each: docs/FORGE.md "Changing the data" and docs/forge/data.md.
  Every correction needs a `source` (`{ "kind": "in-game-check", "ref": "#N" }`; kinds in the file's
  `_about`) and a note saying how the fact was checked, in your own words; never copy or cite a website.
- **No reference data?** `data/forever/` is built on the contributor's machine from the game client and is not in the repository. If you cannot build it, say in the pull request which checks you could not run. Never claim a check passed that you did not run, and never invent quest ids, coordinates or NPC names.
- **Commits**: one change per commit. The message describes the change for the players or authors it affects ("Westfall: turn in at Sentinel Hill before the farms"), not how it was made.
- **Changelog**: never edit CHANGELOG.md. Add a fragment and check it:

  ```sh
  forge changelog add players --name <slug> --text "<entry>"
  forge changelog check
  ```

  The section is `players`, `authors` or `contributors`. A fix for a report
  credits the reporter by the name they used: "(thanks Tom)". A tiny text
  fix (wording, typo) does not need a changelog fragment.
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
- Tick the AI-agent checkbox in the pull request template and fill in
  "Model and tool: <model name and version> via <app or CLI>" (for example
  "Claude Sonnet 4.6 via Claude Code", or "GPT-4o via Codex"). List every
  model that helped if more than one did. Leaving the line blank causes the
  maintainer to re-verify the work as if the model is unknown.
- Comment voice: plain, warm, short, evidence first. Don't promise a release
  or a date.
