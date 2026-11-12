-- Binding the Hearthstone at the guide's inn (qol.autoBind, off by default:
-- it binds for the player). While the current step has an open `sethome`
-- goal and the player talks to the innkeeper that goal binds at (the
-- Engine's own rule, Engine.IsSethomeInnkeeper), pick the gossip's bind
-- option and confirm the bind; nothing else. Never with Shift held, never
-- while the gossip has a quest to pick up or hand in (the quest automation
-- goes first, and the gossip shows again after it), never at an inn the
-- character is already bound at (Nav.BoundInn).
--
-- Recognising the bind option without its localized text: the binder gossip
-- icon, fileID 132052 (Interface\GossipFrame\BinderGossipIcon, in the
-- client's file list beside the taxi icon Flight.lua reads), as `icon` or
-- `overrideIconID`.
--
-- Picking it fires CONFIRM_BINDER(areaName), on which Blizzard shows the
-- StaticPopup "CONFIRM_BINDER"; its Accept calls
-- C_PlayerInteractionManager.ConfirmationInteraction(Enum.PlayerInteractionType.Binder),
-- then ClearInteraction(Binder) (Blizzard_StaticPopup_Game GameDialogDefs.lua).
-- At CONFIRM_BINDER, while the innkeeper is the step's (whether this helper
-- picked the option or the player did) and Shift was held neither at the
-- gossip nor now, this answers the same way on the next frame, as a click on
-- Accept would, and closes the popup. Answered inside the event, Forever's
-- client drops the first bind at an innkeeper: the popup goes, the
-- Hearthstone stays where it was, and only a second visit binds. "Bound your
-- Hearthstone" waits for the game's HEARTHSTONE_BOUND.

local ADDON, ns = ...
local L = ns.L
local QoL = ns.QoL
local readable = ns.Compat.Readable

local Bind = {}
QoL.Bind = Bind

local BINDER_ICON = 132052
Bind.BINDER_ICON = BINDER_ICON

-- The NPC of the last gossip seen while the setting is on, and whether Shift
-- was held then: CONFIRM_BINDER follows that gossip, and the client may have
-- closed it (no "npc" unit) by then.
local seen, held

-- The bind this helper answered, until the game says it is done:
-- { area = the confirmation's area name, at = GetTime() }.
local answered
local ANSWER_WAIT = 5

-- Whether binding at `npc` is what the current step still asks for.
function Bind.Wanted(npc)
	local E = ns.Engine
	if not (npc and E and E.IsSethomeInnkeeper) then return false end
	local Nav = ns.Nav
	local bound = Nav and Nav.BoundInn and Nav.BoundInn()
	if bound and bound.npc == npc then return false end
	local view, raw = QoL.CurrentStep()
	if not (view and raw) then return false end
	for g, gv in ipairs(view.goals or {}) do
		local goal = raw[g]
		if goal and goal.t == "sethome" and QoL.Open(gv) and E.IsSethomeInnkeeper(goal, npc) then return true end
	end
	return false
end

-- The bind option of the open gossip, or nil.
function Bind.BinderOption(options)
	for i = 1, #options do
		local o = options[i]
		if o.icon == BINDER_ICON or o.overrideIconID == BINDER_ICON then return o end
	end
	return nil
end

-- Returns true when it picked the bind option.
function Bind.OnGossip()
	if not QoL.On("autoBind") then return false end
	local npc = ns.Compat.GetNpcID and ns.Compat.GetNpcID("npc")
	seen, held = npc, QoL.Shift()
	if held or not Bind.Wanted(npc) then return false end
	local G = C_GossipInfo
	if not (G and G.GetOptions) or QoL.HasQuestBusiness() then return false end
	local opt = Bind.BinderOption(G.GetOptions() or {})
	return opt ~= nil and QoL.SelectGossip(opt)
end

function Bind.OnConfirm(_, areaName)
	if not QoL.On("autoBind") or held or QoL.Shift() then return end
	local npc = ns.Compat.GetNpcID and ns.Compat.GetNpcID("npc") or seen
	if not Bind.Wanted(npc) then return end
	local P = C_PlayerInteractionManager
	local binder = Enum and Enum.PlayerInteractionType and Enum.PlayerInteractionType.Binder
	if not (P and P.ConfirmationInteraction and binder) then return end
	areaName = readable(areaName)
	local function answer()
		-- Cancelled or walked away meanwhile (the popup's own OnUpdate test).
		if P.IsValidNPCInteraction and not P.IsValidNPCInteraction(binder) then return end
		P.ConfirmationInteraction(binder)
		if P.ClearInteraction then P.ClearInteraction(binder) end
		QoL.ClosePopup("CONFIRM_BINDER")
		answered = { area = areaName, at = GetTime() }
	end
	if C_Timer and C_Timer.After then ns.After(0, answer) else answer() end
end

function Bind.OnBound()
	local a = answered
	answered = nil
	if not (a and GetTime() - a.at <= ANSWER_WAIT) then return end
	ns.Print(a.area and string.format(L["Bound your Hearthstone to %s."], a.area) or L["Bound your Hearthstone."])
end

QoL.WhileOn("autoBind", "CONFIRM_BINDER", Bind.OnConfirm)
QoL.WhileOn("autoBind", "HEARTHSTONE_BOUND", Bind.OnBound)
