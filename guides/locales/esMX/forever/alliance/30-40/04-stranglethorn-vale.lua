-- Spanish (Latin America) (esMX): the guide forever/alliance/30-40/04-stranglethorn-vale (forever/alliance/30-40/04-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "",

	-- Step 2: Druid training
	["Druid training"] = "Entrenamiento de druida",
	-- {zone:1455} Ironforge · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind · {npc:5504} Sheldras Moontree
	["{zone:1455} has no druid trainer: take the {area:2257} from {object:171524} to {zone:1453} and train with {npc:5504}."] = "",

	-- Step 3: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "",

	-- Step 5: Nesingwary's Expedition
	-- {zone:1431} Duskwood · {area:99} Rebel Camp
	["From {zone:1431} take the road south into Stranglethorn; the hunters' tents stand just west of the road past the {area:99} turn-off."] = "Desde {zone:1431} toma el camino al sur hacia Tuercespina; las tiendas de los cazadores están justo al oeste del camino, pasado el desvío a {area:99}.",
	-- {npc:715} Hemet Nesingwary · {zone:1441} Thousand Needles
	["{npc:715}, from {zone:1441}"] = "{npc:715}, de {zone:1441}",

	-- Step 6: Young tigers and panthers
	["Young tigers and panthers"] = "Tigres jóvenes y panteras",
	["Both roam the grass around the camp and along the road north."] = "Ambos deambulan por la hierba alrededor del campamento y a lo largo del camino al norte.",

	-- Step 10: Stranglethorn Tigers
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["Stranglethorn Tigers"] = "Tigres de Tuercespina",
	["The adult tigers prowl the hills just south and west of the camp."] = "Los tigres adultos merodean por las colinas justo al sur y al oeste del campamento.",

	-- Step 11: Ajeck Rouack
	-- {area:99} Rebel Camp
	["The elder tigers come later, on the way back from the {area:99}"] = "Los tigres mayores vienen después, al regresar de {area:99}",

	-- Step 12: Panthers, raptors and elder tigers
	["Panthers, raptors and elder tigers"] = "Panteras, raptores y tigres mayores",
	-- plural, as words: Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Back south past Nesingwary: Panthers and Stranglethorn Raptors run in the clearings west of the camp toward the coast; the elder tigers hold the hills south-west."] = "De vuelta al sur pasando a Nesingwary: las panteras y los raptores de Tuercespina corren por los claros al oeste del campamento hacia la costa; los tigres mayores ocupan las colinas del suroeste.",
	-- {item:4614} Pendant of Myzrael
	["Gluggle, a rare murloc on the coast west of camp, drops the {item:4614}: take it if you meet him"] = "Gluggle, un múrloc raro en la costa al oeste del campamento, suelta {item:4614}: tómalo si te lo encuentras",

	-- Step 13: Rebel Camp
	-- {npc:738} Private Thorsen
	["Take the road north; {npc:738} patrols it, the camp sits in the hills to the west."] = "Toma el camino al norte; {npc:738} lo patrulla, y el campamento está en las colinas al oeste.",
	-- {npc:469} Lieutenant Doren
	["{npc:469}, in the hut"] = "{npc:469}, en la cabaña",

	-- Step 14: Bookie Herod
	["Herod's records lie in a hut on the compound's west side; his strongbox sits farther east, by the cave mouth."] = "Los documentos de Herod están en una cabaña en el lado oeste de la base; su caja fuerte está más al este, junto a la boca de la cueva.",
	-- {object:287} Bookie Herod's Records
	["{object:287}, upstairs"] = "",

	-- Step 15: Kurzen's Compound: kill these as you meet them
	-- {area:101} Kurzen's Compound
	["{area:101}: kill these as you meet them"] = "",
	-- {area:99} Rebel Camp
	["The Kurzen rebels hold the camp east of the {area:99}; work its outer edge, where Jungle Fighters and Medicine Men stand, and loot the supply crates by the tents."] = "Los rebeldes de Kurzen ocupan el campamento al este de {area:99}; recorre su borde exterior, donde están los jíbaros y auxiliadores, y saquea las cajas de suministros junto a las tiendas.",
	-- {item:2634} Venom Fern Extract · {object:263} Kurzen Supplies
	["{item:2634}, from a {object:263} crate"] = "{item:2634}, de una caja de {object:263}",

	-- Step 16: Bookie Herod
	-- {object:288} Bookie Herod's Strongbox
	["{object:288}, below ground"] = "",

	-- Step 18: Elder Stranglethorn Tiger
	["Careful: Troll camps are close to the tiger area, and trolls can join a fight if you pull carelessly."] = "",

	-- Step 19: Down to Booty Bay
	-- {area:35} Booty Bay
	["Down to {area:35}"] = "Baja a {area:35}",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {area:35} Booty Bay
	["Follow the main road south the length of the jungle, past the {object:3202} turn-off, to {area:35} on the southern cape."] = "Sigue el camino principal al sur a lo largo de toda la jungla, pasando el desvío a {object:3202}, hasta {area:35}, en el cabo sur.",
	["Upstairs"] = "",
	-- {npc:2832} Nixxrax Fillamug · {object:56910} Salty Sailor Tavern
	["{npc:2832}, in the {object:56910}; upstairs"] = "",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "",
	-- {npc:737} Kebok
	["{npc:737}, in the tavern"] = "{npc:737}, en la taberna",
	-- {npc:773} Krazek
	["{npc:773}, in the tavern; upstairs"] = "",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs in the tavern"] = "{npc:2496}, en el piso de arriba de la taberna",
	-- {npc:2495} Drizzlik
	["{npc:2495}, by the bank; inside"] = "",

	-- Step 20: Large River Crocolisk Skin on the way
	-- {item:4053} Large River Crocolisk Skin
	["{item:4053} on the way"] = "",

	-- Step 21: Bal'lal Ruins: kill these as you meet them
	-- {area:123} Bal'lal Ruins
	["{area:123}: kill these as you meet them"] = "",
	-- {area:310} Crystalvein Mine
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["The Bloodscalp trolls hold the ruins on the coast west of Nesingwary's camp.\nWalk back north; the {area:310} lies west of the road in the middle of the jungle. The Crystal Spine Basilisks there drop the shards."] = "",
	-- {npc:689} Crystal Spine Basilisk
	["grind on {npc:689}"] = "",

	-- Step 22: Panthers, raptors and elder tigers
	["Careful: The raptor nest has young raptors that join the fight when you attack the adults."] = "",

	-- Step 23: Nesingwary's Expedition
	-- {npc:716} Barnil Stonepot · {item:2755} Green Hills of Stranglethorn
	["{npc:716} collects the {item:2755}: the pages drop from almost every humanoid in the jungle. Turn the pages into chapters as you go."] = "{npc:716} colecciona {item:2755}: las páginas las sueltan casi todos los humanoides de la jungla. Convierte las páginas en capítulos sobre la marcha.",

	-- Step 24: Shadowmaw Panther on the way
	-- {npc:684} Shadowmaw Panther
	["{npc:684} on the way"] = "",

	-- Step 25: Sin'Dall and the Lashtail raptors
	-- {npc:729} Sin'Dall
	["{npc:729} and the Lashtail raptors"] = "{npc:729} y los raptores colazote",
	-- {npc:729} Sin'Dall · {area:35} Booty Bay
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{npc:729}, the great tiger, lairs on the hilltop south-west of the camp; Lashtail Raptors run south of it, along the way to {area:35}."] = "{npc:729}, el gran tigre, tiene su guarida en la cima de la colina al suroeste del campamento; los raptores colazote corren al sur de ella, por el camino a {area:35}.",

	-- Step 26: Nesingwary's Expedition
	-- {quest:201} Investigate the Camp
	["{quest:201}: just look around the hunters' camp"] = "{quest:201}: solo echa un vistazo al campamento de los cazadores",

	-- Step 27: River crocolisks
	["River crocolisks"] = "Crocoliscos fluviales",
	-- {area:99} Rebel Camp
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["River Crocolisks swim the river by the {area:99}."] = "Los crocoliscos fluviales nadan en el río junto a {area:99}.",

	-- Step 28: Private Thorsen
	-- {area:99} Rebel Camp
	["Thorsen patrols the road north of camp, toward the {area:99}."] = "Thorsen patrulla el camino al norte del campamento, hacia {area:99}.",

	-- Step 29: Level 35.37
	["Level 35.37"] = "",
	-- {area:35} Booty Bay
	["Top up here to level 35.37 before the hand-ins at {area:35}: they take you to level 36."] = "",
	-- {npc:1150} River Crocolisk
	["grind on {npc:1150}"] = "",

	-- Step 30: Hearth to Booty Bay
	-- {area:35} Booty Bay
	["Hearth to {area:35}"] = "",

	-- Step 31: Booty Bay
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "",

	-- Step 32: Snapjaw Crocolisks
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks"] = "Crocoliscos Quijaforte",
	-- {area:35} Booty Bay
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks bask on the shore and islands along the coast north of {area:35}."] = "Los crocoliscos Quijaforte toman el sol en la orilla y las islas de la costa al norte de {area:35}.",

	-- Step 34: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "",

	-- Step 35: Into Stranglethorn Vale
	-- {area:33} Stranglethorn Vale
	["Into {area:33}"] = "",

	-- Step 37: Kurzen's Compound
	-- plural, as words: Kurzen Commandos = {npc:938} Kurzen Commando
	["Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave. Pick up Green Hills pages as they drop.\nCareful: Kurzen Commandos are level 34-35, not elite, and often spawn stealthed; near death they use Smoke Bomb."] = "",
	-- {npc:941} Kurzen Headshrinker
	["{npc:941}, below ground"] = "",

	-- Step 38: The jungle ruins
	["The jungle ruins"] = "Las ruinas de la jungla",
	-- {area:37} Lake Nazferiti
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Loop through the troll ruins of the north and centre: each holds one stone tablet of the troll legends. Shadowmaw Panthers prowl stealthed in the jungle around them; the Venture Co. camp on {area:37} carries the Tumbled Crystals."] = "Recorre las ruinas trol del norte y del centro: cada una guarda una tablilla de piedra de las leyendas trol. Las panteras Faucesombría merodean en sigilo por la jungla a su alrededor; el campamento de Ventura y Cía. en {area:37} lleva los cristales caídos.",
	-- {item:2006} The Second Troll Legend · {object:58} Gri'lek the Wanderer
	["{item:2006}: {object:58}; underwater"] = "",

	-- Step 39: The haunted island
	["The haunted island"] = "La isla embrujada",
	["Follow the west coast north; the haunted island lies off the shore west of Nesingwary's camp. Just reach it."] = "Sigue la costa oeste al norte; la isla embrujada está frente a la costa, al oeste del campamento de Nesingwary. Solo llega hasta ella.",

	-- Step 40: Ruins of Zul'Kunda
	-- {npc:684} Shadowmaw Panther
	["grind on {npc:684}"] = "",

	-- Step 41: Venture Co. Base Camp
	-- {npc:1096} Venture Co. Geologist
	["grind on {npc:1096}"] = "",

	-- Step 42: Rebel Camp
	-- {npc:770} Corporal Kaleb · {npc:773} Krazek · {area:35} Booty Bay
	["{npc:770}: for {npc:773} in {area:35}"] = "{npc:770}: para {npc:773} en {area:35}",

	-- Step 45: Jungle Stalker on the way
	-- {npc:687} Jungle Stalker
	["{npc:687} on the way"] = "",

	-- Step 46: Skullsplitter trolls
	["Skullsplitter trolls"] = "Trols Machacacráneos",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The Skullsplitter trolls hold the ruins east of the road between Nesingwary and {object:3202}."] = "Los trols Machacacráneos ocupan las ruinas al este del camino entre Nesingwary y {object:3202}.",

	-- Step 49: Booty Bay
	-- {object:56910} Salty Sailor Tavern
	["{object:56910} is the tall building over the harbour; most of the quest givers are on its floors or the docks below."] = "",
	-- {zone:1417} Arathi Highlands
	["The ore drops from Drywhisker kobolds in {zone:1417}"] = "El mineral lo sueltan los kóbolds Mostacho Seco en {zone:1417}",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "",

	-- Step 51: Into Westfall
	-- {area:40} Westfall
	["Into {area:40}"] = "",

	-- Step 53: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "",
	-- {area:108} Sentinel Hill
	["{area:108} flight master"] = "",

	-- Step 54: Baron Revilgaz
	-- {zone:1416} Alterac Mountains
	["For Archmage Ansirem in {zone:1416}"] = "Para el archimago Ansirem en {zone:1416}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Bloodscalp trolls"] = "Trols Sangrapellejo",
	-- ["Fly from {area:150} to {area:1537} and train."] = "Vuela de {area:150} a {area:1537} y entrena.",
	-- ["Fly to {area:42}: {npc:1573} in {area:1537}'s {object:32372}, or {npc:352} in {zone:1453}'s {object:2096}."] = "Vuela a {area:42}: {npc:1573} en {object:32372} de {area:1537}, o {npc:352} en {object:2096} de {zone:1453}.",
	-- ["Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave. Pick up Green Hills pages as they drop."] = "Los reductores de cabezas están más adentro de la base; los comandos acechan en sigilo a su alrededor y en la cueva. Recoge las páginas de Las verdes colinas cuando caigan.",
	-- ["Take the road north; {npc:738} stands on it, the camp sits in the hills to the west."] = "Toma el camino al norte; {npc:738} está en él, y el campamento está en las colinas al oeste.",
	-- ["The Bloodscalp trolls hold the ruins on the coast west of Nesingwary's camp."] = "Los trols Sangrapellejo ocupan las ruinas de la costa al oeste del campamento de Nesingwary.",
	-- ["Walk back north; the {area:310} lies west of the road in the middle of the jungle. The Crystal Spine Basilisks there drop the shards."] = "Regresa al norte; {area:310} está al oeste del camino, en medio de la jungla. Los basiliscos Espina de Cristal de allí sueltan los fragmentos.",
	-- ["{area:1537} has no druid trainer: take the {area:2257} from {object:171524} to {zone:1453} and train with {npc:5504}."] = "{area:1537} no tiene instructor de druidas: toma el {area:2257} desde {object:171524} hasta {zone:1453} y entrena con {npc:5504}.",
	-- ["{npc:2495}, by the bank"] = "{npc:2495}, junto al banco",
	-- ["{npc:2832}, in the {object:56910}"] = "{npc:2832}, en la {object:56910}",
	-- ["{npc:2859}, on the top floor by the docks"] = "{npc:2859}, en el piso superior junto a los muelles",
	-- ["{npc:773}, in the tavern"] = "{npc:773}, en la taberna",
	-- ["{quest:207}: four troll legends"] = "{quest:207}: cuatro leyendas trol",
}
