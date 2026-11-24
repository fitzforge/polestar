---
section: contributors
---
- The release gates' pin coverage guard no longer asks the coming release to
  pin a report closed as already fixed: an issue labelled `released:<tag>`
  for a release already out counts as that release's fix. A report of
  something an earlier release fixed is closed with that release's label
  (CONTRIBUTING.md, "How a report is handled") (#3625).
