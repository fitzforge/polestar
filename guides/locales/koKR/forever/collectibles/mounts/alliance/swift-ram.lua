-- Korean (koKR): the guide forever/collectibles/mounts/alliance/swift-ram (forever/collectibles/mounts/alliance/swift-ram.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Ram"] = "날쌘 산양",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "수습 {skill:762}",
	-- {area:803} Amberstill Ranch · {area:131} Kharanos · {zone:1432} Loch Modan · {npc:4772} Ultham Ironhorn · {npc:1261} Veron Amberstill · {skill:762} Riding · {faction:47} Ironforge
	["{area:803} is east of {area:131} on the road to {zone:1432}; {npc:4772} stands beside {npc:1261}'s rams. At 60 {npc:4772} teaches Journeyman {skill:762} to Dwarves for 1,000g (10% less at Honored with {faction:47}); Blizzard says it comes with a mount. Other races train it at their own race's riding trainer. Each swift ram costs 200g here."] = "{area:803}은(는) {area:131} 동쪽 {zone:1432}으로 가는 도로에 있고 {npc:4772}이(가) {npc:1261}의 숫양 곁에 서 있습니다. 60레벨에 {npc:4772}이(가) 드워프에게 수습 {skill:762}을(를) 1,000골드에 가르칩니다({faction:47}과(와) 우호적이면 10% 할인). 블리자드는 탈것이 함께 온다고 합니다. 다른 종족은 각자 종족의 승마 교관에서 배웁니다. 여기서 빠른 숫양은 마리당 200골드입니다.",
	-- {npc:4772} Ultham Ironhorn
	["{npc:4772}, riding trainer"] = "{npc:4772}, 탈것 상급자",

	-- Step 2: Ram Riding for other races
	-- {spell:826} Ram Riding
	["{spell:826} for other races"] = "{spell:826} (다른 종족)",
	-- {spell:826} Ram Riding · {skill:762} Riding · {npc:4772} Ultham Ironhorn · {faction:47} Ironforge
	["Any Alliance race can buy these rams, but riding one also takes {spell:826}, which only Dwarves get with {skill:762}. {npc:4772} teaches it to other races once they are Exalted with {faction:47} (the Ironforge Reputation guide shows the way). Until then, don't buy a ram for this character."] = "모든 얼라이언스 종족이 이 숫양을 살 수 있지만 탑승에는 {spell:826}도 필요하며 드워프만 {skill:762}과(와) 함께 받습니다. {faction:47}과(와) 확고한 동맹이 되면 {npc:4772}이(가) 다른 종족에게도 가르칩니다(아이언포지 평판 가이드가 안내). 그 전에는 이 캐릭터로 숫양을 사지 마세요.",

	-- Step 3: Pick a colour
	["Pick a colour"] = "색상 고르기",
	-- {npc:1261} Veron Amberstill
	["{npc:1261} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:1261}이(가) 다른 색상을 팝니다(Forever 클라이언트에서 각 200골드). 원하는 것을 사거나, 받은 탈것이 마음에 들면 사지 않아도 됩니다.",
	-- {item:18785} Swift White Ram
	["{item:18785}, 200g"] = "{item:18785}, 200골드",
	-- {item:18786} Swift Brown Ram
	["{item:18786}, 200g"] = "{item:18786}, 200골드",
	-- {item:18787} Swift Gray Ram
	["{item:18787}, 200g"] = "{item:18787}, 200골드",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{area:803} is east of {area:131} on the road to {zone:1432}; {npc:4772} stands beside {npc:1261}'s rams. At 60 {npc:4772} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift ram for 200g at level 60."] = "{area:803}은(는) {area:131} 동쪽, {zone:1432}(으)로 가는 길에 있습니다. {npc:4772}은(는) {npc:1261}의 산양 옆에 서 있습니다. 60레벨에 {npc:4772}이(가) 수습 {skill:762}을(를) 가르쳐 줍니다(블리자드 개발진에 따르면 1,000골드). 블리자드에 따르면 탈것 타기를 배우면 탈것을 받습니다. Forever 클라이언트에서는 날쌘 산양을 60레벨에 각 200골드에 팝니다.",
}
