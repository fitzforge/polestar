---
section: contributors
---
- Pull request checks no longer fail on a timing budget. On GitHub's shared
  runners the tests that time the settings window, the recorder, tooltips and
  route plans only warn when a figure is over budget; everything else they
  check still fails. The release gate enforces the budgets on a quiet machine
  (`rust/scripts/timing-budgets.sh`, docs/RELEASING.md step 3).
