---
section: contributors
---
- The Release data check skips draft pull requests (it starts when a draft
  is marked ready) and a newer push cancels its older run; the post-merge
  gates have a runner of their own, so they never wait behind pull
  requests (#3310).
