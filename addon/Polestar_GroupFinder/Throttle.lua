-- Polestar Group Finder: an outgoing queue for addon messages.
--
-- The client allows about 10 addon messages per prefix in a burst, then
-- one per second (values the server may change). We stay well under it:
-- a bucket of BURST messages refilled at RATE per second, messages that
-- do not fit wait their turn, and a message the client refuses with
-- AddonMessageThrottle is tried again later. A search goes out at once
-- (Throttle.SendNow) so that its result can be told on the click; replies,
-- updates and probes go through the queue.

local _, ns = ...

local Throttle = {}
ns.Throttle = Throttle

local BURST, RATE = 4, 0.8
local MAX_QUEUE = 30
local tokens, last = BURST, 0
local queue = {}
local ticking = false

local RESULT_NAMES = {
	[0] = "Success", "InvalidPrefix", "InvalidMessage", "AddonMessageThrottle", "InvalidChatType",
	"NotInGroup", "TargetRequired", "InvalidChannel", "ChannelThrottle", "GeneralError",
	"NotInGuild", "AddOnMessageLockdown", "TargetOffline",
}
function Throttle.ResultName(code)
	if code == true then return "Success" end
	if code == false or code == nil then return "Failed" end
	return RESULT_NAMES[code] or tostring(code)
end

local function refill()
	local now = ns.Now()
	tokens = math.min(BURST, tokens + (now - last) * RATE)
	last = now
end

-- Sends at once; returns ok, code (Enum.SendAddonMessageResult or boolean).
function Throttle.SendNow(prefix, text, chatType, target)
	if not (C_ChatInfo and C_ChatInfo.SendAddonMessage) then return false, "noapi" end
	if #text > 255 then return false, "InvalidMessage" end
	refill()
	tokens = tokens - 1
	local ok, r = pcall(C_ChatInfo.SendAddonMessage, prefix, text, chatType, target)
	if not ok then return false, "GeneralError" end
	-- Older clients return a boolean, newer ones a result code (last value).
	local success = (Enum and Enum.SendAddonMessageResult and Enum.SendAddonMessageResult.Success) or 0
	if r == nil or r == true or r == success then return true, 0 end
	return false, r
end

local function pump()
	refill()
	while queue[1] and tokens >= 1 do
		local m = table.remove(queue, 1)
		local ok, code = Throttle.SendNow(m.prefix, m.text, m.chatType, m.target)
		if not ok and Throttle.ResultName(code) == "AddonMessageThrottle" and (m.tries or 0) < 3 then
			m.tries = (m.tries or 0) + 1
			table.insert(queue, 1, m)
			tokens = 0
			break
		end
		if m.done then pcall(m.done, ok, code) end
	end
	if queue[1] then
		ns.After(1 / RATE, pump)
	else
		ticking = false
	end
end

function Throttle.Send(prefix, text, chatType, target, done)
	if #queue >= MAX_QUEUE then return false end
	queue[#queue + 1] = { prefix = prefix, text = text, chatType = chatType, target = target, done = done }
	if not ticking then
		ticking = true
		pump()
	end
	return true
end
