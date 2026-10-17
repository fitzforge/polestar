-- Russian (ruRU): the guide forever/horde/tauren/01-mulgore (forever/horde/tauren/01-mulgore.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Camp Narache
	-- {area:221} Camp Narache · {npc:2980} Grull Hawkwind
	["You start on the mesa of {area:221}. {npc:2980} and the chief stand by the big tent in the middle."] = "Вы начинаете на плато ({area:221}). {npc:2980} и вождь стоят у большого шатра в центре.",

	-- Step 2: The Hunt Begins
	["Plainstriders roam the grass all around the camp."] = "Равнинные долгоноги бродят по траве вокруг лагеря.",

	-- Step 3: Grull Hawkwind
	-- {npc:3059} Harutt Thunderhorn
	["{npc:3059}, the warrior trainer"] = "{npc:3059}, учитель воинов",
	-- {npc:3061} Lanka Farshot
	["{npc:3061}, the hunter trainer"] = "{npc:3061}, учитель охотников",
	-- {npc:3062} Meela Dawnstrider
	["{npc:3062}, the shaman trainer in camp"] = "{npc:3062}, учитель шаманов, в лагере",
	-- {npc:3060} Gart Mistrunner
	["{npc:3060}, the druid trainer beside him"] = "{npc:3060}, учитель друидов, рядом с ним",

	-- Step 4: Greatmother Hawkwind
	-- {npc:2991} Greatmother Hawkwind · {object:2907} Water Pitcher
	["{npc:2991} sits by the tent on the camp's eastern edge; the {object:2907} stands next to her."] = "{npc:2991} сидит у шатра на восточном краю лагеря; {object:2907} стоит рядом с ней.",

	-- Step 6: The Hunt Continues
	-- {npc:6775} Antur Fallow · {npc:2980} Grull Hawkwind
	-- plural, as words: Mountain Cougars = {npc:2961} Mountain Cougar
	["{npc:6775} stands at the west end of the camp, at the north-west corner of the hills where the Mountain Cougars prowl: take his quest, hunt the cougars from there south and east, then come back up to {npc:2980}."] = "{npc:6775} стоит в западной части лагеря, у северо-западного угла холмов, где бродят горные пумы: возьмите его задание, охотьтесь на пум оттуда к югу и востоку, затем вернитесь к {npc:2980}.",

	-- Step 7: Grull Hawkwind
	-- {npc:3209} Brave Windfeather · {npc:2980} Grull Hawkwind
	["{npc:3209}, next to {npc:2980}"] = "{npc:3209}, рядом с {npc:2980}",

	-- Step 8: Seer Graytongue
	["Follow the path south out of camp to the Seer's tent at the foot of the hills."] = "Идите по тропе на юг из лагеря к шатру провидца у подножия холмов.",

	-- Step 9: The shrine of An'she and Mu'sha
	["The shrine of An'she and Mu'sha"] = "Святилище Ан'ше и Му'ши",
	-- {object:660739} Ritual Fire
	["The incense burns out in ten minutes: run straight east along the southern hills to the {object:660739}."] = "Благовония сгорают за десять минут: бегите прямо на восток вдоль южных холмов сюда: {object:660739}.",

	-- Step 10: Brambleblade Ravine
	-- {npc:8554} Chief Sharptusk Thornmantle · {object:3076} Dirt-stained Map
	-- plural, as words: Battleboars = {npc:2966} Battleboar
	["Battleboars graze north of the shrine; the Bristleback quilboar hold the ravine to the north-east. {npc:8554} stands at its eastern end, and the {object:3076} lies on the ground in the camp."] = "К северу от святилища пасутся боевые вепри; дыбогривые свинобразы занимают ущелье к северо-востоку. {npc:8554} стоит в его восточной части, а {object:3076} лежит на земле в лагере.",

	-- Step 11: Camp Narache
	["Back west to the camp."] = "Назад на запад в лагерь.",

	-- Step 12: Seer Ravenfeather
	-- {npc:5888} Seer Ravenfeather · {area:221} Camp Narache · {quest:1516} Call of Earth
	["{npc:5888} stands in {area:221}. {quest:1516} needs level 4, which you reach with the turn-ins here."] = "{npc:5888} стоит здесь: {area:221}. Для задания {quest:1516} нужен 4-й уровень – вы получите его, сдав задания здесь.",

	-- Step 13: Ritual Salve
	-- {area:358} Brambleblade Ravine
	-- plural, as words: Bristleback Shamans = {npc:2953} Bristleback Shaman
	["Back east to {area:358}: the Bristleback Shamans stand among the quilboar there."] = "Назад на восток сюда: {area:358}: шаманы из племени Дыбогривов стоят там среди свинобразов.",

	-- Step 14: Call of Earth
	-- {npc:5888} Seer Ravenfeather · {npc:5891} Minor Manifestation of Earth · {item:6635} Earth Sapta · {item:6656} Rough Quartz
	["Back to {npc:5888} in the camp. The {npc:5891} waits on the mesa east of the camp: drink the {item:6635} there to see it, then take the {item:6656} back to the Seer."] = "Назад к персонажу {npc:5888} в лагерь. {npc:5891} ждет на плато к востоку от лагеря: выпейте там {item:6635}, чтобы увидеть его, затем отнесите предмет {item:6656} провидцу.",
	-- {npc:5888} Seer Ravenfeather · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5888}: {npc:5873} and your {item:5175}"] = "{npc:5888}: {npc:5873} и ваш {item:5175}",

	-- Step 15: Kaga Wildhoof
	-- {area:220} Red Cloud Mesa · {npc:265810} Kaga Wildhoof · {area:222} Bloodhoof Village · {spell:1229451} Boosted Rest
	["Follow the road north out of {area:220}. {npc:265810} waits on the road just south of {area:222}; /sit by her campfire until you get {spell:1229451}."] = "Идите по дороге на север от места {area:220}. {npc:265810} ждет на дороге чуть к югу от места {area:222}; /sit у ее костра, пока не получите {spell:1229451}.",
	-- {spell:1229451} Boosted Rest
	["/sit by Kaga's campfire until you get {spell:1229451}"] = "/sit у костра Каги, пока не получите {spell:1229451}",

	-- Step 16: Bloodhoof Village
	-- {npc:3067} Pyall Silentstride
	["Speak with {npc:3067}"] = "Поговорите с персонажем {npc:3067}",

	-- Step 17: Poison Water
	-- plural, as words: Adult Plainstriders = {npc:2956} Adult Plainstrider
	["Prairie Wolves and Adult Plainstriders roam the plains around the village."] = "Волки прерий и взрослые равнинные долгоноги бродят по равнинам вокруг деревни.",

	-- Step 19: Winterhoof Water Well
	["The well lies south-east of the village."] = "Колодец – к юго-востоку от деревни.",

	-- Step 21: Chakuyak and Thunderhorn Totem
	-- {quest:96130} Chakuyak · {quest:756} Thunderhorn Totem
	["{quest:96130} and {quest:756}"] = "{quest:96130} и {quest:756}",
	-- {quest:96130} Chakuyak
	-- plural, as words: Prairie Stalkers = {npc:2959} Prairie Stalker · Flatland Cougars = {npc:3035} Flatland Cougar
	["{quest:96130}, a lone wolf, prowls the plains west of the village. Prairie Stalkers and Flatland Cougars roam the plains north and west of it."] = "{quest:96130}, волк-одиночка, бродит по равнинам к западу от деревни. Охотники прерий и пумы плоскогорья бродят по равнинам к северу и западу от нее.",

	-- Step 22: Back to Bloodhoof
	["Back to Bloodhoof"] = "Назад в Деревня Кровавого Копыта",

	-- Step 23: Sparring Match
	-- {npc:3063} Krang Stonehoof
	-- plural, as words: Novice Warriors = {npc:10721} Novice Warrior
	["{npc:3063}'s quest: beat three Novice Warriors (or players in duels) next to him."] = "Задание ({npc:3063}): одолейте трех воинов-учеников (или игроков на дуэли) рядом с ним.",

	-- Step 25: Ahab Wheathoof
	-- {npc:277182} Ahab Wheathoof · {item:287505} Tender Strider Meat
	["{npc:277182} stands at the north edge of the village. Kyle wants {item:287505} from plainstriders."] = "{npc:277182} стоит на северной окраине деревни. Кайлу нужен предмет {item:287505} с равнинных долгоногов.",

	-- Step 26: Thunderhorn Water Well
	-- {object:2912} Ambercorn · {quest:766} Mazzranache · {quest:761} Swoop Hunting
	-- plural, as words: Well Stones = {object:2910} Well Stone
	["The well lies north of the village. Well Stones sit around the well, {object:2912} lies under the trees nearby. Kill wolves, cougars, plainstriders and swoops on the way for {quest:766} and {quest:761}."] = "Колодец – к северу от деревни. Камни у источника лежат вокруг него, {object:2912} – под деревьями рядом. По пути убивайте волков, пум, долгоногов и перепелятников для заданий {quest:766} и {quest:761}.",

	-- Step 27: Bloodhoof Village
	-- {npc:277182} Ahab Wheathoof
	["{npc:277182}, at the north end of the village"] = "{npc:277182}, на северной окраине деревни",

	-- Step 28: Swoop Hunting
	["Swoops glide over the plains all around Bloodhoof."] = "Перепелятники парят над равнинами вокруг Деревни Кровавого Копыта.",

	-- Step 29: Morin Cloudstalker
	-- {npc:2988} Morin Cloudstalker · {area:396} Winterhoof Water Well
	["{npc:2988} camps by the {area:396} south-east of Bloodhoof."] = "{npc:2988} стоит лагерем у места {area:396}, к юго-востоку от Деревни Кровавого Копыта.",

	-- Step 30: Longwalker Malah
	-- {npc:275789} Malah Longwind · {area:821} Rolling Plains
	["{npc:275789} stands on the {area:821} a little east of the well."] = "{npc:275789} стоит здесь: {area:821}, чуть к востоку от колодца.",

	-- Step 31: Prairie Wolf Alphas
	-- plural, as words: Prairie Wolf Alphas = {npc:2960} Prairie Wolf Alpha
	["Prairie Wolf Alphas"] = "Могучие волки прерий",
	-- {npc:275789} Malah Longwind
	-- plural, as words: Prairie Wolf Alphas = {npc:2960} Prairie Wolf Alpha
	["Prairie Wolf Alphas roam among the wolves on the plains around {npc:275789} and the Galak camp to the east."] = "Могучие волки прерий бродят среди волков на равнинах вокруг NPC {npc:275789} и лагеря племени Галак к востоку.",

	-- Step 32: The Ravaged Caravan
	-- {zone:1456} Thunder Bluff
	["The wrecked caravan lies north-west of the centaurs, east of the road to {zone:1456}."] = "Разбитый караван лежит к северо-западу от кентавров, к востоку от дороги к городу {zone:1456}.",

	-- Step 34: Mazzranache
	["Finish the wolf heart, cougar femur, plainstrider scale and swoop gizzard on the plains around the village."] = "Доберите сердце волка, бедро пумы, чешую долгонога и желудок перепелятника на равнинах вокруг деревни.",

	-- Step 36: Morin Cloudstalker
	-- {area:396} Winterhoof Water Well
	["Back south-east to the {area:396}."] = "Назад на юго-восток сюда: {area:396}.",

	-- Step 37: Galak centaurs
	["Galak centaurs"] = "Кентавры из племени Галак",
	-- {npc:275767} Herak the Pillager
	["The Galak centaurs camp on the plains east of the well; {npc:275767} leads them."] = "Кентавры из племени Галак стоят лагерем на равнинах к востоку от колодца; их ведет {npc:275767}.",

	-- Step 38: The Venture Co. Mine
	-- {quest:765} Supervisor Fizsprocket · {item:281031} Mulgore Expansion Plans · {quest:98424} Fizsprocket's Notes
	["The goblins work the mine in the hills north-east of the well. {quest:765} stands in the back of the mine; his {item:281031} start {quest:98424}, and the other pages lie inside the mine."] = "Гоблины работают в шахте на холмах к северо-востоку от колодца. {quest:765} стоит в глубине шахты; его {item:281031} начинают задание {quest:98424}, а остальные страницы лежат в шахте.",

	-- Step 39: Wildmane Water Well
	-- {zone:1456} Thunder Bluff · {area:398} Wildmane Water Well · {zone:1412} Mulgore
	["Cross north-west past {zone:1456} to the {area:398} in the far north of {zone:1412}."] = "Идите на северо-запад мимо города {zone:1456} сюда: {area:398}, на дальнем севере края {zone:1412}.",

	-- Step 40: Dangers of the Windfury
	-- {area:819} Windfury Ridge
	["The Windfury harpies hold {area:819}, north and west of the well."] = "Гарпии из стаи Ярости Ветра занимают место {area:819} к северу и западу от колодца.",

	-- Step 41: Seer Wiserunner
	-- {npc:2984} Seer Wiserunner · {area:404} Bael'dun Digsite
	["{npc:2984} stands at the edge of the {area:404}, south of the well."] = "{npc:2984} стоит на краю места {area:404}, к югу от колодца.",

	-- Step 42: Dwarven Digging
	-- {area:404} Bael'dun Digsite
	-- plural, as words: Prospector's Picks = {item:4702} Prospector's Pick
	["The dwarves of the {area:404} carry the Prospector's Picks. Smash them at the dwarves' forge in the digsite."] = "Кирки геолога – у дворфов ({area:404}). Разбейте их в кузнице дворфов на раскопках.",
	-- {item:4703} Broken Tools
	["{item:4703}, at the digsite forge"] = "{item:4703} – у кузницы на раскопках",

	-- Step 43: Sharing the Land
	-- {area:818} Palemane Rock · {npc:272203} Perith Stormhoof
	["The Palemane gnolls hold {area:818}, south of the digsite and west of Bloodhoof. {npc:272203} is held in their camp: lead him out."] = "Гноллы из стаи Бледногривов занимают место {area:818} к югу от раскопок и к западу от Деревни Кровавого Копыта. {npc:272203} в плену в их лагере: выведите его.",

	-- Step 44: Bloodhoof Village
	-- {npc:2993} Baine Bloodhoof · {npc:3057} Cairne Bloodhoof · {zone:1456} Thunder Bluff
	["{npc:2993}, for {npc:3057} in {zone:1456}"] = "{npc:2993}, для {npc:3057} ({zone:1456})",
	-- {npc:2948} Mull Thunderhorn · {zone:1456} Thunder Bluff
	["{npc:2948}, for Hamuul in {zone:1456}"] = "{npc:2948}, для Хамуула ({zone:1456})",

	-- Step 46: Red Rocks
	-- {area:225} Red Rocks · {zone:1456} Thunder Bluff · {npc:3233} Lorekeeper Raintotem · {npc:2994} Ancestral Spirit
	-- plural, as words: Bristleback Interlopers = {npc:3232} Bristleback Interloper
	["Head north to {area:225}, east of {zone:1456}. {npc:3233} stands at the foot of the rocks; the Bristleback Interlopers dig at the burial ground and the {npc:2994} waits on top."] = "Идите на север сюда: {area:225}, к востоку от города {zone:1456}. {npc:3233} стоит у подножия скал; злоумышленники из племени Дыбогривов роются на кладбище, а {npc:2994} ждет наверху.",
	-- {item:5203} Flatland Prowler Claw · {area:225} Red Rocks
	-- plural, as words: Flatland Prowlers = {npc:3566} Flatland Prowler
	["{item:5203}: Flatland Prowlers roam the plains around {area:225}"] = "{item:5203}: хищники плоскогорья бродят по равнинам вокруг места {area:225}",

	-- Step 47: Thunder Bluff
	-- {npc:2995} Tal · {npc:3057} Cairne Bloodhoof
	["Ride a lift up to the mesas. {npc:2995} keeps the wind riders on the central rise; {npc:3057} stands in the great tent there."] = "Поднимитесь на подъемнике на плато. {npc:2995} присматривает за ветрокрылами на центральном холме; {npc:3057} стоит там в большом шатре.",

	-- Step 48: Traditions of the Bluff
	-- {npc:269068} Eylah Sunhorn · {npc:3014} Nida Winterhoof · {npc:3012} Nata Dawnstrider · {npc:3005} Mahu · {npc:3027} Naal Mistrunner · {item:278078} Prepared Incense
	["{npc:269068} wants tauren incense: buy its four parts from {npc:3014} the herbalist, {npc:3012} the enchanting supplier, {npc:3005} the leatherworking supplier and {npc:3027} the cooking supplier, then combine them into {item:278078}."] = "{npc:269068} просит тауренские благовония: купите четыре части у {npc:3014} (травница), {npc:3012} (товары для зачарования), персонажа {npc:3005} (товары для кожевников) и {npc:3027} (товары для кулинарии), затем соедините их в предмет {item:278078}.",
	-- {item:278079} Bundle of Herbs · {npc:3014} Nida Winterhoof
	["{item:278079}, from {npc:3014}"] = "{item:278079}, у персонажа {npc:3014}",
	-- {item:278080} Bundle of Dried Cedar Twigs · {npc:3012} Nata Dawnstrider
	["{item:278080}, from {npc:3012}"] = "{item:278080}, у персонажа {npc:3012}",
	-- {item:278081} Sinew Thread · {npc:3005} Mahu
	["{item:278081}, from {npc:3005}"] = "{item:278081}, у персонажа {npc:3005}",
	-- {item:278083} Ceremonial Flint and Tinder · {npc:3027} Naal Mistrunner
	["{item:278083}, from {npc:3027}"] = "{item:278083}, у персонажа {npc:3027}",

	-- Step 49: Hunter Rise
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Use the {item:278078} at the ceremonial mat and burner on the south-facing cliff of {area:1641}."] = "Используйте предмет {item:278078} у церемониального коврика и курильницы на южном обрыве ({area:1641}).",
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Spread the {item:278078} off {area:1641}"] = "Развейте предмет {item:278078} с обрыва ({area:1641})",
	-- {npc:3441} Melor Stonehoof · {quest:860} Sergra Darkthorn · {area:380} Crossroads
	["{npc:3441}: for {quest:860} at the {area:380}"] = "{npc:3441}: для задания {quest:860} ({area:380})",

	-- Step 51: Elder Rise
	-- {npc:5769} Arch Druid Hamuul Runetotem · {npc:3448} Tonga Runetotem · {area:380} Crossroads
	["{npc:5769}: for {npc:3448} at the {area:380}"] = "{npc:5769}: для персонажа {npc:3448} ({area:380})",

	-- Step 53: Turak Runetotem
	-- {npc:6746} Innkeeper Pala · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:6746} on the central rise sends you to {npc:3033} on {area:1639}."] = "{npc:6746} на центральном холме отправляет вас к NPC {npc:3033} ({area:1639}).",

	-- Step 54: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {quest:5930} Great Bear Spirit
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5930} sits in the north-western woods."] = "Используйте {spell:18960}. {npc:11802} – здесь: {area:2361}; {quest:5930} – в северо-западных лесах.",

	-- Step 55: Back to Thunder Bluff
	-- {area:222} Bloodhoof Village · {area:1639} Elder Rise
	["Hearth to {area:222} and ride north to {area:1639}."] = "Камень возвращения: {area:222}, затем езжайте на север сюда: {area:1639}.",

	-- Step 56: Yaw Sharpmane
	-- {area:222} Bloodhoof Village · {item:15908} Taming Rod · {npc:2956} Adult Plainstrider · {npc:2959} Prairie Stalker
	["Ride down to {area:222} and tame with the {item:15908}: an {npc:2956} on the plains, a {npc:2959} north of the village, a Swoop to the north-west."] = "Спуститесь сюда: {area:222} и приручите предметом {item:15908}: монстра {npc:2956} на равнинах, монстра {npc:2959} к северу от деревни и перепелятника к северо-западу.",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "Приручите его предметом {item:15908}",

	-- Step 57: The Moonkin Stone
	-- {object:177525} Moonkin Stone
	["The {object:177525}"] = "{object:177525}",
	-- {zone:1412} Mulgore · {item:15710} Cenarion Lunardust
	["The stone stands in the pass out of {zone:1412}, on your way east. Use the {item:15710} there and defeat Lunaclaw."] = "Камень стоит на перевале из края {zone:1412}, по пути на восток. Используйте там предмет {item:15710} и одолейте Лунокогтя.",

	-- Step 58: Crossroads
	-- {zone:1412} Mulgore · {area:380} Crossroads · {quest:860} Sergra Darkthorn · {npc:3448} Tonga Runetotem · {zone:1413} The Barrens
	["Leave {zone:1412} by the south-eastern pass and follow the road to the {area:380}. {quest:860} stands by the inn, {npc:3448} at the south gate. {zone:1413} guide starts here."] = "Покиньте край {zone:1412} через юго-восточный перевал и идите по дороге сюда: {area:380}. {quest:860} стоит у таверны, {npc:3448} – у южных ворот. Здесь начинается руководство: {zone:1413}.",

	-- Step 59: Class turn-ins in Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Class turn-ins in {area:1638}"] = "Сдача классовых заданий: {area:1638}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Battleboars graze north of the shrine; the Bristleback quilboar hold the ravine to the north-east. {npc:8554} stands at its eastern end, and the {item:4851} lies on the ground in the camp."] = "К северу от святилища пасутся боевые вепри; дыбогривые свинобразы занимают ущелье к северо-востоку. {npc:8554} стоит в его восточной части, а {item:4851} лежит на земле в лагере.",
	-- ["Flatland Prowlers roam the plains around {area:225}"] = "Хищники плоскогорья бродят по равнинам вокруг места {area:225}",
	-- ["Galak centaurs and Prairie Wolf Alphas"] = "Кентавры Галак и могучие волки прерий",
	-- ["The Galak centaurs camp on the plains north of the {area:821}; Herak leads them. Prairie Wolf Alphas roam among the wolves."] = "Кентавры племени Галак стоят лагерем на равнинах к северу от места {area:821}; их ведет Херак. Среди волков бродят могучие волки прерий.",
	-- ["The dwarves of the {area:404} carry the Prospector's Picks. Smash them at the forge in {area:222}."] = "Кирки геолога – у дворфов ({area:404}). Разбейте их в кузнице ({area:222}).",
	-- ["The well lies north of the village. Well Stones sit around the well, {item:4809} lies under the trees nearby. Kill wolves, cougars, plainstriders and swoops on the way for {quest:766} and {quest:761}."] = "Колодец – к северу от деревни. Камни колодца ({item:4808}) лежат вокруг него, {item:4809} – под деревьями рядом. По пути убивайте волков, пум, долгоногов и перепелятников для заданий {quest:766} и {quest:761}.",
	-- ["The {area:380}"] = "{area:380}",
	-- ["{npc:2991} sits by the tent on the camp's eastern edge; the {item:4755} stands next to her."] = "{npc:2991} сидит у шатра на восточном краю лагеря; {item:4755} стоит рядом с ней.",
}
