-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/horde/skeletal-warhorse (forever/collectibles/mounts/horde/skeletal-warhorse.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Skeletal Warhorse"] = "骸骨战马",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "中级{skill:762}",
	-- {npc:4773} Velma Warnam · {npc:4731} Zachariah Post · {area:159} Brill · {zone:1420} Tirisfal Glades · {skill:762} Riding
	["{npc:4773} and {npc:4731}'s stable are in {area:159}, {zone:1420}. At 60 {npc:4773} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each skeletal warhorse for 200g at level 60."] = "{npc:4773}和{npc:4731}的马厩在{zone:1420}的{area:159}。60级时{npc:4773}教授中级{skill:762}（据暴雪设计师称1,000金）；暴雪称学会骑术会获得一匹坐骑。Forever 客户端中每匹骸骨战马售价200金，需要60级。",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}，骑术训练师",

	-- Step 2: Pick a colour
	["Pick a colour"] = "挑选颜色",
	-- {npc:4731} Zachariah Post
	["{npc:4731} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:4731}出售其他颜色（Forever 客户端中每只200金）。想要哪只就买哪只；如果喜欢送你的那只，也可以不买。",
	-- {item:13334} Green Skeletal Warhorse
	["{item:13334}, 200g"] = "{item:13334}，200金",
	-- {item:18791} Purple Skeletal Warhorse
	["{item:18791}, 200g"] = "{item:18791}，200金",
	-- {npc:265653} Ochre Skeletal Warhorse
	-- plural, as words: Purple Skeletal Horses = {item:265840} Purple Skeletal Horse
	["The new Forever Green, Dark and Purple Skeletal Horses and the {npc:265653} (level 60) have no known source yet."] = "Forever 新增的绿色骸骨军马、黑暗骷髅战马和{item:265840}以及{npc:265653}（60级）目前来源不明。",
}
