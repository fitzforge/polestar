-- Chinese (traditional) (zhTW): the guide forever/class/mage/teleports-horde (forever/class/mage/teleports-horde.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Teleports and Portals (Horde)"] = "傳送與傳送門（部落）",
	["Your city teleports at 20 and 30 and the group portals at 40 and 50, from each city's portal trainer."] = "20級和30級學習主城傳送，40級和50級學習小隊傳送門，均由各主城的傳送門訓練師教授。",

	-- Step 1: Teleport: Orgrimmar
	-- {object:173161} Darkbriar Lodge · {zone:1454} Orgrimmar · {object:172961} Valley of Spirits · {npc:5958} Thuul · {spell:3567} Teleport: Orgrimmar · {item:17031} Rune of Teleportation
	["At 20 go to {object:173161} in {zone:1454}'s {object:172961}, where the mage trainers live. {npc:5958}, the portal trainer, stands on the upper floor and teaches {spell:3567} for 20 silver. Every teleport burns one {item:17031} (10 silver at any reagent vendor), so carry a few."] = "20級時去{zone:1454}的{object:172961}裡的{object:173161}，法師訓練師都在那裡。傳送門訓練師{npc:5958}站在上層，以20銀教授{spell:3567}。每次傳送消耗一個{item:17031}（任何材料商處10銀），所以隨身帶幾個。",
	-- {item:17031} Rune of Teleportation
	["{item:17031}, 10s each"] = "{item:17031}，每個10銀",

	-- Step 2: Teleport: Undercity
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1458} Undercity · {npc:2492} Lexington Mortaim · {object:36082} Magic Quarter · {spell:3563} Teleport: Undercity · {npc:4575} Hannah Akeley
	["Take the zeppelin from the tower outside {zone:1454}'s gate to {zone:1420} and walk into the {zone:1458}. {npc:2492}, the portal trainer, stands in the {object:36082} with the mage trainers: {spell:3563}, 20 silver. {npc:4575} beside him sells the runes."] = "從{zone:1454}城門外的塔乘飛艇到{zone:1420}，再走進{zone:1458}。傳送門訓練師{npc:2492}和法師訓練師們一起待在{object:36082}裡：{spell:3563}，20銀。他身邊的{npc:4575}出售符文。",

	-- Step 3: Teleport: Thunder Bluff
	-- {zone:1456} Thunder Bluff · {zone:1412} Mulgore · {zone:1454} Orgrimmar · {npc:5957} Birgitte Cranston · {area:2197} Pools of Vision · {area:1640} Spirit Rise · {spell:3566} Teleport: Thunder Bluff
	["At 30. {zone:1456} is in {zone:1412}: fly there from {zone:1454} or the Crossroads. {npc:5957}, the portal trainer, stands with the mage trainers in the {area:2197}, the cave under {area:1640}: go down inside, the arrow cannot tell the floors apart. She teaches {spell:3566} for 80 silver."] = "30級時。{zone:1456}位於{zone:1412}內：從{zone:1454}或十字路口飛過去。傳送門訓練師{npc:5957}和法師訓練師們一起站在{area:1640}下方洞穴{area:2197}裡：從裡面往下走，箭頭分不清樓層。她以80銀教授{spell:3566}。",

	-- Step 4: Portals to Orgrimmar and the Undercity
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity
	["Portals to {zone:1454} and the {zone:1458}"] = "通往{zone:1454}和{zone:1458}的傳送門",
	-- {item:17032} Rune of Portals · {npc:5958} Thuul · {object:173161} Darkbriar Lodge · {spell:11417} Portal: Orgrimmar · {zone:1458} Undercity · {npc:2492} Lexington Mortaim · {spell:11418} Portal: Undercity
	["At 40 the portal trainers teach the portals: a gateway your whole group can step through, for 1 gold 50 silver each. Each portal burns one {item:17032} (20 silver at any reagent vendor). {npc:5958} in {object:173161} has {spell:11417}; teleport to the {zone:1458} for {npc:2492}'s {spell:11418}."] = "40級時傳送門訓練師會教傳送門：一道整隊都能穿過的門，每個1金50銀。每道傳送門消耗一個{item:17032}（任何材料商處20銀）。{object:173161}裡的{npc:5958}有{spell:11417}；先傳送到{zone:1458}再找{npc:2492}學{spell:11418}。",
	-- {item:17032} Rune of Portals
	["{item:17032}, 20s each"] = "{item:17032}，每個20銀",

	-- Step 5: Portal: Thunder Bluff
	-- {npc:5957} Birgitte Cranston · {area:2197} Pools of Vision · {area:1640} Spirit Rise · {zone:1456} Thunder Bluff · {spell:11420} Portal: Thunder Bluff · {spell:3566} Teleport: Thunder Bluff
	["At 50 {npc:5957}, down in the {area:2197} under {area:1640} in {zone:1456}, teaches the last one, {spell:11420}, for 3 gold 20 silver. Use your {spell:3566} to get there."] = "50級時，在{zone:1456}的{area:1640}下方{area:2197}裡的{npc:5957}會教最後一個{spell:11420}，3金20銀。用你的{spell:3566}過去。",
}
