-- Chinese (traditional) (zhTW): the guide forever/class/mage/teleports-alliance (forever/class/mage/teleports-alliance.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Teleports and Portals (Alliance)"] = "傳送術與傳送門（聯盟）",
	["Your city teleports at 20 and 30 and the group portals at 40 and 50, from each city's portal trainer."] = "20級和30級學習主城傳送術，40級和50級學習小隊傳送門，均可在各主城的傳送門訓練師處學習。",

	-- Step 1: Teleport: Stormwind
	-- {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:2485} Larimaine Purdue · {spell:3561} Teleport: Stormwind · {item:17031} Rune of Teleportation · {npc:1308} Owen Vaughn
	["At 20 go to the Wizard's Sanctum, the violet tower of {zone:1453}'s {object:2101}. {npc:2485}, the portal trainer, stands at the very top: climb the spiral ramp and take the portal near the top. She teaches {spell:3561} for 20 silver. Every teleport burns one {item:17031} (10 silver at any reagent vendor; {npc:1308} sells them at the foot of the tower), so carry a few."] = "20級時去巫師聖殿，即{zone:1453}的{object:2101}中的紫羅蘭高塔。傳送門訓練師{npc:2485}就在最頂層：沿螺旋坡道爬上去，乘靠近頂部的傳送門。她以20銀教授{spell:3561}。每次傳送消耗一個{item:17031}（任意施法材料商10銀；{npc:1308}在塔底出售），所以多帶幾個。",
	-- {item:17031} Rune of Teleportation
	["{item:17031}, 10s each"] = "{item:17031}，每個10銀",

	-- Step 2: Teleport: Ironforge
	-- {area:2257} Deeprun Tram · {zone:1453} Stormwind · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:2489} Milstaff Stormeye · {object:32362} Mystic Ward · {spell:3562} Teleport: Ironforge
	["Take the {area:2257} from {zone:1453}'s {object:28027} to {zone:1455}. {npc:2489}, the portal trainer, stands with the mage trainers in the {object:32362} at the back of the city: {spell:3562}, 20 silver."] = "從{zone:1453}的{object:28027}乘{area:2257}到{zone:1455}。傳送門訓練師{npc:2489}與法師訓練師一起站在城市後部的{object:32362}裡：{spell:3562}，20銀。",

	-- Step 3: Teleport: Darnassus
	-- {area:17203} Stormwind Harbor · {area:442} Auberdine · {zone:1439} Darkshore · {area:702} Rut'theran Village · {zone:1457} Darnassus · {npc:4165} Elissa Dumas · {spell:3565} Teleport: Darnassus
	["At 30. Take the boat from {area:17203} to {area:442} in {zone:1439}, then the boat to {area:702} and the pink portal up into {zone:1457}. {npc:4165}, the portal trainer, teaches {spell:3565} for 80 silver."] = "30級時。從{area:17203}乘船到{zone:1439}的{area:442}，再乘船到{area:702}，然後走粉色傳送門進入{zone:1457}。傳送門訓練師{npc:4165}以80銀教授{spell:3565}。",

	-- Step 4: Portals to Stormwind and Ironforge
	-- {zone:1453} Stormwind · {zone:1455} Ironforge
	["Portals to {zone:1453} and {zone:1455}"] = "通往{zone:1453}和{zone:1455}的傳送門",
	-- {item:17032} Rune of Portals · {npc:2485} Larimaine Purdue · {spell:10059} Portal: Stormwind · {npc:2489} Milstaff Stormeye · {zone:1455} Ironforge · {object:32362} Mystic Ward · {spell:11416} Portal: Ironforge
	["At 40 the portal trainers teach the portals: a gateway your whole group can step through, for 1 gold 50 silver each. Each portal burns one {item:17032} (20 silver at any reagent vendor). {npc:2485} has {spell:10059} at the top of the Wizard's Sanctum; then the tram to {npc:2489} in {zone:1455}'s {object:32362} for {spell:11416}."] = "40級時傳送門訓練師會教傳送門：一道整隊都能穿過的傳送門，每個1金50銀。每道傳送門消耗一個{item:17032}（任意施法材料商20銀）。{npc:2485}在巫師聖殿頂層教{spell:10059}；然後乘地鐵到{zone:1455}的{object:32362}找{npc:2489}學{spell:11416}。",
	-- {item:17032} Rune of Portals
	["{item:17032}, 20s each"] = "{item:17032}，每個20銀",

	-- Step 5: Portal: Darnassus
	-- {npc:4165} Elissa Dumas · {zone:1457} Darnassus · {spell:11419} Portal: Darnassus · {spell:3565} Teleport: Darnassus
	["At 50 {npc:4165} in {zone:1457} teaches the last one, {spell:11419}, for 3 gold 20 silver. Use your {spell:3565} to get there."] = "50級時{zone:1457}的{npc:4165}教授最後一個{spell:11419}，3金20銀。用你的{spell:3565}過去。",
}
