-- Chinese (simplified) (zhCN): the guide forever/collectibles/pets/shylenai (forever/collectibles/pets/shylenai.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:8665} Shylenai
	["{npc:8665}'s Owls"] = "{npc:8665}的猫头鹰",

	-- Step 1: Shylenai
	-- {npc:8665} Shylenai · {area:1659} Craftsmen's Terrace · {zone:1457} Darnassus · {item:280803} Eagle Owl
	["{npc:8665}, the owl trainer, stands on the {area:1659} in {zone:1457}, beside the food and general goods vendors. She sells three owls (50s each); the {item:280803} is new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "猫头鹰训练师 {npc:8665} 站在 {zone:1457} 的 {area:1659}，就在食物和杂货商人旁。她出售三种猫头鹰（每种 50 银币）；{item:280803} 是无限新增的。每件宠物物品使用后都会学会对应的小伙伴；学会后，目标仍会保持勾选。",
	-- {item:8500} Great Horned Owl
	["{item:8500}, 50s"] = "{item:8500}，50银",
	-- {item:8501} Hawk Owl
	["{item:8501}, 50s"] = "{item:8501}，50银",
	["50s"] = "50银",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:8665} sells three owls in {zone:1457} (50s each); the {item:280803} is new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:8665}在{zone:1457}出售三种猫头鹰（每只50银）；{item:280803}是Forever 新增的。每件宠物物品使用后会教会你对应的小伙伴；之后目标会保持勾选。",
}
