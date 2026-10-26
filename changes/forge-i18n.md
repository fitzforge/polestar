---
section: contributors
---
- The translation tools moved to Forge: `forge i18n status`, `check`, `sync`,
  `keys`, `import`, `leaks` and `guides sync|check|stats` (docs/forge/i18n.md)
  replace `node tools/polestar.js i18n ...`, which now prints the forge
  command; CI's translation check and `npm run i18n:check` run Forge. The
  glossary and the leaks lists live in `data/i18n/`. `i18n names` and
  `i18n fit` stay on the JS tools for now.
