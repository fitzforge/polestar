'use strict';

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

test('quest buying offers cached auction items and prices only what is still needed', () => {
	const { emitted } = runAddon({
		stubs: ['stub_world.lua', 'stub_quests.lua'],
		addons: ['Polestar'],
		before: `
			local w = stub.world
			w.itemInfo[3712] = { name = "Turtle Meat", classID = 7, subclassID = 8 }
			w.itemInfo[769] = { name = "Chunk of Boar Meat", classID = 7, subclassID = 8 }
			w.itemInfo[3713] = { name = "Soothing Spices", classID = 7, subclassID = 8 }
			w.itemInfo[9998] = { name = "Bound Token", classID = 12, bind = 4 }
			quotes = { [769] = 35, [3713] = 165, [9998] = 100 }
			Auctionator = { API = { v1 = {
				GetAuctionPriceByItemID = function(caller, id)
					assert(caller == "Polestar")
					return quotes[id]
				end,
				RegisterForDBUpdate = function(caller, callback)
					assert(caller == "Polestar")
					updatePrices = callback
				end,
			} } }
		`,
		login: true,
		script: `
			local ns, w = Polestar, stub.world
			local AB, AU, E, Q = ns.AuctionBuys, ns.UI.AuctionBuys, ns.Engine, ns.QuestDB
			local goals = {
				{ t = "collect", quest = 555, item = 3712, count = 10, status = "active" },
				{ t = "collect", quest = 556, item = 769, count = 4, status = "active" },
				{ t = "collect", quest = 555, item = 3713, count = 1, status = "active" },
				{ t = "collect", quest = 555, item = 9998, count = 1, status = "active" },
				{ t = "buy", item = 3712, count = 10, only = { factions = { "Horde" } } },
			}
			local records = {
				[3712] = { "Turtle Meat", 1, 2408, 53, 0 },
				[769] = { "Chunk of Boar Meat", 1, 113, 80, 0 },
				[3713] = { "Soothing Spices", 0, 0, 2381 },
				[9998] = { "Bound Token", 1, 2408, 10, 0 },
			}
			Q.IsLoaded = function() return true end
			Q.ItemRecord = function(id) return records[id] end
			Q.HandsOver = function() return false end
			Q.GetQuestTitle = function(id) return id == 555 and "Soothing Turtle Bisque" or "Boar Meat" end
			E.GetGuide = function() return { id = "test/market", steps = { { goals = goals } } } end
			E.GetLiveStep = function() return 1 end
			E.Applies = function(_, i)
				return ns.Guides.Matches(goals[i].only, { faction = "Alliance" })
			end
			local function capture()
				AU.Show()
				local f = PolestarAuctionBuys
				local rows = {}
				for i, e in ipairs(AB.List("guide")) do
					rows[i] = { e.item, e.need, e.why, f.rows[i].Price:GetText() }
				end
				emit({ rows = rows, total = f.Total:GetText(), turtle = AU.CanBuyGoal(goals[1]) })
			end

			w.addItem(3712, 3)
			AB.Changed()
			capture()

			quotes[3712] = 210
			updatePrices()
			stub.advance(0.5)
			capture()

			ns.Materials.NoteSearch(3712, { { price = 200, quantity = 2 } })
			stub.advance(0.5)
			capture()
		`,
	});

	assert.deepEqual(emitted, [
		{ rows: [[769, 4, 'market', 'Auctionator estimate: 1s 40c']], total: 'Estimated total for remaining quest items: 1s 40c', turtle: false },
		{ rows: [[3712, 7, 'market', 'Auctionator estimate: 14s 70c'], [769, 4, 'market', 'Auctionator estimate: 1s 40c']], total: 'Estimated total for remaining quest items: 16s 10c', turtle: true },
		{ rows: [[3712, 7, 'market', '≈ 4s (5 still unpriced)'], [769, 4, 'market', 'Auctionator estimate: 1s 40c']], total: 'Partial estimate for remaining quest items: 5s 40c', turtle: true },
	]);
});

