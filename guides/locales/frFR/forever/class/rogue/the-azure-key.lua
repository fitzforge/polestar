-- French (frFR): the guide forever/class/rogue/the-azure-key (forever/class/rogue/the-azure-key.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ravenholdt reputation and experience at 50; Forever removed the Classic item choice."] = "Réputation Ravenholdt et expérience au niveau 50 ; Forever a retiré le choix d'objet de Classic.",
	["Ravenholdt reputation"] = "Réputation Ravenholdt",

	-- Step 1: A Simple Request (Alliance)
	-- {quest:8233} A Simple Request
	["{quest:8233} (Alliance)"] = "{quest:8233} (Alliance)",
	-- {npc:918} Osborne the Night Man · {zone:1453} Stormwind · {object:2100} Old Town · {zone:1457} Darnassus · {npc:5165} Hulfdan Blackbeard · {zone:1455} Ironforge
	["At 50 {npc:918} in {zone:1453}'s {object:2100} has it; so do Syurna in {zone:1457} and {npc:5165} and Fenthwick in {zone:1455}."] = "Au niveau 50, {npc:918}, dans {object:2100} de {zone:1453}, la propose ; Syurna à {zone:1457}, {npc:5165} et Fenthwick à {zone:1455} aussi.",

	-- Step 2: A Simple Request (Horde)
	-- {quest:8233} A Simple Request
	["{quest:8233} (Horde)"] = "{quest:8233} (Horde)",
	-- {npc:3328} Ormok · {object:172960} Cleft of Shadow · {npc:4583} Miles Dexter · {zone:1458} Undercity · {object:36073} Rogues' Quarter
	["At 50 {npc:3328} in the {object:172960} has it; so does {npc:4583} in the {zone:1458}'s {object:36073}."] = "Au niveau 50, {npc:3328}, dans {object:172960}, la propose ; {npc:4583}, dans {object:36073} de {zone:1458}, aussi.",

	-- Step 3: Lord Jorach Ravenholdt
	-- {area:3486} Ravenholdt Manor · {area:272} Tarren Mill · {zone:1416} Alterac Mountains · {area:271} Southshore
	["{area:3486} hides in the hills east of {area:272}, up a path into the {zone:1416}. Horde fly to {area:272}, Alliance to {area:271}."] = "{area:3486} se cache dans les collines à l'est de {area:272}, au bout d'un chemin qui monte dans {zone:1416}. La Horde prend un vol pour {area:272}, l'Alliance pour {area:271}.",

	-- Step 4: Sealed Azure Bag
	-- {area:3137} Talrendis Point · {area:1237} Valormok · {zone:1447} Azshara
	-- plural, as words: Timbermaw Shamans = {npc:6188} Timbermaw Shaman
	["Alliance fly to {area:3137}, Horde to {area:1237}. The Timbermaw Shamans in {zone:1447}'s northern hills drop the bag, about one in thirty."] = "L'Alliance prend un vol pour {area:3137}, la Horde pour {area:1237}. Les Chamans Grumegueule des collines du nord d'{zone:1447} laissent tomber le sac, environ une fois sur trente.",

	-- Step 6: Encoded Fragments
	-- {zone:1447} Azshara
	-- plural, as words: Forest Oozes = {npc:8766} Forest Ooze
	["The Forest Oozes of southern {zone:1447} drop the fragments."] = "Les Limons forestiers du sud d'{zone:1447} laissent tomber les fragments.",

	-- Step 7: Back to Xylem
	["Back to Xylem"] = "Retour auprès de Xylem",

	-- Step 8: Morphaz in the Sunken Temple
	-- {area:1417} Sunken Temple
	["Morphaz in the {area:1417}"] = "Morphaz dans {area:1417}",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears · {area:75} Stonard · {area:1438} Nethergarde Keep
	["Morphaz, a green drake, is an elite boss deep in the {area:1417}, a level 50 dungeon: bring a group of five. The temple stands in the {area:74}; swim down to the entrance. Horde: fly to {area:75}; Alliance: fly to {area:1438} and ride on."] = "Morphaz, un drake vert, est un boss élite au fond de {area:1417}, un donjon de niveau 50 : venez en groupe de cinq. Le temple se dresse dans {area:74} ; nagez jusqu'à l'entrée au fond. Horde : prenez un vol pour {area:75} ; Alliance : prenez un vol pour {area:1438} et continuez à cheval.",
	-- {item:20022} Azure Key
	["{item:20022}: Morphaz, inside the temple"] = "{item:20022} : Morphaz, dans le temple",

	-- Step 9: Lord Ravenholdt
	["Lord Ravenholdt"] = "Seigneur Ravenholdt",
	-- {npc:6768} Lord Jorach Ravenholdt
	["{npc:6768}: no item choices in Forever"] = "{npc:6768} : pas de choix d'objet dans Forever",
}
