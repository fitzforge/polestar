-- Russian (ruRU): the guide forever/reputation/thorium-brotherhood (forever/reputation/thorium-brotherhood.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Thorium Brotherhood Reputation"] = "Репутация: Братство Тория",

	-- Step 1: Master Smith Burninate
	-- {area:1446} Thorium Point · {zone:1427} Searing Gorge · {faction:59} Thorium Brotherhood
	["{area:1446}, on the scaffolds in the north-west of {zone:1427}, is the Brotherhood's outpost. The {faction:59} starts out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{area:1446} – аванпост Братства на лесах на северо-западе зоны {zone:1427}. {faction:59}: начальная репутация – равнодушие. Бонус наследия Forever «Дипломат» ускоряет рост репутации.",

	-- Step 2: Secret Plans: Fiery Flux
	-- {area:1443} Slag Pit · {object:147516} Dark Iron · {item:18945} Dark Iron Residue
	["The plans lie in the {area:1443} of the Cauldron, guarded by {object:147516} dwarves. {object:147516} dwarves also drop {item:18945}, which Burninate takes for Gaining Acceptance."] = "Чертежи лежат здесь: {area:1443} в Котловане; их охраняют дворфы ({object:147516}). С этих дворфов ({object:147516}) также падает {item:18945} – Гориврат принимает его для задания «Завоевать благосклонность».",

	-- Step 3: Back to Burninate
	["Back to Burninate"] = "Вернитесь к Гориврату",

	-- Step 4: Fiery Flux supplies to Friendly
	-- {item:18942} Fiery Flux
	["{item:18942} supplies to Friendly"] = "Припасы ({item:18942}) до уровня «Дружелюбие»",
	-- {item:3356} Kingsblood · {item:4234} Heavy Leather · {item:18944} Incendosaur Scale · {zone:1427} Searing Gorge
	-- plural, as words: Iron Bars = {item:3575} Iron Bar · Incendosaurs = {npc:9318} Incendosaur
	["Restoring Fiery Flux Supplies repeats in three versions: {item:3356}, Iron Bars or {item:4234}, each with Coal and an {item:18944}. Incendosaurs (level 47-49) in the north of {zone:1427} drop a scale every time; Burninate himself sells Coal."] = "Задание на пополнение запасов огненного плавня повторяется в трех вариантах: {item:3356}, {item:3575} или {item:4234}, каждый – с углем и предметом {item:18944}. Пламезавры (уровень 47-49) на севере зоны {zone:1427} всегда роняют чешую; уголь продает сам Гориврат.",
	-- {npc:14624} Master Smith Burninate
	["{npc:14624}: Restoring Fiery Flux Supplies"] = "{npc:14624}: пополнение запасов огненного плавня",

	-- Step 5: Lokhtos Darkbargainer to Honored
	-- {npc:12944} Lokhtos Darkbargainer
	["{npc:12944} to Honored"] = "{npc:12944} до уровня «Уважение»",
	-- {npc:12944} Lokhtos Darkbargainer · {area:1584} Blackrock Depths · {item:11099} Dark Iron Ore · {skill:186} Mining · {item:11382} Blood of the Mountain · {item:17010} Fiery Core · {item:17011} Lava Core · {item:17012} Core Leather · {npc:14387} Lothos Riftwaker · {area:1445} Blackrock Mountain · {area:2717} Molten Core
	-- plural, as words: Dark Iron Deposits = {object:165658} Dark Iron Deposit
	["{npc:12944} trades in the Grim Guzzler inside {area:1584}. His Favor Amongst the Brotherhood turn-ins take {item:11099} (mined from Dark Iron Deposits with {skill:186}), {item:11382}, {item:17010}, {item:17011} and {item:17012}. {npc:14387} at the {area:1445} entrance offers attunement to the {area:2717}."] = "{npc:12944} торгует в «Угрюмом обжоре» ({area:1584}). Его задания «Покровительство братства» принимают {item:11099} (добывается из жил: {object:165658}; {skill:186}), {item:11382}, {item:17010}, {item:17011} и {item:17012}. {npc:14387} у входа ({area:1445}) дает допуск в рейд {area:2717}.",
	-- {item:11099} Dark Iron Ore
	["{item:11099}: Favor Amongst the Brotherhood, {item:11099} at Lokhtos, repeatable."] = "{item:11099}: «Покровительство братства» ({item:11099}) у Локтоса, повторяемое.",

	-- Step 6: Thorium Brotherhood to Revered
	-- {faction:59} Thorium Brotherhood
	["{faction:59} to Revered"] = "{faction:59} до уровня «Почтение»",
	-- {area:2717} Molten Core · {item:11382} Blood of the Mountain
	-- plural, as words: Fiery Cores = {item:17010} Fiery Core · Lava Cores = {item:17011} Lava Core · Lava Elementals = {npc:12076} Lava Elemental · Lava Reavers = {npc:12100} Lava Reaver · Molten Destroyers = {npc:11659} Molten Destroyer
	["The {area:2717} materials carry the rest: Fiery Cores drop from Firewalkers, Flameguards and Firelords, and Lava Cores from Lava Elementals, Lava Reavers and Molten Destroyers there. {item:11382} comes from Molten Destroyers and rarely elsewhere."] = "Остальное дают материалы из рейда {area:2717}: {item:17010} падает с огнеходов, пламестражей и повелителей огня, а {item:17011} – с лавовых элементалей ({npc:12076}), лавовых разорителей ({npc:12100}) и огненных разрушителей ({npc:11659}). {item:11382} падает с огненных разрушителей и изредка в других местах.",
	-- {area:2717} Molten Core · {item:17010} Fiery Core · {item:17011} Lava Core · {item:17012} Core Leather · {item:11382} Blood of the Mountain
	["{area:2717} materials: Favor Amongst the Brotherhood, {item:17010}, {item:17011}, {item:17012} and {item:11382}, all repeatable at Lokhtos."] = "Материалы ({area:2717}): «Покровительство братства» – {item:17010}, {item:17011}, {item:17012} и {item:11382}, все повторяемые у Локтоса.",

	-- Step 7: Thorium Brotherhood to Exalted
	-- {faction:59} Thorium Brotherhood
	["{faction:59} to Exalted"] = "{faction:59} до уровня «Превознесение»",
	-- {area:2717} Molten Core · {item:11099} Dark Iron Ore
	["Keep turning in {area:2717} materials and {item:11099} at Lokhtos until Exalted."] = "Сдавайте Локтосу материалы ({area:2717}) и {item:11099} до превознесения.",
}
