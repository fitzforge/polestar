-- German (deDE): the guide forever/collectibles/mounts/horde/frostwolf-howler (forever/collectibles/mounts/horde/frostwolf-howler.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Frostwolf Clan
	-- {area:2839} Alterac Valley · {faction:729} Frostwolf Clan · {npc:13219} Jekyll Flandring · {zone:1416} Alterac Mountains · {npc:13218} Grunnda Wolfheart
	["{area:2839} (level 51+) raises {faction:729}: win, capture towers and graveyards, and hand in the battleground's turn-ins; the Alterac Valley Reputation guide shows the fastest way. {npc:13219} waits at the Horde end of {zone:1416} outside the battleground; {npc:13218} inside {area:2839} sells the same mount."] = "{area:2839} (ab Stufe 51) steigert {faction:729}: Gewinne, erobere Türme und Friedhöfe und gib die Abgaben des Schlachtfelds ab; der Ruf-Guide für das Alteractal zeigt den schnellsten Weg. {npc:13219} wartet am Horde-Ende von {zone:1416} vor dem Schlachtfeld; {npc:13218} im Inneren von {area:2839} verkauft dasselbe Reittier.",

	-- Step 2: Horn of the Frostwolf Howler
	-- {skill:762} Riding
	["The Forever client lists it at 200g and level 60. It runs at full speed, so riding it needs Journeyman {skill:762}; any Horde race can ride it."] = "Der Forever-Client führt es für 200g und Stufe 60. Es läuft mit voller Geschwindigkeit, also braucht man zum Reiten {skill:762} (Geselle); jede Hordenrasse kann es reiten.",
	-- {npc:13219} Jekyll Flandring
	["{npc:13219}, 200g"] = "{npc:13219}, 200g",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Forever client lists it at 200g and level 60, and asks for no riding rank."] = "Der Forever-Client listet ihn für 200g ab Stufe 60 und verlangt keinen Reitrang.",
	-- ["{area:2839} (level 51+) raises {faction:729}: win, capture towers and graveyards, and hand in the battleground's turn-ins. {npc:13219} waits at the Horde end of {zone:1416} outside the battleground; {npc:13218} inside {area:2839} sells the same mount."] = "Das {area:2839} (ab Stufe 51) steigert den Ruf bei {faction:729}: Gewinne, erobere Türme und Friedhöfe und gib die Abgaben des Schlachtfelds ab. {npc:13219} wartet am Horde-Ende von {zone:1416} vor dem Schlachtfeld; {npc:13218} im {area:2839} verkauft dasselbe Reittier.",
}
