-- Chinese (simplified) (zhCN): the guide forever/collectibles/pets/xantish (forever/collectibles/pets/xantish.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:8404} Xan'tish
	["{npc:8404}'s Snakes"] = "{npc:8404}的蛇",

	-- Step 1: Xan'tish
	-- {npc:8404} Xan'tish · {object:172961} Valley of Spirits · {item:280703} Jungle Boa
	["{npc:8404}, the snake vendor, walks with his three snakes: from the {object:172961} north along the city's west side to the battleground emissaries and back. The waypoint is where his walk starts; if he is not there, follow the road north. He sells four snakes (50s each); the {item:280703} is new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "卖蛇商人{npc:8404}带着他的3条蛇巡行：从{object:172961}出发，沿城市西侧向北到战场使者处，再原路返回。路径点是他的出发位置；不在的话，沿路向北找。他出售4种蛇（每条50银币）；{item:280703}是无限新增的。使用每个宠物物品都会学会对应的小伙伴；之后目标会保持勾选。",
	-- {item:10360} Black Kingsnake
	["{item:10360}, 50s"] = "{item:10360}，50银",
	-- {item:10361} Brown Snake
	["{item:10361}, 50s"] = "{item:10361}，50银",
	-- {item:10392} Crimson Snake
	["{item:10392}, 50s"] = "{item:10392}，50银",
	["50s"] = "50银",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:8404} sells four snakes in {zone:1454} (50s each); the {item:280703} is new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:8404}在{zone:1454}出售四种蛇（每个50银）；{item:280703}是Forever新增的。使用每个宠物物品即可学会对应的小伙伴；之后目标会保持完成状态。",
}
