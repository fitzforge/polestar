-- Spanish (Spain) (esES): the guide forever/class/priest/blood-of-morphaz (forever/class/priest/blood-of-morphaz.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1447} Azshara · {area:1417} Sunken Temple
	["Experience and gold at 50 through {zone:1447} and the {area:1417}; Forever removed the Classic item choice."] = "Experiencia y oro a nivel 50 por {zone:1447} y {area:1417}; Forever quitó la elección de objeto de Classic.",
	["Experience and gold"] = "Experiencia y oro",

	-- Step 1: Cenarion Aid (Alliance)
	-- {quest:8254} Cenarion Aid
	["{quest:8254} (Alliance)"] = "{quest:8254} (Alianza)",
	-- {npc:5489} Brother Joshua · {zone:1453} Stormwind · {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {object:32386} Hall of Mysteries (no name in this language: may be words)
	["At 50 {npc:5489} in {zone:1453}'s Cathedral of Light or {npc:11406} in {zone:1455}'s {object:32386} offers it."] = "A nivel 50 te la ofrece {npc:5489}, en la Catedral de la Luz de {zone:1453}, o {npc:11406}, en {object:32386} de {zone:1455}.",

	-- Step 2: Cenarion Aid (Horde)
	-- {quest:8254} Cenarion Aid
	["{quest:8254} (Horde)"] = "{quest:8254} (Horda)",
	-- {npc:6018} Ur'kyo · {zone:1454} Orgrimmar · {object:172961} Valley of Spirits
	["At 50 {npc:6018} in {zone:1454}'s {object:172961} offers it."] = "A nivel 50 te la ofrece {npc:6018}, en {object:172961} de {zone:1454}.",

	-- Step 3: Ogtinc
	-- {npc:8405} Ogtinc · {area:1221} Ruins of Eldarath · {area:3137} Talrendis Point · {area:1237} Valormok
	["{npc:8405} lives atop the cliffs north-east of the {area:1221}. Alliance: fly to {area:3137}; Horde: fly to {area:1237}."] = "{npc:8405} vive en lo alto de los acantilados al noreste de {area:1221}. Alianza: vuela a {area:3137}; Horda: vuela a {area:1237}.",

	-- Step 4: Of Coursers We Know
	-- {zone:1447} Azshara · {item:20027} Healthy Courser Gland
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers graze all over {zone:1447}; about one in three drops a {item:20027}."] = "Los maledictores Pezuñamusgo pastan por todo {zone:1447}; más o menos uno de cada tres suelta una {item:20027}.",

	-- Step 6: The Ichor of Undeath
	-- {npc:7864} Lingering Highborne · {area:1221} Ruins of Eldarath · {npc:8405} Ogtinc · {area:3137} Talrendis Point
	-- plural, as words: Highborne Apparitions = {npc:6116} Highborne Apparition
	["Any undead can drop it. The {npc:7864} in the {area:1221}, below {npc:8405}'s cliffs, are the nearest; Highborne Apparitions and Lichlings haunt the ruins near {area:3137}."] = "Cualquier no-muerto puede soltarlo. Los más cercanos son {npc:7864} de {area:1221}, bajo los acantilados de {npc:8405}; las apariciones de Altonato y los exanimatos Altonato rondan las ruinas cerca de {area:3137}.",

	-- Step 8: Morphaz in the Sunken Temple
	-- {area:1417} Sunken Temple
	["Morphaz in the {area:1417}"] = "Morphaz en {area:1417}",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears · {area:75} Stonard · {area:42} Darkshire · {area:1438} Nethergarde Keep
	["Morphaz is an elite dragon boss inside the {area:1417}, a level 50 dungeon: bring a group of five. The temple stands in the middle of the {area:74}; swim down into it to reach the entrance. Horde: fly to {area:75}; Alliance: fly to {area:42} or {area:1438} and ride on."] = "Morphaz es un jefe dragón élite dentro de {area:1417}, una mazmorra de nivel 50: lleva un grupo de cinco. El templo está en medio de {area:74}; bucea hacia abajo para llegar a la entrada. Horda: vuela a {area:75}; Alianza: vuela a {area:42} o {area:1438} y sigue a caballo.",
	-- {quest:8257} Blood of Morphaz · {area:1417} Sunken Temple
	["{quest:8257}: the {area:1417} entrance"] = "{quest:8257}: entrada de {area:1417}",

	-- Step 9: Greta Mosshoof
	-- {npc:10922} Greta Mosshoof · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["{npc:10922} is at the {area:2479} in southern {zone:1448}."] = "{npc:10922} está en {area:2479}, en el sur de {zone:1448}.",
}
