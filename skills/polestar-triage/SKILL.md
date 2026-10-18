---
name: polestar-triage
description: Checks a Polestar bug report (a GitHub issue, a Discord post or an in-game /polestar report) against the guides, the reference data and the addon before anyone agrees it is a bug, then drafts a verdict and a reply. Use when asked to look at, triage, reproduce, answer or start on a Polestar issue or wrong-step report, before any fix.
compatibility: A Polestar clone. Reproducing in the data needs data/forever built (polestar data build), Node 24 or newer, and Lua 5.1 or LuaJIT for playtest and play.
---

# Triaging a Polestar report

A report is a lead, not a verdict. Players are often wrong, and so are the
agents they used to write the report. Your job is to find out what is true.
Agreeing with the reporter is not the goal. A guide changed to match a wrong
report breaks the route for every player who had no problem.

`polestar` below is `node tools/polestar.js` in the clone.

## 1. Read what was reported

Write down the reporter's claims, separate from their guesses about the
cause:

- the guide and the step (the title and number as the guide window shows
  them);
- what the step says, and what they say they found in the game;
- their race, class and level;
- the Polestar version. On an in-game report it is in the first line;
  otherwise ask for it;
- when it was reported. A version string can name a build from before
  that version's tag, so the date is what you compare fixes against;
- what the guide window said around the step, such as "Looking ahead. The
  guide is at step 9." (the player was viewing a step the guide had not
  reached) or a skipped step.

If the report has none of this, stop here and ask for it (step 5). Don't
reconstruct a report from guesses.

## 2. Rule out the usual causes

Most reports that turn out wrong have one of these causes. Check each one
and note what you found:

| Cause | How to check |
|---|---|
| Already reported | `gh issue list --state all --search "<quest id>"`, then the quest's name and the guide's title. Leave the issue you are triaging out of the results. Link an earlier issue; a duplicate is closed in favour of it. |
| Already fixed | `git log --oneline -S "<quest id>" -- guides/`, CHANGELOG.md since their version, and `changes/` (fixes merged but not released yet). Compare the fix commit's date with the report's, and check which release carries it with `git tag --contains <commit>` (plain `vX.Y.Z` tags only; `-rc` and `-test` tags are candidates). An unreleased fix on `next` or a `hotfix/` branch still counts as fixed. |
| Old or mixed install | A version older than the latest release; addon folders from two versions; `Polestar_Guides` missing. |
| The step was misread | Read the step on the version they run: `git show v<version>:<guide file>`. |
| Another addon | Quest arrows, waypoints or objective text that Polestar does not draw (Questie, TomTom, other guide addons). The report's "Other addons" field lists them; an issue the bot filed from Discord has them in its "**Addons:**" line, under the player's words. |
| Classic, not Forever | Forever moved givers, changed prerequisites and levels, and added quests. What a quest does on Classic proves nothing here. |
| Character state | A quest skipped earlier, an abandoned chain, a race or class the step is not for (`only` lines), a step the guide skipped or is looking ahead to. |
| The world, not the guide | An NPC that was dead, despawned or busy in an event, or a mob camp cleared by other players, while the data puts it where the guide says. The data's spawn and the reporter's `/polestar where` line settle where; only the game settles when. |
| Works as designed | The guide's `levels` line is the level range you are expected to be at, not every quest's level. A quest that is still green gives XP (grey is the game's grey level for the player); Options, Guide, Automation has "Skip grey quests" for players who want them gone. The comments at the top of the guide say what it leaves out on purpose. |
| Missing quest | `polestar find <id>` shows the quest's races, classes and prerequisites: a quest for another race or class, or behind a chain the route does not take, is left out on purpose, and the guide's top comments usually say so. |

## 3. Reproduce it

Find the step: `git grep -n "accept <id>" guides/` or
`polestar find <quest name or id>` (it prints the quest's giver, turn-in and
objectives from the reference data). Then use whichever of these fits the
claim:

- the guide source and the comments at the top of the guide, which explain
  the route's choices;
- the compiled step in `addon/Polestar_Guides/Guides.lua` (what the addon
  actually shows);
- `polestar lint`, and `polestar playtest --filter <guide> --class <Class>`,
  which plays the guide to the end in the real addon for that class;
- `polestar play`, which runs the real addon in a browser against the
  simulated world, to watch the step as the player saw it;
- the reporter's `/polestar where` line or Recorder file, against the step's
  coordinates.

Without `data/forever` you can still read the guide and Guides.lua. Say
which checks you could not run. Never claim a check passed that you did not
run.

## 4. Check the sources and give a verdict

Sources that count: the game's own data (`data/forever/*.json`, built from
the client and pfQuest), Wowhead's Forever database, Polestar Recorder
recordings, and what a maintainer saw in the game. Sources that don't
count: Classic Wowhead, Classic guides, memory, and your own training data.

Give one verdict:

- **Confirmed bug**: the guide, data or addon is wrong, with the evidence.
- **Already fixed**: it was a bug in their version, and a release or the
  coming one has the fix; name the commit and where it ships.
- **Reporter mistaken**: what Polestar does is right, with the evidence.
- **Partly right**: which claims hold and which don't.
- **Unclear**: what you checked, and the one piece of evidence that would
  settle it. When the data supports the guide but only the game can settle
  the claim (an NPC that was "not there"), this is the verdict, with what
  the data shows.

Name the evidence each time: the guide file and step, the quest id, the data
entry, the commit or changelog entry, the addon file.

Found something else wrong on the way, such as a tip naming the wrong place?
Report it separately in your answer. It does not change this verdict; it
gets its own issue.

## 5. Draft the reply

A human reads it before it goes up. Don't post it yourself, and don't write
as a maintainer. Keep it plain, warm and short, evidence first:

- Thank them, and say what you checked.
- The verdict in one sentence, then the evidence (step, quest id, file).
- When Polestar is right: say so politely and ask for whatever would change
  the verdict, such as a `/polestar where` line at the right spot, a
  screenshot, their version, or a Recorder file
  (`WTF/Account/<account>/SavedVariables/Polestar_Recorder.lua`).
- When it is a bug: say it is confirmed. Don't promise a release or a date.
  Name a release only when CHANGELOG.md lists the fix under it, or
  `git tag --contains` shows a released tag that has it.
- When it is already fixed: say which release has it and that updating
  fixes it, and ask them to say if it still happens after updating.

Suggest the labels with the draft; a maintainer sets them:

| Verdict | Label | Then |
|---|---|---|
| Confirmed | `confirmed`, plus `patch-candidate` when the fix is guide-only (CONTRIBUTING.md, "Branches") | the fix |
| Already fixed | none | closed as completed. The release workflow tells a Discord thread when the fix ships and labels the issue `released:<tag>` |
| Unclear | `needs-info` | without a reply it closes on its own after three weeks; a maintainer reopens it when the answer comes |
| Mistaken | none | closed as not planned, once the reporter has had the explanation |
| Duplicate | none | closed as a duplicate, linking the earlier issue |

## 6. Only then, fix

A confirmed bug in a guide goes on to the polestar-guide-fix skill
(`skills/polestar-guide-fix/SKILL.md`). A bug in the addon or the tools goes
to `next` with a test that fails before the fix (CONTRIBUTING.md, "Code
changes"). Don't fix a symptom: special-casing one quest id, hiding an error
or loosening a check is not a fix. If the real cause is out of reach, report
what you found and stop.
