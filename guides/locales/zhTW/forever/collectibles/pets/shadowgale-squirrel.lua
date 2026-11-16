-- Chinese (traditional) (zhTW): the guide forever/collectibles/pets/shadowgale-squirrel (forever/collectibles/pets/shadowgale-squirrel.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	["{zone:2521} is the Skyborne starting island; by beta reports anyone may visit. A skyboat leaves the north side of {area:279} about every five minutes (another flies from north of {zone:1456}; either faction may take either)."] = "{zone:2521}是天裔精靈的起始島嶼；據測試版回報，任何人都可以前往。天空船約每五分鐘從{area:279}北側出發（另一艘從{zone:1456}北邊起飛；兩個陣營都可搭乘任一艘）。",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "搭天空船前往{zone:2521}",

	-- Step 2: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "從{zone:1456}搭乘天空船",
	-- {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff · {area:279} Dalaran
	["{zone:2521} is the Skyborne starting island; by beta reports anyone may visit. A skyboat leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes (another flies from {area:279}; either faction may take either)."] = "{zone:2521}是天裔精靈的起始島嶼；據測試版回報，任何人都可以前往。天空船約每五分鐘從{zone:1456}北邊、{area:17045}南側的懸崖出發（另一艘從{area:279}起飛；兩個陣營都可搭乘任一艘）。",

	-- Step 3: Revered with the Nightclaw Druids
	-- {faction:2758} Nightclaw Druids
	["Revered with the {faction:2758}"] = "與{faction:2758}達到崇敬",
	-- {npc:254151} Vayn Moongaze · {area:16631} Shadowgale Forest · {npc:257944} Elegael Thornpaw · {faction:2758} Nightclaw Druids
	-- plural, as words: Al'Aketh Cultist's Ears = {item:258771} Al'Aketh Cultist's Ear · Nightclaw Druids = {npc:254152} Nightclaw Druid
	["{npc:254151}, the druids' quartermaster, waits inside their den in the {area:16631}, the cave just north-east of {npc:257944}'s camp. He sells the squirrel (50s) once you are Revered with the {faction:2758}. Get there young: the Shadowgale storyline and {npc:254151}'s first ear quest take you to Friendly, and his repeatable pays 1000 for five Al'Aketh Cultist's Ears up to level 18 but, by Classic's rules, only 200 from level 22. From Friendly to Revered that is about 80 ears at level 18 and about 400 at 22 or above. The Nightclaw Druids Reputation guide walks you through it."] = "{npc:254151}，德魯伊的軍需官，在他們位於{area:16631}的巢穴裡等候，那是{npc:257944}營地東北方的洞穴。只要你對{faction:2758}達到崇敬，他就會出售這隻松鼠（50銀）。趁等級低就去：影風劇情線和{npc:254151}的第一個耳朵任務能把你帶到友善，他的可重複任務在18級及以下時每五隻奧阿克教徒耳朵給1000點，但按經典舊世的規則，22級起只給200點。從友善到崇敬，18級約需80只耳朵，22級及以上約需400只。《夜爪德魯伊聲望》指南會帶你走完。",
	["50s"] = "50銀",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:254151} sells the squirrel (50s) once you are Revered with the {faction:2758}."] = "與{faction:2758}達到崇敬後，{npc:254151}會出售這隻松鼠（50銀）。",
}
