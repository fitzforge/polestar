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

	-- Step 3: Orgrimmar
	-- {item:3713} Soothing Spices
	["{item:3713}, for \"Swamp Eye\" Jarl"] = "{item:3713}: для Ярла «Болотного Глаза»",
	-- {npc:3354} Sorek · {object:172958} Valley of Honor
	["{npc:3354}, {object:172958}: for Fray Island, later in this guide (offered from level 30)"] = "",

	-- Step 4: Fly to the Crossroads
	["Fly to the Crossroads"] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 5: Korran
	-- {npc:3428} Korran
	["{npc:3428} stands beside the Crossroads flight master."] = "",
	-- {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["for {npc:4485} in {zone:1454}, at the end of this guide"] = "",

	-- Step 6: Fly to Camp Taurajo
	["Fly to Camp Taurajo"] = "",
	["Crossroads flight master"] = "",

	-- Step 8: Shady Rest Inn
	-- {object:21077} Shady Rest Inn (no name in this language: may be words)
	["Head east from Camp Taurajo along the road into the marsh. The burned-out {object:21077} stands beside it just past the border; the shield, the badge and the hoofprints are in and beside the ruin."] = "",

	-- Step 10: Brackenwall Village
	["Take the road north at the fork to the ogre village of Brackenwall."] = "На развилке сверните на север к деревне огров Гиблотопь.",
	-- {npc:4503} Mudcrush Durtfeet
	["{npc:4503}, at the south edge of the village where the road comes in"] = "{npc:4503}, на южном краю деревни, у въезда",

	-- Step 11: Questioning Reethe
	-- {npc:4983} Ogron
	["{npc:4983} waits in the Quagmire east of the village. Follow him to Reethe and keep him alive through the fight that breaks out."] = "",

	-- Step 12: Stinky Ignatz
	["Stinky Ignatz"] = "«Вонючка» Игнац",
	["Head north to Witch Hill. Stinky stands at the foot of the hill; escort him while he gathers Bogbean Leaves just south of it."] = "",

	-- Step 13: Mirefin murlocs
	["Mirefin murlocs"] = "Мурлоки Болотного Плавника",
	["The Mirefin murlocs crowd the coast east and north-east of Witch Hill; every kind drops heads."] = "",

	-- Step 14: Swamp Eye Jarl
	["Swamp Eye Jarl"] = "Ярл «Болотный Глаз»",
	["Jarl lives in the Swamplight Manor south-east of Witch Hill."] = "",
	-- {object:20985} Loose Dirt
	["{object:20985}, beside the manor"] = "{object:20985}, у усадьбы",
	-- {quest:1218} Soothing Spices · {zone:1454} Orgrimmar
	["{quest:1218}, if you did not buy them in {zone:1454}"] = "",

	-- Step 15: Brackenwall Village: kill these as you meet them
	-- {object:21082} Brackenwall Village (no name in this language: may be words)
	["{object:21082}: kill these as you meet them"] = "",
	-- plural, as words: Darkfang Venomspitters = {npc:4414} Darkfang Venomspitter · Theramore Infiltrators = {npc:4834} Theramore Infiltrator · Darkfang Lurkers = {npc:4411} Darkfang Lurker · Darkmist Lurkers = {npc:4377} Darkmist Lurker
	["Head west back across the marsh. The Darkfang Venomspitters on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely.\nThe Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes.\nCareful: Darkfang Lurkers (level 36-37) use Sneak to stealth while out of combat and cast Poison once fighting.\nCareful: Stealthed spiders in the same area will attack you on sight.\nCareful: Darkmist Lurkers move about stealthed and use poison once in combat. The spiders stand close together, so adds are common; pulling single targets from the outer edge cuts down on them."] = "",

	-- Step 17: Swamp Eye Jarl
	["Head east back to the Swamplight Manor."] = "",
	-- {object:20985} Loose Dirt · {npc:4791} Nazeer Bloodpike
	["{object:20985}, now that {npc:4791} has read the report"] = "{object:20985}, теперь, когда {npc:4791} прочел донесение",
	-- {item:3853} Moonsteel Broadsword · {skill:164} Blacksmithing
	["only if you carry a {item:3853} ({skill:164} or the Auction House)"] = "только если у вас есть {item:3853} ({skill:164} или аукцион)",

	-- Step 18: The Theramore Docks
	["Underwater"] = "",

	-- Step 19: Level 37.5
	["Level 37.5"] = "",
	-- {zone:1443} Desolace
	["{zone:1443}'s last quests and Alterac are 38-41. Below 37.5? Keep killing the Mirefin murlocs along the north-east coast, past Witch Hill, until level 37.5. Or, with a group, run the Razorfen Downs dungeon or the Scarlet Monastery dungeon (Armory) instead."] = "",
	-- {npc:4362} Mirefin Coastrunner
	["grind on {npc:4362}"] = "",

	-- Step 20: Brackenwall Village
	-- {npc:4503} Mudcrush Durtfeet · {npc:4791} Nazeer Bloodpike
	["Head back west to Brackenwall with the head: {npc:4503} stands at the south edge of the village where the road comes in, {npc:4791} in the village."] = "Возвращайтесь с головой на запад в Гиблотопь: {npc:4503} стоит на южном краю деревни, у въезда, {npc:4791} – в деревне.",
	-- {npc:2519} Kin'weelay · {object:3202} Grom'gol
	["For {npc:2519} at {object:3202}, in forever/horde/40-50/01-stranglethorn-vale"] = "",

	-- Step 21: Fly to Ratchet
	["Fly to Ratchet"] = "",
	-- {object:21082} Brackenwall Village (no name in this language: may be words)
	["{object:21082} flight master"] = "",

	-- Step 22: Ratchet
	["Ratchet"] = "",
	-- {npc:3391} Gazlowe · {npc:3446} Mebok Mizzyrix
	["{npc:3391} waits upstairs in the house by the flight master; {npc:3446} stands below it, towards the docks."] = "",
	-- {npc:3391} Gazlowe · {object:3204} Booty Bay (no name in this language: may be words)
	["{npc:3391}'s next errand takes you to {object:3204}, off this part of the route: leave it."] = "",

	-- Step 23: The Affray
	-- {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["Head south along the coast from Ratchet to Fray Island. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "",
	-- {npc:6236} Klannoc Macleod
	["{npc:6236}: Berserker Stance"] = "",

	-- Step 24: Fly to Shadowprey Village
	-- {object:176946} Shadowprey Village (no name in this language: may be words)
	["Fly to {object:176946}"] = "",
	["Ratchet flight master"] = "",

	-- Step 25: Shadowprey Village
	-- {npc:11624} Taiga Wisemane
	["{npc:11624} stands in the village."] = "",

	-- Step 26: Portals of the Legion
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["Head east to Mannoroc Coven. Use the Rod of Banishing by each demon portal to close six of them.\nCareful: Infernals, Doomguards and Burning Blade Summoners walk close by many portals and may join in; kill nearby mobs first or drag the guardian away, for example toward the coven's central lake."] = "",
	["Mannoroc Coven"] = "",

	-- Step 27: Ghost Walker Post
	-- {npc:5412} Gurda Wildmane · {npc:5395} Felgur Twocuts
	["North to the post; {npc:5412} stands beside {npc:5395}."] = "",

	-- Step 28: Valley of Spears
	["Valley of Spears"] = "",
	-- {item:254432} Carved Centaur Totem · {npc:5395} Felgur Twocuts · {quest:1366} Centaur Bounty
	["West of the post, the Maraudine centaurs hold the Valley of Spears. Every Maraudine can drop a {item:254432} and an ear for {npc:5395}'s {quest:1366}."] = "",

	-- Step 29: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the Maraudine camp at the valley's western end; free her and escort her out east of the valley.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "",

	-- Step 30: Hornizz Brimbuzzle
	-- {npc:6019} Hornizz Brimbuzzle
	["{npc:6019} waits at the goblin camp on the west side of the Kodo Graveyard."] = "",

	-- Step 31: The Valley of Bones
	["The Valley of Bones"] = "",
	-- {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magrami Spectres = {npc:11560} Magrami Spectre
	["Head south-east to the bone fields of the Valley of Bones, where Undead Ravagers roam. At the far south-east, use the {item:15848} to draw the Magrami Spectres: they drop the ghost-o-plasm."] = "",

	-- Step 32: Hornizz Brimbuzzle
	["North to the goblin camp on the west side of the Kodo Graveyard."] = "",

	-- Step 34: Shadowprey
	["Shadowprey"] = "",
	["West to Shadowprey."] = "",

	-- Step 35: Thunder Bluff
	-- {object:176946} Shadowprey Village (no name in this language: may be words) · {zone:1456} Thunder Bluff · {npc:3033} Turak Runetotem · {object:50507} Elder Rise (no name in this language: may be words) · {zone:1454} Orgrimmar
	["Fly from {object:176946} to {zone:1456} and train with {npc:3033} on {object:50507}; fly on to {zone:1454} from there."] = "",

	-- Step 36: Fly to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Fly to {zone:1454}"] = "",
	-- {object:176946} Shadowprey Village (no name in this language: may be words)
	["{object:176946} flight master"] = "",

	-- Step 37: Back to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Back to {zone:1454}"] = "",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 38: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["{npc:4485} stands in the {object:172958}."] = "",
	-- {npc:3412} Nogg · {object:172958} Valley of Honor · {npc:4485} Belgrom Rockmaul · {quest:2841} Rig Wars
	["{npc:3412}, in the {object:172958} beside {npc:4485}: {quest:2841}, if you ran Gnomeregan"] = "",

	-- Step 39: Orgrimmar trainers
	-- {zone:1454} Orgrimmar
	["{zone:1454} trainers"] = "",
	-- {zone:1458} Undercity
	["Train while you are in the city; everyone else trains in the {zone:1458}, next."] = "",
	-- {zone:1458} Undercity
	["The next guide takes the {zone:1458} zeppelin from the tower outside the main gate."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Darkfang spiders"] = "Пауки-темножвалы",
	-- ["Fly to {area:378}"] = "Летите сюда: {area:378}",
	-- ["For {npc:2519} at {object:3202}, in the next guide"] = "Для персонажа {npc:2519} ({object:3202}), в следующем руководстве",
	-- ["Hearth to Shadowprey"] = "Камень возвращения: Деревня Ночных Охотников",
	-- ["Hearth to {area:392}"] = "Камень возвращения: {area:392}",
	-- ["Jarl lives in the {area:497} south-east of {area:502}."] = "Ярл живет здесь: {area:497}, к юго-востоку от места {area:502}.",
	-- ["Kodo bones and ghosts"] = "Кости кодо и призраки",
	-- ["Maraudine totems"] = "Тотемы Мародин",
	-- ["Pick up the kodo bones scattered across the graveyard, and use the {item:15848} among the bones: the ghosts it draws drop the ghost-o-plasm."] = "Собирайте кости кодо по всему кладбищу и используйте предмет {item:15848} среди костей: с призванных призраков падает призракоплазма.",
	-- ["Ride back west to Brackenwall with the head."] = "Возвращайтесь с головой на запад в Гиблотопь.",
	-- ["Ride east back to the {area:497}."] = "Возвращайтесь на восток сюда: {area:497}.",
	-- ["Ride east from {area:378} along the road into the marsh. The burned-out {area:403} stands beside it just past the border; the shield, the badge and the hoofprints are in and beside the ruin."] = "Езжайте на восток от места {area:378} по дороге в болото. Сгоревшее здание ({area:403}) стоит у дороги сразу за границей; щит, бляха и следы копыт – в руинах и рядом с ними.",
	-- ["Ride east to {area:602}. Use the Rod of Banishing by each demon portal to close six of them."] = "Езжайте на восток сюда: {area:602}. Используйте жезл изгнания у порталов демонов, чтобы закрыть шесть из них.",
	-- ["Ride north from the coven to {npc:5412} at {area:597}."] = "Езжайте на север от ковена к персонажу {npc:5412} ({area:597}).",
	-- ["Ride north to {area:502}. Stinky stands at the foot of the hill; escort him while he gathers Bogbean Leaves just south of it."] = "Езжайте на север сюда: {area:502}. Вонючка стоит у подножия холма; охраняйте его, пока он собирает листья чуть к югу.",
	-- ["Ride north up the road to the hut by the road north of the graveyard."] = "Езжайте на север по дороге к хижине у дороги к северу от кладбища.",
	-- ["Ride north-east to the {area:607}. {npc:12277} is held in the Maraudine centaur camp; free her and escort her out east of the valley."] = "Езжайте на северо-восток сюда: {area:607}. {npc:12277} в плену в лагере кентавров Мародин; освободите ее и выведите на восток из долины.",
	-- ["Ride on south-west to Shadowprey."] = "Езжайте дальше на юго-запад к Деревне Ночных Охотников.",
	-- ["Ride south from {area:2405} into the {area:607}. The Maraudine Scouts, Wranglers, Maulers, Windchasers and Marauders (36-39) drop the {quest:93225}."] = "Езжайте на юг от места {area:2405} сюда: {area:607}. С разведчиков, пастухов, извергов, ветроловок и мародеров из племени Мародин (36-39) падают тотемы ({quest:93225}).",
	-- ["Ride west back across the marsh. The Darkfang Venomspitters on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely."] = "Возвращайтесь на запад через болото. С ядоплюев-темножвалов на холмах к северу от Гиблотопи падают ядовитые железы. Тераморские секретные агенты (35-36) крадутся в тех же лесах: они незаметны, смотрите внимательно.",
	-- ["Ride west to {npc:11863}'s tower at {area:2405} on the north-west coast."] = "Езжайте на запад к башне ({npc:11863}, {area:2405}) на северо-западном побережье.",
	-- ["Slitherblade coast"] = "Берег Скользящего Плавника",
	-- ["The Burning Blade hold the fortress north-west of {area:2407}. Use the {item:14523} on the {npc:11876} in the fortress to get the {item:13542}."] = "Культисты (Пылающий Клинок) занимают крепость к северо-западу от места {area:2407}. Примените предмет {item:14523} на персонаже {npc:11876} в крепости, чтобы получить {item:13542}.",
	-- ["The Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes."] = "Пауки Мглистой пещеры кишат у входа в пещеру к северо-западу от Гиблотопи; глаза падают со всех видов.",
	-- ["The Mirefin murlocs crowd the coast east and north-east of {area:502}; every kind drops heads."] = "Мурлоки племени Болотного Плавника толпятся на побережье к востоку и северо-востоку от места {area:502}; головы падают со всех видов.",
	-- ["The Slitherblade naga hold the coast north of {area:2405}, up to {area:598}. {npc:12369} guards the {quest:6027} at the far northern tip."] = "Наги клана Скользящего Плавника занимают берег к северу от места {area:2405}, до места {area:598}. {npc:12369} охраняет книгу ({quest:6027}) на северной оконечности.",
	-- ["The caravan ends at {npc:11596}'s camp on the east side of the {area:596}."] = "Караван заканчивает путь у лагеря {npc:11596} в восточной части места {area:596}.",
	-- ["The next guide takes you back to {zone:1434}."] = "Следующее руководство вернет вас сюда: {zone:1434}.",
	-- ["{npc:11626}'s caravan stops on the road at the edge of {area:602}. Escort it east past the coven; demons attack it twice."] = "Караван ({npc:11626}) останавливается на дороге у края места {area:602}. Сопроводите его на восток мимо ковена; демоны нападут дважды.",
	-- ["{npc:4983} waits in the {area:2302} east of the village. Follow him to Reethe and keep him alive through the fight that breaks out."] = "{npc:4983} ждет здесь: {area:2302}, к востоку от деревни. Следуйте за ним к Риту и не дайте ему погибнуть в завязавшемся бою.",
	-- ["{npc:5395} and {npc:5412} stand in the post just west of {npc:11596}'s camp."] = "{npc:5395} и {npc:5412} стоят в лагере чуть к западу от лагеря {npc:11596}.",
	-- ["{npc:6019} waits at the goblin camp on the west side of the {area:596}."] = "{npc:6019} ждет в лагере гоблинов в западной части места {area:596}.",
	-- ["{npc:6791}: the last guide binds here, so this usually ticks at once"] = "{npc:6791}: предыдущий гайд привязывает вас здесь, так что это обычно отмечается сразу",
}
