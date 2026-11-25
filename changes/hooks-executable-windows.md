---
section: contributors
---
- The public-text tests pass on Windows: there they read whether the
  commit-msg and pre-push hooks are executable from the mode git stores for
  them, which is what a clone gets, as Windows file modes carry no execute
  bit (thanks AbaddonAbatu).
