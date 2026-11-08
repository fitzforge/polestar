-- Chinese (traditional) (zhTW): the guide forever/collectibles/mounts/horde/skeletal-horse (forever/collectibles/mounts/horde/skeletal-horse.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn to ride
	["Learn to ride"] = "學習騎術",
	-- {npc:4773} Velma Warnam · {npc:4731} Zachariah Post · {zone:1420} Tirisfal Glades · {skill:762} Riding · {faction:68} Undercity
	["{npc:4773} and {npc:4731}'s stable are in Brill, {zone:1420}. At 40 {npc:4773} teaches {skill:762} to Undead for 100g (10% less at Honored with {faction:68}), and it comes with a skeletal horse. Other races learn {skill:762}, with their own first mount, at their own race's riding trainer."] = "",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "騎術訓練師{npc:4773}",

	-- Step 2: Undead Horsemanship for other races
	["Undead Horsemanship for other races"] = "",
	-- {skill:762} Riding · {npc:4773} Velma Warnam · {faction:68} Undercity
	["Any Horde race can buy these skeletal horses, but riding one also takes Undead Horsemanship, which only Undead get with {skill:762}. {npc:4773} teaches it to other races once they are Exalted with {faction:68} (the Undercity Reputation guide shows the way). Until then, don't buy a skeletal horse for this character."] = "",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, Undead Horsemanship"] = "",

	-- Step 3: Pick a colour
	["Pick a colour"] = "挑選顏色",
	-- {npc:4731} Zachariah Post
	["{npc:4731} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:4731}出售其他顏色（Forever用戶端中每隻20金）。想要哪隻就買，如果你喜歡獲贈的那隻，也可以都不買。",
	-- {item:13331} Red Skeletal Horse
	["{item:13331}, 20g"] = "{item:13331}，20金",
	-- {item:13332} Blue Skeletal Horse
	["{item:13332}, 20g"] = "{item:13332}，20金",
	-- {item:13333} Brown Skeletal Horse
	["{item:13333}, 20g"] = "{item:13333}，20金",
	["new in Forever, 20g; beta players found it here"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:267354} is a new Forever horse (level 40) whose source is not known yet."] = "{npc:267354}是Forever新增的馬（40級），來源尚不清楚。",
	-- ["{npc:4773} and {npc:4731}'s stable are in {area:159}, {zone:1420}. At 40 {npc:4773} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Horde race ride these."] = "{npc:4773}和{npc:4731}的馬廄在{zone:1420}的{area:159}。40級時{npc:4773}教授{skill:762}（依暴雪設計師為100金），學會後會獲得一隻坐騎。Forever用戶端允許所有部落種族騎乘。",
}
