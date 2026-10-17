-- German (deDE): the guide forever/collectibles/pets/dark-whelpling (forever/collectibles/pets/dark-whelpling.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Black whelps
	["Black whelps"] = "Schwarze Welpen",
	-- {area:511} Wyrmbog · {zone:1445} Dustwallow Marsh · {zone:1418} Badlands
	-- plural, as words: Searing Whelps = {npc:4324} Searing Whelp · Scalding Whelps = {npc:2725} Scalding Whelp
	["The Searing Whelps of the {area:511} in southern {zone:1445} (level 42) and the Scalding Whelps of eastern {zone:1418} (level 41) drop it about once in 900 kills in our data. The waypoint is the {area:511}; the {zone:1418} whelps are the same grind."] = "Die Sengenden Welpen im {area:511} in den südlichen {zone:1445} (Stufe 42) und die Brühenden Welpen im östlichen {zone:1418} (Stufe 41) lassen ihn laut unseren Daten etwa einmal in 900 Kills fallen. Der Wegpunkt ist {area:511}; die Welpen im {zone:1418} sind derselbe Grind.",
	-- {area:511} Wyrmbog
	["The {area:511}"] = "{area:511}",
}
