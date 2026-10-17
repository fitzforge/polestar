-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/alliance/swift-horse (forever/collectibles/mounts/alliance/swift-horse.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {npc:4732} Randal Hunter · {npc:384} Katie Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {skill:762} Riding
	["{npc:4732} and {npc:384}'s horse pen are at {area:88} in eastern {zone:1429}. At 60 {npc:4732} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift horse for 200g at level 60."] = "{npc:4732}和{npc:384}的马圈位于{zone:1429}东部的{area:88}。60级时{npc:4732}教授中级{skill:762}（据暴雪设计师称1,000金）；暴雪称学会骑术会获得一匹坐骑。Forever 客户端中每匹迅捷战马售价200金，需要60级。",
	-- {npc:4732} Randal Hunter
	["{npc:4732}, riding trainer"] = "{npc:4732}，骑术训练师",

	-- Step 2: Pick a colour
	["Pick a colour"] = "挑选颜色",
	-- {npc:384} Katie Hunter
	["{npc:384} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:384}出售其他颜色（Forever 客户端中每只200金）。想要哪只就买哪只；如果喜欢送你的那只，也可以不买。",
	-- {item:18776} Swift Palomino
	["{item:18776}, 200g"] = "{item:18776}，200金",
	-- {item:18777} Swift Brown Steed
	["{item:18777}, 200g"] = "{item:18777}，200金",
	-- {item:18778} Swift White Steed
	["{item:18778}, 200g"] = "{item:18778}，200金",
}
