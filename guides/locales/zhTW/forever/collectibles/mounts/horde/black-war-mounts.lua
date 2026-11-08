-- Chinese (traditional) (zhTW): the guide forever/collectibles/mounts/horde/black-war-mounts (forever/collectibles/mounts/horde/black-war-mounts.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {skill:762} Riding
	["Rank Points come from battlegrounds, PvP quests and the season's weekly tasks, with a weekly cap; Lieutenant General (rank 11) unlocks the Black War mounts. The Player vs. Player tab of your character pane shows your rank and what you may buy. {skill:762} one at full speed needs Journeyman {skill:762} (level 60). Polestar cannot read your rank, so this step waits for level 60 and Journeyman {skill:762}."] = "",

	-- Step 2: Raider Bork
	-- {npc:12796} Raider Bork · {object:179739} Hall of Legends (no name in this language: may be words) · {zone:1454} Orgrimmar · {object:172958} Valley of Honor
	["{npc:12796} sells the mounts by the {object:179739} in {zone:1454}'s {object:172958}, beside the other honor quartermasters. The Forever client lists each at 100g. Each one also needs its kind's riding: Orcs ride the wolf, Trolls the raptor, Tauren the kodo, Undead the skeletal warhorse. A Skyborne, or anyone choosing another race's mount, first needs that riding from its trainer (Exalted with the race's city)."] = "",
	-- {npc:14329} Black War Wolf
	["{npc:14329}, Wolf Riding, 100g"] = "",
	-- {npc:14330} Black War Raptor
	["{npc:14330}, Raptor Riding, 100g"] = "",
	-- {item:18247} Black War Kodo
	["{item:18247}, Kodo Riding, 100g"] = "",
	-- {item:18248} Red Skeletal Warhorse
	["{item:18248}, Undead Horsemanship, 100g"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["100g"] = "100金",
	-- ["Forever's PvP ranks come from {spell:1299382} earned in battlegrounds and world PvP, with a weekly cap; {spell:436438} (rank 11) unlocks the Black War mounts. Polestar cannot read your rank, so this step waits for level 40 and the riding skill."] = "Forever的PvP軍階來自在戰場和世界PvP中獲得的{spell:1299382}，每週有上限；{spell:436438}（軍階11）可解鎖黑色戰鬥坐騎。Polestar無法讀取你的軍階，所以此步驟會等到40級並學會騎術。",
	-- ["{npc:12796} sells the mounts in the {area:2917} in {zone:1454}'s {object:172958}, beside the other honor quartermasters such as {npc:12799}. The Forever client lists each at 100g; choose one."] = "{npc:12796}在{zone:1454}{object:172958}的{area:2917}出售這些坐騎，旁邊是{npc:12799}等其他榮譽軍需官。Forever用戶端標價每隻100金；選一隻。",
}
