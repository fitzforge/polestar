-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/alliance/swift-horse (forever/collectibles/mounts/alliance/swift-horse.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Horse"] = "迅捷战马",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "中级{skill:762}",
	-- {npc:4732} Randal Hunter · {npc:384} Katie Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {skill:762} Riding · {faction:72} Stormwind
	["{npc:4732} and {npc:384}'s horse pen are at {area:88} in eastern {zone:1429}. At 60 {npc:4732} teaches Journeyman {skill:762} to Humans for 1,000g (10% less at Honored with {faction:72}); Blizzard says it comes with a mount. Other races train it at their own race's riding trainer. Each swift horse costs 200g here."] = "{npc:4732} 和 {npc:384} 的马栏位于 {zone:1429} 东部的 {area:88}。60级时，{npc:4732} 以1,000金币向人类教授中级 {skill:762}（{faction:72} 达到尊敬可优惠10%）；暴雪称会附赠一只坐骑。其他种族在本族的骑术训练师处学习。这里每匹迅捷马售价200金币。",
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
	["{npc:384} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:384}出售其他颜色（无限 客户端中每只200金）。想要哪只就买哪只；如果喜欢送你的那只，也可以不买。",
	-- {item:18776} Swift Palomino
	["{item:18776}, 200g"] = "{item:18776}，200金",
	-- {item:18777} Swift Brown Steed
	["{item:18777}, 200g"] = "{item:18777}，200金",
	-- {item:18778} Swift White Steed
	["{item:18778}, 200g"] = "{item:18778}，200金",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:4732} and {npc:384}'s horse pen are at {area:88} in eastern {zone:1429}. At 60 {npc:4732} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift horse for 200g at level 60."] = "{npc:4732}和{npc:384}的马圈位于{zone:1429}东部的{area:88}。60级时{npc:4732}教授中级{skill:762}（据暴雪设计师称1,000金）；暴雪称学会骑术会获得一匹坐骑。Forever 客户端中每匹迅捷战马售价200金，需要60级。",
}
