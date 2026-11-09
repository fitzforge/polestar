-- French (frFR): the guide forever/alliance/04-redridge-mountains (forever/alliance/04-redridge-mountains.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Stormwind
	-- {zone:1429} Elwynn Forest · {quest:174} Look to the Stars · {area:42} Darkshire · {item:4371} Bronze Tube · {npc:3133} Herble Baubbletump · {object:2096} Trade District
	["Train, then leave by the main gate and follow the road east through {zone:1429}.\n{quest:174} in {area:42} needs a {item:4371}. Its vendors keep only one or two, and {npc:3133} in {area:42} is nearly always sold out: buy one at the Auction House in the {object:2096} on your way out. An engineer can make one too."] = "",
	["Level 18 and 20 spells"] = "Sorts des niveaux 18 et 20",
	-- {item:4371} Bronze Tube · {quest:174} Look to the Stars · {area:42} Darkshire
	["{item:4371}: the Auction House, for {quest:174} in {area:42}"] = "",

	-- Step 2: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Polearms from {npc:11867} ({object:2096}, 1 gold); two-handers level a Warrior fastest."] = "Pendant que vous y êtes : apprenez le maniement des armes d'hast auprès de {npc:11867} ({object:2096}, 1 pièce d'or) ; les armes à deux mains font progresser un Guerrier le plus vite.",

	-- Step 3: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Polearms from {npc:11867} ({object:2096}, 1 gold); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "Pendant que vous y êtes : apprenez le maniement des armes d'hast auprès de {npc:11867} ({object:2096}, 1 pièce d'or) ; l'arme de mêlée d'un Chasseur vaut surtout par ses caractéristiques, et les armes à deux mains en portent le plus.",

	-- Step 4: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "Tram pour {zone:1455}",

	-- Step 5: Shaman training
	["Shaman training"] = "Entraînement de chaman",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back."] = "{zone:1453} n'a pas de maître chaman : prenez {area:2257} depuis {object:28027} jusqu'à {zone:1455}, entraînez-vous auprès de {npc:258098}, puis reprenez le tram pour revenir.",

	-- Step 6: Fly to Sentinel Hill
	-- {area:108} Sentinel Hill
	["Fly to {area:108}"] = "Prendre un vol pour {area:108}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Maître de vol de {zone:1453}",

	-- Step 7: Half Pendant of Aquatic Endurance
	-- {area:108} Sentinel Hill · {object:177790} Strange Lockbox
	["Fly to {area:108} and head north-west to the coast: the {object:177790} lies on the sea floor off the shore. Then head east along the road through Elwynn."] = "",
	-- {item:15882} Half Pendant of Aquatic Endurance · {object:177790} Strange Lockbox
	["{item:15882}: the {object:177790}"] = "{item:15882} : l'{object:177790}",

	-- Step 8: Back to Elwynn Forest
	-- {zone:1429} Elwynn Forest
	["Back to {zone:1429}"] = "Retour dans la {zone:1429}",
	-- {zone:1429} Elwynn Forest
	["The road into {zone:1429}"] = "",

	-- Step 9: Elwynn Forest
	-- {area:91} Tower of Azora
	["The {area:91}"] = "La {area:91}",

	-- Step 10: Theocritus
	["On the top floor"] = "Au dernier étage",

	-- Step 11: Henze Faulk
	-- {area:91} Tower of Azora · {area:86} Stone Cairn Lake · {npc:6172} Henze Faulk · {item:6866} Symbol of Life · {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["On the road east, past the {area:91}, head north from the bridge to {area:86}. {npc:6172} lies south of the lake: use the {item:6866} on him. The Defias Rogue Wizards around him carry the {item:6846}."] = "Sur la route vers l'est, après la {area:91}, partez vers le nord depuis le pont jusqu'au {area:86}. {npc:6172} gît au sud du lac : utilisez le {item:6866} sur lui. Les Sorciers-voleurs défias autour de lui portent le {item:6846}.",
	-- {item:6866} Symbol of Life · {npc:6172} Henze Faulk
	["Use the {item:6866} on {npc:6172}"] = "Utilisez le {item:6866} sur {npc:6172}",
	-- {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["{item:6846}: Defias Rogue Wizards"] = "{item:6846} : Sorciers-voleurs défias",

	-- Step 12: Three Corners
	-- {area:1002} Three Corners · {zone:1431} Duskwood
	["The road east through Elwynn crosses into Redridge at {area:1002}, where the roads to Redridge, {zone:1431} and Elwynn meet: south to {zone:1431} first."] = "",

	-- Step 14: Darkshire
	-- {area:1002} Three Corners · {zone:1431} Duskwood · {area:42} Darkshire · {item:4371} Bronze Tube · {quest:174} Look to the Stars · {npc:3133} Herble Baubbletump · {npc:276} Viktori Prism'Antras
	["Follow the road south from {area:1002} into {zone:1431}; {area:42} lies on the east side of the forest.\nNo {item:4371} for {quest:174}? {npc:3133}, in the house beside {npc:276}, keeps only one and is usually sold out. Without one, right-click the quest in the guide window and skip it.\n{npc:276}'s house stands at the east end of town. {npc:3133} sells engineering goods in the house beside it."] = "",
	-- {npc:2409} Felicia Maline
	["{npc:2409}, at the north end of town"] = "{npc:2409}, à l'extrémité nord de la ville",
	-- {npc:265} Madame Eva
	["{npc:265}, in her house by the tavern; inside"] = "{npc:265}, dans sa maison près de la taverne ; à l'intérieur",
	-- {npc:265} Madame Eva
	["{npc:265}, inside"] = "{npc:265}, à l'intérieur",
	-- {npc:6790} Innkeeper Trelayne
	["{npc:6790}, Scarlet Raven Tavern"] = "{npc:6790}, taverne du Corbeau écarlate",
	-- {npc:267} Clerk Daltry
	["{npc:267}, in the town hall"] = "{npc:267}, à l'hôtel de ville",
	-- {npc:264} Commander Althea Ebonlocke
	["{npc:264}, in the town hall"] = "{npc:264}, à l'hôtel de ville",
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, in the house behind the town hall"] = "{npc:268}, dans la maison derrière l'hôtel de ville",
	-- {npc:633} Elaine Carevin
	["{npc:633}, at the south end of town; inside"] = "{npc:633}, au sud de la ville ; à l'intérieur",
	-- {npc:633} Elaine Carevin · {npc:288} Jitters · {quest:163} Raven Hill
	["{npc:633}: {npc:288}, at {quest:163}"] = "",
	-- {item:4371} Bronze Tube · {npc:3133} Herble Baubbletump
	["{item:4371}, from {npc:3133}, if you have none"] = "{item:4371}, chez {npc:3133}, si vous n'en avez pas",
	-- {npc:276} Viktori Prism'Antras
	["{npc:276}, inside"] = "{npc:276}, à l'intérieur",
	-- {npc:302} Blind Mary
	["For {npc:302}, on the hill south-east of town"] = "",

	-- Step 15: Tranquil Gardens Cemetery: kill these as you meet them
	-- {area:121} Tranquil Gardens Cemetery
	["{area:121}: kill these as you meet them"] = "{area:121} : tuez-les au passage",
	-- {area:42} Darkshire · {npc:302} Blind Mary · {zone:1431} Duskwood · {item:2378} Skeleton Finger
	-- plural, as words: Skeletal Warriors = {npc:48} Skeletal Warrior · Skeletal Mages = {npc:203} Skeletal Mage
	["Skeletal Warriors and Skeletal Mages walk among the graves south-east of {area:42}, below {npc:302}'s house on the hill. Every skeleton in {zone:1431} can drop a {item:2378}.\nCareful: Because the skeletons stand near each other, running straight in tends to pull several at once."] = "Des Guerriers squelettes et des Mages squelettes errent parmi les tombes au sud-est de {area:42}, en contrebas de la maison de {npc:302} sur la colline. Tous les squelettes du {zone:1431} peuvent lâcher un {item:2378}.\nAttention : les squelettes se tiennent près les uns des autres : foncer dans le tas en attire souvent plusieurs à la fois.",

	-- Step 16: Watcher Dodds
	-- {npc:888} Watcher Dodds · {area:245} Yorgen Farmstead
	["{npc:888} stands south of the road, at the {area:245}."] = "{npc:888} se tient au sud de la route, à {area:245}.",

	-- Step 17: Raven Hill
	-- {quest:163} Raven Hill · {object:673515} Memory of Valor · {npc:288} Jitters
	["Continue west to {quest:163}. The {object:673515} glows by the ruined house south of the road; {npc:288} hides in the house at the west end of the village."] = "",
	-- {item:281046} Raven Hill Tome · {object:673515} Memory of Valor
	["{item:281046}, from the {object:673515}"] = "{item:281046}, sur le {object:673515}",
	-- {npc:272} Chef Grual · {area:42} Darkshire
	["for {npc:272} in {area:42}"] = "",

	-- Step 18: Sven's Camp
	-- {npc:311} Sven Yorgen · {npc:893} Lars
	["Follow the road north-west past the cemetery to {npc:311}'s camp on the far west edge of the forest. {npc:893} stands beside {npc:311}."] = "Suivez la route vers le nord-ouest après le cimetière jusqu'au camp de {npc:311}, à l'extrême ouest de la forêt. {npc:893} se tient à côté de {npc:311}.",

	-- Step 19: The Hushed Bank: kill these as you meet them
	-- {area:1097} The Hushed Bank
	["{area:1097}: kill these as you meet them"] = "{area:1097} : tuez-les au passage",
	-- {npc:289} Abercrombie · {area:1097} The Hushed Bank · {quest:163} Raven Hill · {npc:311} Sven Yorgen · {zone:1436} Westfall
	-- plural, as words: Pygmy Venom Web Spiders = {npc:539} Pygmy Venom Web Spider
	["Rabid Dire Wolves roam the woods around the cemetery and {npc:289}, Starving Dire Wolves the hills north-east of him. Pygmy Venom Web Spiders are the small spiders, and few: most crawl along the {area:1097} west of {quest:163}, fewer up north towards {npc:311}'s camp; they drop the venom too. Every ghoul of the cemetery's northern half can drop a fang. Wolves and the bigger spiders share the {zone:1436} border, so pull with care."] = "",
	-- {item:1130} Vial of Spider Venom
	-- plural, as words: Pygmy Venom Web Spiders = {npc:539} Pygmy Venom Web Spider · Venom Web Spiders = {npc:217} Venom Web Spider · Green Recluses = {npc:569} Green Recluse
	["{item:1130}: Pygmy Venom Web Spiders, Venom Web Spiders and Green Recluses"] = "",

	-- Step 20: Abercrombie
	-- {area:492} Raven Hill Cemetery
	["The hermit's shack stands in the woods north-east of the {area:492}."] = "La cabane de l'ermite se trouve dans les bois au nord-est de {area:492}.",

	-- Step 21: Raven Hill Cemetery: kill these as you meet them
	-- {area:492} Raven Hill Cemetery
	["{area:492}: kill these as you meet them"] = "{area:492} : tuez-les au passage",
	-- {npc:522} Mor'Ladim
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Skeletal Fiends = {npc:531} Skeletal Fiend
	["The cemetery lies north of the village. Skeletal Horrors and Skeletal Fiends walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "Le cimetière se trouve au nord du village. Les Squelettes infernaux et les Démons squelettes errent dans sa moitié sud. {npc:522}, un élite, rôde parmi les tombes : tenez-vous à l'écart.",

	-- Step 22: Watcher Dodds
	-- {area:245} Yorgen Farmstead
	["Head back east along the road to the {area:245}."] = "Retournez vers l'est par la route jusqu'à {area:245}.",

	-- Step 23: Yorgen Farmstead
	["The mound of loose dirt lies south of the farmhouse, by the old stump."] = "Le monticule de poussière se trouve au sud de la ferme, près de la vieille souche.",

	-- Step 24: Darkshire
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, inside"] = "{npc:268}, à l'intérieur",
	-- {npc:272} Chef Grual
	["{npc:272}, in the Scarlet Raven Tavern"] = "",
	-- {npc:663} Calor
	["{npc:663}, by the town hall"] = "{npc:663}, près de l'hôtel de ville",

	-- Step 26: Redridge Mountains
	-- {area:42} Darkshire · {area:1002} Three Corners
	["Back north along the road from {area:42} to {area:1002}."] = "",

	-- Step 27: Lakeridge Highway
	-- {area:68} Lake Everstill · {npc:903} Guard Howe
	["Follow the road along the south shore of {area:68} to the gryphon master. {npc:903} stands by the road next to her."] = "",

	-- Step 28: Lake Everstill's murlocs: kill these as you meet them
	-- {area:68} Lake Everstill
	["{area:68}'s murlocs: kill these as you meet them"] = "",
	-- {area:68} Lake Everstill
	-- plural, as words: Murloc Flesheaters = {npc:422} Murloc Flesheater
	["Murloc Flesheaters and Tidecallers line the south shore of {area:68}, just east of the gryphons and the bridge. Any of them can carry a fin."] = "",

	-- Step 29: Lakeshire
	-- {npc:381} Dockmaster Baren · {npc:900} Bailiff Conacher · {npc:342} Martie Jainrose · {npc:382} Marshal Marris · {quest:98386} Alther's Mill
	["Cross the long bridge north into town: {npc:381} on the docks, {npc:900} in the town hall, the innkeeper in the inn, {npc:342} in her garden at the west end. {npc:382}'s Blackrock quests and {quest:98386} came with you from your first Redridge visit."] = "",
	-- {npc:900} Bailiff Conacher
	["{npc:900}, in the town hall"] = "",
	["The Wanted poster by the inn"] = "L'avis de recherche près de l'auberge",

	-- Step 30: Bellygrub
	-- {npc:345} Bellygrub · {area:69} Lakeshire · {npc:342} Martie Jainrose
	["{npc:345} (level 24) roots around the pen just west of {area:69}, beside {npc:342}'s garden. Pull him away from the other boars and fight at full health."] = "",

	-- Step 31: Martie Jainrose
	-- {npc:342} Martie Jainrose
	["{npc:342}'s garden is at the west end of town."] = "",

	-- Step 32: Lakeshire
	-- {npc:342} Martie Jainrose
	["Back east through town from {npc:342}'s garden: two Wanted posters hang on the town hall doorway."] = "",
	["The Wanted poster on the town hall doorway"] = "",
	["The Wanted poster beside it"] = "",

	-- Step 33: Alther's Mill
	-- {quest:98386} Alther's Mill
	-- plural, as words: Greater Tarantulas = {npc:505} Greater Tarantula · Tarantula Eggs = {object:673101} Tarantula Egg
	["Greater Tarantulas crawl on the slopes around {quest:98386}, north-east of the lake; their Tarantula Eggs lie on the ground among them: click six."] = "",

	-- Step 34: Blackrock camps
	["Blackrock camps"] = "Camps Blackrock",
	-- {area:1000} Galardell Valley · {area:2099} Stonewatch Keep
	["South-east from the mill, west of {area:1000}'s gnolls, to the Blackrock camps east of {area:2099}. Renegades, Grunts and Outrunners fill them; keep east of the keep, whose orcs are elite. Weapon racks and swords lie about the camps; meat haunches, grain sacks and water barrels hold the supplies."] = "",
	-- {item:280841} Stolen Weapon
	["{item:280841}: weapon racks and swords on the ground"] = "",
	-- {item:280839} Blackrock Supplies
	["{item:280839}: meat haunches, grain sacks, water barrels"] = "",

	-- Step 35: Incinerator Gar'im
	["Gar'im keeps to the cave at the camps' south end with his imp and two orcs. Elite: group up if you can; solo, pull the orcs at the mouth first and interrupt his fire cast."] = "",

	-- Step 36: Galardell Valley
	-- {npc:703} Lieutenant Fangore · {area:2099} Stonewatch Keep
	["North up the valley's east side. Shadowhide gnolls fill it; {npc:703} (26) and his two guards stand at its north end: clear the gnolls around him first and fight at full health. Stay out of {area:2099} to the west until the watch tower: its orcs are elite."] = "",
	-- {item:1075} Shadowhide Pendant
	["{item:1075}: any Shadowhide gnoll"] = "{item:1075} : tout gnoll Sombrepoil",

	-- Step 37: A Watchful Eye
	-- {object:31} Old Lion Statue
	["The {object:31} stands at the valley's east edge."] = "",

	-- Step 38: Looking Further
	-- {area:2099} Stonewatch Keep
	["West to the intact watch tower beside {area:2099}: climb it and leave the Glyph in the empty jar at the top."] = "",

	-- Step 39: Stonewatch Keep
	-- {npc:334} Gath'Ilzogg
	-- plural, as words: Blackrock Shadowcasters = {npc:436} Blackrock Shadowcaster
	["The keep stands beside the tower. {npc:334} (elite) waits in the keep's top room with two guards and a dragon; Blackrock Shadowcasters (elite) and Sentries stand on its west side, so pull one at a time on the way in, and hug the right wall as you enter his room so you don't pull him at once. Elite: group up if you can."] = "",

	-- Step 40: Render's Valley
	-- {area:95} Redridge Canyons · {area:997} Render's Valley · {area:69} Lakeshire
	-- plural, as words: Blackrock Champions = {npc:435} Blackrock Champion
	["From the keep head back west along the lake's north shore and north up the {area:95} to {area:997}; {area:69}'s hand-ins wait for Keeshan's escort, which ends there. Blackrock Champions camp in the valley."] = "",
	-- {npc:435} Blackrock Champion
	["{npc:435}, below ground"] = "{npc:435}, sous terre",

	-- Step 41: Corporal Keeshan
	-- {zone:1428} Burning Steppes · {area:69} Lakeshire
	["Keeshan hides at the very north end of the valley, by the {zone:1428} border. Escort him down to {area:69}; Blackrock orcs ambush you on the way."] = "Keeshan se cache tout au nord de la vallée, près de la frontière de {zone:1428}. Escortez-le jusqu'à {area:69} ; des orcs Blackrock vous tendent des embuscades en chemin.",
	-- {npc:349} Corporal Keeshan
	["{npc:349}, below ground"] = "{npc:349}, sous terre",

	-- Step 42: Magistrate Solomon: Gath'Ilzogg
	-- {npc:344} Magistrate Solomon
	["{npc:344}, in the town hall"] = "{npc:344}, dans l'hôtel de ville",

	-- Step 44: Back to Lakeshire
	-- {area:69} Lakeshire
	["Back to {area:69}"] = "Retour à {area:69}",
	-- {area:69} Lakeshire · {npc:900} Bailiff Conacher · {npc:344} Magistrate Solomon · {npc:382} Marshal Marris · {npc:341} Foreman Oslow · {npc:903} Guard Howe
	["Into {area:69} from the north with Keeshan: {npc:900} and {npc:344} in the town hall, {npc:382} and {npc:341} at the north end of the bridge, then over the bridge to {npc:903} and the gryphons."] = "",
	-- {npc:903} Guard Howe
	["{npc:903}, by the gryphons south of the bridge"] = "{npc:903}, près des griffons au sud du pont",
	-- {area:42} Darkshire · {zone:1431} Duskwood
	["Next: the gryphon to {area:42} for {zone:1431}'s second loop (05-duskwood)."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Bellygrub"] = "Fouailleventre",
	-- ["Boat to {area:17203}"] = "Bateau pour {area:17203}",
	-- ["Cross the long bridge north into town. {npc:341} and {npc:382} stand at the north end of the bridge, {npc:900} in the town hall, {npc:381} and {npc:266} on the docks, {npc:343} at the inn, {npc:342} in her garden at the west end."] = "Traversez le long pont vers le nord jusqu'à la ville. {npc:341} et {npc:382} se tiennent au bout nord du pont, {npc:900} dans l'hôtel de ville, {npc:381} et {npc:266} sur les quais, {npc:343} à l'auberge, {npc:342} dans son jardin, à l'ouest.",
	-- ["East past the mill and across the river. Shadowhide gnolls fill the valley; {npc:703} (26, well above you) leads them at its north end: clear his escort first and fight him at full health. Stay out of {area:2099} to the south: its orcs are elite."] = "À l'est, au-delà du moulin et de la rivière. Les gnolls Sombrepoil remplissent la vallée ; {npc:703} (26, bien au-dessus de vous) les mène à son extrémité nord : éliminez d'abord son escorte et combattez-le en pleine santé. Évitez {area:2099} au sud : ses orcs sont élites.",
	-- ["East past the mill and across the river. Shadowhide gnolls fill the valley; {npc:703} (26, well above you) leads them at its north end: clear his escort first and fight him at full health. Stay out of {area:2099} to the south: its orcs are elite.\nCareful: Two gnoll guards stay with him and join the fight whenever he is attacked, even if he has wandered a short way off; other gnolls stand close by and wander through the area."] = "À l'est, après le moulin, de l'autre côté de la rivière. Les gnolls Sombrepoil remplissent la vallée ; {npc:703} (niveau 26, bien au-dessus de vous) les mène à son extrémité nord : éliminez d'abord son escorte et combattez-le avec toute votre vie. Évitez {area:2099} au sud : ses orcs sont des élites.\nAttention : deux gardes gnolls restent avec lui et se joignent au combat dès qu'il est attaqué, même s'il s'est un peu éloigné ; d'autres gnolls se tiennent tout près et errent dans le secteur.",
	-- ["Fly to {area:108} and head north-west to the coast: the {object:177790} lies on the sea floor off the shore. Then head east along the road through Elwynn to Redridge."] = "Prenez un vol pour {area:108} et allez au nord-ouest jusqu'à la côte : le {object:177790} repose au fond de la mer, au large. Suivez ensuite la route vers l'est à travers la forêt d'Elwynn jusqu'aux Carmines.",
	-- ["Fly to {area:108} and ride north-west to the coast: the {object:177790} lies on the sea floor off the shore. Then ride east along the road through Elwynn to Redridge."] = "Prenez un vol pour {area:108} et allez au nord-ouest jusqu'à la côte : l'{object:177790} repose au fond de la mer, au large. Suivez ensuite la route vers l'est à travers la forêt d'Elwynn jusqu'aux Carmines.",
	-- ["Follow the road along the south shore of {area:68} to the gryphon master. {npc:1070} and {npc:903} stand by the road next to her."] = "Suivez la route le long de la rive sud de {area:68} jusqu'à la maîtresse des griffons. {npc:1070} et {npc:903} se tiennent au bord de la route, près d'elle.",
	-- ["For {npc:3649}, on the return to {area:442} (06-ashenvale)"] = "Pour {npc:3649}, au retour à {area:442} (06-ashenvale)",
	-- ["Gnolls toward {area:1002}"] = "Gnolls vers {area:1002}",
	-- ["Greater Tarantulas crawl on the slopes around the mill north-east of the lake; Blackrock Renegades hold the mill itself."] = "Des Grandes tarentules rampent sur les pentes autour du moulin, au nord-est du lac ; des Renégats Blackrock occupent le moulin.",
	-- ["Head north out of {area:69} up the {area:95} to {area:997}. Blackrock Champions camp in the valley."] = "Allez au nord hors de {area:69} par {area:95} jusqu'à {area:997}. Des Champions Blackrock campent dans la vallée.",
	-- ["Hearth to {area:69}"] = "Pierre de foyer vers {area:69}",
	-- ["Inside"] = "À l'intérieur",
	-- ["Lake murlocs"] = "Murlocs du lac",
	-- ["Murloc Flesheaters and Tidecallers line the south shore east of the bridge. Any of them can carry a {item:1467} or a fin."] = "Des Dévoreurs murlocs et des Maîtres des flots murlocs bordent la rive sud à l'est du pont. Chacun peut porter un {item:1467} ou une nageoire.",
	-- ["Murloc Flesheaters and Tidecallers line the south shore east of the bridge. Any of them can carry a {item:1467} or a fin.\nGreater Tarantulas crawl on the slopes around the mill north-east of the lake."] = "Des Dévoreurs murlocs et des Mande-flots murlocs bordent la rive sud à l'est du pont. N'importe lequel peut porter un {item:1467} ou une nageoire.\nDes Grandes tarentules rampent sur les pentes autour du moulin au nord-est du lac.",
	-- ["On the top floor"] = "Au dernier étage",
	-- ["Only once {quest:97914} is handed in: for {npc:3649}, back in {area:442} (06-ashenvale)"] = "Seulement une fois {quest:97914} rendue : pour {npc:3649}, de retour à {area:442} (06-ashenvale)",
	-- ["Redridge Mongrels and other gnolls hold the hills east of {area:1002}, north of the road; Redridge Thrashers prowl among them, Poachers camp south of the road. Dire Condors and Great Goretusks roam the same hills."] = "Les Bâtards des Carmines et d'autres gnolls tiennent les collines à l'est de {area:1002}, au nord de la route ; des Vandales des Carmines rôdent parmi eux, des Braconniers des Carmines campent au sud de la route. Des Condors redoutables et des Grands Broche-tripes parcourent les mêmes collines.",
	-- ["Redridge Mongrels and other gnolls hold the hills east of {area:1002}, north of the road; Redridge Thrashers prowl among them, Poachers camp south of the road. Redridge Brutes, for the Iron Pikes and Rivets, hold the hills further north; Dire Condors and Great Goretusks roam the hills east of them."] = "Des Bâtards des Carmines et d'autres gnolls tiennent les collines à l'est de {area:1002}, au nord de la route ; des Vandales des Carmines rôdent parmi eux, des Braconniers campent au sud de la route. Les Brutes des Carmines, pour les Clous en fer et les rivets, tiennent les collines plus au nord ; des Condors redoutables et des Grands Broche-tripes parcourent les collines à leur est.",
	-- ["South down the valley's east side to the Blackrock camps east of {area:2099}. Renegades, Grunts and Outrunners fill them; keep east of the keep, whose orcs are elite."] = "Descendez vers le sud par le côté est de la vallée jusqu'aux camps Blackrock à l'est de {area:2099}. Des Renégats, des Grunts et des Estafettes les remplissent ; restez à l'est du donjon, dont les orcs sont des élites.",
	-- ["Swim east from the bridge into {area:68}; the chest lies on the lake bed."] = "Nagez vers l'est depuis le pont dans {area:68} ; le coffre repose au fond du lac.",
	-- ["The Wanted poster by the inn: {npc:703}, in {area:1000}"] = "L'avis de recherche près de l'auberge : {npc:703}, à {area:1000}",
	-- ["The road from Elwynn enters Redridge at {area:1002}. {npc:464} stands where the roads to Redridge and {zone:1431} meet."] = "La route d'Elwynn entre dans les Carmines à {area:1002}. {npc:464} se tient au croisement des routes des Carmines et de {zone:1431}.",
	-- ["The {area:442} boat docks at {area:17203}. Walk up into the city for training and {npc:1646}, then leave by the main gate and follow the road east through {area:12}."] = "Le bateau d'{area:442} accoste au {area:17203}. Montez en ville pour vous entraîner et voir {npc:1646}, puis sortez par la grande porte et suivez la route vers l'est à travers la {area:12}.",
	-- ["The {area:442} boat docks at {area:17203}. Walk up into the city for training and {npc:1646}, then leave by the main gate and follow the road east through {zone:1429}."] = "Le bateau d'{area:442} accoste à {area:17203}. Montez en ville pour l'entraînement et {npc:1646}, puis sortez par la porte principale et suivez la route vers l'est à travers {zone:1429}.",
	-- ["{area:1000}: kill these as you meet them"] = "{area:1000} : tuez-les au passage",
	-- ["{area:1001}: kill these as you meet them"] = "{area:1001} : tuez-les au passage",
	-- ["{area:68}: kill these as you meet them"] = "{area:68} : tuez-les au passage",
	-- ["{item:1075}: any Shadowhide gnoll"] = "{item:1075} : tout gnoll Sombrepoil",
	-- ["{item:1309}; underwater"] = "{item:1309} ; sous l'eau",
	-- ["{item:1467} on the way"] = "{item:1467} en chemin",
	-- ["{item:280911}: Redridge Thrashers"] = "{item:280911} : Vandales des Carmines",
	-- ["{item:3014}: any Blackrock orc"] = "{item:3014} : tout orc Blackrock",
	-- ["{item:3014}: the Blackrock Renegades at the mill"] = "{item:3014} : les Renégats Blackrock du moulin",
	-- ["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646} : la lettre de Thundris, d'{area:442}",
	-- ["{npc:266}, by the docks"] = "{npc:266}, près des quais",
	-- ["{npc:266}, by the docks; upstairs"] = "{npc:266}, près des quais ; à l'étage",
	-- ["{npc:332} is at SI:7 in {object:2100}, {npc:6122} in the {object:2164}'s cellar in the {object:2101}, {npc:376} in the Cathedral of Light."] = "{npc:332} est au SI:7, dans {object:2100}, {npc:6122} dans la cave de {object:2164}, dans {object:2101}, {npc:376} dans la Cathedral of Light.",
	-- ["{npc:332}: {npc:7024} in {zone:1436} takes it, at the end of {zone:1431}"] = "{npc:332} : à rendre à {npc:7024} en {zone:1436}, à la fin de {zone:1431}",
	-- ["{npc:341}: after {quest:89}"] = "{npc:341} : après {quest:89}",
	-- ["{npc:343}, inside"] = "{npc:343}, à l'intérieur",
	-- ["{npc:344}, in the town hall"] = "{npc:344}, dans l'hôtel de ville",
	-- ["{npc:345} (level 24) roots around the pen just west of {area:69}. Pull him away from the other boars and fight at full health."] = "{npc:345} (niveau 24) fouille l'enclos juste à l'ouest de {area:69}. Éloignez-le des autres sangliers et combattez-le avec toute votre vie.",
	-- ["{npc:376}: {npc:11401} in {zone:1457} takes it, later"] = "{npc:376} : à rendre plus tard à {npc:11401}, à {zone:1457}",
	-- ["{npc:376}: {npc:11406} in {zone:1455} takes it, later"] = "{npc:376} : à rendre plus tard à {npc:11406}, à {zone:1455}",
	-- ["{npc:376}: {npc:258785} in {zone:1455} takes it, later"] = "{npc:376} : à rendre plus tard à {npc:258785}, à {zone:1455}",
	-- ["{npc:464} walks around {area:1002}: look inside the circle on the map"] = "{npc:464} se promène autour de {area:1002} : cherchez dans le cercle sur la carte",
	-- ["{npc:6122}: {npc:6244} in the {zone:1413} takes it, later"] = "{npc:6122} : à rendre plus tard à {npc:6244}, dans {zone:1413}",
	-- ["{npc:900}, inside"] = "{npc:900}, à l'intérieur",
	-- ["{zone:1431} is next: follow the road west to {area:1002}, then south to {area:42}."] = "Ensuite, {zone:1431} : suivez la route vers l'ouest jusqu'à {area:1002}, puis vers le sud jusqu'à {area:42}.",
	-- ["{zone:1453} class quests"] = "Quêtes de classe à {zone:1453}",
}
