-- Spanish (Spain) (esES): the guide forever/class/shaman/call-of-air-horde (forever/class/shaman/call-of-air-horde.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:1531} Call of Air
	["{quest:1531} and the Tempest's Weapons (Horde)"] = "{quest:1531} y las armas de la Tempestad (Horda)",
	-- {item:5178} Air Totem
	["The {item:5178} that lets you place air totems, then a weapon of your choice at 40."] = "El {item:5178} que te permite colocar tótems de aire, y luego un arma a tu elección a nivel 40.",

	-- Step 1: Searn Firewarder
	-- {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom · {npc:5905} Prate Cloudseer · {zone:1441} Thousand Needles
	["At 30 {npc:5892} in the {object:172957} sends you to {npc:5905} in {zone:1441}."] = "A nivel 30 {npc:5892}, en {object:172957}, te envía con {npc:5905} en {zone:1441}.",

	-- Step 2: Xanis Flameweaver
	-- {npc:5906} Xanis Flameweaver · {zone:1456} Thunder Bluff · {npc:5905} Prate Cloudseer · {zone:1441} Thousand Needles
	["At 30 {npc:5906}, a shaman trainer in {zone:1456}, sends you to {npc:5905} in {zone:1441}."] = "A nivel 30 {npc:5906}, un instructor de chamanes de {zone:1456}, te envía con {npc:5905} en {zone:1441}.",

	-- Step 3: Prate Cloudseer
	-- {area:484} Freewind Post · {npc:5905} Prate Cloudseer · {quest:1531} Call of Air
	["Fly to {area:484}. {npc:5905} hides in a small cave in the canyon wall north-east of the post. Skyborne: your own {quest:1531} (96136) ends with her too."] = "Vuela a {area:484}. {npc:5905} se esconde en una pequeña cueva en la pared del cañón al noreste del puesto. Cielonato: tu propia {quest:1531} (96136) también termina con ella.",
	-- {npc:5905} Prate Cloudseer · {item:5178} Air Totem
	["{npc:5905}: your {item:5178}"] = "{npc:5905}: tu {item:5178}",

	-- Step 4: Charlga Razorflank
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {npc:4421} Charlga Razorflank
	["{area:1717} is a dungeon at the southern edge of the {zone:1413} (the arrow points at its entrance); {npc:4421} is its last boss. Bring a group."] = "{area:1717} es una mazmorra en el extremo sur de {zone:1413} (la flecha señala su entrada); {npc:4421} es su último jefe. Lleva un grupo.",
	-- {item:274463} Tattered Note · {npc:4421} Charlga Razorflank
	["{item:274463}, from {npc:4421}"] = "{item:274463}, de {npc:4421}",

	-- Step 5: Rau Cliffrunner
	-- {npc:4722} Rau Cliffrunner · {area:484} Freewind Post
	["{npc:4722} stands at {area:484}."] = "{npc:4722} está en {area:484}.",

	-- Step 7: Twisted Air Totems
	-- plural, as words: Twisted Air Totems = {item:274047} Twisted Air Totem
	["Twisted Air Totems"] = "Tótems de aire retorcidos",
	-- {zone:1443} Desolace
	-- plural, as words: Twisted Air Totems = {item:274047} Twisted Air Totem
	["The Maraudine centaurs of western {zone:1443} carry the Twisted Air Totems."] = "Los centauros Maraudine del oeste de {zone:1443} llevan los Tótems de aire retorcidos.",

	-- Step 8: Twisted Water Totems
	-- plural, as words: Twisted Water Totems = {item:274046} Twisted Water Totem
	["Twisted Water Totems"] = "Tótems de agua retorcidos",
	-- {zone:1445} Dustwallow Marsh
	-- plural, as words: Twisted Water Totems = {item:274046} Twisted Water Totem
	["The Mirefin murlocs of northern {zone:1445} carry the Twisted Water Totems."] = "Los múrlocs Ancalodo del norte de {zone:1445} llevan los Tótems de agua retorcidos.",

	-- Step 9: Twisted Fire Totems
	-- plural, as words: Twisted Fire Totems = {item:274044} Twisted Fire Totem
	["Twisted Fire Totems"] = "Tótems de fuego retorcidos",
	-- {zone:1418} Badlands
	-- plural, as words: Twisted Fire Totems = {item:274044} Twisted Fire Totem
	["The Stonevault troggs in the south of the {zone:1418} carry the Twisted Fire Totems."] = "Los troggs Grutacanto del sur de {zone:1418} llevan los Tótems de fuego retorcidos.",

	-- Step 10: Twisted Earth Totems
	-- plural, as words: Twisted Earth Totems = {item:274045} Twisted Earth Totem
	["Twisted Earth Totems"] = "Tótems de tierra retorcidos",
	-- {zone:1435} Swamp of Sorrows
	-- plural, as words: The Lost Ones = {npc:256028} The Lost One · Twisted Earth Totems = {item:274045} Twisted Earth Totem
	["The Lost Ones in the north of the {zone:1435} carry the Twisted Earth Totems."] = "Los Perdidos del norte de {zone:1435} llevan los Tótems de tierra retorcidos.",

	-- Step 12: The steam pools
	["The steam pools"] = "Las pozas de vapor",
	-- {npc:5905} Prate Cloudseer · {item:268582} Corrupted Totems · {area:484} Freewind Post · {npc:216474} Ravaging Tempest · {quest:79366} Heed My Call
	["{npc:5905} hands you the {item:268582}: place them at the steam pools west of {area:484} and defeat the {npc:216474} they call. {quest:79366} is an elite quest: grouping up is advised."] = "{npc:5905} te da los {item:268582}: colócalos en las pozas de vapor al oeste de {area:484} y derrota a {npc:216474} que invocan. {quest:79366} es una misión de élite: se recomienda ir en grupo.",
	-- {item:212792} Eye of the Tempest · {npc:216474} Ravaging Tempest
	["{item:212792}, from the {npc:216474}"] = "{item:212792}, de {npc:216474}",

	-- Step 14: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher · {zone:1416} Alterac Mountains · {area:272} Tarren Mill
	["{npc:6176} camps in the east of {zone:1416}, north-east of {area:272}."] = "{npc:6176} acampa en el este de {zone:1416}, al noreste de {area:272}.",
	-- {npc:6176} Bath'rah the Windwatcher · {item:213086} Rune of the Storm
	["{npc:6176}: the {item:213086} and your weapon"] = "{npc:6176}: la {item:213086} y tu arma",
}
