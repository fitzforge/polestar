-- Korean (koKR): the guide forever/collectibles/mounts/alliance/ram (forever/collectibles/mounts/alliance/ram.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ram"] = "산양",

	-- Step 1: Learn to ride
	["Learn to ride"] = "탈것 타기 배우기",
	-- {area:803} Amberstill Ranch · {area:131} Kharanos · {zone:1432} Loch Modan · {npc:4772} Ultham Ironhorn · {npc:1261} Veron Amberstill · {skill:762} Riding
	["{area:803} is east of {area:131} on the road to {zone:1432}; {npc:4772} stands beside {npc:1261}'s rams. At 40 {npc:4772} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "{area:803}은(는) {area:131} 동쪽, {zone:1432}(으)로 가는 길에 있습니다. {npc:4772}은(는) {npc:1261}의 산양 옆에 서 있습니다. 40레벨에 {npc:4772}이(가) {skill:762}을(를) 가르쳐 주며(블리자드 개발진에 따르면 100골드), 배우면 탈것을 하나 받습니다. Forever 클라이언트에서는 모든 얼라이언스 종족이 이 탈것을 탈 수 있습니다.",
	-- {npc:4772} Ultham Ironhorn
	["{npc:4772}, riding trainer"] = "{npc:4772}, 탈것 상급자",

	-- Step 2: Pick a colour
	["Pick a colour"] = "색상 고르기",
	-- {npc:1261} Veron Amberstill
	["{npc:1261} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:1261}이(가) 다른 색상을 팝니다(Forever 클라이언트에서 각 20골드). 원하는 것을 사거나, 받은 탈것이 마음에 들면 사지 않아도 됩니다.",
	-- {item:5864} Gray Ram
	["{item:5864}, 20g"] = "{item:5864}, 20골드",
	-- {item:5872} Brown Ram
	["{item:5872}, 20g"] = "{item:5872}, 20골드",
	-- {item:5873} White Ram
	["{item:5873}, 20g"] = "{item:5873}, 20골드",
}
