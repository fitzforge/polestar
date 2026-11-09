-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/horde/black-war-mounts (forever/collectibles/mounts/horde/black-war-mounts.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Black War Mounts"] = "黑色战斗坐骑",

	-- Step 1: PvP rank 11
	["PvP rank 11"] = "PvP 军衔11",
	-- {spell:1299382} Rank Points · {spell:436438} Lieutenant General · {skill:762} Riding
	["{spell:1299382} come from battlegrounds, PvP quests and the season's weekly tasks, with a weekly cap; {spell:436438} (rank 11) unlocks the Black War mounts. The Player vs. Player tab of your character pane shows your rank and what you may buy. {skill:762} one at full speed needs Journeyman {skill:762} (level 60). Polestar cannot read your rank, so this step waits for level 60 and Journeyman {skill:762}."] = "{spell:1299382} 来自战场、PvP任务和赛季每周任务，有每周获取上限；{spell:436438}（军衔11级）可解锁黑色作战坐骑。角色面板的玩家对战分页会显示你的军衔及可购买的物品。以全速 {skill:762} 这些坐骑需要中级 {skill:762}（60级）。Polestar 无法读取你的军衔，因此此步骤会等待你达到60级并学会中级 {skill:762}。",

	-- Step 2: Raider Bork
	-- {npc:12796} Raider Bork · {area:2917} Hall of Legends · {zone:1454} Orgrimmar · {object:172958} Valley of Honor
	["{npc:12796} sells the mounts by the {area:2917} in {zone:1454}'s {object:172958}, beside the other honor quartermasters. The Forever client lists each at 100g. Each one also needs its kind's riding: Orcs ride the wolf, Trolls the raptor, Tauren the kodo, Undead the skeletal warhorse. A Skyborne, or anyone choosing another race's mount, first needs that riding from its trainer (Exalted with the race's city)."] = "{npc:12796} 在 {zone:1454} 的 {object:172958} 中、{area:2917} 旁出售坐骑，就在其他荣誉军需官附近。无限服客户端标价均为100金币。每种坐骑还需要对应的骑乘技能：兽人骑狼，巨魔骑迅猛龙，牛头人骑科多兽，亡灵骑骸骨战马。天裔或任何选择其他种族坐骑的玩家，都必须先从对应训练师处学习该骑乘技能（需要该种族主城声望达到崇拜）。",
	-- {npc:14329} Black War Wolf · {spell:825} Wolf Riding
	["{npc:14329}, {spell:825}, 100g"] = "{npc:14329}，{spell:825}，100金币",
	-- {npc:14330} Black War Raptor · {spell:10861} Raptor Riding
	["{npc:14330}, {spell:10861}, 100g"] = "{npc:14330}，{spell:10861}，100金币",
	-- {item:18247} Black War Kodo · {spell:18995} Kodo Riding
	["{item:18247}, {spell:18995}, 100g"] = "{item:18247}，{spell:18995}，100 金",
	-- {item:18248} Red Skeletal Warhorse · {spell:10906} Undead Horsemanship
	["{item:18248}, {spell:10906}, 100g"] = "{item:18248}，{spell:10906}，100 金",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["100g"] = "100金",
	-- ["Forever's PvP ranks come from {spell:1299382} earned in battlegrounds and world PvP, with a weekly cap; {spell:436438} (rank 11) unlocks the Black War mounts. Polestar cannot read your rank, so this step waits for level 40 and the riding skill."] = "Forever 的PvP军衔来自在战场和世界PvP中获得的{spell:1299382}，每周有上限；{spell:436438}（军衔11级）解锁黑色战斗坐骑。Polestar无法读取你的军衔，所以此步骤会等到40级并学会骑术。",
	-- ["{npc:12796} sells the mounts in the {area:2917} in {zone:1454}'s {object:172958}, beside the other honor quartermasters such as {npc:12799}. The Forever client lists each at 100g; choose one."] = "{npc:12796}在{zone:1454}{object:172958}的{area:2917}出售坐骑，旁边是{npc:12799}等其他荣誉军需官。Forever 客户端中每个售价100金；选择一个。",
}
