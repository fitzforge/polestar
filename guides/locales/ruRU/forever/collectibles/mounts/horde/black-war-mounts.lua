-- Russian (ruRU): the guide forever/collectibles/mounts/horde/black-war-mounts (forever/collectibles/mounts/horde/black-war-mounts.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Black War Mounts"] = "Черные боевые скакуны",

	-- Step 1: PvP rank 11
	["PvP rank 11"] = "PvP-звание 11",
	-- {spell:1299382} Rank Points · {spell:436438} Lieutenant General
	["Forever's PvP ranks come from {spell:1299382} earned in battlegrounds and world PvP, with a weekly cap; {spell:436438} (rank 11) unlocks the Black War mounts. Polestar cannot read your rank, so this step waits for level 40 and the riding skill."] = "PvP-звания в Forever даются за «{spell:1299382}», заработанные на полях боя и в мировом PvP, с недельным ограничением; {spell:436438} (звание 11) открывает черных боевых скакунов. Polestar не может узнать ваше звание, поэтому этот шаг ждет 40-го уровня и навыка верховой езды.",

	-- Step 2: Raider Bork
	-- {npc:12796} Raider Bork · {area:2917} Hall of Legends · {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {npc:12799} Sergeant Ba'sha
	["{npc:12796} sells the mounts in the {area:2917} in {zone:1454}'s {object:172958}, beside the other honor quartermasters such as {npc:12799}. The Forever client lists each at 100g; choose one."] = "{npc:12796} продает скакунов здесь: {area:2917} ({zone:1454}, {object:172958}), рядом с другими интендантами чести, например {npc:12799}. В клиенте Forever каждый стоит 100 з; выберите одного.",
	["100g"] = "100 з",
}
