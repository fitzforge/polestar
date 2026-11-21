-- Replacing an enchant on your own gear (qol.autoReplaceEnchant, off by
-- default: it overwrites an enchant for the player, #3126). Enchanting an
-- item that already has one fires REPLACE_ENCHANT (a scroll or an item used
-- on gear) or REPLACE_TRADESKILL_ENCHANT (cast from the profession window),
-- each with the names of the enchant on the item and the new one, and
-- Blizzard shows the StaticPopup of the same name. Its Accept calls
-- C_Item.ReplaceEnchant or C_Item.ReplaceTradeskillEnchant
-- (Blizzard_StaticPopup_Game GameDialogDefs.lua and Mainline/GameDialogDefs.lua),
-- and neither popup has an OnCancel.
--
-- At the event this answers the same way, unless Shift is held, closes the
-- popup and names both enchants in chat, so an overwrite never goes unseen.
-- Answered inside the event, the first answer takes on Forever's client
-- (checked in game, #3126), unlike CONFIRM_BINDER's (Bind.lua).
-- TRADE_REPLACE_ENCHANT, the same question in a trade window, is left to the
-- player: the item is someone else's.

local ADDON, ns = ...
local L = ns.L
local QoL = ns.QoL
local readable = ns.Compat.Readable

local Enchant = {}
QoL.Enchant = Enchant

-- Event (and the popup Blizzard shows for it) -> the C_Item call its Accept makes.
Enchant.ANSWER = {
	REPLACE_ENCHANT = "ReplaceEnchant",
	REPLACE_TRADESKILL_ENCHANT = "ReplaceTradeskillEnchant",
}

function Enchant.OnReplace(event, existing, replacement)
	if not QoL.On("autoReplaceEnchant") or QoL.Shift() then return end
	local answer = C_Item and C_Item[Enchant.ANSWER[event]]
	if type(answer) ~= "function" then return end
	answer()
	QoL.ClosePopup(event)
	existing, replacement = readable(existing), readable(replacement)
	if existing and replacement then
		ns.Print(string.format(L["Replaced %s with %s."], existing, replacement))
	else
		ns.Print(L["Replaced the enchant."])
	end
end

for event in pairs(Enchant.ANSWER) do
	QoL.WhileOn("autoReplaceEnchant", event, Enchant.OnReplace)
end
