-- Korean (koKR): the guide forever/class/shaman/darkreaver (forever/class/shaman/darkreaver.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:2057} Scholomance · {item:20134} Skyfury Helm
	["A {area:2057} fight at 60 for Horde reputation; Forever removed the {item:20134}."] = "호드 평판을 위한 60레벨 {area:2057} 전투. Forever에서는 {item:20134}이(가) 사라졌습니다.",
	["200 Horde reputation"] = "호드 평판 200",

	-- Step 1: Sagorne Creststrider
	-- {npc:13417} Sagorne Creststrider · {object:172957} Valley of Wisdom
	["At 58 {npc:13417}, the shaman trainer in the {object:172957}, asks for two rare diamonds."] = "58레벨에 {object:172957}의 주술사 상급자 {npc:13417}이(가) 희귀한 다이아몬드 두 개를 요구합니다.",

	-- Step 2: Two diamonds
	["Two diamonds"] = "다이아몬드 두 개",
	-- {item:12800} Azerothian Diamond · {item:18335} Pristine Black Diamond · {zone:1422} Western Plaguelands
	["An {item:12800} comes from Thorium veins, a {item:18335} from the elites of the {zone:1422}, both rarely: buy them at the auction house if you can."] = "{item:12800}은(는) 토륨 광맥에서, {item:18335}은(는) {zone:1422}의 정예 몹에게서 나오며 둘 다 드뭅니다. 가능하면 경매장에서 사세요.",

	-- Step 3: Sagorne Creststrider
	-- {quest:7668} The Darkreaver Menace
	["{quest:7668} needs level 60."] = "{quest:7668}은(는) 60레벨이 필요합니다.",
	-- {item:18746} Divination Scryer
	["he hands you the {item:18746}"] = "그가 {item:18746}을(를) 줍니다",

	-- Step 4: The Great Ossuary
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:18746} Divination Scryer · {object:179746} The Great Ossuary (no name in this language: may be words) · {npc:14516} Death Knight Darkreaver
	["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. Use the {item:18746} in the heart of the {object:179746}'s basement, beat the spirits it calls, then {npc:14516}. All are elite: bring a group."] = "{area:2057}은(는) {zone:1422} 남동쪽의 섬 마을인 {area:2298} 아래에 있습니다. 거대한 납골당 지하실 중앙에서 {item:18746}을(를) 사용하고 나타나는 영혼들을 물리친 뒤 {npc:14516}을(를) 물리치세요. 모두 정예이니 파티를 데려가세요.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. Use the {item:18746} in the heart of the {object:179746}'s basement, beat the spirits it calls, then {npc:14516}. All are elite: bring a group."] = "{area:2057}은(는) {zone:1422} 남동쪽의 섬 마을인 {area:2298} 아래에 있습니다. {object:179746} 지하실 중앙에서 {item:18746}을(를) 사용하고 나타나는 영혼들을 물리친 뒤 {npc:14516}을(를) 물리치세요. 모두 정예이니 파티를 데려가세요.",
}
