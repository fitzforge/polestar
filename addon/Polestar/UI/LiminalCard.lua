-- The Liminal Passage heads-up (nav.liminalScroll; the offer: Nav/LiminalScroll.lua). A card on the guide window, as
-- the auction house reminder's, with a line each for the two offers:
--
-- * "use": "Use a Scroll of Liminal Passage": the member who rests at an inn, that inn, and what the teleport saves on
--   the trip. The scroll's icon shows its count and the game's tooltip. The card has no button for it: the player
--   uses the scroll from the bags.
-- * "need": "Buy Scrolls of Liminal Passage", only in a town with an auction house (UI/AuctionBuys.lua's
--   AuctioneerHere), with "Show me the auctioneer" (the arrow to the nearest one, Nearby.Go).
--
-- Each is told once: a "use" line once per member and target, a "need" line once per visit to a town (the visit ends
-- when the character is out of every auctioneer's reach). Never in combat, while Polestar or the guide window is
-- hidden, nor while another heads-up is on the card: the next look at the offer (Nav/LiminalScroll.lua repeats it
-- every few seconds) tries again. "Turn these off" sets nav.liminalScroll off.
--
--   UI.LiminalCard.Model(offer, place) -> card model   place: the auctioneer of a "need" offer
--   UI.LiminalCard.Check(offer) -> true when a card shows

local ADDON, ns = ...
local UI = ns.UI
local L = ns.L
local format = string.format

local LC = {}
UI.LiminalCard = LC

LC.KIND = "liminal"
LC.ICON = "Interface\\AddOns\\" .. ADDON .. "\\Media\\Map\\icon-auction"

local toldUse = {} -- "member:target" -> true: the use lines already shown
local toldTown       -- the map of the town whose need line was shown, until the character leaves it

local function CT() return UI.ClassToast end

local function duration(seconds)
	local Q = ns.QoL
	return Q and Q.Duration and Q.Duration(seconds) or format(L["%ds"], seconds)
end

local function turnOff()
	ns.Set("nav.liminalScroll", false)
	ns.Print(L["Liminal Passage tips are off. Turn them back on under Settings > Guide > Arrow & routes > Routes."])
end

-- The card for `offer` (Nav.liminal.Find's); place: the auctioneer, for a "need" offer.
function LC.Model(offer, place)
	local item = ns.Nav.liminal.ITEM
	local m = { kind = LC.KIND, icon = LC.ICON, iconColor = "accent", titleColor = "text", head = L["LIMINAL PASSAGE"] }
	m.spells = { { item = item, count = ns.Compat.GetItemCount(item) } }
	m.off = { label = L["Turn these off"], run = turnOff }
	if offer.kind == "use" then
		m.title = L["Use a Scroll of Liminal Passage"]
		m.giver = format(L["%s rests at %s. The scroll takes you there and saves about %s on this trip."], offer.member, offer.inn, duration(offer.saves))
		m.route = L["You and your party member must both rest in an inn or a city, out of combat."]
		m.noAct = true
	else
		m.title = L["Buy Scrolls of Liminal Passage"]
		m.giver = L["A Mage can teleport to a party member who rests in an inn or a city. You carry no scroll, and this trip is long."]
		m.route = L["The auction house sells them."]
		m.act = { label = L["Show me the auctioneer"], run = function()
			local N = ns.Nav and ns.Nav.nearby
			if N and N.Go and N.Go("auction") then CT().Hide() end
			return true
		end }
	end
	return m
end

local function useKey(offer)
	return format("%s:%s", offer.member, offer.target and offer.target.label or "")
end

-- Whether `offer` is told now: a "use" line once per member and target; a "need" line once per town visit, and only in
-- a town with an auction house. -> true | false, the auctioneer's place (for a "need" line)
local function due(offer)
	if offer.kind == "use" then return not toldUse[useKey(offer)] end
	local place = UI.AuctionBuys and UI.AuctionBuys.AuctioneerHere(true)
	if not place then
		toldTown = nil -- out of every auctioneer's reach: the visit is over
		return false
	end
	return toldTown ~= place.map, place
end

local function told(offer, place)
	if offer.kind == "use" then
		toldUse[useKey(offer)] = true
	else
		toldTown = place.map
	end
end

function LC.Check(offer)
	local T = CT()
	if not (T and T.ShowCard) or ns.Hidden() or InCombatLockdown() then return false end
	local yes, place = due(offer)
	if not yes then return false end
	local cur = T.current
	if cur and cur.kind ~= LC.KIND then return false end
	if T.ShowCard(LC.Model(offer, place)) then
		told(offer, place)
		return true
	end
	return false
end

ns.On("LIMINAL_OFFER", function(offer)
	if offer then
		LC.Check(offer)
		return
	end
	local T = CT()
	if T and T.current and T.current.kind == LC.KIND then T.Hide() end
end)
