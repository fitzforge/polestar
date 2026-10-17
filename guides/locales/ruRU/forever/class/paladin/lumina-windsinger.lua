-- Russian (ruRU): the guide forever/class/paladin/lumina-windsinger (forever/class/paladin/lumina-windsinger.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:91862} Lumina Windsinger
	["Rescuing {quest:91862}"] = "Спасение: {quest:91862}",
	-- {item:268484} Moonsilver Blade
	["No item yet: a Forsaken paladin rescue story; its sequel, the {item:268484}, cannot be finished yet."] = "Предмета пока нет: история о спасении для паладина Отрекшихся; ее продолжение, {item:268484}, пока нельзя завершить.",
	-- {zone:1458} Undercity
	["{zone:1458} and Earthen Ring reputation"] = "Репутация: {zone:1458} и Служители Земли",

	-- Step 1: Danitha Morr
	-- {npc:246378} Danitha Morr · {area:16602} Bandarion Keep · {area:156} Solliden Farmstead
	["{npc:246378} leads the Paladins of Tyr's Watch from inside {area:16602}, on the bluffs north-west of the {area:156}."] = "{npc:246378} руководит паладинами Tyr's Watch изнутри места {area:16602}, на утесах к северо-западу от места {area:156}.",

	-- Step 2: The Sepulcher
	-- {zone:1421} Silverpine Forest · {area:228} The Sepulcher · {npc:248840} Trevan Rol · {npc:259611} Deathguard Baldren
	["Ride south through {zone:1421} to the {area:228}. {npc:248840} stands in the town; {npc:259611} keeps watch near its entrance."] = "Езжайте на юг через {zone:1421} к {area:228}. {npc:248840} стоит в поселении; {npc:259611} стоит на страже у входа.",

	-- Step 3: The pyre on Fenris Isle
	-- {area:172} Fenris Isle
	["The pyre on {area:172}"] = "Погребальный костер: {area:172}",
	-- {area:172} Fenris Isle · {area:228} The Sepulcher
	["{area:172} lies in the lake east of the {area:228}. The charred remains are on its shore."] = "{area:172} — остров в озере к востоку от {area:228}. Обугленные останки лежат на его берегу.",
	-- {object:566037} Charred Remains
	["from the {object:566037}"] = "Объект: {object:566037}",

	-- Step 4: Fenris Keep
	-- {quest:91862} Lumina Windsinger · {area:235} Fenris Keep
	["{quest:91862} is caged inside {area:235}, at the north end of the isle. The Rot Hide gnolls around her carry the key."] = "{quest:91862} заперта в клетке здесь: {area:235}, северный край острова. Ключ у гноллов из стаи Гнилошкуров вокруг нее.",
	-- {item:267412} Fenris Isle Key
	["{item:267412}, from the Rot Hide gnolls"] = "{item:267412} – с гноллов из стаи Гнилошкуров",

	-- Step 5: Free Lumina Windsinger
	-- {npc:248755} Lumina Windsinger
	["Free {npc:248755}"] = "Освободите {npc:248755}",
	["Free her with the key, then stay close while she fights her way out of the keep."] = "Освободите ее ключом и держитесь рядом, пока она пробивается из крепости.",

	-- Step 6: Back to the The Sepulcher
	-- {area:228} The Sepulcher
	["Back to the {area:228}"] = "Вернитесь в {area:228}",
	-- {area:235} Fenris Keep · {npc:259620} Lumina Windsinger · {area:228} The Sepulcher
	["Once she is clear of {area:235}, {npc:259620} waits for you in the {area:228}. Speak with her again to hear what really happened on the road."] = "Когда она выберется из места {area:235}, {npc:259620} ждет вас в месте {area:228}. Поговорите с ней снова, чтобы узнать, что на самом деле случилось в дороге.",
	-- {npc:259620} Lumina Windsinger · {area:228} The Sepulcher
	["{npc:259620}, the {area:228}"] = "{npc:259620}, {area:228}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the {area:228}"] = "Вернитесь: {area:228}",
	-- ["Once she is clear of {area:235}, Lumina waits for you in the {area:228}. Speak with her again to hear what really happened on the road."] = "Когда она выберется из места {area:235}, Люмина ждет вас здесь: {area:228}. Поговорите с ней снова, чтобы узнать, что на самом деле случилось в дороге.",
	-- ["Ride south through {zone:1421} to the {area:228}. {npc:248840} stands in the town; {npc:259611} keeps watch near its entrance."] = "Езжайте на юг через {zone:1421} к месту {area:228}. {npc:248840} стоит в поселении; {npc:259611} стоит на страже у входа.",
	-- ["{area:172} lies in the lake east of the {area:228}. The charred remains are on its shore."] = "{area:172} — остров в озере к востоку от места {area:228}. Обугленные останки лежат на его берегу.",
	-- ["{npc:259620}, the {area:228}"] = "{npc:259620}, {area:228}",
}
