# Changelog fragments

Each change's changelog entry is its own file here, so pull requests never
edit the same lines of CHANGELOG.md. A release gathers them into
CHANGELOG.md under its version and deletes them.

A fragment, `changes/<slug>.md`, names its section in front matter
(`players`, `authors`, `contributors` or `forge`, for "For players", "For
guide authors", "For contributors" and "Forge", the Rust route tool), then
gives the entry as CHANGELOG.md
writes it: a list item, wrapped at 78 columns.

```markdown
---
section: players
---
- Ticking a quest's accept off without taking the quest no longer sends you
  to farm for it.
```

```sh
forge changelog add players --text "..."  # write one
forge changelog check                     # validate them
forge changelog show                      # the next release's entries
forge changelog build 0.2.5               # at release only
```
