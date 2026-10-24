---
section: contributors
---
- `npm run test:changed` runs only the test files a change can reach
  (`tools/testsel.js`: the require closure for code, the addon files a test
  loads, the paths it reads), with the reason for each; `npm test` stays the
  CI gate.
