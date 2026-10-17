-- Portuguese (Brazil) (ptBR): the guide forever/class/rogue/the-azure-key (forever/class/rogue/the-azure-key.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ravenholdt reputation and experience at 50; Forever removed the Classic item choice."] = "Reputação com Ravenholdt e experiência no nível 50; o Forever removeu a escolha de item do Classic.",
	["Ravenholdt reputation"] = "Reputação com Ravenholdt",

	-- Step 1: A Simple Request (Alliance)
	-- {quest:8233} A Simple Request
	["{quest:8233} (Alliance)"] = "{quest:8233} (Aliança)",
	-- {npc:918} Osborne the Night Man · {zone:1453} Stormwind · {object:2100} Old Town · {zone:1457} Darnassus · {npc:5165} Hulfdan Blackbeard · {zone:1455} Ironforge
	["At 50 {npc:918} in {zone:1453}'s {object:2100} has it; so do Syurna in {zone:1457} and {npc:5165} and Fenthwick in {zone:1455}."] = "No nível 50, {npc:918} em {object:2100} de {zone:1453} a tem; assim como Syurna em {zone:1457} e {npc:5165} e Degrauzinho em {zone:1455}.",

	-- Step 2: A Simple Request (Horde)
	-- {quest:8233} A Simple Request
	["{quest:8233} (Horde)"] = "{quest:8233} (Horda)",
	-- {npc:3328} Ormok · {object:172960} Cleft of Shadow (no name in this language: may be words) · {npc:4583} Miles Dexter · {zone:1458} Undercity · {object:36073} Rogues' Quarter (no name in this language: may be words)
	["At 50 {npc:3328} in the {object:172960} has it; so does {npc:4583} in the {zone:1458}'s {object:36073}."] = "No nível 50, {npc:3328} na {object:172960} a tem; assim como {npc:4583} no {object:36073} de {zone:1458}.",

	-- Step 3: Lord Jorach Ravenholdt
	-- {area:3486} Ravenholdt Manor · {area:272} Tarren Mill · {zone:1416} Alterac Mountains · {area:271} Southshore
	["{area:3486} hides in the hills east of {area:272}, up a path into the {zone:1416}. Horde fly to {area:272}, Alliance to {area:271}."] = "{area:3486} se esconde nas colinas a leste de {area:272}, subindo uma trilha para as {zone:1416}. A Horda voa para {area:272}, a Aliança para {area:271}.",

	-- Step 4: Sealed Azure Bag
	-- {area:3137} Talrendis Point · {area:1237} Valormok · {zone:1447} Azshara
	-- plural, as words: Timbermaw Shamans = {npc:6188} Timbermaw Shaman
	["Alliance fly to {area:3137}, Horde to {area:1237}. The Timbermaw Shamans in {zone:1447}'s northern hills drop the bag, about one in thirty."] = "A Aliança voa para {area:3137}, a Horda para {area:1237}. Os Xamãs Presamatos nas colinas do norte de {zone:1447} deixam cair a bolsa, cerca de um em trinta.",

	-- Step 6: Encoded Fragments
	-- {zone:1447} Azshara
	-- plural, as words: Forest Oozes = {npc:8766} Forest Ooze
	["The Forest Oozes of southern {zone:1447} drop the fragments."] = "As Gosmas Florestais do sul de {zone:1447} deixam cair os fragmentos.",

	-- Step 7: Back to Xylem
	["Back to Xylem"] = "De volta a Tauriel",

	-- Step 8: Morphaz in the Sunken Temple
	-- {area:1417} Sunken Temple
	["Morphaz in the {area:1417}"] = "Morphaz no {area:1417}",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears · {area:75} Stonard · {area:1438} Nethergarde Keep
	["Morphaz, a green drake, is an elite boss deep in the {area:1417}, a level 50 dungeon: bring a group of five. The temple stands in the {area:74}; swim down to the entrance. Horde: fly to {area:75}; Alliance: fly to {area:1438} and ride on."] = "Morphaz, um draco verde, é um chefe de elite no fundo do {area:1417}, uma masmorra de nível 50: leve um grupo de cinco. O templo fica no {area:74}; nade até a entrada. Horda: voe para {area:75}; Aliança: voe para {area:1438} e siga cavalgando.",
	-- {item:20022} Azure Key
	["{item:20022}: Morphaz, inside the temple"] = "{item:20022}: Morphaz, dentro do templo",

	-- Step 9: Lord Ravenholdt
	["Lord Ravenholdt"] = "Lorde Ravenholdt",
	-- {npc:6768} Lord Jorach Ravenholdt
	["{npc:6768}: no item choices in Forever"] = "{npc:6768}: sem escolha de itens no Forever",
}
