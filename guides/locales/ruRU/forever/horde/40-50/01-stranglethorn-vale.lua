-- Russian (ruRU): the guide forever/horde/40-50/01-stranglethorn-vale (forever/horde/40-50/01-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Hearth to Ratchet
	-- {area:392} Ratchet
	["Hearth to {area:392}"] = "",

	-- Step 2: To Ratchet
	-- {area:392} Ratchet
	["To {area:392}"] = "",

	-- Step 4: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Корабль: {area:35}",

	-- Step 5: Booty Bay
	-- {area:35} Booty Bay
	["The boat lands in {area:35}'s harbour. The quest givers stand on the boardwalks around the harbour and in the inn."] = "Корабль прибывает в гавань ({area:35}). Персонажи с заданиями стоят на мостках вокруг гавани и в таверне.",
	-- {npc:2495} Drizzlik
	["{npc:2495}: the Snapjaw skins gathered earlier; inside"] = "",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "",
	-- {area:272} Tarren Mill · {zone:1417} Arathi Highlands
	["The next guide flies you north to {area:272} and into the {zone:1417}."] = "",
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {area:976} Gadgetzan
	["{npc:773}: for {quest:2864} in {area:976}; upstairs"] = "",
	["Inside"] = "",
	-- {zone:1446} Tanaris
	["for Stoley in {zone:1446}; on the top floor"] = "",

	-- Step 6: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "Летите сюда: {object:3202}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "",

	-- Step 8: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "",
	-- {object:3202} Grom'gol
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights."] = "",

	-- Step 10: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "",
	-- {object:3202} Grom'gol
	["{object:3202} flight master"] = "",

	-- Step 12: Bloodsail Correspondence
	-- {area:35} Booty Bay
	["Leave town by the tunnel; the note lies in the pirates' cove just north of {area:35}."] = "Выйдите из города через туннель; записка лежит в пиратской бухте чуть к северу от места {area:35}.",

	-- Step 13: Booty Bay
	["\"Sea Wolf\" MacKinley, on the top floor"] = "",
	-- {npc:2488} Deeg
	["{npc:2488}, on the top floor"] = "",

	-- Step 14: Mistvale Valley: kill these as you meet them
	-- {area:1737} Mistvale Valley
	["{area:1737}: kill these as you meet them"] = "",
	-- {area:43} Wild Shore · {npc:2493} Dizzy One-Eye · {area:35} Booty Bay · {area:1737} Mistvale Valley
	-- plural, as words: Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both.\nTake the road south towards {area:35}. The Elder Mistvale Gorillas (40-41) live in {area:1737}, east of the road; about one in twenty carries an aged sinew."] = "",

	-- Step 16: The Bloodsail ships
	["The Bloodsail ships"] = "Корабли Кровавого Паруса",
	-- {area:43} Wild Shore · {npc:2546} Fleet Master Firallon · {quest:624} Cortello's Riddle
	["The three ships lie off the {area:43}. The crews are 42-45, Stillwater 45, Keelhaul 46 and {npc:2546} 48: at 41 this is a fight for a group, or for the end of the guide. If you go, swim out and pull the crew to the rail one at a time. A scroll, {quest:624}, lies on the ships' decks: take it."] = "Три корабля стоят у берега ({area:43}). Команды 42-45, капитан Штиллец 45, капитан Кильватель 46, {npc:2546} 48: на 41-м уровне это бой для группы или для конца руководства. Если идете, плывите к ним и выманивайте команду к борту по одному. На палубе лежит свиток ({quest:624}): возьмите его.",
	-- {area:8} Swamp of Sorrows
	["for a later stop in the {area:8}"] = "",

	-- Step 17: Witch Doctor Unbagwa
	-- {area:35} Booty Bay · {area:1737} Mistvale Valley
	["Take the road north out of {area:35}; Unbagwa sits on a hill in {area:1737}, east of the road."] = "Езжайте по дороге на север от места {area:35}; Унбагва сидит на холме ({area:1737}), к востоку от дороги.",
	-- {area:1742} Spirit Den
	["Inside {area:1742}"] = "",

	-- Step 18: Mistvale gorillas
	["Mistvale gorillas"] = "Гориллы из Мглистой долины",
	["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang."] = "Гориллы бродят по долине вокруг Унбагвы. Потроха падают со старых горилл; клык может упасть с любой.",

	-- Step 19: Witch Doctor Unbagwa
	-- {npc:1514} Mokk the Savage
	["Hand Unbagwa the fangs and stay by him: he calls three waves of gorillas, then {npc:1514}. Fight them one at a time."] = "Отдайте Унбагве клыки и оставайтесь рядом: он призовет три волны горилл, затем {npc:1514}. Бейтесь с ними по одному.",

	-- Step 21: Venture Co. mine
	["Venture Co. mine"] = "Рудник Торговой компании",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals.\nCareful: Stealthed Shadowmaw Panthers and Stranglethorn Tigresses roam the area around the camp."] = "",

	-- Step 23: Nesingwary's camp
	["Nesingwary's camp"] = "",

	-- Step 24: Zul'Kunda
	["Zul'Kunda"] = "Зул'Кунда",
	-- {npc:1061} Gan'zulah · {npc:1062} Nezzliok the Dire
	["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them."] = "К западу от экспедиции вожди племени Кровавого Скальпа – {npc:1061} и {npc:1062} – стоят вместе в руинах Зул'Кунды. Сначала перебейте охрану, затем выманите их.",

	-- Step 25: Hearth to Grom'gol Base Camp
	-- {area:117} Grom'gol Base Camp
	["Hearth to {area:117}"] = "",

	-- Step 26: Grom'gol
	-- {object:2076} Bubbling Cauldron
	["the {object:2076}, beside Nimboya"] = "",

	-- Step 27: Jungle stalkers
	["Jungle stalkers"] = "Ящеры-ловчие",
	-- {object:3202} Grom'gol
	["The stalker raptors hunt the jungle south of {object:3202}, out towards the west coast."] = "Ящеры-ловчие охотятся в джунглях к югу от места {object:3202}, ближе к западному побережью.",

	-- Step 28: The Cape of Stranglethorn: kill these as you meet them
	-- {area:1577} The Cape of Stranglethorn
	["{area:1577}: kill these as you meet them"] = "",
	-- {object:759} Holy Spring
	["Follow the coast south. The naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them."] = "Идите вдоль берега на юг. Наги-исследователи бродят по берегу и носят связки тростника; {object:759} бурлит в холмах чуть к востоку.",

	-- Step 29: Booty Bay
	-- {area:35} Booty Bay
	["Ride south to {area:35}. Shaky Phillipe waits on the docks."] = "Езжайте на юг сюда: {area:35}. Филипп «Трусишка» ждет на пристани.",
	-- {npc:6807} Innkeeper Skindle
	["{npc:6807}, upstairs"] = "",

	-- Step 30: Zanzil's camps
	["Zanzil's camps"] = "Лагеря Занзила",
	["North-east of Mistvale, Zanzil's followers camp in the jungle; every one of them can carry the mixture."] = "К северо-востоку от Мглистой долины в джунглях стоят лагерем последователи Занзила; смесь может быть у любого из них.",

	-- Step 31: Pirate ghosts
	["Pirate ghosts"] = "Призраки пиратов",
	-- {area:35} Booty Bay · {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow · {npc:2537} Chucky "Ten Thumbs"
	["The three ghostly pirates haunt the jungle north of {area:35}, near Zanzil's camps: {npc:2535} and {npc:2536} stand together, {npc:2537} further east."] = "Три призрачных пирата бродят в джунглях к северу от места {area:35}, у лагерей Занзила: {npc:2535} и {npc:2536} стоят вместе, {npc:2537} – дальше к востоку.",

	-- Step 32: Zul'Mamwe
	["Zul'Mamwe"] = "Зул'Мамбве",
	-- {npc:1059} Ana'thek the Cruel
	["Ride north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "Езжайте на север к руинам племени Дробителей Черепов к востоку от рудника Торговой компании; выманивайте охотников за головами и берсерков по одному. {npc:1059} охраняет юго-западные руины, а одна груда трофейных черепов стоит в северной части руин. С любого тролля Дробителей Черепов может упасть клык или ожерелье: ожерелья падают медленнее, поэтому бейте воинов в лагере к северу от руин, пока не соберете все.",
	["Skullsplitter warriors"] = "Воины из племени Дробителей Черепов",
	-- {npc:669} Skullsplitter Hunter
	["{npc:669} walks around here: look inside the circle on the map"] = "",
	["Below ground"] = "",

	-- Step 33: Balia'mah Ruins: kill these as you meet them
	-- {area:127} Balia'mah Ruins
	["{area:127}: kill these as you meet them"] = "",
	-- {object:3202} Grom'gol
	["The next trophy skulls stand in the small ruins just north of the warriors' camp.\nThe last skulls are in the ruins a short ride west, on the way back to {object:3202}."] = "",

	-- Step 34: Grom'gol Base Camp
	-- {object:3202} Grom'gol
	["Ride west to {object:3202}."] = "Езжайте на запад сюда: {object:3202}.",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076}"] = "{object:2076}",

	-- Step 36: Booty Bay
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "",

	-- Step 39: Nesingwary's Expedition
	["Ride north up the road to the hunters' camp."] = "Езжайте на север по дороге к лагерю охотников.",

	-- Step 41: Into the Swamp of Sorrows
	-- {area:8} Swamp of Sorrows
	["Into the {area:8}"] = "",
	-- {zone:1431} Duskwood · {zone:1430} Deadwind Pass · {npc:1776} Magtoor · {area:657} Harborage
	["Keep riding north into {zone:1431}, then east along the road through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp near the way in from {zone:1430}."] = "Езжайте дальше на север в край {zone:1431}, затем на восток по дороге через край {zone:1430} в болото. {npc:1776} ждет здесь: {area:657} – лагерь дренеев у въезда со стороны края {zone:1430}.",

	-- Step 42: Stonard
	-- {area:75} Stonard
	["Ride east to {area:75}, in the reeds south of the road."] = "Езжайте на восток сюда: {area:75}, в камышах к югу от дороги.",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "",

	-- Step 43: Stonard
	-- {area:75} Stonard
	["You start in {area:75}. Bind here: you hearth back after the coast."] = "",
	-- {npc:1442} Helgrum the Swift
	["{npc:1442}, upstairs"] = "",
	-- {npc:6930} Innkeeper Karakul
	["{npc:6930}, upstairs"] = "",
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "",

	-- Step 44: Monstrous Crawler Leg on the way
	-- {item:6184} Monstrous Crawler Leg
	["{item:6184} on the way"] = "",

	-- Step 45: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "Острозубые кроколиски",
	-- {npc:5391} Galen Goodward · {area:75} Stonard · {npc:5592} Tok'Kar
	-- plural, as words: Shadow Panthers = {npc:768} Shadow Panther
	["The crocolisks wallow in the pools around {npc:5391}'s camp and south towards {area:75}; about one in four drops a flank.\nCareful: {npc:5592}'s camp sits by the coast. Along the way to it you pass level 40 spiders that chase a long distance, plus stealthed Shadow Panthers."] = "",

	-- Step 46: Fly to Booty Bay
	-- {area:75} Stonard
	["{area:75} flight master"] = "",

	-- Step 47: Boat to Ratchet
	-- {area:392} Ratchet
	["Boat to {area:392}"] = "",

	-- Step 48: Riding at 40
	["Riding at 40"] = "",
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village · {zone:1411} Durotar · {zone:1454} Orgrimmar
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:7953} in {area:367} on the {zone:1411} coast, with Zjolnir's raptors (20 gold each) beside him. Another race's trainer (Kildar in {zone:1454}) teaches you only once you are Exalted with his city."] = "",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "",
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village
	["Raptors: Zjolnir, beside {npc:7953} in {area:367}."] = "",

	-- Step 50: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "",

	-- Step 51: Noboru the Cudgel
	-- {area:76} Fallow Sanctuary
	["Noboru wanders the clearing south-west of the {area:76}; his cudgel starts a quest."] = "Нобору бродит по поляне к юго-западу от места {area:76}; его дубина начинает задание.",

	-- Step 52: Draenethyst crystals
	["Draenethyst crystals"] = "Кристаллы дренетиста",
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	["Ride north-east to the {area:76}. The crystals stand along the way up to {npc:5391}'s cage."] = "Езжайте на северо-восток сюда: {area:76}. Кристаллы стоят по пути к клетке ({npc:5391}).",

	-- Step 53: Galen's Escape
	-- {npc:5391} Galen Goodward · {area:76} Fallow Sanctuary
	["{npc:5391} is held in the {area:76} in the swamp's north-east. Free him and follow him out, fighting off the swamp creatures that chase him."] = "{npc:5391} в плену здесь: {area:76}, на северо-востоке болота. Освободите его и следуйте за ним, отбиваясь от болотных тварей.",

	-- Step 54: Harborage
	-- {area:657} Harborage · {zone:1430} Deadwind Pass
	["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}."] = "Езжайте на запад по дороге к лагерю дренеев ({area:657}), у въезда со стороны края {zone:1430}.",

	-- Step 55: Galen's Strongbox
	-- {area:75} Stonard
	["His strongbox waits at his old camp north of {area:75}."] = "Его сундук – в его старом лагере к северу от места {area:75}.",

	-- Step 56: Misty Reed Post
	-- {area:75} Stonard
	["Ride back east past {area:75} and follow the road south-east to the small Horde post on the shore."] = "Возвращайтесь на восток мимо места {area:75} и следуйте по дороге на юго-восток к небольшому лагерю Орды на берегу.",

	-- Step 57: Sawtooth snappers
	["Sawtooth snappers"] = "Острозубые крепкохваты",
	["The snappers line the strand south of the post."] = "Крепкохваты сидят на берегу к югу от лагеря.",

	-- Step 58: Misty Reed Post
	-- {zone:1446} Tanaris
	["The next guide starts here and takes you to {zone:1446}.\nThe small Horde post on the southern shore."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly to {area:392}"] = "Летите сюда: {area:392}",
	-- ["From {area:2408} fly to {area:392}."] = "Из места {area:2408} летите сюда: {area:392}.",
	-- ["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals."] = "Дальше к северу гоблины Торговой компании копают в руднике к востоку от дороги; кристаллы падают с шахтеров, десятников, геодезистов и механиков.",
	-- ["Hearth to {area:35}"] = "Камень возвращения: {area:35}",
	-- ["Hearth to {object:3202}"] = "Камень возвращения: {object:3202}",
	-- ["Into the {zone:1435}"] = "В край {zone:1435}",
	-- ["Naga shore and the {object:759}"] = "Берег наг и {object:759}",
	-- ["Ride north up the road; the hunters camp on the hill above the river."] = "Езжайте на север по дороге; лагерь охотников – на холме над рекой.",
	-- ["Ride north-west to {object:3202}."] = "Езжайте на северо-запад сюда: {object:3202}.",
	-- ["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "К югу от Пиратской бухты висельники из шайки Кровавого Паруса стоят лагерем здесь: {area:43}; карты и приказы лежат в их палатках. Нюхательный табак и глаз {npc:2493} может нести любой пират Кровавого Паруса: убивайте, пока не получите оба.",
	-- ["The boat to {area:35} docks at the end of {area:392}'s pier."] = "Корабль ({area:35}) причаливает в конце пирса ({area:392}).",
	-- ["The crocolisks wallow in the pools around {npc:5391}'s camp and south towards {area:75}; about one in four drops a flank."] = "Кроколиски лежат в лужах вокруг лагеря {npc:5391} и к югу, к месту {area:75}; бок падает примерно с каждого четвертого.",
	-- ["The last skulls are in the ruins a short ride west, on the way back to {object:3202}."] = "Последние черепа – в руинах недалеко к западу, по пути обратно сюда: {object:3202}.",
	-- ["The next guide starts here and takes you to {zone:1446}."] = "Следующее руководство начинается здесь и ведет в край {zone:1446}.",
	-- ["The next trophy skulls stand in the small ruins just north of the warriors' camp."] = "Следующие трофейные черепа – в небольших руинах чуть к северу от лагеря воинов.",
	-- ["The {area:43}"] = "{area:43}",
	-- ["The {area:657}"] = "{area:657}",
	-- ["for Stoley in {zone:1446}"] = "для Столи ({zone:1446})",
	-- ["for a later stop in the {zone:1435}"] = "для более поздней остановки ({zone:1435})",
	-- ["for later: the {zone:1425}, around level 48"] = "на потом: {zone:1425}, примерно на 48-м уровне",
	-- ["the {object:2076}, beside {npc:2497}"] = "{object:2076}, рядом: {npc:2497}",
	-- ["{area:392} pier"] = "Пирс: {area:392}",
	-- ["{npc:773}: for {quest:2864} in {area:976}"] = "{npc:773}: для задания {quest:2864} ({area:976})",
}
