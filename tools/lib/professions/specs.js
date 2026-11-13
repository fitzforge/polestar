'use strict';
// What the crafting guides (guide.js) say beyond the plan: per profession the
// header paragraphs (what it makes, what to pair it with, Forever's changes,
// specialisations), recipes left out of the plan by hand, a reason per
// recipe, the skill-20 camp recipe, and notes at a skill (specialisation
// quests). Facts come from Forever's data first (professions.json, quests.json,
// npcs.json, the world DB's sniffed trainer and vendor rows); research notes
// with their sources: ~/work/ProfGuides/bench-<profession>.md (internal).
//
//   intro:   [paragraph]            header comment paragraphs
//   apprentice: text                added to the first trainer step
//   camp:    { spell | spells: [{ spell, only }], at, tip }
//                                   Forever's camp recipe, learned at the first
//                                   trainer visit at skill `at` or more
//   exclude: { spell: reason }      recipes the planner must not use
//   noLevel: { spell: reason }      recipes made only as parts or tools
//   tips:    { spell: text }        why this recipe (replaces the generic line)
//   taughtBy: { spell: rank }       recipes only that rank's trainers teach: the
//                                   learn is pinned to them, and the rank is
//                                   offered there when the skill allows it
//   notes:   [{ at, text }]         added to the craft step that holds skill `at`
//   questRecipes: { spell: quest }  plans a quest hands over (the data has no quest rewards): the
//                                   planner uses them from the quest's skill, pricing its hand-in
//   assumed: [text]                 extra ASSUMED / INGAME header lines
//   rankCost: { rank: copper }      a rank's price where Forever's lists have none
//                                   (Classic's, said so in the guide)
//   last:    text                   the tip past the plan's reach
//   to:      skill                  where the plan stops (the rest is `last`)
//   notBefore: { spell: skill }    recipes used (to level or for an intermediate) only from
//                                   that skill on: a cloth the character cannot farm yet
//   lastRoute: text                 the route table's line past the plan's reach

const CAMPING_101 = (prof) =>
	`The Camping 101: ${prof} quest from your starting area's camping guide (after The Great Outdoors) sends you to ${/^[aeiou]/i.test(prof) ? 'an' : 'a'} ${prof.toLowerCase()} trainer who teaches it free.`;

const FAVOR = 'Merchant\'s Favor is a currency from the supply crates turned in at the camps, not gold; its patterns bind when picked up.';

