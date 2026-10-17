-- Chinese (traditional) (zhTW): the guide forever/collectibles/mounts/alliance/ram (forever/collectibles/mounts/alliance/ram.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ram"] = "山羊",

	-- Step 1: Learn to ride
	["Learn to ride"] = "學習騎術",
	-- {area:803} Amberstill Ranch · {area:131} Kharanos · {zone:1432} Loch Modan · {npc:4772} Ultham Ironhorn · {npc:1261} Veron Amberstill · {skill:762} Riding
	["{area:803} is east of {area:131} on the road to {zone:1432}; {npc:4772} stands beside {npc:1261}'s rams. At 40 {npc:4772} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "{area:803}位於{area:131}東邊、通往{zone:1432}的路上；{npc:4772}站在{npc:1261}的山羊旁。40級時{npc:4772}教授{skill:762}（依暴雪設計師為100金），學會後會獲得一隻坐騎。Forever用戶端允許所有聯盟種族騎乘。",
	-- {npc:4772} Ultham Ironhorn
	["{npc:4772}, riding trainer"] = "騎術訓練師{npc:4772}",

	-- Step 2: Pick a colour
	["Pick a colour"] = "挑選顏色",
	-- {npc:1261} Veron Amberstill
	["{npc:1261} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:1261}出售其他顏色（Forever用戶端中每隻20金）。想要哪隻就買，如果你喜歡獲贈的那隻，也可以都不買。",
	-- {item:5864} Gray Ram
	["{item:5864}, 20g"] = "{item:5864}，20金",
	-- {item:5872} Brown Ram
	["{item:5872}, 20g"] = "{item:5872}，20金",
	-- {item:5873} White Ram
	["{item:5873}, 20g"] = "{item:5873}，20金",
}
