-- German (deDE): the guide forever/class/shaman/call-of-air-horde (forever/class/shaman/call-of-air-horde.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:1531} Call of Air
	["{quest:1531} and the Tempest's Weapons (Horde)"] = "{quest:1531} und die Waffen des Sturms (Horde)",
	-- {item:5178} Air Totem
	["The {item:5178} that lets you place air totems, then a weapon of your choice at 40."] = "{item:5178}, mit dem du Lufttotems aufstellen kannst, dann mit 40 eine Waffe deiner Wahl.",

	-- Step 1: Searn Firewarder
	-- {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom · {npc:5905} Prate Cloudseer · {zone:1441} Thousand Needles · {spell:10596} Nature Resistance · {item:5178} Air Totem
	["At 30 {npc:5892} in the {object:172957} sends you to {npc:5905} in {zone:1441}. Your level 30 air totems (Grounding, {spell:10596}) need the {item:5178} she gives."] = "Mit 30 schickt dich {npc:5892} im {object:172957} zu {npc:5905} in {zone:1441}. Deine Lufttotems der Stufe 30 (Erdungstotem, {spell:10596}) brauchen {item:5178}, das sie dir gibt.",

	-- Step 2: Alaana Stormwalker
	-- {quest:96136} Call of Air · {npc:259119} Alaana Stormwalker · {zone:1412} Mulgore · {zone:1456} Thunder Bluff · {npc:5906} Xanis Flameweaver
	["At 30 Skyborne shamans get their own {quest:96136}. {npc:259119} waits where the airship from Zephras Isle lands, in northern {zone:1412} beside {zone:1456}. Your level 30 air totems need the Air Totem Prate Cloudseer gives. If she has nothing for you, head up to {npc:5906} in {zone:1456} (next step): the trainers' {quest:96136} is open to Skyborne and gives the same totem."] = "Mit 30 bekommen Himmelsgeborene-Schamanen ihre eigene {quest:96136}. {npc:259119} wartet dort, wo das Luftschiff von Zephras Isle landet, im Norden von {zone:1412} bei {zone:1456}. Deine Lufttotems der Stufe 30 brauchen das Lufttotem, das Prate Cloudseer gibt. Wenn sie nichts für dich hat, geh hinauf zu {npc:5906} in {zone:1456} (nächster Schritt): Die {quest:96136} der Lehrer steht Himmelsgeborenen offen und gibt dasselbe Totem.",

	-- Step 3: Xanis Flameweaver
	-- {npc:5906} Xanis Flameweaver · {area:1640} Spirit Rise · {zone:1456} Thunder Bluff · {npc:5905} Prate Cloudseer · {zone:1441} Thousand Needles · {spell:10596} Nature Resistance · {npc:5892} Searn Firewarder · {quest:1531} Call of Air · {zone:1454} Orgrimmar
	["At 30 {npc:5906}, a shaman trainer on {area:1640} in {zone:1456}, sends you to {npc:5905} in {zone:1441}. Your level 30 air totems (Grounding, {spell:10596}) need the Air Totem Prate gives. Already carry {npc:5892}'s {quest:1531} from {zone:1454}? It goes to {npc:5905} too: skip {npc:5906}."] = "Mit 30 schickt dich {npc:5906}, ein Schamanenlehrer auf {area:1640} in {zone:1456}, zu {npc:5905} in {zone:1441}. Deine Lufttotems der Stufe 30 (Erdungstotem, {spell:10596}) brauchen das Lufttotem, das Prate gibt. Trägst du schon {quest:1531} von {npc:5892} aus {zone:1454} bei dir? Sie geht auch an {npc:5905}: Überspringe {npc:5906}.",

	-- Step 4: Prate Cloudseer
	-- {area:484} Freewind Post · {npc:5905} Prate Cloudseer
	["Fly to {area:484}. {npc:5905} stands on a ledge above a cave mouth in the canyon wall north-east of the post, not inside the cave: climb the slope beside it. She also gives you an hour of faster attacks and running."] = "Flieg nach {area:484}. {npc:5905} steht auf einem Felsvorsprung über einem Höhleneingang in der Canyonwand nordöstlich des Postens, nicht in der Höhle: Klettere den Hang daneben hinauf. Sie gibt dir außerdem eine Stunde schnellere Angriffe und schnelleres Laufen.",

	-- Step 5
	-- {npc:5905} Prate Cloudseer · {item:5178} Air Totem
	["{npc:5905}: your {item:5178}"] = "{npc:5905}: dein {item:5178}",

	-- Step 9: Charlga Razorflank
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {npc:4421} Charlga Razorflank · {spell:8292} Chain Bolt · {spell:139} Renew · {item:274463} Tattered Note
	["{area:1717} is a five-player dungeon at the southern edge of the {zone:1413} (the arrow points at its entrance); {npc:4421} (level 33 elite) is its last boss. She casts {spell:8292}, {spell:139} on her allies and Purity; the {item:274463} drops only from her."] = "{area:1717} ist ein Dungeon für fünf Spieler am südlichen Rand von {zone:1413} (der Pfeil zeigt auf seinen Eingang); {npc:4421} (Elite der Stufe 33) ist sein letzter Boss. Sie wirkt {spell:8292}, {spell:139} auf ihre Verbündeten und Purity; {item:274463} fällt nur bei ihr.",
	-- {item:274463} Tattered Note · {npc:4421} Charlga Razorflank
	["{item:274463}, from {npc:4421}"] = "{item:274463}, von {npc:4421}",

	-- Step 10: Rau Cliffrunner
	-- {npc:4722} Rau Cliffrunner · {area:484} Freewind Post
	["{npc:4722} stands at {area:484}."] = "{npc:4722} steht in {area:484}.",

	-- Step 12: Twisted Air Totems
	-- plural, as words: Twisted Air Totems = {item:274047} Twisted Air Totem
	["Twisted Air Totems"] = "Verdrehte Lufttotems",
	-- {area:2408} Shadowprey Village · {zone:1443} Desolace · {spell:9654} Jumping Lightning
	-- plural, as words: Twisted Air Totems = {item:274047} Twisted Air Totem
	["Five Twisted Air Totems. The Maraudine centaurs (level 36-40) north and north-east of {area:2408} in western {zone:1443} carry them; the Scouts drop one nearly every other kill. Wranglers Net and Disarm, Windchasers heal, Stormers throw {spell:9654}: pull one at a time. Respawn about five minutes."] = "Fünf Twisted Air Totems. Die Maraudine-Zentauren (Stufe 36-40) nördlich und nordöstlich von {area:2408} im Westen von {zone:1443} tragen sie; die Scouts lassen bei fast jedem zweiten Kill eines fallen. Wranglers werfen Netz und Entwaffnen, Windchasers heilen, Stormers werfen {spell:9654}: Zieh einen nach dem anderen. Respawn etwa fünf Minuten.",

	-- Step 13: Twisted Water Totems
	-- plural, as words: Twisted Water Totems = {item:274046} Twisted Water Totem
	["Twisted Water Totems"] = "Verdrehte Wassertotems",
	-- {area:496} Brackenwall Village · {zone:1445} Dustwallow Marsh
	-- plural, as words: Twisted Water Totems = {item:274046} Twisted Water Totem
	["Five Twisted Water Totems. The Mirefin murlocs (level 35-38) north-east of {area:496} in northern {zone:1445} carry them."] = "Fünf Twisted Water Totems. Die Mirefin-Murlocs (Stufe 35-38) nordöstlich von {area:496} im Norden von {zone:1445} tragen sie.",

	-- Step 14: Twisted Fire Totems
	-- plural, as words: Twisted Fire Totems = {item:274044} Twisted Fire Totem
	["Twisted Fire Totems"] = "Verdrehte Feuertotems",
	-- {area:338} Angor Fortress · {zone:1418} Badlands · {npc:3560} Healing Ward
	-- plural, as words: Twisted Fire Totems = {item:274044} Twisted Fire Totem · Fire Nova Totems = {npc:5879} Fire Nova Totem
	["Five Twisted Fire Totems. The Stonevault troggs (Skullthumpers, Bonesnappers and Shamans, level 37-41) south of {area:338} in the {zone:1418} carry them; the Shamans drop Fire Nova Totems and a {npc:3560}, the Bonesnappers run for help when hurt. Respawn about five minutes."] = "Fünf Twisted Fire Totems. Die Stonevault-Troggs (Skullthumpers, Bonesnappers und Shamans, Stufe 37-41) südlich von {area:338} in den {zone:1418} tragen sie; die Shamans lassen Fire Nova Totems und einen {npc:3560} fallen, die Bonesnappers rufen bei Verletzung um Hilfe. Respawn etwa fünf Minuten.",

	-- Step 15: Twisted Earth Totems
	-- plural, as words: Twisted Earth Totems = {item:274045} Twisted Earth Totem
	["Twisted Earth Totems"] = "Verdrehte Erdtotems",
	-- {area:75} Stonard · {zone:1435} Swamp of Sorrows
	-- plural, as words: Twisted Earth Totems = {item:274045} Twisted Earth Totem · The Lost Ones = {npc:256028} The Lost One
	["Five Twisted Earth Totems. The Lost Ones (murlocs, level 34-39) north and north-east of {area:75} in the {zone:1435} carry them; most run for help when hurt."] = "Fünf Twisted Earth Totems. Die Lost Ones (Murlocs, Stufe 34-39) nördlich und nordöstlich von {area:75} im {zone:1435} tragen sie; die meisten rufen bei Verletzung um Hilfe.",

	-- Step 17: The steam pools
	["The steam pools"] = "Die Dampfbecken",
	-- {npc:5905} Prate Cloudseer · {item:268582} Corrupted Totems · {area:484} Freewind Post · {npc:216474} Ravaging Tempest · {item:212792} Eye of the Tempest
	["{npc:5905} hands you the {item:268582}. Place the {item:268582} at the steam pools north-west of {area:484} to call the corrupted elementals and then the {npc:216474}; Razormane quilboar join the fight while the ritual runs. A group quest: bring at least one or two friends. The {item:212792} drops about every other kill, and every group member can loot it."] = "{npc:5905} gibt dir {item:268582}. Stelle {item:268582} an den Dampfbecken nordwestlich von {area:484} auf, um die verderbten Elementare und dann {npc:216474} herbeizurufen; Razormane-Quilboar mischen sich in den Kampf ein, während das Ritual läuft. Eine Gruppenquest: Bring mindestens einen oder zwei Freunde mit. {item:212792} fällt etwa bei jedem zweiten Kill, und jedes Gruppenmitglied kann es plündern.",
	-- {item:212792} Eye of the Tempest · {npc:216474} Ravaging Tempest
	["{item:212792}, from the {npc:216474}"] = "{item:212792}, von {npc:216474}",

	-- Step 19: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher · {zone:1416} Alterac Mountains · {area:272} Tarren Mill · {item:280607} Lightning's Grasp · {item:280605} Tidebringer's Claw · {item:280604} Rage of the Storm · {item:280696} Elementalist's Guard
	["{npc:6176} camps in the ruins in the east of {zone:1416}: from {area:272} follow the river east of town north into the hills. Pick your weapon: {item:280607}, {item:280605} or {item:280604}; the {item:280696} shield comes with it."] = "{npc:6176} lagert in den Ruinen im Osten des {zone:1416}: Folge von {area:272} aus dem Fluss östlich der Stadt nach Norden in die Hügel. Wähle deine Waffe: {item:280607}, {item:280605} oder {item:280604}; der Schild {item:280696} gehört dazu.",
	-- {npc:6176} Bath'rah the Windwatcher · {item:280696} Elementalist's Guard
	["{npc:6176}: the {item:280696} and your weapon"] = "{npc:6176}: {item:280696} und deine Waffe",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 30 {npc:5892} in the {object:172957} sends you to {npc:5905} in {zone:1441}."] = "Mit 30 schickt dich {npc:5892} im {object:172957} zu {npc:5905} in {zone:1441}.",
	-- ["At 30 {npc:5906}, a shaman trainer in {zone:1456}, sends you to {npc:5905} in {zone:1441}."] = "Mit 30 schickt dich {npc:5906}, ein Schamanenlehrer in {zone:1456}, zu {npc:5905} in {zone:1441}.",
	-- ["Fly to {area:484}. {npc:5905} hides in a small cave in the canyon wall north-east of the post. Skyborne: your own {quest:1531} (96136) ends with her too."] = "Flieg nach {area:484}. {npc:5905} versteckt sich in einer kleinen Höhle in der Schluchtwand nordöstlich des Postens. Himmelsgeborene: Deine eigene {quest:1531} (96136) endet ebenfalls bei ihr.",
	-- ["The Lost Ones in the north of the {zone:1435} carry the Twisted Earth Totems."] = "Die Verlorenen im Norden der {zone:1435} tragen die Verdrehten Erdtotems.",
	-- ["The Maraudine centaurs of western {zone:1443} carry the Twisted Air Totems."] = "Die Zentauren der Maraudine im Westen von {zone:1443} tragen die Verdrehten Lufttotems.",
	-- ["The Mirefin murlocs of northern {zone:1445} carry the Twisted Water Totems."] = "Die Murlocs der Schlammflossen im Norden der {zone:1445} tragen die Verdrehten Wassertotems.",
	-- ["The Stonevault troggs in the south of the {zone:1418} carry the Twisted Fire Totems."] = "Die Steingrufttroggs im Süden des {zone:1418} tragen die Verdrehten Feuertotems.",
	-- ["{area:1717} is a dungeon at the southern edge of the {zone:1413} (the arrow points at its entrance); {npc:4421} is its last boss. Bring a group."] = "{area:1717} ist ein Dungeon am Südrand des {zone:1413} (der Pfeil zeigt auf den Eingang); {npc:4421} ist sein letzter Boss. Bring eine Gruppe mit.",
	-- ["{npc:5905} hands you the {item:268582}: place them at the steam pools west of {area:484} and defeat the {npc:216474} they call. {quest:79366} is an elite quest: grouping up is advised."] = "{npc:5905} Cloudseer gibt dir {item:268582}: Stell sie an den Dampfbecken westlich von {area:484} auf und besiege {npc:216474}, den sie rufen. {quest:79366} ist eine Elite-Quest: Eine Gruppe wird empfohlen.",
	-- ["{npc:6176} camps in the east of {zone:1416}, north-east of {area:272}."] = "{npc:6176} lagert im Osten des {zone:1416}, nordöstlich von {area:272}.",
	-- ["{npc:6176}: the {item:213086} and your weapon"] = "{npc:6176}: {item:213086} und deine Waffe",
}
