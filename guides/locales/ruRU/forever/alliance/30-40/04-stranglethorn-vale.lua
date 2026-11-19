-- Russian (ruRU): the guide forever/alliance/30-40/04-stranglethorn-vale (forever/alliance/30-40/04-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Корабль: {area:35}",
	-- {area:392} Ratchet · {area:35} Booty Bay
	["The boat from {area:392}'s dock crosses to {area:35}, on Stranglethorn's southern cape."] = "",

	-- Step 2: Booty Bay
	["Bind your hearthstone at the inn: it is your way back here from the north of the jungle at the end of the loop."] = "",
	-- {npc:2495} Drizzlik
	["{npc:2495}, by the bank; inside"] = "{npc:2495} – у банка; внутри",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}, внутри",
	-- {npc:6807} Innkeeper Skindle · {object:56910} The Salty Sailor Tavern
	["{npc:6807}, {object:56910}; upstairs"] = "",
	-- {npc:2832} Nixxrax Fillamug · {object:56910} The Salty Sailor Tavern
	["{npc:2832}, in the {object:56910}; upstairs"] = "{npc:2832} – {object:56910}; наверху",
	-- {npc:773} Krazek · {npc:738} Private Thorsen · {area:99} Rebel Camp
	["{npc:773}, in the tavern; upstairs: {npc:738} is at the {area:99}, on the way"] = "",
	-- {npc:773} Krazek
	["{npc:773}: Nesingwary's camp, on the way"] = "",
	-- {npc:737} Kebok
	["{npc:737}, in the tavern"] = "{npc:737} – в таверне",
	-- {npc:737} Kebok
	-- plural, as words: Tumbled Crystals = {item:4106} Tumbled Crystal
	["{npc:737}: the Tumbled Crystals, on the northern loop"] = "",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs in the tavern"] = "{npc:2496} – наверху в таверне",

	-- Step 3: North to Nesingwary's Expedition
	-- {area:100} Nesingwary's Expedition
	["North to {area:100}"] = "На север: {area:100}",
	-- {object:3202} Grom'gol
	["Follow the main road north the length of the jungle, past the {object:3202} turn-off, to the hunters' camp just west of the road."] = "",

	-- Step 4: Nesingwary's Expedition
	-- {npc:773} Krazek · {quest:201} Investigate the Camp
	["The hunters' tents stand just west of the road. {npc:773}'s {quest:201} only asks you to look around it."] = "",
	-- {quest:201} Investigate the Camp
	["{quest:201}: just look around the hunters' camp"] = "{quest:201}: просто осмотритесь в лагере охотников",
	-- {npc:715} Hemet Nesingwary · {zone:1441} Thousand Needles
	["{npc:715}, from {zone:1441}"] = "{npc:715}: из зоны {zone:1441}",

	-- Step 5: Young tigers and panthers
	["Young tigers and panthers"] = "Молодые тигры и пантеры",
	["Both roam the grass around the camp and along the road north."] = "И те и другие бродят по траве вокруг лагеря и вдоль дороги на север.",

	-- Step 6: River crocolisks
	["River crocolisks"] = "Речные кроколиски",
	-- {area:99} Rebel Camp
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["River Crocolisks (30-31) swim the river right beside Nesingwary's camp and up toward the {area:99}."] = "",

	-- Step 10: Stranglethorn Tigers
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["Stranglethorn Tigers"] = "Тигры Тернистой долины",
	["The adult tigers prowl the hills just south and west of the camp."] = "Взрослые тигры рыщут по холмам сразу к югу и западу от лагеря.",

	-- Step 11: Ajeck Rouack
	-- {area:99} Rebel Camp
	["The elder tigers come later, on the way back from the {area:99}"] = "Старые тигры – позже, на обратном пути от лагеря ({area:99})",

	-- Step 12: Panthers, raptors and elder tigers
	["Panthers, raptors and elder tigers"] = "Пантеры, ящеры и старые тигры",
	-- plural, as words: Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Back south past Nesingwary: Panthers and Stranglethorn Raptors run in the clearings west of the camp toward the coast; the elder tigers hold the hills south-west."] = "Назад на юг мимо Эрнестуэя: пантеры и ящеры Тернистой долины бегают по полянам к западу от лагеря в сторону побережья; старые тигры занимают холмы на юго-западе.",
	-- {item:4614} Pendant of Myzrael
	["Gluggle (37, rare) on the coast west of camp drops the {item:4614}: four levels over you, leave him unless you are grouped"] = "Барабуль (37, редкий) на побережье к западу от лагеря роняет предмет {item:4614}: он на четыре уровня выше вас, не трогайте его без группы",
	-- {object:661516} Thoroughly Scavenged Supplies (no name in this language: may be words)
	-- plural, as words: Stolen Shipments = {item:277953} Stolen Shipment
	["{object:661516}, a looted crate west of Nesingwary's camp: the Stolen Shipments lie in the Bloodscalp ruins on the coast, for the second Stranglethorn loop"] = "{object:661516} – разграбленный ящик к западу от лагеря Несингвари: украденные грузы лежат в руинах Кровавого Скальпа на побережье, для второго круга по Тернистой долине",

	-- Step 13: Sir S. J. Erlgadin
	-- {area:99} Rebel Camp
	["Back east to Nesingwary's camp on the way north to the {area:99}."] = "",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["keep it: the Shadowmaw Panthers (37-38) wait for the 40-50 Stranglethorn guide"] = "сохраните его: тенебрюхие пантеры (37-38) ждут гайда 40-50 по Тернистой долине",

	-- Step 14: Rebel Camp
	-- {npc:738} Private Thorsen · {quest:215} Jungle Secrets · {quest:200} Bookie Herod · {area:99} Rebel Camp
	-- plural, as words: Kurzen's Agents = {npc:775} Kurzen's Agent
	["Take the road north; the camp sits in the hills to the west.\n{npc:738} offers {quest:215} only while he is out of the camp: about every half hour he walks down the path to the road, where two Kurzen's Agents ambush him. Help him kill them and take the quest at once, before he walks back up. He isn't there? Leave it: the guide passes {quest:200}, which follows from it, as well.\n{npc:738} spends most of his time at the top of the {area:99}'s path, by the huts, and now and then walks down it to the road and back (about eight minutes). If he isn't at the arrow, look along that path."] = "",
	-- {npc:738} Private Thorsen
	["{npc:738}, at the foot of the path"] = "{npc:738} – у подножия тропы",
	-- {npc:738} Private Thorsen
	["{npc:738}: at the top of the path by the huts, or on his walk down it"] = "",
	-- {npc:469} Lieutenant Doren
	["{npc:469}, in the hut"] = "{npc:469} – в хижине",
	-- {npc:469} Lieutenant Doren · {quest:200} Bookie Herod · {area:101} Kurzen's Compound
	["{npc:469}: {quest:200}'s records lie at the edge of {area:101}, next"] = "",
	-- {npc:770} Corporal Kaleb · {npc:773} Krazek · {area:35} Booty Bay
	["{npc:770}: for {npc:773} in {area:35}, later in this guide"] = "{npc:770}: для NPC {npc:773} ({area:35}), позже в этом гайде",

	-- Step 15: Kurzen's Compound: kill these as you meet them
	-- {area:101} Kurzen's Compound
	["{area:101}: kill these as you meet them"] = "{area:101}: убивайте их по пути",
	-- {area:99} Rebel Camp · {quest:200} Bookie Herod
	-- plural, as words: Kurzen Elites = {npc:939} Kurzen Elite
	["The Kurzen rebels hold the camp east of the {area:99}; work its outer edge, where Jungle Fighters and Medicine Men stand, and loot the supply crates by the tents. {quest:200}'s records lie in a hut on the compound's west side. Careful: Kurzen Elites and Witch Doctors (36) hold the compound's eastern half, by the cave: stay on its west side."] = "Повстанцы Курцена занимают лагерь к востоку от места {area:99}; действуйте по его внешнему краю, где стоят партизаны и целители Курцена, и обыскивайте ящики с припасами у палаток. Записи для задания «{quest:200}» лежат в хижине в западной части лагеря. Осторожно: элитные бойцы и знахари Курцена (36) удерживают восточную половину лагеря у пещеры: держитесь западной стороны.",
	-- {object:287} Bookie Herod's Records
	["{object:287}, in the hut"] = "",
	["The strongbox is deeper in, by the cave: on the northern loop (04b)"] = "",
	-- {item:2634} Venom Fern Extract · {object:263} Kurzen Supplies
	["{item:2634}, from a {object:263} crate"] = "{item:2634}: из ящика ({object:263})",

	-- Step 16: Level 33.2
	["Level 33.2"] = "",
	-- {area:796} Scarlet Monastery
	-- plural, as words: Kurzen Jungle Fighters = {npc:937} Kurzen Jungle Fighter
	["The elder tigers next are 34-35: short of 33.2? Keep on the Kurzen Jungle Fighters and Medicine Men around the compound's outer edge until level 33.2. Or, with a group, run the {area:796} dungeon (Library) instead."] = "Старые тигры дальше – 34-35 уровня: не хватает до 33.2? Бейте партизан Курцена и знахарей по внешнему краю лагеря до уровня 33.2. Или с группой пройдите вместо этого подземелье {area:796} (Библиотека).",
	-- {npc:937} Kurzen Jungle Fighter
	["grind on {npc:937}"] = "убивайте: {npc:937}",

	-- Step 18: Stranglethorn Vale: kill these as you meet them
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434}: kill these as you meet them"] = "{zone:1434}: убивайте их по пути",
	["Careful: Troll camps are close to the tiger area, and trolls can join a fight if you pull carelessly.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "",

	-- Step 19: Nesingwary's Expedition
	-- {npc:716} Barnil Stonepot · {item:2755} Green Hills of Stranglethorn
	["{npc:716} collects the {item:2755}: the pages drop from almost every humanoid in the jungle. Turn the pages into chapters as you go."] = "{npc:716} собирает страницы ({item:2755}): они падают почти со всех гуманоидов в джунглях. По ходу дела собирайте из страниц главы.",
	-- {npc:729} Sin'Dall
	["keep it: {npc:729} (37) comes in the 40-50 Stranglethorn guide, at about 41"] = "сохраните его: {npc:729} (37) будет в гайде 40-50 по Тернистой долине, примерно на 41 уровне",
	-- {npc:729} Sin'Dall
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["keep it: the Lashtail Raptors come on the second loop (04b), around {npc:729}'s hill"] = "сохраните его: ящеры-кнутохвосты будут на втором круге (04b), у холма {npc:729}",

	-- Step 20: The Savage Coast
	-- {area:310} Crystalvein Mine
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk · Lesser Water Elementals = {npc:691} Lesser Water Elemental
	-- was: ["From {area:108} the way leads south out of {zone:1436} into Stranglethorn's north-west, to the {area:310} near the coast; the Crystal Spine Basilisks around it drop the shards.\nThe haunted island lies just off the coast south-west of the mine: just reach its edge. Careful: its Lesser Water Elementals are 36-37: don't stay. The Bloodscalp ruins of Zul'Kunda to the north wait for the second Stranglethorn loop."] = "От места {area:108} путь ведет на юг из зоны {zone:1436} в северо-запад Тернистой долины, к месту {area:310} у побережья; хрустальные василиски вокруг него роняют осколки.\nОстров с призраками лежит у побережья к юго-западу от рудника: достаточно добраться до его края. Осторожно: младшие элементали воды там 36-37 уровня – не задерживайтесь. Руины Кровавого Скальпа Зул'Кунда к северу ждут второго круга по Тернистой долине."
	["From Nesingwary's camp head west to the {area:310} near the coast; the Crystal Spine Basilisks around it drop the shards.\nThe haunted island lies just off the coast south-west of the mine: just reach its edge. Careful: its Lesser Water Elementals are 36-37: don't stay. The Bloodscalp ruins of Zul'Kunda to the north wait for the second Stranglethorn loop."] = "",
	["The haunted island"] = "Остров духов",

	-- Step 21: Booty Bay
	-- {area:35} Booty Bay
	["Hearth back to {area:35}."] = "",
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "{npc:2495}, внутри",
	-- {npc:2495} Drizzlik
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["{npc:2495}: the Snapjaw Crocolisks, on the northern loop"] = "",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "{npc:773}, наверху",
	-- {npc:773} Krazek · {npc:770} Corporal Kaleb
	["{npc:773}, from {npc:770}"] = "",
	-- {npc:737} Kebok
	["{npc:737}'s Bloodscalp ears wait for the second Stranglethorn loop: keep the quest."] = "Уши Кровавого Скальпа для NPC {npc:737} ждут второго круга по Тернистой долине: сохраните задание.",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}: the water elementals rise around the haunted island, on the northern loop"] = "",

	-- Step 22: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Лететь в {zone:1453}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Распорядитель полетов: {area:35}",

	-- Step 24: Collin Mauren
	-- {npc:4078} Collin Mauren · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["{npc:4078} is in the {object:2164}, in the {object:2101}."] = "",

	-- Step 25: Class training
	["Class training"] = "Обучение классовым навыкам",
	-- {object:2096} Trade District · {object:2100} Old Town · {object:2101} Mage Quarter · {npc:5504} Sheldras Moontree · {zone:1455} Ironforge
	["Your level 34 ranks: the class trainers stand around the {object:2096}, {object:2100}, the Cathedral and the {object:2101}; {npc:5504}, the druid trainer, stands north-west of the {object:2101}. Shamans train in {zone:1455}, later in 30-40."] = "",

	-- Step 27: Fly to Stonetalon Peak
	-- {area:467} Stonetalon Peak
	["Fly to {area:467}"] = "Летите в {area:467}",
	-- {area:467} Stonetalon Peak · {zone:1443} Desolace · {area:415} Astranaar · {area:465} Charred Vale
	["You know the {area:467} flight: it lands closer to {zone:1443} than {area:415} does. From the peak, follow the road south through the mountains to the {area:465}."] = "Вам известен маршрут полета в {area:467}: он ближе к зоне {zone:1443}, чем {area:415}. От пика идите по дороге на юг через горы до места {area:465}.",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "Распорядитель полетов: {area:442}",

	-- Step 28: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "Летите сюда: {area:415}",

	-- Step 29: Fly to Astranaar
	-- {area:415} Astranaar · {quest:1738} Heartswood
	["Warlocks fly to {area:415} for the {quest:1738}, on the way west."] = "Чернокнижники летят в {area:415} за заданием «{quest:1738}» по пути на запад.",

	-- Step 30: Heartswood
	-- {area:415} Astranaar · {quest:1738} Heartswood · {area:413} Maestra's Post · {quest:65602} What Is Love? · {item:190309} Wooden Figurine
	["From {area:415} head north-west into the hills: the {quest:1738} is a glowing tree north of the road to {area:413}. If you took {quest:65602}, the {item:190309} lies in a house among the trees north of {area:413} (26.6,22.0). Then take the road west to Stonetalon."] = "",
	-- {item:190309} Wooden Figurine · {area:413} Maestra's Post
	["{item:190309}, north of {area:413}"] = "{item:190309}, к северу (ориентир: {area:413})",

	-- Step 31: Stonetalon Mountains
	-- {area:608} Nijel's Point
	["The road to {area:608}"] = "Дорога: {area:608}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Bloodscalp trolls"] = "Тролли из племени Кровавого Скальпа",
	-- ["Down to {area:35}"] = "Вниз: {area:35}",
	-- ["East of Zul'Kunda"] = "К востоку от Зул'Кунды",
	-- ["Fly from {area:150} to {area:1537} and train."] = "Летите в {area:1537} (вылет: {area:150}) и обучитесь.",
	-- ["Fly to {area:42}: {npc:1573} in {area:1537}'s {object:32372}, or {npc:352} in {zone:1453}'s {object:2096}."] = "Летите в поселок {area:42}: {npc:1573} ({area:1537}, {object:32372}) или {npc:352} ({zone:1453}, {object:2096}).",
	-- ["Follow the main road south the length of the jungle, past the {object:3202} turn-off, to {area:35} on the southern cape."] = "Идите по главной дороге на юг через все джунгли, мимо поворота на {object:3202}, до южного мыса: {area:35}.",
	-- ["Follow the main road south the length of the jungle, past the {object:3202} turn-off, to {area:35} on the southern cape. Bind your hearthstone at the inn: it is your way back here from Nesingwary's camp at the end of the jungle loop."] = "Идите по главной дороге на юг через все джунгли, мимо поворота на {object:3202}, до южного мыса: {area:35}. Привяжите камень возвращения в таверне: так вы вернетесь сюда из лагеря Несингвари в конце круга по джунглям.",
	-- ["Follow the west coast north; the haunted island lies off the shore west of Nesingwary's camp. Just reach it."] = "Идите вдоль западного побережья на север; остров духов лежит у берега к западу от лагеря Эрнестуэя. Достаточно добраться до него.",
	-- ["For Archmage Ansirem in {zone:1416}"] = "Для верховного мага Ансарема (зона {zone:1416})",
	-- ["From {area:108} the way leads south out of {zone:1436} into Stranglethorn's north-west, to the {area:310} near the coast; the Crystal Spine Basilisks around it drop the shards.\nThe haunted island lies just off the coast south-west of the mine: just reach its edge. Careful: its Lesser Water Elementals are 36-37: don't stay. The Bloodscalp ruins of Zul'Kunda to the north wait for the second Stranglethorn loop."] = "От места {area:108} путь ведет на юг из зоны {zone:1436} в северо-запад Тернистой долины, к месту {area:310} у побережья; хрустальные василиски вокруг него роняют осколки.\nОстров с призраками лежит у побережья к юго-западу от рудника: достаточно добраться до его края. Осторожно: младшие элементали воды там 36-37 уровня – не задерживайтесь. Руины Кровавого Скальпа Зул'Кунда к северу ждут второго круга по Тернистой долине.",
	-- ["From {zone:1431} take the road south into Stranglethorn; the hunters' tents stand just west of the road past the {area:99} turn-off."] = "Из зоны {zone:1431} идите по дороге на юг в Тернистую долину; палатки охотников стоят сразу к западу от дороги, за поворотом к лагерю ({area:99}).",
	-- ["Gluggle, a rare murloc on the coast west of camp, drops the {item:4614}: take it if you meet him"] = "Барабуль, редкий мурлок на побережье к западу от лагеря, роняет предмет {item:4614}: заберите его, если встретите",
	-- ["Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave. Pick up Green Hills pages as they drop."] = "Охотники за головами Курцена стоят в глубине лагеря; коммандо Курцена прячутся в незаметности вокруг него и в пещере. Подбирайте выпавшие страницы «Зеленых холмов».",
	-- ["Herod's records lie in a hut on the compound's west side; his strongbox sits farther east, by the cave mouth."] = "Записи Герода лежат в хижине на западной стороне лагеря; его сундук стоит дальше на востоке, у входа в пещеру.",
	-- ["Loop through the troll ruins of the north and centre: each holds one stone tablet of the troll legends. Shadowmaw Panthers prowl stealthed in the jungle around them; the Venture Co. camp on {area:37} carries the Tumbled Crystals."] = "Обойдите по кругу руины троллей на севере и в центре: в каждых лежит одна каменная табличка с легендами троллей. В джунглях вокруг них в незаметности рыщут тенебрюхие пантеры; упавшие кристаллы носят члены Торговой компании из лагеря у озера ({area:37}).",
	-- ["River Crocolisks swim the river by the {area:99}."] = "Речные кроколиски плавают в реке у места {area:99}.",
	-- ["Skullsplitter trolls"] = "Тролли из племени Дробителей Черепов",
	-- ["Snapjaw Crocolisks"] = "Кроколиски-хрустогрызы",
	-- ["Snapjaw Crocolisks bask on the shore and islands along the coast north of {area:35}."] = "Кроколиски-хрустогрызы греются на берегу и островах вдоль побережья к северу от бухты ({area:35}).",
	-- ["Take the road north; the camp sits in the hills to the west.\n{npc:738} offers {quest:215} only while he is out of the camp: about every half hour he walks down the path to the road, where two Kurzen's Agents ambush him. Help him kill them and take the quest at once, before he walks back up. He isn't there? Leave it: the guide passes {quest:200}, which follows from it, as well."] = "Идите по дороге на север; лагерь – в холмах к западу.\n{npc:738} предлагает задание {quest:215}, только пока находится вне лагеря: примерно раз в полчаса он спускается по тропе к дороге, где на него из засады нападают двое посланников Курцена. Помогите ему убить их и сразу возьмите задание, пока он не ушел обратно наверх. Его там нет? Оставьте задание: гайд пропустит и {quest:200}, которое из него следует.",
	-- ["Take the road north; {npc:738} patrols it, the camp sits in the hills to the west."] = "Идите по дороге на север; {npc:738} патрулирует ее, лагерь – в холмах к западу.",
	-- ["Take the road north; {npc:738} stands on it, the camp sits in the hills to the west."] = "Идите по дороге на север; {npc:738} стоит на ней, лагерь – в холмах к западу.",
	-- ["The Bloodscalp trolls hold the ruins on the coast west of Nesingwary's camp."] = "Тролли из племени Кровавого Скальпа занимают руины на побережье к западу от лагеря Эрнестуэя.",
	-- ["The Skullsplitter trolls hold the ruins east of the road between Nesingwary and {object:3202}."] = "Тролли из племени Дробителей Черепов занимают руины к востоку от дороги между лагерем Эрнестуэя и местом {object:3202}.",
	-- ["The jungle ruins"] = "Руины в джунглях",
	-- ["The ore drops from Drywhisker kobolds in {zone:1417}"] = "Руда падает с кобольдов из племени Сухоусов (зона {zone:1417})",
	-- ["Thorsen patrols the road north of camp, toward the {area:99}."] = "Торсен патрулирует дорогу к северу от лагеря, в сторону места {area:99}.",
	-- ["Walk back north; the {area:310} lies west of the road in the middle of the jungle. The Crystal Spine Basilisks there drop the shards."] = "Идите назад на север; {area:310} – к западу от дороги, в середине джунглей. Осколки падают с хрустальных василисков, которые там водятся.",
	-- ["{area:1537} has no druid trainer: take the {area:2257} from {object:171524} to {zone:1453} and train with {npc:5504}."] = "В городе {area:1537} нет учителя друидов: в районе {object:171524} сядьте на поезд ({area:2257}) до города {zone:1453} и обучитесь у NPC {npc:5504}.",
	-- ["{npc:2859}, on the top floor by the docks"] = "{npc:2859} – на верхнем этаже у причалов",
	-- ["{npc:729} and the Lashtail raptors"] = "{npc:729} и ящеры-кнутохвосты",
	-- ["{npc:729}, the great tiger, lairs on the hilltop south-west of the camp; Lashtail Raptors run south of it, along the way to {area:35}."] = "{npc:729}, огромный тигр, живет на вершине холма к юго-западу от лагеря; ящеры-кнутохвосты бегают к югу от него, по пути в {area:35}.",
	-- ["{npc:773}, in the tavern; upstairs"] = "{npc:773} – в таверне; наверху",
	-- ["{quest:207}: four troll legends"] = "{quest:207}: четыре легенды троллей",
}
