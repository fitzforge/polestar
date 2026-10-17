-- French (frFR): the guide forever/alliance/05-duskwood (forever/alliance/05-duskwood.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Darkshire
	-- {area:1002} Three Corners · {zone:1431} Duskwood · {area:42} Darkshire
	["Follow the road south from {area:1002} into {zone:1431}; {area:42} lies on the east side of the forest."] = "Suivez la route vers le sud depuis {area:1002} jusqu'à {zone:1431} ; {area:42} se trouve du côté est de la forêt.",
	-- {npc:2409} Felicia Maline
	["{npc:2409}, at the north end of town"] = "{npc:2409}, à l'extrémité nord de la ville",
	-- {npc:6790} Innkeeper Trelayne
	["{npc:6790}, Scarlet Raven Tavern"] = "{npc:6790}, taverne du Corbeau écarlate",
	-- {npc:265} Madame Eva
	["{npc:265}, in her house by the tavern"] = "{npc:265}, dans sa maison près de la taverne",
	-- {npc:264} Commander Althea Ebonlocke
	["{npc:264}, in the town hall"] = "{npc:264}, à l'hôtel de ville",
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, in the house behind the town hall"] = "{npc:268}, dans la maison derrière l'hôtel de ville",
	-- {npc:633} Elaine Carevin
	["{npc:633}, at the south end of town"] = "{npc:633}, à l'extrémité sud de la ville",

	-- Step 2: Viktori Prism'Antras
	-- {npc:276} Viktori Prism'Antras · {npc:3133} Herble Baubbletump
	["{npc:276}'s house stands at the east end of town. {npc:3133} sells engineering goods in the house beside it."] = "La maison de {npc:276} se trouve à l'extrémité est de la ville. {npc:3133} vend des fournitures d'ingénierie dans la maison voisine.",
	-- {item:4371} Bronze Tube · {npc:3133} Herble Baubbletump · {npc:1448} Neal Allen · {area:150} Menethil Harbor
	["{item:4371}, from {npc:3133}: limited stock. Sold out? {npc:1448} in {area:150} sells it too."] = "{item:4371}, chez {npc:3133} : stock limité. Épuisé ? {npc:1448} à {area:150} en vend aussi.",

	-- Step 3: Tranquil Gardens Cemetery
	-- {area:42} Darkshire · {npc:302} Blind Mary · {zone:1431} Duskwood · {item:2378} Skeleton Finger
	-- plural, as words: Skeletal Warriors = {npc:48} Skeletal Warrior · Skeletal Mages = {npc:203} Skeletal Mage
	["Skeletal Warriors and Skeletal Mages walk among the graves south-east of {area:42}, below {npc:302}'s house on the hill. Every skeleton in {zone:1431} can drop a {item:2378}."] = "Les Guerriers squelettes et les Mages squelettes errent parmi les tombes au sud-est de {area:42}, sous la maison de {npc:302} sur la colline. Tout squelette de {zone:1431} peut laisser tomber un {item:2378}.",
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["{quest:337}: a rare drop from {zone:1431}'s mobs"] = "{quest:337} : butin rare des monstres de {zone:1431}",

	-- Step 5: Watcher Dodds
	-- {npc:888} Watcher Dodds · {area:245} Yorgen Farmstead
	["{npc:888} stands south of the road, at the {area:245}."] = "{npc:888} se tient au sud de la route, à {area:245}.",

	-- Step 6: Raven Hill
	-- {area:94} Raven Hill · {object:673515} Memory of Valor
	["Continue west to {area:94}. The {object:673515} glows by the ruined house south of the road."] = "Continuez vers l'ouest jusqu'à {area:94}. Le {object:673515} brille près de la maison en ruine au sud de la route.",
	-- {item:281046} Raven Hill Tome · {object:673515} Memory of Valor
	["{item:281046}, from the {object:673515}"] = "{item:281046}, sur le {object:673515}",

	-- Step 7: Raven Hill Cemetery, south
	-- {area:492} Raven Hill Cemetery
	["{area:492}, south"] = "{area:492}, sud",
	-- {npc:522} Mor'Ladim
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Skeletal Fiends = {npc:531} Skeletal Fiend
	["The cemetery lies north of the village. Skeletal Horrors and Skeletal Fiends walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "Le cimetière se trouve au nord du village. Les Squelettes infernaux et les Démons squelettes errent dans sa moitié sud. {npc:522}, un élite, rôde parmi les tombes : tenez-vous à l'écart.",

	-- Step 8: Sven's Camp
	-- {npc:311} Sven Yorgen · {npc:893} Lars
	["Follow the road north-west past the cemetery to {npc:311}'s camp on the far west edge of the forest. {npc:893} stands beside {npc:311}."] = "Suivez la route vers le nord-ouest après le cimetière jusqu'au camp de {npc:311}, à l'extrême ouest de la forêt. {npc:893} se tient à côté de {npc:311}.",

	-- Step 9: Abercrombie
	-- {area:492} Raven Hill Cemetery
	["The hermit's shack stands in the woods north-east of the {area:492}."] = "La cabane de l'ermite se trouve dans les bois au nord-est de {area:492}.",

	-- Step 10: Wolves, spiders and ghouls
	["Wolves, spiders and ghouls"] = "Loups, araignées et goules",
	-- {npc:289} Abercrombie
	-- plural, as words: Pygmy Venom Web Spiders = {npc:539} Pygmy Venom Web Spider
	["Rabid Dire Wolves roam the woods around the cemetery and {npc:289}, Starving Dire Wolves the hills north-east of him. Pygmy Venom Web Spiders crawl east of the cemetery and drop the venom. Every ghoul of the cemetery's northern half can drop a fang."] = "Les Loups redoutables enragés rôdent dans les bois autour du cimetière et de {npc:289}, les Loups redoutables affamés dans les collines au nord-est de lui. Les Araignées Tisse-venin pygmées rampent à l'est du cimetière et laissent tomber le venin. Toute goule de la moitié nord du cimetière peut laisser tomber un croc.",

	-- Step 11: Watcher Dodds
	-- {area:245} Yorgen Farmstead
	["Ride back east along the road to the {area:245}."] = "Revenez vers l'est le long de la route jusqu'à {area:245}.",

	-- Step 12: Yorgen Farmstead
	["The mound of loose dirt lies south of the farmhouse, by the old stump."] = "Le monticule de poussière se trouve au sud de la ferme, près de la vieille souche.",

	-- Step 14: Blind Mary
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	["Her house stands on the hill south-east of {area:42}, above the {area:121}."] = "Sa maison se trouve sur la colline au sud-est de {area:42}, au-dessus de {area:121}.",

	-- Step 16: Abercrombie
	["Ride west along the road once more."] = "Chevauchez encore vers l'ouest le long de la route.",

	-- Step 18: Back to Darkshire
	-- {area:42} Darkshire
	["Back to {area:42}"] = "Retour à {area:42}",
	-- {area:42} Darkshire
	["Ride back east to {area:42}."] = "Revenez vers l'est jusqu'à {area:42}.",
	-- {npc:267} Clerk Daltry
	["{npc:267}, in the town hall"] = "{npc:267}, à l'hôtel de ville",
	-- {npc:273} Tavernkeep Smitts
	["{npc:273}, in the tavern"] = "{npc:273}, dans la taverne",

	-- Step 19: Rot Blossoms
	-- plural, as words: Rot Blossoms = {item:1598} Rot Blossom
	["Rot Blossoms"] = "Racines pourries ({item:1598})",
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Rot Blossoms = {item:1598} Rot Blossom
	["Skeletal Horrors walk the hillside between {area:42} and the {area:121}, south-east of town; they drop the Rot Blossoms."] = "Des Squelettes infernaux ({npc:202}) arpentent le flanc de colline entre {area:42} et {area:121}, au sud-est de la ville ; ils lâchent les Racines pourries ({item:1598}).",

	-- Step 21: Abercrombie
	["Ride west to the hermit once more."] = "Chevauchez encore vers l'ouest jusqu'à l'ermite.",

	-- Step 22: Ghoul Ribs
	-- plural, as words: Ghoul Ribs = {item:884} Ghoul Rib
	["Ghoul Ribs"] = "Côtes de goule",
	-- {area:492} Raven Hill Cemetery
	-- plural, as words: Flesh Eaters = {npc:3} Flesh Eater · Bone Chewers = {npc:210} Bone Chewer · Plague Spreaders = {npc:604} Plague Spreader · Brain Eaters = {npc:570} Brain Eater
	["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters, Bone Chewers, Plague Spreaders and Brain Eaters."] = "Toute goule de la moitié nord de {area:492} peut laisser tomber une côte : Dévoreurs, Mâcheurs d'os, Répandeurs de peste et Mangeurs de cervelle.",

	-- Step 24: Jitters
	-- {npc:288} Jitters · {area:94} Raven Hill
	["{npc:288} hides in the house at the west end of {area:94}."] = "{npc:288} se cache dans la maison à l'extrémité ouest de {area:94}.",

	-- Step 25: Sven's Camp
	-- {zone:1453} Stormwind · {area:17203} Stormwind Harbor · {area:442} Auberdine · {zone:1440} Ashenvale
	["Next: {zone:1453} for training, then the boat from {area:17203} to {area:442} for {zone:1440}."] = "Ensuite : {zone:1453} pour l'entraînement, puis le bateau de {area:17203} pour {area:442}, vers {zone:1440}.",

	-- Step 26: Agent Kearnen
	-- {area:94} Raven Hill · {zone:1436} Westfall · {npc:7024} Agent Kearnen · {npc:7053} Klaven Mortwake · {npc:7051} Malformed Defias Drone
	["Ride west along the road out of {area:94} into {zone:1436}. {npc:7024} watches {npc:7053}'s tower from the hills just inside the border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "Suivez la route vers l'ouest pour quitter {area:94} et entrer en {zone:1436}. {npc:7024} surveille la tour de {npc:7053} depuis les collines juste après la frontière. Le {npc:7051} (niveau 23) qui garde la tour porte sa clé ; le journal de Klaven est dans le coffre au sommet.",
	-- {item:7908} Klaven Mortwake's Journal
	["{item:7908}, in the chest"] = "{item:7908}, dans le coffre",

	-- Step 27: Master Mathias Shaw
	-- {zone:1453} Stormwind · {object:2100} Old Town
	["Ride north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "Chevauchez vers le nord à travers Elwynn jusqu'à {zone:1453} ; Mathias Shaw se trouve au SI:7, dans {object:2100}.",
	-- {npc:332} Master Mathias Shaw · {item:18160} Recipe: Thistle Tea
	["{npc:332}: Poisons, and {item:18160}"] = "{npc:332} : Poisons, et {item:18160}",
	-- {quest:2607} The Touch of Zanzil · {npc:7207} Doc Mixilpixil
	["{quest:2607}: {npc:7207}, in the cellar of the Barracks"] = "{quest:2607} : {npc:7207}, dans la cave de la caserne",
	-- {npc:7207} Doc Mixilpixil
	["/lay down beside {npc:7207}"] = "/lay down à côté de {npc:7207}",
	-- {item:3372} Leaded Vial · {npc:1313} Maria Lumere
	["{item:3372}: {npc:1313}, Alchemy Supplies"] = "{item:3372} : {npc:1313}, Fournitures d'alchimie",

	-- Step 28: Stormwind
	-- {zone:1453} Stormwind · {zone:1429} Elwynn Forest · {area:17203} Stormwind Harbor · {area:442} Auberdine
	["Train in {zone:1453}, north through {zone:1429}. Then take the boat from {area:17203} to {area:442}."] = "Entraînez-vous à {zone:1453}, au nord à travers {zone:1429}. Prenez ensuite le bateau de {area:17203} pour {area:442}.",
	["Level 22 and 24 spells"] = "Sorts des niveaux 22 et 24",

	-- Step 29: Shaman training
	["Shaman training"] = "Entraînement de chaman",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker · {area:442} Auberdine
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the {area:442} boat."] = "{zone:1453} n'a pas de maître des chamans : prenez le {area:2257} depuis {object:28027} jusqu'à {zone:1455}, entraînez-vous auprès de {npc:258098}, puis reprenez le tram pour le bateau d'{area:442}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Skeletal Horrors walk the hillside between {area:42} and the {area:121}, south-east of town; they drop the {npc:14235} Blossoms."] = "Les Squelettes infernaux errent sur la colline entre {area:42} et {area:121}, au sud-est de la ville ; ils laissent tomber les fleurs de {npc:14235}.",
	-- ["{item:3372}: {npc:1313}, {skill:171} Supplies"] = "{item:3372} : {npc:1313}, fournitures d'{skill:171}",
	-- ["{npc:14235} Blossoms"] = "Fleurs de {npc:14235}",
	-- ["{npc:332}: {spell:2842}, and {item:18160}"] = "{npc:332} : {spell:2842} et {item:18160}",
}