const SPECS = {
	Alchemy: {
		intro: [
			'Alchemy turns herbs into elixirs, potions and oils. Herbalism is its partner: every reagent below is a herb, a vial from an alchemy or trade supplies vendor, or (three times) a fish.',
			"Forever's changes: the healing potions moved to First Aid. Alchemy keeps a Discolored healing line that needs a Murloc Eye per potion (a drop) and has no confirmed learn skill, so this route leaves it out. New: Minor Arcane Elixir and Elixir of Minor Force (orange to 10), Elixir of Minor Fortitude at 50 (trainer), Cerulean Dye and Sulfuric Acid at 40 (Frilled Lichen and Pyrite are scarce finds while gathering), Magenta and Viridian Dye, and dozens of new elixirs that are only five points wide or sold for Merchant's Favor by Apothecary Durelle near the Crossroads. Several Classic recipes kept their spell but changed name: Elixir of Lion's Strength is Elixir of Minor Strength, Elixir of Greater Defense is Elixir of Defense, Elixir of Superior Defense is Elixir of Greater Defense, Elixir of Detect Undead is Draught of Detect Undead.",
			'Camping: Mana Well (skill 20) is the Alchemy camp item. The Fermenter (skill 140) is a camp station from a blueprint that Rath\'mael drops in the Ruins of Lordaeron; Shadow Oil, Frost Oil, Goblin Rocket Fuel, Ghost Dye and Viridian Dye need it, so this route leaves them out. The skill-300 Alchemy Laboratory (flasks) has no known blueprint source yet.',
			'Ranks: trainers teach by tier and train only from their tier\'s skill: Journeyman at the city trainers, from skill 50; Expert only at Ainethil (Darnassus) and Doctor Herbert Halsey (Undercity), from 125; Artisan only at Kylanna Windwhisper (Feathermoon Stronghold, Feralas) and Rogvar (Stonard, Swamp of Sorrows), from 200. Alchemy has no specialisation. Transmutes and the Philosopher\'s Stone come from Alchemist Pestlezugg in Gadgetzan.',
			"The route keeps to trainer recipes from 75 to 265. Holy Protection Potion (100) and Shadow Protection Potion (135) would cost about the same, but their recipes come from limited-stock sellers (Kzixx, Xandar Goodbeard and Hula'mahi; Harklan Moongrove and Christoph Jeffcoat) and bind when picked up, and Holy Protection takes a Swiftthistle per craft, a find on about two Briarthorn in five.",
		],
		apprentice: 'Pair it with Herbalism: Peacebloom and Silverleaf grow in every starting zone, and Empty Vials cost 4c at any alchemy or trade supplies vendor.',
		camp: { spell: 1230564, at: 20, tip: `Also learn Mana Well (1s): Forever's Alchemy camp item, 1 Peacebloom and 1 Empty Vial, placed at a campsite beside a campfire for its buff. ${CAMPING_101('Alchemy')}` },
		// Classic's trainer lists (the world DB's per-trainer rows): Journeyman 4s 50c,
		// Expert 50s, Artisan 4g 50s. Forever's sniffed lists price only Apprentice (10c, as Classic).
		rankCost: { Journeyman: 450, Expert: 5000, Artisan: 45000 },
		assumed: ["ASSUMED: rank prices Journeyman 4s 50c, Expert 50s and Artisan 4g 50s (Classic's trainer lists; Forever's sniffed lists price only Apprentice, 10c as in Classic). In-game check: what each rank costs."],
		exclude: {
			1244645: 'a Murloc Eye per craft (drop only) and no confirmed learn skill',
			1244646: 'a Murloc Eye per craft (drop only) and no confirmed learn skill',
			1244647: 'a Murloc Eye per craft (drop only) and no confirmed learn skill',
			1244648: 'a Murloc Eye per craft (drop only) and no confirmed learn skill',
			6617: "a Sharp Claw per craft (a beast drop): the herbalist's route keeps to herbs",
			6618: "a Large Fang per craft (a beast drop): the herbalist's route keeps to herbs",
			// Both need a limited-stock recipe that binds when picked up, a trip to its
			// seller, and cost the same as the trainer recipes that replace them (Elixir of
			// Wisdom, Lesser Troll's Blood Elixir, Mana Potion: about 22.6g against 21.6g).
			7255: "a limited-stock recipe that binds when picked up, and a Swiftthistle per craft (a find on two Briarthorn in five): about 150 Briarthorn for 58 crafts; the trainer's Elixir of Wisdom covers the same points",
			7256: "a limited-stock recipe that binds when picked up (Harklan Moongrove in Ashenvale, Christoph Jeffcoat in Tarren Mill); the trainer's Lesser Troll's Blood Elixir and Mana Potion cover the same points",
		},
		tips: {
			7183: 'Known from the start and the cheapest way through the Apprentice range. Keep the elixirs (armour while you level) or sell them.',
			2331: 'The trainer teaches it from 25. It is yellow already, so count on about two crafts a point until Elixir of Wisdom takes over at 90. Mageroyal grows in the 10-25 zones.',
			3171: 'Two Briarthorn and a Mageroyal a craft, both from the 10-25 zones; orange to 120.',
			3176: 'Two Bruiseweed and two Briarthorn a craft; Bruiseweed grows in the 15-30 zones.',
			3452: 'Stranglekelp grows under water along the coasts: bring a water breathing elixir or come up for air. Kingsblood grows in the 20-40 zones.',
			11450: 'Wild Steelbloom and Goldthorn are the herbs of the 30-45 zones (Stranglethorn, Arathi, the Badlands).',
			11460: "Arthas' Tears grow in the Plaguelands and Felwood (Herbalism 220); Crystal Vials come from alchemy vendors.",
			17554: 'Stonescale Eel comes from the Stonescale Eel schools on the coasts of the 40-55 zones, or the Auction House (fishers sell them in stacks). Sungrass grows in the 40-55 zones.',
		},
	},

	Blacksmithing: {
		intro: [
			'Blacksmithing hammers bars into plate and mail, weapons, keys, rods, and the sharpening, weight and grinding stones the later recipes eat. Mining is its partner: every bar is smelted from ore, and the stones come straight from the veins. A Blacksmith Hammer must be in your bags, and almost every recipe needs an anvil (towns and forges have them).',
			"Forever's changes: almost every plan was moved 25 points down. It turns yellow, green and grey 25 points sooner, and trainers teach it 25 points earlier (Runed Copper Belt from 45, Heavy Grinding Stone from 100), so a Classic route crafts grey recipes in about nine places. Copper Rod (for enchanters) is now Blacksmithing. Many new plans arrive in sets keyed to a gem or dust; most of them are sold for Merchant's Favor by Gor'mak near the Crossroads and Stondry Darkhammer at Three Corners (Redridge), and their later pieces need Sandpaper (Engineering) and Sulfuric Acid (Alchemy). " + FAVOR + ' This route leaves them out.',
			'Camping: Sharpening Wheel (skill 20) is the Blacksmithing camp item. The Anvil (skill 140) is a camp station from a blueprint Gilnid drops in the Deadmines. The skill-300 Master Forge has no known blueprint source, and about 60 late plans need it.',
			'Ranks: Journeyman needs character level 10 (Forever\'s sniffed lists). Trainers teach by tier and train only from their tier\'s skill: Journeyman at the city trainers, from skill 50; Expert only at Bengus Deepforge (Ironforge) and Saru Steelfury (Orgrimmar), from 125; Artisan only at Brikk Keencraft (Booty Bay), from 200. Specialisation at 200 and level 40: Armorsmith (Grumnus Steelshaper, Ironforge / Okothos Ironrager, Orgrimmar) or Weaponsmith (Ironus Coldsteel, Ironforge / Borgosh Corebender, Orgrimmar), with the axe, hammer and sword masters in Everlook at 250 and level 50.',
		],
		// Derotain Mudsipper (Gadgetzan) trades the Imperial Plate plans for Thorium Bars after A Blue
		// Light Bargain (7652): the Forever quest pages name these rewards; the data has no rewards.
		questRecipes: { 16647: 7653, 16657: 7654, 16649: 7655 },
		// Classic's trainer lists (world DB, VB 0) teach these, which asked 230-235 there (above Expert's 225), at
		// Brikk Keencraft (1002836) only, never at Bengus Deepforge or Saru Steelfury (1004258/1003355). Forever
		// moved the plans 25 points down but not off the Artisan list: at 205 Saru teaches no Heavy Mithril
		// Breastplate (#1956, the reporter's trainer window).
		taughtBy: { 9959: 'Artisan', 9961: 'Artisan', 9968: 'Artisan', 10001: 'Artisan' },
		// Expert 50s (a Forever beta guide tested to 225; Classic's list asks 45s), Artisan 5g (Classic's list).
		rankCost: { Expert: 5000, Artisan: 50000 },
		assumed: [
			"ASSUMED: Derotain Mudsipper's Imperial Plate quests ask Blacksmithing 265 and character level 50 (Forever's quest data, as in Classic, though Forever moved the plans themselves 25 points down to 240-270). In-game check: the skill his quests ask; a lower one lets the Imperial Plate Bracers (orange to 265) take over from the battleaxe sooner.",
			"ASSUMED: rank prices Expert 50s and Artisan 5g (Classic's trainer lists; Forever's sniffed lists price only Apprentice 10c and Journeyman 5s, as in Classic). In-game check: what Expert and Artisan cost.",
		],
		apprentice: 'Buy a Blacksmith Hammer (any blacksmithing supplier) and pair it with Mining: Rough Stone and Copper Ore come from the Copper Veins of every starting zone.',
		camp: { spell: 1230171, at: 20, tip: `Also learn Sharpening Wheel (1s): Forever's Blacksmithing camp item, 1 Rough Stone and 1 Copper Bar, placed at a campsite beside a campfire for its buff. ${CAMPING_101('Blacksmithing')}` },
		tips: {
			2660: 'One Rough Stone a craft, a point every craft to 15.',
			3320: 'Two Rough Stone a craft. Grinding stones are parts for later plans; the extras sell to vendors.',
			2666: 'Forever teaches Runed Copper Belt from 45; it stays orange to 85. Ten Copper Bars a craft: smelt your Copper Ore.',
			2674: 'Heavy Stone comes from Iron Deposits; one a craft.',
			2672: 'Each bracer takes two Coarse Grinding Stones (Coarse Stone from Tin Veins): make them first; they give points too.',
			3501: 'Six Iron Bars and a Green Dye a craft; Green Dye comes from tailoring, leatherworking and trade supplies vendors. Orange to 165 on Forever, so a point every craft for the first fifteen.',
			9918: 'One Solid Stone a craft (Mithril Deposits): cheap points between the iron and the steel bracers. Use the stones on your weapons or sell them.',
			7223: 'Steel Bars are smelted from an Iron Bar and a Coal (Mining 165; Coal from trade and blacksmithing suppliers), so each bracer is five of each. Each bracer takes two Heavy Grinding Stones: make them first.',
			9959: 'Sixteen Mithril Bars a craft and nothing else; orange to 225 on Forever, so a point every craft to the Artisan cap.',
			16640: 'One Dense Stone a craft (Thorium veins): cheap points at the start of Artisan.',
			9968: 'Mithril Bars from Mithril Deposits; Thick Leather from skinners or the Auction House.',
			10001: 'Only about 11 crafts to bridge 247-250, but each wants four Shadowgems (about one Tin Vein in a hundred) and a Black Pearl: buy those at the Auction House unless your bags already hold them.',
			16969: 'Large Opal turns up in about one Thorium vein in 130: buy the ten at the Auction House. Five crafts only, until the battleaxe plans can be used at 255.',
			16971: 'Plans from Magnus Frostwake (Caer Darrow, Western Plaguelands), unlimited stock, but they bind when picked up. Forty Thorium Bars and six Dense Grinding Stones a craft: the dearest stretch, so stop where the Imperial Plate Boots take over. Other ways through: world-drop plans from the Auction House (the Radiant pieces: about 820 Thorium Bars and 190 Hearts of Fire for the Radiant route) or the Merchant\'s Favor sets.',
			16657: 'About 34 Thorium Bars a craft against the battleaxe\'s 40 and its grinding stones, orange to 290. Below character level 50 Derotain has no quest for you: keep making Huge Thorium Battleaxes to 300 instead (yellow to 292, grey at 305: about twice the Thorium Bars).',
		},
		notes: [
			{
				at: 200,
				text: 'Specialisation (optional): at 200 and character level 40, Grumnus Steelshaper (Ironforge) or Okothos Ironrager (Orgrimmar) starts The Art of the Armorsmith: 4 Ornate Mithril Helms, 2 Ornate Mithril Boots and an Ornate Mithril Breastplate, whose plans come from a Mithril Order quest chain. Ironus Coldsteel (Ironforge) or Borgosh Corebender (Orgrimmar) starts The Way of the Weaponsmith: 4 Moonsteel Broadswords, 4 Massive Iron Axes, 2 Heavy Mithril Axes and 2 Big Black Maces; on Forever the Moonsteel Broadsword plans (Zarena Cromwind, Booty Bay) and Massive Iron Axe plans bind when picked up, so buy and use them yourself. You can take only one; neither is needed for 300, and the beta never tested them (it stopped at level 30).',
			},
		],
	},

	Enchanting: {
		intro: [
			'Enchanting turns magic items into enchanting materials (Disenchant: any green or better item gives dust, essence or a shard by its level) and puts enchantments on gear. It needs no gathering profession: the dust and essence come from disenchanting what you loot, or from the Auction House. Each tier needs a runed rod in your bags (Copper, Silver, Golden, Truesilver, Arcanite); the rod bases come from blacksmiths or trade vendors.',
			"Forever's changes: the first levels run on Mote of Magic, 10c at enchanting supply vendors with no stock limit. Runed Copper Rod is a Copper Rod and 1 Mote; Bracer - Inferior Stamina (Classic's Minor Health) takes 1 Mote and goes grey at 25; Dust to Motes turns 1 Strange Dust into 3 Motes. Strange Dust and Lesser Magic Essence are still sold, but only 1 to 4 at a time, so this route runs on the Strange Dust that low-level greens break into (Chest - Inferior Stamina, then Cloak - Minor Protection). Several later formulas need fewer materials (Runed Silver Rod: 3 Strange Dust and 4 Lesser Magic Essence). New formulas for caster weapons, relics and necklaces are sold for Merchant's Favor by Beneris near the Crossroads. " + FAVOR,
			'Camping: Enchanted Lute (skill 20) is the Enchanting camp item. The Arcane Salvager (skill 140, blueprint from Rath\'mael, Ruins of Lordaeron) improves disenchanting at a camp and needs the Runed Truesilver Rod; the skill-300 Arcane Forge has no known blueprint source.',
			'Ranks: trainers teach by tier and train only from their tier\'s skill: Journeyman at the city trainers, from skill 50; Expert only at Kitta Firewind (Tower of Azora, Elwynn Forest) and Hgarth (Sun Rock Retreat, Stonetalon Mountains), from 125. Artisan is taught only by Annora inside Uldaman: enter by the back door (Badlands), clear the scorpids in her room until she appears, and learn every formula up to 250 on that visit. The new starter quests An Enchanting Lesson (Kitta Firewind, Alliance) and A Pain in the Neck (Pa\'zula, Sen\'jin Village, Horde) teach Disenchant on a quest item. Enchanting has no specialisation.',
		],
		apprentice: "Buy a Copper Rod and Mote of Magic from an enchanting supplies vendor (in the capitals and on Zephras Isle; the starting-area trainers have none beside them, and the next step's arrow picks the nearest). From now on, disenchant every green you do not wear: that is where the dust and essences come from. Two starter quests teach Disenchant on a quest item: An Enchanting Lesson from Kitta Firewind (Tower of Azora, Elwynn Forest) and A Pain in the Neck from Pa'zula (Sen'jin Village, Durotar).",
		camp: { spell: 1230643, at: 20, tip: `Also learn Enchanted Lute (1s): Forever's Enchanting camp item, 1 Simple Wood and 1 Strange Dust, placed at a campsite beside a campfire for its buff. ${CAMPING_101('Enchanting')}` },
		// Classic's trainer lists: Journeyman 5s, Expert 50s, Artisan (Annora) 5g.
		rankCost: { Journeyman: 500, Expert: 5000, Artisan: 50000 },
		assumed: ["ASSUMED: rank prices Journeyman 5s, Expert 50s and Artisan 5g (Classic's trainer lists; Forever's sniffed lists price only Apprentice, 10c as in Classic). In-game check: what each rank costs."],
		tips: {
			7418: 'One Mote of Magic (10c) a craft; grey at 25 on Forever.',
			7420: 'One Strange Dust a craft: the dust most level 5-20 greens break into, armour above all. Lesser Magic Essence (from weapons) does the same job through Bracer - Minor Deflect or Chest - Minor Absorption if you have more of it.',
			7771: 'Two Strange Dust a craft (the trainer teaches it from 70 for 2s); keep disenchanting the greens of the 10-20 zones.',
			13501: 'One Soul Dust a craft (level 21-30 greens).',
			13637: 'Soul Dust again.',
			13746: 'One Vision Dust a craft (level 31-40 greens).',
			13815: "Annora teaches it with Artisan: learn it on that visit. Vision Dust again; bring about 40.",
			25127: 'One Dream Dust (level 41-50 greens) and one Purple Lotus (herbalists) a craft; the oil sells well. Kania sells the formula at the inn of Cenarion Hold (Silithus): fly there, the mobs around it are level 55 and up.',
			20017: 'Six Dream Dust a craft: the dearest stretch, so disenchant every level 41-50 green you find.',
		},
	},

	Engineering: {
		intro: [
			'Engineering builds bombs, guns, goggles, scopes and gadgets from parts it makes itself: blasting powder from stone, bolts and tubes from bars. Mining is its partner. Keep a Blacksmith Hammer and the Arclight Spanner (made at 57) in your bags; most recipes need an anvil. Goggles and scopes also want a Gyromatic Micro-Adjustor (from 175, 4 Steel Bars), which this route never needs.',
			"Forever's changes: the colours and learn skills are Classic's, so a Classic order works, but Gnomes no longer get +15 Engineering (Forever's client changed the racial). A few reagents changed (Rough Dynamite takes one powder; EZ-Thro Dynamite needs an EZ-Thro Wrap). New SAF-T and EZ-Thro schematics are sold for Merchant's Favor by Fizzlefuse near the Crossroads and Fritz Fizzle at Three Corners (Redridge); Sandpaper (Bauxite from Gold Veins) feeds blacksmiths' plans. " + FAVOR + ' Many late schematics (Thorium Tube, Accurate Scope, Deadly Scope) now bind when picked up.',
			'Camping: Reagent Bot (skill 20) is the Engineering camp item; you learn it at 20 but its parts come at 30 and 50, so it gives no points. The Repair Bot (skill 140) comes from a blueprint Sneed drops in the Deadmines; the skill-300 Anarchist\'s Workbench has no known source.',
			'Ranks: trainers teach by tier and train only from their tier\'s skill: Journeyman at the city trainers, from skill 50; Expert only at Springspindle Fizzlegear (Ironforge) and Roxxik (Orgrimmar), from 125; Artisan only at Buzzek Bracketswing (Gadgetzan), from 200. Specialisation at 200 and level 30: Gnomish (Tinkmaster Overspark, Ironforge / Oglethorpe Obnoticus, Booty Bay) or Goblin (Nixx Sprocketspring, Gadgetzan).',
		],
		apprentice: 'Buy a Blacksmith Hammer and pair it with Mining: Rough Stone and Copper Ore are the first parts.',
		camp: { spell: 1230656, at: 20, tip: `Also learn Reagent Bot (1s): Forever's Engineering camp item, placed at a campsite beside a campfire. It takes a Handful of Copper Bolts and a Copper Tube, which you learn at 30 and 50, so it gives no points. ${CAMPING_101('Engineering')}` },
		noLevel: { 12590: 'a tool you need once (the goggles and scopes)' },
		// Classic's trainer lists (world DB 1001676/1005174/1008736, VB 0) ask 4s 50c, 45s and 4g 50s;
		// Forever's Blacksmithing Journeyman (sniffed) and Expert (a beta guide) cost 5s and 50s.
		rankCost: { Journeyman: 500, Expert: 5000, Artisan: 45000 },
		assumed: ["ASSUMED: rank prices Journeyman 5s, Expert 50s and Artisan 4g 50s (Classic's trainer lists and Forever's Blacksmithing ranks; Forever's sniffed lists price only Apprentice, 10c as in Classic). In-game check: what each rank costs."],
		tips: {
			3918: 'One Rough Stone a craft; Rough Stone comes with the Copper Ore from Copper Veins.',
			3922: 'One Copper Bar a craft. Keep the bolts: Practice Locks and later gadgets take them.',
			3924: 'Two Copper Bars and a Weak Flux a craft (blacksmithing and engineering suppliers).',
			3930: 'The Coarse Blasting Powder in each gives its own point while it is not grey: two chances a craft. Sell the shot to hunters or a vendor.',
			9271: 'Nightcrawlers come from trade and fishing suppliers; the attractors sell to fishermen.',
			3967: 'A Silver Bar makes five Silver Contacts (grey by now: no points, but no trip to a vendor either); the Heavy Blasting Powder comes from Heavy Stone. Each craft makes two bombs.',
			3923: 'Make the bolts and powder first; they give points too.',
			3929: 'One Coarse Stone a craft (Tin Veins).',
			3926: 'Make the Arclight Spanner first (Copper Bars): it stays in your bags from now on.',
			8334: 'Practice Locks sell to rogues, or open them yourself.',
			3945: 'One Heavy Stone a craft (Iron Deposits). Keep some: Iron Grenades take one each.',
			3942: 'Whirring Bronze Gizmos are parts for the later scopes and guns.',
			3953: 'Bronze Frameworks are parts for later gadgets; the extras sell to vendors.',
			12585: 'Two Solid Stone a craft (Mithril Deposits). Make plenty: the triggers, slugs and Gyro-Shot all use it.',
			3962: 'Uses the Heavy Blasting Powder you kept.',
			12591: 'Unstable Triggers are parts for the late bombs.',
			12596: 'One Mithril Bar and one Solid Blasting Powder a craft; hunters buy the slugs.',
			12621: 'Two Mithril Bars and two Solid Blasting Powder a craft.',
			19791: 'Three Thorium Bars and a Runecloth a craft; the widgets are parts for the later Thorium gadgets.',
			19795: 'The schematic binds when picked up; six Thorium Bars a craft.',
		},
		notes: [
			{
				at: 200,
				text: 'Specialisation (optional): at 200 and character level 30, Springspindle Fizzlegear (Ironforge), Lilliam Sparkspindle (Stormwind), Graham Van Talen (Undercity) or Tinkerwiz (Ratchet) sends you to Gnomish Engineering (Tinkmaster Overspark, Ironforge, or Oglethorpe Obnoticus, Booty Bay: 6 Mithril Tubes, an Accurate Scope and 2 Advanced Target Dummies) or Goblin Engineering (Nixx Sprocketspring, Gadgetzan: 20 Big Iron Bombs, 20 Solid Dynamite and 5 Explosive Sheep). The Accurate Scope schematic now binds when picked up, but the quest takes a scope someone else made. The membership card lasts 14 days of play; renewing it costs 2g. You can take only one; neither is needed for 300, and the beta never tested them (it stopped at level 30).',
			},
		],
	},

	Leatherworking: {
		intro: [
			'Leatherworking turns the leather and hides that Skinning gives into armor kits, leather and mail armour, quivers and ammo pouches, and cures hides with Salt. Skinning is its partner. Thread, Salt and dyes come from leatherworking and trade supplies vendors.',
			"Forever's changes: nearly every pattern moved 25 points down: trainers teach it 25 points earlier (Embossed Leather Gloves at 40, Fine Leather Belt at 55, Heavy Leather at 125) and it greys 25 points sooner. Spell 2167 is now Gray Leather Boots; Forever's Dark Leather Boots is a new pattern at 35. Many 125-225 patterns, Cured Rugged Hide and the specialisation patterns need a Tanning Rack, a camp station from a blueprint Razorclaw the Butcher drops in Shadowfang Keep; no town has one, so this route leaves them out. The 270+ dungeon patterns need a Sewing Machine (no known blueprint source). New stat sets and the Forceful Thick Armor Kit are sold for Merchant's Favor by Pawani near the Crossroads and Daniel Stitchsong at Three Corners (Redridge). " + FAVOR,
			'Camping: Camp Tent (skill 20, 5 Light Leather) is the Leatherworking camp item and still gives points until 25. Tanning Rack (125 since Forever\'s 2026-11-06 hotfixes) and Sewing Machine (300) as above.',
			'Ranks: Journeyman needs character level 10 (Forever\'s sniffed lists). Trainers teach by tier and train only from their tier\'s skill: Journeyman at the city trainers, from skill 50; Expert only at Telonis (Darnassus) and Una (Thunder Bluff), from 125; Artisan only at Drakk Stonehand (Aerie Peak, the Hinterlands) and Hahrana Ironhide (Camp Mojache, Feralas), from 200. Specialisation at 225 and level 40: Dragonscale (Peter Galen, Azshara / Thorkaf Dragoneye, Badlands), Elemental (Sarah Tanner, Searing Gorge / Brumn Winterhoof, Arathi Highlands) or Tribal (at 235: Caryssia Moonhunter, Feralas / Se\'Jib, Stranglethorn Vale).',
		],
		apprentice: 'Pair it with Skinning: Light Leather comes from the beasts of every starting zone. Coarse Thread and Salt are sold by leatherworking and trade supplies vendors.',
		camp: { spell: 1229432, at: 20, tip: `Also learn Camp Tent (1s): Forever's Leatherworking camp item, 5 Light Leather, placed at a campsite beside a campfire. ${CAMPING_101('Leatherworking')}` },
		tips: {
			2152: 'One Light Leather a craft; the kits sell to vendors.',
			3756: 'Forever teaches Embossed Leather Gloves from 40.',
			3763: 'Forever teaches Fine Leather Belt from 55.',
			9074: 'Each takes an Elixir of Minor Agility: an alchemist makes it from a Swiftthistle and a Silverleaf, and the Auction House has it cheap. With no elixirs, take Fine Leather Belt on to 105 and Dark Leather Cloak (from 85: 8 Medium Leather, a Gray Dye and a Fine Thread) to 125: about 28 cloaks, 224 Medium Leather in all.',
			3780: 'Five Heavy Leather a craft (beasts of level 28-40); the kits sell to vendors.',
			20650: 'Six Heavy Leather make one Thick Leather, orange until 175: keep them, the Thick Armor Kits next use them.',
			10487: 'Five Thick Leather a craft; the kits sell to vendors.',
			22331: 'Rugged Leather from Thick Leather: the points come cheap and you need the Rugged Leather next.',
			19058: 'Five Rugged Leather a craft.',
			19049: 'Eight Rugged Leather a craft; Black Dye and Rune Thread from leatherworking or tailoring vendors.',
			19082: '14 Rugged Leather and 10 Runecloth a craft: the dearest stretch.',
		},
		// Classic's trainer lists (world DB 1011097/1011098, VB 0) put these on the
		// Artisan trainers only; Telonis and Una (1004212/1003007) never teach them.
		// The Nightscape and Turtle Scale pieces asked 230-235 in Classic, above
		// Expert's 225: Forever moved them 25 points down, not off the Artisan list
		// (Blacksmithing's Heavy Mithril Breastplate, #1956).
		taughtBy: { 22331: 'Artisan', 19058: 'Artisan', 10548: 'Artisan', 10552: 'Artisan', 10556: 'Artisan', 10558: 'Artisan' },
		assumed: [
			"ASSUMED: Rugged Leather and Rugged Armor Kit are taught only by the Artisan trainers, Drakk Stonehand and Hahrana Ironhide (Classic's trainer lists; Forever's sniffed lists stop at 150). In-game check: whether Telonis or Una teach them.",
		],
		notes: [
			{
				at: 225,
				text: 'Specialisation (optional): at 225 and character level 40. Dragonscale: Peter Galen (Azshara) or Thorkaf Dragoneye (Badlands) wants 2 Tough Scorpid Breastplates, 2 Tough Scorpid Gloves (patterns drop from the Wastewander bandits in Tanaris) and 10 Worn Dragonscale. Elemental: Sarah Tanner (Searing Gorge) or Brumn Winterhoof (Arathi Highlands) wants 2 each of Heart of Fire, Globe of Water, Core of Earth and Breath of Wind. Tribal (from 235): Caryssia Moonhunter (Feralas) or Se\'Jib (Stranglethorn Vale) wants a Wild Leather Vest and Helmet, after the Wild Leather quests from Pratt McGrubben or Jangdor Swiftstrider in Feralas. On Forever the specialisation patterns need a Tanning Rack. You can take only one; none is needed for 300, and the beta never tested them (it stopped at level 30).',
			},
		],
	},

	Tailoring: {
		intro: [
			'Tailoring sews cloth into bolts and the bolts into cloth armour, bags and shirts. It needs no gathering profession: humanoids drop the cloth of their level as you quest. Thread and dyes come from tailoring and trade supplies vendors.',
			"Forever's changes: nearly every pattern moved 25 points down: trainers teach it 25 points earlier (Bolt of Silk Cloth at 100, Gloves of Meditation at 105) and it greys sooner. Forever adds school sets (sashes, slippers, belts and more), reagent bags, and the Faction Banner camp item. 74 patterns need a Spinning Wheel, a camp station (skill 140) from a blueprint the Unstable Sentinel drops in the City of Dalaran; 43 more need the skill-300 Loom (no known source); Mooncloth needs a Moonwell. New patterns are also sold for Merchant's Favor by Jim'bek near the Crossroads and Mivin Shadowweave at Three Corners (Redridge). " + FAVOR + ' Tailoring has no specialisation on Forever.',
			'Ranks: Journeyman needs character level 10 (Forever\'s sniffed lists). Trainers teach by tier and train only from their tier\'s skill: Journeyman at the city trainers, from skill 50; Expert only at Georgio Bolero (Stormwind) and Josef Gregorian (Undercity), from 125; Artisan only at Timothy Worthington (Theramore, Dustwallow Marsh) and Daryl Stack (Tarren Mill, Hillsbrad), from 200.',
		],
		apprentice: 'Keep every Linen Cloth you loot: humanoids of level 5-20 drop it.',
		camp: {
			spells: [
				{ spell: 1263425, only: 'Alliance' },
				{ spell: 1229504, only: 'Horde' },
			],
			at: 20,
			tip: `Also learn Faction Banner (1s): Forever's Tailoring camp item, a Bolt of Linen Cloth and a Coarse Thread; each faction has its own. ${CAMPING_101('Tailoring')}`,
		},
		noLevel: { 3865: 'Mageweave drops from humanoids of level 35-50, later than skill 140 comes' },
		// Classic's trainer lists (world DB, VB 0) teach these, which asked 230-250 there (above Expert's 225), at
		// the Artisan trainers only, never at Georgio Bolero or Josef Gregorian: Forever moved them down, not off
		// the Artisan list (Blacksmithing's Heavy Mithril Breastplate, #1956).
		taughtBy: { 12072: 'Artisan', 12073: 'Artisan', 12074: 'Artisan', 12077: 'Artisan', 12079: 'Artisan', 12088: 'Artisan', 12092: 'Artisan', 18401: 'Artisan', 18402: 'Artisan' },
		exclude: {
			1257487: 'sold only by Pexmit, "Someone\'s Minion", in Mount Hyjal (an endgame zone, no faction in the data): unverified',
			3852: 'an Elixir of Wisdom from an alchemist in every craft',
			12081: 'six Long Elegant Feathers (a bird drop) in every craft',
		},
		// Past 265 every trainer or vendor pattern without a station is green or grey: Runecloth
		// Gloves to 275 and Runecloth Boots to 280 take over a hundred crafts for 15 points. The
		// world-drop patterns that do not bind (Forever's data: 542 and 454 kinds of mob drop them)
		// carry the rest from the Auction House: Runecloth Headband orange to 265 and yellow to 280,
		// Runecloth Shoulders orange to 275 and yellow to 290.
		auction: { 18444: 265, 18449: 265 },
		// Runecloth drops from humanoids of level 45-60; a tailor reaches 205 at about level
		// 44 and 225 at 47. Mageweave (35-50) carries 205-225 as both web routes do, and the
		// Runecloth recipes start with Artisan.
		notBefore: { 18401: 225, 18402: 225 },
		notes: [
			{
				at: 266,
				text: "No pattern on the Auction House? Runecloth Gloves still give a point now and then to 275, and Runecloth Boots (Darnall, Moonglade) to 280, at 4 bolts a craft. Mooncloth (pattern from Qia or Evie Whirlbrew in Everlook; 2 Felcloth at a Moonwell) stays orange to 270 and yellow to 285, but it can be made once every four days. The Spinning Wheel patterns (Merchant's Favor sandals and waistcords from Jim'bek or Mivin Shadowweave; the wheel's blueprint drops from the Unstable Sentinel in the City of Dalaran) and Runecloth Cuffs (Pexmit in Mount Hyjal, 10g; we could not confirm that vendor yet) are the other ways on.",
			},
		],
		tips: {
			2963: 'The bolts give points too while they are not grey.',
			8776: 'Each belt takes one bolt; the belts sell to vendors.',
			2402: 'Bolt of Woolen Cloth is taught from 55 on Forever.',
			3866: 'Three woolen bolts and two Red Dye a shirt; Wool Cloth drops from humanoids of level 15-30.',
			3871: 'Silk bolts from here on: Silk Cloth drops from humanoids of level 25-45. Bleach from tailoring and trade supplies vendors.',
			18401: 'Runecloth comes from humanoids of level 45-60.',
			18402: 'Rune Thread from tailoring vendors.',
			18417: 'Qia in Everlook keeps one pattern at a time; the Timbermaw Hold tunnel from Felwood is the road in, so never kill Timbermaw furbolgs on the way.',
			18444: 'Two Ironweb Spider Silk a craft: the spiders of Western Plaguelands and Silithus drop it (the marked spots), or the Auction House.',
			18449: 'Seven bolts, two Ironweb Spider Silk and four Rugged Leather a craft: the dearest stretch. The spiders of Western Plaguelands and Silithus drop the silk (the marked spots), or the Auction House.',
		},
	},
};

module.exports = { SPECS };
