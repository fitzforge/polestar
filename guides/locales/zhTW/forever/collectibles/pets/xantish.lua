-- Chinese (traditional) (zhTW): the guide forever/collectibles/pets/xantish (forever/collectibles/pets/xantish.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:8404} Xan'tish
	["{npc:8404}'s Snakes"] = "{npc:8404}的蛇",

	-- Step 1: Xan'tish
	-- {npc:8404} Xan'tish · {zone:1454} Orgrimmar · {item:280703} Jungle Boa
	["{npc:8404} sells four snakes in {zone:1454} (50s each); the {item:280703} is new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:8404}在{zone:1454}販售四種蛇（每隻50銀）；{item:280703}是 Forever 新增的。每個寵物物品使用後都會教會你該寵物；之後目標會保持勾選。",
	-- {item:10360} Black Kingsnake
	["{item:10360}, 50s"] = "{item:10360}，50銀",
	-- {item:10361} Brown Snake
	["{item:10361}, 50s"] = "{item:10361}，50銀",
	-- {item:10392} Crimson Snake
	["{item:10392}, 50s"] = "{item:10392}，50銀",
	["50s"] = "50銀",
}
