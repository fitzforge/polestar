-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/alliance/horse (forever/collectibles/mounts/alliance/horse.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Horse"] = "马",

	-- Step 1: Learn to ride
	["Learn to ride"] = "学习骑术",
	-- {npc:4732} Randal Hunter · {npc:384} Katie Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {skill:762} Riding
	["{npc:4732} and {npc:384}'s horse pen are at {area:88} in eastern {zone:1429}. At 40 {npc:4732} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "{npc:4732}和{npc:384}的马圈位于{zone:1429}东部的{area:88}。40级时{npc:4732}教授{skill:762}（据暴雪设计师称100金），学会后会获得一匹坐骑。Forever 客户端允许所有联盟种族骑乘这些坐骑。",
	-- {npc:4732} Randal Hunter
	["{npc:4732}, riding trainer"] = "{npc:4732}，骑术训练师",

	-- Step 2: Pick a colour
	["Pick a colour"] = "挑选颜色",
	-- {npc:384} Katie Hunter
	["{npc:384} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:384}出售其他颜色（Forever 客户端中每只20金）。想要哪只就买哪只；如果喜欢送你的那只，也可以不买。",
	-- {item:2414} Pinto Bridle
	["{item:2414}, 20g"] = "{item:2414}，20金",
	-- {item:5655} Chestnut Mare Bridle
	["{item:5655}, 20g"] = "{item:5655}，20金",
	-- {item:5656} Brown Horse Bridle
	["{item:5656}, 20g"] = "{item:5656}，20金",
	-- {item:2411} Black Stallion Bridle
	["{item:2411} is in the client, but no vendor is confirmed to sell it in Forever."] = "{item:2411}存在于客户端中，但尚未确认Forever 有商人出售。",
}
