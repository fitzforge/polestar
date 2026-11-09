-- Russian (ruRU): the guide forever/alliance/human/01-elwynn-forest (forever/alliance/human/01-elwynn-forest.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Northshire Abbey
	-- {npc:823} Deputy Willem · {npc:197} Marshal McBride · {npc:951} Brother Paxton · {npc:247229} Daniel · {npc:196} Eagan Peltskinner
	["You start in front of the Abbey. {npc:823} stands at the foot of the steps, {npc:197} inside the hall, {npc:951} and {npc:247229} in the library to the right, {npc:196} outside the north-west corner."] = "Вы начинаете перед аббатством. {npc:823} стоит у подножия лестницы, {npc:197} – в зале, {npc:951} и {npc:247229} – в библиотеке справа, {npc:196} – снаружи у северо-западного угла.",
	-- {npc:197} Marshal McBride
	["{npc:197}, inside"] = "{npc:197}, внутри",
	-- {npc:459} Drusilla La Salle
	["{npc:459}, outside the Abbey"] = "{npc:459}, у аббатства",

	-- Step 2: Wolves
	["Wolves"] = "Волки",
	["Young Wolves and Timber Wolves roam the fields right around the Abbey."] = "Молодые и лесные волки бродят по полям прямо вокруг аббатства.",

	-- Step 3: Deputy Willem
	-- {npc:198} Khelden Bremen
	["Mages: {npc:198}, the mage trainer, stands upstairs in the Abbey: take the stairs inside, the arrow cannot tell the floors apart."] = "Маги: {npc:198}, учитель магов, стоит на втором этаже аббатства: поднимитесь по лестнице внутри, стрелка не различает этажи.",
	-- {npc:823} Deputy Willem
	["{npc:823}, back at the Abbey steps"] = "{npc:823}, снова у лестницы аббатства",

	-- Step 4: The kobold camp
	["The kobold camp"] = "Лагерь кобольдов",
	-- {npc:6} Kobold Vermin · {quest:91741} Nibbled-On Book
	["{npc:6} dig in the vineyards north-east of the Abbey. Now and then one drops a {quest:91741}: right-click it."] = "{npc:6} копаются на виноградниках к северо-востоку от аббатства. Иногда с них падает {quest:91741}: щелкните по нему правой кнопкой.",

	-- Step 5: Northshire Abbey
	["Inside"] = "Внутри",
	-- {npc:247229} Daniel
	["{npc:247229}, in the library; inside"] = "{npc:247229}, в библиотеке; внутри",

	-- Step 6: Echo Ridge Mine: kill these as you meet them
	-- {area:34} Echo Ridge Mine
	["{area:34}: kill these as you meet them"] = "{area:34}: убивайте их по пути",
	-- {object:83763} Stolen Books
	-- plural, as words: Kobold Workers = {npc:257} Kobold Worker
	["Follow the path north to the mine. Kobold Workers swarm outside it; every kobold in the valley can drop the {object:83763}."] = "Идите по тропе на север к руднику. Снаружи кишат кобольды-рабочие; {object:83763} может упасть с любого кобольда в долине.",

	-- Step 7: Northshire Abbey
	-- {npc:248415} Tordrin Sternblade · {npc:198} Khelden Bremen
	["{npc:248415} stands behind the Abbey, by the stables. {npc:198}, the mage trainer, stands upstairs in the Abbey: take the stairs inside, the arrow cannot tell the floors apart."] = "{npc:248415} стоит за аббатством, у конюшен. {npc:198}, учитель магов, стоит на втором этаже аббатства: поднимитесь по лестнице внутри, стрелка не различает этажи.",
	-- {npc:911} Llane Beshere
	["{npc:911}, the warrior trainer; inside"] = "{npc:911}, учитель воинов; внутри",
	-- {npc:925} Brother Sammuel
	["{npc:925}, the paladin trainer"] = "{npc:925}, учитель паладинов",
	-- {npc:248415} Tordrin Sternblade
	["{npc:248415}, by the Abbey"] = "{npc:248415}, у аббатства",
	-- {npc:915} Jorik Kerridan
	["{npc:915}, the rogue trainer"] = "{npc:915}, учитель разбойников",
	-- {npc:375} Priestess Anetta
	["{npc:375}, the priest trainer"] = "{npc:375}, учитель жрецов",
	-- {npc:198} Khelden Bremen
	["{npc:198}, the mage trainer, inside the Abbey"] = "{npc:198}, учитель магов, в аббатстве",

	-- Step 8: The Defias camp
	["The Defias camp"] = "Лагерь Братства Справедливости",
	-- plural, as words: Defias Thugs = {npc:38} Defias Thug
	["Defias Thugs camp in the clearing east of the Abbey and along the valley's east side."] = "Лиходеи из Братства Справедливости стоят лагерем на поляне к востоку от аббатства и вдоль восточного края долины.",
	-- plural, as words: Red Burlap Bandanas = {item:752} Red Burlap Bandana
	["Red Burlap Bandanas"] = "Красные холщовые банданы",
	-- {item:6785} Powers of the Void · {object:83763} Stolen Books
	["{item:6785}: the {object:83763} in the Defias camp"] = "{item:6785}: {object:83763} в лагере Братства Справедливости",

	-- Step 9: Deputy Willem
	["She stands by her cart at the vineyard east of the Abbey."] = "Она стоит у своей тележки на винограднике к востоку от аббатства.",

	-- Step 10: The vineyards and Garrick Padfoot
	-- {npc:103} Garrick Padfoot
	["The vineyards and {npc:103}"] = "Виноградники и {npc:103}",
	-- {npc:103} Garrick Padfoot
	["The crates of grapes lie in the vineyards behind the Defias. {npc:103} waits by the cabin at the east end of the valley."] = "Ящики с виноградом лежат на виноградниках за Братством Справедливости. {npc:103} ждет у хижины в восточном конце долины.",

	-- Step 12: Kelsey Fargo
	-- {npc:248362} Shinyfinder Narf
	["She stands outside the mine entrance. {npc:248362}, inside, is elite: grouping up is advised."] = "Она стоит у входа в рудник. {npc:248362} внутри – элита: лучше собрать группу.",

	-- Step 14: Inside Echo Ridge Mine
	-- {area:34} Echo Ridge Mine
	["Inside {area:34}"] = "Внутри: {area:34}",
	-- {npc:248362} Shinyfinder Narf
	-- plural, as words: Kobold Laborers = {npc:80} Kobold Laborer
	["Kobold Laborers work the tunnels inside the mine. {npc:248362} waits down the second turn on the right."] = "В туннелях рудника работают кобольды-работники. {npc:248362} ждет за вторым поворотом направо.",
	-- {npc:80} Kobold Laborer · {area:34} Echo Ridge Mine
	["{npc:80} walks around {area:34}: look inside the circle on the map"] = "{npc:80} ходит по месту {area:34}: ищите внутри круга на карте",

	-- Step 15: Inside Echo Ridge Mine
	-- {npc:248362} Shinyfinder Narf
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:248362} (level 3 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "Это элитные противники: лучше собрать группу, поищите спутников. {npc:248362} (элита 3-го уровня) – нужна группа из 2 человек. Если вы один, пропустите: по маршруту вы доберете этот опыт убийством монстров.",

	-- Step 16: Northshire Abbey
	-- {npc:823} Deputy Willem
	["{npc:823}, at the Abbey steps"] = "{npc:823}, у лестницы аббатства",
	-- {npc:952} Brother Neals
	["{npc:952}, upstairs"] = "{npc:952}, наверху",
	-- {npc:6774} Falkhaan Isenstrider
	["{npc:6774}, by the stables south of the Abbey"] = "{npc:6774}, у конюшен к югу от аббатства",

	-- Step 17: Northshire Abbey
	-- {area:87} Goldshire
	["his kobold tracker shows the kobolds to click on the road to {area:87}"] = "его следопыт по кобольдам показывает, на каких кобольдов щелкать по дороге (цель: {area:87})",

	-- Step 18: Level 5.48
	["Level 5.48"] = "Уровень 5.48",
	-- {quest:91752} The Big Picture
	["If you skipped {quest:91752}, grind here to level 5.48 to stay on the route's plan."] = "Если вы пропустили {quest:91752}, убивайте монстров здесь до уровня 5.48, чтобы не отстать от маршрута.",
	-- {npc:80} Kobold Laborer
	["grind on {npc:80}"] = "убивайте: {npc:80}",

	-- Step 19: Goldshire
	-- {area:87} Goldshire · {npc:240} Marshal Dughan · {npc:241} Remy "Two Times" · {npc:295} Innkeeper Farley · {npc:253} William Pestle
	["Follow the road south out of the valley to {area:87}. {npc:240} stands outside the smithy on the west side of the road, {npc:241} by the road south of it, and {npc:295} and {npc:253} in the Lion's Pride Inn across the road."] = "Идите по дороге на юг из долины. Цель: {area:87}. {npc:240} стоит у кузницы на западной стороне дороги, {npc:241} – у дороги к югу от нее, а {npc:295} и {npc:253} – в таверне «Гордость льва» через дорогу.",
	-- {npc:295} Innkeeper Farley
	["{npc:295}, inside"] = "{npc:295}, внутри",
	-- {npc:253} William Pestle
	["{npc:253}, inside"] = "{npc:253}, внутри",

	-- Step 22: Level 5.77
	["Level 5.77"] = "Уровень 5.77",
	-- {quest:91752} The Big Picture
	["If you skipped {quest:91752}, grind here to level 5.77 to stay on the route's plan."] = "Если вы пропустили {quest:91752}, убивайте монстров здесь до уровня 5.77, чтобы не отстать от маршрута.",
	-- {npc:40} Kobold Miner
	["grind on {npc:40}"] = "убивайте: {npc:40}",

	-- Step 23: The lake shore
	["The lake shore"] = "Берег озера",
	-- {npc:263399} Sam Sarsaparilla · {npc:6306} Helene Peltskinner · {npc:383} Jason Mathers · {npc:1651} Lee Brown · {area:18} Crystal Lake
	["{npc:263399} camps north-east of the inn; {npc:6306}, {npc:383} and {npc:1651} stand on the shore of {area:18} east of town."] = "{npc:263399} стоит лагерем к северо-востоку от таверны; {npc:6306}, {npc:383} и {npc:1651} стоят на берегу к востоку от городка ({area:18}).",
	-- {spell:1229451} Boosted Rest
	["Sit (/sit) by his campfire until you have {spell:1229451}"] = "Сядьте (/sit) у его костра, пока не получите эффект «{spell:1229451}»",
	-- {npc:6306} Helene Peltskinner
	["{npc:6306}: skinners only, the pelts are skinned; inside"] = "{npc:6306}: только для снятия шкур, шкуры снимаются с добычи; внутри",

	-- Step 24: Crystal Lake
	-- plural, as words: Fishing Traps = {object:694772} Fishing Trap
	["The Fishing Traps sit along the west shore of the lake."] = "Ловушки ({object:694772}) стоят вдоль западного берега озера.",

	-- Step 26: Crystal Lake: kill these as you meet them
	-- {area:18} Crystal Lake
	["{area:18}: kill these as you meet them"] = "{area:18}: убивайте их по пути",
	-- plural, as words: Murloc Streamrunners = {npc:735} Murloc Streamrunner · Junk Piles = {object:694785} Junk Pile
	["Murlocs and Murloc Streamrunners hold the east shore; the Junk Piles lie in their camp."] = "Мурлоки и речные мурлоки-бегуны занимают восточный берег; груды мусора лежат в их лагере.",

	-- Step 28: Goldshire
	-- {npc:1430} Tomas · {npc:377} Priestess Josetta · {npc:328} Zaldimar Wefhellt · {npc:917} Keryn Sylvius
	["{npc:1430} cooks in the inn's kitchen. {npc:377} (priests), {npc:328} (mages) and {npc:917} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "{npc:1430} готовит на кухне таверны. {npc:377} (жрецы), {npc:328} (маги) и {npc:917} (разбойники) стоят наверху в таверне: поднимитесь по лестнице внутри, стрелка не различает этажи.",
	-- {npc:1430} Tomas
	["{npc:1430}: Camping 101 asks you to learn it; below ground"] = "{npc:1430}: «Походное дело для начинающих» просит выучить это; под землей",

	-- Step 29: Maybell Maclure
	-- {area:87} Goldshire · {area:64} Maclure Vineyards · {npc:251} Maybell Maclure
	["Follow the road south out of {area:87} to the {area:64}. {npc:251} waits by the house."] = "Идите по дороге на юг из места {area:87}. Цель: {area:64}. {npc:251} ждет у дома.",

	-- Step 30: Tommy Joe Stonefield
	["He stands by the river west of the farm."] = "Он стоит у реки к западу от фермы.",

	-- Step 31: The Stonefield Farm
	["The Stonefield farm is west of the mine. Ma and \"Auntie\" Bernice stand by the house.\nShe sits inside the farmhouse."] = "Ферма Стоунфилдов – к западу от рудника. Мамаша и \"Тетушка\" Бернис стоят у дома.\nОна сидит в доме на ферме.",

	-- Step 32: Billy Maclure
	-- {area:64} Maclure Vineyards
	["Billy plays in the {area:64}, east of the mine."] = "Билли играет здесь: {area:64}, к востоку от рудника.",

	-- Step 33: Elwynn Forest: kill these as you meet them
	-- {zone:1429} Elwynn Forest
	["{zone:1429}: kill these as you meet them"] = "{zone:1429}: убивайте их по пути",
	-- {object:694855} Overgrown Duskweed
	-- plural, as words: Stonetusk Boars = {npc:113} Stonetusk Boar
	["{object:694855} grows in the fields around the vineyards and the Stonefield farm; Stonetusk Boars around them give the blood.\nStonetusk Boars graze between the vineyards and the farm."] = "{object:694855} растет на полях вокруг виноградников и фермы Стоунфилдов; кровь дают вепри-камнеклыки поблизости.\nВепри-камнеклыки пасутся между виноградниками и фермой.",
	-- {item:286215} Vial of Animal Blood
	-- plural, as words: Stonetusk Boars = {npc:113} Stonetusk Boar
	["{item:286215}: Stonetusk Boars"] = "{item:286215}: вепри-камнеклыки",
	["Chunks of Boar Meat"] = "Куски кабанины",

	-- Step 34: "Auntie" Bernice Stonefield
	["\"Auntie\" Bernice Stonefield"] = "\"Тетушка\" Бернис Стоунфилд",

	-- Step 36: Maclure Vineyards: kill these as you meet them
	-- {area:64} Maclure Vineyards
	["{area:64}: kill these as you meet them"] = "{area:64}: убивайте их по пути",
	-- {npc:248464} Nimsy
	-- plural, as words: Kobold Miners = {npc:40} Kobold Miner
	["The mine is west of the vineyards. Kobold Miners and Tunnelers fill both levels; {npc:248464}, a named kobold, holds the picture book in the lower tunnels. {npc:248464} is elite: grouping up is advised."] = "Рудник – к западу от виноградников. Оба уровня полны кобольдов-шахтеров и кобольдов-проходчиков; книжка с картинками – у NPC {npc:248464}, именного кобольда в нижних туннелях. {npc:248464} – элита: лучше собрать группу.",
	["Walk through the mine"] = "Пройдите через рудник",
	-- plural, as words: Large Candles = {item:772} Large Candle
	["Large Candles"] = "Большие свечи",

	-- Step 37: Maclure Vineyards: kill these as you meet them
	-- {npc:248464} Nimsy
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:248464} (level 6 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "Это элитные противники: лучше собрать группу, поищите спутников. {npc:248464} (элита 6-го уровня) – нужна группа из 2 человек. Если вы один, пропустите: маршрут восполнит опыт за счет убийства монстров.",
	-- plural, as words: Lost Books = {item:248001} Lost Book · Kobold Miners = {npc:40} Kobold Miner
	["Lost Books: Kobold Miners and Tunnelers"] = "Потерянные книги: кобольды-шахтеры и кобольды-проходчики",
	-- {npc:248464} Nimsy
	["Fun with Elementals: {npc:248464}"] = "«Забавы с элементалями»: {npc:248464}",

	-- Step 38: Goldtooth
	-- {quest:87} Goldtooth · {area:57} Fargodeep Mine · {item:1972} Westfall Deed
	-- plural, as words: Defias Bandits = {npc:116} Defias Bandit
	["{quest:87} is inside the {area:57}, not on the hill above it: go in at the mouth and keep left to the back of the mine floor; don't take the stairs up. Defias Bandits around the vineyards drop a {item:1972} now and then: right-click it."] = "{quest:87} – внутри ({area:57}), а не на холме над ним: войдите и держитесь левее до дальнего конца нижнего уровня; по лестнице наверх не поднимайтесь. С бандитов из Братства Справедливости у виноградников иногда падает {item:1972}: щелкните по нему правой кнопкой.",
	-- {item:981} Bernice's Necklace
	["{item:981}; below ground"] = "{item:981}; под землей",

	-- Step 39: Goldshire
	-- {npc:377} Priestess Josetta · {npc:328} Zaldimar Wefhellt · {npc:917} Keryn Sylvius
	["{npc:377} (priests), {npc:328} (mages) and {npc:917} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "{npc:377} (жрецы), {npc:328} (маги) и {npc:917} (разбойники) стоят наверху в таверне: поднимитесь по лестнице внутри, стрелка не различает этажи.",
	-- {npc:279} Morgan Pestle · {zone:1453} Stormwind
	["{npc:279} in {zone:1453} takes it (02-westfall)"] = "Его принимает {npc:279} ({zone:1453}) (02-westfall)",

	-- Step 41: Level 8.39
	["Level 8.39"] = "Уровень 8.39",
	-- {quest:91775} Book Return
	["If you skipped {quest:91775}, grind here to level 8.39 to stay on the route's plan."] = "Если вы пропустили {quest:91775}, убивайте монстров здесь до уровня 8.39, чтобы не отставать от маршрута.",

	-- Step 42: Class trainer
	["Class trainer"] = "Учитель классовых навыков",

	-- Step 43: Shaman trainer
	["Shaman trainer"] = "Учитель шаманов",
	-- {npc:257446} Teo Hammerstorm · {zone:1426} Dun Morogh · {area:87} Goldshire
	["{npc:257446} in {zone:1426}; {area:87} has no shaman trainer"] = "{npc:257446} ({zone:1426}); {area:87}: учителя шаманов нет",

	-- Step 44: Druid trainer
	["Druid trainer"] = "Учитель друидов",
	-- {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {area:87} Goldshire
	["{npc:5504} in {zone:1453}; {area:87} has no druid trainer"] = "{npc:5504} ({zone:1453}); {area:87}: учителя друидов нет",

	-- Step 45: Jason Mathers
	-- {area:87} Goldshire · {npc:383} Jason Mathers
	["Head east out of {area:87} along the lake shore. {npc:383} stands on the shore north-east of town."] = "Идите на восток из места {area:87} вдоль берега озера. {npc:383} стоит на берегу к северо-востоку от городка.",

	-- Step 46: Crystal Lake: kill these as you meet them
	-- {area:91} Tower of Azora
	-- plural, as words: Prowlers = {npc:118} Prowler
	["The murlocs on the east shore drop the kelp. Skinners: Gray Forest Wolves roam the woods between the lake and the {area:91}; Prowlers further east give pelts too."] = "Фукус падает с мурлоков на восточном берегу. Для снятия шкур: серые лесные волки бродят по лесу между озером и местом {area:91}; шкуры дают и лесные хищники дальше к востоку.",
	-- plural, as words: Crystal Kelp Fronds = {item:1256} Crystal Kelp Frond
	["Crystal Kelp Fronds"] = "Ветки хрустального фукуса",

	-- Step 47: The Tower of Azora
	-- {area:91} Tower of Azora
	["The {area:91}"] = "{area:91}",
	-- {npc:248242} Hamish Bergwort · {npc:248248} Blixie Fitzwink
	["{npc:248242} and {npc:248248} stand at the foot of the tower."] = "{npc:248242} и {npc:248248} стоят у подножия башни.",

	-- Step 48: The bridge
	["The bridge"] = "Мост",
	-- {npc:261} Guard Thomas · {npc:248265} Ormin Pelford
	["{npc:261} guards the bridge on the road east; {npc:248265} stands just across it."] = "{npc:261} охраняет мост на дороге к востоку; {npc:248265} стоит сразу за ним.",

	-- Step 49: Downstream and Princess
	-- {quest:91733} Downstream · {npc:330} Princess
	["{quest:91733} and {npc:330}"] = "{quest:91733} и {npc:330}",
	-- {item:247813} Waterlogged Saw · {npc:330} Princess · {area:62} Brackwell Pumpkin Patch · {npc:390} Porcine Entourage · {npc:248278} Croaky
	-- plural, as words: Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear
	["The {item:247813}, Axe and Toolbox lie in the river south of the bridge. {npc:330}, a big boar, roots in the {area:62} west of the river with her {npc:390}: pull the piglets away first. Kill Prowlers and Young Forest Bears on the way. Careful: {npc:248278} is a level 11 elite on the murloc shore. Only go for his head with a group or once you're level 10; otherwise leave him: it's optional."] = "{item:247813}, топор и ящик с инструментами лежат в реке к югу от моста. {npc:330}, большая свинья, роется здесь: {area:62}, к западу от реки, вместе с поросятами ({npc:390}): сначала отманите поросят. По пути убивайте лесных хищников и молодых лесных медведей. Осторожно: {npc:248278} – элита 11-го уровня на берегу мурлоков. Идите за его головой только с группой или с 10-го уровня; иначе не трогайте: это необязательно.",

	-- Step 50: Croaky
	-- {npc:248278} Croaky · {quest:91740} Croaky's Head
	["{npc:248278} is a level 11 elite on the murloc shore south of the bridge: grouping up is encouraged, look for people to do it with. {quest:91740} needs a group of 2. Skip it if you are alone: the route has you grind the XP back. Right-click the head for its quest."] = "",

	-- Step 52: Level 8.85
	["Level 8.85"] = "Уровень 8.85",
	-- {quest:91740} Croaky's Head
	["If you skipped {quest:91740}, grind here to level 8.85 to stay on the route's plan."] = "Если вы пропустили {quest:91740}, убивайте монстров здесь до уровня 8.85, чтобы не отставать от маршрута.",
	-- {npc:118} Prowler
	["grind on {npc:118}"] = "убивайте: {npc:118}",

	-- Step 54: The Eastvale Logging Camp
	-- {area:88} Eastvale Logging Camp
	["The {area:88}"] = "{area:88}",
	["The camp is north-east of the bridge. Bundles of Wood lie around the camp and in the woods north of it."] = "Лагерь – к северо-востоку от моста. Вязанки дров лежат вокруг лагеря и в лесу к северу от него.",
	-- {npc:278} Sara Timberlain
	["{npc:278}, inside"] = "{npc:278}, внутри",

	-- Step 55: A half-eaten body
	["It lies by the river north-west of the logging camp."] = "Оно лежит у реки к северо-западу от лесозаготовок.",

	-- Step 56: Stone Cairn Lake
	-- {area:86} Stone Cairn Lake · {object:56} Rolf's corpse
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard · Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Defias Rogue Wizards camp on the shores of {area:86}; they drop the Red Linen Bandanas too. {object:56} lies in the murloc village on the north-east shore."] = "Волшебники-плуты из Братства Справедливости стоят лагерем на берегах ({area:86}); с них падают и красные льняные банданы. {object:56} лежит в деревне мурлоков на северо-восточном берегу.",
	-- plural, as words: Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Red Linen Bandanas"] = "Красные льняные банданы",

	-- Step 57: The gnoll camps
	["The gnoll camps"] = "Лагеря гноллов",
	-- {area:86} Stone Cairn Lake · {quest:91725} Stolen Enchanting Supplies
	["Riverpaw gnolls camp in the hills west of {area:86}; the {quest:91725} lie in their camps."] = "Гноллы из стаи Речной Лапы стоят лагерем на холмах к западу (ориентир: {area:86}); {quest:91725} лежат в их лагерях.",

	-- Step 58: The Jasperlode Mine's entrance
	-- {quest:76} The Jasperlode Mine
	["{quest:76}'s entrance"] = "Вход: {quest:76}",

	-- Step 59: Jasperlode Mine: kill these as you meet them
	-- {area:54} Jasperlode Mine
	["{area:54}: kill these as you meet them"] = "{area:54}: убивайте их по пути",
	-- {item:247816} Mining Tools
	-- plural, as words: Kobold Geomancers = {npc:476} Kobold Geomancer
	["The mine is south-west of the gnoll camps. {item:247816} lie near the entrance; Kobold Geomancers hold the tunnels."] = "Рудник – к юго-западу от лагерей гноллов. {item:247816} лежат у входа; туннели занимают кобольды-геоманты.",
	["Walk into the mine"] = "Войдите в рудник",
	-- {npc:476} Kobold Geomancer · {area:54} Jasperlode Mine
	["{npc:476} walks around {area:54}: look inside the circle on the map"] = "{npc:476} ходит здесь: {area:54}: ищите внутри круга на карте",

	-- Step 60: The Tower of Azora
	["Follow the hills south to the tower."] = "Идите по холмам на юг к башне.",

	-- Step 61: Guard Thomas
	-- {area:91} Tower of Azora
	-- plural, as words: Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear
	["Follow the road east past the {area:91} to the bridge. Finish the Prowlers and Young Forest Bears around the river south of it."] = "Идите по дороге на восток мимо места {area:91} к мосту. Добейте лесных хищников и молодых лесных медведей у реки к югу от него.",

	-- Step 63: Stone Cairn Lake
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["North-east of the logging camp. Defias Rogue Wizards camp on the shores of the lake."] = "К северо-востоку от лесозаготовок. Волшебники-плуты из Братства Справедливости стоят лагерем на берегах озера.",

	-- Step 64: The Tower of Azora
	["Follow the hills south to the tower, on the road west."] = "Идите по холмам на юг к башне, по дороге на запад.",

	-- Step 65: Goldshire
	-- {area:87} Goldshire · {npc:6306} Helene Peltskinner · {npc:377} Priestess Josetta · {npc:328} Zaldimar Wefhellt · {npc:917} Keryn Sylvius
	["Follow the road west back to {area:87}; {npc:6306} stands on the lake shore before town. {npc:377} (priests), {npc:328} (mages) and {npc:917} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "Идите по дороге на запад обратно. Цель: {area:87}; {npc:6306} стоит на берегу озера перед городком. {npc:377} (жрецы), {npc:328} (маги) и {npc:917} (разбойники) – на втором этаже таверны: поднимитесь по лестнице внутри, стрелка не различает этажи.",
	-- {npc:6306} Helene Peltskinner
	["{npc:6306}, inside"] = "{npc:6306}, внутри",
	-- {npc:240} Marshal Dughan
	["{npc:240}, while William brews"] = "{npc:240}, пока Уильям варит зелье",
	-- {npc:514} Smith Argus · {npc:1416} Grimand Elmore · {zone:1453} Stormwind
	["{npc:514}, at the smithy: {npc:1416} in {zone:1453} takes it (02-westfall)"] = "",
	-- {npc:377} Priestess Josetta · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["{npc:377}: {npc:376} in {zone:1453} takes it"] = "{npc:377}: его принимает {npc:376} ({zone:1453})",
	-- {npc:328} Zaldimar Wefhellt · {npc:5497} Jennea Cannon · {zone:1453} Stormwind
	["{npc:328}: {npc:5497} in {zone:1453} takes it"] = "{npc:328}: принимает {npc:5497} ({zone:1453})",
	-- {npc:6121} Remen Marcot · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind
	["{npc:6121}: {npc:6122} in {zone:1453} takes it"] = "{npc:6121}: принимает {npc:6122} ({zone:1453})",

	-- Step 67: Jennea Cannon
	-- {area:87} Goldshire · {zone:1453} Stormwind · {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {quest:1861} Mirror Lake
	["Follow the road north from {area:87} into {zone:1453}. {npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}; she gives you a flask for the {quest:1861} waterfall."] = "Идите по дороге на север от места {area:87} в город {zone:1453}. {npc:5497} стоит в башне ({object:2101}); она даст вам флягу для водопада ({quest:1861}).",

	-- Step 69: Gakin the Darkbinder
	-- {area:87} Goldshire · {zone:1453} Stormwind · {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["Follow the road north from {area:87} into {zone:1453}. {npc:6122} waits in the cellar of the {object:2164}, in the {object:2101}."] = "Идите по дороге на север от места {area:87} в город {zone:1453}. {npc:6122} ждет в подвале ({object:2164}, {object:2101}).",

	-- Step 70: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "Раз уж вы здесь: изучите посохи у NPC {npc:11867} ({object:2096}, 10 серебра); при прокачке посох дает больше характеристик для заклинаний, чем одноручное оружие.",

	-- Step 71: Mirror Lake
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {zone:1436} Westfall · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {zone:1436}: fill {item:7207} at its base."] = "Выйдите из города {zone:1453} через главные ворота. Водопад ({quest:1861}) – к юго-западу от ворот, по пути на запад в зону {zone:1436}: наполните {item:7207} у его подножия.",

	-- Step 72: Surena Caledon
	-- {area:87} Goldshire · {area:62} Brackwell Pumpkin Patch · {npc:881} Surena Caledon
	["Head back out through {area:87} and east along the road to the {area:62}. {npc:881} (level 9) stands by its farmhouse."] = "Возвращайтесь через {area:87} и на восток вдоль дороги к {area:62}. {npc:881} (9 уровня) стоит у фермерского домика.",

	-- Step 73: The Binding
	-- {npc:6122} Gakin the Darkbinder · {item:6928} Bloodstone Choker · {object:2164} Slaughtered Lamb
	["Back to {npc:6122}. Use the {item:6928} at the summoning circle in the {object:2164}'s cellar and defeat the voidwalker it calls."] = "Назад к {npc:6122}. Используйте {item:6928} у круга призыва в подвале ({object:2164}) и победите призванного демона Бездны.",
	["Subdue the voidwalker"] = "Одолейте демона Бездны",

	-- Step 74: Back to Elwynn Forest
	-- {zone:1429} Elwynn Forest
	["Back to {zone:1429}"] = "Назад: {zone:1429}",

	-- Step 75: Taming the Beast
	-- {npc:251507} Josephine Carson · {area:87} Goldshire · {item:15908} Taming Rod · {area:64} Maclure Vineyards · {area:18} Crystal Lake
	-- plural, as words: Rockhide Boars = {npc:524} Rockhide Boar · Young Forest Bears = {npc:822} Young Forest Bear
	["{npc:251507} stands with the {area:87} trainers. Each of her quests hands you a {item:15908}: use it on the beast she names, then bring the rod back to her. Rockhide Boars and Young Forest Bears roam the hills south of the {area:64}, Gray Forest Wolves the woods east of {area:18}."] = "{npc:251507} стоит с учителями ({area:87}). Каждое ее задание дает вам {item:15908}: используйте его на названном звере, затем верните жезл ей. Твердошкурые вепри и молодые лесные медведи бродят по холмам к югу от места {area:64}, серые лесные волки – по лесу к востоку (ориентир: {area:18}).",
	-- {npc:524} Rockhide Boar · {item:15908} Taming Rod
	["{npc:524}: tame it with the {item:15908}"] = "{npc:524}: приручите с помощью предмета {item:15908}",
	-- {npc:524} Rockhide Boar
	["Tame {npc:524}"] = "Приручить: {npc:524}",
	-- {npc:1922} Gray Forest Wolf · {item:15908} Taming Rod
	["{npc:1922}: tame it with the {item:15908}"] = "{npc:1922}: приручите с помощью предмета {item:15908}",
	-- {npc:1922} Gray Forest Wolf
	["Tame {npc:1922}"] = "Приручить: {npc:1922}",
	-- {npc:822} Young Forest Bear · {item:15908} Taming Rod
	["{npc:822}: tame it with the {item:15908}"] = "{npc:822}: приручите с помощью предмета {item:15908}",
	-- {npc:822} Young Forest Bear
	["Tame {npc:822}"] = "Приручить: {npc:822}",
	-- {npc:258930} Isaac Chan · {spell:5149} Beast Training
	["{npc:258930}, beside her: {spell:5149}"] = "{npc:258930}, рядом с ней: {spell:5149}",

	-- Step 76: Maybell Maclure
	-- {area:64} Maclure Vineyards
	["South down the road to the {area:64}."] = "По дороге на юг. Цель: {area:64}.",

	-- Step 77: The Stonefield Farm
	-- {npc:894} Homer Stonefield · {quest:91736} Applejack Still
	-- plural, as words: Shiny Red Apples = {item:4536} Shiny Red Apple
	["{npc:894} sells the Shiny Red Apples for the {quest:91736}. Apples looted from kobolds and crates count too: the purchase ticks itself once you have four."] = "{npc:894} продает спелые красные яблоки для объекта {quest:91736}. Яблоки с кобольдов и из ящиков тоже подходят: покупка отметится сама, когда у вас будет четыре.",
	-- {npc:894} Homer Stonefield · {quest:91736} Applejack Still
	-- plural, as words: Shiny Red Apples = {item:4536} Shiny Red Apple
	["Shiny Red Apples, from {npc:894}, for the {quest:91736}"] = "Спелые красные яблоки: продает {npc:894}, для задания {quest:91736}",

	-- Step 78: The Applejack Still
	-- {quest:91736} Applejack Still
	["The {quest:91736}"] = "{quest:91736}",
	-- {quest:91736} Applejack Still · {area:120} Westbrook Garrison · {item:247824} Thunder Applejack · {npc:955} Sergeant De Vries
	-- plural, as words: Shiny Red Apples = {item:4536} Shiny Red Apple
	["The {quest:91736} stands north of the {area:120}. Click it with four Shiny Red Apples in your bags: it takes them and gives you a {item:247824} on the spot (the quest never shows in your quest log). Keep the Applejack for {npc:955}: don't drink it."] = "{quest:91736} стоит к северу от места {area:120}. Щелкните по нему, имея в сумках четыре спелых красных яблока: он заберет их и сразу даст {item:247824} (задание не появляется в журнале заданий). Сохраните сидр для NPC {npc:955}: не пейте его.",
	-- {item:247824} Thunder Applejack
	["{item:247824}, from the still"] = "{item:247824}, из перегонного куба",

	-- Step 79: Westbrook Garrison
	-- {area:120} Westbrook Garrison · {zone:1436} Westfall · {npc:963} Deputy Rainer · {npc:955} Sergeant De Vries · {quest:91738} An Apple Treat · {item:247824} Thunder Applejack
	["Follow the road south to the {area:120}, on the way into {zone:1436}. {npc:963} stands outside the barracks; {npc:955} stands inside. He has {quest:91738} only while you carry the {item:247824}: talk to him and it goes straight to the hand-in."] = "Идите по дороге на юг. Цель: {area:120}, по пути в зону {zone:1436}. {npc:963} стоит у казарм; {npc:955} – внутри. Задание {quest:91738} есть у него, только пока у вас {item:247824}: поговорите с ним, и оно сразу перейдет к сдаче.",
	-- {npc:963} Deputy Rainer · {npc:234} Gryan Stoutmantle · {area:108} Sentinel Hill
	["{npc:963}: for {npc:234} at {area:108}"] = "{npc:963}: для {npc:234} у {area:108}",
	-- {npc:955} Sergeant De Vries · {item:247824} Thunder Applejack
	["{npc:955}: he wants your {item:247824}; inside"] = "{npc:955}: ему нужен ваш {item:247824}; внутри",

	-- Step 80: Forest's Edge
	-- {zone:1436} Westfall
	-- plural, as words: Riverpaw Runts = {npc:97} Riverpaw Runt
	["Riverpaw Runts and Outrunners hold the hills south of the garrison, along the {zone:1436} border."] = "Недоростки и гонцы стаи Речной Лапы занимают холмы к югу от гарнизона, вдоль границы с зоной {zone:1436}.",
	-- plural, as words: Painted Gnoll Armbands = {item:782} Painted Gnoll Armband
	["Painted Gnoll Armbands"] = "Раскрашенные поручи гнолла",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back south to the {area:120}, by the road to {zone:1436}. {npc:963} stands outside the barracks, {npc:955} beside him."] = "Назад на юг. Цель: {area:120}, у дороги в зону {zone:1436}. {npc:963} стоит у казарм, {npc:955} – рядом с ним.",
	-- ["Back to the Cathedral of Light."] = "Назад в Собор Света.",
	-- ["Bait ingredients"] = "Ингредиенты для приманки",
	-- ["Boar meat"] = "Кабанина",
	-- ["Follow the road east past the {area:91} to the bridge."] = "Идите по дороге на восток мимо места {area:91} к мосту.",
	-- ["Follow the road north from {area:87} into {zone:1453}. {npc:6171} and {npc:6173} are in the Cathedral of Light; {npc:6174} stands in {object:2100} and asks for ten {item:2589} (humanoids drop it; the Auction House sells it)."] = "Идите по дороге на север от места {area:87} в город {zone:1453}. {npc:6171} и {npc:6173} – в Соборе Света; {npc:6174} стоит здесь: {object:2100} – и просит десять штук: {item:2589} (падает с гуманоидов; продается на аукционе).",
	-- ["Follow the road south out of the valley to {area:87}. {npc:295} is in the Lion's Pride Inn; {npc:240} stands outside the smithy across the road, {npc:253} at the inn's front and {npc:241} by the road south of it."] = "Идите по дороге на юг из долины. Цель: {area:87}. {npc:295} – в таверне «Гордость льва»; {npc:240} стоит у кузницы через дорогу, {npc:253} – перед таверной, {npc:241} – у дороги к югу от нее.",
	-- ["Follow the road west back to {area:87}."] = "Идите по дороге на запад обратно. Цель: {area:87}.",
	-- ["Follow the road west back to {area:87}; {npc:6306} and Jason stand on the lake shore before town."] = "Идите по дороге на запад обратно. Цель: {area:87}; {npc:6306} и Джейсон стоят на берегу озера перед городком.",
	-- ["Follow the road west past Westbrook into {zone:1436}, then south along it to {area:108}. {npc:523}, the gryphon master, stands on the hill."] = "Идите по дороге на запад мимо гарнизона у Западного ручья в зону {zone:1436}, затем по ней на юг. Цель: {area:108}. Укротитель грифонов {npc:523} стоит на холме.",
	-- ["Follow the road west to the {area:120}, on the way into {zone:1436}. {npc:963} stands outside the barracks."] = "Следуйте на запад по дороге к {area:120}, по пути в {zone:1436}. {npc:963} стоит снаружи казармы.",
	-- ["From the {quest:2998} he gives you"] = "Из книги ({quest:2998}), которую он вам даст",
	-- ["Head back out through {area:87} and east to {area:86}. {npc:6172} lies south of the lake: use the {item:6866} on him. The Defias Rogue Wizards around him carry the {item:6846}."] = "Возвращайтесь через {area:87} и на восток к {area:86}. {npc:6172} лежит к югу от озера: используйте на нём {item:6866}. Бесчестные маги Братства Справедливости вокруг него несут {item:6846}.",
	-- ["Head north-west across the fields to the {quest:91736}, north of the {area:120}. Hand it four Shiny Red Apples for a {item:247824}."] = "Идите на северо-запад через поля. Цель: {quest:91736}, к северу от места {area:120}. Отдайте четыре спелых красных яблока и получите {item:247824}.",
	-- ["Murloc Foragers and Lurkers line the river south of the bridge. {npc:473}, a Defias, walks the {area:62} west of it. Finish the Prowlers and Young Forest Bears on the way."] = "Мурлоки-добытчики и мурлоки-скрытни занимают реку к югу от моста. {npc:473} из Братства Справедливости ходит здесь: {area:62}, к западу от нее. По пути добейте лесных хищников и молодых лесных медведей.",
	-- ["Murloc Foragers and Lurkers line the river south of the bridge. {npc:473}, a Defias, walks the {area:62} west of it. Finish the Prowlers and Young Forest Bears on the way. {npc:248278} roams the murloc shore too: right-click the head it drops. {npc:248278} is elite: grouping up is advised."] = "Мурлоки-добытчики и мурлоки-скрытни занимают реку к югу от моста. {npc:473} из Братства Справедливости ходит здесь: {area:62}, к западу от нее. По пути добейте лесных хищников и молодых лесных медведей. {npc:248278} тоже бродит по берегу мурлоков: щелкните правой кнопкой по голове, которую он оставит. {npc:248278} – элитный противник: лучше собрать группу.",
	-- ["Murlocs and the Collector"] = "Мурлоки и Собиратель",
	-- ["Ride back out through {area:87} and east along the road to the {area:62}. {npc:881} (level 9) stands by its farmhouse."] = "Езжайте обратно через {area:87} и по дороге на восток. Цель: {area:62}. {npc:881} (9-й уровень) стоит у фермерского дома.",
	-- ["Ride back out through {area:87} and east along the road to the {area:62}. {quest:1688} (level 9) stands by its farmhouse."] = "Езжайте обратно через {area:87} и по дороге на восток. Цель: {area:62}. {quest:1688} (9-й уровень) стоит у фермерского дома.",
	-- ["Ride back out through {area:87} and east to {area:86}. {npc:6172} lies south of the lake: use the {item:6866} on him. The Defias Rogue Wizards around him carry the {item:6846}."] = "Езжайте обратно через {area:87} и на восток. Цель: {area:86}. {npc:6172} лежит к югу от озера: используйте на нем {item:6866}. {item:6846} – у волшебников-плутов из Братства Справедливости вокруг.",
	-- ["Riverpaw Runts and Outrunners hold the hills south of the garrison, along the {zone:1436} border. {npc:100}, a level 12 gnoll, walks among them and carries the {item:1307}: right-click it."] = "Недоростки и гонцы стаи Речной Лапы занимают холмы к югу от гарнизона, вдоль границы с зоной {zone:1436}. Среди них ходит гнолл 12-го уровня {npc:100}, у него {item:1307}: щелкните по нему правой кнопкой.",
	-- ["She sits inside the farmhouse."] = "Она сидит в доме на ферме.",
	-- ["Speak with {npc:1430}"] = "Поговорить: {npc:1430}",
	-- ["Stonetusk Boars graze between the vineyards and the farm."] = "Вепри-камнеклыки пасутся между виноградниками и фермой.",
	-- ["The Stonefield farm is west of the mine. Ma and \"Auntie\" Bernice stand by the house."] = "Ферма Стоунфилдов – к западу от рудника. Мамаша и \"Тетушка\" Бернис стоят у дома.",
	-- ["The murloc camp"] = "Лагерь мурлоков",
	-- ["The {item:247813}, Axe and Toolbox lie in the river south of the bridge. {npc:330}, a big boar, roots in the {area:62} west of the river with her {npc:390}: pull the piglets away first. Kill Prowlers and Young Forest Bears on the way."] = "{item:247813}, топор и ящик с инструментами лежат в реке к югу от моста. {npc:330}, большая свинья, роется здесь: {area:62}, к западу от реки, вместе с поросятами ({npc:390}): сначала отманите поросят. По пути убивайте лесных хищников и молодых лесных медведей.",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:91740} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "Это элитные противники: лучше собрать группу, поищите спутников. {quest:91740} – нужна группа из 2 человек. Если вы один, пропустите: маршрут восполнит опыт за счет убийства монстров.",
	-- ["Torn Murloc Fins"] = "Рваные плавники мурлока",
	-- ["Use the {item:6866} on {npc:6172}"] = "Используйте {item:6866}. Цель: {npc:6172}",
	-- ["{area:18} and the wolves"] = "{area:18} и волки",
	-- ["{area:57}'s mouth"] = "Вход: {area:57}",
	-- ["{item:1006}: Princess"] = "{item:1006}: Принцесса",
	-- ["{item:6846}: Defias Rogue Wizards"] = "{item:6846}: волшебники-плуты из Братства Справедливости",
	-- ["{npc:1430} cooks in the inn's kitchen."] = "{npc:1430} готовит на кухне таверны.",
	-- ["{npc:247229}, in the library"] = "{npc:247229}, в библиотеке",
	-- ["{npc:248277} keeps watch at {area:798}, east of the murloc shore. Then head north-west back to the bridge."] = "{npc:248277} несет дозор здесь: {area:798}, к востоку от берега мурлоков. Затем возвращайтесь на северо-запад к мосту.",
	-- ["{npc:248415} stands behind the Abbey, by the stables."] = "{npc:248415} стоит за аббатством, у конюшен.",
	-- ["{npc:377}: {npc:376} in {zone:1453} takes both"] = "{npc:377}: оба принимает {npc:376} ({zone:1453})",
	-- ["{npc:6171}: Redemption"] = "{npc:6171}: Искупление",
	-- ["{npc:6306}: skinners only, the pelts are skinned"] = "{npc:6306}: только для снятия шкур, шкуры нужно снимать",
	-- ["{npc:911}, the warrior trainer"] = "{npc:911}, учитель воинов",
	-- ["{npc:927}: {npc:6171} in {zone:1453} takes it"] = "{npc:927}: принимает {npc:6171} ({zone:1453})",
	-- ["{npc:955}: he wants your {item:247824}"] = "{npc:955}: ему нужен ваш предмет {item:247824}",
	-- ["{object:694855} grows in the fields around the vineyards and the Stonefield farm; Stonetusk Boars around them give the blood."] = "{object:694855} растет на полях вокруг виноградников и фермы Стоунфилдов; кровь дают вепри-камнеклыки поблизости.",
}
