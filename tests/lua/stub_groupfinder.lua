-- The game's chat channels and invitations, for the group finder
-- (Polestar_GroupFinder). Load after stub_world.lua and stub_party.lua (which
-- own the group, addon messages and chat lines). Shapes follow the Forever
-- client's Blizzard_APIDocumentationGenerated (ChatInfoDocumentation.lua,
-- PartyInfoDocumentation.lua) and FrameXML (ChatFrame's channel functions).
--
--   local g = stub.groupfinder
--   g.channels                 -- { [name] = id } the channels joined (JoinTemporaryChannel); General is 1
--   g.invited                  -- names C_PartyInfo.InviteUnit was called with, in order
--   g.left                     -- times C_PartyInfo.LeaveParty was called
--   g.region = 3               -- GetCurrentRegion (1 Americas, 2 Korea, 3 Europe, 4 Taiwan, 5 China; nil: unknown)
--   g.search(sender, text)     -- an addon message on the finder's hidden channel (CHAT_MSG_ADDON "CHANNEL")
--   g.whisper(sender, text)    -- one whispered (CHAT_MSG_ADDON "WHISPER")

local g = { channels = { General = 1 }, invited = {}, left = 0 }
stub.groupfinder = g

local function nextId()
	local n = 0
	for _, id in pairs(g.channels) do if id > n then n = id end end
	return n + 1
end

function JoinTemporaryChannel(name)
	if not g.channels[name] then g.channels[name] = nextId() end
end
JoinChannelByName = JoinTemporaryChannel
function LeaveChannelByName(name) g.channels[name] = nil end
-- GetChannelName(name): id, name (0 when not joined).
function GetChannelName(name)
	if type(name) == "number" then
		for n, id in pairs(g.channels) do if id == name then return id, n end end
		return 0
	end
	local id = g.channels[name]
	return id or 0, id and name or nil
end
-- GetChannelList(): id, name, disabled, ... for every channel joined.
function GetChannelList()
	local out = {}
	for n, id in pairs(g.channels) do out[#out + 1] = { id, n } end
	table.sort(out, function(a, b) return a[1] < b[1] end)
	local flat = {}
	for _, c in ipairs(out) do flat[#flat + 1] = c[1]; flat[#flat + 1] = c[2]; flat[#flat + 1] = false end
	return unpack(flat)
end
function ChatFrame_RemoveChannel() end
NUM_CHAT_WINDOWS = 1

function GetCurrentRegion() return g.region end

C_PartyInfo = C_PartyInfo or {}
function C_PartyInfo.InviteUnit(name) table.insert(g.invited, name) end
function C_PartyInfo.LeaveParty() g.left = g.left + 1 end
function C_PartyInfo.CanInvite() return true end
function UnitIsGroupLeader() return true end

function g.search(sender, text) stub.party.receive(sender, text, "CHANNEL", "PSGF") end
function g.whisper(sender, text) stub.party.receive(sender, text, "WHISPER", "PSGF") end
