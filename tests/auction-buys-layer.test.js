'use strict';
const { test } = require('node:test');
const { runAddon } = require('./helpers/lua');

test('the auction shopping list stays below bags when opened manually or docked', () => {
	runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar'],
		login: true,
		script: `
			local P = Polestar
			P.AuctionBuys.On = function() return true end
			P.AuctionBuys.List = function()
				return { { item = 4306, name = "Silk Cloth", need = 5, have = 0, quests = {} } }
			end

			P.UI.AuctionBuys.Show()
			local list = PolestarAuctionBuys
			assert(list:IsShown() and list:GetFrameStrata() == "LOW", "the floating list must sit below bag windows")

			P.UI.AuctionBuys.Hide()
			AuctionHouseFrame = CreateFrame("Frame", nil, UIParent)
			AuctionHouseFrame:Show()
			stub.fire("AUCTION_HOUSE_SHOW")
			stub.advance(0.1)
			local point, anchor, relativePoint = list:GetPoint()
			assert(list:IsShown() and list:GetFrameStrata() == "LOW", "the docked list must still sit below bag windows")
			assert(point == "TOPLEFT" and anchor == AuctionHouseFrame and relativePoint == "TOPRIGHT",
				"the list still docks beside the Auction House")

			stub.fire("AUCTION_HOUSE_CLOSED")
			assert(not list:IsShown(), "the docked list closes with the Auction House")
		`,
	});
});
