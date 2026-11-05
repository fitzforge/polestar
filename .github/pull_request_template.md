<!-- Base branch: every pull request goes to next, never main. See CONTRIBUTING.md, "Branches". -->

## Issues

<!-- One line per issue this fixes: "closes #N". That lists this pull request on the issue. "See #N" is only a link. -->

- [ ] I checked for open pull requests on the same issue (`gh pr list --state open --search "<N>"`, the issue's `has-pr` label) and found none, or say here how this one differs:

## What and why

<!-- What changes for the player or author, and why. -->

## The report, checked

<!-- For a bug fix: the verdict (confirmed / partly right) and the evidence: guide file and step, quest id, data, Forever's quest data, a recording. A report is a lead, not a verdict. -->

## Checks

<!-- Run only what you changed; see CONTRIBUTING.md "Checks" for the table. -->

- [ ] I ran the tests for what I changed (`node --test tests/<area>.test.js`; guide changes: also `lint` and `playtest --filter <guide>`)
- [ ] Not run, and why:
- [ ] A changelog fragment in `changes/` (`forge changelog add`), crediting the reporter
- [ ] An AI agent wrote or helped with this — **Model and tool:** ____

## Maintainer review

<!-- Safety read of the full diff before running any code (CONTRIBUTING.md, "How a pull request is reviewed"), pattern sweep, release scope. -->
