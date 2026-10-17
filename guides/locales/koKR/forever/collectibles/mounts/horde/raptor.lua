-- Korean (koKR): the guide forever/collectibles/mounts/horde/raptor (forever/collectibles/mounts/horde/raptor.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Raptor"] = "랩터",

	-- Step 1: Learn to ride
	["Learn to ride"] = "탈것 타기 배우기",
	-- {npc:7953} Xar'Ti · {npc:7952} Zjolnir · {area:367} Sen'jin Village · {zone:1411} Durotar · {skill:762} Riding
	["{npc:7953} and {npc:7952}'s raptors are in {area:367} on the {zone:1411} coast. At 40 {npc:7953} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Horde race ride these."] = "{npc:7953}와(과) {npc:7952}의 랩터는 {zone:1411} 해안의 {area:367}에 있습니다. 40레벨에 {npc:7953}이(가) {skill:762}을(를) 가르치며(Blizzard 개발진에 따르면 100골드), 배우면 탈것을 받습니다. Forever 클라이언트에서는 모든 호드 종족이 이 탈것을 탈 수 있습니다.",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}, 탈것 상급자",

	-- Step 2: Pick a colour
	["Pick a colour"] = "색상 고르기",
	-- {npc:7952} Zjolnir
	["{npc:7952} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:7952}이(가) 다른 색상을 판매합니다(Forever 클라이언트에서 각각 20골드). 원하는 것을 사거나, 받은 탈것이 마음에 들면 사지 않아도 됩니다.",
	-- {item:8588} Whistle of the Emerald Raptor
	["{item:8588}, 20g"] = "{item:8588}, 20골드",
	-- {item:8591} Whistle of the Turquoise Raptor
	["{item:8591}, 20g"] = "{item:8591}, 20골드",
	-- {item:8592} Whistle of the Violet Raptor
	["{item:8592}, 20g"] = "{item:8592}, 20골드",
}
