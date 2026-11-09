-- French (frFR): the guide forever/alliance/50-60/01-burning-steppes (forever/alliance/50-60/01-burning-steppes.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Shadowsong Shrine
	-- {zone:1447} Azshara · {area:3137} Talrendis Point
	["The shrine lies in the south-west corner of {zone:1447}, south of {area:3137}."] = "Le Sanctuaire de Shadowsong se trouve dans le coin sud-ouest d'{zone:1447}, au sud de {area:3137}.",

	-- Step 2: Azshara: kill these as you meet them
	-- {zone:1447} Azshara
	["{zone:1447}: kill these as you meet them"] = "{zone:1447} : tuez-les au passage",
	["The Highborne ghosts haunt the ruins around the shrine; the Haldarr satyrs hold the camp just north of it."] = "Les fantômes bien-nés hantent les ruines autour du sanctuaire ; les satyres Haldarr tiennent le Campement des Haldarr juste au nord.",

	-- Step 5: Ogtinc
	-- {npc:8405} Ogtinc · {area:1224} Bear's Head
	["Ride north-east from the shrine: {npc:8405} camps at the {area:1224}, in the hills above the road."] = "Chevauchez vers le nord-est depuis le sanctuaire : {npc:8405} campe à {area:1224}, dans les collines au-dessus de la route.",

	-- Step 6: Mosshoof Coursers
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers"] = "Coursiers Sabots-de-mousse",
	-- {area:1224} Bear's Head · {area:1219} Legashi Encampment
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south."] = "Les Coursiers Sabots-de-mousse les plus proches paissent dans les collines au nord-est de {area:1224}, vers {area:1219} ; un troupeau plus grand parcourt les terres dégagées au sud.",

	-- Step 9: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo
	-- plural, as words: Undamaged Hippogryph Feathers = {item:10450} Undamaged Hippogryph Feather
	["Optional: {npc:8395} wants two Undamaged Hippogryph Feathers from the hippogryphs around his camp. The data lists no experience for it."] = "Facultatif : {npc:8395} veut deux Plumes d'hippogryphe sans défaut des hippogryphes autour de son camp. Les données n'indiquent aucune expérience pour cette quête.",
	-- {npc:6375} Thunderhead Hippogryph
	["grind on {npc:6375}"] = "tuez en boucle : {npc:6375}",

	-- Step 10: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo · {npc:8379} Archmage Xylem
	["Get off your mount before you talk to {npc:8395}: he teleports you up to {npc:8379}'s tower on the cliff above his camp."] = "",

	-- Step 11: Archmage Xylem
	["The apprentice at the top of the tower sends you back down."] = "",
	-- {area:1220} Thalassian Base Camp · {npc:8420} Kim'jael
	["The blood elves are at the {area:1220}, on the way to {npc:8420}"] = "",

	-- Step 12: Kim'jael
	-- {npc:8420} Kim'jael · {area:1219} Legashi Encampment · {area:1220} Thalassian Base Camp
	["{npc:8420} camps at the {area:1219} in the north; his equipment lies all over the {area:1220} just south-east of him."] = "{npc:8420} campe à {area:1219}, au nord ; son équipement est éparpillé dans tout {area:1220}, juste au sud-est.",
	-- {item:20028} Glittering Dust
	["{item:20028}, from the blood elf surveyors and reclaimers"] = "",
	-- {npc:6196} Spitelash Myrmidon
	["grind on {npc:6196}"] = "tuez en boucle : {npc:6196}",

	-- Step 13: The Ruins of Eldarath
	-- {area:1221} Ruins of Eldarath
	["The {area:1221}"] = "{area:1221}",
	-- {area:1221} Ruins of Eldarath · {item:13815} Some Rune · {npc:8507} Tymor · {item:10445} Drawing Kit
	["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s four runes stand among the ruins: use his {item:10445} on each."] = "Les nagas Fouette-bile de {area:1221} portent {item:13815}. Les quatre runes de {npc:8507} se dressent parmi les ruines : utilisez son {item:10445} sur chacune.",

	-- Step 17: Rubbing: Rune of Sael'hai
	-- {item:7972} Ichor of Undeath · {npc:7864} Lingering Highborne
	["{item:7972}: the {npc:7864}, about 10%"] = "{item:7972} : les {npc:7864}, environ 10 %",

	-- Step 18: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo
	["Ride back west to {npc:8395}'s camp and get off your mount: he teleports you up to Xylem again."] = "",

	-- Step 20: The Temple of Zin-Malor
	-- {area:1223} Temple of Zin-Malor
	["The {area:1223}"] = "",
	-- {area:1223} Temple of Zin-Malor · {npc:8395} Sanath Lim-yo
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren
	["The Spitelash Sirens wander the ruins and the beach around the {area:1223}, just south of {npc:8395}. Only the Sirens carry the coral, not the Screamers."] = "",

	-- Step 21: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo
	["Back up through {npc:8395}'s teleport."] = "",
	-- {area:1417} Sunken Temple
	["Xylem's last task, Destroy Morphaz, is in the {area:1417}: skip it."] = "",

	-- Step 23: Ravencrest Monument
	-- {zone:1447} Azshara · {npc:8392} Pilot Xiggs Fuselighter
	["Swim to the small island off the southern tip of {zone:1447}: {npc:8392} waits by the monument."] = "Nagez jusqu'au petit îlot au large de la pointe sud d'{zone:1447} : {npc:8392} attend près du Colosse de Ravencrest.",

	-- Step 24: To Stoutlager Inn
	-- {area:2101} Stoutlager Inn
	["To {area:2101}"] = "Vers {area:2101}",

	-- Step 25: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Prendre un vol pour {area:1537}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "Maître de vol de {area:144}",

	-- Step 27: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}."] = "Archesonus se tient à côté du roi Magni dans {object:171709}.",
	-- {zone:1428} Burning Steppes
	["The relics are in the {zone:1428}: keep it"] = "Les reliques sont dans {zone:1428} : gardez-la",

	-- Step 28: Fly to Aerie Peak
	-- {area:348} Aerie Peak
	["Fly to {area:348}"] = "Prendre un vol pour {area:348}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Maître de vol de {zone:1455}",

	-- Step 29: Wildkin feathers
	["Wildkin feathers"] = "Plumes d'Indomptable",
	-- {zone:1425} Hinterlands · {area:348} Aerie Peak
	-- plural, as words: Wildkin Feathers = {item:10819} Wildkin Feather
	["The Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "Les Plumes d'Indomptable jonchent le sol des {zone:1425}, au sud et à l'est du {area:348}, là où rôdent les chouettards ; les monstres d'ici sont désormais bien en dessous de votre niveau.",

	-- Step 30: The Super Snapper FX
	-- {npc:7977} Gammerita
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:7977} (level 48 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:7977} (élite de niveau 48) demande un groupe de 2. Passez-la si vous êtes seul : l'itinéraire vous fait regagner l'expérience en tuant des monstres.",

	-- Step 32: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Prendre un vol pour {area:271}",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "Maître de vol du {area:348}",

	-- Step 33: Western Plaguelands
	-- {area:271} Southshore · {area:3197} Chillwind Camp
	["Ride north from {area:271} up the road through Alterac to {area:3197}."] = "",

	-- Step 34: Chillwind Camp
	-- {npc:10838} Commander Ashlam Valorfist
	["{npc:10838} stands in the middle of the camp."] = "",

	-- Step 35: Sorrow Hill: kill these as you meet them
	-- {area:197} Sorrow Hill
	["{area:197}: kill these as you meet them"] = "{area:197} : tuez-les au passage",
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "Des Écorcheurs squelettes et des Goules écumantes parcourent les champs au nord du camp ; tout le Fléau ici laisse tomber des Pierres du Fléau.\nAttention : ces morts-vivants vous repèrent de loin, et les autres morts-vivants proches se joignent au combat quand vous en attirez un.\nAttention : l'{npc:10411} (3 apparitions, réapparition en 15 min) devient invisible hors combat et appelle des Gargouilles Aile-de-roc dès qu'un combat commence.",

	-- Step 36: Chillwind Camp
	["Ride back south to the camp."] = "Retournez au camp, au sud.",

	-- Step 37: Janice Felstone
	-- {npc:10778} Janice Felstone · {area:199} Felstone Field · {area:200} Dalson's Tears
	["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "Le fantôme de {npc:10778} erre près de la ferme de {area:199}, à l'ouest de {area:200} ; son colis est à l'intérieur.",
	["Upstairs"] = "À l'étage",
	-- {object:175894} Janice's Parcel
	["{object:175894}, inside"] = "{object:175894}, à l'intérieur",
	-- {zone:1453} Stormwind
	["For {zone:1453}: keep it"] = "Pour {zone:1453} : gardez-la",

	-- Step 38: Felstone Field cauldron
	-- {area:199} Felstone Field
	["{area:199} cauldron"] = "Chaudron de {area:199}",
	-- {npc:11075} Cauldron Lord Bilemaw · {area:199} Felstone Field
	["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075} garde le chaudron de {area:199}, à l'ouest d'Andorhal.",

	-- Step 40: Fly to Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["Fly to {area:2418}"] = "Prendre un vol pour {area:2418}",
	-- {area:3197} Chillwind Camp
	["{area:3197} flight master"] = "Maître de vol de {area:3197}",

	-- Step 41: Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["{area:2418} sits in the south-east of the Steppes, at the top of the pass up from Redridge."] = "{area:2418} se trouve au sud-est des Steppes, en haut du col qui monte depuis les Carmines.",

	-- Step 42: Dreadmaul Rock
	["The Firegut ogres hold the great rock north of the Vigil, with the Brutes on its east side."] = "Les ogres Brûlentrailles tiennent le grand rocher au nord de la Veille, avec les Brutes sur son flanc est.",
	-- {npc:7034} Firegut Ogre Mage
	["{npc:7034}, below ground"] = "{npc:7034}, sous terre",
	-- {npc:7033} Firegut Ogre · {npc:9177} Oralius · {quest:4283} FIFTY! YEP!
	["grind on {npc:7033}: {npc:9177} gives {quest:4283} from level 51"] = "",

	-- Step 43: Morgan's Vigil
	-- {npc:9177} Oralius
	["{npc:9177}: the Blackrock orcs drop the medallions, keep it open all through the Steppes"] = "{npc:9177} : les orcs Blackrock laissent tomber les médaillons, gardez-la ouverte dans toutes les Steppes",

	-- Step 44: Level 52
	["Level 52"] = "Niveau 52",
	-- {area:249} Dreadmaul Rock · {area:251} Flame Crest · {area:1417} Sunken Temple · {area:2100} Maraudon
	["Top up here to level 52 on the ogres of {area:249}, on the way to {area:251}: the hand-ins there take you to level 53. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "",
	-- {npc:7034} Firegut Ogre Mage
	["grind on {npc:7034}"] = "tuez en boucle : {npc:7034}",

	-- Step 45: Flame Crest
	-- {area:251} Flame Crest
	["Follow the road west, then climb north to the goblin camp on {area:251}."] = "Suivez la route vers l'ouest, puis montez vers le nord jusqu'au camp gobelin de {area:251}.",

	-- Step 46: Ruins of Thaurissan: kill these as you meet them
	-- {area:250} Ruins of Thaurissan
	["{area:250}: kill these as you meet them"] = "{area:250} : tuez-les au passage",
	-- {area:250} Ruins of Thaurissan · {area:251} Flame Crest · {object:147516} Dark Iron · {item:12284} Draco-Incarcinatrix 900 · {npc:7047} Black Broodling
	["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered.\nRead the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript.\nUse the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves."] = "Les reliques sont les pierres sculptées éparpillées dans les {area:250} autour de {area:251} : cliquez dessus jusqu'à récupérer les informations.\nLisez la tablette dans le camp {object:147516} parmi les ruines, au sud-ouest de {area:251}, pour en copier la transcription.\nUtilisez le {item:12284} sur un {npc:7047} sur les pentes à l'est de {area:251} juste avant qu'il meure, puis ramassez l'essence qu'il laisse.",

	-- Step 47: Flame Crest
	-- {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Ends with {quest:4808} in {area:2255}, {zone:1452}: keep it"] = "Se termine auprès de {quest:4808} à {area:2255}, {zone:1452} : gardez-la",

	-- Step 48: Cyrus Therepentous
	["Below ground"] = "Sous terre",

	-- Step 49: A Taste of Flame
	-- {npc:9461} Frenzied Black Drake
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:9461} is a level 54 elite: most classes solo it at level 56, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:9461} est un élite de niveau 54 : la plupart des classes le battent seules au niveau 56, mais vous aurez peut-être besoin d'aide. Passez-le si vous êtes seul : l'itinéraire vous fait regagner l'expérience en tuant des monstres.",

	-- Step 51: Level 52.08
	["Level 52.08"] = "Niveau 52.08",
	-- {quest:4022} A Taste of Flame · {area:1417} Sunken Temple · {area:2100} Maraudon
	["If you skipped {quest:4022}, grind here to level 52.08 to stay on the route's plan. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "",
	-- {npc:9690} Ember Worg
	["grind on {npc:9690}"] = "tuez en boucle : {npc:9690}",

	-- Step 52: Blackrock Stronghold
	-- {npc:9176} Gor'tesh · {area:254} Blackrock Mountain · {area:251} Flame Crest
	["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty.\nCareful: {npc:9176} has a guard linked to him that joins the fight, and a second soldier patrols close by; clear the patrol before pulling."] = "{npc:9176} et les orcs Blackrock tiennent les camps et la forteresse au pied du {area:254}, à l'ouest de {area:251}. Attirez-les un par un ; chaque orc et chaque worg peut lâcher un médaillon, tuez-les donc jusqu'à en avoir cinquante.\nAttention : {npc:9176} a un garde lié qui se joint au combat, et un second soldat patrouille tout près ; éliminez la patrouille avant de l'attirer.",
	-- {item:11467} Blackrock Medallion
	["{item:11467}; inside"] = "{item:11467} ; à l'intérieur",

	-- Step 53: Morgan's Vigil
	["Ride back east along the road to the Vigil."] = "Revenez vers l'est par la route jusqu'à la Veille.",

	-- Step 54: Dreadmaul Rock
	-- {area:249} Dreadmaul Rock
	["Climb to the top of {area:249} and plant the head in the soft dirt mound."] = "Montez au sommet de {area:249} et plantez la tête dans le monticule de terre meuble.",

	-- Step 56: Fly to Nethergarde Keep
	-- {area:1438} Nethergarde Keep
	["Fly to {area:1438}"] = "Prendre un vol pour {area:1438}",
	-- {area:2418} Morgan's Vigil
	["{area:2418} flight master"] = "Maître de vol de la {area:2418}",

	-- Step 57: Kum'isha the Collector
	-- {area:2517} Rise of the Defiler · {zone:1419} Blasted Lands · {npc:7664} Razelikh the Defiler · {spell:2691} Mana Burn · {spell:8255} Strong Cleave · {object:141891} Razelikh's Tear (no name in this language: may be words) · {spell:10854} Flames of Chaos
	-- plural, as words: Imperfect Draenethyst Fragments = {item:10593} Imperfect Draenethyst Fragment
	["Kum'isha waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have.\nCareful: Felcular, {npc:7664} and Ilifar are all level 60 elites. Razelikh casts {spell:2691}, {spell:8255} and Decimate, and as its health drops it adds {object:141891}, {spell:10854} and then Enrage at 15%."] = "Kum'isha attend à {area:2517}, la colline au sud-ouest du donjon. Les monstres des {zone:1419} sur le chemin lâchent les Fragments de draenéthyste imparfaits ; apportez-lui ce que vous avez.\nAttention : Felcular, {npc:7664} et Ilifar sont tous des élites de niveau 60. Razelikh lance {spell:2691}, {spell:8255} et Décimer, et à mesure que sa vie baisse il ajoute Larme de Razelikh, {spell:10854} puis Enrager à 15 %.",
	-- {npc:7363} Kum'isha the Collector
	["{npc:7363} walks around here: look inside the circle on the map"] = "{npc:7363} se promène par ici : cherchez dans le cercle sur la carte",

	-- Step 65: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Prendre un vol pour {area:150}",

	-- Step 67: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "Prendre un vol pour {area:702}",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "Maître de vol d'{area:442}",

	-- Step 68: Rut'theran Village
	-- {zone:1452} Winterspring
	["The wildkin are in {zone:1452}: keep it"] = "Les Indomptables sont au {zone:1452} : gardez-la",

	-- Step 69: Druid training
	["Druid training"] = "Entraînement de druide",
	-- {zone:1455} Ironforge · {zone:1457} Darnassus · {area:1658} Cenarion Enclave · {area:702} Rut'theran Village
	["{zone:1455} has no druid trainer: take the portal up to {zone:1457} and train in the {area:1658}, then come back down to {area:702}."] = "{zone:1455} n'a pas de maître des druides : prenez le portail pour monter à {zone:1457} et entraînez-vous à {area:1658}, puis redescendez à {area:702}.",

	-- Step 70: Back to Teldrassil
	-- {zone:1438} Teldrassil
	["Back to {zone:1438}"] = "Retour à {zone:1438}",

	-- Step 71: Daryn Lightwind
	-- {npc:7907} Daryn Lightwind · {npc:7916} Erelas Ambersky
	["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Climb back to {npc:8405} at the {area:1224}, above the ruins."] = "Remontez jusqu'à {npc:8405}, à {area:1224}, au-dessus des ruines.",
	-- ["Fly from {zone:1455} to {area:150} and take the boat to {area:442}."] = "Prenez un vol de {zone:1455} pour {area:150} et le bateau pour {area:442}.",
	-- ["Fly from {zone:1455} to {area:69}."] = "Prenez un vol de {zone:1455} pour {area:69}.",
	-- ["Fly to {area:1438}."] = "Prenez un vol pour {area:1438}.",
	-- ["Fly to {area:150} and take the boat to {area:442}, then the boat on to {area:702}."] = "Prenez un vol pour {area:150} et le bateau pour {area:442}, puis le bateau pour {area:702}.",
	-- ["From the {area:442} dock, fly to {area:415}."] = "Depuis le quai d'{area:442}, prenez un vol pour {area:415}.",
	-- ["Hearth to {area:2101}"] = "Pierre de foyer vers {area:2101}",
	-- ["If you skipped {quest:4022}, grind here to level 52.08 to stay on the route's plan."] = "Si vous avez passé {quest:4022}, tuez des monstres ici jusqu'au niveau 52.08 pour suivre le plan de l'itinéraire.",
	-- ["Level 50.89"] = "Niveau 50.89",
	-- ["Level 51.39"] = "Niveau 51.39",
	-- ["On the way"] = "En chemin",
	-- ["Optional: {npc:8888}'s ghost stands on his tomb on the great chain inside {area:254}, and only the dead can see him. If you die near the mountain anyway, run your spirit to him before resurrecting."] = "Facultatif : le fantôme de {npc:8888} se tient sur sa tombe, sur la grande chaîne à l'intérieur de {area:254}, et seuls les morts peuvent le voir. Si vous mourez près de la montagne de toute façon, menez votre esprit jusqu'à lui avant de ressusciter.",
	-- ["Read the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript."] = "Lisez la tablette dans le camp {object:147516} parmi les ruines, au sud-ouest de {area:251}, pour en copier la transcription.",
	-- ["Ride back to {area:1438} and fly to {area:348}. The Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "Revenez à {area:1438} et prenez un vol pour {area:348}. Les Plumes d'Indomptable jonchent le sol dans {zone:1425}, au sud et à l'est de {area:348}, là où rôdent les chouettards ; les monstres d'ici sont désormais bien en dessous de votre niveau.",
	-- ["Ride east along the road out of {zone:1440} into {zone:1447} to the Sentinels' camp at {area:3137}."] = "Chevauchez vers l'est par la route hors de {zone:1440} jusqu'en {zone:1447}, au camp des Sentinelles de {area:3137}.",
	-- ["Ride north out of {area:69} through the pass into the {zone:1428}; {area:2418} sits at the top, in the south-east of the Steppes."] = "Chevauchez vers le nord hors de {area:69} par le col jusqu'à {zone:1428} ; {area:2418} se trouve en haut, dans le sud-est des Steppes.",
	-- ["Swim to the small island off the southern tip of {area:16}: {npc:8392} waits by the monument."] = "Nagez jusqu'au petit îlot au large de la pointe sud d'{area:16} : {npc:8392} attend près du monument.",
	-- ["Thaurissan Relics"] = "Reliques de Thaurissan",
	-- ["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered."] = "Les reliques sont les pierres sculptées éparpillées dans {area:250} autour de {area:251} : cliquez dessus jusqu'à ce que l'information soit récupérée.",
	-- ["The shrine lies in the south-west corner of {area:16}, south of {area:3137}."] = "Le sanctuaire se trouve dans le coin sud-ouest d'{area:16}, au sud de {area:3137}.",
	-- ["The {quest:4296}"] = "{quest:4296}",
	-- ["Top up here to level 50.89 before the hand-ins at {zone:1426}: they take you to level 51."] = "Complétez ici jusqu'au niveau 50.89 avant les rendus de quêtes à {zone:1426} : ils vous font passer au niveau 51.",
	-- ["Top up here to level 51.39 before the hand-ins at {area:251}: they take you to level 52."] = "Complétez ici jusqu'au niveau 51.39 avant les rendus de quêtes à {area:251} : ils vous font passer au niveau 52.",
	-- ["Top up here to level 52 before the hand-ins at {area:251}: they take you to level 53."] = "Complétez ici jusqu'au niveau 52 avant les rendus de quêtes à {area:251} : ils vous font passer au niveau 53.",
	-- ["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves."] = "Utilisez le {item:12284} sur un {npc:7047} sur les pentes à l'est de {area:251} juste avant sa mort, puis ramassez l'essence qu'il laisse.",
	-- ["{item:11467} on the way"] = "{item:11467} en chemin",
	-- ["{npc:5111}: the last guide binds here, so this usually ticks at once"] = "{npc:5111} : le guide précédent vous lie ici, cette étape se coche donc généralement aussitôt",
	-- ["{npc:6116} along the way to {area:1235}"] = "{npc:6116} sur le chemin de {area:1235}",
	-- ["{npc:6117} along the way to {area:1235}"] = "{npc:6117} sur le chemin de {area:1235}",
	-- ["{npc:7363} waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have."] = "{npc:7363} attend à {area:2517}, la colline au sud-ouest du donjon. Les monstres des {zone:1419} en chemin laissent tomber les Fragments de draenéthyste imparfaits ; apportez-lui ce que vous avez.",
	-- ["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty."] = "{npc:9176} et les orcs Blackrock tiennent les camps et le Bastion Rochenoire au pied de {area:254}, à l'ouest de {area:251}. Attirez-les un par un ; chaque orc et chaque worg peut laisser tomber un médaillon, tuez-en jusqu'à en avoir cinquante.",
	-- ["{object:153556} on the way"] = "{object:153556} en chemin",
}
