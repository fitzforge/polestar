-- Korean (koKR): the guide forever/alliance/50-60/01-burning-steppes (forever/alliance/50-60/01-burning-steppes.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Shadowsong Shrine
	-- {zone:1447} Azshara · {area:3137} Talrendis Point
	["The shrine lies in the south-west corner of {zone:1447}, south of {area:3137}."] = "섀도송 제단은 {area:3137} 남쪽, {zone:1447} 남서쪽 구석에 있습니다.",

	-- Step 2: Azshara: kill these as you meet them
	-- {zone:1447} Azshara
	["{zone:1447}: kill these as you meet them"] = "",
	["The Highborne ghosts haunt the ruins around the shrine; the Haldarr satyrs hold the camp just north of it."] = "명가 유령들이 제단 주변 폐허를 떠돌고, 할다르 사티로스가 그 바로 북쪽 야영지를 차지하고 있습니다.",

	-- Step 5: Ogtinc
	-- {npc:8405} Ogtinc · {area:1224} Bear's Head
	["Ride north-east from the shrine: {npc:8405} camps at the {area:1224}, in the hills above the road."] = "제단에서 북동쪽으로 가세요. {npc:8405}은(는) 길 위 언덕의 {area:1224}에 진을 치고 있습니다.",

	-- Step 6: Mosshoof Coursers
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers"] = "{npc:8761}",
	-- {area:1224} Bear's Head · {area:1219} Legashi Encampment
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south."] = "가장 가까운 {npc:8761}은(는) {area:1224} 북동쪽, {area:1219} 쪽 언덕에서 풀을 뜯고, 더 큰 무리는 남쪽 평지를 돌아다닙니다.",

	-- Step 9: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo
	-- plural, as words: Undamaged Hippogryph Feathers = {item:10450} Undamaged Hippogryph Feather
	["Optional: {npc:8395} wants two Undamaged Hippogryph Feathers from the hippogryphs around his camp. The data lists no experience for it."] = "선택: {npc:8395}이(가) 야영지 주변 히포그리프에게서 얻는 {item:10450} 2개를 원합니다. 데이터에는 경험치가 나와 있지 않습니다.",
	-- {npc:6375} Thunderhead Hippogryph
	["grind on {npc:6375}"] = "",

	-- Step 10: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo · {npc:8379} Archmage Xylem
	["Get off your mount before you talk to {npc:8395}: he teleports you up to {npc:8379}'s tower on the cliff above his camp."] = "",

	-- Step 11: Archmage Xylem
	["The apprentice at the top of the tower sends you back down."] = "",
	-- {area:1220} Thalassian Base Camp · {npc:8420} Kim'jael
	["The blood elves are at the {area:1220}, on the way to {npc:8420}"] = "",

	-- Step 12: Kim'jael
	-- {npc:8420} Kim'jael · {area:1219} Legashi Encampment · {area:1220} Thalassian Base Camp
	["{npc:8420} camps at the {area:1219} in the north; his equipment lies all over the {area:1220} just south-east of him."] = "{npc:8420}은(는) 북쪽 {area:1219}에 진을 치고 있으며, 그의 장비는 바로 남동쪽 {area:1220} 곳곳에 흩어져 있습니다.",
	-- {item:20028} Glittering Dust
	["{item:20028}, from the blood elf surveyors and reclaimers"] = "",
	-- {npc:6196} Spitelash Myrmidon
	["grind on {npc:6196}"] = "",

	-- Step 13: The Ruins of Eldarath
	-- {area:1221} Ruins of Eldarath
	["The {area:1221}"] = "{area:1221}",
	-- {area:1221} Ruins of Eldarath · {item:13815} Some Rune · {npc:8507} Tymor · {item:10445} Drawing Kit
	["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s four runes stand among the ruins: use his {item:10445} on each."] = "{area:1221}의 원한의꼬리일족 나가가 {item:13815}을(를) 가지고 있습니다. {npc:8507}의 룬 네 개는 폐허 사이에 서 있습니다. 각각에 그의 {item:10445}을(를) 사용하세요.",

	-- Step 17: Rubbing: Rune of Sael'hai
	-- {item:7972} Ichor of Undeath · {npc:7864} Lingering Highborne
	["{item:7972}: the {npc:7864}, about 10%"] = "{item:7972}: {npc:7864}, 약 10%",

	-- Step 18: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo
	["Ride back west to {npc:8395}'s camp and get off your mount: he teleports you up to Xylem again."] = "",

	-- Step 20: The Temple of Zin-Malor
	-- {area:1223} Temple of Zin-Malor
	["The {area:1223}"] = "",
	-- {area:1223} Temple of Zin-Malor · {npc:8395} Sanath Lim-yo
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren
	["The Spitelash Sirens wander the ruins and the beach around the {area:1223}, just south of {npc:8395}. Only the Sirens carry the coral, not the Screamers."] = "",

	-- Step 21: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo
	["Back up through {npc:8395}'s teleport."] = "",
	-- {area:1417} Sunken Temple
	["Xylem's last task, Destroy Morphaz, is in the {area:1417}: skip it."] = "",

	-- Step 23: Ravencrest Monument
	-- {zone:1447} Azshara · {npc:8392} Pilot Xiggs Fuselighter
	["Swim to the small island off the southern tip of {zone:1447}: {npc:8392} waits by the monument."] = "{zone:1447} 남쪽 끝 앞바다의 작은 섬까지 헤엄쳐 가세요. {npc:8392}이(가) 기념비 옆에서 기다립니다.",

	-- Step 24: To Stoutlager Inn
	-- {area:2101} Stoutlager Inn
	["To {area:2101}"] = "",

	-- Step 25: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "",

	-- Step 27: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}."] = "아케소누스는 {object:171709}에서 국왕 마그니 브론즈비어드 옆에 서 있습니다.",
	-- {zone:1428} Burning Steppes
	["The relics are in the {zone:1428}: keep it"] = "유물은 {zone:1428}에 있습니다: 보관하세요",

	-- Step 28: Fly to Aerie Peak
	-- {area:348} Aerie Peak
	["Fly to {area:348}"] = "",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "",

	-- Step 29: Wildkin feathers
	["Wildkin feathers"] = "올빼미야수 깃털",
	-- {zone:1425} Hinterlands · {area:348} Aerie Peak
	-- plural, as words: Wildkin Feathers = {item:10819} Wildkin Feather
	["The Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "",

	-- Step 30: The Super Snapper FX
	-- {npc:7977} Gammerita
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:7977} (level 48 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 32: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "{area:271}(으)로 날아가세요",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "",

	-- Step 33: Western Plaguelands
	-- {area:271} Southshore · {area:3197} Chillwind Camp
	["Ride north from {area:271} up the road through Alterac to {area:3197}."] = "",

	-- Step 34: Chillwind Camp
	-- {npc:10838} Commander Ashlam Valorfist
	["{npc:10838} stands in the middle of the camp."] = "",

	-- Step 35: Sorrow Hill: kill these as you meet them
	-- {area:197} Sorrow Hill
	["{area:197}: kill these as you meet them"] = "",
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "",

	-- Step 36: Chillwind Camp
	["Ride back south to the camp."] = "남쪽 야영지로 돌아가세요.",

	-- Step 37: Janice Felstone
	-- {npc:10778} Janice Felstone · {area:199} Felstone Field · {area:200} Dalson's Tears
	["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "{npc:10778}의 유령은 {area:200} 서쪽, {area:199}의 농가 근처를 떠돕니다. 소포는 농가 안에 있습니다.",
	["Upstairs"] = "",
	-- {object:175894} Janice's Parcel
	["{object:175894}, inside"] = "",
	-- {zone:1453} Stormwind
	["For {zone:1453}: keep it"] = "{zone:1453}용: 보관하세요",

	-- Step 38: Felstone Field cauldron
	-- {area:199} Felstone Field
	["{area:199} cauldron"] = "{area:199} 가마솥",
	-- {npc:11075} Cauldron Lord Bilemaw · {area:199} Felstone Field
	["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075}이(가) 안돌할 서쪽 {area:199}의 가마솥을 지킵니다.",

	-- Step 40: Fly to Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["Fly to {area:2418}"] = "",
	-- {area:3197} Chillwind Camp
	["{area:3197} flight master"] = "",

	-- Step 41: Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["{area:2418} sits in the south-east of the Steppes, at the top of the pass up from Redridge."] = "",

	-- Step 42: Dreadmaul Rock
	["The Firegut ogres hold the great rock north of the Vigil, with the Brutes on its east side."] = "불자루 오우거가 감시초소 북쪽의 큰 바위를 차지하고 있고, 불자루일족 투사는 그 동쪽에 있습니다.",
	-- {npc:7034} Firegut Ogre Mage
	["{npc:7034}, below ground"] = "",
	-- {npc:7033} Firegut Ogre · {npc:9177} Oralius · {quest:4283} FIFTY! YEP!
	["grind on {npc:7033}: {npc:9177} gives {quest:4283} from level 51"] = "",

	-- Step 43: Morgan's Vigil
	-- {npc:9177} Oralius
	["{npc:9177}: the Blackrock orcs drop the medallions, keep it open all through the Steppes"] = "{npc:9177}: 검은바위부족 오크가 메달을 떨어뜨립니다. 불타는 평원 내내 열어 두세요",

	-- Step 44: Level 52
	["Level 52"] = "",
	-- {area:249} Dreadmaul Rock · {area:251} Flame Crest · {area:1417} Sunken Temple · {area:2100} Maraudon
	["Top up here to level 52 on the ogres of {area:249}, on the way to {area:251}: the hand-ins there take you to level 53. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "",
	-- {npc:7034} Firegut Ogre Mage
	["grind on {npc:7034}"] = "",

	-- Step 45: Flame Crest
	-- {area:251} Flame Crest
	["Follow the road west, then climb north to the goblin camp on {area:251}."] = "길을 따라 서쪽으로 간 뒤 북쪽으로 올라가 {area:251}의 고블린 야영지로 가세요.",

	-- Step 46: Ruins of Thaurissan: kill these as you meet them
	-- {area:250} Ruins of Thaurissan
	["{area:250}: kill these as you meet them"] = "",
	-- {area:250} Ruins of Thaurissan · {area:251} Flame Crest · {object:147516} Dark Iron · {item:12284} Draco-Incarcinatrix 900 · {npc:7047} Black Broodling
	["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered.\nRead the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript.\nUse the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves."] = "",

	-- Step 47: Flame Crest
	-- {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Ends with {quest:4808} in {area:2255}, {zone:1452}: keep it"] = "{zone:1452} {area:2255}의 {quest:4808}에게서 끝납니다: 보관하세요",

	-- Step 48: Cyrus Therepentous
	["Below ground"] = "",

	-- Step 49: A Taste of Flame
	-- {npc:9461} Frenzied Black Drake
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:9461} is a level 54 elite: most classes solo it at level 56, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 51: Level 52.08
	["Level 52.08"] = "",
	-- {quest:4022} A Taste of Flame · {area:1417} Sunken Temple · {area:2100} Maraudon
	["If you skipped {quest:4022}, grind here to level 52.08 to stay on the route's plan. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "",
	-- {npc:9690} Ember Worg
	["grind on {npc:9690}"] = "",

	-- Step 52: Blackrock Stronghold
	-- {npc:9176} Gor'tesh · {area:254} Blackrock Mountain · {area:251} Flame Crest
	["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty.\nCareful: {npc:9176} has a guard linked to him that joins the fight, and a second soldier patrols close by; clear the patrol before pulling."] = "",
	-- {item:11467} Blackrock Medallion
	["{item:11467}; inside"] = "",

	-- Step 53: Morgan's Vigil
	["Ride back east along the road to the Vigil."] = "길을 따라 동쪽으로 감시초소에 돌아가세요.",

	-- Step 54: Dreadmaul Rock
	-- {area:249} Dreadmaul Rock
	["Climb to the top of {area:249} and plant the head in the soft dirt mound."] = "{area:249} 꼭대기에 올라가 부드러운 흙더미에 머리를 꽂으세요.",

	-- Step 56: Fly to Nethergarde Keep
	-- {area:1438} Nethergarde Keep
	["Fly to {area:1438}"] = "",
	-- {area:2418} Morgan's Vigil
	["{area:2418} flight master"] = "",

	-- Step 57: Kum'isha the Collector
	-- {area:2517} Rise of the Defiler · {zone:1419} Blasted Lands · {npc:7664} Razelikh the Defiler · {spell:2691} Mana Burn · {spell:8255} Strong Cleave · {object:141891} Razelikh's Tear (no name in this language: may be words) · {spell:10854} Flames of Chaos
	-- plural, as words: Imperfect Draenethyst Fragments = {item:10593} Imperfect Draenethyst Fragment
	["Kum'isha waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have.\nCareful: Felcular, {npc:7664} and Ilifar are all level 60 elites. Razelikh casts {spell:2691}, {spell:8255} and Decimate, and as its health drops it adds {object:141891}, {spell:10854} and then Enrage at 15%."] = "",
	-- {npc:7363} Kum'isha the Collector
	["{npc:7363} walks around here: look inside the circle on the map"] = "",

	-- Step 65: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "",

	-- Step 67: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "",

	-- Step 68: Rut'theran Village
	-- {zone:1452} Winterspring
	["The wildkin are in {zone:1452}: keep it"] = "올빼미야수는 {zone:1452}에 있습니다: 보관하세요",

	-- Step 69: Druid training
	["Druid training"] = "드루이드 수련",
	-- {zone:1455} Ironforge · {zone:1457} Darnassus · {area:1658} Cenarion Enclave · {area:702} Rut'theran Village
	["{zone:1455} has no druid trainer: take the portal up to {zone:1457} and train in the {area:1658}, then come back down to {area:702}."] = "{zone:1455}에는 드루이드 상급자가 없습니다. 차원문을 타고 {zone:1457}(으)로 올라가 {area:1658}에서 수련한 뒤 {area:702}(으)로 내려오세요.",

	-- Step 70: Back to Teldrassil
	-- {zone:1438} Teldrassil
	["Back to {zone:1438}"] = "",

	-- Step 71: Daryn Lightwind
	-- {npc:7907} Daryn Lightwind · {npc:7916} Erelas Ambersky
	["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Climb back to {npc:8405} at the {area:1224}, above the ruins."] = "폐허 위 {area:1224}의 {npc:8405}에게 다시 올라가세요.",
	-- ["Fly from {zone:1455} to {area:150} and take the boat to {area:442}."] = "{zone:1455}에서 {area:150}(으)로 날아가 배를 타고 {area:442}(으)로 가세요.",
	-- ["Fly from {zone:1455} to {area:69}."] = "{zone:1455}에서 {area:69}(으)로 날아가세요.",
	-- ["Fly to {area:1438}."] = "{area:1438}(으)로 날아가세요.",
	-- ["Fly to {area:150} and take the boat to {area:442}, then the boat on to {area:702}."] = "{area:150}(으)로 날아가 배를 타고 {area:442}(으)로 간 뒤, 다시 배를 타고 {area:702}(으)로 가세요.",
	-- ["From the {area:442} dock, fly to {area:415}."] = "{area:442} 부두에서 {area:415}(으)로 날아가세요.",
	-- ["Optional: {npc:8888}'s ghost stands on his tomb on the great chain inside {area:254}, and only the dead can see him. If you die near the mountain anyway, run your spirit to him before resurrecting."] = "선택: {npc:8888}의 유령은 {area:254} 안 거대한 사슬 위 그의 무덤에 서 있으며, 죽은 자만 그를 볼 수 있습니다. 어차피 산 근처에서 죽었다면 부활하기 전에 영혼 상태로 그에게 달려가세요.",
	-- ["Read the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript."] = "{area:251} 남서쪽 폐허 사이의 {object:147516} 야영지에서 석판을 읽고 내용을 베끼세요.",
	-- ["Ride back to {area:1438} and fly to {area:348}. The Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "{area:1438}(으)로 돌아가 {area:348}(으)로 날아가세요. {item:10819}은(는) {area:348} 남쪽과 동쪽, 올빼미야수가 돌아다니는 {zone:1425} 곳곳의 땅바닥에 있습니다. 이곳 몹은 이제 당신보다 한참 낮습니다.",
	-- ["Ride east along the road out of {zone:1440} into {zone:1447} to the Sentinels' camp at {area:3137}."] = "길을 따라 동쪽으로 {zone:1440}을(를) 벗어나 {zone:1447}에 들어가 {area:3137}의 파수꾼 야영지로 가세요.",
	-- ["Ride north out of {area:69} through the pass into the {zone:1428}; {area:2418} sits at the top, in the south-east of the Steppes."] = "{area:69}에서 북쪽으로 고개를 넘어 {zone:1428}에 들어가세요. {area:2418}은(는) 고개 꼭대기, 초원 남동쪽에 있습니다.",
	-- ["Swim to the small island off the southern tip of {area:16}: {npc:8392} waits by the monument."] = "{area:16} 남쪽 끝 앞바다의 작은 섬까지 헤엄쳐 가세요. {npc:8392}이(가) 기념비 옆에서 기다립니다.",
	-- ["Thaurissan Relics"] = "{object:153556}",
	-- ["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered."] = "유물은 {area:251} 주변 {area:250}에 흩어진 조각된 돌입니다. 정보가 복구될 때까지 클릭하세요.",
	-- ["The shrine lies in the south-west corner of {area:16}, south of {area:3137}."] = "섀도송 제단은 {area:3137} 남쪽, {area:16} 남서쪽 구석에 있습니다.",
	-- ["The {quest:4296}"] = "{quest:4296}",
	-- ["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves."] = "{area:251} 동쪽 비탈의 {npc:7047}이(가) 죽기 직전에 {item:12284}을(를) 사용한 뒤, 남긴 정수를 획득하세요.",
	-- ["{npc:5111}: the last guide binds here, so this usually ticks at once"] = "{npc:5111}: 이전 가이드에서 이곳에 귀환 지점을 정하므로 보통 바로 완료됩니다",
	-- ["{npc:7363} waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have."] = "{npc:7363}은(는) 요새 남서쪽 언덕인 {area:2517}에서 기다립니다. 가는 길의 {zone:1419} 몹이 {item:10593}을(를) 떨어뜨립니다. 가진 만큼 가져가세요.",
	-- ["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty."] = "{npc:9176}와(과) 검은바위부족 오크가 {area:251} 서쪽, {area:254} 기슭의 야영지와 요새를 차지하고 있습니다. 하나씩 끌어오세요. 오크와 늑대 모두 메달을 떨어뜨릴 수 있으니 50개가 될 때까지 처치하세요.",
}
