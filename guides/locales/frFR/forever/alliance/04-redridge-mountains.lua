-- French (frFR): the guide forever/alliance/04-redridge-mountains (forever/alliance/04-redridge-mountains.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Boat to Stormwind Harbor
	-- {area:17203} Stormwind Harbor
	["Boat to {area:17203}"] = "Bateau pour {area:17203}",

	-- Step 2: Stormwind
	-- {area:442} Auberdine · {area:17203} Stormwind Harbor · {npc:1646} Baros Alexston · {area:12} Elwynn Forest
	["The {area:442} boat docks at {area:17203}. Walk up into the city for training and {npc:1646}, then leave by the main gate and follow the road east through {area:12}."] = "Le bateau d'{area:442} accoste au {area:17203}. Montez en ville pour vous entraîner et voir {npc:1646}, puis sortez par la grande porte et suivez la route vers l'est à travers la {area:12}.",
	["Level 18 and 20 spells"] = "Sorts des niveaux 18 et 20",
	-- {npc:1646} Baros Alexston · {area:442} Auberdine
	["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646} : la lettre de Thundris, d'{area:442}",
	-- {quest:97914} Expanding Horizons · {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["Only once {quest:97914} is handed in: for {npc:3649}, back in {area:442} (06-ashenvale)"] = "Seulement une fois {quest:97914} rendue : pour {npc:3649}, de retour à {area:442} (06-ashenvale)",

	-- Step 3: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Polearms from {npc:11867} ({object:2096}, 1 gold); two-handers level a Warrior fastest."] = "Pendant que vous y êtes : apprenez le maniement des armes d'hast auprès de {npc:11867} ({object:2096}, 1 pièce d'or) ; les armes à deux mains font progresser un Guerrier le plus vite.",

	-- Step 4: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Polearms from {npc:11867} ({object:2096}, 1 gold); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "Pendant que vous y êtes : apprenez le maniement des armes d'hast auprès de {npc:11867} ({object:2096}, 1 pièce d'or) ; l'arme de mêlée d'un Chasseur vaut surtout par ses caractéristiques, et les armes à deux mains en portent le plus.",

	-- Step 5: Stormwind class quests
	-- {zone:1453} Stormwind
	["{zone:1453} class quests"] = "Quêtes de classe à {zone:1453}",
	-- {npc:332} Master Mathias Shaw · {object:2100} Old Town · {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:376} High Priestess Laurena
	["{npc:332} is at SI:7 in {object:2100}, {npc:6122} in the {object:2164}'s cellar in the {object:2101}, {npc:376} in the Cathedral of Light."] = "{npc:332} est au SI:7, dans {object:2100}, {npc:6122} dans la cave de {object:2164}, dans {object:2101}, {npc:376} dans la Cathedral of Light.",
	-- {npc:332} Master Mathias Shaw · {npc:7024} Agent Kearnen · {zone:1436} Westfall · {zone:1431} Duskwood
	["{npc:332}: {npc:7024} in {zone:1436} takes it, at the end of {zone:1431}"] = "{npc:332} : à rendre à {npc:7024} en {zone:1436}, à la fin de {zone:1431}",
	-- {npc:6122} Gakin the Darkbinder · {npc:6244} Takar the Seer · {zone:1413} Barrens
	["{npc:6122}: {npc:6244} in the {zone:1413} takes it, later"] = "{npc:6122} : à rendre plus tard à {npc:6244}, dans {zone:1413}",
	-- {npc:376} High Priestess Laurena · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["{npc:376}: {npc:11406} in {zone:1455} takes it, later"] = "{npc:376} : à rendre plus tard à {npc:11406}, à {zone:1455}",
	-- {npc:376} High Priestess Laurena · {npc:258785} High Priestess Mims · {zone:1455} Ironforge
	["{npc:376}: {npc:258785} in {zone:1455} takes it, later"] = "{npc:376} : à rendre plus tard à {npc:258785}, à {zone:1455}",
	-- {npc:376} High Priestess Laurena · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["{npc:376}: {npc:11401} in {zone:1457} takes it, later"] = "{npc:376} : à rendre plus tard à {npc:11401}, à {zone:1457}",

	-- Step 6: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "Tram pour {zone:1455}",

	-- Step 7: Shaman training
	["Shaman training"] = "Entraînement de chaman",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back."] = "{zone:1453} n'a pas de maître chaman : prenez {area:2257} depuis {object:28027} jusqu'à {zone:1455}, entraînez-vous auprès de {npc:258098}, puis reprenez le tram pour revenir.",

	-- Step 8: Fly to Sentinel Hill
	-- {area:108} Sentinel Hill
	["Fly to {area:108}"] = "Prendre un vol pour {area:108}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Maître de vol de {zone:1453}",

	-- Step 9: Half Pendant of Aquatic Endurance
	-- {area:108} Sentinel Hill · {object:177790} Strange Lockbox
	["Fly to {area:108} and head north-west to the coast: the {object:177790} lies on the sea floor off the shore. Then head east along the road through Elwynn to Redridge."] = "Prenez un vol pour {area:108} et allez au nord-ouest jusqu'à la côte : le {object:177790} repose au fond de la mer, au large. Suivez ensuite la route vers l'est à travers la forêt d'Elwynn jusqu'aux Carmines.",
	-- {item:15882} Half Pendant of Aquatic Endurance · {object:177790} Strange Lockbox
	["{item:15882}: the {object:177790}"] = "{item:15882} : l'{object:177790}",

	-- Step 10: Back to Elwynn Forest
	-- {area:12} Elwynn Forest
	["Back to {area:12}"] = "Retour dans la {area:12}",

	-- Step 13: Henze Faulk
	-- {area:91} Tower of Azora · {area:86} Stone Cairn Lake · {npc:6172} Henze Faulk · {item:6866} Symbol of Life · {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["On the road east, past the {area:91}, head north from the bridge to {area:86}. {npc:6172} lies south of the lake: use the {item:6866} on him. The Defias Rogue Wizards around him carry the {item:6846}."] = "Sur la route vers l'est, après la {area:91}, partez vers le nord depuis le pont jusqu'au {area:86}. {npc:6172} gît au sud du lac : utilisez le {item:6866} sur lui. Les Sorciers-voleurs défias autour de lui portent le {item:6846}.",
	-- {item:6866} Symbol of Life · {npc:6172} Henze Faulk
	["Use the {item:6866} on {npc:6172}"] = "Utilisez le {item:6866} sur {npc:6172}",
	-- {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["{item:6846}: Defias Rogue Wizards"] = "{item:6846} : Sorciers-voleurs défias",

	-- Step 15: Three Corners
	-- {area:1002} Three Corners · {npc:464} Guard Parker · {zone:1431} Duskwood
	["The road from Elwynn enters Redridge at {area:1002}. {npc:464} stands where the roads to Redridge and {zone:1431} meet."] = "La route d'Elwynn entre dans les Carmines à {area:1002}. {npc:464} se tient au croisement des routes des Carmines et de {zone:1431}.",
	-- {npc:464} Guard Parker · {area:1002} Three Corners
	["{npc:464} walks around {area:1002}: look inside the circle on the map"] = "{npc:464} se promène autour de {area:1002} : cherchez dans le cercle sur la carte",

	-- Step 16: Lakeridge Highway
	-- {area:68} Lake Everstill · {npc:1070} Deputy Feldon · {npc:903} Guard Howe
	["Follow the road along the south shore of {area:68} to the gryphon master. {npc:1070} and {npc:903} stand by the road next to her."] = "Suivez la route le long de la rive sud de {area:68} jusqu'à la maîtresse des griffons. {npc:1070} et {npc:903} se tiennent au bord de la route, près d'elle.",

	-- Step 17: Lakeshire
	-- {npc:341} Foreman Oslow · {npc:382} Marshal Marris · {npc:900} Bailiff Conacher · {npc:381} Dockmaster Baren · {npc:266} Wiley the Black · {npc:343} Chef Breanna · {npc:342} Martie Jainrose
	["Cross the long bridge north into town. {npc:341} and {npc:382} stand at the north end of the bridge, {npc:900} in the town hall, {npc:381} and {npc:266} on the docks, {npc:343} at the inn, {npc:342} in her garden at the west end."] = "Traversez le long pont vers le nord jusqu'à la ville. {npc:341} et {npc:382} se tiennent au bout nord du pont, {npc:900} dans l'hôtel de ville, {npc:381} et {npc:266} sur les quais, {npc:343} à l'auberge, {npc:342} dans son jardin, à l'ouest.",
	-- {npc:266} Wiley the Black
	["{npc:266}, by the docks; upstairs"] = "{npc:266}, près des quais ; à l'étage",
	["Inside"] = "À l'intérieur",
	-- {npc:343} Chef Breanna
	["{npc:343}, inside"] = "{npc:343}, à l'intérieur",

	-- Step 18: Spotted Sunfish on the way
	-- {item:1467} Spotted Sunfish
	["{item:1467} on the way"] = "{item:1467} en chemin",

	-- Step 19: Sunken Chest
	-- {area:68} Lake Everstill
	["Swim east from the bridge into {area:68}; the chest lies on the lake bed."] = "Nagez vers l'est depuis le pont dans {area:68} ; le coffre repose au fond du lac.",
	-- {item:1309} Oslow's Toolbox
	["{item:1309}; underwater"] = "{item:1309} ; sous l'eau",

	-- Step 21: Lakeridge Highway: kill these as you meet them
	-- {area:1001} Lakeridge Highway
	["{area:1001}: kill these as you meet them"] = "{area:1001} : tuez-les au passage",
	-- {area:1002} Three Corners
	-- plural, as words: Redridge Mongrels = {npc:423} Redridge Mongrel · Redridge Thrashers = {npc:712} Redridge Thrasher · Redridge Brutes = {npc:426} Redridge Brute · Iron Pikes = {item:2856} Iron Pike · Dire Condors = {npc:428} Dire Condor · Great Goretusks = {npc:547} Great Goretusk
	["Redridge Mongrels and other gnolls hold the hills east of {area:1002}, north of the road; Redridge Thrashers prowl among them, Poachers camp south of the road. Redridge Brutes, for the Iron Pikes and Rivets, hold the hills further north; Dire Condors and Great Goretusks roam the hills east of them."] = "Des Bâtards des Carmines et d'autres gnolls tiennent les collines à l'est de {area:1002}, au nord de la route ; des Vandales des Carmines rôdent parmi eux, des Braconniers campent au sud de la route. Les Brutes des Carmines, pour les Clous en fer et les rivets, tiennent les collines plus au nord ; des Condors redoutables et des Grands Broche-tripes parcourent les collines à leur est.",
	-- {item:280911} Spiked Collar
	-- plural, as words: Redridge Thrashers = {npc:712} Redridge Thrasher
	["{item:280911}: Redridge Thrashers"] = "{item:280911} : Vandales des Carmines",

	-- Step 26: Lakeshire
	-- {npc:341} Foreman Oslow · {quest:89} The Everstill Bridge
	["{npc:341}: after {quest:89}"] = "{npc:341} : après {quest:89}",

	-- Step 27: Lake Everstill: kill these as you meet them
	-- {area:68} Lake Everstill
	["{area:68}: kill these as you meet them"] = "{area:68} : tuez-les au passage",
	-- {item:1467} Spotted Sunfish
	-- plural, as words: Murloc Flesheaters = {npc:422} Murloc Flesheater · Greater Tarantulas = {npc:505} Greater Tarantula
	["Murloc Flesheaters and Tidecallers line the south shore east of the bridge. Any of them can carry a {item:1467} or a fin.\nGreater Tarantulas crawl on the slopes around the mill north-east of the lake."] = "Des Dévoreurs murlocs et des Mande-flots murlocs bordent la rive sud à l'est du pont. N'importe lequel peut porter un {item:1467} ou une nageoire.\nDes Grandes tarentules rampent sur les pentes autour du moulin au nord-est du lac.",

	-- Step 28: Blackrock camps
	["Blackrock camps"] = "Camps Blackrock",
	-- {area:1000} Galardell Valley · {area:2099} Stonewatch Keep
	["South-east from the mill, west of {area:1000}'s gnolls, to the Blackrock camps east of {area:2099}. Renegades, Grunts and Outrunners fill them; keep east of the keep, whose orcs are elite."] = "",

	-- Step 29: Back to Lakeshire
	-- {area:69} Lakeshire
	["Back to {area:69}"] = "Retour à {area:69}",

	-- Step 30: Render's Valley
	-- {area:69} Lakeshire · {area:95} Redridge Canyons · {area:997} Render's Valley
	-- plural, as words: Blackrock Champions = {npc:435} Blackrock Champion
	["Head north out of {area:69} up the {area:95} to {area:997}. Blackrock Champions camp in the valley."] = "Allez au nord hors de {area:69} par {area:95} jusqu'à {area:997}. Des Champions Blackrock campent dans la vallée.",
	-- {npc:435} Blackrock Champion
	["{npc:435}, below ground"] = "{npc:435}, sous terre",

	-- Step 31: Corporal Keeshan
	-- {zone:1428} Burning Steppes · {area:69} Lakeshire
	["Keeshan hides at the very north end of the valley, by the {zone:1428} border. Escort him down to {area:69}; Blackrock orcs ambush you on the way."] = "Keeshan se cache tout au nord de la vallée, près de la frontière de {zone:1428}. Escortez-le jusqu'à {area:69} ; des orcs Blackrock vous tendent des embuscades en chemin.",
	-- {npc:349} Corporal Keeshan
	["{npc:349}, below ground"] = "{npc:349}, sous terre",

	-- Step 32: Lakeshire
	-- {npc:903} Guard Howe
	["{npc:903}, by the gryphons south of the bridge"] = "{npc:903}, près des griffons au sud du pont",
	-- {zone:1431} Duskwood · {area:1002} Three Corners · {area:42} Darkshire
	["{zone:1431} is next: follow the road west to {area:1002}, then south to {area:42}."] = "Ensuite, {zone:1431} : suivez la route vers l'ouest jusqu'à {area:1002}, puis vers le sud jusqu'à {area:42}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Bellygrub"] = "Fouailleventre",
	-- ["East past the mill and across the river. Shadowhide gnolls fill the valley; {npc:703} (26, well above you) leads them at its north end: clear his escort first and fight him at full health. Stay out of {area:2099} to the south: its orcs are elite."] = "À l'est, au-delà du moulin et de la rivière. Les gnolls Sombrepoil remplissent la vallée ; {npc:703} (26, bien au-dessus de vous) les mène à son extrémité nord : éliminez d'abord son escorte et combattez-le en pleine santé. Évitez {area:2099} au sud : ses orcs sont élites.",
	-- ["East past the mill and across the river. Shadowhide gnolls fill the valley; {npc:703} (26, well above you) leads them at its north end: clear his escort first and fight him at full health. Stay out of {area:2099} to the south: its orcs are elite.\nCareful: Two gnoll guards stay with him and join the fight whenever he is attacked, even if he has wandered a short way off; other gnolls stand close by and wander through the area."] = "À l'est, après le moulin, de l'autre côté de la rivière. Les gnolls Sombrepoil remplissent la vallée ; {npc:703} (niveau 26, bien au-dessus de vous) les mène à son extrémité nord : éliminez d'abord son escorte et combattez-le avec toute votre vie. Évitez {area:2099} au sud : ses orcs sont des élites.\nAttention : deux gardes gnolls restent avec lui et se joignent au combat dès qu'il est attaqué, même s'il s'est un peu éloigné ; d'autres gnolls se tiennent tout près et errent dans le secteur.",
	-- ["Fly to {area:108} and ride north-west to the coast: the {object:177790} lies on the sea floor off the shore. Then ride east along the road through Elwynn to Redridge."] = "Prenez un vol pour {area:108} et allez au nord-ouest jusqu'à la côte : l'{object:177790} repose au fond de la mer, au large. Suivez ensuite la route vers l'est à travers la forêt d'Elwynn jusqu'aux Carmines.",
	-- ["For {npc:3649}, on the return to {area:442} (06-ashenvale)"] = "Pour {npc:3649}, au retour à {area:442} (06-ashenvale)",
	-- ["Gnolls toward {area:1002}"] = "Gnolls vers {area:1002}",
	-- ["Greater Tarantulas crawl on the slopes around the mill north-east of the lake; Blackrock Renegades hold the mill itself."] = "Des Grandes tarentules rampent sur les pentes autour du moulin, au nord-est du lac ; des Renégats Blackrock occupent le moulin.",
	-- ["Hearth to {area:69}"] = "Pierre de foyer vers {area:69}",
	-- ["Lake murlocs"] = "Murlocs du lac",
	-- ["Murloc Flesheaters and Tidecallers line the south shore east of the bridge. Any of them can carry a {item:1467} or a fin."] = "Des Dévoreurs murlocs et des Maîtres des flots murlocs bordent la rive sud à l'est du pont. Chacun peut porter un {item:1467} ou une nageoire.",
	-- ["On the top floor"] = "Au dernier étage",
	-- ["Redridge Mongrels and other gnolls hold the hills east of {area:1002}, north of the road; Redridge Thrashers prowl among them, Poachers camp south of the road. Dire Condors and Great Goretusks roam the same hills."] = "Les Bâtards des Carmines et d'autres gnolls tiennent les collines à l'est de {area:1002}, au nord de la route ; des Vandales des Carmines rôdent parmi eux, des Braconniers des Carmines campent au sud de la route. Des Condors redoutables et des Grands Broche-tripes parcourent les mêmes collines.",
	-- ["South down the valley's east side to the Blackrock camps east of {area:2099}. Renegades, Grunts and Outrunners fill them; keep east of the keep, whose orcs are elite."] = "Descendez vers le sud par le côté est de la vallée jusqu'aux camps Blackrock à l'est de {area:2099}. Des Renégats, des Grunts et des Estafettes les remplissent ; restez à l'est du donjon, dont les orcs sont des élites.",
	-- ["The Wanted poster by the inn: {npc:703}, in {area:1000}"] = "L'avis de recherche près de l'auberge : {npc:703}, à {area:1000}",
	-- ["The {area:442} boat docks at {area:17203}. Walk up into the city for training and {npc:1646}, then leave by the main gate and follow the road east through {zone:1429}."] = "Le bateau d'{area:442} accoste à {area:17203}. Montez en ville pour l'entraînement et {npc:1646}, puis sortez par la porte principale et suivez la route vers l'est à travers {zone:1429}.",
	-- ["{area:1000}: kill these as you meet them"] = "{area:1000} : tuez-les au passage",
	-- ["{item:1075}: any Shadowhide gnoll"] = "{item:1075} : tout gnoll Sombrepoil",
	-- ["{item:3014}: any Blackrock orc"] = "{item:3014} : tout orc Blackrock",
	-- ["{item:3014}: the Blackrock Renegades at the mill"] = "{item:3014} : les Renégats Blackrock du moulin",
	-- ["{npc:266}, by the docks"] = "{npc:266}, près des quais",
	-- ["{npc:344}, in the town hall"] = "{npc:344}, dans l'hôtel de ville",
	-- ["{npc:345} (level 24) roots around the pen just west of {area:69}. Pull him away from the other boars and fight at full health."] = "{npc:345} (niveau 24) fouille l'enclos juste à l'ouest de {area:69}. Éloignez-le des autres sangliers et combattez-le avec toute votre vie.",
	-- ["{npc:900}, inside"] = "{npc:900}, à l'intérieur",
}
