-- Russian (ruRU): the guide forever/reputation/argent-dawn (forever/reputation/argent-dawn.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Argent Dawn Reputation"] = "Репутация: Серебряный Рассвет",
	-- {area:2057} Scholomance · {area:2279} Stratholme
	["Scourgestones, {area:2057} and {area:2279}: the shoulder resistance enchants and a dozen recipes."] = "Камни Плети, {area:2057} и {area:2279}: чары сопротивления для наплечников и десяток рецептов.",
	["Recipes for Tailors, Leatherworkers, Blacksmiths, Enchanters and Alchemists from Honored and Revered"] = "Рецепты для портных, кожевников, кузнецов, зачарователей и алхимиков на уровнях «Уважение» и «Почтение»",

	-- Step 1: Argent Dawn Commission (Alliance)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Alliance)"] = "{quest:5401} (Альянс)",
	-- {npc:10840} Argent Officer Pureheart · {area:3197} Chillwind Camp · {zone:1422} Western Plaguelands · {object:2160} The Argent Dawn · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel
	["{npc:10840} stands in {area:3197}, in the south of the {zone:1422}. {object:2160} starts at Neutral 200 for everyone. Wear the Commission trinket while you fight the Scourge: Scourgestones only drop while you wear it. {npc:11039} at {area:2268} gives the same Commission; you can only take one."] = "{npc:10840} стоит в месте {area:3197}, на юге зоны {zone:1422}. {object:2160} начинается с 200 очков «Равнодушия» для всех. Носите аксессуар Комиссии, пока сражаетесь с Плетью: камни Плети падают, только пока он надет. {npc:11039} в месте {area:2268} выдает ту же Комиссию; взять можно только одну.",

	-- Step 2: Argent Dawn Commission (Horde)
	-- {quest:5405} Argent Dawn Commission
	["{quest:5405} (Horde)"] = "{quest:5405} (Орда)",
	-- {npc:10839} Argent Officer Garush · {area:152} Bulwark · {zone:1420} Tirisfal Glades · {zone:1422} Western Plaguelands · {object:2160} The Argent Dawn · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel
	["{npc:10839} stands at the {area:152}, on the road from {zone:1420} into the {zone:1422}. {object:2160} starts at Neutral 200 for everyone. Wear the Commission trinket while you fight the Scourge: Scourgestones only drop while you wear it. {npc:11039} at {area:2268} gives the same Commission; you can only take one."] = "{npc:10839} стоит в месте {area:152}, на дороге из зоны {zone:1420} в зону {zone:1422}. {object:2160} начинается с 200 очков «Равнодушия» для всех. Носите аксессуар Комиссии, пока сражаетесь с Плетью: камни Плети падают, только пока он надет. {npc:11039} в месте {area:2268} выдает ту же Комиссию; взять можно только одну.",

	-- Step 3: Neutral to Friendly: Scourge of the Western Plaguelands
	-- {zone:1422} Western Plaguelands
	["Neutral to Friendly: Scourge of the {zone:1422}"] = "От «Равнодушия» до «Дружелюбия»: Плеть в зоне {zone:1422}",
	-- {area:199} Felstone Field · {area:200} Dalson's Tears · {area:202} Writhing Haunt · {area:201} Gahrron's Withering · {quest:5510} Minion's Scourgestones · {npc:10838} Commander Ashlam Valorfist · {area:3197} Chillwind Camp
	-- plural, as words: Scourge Cauldrons = {object:176392} Scourge Cauldron
	["Every Scourge kill in the Plaguelands gives 5 reputation (named ones 15), from the level 50 ghouls and skeletons up; at level 60 pick the level 53 and up ones, since in Classic grey mobs give only about a fifth. Neutral to Friendly is 2,800: about 560 kills, fewer with the Plaguelands quests on the way. The densest Scourge stand around the four Scourge Cauldrons: {area:199} west of Andorhal (skeletons, 50-53), {area:200} north of Andorhal (zombies and ghouls, 52-55), the {area:202} in the south (ghouls, 54-55) and {area:201} in the east (ghosts, 56-57). Keep every Scourgestone and every quest you can save: turn-ins never stop counting, kills do. {quest:5510} drop from about four in ten of these Scourge, Invader's from about a third of the level 56 and up ones. If you die, take the Commission off and put it back on: it can lose its effect. Paladins (Human and Dwarf): {npc:10838} at {area:3197} asks 20 {quest:5510} once for Dispelling Evil, 100 reputation instead of 25. The Legacy perk Diplomat adds up to 10% to every gain."] = "Каждое убийство Плети в Чумных землях дает 5 репутации (именованные — 15), начиная с гулей и скелетов 50-го уровня; на 60-м уровне берите тех, что 53-го и выше, потому что в Classic серые существа дают лишь около пятой части. От «Равнодушия» до «Дружелюбия» — 2800: примерно 560 убийств, меньше, если по пути брать задания Чумных земель. Самая густая Плеть стоит вокруг четырех котлов Плети: {area:199} к западу от Андорала (скелеты, 50-53), {area:200} к северу от Андорала (зомби и гули, 52-55), {area:202} на юге (гули, 54-55) и {area:201} на востоке (призраки, 56-57). Сохраняйте каждый камень Плети и каждое задание, которое можно отложить: сдача никогда не перестает считаться, а убийства — перестают. {quest:5510} падают примерно с четырех из десяти этой Плети, «Вторженцев» — примерно с трети тех, что 56-го уровня и выше. Если вы погибли, снимите Комиссию и наденьте снова: она может потерять эффект. Паладины (люди и дворфы): {npc:10838} в месте {area:3197} один раз просит 20 {quest:5510} для «Развеивания зла» — 100 репутации вместо 25. Наследие «Дипломат» добавляет до 10% к каждому приросту.",
	-- {quest:5510} Minion's Scourgestones
	["{quest:5510}: keep them"] = "{quest:5510}: сохраните их",
	-- {area:201} Gahrron's Withering
	-- plural, as words: Hungering Wraiths = {npc:1802} Hungering Wraith
	["Hungering Wraiths at {area:201}; any Scourge counts"] = "Алчущие призраки в месте {area:201}; считается любая Плеть",
	-- {area:202} Writhing Haunt
	-- plural, as words: Soulless Ghouls = {npc:1794} Soulless Ghoul
	["Soulless Ghouls at the {area:202}"] = "Бездушные вурдалаки в месте {area:202}",

	-- Step 4: Plaguelands quests and the Scourge Cauldrons
	-- plural, as words: Scourge Cauldrons = {object:176392} Scourge Cauldron
	["Plaguelands quests and the Scourge Cauldrons"] = "Задания Чумных земель и котлы Плети",
	-- {npc:11053} High Priestess MacDonnell · {area:3197} Chillwind Camp · {npc:11055} Shadow Priestess Vandis · {area:152} Bulwark · {npc:1852} Araj the Summoner · {area:2268} Light's Hope Chapel · {npc:11063} Carlin Redpath · {area:2262} Darrowshire · {npc:10926} Pamela Redpath · {npc:12250} Zaeldarr the Outcast · {npc:11038} Caretaker Alen · {npc:11056} Alchemist Arbington · {npc:11057} Apothecary Dithers · {item:13370} Vitreous Focuser · {item:14047} Runecloth · {area:201} Gahrron's Withering · {item:13354} Ectoplasmic Resonator
	-- plural, as words: Arcane Quickeners = {item:13320} Arcane Quickener
	["The Plaguelands quests pay in full at 60 from level 55 up and never stop counting, about 1,500 in all; the leveling guides walk them. The cauldron chain from {npc:11053} at {area:3197} (Horde: {npc:11055} at the {area:152}): 150 per cauldron with its return, then Mission Accomplished! 200. Alas, Andorhal 150 ({npc:1852}, elite). At {area:2268}, {npc:11063}'s {area:2262} quests (Brother Carlin 50 from Chromie in Andorhal, Villains of Darrowshire 100, Marauders of Darrowshire 100) and {npc:10926}'s Hidden Treasures 200 at the end of the {area:2262} story; {npc:12250} 75 from {npc:11038}. After Mission Accomplished!, each cauldron takes a repeatable delivery: 25 reputation every time, until Exalted. {npc:11056} at {area:3197} (Horde: {npc:11057} at the {area:152}) gives you a {item:13370}, without which the reagents never drop, and sells Arcane Quickeners for 50 silver (one per delivery; it crumbles after 30 minutes, so buy it last). Each delivery also takes 4 {item:14047}. Farm {area:201}: its ghosts drop an {item:13354} about one time in four, so about 16 kills fill a delivery; the other cauldrons want 5 or 6 reagents that drop one time in ten or less. Once the Plaguelands Scourge stop counting, this earns about four times what their Scourgestones alone do."] = "Задания Чумных земель с 55-го уровня на 60-м дают полную репутацию и никогда не перестают считаться — примерно 1500 всего; их проходят гайды по прокачке. Цепочка котлов от {npc:11053} в месте {area:3197} (Орда: {npc:11055} в месте {area:152}): 150 за котел с возвратом, затем «Миссия выполнена!» — 200. Увы, Андорал — 150 ({npc:1852}, элитный). В месте {area:2268} — задания {npc:11063} про {area:2262} (Брат Карлин — 50 от Хроми в Андорале, «Злодеи Дарроушира» — 100, «Мародеры Дарроушира» — 100) и «Сокровища Дарроушира» {npc:10926} — 200 в конце сюжета {area:2262}; {npc:12250} — 75 от {npc:11038}. После «Миссия выполнена!» каждый котел принимает повторяющуюся доставку: 25 репутации каждый раз, до «Превознесения». {npc:11056} в месте {area:3197} (Орда: {npc:11057} в месте {area:152}) выдает {item:13370}, без которого реагенты не падают, и продает чародейские ускорители за 50 серебра (один на доставку; он рассыпается через 30 минут, так что покупайте его последним). Каждая доставка также требует 4 {item:14047}. Фармите {area:201}: его призраки роняют {item:13354} примерно раз в четыре, так что на доставку хватает примерно 16 убийств; остальным котлам нужно 5 или 6 реагентов, которые падают не чаще одного раза в десять. Когда Плеть Чумных земель перестанет считаться, это принесет примерно в четыре раза больше, чем одни их камни.",
	-- {npc:11056} Alchemist Arbington · {item:13370} Vitreous Focuser
	["{npc:11056}: ask for a {item:13370}"] = "{npc:11056}: попросите {item:13370}",
	-- {npc:11057} Apothecary Dithers · {area:152} Bulwark · {item:13370} Vitreous Focuser
	["{npc:11057}, at the {area:152}: ask for a {item:13370}"] = "{npc:11057}, в месте {area:152}: попросите {item:13370}",
	-- plural, as words: Ectoplasmic Resonators = {item:13354} Ectoplasmic Resonator
	["Ectoplasmic Resonators: the ghosts around the cauldron"] = "Эктоплазматические резонаторы: призраки вокруг котла",
	-- {item:13320} Arcane Quickener
	["{item:13320}, 50 silver"] = "{item:13320}, 50 серебра",
	-- {area:201} Gahrron's Withering
	["the cauldron at {area:201}: handed in from its window, never in the log"] = "котел ({area:201}): сдается через его окно, в журнал не попадает",

	-- Step 5: Light's Hope Chapel quests
	-- {area:2268} Light's Hope Chapel
	["{area:2268} quests"] = "Задания места {area:2268}",
	-- {area:2268} Light's Hope Chapel · {zone:1423} Eastern Plaguelands · {faction:529} Argent Dawn · {npc:11039} Duke Nicholas Zverenhoff · {npc:11035} Betina Bigglezink · {npc:243252} Leonid Barthalomew · {area:2279} Stratholme · {area:2057} Scholomance · {object:176317} Argent Hold
	["{area:2268}, on the east side of the {zone:1423}, is the {faction:529}'s home: {npc:11039}, {npc:11035} and {npc:243252} give its dungeon quests, 100 to 200 reputation each and about 1,700 in all. They are group quests for {area:2279} and {area:2057} (level 58-60, five players): take the ones your group will run. The Duke's chain ends at the {object:176317}, a chest of {faction:529} gear."] = "Место {area:2268} на восточной стороне зоны {zone:1423} — дом {faction:529}: {npc:11039}, {npc:11035} и {npc:243252} выдают его задания подземелий, по 100-200 репутации, примерно 1700 всего. Это групповые задания для {area:2279} и {area:2057} (58-60 уровень, пять игроков): берите те, что ваша группа будет проходить. Цепочка герцога заканчивается у {object:176317} — сундука с экипировкой {faction:529}.",

	-- Step 6: Stratholme
	-- {area:2279} Stratholme · {zone:1423} Eastern Plaguelands · {npc:10440} Baron Rivendare · {item:12843} Corruptor's Scourgestone
	["{area:2279} is a group of five at the north end of the {zone:1423}. Its Scourge give 5 reputation a kill up to the last point of Honored, and its Scourge bosses 25 until Exalted ({npc:10440} 50), each with a {item:12843}. The Black Guard Sentries by the Baron give 5 until Exalted. The Scourge side, through the service entrance, pays far more than the Scarlet side."] = "{area:2279} — группа из пяти на северной оконечности зоны {zone:1423}. Ее Плеть дает 5 репутации за убийство до последней точки «Уважения», а ее боссы Плети — 25 до «Превознесения» ({npc:10440} — 50), каждый с {item:12843}. Караульные Черной Стражи у барона дают 5 до «Превознесения». Сторона Плети через служебный вход платит куда больше, чем Аля сторона.",
	-- plural, as words: Plagued Flesh Samples = {item:13174} Plagued Flesh Sample
	["Plagued Flesh Samples: the Scourge inside"] = "Образцы чумной плоти: Плеть внутри",
	-- {item:13180} Stratholme Holy Water
	["{item:13180}: the supply crates"] = "{item:13180}: ящики с припасами",
	-- {npc:10811} Archivist Galford
	["{npc:10811}, Scarlet side"] = "{npc:10811}, Алая сторона",
	-- {object:176245} Scarlet Archive
	["the {object:176245}: burn it, Scarlet side"] = "{object:176245}: сожгите его, Алая сторона",

	-- Step 7: Scholomance
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:13704} Skeleton Key · {faction:529} Argent Dawn · {quest:5508} Corruptor's Scourgestones · {npc:10508} Ras Frostwhisper · {npc:1853} Darkmaster Gandling
	["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}; your side's {area:2057} quests give the {item:13704} that opens it. It is the best {faction:529} run: its mobs give 5 up to the last point of Honored, and its thirteen bosses about 375 reputation a full clear plus ten or so {quest:5508} (about 250 more). {npc:10508} and {npc:1853} give 50 each."] = "{area:2057} лежит под {area:2298} — островным городом на юго-востоке зоны {zone:1422}; ваши задания {area:2057} дают {item:13704}, который его открывает. Это лучший забег {faction:529}: его существа дают 5 до последней точки «Уважения», а тринадцать боссов — примерно 375 репутации за полный зачист, плюс десяток {quest:5508} (еще примерно 250). {npc:10508} и {npc:1853} дают по 50.",
	-- {quest:5529} Plagued Hatchlings
	["{quest:5529}, in the hatchery"] = "{quest:5529}, в инкубаторе",

	-- Step 8: Back at Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Back at {area:2268}"] = "Снова здесь: {area:2268}",
	-- {quest:5212} The Flesh Does Not Lie · {quest:5213} The Active Agent · {item:13176} Scourge Data · {area:2279} Stratholme · {item:13209} Seal of the Dawn · {item:19812} Rune of the Dawn · {quest:5251} The Archivist · {item:13250} Head of Balnazzar · {npc:10440} Baron Rivendare · {item:13920} Healthy Dragon Scale · {quest:5529} Plagued Hatchlings · {npc:10267} Tinkee Steamboil · {zone:1428} Burning Steppes · {area:1583} Blackrock Spire · {npc:243252} Leonid Barthalomew · {npc:11035} Betina Bigglezink · {item:12368} Dawn's Gambit · {area:2057} Scholomance
	["{quest:5212} leads to {quest:5213} (the {item:13176} in a {area:2279} ziggurat), which rewards the {item:13209} or the {item:19812}: better trinkets that also make Scourgestones drop, so they can replace the Commission. {quest:5251} leads on to the {item:13250} and {npc:10440}. A {item:13920}, a rare drop (about 6%) from the {quest:5529} once {quest:5529} is done, starts a quest worth 50 each time: keep them until Revered. {npc:10267} in the {zone:1428}, at the end of her {area:1583} quests, sends you to {npc:243252} (75) and on to {npc:11035}'s {item:12368} in {area:2057} (25 and 200)."] = "{quest:5212} ведет к {quest:5213} ({item:13176} в зиггурате {area:2279}), которое награждает {item:13209} или {item:19812}: лучшие аксессуары, которые также заставляют падать камни Плети, так что могут заменить Комиссию. {quest:5251} ведет к {item:13250} и {npc:10440}. {item:13920} — редкая добыча (около 6%) с {quest:5529}, как только {quest:5529} выполнено, — запускает задание на 50 каждый раз: сохраняйте их до «Почтения». {npc:10267} в зоне {zone:1428}, в конце ее заданий {area:1583}, отправляет к {npc:243252} (75) и далее к {item:12368} от {npc:11035} в {area:2057} (25 и 200).",

	-- Step 9: Friendly to Honored: stones and named Scourge
	["Friendly to Honored: stones and named Scourge"] = "От «Дружелюбия» до «Уважения»: камни и именованная Плеть",
	-- {npc:10826} Lord Darkscythe · {npc:10821} Hed'mush the Rotting · {npc:10825} Gish the Unmoving · {area:2057} Scholomance · {area:2279} Stratholme · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel · {area:3197} Chillwind Camp · {area:152} Bulwark · {item:12844} Argent Dawn Valor Token · {quest:5509} Invader's Scourgestones · {area:2272} Northdale · {item:12843} Corruptor's Scourgestone · {npc:1850} Putridius
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept · Dread Weavers = {npc:8528} Dread Weaver · Scourge Champions = {npc:8529} Scourge Champion · Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Normal Scourge outside the dungeons stop giving reputation halfway through Friendly (3,000 of 6,000); {npc:10826}, {npc:10821} and {npc:10825} stop at the end of Friendly. After that only Araj, the {area:2057} and {area:2279} mobs, the cauldron deliveries and Scourgestones count. Now turn in the stones you saved: {npc:11039} at {area:2268} takes all three kinds, and so do the officers at {area:3197} and the {area:152}. Every turn-in pays 25 and an {item:12844}: keep 35 tokens for the mantles at Revered and Exalted. {quest:5509} are worth twice as much per stone: the Dark Adepts, Shadowmages, Dread Weavers and Scourge Champions (level 58-60) at {area:2272}, just north of {area:2268}, drop them about a third of the time or more, next to the turn-in. The named Scourge below drop a {item:12843} half the time or more ({npc:1850} two times in three, Araj and {npc:10821} half the time) and give 15 a kill, Araj until Exalted; {npc:1850} gives no reputation, only the stone. Friendly opens the Enriched Manna Biscuits (60 silver) at the quartermasters."] = "Обычная Плеть вне подземелий перестает давать репутацию на середине «Дружелюбия» (3000 из 6000); {npc:10826}, {npc:10821} и {npc:10825} — в конце «Дружелюбия». После этого считаются только Арадж, существа {area:2057} и {area:2279}, доставки котлов и камни Плети. Теперь сдайте сохраненные камни: {npc:11039} в месте {area:2268} принимает все три вида, как и офицеры в месте {area:3197} и {area:152}. Каждая сдача дает 25 и {item:12844}: сохраните 35 жетонов на мантии для «Почтения» и «Превознесения». {quest:5509} стоят вдвое больше за камень: Адепты Тьмы, Теневые маги, Ужасные ткачи и Воители Плети (58-60 уровень) в месте {area:2272}, прямо к северу от {area:2268}, роняют их примерно в трети случаев или чаще, рядом со сдачей. Именованная Плеть ниже роняет {item:12843} в половине случаев или чаще ({npc:1850} — два раза из трех, Арадж и {npc:10821} — в половине) и дает 15 за убийство, Арадж — до «Превознесения»; {npc:1850} не дает репутации, только камень. «Дружелюбие» открывает витаминизированное печенье из манны (60 серебра) у интендантов.",
	-- {item:12843} Corruptor's Scourgestone
	["{item:12843}: the named Scourge below, and dungeon bosses"] = "{item:12843}: именные существа Плети ниже и боссы подземелий",
	-- {area:2272} Northdale
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Dark Adepts and Shadowmages at {area:2272}"] = "Адепты Тьмы и Теневые маги в месте {area:2272}",
	-- {npc:1852} Araj the Summoner
	["{npc:1852}, Andorhal"] = "{npc:1852}, Андорал",
	-- {npc:1850} Putridius · {zone:1422} Western Plaguelands
	["{npc:1850}, {zone:1422}: the stone only"] = "{npc:1850}, {zone:1422}: только камень",
	-- {quest:5510} Minion's Scourgestones
	["{quest:5510}: 20 for 25 reputation"] = "{quest:5510}: 20 за 25 репутации",
	-- {quest:5509} Invader's Scourgestones
	["{quest:5509}: 10 for 25 reputation"] = "{quest:5509}: 10 за 25 репутации",
	-- {quest:5508} Corruptor's Scourgestones
	["{quest:5508}: 1 for 25 reputation"] = "{quest:5508}: 1 за 25 репутации",

	-- Step 10: Honored to Revered: dungeons and stones
	["Honored to Revered: dungeons and stones"] = "От «Уважения» до «Почтения»: подземелья и камни",
	-- {area:2057} Scholomance · {area:2279} Stratholme · {quest:5509} Invader's Scourgestones · {npc:11536} Quartermaster Miranda Breechlock · {area:2268} Light's Hope Chapel · {npc:10857} Argent Quartermaster Lightspark · {area:3197} Chillwind Camp · {npc:10856} Argent Quartermaster Hasana · {area:152} Bulwark · {item:22014} Hallowed Brazier
	["Honored to Revered is 12,000: about 2,400 {area:2057} and {area:2279} mobs, fewer with their bosses. Their mobs stop at 11,999 of 12,000 Honored; a boss or a turn-in takes you over. Solo, only Scourgestones, the cauldron deliveries and Araj count: 12,000 is 480 turn-ins, or 4,800 {quest:5509}. Keep the stones you get in the dungeons until their mobs stop counting. Honored opens recipes at all three quartermasters: {npc:11536} at {area:2268}, {npc:10857} at {area:3197}, {npc:10856} at the {area:152}. Also the {item:22014} (133 gold) for the Three Kings of Flame quest."] = "От «Уважения» до «Почтения» — 12000: примерно 2400 существ {area:2057} и {area:2279}, меньше с их боссами. Их существа останавливаются на 11999 из 12000 «Уважения»; босс или сдача выводят вас дальше. Соло считаются только камни Плети, доставки котлов и Арадж: 12000 — это 480 сдач или 4800 {quest:5509}. Сохраняйте камни, добытые в подземельях, пока их существа не перестанут считаться. «Уважение» открывает рецепты у всех трех интендантов: {npc:11536} в месте {area:2268}, {npc:10857} в месте {area:3197}, {npc:10856} в месте {area:152}. А также {item:22014} (133 золота) для задания «Три властелина огня».",
	-- {item:19446} Formula: Enchant Bracer - Mana Regeneration
	["{item:19446}, 3 gold"] = "{item:19446}, 3 золота",
	-- {item:19216} Pattern: Argent Boots · {skill:197} Tailoring
	["{item:19216} ({skill:197}), 2 gold 20 silver"] = "{item:19216} ({skill:197}), 2 золота 20 серебра",
	-- {item:19328} Pattern: Dawn Treaders · {skill:165} Leatherworking
	["{item:19328} ({skill:165}), 2 gold 20 silver"] = "{item:19328} ({skill:165}), 2 золота 20 серебра",
	-- {item:19203} Plans: Girdle of the Dawn · {skill:164} Blacksmithing
	["{item:19203} ({skill:164}), 2 gold 20 silver"] = "{item:19203} ({skill:164}), 2 золота 20 серебра",
	-- {item:13482} Recipe: Transmute Air to Fire · {skill:171} Alchemy
	["{item:13482} ({skill:171}), 1 gold 50 silver"] = "{item:13482} ({skill:171}), 1 золото 50 серебра",
	-- {item:19442} Formula: Powerful Anti-Venom · {skill:129} First Aid
	["{item:19442} ({skill:129}), 10 gold"] = "{item:19442} ({skill:129}), 10 золота",

	-- Step 11: Mantles of the Dawn
	-- {npc:11536} Quartermaster Miranda Breechlock · {quest:5513} Mantles of the Dawn · {faction:529} Argent Dawn · {item:18173} Shadow Mantle of the Dawn · {item:13810} Blessed Sunfruit
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["At Revered, {npc:11536} takes 10 Argent Dawn Valor Tokens for {quest:5513} (100 reputation). After it, any {faction:529} quartermaster sells the five shoulder enchants for 10 gold each: Flame, Frost, Arcane, Nature and {item:18173}, +5 to that resistance. Revered also opens the {item:13810} and its juice (60 silver) and the Revered recipes."] = "На «Почтении» {npc:11536} принимает 10 знаков доблести Серебряного Рассвета для {quest:5513} (100 репутации). После этого любой интендант {faction:529} продает пять чар для наплечников по 10 золота: Огонь, Лед, Тайная магия, Природа и {item:18173}, +5 к соответствующему сопротивлению. «Почтение» также открывает {item:13810} и его сок (60 серебра) и рецепты «Почтения».",
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["Argent Dawn Valor Tokens, from the stone turn-ins"] = "Знаки доблести Серебряного Рассвета, с сдачи камней",
	-- {item:18170} Frost Mantle of the Dawn
	["{item:18170}: pick the resistance you need, 10 gold"] = "{item:18170}: выберите нужное сопротивление, 10 золота",
	-- {item:19447} Formula: Enchant Bracer - Healing
	["{item:19447}, 6 gold"] = "{item:19447}, 6 золота",
	-- {item:19217} Pattern: Argent Shoulders · {skill:197} Tailoring
	["{item:19217} ({skill:197}), 4 gold"] = "{item:19217} ({skill:197}), 4 золота",
	-- {item:19329} Pattern: Golden Mantle of the Dawn · {skill:165} Leatherworking
	["{item:19329} ({skill:165}), 4 gold"] = "{item:19329} ({skill:165}), 4 золота",
	-- {item:19205} Plans: Gloves of the Dawn · {skill:164} Blacksmithing
	["{item:19205} ({skill:164}), 4 gold"] = "{item:19205} ({skill:164}), 4 золота",

	-- Step 12: Revered to Exalted
	["Revered to Exalted"] = "От «Почтения» до «Превознесения»",
	-- {quest:5508} Corruptor's Scourgestones · {area:2057} Scholomance · {item:13920} Healthy Dragon Scale
	["Revered to Exalted is 21,000: 840 Scourgestone or cauldron turn-ins, or the dungeon bosses with their {quest:5508} (a full {area:2057} clear is about 600). Turn in every stone and {item:13920} you saved."] = "От «Почтения» до «Превознесения» — 21000: 840 сдач камней Плети или котлов, либо боссы подземелий с их {quest:5508} (полный зачист {area:2057} — примерно 600). Сдайте каждый сохраненный камень и {item:13920}.",

	-- Step 13: Chromatic Mantle of the Dawn
	-- {npc:11536} Quartermaster Miranda Breechlock · {quest:5517} Chromatic Mantle of the Dawn
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["At Exalted, {npc:11536} takes 25 Argent Dawn Valor Tokens for the {quest:5517} (150 reputation): +5 to every resistance, on your shoulders. After it, the quartermasters sell more for 40 gold each."] = "На «Превознесении» {npc:11536} принимает 25 знаков доблести Серебряного Рассвета для {quest:5517} (150 репутации): +5 ко всем сопротивлениям, на наплечниках. После этого интенданты продают больше по 40 золота.",
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["Argent Dawn Valor Tokens"] = "Знаки доблести Серебряного Рассвета",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop Invader's Scourgestones here, along with Minion's stones and {item:14047}. Hand Invader's in 10 at a time and Minion's 20 at a time to {npc:11039} at {area:2268}. In Classic both stop giving reputation at Honored."] = "Адепты Тьмы ({npc:8546}) и темные маги (уровень 58-60) роняют здесь {item:12841}, а также камни приспешников и {item:14047}. Сдавайте камни захватчиков по 10, а камни приспешников по 20: {npc:11039} – {area:2268}. В Classic и те и другие перестают давать репутацию на уровне «Уважение».",
	-- ["From Honored on, Corruptor's Scourgestones (one per turn-in) and Scourge kills in {area:2279} and {area:2057} carry the reputation. Corruptor's stones drop from the Scourge bosses there ({npc:1853}, {npc:10433}, Vectus) and from {npc:1852} and Putridius in {zone:1422}. Many dungeon runs pay off faster than any open-world farm."] = "С уровня «Уважение» репутацию дают {item:12843} (по одному за сдачу) и убийства Плети: {area:2279} и {area:2057}. Камни осквернителей падают с боссов Плети там ({npc:1853}, {npc:10433}, Вектус), а также с NPC {npc:1852} и Гнилиуса (зона {zone:1422}). Многократные походы в подземелья окупаются быстрее любого фарма в открытом мире.",
	-- ["Ghouls and skeletons all over {zone:1422} drop Minion's Scourgestones about half the time; this cluster is dense. Hand them in 20 at a time to any Argent Officer (Pureheart at {area:3197}, Garush at {area:152}, {npc:11039} at {area:2268}). Each turn-in also pays an {item:12844} for the Argent quartermasters."] = "Вурдалаки и скелеты по всей зоне {zone:1422} примерно в половине случаев роняют: {item:12840}; здесь они встречаются густо. Сдавайте по 20 любому офицеру Серебряного Рассвета (Чистосердая – {area:3197}, Гаруш – {area:152}, {npc:11039} – {area:2268}). Каждая сдача также дает {item:12844} для интендантов Серебряного Рассвета.",
	-- ["Invader's Scourgestones to Honored"] = "Камни захватчиков Плети ({item:12841}) до уровня «Уважение»",
	-- ["Keep running {area:2279} and {area:2057} and turning in every {item:12843} at {area:2268} until Exalted."] = "Проходите {area:2279} и {area:2057} и сдавайте каждый {item:12843} ({area:2268}) до превознесения.",
	-- ["Minion's Scourgestones to Friendly"] = "Камни приспешников Плети ({item:12840}) до уровня «Дружелюбие»",
	-- ["Run {area:2279} (both wings) and {area:2057}, killing every Scourge you pass."] = "Проходите {area:2279} (обе части) и {area:2057}, убивая всю Плеть на пути.",
	-- ["{faction:529} to Exalted"] = "{faction:529} до уровня «Превознесение»",
	-- ["{object:2160} starts out Neutral. Take the Commission from {npc:10839} at {area:152} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "{object:2160}: начальная репутация – равнодушие. Возьмите жетон у NPC {npc:10839} ({area:152}) и наденьте: в Classic камни Плети падают, только пока надет аксессуар {quest:5401}. Бонус наследия Forever «Дипломат» ускоряет рост репутации.",
	-- ["{object:2160} starts out Neutral. Take the Commission from {npc:10840} at {area:3197} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "{object:2160}: начальная репутация – равнодушие. Возьмите жетон у NPC {npc:10840} ({area:3197}) и наденьте: в Classic камни Плети падают, только пока надет аксессуар {quest:5401}. Бонус наследия Forever «Дипломат» ускоряет рост репутации.",
	-- ["{quest:5401} (Horde)"] = "{quest:5401} (Орда)",
}
