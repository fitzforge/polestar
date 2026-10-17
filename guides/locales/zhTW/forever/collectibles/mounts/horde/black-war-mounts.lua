-- Chinese (traditional) (zhTW): the guide forever/collectibles/mounts/horde/black-war-mounts (forever/collectibles/mounts/horde/black-war-mounts.guide).
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
	-- {spell:1299382} Rank Points · {spell:436438} Lieutenant General
	["Forever's PvP ranks come from {spell:1299382} earned in battlegrounds and world PvP, with a weekly cap; {spell:436438} (rank 11) unlocks the Black War mounts. Polestar cannot read your rank, so this step waits for level 40 and the riding skill."] = "Forever的PvP軍階來自在戰場和世界PvP中獲得的{spell:1299382}，每週有上限；{spell:436438}（軍階11）可解鎖黑色戰鬥坐騎。Polestar無法讀取你的軍階，所以此步驟會等到40級並學會騎術。",

	-- Step 2: Raider Bork
	-- {npc:12796} Raider Bork · {area:2917} Hall of Legends · {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {npc:12799} Sergeant Ba'sha
	["{npc:12796} sells the mounts in the {area:2917} in {zone:1454}'s {object:172958}, beside the other honor quartermasters such as {npc:12799}. The Forever client lists each at 100g; choose one."] = "{npc:12796}在{zone:1454}{object:172958}的{area:2917}出售這些坐騎，旁邊是{npc:12799}等其他榮譽軍需官。Forever用戶端標價每隻100金；選一隻。",
	["100g"] = "100金",
}
