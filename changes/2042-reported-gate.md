---
section: contributors
---
- `npm run test:reported` runs the reported-problems gate: for every
  confirmed player report that was fixed, the tests that fail if the problem
  comes back (listed per report in `tests/reported-gate.json`), with the whole
  of `tests/guides-reported.test.js`, the judge's player-report seeds on the
  shipped guides and the danger gate on the release candidate's level model,
  and it names the reports whose tests fail. Eight reports that had no check
  of their own now have one: walking quest givers' tips, a camp that pulls
  together, Danitha Morr back upstairs in Tyr's Watch, item uses bound to the
  quest that collects what they make, Sentinel Selarin's respawn, and Heart of
  Disruption's lead-in quests (#227, #504, #874, #875, #910, #1089, #1235,
  #1250). Four of the judge's seeds still asserted what later fixes undid, so
  they passed a written route that brought the old problem back; they now
  check what the guides do today: Alba Fairmoon's chain for Humans (#144),
  Alonso's Dragonslayer quests left out (#1117), no Bronze Tube from Herble
  (#1792) and the Talondeep way into Stonetalon (#563, #1813) (#2042).
