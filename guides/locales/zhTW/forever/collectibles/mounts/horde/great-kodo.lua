-- Chinese (traditional) (zhTW): the guide forever/collectibles/mounts/horde/great-kodo (forever/collectibles/mounts/horde/great-kodo.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Great Kodo"] = "大型科多獸",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "中級{skill:762}",
	-- {npc:3690} Kar Stormsinger · {npc:3685} Harb Clawhoof · {area:222} Bloodhoof Village · {zone:1412} Mulgore · {skill:762} Riding · {faction:81} Thunder Bluff
	["{npc:3690} and {npc:3685}'s kodos are in {area:222}, {zone:1412}. At 60 {npc:3690} teaches Journeyman {skill:762} to Tauren for 1,000g (10% less at Honored with {faction:81}); Blizzard says it comes with a mount. Other races train it at their own race's riding trainer. Each great kodo costs 200g here."] = "{npc:3690}和{npc:3685}的科多獸都在{zone:1412}的{area:222}。60級時，{npc:3690}以1,000金教牛頭人中級{skill:762}（與{faction:81}達到尊敬時便宜10%）；暴雪說它會附帶一匹坐騎。其他種族在自己種族的騎術訓練師處學習。這裡每匹大型科多獸售價200金。",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "騎術訓練師{npc:3690}",

	-- Step 2: Kodo Riding for other races
	-- {spell:18995} Kodo Riding
	["{spell:18995} for other races"] = "其他種族所需的{spell:18995}",
	-- {spell:18995} Kodo Riding · {skill:762} Riding · {npc:3690} Kar Stormsinger · {faction:81} Thunder Bluff
	["Any Horde race can buy these kodos, but riding one also takes {spell:18995}, which only Tauren get with {skill:762}. {npc:3690} teaches it to other races once they are Exalted with {faction:81} (the Thunder Bluff Reputation guide shows the way). Until then, don't buy a kodo for this character."] = "任何部落種族都能買這些科多獸，但騎乘還需要{spell:18995}，只有牛頭人隨{skill:762}獲得。其他種族在與{faction:81}達到崇拜後，{npc:3690}才會教（雷霆崖聲望指南里有說明）。在此之前，不要給這個角色買科多獸。",

	-- Step 3: Pick a colour
	["Pick a colour"] = "挑選顏色",
	-- {npc:3685} Harb Clawhoof
	["{npc:3685} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:3685}出售其他顏色（Forever用戶端中每隻200金）。想要哪隻就買，如果你喜歡獲贈的那隻，也可以都不買。",
	-- {item:18793} Great White Kodo
	["{item:18793}, 200g"] = "{item:18793}，200金",
	-- {item:18794} Great Brown Kodo
	["{item:18794}, 200g"] = "{item:18794}，200金",
	-- {item:18795} Great Gray Kodo
	["{item:18795}, 200g"] = "{item:18795}，200金",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:3690} and {npc:3685}'s kodos are in {area:222}, {zone:1412}. At 60 {npc:3690} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each great kodo for 200g at level 60."] = "{npc:3690}和{npc:3685}的科多獸在{zone:1412}的{area:222}。60級時{npc:3690}教授中級{skill:762}（依暴雪設計師為1,000金）；暴雪表示學會騎術會附贈一隻坐騎。Forever用戶端以200金出售每隻大型科多獸，需要60級。",
}
