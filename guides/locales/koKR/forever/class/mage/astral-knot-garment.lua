-- Korean (koKR): the guide forever/class/mage/astral-knot-garment (forever/class/mage/astral-knot-garment.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A robe or a blouse for Human and Gnome mages in their late 20s."] = "20대 후반 인간과 노움 마법사를 위한 로브 또는 블라우스입니다.",

	-- Step 1: Bink (Ironforge)
	-- {npc:5144} Bink · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind
	["{npc:5144} teaches mages in {zone:1455}'s {object:32362}. Take the {area:2257} from {object:171524} to {zone:1453} afterwards."] = "{npc:5144}은(는) {zone:1455}의 {object:32362}에서 마법사를 가르칩니다. 이후 {object:171524}에서 {area:2257}을(를) 타고 {zone:1453}(으)로 가십시오.",

	-- Step 2: Jennea Cannon (Stormwind)
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter
	["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}."] = "{npc:5497}은(는) {object:2101}의 탑인 마법사의 성소에 있습니다.",

	-- Step 3: High Sorcerer Andromath
	-- {quest:1939} High Sorcerer Andromath
	["{quest:1939} is in the Wizard's Sanctum too."] = "{quest:1939}도 마법사의 성소에 있습니다.",

	-- Step 4: The Tower of Ilgalar
	-- {area:96} Tower of Ilgalar
	["The {area:96}"] = "{area:96}",
	-- {zone:1429} Elwynn Forest
	["Ride east through {zone:1429} into Redridge. The fallen mage's tower of Ilgalar stands in the east of the zone; the treatise is in his library."] = "{zone:1429}을(를) 지나 동쪽 붉은마루 산맥으로 가십시오. 타락한 마법사 일갈라의 탑은 지역 동쪽에 있으며, 논문은 그의 서재에 있습니다.",

	-- Step 5: Back to Andromath
	["Back to Andromath"] = "고위마술사 안드로매스에게 돌아가기",

	-- Step 6: Carrion Recluses
	-- plural, as words: Carrion Recluses = {npc:949} Carrion Recluse
	["Carrion Recluses"] = "청소부그늘거미",
	-- {zone:1431} Duskwood
	-- plural, as words: Carrion Recluses = {npc:949} Carrion Recluse · Black Widow Hatchlings = {npc:930} Black Widow Hatchling
	["Carrion Recluses lurk in the woods of western {zone:1431} and each one drops the silk. The Black Widow Hatchlings further east drop it now and then."] = "청소부그늘거미는 {zone:1431} 서쪽 숲에 숨어 있으며, 모두 거미줄을 떨어뜨립니다. 더 동쪽의 새끼 검은과부거미도 가끔 떨어뜨립니다.",

	-- Step 7: Wynne Larson
	-- {npc:1309} Wynne Larson · {object:23296} Larson Clothiers · {object:2101} Mage Quarter
	["{npc:1309} works at {object:23296} in the {object:2101}."] = "{npc:1309}은(는) {object:2101}의 {object:23296}에서 일합니다.",
}
