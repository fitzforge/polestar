-- Chinese (traditional) (zhTW): the guide forever/collectibles/mounts/alliance/horse (forever/collectibles/mounts/alliance/horse.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Horse"] = "馬",

	-- Step 1: Learn to ride
	["Learn to ride"] = "學習騎術",
	-- {npc:4732} Randal Hunter · {npc:384} Katie Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {skill:762} Riding
	["{npc:4732} and {npc:384}'s horse pen are at {area:88} in eastern {zone:1429}. At 40 {npc:4732} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "{npc:4732}和{npc:384}的馬欄在{zone:1429}東部的{area:88}。40級時{npc:4732}教授{skill:762}（依暴雪設計師為100金），學會後會獲得一隻坐騎。Forever用戶端允許所有聯盟種族騎乘。",
	-- {npc:4732} Randal Hunter
	["{npc:4732}, riding trainer"] = "騎術訓練師{npc:4732}",

	-- Step 2: Pick a colour
	["Pick a colour"] = "挑選顏色",
	-- {npc:384} Katie Hunter
	["{npc:384} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:384}出售其他顏色（Forever用戶端中每隻20金）。想要哪隻就買，如果你喜歡獲贈的那隻，也可以都不買。",
	-- {item:2414} Pinto Bridle
	["{item:2414}, 20g"] = "{item:2414}，20金",
	-- {item:5655} Chestnut Mare Bridle
	["{item:5655}, 20g"] = "{item:5655}，20金",
	-- {item:5656} Brown Horse Bridle
	["{item:5656}, 20g"] = "{item:5656}，20金",
	-- {item:2411} Black Stallion Bridle
	["{item:2411} is in the client, but no vendor is confirmed to sell it in Forever."] = "{item:2411}存在於用戶端中，但尚未確認Forever中有商人出售。",
}
