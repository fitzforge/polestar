-- Russian (ruRU): the guide forever/40-50/shendralas (forever/40-50/shendralas.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1444} Feralas
	["About a dozen quests on a short trip into Forever's new zone (about 45-46 for the Alliance, 47 for the Horde), then on to {zone:1444}."] = "Около дюжины заданий за короткую вылазку в новую зону Forever (примерно 45-46 для Альянса, 47 для Орды), затем дальше в край {zone:1444}.",

	-- Step 1: North into Desolace
	-- {area:405} Desolace
	["North into {area:405}"] = "На север: {area:405}",
	-- {zone:2652} Shen'dralas · {area:405} Desolace · {area:2657} Valley of Bones · {area:1099} Camp Mojache · {area:2577} Dire Maul
	["New in Forever: this guide follows what players did in {zone:2652}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\n{zone:2652} lies south of {area:405}, through the {area:2657}, and has no flight path of its own. From {area:1099} ride north-west on the road past {area:2577} and on north into {area:405}: the road comes out on {area:405}'s southern edge."] = "Новое в Forever: этот гайд повторяет то, что делали игроки здесь: {zone:2652}. Если шаг неверен, сообщите нам в Discord или на GitHub Polestar и назовите шаг.\n{zone:2652} лежит к югу от края {area:405}, через место {area:2657}, и своего маршрута полета не имеет. От места {area:1099} езжайте на северо-запад по дороге мимо места {area:2577} и дальше на север: {area:405}. Дорога выходит к южному краю зоны {area:405}.",
	-- {area:405} Desolace · {zone:1444} Feralas
	["{area:405}, where the road from {zone:1444} comes in"] = "{area:405}, там, где входит дорога из края {zone:1444}",

	-- Step 2: Fly to Shadowprey Village
	-- {area:2408} Shadowprey Village
	["Fly to {area:2408}"] = "Летите сюда: {area:2408}",
	-- {zone:2652} Shen'dralas · {area:405} Desolace · {area:2657} Valley of Bones · {zone:1454} Orgrimmar · {object:3202} Grom'gol · {zone:1458} Undercity
	["New in Forever: this guide follows what players did in {zone:2652}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\n{zone:2652} lies south of {area:405}, through the {area:2657}, and has no flight path of its own. Its quests are for levels 41-45. Coming from the Eastern Kingdoms, take the zeppelin to {zone:1454} first (from {object:3202} or the {zone:1458})."] = "Новое в Forever: этот гайд повторяет то, что делали игроки здесь: {zone:2652}. Если шаг неверен, сообщите нам в Discord или на GitHub Polestar и назовите шаг.\n{zone:2652} лежит к югу от края {area:405}, через место {area:2657}, и своего маршрута полета не имеет. Задания здесь для уровней 41-45. Если вы в Восточных королевствах, сначала летите на дирижабле в {zone:1454} (из места {object:3202} или из города {zone:1458}).",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Распорядитель полетов: {zone:1454}",

	-- Step 3: Fly to Nijel's Point
	-- {area:608} Nijel's Point
	["Fly to {area:608}"] = "Летите сюда: {area:608}",
	-- {zone:2652} Shen'dralas · {area:405} Desolace · {area:2657} Valley of Bones · {area:150} Menethil Harbor
	["New in Forever: this guide follows what players did in {zone:2652}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\n{zone:2652} lies south of {area:405}, through the {area:2657}, and has no flight path of its own. Its quests are for levels 41-45. Coming from the Eastern Kingdoms, take the boat from {area:150} to Theramore first."] = "Новое в Forever: этот гайд повторяет то, что делали игроки здесь: {zone:2652}. Если шаг неверен, сообщите нам в Discord или на GitHub Polestar и назовите шаг.\n{zone:2652} лежит к югу от края {area:405}, через место {area:2657}, и своего маршрута полета не имеет. Задания здесь для уровней 41-45. Если вы в Восточных королевствах, сначала плывите на корабле из места {area:150} в Терамор.",

	-- Step 4: Into the Valley of Bones
	-- {area:2657} Valley of Bones
	["Into the {area:2657}"] = "Вперед: {area:2657}",
	-- {area:405} Desolace · {area:2408} Shadowprey Village · {area:606} Gelkis Village · {area:2657} Valley of Bones · {area:16651} Shen'dralas
	["Ride east along {area:405}'s southern edge (from {area:2408}: past {area:606}): the {area:2657} opens there into {area:16651}."] = "Езжайте на восток вдоль южного края зоны {area:405} (от места {area:2408}: мимо места {area:606}): там {area:2657} открывается в зону {area:16651}.",

	-- Step 5: Into the Valley of Bones
	-- {area:608} Nijel's Point · {area:405} Desolace · {area:604} Magram Village · {area:2657} Valley of Bones · {area:16651} Shen'dralas
	["Ride south from {area:608} down the road through eastern {area:405} to {area:604}: just past its western edge the path climbs into the {area:2657} and {area:16651}."] = "Езжайте на юг от места {area:608} по дороге через восточную часть края {area:405} к месту {area:604}: сразу за его западным краем тропа поднимается – {area:2657}, а затем {area:16651}.",

	-- Step 6: The Valley of Bones: a Tattered Journal
	-- {area:2657} Valley of Bones · {quest:93644} Tattered Journal
	["The {area:2657}: a {quest:93644}"] = "{area:2657}: {quest:93644}",
	-- {quest:93644} Tattered Journal · {zone:2652} Shen'dralas · {area:2657} Valley of Bones
	-- plural, as words: Outcast Necromancers = {npc:11559} Outcast Necromancer · Magram Necromancers = {npc:253272} Magram Necromancer
	-- was: ["New in Forever: if a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\nThe Outcast Necromancers and the Magram Necromancers of the valley drop a {quest:93644} whose writer lives in {zone:2652}: players got it within a few kills. The Magram centaurs leave you be until you attack; the Magram Necrokhans among them (level 45) are elites: leave them be.\nThe Gelkis and Magram centaurs have {area:2657} quest chains of their own, worth about 20,000 to 30,000 more experience, but each chain asks for Honored with its clan. The two clans are rivals, so work for one of them: the Gelkis and Magram Centaur Reputation guide, under Reputation, shows how."] = "Новое в Forever: если шаг неверен, сообщите нам в Discord или на GitHub Polestar и назовите шаг.\nИзгнанные некромантки и некроманты Маграмов в долине роняют предмет «{quest:93644}», автор которого живет здесь: {zone:2652}. Игроки получали его за несколько убийств. Кентавры Маграмов не трогают вас, пока вы не нападете; некроханы Маграмов среди них (уровень 45) – элита: не трогайте их.\nУ кентавров Гелкис и Маграмов есть свои цепочки заданий ({area:2657}), еще около 20 000-30 000 опыта, но каждая требует уровня «Уважение» у своего клана. Кланы враждуют, так что работайте на один из них: как – описано в гайде «Репутация у кентавров Гелкис и Маграмов» в разделе «Репутация»."
	["New in Forever: if a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\nThe Outcast Necromancers and the Magram Necromancers of the valley drop a {quest:93644} whose writer lives in {zone:2652}: players got it within a few kills. Take it from the Outcast Necromancers and leave the Magram alone: the Magram centaurs leave you be until you attack, but once you have killed Magram the whole clan turns on you, and their Necrokhans (level 45, elites) stand around the western pylon you repair later.\nThe Gelkis and Magram centaurs have {area:2657} quest chains of their own, worth about 20,000 to 30,000 more experience, but each chain asks for Honored with its clan. The two clans are rivals, so work for one of them: the Gelkis and Magram Centaur Reputation guide, under Reputation, shows how."] = "",

	-- Step 7: The western pylon
	["The western pylon"] = "Западный пилон",
	-- {quest:92914} Strange Pylons
	-- plural, as words: Decrepit Pylon Protectors = {npc:252711} Decrepit Pylon Protector · Magram Necrokhans = {npc:253274} Magram Necrokhan
	["East through the valley to the strange crystal on its pedestal: clicking it starts {quest:92914}. The Decrepit Pylon Protectors (levels 42-43) around it are the mana elementals that guard it. Corpsefeeders (level 45, elite) roam the valley east of here.\nCareful: click the crystal from the road on its west side and move on: the Protectors stand two and three together east and north-east of it, where Corpsefeeders and the Magram Necrokhans (elites, 45) walk too."] = "",

	-- Step 8: Bristleback Retreat: the eastern pylon
	-- {area:16677} Bristleback Retreat
	["{area:16677}: the eastern pylon"] = "{area:16677}: восточный пилон",
	-- {area:16677} Bristleback Retreat · {npc:253527} Kog'thug the Brave
	["East along the valley road to the quilboar of {area:16677}: the second pylon stands at the eastern end of their camp. A Corpsefeeder (level 45, elite) walks this road: let it pass. The Bristlebacks (levels 42-43) attack on sight; {npc:253527} (level 43, elite) and his bodyguards hold the south side of the camp."] = "На восток по дороге через долину к кабанолюдям ({area:16677}): второй пилон стоит в восточном конце их лагеря. По этой дороге ходит трупоед (уровень 45, элита): пропустите его. Щетиноспины (уровни 42-43) нападают сразу; {npc:253527} (уровень 43, элита) и его телохранители удерживают южную часть лагеря.",
	["the eastern pylon"] = "восточный пилон",

	-- Step 9: The temple of Shen'dralas: the third pylon
	-- {zone:2652} Shen'dralas
	["The temple of {zone:2652}: the third pylon"] = "Храм ({zone:2652}): третий пилон",
	["South to the Shen'dralar temple at the zone's heart, keeping west of Kog'thug's bodyguards: the third pylon stands inside. The temple's guards are neutral: leave them be."] = "На юг к храму Шен'дралар в сердце зоны, держась западнее телохранителей Ког'туга: третий пилон стоит внутри. Стражи храма нейтральны: не трогайте их.",

	-- Step 10: Evenshade's Overlook
	-- {npc:253471} Mordent Evenshade · {quest:93644} Tattered Journal
	["North-west from the temple to {npc:253471}'s camp on the overlook, beside the spirit healer: the {quest:93644} is his, and he wants to hear about the pylons."] = "На северо-запад от храма к лагерю на смотровой площадке, рядом с целителем душ, – там {npc:253471}: предмет «{quest:93644}» принадлежит ему, и он хочет услышать о пилонах.",

	-- Step 11: North into Desolace
	-- {npc:253471} Mordent Evenshade · {area:405} Desolace · {area:604} Magram Village
	["{npc:253471} wants a fragment and a shard of the pylons back from {area:405}'s two centaur villages: {area:604} lies just beyond the valley's northern way out.\nCareful: if you have killed Magram or Gelkis centaurs, that clan's guards may attack you when you walk into its village."] = "{npc:253471} просит вернуть фрагмент и осколок пилонов из двух деревень кентавров в краю {area:405}: {area:604} лежит сразу за северным выходом из долины.\nОсторожно: если вы убивали кентавров Маграм или Гелкис, стражи этого племени могут напасть на вас, когда вы войдете в их деревню.",

	-- Step 12: Magram Village
	-- {item:255656} Pylon Fragment
	-- plural, as words: Magram Guardians = {npc:255560} Magram Guardian
	["The {item:255656} lies at the western edge of the village; Magram Guardians (levels 39-41) watch over it. They leave you be unless you have fought the Magram: pick the fragment up without a fight. Every Magram you kill turns the clan against you, and back in the valley that means the Necrokhans (level 45, elites) at the western pylon as well."] = "",

	-- Step 13: Gelkis Village
	-- {area:405} Desolace · {area:606} Gelkis Village · {item:255657} Pylon Shard
	-- plural, as words: Gelkis Guardians = {npc:255561} Gelkis Guardian
	["West along {area:405}'s southern edge to {area:606}: the {item:255657} lies at its southern end, watched by Gelkis Guardians (levels 39-41)."] = "На запад вдоль южного края зоны {area:405} к месту {area:606}: {item:255657} лежит в его южной части, его охраняют стражи Гелкис (уровни 39-41).",

	-- Step 14: Back into the Valley of Bones
	-- {area:2657} Valley of Bones
	["Back into the {area:2657}"] = "Обратно: {area:2657}",
	-- {area:405} Desolace · {area:2657} Valley of Bones · {area:16651} Shen'dralas
	["East again along {area:405}'s southern edge: the {area:2657} opens into {area:16651}."] = "Снова на восток вдоль южного края зоны {area:405}: {area:2657} выходит к месту {area:16651}.",

	-- Step 16: The temple: the Mana Sieve
	-- {item:255662} Mana Sieve
	["The temple: the {item:255662}"] = "Храм: {item:255662}",
	-- {npc:253471} Mordent Evenshade · {item:255662} Mana Sieve · {npc:255486} Historian Biraxas · {quest:96018} Powering the Pylons
	-- plural, as words: Unstable Mana Rifts = {npc:264149} Unstable Mana Rift
	["{npc:253471} sends you for the {item:255662}, kept inside the temple beside {npc:255486}. {quest:96018} asks you to gather mana with the Sieve before you repair the pylons: with it in your bags you can handle the Unstable Mana Rifts, the floating sparks of mana all along the road north."] = "{npc:253471} отправляет вас за предметом {item:255662}, который хранится в храме рядом с NPC {npc:255486}. {quest:96018}: перед ремонтом пилонов нужно собрать ману Фильтром. Когда он у вас в сумках, можно взаимодействовать с нестабильными разломами маны – парящими искрами маны вдоль всей дороги на север.",

	-- Step 17: Unstable Mana Rifts: mana for the western pylon
	-- plural, as words: Unstable Mana Rifts = {npc:264149} Unstable Mana Rift
	["Unstable Mana Rifts: mana for the western pylon"] = "",
	-- {item:255662} Mana Sieve
	-- plural, as words: Unstable Mana Rifts = {npc:264149} Unstable Mana Rift · Coalesced Mana Crystals = {item:255667} Coalesced Mana Crystal
	["Use the {item:255662} on the Unstable Mana Rifts, the floating sparks along the road north: each pylon takes four Coalesced Mana Crystals, and the repair uses them up."] = "",
	-- {item:255667} Coalesced Mana Crystal · {item:255662} Mana Sieve
	-- plural, as words: Unstable Mana Rifts = {npc:264149} Unstable Mana Rift
	["{item:255667}, from the Unstable Mana Rifts with the {item:255662}"] = "",

	-- Step 18: The road south of the western pylon
	["The road south of the western pylon"] = "",
	-- {npc:252711} Decrepit Pylon Protector · {spell:1289727} Repair and Recharge Pylon
	-- plural, as words: Unstable Mana Rifts = {npc:264149} Unstable Mana Rift · Magram Necrokhans = {npc:253274} Magram Necrokhan · Nascent Pylon Protectors = {npc:276401} Nascent Pylon Protector
	["North up the road to the first pylon, gathering mana from the Unstable Mana Rifts on the way. Stop where the arrow points, on the road just south of the pylon, keeping to its west edge: the quiet side, with no Protectors behind you. Pull one {npc:252711} at a time down to that spot, the one nearest the pylon's south side first, and kill it there; then step up to the pylon's west side and use {spell:1289727}, as players did to repair it.\nCareful: stay off the pylon's east and north-east side. The Protectors stand there two and three together, a Corpsefeeder (level 45, elite) walks among them and the Magram Necrokhans (elites, 45) stand just beyond: nearly every recorded death at this pylon happened east of it. If the Magram attack you (they do once you have killed Magram), wait at the arrow until any Necrokhan by the pylon walks off before you pull. Nascent Pylon Protectors (elites, 43) wander the road south of it: let them pass.\nIf you die here, walk your ghost back to the arrow before you come back to life: players who rose beside the pylon died again within seconds."] = "",
	["the road just south of the western pylon"] = "",

	-- Step 19: The western pylon: repair it
	["The western pylon: repair it"] = "Западный пилон: почините его",
	["Pull a single Protector down to the road, then repair the pylon from its west side."] = "",
	-- {npc:252711} Decrepit Pylon Protector · {spell:1289727} Repair and Recharge Pylon
	["{npc:252711}, pulled to the arrow's spot, then {spell:1289727} on the pylon's west side"] = "",

	-- Step 20: Unstable Mana Rifts: mana for the eastern pylon
	-- plural, as words: Unstable Mana Rifts = {npc:264149} Unstable Mana Rift
	["Unstable Mana Rifts: mana for the eastern pylon"] = "",
	-- {item:255662} Mana Sieve
	-- plural, as words: Unstable Mana Rifts = {npc:264149} Unstable Mana Rift · Coalesced Mana Crystals = {item:255667} Coalesced Mana Crystal
	["The western repair used up your crystals: on the way east, use the {item:255662} on the Unstable Mana Rifts again for four more Coalesced Mana Crystals."] = "",

	-- Step 21: Bristleback Retreat: repair the eastern pylon
	-- {area:16677} Bristleback Retreat
	["{area:16677}: repair the eastern pylon"] = "{area:16677}: почините восточный пилон",
	-- {npc:252711} Decrepit Pylon Protector · {npc:253527} Kog'thug the Brave
	["East along the valley road to the eastern pylon and repair it the same way, a {npc:252711} first, coming in from the west: {npc:253527} (level 43, elite) and his bodyguards hold the south side of the quilboar camp, and a Corpsefeeder (level 45, elite) walks the road."] = "На восток по дороге через долину к восточному пилону и почините его так же, сначала {npc:252711}; подходите с запада: {npc:253527} (уровень 43, элита) с телохранителями удерживает южную часть лагеря свинобразов, а по дороге ходит трупоед (уровень 45, элита).",
	-- {npc:252711} Decrepit Pylon Protector · {spell:1289727} Repair and Recharge Pylon
	["{npc:252711}, then {spell:1289727} on it"] = "{npc:252711}, затем на нем {spell:1289727}",

	-- Step 22: Evenshade's Overlook
	-- {npc:253471} Mordent Evenshade · {quest:93016} A Brief History Lesson
	["Back west along the valley road and south to {npc:253471}. {quest:93016} asks you to hear him out: talk to him once more, then hand it in."] = "Обратно на запад по дороге через долину и на юг к NPC {npc:253471}. {quest:93016}: выслушайте его – поговорите с ним еще раз, затем сдайте задание.",
	-- {npc:253471} Mordent Evenshade
	["{npc:253471}: hear him out"] = "{npc:253471}: выслушайте его",

	-- Step 23: Liranne
	-- {quest:93568} Partially Digested Collar · {npc:255385} Liranne
	["A Prowler gave up a {quest:93568}: {npc:255385}, north of the temple, knows whose it was."] = "С рыскуна выпал предмет {quest:93568}: {npc:255385}, к северу от храма, знает, чей он.",

	-- Step 24: The temple: Magister Kirandis
	-- {npc:254656} Magister Kirandis
	["The temple: {npc:254656}"] = "Храм: {npc:254656}",
	-- {npc:254656} Magister Kirandis · {npc:254578} Mithera · {quest:93341} Forlorn Gardens
	["{npc:254656} waits inside the temple. Then {npc:254578}, on the temple's eastern side, has work in the {quest:93341}."] = "{npc:254656} ждет в храме. Затем у NPC {npc:254578}, в восточной части храма, есть работа в месте {quest:93341}.",

	-- Step 25: The Forlorn Gardens: the pedestal
	-- {quest:93341} Forlorn Gardens
	["The {quest:93341}: the pedestal"] = "{quest:93341}: пьедестал",
	-- {quest:93341} Forlorn Gardens
	["East of the temple the {quest:93341} have run wild, and their plants attack on sight. Examine the pedestal at the gardens' southern end."] = "К востоку от храма {quest:93341} совсем одичали, и растения нападают, едва завидев вас. Осмотрите пьедестал в южной части садов.",

	-- Step 27: The Forlorn Gardens
	-- {quest:93341} Forlorn Gardens
	["The {quest:93341}"] = "{quest:93341}",
	-- {npc:254674} Woodwyrd · {area:2100} Maraudon
	-- plural, as words: Rowdy Roses = {npc:254566} Rowdy Rose · Terrible Tulips = {npc:254567} Terrible Tulip · Malevolent Marigolds = {npc:254572} Malevolent Marigold · Nascent Pylon Protectors = {npc:276401} Nascent Pylon Protector
	["Rowdy Roses and Terrible Tulips grow all over the gardens; the Malevolent Marigolds keep to the northern part. {npc:254674}, the treant in the middle of the gardens, has a request of his own that needs water from {area:2100}, a dungeon: this guide leaves it.\nThe Shen'dralar who wander the gardens are neutral, like the temple's guards: leave them be and pull the flowers away from them. Careful: Nascent Pylon Protectors (elites, 43) wander the zone's middle, the gardens too: keep clear of them."] = "Буйные розы и Жуткие тюльпаны растут по всем садам; Злобные бархатцы держатся северной части. У древня {npc:254674} в середине садов есть своя просьба, для которой нужна вода из подземелья {area:2100}: этот гайд ее пропускает.\nШен'дралар, бродящие по садам, нейтральны, как и стража храма: не трогайте их и выманивайте цветы подальше от них. Осторожно: Зарождающиеся защитники пилонов (элита, 43) бродят по центру зоны, в том числе по садам: держитесь от них подальше.",

	-- Step 28: Mithera
	-- {npc:255486} Historian Biraxas · {npc:254656} Magister Kirandis · {npc:252711} Decrepit Pylon Protector
	["{npc:255486}, inside the temple, has a task for you now that you have met {npc:254656}: the heart of a {npc:252711} (42-43, not elite), a short ride back up the road north."] = "{npc:255486} в храме теперь, когда вы встретили NPC {npc:254656}, дает вам поручение: сердце существа {npc:252711} (42-43, не элита), недалеко назад на север по дороге.",

	-- Step 29: A Heart of Crystal
	-- {npc:252711} Decrepit Pylon Protector
	["Use the west face of the western pylon, where you repaired it. Approach on the road from the south and pull one {npc:252711} back to you. Wait for the elite patrols to pass; do not follow a Protector around the east side."] = "",

	-- Step 31: Mana Mania
	-- {item:286647} Depleted Crystal Heart · {npc:264149} Unstable Mana Rift · {npc:276401} Nascent Pylon Protector
	["Take the {item:286647} to an {npc:264149} on the road north of the temple and throw it into the rift. The {npc:276401} is elite: grouping up is advised."] = "",

	-- Step 32: Shadowprey Village
	-- {zone:2652} Shen'dralas · {area:2657} Valley of Bones · {area:405} Desolace · {area:2408} Shadowprey Village · {area:1637} Orgrimmar · {zone:1444} Feralas · {area:1099} Camp Mojache
	["{zone:2652} is done. Ride back north through the {area:2657} and west along {area:405}'s southern edge to {area:2408} and fly to {area:1637}: the next guide picks up there, with the {zone:1444} guide's hand-ins. Keep your hearthstone (bound at {area:1099}): the next guide uses it to get from {area:1637} back to {area:1099}."] = "",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "Распорядитель полетов: {area:2408}",

	-- Step 33: Back to your route
	["Back to your route"] = "Назад к вашему маршруту",
	-- {zone:2652} Shen'dralas · {zone:1444} Feralas · {area:2657} Valley of Bones · {area:405} Desolace · {area:1108} Forgotten Coast · {area:1116} Feathermoon Stronghold
	["{zone:2652} is done. Your {zone:1444} guide picks up from here: ride back north through the {area:2657}, west along {area:405}'s southern edge and south into {zone:1444}, to the dock on the {area:1108} where the boat crosses to {area:1116}."] = "{zone:2652}: всё выполнено. Дальше продолжает ваш гайд по зоне {zone:1444}: езжайте назад на север через {area:2657}, на запад вдоль южного края зоны {area:405} и на юг в зону {zone:1444}, к причалу ({area:1108}), откуда корабль идет в {area:1116}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["East through the valley to the strange crystal on its pedestal: clicking it starts {quest:92914}. The Decrepit Pylon Protectors (levels 42-43) around it are the mana elementals that guard it. Corpsefeeders (level 45, elite) roam the valley east of here."] = "На восток через долину к странному кристаллу на пьедестале: щелчок по нему начинает задание {quest:92914}. Ветхие защитники пилона (уровни 42-43) вокруг – элементали маны, охраняющие его. К востоку отсюда по долине бродят трупоеды (уровень 45, элита).",
	-- ["New in Forever: if a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\nThe Outcast Necromancers and the Magram Necromancers of the valley drop a {quest:93644} whose writer lives in {zone:2652}: players got it within a few kills. The Magram centaurs leave you be until you attack; the Magram Necrokhans among them (level 45) are elites: leave them be.\nThe Gelkis and Magram centaurs have {area:2657} quest chains of their own, worth about 20,000 to 30,000 more experience, but each chain asks for Honored with its clan. The two clans are rivals, so work for one of them: the Gelkis and Magram Centaur Reputation guide, under Reputation, shows how."] = "Новое в Forever: если шаг неверен, сообщите нам в Discord или на GitHub Polestar и назовите шаг.\nИзгнанные некромантки и некроманты Маграмов в долине роняют предмет «{quest:93644}», автор которого живет здесь: {zone:2652}. Игроки получали его за несколько убийств. Кентавры Маграмов не трогают вас, пока вы не нападете; некроханы Маграмов среди них (уровень 45) – элита: не трогайте их.\nУ кентавров Гелкис и Маграмов есть свои цепочки заданий ({area:2657}), еще около 20 000-30 000 опыта, но каждая требует уровня «Уважение» у своего клана. Кланы враждуют, так что работайте на один из них: как – описано в гайде «Репутация у кентавров Гелкис и Маграмов» в разделе «Репутация».",
	-- ["North up the road to the first pylon, gathering mana from the Unstable Mana Rifts on the way. Decrepit Pylon Protectors guard it: kill one beside the pylon, then use {spell:1289727} on it, as players did to repair it.\nCareful: the pylon stands at the edge of the {area:2657}, where Magram Necrokhans and Corpsefeeders (elites, level 45) walk, and Nascent Pylon Protectors (elites, 43) wander the road. Pull the Decrepit Pylon Protectors away from them before you repair it."] = "На север по дороге к первому пилону, по пути собирая ману с нестабильных разломов маны. Его охраняют ветхие защитники пилона: убейте одного рядом с пилоном, затем используйте на нем {spell:1289727}, как игроки делали для ремонта.\nОсторожно: пилон стоит на краю места {area:2657}, где ходят некрохане Маграм и трупоеды (элита, уровень 45), а по дороге бродят зарождающиеся защитники пилона (элита, 43). Отведите ветхих защитников пилона от них, прежде чем чинить.",
	-- ["The nearest Decrepit Pylon Protectors stand by the road north, from the middle of the zone up to the western pylon, and around {npc:253471}'s overlook: one of them carries the heart Biraxas wants."] = "Ближайшие Ветхие защитники пилонов стоят у дороги на север, от центра зоны до западного пилона, и вокруг смотровой площадки NPC {npc:253471}: у одного из них сердце, нужное Бираксасу.",
	-- ["The {item:255656} lies at the western edge of the village; Magram Guardians (levels 39-41) watch over it."] = "{item:255656} лежит у западного края деревни; его охраняют стражи Маграм (уровни 39-41).",
	-- ["{zone:2652} is done. Ride back north through the {area:2657} and west along {area:405}'s southern edge to {area:2408}: the next guide picks up in {area:1637}, with the {zone:1444} guide's hand-ins. Your hearthstone is bound at {area:1099}: if it is ready, hearth there and fly to {area:1637} from {area:1099} instead."] = "{zone:2652} пройден. Езжайте обратно на север через {area:2657}, затем на запад вдоль южного края зоны {area:405} до места {area:2408}: следующий гайд начинается здесь: {area:1637}, со сдачей заданий из гайда по зоне {zone:1444}. Ваш камень возвращения привязан здесь: {area:1099}. Если он готов, вернитесь туда и летите в {area:1637} оттуда ({area:1099}).",
	-- ["{zone:2652} is done: ride back north through the {area:2657}; the next step says where your route goes on from there."] = "{zone:2652}: всё выполнено. Езжайте назад на север через {area:2657}; следующий шаг подскажет, куда ведет маршрут дальше.",
}
