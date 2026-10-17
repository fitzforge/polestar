-- Chinese (traditional) (zhTW): the guide forever/collectibles/pets/halpa (forever/collectibles/pets/halpa.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:8401} Halpa
	-- plural, as words: Prairie Dogs = {npc:2620} Prairie Dog
	["{npc:8401}'s Prairie Dogs"] = "{npc:8401}的草原土撥鼠",

	-- Step 1: Halpa
	-- {npc:8401} Halpa · {zone:1456} Thunder Bluff
	["{npc:8401} sells three whistles in {zone:1456} (50s each); the two ground squirrels are new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:8401}在{zone:1456}販售三種哨子（每個50銀）；兩種地松鼠是 Forever 新增的。每個寵物物品使用後都會教會你該寵物；之後目標會保持勾選。",
	-- {item:10394} Prairie Dog Whistle
	["{item:10394}, 50s"] = "{item:10394}，50銀",
	["50s"] = "50銀",
}
