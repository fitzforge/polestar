-- Russian (ruRU): the guide forever/reputation/orgrimmar (forever/reputation/orgrimmar.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Orgrimmar Reputation"] = "Репутация: Оргриммар",
	-- {zone:1411} Durotar · {zone:1448} Felwood · {zone:1447} Azshara · {item:14047} Runecloth
	["{zone:1411} and Crossroads quests while you level, {zone:1448} and {zone:1447} quests from 55, then {item:14047} to Exalted."] = "Задания {zone:1411} и Перекрестка пока вы поднимаете уровень, задания {zone:1448} и {zone:1447} с 55-го уровня, затем {item:14047} до «Превознесения».",
	-- {faction:76} Orgrimmar
	["Exalted with {faction:76}"] = "Превознесение: {faction:76}",

	-- Step 1: Orgrimmar: how it works
	-- {faction:76} Orgrimmar
	["{faction:76}: how it works"] = "{faction:76}: как это работает",
	-- {faction:76} Orgrimmar · {npc:14726} Rashona Straglash · {quest:7832} Additional Runecloth · {item:14047} Runecloth · {zone:1456} Thunder Bluff · {zone:1458} Undercity · {zone:1411} Durotar · {npc:4949} Thrall · {quest:5726} Hidden Enemies
	["{faction:76} reputation comes from quests and cloth. {npc:14726}, the cloth quartermaster, stands in the Drag beside the cloth and leather armor shop. She takes four one-time donations of 60 cloth (150 each) and then {quest:7832}, 20 {item:14047} for 50, as often as you like. Every point you earn with {faction:76} also gives a quarter as much to {zone:1456}, the {zone:1458} and the Darkspear Trolls. While you level, do {faction:76}'s quests within 5 levels of them: {zone:1411} at 5 to 12, the Crossroads at 12 to 20, {npc:4949}'s {quest:5726} at 12 to 16. The Legacy perk Diplomat adds up to 10%. Rewards: at Honored Orgrimmar's merchants sell to you for 10% less (the Classic rule), the wolf vendor included; at Exalted other races can buy the wolves: 20 gold for a level 40 wolf, 200 gold for a swift wolf at level 60, once you have mount training. {faction:76} has no tabard or other reward."] = "Репутация {faction:76} растет за задания и ткань. {npc:14726}, интендант ткани, стоит в Драге рядом с лавкой тканевой и кожаной брони. Она принимает четыре разовых пожертвования по 60 ткани (по 150 очков), а затем {quest:7832} — 20 {item:14047} за 50, сколько угодно раз. Каждый заработанный у {faction:76} пункт даёт вчетверо меньше {zone:1456}, {zone:1458} и троллям Черного Копья. Пока вы поднимаете уровень, делайте задания {faction:76} в пределах 5 уровней от них: {zone:1411} с 5 по 12, Перекресток с 12 по 20, {quest:5726} от {npc:4949} с 12 по 16. Талант наследия Дипломат добавляет до 10%. Награды: на уровне «Уважение» торговцы Оргриммара продают вам на 10% дешевле (правило Classic), включая торговца волками; на «Превознесении» другие расы могут покупать волков: 20 золота за волка 40-го уровня, 200 золота за стремительного волка на 60-м, если вы изучили езду. У {faction:76} нет табарда и других наград.",
	["her donations are handed in from her window and never enter the log"] = "ее пожертвования сдаются через ее окно и не попадают в журнал",

	-- Step 2: Valley of Trials (optional hub)
	-- {area:363} Valley of Trials
	["{area:363} (optional hub)"] = "{area:363} (необязательный узел)",
	-- {area:363} Valley of Trials · {faction:76} Orgrimmar · {npc:3143} Gornek · {npc:10176} Kaltunk
	["Forever pays these old quests in full at any level. The {area:363} is the best of them: about 1,400 {faction:76} and 1,400 Darkspear reputation in 25 minutes. {npc:3143} waits in the Den, the big hut; {npc:10176} stands outside it."] = "Forever оплачивает эти старые задания полностью на любом уровне. {area:363} — лучшее из них: около 1400 репутации {faction:76} и 1400 репутации Черного Копья за 25 минут. {npc:3143} ждёт в Логове, большой хижине; {npc:10176} стоит снаружи.",
	-- {npc:3144} Eitrigg · {faction:76} Orgrimmar · {quest:787} The New Horde
	["{npc:3144}, in {faction:76}: {quest:787}, +50"] = "{npc:3144}, в {faction:76}: {quest:787}, +50",
	-- {npc:5765} Ruzan · {quest:792} Vile Familiars
	["{npc:5765}: {quest:792}, warlocks only"] = "{npc:5765}: {quest:792}, только для чернокнижников",

	-- Step 3: Boars, weapons and peons
	["Boars, weapons and peons"] = "Кабаны, оружие и прислужники",
	-- {npc:10556} Lazy Peon · {item:16114} Foreman's Blackjack
	["The training weapons lie on the ground in the Den and among the boars to the north. For the peons: target a sleeping {npc:10556} and use the {item:16114} on it."] = "Тренировочное оружие лежит на земле в Логове и среди кабанов к северу. Для прислужников: выберите спящего {npc:10556} и используйте на нём {item:16114}.",
	-- {npc:10556} Lazy Peon · {item:16114} Foreman's Blackjack
	["{npc:10556}: hit it with the {item:16114}"] = "{npc:10556}: ударьте его {item:16114}",
	-- {npc:10556} Lazy Peon
	["Wake {npc:10556}"] = "Разбудите {npc:10556}",

	-- Step 4: The Den: hand in
	-- {area:364} The Den
	["{area:364}: hand in"] = "{area:364}: сдать",

	-- Step 5: North of the Den
	["North of the Den"] = "Севернее Логова",
	-- {npc:3287} Hana'zua · {quest:790} Sarkoth · {quest:792} Vile Familiars · {area:365} Burning Blade Coven · {quest:6394} Thazz'ril's Pick
	["The cactus apples grow beside the cacti north of the Den. {npc:3287} lies wounded by the rocks to the north; {quest:790}, his big scorpid, roams close by. {quest:792} swarm at the mouth of the {area:365}; {quest:6394} lies inside: take the middle tunnel where it splits three ways."] = "Кактусовые яблоки растут рядом с кактусами к северу от Логова. {npc:3287} лежит раненый у скал к северу; {quest:790}, его большой скорпион, бродит неподалёку. {quest:792} роятся у входа в {area:365}; {quest:6394} лежит внутри: возьмите средний тоннель там, где он разветвляется на три.",
	-- {quest:6394} Thazz'ril's Pick
	["{quest:6394}, in the cave"] = "{quest:6394}, в пещере",

	-- Step 6: The Den: hand in again
	-- {area:364} The Den
	["{area:364}: hand in again"] = "{area:364}: сдать снова",

	-- Step 7: Burning Blade Coven
	-- {npc:3183} Yarrog Baneshadow
	["Go back into the cave and keep to the right-hand wall all the way, over a small stream, to {npc:3183} on a ledge above a pool."] = "Вернитесь в пещеру и держитесь правой стены до конца, через небольшой ручей, к {npc:3183} на уступе над водоёмом.",
	-- {quest:794} Burning Blade Medallion · {npc:3183} Yarrog Baneshadow
	["{quest:794}, from {npc:3183}"] = "{quest:794}, от {npc:3183}",
	-- {npc:3145} Zureetha Fargaze
	["{npc:3145}, in the Den"] = "{npc:3145}, в Логове",
	-- {quest:805} Report to Sen'jin Village · {quest:97225} Forgotten Loa Idols
	["{quest:805}, +50: {quest:97225} waits on it"] = "{quest:805}, +50: {quest:97225} ждёт на нём",

	-- Step 9: Sen'jin Village (optional hub)
	-- {area:367} Sen'jin Village
	["{area:367} (optional hub)"] = "{area:367} (необязательный узел)",
	-- {area:367} Sen'jin Village · {area:368} Echo Isles · {faction:76} Orgrimmar · {npc:3188} Master Gadrin · {npc:3304} Master Vornal · {npc:3194} Vel'rin Fang · {npc:7953} Xar'Ti
	["Forever pays these old quests in full at any level. {area:367} and the {area:368}: about 700 {faction:76} and 650 Darkspear reputation in 25 minutes. {npc:3188} and {npc:3304} stand by the huts, {npc:3194} near the water, {npc:7953} south of the village."] = "Forever оплачивает эти старые задания полностью на любом уровне. {area:367} и {area:368}: около 700 репутации {faction:76} и 650 репутации Черного Копья за 25 минут. {npc:3188} и {npc:3304} стоят у хижин, {npc:3194} у воды, {npc:7953} к югу от деревни.",
	-- {quest:97225} Forgotten Loa Idols · {quest:805} Report to Sen'jin Village
	["{quest:97225}, +100: needs {quest:805} from the Den"] = "{quest:97225}, +100: нужно {quest:805} из Логова",

	-- Step 10: The Echo Isles
	-- {area:368} Echo Isles
	["The {area:368}"] = "{area:368}",
	-- {area:368} Echo Isles · {quest:826} Zalazane
	-- plural, as words: Durotar Tigers = {npc:3121} Durotar Tiger
	["Swim to the largest of the {area:368}, south-east of the village. {quest:826}, the idols and the skulls at the circle of power are all there; the Durotar Tigers prowl the smaller islands."] = "Плывите к крупнейшему из {area:368}, юго-восточнее деревни. {quest:826}, идолы и черепа у круга силы — всё там; дуротарские тигры бродят по меньшим островам.",
	-- {quest:808} Minshina's Skull · {object:3237} Imprisoned Darkspear
	["{quest:808}: click an {object:3237} skull"] = "{quest:808}: щёлкните по черепу {object:3237}",

	-- Step 11: The coast and the road
	["The coast and the road"] = "Побережье и дорога",
	-- {quest:97223} Bloodtalon Matriarch · {area:362} Razor Hill
	["Makrura and surf crawlers walk the beaches east and south of Sen'jin. The {quest:97223} is east of the village. The Ridgeshade spiders are along the road south of {area:362} and north-east of the Den."] = "Макруры и береговые крабы ходят по пляжам восточнее и южнее Сен'джина. {quest:97223} восточнее деревни. Пауки Хребтолома — вдоль дороги южнее {area:362} и северо-восточнее Логова.",

	-- Step 12: Sen'jin Village: hand in
	-- {area:367} Sen'jin Village
	["{area:367}: hand in"] = "{area:367}: сдать",

	-- Step 13: Thrall: Hidden Enemies (optional hub)
	-- {npc:4949} Thrall · {quest:5726} Hidden Enemies
	["{npc:4949}: {quest:5726} (optional hub)"] = "{npc:4949}: {quest:5726} (необязательный узел)",
	-- {quest:5726} Hidden Enemies · {faction:76} Orgrimmar · {area:2437} Ragefire Chasm
	["Forever pays these old quests in full at any level. {quest:5726}: 400 {faction:76} reputation in 20 minutes, with a run through {area:2437} that a level 60 clears alone."] = "Forever оплачивает эти старые задания полностью на любом уровне. {quest:5726}: 400 репутации {faction:76} за 20 минут, с забегом в {area:2437}, который 60-й уровень проходит один.",

	-- Step 14: Skull Rock: the Lieutenant's Insignia
	-- {quest:827} Skull Rock · {item:14544} Lieutenant's Insignia
	["{quest:827}: the {item:14544}"] = "{quest:827}: {item:14544}",
	-- {quest:827} Skull Rock · {faction:76} Orgrimmar
	-- plural, as words: Burning Blade Fanatics = {npc:3197} Burning Blade Fanatic
	["{quest:827} is the cave just east of {faction:76}. Burning Blade Fanatics and Apprentices inside drop the insignia about one kill in five."] = "{quest:827} — это пещера прямо восточнее {faction:76}. Фанатики из клана Пылающего Клинка и ученики внутри роняют знак примерно с одного убийства из пяти.",

	-- Step 15: Orgrimmar: Thrall and Neeru Fireblade
	-- {faction:76} Orgrimmar · {npc:4949} Thrall · {npc:3216} Neeru Fireblade
	["{faction:76}: {npc:4949} and {npc:3216}"] = "{faction:76}: {npc:4949} и {npc:3216}",
	-- {npc:3216} Neeru Fireblade · {object:172960} Cleft of Shadow
	["{npc:3216} is in the {object:172960}. Tell him he may speak openly and click through his story."] = "{npc:3216} находится в {object:172960}. Скажите ему, что он может говорить открыто, и пройдите его историю.",
	-- {npc:3216} Neeru Fireblade
	["{npc:3216}: hear him out"] = "{npc:3216}: выслушайте его",

	-- Step 16: Ragefire Chasm
	-- {area:2437} Ragefire Chasm · {object:172960} Cleft of Shadow · {npc:11518} Jergosh the Invoker · {npc:11519} Bazzalan
	["{area:2437} opens off the {object:172960}. {npc:11518} and {npc:11519} wait at the far end."] = "{area:2437} открывается от {object:172960}. {npc:11518} и {npc:11519} ждут в дальнем конце.",
	-- {npc:11518} Jergosh the Invoker · {npc:11519} Bazzalan
	["{npc:11518} and {npc:11519}"] = "{npc:11518} и {npc:11519}",

	-- Step 17: Orgrimmar: Hidden Enemies done
	-- {faction:76} Orgrimmar · {quest:5728} Hidden Enemies
	["{faction:76}: {quest:5728} done"] = "{faction:76}: {quest:5728} выполнено",

	-- Step 18: Razor Hill: Sen'jin hand-ins
	-- {area:362} Razor Hill
	["{area:362}: Sen'jin hand-ins"] = "{area:362}: сдать за Сен'джин",

	-- Step 19: Razor Hill (optional hub)
	-- {area:362} Razor Hill
	["{area:362} (optional hub)"] = "{area:362} (необязательный узел)",
	-- {area:362} Razor Hill · {zone:1411} Durotar · {faction:76} Orgrimmar · {npc:3142} Orgnil Soulscar · {npc:3139} Gar'Thok · {npc:3191} Cook Torka · {npc:3147} Furl Scornbrow · {npc:266940} Turroc
	["Forever pays these old quests in full at any level. {area:362} and north {zone:1411}: about 1,800 {faction:76} and 1,650 Darkspear reputation in 80 minutes. {npc:3142} and {npc:3139} stand in the middle of the town, {npc:3191} by the barracks, {npc:3147} and {npc:266940} at the edges."] = "Forever оплачивает эти старые задания полностью на любом уровне. {area:362} и северный {zone:1411}: около 1800 репутации {faction:76} и 1650 репутации Черного Копья за 80 минут. {npc:3142} и {npc:3139} стоят в центре города, {npc:3191} у казарм, {npc:3147} и {npc:266940} по краям.",
	-- {quest:806} Dark Storms · {quest:823} Report to Orgnil
	["{quest:806}, +100: needs {quest:823} from Sen'jin"] = "{quest:806}, +100: нужно {quest:823} из Сен'джина",

	-- Step 20: Tiragarde Keep
	-- {area:362} Razor Hill · {npc:3192} Lieutenant Benedict · {object:3239} Benedict's Chest · {item:4881} Aged Envelope · {quest:830} The Admiral's Orders · {item:4870} Canvas Scraps · {item:275713} Raider's Bow
	["The keep is south of {area:362} on the coast. {npc:3192} is in the keep's only building; his key opens {object:3239} on the roof, and the {item:4881} inside starts {quest:830}. The sailors and marines drop the {item:4870}; the {item:275713}, Battleaxe and Shield lie outside the keep."] = "Крепость Тиражад находится южнее {area:362} на побережье. {npc:3192} — в единственном здании крепости; его ключ открывает {object:3239} на крыше, а {item:4881} внутри начинает {quest:830}. Моряки и морпехи роняют {item:4870}; {item:275713}, Секира и Щит лежат снаружи крепости.",

	-- Step 21: Razormane Grounds and the Echo Isles
	-- {area:816} Razormane Grounds · {area:368} Echo Isles
	["{area:816} and the {area:368}"] = "{area:816} и {area:368}",
	-- {area:362} Razor Hill · {area:368} Echo Isles · {object:3240} Taillasher Eggs
	["The Razormane camps are south-west and west of {area:362}; the Prickly Pear cacti grow among them. Then head to the {area:368} for the {object:3240}: each nest gives an egg every time."] = "Лагеря серебрянокожих — юго-западнее и западнее {area:362}; кактусы Колючей груши растут среди них. Затем отправляйтесь на {area:368} за {object:3240}: каждое гнездо даёт яйцо каждый раз.",

	-- Step 22: Razor Hill: hand in
	-- {area:362} Razor Hill
	["{area:362}: hand in"] = "{area:362}: сдать",
	-- {quest:830} The Admiral's Orders · {npc:3230} Nazgrel · {faction:76} Orgrimmar
	["{quest:830}, +100: to {npc:3230} in {faction:76}"] = "{quest:830}, +100: к {npc:3230} в {faction:76}",

	-- Step 23: The wreck
	["The wreck"] = "Кораблекрушение",
	-- {area:372} Tiragarde Keep
	["The wrecked ship lies in the shallows east of {area:372}. Open the Gnomish Toolboxes."] = "Разбитый корабль лежит на отмели восточнее {area:372}. Откройте гномские ящики с инструментами.",
	-- {npc:3139} Gar'Thok · {area:362} Razor Hill
	["back at {npc:3139} in {area:362}"] = "вернувшись к {npc:3139} в {area:362}",

	-- Step 24: North Durotar
	-- {zone:1411} Durotar
	["North {zone:1411}"] = "Северный {zone:1411}",
	-- {npc:3293} Rezlak · {area:362} Razor Hill · {npc:3193} Misha Tor'kren
	["{npc:3293} stands on the road north of {area:362}, {npc:3193} at her farm west of it."] = "{npc:3293} стоит на дороге севернее {area:362}, {npc:3193} — на её ферме западнее неё.",

	-- Step 25: Thunder Ridge and Razorwind Canyon
	-- {area:369} Thunder Ridge · {area:410} Razorwind Canyon
	["{area:369} and {area:410}"] = "{area:369} и {area:410}",
	-- {npc:3203} Fizzle Darkstorm · {area:369} Thunder Ridge · {faction:76} Orgrimmar · {area:410} Razorwind Canyon · {area:362} Razor Hill · {item:4891} Kron's Amulet
	["{npc:3203} keeps a Burning Blade camp in {area:369}, south of {faction:76}, among the thunder lizards. The supply sacks lie in {area:410}, north of {area:362}. {item:4891} drops from the crocolisks along the river to the west, about one in ten."] = "{npc:3203} держит лагерь Пылающего Клинка в {area:369}, южнее {faction:76}, среди громовых ящеров. Сумки с припасами лежат в {area:410}, севернее {area:362}. {item:4891} роняют кроколисы вдоль реки к западу, примерно с одного из десяти.",

	-- Step 26: Rezlak and Misha
	-- {npc:3293} Rezlak
	["{npc:3293} and Misha"] = "{npc:3293} и Миша",
	-- {npc:3118} Dustwind Storm Witch · {item:277661} Dull Storm Orb · {quest:97281} A Simmering Storm · {npc:3293} Rezlak · {quest:97282} Stormy Potential
	["A {npc:3118} may drop a {item:277661}: use it to start {quest:97281}. Once you hand that in, {npc:3293} offers {quest:97282}."] = "{npc:3118} может уронить {item:277661}: используйте его, чтобы начать {quest:97281}. Как только вы сдадите его, {npc:3293} предложит {quest:97282}.",
	-- {npc:3117} Dustwind Savage · {area:370} Drygulch Ravine
	["{npc:3117}, in {area:370}"] = "{npc:3117}, здесь: {area:370}",

	-- Step 27: Stormy Potential
	-- {area:369} Thunder Ridge · {npc:3293} Rezlak
	-- plural, as words: Charged Thunder Lizard Organs = {item:277665} Charged Thunder Lizard Organ
	["The Charged Thunder Lizard Organs come from the thunder lizards on {area:369}, just west of {npc:3293}."] = "Заряженные органы рокочущей ящерицы добываются с громовых ящеров на {area:369}, прямо западнее {npc:3293}.",

	-- Step 29: Skull Rock
	-- {quest:828} Margoz · {quest:827} Skull Rock · {faction:76} Orgrimmar
	["{quest:828} camps outside {quest:827}, the cave just east of {faction:76}."] = "{quest:828} раскинулся лагерем снаружи {quest:827}, пещеры прямо восточнее {faction:76}.",

	-- Step 30: Orgrimmar: Neeru Fireblade and Nazgrel
	-- {faction:76} Orgrimmar · {npc:3216} Neeru Fireblade · {npc:3230} Nazgrel
	["{faction:76}: {npc:3216} and {npc:3230}"] = "{faction:76}: {npc:3216} и {npc:3230}",
	-- {quest:829} Neeru Fireblade · {object:172960} Cleft of Shadow · {npc:3230} Nazgrel · {npc:4949} Thrall
	["{quest:829} is in the {object:172960}; {npc:3230} in Grommash Hold beside {npc:4949}."] = "{quest:829} находится в {object:172960}; {npc:3230} — в Громовом Зале рядом с {npc:4949}.",

	-- Step 31: Far Watch Post
	-- {faction:76} Orgrimmar · {zone:1413} Barrens · {npc:3337} Kargal Battlescar · {quest:809} Ak'Zeloth · {area:379} Far Watch Post
	["Run out of {faction:76}'s west gate and over the bridge into the {zone:1413}. {npc:3337} and {quest:809} stand at {area:379}."] = "Выбегите из западных ворот {faction:76} и через мост в {zone:1413}. {npc:3337} и {quest:809} стоят у {area:379}.",
	-- {quest:842} Crossroads Conscription · {quest:860} Sergra Darkthorn
	["{quest:842}, +100: to {quest:860}"] = "{quest:842}, +100: к {quest:860}",

	-- Step 33: The Crossroads (optional hub)
	-- {area:380} The Crossroads
	["{area:380} (optional hub)"] = "{area:380} (необязательный узел)",
	-- {area:380} The Crossroads · {faction:76} Orgrimmar · {quest:860} Sergra Darkthorn · {npc:3464} Gazrog · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger · {npc:267310} Gur'ak · {npc:3432} Mankrik
	["Forever pays these old quests in full at any level. {area:380}: about 1,500 {faction:76} reputation in 70 minutes, {faction:76}'s only. {quest:860}, {npc:3464}, {npc:3429}, {npc:3449} and {npc:267310} stand in the town, {npc:3432} by the inn."] = "Forever оплачивает эти старые задания полностью на любом уровне. {area:380}: около 1500 репутации {faction:76} за 70 минут, только у {faction:76}. {quest:860}, {npc:3464}, {npc:3429}, {npc:3449} и {npc:267310} стоят в городе, {npc:3432} — у таверны.",

	-- Step 34: Around the Crossroads
	["Around the Crossroads"] = "Вокруг Перекрестка",
	-- {npc:267307} Chol'aruk · {area:1699} Thorn Hill · {npc:10668} Beaten Corpse · {area:378} Camp Taurajo
	["The Razormane camps and the supply crates are north-east of the town; {npc:267307}, an elite boar, sits deep in the {area:1699} cave there. The Witchwing harpies nest far to the north-west. The {npc:10668} lies north-east of {area:378}, in the south: right-click it. Raptors and plainstriders are everywhere."] = "Лагеря серебрянокожих и ящики с припасами находятся северо-восточнее города; {npc:267307}, элитный кабан, сидит глубоко в пещере {area:1699} там. Гарпии Когтистого Крыла гнездятся далеко на северо-западе. {npc:10668} лежит северо-восточнее {area:378}, на юге: щёлкните по нему. Рапторы и равнинные страусы повсюду.",
	-- {npc:10668} Beaten Corpse
	["{npc:10668}: right-click it"] = "{npc:10668}: щёлкните по нему",

	-- Step 35: The Crossroads: hand in
	-- {area:380} The Crossroads
	["{area:380}: hand in"] = "{area:380}: сдать",

	-- Step 36: Zhevras, quilboars, harpies and the Raptor Grounds
	-- {area:1697} Raptor Grounds
	["Zhevras, quilboars, harpies and the {area:1697}"] = "Зевры, кабаны, гарпии и {area:1697}",
	-- {npc:3438} Kreenig Snarlsnout · {quest:3281} Stolen Silver · {area:1697} Raptor Grounds · {area:378} Camp Taurajo
	-- plural, as words: Zhevra Runners = {npc:3242} Zhevra Runner · Witchwing Slayers = {npc:3278} Witchwing Slayer
	["Zhevra Runners graze south and west of the town. {npc:3438} leads the Razormane camps north-east. The Witchwing Slayers carry the rings. The {quest:3281} is in the {area:1697} east of {area:378}: follow the nest-lined path on its left side to the last nest."] = "Жевры-бегуны пасутся южнее и западнее города. {npc:3438} ведёт лагеря серебрянокожих на северо-восток. Душегубки из стаи Зачарованного Крыла носят кольца. {quest:3281} находится в {area:1697} восточнее {area:378}: идите по тропе с гнёздами по её левой стороне до последнего гнезда.",

	-- Step 37: The Crossroads: hand in again
	-- {area:380} The Crossroads
	["{area:380}: hand in again"] = "{area:380}: сдать снова",

	-- Step 38: Prowlers, Serena Bloodfeather and Echeyakee
	-- {npc:3452} Serena Bloodfeather · {quest:881} Echeyakee
	["Prowlers, {npc:3452} and {quest:881}"] = "Следопыты, {npc:3452} и {quest:881}",
	-- {quest:876} Serena Bloodfeather · {npc:3338} Sergra Darkthorn · {item:10327} Horn of Echeyakee · {object:147524} Echeyakee's Lair (no name in this language: may be words)
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["Savannah Prowlers lie west and north of the Crossroads. {quest:876} leads the Witchwing harpies in the far north-west. Then {npc:3338} gives you the {item:10327}: blow it beside the kodo bones at {object:147524}, north of the town, and kill the white lion."] = "Хищники саванны лежат западнее и севернее Перекрестка. {quest:876} ведёт гарпий Когтистого Крыла на дальнем северо-западе. Затем {npc:3338} даёт вам {item:10327}: подуйте в него рядом с костями кодо у {object:147524}, севернее города, и убейте белого льва.",

	-- Step 39: Chen's Empty Keg (optional hub)
	-- {quest:819} Chen's Empty Keg
	["{quest:819} (optional hub)"] = "{quest:819} (необязательный узел)",
	-- {quest:819} Chen's Empty Keg · {zone:1413} Barrens · {npc:3292} Brewmaster Drohn · {area:392} Ratchet · {faction:76} Orgrimmar
	["Forever pays it in full at any level. {quest:819} lies on the ground at one of several spots in the central and northern {zone:1413}, most of them by the roads around the Crossroads; once someone takes it, it turns up at another. {npc:3292} in {area:392} pays 250 {faction:76} reputation for the keg and its first filling, then 50 for every filling after, as often as you like."] = "Forever оплачивает его полностью на любом уровне. {quest:819} лежит на земле в одном из нескольких мест в центральном и северном {zone:1413}, чаще всего у дорог вокруг Перекрестка; как только кто-то забирает его, он появляется в другом. {npc:3292} в {area:392} платит 250 репутации {faction:76} за кег и первую наполненную порцию, затем 50 за каждую следующую, сколько угодно раз.",
	-- {quest:819} Chen's Empty Keg
	["{quest:819}: look for it by the roads"] = "{quest:819}: ищите у дорог",

	-- Step 41: Lions, plainstriders and a thunder lizard
	["Lions, plainstriders and a thunder lizard"] = "Львы, равнинные страусы и громовой ящер",
	-- {zone:1413} Barrens
	["Savannah lions, plainstriders and thunder lizards roam the whole northern {zone:1413}. The lions drop a tusk about every other kill, the plainstriders a kidney about two kills in five; any thunder lizard may drop the horn, about one in five."] = "Львы Саванны, равнинные страусы и громовые ящеры бродят по всему северному {zone:1413}. Львы роняют клык примерно через одно убийство, страусы — почку примерно с двух из пяти; любой громовой ящер может уронить рог, примерно с одного из пяти.",

	-- Step 42: Ratchet: the repeatable keg
	-- {area:392} Ratchet
	["{area:392}: the repeatable keg"] = "{area:392}: повторяющийся кег",
	-- {item:4897} Thunderhawk Saliva Gland · {item:4896} Kodo Liver · {npc:3238} Stormhide · {area:378} Camp Taurajo · {area:392} Ratchet
	-- plural, as words: Lightning Glands = {item:4898} Lightning Gland · Greater Thunderhawks = {npc:3249} Greater Thunderhawk
	["From now on Drohn takes 5 Lightning Glands, a {item:4897} and a {item:4896} for 50, as often as you like. The {npc:3238} thunder lizards (a gland about every other kill), the Greater Thunderhawks and the kodos south of {area:378} drop them. Gather several sets before you head back to {area:392}."] = "С этого момента Дрон принимает 5 грозовых желез, {item:4897} и {item:4896} за 50, сколько угодно раз. Их роняют громовые ящеры {npc:3238} (железа примерно через одно убийство), большие грозовые змеи и кодо южнее {area:378}. Соберите несколько наборов, прежде чем возвращаться в {area:392}.",
	-- {item:4898} Lightning Gland
	-- plural, as words: Stormhides = {npc:3238} Stormhide
	["{item:4898}, from Stormhides"] = "{item:4898}, с грозошкур",
	-- {item:4897} Thunderhawk Saliva Gland
	-- plural, as words: Greater Thunderhawks = {npc:3249} Greater Thunderhawk
	["{item:4897}, from Greater Thunderhawks"] = "{item:4897}, с больших грозовых змеев",
	-- {item:4896} Kodo Liver
	["{item:4896}, from the kodos"] = "{item:4896}, с кодо",

	-- Step 43: Rashona Straglash: A Donation of Wool
	-- {npc:14726} Rashona Straglash · {item:14047} Runecloth · {quest:7832} Additional Runecloth
	["From here it is cloth. Wool, Silk and Mageweave must all be handed in before {npc:14726} offers the {item:14047} donation, and {quest:7832} needs the {item:14047} donation. Buy cloth at the Auction House, or farm it: humanoids drop it, Wool from level 15 to 25, Silk 25 to 40, Mageweave 40 to 50, {item:14047} 50 and up. At 60 farm mobs of level 52 or more: lower ones are grey."] = "С этого момента — ткань. Шерсть, Шелк и Магическую ткань нужно сдать до того, как {npc:14726} предложит пожертвование {item:14047}, а {quest:7832} требует пожертвования {item:14047}. Покупайте ткань на аукционе или добывайте: её роняют гуманоиды, Шерсть с 15-го по 25-й уровень, Шелк с 25-го по 40-й, Магическая ткань с 40-го по 50-й, {item:14047} с 50-го и выше. На 60-м уровне фармите мобов 52-го уровня и выше: более низкие серые.",
	-- {item:2592} Wool Cloth
	["{item:2592}: the Thistlefur furbolgs drop it about one kill in four"] = "{item:2592}: фурболги Хилствера роняют её примерно с одного убийства из четырёх",

	-- Step 44: A Donation of Silk
	-- {area:287} Hillsbrad
	["Silk: the Syndicate in {area:287} and Alterac drop it about one kill in three, or buy it."] = "Шёлк: Отродье в {area:287} и Альтераке роняет его примерно с одного убийства из трёх, или купите.",
	-- {item:4306} Silk Cloth
	["{item:4306}: the Syndicate"] = "{item:4306}: Отродье",

	-- Step 45: A Donation of Mageweave
	-- {zone:1448} Felwood · {zone:1446} Tanaris
	["Mageweave: the Jadefire satyrs in southern {zone:1448} and the Dunemaul ogres in {zone:1446} drop it about one kill in three, or buy it."] = "Магическая ткань: сатиры Нефритового Пламени в южном {zone:1448} и огры Дюнмола в {zone:1446} роняют её примерно с одного убийства из трёх, или купите.",
	-- {item:4338} Mageweave Cloth
	["{item:4338}: the Jadefire satyrs"] = "{item:4338}: сатиры Нефритового Пламени",

	-- Step 46: A Donation of Runecloth
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand · {zone:1423} Eastern Plaguelands · {area:2577} Dire Maul · {zone:1444} Feralas · {zone:1451} Silithus
	["{item:14047}: the Scarlet at {area:2266} in the {zone:1423}, the Gordok ogres outside {area:2577} in {zone:1444} and the Twilight camps of {zone:1451} drop it about one kill in three. The Auction House is faster if you have gold."] = "{item:14047}: Алые в {area:2266} в {zone:1423}, огры Гордок снаружи {area:2577} в {zone:1444} и лагеря Сумеречного Братства в {zone:1451} роняют её примерно с одного убийства из трёх. Аукцион быстрее, если у вас есть золото.",
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand
	["{item:14047}: the Scarlet outside {area:2266}"] = "{item:14047}: Алые снаружи {area:2266}",

	-- Step 47: Bloodvenom Post: Wild Guardians
	-- {npc:10306} Trull Failbane · {area:1997} Bloodvenom Post · {zone:1452} Winterspring · {zone:1448} Felwood
	["These quests are level 56 to 59, so they pay in full at 60. {npc:10306} stands at {area:1997}; the owlbeasts live in {zone:1452}, through the Timbermaw tunnel north of {zone:1448}."] = "Эти задания 56-59 уровней, поэтому на 60-м они оплачиваются полностью. {npc:10306} стоит у {area:1997}; совоястребы живут в {zone:1452}, через тоннель Древобрюхов севернее {zone:1448}.",

	-- Step 48: Winterspring: owlbeasts
	-- {zone:1452} Winterspring
	["{zone:1452}: owlbeasts"] = "{zone:1452}: совоястребы",
	-- {area:2255} Everlook
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast · Ragged Owlbeasts = {npc:7450} Ragged Owlbeast
	["Raging Owlbeasts north-west of {area:2255}, Ragged Owlbeasts further west."] = "Бешеные совухи северо-западнее {area:2255}, Лохматые совухи ещё западнее.",

	-- Step 49: Bloodvenom Post: hand in
	-- {area:1997} Bloodvenom Post
	["{area:1997}: hand in"] = "{area:1997}: сдать",

	-- Step 50: Winterspring: Moontouched Owlbeasts
	-- {zone:1452} Winterspring
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["{zone:1452}: Moontouched Owlbeasts"] = "{zone:1452}: Луноподобные совухи",
	-- {area:2255} Everlook
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Moontouched Owlbeasts north of {area:2255} and south of it."] = "Луноподобные совухи севернее {area:2255} и южнее него.",

	-- Step 51: Bloodvenom Post: hand in again
	-- {area:1997} Bloodvenom Post
	["{area:1997}: hand in again"] = "{area:1997}: сдать снова",

	-- Step 52: Winterspring: Berserk Owlbeasts
	-- {zone:1452} Winterspring
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["{zone:1452}: Berserk Owlbeasts"] = "{zone:1452}: Яростные совухи",
	-- {area:2255} Everlook · {item:12558} Blue-feathered Necklace · {quest:4882} Guarding Secrets
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["Most Berserk Owlbeasts are north of {area:2255}. A {item:12558} may drop from the owlbeasts now: use it to start {quest:4882}."] = "Большинство Яростных совухов севернее {area:2255}. С совухов теперь может упасть {item:12558}: используйте его, чтобы начать {quest:4882}.",

	-- Step 53: Bloodvenom Post: last hand-in
	-- {area:1997} Bloodvenom Post
	["{area:1997}: last hand-in"] = "{area:1997}: последняя сдача",
	-- {quest:4882} Guarding Secrets · {zone:1456} Thunder Bluff · {npc:5770} Nara Wildmane · {area:1639} Elder Rise
	["{quest:4882}, +100 {zone:1456}: to {npc:5770} on {area:1639} in {zone:1456}"] = "{quest:4882}, +100 {zone:1456}: к {npc:5770} на {area:1639} в {zone:1456}",
	-- {quest:4721} Wild Guardians · {faction:76} Orgrimmar
	["{quest:4721}: 300 {faction:76} reputation."] = "{quest:4721}: 300 репутации {faction:76}.",

	-- Step 54: Valormok: Betrayed
	-- {area:1237} Valormok · {zone:1447} Azshara · {quest:3505} Betrayed · {npc:8576} Ag'tor Bloodfist · {npc:4485} Belgrom Rockmaul
	["Fly to {area:1237} in western {zone:1447}: on Forever, {quest:3505} starts with {npc:8576} there, with no letter from {npc:4485} first. The {quest:3505} quests are level 53 and pay in full at 60 too, as every quest does in Forever. {npc:8576} sends you north-east to the blood elf camp on the bluffs of the northern peninsula."] = "Летите в {area:1237} на западе края {zone:1447}: на Forever задание {quest:3505} начинается прямо там, у NPC {npc:8576}, без предварительного письма от NPC {npc:4485}. Задания цепочки {quest:3505} – 53 уровня, и на 60 уровне за них тоже дают полную награду, как и за любое задание на Forever. {npc:8576} отправляет вас на северо-восток, к лагерю эльфов крови на утесах северного полуострова.",

	-- Step 55: Magus Rimtori's camp
	-- {npc:8578} Magus Rimtori
	["{npc:8578}'s camp"] = "Лагерь: {npc:8578}",
	-- {object:151286} Kaldorei Tome of Summoning · {npc:8578} Magus Rimtori
	["Kill the Reclaimers and Surveyors, then walk up to the book inside the ring of stone pillars. Read the {object:151286} there to start the next quest: break the crystals around the circle, kill the guard that comes, then {npc:8578}."] = "Убейте Возвращенцев и Геодезистов, затем подойдите к книге внутри кольца каменных столпов. Прочтите {object:151286} там, чтобы начать следующее задание: разбейте кристаллы вокруг круга, убейте пришедшего стража, затем {npc:8578}.",
	-- {npc:8578} Magus Rimtori
	["Find {npc:8578}'s camp"] = "Найдите лагерь {npc:8578}",
	-- {object:151286} Kaldorei Tome of Summoning
	["the {object:151286}"] = "{object:151286}",

	-- Step 56: Valormok and Orgrimmar
	-- {area:1237} Valormok · {faction:76} Orgrimmar
	["{area:1237} and {faction:76}"] = "{area:1237} и {faction:76}",
	-- {npc:4485} Belgrom Rockmaul · {faction:76} Orgrimmar
	["{npc:4485}, in {faction:76}"] = "{npc:4485}, в {faction:76}",
	-- {quest:3506} Betrayed · {faction:76} Orgrimmar
	["{quest:3506}: 300 {faction:76} reputation at 60."] = "{quest:3506}: 300 репутации {faction:76} на 60-м уровне.",

	-- Step 57: Blackrock Mountain, with a group
	["Blackrock Mountain, with a group"] = "Гора Черной Скалы, с группой",
	-- {area:340} Kargath · {zone:1418} Badlands · {faction:76} Orgrimmar · {area:1584} Blackrock Depths · {area:1583} Blackrock Spire · {quest:4724} The Pack Mistress · {item:12652} Bijou's Reconnaissance Report · {quest:4903} Warlord's Command · {npc:3144} Eitrigg
	["{area:340} in the {zone:1418} hands out {faction:76} quests for {area:1584} and {area:1583}, all level 58 to 60 and paid in full: Precarious Predicament and Operation: Death to Angerforge (150 each), {quest:4724} and {item:12652} (100 each), {quest:4903} (150), {npc:3144}'s Wisdom (100) and For The Horde! (Rend's head, 200 to every Horde city). These are dungeon quests: take them when your group goes."] = "{area:340} в {zone:1418} раздаёт задания {faction:76} для {area:1584} и {area:1583}, все 58-60 уровней и оплачиваются полностью: Шаткое положение и Операция: Смерть Гневной Кузне (по 150), {quest:4724} и {item:12652} (по 100), {quest:4903} (150), Мудрость {npc:3144} (100) и За Орду! (голова Ренда, 200 каждому городу Орды). Это задания подземелий: берите их, когда идёт ваша группа.",
	-- {npc:9077} Warlord Goretooth · {quest:4903} Warlord's Command
	["{npc:9077}: {quest:4903}, +150, a group of five"] = "{npc:9077}: {quest:4903}, +150, группа из пяти",
	-- {npc:9081} Galamav the Marksman · {quest:4724} The Pack Mistress
	["{npc:9081}: {quest:4724}, +100, a group of five"] = "{npc:9081}: {quest:4724}, +100, группа из пяти",

	-- Step 58: Additional Runecloth to Honored
	-- {quest:7832} Additional Runecloth
	["{quest:7832} to Honored"] = "{quest:7832} до уровня «Уважение»",
	-- {quest:7832} Additional Runecloth · {item:14047} Runecloth
	["{quest:7832}: 20 {item:14047} for 50 reputation, as often as you like. Friendly to Honored is 6,000: 120 hand-ins, 2,400 {item:14047}, less what the quests gave you (an orc starts at Friendly 1,000: 100 hand-ins; an Undead or Skyborne starts at Neutral 2,000 and first needs 20 hand-ins, 400 {item:14047}, to reach Friendly). Hand in every 20 you carry, one after another."] = "{quest:7832}: 20 {item:14047} за 50 репутации, сколько угодно раз. От «Дружелюбия» до «Уважения» — 6000: 120 сдач, 2400 {item:14047}, минус то, что дали задания (орк начинает с 1000 «Дружелюбия»: 100 сдач; нежить или Skyborne начинают с 2000 «Равнодушия» и сначала им нужно 20 сдач, 400 {item:14047}, чтобы достичь «Дружелюбия»). Сдавайте каждые 20, что несёте, одну за другой.",

	-- Step 59: Additional Runecloth to Revered
	-- {quest:7832} Additional Runecloth
	["{quest:7832} to Revered"] = "{quest:7832} до уровня «Почтение»",
	-- {item:14047} Runecloth
	["Honored to Revered is 12,000: 240 hand-ins, 4,800 {item:14047}. The Auction House price of a stack decides whether to farm or buy."] = "От «Уважения» до «Почтения» — 12000: 240 сдач, 4800 {item:14047}. Цена на аукционе за стопку решает, фармить или покупать.",

	-- Step 60: Additional Runecloth to Exalted
	-- {quest:7832} Additional Runecloth
	["{quest:7832} to Exalted"] = "{quest:7832} до уровня «Превознесение»",
	-- {item:14047} Runecloth · {faction:76} Orgrimmar · {npc:3362} Ogunaro Wolfrunner · {object:172958} Valley of Honor
	["Revered to Exalted is 21,000: 420 hand-ins, 8,400 {item:14047}. Raid heads pay too: The Lord of Blackrock (Nefarian) 200 to every Horde city and Victory for the Horde (Onyxia) 400 to {faction:76}. At Exalted, {npc:3362} in the {object:172958} sells the wolves to every Horde race: 20 gold for a level 40 wolf, 200 gold for a swift wolf at level 60 (Forever's prices); in Classic other races needed Exalted to buy them."] = "От «Почтения» до «Превознесения» — 21000: 420 сдач, 8400 {item:14047}. Головы с рейдов тоже считаются: Повелитель Черной Скалы (Нефариан) 200 каждому городу Орды и Победа за Орду (Ониксия) 400 {faction:76}. На «Превознесении» {npc:3362} в {object:172958} продаёт волков всем расам Орды: 20 золота за волка 40-го уровня, 200 золота за стремительного волка на 60-м (цены Forever); в Classic другим расам нужно было «Превознесение», чтобы их купить.",
	-- {npc:3362} Ogunaro Wolfrunner
	["{npc:3362}: the wolves"] = "{npc:3362}: волки",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Добыча здесь: адепты Тьмы ({npc:8546}) и темные маги (уровень 58-60); каждое убийство Плети здесь также дает репутацию ({object:92525}, см. тот гайд). Подойдет и аукцион.",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Добыча здесь: огры из клана Песчаного Молота (уровень 45-48). Подойдет и аукцион.",
	-- ["Keep handing in {quest:7832} until {faction:76} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Сдавайте задание {quest:7832}, пока репутация ({faction:76}) не дойдет до превознесения. {item:14047}: Адепты Тьмы и темные маги (уровень 58-60) – зона {zone:1423}, или аукцион.",
	-- ["Keep handing in {quest:7832}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Продолжайте сдавать: {quest:7832}, по 20 шт. ({item:14047}). {item:14047}: Адепты Тьмы и темные маги (уровень 58-60) – зона {zone:1423}, или аукцион.",
	-- ["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "Добыча здесь: кентавры из племени Колкар (уровень 30-33). Подойдет и аукцион.",
	-- ["Level 56-60 quests and {item:14047} to Exalted, with the old {zone:1411} quests as a fast extra if they still pay in full."] = "Задания 56-60 уровня и {item:14047} до превознесения; старые задания в зоне {zone:1411} – быстрое дополнение, если они еще дают полную награду.",
	-- ["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "Добыча здесь: {npc:3283} ({area:381}, уровень 16-17). Подойдет и аукцион.",
	-- ["{npc:14726} takes cloth for {faction:76} in {faction:76}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7832} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14726} принимает ткань для фракции {faction:76} (место: {faction:76}). Первые пожертвования шерсти, шелкового материала, магической ткани и предмета {item:14047} (по 60 шт.) делаются один раз и дают больше всего репутации за ткань; после них {quest:7832} повторяется до превознесения. Превознесение у города другой расы позволяет покупать транспорт этой расы. Бонус наследия Forever «Дипломат» ускоряет рост репутации.",
	-- ["{npc:14726}: {item:14047} delivered"] = "{npc:14726}: {item:14047} сдано",
	-- ["{quest:7832} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7832}: 20 шт. ({item:14047}) за сдачу, повторяется сколько угодно. Приносите {item:14047} партиями по 20 и сдавайте все сразу, одну сдачу за другой. {item:14047}: Адепты Тьмы и темные маги (уровень 58-60) – зона {zone:1423}, или аукцион.",
}
