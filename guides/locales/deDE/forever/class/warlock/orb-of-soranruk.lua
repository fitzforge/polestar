-- German (deDE): the guide forever/class/warlock/orb-of-soranruk (forever/class/warlock/orb-of-soranruk.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A rare off-hand orb or staff for your late 20s, for fragments from two dungeons."] = "Eine seltene Kugel für die Schildhand oder ein Stab für deine späten 20er, für Fragmente aus zwei Dungeons.",

	-- Step 1: Doan Karhan
	-- {npc:6247} Doan Karhan · {zone:1413} Barrens · {area:378} Camp Taurajo
	["{npc:6247} camps in the southern {zone:1413}, east of the road north-east of {area:378}."] = "{npc:6247} lagert im südlichen {zone:1413}, östlich der Straße nordöstlich von {area:378}.",

	-- Step 2: Blackfathom Deeps
	-- {area:2797} Blackfathom Deeps · {item:6914} Soran'ruk Fragment · {zone:1440} Ashenvale
	-- plural, as words: Twilight Acolytes = {npc:4809} Twilight Acolyte
	["The Twilight Acolytes inside {area:2797}, a level 24-32 dungeon, each drop a {item:6914}: bring a group. The entrance is in the ruins on the north-west coast of {zone:1440}."] = "Die Twilight-Akolythen in {area:2797}, einem Dungeon der Stufe 24-32, lassen je ein {item:6914} fallen: Bring eine Gruppe mit. Der Eingang liegt in den Ruinen an der Nordwestküste von {zone:1440}.",
	-- {item:6914} Soran'ruk Fragment
	-- plural, as words: Twilight Acolytes = {npc:4809} Twilight Acolyte
	["{item:6914}, from the Twilight Acolytes"] = "{item:6914}, von den Twilight-Akolythen",

	-- Step 3: Shadowfang Keep
	-- {area:236} Shadowfang Keep · {area:228} Sepulcher
	-- plural, as words: Shadowfang Darksouls = {npc:3855} Shadowfang Darksoul
	["The Shadowfang Darksouls inside {area:236}, a level 20-30 dungeon, drop the Large Fragment about one time in five: bring a group. The keep stands south of the {area:228}."] = "Die Shadowfang-Dunkelseelen in {area:236}, einem Dungeon der Stufe 20-30, lassen das Große Soran'ruk-Fragment etwa einmal in fünf fallen: Bring eine Gruppe mit. Die Burg steht südlich von {area:228}.",
	-- {item:6915} Large Soran'ruk Fragment
	-- plural, as words: Shadowfang Darksouls = {npc:3855} Shadowfang Darksoul
	["{item:6915}, from the Shadowfang Darksouls"] = "{item:6915}, von den Shadowfang-Dunkelseelen",

	-- Step 4: Back to Doan Karhan
	-- {npc:6247} Doan Karhan
	["Back to {npc:6247}"] = "Zurück zu {npc:6247}",
}
