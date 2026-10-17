-- Requests from other players: summons, resurrections, party and guild
-- invitations, duels. Each event is registered only while a setting that
-- needs it is on (QoL.WhileOn), so what is off costs nothing.
--
--   acceptSummon          take a summon, unless in combat or unable to
--                         teleport (the dialog's own Accept rules). Shift: ask.
--   acceptResurrect       take a resurrection, once the corpse delay allows,
--                         unless its caster is in combat (a battle resurrection
--                         is yours to time) or Hardcore is on. Shift: ask.
--   acceptPartyFriends    join a friend's or guild member's party, unless it is
--                         a role check or joining would drop a queue. Shift: ask.
--   declinePartyStrangers decline party invitations from anyone else.
--   declineGuildInvites   decline guild invitations, except from friends.
--   declineDuels          decline duels, except from friends and guild.
--
-- A friend: on the friend list (C_FriendList.IsFriend / GetFriendInfo), a
-- Battle.net friend's character (C_BattleNet.GetGameAccountInfoByGUID) or a
-- guild member (IsGuildMember, C_GuildInfo.MemberExistsByName).
--
-- Answering through the API leaves Blizzard's dialog up, so it is closed on
-- the next frame (after Blizzard's own handler has shown it): PARTY_INVITE
-- with inviteAccepted set, as its Accept button does, since its OnHide declines
-- otherwise (GameDialogDefs.lua); GuildInviteFrame's OnHide declines, which is
-- the answer anyway. Resurrection dialogs close themselves at PLAYER_ALIVE.
-- Under Forever's Gamepad interface style (ns.GamepadUI, Core/Init.lua)
-- dialogs belong to the gamepad focus system and are left for the player
-- to dismiss.
-- Client: CONFIRM_SUMMON, RESURRECT_REQUEST, PARTY_INVITE_REQUEST,
-- GUILD_INVITE_REQUEST, DUEL_REQUESTED (Blizzard_APIDocumentationGenerated);
-- C_SummonInfo.ConfirmSummon, AcceptResurrect, AcceptGroup, DeclineGroup,
-- DeclineGuild, CancelDuel, PlayerCanTeleport, WillAcceptInviteRemoveQueues,
-- GetCorpseRecoveryDelay, ResurrectGetOfferer (GameDialogDefs.lua,
-- Blizzard_Game EventImplementation.lua).

local ADDON, ns = ...
local L = ns.L
local QoL = ns.QoL
local readable = ns.Compat.Readable

local format = string.format

local Social = {}
QoL.Social = Social

---------------------------------------------------------------------------
-- Who is a friend
---------------------------------------------------------------------------

local function byGUID(guid)
	if C_FriendList and C_FriendList.IsFriend and C_FriendList.IsFriend(guid) then return true end
	if C_BattleNet and C_BattleNet.GetGameAccountInfoByGUID and C_BattleNet.GetGameAccountInfoByGUID(guid) then return true end
	return IsGuildMember and IsGuildMember(guid) and true or false
end

local function byName(name)
	if C_FriendList and C_FriendList.GetFriendInfo and C_FriendList.GetFriendInfo(name) then return true end
	local G = C_GuildInfo
	return G and G.MemberExistsByName and G.MemberExistsByName(name) and true or false
end

-- name: as the event gives it ("Name" or "Name-Realm"); guid when known.
function Social.IsFriend(name, guid)
	guid, name = readable(guid), readable(name)
	if guid and guid ~= "" and byGUID(guid) then return true end
	if not name or name == "" then return false end
	if byName(name) then return true end
	local short = name:match("^([^%-]+)%-")
	return short and byName(short) or false
end

---------------------------------------------------------------------------
-- Blizzard's dialogs
---------------------------------------------------------------------------

local gamepadUI = ns.GamepadUI

local function nextFrame(fn)
	if C_Timer and C_Timer.After then C_Timer.After(0, fn) else fn() end
end

-- Close a static popup the way its own button would; `mark` is a field its
-- OnHide reads to know it was answered.
local function closePopup(which, mark)
	nextFrame(function()
		if gamepadUI() or not StaticPopup_Hide then return end
		if mark and StaticPopup_FindVisible then
			local dialog = StaticPopup_FindVisible(which)
			if dialog then dialog[mark] = 1 end
		end
		StaticPopup_Hide(which)
	end)
end

local function inCombat(unit)
	return UnitAffectingCombat and UnitAffectingCombat(unit) and true or false
end

local function hardcore()
	return C_GameRules and C_GameRules.IsHardcoreActive and C_GameRules.IsHardcoreActive() and true or false
end

---------------------------------------------------------------------------
-- Summons
---------------------------------------------------------------------------

function Social.TakeSummon()
	if not QoL.On("acceptSummon") or QoL.Shift() then return false end
	if inCombat("player") then return false end
	if PlayerCanTeleport and not PlayerCanTeleport() then return false end
	return true
end

function Social.OnSummon()
	local S = C_SummonInfo
	if not (S and S.ConfirmSummon) or not Social.TakeSummon() then return end
	local who = S.GetSummonConfirmSummoner and readable(S.GetSummonConfirmSummoner())
	local where = S.GetSummonConfirmAreaName and readable(S.GetSummonConfirmAreaName())
	S.ConfirmSummon()
	closePopup("CONFIRM_SUMMON")
	if who and where then
		ns.Print(format(L["Accepted a summon from %s to %s."], who, where))
	else
		ns.Print(L["Accepted a summon."])
	end
end

QoL.WhileOn("acceptSummon", "CONFIRM_SUMMON", Social.OnSummon)

---------------------------------------------------------------------------
-- Resurrections
---------------------------------------------------------------------------

function Social.TakeResurrect(caster)
	if not QoL.On("acceptResurrect") or QoL.Shift() then return false end
	if hardcore() then return false end
	if caster and inCombat(caster) then return false end
	return true
end

local function acceptResurrect(caster)
	-- Still offered (it may have been declined or timed out meanwhile).
	if ResurrectGetOfferer and not ResurrectGetOfferer() then return end
	if not Social.TakeResurrect(caster) or not AcceptResurrect then return end
	AcceptResurrect()
	ns.Print(caster and format(L["Accepted a resurrection from %s."], caster) or L["Accepted a resurrection."])
end

function Social.OnResurrect(_, caster)
	caster = readable(caster)
	if not Social.TakeResurrect(caster) then return end
	-- The dialog's Accept stays disabled for the corpse recovery delay.
	local delay = GetCorpseRecoveryDelay and GetCorpseRecoveryDelay() or 0
	if delay > 0 and C_Timer and C_Timer.After then
		C_Timer.After(delay + 0.1, function() acceptResurrect(caster) end)
	else
		acceptResurrect(caster)
	end
end

QoL.WhileOn("acceptResurrect", "RESURRECT_REQUEST", Social.OnResurrect)

---------------------------------------------------------------------------
-- Party invitations
---------------------------------------------------------------------------

-- "accept", "decline" or nil (ask). roleCheck: a Dungeon Finder role invite.
function Social.PartyAnswer(name, guid, roleCheck)
	if Social.IsFriend(name, guid) then
		if not QoL.On("acceptPartyFriends") or QoL.Shift() or roleCheck then return nil end
		if WillAcceptInviteRemoveQueues and WillAcceptInviteRemoveQueues() then return nil end
		return "accept"
	end
	if QoL.On("declinePartyStrangers") then return "decline" end
	return nil
end

function Social.OnPartyInvite(_, name, isTank, isHealer, isDamage, _, _, guid)
	name = readable(name)
	local answer = Social.PartyAnswer(name, guid, (isTank or isHealer or isDamage) and true or false)
	if answer == "accept" and AcceptGroup then
		AcceptGroup()
		closePopup("PARTY_INVITE", "inviteAccepted")
		ns.Print(format(L["Joined %s's party."], name or "?"))
	elseif answer == "decline" and DeclineGroup then
		DeclineGroup()
		closePopup("PARTY_INVITE")
		ns.Print(format(L["Declined a party invitation from %s."], name or "?"))
	end
end

QoL.WhileOn({ "acceptPartyFriends", "declinePartyStrangers" }, "PARTY_INVITE_REQUEST", Social.OnPartyInvite)

---------------------------------------------------------------------------
-- Guild invitations
---------------------------------------------------------------------------

function Social.DeclineGuild(inviter)
	return QoL.On("declineGuildInvites") and not Social.IsFriend(inviter) or false
end

function Social.OnGuildInvite(_, inviter, guildName)
	inviter, guildName = readable(inviter), readable(guildName)
	if not (Social.DeclineGuild(inviter) and DeclineGuild) then return end
	DeclineGuild()
	nextFrame(function()
		local f = GuildInviteFrame
		if f and not gamepadUI() and f:IsShown() then f:Hide() end
	end)
	ns.Print(format(L["Declined an invitation to %s."], guildName or (inviter or "?")))
end

QoL.WhileOn("declineGuildInvites", "GUILD_INVITE_REQUEST", Social.OnGuildInvite)

---------------------------------------------------------------------------
-- Duels
---------------------------------------------------------------------------

function Social.DeclineDuel(challenger)
	return QoL.On("declineDuels") and not Social.IsFriend(challenger) or false
end

function Social.OnDuel(_, challenger)
	challenger = readable(challenger)
	if not (Social.DeclineDuel(challenger) and CancelDuel) then return end
	CancelDuel()
	closePopup("DUEL_REQUESTED")
	ns.Print(challenger and format(L["Declined a duel from %s."], challenger) or L["Declined a duel."])
end

QoL.WhileOn("declineDuels", "DUEL_REQUESTED", Social.OnDuel)
