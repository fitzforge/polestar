-- Russian (ruRU): the guide forever/horde/40-50/01b-riverglades (forever/horde/40-50/01b-riverglades.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:16743} Rog'mar
	["About 70 quests in Forever's new zone, from the fort of {area:16743}."] = "Около 70 заданий в новой зоне Forever, из крепости {area:16743}.",

	-- Step 1: Fly to Kargath
	-- {area:340} Kargath
	["Fly to {area:340}"] = "Летите сюда: {area:340}",
	-- {zone:2548} Riverglades · {area:3} Badlands · {area:657} Harborage · {area:75} Stonard · {area:340} Kargath
	["The {zone:2548} lie south of the {area:3}. Ride east from the {area:657} to {area:75} and fly to {area:340}: the way down into the zone starts there."] = "{zone:2548} лежат к югу от зоны {area:3}. Езжайте на восток от места {area:657} к месту {area:75} и летите сюда: {area:340}. Оттуда начинается спуск в зону.",
	-- {area:75} Stonard
	["{area:75} flight master"] = "Распорядитель полетов: {area:75}",

	-- Step 2: Into the Riverglades
	-- {area:16591} Riverglades
	["Into the {area:16591}"] = "Сюда: {area:16591}",
	-- {area:16591} Riverglades · {area:340} Kargath · {area:3} Badlands · {area:16685} Twilight's Shroud · {area:16743} Rog'mar · {npc:258570} Da'grosh
	-- plural, as words: Twilight Enforcers = {npc:256800} Twilight Enforcer
	["New in Forever: this guide follows what players did in the {area:16591}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\nFrom {area:340}, ride south-east across the {area:3} to the zone's southern edge: the pass of {area:16685} leads down into the {area:16591}. {area:16743}, the Horde's fort, stands in the middle of the zone, east along the valley.\nCareful: this route starts at about 41, after Stranglethorn and the Swamp. Keep east to {area:16743}. {npc:258570}'s Twilight camps south-west of the pass are 43-46; Twilight Enforcers (45), Kilgar and Morg (46) are elite. Leave the valley for about 44."] = "",

	-- Step 3: Fly to Freewind Post
	-- {area:484} Freewind Post
	["Fly to {area:484}"] = "Летите сюда: {area:484}",
	-- {zone:2548} Riverglades · {zone:1446} Tanaris · {area:977} Steamwheedle Port · {area:976} Gadgetzan · {area:16727} Powderfuse Port · {area:484} Freewind Post · {zone:1441} Thousand Needles · {area:439} Shimmering Flats · {area:340} Kargath · {area:3} Badlands · {area:16685} Twilight's Shroud
	["New in Forever: this guide follows what players did in the {zone:2548}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\nThe {zone:2548} lie across the sea from {zone:1446}: a goblin boat sails from {area:977}, north-east of {area:976}, to {area:16727}. Fly to {area:484} in {zone:1441} and head south-east through the {area:439} to {area:976}. (If you already know {area:340} in the {area:3}, the way in through {area:16685} works too.)"] = "Новое в Forever: этот гайд повторяет то, что делали игроки в зоне {zone:2548}. Если шаг неверен, сообщите нам в Discord или на GitHub Polestar и назовите шаг.\n{zone:2548} лежат за морем от края {zone:1446}: гоблинский корабль ходит из места {area:977}, к северо-востоку от места {area:976}, до места {area:16727}. Летите сюда: {area:484} ({zone:1441}), и идите на юго-восток через {area:439} к месту {area:976}. (Если у вас уже открыт {area:340} ({area:3}), можно пройти и через {area:16685}.)",

	-- Step 4: Gadgetzan
	-- {area:976} Gadgetzan
	["Learn {area:976}'s flight path: it saves the ride next time."] = "Откройте маршрут полета ({area:976}): в следующий раз не придется ехать.",

	-- Step 5: Boat to Powderfuse Port
	-- {area:16727} Powderfuse Port
	["Boat to {area:16727}"] = "Корабль: {area:16727}",
	-- {area:977} Steamwheedle Port · {area:976} Gadgetzan · {area:16727} Powderfuse Port
	["{area:977} is on the coast north-east of {area:976}: wait on the pier for the goblin boat to {area:16727}."] = "{area:977} – на побережье к северо-востоку от места {area:976}: ждите на пристани гоблинский корабль до места {area:16727}.",

	-- Step 6: Land at Powderfuse Port
	-- {area:16727} Powderfuse Port
	["Land at {area:16727}"] = "",
	-- {area:16727} Powderfuse Port · {npc:255897} Friz Frazzlespark · {zone:1446} Tanaris
	["Board at Steamwheedle and ride to {area:16727}. Leave the boat and walk west along the docks to {npc:255897}'s stall. Reaching the {zone:1446} pier is not the crossing."] = "",
	-- {npc:255897} Friz Frazzlespark
	["{npc:255897}, at the west end of the docks"] = "",

	-- Step 7: Powderfuse Port
	-- {npc:255897} Friz Frazzlespark
	["New in Forever: if a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\n{npc:255897} keeps a stall at the west end of the docks. The port's other jobs are for later in this guide: this crate goes to the Horde's fort."] = "Новое в Forever: если шаг неверен, сообщите нам в Discord или на GitHub Polestar и назовите шаг.\n{npc:255897} держит лавку в западном конце доков. Остальные поручения порта – позже в этом гайде: этот ящик отправляется в крепость Орды.",
	-- {quest:95062} Frazzlespark's Crate · {npc:256418} Krom'rosh · {area:16743} Rog'mar
	["{quest:95062}: for {npc:256418} in {area:16743}"] = "{quest:95062}: для NPC {npc:256418} ({area:16743})",

	-- Step 8: Sleebo Fizzlespout's workshop
	-- {npc:263367} Sleebo Fizzlespout
	["{npc:263367}'s workshop"] = "Мастерская: {npc:263367}",
	-- {npc:263367} Sleebo Fizzlespout · {npc:258031} Neza Bloodsnout
	["West up the road from the port: {npc:263367} has his workshop on the hill. The gas vents are in the marsh south-west of it, on your first hunt for {npc:258031}."] = "На запад по дороге от порта: мастерская NPC {npc:263367} на холме. Газовые выходы – на болоте к юго-западу от нее, во время первой охоты для NPC {npc:258031}.",

	-- Step 9: Rog'mar
	-- {area:16743} Rog'mar · {npc:258031} Neza Bloodsnout · {npc:256657} Kreza Darkthorn · {npc:256418} Krom'rosh · {npc:255993} Grakna · {npc:256675} Innkeeper Toka · {npc:263190} Tan'jani
	["West to {area:16743}, the Horde's fort in the middle of the zone. {npc:258031} stands on its east side, {npc:256657} and {npc:256418} in the middle with {npc:255993}, the wind rider master; {npc:256675} and {npc:263190} on the west side."] = "На запад: {area:16743}, крепость Орды в центре зоны. {npc:258031} стоит на ее восточной стороне, {npc:256657} и {npc:256418} – в центре рядом с NPC {npc:255993}, распорядителем полетов; {npc:256675} и {npc:263190} – на западной стороне.",
	-- {npc:256418} Krom'rosh · {object:3202} Grom'gol
	["{npc:256418}: Aggro'gosh's report from {object:3202}, if you carry it"] = "{npc:256418}: донесение Аггро'гоша из {object:3202}, если оно у вас есть",
	-- {npc:255993} Grakna
	["{npc:255993}, in the middle of the fort"] = "{npc:255993}, в центре крепости",
	-- {npc:263190} Tan'jani · {quest:95033} On the Other Side · {npc:8115} Witch Doctor Uzer'i · {area:1099} Camp Mojache · {zone:1444} Feralas
	["{npc:263190}: {quest:95033}, for {npc:8115} at {area:1099} in the {zone:1444} guide"] = "{npc:263190}: {quest:95033}, для NPC {npc:8115} ({area:1099}) в гайде по зоне {zone:1444}",

	-- Step 10: Krom'rosh
	-- {npc:256418} Krom'rosh
	["Frazzlespark's crate from the port goes to {npc:256418}, in the middle of the fort."] = "Ящик Фраззлспарка из порта – для NPC {npc:256418}, в центре крепости.",

	-- Step 11: Sleebo Fizzlespout's workshop
	-- {area:16727} Powderfuse Port · {npc:263367} Sleebo Fizzlespout · {npc:258031} Neza Bloodsnout
	["East of Rog'mar, on the hill above the road to {area:16727}: {npc:263367} has his workshop there. The gas vents are in the marsh south-west of it, on your first hunt for {npc:258031}."] = "К востоку от Рог'мара, на холме над дорогой к месту {area:16727}: там мастерская NPC {npc:263367}. Газовые выходы – на болоте к юго-западу от нее, во время первой охоты для NPC {npc:258031}.",

	-- Step 12: The plains and the marsh
	["The plains and the marsh"] = "Равнины и болото",
	-- {area:16729} Terral's Watch · {quest:96103} A Feast for Buzzards
	-- plural, as words: Low Plains Buzzards = {npc:263343} Low Plains Buzzard
	["South-east of Rog'mar the plains run down to {area:16729}. The Low Plains Buzzards circle everywhere; a picked carcass lies in the grass (its skull starts {quest:96103}), and the marsh vents are just past it."] = "К юго-востоку от Рог'мара равнины спускаются к месту {area:16729}. Низинные канюки кружат повсюду; в траве лежит обглоданная туша (ее череп начинает задание «{quest:96103}»), а болотные выходы газа – сразу за ней.",

	-- Step 13: Sleebo Fizzlespout
	-- {npc:263367} Sleebo Fizzlespout
	["North-east to the workshop. {npc:263367}'s stress test is a fight with his G45-B4G beside the workshop: hand the quest in once it's beaten."] = "На северо-восток к мастерской. Нагрузочное испытание NPC {npc:263367} – бой с его G45-B4G рядом с мастерской: сдайте задание после победы.",
	["the stress test: beat G45-B4G beside the workshop"] = "испытание под нагрузкой: победите G45-B4G у мастерской",

	-- Step 14: Neza Bloodsnout
	-- {area:16743} Rog'mar
	["West back to {area:16743}'s east side."] = "Возвращайтесь на запад, к восточной части места {area:16743}.",

	-- Step 15: The vipers and the tallstriders
	["The vipers and the tallstriders"] = "Гадюки и долгоноги",
	-- {npc:257079} Cavalry Scout Alturin · {area:16729} Terral's Watch · {area:16725} Wheeler's Grange
	-- plural, as words: Glade Vipers = {npc:263307} Glade Viper · Roving Tallstriders = {npc:263348} Roving Tallstrider
	["The Glade Vipers hide in the long grass south-east of town; the Roving Tallstriders graze beside them. {npc:257079}, an Alliance elite (level 45), rides the road from {area:16729} to {area:16725} along the grass's south-west edge: keep clear of him."] = "Прогалинные гадюки прячутся в высокой траве к юго-востоку от городка; рядом пасутся бродячие долгоноги. {npc:257079}, элитный враг Альянса (45-й уровень), ездит по дороге от места {area:16729} до места {area:16725} вдоль юго-западного края травы: держитесь от него подальше.",

	-- Step 17: King of the Wild Plains
	-- {npc:263315} Ombassa · {area:16743} Rog'mar
	["{npc:263315}, an elite lion (level 41), prowls the plains south of {area:16743}, where the lions are: grouping up is advised."] = "{npc:263315}, элитный лев (41-й уровень), бродит по равнинам к югу от места {area:16743}, где водятся львы: рекомендуется собрать группу.",

	-- Step 18: The lions
	["The lions"] = "Львы",
	-- {area:16743} Rog'mar · {npc:263315} Ombassa
	["The Wildplains lions roam the plains just south of {area:16743}.\nCareful: {npc:263315}, an elite lion (level 41), prowls the same plains around 59.6,53.2: keep an eye out for him and pull the lions away from where he walks."] = "Львы диких равнин бродят по равнинам чуть к югу от места {area:16743}.\nОсторожно: {npc:263315}, элитный лев (41-й уровень), бродит по тем же равнинам около 59.6,53.2: следите за ним и уводите львов подальше от его пути.",

	-- Step 21: Neza Bloodsnout's elites
	-- {npc:258031} Neza Bloodsnout
	["{npc:258031}'s elites"] = "Элита: {npc:258031}",

	-- Step 22: Snargl's Snout
	-- {npc:255906} Snargl · {area:16737} Bristle Hills
	["{npc:255906} is an elite gnoll (level 40) who roams the south-western camps of the {area:16737}: grouping up is advised."] = "{npc:255906} – элитный гнолл (40 уровня), бродящий по юго-западным лагерям (местность {area:16737}): рекомендуется собрать группу.",

	-- Step 24: Turner's Logging Camp
	-- {npc:263380} Ghostmaw
	-- plural, as words: Wood Bundles = {item:271629} Wood Bundle · Peasant Woodpiles = {object:645516} Peasant Woodpile · Makeshift Stickin' Spears = {item:271630} Makeshift Stickin' Spear
	["South-west across the river to the Alliance lumber camp. The lumberjacks carry the axes. Loot Wood Bundles from the Peasant Woodpiles around the camp and use them to fletch Makeshift Stickin' Spears. {npc:263380}, an elite (level 42), prowls the river by the camp: if he comes your way, back off and let him pass."] = "На юго-запад через реку, к лесозаготовкам Альянса. Топоры – у лесорубов. Собирайте вязанки дров из крестьянских поленниц вокруг лагеря и делайте из них самодельные копья. {npc:263380}, элита (42-й уровень), бродит у реки возле лагеря: если он пойдет к вам, отступите и пропустите его.",
	-- {item:271629} Wood Bundle
	-- plural, as words: Peasant Woodpiles = {object:645516} Peasant Woodpile
	["{item:271629}, from the Peasant Woodpiles"] = "{item:271629}: из крестьянских поленниц",
	-- {item:271629} Wood Bundle
	-- plural, as words: Makeshift Stickin' Spears = {item:271630} Makeshift Stickin' Spear
	["{item:271629}: fletch it into Makeshift Stickin' Spears"] = "{item:271629}: сделайте из нее самодельные копья",

	-- Step 25: The Bristle Hills
	-- {area:16737} Bristle Hills
	["The {area:16737}"] = "{area:16737}",
	-- {area:16737} Bristle Hills · {npc:255906} Snargl
	["West into the {area:16737}: the Redridge gnolls camp along the slopes and carry the stolen ore. Work south-west through their camps.\nCareful: {npc:255906}, an elite gnoll (level 40), roams the south-western camps: pull the gnolls away from him."] = "На запад, в место {area:16737}: гноллы Красногорья стоят лагерями по склонам, у них – украденная руда. Продвигайтесь через их лагеря на юго-запад.\nОсторожно: {npc:255906}, элитный гнолл (40-й уровень), бродит по юго-западным лагерям: уводите гноллов подальше от него.",

	-- Step 27: Gelinda Coppergleam
	-- {npc:262399} Gelinda Coppergleam
	["South-east out of the hills: {npc:262399}, a prospector who deals with both sides, has camped by the Cinderscale dragonkin's hollow."] = "На юго-восток из холмов: {npc:262399}, старательница, торгующая с обеими сторонами, разбила лагерь у лощины драконидов Пеплочешуйных.",

	-- Step 28: The Cinderscale hollow
	["The Cinderscale hollow"] = "Лощина Угольной Чешуи",
	-- {item:271611} Cubic Draconia
	["The whelps nest all over the hollow; the warriors guard its back, by the {item:271611}. The warriors are level 41-42: pull them one at a time. Scaldaron, a rare elite drake, can be up here too: leave him be unless you have a group."] = "Дракончики гнездятся по всей лощине; воины охраняют ее дальнюю часть, у предмета {item:271611}. Воины 41-42-го уровня: выманивайте их по одному. Здесь может быть и Скальдарон, редкий элитный дракон: не трогайте его без группы.",

	-- Step 30: Meadowsbrook
	-- {area:16735} Meadowsbrook · {area:16744} Southern Watch · {npc:263380} Ghostmaw
	["East to {area:16735}, the Alliance farm by the river: the farmhands work the fields and the feed satchels lie by the barns. {area:16744}, the Alliance outpost on the road, has guards: pass south of it.\nCareful: {npc:263380}, an elite (level 42), hunts along the river by the farm: keep an eye on the riverbank."] = "На восток, в место {area:16735}, ферму Альянса у реки: батраки работают в полях, мешки с кормом лежат у амбаров. В месте {area:16744}, заставе Альянса на дороге, есть стража: обойдите ее с юга.\nОсторожно: {npc:263380}, элита (42-й уровень), охотится вдоль реки у фермы: следите за берегом.",

	-- Step 31: Rog'mar
	-- {area:16743} Rog'mar · {npc:263190} Tan'jani · {npc:256418} Krom'rosh · {npc:256655} Gorg · {npc:256657} Kreza Darkthorn · {npc:258031} Neza Bloodsnout
	["Back to {area:16743}, where your Hearthstone is set: {npc:263190} on the fort's west side first, then {npc:256418}, {npc:256655} by the cook fire, {npc:256657} and {npc:258031} on your way east through the fort."] = "Вернитесь в место {area:16743}, где привязан ваш Камень возвращения: сначала {npc:263190} в западной части форта, затем {npc:256418}, {npc:256655} у костра, {npc:256657} и {npc:258031} по пути на восток через форт.",
	-- {npc:256655} Gorg
	["{npc:256655}, by the cook fire"] = "{npc:256655}, у костра",
	-- {quest:93976} The Goblin Trader · {npc:255897} Friz Frazzlespark · {area:16727} Powderfuse Port
	["{quest:93976}: for {npc:255897} in {area:16727}, keep it"] = "{quest:93976}: для NPC {npc:255897} ({area:16727}), сохраните",

	-- Step 33: WANTED: Ghostmaw
	-- {npc:263380} Ghostmaw · {area:16743} Rog'mar
	["{npc:263380} is an elite (level 42) who hunts along the river south-west of {area:16743}, by the Farholde camp you go to next: grouping up is advised. The poster hangs in the middle of the fort."] = "{npc:263380} – элита (42-й уровень), охотится вдоль реки к юго-западу от места {area:16743}, у лагеря Фархольда, куда вы идете дальше: рекомендуется собрать группу. Плакат висит в центре форта.",
	-- {object:645164} WANTED! (no name in this language: may be words)
	["the {object:645164} poster"] = "плакат «{object:645164}»",

	-- Step 34: The training grounds
	["The training grounds"] = "Тренировочная площадка",
	-- {npc:256655} Gorg · {item:265066} Hearty Stew · {npc:263380} Ghostmaw
	-- plural, as words: Rog'mar Trainees = {npc:256749} Rog'mar Trainee
	["North of the fort the Rog'mar Trainees drill: use {npc:256655}'s {item:265066} on them.\nCareful: {npc:263380}, an elite (level 42), can come up from the river south of the fort: let him pass."] = "К северу от форта тренируются новобранцы Рог'мара: используйте на них {item:265066} ({npc:256655}).\nОсторожно: {npc:263380}, элита (42-й уровень), может выйти с реки к югу от форта: пропустите его.",

	-- Step 36: The river and the Farholde camp
	["The river and the Farholde camp"] = "Река и лагерь Фархольда",
	-- {npc:263190} Tan'jani · {npc:257079} Cavalry Scout Alturin · {npc:263380} Ghostmaw
	-- plural, as words: Freshwater Crocolisks = {npc:259046} Freshwater Crocolisk
	["South-west of Rog'mar the river runs between the farms: impale the Freshwater Crocolisks with {npc:263190}'s spears. The Alliance trains its scouts and priests at a camp on the far bank. {npc:257079}, the Alliance elite, rides the road just east of the camp: pull the scouts and priests away from it.\nCareful: {npc:263380}, an elite (level 42), hunts along this river: if he comes your way, back off and let him pass."] = "К юго-западу от Рог'мара река течет между фермами: пронзайте пресноводных кроколисков копьями ({npc:263190}). Альянс обучает разведчиков и жрецов в лагере на дальнем берегу. {npc:257079}, элита Альянса, разъезжает по дороге чуть восточнее лагеря: выманивайте разведчиков и жрецов подальше от него.\nОсторожно: {npc:263380}, элита (42-й уровень), охотится вдоль этой реки: если он идет к вам, отойдите и пропустите его.",
	-- {npc:263190} Tan'jani
	-- plural, as words: Freshwater Crocolisks = {npc:259046} Freshwater Crocolisk
	["{npc:263190}'s spears, on the Freshwater Crocolisks in the river"] = "",

	-- Step 40: Tran'gul
	-- {npc:256710} Tran'gul · {npc:256418} Krom'rosh · {area:16743} Rog'mar · {area:16723} Sunnyglade
	["{npc:256710} stands beside {npc:256418} in the middle of {area:16743}: now that the Farholde camp has had its lesson, he has work in {area:16723}."] = "{npc:256710} стоит рядом с NPC {npc:256418} в центре места {area:16743}: теперь, когда лагерь Фархольда проучен, у него есть работа здесь: {area:16723}.",

	-- Step 41: Fuzzle
	-- {area:16723} Sunnyglade · {npc:259158} Fuzzle
	["West of Rog'mar the Twilight cult holds the farm town of {area:16723}. {npc:259158} is in a cage on the south side of town."] = "",
	-- {npc:259158} Fuzzle
	["{npc:259158} in his cage, not the end of his escort"] = "",

	-- Step 42: Sunnyglade
	-- {npc:256899} Chogg'Zac · {area:16723} Sunnyglade
	["The cultists fill the streets and fields; the Shadowmancers on the town's northern side carry the missives. The finger bones drop from all of them.\nCareful: {npc:256899}, an elite ogre (level 41), walks the western streets of {area:16723}, around 44-47,47-52. Pull the cultists out towards you and let him pass."] = "Культисты заполонили улицы и поля; послания несут темные заклинатели в северной части городка. Кости пальцев падают со всех.\nОсторожно: {npc:256899}, элитный огр (41-й уровень), бродит по западным улицам места {area:16723}, около 44-47,47-52. Выманивайте культистов к себе и пропускайте его.",

	-- Step 43: Fuzzle
	-- {npc:259158} Fuzzle · {area:16723} Sunnyglade
	["{npc:259158} wants out of {area:16723}: lead him west to his treasure at the edge of town and keep the cultists off him."] = "{npc:259158} хочет выбраться из города {area:16723}: отведите его на запад к его сокровищу на окраине и не подпускайте к нему культистов.",
	-- {npc:259158} Fuzzle · {area:16723} Sunnyglade
	["lead {npc:259158} out of {area:16723} to his treasure, west of the town"] = "выведите {npc:259158} из города {area:16723} к его сокровищу к западу от города",

	-- Step 44: Tran'gul
	-- {area:16743} Rog'mar
	["East back to {area:16743}."] = "Возвращайтесь на восток: {area:16743}.",
	-- {quest:94727} Digging for Answers · {npc:260931} Clubtoe · {area:16723} Sunnyglade
	["{quest:94727}: for {npc:260931} in {area:16723}"] = "{quest:94727}: для NPC {npc:260931} ({area:16723})",

	-- Step 45: Clubtoe
	-- {area:16723} Sunnyglade · {npc:260931} Clubtoe · {npc:256710} Tran'gul
	["West to {area:16723} again: {npc:260931}, a Twilight miner who wants out, waits at the town's eastern edge. Talk him round, then hand {npc:256710}'s quest in; one of the missing ogres stands a few steps west."] = "Снова на запад: {area:16723}. {npc:260931}, сумеречный рудокоп, который хочет уйти, ждет на восточной окраине городка. Переубедите его, затем сдайте задание ({npc:256710}); один из пропавших огров стоит в нескольких шагах к западу.",
	-- {npc:260931} Clubtoe
	["talk {npc:260931} round"] = "переубедить: {npc:260931}",
	-- {npc:261208} Twilight Brute
	["{npc:261208}, a few steps west"] = "{npc:261208}, в нескольких шагах к западу",

	-- Step 46: The ritual grounds
	["The ritual grounds"] = "Ритуальная площадка",
	-- {area:16723} Sunnyglade · {npc:256899} Chogg'Zac
	["The ritualists and their empowered brutes gather at the ritual circles in the middle of {area:16723}: wreck five of the circles.\nCareful: {npc:256899}, the elite ogre (level 41), walks through here from the western streets: watch for him before each pull."] = "Ритуалисты и их усиленные громилы собираются у ритуальных кругов в центре места {area:16723}: разрушьте пять кругов.\nОсторожно: {npc:256899}, элитный огр (41-й уровень), заходит сюда с западных улиц: высматривайте его перед каждым пуллом.",
	-- plural, as words: Twilight Ritual Circles = {npc:262006} Twilight Ritual Circle
	["destroy 5 Twilight Ritual Circles"] = "разрушить 5 ритуальных кругов Сумеречного Молота",

	-- Step 48: Twilight No More!
	-- {npc:256899} Chogg'Zac · {area:16723} Sunnyglade · {npc:260931} Clubtoe · {quest:95420} Land of Giants · {npc:255829} Clugfist · {quest:94668} Bloodmaster's Ring · {area:16726} Bolder'ok · {npc:258570} Da'grosh
	["{npc:256899}, the two-headed ogre at the western edge of {area:16723}, is an elite (level 41): grouping up is advised. {npc:260931} wants both his heads, and the rest of the zone's ogre story waits on them: {quest:95420}, {npc:255829}'s quests and the {quest:94668} in {area:16726}, then {npc:258570}'s camp in the west (about 21,000 XP in all). Skip him and the guide leaves those out."] = "",

	-- Step 49: Chogg'Zac
	["Clear the cultists around him first and come in with full health and mana."] = "",

	-- Step 50: Clubtoe
	-- {quest:95418} Spread the Word · {npc:256710} Tran'gul · {area:16743} Rog'mar
	["{quest:95418}: for {npc:256710} in {area:16743}"] = "{quest:95418}: для NPC {npc:256710} ({area:16743})",

	-- Step 51: Tran'gul
	-- {area:16743} Rog'mar · {npc:260931} Clubtoe · {npc:256710} Tran'gul · {npc:255829} Clugfist
	["East back to {area:16743}: {npc:260931}'s word goes to {npc:256710}, and {npc:256710}'s to {npc:255829}, the ogres' chieftain."] = "На восток обратно в {area:16743}: весть от NPC {npc:260931} передайте NPC {npc:256710}, а весть от NPC {npc:256710} – вождю огров ({npc:255829}).",
	-- {quest:95420} Land of Giants · {npc:255829} Clugfist · {area:16726} Bolder'ok
	["{quest:95420}: for {npc:255829} in {area:16726}"] = "{quest:95420}: для NPC {npc:255829} ({area:16726})",

	-- Step 52: WANTED: Scoutmaster Vargas
	-- {npc:260211} Scoutmaster Vargas · {npc:256728} Na'zok · {npc:258031} Neza Bloodsnout
	["{npc:260211} is an elite (level 42) at the Alliance scouts' camp in the hills south-east of {npc:256728}, where you go next: grouping up is advised. The poster hangs in the middle of the fort; {npc:258031} takes the eye, later in this guide."] = "{npc:260211} – элита (42-й уровень) в лагере разведчиков Альянса на холмах к юго-востоку от NPC {npc:256728}, куда вы идете дальше: советуем собрать группу. Объявление висит в центре форта; глаз примет {npc:258031} – позже в этом гайде.",
	-- {object:707249} Wanted (no name in this language: may be words)
	["the {object:707249} poster"] = "Плакат: {object:707249}",

	-- Step 53: Na'zok's camp
	-- {npc:256728} Na'zok
	["{npc:256728}'s camp"] = "Лагерь NPC {npc:256728}",
	-- {area:16743} Rog'mar · {npc:256728} Na'zok
	["North-east from {area:16743} up into the hills: {npc:256728} watches the Paletusk boars from his camp."] = "На северо-восток от места {area:16743}, вверх в холмы: {npc:256728} наблюдает из своего лагеря за кабанами-бледноклыками.",

	-- Step 54: Bolder'ok
	-- {area:16726} Bolder'ok · {npc:255829} Clugfist
	["North-west to {area:16726}, the ogres' town. {npc:255829}, its chieftain, sits on the hill. The ogres are friendly while you leave them alone."] = "На северо-запад, в {area:16726} – город огров. Их вождь, {npc:255829}, сидит на холме. Огры дружелюбны, пока вы их не трогаете.",

	-- Step 57: The Twilight ogres' camp
	["The Twilight ogres' camp"] = "Лагерь огров Сумеречного Молота",
	-- {npc:256728} Na'zok · {npc:260973} Klunk · {item:269257} Skullbasher · {npc:260211} Scoutmaster Vargas
	-- plural, as words: Twilight Maulers = {npc:260968} Twilight Mauler · Farholde Ambushers = {npc:260023} Farholde Ambusher
	["The Twilight Maulers and Firecallers camp on the ridge east of {npc:256728}. {npc:260973}, who carries the {item:269257}, stands among them. Just south of the ogres, {npc:260211} (an Alliance elite, level 42) and his Farholde Ambushers hold the scouts' camp: keep north of it unless you came with a group for him."] = "Громилы и призыватели огня из клана Сумеречного Молота стоят лагерем на гребне к востоку от NPC {npc:256728}. Среди них стоит {npc:260973} – у него {item:269257}. Чуть южнее огров лагерь разведчиков удерживают {npc:260211} (элита Альянса, 42-й уровень) и его засадники из Фархольда: держитесь севернее лагеря, если только не пришли за ним с группой.",
	-- {item:269257} Skullbasher · {npc:260973} Klunk
	["{item:269257}, from {npc:260973}"] = "{item:269257} – добыча: {npc:260973}",

	-- Step 59: The paletusks
	["The paletusks"] = "Бледноклыки",
	-- {npc:256728} Na'zok
	-- plural, as words: Young Paletusks = {npc:258331} Young Paletusk · Mature Paletusks = {npc:255851} Mature Paletusk
	["South down the hills, round the west side of the Alliance scouts' camp: tap the Young Paletusks with {npc:256728}'s staff to send them home; the Mature Paletusks around the hills drop the boar meat."] = "На юг вниз с холмов, в обход лагеря разведчиков Альянса с запада: коснитесь посохом ({npc:256728}) молодых бледноклыков, чтобы отправить их домой; взрослые бледноклыки на холмах дают кабанину.",
	-- {item:268521} Swineherd's Staff
	-- plural, as words: Young Paletusks = {npc:258331} Young Paletusk
	["{item:268521}, on the Young Paletusks"] = "{item:268521} – на молодых бледноклыках",
	-- {item:769} Chunk of Boar Meat
	-- plural, as words: Mature Paletusks = {npc:255851} Mature Paletusk
	["{item:769}, from the Mature Paletusks"] = "{item:769} – со взрослых бледноклыков",

	-- Step 61: Twilight camp before the escort
	["Twilight camp before the escort"] = "",
	-- {npc:258048} Jom-jom
	["Before taking {npc:258048} home, finish any Maulers and Firecallers you still need here. Stay on the ridge, north of Vargas and his ambushers."] = "",

	-- Step 62: Klunk before the escort
	-- {npc:260973} Klunk
	["{npc:260973} before the escort"] = "",
	-- {item:269257} Skullbasher · {npc:260973} Klunk · {npc:258048} Jom-jom
	["If you still need the {item:269257}, {npc:260973} is at the same camp as {npc:258048}. Take it back with the escort."] = "",

	-- Step 63: Jom-jom's Escape
	-- {npc:258048} Jom-jom · {npc:256728} Na'zok · {area:16726} Bolder'ok
	["{npc:258048} waits by the Twilight ogres' camp north-east of {npc:256728}: take him home to {area:16726} and keep the cultists off him. If he falls, take the quest from him again."] = "{npc:258048} ждет у лагеря огров Сумеречного Молота к северо-востоку от NPC {npc:256728}: отведите его домой ({area:16726}) и отгоняйте от него культистов. Если он погибнет, возьмите задание у него снова.",
	-- {npc:258048} Jom-jom
	["{npc:258048}, in the cave"] = "",
	-- {npc:258048} Jom-jom · {area:16726} Bolder'ok
	["help {npc:258048} reach {area:16726}"] = "Помогите NPC {npc:258048} добраться сюда: {area:16726}",

	-- Step 64: Bolder'ok
	-- {npc:255829} Clugfist · {npc:257062} Jezap Jinglesprocket · {quest:94668} Bloodmaster's Ring
	["Back to {npc:255829} on his hill. {npc:257062} runs the {quest:94668} just below it."] = "Назад к NPC {npc:255829} на холм. Чуть ниже {npc:257062} заправляет заданием {quest:94668}.",

	-- Step 67: Finish Might Makes Right
	-- {quest:95424} Might Makes Right
	["Finish {quest:95424}"] = "",
	-- {npc:255829} Clugfist · {npc:256728} Na'zok
	["If you joined the route with {npc:255829}'s hunt unfinished, the Maulers and Firecallers are at the Twilight camp on the ridge east of {npc:256728}. Stay north of Vargas and his ambushers."] = "",

	-- Step 68: Finish Unworthy Champion
	-- {quest:95425} Unworthy Champion
	["Finish {quest:95425}"] = "",
	-- {npc:260973} Klunk · {item:269257} Skullbasher · {npc:255829} Clugfist
	["{npc:260973} is in the same Twilight camp. Take his {item:269257} back to {npc:255829} with any finished hunt."] = "",

	-- Step 69: Clugfist: the finished hunt
	-- {npc:255829} Clugfist
	["{npc:255829}: the finished hunt"] = "",

	-- Step 70: Clugfist: the recovered Skullbasher
	-- {npc:255829} Clugfist · {item:269257} Skullbasher
	["{npc:255829}: the recovered {item:269257}"] = "",

	-- Step 71: Clugfist
	-- {quest:95428} Clugfist's Decree · {npc:256418} Krom'rosh · {area:16743} Rog'mar
	["{quest:95428}: for {npc:256418} in {area:16743}, later in this guide"] = "{quest:95428}: для NPC {npc:256418} ({area:16743}), далее в этом гайде",
	-- {quest:94669} Pay to Play
	["{quest:94669}: the Ring's bouts, one-on-one fights with elites (41-45); a deposit first"] = "{quest:94669}: бои Круга, поединки с элитой (41-45); сначала взнос",

	-- Step 72: The Bloodmaster's Ring: Buzzbeak
	-- {quest:94670} Bloodmaster's Ring
	["The {quest:94670}: Buzzbeak"] = "{quest:94670}: Жужжеклюв",
	-- {npc:255829} Clugfist · {npc:258626} Mog'thar · {npc:257059} Chub'chob · {npc:257062} Jezap Jinglesprocket
	["Each bout is a fight in the ring below {npc:255829}'s hill against an elite: Buzzbeak (41), Kronk and Bonegnaw (42), {npc:258626} (43), Snufflesnout (44) and {npc:257059} (45). Come in rested, with full health and mana; if a bout goes wrong, {npc:257062} offers it again."] = "Каждый бой – схватка с элитой на арене под холмом ({npc:255829}): Жужжеклюв (41), Кронк и Костеглод (42), {npc:258626} (43), Нюхорыл (44) и {npc:257059} (45). Приходите отдохнувшими, с полным здоровьем и маной; если бой не удался, {npc:257062} предложит его снова.",
	-- {quest:94670} Bloodmaster's Ring
	["{quest:94670}: Buzzbeak"] = "{quest:94670}: Жужжеклюв",
	["beat Buzzbeak"] = "Победите Жужжеклюва",

	-- Step 73: The Bloodmaster's Ring: Kronk and Bonegnaw
	-- {quest:94670} Bloodmaster's Ring
	["The {quest:94670}: Kronk and Bonegnaw"] = "{quest:94670}: Кронк и Костеглод",
	["Kronk"] = "Кронк",
	["Bonegnaw"] = "Костеглод",

	-- Step 74: The Bloodmaster's Ring: Mog'thar
	-- {quest:94962} Bloodmaster's Ring · {npc:258626} Mog'thar
	["The {quest:94962}: {npc:258626}"] = "{quest:94962}: {npc:258626}",

	-- Step 75: The Bloodmaster's Ring: Snufflesnout and Chub'chob
	-- {quest:94964} Bloodmaster's Ring · {npc:257059} Chub'chob
	["The {quest:94964}: Snufflesnout and {npc:257059}"] = "{quest:94964}: Нюхорыл и {npc:257059}",
	-- {npc:257062} Jezap Jinglesprocket · {npc:258626} Mog'thar
	["{npc:257062} offers the last two once Gobam's errands are done (players' recordings), which this guide leaves out. They are level 44 and 45: leave them for later if {npc:258626} was a close fight."] = "{npc:257062} дает последние два боя после поручений Гобама (по записям игроков), которые этот гайд пропускает. Они 44-го и 45-го уровней: отложите их на потом, если бой с {npc:258626} дался с трудом.",
	["Snufflesnout (44)"] = "Нюхорыл (44)",
	-- {npc:255829} Clugfist
	["{npc:255829}, on the hill"] = "{npc:255829}, на холме",

	-- Step 76: Powderfuse Port
	-- {area:16727} Powderfuse Port · {npc:255897} Friz Frazzlespark · {npc:259962} Fimbo Greasemitz · {npc:259961} Wharfmaster Whizzbuzz
	["South-east down out of the hills to {area:16727}, the goblins' harbour on the coast. {npc:255897} keeps a stall at the west end of the docks, {npc:259962} cooks by the inn, and {npc:259961} works the north pier."] = "На юго-восток, вниз с холмов, к {area:16727} — гоблинской гавани на побережье. {npc:255897} держит лавку в западном конце доков, {npc:259962} готовит у таверны, а {npc:259961} работает на северном причале.",
	-- {object:628948} WANTED! (no name in this language: may be words) · {npc:260235} Trapclaw
	["The {object:628948} poster by the inn: {npc:260235}"] = "Плакат «{object:628948}» у таверны: {npc:260235}",

	-- Step 77: Wharfmaster Whizzbuzz
	-- {npc:259961} Wharfmaster Whizzbuzz · {item:277974} Twice Reordered Package
	["{npc:259961} on the north pier takes Lozgil's {item:277974}."] = "{npc:259961} на северном причале примет посылку Лозгила: {item:277974}.",

	-- Step 78: WANTED: Old Rot-Chum
	-- {npc:257001} Old Rot-Chum
	["{npc:257001} is an elite (level 42) on the south shore: grouping up is advised."] = "{npc:257001} — элита (42-й уровень) на южном берегу: лучше собрать группу.",
	-- {object:628948} WANTED! (no name in this language: may be words)
	["The {object:628948} poster by the inn"] = "Плакат «{object:628948}» у таверны",

	-- Step 79: The murlocs, south-west
	["The murlocs, south-west"] = "Мурлоки на юго-западе",
	-- {quest:95260} Terrors From the Deep · {npc:260231} Argo Brinewhistle
	["South-west along the shore from the port: the saltwater murlocs camp on the beaches. On the way, a painted hide is stretched beside the path: it starts {quest:95260} for {npc:260231} at the docks."] = "На юго-запад вдоль берега от порта: морские мурлоки стоят лагерями на пляжах. По пути у тропы растянута раскрашенная шкура: она начинает задание «{quest:95260}» для NPC {npc:260231} на причалах.",

	-- Step 81: Back through the port
	["Back through the port"] = "Обратно через порт",
	["Back north along the shore: hand in the murlocs and the hide on the docks on your way to the crawlers."] = "Обратно на север вдоль берега: по пути к ползунам сдайте мурлоков и шкуру на причалах.",
	-- {quest:95261} It Takes Guts
	["{quest:95261}: the beasts' entrails come as you go; the mushrooms grow on the ridge west of the pirates"] = "{quest:95261}: внутренности зверей собираются по пути; грибы растут на гребне к западу от пиратов",

	-- Step 82: The crawlers and Trapclaw
	-- {npc:260235} Trapclaw
	["The crawlers and {npc:260235}"] = "Ползуны и {npc:260235}",
	-- {npc:259962} Fimbo Greasemitz · {npc:260231} Argo Brinewhistle · {npc:260235} Trapclaw · {npc:259758} Gul'gash
	["North along the beach from the docks: the crawlers drop the meat for {npc:259962}, and their entrails count for {npc:260231}. {npc:260235}, a big crab, scuttles along the rocks east of the docks. {npc:259758}, a rare elite of level 49, roams this coast from the docks up to the pirates' camp: if you see him, keep well away."] = "На север вдоль пляжа от доков: ползуны оставляют мясо для персонажа {npc:259962}, а их внутренности засчитываются для персонажа {npc:260231}. {npc:260235}, большой краб, снует по камням к востоку от доков. {npc:259758}, редкая элита 49-го уровня, бродит по побережью от доков до лагеря пиратов: увидев его, держитесь подальше.",
	["Keep entrails from these crawlers; the later ridge and beach finish any missing ones."] = "",

	-- Step 87: Before the Eastsea camp
	["Before the Eastsea camp"] = "",
	-- {area:16727} Powderfuse Port
	-- plural, as words: Eastsea Musketeers = {npc:257910} Eastsea Musketeer · Jungle Stalkers = {npc:687} Jungle Stalker
	["The Eastsea Musketeers reach 43. Leave the camp for now. At 40 or 41, if Raptor Mastery is still in your log, the Jungle Stalkers west of the Venture Co. mine in Stranglethorn are 40-41. At 42 resume on the beach north of {area:16727} for the buccaneers and musketeers."] = "",

	-- Step 88: The Eastsea pirates
	["The Eastsea pirates"] = "Пираты Восточного моря",
	-- {npc:259758} Gul'gash
	["North-east along the coast to the pirates' camp on the cliffs. The buccaneers and musketeers carry the smuggled goods. {npc:259758} walks the camp too: keep an eye out for him."] = "На северо-восток вдоль побережья к лагерю пиратов на утесах. Контрабандный товар носят флибустьеры и мушкетеры. По лагерю также бродит {npc:259758}: следите за ним.",

	-- Step 90: Wharfmaster Whizzbuzz
	["Take the raider and powder-keg jobs for the return to the cliffs at 44."] = "",

	-- Step 94: Friz Frazzlespark
	-- {npc:260390} Captain Bentcoin
	["Keep the delivery for {npc:260390} on the raider visit."] = "",

	-- Step 97: Back to Argo Brinewhistle
	-- {npc:260231} Argo Brinewhistle
	["Back to {npc:260231}"] = "",

	-- Step 98: Beast Entrails as you go
	-- {item:268632} Beast Entrails
	["{item:268632} as you go"] = "{item:268632} по пути",
	-- {zone:2548} Riverglades · {item:268632} Beast Entrails · {npc:260231} Argo Brinewhistle · {npc:257001} Old Rot-Chum · {npc:263380} Ghostmaw
	["Most beasts in the {zone:2548} drop {item:268632} for {npc:260231}: the shore crawlers on this coast and the boars on the ridge west of the pirates.\nCareful: {npc:257001} (elite, 42) wanders the shore and {npc:263380} (elite, 42) the river: take your beasts away from them."] = "Почти все звери в зоне {zone:2548} оставляют {item:268632} для персонажа {npc:260231}: береговые ползуны на этом побережье и кабаны на гребне к западу от пиратов.\nОсторожно: {npc:257001} (элита, 42) бродит по берегу, а {npc:263380} (элита, 42) — по реке: уводите зверей подальше от них.",

	-- Step 99: Wharfmaster Whizzbuzz: the raiders
	-- {npc:259961} Wharfmaster Whizzbuzz
	["{npc:259961}: the raiders"] = "",

	-- Step 100: Wharfmaster Whizzbuzz: the powder kegs
	-- {npc:259961} Wharfmaster Whizzbuzz
	["{npc:259961}: the powder kegs"] = "",

	-- Step 101: Friz Frazzlespark: the captain’s bargain
	-- {npc:255897} Friz Frazzlespark
	["{npc:255897}: the captain’s bargain"] = "",

	-- Step 102: Wharfmaster Whizzbuzz: the ships
	-- {npc:259961} Wharfmaster Whizzbuzz
	["{npc:259961}: the ships"] = "",

	-- Step 104: Before the raiders
	["Before the raiders"] = "",
	-- {quest:95124} Admiral Lamora · {npc:259961} Wharfmaster Whizzbuzz · {area:43} Wild Shore · {area:35} Booty Bay
	["The raiders and {quest:95124} reach 45. Pause here at {npc:259961} on the north pier. At 42-43, if you still have Keep An Eye Out or Up to Snuff, the pirates on the {area:43} south of {area:35} count; stay on the beach, not the ships. If those are already done, don't make that trip. At 44 resume here for the raiders on the cliffs. You don't need to farm the first camp."] = "",

	-- Step 105: The pirates' second wave
	["The pirates' second wave"] = "Вторая волна пиратов",
	-- {npc:259758} Gul'gash
	-- plural, as words: Eastsea Raiders = {npc:257915} Eastsea Raider
	-- was: ["North along the coast from the port: the Eastsea raiders and bombardiers have dug in on the slopes west of the buccaneers' camp, among their powder kegs. Watch for {npc:259758} on these cliffs.\nCareful: the Eastsea Raiders are level 44-45, a level or two over you here: pull them one at a time from the edge of the slopes and keep clear of the camp behind them."] = "На север вдоль побережья от порта: налетчики и бомбардиры Восточного моря окопались на склонах к западу от лагеря буканьеров, среди пороховых бочек. Остерегайтесь: {npc:259758} на этих утесах.\nОсторожно: налетчики Восточного моря 44–45-го уровня, на уровень-два выше вас: выманивайте их по одному с края склонов и держитесь подальше от лагеря за ними."
	["North along the coast from the port: the Eastsea raiders and bombardiers have dug in on the slopes west of the buccaneers' camp, among their powder kegs. Watch for {npc:259758} on these cliffs.\nCareful: the Eastsea Raiders are level 44-45, so pull them one at a time from the edge of the slopes and keep clear of the camp behind them."] = "",

	-- Step 106: Captain Bentcoin
	-- {npc:260390} Captain Bentcoin · {npc:260391} Captain Haynes
	["East along the cliffs to the far end of the pirates' camp: {npc:260390} waits by the water, {npc:260391} beside him."] = "На восток вдоль утесов к дальнему краю лагеря пиратов: {npc:260390} ждет у воды, рядом – {npc:260391}.",

	-- Step 109: Wharfmaster Whizzbuzz
	-- {quest:95124} Admiral Lamora
	["Whizzbuzz gives you the ship charges and the order for {quest:95124}."] = "",

	-- Step 111: Friz Frazzlespark
	-- {npc:260405} Wharfmaster Steamfizzle · {area:977} Steamwheedle Port · {zone:1446} Tanaris
	["Keep the shipping papers for {npc:260405} at {area:977} in {zone:1446}."] = "",

	-- Step 112: The pirates' ships
	["The pirates' ships"] = "Корабли пиратов",
	-- {quest:95124} Admiral Lamora · {npc:259758} Gul'gash
	["Out to the pirates' cliffs once more. Plant Whizzbuzz's charges on the three ships moored below the camp, south to north; {quest:95124} patrols the top deck of the middle ship. Once she's down, go below deck for the loot chest in the hold. Keep an eye out for {npc:259758} on the way.\nCareful: {quest:95124} is level 45, so clear the deck around her first and come in with full health."] = "",
	-- {item:268505} Remote Explosive Charge
	["{item:268505}, the southern ship"] = "{item:268505}, южный корабль",
	["Open Lamora's chest in the hold"] = "",
	["the middle ship"] = "средний корабль",
	["the northern ship"] = "северный корабль",

	-- Step 113: Rotflesh Mushrooms
	-- plural, as words: Rotflesh Mushrooms = {item:268664} Rotflesh Mushroom
	["Rotflesh Mushrooms"] = "Гнилогрибы",
	-- plural, as words: Rotflesh Mushrooms = {item:268664} Rotflesh Mushroom · Mature Paletusks = {npc:255851} Mature Paletusk
	["West from the northern ship, up the ridge: the Rotflesh Mushrooms grow among the rocks, close to the Twilight ogres' camp. The Mature Paletusks on the ridge give entrails too."] = "На запад от северного корабля, вверх по гребню: гнилогрибы растут среди камней, рядом с лагерем огров из Сумеречного Молота. Взрослые бледноклыки на гребне тоже дают внутренности.",

	-- Step 114: Finish the Beast Entrails
	-- {item:268632} Beast Entrails
	["Finish the {item:268632}"] = "Добудьте все {item:268632}",
	-- {npc:259758} Gul'gash
	["South-east back towards the port: the shore crawlers on the beach north of the docks are the quickest entrails. {npc:259758} wanders down to this beach too."] = "На юго-восток обратно к порту: береговые ползуны на пляже к северу от доков — самый быстрый источник внутренностей. {npc:259758} забредает и на этот пляж.",

	-- Step 118: Argo Brinewhistle
	-- {npc:260231} Argo Brinewhistle · {npc:257001} Old Rot-Chum
	["{npc:260231} can give you the bait for the shallows south-west of the port. {npc:257001}, the elite, walks the same shore."] = "",

	-- Step 119: The Monster Surfaces
	-- {npc:260231} Argo Brinewhistle · {item:268647} Big Ball o' Bait · {npc:257001} Old Rot-Chum
	["At the junk in the shallows south-west of the port, use {npc:260231}'s {item:268647}. Kill the threshadon that comes to the bait and take its head. Give {npc:257001}, the elite that walks this shore, plenty of room."] = "",
	-- {item:268647} Big Ball o' Bait
	["{item:268647} at the junk"] = "",
	["Loot the summoned threshadon's head"] = "",

	-- Step 121: Rog'mar
	-- {area:16743} Rog'mar · {npc:256418} Krom'rosh · {npc:255829} Clugfist · {npc:258570} Da'grosh
	["Back to {area:16743} from the port, where your Hearthstone is set. {npc:256418} in the middle of the fort: {npc:255829}'s word sends him looking for {npc:258570}, his warrior in the west."] = "Из порта обратно в {area:16743}, где привязан ваш Камень возвращения. {npc:256418} в центре форта: по слову персонажа {npc:255829} он отправит вас искать персонажа {npc:258570}, своего воина на западе.",
	-- {quest:94744} The Wayward Warrior · {npc:258570} Da'grosh · {area:16723} Sunnyglade
	["{quest:94744}: for {npc:258570}, west of {area:16723}"] = "{quest:94744}: для персонажа {npc:258570}, к западу от {area:16723}",

	-- Step 123: Fly to Kargath
	-- {npc:258570} Da'grosh · {npc:256899} Chogg'Zac · {zone:2548} Riverglades · {area:16743} Rog'mar · {npc:255993} Grakna · {area:340} Kargath · {area:3} Badlands
	["The rest of this guide is {npc:258570}'s camp in the west, which waits on {npc:256899}: without him the {zone:2548} end here. Back to {area:16743} from the port, where your Hearthstone is set: {npc:255993}, the wind rider master in the middle of the fort, flies to {area:340} in the {area:3}, where the next guide starts."] = "",

	-- Step 124: Da'grosh
	-- {area:16743} Rog'mar · {area:16723} Sunnyglade · {area:16685} Twilight's Shroud · {npc:258570} Da'grosh · {npc:256418} Krom'rosh
	["West from {area:16743} through {area:16723} and on up the valley towards {area:16685}: {npc:258570}, {npc:256418}'s wayward warrior, keeps a camp in the hills below the Twilight cult's fortress."] = "На запад из {area:16743} через {area:16723} и дальше вверх по долине к {area:16685}: {npc:258570}, своенравный воин персонажа {npc:256418}, разбил лагерь в холмах под крепостью культа Сумеречного Молота.",

	-- Step 125: Crag'rog
	-- {npc:260993} Crag'rog · {area:16726} Bolder'ok · {npc:258570} Da'grosh
	["{npc:260993}, a {area:16726} ogre, hides in the cave west of {npc:258570}'s camp."] = "{npc:260993}, огр из племени {area:16726}, прячется в пещере к западу от лагеря NPC {npc:258570}.",

	-- Step 126: The Twilight camps
	["The Twilight camps"] = "Лагеря Сумеречного Молота",
	-- {npc:258570} Da'grosh · {npc:256881} Overlord Kilgar · {npc:256891} Executioner Morg · {npc:258023} Sergeant Riftan
	-- plural, as words: Rog'mar Scouts = {npc:257450} Rog'mar Scout · Twilight Enforcers = {npc:256800} Twilight Enforcer · Farholde Lookouts = {npc:258686} Farholde Lookout
	["The cult's camps fill the valley south and west of {npc:258570}. Free the captive Rog'mar Scouts as you find them. Twilight Enforcers (elites, level 45) patrol through the camps: watch where they walk before each pull. {npc:256881} and {npc:256891} (elites, 46) hold the fortress at the valley's head: pull the cultists away from them. {npc:258023}'s Alliance camp sits at the valley's south end, and its Farholde Lookouts (level 46) attack the Horde: stay north of it."] = "Лагеря культа занимают долину к югу и западу от NPC {npc:258570}. Освобождайте пленных разведчиков Рог'мара по пути. Через лагеря патрулируют каратели Сумеречного Молота (элита, 45-й уровень): прежде чем атаковать, следите за их маршрутом. {npc:256881} и {npc:256891} (элита, 46) удерживают крепость в верхней части долины: оттаскивайте сектантов подальше от них. Лагерь Альянса ({npc:258023}) находится в южном конце долины, и его дозорные Фархольда (46-й уровень) нападают на Орду: держитесь к северу от него.",
	-- plural, as words: Rog'mar Scouts = {npc:257450} Rog'mar Scout
	["free five captive Rog'mar Scouts"] = "освободите пятерых пленных разведчиков Рог'мара",

	-- Step 127: The ogre mine
	["The ogre mine"] = "Огрская шахта",
	-- plural, as words: Twilight Enforcers = {npc:256800} Twilight Enforcer
	["North of the camps the cult works ogre miners in a mine: talk five of them into rising up against their masters.\nCareful: Twilight Enforcers (elites, level 45) walk past the mine's mouth on their way through the camps. Wait for one to pass before you go in."] = "К северу от лагерей культ заставляет огров-рудокопов работать в шахте: уговорите пятерых из них восстать против хозяев.\nОсторожно: каратели Сумеречного Молота (элита, 45-й уровень) проходят мимо входа в шахту, патрулируя лагеря. Дождитесь, пока один пройдет, прежде чем входить.",
	-- plural, as words: Ogre Miners = {npc:260995} Ogre Miner
	["recruit five Ogre Miners"] = "завербуйте пятерых огров-рудокопов",

	-- Step 130: Bring Me His Head
	-- {npc:256881} Overlord Kilgar
	["{npc:256881} is an elite (level 46) in the fortress at the head of the valley, with the Enforcers around him: grouping up is advised."] = "{npc:256881} – элита (уровень 46) в крепости в верховье долины, вокруг него каратели: рекомендуется собрать группу.",

	-- Step 131: Twilight's Shroud
	-- {area:340} Kargath · {area:3} Badlands · {area:16685} Twilight's Shroud · {npc:258570} Da'grosh · {area:16743} Rog'mar · {area:16723} Sunnyglade
	["The next guide flies from {area:340} in the {area:3}: up through {area:16685}, the pass at the valley's north-west end, just north of {npc:258570}'s camp. Coming from {area:16743}, ride west through {area:16723} and keep north of the Twilight camps below the pass."] = "",

	-- Step 132: Kargath
	-- {area:3} Badlands · {area:340} Kargath
	["Across the {area:3} to {area:340}, the Horde fortress built into the cliffs at the zone's western edge: its flight master stands at the foot of the fortress."] = "Через {area:3} в {area:340} – крепость Орды, встроенную в скалы у западного края зоны: распорядитель полетов стоит у подножия крепости.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the port, from the north pier west through the docks."] = "Возвращайтесь в порт: от северного пирса на запад через доки.",
	-- ["Back to the port."] = "Возвращайтесь в порт.",
	-- ["Careful: {npc:256899}, the two-headed ogre at the western edge of {area:16723}, is an elite (level 41): grouping up is advised under 43. Clear the cultists around him first and come in with full health and mana: recorded players of 42-43 killed him alone. {npc:255829}'s quests in {area:16726} wait on this one: skip him and {quest:95420}, the {area:16726} quests and {npc:258570}'s camp in the west go with him (about 21,000 XP); the guide then leaves them out."] = "Осторожно: {npc:256899}, двухголовый огр на западной окраине места {area:16723}, – элита (41-й уровень): до 43-го уровня советуем собрать группу. Сначала зачистите культистов вокруг него и вступайте в бой с полным здоровьем и маной: игроки 42-43-го уровня убивали его в одиночку. От него зависят задания NPC {npc:255829} ({area:16726}): если пропустите его, вместе с ним отпадут {quest:95420}, задания в месте {area:16726} и лагерь NPC {npc:258570} на западе (около 21 000 опыта); гайд их тогда пропустит.",
	-- ["Down to the port."] = "Спускайтесь в порт.",
	-- ["New in Forever: this guide follows what players did in the {area:16591}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\nFrom {area:340}, ride south-east across the {area:3} to the zone's southern edge: the pass of {area:16685} leads down into the {area:16591}. {area:16743}, the Horde's fort, stands in the middle of the zone, east along the valley."] = "Новое в Forever: этот гайд повторяет то, что делали игроки здесь: {area:16591}. Если шаг неверен, сообщите нам в Discord или на GitHub Polestar и назовите шаг.\nИз места {area:340} езжайте на юго-восток через {area:3} к южному краю зоны: перевал {area:16685} ведет вниз сюда: {area:16591}. {area:16743}, крепость Орды, стоит в центре зоны, к востоку по долине.",
	-- ["North along the coast from the port: the Eastsea raiders and bombardiers have dug in on the slopes west of the buccaneers' camp, among their powder kegs. Watch for {npc:259758} on these cliffs.\nCareful: the Eastsea Raiders are level 44-45, a level or two over you here: pull them one at a time from the edge of the slopes and keep clear of the camp behind them."] = "На север вдоль побережья от порта: налетчики и бомбардиры Восточного моря окопались на склонах к западу от лагеря буканьеров, среди пороховых бочек. Остерегайтесь: {npc:259758} на этих утесах.\nОсторожно: налетчики Восточного моря 44–45-го уровня, на уровень-два выше вас: выманивайте их по одному с края склонов и держитесь подальше от лагеря за ними.",
	-- ["Out to the pirates' cliffs once more. Plant Whizzbuzz's charges on the three ships moored below the camp, south to north; {quest:95124} stands by the middle one, with her loot chest beside her. Keep an eye out for {npc:259758} on the way.\nCareful: {quest:95124} is level 45, a level or two over you here: clear the deck around her first and come in with full health."] = "Еще раз к пиратским утесам. Заложите заряды Вжиквжика на три корабля, стоящих под лагерем, с юга на север; {quest:95124} стоит у среднего, рядом с сундуком с добычей. По пути остерегайтесь: {npc:259758}.\nОсторожно: {quest:95124} — 45-го уровня, на уровень-два выше вас: сначала зачистите палубу вокруг нее и вступайте в бой с полным здоровьем.",
	-- ["The next guide flies from {area:340} in the {area:3}: north out of {npc:258570}'s valley and up through {area:16685}, the way through to the {area:3}."] = "Следующий гайд начинается с полета из места {area:340} ({area:3}): на север из долины NPC {npc:258570} и вверх через {area:16685} – это путь в {area:3}.",
	-- ["The {npc:260244} prowls the shallows south-west of the port, below the murlocs' beaches. {npc:257001}, an elite, walks the shore close by: give him room."] = "{npc:260244} рыщет по отмели к юго-западу от порта, ниже пляжей мурлоков. {npc:257001} (элита) ходит по берегу неподалеку: держитесь от него подальше.",
	-- ["West of Rog'mar the Twilight cult holds the farm town of {area:16723}. {npc:259158}, a kobold who wants out, hides in the middle of the town."] = "К западу от Рог'мара культ Сумеречного Молота захватил фермерский городок {area:16723}. {npc:259158}, кобольд, который хочет уйти, прячется в центре городка.",
	-- ["{npc:255897}: {quest:95296}, for {npc:260405} at {area:977} in the {zone:1444} & {zone:1446} guide"] = "{npc:255897}: {quest:95296}, для персонажа {npc:260405} ({area:977}) в гайде «{zone:1444} и {zone:1446}»",
	-- ["{npc:263190}'s spears, on the Freshwater Crocolisks"] = "Копья ({npc:263190}) – на пресноводных кроколисков",
	-- ["{quest:95267}: a big beast in the shallows south-west of the port, near {npc:257001}, the elite"] = "{quest:95267}: крупный зверь на отмели к юго-западу от порта, рядом с NPC {npc:257001} (элита)",
	-- ["{quest:95293}: for {npc:260390} at the pirates' camp"] = "{quest:95293}: для NPC {npc:260390} в лагере пиратов",
}
