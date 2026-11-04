-- French (frFR): the guide forever/class/shaman/call-of-earth-horde (forever/class/shaman/call-of-earth-horde.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:1516} Call of Earth
	["{quest:1516} (Horde)"] = "{quest:1516} (Horde)",
	-- {item:5175} Earth Totem · {spell:8071} Stoneskin Totem
	["Your {item:5175}: without it no earth totem can be cast. {spell:8071} comes with it at level 4."] = "Votre {item:5175} : sans lui, aucun totem de terre ne peut être posé. {spell:8071} vient avec, au niveau 4.",

	-- Step 1: Canaga Earthcaller
	-- {npc:5887} Canaga Earthcaller · {area:363} Valley of Trials
	["{npc:5887} stands just outside the Den, the cave in the middle of the {area:363}. The quest opens at level 4."] = "{npc:5887} se tient juste devant l'Antre, la grotte au milieu de la {area:363}. La quête s'ouvre au niveau 4.",

	-- Step 2: Felstalker Hooves
	["Felstalker Hooves"] = "Sabots de traqueur corrompu",
	-- {area:365} Burning Blade Coven · {npc:3102} Felstalker
	-- plural, as words: Felstalkers = {npc:3102} Felstalker · Vile Familiars = {npc:3101} Vile Familiar
	["Felstalkers (level 3-4) prowl the slope below the {area:365}, the cave in the north of the valley, and just inside its mouth among the Vile Familiars. Nearly every {npc:3102} drops a hoof (four kills in five); they respawn in a little over three minutes."] = "Les Traqueurs corrompus (niveau 3-4) rôdent sur la pente sous le {area:365}, la grotte au nord de la vallée, et juste à l'entrée parmi les Vils quasits. Presque chaque {npc:3102} lâche un sabot (quatre fois sur cinq) ; ils réapparaissent en un peu plus de trois minutes.",

	-- Step 3: Canaga Earthcaller
	-- {npc:5887} Canaga Earthcaller · {quest:1462} Earth Sapta
	["Back to {npc:5887} outside the Den. She hands you the {quest:1462}: do not drink it yet."] = "Retournez voir {npc:5887} devant l'Antre. Elle vous remet le {quest:1462} : ne le buvez pas encore.",

	-- Step 4: Lost the Earth Sapta?
	-- {quest:1463} Earth Sapta
	["Lost the {quest:1463}?"] = "Vous avez perdu le {quest:1463} ?",
	-- {quest:1463} Earth Sapta · {npc:5887} Canaga Earthcaller
	["Only if the {quest:1463} is gone from your bags (drunk away from the rock, or sold): {npc:5887} gives you another."] = "Seulement si le {quest:1463} n'est plus dans vos sacs (bu loin du rocher, ou vendu) : {npc:5887} vous en donne un autre.",
	-- {npc:5887} Canaga Earthcaller · {quest:1463} Earth Sapta
	["{npc:5887}: a new {quest:1463}"] = "{npc:5887} : un nouveau {quest:1463}",

	-- Step 5: Spirit Rock
	-- {area:639} Spirit Rock · {area:638} Hidden Path · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth
	["{area:639} sits on a ledge in the hills just south of the Den. The {area:638} up starts at the foot of the hills south-west of the Den, between two idle peons; it climbs south-west into the hills, then bends back east to the rock. Stand right beside the stone and drink the {item:6635}: the {npc:5891} appears for a short while, so speak to it at once (walk almost under it if it does not answer). Coming back, you can drop down the ledge towards the Den instead of walking the path."] = "Le {area:639} se trouve sur une corniche dans les collines, juste au sud de l'Antre. Le {area:638} qui y monte part du pied des collines au sud-ouest de l'Antre, entre deux péons oisifs ; il grimpe vers le sud-ouest dans les collines, puis repart vers l'est jusqu'au rocher. Placez-vous tout contre la pierre et buvez le {item:6635} : la {npc:5891} apparaît peu de temps, parlez-lui donc aussitôt (avancez presque sous elle si elle ne répond pas). Au retour, vous pouvez sauter de la corniche vers l'Antre au lieu de reprendre le sentier.",
	-- {item:6635} Earth Sapta · {area:639} Spirit Rock
	["{item:6635}, beside {area:639}"] = "{item:6635}, à côté du {area:639}",
	-- {item:6656} Rough Quartz
	["it hands you the {item:6656}: keep it"] = "elle vous remet le {item:6656} : gardez-le",

	-- Step 6: Canaga Earthcaller
	-- {item:6656} Rough Quartz · {npc:5887} Canaga Earthcaller · {item:5175} Earth Totem
	["Bring the {item:6656} back to {npc:5887} outside the Den. Keep the {item:5175} she gives you in your bags for good: every earth totem needs it."] = "Rapportez le {item:6656} à {npc:5887} devant l'Antre. Gardez dans vos sacs pour de bon le {item:5175} qu'elle vous donne : chaque totem de terre en a besoin.",
	-- {npc:5887} Canaga Earthcaller · {spell:8071} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5887}: {spell:8071} and your {item:5175}"] = "{npc:5887} : {spell:8071} et votre {item:5175}",
	["the level 4 shaman spells"] = "les sorts de chaman du niveau 4",

	-- Step 7: Seer Ravenfeather
	-- {npc:5888} Seer Ravenfeather · {area:221} Camp Narache
	["{npc:5888} stands in {area:221}. She may show no quest mark over her head: speak to her anyway. The quest opens at level 4."] = "{npc:5888} se tient au {area:221}. Elle n'affiche parfois aucun point d'exclamation au-dessus de la tête : parlez-lui quand même. La quête s'ouvre au niveau 4.",

	-- Step 8: Ritual Salve
	-- {area:358} Brambleblade Ravine · {spell:403} Lightning Bolt
	-- plural, as words: Bristleback Shamans = {npc:2953} Bristleback Shaman
	["The Bristleback Shamans (level 3-4) stand among the quilboar huts of {area:358}, east of the camp, and throw the odd {spell:403}. Four kills in five drop a salve; they respawn in about four minutes."] = "Les Chamans Dos-hirsute (niveau 3-4) se tiennent parmi les huttes des hurans du {area:358}, à l'est du camp, et lancent de temps en temps un {spell:403}. Quatre fois sur cinq, ils lâchent un onguent ; ils réapparaissent en quatre minutes environ.",

	-- Step 9: Seer Ravenfeather
	-- {area:221} Camp Narache · {quest:1462} Earth Sapta
	["Back to the Seer in {area:221}. She hands you the {quest:1462}: do not drink it yet."] = "Retournez voir la Prophétesse au {area:221}. Elle vous remet le {quest:1462} : ne le buvez pas encore.",

	-- Step 10: Lost the Earth Sapta?
	-- {quest:1462} Earth Sapta
	["Lost the {quest:1462}?"] = "Vous avez perdu le {quest:1462} ?",
	-- {quest:1462} Earth Sapta
	["Only if the {quest:1462} is gone from your bags: the Seer gives you another."] = "Seulement si le {quest:1462} n'est plus dans vos sacs : la Prophétesse vous en donne un autre.",
	-- {npc:5888} Seer Ravenfeather · {quest:1462} Earth Sapta
	["{npc:5888}: a new {quest:1462}"] = "{npc:5888} : un nouveau {quest:1462}",

	-- Step 11: Kodo Rock
	-- {area:637} Kodo Rock · {npc:2991} Greatmother Hawkwind · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth
	["{area:637} is a small pillar on a low mound due east of {npc:2991}'s well, east of the camp; it only shows from about fifteen yards away, and hostile boars graze around it. Stand beside it and drink the {item:6635}, then speak to the {npc:5891} before it fades (drink again if it does)."] = "Le {area:637} est un petit pilier sur un monticule bas, plein est du puits de {npc:2991}, à l'est du camp ; il n'apparaît qu'à une quinzaine de mètres, et des sangliers hostiles paissent autour. Placez-vous à côté et buvez le {item:6635}, puis parlez à la {npc:5891} avant qu'elle ne disparaisse (buvez de nouveau si c'est le cas).",
	-- {item:6635} Earth Sapta · {area:637} Kodo Rock
	["{item:6635}, beside {area:637}"] = "{item:6635}, à côté du {area:637}",

	-- Step 12: Seer Ravenfeather
	-- {item:6656} Rough Quartz · {item:5175} Earth Totem
	["Bring the {item:6656} back to the Seer. Keep the {item:5175} in your bags for good: every earth totem needs it."] = "Rapportez le {item:6656} à la Prophétesse. Gardez le {item:5175} dans vos sacs pour de bon : chaque totem de terre en a besoin.",
	-- {npc:5888} Seer Ravenfeather · {spell:8071} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5888}: {spell:8071} and your {item:5175}"] = "{npc:5888} : {spell:8071} et votre {item:5175}",

	-- Step 13: Windshaper Boro
	-- {npc:251374} Windshaper Boro · {area:16635} Thendal Village
	["{npc:251374}, the shaman trainer, stands in {area:16635}. The quest opens at level 3."] = "{npc:251374}, le maître des chamans, se tient à {area:16635}. La quête s'ouvre au niveau 3.",

	-- Step 14: Signet of Akir
	-- {item:251924} Signet of Akir · {npc:252095} Hanaa Nightwind
	["Any Al'Aketh cultist can carry the {item:251924}: the Converts (level 2-3) around the standing stones just east of the village, or the Brutes and Neophytes (level 4) in the camp beyond {npc:252095}, south-west of the village. Keep killing until one drops it."] = "N'importe quel sectateur d'Al'Aketh peut porter le {item:251924} : les Convertis (niveau 2-3) autour des pierres levées juste à l'est du village, ou les Brutes et les Néophytes (niveau 4) dans le camp au-delà de {npc:252095}, au sud-ouest du village. Tuez-en jusqu'à ce que l'un d'eux le lâche.",

	-- Step 15: Windshaper Boro
	-- {area:16635} Thendal Village · {quest:1462} Earth Sapta
	["Back to Boro in {area:16635}. He hands you the {quest:1462}: do not drink it yet."] = "Retournez voir Boro à {area:16635}. Il vous remet le {quest:1462} : ne le buvez pas encore.",

	-- Step 16: The Rise of Spirits
	-- {area:16988} Rise of Spirits
	["The {area:16988}"] = "Le {area:16988}",
	-- {area:16988} Rise of Spirits · {item:6635} Earth Sapta · {npc:251166} Minor Manifestation of Earth
	["The {area:16988} is the hilltop shrine north-east of Boro: the path up starts on the hill just above the clearing where the flies were. Drink the {item:6635} beside the shrine and speak to the {npc:251166} before it fades."] = "Le {area:16988} est le sanctuaire au sommet de la colline, au nord-est de Boro : le chemin qui y monte part de la colline juste au-dessus de la clairière où se trouvaient les mouches. Buvez le {item:6635} à côté du sanctuaire et parlez à la {npc:251166} avant qu'elle ne disparaisse.",
	-- {item:6635} Earth Sapta
	["{item:6635}, beside the shrine"] = "{item:6635}, à côté du sanctuaire",

	-- Step 17: Windshaper Boro
	-- {item:6656} Rough Quartz · {item:5175} Earth Totem
	["Bring the {item:6656} back to Boro. Keep the {item:5175} in your bags for good: every earth totem needs it."] = "Rapportez le {item:6656} à Boro. Gardez le {item:5175} dans vos sacs pour de bon : chaque totem de terre en a besoin.",
	-- {npc:251374} Windshaper Boro · {spell:8071} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:251374}: {spell:8071} and your {item:5175}"] = "{npc:251374} : {spell:8071} et votre {item:5175}",
}
