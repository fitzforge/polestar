-- Chinese (traditional) (zhTW): the guide forever/collectibles/mounts/horde/raptor (forever/collectibles/mounts/horde/raptor.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Raptor"] = "迅猛龍",

	-- Step 1: Learn to ride
	["Learn to ride"] = "學習騎術",
	-- {npc:7953} Xar'Ti · {npc:7952} Zjolnir · {area:367} Sen'jin Village · {zone:1411} Durotar · {skill:762} Riding
	["{npc:7953} and {npc:7952}'s raptors are in {area:367} on the {zone:1411} coast. At 40 {npc:7953} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Horde race ride these."] = "{npc:7953}和{npc:7952}的迅猛龍在{zone:1411}海岸的{area:367}。40級時{npc:7953}教授{skill:762}（依暴雪設計師的說法為100金），學會後會得到一匹坐騎。Forever 用戶端讓每個部落種族都能騎乘這些坐騎。",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "騎術訓練師{npc:7953}",

	-- Step 2: Pick a colour
	["Pick a colour"] = "挑選顏色",
	-- {npc:7952} Zjolnir
	["{npc:7952} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:7952}出售其他顏色（Forever用戶端中每隻20金）。想要哪隻就買，如果你喜歡獲贈的那隻，也可以都不買。",
	-- {item:8588} Whistle of the Emerald Raptor
	["{item:8588}, 20g"] = "{item:8588}，20金",
	-- {item:8591} Whistle of the Turquoise Raptor
	["{item:8591}, 20g"] = "{item:8591}，20金",
	-- {item:8592} Whistle of the Violet Raptor
	["{item:8592}, 20g"] = "{item:8592}，20金",
}
