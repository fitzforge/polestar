<!-- Base branch: every pull request goes to next, never main or a hotfix branch. A guide fix players need in the coming patch gets the backport label from the maintainer after it merges. See CONTRIBUTING.md, "Branches". -->

## Issues

<!-- One line per issue this fixes: "closes #N". That lists this pull request on the issue. "See #N" is only a link. -->

- [ ] I checked for open pull requests on the same issue (`gh pr list --state open --search "<N>"`, the issue's `has-pr` label) and found none, or say here how this one differs:

## What and why

<!-- What changes for the player or author, and why. -->

## The report, checked

<!-- For a bug fix: the verdict (confirmed / partly right) and the evidence: guide file and step, quest id, data, Wowhead Forever, a recording. A report is a lead, not a verdict. -->

## Checks

- [ ] I ran the tests for what I changed — `node --test tests/<file>.test.js`; for a guide change, also `node tools/polestar.js lint` and `playtest --filter <guide>` (if I could not run them, I've said so above)
- [ ] A changelog fragment in `changes/` (`node tools/polestar.js changelog add`), crediting the reporter
- [ ] An AI agent wrote or helped with this — **Model and tool:**

## Maintainer review

<!-- Safety read of the full diff before running any code (CONTRIBUTING.md, "How a pull request is reviewed"), pattern sweep across guides, release scope. -->
