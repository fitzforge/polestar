-- Russian (ruRU): the guide forever/alliance/50-60/02-felwood (forever/alliance/50-60/02-felwood.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1448} Felwood · {area:2255} Everlook · {zone:1457} Darnassus · {zone:1444} Feralas
	["{zone:1448} and a stop in {area:2255}, then {zone:1457} and {zone:1444}."] = "{zone:1448} и остановка в {area:2255}, затем {zone:1457} и {zone:1444}.",

	-- Step 1: Felwood
	-- {area:3137} Talrendis Point · {area:2358} Forest Song · {zone:1448} Felwood · {area:2479} Emerald Sanctuary · {zone:1440} Ashenvale
	["From {area:3137} ride west along the road past {area:2358}, then north-west into {zone:1448}: the {area:2479} is the druids' camp on the road just past the {zone:1440} border."] = "",
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 2: The Emerald Sanctuary
	-- {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["The {area:2479} is the druids' camp by the road in southern {zone:1448}."] = "",
	-- {npc:9528} Arathandris Silversky · {npc:11554} Grazle
	["{npc:9528}, in the ruins just east of {npc:11554}"] = "{npc:9528} – в руинах чуть восточнее (ориентир: {npc:11554})",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "{npc:9116}, внутри",
	-- {npc:10920} Kelek Skykeeper · {quest:86577} A Sampling of Putrescence · {zone:1448} Felwood
	["{npc:10920}: {quest:86577}, from the bears and wolves you meet in {zone:1448}"] = "{npc:10920}: {quest:86577}, с медведей и волков, встреченных в зоне {zone:1448}",

	-- Step 3: Grazle
	-- {npc:11554} Grazle · {area:2479} Emerald Sanctuary
	["{npc:11554} the furbolg stands by the road just south of the {area:2479}."] = "Фурболг {npc:11554} стоит у дороги чуть южнее места {area:2479}.",

	-- Step 4: Deadwood Village
	-- {npc:11554} Grazle · {npc:15395} Nafien
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	-- was: ["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop."] = "Фурболги из племени Мертвого Леса живут в деревне чуть юго-западнее (ориентир: {npc:11554}); сохраняйте перья из головного убора Мертвого Леса, которые с них падают."
	["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop: {npc:11554} and {npc:15395} each take five."] = "",

	-- Step 5: Grazle
	-- {npc:15395} Nafien · {zone:1448} Felwood
	["{npc:15395} waits at the north end of {zone:1448}"] = "{npc:15395} ждет в северной части зоны {zone:1448}",

	-- Step 6: Jadefire Glen
	-- {npc:9454} Xavathras · {spell:7992} Slowing Poison
	-- plural, as words: Jadefire Shadowstalkers = {npc:7110} Jadefire Shadowstalker · Cursed Oozes = {npc:7086} Cursed Ooze
	["The Jadefire satyrs hold the glen west of the road, with {npc:9454} at its back.\nCareful: Jadefire Shadowstalkers (level 51-52) use Sneak and {spell:7992} and are stealthed, so they often join fights uninvited.\nCursed Oozes slide about the glen's streams: kill them and use Laris's Empty Ooze Jar on their remains."] = "Сатиры из племени Нефритового Пламени занимают долину к западу от дороги; {npc:9454} – в ее глубине.\nОсторожно: ночные охотники из племени Нефритового Пламени (51–52-й уровень) используют Крадущийся шаг и {spell:7992} и находятся в незаметности, поэтому часто вмешиваются в бой.\nПроклятые слизнюки ползают по ручьям долины: убивайте их и используйте на останках пустой флакон, полученный у Лариса.",

	-- Step 7: Ruins of Constellas
	-- {npc:9454} Xavathras · {area:2481} Ruins of Constellas
	["Careful: {npc:9454} (54) stands at the back of the {area:2481}, at about 32.2,67.1, with Shadowstalkers around him: clear them one at a time, then pull him alone at full health."] = "Осторожно: {npc:9454} (54) стоит в глубине руин ({area:2481}), около 32.2,67.1, а вокруг него – крадущиеся в тени: убивайте их по одному, затем выманите его одного при полном здоровье.",

	-- Step 8: Jaedenar
	-- {area:1763} Jaedenar · {npc:11141} Spirit of Trey Lightforge · {item:11948} Empty Tainted Ooze Jar
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["{area:1763} is the ruined temple north of the glen.\nCareful: the {npc:11141} (53, elite) haunts the west end of {area:1763}, around 35,60: work the south-east, where the arrow points, and pull the cultists and hounds away from him.\nTainted Oozes slide about {area:1763}'s fel pools: kill them and use the {item:11948} on their remains."] = "",
	-- {item:11949} Filled Tainted Ooze Jar · {area:1763} Jaedenar
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["{item:11949}: Tainted Oozes slide about {area:1763}'s fel pools"] = "{item:11949}: нечистые слизнюки ползают по озерам скверны ({area:1763})",

	-- Step 9: Putrescent organs: kill these as you meet them
	["Putrescent organs: kill these as you meet them"] = "Гниющие органы: убивайте встречных",
	-- {zone:1448} Felwood · {npc:10920} Kelek Skykeeper · {area:1763} Jaedenar
	["{zone:1448}'s Angerclaw bears and Felpaw wolves carry the putrescent organs {npc:10920} wants: the Bears and Wolves (47-48) of the south and the Maulers and Scavengers (49-50) along the road north of {area:1763}. Kill them as you ride between the stops."] = "Медведи Злобного Когтя и волки Сквернолапа в зоне {zone:1448} носят гниющие органы, нужные NPC {npc:10920}: медведи и волки (47-48) на юге, а также громилы и падальщики (49-50) вдоль дороги к северу от места {area:1763}. Убивайте их, проезжая между остановками.",

	-- Step 11: Shatter Scar Vale
	-- {npc:7136} Infernal Sentry
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["Follow the road north to the cratered vale and walk to each crater, killing the Entropic Beasts and Horrors between them.\nCareful: an {npc:7136} (53, elite) stands among the craters: walk round it."] = "Идите по дороге на север в долину с кратерами и обойдите каждый кратер, убивая по пути энтропических зверей и энтропических ужасов.\nОсторожно: среди кратеров стоит {npc:7136} (53, элитный): обойдите его.",
	["First crater"] = "Первый кратер",
	["Second crater"] = "Второй кратер",
	["Third crater"] = "Третий кратер",

	-- Step 12: Irontree Woods
	-- {area:1767} Irontree Woods · {area:2618} Jadefire Run · {item:11503} Blood Amber
	["The Warpwood treants of {area:1767}, east of {area:2618}, carry the {item:11503}."] = "{item:11503} носят древни-криводревы ({area:1767}, к востоку от места {area:2618}).",
	["Below ground"] = "Под землей",

	-- Step 13: Jadefire Run: kill these as you meet them
	-- {area:2618} Jadefire Run
	["{area:2618}: kill these as you meet them"] = "{area:2618}: убивайте их по пути",
	-- {area:2618} Jadefire Run · {npc:10648} Xavaric · {quest:939} Flute of Xavaric · {item:11674} Jadefire Felbind
	["{area:2618} is the satyr valley in the north-west, with {npc:10648} at its far end. He drops the {quest:939}; every Jadefire satyr can drop {item:11674}.\nCareful: {npc:10648} (55) stands at the valley's far end with Hellcallers (53-54) around him: clear them one at a time before you pull him."] = "{area:2618} – долина сатиров на северо-западе; {npc:10648} – в ее дальнем конце. С него падает {quest:939}; с любого сатира из племени Нефритового Пламени может упасть {item:11674}.\nОсторожно: {npc:10648} (55) стоит в дальнем конце долины, а вокруг него – призыватели ада (53-54): убейте их по одному, прежде чем выманивать его.",

	-- Step 14: Jaedenar again
	-- {area:1763} Jaedenar
	["{area:1763} again"] = "Снова: {area:1763}",
	-- {item:12922} Empty Canteen · {area:1763} Jaedenar
	["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}."] = "",

	-- Step 15: The Emerald Sanctuary
	-- {area:1763} Jaedenar · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Ride south-east from {area:1763} to the {area:2479}, the druids' camp by the road in southern {zone:1448}."] = "Езжайте на юго-восток ({area:1763} → {area:2479}) к лагерю друидов у дороги на юге зоны {zone:1448}.",

	-- Step 16: The Emerald Sanctuary
	-- {zone:1457} Darnassus
	["The vial is filled in {zone:1457}, later in this guide: keep it; inside"] = "",
	-- {area:392} Ratchet
	["Ends in {area:392}, on the next guide: keep it"] = "",

	-- Step 17: Nafien
	-- {area:1769} Timbermaw Hold · {npc:15395} Nafien
	["Ride north up the road from the Sanctuary, all the way to the cave mouth of {area:1769}; {npc:15395} guards it."] = "Езжайте от Святилища по дороге на север, до самого входа в пещеру ({area:1769}); его охраняет {npc:15395}.",

	-- Step 18: Felpaw Village
	-- {area:1762} Felpaw Village
	["The Deadwood furbolgs of {area:1762} fill the hills west of the cave.\nCareful: Den Watchers are level 53-54 and the Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "",

	-- Step 19: Deadwood Ritual Totem
	-- {quest:8470} Deadwood Ritual Totem · {npc:11558} Kernda · {area:1769} Timbermaw Hold
	["Only if the Timbermaw are already Neutral to you: the Deadwood furbolgs drop a {quest:8470} about one kill in thirty, and {npc:11558} just inside {area:1769} takes it. Below Neutral the quest is refused: it needs Neutral with the Timbermaw; the reputation guide gets you there."] = "",

	-- Step 20: Nafien
	-- {npc:11556} Salfa · {zone:1452} Winterspring
	-- was: ["Salfa stands at the {zone:1452} end of the tunnel: keep it"] = "Сальфа стоит у выхода из туннеля в зону {zone:1452}: сохраните задание"
	["{npc:11556} stands at the {zone:1452} end of the tunnel"] = "",

	-- Step 22: Timbermaw Hold
	-- {npc:11558} Kernda
	["Step into the cave: {npc:11558} stands just inside. She needs Neutral with the Timbermaw; the reputation guide gets you there."] = "",
	-- {npc:11558} Kernda
	["{npc:11558}: walks around here: look inside the circle on the map"] = "{npc:11558}: ходит здесь: ищите внутри круга на карте",

	-- Step 23: Into Winterspring
	-- {zone:1452} Winterspring
	["Into {zone:1452}"] = "В зону {zone:1452}",
	-- {area:1769} Timbermaw Hold · {zone:1452} Winterspring
	["Walk through {area:1769}'s tunnel to its {zone:1452} end."] = "",

	-- Step 24: Salfa
	-- {npc:11556} Salfa · {zone:1452} Winterspring · {area:1769} Timbermaw Hold
	["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "{npc:11556} стоит прямо у выхода туннеля ({area:1769}) в край {zone:1452}, там, где вы выходите.",

	-- Step 25: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Ride south to {npc:9298}'s camp beside the hot springs."] = "",
	-- {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["Keep it: {npc:7775} in {zone:1444}, later in this guide, brews the elixir"] = "",

	-- Step 26: Everlook
	-- {area:2255} Everlook
	["Ride east along the road to {area:2255}."] = "Езжайте на восток по дороге в {area:2255}.",
	-- {zone:1452} Winterspring
	["The Chillwind horns come on the next guide's {zone:1452} loop: keep it"] = "",

	-- Step 27: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "Летите сюда: {area:702}",
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
	["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "",

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
	["{npc:7740}: {quest:162}, from {area:976}"] = "{npc:7740}: {quest:162}, из места {area:976}",
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
	["{npc:4217}, upstairs"] = "{npc:4217}, наверху",
	-- {npc:4217} Mathrengyl Bearwalker · {item:11040} Morrowgrain
	["{npc:4217}'s next task grows ten {item:11040} from a pouch over several hours: skip it."] = "",
	-- {zone:1455} Ironforge
	["{zone:1455} has no druid trainer"] = "В городе {zone:1455} нет учителя друидов",

	-- Step 41: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "Портал: {zone:1438}",

	-- Step 42: Rut'theran Village flight master
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "Распорядитель полетов: {area:702}",

	-- Step 43: Feathermoon Stronghold
	-- {area:702} Rut'theran Village · {area:1116} Feathermoon Stronghold
	["From {area:702}, fly to {area:1116}."] = "Летите: {area:702} → {area:1116}.",

	-- Step 45: Boat to The Forgotten Coast
	-- {area:1108} The Forgotten Coast
	["Boat to {area:1108}"] = "Корабль: {area:1108}",

	-- Step 46: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle
	["Take the boat to the mainland: {npc:14637} waits on the dock where it lands."] = "",

	-- Step 47: The Forgotten Coast: kill these as you meet them
	-- {area:1108} The Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "{area:1108}: убивайте их по пути",
	-- {item:18904} Zorbin's Ultra-Shrinker · {npc:14637} Zorbin Fandazzle
	-- plural, as words: Sea Sprays = {npc:5462} Sea Spray · Water Elemental Cores = {item:18958} Water Elemental Core · Sea Elementals = {npc:5461} Sea Elemental · Deep Striders = {npc:5360} Deep Strider
	["The Sea Sprays (46-47) wash along the shore just south of the dock: they drop the Water Elemental Cores as well as the Sea Elementals (47) do. The Wave and Deep Striders (47) wade in the water off the same beach: zap them with {item:18904} first, and shrunken they lose their elite strength.\nThe Ultra-Shrinker lasts two hours: hand both quests back to {npc:14637} before you leave the coast."] = "",
	-- {item:18958} Water Elemental Core
	-- plural, as words: Sea Sprays = {npc:5462} Sea Spray
	["{item:18958}, from the Sea Sprays"] = "{item:18958} – с морских валов",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Deep Striders = {npc:5360} Deep Strider
	["{item:18904}, on the Wave and Deep Striders in the water"] = "{item:18904} – на волновых странников и странников глубин в воде",

	-- Step 48: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle
	["Back to {npc:14637} on the dock."] = "Назад к NPC {npc:14637} на причале.",

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
	["Ride west into the Ravenwind Ruins: {npc:7774} hides in the small round building at the back. Open the chest beside her for {item:9189}: it lasts 15 minutes, like the quest."] = "Езжайте на запад в Руины Воронова Ветра: {npc:7774} прячется в маленьком круглом здании в глубине. Откройте сундук рядом с ней ради предмета {item:9189}: он действует 15 минут, как и задание.",

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
	-- ["Ends in the {zone:1413}: keep it"] = "Завершается здесь: {zone:1413} – сохраните задание",
	-- ["Five feathers buy a little Timbermaw reputation"] = "Пять перьев дают немного репутации у Древобрюхов",
	-- ["Fly from {area:1998} to the Sanctuary's end of the road, or ride south along it."] = "Летите ({area:1998}) к концу дороги у Святилища или езжайте по ней на юг.",
	-- ["Fly to {area:415}"] = "Летите сюда: {area:415}",
	-- ["Follow the road north to the cratered vale and walk to each crater, killing the Entropic Beasts and Horrors between them."] = "Идите по дороге на север в долину с кратерами и обойдите каждый кратер, убивая по пути энтропических зверей и энтропических ужасов.",
	-- ["Keep her alive until she is out of the cave"] = "Не дайте ей погибнуть, пока она не выйдет из пещеры",
	-- ["Oozes"] = "Слизнюки",
	-- ["Ride east to the night elf camp at {area:1998}."] = "Езжайте на восток к лагерю ночных эльфов: {area:1998}.",
	-- ["Ride north to {area:1769} (or fly back to {area:1998} first) and through the tunnel into {zone:1452}; follow the road east to the goblin town of {area:2255}."] = "Езжайте на север: {area:1769} (или сначала летите обратно: {area:1998}), и через туннель в зону {zone:1452}; идите по дороге на восток к городу гоблинов: {area:2255}.",
	-- ["Salfa stands at the {zone:1452} end of the tunnel: keep it"] = "Сальфа стоит у выхода из туннеля в зону {zone:1452}: сохраните задание",
	-- ["Step into the cave: {npc:11558} stands just inside."] = "Войдите в пещеру: {npc:11558} стоит сразу у входа.",
	-- ["Still short of level 52.9 after the {area:2479}'s hand-ins? Top up on the Entropic Beasts in {area:1766}, the next stop north."] = "После сдачи заданий ({area:2479}) все еще не хватает до уровня 52.9? Доберите опыт на энтропических зверях здесь: {area:1766}, следующая остановка к северу.",
	-- ["Take the boat from {area:702} to {area:442} and fly to {area:415}."] = "Плывите на корабле: {area:702} → {area:442}, затем летите сюда: {area:415}.",
	-- ["The Cursed and Tainted Oozes slide about the streams and fel pools around {area:1763} and {area:1765}: kill them and use Laris's Empty Ooze Jars on their remains."] = "Проклятые и нечистые слизнюки ползают по ручьям и озерам скверны вокруг мест {area:1763} и {area:1765}: убивайте их и используйте на останках пустые флаконы, полученные у Лариса.",
	-- ["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop."] = "Фурболги из племени Мертвого Леса живут в деревне чуть юго-западнее (ориентир: {npc:11554}); сохраняйте перья из головного убора Мертвого Леса, которые с них падают.",
	-- ["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. Keep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 58.\nCareful: Den Watchers are level 53-54 and the Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "Фурболги Мертвого Леса из места {area:1762} заполняют холмы к западу от пещеры. Убивайте их, пока с одного не упадет {quest:8470} (примерно один на тридцать), затем щелкните по нему правой кнопкой: {npc:11558} ({area:1769}) примет его, когда Древобрюхи станут к вам равнодушны – сейчас, если уже, или когда последний гайд снова пройдет мимо пещеры на 58-м уровне.\nОсторожно: стражи логова – 53-54 уровня, мстители – 54-55; при здоровье ниже 50% они зовут союзников в радиусе 25 м, а ниже 15% убегают за помощью.",
	-- ["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. The Avengers can drop a {quest:8470}."] = "Фурболги из племени Мертвого Леса ({area:1762}) заполняют холмы к западу от пещеры. С мстителей может упасть {quest:8470}.",
	-- ["The Jadefire satyrs hold the glen west of the road, with {npc:9454} at its back."] = "Сатиры из племени Нефритового Пламени занимают долину к западу от дороги; {npc:9454} – в ее глубине.",
	-- ["The vial is filled in {zone:1457}: keep it; inside"] = "Склянка наполняется здесь: {zone:1457} – сохраните задание; внутри",
	-- ["The {item:11242} grows inside a ruined building north of {npc:7765}: climb in through the break in its wall from the ledge beside it."] = "{item:11242} растет внутри разрушенного здания к северу от {npc:7765}: заберитесь внутрь через пролом в стене с уступа рядом.",
	-- ["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}. If you freed {npc:11018}, go back into {area:1770} for the succubus {npc:9518}; Trey Lightforge's remains lie beside her."] = "Используйте {item:12922} у оскверненного лунного колодца в центре храма ({area:1763}). Если вы освободили персонажа {npc:11018}, вернитесь сюда: {area:1770} – за суккубом {npc:9518}; рядом с ней лежат останки Трея Светогорна.",
	-- ["grind on {npc:7109}"] = "убивайте: {npc:7109}",
	-- ["grind on {npc:7153}"] = "убивайте: {npc:7153}",
	-- ["grind on {npc:7155}"] = "убивайте: {npc:7155}",
	-- ["grind on {npc:9878}"] = "убивайте: {npc:9878}",
	-- ["{area:1763} is the ruined temple north of the glen. Some of its cultists drop a {item:13140}, about one kill in thirty: it opens {npc:11018}'s cell in {area:1770}, the cave at the back. If it drops, clear the way out before you free her; if not, skip her quests."] = "{area:1763} – разрушенный храм к северу от долины. С некоторых его культистов падает {item:13140}, примерно с одного из тридцати: он открывает камеру, где сидит {npc:11018} ({area:1770}, пещера в глубине). Если ключ выпал, расчистите путь к выходу, прежде чем освобождать ее; если нет, пропустите ее задания.",
	-- ["{area:2618} is the satyr valley in the north-west, with {npc:10648} at its far end. He drops the {quest:939}; every Jadefire satyr can drop {item:11674}."] = "{area:2618} – долина сатиров на северо-западе; {npc:10648} – в ее дальнем конце. С него падает {quest:939}; с любого сатира из племени Нефритового Пламени может упасть {item:11674}.",
	-- ["{item:13140}, a rare drop"] = "{item:13140}: редкая добыча",
	-- ["{npc:10924}: for {npc:11079} in {zone:1452}, keep it"] = "{npc:10924}: для NPC {npc:11079} в зоне {zone:1452}, сохраните",
	-- ["{npc:11016}, in {area:1770}"] = "{npc:11016} – здесь: {area:1770}",
	-- ["{npc:11557}: thirty {quest:6031}, handed in when you pass through again at 57"] = "{npc:11557}: тридцать шт. {quest:6031}, сдаются, когда вы снова пройдете здесь на 57-м уровне",
	-- ["{npc:11558}: the Timbermaw speak to you only from Neutral; walks around here: look inside the circle on the map"] = "{npc:11558}: Древобрюхи разговаривают с вами только начиная с уровня «Равнодушие»; ходит здесь: ищите внутри круга на карте",
	-- ["{npc:15395} waits at the north end of {area:361}"] = "{npc:15395} ждет в северной части зоны {area:361}",
	-- ["{quest:8470}, a rare drop"] = "{quest:8470}: редкая добыча",
}
