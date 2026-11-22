-- Russian (ruRU): the guide forever/horde/50-60/06-silithus (forever/horde/50-60/06-silithus.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1451} Silithus · {zone:1446} Tanaris
	["{zone:1451}, then Un'Goro and {zone:1446}."] = "",

	-- Step 1: Innkeeper Vizzie
	-- {npc:11118} Innkeeper Vizzie · {area:2255} Everlook · {area:2249} Frostwhisper Gorge
	-- plural, as words: Ice Thistle Yetis = {npc:7458} Ice Thistle Yeti
	["{npc:11118}, in {area:2255}'s inn, has more mail for you: the Ice Thistle Yetis in the hills south-east of town carry it. Keep it for the last guide, whose ride back north from {area:2249} crosses those hills."] = "",

	-- Step 2: Back from Mount Hyjal
	-- {zone:2482} Mount Hyjal
	["Back from {zone:2482}"] = "",
	-- {zone:2482} Mount Hyjal · {area:2255} Everlook · {area:976} Gadgetzan · {npc:9299} Gaeriyan · {npc:7583} Sprinkle · {area:541} Marshal's Refuge · {zone:1451} Silithus
	["Back from {zone:2482}: fly from {area:2255} to {area:976} for {npc:9299}, {npc:7583} and Pestlezugg, then on to {area:541} and {zone:1451}."] = "",
	["Yugrek, the Horde flight master"] = "",

	-- Step 3: Gaeriyan
	-- {item:11243} Videre Elixir · {area:976} Gadgetzan · {npc:9299} Gaeriyan
	["Drink the {item:11243} at the graveyard just east of {area:976}: it kills you, and only as a ghost can you see {npc:9299}, in a rocky crevice in the hills due north of it. Talk to him there, then run back to your body and resurrect: the Conspicuous Gravestone he sends you to stands in that graveyard."] = "Выпейте {item:11243} на кладбище чуть к востоку от места {area:976}: он вас убьет, и только в облике призрака можно увидеть {npc:9299} – в скальной расщелине в холмах прямо к северу от кладбища. Поговорите с ним там, затем бегите обратно к телу и воскресните: приметное надгробие, к которому он вас отправит, стоит на том же кладбище.",

	-- Step 4: Sprinkle
	-- {item:12928} Umi's Mechanical Yeti · {npc:7583} Sprinkle · {area:976} Gadgetzan · {npc:10977} Quixxil · {npc:10978} Legacki
	["Use {item:12928} on {npc:7583}, the goblin girl in {area:976}. {npc:10977} and {npc:10978} are scared later in the route."] = "Используйте игрушку {item:12928} на гоблинше {npc:7583} ({area:976}). {npc:10977} и {npc:10978} – позже по маршруту.",
	-- {npc:7583} Sprinkle · {item:12928} Umi's Mechanical Yeti
	["Scare {npc:7583} with {item:12928}"] = "Напугайте {npc:7583} с помощью предмета {item:12928}",

	-- Step 5: Alchemist Pestlezugg
	-- {quest:4493} March of the Silithid · {zone:1454} Orgrimmar · {zone:1447} Azshara
	["Inside: {quest:4493}, if you took it in {zone:1454} on the {zone:1447} guide"] = "Внутри: {quest:4493}, если вы взяли его в городе {zone:1454} во время гайда по зоне {zone:1447}",

	-- Step 6: Alchemist Pestlezugg
	["Inside"] = "Внутри",

	-- Step 7: Gaeriyan
	-- {quest:3914} Linken's Sword · {npc:8737} Linken
	["{quest:3914} goes back to {npc:8737} in Un'Goro: keep it."] = "{quest:3914} сдается {npc:8737}у в Ун'Горо: сохраните задание.",

	-- Step 8: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["{npc:7771} camps by the {area:1336} road, south of {area:976}."] = "{npc:7771} стоит лагерем у дороги к месту {area:1336}, к югу от места {area:976}.",

	-- Step 9: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "Летите сюда: {area:541}",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Распорядитель полетов: {area:976}",

	-- Step 10: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:8737} Linken · {npc:9117} J.D. Collie
	["The flight lands at {area:541}: {npc:8737} stands by the cave a few steps from the flight master, {npc:9117} inside it."] = "",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}, под землей",
	-- {quest:3942} Linken's Memory · {npc:9116} Eridan Bluewind · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	-- was: ["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the next guide's way through {zone:1448}."] = "Сохраните задание {quest:3942}: {npc:9116} – здесь: {area:2479}, по пути следующего руководства через край {zone:1448}."
	["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the last guide's way through {zone:1448}."] = "",
	-- {item:12928} Umi's Mechanical Yeti · {npc:10977} Quixxil
	["Use {item:12928} on {npc:10977}"] = "",
	-- {npc:10977} Quixxil · {item:12928} Umi's Mechanical Yeti
	["Scare {npc:10977} with {item:12928}"] = "",

	-- Step 11: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus · {npc:13220} Layo Starstrike
	["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "Перевал из Ун'Горо выходит сюда: {area:3077} – кладбище на северо-востоке края {zone:1451}. {npc:13220} стоит среди могил.",

	-- Step 12: The Spirits of Southwind
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary · {npc:11801} Rabine Saturna
	["Ride south-west to the ruins of {area:2738}. The {object:179565} for {npc:11801} sits inside one of the ruined houses."] = "Езжайте на юго-запад к руинам ({area:2738}). {object:179565} для персонажа {npc:11801} – в одном из разрушенных домов.",

	-- Step 14: Cenarion Hold
	-- {area:3077} Valor's Rest · {npc:15189} Beetix Ficklespragg
	-- was: ["Ride west to the walled hold in the middle of the desert. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Езжайте на запад к обнесенной стеной крепости в центре пустыни. {npc:15189} стоит наверху в своем здании: поднимитесь внутри, Стрелка не различает этажи."
	["Ride west from {area:3077} to the walled hold in the middle of the desert. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 15: Calandrath
	-- {skill:185} Cooking · {npc:15174} Calandrath
	["Cooks with 285 {skill:185} or more: {npc:15174}, the innkeeper you just bound with, wants word of the Twilight's Hammer's sandworm recipe; the cookbook lies in the outpost west of the Hold, where this guide goes later."] = "",

	-- Step 16: Silithus: kill these as you meet them
	-- {zone:1451} Silithus
	["{zone:1451}: kill these as you meet them"] = "{zone:1451}: убивайте их по пути",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "Землечерпы, камнехвостые скорпиды и песчаные пауки-быстроноги бродят по пескам чуть к северу от крепости.",

	-- Step 17: Twilight Base Camp
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler · Whirling Invaders = {npc:14455} Whirling Invader
	-- was: ["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too. Careful: the biggest Rumblers and the Whirling Invaders are 58: pull them one at a time."] = "Светящиеся осколки табличек лежат вокруг лагеря Сумеречного Молота на дальнем северо-западе; они падают и с пылевихрей и пустынных грохотунов. Осторожно: самые крупные грохотуны и вертящиеся захватчики – 58-го уровня: выманивайте по одному."
	["The glowing tablet fragments lie on the ground around the Twilight camp in the far north-west: pick them up. The Dust Stormers and Desert Rumblers there may carry them too. Careful: the biggest Rumblers and the Whirling Invaders are 58: pull them one at a time."] = "",

	-- Step 18: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189} стоит наверху в своем здании: поднимитесь внутри, Стрелка не различает этажи.",

	-- Step 19: Hive in the Tower
	-- {item:17346} Encrusted Silithid Object
	-- plural, as words: Hive'Ashi Ambushers = {npc:13301} Hive'Ashi Ambusher
	["Back to Southwind and climb the tower. Stirring the hive at the top brings out Hive'Ashi Ambushers; one carries the {item:17346}."] = "Вернитесь в Южный Ветер и поднимитесь на башню. Если потревожить улей наверху, вылезут душители из улья Аши; у одного из них – {item:17346}.",
	-- {quest:8308} Brann Bronzebeard's Lost Letter · {area:2742} Hive'Ashi
	["{quest:8308}: now and then a {area:2742} silithid carries one; right-click it if it drops"] = "",
	-- {npc:15170} Rutgar Glyphshaper
	["for {npc:15170} at Bronzebeard's Encampment, later in this guide"] = "",

	-- Step 21: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride south-east to {area:3447} under the Un'Goro cliffs."] = "Езжайте на юго-восток сюда: {area:3447}, под скалами Ун'Горо.",
	["Below ground"] = "Под землей",
	-- {item:20377} Rock Stalker Fang · {npc:11739} Rock Stalker
	["{item:20377} from {npc:11739}, 130 yd south-west"] = "{item:20377} – с NPC {npc:11739}, в 130 м к юго-западу",

	-- Step 22: Dredge Crushers and Pincers
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Dredge Crushers and Pincers"] = "Земляные сокрушители и клешневики",
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer
	["Head north along the western dunes; Dredge Crushers and Stonelash Pincers range from here back toward the hold."] = "Двигайтесь на север вдоль западных дюн; земляные сокрушители и камнехвостые клешневики встречаются отсюда до крепости.",
	-- {npc:11741} Dredge Crusher · {area:2738} Southwind Village
	["{npc:11741} walks around {area:2738}: look inside the circle on the map"] = "{npc:11741} ходит по месту {area:2738}: ищите внутри круга на карте",

	-- Step 23: General Kirika
	-- {area:2744} Hive'Regal
	["Ride west to the Horde camp north of {area:2744}."] = "Езжайте на запад к лагерю Орды к северу от места {area:2744}.",

	-- Step 24: Scouring the Desert
	["Silithyst geysers erupt across the southern desert. Walk into the Silithyst one leaves behind and carry it to the Horde's Silithyst Extractor at Kirika's camp; fighting or mounting drops it."] = "Гейзеры силитиста извергаются по всей южной пустыне. Войдите в оставленный гейзером силитист и отнесите его к экстрактору Орды в лагере Кирики; в бою или верхом вы его теряете.",

	-- Step 25: Flayers and Rock Stalkers
	-- plural, as words: Rock Stalkers = {npc:11739} Rock Stalker
	["Flayers and Rock Stalkers"] = "Живодеры и скальные пауки-скакуны",
	-- plural, as words: Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker
	["Stonelash Flayers and Rock Stalkers roam the dunes south-west of Kirika's camp."] = "Камнехвостые живодеры и скальные пауки-скакуны бродят по дюнам к юго-западу от лагеря Кирики.",

	-- Step 26: Twilight Vanguard
	["Twilight Vanguard"] = "Авангард Сумеречного Молота",
	-- {npc:11803} Twilight Keeper Exeter · {item:20404} Encrypted Twilight Text · {npc:15306} Bor Wildmane
	["{npc:11803} walks the Vanguard camp in the far south-west. Keep every {item:20404} the cultists drop: {npc:15306} and Ortell want ten each later."] = "{npc:11803} бродит по лагерю авангарда на дальнем юго-западе. Сохраняйте каждый {item:20404}, который падает с культистов: позже {npc:15306} и Ортелл попросят по десять.",

	-- Step 28: Twilight Post
	-- {npc:15200} Twilight Keeper Mayna
	["{npc:15200} holds the camp in the west."] = "{npc:15200} занимает лагерь на западе.",

	-- Step 29: Twilight Outpost
	-- {npc:11804} Twilight Keeper Havunth · {area:3425} Cenarion Hold
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:11804} stands in the outpost west of {area:3425}. Keep any Encrypted Twilight Texts that drop here too."] = "{npc:11804} стоит на заставе к западу от места {area:3425}. Сохраняйте и зашифрованные сумеречные тексты, которые падают здесь.",

	-- Step 30: Sandy Cookbook
	-- {object:180503} Sandy Cookbook · {npc:15174} Calandrath
	["The {object:180503} lies in the outpost: read it and take its torn page back to {npc:15174}."] = "",

	-- Step 31: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg · {npc:15190} Noggle Ficklespragg
	["{npc:15189} and {npc:15190} stand upstairs in their building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189} и {npc:15190} стоят наверху в своем здании: поднимитесь внутри, Стрелка не различает этажи.",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}, on the west side of the Hold"] = "{npc:15306}, в западной части крепости",

	-- Step 32: Calandrath
	-- {npc:15174} Calandrath · {object:180503} Sandy Cookbook
	["{npc:15174}, the innkeeper, takes the {object:180503}'s torn page."] = "",

	-- Step 33: Wanted: Deathclasp
	-- {npc:15196} Deathclasp
	["Wanted: {npc:15196}"] = "",
	-- {npc:15196} Deathclasp · {npc:15190} Noggle Ficklespragg · {npc:15182} Vish Kozus
	["{npc:15196}, Terror of the Sands, is a level 59 elite scorpid patrolling the mountains by {npc:15190}'s satchel, at your level: a group choice. The wanted poster stands in the middle of the Hold; {npc:15182} pays out."] = "",

	-- Step 34: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride north-east to {area:3447}."] = "Езжайте на северо-восток сюда: {area:3447}.",

	-- Step 35: Noggle's Lost Satchel
	-- {npc:15196} Deathclasp
	-- was: ["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. Deathclasp, an elite scorpid, patrols near it: grab it while he is away."] = "Сумка лежит в горах на дальнем юге, за Лагерем Бронзоборода. Рядом патрулирует Смертехват, элитный скорпид: хватайте сумку, пока его нет."
	["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. {npc:15196}, an elite scorpid, patrols near it: grab it while he is away."] = "",

	-- Step 36: Deathclasp
	-- {npc:15196} Deathclasp
	["With your group: {npc:15196} walks the mountains around the satchel. Pull him away from the other scorpids."] = "",

	-- Step 37: Dearest Natalia
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper
	["{npc:15171} and {npc:15170} camp at Bronzebeard's Encampment, just north of the satchel's mountains. Question them: go through each one's whole conversation; there is no need to fight them."] = "",
	-- {npc:15170} Rutgar Glyphshaper
	["{npc:15170}, if Brann's letter dropped for you"] = "",

	-- Step 38: Twilight Base Camp
	-- {npc:15306} Bor Wildmane
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text · Twilight Avengers = {npc:11880} Twilight Avenger
	["Collect twenty Encrypted Twilight Texts from the cultists here, ten for {npc:15306} and ten for Ortell. Take them from the Twilight Avengers and Geolords; leave the Flamereavers and Stonecallers (59-60)."] = "Соберите двадцать зашифрованных Сумеречных текстов с культистов здесь: десять для NPC {npc:15306} и десять для Ортелла. Берите их с мстителей из культа Сумеречного Молота и геомантов; огненных жнецов и призывателей камня (59-60) не трогайте.",
	-- {npc:15306} Bor Wildmane
	["ten for each quest: {npc:15306} takes his ten before Ortell"] = "",

	-- Step 39: Twilight Base Camp
	["The spare texts from the cultists"] = "Лишние тексты с культистов",

	-- Step 40: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "Назад: {area:3425}",
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15190} стоит наверху в своем здании: поднимитесь внутри, Стрелка не различает этажи.",
	-- {area:2744} Hive'Regal
	["Mar'alith's next errand, Into the Maw of Madness, leads into {area:2744} among elites. Skip it."] = "Следующее поручение Мар'алита, «Into the Maw of Madness», ведет сюда: {area:2744}, к элите. Пропустите.",

	-- Step 41: Vish Kozus
	-- {npc:15182} Vish Kozus · {npc:15196} Deathclasp
	["{npc:15182}, Captain of the Guard, pays out for {npc:15196}'s pincer."] = "",

	-- Step 43: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus
	["Ride north-east to {area:3077}; you leave {zone:1451} through the pass beside it."] = "Езжайте на северо-восток сюда: {area:3077}; из края {zone:1451} вы уйдете через перевал рядом.",

	-- Step 45: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:9997} Spraggle Frock
	-- was: ["Through the pass and east along the northern cliffs to {area:541}. {npc:9997} stands beside the flight master."] = "Через перевал и на восток вдоль северных скал сюда: {area:541}. {npc:9997} стоит рядом с распорядителем полетов."
	["You missed this on the Un'Goro guide's loop: through the pass and east along the northern cliffs to {area:541}. {npc:9997} stands beside the flight master."] = "",

	-- Step 46: Krakle
	-- {npc:10302} Krakle · {area:543} Golakka Hot Springs
	["You missed this on the Un'Goro guide's loop: {npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "",

	-- Step 47: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer · {npc:10302} Krakle
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vent near the top, then ride back west to {npc:10302}."] = "Езжайте на восток сюда: {area:537}, поднимитесь и используйте предмет {npc:10541} у лавового жерла у вершины, затем возвращайтесь на запад к персонажу {npc:10302}.",

	-- Step 48: Krakle
	-- {npc:10302} Krakle · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{npc:10302} sends you to {npc:9298} in {zone:1452}: keep it."] = "{npc:10302} отправляет вас к персонажу {npc:9298} ({zone:1452}): сохраните задание.",

	-- Step 49: Bungle in the Jungle
	-- {quest:4496} Bungle in the Jungle · {area:976} Gadgetzan · {area:540} Slithering Scar · {area:537} Fire Plume Ridge · {item:11018} Un'Goro Soil
	["Only if you took {quest:4496} in {area:976} on the way here: the Gorishi of the {area:540}, south of {area:537}, drop the Scent Gland, and most of the crater's beasts and plants drop {item:11018}."] = "Только если по пути сюда вы взяли задание {quest:4496} в месте {area:976}: силитиды Гориши в месте {area:540}, к югу от места {area:537}, роняют пахучую железу, а большинство зверей и растений кратера – предмет {item:11018}.",

	-- Step 50: Pawn Captures Queen
	-- {item:11833} Gorishi Queen Lure · {area:540} Slithering Scar · {npc:10041} Gorishi Hive Queen
	["Use the {item:11833} where the arrow points, inside the Gorishi hive of the {area:540}, to call the {npc:10041} (level 56)."] = "",

	-- Step 51: Torwa Pathfinder
	-- {quest:4301} The Mighty U'cha · {area:541} Marshal's Refuge
	["{quest:4301}: his north-east cave is on your way back here from {area:541}"] = "",
	-- {npc:9684} Lar'korwi
	["Keep the bait for {npc:9684}'s lair, next (he is level 56)."] = "",

	-- Step 52: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder
	["{npc:9684}'s lair is just south of the pylon. Use {npc:9619}'s bait there; {npc:9684} is level 56 and hits hard, so start at full health."] = "Логово ({npc:9684}) – чуть к югу от пилона. Используйте там приманку {npc:9619}; {npc:9684} – 56-го уровня и бьет сильно, начинайте с полным здоровьем.",

	-- Step 53: Ringo
	-- {npc:9999} Ringo
	["{npc:9999} sits on the ridge, lost and exhausted."] = "{npc:9999} сидит на хребте, заблудившийся и обессиленный.",

	-- Step 54: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "Сопроводите NPC {npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "",

	-- Step 56: The Mighty U'cha
	-- {area:541} Marshal's Refuge · {npc:9622} U'cha · {npc:9619} Torwa Pathfinder
	["From {area:541} ride east to the cave in the crater's north-east corner: {npc:9622} (55) sits at its back among his gorillas, well under you now. Then south down the crater's east side to {npc:9619}."] = "",

	-- Step 58: Tanaris
	-- {npc:9619} Torwa Pathfinder · {area:541} Marshal's Refuge · {area:976} Gadgetzan
	["{npc:9619}'s corner has no flight master: ride north to {area:541} and fly to {area:976}."] = "",

	-- Step 59: Gadgetzan
	-- {quest:2741} The Super Egg-O-Matic · {area:976} Gadgetzan
	-- was: ["Fly to {area:976}. Still carrying {quest:2741}? The machine stands in the middle of town."] = "Летите сюда: {area:976}. Задание {quest:2741} еще при вас? Машина стоит в центре города."
	["Still carrying {quest:2741}? The machine stands in the middle of {area:976}."] = "",

	-- Step 62: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Летите сюда: {area:1637}",

	-- Step 63: Class trainer
	["Class trainer"] = "Учитель классовых навыков",

	-- Step 64: Paladin trainer
	["Paladin trainer"] = "",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{npc:246344} – здесь: {zone:1456}; в городе {zone:1454} нет учителя паладинов",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "Рваный свиток лежит у входа сюда: {area:2261} – склеп к югу от места {area:2260}.",
	-- ["Andorhal watchtowers and silos"] = "Сторожевые башни и силосы Андорала",
	-- ["Diseased Grizzlies"] = "Болезненные гризли",
	-- ["Dithers offers {item:14619} ({quest:838}). Skip it."] = "Дитерс предлагает {item:14619} ({quest:838}). Пропустите.",
	-- ["Dredge Strikers"] = "Землечерпы",
	-- ["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "Землечерпы, камнехвостые скорпиды и песчаные пауки-быстроноги бродят по пескам чуть к северу от крепости.",
	-- ["Dredge and scorpids"] = "Землечерпы и скорпиды",
	-- ["East along the road, {npc:11077} guards the cauldron at {area:200}."] = "На восток по дороге: {npc:11077} охраняет котел ({area:200}).",
	-- ["Fly to {area:1637} and train."] = "Летите сюда: {area:1637} и обучитесь.",
	-- ["Fly to {area:976}. Still carrying {quest:2741}? The machine stands in the middle of town."] = "Летите сюда: {area:976}. Задание {quest:2741} еще при вас? Машина стоит в центре города.",
	-- ["Fly to {area:976}. The {object:142071} stands in the middle of town."] = "Летите сюда: {area:976}. {object:142071} стоит в центре города.",
	-- ["From the zeppelin tower ride east along the road to the {area:152}, on the way into the {zone:1422}."] = "От башни дирижаблей езжайте на восток по дороге сюда: {area:152}, по пути в {zone:1422}.",
	-- ["Hameya's mound"] = "Курган Хамейи",
	-- ["Hameya's scroll"] = "Свиток Хамейи",
	-- ["Into {zone:1422}"] = "В зону {zone:1422}",
	-- ["Into {zone:1423}"] = "В зону {zone:1423}",
	-- ["Keep the bait: {npc:9684} is level 56, and the second loop passes his lair."] = "Сохраните приманку: {npc:9684} – 56-го уровня, а второй круг проходит мимо его логова.",
	-- ["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the next guide's way through {zone:1448}."] = "Сохраните задание {quest:3942}: {npc:9116} – здесь: {area:2479}, по пути следующего руководства через край {zone:1448}.",
	-- ["Knights and magi work the {area:192}; the medics and hunters camp south of it. Set {npc:11615}'s termite barrel down in the middle of the lumber mill while you are there.\nCareful: a {npc:10996}, a level 58-59 elite, can stand at the lumber camp, as at many other spots of the {zone:1422}: give it room."] = "Рыцари и маги работают здесь: {area:192}; лекари и охотники стоят лагерем к югу. Заодно поставьте бочонок с термитами от NPC {npc:11615} в центре лесопилки.\nОсторожно: {npc:10996}, элита 58-59-го уровня, может стоять у лесопилки, как и во многих других местах зоны {zone:1422}: держитесь подальше.",
	-- ["Level 57"] = "Уровень 57",
	-- ["Mark {npc:10902} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10902}",
	-- ["Mark {npc:10903} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10903}",
	-- ["Mark {npc:10904} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10904}",
	-- ["Mark {npc:10905} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10905}",
	-- ["Pamela and the {area:2261}"] = "Памела и {area:2261}",
	-- ["Radley and Durgen"] = "Рэдли и Дурген",
	-- ["Ride east across the plaguelands to the chapel."] = "Езжайте на восток через Чумные земли к часовне.",
	-- ["Ride east along the road to the {area:152} on the border."] = "Езжайте на восток по дороге к {area:152} на границе.",
	-- ["Ride east to {npc:1855}'s hut by the {area:2619} and hear him out."] = "Езжайте на восток к хижине {npc:1855} у места {area:2619} и выслушайте его.",
	-- ["Ride north-east to {area:2276} by {area:2275}: the high elf Rangers, Pathstriders and Woodsmen guard it and the Registry lies inside. Careful: the Pathstriders are 57-58 but the Rangers reach 60: pull one at a time and take the Rangers last."] = "Езжайте на северо-восток сюда: {area:2276}, у места {area:2275}. Его охраняют высшие эльфы – следопыты, разведчицы дорог и лесники, а реестр лежит внутри. Осторожно: разведчицы 57-58-го уровня, но следопыты доходят до 60-го: притягивайте по одному, следопытов оставьте напоследок.",
	-- ["Ride north-west to {npc:1855}'s hut."] = "Езжайте на северо-запад к хижине {npc:1855}.",
	-- ["Ride south into Andorhal. {npc:10667} waits in the ruined inn on the west side of town. Stand in the doorway of each of the four towers with the {item:12815} to mark it; keep to the edges of town. Use the {item:12627} by the silos in the middle of town to bring out Temporal Parasites."] = "Езжайте на юг в Андорал. {npc:10667} ждет в разрушенной таверне в западной части города. Встаньте в дверях каждой из четырех башен с предметом {item:12815}, чтобы отметить ее; держитесь окраин города. Используйте предмет {item:12627} у силосов в центре города, чтобы выманить временных паразитов.",
	-- ["Ride south-east from {npc:1855} to the {area:2260} farmhouse."] = "Езжайте на юго-восток от NPC {npc:1855} к ферме: {area:2260}.",
	-- ["Ride south-west to {npc:10667} in Andorhal."] = "Езжайте на юго-запад к персонажу {npc:10667} в Андорал.",
	-- ["Ride to {area:2262} in the south-west; Pamela plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "Езжайте сюда: {area:2262}, на юго-запад; Памела играет среди домов. {npc:11886} прячется здесь: {area:2261} – склеп чуть к западу от города.\nОсторожно: вместе с Меркуцио появляются около четырех неэлитных помощников. Они идут к могиле, а не появляются на месте.",
	-- ["Ride west to the walled hold in the middle of the desert."] = "Езжайте на запад к обнесенной стеной крепости в центре пустыни.",
	-- ["Ride west to the walled hold in the middle of the desert. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Езжайте на запад к обнесенной стеной крепости в центре пустыни. {npc:15189} стоит наверху в своем здании: поднимитесь внутри, Стрелка не различает этажи.",
	-- ["Scarlet Crusade"] = "Алый орден",
	-- ["Scourge Champions"] = "Воители Плети",
	-- ["Scourge Champions roam the {area:2270}, north of the chapel. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants."] = "Воители Плети бродят здесь: {area:2270}, к северу от часовни. Проведите предметом {npc:11063} ({item:13156}) над каждым убитым: нужны черепа, которые отзываются.",
	-- ["Take the zeppelin from the tower outside {area:1637} to {zone:1420} and ride into the {zone:1458}. Lady Sylvanas holds the {object:36126}."] = "Садитесь на дирижабль с башни у города {area:1637} в край {zone:1420} и езжайте в город {zone:1458}. Леди Сильвана – здесь: {object:36126}.",
	-- ["The Dredge Crushers (57-58) of the south-east are two over you below 57. First top up to 57 on the Dredge Strikers (55-56) on the sands east of {area:3425}, where Sand Skitterers and Stonelash Scorpids (54-56) roam among them, away from the Silithid Darters of the northern sands. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "Земляные сокрушители (57-58) на юго-востоке на два уровня выше вас, если вы ниже 57-го. Сначала доберите 57-й уровень на землечерпах (55-56) в песках к востоку от места {area:3425}, где среди них бродят песчаные пауки-быстроноги и камнехвостые скорпиды (54-56), подальше от силитидов-стрелков северных песков. Или пройдите с группой подземелье {area:1583} (нижнюю часть) или подземелье {quest:838}.",
	-- ["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too."] = "Светящиеся осколки табличек лежат вокруг лагеря Сумеречного Молота на дальнем северо-западе; они падают и с пылевихрей и пустынных грохотунов.",
	-- ["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too. Careful: the biggest Rumblers and the Whirling Invaders are 58: pull them one at a time."] = "Светящиеся осколки табличек лежат вокруг лагеря Сумеречного Молота на дальнем северо-западе; они падают и с пылевихрей и пустынных грохотунов. Осторожно: самые крупные грохотуны и вертящиеся захватчики – 58-го уровня: выманивайте по одному.",
	-- ["The libram lies further north, on the way to {area:190}."] = "Либрам лежит дальше к северу, по пути к месту {area:190}.",
	-- ["The lockboxes sit in Andorhal's ruined houses around {npc:10667}'s inn. Careful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "Сундучки стоят в разрушенных домах Андорала вокруг таверны, где находится {npc:10667}. Осторожно: рядом с сундучками обычно стоят вурдалаки и скелеты, они нападают, когда вы подходите. Обжигающие вурдалаки также ранят всех поблизости и выводят из незаметности.",
	-- ["The lumber mill is right beside Radley: set {npc:11615}'s termite barrel down in the middle of it."] = "Лесопилка – прямо рядом с Рэдли: поставьте бочку с термитами ({npc:11615}) в ее центре.",
	-- ["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. Deathclasp, an elite scorpid, patrols near it: grab it while he is away."] = "Сумка лежит в горах на дальнем юге, за Лагерем Бронзоборода. Рядом патрулирует Смертехват, элитный скорпид: хватайте сумку, пока его нет.",
	-- ["The shield lies at {area:201}, south of {npc:1855}'s hut."] = "Щит лежит здесь: {area:201}, к югу от хижины {npc:1855}.",
	-- ["The wooden sign beside {npc:9997}"] = "Деревянная табличка рядом с NPC {npc:9997}",
	-- ["The {object:177675} is just behind the {area:2261}."] = "{object:177675} – сразу за местом {area:2261}.",
	-- ["The {object:177675} is just south, behind the {area:2261}."] = "{object:177675} – чуть южнее, за местом {area:2261}.",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:11897} is a level 60 elite: skip it if you are alone."] = "Это элитные противники: лучше собрать группу, поищите напарников. {npc:11897} – элита 60-го уровня: если вы один, пропустите.",
	-- ["Through the pass and east along the northern cliffs to {area:541}. {npc:9997} stands beside the flight master."] = "Через перевал и на восток вдоль северных скал сюда: {area:541}. {npc:9997} стоит рядом с распорядителем полетов.",
	-- ["Top up here to level 58 before Ortell's Rock Stalkers (57-59) and the south; {npc:15181}'s {quest:8304}, back at {area:3425}, needs level 58 too. The Dredge Crushers (57-58) on the way south-east are the ones {npc:15191} wants: leave the Twilight cultists around them be. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "Доберите здесь 58-й уровень, прежде чем идти к скальным паукам-скакунам Ортелла (57-59) и на юг; задание {quest:8304} от NPC {npc:15181} в месте {area:3425} тоже требует 58-го уровня. Земляные сокрушители (57-58) по пути на юго-восток – те, что нужны NPC {npc:15191}: сумеречных культистов вокруг не трогайте. Или пройдите с группой подземелье {area:1583} (нижнюю часть) или подземелье {quest:838}.",
	-- ["Underwater"] = "Под водой",
	-- ["Upstairs"] = "Наверху",
	-- ["Use {npc:10980} on {npc:10977}"] = "Используйте игрушку {npc:10980} на персонаже {npc:10977}",
	-- ["West to the {area:152}. The next guide starts in the {zone:1458}, a short ride west."] = "На запад к {area:152}. Следующее руководство начинается здесь: {zone:1458}, недалеко к западу.",
	-- ["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "Вы пропустили это при прошлом посещении этих мест по маршруту: теперь это идёт первым. Это быстро и открывает следующие задания.",
	-- ["Zeppelin to {zone:1458}"] = "Дирижабль: {zone:1458}",
	-- ["grind on {npc:11740}"] = "убивайте: {npc:11740}",
	-- ["grind on {npc:11741}"] = "убивайте цель {npc:11741}",
	-- ["{item:20375} on the way"] = "{item:20375} по пути",
	-- ["{npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "Гоблин {npc:10302} сидит здесь: {area:543}, чуть к востоку от пилона.",
	-- ["{npc:10667}'s Battle of Darrowshire ends against elites. Skip it."] = "Битва за Дарроушир ({npc:10667}) заканчивается боем с элитой. Пропустите.",
	-- ["{npc:10667}, upstairs"] = "{npc:10667}, наверху",
	-- ["{npc:10739} camps by the {area:202}, beside the cauldron; his bears roam the hills north and east of it, on the way to {area:201}."] = "{npc:10739} стоит лагерем у места {area:202}, рядом с котлом; его медведи бродят по холмам к северу и востоку, по пути сюда: {area:201}.",
	-- ["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field."] = "Ферма ({npc:10778}) – первая к востоку от {area:152}. У болтливых вурдалаков на ферме – вторая половина ее талисмана; {npc:11075} охраняет котел в поле.",
	-- ["{npc:10926}'s own errand is not on this route. Skip it."] = "Поручение самой {npc:10926} не входит в маршрут. Пропустите.",
	-- ["{npc:11610} hides on the hill north-east of the {area:192}."] = "{npc:11610} прячется на холме к северо-востоку от места {area:192}.",
	-- ["{npc:11878}' errands are not on this route. Skip them."] = "Поручения {npc:11878} не входят в маршрут. Пропустите.",
	-- ["{npc:15181}'s {quest:8304}, at {area:3425}, needs level 58: top up on the Dredge Crushers (57-58) west of the outpost, and leave the Twilight Avengers, Geolords and Stonecallers (57-61) around them be. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "Заданию {quest:8304} ({npc:15181}, {area:3425}) нужен 58-й уровень: доберите его на земляных сокрушителях (57-58) к западу от заставы и не трогайте Twilight Avengers, Geolords и Stonecallers (57-61) вокруг них. Или, с группой, пройдите вместо этого подземелье {area:1583} (нижняя часть) или подземелье {quest:838}.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "Защитник ({npc:15193}) занимает дом на ферме ({area:2260}) к северу от места {area:2261}.",
	-- ["{npc:15306}, on the west side of the Hold"] = "{npc:15306}, в западной части крепости",
	-- ["{npc:1852} (61, elite) stands in the middle of Andorhal among Skeletal Warlords (56-57, elite): kill him with your group, then take the shard from {object:177241} there."] = "{npc:1852} (61, элитный) стоит в центре Андорала среди скелетов-полководцев (56-57, элитные): убейте его с группой, затем заберите осколок из объекта {object:177241} там же.",
	-- ["{npc:1855}'s next task, Of Lost Honor, is not on this route. Skip it."] = "Следующее задание {npc:1855}, о потерянной чести, не входит в маршрут. Пропустите.",
	-- ["{npc:8565} walks around {area:2276}: look inside the circle on the map"] = "{npc:8565} ходит по месту {area:2276}: ищите внутри круга на карте",
	-- ["{npc:9619} now asks for {npc:9622}'s pelt, back in the north-east cave: skip it."] = "Теперь {npc:9619} просит шкуру ({npc:9622}) из северо-восточной пещеры: пропустите.",
	-- ["{quest:105}'s shard lies at {npc:1852}'s feet, in the middle of Andorhal: he is a level 61 elite with elite Skeletal Warlords about him, a fight for a group."] = "Осколок для задания {quest:105} лежит у ног NPC {npc:1852} в центре Андорала: это элитный противник 61-го уровня, вокруг него элитные скелеты-полководцы – бой для группы.",
}
