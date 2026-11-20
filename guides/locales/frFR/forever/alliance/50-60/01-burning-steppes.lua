-- French (frFR): the guide forever/alliance/50-60/01-burning-steppes (forever/alliance/50-60/01-burning-steppes.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Azshara
	-- {zone:1447} Azshara
	["Into {zone:1447}"] = "Vers {zone:1447}",
	-- {area:415} Astranaar · {area:2358} Forest Song · {zone:1447} Azshara · {area:1235} Shadowsong Shrine
	["From {area:415}, ride east along the road past {area:2358} into {zone:1447}: {area:1235} lies just over the border, in {zone:1447}'s south-west corner."] = "Depuis {area:415}, chevauchez vers l'est le long de la route après {area:2358} jusqu'en {zone:1447} : {area:1235} se trouve juste après la frontière, dans le coin sud-ouest d'{zone:1447}.",
	-- {area:1235} Shadowsong Shrine
	["East along the road to {area:1235}"] = "Vers l'est par la route jusqu'à {area:1235}",

	-- Step 2: Shadowsong Shrine
	-- {zone:1447} Azshara · {area:3137} Talrendis Point
	["The shrine lies in the south-west corner of {zone:1447}, south of {area:3137}."] = "Le Sanctuaire de Shadowsong se trouve dans le coin sud-ouest d'{zone:1447}, au sud de {area:3137}.",

	-- Step 3: Talrendis Point
	-- {npc:239822} Commander Truesong · {npc:240482} Berdun Cliffbrew · {area:3137} Talrendis Point
	["Just north-east of the shrine: {npc:239822} and {npc:240482} keep the Alliance camp at {area:3137}."] = "Juste au nord-est du sanctuaire : {npc:239822} et {npc:240482} tiennent le camp de l'Alliance de {area:3137}.",

	-- Step 4: Shadowsong Shrine spirits
	-- {area:1235} Shadowsong Shrine
	["{area:1235} spirits"] = "",
	-- {area:3137} Talrendis Point · {area:1235} Shadowsong Shrine
	-- plural, as words: Highborne Apparitions = {npc:6116} Highborne Apparition
	["Ride south-west from {area:3137}. Kill the Highborne Apparitions and Lichlings in the ruins around {area:1235}."] = "",

	-- Step 5: Mosshoof Runners
	-- plural, as words: Mosshoof Runners = {npc:8759} Mosshoof Runner
	["Mosshoof Runners"] = "Coureurs Sabots-de-mousse",
	-- {area:3137} Talrendis Point
	-- plural, as words: Mosshoof Runners = {npc:8759} Mosshoof Runner
	["The Mosshoof Runners (45-47) graze the hills north of {area:3137}, on the way to the satyrs."] = "Les Coureurs Sabots-de-mousse (45-47) paissent dans les collines au nord de {area:3137}, sur le chemin des satyres.",

	-- Step 6: Azshara: kill these as you meet them
	-- {zone:1447} Azshara
	["{zone:1447}: kill these as you meet them"] = "{zone:1447} : tuez-les au passage",
	-- {npc:222478} Sentinel Keldara Sunblade
	["The Haldarr satyrs hold the camp north of the shrine. {npc:222478} is held in their camp: free her and walk her out."] = "",
	-- {npc:222478} Sentinel Keldara Sunblade
	["{npc:222478}, in the camp"] = "{npc:222478}, dans le camp",
	["Help her escape the camp"] = "Aidez-la à s'échapper du camp",

	-- Step 7: The western shore
	["The western shore"] = "La rive ouest",
	-- plural, as words: Spitelash Warriors = {npc:6190} Spitelash Warrior
	["The Spitelash Warriors (46-47) and Screamers (47-48) hold the western shore north-east of the satyrs."] = "Les Guerriers (46-47) et Hurleurs (47-48) Fouette-bile tiennent la rive ouest, au nord-est des satyres.",

	-- Step 8: Talrendis Point
	-- {area:3137} Talrendis Point
	["Back south-west to {area:3137}."] = "Retournez au sud-ouest à {area:3137}.",
	-- {npc:239822} Commander Truesong · {quest:88809} Preserving Eldarath
	["{npc:239822}: {quest:88809}, the relics drop from the naga of the top-up ahead"] = "{npc:239822} : {quest:88809}, les reliques tombent sur les nagas de la session d'XP suivante",
	-- {npc:239822} Commander Truesong · {quest:92345} Beneath Nordrassil · {npc:4217} Mathrengyl Bearwalker · {zone:1457} Darnassus
	["{npc:239822}: {quest:92345}, for {npc:4217} in {zone:1457}, keep it"] = "{npc:239822} : {quest:92345}, pour {npc:4217} à {zone:1457}, gardez-la",

	-- Step 12: Wild honey
	["Wild honey"] = "",
	-- {npc:240482} Berdun Cliffbrew · {item:238501} Pellet Gun · {item:238503} Wild Honey · {area:1237} Valormok
	-- plural, as words: Honey Wasps = {npc:236028} Honey Wasp
	["Shoot a nest with {npc:240482}'s {item:238501}, then loot the Honey Wasps for {item:238503}. Work north through the trees toward Eldarath, away from {area:1237}."] = "",

	-- Step 14: Ogtinc
	-- {npc:8405} Ogtinc · {area:1224} Bear's Head
	["Ride north-east from the shrine: {npc:8405} camps at the {area:1224}, in the hills above the road."] = "Chevauchez vers le nord-est depuis le sanctuaire : {npc:8405} campe à {area:1224}, dans les collines au-dessus de la route.",

	-- Step 15: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo · {npc:8379} Archmage Xylem
	["Get off your mount before you talk to {npc:8395}: he teleports you up to {npc:8379}'s tower on the cliff above his camp."] = "Descendez de monture avant de parler à {npc:8395} : il vous téléporte à la tour de {npc:8379}, sur la falaise au-dessus de son camp.",

	-- Step 16: Archmage Xylem
	["The apprentice at the top of the tower sends you back down."] = "L'apprenti en haut de la tour vous renvoie en bas.",
	-- {area:1220} Thalassian Base Camp · {npc:8420} Kim'jael
	["The blood elves are at the {area:1220}, on the way to {npc:8420}"] = "Les elfes de sang sont au {area:1220}, sur le chemin de {npc:8420}",

	-- Step 17: The Ruins of Eldarath
	-- {area:1221} Ruins of Eldarath
	["The {area:1221}"] = "{area:1221}",
	-- {area:1221} Ruins of Eldarath · {item:13815} Some Rune · {npc:8507} Tymor · {item:10445} Drawing Kit
	["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s runes stand among the ruins: use his {item:10445} on each. The naga here are the ones the top-up below asks for, so these kills count towards it."] = "Les nagas Fouette-bile de {area:1221} portent {item:13815}. Les runes de {npc:8507} se dressent parmi les ruines : utilisez son {item:10445} sur chacune. Ces nagas sont ceux que demande la montée de niveau ci-dessous, donc ces victimes comptent pour elle.",

	-- Step 18: Level 51.3 on the way north
	["Level 51.3 on the way north"] = "Niveau 51.3 en route vers le nord",
	-- {npc:8395} Sanath Lim-yo · {npc:8420} Kim'jael · {area:1417} Sunken Temple
	-- plural, as words: Spitelash Myrmidons = {npc:6196} Spitelash Myrmidon
	["Top up to level 51.3 on the Spitelash Myrmidons (50-51) of the ruins between {npc:8395}'s camp and the north: the blood elves at {npc:8420}'s camp are 51-53. Or, with a group, run the {area:1417} dungeon instead."] = "Montez jusqu'au niveau 51.3 sur les Myrmidons Fouette-bile (50-51) des ruines entre le camp de {npc:8395} et le nord : les elfes de sang du camp de {npc:8420} sont 51-53. Ou, en groupe, faites plutôt le donjon {area:1417}.",
	-- {npc:6196} Spitelash Myrmidon
	["grind on {npc:6196}"] = "tuez en boucle : {npc:6196}",

	-- Step 19: Lord Sarthiss
	-- {npc:239939} Lord Sarthiss
	-- plural, as words: Eldarath Relics = {item:280608} Eldarath Relic
	["The Spitelash naga of these ruins drop Truesong's Eldarath Relics, top-up or not. {npc:239939} (52) stands in the ruins of Eldarath, south-west of the Myrmidons: pull him alone."] = "Les nagas Fouette-bile de ces ruines laissent tomber les Reliques d'Eldarath de Chant-vrai, montée de niveau ou non. {npc:239939} (52) se tient dans les ruines d'Eldarath, au sud-ouest des Myrmidons : attirez-le seul.",

	-- Step 20: Ekkal
	-- {npc:235903} Ekkal · {npc:8420} Kim'jael
	["{npc:235903} camps by the road north to {npc:8420}: his satyrs are in {npc:8420}'s camp."] = "{npc:235903} campe au bord de la route qui mène au nord vers {npc:8420} : ses satyres sont dans le camp de {npc:8420}.",

	-- Step 21: Mosshoof Coursers
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers"] = "Coursiers Sabots-de-mousse",
	-- {area:1224} Bear's Head · {area:1219} Legashi Encampment
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south.\nCareful: the Mosshoof Coursers are 52-53, a level or two over you here: pull them one at a time from the herd's edge."] = "Les Coursiers Sabots-de-mousse les plus proches paissent dans les collines au nord-est de {area:1224}, vers {area:1219} ; un troupeau plus grand parcourt les terres dégagées au sud.\nAttention : les Coursiers Sabots-de-mousse sont 52-53, un ou deux niveaux au-dessus de vous ici : attirez-les un par un depuis le bord du troupeau.",

	-- Step 24: Kim'jael
	-- {npc:8420} Kim'jael · {area:1219} Legashi Encampment · {area:1220} Thalassian Base Camp · {npc:6647} Magister Hawkhelm · {npc:235903} Ekkal
	-- plural, as words: Blood Elf Surveyors = {npc:6198} Blood Elf Surveyor · Legashi Soulstealers = {npc:236867} Legashi Soulstealer
	["{npc:8420} camps at the {area:1219} in the north; his equipment lies all over the {area:1220} just south-east of him.\nCareful: the Blood Elf Surveyors are 51-52 and the Reclaimers 52-53, with {npc:6647} (53) among them: take the equipment from the camp's edge and pull the elves one at a time.\n{npc:235903}'s satyrs, rogues and hellcallers (51-53) are the Legashi around {npc:8420}'s camp; the Legashi Soulstealers, Hellraisers and Blackguards (53) further east are not part of it: stay west of them."] = "{npc:8420} campe à {area:1219} au nord ; son équipement est éparpillé dans {area:1220}, juste au sud-est de lui.\nAttention : les Géomètres elfes de sang sont 51-52 et les Reconquérants 52-53, avec {npc:6647} (53) parmi eux : prenez l'équipement depuis le bord du camp et attirez les elfes un par un.\nLes satyres, voleurs et invocateurs infernaux de {npc:235903} (51-53) sont les Legashi autour du camp de {npc:8420} ; les Voleurs d'âme, Fléaux infernaux et Gardes noirs Legashi (53) plus à l'est n'en font pas partie : restez à l'ouest d'eux.",
	-- {item:20028} Glittering Dust
	["{item:20028}, from the blood elf surveyors and reclaimers"] = "{item:20028}, sur les géomètres et les vengeurs elfes de sang",

	-- Step 27: Ekkal
	-- {npc:235903} Ekkal
	["On the road back south, {npc:235903} takes the satyrs."] = "Sur la route du retour vers le sud, {npc:235903} prend les satyres.",

	-- Step 28: Rubbing: Rune of Sael'hai
	-- {item:7972} Ichor of Undeath · {npc:7864} Lingering Highborne
	["{item:7972}: the {npc:7864}, about 10%"] = "{item:7972} : les {npc:7864}, environ 10 %",

	-- Step 29: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo
	["Ride back west to {npc:8395}'s camp and get off your mount: he teleports you up to Xylem again."] = "Revenez vers l'ouest jusqu'au camp de {npc:8395} et descendez de monture : il vous téléporte de nouveau auprès de Xylem.",

	-- Step 31: The Temple of Zin-Malor
	-- {area:1223} Temple of Zin-Malor
	["The {area:1223}"] = "Le {area:1223}",
	-- {area:1223} Temple of Zin-Malor · {npc:8395} Sanath Lim-yo
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren
	["The Spitelash Sirens wander the ruins and the beach around the {area:1223}, just south of {npc:8395}. Only the Sirens carry the coral, not the Screamers."] = "Les Sirènes Fouette-bile errent dans les ruines et sur la plage autour du {area:1223}, juste au sud de {npc:8395}. Seules les Sirènes portent le corail, pas les Screamers.",

	-- Step 32: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo
	["Back up through {npc:8395}'s teleport."] = "Remontez par le téléporteur de {npc:8395}.",
	-- {area:1417} Sunken Temple
	["Xylem's last task, Destroy Morphaz, is in the {area:1417}: skip it."] = "La dernière tâche de Xylem, Détruire Morphaz, se trouve dans le {area:1417} : passez-la.",

	-- Step 34: Ravencrest Monument
	-- {zone:1447} Azshara · {npc:8392} Pilot Xiggs Fuselighter · {item:10444} Standard Issue Flare Gun
	["Swim to the small island off the southern tip of {zone:1447}. If {npc:8392} isn't there, fire your {item:10444} to signal him, and wait for him to land."] = "Nagez jusqu'au petit îlot au large de la pointe sud d'{zone:1447}. Si {npc:8392} n'est pas là, tirez avec votre {item:10444} pour lui faire signe, et attendez qu'il atterrisse.",

	-- Step 35: Talrendis Point
	-- {area:3137} Talrendis Point
	["Back to Truesong at {area:3137} before you hearth."] = "Retournez voir Chant-vrai à {area:3137} avant d'utiliser votre Pierre de foyer.",

	-- Step 37: To Ironforge
	-- {zone:1455} Ironforge
	["To {zone:1455}"] = "Vers {zone:1455}",
	-- {zone:1455} Ironforge · {zone:1425} Hinterlands
	["Your Hearthstone is set at {zone:1455} (the {zone:1425} guide binds it there): hearth back to the inn."] = "Votre Pierre de foyer est liée à {zone:1455} (le guide des {zone:1425} l'y lie) : utilisez-la pour retourner à l'auberge.",
	-- {zone:1455} Ironforge
	["{zone:1455} inn"] = "Auberge de {zone:1455}",

	-- Step 39: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}."] = "Archesonus se tient à côté du roi Magni dans {object:171709}.",

	-- Step 40: Royal Historian Archesonus
	-- {quest:3701} The Smoldering Ruins of Thaurissan · {npc:8978} Thauris Balgarr · {zone:1428} Burning Steppes
	-- plural, as words: War Reavers = {npc:7039} War Reaver
	["{quest:3701} is a group quest at this level: its relics stand among War Reavers and Firewalkers of 53-55, with {npc:8978} (57) close by, two to five over you, and the route has no later {zone:1428} visit. Grouping up is encouraged, look for people to do it with. Skip it if you are alone."] = "{quest:3701} est une quête de groupe à ce niveau : ses reliques se trouvent parmi des Ravageurs de guerre et des Marchefeux de 53-55, avec {npc:8978} (57) tout près, deux à cinq niveaux au-dessus de vous, et l'itinéraire ne revient pas plus tard dans les {zone:1428}. Il est conseillé de se grouper, cherchez des joueurs avec qui le faire. Passez-la si vous êtes seul.",
	-- {zone:1428} Burning Steppes
	["The relics are in the {zone:1428}: keep it"] = "Les reliques sont dans {zone:1428} : gardez-la",

	-- Step 41: Fly to Aerie Peak
	-- {area:348} Aerie Peak
	["Fly to {area:348}"] = "Prendre un vol pour {area:348}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Maître de vol de {zone:1455}",

	-- Step 42: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Prendre un vol pour {area:271}",

	-- Step 43: The Super Snapper FX
	-- {npc:7977} Gammerita · {zone:1425} Hinterlands · {area:307} Overlook Cliffs
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:7977} (level 48 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back.\n{npc:7977} walks the {zone:1425} shore below the {area:307}, from the arrow south to about 75,66 and north to about 82,52: if she isn't at the arrow, follow the shore."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:7977} (élite de niveau 48) demande un groupe de 2. Passez-la si vous êtes seul : l'itinéraire vous fait regagner l'expérience en tuant des monstres.\n{npc:7977} arpente le rivage des {zone:1425} au pied des {area:307}, de la flèche jusqu'à environ 75,66 au sud et 82,52 au nord : si elle n'est pas à la flèche, suivez le rivage.",

	-- Step 44: Fly to Southshore
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "Maître de vol du {area:348}",

	-- Step 45: Orphan Matron Aria
	-- {area:271} Southshore · {area:279} Dalaran · {npc:34365} Orphan Matron Aria · {npc:266524} Lieutenant Connar · {area:1438} Nethergarde Keep
	["Ride north from {area:271} into Alterac and west to the walls of {area:279}: {npc:34365} stands outside them. Her quest goes to {npc:266524} in {area:1438}, where this guide flies later."] = "Chevauchez vers le nord depuis {area:271} jusqu'en Alterac, puis à l'ouest jusqu'aux murs de {area:279} : {npc:34365} se tient à l'extérieur. Sa quête se rend à {npc:266524} au {area:1438}, où ce guide vous emmène plus tard en vol.",

	-- Step 46: Western Plaguelands
	-- {area:271} Southshore · {area:3197} Chillwind Camp
	["Ride north from {area:271} up the road through Alterac to {area:3197}."] = "Chevauchez vers le nord depuis {area:271} par la route qui traverse l'Alterac jusqu'au {area:3197}.",

	-- Step 47: Chillwind Camp
	-- {npc:10838} Commander Ashlam Valorfist
	["{npc:10838} stands in the middle of the camp."] = "{npc:10838} se tient au milieu du camp.",

	-- Step 48: Sorrow Hill: kill these as you meet them
	-- {area:197} Sorrow Hill
	["{area:197}: kill these as you meet them"] = "{area:197} : tuez-les au passage",
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "Des Écorcheurs squelettes et des Goules écumantes parcourent les champs au nord du camp ; tout le Fléau ici laisse tomber des Pierres du Fléau.\nAttention : ces morts-vivants vous repèrent de loin, et les autres morts-vivants proches se joignent au combat quand vous en attirez un.\nAttention : l'{npc:10411} (3 apparitions, réapparition en 15 min) devient invisible hors combat et appelle des Gargouilles Aile-de-roc dès qu'un combat commence.",

	-- Step 49: Chillwind Camp
	["Ride back south to the camp."] = "Retournez au camp, au sud.",
	-- {area:199} Felstone Field · {zone:1452} Winterspring
	["keep it: the {area:199} cauldron waits for the {zone:1452} guide's Chillwind stop, at about 55"] = "gardez-la : le chaudron de {area:199} attend l'étape au camp Chillwind du guide {zone:1452}, vers le niveau 55",

	-- Step 50: Fly to Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["Fly to {area:2418}"] = "Prendre un vol pour {area:2418}",
	-- {area:3197} Chillwind Camp
	["{area:3197} flight master"] = "Maître de vol de {area:3197}",

	-- Step 51: Fly to Lakeshire
	-- {area:69} Lakeshire
	["Fly to {area:69}"] = "Prendre un vol pour {area:69}",

	-- Step 52: Morgan's Vigil flight master
	-- {area:2418} Morgan's Vigil
	["{area:2418} flight master"] = "Maître de vol de la {area:2418}",
	-- {area:69} Lakeshire · {zone:1428} Burning Steppes · {area:2418} Morgan's Vigil
	["Ride east out of {area:69} and up the pass into the {zone:1428}: {area:2418} stands at the top."] = "Chevauchez vers l'est en sortant de {area:69} et montez le col jusqu'aux {zone:1428} : la {area:2418} se dresse au sommet.",

	-- Step 53: Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["{area:2418} sits in the south-east of the Steppes, at the top of the pass up from Redridge."] = "{area:2418} se trouve au sud-est des Steppes, en haut du col qui monte depuis les Carmines.",

	-- Step 54: Level 52 at Dreadmaul Rock
	-- {area:249} Dreadmaul Rock
	["Level 52 at {area:249}"] = "Niveau 52 à {area:249}",
	-- {area:249} Dreadmaul Rock · {area:1417} Sunken Temple
	-- plural, as words: Firegut Ogres = {npc:7033} Firegut Ogre
	["Top up first to level 52 on the Firegut Ogres (50-51) on the near side of {area:249}, north of the Vigil: the Brutes on its east side are 52-53. Or, with a group, run the {area:1417} dungeon instead."] = "Montez d'abord jusqu'au niveau 52 sur les Ogres Brûlentrailles (50-51) du côté proche de {area:249}, au nord de la Veille : les Brutes sur son flanc est sont 52-53. Ou, en groupe, faites plutôt le donjon {area:1417}.",
	-- {npc:7033} Firegut Ogre
	["grind on {npc:7033}"] = "tuez en boucle : {npc:7033}",

	-- Step 55: Dreadmaul Rock
	-- {area:249} Dreadmaul Rock
	-- plural, as words: Escaped Core Hounds = {npc:227746} Escaped Core Hound
	["The Firegut ogres hold the great rock north of the Vigil, with the Brutes on its east side.\nCareful: Escaped Core Hounds (level 60) roam the Steppes, a few on the slopes west and south of {area:249}: pull the ogres on the rock itself and look around before each pull."] = "Les ogres Brûlentrailles tiennent le grand rocher au nord de la Veille, avec les Brutes sur son flanc est.\nAttention : des Chiens du Magma évadés (niveau 60) rôdent dans les Steppes, quelques-uns sur les pentes à l'ouest et au sud de {area:249} : attirez les ogres sur le rocher même et regardez autour de vous avant chaque attaque.",
	-- {npc:7034} Firegut Ogre Mage
	["{npc:7034}, below ground"] = "{npc:7034}, sous terre",

	-- Step 56: Morgan's Vigil
	-- {npc:9177} Oralius · {npc:9176} Gor'tesh · {area:254} Blackrock Mountain
	-- plural, as words: Blackrock Medallions = {item:11467} Blackrock Medallion
	["{npc:9177}' next tasks ({npc:9176}, and fifty Blackrock Medallions) send you among the Blackrock orcs of 55-58 at the foot of {area:254}: skip them."] = "Les tâches suivantes de {npc:9177} ({npc:9176}, et cinquante Médaillons de Rochenoire) vous envoient parmi les orcs Rochenoire de 55-58 au pied du {area:254} : passez-les.",

	-- Step 57: Flame Crest
	-- {area:251} Flame Crest
	["Follow the road west, then climb north to the goblin camp on {area:251}."] = "Suivez la route vers l'ouest, puis montez vers le nord jusqu'au camp gobelin de {area:251}.",

	-- Step 58: Ruins of Thaurissan: kill these as you meet them
	-- {area:250} Ruins of Thaurissan
	["{area:250}: kill these as you meet them"] = "{area:250} : tuez-les au passage",
	-- {item:12284} Draco-Incarcinatrix 900 · {npc:7047} Black Broodling · {area:251} Flame Crest · {npc:8981} Malfunctioning Reaver · {npc:7040} Black Dragonspawn
	["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves.\nCareful: a {npc:8981} (level 56, rare) walks the slopes by the broodlings, and the {npc:7040} and Wyrmkin around them are elite: use the Incarcinatrix on a broodling at the edge and look around before each pull."] = "Utilisez le {item:12284} sur un {npc:7047} sur les pentes à l'est de {area:251} juste avant qu'il meure, puis ramassez l'essence qu'il laisse.\nAttention : un {npc:8981} (niveau 56, rare) arpente les pentes près des rejetons, et les {npc:7040} et Wyrmides autour d'eux sont élites : utilisez l'Incarcinatrix sur un rejeton en bordure et regardez autour de vous avant chaque attaque.",

	-- Step 59: Ruins of Thaurissan
	-- {area:250} Ruins of Thaurissan · {area:251} Flame Crest · {npc:8978} Thauris Balgarr · {object:147516} Dark Iron
	-- plural, as words: War Reavers = {npc:7039} War Reaver · Thaurissan Firewalkers = {npc:7037} Thaurissan Firewalker
	["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered. Take the ones on the ruins' southern edge, nearest {area:251}.\nCareful: the ruins' War Reavers and Thaurissan Firewalkers are 53-55, and {npc:8978} (57) holds the {object:147516} camp south-west of {area:251}: take the relics at the edge of the ruins, pull one at a time, and keep away from the camp."] = "Les reliques sont les pierres sculptées éparpillées dans les {area:250} autour de {area:251} : cliquez dessus jusqu'à récupérer les informations. Prenez celles du bord sud des ruines, les plus proches de {area:251}.\nAttention : les Ravageurs de guerre et les Marchefeux de Thaurissan des ruines sont 53-55, et {npc:8978} (57) tient le camp {object:147516} au sud-ouest de {area:251} : prenez les reliques en bordure des ruines, attirez-les un par un et restez loin du camp.",

	-- Step 60: Flame Crest
	-- {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Ends with {quest:4808} in {area:2255}, {zone:1452}: keep it"] = "Se termine auprès de {quest:4808} à {area:2255}, {zone:1452} : gardez-la",

	-- Step 61: Cyrus Therepentous
	-- {item:10569} Hoard of the Black Dragonflight · {zone:1427} Searing Gorge · {item:10575} Black Dragonflight Molt · {npc:9459} Cyrus Therepentous
	["Open the {item:10569} from {zone:1427} for its {item:10575}, then tell {npc:9459} you bring proof of your deeds: no drake to fight."] = "Ouvrez le {item:10569} de {zone:1427} pour en récupérer la {item:10575}, puis dites à {npc:9459} que vous apportez la preuve de vos exploits : aucun drake à combattre.",
	["Below ground"] = "Sous terre",
	-- {item:10575} Black Dragonflight Molt
	["{item:10575}, from the hoard"] = "{item:10575}, dans le trésor",

	-- Step 63: A Taste of Flame
	-- {npc:9461} Frenzied Black Drake
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:9461} is a level 54 elite: most classes solo it at level 56, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:9461} est un élite de niveau 54 : la plupart des classes le battent seules au niveau 56, mais vous aurez peut-être besoin d'aide. Passez-le si vous êtes seul : l'itinéraire vous fait regagner l'expérience en tuant des monstres.",

	-- Step 65: Level 52.08
	["Level 52.08"] = "Niveau 52.08",
	-- {quest:4022} A Taste of Flame · {area:1417} Sunken Temple
	["If you skipped {quest:4022}, grind here to level 52.08 to stay on the route's plan. Or, with a group, run the {area:1417} dungeon instead."] = "Si vous avez passé {quest:4022}, tuez des monstres ici jusqu'au niveau 52.08 pour suivre le plan de l'itinéraire. Ou, en groupe, faites plutôt le donjon {area:1417}.",
	-- {npc:9690} Ember Worg
	["grind on {npc:9690}"] = "tuez en boucle : {npc:9690}",

	-- Step 66: Morgan's Vigil
	["Ride back east along the road to the Vigil."] = "Revenez vers l'est par la route jusqu'à la Veille.",

	-- Step 67: Fly to Nethergarde Keep
	-- {area:1438} Nethergarde Keep
	["Fly to {area:1438}"] = "Prendre un vol pour {area:1438}",

	-- Step 68: Ambassador Ardalan
	-- {area:1438} Nethergarde Keep
	["Ardalan is inside {area:1438}."] = "Ardalan se trouve à l'intérieur de {area:1438}.",
	-- {npc:3546} Bernie Heisten · {quest:87295} Deflective Surface
	["{npc:3546}: {quest:87295}, the scales come from the basilisks ahead"] = "{npc:3546} : {quest:87295}, les écailles viennent des basilics plus loin",

	-- Step 69: Swamp of Sorrows
	-- {zone:1419} Blasted Lands · {zone:1435} Swamp of Sorrows · {npc:10996} Fallen Hero · {area:75} Stonard
	["Ride north out of the {zone:1419} into the {zone:1435}: the {npc:10996} stands by the road from the {zone:1419}. Keep clear of {area:75}, the Horde town to the north-east."] = "Chevauchez vers le nord hors des {zone:1419} jusqu'au {zone:1435} : le {npc:10996} se tient au bord de la route qui vient des {zone:1419}. Restez à l'écart de {area:75}, la ville de la Horde au nord-est.",

	-- Step 70: Fallen Hero of the Horde
	["Listen to his tale, then ride back south to Kum'isha."] = "Écoutez son récit, puis revenez vers le sud jusqu'à Kum'isha.",

	-- Step 71: Back to the Blasted Lands
	-- {zone:1419} Blasted Lands
	["Back to the {zone:1419}"] = "Retour aux {zone:1419}",
	["Bloodmages' camp"] = "Camp des mages de sang",

	-- Step 72: The bloodmages
	["The bloodmages"] = "Les mages de sang",
	["Drazial and Lynnore stand together by the road. Take any beast requests they still offer before riding south."] = "",

	-- Step 73: Blasted Lands: kill these as you meet them
	-- {zone:1419} Blasted Lands
	["{zone:1419}: kill these as you meet them"] = "{zone:1419} : tuez-les au passage",
	-- {zone:1419} Blasted Lands · {npc:5982} Black Slayer · {npc:221740} Calefactus the Unleashed · {npc:247015} Vek'zol
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger · Ashmane Boars = {npc:5992} Ashmane Boar · Redstone Basilisks = {npc:5990} Redstone Basilisk
	["Ride back south into the {zone:1419} for the bloodmages' beasts: Starving Snickerfangs roam the dry hills south of the bloodmages' camp, Scorpok Stingers scuttle across the middle of the north and {npc:5982} vultures circle over all of it. Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep.\nCareful: two elites roam here: {npc:221740} (50) in the middle of the zone around 44,34, and {npc:247015} (55) on the ridge around 39,32. When you see one, hunt somewhere else."] = "Retournez vers le sud dans les {zone:1419} pour les bêtes des mages de sang : des Raillecrocs affamées rôdent dans les collines arides au sud du camp des mages de sang, des Aiguillonneurs scorpoks courent au milieu du nord et des vautours {npc:5982} tournoient au-dessus de tout cela. Les Sangliers cendrés et les Basilics Rougepierre partagent les pentes au sud-ouest du donjon.\nAttention : deux élites rôdent ici : {npc:221740} (50) au milieu de la zone vers 44,34, et {npc:247015} (55) sur la crête vers 39,32. Si vous en voyez un, chassez ailleurs.",

	-- Step 75: Kum'isha the Collector
	-- {area:2517} Rise of the Defiler · {zone:1419} Blasted Lands · {npc:7664} Razelikh the Defiler · {spell:2691} Mana Burn · {spell:8255} Strong Cleave · {object:141891} Razelikh's Tear · {spell:10854} Flames of Chaos · {npc:247015} Vek'zol
	-- plural, as words: Imperfect Draenethyst Fragments = {item:10593} Imperfect Draenethyst Fragment
	["Kum'isha waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have. Come at her hill straight from the keep, along the road, and leave by the same way.\nCareful: Felcular, {npc:7664} and Ilifar are all level 60 elites. Razelikh casts {spell:2691}, {spell:8255} and Decimate, and as its health drops it adds {object:141891}, {spell:10854} and then Enrage at 15%.\nCareful: {npc:247015}, a level 55 elite, stands by Kum'isha's hill (about 50,35) and to the west (about 39,32), and the Dreadmaul and Shadowsworn camps around it are 53-55: take the fragments from the mobs on the way from the keep, not beside him."] = "Kum'isha attend à {area:2517}, la colline au sud-ouest du donjon. Les monstres des {zone:1419} sur le chemin lâchent les Fragments de draenéthyste imparfaits ; apportez-lui ce que vous avez. Allez à sa colline directement depuis le donjon, par la route, et repartez par le même chemin.\nAttention : Felcular, {npc:7664} et Ilifar sont tous des élites de niveau 60. Razelikh lance {spell:2691}, {spell:8255} et Décimer, et à mesure que sa vie baisse il ajoute {object:141891}, {spell:10854} puis Enrager à 15 %.\nAttention : {npc:247015}, un élite de niveau 55, se tient près de la colline de Kum'isha (vers 50,35) et à l'ouest (vers 39,32), et les camps Cognepeur et Assermentés de l'ombre autour sont de niveau 53-55 : prenez les fragments sur les monstres du chemin depuis le donjon, pas à côté de lui.",
	-- {npc:7363} Kum'isha the Collector
	["{npc:7363} walks around here: look inside the circle on the map"] = "{npc:7363} se promène par ici : cherchez dans le cercle sur la carte",

	-- Step 76: The bloodmages
	-- {zone:1419} Blasted Lands
	["Ride north to the bloodmages' camp beside the road into the {zone:1419}."] = "Chevauchez vers le nord jusqu'au camp des mages de sang, au bord de la route qui mène aux {zone:1419}.",
	["The bloodmages' second tier pays for the same parts with a buff item and no experience: skip it."] = "Le second palier des mages de sang paie les mêmes morceaux avec un objet d'amélioration et sans expérience : passez-le.",

	-- Step 77: Bernie Heisten
	-- {npc:3546} Bernie Heisten · {area:1438} Nethergarde Keep
	["Back to {npc:3546} in {area:1438} before you hearth."] = "Retournez voir {npc:3546} au {area:1438} avant d'utiliser votre Pierre de foyer.",

	-- Step 78: To Ironforge
	-- {zone:1455} Ironforge
	["Hearth back to {zone:1455}'s inn."] = "Utilisez votre Pierre de foyer pour retourner à l'auberge de {zone:1455}.",

	-- Step 79: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "Prendre un vol pour {area:144}",

	-- Step 82: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Prendre un vol pour {area:1537}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "Maître de vol de {area:144}",

	-- Step 85: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}: the relics you read in the Steppes are his."] = "Archesonus se tient à côté du roi Magni dans {object:171709} : les reliques que vous avez lues dans les Steppes sont pour lui.",

	-- Step 86: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Prendre un vol pour {area:150}",

	-- Step 88: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "Prendre un vol pour {area:702}",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "Maître de vol d'{area:442}",

	-- Step 89: Rut'theran Village
	-- {zone:1452} Winterspring
	["The wildkin are in {zone:1452}: keep it"] = "Les Indomptables sont au {zone:1452} : gardez-la",

	-- Step 92: Darnassus
	-- {area:702} Rut'theran Village · {zone:1457} Darnassus · {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["The portal in {area:702} leads up to {zone:1457}: {npc:9047} waits in the {area:1658}, in the north of the city."] = "Le portail de {area:702} mène à {zone:1457} : {npc:9047} attend à {area:1658}, au nord de la cité.",
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["{npc:9047}, in the {area:1658}"] = "{npc:9047}, à {area:1658}",
	-- {zone:1455} Ironforge
	["{zone:1455} has no druid trainer"] = "{zone:1455} n'a pas de maître des druides",

	-- Step 93: Mathrengyl Bearwalker
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217} is upstairs in the druids' building of the {area:1658}: go in by its south door."] = "{npc:4217} est à l'étage du bâtiment des druides de l'{area:1658} : entrez par sa porte sud.",
	-- {npc:4217} Mathrengyl Bearwalker
	["{npc:4217}, upstairs"] = "{npc:4217}, à l'étage",

	-- Step 94: Astarii Starseeker
	-- {npc:7740} Gracina Spiritmight · {quest:3378} Prayer to Elune · {npc:4090} Astarii Starseeker
	["On the way to {npc:7740}, give the {quest:3378} to {npc:4090} in the Temple of the Moon."] = "",

	-- Step 95: Gracina Spiritmight
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740} stands beside Tyrande in the Temple of the Moon, in the south of the city."] = "{npc:7740} se tient à côté de Tyrande dans le temple de la Lune, au sud de la ville.",
	-- {npc:7740} Gracina Spiritmight · {quest:162} Rise of the Silithid · {area:976} Gadgetzan
	["{npc:7740}: {quest:162}, from {area:976}"] = "{npc:7740} : {quest:162}, depuis {area:976}",
	-- {npc:5594} Alchemist Pestlezugg · {area:976} Gadgetzan · {zone:1422} Western Plaguelands
	["For {npc:5594} in {area:976}, on the {zone:1422} guide: keep it"] = "Pour l'{npc:5594} à {area:976}, dans le guide des {zone:1422} : gardez-le",

	-- Step 96: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "Portail vers {zone:1438}",

	-- Step 97: Daryn Lightwind
	-- {npc:7907} Daryn Lightwind · {npc:7916} Erelas Ambersky
	["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "{npc:7907} se tient à l'étage, au-dessus de {npc:7916} : montez par l'intérieur, la flèche ne distingue pas les étages.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {zone:1438}"] = "Retour à {zone:1438}",
	-- ["Class trainer"] = "Maître de classe",
	-- ["Climb back to {npc:8405} at the {area:1224}, above the ruins."] = "Remontez jusqu'à {npc:8405}, à {area:1224}, au-dessus des ruines.",
	-- ["Climb to the top of {area:249} and plant the head in the soft dirt mound."] = "Montez au sommet de {area:249} et plantez la tête dans le monticule de terre meuble.",
	-- ["Druid training"] = "Entraînement de druide",
	-- ["Fly from {zone:1455} to {area:150} and take the boat to {area:442}."] = "Prenez un vol de {zone:1455} pour {area:150} et le bateau pour {area:442}.",
	-- ["Fly from {zone:1455} to {area:69}."] = "Prenez un vol de {zone:1455} pour {area:69}.",
	-- ["Fly to {area:1438}."] = "Prenez un vol pour {area:1438}.",
	-- ["Fly to {area:150} and take the boat to {area:442}, then the boat on to {area:702}."] = "Prenez un vol pour {area:150} et le bateau pour {area:442}, puis le bateau pour {area:702}.",
	-- ["For {zone:1453}: keep it"] = "Pour {zone:1453} : gardez-la",
	-- ["From the {area:442} dock, fly to {area:415}."] = "Depuis le quai d'{area:442}, prenez un vol pour {area:415}.",
	-- ["Hearth to {area:2101}"] = "Pierre de foyer vers {area:2101}",
	-- ["Kum'isha waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have.\nCareful: Felcular, {npc:7664} and Ilifar are all level 60 elites. Razelikh casts {spell:2691}, {spell:8255} and Decimate, and as its health drops it adds {object:141891}, {spell:10854} and then Enrage at 15%.\nCareful: {npc:247015}, a level 55 elite, stands by Kum'isha's hill (about 50,35) and to the west (about 39,32): take the fragments from the mobs on the way from the keep, not beside him."] = "Kum'isha attend à {area:2517}, la colline au sud-ouest du donjon. Les monstres des {zone:1419} sur le chemin lâchent les Fragments de draenéthyste imparfaits ; apportez-lui ce que vous avez.\nAttention : Felcular, {npc:7664} et Ilifar sont tous des élites de niveau 60. Razelikh lance {spell:2691}, {spell:8255} et Décimer, et à mesure que sa vie baisse il ajoute {object:141891}, {spell:10854} puis Enrager à 15 %.\nAttention : {npc:247015}, un élite de niveau 55, se tient près de la colline de Kum'isha (vers 50,35) et à l'ouest (vers 39,32) : prenez les fragments sur les monstres du chemin depuis le donjon, pas à côté de lui.",
	-- ["Level 50.89"] = "Niveau 50.89",
	-- ["Level 51.39"] = "Niveau 51.39",
	-- ["Level 52"] = "Niveau 52",
	-- ["On the way"] = "En chemin",
	-- ["Optional: {npc:8395} wants two Undamaged Hippogryph Feathers from the hippogryphs around his camp. The data lists no experience for it."] = "Facultatif : {npc:8395} veut deux Plumes d'hippogryphe sans défaut des hippogryphes autour de son camp. Les données n'indiquent aucune expérience pour cette quête.",
	-- ["Optional: {npc:8888}'s ghost stands on his tomb on the great chain inside {area:254}, and only the dead can see him. If you die near the mountain anyway, run your spirit to him before resurrecting."] = "Facultatif : le fantôme de {npc:8888} se tient sur sa tombe, sur la grande chaîne à l'intérieur de {area:254}, et seuls les morts peuvent le voir. Si vous mourez près de la montagne de toute façon, menez votre esprit jusqu'à lui avant de ressusciter.",
	-- ["Priests and Mages trained here at the end of the Un'Goro guide"] = "Les prêtres et les mages se sont entraînés ici à la fin du guide d'Un'Goro",
	-- ["Read the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript."] = "Lisez la tablette dans le camp {object:147516} parmi les ruines, au sud-ouest de {area:251}, pour en copier la transcription.",
	-- ["Ride back to {area:1438} and fly to {area:348}. The Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "Revenez à {area:1438} et prenez un vol pour {area:348}. Les Plumes d'Indomptable jonchent le sol dans {zone:1425}, au sud et à l'est de {area:348}, là où rôdent les chouettards ; les monstres d'ici sont désormais bien en dessous de votre niveau.",
	-- ["Ride east along the road out of {zone:1440} into {zone:1447} to the Sentinels' camp at {area:3137}."] = "Chevauchez vers l'est par la route hors de {zone:1440} jusqu'en {zone:1447}, au camp des Sentinelles de {area:3137}.",
	-- ["Ride north out of the {zone:1419} into the {zone:1435}: the {npc:10996} stands by the road from the {zone:1419}. Keep clear of {area:75}, the Horde town to the north-east. Listen to his tale, then ride back south to Kum'isha."] = "Chevauchez vers le nord hors des {zone:1419} jusqu'au {zone:1435} : le {npc:10996} se tient au bord de la route qui vient des {zone:1419}. Restez à l'écart de {area:75}, la ville de la Horde au nord-est. Écoutez son récit, puis revenez vers le sud jusqu'à Kum'isha.",
	-- ["Ride north out of {area:69} through the pass into the {zone:1428}; {area:2418} sits at the top, in the south-east of the Steppes."] = "Chevauchez vers le nord hors de {area:69} par le col jusqu'à {zone:1428} ; {area:2418} se trouve en haut, dans le sud-est des Steppes.",
	-- ["Swim to the small island off the southern tip of {area:16}: {npc:8392} waits by the monument."] = "Nagez jusqu'au petit îlot au large de la pointe sud d'{area:16} : {npc:8392} attend près du monument.",
	-- ["Swim to the small island off the southern tip of {zone:1447}: {npc:8392} waits by the monument."] = "Nagez jusqu'au petit îlot au large de la pointe sud d'{zone:1447} : {npc:8392} attend près du Colosse de Ravencrest.",
	-- ["Thaurissan Relics"] = "Reliques de Thaurissan",
	-- ["The Highborne ghosts haunt the ruins around the shrine; the Haldarr satyrs hold the camp just north of it."] = "Les fantômes bien-nés hantent les ruines autour du sanctuaire ; les satyres Haldarr tiennent le Campement des Haldarr juste au nord.",
	-- ["The Highborne ghosts haunt the ruins around the shrine; the Haldarr satyrs hold the camp just north of it. {npc:222478} is held in the satyrs' camp: free her and walk her out."] = "Les fantômes bien-nés hantent les ruines autour du sanctuaire ; les satyres Haldarr tiennent le camp juste au nord. {npc:222478} est retenue dans le camp des satyres : libérez-la et escortez-la dehors.",
	-- ["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s four runes stand among the ruins: use his {item:10445} on each."] = "Les nagas Fouette-bile de {area:1221} portent {item:13815}. Les quatre runes de {npc:8507} se dressent parmi les ruines : utilisez son {item:10445} sur chacune.",
	-- ["The Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "Les Plumes d'Indomptable jonchent le sol des {zone:1425}, au sud et à l'est du {area:348}, là où rôdent les chouettards ; les monstres d'ici sont désormais bien en dessous de votre niveau.",
	-- ["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south."] = "Les Coursiers Sabots-de-mousse les plus proches paissent dans les collines au nord-est de {area:1224}, vers {area:1219} ; un troupeau plus grand parcourt les terres dégagées au sud.",
	-- ["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered."] = "Les reliques sont les pierres sculptées éparpillées dans {area:250} autour de {area:251} : cliquez dessus jusqu'à ce que l'information soit récupérée.",
	-- ["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered.\nRead the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript.\nUse the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves.\nCareful: a {npc:8981} (level 56, rare) walks the slopes by the broodlings, and the {npc:7040} and Wyrmkin around them are elite: use the Incarcinatrix on a broodling at the edge and look around before each pull."] = "Les reliques sont les pierres sculptées éparpillées dans les {area:250} autour de {area:251} : cliquez dessus jusqu'à récupérer les informations.\nLisez la tablette dans le camp {object:147516} parmi les ruines, au sud-ouest de {area:251}, pour en copier la transcription.\nUtilisez le {item:12284} sur un {npc:7047} sur les pentes à l'est de {area:251} juste avant qu'il meure, puis ramassez l'essence qu'il laisse.\nAttention : un {npc:8981} (niveau 56, rare) arpente les pentes près des rejetons, et les {npc:7040} et Wyrmides autour d'eux sont élites : utilisez l'Incarcinatrix sur un rejeton en bordure et regardez autour de vous avant chaque attaque.",
	-- ["The shrine lies in the south-west corner of {area:16}, south of {area:3137}."] = "Le sanctuaire se trouve dans le coin sud-ouest d'{area:16}, au sud de {area:3137}.",
	-- ["The {quest:4296}"] = "{quest:4296}",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:7977} (level 48 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:7977} (élite de niveau 48) demande un groupe de 2. Passez-la si vous êtes seul : l'itinéraire vous fait regagner l'expérience en tuant des monstres.",
	-- ["Top up here to level 50.89 before the hand-ins at {zone:1426}: they take you to level 51."] = "Complétez ici jusqu'au niveau 50.89 avant les rendus de quêtes à {zone:1426} : ils vous font passer au niveau 51.",
	-- ["Top up here to level 51.39 before the hand-ins at {area:251}: they take you to level 52."] = "Complétez ici jusqu'au niveau 51.39 avant les rendus de quêtes à {area:251} : ils vous font passer au niveau 52.",
	-- ["Top up here to level 52 before the hand-ins at {area:251}: they take you to level 53."] = "Complétez ici jusqu'au niveau 52 avant les rendus de quêtes à {area:251} : ils vous font passer au niveau 53.",
	-- ["Top up here to level 52 on the ogres of {area:249}, on the way to {area:251}: the hand-ins there take you to level 53. Or, with a group, run the {area:1417} dungeon instead."] = "Montez ici jusqu'au niveau 52 sur les ogres de {area:249}, sur le chemin de {area:251} : les rendus de quêtes là-bas vous font passer au niveau 53. Ou, en groupe, faites plutôt le donjon {area:1417}.",
	-- ["Upstairs"] = "À l'étage",
	-- ["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves."] = "Utilisez le {item:12284} sur un {npc:7047} sur les pentes à l'est de {area:251} juste avant sa mort, puis ramassez l'essence qu'il laisse.",
	-- ["Wildkin feathers"] = "Plumes d'Indomptable",
	-- ["grind on {npc:6375}"] = "tuez en boucle : {npc:6375}",
	-- ["grind on {npc:7033}: {npc:9177} gives {quest:4283} from level 51"] = "tuez en boucle : {npc:7033} ; {npc:9177} donne {quest:4283} dès le niveau 51",
	-- ["grind on {npc:7034}"] = "tuez en boucle : {npc:7034}",
	-- ["{area:199} cauldron"] = "Chaudron de {area:199}",
	-- ["{item:11467} on the way"] = "{item:11467} en chemin",
	-- ["{item:11467}; inside"] = "{item:11467} ; à l'intérieur",
	-- ["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "Le fantôme de {npc:10778} erre près de la ferme de {area:199}, à l'ouest de {area:200} ; son colis est à l'intérieur.",
	-- ["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075} garde le chaudron de {area:199}, à l'ouest d'Andorhal.",
	-- ["{npc:5111}: the last guide binds here, so this usually ticks at once"] = "{npc:5111} : le guide précédent vous lie ici, cette étape se coche donc généralement aussitôt",
	-- ["{npc:6116} along the way to {area:1235}"] = "{npc:6116} sur le chemin de {area:1235}",
	-- ["{npc:6117} along the way to {area:1235}"] = "{npc:6117} sur le chemin de {area:1235}",
	-- ["{npc:7363} waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have."] = "{npc:7363} attend à {area:2517}, la colline au sud-ouest du donjon. Les monstres des {zone:1419} en chemin laissent tomber les Fragments de draenéthyste imparfaits ; apportez-lui ce que vous avez.",
	-- ["{npc:8395} wants two Undamaged Hippogryph Feathers from the Thunderhead hippogryphs around his camp, the ones you top up on here: about one in three carries one."] = "{npc:8395} veut deux Plumes d'hippogryphe sans défaut des hippogryphes Cogne-tonnerre autour de son camp, ceux sur lesquels vous complétez votre niveau ici : environ un sur trois en porte une.",
	-- ["{npc:8420} camps at the {area:1219} in the north; his equipment lies all over the {area:1220} just south-east of him."] = "{npc:8420} campe à {area:1219}, au nord ; son équipement est éparpillé dans tout {area:1220}, juste au sud-est.",
	-- ["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty."] = "{npc:9176} et les orcs Blackrock tiennent les camps et le Bastion Rochenoire au pied de {area:254}, à l'ouest de {area:251}. Attirez-les un par un ; chaque orc et chaque worg peut laisser tomber un médaillon, tuez-en jusqu'à en avoir cinquante.",
	-- ["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty.\nCareful: {npc:9176} has a guard linked to him that joins the fight, and a second soldier patrols close by; clear the patrol before pulling.\nCareful: Firesworn, level 60 fire elementals, wander the Steppes, some between the Blackrock camps: look before each pull and let them pass."] = "{npc:9176} et les orcs Blackrock tiennent les camps et la forteresse au pied du {area:254}, à l'ouest de {area:251}. Attirez-les un par un ; chaque orc et chaque worg peut lâcher un médaillon, tuez-les donc jusqu'à en avoir cinquante.\nAttention : {npc:9176} a un garde lié qui se joint au combat, et un second soldat patrouille tout près ; éliminez la patrouille avant de l'attirer.\nAttention : les Firesworn, des élémentaires de feu de niveau 60, errent dans les Steppes, certains entre les camps Blackrock : regardez avant chaque attaque et laissez-les passer.",
	-- ["{npc:9177}: the Blackrock orcs drop the medallions, keep it open all through the Steppes"] = "{npc:9177} : les orcs Blackrock laissent tomber les médaillons, gardez-la ouverte dans toutes les Steppes",
	-- ["{object:153556} on the way"] = "{object:153556} en chemin",
	-- ["{object:175894}, inside"] = "{object:175894}, à l'intérieur",
	-- ["{zone:1455} has no druid trainer: take the portal up to {zone:1457} and train in the {area:1658}, then come back down to {area:702}."] = "{zone:1455} n'a pas de maître des druides : prenez le portail pour monter à {zone:1457} et entraînez-vous à {area:1658}, puis redescendez à {area:702}.",
}
