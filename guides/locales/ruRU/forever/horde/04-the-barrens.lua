-- Russian (ruRU): the guide forever/horde/04-the-barrens (forever/horde/04-the-barrens.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Лететь: {area:392}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 2: Ratchet
	-- {object:3972} WANTED
	["{object:3972} poster"] = "Плакат: {object:3972}",

	-- Step 4: Bruuz
	-- {npc:209797} Bruuz
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:209797} (level 20 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 5: Ratchet
	-- {npc:3391} Gazlowe
	["{npc:3391} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 6: Level 19.43
	["Level 19.43"] = "",
	-- {quest:92706} WANTED: Bruuz
	["If you skipped {quest:92706}, grind here to level 19.43 to stay on the route's plan."] = "",
	-- {npc:3256} Sunscale Scytheclaw
	["grind on {npc:3256}"] = "",

	-- Step 7: Ratchet
	-- {npc:3442} Sputtervalve · {quest:1483} Ziz Fizziks
	["{npc:3442}, beside the wind rider master. Keep it: {quest:1483} is in Stonetalon, later"] = "{npc:3442}, рядом с распорядителем ветрокрылов. Сохраните задание: {quest:1483} – в Когтистых горах, позже",

	-- Step 10: Northwatch Hold: kill these as you meet them
	-- {area:385} Northwatch Hold
	["{area:385}: kill these as you meet them"] = "",
	-- {area:385} Northwatch Hold · {npc:3393} Captain Fairmount
	-- plural, as words: Theramore Marines = {npc:3385} Theramore Marine
	["{area:385}, on the coast further south. The Theramore Marines and Preservers (15-16) drop the medals; {npc:3393} (20) and the two cannoneers (19) stand in the keep and on its walls, and they are why the hold waits until now.\nCareful: Each named target is linked to a healer and guards, and Fairmount has three extra marines with her. Killing the healer first makes the fight easier."] = "",
	["On the top floor"] = "",
	["Upstairs"] = "",

	-- Step 11: Free From the Hold
	-- {npc:3465} Gilthares Firebough · {area:392} Ratchet
	["{npc:3465} is chained inside the hold. Talk to him to start the escort and stay close: Theramore soldiers attack on the way out. He walks you back to {area:392}."] = "{npc:3465} закован в цепи внутри крепости. Поговорите с ним, чтобы начать сопровождение, и держитесь рядом: на выходе нападут солдаты Терамора. Он доведет вас обратно. Цель: {area:392}.",
	["Inside"] = "",

	-- Step 14: Raptor Grounds: kill these as you meet them
	-- {area:1697} Raptor Grounds
	["{area:1697}: kill these as you meet them"] = "",
	-- {area:380} Crossroads · {area:1697} Raptor Grounds · {area:392} Ratchet · {area:385} Northwatch Hold
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["Sunscale Scytheclaws hunt the plains south of the {area:380}, around the {area:1697}; they drop the horns. Hand them in on your next pass through {area:392}.\nEast across the plains toward the coast: the stolen silver lies in a raptor nest north-west of {area:385}."] = "",

	-- Step 15: Raptor nests
	["Raptor nests"] = "",
	-- {area:1697} Raptor Grounds
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["The three nests sit together in the {area:1697} south-west of the oasis; Sunscale Scytheclaws guard them."] = "",

	-- Step 16: Crossroads
	-- {npc:3429} Thork
	["{npc:3429}, at the top of the tower"] = "{npc:3429}, на вершине башни",
	-- {npc:3429} Thork · {area:1703} Mor'shan Rampart
	["{npc:3429}. Keep it: Kadrak at the {area:1703}, next guide"] = "{npc:3429}. Сохраните задание: Кадрак ({area:1703}), следующий гайд",
	-- {npc:3428} Korran · {area:390} Field of Giants
	["{npc:3428}: the eggs are in the {area:390}, later"] = "{npc:3428}: яйца – здесь: {area:390}, позже",

	-- Step 17: Dreadmist Peak
	-- {area:380} Crossroads · {area:384} Dreadmist Peak · {item:15842} Empty Dreadmist Peak Sampler · {object:19464} Dreadmist Peak Pool · {npc:3448} Tonga Runetotem · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["Head north from the {area:380} to {area:384} and fill the {item:15842} at the {object:19464}, then back to {npc:3448} in the {area:380}. No {skill:182}? {npc:3490} beside him sells {item:2449}, three at a time until he restocks."] = "",
	-- {item:2449} Earthroot · {npc:3490} Hula'mahi
	["{item:2449} from {npc:3490}; herbalists pick it on the plains"] = "{item:2449}: продает {npc:3490}; травники собирают на равнинах",

	-- Step 18: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate · {area:380} Crossroads
	["{npc:3389} stands at the Kolkar watch post just west of the {area:380}."] = "{npc:3389} стоит у дозорного поста против кентавров Колкар чуть западнее места {area:380}.",

	-- Step 19: Barak Kodobane
	-- {npc:3394} Barak Kodobane · {npc:3389} Regthar Deathgate
	["{npc:3394} stands in the Kolkar camp north-west of {npc:3389}."] = "{npc:3394} стоит в лагере племени Колкар к северо-западу от {npc:3389}.",
	-- {item:15852} Kodo Horn
	-- plural, as words: Lost Barrens Kodos = {npc:3234} Lost Barrens Kodo
	["{item:15852}: Lost Barrens Kodos on the plains around the Kolkar camp"] = "{item:15852}: потерявшиеся степные кодо ({npc:3234}) на равнинах вокруг лагеря Колкар",
	-- {item:2449} Earthroot
	["{item:2449}: herbalists pick it here"] = "{item:2449}: травники собирают здесь",

	-- Step 21: Vrang Wildgore
	-- {area:383} Dry Hills · {npc:3682} Vrang Wildgore · {npc:261366} Walton
	["North to the {area:383}. {npc:3682} camps below the hills; {npc:261366}, the hermit on the ridge behind him, has work for you only once {npc:3682} sends you up."] = "На север. Цель: {area:383}. {npc:3682} стоит лагерем под холмами; у отшельника на гребне за ним ({npc:261366}) найдется работа, только когда {npc:3682} отправит вас наверх.",

	-- Step 22: The Barrens: kill these as you meet them
	-- {area:17} The Barrens
	["{area:17}: kill these as you meet them"] = "",
	-- {quest:876} Serena Bloodfeather
	-- plural, as words: Savannah Patriarchs = {npc:3241} Savannah Patriarch · Sprung Traps = {object:640104} Sprung Trap
	["Savannah Patriarchs roam the plains east of the hills, and the Sprung Traps lie among them. {quest:876} leads the Witchwing harpies in the hills to the west.\nCareful: The route in passes stealthed Harpy Ambushers and an elite harpy that patrols."] = "",
	-- {quest:865} Raptor Horns
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["{quest:865}, if still open: Sunscale Scytheclaws prowl among the lions"] = "",

	-- Step 25: Trouble in the Valley
	-- {npc:262119} Corporal Adamore · {npc:261366} Walton
	["{npc:262119} and his marines hold the wrecked caravan south of {npc:261366}. The marines are linked: pulling one calls the rest. Pull from the edge and run; they leash short, so you can thin the camp one at a time before tackling the Corporal."] = "",

	-- Step 26: Walton
	-- {npc:261366} Walton · {npc:261367} Terry Longdrink · {area:21} Kul Tiras
	["Assist {npc:261366}: stay by him when {npc:261367} and the {area:21} marines come up the ridge"] = "Помогите NPC {npc:261366}: держитесь рядом, когда на гребень поднимутся {npc:261367} и солдаты ({area:21})",

	-- Step 28: Strange Lockbox
	-- {object:177792} Strange Lockbox · {area:382} Sludge Fen · {item:15883} Half Pendant of Aquatic Agility · {quest:30} Trial of the Sea Lion
	["The {object:177792} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "{object:177792} лежит у северного края места {area:382}, у башни Торговой компании. В нем – {item:15883} для задания {quest:30}.",

	-- Step 29: The Escape
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["Wizzlecrank drives his shredder out of the camp: stay with him and kill whatever attacks him. {npc:3442} takes it in {area:392}.\nCareful: The route leads west and climbs a ramp. Once you reach the top, two Venture Company mobs ambush you."] = "",

	-- Step 30: Mission: Possible But Not Probable
	-- {npc:7287} Foreman Silixiz
	["Pickpocket {npc:7287} for the tower key before opening the lockbox. Gallywix and his lockbox are at the top; the key does not open that box, which still needs Lockpicking. Gallywix is elite: grouping up is advised. If you postpone this optional job, resume it in the Class guide Poisons (Horde)."] = "",
	["Venture Co. tower"] = "Башня Торговой компании",

	-- Step 31: Boulder Lode Mine
	-- {item:5097} Cats Eye Emerald
	-- plural, as words: Venture Co. Overseers = {npc:3286} Venture Co. Overseer
	["The Venture Co. Overseers and Enforcers at the mine in the north-east corner of the zone drop the {item:5097}."] = "{item:5097} падает с надзирателей и головорезов Торговой компании у рудника в северо-восточном углу зоны.",

	-- Step 33: Shenthul
	-- {quest:2458} Deep Cover · {npc:7233} Taskmaster Fizzule · {area:382} Sludge Fen
	["{quest:2458}: {npc:7233}, by the {area:382}"] = "{quest:2458}: {npc:7233}, у места {area:382}",

	-- Step 35: Taskmaster Fizzule
	-- {area:382} Sludge Fen · {item:8051} Flare Gun
	["Fizzule is by the Venture Co. tower north of the {area:382}. Before you go near him, use {item:8051} to fire two flares, then target him and /salute: he attacks anyone who comes in without signalling first."] = "",

	-- Step 38: Orgrimmar
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom
	["{npc:3354} is in the {object:172958}, {npc:5892} in the {object:172957}."] = "",

	-- Step 40: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Fly to {area:1638} and train your level 20 ranks: {npc:3033} is on {area:1639}."] = "Летите сюда: {area:1638} – и изучите ранги 20-го уровня: {npc:3033} – здесь: {area:1639}.",

	-- Step 41: Orgrimmar class quests
	-- {zone:1454} Orgrimmar
	["{zone:1454} class quests"] = "",
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits
	["{npc:6018} stands in the {object:172961} on the city's west side."] = "",

	-- Step 42: Gan'rul Bloodeye
	-- {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["The {object:172960} is the canyon under the {object:172982}."] = "{object:172960} – ущелье под местом {object:172982}.",
	-- {npc:5909} Cazul
	["{npc:5909}, a few steps away"] = "{npc:5909}, в нескольких шагах",

	-- Step 43: Ur'kyo
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits
	["{npc:6018} stands in the {object:172961}, on the city's west side."] = "{npc:6018} стоит здесь: {object:172961}, в западной части города.",
	-- {npc:6018} Ur'kyo · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["{npc:6018}: {npc:4606} in the {zone:1458}, two guides on"] = "{npc:6018}: {npc:4606} ({zone:1458}), через два гайда",

	-- Step 44: Back to Crossroads
	-- {area:380} Crossroads
	["Back to {area:380}"] = "",

	-- Step 45: Back to Crossroads
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 46: the Crossroads
	-- {area:380} Crossroads
	["the {area:380}"] = "",
	-- {item:15826} Curative Animal Salve
	["He gives you the {item:15826}"] = "Он даст вам {item:15826}",

	-- Step 50: Ken'zigla
	-- {npc:4197} Ken'zigla · {area:2539} Malaka'jin · {npc:3389} Regthar Deathgate
	["{npc:4197} lives in {area:2539}, the troll village just inside Stonetalon at the end of the road west from {npc:3389}."] = "",

	-- Step 52: Verog the Dervish
	-- {npc:3395} Verog the Dervish · {area:388} Stagnant Oasis · {area:380} Crossroads
	["{npc:3395} walks among the Kolkar at the {area:388} south-east of the {area:380}."] = "{npc:3395} ходит среди кентавров из племени Колкар ({area:388}) к юго-востоку от места {area:380}.",
	-- {npc:12296} Sickly Gazelle · {item:15826} Curative Animal Salve · {area:380} Crossroads
	["{npc:12296}: use the {item:15826} on them; they roam the plains all around the {area:380}"] = "{npc:12296}: используйте на них {item:15826}; они бродят по равнинам вокруг места {area:380}",

	-- Step 53: Bristleback camps
	["Bristleback camps"] = "Лагеря Дыбогривых",
	-- {area:378} Camp Taurajo · {area:458} Gold Road · {npc:3432} Mankrik · {npc:3430} Mangletooth · {quest:883} Lakota'mani
	["The Bristleback quilboar camps spread over the plains north of {area:378}, either side of the {area:458}. {npc:3432}'s wife lies at their north edge, on your way south. Leave the quilboar for now: {npc:3430} in {area:378} wants the same camps cleared. {quest:883}, a grey kodo, sometimes wanders here: his hoof starts a quest."] = "",

	-- Step 54: Camp Taurajo
	-- {area:458} Gold Road · {area:378} Camp Taurajo
	["Follow the {area:458} south to {area:378}."] = "Идите по дороге ({area:458}) на юг. Цель: {area:378}.",
	-- {npc:3433} Tatternack Steelforge
	["{npc:3433}, at the north edge of the camp"] = "{npc:3433}, у северного края лагеря",
	-- {npc:3430} Mangletooth
	["{npc:3430}, in the cage"] = "{npc:3430}, в клетке",
	-- {npc:6394} Ruga Ragetotem
	["{npc:6394}, inside"] = "",

	-- Step 55: Bramblescar
	-- {npc:3432} Mankrik · {npc:3430} Mangletooth · {item:5075} Blood Shard
	["Back north into the Bristleback camps. Any Bristleback can drop a tusk for {npc:3432}, so collect them while you kill these for {npc:3430}. Keep one {item:5075}."] = "",

	-- Step 57: Grunt Dogran
	["Dogran is chained up in the quilboar camp west of the road."] = "Догран закован в цепи в лагере свинобразов к западу от дороги.",
	-- {npc:5875} Gan'rul Bloodeye · {zone:1454} Orgrimmar
	["Keep it: {npc:5875} in {zone:1454}, at the end of this guide"] = "Сохраните: {npc:5875} ({zone:1454}), в конце этого гайда",

	-- Step 61: Fly to Ratchet
	-- {area:378} Camp Taurajo
	["{area:378} flight master"] = "",

	-- Step 63: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} waits on the hill south of {area:392}, on your way north."] = "{npc:5901} ждет на холме к югу (ориентир: {area:392}), по пути на север.",

	-- Step 64: Ishamuhale
	-- {quest:882} Ishamuhale · {item:10338} Fresh Zhevra Carcass · {object:147538} Dead Tree (no name in this language: may be words) · {area:392} Ratchet · {area:380} Crossroads
	["{quest:882}, a big Sunscale raptor, only comes to a fresh kill: loot a {item:10338} from a zhevra, then use it at the {object:147538} north-west of {area:392}, north of the road to the {area:380}, and be ready when he arrives."] = "",
	-- {item:10338} Fresh Zhevra Carcass
	-- plural, as words: Zhevra Chargers = {npc:3426} Zhevra Charger
	["{item:10338}, from any zhevra; Zhevra Chargers graze around the tree"] = "",
	-- {object:147538} Dead Tree (no name in this language: may be words) · {quest:882} Ishamuhale
	["At the {object:147538}: summons {quest:882}"] = "",

	-- Step 65: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:380} Crossroads
	["{npc:5878} camps beside the road east of the {area:380}."] = "{npc:5878} стоит лагерем у дороги к востоку (ориентир: {area:380}).",
	-- {quest:1838} Brutal Armor · {area:1717} Razorfen Kraul
	["He offers {quest:1838} next (1838, level 30): it needs {area:1717} and sends you all over Kalimdor and the Eastern Kingdoms. The Warrior class guide {quest:1838} covers it."] = "Затем он предложит {quest:1838} (1838, 30-й уровень): для него нужно место {area:1717}, и оно отправит вас по всему Калимдору и Восточным королевствам. Его описывает классовый гайд воина «{quest:1838}».",

	-- Step 66: Crossroads
	-- {npc:3432} Mankrik · {quest:95774} Her Name Is Olgra · {quest:4921} Lost in Battle
	["{npc:3432} offers {quest:95774} once {quest:4921} is handed in"] = "{npc:3432} предложит {quest:95774}, когда будет сдано задание {quest:4921}",

	-- Step 68: Hezrul Bloodmark
	-- {npc:3396} Hezrul Bloodmark · {area:387} Lushwater Oasis · {npc:3389} Regthar Deathgate · {area:380} Crossroads
	["{npc:3396} leads the Kolkar on the west shore of {area:387}, south of {npc:3389}. Hand his head to {npc:3389} on your last {area:380} stop."] = "{npc:3396} ведет кентавров из племени Колкар на западном берегу ({area:387}) к югу от {npc:3389}. Отдайте его голову {npc:3389} при последнем заходе сюда: {area:380}.",

	-- Step 69: Olgra's Adornments
	-- {area:458} Gold Road · {area:378} Camp Taurajo · {item:277277} Olgra's Adornments · {npc:3432} Mankrik · {area:380} Crossroads
	-- plural, as words: Razormane Raiders = {npc:268624} Razormane Raider
	["On the way back down the {area:458} to {area:378}: the Razormane Raiders among the Bristleback camps, either side of the road north of the camp, carry {item:277277}. Hand them to {npc:3432} on your last {area:380} stop."] = "По пути обратно на юг по дороге ({area:458}). Цель: {area:378}. {item:277277} – у налетчиков из племени Иглогривых среди лагерей Дыбогривых, по обе стороны дороги к северу от лагеря. Отдайте их NPC {npc:3432} при последнем заходе сюда: {area:380}.",

	-- Step 70: Camp Taurajo
	-- {area:458} Gold Road · {area:378} Camp Taurajo
	["Down the {area:458} to {area:378} again."] = "Снова на юг по дороге ({area:458}). Цель: {area:378}.",
	-- {npc:12696} Senani Thunderheart · {zone:1440} Ashenvale
	["Keep it: {npc:12696} in {zone:1440}, next guide"] = "Сохраните: {npc:12696} ({zone:1440}), следующий гайд",

	-- Step 71: Enraged Thunder Lizards
	-- {area:378} Camp Taurajo · {quest:884} Owatanka
	-- plural, as words: Thunderheads = {npc:3239} Thunderhead
	["Thunderheads graze on the plains just south of {area:378}. {quest:884}, a blue thunder lizard, roams among them: his Tailspike starts a quest."] = "Громоголовы пасутся на равнинах чуть южнее места {area:378}. Среди них бродит синий громоящер {quest:884}: его хвостовой шип начинает задание.",

	-- Step 73: Cry of the Thunderhawk
	-- plural, as words: Thunderhawk Cloudscrapers = {npc:3424} Thunderhawk Cloudscraper
	["Thunderhawk Cloudscrapers circle over the same plains south of the camp."] = "Над теми же равнинами к югу от лагеря кружат грозовые змеи-облачники.",

	-- Step 75: Gann Stonespire
	-- {npc:3341} Gann Stonespire · {area:359} Bael Modan
	["{npc:3341} waits in a small camp further south, on the road toward {area:359}."] = "{npc:3341} ждет в небольшом лагере дальше к югу, на дороге к месту {area:359}.",
	-- {npc:3341} Gann Stonespire · {area:1701} Blackthorn Ridge
	["{npc:3341} walks around {area:1701}: look inside the circle on the map"] = "",

	-- Step 76: Bael Modan
	-- {area:359} Bael Modan · {npc:3392} Prospector Khazgorm
	["South of Gann, the Bael'dun dwarves dig at {area:359}. Excavators and Foremen work the pit; {npc:3392} (26) carries the journal: pull him alone.\nCareful: Excavators (level 21-22) and Foremen (level 22-23) run off for help once they fall to 15% health, so more dwarves can join the fight."] = "",
	-- {npc:3375} Bael'dun Foreman · {area:359} Bael Modan
	["{npc:3375} walks around {area:359}: look inside the circle on the map"] = "",

	-- Step 77: Blackthorn Ridge
	-- {area:1701} Blackthorn Ridge · {npc:3436} Kuz · {npc:3434} Nak · {npc:3435} Lok Orcbane · {npc:5859} Hagg Taurenbane · {npc:3238} Stormhide · {npc:3341} Gann Stonespire · {quest:885} Washte Pawne · {spell:1752} Sinister Strike
	-- plural, as words: Hecklefang Stalkers = {npc:4128} Hecklefang Stalker · Razormane Stalkers = {npc:3457} Razormane Stalker
	["West of Gann, the Razormane hold {area:1701}. {npc:3436} is on the east side, {npc:3434} to the south, {npc:3435} at the west end. Lok (25) and the Warfrenzies (24-25) are a few levels above you; {npc:5859}, a rare elite, sometimes walks the ridge: leave him. Pathfinders and Stalkers drop the Backstabber, Seers the Wand, Warfrenzies the War Shield. {npc:3238} lizards and Hecklefang Stalkers roam the plain between {npc:3341} and the ridge. {quest:885}, a rare red wind serpent, flies over the ridge: its feather starts a quest.\nCareful: Razormane Stalkers move around in stealth and hit with {spell:1752}, so they can join a fight without warning."] = "",

	-- Step 79: Field of Giants
	-- {area:390} Field of Giants
	-- plural, as words: Silithid Mounds = {object:3685} Silithid Mound · Silithid Swarmers = {npc:3252} Silithid Swarmer · Silithid Harvesters = {npc:3253} Silithid Harvester
	["South of Camp Taurajo the Silithid Mounds dot the {area:390}; the eggs lie in them, and Silithid Swarmers come out to defend them. Silithid Harvesters are rare: if you see one, kill it for its head.\nCareful: Silithid Swarmers in the area release many tiny adds that interrupt spells; damage shields such as Thorns kill them in one hit."] = "",

	-- Step 80: Sulhasa
	-- {npc:14242} Sulhasa · {npc:3341} Gann Stonespire
	["{npc:14242}, up in the tree just east of {npc:3341}"] = "{npc:14242}, на дереве чуть восточнее {npc:3341}",
	-- {npc:5899} Brine · {npc:3341} Gann Stonespire
	["{npc:5899}, just west of {npc:3341}"] = "{npc:5899}, чуть западнее {npc:3341}",
	-- {item:7766} Empty Brown Waterskin
	["Fill the {item:7766} at the quilboar watering hole"] = "Наполните {item:7766} у водопоя свинобразов",
	-- {object:107045} Spring Well · {area:272} Tarren Mill
	["Keep it: the {object:107045} is beside {area:272}"] = "Сохраните: {object:107045} – рядом с местом {area:272}",

	-- Step 81: Southern Barrens
	-- {npc:4128} Hecklefang Stalker · {area:1156} Southern Barrens
	["{npc:4128} walks around {area:1156}: look inside the circle on the map"] = "",

	-- Step 82: Sulhasa
	-- {npc:3238} Stormhide
	["{npc:3238}, by this stop"] = "",

	-- Step 83: Bael'dun fortress
	["Bael'dun fortress"] = "Крепость Бейл'дана",
	-- plural, as words: Bael'dun Soldiers = {npc:3376} Bael'dun Soldier
	["The Bael'dun Soldiers, Riflemen and Officers guard the fortress on the east side of the dig; all three items drop from them.\nCareful: Riflemen (level 24-25) Shoot from 5-30 yd, so nearby ones can join a fight from range."] = "",

	-- Step 85: The flying machine
	["The flying machine"] = "Летательная машина",
	["The dwarves' flying machine sits on its platform inside the dig site."] = "Летательная машина дворфов стоит на площадке внутри раскопок.",

	-- Step 87: Twitching Antennae
	["Twitching Antennae"] = "Дергающиеся усики",
	-- {area:390} Field of Giants · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo · {npc:4196} Silithid Swarm · {npc:5781} Silithid Creeper Egg
	-- plural, as words: Silithid Swarmers = {npc:3252} Silithid Swarmer · Silithid Creepers = {npc:3250} Silithid Creeper
	["The antennae vanish fifteen minutes after they drop, so gather them now, on the way back north: kill the Silithid Swarmers and Creepers at the {area:390}' mounds until you have five, then take them straight to {npc:6394} in {area:378}.\nCareful: Silithid Swarmers (level 21-22) cast {npc:4196} both in and out of combat, which brings several small adds. Silithid Creepers (level 20-21) periodically cast {npc:5781} in combat, which spawns extra adds."] = "",
	["Twitching Antennae from the silithid"] = "Дергающиеся усики с силитидов",

	-- Step 89: Fly to Crossroads
	-- {area:380} Crossroads
	["Fly to {area:380}"] = "",

	-- Step 92: Crossroads flight master
	-- {area:380} Crossroads
	["{area:380} flight master"] = "",

	-- Step 93: Thunder Bluff
	-- {npc:246344} Alodan the Hopeful · {area:1638} Thunder Bluff · {area:378} Camp Taurajo · {zone:1412} Mulgore · {npc:2995} Tal
	["{npc:246344} teaches Paladins in {area:1638}. You have no flight path there yet: fly to {area:378}, head west through {zone:1412} and up a lift, and take the flight path from {npc:2995} on the central rise."] = "",

	-- Step 95: The Great Cat Spirit
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Fly to {area:1638} to train: {npc:3033} is on {area:1639}."] = "Летите сюда: {area:1638} – на обучение: {npc:3033} – здесь: {area:1639}.",

	-- Step 96: Moonglade
	-- {spell:18960} Teleport: Moonglade · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. Tauren: join the two pendant halves at the {area:2362}, on the north-west shore of the lake, before you see {npc:11802} in {area:2361}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos
	["{item:15885}: use a half at the {area:2362}"] = "{item:15885}: используйте половинку здесь: {area:2362}",

	-- Step 97: Moonglade
	-- {spell:18960} Teleport: Moonglade
	["Cast {spell:18960}"] = "",

	-- Step 98: Moonglade
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["{npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 99: Moonglade
	-- {npc:11802} Dendrite Starblaze · {npc:3033} Turak Runetotem
	["{npc:11802}: the welcome from {npc:3033}"] = "{npc:11802}: приветствие от {npc:3033}",

	-- Step 100: The Stormrage Barrow Dens
	-- {area:2363} Stormrage Barrow Dens
	["The {area:2363}"] = "{area:2363}",
	-- {npc:11957} Great Cat Spirit · {npc:272054} Avatar of Saeyleenan · {item:280680} Relic of the Silent Shadow
	["Tauren: the {npc:11957} waits on the southern hill above the bridge. Skyborne: the {npc:272054} stands south of the twin bridges. Then the dens east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue."] = "Таурены: {npc:11957} ждет на южном холме над мостом. Небеснорожденные: {npc:272054} стоит к югу от двух мостов. Затем – логова к востоку от озера: выйдите из облика, щелкните по статуе у входа, чтобы получить пять минут незаметности, держитесь подальше от духов внутри и возьмите по одной реликвии каждого вида; {item:280680} лежит у подножия статуи белой кошки.",

	-- Step 102: Turak Runetotem
	-- {npc:11798} Bunthen Plainswind · {area:2361} Nighthaven
	["{npc:11798} in {area:2361} flies druids there"] = "{npc:11798} ({area:2361}) отправляет туда друидов по воздуху",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the {area:380}"] = "Назад: {area:380}",
	-- ["Bruuz"] = "Брууз",
	-- ["Cast {spell:18960}. Tauren: join the two pendant halves at the {area:2362}, on the north-west shore of the lake, before you see {npc:11802} in {area:2361}."] = "Примените {spell:18960}. Таурены: соедините две половинки подвески здесь: {area:2362}, на северо-западном берегу озера, прежде чем идти к NPC {npc:11802} ({area:2361}).",
	-- ["Doras, the wind rider master, stands on the tower in the {object:172982}."] = "Дорас, распорядитель ветрокрылов, стоит на башне ({object:172982}).",
	-- ["East across the plains toward the coast: the stolen silver lies in a raptor nest north-west of {area:385}."] = "На восток через равнины к побережью: украденное серебро лежит в гнезде ящеров к северо-западу (ориентир: {area:385}).",
	-- ["East to the {area:382}. {npc:3439} stands inside the Venture Co. camp; {npc:3445} carries the key."] = "На восток. Цель: {area:382}. {npc:3439} стоит в лагере Торговой компании; ключ – у NPC {npc:3445}.",
	-- ["Fizzule runs the Venture Co. camp at the east end of the {area:382}. He attacks strangers: target him and /salute before he does."] = "Физзул руководит лагерем Торговой компании в восточном конце места {area:382}. Он нападает на чужаков: выберите его целью и введите /salute, пока он не напал.",
	-- ["Fly back to the {area:380}. The next guide starts here and takes the road north to the {area:1703} and {zone:1440}."] = "Летите обратно. Цель: {area:380}. Отсюда начинается следующий гайд: дорога на север к месту {area:1703} и в зону {zone:1440}.",
	-- ["Fly to {area:1637} to train your level 20 ranks. {npc:3354} is in the {object:172958}, {npc:5892} in the {object:172957}."] = "Летите сюда: {area:1637} – изучить ранги 20-го уровня. {npc:3354} – здесь: {object:172958}; {npc:5892} – здесь: {object:172957}.",
	-- ["Fly to {area:1637} to train."] = "Летите сюда: {area:1637} – на обучение.",
	-- ["Hearth to the {area:380}"] = "Вернуться камнем: {area:380}",
	-- ["Level 20"] = "20-й уровень",
	-- ["Ride north from the {area:380} to {area:384} and fill the {item:15842} at the {object:19464}, then back to {npc:3448} in the {area:380}. No {skill:182}? {npc:3490} beside him sells {item:2449}, three at a time until he restocks."] = "Езжайте на север от места {area:380}. Цель: {area:384}. Наполните {item:15842} ({object:19464}), затем назад: {npc:3448} ({area:380}). Нет навыка {skill:182}? {npc:3490} рядом с ним продает {item:2449} – по три штуки, пока не обновит запас.",
	-- ["Savannah Patriarchs roam the plains east of the hills, and the Sprung Traps lie among them. {quest:876} leads the Witchwing harpies in the hills to the west."] = "Патриархи саванны бродят по равнинам к востоку от холмов, среди них лежат сработавшие ловушки. {quest:876} ведет гарпий из стаи Зачарованного Крыла на холмах к западу.",
	-- ["South of Camp Taurajo the Silithid Mounds dot the {area:390}; the eggs lie in them, and Silithid Swarmers come out to defend them. Silithid Harvesters are rare: if you see one, kill it for its head."] = "К югу от Лагеря Таурахо по местности {area:390} разбросаны курганы силитидов; в них лежат яйца, а на защиту выходят членистоноги Силитида. Силитиды-жнецы редки: если увидите одного, убейте его ради головы.",
	-- ["South of Gann, the Bael'dun dwarves dig at {area:359}. Excavators and Foremen work the pit; {npc:3392} (26) carries the journal: pull him alone."] = "К югу от Ганна дворфы Бейл'дана ведут раскопки ({area:359}). В котловане работают землечерпы и старшины; дневник – у NPC {npc:3392} (26): выманите его одного.",
	-- ["Stay stealthed: {npc:7287} carries the key to the tower; Gallywix and his lockbox are at the top. Gallywix is elite: grouping up is advised."] = "Оставайтесь незаметными: ключ от башни – у NPC {npc:7287}; Нервотреп и его денежный ящик – наверху. Нервотреп – элита: лучше собрать группу.",
	-- ["Sunscale Scytheclaws hunt the plains south of the {area:380}, around the {area:1697}; they drop the horns. Hand them in on your next pass through {area:392}."] = "Яркочешуйчатые смертехваты охотятся на равнинах к югу (ориентир: {area:380}), вокруг места {area:1697}; с них падают рога. Сдайте их, когда в следующий раз будете здесь: {area:392}.",
	-- ["The Bael'dun Soldiers, Riflemen and Officers guard the fortress on the east side of the dig; all three items drop from them."] = "Солдаты, ружейники и офицеры Бейл'дана охраняют крепость на восточной стороне раскопок; все три предмета падают с них.",
	-- ["The Bristleback quilboar camps spread over the plains north of {area:378}, either side of the {area:458}. Every Bristleback drops a tusk; {npc:3432}'s wife lies at the north edge. Keep one {item:5075}. {quest:883}, a grey kodo, sometimes wanders here: his hoof starts a quest."] = "Лагеря дыбогривых свинобразов раскинулись по равнинам к северу от места {area:378}, по обе стороны дороги ({area:458}). Бивень падает с каждого Дыбогривого; жена NPC {npc:3432} лежит у северного края. Сохраните один предмет: {item:5075}. Здесь иногда бродит серый кодо {quest:883}: его копыто начинает задание.",
	-- ["The antennae vanish fifteen minutes after they drop, so gather them now, on the way back north: kill the Silithid Swarmers and Creepers at the {area:390}' mounds until you have five, then hearth to {area:378} straight away."] = "Усики исчезают через пятнадцать минут после выпадения, поэтому соберите их сейчас, по пути на север: убивайте членистоногов Силитида и ползучих силитидов у курганов ({area:390}), пока не наберете пять, затем сразу возвращайтесь камнем. Цель: {area:378}.",
	-- ["The level-20 class quests in {zone:1454} ({npc:3354}, {npc:5892}, the Warlock and Rogue trainers) are only offered from level 20, so finish the level here before you fly. The Thunderhawk Hatchlings (18) on the plains south-west of the {area:380} and the Kolkar (14-15) at the {area:388} are the nearest mobs worth killing; you need well under a level."] = "Классовые задания 20-го уровня в городе {zone:1454} ({npc:3354}, {npc:5892}, учителя чернокнижников и разбойников) выдаются только с 20-го уровня, поэтому доберите уровень здесь, прежде чем лететь. Ближайшие подходящие противники – птенцы грозового змея (18) на равнинах к юго-западу (ориентир: {area:380}) и кентавры из племени Колкар (14-15), здесь: {area:388}; нужно гораздо меньше уровня.",
	-- ["The pirates camp on the beach south of {area:392}; {npc:3467} stands at its southern end."] = "Пираты стоят лагерем на пляже к югу (ориентир: {area:392}); {npc:3467} – в его южном конце.",
	-- ["The {area:380}"] = "{area:380}",
	-- ["The {area:383}"] = "{area:383}",
	-- ["The {object:177790} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "{object:177790} лежит у северного края места {area:382}, у башни Торговой компании. В нем – {item:15883} для задания {quest:30}.",
	-- ["West of Gann, the Razormane hold {area:1701}. {npc:3436} is on the east side, {npc:3434} to the south, {npc:3435} at the west end. Lok (25) and the Warfrenzies (24-25) are a few levels above you; {npc:5859}, a rare elite, sometimes walks the ridge: leave him. Pathfinders and Stalkers drop the Backstabber, Seers the Wand, Warfrenzies the War Shield. {npc:3238} lizards and Hecklefang Stalkers roam the plain between {npc:3341} and the ridge. {quest:885}, a rare red wind serpent, flies over the ridge: its feather starts a quest."] = "К западу от {npc:3341} племя Иглогривых занимает {area:1701}. {npc:3436} – на восточной стороне, {npc:3434} – на юге, {npc:3435} – в западном конце. Лок (25) и бешенеры (24-25) на несколько уровней выше вас; по гребню иногда ходит редкий элитный {npc:5859}: не трогайте его. Кинжал падает с землепроходцев и ловчих, жезл – с ясновидцев, боевой щит – с бешенеров. Ящеры ({npc:3238}) и многозубые ловцы бродят по равнине между Ганном и гребнем. Над гребнем летает редкий красный ветрокрылый змей {quest:885}: его перо начинает задание.",
	-- ["Wizzlecrank drives his shredder out of the camp: stay with him and kill whatever attacks him. {npc:3442} takes it in {area:392}."] = "Он выводит свой крошшер из лагеря: держитесь рядом и убивайте всех, кто на него нападает. Задание принимает {npc:3442} ({area:392}).",
	-- ["grind on Thunderhawk Hatchlings south-west of the {area:380}"] = "убивайте птенцов грозового змея к юго-западу (ориентир: {area:380})",
	-- ["{area:385}, on the coast further south. The Theramore Marines and Preservers (15-16) drop the medals; {npc:3393} (20) and the two cannoneers (19) stand in the keep and on its walls, and they are why the hold waits until now."] = "{area:385}, на побережье дальше к югу. Медали падают с тераморских стражей бухты и оберегательниц (15-16); {npc:3393} (20) и двое канониров (19) стоят в крепости и на ее стенах – поэтому крепость и ждала до сих пор.",
	-- ["{npc:209797} swims in the harbour just off {area:392}'s docks. {npc:209797} is elite: grouping up is advised."] = "{npc:209797} плавает в гавани прямо у причалов ({area:392}). {npc:209797} – элита: лучше собрать группу.",
	-- ["{npc:2391} in {area:272} teaches Poisons: keep it"] = "{npc:2391} ({area:272}) обучает: Яды – сохраните задание",
	-- ["{npc:2391} in {area:272} teaches {spell:2842}: keep it"] = "{npc:2391} ({area:272}) обучает: {spell:2842} – сохраните задание",
	-- ["{npc:246344} teaches Paladins in {area:1638}. You have no flight path there yet: fly to {area:378}, ride west through {zone:1412} and up a lift, and take the flight path from {npc:2995} on the central rise."] = "{npc:246344} обучает паладинов ({area:1638}). Маршрута полета туда у вас еще нет: летите сюда: {area:378}, езжайте на запад через зону {zone:1412}, поднимитесь на подъемнике и получите маршрут полета у NPC {npc:2995} на центральном возвышении.",
	-- ["{npc:262119} and his marines hold the wrecked caravan south of {npc:261366}."] = "{npc:262119} и его солдаты удерживают разбитый караван к югу (ориентир: {npc:261366}).",
	-- ["{npc:3238}, on the plain between {npc:3341} and the ridge"] = "{npc:3238}, на равнине между {npc:3341} и гребнем",
	-- ["{npc:3401} stands in the {object:172960}. Target him and type /salute to finish {quest:2460}."] = "{npc:3401} стоит здесь: {object:172960}. Выберите его целью и введите /salute, чтобы выполнить задание {quest:2460}.",
	-- ["{npc:3453}, on the dock"] = "{npc:3453}, на причале",
	-- ["{npc:4197} lives in {area:2539}, the troll village just inside Stonetalon at the end of the road west from {npc:3389}."] = "{npc:4197} живет здесь: {area:2539} – деревня троллей сразу на входе в Когтистые горы, в конце дороги на запад от {npc:3389}.",
	-- ["{npc:5875} stands in the {object:172960}. Use {item:6626} on the summoning circle there and defeat the succubus to bind her."] = "{npc:5875} стоит здесь: {object:172960}. Используйте {item:6626} на круге призыва и победите суккуба, чтобы подчинить ее.",
	-- ["{quest:882}, a big Sunscale raptor, hunts the plains north of the road from {area:392} to the {area:380}."] = "{quest:882}, крупный яркочешуйчатый ящер, охотится на равнинах к северу от дороги между местами {area:392} и {area:380}.",
}
