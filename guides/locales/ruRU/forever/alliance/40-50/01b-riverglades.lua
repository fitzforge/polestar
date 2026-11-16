-- Russian (ruRU): the guide forever/alliance/40-50/01b-riverglades (forever/alliance/40-50/01b-riverglades.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:16724} Farholde Keep
	["About 90 quests in Forever's new zone, 42 to 45, from {area:16724}: the level for its port and Western Front."] = "Около 90 заданий в новой зоне Forever, уровни 42–45, начиная с крепости {area:16724}: уровень для ее порта и Западного фронта.",

	-- Step 1: Ironforge flight master
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Распорядитель полетов ({zone:1455})",
	-- {zone:1426} Dun Morogh · {zone:1455} Ironforge · {area:69} Lakeshire
	["The Stranglethorn guide leaves Dwarves and Gnomes at their riding trainer in {zone:1426}: ride back west into {zone:1455}, where the flight to {area:69} leaves from the gryphon master."] = "Гайд по Тернистой долине оставляет дворфов и гномов у учителя верховой езды (зона {zone:1426}): езжайте обратно на запад в {zone:1455}, где у распорядителя полетов есть маршрут в {area:69}.",

	-- Step 2: Into the Riverglades
	-- {zone:2548} Riverglades
	["Into the {zone:2548}"] = "В зону {zone:2548}",
	-- {zone:1455} Ironforge · {area:69} Lakeshire · {area:2417} Blackrock Pass · {zone:2548} Riverglades · {area:16737} Bristle Hills
	["Fly from {zone:1455} to {area:69} in Redridge, then follow the road north out of town and up through {area:2417}: it comes down into the western {zone:2548} by the {area:16737}."] = "Летите из города {zone:1455} в {area:69} (Красногорье), затем следуйте по дороге на север из города и через {area:2417}: она спускается в западную часть зоны {zone:2548} у местности {area:16737}.",
	-- {zone:2548} Riverglades
	["The western {zone:2548}"] = "Запад зоны {zone:2548}",

	-- Step 3: Scout Bolain
	-- {npc:260026} Scout Bolain
	["{npc:260026} waits beside the road east of the pass."] = "{npc:260026} ждет у дороги к востоку от перевала.",

	-- Step 4: Southern Watch
	-- {area:16744} Southern Watch
	["Follow the road east to {area:16744}, the Alliance outpost above the river. The gnolls you passed on the way in are Captain Dalton's job: you go back for them after the lumber camp."] = "Следуйте по дороге на восток до заставы {area:16744} – аванпоста Альянса над рекой. Гноллами, мимо которых вы прошли, занимается капитан Далтон: вы вернетесь к ним после лесопилки.",
	-- {quest:95148} Southern Watch Gnoll Report · {npc:257558} Demar Brant · {area:16724} Farholde Keep
	["{quest:95148}: for {npc:257558} in {area:16724}, keep it"] = "«{quest:95148}»: для NPC {npc:257558} ({area:16724}), сохраните",

	-- Step 5: Snargl's Snout
	-- {npc:255906} Snargl · {area:16737} Bristle Hills
	["{npc:255906} is an elite gnoll (level 40) who roams the south-western camps of the {area:16737}: grouping up is advised."] = "{npc:255906} – элитный гнолл (40 уровня), бродящий по юго-западным лагерям (местность {area:16737}): рекомендуется собрать группу.",

	-- Step 6: Turner's Logging Camp
	-- {npc:256438} Halligan Turner
	["North up the road to the lumber camp. {npc:256438} runs it; his third job, the saplings, comes once his plant food is in."] = "На север по дороге к лесопилке. Ею заведует {npc:256438}; его третье поручение, саженцы, появится после сдачи удобрения.",

	-- Step 7: The Bristle Hills
	-- {area:16737} Bristle Hills
	["The {area:16737}"] = "{area:16737}",
	-- {area:16737} Bristle Hills · {npc:255906} Snargl
	["West into the {area:16737}: the Redridge gnolls camp on the slopes all the way from the hills west of the lumber camp to the pass you came in by. The stolen saw blades lie only in the western camps, near the pass.\nCareful: {npc:255906}, an elite gnoll (level 40), roams the south-western camps: pull the gnolls away from him."] = "На запад в местность {area:16737}: гноллы Красногорья стоят лагерями на склонах от холмов к западу от лесопилки до перевала, через который вы пришли. Украденные пильные диски лежат только в западных лагерях, у перевала.\nОсторожно: {npc:255906}, элитный гнолл (40 уровня), бродит по юго-западным лагерям: оттягивайте гноллов подальше от него.",

	-- Step 9: Southern Watch
	-- {area:16744} Southern Watch
	["Back east along the road to {area:16744}."] = "Обратно на восток по дороге к месту {area:16744}.",

	-- Step 11: Gelinda Coppergleam
	-- {area:16744} Southern Watch · {npc:262399} Gelinda Coppergleam
	["South-west past {area:16744}: {npc:262399}, a prospector, has camped by the Cinderscale dragonkin's hollow."] = "На юго-запад мимо места {area:16744}: старательница {npc:262399} разбила лагерь у лощины драконидов Угольной Чешуи.",

	-- Step 12: The Cinderscale hollow
	["The Cinderscale hollow"] = "Лощина Угольной Чешуи",
	-- {item:271611} Cubic Draconia
	["The whelps nest all over the hollow; the warriors (level 41-42) guard its back, by the {item:271611}. Scaldaron, a rare elite drake, can be up here too: leave him be unless you have a group."] = "Дракончики гнездятся по всей лощине; воины (41-42-го уровня) охраняют ее дальнюю часть, у предмета {item:271611}. Здесь может появиться и Скальдарон, редкий элитный дракон: не трогайте его, если у вас нет группы.",

	-- Step 14: Holmsby farm
	["Holmsby farm"] = "Ферма Холмсби",
	-- {area:16744} Southern Watch
	["Back past {area:16744} and south to the Holmsbys' farm by the river."] = "Обратно мимо места {area:16744} и на юг к ферме Холмсби у реки.",

	-- Step 15: Benjy Wheeler
	-- {area:16725} Wheeler's Grange · {npc:258317} Benjy Wheeler · {npc:256438} Halligan Turner
	["North-east across the fields to {area:16725}: {npc:258317} wants the Mudfin murlocs on the river thinned out, the same murlocs whose heads {npc:256438} needs, so one pass along the river does both."] = "На северо-восток через поля к месту {area:16725}: {npc:258317} просит проредить мурлоков Илистого Плавника на реке – тех же, чьи головы нужны NPC {npc:256438}, так что один проход вдоль реки закроет оба задания.",

	-- Step 16: Meadowsbrook and the river
	-- {area:16735} Meadowsbrook
	["{area:16735} and the river"] = "{area:16735} и река",
	-- {npc:258317} Benjy Wheeler · {npc:256438} Halligan Turner · {npc:258588} Jumbo Crawfish · {npc:258935} Curly · {npc:259049} Robbie Holmsby · {area:16735} Meadowsbrook · {npc:263380} Ghostmaw
	-- plural, as words: Mudfin Warriors = {npc:258574} Mudfin Warrior
	["Back south-west along the river: kill the Mudfin Warriors and Oracles on the banks for {npc:258317} (they drop {npc:256438}'s heads) and the {npc:258588} in the shallows for the shells. {npc:258935}, one of {npc:256438}'s lumberjacks, is stuck on the bank just north-west of the murlocs; {npc:259049}'s hat lies on the riverbank among them; the fresh manure is in the fields of {area:16735}, between the river and the farm. {npc:263380}, an elite (level 42), prowls the river: if he comes your way, back off and let him pass."] = "Обратно на юго-запад вдоль реки: убивайте илистых воинов и оракулов на берегах для NPC {npc:258317} (с них падают головы для NPC {npc:256438}) и NPC {npc:258588} на мелководье ради панцирей. {npc:258935}, один из лесорубов NPC {npc:256438}, застрял на берегу к северо-западу от мурлоков; шляпа NPC {npc:259049} лежит на берегу среди них; свежий навоз – на полях ({area:16735}) между рекой и фермой. По реке бродит элита {npc:263380} (42-й уровень): если он идет к вам, отойдите и пропустите его.",

	-- Step 18: Watcher Fredericks
	-- {npc:259051} Watcher Fredericks · {area:16744} Southern Watch
	["{npc:259051} keeps the west end of {area:16744}."] = "{npc:259051} стоит в западной части места {area:16744}.",

	-- Step 19: Turner's Logging Camp
	["North up the road to the lumber camp."] = "На север по дороге к лагерю лесорубов.",

	-- Step 20: Saplings
	["Saplings"] = "Саженцы",
	-- {npc:256438} Halligan Turner · {item:266161} Tree Sprouting Kit
	["Use {npc:256438}'s {item:266161} on bare ground around the camp: five saplings."] = "Используйте {item:266161} от NPC {npc:256438} на голой земле вокруг лагеря: пять саженцев.",

	-- Step 21: Hurley
	-- {npc:258963} Hurley · {npc:258935} Curly · {quest:94861} Helping Hands · {npc:263380} Ghostmaw
	["{npc:258963} stands at the camp's south end. He sets off for {npc:258935}, south-east of the camp, as soon as you take {quest:94861}: go with him and keep the attackers off, and wait if {npc:263380} is in sight. If it fails, {npc:258963} offers the quest again."] = "{npc:258963} стоит в южной части лагеря. Он отправляется к NPC {npc:258935}, к юго-востоку от лагеря, как только вы примете задание «{quest:94861}»: идите с ним и отбивайте нападающих, а если виден {npc:263380} – подождите. При провале {npc:258963} снова предложит задание.",
	-- {npc:258963} Hurley · {npc:258935} Curly
	["go with {npc:258963} to save {npc:258935}"] = "идите с NPC {npc:258963}, чтобы спасти NPC {npc:258935}",

	-- Step 23: Wheeler's Grange
	-- {area:16724} Farholde Keep · {npc:258317} Benjy Wheeler · {area:16725} Wheeler's Grange
	["East along the road towards {area:16724}: hand {npc:258317} his murlocs as you pass {area:16725}."] = "На восток по дороге к месту {area:16724}: по пути через {area:16725} сдайте мурлоков NPC {npc:258317}.",

	-- Step 24: Farholde Keep
	-- {area:16724} Farholde Keep · {npc:257087} Gretchen Mayberry · {npc:260070} Bertrand Ironbrow · {npc:260080} Ember Bladewhisper · {npc:263613} Brother Lowley · {npc:257558} Demar Brant · {npc:257591} Ashe Amberhall
	["On east along the road to {area:16724}. {npc:257087}, the gryphon master, stands at its western gate; {npc:260070} and {npc:260080} are on the way in, {npc:263613} tends the wounded by the barracks, {npc:257558} and {npc:257591} wait in the keep at the east end, and the inn is in the south of the walls."] = "Дальше на восток по дороге к месту {area:16724}. {npc:257087}, распорядительница полетов, стоит у западных ворот; {npc:260070} и {npc:260080} – по пути внутрь, {npc:263613} лечит раненых у казарм, {npc:257558} и {npc:257591} ждут в крепости в восточной части, а таверна – в южной части за стенами.",
	-- {npc:257087} Gretchen Mayberry
	["{npc:257087}, at the western gate"] = "{npc:257087} – у западных ворот",
	-- {npc:257558} Demar Brant
	["{npc:257558}, in the keep"] = "{npc:257558} – в крепости",
	-- {quest:94877} Saving Sunnyglade
	["{quest:94877}: for later in this guide"] = "«{quest:94877}»: на потом, позже в этом гайде",
	-- {npc:257591} Ashe Amberhall · {quest:94881} Curious Trinkets
	["{npc:257591}: {quest:94881}, for later in this guide"] = "{npc:257591}: {quest:94881}, понадобится позже в этом гайде",
	-- {quest:94879} Scraps of Knowledge
	["{quest:94879}, for later in this guide"] = "{quest:94879}, понадобится позже в этом гайде",
	-- {npc:259863} Cassandra Wheeler · {quest:95330} Love Thy Neighbor · {area:16736} Turner's Logging Camp
	["{npc:259863}, by the inn: {quest:95330}, for {area:16736} later in this guide"] = "{npc:259863}, у таверны: {quest:95330}, для локации {area:16736} позже в этом гайде",
	-- {npc:257595} Barracks Master Harlan
	["{npc:257595}, at the inn"] = "{npc:257595}, в таверне",

	-- Step 25: The cathedral
	["The cathedral"] = "Собор",
	-- {npc:262031} Sister Rowland · {area:16724} Farholde Keep · {npc:272437} Marla Bell · {npc:271742} Abbot Schuncke
	["{npc:262031} keeps the old cathedral at the south-west corner of {area:16724}. The bats roost in its upper floor; {npc:272437} sells the holy candles beside it; the graves are in the chapel graveyard.\n{npc:271742}, an elite of level 53, stands in the cathedral: he leaves you be, so never attack him, and pull the bats away from him."] = "{npc:262031} присматривает за старым собором в юго-западном углу локации {area:16724}. Летучие мыши гнездятся на его верхнем этаже; {npc:272437} продает святые свечи рядом с ним; могилы – на кладбище у часовни.\n{npc:271742}, элита 53-го уровня, стоит в соборе: он вас не тронет, поэтому никогда не атакуйте его и уводите летучих мышей подальше от него.",
	-- {item:17028} Holy Candle · {npc:272437} Marla Bell
	["{item:17028}, from {npc:272437}"] = "{item:17028}: у NPC {npc:272437}",
	-- {item:269997} Bundle of Candles
	["{item:269997}, on the graves"] = "{item:269997} – на могилах",

	-- Step 26: Wheeler's Grange
	-- {area:16725} Wheeler's Grange · {npc:258317} Benjy Wheeler
	["West to {area:16725}: {npc:258317} stands by the farmhouse."] = "На запад, в {area:16725}: {npc:258317} стоит у фермерского дома.",

	-- Step 27: The stables
	["The stables"] = "Конюшни",
	["Search around the stables south of the farmhouse for the horses' tracks; the bundles of hay lie around the farm."] = "Ищите следы лошадей вокруг конюшен к югу от фермерского дома; связки сена лежат по всей ферме.",

	-- Step 29: The coyote den
	["The coyote den"] = "Логово койотов",
	-- {npc:258522} Sootfur
	-- plural, as words: Plains Coyotes = {npc:259267} Plains Coyote
	["The coyotes den in the hills south of the farm: {npc:258522}, the big dark one, sits at the back of it; the Plains Coyotes around it drop the pelts."] = "Логово койотов – в холмах к югу от фермы: {npc:258522}, большой темный койот, сидит в глубине; шкуры падают с равнинных койотов вокруг.",

	-- Step 30: The lost horse
	["The lost horse"] = "Потерявшаяся лошадь",
	["One of Benjy's horses ran north up the river, past the farm. Give it the feed, then lead it home."] = "Одна из лошадей Бенджи убежала на север вверх по реке, мимо фермы. Дайте ей корм, затем отведите домой.",
	-- {area:16725} Wheeler's Grange
	["walk it back to {area:16725}"] = "отведите ее обратно в {area:16725}",

	-- Step 32: Foreman's Crate
	-- {area:16729} Terral's Watch
	["North up the track towards {area:16729}: the foreman's crate lies by the road."] = "На север по тропе к локации {area:16729}: ящик бригадира лежит у дороги.",

	-- Step 33: Terral's Watch
	-- {npc:259352} Watcher Cornelius · {area:16729} Terral's Watch
	["{npc:259352} holds {area:16729}, the tower on the plains north-east of the crate."] = "{npc:259352} охраняет {area:16729} – башню на равнине к северо-востоку от ящика.",

	-- Step 34: The plains
	["The plains"] = "Равнины",
	-- {quest:95983} A Feast for Buzzards · {npc:263380} Ghostmaw
	-- plural, as words: Rog'mar Poachers = {npc:259052} Rog'mar Poacher
	["The Rog'mar Poachers hunt the plains north of the tower; the Wildplains lions roam among them. A picked carcass lies in the grass east of the tower: its skull starts {quest:95983}.\nCareful: {npc:263380}, an elite (level 42), hunts along the river west of the plains: keep an eye on the riverbank."] = "Браконьеры Рог'мара охотятся на равнинах к северу от башни; среди них бродят львы диких равнин. Обглоданная туша лежит в траве к востоку от башни: ее череп начинает задание {quest:95983}.\nОсторожно: {npc:263380}, элита (42-й уровень), охотится вдоль реки к западу от равнин: следите за берегом.",

	-- Step 35: Terral's Watch
	-- {quest:94928} A Few Furs for Friz · {area:16727} Powderfuse Port
	["{quest:94928}: for {area:16727}, keep it"] = "{quest:94928}: для места {area:16727}, сохраните",
	-- {quest:95984} Song of the Strider · {npc:263367} Sleebo Fizzlespout
	["{quest:95984}: for later, where the tallstriders graze by {npc:263367}'s workshop; keep it"] = "{quest:95984}: на потом, там, где пасутся долгоноги у мастерской NPC {npc:263367}; сохраните",
	-- {quest:95064} Preventative Measures · {area:16743} Rog'mar
	["{quest:95064}: for later, at the Horde's training grounds north of {area:16743}"] = "{quest:95064}: на потом, на тренировочной площадке Орды к северу от места {area:16743}",
	-- {quest:96125} In Need of Relief · {npc:259057} Dunston Willis · {area:16726} Bolder'ok
	["{quest:96125}: for {npc:259057} in {area:16726}, keep it"] = "{quest:96125}: для NPC {npc:259057} ({area:16726}), сохраните",
	-- {quest:95426} Rog'mar Supplies
	["{quest:95426}: for later, the same training grounds"] = "{quest:95426}: на потом, та же тренировочная площадка",

	-- Step 36: Farholde Keep
	-- {area:16724} Farholde Keep
	["South back to {area:16724}."] = "Обратно на юг, в {area:16724}.",
	-- {quest:96009} High Stakes · {area:16736} Turner's Logging Camp
	["{quest:96009}: for {area:16736} later in this guide"] = "{quest:96009}: для места {area:16736}, позже в этом гайде",

	-- Step 37: WANTED: Ghostmaw
	-- {npc:263380} Ghostmaw · {area:16725} Wheeler's Grange · {area:16729} Terral's Watch · {npc:259859} Wheatley
	["{npc:263380} is an elite (level 42) who hunts along the river between {area:16725} and {area:16729}, on your way north later in this guide: grouping up is advised. The poster hangs by the keep; {npc:259859}, who takes the fang, stands south of the inn."] = "{npc:263380} – элита (42-й уровень), охотится вдоль реки между {area:16725} и {area:16729}, по пути на север позже в этом гайде: лучше собрать группу. Объявление висит у крепости; {npc:259859}, который примет клык, стоит к югу от таверны.",
	-- {object:645166} WANTED! (no name in this language: may be words)
	["the {object:645166} poster"] = "объявление «{object:645166}»",

	-- Step 38: WANTED: Blademaster Kaijo
	-- {npc:263071} Blademaster Kaijo · {area:16743} Rog'mar
	["{npc:263071} is an elite (level 42) at the Horde's training grounds north of {area:16743}, where this guide goes later: grouping up is advised."] = "{npc:263071} – элита (42-й уровень) на тренировочной площадке Орды к северу от места {area:16743}, куда гайд ведет позже: лучше собрать группу.",
	-- {object:707245} Wanted (no name in this language: may be words)
	["the {object:707245} poster"] = "объявление «{object:707245}»",

	-- Step 39: Ghostmaw
	-- {npc:263380} Ghostmaw · {area:16725} Wheeler's Grange · {area:16729} Terral's Watch
	["{npc:263380}, the elite, hunts along the river between {area:16725} and {area:16729}, on your way north."] = "{npc:263380}, элита, охотится вдоль реки между {area:16725} и {area:16729}, по пути на север.",

	-- Step 40: Sunnyglade
	-- {area:16724} Farholde Keep · {area:16729} Terral's Watch · {area:16723} Sunnyglade · {area:16743} Rog'mar · {npc:259158} Fuzzle · {npc:256831} Apprentice Claire · {npc:258697} Farmer Elbrim
	["North from {area:16724}, past {area:16729} and across the river, to {area:16723}, the farm town the Twilight cult holds; keep clear of {area:16743}, the Horde's fort east of the town. {npc:259158} the kobold hides in the middle of the town, {npc:256831} at its eastern edge, and {npc:258697} waits at his farm on the north-eastern edge."] = "На север от места {area:16724}, мимо {area:16729} и через реку, в {area:16723} – фермерский городок, захваченный Сумеречным культом; держитесь подальше от {area:16743}, ордынской крепости к востоку от городка. Кобольд {npc:259158} прячется в центре городка, {npc:256831} – на его восточной окраине, а {npc:258697} ждет на своей ферме на северо-восточной окраине.",

	-- Step 41: The Twilight cult
	["The Twilight cult"] = "Сумеречный культ",
	-- {area:16723} Sunnyglade · {item:266148} Farmers' Mementos · {item:4338} Mageweave Cloth · {npc:263613} Brother Lowley · {area:16724} Farholde Keep · {quest:94885} Field Marshal's Log · {npc:256899} Chogg'Zac · {npc:263380} Ghostmaw
	-- plural, as words: Twilight Raiders = {npc:256952} Twilight Raider
	["The cultists fill the streets and fields of {area:16723}. Start at the ritual circles in the middle (fill Claire's catalyst there), work west through the burnt houses to the edge of town, then back north-east to the loose soil west of Elbrim's farm: bury the {item:266148} the Twilight Raiders drop there. The charms, pages and finger bones drop from the cultists.\nKeep the {item:4338} they drop: {npc:263613} in {area:16724} asks for twenty when you are back there. Now and then a cultist drops the {quest:94885}: right-click it to start the quest.\nCareful: {npc:256899}, an elite ogre (level 41), walks the western streets of {area:16723}, around 44-47,47-52. Pull the cultists out towards you and let him pass; players died here more than anywhere else in the zone.\n{npc:263380}, the river's elite (level 42), can wander up from the south-western fields: let him pass."] = "Культисты заполонили улицы и поля ({area:16723}). Начните с ритуальных кругов в центре (там наполните катализатор Клэр), пройдите на запад через сгоревшие дома до края городка, затем вернитесь на северо-восток к рыхлой земле к западу от фермы Элбрима: закопайте там {item:266148}, которые выпадают из Сумеречных грабителей. Амулеты, страницы и кости пальцев выпадают из культистов.\nСохраняйте {item:4338} с культистов: {npc:263613} ({area:16724}) попросит двадцать штук, когда вернетесь. Иногда из культиста выпадает {quest:94885}: нажмите на него правой кнопкой мыши, чтобы начать задание.\nОсторожно: {npc:256899}, элитный огр (41-й уровень), бродит по западным улицам ({area:16723}), около 44-47,47-52. Выманивайте культистов к себе и пропускайте его; здесь игроки гибли чаще, чем где-либо еще в зоне.\n{npc:263380}, речная элита (42-й уровень), может забрести с юго-западных полей: пропустите его.",
	-- {item:269990} Crystal Catalyst
	["fill the {item:269990} at the ritual circles"] = "наполните {item:269990} у ритуальных кругов",
	-- {object:621813} Loose Soil (no name in this language: may be words)
	["{object:621813}: bury the mementos"] = "{object:621813}: закопайте памятные вещи",
	-- {quest:94885} Field Marshal's Log
	["{quest:94885}: only if a cultist dropped the log"] = "{quest:94885}: только если из культиста выпал журнал",

	-- Step 43: Cut Off the Heads
	-- {npc:256899} Chogg'Zac · {area:16723} Sunnyglade · {npc:257591} Ashe Amberhall · {area:16724} Farholde Keep
	["{npc:256899}, the two-headed ogre, is an elite (level 41) at the western edge of {area:16723}: grouping up is advised. Claire then has the filled catalyst for {npc:257591} in {area:16724}."] = "{npc:256899}, двухголовый огр, – элита (41-й уровень) на западной окраине ({area:16723}): лучше собрать группу. Затем Клэр отдаст наполненный катализатор для NPC {npc:257591} ({area:16724}).",
	-- {quest:94884} An Unsettling Discovery · {npc:257591} Ashe Amberhall · {area:16724} Farholde Keep
	["{quest:94884}: for {npc:257591} in {area:16724}"] = "{quest:94884}: для NPC {npc:257591} ({area:16724})",

	-- Step 44: Fuzzle
	-- {npc:259158} Fuzzle · {area:16723} Sunnyglade
	["{npc:259158} wants out of {area:16723}: lead him west to his treasure at the edge of town and keep the cultists off him."] = "{npc:259158} хочет выбраться из города {area:16723}: отведите его на запад к его сокровищу на окраине и не подпускайте к нему культистов.",
	-- {npc:259158} Fuzzle · {area:16723} Sunnyglade
	["lead {npc:259158} out of {area:16723} to his treasure, west of the town"] = "выведите {npc:259158} из города {area:16723} к его сокровищу к западу от города",

	-- Step 45: Farmer Elbrim
	["Back east through the town to Elbrim's farm: the doll and the locket are in the burnt farmhouse beside it."] = "Возвращайтесь на восток через город к ферме Элбрима: кукла и медальон лежат в сгоревшем доме рядом с ней.",

	-- Step 46: The Rog'mar training grounds
	-- {area:16743} Rog'mar
	["The {area:16743} training grounds"] = "Тренировочный лагерь ({area:16743})",
	-- {area:16743} Rog'mar · {npc:263071} Blademaster Kaijo · {npc:263615} Krek the Noxious
	-- plural, as words: Rog'mar Grunts = {npc:255996} Rog'mar Grunt
	["North-east of Elbrim's farm, the Horde drills its trainees in the fields north of {area:16743}. Stay north of the fort: its guards are far above your level. The supply crates lie around the drill grounds. Three elites work this ground: {npc:263071} (42) walks among the trainees, {npc:263615} (42) lurks at the north end, and Komuk (45), a Horde elite, patrols the hills to the east; give each of them room.\nCareful: Rog'mar Grunts (55) guard the fort's north wall, around 59,39 to 61,41. Leave the crates and trainees by the wall and take the ones further north, around 57-61,34-37."] = "К северо-востоку от фермы Элбрима Орда муштрует новобранцев на полях к северу от крепости ({area:16743}). Держитесь севернее крепости: ее стражники намного выше вас по уровню. Ящики с припасами разбросаны вокруг плаца. Здесь ходят три элиты: {npc:263071} (42) бродит среди новобранцев, {npc:263615} (42) таится в северной части, а Комук (45), элита Орды, патрулирует холмы к востоку; держитесь от каждого подальше.\nОсторожно: рубаки Рог'мара (55) охраняют северную стену крепости, примерно от 59,39 до 61,41. Не трогайте ящики и новобранцев у стены, берите те, что севернее, около 57-61,34-37.",

	-- Step 47: Blademaster Kaijo
	-- {npc:263071} Blademaster Kaijo
	["{npc:263071}, the elite, walks the training grounds."] = "{npc:263071} (элита) бродит по тренировочному лагерю.",

	-- Step 48: Sleebo Fizzlespout's workshop
	-- {npc:263367} Sleebo Fizzlespout
	["{npc:263367}'s workshop"] = "Мастерская: {npc:263367}",
	-- {area:16743} Rog'mar · {npc:263367} Sleebo Fizzlespout · {area:16726} Bolder'ok
	["South-east, round {area:16743}'s east side, to {npc:263367}'s workshop on the hill. Komuk and the {area:16726} ogres walk the road east of the fort: let them pass before you cross it."] = "На юго-восток, в обход крепости ({area:16743}) с востока, к мастерской на холме ({npc:263367}). Комук и огры ({area:16726}) ходят по дороге к востоку от крепости: пропустите их, прежде чем переходить ее.",

	-- Step 49: The tallstriders and the marsh
	["The tallstriders and the marsh"] = "Долгоноги и болото",
	-- plural, as words: Roving Tallstriders = {npc:263348} Roving Tallstrider
	["The Roving Tallstriders graze the meadows south-west of the workshop; further south-west the marsh bubbles with gas: fill the vials at the vents."] = "Бродячие долгоноги пасутся на лугах к юго-западу от мастерской; дальше на юго-запад на болоте пузырится газ: наполните склянки у выходов газа.",

	-- Step 50: Terral's Watch
	-- {npc:259352} Watcher Cornelius
	["{npc:259352}'s tower stands just south-west of the marsh."] = "Башня, где стоит {npc:259352}, – чуть юго-западнее болота.",
	-- {quest:95066} The Rog'mar Situation · {npc:257558} Demar Brant · {area:16724} Farholde Keep
	["{quest:95066}: for {npc:257558} in {area:16724}, keep it"] = "{quest:95066}: для NPC {npc:257558} ({area:16724}), не сдавайте пока",

	-- Step 51: Farholde Keep
	-- {area:16724} Farholde Keep · {npc:257591} Ashe Amberhall · {npc:257558} Demar Brant · {area:16723} Sunnyglade · {npc:263089} Tessa Dawnbright · {npc:263613} Brother Lowley
	["South across the plains to {area:16724}: {npc:257591} and {npc:257558} stand together in the keep at the east end, {npc:257591} first, her news is what Brant's next orders wait on. With {area:16723} saved, {npc:263089} by the orchard and {npc:263613} by the barracks have work for you too."] = "На юг через равнины, цель: {area:16724}. {npc:257591} и {npc:257558} стоят вместе в крепости в восточной части; сначала {npc:257591} – от ее вестей зависят следующие приказы Бранта. Город {area:16723} спасен, так что {npc:263089} у сада и {npc:263613} у казарм тоже дадут вам задания.",
	-- {quest:94907} A Small Favor
	["{quest:94907}: for later in this guide"] = "{quest:94907}: понадобится позже в этом гайде",
	-- {quest:95329} Out in the Field · {npc:259352} Watcher Cornelius · {area:16729} Terral's Watch
	["{quest:95329}: for {npc:259352} at {area:16729}, keep it"] = "{quest:95329}: для NPC {npc:259352} ({area:16729}), не сдавайте пока",
	-- {quest:94886} The Western Front
	["{quest:94886}: for later in this guide"] = "{quest:94886}: понадобится позже в этом гайде",
	-- {npc:263613} Brother Lowley · {item:4338} Mageweave Cloth · {area:16723} Sunnyglade
	["{npc:263613}: twenty {item:4338}, from {area:16723}'s cultists and the pirates; hand it in when you are back"] = "{npc:263613}: двадцать штук «{item:4338}» с культистов ({area:16723}) и пиратов; сдайте, когда вернетесь",

	-- Step 52: Tessa Dawnbright
	-- {npc:263089} Tessa Dawnbright
	["{npc:263089} stands west of the inn, by the orchard: the apples hang on the trees around it."] = "{npc:263089} стоит к западу от таверны, у сада: яблоки висят на деревьях вокруг.",

	-- Step 53: Coyote pelts
	["Coyote pelts"] = "Шкуры койотов",
	-- {area:16725} Wheeler's Grange
	-- plural, as words: Plains Coyotes = {npc:259267} Plains Coyote
	["The Plains Coyotes roam west and south-west of the keep, towards {area:16725}."] = "Равнинные койоты бродят к западу и юго-западу от крепости, в сторону места {area:16725}.",

	-- Step 54: Tessa Dawnbright
	-- {quest:95961} Stepped Out · {npc:263120} Gray Dawnbright · {area:16727} Powderfuse Port
	["{quest:95961}: for {npc:263120} in {area:16727}, keep it"] = "{quest:95961}: для NPC {npc:263120} ({area:16727}), сохраните",

	-- Step 55: King of the Wild Plains
	-- {npc:263315} Ombassa · {area:16729} Terral's Watch
	["{npc:263315}, an elite lion (level 41), prowls the plains north of {area:16729}, on your way back north: grouping up is advised."] = "{npc:263315}, элитный лев 41-го уровня, бродит по равнинам к северу от места {area:16729}, по пути обратно на север: лучше собрать группу.",

	-- Step 57: Sleebo Fizzlespout
	-- {npc:263367} Sleebo Fizzlespout
	["North-east to {npc:263367}'s workshop. {npc:263367}'s stress test is a fight with his G45-B4G beside the workshop: hand the quest in once it's beaten."] = "На северо-восток, к мастерской NPC {npc:263367}. Испытание под нагрузкой от NPC {npc:263367} — бой с его G45-B4G у мастерской: победите его и сдайте задание.",
	["the stress test: beat G45-B4G beside the workshop"] = "испытание под нагрузкой: победите G45-B4G у мастерской",

	-- Step 58: Powderfuse Port
	-- {area:16727} Powderfuse Port · {npc:255897} Friz Frazzlespark · {npc:263120} Gray Dawnbright · {npc:255894} Innkeeper Zizplink · {npc:259962} Fimbo Greasemitz · {npc:259961} Wharfmaster Whizzbuzz · {npc:260487} Gritta Chumwater · {npc:260565} Kor'gar · {npc:260560} Krikshank
	["East down the road to {area:16727}, the goblins' harbour. {npc:255897} keeps a stall at the west end of the docks; {npc:263120}, {npc:255894} and {npc:259962} are at the inn, and {npc:259961} works the north pier. Zizplink's drink needs three things the port's traders sell: the chum from {npc:260487}, the degreaser and the old poison from {npc:260565} and {npc:260560}, by {npc:255897}'s stall."] = "На восток по дороге в гоблинскую гавань ({area:16727}). {npc:255897} держит лавку у западного края причалов; {npc:263120}, {npc:255894} и {npc:259962} — в таверне, а {npc:259961} работает на северном пирсе. Для напитка Зизплинка нужны три вещи, которые продают торговцы порта: наживка у NPC {npc:260487}, жирорастворитель и старый яд у NPC {npc:260565} и {npc:260560}, возле лавки NPC {npc:255897}.",
	-- {quest:95059} Frazzlespark's Crate · {npc:257558} Demar Brant · {area:16724} Farholde Keep
	["{quest:95059}: for {npc:257558} in {area:16724}, keep it"] = "{quest:95059}: для NPC {npc:257558} ({area:16724}), сохраните",
	-- {item:271657} Fresh Chum · {npc:260487} Gritta Chumwater
	["{item:271657}, from {npc:260487}"] = "{item:271657}: у NPC {npc:260487}",
	-- {item:271653} Goblin Degreaser · {npc:260565} Kor'gar
	["{item:271653}, from {npc:260565}"] = "{item:271653}: у NPC {npc:260565}",
	-- {item:271654} Expired Poison · {npc:260560} Krikshank
	["{item:271654}, from {npc:260560}"] = "{item:271654}: у NPC {npc:260560}",
	-- {object:628948} WANTED! (no name in this language: may be words) · {npc:260235} Trapclaw
	["The {object:628948} poster by the inn: {npc:260235}"] = "Плакат «{object:628948}» у таверны: {npc:260235}",

	-- Step 59: WANTED: Old Rot-Chum
	-- {npc:257001} Old Rot-Chum
	["{npc:257001} is an elite (level 42) on the south shore: grouping up is advised."] = "{npc:257001} — элита (42-й уровень) на южном берегу: лучше собрать группу.",
	-- {object:628948} WANTED! (no name in this language: may be words)
	["The {object:628948} poster by the inn"] = "Плакат «{object:628948}» у таверны",

	-- Step 60: The murlocs, south-west
	["The murlocs, south-west"] = "Мурлоки на юго-западе",
	-- {quest:95260} Terrors From the Deep · {npc:260231} Argo Brinewhistle
	["South-west along the shore from the port: the saltwater murlocs camp on the beaches. On the way, a painted hide is stretched beside the path: it starts {quest:95260} for {npc:260231} at the docks."] = "На юго-запад вдоль берега от порта: морские мурлоки стоят лагерями на пляжах. По пути у тропы растянута раскрашенная шкура: она начинает задание «{quest:95260}» для NPC {npc:260231} на причалах.",

	-- Step 62: Back through the port
	["Back through the port"] = "Обратно через порт",
	["Back north along the shore: hand in the murlocs and the hide on the docks on your way to the crawlers."] = "Обратно на север вдоль берега: по пути к ползунам сдайте мурлоков и шкуру на причалах.",
	-- {quest:95261} It Takes Guts
	["{quest:95261}: the beasts' entrails come as you go; the mushrooms are for later"] = "{quest:95261}: потроха зверей соберутся по ходу; грибы — позже",

	-- Step 63: The crawlers and Trapclaw
	-- {npc:260235} Trapclaw
	["The crawlers and {npc:260235}"] = "Ползуны и {npc:260235}",
	-- {npc:259962} Fimbo Greasemitz · {npc:260231} Argo Brinewhistle · {npc:260235} Trapclaw · {npc:259758} Gul'gash
	["North along the beach from the docks: the crawlers drop the meat for {npc:259962} and the spittle for Zizplink, and their entrails count for {npc:260231}. {npc:260235}, a big crab, scuttles along the rocks east of the docks. {npc:259758}, a rare elite of level 49, roams this coast from the docks up to the pirates' camp: if you see him, keep well away."] = "На север по пляжу от причалов: с ползунов падает мясо для NPC {npc:259962} и слюна для Зизплинка, а их потроха идут в зачет для NPC {npc:260231}. {npc:260235}, большой краб, снует по скалам к востоку от причалов. {npc:259758}, редкая элита 49-го уровня, бродит по этому берегу от причалов до лагеря пиратов: если увидите его, держитесь подальше.",

	-- Step 64: The Eastsea pirates
	["The Eastsea pirates"] = "Пираты Восточного моря",
	-- {npc:259758} Gul'gash
	["North-east along the coast to the pirates' camp on the cliffs. The buccaneers and musketeers carry the smuggled goods. {npc:259758} walks the camp too: keep an eye out for him."] = "На северо-восток вдоль побережья к лагерю пиратов на утесах. Контрабандный товар носят флибустьеры и мушкетеры. По лагерю также бродит {npc:259758}: следите за ним.",

	-- Step 65: Powderfuse Port
	["Back to the port, from the north pier west through the docks."] = "Возвращайтесь в порт: от северного пирса на запад через доки.",
	-- {quest:95122} Unchecked Expansion
	["{quest:95122}: for later in this guide"] = "{quest:95122}: на потом, позже в этом гайде",
	-- {quest:95123} A Blast Ye Scurvy Dogs!
	["{quest:95123}: for later in this guide"] = "{quest:95123}: на потом, позже в этом гайде",
	-- {quest:95975} Her World
	["{quest:95975}: for later, the wildflowers west of the port"] = "{quest:95975}: на потом, полевые цветы к западу от порта",
	-- {quest:95293} Smuggler's Special · {npc:260390} Captain Bentcoin
	["{quest:95293}: for {npc:260390} at the pirates' camp"] = "{quest:95293}: для NPC {npc:260390} в лагере пиратов",

	-- Step 67: Beast Entrails as you go
	-- {item:268632} Beast Entrails
	["{item:268632} as you go"] = "{item:268632} по пути",
	-- {zone:2548} Riverglades · {item:268632} Beast Entrails · {npc:260231} Argo Brinewhistle · {npc:257001} Old Rot-Chum · {npc:263380} Ghostmaw
	["Most beasts in the {zone:2548} drop {item:268632} for {npc:260231}: the shore crawlers on this coast and the boars on the ridge west of the pirates.\nCareful: {npc:257001} (elite, 42), Komuk (a Horde elite, 45) and {npc:263380} (elite, 42) range over the zone's wilds: take your beasts away from them."] = "Почти со всех зверей в зоне {zone:2548} падают {item:268632} для NPC {npc:260231}: с береговых ползунов на этом побережье и с кабанов на гребне к западу от пиратов.\nОсторожно: {npc:257001} (элита, 42), Комук (элита Орды, 45) и {npc:263380} (элита, 42) бродят по диким землям зоны: уводите зверей подальше от них.",

	-- Step 68: Level 44.4 on the Eastsea pirates
	["Level 44.4 on the Eastsea pirates"] = "Уровень 44.4 на пиратах Восточного моря",
	-- {npc:259758} Gul'gash · {area:1517} Uldaman
	["Before the second wave: its raiders and bombardiers (43-45) and the pirates' ships after them are a level over you below 44.4. Top up on the first camp's buccaneers and musketeers (41-43) at its south-west end, away from the port. {npc:259758}, a rare elite of level 49, roams these cliffs: if you see him, keep well away. Or, with a group, run the {area:1517} dungeon instead."] = "Перед второй волной: ее налетчики и бомбардиры (43-45), а за ними и корабли пиратов, на уровень выше вас, пока у вас меньше 44.4. Добейте уровень на флибустьерах и мушкетерах (41-43) первого лагеря у его юго-западного края, подальше от порта. По этим утесам бродит {npc:259758}, редкая элита 49 уровня: увидев его, держитесь подальше. Или, если есть группа, пройдите вместо этого подземелье {area:1517}.",
	-- {npc:257901} Eastsea Buccaneer
	["grind on {npc:257901}"] = "убивайте: {npc:257901}",

	-- Step 69: The pirates' second wave
	["The pirates' second wave"] = "Вторая волна пиратов",
	-- {npc:259758} Gul'gash
	["North along the coast from the port: the Eastsea raiders and bombardiers have dug in on the slopes west of the buccaneers' camp, among their powder kegs. They stand close together: pull them one at a time. {npc:259758}, a rare elite of level 49, roams these cliffs and the beach below: if you see him, keep well away."] = "На север вдоль побережья от порта: налетчики и бомбардиры Восточных морей окопались на склонах к западу от лагеря флибустьеров, среди своих пороховых бочек. Они стоят плотно: выманивайте по одному. По этим утесам и пляжу внизу бродит {npc:259758}, редкая элита 49 уровня: увидев его, держитесь подальше.",

	-- Step 70: Captain Bentcoin
	-- {npc:260390} Captain Bentcoin · {npc:260391} Captain Haynes
	["East along the cliffs to the far end of the pirates' camp: {npc:260390} waits by the water, {npc:260391} beside him."] = "На восток вдоль утесов к дальнему краю лагеря пиратов: {npc:260390} ждет у воды, рядом – {npc:260391}.",

	-- Step 71: Powderfuse Port
	["Back to the port."] = "Возвращайтесь в порт.",

	-- Step 72: The pirates' ships
	["The pirates' ships"] = "Корабли пиратов",
	-- {quest:95124} Admiral Lamora · {npc:259758} Gul'gash
	["Out to the pirates' cliffs once more. Plant Whizzbuzz's charges on the three ships moored below the camp, south to north; {quest:95124} (level 45) stands by the middle one, with her loot chest beside her. Keep an eye out for {npc:259758} on the way."] = "Снова к утесам пиратов. Заложите заряды Виззбазза на три корабля, стоящих под лагерем, с юга на север; {quest:95124} (45 уровень) стоит у среднего, рядом с ней – ее сундук с добычей. По пути следите за NPC {npc:259758}.",
	-- {item:268505} Remote Explosive Charge
	["{item:268505}, the southern ship"] = "{item:268505}, южный корабль",
	["the middle ship"] = "средний корабль",
	["the northern ship"] = "северный корабль",

	-- Step 73: Rotflesh Mushrooms
	-- plural, as words: Rotflesh Mushrooms = {item:268664} Rotflesh Mushroom
	["Rotflesh Mushrooms"] = "Гнилогрибы",
	-- plural, as words: Rotflesh Mushrooms = {item:268664} Rotflesh Mushroom · Mature Paletusks = {npc:255851} Mature Paletusk
	["West from the northern ship, up the ridge: the Rotflesh Mushrooms grow among the rocks, close to the Twilight ogres' camp. The Mature Paletusks on the ridge give entrails too."] = "На запад от северного корабля, вверх по гребню: гнилогрибы растут среди камней, рядом с лагерем огров из Сумеречного Молота. Взрослые бледноклыки на гребне тоже дают внутренности.",

	-- Step 74: Bolder'ok
	-- {area:16726} Bolder'ok · {npc:259057} Dunston Willis
	["North-west to {area:16726}, the ogres' town. Its ogres side with the Horde and attack you on sight, and Clugfist on his hill in the middle is an elite (level 50): keep to the town's north-eastern edge, where {npc:259057} hides."] = "На северо-запад, в {area:16726} – город огров. Местные огры на стороне Орды и нападают сразу, а Клагфист на холме в центре – элита (50 уровень): держитесь северо-восточного края города, где прячется {npc:259057}.",

	-- Step 75: Gronok's Key
	-- {npc:263749} Gronok the Butcher · {npc:259057} Dunston Willis · {item:275043} Bloodmaster's Ring
	["{npc:263749} (level 44) carries the key: he paces the lanes south of {npc:259057}'s hut.\nThe {item:275043} lies just west of the lanes: its fighters (elites, 41-45) only fight in a bout, so leave them be."] = "Ключ у NPC {npc:263749} (уровень 44): он ходит по улочкам к югу от хижины, где сидит {npc:259057}.\nПредмет {item:275043} – сразу к западу от улочек: его бойцы (элита, 41-45) дерутся только в поединке, так что не трогайте их.",

	-- Step 76: Dunston Willis
	-- {npc:259057} Dunston Willis · {area:16726} Bolder'ok
	["Free him, then get him out: {npc:259057} fights his way out of {area:16726}, and you keep the ogres off him. If he falls, take the quest from him again."] = "Освободите его и выведите: {npc:259057} пробивается наружу ({area:16726}), а вы отгоняете от него огров. Если он погибнет, возьмите задание у него снова.",
	-- {npc:259057} Dunston Willis · {area:16726} Bolder'ok
	["help {npc:259057} break out of {area:16726}"] = "помогите NPC {npc:259057} вырваться отсюда: {area:16726}",

	-- Step 77: Finish the Beast Entrails
	-- {item:268632} Beast Entrails
	["Finish the {item:268632}"] = "Добудьте все {item:268632}",
	-- {npc:259758} Gul'gash
	["South-east out of the hills towards the port: the shore crawlers on the beach north of the docks are the quickest entrails. {npc:259758} wanders down to this beach too."] = "На юго-восток из холмов к порту: береговые ползуны на пляже к северу от причалов – самый быстрый источник внутренностей. {npc:259758} тоже забредает на этот пляж.",

	-- Step 78: Powderfuse Port
	["Down to the port."] = "Спускайтесь в порт.",
	-- {quest:95267} The Monster Surfaces · {npc:257001} Old Rot-Chum
	["{quest:95267}: a big beast in the shallows south-west of the port, near {npc:257001}, the elite"] = "{quest:95267}: крупный зверь на отмели к юго-западу от порта, рядом с NPC {npc:257001} (элита)",

	-- Step 79: The Monster Surfaces
	-- {npc:260244} Monstrous Threshadon · {npc:257001} Old Rot-Chum
	["The {npc:260244} prowls the shallows south-west of the port, below the murlocs' beaches. {npc:257001}, an elite, walks the shore close by: give him room."] = "{npc:260244} рыщет по отмели к юго-западу от порта, ниже пляжей мурлоков. {npc:257001} (элита) ходит по берегу неподалеку: держитесь от него подальше.",

	-- Step 81: The meadows
	["The meadows"] = "Луга",
	-- {npc:263367} Sleebo Fizzlespout
	["West of the port, the wildflowers grow in the meadows below {npc:263367}'s workshop."] = "К западу от порта полевые цветы растут на лугах под мастерской, где работает {npc:263367}.",

	-- Step 82: Farholde Keep
	-- {area:16724} Farholde Keep · {npc:257558} Demar Brant
	["South-west across the plains to {area:16724}: {npc:257558} in the keep at the east end."] = "На юго-запад через равнины: {area:16724}. {npc:257558} – в крепости на восточном краю.",

	-- Step 83: Demar Brant
	-- {quest:94887} Saving Marshal Ryan
	["{quest:94887}: for later in this guide"] = "{quest:94887}: понадобится позже в этом гайде",

	-- Step 86: Brother Lowley
	-- {npc:263613} Brother Lowley · {npc:262031} Sister Rowland
	["{npc:263613} tends the wounded beside the barracks: bandage three of his soldiers, then he has a note for {npc:262031} in the cathedral."] = "{npc:263613} ухаживает за ранеными у казарм: перевяжите трех его солдат, и он даст записку для NPC {npc:262031} в соборе.",
	-- {item:272126} Makeshift Bandages
	-- plural, as words: Wounded Soldiers = {npc:263614} Wounded Soldier
	["{item:272126}, on the Wounded Soldiers beside him"] = "{item:272126} – на израненных солдатах рядом с ним",

	-- Step 87: Farholde Keep, the west side
	-- {area:16724} Farholde Keep
	["{area:16724}, the west side"] = "{area:16724}, западная часть",
	-- {npc:263089} Tessa Dawnbright · {npc:259859} Wheatley
	["West through the keep: {npc:263089} by the orchard, then the cathedral and {npc:259859} south of the inn if you have their errands."] = "На запад через крепость: {npc:263089} у сада, затем собор и {npc:259859} к югу от таверны, если у вас есть их поручения.",

	-- Step 88: Sister Rowland
	-- {quest:96084} Something's in the Water
	["{quest:96084}: for later in this guide"] = "{quest:96084}: понадобится позже в этом гайде",

	-- Step 90: Something's in the Water
	-- {area:16729} Terral's Watch · {npc:262031} Sister Rowland
	["North past {area:16729}: fill {npc:262031}'s phial in the marsh water north-east of the tower."] = "На север мимо места {area:16729}: наполните фиал, который дала {npc:262031}, в болотной воде к северо-востоку от башни.",

	-- Step 91: Terral's Watch
	-- {npc:259352} Watcher Cornelius
	["{npc:259352}'s tower."] = "Башня: {npc:259352}.",

	-- Step 93: Turner's Logging Camp
	-- {area:16736} Turner's Logging Camp · {npc:263380} Ghostmaw
	-- plural, as words: Peasant Woodpiles = {object:645516} Peasant Woodpile
	["West across the river to {area:16736}: the Peasant Woodpiles around the camp give the wood bundles.\nCareful: {npc:263380}, an elite (level 42), prowls the river by the camp: if he comes your way, back off and let him pass."] = "На запад через реку к месту {area:16736}: крестьянские поленницы вокруг лагеря дают вязанки дров.\nОсторожно: {npc:263380}, элита (уровень 42), рыщет у реки возле лагеря: если он идет к вам, отойдите и пропустите его.",

	-- Step 94: Sergeant Riftan
	-- {area:16685} Twilight's Shroud · {npc:258023} Sergeant Riftan
	["North up the long valley towards {area:16685}: {npc:258023} holds a small camp below the Twilight cult's fortress."] = "На север по длинной долине к месту {area:16685}: {npc:258023} держит небольшой лагерь под крепостью культа Сумеречного Молота.",

	-- Step 95: The Twilight camps
	["The Twilight camps"] = "Лагеря Сумеречного Молота",
	-- {npc:258652} Twilight Thrall · {npc:257591} Ashe Amberhall · {npc:256881} Overlord Kilgar · {npc:256891} Executioner Morg
	-- plural, as words: Farholde Scouts = {npc:256904} Farholde Scout · Twilight Enforcers = {npc:256800} Twilight Enforcer
	["The cult's camps fill the valley north and west of Riftan. Free the captive Farholde Scouts as you find them, and kill a {npc:258652} for {npc:257591}: her soulstone takes it. Twilight Enforcers (elites, level 45) patrol through the camps: watch where they walk before each pull. {npc:256881} and {npc:256891} (elites, 46) hold the fortress at the valley's head: pull the cultists away from them."] = "Лагеря культа занимают долину к северу и западу от Рифтана. Освобождайте пленных разведчиков Фархольда по пути и убейте NPC {npc:258652} для NPC {npc:257591}: ее камень души заберет его. Сумеречные каратели (элита, уровень 45) патрулируют лагеря: перед каждым пуллом следите за их маршрутом. {npc:256881} и {npc:256891} (элита, 46) держат крепость в верховье долины: выманивайте культистов подальше от них.",
	-- plural, as words: Farholde Scouts = {npc:256904} Farholde Scout
	["free five captive Farholde Scouts"] = "освободите пятерых пленных разведчиков Фархольда",
	-- {npc:258652} Twilight Thrall
	["kill a {npc:258652}"] = "убейте: {npc:258652}",

	-- Step 96: Marshal Ryan
	-- {npc:257250} Marshal Ryan · {npc:256881} Overlord Kilgar · {npc:256891} Executioner Morg
	["{npc:257250} lies wounded among the camps at the valley's western edge.\nCareful: {npc:256881} and {npc:256891} (elites, 46) hold the fortress north of him: come at Ryan from the south."] = "{npc:257250} лежит раненый среди лагерей у западного края долины.\nОсторожно: {npc:256881} и {npc:256891} (элита, 46) держат крепость к северу от него: подходите к Райану с юга.",
	-- {npc:257250} Marshal Ryan
	["find {npc:257250} and talk to him"] = "найдите NPC {npc:257250} и поговорите с ним",
	-- {quest:94892} Dying Wish · {npc:257558} Demar Brant · {area:16724} Farholde Keep
	["{quest:94892}: for {npc:257558} in {area:16724}"] = "{quest:94892}: для NPC {npc:257558} ({area:16724})",

	-- Step 97: The ogre mine
	["The ogre mine"] = "Огрская шахта",
	-- plural, as words: Twilight Subjugators = {npc:260996} Twilight Subjugator · Twilight Enforcers = {npc:256800} Twilight Enforcer
	["North of the camps the cult works ogre miners in a mine, driven by the Twilight Subjugators.\nCareful: Twilight Enforcers (elites, level 45) walk past the mine's mouth on their way through the camps. Wait for one to pass before you go in, and pull the miners and Subjugators back out to you."] = "К северу от лагерей культ заставляет огров-шахтеров работать в шахте под надзором сумеречных поработителей.\nОсторожно: сумеречные каратели (элита, уровень 45) проходят мимо входа в шахту, патрулируя лагеря. Дождитесь, пока один пройдет, прежде чем входить, и выманивайте шахтеров и поработителей наружу к себе.",

	-- Step 99: Bring Me His Head
	-- {npc:256881} Overlord Kilgar
	["{npc:256881} is an elite (level 46) in the fortress at the head of the valley, with the Enforcers around him: grouping up is advised."] = "{npc:256881} – элита (уровень 46) в крепости в верховье долины, вокруг него каратели: рекомендуется собрать группу.",
	-- {quest:94891} News to Farholde · {npc:257591} Ashe Amberhall
	["{quest:94891}: for {npc:257591}"] = "{quest:94891}: для NPC {npc:257591}",

	-- Step 100: Back to Farholde Keep
	-- {area:16724} Farholde Keep
	["Back to {area:16724}"] = "Обратно: {area:16724}",
	-- {area:16724} Farholde Keep
	["Your hearthstone is bound at {area:16724}'s inn: use it, or ride back south to the keep."] = "Ваш камень возвращения привязан к таверне ({area:16724}): используйте его или езжайте обратно на юг к крепости.",

	-- Step 101: Farholde Keep
	-- {npc:260070} Bertrand Ironbrow · {npc:257558} Demar Brant · {npc:257591} Ashe Amberhall
	["From the inn: {npc:260070} on the way in, then {npc:257558} and {npc:257591} in the keep."] = "От таверны: {npc:260070} по пути, затем {npc:257558} и {npc:257591} в крепости.",

	-- Step 103: Demar Brant
	-- {quest:94893} Delivering Closure · {npc:278088} Abigail Lawson · {zone:1453} Stormwind
	["{quest:94893}: for {npc:278088} in {zone:1453}"] = "{quest:94893}: для NPC {npc:278088} ({zone:1453})",

	-- Step 104: The Twilight Threat
	-- {npc:257558} Demar Brant · {npc:1748} Highlord Bolvar Fordragon · {object:2117} Stormwind Keep
	["{npc:257558}: Kilgar's head for {npc:1748} in {object:2117}"] = "{npc:257558}: голова Килгара для NPC {npc:1748} ({object:2117})",

	-- Step 105: Sister Rowland
	-- {npc:262031} Sister Rowland
	["{npc:262031}, in the cathedral at the keep's south-west corner."] = "{npc:262031} – в соборе в юго-западном углу крепости.",

	-- Step 106: Stormwind
	-- {npc:257087} Gretchen Mayberry · {zone:1453} Stormwind · {npc:278088} Abigail Lawson · {object:2098} Cathedral Square
	["{npc:257087} flies to {zone:1453}. {npc:278088} waits in the {object:2098}."] = "{npc:257087} отправит вас в {zone:1453}. {npc:278088} ждет вас на площади ({object:2098}).",

	-- Step 108: Train before the Badlands
	-- {zone:1418} Badlands
	["Train before the {zone:1418}"] = "Обучитесь перед зоной {zone:1418}",
	-- {zone:2548} Riverglades · {zone:1418} Badlands · {zone:1425} Hinterlands · {npc:257087} Gretchen Mayberry · {zone:1453} Stormwind
	["No class trainer stands in the {zone:2548}, and the {zone:1418} & {zone:1425} guide passes none: {npc:257087} flies to {zone:1453}, where you train before you go on."] = "В зоне {zone:2548} нет учителя классовых навыков, и в гайде по зонам {zone:1418} и {zone:1425} их тоже нет: {npc:257087} отправит вас в {zone:1453}, где вы обучитесь перед дорогой.",

	-- Step 109: Your class trainer
	["Your class trainer"] = "Ваш учитель классовых навыков",
	-- {zone:2548} Riverglades · {zone:1453} Stormwind
	["No class trainer stands in the {zone:2548}: train here in {zone:1453} before you fly on."] = "В зоне {zone:2548} нет учителя классовых навыков: обучитесь здесь, в городе {zone:1453}, прежде чем лететь дальше.",

	-- Step 110: Stormwind flight master
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Распорядитель полетов: {zone:1453}",

	-- Step 111: Shaman trainer
	["Shaman trainer"] = "Учитель шаманов",
	-- {zone:2548} Riverglades · {zone:1453} Stormwind · {zone:1418} Badlands · {zone:1425} Hinterlands · {area:1537} Ironforge · {area:144} Thelsamar
	["No shaman trainer stands in the {zone:2548} or in {zone:1453}, and the {zone:1418} & {zone:1425} guide passes none: fly to {area:1537} and train there; {area:144} is a short flight on."] = "Ни в зоне {zone:2548}, ни в городе {zone:1453} нет учителя шаманов, и в гайде по зонам {zone:1418} и {zone:1425} их тоже нет: летите в {area:1537} и обучитесь там; оттуда до места {area:144} недолго лететь.",

	-- Step 112: Leave Stormwind
	-- {zone:1453} Stormwind
	["Leave {zone:1453}"] = "Покиньте {zone:1453}",
	-- {zone:1418} Badlands · {zone:1432} Loch Modan · {area:144} Thelsamar · {zone:1453} Stormwind · {object:2096} Trade District
	["The next guide starts in the {zone:1418}, south of {zone:1432}: fly to {area:144}. {zone:1453}'s gryphon master stands in the {object:2096}."] = "Следующий гайд начинается в зоне {zone:1418}, к югу от зоны {zone:1432}: летите в {area:144}. Распорядитель полетов города {zone:1453} стоит в квартале ({object:2096}).",

	-- Step 113: Loch Modan
	-- {area:144} Thelsamar · {zone:1455} Ironforge · {area:2257} Deeprun Tram · {zone:1453} Stormwind · {zone:1426} Dun Morogh · {zone:1432} Loch Modan
	["No flight path to {area:144} yet: go to {zone:1455} (by the {area:2257} from {zone:1453}), ride out of its gates east through {zone:1426} and the tunnel into {zone:1432}, and on along the road to {area:144}."] = "Маршрута полета до места {area:144} пока нет: отправляйтесь в {zone:1455} (на поезде {area:2257} из города {zone:1453}), выезжайте из ворот на восток через зону {zone:1426} и туннель в зону {zone:1432}, а затем по дороге до места {area:144}.",

	-- Step 114: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "Летите сюда: {area:144}",
	-- {zone:1418} Badlands · {zone:1432} Loch Modan · {area:144} Thelsamar
	["The next guide starts in the {zone:1418}, south of {zone:1432}: fly to {area:144}."] = "Следующий гайд начинается в зоне {zone:1418}, к югу от зоны {zone:1432}: летите в {area:144}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{item:17028}, from {npc:272437}"] = "{item:17028} – у NPC {npc:272437}",
	-- ["{npc:262031} keeps the old cathedral at the south-west corner of {area:16724}. The bats roost in its upper floor; {npc:272437} hands out the holy candles beside it; the graves are in the chapel graveyard.\n{npc:271742}, an elite of level 53, stands in the cathedral: he leaves you be, so never attack him, and pull the bats away from him."] = "{npc:262031} присматривает за старым собором в юго-западном углу локации {area:16724}. Летучие мыши гнездятся на его верхнем этаже; {npc:272437} раздает святые свечи рядом с ним; могилы – на кладбище у часовни.\n{npc:271742}, элита 53-го уровня, стоит в соборе: он вас не тронет, поэтому никогда не атакуйте его и уводите летучих мышей подальше от него.",
}
