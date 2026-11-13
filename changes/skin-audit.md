---
section: contributors
---
- The preview harness's overlap check leaves out text that a scroll area
  has scrolled out of view.
- Every bundled look is checked on every surface at UI scales 0.64, 1 and
  1.5 (`tests/skin-audit.test.js`; `node tools/preview/audit.js [look ...]
  [--surface key,...]` lists the findings): the guide window with each card
  over it, its banners, menu, compact and transparent modes, the toasts,
  the dialogs, the picker and the settings window's pages, each look saved
  before login as a player's is. It reports a control another frame
  covers, text that overlaps other text or crosses its window, text under
  3:1 against its ground, a close drawn larger than the look's own, a big
  window's frame on the guide window or a toast, and Lua errors. A probe
  for each check proves it still fires; the breakages known today are
  listed in the test, each with its owner.
