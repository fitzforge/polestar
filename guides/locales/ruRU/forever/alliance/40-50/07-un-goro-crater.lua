-- Russian (ruRU): the guide forever/alliance/40-50/07-un-goro-crater (forever/alliance/40-50/07-un-goro-crater.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "",

	-- Step 3: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Летите сюда: {area:976}",
	["Theramore flight master"] = "",

	-- Step 4: Gadgetzan
	-- {area:976} Gadgetzan
	["The flight from Theramore lands in {area:976}."] = "Полет из Терамора приземляется в городе {area:976}.",

	-- Step 6: Sprinkle
	-- {npc:7564} Marin Noggenfogger
	["{npc:7564}, once he has brewed the elixir: a few seconds"] = "",

	-- Step 8: Torwa Pathfinder
	-- {area:976} Gadgetzan · {zone:1449} Un'Goro Crater · {npc:9619} Torwa Pathfinder
	["Ride west out of {area:976} to the long ramp down into {zone:1449}. {npc:9619} camps at the foot of the ramp, in the south-east corner of the crater."] = "Езжайте на запад из города {area:976} к длинному спуску в зону {zone:1449}. {npc:9619} стоит лагерем у подножия спуска, в юго-восточном углу кратера.",

	-- Step 9: Fresh Threshadon Carcass
	-- {npc:9619} Torwa Pathfinder
	["The dead Threshadon lies by the water north of {npc:9619}."] = "Мертвый жесткозуб лежит у воды к северу от {npc:9619}.",

	-- Step 11: Lar'korwi Mates and the raft
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["Lar'korwi Mates and the raft"] = "Самки Лар'корви и плот",
	-- {npc:9619} Torwa Pathfinder · {npc:8737} Linken · {item:11116} A Mangled Journal
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["The Lar'korwi Mates prowl the jungle west of {npc:9619}. The wrecked raft lies on the shore of the lake there; the small pack sits in the water beside it. Keep the compass, map and key for {npc:8737}. Any beast in the crater may drop {item:11116}: right-click it."] = "Самки Лар'корви рыщут по джунглям к западу от {npc:9619}. Разбитый плот лежит там на берегу озера; маленький рюкзак – в воде рядом с ним. Компас, карту и ключ сохраните для NPC {npc:8737}. С любого зверя в кратере может выпасть {item:11116}: щелкните по нему правой кнопкой.",
	-- {object:161504} A Small Pack
	["{object:161504}, underwater"] = "",

	-- Step 12: Karna Remtravel
	-- {npc:9618} Karna Remtravel
	["{npc:9618} stands just outside the refuge."] = "{npc:9618} стоит сразу у входа в укрытие.",

	-- Step 13: Marshal's Refuge
	-- {object:157936} Un'Goro Dirt Pile
	["Ride west back to the refuge.\nGive the elite devilsaurs and stegodons a wide berth. Pick up every Power Crystal and {object:157936} you pass from here on."] = "",
	-- {npc:9998} Shizzle
	["{npc:9998}, at the refuge entrance"] = "{npc:9998} – у входа в укрытие",
	-- {npc:8737} Linken
	["{npc:8737}, at the back of the refuge"] = "{npc:8737} – в глубине лагеря",
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}: keep it"] = "Завершается у NPC {npc:9298} (зона {zone:1452}): сохраните",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, at the back of the cave; below ground"] = "",

	-- Step 14: Fire Plume Ridge and the eastern jungle
	-- {area:537} Fire Plume Ridge
	["{area:537} and the eastern jungle"] = "{area:537} и восточные джунгли",
	-- {area:537} Fire Plume Ridge · {item:11113} Crate of Foodstuffs
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher
	["Ride south to {area:537} in the middle of the crater, then east into the eastern jungle. Crystal clusters stand all over the crater, many of them around {area:537}: take a few extra of each colour. Bloodpetal Lashers and Threshers drop the petals; the expedition's {item:11113} sits at an abandoned camp in the eastern jungle."] = "Езжайте на юг: {area:537} в середине кратера, затем на восток в восточные джунгли. Скопления кристаллов стоят по всему кратеру, многие – вокруг места {area:537}: возьмите по несколько лишних каждого цвета. Лепестки падают с кровоцветов-хлыстунов и кровоцветов-крепкозубов; {item:11113} экспедиции лежит в заброшенном лагере в восточных джунглях.",

	-- Step 16: Marshal's Refuge
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "",
	-- {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["For {npc:7775} in {zone:1444}: keep it"] = "Для NPC {npc:7775} (зона {zone:1444}): сохраните",

	-- Step 17: Northern Pylon
	["Northern Pylon"] = "Северный пилон",
	-- {npc:9998} Shizzle
	["The pylon stands on the slope east of the refuge. Pterrordax circle the slopes around it: they count for Spraggle and drop {npc:9998}'s scales."] = "",

	-- Step 18: A-Me 01
	-- {area:1943} Ironstone Plateau
	["Ride north to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "Езжайте на север: {area:1943}, где робот стоит среди горилл. Не заходите там в глубокую пещеру.",
	["Below ground"] = "",

	-- Step 19: Level 49.51
	["Level 49.51"] = "",
	-- {area:541} Marshal's Refuge · {area:2100} Maraudon
	["Top up here to level 49.51 before the hand-ins at {area:541}: they take you to level 50. Or, with a group, run the {area:2100} dungeon instead."] = "",
	["Pterrordax"] = "Жутедактиль",
	["grind on Pterrordax"] = "",

	-- Step 20: Crate of Foodstuffs
	-- {npc:9165} Fledgling Pterrordax · {npc:9998} Shizzle
	-- plural, as words: Young Diemetradons = {npc:9162} Young Diemetradon
	["Ride south down the east side. Young Diemetradons graze the eastern jungle and {npc:9165} fly near the eastern cliffs; both drop {npc:9998}'s scales. The crate sits at the abandoned camp in the eastern jungle."] = "",

	-- Step 21: Eastern Pylon
	["Eastern Pylon"] = "Восточный пилон",
	["The pylon stands on the eastern cliffs."] = "Пилон стоит на восточных утесах.",

	-- Step 22: The Gorishi hive
	["The Gorishi hive"] = "Улей Гориши",
	-- {npc:9619} Torwa Pathfinder · {quest:3764} Un'Goro Soil · {spell:8137} Silithid Pox · {spell:14120} Tunneler Acid
	-- plural, as words: Gorishi Workers = {npc:6552} Gorishi Worker
	["Ride south-west past {npc:9619}: the silithid hive fills the south of the crater. Use the Scraping Vial on a hatchery, a chamber with hanging larvae. Gorishi wasps and workers drop {quest:3764}; Pterrordax nest on the southern cliffs if you still need kills.\nCareful: Gorishi silithids are level 51-54 and cast {spell:8137} or {spell:14120} in melee; Gorishi Workers have a 50% chance to call for help within 25 yd once they fall below 45% health."] = "",
	-- {npc:9167} Frenzied Pterrordax
	["grind on {npc:9167}"] = "",

	-- Step 23: Bones and equipment
	["Bones and equipment"] = "Кости и оборудование",
	-- {item:11112} Research Equipment
	-- plural, as words: Dinosaur Bones = {item:11114} Dinosaur Bone
	["Dinosaur Bones lie on the ground in the south-west, among the stegodons: those are elite, pick the bones up around them and take the rest from Diemetradons. The expedition's {item:11112} lies in the south-west jungle."] = "Кости динозавров лежат на земле на юго-западе, среди стегодонов: они элитные, поэтому подбирайте кости вокруг них, а остальные добывайте с деметродонов. {item:11112} экспедиции лежит в юго-западных джунглях.",
	-- {npc:9164} Elder Diemetradon
	["grind on {npc:9164}"] = "",

	-- Step 24: Western Pylon
	["Western Pylon"] = "Западный пилон",
	-- {npc:9167} Frenzied Pterrordax
	["The pylon stands on the western cliffs. {npc:9167} fly over the whole west side."] = "Пилон стоит на западных утесах. {npc:9167}: летают над всей западной стороной.",

	-- Step 25: Marshal's Refuge
	["Ride north along the western jungle back to the refuge."] = "Езжайте на север через западные джунгли назад в укрытие.",
	-- {npc:9998} Shizzle
	["{npc:9998}, at the refuge's entrance"] = "{npc:9998} – у входа в укрытие",

	-- Step 26: To Stoutlager Inn
	-- {area:2101} Stoutlager Inn
	["To {area:2101}"] = "",

	-- Step 27: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "",

	-- Step 28: Hall of Explorers
	-- {npc:9616} Laris Geardawdle · {zone:1448} Felwood
	["{npc:9616}: the oozes are in {zone:1448}, keep it"] = "{npc:9616}: слизни – в зоне {zone:1448}, сохраните",

	-- Step 29: Mystic Ward
	-- {zone:1447} Azshara
	["Four rune rubbings in {zone:1447}: keep it"] = "Четыре оттиска рун в зоне {zone:1447}: сохраните",
	-- {npc:11406} High Priest Rohan · {zone:1447} Azshara
	["{npc:11406}: for Ogtinc in {zone:1447}, keep it"] = "{npc:11406}: для Огтинка (зона {zone:1447}), сохраните",
	-- {npc:7312} Dink · {npc:8395} Sanath Lim-yo · {zone:1447} Azshara
	["{npc:7312}, the mage trainer: for {npc:8395} in {zone:1447}, keep it"] = "",

	-- Step 30: Class trainer
	["Class trainer"] = "Учитель классовых навыков",

	-- Step 31: Xiggs Fuselighter
	-- {object:32359} Military Ward
	["Xiggs waits in the {object:32359}."] = "Зиггс ждет здесь: {object:32359}.",

	-- Step 34: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "",

	-- Step 35: Level 50.4
	["Level 50.4"] = "",
	-- {area:3137} Talrendis Point · {area:2100} Maraudon · {area:1417} Sunken Temple
	["Top up here to level 50.4 before the hand-ins at {area:3137}: they take you to level 51. Or, with a group, run the {area:2100} dungeon or the {area:1417} dungeon instead."] = "",
	-- {npc:6116} Highborne Apparition
	["grind on {npc:6116}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Archesonus stands beside King Magni in the {object:171709}."] = "Аркессон стоит рядом с королем Магни ({object:171709}).",
	-- ["Bind and train"] = "Привяжите камень и обучитесь",
	-- ["Cross the south of the crater to {npc:9619} by the ramp."] = "Пересеките юг кратера и вернитесь к {npc:9619} у спуска.",
	-- ["Escort {npc:9999}"] = "Сопроводите NPC {npc:9999}",
	-- ["Fly from {area:144} to {area:1537}."] = "Летите из поселка {area:144} в {area:1537}.",
	-- ["From {area:144} fly to {area:150}, take the boat to Theramore and fly on to {area:976}. {npc:9619}'s first quest in the crater needs level 48: finish the level here if you are short."] = "Из поселка {area:144} летите в {area:150}, сядьте на корабль до Терамора и летите дальше в {area:976}. Первое задание {npc:9619} в кратере требует 48-го уровня: если не хватает, доберите уровень здесь.",
	-- ["Grind to 50"] = "Добейте 50-й уровень",
	-- ["Grind to 51"] = "Добейте 51-й уровень",
	-- ["Gryfe"] = "Грайф",
	-- ["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Отведите NPC {npc:9999} на север: {area:541}. Когда он упадет в обморок, используйте на нем {item:11804}, чтобы привести его в чувство.",
	-- ["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "Езжайте по спуску вниз в кратер: {npc:9619} стоит лагерем у его подножия.",
	-- ["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "Езжайте на восток к вулкану ({area:537}), поднимитесь на него и используйте {npc:10541} у лавовых отдушин у вершины.",
	-- ["Ride north along the east side of the crater to {area:541}, the camp in the caves of the northern cliff. Give the elite devilsaurs and stegodons a wide berth. Pick up every Power Crystal and {object:157936} you pass from here on."] = "Езжайте на север по восточной стороне кратера: {area:541} – лагерь в пещерах северного утеса. Обходите элитных девизавров и стегодонов стороной. Отсюда и дальше подбирайте каждый кристалл силы и каждый объект {object:157936} по пути.",
	-- ["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "Езжайте на север по восточной стороне к плато горилл. {npc:9622}, горилла 55-го уровня, сидит в самой глубокой пещере: сначала перебейте горилл у входа.",
	-- ["Ride south along the eastern cliffs to {npc:9619} at the foot of the ramp."] = "Езжайте на юг вдоль восточных утесов к {npc:9619} у подножия спуска.",
	-- ["Ride south down the east side. Young Diemetradons graze the eastern jungle and {npc:9165} fly near the eastern cliffs; both drop {npc:9998}'s scales."] = "Езжайте на юг по восточной стороне. Молодые деметродоны пасутся в восточных джунглях, а у восточных утесов летает {npc:9165}; с тех и других падает чешуя для NPC {npc:9998}.",
	-- ["Ride west back to the refuge."] = "Езжайте на запад назад в укрытие.",
	-- ["Ride west from {npc:9619}: the silithid hive fills the south of the crater. Use the Scraping Vial on a hatchery, a chamber with hanging larvae. Gorishi wasps and workers drop {quest:3764}; {npc:9166} nest on the southern cliffs if you still need kills."] = "Езжайте от {npc:9619} на запад: улей силитидов занимает юг кратера. Используйте фиал для образцов на инкубаторе – камере со свисающими личинками. С ос и рабочих из улья Гориши падает предмет для задания «{quest:3764}»; если вам еще нужны убийства, на южных утесах гнездится {npc:9166}.",
	-- ["Ride west out of {area:976} to the long ramp down into {area:490}. {npc:9619} camps at the foot of the ramp, in the south-east corner of the crater."] = "Езжайте на запад из города {area:976} к длинному спуску в зону {area:490}. {npc:9619} стоит лагерем у подножия спуска, в юго-восточном углу кратера.",
	-- ["Ride west past {area:541} and south down the western side to {area:543}: {npc:10302} the goblin sits by the water."] = "Езжайте на запад мимо места {area:541} и на юг по западной стороне: {area:543}. {npc:10302}, гоблин, сидит у воды.",
	-- ["Running the {area:1417} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "Пройти {area:1417} вместо убийства монстров в группе быстрее. Пропустите этот шаг, чтобы качаться в одиночку.",
	-- ["Running {area:978} instead of grinding gets you there faster in a group. The troll city lies in the north-west of {zone:1446}, just north of {area:976}."] = "Пройти {area:978} вместо убийства монстров в группе быстрее. Город троллей лежит на северо-западе зоны {zone:1446}, сразу к северу от города {area:976}.",
	-- ["The Centipaar silithid crawl around the {area:982} in western {zone:1446}, just east of the crater ramp. The Workers are the easiest pulls."] = "Силитиды-сентипаары ползают вокруг улья ({area:982}) на западе зоны {zone:1446}, сразу к востоку от спуска в кратер. Легче всего выманивать рабочих.",
	-- ["The east side"] = "Восточная сторона",
	-- ["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55."] = "Гориллы живут здесь: {area:1943}, к востоку от места {area:541}. Их шкуры сохраните для NPC {npc:9619}. Не заходите в самую глубокую пещеру: {npc:9622} – 55-го уровня.",
	-- ["The gorillas of {area:1943} come in small groups and drop nothing for you yet; {npc:9619}'s pelt quest comes later. Stay out of the deepest cave: {npc:9622} is level 55."] = "Гориллы на плато ({area:1943}) ходят небольшими группами, и пока с них ничего не падает для вас; задание {npc:9619} на шкуры будет позже. Не заходите в самую глубокую пещеру: {npc:9622} – 55-го уровня.",
	-- ["The pelts come after loop 2, on the gorilla plateau"] = "Шкуры – после 2-го круга, на плато горилл",
	-- ["The pylon stands on the slope east of the refuge. {npc:9166} circle the slopes around it: they count for {npc:9997} and drop {npc:9998}'s scales."] = "Пилон стоит на склоне к востоку от укрытия. {npc:9166}: кружат над склонами вокруг него, засчитываются для {npc:9997} и роняют чешую для NPC {npc:9998}.",
	-- ["The relics are in the {zone:1428}: keep it"] = "Реликвии – в зоне {zone:1428}: сохраните",
	-- ["The wooden sign beside {npc:9997}"] = "Деревянная табличка рядом с NPC {npc:9997}",
	-- ["grind on the Wastewanderers or Dunemaul ogres around {area:976}"] = "убивайте Скитальцев Пустыни или огров из клана Песчаного Молота вокруг города {area:976}",
	-- ["grind on {npc:5458} at {area:982}, {zone:1446}"] = "убивайте: {npc:5458} ({area:982}, {zone:1446})",
	-- ["grind on {npc:6514} at {area:1943}, {zone:1449}"] = "убивайте: {npc:6514} ({area:1943}, {zone:1449})",
	-- ["{area:978} (optional)"] = "{area:978} (необязательно)",
	-- ["{item:11834} from {npc:6518} and {npc:6519}, 60 yd south"] = "{item:11834}: падает с NPC {npc:6518} и {npc:6519}, в 60 м к югу",
	-- ["{npc:6734}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6734}: предыдущий гайд возвращает вас сюда камнем возвращения, так что это обычно отмечается сразу",
	-- ["{npc:9117}, at the back of the cave"] = "{npc:9117} – в глубине пещеры",
	-- ["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "Логово зверя {npc:9684} – в джунглях к северу от {npc:9619}, под восточными утесами: используйте там {item:11568}. {npc:9684} – 56-го уровня: начинайте бой с полным здоровьем.",
	-- ["{npc:9997}'s friend {npc:9999} has gone missing."] = "Пропал друг {npc:9997} – {npc:9999}.",
	-- ["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999} сидит на юго-восточном склоне вулкана ({area:537}) в середине кратера.",
}
