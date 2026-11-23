-- Chinese (simplified) (zhCN): the guide forever/collectibles/pets/magus-tirth (forever/collectibles/pets/magus-tirth.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Magus Tirth
	-- {npc:6548} Magus Tirth · {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {zone:1441} Thousand Needles · {item:11023} Ancona Chicken · {area:484} Freewind Post · {area:976} Gadgetzan · {zone:1446} Tanaris
	["{npc:6548} at the {area:2240}, the goblin and gnome racetrack in the {area:439} of south-eastern {zone:1441}, sells the {item:11023} (1g) to both sides. The nearest flight paths are {area:484} (Horde) and {area:976} in {zone:1446} (both sides); from {area:976}, ride north into the {area:439}. Each pet item teaches its companion when you use it; the goal stays ticked afterwards."] = "{npc:6548}在{area:2240}向双方阵营出售{item:11023}（1金币）；那里是{zone:1441}东南部{area:439}中的地精与侏儒赛车场。最近的飞行点是{area:484}（部落）以及{zone:1446}的{area:976}（双方均可）；从{area:976}骑马向北进入{area:439}即可。使用每个宠物物品都会学会对应的小伙伴；之后目标会保持勾选。",
	-- {item:11023} Ancona Chicken
	["{item:11023}, 1g"] = "{item:11023}，1金",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:6548} at the {area:2240}, in the {area:439} of south-eastern {zone:1441}, sells the {item:11023} (1g). Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{zone:1441}东南部{area:439}的{area:2240}处的{npc:6548}出售{item:11023}（1金）。每件宠物物品使用后会教会你对应的小伙伴；之后目标会保持勾选。",
}
