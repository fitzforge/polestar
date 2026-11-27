-- Polestar Group Finder: the party box, a small floating window for a group
-- formed through the finder.
--
-- Like a quest tracker: the group's quests with your progress and the
-- objectives left. Two moments (Leave.lua fires them):
--   * hello, when the group forms: Say hello (or its key binding) says the
--     hello message (Messages.lua, with the quest links and your progress)
--     in the party, for HELLO_TIME seconds; then the box goes and the chance
--     is gone. The time left drains the button's accent fill; the pointer on
--     the box holds it. Nothing is ever said without the click or the key.
--   * goodbye, when the group's quests are all done: Say goodbye (the
--     goodbye message, then leave the group) for GOODBYE_TIME seconds; then
--     the box goes and you stay. Stay closes it at once.
-- Both have a key binding. The option `partyBox` turns the box off; an empty
-- hello message skips the hello moment.

local _, ns = ...
local L = ns.L
local W = ns.Widgets

local PartyBox = {}
ns.PartyBox = PartyBox

local WIDTH, PAD = 260, 10
local HELLO_TIME = 5
local GOODBYE_TIME = 30
local HELLO_AGAIN = 60     -- seconds before another hello may be offered
local MAX_QUESTS, MAX_OBJECTIVES = 3, 3

local box, mode, remaining, total
local lastHello = -math.huge
local lines = {}

local function line(i)
	local fs = lines[i]
	if not fs then
		fs = W.Text(box, "small", GameFontHighlightSmall)
		fs:SetJustifyH("LEFT")
		fs:SetWidth(WIDTH - 2 * PAD)
		fs:SetWordWrap(false)
		lines[i] = fs
	end
	return fs
end

