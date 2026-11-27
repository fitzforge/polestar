'use strict';
// The Journey in the guide window's preview (addon/Polestar_Options/UI/Looks/
// GuideWindow.lua): its sample route takes a hotspot like the window's other
// parts (the pointer outlines it and names Journey style, a click opens that
// row) and lights with the Journey's rows, under Atlas folded on the card
// joined below the window as in Polestar's own layout. Against the real
// addon's modules and the fakes of tests/lua/stub_ui.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const preview = (layout) => runAddon({
	stubs: ['stub_world.lua', 'stub_ui.lua'],
	addons: ['Polestar', 'Polestar_Skins'],
	script: `Polestar.UI.LoadOptions()
		uistub.install()
		stub.login()
		Polestar.Set("nav.journeySteps", true)
		${layout ? `Polestar.Set("ui.skin", "atlas"); Polestar.Theme.SetLayout("atlas")` : ''}
		local UI = Polestar.UI
		local f = UI.GuideWindowPreview(UIParent)
		f:SetSize(420, 600)
		f:Layout(420, 600)
		stub.advance(0.5)
		local G = f.Scene.Copy
		local journey = G.journeySample and G.journeySample.frame
		local spot
		for _, b in ipairs(rawget(f, "psSpots") or {}) do if b.psSpot == journey then spot = b end end
		local P = UI.Preview
		local host = f
		emit({ journey = journey ~= nil, shown = journey ~= nil and journey:IsShown(), key = spot and spot.psKey or false,
			spotShown = spot ~= nil and spot:IsShown(), enter = spot ~= nil and spot:GetScript("OnEnter") ~= nil,
			atlasCard = journey ~= nil and journey:GetParent() ~= G.parts.body,
			style = P.LightUp(host, "guideWindow.journeyStyle"), steps = P.LightUp(host, "nav.journeySteps") })`,
}).emitted[0];

test("the Journey in the preview takes a hotspot for Journey style, in Polestar's own layout and under Atlas", () => {
	for (const atlas of [false, true]) {
		const out = preview(atlas);
		const where = atlas ? 'Atlas' : "Polestar's own";
		assert.equal(out.journey && out.shown, true, `${where}: the preview draws its sample Journey`);
		assert.equal(out.atlasCard, atlas, `${where}: ${atlas ? 'on the card joined below the window' : 'in the window'}`);
		assert.equal(out.key, 'guideWindow.journeyStyle', `${where}: the Journey has a hotspot naming Journey style`);
		assert.equal(out.spotShown && out.enter, true, `${where}: shown, and the pointer on it outlines it`);
		assert.ok(out.style >= 1, `${where}: the Journey style row lights it`);
		assert.ok(out.steps >= 1, `${where}: the Show the journey row lights it`);
	}
});
