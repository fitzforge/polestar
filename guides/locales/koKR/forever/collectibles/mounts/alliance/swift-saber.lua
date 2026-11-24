-- Korean (koKR): the guide forever/collectibles/mounts/alliance/swift-saber (forever/collectibles/mounts/alliance/swift-saber.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Saber"] = "날쌘 호랑이",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "수습 {skill:762}",
	-- {npc:4753} Jartsam · {npc:4730} Lelanai · {area:1658} Cenarion Enclave · {faction:69} Darnassus · {skill:762} Riding
	["{npc:4753} and {npc:4730}'s sabers are in the {area:1658}'s riding grounds in {faction:69}. At 60 {npc:4753} teaches Journeyman {skill:762} to Night Elves for 1,000g (10% less at Honored with {faction:69}); Blizzard says it comes with a mount. Other races train it at their own race's riding trainer. Each swift saber costs 200g here."] = "{npc:4753}과(와) {npc:4730}의 호랑이가 {faction:69}의 {area:1658} 승마장에 있습니다. 60레벨에 {npc:4753}이(가) 나이트엘프에게 수습 {skill:762}을(를) 1,000골드에 가르칩니다({faction:69}과(와) 우호적이면 10% 할인). 블리자드는 탈것이 함께 온다고 합니다. 다른 종족은 각자 종족의 승마 교관에서 배웁니다. 여기서 빠른 호랑이는 마리당 200골드입니다.",
	-- {npc:4753} Jartsam
	["{npc:4753}, riding trainer"] = "{npc:4753}, 탈것 상급자",

	-- Step 2: Tiger Riding for other races
	-- {spell:828} Tiger Riding
	["{spell:828} for other races"] = "{spell:828} (다른 종족)",
	-- {spell:828} Tiger Riding · {skill:762} Riding · {npc:4753} Jartsam · {faction:69} Darnassus
	["Any Alliance race can buy these sabers, but riding one also takes {spell:828}, which only Night Elves get with {skill:762}. {npc:4753} teaches it to other races once they are Exalted with {faction:69} (the Darnassus Reputation guide shows the way). Until then, don't buy a saber for this character."] = "모든 얼라이언스 종족이 이 호랑이를 살 수 있지만 탑승에는 {spell:828}도 필요하며 나이트엘프만 {skill:762}과(와) 함께 받습니다. {faction:69}과(와) 확고한 동맹이 되면 {npc:4753}이(가) 다른 종족에게도 가르칩니다(다르나서스 평판 가이드가 안내). 그 전에는 이 캐릭터로 호랑이를 사지 마세요.",

	-- Step 3: Pick a colour
	["Pick a colour"] = "색상 고르기",
	-- {npc:4730} Lelanai
	["{npc:4730} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:4730}이(가) 다른 색상을 판매합니다(Forever 클라이언트에서 각 200골드). 원하는 것을 구매하거나, 받은 탈것이 마음에 들면 사지 않아도 됩니다.",
	-- {item:18766} Reins of the Swift Frostsaber
	["{item:18766}, 200g"] = "{item:18766}, 200골드",
	-- {item:18767} Reins of the Swift Mistsaber
	["{item:18767}, 200g"] = "{item:18767}, 200골드",
	-- {item:18902} Reins of the Swift Stormsaber
	["{item:18902}, 200g"] = "{item:18902}, 200골드",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:4753} and {npc:4730}'s sabers are in the {area:1658}'s riding grounds in {zone:1457}. At 60 {npc:4753} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift saber for 200g at level 60."] = "{npc:4753}와(과) {npc:4730}의 호랑이는 {zone:1457} {area:1658}의 탈것 훈련장에 있습니다. 60레벨에 {npc:4753}이(가) 수습 {skill:762}을(를) 가르칩니다(블리자드 개발진 기준 1,000골드). 블리자드에 따르면 탈것 타기를 배우면 탈것을 하나 받습니다. Forever 클라이언트에서는 날쌘 호랑이를 60레벨에 각 200골드에 판매합니다.",
}
