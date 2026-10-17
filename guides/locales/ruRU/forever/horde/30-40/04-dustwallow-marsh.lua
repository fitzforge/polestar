-- Russian (ruRU): the guide forever/horde/30-40/04-dustwallow-marsh (forever/horde/30-40/04-dustwallow-marsh.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Camp Taurajo
	-- {area:378} Camp Taurajo
	["Fly to {area:378}"] = "Летите сюда: {area:378}",
	-- {npc:6791} Innkeeper Wiley
	["{npc:6791}: the last guide binds here, so this usually ticks at once"] = "{npc:6791}: предыдущий гайд привязывает вас здесь, так что это обычно отмечается сразу",

	-- Step 2: Shady Rest Inn
	-- {area:378} Camp Taurajo · {area:403} Shady Rest Inn
	["Ride east from {area:378} along the road into the marsh. The burned-out {area:403} stands beside it just past the border; the shield, the badge and the hoofprints are in and beside the ruin."] = "Езжайте на восток от места {area:378} по дороге в болото. Сгоревшее здание ({area:403}) стоит у дороги сразу за границей; щит, бляха и следы копыт – в руинах и рядом с ними.",

	-- Step 3: Brackenwall Village
	["Take the road north at the fork to the ogre village of Brackenwall."] = "На развилке сверните на север к деревне огров Гиблотопь.",
	-- {npc:4503} Mudcrush Durtfeet
	["{npc:4503}, at the south edge of the village where the road comes in"] = "{npc:4503}, на южном краю деревни, у въезда",

	-- Step 4: Questioning Reethe
	-- {npc:4983} Ogron · {area:2302} Quagmire
	["{npc:4983} waits in the {area:2302} east of the village. Follow him to Reethe and keep him alive through the fight that breaks out."] = "{npc:4983} ждет здесь: {area:2302}, к востоку от деревни. Следуйте за ним к Риту и не дайте ему погибнуть в завязавшемся бою.",

	-- Step 5: Stinky Ignatz
	["Stinky Ignatz"] = "«Вонючка» Игнац",
	-- {area:502} Witch Hill
	["Ride north to {area:502}. Stinky stands at the foot of the hill; escort him while he gathers Bogbean Leaves just south of it."] = "Езжайте на север сюда: {area:502}. Вонючка стоит у подножия холма; охраняйте его, пока он собирает листья чуть к югу.",

	-- Step 6: Mirefin murlocs
	["Mirefin murlocs"] = "Мурлоки Болотного Плавника",
	-- {area:502} Witch Hill
	["The Mirefin murlocs crowd the coast east and north-east of {area:502}; every kind drops heads."] = "Мурлоки племени Болотного Плавника толпятся на побережье к востоку и северо-востоку от места {area:502}; головы падают со всех видов.",

	-- Step 7: Swamp Eye Jarl
	["Swamp Eye Jarl"] = "Ярл «Болотный Глаз»",
	-- {area:497} Swamplight Manor · {area:502} Witch Hill
	["Jarl lives in the {area:497} south-east of {area:502}."] = "Ярл живет здесь: {area:497}, к юго-востоку от места {area:502}.",
	-- {object:20985} Loose Dirt
	["{object:20985}, beside the manor"] = "{object:20985}, у усадьбы",

	-- Step 8: Darkfang spiders
	["Darkfang spiders"] = "Пауки-темножвалы",
	-- plural, as words: Darkfang Venomspitters = {npc:4414} Darkfang Venomspitter · Theramore Infiltrators = {npc:4834} Theramore Infiltrator
	["Ride west back across the marsh. The Darkfang Venomspitters on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely."] = "Возвращайтесь на запад через болото. С ядоплюев-темножвалов на холмах к северу от Гиблотопи падают ядовитые железы. Тераморские секретные агенты (35-36) крадутся в тех же лесах: они незаметны, смотрите внимательно.",

	-- Step 9: Darkmist Cavern
	["The Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes."] = "Пауки Мглистой пещеры кишат у входа в пещеру к северо-западу от Гиблотопи; глаза падают со всех видов.",

	-- Step 11: Swamp Eye Jarl
	-- {area:497} Swamplight Manor
	["Ride east back to the {area:497}."] = "Возвращайтесь на восток сюда: {area:497}.",
	-- {item:3853} Moonsteel Broadsword · {skill:164} Blacksmithing
	["only if you carry a {item:3853} ({skill:164} or the Auction House)"] = "только если у вас есть {item:3853} ({skill:164} или аукцион)",
	-- {object:20985} Loose Dirt · {npc:4791} Nazeer Bloodpike
	["{object:20985}, now that {npc:4791} has read the report"] = "{object:20985}, теперь, когда {npc:4791} прочел донесение",

	-- Step 12: Brackenwall Village
	["Ride back west to Brackenwall with the head."] = "Возвращайтесь с головой на запад в Гиблотопь.",
	-- {npc:2519} Kin'weelay · {object:3202} Grom'gol
	["For {npc:2519} at {object:3202}, in the next guide"] = "Для персонажа {npc:2519} ({object:3202}), в следующем руководстве",

	-- Step 13: Hearth to Ratchet
	-- {area:392} Ratchet
	["Hearth to {area:392}"] = "Камень возвращения: {area:392}",

	-- Step 15: Melizza Brimbuzzle
	-- {area:607} Valley of Spears · {npc:12277} Melizza Brimbuzzle
	["Ride north-east to the {area:607}. {npc:12277} is held in the Maraudine centaur camp; free her and escort her out east of the valley."] = "Езжайте на северо-восток сюда: {area:607}. {npc:12277} в плену в лагере кентавров Мародин; освободите ее и выведите на восток из долины.",

	-- Step 16: Kodo Graveyard
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard
	["{npc:6019} waits at the goblin camp on the west side of the {area:596}."] = "{npc:6019} ждет в лагере гоблинов в западной части места {area:596}.",

	-- Step 17: Gizelton Caravan
	-- {npc:11626} Rigger Gizelton · {area:602} Mannoroc Coven
	["{npc:11626}'s caravan stops on the road at the edge of {area:602}. Escort it east past the coven; demons attack it twice."] = "Караван ({npc:11626}) останавливается на дороге у края места {area:602}. Сопроводите его на восток мимо ковена; демоны нападут дважды.",

	-- Step 18: Scrabblescrew's Camp
	-- {npc:11596} Smeed Scrabblescrew · {area:596} Kodo Graveyard
	["The caravan ends at {npc:11596}'s camp on the east side of the {area:596}."] = "Караван заканчивает путь у лагеря {npc:11596} в восточной части места {area:596}.",

	-- Step 19: Ghost Walker Post
	-- {npc:5395} Felgur Twocuts · {npc:5412} Gurda Wildmane · {npc:11596} Smeed Scrabblescrew
	["{npc:5395} and {npc:5412} stand in the post just west of {npc:11596}'s camp."] = "{npc:5395} и {npc:5412} стоят в лагере чуть к западу от лагеря {npc:11596}.",

	-- Step 20: Kormek's Hut
	["Ride north up the road to the hut by the road north of the graveyard."] = "Езжайте на север по дороге к хижине у дороги к северу от кладбища.",

	-- Step 21: Kodo bones and ghosts
	["Kodo bones and ghosts"] = "Кости кодо и призраки",
	-- {item:15848} Crate of Ghost Magnets
	["Pick up the kodo bones scattered across the graveyard, and use the {item:15848} among the bones: the ghosts it draws drop the ghost-o-plasm."] = "Собирайте кости кодо по всему кладбищу и используйте предмет {item:15848} среди костей: с призванных призраков падает призракоплазма.",

	-- Step 24: Thunder Axe Fortress
	-- {area:2407} Kormek's Hut · {item:14523} Demon Pick · {npc:11876} Demon Spirit · {item:13542} Demon Box
	["The Burning Blade hold the fortress north-west of {area:2407}. Use the {item:14523} on the {npc:11876} in the fortress to get the {item:13542}."] = "Культисты (Пылающий Клинок) занимают крепость к северо-западу от места {area:2407}. Примените предмет {item:14523} на персонаже {npc:11876} в крепости, чтобы получить {item:13542}.",

	-- Step 25: Ethel Rethor
	-- {npc:11863} Azore Aldamort · {area:2405} Ethel Rethor
	["Ride west to {npc:11863}'s tower at {area:2405} on the north-west coast."] = "Езжайте на запад к башне ({npc:11863}, {area:2405}) на северо-западном побережье.",

	-- Step 26: Slitherblade coast
	["Slitherblade coast"] = "Берег Скользящего Плавника",
	-- {area:2405} Ethel Rethor · {area:598} Sar'theris Strand · {npc:12369} Lord Kragaru · {quest:6027} Book of the Ancients
	["The Slitherblade naga hold the coast north of {area:2405}, up to {area:598}. {npc:12369} guards the {quest:6027} at the far northern tip."] = "Наги клана Скользящего Плавника занимают берег к северу от места {area:2405}, до места {area:598}. {npc:12369} охраняет книгу ({quest:6027}) на северной оконечности.",

	-- Step 28: Maraudine totems
	["Maraudine totems"] = "Тотемы Мародин",
	-- {area:2405} Ethel Rethor · {area:607} Valley of Spears · {quest:93225} Carved Centaur Totems
	-- plural, as words: Maraudine Scouts = {npc:4654} Maraudine Scout
	["Ride south from {area:2405} into the {area:607}. The Maraudine Scouts, Wranglers, Maulers, Windchasers and Marauders (36-39) drop the {quest:93225}."] = "Езжайте на юг от места {area:2405} сюда: {area:607}. С разведчиков, пастухов, извергов, ветроловок и мародеров из племени Мародин (36-39) падают тотемы ({quest:93225}).",

	-- Step 29: Shadowprey Village
	["Ride on south-west to Shadowprey."] = "Езжайте дальше на юго-запад к Деревне Ночных Охотников.",

	-- Step 30: Portals of the Legion
	-- {area:602} Mannoroc Coven
	["Ride east to {area:602}. Use the Rod of Banishing by each demon portal to close six of them."] = "Езжайте на восток сюда: {area:602}. Используйте жезл изгнания у порталов демонов, чтобы закрыть шесть из них.",

	-- Step 31: Ghost Walker Post
	-- {npc:5412} Gurda Wildmane · {area:597} Ghost Walker Post
	["Ride north from the coven to {npc:5412} at {area:597}."] = "Езжайте на север от ковена к персонажу {npc:5412} ({area:597}).",

	-- Step 32: Hearth to Shadowprey
	["Hearth to Shadowprey"] = "Камень возвращения: Деревня Ночных Охотников",
	-- {zone:1434} Stranglethorn Vale
	["The next guide takes you back to {zone:1434}."] = "Следующее руководство вернет вас сюда: {zone:1434}.",
}
