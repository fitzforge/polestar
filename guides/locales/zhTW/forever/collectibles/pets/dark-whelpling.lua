-- Chinese (traditional) (zhTW): the guide forever/collectibles/pets/dark-whelpling (forever/collectibles/pets/dark-whelpling.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Black whelps
	["Black whelps"] = "黑色雛龍",
	-- {area:511} Wyrmbog · {zone:1445} Dustwallow Marsh · {zone:1418} Badlands
	-- plural, as words: Searing Whelps = {npc:4324} Searing Whelp · Scalding Whelps = {npc:2725} Scalding Whelp
	["The Searing Whelps of the {area:511} in southern {zone:1445} (level 42) and the Scalding Whelps of eastern {zone:1418} (level 41) drop it about once in 900 kills in our data. The waypoint is the {area:511}; the {zone:1418} whelps are the same grind."] = "{zone:1445}南部{area:511}的灼熱雛龍（42級）和{zone:1418}東部的滾燙的雛龍（41級）依我們的資料約每900次擊殺掉落一次。路徑點是{area:511}；{zone:1418}的雛龍刷法相同。",
	-- {area:511} Wyrmbog
	["The {area:511}"] = "{area:511}",
}
