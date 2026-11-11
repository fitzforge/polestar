-- German (deDE): the guide forever/class/shaman/call-of-earth-horde (forever/class/shaman/call-of-earth-horde.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:1516} Call of Earth
	["{quest:1516} (Horde)"] = "{quest:1516} (Horde)",
	-- {item:5175} Earth Totem · {spell:8071} Stoneskin Totem
	["Your {item:5175}: without it no earth totem can be cast. {spell:8071} comes with it at level 4."] = "Dein {item:5175}: Ohne es kann kein Erdtotem gewirkt werden. {spell:8071} kommt mit Stufe 4 dazu.",

	-- Step 1: Canaga Earthcaller
	-- {npc:5887} Canaga Earthcaller · {area:363} Valley of Trials
	["{npc:5887} stands just outside the Den, the cave in the middle of the {area:363}. The quest opens at level 4."] = "{npc:5887} steht direkt vor dem Den, der Höhle mitten im {area:363}. Die Quest wird mit Stufe 4 frei.",

	-- Step 2: Felstalker Hooves
	["Felstalker Hooves"] = "Felstalker-Hufe",
	-- {area:365} Burning Blade Coven · {npc:3102} Felstalker
	-- plural, as words: Felstalkers = {npc:3102} Felstalker · Vile Familiars = {npc:3101} Vile Familiar
	["Felstalkers (level 3-4) prowl the slope below the {area:365}, the cave in the north of the valley, and just inside its mouth among the Vile Familiars. Nearly every {npc:3102} drops a hoof (four kills in five); they respawn in a little over three minutes."] = "Felstalkers (Stufe 3-4) streifen über den Hang unterhalb von {area:365}, der Höhle im Norden des Tals, und direkt hinter ihrem Eingang zwischen den Vile Familiars. Fast jeder {npc:3102} lässt einen Huf fallen (vier von fünf Kills); sie respawnen nach etwas über drei Minuten.",

	-- Step 3: Canaga Earthcaller
	-- {npc:5887} Canaga Earthcaller · {quest:1462} Earth Sapta
	["Back to {npc:5887} outside the Den. She hands you the {quest:1462}: do not drink it yet."] = "Zurück zu {npc:5887} vor dem Den. Sie gibt dir {quest:1462}: Trink es noch nicht.",

	-- Step 4: Lost the Earth Sapta?
	-- {quest:1463} Earth Sapta
	["Lost the {quest:1463}?"] = "{quest:1463} verloren?",
	-- {quest:1463} Earth Sapta · {npc:5887} Canaga Earthcaller
	["Only if the {quest:1463} is gone from your bags (drunk away from the rock, or sold): {npc:5887} gives you another."] = "Nur wenn {quest:1463} nicht mehr in deinen Taschen ist (abseits des Felsens getrunken oder verkauft): {npc:5887} gibt dir ein neues.",
	-- {npc:5887} Canaga Earthcaller · {quest:1463} Earth Sapta
	["{npc:5887}: a new {quest:1463}"] = "{npc:5887}: ein neues {quest:1463}",

	-- Step 5: Spirit Rock
	-- {area:639} Spirit Rock · {area:638} Hidden Path · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth
	["{area:639} sits on a ledge in the hills just south of the Den. The {area:638} up starts at the foot of the hills south-west of the Den, between two idle peons; it climbs south-west into the hills, then bends back east to the rock. Stand right beside the stone and drink the {item:6635}: the {npc:5891} appears for a short while, so speak to it at once (walk almost under it if it does not answer). Coming back, you can drop down the ledge towards the Den instead of walking the path."] = "{area:639} liegt auf einem Vorsprung in den Hügeln direkt südlich des Den. Der {area:638} hinauf beginnt am Fuß der Hügel südwestlich des Den, zwischen zwei untätigen Peons; er führt nach Südwesten in die Hügel und biegt dann zurück nach Osten zum Felsen. Stell dich direkt neben den Stein und trink {item:6635}: {npc:5891} erscheint nur kurz, sprich also sofort mit ihr (geh fast unter sie, wenn sie nicht antwortet). Auf dem Rückweg kannst du den Vorsprung in Richtung Den hinunterspringen, statt den Pfad zu gehen.",
	-- {item:6635} Earth Sapta · {area:639} Spirit Rock
	["{item:6635}, beside {area:639}"] = "{item:6635}, neben {area:639}",
	-- {item:6656} Rough Quartz
	["it hands you the {item:6656}: keep it"] = "sie gibt dir {item:6656}: Behalte ihn",

	-- Step 6: Canaga Earthcaller
	-- {item:6656} Rough Quartz · {npc:5887} Canaga Earthcaller · {item:5175} Earth Totem
	["Bring the {item:6656} back to {npc:5887} outside the Den. Keep the {item:5175} she gives you in your bags for good: every earth totem needs it."] = "Bring {item:6656} zurück zu {npc:5887} vor dem Den. Behalte {item:5175}, das sie dir gibt, dauerhaft in deinen Taschen: Jedes Erdtotem braucht es.",
	-- {npc:5887} Canaga Earthcaller · {spell:8071} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5887}: {spell:8071} and your {item:5175}"] = "{npc:5887}: {spell:8071} und dein {item:5175}",
	["the level 4 shaman spells"] = "die Schamanenzauber der Stufe 4",

	-- Step 7: Seer Ravenfeather
	-- {npc:5888} Seer Ravenfeather · {area:221} Camp Narache
	["{npc:5888} stands in {area:221}. She may show no quest mark over her head: speak to her anyway. The quest opens at level 4."] = "{npc:5888} steht in {area:221}. Über ihrem Kopf ist vielleicht kein Questzeichen: Sprich sie trotzdem an. Die Quest wird mit Stufe 4 frei.",

	-- Step 8: Ritual Salve
	-- {area:358} Brambleblade Ravine · {spell:403} Lightning Bolt
	-- plural, as words: Bristleback Shamans = {npc:2953} Bristleback Shaman
	["The Bristleback Shamans (level 3-4) stand among the quilboar huts of {area:358}, east of the camp, and throw the odd {spell:403}. Four kills in five drop a salve; they respawn in about four minutes."] = "Die Bristleback Shamans (Stufe 3-4) stehen zwischen den Quilboar-Hütten von {area:358}, östlich des Lagers, und werfen gelegentlich {spell:403}. Vier von fünf Kills lassen eine Salbe fallen; sie respawnen nach etwa vier Minuten.",

	-- Step 9: Seer Ravenfeather
	-- {area:221} Camp Narache · {quest:1462} Earth Sapta
	["Back to the Seer in {area:221}. She hands you the {quest:1462}: do not drink it yet."] = "Zurück zur Seherin in {area:221}. Sie gibt dir {quest:1462}: Trink es noch nicht.",

	-- Step 10: Lost the Earth Sapta?
	-- {quest:1462} Earth Sapta
	["Lost the {quest:1462}?"] = "{quest:1462} verloren?",
	-- {quest:1462} Earth Sapta
	["Only if the {quest:1462} is gone from your bags: the Seer gives you another."] = "Nur wenn {quest:1462} nicht mehr in deinen Taschen ist: Die Seherin gibt dir ein neues.",
	-- {npc:5888} Seer Ravenfeather · {quest:1462} Earth Sapta
	["{npc:5888}: a new {quest:1462}"] = "{npc:5888}: ein neues {quest:1462}",

	-- Step 11: Kodo Rock
	-- {area:637} Kodo Rock · {npc:2991} Greatmother Hawkwind · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth
	["{area:637} is a small pillar on a low mound due east of {npc:2991}'s well, east of the camp; it only shows from about fifteen yards away, and hostile boars graze around it. Stand beside it and drink the {item:6635}, then speak to the {npc:5891} before it fades (drink again if it does)."] = "{area:637} ist ein kleiner Pfeiler auf einem niedrigen Hügel genau östlich des Brunnens von {npc:2991}, östlich des Lagers; er ist erst aus etwa fünfzehn Yards Entfernung zu sehen, und feindliche Eber grasen um ihn herum. Stell dich neben ihn und trink {item:6635}, sprich dann mit {npc:5891}, bevor sie verblasst (trink erneut, falls sie es tut).",
	-- {item:6635} Earth Sapta · {area:637} Kodo Rock
	["{item:6635}, beside {area:637}"] = "{item:6635}, neben {area:637}",

	-- Step 12: Seer Ravenfeather
	-- {item:6656} Rough Quartz · {item:5175} Earth Totem
	["Bring the {item:6656} back to the Seer. Keep the {item:5175} in your bags for good: every earth totem needs it."] = "Bring {item:6656} zurück zur Seherin. Behalte {item:5175} dauerhaft in deinen Taschen: Jedes Erdtotem braucht es.",
	-- {npc:5888} Seer Ravenfeather · {spell:8071} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5888}: {spell:8071} and your {item:5175}"] = "{npc:5888}: {spell:8071} und dein {item:5175}",

	-- Step 13: Windshaper Boro
	-- {npc:251374} Windshaper Boro · {area:16635} Thendal Village
	["{npc:251374}, the shaman trainer, stands in {area:16635}. The quest opens at level 3."] = "{npc:251374}, der Schamanenlehrer, steht in {area:16635}. Die Quest wird mit Stufe 3 frei.",

	-- Step 14: Signet of Akir
	-- {item:251924} Signet of Akir · {npc:252095} Hanaa Nightwind
	["Any Al'Aketh cultist can carry the {item:251924}: the Converts (level 2-3) around the standing stones just east of the village, or the Brutes and Neophytes (level 4) in the camp beyond {npc:252095}, south-west of the village. Keep killing until one drops it."] = "Jeder Al'Aketh-Kultist kann {item:251924} tragen: die Converts (Stufe 2-3) bei den Standsteinen direkt östlich des Dorfes oder die Brutes und Neophytes (Stufe 4) im Lager hinter {npc:252095}, südwestlich des Dorfes. Töte weiter, bis einer es fallen lässt.",

	-- Step 15: Windshaper Boro
	-- {area:16635} Thendal Village · {quest:1462} Earth Sapta
	["Back to Boro in {area:16635}. He hands you the {quest:1462}: do not drink it yet."] = "Zurück zu Boro in {area:16635}. Er gibt dir {quest:1462}: Trink es noch nicht.",

	-- Step 16: The Rise of Spirits
	-- {area:16988} Rise of Spirits
	["The {area:16988}"] = "{area:16988}",
	-- {area:16988} Rise of Spirits · {item:6635} Earth Sapta · {npc:251166} Minor Manifestation of Earth
	["The {area:16988} is the hilltop shrine north-east of Boro: the path up starts on the hill just above the clearing where the flies were. Drink the {item:6635} beside the shrine and speak to the {npc:251166} before it fades."] = "{area:16988} ist der Schrein auf der Hügelkuppe nordöstlich von Boro: Der Pfad hinauf beginnt am Hügel direkt über der Lichtung, auf der die Fliegen waren. Trink {item:6635} neben dem Schrein und sprich mit {npc:251166}, bevor sie verblasst.",
	-- {item:6635} Earth Sapta
	["{item:6635}, beside the shrine"] = "{item:6635}, neben dem Schrein",

	-- Step 17: Windshaper Boro
	-- {item:6656} Rough Quartz · {item:5175} Earth Totem
	["Bring the {item:6656} back to Boro. Keep the {item:5175} in your bags for good: every earth totem needs it."] = "Bring {item:6656} zurück zu Boro. Behalte {item:5175} dauerhaft in deinen Taschen: Jedes Erdtotem braucht es.",
	-- {npc:251374} Windshaper Boro · {spell:8071} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:251374}: {spell:8071} and your {item:5175}"] = "{npc:251374}: {spell:8071} und dein {item:5175}",
}
