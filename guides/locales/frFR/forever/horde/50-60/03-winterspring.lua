-- French (frFR): the guide forever/horde/50-60/03-winterspring (forever/horde/50-60/03-winterspring.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Winterspring
	-- {zone:1452} Winterspring
	["Into {zone:1452}"] = "Vers {zone:1452}",

	-- Step 2: Salfa
	-- {npc:11556} Salfa · {zone:1452} Winterspring · {area:1769} Timbermaw Hold
	["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "",

	-- Step 3: Donova Snowden
	-- {npc:9298} Donova Snowden · {area:2246} Frostfire Hot Springs
	["Ride south from the tunnel: {npc:9298} camps among the steaming pools of {area:2246}, in the west of the valley."] = "",
	["Linken's letter"] = "La lettre de Linken",
	-- {quest:3909} The Videre Elixir · {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["{quest:3909} comes from {npc:7775} in {zone:1444}, later in this guide."] = "{quest:3909} vient de {npc:7775} en {zone:1444}, plus loin dans ce guide.",

	-- Step 4: Frostfire Hot Springs: kill these as you meet them
	-- {area:2246} Frostfire Hot Springs
	["{area:2246}: kill these as you meet them"] = "{area:2246} : tuez-les au passage",
	-- {item:14047} Runecloth
	-- plural, as words: Ragged Owlbeasts = {npc:7450} Ragged Owlbeast
	["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh."] = "Guides, Protecteurs et Totémiques se partagent les camps de furbolgs autour des sources chaudes ; des Chouettards éreintés parcourent les pentes entre eux. Tuez d'abord les Totémiques. Gardez chaque {item:14047} ramassée pour Meilosh.",
	-- {item:12771} Empty Firewater Flask
	["{item:12771}: about one Winterfall furbolg in ten carries one; keep killing them until it drops"] = "",
	-- {quest:8471} Winterfall Ritual Totem
	["{quest:8471}, a rare drop from the Winterfall furbolgs"] = "{quest:8471}, un butin rare des furbolgs Tombe-hiver",

	-- Step 5: Donova Snowden
	-- {quest:5084} Falling to Corruption · {object:176091} Deadwood Cauldron · {zone:1448} Felwood
	["{quest:5084} is turned in at the {object:176091} in {zone:1448}, on a later trip."] = "{quest:5084} se rend au {object:176091} en {zone:1448}, lors d'un voyage ultérieur.",

	-- Step 6: Raging Owlbeasts
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["Raging Owlbeasts"] = "Chouettards enragés ({npc:7451})",
	-- {area:2251} Lake Kel'Theril · {area:2246} Frostfire Hot Springs · {area:2255} Everlook
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2246} and {area:2255}."] = "",

	-- Step 8: Everlook
	-- {area:2255} Everlook
	["{area:2255} is the goblin town on the east side of the valley, past the owlbeast hills."] = "",
	["Gregor's and Harlo's quests lead to other zones: keep them."] = "Les quêtes de Gregor et de Harlo mènent à d'autres zones : gardez-les.",
	-- {npc:11118} Innkeeper Vizzie
	["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118} : le guide précédent vous lie ici, cette étape se coche donc généralement aussitôt",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}, inside"] = "{npc:10431}, à l'intérieur",

	-- Step 9: Ice Thistle yetis
	["Ice Thistle yetis"] = "Yétis Chardon de glace",
	-- {area:2255} Everlook
	["The yeti hills start just south-east of {area:2255}. Every yeti drops fur; only Matriarchs and Patriarchs drop horns, so keep those for after the turn-in."] = "Les collines des yétis commencent juste au sud-est de {area:2255}. Chaque yéti lâche de la fourrure ; seuls les Matriarches et Patriarches lâchent des cornes, gardez donc celles-ci pour après la remise de quête.",

	-- Step 11: Level 55.04
	["Level 55.04"] = "Niveau 55.04",
	-- {area:2255} Everlook · {area:1584} Blackrock Depths · {area:1583} Blackrock Spire
	["Top up here to level 55.04 before the hand-ins at {area:2255}: they take you to level 56. Or, with a group, run the {area:1584} dungeon or the {area:1583} dungeon (Lower) instead."] = "",
	-- {npc:7460} Ice Thistle Patriarch
	["grind on {npc:7460}"] = "tuez en boucle : {npc:7460}",

	-- Step 12: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "Cornes de yéti en parfait état ({item:12367})",
	["Matriarchs and Patriarchs hit hard: pull them one at a time."] = "Les Matriarches et Patriarches frappent fort : attirez-les un par un.",
	["Below ground"] = "Sous terre",

	-- Step 13: Chillwind chimaeras
	["Chillwind chimaeras"] = "Chimères Frisevent",
	-- {area:2255} Everlook · {area:2245} Mazthoril
	["The chimaeras roam the snowfields south and west of {area:2255}. Stay clear of {area:2245}'s cave: its blue dragonkin are elite."] = "Les chimères parcourent les champs de neige au sud et à l'ouest de {area:2255}. Évitez la grotte de {area:2245} : ses draconiens bleus sont élites.",

	-- Step 14: Umi Rumplesnicker
	-- {area:976} Gadgetzan
	["Umi's third prank targets goblins in {area:976} and Un'Goro: keep it for later."] = "La troisième farce d'Umi vise les gobelins de {area:976} et d'Un'Goro : gardez-la pour plus tard.",

	-- Step 15: Winterfall Village
	-- {area:2255} Everlook · {npc:10738} High Chief Winterfall
	["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} in the cave at the back is elite: stay out."] = "Le village furbolg occupe la vallée au nord-est de {area:2255}. Tuez d'abord les Chamans ; ils soignent. {npc:10738}, dans la grotte du fond, est un élite : n'y allez pas.",

	-- Step 16: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Volez jusqu'au {area:1099}",
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "Maître de vol de {area:2255}",

	-- Step 18: The Videre Elixir
	-- {npc:7775} Gregan Brewspewer · {area:1137} Lower Wilds · {area:1099} Camp Mojache
	["{npc:7775}, a dwarf, camps in the {area:1137} north-west of {area:1099}; he has the elixir."] = "{npc:7775}, un nain, campe dans les {area:1137} au nord-ouest du {area:1099} ; il a l'élixir.",

	-- Step 20: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Volez jusqu'à {area:1638}",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "Maître de vol de {area:2408}",

	-- Step 21: Bluff Runner Windstrider
	-- {npc:10881} Bluff Runner Windstrider · {npc:14728} Rumstag Proudstrider · {area:1641} Hunter Rise
	["{npc:10881} and {npc:14728} stand on {area:1641}. Each of Rumstag's donations takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "",

	-- Step 22: Elder Rise
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{npc:3033} sur la {area:1639} ; {npc:246344}",
	-- {quest:1123} Rabine Saturna · {zone:1450} Moonglade
	["{quest:1123} waits in {zone:1450}: keep it for later."] = "{quest:1123} attend à {zone:1450} : gardez-la pour plus tard.",

	-- Step 23: Bashana Runetotem
	-- {npc:9087} Bashana Runetotem · {item:11040} Morrowgrain · {quest:3761} Un'Goro Soil · {quest:3782} Morrowgrain Research · {item:11020} Evergreen Pouch
	["{npc:9087} buys {item:11040} grown from your {quest:3761}. {quest:3782} wants ten, and the {item:11020} gives one try every ten minutes: take it only if you already have the grain."] = "",

	-- Step 24: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Volez jusqu'à {area:1637}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Maître de vol : {zone:1456}",

	-- Step 25: Vehena
	-- {object:172961} Valley of Spirits
	["In the {object:172961}. Each donation takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "Dans {object:172961}. Chaque don prend soixante étoffes de laine, de soie ou de tisse-mage dans vos sacs : rendez celles que vous avez sur vous, ignorez les autres.",

	-- Step 26: Rashona Straglash
	-- {object:172958} Valley of Honor
	["In the {object:172958}."] = "Dans {object:172958}.",
	-- {item:14047} Runecloth
	["Both {item:14047} donations are handed in later in the route: save sixty {item:14047} for each if you want them."] = "Les deux dons d'{item:14047} se rendent plus loin dans le parcours : gardez soixante {item:14047} pour chacun si vous les voulez.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any Winterfall furbolg can carry the beads; the camps just south of {npc:11556} are the closest."] = "N'importe quel furbolg Tombe-hiver peut porter les perles ; les camps juste au sud de {npc:11556} sont les plus proches.",
	-- ["Back at {area:1099}."] = "De retour au {area:1099}.",
	-- ["Back to {area:2255}"] = "Retour à {area:2255}",
	-- ["Chillwind chimaeras"] = "Chimères Noroît",
	-- ["Fly to {zone:1454}"] = "Prendre un vol pour {zone:1454}",
	-- ["Fly to {zone:1456}"] = "Prendre un vol pour {zone:1456}",
	-- ["From Krakle in Un'Goro"] = "De la part de Krakle à Un'Goro",
	-- ["Frostfire Winterfall camp"] = "Camp Tombe-hiver de Givrefeu",
	-- ["Frostfire Winterfall camps"] = "Camps Tombe-hiver de Givrefeu",
	-- ["Grind to 55"] = "Montez au niveau 55",
	-- ["He stands on {area:1641}. Each donation wants cloth from your bags; hand them in when you have it, later in the route."] = "Il se tient sur la {area:1641}. Chaque don demande de l'étoffe de vos sacs ; remettez-les quand vous l'avez, plus loin dans l'itinéraire.",
	-- ["He stands on {area:1641}. Each donation wants sixty cloth from your bags: take them if you save cloth, and hand in what you carry later in the route."] = "Il se tient sur {area:1641}. Chaque don demande soixante pièces de tissu de vos sacs : acceptez-les si vous gardez votre tissu, et rendez ce que vous avez sur vous plus loin dans le parcours.",
	-- ["In the {object:172961}."] = "Dans {object:172961}.",
	-- ["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh."] = "Guides, Protecteurs et Totémiques se partagent les camps de furbolgs autour des sources chaudes ; des Chouettards éreintés ({npc:7450}) parcourent les pentes entre eux. Tuez d'abord les Totémiques. Gardez chaque {item:14047} ramassée pour Meilosh.",
	-- ["Ride back west to {area:2246}."] = "Retournez vers l'ouest jusqu'aux {area:2246}.",
	-- ["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "Chevauchez vers l'est, puis descendez vers le sud la {area:2249}. Les Géants Cognegivre y sont des élites de niveau 59 : restez au milieu et ne vous arrêtez pas. L'étrange source se trouve à l'entrée de la {area:2256}, à l'extrémité sud.",
	-- ["Ride west along the road past {area:2251}; Raging Owlbeasts roam the hills north of it."] = "Chevauchez vers l'ouest sur la route en passant le {area:2251} ; les Chouettards enragés ({npc:7451}) parcourent les collines au nord.",
	-- ["Top up here to level 55.04 before the hand-ins at {area:2255}: they take you to level 56."] = "Montez ici jusqu'au niveau 55.04 avant de rendre les quêtes ({area:2255}) : elles vous font passer au niveau 56.",
	-- ["grind on {npc:7440} at {area:2244}, {zone:1452}"] = "tuez des {npc:7440} au {area:2244}, {zone:1452}",
	-- ["{area:2255} is the goblin town on the east side of the valley."] = "{area:2255} est la ville gobeline à l'est de la vallée.",
	-- ["{item:12771}, a rare drop from the Winterfall furbolgs"] = "{item:12771}, un butin rare des furbolgs Tombe-hiver",
	-- ["{npc:10307}, beside him"] = "{npc:10307}, à côté de lui",
	-- ["{npc:11556} stands by the {area:618} exit of {area:1769}'s tunnel, north of the hot springs."] = "{npc:11556} se tient à la sortie du tunnel de {area:1769} côté {area:618}, au nord des sources chaudes.",
	-- ["{npc:11556} stands by the {zone:1452} exit of {area:1769}'s tunnel, north of the hot springs."] = "{npc:11556} se tient à la sortie vers {zone:1452} du tunnel du {area:1769}, au nord des sources chaudes.",
	-- ["{npc:11754} walks around {area:2255}: look inside the circle on the map"] = "{npc:11754} se promène autour de {area:2255} : cherchez dans le cercle sur la carte",
	-- ["{npc:7440} on the way"] = "{npc:7440} en chemin",
	-- ["{npc:7450} on the way"] = "{npc:7450} en chemin",
	-- ["{npc:7451} on the way"] = "{npc:7451} en chemin",
	-- ["{npc:9087} buys {item:11040} grown from your {quest:3761}."] = "{npc:9087} achète la {item:11040} cultivée à partir de votre {quest:3761}.",
	-- ["{npc:9087} buys {item:11040} grown from your {quest:3761}.\nCareful: Gorishi Workers and Stingers cast {spell:8137}, and Hive Guards cast {spell:14120}. When a Worker drops to 45% health, it has a 50% chance to call for help from mobs within 25 yd."] = "{npc:9087} achète le {item:11040} cultivé à partir de votre {quest:3761}.\nAttention : les Ouvriers et Dards Gorishi lancent {spell:8137}, et les Gardes de la ruche lancent {spell:14120}. Quand un Ouvrier tombe à 45 % de vie, il a 50 % de chances d'appeler à l'aide les monstres à moins de 25 m.",
	-- ["{npc:9298} camps among the steaming pools of {area:2246}, in the west of the valley."] = "{npc:9298} campe parmi les bassins fumants des {area:2246}, à l'ouest de la vallée.",
}
