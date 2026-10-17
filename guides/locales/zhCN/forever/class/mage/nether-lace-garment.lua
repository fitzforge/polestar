-- Chinese (simplified) (zhCN): the guide forever/class/mage/nether-lace-garment (forever/class/mage/nether-lace-garment.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A robe or a tunic for Undead and Troll mages in their late 20s."] = "一件给20多级后期亡灵和巨魔法师的长袍或外衣。",

	-- Step 1: Anastasia Hartwell
	-- {npc:4568} Anastasia Hartwell · {zone:1458} Undercity · {object:36082} Magic Quarter · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["{npc:4568} stands in the {zone:1458}'s {object:36082}. Trolls take the zeppelin from {zone:1454} to {zone:1420} for her."] = "{npc:4568}站在{zone:1458}的{object:36082}。巨魔从{zone:1454}乘飞艇前往{zone:1420}去找她。",

	-- Step 2: Deino
	-- {zone:1454} Orgrimmar · {npc:5885} Deino
	["Take the zeppelin to {zone:1454}. {npc:5885} is one of {zone:1454}'s mage trainers."] = "乘飞艇前往{zone:1454}。{npc:5885}是{zone:1454}的法师训练师之一。",

	-- Step 3: The Xavian Waterfall
	-- {object:174797} Xavian Waterfall
	["The {object:174797}"] = "{object:174797}",
	-- {area:429} Xavian · {zone:1440} Ashenvale · {spell:9052} Fill Deino's Flask
	["Satyrs hold the ruins of {area:429} in eastern {zone:1440}. {spell:9052} at the bottom of the highest waterfall."] = "萨特占据着{zone:1440}东部的{area:429}废墟。在最高的瀑布底部{spell:9052}。",

	-- Step 4: Back to Deino
	-- {npc:5885} Deino
	["Back to {npc:5885}"] = "回到{npc:5885}那里",

	-- Step 5: The Laughing Sisters
	-- {quest:1945} Laughing Sisters
	["The {quest:1945}"] = "{quest:1945}",
	-- {quest:1945} Laughing Sisters · {area:426} Raynewood Retreat · {zone:1440} Ashenvale
	["The {quest:1945}, dryads, gather near the {area:426} in central {zone:1440}."] = "{quest:1945}是树妖，聚集在{zone:1440}中部的{area:426}附近。",

	-- Step 6: Kil'hala
	-- {npc:3484} Kil'hala · {area:380} Crossroads
	["{npc:3484}, a troll tailor, works at the {area:380}."] = "巨魔裁缝{npc:3484}在{area:380}工作。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Satyrs hold the ruins of {area:429} in eastern {zone:1440}. Fill {item:7269} at the bottom of the highest waterfall."] = "萨特占据了{zone:1440}东部的{area:429}废墟。在最高的瀑布底部装满{item:7269}。",
}
