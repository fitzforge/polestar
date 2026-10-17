-- Chinese (traditional) (zhTW): the guide forever/collectibles/mounts/alliance/black-war-mounts (forever/collectibles/mounts/alliance/black-war-mounts.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Black War Mounts"] = "黑色戰鬥坐騎",

	-- Step 1: PvP rank 11
	["PvP rank 11"] = "PvP軍階11",
	-- {spell:1299382} Rank Points
	["Forever's PvP ranks come from {spell:1299382} earned in battlegrounds and world PvP, with a weekly cap; Commander (rank 11) unlocks the Black War mounts. Polestar cannot read your rank, so this step waits for level 40 and the riding skill."] = "Forever的PvP軍階來自在戰場和野外PvP中獲得的{spell:1299382}，每週有上限；指揮官（軍階11）會解鎖黑色戰鬥坐騎。Polestar無法讀取你的軍階，所以此步驟會等到40級和騎術技能。",

	-- Step 2: Lieutenant Karter
	-- {npc:12783} Lieutenant Karter · {area:2918} Champions' Hall · {zone:1453} Stormwind · {object:2100} Old Town · {npc:12805} Officer Areyn
	["{npc:12783} sells the mounts in the {area:2918} in {zone:1453}'s {object:2100}, beside the other honor quartermasters such as {npc:12805}. The Forever client lists each at 100g; choose one."] = "{npc:12783}在{zone:1453}{object:2100}的{area:2918}出售這些坐騎，旁邊是{npc:12805}等其他榮譽軍需官。Forever用戶端標價每隻100金；選一隻。",
	["100g"] = "100金",
}
