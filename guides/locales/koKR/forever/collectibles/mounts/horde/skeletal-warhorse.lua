-- Korean (koKR): the guide forever/collectibles/mounts/horde/skeletal-warhorse (forever/collectibles/mounts/horde/skeletal-warhorse.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Skeletal Warhorse"] = "전투해골마",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "수습 {skill:762}",
	-- {npc:4773} Velma Warnam · {npc:4731} Zachariah Post · {area:159} Brill · {zone:1420} Tirisfal Glades · {skill:762} Riding
	["{npc:4773} and {npc:4731}'s stable are in {area:159}, {zone:1420}. At 60 {npc:4773} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each skeletal warhorse for 200g at level 60."] = "{npc:4773}와(과) {npc:4731}의 마구간은 {zone:1420} {area:159}에 있습니다. 60레벨에 {npc:4773}이(가) 수습 {skill:762}을(를) 가르칩니다(블리자드 개발진 기준 1,000골드). 블리자드에 따르면 탈것 타기를 배우면 탈것을 하나 받습니다. Forever 클라이언트에서는 전투해골마를 60레벨에 각 200골드에 판매합니다.",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}, 탈것 상급자",

	-- Step 2: Pick a colour
	["Pick a colour"] = "색상 고르기",
	-- {npc:4731} Zachariah Post
	["{npc:4731} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:4731}이(가) 다른 색상을 판매합니다(Forever 클라이언트에서 각 200골드). 원하는 것을 구매하거나, 받은 탈것이 마음에 들면 사지 않아도 됩니다.",
	-- {item:13334} Green Skeletal Warhorse
	["{item:13334}, 200g"] = "{item:13334}, 200골드",
	-- {item:18791} Purple Skeletal Warhorse
	["{item:18791}, 200g"] = "{item:18791}, 200골드",
	-- {npc:265653} Ochre Skeletal Warhorse
	-- plural, as words: Purple Skeletal Horses = {item:265840} Purple Skeletal Horse
	["The new Forever Green, Dark and Purple Skeletal Horses and the {npc:265653} (level 60) have no known source yet."] = "Forever에 새로 추가된 녹색, 어두운, 보라색 해골마와 {npc:265653}(60레벨)은 아직 알려진 획득처가 없습니다.",
}
