# Contributing to Polestar

Polestar is a guide addon for WoW: Forever: a Lua 5.1 addon in `addon/`, the
guides in `guides/`, and Node tools in `tools/` that check, compile, play and
package them. You can help without touching any code.

## Ways to help

- **Report a wrong step.** A quest that is not where the guide says, a step
  that never checks off, an order that wastes a trip. In the game, click the
  bug in the guide window (or type `/polestar report`), say what is wrong and
  paste the report on the [Polestar Discord](https://discord.gg/vMbee6F2e9);
  or open an issue with the "Wrong step" form.
- **Fix a guide.** Guides are plain text files; a fix is often one line. See
  [Fixing a guide](#fixing-a-guide). New here? Start with an issue labelled
  [good first issue](https://github.com/fitzforge/polestar/labels/good%20first%20issue)
  or `confirmed`: small issues to start on, and confirmed guide-only fixes with
  the evidence on the issue.
- **Record a session.** The Polestar Recorder addon (its own download beside
  Polestar on the GitHub release; it runs with or without Polestar) logs your
  play: quests, routes, rares you see, what creatures and chests drop, the
  dungeons you enter. Turn it on with `/psrec on` and play. No tools needed to
  share it: after logging out, send the file
  `WTF/Account/<your account>/SavedVariables/Polestar_Recorder.lua` on Discord
  or attach it to an issue. We import it with
  `node tools/polestar.js record import --sv <file> --anonymize`, which keeps
  no character name or realm. With the tools set up you can measure a route
  yourself: `node tools/polestar.js record import`, then
  `node tools/polestar.js record report` gives per step times, XP per hour,
  deaths and detours.
- **Code.** Bugs in the addon or the tools; see [Code changes](#code-changes).
  For a Lua error, use the "Bug report" form.
- **Translate.** Polestar's interface is in German, Latin American Spanish
  and French, and AI-made languages need native speakers to check them.
  [docs/TRANSLATING.md](docs/TRANSLATING.md) shows the file to edit: a text
  editor is enough.
- **Suggest a feature.** Open an issue with the "Feature request" form, so the
  idea and the date it was asked stay in one place and anyone can pick it up.

## A good wrong-step report

The in-game report (the bug in the guide window) fills in most of this for
you: the guide, the step and its goals, your position, your race, class and
level, the versions and any errors Polestar caught. Add what is wrong.

- The guide and the step as the guide window shows them (the guide's title
  and the step's number and text).
- What is wrong: what the step says, and what you found in the game.
- The right spot: stand there and type `/polestar where`. It prints your map
  and position as guide lines (`zone map <id>` and `goto <x>,<y> live`) and
  opens them in a box you can copy from.
- Your race, class and level.
- Your Polestar version (shown at the foot of the Options sidebar and in the
  game's AddOns list).

## How a report is handled

A report is a lead, not a verdict: players are sometimes on an old version,
have an incomplete install, misread a step or meet another addon's lines. Each
report goes through the same steps before anything changes:

1. **Check the version and install.** The report's first line names the
   Polestar version. Is the step still the same on the coming release?
2. **Reproduce it.** In the data (`data/forever/*.json`, the compiled guide),
   in the test client (`tests/`, see tests/README.md) or in the game. A
   report that can't be reproduced gets an answer saying so, and why.
3. **Check it against the sources.** The game's own data, Forever's quest
   data, recordings. A player's memory of Classic is not a source: Forever
   changed many quests.
4. **Fix it only if it is real,** with a test that fails before the fix and
   passes after it (or, for a guide, lint and `playtest`).
5. **Credit the reporter** in the fix's changelog entry, "(thanks <name>)",
   and tell them which release carries the fix.

## Before you start

Many people, and their agents, work on the same reports at once. These
steps keep two of you from fixing the same thing without knowing:

1. **Look for work already open.** An issue with the label `has-pr` has a
   comment, "Pull requests for this issue", listing who is on it. Not every
   pull request names its issue, so search too:
   `gh pr list --state open --search "<issue number>"`, then the quest id
   and the guide's name. When an open pull request covers it, help there
   instead of opening another: review it, try it in the game, or offer the
   part it is missing.
2. **Start from a checked report.** Issues labelled `confirmed` have the
   evidence on them. Any other report is a lead: check it first
   ([How a report is handled](#how-a-report-is-handled)).
3. **Say you are on it.** Leave a short comment on the issue, and open your
   pull request early, as a draft while it is unfinished. Link the issue so
   it shows: the issue's number in the title (`(#302)`), or "closes #302"
   in the description, once for each issue it fixes. A plain mention
   ("see #302") is a link, not a claim, and does not list your pull request
   on the issue.
4. **If your pull request gets the label `overlap`,** another open pull
   request addresses the same issue (its comment names it). Compare the two
   and say on both what each covers. One is merged: the correct and complete
   one first, then the earlier. Useful parts of the other are carried over
   with credit to its author.
5. **One issue, one pull request.** The same bug in several guides is one
   pull request that fixes the pattern and lists every issue it closes.
6. **A claim that went quiet** (no commit or reply for a week) is free:
   say on the issue that you are taking it over, and go ahead.

An issue filed from the Discord #bugs forum tells its reporter in their
thread when the first pull request for it opens, so link only what you are
really fixing.

## Fixing a guide

Each guide's title leads to its file: the leveling guides live under
`guides/forever/<faction>/...` (for example
`guides/forever/alliance/02-westfall.guide` is "Westfall"), and the first
line of every file names the guide's id. To find the step for a quest, search
for the quest id:

```sh
git grep "accept 184"
```

- The format is in [docs/GUIDE_FORMAT.md](docs/GUIDE_FORMAT.md), and on one
  page in [docs/GUIDE_CHEATSHEET.md](docs/GUIDE_CHEATSHEET.md).
- The comments at the top of a leveling guide explain the route's choices
  (where it comes from, the flow through the zone, what it leaves out). Read
  them before moving steps around, and update them when a fix changes the
  route: a later route refresh keeps every fix they document (see
  [docs/SIMULATION.md](docs/SIMULATION.md), "Refresh").
- A fix for a player's report gets a case in `tests/guides-reported.test.js`
  (or `tests/guides-caves.test.js` for a cave mouth) that checks what the
  player sees, the goal order or where the arrow leads, not the guide's
  wording, so a refresh that undoes it fails the suite. A quest item that
  vanishes after a while is checked by lint itself (`item ... lasts ...`).
- When the guide is wrong because the data is (a giver, a spawn, a drop),
  fix the data in `tools/lib/data/corrections.json` too, so the simulator and
  the next route refresh see it. Give the entry a `source` (an in-game check
  or issue, a recording, the client, CMaNGOS, the Forever TrinityCore DB,
  QuestieDB or pfQuest; the file's `_about` lists the kinds) and a `note` in
  your own words.
- **Do not commit `addon/Polestar_Guides/Guides.lua`.** It is compiled from
  `guides/` and `data/forever`; the maintainer runs `node tools/polestar.js
  compile` (via `polestar regen`) after merge. Never hand-edit it or splice
  in a hunk from a partial compile: a spliced hunk can still be valid Lua
  while the game never sees the goals it contains.
- Check your change:

  ```sh
  node tools/polestar.js lint                        # every compile check, writes nothing
  node tools/polestar.js playtest --filter westfall  # play the matching guides to the end for every class
  node --test tests/guides-reported.test.js          # or tests/guides-caves.test.js for a cave mouth
  ```

  `--filter` plays only the guides whose file or id contains its text;
  `--class Warrior` narrows it to one class. You don't need the full test
  suite; CI runs it on your pull request.

Both need the reference data (below). If you cannot build it, send the fix
anyway: describe what you changed and why, say that you could not run the
checks, and they are run before it is merged.

## Setup

- Node 24 or newer: every command.
- Lua 5.1 or LuaJIT: `play`, `playtest`, `record import`, `travel route` and
  the addon tests.
  `$LUA` picks one when you have several.
- The reference data, `data/forever/`: quest titles, givers and coordinates,
  used by every guide command. `node tools/polestar.js data build` assembles
  it from pfQuest, Blizzard client tables and recordings, and reads QuestieDB's
  Forever store from addons installed with your game (`--no-questie` builds
  without it). `node tools/polestar.js help data` lists the options;
  [docs/PACKS.md](docs/PACKS.md) has the install commands per system.

`node tools/polestar.js doctor` checks Node, Lua, the reference data, the
AddOns folder and `pack.json`. `node tools/polestar.js help` lists every
command.

## Checks

Run only the checks for what you changed. CI runs the full suite on every
pull request and tells you if anything else broke.

| What you changed | What you run |
|---|---|
| A guide step (`.guide` file, existing guide) | `node tools/polestar.js lint` and `playtest --filter <guide>` (need reference data; say so in the PR if unavailable); for a fix to a reported bug, also `node --test tests/guides-reported.test.js` (or `tests/guides-caves.test.js` for a cave mouth) |
| A new or renamed guide file | The same lint and playtest; note in the PR that `Guides.lua` needs recompiling — the maintainer does it after merge |
| The addon's Lua (`addon/Polestar/`) | The test file(s) for the area you changed: `node --test tests/<area>.test.js`. Find it with `grep -rl <module-name> tests/*.test.js`; for example, a change to `Theme/` → `node --test tests/theme.test.js`. For a UI change, optionally run `node tools/polestar.js preview` to review the renders |
| A tool or its library (`tools/`) | That tool's tests: `node --test "tests/<tool>*.test.js"` (e.g. `node --test tests/compile.test.js`) |
| `tools/media/` (texture generators) | `node tools/polestar.js media` to see the textures locally; CI verifies the generators work |
| Player-facing English strings (`L["..."]`) | The area's tests (see addon Lua row above); translations are handled by the maintainer after merge — nothing extra from you |
| `tools/lib/data/corrections.json` | `node --test tests/data-corrections.test.js` |
| A changelog fragment in `changes/` | `node tools/polestar.js changelog check` |
| Anything else | `node --test tests/<area>.test.js` for what you touched |

A few tests skip automatically when the reference data (`data/forever`) or
Lua 5.1 is missing. [tests/README.md](tests/README.md) describes the suite;
[docs/SUITE.md](docs/SUITE.md) what is in and out of scope.

**You do not commit** `addon/Polestar_Guides/Guides.lua`, `docs/preview/*.svg`,
the locale files in `addon/Polestar*/`, or `addon/Polestar/Media/*.tga` unless
your change is to the generator itself (a texture generator in `tools/media/`,
the preview renderer in `tools/preview/`, or the compiler in `tools/lib/dsl/`).
The maintainer regenerates those after merging your PR.

## Code changes

- [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) explains how the addon and the
  tools fit together; [docs/README.md](docs/README.md) maps every document.
- Behaviour changes come with tests that show the behaviour. Run the tests
  for what you changed (see [Checks](#checks) above); CI runs the full suite
  on every PR and tells you if anything else broke.
- For UI changes, `node tools/polestar.js preview` renders the guide window,
  menu and options to `docs/preview/*.svg`. Run it to review your change
  visually; CI runs it on every PR to verify the renderer still works.
  [docs/DESIGN.md](docs/DESIGN.md) describes the visual system. The renders
  use frozen sample guides, not the shipped ones, so a guide edit never
  changes them.
- Player-facing text is a literal `L["..."]`. Adding, changing or removing
  a string does not require any extra step from you: CI checks the existing
  locale files and the maintainer runs `i18n sync` after merge to propagate
  new strings to the locale files.


## Branches

| Branch | Holds |
|---|---|
| `main` | The latest release, what players have. It moves only when a release is made. |
| `next` | The next release (the repository's default branch). Every pull request goes here. |

Every pull request goes to **`next`**: guide fixes, the addon, the tools,
the data builds, translations, new guides and route refreshes. Never to
`main`; the `Base branch` check fails those. `main` moves only when a
release is made: it is fast-forwarded to `next` and tagged. A patch release
is just a version bump (`x.y.Z`) from `next`, sooner than a feature release.
docs/RELEASING.md has the release side.

## Using an AI agent

Agents are welcome. [AGENTS.md](AGENTS.md), which most coding agents read
on their own, sends them to the skill for their task in `skills/`:
`polestar-contributing` for any change or pull request, `polestar-triage`
for checking a report, `polestar-guide-fix` for fixing a guide step and
`polestar-guide-pack` for writing a community addon. Your own agent settings and
notes stay yours: keep them out of commits. Claude Code reads AGENTS.md only
while you have no `CLAUDE.md` or `CLAUDE.local.md` of your own; if you write
one, start it with `@AGENTS.md`. The rules that matter most:

- A bug report is a lead, not a verdict, from a player or from their agent.
  Check it against the guide, the data and Forever's own sources before
  changing anything; Classic knowledge is not a source (see
  [How a report is handled](#how-a-report-is-handled)).
- Never claim a check ran when it did not, and never invent quest ids,
  coordinates or names.
- You answer for what your agent opens, pushes or posts. Read its comments
  before they go up, and say in the pull request that an agent helped — tick
  the checkbox and fill in the exact model name and version and the app or
  CLI (for example "Claude Sonnet 4.6 via Claude Code", or "GPT-4o via
  Codex"). The maintainer uses that to decide how carefully to re-verify the
  work.

### Installing the skills

Install the skills to have them in your agent outside a clone too, for
example to start on an issue. The `--sparse` paths fetch only the skills,
not the whole repository:

| Agent | Install | Update |
|---|---|---|
| Claude Code | `claude plugin marketplace add fitzforge/polestar --sparse .claude-plugin skills`, then `claude plugin install polestar@polestar` | `claude plugin update polestar@polestar` |
| Codex | `codex plugin marketplace add fitzforge/polestar --sparse .agents/plugins --sparse skills`, then `codex plugin add polestar@polestar` | `codex plugin marketplace upgrade polestar` |
| Any other (Cursor, Hermes Agent, OpenCode, Gemini CLI and more) | `npx skills add fitzforge/polestar -g` (`-a hermes-agent` for one agent) | `npx skills update` |

Run `npx skills` with `-g`: without it, it writes the skills into the folder
you are in. Start a new session after installing. An agent picks a skill when
your request matches it; to be sure, name it: "use polestar-triage on #123".

## Commits and pull requests

- Base branch: see [Branches](#branches).
- One change per commit.
- Plain messages that describe the change for the players or authors it
  affects (for example "Westfall: turn in at Sentinel Hill before the farms"), not
  how it was made.
- Behaviour changes come with tests that show the behaviour.
- Each change brings its changelog entry as a file of its own in
  `changes/` (a fragment), not an edit to CHANGELOG.md: with many pull
  requests open at once, they would all edit the same lines. The release
  assembles them into CHANGELOG.md. Write it with

  ```sh
  node tools/polestar.js changelog add players --name westfall-sentinel-hill --text "Westfall turns in at Sentinel Hill before the farms (thanks Tom)."
  ```

  (`players`, `authors` or `contributors`: the "For players", "For guide
  authors" and "For contributors" headings), or by hand as in
  [changes/README.md](changes/README.md). `changelog check` (run in CI)
  checks every fragment and `changelog show` prints them as the release will.
  A fix for a reported bug (Discord, an issue, the in-game report) credits
  the person who reported it at the end of its entry, by the name they
  reported under: "(thanks Tom)". A contribution credits its author the
  same way.

## How a pull request is reviewed

Every pull request is read for safety **before any of its code is run**:
its tests run Node tools on the maintainer's machine and Lua in the test
client, so running them is already trusting them. The diff is read in full,
generated files included, and the pull request waits while anything below is
unexplained.

- **Money and items leaving the player.** Any use of the mailbox
  (`SendMail`, `SetSendMailMoney`, `SetSendMailCOD`, items attached to a
  mail), trade (`SetTradeMoney`, `AcceptTrade`), the auction house, the guild
  bank, or buying, learning and repairing beyond what the pull request says
  it does, and any hard-coded character or realm name. The known scam is an
  addon that mails gold to someone when the mailbox opens.
- **Code that acts on its own or hides what it does.** `loadstring`,
  `RunScript` or other dynamic code, obfuscated or encoded text, addon
  messages and chat sent without the player asking, hooks on secure
  functions, slash commands that do something other than what they say.
- **The toolchain.** New dependencies or install scripts, `child_process`,
  network access to hosts the project does not already use (wago.tools),
  reading or writing outside the repository (the home folder, tokens, other
  addons' saved data), changes to `.github/workflows`.
- **Data and guides.** Executable code or links hidden in data, guide or
  locale files.

Then the change is reviewed for correctness (tests, the game's limits,
Options toggles off by default for anything that spends, equips or acts for
the player) and merged into its base branch.

**AI-assisted pull requests:** the model named in the "Model and tool" line
sets how carefully the work is re-verified. Pull requests from smaller or
unnamed models have their claims, generated files and tests re-run before
merge; pull requests that leave the line blank are treated the same way.

**Copilot's comments:** GitHub Copilot reviews each pull request into `next`
automatically, as a quick first pass. Its comments are suggestions: fix what
is right, and feel free to resolve the rest with a short reply. It knows code,
not the game, so it can't tell whether a quest, NPC or route is right. The
maintainer's review above is what decides.

## Licence

Contributions to Polestar are under GPL-3.0 ([LICENSE](LICENSE)). Community
addons written by others are separate works; see
[LICENSE-EXCEPTION.md](LICENSE-EXCEPTION.md).
