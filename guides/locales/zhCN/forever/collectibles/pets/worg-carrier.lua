-- Chinese (simplified) (zhCN): the guide forever/collectibles/pets/worg-carrier (forever/collectibles/pets/worg-carrier.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kibler at Flame Crest
	-- {npc:10260} Kibler · {area:251} Flame Crest
	["{npc:10260} at {area:251}"] = "{area:251}的{npc:10260}",
	-- {npc:10260} Kibler · {area:251} Flame Crest · {zone:1428} Burning Steppes · {area:254} Blackrock Mountain · {item:12262} Empty Worg Pup Cage · {item:12529} Smolderweb Carrier
	["{npc:10260} stands inside the cave at {area:251}, the camp in northern {zone:1428} east of {area:254}. He gives you an {item:12262}. He also gives En-Ay-Es-Tee-Why (the {item:12529}): take both, they are done in the same run."] = "{npc:10260}站在{area:251}营地的洞穴中，营地位于{zone:1428}北部、{area:254}以东。他会给你一个{item:12262}。他还提供蜘蛛卵任务（{item:12529}）：两个都接，一趟可以一起完成。",

	-- Step 2: Lower Blackrock Spire: Halycon's pups
	-- {area:1583} Blackrock Spire
	["Lower {area:1583}: Halycon's pups"] = "{area:1583} 下层：哈雷肯的幼崽",
	-- {npc:10584} Urok Doomhowl · {npc:10221} Bloodaxe Worg Pup
	["The pups are in Lower Blackrock Spire (a group of five, level 55-60), not Upper: they run with Halycon, the great worg, deep in the dungeon beyond {npc:10584}'s ogres. Use the cage on a living {npc:10221} before the pack is dead. Taking damage interrupts the cast, so let the tank hold the pups and cage one from the side. A rogue or druid can sneak in, cage a pup from a corner, then vanish."] = "幼崽位于黑石塔下层（五人小队，55-60 级），不是上层：它们跟着大座狼哈雷肯，位于地下城深处、{npc:10584} 的食人魔后方。狼群被杀光前，对一只活着的 {npc:10221} 使用笼子。受到伤害会打断施法，因此让坦克拉住幼崽，从侧面捕捉一只。潜行者或德鲁伊可以潜入，从角落捕捉一只后再脱身。",
	-- {area:1583} Blackrock Spire
	["Lower {area:1583}"] = "{area:1583}下层",

	-- Step 3: Back to Kibler
	-- {npc:10260} Kibler
	["Back to {npc:10260}"] = "回到{npc:10260}处",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Upper {area:1583}"] = "{area:1583}上层",
	-- ["Upper {area:1583} is a raid group of up to ten, level 58-60. Use {npc:10260}'s cage on a {npc:10221} (Halycon's den) to get the {item:12263}."] = "{area:1583}上层是最多十人的团队副本，58-60级。对{npc:10221}（哈雷肯的巢穴）使用{npc:10260}的笼子，获得{item:12263}。",
	-- ["{npc:10260} stands at {area:251} in northern {zone:1428}, near the {area:254} path."] = "{npc:10260}站在{zone:1428}北部的{area:251}，靠近通往{area:254}的路。",
}
