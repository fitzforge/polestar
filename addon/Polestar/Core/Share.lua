-- Share: an imported guide (or Polestar Studio's draft) sent to another
-- player through a chat link, as its v2 import string.
--
--   Share.Link(guideId) -> bool   -- put [Polestar: <title>] into the open chat box
--
-- The link is |Hgarrmission:polestar:<sender>:<guideId>|h[Polestar: <title>]|h
-- (a link type the server passes through to other players). Clicking
-- it (a post-hook on SetItemRef) whispers `REQ <guideId>` to the sender on
-- the addon prefix PolestarShare. The sender answers only links it made in
-- the last 5 minutes: it re-encodes the guide's stored entry
-- (Import.Encode, a !PS2! string) and whispers it in chunks of 240 bytes,
-- `n/total|data`, about four a second; a string over 64 KB gets `BIG`
-- instead, an unknown or expired link `NO`. The receiver takes chunks only
-- from a sender it asked, shows the progress in a tooltip, and on the last
-- one opens the Import page with the string read through the normal
-- Preview (UI/Import.lua, IV.Paste). Nothing is saved until the player
-- presses Import.

local ADDON, ns = ...
local L = ns.L
local Guides = ns.Guides
local Import = ns.Import

local type, tonumber, format, concat, floor = type, tonumber, string.format, table.concat, math.floor

local Share = {}
ns.Share = Share

local PREFIX = "PolestarShare"
local CHUNK = 240
local MAX_BYTES = 65536
local LINK_SECONDS = 300
local SEND_INTERVAL = 0.25
Share.PREFIX, Share.CHUNK, Share.MAX_BYTES, Share.LINK_SECONDS = PREFIX, CHUNK, MAX_BYTES, LINK_SECONDS

local made = {} -- guide id -> GetTime() of the last link made for it
local asked = {} -- sender -> { id, chunks = {}, total, got } while a guide is on its way

if C_ChatInfo and C_ChatInfo.RegisterAddonMessagePrefix then C_ChatInfo.RegisterAddonMessagePrefix(PREFIX) end

local function shortName(name)
	if type(name) ~= "string" then return nil end
	return Ambiguate and Ambiguate(name, "none") or name
end

local function me() return shortName(UnitName and UnitName("player")) end

local function send(text, target)
	if C_ChatInfo and C_ChatInfo.SendAddonMessage then C_ChatInfo.SendAddonMessage(PREFIX, text, "WHISPER", target) end
end

-- One line in a tooltip at the cursor (asking, receiving, refused).
local function status(text)
	local tt = GameTooltip
	if not tt then
		ns.Print(text)
		return
	end
	tt:SetOwner(UIParent, "ANCHOR_CURSOR")
	tt:SetText(text)
	tt:Show()
end

-- Guide id -> its entry, when it is one a link can carry: an imported guide
-- or the draft, with a stored v2 entry (one with its source).
local function entryOf(id)
	local g = type(id) == "string" and Guides.Get(id)
	if not g then return nil end
	local entry
	if g.pack == "imported" then
		entry = Import.Entry(id)
	elseif g.pack == "studio" and ns.Studio then
		entry = ns.Studio.Entry(id)
	end
	if type(entry) == "table" and type(entry.source) == "table" then return entry end
	return nil
end

function Share.Link(guideId)
	if not entryOf(guideId) then return false end
	local sender = me()
	if not sender then return false end
	local g = Guides.Get(guideId)
	-- The title as shown, without what would end the link early.
	local title = tostring(g.title or guideId):gsub("|", ""):gsub("[%[%]]", "")
	local link = format("|Hgarrmission:polestar:%s:%s|h[%s]|h", sender, guideId, format(L["Polestar: %s"], title))
	local box = ChatEdit_GetActiveWindow and ChatEdit_GetActiveWindow()
	if box then
		box:Insert(link)
	elseif ChatFrame_OpenChat then
		ChatFrame_OpenChat(link)
	else
		return false
	end
	made[guideId] = GetTime()
	return true
end

-- A click on a garrmission:polestar: link: ask its sender for the guide.
function Share.Request(sender, guideId)
	sender = shortName(sender)
	if not (sender and type(guideId) == "string") then return end
	asked[sender] = { id = guideId, chunks = {}, got = 0 }
	send("REQ " .. guideId, sender)
	status(format(L["Asking %s\226\128\166"], sender))
end

if hooksecurefunc and type(SetItemRef) == "function" then
	hooksecurefunc("SetItemRef", function(link)
		if type(link) ~= "string" then return end
		local sender, id = link:match("^garrmission:polestar:([^:]+):(.+)$")
		if sender then Share.Request(sender, id) end
	end)
end

-- The sender's side: answer a request for a link made in the last 5 minutes.
local function answer(id, target)
	local at = made[id]
	local entry = at and GetTime() - at <= LINK_SECONDS and entryOf(id)
	if not entry then
		send("NO " .. id, target)
		return
	end
	local text = Import.Encode(entry)
	if not text then
		send("NO " .. id, target)
		return
	end
	if #text > MAX_BYTES then
		send("BIG " .. id, target)
		return
	end
	local total = floor((#text + CHUNK - 1) / CHUNK)
	local n = 0
	local function nextChunk()
		n = n + 1
		send(n .. "/" .. total .. "|" .. text:sub((n - 1) * CHUNK + 1, n * CHUNK), target)
		if n < total then C_Timer.After(SEND_INTERVAL, nextChunk) end
	end
	nextChunk()
end

-- The receiver's side: chunks from a sender it asked, joined on the last.
local function received(from, n, total, data)
	local want = asked[from]
	if not want then return end
	if want.total and want.total ~= total or n < 1 or n > total or total * CHUNK > MAX_BYTES + CHUNK then
		asked[from] = nil
		status(format(L["The guide from %s arrived incomplete: ask again."], from))
		return
	end
	want.total = total
	if not want.chunks[n] then want.got = want.got + 1 end
	want.chunks[n] = data
	if n < total then
		status(format(L["Receiving a guide from %s: %d/%d"], from, n, total))
		return
	end
	asked[from] = nil
	for i = 1, total do
		if not want.chunks[i] then
			status(format(L["The guide from %s arrived incomplete: ask again."], from))
			return
		end
	end
	if GameTooltip then GameTooltip:Hide() end
	local text = concat(want.chunks, "", 1, total)
	local IV = ns.UI and ns.UI.Import
	ns.Fire("SHOW_IMPORT")
	if IV and IV.Paste then IV.Paste(text) end
end

ns.RegisterEvent("CHAT_MSG_ADDON", function(_, prefix, message, channel, sender)
	if prefix ~= PREFIX or type(message) ~= "string" or channel ~= "WHISPER" then return end
	local from = shortName(sender)
	if not from then return end
	local verb, id = message:match("^(%u+) (.+)$")
	if verb == "REQ" then
		answer(id, from)
		return
	end
	local want = asked[from]
	if verb == "BIG" and want and want.id == id then
		asked[from] = nil
		status(L["Too big to send in chat: ask for the string."])
		return
	end
	if verb == "NO" and want and want.id == id then
		asked[from] = nil
		status(format(L["%s's link has expired: ask for a new one."], from))
		return
	end
	local n, total, data = message:match("^(%d+)/(%d+)|(.*)$")
	if n then received(from, tonumber(n), tonumber(total), data) end
end)
