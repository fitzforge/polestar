-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/horde/raptor (forever/collectibles/mounts/horde/raptor.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Raptor"] = "迅猛龙",

	-- Step 1: Learn to ride
	["Learn to ride"] = "学习骑术",
	-- {npc:7953} Xar'Ti · {npc:7952} Zjolnir · {area:367} Sen'jin Village · {zone:1411} Durotar · {skill:762} Riding
	["{npc:7953} and {npc:7952}'s raptors are in {area:367} on the {zone:1411} coast. At 40 {npc:7953} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Horde race ride these."] = "{npc:7953}和{npc:7952}的迅猛龙在{zone:1411}海岸的{area:367}。40级时{npc:7953}教授{skill:762}（据暴雪设计师称100金），学会后会获得一匹坐骑。Forever 客户端允许所有部落种族骑乘这些坐骑。",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}，骑术训练师",

	-- Step 2: Pick a colour
	["Pick a colour"] = "挑选颜色",
	-- {npc:7952} Zjolnir
	["{npc:7952} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:7952}出售其他颜色（Forever 客户端中每只20金）。想要哪只就买哪只；如果喜欢送你的那只，也可以不买。",
	-- {item:8588} Whistle of the Emerald Raptor
	["{item:8588}, 20g"] = "{item:8588}，20金",
	-- {item:8591} Whistle of the Turquoise Raptor
	["{item:8591}, 20g"] = "{item:8591}，20金",
	-- {item:8592} Whistle of the Violet Raptor
	["{item:8592}, 20g"] = "{item:8592}，20金",
}
