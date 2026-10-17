-- French (frFR): the guide forever/horde/50-60/03-winterspring (forever/horde/50-60/03-winterspring.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Everlook
	-- {area:2255} Everlook
	["{area:2255} is the goblin town on the east side of the valley."] = "{area:2255} est la ville gobeline à l'est de la vallée.",
	["Gregor's and Harlo's quests lead to other zones: keep them."] = "Les quêtes de Gregor et de Harlo mènent à d'autres zones : gardez-les.",

	-- Step 2: Ice Thistle yetis
	["Ice Thistle yetis"] = "Yétis Chardon de glace",
	-- {area:2255} Everlook
	["The yeti hills start just south-east of {area:2255}. Every yeti drops fur; only Matriarchs and Patriarchs drop horns, so keep those for after the turn-in."] = "Les collines des yétis commencent juste au sud-est de {area:2255}. Chaque yéti lâche de la fourrure ; seuls les Matriarches et Patriarches lâchent des cornes, gardez donc celles-ci pour après la remise de quête.",

	-- Step 4: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "Cornes de yéti en parfait état ({item:12367})",
	["Matriarchs and Patriarchs hit hard: pull them one at a time."] = "Les Matriarches et Patriarches frappent fort : attirez-les un par un.",

	-- Step 5: Umi Rumplesnicker
	-- {area:976} Gadgetzan
	["Umi's third prank targets goblins in {area:976} and Un'Goro: keep it for later."] = "La troisième farce d'Umi vise les gobelins de {area:976} et d'Un'Goro : gardez-la pour plus tard.",

	-- Step 6: Chillwind chimaeras
	["Chillwind chimaeras"] = "Chimères Noroît",
	-- {area:2255} Everlook · {area:2245} Mazthoril
	["The chimaeras roam the snowfields south and west of {area:2255}. Stay clear of {area:2245}'s cave: its blue dragonkin are elite."] = "Les chimères parcourent les champs de neige au sud et à l'ouest de {area:2255}. Évitez la grotte de {area:2245} : ses draconiens bleus sont des élites.",

	-- Step 8: Raging Owlbeasts
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["Raging Owlbeasts"] = "Chouettards enragés ({npc:7451})",
	-- {area:2251} Lake Kel'Theril
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["Ride west along the road past {area:2251}; Raging Owlbeasts roam the hills north of it."] = "Chevauchez vers l'ouest sur la route en passant le {area:2251} ; les Chouettards enragés ({npc:7451}) parcourent les collines au nord.",

	-- Step 9: Donova Snowden
	-- {npc:9298} Donova Snowden · {area:2246} Frostfire Hot Springs
	["{npc:9298} camps among the steaming pools of {area:2246}, in the west of the valley."] = "{npc:9298} campe parmi les bassins fumants des {area:2246}, à l'ouest de la vallée.",
	["From Krakle in Un'Goro"] = "De la part de Krakle à Un'Goro",
	["Linken's letter"] = "La lettre de Linken",
	-- {quest:3909} The Videre Elixir · {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["{quest:3909} comes from {npc:7775} in {zone:1444}, later in this guide."] = "{quest:3909} vient de {npc:7775} en {zone:1444}, plus loin dans ce guide.",

	-- Step 10: Salfa
	-- {npc:11556} Salfa · {zone:1452} Winterspring · {area:1769} Timbermaw Hold
	["{npc:11556} stands by the {zone:1452} exit of {area:1769}'s tunnel, north of the hot springs."] = "{npc:11556} se tient à la sortie vers {zone:1452} du tunnel du {area:1769}, au nord des sources chaudes.",

	-- Step 11: Frostfire Winterfall camps
	["Frostfire Winterfall camps"] = "Camps Tombe-hiver de Givrefeu",
	-- {item:14047} Runecloth
	-- plural, as words: Ragged Owlbeasts = {npc:7450} Ragged Owlbeast
	["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh."] = "Guides, Protecteurs et Totémiques se partagent les camps de furbolgs autour des sources chaudes ; des Chouettards éreintés ({npc:7450}) parcourent les pentes entre eux. Tuez d'abord les Totémiques. Gardez chaque {item:14047} ramassée pour Meilosh.",
	-- {item:12771} Empty Firewater Flask
	["{item:12771}, a rare drop from the Winterfall furbolgs"] = "{item:12771}, un butin rare des furbolgs Tombe-hiver",
	-- {quest:8471} Winterfall Ritual Totem
	["{quest:8471}, a rare drop from the Winterfall furbolgs"] = "{quest:8471}, un butin rare des furbolgs Tombe-hiver",

	-- Step 12: Donova Snowden
	-- {quest:5084} Falling to Corruption · {object:176091} Deadwood Cauldron · {zone:1448} Felwood
	["{quest:5084} is turned in at the {object:176091} in {zone:1448}, on a later trip."] = "{quest:5084} se rend au {object:176091} en {zone:1448}, lors d'un voyage ultérieur.",

	-- Step 13: Darkwhisper Gorge
	-- {area:2249} Frostwhisper Gorge · {area:2256} Darkwhisper Gorge
	["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "Chevauchez vers l'est, puis descendez vers le sud la {area:2249}. Les Géants Cognegivre y sont des élites de niveau 59 : restez au milieu et ne vous arrêtez pas. L'étrange source se trouve à l'entrée de la {area:2256}, à l'extrémité sud.",

	-- Step 14: Winterfall Village
	-- {area:2255} Everlook · {npc:10738} High Chief Winterfall
	["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} in the cave at the back is elite: stay out."] = "Le village furbolg occupe la vallée au nord-est de {area:2255}. Tuez d'abord les Chamans ; ils soignent. {npc:10738}, dans la grotte du fond, est un élite : n'y allez pas.",

	-- Step 15: Donova Snowden
	-- {area:2246} Frostfire Hot Springs
	["Ride back west to {area:2246}."] = "Retournez vers l'ouest jusqu'aux {area:2246}.",

	-- Step 17: Beads for Salfa
	-- {npc:11556} Salfa
	["Any Winterfall furbolg can carry the beads; the camps just south of {npc:11556} are the closest."] = "N'importe quel furbolg Tombe-hiver peut porter les perles ; les camps juste au sud de {npc:11556} sont les plus proches.",
	["Frostfire Winterfall camp"] = "Camp Tombe-hiver de Givrefeu",

	-- Step 19: Back to Everlook
	-- {area:2255} Everlook
	["Back to {area:2255}"] = "Retour à {area:2255}",

	-- Step 20: Grind to 55
	["Grind to 55"] = "Montez au niveau 55",
	-- {npc:7440} Winterfall Den Watcher · {area:2244} Winterfall Village · {zone:1452} Winterspring
	["grind on {npc:7440} at {area:2244}, {zone:1452}"] = "tuez des {npc:7440} au {area:2244}, {zone:1452}",

	-- Step 21: A Little Luck
	-- {npc:10307} Witch Doctor Mau'ari
	["{npc:10307}, beside him"] = "{npc:10307}, à côté de lui",

	-- Step 22: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Volez jusqu'au {area:1099}",

	-- Step 23: The Videre Elixir
	-- {npc:7775} Gregan Brewspewer · {area:1137} Lower Wilds · {area:1099} Camp Mojache
	["{npc:7775}, a dwarf, camps in the {area:1137} north-west of {area:1099}; he has the elixir."] = "{npc:7775}, un nain, campe dans les {area:1137} au nord-ouest du {area:1099} ; il a l'élixir.",

	-- Step 24: Talo Thornhoof
	-- {area:1099} Camp Mojache
	["Back at {area:1099}."] = "De retour au {area:1099}.",

	-- Step 25: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Volez jusqu'à {area:1638}",

	-- Step 26: Rumstag Proudstrider
	-- {area:1641} Hunter Rise
	["He stands on {area:1641}. Each donation wants cloth from your bags; hand them in when you have it, later in the route."] = "Il se tient sur la {area:1641}. Chaque don demande de l'étoffe de vos sacs ; remettez-les quand vous l'avez, plus loin dans l'itinéraire.",

	-- Step 28: Elder Rise
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{npc:3033} sur la {area:1639} ; {npc:246344}",
	-- {quest:1123} Rabine Saturna · {zone:1450} Moonglade
	["{quest:1123} waits in {zone:1450}: keep it for later."] = "{quest:1123} attend à {zone:1450} : gardez-la pour plus tard.",

	-- Step 29: Bashana Runetotem
	-- {npc:9087} Bashana Runetotem · {item:11040} Morrowgrain · {quest:3761} Un'Goro Soil
	["{npc:9087} buys {item:11040} grown from your {quest:3761}."] = "{npc:9087} achète la {item:11040} cultivée à partir de votre {quest:3761}.",

	-- Step 30: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Volez jusqu'à {area:1637}",

	-- Step 31: Vehena
	-- {object:172961} Valley of Spirits
	["In the {object:172961}."] = "Dans {object:172961}.",

	-- Step 32: Rashona Straglash
	-- {object:172958} Valley of Honor
	["In the {object:172958}."] = "Dans {object:172958}.",
}
