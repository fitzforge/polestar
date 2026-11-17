-- Spanish (Latin America) (esMX): the guide forever/alliance/30-40/04-stranglethorn-vale (forever/alliance/30-40/04-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Barco a {area:35}",
	-- {area:392} Ratchet · {area:35} Booty Bay
	["The boat from {area:392}'s dock crosses to {area:35}, on Stranglethorn's southern cape."] = "",

	-- Step 2: Booty Bay
	["Bind your hearthstone at the inn: it is your way back here from the north of the jungle at the end of the loop."] = "",
	-- {npc:2495} Drizzlik
	["{npc:2495}, by the bank; inside"] = "{npc:2495}, junto al banco; adentro",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}, adentro",
	-- {npc:6807} Innkeeper Skindle · {object:56910} The Salty Sailor Tavern
	["{npc:6807}, {object:56910}; upstairs"] = "{npc:6807}, {object:56910}; arriba",
	-- {npc:2832} Nixxrax Fillamug · {object:56910} The Salty Sailor Tavern
	["{npc:2832}, in the {object:56910}; upstairs"] = "{npc:2832}, en {object:56910}; arriba",
	-- {npc:773} Krazek · {npc:738} Private Thorsen · {area:99} Rebel Camp
	["{npc:773}, in the tavern; upstairs: {npc:738} is at the {area:99}, on the way"] = "",
	-- {npc:773} Krazek
	["{npc:773}: Nesingwary's camp, on the way"] = "",
	-- {npc:737} Kebok
	["{npc:737}, in the tavern"] = "{npc:737}, en la taberna",
	-- {npc:737} Kebok
	-- plural, as words: Tumbled Crystals = {item:4106} Tumbled Crystal
	-- was: ["{npc:737}: the Tumbled Crystals, on the northern loop"] = "{npc:737}: los cristales pulidos, en el circuito del norte"
	["{npc:737}: the Tumbled Crystals, on the northern loop"] = "{npc:737}: los cristales pulidos, en el circuito del norte",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs in the tavern"] = "{npc:2496}, en el piso de arriba de la taberna",

	-- Step 3: North to Nesingwary's Expedition
	-- {area:100} Nesingwary's Expedition
	["North to {area:100}"] = "",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Follow the main road north the length of the jungle, past the {object:3202} turn-off, to the hunters' camp just west of the road."] = "",

	-- Step 4: Nesingwary's Expedition
	-- {npc:773} Krazek · {quest:201} Investigate the Camp
	["The hunters' tents stand just west of the road. {npc:773}'s {quest:201} only asks you to look around it."] = "",
	-- {quest:201} Investigate the Camp
	["{quest:201}: just look around the hunters' camp"] = "{quest:201}: solo echa un vistazo al campamento de los cazadores",
	-- {npc:715} Hemet Nesingwary · {zone:1441} Thousand Needles
	["{npc:715}, from {zone:1441}"] = "{npc:715}, de {zone:1441}",

	-- Step 5: Young tigers and panthers
	["Young tigers and panthers"] = "Tigres jóvenes y panteras",
	["Both roam the grass around the camp and along the road north."] = "Ambos deambulan por la hierba alrededor del campamento y a lo largo del camino al norte.",

	-- Step 6: River crocolisks
	["River crocolisks"] = "Crocoliscos fluviales",
	-- {area:99} Rebel Camp
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["River Crocolisks (30-31) swim the river right beside Nesingwary's camp and up toward the {area:99}."] = "",

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
	["Gluggle (37, rare) on the coast west of camp drops the {item:4614}: four levels over you, leave him unless you are grouped"] = "Gluggle (37, raro), en la costa al oeste del campamento, suelta {item:4614}: está cuatro niveles por encima de ti; déjalo a menos que vayas en grupo",
	-- {object:661516} Thoroughly Scavenged Supplies (no name in this language: may be words)
	-- plural, as words: Stolen Shipments = {item:277953} Stolen Shipment
	["{object:661516}, a looted crate west of Nesingwary's camp: the Stolen Shipments lie in the Bloodscalp ruins on the coast, for the second Stranglethorn loop"] = "{object:661516}, una caja saqueada al oeste del campamento de Nesingwary: los envíos robados están en las ruinas Cabellera Sangrienta de la costa, para el segundo circuito de Tuercespina",

	-- Step 13: Sir S. J. Erlgadin
	-- {area:99} Rebel Camp
	["Back east to Nesingwary's camp on the way north to the {area:99}."] = "De vuelta al este hasta el campamento de Nesingwary, de camino al norte hacia {area:99}.",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["keep it: the Shadowmaw Panthers (37-38) wait for the 40-50 Stranglethorn guide"] = "consérvala: las panteras Faucesombría (37-38) quedan para la guía 40-50 de Tuercespina",

	-- Step 14: Rebel Camp
	-- {npc:738} Private Thorsen · {quest:215} Jungle Secrets · {quest:200} Bookie Herod · {area:99} Rebel Camp
	-- plural, as words: Kurzen's Agents = {npc:775} Kurzen's Agent
	["Take the road north; the camp sits in the hills to the west.\n{npc:738} offers {quest:215} only while he is out of the camp: about every half hour he walks down the path to the road, where two Kurzen's Agents ambush him. Help him kill them and take the quest at once, before he walks back up. He isn't there? Leave it: the guide passes {quest:200}, which follows from it, as well.\n{npc:738} spends most of his time at the top of the {area:99}'s path, by the huts, and now and then walks down it to the road and back (about eight minutes). If he isn't at the arrow, look along that path."] = "",
	-- {npc:738} Private Thorsen
	["{npc:738}, at the foot of the path"] = "{npc:738}, al pie del sendero",
	-- {npc:738} Private Thorsen
	["{npc:738}: at the top of the path by the huts, or on his walk down it"] = "",
	-- {npc:469} Lieutenant Doren
	["{npc:469}, in the hut"] = "{npc:469}, en la cabaña",
	-- {npc:469} Lieutenant Doren · {quest:200} Bookie Herod · {area:101} Kurzen's Compound
	["{npc:469}: {quest:200}'s records lie at the edge of {area:101}, next"] = "{npc:469}: los registros de {quest:200} están en el borde de {area:101}, lo siguiente",
	-- {npc:770} Corporal Kaleb · {npc:773} Krazek · {area:35} Booty Bay
	["{npc:770}: for {npc:773} in {area:35}, later in this guide"] = "{npc:770}: para {npc:773} en {area:35}, más adelante en esta guía",

	-- Step 15: Kurzen's Compound: kill these as you meet them
	-- {area:101} Kurzen's Compound
	["{area:101}: kill these as you meet them"] = "{area:101}: mata a estos según te los encuentres",
	-- {area:99} Rebel Camp · {quest:200} Bookie Herod
	-- plural, as words: Kurzen Elites = {npc:939} Kurzen Elite
	["The Kurzen rebels hold the camp east of the {area:99}; work its outer edge, where Jungle Fighters and Medicine Men stand, and loot the supply crates by the tents. {quest:200}'s records lie in a hut on the compound's west side. Careful: Kurzen Elites and Witch Doctors (36) hold the compound's eastern half, by the cave: stay on its west side."] = "Los rebeldes de Kurzen ocupan el campamento al este de {area:99}; recorre su borde exterior, donde están los combatientes de la jungla y los curanderos, y saquea las cajas de suministros junto a las tiendas. Los registros de {quest:200} están en una choza del lado oeste del complejo. Cuidado: los élites y médicos brujos de Kurzen (36) ocupan la mitad este del complejo, junto a la cueva: quédate en su lado oeste.",
	-- {object:287} Bookie Herod's Records
	["{object:287}, in the hut"] = "{object:287}, en la choza",
	["The strongbox is deeper in, by the cave: on the northern loop (04b)"] = "La caja fuerte está más adentro, junto a la cueva: en el circuito del norte (04b)",
	-- {item:2634} Venom Fern Extract · {object:263} Kurzen Supplies
	["{item:2634}, from a {object:263} crate"] = "{item:2634}, de una caja de {object:263}",

	-- Step 16: Level 33.2
	["Level 33.2"] = "Nivel 33.2",
	-- {area:796} Scarlet Monastery
	-- plural, as words: Kurzen Jungle Fighters = {npc:937} Kurzen Jungle Fighter
	["The elder tigers next are 34-35: short of 33.2? Keep on the Kurzen Jungle Fighters and Medicine Men around the compound's outer edge until level 33.2. Or, with a group, run the {area:796} dungeon (Library) instead."] = "Los tigres mayores que siguen son de nivel 34-35: ¿no llegas a 33.2? Sigue con los jíbaros y curanderos de Kurzen alrededor del borde exterior del complejo hasta el nivel 33.2. O, con un grupo, haz en su lugar el calabozo {area:796} (Biblioteca).",
	-- {npc:937} Kurzen Jungle Fighter
	["grind on {npc:937}"] = "farmea {npc:937}",

	-- Step 18: Stranglethorn Vale: kill these as you meet them
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434}: kill these as you meet them"] = "{zone:1434}: mata a estos según te los encuentres",
	["Careful: Troll camps are close to the tiger area, and trolls can join a fight if you pull carelessly.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "Cuidado: Hay campamentos de trols cerca de la zona de los tigres, y los trols pueden sumarse a la pelea si atraes sin cuidado.\nCuidado: El nido de raptores tiene raptores jóvenes que se suman a la pelea cuando atacas a los adultos.",

	-- Step 19: Nesingwary's Expedition
	-- {npc:716} Barnil Stonepot · {item:2755} Green Hills of Stranglethorn
	["{npc:716} collects the {item:2755}: the pages drop from almost every humanoid in the jungle. Turn the pages into chapters as you go."] = "{npc:716} colecciona {item:2755}: las páginas las sueltan casi todos los humanoides de la jungla. Convierte las páginas en capítulos sobre la marcha.",
	-- {npc:729} Sin'Dall
	["keep it: {npc:729} (37) comes in the 40-50 Stranglethorn guide, at about 41"] = "consérvala: {npc:729} (37) viene en la guía 40-50 de Tuercespina, hacia el nivel 41",
	-- {npc:729} Sin'Dall
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["keep it: the Lashtail Raptors come on the second loop (04b), around {npc:729}'s hill"] = "consérvala: los raptores colazote vienen en el segundo circuito (04b), alrededor de la colina de {npc:729}",

	-- Step 20: The Savage Coast
	-- {area:310} Crystalvein Mine
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk · Lesser Water Elementals = {npc:691} Lesser Water Elemental
	-- was: ["From {area:108} the way leads south out of {zone:1436} into Stranglethorn's north-west, to the {area:310} near the coast; the Crystal Spine Basilisks around it drop the shards.\nThe haunted island lies just off the coast south-west of the mine: just reach its edge. Careful: its Lesser Water Elementals are 36-37: don't stay. The Bloodscalp ruins of Zul'Kunda to the north wait for the second Stranglethorn loop."] = "Desde {area:108} el camino sale al sur de {zone:1436} hasta el noroeste de Tuercespina, hacia {area:310}, cerca de la costa; los basiliscos Espina de Cristal de alrededor sueltan los fragmentos.\nLa isla encantada está justo frente a la costa, al suroeste de la mina: basta con llegar a su orilla. Cuidado: sus elementales de agua inferiores son de nivel 36-37: no te quedes. Las ruinas Cabellera Sangrienta de Zul'Kunda, al norte, quedan para el segundo circuito de Tuercespina."
	["From Nesingwary's camp head west to the {area:310} near the coast; the Crystal Spine Basilisks around it drop the shards.\nThe haunted island lies just off the coast south-west of the mine: just reach its edge. Careful: its Lesser Water Elementals are 36-37: don't stay. The Bloodscalp ruins of Zul'Kunda to the north wait for the second Stranglethorn loop."] = "",
	["The haunted island"] = "La isla embrujada",

	-- Step 21: Booty Bay
	-- {area:35} Booty Bay
	["Hearth back to {area:35}."] = "",
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "{npc:2495}, adentro",
	-- {npc:2495} Drizzlik
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["{npc:2495}: the Snapjaw Crocolisks, on the northern loop"] = "{npc:2495}: los crocoliscos Quijaforte, en el circuito del norte",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "{npc:773}, en el piso de arriba",
	-- {npc:773} Krazek · {npc:770} Corporal Kaleb
	["{npc:773}, from {npc:770}"] = "{npc:773}, de {npc:770}",
	-- {npc:737} Kebok
	["{npc:737}'s Bloodscalp ears wait for the second Stranglethorn loop: keep the quest."] = "Las orejas Cabellera Sangrienta de {npc:737} quedan para el segundo circuito de Tuercespina: conserva la misión.",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}: the water elementals rise around the haunted island, on the northern loop"] = "{npc:2496}: los elementales de agua surgen alrededor de la isla encantada, en el circuito del norte",

	-- Step 22: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Vuela a {zone:1453}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Maestro de vuelo de {area:35}",

	-- Step 24: Collin Mauren
	-- {npc:4078} Collin Mauren · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["{npc:4078} is in the {object:2164}, in the {object:2101}."] = "{npc:4078} está en {object:2164}, en {object:2101}.",

	-- Step 25: Class training
	["Class training"] = "Entrenamiento de clase",
	-- {object:2096} Trade District · {object:2100} Old Town · {object:2101} Mage Quarter · {npc:5504} Sheldras Moontree · {zone:1455} Ironforge
	["Your level 34 ranks: the class trainers stand around the {object:2096}, {object:2100}, the Cathedral and the {object:2101}; {npc:5504}, the druid trainer, stands north-west of the {object:2101}. Shamans train in {zone:1455}, later in 30-40."] = "Tus rangos de nivel 34: los instructores de clase están alrededor de {object:2096}, {object:2100}, la Catedral y {object:2101}; {npc:5504}, el instructor de druidas, está al noroeste de {object:2101}. Los chamanes entrenan en {zone:1455}, más adelante en 30-40.",

	-- Step 27: Fly to Stonetalon Peak
	-- {area:467} Stonetalon Peak
	["Fly to {area:467}"] = "Vuela a {area:467}",
	-- {area:467} Stonetalon Peak · {zone:1443} Desolace · {area:415} Astranaar · {area:465} Charred Vale
	["You know the {area:467} flight: it lands closer to {zone:1443} than {area:415} does. From the peak, follow the road south through the mountains to the {area:465}."] = "Conoces la ruta de vuelo a {area:467}: aterriza más cerca de {zone:1443} que {area:415}. Desde el pico, sigue el camino al sur por las montañas hasta {area:465}.",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "Maestro de vuelo de {area:442}",

	-- Step 28: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "Vuela a {area:415}",

	-- Step 29: Fly to Astranaar
	-- {area:415} Astranaar · {quest:1738} Heartswood
	["Warlocks fly to {area:415} for the {quest:1738}, on the way west."] = "Los brujos vuelan a {area:415} por {quest:1738}, de camino al oeste.",

	-- Step 30: Heartswood
	-- {area:415} Astranaar · {quest:1738} Heartswood · {area:413} Maestra's Post · {quest:65602} What Is Love? · {item:190309} Wooden Figurine
	["From {area:415} head north-west into the hills: the {quest:1738} is a glowing tree north of the road to {area:413}. If you took {quest:65602}, the {item:190309} lies in a house among the trees north of {area:413} (26.6,22.0). Then take the road west to Stonetalon."] = "Desde {area:415} ve al noroeste hacia las colinas: {quest:1738} es un árbol brillante al norte del camino a {area:413}. Si tomaste {quest:65602}, {item:190309} está en una casa entre los árboles al norte de {area:413} (26.6,22.0). Luego toma el camino al oeste hacia Sierra Espolón.",
	-- {item:190309} Wooden Figurine · {area:413} Maestra's Post
	["{item:190309}, north of {area:413}"] = "{item:190309}, al norte de {area:413}",

	-- Step 31: Stonetalon Mountains
	-- {area:608} Nijel's Point
	["The road to {area:608}"] = "El camino a {area:608}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Bloodscalp trolls"] = "Trols Sangrapellejo",
	-- ["Down to {area:35}"] = "Baja a {area:35}",
	-- ["East of Zul'Kunda"] = "Al este de Zul'Kunda",
	-- ["Fly from {area:150} to {area:1537} and train."] = "Vuela de {area:150} a {area:1537} y entrena.",
	-- ["Fly to {area:108}"] = "Vuela a {area:108}",
	-- ["Fly to {area:42}"] = "Vuela a {area:42}",
	-- ["Fly to {area:42}: {npc:1573} in {area:1537}'s {object:32372}, or {npc:352} in {zone:1453}'s {object:2096}."] = "Vuela a {area:42}: {npc:1573} en {object:32372} de {area:1537}, o {npc:352} en {object:2096} de {zone:1453}.",
	-- ["Follow the main road south the length of the jungle, past the {object:3202} turn-off, to {area:35} on the southern cape."] = "Sigue el camino principal al sur a lo largo de toda la jungla, pasando el desvío a {object:3202}, hasta {area:35}, en el cabo sur.",
	-- ["Follow the main road south the length of the jungle, past the {object:3202} turn-off, to {area:35} on the southern cape. Bind your hearthstone at the inn: it is your way back here from Nesingwary's camp at the end of the jungle loop."] = "Sigue el camino principal al sur a lo largo de toda la jungla, pasando el desvío a {object:3202}, hasta {area:35}, en el cabo sur. Vincula tu Piedra de hogar en la posada: es tu forma de volver aquí desde el campamento de Nesingwary al final del circuito de la jungla.",
	-- ["Follow the west coast north; the haunted island lies off the shore west of Nesingwary's camp. Just reach it."] = "Sigue la costa oeste al norte; la isla embrujada está frente a la costa, al oeste del campamento de Nesingwary. Solo llega hasta ella.",
	-- ["For Archmage Ansirem in {zone:1416}"] = "Para el archimago Ansirem en {zone:1416}",
	-- ["From {area:108} the way leads south out of {zone:1436} into Stranglethorn's north-west, to the {area:310} near the coast; the Crystal Spine Basilisks around it drop the shards.\nThe haunted island lies just off the coast south-west of the mine: just reach it. The Bloodscalp trolls hold the ruins on the coast to the north."] = "Desde {area:108} el camino sale al sur de {zone:1436} hasta el noroeste de Tuercespina, hacia {area:310}, cerca de la costa; los basiliscos Espina de Cristal de alrededor sueltan los fragmentos.\nLa isla encantada está justo frente a la costa, al suroeste de la mina: basta con llegar a ella. Los trols Cabellera Sangrienta ocupan las ruinas de la costa, al norte.",
	-- ["From {area:108} the way leads south out of {zone:1436} into Stranglethorn's north-west, to the {area:310} near the coast; the Crystal Spine Basilisks around it drop the shards.\nThe haunted island lies just off the coast south-west of the mine: just reach its edge. Careful: its Lesser Water Elementals are 36-37: don't stay. The Bloodscalp ruins of Zul'Kunda to the north wait for the second Stranglethorn loop."] = "Desde {area:108} el camino sale al sur de {zone:1436} hasta el noroeste de Tuercespina, hacia {area:310}, cerca de la costa; los basiliscos Espina de Cristal de alrededor sueltan los fragmentos.\nLa isla encantada está justo frente a la costa, al suroeste de la mina: basta con llegar a su orilla. Cuidado: sus elementales de agua inferiores son de nivel 36-37: no te quedes. Las ruinas Cabellera Sangrienta de Zul'Kunda, al norte, quedan para el segundo circuito de Tuercespina.",
	-- ["From {zone:1431} take the road south into Stranglethorn; the hunters' tents stand just west of the road past the {area:99} turn-off."] = "Desde {zone:1431} toma el camino al sur hacia Tuercespina; las tiendas de los cazadores están justo al oeste del camino, pasado el desvío a {area:99}.",
	-- ["Gluggle, a rare murloc on the coast west of camp, drops the {item:4614}: take it if you meet him"] = "Gluggle, un múrloc raro en la costa al oeste del campamento, suelta {item:4614}: tómalo si te lo encuentras",
	-- ["Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave. Pick up Green Hills pages as they drop."] = "Los reductores de cabezas están más adentro de la base; los comandos acechan en sigilo a su alrededor y en la cueva. Recoge las páginas de Las verdes colinas cuando caigan.",
	-- ["Herod's records lie in a hut on the compound's west side; his strongbox sits farther east, by the cave mouth."] = "Los documentos de Herod están en una cabaña en el lado oeste de la base; su caja fuerte está más al este, junto a la boca de la cueva.",
	-- ["Level 33.6"] = "Nivel 33.6",
	-- ["Level 34"] = "Nivel 34",
	-- ["Loop through the troll ruins of the north and centre: each holds one stone tablet of the troll legends. Shadowmaw Panthers prowl stealthed in the jungle around them; the Venture Co. camp on {area:37} carries the Tumbled Crystals."] = "Recorre las ruinas trol del norte y del centro: cada una guarda una tablilla de piedra de las leyendas trol. Las panteras Faucesombría merodean en sigilo por la jungla a su alrededor; el campamento de Ventura y Cía. en {area:37} lleva los cristales caídos.",
	-- ["River Crocolisks swim the river by the {area:99}."] = "Los crocoliscos fluviales nadan en el río junto a {area:99}.",
	-- ["Short of 33.6? Keep on the Kurzen Jungle Fighters and Medicine Men around the compound's outer edge until level 33.6. Or, with a group, run the {area:796} dungeon (Library) instead."] = "¿No llegas a 33.6? Sigue con los combatientes de la jungla y curanderos de Kurzen alrededor del borde exterior del complejo hasta el nivel 33.6. O, con un grupo, haz en su lugar la mazmorra {area:796} (Biblioteca).",
	-- ["Skullsplitter trolls"] = "Trols Machacacráneos",
	-- ["Snapjaw Crocolisks"] = "Crocoliscos Quijaforte",
	-- ["Snapjaw Crocolisks bask on the shore and islands along the coast north of {area:35}."] = "Los crocoliscos Quijaforte toman el sol en la orilla y las islas de la costa al norte de {area:35}.",
	-- ["Take the road north; the camp sits in the hills to the west.\n{npc:738} offers {quest:215} only while he is out of the camp: about every half hour he walks down the path to the road, where two Kurzen's Agents ambush him. Help him kill them and take the quest at once, before he walks back up. He isn't there? Leave it: the guide passes {quest:200}, which follows from it, as well."] = "Toma el camino al norte; el campamento está en las colinas al oeste.\n{npc:738} solo ofrece {quest:215} mientras está fuera del campamento: más o menos cada media hora baja por el sendero hasta el camino, donde dos Agentes de Kurzen le tienden una emboscada. Ayúdalo a matarlos y toma la misión de inmediato, antes de que vuelva a subir. ¿No está? Déjala: la guía también omite {quest:200}, que viene de ella.",
	-- ["Take the road north; {npc:738} patrols it, the camp sits in the hills to the west."] = "Toma el camino al norte; {npc:738} lo patrulla, y el campamento está en las colinas al oeste.",
	-- ["Take the road north; {npc:738} stands on it, the camp sits in the hills to the west."] = "Toma el camino al norte; {npc:738} está en él, y el campamento está en las colinas al oeste.",
	-- ["The Bloodscalp trolls hold the ruins on the coast west of Nesingwary's camp."] = "Los trols Sangrapellejo ocupan las ruinas de la costa al oeste del campamento de Nesingwary.",
	-- ["The Kurzen rebels hold the camp east of the {area:99}; work its outer edge, where Jungle Fighters and Medicine Men stand, and loot the supply crates by the tents."] = "Los rebeldes de Kurzen ocupan el campamento al este de {area:99}; recorre su borde exterior, donde están los jíbaros y auxiliadores, y saquea las cajas de suministros junto a las tiendas.",
	-- ["The Skullsplitter trolls hold the ruins east of the road between Nesingwary and {object:3202}."] = "Los trols Machacacráneos ocupan las ruinas al este del camino entre Nesingwary y {object:3202}.",
	-- ["The jungle ruins"] = "Las ruinas de la jungla",
	-- ["The jungle's quests climb to 37 from here: short of 33.2? Keep on the Stranglethorn Tigers in the hills just south and west of the camp until level 33.2. Or, with a group, run the {area:796} dungeon (Library) instead."] = "Las misiones de la jungla suben a 37 desde aquí: ¿no llegas a 33.2? Sigue con los tigres de Tuercespina en las colinas justo al sur y al oeste del campamento hasta el nivel 33.2. O, con un grupo, haz en su lugar la mazmorra {area:796} (Biblioteca).",
	-- ["The ore drops from Drywhisker kobolds in {zone:1417}"] = "El mineral lo sueltan los kóbolds Mostacho Seco en {zone:1417}",
	-- ["The quests from here on are 37: if you are short of 34, keep on the elder tigers in the hills south-west of Nesingwary's camp until level 34. Or, with a group, run the {area:796} dungeon (Library or Armory) instead."] = "Las misiones de aquí en adelante son de nivel 37: si no llegas a 34, sigue con los tigres ancianos en las colinas al suroeste del campamento de Nesingwary hasta el nivel 34. O, con un grupo, haz en su lugar la mazmorra {area:796} (Biblioteca o Armería).",
	-- ["Thorsen patrols the road north of camp, toward the {area:99}."] = "Thorsen patrulla el camino al norte del campamento, hacia {area:99}.",
	-- ["Walk back north; the {area:310} lies west of the road in the middle of the jungle. The Crystal Spine Basilisks there drop the shards."] = "Regresa al norte; {area:310} está al oeste del camino, en medio de la jungla. Los basiliscos Espina de Cristal de allí sueltan los fragmentos.",
	-- ["grind on {npc:1085}"] = "farmea {npc:1085}",
	-- ["grind on {npc:682}"] = "farmea {npc:682}",
	-- ["{area:150} flight master"] = "Maestro de vuelo de {area:150}",
	-- ["{area:1537} has no druid trainer: take the {area:2257} from {object:171524} to {zone:1453} and train with {npc:5504}."] = "{area:1537} no tiene instructor de druidas: toma el {area:2257} desde {object:171524} hasta {zone:1453} y entrena con {npc:5504}.",
	-- ["{area:301}: kill these as you meet them"] = "{area:301}: mata a estos según te los encuentres",
	-- ["{npc:2495}, by the bank"] = "{npc:2495}, junto al banco",
	-- ["{npc:2832}, in the {object:56910}"] = "{npc:2832}, en la {object:56910}",
	-- ["{npc:2859}, on the top floor by the docks"] = "{npc:2859}, en el piso superior junto a los muelles",
	-- ["{npc:729} and the Lashtail raptors"] = "{npc:729} y los raptores colazote",
	-- ["{npc:729}, the great tiger, lairs on the hilltop south-west of the camp; Lashtail Raptors run south of it, along the way to {area:35}."] = "{npc:729}, el gran tigre, tiene su guarida en la cima de la colina al suroeste del campamento; los raptores colazote corren al sur de ella, por el camino a {area:35}.",
	-- ["{npc:737}, upstairs"] = "{npc:737}, en el piso de arriba",
	-- ["{npc:737}: the Tumbled Crystals, on the northern loop"] = "{npc:737}: los cristales pulidos, en el circuito del norte",
	-- ["{npc:738} spends most of his time at the top of the {area:99}'s path, by the huts, and now and then walks down it to the road and back (about eight minutes). If he isn't at the arrow, look along that path."] = "{npc:738} pasa la mayor parte del tiempo arriba del sendero de {area:99}, junto a las chozas, y de vez en cuando baja por él hasta el camino y vuelve (unos ocho minutos). Si no está en la flecha, búscalo a lo largo de ese sendero.",
	-- ["{npc:770}: for {npc:773} in {area:35}"] = "{npc:770}: para {npc:773} en {area:35}",
	-- ["{npc:773}, in the tavern"] = "{npc:773}, en la taberna",
	-- ["{npc:773}, in the tavern; upstairs"] = "{npc:773}, en la taberna; arriba",
	-- ["{quest:207}: four troll legends"] = "{quest:207}: cuatro leyendas trol",
}
