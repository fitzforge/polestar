-- Marks on the client's talent frame (PlayerSpellsFrame.TalentsFrame, from
-- Blizzard_PlayerSpells): a ring on the plan's next talent whenever a point
-- is unspent, the pick number of each talent's next planned rank (an order,
-- not a level: points can come earlier than one a level), a flag on ranks
-- the plan does not spend, and a line in the talent's tooltip. Nothing is
-- muted as "not yet": if the game has given a point, the next pick takes it. Post-hooks only (EventRegistry callbacks, HookScript):
-- nothing Blizzard's frame does is replaced, so its secure paths stay clean.
--
-- Nothing is drawn while inspecting someone, for a loadout the frame shows
-- that is not the active one, or with a plan out of date (Talents.lua,
-- T.Validate). In combat a redraw waits for PLAYER_REGEN_ENABLED.

local ADDON, ns = ...
local T, Theme, W = ns.Talents, ns.Theme, ns.Widgets
local L = ns.L
local pairs, format, tostring = pairs, string.format, tostring

if not (T and Theme and W) then return end

local O = {}
local RING_OUT = 5 -- the ring past the mark's edge; the badge pokes out 2
T.Overlay = O

local marks = {} -- button -> mark frame
local hooked = setmetatable({}, { __mode = "k" }) -- buttons with our OnEnter
local attached, pending = false, false
O.marks = marks

local function frame()
	local p = PlayerSpellsFrame
	return p and p.TalentsFrame
end

local function edge(m, a, b, horizontal)
	local t = m:CreateTexture(nil, "OVERLAY")
	t:SetTexture(Theme.Media("white"))
	t:SetPoint(a, m, a, 0, 0)
	t:SetPoint(b, m, b, 0, 0)
	if horizontal then t:SetHeight(2) else t:SetWidth(2) end
	W.Color(t, "accent")
	return t
end

local function mark(button)
	local m = marks[button]
	if m then return m end
	m = ns.CreateFrameUnder("Frame", nil, button)
	m:SetPoint("TOPLEFT", button, "TOPLEFT", -3, 3)
	m:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 3, -3)
	m:SetFrameLevel(button:GetFrameLevel() + 5)
	m.Ring = ns.CreateFrameUnder("Frame", nil, m)
	-- Wider than the mark, so the top-right badge sits inside it.
	m.Ring:SetPoint("TOPLEFT", m, "TOPLEFT", -RING_OUT, RING_OUT)
	m.Ring:SetPoint("BOTTOMRIGHT", m, "BOTTOMRIGHT", RING_OUT, -RING_OUT)
	m.Ring.edges = {
		edge(m.Ring, "TOPLEFT", "TOPRIGHT", true), edge(m.Ring, "BOTTOMLEFT", "BOTTOMRIGHT", true),
		edge(m.Ring, "TOPLEFT", "BOTTOMLEFT"), edge(m.Ring, "TOPRIGHT", "BOTTOMRIGHT"),
	}
	m.Badge = ns.CreateFrameUnder("Frame", nil, m)
	m.Badge:SetSize(20, 14)
	-- Top right: Blizzard's rank count sits bottom right, our off-plan flag top left.
	m.Badge:SetPoint("TOPRIGHT", m, "TOPRIGHT", 2, 2)
	m.Badge.Bg = W.Fill(m.Badge, "shade")
	m.Badge.Text = W.Text(m.Badge, "caption", "text")
	m.Badge.Text:SetPoint("CENTER", m.Badge, "CENTER", 0, 0)
	m.Flag = m:CreateTexture(nil, "OVERLAY")
	m.Flag:SetTexture(Theme.Media("white"))
	m.Flag:SetSize(8, 8)
	m.Flag:SetPoint("TOPLEFT", m, "TOPLEFT", 0, 0)
	W.Color(m.Flag, "danger")
	marks[button] = m
	return m
end

local function hideAll()
	for _, m in pairs(marks) do m:Hide() end
end

-- What the plan says about a live node: (pick | nil), off-plan ranks, next.
local function planFor(c, liveID)
	local id = c.valid.back[liveID]
	if not id then return nil end
	local s = c.staged
	return id, s.nodeNext[id], s.offPlan[id], s.next and s.next.node == id
