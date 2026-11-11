-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/alliance/black-war-mounts (forever/collectibles/mounts/alliance/black-war-mounts.guide).
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
	["PvP rank 11"] = "PvP军衔11级",
	-- {spell:1299382} Rank Points · {skill:762} Riding
	["{spell:1299382} come from battlegrounds, PvP quests and the season's weekly tasks, with a weekly cap; Commander (rank 11) unlocks the Black War mounts. The Player vs. Player tab of your character pane shows your rank and what you may buy. {skill:762} one at full speed needs Journeyman {skill:762} (level 60). Polestar cannot read your rank, so this step waits for level 60 and Journeyman {skill:762}."] = "{spell:1299382}来自战场、PvP任务和赛季每周任务，每周有获取上限；达到统帅（军衔11级）可解锁黑色作战坐骑。角色界面的玩家对战分页会显示你的军衔和可购买的物品。要运用{skill:762}全速骑乘，需要中级{skill:762}（60级）。Polestar无法读取你的军衔，因此此步骤会等待你达到60级并学会中级{skill:762}。",

	-- Step 2: Lieutenant Karter
	-- {npc:12783} Lieutenant Karter · {zone:1453} Stormwind · {object:2100} Old Town · {area:2918} Champions' Hall
	["{npc:12783} sells the mounts in {zone:1453}'s {object:2100} by the {area:2918}, beside the other honor quartermasters. The Forever client lists each at 100g. Each one also needs its kind's riding: Humans ride the steed, Night Elves the tiger, Gnomes the battlestrider, Dwarves the ram. A Skyborne, or anyone choosing another race's mount, first needs that riding from its trainer (Exalted with the race's city)."] = "{npc:12783}在{zone:1453}的{object:2100}、{area:2918}旁出售坐骑，就在其他荣誉军需官旁边。无限客户端标价每只100金币。每种还需要对应的骑术：人类骑战马，暗夜精灵骑虎，侏儒骑作战机械陆行鸟，矮人骑山羊。天裔或选择其他种族坐骑的玩家，必须先向对应训练师学习该骑术（需对应种族主城声望达到崇拜）。",
	-- {npc:14332} Black War Steed · {spell:824} Horse Riding
	["{npc:14332}, {spell:824}, 100g"] = "{npc:14332}，{spell:824}，100金币",
	-- {spell:22723} Black War Tiger · {spell:828} Tiger Riding
	["{spell:22723}, {spell:828}, 100g"] = "{spell:22723}，{spell:828}，100金币",
	-- {item:18243} Black Battlestrider · {spell:10907} Mechanostrider Piloting
	["{item:18243}, {spell:10907}, 100g"] = "{item:18243}，{spell:10907}，100 金",
	-- {item:18244} Black War Ram · {spell:826} Ram Riding
	["{item:18244}, {spell:826}, 100g"] = "{item:18244}，{spell:826}，100 金",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["100g"] = "100金",
	-- ["Forever's PvP ranks come from {spell:1299382} earned in battlegrounds and world PvP, with a weekly cap; Commander (rank 11) unlocks the Black War mounts. Polestar cannot read your rank, so this step waits for level 40 and the riding skill."] = "Forever 的PvP军衔来自在战场和世界PvP中获得的{spell:1299382}，每周有上限；指挥官（军衔11级）解锁黑色战斗坐骑。Polestar无法读取你的军衔，所以此步骤会等到40级并学会骑术。",
	-- ["{npc:12783} sells the mounts in the {area:2918} in {zone:1453}'s {object:2100}, beside the other honor quartermasters such as {npc:12805}. The Forever client lists each at 100g; choose one."] = "{npc:12783}在{zone:1453}{object:2100}的{area:2918}出售这些坐骑，旁边还有{npc:12805}等其他荣誉军需官。Forever 客户端中每只售价100金；任选一只。",
}
