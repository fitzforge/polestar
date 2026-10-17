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
  or [patch-candidate](https://github.com/fitzforge/polestar/labels/patch-candidate):
  small issues to start on, and confirmed guide-only fixes with the evidence
  on the issue.
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
3. **Check it against the sources.** The game's own data, Wowhead's Forever
   database, recordings. A player's memory of Classic is not a source: Forever
   changed many quests.
4. **Fix it only if it is real,** with a test that fails before the fix and
   passes after it (or, for a guide, lint and `playtest`).
5. **Credit the reporter** in the fix's changelog entry, "(thanks <name>)",
   and tell them which release carries the fix.

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
  the next route refresh see it.
- `addon/Polestar_Guides/Guides.lua` comes from
  `node tools/polestar.js compile`: commit the file it writes, never a hand
  edit or a hunk spliced in from another compile. A spliced hunk can still be
  valid Lua and load without an error while the game never sees its goals: a
  goal left between a step's `title` and its `goals = {`, or a step's goals
  left open so the next step becomes one of its goals. When your reference
  data is older or newer than the branch's, a recompile also changes guides
  you did not touch. Keep only your change by compiling the guides before and
  after it with the same local data and merging the difference into the
  committed file:

  ```sh
  tmp=$(mktemp -d)
  git archive origin/next guides | tar -x -C "$tmp"   # the guides your change starts from (origin/hotfix/<version> for a patch fix)
  node tools/polestar.js compile --guides "$tmp/guides" --out "$tmp/before"
  node tools/polestar.js compile --out "$tmp/after"
  git merge-file addon/Polestar_Guides/Guides.lua "$tmp/before/Guides.lua" "$tmp/after/Guides.lua"
  ```

  A conflict means your data differs from the branch's in the very lines
  your change touches: rebuild the data and compile, or say so in the pull
  request and leave Guides.lua to the maintainer.
- Check your change:

  ```sh
  node tools/polestar.js lint                       # every compile check, writes nothing
  node tools/polestar.js playtest --filter westfall  # play the matching guides to the end for every class
  ```

  `--filter` plays only the guides whose file or id contains its text;
  `--class Warrior` narrows it to one class.

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

## Code changes

- [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) explains how the addon and the
  tools fit together; [docs/README.md](docs/README.md) maps every document.
- Keep the suite green:

  ```sh
  npm test        # the same as: node --test "tests/**/*.test.js"
  ```

  A few tests skip when the reference data or the game client is missing.
  [tests/README.md](tests/README.md) describes the suite, and
  [docs/SUITE.md](docs/SUITE.md) what is in and out of scope. CI runs
  `npm test` on every pull request, then fails when the textures in
  `addon/Polestar/Media` differ from what `node tools/polestar.js media`
  builds: after changing `tools/media`, run it and commit the textures.
- For UI changes, `node tools/polestar.js preview` renders the guide window,
  menu and options to `docs/preview/*.svg`; look at them before and after,
  and commit them with the change: CI renders them again and fails when they
  differ. They change only with the addon's Lua, never with a guide
  recompile: the guide menu scenes load frozen copies of six compiled guides
  (`tests/fixtures/preview`). [docs/DESIGN.md](docs/DESIGN.md) describes the
  visual system.
- Player-facing text is a literal `L["..."]`. After adding, changing or
  removing texts, run `node tools/polestar.js i18n sync` and commit the
  locale files with the change ([docs/TRANSLATING.md](docs/TRANSLATING.md),
  "For developers"); CI runs `i18n check`.

## Branches

| Branch | Holds |
|---|---|
| `main` | The latest release, what players have. It moves only when a release is made. |
| `next` | The next feature release (the repository's default branch). |
| `hotfix/<version>` | The next patch release, for example `hotfix/0.2.5`: cut from the latest release's tag right after it ships, deleted once the patch is out. |

Open your pull request against:

- **`hotfix/<version>`** for a guide fix to a bug players have in the latest
  release: changes to `guides/`, the recompiled `addon/Polestar_Guides/`,
  the fix's test, `tools/lib/data/corrections.json` and its changelog
  fragment in `changes/`, nothing else. The `Base branch` check fails a
  pull request to a `hotfix/` branch that changes anything more. It has
  to work with the released addon: a fix that needs a change to the addon or
  the tools that is only on `next` goes to `next`. Write "fixes #N" in the
  description; GitHub closes issues only for pull requests merged into
  `next`, so the maintainer closes them when the patch ships.
- **`next`** for everything else: the addon, the tools, the data builds,
  translations, new guides and route refreshes. Not sure? Use `next`; a fix
  there can still go into a patch later.
- Never `main`.

After a patch ships, `main` is merged into `next`, so `next` always has
every released fix. docs/RELEASING.md has the release side.

## Using an AI agent

Agents are welcome. [AGENTS.md](AGENTS.md), which most coding agents read
on their own, sends them to the skill for their task in `skills/`:
`polestar-contributing` for any change or pull request, `polestar-triage`
for checking a report, `polestar-guide-fix` for fixing a guide step and
`polestar-guide-pack` for writing a guide pack. Your own agent settings and
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
  before they go up, and say in the pull request that an agent helped.

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
- A pull request into `next` that should also go out in the coming patch:
  ask for the `backport` label. When it merges, a pull request picking it
  onto the `hotfix/` branch opens on its own (docs/RELEASING.md).

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

## Licence

Contributions to Polestar are under GPL-3.0 ([LICENSE](LICENSE)). Guide packs
written by others are separate works; see
[LICENSE-EXCEPTION.md](LICENSE-EXCEPTION.md).
