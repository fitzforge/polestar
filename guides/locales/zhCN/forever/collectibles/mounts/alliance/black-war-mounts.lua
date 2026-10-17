-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/alliance/black-war-mounts (forever/collectibles/mounts/alliance/black-war-mounts.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {spell:1299382} Rank Points
	["Forever's PvP ranks come from {spell:1299382} earned in battlegrounds and world PvP, with a weekly cap; Commander (rank 11) unlocks the Black War mounts. Polestar cannot read your rank, so this step waits for level 40 and the riding skill."] = "Forever 的PvP军衔来自在战场和世界PvP中获得的{spell:1299382}，每周有上限；指挥官（军衔11级）解锁黑色战斗坐骑。Polestar无法读取你的军衔，所以此步骤会等到40级并学会骑术。",

	-- Step 2: Lieutenant Karter
	-- {npc:12783} Lieutenant Karter · {area:2918} Champions' Hall · {zone:1453} Stormwind · {object:2100} Old Town · {npc:12805} Officer Areyn
	["{npc:12783} sells the mounts in the {area:2918} in {zone:1453}'s {object:2100}, beside the other honor quartermasters such as {npc:12805}. The Forever client lists each at 100g; choose one."] = "{npc:12783}在{zone:1453}{object:2100}的{area:2918}出售这些坐骑，旁边还有{npc:12805}等其他荣誉军需官。Forever 客户端中每只售价100金；任选一只。",
	["100g"] = "100金",
}
