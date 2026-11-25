'use strict';
// A button made plain and marked primary afterwards (W.Modal's action,
// addon/Polestar/Theme/Widgets.lua: psPrimary, then W.RepaintButton) wears
// the same paint as one made primary: the skin's primary ground (Hearth's
// flat accent plank, addon/Polestar/Theme/Looks/Hearth.lua; Lanterns' accent
// pill, addon/Polestar_Skins/Skins/Lanterns) and its label colour, in every look.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

function run(skin, addons) {
	return runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar', ...addons],
		script: `stub.login()
local Theme, W = Polestar.Theme, Polestar.Widgets
if Theme.LoadInstalledSkins then Theme.LoadInstalledSkins() end
Polestar.Set("ui.skin", ${JSON.stringify(skin)})
stub.advance(0.5)
assert(Theme.SkinId() == ${JSON.stringify(skin)}, "skin: " .. tostring(Theme.SkinId()))
local function r2(v) return v and math.floor(v * 100 + 0.5) / 100 or -1 end
-- What a button shows: its shown textures' colours (sorted), the label's.
local function look(b)
	local out = {}
	for _, t in ipairs({ b:GetRegions() }) do
		if t:IsShown() and t:GetObjectType() == "Texture" then
			local r, g, bb, a = t:GetVertexColor()
			out[#out + 1] = table.concat({ r2(r), r2(g), r2(bb), r2(a) }, ",")
		end
	end
	table.sort(out)
	local r, g, bb = b.Label:GetTextColor()
	out[#out + 1] = "label " .. table.concat({ r2(r), r2(g), r2(bb) }, ",")
	return table.concat(out, " | ")
end
local made = W.Button(UIParent, "Reload UI", function() end, { primary = true })
local later = W.Button(UIParent, "Reload UI", function() end)
later.psPrimary = true
W.RepaintButton(later)
emit({ made = look(made), later = look(later) })`,
	}).emitted[0];
}

for (const [skin, addons] of [['hearth', []], ['lanterns', [{ name: 'Polestar_Skins', files: ['Skins/Lanterns/Lanterns.lua'] }]], ['polestar', []]]) {
	test(`${skin}: a button marked primary after it was made wears the primary paint`, () => {
		const out = run(skin, addons);
		assert.equal(out.later, out.made);
	});
}
