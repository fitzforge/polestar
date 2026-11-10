-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/alliance/horse (forever/collectibles/mounts/alliance/horse.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {npc:4732} Randal Hunter · {npc:384} Katie Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {skill:762} Riding · {faction:72} Stormwind
	["{npc:4732} and {npc:384}'s horse pen are at {area:88} in eastern {zone:1429}. At 40 {npc:4732} teaches {skill:762} to Humans for 100g (10% less at Honored with {faction:72}), and it comes with a horse. Other races learn {skill:762}, with their own first mount, at their own race's riding trainer."] = "{npc:4732} 和 {npc:384} 的马栏位于 {zone:1429} 东部的 {area:88}。40级时，{npc:4732} 以100金币向人类教授 {skill:762}（{faction:72} 达到尊敬可优惠10%），并附赠一匹马。其他种族在本族的骑术训练师处学习 {skill:762}，同时获得本族的第一只坐骑。",
	-- {npc:4732} Randal Hunter
	["{npc:4732}, riding trainer"] = "{npc:4732}，骑术训练师",

	-- Step 2: Horse Riding for other races
	-- {spell:824} Horse Riding
	["{spell:824} for other races"] = "其他种族学习{spell:824}",
	-- {spell:824} Horse Riding · {skill:762} Riding · {npc:4732} Randal Hunter · {faction:72} Stormwind
	["Any Alliance race can buy these horses, but riding one also takes {spell:824}, which only Humans get with {skill:762}. {npc:4732} teaches it to other races once they are Exalted with {faction:72} (the Stormwind Reputation guide shows the way). Until then, don't buy a horse for this character."] = "所有联盟种族都能购买这些马，但骑乘还需要{spell:824}，只有人类学习{skill:762}时会同时获得。其他种族需先将{faction:72}声望提升至崇拜，再找{npc:4732}学习（详见暴风城声望指南）。在那之前，不要为这个角色买马。",

	-- Step 3: Pick a colour
	["Pick a colour"] = "挑选颜色",
	-- {npc:384} Katie Hunter
	["{npc:384} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:384}出售其他颜色（无限 客户端中每只20金）。想要哪只就买哪只；如果喜欢送你的那只，也可以不买。",
	-- {item:2414} Pinto Bridle
	["{item:2414}, 20g"] = "{item:2414}，20金",
	-- {item:5655} Chestnut Mare Bridle
	["{item:5655}, 20g"] = "{item:5655}，20金",
	-- {item:5656} Brown Horse Bridle
	["{item:5656}, 20g"] = "{item:5656}，20金",

	-- Step 4: Black Stallion in Menethil Harbor
	-- {npc:5404} Black Stallion · {area:150} Menethil Harbor
	["{npc:5404} in {area:150}"] = "{area:150}的{npc:5404}",
	-- {npc:5404} Black Stallion · {npc:384} Katie Hunter · {npc:1460} Unger Statforth · {area:150} Menethil Harbor · {zone:1437} Wetlands
	["The {npc:5404} is not at {npc:384}: {npc:1460} sells it, at the stables of {area:150} in the {zone:1437} (20g in the Forever client). Skip this unless you want that colour."] = "{npc:5404}不在{npc:384}处出售：出售者是{npc:1460}，位于{zone:1437}的{area:150}马厩（无限客户端售价20金币）。除非你想要这种颜色，否则跳过。",
	-- {item:2411} Black Stallion Bridle · {npc:1460} Unger Statforth
	["{item:2411}, 20g, {npc:1460}"] = "{item:2411}，20金币，{npc:1460}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{item:2411} is in the client, but no vendor is confirmed to sell it in Forever."] = "{item:2411}存在于客户端中，但尚未确认Forever 有商人出售。",
	-- ["{npc:4732} and {npc:384}'s horse pen are at {area:88} in eastern {zone:1429}. At 40 {npc:4732} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "{npc:4732}和{npc:384}的马圈位于{zone:1429}东部的{area:88}。40级时{npc:4732}教授{skill:762}（据暴雪设计师称100金），学会后会获得一匹坐骑。Forever 客户端允许所有联盟种族骑乘这些坐骑。",
}
