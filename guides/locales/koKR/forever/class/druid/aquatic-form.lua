-- Korean (koKR): the guide forever/class/druid/aquatic-form (forever/class/druid/aquatic-form.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Your water travel form: swim fast and breathe underwater, with a belt and an idol besides."] = "물속 이동 변신입니다. 빠르게 헤엄치고 물속에서 숨을 쉴 수 있으며, 허리띠와 우상도 얻습니다.",

	-- Step 1: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {spell:18960} Teleport: Moonglade · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["{npc:4217} stands upstairs in the druids' building of the {area:1658}. Skyborne: cast {spell:18960} and take {npc:11800}'s flight from the middle of {area:2361} (she flies druids to {area:702}, no flight path needed), then the portal up."] = "",

	-- Step 3: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {quest:29} Trial of the Lake · {npc:11799} Tajarri · {area:656} Lake Elune'ara · {area:2361} Nighthaven · {object:177524} Bubbly Fissure (no name in this language: may be words) · {item:15877} Shrine Bauble · {area:2362} Shrine of Remulos
	-- plural, as words: Bauble Containers = {object:177785} Bauble Container
	["Cast {spell:18960} to get here: {npc:11802} stands upstairs in the building beside where you land. {quest:29} runs on a 30-minute timer: once you accept it, no teleport or Hearthstone until {npc:11799} has it. Six Bauble Containers (vases) lie in narrow hollows deep on the floor of {area:656} below {area:2361}, often near the bubbling fissures (the {object:177524} in the middle of the lake refills your breath); each comes back three minutes after it is opened, and other druids take them too. Check the {item:15877} is in your bags before you surface: it fades five minutes after you loot it. Swim it straight to the {area:2362} on the north-west shore, use it inside the shrine grounds and speak to {npc:11799} by the tree."] = "",
	-- {item:15877} Shrine Bauble · {object:177785} Bauble Container
	["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}, 호수의 {object:177785}에서",
	-- {area:2362} Shrine of Remulos
	["At the {area:2362}"] = "{area:2362}에서",

	-- Step 4: Half Pendant of Aquatic Agility
	-- {area:2361} Nighthaven · {area:442} Auberdine · {object:177792} Strange Lockbox · {area:456} Cliffspring River
	-- plural, as words: Darkshore Threshers = {npc:2185} Darkshore Thresher
	["Fly from {area:2361} to {area:442}. The {object:177792} lies far out on the sea floor off the north coast, between tall rocks west of where the {area:456} reaches the sea: it cannot be seen from the east side of the rocks. Watch your breath and the Darkshore Threshers; fight above water."] = "",
	-- {item:15883} Half Pendant of Aquatic Agility · {object:177792} Strange Lockbox
	["{item:15883}, from the {object:177792}"] = "",

	-- Step 5: Half Pendant of Aquatic Endurance
	-- {area:442} Auberdine · {zone:1453} Stormwind · {area:108} Sentinel Hill · {object:177790} Strange Lockbox
	["Take the boat from {area:442} to {zone:1453} and fly to {area:108}. Head west to the coast: the {object:177790} lies far out on the sea floor beside a bubbling fissure (air), west of a sunken anchor. Sharks roam here; do not swim on past the wreck beyond it, the deep water brings fatigue."] = "",
	-- {item:15882} Half Pendant of Aquatic Endurance · {object:177790} Strange Lockbox
	["{item:15882}, from the {object:177790}"] = "",

	-- Step 6: Pendant of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {area:2362} Shrine of Remulos · {item:15883} Half Pendant of Aquatic Agility · {zone:1450} Moonglade · {npc:11802} Dendrite Starblaze · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["Cast {spell:18960}. With both halves in your bags, stand by the {area:2362} on the north-west shore and use the {item:15883} to join them, then cast {spell:18960} again (it works inside {zone:1450}) to land by {npc:11802}. He stands upstairs in his building: go up inside, the arrow cannot tell the floors apart. Afterwards {npc:11800}, in the middle of {area:2361}, flies druids straight to {area:702}."] = "",
	-- {item:15885} Pendant of the Sea Lion
	["{item:15885}: join the halves at the shrine"] = "{item:15885}: 제단에서 반쪽을 합치세요",

	-- Step 7: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {quest:31} Aquatic Form
	["Take the portal up to {npc:4217} in the {area:1658}. {quest:31}: swim fast and breathe underwater."] = "",

	-- Step 8: Aquatic Form
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {quest:5061} Aquatic Form
	["Take the portal up to {npc:4217} in the {area:1658}. {quest:5061}: swim fast and breathe underwater."] = "",

	-- Step 9: A Lesson to Learn
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:3033} stands in the druids' hut on {area:1639}."] = "",

	-- Step 10: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {quest:28} Trial of the Lake · {npc:11799} Tajarri · {area:656} Lake Elune'ara · {area:2361} Nighthaven · {object:177524} Bubbly Fissure (no name in this language: may be words) · {item:15877} Shrine Bauble · {area:2362} Shrine of Remulos
	-- plural, as words: Bauble Containers = {object:177785} Bauble Container
	["Cast {spell:18960} to get here: {npc:11802} stands upstairs in the building beside where you land. {quest:28} runs on a 30-minute timer: once you accept it, no teleport or Hearthstone until {npc:11799} has it. Six Bauble Containers (vases) lie in narrow hollows deep on the floor of {area:656} below {area:2361}, often near the bubbling fissures (the {object:177524} in the middle of the lake refills your breath); each comes back three minutes after it is opened, and other druids take them too. Check the {item:15877} is in your bags before you surface: it fades five minutes after you loot it. Swim it straight to the {area:2362} on the north-west shore, use it inside the shrine grounds and speak to {npc:11799} by the tree."] = "",

	-- Step 11: Half Pendant of Aquatic Agility
	-- {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff · {area:1637} Orgrimmar · {object:177792} Strange Lockbox · {area:382} Sludge Fen
	["Take {npc:11798}'s flight to {area:1638} and fly on to {area:1637}. The {object:177792} lies underwater in the {area:382} pond, a short walk out of {area:1637}'s west gate, in front of a wooden wall. The Venture Co. there are quick to join a fight: come in from the west to avoid most of them."] = "",

	-- Step 12: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "",
	-- {area:1637} Orgrimmar · {zone:1458} Undercity · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest
	["Back through {area:1637} to the zeppelin towers outside its main gate: the zeppelin to the {zone:1458} lands in {zone:1420}, and {zone:1421} is south of the {zone:1458}."] = "",

	-- Step 13: Half Pendant of Aquatic Endurance
	-- {object:177790} Strange Lockbox · {area:228} Sepulcher · {spell:18960} Teleport: Moonglade
	["The {object:177790} lies at the bottom of very deep water off the coast north-west of the {area:228}, beside an air fissure where you can breathe: watch your breath on the way down. Then {spell:18960} takes you straight back."] = "",

	-- Step 14: Pendant of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {area:2362} Shrine of Remulos · {item:15883} Half Pendant of Aquatic Agility · {zone:1450} Moonglade · {npc:11802} Dendrite Starblaze · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960}. With both halves in your bags, stand by the {area:2362} on the north-west shore and use the {item:15883} to join them, then cast {spell:18960} again (it works inside {zone:1450}) to land by {npc:11802}. He stands upstairs in his building: go up inside, the arrow cannot tell the floors apart. {npc:11798} flies druids to {area:1638}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast {spell:18960}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. Fly to {area:702} afterwards."] = "{spell:18960}을(를) 시전하세요. 호수 북서쪽 기슭의 {area:2362} 근처에서 반쪽 두 개를 합쳐 {item:15885}을(를) 만든 뒤, {area:2361}의 {npc:11802}을(를) 만나세요. 그 후 {area:702}(으)로 날아가세요.",
	-- ["Cast {spell:18960}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. {npc:11798} flies druids to {area:1638}."] = "{spell:18960}을(를) 시전하세요. 호수 북서쪽 기슭의 {area:2362} 근처에서 반쪽 두 개를 합쳐 {item:15885}을(를) 만든 뒤, {area:2361}의 {npc:11802}을(를) 만나세요. {npc:11798}이(가) 드루이드를 {area:1638}(으)로 태워 줍니다.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}. Shrine Baubles lie in the containers on the floor of {area:656}, below {area:2361}: take one to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "{spell:18960}을(를) 시전하세요. {npc:11802}은(는) {area:2361}에 있습니다. {item:15877}은(는) {area:2361} 아래 {area:656} 바닥의 용기 속에 있습니다. 하나를 북서쪽 기슭의 {area:2362}(으)로 가져가 그곳에서 사용하고 {npc:11799}와(과) 대화하세요.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "{spell:18960}을(를) 시전하세요. {npc:11802}은(는) {area:2361}에 있습니다. {item:15877}은(는) {area:656} 바닥에 있으며 몇 분 안에 사라집니다. 하나를 들고 북서쪽 기슭의 {area:2362}까지 곧장 헤엄쳐 가서 사용하고 {npc:11799}와(과) 대화하세요.",
	-- ["Fly from {area:2361} to {area:442}. The {object:177792} lies under the water off the north coast, west of the {area:443}."] = "{area:2361}에서 {area:442}(으)로 날아가세요. {object:177792}은(는) {area:443} 서쪽, 북쪽 해안 앞 물속에 있습니다.",
	-- ["Take the boat from {area:442} to {zone:1453} and fly to {area:108}. Ride north-west to the coast: the {object:177790} lies on the sea floor off the shore."] = "{area:442}에서 배를 타고 {zone:1453}(으)로 간 뒤 {area:108}(으)로 날아가세요. 북서쪽 해안으로 가면 {object:177790}이(가) 해안 앞바다 바닥에 있습니다.",
	-- ["Take the portal up to {npc:4217} in the {area:1658}."] = "차원문을 타고 {area:1658}의 {npc:4217}에게 올라가세요.",
	-- ["Take {npc:11798}'s flight to {zone:1456}, fly to {zone:1454} and take the zeppelin to {zone:1420}; {zone:1421} is south of the {zone:1458}. The {object:177790} lies on the coast west of the {area:240}, north of the {area:228}."] = "{npc:11798}의 비행편으로 {zone:1456}에 간 뒤, {zone:1454}(으)로 날아가 비행선을 타고 {zone:1420}(으)로 가세요. {zone:1421}은(는) {zone:1458} 남쪽에 있습니다. {object:177790}은(는) {area:228} 북쪽, {area:240} 서쪽 해안에 있습니다.",
	-- ["The {object:177792} lies at the north edge of the {area:382}, by the Venture Co. tower, north of the {area:380}."] = "{object:177792}은(는) {area:380} 북쪽, {area:382} 북쪽 가장자리의 투자개발회사 탑 옆에 있습니다.",
	-- ["{npc:3033} stands on {area:1639}."] = "{npc:3033}은(는) {area:1639}에 서 있습니다.",
	-- ["{npc:4217} stands in the {area:1658}."] = "{npc:4217}은(는) {area:1658}에 서 있습니다.",
}
