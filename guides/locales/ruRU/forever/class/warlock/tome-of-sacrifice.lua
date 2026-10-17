-- Russian (ruRU): the guide forever/class/warlock/tome-of-sacrifice (forever/class/warlock/tome-of-sacrifice.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:14463} Daio the Decrepit · {npc:12396} Doomguard Commander · {zone:1419} Blasted Lands
	["A rare off-hand at 60, {npc:14463}'s payment for capturing a {npc:12396} in the {zone:1419}."] = "Редкий предмет для левой руки на 60-м уровне — плата {npc:14463} за поимку NPC {npc:12396} (зона: {zone:1419}).",

	-- Step 1: Daio the Decrepit
	-- {npc:14463} Daio the Decrepit · {area:73} Tainted Scar · {zone:1419} Blasted Lands
	["At 60 {npc:14463} waits in the {area:73}, in western {zone:1419}."] = "На 60-м уровне {npc:14463} ждет здесь: {area:73}, на западе зоны {zone:1419}.",

	-- Step 2: Satyr Blood
	-- {area:2577} Dire Maul · {area:2518} Lariss Pavilion · {area:1099} Camp Mojache · {item:18249} Crescent Key
	["The Wildspawn satyrs of the Warpwood Quarter, {area:2577}'s eastern wing, carry the blood. The back door at {area:2518}, north of {area:1099}, needs the {item:18249}; otherwise go in by {area:2577}'s main entrance. Bring a group."] = "Кровь носят сатиры из племени Исчадий Природы в восточном крыле подземелья {area:2577}. Для черного хода у места {area:2518}, к северу от места {area:1099}, нужен {item:18249}; иначе входите через главный вход ({area:2577}). Возьмите группу.",
	-- {item:18603} Satyr Blood
	["{item:18603}, inside the Warpwood Quarter"] = "{item:18603}, в восточном крыле подземелья",

	-- Step 3: Tears of the Hederine
	-- {area:2256} Darkwhisper Gorge · {zone:1452} Winterspring
	["The Hederine demons hold {area:2256}, in southern {zone:1452}. They are elite: grouping up is advised."] = "Демоны Хедерины удерживают {area:2256} на юге зоны {zone:1452}. Они элитные: лучше собрать группу.",

	-- Step 4: Suppression
	-- {npc:14463} Daio the Decrepit · {npc:12396} Doomguard Commander · {area:73} Tainted Scar · {item:18601} Glowing Crystal Prison
	["Hand both in to {npc:14463}, then find the {npc:12396} in the {area:73} and use the {item:18601} on him. He is elite and fights to escape: grouping up is advised."] = "Сдайте {npc:14463} оба предмета, затем найдите NPC {npc:12396} ({area:73}) и используйте на нем {item:18601}. Он элитный и пытается вырваться: лучше собрать группу.",
	-- {item:18601} Glowing Crystal Prison · {npc:12396} Doomguard Commander
	["{item:18601}, on the {npc:12396}"] = "{item:18601}: используйте на NPC {npc:12396}",

	-- Step 5: Back to Daio the Decrepit
	-- {npc:14463} Daio the Decrepit
	["Back to {npc:14463}"] = "Обратно к {npc:14463}",
}
