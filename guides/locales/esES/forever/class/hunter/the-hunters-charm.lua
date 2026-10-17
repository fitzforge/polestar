-- Spanish (Spain) (esES): the guide forever/class/hunter/the-hunters-charm (forever/class/hunter/the-hunters-charm.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1447} Azshara · {area:1417} Sunken Temple
	["Experience at 50 through {zone:1447} and the {area:1417}; Forever removed the Classic item choice."] = "Experiencia a nivel 50 por {zone:1447} y el {area:1417}; Forever eliminó la elección de objeto de Classic.",
	["Experience"] = "Experiencia",

	-- Step 1: The Hunter's Charm (Alliance)
	-- {quest:8151} The Hunter's Charm
	["{quest:8151} (Alliance)"] = "{quest:8151} (Alianza)",
	-- {npc:5516} Ulfir Ironbeard · {zone:1453} Stormwind · {object:28027} Dwarven District · {npc:5116} Olmin Burningbeard · {zone:1455} Ironforge · {object:32390} Hall of Arms (no name in this language: may be words) · {zone:1457} Darnassus
	["At 50 any Alliance hunter trainer offers it: {npc:5516} in {zone:1453}'s {object:28027}, {npc:5116} in {zone:1455}'s {object:32390} or Dorion in {zone:1457}' Cenarion Enclave."] = "A nivel 50 cualquier instructor de cazadores de la Alianza la ofrece: {npc:5516} en {object:28027} de {zone:1453}, {npc:5116} en {object:32390} de {zone:1455} o Dorion en el Enclave Cenarion de {zone:1457}.",

	-- Step 2: The Hunter's Charm (Horde)
	-- {quest:8151} The Hunter's Charm
	["{quest:8151} (Horde)"] = "{quest:8151} (Horda)",
	-- {npc:3352} Ormak Grimshot · {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {npc:3039} Holt Thunderhorn · {area:1641} Hunter Rise · {zone:1456} Thunder Bluff
	["At 50 any Horde hunter trainer offers it: {npc:3352} in {zone:1454}'s {object:172958} or {npc:3039} on {area:1641} in {zone:1456}."] = "A nivel 50 cualquier instructor de cazadores de la Horda la ofrece: {npc:3352} en {object:172958} de {zone:1454} o {npc:3039} en {area:1641}, en {zone:1456}.",

	-- Step 3: Ogtinc
	-- {npc:8405} Ogtinc · {area:1221} Ruins of Eldarath · {area:3137} Talrendis Point · {area:1237} Valormok
	["{npc:8405} lives atop the cliffs north-east of the {area:1221}. Alliance: fly to {area:3137}; Horde: fly to {area:1237}."] = "{npc:8405} vive en lo alto de los acantilados al noreste de {area:1221}. Alianza: vuela a {area:3137}; Horda: vuela a {area:1237}.",

	-- Step 4: Courser Antlers
	-- {zone:1447} Azshara
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser · Perfect Courser Antlers = {item:20017} Perfect Courser Antler
	["Mosshoof Coursers graze all over {zone:1447}; one in a dozen or so drops a pair of Perfect Courser Antlers."] = "Los maledictores Pezuñamusgo ({npc:8761}) pastan por todo {zone:1447}; más o menos uno de cada doce suelta un par de cuernos perfectos ({item:20017}).",

	-- Step 6: Wavethrashing
	-- {zone:1447} Azshara
	-- plural, as words: Young Wavethrashers = {npc:6347} Young Wavethrasher · Great Wavethrashers = {npc:6349} Great Wavethrasher
	["Wavethrashers crawl along {zone:1447}'s coasts: Young Wavethrashers on the north-east shore and Wavethrashers on the east coast drop the scales about twice as often as the Great Wavethrashers of the south shore."] = "Los vándalos marinos recorren las costas de {zone:1447}: los Vándalos marinos jóvenes de la orilla noreste y los vándalos marinos de la costa este sueltan las escamas el doble de a menudo que los Grandes vándalos marinos de la orilla sur.",

	-- Step 8: Morphaz in the Sunken Temple
	-- {area:1417} Sunken Temple
	["Morphaz in the {area:1417}"] = "Morphaz en el {area:1417}",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears · {area:75} Stonard · {area:42} Darkshire · {area:1438} Nethergarde Keep
	["Morphaz is an elite dragon boss inside the {area:1417}, a five-player dungeon: bring a group. The temple stands in the middle of the {area:74}; swim down into it to reach the entrance. Horde: fly to {area:75}; Alliance: fly to {area:42} or {area:1438} and ride on."] = "Morphaz es un jefe dragón élite dentro del {area:1417}, una mazmorra para cinco jugadores: lleva un grupo. El templo está en medio de {area:74}; bucea hasta él para llegar a la entrada. Horda: vuela a {area:75}; Alianza: vuela a {area:42} o a {area:1438} y sigue cabalgando.",
	-- {item:20019} Tooth of Morphaz · {area:1417} Sunken Temple
	["{item:20019}, inside the {area:1417}"] = "{item:20019}, dentro del {area:1417}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 50 any Alliance hunter trainer offers it: {npc:5516} in {zone:1453}'s {object:28027}, {npc:5116} in {zone:1455}'s {object:32390} or Dorion in {zone:1457}' {area:1658}."] = "A nivel 50 cualquier instructor de cazadores de la Alianza la ofrece: {npc:5516} en {object:28027} de {zone:1453}, {npc:5116} en {object:32390} de {zone:1455} o Dorion en {area:1658} de {zone:1457}.",
}
