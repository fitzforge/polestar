-- Chinese (simplified) (zhCN): the guide forever/class/mage/celestial-orb (forever/class/mage/celestial-orb.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7515} Celestial Orb
	["{item:7515} and Stave"] = "{item:7515}和法杖",
	["An off-hand orb or a staff for the late 30s, your pick."] = "30多级后期可选一个副手宝珠或一根法杖，任你选择。",

	-- Step 1: Return to the Marsh (Stormwind)
	-- {npc:5497} Jennea Cannon · {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:6546} Tabetha · {zone:1455} Ironforge
	["{npc:5497} in the Wizard's Sanctum, {zone:1453}'s {object:2101}, sends you back to {npc:6546}; Bink in {zone:1455} gives the same quest."] = "{zone:1453}{object:2101}巫师圣殿中的{npc:5497}会让你回去找{npc:6546}；{zone:1455}的彬克也提供同一任务。",

	-- Step 2: Return to the Marsh (Orgrimmar)
	-- {npc:5885} Deino · {zone:1454} Orgrimmar · {npc:6546} Tabetha · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity · {npc:3048} Ursyn Ghull · {zone:1456} Thunder Bluff
	["{npc:5885}, one of {zone:1454}'s mage trainers, sends you back to {npc:6546}; {npc:4568} in the {zone:1458} and {npc:3048} in {zone:1456} give the same quest."] = "{zone:1454}的法师训练师之一{npc:5885}会让你回去找{npc:6546}；{zone:1458}的{npc:4568}和{zone:1456}的{npc:3048}也提供同一任务。",

	-- Step 3: Tabetha
	-- {npc:6546} Tabetha · {area:508} Stonemaul Ruins
	["{npc:6546}'s cottage is deep in the marsh west of Theramore, just north of the {area:508}."] = "{npc:6546}的小屋在塞拉摩岛以西的沼泽深处，就在{area:508}北边。",

	-- Step 4: The Infernal Orb
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace · {item:7291} Infernal Orb
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["The Burning Blade Summoners work the {area:602} in southern {zone:1443}; any of them carries an {item:7291}."] = "火刃召唤师在{zone:1443}南部的{area:602}活动；他们每个都带着一个{item:7291}。",

	-- Step 5: The Exorcism
	-- {npc:6546} Tabetha · {npc:6549} Demon of the Orb
	["{npc:6546} draws the demon out of the orb beside her cottage. The {npc:6549} is elite: grouping up is advised. You have three minutes before it slips back into the orb."] = "{npc:6546}会在她的小屋旁把恶魔从宝珠中引出来。{npc:6549}是精英：建议组队。三分钟后它会退回宝珠。",

	-- Step 6: Power in Uldaman
	-- {area:1517} Uldaman · {zone:1418} Badlands · {object:178824} Meeting Stone · {npc:7023} Obsidian Sentinel
	["{area:1517} is a dungeon in the northern {zone:1418}, by the {object:178824}: a group of five. Defeat the {npc:7023} inside for its power source."] = "{area:1517}是{zone:1418}北部的地下城，在{object:178824}旁：需要五人小队。击败里面的{npc:7023}获取它的能量源。",

	-- Step 7: Mana Surges
	-- {npc:6546} Tabetha · {quest:1957} Mana Surges
	["Back to {npc:6546}. She opens a mana rift beside her cottage: kill twelve {quest:1957} within ten minutes."] = "回到{npc:6546}处。她会在小屋旁打开法力裂隙：在十分钟内击杀十二个{quest:1957}。",
}
