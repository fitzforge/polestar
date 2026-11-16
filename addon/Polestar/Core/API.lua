-- Polestar.API: what other addons may build on (docs/API.md). Every call that
-- doc lists keeps its arguments, returns and messages while API.version stays
-- the same; a release that changes one in a way that breaks a caller raises
-- the version by one. The calls it lists outside this table keep their places
-- (Polestar.Lookup.RegisterPlanner, Polestar.RegisterGuide, ...), and the
-- test that pins them all is forge-addontest's api.rs.
--
--   API.version -> 1
--   API.ReplaceSteps(guideId, steps) -> true | false, reason
--       a registered guide takes `steps` in place and for the session: same
--       id, same tab, the player's place, done steps and skips kept
--       (Engine.ReplaceSteps). Refused from inside a Polestar message
--       handler ("busy"): the GUIDE_CHANGED it fires would call it again.

local ADDON, ns = ...

local API = { version = 1 }
ns.API = API

function API.ReplaceSteps(guideId, steps)
	if ns.Dispatching() then return false, "busy" end
	return ns.Engine.ReplaceSteps(guideId, steps)
end
