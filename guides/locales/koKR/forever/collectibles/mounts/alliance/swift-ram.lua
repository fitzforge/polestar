-- Korean (koKR): the guide forever/collectibles/mounts/alliance/swift-ram (forever/collectibles/mounts/alliance/swift-ram.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {area:803} Amberstill Ranch · {area:131} Kharanos · {zone:1432} Loch Modan · {npc:4772} Ultham Ironhorn · {npc:1261} Veron Amberstill · {skill:762} Riding
	["{area:803} is east of {area:131} on the road to {zone:1432}; {npc:4772} stands beside {npc:1261}'s rams. At 60 {npc:4772} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift ram for 200g at level 60."] = "{area:803}은(는) {area:131} 동쪽, {zone:1432}(으)로 가는 길에 있습니다. {npc:4772}은(는) {npc:1261}의 산양 옆에 서 있습니다. 60레벨에 {npc:4772}이(가) 수습 {skill:762}을(를) 가르쳐 줍니다(블리자드 개발진에 따르면 1,000골드). 블리자드에 따르면 탈것 타기를 배우면 탈것을 받습니다. Forever 클라이언트에서는 날쌘 산양을 60레벨에 각 200골드에 팝니다.",
	-- {npc:4772} Ultham Ironhorn
	["{npc:4772}, riding trainer"] = "{npc:4772}, 탈것 상급자",

	-- Step 2: Pick a colour
	["Pick a colour"] = "색상 고르기",
	-- {npc:1261} Veron Amberstill
	["{npc:1261} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:1261}이(가) 다른 색상을 팝니다(Forever 클라이언트에서 각 200골드). 원하는 것을 사거나, 받은 탈것이 마음에 들면 사지 않아도 됩니다.",
	-- {item:18785} Swift White Ram
	["{item:18785}, 200g"] = "{item:18785}, 200골드",
	-- {item:18786} Swift Brown Ram
	["{item:18786}, 200g"] = "{item:18786}, 200골드",
	-- {item:18787} Swift Gray Ram
	["{item:18787}, 200g"] = "{item:18787}, 200골드",
}
