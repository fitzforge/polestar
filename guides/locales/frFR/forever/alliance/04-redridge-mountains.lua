-- French (frFR): the guide forever/alliance/04-redridge-mountains (forever/alliance/04-redridge-mountains.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Stormwind
	-- {area:442} Auberdine · {area:17203} Stormwind Harbor · {npc:1646} Baros Alexston · {zone:1429} Elwynn Forest
	["The {area:442} boat docks at {area:17203}. Walk up into the city for training and {npc:1646}, then leave by the main gate and follow the road east through {zone:1429}."] = "Le bateau d'{area:442} accoste à {area:17203}. Montez en ville pour l'entraînement et {npc:1646}, puis sortez par la porte principale et suivez la route vers l'est à travers {zone:1429}.",
	["Level 18 and 20 spells"] = "Sorts des niveaux 18 et 20",
	-- {npc:1646} Baros Alexston · {area:442} Auberdine
	["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646} : la lettre de Thundris, d'{area:442}",
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["For {npc:3649}, on the return to {area:442} (06-ashenvale)"] = "Pour {npc:3649}, au retour à {area:442} (06-ashenvale)",

	-- Step 2: Shaman training
	["Shaman training"] = "Entraînement de chaman",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back."] = "{zone:1453} n'a pas de maître chaman : prenez {area:2257} depuis {object:28027} jusqu'à {zone:1455}, entraînez-vous auprès de {npc:258098}, puis reprenez le tram pour revenir.",

	-- Step 3: Stormwind class quests
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

	-- Step 4: Half Pendant of Aquatic Endurance
	-- {area:108} Sentinel Hill · {object:177790} Strange Lockbox
	["Fly to {area:108} and ride north-west to the coast: the {object:177790} lies on the sea floor off the shore. Then ride east along the road through Elwynn to Redridge."] = "Prenez un vol pour {area:108} et allez au nord-ouest jusqu'à la côte : l'{object:177790} repose au fond de la mer, au large. Suivez ensuite la route vers l'est à travers la forêt d'Elwynn jusqu'aux Carmines.",
	-- {item:15882} Half Pendant of Aquatic Endurance · {object:177790} Strange Lockbox
	["{item:15882}: the {object:177790}"] = "{item:15882} : l'{object:177790}",

	-- Step 5: Three Corners
	-- {area:1002} Three Corners · {npc:464} Guard Parker · {zone:1431} Duskwood
	["The road from Elwynn enters Redridge at {area:1002}. {npc:464} stands where the roads to Redridge and {zone:1431} meet."] = "La route d'Elwynn entre dans les Carmines à {area:1002}. {npc:464} se tient au croisement des routes des Carmines et de {zone:1431}.",

	-- Step 6: Lakeridge Highway
	-- {area:68} Lake Everstill · {npc:1070} Deputy Feldon · {npc:903} Guard Howe
	["Follow the road along the south shore of {area:68} to the gryphon master. {npc:1070} and {npc:903} stand by the road next to her."] = "Suivez la route le long de la rive sud de {area:68} jusqu'à la maîtresse des griffons. {npc:1070} et {npc:903} se tiennent au bord de la route, près d'elle.",

	-- Step 7: Lakeshire
	-- {npc:341} Foreman Oslow · {npc:382} Marshal Marris · {npc:900} Bailiff Conacher · {npc:381} Dockmaster Baren · {npc:266} Wiley the Black · {npc:343} Chef Breanna · {npc:342} Martie Jainrose
	["Cross the long bridge north into town. {npc:341} and {npc:382} stand at the north end of the bridge, {npc:900} in the town hall, {npc:381} and {npc:266} on the docks, {npc:343} at the inn, {npc:342} in her garden at the west end."] = "Traversez le long pont vers le nord jusqu'à la ville. {npc:341} et {npc:382} se tiennent au bout nord du pont, {npc:900} dans l'hôtel de ville, {npc:381} et {npc:266} sur les quais, {npc:343} à l'auberge, {npc:342} dans son jardin, à l'ouest.",
	-- {npc:266} Wiley the Black
	["{npc:266}, by the docks"] = "{npc:266}, près des quais",

	-- Step 8: Sunken Chest
	-- {area:68} Lake Everstill
	["Swim east from the bridge into {area:68}; the chest lies on the lake bed."] = "Nagez vers l'est depuis le pont dans {area:68} ; le coffre repose au fond du lac.",

	-- Step 9: Gnolls toward Three Corners
	-- {area:1002} Three Corners
	["Gnolls toward {area:1002}"] = "Gnolls vers {area:1002}",
	-- {area:1002} Three Corners
	-- plural, as words: Redridge Mongrels = {npc:423} Redridge Mongrel · Redridge Thrashers = {npc:712} Redridge Thrasher · Dire Condors = {npc:428} Dire Condor · Great Goretusks = {npc:547} Great Goretusk
	["Redridge Mongrels and other gnolls hold the hills east of {area:1002}, north of the road; Redridge Thrashers prowl among them, Poachers camp south of the road. Dire Condors and Great Goretusks roam the same hills."] = "Les Bâtards des Carmines et d'autres gnolls tiennent les collines à l'est de {area:1002}, au nord de la route ; des Vandales des Carmines rôdent parmi eux, des Braconniers des Carmines campent au sud de la route. Des Condors redoutables et des Grands Broche-tripes parcourent les mêmes collines.",
	-- {item:280911} Spiked Collar
	-- plural, as words: Redridge Thrashers = {npc:712} Redridge Thrasher
	["{item:280911}: Redridge Thrashers"] = "{item:280911} : Vandales des Carmines",

	-- Step 10: Bellygrub
	-- {npc:345} Bellygrub · {area:69} Lakeshire
	["{npc:345} (level 24) roots around the pen just west of {area:69}. Pull him away from the other boars and fight at full health."] = "{npc:345} (niveau 24) fouille autour de l'enclos juste à l'ouest de {area:69}. Éloignez-le des autres sangliers et combattez-le en pleine santé.",

	-- Step 12: Lakeshire
	-- {npc:341} Foreman Oslow · {quest:89} The Everstill Bridge
	["{npc:341}: after {quest:89}"] = "{npc:341} : après {quest:89}",
	-- {npc:703} Lieutenant Fangore · {area:1000} Galardell Valley
	["The Wanted poster by the inn: {npc:703}, in {area:1000}"] = "L'avis de recherche près de l'auberge : {npc:703}, à {area:1000}",

	-- Step 13: Lake murlocs
	["Lake murlocs"] = "Murlocs du lac",
	-- {item:1467} Spotted Sunfish
	-- plural, as words: Murloc Flesheaters = {npc:422} Murloc Flesheater
	["Murloc Flesheaters and Tidecallers line the south shore east of the bridge. Any of them can carry a {item:1467} or a fin."] = "Des Dévoreurs murlocs et des Maîtres des flots murlocs bordent la rive sud à l'est du pont. Chacun peut porter un {item:1467} ou une nageoire.",

	-- Step 14: Alther's Mill
	-- plural, as words: Greater Tarantulas = {npc:505} Greater Tarantula · Blackrock Renegades = {npc:437} Blackrock Renegade
	["Greater Tarantulas crawl on the slopes around the mill north-east of the lake; Blackrock Renegades hold the mill itself."] = "Des Grandes tarentules rampent sur les pentes autour du moulin, au nord-est du lac ; des Renégats Blackrock occupent le moulin.",
	-- {item:3014} Battleworn Axe
	-- plural, as words: Blackrock Renegades = {npc:437} Blackrock Renegade
	["{item:3014}: the Blackrock Renegades at the mill"] = "{item:3014} : les Renégats Blackrock du moulin",

	-- Step 15: Galardell Valley
	-- {npc:703} Lieutenant Fangore · {area:2099} Stonewatch Keep
	["East past the mill and across the river. Shadowhide gnolls fill the valley; {npc:703} (26, well above you) leads them at its north end: clear his escort first and fight him at full health. Stay out of {area:2099} to the south: its orcs are elite."] = "À l'est, au-delà du moulin et de la rivière. Les gnolls Sombrepoil remplissent la vallée ; {npc:703} (26, bien au-dessus de vous) les mène à son extrémité nord : éliminez d'abord son escorte et combattez-le en pleine santé. Évitez {area:2099} au sud : ses orcs sont élites.",
	-- {item:1075} Shadowhide Pendant
	["{item:1075}: any Shadowhide gnoll"] = "{item:1075} : tout gnoll Sombrepoil",

	-- Step 16: Back to Lakeshire
	-- {area:69} Lakeshire
	["Back to {area:69}"] = "Retour à {area:69}",
	-- {npc:344} Magistrate Solomon
	["{npc:344}, in the town hall"] = "{npc:344}, dans l'hôtel de ville",

	-- Step 17: Render's Valley
	-- {area:69} Lakeshire · {area:95} Redridge Canyons · {area:997} Render's Valley
	-- plural, as words: Blackrock Champions = {npc:435} Blackrock Champion
	["Head north out of {area:69} up the {area:95} to {area:997}. Blackrock Champions camp in the valley."] = "Allez au nord hors de {area:69} par {area:95} jusqu'à {area:997}. Des Champions Blackrock campent dans la vallée.",

	-- Step 18: Corporal Keeshan
	-- {zone:1428} Burning Steppes · {area:69} Lakeshire
	["Keeshan hides at the very north end of the valley, by the {zone:1428} border. Escort him down to {area:69}; Blackrock orcs ambush you on the way."] = "Keeshan se cache tout au nord de la vallée, près de la frontière de {zone:1428}. Escortez-le jusqu'à {area:69} ; des orcs Blackrock vous tendent des embuscades en chemin.",

	-- Step 19: Lakeshire
	-- {npc:903} Guard Howe
	["{npc:903}, by the gryphons south of the bridge"] = "{npc:903}, près des griffons au sud du pont",
	-- {zone:1431} Duskwood · {area:1002} Three Corners · {area:42} Darkshire
	["{zone:1431} is next: follow the road west to {area:1002}, then south to {area:42}."] = "Ensuite, {zone:1431} : suivez la route vers l'ouest jusqu'à {area:1002}, puis vers le sud jusqu'à {area:42}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Bellygrub"] = "Fouailleventre",
	-- ["{item:3014}: any Blackrock orc"] = "{item:3014} : tout orc Blackrock",
}
