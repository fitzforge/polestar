-- Russian (ruRU): the guide forever/alliance/03-darkshore-return (forever/alliance/03-darkshore-return.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Auberdine
	-- {npc:3649} Thundris Windweaver · {npc:3702} Alanndarian Nightsong · {npc:2913} Archaeologist Hollee · {npc:3693} Terenthis · {npc:3694} Sentinel Selarin · {quest:990} Trek to Ashenvale · {npc:3692} Volcor
	["From the dock (or the inn, if you used your Hearthstone), up to the north end of the village first ({npc:3649}, {npc:3702} by the moonwell, {npc:2913}), then down the main street: the WANTED poster outside the inn, {npc:3693} at its east end, where the road leaves south. {npc:3694} ({quest:990}) is beside {npc:3693} only for a few minutes at a time: she comes shortly after someone hands in {npc:3692}'s escort and leaves again about 5 minutes later. If she isn't there, don't wait: the guide offers her quest again when you hand in {npc:3692}'s escort to {npc:3693} yourself. Changing layer can also find her."] = "От причала (или от таверны, если вы использовали Камень возвращения) сначала в северную часть деревни ({npc:3649}, {npc:3702} у лунного колодца, {npc:2913}), затем вниз по главной улице: плакат «Разыскивается» у таверны, {npc:3693} в восточном конце улицы, где дорога уходит на юг. {npc:3694} ({quest:990}) стоит рядом с NPC {npc:3693} лишь несколько минут: она приходит вскоре после того, как кто-то сдаст сопровождение NPC {npc:3692}, и уходит примерно через 5 минут. Если ее нет, не ждите: гайд снова предложит ее задание, когда вы сами сдадите сопровождение NPC {npc:3692} персонажу {npc:3693}. Также найти ее может помочь смена слоя.",
	-- {npc:3649} Thundris Windweaver · {npc:1646} Baros Alexston
	["{npc:3649}, north end of the village: {npc:1646}'s reply"] = "",
	["The WANTED poster"] = "Плакат «РАЗЫСКИВАЕТСЯ»",
	-- {npc:3694} Sentinel Selarin · {npc:3693} Terenthis · {npc:3691} Raene Wolfrunner · {area:415} Astranaar
	["{npc:3694}, beside {npc:3693} if she is there: for {npc:3691} in {area:415}, in the next guide"] = "{npc:3694} рядом с NPC {npc:3693}, если она там: для NPC {npc:3691} в {area:415}, в следующем гайде",

	-- Step 2: Lunar Fungus and Earthroot
	-- {item:15851} Lunar Fungus · {item:2449} Earthroot
	["{item:15851} and {item:2449}"] = "{item:15851} и {item:2449}",
	-- {area:442} Auberdine · {item:2449} Earthroot · {skill:182} Herbalism · {zone:1439} Darkshore · {zone:1453} Stormwind · {npc:1313} Maria Lumere
	-- plural, as words: Lunar Fungal Blooms = {object:177750} Lunar Fungal Bloom
	["On the way south to the Grove: the Lunar Fungal Blooms grow in the moonkin caves in the hills just east of {area:442}, a short way off the road; the moonkin there are irritable. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else brings it from {zone:1453} ({npc:1313}) or the Auction House."] = "По пути на юг к Роще: Лунный Плеснецвет растет в пещерах лунных совухов на холмах чуть восточнее (ориентир: {area:442}), недалеко от дороги; совухи там раздражительны. Для предмета {item:2449} нужен навык {skill:182}: травники собирают его по всей зоне {zone:1439}, остальные привозят его из города {zone:1453} ({npc:1313}) или с аукциона.",

	-- Step 4: Onu
	-- {quest:948} Onu · {npc:270269} Arbal · {npc:11218} Kerlonian Evershade
	["{quest:948} is the ancient at the Grove; {npc:270269} and {npc:11218} sleep beside him."] = "",

	-- Step 5: The Grove of the Ancients
	-- {quest:952} Grove of the Ancients
	["The {quest:952}"] = "{quest:952}",
	-- {quest:1003} Buzzbox 525
	-- plural, as words: Grizzled Thistle Bears = {npc:2165} Grizzled Thistle Bear
	["Grizzled Thistle Bears roam the hills around the Grove; {quest:1003} stands west of it among them."] = "Седые колючешерстные медведи бродят по холмам вокруг Рощи; {quest:1003} стоит к западу от нее, среди них.",
	-- plural, as words: Grizzled Scalps = {item:5414} Grizzled Scalp
	["Grizzled Scalps"] = "Седые скальпы",

	-- Step 6: The Master's Glaive
	-- {object:12666} Twilight Tome · {npc:3584} Therylune · {quest:948} Onu · {item:5251} Phial of Scrying · {object:10076} Scrying Bowl
	-- plural, as words: Moonstalker Sires = {npc:2237} Moonstalker Sire
	["Moonstalker Sires prowl the woods around the glaive. The {object:12666} sits at the bottom of the crater; {npc:3584} stands on its north side. For {quest:948}'s quest, use the {item:5251} at the bottom of the crater: it makes the {object:10076}, and you hand the quest in to the bowl."] = "Взрослые лунопарды рыщут в лесу вокруг глефы. {object:12666} – на дне кратера; {npc:3584} стоит на его северной стороне. Для задания {quest:948} примените {item:5251} на дне кратера: так появится {object:10076}, и задание сдается чаше.",
	-- plural, as words: Fine Moonstalker Pelts = {item:5386} Fine Moonstalker Pelt
	["Fine Moonstalker Pelts"] = "Прекрасные шкуры лунопарда",
	-- {zone:1440} Ashenvale
	["Escort her out of the glaive; Therysil takes the turn-in in {zone:1440}"] = "Выведите ее из глефы; задание сдается Тересиль ({zone:1440})",
	-- {item:5352} Book: The Powers Below
	["Only if a Disciple or Thug dropped {item:5352}: right-click it"] = "Только если с послушника или лиходея упал предмет {item:5352}: щелкните по нему правой кнопкой",
	-- {object:10076} Scrying Bowl
	["The {object:10076}"] = "{object:10076}",
	-- {object:12666} Twilight Tome
	["The {object:12666}"] = "{object:12666}",
	-- {object:12666} Twilight Tome · {quest:949} The Twilight Camp
	["The {object:12666}, once it has {quest:949}"] = "",
	-- {item:279279} Peerless Eye
	-- plural, as words: Twilight Disciples = {npc:2338} Twilight Disciple
	["{item:279279}: Twilight Disciples and Thugs"] = "{item:279279}: послушники и лиходеи из культа Сумеречного Молота",

	-- Step 7: Prospector Remtravel
	-- {area:450} Remtravel's Excavation · {npc:10323} Murkdeep
	["{area:450} lies on the coast south of {npc:10323}'s beach. Protect the prospector while he searches for the fossil.\nCareful: Ambushers appear as he passes certain spots: a scout comes out from under the board ramp, and more scouts come out when he checks the tent."] = "",

	-- Step 8: Murkdeep's beach
	-- {npc:10323} Murkdeep
	["{npc:10323}'s beach"] = "Пляж: {npc:10323}",
	-- {npc:10323} Murkdeep · {area:450} Remtravel's Excavation
	["{npc:10323} camps on the beach west of the glaive: kill the murlocs at the camp fire; he comes in the third wave with his hound. Four beached remains lie on the beaches west and south-west of {area:450}: take them on the way north to his camp."] = "",

	-- Step 11: The shore west of the Grove
	["The shore west of the Grove"] = "",
	-- {area:442} Auberdine · {quest:4728} Beached Sea Creature
	["On the way north to {area:442}, the last {quest:4728} lies on the shore west of the Grove."] = "",

	-- Step 12: Auberdine
	["Follow the road north."] = "Идите по дороге на север.",
	-- {quest:87760} Holy Diver · {npc:10219} Gwennyth Bly'Leggonde
	["{quest:87760}: {npc:10219} offers it once all nine beached remains are handed in"] = "{quest:87760}: {npc:10219} дает это задание, когда сданы все девять выброшенных на берег останков",
	-- {item:15826} Curative Animal Salve
	["She gives you the {item:15826}"] = "Она дает вам предмет {item:15826}",

	-- Step 13: Gershala Nightwhisper
	-- {area:2797} Blackfathom Deeps · {area:414} Zoram Strand · {npc:8997} Gershala Nightwhisper · {npc:3693} Terenthis
	["For your {area:2797} run, on the {area:414} in the next guide: {npc:8997} stands a short walk west of {npc:3693}."] = "Для подземелья {area:2797}, на побережье ({area:414}) в следующем гайде: {npc:8997} стоит чуть западнее NPC {npc:3693}.",

	-- Step 14: On the way
	["On the way"] = "",

	-- Step 15: The naga
	["The naga"] = "Наги",
	-- {area:443} Ruins of Mathystra · {quest:951} Mathystra Relics · {npc:270294} Baron Marinous
	-- plural, as words: Stormscale Myrmidons = {npc:2181} Stormscale Myrmidon
	["Follow the coast north-east to the {area:443}. {quest:951} lie among the ruins; Stormscale Myrmidons, Sorceresses and Warriors hold them, and Stormscale Beastmistresses walk the shore. Careful: {npc:270294}, an elite naga (21), walks the ruins among them: pull the naga away from him, or fight him at full health."] = "Идите вдоль побережья на северо-восток ({area:443}). {quest:951} лежат среди руин; их охраняют мирмидоны, колдуньи и воины из клана Гремучей Чешуи, а по берегу ходят повелительницы зверей из клана Гремучей Чешуи. Осторожно: {npc:270294}, элитный нага (21), ходит по руинам среди них: выманивайте наг подальше от него или сражайтесь с ним с полным здоровьем.",

	-- Step 16: The Ruins of Mathystra
	-- {area:443} Ruins of Mathystra
	["The {area:443}"] = "{area:443}",
	-- {npc:6667} Gelkak Gyromast
	-- plural, as words: Giant Foreststriders = {npc:2323} Giant Foreststrider · Raging Reef Crawlers = {npc:2236} Raging Reef Crawler
	["{npc:6667} hides on the little island off the ruins. The key pieces drop from Giant Foreststriders (top), Greymist murlocs (middle) and Raging Reef Crawlers (bottom)."] = "{npc:6667} прячется на островке у руин. Части ключа падают с гигантских лесных долгоногов (верх), мурлоков из племени Серой Мглы (середина) и гневных рифовых крабов (низ).",
	["Underwater"] = "Под водой",

	-- Step 17: Strange Lockbox
	-- {item:15883} Half Pendant of Aquatic Agility · {object:177792} Strange Lockbox
	["{item:15883}: the {object:177792} under the water off the north coast, west of the ruins"] = "{item:15883}: {object:177792} под водой у северного побережья, к западу от руин",

	-- Step 18: Mist's Edge: kill these as you meet them
	-- {area:452} Mist's Edge
	["{area:452}: kill these as you meet them"] = "{area:452}: убивайте их по пути",

	-- Step 19: Back south
	["Back south"] = "Назад на юг",
	-- {npc:3616} Onu
	["{npc:3616}, at the Grove"] = "{npc:3616} – в Роще",

	-- Step 20: Volcor
	-- {npc:3692} Volcor · {area:449} Master's Glaive · {npc:3693} Terenthis · {area:442} Auberdine
	["{npc:3692} hides in the hills east of the {area:449}. Help him back to the road; he fights on his way out. {npc:3693} takes the escort in {area:442} on the next visit there."] = "",
	-- {npc:3692} Volcor · {area:455} Blackwood Den
	["{npc:3692}, inside {area:455}"] = "{npc:3692}, внутри: {area:455}",
	["His walk ends at the road, where Grimclaw waits"] = "",
	-- {npc:12298} Sickly Deer · {item:15826} Curative Animal Salve · {zone:1439} Darkshore
	["{npc:12298}: use the {item:15826} on them; they roam all of {zone:1439}"] = "{npc:12298}: примените на них {item:15826}; они бродят по всей зоне {zone:1439}",
	-- {npc:12298} Sickly Deer
	["Cure {npc:12298}"] = "",

	-- Step 21: Auberdine
	-- {quest:990} Trek to Ashenvale · {npc:3694} Sentinel Selarin · {npc:3693} Terenthis · {npc:3692} Volcor
	["No {quest:990} yet? Give it a minute after the hand-in: {npc:3694} comes to {npc:3693}'s side shortly after {npc:3692}'s escort is handed in. Changing layer can also find her."] = "Еще нет задания {quest:990}? Подождите минуту после сдачи: {npc:3694} приходит к NPC {npc:3693} вскоре после сдачи сопровождения NPC {npc:3692}. Также найти ее может помочь смена слоя.",
	-- {npc:3694} Sentinel Selarin · {quest:990} Trek to Ashenvale · {npc:3691} Raene Wolfrunner · {area:415} Astranaar · {zone:1440} Ashenvale
	["{npc:3694}, once she comes: {quest:990}, for {npc:3691} in {area:415} on your next {zone:1440} visit"] = "{npc:3694}, когда придет: {quest:990}, для NPC {npc:3691} в {area:415} при следующем визите в зону {zone:1440}",

	-- Step 22: Auberdine flight master
	-- {area:442} Auberdine
	["{area:442} flight master"] = "Распорядитель полетов: {area:442}",

	-- Step 23: The Great Cat Spirit
	-- {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Night Elves fly from {area:442} to {area:702}; Skyborne take the boat from the {area:442} dock and learn the Rut'theran flight path there. Take the portal up to {npc:4217} in the {area:1658}."] = "Ночные эльфы летят ({area:442} → {area:702}); небеснорожденные плывут на корабле от пристани ({area:442}) и там узнают маршрут полета Деревни Рут'теран. Поднимитесь через портал; там {npc:4217} ({area:1658}).",

	-- Step 26: Moonglade
	-- {spell:18960} Teleport: Moonglade
	["Cast {spell:18960}"] = "",

	-- Step 27: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:493} Moonglade · {npc:10897} Sindrayl
	["Cast {spell:18960}. {npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart. No {area:493} flight path yet? Learn it from {npc:10897}, south of the lake: the flight master in {area:2361} flies only Druids, from her gossip, and has none to learn."] = "Примените {spell:18960}. {npc:11802} стоит наверху в своем здании ({area:2361}): поднимитесь внутри, стрелка не различает этажи. Еще нет маршрута полета в {area:493}? Изучите его у NPC {npc:10897} к югу от озера: Распорядитель полетов в {area:2361} возит только друидов (через диалог) и маршрута для изучения не дает.",

	-- Step 28: Dendrite Starblaze
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["{npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart."] = "{npc:11802} стоит на верхнем этаже своего здания ({area:2361}): поднимитесь внутри, стрелка не различает этажи.",
	-- {npc:11802} Dendrite Starblaze · {npc:5504} Sheldras Moontree
	["{npc:11802}: the welcome from {npc:5504}"] = "{npc:11802}: приветствие от NPC {npc:5504}",

	-- Step 30: The relics of the Barrow Dens
	["The relics of the Barrow Dens"] = "Реликвии Келий Малфуриона",
	-- {quest:98394} The Great Cat Spirit · {npc:272054} Avatar of Saeyleenan · {area:493} Moonglade · {area:2363} Stormrage Barrow Dens
	["{quest:98394} (Night Elves) and the {npc:272054} (Skyborne) wait in southern {area:493}. The three relics lie in the {area:2363}, east of them. Reports from the first weeks say a relic gives no loot while another player is looting it: wait a moment and try again."] = "{quest:98394} (ночные эльфы) и {npc:272054} (небеснорожденные) ждут на юге ({area:493}). Три реликвии лежат к востоку от них ({area:2363}). По отчетам первых недель, реликвия не дает добычи, пока ее обыскивает другой игрок: подождите немного и попробуйте снова.",

	-- Step 31: Trial of the Sea Lion
	-- {zone:1436} Westfall · {zone:1439} Darkshore · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {spell:499} Cat Form
	["Both half pendants in your bags (the {zone:1436} half from your last {zone:1436} visit, the {zone:1439} half from the north coast): stand by the {area:2362} on the north-west shore of the lake and use a half to join them, then take the pendant to {npc:11802} with the {spell:499} hand-in. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Обе половинки подвески в сумках (половинка из зоны {zone:1436} – с последнего визита в зону {zone:1436}, половинка из зоны {zone:1439} – с северного побережья): встаньте у места {area:2362} на северо-западном берегу озера и используйте половинку, чтобы соединить их, затем отнесите подвеску NPC {npc:11802} вместе со сдачей задания на {spell:499}. {npc:11802} стоит на верхнем этаже своего здания: поднимитесь внутри, стрелка не различает этажи.",
	-- {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos
	["{item:15885}: join the halves at the {area:2362}"] = "{item:15885}: соедините половинки здесь: {area:2362}",
	-- {npc:11802} Dendrite Starblaze · {quest:5061} Aquatic Form · {npc:4217} Mathrengyl Bearwalker
	["{npc:11802}: {quest:5061}, for {npc:4217}"] = "{npc:11802}: {quest:5061}, для NPC {npc:4217}",

	-- Step 32: Back to Dendrite Starblaze
	-- {npc:11802} Dendrite Starblaze
	["Back to {npc:11802}"] = "Назад к {npc:11802}",
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11800} Silva Fil'naveth · {area:702} Rut'theran Village
	["Back to {npc:11802} in {area:2361}, then {npc:11800} there flies Druids straight to {area:702}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Назад: {npc:11802} ({area:2361}), затем {npc:11800} там же отправит друидов прямо сюда: {area:702}. {npc:11802} стоит на верхнем этаже своего здания: поднимитесь внутри, стрелка не различает этажи.",

	-- Step 35: To Darnassus
	-- {npc:4217} Mathrengyl Bearwalker · {area:442} Auberdine · {zone:1440} Ashenvale
	["Take the portal up to {npc:4217}, then fly back to {area:442} for the road south to {zone:1440}. {npc:4217} is a Druid trainer: learn your new spells from him."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Moonstalker Sires prowl the woods around the glaive. The {object:10076} and the {object:12666} sit at the bottom of the crater; {npc:3584} stands on its north side."] = "Взрослые лунопарды рыщут в лесу вокруг глефы. {object:10076} и {object:12666} – на дне кратера; {npc:3584} стоит на его северной стороне.",
}
