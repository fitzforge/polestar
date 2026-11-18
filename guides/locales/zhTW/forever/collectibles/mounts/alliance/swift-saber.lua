-- Chinese (traditional) (zhTW): the guide forever/collectibles/mounts/alliance/swift-saber (forever/collectibles/mounts/alliance/swift-saber.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Saber"] = "迅捷刃豹",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "中級{skill:762}",
	-- {npc:4753} Jartsam · {npc:4730} Lelanai · {area:1658} Cenarion Enclave · {faction:69} Darnassus · {skill:762} Riding
	["{npc:4753} and {npc:4730}'s sabers are in the {area:1658}'s riding grounds in {faction:69}. At 60 {npc:4753} teaches Journeyman {skill:762} to Night Elves for 1,000g (10% less at Honored with {faction:69}); Blizzard says it comes with a mount. Other races train it at their own race's riding trainer. Each swift saber costs 200g here."] = "{npc:4753}和{npc:4730}的夜刃豹在{faction:69}的{area:1658}騎術訓練場。60級時{npc:4753}以1,000金教夜精靈中級{skill:762}（{faction:69}尊敬時便宜10%）；暴雪稱會附贈坐騎。其他種族在本族騎術訓練師處學習。此處每隻迅捷夜刃豹200金。",
	-- {npc:4753} Jartsam
	["{npc:4753}, riding trainer"] = "騎術訓練師{npc:4753}",

	-- Step 2: Tiger Riding for other races
	-- {spell:828} Tiger Riding
	["{spell:828} for other races"] = "其他種族的{spell:828}",
	-- {spell:828} Tiger Riding · {skill:762} Riding · {npc:4753} Jartsam · {faction:69} Darnassus
	["Any Alliance race can buy these sabers, but riding one also takes {spell:828}, which only Night Elves get with {skill:762}. {npc:4753} teaches it to other races once they are Exalted with {faction:69} (the Darnassus Reputation guide shows the way). Until then, don't buy a saber for this character."] = "任何聯盟種族都能買這些夜刃豹，但騎乘還需{spell:828}，只有夜精靈隨{skill:762}獲得。其他種族在{faction:69}達到崇拜後，{npc:4753}會教它（達納蘇斯聲望指南有路線）。在此之前，別為這個角色買夜刃豹。",

	-- Step 3: Pick a colour
	["Pick a colour"] = "挑選顏色",
	-- {npc:4730} Lelanai
	["{npc:4730} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:4730}出售其他顏色（Forever用戶端中每隻200金）。想要哪隻就買，如果你喜歡獲贈的那隻，也可以都不買。",
	-- {item:18766} Reins of the Swift Frostsaber
	["{item:18766}, 200g"] = "{item:18766}，200金",
	-- {item:18767} Reins of the Swift Mistsaber
	["{item:18767}, 200g"] = "{item:18767}，200金",
	-- {item:18902} Reins of the Swift Stormsaber
	["{item:18902}, 200g"] = "{item:18902}，200金",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:4753} and {npc:4730}'s sabers are in the {area:1658}'s riding grounds in {zone:1457}. At 60 {npc:4753} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift saber for 200g at level 60."] = "{npc:4753}和{npc:4730}的刃豹在{zone:1457}{area:1658}的騎術場。60級時{npc:4753}教授中級{skill:762}（依暴雪設計師的說法為1000金）；暴雪表示學會騎術會獲得一匹坐騎。Forever 用戶端在60級時以每隻200金販售迅捷刃豹。",
}
