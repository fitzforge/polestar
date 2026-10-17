-- Korean (koKR): the guide forever/collectibles/mounts/horde/wolf (forever/collectibles/mounts/horde/wolf.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Wolf"] = "늑대",

	-- Step 1: Learn to ride
	["Learn to ride"] = "탈것 타기 배우기",
	-- {npc:4752} Kildar · {npc:3362} Ogunaro Wolfrunner · {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {skill:762} Riding
	["{npc:4752} and {npc:3362}'s kennel are in {zone:1454}'s {object:172958}. At 40 {npc:4752} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Horde race ride these."] = "{npc:4752}와(과) {npc:3362}의 늑대 우리는 {zone:1454}의 {object:172958}에 있습니다. 40레벨에 {npc:4752}이(가) {skill:762}을(를) 가르치며(블리자드 개발진 기준 100골드), 배우면 탈것을 하나 받습니다. Forever 클라이언트에서는 모든 호드 종족이 이 탈것을 탈 수 있습니다.",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}, 탈것 상급자",

	-- Step 2: Pick a colour
	["Pick a colour"] = "색상 고르기",
	-- {npc:3362} Ogunaro Wolfrunner
	["{npc:3362} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:3362}이(가) 다른 색상을 판매합니다(Forever 클라이언트에서 각 20골드). 원하는 것을 구매하거나, 받은 탈것이 마음에 들면 사지 않아도 됩니다.",
	-- {item:1132} Horn of the Timber Wolf
	["{item:1132}, 20g"] = "{item:1132}, 20골드",
	-- {item:5665} Horn of the Dire Wolf
	["{item:5665}, 20g"] = "{item:5665}, 20골드",
	-- {item:5668} Horn of the Brown Wolf
	["{item:5668}, 20g"] = "{item:5668}, 20골드",
	-- {item:1041} Horn of the Black Wolf
	["{item:1041} is in the client (20g) but our data has no vendor selling it."] = "{item:1041}은(는) 클라이언트에 있지만(20골드) 저희 데이터에는 판매하는 상인이 없습니다.",
}
