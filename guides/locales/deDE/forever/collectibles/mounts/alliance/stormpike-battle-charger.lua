-- German (deDE): the guide forever/collectibles/mounts/alliance/stormpike-battle-charger (forever/collectibles/mounts/alliance/stormpike-battle-charger.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Stormpike Guard
	-- {area:2839} Alterac Valley · {faction:730} Stormpike Guard · {npc:13217} Thanthaldis Snowgleam · {zone:1416} Alterac Mountains · {area:287} Hillsbrad · {npc:13216} Gaelden Hammersmith
	["{area:2839} (level 51+) raises {faction:730}: win, capture towers and graveyards, and hand in the battleground's turn-ins; the Alterac Valley Reputation guide shows the fastest way. {npc:13217} waits outside the battleground on the {zone:1416} border above {area:287}; {npc:13216} inside {area:2839} sells the same mount."] = "{area:2839} (ab Stufe 51) steigert {faction:730}: Gewinne, erobere Türme und Friedhöfe und gib die Abgaben des Schlachtfelds ab; der Ruf-Guide für das Alteractal zeigt den schnellsten Weg. {npc:13217} wartet vor dem Schlachtfeld an der Grenze zum {zone:1416} oberhalb von {area:287}; {npc:13216} im Inneren von {area:2839} verkauft dasselbe Reittier.",

	-- Step 2: Stormpike Battle Charger
	-- {skill:762} Riding
	["The Forever client lists it at 200g and level 60. It runs at full speed, so riding it needs Journeyman {skill:762}; any Alliance race can ride it."] = "Der Forever-Client führt es für 200g und Stufe 60. Es läuft mit voller Geschwindigkeit, also braucht man zum Reiten {skill:762} (Geselle); jede Allianzrasse kann es reiten.",
	-- {npc:13217} Thanthaldis Snowgleam
	["{npc:13217}, 200g"] = "{npc:13217}, 200g",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Forever client lists it at 200g and level 60, and asks for no riding rank."] = "Der Forever-Client führt es für 200g ab Stufe 60 und verlangt keinen Reitrang.",
	-- ["{area:2839} (level 51+) raises {faction:730}: win, capture towers and graveyards, and hand in the battleground's turn-ins. {npc:13217} waits outside the battleground on the {zone:1416} border above {area:287}; {npc:13216} inside {area:2839} sells the same mount."] = "Im {area:2839} (ab Stufe 51) steigt dein Ruf bei {faction:730}: Gewinne, erobere Türme und Friedhöfe und gib die Abgaben des Schlachtfelds ab. {npc:13217} wartet vor dem Schlachtfeld an der Grenze zu {zone:1416} oberhalb von {area:287}; {npc:13216} im {area:2839} verkauft dasselbe Reittier.",
}
