-- Gossip the guide asks for (qol.stepGossip, on by default; Shift suppresses;
-- never while the NPC has a quest to pick up or hand in: the quest
-- automation goes first). At the NPC of an open goal of the live step only:
--   * a goal with `gossip <id>` (talk, vendor, train) picks that gossip
--     option, by its id, when the window offers it;
--   * else a `buy` or `vendor` goal opens the NPC's goods, a `train` goal its
--     training, recognised by the option's icon (never its text): fileID
--     132060 (VendorGossipIcon), 132058 (TrainerGossipIcon).
-- One pick per gossip window: an option that opens another page is not
-- picked again until the window closes.

local ADDON, ns = ...
local QoL = ns.QoL

local Gossip = {}
QoL.Gossip = Gossip

local VENDOR_ICON, TRAINER_ICON = 132060, 132058
Gossip.VENDOR_ICON, Gossip.TRAINER_ICON = VENDOR_ICON, TRAINER_ICON

local SERVICE = { buy = VENDOR_ICON, vendor = VENDOR_ICON, train = TRAINER_ICON }
local picked -- the option picked in the open gossip window

local function iconOf(o)
	return o.overrideIconID or o.icon
end

-- Whether raw goal rg is at npc: its own NPC or one of its candidates.
local function atNpc(rg, npc)
	if rg.npc == npc then return true end
	for _, c in ipairs(type(rg.candidates) == "table" and rg.candidates or {}) do
		if c.npc == npc then return true end
	end
	return false
end

-- The option the live step wants picked in the open gossip, or nil.
function Gossip.Wanted(options, npc)
	local E = ns.Engine
	local live = E and E.GetLiveStep and E.GetLiveStep()
	local view = live and E.GetStepView(live)
	local g = E and E.GetGuide and E.GetGuide()
	local raw = g and g.steps and g.steps[live] and g.steps[live].goals
	if not (view and raw and npc) then return nil end
	local service
	for i, gv in ipairs(view.goals or {}) do
		local rg = raw[i] or gv
		if QoL.Open(gv) and atNpc(rg, npc) then
			if rg.gossip then
				for _, o in ipairs(options) do
					if o.gossipOptionID == rg.gossip then return o end
				end
			elseif not service and SERVICE[gv.t] then
				service = SERVICE[gv.t]
			end
		end
	end
	if service then
		for _, o in ipairs(options) do
			if iconOf(o) == service then return o end
		end
	end
	return nil
end

-- GOSSIP_SHOW (Toggles.lua: after the flight and bind helpers). True when it
-- picked an option.
function Gossip.OnGossip()
	if not QoL.On("stepGossip") or QoL.Shift() or QoL.HasQuestBusiness() then return false end
	local G = C_GossipInfo
	local options = G and G.GetOptions and G.GetOptions() or {}
	local o = Gossip.Wanted(options, ns.Compat.GetNpcID("npc"))
	if not o or picked == (o.gossipOptionID or o.orderIndex) then return false end
	picked = o.gossipOptionID or o.orderIndex
	return QoL.SelectGossip(o)
end

ns.RegisterEvent("GOSSIP_CLOSED", function() picked = nil end)
