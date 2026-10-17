-- Chinese (traditional) (zhTW): the guide forever/collectibles/pets/shadowgale-squirrel (forever/collectibles/pets/shadowgale-squirrel.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Skyboat from Dalaran
	-- {area:279} Dalaran
	["Skyboat from {area:279}"] = "從{area:279}搭乘天空船",
	-- {zone:2521} Zephras Isle · {area:279} Dalaran · {zone:1456} Thunder Bluff
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the north side of {area:279} about every five minutes (another flies from north of {zone:1456}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521}是天裔精靈的起始島嶼；任何人都可以前往。天空船約每五分鐘從{area:279}北側出發（另一艘從{zone:1456}北邊起飛；兩個陣營都可搭乘任一艘）。如果你已在島上，跳過此步。",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "搭天空船前往{zone:2521}",

	-- Step 2: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "從{zone:1456}搭乘天空船",
	-- {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff · {area:279} Dalaran
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes (another flies from {area:279}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521}是天裔精靈的起始島嶼；任何人都可以前往。天空船約每五分鐘從{zone:1456}北邊、{area:17045}南側的懸崖出發（另一艘從{area:279}起飛；兩個陣營都可搭乘任一艘）。如果你已在島上，跳過此步。",

	-- Step 3: Revered with the Nightclaw Druids
	-- {faction:2758} Nightclaw Druids
	["Revered with the {faction:2758}"] = "與{faction:2758}達到崇敬",
	-- {npc:254151} Vayn Moongaze · {faction:2758} Nightclaw Druids
	["{npc:254151} sells the squirrel (50s) once you are Revered with the {faction:2758}."] = "與{faction:2758}達到崇敬後，{npc:254151}會出售這隻松鼠（50銀）。",
	["50s"] = "50銀",
}
