-- French (frFR): the guide forever/alliance/nightelf/02-darkshore (forever/alliance/nightelf/02-darkshore.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Auberdine
	["The boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street."] = "Le bateau accoste à l'ouest du village. Le maître de vol se tient sur la colline au sud de l'auberge ; les donneurs de quêtes sont répartis le long de la rue principale.",
	["The WANTED poster outside the inn"] = "L'affiche AVIS DE RECHERCHE devant l'auberge",

	-- Step 2: The beach
	["The beach"] = "La plage",
	-- {quest:983} Buzzbox 827 · {object:175207} Beached Sea Creature
	-- plural, as words: Tide Crawlers = {npc:2232} Tide Crawler · Darkshore Threshers = {npc:2185} Darkshore Thresher
	["Tide Crawlers scuttle along the shore below the village; {quest:983} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {object:175207} lies on the shore just south of the village."] = "Les Clampants des marées grouillent sur la côte en contrebas du village ; {quest:983} se trouve sur la plage juste au sud des quais. Les Batteurs de Sombrivage nagent dans les hauts-fonds. La {object:175207} gît sur la côte juste au sud du village.",

	-- Step 3: Auberdine
	-- {npc:3649} Thundris Windweaver
	["{npc:3649}, north end of the village"] = "{npc:3649}, au nord du village",

	-- Step 4: Auberdine
	-- {npc:3666} Wizbang Cranktoggle
	["The boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street. {npc:3666} stands upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "Le bateau accoste à l'ouest du village. Le maître de vol se tient sur la colline au sud de l'auberge ; les donneurs de quêtes sont répartis le long de la rue principale. {npc:3666} se tient à l'étage de l'auberge : montez par l'escalier intérieur, la flèche ne distingue pas les étages.",
	-- {npc:3666} Wizbang Cranktoggle
	["{npc:3666}, upstairs in the inn"] = "{npc:3666}, à l'étage de l'auberge",
	-- {npc:3644} Cerellean Whiteclaw
	["{npc:3644}, on the pier"] = "{npc:3644}, sur la jetée",

	-- Step 5: The skeletal turtle
	["The skeletal turtle"] = "La tortue squelettique",
	-- {item:12289} Sea Turtle Remains
	["{item:12289}, on the beach west of the docks; underwater"] = "{item:12289}, sur la plage à l'ouest des quais ; sous l'eau",

	-- Step 6: Buzzbox 827
	-- {quest:983} Buzzbox 827
	-- plural, as words: Tide Crawlers = {npc:2232} Tide Crawler
	["Only if you still carry {quest:983}'s quest: the Tide Crawlers scuttle along the shore below the village, and {quest:983} stands on the beach just south of the docks."] = "Seulement si vous avez encore la quête de {quest:983} : les Clampants des marées grouillent sur la côte en contrebas du village, et {quest:983} se tient sur la plage juste au sud des quais.",
	-- plural, as words: Crawler Legs = {item:5385} Crawler Leg · Tide Crawlers = {npc:2232} Tide Crawler
	["Crawler Legs: the Tide Crawlers"] = "Pattes de clampant : les Clampants des marées",

	-- Step 7: Bears and the Blackwood camp
	["Bears and the Blackwood camp"] = "Les ours et le camp Noirbois",
	-- {area:442} Auberdine · {item:7586} Tharnariun's Hope
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["Rabid Thistle Bears roam the hills south of {area:442}: use {item:7586} on one to capture it. Then walk up to the furbolg camp just east of them: nothing to kill yet."] = "Des Ours des chardons enragés parcourent les collines au sud d'{area:442} : utilisez {item:7586} sur l'un d'eux pour le capturer. Montez ensuite jusqu'au camp de furbolgs juste à l'est : rien à tuer pour l'instant.",
	-- {npc:3701} Tharnariun Treetender
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["the Rabid Thistle Bears nearest {npc:3701}"] = "les Ours des chardons enragés les plus proches de {npc:3701}",

	-- Step 8: Ameth'Aran
	-- {npc:3639} Sentinel Tysha Moonblade · {npc:2178} Wailing Highborne · {npc:3667} Anaya Dawnrunner · {npc:270196} Jai'vhanel · {quest:4722} Beached Sea Turtle
	["{npc:3639} stands at the north edge of the ruins. Cursed, Writhing and {npc:2178} haunt them; {npc:3667}'s ghost walks among them, {npc:270196} the owl circles east of them. The two tablets lie in the ruins; a {quest:4722} lies on the shore west of them."] = "{npc:3639} se tient à la lisière nord des ruines. Des Bien-nés maudits, des Bien-nés frémissants et des {npc:2178} les hantent ; le fantôme d'{npc:3667} erre parmi eux, la chouette {npc:270196} tournoie à l'est. Les deux tablettes se trouvent dans les ruines ; une {quest:4722} gît sur la côte à l'ouest.",
	-- plural, as words: Highborne Relics = {item:5360} Highborne Relic
	["Highborne Relics"] = "Reliques de bien-Né",
	-- {object:17188} Lay of Ameth'Aran
	["Read the {object:17188}"] = "Lisez {object:17188}",
	-- {object:17189} Fall of Ameth'Aran
	["Read the {object:17189}"] = "Lisez {object:17189}",
	-- {item:5382} Anaya's Pendant · {npc:3667} Anaya Dawnrunner
	["{item:5382}: {npc:3667}, level 16; pull her away from the Highborne"] = "{item:5382} : {npc:3667}, niveau 16 ; éloignez-la des Bien-nés",

	-- Step 9: The red crystal
	["The red crystal"] = "Le cristal rouge",
	-- {area:447} Ameth'Aran · {object:175524} Mysterious Red Crystal
	["Climb the eastern mountains east of {area:447}; the {object:175524} sits on a ledge."] = "Escaladez les montagnes à l'est d'{area:447} ; le {object:175524} repose sur une corniche.",

	-- Step 10: Bashal'Aran
	-- {npc:3650} Asterion · {quest:954} Bashal'Aran · {object:17183} Buzzbox 411 · {quest:4723} Beached Sea Creature
	-- plural, as words: Wild Grells = {npc:2190} Wild Grell · Vile Sprites = {npc:2189} Vile Sprite · Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["North along the hills. {npc:3650} waits in the ruins of {quest:954}; Wild Grells and Vile Sprites fill them, Deth'ryll Satyrs the eastern edge. {object:17183} stands by the road west of the ruins; a {quest:4723} lies on the shore on the way to him."] = "Vers le nord, le long des collines. {npc:3650} attend dans les ruines de {quest:954} ; des Grells sauvages et des Fées viles les remplissent, des Satyres Deth'ryll en occupent le bord est. {object:17183} se dresse au bord de la route à l'ouest des ruines ; une {quest:4723} repose sur le rivage en chemin vers lui.",
	-- plural, as words: Grell Earrings = {item:5336} Grell Earring
	["Grell Earrings"] = "Boucles d'oreille de grell",
	-- {item:5338} Ancient Moonstone Seal
	-- plural, as words: Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["{item:5338}: Deth'ryll Satyrs"] = "{item:5338} : Satyres Deth'ryll",

	-- Step 12: Auberdine
	["Fill the tube at the moonwell in the village"] = "Remplissez le tube au puits de lune du village",

	-- Step 13: Blackwood furbolgs
	["Blackwood furbolgs"] = "Les furbolgs Noirbois",
	-- {area:442} Auberdine
	-- plural, as words: Blackwood Pathfinders = {npc:2167} Blackwood Pathfinder
	["Blackwood Pathfinders and Windtalkers hold the camp south-east of {area:442}."] = "Des Guides Noirbois et des Messagers du Vent Noirbois tiennent le camp au sud-est d'{area:442}.",

	-- Step 14: The southern beaches
	["The southern beaches"] = "Les plages du sud",
	-- {area:447} Ameth'Aran · {quest:4728} Beached Sea Creature · {area:450} Remtravel's Excavation
	-- plural, as words: Greymist Oracles = {npc:2207} Greymist Oracle
	["Follow the coast south past {area:447}: one {quest:4728} lies on the shore west of the Grove, another further south near {area:450}. Three more remains lie further south-west among Greymist Oracles and Tidehunters (18-20): the guide leaves them for the last loop, when you are closer to their level."] = "Suivez la côte vers le sud au-delà d'{area:447} : une {quest:4728} gît sur la côte à l'ouest du Bosquet des Anciens, une autre plus au sud près de l'{area:450}. Trois autres restes gisent plus au sud-ouest parmi les Oracles Grisebrume et les Chasse-marée Grisebrume (18-20) : le guide les garde pour la dernière boucle, quand vous serez plus proche de leur niveau.",

	-- Step 15: Ameth'Aran
	-- {area:447} Ameth'Aran
	["Back north to {area:447}: the flame burns in the south of the ruins."] = "Retournez au nord jusqu'à {area:447} : la flamme brûle au sud des ruines.",

	-- Step 16: The red crystal
	["Back north-east into the mountains to the crystal."] = "Retournez au nord-est dans les montagnes jusqu'au cristal.",

	-- Step 17: Bashal'Aran
	-- {npc:3650} Asterion · {area:442} Auberdine
	["North along the hills to {npc:3650}, then west down to {area:442}."] = "Vers le nord le long des collines jusqu'à {npc:3650}, puis descendez vers l'ouest jusqu'à {area:442}.",

	-- Step 18: Auberdine
	-- {npc:3644} Cerellean Whiteclaw
	["{npc:3644}, where the pier meets the shore, on the way to the boat"] = "{npc:3644}, là où la jetée rejoint le rivage, sur le chemin du bateau",

	-- Step 19: Boat to Stormwind Harbor
	-- {area:17203} Stormwind Harbor
	["Boat to {area:17203}"] = "Bateau pour {area:17203}",

	-- Step 20: Manifest Clerk Philmor
	-- {npc:268511} Manifest Clerk Philmor · {npc:483} Elaine Trias · {object:2096} Trade District
	["Off the boat, {npc:268511} stands on the harbor: his shipment goes to {npc:483}' cheese shop in the {object:2096}, beside the flight master."] = "En descendant du bateau, {npc:268511} se tient sur le port : sa cargaison va à la fromagerie de {npc:483}, dans {object:2096}, à côté du maître de vol.",

	-- Step 21: Stormwind flight master
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Maître de vol de {zone:1453}",
	-- {npc:483} Elaine Trias
	["{npc:483}, in her cheese shop"] = "{npc:483}, dans sa fromagerie",
	-- {object:460004} Gatehouse Door (no name in this language: may be words)
	["Up the stairs in her shop: leave the shipment at the {object:460004}"] = "Montez l'escalier de sa boutique : déposez la cargaison à {object:460004}",

	-- Step 22: Baros Alexston
	-- {npc:1646} Baros Alexston · {object:2098} Cathedral Square · {object:2096} Trade District · {zone:1436} Westfall
	["{npc:1646} stands in {object:2098}, west of the {object:2096}: his compass is in his old house in {zone:1436}, on the way."] = "{npc:1646} se tient sur {object:2098}, à l'ouest de {object:2096} : sa boussole est dans son ancienne maison en {zone:1436}, sur le chemin.",

	-- Step 23: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "Pendant que vous y êtes : apprenez {spell:202} auprès de {npc:11867} ({object:2096}, 10 pièces d'argent) ; les armes à deux mains font progresser un Guerrier le plus vite.",

	-- Step 24: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Swords from {npc:11867} ({object:2096}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "Pendant que vous y êtes : apprenez le maniement des épées auprès de {npc:11867} ({object:2096}, 10 pièces d'argent) ; une épée en main droite fait progresser un Voleur régulièrement.",

	-- Step 25: Druid trainer
	["Druid trainer"] = "Maître des druides",
	-- {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {area:87} Goldshire
	["{npc:5504} in {zone:1453}; {area:87} has no druid trainer"] = "{npc:5504} dans {zone:1453} ; {area:87} n'a pas de maître des druides",

	-- Step 27: Class trainer
	["Class trainer"] = "Maître de classe",

	-- Step 28: Shaman trainer
	["Shaman trainer"] = "Maître des chamans",
	-- {npc:257446} Teo Hammerstorm · {zone:1426} Dun Morogh · {area:87} Goldshire
	["{npc:257446} in {zone:1426}; {area:87} has no shaman trainer"] = "{npc:257446} à {zone:1426} ; {area:87} n'a pas de maître des chamans",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back south"] = "Retour au sud",
	-- ["Follow the coast north-east to the {area:443}. Mathystra Relics lie among the ruins; Stormscale Myrmidons, Sorceresses and Warriors hold them, and Stormscale Beastmistresses walk the shore."] = "Suivez la côte vers le nord-est jusqu'aux {area:443}. Des Reliques de Mathystra jonchent les ruines ; des Myrmidons, des Ensorceleuses et des Guerriers Tempécaille les gardent, et des Maîtresses des bêtes Tempécaille arpentent le rivage.",
	-- ["Follow the road north."] = "Suivez la route vers le nord.",
	-- ["Follow the road south. Onu is the ancient at the Grove; {npc:270269} and {npc:11218} sleep beside him."] = "Suivez la route vers le sud. Onu est l'ancien du Bosquet ; {npc:270269} et {npc:11218} dorment à côté de lui.",
	-- ["Hearth to {area:442}"] = "Pierre de foyer vers {area:442}",
	-- ["Hearthstone on cooldown? Follow the coast road back south."] = "Pierre de foyer en recharge ? Suivez la route côtière vers le sud.",
	-- ["Into {area:12}"] = "Vers {area:12}",
	-- ["Into {area:148}"] = "Vers {area:148}",
	-- ["Plagued bears"] = "Les ours pestiférés",
	-- ["Rabid Thistle Bears roam the hills just east of {area:442}. Use {item:7586} on one and lead it back to him."] = "Des Ours des chardons enragés parcourent les collines juste à l'est d'{area:442}. Utilisez l'{item:7586} sur l'un d'eux et ramenez-le jusqu'à lui.",
	-- ["The naga"] = "Les nagas",
	-- ["The {area:448}"] = "{area:448}",
}
