-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/horde/skeletal-horse (forever/collectibles/mounts/horde/skeletal-horse.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn to ride
	["Learn to ride"] = "学习骑术",
	-- {npc:4773} Velma Warnam · {npc:4731} Zachariah Post · {area:159} Brill · {zone:1420} Tirisfal Glades · {skill:762} Riding
	["{npc:4773} and {npc:4731}'s stable are in {area:159}, {zone:1420}. At 40 {npc:4773} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Horde race ride these."] = "{npc:4773}和{npc:4731}的马厩在{zone:1420}的{area:159}。40级时{npc:4773}教授{skill:762}（据暴雪设计师称100金），学会后会获得一匹坐骑。Forever 客户端允许所有部落种族骑乘这些坐骑。",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}，骑术训练师",

	-- Step 2: Pick a colour
	["Pick a colour"] = "挑选颜色",
	-- {npc:4731} Zachariah Post
	["{npc:4731} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:4731}出售其他颜色（Forever 客户端中每只20金）。想要哪只就买哪只；如果喜欢送你的那只，也可以不买。",
	-- {item:13331} Red Skeletal Horse
	["{item:13331}, 20g"] = "{item:13331}，20金",
	-- {item:13332} Blue Skeletal Horse
	["{item:13332}, 20g"] = "{item:13332}，20金",
	-- {item:13333} Brown Skeletal Horse
	["{item:13333}, 20g"] = "{item:13333}，20金",
	-- {npc:267354} Black Skeletal Horse
	["{npc:267354} is a new Forever horse (level 40) whose source is not known yet."] = "{npc:267354}是Forever 新增的马（40级），来源尚不清楚。",
}
