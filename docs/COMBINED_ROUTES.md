# Combined routes

Combined routing is optional. Open a leveling guide and choose **Use as main
guide** from its tab's right-click menu or the guide window's menu. Open the
other guides you want to follow, then choose **Add to combined route** on
their tabs. The existing limit of six open guides still applies.

The guide window lists objectives in combined order. Each line names its
source guide (or guides when the same quest objective occurs in several).
The current destination leads the arrow; upcoming and deferred work stays
visible. A deferred line explains why it is not being routed to now.

## Navigation and control

- The leveling guide's stops retain their order. Eligible companion work is
  inserted before the next stop when the estimated additional travel fits.
- The default added-travel budget is five minutes between main-guide stops.
  The menu offers 0, 2, 5, 10 and 30 minutes. These are travel estimates,
  not promises about combat, gathering, queues or quest duration.
- Merely browsing another tab does not change the route. Clicking an
  objective or setting a manual waypoint pauses weaving. Choose **Resume
  combined route** to resume from current progress.
- Escorts, timed quests and dungeon entries require an explicit choice.
  Click their deferred objective to confirm or choose **Not now**. Resuming
  the combined route permits asking about deferred activities again.
- A started escort or confirmed timed chain takes priority until its live
  quest state releases it. Repeating profession activities remain optional;
  they do not keep the leveling route in a farming loop.
- **Remove from combined route** leaves the guide open with its progress.
  **Disable combined route** restores ordinary tab navigation.

Selection, budget, spent detour allowance and pause state are saved per
character. Commitment confirmations are session-only; removing a quest clears
its confirmation, and leaving an instance clears dungeon confirmations.
Closing the main guide disables the combined route. Normal chapter handoffs
transfer its role to the next chapter.

## Runtime contract

`Core/CombinedRoute.lua` orders snapshots; the Engine remains the only
owner of completion and manual progress. No synthetic guide is registered.

`Engine.CombinedSnapshot()` returns a bounded view of the open, selected
guides. References contain `guideId`, `step`, `goal` and the raw goal's
identity. `ResolveObjective` rejects references to closed or replaced goals.
The main guide is inspected first, followed by companions in tab order.
Each guide is bounded to eight steps, stops at its next zone/travel boundary,
and receives a share of a 64-objective total limit.

Within a source guide, the current group retains authored order. Later
quest work is eligible only when the existing early-work checks permit it.
Later pickups remain on their authored steps, including sequence-sensitive
pickups. Level, prerequisite, group, manual-skip and lost-quest checks apply.

`CombinedRoute.Build` is a deterministic insertion planner. The main
objective is the anchor. It compares travel to a companion and back to the
anchor with the direct trip, charging the cumulative added travel. Unknown
estimates defer work. At most five insertions are selected per pass. A
selected destination remains preferred until it is done or invalid.

Runtime estimates use the existing budgeted travel API without hypothetical
Hearthstone reuse. The planner yields between calls and retries `busy`
answers; a changed generation discards the unfinished plan. Progress events
invalidate snapshots, and a five-second poll refreshes position-dependent
costs. Reserved detour costs survive replanning until the main anchor changes.

`Engine.CombinedAction` resolves the source for row actions. The authoritative
waypoint carries that reference for map regions and spawn cycling.
`Engine.NavigationStep` supplies the selected goal to item and target
controls. Combined quest automation permits only eligible planned work;
unselected background tabs cannot bypass commitment gates.

## Validation

Run `node --test tests/combined-route.test.js` with Lua 5.1 or LuaJIT. This
uses the real Engine, and additionally the real UI and navigation manifests
for integration cases. It covers independent progress, manual control,
shared objectives, travel budgets, commitments, stale references, deferred
class quests, save restoration and six-guide bounds.

Also run the existing Engine tab, Dynamic Questing, automation, navigation,
guide-window and transparent-layout tests. In-game acceptance should cover
leveling with a class chain, then dungeon preparation and a confirmed run.
The automated test client cannot establish live-server travel correctness
or secure UI behavior in the game.
