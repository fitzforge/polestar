-- Chinese (traditional) (zhTW): the guide forever/alliance/50-60/02-felwood (forever/alliance/50-60/02-felwood.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1448} Felwood · {area:2255} Everlook · {zone:1457} Darnassus · {zone:1444} Feralas
	["{zone:1448} and a stop in {area:2255}, then {zone:1457} and {zone:1444}."] = "{zone:1448}，途中在{area:2255}停留，然後是{zone:1457}和{zone:1444}。",

	-- Step 1: Felwood
	-- {area:3137} Talrendis Point · {area:2358} Forest Song · {zone:1448} Felwood · {area:2479} Emerald Sanctuary · {zone:1440} Ashenvale
	["From {area:3137} ride west along the road past {area:2358}, then north-west into {zone:1448}: the {area:2479} is the druids' camp on the road just past the {zone:1440} border."] = "",
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 2: The Emerald Sanctuary
	-- {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["The {area:2479} is the druids' camp by the road in southern {zone:1448}."] = "",
	-- {npc:9528} Arathandris Silversky · {npc:11554} Grazle
	["{npc:9528}, in the ruins just east of {npc:11554}"] = "{npc:9528}，在{npc:11554}東邊的廢墟裡",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "{npc:9116}，在裡面",
	-- {npc:10920} Kelek Skykeeper · {quest:86577} A Sampling of Putrescence · {zone:1448} Felwood
	["{npc:10920}: {quest:86577}, from the bears and wolves you meet in {zone:1448}"] = "{npc:10920}：{quest:86577}，來自你在{zone:1448}遇到的熊和狼",

	-- Step 3: Grazle
	-- {npc:11554} Grazle · {area:2479} Emerald Sanctuary
	["{npc:11554} the furbolg stands by the road just south of the {area:2479}."] = "熊怪{npc:11554}站在{area:2479}南邊的路旁。",

	-- Step 4: Deadwood Village
	-- {npc:11554} Grazle · {npc:15395} Nafien
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	-- was: ["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop."] = "死木熊怪住在{npc:11554}西南方的村莊裡；保留牠們掉落的死木頭飾羽毛。"
	["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop: {npc:11554} and {npc:15395} each take five."] = "",

	-- Step 5: Grazle
	-- {npc:15395} Nafien · {zone:1448} Felwood
	["{npc:15395} waits at the north end of {zone:1448}"] = "{npc:15395}在{zone:1448}北端等候",

	-- Step 6: Jadefire Glen
	-- {npc:9454} Xavathras · {spell:7992} Slowing Poison
	-- plural, as words: Jadefire Shadowstalkers = {npc:7110} Jadefire Shadowstalker · Cursed Oozes = {npc:7086} Cursed Ooze
	["The Jadefire satyrs hold the glen west of the road, with {npc:9454} at its back.\nCareful: Jadefire Shadowstalkers (level 51-52) use Sneak and {spell:7992} and are stealthed, so they often join fights uninvited.\nCursed Oozes slide about the glen's streams: kill them and use Laris's Empty Ooze Jar on their remains."] = "碧火薩特佔據道路以西的山谷，{npc:9454}在最深處。\n小心：碧火暗影潛伏者（51-52級）會潛行並使用{spell:7992}，常常不請自來地加入戰鬥。\n詛咒軟泥怪在山谷的溪流裡四處遊蕩：殺死它們，再對殘骸使用拉里斯的空軟泥怪罐。",

	-- Step 7: Ruins of Constellas
	-- {npc:9454} Xavathras · {area:2481} Ruins of Constellas
	["Careful: {npc:9454} (54) stands at the back of the {area:2481}, at about 32.2,67.1, with Shadowstalkers around him: clear them one at a time, then pull him alone at full health."] = "小心：{npc:9454}（54級）站在{area:2481}後方，約32.2,67.1，周圍有暗影潛行者：一次清掉一隻，然後在滿血時單獨拉他。",

	-- Step 8: Jaedenar
	-- {area:1763} Jaedenar · {npc:11141} Spirit of Trey Lightforge · {item:11948} Empty Tainted Ooze Jar
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["{area:1763} is the ruined temple north of the glen.\nCareful: the {npc:11141} (53, elite) haunts the west end of {area:1763}, around 35,60: work the south-east, where the arrow points, and pull the cultists and hounds away from him.\nTainted Oozes slide about {area:1763}'s fel pools: kill them and use the {item:11948} on their remains."] = "",
	-- {item:11949} Filled Tainted Ooze Jar · {area:1763} Jaedenar
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["{item:11949}: Tainted Oozes slide about {area:1763}'s fel pools"] = "{item:11949}：汙染軟泥怪在{area:1763}的邪能水池裡四處遊蕩",

	-- Step 9: Putrescent organs: kill these as you meet them
	["Putrescent organs: kill these as you meet them"] = "腐爛的器官：遇到就擊殺",
	-- {zone:1448} Felwood · {npc:10920} Kelek Skykeeper · {area:1763} Jaedenar
	["{zone:1448}'s Angerclaw bears and Felpaw wolves carry the putrescent organs {npc:10920} wants: the Bears and Wolves (47-48) of the south and the Maulers and Scavengers (49-50) along the road north of {area:1763}. Kill them as you ride between the stops."] = "{zone:1448}的怒爪熊和魔爪狼身上有{npc:10920}要的腐爛器官：南部的熊和狼（47-48級），以及{area:1763}北邊道路沿途的重擊者和食腐者（49-50級）。在各個地點之間移動時順手擊殺。",

	-- Step 11: Shatter Scar Vale
	-- {npc:7136} Infernal Sentry
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["Follow the road north to the cratered vale and walk to each crater, killing the Entropic Beasts and Horrors between them.\nCareful: an {npc:7136} (53, elite) stands among the craters: walk round it."] = "沿著道路向北前往坑窪山谷，走到每個坑洞，並擊殺途中的熱能野獸和熱能恐獸。\n小心：坑洞之間站著一隻{npc:7136}（53級，精英）：繞過它。",
	["First crater"] = "第一個坑洞",
	["Second crater"] = "第二個坑洞",
	["Third crater"] = "第三個坑洞",

	-- Step 12: Irontree Woods
	-- {area:1767} Irontree Woods · {area:2618} Jadefire Run · {item:11503} Blood Amber
	["The Warpwood treants of {area:1767}, east of {area:2618}, carry the {item:11503}."] = "{area:2618}東邊{area:1767}的曲木樹人帶著{item:11503}。",
	["Below ground"] = "地下",

	-- Step 13: Jadefire Run: kill these as you meet them
	-- {area:2618} Jadefire Run
	["{area:2618}: kill these as you meet them"] = "{area:2618}：遇到就殺",
	-- {area:2618} Jadefire Run · {npc:10648} Xavaric · {quest:939} Flute of Xavaric · {item:11674} Jadefire Felbind
	["{area:2618} is the satyr valley in the north-west, with {npc:10648} at its far end. He drops the {quest:939}; every Jadefire satyr can drop {item:11674}.\nCareful: {npc:10648} (55) stands at the valley's far end with Hellcallers (53-54) around him: clear them one at a time before you pull him."] = "{area:2618}是西北方的薩特山谷，{npc:10648}在山谷盡頭。他會掉落{quest:939}；每個碧火薩特都可能掉落{item:11674}。\n小心：{npc:10648}（55級）站在山谷盡頭，周圍有地獄召喚者（53-54級）：先一次一隻清掉它們，再拉他。",

	-- Step 14: Jaedenar again
	-- {area:1763} Jaedenar
	["{area:1763} again"] = "再次前往{area:1763}",
	-- {item:12922} Empty Canteen · {area:1763} Jaedenar
	["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}."] = "在{area:1763}中央被腐化的月井處使用{item:12922}。",

	-- Step 15: The Emerald Sanctuary
	-- {area:1763} Jaedenar · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Ride south-east from {area:1763} to the {area:2479}, the druids' camp by the road in southern {zone:1448}."] = "從{area:1763}向東南騎行到{area:2479}，即{zone:1448}南部路旁的德魯伊營地。",

	-- Step 16: The Emerald Sanctuary
	-- {zone:1457} Darnassus
	["The vial is filled in {zone:1457}, later in this guide: keep it; inside"] = "",
	-- {area:392} Ratchet
	["Ends in {area:392}, on the next guide: keep it"] = "",

	-- Step 17: Nafien
	-- {area:1769} Timbermaw Hold · {npc:15395} Nafien
	["Ride north up the road from the Sanctuary, all the way to the cave mouth of {area:1769}; {npc:15395} guards it."] = "從聖地沿著道路向北騎，一路到{area:1769}的洞口；{npc:15395}守在那裡。",

	-- Step 18: Felpaw Village
	-- {area:1762} Felpaw Village
	["The Deadwood furbolgs of {area:1762} fill the hills west of the cave.\nCareful: Den Watchers are level 53-54 and the Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "",

	-- Step 19: Deadwood Ritual Totem
	-- {quest:8470} Deadwood Ritual Totem · {npc:11558} Kernda · {area:1769} Timbermaw Hold
	["Only if the Timbermaw are already Neutral to you: the Deadwood furbolgs drop a {quest:8470} about one kill in thirty, and {npc:11558} just inside {area:1769} takes it. Below Neutral the quest is refused: it needs Neutral with the Timbermaw; the reputation guide gets you there."] = "",

	-- Step 20: Nafien
	-- {npc:11556} Salfa · {zone:1452} Winterspring
	-- was: ["Salfa stands at the {zone:1452} end of the tunnel: keep it"] = "薩爾法站在隧道的{zone:1452}那一端：保留此任務"
	["{npc:11556} stands at the {zone:1452} end of the tunnel"] = "",

	-- Step 22: Timbermaw Hold
	-- {npc:11558} Kernda
	["Step into the cave: {npc:11558} stands just inside. She needs Neutral with the Timbermaw; the reputation guide gets you there."] = "",
	-- {npc:11558} Kernda
	["{npc:11558}: walks around here: look inside the circle on the map"] = "{npc:11558}：在這一帶走動：看地圖上的圓圈裡",

	-- Step 23: Into Winterspring
	-- {zone:1452} Winterspring
	["Into {zone:1452}"] = "進入{zone:1452}",
	-- {area:1769} Timbermaw Hold · {zone:1452} Winterspring
	["Walk through {area:1769}'s tunnel to its {zone:1452} end."] = "",

	-- Step 24: Salfa
	-- {npc:11556} Salfa · {zone:1452} Winterspring · {area:1769} Timbermaw Hold
	["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "{npc:11556}就站在{area:1769}隧道的{zone:1452}出口，也就是你出來的地方。",

	-- Step 25: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Ride south to {npc:9298}'s camp beside the hot springs."] = "",
	-- {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["Keep it: {npc:7775} in {zone:1444}, later in this guide, brews the elixir"] = "",

	-- Step 26: Everlook
	-- {area:2255} Everlook
	["Ride east along the road to {area:2255}."] = "沿著道路向東騎往{area:2255}。",
	-- {zone:1452} Winterspring
	["The Chillwind horns come on the next guide's {zone:1452} loop: keep it"] = "",

	-- Step 27: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "飛往{area:702}",
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
	["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "{npc:7907}站在樓上，在{npc:7916}上方：從裡面走上去，箭頭無法分辨樓層。",

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
	["{npc:7740}: {quest:162}, from {area:976}"] = "{npc:7740}：{quest:162}，來自{area:976}",
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
	["{npc:4217}, upstairs"] = "{npc:4217}，在樓上",
	-- {npc:4217} Mathrengyl Bearwalker · {item:11040} Morrowgrain
	["{npc:4217}'s next task grows ten {item:11040} from a pouch over several hours: skip it."] = "",
	-- {zone:1455} Ironforge
	["{zone:1455} has no druid trainer"] = "{zone:1455}沒有德魯伊訓練師",

	-- Step 41: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "",

	-- Step 42: Rut'theran Village flight master
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "{area:702}飛行管理員",

	-- Step 43: Feathermoon Stronghold
	-- {area:702} Rut'theran Village · {area:1116} Feathermoon Stronghold
	["From {area:702}, fly to {area:1116}."] = "從{area:702}飛往{area:1116}。",

	-- Step 45: Boat to The Forgotten Coast
	-- {area:1108} The Forgotten Coast
	["Boat to {area:1108}"] = "坐船到{area:1108}",

	-- Step 46: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle
	["Take the boat to the mainland: {npc:14637} waits on the dock where it lands."] = "",

	-- Step 47: The Forgotten Coast: kill these as you meet them
	-- {area:1108} The Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "{area:1108}：遇到就殺",
	-- {item:18904} Zorbin's Ultra-Shrinker · {npc:14637} Zorbin Fandazzle
	-- plural, as words: Sea Sprays = {npc:5462} Sea Spray · Water Elemental Cores = {item:18958} Water Elemental Core · Sea Elementals = {npc:5461} Sea Elemental · Deep Striders = {npc:5360} Deep Strider
	["The Sea Sprays (46-47) wash along the shore just south of the dock: they drop the Water Elemental Cores as well as the Sea Elementals (47) do. The Wave and Deep Striders (47) wade in the water off the same beach: zap them with {item:18904} first, and shrunken they lose their elite strength.\nThe Ultra-Shrinker lasts two hours: hand both quests back to {npc:14637} before you leave the coast."] = "",
	-- {item:18958} Water Elemental Core
	-- plural, as words: Sea Sprays = {npc:5462} Sea Spray
	["{item:18958}, from the Sea Sprays"] = "{item:18958}，從巨型海元素身上取得",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Deep Striders = {npc:5360} Deep Strider
	["{item:18904}, on the Wave and Deep Striders in the water"] = "{item:18904}，對水中的海浪巨人和深海巨人使用",

	-- Step 48: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle
	["Back to {npc:14637} on the dock."] = "回到碼頭上的{npc:14637}那裡。",

	-- Step 49: Gregan Brewspewer
	-- {area:1119} Twin Colossals · {npc:7775} Gregan Brewspewer · {item:11243} Videre Elixir · {item:11242} Evoroot
	["Ride north-east from the dock past the {area:1119} to {npc:7775}'s camp. He brews the {item:11243} from an {item:11242}: take his errand for one."] = "",

	-- Step 50: Rockbiter
	-- {npc:7765} Rockbiter · {npc:7775} Gregan Brewspewer
	["The giant {npc:7765} sits just north-west of {npc:7775}'s camp."] = "巨人{npc:7765}就坐在{npc:7775}營地的西北邊。",

	-- Step 51: Evoroot
	-- {item:11242} Evoroot · {npc:7765} Rockbiter · {npc:9467} Miblon Snarltooth
	["The {item:11242} grows inside a ruined building north of {npc:7765}: climb in through the break in its wall from the ledge beside it.\nOr the front door: {npc:9467} guards it, and the Bait Gregan sells draws him off when you use it beside him. Half the players in our recordings went in that way, half through the wall."] = "",

	-- Step 52: Shay Leafrunner
	-- {npc:7774} Shay Leafrunner · {item:9189} Shay's Bell
	["Ride west into the Ravenwind Ruins: {npc:7774} hides in the small round building at the back. Open the chest beside her for {item:9189}: it lasts 15 minutes, like the quest."] = "向西騎進鴉風廢墟：{npc:7774}躲在後方的小圓形建築裡。打開她旁邊的箱子取得{item:9189}：效果持續15分鐘，和任務時限一樣。",

	-- Step 53: Wandering Shay
	-- {npc:7774} Shay Leafrunner · {npc:7765} Rockbiter
	["Lead {npc:7774} back to {npc:7765} at walking pace: she wanders off, so ring the bell to call her back (not in combat), and clear the harpies on the way before she reaches them."] = "以步行速度把{npc:7774}帶回{npc:7765}那裡：她會走開，所以搖鈴把她叫回來（戰鬥時不行），並在她走到之前先清掉路上的鷹身人。",

	-- Step 54: Gregan Brewspewer
	-- {npc:7775} Gregan Brewspewer · {npc:7765} Rockbiter · {item:11242} Evoroot · {npc:9298} Donova Snowden · {area:976} Gadgetzan
	-- plural, as words: Videre Elixirs = {item:11243} Videre Elixir
	["Back to {npc:7775}'s camp, just south-east of {npc:7765}: the {item:11242} buys three Videre Elixirs. Keep them: {npc:9298} takes one at the start of the next guide, and Gaeriyan in {area:976} shows himself only to someone who has drunk one."] = "",

	-- Step 55: Feralas
	-- {area:489} Thalanaar · {zone:1441} Thousand Needles
	["Ride east along the road to {area:489}, on the {zone:1441} border: the next guide flies from there."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ends in the {zone:1413}: keep it"] = "在{zone:1413}完成：保留此任務",
	-- ["Five feathers buy a little Timbermaw reputation"] = "五根羽毛可換取少量木喉聲望",
	-- ["Fly from {area:1998} to the Sanctuary's end of the road, or ride south along it."] = "從{area:1998}飛往道路上聖地那一端，或沿路向南騎。",
	-- ["Fly to {area:415}"] = "飛往{area:415}",
	-- ["Follow the road north to the cratered vale and walk to each crater, killing the Entropic Beasts and Horrors between them."] = "沿著道路向北前往坑窪山谷，走到每個坑洞，並擊殺途中的熱能野獸和熱能恐獸。",
	-- ["If you skipped The Horn of the Beast or The {item:9328}, grind here to level 52.58 to stay on the route's plan."] = "如果跳過了瑪爾戈的巨角或{item:9328}，就在這裡刷到52.58級，以跟上路線進度。",
	-- ["Keep her alive until she is out of the cave"] = "在她離開洞穴之前保住她的性命",
	-- ["Level 52.58"] = "52.58級",
	-- ["Level 52.69"] = "52.69級",
	-- ["Level 52.9"] = "52.9級",
	-- ["Oozes"] = "軟泥怪",
	-- ["Ride east to the night elf camp at {area:1998}."] = "向東騎往{area:1998}的夜精靈營地。",
	-- ["Ride north out of {area:415} into {zone:1448} to the {area:2479}, the druids' camp by the road."] = "從{area:415}騎馬向北進入{zone:1448}，前往路旁的德魯伊營地{area:2479}。",
	-- ["Ride north to {area:1769} (or fly back to {area:1998} first) and through the tunnel into {zone:1452}; follow the road east to the goblin town of {area:2255}."] = "向北騎往{area:1769}（或先飛回{area:1998}），穿過隧道進入{zone:1452}；沿著道路向東前往哥布林城鎮{area:2255}。",
	-- ["Salfa stands at the {zone:1452} end of the tunnel: keep it"] = "薩爾法站在隧道的{zone:1452}那一端：保留此任務",
	-- ["Step into the cave: {npc:11558} stands just inside."] = "走進洞穴：{npc:11558}就站在入口內。",
	-- ["Still short of level 52.9 after the {area:2479}'s hand-ins? Top up on the Entropic Beasts in {area:1766}, the next stop north."] = "交完{area:2479}的任務後仍不到52.9級？在北邊下一站{area:1766}的熱能野獸身上練一下。",
	-- ["Take the boat from {area:702} to {area:442} and fly to {area:415}."] = "從{area:702}搭船前往{area:442}，再飛往{area:415}。",
	-- ["The Cursed and Tainted Oozes slide about the streams and fel pools around {area:1763} and {area:1765}: kill them and use Laris's Empty Ooze Jars on their remains."] = "被詛咒的軟泥怪和被污染的軟泥怪在{area:1763}和{area:1765}周圍的溪流與魔化水池中滑動：擊殺牠們，並對牠們的殘骸使用拉里斯的軟泥怪採樣瓶。",
	-- ["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop."] = "死木熊怪住在{npc:11554}西南方的村莊裡；保留牠們掉落的死木頭飾羽毛。",
	-- ["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. Keep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 58.\nCareful: Den Watchers are level 53-54 and the Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "{area:1762}的死木熊怪佈滿洞穴西邊的山丘。持續擊殺直到掉落{quest:8470}（約三十隻掉一個），然後右鍵點擊它：木喉要塞對你中立後，{area:1769}的{npc:11558}就會收下它，若已經中立就現在交，否則等最後一份指南在58級再次經過洞穴時交。\n小心：巢穴守衛是53-54級，復仇者是54-55級；血量低於50%時會呼叫25碼內的同伴，低於15%時會逃跑求援。",
	-- ["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. The Avengers can drop a {quest:8470}."] = "{area:1762}的死木熊怪佈滿洞穴西邊的山丘。死木復仇者可能掉落{quest:8470}。",
	-- ["The Jadefire satyrs hold the glen west of the road, with {npc:9454} at its back."] = "碧火薩特佔據道路西邊的山谷，{npc:9454}在山谷深處。",
	-- ["The vial is filled in {zone:1457}: keep it; inside"] = "瓶子在{zone:1457}裝滿：保留此任務；在裡面",
	-- ["The {item:11242} grows inside a ruined building north of {npc:7765}: climb in through the break in its wall from the ledge beside it."] = "{item:11242}生長在{npc:7765}北邊一棟廢墟建築裡：從旁邊的岩架穿過牆上的破口爬進去。",
	-- ["Top up here to level 52.69 before the hand-ins at {area:1763}: they take you to level 53."] = "在這裡補到52.69級，再去{area:1763}交任務，交完會升到53級。",
	-- ["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}. If you freed {npc:11018}, go back into {area:1770} for the succubus {npc:9518}; Trey Lightforge's remains lie beside her."] = "在{area:1763}中央的腐化月井使用{item:12922}。如果你釋放了{npc:11018}，回到{area:1770}找魅魔{npc:9518}；特雷·萊弗治的殘骸就在她旁邊。",
	-- ["grind on {npc:7109}"] = "刷{npc:7109}",
	-- ["grind on {npc:7153}"] = "刷{npc:7153}",
	-- ["grind on {npc:7155}"] = "刷{npc:7155}",
	-- ["grind on {npc:9878}"] = "刷{npc:9878}",
	-- ["{area:1763} is the ruined temple north of the glen."] = "{area:1763}是林地以北的廢棄神殿。",
	-- ["{area:1763} is the ruined temple north of the glen. Some of its cultists drop a {item:13140}, about one kill in thirty: it opens {npc:11018}'s cell in {area:1770}, the cave at the back. If it drops, clear the way out before you free her; if not, skip her quests."] = "{area:1763}是山谷北邊的神殿廢墟。部分教徒會掉落{item:13140}，大約每三十次擊殺一次：它能打開後方洞穴{area:1770}裡{npc:11018}的牢房。若有掉落，先清出離開的路再釋放她；若沒有，跳過她的任務。",
	-- ["{area:2618} is the satyr valley in the north-west, with {npc:10648} at its far end. He drops the {quest:939}; every Jadefire satyr can drop {item:11674}."] = "{area:2618}是西北方的薩特山谷，{npc:10648}在山谷盡頭。他會掉落{quest:939}；每個碧火薩特都可能掉落{item:11674}。",
	-- ["{item:13140}, a rare drop"] = "{item:13140}，稀有掉落",
	-- ["{npc:10924}: for {npc:11079} in {zone:1452}, keep it"] = "{npc:10924}：給{zone:1452}的{npc:11079}，先留著",
	-- ["{npc:11016}, in {area:1770}"] = "{npc:11016}，在{area:1770}",
	-- ["{npc:11557}: thirty {quest:6031}, handed in when you pass through again at 57"] = "{npc:11557}：三十塊{quest:6031}，在57級再次經過時繳交",
	-- ["{npc:11558}: the Timbermaw speak to you only from Neutral; walks around here: look inside the circle on the map"] = "{npc:11558}：木喉熊怪只有在中立以上才會和你說話；會在這附近走動：在地圖上的圓圈內找他",
	-- ["{npc:15395} waits at the north end of {area:361}"] = "{npc:15395}在{area:361}北端等候",
	-- ["{quest:8470}, a rare drop"] = "{quest:8470}，稀有掉落",
}
