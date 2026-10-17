-- Russian (ruRU): the guide forever/reputation/warsong-gulch (forever/reputation/warsong-gulch.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Warsong Gulch Reputation"] = "Репутация: Ущелье Песни Войны",

	-- Step 1: Silverwing Sentinels to Friendly
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Friendly"] = "{faction:890} до уровня «Дружелюбие»",
	-- {faction:890} Silverwing Sentinels · {zone:1460} Warsong Gulch
	["The {faction:890} are the Night Elves holding {zone:1460}. Their reputation comes from the battleground: every enemy flag your team captures pays it to the whole team. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:890} – ночные эльфы, удерживающие {zone:1460}. Репутацию дает поле боя: каждый захваченный командой вражеский флаг приносит ее всей команде. Встаньте в очередь у любого военачальника поля боя. Бонус наследия Forever «Дипломат» ускоряет рост репутации.",
	-- {npc:14733} Sentinel Farsong
	["{npc:14733} takes Warsong Gulch Marks of Honor for Vanquish the Invaders!, once per level bracket (data); check them live."] = "{npc:14733} принимает почетные знаки Ущелья Песни Войны за задание «Долой захватчиков!», по разу на диапазон уровней (по данным); проверьте в игре.",

	-- Step 2: Silverwing Sentinels to Honored
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Honored"] = "{faction:890} до уровня «Уважение»",
	-- {zone:1460} Warsong Gulch · {npc:15351} Alliance Brigadier General
	["Keep playing {zone:1460} and capturing flags. On Call to Arms: {zone:1460} weekends the {npc:15351} in the capitals takes three Warsong Gulch Marks of Honor for extra reputation."] = "Продолжайте играть ({zone:1460}) и захватывать флаги. В выходные «К оружию!» ({zone:1460}) {npc:15351} в столицах принимает три почетных знака Ущелья Песни Войны за дополнительную репутацию.",
	-- {npc:14753} Illiyana Moonblaze
	["{npc:14753} hands out one Sentinel care package by level"] = "{npc:14753} выдает по одному набору припасов часовых за уровень",

	-- Step 3: Silverwing Sentinels to Revered
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Revered"] = "{faction:890} до уровня «Почтение»",
	-- {zone:1460} Warsong Gulch
	["Keep capturing flags in {zone:1460}."] = "Продолжайте захватывать флаги: {zone:1460}.",

	-- Step 4: Silverwing Sentinels to Exalted
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Exalted"] = "{faction:890} до уровня «Превознесение»",
	-- {faction:890} Silverwing Sentinels
	["Exalted with the {faction:890} earns a Legacy Point."] = "Превознесение у фракции {faction:890} дает очко наследия.",

	-- Step 5: Warsong Outriders to Friendly
	-- {faction:889} Warsong Outriders
	["{faction:889} to Friendly"] = "{faction:889} до уровня «Дружелюбие»",
	-- {faction:889} Warsong Outriders · {zone:1440} Ashenvale
	["The {faction:889} are the Orcs logging {zone:1440}. Their reputation comes from the battleground: every enemy flag your team captures pays it to the whole team. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:889} – орки, вырубающие лес (зона {zone:1440}). Репутацию дает поле боя: каждый захваченный командой вражеский флаг приносит ее всей команде. Встаньте в очередь у любого военачальника поля боя. Бонус наследия Forever «Дипломат» ускоряет рост репутации.",
	-- {npc:14781} Captain Shatterskull
	["{npc:14781} takes Warsong Gulch Marks of Honor for Quell the Silverwing Usurpers, once per level bracket (data); check them live."] = "{npc:14781} принимает почетные знаки Ущелья Песни Войны за задание «Громи захватчиков-Среброкрылых!», по разу на диапазон уровней (по данным); проверьте в игре.",

	-- Step 6: Warsong Outriders to Honored
	-- {faction:889} Warsong Outriders
	["{faction:889} to Honored"] = "{faction:889} до уровня «Уважение»",
	-- {zone:1460} Warsong Gulch · {npc:15350} Horde Warbringer
	["Keep playing {zone:1460} and capturing flags. On Call to Arms: {zone:1460} weekends the {npc:15350} in the capitals takes three Warsong Gulch Marks of Honor for extra reputation."] = "Продолжайте играть ({zone:1460}) и захватывать флаги. В выходные «К оружию!» ({zone:1460}) {npc:15350} в столицах принимает три почетных знака Ущелья Песни Войны за дополнительную репутацию.",
	-- {npc:14754} Kelm Hargunth
	["{npc:14754} hands out one Outrider care package by level"] = "{npc:14754} выдает по одному набору припасов Всадников за уровень",

	-- Step 7: Warsong Outriders to Revered
	-- {faction:889} Warsong Outriders
	["{faction:889} to Revered"] = "{faction:889} до уровня «Почтение»",

	-- Step 8: Warsong Outriders to Exalted
	-- {faction:889} Warsong Outriders
	["{faction:889} to Exalted"] = "{faction:889} до уровня «Превознесение»",
	-- {faction:889} Warsong Outriders
	["Exalted with the {faction:889} earns a Legacy Point."] = "Превознесение у фракции {faction:889} дает очко наследия.",
}
