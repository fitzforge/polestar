-- Korean (koKR): the guide forever/collectibles/mounts/alliance/horse (forever/collectibles/mounts/alliance/horse.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Horse"] = "말",

	-- Step 1: Learn to ride
	["Learn to ride"] = "탈것 타기 배우기",
	-- {npc:4732} Randal Hunter · {npc:384} Katie Hunter · {object:95} Eastvale Logging Camp (no name in this language: may be words) · {zone:1429} Elwynn Forest · {skill:762} Riding · {faction:72} Stormwind
	["{npc:4732} and {npc:384}'s horse pen are at {object:95} in eastern {zone:1429}. At 40 {npc:4732} teaches {skill:762} to Humans for 100g (10% less at Honored with {faction:72}), and it comes with a horse. Other races learn {skill:762}, with their own first mount, at their own race's riding trainer."] = "",
	-- {npc:4732} Randal Hunter
	["{npc:4732}, riding trainer"] = "{npc:4732}, 탈것 상급자",

	-- Step 2: Horse Riding for other races
	-- {skill:762} Riding
	["Horse {skill:762} for other races"] = "",
	-- {skill:762} Riding · {npc:4732} Randal Hunter · {faction:72} Stormwind
	["Any Alliance race can buy these horses, but riding one also takes Horse Riding, which only Humans get with {skill:762}. {npc:4732} teaches it to other races once they are Exalted with {faction:72} (the Stormwind Reputation guide shows the way). Until then, don't buy a horse for this character."] = "",
	-- {npc:4732} Randal Hunter
	["{npc:4732}, Horse Riding"] = "",

	-- Step 3: Pick a colour
	["Pick a colour"] = "색상 고르기",
	-- {npc:384} Katie Hunter
	["{npc:384} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:384}이(가) 다른 색상을 판매합니다(Forever 클라이언트에서 각 20골드). 원하는 것을 구매하거나, 받은 탈것이 마음에 들면 사지 않아도 됩니다.",
	-- {item:2414} Pinto Bridle
	["{item:2414}, 20g"] = "{item:2414}, 20골드",
	-- {item:5655} Chestnut Mare Bridle
	["{item:5655}, 20g"] = "{item:5655}, 20골드",
	-- {item:5656} Brown Horse Bridle
	["{item:5656}, 20g"] = "{item:5656}, 20골드",

	-- Step 4: Black Stallion in Menethil Harbor
	-- {npc:5404} Black Stallion · {object:1162} Menethil Harbor (no name in this language: may be words)
	["{npc:5404} in {object:1162}"] = "",
	-- {npc:5404} Black Stallion · {npc:384} Katie Hunter · {npc:1460} Unger Statforth · {object:1162} Menethil Harbor (no name in this language: may be words) · {zone:1437} Wetlands
	["The {npc:5404} is not at {npc:384}: {npc:1460} sells it, at the stables of {object:1162} in the {zone:1437} (20g in the Forever client). Skip this unless you want that colour."] = "",
	-- {item:2411} Black Stallion Bridle · {npc:1460} Unger Statforth
	["{item:2411}, 20g, {npc:1460}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{item:2411} is in the client, but no vendor is confirmed to sell it in Forever."] = "{item:2411}은(는) 클라이언트에 있지만, Forever에서 판매하는 상인은 확인되지 않았습니다.",
	-- ["{npc:4732} and {npc:384}'s horse pen are at {area:88} in eastern {zone:1429}. At 40 {npc:4732} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "{npc:4732}와(과) {npc:384}의 말 우리는 {zone:1429} 동쪽 {area:88}에 있습니다. 40레벨에 {npc:4732}이(가) {skill:762}을(를) 가르치며(블리자드 개발진 기준 100골드), 배우면 탈것을 하나 받습니다. Forever 클라이언트에서는 모든 얼라이언스 종족이 이 탈것을 탈 수 있습니다.",
}
