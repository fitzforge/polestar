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
	["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "{npc:11556} se tient à la sortie vers {zone:1452} du tunnel du {area:1769}, juste à la sortie.",

	-- Step 3: Donova Snowden
	-- {npc:9298} Donova Snowden · {area:2246} Frostfire Hot Springs
	["Ride south from the tunnel: {npc:9298} camps among the steaming pools of {area:2246}, in the west of the valley."] = "Chevauchez vers le sud depuis le tunnel : {npc:9298} campe parmi les bassins fumants des {area:2246}, à l'ouest de la vallée.",
	["Linken's letter"] = "La lettre de Linken",
	-- {quest:980} The New Springs
	["{quest:980}, from Krakle in Un'Goro"] = "",
	-- {quest:3909} The Videre Elixir · {npc:7775} Gregan Brewspewer · {zone:1444} Feralas · {npc:9298} Donova Snowden · {area:2256} Darkwhisper Gorge · {zone:1452} Winterspring
	["{quest:3909} comes from {npc:7775} in {zone:1444}, later in this guide. {npc:9298}'s next errand, Strange Sources, is at the mouth of {area:2256} among level 59-60 elites: it waits for the last guide's {zone:1452} loop."] = "",

	-- Step 4: Winterspring
	-- {area:2251} Lake Kel'Theril · {area:2255} Everlook · {npc:9298} Donova Snowden
	["Ride east along the road past {area:2251} to {area:2255} first: its yeti and chimaera errands bring you about a quarter of a level, which the Frostfire furbolg camps want; {npc:9298}'s camps come on the ride back west."] = "",

	-- Step 5: Everlook
	-- {area:2255} Everlook
	["{area:2255} is the goblin town on the east side of the valley, past the owlbeast hills."] = "{area:2255} est la ville gobeline à l'est de la vallée, après les collines des chouettes-ours.",
	["Gregor's quests lead to other zones: keep them."] = "Les quêtes de Gregor mènent à d'autres zones : gardez-les.",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}, inside"] = "{npc:10431}, à l'intérieur",

	-- Step 6: Ice Thistle yetis
	["Ice Thistle yetis"] = "Yétis Chardon de glace",
	-- {area:2255} Everlook
	-- plural, as words: Ice Thistle Yetis = {npc:7458} Ice Thistle Yeti
	["The yeti hills start just south-east of {area:2255}. Every yeti drops fur. Careful: the Ice Thistle Yetis are 55-56: take the 55s one at a time, and leave the Matriarchs and Patriarchs (56-58), whose horns come on a later visit."] = "",

	-- Step 7: Chillwind chimaeras
	["Chillwind chimaeras"] = "Chimères Frisevent",
	-- {area:2255} Everlook · {area:2251} Lake Kel'Theril · {area:2245} Mazthoril
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera · Fledgling Chillwinds = {npc:7447} Fledgling Chillwind
	["The chimaeras roam the snowfields south and west of {area:2255}. Careful: Chillwind Chimaeras are 55-57: take only the 55s, and the Fledgling Chillwinds (53-55) by {area:2251}, which carry the horns too. Stay clear of {area:2245}'s cave: its blue dragonkin are elite."] = "",

	-- Step 8: Everlook
	-- {zone:1423} Eastern Plaguelands · {area:2255} Everlook
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	-- was: ["Umi: keep it, the Pristine Yeti Horns come on the {zone:1423} guide's {area:2255} stop at about 57"] = "Umi : gardez-la, les Cornes de yéti en parfait état se font lors de l'arrêt à {area:2255} du Guide {zone:1423}, vers le niveau 57"
	["Umi: keep it, the Pristine Yeti Horns come on the {zone:1423} guide's {area:2255} stop at about 56"] = "",
	["The Matriarchs and Patriarchs that carry Umi's horns are 56-58: leave them for that later stop."] = "Les Matriarches et Patriarches qui portent les cornes d'Umi sont de niveau 56-58 : laissez-les pour cet arrêt ultérieur.",

	-- Step 9: Raging Owlbeasts
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["Raging Owlbeasts"] = "Chouettards enragés ({npc:7451})",
	-- {area:2251} Lake Kel'Theril · {area:2255} Everlook · {area:2246} Frostfire Hot Springs
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	-- was: ["Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2246} and {area:2255}. Careful: the biggest are level 56: pull them one at a time."] = "Les Chouettards enragés parcourent les collines au nord du {area:2251}, près de la route entre {area:2246} et {area:2255}. Attention : les plus gros sont de niveau 56 : attirez-les un par un."
	["Ride back west: Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2255} and {area:2246}. Careful: the biggest are level 56: pull them one at a time."] = "",

	-- Step 10: Frostfire Hot Springs: kill these as you meet them
	-- {area:2246} Frostfire Hot Springs
	["{area:2246}: kill these as you meet them"] = "{area:2246} : tuez-les au passage",
	-- {item:14047} Runecloth
	-- plural, as words: Ragged Owlbeasts = {npc:7450} Ragged Owlbeast
	-- was: ["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh.\nCareful: the Den Watchers reach 56: pull one at a time and keep clear of the camps' totems."] = "Guides, Protecteurs et Totémiques se partagent les camps de furbolgs autour des sources chaudes ; des Chouettards éreintés parcourent les pentes entre eux. Tuez d'abord les Totémiques. Gardez chaque {item:14047} ramassée pour Meilosh.\nAttention : les Protecteurs vont jusqu'au niveau 56 : attirez-les un par un et tenez-vous à l'écart des totems des camps."
	["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh.\nCareful: the Den Watchers are 55-56: pull the 55s, one at a time, and keep clear of the camps' totems."] = "",
	-- {item:12771} Empty Firewater Flask
	["{item:12771}: about one Winterfall furbolg in ten carries one; keep killing them until it drops"] = "{item:12771} : environ un furbolg Tombe-hiver sur dix en porte une ; continuez à les tuer jusqu'à ce qu'elle tombe",
	-- {quest:8471} Winterfall Ritual Totem
	["{quest:8471}, a rare drop from the Winterfall furbolgs"] = "{quest:8471}, un butin rare des furbolgs Tombe-hiver",

	-- Step 11: Donova Snowden
	-- {quest:5084} Falling to Corruption · {object:176091} Deadwood Cauldron · {zone:1448} Felwood
	["{quest:5084} is turned in at the {object:176091} in {zone:1448}, on a later trip."] = "{quest:5084} se rend au {object:176091} en {zone:1448}, lors d'un voyage ultérieur.",

	-- Step 12: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "Prendre un vol pour {area:431}",
	-- {zone:1448} Felwood · {area:2255} Everlook · {area:431} Splintertree Post · {area:1237} Valormok
	["{zone:1448}'s southern hand-ins are next: ride back east to {area:2255}'s flight master, fly to {area:431} (by way of {area:1237}) and ride north into {zone:1448}, so the forest is ridden once, south to north."] = "",
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "Maître de vol de {area:2255}",

	-- Step 13: Overlord Ror
	-- {zone:1448} Felwood · {area:1761} Deadwood Village
	["Ride north-west along the road into {zone:1448}. Ror stands at the far south end of {area:1761}, just inside the border."] = "",

	-- Step 14: Emerald Sanctuary
	["North to the druids' camp."] = "",
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, on the west side of the Sanctuary"] = "{npc:9529}, à l'ouest du Sanctuaire",
	-- {quest:5158} Seeking Spiritual Aid · {npc:5901} Islen Waterseer · {area:392} Ratchet
	["Keep {quest:5158}: {npc:5901} is by {area:392}, on the next guide."] = "",

	-- Step 15: The Jadefire moonwell
	["The Jadefire moonwell"] = "Le puits de lune des Jadefeu",
	-- {area:1763} Jaedenar · {npc:9996} Winna Hazzard
	["Ride north-west past {area:1763} to the corrupted moonwell of the Jadefire satyrs and fill {npc:9996}'s flasket there."] = "",

	-- Step 16: Bloodvenom Post
	-- {area:1997} Bloodvenom Post
	["North up the road to {area:1997}."] = "",
	-- {npc:9996} Winna Hazzard · {quest:86612} Stag Lord's Bauble
	["{npc:9996}: the {quest:86612}"] = "{npc:9996} : {quest:86612}",
	-- {npc:10306} Trull Failbane · {zone:1452} Winterspring · {zone:1423} Eastern Plaguelands
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["{npc:10306}'s Moontouched Owlbeasts are 57-58, in {zone:1452}: keep it for the {zone:1423} guide's {zone:1452} stop."] = "",

	-- Step 17: Winna Hazzard's kitten
	-- {npc:9996} Winna Hazzard
	["{npc:9996}'s kitten"] = "Le chaton de {npc:9996}",
	-- {item:12565} Winna's Kitten Carrier · {npc:10042} Corrupted Saber · {npc:9996} Winna Hazzard
	["Take the kitten back to the Jadefire moonwell and release it there with {item:12565}; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "",
	-- {item:12565} Winna's Kitten Carrier
	["{item:12565}, at the Jadefire moonwell"] = "{item:12565}, au puits de lune des Jadefeu",

	-- Step 19: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Volez jusqu'au {area:1099}",
	-- {area:1997} Bloodvenom Post
	["{area:1997} flight master"] = "",

	-- Step 21: Evoroot
	-- {item:11242} Evoroot · {npc:7775} Gregan Brewspewer · {area:1114} Ruins of Ravenwind
	["The {item:11242} grows inside a ruined building north of {npc:7775}'s camp, east of the harpies' {area:1114}: climb in through the broken part of its wall."] = "La {item:11242} pousse dans un bâtiment en ruine au nord du camp de {npc:7775}, à l'est de {area:1114} des harpies : entrez par la partie effondrée de son mur.",

	-- Step 22: The Videre Elixir
	-- {npc:7775} Gregan Brewspewer · {area:976} Gadgetzan
	["Back south to {npc:7775}. Keep the elixir and don't drink it yet: it kills you, and that is how you meet Gaeriyan by {area:976} later."] = "Retournez au sud voir {npc:7775}. Gardez l'élixir et ne le buvez pas encore : il vous tue, et c'est ainsi que vous rencontrerez Gaeriyan près de {area:976} plus tard.",
	-- {item:11243} Videre Elixir · {npc:7775} Gregan Brewspewer
	["{item:11243}, {npc:7775}'s reward"] = "{item:11243}, récompense de {npc:7775}",

	-- Step 24: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Volez jusqu'à {area:1638}",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "Maître de vol de {area:2408}",

	-- Step 25: Bluff Runner Windstrider
	-- {npc:10881} Bluff Runner Windstrider · {npc:14728} Rumstag Proudstrider · {area:1641} Hunter Rise
	["{npc:10881} and {npc:14728} stand on {area:1641}. Each of Rumstag's donations takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "{npc:10881} et {npc:14728} se tiennent sur {area:1641}. Chaque don de Rumstag prend soixante étoffes de laine, de soie ou de tisse-mage dans vos sacs : rendez ce que vous avez, passez le reste.",

	-- Step 26: Elder Rise
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{npc:3033} sur la {area:1639} ; {npc:246344}",
	-- {quest:1123} Rabine Saturna · {zone:1450} Moonglade
	["{quest:1123} waits in {zone:1450}: keep it for later."] = "{quest:1123} attend à {zone:1450} : gardez-la pour plus tard.",

	-- Step 27: Bashana Runetotem
	-- {npc:9087} Bashana Runetotem · {item:11040} Morrowgrain · {quest:3761} Un'Goro Soil · {quest:3782} Morrowgrain Research · {item:11020} Evergreen Pouch
	["{npc:9087} buys {item:11040} grown from your {quest:3761}. {quest:3782} wants ten, and the {item:11020} gives one try every ten minutes: take it only if you already have the grain."] = "{npc:9087} achète le {item:11040} cultivé à partir de votre {quest:3761}. {quest:3782} en demande dix, et la {item:11020} permet un essai toutes les dix minutes : ne la prenez que si vous avez déjà le grain.",

	-- Step 29: Magatha Grimtotem
	-- {npc:4046} Magatha Grimtotem · {area:1639} Elder Rise
	["{npc:4046} stands on {area:1639}."] = "",
	-- {npc:4046} Magatha Grimtotem · {zone:1447} Azshara
	["Delivery to {npc:4046}, from Jediga in {zone:1447}"] = "",
	-- {npc:4046} Magatha Grimtotem · {zone:1447} Azshara
	["{npc:4046}'s payment goes back to Jediga in {zone:1447}, which the route doesn't pass again: leave it."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any Winterfall furbolg can carry the beads; the camps just south of {npc:11556} are the closest."] = "N'importe quel furbolg Tombe-hiver peut porter les perles ; les camps juste au sud de {npc:11556} sont les plus proches.",
	-- ["Back at {area:1099}."] = "De retour au {area:1099}.",
	-- ["Back to {area:2255}"] = "Retour à {area:2255}",
	-- ["Below ground"] = "Sous terre",
	-- ["Both {item:14047} donations are handed in later in the route: save sixty {item:14047} for each if you want them."] = "Les deux dons d'{item:14047} se rendent plus loin dans le parcours : gardez soixante {item:14047} pour chacun si vous les voulez.",
	-- ["Chillwind chimaeras"] = "Chimères Noroît",
	-- ["Fly to {area:1637}"] = "Volez jusqu'à {area:1637}",
	-- ["Fly to {zone:1454}"] = "Prendre un vol pour {zone:1454}",
	-- ["Fly to {zone:1456}"] = "Prendre un vol pour {zone:1456}",
	-- ["From Krakle in Un'Goro"] = "De la part de Krakle à Un'Goro",
	-- ["Frostfire Winterfall camp"] = "Camp Tombe-hiver de Givrefeu",
	-- ["Frostfire Winterfall camps"] = "Camps Tombe-hiver de Givrefeu",
	-- ["Gregor's and Harlo's quests lead to other zones: keep them."] = "Les quêtes de Gregor et de Harlo mènent à d'autres zones : gardez-les.",
	-- ["Grind to 55"] = "Montez au niveau 55",
	-- ["He stands on {area:1641}. Each donation wants cloth from your bags; hand them in when you have it, later in the route."] = "Il se tient sur la {area:1641}. Chaque don demande de l'étoffe de vos sacs ; remettez-les quand vous l'avez, plus loin dans l'itinéraire.",
	-- ["He stands on {area:1641}. Each donation wants sixty cloth from your bags: take them if you save cloth, and hand in what you carry later in the route."] = "Il se tient sur {area:1641}. Chaque don demande soixante pièces de tissu de vos sacs : acceptez-les si vous gardez votre tissu, et rendez ce que vous avez sur vous plus loin dans le parcours.",
	-- ["In the {object:172958}."] = "Dans {object:172958}.",
	-- ["In the {object:172961}."] = "Dans {object:172961}.",
	-- ["In the {object:172961}. Each donation takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "Dans {object:172961}. Chaque don prend soixante étoffes de laine, de soie ou de tisse-mage dans vos sacs : rendez celles que vous avez sur vous, ignorez les autres.",
	-- ["Level 55.04"] = "Niveau 55.04",
	-- ["Matriarchs and Patriarchs hit hard: pull them one at a time."] = "Les Matriarches et Patriarches frappent fort : attirez-les un par un.",
	-- ["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh."] = "Guides, Protecteurs et Totémiques se partagent les camps de furbolgs autour des sources chaudes ; des Chouettards éreintés parcourent les pentes entre eux. Tuez d'abord les Totémiques. Gardez chaque {item:14047} ramassée pour Meilosh.",
	-- ["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh.\nCareful: the Den Watchers reach 56: pull one at a time and keep clear of the camps' totems."] = "Guides, Protecteurs et Totémiques se partagent les camps de furbolgs autour des sources chaudes ; des Chouettards éreintés parcourent les pentes entre eux. Tuez d'abord les Totémiques. Gardez chaque {item:14047} ramassée pour Meilosh.\nAttention : les Protecteurs vont jusqu'au niveau 56 : attirez-les un par un et tenez-vous à l'écart des totems des camps.",
	-- ["Pristine Yeti Horns"] = "Cornes de yéti en parfait état ({item:12367})",
	-- ["Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2246} and {area:2255}."] = "Les Chouettards enragés parcourent les collines au nord du {area:2251}, près de la route entre {area:2246} et {area:2255}.",
	-- ["Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2246} and {area:2255}. Careful: the biggest are level 56: pull them one at a time."] = "Les Chouettards enragés parcourent les collines au nord du {area:2251}, près de la route entre {area:2246} et {area:2255}. Attention : les plus gros sont de niveau 56 : attirez-les un par un.",
	-- ["Ride back west to {area:2246}."] = "Retournez vers l'ouest jusqu'aux {area:2246}.",
	-- ["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "Chevauchez vers l'est, puis descendez vers le sud la {area:2249}. Les Géants Cognegivre y sont des élites de niveau 59 : restez au milieu et ne vous arrêtez pas. L'étrange source se trouve à l'entrée de la {area:2256}, à l'extrémité sud.",
	-- ["Ride west along the road past {area:2251}; Raging Owlbeasts roam the hills north of it."] = "Chevauchez vers l'ouest sur la route en passant le {area:2251} ; les Chouettards enragés ({npc:7451}) parcourent les collines au nord.",
	-- ["The chimaeras roam the snowfields south and west of {area:2255}. Stay clear of {area:2245}'s cave: its blue dragonkin are elite."] = "Les chimères parcourent les champs de neige au sud et à l'ouest de {area:2255}. Évitez la grotte de {area:2245} : ses draconiens bleus sont élites.",
	-- ["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} in the cave at the back is elite: stay out."] = "Le village furbolg occupe la vallée au nord-est de {area:2255}. Tuez d'abord les Chamans ; ils soignent. {npc:10738}, dans la grotte du fond, est un élite : n'y allez pas.",
	-- ["The yeti hills start just south-east of {area:2255}. Every yeti drops fur: work the Ice Thistle Yetis (55-56) and leave the Matriarchs and Patriarchs (56-58), whose horns come on a later visit."] = "Les collines des yétis commencent juste au sud-est de {area:2255}. Chaque yéti lâche de la fourrure : tuez les Yétis Chardon de glace (55-56) et laissez les Matriarches et Patriarches (56-58), dont les cornes seront pour une visite ultérieure.",
	-- ["The yeti hills start just south-east of {area:2255}. Every yeti drops fur; only Matriarchs and Patriarchs drop horns, so keep those for after the turn-in."] = "Les collines des yétis commencent juste au sud-est de {area:2255}. Chaque yéti lâche de la fourrure ; seuls les Matriarches et Patriarches lâchent des cornes, gardez donc celles-ci pour après la remise de quête.",
	-- ["Top up here to level 55.04 before the hand-ins at {area:2255}: they take you to level 56."] = "Montez ici jusqu'au niveau 55.04 avant de rendre les quêtes ({area:2255}) : elles vous font passer au niveau 56.",
	-- ["Top up here to level 55.04 before the hand-ins at {area:2255}: they take you to level 56. The Ice Thistle Yetis (55-56) are the lowest here; the Matriarchs and Patriarchs (56-58) hit harder. Or, with a group, run the {area:1584} dungeon or the {area:1583} dungeon (Lower) instead."] = "Complétez ici jusqu'au niveau 55.04 avant de rendre les quêtes à {area:2255} : elles vous amènent au niveau 56. Les Yétis Chardon de glace (55-56) sont les plus faibles ici ; les Matriarches et les Patriarches (56-58) frappent plus fort. Ou, en groupe, faites plutôt le donjon {area:1584} ou le donjon {area:1583} (inférieur).",
	-- ["Umi's third prank targets goblins in {area:976} and Un'Goro: keep it for later."] = "La troisième farce d'Umi vise les gobelins de {area:976} et d'Un'Goro : gardez-la pour plus tard.",
	-- ["Umi: keep it, the Pristine Yeti Horns come on the {zone:1423} guide's {area:2255} stop at about 57"] = "Umi : gardez-la, les Cornes de yéti en parfait état se font lors de l'arrêt à {area:2255} du Guide {zone:1423}, vers le niveau 57",
	-- ["grind on {npc:7440} at {area:2244}, {zone:1452}"] = "tuez des {npc:7440} au {area:2244}, {zone:1452}",
	-- ["grind on {npc:7458}"] = "tuez en boucle : {npc:7458}",
	-- ["{item:12771}, a rare drop from the Winterfall furbolgs"] = "{item:12771}, un butin rare des furbolgs Tombe-hiver",
	-- ["{npc:10307}, beside him"] = "{npc:10307}, à côté de lui",
	-- ["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118} : le guide précédent vous lie ici, cette étape se coche donc généralement aussitôt",
	-- ["{npc:11556} stands by the {area:618} exit of {area:1769}'s tunnel, north of the hot springs."] = "{npc:11556} se tient à la sortie du tunnel de {area:1769} côté {area:618}, au nord des sources chaudes.",
	-- ["{npc:11754} walks around {area:2255}: look inside the circle on the map"] = "{npc:11754} se promène autour de {area:2255} : cherchez dans le cercle sur la carte",
	-- ["{npc:7440} on the way"] = "{npc:7440} en chemin",
	-- ["{npc:7450} on the way"] = "{npc:7450} en chemin",
	-- ["{npc:7451} on the way"] = "{npc:7451} en chemin",
	-- ["{npc:7775}, a dwarf, camps in the {area:1137} north-west of {area:1099}. He brews the {item:11243} only from an {item:11242} you bring him."] = "{npc:7775}, un nain, campe dans les {area:1137} au nord-ouest du {area:1099}. Il ne prépare l'{item:11243} qu'à partir d'une {item:11242} que vous lui apportez.",
	-- ["{npc:7775}, a dwarf, camps in the {area:1137} north-west of {area:1099}; he has the elixir."] = "{npc:7775}, un nain, campe dans les {area:1137} au nord-ouest du {area:1099} ; il a l'élixir.",
	-- ["{npc:9087} buys {item:11040} grown from your {quest:3761}."] = "{npc:9087} achète la {item:11040} cultivée à partir de votre {quest:3761}.",
	-- ["{npc:9087} buys {item:11040} grown from your {quest:3761}.\nCareful: Gorishi Workers and Stingers cast {spell:8137}, and Hive Guards cast {spell:14120}. When a Worker drops to 45% health, it has a 50% chance to call for help from mobs within 25 yd."] = "{npc:9087} achète le {item:11040} cultivé à partir de votre {quest:3761}.\nAttention : les Ouvriers et Dards Gorishi lancent {spell:8137}, et les Gardes de la ruche lancent {spell:14120}. Quand un Ouvrier tombe à 45 % de vie, il a 50 % de chances d'appeler à l'aide les monstres à moins de 25 m.",
	-- ["{quest:3909} comes from {npc:7775} in {zone:1444}, later in this guide."] = "{quest:3909} vient de {npc:7775} en {zone:1444}, plus loin dans ce guide.",
	-- ["{zone:1456} flight master"] = "Maître de vol : {zone:1456}",
}
