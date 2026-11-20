'use strict';
// Polestar's experimental guides listed with ours (Core/Guides.lua, Guides.OWN_EXTRA; UI/Picker.lua): the
// guide menu's Leveling bands with the zones' guides among ours at their levels, each row with the small
// Forever mark (its tooltip in the -tip shots), and the selected one's details ("By Polestar ·
// Experimental", the purple Experimental chip beside its levels); and "Choose your path"
// (UI/RouteChoice.lua) where a guide of ours offers one, from the real guides and their experimental index
// (Engine.GetRouteChoice). Every look at UI scale 1.0, the default look at 0.64 and 1.5 too. No faction has an
// experimental guide left: the Riverglades and Shen'dralas are part of both routes (40-50/01b-riverglades,
// 40-50/shendralas), so a Horde Orc Hunter here sees them in Leveling 40-50 as route guides, without the mark
// or the chip, and no card offers them; the Alliance's Mount Hyjal (50-60/mount-hyjal) is experimental-guides-alliance.js. Render
// with the compiled packs (`forge guide compile` and `forge guide compile experimental` into a checkout given
// with --checkout): each shot returns what it showed, which polestar studio prints.

const skins = require('./skins');

const LOOKS = { polestar: ['polestar', null], hearth: ['hearth', null], forever: ['forever', null] };
// The guide window's place (ui.pos).
const WINDOW = [1440, 760];

// UI scale `s` on the studio's 1920x1080 screen (the default look's menus and choices at 0.64 and 1.5).
const SCALE = (s) => `UIParent:SetScale(${s})
function UIParent:GetWidth() return 1920 / ${s} end
function UIParent:GetHeight() return 1080 / ${s} end`;

// The cursor on the Forever mark of guide `select`'s row (the menu open as MENU leaves it). rawget: the stub
// answers any capitalised field of a frame with a method.
const TIP = (select) => `local function find(f)
	for _, c in ipairs({ f:GetChildren() }) do
		local m, g = rawget(c, "Forever"), rawget(c, "psGuide")
		if type(m) == "table" and c:IsShown() and m:IsShown() and g and g.id == ${JSON.stringify(select)} then return m end
		local hit = find(c)
		if hit then return hit end
	end
end
local mark = find(PolestarPicker)
if not mark then error("no Forever mark on " .. ${JSON.stringify(select)} .. "'s row") end
studio.hover(mark)
return GameTooltip and GameTooltip:IsShown() and "tooltip shown" or "NO tooltip"`;

// The guide menu on Leveling, every folder folded but `open` (folder ids, P.FolderOf's; after the menu opens,
// which unfolds the open guide's), `select` selected; the guide window and the arrow out of its frame.
const MENU = (open, select) => `local P = Polestar.UI.Picker
if PolestarNavArrow then PolestarNavArrow:Hide() end
if PolestarGuideFrame then PolestarGuideFrame:Hide() end
Polestar.UI.ShowPicker()
stub.advance(0.5)
P.SetView("browse")
P.SetCategory("Leveling")
local keep = {}
for _, id in ipairs(${JSON.stringify(open).replace('[', '{').replace(/]$/, '}')}) do keep[id] = true end
for _, e in ipairs(P.Entries("", "Leveling")) do
	if e.kind == "folder" then P.SetCollapsed(e.id, not keep[e.id]) end
end
P.Select(${JSON.stringify(select)})
P.Render()
stub.advance(0.5)
local out, folder = {}, nil
for _, e in ipairs(P.Entries("", "Leveling")) do
	if e.kind == "folder" then folder = e.id end
	if e.kind == "guide" and keep[folder] then
		local g = e.guide
		out[#out + 1] = folder .. ": " .. e.title .. " (" .. tostring(g.minLevel) .. "-" .. tostring(g.maxLevel) .. ")" .. (Polestar.Guides.IsExperimental(g) and " [Experimental]" or "")
	end
end
local credits = P.Credits(Polestar.Guides.Get(${JSON.stringify(select)}))
return table.concat(out, " | ") .. " || details: " .. tostring(credits)`;

