-- Korean (koKR): the guide forever/class/druid/aquatic-form (forever/class/druid/aquatic-form.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Your water travel form: swim fast and breathe underwater, with a belt and an idol besides."] = "물속 이동 변신입니다. 빠르게 헤엄치고 물속에서 숨을 쉴 수 있으며, 허리띠와 우상도 얻습니다.",

	-- Step 1: A Lesson to Learn
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217} stands in the {area:1658}."] = "{npc:4217}은(는) {area:1658}에 서 있습니다.",

	-- Step 2: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. Shrine Baubles lie in the containers on the floor of {area:656}, below {area:2361}: take one to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "{spell:18960}을(를) 시전하세요. {npc:11802}은(는) {area:2361}에 있습니다. {item:15877}은(는) {area:2361} 아래 {area:656} 바닥의 용기 속에 있습니다. 하나를 북서쪽 기슭의 {area:2362}(으)로 가져가 그곳에서 사용하고 {npc:11799}와(과) 대화하세요.",
	-- {item:15877} Shrine Bauble · {object:177785} Bauble Container
	["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}, 호수의 {object:177785}에서",
	-- {area:2362} Shrine of Remulos
	["At the {area:2362}"] = "{area:2362}에서",

	-- Step 3: Half Pendant of Aquatic Agility
	-- {area:2361} Nighthaven · {area:442} Auberdine · {object:177792} Strange Lockbox · {area:443} Ruins of Mathystra
	["Fly from {area:2361} to {area:442}. The {object:177792} lies under the water off the north coast, west of the {area:443}."] = "{area:2361}에서 {area:442}(으)로 날아가세요. {object:177792}은(는) {area:443} 서쪽, 북쪽 해안 앞 물속에 있습니다.",

	-- Step 4: Half Pendant of Aquatic Endurance
	-- {area:442} Auberdine · {zone:1453} Stormwind · {area:108} Sentinel Hill · {object:177790} Strange Lockbox
	["Take the boat from {area:442} to {zone:1453} and fly to {area:108}. Ride north-west to the coast: the {object:177790} lies on the sea floor off the shore."] = "{area:442}에서 배를 타고 {zone:1453}(으)로 간 뒤 {area:108}(으)로 날아가세요. 북서쪽 해안으로 가면 {object:177790}이(가) 해안 앞바다 바닥에 있습니다.",

	-- Step 5: Pendant of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["Cast {spell:18960}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. Fly to {area:702} afterwards."] = "{spell:18960}을(를) 시전하세요. 호수 북서쪽 기슭의 {area:2362} 근처에서 반쪽 두 개를 합쳐 {item:15885}을(를) 만든 뒤, {area:2361}의 {npc:11802}을(를) 만나세요. 그 후 {area:702}(으)로 날아가세요.",
	-- {item:15885} Pendant of the Sea Lion
	["{item:15885}: join the halves at the shrine"] = "{item:15885}: 제단에서 반쪽을 합치세요",

	-- Step 6: Aquatic Form
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Take the portal up to {npc:4217} in the {area:1658}."] = "차원문을 타고 {area:1658}의 {npc:4217}에게 올라가세요.",

	-- Step 7: A Lesson to Learn
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:3033} stands on {area:1639}."] = "{npc:3033}은(는) {area:1639}에 서 있습니다.",

	-- Step 8: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "{spell:18960}을(를) 시전하세요. {npc:11802}은(는) {area:2361}에 있습니다. {item:15877}은(는) {area:656} 바닥에 있으며 몇 분 안에 사라집니다. 하나를 들고 북서쪽 기슭의 {area:2362}까지 곧장 헤엄쳐 가서 사용하고 {npc:11799}와(과) 대화하세요.",

	-- Step 9: Half Pendant of Aquatic Endurance
	-- {npc:11798} Bunthen Plainswind · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest · {zone:1458} Undercity · {object:177790} Strange Lockbox · {area:240} Dead Field · {area:228} Sepulcher
	["Take {npc:11798}'s flight to {zone:1456}, fly to {zone:1454} and take the zeppelin to {zone:1420}; {zone:1421} is south of the {zone:1458}. The {object:177790} lies on the coast west of the {area:240}, north of the {area:228}."] = "{npc:11798}의 비행편으로 {zone:1456}에 간 뒤, {zone:1454}(으)로 날아가 비행선을 타고 {zone:1420}(으)로 가세요. {zone:1421}은(는) {zone:1458} 남쪽에 있습니다. {object:177790}은(는) {area:228} 북쪽, {area:240} 서쪽 해안에 있습니다.",

	-- Step 10: Half Pendant of Aquatic Agility
	-- {object:177792} Strange Lockbox · {area:382} Sludge Fen · {area:380} Crossroads
	["The {object:177792} lies at the north edge of the {area:382}, by the Venture Co. tower, north of the {area:380}."] = "{object:177792}은(는) {area:380} 북쪽, {area:382} 북쪽 가장자리의 투자개발회사 탑 옆에 있습니다.",

	-- Step 11: Pendant of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. {npc:11798} flies druids to {area:1638}."] = "{spell:18960}을(를) 시전하세요. 호수 북서쪽 기슭의 {area:2362} 근처에서 반쪽 두 개를 합쳐 {item:15885}을(를) 만든 뒤, {area:2361}의 {npc:11802}을(를) 만나세요. {npc:11798}이(가) 드루이드를 {area:1638}(으)로 태워 줍니다.",
}
