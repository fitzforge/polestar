-- Russian (ruRU): the guide forever/reputation/thunder-bluff (forever/reputation/thunder-bluff.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Thunder Bluff Reputation"] = "Репутация: Громовой Утес",
	-- {zone:1412} Mulgore · {zone:1452} Winterspring · {item:11040} Morrowgrain · {item:14047} Runecloth
	["{zone:1412} quests while you level, {zone:1452} quests and {item:11040} from 55, then {item:14047} to Exalted."] = "Задания {zone:1412}, пока вы поднимаете уровень, задания {zone:1452} и {item:11040} с 55-го, затем {item:14047} до «Превознесения».",
	-- {faction:81} Thunder Bluff
	["Exalted with {faction:81}"] = "Превознесение: {faction:81}",

	-- Step 1: Thunder Bluff: how it works
	-- {faction:81} Thunder Bluff
	["{faction:81}: how it works"] = "{faction:81}: как это работает",
	-- {faction:81} Thunder Bluff · {item:11040} Morrowgrain · {npc:14728} Rumstag Proudstrider · {quest:7825} Additional Runecloth · {item:14047} Runecloth · {zone:1454} Orgrimmar · {zone:1458} Undercity · {zone:1412} Mulgore · {area:378} Camp Taurajo · {zone:1441} Thousand Needles
	["{faction:81} reputation comes from quests, {item:11040} and cloth. {npc:14728}, the cloth quartermaster, stands on the central rise among the leatherworkers' and tailors' tents. He takes four one-time donations of 60 cloth (150 each) and then {quest:7825}, 20 {item:14047} for 50, as often as you like. Every point you earn with {faction:81} also gives a quarter as much to {zone:1454}, the {zone:1458} and the Darkspear Trolls. While you level, do {faction:81}'s quests within 5 levels of them: {zone:1412} at 1 to 12, {area:378} and the Crossroads at 13 to 22, {zone:1441} at 25 to 30. The Legacy perk Diplomat adds up to 10%. Rewards: at Honored Thunder Bluff's merchants sell to you for 10% less (the Classic rule), the kodo vendor included; at Exalted other races can buy the kodos: 20 gold for a level 40 kodo, 200 gold for a great kodo at level 60, once you have mount training. {faction:81} has no tabard or other reward."] = "Репутация с {faction:81} идёт от заданий, {item:11040} и ткани. {npc:14728}, интендант по ткани, стоит на центральном холме среди шатров кожевников и портных. Он принимает четыре одноразовых пожертвования по 60 ткани (по 150), а затем {quest:7825} — 20 {item:14047} за 50, сколько угодно раз. Каждая единица, заработанная у {faction:81}, даёт вчетверо меньше {zone:1454}, {zone:1458} и троллям Черного Копья. Пока вы поднимаете уровень, делайте задания {faction:81} в пределах 5 уровней от вашего: {zone:1412} с 1 по 12, {area:378} и Перекрёсток с 13 по 22, {zone:1441} с 25 по 30. Талант наследия Дипломат добавляет до 10%. Награды: на «Уважении» торговцы Громового Утёса продают вам на 10% дешевле (правило классики), включая продавца кодо; на «Превознесении» другие расы могут покупать кодо: 20 золота за кодо 40-го уровня, 200 золота за большого кодо 60-го уровня, если вы выучили езду. У {faction:81} нет гербовой накидки и другой награды.",
	["his donations are handed in from his window and never enter the log"] = "его пожертвования сдаются через его окно и не попадают в журнал",

	-- Step 2: Camp Narache (optional hub)
	-- {area:221} Camp Narache
	["{area:221} (optional hub)"] = "{area:221} (необязательный центр)",
	-- {area:221} Camp Narache · {zone:1412} Mulgore · {faction:81} Thunder Bluff · {npc:2980} Grull Hawkwind · {npc:2981} Chief Hawkwind · {npc:3209} Brave Windfeather
	["Forever pays these old quests in full at any level. {area:221}, at the south end of {zone:1412}: about 1,100 {faction:81} reputation in 25 minutes. Starting-zone quests give the other cities no share. {npc:2980} and {npc:2981} stand in the camp, {npc:3209} at its edge."] = "Forever оплачивает эти старые задания полностью на любом уровне. {area:221}, на южном конце {zone:1412}: около 1 100 репутации {faction:81} за 25 минут. Задания стартовой зоны не дают доли другим городам. {npc:2980} и {npc:2981} стоят в лагере, {npc:3209} — на его краю.",

	-- Step 3: Greatmother Hawkwind and the plains
	-- {npc:2991} Greatmother Hawkwind
	["{npc:2991} and the plains"] = "{npc:2991} и равнины",
	-- {npc:2991} Greatmother Hawkwind
	["{npc:2991}'s tent is south-east of the camp; the water pitcher stands at the well beside it. Plainstriders graze all around."] = "Шатёр {npc:2991} находится к юго-востоку от лагеря; водяной кувшин стоит у колодца рядом с ним. Равнинные бегуны пасутся повсюду.",

	-- Step 4: Camp Narache: hand in
	-- {area:221} Camp Narache
	["{area:221}: hand in"] = "{area:221}: сдача",

	-- Step 5: Seer Graytongue and the cougars
	-- {npc:2982} Seer Graytongue
	["{npc:2982} and the cougars"] = "{npc:2982} и пумы",
	-- {npc:2982} Seer Graytongue
	-- plural, as words: Mountain Cougars = {npc:2961} Mountain Cougar
	["{npc:2982} sits on the hill south of the camp; the Mountain Cougars live in those hills."] = "{npc:2982} сидит на холме к югу от лагеря; горные пумы живут в этих холмах.",

	-- Step 6: Camp Narache: the Battleboars
	-- {area:221} Camp Narache
	-- plural, as words: Battleboars = {npc:2966} Battleboar
	["{area:221}: the Battleboars"] = "{area:221}: боевые вепри",

	-- Step 7: Brambleblade Ravine
	-- {quest:780} The Battleboars · {npc:8554} Chief Sharptusk Thornmantle · {area:358} Brambleblade Ravine · {item:4851} Dirt-stained Map · {quest:781} Attack on Camp Narache
	["{quest:780} graze east of the camp; the Bristleback quilboar and {npc:8554} hold {area:358} beyond them. A {item:4851} lies in the ravine: reading it starts {quest:781}."] = "{quest:780} пасутся восточнее лагеря; свинобразы Дыбогривы и {npc:8554} держат {area:358} за ними. В овраге лежит {item:4851}: прочитав его, вы начнёте {quest:781}.",

	-- Step 8: Camp Narache: last hand-in
	-- {area:221} Camp Narache
	["{area:221}: last hand-in"] = "{area:221}: последняя сдача",
	-- {quest:763} Rites of the Earthmother · {npc:2993} Baine Bloodhoof
	["{quest:763}, +75: to {npc:2993}"] = "{quest:763}, +75: к {npc:2993}",

	-- Step 10: Bloodhoof Village (optional hub)
	-- {area:222} Bloodhoof Village
	["{area:222} (optional hub)"] = "{area:222} (необязательный центр)",
	-- {area:222} Bloodhoof Village · {zone:1412} Mulgore · {faction:81} Thunder Bluff · {npc:2993} Baine Bloodhoof · {npc:2947} Harken Windtotem · {npc:2985} Ruul Eagletalon · {npc:3222} Brave Wildrunner · {npc:2988} Morin Cloudstalker
	["Forever pays these old quests in full at any level. {area:222} and eastern {zone:1412}: about 1,000 {faction:81} reputation in 45 minutes. {npc:2993} stands in the middle of the village; {npc:2947}, {npc:2985} and {npc:3222} close by; {npc:2988} waits east of the village by the road."] = "Forever оплачивает эти старые задания полностью на любом уровне. {area:222} и восточная часть {zone:1412}: около 1 000 репутации {faction:81} за 45 минут. {npc:2993} стоит посреди деревни; {npc:2947}, {npc:2985} и {npc:3222} — рядом; {npc:2988} ждёт восточнее деревни у дороги.",

	-- Step 11: Eastern Mulgore
	-- {zone:1412} Mulgore
	["Eastern {zone:1412}"] = "Восточная часть {zone:1412}",
	-- {quest:99079} Longwalker Malah · {object:2908} Sealed Supply Crate
	["{quest:99079} waits by the eastern border. The {object:2908} of the ravaged caravan lies north-east of the village: open it to start the next quest."] = "{quest:99079} ждёт у восточной границы. {object:2908} разграбленного каравана лежит северо-восточнее деревни: откройте его, чтобы начать следующее задание.",
	-- {object:2908} Sealed Supply Crate
	["the {object:2908}"] = "{object:2908}",

	-- Step 12: Bloodhoof Village: hand in
	-- {area:222} Bloodhoof Village
	["{area:222}: hand in"] = "{area:222}: сдача",

	-- Step 13: The mine, the centaurs and the plains
	["The mine, the centaurs and the plains"] = "Шахта, кентавры и равнины",
	-- {quest:765} Supervisor Fizsprocket · {item:281031} Mulgore Expansion Plans · {quest:98424} Fizsprocket's Notes · {zone:1412} Mulgore
	["Back to the mine for the workers, supervisors and {quest:765} in the back: his {item:281031} start {quest:98424}, and its other pages lie inside the mine. The Galak centaurs and Herak camp east of the village. Swoops fly all over {zone:1412}; the Windfury harpies roost south-east of the village; the Palemane gnolls camp west of it."] = "Вернитесь к шахте за рабочими, надзирателями и {quest:765} в глубине: его {item:281031} начинают {quest:98424}, а остальные страницы лежат внутри шахты. Кентавры Галака и Херак стоят восточнее деревни. Свипы летают по всему {zone:1412}; гарпии Ветрокрылых гнездятся юго-восточнее деревни; гноллы Бледной Гривы разбили лагерь западнее неё.",
	-- {item:281031} Mulgore Expansion Plans · {quest:765} Supervisor Fizsprocket
	["{item:281031}, from {quest:765}"] = "{item:281031}: {quest:765}",
	-- {item:281035} Shredder Operation Instructions
	["{item:281035}, inside the mine"] = "{item:281035}, внутри шахты",

	-- Step 14: Morin Cloudstalker
	-- {quest:98427} Ceasing Operations · {quest:98424} Fizsprocket's Notes
	["{quest:98427}, +150: needs {quest:98424}"] = "{quest:98427}, +150: нужно {quest:98424}",

	-- Step 15: The Venture Co. Mine: the Clearcutter
	-- {area:360} The Venture Co. Mine
	["{area:360}: the Clearcutter"] = "{area:360}: «Отсекатель»",
	-- {npc:272173} Venture Co. Clearclutter · {quest:98427} Ceasing Operations
	-- was: ["The elite shredder Venture Co. Clearcutter works deep inside the mine, beyond where Fizsprocket stood: its key is for {quest:98427}."] = "Элитный крошер Торговой компании «Отсекатель» работает глубоко внутри шахты, дальше того места, где стоял Физсрокет: его ключ нужен для {quest:98427}."
	["The elite shredder {npc:272173} works deep inside the mine, beyond where Fizsprocket stood: its key is for {quest:98427}."] = "",

	-- Step 16: Bloodhoof Village: last hand-in
	-- {area:222} Bloodhoof Village
	["{area:222}: last hand-in"] = "{area:222}: последняя сдача",
	-- {quest:99082} The High Chieftain · {npc:3057} Cairne Bloodhoof · {faction:81} Thunder Bluff
	["{quest:99082}, +10: to {npc:3057} in {faction:81}"] = "{quest:99082}, +10: к {npc:3057} в {faction:81}",

	-- Step 18: Gloomrise (optional hub)
	-- {area:17044} Gloomrise
	["{area:17044} (optional hub)"] = "{area:17044} (необязательный центр)",
	-- {area:17045} Skywatcher Plateau · {faction:81} Thunder Bluff · {zone:1454} Orgrimmar · {npc:259118} Muln Earthfury · {npc:264074} Mazu'kon · {npc:264072} Yorn Grimtotem
	["Forever pays these old quests in full at any level. The Earthen Ring camp on the {area:17045}, north-west of {faction:81}: 300 {faction:81} reputation in 20 minutes, plus 100 each for {zone:1454} and the Darkspear Trolls and 450 Earthen Ring. {npc:259118}, {npc:264074} and {npc:264072} stand in the camp."] = "Forever оплачивает эти старые задания полностью на любом уровне. Лагерь Кольца Земли на {area:17045}, северо-западнее {faction:81}: 300 репутации {faction:81} за 20 минут, плюс по 100 для {zone:1454} и троллей Черного Копья и 450 Кольца Земли. {npc:259118}, {npc:264074} и {npc:264072} стоят в лагере.",
	-- {npc:259118} Muln Earthfury · {quest:96259} Defending the Dead · {quest:96261} The Broodmother
	["{npc:259118}: {quest:96259}, +100 ({quest:96261} comes once it is handed in)"] = "{npc:259118}: {quest:96259}, +100 ({quest:96261} откроется после сдачи)",
	-- {npc:264074} Mazu'kon · {quest:96241} Talkin' bout Toxins, Mon
	["{npc:264074}: {quest:96241} (Darkspear +100)"] = "{npc:264074}: {quest:96241} (Черное Копьё +100)",

	-- Step 19: Gloomrise
	-- {area:17044} Gloomrise · {faction:81} Thunder Bluff · {item:273015} Toxin Extractor · {npc:264082} Broodmother Valraxx · {item:273658} Bloody Parchment · {quest:96294} A Darker Truth
	-- plural, as words: Gnawed Corpses = {npc:264096} Gnawed Corpse
	["{area:17044} is the tauren burial ground north of {faction:81}. Use the {item:273015} on the Gnawed Corpses. {npc:264082} waits at the heart of it; her body carries a {item:273658}: read it to start {quest:96294}."] = "{area:17044} — тауренское кладбище севернее {faction:81}. Примените {item:273015} к обглоданным трупам. {npc:264082} ждёт в его сердцевине; на её теле лежит {item:273658}: прочитайте его, чтобы начать {quest:96294}.",
	-- {item:273181} Crystalline Silk
	-- plural, as words: Gloomrise Spinners = {npc:264081} Gloomrise Spinner
	["{item:273181}, from Gloomrise Spinners"] = "{item:273181}, с прядильщиц ({npc:264081})",

	-- Step 20: The Skywatcher camp: hand in
	["The Skywatcher camp: hand in"] = "Лагерь Небесного Надзора: сдача",
	-- {npc:259118} Muln Earthfury · {quest:96261} The Broodmother · {quest:96259} Defending the Dead
	["{npc:259118} offers {quest:96261} only once {quest:96259} is handed in."] = "{npc:259118} предлагает задание {quest:96261} только после сдачи задания {quest:96259}.",

	-- Step 21: Broodmother Valraxx
	-- {npc:264082} Broodmother Valraxx · {area:17044} Gloomrise
	["{npc:264082}, at the heart of {area:17044}"] = "{npc:264082}, в самом центре локации {area:17044}",

	-- Step 23: Rumstag Proudstrider: A Donation of Wool
	-- {npc:14728} Rumstag Proudstrider · {item:14047} Runecloth · {quest:7825} Additional Runecloth
	["From here it is cloth. Wool, Silk and Mageweave must all be handed in before {npc:14728} offers the {item:14047} donation, and {quest:7825} needs the {item:14047} donation. Buy cloth at the Auction House, or farm it: humanoids drop it, Wool from level 15 to 25, Silk 25 to 40, Mageweave 40 to 50, {item:14047} 50 and up. At 60 farm mobs of level 52 or more: lower ones are grey."] = "Дальше — ткань. Шерсть, шёлк и магическую ткань нужно сдать все до того, как {npc:14728} предложит пожертвование {item:14047}, а {quest:7825} требует пожертвования {item:14047}. Покупайте ткань на аукционе или добывайте сами: с гуманоидов падает ткань, шерсть с 15-го по 25-й уровень, шёлк с 25-го по 40-й, магическая ткань с 40-го по 50-й, {item:14047} с 50-го и выше. На 60-м уровне фармите мобов 52-го уровня и выше: более низкие — серые.",
	-- {item:2592} Wool Cloth
	["{item:2592}: the Thistlefur furbolgs drop it about one kill in four"] = "{item:2592}: фурболги Хилствера роняют её примерно с одного убийства из четырёх",

	-- Step 24: A Donation of Silk
	-- {area:287} Hillsbrad
	["Silk: the Syndicate in {area:287} and Alterac drop it about one kill in three, or buy it."] = "Шёлк: Отродье в {area:287} и Альтераке роняет его примерно с одного убийства из трёх, или купите.",
	-- {item:4306} Silk Cloth
	["{item:4306}: the Syndicate"] = "{item:4306}: Отродье",

	-- Step 25: A Donation of Mageweave
	-- {zone:1448} Felwood · {zone:1446} Tanaris
	["Mageweave: the Jadefire satyrs in southern {zone:1448} and the Dunemaul ogres in {zone:1446} drop it about one kill in three, or buy it."] = "Магическая ткань: сатиры Нефритового Пламени в южном {zone:1448} и огры Дюнмола в {zone:1446} роняют её примерно с одного убийства из трёх, или купите.",
	-- {item:4338} Mageweave Cloth
	["{item:4338}: the Jadefire satyrs"] = "{item:4338}: сатиры Нефритового Пламени",

	-- Step 26: A Donation of Runecloth
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand · {zone:1423} Eastern Plaguelands · {area:2577} Dire Maul · {zone:1444} Feralas · {zone:1451} Silithus
	["{item:14047}: the Scarlet at {area:2266} in the {zone:1423}, the Gordok ogres outside {area:2577} in {zone:1444} and the Twilight camps of {zone:1451} drop it about one kill in three. The Auction House is faster if you have gold."] = "{item:14047}: Алые в {area:2266} в {zone:1423}, огры Гордок снаружи {area:2577} в {zone:1444} и лагеря Сумеречного Братства в {zone:1451} роняют её примерно с одного убийства из трёх. Аукцион быстрее, если у вас есть золото.",
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand
	["{item:14047}: the Scarlet outside {area:2266}"] = "{item:14047}: Алые снаружи {area:2266}",

	-- Step 27: Everlook: Storm Shadowhoof
	-- {npc:10303} Storm Shadowhoof · {faction:81} Thunder Bluff · {npc:10806} Ursius · {area:2255} Everlook
	["{npc:10303}'s four quests are level 56 to 60, so they pay in full: 400 {faction:81} reputation. {npc:10806}, an elite bear, walks a loop over the four hills north of {area:2255}: wait on a hilltop for him."] = "Четыре задания {npc:10303} — 56-60 уровней, поэтому платят полностью: 400 репутации {faction:81}. {npc:10806}, элитный медведь, ходит кругом над четырьмя холмами севернее {area:2255}: ждите его на вершине холма.",
	-- {npc:10806} Ursius
	["{npc:10806}, elite"] = "{npc:10806}, элитный",

	-- Step 28: Brumeran and Shy-Rotam
	-- {npc:10807} Brumeran · {quest:5056} Shy-Rotam
	["{npc:10807} and {quest:5056}"] = "{npc:10807} и {quest:5056}",
	-- {npc:10807} Brumeran · {area:2255} Everlook · {quest:5056} Shy-Rotam · {item:12733} Sacred Frostsaber Meat · {object:103819} Stone of Shy-Rotam (no name in this language: may be words) · {npc:10306} Trull Failbane · {zone:1454} Orgrimmar · {item:12558} Blue-feathered Necklace · {quest:4882} Guarding Secrets · {faction:81} Thunder Bluff
	["{npc:10807}, an elite chimera, spawns south of {area:2255}. For {quest:5056}, kill frostsabers north of {area:2255} until one drops {item:12733} (about one in ten), then use the meat at the {object:103819}, far to the north, and kill the great cat that comes. If you have done {npc:10306}'s Wild Guardians quests (the {zone:1454} guide), the Crazed, Moontouched and Berserk owlbeasts around {area:2255} sometimes drop a {item:12558}: it starts {quest:4882}, 50 {zone:1454} and then 100 {faction:81} reputation in full."] = "{npc:10807}, элитная химера, появляется южнее {area:2255}. Для {quest:5056} убивайте морозных саблезубов севернее {area:2255}, пока один не уронит {item:12733} (примерно один из десяти), затем примените мясо у {object:103819} далеко на севере и убейте пришедшую большую кошку. Если вы прошли задания «Дикие Стражи» у {npc:10306} (гайд {zone:1454}), безумные, лунные и берсеркующиеся совокровы вокруг {area:2255} иногда роняют {item:12558}: он начинает {quest:4882}, 50 репутации {zone:1454}, а затем 100 репутации {faction:81} полностью.",
	-- {npc:10807} Brumeran
	["{npc:10807}, elite"] = "{npc:10807}, элитная",
	-- {item:12733} Sacred Frostsaber Meat
	["{item:12733}, from the frostsabers"] = "{item:12733}, с морозных саблезубов",

	-- Step 29: Bloodvenom Post: Trull Failbane
	-- {npc:10306} Trull Failbane · {area:1997} Bloodvenom Post · {zone:1452} Winterspring
	["{npc:10306} stands at {area:1997}, through the Timbermaw tunnel south of {zone:1452}."] = "{npc:10306} стоит в {area:1997}, через туннель Древобрюхов южнее {zone:1452}.",
	-- {quest:4882} Guarding Secrets · {npc:5770} Nara Wildmane · {faction:81} Thunder Bluff
	["{quest:4882}, +100: to {npc:5770} in {faction:81}"] = "{quest:4882}, +100: к {npc:5770} в {faction:81}",

	-- Step 31: Thunder Bluff: Nara Wildmane
	-- {npc:5770} Nara Wildmane · {area:1639} Elder Rise · {npc:5769} Arch Druid Hamuul Runetotem
	["{npc:5770} stands on {area:1639}, beside {npc:5769}."] = "{npc:5770} стоит на {area:1639}, рядом с {npc:5769}.",

	-- Step 32: Morrowgrain (optional)
	-- {item:11040} Morrowgrain
	["{item:11040} (optional)"] = "{item:11040} (необязательно)",
	-- {quest:3804} Morrowgrain to Thunder Bluff · {item:11040} Morrowgrain · {item:11020} Evergreen Pouch · {quest:3761} Un'Goro Soil · {npc:6746} Innkeeper Pala · {npc:5769} Arch Druid Hamuul Runetotem · {area:1639} Elder Rise
	["{quest:3804} takes 10 {item:11040} for 50, as often as you like, and pays in full at 60, but it is slow: the {item:11020} grows one casing every 10 minutes and a casing holds about one {item:11040} on average, so each hand-in takes about 90 minutes of waiting, 18 {quest:3761} and 9 seed packets (90 silver). It runs beside whatever else you do: a little over 30 reputation an hour. The chain before it is level 50. {npc:6746} sends you to {npc:5769} on {area:1639}; he wants 20 {quest:3761}."] = "{quest:3804} берёт 10 {item:11040} за 50, сколько угодно раз, и платит полностью на 60-м, но это медленно: {item:11020} выращивает одну капсулу каждые 10 минут, а в капсуле в среднем один {item:11040}, поэтому на каждую сдачу уходит около 90 минут ожидания, 18 {quest:3761} и 9 пакетов семян (90 серебра). Это идёт параллельно остальному: чуть больше 30 репутации в час. Цепочка перед этим — 50-го уровня. {npc:6746} отправляет вас к {npc:5769} на {area:1639}; ему нужно 20 {quest:3761}.",

	-- Step 33: Un'Goro Crater: Un'Goro Soil
	-- {quest:3761} Un'Goro Soil · {item:11040} Morrowgrain
	["Nearly every beast, plant and silithid in the crater drops {quest:3761}, about one kill in three (the Bloodpetals and the Gorishi wasps about one in two), and the dirt mounds give it too. Take far more than 20: every casing uses 2, about 18 for each {item:11040} hand-in."] = "Почти каждый зверь, растение и силитид в кратере роняет {quest:3761}, примерно одно убийство из трёх (у Кроволепестников и ос Гориши — примерно одно из двух), и земляные насыпи тоже дают его. Берите далеко больше 20: каждая капсула использует 2, примерно 18 на каждую сдачу {item:11040}.",

	-- Step 34: Thunder Bluff: Morrowgrain Research
	-- {npc:9076} Ghede · {npc:9087} Bashana Runetotem · {item:11020} Evergreen Pouch · {quest:3761} Un'Goro Soil · {item:11024} Evergreen Herb Casing · {item:11040} Morrowgrain
	["{npc:9076} takes the soil. {npc:9087} sells the {item:11020} (1 gold) and Packets of Tharlendris Seeds (10 silver each). With a seed packet and 2 {quest:3761} in your bags, use the pouch: it grows an {item:11024}, once every 10 minutes. Open each casing: about one in three holds 1 to 5 {item:11040}, the rest common herbs. Use the pouch whenever it is ready while you follow the rest of this guide."] = "{npc:9076} берёт землю. {npc:9087} продаёт {item:11020} (1 золото) и пакеты семян Тарлендриса (по 10 серебра). С пакетом семян и 2 {quest:3761} в сумке примените мешочек: он выращивает {item:11024}, раз в 10 минут. Открывайте каждую капсулу: примерно одна из трёх содержит от 1 до 5 {item:11040}, остальные — простые травы. Применяйте мешочек всякий раз, когда он готов, пока следуете остальной части этого гайда.",
	-- {item:11020} Evergreen Pouch
	["{item:11020}, 1 gold"] = "{item:11020}, 1 золото",
	-- {item:11022} Packet of Tharlendris Seeds
	["{item:11022}, 10 silver each"] = "{item:11022}, по 10 серебра",

	-- Step 35: Morrowgrain as you go
	-- {item:11040} Morrowgrain
	["{item:11040} as you go"] = "{item:11040} по пути",
	-- {item:11040} Morrowgrain · {npc:9087} Bashana Runetotem
	["{item:11040}: use the pouch every 10 minutes and open the casings; {npc:9087} takes it"] = "{item:11040}: применяйте мешочек каждые 10 минут и открывайте капсулы; {npc:9087} принимает его",

	-- Step 36: Bashana Runetotem: Morrowgrain Research
	-- {npc:9087} Bashana Runetotem · {area:1639} Elder Rise · {item:11040} Morrowgrain
	["{npc:9087} stands on {area:1639}. If your 10 {item:11040} are not ready yet, skip this step and go on with the cloth: the cloth steps below list the {item:11040} hand-in too."] = "{npc:9087} стоит на {area:1639}. Если ваши 10 {item:11040} ещё не готовы, пропустите этот шаг и продолжайте с тканью: шаги с тканью ниже тоже перечисляют сдачу {item:11040}.",

	-- Step 37: Additional Runecloth to Honored
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Honored"] = "{quest:7825} до уровня «Уважение»",
	-- {quest:7825} Additional Runecloth · {item:14047} Runecloth
	["{quest:7825}: 20 {item:14047} for 50 reputation, as often as you like. Friendly to Honored is 6,000: 120 hand-ins, 2,400 {item:14047}, less what the quests gave you (a tauren starts at Friendly 1,000: 100 hand-ins; an Undead at Neutral 500 first needs 50 more to reach Friendly). Hand in every 20 you carry, one after another."] = "{quest:7825}: 20 {item:14047} за 50 репутации, сколько угодно раз. От «Дружелюбия» до «Уважения» — 6 000: 120 сдач, 2 400 {item:14047}, меньше того, что дали задания (таурен начинает с «Дружелюбия» 1 000: 100 сдач; нежить с «Равнодушия» 500 сначала нужно ещё 50, чтобы достичь «Дружелюбия»). Сдавайте каждые 20, что несёте, один за другим.",
	-- {item:11040} Morrowgrain · {npc:9087} Bashana Runetotem
	["{item:11040}, if you grow it: {npc:9087} takes it"] = "{item:11040}, если вы его выращиваете: {npc:9087} принимает его",

	-- Step 38: Additional Runecloth to Revered
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Revered"] = "{quest:7825} до уровня «Почтение»",
	-- {item:14047} Runecloth · {item:11040} Morrowgrain · {area:1584} Blackrock Depths · {area:340} Kargath · {npc:9017} Lord Incendius
	["Honored to Revered is 12,000: 240 hand-ins, 4,800 {item:14047}, fewer if you also hand in {item:11040}. {area:1584} pays too: Disharmony of Flame and Disharmony of Fire from Thunderheart at {area:340} ({npc:9017}, 150 in full)."] = "От «Уважения» до «Почтения» — 12 000: 240 сдач, 4 800 {item:14047}, меньше, если вы также сдаёте {item:11040}. {area:1584} тоже платит: «Дисгармония пламени» и «Дисгармония огня» от Громоверха в {area:340} ({npc:9017}, 150 полностью).",
	-- {item:11040} Morrowgrain
	["{item:11040}, if you grow it"] = "{item:11040}, если вы его выращиваете",

	-- Step 39: Additional Runecloth to Exalted
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Exalted"] = "{quest:7825} до уровня «Превознесение»",
	-- {item:14047} Runecloth · {npc:3685} Harb Clawhoof · {area:222} Bloodhoof Village
	["Revered to Exalted is 21,000: 420 hand-ins, 8,400 {item:14047}. For The Horde! (Rend's head) and The Lord of Blackrock (Nefarian's head) pay 200 to every Horde city. At Exalted, {npc:3685} in {area:222} sells the kodos to every Horde race: 20 gold for a level 40 kodo, 200 gold for a great kodo at level 60 (Forever's prices); in Classic other races needed Exalted to buy them."] = "От «Почтения» до «Превознесения» — 21 000: 420 сдач, 8 400 {item:14047}. «За Орду!» (голова Ренда) и «Повелитель Черной Скалы» (голова Нефариана) платят 200 каждому городу Орды. На «Превознесении» {npc:3685} в {area:222} продаёт кодо всем расам Орды: 20 золота за кодо 40-го уровня, 200 золота за большого кодо 60-го уровня (цены Forever); в классике другим расам нужно было «Превознесение», чтобы их купить.",
	-- {npc:3685} Harb Clawhoof
	["{npc:3685}: the kodos"] = "{npc:3685}: кодо",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Добыча здесь: адепты Тьмы ({npc:8546}) и темные маги (уровень 58-60); каждое убийство Плети здесь также дает репутацию ({object:92525}, см. тот гайд). Подойдет и аукцион.",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Добыча здесь: огры из клана Песчаного Молота (уровень 45-48). Подойдет и аукцион.",
	-- ["Keep handing in {quest:7825} until {faction:81} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Сдавайте задание {quest:7825}, пока репутация ({faction:81}) не дойдет до превознесения. {item:14047}: Адепты Тьмы и темные маги (уровень 58-60) – зона {zone:1423}, или аукцион.",
	-- ["Keep handing in {quest:7825}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Продолжайте сдавать: {quest:7825}, по 20 шт. ({item:14047}). {item:14047}: Адепты Тьмы и темные маги (уровень 58-60) – зона {zone:1423}, или аукцион.",
	-- ["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "Добыча здесь: кентавры из племени Колкар (уровень 30-33). Подойдет и аукцион.",
	-- ["The elite shredder Venture Co. Clearcutter works deep inside the mine, beyond where Fizsprocket stood: its key is for {quest:98427}."] = "Элитный крошер Торговой компании «Отсекатель» работает глубоко внутри шахты, дальше того места, где стоял Физсрокет: его ключ нужен для {quest:98427}.",
	-- ["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "Добыча здесь: {npc:3283} ({area:381}, уровень 16-17). Подойдет и аукцион.",
	-- ["{npc:14728} takes cloth for {faction:81} in {faction:81}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7825} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14728} принимает ткань для фракции {faction:81} (место: {faction:81}). Первые пожертвования шерсти, шелкового материала, магической ткани и предмета {item:14047} (по 60 шт.) делаются один раз и дают больше всего репутации за ткань; после них {quest:7825} повторяется до превознесения. Превознесение у города другой расы позволяет покупать транспорт этой расы. Бонус наследия Forever «Дипломат» ускоряет рост репутации.",
	-- ["{npc:14728}: {item:14047} delivered"] = "{npc:14728}: {item:14047} сдано",
	-- ["{quest:7825} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7825}: 20 шт. ({item:14047}) за сдачу, повторяется сколько угодно. Приносите {item:14047} партиями по 20 и сдавайте все сразу, одну сдачу за другой. {item:14047}: Адепты Тьмы и темные маги (уровень 58-60) – зона {zone:1423}, или аукцион.",
	-- ["{zone:1452}'s level 56-60 quests, {item:11040} and {item:14047} to Exalted, with {zone:1412}'s old quests as an optional extra."] = "Задания зоны {zone:1452} (уровень 56-60), {item:11040} и {item:14047} до превознесения; по желанию – старые задания зоны {zone:1412}.",
}
