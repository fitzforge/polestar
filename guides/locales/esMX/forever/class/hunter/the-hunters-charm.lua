-- Spanish (Latin America) (esMX): the guide forever/class/hunter/the-hunters-charm (forever/class/hunter/the-hunters-charm.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1447} Azshara · {area:1417} Sunken Temple
	["Experience at 50 through {zone:1447} and the {area:1417}; Classic's item choice may be gone on Forever."] = "Experiencia a nivel 50 por {zone:1447} y {area:1417}; puede que en Forever ya no esté la elección de objeto de Classic.",
	["Experience"] = "Experiencia",

	-- Step 1: The Hunter's Charm (Alliance)
	-- {quest:8151} The Hunter's Charm
	["{quest:8151} (Alliance)"] = "{quest:8151} (Alianza)",
	-- {npc:5516} Ulfir Ironbeard · {zone:1453} Stormwind · {object:28027} Dwarven District · {npc:5116} Olmin Burningbeard · {zone:1455} Ironforge · {object:32390} Hall of Arms (no name in this language: may be words) · {zone:1457} Darnassus
	["At 50 any Alliance hunter trainer offers it: {npc:5516} in {zone:1453}'s {object:28027}, {npc:5116} in {zone:1455}'s {object:32390} or Dorion in {zone:1457}' Cenarion Enclave."] = "A nivel 50 la ofrece cualquier instructor de cazadores de la Alianza: {npc:5516} en {object:28027} de {zone:1453}, {npc:5116} en {object:32390} de {zone:1455} o Dorion en el Enclave Cenarion de {zone:1457}.",

	-- Step 2: The Hunter's Charm (Horde)
	-- {quest:8151} The Hunter's Charm
	["{quest:8151} (Horde)"] = "{quest:8151} (Horda)",
	-- {npc:3352} Ormak Grimshot · {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {npc:3039} Holt Thunderhorn · {area:1641} Hunter Rise · {zone:1456} Thunder Bluff
	["At 50 any Horde hunter trainer offers it: {npc:3352} in {zone:1454}'s {object:172958} or {npc:3039} on {area:1641} in {zone:1456}."] = "A nivel 50 la ofrece cualquier instructor de cazadores de la Horda: {npc:3352} en {object:172958} de {zone:1454} o {npc:3039} en {area:1641}, en {zone:1456}.",

	-- Step 3: Ogtinc
	-- {npc:8405} Ogtinc · {area:1221} Ruins of Eldarath · {zone:1447} Azshara · {area:3137} Talrendis Point · {area:1237} Valormok
	["{npc:8405} lives on a raised spot on the cliffs at the north-east rim of the {area:1221}, west-central {zone:1447}. Keep to the high ridges around the ruins: the pit below does not lead up to him. Alliance: fly to {area:3137}; Horde: fly to {area:1237}, a short ride west of him."] = "{npc:8405} vive en un punto elevado de los acantilados del borde noreste de {area:1221}, en el centro-oeste de {zone:1447}. Mantente en las crestas altas alrededor de las ruinas: el foso de abajo no sube hasta él. Alianza: vuela a {area:3137}; Horda: vuela a {area:1237}, a poca distancia al oeste de él.",

	-- Step 4: Courser Antlers
	-- {zone:1447} Azshara · {area:1220} Thalassian Base Camp · {area:1237} Valormok · {area:1234} Lake Mennar
	-- plural, as words: Perfect Courser Antlers = {item:20017} Perfect Courser Antler · Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["You need two Perfect Courser Antlers. Mosshoof Coursers (level 52-53, deer) graze all over {zone:1447} and drop one about one kill in twelve, so expect two dozen kills. Good herds: north of the {area:1220} in the north, and the hills north-east and south-east of {area:1237}; the {area:1234} area also has elite giants and dragonkin. They Enrage at 30% health. Coursers share spawn points with the Thunderhead hippogryphs: if none are around, kill the hippogryphs and coursers may spawn instead. Respawn is about five and a half minutes."] = "Necesitas dos Cornamentas de corcel perfectas. Los corceles Pezuña de Musgo (nivel 52-53, ciervos) pastan por todo {zone:1447} y sueltan una más o menos una vez de cada doce, así que cuenta con dos docenas de muertes. Buenas manadas: al norte de {area:1220}, en el norte, y las colinas al noreste y sureste de {area:1237}; la zona de {area:1234} también tiene gigantes y dragonantes élite. Se enfurecen al 30 % de salud. Los corceles comparten puntos de aparición con los hipogrifos Cabezatrueno: si no hay ninguno, mata a los hipogrifos y pueden aparecer corceles en su lugar. Reaparecen en unos cinco minutos y medio.",
	-- {item:20017} Perfect Courser Antler
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["{item:20017}, from Mosshoof Coursers"] = "{item:20017}, de los corceles Pezuña de Musgo",

	-- Step 6: Wavethrashing
	-- {item:20087} Wavethrasher Scales · {zone:1447} Azshara · {area:1229} Tower of Eldara · {spell:1494} Track Beasts
	-- plural, as words: Young Wavethrashers = {npc:6347} Young Wavethrasher · Great Wavethrashers = {npc:6349} Great Wavethrasher
	["You need six {item:20087}. Wavethrashers (three-headed sea beasts) live along {zone:1447}'s coasts, mostly underwater: the Young Wavethrashers (level 51-52) of the north-east shore drop a scale about one kill in three, the Wavethrashers (52-53) of the east coast by the {area:1229} about as often (a few walk the beach there), the Great Wavethrashers (53-54) of the south-east shore about one in seven. {spell:1494} does not show them; fight them where you can breathe, and bring water breathing if you can. Elite sharks swim the deeper water."] = "Necesitas seis {item:20087}. Los azotaolas (bestias marinas de tres cabezas) viven a lo largo de las costas de {zone:1447}, sobre todo bajo el agua: los azotaolas jóvenes (nivel 51-52) de la orilla noreste sueltan una escama más o menos una vez de cada tres, los azotaolas (52-53) de la costa este junto a {area:1229} con la misma frecuencia (algunos caminan por la playa ahí), y los grandes azotaolas (53-54) de la orilla sureste más o menos uno de cada siete. {spell:1494} no los muestra; pelea donde puedas respirar y lleva respiración acuática si puedes. Hay tiburones élite en las aguas más profundas.",

	-- Step 8: Morphaz in the Sunken Temple
	-- {area:1417} Sunken Temple
	["Morphaz in the {area:1417}"] = "Morphaz en {area:1417}",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears · {zone:1435} Swamp of Sorrows · {area:75} Stonard · {area:1438} Nethergarde Keep · {area:42} Darkshire · {npc:5710} Jammal'an the Prophet · {spell:12533} Acid Breath · {spell:11019} Wing Flap
	["Morphaz is an elite green drake (level 52) inside the {area:1417}, a five-player dungeon: needs a group of five. The temple stands in the {area:74} in eastern {zone:1435}: climb its outer steps, dive into the flooded hall and follow the stairs down to the entrance. Horde: fly to {area:75}; Alliance: fly to {area:1438} or {area:42} and ride on. He is not there when you arrive: first kill the six troll guardians on the platforms around the upper ring, which opens the way down to {npc:5710} in the Pit of Sacrifice. Jammal'an's death brings out two drakes, Weaver and Dreamscythe (pull them one at a time); when both are dead, Morphaz and Hazzas appear together and cannot be split. Clear the dragonkin around the pit first, because they call for help. Morphaz uses {spell:12533} and {spell:11019}. The tooth always drops. Warriors in the group may want the same run for the voodoo feathers of the balcony trolls."] = "Morphaz es un draco verde élite (nivel 52) dentro de {area:1417}, una mazmorra de cinco jugadores: necesita un grupo de cinco. El templo está en {area:74}, en el este de {zone:1435}: sube sus escalones exteriores, zambúllete en la sala inundada y sigue la escalera hacia abajo hasta la entrada. Horda: vuela a {area:75}; Alianza: vuela a {area:1438} o {area:42} y sigue a caballo. No está cuando llegas: primero mata a los seis guardianes trol de las plataformas del anillo superior, lo que abre el camino de bajada hasta {npc:5710} en el Foso del Sacrificio. La muerte de Jammal'an saca a dos dracos, Tejedor y Guadañasueño (atráelos de a uno); cuando ambos mueren, Morphaz y Hazzas aparecen juntos y no se pueden separar. Despeja antes a los dragonantes alrededor del foso, porque piden ayuda. Morphaz usa {spell:12533} y {spell:11019}. El diente siempre cae. Los guerreros del grupo pueden querer la misma salida por las plumas vudú de los trols del balcón.",
	-- {item:20019} Tooth of Morphaz · {area:1417} Sunken Temple
	["{item:20019}, inside the {area:1417}"] = "{item:20019}, dentro de {area:1417}",

	-- Step 9: The Green Drake
	-- {item:19991} Devilsaur Eye · {item:19992} Devilsaur Tooth · {item:20083} Hunting Spear
	["In Classic Ogtinc let you choose the {item:19991}, the {item:19992} or the {item:20083} here. Forever's change notes say the choice is gone, though its quest page still lists three unnamed rewards: look at the reward window before you hand in."] = "En Classic, Ogtinc te dejaba elegir aquí {item:19991}, {item:19992} o {item:20083}. Las notas de cambios de Forever dicen que la elección ya no está, aunque su página de misión todavía muestra tres recompensas sin nombre: mira la ventana de recompensas antes de entregar.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Experience at 50 through {zone:1447} and the {area:1417}; Forever removed the Classic item choice."] = "Experiencia a nivel 50 por {zone:1447} y {area:1417}; Forever quitó la elección de objeto de Classic.",
	-- ["Morphaz is an elite dragon boss inside the {area:1417}, a five-player dungeon: bring a group. The temple stands in the middle of the {area:74}; swim down into it to reach the entrance. Horde: fly to {area:75}; Alliance: fly to {area:42} or {area:1438} and ride on."] = "Morphaz es un jefe dragón élite dentro de {area:1417}, un calabozo de cinco jugadores: lleva un grupo. El templo está en medio de {area:74}; nada hacia abajo para llegar a la entrada. Horda: vuela a {area:75}; Alianza: vuela a {area:42} o {area:1438} y sigue cabalgando.",
	-- ["Mosshoof Coursers graze all over {zone:1447}; one in a dozen or so drops a pair of Perfect Courser Antlers."] = "Los Trotadores Pezuñamusgo ({npc:8761}) pastan por todo {zone:1447}; más o menos uno de cada doce suelta un par de {item:20017}.",
	-- ["Wavethrashers crawl along {zone:1447}'s coasts: Young Wavethrashers on the north-east shore and Wavethrashers on the east coast drop the scales about twice as often as the Great Wavethrashers of the south shore."] = "Los vándalos marinos recorren las costas de {zone:1447}: los Descarnadores marinos jóvenes de la orilla noreste y los vándalos marinos de la costa este sueltan las escamas casi el doble que los Grandes vándalos marinos de la orilla sur.",
	-- ["{npc:8405} lives atop the cliffs north-east of the {area:1221}. Alliance: fly to {area:3137}; Horde: fly to {area:1237}."] = "{npc:8405} vive en lo alto de los acantilados al noreste de {area:1221}. Alianza: vuela a {area:3137}; Horda: vuela a {area:1237}.",
}
