-- Russian (ruRU): the guide forever/alliance/30-40/04-stranglethorn-vale (forever/alliance/30-40/04-stranglethorn-vale.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Ironforge
	-- {area:150} Menethil Harbor · {area:1537} Ironforge
	["Fly from {area:150} to {area:1537} and train."] = "Летите в {area:1537} (вылет: {area:150}) и обучитесь.",

	-- Step 2: Druid training
	["Druid training"] = "Обучение друида",
	-- {area:1537} Ironforge · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind · {npc:5504} Sheldras Moontree
	["{area:1537} has no druid trainer: take the {area:2257} from {object:171524} to {zone:1453} and train with {npc:5504}."] = "В городе {area:1537} нет учителя друидов: в районе {object:171524} сядьте на поезд ({area:2257}) до города {zone:1453} и обучитесь у NPC {npc:5504}.",

	-- Step 3: Darkshire
	-- {area:42} Darkshire · {npc:1573} Gryth Thurden · {area:1537} Ironforge · {object:32372} Great Forge · {npc:352} Dungar Longdrink · {zone:1453} Stormwind · {object:2096} Trade District
	["Fly to {area:42}: {npc:1573} in {area:1537}'s {object:32372}, or {npc:352} in {zone:1453}'s {object:2096}."] = "Летите в поселок {area:42}: {npc:1573} ({area:1537}, {object:32372}) или {npc:352} ({zone:1453}, {object:2096}).",

	-- Step 4: Nesingwary's Expedition
	-- {zone:1431} Duskwood · {area:99} Rebel Camp
	["From {zone:1431} take the road south into Stranglethorn; the hunters' tents stand just west of the road past the {area:99} turn-off."] = "Из зоны {zone:1431} идите по дороге на юг в Тернистую долину; палатки охотников стоят сразу к западу от дороги, за поворотом к лагерю ({area:99}).",
	-- {npc:715} Hemet Nesingwary · {zone:1441} Thousand Needles
	["{npc:715}, from {zone:1441}"] = "{npc:715}: из зоны {zone:1441}",

	-- Step 5: Young tigers and panthers
	["Young tigers and panthers"] = "Молодые тигры и пантеры",
	["Both roam the grass around the camp and along the road north."] = "И те и другие бродят по траве вокруг лагеря и вдоль дороги на север.",

	-- Step 7: Stranglethorn Tigers
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["Stranglethorn Tigers"] = "Тигры Тернистой долины",
	["The adult tigers prowl the hills just south and west of the camp."] = "Взрослые тигры рыщут по холмам сразу к югу и западу от лагеря.",

	-- Step 8: Ajeck Rouack
	-- {area:99} Rebel Camp
	["The elder tigers come later, on the way back from the {area:99}"] = "Старые тигры – позже, на обратном пути от лагеря ({area:99})",

	-- Step 9: Rebel Camp
	-- {npc:738} Private Thorsen
	["Take the road north; {npc:738} patrols it, the camp sits in the hills to the west."] = "Идите по дороге на север; {npc:738} патрулирует ее, лагерь – в холмах к западу.",
	-- {npc:469} Lieutenant Doren
	["{npc:469}, in the hut"] = "{npc:469} – в хижине",

	-- Step 10: Kurzen's Compound
	-- {area:99} Rebel Camp
	["The Kurzen rebels hold the camp east of the {area:99}; work its outer edge, where Jungle Fighters and Medicine Men stand, and loot the supply crates by the tents."] = "Повстанцы Курцена занимают лагерь к востоку от места {area:99}; действуйте по его внешнему краю, где стоят партизаны и целители Курцена, и обыскивайте ящики с припасами у палаток.",
	-- {item:2634} Venom Fern Extract · {object:263} Kurzen Supplies
	["{item:2634}, from a {object:263} crate"] = "{item:2634}: из ящика ({object:263})",

	-- Step 11: Bookie Herod
	["Herod's records lie in a hut on the compound's west side; his strongbox sits farther east, by the cave mouth."] = "Записи Герода лежат в хижине на западной стороне лагеря; его сундук стоит дальше на востоке, у входа в пещеру.",

	-- Step 13: Panthers, raptors and elder tigers
	["Panthers, raptors and elder tigers"] = "Пантеры, ящеры и старые тигры",
	-- plural, as words: Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Back south past Nesingwary: Panthers and Stranglethorn Raptors run in the clearings west of the camp toward the coast; the elder tigers hold the hills south-west."] = "Назад на юг мимо Эрнестуэя: пантеры и ящеры Тернистой долины бегают по полянам к западу от лагеря в сторону побережья; старые тигры занимают холмы на юго-западе.",
	-- {item:4614} Pendant of Myzrael
	["Gluggle, a rare murloc on the coast west of camp, drops the {item:4614}: take it if you meet him"] = "Барабуль, редкий мурлок на побережье к западу от лагеря, роняет предмет {item:4614}: заберите его, если встретите",

	-- Step 15: Sin'Dall and the Lashtail raptors
	-- {npc:729} Sin'Dall
	["{npc:729} and the Lashtail raptors"] = "{npc:729} и ящеры-кнутохвосты",
	-- {npc:729} Sin'Dall · {area:35} Booty Bay
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{npc:729}, the great tiger, lairs on the hilltop south-west of the camp; Lashtail Raptors run south of it, along the way to {area:35}."] = "{npc:729}, огромный тигр, живет на вершине холма к юго-западу от лагеря; ящеры-кнутохвосты бегают к югу от него, по пути в {area:35}.",

	-- Step 16: Down to Booty Bay
	-- {area:35} Booty Bay
	["Down to {area:35}"] = "Вниз: {area:35}",
	-- {object:3202} Grom'gol · {area:35} Booty Bay
	["Follow the main road south the length of the jungle, past the {object:3202} turn-off, to {area:35} on the southern cape."] = "Идите по главной дороге на юг через все джунгли, мимо поворота на {object:3202}, до южного мыса: {area:35}.",
	["Gyll, on the top floor by the docks"] = "Гилл – на верхнем этаже у причалов",
	-- {npc:2832} Nixxrax Fillamug · {object:56910} The Salty Sailor Tavern
	["{npc:2832}, in the {object:56910}"] = "{npc:2832} – {object:56910}",
	-- {npc:2495} Drizzlik
	["{npc:2495}, by the bank"] = "{npc:2495} – у банка",
	-- {npc:773} Krazek
	["{npc:773}, in the tavern"] = "{npc:773} – в таверне",
	-- {npc:737} Kebok
	["{npc:737}, in the tavern"] = "{npc:737} – в таверне",

	-- Step 17: Crystalvein Mine
	-- {area:310} Crystalvein Mine
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["Walk back north; the {area:310} lies west of the road in the middle of the jungle. The Crystal Spine Basilisks there drop the shards."] = "Идите назад на север; {area:310} – к западу от дороги, в середине джунглей. Осколки падают с хрустальных василисков, которые там водятся.",

	-- Step 18: Bloodscalp trolls
	["Bloodscalp trolls"] = "Тролли из племени Кровавого Скальпа",
	["The Bloodscalp trolls hold the ruins on the coast west of Nesingwary's camp."] = "Тролли из племени Кровавого Скальпа занимают руины на побережье к западу от лагеря Эрнестуэя.",

	-- Step 19: Nesingwary's Expedition
	-- {quest:201} Investigate the Camp
	["{quest:201}: just look around the hunters' camp"] = "{quest:201}: просто осмотритесь в лагере охотников",

	-- Step 20: Private Thorsen
	-- {area:99} Rebel Camp
	["Thorsen patrols the road north of camp, toward the {area:99}."] = "Торсен патрулирует дорогу к северу от лагеря, в сторону места {area:99}.",

	-- Step 21: River crocolisks
	["River crocolisks"] = "Речные кроколиски",
	-- {area:99} Rebel Camp
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["River Crocolisks swim the river by the {area:99}."] = "Речные кроколиски плавают в реке у места {area:99}.",

	-- Step 23: Snapjaw Crocolisks
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks"] = "Кроколиски-хрустогрызы",
	-- {area:35} Booty Bay
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks bask on the shore and islands along the coast north of {area:35}."] = "Кроколиски-хрустогрызы греются на берегу и островах вдоль побережья к северу от бухты ({area:35}).",

	-- Step 24: Booty Bay
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs in the tavern"] = "{npc:2496} – наверху в таверне",

	-- Step 25: The haunted island
	["The haunted island"] = "Остров духов",
	["Follow the west coast north; the haunted island lies off the shore west of Nesingwary's camp. Just reach it."] = "Идите вдоль западного побережья на север; остров духов лежит у берега к западу от лагеря Эрнестуэя. Достаточно добраться до него.",

	-- Step 26: Nesingwary's Expedition
	-- {npc:716} Barnil Stonepot · {item:2755} Green Hills of Stranglethorn
	["{npc:716} collects the {item:2755}: the pages drop from almost every humanoid in the jungle. Turn the pages into chapters as you go."] = "{npc:716} собирает страницы ({item:2755}): они падают почти со всех гуманоидов в джунглях. По ходу дела собирайте из страниц главы.",

	-- Step 28: Kurzen's Compound
	["Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave. Pick up Green Hills pages as they drop."] = "Охотники за головами Курцена стоят в глубине лагеря; коммандо Курцена прячутся в незаметности вокруг него и в пещере. Подбирайте выпавшие страницы «Зеленых холмов».",

	-- Step 29: The jungle ruins
	["The jungle ruins"] = "Руины в джунглях",
	-- {area:37} Lake Nazferiti
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Loop through the troll ruins of the north and centre: each holds one stone tablet of the troll legends. Shadowmaw Panthers prowl stealthed in the jungle around them; the Venture Co. camp on {area:37} carries the Tumbled Crystals."] = "Обойдите по кругу руины троллей на севере и в центре: в каждых лежит одна каменная табличка с легендами троллей. В джунглях вокруг них в незаметности рыщут тенебрюхие пантеры; упавшие кристаллы носят члены Торговой компании из лагеря у озера ({area:37}).",

	-- Step 30: Rebel Camp
	-- {npc:770} Corporal Kaleb · {npc:773} Krazek · {area:35} Booty Bay
	["{npc:770}: for {npc:773} in {area:35}"] = "{npc:770}: для NPC {npc:773} ({area:35})",

	-- Step 32: Skullsplitter trolls
	["Skullsplitter trolls"] = "Тролли из племени Дробителей Черепов",
	-- {object:3202} Grom'gol
	["The Skullsplitter trolls hold the ruins east of the road between Nesingwary and {object:3202}."] = "Тролли из племени Дробителей Черепов занимают руины к востоку от дороги между лагерем Эрнестуэя и местом {object:3202}.",

	-- Step 34: Booty Bay
	-- {zone:1417} Arathi Highlands
	["The ore drops from Drywhisker kobolds in {zone:1417}"] = "Руда падает с кобольдов из племени Сухоусов (зона {zone:1417})",

	-- Step 36: Baron Revilgaz
	-- {zone:1416} Alterac Mountains
	["For Archmage Ansirem in {zone:1416}"] = "Для верховного мага Ансарема (зона {zone:1416})",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Take the road north; {npc:738} stands on it, the camp sits in the hills to the west."] = "Идите по дороге на север; {npc:738} стоит на ней, лагерь – в холмах к западу.",
	-- ["{npc:2832}, in the {object:56910}"] = "{npc:2832} – {object:56910}",
	-- ["{quest:207}: four troll legends"] = "{quest:207}: четыре легенды троллей",
}
