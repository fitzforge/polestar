-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/horde/skeletal-warhorse (forever/collectibles/mounts/horde/skeletal-warhorse.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {npc:4773} Velma Warnam · {npc:4731} Zachariah Post · {area:159} Brill · {zone:1420} Tirisfal Glades · {skill:762} Riding · {faction:68} Undercity
	["{npc:4773} and {npc:4731}'s stable are in {area:159}, {zone:1420}. At 60 {npc:4773} teaches Journeyman {skill:762} to Undead for 1,000g (10% less at Honored with {faction:68}); Blizzard says it comes with a mount. Other races train it at their own race's riding trainer. Each skeletal warhorse costs 200g here."] = "{npc:4773} 和 {npc:4731} 的马厩位于 {zone:1420} 的 {area:159}。60级时，{npc:4773} 以1,000金币向亡灵教授中级 {skill:762}（{faction:68} 达到尊敬可优惠10%）；暴雪称会附赠一只坐骑。其他种族在本族的骑术训练师处学习。这里每匹骸骨战马售价200金币。",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}，骑术训练师",

	-- Step 2: Undead Horsemanship for other races
	-- {spell:10906} Undead Horsemanship
	["{spell:10906} for other races"] = "其他种族学习{spell:10906}",
	-- {spell:10906} Undead Horsemanship · {skill:762} Riding · {npc:4773} Velma Warnam · {faction:68} Undercity
	["Any Horde race can buy these skeletal horses, but riding one also takes {spell:10906}, which only Undead get with {skill:762}. {npc:4773} teaches it to other races once they are Exalted with {faction:68} (the Undercity Reputation guide shows the way). Until then, don't buy a skeletal horse for this character."] = "部落任何种族都能购买这些骸骨马，但骑乘还需要 {spell:10906}，只有亡灵在学习 {skill:762} 时会一并获得。其他种族需要 {faction:68} 声望达到崇拜后，才能向 {npc:4773} 学习（可参照幽暗城声望指南）。在此之前，不要为这个角色购买骸骨马。",

	-- Step 3: Pick a colour
	["Pick a colour"] = "挑选颜色",
	-- {npc:4731} Zachariah Post
	["{npc:4731} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:4731}出售其他颜色（无限 客户端中每只200金）。想要哪只就买哪只；如果喜欢送你的那只，也可以不买。",
	-- {item:13334} Green Skeletal Warhorse
	["{item:13334}, 200g"] = "{item:13334}，200金",
	-- {item:18791} Purple Skeletal Warhorse
	["{item:18791}, 200g"] = "{item:18791}，200金",
	-- {npc:265653} Ochre Skeletal Warhorse
	-- plural, as words: Purple Skeletal Horses = {item:265840} Purple Skeletal Horse
	["The new Forever Green, Dark and Purple Skeletal Horses and the {npc:265653} (level 60) have no known source yet."] = "无限 新增的绿色骸骨军马、黑暗骷髅战马和{item:265840}以及{npc:265653}（60级）目前来源不明。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:4773} and {npc:4731}'s stable are in {area:159}, {zone:1420}. At 60 {npc:4773} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each skeletal warhorse for 200g at level 60."] = "{npc:4773}和{npc:4731}的马厩在{zone:1420}的{area:159}。60级时{npc:4773}教授中级{skill:762}（据暴雪设计师称1,000金）；暴雪称学会骑术会获得一匹坐骑。Forever 客户端中每匹骸骨战马售价200金，需要60级。",
}
