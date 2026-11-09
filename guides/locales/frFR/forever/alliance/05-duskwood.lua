-- French (frFR): the guide forever/alliance/05-duskwood (forever/alliance/05-duskwood.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "",
	-- {area:69} Lakeshire · {area:42} Darkshire · {zone:1431} Duskwood
	["Back to the {area:69} gryphon master: fly to {area:42} for {zone:1431}'s second loop."] = "",
	-- {area:69} Lakeshire
	["{area:69} flight master"] = "",

	-- Step 2: Blind Mary
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	["Her house stands on the hill south-east of {area:42}, above the {area:121}."] = "Sa maison se trouve sur la colline au sud-est de {area:42}, au-dessus de {area:121}.",
	["Inside"] = "À l'intérieur",
	-- {item:1946} Mary's Looking Glass · {npc:511} Insane Ghoul · {zone:1431} Duskwood
	["{item:1946}: the {npc:511} in the cemetery's crypt is level 26; it waits for the {zone:1431} return"] = "",

	-- Step 3: Tranquil Gardens Cemetery
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["{quest:337}: a rare drop from {zone:1431}'s mobs"] = "{quest:337} : butin rare des monstres de {zone:1431}",

	-- Step 5: Abercrombie
	["Head west along the road once more."] = "Repartez une fois de plus vers l'ouest par la route.",

	-- Step 7: Back to Darkshire
	-- {area:42} Darkshire
	["Back to {area:42}"] = "Retour à {area:42}",
	-- {area:42} Darkshire
	["Head back east to {area:42}."] = "Retournez vers l'est jusqu'à {area:42}.",
	-- {npc:265} Madame Eva
	["{npc:265}, inside"] = "{npc:265}, à l'intérieur",
	-- {npc:267} Clerk Daltry
	["{npc:267}, in the town hall"] = "{npc:267}, à l'hôtel de ville",
	-- {npc:273} Tavernkeep Smitts
	["{npc:273}, in the tavern"] = "{npc:273}, dans la taverne",

	-- Step 8: Rot Blossoms
	-- plural, as words: Rot Blossoms = {item:1598} Rot Blossom
	["Rot Blossoms"] = "Racines pourries ({item:1598})",
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Rot Blossoms = {item:1598} Rot Blossom
	["Skeletal Horrors walk the hillside between {area:42} and the {area:121}, south-east of town; they drop the Rot Blossoms."] = "Des Squelettes infernaux ({npc:202}) arpentent le flanc de colline entre {area:42} et {area:121}, au sud-est de la ville ; ils lâchent les Racines pourries ({item:1598}).",

	-- Step 10: Abercrombie
	["Head west to the hermit once more."] = "Retournez une fois de plus vers l'ouest jusqu'à l'ermite.",

	-- Step 11: Ghoul Ribs
	-- plural, as words: Ghoul Ribs = {item:884} Ghoul Rib
	["Ghoul Ribs"] = "Côtes de goule",
	-- {area:492} Raven Hill Cemetery · {npc:948} Rotted One · {spell:3428} Summon Flesh Eating Worms
	-- plural, as words: Flesh Eaters = {npc:3} Flesh Eater · Bone Chewers = {npc:210} Bone Chewer · Plague Spreaders = {npc:604} Plague Spreader · Brain Eaters = {npc:570} Brain Eater
	["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters, Bone Chewers, Plague Spreaders and Brain Eaters.\nCareful: A {npc:948} casts {spell:3428} as it dies, which brings extra adds."] = "Toutes les goules de la moitié nord du {area:492} peuvent lâcher une côte : Dévoreurs, Mâcheurs d'os, Répandeurs de peste et Mangeurs de cervelle.\nAttention : un {npc:948} lance {spell:3428} en mourant, ce qui fait apparaître des renforts.",

	-- Step 13: Raven Hill Cemetery: kill these as you meet them
	-- {area:492} Raven Hill Cemetery
	["{area:492}: kill these as you meet them"] = "{area:492} : tuez-les au passage",
	-- {area:94} Raven Hill · {npc:522} Mor'Ladim
	-- plural, as words: Skeletal Fiends = {npc:531} Skeletal Fiend · Skeletal Horrors = {npc:202} Skeletal Horror
	["Head south through the cemetery towards {area:94}. Skeletal Fiends and Skeletal Horrors walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "",

	-- Step 14: Jitters
	-- {npc:288} Jitters · {area:94} Raven Hill
	["{npc:288} hides in the house at the west end of {area:94}."] = "{npc:288} se cache dans la maison à l'extrémité ouest de {area:94}.",

	-- Step 15: Sven's Camp
	-- {zone:1453} Stormwind · {area:150} Menethil Harbor · {zone:1437} Wetlands
	["Next: training, then the flight from {zone:1453} to {area:150} for the {zone:1437}."] = "",

	-- Step 17: Agent Kearnen
	-- {area:94} Raven Hill · {zone:1436} Westfall · {npc:7024} Agent Kearnen · {npc:7053} Klaven Mortwake · {npc:7051} Malformed Defias Drone
	["Head west along the road out of {area:94} into {zone:1436}. {npc:7024} watches {npc:7053}'s tower from the hills just inside the border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "Suivez la route vers l'ouest pour quitter {area:94} et entrer en {zone:1436}. {npc:7024} surveille la tour de {npc:7053} depuis les collines juste après la frontière. Le {npc:7051} (niveau 23) qui garde la tour porte sa clé ; le journal de Klaven se trouve dans le coffre au sommet.",
	-- {item:7908} Klaven Mortwake's Journal
	["{item:7908}, in the chest"] = "{item:7908}, dans le coffre",

	-- Step 18: Master Mathias Shaw
	-- {zone:1453} Stormwind · {object:2100} Old Town
	["Head north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "Remontez vers le nord à travers la forêt d'Elwynn jusqu'à {zone:1453} ; Mathias Shaw se trouve au SI:7, dans {object:2100}.",
	-- {npc:332} Master Mathias Shaw · {item:18160} Recipe: Thistle Tea
	["{npc:332}: Poisons, and {item:18160}"] = "{npc:332} : Poisons, et {item:18160}",
	-- {quest:2607} The Touch of Zanzil · {npc:7207} Doc Mixilpixil
	["{quest:2607}: {npc:7207}, in the cellar of the Barracks"] = "{quest:2607} : {npc:7207}, dans la cave de la caserne",
	-- {npc:7207} Doc Mixilpixil
	["/lay down beside {npc:7207}"] = "/lay down à côté de {npc:7207}",
	-- {item:3372} Leaded Vial · {npc:1313} Maria Lumere
	["{item:3372}: {npc:1313}, Alchemy Supplies"] = "{item:3372} : {npc:1313}, Fournitures d'alchimie",
	-- {item:4371} Bronze Tube · {object:2096} Trade District · {npc:5519} Billibub Cogspinner
	["{item:4371}: the Auction House, {object:2096}; {npc:5519} keeps one and is nearly always sold out"] = "",

	-- Step 19: Elwynn Forest
	-- {area:94} Raven Hill · {area:87} Goldshire · {zone:1453} Stormwind
	["North from {area:94} through Elwynn: {area:87} is on the road to {zone:1453}."] = "",

	-- Step 20: Class trainer
	["Class trainer"] = "Maître de classe",
	["Level 22 and 24 spells"] = "Sorts des niveaux 22 et 24",

	-- Step 21: Gazin Tenorm
	-- {zone:1453} Stormwind · {npc:6173} Gazin Tenorm · {npc:6171} Duthorian Rall
	["On into {zone:1453}: {npc:6173} and {npc:6171} are in the Cathedral of Light, on the way to the gryphon master."] = "",
	["Cathedral of Light"] = "Cathédrale de la Lumière",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}: Redemption"] = "{npc:6171} : Rédemption",

	-- Step 22: Stormwind
	-- {zone:1453} Stormwind · {object:28027} Dwarven District
	["{zone:1453}'s {object:28027}"] = "",

	-- Step 23: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "Tram pour {zone:1455}",

	-- Step 24: Shaman training
	["Shaman training"] = "Entraînement de chaman",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back."] = "{zone:1453} n'a pas de maître chaman : prenez {area:2257} depuis {object:28027} jusqu'à {zone:1455}, entraînez-vous auprès de {npc:258098}, puis reprenez le tram pour revenir.",

	-- Step 25: Rogue training
	["Rogue training"] = "Entraînement de voleur",
	-- {zone:1453} Stormwind
	["Train here, in {zone:1453}, before you go on."] = "Entraînez-vous ici, à {zone:1453}, avant de continuer.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Continue west to {area:94}. The {object:673515} glows by the ruined house south of the road."] = "Continuez vers l'ouest jusqu'à {area:94}. Le {object:673515} brille près de la maison en ruine au sud de la route.",
	-- ["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters, Bone Chewers, Plague Spreaders and Brain Eaters."] = "Toute goule de la moitié nord de {area:492} peut laisser tomber une côte : Dévoreurs, Mâcheurs d'os, Répandeurs de peste et Mangeurs de cervelle.",
	-- ["Fly to {zone:1453}"] = "Prendre un vol pour {zone:1453}",
	-- ["Follow the road north-west past the cemetery to {npc:311}'s camp on the far west edge of the forest. {npc:893} stands beside {npc:311}."] = "Suivez la route vers le nord-ouest après le cimetière jusqu'au camp de {npc:311}, à l'extrême ouest de la forêt. {npc:893} se tient à côté de {npc:311}.",
	-- ["Follow the road south from {area:1002} into {area:10}; {area:42} lies on the east side of the forest."] = "Suivez la route vers le sud depuis {area:1002} jusqu'au {area:10} ; {area:42} se trouve à l'est de la forêt.",
	-- ["Follow the road south from {area:1002} into {zone:1431}; {area:42} lies on the east side of the forest."] = "Suivez la route vers le sud depuis {area:1002} jusqu'à {zone:1431} ; {area:42} se trouve du côté est de la forêt.",
	-- ["Head back east along the road to the {area:245}."] = "Retournez vers l'est par la route jusqu'à {area:245}.",
	-- ["Hearth to {area:42}"] = "Pierre de foyer vers {area:42}",
	-- ["Next: {zone:1453} for training, then the boat from {area:17203} to {area:442} for {zone:1440}."] = "Ensuite : {zone:1453} pour l'entraînement, puis le bateau de {area:17203} pour {area:442}, vers {zone:1440}.",
	-- ["No {item:4371} for {quest:174}? {npc:3133} sells it in the house beside {npc:276}, in limited stock; {npc:1448} in {area:150} sells it too.\n{npc:276}'s house stands at the east end of town. {npc:3133} sells engineering goods in the house beside it."] = "Pas de {item:4371} pour {quest:174} ? {npc:3133} en vend dans la maison voisine de celle de {npc:276}, en quantité limitée ; {npc:1448}, à {area:150}, en vend aussi.\nLa maison de {npc:276} se trouve à l'extrémité est de la ville. {npc:3133} vend des articles d'ingénierie dans la maison voisine.",
	-- ["Rabid Dire Wolves roam the woods around the cemetery and {npc:289}, Starving Dire Wolves the hills north-east of him. Pygmy Venom Web Spiders crawl east of the cemetery and drop the venom. Every ghoul of the cemetery's northern half can drop a fang."] = "Les Loups redoutables enragés rôdent dans les bois autour du cimetière et de {npc:289}, les Loups redoutables affamés dans les collines au nord-est de lui. Les Araignées Tisse-venin pygmées rampent à l'est du cimetière et laissent tomber le venin. Toute goule de la moitié nord du cimetière peut laisser tomber un croc.",
	-- ["Rabid Dire Wolves roam the woods around the cemetery and {npc:289}, Starving Dire Wolves the hills north-east of him. Pygmy Venom Web Spiders crawl east of the cemetery and drop the venom. Every ghoul of the cemetery's northern half can drop a fang.\nCareful: Wolves and other spider types share the area along the {area:40} border, so you can easily pull several mobs at once."] = "Des Loups redoutables enragés parcourent les bois autour du cimetière et de {npc:289}, des Loups redoutables affamés les collines au nord-est de chez lui. Des Araignées Tisse-venin pygmées rampent à l'est du cimetière et lâchent le venin. Toutes les goules de la moitié nord du cimetière peuvent lâcher un croc.\nAttention : des loups et d'autres types d'araignées partagent la zone le long de la frontière avec {area:40} : vous pouvez facilement attirer plusieurs monstres à la fois.",
	-- ["Ride back east along the road to the {area:245}."] = "Revenez vers l'est le long de la route jusqu'à {area:245}.",
	-- ["Ride back east to {area:42}."] = "Revenez vers l'est jusqu'à {area:42}.",
	-- ["Ride north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "Chevauchez vers le nord à travers Elwynn jusqu'à {zone:1453} ; Mathias Shaw se trouve au SI:7, dans {object:2100}.",
	-- ["Ride west along the road once more."] = "Chevauchez encore vers l'ouest le long de la route.",
	-- ["Ride west along the road out of {area:94} into {zone:1436}. {npc:7024} watches {npc:7053}'s tower from the hills just inside the border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "Suivez la route vers l'ouest pour quitter {area:94} et entrer en {zone:1436}. {npc:7024} surveille la tour de {npc:7053} depuis les collines juste après la frontière. Le {npc:7051} (niveau 23) qui garde la tour porte sa clé ; le journal de Klaven est dans le coffre au sommet.",
	-- ["Ride west to the hermit once more."] = "Chevauchez encore vers l'ouest jusqu'à l'ermite.",
	-- ["Skeletal Horrors walk the hillside between {area:42} and the {area:121}, south-east of town; they drop the {npc:14235} Blossoms."] = "Les Squelettes infernaux errent sur la colline entre {area:42} et {area:121}, au sud-est de la ville ; ils laissent tomber les fleurs de {npc:14235}.",
	-- ["Skeletal Warriors and Skeletal Mages walk among the graves south-east of {area:42}, below {npc:302}'s house on the hill. Every skeleton in {area:10} can drop a {item:2378}.\nCareful: Because the skeletons stand near each other, running straight in tends to pull several at once."] = "Des Guerriers squelettes et des Mages squelettes errent parmi les tombes au sud-est de {area:42}, en contrebas de la maison de {npc:302} sur la colline. Tous les squelettes du {area:10} peuvent lâcher un {item:2378}.\nAttention : les squelettes se tiennent près les uns des autres : foncer dans le tas en attire souvent plusieurs à la fois.",
	-- ["Skeletal Warriors and Skeletal Mages walk among the graves south-east of {area:42}, below {npc:302}'s house on the hill. Every skeleton in {zone:1431} can drop a {item:2378}."] = "Les Guerriers squelettes et les Mages squelettes errent parmi les tombes au sud-est de {area:42}, sous la maison de {npc:302} sur la colline. Tout squelette de {zone:1431} peut laisser tomber un {item:2378}.",
	-- ["The cemetery lies north of the village. Skeletal Horrors and Skeletal Fiends walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "Le cimetière se trouve au nord du village. Les Squelettes infernaux et les Démons squelettes errent dans sa moitié sud. {npc:522}, un élite, rôde parmi les tombes : tenez-vous à l'écart.",
	-- ["The hermit's shack stands in the woods north-east of the {area:492}."] = "La cabane de l'ermite se trouve dans les bois au nord-est de {area:492}.",
	-- ["The mound of loose dirt lies south of the farmhouse, by the old stump."] = "Le monticule de poussière se trouve au sud de la ferme, près de la vieille souche.",
	-- ["Train in {zone:1453}, north through {zone:1429}. Then take the boat from {area:17203} to {area:442}."] = "Entraînez-vous à {zone:1453}, au nord à travers {zone:1429}. Prenez ensuite le bateau de {area:17203} pour {area:442}.",
	-- ["Wolves, spiders and ghouls"] = "Loups, araignées et goules",
	-- ["{area:108} flight master"] = "Maître de vol de {area:108}",
	-- ["{area:1097}: kill these as you meet them"] = "{area:1097} : tuez-les au passage",
	-- ["{area:121}: kill these as you meet them"] = "{area:121} : tuez-les au passage",
	-- ["{area:492}, south"] = "{area:492}, sud",
	-- ["{item:281046}, from the {object:673515}"] = "{item:281046}, sur le {object:673515}",
	-- ["{item:3372}: {npc:1313}, {skill:171} Supplies"] = "{item:3372} : {npc:1313}, fournitures d'{skill:171}",
	-- ["{item:4371}, from {npc:3133}, if you have none"] = "{item:4371}, chez {npc:3133}, si vous n'en avez pas",
	-- ["{item:4371}, from {npc:3133}: limited stock. Sold out? {npc:1448} in {area:150} sells it too."] = "{item:4371}, chez {npc:3133} : stock limité. Épuisé ? {npc:1448} à {area:150} en vend aussi.",
	-- ["{npc:14235} Blossoms"] = "Fleurs de {npc:14235}",
	-- ["{npc:202} on the way"] = "{npc:202} en chemin",
	-- ["{npc:2409}, at the north end of town"] = "{npc:2409}, à l'extrémité nord de la ville",
	-- ["{npc:264}, in the town hall"] = "{npc:264}, à l'hôtel de ville",
	-- ["{npc:265}, in her house by the tavern"] = "{npc:265}, dans sa maison près de la taverne",
	-- ["{npc:265}, in her house by the tavern; inside"] = "{npc:265}, dans sa maison près de la taverne ; à l'intérieur",
	-- ["{npc:268}, in the house behind the town hall"] = "{npc:268}, dans la maison derrière l'hôtel de ville",
	-- ["{npc:268}, inside"] = "{npc:268}, à l'intérieur",
	-- ["{npc:276}'s house stands at the east end of town. {npc:3133} sells engineering goods in the house beside it."] = "La maison de {npc:276} se trouve à l'extrémité est de la ville. {npc:3133} vend des fournitures d'ingénierie dans la maison voisine.",
	-- ["{npc:276}, inside"] = "{npc:276}, à l'intérieur",
	-- ["{npc:332}: {spell:2842}, and {item:18160}"] = "{npc:332} : {spell:2842} et {item:18160}",
	-- ["{npc:531} on the way"] = "{npc:531} en chemin",
	-- ["{npc:533} on the way"] = "{npc:533} en chemin",
	-- ["{npc:6173} and {npc:6171} are in the Cathedral of Light."] = "{npc:6173} et {npc:6171} sont dans la Cathédrale de la Lumière.",
	-- ["{npc:633}, at the south end of town"] = "{npc:633}, à l'extrémité sud de la ville",
	-- ["{npc:633}, at the south end of town; inside"] = "{npc:633}, au sud de la ville ; à l'intérieur",
	-- ["{npc:663}, by the town hall"] = "{npc:663}, près de l'hôtel de ville",
	-- ["{npc:6790}, Scarlet Raven Tavern"] = "{npc:6790}, taverne du Corbeau écarlate",
	-- ["{npc:888} stands south of the road, at the {area:245}."] = "{npc:888} se tient au sud de la route, à {area:245}.",
	-- ["{quest:337}: a rare drop from {area:10}'s mobs"] = "{quest:337} : butin rare des monstres du {area:10}",
	-- ["{quest:337}: a rare drop from {zone:1431}'s mobs"] = "{quest:337} : butin rare des monstres de {zone:1431}",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the {area:442} boat."] = "{zone:1453} n'a pas de maître des chamans : prenez le {area:2257} depuis {object:28027} jusqu'à {zone:1455}, entraînez-vous auprès de {npc:258098}, puis reprenez le tram pour le bateau d'{area:442}.",
}
