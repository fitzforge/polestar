-- French (frFR): the guide forever/alliance/50-60/01-burning-steppes (forever/alliance/50-60/01-burning-steppes.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Menethil Harbor
	-- {zone:1455} Ironforge · {area:150} Menethil Harbor · {area:442} Auberdine
	["Fly from {zone:1455} to {area:150} and take the boat to {area:442}."] = "Prenez un vol de {zone:1455} pour {area:150} et le bateau pour {area:442}.",

	-- Step 2: Auberdine
	-- {area:442} Auberdine · {area:415} Astranaar
	["From the {area:442} dock, fly to {area:415}."] = "Depuis le quai d'{area:442}, prenez un vol pour {area:415}.",

	-- Step 3: Talrendis Point
	-- {zone:1440} Ashenvale · {zone:1447} Azshara · {area:3137} Talrendis Point
	["Ride east along the road out of {zone:1440} into {zone:1447} to the Sentinels' camp at {area:3137}."] = "Chevauchez vers l'est par la route hors de {zone:1440} jusqu'en {zone:1447}, au camp des Sentinelles de {area:3137}.",

	-- Step 4: Shadowsong Shrine
	-- {zone:1447} Azshara · {area:3137} Talrendis Point
	["The shrine lies in the south-west corner of {zone:1447}, south of {area:3137}."] = "Le Sanctuaire de Shadowsong se trouve dans le coin sud-ouest d'{zone:1447}, au sud de {area:3137}.",

	-- Step 5: Haldarr Encampment
	["The Highborne ghosts haunt the ruins around the shrine; the Haldarr satyrs hold the camp just north of it."] = "Les fantômes bien-nés hantent les ruines autour du sanctuaire ; les satyres Haldarr tiennent le Campement des Haldarr juste au nord.",

	-- Step 7: Ogtinc
	-- {npc:8405} Ogtinc · {area:1224} Bear's Head
	["Ride north-east from the shrine: {npc:8405} camps at the {area:1224}, in the hills above the road."] = "Chevauchez vers le nord-est depuis le sanctuaire : {npc:8405} campe à {area:1224}, dans les collines au-dessus de la route.",

	-- Step 8: Mosshoof Coursers
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers"] = "Coursiers Sabots-de-mousse",
	-- {area:1224} Bear's Head · {area:1219} Legashi Encampment
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south."] = "Les Coursiers Sabots-de-mousse les plus proches paissent dans les collines au nord-est de {area:1224}, vers {area:1219} ; un troupeau plus grand parcourt les terres dégagées au sud.",

	-- Step 10: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo
	-- plural, as words: Undamaged Hippogryph Feathers = {item:10450} Undamaged Hippogryph Feather
	["Optional: {npc:8395} wants two Undamaged Hippogryph Feathers from the hippogryphs around his camp. The data lists no experience for it."] = "Facultatif : {npc:8395} veut deux Plumes d'hippogryphe sans défaut des hippogryphes autour de son camp. Les données n'indiquent aucune expérience pour cette quête.",

	-- Step 11: Kim'jael
	-- {npc:8420} Kim'jael · {area:1219} Legashi Encampment · {area:1220} Thalassian Base Camp
	["{npc:8420} camps at the {area:1219} in the north; his equipment lies all over the {area:1220} just south-east of him."] = "{npc:8420} campe à {area:1219}, au nord ; son équipement est éparpillé dans tout {area:1220}, juste au sud-est.",

	-- Step 12: The Ruins of Eldarath
	-- {area:1221} Ruins of Eldarath
	["The {area:1221}"] = "{area:1221}",
	-- {area:1221} Ruins of Eldarath · {item:13815} Some Rune · {npc:8507} Tymor · {item:10445} Drawing Kit
	["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s four runes stand among the ruins: use his {item:10445} on each."] = "Les nagas Fouette-bile de {area:1221} portent {item:13815}. Les quatre runes de {npc:8507} se dressent parmi les ruines : utilisez son {item:10445} sur chacune.",
	-- {item:7972} Ichor of Undeath · {npc:7864} Lingering Highborne
	["{item:7972}: the {npc:7864}, about 10%"] = "{item:7972} : les {npc:7864}, environ 10 %",

	-- Step 13: Ogtinc
	-- {npc:8405} Ogtinc · {area:1224} Bear's Head
	["Climb back to {npc:8405} at the {area:1224}, above the ruins."] = "Remontez jusqu'à {npc:8405}, à {area:1224}, au-dessus des ruines.",

	-- Step 15: Ravencrest Monument
	-- {zone:1447} Azshara · {npc:8392} Pilot Xiggs Fuselighter
	["Swim to the small island off the southern tip of {zone:1447}: {npc:8392} waits by the monument."] = "Nagez jusqu'au petit îlot au large de la pointe sud d'{zone:1447} : {npc:8392} attend près du Colosse de Ravencrest.",

	-- Step 17: Lakeshire
	-- {zone:1455} Ironforge · {area:69} Lakeshire
	["Fly from {zone:1455} to {area:69}."] = "Prenez un vol de {zone:1455} pour {area:69}.",

	-- Step 18: Morgan's Vigil
	-- {area:69} Lakeshire · {zone:1428} Burning Steppes · {area:2418} Morgan's Vigil
	["Ride north out of {area:69} through the pass into the {zone:1428}; {area:2418} sits at the top, in the south-east of the Steppes."] = "Chevauchez vers le nord hors de {area:69} par le col jusqu'à {zone:1428} ; {area:2418} se trouve en haut, dans le sud-est des Steppes.",
	-- {npc:9177} Oralius
	["{npc:9177}: the Blackrock orcs drop the medallions, keep it open all through the Steppes"] = "{npc:9177} : les orcs Blackrock laissent tomber les médaillons, gardez-la ouverte dans toutes les Steppes",

	-- Step 19: Dreadmaul Rock
	["The Firegut ogres hold the great rock north of the Vigil, with the Brutes on its east side."] = "Les ogres Brûlentrailles tiennent le grand rocher au nord de la Veille, avec les Brutes sur son flanc est.",

	-- Step 21: Flame Crest
	-- {area:251} Flame Crest
	["Follow the road west, then climb north to the goblin camp on {area:251}."] = "Suivez la route vers l'ouest, puis montez vers le nord jusqu'au camp gobelin de {area:251}.",

	-- Step 22: Thaurissan Relics
	-- plural, as words: Thaurissan Relics = {object:153556} Thaurissan Relic
	["Thaurissan Relics"] = "Reliques de Thaurissan",
	-- {area:250} Ruins of Thaurissan · {area:251} Flame Crest
	["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered."] = "Les reliques sont les pierres sculptées éparpillées dans {area:250} autour de {area:251} : cliquez dessus jusqu'à ce que l'information soit récupérée.",

	-- Step 23: The Tablet of the Seven
	-- {quest:4296} Tablet of the Seven
	["The {quest:4296}"] = "{quest:4296}",
	-- {object:147516} Dark Iron · {area:251} Flame Crest
	["Read the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript."] = "Lisez la tablette dans le camp {object:147516} parmi les ruines, au sud-ouest de {area:251}, pour en copier la transcription.",

	-- Step 24: Broodling Essence
	-- {item:12284} Draco-Incarcinatrix 900 · {npc:7047} Black Broodling · {area:251} Flame Crest
	["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves."] = "Utilisez le {item:12284} sur un {npc:7047} sur les pentes à l'est de {area:251} juste avant sa mort, puis ramassez l'essence qu'il laisse.",

	-- Step 25: Flame Crest
	-- {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Ends with {quest:4808} in {area:2255}, {zone:1452}: keep it"] = "Se termine auprès de {quest:4808} à {area:2255}, {zone:1452} : gardez-la",

	-- Step 26: Blackrock Stronghold
	-- {npc:9176} Gor'tesh · {area:254} Blackrock Mountain · {area:251} Flame Crest
	["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty."] = "{npc:9176} et les orcs Blackrock tiennent les camps et le Bastion Rochenoire au pied de {area:254}, à l'ouest de {area:251}. Attirez-les un par un ; chaque orc et chaque worg peut laisser tomber un médaillon, tuez-en jusqu'à en avoir cinquante.",

	-- Step 27: Franclorn Forgewright
	-- {npc:8888} Franclorn Forgewright · {area:254} Blackrock Mountain
	["Optional: {npc:8888}'s ghost stands on his tomb on the great chain inside {area:254}, and only the dead can see him. If you die near the mountain anyway, run your spirit to him before resurrecting."] = "Facultatif : le fantôme de {npc:8888} se tient sur sa tombe, sur la grande chaîne à l'intérieur de {area:254}, et seuls les morts peuvent le voir. Si vous mourez près de la montagne de toute façon, menez votre esprit jusqu'à lui avant de ressusciter.",

	-- Step 28: Morgan's Vigil
	["Ride back east along the road to the Vigil."] = "Revenez vers l'est par la route jusqu'à la Veille.",

	-- Step 29: Dreadmaul Rock
	-- {area:249} Dreadmaul Rock
	["Climb to the top of {area:249} and plant the head in the soft dirt mound."] = "Montez au sommet de {area:249} et plantez la tête dans le monticule de terre meuble.",

	-- Step 31: Nethergarde Keep
	-- {area:1438} Nethergarde Keep
	["Fly to {area:1438}."] = "Prenez un vol pour {area:1438}.",

	-- Step 32: Kum'isha the Collector
	-- {npc:7363} Kum'isha the Collector · {area:2517} Rise of the Defiler · {zone:1419} Blasted Lands
	-- plural, as words: Imperfect Draenethyst Fragments = {item:10593} Imperfect Draenethyst Fragment
	["{npc:7363} waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have."] = "{npc:7363} attend à {area:2517}, la colline au sud-ouest du donjon. Les monstres des {zone:1419} en chemin laissent tomber les Fragments de draenéthyste imparfaits ; apportez-lui ce que vous avez.",

	-- Step 33: Wildkin feathers
	["Wildkin feathers"] = "Plumes d'Indomptable",
	-- {area:1438} Nethergarde Keep · {area:348} Aerie Peak · {zone:1425} Hinterlands
	-- plural, as words: Wildkin Feathers = {item:10819} Wildkin Feather
	["Ride back to {area:1438} and fly to {area:348}. The Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "Revenez à {area:1438} et prenez un vol pour {area:348}. Les Plumes d'Indomptable jonchent le sol dans {zone:1425}, au sud et à l'est de {area:348}, là où rôdent les chouettards ; les monstres d'ici sont désormais bien en dessous de votre niveau.",

	-- Step 35: Menethil Harbor
	-- {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village
	["Fly to {area:150} and take the boat to {area:442}, then the boat on to {area:702}."] = "Prenez un vol pour {area:150} et le bateau pour {area:442}, puis le bateau pour {area:702}.",

	-- Step 36: Rut'theran Village
	-- {zone:1452} Winterspring
	["The wildkin are in {zone:1452}: keep it"] = "Les Indomptables sont au {zone:1452} : gardez-la",

	-- Step 37: Druid training
	["Druid training"] = "Entraînement de druide",
	-- {zone:1455} Ironforge · {zone:1457} Darnassus · {area:1658} Cenarion Enclave · {area:702} Rut'theran Village
	["{zone:1455} has no druid trainer: take the portal up to {zone:1457} and train in the {area:1658}, then come back down to {area:702}."] = "{zone:1455} n'a pas de maître des druides : prenez le portail pour monter à {zone:1457} et entraînez-vous à {area:1658}, puis redescendez à {area:702}.",
}
