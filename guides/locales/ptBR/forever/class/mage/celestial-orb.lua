-- Portuguese (Brazil) (ptBR): the guide forever/class/mage/celestial-orb (forever/class/mage/celestial-orb.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7515} Celestial Orb
	["{item:7515} and Stave"] = "{item:7515} e Báculo",
	["An off-hand orb or a staff for the late 30s, your pick."] = "Um orbe de mão secundária ou um cajado para o fim dos 30, à sua escolha.",

	-- Step 1: Return to the Marsh (Stormwind)
	-- {npc:5497} Jennea Cannon · {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:6546} Tabetha · {zone:1455} Ironforge
	["{npc:5497} at the top of the Wizard's Sanctum, {zone:1453}'s {object:2101}, sends you back to {npc:6546}; Bink in {zone:1455} gives the same quest."] = "",

	-- Step 2: Return to the Marsh (Orgrimmar)
	-- {npc:5885} Deino · {zone:1454} Orgrimmar · {object:173161} Darkbriar Lodge (no name in this language: may be words) · {npc:6546} Tabetha · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity · {npc:3048} Ursyn Ghull · {zone:1456} Thunder Bluff
	["{npc:5885}, one of {zone:1454}'s mage trainers in {object:173161}, sends you back to {npc:6546}; {npc:4568} in the {zone:1458} and {npc:3048} in {zone:1456} give the same quest."] = "",

	-- Step 3: Tabetha
	-- {npc:6546} Tabetha
	["{npc:6546}'s cottage is deep in the marsh west of Theramore, just north of the Stonemaul Ruins; come in from the west road, the elites roam its east side."] = "",

	-- Step 4: The Infernal Orb
	-- {zone:1443} Desolace · {object:176946} Shadowprey Village (no name in this language: may be words) · {item:7291} Infernal Orb · {zone:1412} Mulgore · {zone:1456} Thunder Bluff
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner · Nether Maidens = {npc:4679} Nether Maiden
	["The Burning Blade Summoners (level 38-39, not elite) work the Mannoroc Coven in southern {zone:1443}, east of {object:176946}, and every one carries an {item:7291}. They cast Shadow Bolt from 40 yards, keep an imp at their side and run for help at low health; Nether Maidens patrol the pillared ruin beside them, so pull with care. Horde mages: one more summoner stands alone in western {zone:1412}, south-west of {zone:1456}."] = "",

	-- Step 5: The Exorcism
	-- {npc:6546} Tabetha · {quest:1955} The Exorcism · {npc:6549} Demon of the Orb
	["Back at {npc:6546}'s. Kill the critters around the cottage first: they join the fight. Accepting {quest:1955} starts a 3 minute timer, and {npc:6546} calls the {npc:6549} out in her garden: a level 40 elite that resists many spells, roots and slows. Grouping up is encouraged: a mage of 40 may need help or potions, at about 45 it is soloable. You can pull it from range from the dock. The timer keeps running after it dies, so hand the quest in straight away. If time runs out, abandon the quest and take it again; she calls the demon again."] = "",
	-- {npc:6549} Demon of the Orb
	["{npc:6549} (elite, 40)"] = "",

	-- Step 6: Power in Uldaman
	-- {zone:1418} Badlands · {npc:7023} Obsidian Sentinel · {npc:7209} Obsidian Shard
	["Uldaman is a dungeon in the northern {zone:1418}: a group of five. Go in by the rear entrance, a cave in Dustwind Gulch south-east of the main entrance (elite dragons fly nearby): the {npc:7023} (level 42 elite) stands just past the first door. At 80, 60, 40 and 20 percent it breaks off an {npc:7209}, an elite too; while a shard lives, both reflect targeted spells, so use area spells and your wand on them. A solo trick: step out through the nearby zone line each time a shard appears; the Sentinel heals but keeps shrinking. It always drops the power source, and takes 2 hours to come back."] = "",

	-- Step 7: Mana Surges
	-- {npc:6546} Tabetha · {quest:1957} Mana Surges
	["Back to {npc:6546}. Accepting {quest:1957} opens a rift beside her cottage and starts a 10 minute timer: twelve {quest:1957} (level 40, Shock and Lightning Bolt) come out about four at a time. Attacking one does not pull the rest. Standing at the edge of the field draws them all; the tree south-west of it is out of their reach but in your spell range. Kill twelve and hand in before the timer runs out."] = "",
	-- {quest:1958} Celestial Power · {item:7515} Celestial Orb · {item:9517} Celestial Stave
	["{quest:1958}: the {item:7515} (off-hand) or the {item:9517}"] = "",

	-- Step 8: Tabetha's Task (optional)
	-- {quest:2861} Tabetha's Task
	["{quest:2861} (optional)"] = "",
	-- {npc:6546} Tabetha · {npc:5497} Jennea Cannon · {npc:4568} Anastasia Hartwell · {npc:5885} Deino · {quest:2861} Tabetha's Task · {quest:2846} Tiara of the Deep · {npc:7795} Hydromancer Velratha · {zone:1446} Tanaris · {item:9527} Spellshifter Rod · {item:9531} Gemshale Pauldrons
	["At 40 the mage trainers who send you to {npc:6546} ({npc:5497}, Bink, {npc:4568}, {npc:5885}) also have {quest:2861}, a quest any class can do. {npc:6546} then wants the {quest:2846} from {npc:7795}, a level 46 elite naga in Zul'Farrak, the troll dungeon in north-western {zone:1446}: a group of five, level 44-54. She is one of the bosses by the sacred pool, and the tiara always drops. The reward window shows the {item:9527} and the {item:9531}."] = "",
	-- {quest:2846} Tiara of the Deep · {npc:7795} Hydromancer Velratha
	["{quest:2846}: {npc:7795}, Zul'Farrak"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:6546}. She opens a mana rift beside her cottage: kill twelve {quest:1957} within ten minutes."] = "De volta a {npc:6546}. Ela abre uma fenda de mana ao lado da cabana: mate doze {quest:1957} em dez minutos.",
	-- ["The Burning Blade Summoners work the {area:602} in southern {zone:1443}; any of them carries an {item:7291}."] = "Os Evocadores da Lâmina Ardente trabalham no {area:602}, no sul de {zone:1443}; qualquer um deles leva um {item:7291}.",
	-- ["{area:1517} is a dungeon in the northern {zone:1418}, by the {object:178824}: a group of five. Defeat the {npc:7023} inside for its power source."] = "{area:1517} é uma masmorra no norte de {zone:1418}, junto à {object:178824}: um grupo de cinco. Derrote o {npc:7023} lá dentro para pegar a fonte de energia dele.",
	-- ["{npc:5497} in the Wizard's Sanctum, {zone:1453}'s {object:2101}, sends you back to {npc:6546}; Bink in {zone:1455} gives the same quest."] = "{npc:5497}, na torre do {object:2101} de {zone:1453}, manda você de volta a {npc:6546}; Bink em {zone:1455} dá a mesma missão.",
	-- ["{npc:5885}, one of {zone:1454}'s mage trainers, sends you back to {npc:6546}; {npc:4568} in the {zone:1458} and {npc:3048} in {zone:1456} give the same quest."] = "{npc:5885}, um dos instrutores de mago de {zone:1454}, manda você de volta a {npc:6546}; {npc:4568} em {zone:1458} e {npc:3048} em {zone:1456} dão a mesma missão.",
	-- ["{npc:6546} draws the demon out of the orb beside her cottage. The {npc:6549} is elite: grouping up is advised. You have three minutes before it slips back into the orb."] = "{npc:6546} tira o demônio do orbe ao lado da cabana dela. O {npc:6549} é elite: é recomendado formar grupo. Você tem três minutos antes que ele volte para o orbe.",
	-- ["{npc:6546}'s cottage is deep in the marsh west of Theramore, just north of the {area:508}."] = "A cabana de {npc:6546} fica no fundo do pântano a oeste de Theramore, logo ao norte das {area:508}.",
}
