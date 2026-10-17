-- Chinese (simplified) (zhCN): the guide forever/collectibles/pets/worg-carrier (forever/collectibles/pets/worg-carrier.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kibler at Flame Crest
	-- {npc:10260} Kibler · {area:251} Flame Crest
	["{npc:10260} at {area:251}"] = "{area:251}的{npc:10260}",
	-- {npc:10260} Kibler · {area:251} Flame Crest · {zone:1428} Burning Steppes · {area:254} Blackrock Mountain
	["{npc:10260} stands at {area:251} in northern {zone:1428}, near the {area:254} path."] = "{npc:10260}站在{zone:1428}北部的{area:251}，靠近通往{area:254}的路。",

	-- Step 2: Upper Blackrock Spire
	-- {area:1583} Blackrock Spire
	["Upper {area:1583}"] = "{area:1583}上层",
	-- {area:1583} Blackrock Spire · {npc:10260} Kibler · {npc:10221} Bloodaxe Worg Pup · {item:12263} Caged Worg Pup
	["Upper {area:1583} is a raid group of up to ten, level 58-60. Use {npc:10260}'s cage on a {npc:10221} (Halycon's den) to get the {item:12263}."] = "{area:1583}上层是最多十人的团队副本，58-60级。对{npc:10221}（哈雷肯的巢穴）使用{npc:10260}的笼子，获得{item:12263}。",

	-- Step 3: Back to Kibler
	-- {npc:10260} Kibler
	["Back to {npc:10260}"] = "回到{npc:10260}处",
}
