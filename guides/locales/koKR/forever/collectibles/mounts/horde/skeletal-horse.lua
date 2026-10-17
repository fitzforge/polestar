-- Korean (koKR): the guide forever/collectibles/mounts/horde/skeletal-horse (forever/collectibles/mounts/horde/skeletal-horse.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn to ride
	["Learn to ride"] = "탈것 타기 배우기",
	-- {npc:4773} Velma Warnam · {npc:4731} Zachariah Post · {area:159} Brill · {zone:1420} Tirisfal Glades · {skill:762} Riding
	["{npc:4773} and {npc:4731}'s stable are in {area:159}, {zone:1420}. At 40 {npc:4773} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Horde race ride these."] = "{npc:4773}와(과) {npc:4731}의 마구간은 {zone:1420} {area:159}에 있습니다. 40레벨에 {npc:4773}이(가) {skill:762}을(를) 가르치며(Blizzard 개발진에 따르면 100골드), 배우면 탈것을 받습니다. Forever 클라이언트에서는 모든 호드 종족이 이 탈것을 탈 수 있습니다.",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}, 탈것 상급자",

	-- Step 2: Pick a colour
	["Pick a colour"] = "색상 고르기",
	-- {npc:4731} Zachariah Post
	["{npc:4731} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:4731}이(가) 다른 색상을 판매합니다(Forever 클라이언트에서 각각 20골드). 원하는 것을 사거나, 받은 탈것이 마음에 들면 사지 않아도 됩니다.",
	-- {item:13331} Red Skeletal Horse
	["{item:13331}, 20g"] = "{item:13331}, 20골드",
	-- {item:13332} Blue Skeletal Horse
	["{item:13332}, 20g"] = "{item:13332}, 20골드",
	-- {item:13333} Brown Skeletal Horse
	["{item:13333}, 20g"] = "{item:13333}, 20골드",
	-- {npc:267354} Black Skeletal Horse
	["{npc:267354} is a new Forever horse (level 40) whose source is not known yet."] = "{npc:267354}은(는) Forever의 새 말(40레벨)이며 획득처는 아직 알려지지 않았습니다.",
}
