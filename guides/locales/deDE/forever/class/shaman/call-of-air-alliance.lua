-- German (deDE): the guide forever/class/shaman/call-of-air-alliance (forever/class/shaman/call-of-air-alliance.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge · {npc:259023} Veyric Thunderhame · {zone:1417} Arathi Highlands
	["At 30 {npc:258098}, the shaman trainer in {zone:1455}, sends you to {npc:259023} in {zone:1417}."] = "Auf Stufe 30 schickt dich {npc:258098}, der Schamanenlehrer in {zone:1455}, zu {npc:259023} im {zone:1417}.",

	-- Step 2: Veyric Thunderhame
	-- {npc:259023} Veyric Thunderhame · {zone:1417} Arathi Highlands
	["{npc:259023} camps in the northern hills of {zone:1417}."] = "{npc:259023} lagert in den nördlichen Hügeln des {zone:1417}.",
	-- {npc:259023} Veyric Thunderhame · {item:5178} Air Totem
	["{npc:259023}: your {item:5178}"] = "{npc:259023}: dein {item:5178}",

	-- Step 3: Charlga Razorflank
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {npc:4421} Charlga Razorflank
	["{area:1717} is a dungeon at the southern edge of the {zone:1413} (the arrow points at its entrance); {npc:4421} is its last boss. Bring a group."] = "{area:1717} ist ein Dungeon am Südrand von {zone:1413} (der Pfeil zeigt auf den Eingang); {npc:4421} ist der letzte Boss. Bring eine Gruppe mit.",
	-- {item:274463} Tattered Note · {npc:4421} Charlga Razorflank
	["{item:274463}, from {npc:4421}"] = "{item:274463}, von {npc:4421}",

	-- Step 5: Twisted Fire Totems
	-- plural, as words: Twisted Fire Totems = {item:274044} Twisted Fire Totem
	["Twisted Fire Totems"] = "Verdrehte Feuertotems",
	-- {zone:1418} Badlands
	-- plural, as words: Twisted Fire Totems = {item:274044} Twisted Fire Totem
	["The Stonevault troggs in the south of the {zone:1418} carry the Twisted Fire Totems."] = "Die Steingrufttroggs im Süden des {zone:1418} tragen die Verdrehten Feuertotems.",

	-- Step 6: Twisted Earth Totems
	-- plural, as words: Twisted Earth Totems = {item:274045} Twisted Earth Totem
	["Twisted Earth Totems"] = "Verdrehte Erdtotems",
	-- {zone:1435} Swamp of Sorrows
	-- plural, as words: The Lost Ones = {npc:256028} The Lost One · Twisted Earth Totems = {item:274045} Twisted Earth Totem
	["The Lost Ones in the north of the {zone:1435} carry the Twisted Earth Totems."] = "Die Verlorenen im Norden der {zone:1435} tragen die Verdrehten Erdtotems.",

	-- Step 7: Twisted Water Totems
	-- plural, as words: Twisted Water Totems = {item:274046} Twisted Water Totem
	["Twisted Water Totems"] = "Verdrehte Wassertotems",
	-- {zone:1445} Dustwallow Marsh
	-- plural, as words: Twisted Water Totems = {item:274046} Twisted Water Totem
	["The Mirefin murlocs of northern {zone:1445} carry the Twisted Water Totems."] = "Die Murlocs der Schlammflossen in den nördlichen {zone:1445} tragen die Verdrehten Wassertotems.",

	-- Step 8: Twisted Air Totems
	-- plural, as words: Twisted Air Totems = {item:274047} Twisted Air Totem
	["Twisted Air Totems"] = "Verdrehte Lufttotems",
	-- {zone:1443} Desolace
	-- plural, as words: Twisted Air Totems = {item:274047} Twisted Air Totem
	["The Maraudine centaurs of western {zone:1443} carry the Twisted Air Totems."] = "Die Zentauren der Maraudine im westlichen {zone:1443} tragen die Verdrehten Lufttotems.",

	-- Step 10: The steam pools
	["The steam pools"] = "Die Dampfbecken",
	-- {npc:259023} Veyric Thunderhame · {item:268582} Corrupted Totems · {zone:1441} Thousand Needles · {npc:216474} Ravaging Tempest · {quest:96135} Heed My Call
	["{npc:259023} hands you the {item:268582}: place them at the steam pools of {zone:1441} and defeat the {npc:216474} they call. {quest:96135} is an elite quest: grouping up is advised."] = "{npc:259023} gibt dir die {item:268582}: Stell sie an den Dampfbecken von {zone:1441} auf und besiege den {npc:216474}, den sie rufen. {quest:96135} ist eine Elite-Quest: Eine Gruppe wird empfohlen.",
	-- {item:212792} Eye of the Tempest · {npc:216474} Ravaging Tempest
	["{item:212792}, from the {npc:216474}"] = "{item:212792}, vom {npc:216474}",

	-- Step 12: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher · {zone:1416} Alterac Mountains · {area:272} Tarren Mill
	["{npc:6176} camps in the east of {zone:1416}, north-east of {area:272}."] = "{npc:6176} lagert im Osten des {zone:1416}, nordöstlich von {area:272}.",
	-- {npc:6176} Bath'rah the Windwatcher · {item:280696} Elementalist's Guard
	["{npc:6176}: the {item:280696} and your weapon"] = "{npc:6176}: {item:280696} und deine Waffe",
}
