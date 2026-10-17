-- Russian (ruRU): the guide forever/class/rogue/ravenholdt (forever/class/rogue/ravenholdt.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:3486} Ravenholdt Manor
	["Opens {area:3486}, the hidden rogue house in the Alterac hills, and its first jobs."] = "Открывает {area:3486} – тайный дом разбойников в холмах Альтерака – и первые поручения.",
	-- {npc:13936} Ravenholdt
	["{npc:13936} reputation"] = "Репутация: {npc:13936}",

	-- Step 1: The Elegant Letter
	-- {item:17126} Elegant Letter
	["The {item:17126}"] = "{item:17126}",
	-- {item:17126} Elegant Letter · {npc:13936} Ravenholdt · {npc:332} Master Mathias Shaw · {npc:918} Osborne the Night Man · {zone:1453} Stormwind · {zone:1454} Orgrimmar · {item:17125} Seal of Ravenholdt · {npc:6707} Fahrad
	["At 24 an {item:17126} from {npc:13936} starts this; the data gives it to you through {npc:332} or {npc:918} in {zone:1453}, or Gest or Ormok in {zone:1454}. The quest hands you the {item:17125} for {npc:6707}."] = "На 24-м уровне все начинается с предмета {item:17126} ({npc:13936}); по данным его вручает {npc:332} или {npc:918} ({zone:1453}), либо Гест или Ормок ({zone:1454}). Задание дает вам {item:17125} для персонажа {npc:6707}.",

	-- Step 2: Ravenholdt Manor
	-- {area:272} Tarren Mill · {area:271} Southshore · {zone:1416} Alterac Mountains
	["Horde fly to {area:272}, Alliance to {area:271}. The manor hides in the hills east of {area:272}, up a path into the {zone:1416}; the Rite of Cunning is passing its way in."] = "Орда летит сюда: {area:272}, Альянс – сюда: {area:271}. Поместье скрыто в холмах к востоку от места {area:272}, вверх по тропе в зону {zone:1416}; чтобы войти, пройдите обряд хитрости.",
	["Rite of Cunning"] = "Обряд хитрости",
	-- {npc:6766} Ravenholdt Guard · {quest:6701} Syndicate Emblems
	["{npc:6766}: {quest:6701}, repeatable"] = "{npc:6766}: {quest:6701}, повторяемое",

	-- Step 3: Lord Tomas
	-- {npc:266216} Lord Tomas · {area:275} Durnholde Keep · {area:287} Hillsbrad · {npc:13085} Myrokos Silentform
	["{npc:266216} is inside {area:275}, the Syndicate fortress in eastern {area:287}, south of the manor. Quick and quiet, says {npc:13085}."] = "{npc:266216} – внутри крепости Синдиката ({area:275}) на востоке зоны {area:287}, к югу от поместья. Быстро и тихо, говорит {npc:13085}.",

	-- Step 5: What's the Big Idea?
	-- {npc:13085} Myrokos Silentform · {area:280} Strahnbrad · {zone:1416} Alterac Mountains
	["At 36, {npc:13085} sends you after Barton's scouting report. Barton leads a Syndicate party at {area:280}, in the east of the {zone:1416}: pick his pocket, do not kill him."] = "На 36-м уровне {npc:13085} отправляет вас за разведдонесением Бартона. Бартон возглавляет отряд Синдиката здесь: {area:280}, восток зоны {zone:1416}. Обчистите его карманы, не убивайте.",
	-- {item:275482} Barton's Scouting Report
	["{item:275482}: pickpocket Barton"] = "{item:275482}: обчистите карманы Бартона",

	-- Step 6: Back to Myrokos Silentform
	-- {npc:13085} Myrokos Silentform
	["Back to {npc:13085}"] = "Назад к {npc:13085}",
}
