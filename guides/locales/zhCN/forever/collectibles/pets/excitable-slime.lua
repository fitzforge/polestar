-- Chinese (simplified) (zhCN): the guide forever/collectibles/pets/excitable-slime (forever/collectibles/pets/excitable-slime.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Nutritious Slime Sludge
	-- {item:278265} Nutritious Slime Sludge · {npc:4612} Boyle · {zone:1458} Undercity
	["Buy {item:278265} from {npc:4612} in the {zone:1458} canals first (25 copper for a stack of 5): you hand it in as soon as the slime offers its quest."] = "先在 {zone:1458} 运河里的 {npc:4612} 处购买 {item:278265}（一组5个，25铜币）：软泥怪提供任务后，你就要立即交还它。",
	-- {item:278265} Nutritious Slime Sludge · {npc:4612} Boyle
	["{item:278265}: {npc:4612}, in the canals"] = "{item:278265}：运河里的 {npc:4612}",

	-- Step 2: WRIGGLE.
	-- {npc:269452} Excitable Slime · {npc:4612} Boyle · {quest:97583} WRIGGLE.
	["Find an {npc:269452}, a little critter in the canal water beside {npc:4612}, target it and /dance at it, again and again, until it dances back and offers {quest:97583}; this takes many tries. Hand in the sludge right away. If the slime seems tired, /dance with it again before you hand in."] = "在 {npc:4612} 旁边的运河水中找一只 {npc:269452}，它是小型环境生物；选中它，反复对它使用 /dance，直到它也跳舞并提供 {quest:97583}；需要尝试很多次。立即交还淤泥。如果软泥怪看起来累了，交还前再与它 /dance 一次。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Find the {npc:269452}, a critter in the {zone:1458} canals, and /dance with it until it offers WRIGGLE. Buy {item:278265} from a vendor in the canals and bring it back; if the slime seems tired, dance with it again."] = "在{zone:1458}的运河里找到小动物{npc:269452}，对它/dance直到它提供任务。向运河里的商人购买{item:278265}并带回来；如果软泥看起来累了，再对它跳一次舞。",
	-- ["{item:278265}: {npc:4612}, in the canals beside the slime"] = "{item:278265}：{npc:4612}，在运河里软泥旁边",
}
