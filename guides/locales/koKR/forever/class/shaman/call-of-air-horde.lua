-- Korean (koKR): the guide forever/class/shaman/call-of-air-horde (forever/class/shaman/call-of-air-horde.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom · {npc:5905} Prate Cloudseer · {zone:1441} Thousand Needles · {spell:10596} Nature Resistance · {item:5178} Air Totem
	["At 30 {npc:5892} in the {object:172957} sends you to {npc:5905} in {zone:1441}. Your level 30 air totems (Grounding, {spell:10596}) need the {item:5178} she gives."] = "",

	-- Step 2: Alaana Stormwalker
	-- {quest:96136} Call of Air · {npc:259119} Alaana Stormwalker · {zone:1412} Mulgore · {zone:1456} Thunder Bluff · {npc:5906} Xanis Flameweaver
	["At 30 Skyborne shamans get their own {quest:96136}. {npc:259119} waits where the airship from Zephras Isle lands, in northern {zone:1412} beside {zone:1456}. Your level 30 air totems need the Air Totem Prate Cloudseer gives. If she has nothing for you, head up to {npc:5906} in {zone:1456} (next step): the trainers' {quest:96136} is open to Skyborne and gives the same totem."] = "",

	-- Step 3: Xanis Flameweaver
	-- {npc:5906} Xanis Flameweaver · {area:1640} Spirit Rise · {zone:1456} Thunder Bluff · {npc:5905} Prate Cloudseer · {zone:1441} Thousand Needles · {spell:10596} Nature Resistance · {npc:5892} Searn Firewarder · {quest:1531} Call of Air · {zone:1454} Orgrimmar
	["At 30 {npc:5906}, a shaman trainer on {area:1640} in {zone:1456}, sends you to {npc:5905} in {zone:1441}. Your level 30 air totems (Grounding, {spell:10596}) need the Air Totem Prate gives. Already carry {npc:5892}'s {quest:1531} from {zone:1454}? It goes to {npc:5905} too: skip {npc:5906}."] = "",

	-- Step 4: Prate Cloudseer
	-- {area:484} Freewind Post · {npc:5905} Prate Cloudseer
	["Fly to {area:484}. {npc:5905} stands on a ledge above a cave mouth in the canyon wall north-east of the post, not inside the cave: climb the slope beside it. She also gives you an hour of faster attacks and running."] = "",

	-- Step 5
	-- {npc:5905} Prate Cloudseer · {item:5178} Air Totem
	["{npc:5905}: your {item:5178}"] = "{npc:5905}: {item:5178}",

	-- Step 9: Charlga Razorflank
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {npc:4421} Charlga Razorflank · {spell:8292} Chain Bolt · {spell:139} Renew · {item:274463} Tattered Note
	["{area:1717} is a five-player dungeon at the southern edge of the {zone:1413} (the arrow points at its entrance); {npc:4421} (level 33 elite) is its last boss. She casts {spell:8292}, {spell:139} on her allies and Purity; the {item:274463} drops only from her."] = "",
	-- {item:274463} Tattered Note · {npc:4421} Charlga Razorflank
	["{item:274463}, from {npc:4421}"] = "{item:274463}, {npc:4421}에게서",

	-- Step 10: Rau Cliffrunner
	-- {npc:4722} Rau Cliffrunner · {area:484} Freewind Post
	["{npc:4722} stands at {area:484}."] = "{npc:4722}은(는) {area:484}에 서 있습니다.",

	-- Step 12: Twisted Air Totems
	-- plural, as words: Twisted Air Totems = {item:274047} Twisted Air Totem
	["Twisted Air Totems"] = "뒤틀린 바람 토템",
	-- {area:2408} Shadowprey Village · {zone:1443} Desolace · {spell:9654} Jumping Lightning
	-- plural, as words: Twisted Air Totems = {item:274047} Twisted Air Totem
	["Five Twisted Air Totems. The Maraudine centaurs (level 36-40) north and north-east of {area:2408} in western {zone:1443} carry them; the Scouts drop one nearly every other kill. Wranglers Net and Disarm, Windchasers heal, Stormers throw {spell:9654}: pull one at a time. Respawn about five minutes."] = "",

	-- Step 13: Twisted Water Totems
	-- plural, as words: Twisted Water Totems = {item:274046} Twisted Water Totem
	["Twisted Water Totems"] = "뒤틀린 물 토템",
	-- {area:496} Brackenwall Village · {zone:1445} Dustwallow Marsh
	-- plural, as words: Twisted Water Totems = {item:274046} Twisted Water Totem
	["Five Twisted Water Totems. The Mirefin murlocs (level 35-38) north-east of {area:496} in northern {zone:1445} carry them."] = "",

	-- Step 14: Twisted Fire Totems
	-- plural, as words: Twisted Fire Totems = {item:274044} Twisted Fire Totem
	["Twisted Fire Totems"] = "뒤틀린 불의 토템",
	-- {area:338} Angor Fortress · {zone:1418} Badlands · {npc:3560} Healing Ward
	-- plural, as words: Twisted Fire Totems = {item:274044} Twisted Fire Totem · Fire Nova Totems = {npc:5879} Fire Nova Totem
	["Five Twisted Fire Totems. The Stonevault troggs (Skullthumpers, Bonesnappers and Shamans, level 37-41) south of {area:338} in the {zone:1418} carry them; the Shamans drop Fire Nova Totems and a {npc:3560}, the Bonesnappers run for help when hurt. Respawn about five minutes."] = "",

	-- Step 15: Twisted Earth Totems
	-- plural, as words: Twisted Earth Totems = {item:274045} Twisted Earth Totem
	["Twisted Earth Totems"] = "뒤틀린 대지 토템",
	-- {area:75} Stonard · {zone:1435} Swamp of Sorrows
	-- plural, as words: Twisted Earth Totems = {item:274045} Twisted Earth Totem · The Lost Ones = {npc:256028} The Lost One
	["Five Twisted Earth Totems. The Lost Ones (murlocs, level 34-39) north and north-east of {area:75} in the {zone:1435} carry them; most run for help when hurt."] = "",

	-- Step 17: The steam pools
	["The steam pools"] = "증기 웅덩이",
	-- {npc:5905} Prate Cloudseer · {item:268582} Corrupted Totems · {area:484} Freewind Post · {npc:216474} Ravaging Tempest · {item:212792} Eye of the Tempest
	["{npc:5905} hands you the {item:268582}. Place the {item:268582} at the steam pools north-west of {area:484} to call the corrupted elementals and then the {npc:216474}; Razormane quilboar join the fight while the ritual runs. A group quest: bring at least one or two friends. The {item:212792} drops about every other kill, and every group member can loot it."] = "",
	-- {item:212792} Eye of the Tempest · {npc:216474} Ravaging Tempest
	["{item:212792}, from the {npc:216474}"] = "{item:212792}, {npc:216474}에게서",

	-- Step 19: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher · {zone:1416} Alterac Mountains · {area:272} Tarren Mill · {item:280607} Lightning's Grasp · {item:280605} Tidebringer's Claw · {item:280604} Rage of the Storm · {item:280696} Elementalist's Guard
	["{npc:6176} camps in the ruins in the east of {zone:1416}: from {area:272} follow the river east of town north into the hills. Pick your weapon: {item:280607}, {item:280605} or {item:280604}; the {item:280696} shield comes with it."] = "",
	-- {npc:6176} Bath'rah the Windwatcher · {item:280696} Elementalist's Guard
	["{npc:6176}: the {item:280696} and your weapon"] = "{npc:6176}: {item:280696}와(과) 무기",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 30 {npc:5892} in the {object:172957} sends you to {npc:5905} in {zone:1441}."] = "30레벨에 {object:172957}의 {npc:5892}이(가) 당신을 {zone:1441}의 {npc:5905}에게 보냅니다.",
	-- ["At 30 {npc:5906}, a shaman trainer in {zone:1456}, sends you to {npc:5905} in {zone:1441}."] = "30레벨에 {zone:1456}의 주술사 상급자 {npc:5906}이(가) 당신을 {zone:1441}의 {npc:5905}에게 보냅니다.",
	-- ["Fly to {area:484}. {npc:5905} hides in a small cave in the canyon wall north-east of the post. Skyborne: your own {quest:1531} (96136) ends with her too."] = "{area:484}(으)로 날아가세요. {npc:5905}은(는) 거점 북동쪽 협곡 벽의 작은 동굴에 숨어 있습니다. 스카이본: 당신의 {quest:1531}(96136)도 그녀에게서 끝납니다.",
	-- ["The Lost Ones in the north of the {zone:1435} carry the Twisted Earth Totems."] = "{zone:1435} 북부의 드레노어 난민이 뒤틀린 대지 토템을 지니고 있습니다.",
	-- ["The Maraudine centaurs of western {zone:1443} carry the Twisted Air Totems."] = "{zone:1443} 서부의 마라우돈일족 켄타우로스가 뒤틀린 바람 토템을 지니고 있습니다.",
	-- ["The Mirefin murlocs of northern {zone:1445} carry the Twisted Water Totems."] = "{zone:1445} 북부의 진흙아가미멀록이 뒤틀린 물 토템을 지니고 있습니다.",
	-- ["The Stonevault troggs in the south of the {zone:1418} carry the Twisted Fire Totems."] = "{zone:1418} 남부의 바위동굴 트로그가 뒤틀린 불의 토템을 지니고 있습니다.",
	-- ["{area:1717} is a dungeon at the southern edge of the {zone:1413} (the arrow points at its entrance); {npc:4421} is its last boss. Bring a group."] = "{area:1717}은(는) {zone:1413} 남쪽 끝의 던전입니다(화살표가 입구를 가리킵니다). {npc:4421}은(는) 마지막 우두머리입니다. 파티를 데려가세요.",
	-- ["{npc:5905} hands you the {item:268582}: place them at the steam pools west of {area:484} and defeat the {npc:216474} they call. {quest:79366} is an elite quest: grouping up is advised."] = "{npc:5905}이(가) {item:268582}을(를) 줍니다. {area:484} 서쪽 증기 웅덩이에 놓고 나타나는 {npc:216474}을(를) 물리치세요. {quest:79366}은(는) 정예 퀘스트이니 파티를 권장합니다.",
	-- ["{npc:6176} camps in the east of {zone:1416}, north-east of {area:272}."] = "{npc:6176}은(는) {zone:1416} 동쪽, {area:272} 북동쪽에 진을 치고 있습니다.",
	-- ["{npc:6176}: the {item:213086} and your weapon"] = "{npc:6176}: {item:213086}와(과) 무기",
}