-- The group's quests, each with its progress and the objectives left.
local function questLines()
	local out = {}
	local log = ns.Quests.Log()
	for i, id in ipairs(ns.Leave.Quests()) do
		if i > MAX_QUESTS then break end
		local pct = ns.Quests.Progress(id)
		local state = pct and (pct >= 100 and L["done"] or (pct .. "%")) or ""
		out[#out + 1] = "|cffffd100" .. ns.Quests.Title(id) .. "|r  " .. W.Dim() .. state .. "|r"
		local n = 0
		for _, o in ipairs(log[id] and log[id].objectives or {}) do
			if not o.done and o.text and n < MAX_OBJECTIVES then
				n = n + 1
				out[#out + 1] = "   " .. W.Soft() .. ns.Messages.ObjectiveText(o) .. "|r"
			end
		end
	end
	return out
end

-- "polestar" (the group's quests and objectives) or "compact" (the line
-- that will be said, then the buttons).
function PartyBox.Style()
	return ns.Get("partyBoxStyle") == "compact" and "compact" or "polestar"
end

function PartyBox.Refresh()
	if not (box and box:IsShown()) then return end
	local hello = mode == "hello"
	local compact = PartyBox.Style() == "compact"
	box.title:SetText(hello and L["Group formed"] or L["Quests done"])
	local y = 32
	local qs = compact and {} or questLines()
	for i, text in ipairs(qs) do
		local fs = line(i)
		fs:SetText(text)
		fs:ClearAllPoints()
		fs:SetPoint("TOPLEFT", box, "TOPLEFT", PAD, -y)
		fs:Show()
		y = y + 14
	end
	for i = #qs + 1, #lines do lines[i]:Hide() end
	-- What will be said (one line in compact), then the buttons.
	local kind = hello and "hello" or "goodbye"
	local speaks = ns.Messages.On(kind)
	local said = speaks and ns.Messages.Expand(kind, ns.Leave.Quests()) or L["(not sent)"]
	box.preview:SetWordWrap(not compact)
	box.preview:SetText(W.Dim() .. "\226\128\156" .. said .. "\226\128\157|r")
	box.preview:ClearAllPoints()
	box.preview:SetPoint("TOPLEFT", box, "TOPLEFT", PAD, -(y + (compact and 0 or 4)))
	y = y + (compact and 0 or 4) + (compact and 14 or math.max(14, box.preview:GetStringHeight() or 14)) + 8
	local label = hello and L["Say hello"] or (speaks and L["Goodbye & leave"] or L["Leave the group"])
	box.main:SetText(label)
	PartyBox.Drain()
	box.other:SetText(hello and L["Not now"] or L["Stay"])
	box.main:ClearAllPoints()
	box.main:SetPoint("TOPLEFT", box, "TOPLEFT", PAD, -y)
	box:SetHeight(y + 22 + PAD)
end

local function close()
	mode, remaining, total = nil, nil, nil
	if box then box:Hide() end
end

local function build()
	local pos = ns.Get("partyBoxPos")
	box = W.Window("PSGroupFinderPartyBox", { width = WIDTH, height = 120, strata = "MEDIUM", movable = true,
		onMoved = function(f)
			local point, _, _, x, y = f:GetPoint(1)
			ns.Set("partyBoxPos", { point, x, y })
		end })
	if type(pos) == "table" then
		box:SetPoint(pos[1] or "TOP", UIParent, pos[1] or "TOP", pos[2] or 0, pos[3] or 0)
	else
		box:SetPoint("TOP", UIParent, "TOP", 0, -140)
	end
	box.title = W.Title(box, L["Group formed"])
	W.CloseButton(box, function() PartyBox.Other() end)
	box.preview = W.Text(box, "small", GameFontHighlightSmall)
	box.preview:SetJustifyH("LEFT")
	box.preview:SetWidth(WIDTH - 2 * PAD)
	box.main = W.Button(box, L["Say hello"], 160, function() PartyBox.Main() end, 22)
	-- The time left: the button's accent fill drains from right to left.
	box.fill = box.main:CreateTexture(nil, "ARTWORK", nil, -8)
	box.fill:SetPoint("TOPLEFT", box.main, "TOPLEFT", 1, -1)
	box.fill:SetPoint("BOTTOMLEFT", box.main, "BOTTOMLEFT", 1, 1)
	if box.fill.SetColorTexture then box.fill:SetColorTexture(0.9, 0.73, 0.4, 0.45) end
	local T = W.Theme()
	if T and T.Color then pcall(T.Color, box.fill, "accent", 0.45) end
	box.other = W.Button(box, L["Not now"], WIDTH - 2 * PAD - 166, function() PartyBox.Other() end, 22)
	box.other:SetPoint("LEFT", box.main, "RIGHT", 6, 0)
	local tick = 0
	box:SetScript("OnUpdate", function(_, dt)
		if not remaining then return end
		-- The pointer on the box holds the time: a last-moment click still lands.
		if box.IsMouseOver and box:IsMouseOver() then return end
		remaining = remaining - dt
		tick = tick + dt
		if remaining <= 0 then
			PartyBox.Other()
		else
			PartyBox.Drain()
			if tick >= 0.5 then
				tick = 0
				PartyBox.Refresh()
			end
		end
	end)
	box:Hide()
end

local function show(m, seconds)
	if not box then build() end
	mode, remaining, total = m, seconds, seconds
	box:Show()
	PartyBox.Refresh()
end

function PartyBox.ShowHello()
	if not (ns.Get("enabled") and ns.Get("partyBox") and ns.Messages.On("hello")) then return end
	if ns.Now() - lastHello < HELLO_AGAIN then return end
	lastHello = ns.Now()
	show("hello", HELLO_TIME)
end

function PartyBox.ShowGoodbye()
	if not (ns.Get("enabled") and ns.Get("partyBox")) then return end
	show("goodbye", GOODBYE_TIME)
end

-- Say hello now / say goodbye and leave.
function PartyBox.Main()
	local m = mode
	close()
	if m == "hello" then
		ns.Messages.SayParty("hello", ns.Leave.Quests())
	elseif m == "goodbye" then
		ns.Leave.Do()
	end
end

-- Cancel the hello / stay in the group.
function PartyBox.Other()
	local m = mode
	close()
	if m == "goodbye" then ns.Leave.Stay() end
end

function PartyBox.Mode() return box and box:IsShown() and mode or nil end
function PartyBox.Remaining() return remaining end
-- Offer hello again at once (nil), or not for a minute (now): the tests.
function PartyBox.ResetHello(at) lastHello = at or -math.huge end

-- The accent fill of the main button, as wide as the time left.
function PartyBox.Drain()
	if not (box and box.fill and remaining and total and total > 0) then return end
	local w = (box.main:GetWidth() or 160) - 2
	box.fill:SetWidth(math.max(0.01, w * math.max(0, remaining) / total))
end
-- Tests: the frame, to drive its countdown.
function PartyBox.Frame() return box end

-- Key bindings. Say hello works only while the box offers it.
function ns.Hello()
	if PartyBox.Mode() == "hello" then PartyBox.Main() end
end

function ns.Goodbye()
	if PartyBox.Mode() then close() end
	if ns.InGroup() then ns.Leave.Do() end
end

-- The roster settles a moment after the join: then say hello.
ns.On("GROUP_FORMED", function() ns.After(1, PartyBox.ShowHello) end)
ns.On("GROUP_DONE", PartyBox.ShowGoodbye)
ns.RegisterEvent("GROUP_ROSTER_UPDATE", function()
	if PartyBox.Mode() and not ns.InGroup() then close() end
end)
ns.RegisterEvent("QUEST_LOG_UPDATE", function() PartyBox.Refresh() end)
ns.On("ENABLED", function(on) if not on then close() end end)
ns.On("SETTING", function(key)
	if key == "partyBox" and not ns.Get("partyBox") then close() end
	if key == "partyBoxStyle" then PartyBox.Refresh() end
	if key == "partyBox" then PartyBox.DimPreviews() end
end)
