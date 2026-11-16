-- env: world stub_quests.lua stub_questlog.lua
-- questdb: fixture
-- The Questing page's quest database settings (Quests/Options.lua; QuestDB.lua, Tooltips.lua, SellWarning.lua,
-- Tracker.lua's nameplates, QuestLevels.lua, Timed.lua, UI/AuctionBuys.lua's list) on the fixture database, as
-- quests.rs, quests-levels.rs and quests-timed.rs play them: Kobold Camp Cleanup and Kobold Candles in the log, a
-- Kobold Vermin's nameplate and tooltip, a merchant buying the candles, the quest log's titles and a timed delivery
-- on its guide.
local w, sq, ql, Q
local function said(pattern) local n = 0 for _, m in ipairs(stub.messages) do if m:find(pattern) then n = n + 1 end end return n end
-- Jump the clock by s seconds (the last second played, so the ticker runs; quests-timed.rs).
local function jump(s) stub.now = stub.now + s - 1.1; stub.advance(1.1) end
-- A Blizzard nameplate for unit (quests.rs): its bar, name and level badge.
local function blizzard(plate)
	local function frame(kind, parent, label, wd, ht)
		local f = CreateFrame(kind, nil, parent)
		f.label = label
		if wd then f:SetSize(wd, ht) end
		return f
	end
	local uf = frame("Frame", plate, "unitframe")
	plate.UnitFrame = uf
	uf.healthBar = frame("StatusBar", uf, "bar", 120, 8)
	uf.name = uf:CreateFontString(nil, "OVERLAY")
	uf.name.label = "name"
	uf.name:SetText("Kobold Vermin")
	uf.PlayerLevelDiffFrame = frame("Frame", uf, "level", 15, 15)
end
-- A Kobold Vermin's nameplate comes into view: Polestar's icon on it, and where.
local function plate()
	sq.removePlate("nameplate1")
	sq.addPlate("nameplate1", 6, false, blizzard)
	stub.advance(0.1)
	local f = Q.NameplateIcon("nameplate1")
	if not (f and f:IsShown()) then return false end
	local point, rel, relPoint = f:GetPoint(1)
	return point .. " " .. (rel and rel.label or "?") .. " " .. relPoint
end
-- At a merchant, the eight Large Candles Kobold Candles needs are sold: the buy-back question, or none.
local function sale()
	local C = Polestar.QoL.Client
	local real = { C.NumBags, C.NumSlots, C.SlotInfo }
	local bag = { { itemID = 772, stackCount = 8 } }
	C.NumBags, C.NumSlots, C.SlotInfo = function() return 0 end, function() return #bag end, function(_, slot) return bag[slot] end
	local before = #stub.popups
	Q.SellWarningOpen(true)
	bag[1] = nil
	buyback = { { link = "|cffffffff|Hitem:772::::::::|h[Large Candle]|h|r", price = 24 } }
	Q.CheckSold()
	stub.advance(0.5)
	local asked = 0
	for i = before + 1, #stub.popups do if stub.popups[i].which == "POLESTAR_QUEST_BUYBACK" then asked = asked + 1 end end
	Q.SellWarningOpen(false)
	buyback = {}
	C.NumBags, C.NumSlots, C.SlotInfo = real[1], real[2], real[3]
	return asked
end
return {
	setup = function()
		w, sq, ql, Q = stub.world, stub.quests, stub.questlog, Polestar.QuestDB
		w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
		w.moveTo(1429, 47.6, 45.1)
		w.setLevel(5)
		for q, t in pairs({ [7] = "Kobold Camp Cleanup", [60] = "Kobold Candles" }) do w.titles[q] = t end
		w.complete({ 783 })
		w.accept(7, { { text = "Kobold Vermin slain: 3/10", type = "monster", required = 10 } })
		w.progress(7, 1, 3)
		w.accept(60, { { text = "Large Candle: 0/8", type = "item", required = 8 } })
		-- The buyback list, which the stub world lacks.
		buyback = {}
		GetNumBuybackItems = function() return #buyback end
		GetBuybackItemLink = function(i) return buyback[i].link end
		GetBuybackItemInfo = function(i) return "x", "icon", buyback[i].price end
		BuybackItem = function() end
		GetCoinTextureString = GetCoinTextureString or function(c) return c .. "c" end
		-- The quest log's titles (quests-levels.rs).
		ql.quests[7] = { title = "Kobold Camp Cleanup", level = 12 }
		ql.log = { 7 }
		-- A timed delivery on its guide (quests-timed.rs): ten minutes.
		Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
		Polestar.RegisterGuide({ id = "test/timed", pack = "test", title = "Timed", minLevel = 1, maxLevel = 10, steps = {
			{ title = "Nori", goals = { { t = "accept", quest = 3364, title = "Scalding Mornbrew Delivery", npc = 12738, npcName = "Nori Pridedrift",
				minLevel = 4, qlvl = 5, limit = 600, map = 1429, x = 47.6, y = 45.1 } } },
			{ title = "Durnan", goals = { { t = "turnin", quest = 3364, title = "Scalding Mornbrew Delivery", npc = 836, npcName = "Durnan Furcutter", map = 1429, x = 20.0, y = 60.0 } } },
		} })
		Polestar.Engine.SetGuide("test/timed")
		C_QuestLog.GetTimeAllowed = nil
		C_QuestLog.IsFailed = function(q) return w.log[q] and w.log[q].failed or false end
		stub.advance(0.5)
	end,
	settle = 0.3,
	probes = {
		-- A Kobold Vermin's tooltip: Kobold Camp Cleanup's line.
		["qol.questDB"] = function() return table.concat(sq.hoverUnit(6), " / ") end,
		["qol.questTooltips"] = function() return table.concat(sq.hoverUnit(6), " / ") end,
		["qol.questSellWarning"] = sale,
		["qol.nameplateIcons"] = plate,
		["qol.nameplateIconSide"] = { with = { ["qol.nameplateIcons"] = true }, value = "right", probe = plate },
		-- The quest log drawn: Kobold Camp Cleanup's title.
		["qol.questLevels"] = function() ql.updateLog(); return ql.logText(7) end,
		-- The delivery taken, five minutes on: a chat line (and a sound) with five minutes left.
		["qol.questTimerAlerts"] = function()
			local before = said("5 minutes left")
			w.accept(3364, {}, "Scalding Mornbrew Delivery")
			stub.advance(1.1)
			jump(299)
			local n = said("5 minutes left") - before
			w.abandon(3364)
			stub.advance(1.1)
			return n
		end,
		-- The auction house list opened (UI/AuctionBuys.lua): the line under its title, what the quests need from
		-- an auction house (nothing: a vendor sells the candles) or that the buys are off.
		["qol.auctionBuys"] = function()
			Polestar.UI.ShowAuctionBuys()
			local text = PolestarAuctionBuys.Hint:GetText()
			PolestarAuctionBuys:Hide()
			return text
		end,
	},
}
