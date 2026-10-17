-- Korean (koKR): the guide forever/collectibles/mounts/alliance/swift-saber (forever/collectibles/mounts/alliance/swift-saber.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {npc:4753} Jartsam · {npc:4730} Lelanai · {area:1658} Cenarion Enclave · {zone:1457} Darnassus · {skill:762} Riding
	["{npc:4753} and {npc:4730}'s sabers are in the {area:1658}'s riding grounds in {zone:1457}. At 60 {npc:4753} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift saber for 200g at level 60."] = "{npc:4753}와(과) {npc:4730}의 호랑이는 {zone:1457} {area:1658}의 탈것 훈련장에 있습니다. 60레벨에 {npc:4753}이(가) 수습 {skill:762}을(를) 가르칩니다(블리자드 개발진 기준 1,000골드). 블리자드에 따르면 탈것 타기를 배우면 탈것을 하나 받습니다. Forever 클라이언트에서는 날쌘 호랑이를 60레벨에 각 200골드에 판매합니다.",
	-- {npc:4753} Jartsam
	["{npc:4753}, riding trainer"] = "{npc:4753}, 탈것 상급자",

	-- Step 2: Pick a colour
	["Pick a colour"] = "색상 고르기",
	-- {npc:4730} Lelanai
	["{npc:4730} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:4730}이(가) 다른 색상을 판매합니다(Forever 클라이언트에서 각 200골드). 원하는 것을 구매하거나, 받은 탈것이 마음에 들면 사지 않아도 됩니다.",
	-- {item:18766} Reins of the Swift Frostsaber
	["{item:18766}, 200g"] = "{item:18766}, 200골드",
	-- {item:18767} Reins of the Swift Mistsaber
	["{item:18767}, 200g"] = "{item:18767}, 200골드",
	-- {item:18902} Reins of the Swift Stormsaber
	["{item:18902}, 200g"] = "{item:18902}, 200골드",
}
