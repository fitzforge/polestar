-- Korean (koKR): the guide forever/alliance/50-60/01-burning-steppes (forever/alliance/50-60/01-burning-steppes.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Menethil Harbor
	-- {zone:1455} Ironforge · {area:150} Menethil Harbor · {area:442} Auberdine
	["Fly from {zone:1455} to {area:150} and take the boat to {area:442}."] = "{zone:1455}에서 {area:150}(으)로 날아가 배를 타고 {area:442}(으)로 가세요.",

	-- Step 2: Auberdine
	-- {area:442} Auberdine · {area:415} Astranaar
	["From the {area:442} dock, fly to {area:415}."] = "{area:442} 부두에서 {area:415}(으)로 날아가세요.",

	-- Step 3: Talrendis Point
	-- {zone:1440} Ashenvale · {zone:1447} Azshara · {area:3137} Talrendis Point
	["Ride east along the road out of {zone:1440} into {zone:1447} to the Sentinels' camp at {area:3137}."] = "길을 따라 동쪽으로 {zone:1440}을(를) 벗어나 {zone:1447}에 들어가 {area:3137}의 파수꾼 야영지로 가세요.",

	-- Step 4: Shadowsong Shrine
	-- {zone:1447} Azshara · {area:3137} Talrendis Point
	["The shrine lies in the south-west corner of {zone:1447}, south of {area:3137}."] = "섀도송 제단은 {area:3137} 남쪽, {zone:1447} 남서쪽 구석에 있습니다.",

	-- Step 5: Haldarr Encampment
	["The Highborne ghosts haunt the ruins around the shrine; the Haldarr satyrs hold the camp just north of it."] = "명가 유령들이 제단 주변 폐허를 떠돌고, 할다르 사티로스가 그 바로 북쪽 야영지를 차지하고 있습니다.",

	-- Step 7: Ogtinc
	-- {npc:8405} Ogtinc · {area:1224} Bear's Head
	["Ride north-east from the shrine: {npc:8405} camps at the {area:1224}, in the hills above the road."] = "제단에서 북동쪽으로 가세요. {npc:8405}은(는) 길 위 언덕의 {area:1224}에 진을 치고 있습니다.",

	-- Step 8: Mosshoof Coursers
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers"] = "{npc:8761}",
	-- {area:1224} Bear's Head · {area:1219} Legashi Encampment
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south."] = "가장 가까운 {npc:8761}은(는) {area:1224} 북동쪽, {area:1219} 쪽 언덕에서 풀을 뜯고, 더 큰 무리는 남쪽 평지를 돌아다닙니다.",

	-- Step 10: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo
	-- plural, as words: Undamaged Hippogryph Feathers = {item:10450} Undamaged Hippogryph Feather
	["Optional: {npc:8395} wants two Undamaged Hippogryph Feathers from the hippogryphs around his camp. The data lists no experience for it."] = "선택: {npc:8395}이(가) 야영지 주변 히포그리프에게서 얻는 {item:10450} 2개를 원합니다. 데이터에는 경험치가 나와 있지 않습니다.",

	-- Step 11: Kim'jael
	-- {npc:8420} Kim'jael · {area:1219} Legashi Encampment · {area:1220} Thalassian Base Camp
	["{npc:8420} camps at the {area:1219} in the north; his equipment lies all over the {area:1220} just south-east of him."] = "{npc:8420}은(는) 북쪽 {area:1219}에 진을 치고 있으며, 그의 장비는 바로 남동쪽 {area:1220} 곳곳에 흩어져 있습니다.",

	-- Step 12: The Ruins of Eldarath
	-- {area:1221} Ruins of Eldarath
	["The {area:1221}"] = "{area:1221}",
	-- {area:1221} Ruins of Eldarath · {item:13815} Some Rune · {npc:8507} Tymor · {item:10445} Drawing Kit
	["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s four runes stand among the ruins: use his {item:10445} on each."] = "{area:1221}의 원한의꼬리일족 나가가 {item:13815}을(를) 가지고 있습니다. {npc:8507}의 룬 네 개는 폐허 사이에 서 있습니다. 각각에 그의 {item:10445}을(를) 사용하세요.",
	-- {item:7972} Ichor of Undeath · {npc:7864} Lingering Highborne
	["{item:7972}: the {npc:7864}, about 10%"] = "{item:7972}: {npc:7864}, 약 10%",

	-- Step 13: Ogtinc
	-- {npc:8405} Ogtinc · {area:1224} Bear's Head
	["Climb back to {npc:8405} at the {area:1224}, above the ruins."] = "폐허 위 {area:1224}의 {npc:8405}에게 다시 올라가세요.",

	-- Step 15: Ravencrest Monument
	-- {zone:1447} Azshara · {npc:8392} Pilot Xiggs Fuselighter
	["Swim to the small island off the southern tip of {zone:1447}: {npc:8392} waits by the monument."] = "{zone:1447} 남쪽 끝 앞바다의 작은 섬까지 헤엄쳐 가세요. {npc:8392}이(가) 기념비 옆에서 기다립니다.",

	-- Step 17: Lakeshire
	-- {zone:1455} Ironforge · {area:69} Lakeshire
	["Fly from {zone:1455} to {area:69}."] = "{zone:1455}에서 {area:69}(으)로 날아가세요.",

	-- Step 18: Morgan's Vigil
	-- {area:69} Lakeshire · {zone:1428} Burning Steppes · {area:2418} Morgan's Vigil
	["Ride north out of {area:69} through the pass into the {zone:1428}; {area:2418} sits at the top, in the south-east of the Steppes."] = "{area:69}에서 북쪽으로 고개를 넘어 {zone:1428}에 들어가세요. {area:2418}은(는) 고개 꼭대기, 초원 남동쪽에 있습니다.",
	-- {npc:9177} Oralius
	["{npc:9177}: the Blackrock orcs drop the medallions, keep it open all through the Steppes"] = "{npc:9177}: 검은바위부족 오크가 메달을 떨어뜨립니다. 불타는 평원 내내 열어 두세요",

	-- Step 19: Dreadmaul Rock
	["The Firegut ogres hold the great rock north of the Vigil, with the Brutes on its east side."] = "불자루 오우거가 감시초소 북쪽의 큰 바위를 차지하고 있고, 불자루일족 투사는 그 동쪽에 있습니다.",

	-- Step 21: Flame Crest
	-- {area:251} Flame Crest
	["Follow the road west, then climb north to the goblin camp on {area:251}."] = "길을 따라 서쪽으로 간 뒤 북쪽으로 올라가 {area:251}의 고블린 야영지로 가세요.",

	-- Step 22: Thaurissan Relics
	-- plural, as words: Thaurissan Relics = {object:153556} Thaurissan Relic
	["Thaurissan Relics"] = "{object:153556}",
	-- {area:250} Ruins of Thaurissan · {area:251} Flame Crest
	["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered."] = "유물은 {area:251} 주변 {area:250}에 흩어진 조각된 돌입니다. 정보가 복구될 때까지 클릭하세요.",

	-- Step 23: The Tablet of the Seven
	-- {quest:4296} Tablet of the Seven
	["The {quest:4296}"] = "{quest:4296}",
	-- {object:147516} Dark Iron · {area:251} Flame Crest
	["Read the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript."] = "{area:251} 남서쪽 폐허 사이의 {object:147516} 야영지에서 석판을 읽고 내용을 베끼세요.",

	-- Step 24: Broodling Essence
	-- {item:12284} Draco-Incarcinatrix 900 · {npc:7047} Black Broodling · {area:251} Flame Crest
	["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves."] = "{area:251} 동쪽 비탈의 {npc:7047}이(가) 죽기 직전에 {item:12284}을(를) 사용한 뒤, 남긴 정수를 획득하세요.",

	-- Step 25: Flame Crest
	-- {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Ends with {quest:4808} in {area:2255}, {zone:1452}: keep it"] = "{zone:1452} {area:2255}의 {quest:4808}에게서 끝납니다: 보관하세요",

	-- Step 26: Blackrock Stronghold
	-- {npc:9176} Gor'tesh · {area:254} Blackrock Mountain · {area:251} Flame Crest
	["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty."] = "{npc:9176}와(과) 검은바위부족 오크가 {area:251} 서쪽, {area:254} 기슭의 야영지와 요새를 차지하고 있습니다. 하나씩 끌어오세요. 오크와 늑대 모두 메달을 떨어뜨릴 수 있으니 50개가 될 때까지 처치하세요.",

	-- Step 27: Franclorn Forgewright
	-- {npc:8888} Franclorn Forgewright · {area:254} Blackrock Mountain
	["Optional: {npc:8888}'s ghost stands on his tomb on the great chain inside {area:254}, and only the dead can see him. If you die near the mountain anyway, run your spirit to him before resurrecting."] = "선택: {npc:8888}의 유령은 {area:254} 안 거대한 사슬 위 그의 무덤에 서 있으며, 죽은 자만 그를 볼 수 있습니다. 어차피 산 근처에서 죽었다면 부활하기 전에 영혼 상태로 그에게 달려가세요.",

	-- Step 28: Morgan's Vigil
	["Ride back east along the road to the Vigil."] = "길을 따라 동쪽으로 감시초소에 돌아가세요.",

	-- Step 29: Dreadmaul Rock
	-- {area:249} Dreadmaul Rock
	["Climb to the top of {area:249} and plant the head in the soft dirt mound."] = "{area:249} 꼭대기에 올라가 부드러운 흙더미에 머리를 꽂으세요.",

	-- Step 31: Nethergarde Keep
	-- {area:1438} Nethergarde Keep
	["Fly to {area:1438}."] = "{area:1438}(으)로 날아가세요.",

	-- Step 32: Kum'isha the Collector
	-- {npc:7363} Kum'isha the Collector · {area:2517} Rise of the Defiler · {zone:1419} Blasted Lands
	-- plural, as words: Imperfect Draenethyst Fragments = {item:10593} Imperfect Draenethyst Fragment
	["{npc:7363} waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have."] = "{npc:7363}은(는) 요새 남서쪽 언덕인 {area:2517}에서 기다립니다. 가는 길의 {zone:1419} 몹이 {item:10593}을(를) 떨어뜨립니다. 가진 만큼 가져가세요.",

	-- Step 33: Wildkin feathers
	["Wildkin feathers"] = "올빼미야수 깃털",
	-- {area:1438} Nethergarde Keep · {area:348} Aerie Peak · {zone:1425} Hinterlands
	-- plural, as words: Wildkin Feathers = {item:10819} Wildkin Feather
	["Ride back to {area:1438} and fly to {area:348}. The Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "{area:1438}(으)로 돌아가 {area:348}(으)로 날아가세요. {item:10819}은(는) {area:348} 남쪽과 동쪽, 올빼미야수가 돌아다니는 {zone:1425} 곳곳의 땅바닥에 있습니다. 이곳 몹은 이제 당신보다 한참 낮습니다.",

	-- Step 35: Menethil Harbor
	-- {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village
	["Fly to {area:150} and take the boat to {area:442}, then the boat on to {area:702}."] = "{area:150}(으)로 날아가 배를 타고 {area:442}(으)로 간 뒤, 다시 배를 타고 {area:702}(으)로 가세요.",

	-- Step 36: Rut'theran Village
	-- {zone:1452} Winterspring
	["The wildkin are in {zone:1452}: keep it"] = "올빼미야수는 {zone:1452}에 있습니다: 보관하세요",

	-- Step 37: Druid training
	["Druid training"] = "드루이드 수련",
	-- {zone:1455} Ironforge · {zone:1457} Darnassus · {area:1658} Cenarion Enclave · {area:702} Rut'theran Village
	["{zone:1455} has no druid trainer: take the portal up to {zone:1457} and train in the {area:1658}, then come back down to {area:702}."] = "{zone:1455}에는 드루이드 상급자가 없습니다. 차원문을 타고 {zone:1457}(으)로 올라가 {area:1658}에서 수련한 뒤 {area:702}(으)로 내려오세요.",
}
