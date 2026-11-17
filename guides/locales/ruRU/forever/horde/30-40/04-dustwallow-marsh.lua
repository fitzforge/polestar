-- Russian (ruRU): the guide forever/horde/30-40/04-dustwallow-marsh (forever/horde/30-40/04-dustwallow-marsh.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Дирижабль: {zone:1454}",

	-- Step 2: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "",

	-- Step 3: Orgrimmar
	-- {item:3713} Soothing Spices
	["{item:3713}, for \"Swamp Eye\" Jarl"] = "{item:3713}: для Ярла «Болотного Глаза»",
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {area:720} Fray Island
	["{npc:3354}, {object:172958}: for {area:720}, later in this guide (offered from level 30)"] = "",

	-- Step 4: Fly to the Crossroads
	["Fly to the Crossroads"] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Распорядитель полетов: {zone:1454}",

	-- Step 5: Korran
	-- {npc:3428} Korran
	["{npc:3428} stands beside the Crossroads flight master."] = "",
	-- {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["for {npc:4485} in {zone:1454}, at the end of this guide"] = "",

	-- Step 6: Fly to Camp Taurajo
	-- {area:378} Camp Taurajo
	["Fly to {area:378}"] = "Летите сюда: {area:378}",
	["Crossroads flight master"] = "Распорядитель полетов на Перекрестке",

	-- Step 8: Shady Rest Inn
	-- {area:378} Camp Taurajo · {area:403} Shady Rest Inn
	["Head east from {area:378} along the road into the marsh. The burned-out {area:403} stands beside it just past the border; the shield, the badge and the hoofprints are in and beside the ruin."] = "Идите на восток от места {area:378} по дороге в болото. Сгоревшее здание ({area:403}) стоит у дороги сразу за границей; щит, бляха и следы копыт – в руинах и рядом с ними.",

	-- Step 10: Brackenwall Village
	["Take the road north at the fork to the ogre village of Brackenwall."] = "На развилке сверните на север к деревне огров Гиблотопь.",
	-- {npc:4503} Mudcrush Durtfeet
	["{npc:4503}, at the south edge of the village where the road comes in"] = "{npc:4503}, на южном краю деревни, у въезда",

	-- Step 11: Stinky Ignatz
	["Stinky Ignatz"] = "«Вонючка» Игнац",
	-- {area:502} Witch Hill
	["Head north to {area:502}. Stinky stands at the foot of the hill; escort him while he gathers Bogbean Leaves just south of it."] = "Идите на север сюда: {area:502}. Вонючка стоит у подножия холма; охраняйте его, пока он собирает листья чуть к югу.",

	-- Step 12: Mirefin murlocs
	["Mirefin murlocs"] = "Мурлоки Болотного Плавника",
	-- {area:502} Witch Hill
	["The Mirefin murlocs crowd the coast east and north-east of {area:502}; every kind drops heads."] = "Мурлоки племени Болотного Плавника толпятся на побережье к востоку и северо-востоку от места {area:502}; головы падают со всех видов.",

	-- Step 13: Swamp Eye Jarl
	["Swamp Eye Jarl"] = "Ярл «Болотный Глаз»",
	-- {area:497} Swamplight Manor · {area:502} Witch Hill
	["Jarl lives in the {area:497} south-east of {area:502}."] = "Ярл живет здесь: {area:497}, к юго-востоку от места {area:502}.",
	-- {object:20985} Loose Dirt
	["{object:20985}, beside the manor"] = "{object:20985}, у усадьбы",
	-- {quest:1218} Soothing Spices · {zone:1454} Orgrimmar
	["{quest:1218}, if you did not buy them in {zone:1454}"] = "",

	-- Step 14: Brackenwall Village: kill these as you meet them
	-- {area:496} Brackenwall Village
	["{area:496}: kill these as you meet them"] = "",
	-- plural, as words: Darkfang Lurkers = {npc:4411} Darkfang Lurker · Theramore Infiltrators = {npc:4834} Theramore Infiltrator · Darkmist Lurkers = {npc:4377} Darkmist Lurker
	["Head west back across the marsh. The Darkfang Lurkers (36-37) and Venomspitters (37-38) on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely.\nThe Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes. Work its outer edge, where the Spiders and Recluses (35-37) stand: the Lurkers and Silkspinners (37-39) deeper in are two or three over you.\nCareful: Darkfang Lurkers (level 36-37) use Sneak to stealth while out of combat and cast Poison once fighting.\nCareful: Stealthed spiders in the same area will attack you on sight.\nCareful: Darkmist Lurkers move about stealthed and use poison once in combat. The spiders stand close together, so adds are common; pulling single targets from the outer edge cuts down on them."] = "Возвращайтесь на запад через болото. Скрытни-темножвалы (36-37) и плюющиеся ядом (37-38) на гребнях к северу от Гиблотопи роняют ядовитые железы. Тераморские секретные агенты (35-36) крадутся по тем же лесам: они в незаметности, так что смотрите внимательно.\nПауки Мглистой пещеры кишат у входа в пещеру к северо-западу от Гиблотопи; глаза падают со всех видов. Действуйте по внешнему краю, где стоят пауки и затворники (35-37): паучата и шелкопряды (37-39) глубже на два-три уровня выше вас.\nОсторожно: скрытни-темножвалы (36-37 уровня) вне боя используют Незаметность, а в бою применяют яд.\nОсторожно: пауки в незаметности в этой же местности нападают, едва заметив вас.\nОсторожно: паучата Мглистой пещеры передвигаются незаметно и в бою применяют яд. Пауки стоят плотно, поэтому лишние враги часто присоединяются; выманивание одиночных целей с внешнего края уменьшает их число.",
	-- plural, as words: Giant Darkfang Spiders = {npc:4415} Giant Darkfang Spider
	["Every Darkfang spider drops them: Lurkers, Spiders, Venomspitters and the Giant Darkfang Spiders"] = "",

	-- Step 16: Questioning Reethe
	-- {npc:4983} Ogron · {area:2302} Quagmire · {npc:5045} Private Hallan
	-- plural, as words: Theramore Skirmishers = {npc:5044} Theramore Skirmisher
	["On the way east, {npc:4983} waits in the {area:2302} east of the village. Follow him to Reethe and keep him alive through the fight that breaks out: {npc:5045} and Theramore Skirmishers (36) join it."] = "По пути на восток {npc:4983} ждет здесь: {area:2302}, к востоку от деревни. Следуйте за ним к Риту и не дайте ему погибнуть в завязавшемся бою: к нему присоединятся {npc:5045} и тераморские рыскатели (36).",

	-- Step 17: Swamp Eye Jarl
	-- {area:497} Swamplight Manor
	["On east to the {area:497}."] = "Дальше на восток сюда: {area:497}.",
	-- {object:20985} Loose Dirt · {npc:4791} Nazeer Bloodpike
	["{object:20985}, now that {npc:4791} has read the report"] = "{object:20985}, теперь, когда {npc:4791} прочел донесение",
	-- {item:3853} Moonsteel Broadsword · {skill:164} Blacksmithing
	["only if you carry a {item:3853} ({skill:164} or the Auction House)"] = "только если у вас есть {item:3853} ({skill:164} или аукцион)",

	-- Step 18: The Theramore Docks
	-- {area:513} Theramore Isle · {object:20925} Captain's Footlocker
	-- plural, as words: Young Murk Threshers = {npc:4388} Young Murk Thresher
	["South-east from the manor to {area:513}: the {object:20925} lies on the sea floor off the docks on the isle's east side. Swim in and out and keep off the piers and the town: Theramore's guards are level 53-57, and a death here is a long run back from the spirit healer. Young Murk Threshers (40-41) circle in the water around the docks: grab the footlocker and swim straight out."] = "На юго-восток от поместья к месту {area:513}: {object:20925} лежит на морском дне у причалов на восточной стороне острова. Подплывайте и уплывайте, держитесь подальше от пирсов и городка: стражники Терамора 53-57 уровня, а после смерти здесь придется долго бежать обратно от целителя душ. Вокруг причалов в воде кружат молодые черные крепкозубы (40-41): хватайте сундучок и сразу уплывайте.",
	["Underwater"] = "Под водой",

	-- Step 19: Brackenwall Village
	-- {npc:4503} Mudcrush Durtfeet · {npc:4791} Nazeer Bloodpike · {npc:4926} Krog
	["Head back west to Brackenwall with the head: {npc:4503} stands at the south edge of the village where the road comes in, {npc:4791} and {npc:4926} in the village."] = "Возвращайтесь с головой на запад в Гиблотопь: {npc:4503} стоит на южном краю деревни, у въезда, {npc:4791} и {npc:4926} – в деревне.",
	-- {npc:2519} Kin'weelay · {object:3202} Grom'gol
	["For {npc:2519} at {object:3202}, in forever/horde/40-50/01-stranglethorn-vale"] = "",

	-- Step 20: Level 36
	["Level 36"] = "",
	-- {zone:1443} Desolace
	-- plural, as words: Drywallow Crocolisks = {npc:4341} Drywallow Crocolisk
	["{zone:1443}'s last quests are 36-39. Still below 36 after Brackenwall's hand-ins? The Drywallow Crocolisks (35-36) along the river east of the village are the closest at your level: kill them until level 36."] = "Последние задания в зоне {zone:1443} 36-39 уровня. Все еще ниже 36 после сдачи заданий в Гиблотопи? Ближайшие по уровню – кроколиски-грязекупы (35-36) вдоль реки к востоку от деревни: убивайте их до 36 уровня.",
	-- plural, as words: Drywallow Crocolisks = {npc:4341} Drywallow Crocolisk
	["Drywallow Crocolisks"] = "Кроколиски-грязекупы",
	-- {npc:4341} Drywallow Crocolisk
	["grind on {npc:4341}"] = "убивайте: {npc:4341}",

	-- Step 21: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "",
	-- {area:496} Brackenwall Village
	["{area:496} flight master"] = "",

	-- Step 22: Ratchet
	-- {npc:3446} Mebok Mizzyrix
	["{npc:3446} stands below Gazlowe's house by the flight master, towards the docks."] = "{npc:3446} стоит под домом Газлоу, у распорядителя полетов, ближе к причалам.",

	-- Step 23: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["Head south along the coast from {area:392} to {area:720}. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "",

	-- Step 24: Ratchet flight master
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",
	-- {area:392} Ratchet
	["Back north along the coast to {area:392}'s flight master."] = "Обратно на север вдоль побережья к распорядителю полетов: {area:392}.",

	-- Step 25: Fly to Shadowprey Village
	-- {area:2408} Shadowprey Village
	["Fly to {area:2408}"] = "",
	-- {area:2408} Shadowprey Village · {area:392} Ratchet
	["Fly to {area:2408} from the flight master you are next to: {area:392}'s, or Brackenwall's if you had no errand in {area:392}."] = "Летите сюда: {area:2408}, от ближайшего распорядителя полетов: {area:392} или Гиблотопь, если в месте {area:392} у вас не было дел.",

	-- Step 26: Shadowprey Village
	-- {npc:11624} Taiga Wisemane · {npc:12340} Drulzegar Skraghook
	["{npc:11624} and {npc:12340} stand in the village."] = "{npc:11624} и {npc:12340} стоят в деревне.",
	-- {npc:11624} Taiga Wisemane · {quest:5381} Hand of Iruxos · {area:599} Thunder Axe Fortress
	["{npc:11624}: the {quest:5381}, at {area:599} later on this visit"] = "{npc:11624}: «{quest:5381}», в месте {area:599} позже в этот визит",
	-- {npc:12340} Drulzegar Skraghook · {area:599} Thunder Axe Fortress
	["{npc:12340}: the Slitherblade of Sar'theris Strand, on the way back from {area:599}"] = "{npc:12340}: Скользящие Плавники с Берега Сар'терис, на обратном пути из места {area:599}",

	-- Step 27: Ghost Walker Post
	-- {area:597} Ghost Walker Post · {npc:5412} Gurda Wildmane · {npc:5395} Felgur Twocuts
	["East along the road to {area:597}; {npc:5412} stands beside {npc:5395}."] = "Идите на восток по дороге сюда: {area:597}; {npc:5412} стоит рядом с NPC {npc:5395}.",
	-- {npc:5395} Felgur Twocuts · {quest:1366} Centaur Bounty
	["{npc:5395}: his {quest:1366}, from the same Maraudine as Gurda's totems"] = "{npc:5395}: его задание {quest:1366}, с тех же кентавров Мародин, что и тотемы для Гурды",

	-- Step 28: Valley of Spears
	-- {area:607} Valley of Spears · {item:254432} Carved Centaur Totem · {npc:5395} Felgur Twocuts · {quest:1366} Centaur Bounty · {npc:5402} Khan Hratha
	-- plural, as words: Rock Worms = {npc:11788} Rock Worm
	["West of the post, the Maraudine centaurs hold the {area:607}; every Maraudine can drop a {item:254432} and an ear for {npc:5395}'s {quest:1366}. Stay with the Scouts and Wranglers (36-38) at the valley's eastern edge; the Maulers and Windchasers (38-39) a little further in are up to two over you at 37: pull them one at a time.\nCareful: {npc:5402} and the Rock Worms (41-42, elite) hold the valley's north-western end with the Khan Guards and Marauders (39-40), and the Magram's village in the south-east has Necromancers (42-43): keep east of the arrow."] = "К западу от лагеря кентавры Мародин занимают это место: {area:607}; с любого Мародин может выпасть {item:254432} и ухо для задания {quest:1366} (дает {npc:5395}). Держитесь разведчиков и укротителей (36-38) у восточного края долины; громилы и ловцы ветра (38-39) чуть дальше – до двух уровней выше вас на 37-м: выманивайте по одному.\nОсторожно: {npc:5402} и каменные черви (41-42, элита) занимают северо-западный конец долины вместе со стражами и мародерами хана (39-40), а в деревне Маграм на юго-востоке есть некроманты (42-43): держитесь восточнее стрелки.",

	-- Step 29: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the Maraudine camp at the valley's western end; free her and escort her out east of the valley.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "",

	-- Step 30: Hornizz Brimbuzzle
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard
	["{npc:6019} waits at the goblin camp on the west side of the {area:596}."] = "{npc:6019} ждет в лагере гоблинов в западной части места {area:596}.",
	-- {npc:6019} Hornizz Brimbuzzle · {area:602} Mannoroc Coven
	["{npc:6019}: the ghost-o-plasm, after {area:602} at the end of this visit"] = "{npc:6019}: эктоплазма, после места {area:602} в конце этого визита",

	-- Step 32: Thunder Axe Fortress
	-- {area:599} Thunder Axe Fortress · {item:14523} Demon Pick · {object:176581} Hand of Iruxos Crystal · {npc:11876} Demon Spirit · {item:13542} Demon Box
	["North up the road to {area:599}. Clear the middle of the largest building, then use the {item:14523} on the red {object:176581} there. A {npc:11876} (37) comes out: kill it for the {item:13542}. The Burning Blade around it are well under you now."] = "Идите на север по дороге сюда: {area:599}. Зачистите середину самого большого здания, затем используйте {item:14523} на красном объекте {object:176581}. Появится {npc:11876} (37): убейте его ради предмета {item:13542}. Пылающий Клинок вокруг теперь намного ниже вас.",
	-- {item:14523} Demon Pick · {object:176581} Hand of Iruxos Crystal
	["{item:14523}, on the {object:176581}"] = "",

	-- Step 33: Sar'theris Strand
	-- {area:598} Sar'theris Strand
	-- plural, as words: Slitherblade Myrmidons = {npc:4714} Slitherblade Myrmidon
	["West from the fortress to the coast at {area:598}: the Slitherblade Myrmidons, Naga and Sorceresses hold the beach. Pull them one at a time; the Sea Witches and Oracles (34-36) cast from range."] = "Идите на запад от крепости к побережью ({area:598}): мирмидоны, наги и колдуньи из клана Скользящего Плавника занимают пляж. Выманивайте по одному; морские ведьмы и оракулы (34-36) атакуют издалека.",

	-- Step 34: Shadowprey Village
	-- {npc:11624} Taiga Wisemane · {area:602} Mannoroc Coven · {npc:12340} Drulzegar Skraghook
	["South down the coast to Shadowprey: {npc:11624} takes the box and sends you to {area:602} with it; {npc:12340} takes the naga."] = "Идите на юг по побережью в Деревню Ночных Охотников: {npc:11624} берет шкатулку и отправляет вас с ней сюда: {area:602}; {npc:12340} принимает наг.",

	-- Step 35: Portals of the Legion
	-- {area:602} Mannoroc Coven · {quest:5381} Hand of Iruxos · {npc:11624} Taiga Wisemane · {npc:11937} Demon Portal Guardian
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["Head east to {area:602}. With the {quest:5381} from {npc:11624} in your bags, open a demon portal's ring: a {npc:11937} (38-39) comes out; kill it to close that portal. Six portals. Careful: Infernals, Doomguards and Burning Blade Summoners walk close by many portals and may join in; kill nearby mobs first or drag the guardian away, for example toward the coven's central lake."] = "",

	-- Step 36: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- {area:2657} Valley of Bones · {zone:1443} Desolace · {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magram Necrokhans = {npc:253274} Magram Necrokhan
	["South-east of the coven, the bone fields of the {area:2657}, where Undead Ravagers roam, at {zone:1443}'s southern edge: keep south of the Magram's village on the way. Use the {item:15848} at the arrow to draw the Magrami Spectres (38-39): they come in numbers, so fight them with your back to the valley's edge. They drop the ghost-o-plasm.\nCareful: Magram Necrokhans and Corpsefeeders (45, elite) walk the bone fields just west of the arrow, well above you: use the crate at the arrow, on the valley's eastern side, and pull the spectres away from them."] = "К юго-востоку от ковена – костяные поля ({area:2657}), где бродят опустошители-отрекшиеся, на южном краю зоны {zone:1443}: по пути держитесь южнее деревни Маграм. Используйте {item:15848} у стрелки, чтобы приманить призраков Маграми (38-39): они приходят толпой, так что сражайтесь спиной к краю долины. С них падает эктоплазма.\nОсторожно: некроханы и трупоеды Маграм (45, элита) ходят по костяным полям чуть западнее стрелки, намного выше вас: используйте ящик у стрелки, на восточной стороне долины, и уводите призраков от них.",

	-- Step 37: Hornizz Brimbuzzle
	-- {area:596} Kodo Graveyard · {area:602} Mannoroc Coven
	["North-west to the goblin camp on the west side of the {area:596}, back past {area:602}: keep west of the Magram's village."] = "На северо-запад к лагерю гоблинов в западной части места {area:596}, обратно мимо места {area:602}: держитесь западнее деревни Маграм.",

	-- Step 38: Shadowprey
	["Shadowprey"] = "",
	["Hearth to Shadowprey: your hearthstone is still bound there."] = "Используйте Камень возвращения в Деревню Ночных Охотников: он все еще привязан там.",

	-- Step 39: Thunder Bluff
	-- {area:2408} Shadowprey Village · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly from {area:2408} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to {zone:1454} from there."] = "",

	-- Step 40: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "Распорядитель полетов: {area:2408}",

	-- Step 41: Back to Orgrimmar
	-- {area:1637} Orgrimmar
	["Back to {area:1637}"] = "",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 42: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["{npc:4485} stands in the {object:172958}."] = "",

	-- Step 43: Nogg
	-- {npc:3412} Nogg · {object:172958} Valley of Honor · {npc:4485} Belgrom Rockmaul · {quest:2841} Rig Wars · {area:133} Gnomeregan
	["{npc:3412}'s workshop is in the {object:172958} beside {npc:4485}: hand in {quest:2841} if you ran {area:133}."] = "",

	-- Step 44: Orgrimmar trainers
	-- {zone:1454} Orgrimmar
	["{zone:1454} trainers"] = "",
	-- {zone:1458} Undercity
	["Train while you are in the city; everyone else trains in the {zone:1458}, next."] = "",
	-- {zone:1458} Undercity
	["The next guide takes the {zone:1458} zeppelin from the tower outside the main gate."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Darkfang spiders"] = "Пауки-темножвалы",
	-- ["For {npc:2519} at {object:3202}, in the next guide"] = "Для персонажа {npc:2519} ({object:3202}), в следующем руководстве",
	-- ["Head back west to Brackenwall with the head: {npc:4503} stands at the south edge of the village where the road comes in, {npc:4791} in the village."] = "Возвращайтесь с головой на запад в Гиблотопь: {npc:4503} стоит на южном краю деревни, у въезда, {npc:4791} – в деревне.",
	-- ["Head east back to the {area:497}."] = "Возвращайтесь на восток сюда: {area:497}.",
	-- ["Hearth to {area:392}"] = "Камень возвращения: {area:392}",
	-- ["Kodo bones and ghosts"] = "Кости кодо и призраки",
	-- ["Maraudine totems"] = "Тотемы Мародин",
	-- ["North to the goblin camp on the west side of the {area:596}."] = "На север к лагерю гоблинов в западной части места {area:596}.",
	-- ["Pick up the kodo bones scattered across the graveyard, and use the {item:15848} among the bones: the ghosts it draws drop the ghost-o-plasm."] = "Собирайте кости кодо по всему кладбищу и используйте предмет {item:15848} среди костей: с призванных призраков падает призракоплазма.",
	-- ["Ride back west to Brackenwall with the head."] = "Возвращайтесь с головой на запад в Гиблотопь.",
	-- ["Ride east to {area:602}. Use the Rod of Banishing by each demon portal to close six of them."] = "Езжайте на восток сюда: {area:602}. Используйте жезл изгнания у порталов демонов, чтобы закрыть шесть из них.",
	-- ["Ride north from the coven to {npc:5412} at {area:597}."] = "Езжайте на север от ковена к персонажу {npc:5412} ({area:597}).",
	-- ["Ride north up the road to the hut by the road north of the graveyard."] = "Езжайте на север по дороге к хижине у дороги к северу от кладбища.",
	-- ["Ride north-east to the {area:607}. {npc:12277} is held in the Maraudine centaur camp; free her and escort her out east of the valley."] = "Езжайте на северо-восток сюда: {area:607}. {npc:12277} в плену в лагере кентавров Мародин; освободите ее и выведите на восток из долины.",
	-- ["Ride on south-west to Shadowprey."] = "Езжайте дальше на юго-запад к Деревне Ночных Охотников.",
	-- ["Ride south from {area:2405} into the {area:607}. The Maraudine Scouts, Wranglers, Maulers, Windchasers and Marauders (36-39) drop the {quest:93225}."] = "Езжайте на юг от места {area:2405} сюда: {area:607}. С разведчиков, пастухов, извергов, ветроловок и мародеров из племени Мародин (36-39) падают тотемы ({quest:93225}).",
	-- ["Ride west back across the marsh. The Darkfang Venomspitters on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely."] = "Возвращайтесь на запад через болото. С ядоплюев-темножвалов на холмах к северу от Гиблотопи падают ядовитые железы. Тераморские секретные агенты (35-36) крадутся в тех же лесах: они незаметны, смотрите внимательно.",
	-- ["Ride west to {npc:11863}'s tower at {area:2405} on the north-west coast."] = "Езжайте на запад к башне ({npc:11863}, {area:2405}) на северо-западном побережье.",
	-- ["Slitherblade coast"] = "Берег Скользящего Плавника",
	-- ["South-east from the manor to {area:513}: the {object:20925} lies on the sea floor off the docks on the isle's east side. Swim in and out and keep off the piers and the town: Theramore's guards are level 53-57, and a death here is a long run back from the spirit healer."] = "На юго-восток от поместья к месту {area:513}: {object:20925} лежит на морском дне у причалов на восточной стороне острова. Подплывайте и уплывайте, держитесь подальше от пирсов и городка: стражники Терамора 53-57 уровня, а после смерти здесь придется долго бежать обратно от целителя душ.",
	-- ["The Burning Blade hold the fortress north-west of {area:2407}. Use the {item:14523} on the {npc:11876} in the fortress to get the {item:13542}."] = "Культисты (Пылающий Клинок) занимают крепость к северо-западу от места {area:2407}. Примените предмет {item:14523} на персонаже {npc:11876} в крепости, чтобы получить {item:13542}.",
	-- ["The Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes."] = "Пауки Мглистой пещеры кишат у входа в пещеру к северо-западу от Гиблотопи; глаза падают со всех видов.",
	-- ["The Slitherblade naga hold the coast north of {area:2405}, up to {area:598}. {npc:12369} guards the {quest:6027} at the far northern tip."] = "Наги клана Скользящего Плавника занимают берег к северу от места {area:2405}, до места {area:598}. {npc:12369} охраняет книгу ({quest:6027}) на северной оконечности.",
	-- ["The next guide takes you back to {zone:1434}."] = "Следующее руководство вернет вас сюда: {zone:1434}.",
	-- ["West to Shadowprey."] = "На запад к Деревне Ночных Охотников.",
	-- ["{npc:11626}'s caravan stops on the road at the edge of {area:602}. Escort it east past the coven; demons attack it twice."] = "Караван ({npc:11626}) останавливается на дороге у края места {area:602}. Сопроводите его на восток мимо ковена; демоны нападут дважды.",
	-- ["{npc:3391}: for {npc:4631} in {area:35}, on the first {area:35} stop of 40-50"] = "{npc:3391}: для персонажа {npc:4631} ({area:35}), при первом заходе сюда ({area:35}) в руководстве 40-50",
	-- ["{npc:4983} waits in the {area:2302} east of the village. Follow him to Reethe and keep him alive through the fight that breaks out."] = "{npc:4983} ждет здесь: {area:2302}, к востоку от деревни. Следуйте за ним к Риту и не дайте ему погибнуть в завязавшемся бою.",
	-- ["{npc:5395} and {npc:5412} stand in the post just west of {npc:11596}'s camp."] = "{npc:5395} и {npc:5412} стоят в лагере чуть к западу от лагеря {npc:11596}.",
	-- ["{npc:5395}: his {quest:1366}, from the same Maraudine"] = "{npc:5395}: его задание {quest:1366}, с тех же кентавров Мародин",
	-- ["{npc:6791}: the last guide binds here, so this usually ticks at once"] = "{npc:6791}: предыдущий гайд привязывает вас здесь, так что это обычно отмечается сразу",
}
