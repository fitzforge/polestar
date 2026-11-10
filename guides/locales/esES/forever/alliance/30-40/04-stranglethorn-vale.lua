-- Spanish (Spain) (esES): the guide forever/alliance/30-40/04-stranglethorn-vale (forever/alliance/30-40/04-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "Vuela a {area:42}",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "",

	-- Step 3: Nesingwary's Expedition
	-- {zone:1431} Duskwood · {area:99} Rebel Camp
	["From {zone:1431} take the road south into Stranglethorn; the hunters' tents stand just west of the road past the {area:99} turn-off."] = "Desde {zone:1431} toma el camino al sur hasta la Vega de Tuercespina; las tiendas de los cazadores están justo al oeste del camino, pasado el desvío al {area:99}.",
	-- {npc:715} Hemet Nesingwary · {zone:1441} Thousand Needles
	["{npc:715}, from {zone:1441}"] = "{npc:715}, desde {zone:1441}",

	-- Step 4: Young tigers and panthers
	["Young tigers and panthers"] = "Tigres y panteras jóvenes",
	["Both roam the grass around the camp and along the road north."] = "Ambos recorren la hierba alrededor del campamento y a lo largo del camino al norte.",

	-- Step 8: Stranglethorn Tigers
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["Stranglethorn Tigers"] = "Tigres de Tuercespina",
	["The adult tigers prowl the hills just south and west of the camp."] = "Los tigres adultos merodean por las colinas justo al sur y al oeste del campamento.",

	-- Step 9: Level 33.2
	["Level 33.2"] = "",
	-- {area:796} Scarlet Monastery
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["The jungle's quests climb to 37 from here: short of 33.2? Keep on the Stranglethorn Tigers in the hills just south and west of the camp until level 33.2. Or, with a group, run the {area:796} dungeon (Library) instead."] = "",
	-- {npc:682} Stranglethorn Tiger
	["grind on {npc:682}"] = "",

	-- Step 10: Ajeck Rouack
	-- {area:99} Rebel Camp
	["The elder tigers come later, on the way back from the {area:99}"] = "Los tigres mayores vienen después, a la vuelta del {area:99}",

	-- Step 11: Panthers, raptors and elder tigers
	["Panthers, raptors and elder tigers"] = "Panteras, raptores y tigres mayores",
	-- plural, as words: Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Back south past Nesingwary: Panthers and Stranglethorn Raptors run in the clearings west of the camp toward the coast; the elder tigers hold the hills south-west."] = "Vuelve al sur, pasado Nesingwary: las Panteras y los Raptores de Tuercespina corren por los claros al oeste del campamento, hacia la costa; los tigres mayores ocupan las colinas del suroeste.",
	-- {item:4614} Pendant of Myzrael
	["Gluggle, a rare murloc on the coast west of camp, drops the {item:4614}: take it if you meet him"] = "Gluggle, un múrloc raro de la costa al oeste del campamento, suelta el {item:4614}: cógelo si te lo encuentras",

	-- Step 12: Sir S. J. Erlgadin
	-- {area:99} Rebel Camp
	["Back east to Nesingwary's camp on the way north to the {area:99}."] = "",

	-- Step 13: Rebel Camp
	-- {npc:738} Private Thorsen · {area:99} Rebel Camp
	["Take the road north; the camp sits in the hills to the west.\n{npc:738} spends most of his time at the top of the {area:99}'s path, by the huts, and now and then walks down it to the road and back (about eight minutes). If he isn't at the arrow, look along that path."] = "",
	-- {npc:469} Lieutenant Doren
	["{npc:469}, in the hut"] = "{npc:469}, en la cabaña",
	-- {npc:469} Lieutenant Doren · {quest:200} Bookie Herod · {area:101} Kurzen's Compound
	["{npc:469}: {quest:200}'s records lie at the edge of {area:101}, next"] = "",
	-- {npc:770} Corporal Kaleb · {npc:773} Krazek · {area:35} Booty Bay
	["{npc:770}: for {npc:773} in {area:35}, later in this guide"] = "",

	-- Step 14: Kurzen's Compound: kill these as you meet them
	-- {area:101} Kurzen's Compound
	["{area:101}: kill these as you meet them"] = "",
	-- {area:99} Rebel Camp · {quest:200} Bookie Herod
	["The Kurzen rebels hold the camp east of the {area:99}; work its outer edge, where Jungle Fighters and Medicine Men stand, and loot the supply crates by the tents. {quest:200}'s records lie in a hut on the compound's west side."] = "",
	-- {object:287} Bookie Herod's Records
	["{object:287}, in the hut"] = "",
	["The strongbox is deeper in, by the cave: on the northern loop (04b)"] = "",
	-- {item:2634} Venom Fern Extract · {object:263} Kurzen Supplies
	["{item:2634}, from a {object:263} crate"] = "{item:2634}, de una caja de {object:263}",

	-- Step 15: Level 33.6
	["Level 33.6"] = "",
	-- {area:796} Scarlet Monastery
	-- plural, as words: Kurzen Jungle Fighters = {npc:937} Kurzen Jungle Fighter
	["Short of 33.6? Keep on the Kurzen Jungle Fighters and Medicine Men around the compound's outer edge until level 33.6. Or, with a group, run the {area:796} dungeon (Library) instead."] = "",
	-- {npc:937} Kurzen Jungle Fighter
	["grind on {npc:937}"] = "",

	-- Step 17: Stranglethorn Vale: kill these as you meet them
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434}: kill these as you meet them"] = "",
	["Careful: Troll camps are close to the tiger area, and trolls can join a fight if you pull carelessly.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "",

	-- Step 18: Level 34
	["Level 34"] = "",
	-- {area:796} Scarlet Monastery
	["The quests from here on are 37: if you are short of 34, keep on the elder tigers in the hills south-west of Nesingwary's camp until level 34. Or, with a group, run the {area:796} dungeon (Library or Armory) instead."] = "",
	-- {npc:1085} Elder Stranglethorn Tiger
	["grind on {npc:1085}"] = "",

	-- Step 19: Nesingwary's Expedition
	-- {npc:716} Barnil Stonepot · {item:2755} Green Hills of Stranglethorn
	["{npc:716} collects the {item:2755}: the pages drop from almost every humanoid in the jungle. Turn the pages into chapters as you go."] = "{npc:716} colecciona {item:2755}: casi todos los humanoides de la selva sueltan las páginas. Convierte las páginas en capítulos sobre la marcha.",

	-- Step 20: Sin'Dall and the Lashtail raptors
	-- {npc:729} Sin'Dall
	["{npc:729} and the Lashtail raptors"] = "{npc:729} y los raptores colazote",
	-- {npc:729} Sin'Dall · {area:35} Booty Bay
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{npc:729}, the great tiger, lairs on the hilltop south-west of the camp; Lashtail Raptors run south of it, along the way to {area:35}."] = "{npc:729}, el gran tigre, tiene su guarida en la cima de la colina al suroeste del campamento; los Raptores colazote corren al sur de ella, de camino a {area:35}.",

	-- Step 21: Down to Booty Bay
	-- {area:35} Booty Bay
	["Down to {area:35}"] = "Bajada a {area:35}",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {area:35} Booty Bay
	["Follow the main road south the length of the jungle, past the {object:3202} turn-off, to {area:35} on the southern cape."] = "Sigue el camino principal al sur a lo largo de toda la selva, pasado el desvío a {object:3202}, hasta {area:35}, en el cabo sur.",
	-- {npc:2495} Drizzlik
	["{npc:2495}, by the bank; inside"] = "",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "",
	-- {npc:6807} Innkeeper Skindle · {object:56910} The Salty Sailor Tavern
	["{npc:6807}, {object:56910}; upstairs"] = "",
	-- {npc:2832} Nixxrax Fillamug · {object:56910} The Salty Sailor Tavern
	["{npc:2832}, in the {object:56910}; upstairs"] = "",
	-- {npc:773} Krazek
	["{npc:773}, in the tavern; upstairs"] = "",
	-- {npc:773} Krazek · {npc:770} Corporal Kaleb
	["{npc:773}, from {npc:770}"] = "",
	-- {npc:737} Kebok
	["{npc:737}, in the tavern"] = "{npc:737}, en la taberna",
	-- {npc:737} Kebok
	-- plural, as words: Tumbled Crystals = {item:4106} Tumbled Crystal
	["{npc:737}: the Tumbled Crystals, on the northern loop"] = "",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs in the tavern"] = "{npc:2496}, en el piso de arriba de la taberna",

	-- Step 22: Fly to Sentinel Hill
	-- {area:108} Sentinel Hill
	["Fly to {area:108}"] = "",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "",

	-- Step 24: The Savage Coast: kill these as you meet them
	-- {area:301} The Savage Coast
	["{area:301}: kill these as you meet them"] = "",
	-- {area:108} Sentinel Hill · {zone:1436} Westfall · {area:310} Crystalvein Mine
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["From {area:108} the way leads south out of {zone:1436} into Stranglethorn's north-west, to the {area:310} near the coast; the Crystal Spine Basilisks around it drop the shards.\nThe haunted island lies just off the coast south-west of the mine: just reach it. The Bloodscalp trolls hold the ruins on the coast to the north."] = "",
	["The haunted island"] = "La isla fantasma",

	-- Step 25: River crocolisks
	["River crocolisks"] = "Crocoliscos fluviales",
	-- {area:99} Rebel Camp
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["River Crocolisks swim the river by the {area:99}."] = "Los Crocoliscos fluviales nadan en el río junto al {area:99}.",

	-- Step 26: Private Thorsen
	-- {npc:738} Private Thorsen · {area:99} Rebel Camp
	["{npc:738} spends most of his time at the top of the {area:99}'s path, by the huts, and now and then walks down it to the road and back (about eight minutes). If he isn't at the arrow, look along that path."] = "",

	-- Step 27: Nesingwary's Expedition
	-- {quest:201} Investigate the Camp
	["{quest:201}: just look around the hunters' camp"] = "{quest:201}: basta con echar un vistazo por el campamento de los cazadores",

	-- Step 28: Booty Bay
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "",
	-- {npc:2495} Drizzlik
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["{npc:2495}: the Snapjaw Crocolisks, on the northern loop"] = "",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}: the water elementals rise around the haunted island, on the northern loop"] = "",

	-- Step 29: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Vuela a {zone:1453}",

	-- Step 31: Collin Mauren
	-- {npc:4078} Collin Mauren · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["{npc:4078} is in the {object:2164}, in the {object:2101}."] = "",

	-- Step 32: Druid training
	["Druid training"] = "Entrenamiento de druida",
	-- {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {object:2101} Mage Quarter
	["{npc:5504}, the druid trainer, stands in {zone:1453}, north-west of the {object:2101}."] = "",

	-- Step 34: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "",

	-- Step 35: Heartswood
	-- {area:415} Astranaar · {quest:1738} Heartswood · {area:413} Maestra's Post · {quest:65602} What Is Love? · {item:190309} Wooden Figurine
	["From {area:415} head north-west into the hills: the {quest:1738} is a glowing tree north of the road to {area:413}. If you took {quest:65602}, the {item:190309} lies in a house among the trees north of {area:413} (26.6,22.0). Then take the road west to Stonetalon."] = "",
	-- {item:190309} Wooden Figurine · {area:413} Maestra's Post
	["{item:190309}, north of {area:413}"] = "{item:190309}, al norte de {area:413}",

	-- Step 36: Stonetalon Mountains
	-- {area:608} Nijel's Point
	["The road to {area:608}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Bloodscalp trolls"] = "Trols Cabellesangre",
	-- ["Fly from {area:150} to {area:1537} and train."] = "Vuela de {area:150} a {area:1537} y entrena.",
	-- ["Fly to {area:42}: {npc:1573} in {area:1537}'s {object:32372}, or {npc:352} in {zone:1453}'s {object:2096}."] = "Vuela a {area:42}: {npc:1573}, en {object:32372} de {area:1537}, o {npc:352}, en {object:2096} de {zone:1453}.",
	-- ["Follow the west coast north; the haunted island lies off the shore west of Nesingwary's camp. Just reach it."] = "Sigue la costa oeste al norte; la isla fantasma está frente a la orilla, al oeste del campamento de Nesingwary. Basta con llegar a ella.",
	-- ["For Archmage Ansirem in {zone:1416}"] = "Para el Archimago Ansirem, en {zone:1416}",
	-- ["Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave. Pick up Green Hills pages as they drop."] = "Los Reductores de cabezas están en el interior de la base; los Comandos acechan en sigilo a su alrededor y en la cueva. Recoge las páginas de Las verdes colinas según caigan.",
	-- ["Herod's records lie in a hut on the compound's west side; his strongbox sits farther east, by the cave mouth."] = "Los documentos de Herod están en una cabaña del lado oeste de la base; su caja fuerte está más al este, junto a la entrada de la cueva.",
	-- ["Loop through the troll ruins of the north and centre: each holds one stone tablet of the troll legends. Shadowmaw Panthers prowl stealthed in the jungle around them; the Venture Co. camp on {area:37} carries the Tumbled Crystals."] = "Recorre en círculo las ruinas trols del norte y del centro: cada una guarda una tablilla de piedra con las leyendas trols. Las Panteras Faucesombría merodean en sigilo por la selva que las rodea; en el campamento de Ventura y Cía. del {area:37} están los Cristales caídos.",
	-- ["Skullsplitter trolls"] = "Trols Machacacráneos",
	-- ["Snapjaw Crocolisks"] = "Crocoliscos Quijaforte",
	-- ["Snapjaw Crocolisks bask on the shore and islands along the coast north of {area:35}."] = "Los Crocoliscos Quijaforte toman el sol en la orilla y en las islas de la costa al norte de {area:35}.",
	-- ["Take the road north; {npc:738} patrols it, the camp sits in the hills to the west."] = "Toma el camino al norte; {npc:738} lo patrulla y el campamento está en las colinas del oeste.",
	-- ["Take the road north; {npc:738} stands on it, the camp sits in the hills to the west."] = "Toma el camino al norte; {npc:738} está en él y el campamento, en las colinas del oeste.",
	-- ["The Bloodscalp trolls hold the ruins on the coast west of Nesingwary's camp."] = "Los trols Cabellesangre ocupan las ruinas de la costa al oeste del campamento de Nesingwary.",
	-- ["The Kurzen rebels hold the camp east of the {area:99}; work its outer edge, where Jungle Fighters and Medicine Men stand, and loot the supply crates by the tents."] = "Los rebeldes de Kurzen ocupan el campamento al este del {area:99}; recorre su borde exterior, donde están los Jíbaros y los Auxiliadores, y saquea las cajas de suministros junto a las tiendas.",
	-- ["The Skullsplitter trolls hold the ruins east of the road between Nesingwary and {object:3202}."] = "Los trols Machacacráneos ocupan las ruinas al este del camino entre Nesingwary y {object:3202}.",
	-- ["The jungle ruins"] = "Las ruinas de la selva",
	-- ["The ore drops from Drywhisker kobolds in {zone:1417}"] = "El mineral lo sueltan los kóbolds Mostacho Seco de {zone:1417}",
	-- ["Thorsen patrols the road north of camp, toward the {area:99}."] = "Thorsen patrulla el camino al norte del campamento, hacia el {area:99}.",
	-- ["Walk back north; the {area:310} lies west of the road in the middle of the jungle. The Crystal Spine Basilisks there drop the shards."] = "Vuelve al norte; la {area:310} está al oeste del camino, en el centro de la selva. Los Basiliscos Espina de Cristal de allí sueltan los fragmentos.",
	-- ["{area:1537} has no druid trainer: take the {area:2257} from {object:171524} to {zone:1453} and train with {npc:5504}."] = "{area:1537} no tiene instructor de druidas: toma el {area:2257} desde {object:171524} hasta {zone:1453} y entrena con {npc:5504}.",
	-- ["{npc:2495}, by the bank"] = "{npc:2495}, junto al banco",
	-- ["{npc:2832}, in the {object:56910}"] = "{npc:2832}, en la {object:56910}",
	-- ["{npc:2859}, on the top floor by the docks"] = "{npc:2859}, en el piso de arriba junto a los muelles",
	-- ["{npc:770}: for {npc:773} in {area:35}"] = "{npc:770}: para {npc:773}, en {area:35}",
	-- ["{npc:773}, in the tavern"] = "{npc:773}, en la taberna",
	-- ["{quest:207}: four troll legends"] = "{quest:207}: cuatro leyendas trols",
}
