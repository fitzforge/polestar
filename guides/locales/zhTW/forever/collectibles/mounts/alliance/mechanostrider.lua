-- Chinese (traditional) (zhTW): the guide forever/collectibles/mounts/alliance/mechanostrider (forever/collectibles/mounts/alliance/mechanostrider.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Mechanostrider"] = "機械陸行鳥",

	-- Step 1: Learn to ride
	["Learn to ride"] = "學習騎術",
	-- {area:189} Steelgrill's Depot · {area:131} Kharanos · {npc:7954} Binjy Featherwhistle · {npc:7955} Milli Featherwhistle · {skill:762} Riding · {faction:54} Gnomeregan Exiles
	["{area:189} is just east of {area:131}; {npc:7954} stands beside {npc:7955}'s mechanostriders. At 40 {npc:7954} teaches {skill:762} to Gnomes for 100g (10% less at Honored with {faction:54}), and it comes with a mechanostrider. Other races learn {skill:762}, with their own first mount, at their own race's riding trainer."] = "",
	-- {npc:7954} Binjy Featherwhistle
	["{npc:7954}, riding trainer"] = "騎術訓練師{npc:7954}",

	-- Step 2: Mechanostrider Piloting for other races
	-- {spell:10907} Mechanostrider Piloting
	["{spell:10907} for other races"] = "",
	-- {spell:10907} Mechanostrider Piloting · {skill:762} Riding · {npc:7954} Binjy Featherwhistle · {faction:54} Gnomeregan Exiles
	["Any Alliance race can buy these mechanostriders, but riding one also takes {spell:10907}, which only Gnomes get with {skill:762}. {npc:7954} teaches it to other races once they are Exalted with {faction:54} (the Gnomeregan Exiles Reputation guide shows the way). Until then, don't buy a mechanostrider for this character."] = "",

	-- Step 3: Pick a colour
	["Pick a colour"] = "挑選顏色",
	-- {npc:7955} Milli Featherwhistle
	["{npc:7955} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:7955}出售其他顏色（Forever用戶端中每隻20金）。想要哪隻就買，如果你喜歡獲贈的那隻，也可以都不買。",
	-- {item:8563} Red Mechanostrider
	["{item:8563}, 20g"] = "{item:8563}，20金",
	-- {item:8595} Blue Mechanostrider
	["{item:8595}, 20g"] = "{item:8595}，20金",
	-- {item:13321} Green Mechanostrider
	["{item:13321}, 20g"] = "{item:13321}，20金",
	-- {item:13322} Unpainted Mechanostrider
	["{item:13322}, 20g"] = "{item:13322}，20金",
	-- {spell:10907} Mechanostrider Piloting
	["In Classic only Dwarves and Gnomes could ride mechanostriders; in Forever every Alliance race can learn {spell:10907}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Era let only Dwarves and Gnomes ride mechanostriders; the Forever client allows every Alliance race."] = "經典版只允許矮人和地精騎乘機械陸行鳥；Forever用戶端允許所有聯盟種族。",
	-- ["{area:189} is just east of {area:131}; {npc:7954} stands beside {npc:7955}'s mechanostriders. At 40 {npc:7954} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "{area:189}就在{area:131}東邊；{npc:7954}站在{npc:7955}的機械陸行鳥旁。40級時{npc:7954}會教你{skill:762}（依暴雪設計者為100金幣），學會後就會得到一匹坐騎。Forever用戶端允許所有聯盟種族騎乘牠們。",
}
