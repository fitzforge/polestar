-- Never lose work (spec 9.4): Forever can restore SavedVariables as nil after
-- a cold restart, so the draft also goes to a second SavedVariable,
-- PolestarStudioBackup, a rolling set of 5 copies written at every save
-- point (a minute after the last edit, a draft replaced or deleted, logout).
-- On load, a main table that is missing, or older than the newest backup,
-- gets a restore offer.
--
--   S.Backup.Save()            a save point now (the current draft)
--   S.Backup.Push(doc)         a copy of doc into the backups
--   S.Backup.List() -> { { time, id, title, steps } }   newest first
--   S.Backup.Restore(n)        backup n becomes a draft again, and the current one
--   S.Backup.LastTime() -> epoch seconds of the newest backup | nil
--   S.Backup.ExportString() -> string | nil, reason   (the current draft as a string)
--   S.Backup.Offer(force)      the restore prompt
-- Fires STUDIO_SAVED(time).

local ADDON, S = ...
local L = S.L

local Backup = {}
S.Backup = Backup

local KEEP = 5
local SAVE_AFTER = 60

local function store()
	local b = PolestarStudioBackup
	if type(b) ~= "table" then
		b = {}
		PolestarStudioBackup = b
	end
	if type(b.list) ~= "table" then b.list = {} end
	return b
end

function Backup.Push(doc)
	if type(doc) ~= "table" or type(doc.header) ~= "table" then return end
	local list = store().list
	local top = list[1]
	if top and top.id == doc.header.id and top.updated == doc.updated then return end
	table.insert(list, 1, { time = S.Now(), id = doc.header.id, updated = doc.updated, doc = S.Copy(doc) })
	while #list > KEEP do list[#list] = nil end
end

function Backup.Save()
	local doc = S.Model and S.Model.Current()
	if not doc then return end
	Backup.Push(doc)
	local now = S.Now()
	S.DB().saved = now
	S.Fire("STUDIO_SAVED", now)
end

function Backup.List()
	local out = {}
	for i, e in ipairs(store().list) do
		local h = type(e.doc) == "table" and e.doc.header or {}
		out[i] = { time = e.time, id = e.id, title = h.title or e.id, steps = type(e.doc) == "table" and #(e.doc.steps or {}) or 0 }
	end
	return out
end

function Backup.LastTime()
	local top = store().list[1]
	return top and top.time or nil
end

function Backup.Restore(n)
	local e = store().list[n or 1]
	if not (e and type(e.doc) == "table" and e.id) then return false end
	local docs = S.DB().docs
	local cur = docs[e.id]
	if cur and cur ~= e.doc then Backup.Push(cur) end
	docs[e.id] = S.Copy(e.doc)
	S.Model.SetCurrent(e.id)
	return true
end

function Backup.ExportString()
	return S.Export(S.Model.Current())
end

---------------------------------------------------------------------------
-- Restore offer
---------------------------------------------------------------------------

local function whenText(t)
	local ago = S.Now() - (t or 0)
	if ago < 60 then return L["just now"] end
	if ago < 3600 then return (L["%d min ago"]):format(math.floor(ago / 60)) end
	if ago < 86400 then return (L["%d h ago"]):format(math.floor(ago / 3600)) end
	return date and date("%Y-%m-%d %H:%M", t) or tostring(t)
end
Backup.WhenText = whenText

StaticPopupDialogs = StaticPopupDialogs or {}
StaticPopupDialogs.POLESTAR_STUDIO_RESTORE = {
	text = "%s",
	button1 = L["Restore"],
	button2 = L["Not now"],
	OnAccept = function()
		if Backup.Restore(1) then S.Print(L["Draft restored from the backup."]) end
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3,
}

function Backup.Offer(force)
	local top = store().list[1]
	if not (top and type(top.doc) == "table") then
		if force then S.Print(L["No backup yet."]) end
		return false
	end
	local db = S.DB()
	local cur = db.docs[top.id]
	local behind = not S.loadedDB or (type(cur) == "table" and (cur.updated or 0) < (top.updated or 0))
	if not (force or behind) then return false end
	local title = top.doc.header and top.doc.header.title or top.id
	local text = (L["Polestar Studio has a backup of \"%s\" from %s. Restore it?"]):format(title, whenText(top.time))
	if StaticPopup_Show then StaticPopup_Show("POLESTAR_STUDIO_RESTORE", text) end
	return true
end

---------------------------------------------------------------------------
-- Save points
---------------------------------------------------------------------------

S.On("STUDIO_CHANGED", function(kind)
	if kind == "select" then return end
	S.Debounce("backup", SAVE_AFTER, Backup.Save)
end)

S.RegisterEvent("PLAYER_LOGOUT", function()
	S.CancelDebounce("backup")
	Backup.Save()
end)

S.RegisterEvent("PLAYER_LOGIN", function()
	store()
	C_Timer.After(3, function() Backup.Offer(false) end)
end)
