# Polestar: for coding agents

Polestar is a leveling guide addon for WoW: Forever: a Lua 5.1 addon in
`addon/`, guides in `guides/`, Node tools in `tools/`
(`node tools/polestar.js help`) and Polestar Forge, the Rust route builder
in `rust/` (`forge --help`, docs/FORGE.md). Before you work here, read the
skill for your task:

| Task | Skill |
|---|---|
| Any change, commit, pull request or issue comment | [skills/polestar-contributing/SKILL.md](skills/polestar-contributing/SKILL.md) |
| Looking at, triaging or answering a bug report | [skills/polestar-triage/SKILL.md](skills/polestar-triage/SKILL.md) |
| Fixing a step, route, giver or coordinate in `guides/`, or the data behind it | [skills/polestar-guide-fix/SKILL.md](skills/polestar-guide-fix/SKILL.md) (step 3 says whether the guide is generated and which record takes the fix) |
| Addon behaviour (reminders, map pins, the arrow's logic) | polestar-contributing; a Lua fix with its test, not touched by Forge |
| Dungeon and lookup entries (entrances, pick-ups) | polestar-contributing; the data is in `tools/lib/codex/` |
| Writing a separate community addon (guide pack) | [skills/polestar-guide-pack/SKILL.md](skills/polestar-guide-pack/SKILL.md) |

The rules that hold for every task:

- A bug report is a lead, not a verdict. Check it against the guide, the
  data and Forever's own sources before agreeing it is a bug.
- Before fixing an issue, check that no open pull request already does
  (`gh pr list --state open --search "<N>"`, the issue's `has-pr` label).
  Help on that one instead of opening a second, and link every issue yours
  fixes ("closes #N").
- Pull requests always go to `next`, never to `main`.
- Never claim a check passed that you did not run, and never invent quest
  ids, coordinates or names.
- A human reads every comment before it is posted.
- When you open a pull request, tick the AI-agent checkbox in the template
  and fill in "Model and tool: <model name and version> via <app or CLI>"
  (for example "Claude Sonnet 4.6 via Claude Code"). List every model that
  helped if more than one did. Leaving it blank causes the work to be
  re-verified as if the model is unknown.

Claude Code reads this file only while there is no `CLAUDE.md`,
`.claude/CLAUDE.md` or `CLAUDE.local.md` in the repository or a folder above
it. If you write one of those for yourself, put `@AGENTS.md` on its first
line so these rules still load, and keep it out of commits (`.gitignore`
already does).

CONTRIBUTING.md is the long form for people.
