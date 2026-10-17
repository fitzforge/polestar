-- Korean (koKR): the guide forever/collectibles/mounts/horde/great-kodo (forever/collectibles/mounts/horde/great-kodo.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Great Kodo"] = "거대한 코도",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "수습 {skill:762}",
	-- {npc:3690} Kar Stormsinger · {npc:3685} Harb Clawhoof · {area:222} Bloodhoof Village · {zone:1412} Mulgore · {skill:762} Riding
	["{npc:3690} and {npc:3685}'s kodos are in {area:222}, {zone:1412}. At 60 {npc:3690} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each great kodo for 200g at level 60."] = "{zone:1412} {area:222}에 {npc:3690}와(과) {npc:3685}의 코도가 있습니다. 60레벨에 {npc:3690}이(가) 수습 {skill:762}을(를) 가르칩니다(블리자드 설계 기준 1,000골드). 블리자드에 따르면 탈것 타기를 배우면 탈것을 하나 얻습니다. Forever 클라이언트는 거대한 코도를 60레벨에 각 200골드에 팝니다.",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}, 탈것 상급자",

	-- Step 2: Pick a colour
	["Pick a colour"] = "색상 고르기",
	-- {npc:3685} Harb Clawhoof
	["{npc:3685} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:3685}이(가) 다른 색상을 팝니다(Forever 클라이언트 기준 각 200골드). 원하는 것을 구매하거나, 받은 탈것이 마음에 들면 사지 않아도 됩니다.",
	-- {item:18793} Great White Kodo
	["{item:18793}, 200g"] = "{item:18793}, 200골드",
	-- {item:18794} Great Brown Kodo
	["{item:18794}, 200g"] = "{item:18794}, 200골드",
	-- {item:18795} Great Gray Kodo
	["{item:18795}, 200g"] = "{item:18795}, 200골드",
}
