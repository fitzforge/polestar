-- French (frFR): the guide forever/alliance/nightelf/02-darkshore (forever/alliance/nightelf/02-darkshore.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Auberdine
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it.\nThe boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street."] = "Vous avez manqué ceci lors du passage précédent de l'itinéraire ici : cela passe d'abord maintenant. C'est rapide et cela ouvre les quêtes qui suivent.\nLe bateau accoste à l'ouest du village. Le maître de vol se tient sur la colline au sud de l'auberge ; les donneurs de quêtes sont répartis le long de la rue principale.",
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

	-- Step 6: The skeletal turtle
	["The skeletal turtle"] = "La tortue squelettique",
	-- {item:12289} Sea Turtle Remains
	["{item:12289}, on the beach west of the docks; underwater"] = "{item:12289}, sur la plage à l'ouest des quais ; sous l'eau",

	-- Step 7: Buzzbox 827
	-- {quest:983} Buzzbox 827
	-- plural, as words: Tide Crawlers = {npc:2232} Tide Crawler
	["Only if you still carry {quest:983}'s quest: the Tide Crawlers scuttle along the shore below the village, and {quest:983} stands on the beach just south of the docks."] = "Seulement si vous avez encore la quête de {quest:983} : les Clampants des marées grouillent sur la côte en contrebas du village, et {quest:983} se tient sur la plage juste au sud des quais.",
	-- plural, as words: Crawler Legs = {item:5385} Crawler Leg · Tide Crawlers = {npc:2232} Tide Crawler
	["Crawler Legs: the Tide Crawlers"] = "Pattes de clampant : les Clampants des marées",

	-- Step 8: Darkshore Threshers
	-- plural, as words: Darkshore Threshers = {npc:2185} Darkshore Thresher
	["Darkshore Threshers"] = "",
	-- {quest:983} Buzzbox 827 · {area:452} Mist's Edge · {quest:1001} Buzzbox 411 · {quest:954} Bashal'Aran
	-- plural, as words: Thresher Eyes = {item:5412} Thresher Eye · Darkshore Threshers = {npc:2185} Darkshore Thresher
	["{quest:983} stands on the beach just south of the docks: once his crawler legs are in, he asks for Thresher Eyes. The Darkshore Threshers (12-14) swim in the shallows off the docks and up the shore to {area:452}; {quest:1001}, who takes the eyes, stands north of {quest:954} at the end of the first loop."] = "",
	-- plural, as words: Thresher Eyes = {item:5412} Thresher Eye
	["Thresher Eyes; underwater"] = "Yeux de batteur ; sous l'eau",

	-- Step 9: Bears and the Blackwood camp
	["Bears and the Blackwood camp"] = "Les ours et le camp Noirbois",
	-- {area:442} Auberdine · {quest:2139} Tharnariun's Hope
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	-- was: ["Rabid Thistle Bears roam the hills south of {area:442}: use {item:7586} on one to capture it. Then walk up to the furbolg camp just east of them: nothing to kill yet."] = "Des Ours des chardons enragés parcourent les collines au sud d'{area:442} : utilisez {item:7586} sur l'un d'eux pour le capturer. Montez ensuite jusqu'au camp de furbolgs juste à l'est : rien à tuer pour l'instant."
	["Rabid Thistle Bears roam the hills south of {area:442}: use {quest:2139} on one to capture it. Then walk up to the furbolg camp just east of them: nothing to kill yet."] = "",
	-- {npc:3701} Tharnariun Treetender
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["the Rabid Thistle Bears nearest {npc:3701}"] = "les Ours des chardons enragés les plus proches de {npc:3701}",

	-- Step 10: Ameth'Aran
	-- {npc:3639} Sentinel Tysha Moonblade · {npc:2178} Wailing Highborne · {npc:3667} Anaya Dawnrunner · {npc:270196} Jai'vhanel · {quest:4722} Beached Sea Turtle
	["{npc:3639} stands at the north edge of the ruins. Cursed, Writhing and {npc:2178} haunt them; {npc:3667}'s ghost walks among them, {npc:270196} the owl circles east of them. The two tablets lie in the ruins; a {quest:4722} lies on the shore west of them."] = "{npc:3639} se tient à la lisière nord des ruines. Des Bien-nés maudits, des Bien-nés frémissants et des {npc:2178} les hantent ; le fantôme d'{npc:3667} erre parmi eux, la chouette {npc:270196} tournoie à l'est. Les deux tablettes se trouvent dans les ruines ; une {quest:4722} gît sur la côte à l'ouest.",
	-- plural, as words: Highborne Relics = {item:5360} Highborne Relic
	["Highborne Relics"] = "Reliques de bien-Né",
	-- {object:17188} Lay of Ameth'Aran
	["Read the {object:17188}"] = "Lisez {object:17188}",
	-- {object:17189} Fall of Ameth'Aran
	["Read the {object:17189}"] = "Lisez {object:17189}",

	-- Step 11: The red crystal
	["The red crystal"] = "Le cristal rouge",
	-- {area:447} Ameth'Aran · {object:175524} Mysterious Red Crystal
	["Climb the eastern mountains east of {area:447}; the {object:175524} sits on a ledge."] = "Escaladez les montagnes à l'est d'{area:447} ; le {object:175524} repose sur une corniche.",

	-- Step 12: Bashal'Aran
	-- {npc:3650} Asterion · {quest:954} Bashal'Aran · {quest:1001} Buzzbox 411 · {quest:4723} Beached Sea Creature
	-- plural, as words: Wild Grells = {npc:2190} Wild Grell · Vile Sprites = {npc:2189} Vile Sprite · Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	-- was: ["North along the hills. {npc:3650} waits in the ruins of {quest:954}; Wild Grells and Vile Sprites fill them, Deth'ryll Satyrs the eastern edge. {object:17183} stands by the road west of the ruins; a {quest:4723} lies on the shore on the way to him."] = "Vers le nord, le long des collines. {npc:3650} attend dans les ruines de {quest:954} ; des Grells sauvages et des Fées viles les remplissent, des Satyres Deth'ryll en occupent le bord est. {object:17183} se dresse au bord de la route à l'ouest des ruines ; une {quest:4723} repose sur le rivage en chemin vers lui."
	["North along the hills. {npc:3650} waits in the ruins of {quest:954}; Wild Grells and Vile Sprites fill them, Deth'ryll Satyrs the eastern edge. {quest:1001} stands by the road north-north-west of {npc:3650}; a {quest:4723} lies on the shore on the way to him."] = "",
	-- plural, as words: Grell Earrings = {item:5336} Grell Earring
	["Grell Earrings"] = "Boucles d'oreille de grell",
	-- {item:5338} Ancient Moonstone Seal
	-- plural, as words: Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["{item:5338}: Deth'ryll Satyrs"] = "{item:5338} : Satyres Deth'ryll",

	-- Step 13: Buzzbox 411
	-- {quest:4723} Beached Sea Creature · {quest:1001} Buzzbox 411 · {area:442} Auberdine
	-- plural, as words: Moonstalker Fangs = {item:5413} Moonstalker Fang
	["North-north-west of Asterion by the road, past the {quest:4723}: {quest:1001} wants Moonstalker Fangs next, from the second loop's hills. Then south-west down to {area:442}."] = "",

	-- Step 14: Auberdine
	-- {npc:3693} Terenthis · {npc:3649} Thundris Windweaver
	["{npc:3693}: for {npc:3649}, at the north end of the village"] = "",
	-- {npc:6301} Gorbold Steelhand · {zone:1439} Darkshore
	["{npc:6301}, on the way north: the bay wrecks, on your next {zone:1439} visit"] = "",

	-- Step 15: Auberdine
	-- {npc:3701} Tharnariun Treetender
	["{npc:3701}: the bears are on the loop ahead"] = "",
	-- {npc:3649} Thundris Windweaver · {area:445} Cliffspring Falls
	["{npc:3649}: his sample comes from the {area:445}, at the end of the next loop"] = "",
	["Fill the tube at the moonwell in the village"] = "Remplissez le tube au puits de lune du village",

	-- Step 16: Cerellean Whiteclaw
	-- {npc:3644} Cerellean Whiteclaw · {npc:3667} Anaya Dawnrunner · {area:447} Ameth'Aran · {zone:1439} Darkshore
	["{npc:3644} waits where the pier meets the shore. {npc:3667} (16), whose pendant he wants, walks {area:447} on the loop ahead: from level 14.5 you take it there, else on your next {zone:1439} visit."] = "",
	-- {npc:3644} Cerellean Whiteclaw
	["{npc:3644}, on the pier"] = "{npc:3644}, sur la jetée",

	-- Step 17: Rabid Thistle Bear on the way
	-- {npc:2164} Rabid Thistle Bear
	["{npc:2164} on the way"] = "{npc:2164} en chemin",

	-- Step 18: Moonstalkers on the way
	["Moonstalkers on the way"] = "",
	-- {area:442} Auberdine · {area:456} Cliffspring River
	-- plural, as words: Moonstalker Sires = {npc:2237} Moonstalker Sire
	["The Moonstalkers (14-15) roam the hills of the loop ahead, south of {area:442} and around the {area:456} at its end: any of them drops the fangs. Leave the Moonstalker Sires (17-18) and Matriarchs (19-20) south of the Grove."] = "",
	-- plural, as words: Moonstalker Fangs = {item:5413} Moonstalker Fang
	["Moonstalker Fangs"] = "Crocs de traquelune",

	-- Step 19: Blackwood furbolgs
	["Blackwood furbolgs"] = "Les furbolgs Noirbois",
	-- {area:442} Auberdine
	-- plural, as words: Blackwood Pathfinders = {npc:2167} Blackwood Pathfinder · Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	-- was: ["Blackwood Pathfinders and Windtalkers hold the camp south-east of {area:442}.\nCareful: the Windtalkers (13-14) cast from range and the furbolgs stand in pairs: pull them one at a time."] = "Les Guides Noirbois et les Parlevents occupent le camp au sud-est d'{area:442}.\nAttention : les Parlevents (13-14) lancent des sorts à distance et les furbolgs se tiennent par deux : attirez-les un par un."
	["Blackwood Pathfinders and Windtalkers hold the camp south-east of {area:442}; Rabid Thistle Bears roam the hills around it.\nCareful: the Windtalkers (13-14) cast from range and the furbolgs stand in pairs: pull them one at a time."] = "",

	-- Step 20: The southern beaches
	["The southern beaches"] = "Les plages du sud",
	-- {area:447} Ameth'Aran · {quest:4728} Beached Sea Creature · {area:450} Remtravel's Excavation
	-- plural, as words: Greymist Oracles = {npc:2207} Greymist Oracle
	["Follow the coast south past {area:447}: one {quest:4728} lies on the shore west of the Grove, another further south near {area:450}. Three more remains lie further south-west among Greymist Oracles and Tidehunters (18-20): the guide leaves them for the last loop, when you are closer to their level."] = "Suivez la côte vers le sud au-delà d'{area:447} : une {quest:4728} gît sur la côte à l'ouest du Bosquet des Anciens, une autre plus au sud près de l'{area:450}. Trois autres restes gisent plus au sud-ouest parmi les Oracles Grisebrume et les Chasse-marée Grisebrume (18-20) : le guide les garde pour la dernière boucle, quand vous serez plus proche de leur niveau.",

	-- Step 21: Onu
	-- {quest:952} Grove of the Ancients · {npc:3616} Onu · {npc:11218} Kerlonian Evershade
	-- plural, as words: Moonstalker Sires = {npc:2237} Moonstalker Sire
	["From the beached creature, head east to the {quest:952}. Watch for level 16 bears and level 17 Moonstalker Sires between the beach and the grove; go around them. {npc:3616} stands beside Arbal and the sleeping {npc:11218}."] = "",

	-- Step 22: Ameth'Aran
	-- {area:447} Ameth'Aran
	["Back north to {area:447}: the flame burns in the south of the ruins."] = "Retournez au nord jusqu'à {area:447} : la flamme brûle au sud des ruines.",

	-- Step 23: Anaya's Pendant
	-- {npc:3667} Anaya Dawnrunner · {npc:2184} Lady Moongazer
	["Careful: {npc:3667} (16) is over you: pull her on her own at full health. {npc:2184}, a rare (17), also walks the ruins: leave her be."] = "",
	-- {item:5382} Anaya's Pendant · {npc:3667} Anaya Dawnrunner
	["{item:5382}: {npc:3667}'s ghost walks the ruins"] = "",

	-- Step 24: The red crystal
	["Back north-east into the mountains to the crystal."] = "Retournez au nord-est dans les montagnes jusqu'au cristal.",

	-- Step 26: Bashal'Aran
	-- {npc:3650} Asterion · {area:456} Cliffspring River
	["North along the hills to {npc:3650}, then on north-east to the {area:456}."] = "",

	-- Step 27: Cliffspring Falls
	-- {area:456} Cliffspring River · {npc:6788} Den Mother
	-- plural, as words: Encrusted Tide Crawlers = {npc:2233} Encrusted Tide Crawler
	["North-east up the {area:456} to the falls: fill the sampler at the water there. Moonstalkers (14-15) roam the hills around the river.\nCareful: Encrusted Tide Crawlers (17-20) line the shore below the falls and the {npc:6788}'s bears (18-19) lair in the hills south of them: keep to the river."] = "",
	-- {item:12349} Cliffspring River Sample
	["{item:12349}, at the waterfall"] = "{item:12349}, à la cascade",

	-- Step 28: Buzzbox 323
	-- {quest:1002} Buzzbox 323 · {object:17185} Buzzbox 525 · {zone:1439} Darkshore
	["{quest:1002} stands on the hill above the falls. He offers {object:17185} next: its bears are far south, for your next {zone:1439} visit."] = "",
	-- plural, as words: Moonstalker Fangs = {item:5413} Moonstalker Fang
	["Moonstalker Fangs: the Moonstalkers around the river"] = "",

	-- Step 29: Beached Sea Turtle
	-- {quest:4725} Beached Sea Turtle · {quest:954} Bashal'Aran · {area:442} Auberdine
	-- plural, as words: Reef Crawlers = {npc:2235} Reef Crawler · Greymist Warriors = {npc:2205} Greymist Warrior
	["West along the north shore: the {quest:4725} lies on the beach north of {quest:954}, among Reef Crawlers and Greymist Warriors (15). Then south-west down to {area:442}."] = "",

	-- Step 30: Auberdine
	-- {npc:3657} Sentinel Elissa Starbreeze · {npc:3693} Terenthis · {area:444} Tower of Althalaxx · {zone:1439} Darkshore
	["{npc:3657}, beside {npc:3693}: for Balthule at the {area:444}, on your next {zone:1439} visit"] = "",
	-- {npc:3701} Tharnariun Treetender · {npc:6788} Den Mother · {zone:1439} Darkshore
	["{npc:3701}: the {npc:6788}, on your next {zone:1439} visit"] = "",
	-- {npc:3583} Barithras Moonshade · {area:445} Cliffspring Falls · {zone:1439} Darkshore
	["{npc:3583}: the cave by the {area:445}, on your next {zone:1439} visit"] = "",
	-- {npc:3649} Thundris Windweaver · {npc:1646} Baros Alexston · {zone:1453} Stormwind
	["{npc:3649}: for {npc:1646} in {zone:1453}, on the walk from the boat"] = "",

	-- Step 31: Thundris Windweaver
	-- {npc:3649} Thundris Windweaver · {quest:4763} The Blackwood Corrupted · {zone:1439} Darkshore
	["From level 15 {npc:3649} also has {quest:4763}: its samples come from the northern Blackwood camp on your next {zone:1439} visit. Fill its bowl at the moonwell in the middle of the village now."] = "",
	-- {item:12347} Filled Cleansing Bowl · {item:12346} Empty Cleansing Bowl · {object:174795} Auberdine Moonwell
	["{item:12347}: fill the {item:12346} at the {object:174795}"] = "{item:12347} : remplissez le {item:12346} au {object:174795}",

	-- Step 32: Cerellean Whiteclaw
	-- {npc:3644} Cerellean Whiteclaw
	-- was: ["{npc:3644}, where the pier meets the shore, on the way to the boat"] = "{npc:3644}, là où la jetée rejoint le rivage, sur le chemin du bateau"
	["{npc:3644} waits where the pier meets the shore, on the way to the boat."] = "",

	-- Step 33: Boat to Stormwind Harbor
	-- {area:17203} Stormwind Harbor
	["Boat to {area:17203}"] = "Bateau pour {area:17203}",

	-- Step 34: Manifest Clerk Philmor
	-- {npc:268511} Manifest Clerk Philmor · {npc:483} Elaine Trias · {object:2096} Trade District
	["Off the boat, {npc:268511} stands on the harbor: his shipment goes to {npc:483}' cheese shop in the {object:2096}, beside the flight master."] = "En descendant du bateau, {npc:268511} se tient sur le port : sa cargaison va à la fromagerie de {npc:483}, dans {object:2096}, à côté du maître de vol.",

	-- Step 35: Stormwind flight master
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Maître de vol de {zone:1453}",
	-- {npc:483} Elaine Trias
	["{npc:483}, in her cheese shop"] = "{npc:483}, dans sa fromagerie",
	-- {object:460004} Gatehouse Door (no name in this language: may be words)
	["Up the stairs in her shop: leave the shipment at the {object:460004}"] = "Montez l'escalier de sa boutique : déposez la cargaison à {object:460004}",

	-- Step 36: Baros Alexston
	-- {npc:1646} Baros Alexston · {object:2098} Cathedral Square · {object:2096} Trade District · {zone:1436} Westfall · {npc:3649} Thundris Windweaver · {area:442} Auberdine
	-- was: ["{npc:1646} stands in {object:2098}, west of the {object:2096}: his compass is in his old house in {zone:1436}, on the way."] = "{npc:1646} se tient sur {object:2098}, à l'ouest de {object:2096} : sa boussole est dans son ancienne maison en {zone:1436}, sur le chemin."
	["{npc:1646} stands in {object:2098}, west of the {object:2096}: his compass is in his old house in {zone:1436}, on the way. His reply to {npc:3649} goes back to {area:442} with you."] = "",
	-- {npc:1646} Baros Alexston · {npc:3649} Thundris Windweaver
	["{npc:1646}: {npc:3649}'s letter"] = "",
	-- {npc:1646} Baros Alexston · {quest:97926} Making Do · {npc:3649} Thundris Windweaver · {zone:1439} Darkshore
	["{npc:1646}: {quest:97926}, for {npc:3649} on your next {zone:1439} visit"] = "",

	-- Step 37: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "Pendant que vous y êtes : apprenez {spell:202} auprès de {npc:11867} ({object:2096}, 10 pièces d'argent) ; les armes à deux mains font progresser un Guerrier le plus vite.",

	-- Step 38: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Swords from {npc:11867} ({object:2096}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "Pendant que vous y êtes : apprenez le maniement des épées auprès de {npc:11867} ({object:2096}, 10 pièces d'argent) ; une épée en main droite fait progresser un Voleur régulièrement.",

	-- Step 39: Druid trainer
	["Druid trainer"] = "Maître des druides",
	-- {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {area:87} Goldshire
	["{npc:5504} in {zone:1453}; {area:87} has no druid trainer"] = "{npc:5504} dans {zone:1453} ; {area:87} n'a pas de maître des druides",

	-- Step 41: Class trainer
	["Class trainer"] = "Maître de classe",

	-- Step 42: Shaman trainer
	["Shaman trainer"] = "Maître des chamans",
	-- {npc:257446} Teo Hammerstorm · {zone:1426} Dun Morogh · {area:87} Goldshire
	["{npc:257446} in {zone:1426}; {area:87} has no shaman trainer"] = "{npc:257446} à {zone:1426} ; {area:87} n'a pas de maître des chamans",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back south"] = "Retour au sud",
	-- ["Blackwood Pathfinders and Windtalkers hold the camp south-east of {area:442}."] = "Des Guides Noirbois et des Messagers du Vent Noirbois tiennent le camp au sud-est d'{area:442}.",
	-- ["Blackwood Pathfinders and Windtalkers hold the camp south-east of {area:442}.\nCareful: the Windtalkers (13-14) cast from range and the furbolgs stand in pairs: pull them one at a time."] = "Les Guides Noirbois et les Parlevents occupent le camp au sud-est d'{area:442}.\nAttention : les Parlevents (13-14) lancent des sorts à distance et les furbolgs se tiennent par deux : attirez-les un par un.",
	-- ["Follow the coast north-east to the {area:443}. Mathystra Relics lie among the ruins; Stormscale Myrmidons, Sorceresses and Warriors hold them, and Stormscale Beastmistresses walk the shore."] = "Suivez la côte vers le nord-est jusqu'aux {area:443}. Des Reliques de Mathystra jonchent les ruines ; des Myrmidons, des Ensorceleuses et des Guerriers Tempécaille les gardent, et des Maîtresses des bêtes Tempécaille arpentent le rivage.",
	-- ["Follow the road north."] = "Suivez la route vers le nord.",
	-- ["Follow the road south. Onu is the ancient at the Grove; {npc:270269} and {npc:11218} sleep beside him."] = "Suivez la route vers le sud. Onu est l'ancien du Bosquet ; {npc:270269} et {npc:11218} dorment à côté de lui.",
	-- ["Hearth to {area:442}"] = "Pierre de foyer vers {area:442}",
	-- ["Hearthstone on cooldown? Follow the coast road back south."] = "Pierre de foyer en recharge ? Suivez la route côtière vers le sud.",
	-- ["Into {area:12}"] = "Vers {area:12}",
	-- ["Into {area:148}"] = "Vers {area:148}",
	-- ["North along the hills to {npc:3650}, then west down to {area:442}."] = "Vers le nord le long des collines jusqu'à {npc:3650}, puis descendez vers l'ouest jusqu'à {area:442}.",
	-- ["North along the hills. {npc:3650} waits in the ruins of {quest:954}; Wild Grells and Vile Sprites fill them, Deth'ryll Satyrs the eastern edge. {object:17183} stands by the road west of the ruins; a {quest:4723} lies on the shore on the way to him."] = "Vers le nord, le long des collines. {npc:3650} attend dans les ruines de {quest:954} ; des Grells sauvages et des Fées viles les remplissent, des Satyres Deth'ryll en occupent le bord est. {object:17183} se dresse au bord de la route à l'ouest des ruines ; une {quest:4723} repose sur le rivage en chemin vers lui.",
	-- ["Plagued bears"] = "Les ours pestiférés",
	-- ["Rabid Thistle Bears roam the hills just east of {area:442}. Use {item:7586} on one and lead it back to him."] = "Des Ours des chardons enragés parcourent les collines juste à l'est d'{area:442}. Utilisez l'{item:7586} sur l'un d'eux et ramenez-le jusqu'à lui.",
	-- ["Rabid Thistle Bears roam the hills south of {area:442}: use {item:7586} on one to capture it. Then walk up to the furbolg camp just east of them: nothing to kill yet."] = "Des Ours des chardons enragés parcourent les collines au sud d'{area:442} : utilisez {item:7586} sur l'un d'eux pour le capturer. Montez ensuite jusqu'au camp de furbolgs juste à l'est : rien à tuer pour l'instant.",
	-- ["The boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street."] = "Le bateau accoste à l'ouest du village. Le maître de vol se tient sur la colline au sud de l'auberge ; les donneurs de quêtes sont répartis le long de la rue principale.",
	-- ["The naga"] = "Les nagas",
	-- ["The {area:448}"] = "{area:448}",
	-- ["{item:5382}: {npc:3667}, level 16; pull her away from the Highborne"] = "{item:5382} : {npc:3667}, niveau 16 ; éloignez-la des Bien-nés",
	-- ["{npc:1646} stands in {object:2098}, west of the {object:2096}: his compass is in his old house in {zone:1436}, on the way."] = "{npc:1646} se tient sur {object:2098}, à l'ouest de {object:2096} : sa boussole est dans son ancienne maison en {zone:1436}, sur le chemin.",
	-- ["{npc:3644}, on the pier"] = "{npc:3644}, sur la jetée",
	-- ["{npc:3644}, where the pier meets the shore, on the way to the boat"] = "{npc:3644}, là où la jetée rejoint le rivage, sur le chemin du bateau",
}
