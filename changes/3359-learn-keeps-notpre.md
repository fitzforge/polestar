---
section: forge
---
- `forge record learn` run on data a build already corrected keeps the
  `notPre` facts that build applied: the last snapshot's prerequisites it
  took out are judged again on the recordings instead of dropping out, so
  the next data build no longer puts them back (#3359).
