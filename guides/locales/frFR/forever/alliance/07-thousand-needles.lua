-- French (frFR): the guide forever/alliance/07-thousand-needles (forever/alliance/07-thousand-needles.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Darkshire
	-- {npc:6790} Innkeeper Trelayne
	["{npc:6790}, Scarlet Raven Tavern"] = "{npc:6790}, taverne du Corbeau écarlate",
	-- {npc:840} Watcher Backus · {area:42} Darkshire
	["{npc:840}, at the north entrance of town; walks around {area:42}: look inside the circle on the map"] = "{npc:840}, à l'entrée nord de la ville ; patrouille autour de {area:42} : regardez dans le cercle sur la carte",

	-- Step 3: Nightbane Shadow Weavers
	-- plural, as words: Nightbane Shadow Weavers = {npc:533} Nightbane Shadow Weaver
	["Nightbane Shadow Weavers"] = "Tisseurs d'ombre Plaie-de-nuit",
	-- {area:42} Darkshire
	["The worgen hold the woods of Brightwood, west of {area:42} and north of the road. Pull them one at a time."] = "Les worgens tiennent les bois du Bosquet de Clairbois, à l'ouest de {area:42} et au nord de la route. Attirez-les un par un.",

	-- Step 5: Nightbane Dark Runners
	-- plural, as words: Nightbane Dark Runners = {npc:205} Nightbane Dark Runner
	["Nightbane Dark Runners"] = "Messagers Plaie-de-nuit",
	-- {area:42} Darkshire
	["The Dark Runners prowl the woods south of the road, west of {area:42}."] = "Les Messagers rôdent dans les bois au sud de la route, à l'ouest de {area:42}.",

	-- Step 7: Nightbane Vile Fangs and the Insane Ghoul
	-- {npc:511} Insane Ghoul
	-- plural, as words: Nightbane Vile Fangs = {npc:206} Nightbane Vile Fang
	["Nightbane Vile Fangs and the {npc:511}"] = "Crocs noirs Plaie-de-nuit et {npc:511}",
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery · {npc:511} Insane Ghoul · {spell:8282} Curse of Blood
	["The strongest worgen roam the woods south of {area:42}, west and south of the {area:121}. The {npc:511} hides in the small crypt by the cemetery.\nCareful: {spell:8282} lasts 10 minutes and adds 13 to each hit of physical damage you take.\nCareful: Some worgen outside the cave stand in groups, including one camp of four. To avoid adds, pull them one at a time from the raised ground next to the cave entrance."] = "Les worgens les plus forts parcourent les bois au sud de {area:42}, à l'ouest et au sud du {area:121}. {npc:511} se cache dans la petite crypte près du cimetière.\nAttention : {spell:8282} dure 10 minutes et ajoute 13 points à chaque coup physique que vous subissez.\nAttention : certains worgens devant la grotte se tiennent en groupes, dont un camp de quatre. Pour éviter les renforts, attirez-les un par un depuis la butte à côté de l'entrée de la grotte.",
	-- {item:1946} Mary's Looking Glass
	["{item:1946}; inside"] = "{item:1946} ; à l'intérieur",

	-- Step 8: Darkshire
	-- {npc:276} Viktori Prism'Antras
	["{npc:276}, inside"] = "{npc:276}, à l'intérieur",
	-- {npc:661} Jonathan Carevin · {npc:633} Elaine Carevin
	["{npc:661}, by {npc:633}'s house; inside"] = "{npc:661}, près de la maison de {npc:633} ; à l'intérieur",

	-- Step 9: Vul'Gol Ogre Mound: kill these as you meet them
	-- {area:93} Vul'Gol Ogre Mound
	["{area:93}: kill these as you meet them"] = "{area:93} : tuez-les au passage",
	-- {area:42} Darkshire · {object:119} Abercrombie's Crate
	["Head south-west from {area:42} to the ogre mound. {object:119} sits in the camp at its entrance; Splinter Fist ogres guard it."] = "",
	-- {npc:272273} Lost Watcher · {quest:96138} Merrick's Bow
	["Only if a {npc:272273} dropped {quest:96138}: right-click it"] = "Seulement si un {npc:272273} a laissé tomber {quest:96138} : clic droit dessus",
	["Below ground"] = "Sous terre",

	-- Step 10: Defias Strongbox
	-- {zone:1431} Duskwood · {area:94} Raven Hill · {zone:1436} Westfall
	["The Defias camp lies in the south-west of {zone:1431}, south of {area:94} near the {zone:1436} border. The strongbox stands among the tents."] = "Le camp défias se trouve dans le sud-ouest de {zone:1431}, au sud de {area:94}, près de la frontière de {zone:1436}. Le coffre se trouve parmi les tentes.",
	-- {item:5947} Defias Docket
	["{item:5947}; inside"] = "{item:5947} ; à l'intérieur",

	-- Step 12: Raven Hill Cemetery: kill these as you meet them
	-- {area:492} Raven Hill Cemetery
	["{area:492}: kill these as you meet them"] = "{area:492} : tuez-les au passage",
	-- {area:492} Raven Hill Cemetery · {npc:522} Mor'Ladim · {npc:311} Sven Yorgen
	-- plural, as words: Plague Spreaders = {npc:604} Plague Spreader · Skeletal Raiders = {npc:1110} Skeletal Raider
	["The Plague Spreaders walk the northern half of the {area:492}. {npc:522}, an elite, wanders the graves: keep away from him.\nSkeletal Raiders, Healers and Warders hold the west part of the cemetery, just east of {npc:311}'s camp.\nCareful: The skeletons in the catacombs are packed close together, so you can easily pull extra mobs."] = "Les Répandeurs de peste errent dans la moitié nord du {area:492}. {npc:522}, un élite, rôde parmi les tombes : tenez-vous à l'écart.\nDes Écumeurs squelettes, des Soigneurs squelettes et des Gardiens squelettes tiennent la partie ouest du cimetière, juste à l'est du camp de {npc:311}.\nAttention : les squelettes des catacombes sont serrés les uns contre les autres : vous pouvez facilement attirer des monstres en plus.",

	-- Step 13: The Weathered Grave
	-- {npc:311} Sven Yorgen · {npc:268} Sirra Von'Indi · {area:42} Darkshire
	["The grave stands among the skeletons at the cemetery's north-west corner, on the way to {npc:311}. Its quest and the next are talk-only, to {npc:268} and Commander Althea in {area:42}: level 35 from level 28, but no fight."] = "",

	-- Step 14: Sven Yorgen's Camp
	-- {npc:311} Sven Yorgen
	["{npc:311}'s Camp"] = "Le camp de {npc:311}",
	-- {npc:1212} Bishop Farthing · {zone:1453} Stormwind
	["For {npc:1212} in {zone:1453}, in the next guide"] = "Pour {npc:1212} à {zone:1453}, dans le guide suivant",

	-- Step 15: Back to Darkshire
	-- {area:42} Darkshire
	["Back to {area:42}"] = "Retour à {area:42}",
	-- {npc:263} Lord Ello Ebonlocke
	["{npc:263}, in the town hall"] = "{npc:263}, à l'hôtel de ville",
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, in the house behind the town hall"] = "{npc:268}, dans la maison derrière l'hôtel de ville",
	["Wait a moment, then speak with her again"] = "Patientez un instant, puis parlez-lui de nouveau",
	-- {npc:840} Watcher Backus · {area:42} Darkshire
	["{npc:840} walks around {area:42}: look inside the circle on the map"] = "{npc:840} se promène autour de {area:42} : cherchez dans le cercle sur la carte",
	-- {npc:482} Elling Trias · {zone:1453} Stormwind
	["For {npc:482} in {zone:1453}, in the next guide"] = "Pour {npc:482} à {zone:1453}, dans le guide suivant",

	-- Step 16: Viktori Prism'Antras
	-- {npc:276} Viktori Prism'Antras
	["{npc:276}'s house stands at the east end of town, on the way to the flight master."] = "",
	["Inside"] = "À l'intérieur",

	-- Step 17: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Prendre un vol pour {area:150}",
	-- {area:42} Darkshire
	["{area:42} flight master"] = "Maître de vol de {area:42}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to Menethil"] = "Retour à Menethil",
	-- ["Bluegill Raiders"] = "Écumeurs Branchie-bleue",
	-- ["Dragonmaw camp"] = "Camp Dragonmaw",
	-- ["Dragonmaw catapult"] = "Catapulte Dragonmaw",
	-- ["Fly to {zone:1453}"] = "Prendre un vol pour {zone:1453}",
	-- ["Follow the canyons east to the salt flats. The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "Suivez les canyons vers l'est jusqu'aux Salines. Les gobelins et les gnomes de {area:2240} sont neutres et donnent des quêtes aux deux factions.",
	-- ["Follow the coast north to the wrecked ship. Cursed Sailors walk the beach, Cursed Marines the deck; {npc:1159} stands on the beach by the bow. Giant Wetlands Crocolisks lurk on the coast just north of it."] = "Suivez la côte vers le nord jusqu'à l'épave. Des Marins maudits ({npc:1157}) arpentent la plage, des Soldats de marine maudits ({npc:1158}) le pont ; {npc:1159} se tient sur la plage près de la proue. Des Crocilisques géants des Paluns ({npc:2089}) rôdent sur la côte juste au nord.",
	-- ["Follow the coast north to the wrecked ship. Cursed Sailors walk the beach, Cursed Marines the deck; {npc:1159} stands on the beach by the bow. Giant Wetlands Crocolisks lurk on the coast just north of it.\nCareful: Fen Creepers hide in stealth where the river splits close to the ghost ship, and they can join a fight."] = "Suivez la côte vers le nord jusqu'à l'épave. Des Marins maudits arpentent la plage, des Soldats de marine maudits le pont ; {npc:1159} se tient sur la plage près de la proue. Des Crocilisques géants des Paluns rôdent sur la côte juste au nord.\nAttention : des Rampants des tourbières se cachent, camouflés, là où la rivière se divise près du navire fantôme, et peuvent se joindre au combat.",
	-- ["Follow the coast north-east past the wreck: the Bluegill Raiders hold the marsh beyond the Giant Crocolisks."] = "Suivez la côte vers le nord-est après l'épave : les Écumeurs Branchie-bleue tiennent le marais au-delà des Crocilisques géants.",
	-- ["Follow the road east to the excavation site."] = "Suivez la route vers l'est jusqu'aux Excavations de Whelgar.",
	-- ["For the Dragonmaw catapult, on the {zone:1437} loop of the next guide"] = "Pour la catapulte Dragonmaw, lors de la boucle des {zone:1437} du guide suivant",
	-- ["For {npc:1284} in {zone:1453}, in the next guide"] = "Pour {npc:1284} à {zone:1453}, dans le guide suivant",
	-- ["For {npc:4048} in {zone:1444}, much later"] = "Pour {npc:4048} en {zone:1444}, bien plus tard",
	-- ["For {quest:5762} in Stranglethorn, later"] = "Pour {quest:5762} à Strangleronce, plus tard",
	-- ["From Theramore follow the road west out of Dustwallow into the {zone:1413} and south along it; give {area:378} a wide berth. {area:485} at the {zone:1413}' south end takes you down into {zone:1441}. The journal lies at the foot of the lift."] = "Depuis Theramore, suivez la route vers l'ouest pour quitter Âprefange et entrer dans {zone:1413}, puis vers le sud ; évitez largement {area:378}. {area:485}, à l'extrémité sud de {zone:1413}, vous fait descendre à {zone:1441}. Le journal se trouve au pied de l'élévateur.",
	-- ["From {npc:352} in {zone:1453}"] = "De {npc:352} à {zone:1453}",
	-- ["Head east again to the Dragonmaw camp. The four sets of Attack Plans lie in the {area:1036}; {npc:2091}, an elite, stands in the camp too."] = "Retournez vers l'est jusqu'au camp Dragonmaw. Les quatre jeux de plans d'attaque se trouvent au {area:1036} ; {npc:2091}, un élite, se tient aussi dans le camp.",
	-- ["Head east to the ogre mound. {object:119} sits in the camp at its entrance; Splinter Fist ogres guard it."] = "Allez vers l'est jusqu'au tertre des ogres. {object:119} se trouve dans le camp à son entrée ; des ogres Brisepoing la gardent.",
	-- ["Hearth to {area:42}"] = "Pierre de foyer vers {area:42}",
	-- ["Her house stands on the hill south-east of {area:42}."] = "Sa maison se trouve sur la colline au sud-est de {area:42}.",
	-- ["Into {zone:1413}"] = "Vers les {zone:1413}",
	-- ["Nightbane Shadow Weavers"] = "Tisseurs d'ombre Plaie-de-nuit",
	-- ["No {item:4371} for {quest:174}? {npc:3133} sells it in the house beside {npc:276}, in limited stock; {npc:1448} in {area:150} sells it too."] = "Pas de {item:4371} pour {quest:174} ? {npc:3133} en vend dans la maison voisine de celle de {npc:276}, en stock limité ; {npc:1448} à {area:150} en vend aussi.",
	-- ["On the road south through the {zone:1413}, {npc:6244} camps east of the road, north-east of {area:378}; come in from the east and keep clear of the Horde guards."] = "Sur la route vers le sud à travers les {zone:1413}, {npc:6244} campe à l'est de la route, au nord-est du {area:378} ; arrivez par l'est et évitez les gardes de la Horde.",
	-- ["On the top floor"] = "Au dernier étage",
	-- ["On the way"] = "En chemin",
	-- ["Plague Spreaders"] = "Répandeurs de peste",
	-- ["Ride back west along the road to {area:150}."] = "Revenez vers l'ouest le long de la route jusqu'à {area:150}.",
	-- ["Ride east again to the Dragonmaw camp. The four sets of Attack Plans lie in the {area:1036}; {npc:2091}, an elite, stands in the camp too."] = "Repartez vers l'est jusqu'au camp des Dragonmaw. Les quatre jeux de plans d'attaque se trouvent dans {area:1036} ; {npc:2091}, un élite, se tient aussi dans le camp.",
	-- ["Ride east again; the catapult stands at the Dragonmaw camp south of the road."] = "Chevauchez de nouveau vers l'est ; la catapulte se trouve au camp Dragonmaw au sud de la route.",
	-- ["Ride east to the ogre mound. {item:1349} sits in the camp at its entrance; Splinter Fist ogres guard it."] = "Chevauchez vers l'est jusqu'au tertre des ogres. {item:1349} se trouve dans le camp à son entrée ; des ogres Brisepoing la gardent.",
	-- ["Ride east to the ogre mound. {object:119} sits in the camp at its entrance; Splinter Fist ogres guard it."] = "Chevauchez vers l'est jusqu'au tertre des ogres. La {object:119} se trouve dans le camp à son entrée ; des ogres Brisepoing la gardent.",
	-- ["Ride west along the road; the hermit's shack stands north-east of the {area:492}."] = "Chevauchez vers l'ouest le long de la route ; la cabane de l'ermite se trouve au nord-est de {area:492}.",
	-- ["Skeletal Raiders, Healers and Warders hold the west part of the cemetery, just east of {npc:311}'s camp."] = "Les Écumeurs, Soigneurs et Gardiens squelettes tiennent la partie ouest du cimetière, juste à l'est du camp de {npc:311}.",
	-- ["Take the boat from Menethil's pier to {area:513} in {zone:1445}."] = "Prenez le bateau du quai de Menethil pour {area:513}, dans {zone:1445}.",
	-- ["The Defias camp lies in the south-west of {area:10}, south of {area:94} near the {zone:1436} border. The strongbox stands among the tents."] = "Le camp des Défias se trouve dans le sud-ouest du {area:10}, au sud de {area:94}, près de la frontière avec {zone:1436}. Le coffre se trouve parmi les tentes.",
	-- ["The Dragonmaw orcs camp east of the excavation site. Raiders and Swamprunners carry the war banners."] = "Les orcs Dragonmaw campent à l'est des Excavations de Whelgar. Les Écumeurs et les Arpenteurs portent les bannières de guerre.",
	-- ["The Goaz Warders stand just west of Whelgar's camp: use the {item:279996} he gave you beside one.\nThe relics lie in the dig itself. {npc:1353}, a big Razormaw, prowls the raptor valley just west of it.\nThe Dragonmaw orcs camp east of the excavation site. Raiders and Swamprunners carry the war banners."] = "Les Gardiens de Goaz se tiennent juste à l'ouest du camp de Whelgar : utilisez à côté de l'un d'eux la {item:279996} qu'il vous a donnée.\nLes reliques se trouvent dans les fouilles elles-mêmes. {npc:1353}, un gros Tranchegueule, rôde dans la vallée des raptors juste à l'ouest.\nLes orcs Dragonmaw campent à l'est du site de fouilles. Les Écumeurs et les Arpenteurs portent les bannières de guerre.",
	-- ["The Plague Spreaders walk the northern half of the {area:492}. {npc:522}, an elite, wanders the graves: keep away from him."] = "Les Répandeurs de peste errent dans la moitié nord de {area:492}. {npc:522}, un élite, rôde parmi les tombes : tenez-vous à l'écart.",
	-- ["The captain walks the deck of the wrecked ship; his strongbox sits in the hold."] = "Le capitaine arpente le pont du navire échoué ; son coffre est dans la cale.",
	-- ["The dig and {npc:1353}"] = "Les fouilles et {npc:1353}",
	-- ["The next step, Defeat Nek'rosh, pits you against an elite chieftain: skip it."] = "L'étape suivante, Vaincre Nek'rosh, vous oppose à un chef élite : passez-la.",
	-- ["The relics lie in the dig itself. {npc:1353}, a big Razormaw, prowls the raptor valley just west of it."] = "Les reliques se trouvent dans les fouilles mêmes. {npc:1353}, un grand raptor Razormaw, rôde dans la vallée des raptors juste à l'ouest.",
	-- ["The salt flats"] = "Les Salines",
	-- ["The strongest worgen roam the woods south of {area:42}, west and south of the {area:121}. The {npc:511} hides in the small crypt by the cemetery."] = "Les worgens les plus forts rôdent dans les bois au sud de {area:42}, à l'ouest et au sud de {area:121}. Le {npc:511} se cache dans la petite crypte près du cimetière.",
	-- ["The wreck of the Third Fleet"] = "L'épave de la Troisième flotte",
	-- ["To Theramore"] = "Vers Theramore",
	-- ["{area:1039}: kill these as you meet them"] = "{area:1039} : tuez-les au passage",
	-- ["{area:118}: kill these as you meet them"] = "{area:118} : tuez-les au passage",
	-- ["{area:2240}: kill these as you meet them"] = "{area:2240} : tuez-les au passage",
	-- ["{area:492}, west"] = "{area:492}, ouest",
	-- ["{item:2594}, from {npc:1464}"] = "{item:2594}, chez {npc:1464}",
	-- ["{item:2658} along the way to {npc:1078} and Whelgar"] = "{item:2658} en chemin vers {npc:1078} et Whelgar",
	-- ["{item:2659} along the way to {npc:1078} and Whelgar"] = "{item:2659} en chemin vers {npc:1078} et Whelgar",
	-- ["{item:2660} along the way to {npc:1078} and Whelgar"] = "{item:2660} en chemin vers {npc:1078} et Whelgar",
	-- ["{item:2661} along the way to {npc:1078} and Whelgar"] = "{item:2661} en chemin vers {npc:1078} et Whelgar",
	-- ["{item:2661}: the {object:331}"] = "{item:2661} : le {object:331}",
	-- ["{item:4371}, from {npc:3133}, if you have none"] = "{item:4371}, chez {npc:3133}, si vous n'en avez pas",
	-- ["{npc:1078} and Whelgar"] = "{npc:1078} et Whelgar",
	-- ["{npc:1217}, inside"] = "{npc:1217}, à l'intérieur",
	-- ["{npc:1217}, upstairs in the inn"] = "{npc:1217}, à l'étage de l'auberge",
	-- ["{npc:1239}, in the inn"] = "{npc:1239}, à l'auberge",
	-- ["{npc:2104}, by the keep"] = "{npc:2104}, près du donjon",
	-- ["{npc:2104}, in {area:2103}"] = "{npc:2104}, dans {area:2103}",
	-- ["{npc:2104}, in {area:2103}; on the top floor"] = "{npc:2104}, dans {area:2103} ; au dernier étage",
	-- ["{npc:267}, in the town hall"] = "{npc:267}, à l'hôtel de ville",
	-- ["{npc:276}, at the east end of town"] = "{npc:276}, à l'extrémité est de la ville",
	-- ["{npc:276}, at the east end of town; inside"] = "{npc:276}, à l'extrémité est de la ville ; à l'intérieur",
	-- ["{npc:4454}: for Martek in the {zone:1418}, later"] = "{npc:4454} : pour Martek dans {zone:1418}, plus tard",
	-- ["{npc:661}, by {npc:633}'s house"] = "{npc:661}, près de la maison de {npc:633}",
	-- ["{npc:663}, by the town hall"] = "{npc:663}, près de l'hôtel de ville",
	-- ["{npc:840}, at the north entrance of town"] = "{npc:840}, à l'entrée nord de la ville",
	-- ["{object:19868} lies all over the flats. Scorpid Reavers, Sparkleshell Tortoises and Saltstone Basilisks roam the north half, Crystalhides, Scorpid Terrors and Snappers the middle, and the Gazers (34-35, five levels above you: one at a time) the far south. Vultures circle over all of it."] = "{object:19868} jonchent les Salines. Les Scorpides ravageurs, Tortues nacrétoile et Basilics du sel gemme parcourent la moitié nord, les Peaux de cristal, Scorpides terrifiants et Mordeuses au milieu, et les Contemplateurs (34-35, cinq niveaux au-dessus de vous : un à la fois) à l'extrême sud. Des vautours tournoient au-dessus de tout cela.",
	-- ["{quest:1738}: in {zone:1440}, on the way to {zone:1443}"] = "{quest:1738} : en {zone:1440}, en route vers {zone:1443}",
	-- ["{quest:65602}: the incubus, beside the succubus; the {item:190309} is near the {quest:1738}"] = "{quest:65602} : l'incube, à côté de la succube ; la {item:190309} est près de {quest:1738}",
	-- ["{quest:98221}: {quest:465} comes after it on Forever"] = "{quest:98221} : sur Forever, {quest:465} vient après",
	-- ["{zone:1453} flight master"] = "Maître de vol de {zone:1453}",
}
