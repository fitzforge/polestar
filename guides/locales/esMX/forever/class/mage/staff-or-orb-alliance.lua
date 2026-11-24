-- Spanish (Latin America) (esMX): the guide forever/class/mage/staff-or-orb-alliance (forever/class/mage/staff-or-orb-alliance.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:9514} Arcane Staff
	["Ley or {item:9514} or Orb (Alliance)"] = "Ley, {item:9514} u Orbe (Alianza)",
	["A staff or an off-hand orb at 10 from your home town's mage trainer; Skyborne add a wand."] = "Un bastón o un orbe de mano izquierda a nivel 10, del instructor de magos de tu ciudad de origen; los Skyborne suman una varita.",

	-- Step 1: Anathamaas Aetherwind (Valanaar)
	-- {npc:252373} Anathamaas Aetherwind · {area:16638} Valanaar · {npc:256507} Belann Windwood
	["At 10 {npc:252373}, the {area:16638} mage trainer, sends you to {npc:256507}, the staff merchant a few steps away in the same town."] = "A nivel 10, {npc:252373}, el instructor de magos de {area:16638}, te manda con {npc:256507}, el vendedor de bastones a pocos pasos en el mismo pueblo.",

	-- Step 2: The Windstone Formations
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The Windstone Formations"] = "Las Windstone Formations",
	-- {area:16636} Falaath Village
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The bough lies on the ground among the Windstone Formations, the wind shrine on the rise west of Fillion's camp, south of {area:16636}. It does not sparkle, so look at the ground by the stones; there are two spots for it."] = "La rama está en el suelo entre las Formaciones de piedra de viento, el santuario del viento en la elevación al oeste del campamento de Fillion, al sur de {area:16636}. No brilla, así que mira el suelo junto a las piedras; hay dos lugares posibles.",

	-- Step 3: Back to Belann Windwood
	-- {npc:256507} Belann Windwood
	["Back to {npc:256507}"] = "De vuelta con {npc:256507}",
	-- {quest:1861} Mirror Lake · {npc:5497} Jennea Cannon · {zone:1453} Stormwind
	["{quest:1861} (the next steps) waits for you with {npc:5497} in {zone:1453}, at about 15."] = "{quest:1861} (los pasos siguientes) te espera con {npc:5497} en {zone:1453}, alrededor del nivel 15.",

	-- Step 4: Zaldimar Wefhellt (Goldshire)
	-- {npc:328} Zaldimar Wefhellt · {area:87} Goldshire · {npc:5497} Jennea Cannon · {zone:1453} Stormwind · {quest:1879} Speak with Bink · {area:131} Kharanos · {quest:1861} Mirror Lake · {npc:5144} Bink
	["At 10 {npc:328}, the {area:87} mage trainer, upstairs in the Lion's Pride Inn, sends you to {npc:5497} in {zone:1453}. Taking it shuts out {quest:1879}, the {area:131} trainer's errand; {quest:1861} and {npc:5144}'s Gizmonitor shut out each other, so you get one staff or orb."] = "A nivel 10, {npc:328}, el instructor de magos de {area:87}, en el piso de arriba de la Posada Orgullo de León, te manda con {npc:5497} en {zone:1453}. Tomarla bloquea {quest:1879}, el encargo del instructor de {area:131}; {quest:1861} y el Gizmonitor de {npc:5144} se excluyen, así que recibes un bastón u orbe.",

	-- Step 5: Magis Sparkmantle (Kharanos)
	-- {npc:1228} Magis Sparkmantle · {area:131} Kharanos · {area:2102} Thunderbrew Distillery · {npc:5144} Bink · {zone:1455} Ironforge · {quest:1860} Speak with Jennea · {area:87} Goldshire · {npc:5497} Jennea Cannon · {quest:1861} Mirror Lake · {npc:328} Zaldimar Wefhellt
	["At 10 {npc:1228}, the {area:131} mage trainer in the {area:2102}, sends you to {npc:5144} in {zone:1455}. Taking it shuts out {quest:1860}, the {area:87} trainer's errand; {npc:5144}'s Gizmonitor and {npc:5497}'s {quest:1861} shut out each other, so you get one staff or orb. (A Gnome who took {npc:328}'s quest in {area:87} instead follows the {quest:1861} steps; a Human who took this one, the Gizmonitor steps.)"] = "A nivel 10, {npc:1228}, el instructor de magos de {area:131} en {area:2102}, te manda con {npc:5144} en {zone:1455}. Tomarla bloquea {quest:1860}, el encargo del instructor de {area:87}; el Gizmonitor de {npc:5144} y {quest:1861} de {npc:5497} se excluyen, así que recibes un bastón u orbe. (Un gnomo que tomó en su lugar la misión de {npc:328} en {area:87} sigue los pasos de {quest:1861}; un humano que tomó esta, los pasos del Gizmonitor.)",

	-- Step 6: Jennea Cannon
	-- {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:5497} Jennea Cannon · {item:7207} Jennea's Flask · {quest:1861} Mirror Lake
	["Follow the road north into {zone:1453} and west to the {object:2101}. {npc:5497} stands at the top of the Wizard's Sanctum, the tall violet tower: climb the spiral ramp and step into the portal near the top, which puts you beside her. She hands you {item:7207}. Skyborne mages take {quest:1861} from her when they first reach {zone:1453}, at about 15."] = "Sigue el camino al norte hasta {zone:1453} y al oeste hasta {object:2101}. {npc:5497} está en lo alto del Santuario del Mago, la alta torre violeta: sube por la rampa en espiral y entra al portal cerca de la cima, que te deja a su lado. Te da {item:7207}. Los magos Skyborne toman {quest:1861} con ella cuando llegan por primera vez a {zone:1453}, alrededor del nivel 15.",

	-- Step 7: The Mirror Lake waterfall
	-- {quest:1861} Mirror Lake
	["The {quest:1861} waterfall"] = "La cascada de {quest:1861}",
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate and head south-west to the waterfall that feeds {quest:1861}. Wade in under the falling water to the rock behind it and use {item:7207} there (a 5 second cast); it fails anywhere else. Level 10 Defias casters stand on the rocks either side of the falls and shoot from range: pull them one at a time or fill the flask from the water."] = "Sal de {zone:1453} por la puerta principal y ve al suroeste hasta la cascada que alimenta {quest:1861}. Métete bajo el agua que cae hasta la roca de atrás y usa {item:7207} ahí (5 segundos de lanzamiento); no funciona en ningún otro lugar. Lanzadores de hechizos Defias de nivel 10 están en las rocas a ambos lados de la cascada y disparan a distancia: atráelos de a uno o llena el frasco desde el agua.",
	-- {item:7207} Jennea's Flask
	["{item:7207}, under the falls"] = "{item:7207}, debajo de la cascada",

	-- Step 8: Back to Jennea Cannon
	-- {npc:5497} Jennea Cannon
	["Back to {npc:5497}"] = "De vuelta con {npc:5497}",
	["Back up the Wizard's Sanctum and through the portal. The orb is an off-hand for a one-hand weapon; the staff is a two-hander."] = "Vuelve a subir al Santuario del Mago y pasa por el portal. El orbe es de mano izquierda, para un arma de una mano; el bastón es de dos manos.",
	-- {npc:5497} Jennea Cannon · {item:7508} Ley Orb · {item:9513} Ley Staff
	["{npc:5497}: {item:7508} or {item:9513}"] = "{npc:5497}: {item:7508} o {item:9513}",

	-- Step 9: Bink
	-- {npc:5144} Bink · {object:32362} Mystic Ward (no name in this language: may be words) · {zone:1455} Ironforge · {object:32386} Hall of Mysteries (no name in this language: may be words)
	["{npc:5144} teaches mages in the {object:32362}, at the back of {zone:1455} past the {object:32386}."] = "{npc:5144} enseña a los magos en {object:32362}, al fondo de {zone:1455}, pasando {object:32386}.",

	-- Step 10: Bink's Toolbox
	-- {area:133} Gnomeregan
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome
	["Head west along the road to {area:133}. Just north of its entrance stand two huts; the toolbox is in the taller, eastern one, the hut with the lift: a small grey box on the ground floor, half under the table beside the lift. Leper Gnomes (level 8) guard the huts: pull them singly. There is only one toolbox and it takes 15 minutes to come back after someone opens it, so wait nearby if it is gone."] = "Ve al oeste por el camino hasta {area:133}. Justo al norte de su entrada hay dos chozas; la caja de herramientas está en la más alta, la del este, la choza con el elevador: una cajita gris en la planta baja, medio debajo de la mesa junto al elevador. Los gnomos leprosos (nivel 8) custodian las chozas: atráelos de a uno. Solo hay una caja de herramientas y tarda 15 minutos en volver después de que alguien la abre, así que espera cerca si no está.",

	-- Step 11: Back to Bink
	-- {npc:5144} Bink
	["Back to {npc:5144}"] = "De vuelta con {npc:5144}",
	-- {npc:5144} Bink · {item:7507} Arcane Orb · {item:9514} Arcane Staff
	["{npc:5144}: {item:7507} or {item:9514}"] = "{npc:5144}: {item:7507} o {item:9514}",

	-- Step 12: Belann Windwood's wand (optional)
	-- {npc:256507} Belann Windwood
	["{npc:256507}'s wand (optional)"] = "La varita de {npc:256507} (opcional)",
	-- {npc:256507} Belann Windwood · {area:16638} Valanaar · {zone:2521} Zephras Isle · {npc:252373} Anathamaas Aetherwind · {item:262668} Wind-Infused Bough · {area:16636} Falaath Village · {item:263430} Windbough Wand
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["{npc:256507}'s quest is open to Human and Gnome mages too, if you ever visit {area:16638} on {zone:2521}, the Skyborne home: {npc:252373}, the town's mage trainer, sends you to {npc:256507} next door, who wants a {item:262668} from the ground by the Windstone Formations south of {area:16636}, for the {item:263430}. It does not shut out the staff or the orb."] = "La misión de {npc:256507} también está disponible para magos humanos y gnomos, si alguna vez visitas {area:16638} en {zone:2521}, el hogar de los Skyborne: {npc:252373}, el instructor de magos del pueblo, te manda con {npc:256507}, al lado, que quiere una {item:262668} del suelo junto a las Formaciones de piedra de viento al sur de {area:16636}, a cambio de {item:263430}. No bloquea el bastón ni el orbe.",
}
