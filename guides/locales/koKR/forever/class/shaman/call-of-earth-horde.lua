-- Korean (koKR): the guide forever/class/shaman/call-of-earth-horde (forever/class/shaman/call-of-earth-horde.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:1516} Call of Earth
	["{quest:1516} (Horde)"] = "",
	-- {item:5175} Earth Totem · {spell:8071} Stoneskin Totem
	["Your {item:5175}: without it no earth totem can be cast. {spell:8071} comes with it at level 4."] = "",

	-- Step 1: Canaga Earthcaller
	-- {npc:5887} Canaga Earthcaller
	["{npc:5887} stands just outside the Den, the cave in the middle of the Valley of Trials. The quest opens at level 4."] = "",

	-- Step 2: Felstalker Hooves
	["Felstalker Hooves"] = "",
	-- {npc:3102} Felstalker
	-- plural, as words: Felstalkers = {npc:3102} Felstalker · Vile Familiars = {npc:3101} Vile Familiar
	["Felstalkers (level 3-4) prowl the slope below the Burning Blade Coven, the cave in the north of the valley, and just inside its mouth among the Vile Familiars. Nearly every {npc:3102} drops a hoof (four kills in five); they respawn in a little over three minutes."] = "",

	-- Step 3: Canaga Earthcaller
	-- {npc:5887} Canaga Earthcaller · {quest:1462} Earth Sapta
	["Back to {npc:5887} outside the Den. She hands you the {quest:1462}: do not drink it yet."] = "",

	-- Step 4: Lost the Earth Sapta?
	-- {quest:1463} Earth Sapta
	["Lost the {quest:1463}?"] = "",
	-- {quest:1463} Earth Sapta · {npc:5887} Canaga Earthcaller
	["Only if the {quest:1463} is gone from your bags (drunk away from the rock, or sold): {npc:5887} gives you another."] = "",
	-- {npc:5887} Canaga Earthcaller · {quest:1463} Earth Sapta
	["{npc:5887}: a new {quest:1463}"] = "",

	-- Step 5: Spirit Rock
	["Spirit Rock"] = "",
	-- {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth
	["Spirit Rock sits on a ledge in the hills just south of the Den. The Hidden Path up starts at the foot of the hills south-west of the Den, between two idle peons; it climbs south-west into the hills, then bends back east to the rock. Stand right beside the stone and drink the {item:6635}: the {npc:5891} appears for a short while, so speak to it at once (walk almost under it if it does not answer). Coming back, you can drop down the ledge towards the Den instead of walking the path."] = "",
	-- {item:6635} Earth Sapta
	["{item:6635}, beside Spirit Rock"] = "",
	-- {item:6656} Rough Quartz
	["it hands you the {item:6656}: keep it"] = "",

	-- Step 6: Canaga Earthcaller
	-- {item:6656} Rough Quartz · {npc:5887} Canaga Earthcaller · {item:5175} Earth Totem
	["Bring the {item:6656} back to {npc:5887} outside the Den. Keep the {item:5175} she gives you in your bags for good: every earth totem needs it."] = "",
	-- {npc:5887} Canaga Earthcaller · {spell:8071} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5887}: {spell:8071} and your {item:5175}"] = "",
	["the level 4 shaman spells"] = "",

	-- Step 7: Seer Ravenfeather
	-- {npc:5888} Seer Ravenfeather · {object:2972} Camp Narache (no name in this language: may be words)
	["{npc:5888} stands in {object:2972}. She may show no quest mark over her head: speak to her anyway. The quest opens at level 4."] = "",

	-- Step 8: Ritual Salve
	-- plural, as words: Bristleback Shamans = {npc:2953} Bristleback Shaman
	["The Bristleback Shamans (level 3-4) stand among the quilboar huts of Brambleblade Ravine, east of the camp, and throw the odd Lightning Bolt. Four kills in five drop a salve; they respawn in about four minutes."] = "",

	-- Step 9: Seer Ravenfeather
	-- {object:2972} Camp Narache (no name in this language: may be words) · {quest:1462} Earth Sapta
	["Back to the Seer in {object:2972}. She hands you the {quest:1462}: do not drink it yet."] = "",

	-- Step 10: Lost the Earth Sapta?
	-- {quest:1462} Earth Sapta
	["Lost the {quest:1462}?"] = "",
	-- {quest:1462} Earth Sapta
	["Only if the {quest:1462} is gone from your bags: the Seer gives you another."] = "",
	-- {npc:5888} Seer Ravenfeather · {quest:1462} Earth Sapta
	["{npc:5888}: a new {quest:1462}"] = "",

	-- Step 11: Kodo Rock
	["Kodo Rock"] = "",
	-- {npc:2991} Greatmother Hawkwind · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth
	["Kodo Rock is a small pillar on a low mound due east of {npc:2991}'s well, east of the camp; it only shows from about fifteen yards away, and hostile boars graze around it. Stand beside it and drink the {item:6635}, then speak to the {npc:5891} before it fades (drink again if it does)."] = "",
	-- {item:6635} Earth Sapta
	["{item:6635}, beside Kodo Rock"] = "",

	-- Step 12: Seer Ravenfeather
	-- {item:6656} Rough Quartz · {item:5175} Earth Totem
	["Bring the {item:6656} back to the Seer. Keep the {item:5175} in your bags for good: every earth totem needs it."] = "",
	-- {npc:5888} Seer Ravenfeather · {spell:8071} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5888}: {spell:8071} and your {item:5175}"] = "",

	-- Step 13: Windshaper Boro
	-- {npc:251374} Windshaper Boro
	["{npc:251374}, the shaman trainer, stands in Thendal Village. The quest opens at level 3."] = "",

	-- Step 14: Signet of Akir
	-- {item:251924} Signet of Akir · {npc:252095} Hanaa Nightwind
	["Any Al'Aketh cultist can carry the {item:251924}: the Converts (level 2-3) around the standing stones just east of the village, or the Brutes and Neophytes (level 4) in the camp beyond {npc:252095}, south-west of the village. Keep killing until one drops it."] = "",

	-- Step 15: Windshaper Boro
	-- {quest:1462} Earth Sapta
	["Back to Boro in Thendal Village. He hands you the {quest:1462}: do not drink it yet."] = "",

	-- Step 16: The Rise of Spirits
	["The Rise of Spirits"] = "",
	-- {item:6635} Earth Sapta · {npc:251166} Minor Manifestation of Earth
	["The Rise of Spirits is the hilltop shrine north-east of Boro: the path up starts on the hill just above the clearing where the flies were. Drink the {item:6635} beside the shrine and speak to the {npc:251166} before it fades."] = "",
	-- {item:6635} Earth Sapta
	["{item:6635}, beside the shrine"] = "",

	-- Step 17: Windshaper Boro
	-- {item:6656} Rough Quartz · {item:5175} Earth Totem
	["Bring the {item:6656} back to Boro. Keep the {item:5175} in your bags for good: every earth totem needs it."] = "",
	-- {npc:251374} Windshaper Boro · {spell:8071} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:251374}: {spell:8071} and your {item:5175}"] = "",
}
