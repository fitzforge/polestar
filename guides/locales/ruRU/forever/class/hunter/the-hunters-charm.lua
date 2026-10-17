-- Russian (ruRU): the guide forever/class/hunter/the-hunters-charm (forever/class/hunter/the-hunters-charm.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1447} Azshara · {area:1417} Sunken Temple
	["Experience at 50 through {zone:1447} and the {area:1417}; Forever removed the Classic item choice."] = "Опыт на 50-м уровне: {zone:1447} и {area:1417}; в Forever убрали выбор предмета из Classic.",
	["Experience"] = "Опыт",

	-- Step 1: The Hunter's Charm (Alliance)
	-- {quest:8151} The Hunter's Charm
	["{quest:8151} (Alliance)"] = "{quest:8151} (Альянс)",
	-- {npc:5516} Ulfir Ironbeard · {zone:1453} Stormwind · {object:28027} Dwarven District · {npc:5116} Olmin Burningbeard · {zone:1455} Ironforge · {object:32390} Hall of Arms · {zone:1457} Darnassus
	["At 50 any Alliance hunter trainer offers it: {npc:5516} in {zone:1453}'s {object:28027}, {npc:5116} in {zone:1455}'s {object:32390} or Dorion in {zone:1457}' Cenarion Enclave."] = "На 50-м уровне его дает любой учитель охотников Альянса: {npc:5516} ({zone:1453}, {object:28027}), {npc:5116} ({zone:1455}, {object:32390}) или Дорион ({zone:1457}, Анклав Кенария).",

	-- Step 2: The Hunter's Charm (Horde)
	-- {quest:8151} The Hunter's Charm
	["{quest:8151} (Horde)"] = "{quest:8151} (Орда)",
	-- {npc:3352} Ormak Grimshot · {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {npc:3039} Holt Thunderhorn · {area:1641} Hunter Rise · {zone:1456} Thunder Bluff
	["At 50 any Horde hunter trainer offers it: {npc:3352} in {zone:1454}'s {object:172958} or {npc:3039} on {area:1641} in {zone:1456}."] = "На 50-м уровне его дает любой учитель охотников Орды: {npc:3352} ({zone:1454}, {object:172958}) или {npc:3039} ({area:1641}, {zone:1456}).",

	-- Step 3: Ogtinc
	-- {npc:8405} Ogtinc · {area:1221} Ruins of Eldarath · {area:3137} Talrendis Point · {area:1237} Valormok
	["{npc:8405} lives atop the cliffs north-east of the {area:1221}. Alliance: fly to {area:3137}; Horde: fly to {area:1237}."] = "{npc:8405} живет на вершине утесов к северо-востоку от места {area:1221}. Альянс: летите сюда: {area:3137}; Орда: летите сюда: {area:1237}.",

	-- Step 4: Courser Antlers
	-- {zone:1447} Azshara
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser · Perfect Courser Antlers = {item:20017} Perfect Courser Antler
	["Mosshoof Coursers graze all over {zone:1447}; one in a dozen or so drops a pair of Perfect Courser Antlers."] = "Мохоногие олени пасутся по всей зоне {zone:1447}; примерно с одного из дюжины падает пара великолепных рогов бегового оленя.",

	-- Step 6: Wavethrashing
	-- {zone:1447} Azshara
	-- plural, as words: Young Wavethrashers = {npc:6347} Young Wavethrasher · Great Wavethrashers = {npc:6349} Great Wavethrasher
	["Wavethrashers crawl along {zone:1447}'s coasts: Young Wavethrashers on the north-east shore and Wavethrashers on the east coast drop the scales about twice as often as the Great Wavethrashers of the south shore."] = "Волношлепы ползают по побережьям зоны {zone:1447}: молодые волношлепы на северо-восточном берегу и волношлепы на восточном побережье оставляют чешую примерно вдвое чаще, чем большие волношлепы южного берега.",

	-- Step 8: Morphaz in the Sunken Temple
	-- {area:1417} Sunken Temple
	["Morphaz in the {area:1417}"] = "Морфаз. Локация: {area:1417}",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears · {area:75} Stonard · {area:42} Darkshire · {area:1438} Nethergarde Keep
	["Morphaz is an elite dragon boss inside the {area:1417}, a five-player dungeon: bring a group. The temple stands in the middle of the {area:74}; swim down into it to reach the entrance. Horde: fly to {area:75}; Alliance: fly to {area:42} or {area:1438} and ride on."] = "Морфаз — элитный босс-дракон внутри подземелья {area:1417} для пяти игроков: возьмите группу. Храм стоит посреди места {area:74}; нырните в него, чтобы добраться до входа. Орда: летите сюда: {area:75}; Альянс: летите сюда: {area:42} или {area:1438}, а дальше верхом.",
	-- {item:20019} Tooth of Morphaz · {area:1417} Sunken Temple
	["{item:20019}, inside the {area:1417}"] = "{item:20019}, внутри подземелья {area:1417}",
}
