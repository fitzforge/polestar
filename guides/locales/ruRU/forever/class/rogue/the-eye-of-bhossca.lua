-- Russian (ruRU): the guide forever/class/rogue/the-eye-of-bhossca (forever/class/rogue/the-eye-of-bhossca.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:277246} Ruby-Adorned Blade · {area:796} Scarlet Monastery
	["The {item:277246}, C's payment for a solo job inside the {area:796}."] = "{item:277246} — плата от C за одиночную работу внутри: {area:796}.",

	-- Step 1: C's dead drop
	["C's dead drop"] = "Тайник C",
	-- {object:410369} Dead Drop · {area:204} Pyrewood Village · {area:236} Shadowfang Keep
	["The {object:410369} is a chest near {area:204} in southern Silverpine, just south of {area:236}. C's next note waits there once you are 25."] = "{object:410369} — сундук у места {area:204} на юге Серебряного бора, чуть южнее: {area:236}. Следующая записка C ждет там, когда вам исполнится 25 уровень.",

	-- Step 2: The Scarlet Monastery
	-- {area:796} Scarlet Monastery
	["The {area:796}"] = "Локация: {area:796}",
	-- {zone:1420} Tirisfal Glades
	["The monastery stands in the far north-east of {zone:1420}. Go in alone; C advises a disguise from the monastery's grounds before you enter."] = "Монастырь стоит на крайнем северо-востоке зоны {zone:1420}. Идите один; C советует добыть маскировку на территории монастыря перед входом.",
	-- {area:796} Scarlet Monastery
	["Find the Eye of Bhossca inside the {area:796}."] = "Найдите Глаз Бхосски внутри: {area:796}.",

	-- Step 3: Back to the dead drop
	["Back to the dead drop"] = "Вернитесь к тайнику",
	-- {object:410369} Dead Drop
	["Place the eye in the {object:410369} near Pyrewood. C's payment is the second Eye of Bhossca quest at the same chest."] = "Положите глаз сюда: {object:410369}, у Погребальных Костров. Плата от C – второе задание о Глазе Бхосски у того же сундука.",
}
