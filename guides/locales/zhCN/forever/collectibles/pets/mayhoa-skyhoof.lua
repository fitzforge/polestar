-- Chinese (simplified) (zhCN): the guide forever/collectibles/pets/mayhoa-skyhoof (forever/collectibles/pets/mayhoa-skyhoof.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Mayhoa Skyhoof
	-- {npc:268745} Mayhoa Skyhoof · {zone:1454} Orgrimmar · {object:172957} Valley of Wisdom · {object:172958} Valley of Honor
	["{npc:268745}, the girl with puppies, walks a long loop through {zone:1454}: from the {object:172957} through the Drag to the {object:172958} and back. The waypoint is where she is seen most, on the road between the Drag and the {object:172958}; if she is not there, walk the loop. The carrier costs 60s. She carries one pup at a time: if she has none, another player just bought it, so come back later. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "",
	["60s"] = "60银",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:268745} walks a long loop through {zone:1454} (from the {object:172982} to the Drag); the waypoint is one point on her path. The carrier costs 60s. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:268745}从{object:172982}出发，在{zone:1454}绕一大圈行走；路径点是她路线上的一个点。宠物笼售价60银。每件宠物物品使用后会教会你对应的小伙伴；之后目标会保持勾选。",
	-- ["{npc:268745}, the girl with puppies, walks a long loop through {zone:1454}: from the {object:172957} through the Drag to the {object:172958} and back. The waypoint is where she is seen most, on the road between the Drag and the {object:172958}; if she is not there, walk the loop. The carrier costs 60s. By beta reports she carries one pup at a time: if she has none, another player just bought it, so come back later. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "带着小狗的女孩{npc:268745}沿{zone:1454}走很长一圈：从{object:172957}穿过暗巷区，到{object:172958}后返回。路径点设在她最常出现的地方，即暗巷区与{object:172958}之间的道路；如果她不在，就沿这条路线寻找。宠物笼售价60银。根据测试服玩家反馈，她每次只带一只小狗：如果没货，就是刚被其他玩家买走，稍后再来。使用每个宠物物品即可学会召唤对应伙伴；之后目标会保持勾选。",
}
