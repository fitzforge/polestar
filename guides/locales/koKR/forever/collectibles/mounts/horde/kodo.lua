-- Korean (koKR): the guide forever/collectibles/mounts/horde/kodo (forever/collectibles/mounts/horde/kodo.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Kodo"] = "코도",

	-- Step 1: Learn to ride
	["Learn to ride"] = "탈것 타기 배우기",
	-- {npc:3690} Kar Stormsinger · {npc:3685} Harb Clawhoof · {area:222} Bloodhoof Village · {zone:1412} Mulgore · {skill:762} Riding
	["{npc:3690} and {npc:3685}'s kodos are in {area:222}, {zone:1412}. At 40 {npc:3690} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Horde race ride these."] = "{zone:1412} {area:222}에 {npc:3690}와(과) {npc:3685}의 코도가 있습니다. 40레벨에 {npc:3690}이(가) {skill:762}을(를) 가르치며(블리자드 설계 기준 100골드), 배우면 탈것을 하나 얻습니다. Forever 클라이언트에서는 모든 호드 종족이 이 탈것을 탈 수 있습니다.",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}, 탈것 상급자",

	-- Step 2: Pick a colour
	["Pick a colour"] = "색상 고르기",
	-- {npc:3685} Harb Clawhoof
	["{npc:3685} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:3685}이(가) 다른 색상을 팝니다(Forever 클라이언트 기준 각 20골드). 원하는 것을 구매하거나, 받은 탈것이 마음에 들면 사지 않아도 됩니다.",
	-- {item:15277} Gray Kodo
	["{item:15277}, 20g"] = "{item:15277}, 20골드",
	-- {item:15290} Brown Kodo
	["{item:15290}, 20g"] = "{item:15290}, 20골드",
	-- {item:275993} White Kodo · {item:277960} Lavender Kodo
	["{item:275993} and {item:277960} are new Forever kodos (level 40, 20g in the client) whose source is not known yet."] = "{item:275993}와(과) {item:277960}은(는) Forever에 새로 추가된 코도(레벨 40, 클라이언트 기준 20골드)이며 아직 출처가 알려지지 않았습니다.",
}