end

-- Whether the frame shows the player's own active loadout.
local function ownActive(f, c)
	if f.IsInspecting and f:IsInspecting() then return false end
	local id = f.GetConfigID and f:GetConfigID()
	return id == nil or id == c.live.config
end

local onEnter

function O.Draw()
	local f = frame()
	if not f then return end
	-- In combat the frame may show someone else or another loadout: take
	-- the marks down now and draw again once combat ends.
	if T.Client.InCombat() then
		pending = true
		return hideAll()
	end
	pending = false
	local c = T.Current()
	if not (c and c.staged and T.Get("overlay") and f:IsShown() and ownActive(f, c)) then return hideAll() end
	if not f.EnumerateAllTalentButtons then return hideAll() end
	local seen = {}
	for button in f:EnumerateAllTalentButtons() do
		local liveID = button.GetNodeID and button:GetNodeID()
		local id, pick, off, isNext = planFor(c, liveID)
		-- No tooltip line with the gamepad interface (ns.GamepadUI): its
		-- navigation runs a button's OnEnter from its own code as it moves.
		if not hooked[button] and button.HookScript and not ns.GamepadUI() then
			button:HookScript("OnEnter", onEnter)
			hooked[button] = true
		end
		if id and (pick or off) then
			local m = mark(button)
			seen[m] = true
			m.Ring:SetShown(isNext == true and c.staged.unspent > 0)
			local badge = pick and T.Get("badges")
			m.Badge:SetShown(badge and true or false)
			if badge then
				m.Badge.Text:SetText(tostring(pick.order))
				W.Color(m.Badge.Text, isNext and "accent" or "text")
			end
			m.Flag:SetShown(off ~= nil)
			m.psNode = id
			m:Show()
		end
	end
	for _, m in pairs(marks) do if not seen[m] then m:Hide() end end
end

-- Coalesced: the frame fires several callbacks per change.
local queued = false
function O.Queue()
	if queued then return end
	queued = true
	local function run()
		queued = false
		O.Draw()
	end
	if C_Timer and C_Timer.After then C_Timer.After(0, run) else run() end
end

-- The tooltip line, below Blizzard's.
function O.TooltipLine(liveID)
	local c = T.Current()
	if not (c and c.staged) then return nil end
	local id, pick, off, isNext = planFor(c, liveID)
	if not id then return nil end
	local spec = c.build.specName
	if off then return format(L["Polestar: not in your %s plan"], spec), "danger" end
	if not pick then return format(L["Polestar: done for your %s plan"], spec), "textMuted" end
	local n = c.data.nodes[id]
	local text = format(L["Polestar: pick #%d, rank %d/%d (%s plan)"], pick.order, pick.rank, n.max, spec)
	if isNext then return text .. "  " .. L["next"], "accent" end
	return text, "text"
end

onEnter = function(button)
	if not T.Get("tooltip") or not GameTooltip or GameTooltip:GetOwner() ~= button then return end
	local f = frame()
	local c = T.Current()
	if not (f and c and c.staged and ownActive(f, c)) then return end
	local text, color = O.TooltipLine(button.GetNodeID and button:GetNodeID())
	if not text then return end
	local r, g, b = Theme.Color(color)
	GameTooltip:AddLine(text, r, g, b, true)
	GameTooltip:Show()
end
O.OnEnter = onEnter

function O.Attach()
	local f = frame()
	if attached or not f then return attached end
	attached = true
	f:HookScript("OnShow", O.Queue)
	if EventRegistry and EventRegistry.RegisterCallback then
		EventRegistry:RegisterCallback("TalentFrameBase.ButtonsUpdated", O.Queue, O)
		EventRegistry:RegisterCallback("TalentFrameBase.ConfigUpdated", O.Queue, O)
	end
	O.Queue()
	return true
end

ns.On("TALENTS_UPDATED", function() if attached then O.Queue() end end)
ns.RegisterEvent("PLAYER_REGEN_ENABLED", function() if pending then O.Queue() end end)
ns.RegisterEvent("ADDON_LOADED", function(_, name) if name == "Blizzard_PlayerSpells" then O.Attach() end end)
ns.OnLogin(O.Attach)
