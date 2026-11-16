-- Chinese (traditional) (zhTW): the guide forever/class/mage/nether-lace-garment (forever/class/mage/nether-lace-garment.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A robe or a tunic for Horde mages in their late 20s."] = "給20多級後段部落法師的長袍或外衣。",

	-- Step 1: Anastasia Hartwell
	-- {npc:4568} Anastasia Hartwell · {zone:1458} Undercity · {object:36082} Magic Quarter · {spell:3563} Teleport: Undercity · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["{npc:4568} stands in the {zone:1458}'s {object:36082}. Orcs and Trolls use {spell:3563} or take the zeppelin from {zone:1454} to {zone:1420} for her."] = "{npc:4568}站在{zone:1458}的{object:36082}。獸人和食人妖使用{spell:3563}，或從{zone:1454}搭飛艇到{zone:1420}去找她。",

	-- Step 2: Deino
	-- {zone:1454} Orgrimmar · {spell:3567} Teleport: Orgrimmar · {object:173161} Darkbriar Lodge · {npc:5885} Deino · {object:172961} Valley of Spirits · {item:7269} Deino's Flask
	["Take the zeppelin to {zone:1454} (or use {spell:3567}, which lands you on the upper floor of {object:173161}). {npc:5885} stands with the mage trainers on the lower floor of {object:173161} in the {object:172961}. She hands you {item:7269}."] = "乘飛艇到{zone:1454}（或使用{spell:3567}，它會把你傳送到{object:173161}的上層）。{npc:5885}和法師訓練師們一起待在{object:172961}內{object:173161}的底層。她會交給你{item:7269}。",

	-- Step 3: The Xavian Waterfall
	-- {object:174797} Xavian Waterfall
	["The {object:174797}"] = "{object:174797}",
	-- {area:431} Splintertree Post · {area:429} Xavian
	["Fly to {area:431} and swim north up the river past the big lake to its far northern end, where the zone text reads {area:429}; satyrs hold the ruins around it and a few river beasts are in the way. Swim right in under the highest waterfall until you touch the rock wall, then use the flask (you can stay in the water). The waterfalls on the western Falfarren fork do not work."] = "飛到{area:431}，沿河向北遊過大湖，直到最北端，那裡區域文字顯示為{area:429}；薩特佔據著周圍的廢墟，路上還有幾隻河裡的野獸。一直游到最高瀑布正下方，直到碰到巖壁，然後使用藥瓶（可以一直留在水裡）。西側法爾法倫支流的瀑布無效。",
	-- {item:7269} Deino's Flask
	["{item:7269}, under the falls"] = "{item:7269}，在瀑布下",

	-- Step 4: Back to Deino
	-- {npc:5885} Deino
	["Back to {npc:5885}"] = "返回{npc:5885}",

	-- Step 5: The Laughing Sisters
	-- {quest:1945} Laughing Sisters
	["The {quest:1945}"] = "{quest:1945}",
	-- {quest:1945} Laughing Sisters · {area:426} Raynewood Retreat · {zone:1440} Ashenvale
	["The {quest:1945}, dryads of level 24-25, roam around the {area:426} in central {zone:1440}; every one drops a hair and they come back after 5 minutes. They often resist fire (and some frost and shadow): arcane spells land best. Each runs for help at low health. Keep clear of the guards by the white tower of the retreat, who hit hard."] = "{quest:1945}，24-25級的樹妖，在{zone:1440}中部的{area:426}一帶遊蕩；每一隻都會掉落一根頭髮，5分鐘後重新出現。它們常抵抗火焰（有些還抵抗冰霜和暗影）：奧術法術命中最好。血量低時它們會跑去求援。遠離隱居地白塔旁的衛兵，他們打人很疼。",

	-- Step 6: Kil'hala
	-- {npc:3484} Kil'hala
	["{npc:3484}, a troll tailor, works at the Crossroads. The robe gives intellect, stamina and spirit; the tunic more intellect and stamina but no spirit."] = "巨魔裁縫{npc:3484}在十字路口工作。長袍提供智力、耐力和精神；外衣提供更多智力和耐力，但沒有精神。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Satyrs hold the ruins of {area:429} in eastern {zone:1440}. {spell:9052} at the bottom of the highest waterfall."] = "薩特佔據了{zone:1440}東部的{area:429}廢墟。在最高瀑布的底部{spell:9052}。",
	-- ["Take the zeppelin to {zone:1454}. {npc:5885} is one of {zone:1454}'s mage trainers."] = "搭飛艇前往{zone:1454}。{npc:5885}是{zone:1454}的法師訓練師之一。",
	-- ["The {quest:1945}, dryads, gather near the {area:426} in central {zone:1440}."] = "{quest:1945}是樹妖，聚集在{zone:1440}中部的{area:426}附近。",
	-- ["{npc:3484}, a troll tailor, works at the {area:380}."] = "食人妖裁縫{npc:3484}在{area:380}工作。",
}
