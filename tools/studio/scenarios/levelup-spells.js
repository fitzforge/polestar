'use strict';
// The level-up spell card and the old ranks card (UI/SpellCards.lua,
// QoL/Spells.lua; #1625): a Tauren Hunter levelling through the Barrens on
// the shipped guide, 55 steps in, dings 18 (four new spells: Multi-Shot,
// Serpent Sting 3, Aspect of the Hawk 2, Track Undead). Needs a checkout
// with QoL/ClassSpells.lua (--checkout <levelup-spells worktree>).

const TRAINED = [13550, 14318, 2643, 19884];

module.exports = {
	title: 'Level-up spells and old ranks (#1625)',
	character: { race: 'Tauren', cls: 'HUNTER', faction: 'Horde', level: 17, money: 13240 },
	place: { map: 1413, x: 51.6, y: 30.1, zone: 'The Barrens', subzone: 'The Crossroads' },
	guide: { id: 'forever/horde/02-the-barrens', play: 55, hours: 1.5 },
	// A level 17 hunter: every class spell up to 17, Auto Shot, Raptor Strike 1, Attack.
	spellbook: { trainerBelow: 18, extra: [75, 2973, 6603] },
	data: { classSpells: true },
	// The Horde pet quests are done by 18.
	completed: [6061, 6062, 6081, 6082, 6083, 6087, 6088, 6089, 94007, 94013, 94050, 94978, 94979],
	settings: { 'behavior.offerClassQuests': false },
	window: [1440, 690],
	capture: ['PolestarGuideFrame', 'PolestarClassToast', 'GameTooltip'],
	shots: {
		ding: {
			title: 'The ding with the data packs: the Shadowfang Keep heads-up comes first, the spells wait for it',
			lua: 'studio.ding(18)',
		},
		card: {
			title: 'That one answered: the spell card above the guide window (its training banner up)',
			lua: 'studio.ding(18)\nstudio.cardUntil("levelUp")',
		},
		'card-hover': {
			title: 'The same, Serpent Sting hovered (the game\'s tooltip, the training cost)',
			lua: 'studio.ding(18)\nstudio.cardUntil("levelUp")\nstudio.hover(Polestar.UI.ClassToast.SpellButton(2))',
		},
		'card-guide-stop': {
			title: 'The training banner answered (Later): the card names the guide\'s training stop',
			lua: `studio.ding(18)
studio.cardUntil("levelUp")
local GF = Polestar.UI.GuideFrame
if GF.BannerNotice and GF.BannerNotice() == "train" then GF.DismissBanner(true) end
local CT = Polestar.UI.ClassToast
if CT.current then CT.Hide() end
stub.advance(1)
Polestar.QoL.Spells.CheckLevel(18)
stub.advance(1)`,
		},
		ranks: {
			title: 'After training: Serpent Sting 2 and Aspect of the Hawk 1 still on the bars',
			lua: `stub.world.level = 18
studio.learn({ ${TRAINED.join(', ')} })
studio.bars({ [1] = 75, [2] = 13549, [3] = 14261, [4] = 1130, [5] = 14281, [6] = 13165, [7] = 5116, [8] = 1495, [9] = 2974 })
studio.clearHeadsUps()
Polestar.Fire("CLASS_TRAINED")
Polestar.QoL.Spells.CheckRanks(true)
stub.advance(1)`,
		},
		'ranks-hover': {
			title: 'The same, Serpent Sting 2 hovered (right-click keeps the rank)',
			lua: `stub.world.level = 18
studio.learn({ ${TRAINED.join(', ')} })
studio.bars({ [1] = 75, [2] = 13549, [3] = 14261, [4] = 1130, [5] = 14281, [6] = 13165, [7] = 5116, [8] = 1495, [9] = 2974 })
studio.clearHeadsUps()
Polestar.Fire("CLASS_TRAINED")
Polestar.QoL.Spells.CheckRanks(true)
stub.advance(1)
studio.hover(Polestar.UI.ClassToast.SpellButton(1))`,
		},
		'ranks-six': {
			title: 'Six old ranks: four lines, then "+2 more"',
			lua: `stub.world.level = 18
studio.learn({ ${TRAINED.join(', ')} })
studio.bars({ [1] = 75, [2] = 13549, [3] = 2973, [4] = 1130, [5] = 3044, [6] = 13165, [7] = 1978, [8] = 14260, [9] = 2974 })
studio.clearHeadsUps()
Polestar.Fire("CLASS_TRAINED")
Polestar.QoL.Spells.CheckRanks(true)
stub.advance(1)`,
		},
	},
};
