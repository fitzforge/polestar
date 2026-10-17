-- Spanish (Spain) (esES): the guide forever/class/rogue/the-azure-key (forever/class/rogue/the-azure-key.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ravenholdt reputation and experience at 50; Forever removed the Classic item choice."] = "Reputación con Ravenholdt y experiencia a nivel 50; Forever eliminó la elección de objeto de Classic.",
	["Ravenholdt reputation"] = "Reputación con Ravenholdt",

	-- Step 1: A Simple Request (Alliance)
	-- {quest:8233} A Simple Request
	["{quest:8233} (Alliance)"] = "{quest:8233} (Alianza)",
	-- {npc:918} Osborne the Night Man · {zone:1453} Stormwind · {object:2100} Old Town · {zone:1457} Darnassus · {npc:5165} Hulfdan Blackbeard · {zone:1455} Ironforge
	["At 50 {npc:918} in {zone:1453}'s {object:2100} has it; so do Syurna in {zone:1457} and {npc:5165} and Fenthwick in {zone:1455}."] = "A nivel 50, la tiene {npc:918} en {object:2100} de {zone:1453}; también Syurna en {zone:1457}, y {npc:5165} y Fenthwick en {zone:1455}.",

	-- Step 2: A Simple Request (Horde)
	-- {quest:8233} A Simple Request
	["{quest:8233} (Horde)"] = "{quest:8233} (Horda)",
	-- {npc:3328} Ormok · {object:172960} Cleft of Shadow · {npc:4583} Miles Dexter · {zone:1458} Undercity · {object:36073} Rogues' Quarter
	["At 50 {npc:3328} in the {object:172960} has it; so does {npc:4583} in the {zone:1458}'s {object:36073}."] = "A nivel 50, la tiene {npc:3328} en {object:172960}; también {npc:4583} en {object:36073} de {zone:1458}.",

	-- Step 3: Lord Jorach Ravenholdt
	-- {area:3486} Ravenholdt Manor · {area:272} Tarren Mill · {zone:1416} Alterac Mountains · {area:271} Southshore
	["{area:3486} hides in the hills east of {area:272}, up a path into the {zone:1416}. Horde fly to {area:272}, Alliance to {area:271}."] = "La {area:3486} se oculta en las colinas al este de {area:272}, subiendo por un sendero hacia {zone:1416}. La Horda vuela a {area:272}; la Alianza, a {area:271}.",

	-- Step 4: Sealed Azure Bag
	-- {area:3137} Talrendis Point · {area:1237} Valormok · {zone:1447} Azshara
	-- plural, as words: Timbermaw Shamans = {npc:6188} Timbermaw Shaman
	["Alliance fly to {area:3137}, Horde to {area:1237}. The Timbermaw Shamans in {zone:1447}'s northern hills drop the bag, about one in thirty."] = "La Alianza vuela a {area:3137}; la Horda, a {area:1237}. Los chamanes Fauces de Madera de las colinas del norte de {zone:1447} sueltan la bolsa, más o menos uno de cada treinta.",

	-- Step 6: Encoded Fragments
	-- {zone:1447} Azshara
	-- plural, as words: Forest Oozes = {npc:8766} Forest Ooze
	["The Forest Oozes of southern {zone:1447} drop the fragments."] = "Los mocos del bosque del sur de {zone:1447} sueltan los fragmentos.",

	-- Step 7: Back to Xylem
	["Back to Xylem"] = "De vuelta con Xylem",

	-- Step 8: Morphaz in the Sunken Temple
	-- {area:1417} Sunken Temple
	["Morphaz in the {area:1417}"] = "Morphaz en el {area:1417}",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears · {area:75} Stonard · {area:1438} Nethergarde Keep
	["Morphaz, a green drake, is an elite boss deep in the {area:1417}, a level 50 dungeon: bring a group of five. The temple stands in the {area:74}; swim down to the entrance. Horde: fly to {area:75}; Alliance: fly to {area:1438} and ride on."] = "Morphaz, un draco verde, es un jefe de élite en lo más hondo del {area:1417}, una mazmorra de nivel 50: lleva un grupo de cinco. El templo está en {area:74}; bucea hasta la entrada. Horda: vuela a {area:75}. Alianza: vuela a {area:1438} y sigue cabalgando.",
	-- {item:20022} Azure Key
	["{item:20022}: Morphaz, inside the temple"] = "{item:20022}: Morphaz, dentro del templo",

	-- Step 9: Lord Ravenholdt
	["Lord Ravenholdt"] = "Lord Ravenholdt",
	-- {npc:6768} Lord Jorach Ravenholdt
	["{npc:6768}: no item choices in Forever"] = "{npc:6768}: sin elección de objeto en Forever",
}
