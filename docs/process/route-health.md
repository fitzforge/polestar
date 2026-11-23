# Route health: recurrence from players' recordings

Generated from players' in-game recordings (Polestar Recorder uploads) for each triage round, as #3654 asks: per release and guide step, the share of people who got stuck on a step, skipped it or abandoned a quest on it, against the release before, and every closed issue whose step climbs again. The triage round reads this page first.

How it is counted: a person is one player (characters and installs that belong together count once); excluded and suspect contributors are left out. A step is the guide's step by title, so a step keeps its row when a release renumbers the guide. **Stuck**: 20 minutes or more on the step (AFK time left out) and never left by the step completing or by Next. **Skipped**: left with Skip. **Abandoned**: a quest abandoned while on the step. A rate is people with that outcome out of the people who reached the step.

Recordings to 2026-11-20 (0.4.2 and later reach this page with the next recordings pull). Releases with recordings: 0.3.0, 0.3.1, 0.3.2, 0.3.3, 0.3.4, 0.3.5, 0.3.6, 0.3.7, 0.3.7.1, 0.3.7.2, 0.4.0, 0.4.0.1, 0.4.1, 0.4.1.1. People per release: 0.3.0 4, 0.3.1 101, 0.3.2 137, 0.3.3 66, 0.3.4 174, 0.3.5 240, 0.3.6 240, 0.3.7 224, 0.3.7.1 54, 0.3.7.2 404, 0.4.0 159, 0.4.0.1 291, 0.4.1 235, 0.4.1.1 338.

## Steps that got worse than the release before

The last 3 releases against the one before each: both with at least 10 people on the step, a rate up by 15 points or more, and at least 3 people with that outcome.

| release | before | guide | step | people | stuck | skipped | abandoned |
|---|---|---|---|---|---|---|---|
| none | | | | | | | |

## Steps where 0.4.1.1 loses the most people

Steps with at least 10 people in 0.4.1.1, by the share stuck or skipping (at least 3 people), worst first.

| guide | step | people | stuck | skipped | abandoned |
|---|---|---|---|---|---|
| forever/horde/03-silverpine-forest | The Sepulcher#2 | 12 | 0% | 58% | 0% |
| forever/alliance/03-loch-modan | Lakeridge Highway: kill these as you meet them | 12 | 17% | 17% | 0% |
| forever/alliance/50-60/03-winterspring | Everlook | 10 | 0% | 30% | 0% |
| forever/alliance/06-ashenvale | Kerlonian Evershade | 16 | 6% | 19% | 31% |
| forever/alliance/06-ashenvale | Piznik | 12 | 8% | 25% | 8% |
| forever/horde/03-silverpine-forest | The Sepulcher | 12 | 8% | 17% | 8% |

## Fixed issues whose step climbs again

An issue closed as fixed is pinned to the guide step its report names. It is fixed in the first release tagged after it was closed; the baseline is the first release from then with at least 3 people on the step. It is back when a later release has at least 5 people on the step and a stuck or skip rate 15 points or more above the baseline's, with at least 2 people stuck or skipping.

| issue | step | fixed in | back in | people | stuck | skipped |
|---|---|---|---|---|---|---|
| #2404 | forever/alliance/06-ashenvale: Piznik | 0.4.1 | 0.4.1.1 | 12 | 8% (was 0% in 0.4.1) | 25% (was 0%) |
| #1924 | forever/horde/04-the-barrens: Gann Stonespire | 0.4.0 | 0.4.1.1 | 8 | 0% (was 25% in 0.4.0.1) | 25% (was 0%) |
| #1458 | forever/alliance/30-40/02-desolace: Kodo Graveyard | 0.3.7 | 0.3.7.2 | 13 | 0% (was 0% in 0.3.7) | 15% (was 0%) |
| #1370 | forever/alliance/06-ashenvale: Piznik | 0.3.6 | 0.3.7 | 6 | 17% (was 0% in 0.3.6) | 33% (was 17%) |
| #1341 | forever/alliance/nightelf/01-teldrassil: Ban'ethil Barrow Den | 0.4.0 | 0.4.1.1 | 7 | 29% (was 0% in 0.4.0.1) | 0% (was 25%) |

Closed issues pinned to a step and released since: 363; back: 5.
