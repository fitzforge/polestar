'use strict';
// Profession steps (UI/GuideFrameKindCraft.lua; docs/DESIGN.md, "A profession guide's window"): the shipped
// Blacksmithing 1-75 guide's first three steps for a level 8 Orc in Durotar (learn it, get the Rough Stone with its
// ways, craft Rough Sharpening Stones until 35) and Enchanting's first get step (Strange Dust: disenchant green
// armour or the Auction House; the window's line for the green items' levels shown as the generator is to write
// them, `gather Enchanting 1 levels 1-20`), in the house look and the game's, standard, Atlas and compact.
const skins = require('./skins');

const BLACKSMITHING = 164;
const MINING = 186;
const ENCHANTING = 333;

// The guide opened at its `n`th step, the skill as given (rank nil: not learned).
const OPEN = (guide, n, line, name, rank, extra = '') => `local w, E = stub.world, Polestar.Engine
${rank ? `w.learnSkill(${line}, ${JSON.stringify(name)}, ${rank}, 75)` : ''}
w.learnSkill(${MINING}, "Mining", 1, 75)
stub.fire("SKILL_LINES_CHANGED")
${extra}
E.SetGuide(${JSON.stringify(guide)})
stub.advance(2)
E.Goto(${n})
stub.advance(2)
studio.clearHeadsUps()
Polestar.UI.GuideFrame.Layout()
stub.advance(0.5)`;

// The green items' levels on the dust's gather goal, as the generator is to write them.
const DUST_LEVELS = `for _, s in ipairs(Polestar.Guides.Get("forever/professions/enchanting").steps) do
	for _, g in ipairs(s.goals or {}) do
		if g.t == "collect" and g.item == 10940 and type(g.gather) == "table" then g.gather.min, g.gather.max = 1, 20 end
	end
end`;

const STEPS = {
	'bs1-learn': ['Blacksmithing step 1: learn it (the trainer, the arrow); the skill line reads "Not learned yet"', OPEN('forever/professions/blacksmithing', 1, BLACKSMITHING, 'Blacksmithing', null)],
	'bs2-get': ['Blacksmithing step 2: Get 195 Rough Stone, Mine it (the loop) or Buy it at the Auction House', OPEN('forever/professions/blacksmithing', 2, BLACKSMITHING, 'Blacksmithing', 1)],
	'bs3-craft': ['Blacksmithing step 3: Craft Rough Sharpening Stone until 35, the skill-up arrow, the crafts to go, Open Blacksmithing', OPEN('forever/professions/blacksmithing', 3, BLACKSMITHING, 'Blacksmithing', 1, 'w.addItem(2835, 40)')],
	'ench-get': ['Enchanting: Get 52 Strange Dust, Disenchant green armour (Requires Level 1-20) or Buy it at the Auction House', OPEN('forever/professions/enchanting', 3, ENCHANTING, 'Enchanting', 1, DUST_LEVELS)],
	// Enchants make no item: the rows wear the spell's own icon.
	'ench-craft': ['Enchanting: Craft Enchant Bracer - Inferior Stamina until 25, the spell\'s icon (no item), the skill-up arrow, Open Enchanting', OPEN('forever/professions/enchanting', 4, ENCHANTING, 'Enchanting', 1, 'w.addItem(247786, 12)')],
	'ench-learn': ['Enchanting: Learn Enchant Chest - Inferior Stamina and Enchanted Lute at 25, each with its spell\'s icon', OPEN('forever/professions/enchanting', 5, ENCHANTING, 'Enchanting', 25)],
};

const LAYOUTS = {
	standard: '',
	atlas: `${skins.loadSkin('Polestar_Skins')}\nPolestar.Set("ui.layout", "atlas")\nstub.advance(0.5)`,
	compact: 'Polestar.Set("ui.compact", true)\nstub.advance(0.5)',
};

const shots = {};
for (const look of ['polestar', 'blizzard']) {
	for (const [layout, set] of Object.entries(LAYOUTS)) {
		for (const [step, [title, lua]] of Object.entries(STEPS)) {
			shots[`${step}-${look}-${layout}`] = {
				title: `${title} (${look}, ${layout})`,
				capture: layout === 'atlas' ? ['PolestarGuideFrame', 'PolestarGuideFrameCards'] : ['PolestarGuideFrame'],
				lua: `${skins.pick(look, null)}\n${set}\n${lua}`,
			};
		}
	}
}

// The recipe row hovered: the game's tooltip of the recipe (the enchant: link; a stand-in shows the spell's lines).
for (const look of ['polestar', 'blizzard']) {
	shots[`ench-craft-hover-${look}`] = {
		title: `Enchanting: the craft row hovered, the recipe's tooltip (${look})`,
		capture: ['PolestarGuideFrame', 'GameTooltip'],
		lua: `${skins.pick(look, null)}\n${STEPS['ench-craft'][1]}\nstudio.hover(Polestar.UI.GuideFrame.RegionFrame("stretch").Row)`,
	};
	shots[`ench-learn-hover-${look}`] = {
		title: `Enchanting: the learn row hovered, the recipe's tooltip (${look})`,
		capture: ['PolestarGuideFrame', 'GameTooltip'],
		lua: `${skins.pick(look, null)}\n${STEPS['ench-learn'][1]}\nlocal row\nfor _, r in ipairs(Polestar.UI.GuideFrame.rows) do if r:IsShown() and r.psGoal and r.psGoal.t == "learn" then row = r; break end end\nassert(row, "no learn row")\nstudio.hover(row)`,
	};
}

module.exports = {
	title: 'Profession steps: a learn, get and craft step and a disenchant get step, drawn as leveling rows (profession-steps)',
	character: { race: 'Orc', cls: 'WARRIOR', faction: 'Horde', level: 8, money: 50000 },
	place: { map: 1411, x: 52.0, y: 41.0, zone: 'Durotar', subzone: 'Razor Hill' },
	settings: { 'behavior.offerClassQuests': false, 'dungeons.headsUp': false },
	window: [1440, 690],
	stubs: skins.stubs,
	art: skins.art,
	// The client's own spell and item data, so the rows wear the game's icons: the enchants and the Enchanting guide's
	// materials (Copper Rod, Mote of Magic, Strange Dust, the Runed Copper Rod), the Rough Stone, and the professions' own
	// spells (Enchanting, Blacksmithing: the icon of the window's Open button without its words).
	data: { spells: [7411, 2018, 7418, 7420, 7421, 7771, 1230643], items: [2835, 6217, 6218, 10940, 247786] },
	capture: ['PolestarGuideFrame'],
	shots,
};
