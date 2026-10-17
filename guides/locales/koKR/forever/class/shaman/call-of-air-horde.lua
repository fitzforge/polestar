-- Korean (koKR): the guide forever/class/shaman/call-of-air-horde (forever/class/shaman/call-of-air-horde.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:1531} Call of Air
	["{quest:1531} and the Tempest's Weapons (Horde)"] = "{quest:1531}와(과) the Tempest's Weapons (호드)",
	-- {item:5178} Air Totem
	["The {item:5178} that lets you place air totems, then a weapon of your choice at 40."] = "바람의 토템을 놓을 수 있게 해 주는 {item:5178}, 그리고 40레벨에 원하는 무기 하나.",

	-- Step 1: Searn Firewarder
	-- {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom · {npc:5905} Prate Cloudseer · {zone:1441} Thousand Needles
	["At 30 {npc:5892} in the {object:172957} sends you to {npc:5905} in {zone:1441}."] = "30레벨에 {object:172957}의 {npc:5892}이(가) 당신을 {zone:1441}의 {npc:5905}에게 보냅니다.",

	-- Step 2: Xanis Flameweaver
	-- {npc:5906} Xanis Flameweaver · {zone:1456} Thunder Bluff · {npc:5905} Prate Cloudseer · {zone:1441} Thousand Needles
	["At 30 {npc:5906}, a shaman trainer in {zone:1456}, sends you to {npc:5905} in {zone:1441}."] = "30레벨에 {zone:1456}의 주술사 상급자 {npc:5906}이(가) 당신을 {zone:1441}의 {npc:5905}에게 보냅니다.",

	-- Step 3: Prate Cloudseer
	-- {area:484} Freewind Post · {npc:5905} Prate Cloudseer · {quest:1531} Call of Air
	["Fly to {area:484}. {npc:5905} hides in a small cave in the canyon wall north-east of the post. Skyborne: your own {quest:1531} (96136) ends with her too."] = "{area:484}(으)로 날아가세요. {npc:5905}은(는) 거점 북동쪽 협곡 벽의 작은 동굴에 숨어 있습니다. 스카이본: 당신의 {quest:1531}(96136)도 그녀에게서 끝납니다.",
	-- {npc:5905} Prate Cloudseer · {item:5178} Air Totem
	["{npc:5905}: your {item:5178}"] = "{npc:5905}: {item:5178}",

	-- Step 4: Charlga Razorflank
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {npc:4421} Charlga Razorflank
	["{area:1717} is a dungeon at the southern edge of the {zone:1413} (the arrow points at its entrance); {npc:4421} is its last boss. Bring a group."] = "{area:1717}은(는) {zone:1413} 남쪽 끝의 던전입니다(화살표가 입구를 가리킵니다). {npc:4421}은(는) 마지막 우두머리입니다. 파티를 데려가세요.",
	-- {item:274463} Tattered Note · {npc:4421} Charlga Razorflank
	["{item:274463}, from {npc:4421}"] = "{item:274463}, {npc:4421}에게서",

	-- Step 5: Rau Cliffrunner
	-- {npc:4722} Rau Cliffrunner · {area:484} Freewind Post
	["{npc:4722} stands at {area:484}."] = "{npc:4722}은(는) {area:484}에 서 있습니다.",

	-- Step 7: Twisted Air Totems
	-- plural, as words: Twisted Air Totems = {item:274047} Twisted Air Totem
	["Twisted Air Totems"] = "뒤틀린 바람 토템",
	-- {zone:1443} Desolace
	-- plural, as words: Twisted Air Totems = {item:274047} Twisted Air Totem
	["The Maraudine centaurs of western {zone:1443} carry the Twisted Air Totems."] = "{zone:1443} 서부의 마라우돈일족 켄타우로스가 뒤틀린 바람 토템을 지니고 있습니다.",

	-- Step 8: Twisted Water Totems
	-- plural, as words: Twisted Water Totems = {item:274046} Twisted Water Totem
	["Twisted Water Totems"] = "뒤틀린 물 토템",
	-- {zone:1445} Dustwallow Marsh
	-- plural, as words: Twisted Water Totems = {item:274046} Twisted Water Totem
	["The Mirefin murlocs of northern {zone:1445} carry the Twisted Water Totems."] = "{zone:1445} 북부의 진흙아가미멀록이 뒤틀린 물 토템을 지니고 있습니다.",

	-- Step 9: Twisted Fire Totems
	-- plural, as words: Twisted Fire Totems = {item:274044} Twisted Fire Totem
	["Twisted Fire Totems"] = "뒤틀린 불의 토템",
	-- {zone:1418} Badlands
	-- plural, as words: Twisted Fire Totems = {item:274044} Twisted Fire Totem
	["The Stonevault troggs in the south of the {zone:1418} carry the Twisted Fire Totems."] = "{zone:1418} 남부의 바위동굴 트로그가 뒤틀린 불의 토템을 지니고 있습니다.",

	-- Step 10: Twisted Earth Totems
	-- plural, as words: Twisted Earth Totems = {item:274045} Twisted Earth Totem
	["Twisted Earth Totems"] = "뒤틀린 대지 토템",
	-- {zone:1435} Swamp of Sorrows
	-- plural, as words: The Lost Ones = {npc:256028} The Lost One · Twisted Earth Totems = {item:274045} Twisted Earth Totem
	["The Lost Ones in the north of the {zone:1435} carry the Twisted Earth Totems."] = "{zone:1435} 북부의 드레노어 난민이 뒤틀린 대지 토템을 지니고 있습니다.",

	-- Step 12: The steam pools
	["The steam pools"] = "증기 웅덩이",
	-- {npc:5905} Prate Cloudseer · {item:268582} Corrupted Totems · {area:484} Freewind Post · {npc:216474} Ravaging Tempest · {quest:79366} Heed My Call
	["{npc:5905} hands you the {item:268582}: place them at the steam pools west of {area:484} and defeat the {npc:216474} they call. {quest:79366} is an elite quest: grouping up is advised."] = "{npc:5905}이(가) {item:268582}을(를) 줍니다. {area:484} 서쪽 증기 웅덩이에 놓고 나타나는 {npc:216474}을(를) 물리치세요. {quest:79366}은(는) 정예 퀘스트이니 파티를 권장합니다.",
	-- {item:212792} Eye of the Tempest · {npc:216474} Ravaging Tempest
	["{item:212792}, from the {npc:216474}"] = "{item:212792}, {npc:216474}에게서",

	-- Step 14: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher · {zone:1416} Alterac Mountains · {area:272} Tarren Mill
	["{npc:6176} camps in the east of {zone:1416}, north-east of {area:272}."] = "{npc:6176}은(는) {zone:1416} 동쪽, {area:272} 북동쪽에 진을 치고 있습니다.",
	-- {npc:6176} Bath'rah the Windwatcher · {item:213086} Rune of the Storm
	["{npc:6176}: the {item:213086} and your weapon"] = "{npc:6176}: {item:213086}와(과) 무기",
}
