-- Portuguese (Brazil) (ptBR): the guide forever/class/warrior/voodoo-feathers (forever/class/warrior/voodoo-feathers.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:1417} Sunken Temple
	["Experience at 50, ending in the {area:1417}; Forever removed the Classic item choice."] = "Experiência no nível 50, terminando no {area:1417}; o Forever removeu o item à escolha do Classic.",
	["Experience"] = "Experiência",

	-- Step 1: A Troubled Spirit (Stormwind)
	-- {npc:5479} Wu Shen · {object:2100} Old Town · {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows
	["At 50, {npc:5479} in {object:2100}, beside the Pig and Whistle, sends you to the {npc:7572} in the {zone:1435}."] = "No nível 50, {npc:5479}, em {object:2100}, ao lado da Taberna do Javatusco Saltitante, envia você ao {npc:7572} no {zone:1435}.",

	-- Step 2: A Troubled Spirit (Ironforge)
	-- {npc:5113} Kelv Sternhammer · {zone:1455} Ironforge · {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows
	["At 50, {npc:5113}, the warrior trainer of {zone:1455}, sends you to the {npc:7572} in the {zone:1435}."] = "No nível 50, {npc:5113}, o instrutor de guerreiros de {zone:1455}, envia você ao {npc:7572} no {zone:1435}.",

	-- Step 3: A Troubled Spirit (Darnassus)
	-- {npc:7315} Darnath Bladesinger · {zone:1457} Darnassus · {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows
	["At 50, {npc:7315}, the warrior trainer of {zone:1457}, sends you to the {npc:7572} in the {zone:1435}."] = "No nível 50, {npc:7315}, o instrutor de guerreiros de {zone:1457}, envia você ao {npc:7572} no {zone:1435}.",

	-- Step 4: A Troubled Spirit (Orgrimmar)
	-- {npc:3354} Sorek · {object:172958} Valley of Honor (no name in this language: may be words) · {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows
	["At 50, {npc:3354} in the {object:172958} sends you to the {npc:7572} in the {zone:1435}."] = "No nível 50, {npc:3354}, no {object:172958}, envia você ao {npc:7572} no {zone:1435}.",

	-- Step 5: A Troubled Spirit (Thunder Bluff)
	-- {npc:3041} Torm Ragetotem · {zone:1456} Thunder Bluff · {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows
	["At 50, {npc:3041}, the warrior trainer of {zone:1456}, sends you to the {npc:7572} in the {zone:1435}."] = "No nível 50, {npc:3041}, o instrutor de guerreiros de {zone:1456}, envia você ao {npc:7572} no {zone:1435}.",

	-- Step 6: A Troubled Spirit (Undercity)
	-- {npc:4593} Christoph Walker · {zone:1458} Undercity · {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows
	["At 50, {npc:4593}, a warrior trainer of the {zone:1458}, sends you to the {npc:7572} in the {zone:1435}."] = "No nível 50, {npc:4593}, um instrutor de guerreiros da {zone:1458}, envia você ao {npc:7572} no {zone:1435}.",

	-- Step 7: The Fallen Hero of the Horde
	-- {npc:7572} Fallen Hero of the Horde
	["The {npc:7572}"] = "{npc:7572}",
	-- {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows · {zone:1419} Blasted Lands
	["The {npc:7572} stands in the south-west of the {zone:1435}, at the entrance to the {zone:1419}."] = "O {npc:7572} fica no sudoeste do {zone:1435}, na entrada da {zone:1419}.",

	-- Step 8: Helboars
	-- plural, as words: Helboars = {npc:5993} Helboar
	["Helboars"] = "Javiltuscos",
	-- {zone:1419} Blasted Lands · {npc:10996} Fallen Hero
	-- plural, as words: Helboars = {npc:5993} Helboar
	["The Helboars roam the north of the {zone:1419}, south of the {npc:10996}."] = "Os Javiltuscos vagam pelo norte da {zone:1419}, ao sul do {npc:10996}.",

	-- Step 10: Shadowsworn camps
	["Shadowsworn camps"] = "Acampamentos dos Devotos da Sombra",
	-- {zone:1419} Blasted Lands
	["The Shadowsworn cultists hold the east of the {zone:1419}."] = "Os sectários Devotos da Sombra ocupam o leste da {zone:1419}.",

	-- Step 12: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "{area:1417}",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears · {zone:1435} Swamp of Sorrows · {npc:5716} Zul'Lor
	["The {area:1417} lies under the {area:74} in the east of the {zone:1435}. Each of the six Atal'ai trolls on the balcony drops a voodoo feather: Gasher or {npc:5716} the amber, Hukku or Mijan the blue, Zolo or Loro the green. The {area:1417} is a dungeon and the trolls are elite: grouping up is advised."] = "O {area:1417} fica sob o {area:74}, no leste do {zone:1435}. Cada um dos seis trolls Atal'ai na sacada solta uma pena vodu: Talho ou {npc:5716} a âmbar, Hukkah ou Mirran a azul, Zolo ou Lorro a verde. O {area:1417} é uma masmorra e os trolls são elite: é recomendado ir em grupo.",

	-- Step 13: Back to the Fallen Hero
	-- {npc:10996} Fallen Hero
	["Back to the {npc:10996}"] = "Volte ao {npc:10996}",
}
