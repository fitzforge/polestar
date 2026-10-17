---
section: authors
---
- Guide texts can be translated (docs/TRANSLATING.md, "Guide texts"): the
  compiler writes the game's names in a guide's texts as tokens, {npc:234},
  which the game shows in each client's language, and a pack's
  locales/<locale>/ files translate the words around them, compiled into a
  load-on-demand texts addon per language, <folder>_<locale>. `i18n guides
  sync`, `check` and `stats` write, check and size them; `lint` warns about a
  stale or broken translation. Packs are now format 3 (X-Polestar-Needs
  0.2.5).
