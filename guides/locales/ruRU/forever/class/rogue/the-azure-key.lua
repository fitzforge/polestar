-- Russian (ruRU): the guide forever/class/rogue/the-azure-key (forever/class/rogue/the-azure-key.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ravenholdt reputation and experience at 50; Forever removed the Classic item choice."] = "Репутация у Черного Ворона и опыт на 50-м уровне; Forever убрал выбор предмета из Classic.",
	["Ravenholdt reputation"] = "Репутация у Черного Ворона",

	-- Step 1: A Simple Request (Alliance)
	-- {quest:8233} A Simple Request
	["{quest:8233} (Alliance)"] = "{quest:8233} (Альянс)",
	-- {npc:918} Osborne the Night Man · {zone:1453} Stormwind · {object:2100} Old Town · {zone:1457} Darnassus · {npc:5165} Hulfdan Blackbeard · {zone:1455} Ironforge
	["At 50 {npc:918} in {zone:1453}'s {object:2100} has it; so do Syurna in {zone:1457} and {npc:5165} and Fenthwick in {zone:1455}."] = "На 50-м уровне его дает {npc:918} ({zone:1453}, {object:2100}); а также Сиарна ({zone:1457}), {npc:5165} и Иззаспинс ({zone:1455}).",

	-- Step 2: A Simple Request (Horde)
	-- {quest:8233} A Simple Request
	["{quest:8233} (Horde)"] = "{quest:8233} (Орда)",
	-- {npc:3328} Ormok · {object:172960} Cleft of Shadow · {npc:4583} Miles Dexter · {zone:1458} Undercity · {object:36073} Rogues' Quarter
	["At 50 {npc:3328} in the {object:172960} has it; so does {npc:4583} in the {zone:1458}'s {object:36073}."] = "На 50-м уровне его дает {npc:3328} ({object:172960}); а также {npc:4583} ({zone:1458}, {object:36073}).",

	-- Step 3: Lord Jorach Ravenholdt
	-- {area:3486} Ravenholdt Manor · {area:272} Tarren Mill · {zone:1416} Alterac Mountains · {area:271} Southshore
	["{area:3486} hides in the hills east of {area:272}, up a path into the {zone:1416}. Horde fly to {area:272}, Alliance to {area:271}."] = "{area:3486} скрыто в холмах к востоку от места {area:272}, вверх по тропе в зону {zone:1416}. Орда летит сюда: {area:272}, Альянс – сюда: {area:271}.",

	-- Step 4: Sealed Azure Bag
	-- {area:3137} Talrendis Point · {area:1237} Valormok · {zone:1447} Azshara
	-- plural, as words: Timbermaw Shamans = {npc:6188} Timbermaw Shaman
	["Alliance fly to {area:3137}, Horde to {area:1237}. The Timbermaw Shamans in {zone:1447}'s northern hills drop the bag, about one in thirty."] = "Альянс летит сюда: {area:3137}, Орда – сюда: {area:1237}. Сумка падает с шаманов из племени Древобрюхов в северных холмах ({zone:1447}), примерно с одного из тридцати.",

	-- Step 6: Encoded Fragments
	-- {zone:1447} Azshara
	-- plural, as words: Forest Oozes = {npc:8766} Forest Ooze
	["The Forest Oozes of southern {zone:1447} drop the fragments."] = "Фрагменты падают с лесных слизнюков на юге зоны {zone:1447}.",

	-- Step 7: Back to Xylem
	["Back to Xylem"] = "Назад к Ксилему",

	-- Step 8: Morphaz in the Sunken Temple
	-- {area:1417} Sunken Temple
	["Morphaz in the {area:1417}"] = "Морфаз: {area:1417}",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears · {area:75} Stonard · {area:1438} Nethergarde Keep
	["Morphaz, a green drake, is an elite boss deep in the {area:1417}, a level 50 dungeon: bring a group of five. The temple stands in the {area:74}; swim down to the entrance. Horde: fly to {area:75}; Alliance: fly to {area:1438} and ride on."] = "Морфаз, зеленый дракон, – элитный босс в глубине подземелья 50-го уровня ({area:1417}): возьмите группу из пяти человек. Храм стоит здесь: {area:74}; спуститесь вплавь ко входу. Орда: летите сюда: {area:75}; Альянс: летите сюда: {area:1438} – и езжайте дальше.",
	-- {item:20022} Azure Key
	["{item:20022}: Morphaz, inside the temple"] = "{item:20022}: Морфаз, внутри храма",

	-- Step 9: Lord Ravenholdt
	["Lord Ravenholdt"] = "Лорд Черный Ворон",
	-- {npc:6768} Lord Jorach Ravenholdt
	["{npc:6768}: no item choices in Forever"] = "{npc:6768}: в Forever выбора предмета нет",
}
