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
			E.Applies = function() return true end
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
		{ rows: [[3712, 7, 'market', '≈ 4s (5 still unpriced)'], [769, 4, 'market', 'Auctionator estimate: 1s 40c']], total: 'Partial quest estimate: 5s 40c (1 items without a full quote)', turtle: true },
	]);
});