test('complete and turn-in goals surface item requirements in the guide and legacy auction UI', () => {
	const { emitted } = runAddon({
		stubs: ['stub_world.lua', 'stub_quests.lua'],
		addons: ['Polestar'],
		login: true,
		script: `
			local ns, w = Polestar, stub.world
			local E, Q, U = ns.Engine, ns.QuestDB, ns.UI
			local AB, GF, AU = ns.AuctionBuys, U.GuideFrame, U.AuctionBuys
			local function records(kind, first, last, lines)
				Q.AddChunk(kind, first, last, "\\n" .. table.concat(lines, "\\n") .. "\\n")
			end

			records("quests", 9011, 9013, {
				"9011\\t'Materials for supper;30;1;;;;;;;;;{2,3712,10,2,3713,1,1,2408,4",
				"9012\\t'Cloth delivery;30;1;;;;;;;;;{2,4306,3,2,9000,1",
				"9013\\t'Out of the guide;30;1;;;;;;;;;{2,769,4",
			})
			records("items", 769, 9000, {
				"769\\t'Chunk of Boar Meat;1;113;80;0",
				"3712\\t'Turtle Meat;1;2408;60;0",
				"3713\\t'Soothing Spices;0;0;2381",
				"4306\\t'Silk Cloth;1;5839;50;0",
				"9000\\t'Account Token;1;113;5;0",
			})
			Q.SetMeta({})
			w.itemInfo[769] = { name = "Chunk of Boar Meat", classID = 7 }
			w.itemInfo[3712] = { name = "Turtle Meat", classID = 7 }
			w.itemInfo[3713] = { name = "Soothing Spices", classID = 7 }
			w.itemInfo[4306] = { name = "Silk Cloth", classID = 7 }
			w.itemInfo[9000] = { name = "Account Token", classID = 15, bind = 7 }
			w.onQuest(9011, { { type = "item", required = 10, text = "Turtle Meat" } })
			w.onQuest(9012, { { type = "item", required = 3, text = "Silk Cloth" } })
			w.onQuest(9013, { { type = "item", required = 4, text = "Chunk of Boar Meat" } })
			w.addItem(3712, 3)

			local quotes = { [3712] = 210, [3713] = 165, [4306] = 195, [9000] = 500, [769] = 35 }
			Auctionator = { API = { v1 = {
				GetAuctionPriceByItemID = function(_, id) return quotes[id] end,
				MultiSearchAdvanced = function(caller, terms) emit({ caller = caller, search = terms[1] }) end,
			} } }
			ns.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
			ns.RegisterGuide({
				id = "test/auction-objectives", pack = "test", title = "Auction Objectives", minLevel = 1, maxLevel = 60,
				steps = {
					{ title = "Cook supper", goals = { { t = "complete", quest = 9011, title = "Materials for supper" } } },
					{ title = "Deliver the cloth", goals = { { t = "turnin", quest = 9012, title = "Cloth delivery" } } },
				},
			})
			E.SetGuide("test/auction-objectives")
			stub.advance(2)

			local rows = {}
			for _, e in ipairs(AB.List("guide")) do rows[#rows + 1] = { e.item, e.need } end
			emit(rows)
			local guideRow
			for _, row in ipairs(GF.rows) do
				if row:IsShown() and row.psGoal and row.psGoal.quest == 9011 then guideRow = row end
			end
			assert(guideRow and guideRow.Sub:IsShown(), "complete goal's subline is visible")
			emit(guideRow.Sub:GetText())
			emit(AU.CanBuyGoal({ t = "turnin", quest = 9012, status = "active" }))
			emit(AU.CanBuyGoal({ t = "kill", quest = 9011, status = "active" }))

			guideRow:Click("RightButton")
			for _, row in ipairs(PolestarMenu.rows) do
				if row:IsShown() and row.Text:GetText() == "Auction house buys" then row:Click(); break end
			end
			local f = assert(PolestarAuctionBuys)
			local function visibleRows()
				local out = {}
				for i, r in ipairs(f.rows) do if r:IsVisible() then out[#out + 1] = r.Title:GetText() end end
				return out
			end
			emit({ shown = f:IsVisible(), rows = visibleRows(), total = f.Total:GetText() })

			AuctionFrame = CreateFrame("Frame", "AuctionFrame", UIParent)
			stub.fire("AUCTION_HOUSE_SHOW")
			stub.advance(0.5)
			local _, dock = f:GetPoint()
			emit({ docked = dock == AuctionFrame, search = f.rows[1].Search:IsVisible(), go = f.Go:IsShown() })
			f.rows[1].Search:Click()

			Auctionator = nil
			AU.Layout()
			emit({ shown = f:IsVisible(), search = f.rows[1].Search:IsShown() })
			AuctionFrame:Hide()
			stub.fire("AUCTION_HOUSE_CLOSED")
			emit(f:IsShown())

			AuctionHouseFrame = CreateFrame("Frame", "AuctionHouseFrame", UIParent)
			function AuctionHouseFrame:SelectBrowseResult(result) emit({ native = result.itemKey.itemID }) end
			AuctionHouseFrameMixin = { Event = { CommoditiesQuantitySelectionChanged = "quantity" } }
			function AuctionHouseFrame:TriggerEvent(event, count) emit({ event = event, count = count }) end
			C_AuctionHouse = {
				MakeItemKey = function(id) return { itemID = id } end,
				GetItemKeyInfo = function() return {} end,
				GetNumCommoditySearchResults = function() return 1 end,
				GetCommoditySearchResultInfo = function() return { unitPrice = 200, quantity = 10 } end,
			}
			stub.fire("AUCTION_HOUSE_SHOW")
			stub.advance(0.5)
			local _, modernDock = f:GetPoint()
			emit({ docked = modernDock == AuctionHouseFrame, search = f.rows[1].Search:IsVisible() })
			f.rows[1].Search:Click()
			stub.fire("COMMODITY_SEARCH_RESULTS_UPDATED", 3712)
			stub.advance(0.5)

			C_PlayerInfo = C_PlayerInfo or {}
			C_PlayerInfo.IsSelfFoundActive = function() return true end
			AB.Changed()
			AU.Show()
			emit({ rows = visibleRows(), hint = f.Hint:GetText() })
		`,
	});

	assert.deepEqual(emitted, [
		[[3712, 7], [4306, 3]],
		'Optional: buy at the auction house (/polestar ah)',
		true,
		false,
		{ shown: true, rows: ['7 Turtle Meat', '3 Silk Cloth', '4 Chunk of Boar Meat'], total: 'Estimated total for remaining quest items: 21s 95c' },
		{ docked: true, search: true, go: false },
		{ caller: 'Polestar', search: { searchString: 'Turtle Meat', isExact: true, quantity: 7 } },
		{ shown: true, search: false },
		false,
		{ docked: true, search: true },
		{ native: 3712 },
		{ event: 'quantity', count: 7 },
		{ rows: {}, hint: 'The auction house is unavailable to Self-Found characters.' },
	]);
});
