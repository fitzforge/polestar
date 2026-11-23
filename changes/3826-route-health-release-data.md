---
section: contributors
---
- The weekly route-health run plays the last release's guides on the data
  that release shipped with (`polestar flow-diff --base-data`, the runner's
  `releases/<tag>/` folder: RELEASING.md step 11), so quests the newer data
  dropped no longer stop the flow check; when the check cannot run, the
  summary says so instead of "no flow diff" (#3826).
