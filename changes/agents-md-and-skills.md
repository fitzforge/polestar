---
section: contributors
---
- AGENTS.md points coding agents to skills that carry the project's rules,
  chief among them that a bug report is a lead to check against the guide,
  the data and Forever's sources, never a verdict:
  `skills/polestar-contributing/` (branches,
  changelog fragments, what a pull request must not do),
  `skills/polestar-triage/` checks a report and drafts the verdict, the
  labels and the reply, and `skills/polestar-guide-fix/` takes a confirmed
  wrong step to a pull request on the right branch. CONTRIBUTING.md, "Using
  an AI agent", and a pull request template say the same to the people
  running them. Claude Code reads AGENTS.md on its own; a personal
  `CLAUDE.md` or `CLAUDE.local.md` stays out of git and starts with
  `@AGENTS.md` so the rules still load.
- The four skills install outside a clone too: as a Claude Code plugin
  (`claude plugin marketplace add fitzforge/polestar`), a Codex plugin
  (`codex plugin marketplace add fitzforge/polestar`), or with
  `npx skills add fitzforge/polestar` for any other agent (Cursor, Hermes
  Agent, OpenCode and more). CONTRIBUTING.md, "Installing the skills", has
  the commands.
- Issues waiting on the reporter carry `needs-info` and close on their own
  after three weeks without a reply; `confirmed` and `patch-candidate` mark
  checked bugs. The "Wrong step" form asks for the other addons in use.
  SECURITY.md says how to report a security problem privately, and
  CODEOWNERS names who reviews what.
