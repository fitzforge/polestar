-- Chinese (simplified) (zhCN): the guide forever/collectibles/pets/halpa (forever/collectibles/pets/halpa.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:8401} Halpa
	-- plural, as words: Prairie Dogs = {npc:2620} Prairie Dog
	["{npc:8401}'s Prairie Dogs"] = "{npc:8401}的{npc:2620}",

	-- Step 1: Halpa
	-- {npc:8401} Halpa · {zone:1456} Thunder Bluff
	["{npc:8401} sells three whistles in {zone:1456} (50s each, 1g 50s for all three); the two ground squirrels are new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:8401} 在 {zone:1456} 出售三种口哨（每种 50 银币，三种共 1 金 50 银）；其中两种地松鼠是无限新增的。每件宠物物品使用后都会学会对应的小伙伴；学会后，目标仍会保持勾选。",
	-- {item:10394} Prairie Dog Whistle
	["{item:10394}, 50s"] = "{item:10394}，50银",
	["50s"] = "50银",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:8401} sells three whistles in {zone:1456} (50s each); the two ground squirrels are new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:8401}在{zone:1456}出售三种哨子（每个50银）；两种地松鼠是Forever 新增的。每件宠物物品使用后会教会你对应的小伙伴；之后目标会保持勾选。",
}
