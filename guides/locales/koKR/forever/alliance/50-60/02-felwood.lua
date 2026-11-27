-- Korean (koKR): the guide forever/alliance/50-60/02-felwood (forever/alliance/50-60/02-felwood.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1448} Felwood · {area:2255} Everlook · {zone:1457} Darnassus · {zone:1444} Feralas
	["{zone:1448} and a stop in {area:2255}, then {zone:1457} and {zone:1444}."] = "{zone:1448}, {area:2255}에 잠시 들른 뒤 {zone:1457}, {zone:1444}.",

	-- Step 1: Felwood
	-- {area:3137} Talrendis Point · {area:2358} Forest Song · {zone:1448} Felwood · {area:2479} Emerald Sanctuary · {zone:1440} Ashenvale
	["From {area:3137} ride west along the road past {area:2358}, then north-west into {zone:1448}: the {area:2479} is the druids' camp on the road just past the {zone:1440} border."] = "",
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 2: The Emerald Sanctuary
	-- {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["The {area:2479} is the druids' camp by the road in southern {zone:1448}."] = "",
	-- {npc:9528} Arathandris Silversky · {npc:11554} Grazle
	["{npc:9528}, in the ruins just east of {npc:11554}"] = "{npc:9528}, {npc:11554} 바로 동쪽 폐허",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "{npc:9116}, 내부",
	-- {npc:10920} Kelek Skykeeper · {quest:86577} A Sampling of Putrescence · {zone:1448} Felwood
	["{npc:10920}: {quest:86577}, from the bears and wolves you meet in {zone:1448}"] = "{npc:10920}: {zone:1448}에서 만나는 곰과 늑대로 {quest:86577}",

	-- Step 3: Grazle
	-- {npc:11554} Grazle · {area:2479} Emerald Sanctuary
	["{npc:11554} the furbolg stands by the road just south of the {area:2479}."] = "펄볼그 {npc:11554}은(는) {area:2479} 바로 남쪽 길가에 서 있습니다.",

	-- Step 4: Deadwood Village
	-- {npc:11554} Grazle · {npc:15395} Nafien
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	-- was: ["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop."] = "마른가지일족 펄볼그는 {npc:11554} 바로 남서쪽 마을에 삽니다. 그들이 떨어뜨리는 {item:21377}은(는) 보관하세요."
	["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop: {npc:11554} and {npc:15395} each take five."] = "",

	-- Step 5: Grazle
	-- {npc:15395} Nafien · {zone:1448} Felwood
	["{npc:15395} waits at the north end of {zone:1448}"] = "{npc:15395}은(는) {zone:1448} 북쪽 끝에서 기다립니다",

	-- Step 6: Jadefire Glen
	-- {npc:9454} Xavathras · {spell:7992} Slowing Poison
	-- plural, as words: Jadefire Shadowstalkers = {npc:7110} Jadefire Shadowstalker · Cursed Oozes = {npc:7086} Cursed Ooze
	["The Jadefire satyrs hold the glen west of the road, with {npc:9454} at its back.\nCareful: Jadefire Shadowstalkers (level 51-52) use Sneak and {spell:7992} and are stealthed, so they often join fights uninvited.\nCursed Oozes slide about the glen's streams: kill them and use Laris's Empty Ooze Jar on their remains."] = "",

	-- Step 7: Ruins of Constellas
	-- {npc:9454} Xavathras · {area:2481} Ruins of Constellas
	["Careful: {npc:9454} (54) stands at the back of the {area:2481}, at about 32.2,67.1, with Shadowstalkers around him: clear them one at a time, then pull him alone at full health."] = "주의: {npc:9454}(54)은(는) {area:2481} 안쪽 약 32.2,67.1에 있고 주위에 어둠추적자가 있습니다. 하나씩 처리한 뒤 생명력이 가득 찬 상태에서 그만 끌어오세요.",

	-- Step 8: Jaedenar
	-- {area:1763} Jaedenar · {npc:11141} Spirit of Trey Lightforge · {item:11948} Empty Tainted Ooze Jar
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["{area:1763} is the ruined temple north of the glen.\nCareful: the {npc:11141} (53, elite) haunts the west end of {area:1763}, around 35,60: work the south-east, where the arrow points, and pull the cultists and hounds away from him.\nTainted Oozes slide about {area:1763}'s fel pools: kill them and use the {item:11948} on their remains."] = "",
	-- {item:11949} Filled Tainted Ooze Jar · {area:1763} Jaedenar
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["{item:11949}: Tainted Oozes slide about {area:1763}'s fel pools"] = "",

	-- Step 9: Putrescent organs: kill these as you meet them
	["Putrescent organs: kill these as you meet them"] = "부패한 장기: 만나는 대로 처치",
	-- {zone:1448} Felwood · {npc:10920} Kelek Skykeeper · {area:1763} Jaedenar
	["{zone:1448}'s Angerclaw bears and Felpaw wolves carry the putrescent organs {npc:10920} wants: the Bears and Wolves (47-48) of the south and the Maulers and Scavengers (49-50) along the road north of {area:1763}. Kill them as you ride between the stops."] = "{zone:1448}의 성난발톱 곰과 악령발 늑대가 {npc:10920}이(가) 원하는 부패한 장기를 지니고 있습니다. 남쪽의 곰과 늑대(47-48), 그리고 {area:1763} 북쪽 길가의 난폭곰과 청소부(49-50)입니다. 지점 사이를 이동하며 처치하세요.",

	-- Step 11: Shatter Scar Vale
	-- {npc:7136} Infernal Sentry
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["Follow the road north to the cratered vale and walk to each crater, killing the Entropic Beasts and Horrors between them.\nCareful: an {npc:7136} (53, elite) stands among the craters: walk round it."] = "길을 따라 북쪽의 구덩이 파인 골짜기로 가서 구덩이마다 들르며, 그 사이의 혼돈의 불길과 혼돈의 소산물을 처치하세요.\n주의: 구덩이 사이에 {npc:7136}(53, 정예)이(가) 서 있습니다. 돌아서 가세요.",
	["First crater"] = "첫 번째 구덩이",
	["Second crater"] = "두 번째 구덩이",
	["Third crater"] = "세 번째 구덩이",

	-- Step 12: Irontree Woods
	-- {area:1767} Irontree Woods · {area:2618} Jadefire Run · {item:11503} Blood Amber
	["The Warpwood treants of {area:1767}, east of {area:2618}, carry the {item:11503}."] = "{area:2618} 동쪽 {area:1767}의 굽이나무정령이 {item:11503}을(를) 가지고 있습니다.",
	["Below ground"] = "지하",

	-- Step 13: Jadefire Run: kill these as you meet them
	-- {area:2618} Jadefire Run
	["{area:2618}: kill these as you meet them"] = "{area:2618}: 만나는 대로 처치하세요",
	-- {area:2618} Jadefire Run · {npc:10648} Xavaric · {quest:939} Flute of Xavaric · {item:11674} Jadefire Felbind
	["{area:2618} is the satyr valley in the north-west, with {npc:10648} at its far end. He drops the {quest:939}; every Jadefire satyr can drop {item:11674}.\nCareful: {npc:10648} (55) stands at the valley's far end with Hellcallers (53-54) around him: clear them one at a time before you pull him."] = "{area:2618}은(는) 북서쪽의 사티로스 골짜기이며, 맨 끝에 {npc:10648}이(가) 있습니다. 그가 {quest:939}을(를) 떨어뜨리고, 비취불꽃의 사티로스는 누구나 {item:11674}을(를) 떨어뜨릴 수 있습니다.\n주의: {npc:10648}(55)은(는) 골짜기 맨 끝에 있고 주위에 지옥소환사(53-54)가 있습니다. 그를 끌어오기 전에 하나씩 처리하세요.",

	-- Step 14: Jaedenar again
	-- {area:1763} Jaedenar
	["{area:1763} again"] = "다시 {area:1763}",
	-- {item:12922} Empty Canteen · {area:1763} Jaedenar
	["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}."] = "",

	-- Step 15: The Emerald Sanctuary
	-- {area:1763} Jaedenar · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Ride south-east from {area:1763} to the {area:2479}, the druids' camp by the road in southern {zone:1448}."] = "",

	-- Step 16: The Emerald Sanctuary
	-- {zone:1457} Darnassus
	["The vial is filled in {zone:1457}, later in this guide: keep it; inside"] = "",
	-- {area:392} Ratchet
	["Ends in {area:392}, on the next guide: keep it"] = "",

	-- Step 17: Nafien
	-- {area:1769} Timbermaw Hold · {npc:15395} Nafien
	["Ride north up the road from the Sanctuary, all the way to the cave mouth of {area:1769}; {npc:15395} guards it."] = "성소에서 길을 따라 북쪽으로 {area:1769}의 동굴 입구까지 쭉 가세요. {npc:15395}이(가) 입구를 지킵니다.",

	-- Step 18: Felpaw Village
	-- {area:1762} Felpaw Village
	["The Deadwood furbolgs of {area:1762} fill the hills west of the cave.\nCareful: Den Watchers are level 53-54 and the Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "",

	-- Step 19: Deadwood Ritual Totem
	-- {quest:8470} Deadwood Ritual Totem · {npc:11558} Kernda · {area:1769} Timbermaw Hold
	["Only if the Timbermaw are already Neutral to you: the Deadwood furbolgs drop a {quest:8470} about one kill in thirty, and {npc:11558} just inside {area:1769} takes it. Below Neutral the quest is refused: it needs Neutral with the Timbermaw; the reputation guide gets you there."] = "",

	-- Step 20: Nafien
	-- {npc:11556} Salfa · {zone:1452} Winterspring
	-- was: ["Salfa stands at the {zone:1452} end of the tunnel: keep it"] = "살파는 터널의 {zone:1452} 쪽 끝에 서 있습니다: 보관하세요"
	["{npc:11556} stands at the {zone:1452} end of the tunnel"] = "",

	-- Step 22: Timbermaw Hold
	-- {npc:11558} Kernda
	["Step into the cave: {npc:11558} stands just inside. She needs Neutral with the Timbermaw; the reputation guide gets you there."] = "",
	-- {npc:11558} Kernda
	["{npc:11558}: walks around here: look inside the circle on the map"] = "{npc:11558}: 여기 돌아다닙니다: 지도에서 원 안을 보세요",

	-- Step 23: Into Winterspring
	-- {zone:1452} Winterspring
	["Into {zone:1452}"] = "{zone:1452}(으)로",
	-- {area:1769} Timbermaw Hold · {zone:1452} Winterspring
	["Walk through {area:1769}'s tunnel to its {zone:1452} end."] = "",

	-- Step 24: Salfa
	-- {npc:11556} Salfa · {zone:1452} Winterspring · {area:1769} Timbermaw Hold
	["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "{npc:11556}은(는) {area:1769} 터널의 {zone:1452} 쪽 출구, 나오는 바로 그 자리에 서 있습니다.",

	-- Step 25: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Ride south to {npc:9298}'s camp beside the hot springs."] = "",
	-- {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["Keep it: {npc:7775} in {zone:1444}, later in this guide, brews the elixir"] = "",

	-- Step 26: Everlook
	-- {area:2255} Everlook
	["Ride east along the road to {area:2255}."] = "길을 따라 동쪽 {area:2255}(으)로 가세요.",
	-- {zone:1452} Winterspring
	["The Chillwind horns come on the next guide's {zone:1452} loop: keep it"] = "",

	-- Step 27: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "{area:702}(으)로 날아가기",
	-- {npc:11138} Maethrya
	["{npc:11138}, the Alliance flight master"] = "",

	-- Step 28: Rut'theran Village
	-- {npc:7916} Erelas Ambersky · {quest:3661} Favored of Elune? · {zone:1425} Hinterlands
	["{npc:7916}: {quest:3661}, the feathers from the {zone:1425}"] = "",

	-- Step 29: Rut'theran Village
	-- {npc:7916} Erelas Ambersky · {zone:1452} Winterspring
	["{npc:7916}: the wildkin feathers lie along {zone:1452}'s road, on the next guide; {npc:7916} takes them on the Plaguelands guide's way through: keep it"] = "",

	-- Step 30: Daryn Lightwind
	-- {npc:7907} Daryn Lightwind · {npc:7916} Erelas Ambersky
	["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "{npc:7907}은(는) {npc:7916} 위층에 서 있습니다. 건물 안에서 올라가십시오. 화살표는 층을 구분하지 못합니다.",

	-- Step 33: The Temple Gardens
	-- {item:11682} Eridan's Vial
	["Fill {item:11682} at the moonwell inside the Temple of the Moon."] = "",

	-- Step 34: Astarii Starseeker
	-- {npc:4090} Astarii Starseeker · {quest:3378} Prayer to Elune · {zone:1427} Searing Gorge
	["{npc:4090}, in the Temple of the Moon: {quest:3378}, from the {zone:1427}"] = "",

	-- Step 35: Gracina Spiritmight
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740} stands beside Tyrande in the Temple of the Moon."] = "",
	-- {npc:7740} Gracina Spiritmight · {quest:162} Rise of the Silithid · {area:976} Gadgetzan
	["{npc:7740}: {quest:162}, from {area:976}"] = "{npc:7740}: {area:976}에서 받은 {quest:162}",
	-- {npc:5594} Alchemist Pestlezugg · {area:976} Gadgetzan · {zone:1446} Tanaris · {zone:1452} Winterspring
	["For {npc:5594} in {area:976}, on the {zone:1446} and {zone:1452} guide: keep it"] = "",

	-- Step 36: Jenal
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["{npc:9047} waits in the {area:1658}, west of the druids' building."] = "",
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave · {quest:3764} Un'Goro Soil
	["{npc:9047}, in the {area:1658}: {quest:3764}"] = "",

	-- Step 38: Arch Druid Fandral Staghelm
	-- {npc:4217} Mathrengyl Bearwalker
	["Fandral stands at the top of the druids' building; {npc:4217}, next, is lower down inside it."] = "",
	-- {npc:3516} Arch Druid Fandral Staghelm
	["{npc:3516}, upstairs"] = "",

	-- Step 40: Mathrengyl Bearwalker
	-- {npc:4217} Mathrengyl Bearwalker
	["{npc:4217}, upstairs"] = "{npc:4217}, 위층",
	-- {npc:4217} Mathrengyl Bearwalker · {item:11040} Morrowgrain
	["{npc:4217}'s next task grows ten {item:11040} from a pouch over several hours: skip it."] = "",
	-- {zone:1455} Ironforge
	["{zone:1455} has no druid trainer"] = "{zone:1455}에는 드루이드 상급자가 없습니다",

	-- Step 41: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "{zone:1438}행 차원문",

	-- Step 42: Rut'theran Village flight master
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "{area:702} 비행 조련사",

	-- Step 43: Feathermoon Stronghold
	-- {area:702} Rut'theran Village · {area:1116} Feathermoon Stronghold
	["From {area:702}, fly to {area:1116}."] = "{area:702}에서 {area:1116}(으)로 날아가세요.",

	-- Step 45: Boat to The Forgotten Coast
	-- {area:1108} The Forgotten Coast
	["Boat to {area:1108}"] = "배를 타고 {area:1108}(으)로",

	-- Step 46: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle
	["Take the boat to the mainland: {npc:14637} waits on the dock where it lands."] = "",

	-- Step 47: The Forgotten Coast: kill these as you meet them
	-- {area:1108} The Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "{area:1108}: 만나는 대로 처치하세요",
	-- {item:18904} Zorbin's Ultra-Shrinker · {npc:14637} Zorbin Fandazzle
	-- plural, as words: Sea Sprays = {npc:5462} Sea Spray · Water Elemental Cores = {item:18958} Water Elemental Core · Sea Elementals = {npc:5461} Sea Elemental · Deep Striders = {npc:5360} Deep Strider
	["The Sea Sprays (46-47) wash along the shore just south of the dock: they drop the Water Elemental Cores as well as the Sea Elementals (47) do. The Wave and Deep Striders (47) wade in the water off the same beach: zap them with {item:18904} first, and shrunken they lose their elite strength.\nThe Ultra-Shrinker lasts two hours: hand both quests back to {npc:14637} before you leave the coast."] = "",
	-- {item:18958} Water Elemental Core
	-- plural, as words: Sea Sprays = {npc:5462} Sea Spray
	["{item:18958}, from the Sea Sprays"] = "{item:18958}, 바다 물보라 정령에게서",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Deep Striders = {npc:5360} Deep Strider
	["{item:18904}, on the Wave and Deep Striders in the water"] = "{item:18904}, 물속의 파도 거인과 성큼걸이 바다거인에게 사용",

	-- Step 48: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle
	["Back to {npc:14637} on the dock."] = "부두의 {npc:14637}에게 돌아가세요.",

	-- Step 49: Gregan Brewspewer
	-- {area:1119} Twin Colossals · {npc:7775} Gregan Brewspewer · {item:11243} Videre Elixir · {item:11242} Evoroot
	["Ride north-east from the dock past the {area:1119} to {npc:7775}'s camp. He brews the {item:11243} from an {item:11242}: take his errand for one."] = "",

	-- Step 50: Rockbiter
	-- {npc:7765} Rockbiter · {npc:7775} Gregan Brewspewer
	["The giant {npc:7765} sits just north-west of {npc:7775}'s camp."] = "",

	-- Step 51: Evoroot
	-- {item:11242} Evoroot · {npc:7765} Rockbiter · {npc:9467} Miblon Snarltooth
	["The {item:11242} grows inside a ruined building north of {npc:7765}: climb in through the break in its wall from the ledge beside it.\nOr the front door: {npc:9467} guards it, and the Bait Gregan sells draws him off when you use it beside him. Half the players in our recordings went in that way, half through the wall."] = "",

	-- Step 52: Shay Leafrunner
	-- {npc:7774} Shay Leafrunner · {item:9189} Shay's Bell
	["Ride west into the Ravenwind Ruins: {npc:7774} hides in the small round building at the back. Open the chest beside her for {item:9189}: it lasts 15 minutes, like the quest."] = "서쪽 레이븐윈드 폐허로 가세요. {npc:7774}은(는) 안쪽의 작고 둥근 건물에 숨어 있습니다. 그녀 옆의 상자를 열어 {item:9189}을(를) 얻으세요. 퀘스트처럼 15분간 지속됩니다.",

	-- Step 53: Wandering Shay
	-- {npc:7774} Shay Leafrunner · {npc:7765} Rockbiter
	["Lead {npc:7774} back to {npc:7765} at walking pace: she wanders off, so ring the bell to call her back (not in combat), and clear the harpies on the way before she reaches them."] = "",

	-- Step 54: Gregan Brewspewer
	-- {npc:7775} Gregan Brewspewer · {npc:7765} Rockbiter · {item:11242} Evoroot · {npc:9298} Donova Snowden · {area:976} Gadgetzan
	-- plural, as words: Videre Elixirs = {item:11243} Videre Elixir
	["Back to {npc:7775}'s camp, just south-east of {npc:7765}: the {item:11242} buys three Videre Elixirs. Keep them: {npc:9298} takes one at the start of the next guide, and Gaeriyan in {area:976} shows himself only to someone who has drunk one."] = "",

	-- Step 55: Feralas
	-- {area:489} Thalanaar · {zone:1441} Thousand Needles
	["Ride east along the road to {area:489}, on the {zone:1441} border: the next guide flies from there."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ends in the {zone:1413}: keep it"] = "{zone:1413}에서 끝납니다: 보관하세요",
	-- ["Five feathers buy a little Timbermaw reputation"] = "깃털 5개로 나무구렁 요새 평판을 조금 얻습니다",
	-- ["Fly from {area:1998} to the Sanctuary's end of the road, or ride south along it."] = "{area:1998}에서 길의 성소 쪽 끝으로 날아가거나, 길을 따라 남쪽으로 가세요.",
	-- ["Fly to {area:415}"] = "{area:415}(으)로 날아가기",
	-- ["Follow the road north to the cratered vale and walk to each crater, killing the Entropic Beasts and Horrors between them."] = "길을 따라 북쪽의 구덩이 파인 골짜기로 가서 구덩이마다 들르며, 그 사이의 {npc:9878}와(과) 혼돈의 소산물을 처치하세요.",
	-- ["Keep her alive until she is out of the cave"] = "동굴을 나갈 때까지 그녀를 살려 두세요",
	-- ["Oozes"] = "수액괴물",
	-- ["Ride east to the night elf camp at {area:1998}."] = "동쪽으로 {area:1998}의 나이트 엘프 야영지로 가세요.",
	-- ["Ride north to {area:1769} (or fly back to {area:1998} first) and through the tunnel into {zone:1452}; follow the road east to the goblin town of {area:2255}."] = "북쪽으로 {area:1769}까지 가서(또는 먼저 {area:1998}(으)로 날아가서) 터널을 지나 {zone:1452}에 들어가세요. 길을 따라 동쪽으로 고블린 마을 {area:2255}까지 가세요.",
	-- ["Salfa stands at the {zone:1452} end of the tunnel: keep it"] = "살파는 터널의 {zone:1452} 쪽 끝에 서 있습니다: 보관하세요",
	-- ["Step into the cave: {npc:11558} stands just inside."] = "동굴에 들어가세요. {npc:11558}이(가) 바로 안쪽에 서 있습니다.",
	-- ["Still short of level 52.9 after the {area:2479}'s hand-ins? Top up on the Entropic Beasts in {area:1766}, the next stop north."] = "{area:2479}의 퀘스트를 제출한 뒤에도 52.9레벨이 안 됩니까? 다음 목적지인 북쪽 {area:1766}의 혼돈의 야수를 잡아 경험치를 채우십시오.",
	-- ["Take the boat from {area:702} to {area:442} and fly to {area:415}."] = "{area:702}에서 배를 타고 {area:442}(으)로 간 뒤 {area:415}(으)로 날아가세요.",
	-- ["The Cursed and Tainted Oozes slide about the streams and fel pools around {area:1763} and {area:1765}: kill them and use Laris's Empty Ooze Jars on their remains."] = "저주받은 수액괴물과 {npc:7092}이(가) {area:1763}와(과) {area:1765} 주변의 개울과 지옥 웅덩이를 미끄러져 다닙니다. 처치한 뒤 라리스의 빈 수액괴물 단지를 그 잔해에 사용하세요.",
	-- ["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop."] = "마른가지일족 펄볼그는 {npc:11554} 바로 남서쪽 마을에 삽니다. 그들이 떨어뜨리는 {item:21377}은(는) 보관하세요.",
	-- ["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. Keep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 58.\nCareful: Den Watchers are level 53-54 and the Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "{area:1762}의 마른가지일족 퍼볼그가 동굴 서쪽 언덕을 채우고 있습니다. {quest:8470}이(가) 나올 때까지(약 30마리당 1개) 계속 처치한 뒤 우클릭하세요. {area:1769}의 {npc:11558}은(는) 나무구렁일족이 중립이 되면 받아줍니다. 이미 중립이면 지금, 아니면 마지막 가이드가 58레벨에 동굴을 다시 지날 때 제출하세요.\n주의: 굴 감시자는 53-54레벨, 복수자는 54-55레벨입니다. 생명력이 50% 아래가 되면 25미터 내의 동료를 부르고, 15% 아래에서는 도망쳐 도움을 청합니다.",
	-- ["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. The Avengers can drop a {quest:8470}."] = "{area:1762}의 마른가지일족 펄볼그가 동굴 서쪽 언덕을 채우고 있습니다. 마른가지일족 복수자가 {quest:8470}을(를) 떨어뜨릴 수 있습니다.",
	-- ["The Jadefire satyrs hold the glen west of the road, with {npc:9454} at its back."] = "비취불꽃의 사티로스가 길 서쪽 숲을 차지하고 있으며, {npc:9454}은(는) 그 안쪽에 있습니다.",
	-- ["The vial is filled in {zone:1457}: keep it; inside"] = "유리병은 {zone:1457}에서 채웁니다: 보관하세요. 안",
	-- ["The {item:11242} grows inside a ruined building north of {npc:7765}: climb in through the break in its wall from the ledge beside it."] = "{item:11242}은(는) {npc:7765} 북쪽의 무너진 건물 안에서 자랍니다. 옆의 바위턱에서 벽의 갈라진 틈으로 들어가세요.",
	-- ["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}. If you freed {npc:11018}, go back into {area:1770} for the succubus {npc:9518}; Trey Lightforge's remains lie beside her."] = "{area:1763} 한가운데의 타락한 달샘에서 {item:12922}을(를) 사용하세요. {npc:11018}을(를) 풀어 주었다면 {area:1770}에 다시 들어가 서큐버스 {npc:9518}을(를) 처치하세요. 트레이 라이트포지의 유해가 그녀 옆에 있습니다.",
	-- ["grind on {npc:7109}"] = "{npc:7109} 사냥",
	-- ["grind on {npc:7153}"] = "{npc:7153} 사냥",
	-- ["grind on {npc:7155}"] = "{npc:7155} 사냥",
	-- ["grind on {npc:9878}"] = "{npc:9878} 사냥",
	-- ["{area:1763} is the ruined temple north of the glen. Some of its cultists drop a {item:13140}, about one kill in thirty: it opens {npc:11018}'s cell in {area:1770}, the cave at the back. If it drops, clear the way out before you free her; if not, skip her quests."] = "{area:1763}은(는) 숲 북쪽의 폐허가 된 사원입니다. 일부 이교도가 약 30마리에 한 번꼴로 {item:13140}을(를) 떨어뜨립니다. 이 열쇠로 안쪽 동굴인 {area:1770}의 {npc:11018} 감옥을 엽니다. 열쇠가 나오면 그녀를 풀어 주기 전에 나가는 길을 정리하고, 안 나오면 그녀의 퀘스트는 건너뛰세요.",
	-- ["{area:2618} is the satyr valley in the north-west, with {npc:10648} at its far end. He drops the {quest:939}; every Jadefire satyr can drop {item:11674}."] = "{area:2618}은(는) 북서쪽의 사티로스 골짜기이며, 맨 끝에 {npc:10648}이(가) 있습니다. 그가 {quest:939}을(를) 떨어뜨리고, 비취불꽃의 사티로스는 누구나 {item:11674}을(를) 떨어뜨릴 수 있습니다.",
	-- ["{item:13140}, a rare drop"] = "{item:13140}, 드물게 획득",
	-- ["{npc:10924}: for {npc:11079} in {zone:1452}, keep it"] = "{npc:10924}: {zone:1452}의 {npc:11079}에게, 보관하십시오",
	-- ["{npc:11016}, in {area:1770}"] = "{npc:11016}, {area:1770} 안",
	-- ["{npc:11557}: thirty {quest:6031}, handed in when you pass through again at 57"] = "{npc:11557}: {quest:6031} 30장, 57레벨에 다시 지나갈 때 제출",
	-- ["{npc:11558}: the Timbermaw speak to you only from Neutral; walks around here: look inside the circle on the map"] = "{npc:11558}: 나무구렁 요새는 중립부터 대화해 줍니다. 이 주변을 돌아다닙니다. 지도의 원 안을 살펴보세요",
	-- ["{npc:15395} waits at the north end of {area:361}"] = "{npc:15395}은(는) {area:361} 북쪽 끝에서 기다립니다",
	-- ["{quest:8470}, a rare drop"] = "{quest:8470}, 드물게 획득",
}
