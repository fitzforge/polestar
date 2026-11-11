-- German (deDE): the guide forever/class/shaman/call-of-air-alliance (forever/class/shaman/call-of-air-alliance.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94789} Call of Air
	["{quest:94789} and the Tempest's Weapons (Alliance)"] = "{quest:94789} und die Waffen des Sturms (Allianz)",
	-- {item:5178} Air Totem
	["The {item:5178} that lets you place air totems, then a weapon of your choice at 40."] = "Das {item:5178}, mit dem du Lufttotems aufstellst, dann eine Waffe deiner Wahl auf Stufe 40.",

	-- Step 1: Eldrun Stormbreaker
	-- {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge · {npc:259023} Veyric Thunderhame · {zone:1417} Arathi Highlands · {spell:10596} Nature Resistance · {item:5178} Air Totem
	["At 30 {npc:258098}, the shaman trainer in {zone:1455}, sends you to {npc:259023} in {zone:1417}. Your level 30 air totems (Grounding, {spell:10596}) need the {item:5178} he gives."] = "Mit 30 schickt dich {npc:258098}, der Schamanenlehrer in {zone:1455}, zu {npc:259023} in {zone:1417}. Deine Lufttotems der Stufe 30 (Erdungstotem, {spell:10596}) brauchen {item:5178}, das er dir gibt.",

	-- Step 2: Veyric Thunderhame
	-- {npc:259023} Veyric Thunderhame · {area:321} Hammerfall · {area:320} Refuge Pointe
	["{npc:259023} camps in the hills just west of {area:321}, the Horde town in the north-east of Arathi: mind its guards. Fly to {area:320} and head north-east."] = "{npc:259023} lagert in den Hügeln westlich von {area:321}, der Horde-Stadt im Nordosten von Arathi: Hüte dich vor ihren Wachen. Flieg nach {area:320} und geh nach Nordosten.",
	-- {npc:259023} Veyric Thunderhame · {item:5178} Air Totem
	["{npc:259023}: your {item:5178}"] = "{npc:259023}: dein {item:5178}",

	-- Step 3: Charlga Razorflank
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {npc:4421} Charlga Razorflank · {spell:8292} Chain Bolt · {spell:139} Renew · {item:274463} Tattered Note
	["{area:1717} is a five-player dungeon at the southern edge of the {zone:1413} (the arrow points at its entrance); {npc:4421} (level 33 elite) is its last boss. She casts {spell:8292}, {spell:139} on her allies and Purity; the {item:274463} drops only from her."] = "{area:1717} ist ein Dungeon für fünf Spieler am südlichen Rand von {zone:1413} (der Pfeil zeigt auf seinen Eingang); {npc:4421} (Elite der Stufe 33) ist sein letzter Boss. Sie wirkt {spell:8292}, {spell:139} auf ihre Verbündeten und Purity; {item:274463} fällt nur bei ihr.",
	-- {item:274463} Tattered Note · {npc:4421} Charlga Razorflank
	["{item:274463}, from {npc:4421}"] = "{item:274463}, von {npc:4421}",

	-- Step 5: Twisted Fire Totems
	-- plural, as words: Twisted Fire Totems = {item:274044} Twisted Fire Totem
	["Twisted Fire Totems"] = "Verdrehte Feuertotems",
	-- {area:338} Angor Fortress · {zone:1418} Badlands · {npc:3560} Healing Ward
	-- plural, as words: Twisted Fire Totems = {item:274044} Twisted Fire Totem · Fire Nova Totems = {npc:5879} Fire Nova Totem
	["Five Twisted Fire Totems. The Stonevault troggs (Skullthumpers, Bonesnappers and Shamans, level 37-41) south of {area:338} in the {zone:1418} carry them; the Shamans drop Fire Nova Totems and a {npc:3560}, the Bonesnappers run for help when hurt. Respawn about five minutes."] = "Fünf Twisted Fire Totems. Die Stonevault-Troggs (Skullthumpers, Bonesnappers und Shamans, Stufe 37-41) südlich von {area:338} in den {zone:1418} tragen sie; die Shamans lassen Fire Nova Totems und einen {npc:3560} fallen, die Bonesnappers rufen bei Verletzung um Hilfe. Respawn etwa fünf Minuten.",

	-- Step 6: Twisted Earth Totems
	-- plural, as words: Twisted Earth Totems = {item:274045} Twisted Earth Totem
	["Twisted Earth Totems"] = "Verdrehte Erdtotems",
	-- {area:75} Stonard · {zone:1435} Swamp of Sorrows
	-- plural, as words: Twisted Earth Totems = {item:274045} Twisted Earth Totem · The Lost Ones = {npc:256028} The Lost One
	["Five Twisted Earth Totems. The Lost Ones (murlocs, level 34-39) north and north-east of {area:75} in the {zone:1435} carry them; most run for help when hurt."] = "Fünf Twisted Earth Totems. Die Lost Ones (Murlocs, Stufe 34-39) nördlich und nordöstlich von {area:75} im {zone:1435} tragen sie; die meisten rufen bei Verletzung um Hilfe.",

	-- Step 7: Twisted Water Totems
	-- plural, as words: Twisted Water Totems = {item:274046} Twisted Water Totem
	["Twisted Water Totems"] = "Verdrehte Wassertotems",
	-- {area:496} Brackenwall Village · {zone:1445} Dustwallow Marsh
	-- plural, as words: Twisted Water Totems = {item:274046} Twisted Water Totem
	["Five Twisted Water Totems. The Mirefin murlocs (level 35-38) north-east of {area:496} in northern {zone:1445} carry them."] = "Fünf Twisted Water Totems. Die Mirefin-Murlocs (Stufe 35-38) nordöstlich von {area:496} im Norden von {zone:1445} tragen sie.",

	-- Step 8: Twisted Air Totems
	-- plural, as words: Twisted Air Totems = {item:274047} Twisted Air Totem
	["Twisted Air Totems"] = "Verdrehte Lufttotems",
	-- {area:2408} Shadowprey Village · {zone:1443} Desolace · {spell:9654} Jumping Lightning
	-- plural, as words: Twisted Air Totems = {item:274047} Twisted Air Totem
	["Five Twisted Air Totems. The Maraudine centaurs (level 36-40) north and north-east of {area:2408} in western {zone:1443} carry them; the Scouts drop one nearly every other kill. Wranglers Net and Disarm, Windchasers heal, Stormers throw {spell:9654}: pull one at a time. Respawn about five minutes."] = "Fünf Twisted Air Totems. Die Maraudine-Zentauren (Stufe 36-40) nördlich und nordöstlich von {area:2408} im Westen von {zone:1443} tragen sie; die Scouts lassen bei fast jedem zweiten Kill eines fallen. Wranglers werfen Netz und Entwaffnen, Windchasers heilen, Stormers werfen {spell:9654}: Zieh einen nach dem anderen. Respawn etwa fünf Minuten.",

	-- Step 10: The steam pools
	["The steam pools"] = "Die Dampfbecken",
	-- {npc:259023} Veyric Thunderhame · {item:268582} Corrupted Totems · {zone:1441} Thousand Needles · {area:489} Thalanaar · {zone:1444} Feralas · {area:484} Freewind Post · {npc:216474} Ravaging Tempest · {item:212792} Eye of the Tempest
	["{npc:259023} hands you the {item:268582}. {zone:1441} is far: the boat to Theramore and the road west, or fly to {area:489} on the {zone:1444} border and head east into the canyon. Place the {item:268582} at the steam pools north-west of {area:484} to call the corrupted elementals and then the {npc:216474}; Razormane quilboar join the fight while the ritual runs. A group quest: bring at least one or two friends. The {item:212792} drops about every other kill, and every group member can loot it."] = "{npc:259023} gibt dir {item:268582}. {zone:1441} ist weit: das Boot nach Theramore und die Straße nach Westen, oder flieg nach {area:489} an der Grenze zu {zone:1444} und geh nach Osten in die Schlucht. Stelle {item:268582} an den Dampfbecken nordwestlich von {area:484} auf, um die verderbten Elementare und dann {npc:216474} herbeizurufen; Razormane-Quilboar mischen sich in den Kampf ein, während das Ritual läuft. Eine Gruppenquest: Bring mindestens einen oder zwei Freunde mit. {item:212792} fällt etwa bei jedem zweiten Kill, und jedes Gruppenmitglied kann es plündern.",
	-- {item:212792} Eye of the Tempest · {npc:216474} Ravaging Tempest
	["{item:212792}, from the {npc:216474}"] = "{item:212792}, vom {npc:216474}",

	-- Step 12: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher · {zone:1416} Alterac Mountains · {area:272} Tarren Mill · {item:280607} Lightning's Grasp · {item:280605} Tidebringer's Claw · {item:280604} Rage of the Storm
	["{npc:6176} camps in the ruins in the east of {zone:1416}: from {area:272} follow the river east of town north into the hills. Pick your weapon: {item:280607}, {item:280605} or {item:280604}."] = "{npc:6176} lagert in den Ruinen im Osten des {zone:1416}: Folge von {area:272} aus dem Fluss östlich der Stadt nach Norden in die Hügel. Wähle deine Waffe: {item:280607}, {item:280605} oder {item:280604}.",
	-- {npc:6176} Bath'rah the Windwatcher · {item:280696} Elementalist's Guard
	["{npc:6176}: the {item:280696} and your weapon"] = "{npc:6176}: {item:280696} und deine Waffe",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 30 {npc:258098}, the shaman trainer in {zone:1455}, sends you to {npc:259023} in {zone:1417}."] = "Auf Stufe 30 schickt dich {npc:258098}, der Schamanenlehrer in {zone:1455}, zu {npc:259023} im {zone:1417}.",
	-- ["The Lost Ones in the north of the {zone:1435} carry the Twisted Earth Totems."] = "Die Verlorenen im Norden der {zone:1435} tragen die Verdrehten Erdtotems.",
	-- ["The Maraudine centaurs of western {zone:1443} carry the Twisted Air Totems."] = "Die Zentauren der Maraudine im westlichen {zone:1443} tragen die Verdrehten Lufttotems.",
	-- ["The Mirefin murlocs of northern {zone:1445} carry the Twisted Water Totems."] = "Die Murlocs der Schlammflossen in den nördlichen {zone:1445} tragen die Verdrehten Wassertotems.",
	-- ["The Stonevault troggs in the south of the {zone:1418} carry the Twisted Fire Totems."] = "Die Steingrufttroggs im Süden des {zone:1418} tragen die Verdrehten Feuertotems.",
	-- ["{area:1717} is a dungeon at the southern edge of the {zone:1413} (the arrow points at its entrance); {npc:4421} is its last boss. Bring a group."] = "{area:1717} ist ein Dungeon am Südrand von {zone:1413} (der Pfeil zeigt auf den Eingang); {npc:4421} ist der letzte Boss. Bring eine Gruppe mit.",
	-- ["{npc:259023} camps in the northern hills of {zone:1417}."] = "{npc:259023} lagert in den nördlichen Hügeln des {zone:1417}.",
	-- ["{npc:259023} hands you the {item:268582}: place them at the steam pools of {zone:1441} and defeat the {npc:216474} they call. {quest:96135} is an elite quest: grouping up is advised."] = "{npc:259023} gibt dir die {item:268582}: Stell sie an den Dampfbecken von {zone:1441} auf und besiege den {npc:216474}, den sie rufen. {quest:96135} ist eine Elite-Quest: Eine Gruppe wird empfohlen.",
	-- ["{npc:6176} camps in the east of {zone:1416}, north-east of {area:272}."] = "{npc:6176} lagert im Osten des {zone:1416}, nordöstlich von {area:272}.",
}
