-- Russian (ruRU): the guide forever/class/warlock/incubus-horde (forever/class/warlock/incubus-horde.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Incubus (Horde)"] = "Инкуб (Орда)",
	["A second seducer demon, the male sayaad, and a soul shard bag to carry your shards."] = "Второй демон-соблазнитель – саяад мужского пола, а также сумка для осколков душ.",

	-- Step 1: Devourer of Souls (Orgrimmar)
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {npc:5909} Cazul · {npc:5675} Carendin Halgar · {zone:1458} Undercity · {quest:1472} Devourer of Souls
	["At 20 {npc:5875}, in the {object:172960} under the {object:172982}, sends you to {npc:5909} a few steps away. Two trainers offer the incubus, {npc:5875} here and {npc:5675} in the {zone:1458}, and you can take only one: this guide follows whichever {quest:1472} you took."] = "На 20-м уровне {npc:5875} ({object:172960} под районом {object:172982}) отправит вас в нескольких шагах отсюда: {npc:5909}. Инкуба предлагают два учителя – {npc:5875} здесь и {npc:5675} ({zone:1458}), – и можно взять только одно задание: гайд следует тому {quest:1472}, которое вы взяли.",

	-- Step 2: Magar
	-- {npc:3363} Magar · {object:173018} Magar's Cloth Goods · {object:172960} Cleft of Shadow
	["{npc:3363} keeps {object:173018}, east of the {object:172960} along the main street. He asks you to look for his mate, Krilge."] = "{npc:3363} держит {object:173018} к востоку от места {object:172960} на главной улице. Он просит найти его подругу Krilge.",

	-- Step 3: Fallen Sky Lake
	-- {area:422} Fallen Sky Lake · {zone:1440} Ashenvale · {area:431} Splintertree Post · {item:190232} Withered Scarf
	["{area:422} lies in southern {zone:1440}, south of {area:431}. The Shadethicket bog beasts around the lake drop the {item:190232}, about one in twenty."] = "{area:422} – на юге зоны {zone:1440}, к югу от места {area:431}. {item:190232} падает с чащобных болотных зверей вокруг озера, примерно в одном случае из двадцати.",

	-- Step 4: The Binding (Orgrimmar)
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {npc:3216} Neeru Fireblade
	["Back to {npc:5875} in the {object:172960}. Take the scarf to the summoning circle in {npc:3216}'s tent nearby and defeat the incubus it calls."] = "Назад к {npc:5875} ({object:172960}). Отнесите шарф к кругу призыва в палатке рядом (хозяин: {npc:3216}) и победите призванного инкуба.",
	-- {npc:5875} Gan'rul Bloodeye
	["{npc:5875}: he binds the incubus to you"] = "{npc:5875}: он привяжет к вам инкуба",

	-- Step 5: Devourer of Souls (Undercity)
	-- {object:1661} The Undercity · {npc:5675} Carendin Halgar · {quest:1472} Devourer of Souls · {npc:5875} Gan'rul Bloodeye · {object:36082} Magic Quarter · {npc:5693} Godrick Farsan
	["{object:1661}'s version, for warlocks who took {npc:5675}'s {quest:1472} instead of {npc:5875}'s. At 20 {npc:5675}, in the {object:36082}, sends you to {npc:5693} in the Temple of the Damned, just north of him."] = "Вариант для {object:1661} – для чернокнижников, взявших {quest:1472} у NPC {npc:5675}, а не у {npc:5875}. На 20-м уровне {npc:5675} ({object:36082}) отправит вас в Храм Проклятых, чуть севернее. Цель: {npc:5693}.",

	-- Step 6: Avelina Lilly
	-- {npc:185333} Avelina Lilly · {area:279} Dalaran · {area:233} Ambermill · {zone:1421} Silverpine Forest
	["{npc:185333} works as a tailor for the {area:279} wizards at {area:233}, in eastern {zone:1421}. Take her heart."] = "{npc:185333} работает портнихой у волшебников ({area:279}) здесь: {area:233}, восток зоны {zone:1421}. Заберите ее сердце.",

	-- Step 7: Isaac Pearson
	-- {npc:185334} Isaac Pearson · {area:392} Ratchet · {zone:1413} Barrens · {zone:1411} Durotar
	["{npc:185334} works in {area:392}, on the {zone:1413} coast. Take the zeppelin to {zone:1411} and ride or fly on to {area:392}."] = "{npc:185334} работает здесь: {area:392}, на побережье зоны {zone:1413}. Сядьте на дирижабль в зону {zone:1411}, затем езжайте или летите дальше. Цель: {area:392}.",

	-- Step 8: The Binding (Undercity)
	-- {npc:5675} Carendin Halgar · {object:36082} Magic Quarter
	["Back to {npc:5675} in the {object:36082}. Place the hearts at the summoning circle below him and defeat the incubus they call."] = "Назад к {npc:5675} ({object:36082}). Положите сердца у круга призыва под ним и победите призванного инкуба.",
	-- {npc:5675} Carendin Halgar
	["{npc:5675}: he binds the incubus to you"] = "{npc:5675}: он привяжет к вам инкуба",
}
