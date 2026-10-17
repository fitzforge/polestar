-- Chinese (traditional) (zhTW): the guide forever/collectibles/mounts/alliance/saber (forever/collectibles/mounts/alliance/saber.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Saber"] = "刃豹",

	-- Step 1: Learn to ride
	["Learn to ride"] = "學習騎術",
	-- {npc:4753} Jartsam · {npc:4730} Lelanai · {area:1658} Cenarion Enclave · {zone:1457} Darnassus · {skill:762} Riding
	["{npc:4753} and {npc:4730}'s sabers are in the {area:1658}'s riding grounds in {zone:1457}. At 40 {npc:4753} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "{npc:4753}和{npc:4730}的刃豹在{zone:1457}{area:1658}的騎術場。40級時{npc:4753}會教你{skill:762}（依暴雪設計者為100金幣），學會後就會得到一匹坐騎。Forever用戶端允許所有聯盟種族騎乘牠們。",
	-- {npc:4753} Jartsam
	["{npc:4753}, riding trainer"] = "騎術訓練師{npc:4753}",

	-- Step 2: Pick a colour
	["Pick a colour"] = "挑選顏色",
	-- {npc:4730} Lelanai
	["{npc:4730} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:4730}出售其他顏色（Forever用戶端中每隻20金）。想要哪隻就買，如果你喜歡獲贈的那隻，也可以都不買。",
	-- {item:8629} Reins of the Striped Nightsaber
	["{item:8629}, 20g"] = "{item:8629}，20金",
	-- {item:8631} Reins of the Striped Frostsaber
	["{item:8631}, 20g"] = "{item:8631}，20金",
	-- {item:8632} Reins of the Spotted Frostsaber
	["{item:8632}, 20g"] = "{item:8632}，20金",
	-- {item:274706} Reins of the Striped Dawnsaber
	["{item:274706} is a new Forever saber (level 40, 20g in the client) whose source is not known yet."] = "{item:274706}是Forever新增的刃豹（40級，用戶端標示20金幣），來源尚未得知。",
}