// "Choose your path" at the end of guide `from`, at level `level`, as the Engine builds it.
const CHOICE = (from, level) => `local E = Polestar.Engine
stub.world.level = ${level}
if PolestarNavArrow then PolestarNavArrow:Hide() end
if PolestarGuideFrame then PolestarGuideFrame:Hide() end
E.PendingRouteChoice = function() return ${JSON.stringify(from)} end
Polestar.UI.ShowRouteChoice(${JSON.stringify(from)})
stub.advance(0.5)
local c = E.GetRouteChoice(${JSON.stringify(from)})
local out = {}
for _, o in ipairs(c and c.options or {}) do
	out[#out + 1] = o.id .. " " .. tostring(o.minLevel) .. "-" .. tostring(o.maxLevel) .. (o.recommended and " recommended" or "")
		.. (o.experimental and " experimental" or "") .. " quests " .. tostring(o.quests) .. " then " .. tostring(o.thenId)
end
return (PolestarRouteChoice and PolestarRouteChoice:IsShown() and "shown" or "NOT shown") .. ": " .. table.concat(out, " | ")`;

// faction: its character and place, its menu shots (name -> { open, select, title, tip? }) with the
// Forever mark's tooltip on the selected row (tip: false for a row without the mark), and its choices
// (name -> { from, level, title }), in every look; the default look's menus and choices at UI scales 0.64
// and 1.5 too.
function make({ title, character, place, menus, choices }) {
	const shots = {};
	for (const [look, [id, folder, variant]] of Object.entries(LOOKS)) {
		const base = skins.pick(id, folder, variant);
		for (const [name, m] of Object.entries(menus)) {
			const menu = MENU(m.open, m.select);
			shots[`${name}-${look}`] = { title: `${look}: ${m.title}`, lua: `${base}\n${menu}`, capture: ['PolestarPicker'] };
			// The menu's script ends in its return: the tooltip's runs in its place.
			const opened = menu.slice(0, menu.lastIndexOf('local out, folder'));
			if (m.tip !== false) {
				shots[`${name}-tip-${look}`] = { title: `${look}: ${m.title}; the Forever mark's tooltip on its row`, lua: `${base}\n${opened}\n${TIP(m.select)}`, capture: ['PolestarPicker', 'GameTooltip'] };
			}
			if (look !== 'polestar') continue;
			for (const s of ['0.64', '1.5']) {
				shots[`${name}-${look}-${s}`] = { title: `${look} at UI scale ${s}: ${m.title}`, lua: `${base}\n${SCALE(s)}\n${menu}`, capture: ['PolestarPicker'] };
			}
		}
		for (const [name, c] of Object.entries(choices)) {
			shots[`${name}-${look}`] = { title: `${look}: ${c.title}`, lua: `${base}\n${CHOICE(c.from, c.level)}`, capture: ['PolestarRouteChoice'] };
			if (look !== 'polestar') continue;
			for (const s of ['0.64', '1.5']) {
				shots[`${name}-${look}-${s}`] = { title: `${look} at UI scale ${s}: ${c.title}`, lua: `${base}\n${SCALE(s)}\n${CHOICE(c.from, c.level)}`, capture: ['PolestarRouteChoice'] };
			}
		}
	}
	return {
		title,
		character,
		place,
		settings: { 'behavior.offerClassQuests': false, 'dungeons.headsUp': false, 'nav.arrow': false },
		window: WINDOW,
		stubs: skins.stubs,
		art: skins.art,
		capture: ['PolestarPicker', 'PolestarRouteChoice'],
		LOOKS,
		shots,
	};
}

module.exports = make({
	title: "New zones in the Horde route: the guide menu's Leveling 40-50 with the Riverglades and Shen'dralas as route guides (no Forever mark, no Experimental chip)",
	character: { race: 'Orc', cls: 'HUNTER', faction: 'Horde', level: 43, money: 412000 },
	place: { map: 1418, x: 4.1, y: 44.9, zone: 'Badlands', subzone: 'Kargath' },
	menus: {
		'menu-4050': {
			title: 'Leveling, Horde 40-50: the Riverglades (40-45) among the route\'s guides, selected',
			open: ['Leveling/Horde/40'], select: 'forever/horde/40-50/01b-riverglades', tip: false,
		},
		'menu-4050-shendralas': {
			title: "Leveling, Horde 40-50: Shen'dralas (43-45) among the route's guides, selected",
			open: ['Leveling/Horde/40'], select: 'forever/40-50/shendralas', tip: false,
		},
	},
	choices: {},
});
module.exports.make = make;
