-- Russian (ruRU): the guide forever/class/warlock/orb-of-orahil (forever/class/warlock/orb-of-orahil.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Orb of Orahil"] = "Сфера Орахила",
	["An off-hand orb or a staff for your late 30s, down the felhound's or the infernal's path, your pick."] = "Сфера для левой руки или посох ближе к 40-му уровню – на выбор путь гончей Скверны или инфернала.",

	-- Step 1: Knowledge of the Orb of Orahil (Stormwind)
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 35 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:6266} in {area:392}."] = "На 35-м уровне {npc:461} ({object:2164}, {object:2101}) отправит вас сюда: {npc:6266} ({area:392}).",

	-- Step 2: Knowledge of the Orb of Orahil (Ironforge)
	-- {npc:5172} Briarthorn · {zone:1455} Ironforge · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 35 {npc:5172} in {zone:1455} sends you to {npc:6266} in {area:392}."] = "На 35-м уровне {npc:5172} ({zone:1455}) отправит вас сюда: {npc:6266} ({area:392}).",

	-- Step 3: Knowledge of the Orb of Orahil (Orgrimmar)
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 35 {npc:3326} in the {object:172960} sends you to {npc:6266} in {area:392}."] = "На 35-м уровне {npc:3326} ({object:172960}) отправит вас сюда: {npc:6266} ({area:392}).",

	-- Step 4: Knowledge of the Orb of Orahil (Undercity)
	-- {npc:4563} Kaal Soulreaper · {object:36082} Magic Quarter · {npc:6266} Menara Voidrender · {area:392} Ratchet · {zone:1420} Tirisfal Glades · {zone:1411} Durotar
	["At 35 {npc:4563} in the {object:36082} sends you to {npc:6266} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}."] = "На 35-м уровне {npc:4563} ({object:36082}) отправит вас сюда: {npc:6266} ({area:392}). Дирижабль из зоны {zone:1420} летит в зону {zone:1411}.",

	-- Step 5: Menara Voidrender
	-- {npc:6266} Menara Voidrender · {area:392} Ratchet · {npc:6251} Strahad Farsan
	["{npc:6266} and her two acolytes stand in the tower on the hill above {area:392}, beside {npc:6251}."] = "{npc:6266} и двое ее послушников стоят в башне на холме над местом {area:392}, рядом с NPC {npc:6251}.",

	-- Step 6: Choose an acolyte
	["Choose an acolyte"] = "Выберите послушника",
	-- {npc:6254} Acolyte Wytula · {item:15106} Staff of Dar'Orahil · {npc:6252} Acolyte Magaz · {item:15105} Staff of Noh'Orahil
	["Pick one acolyte: you can take only one of their quests. {npc:6254}'s felhound path ends with the Orb or {item:15106}, {npc:6252}'s infernal path with the Orb or {item:15105}. The guide follows the one you take."] = "Выберите одного послушника: можно взять только одно из их заданий. Путь гончей Скверны ({npc:6254}) заканчивается сферой или предметом {item:15106}, путь инфернала ({npc:6252}) – сферой или предметом {item:15105}. Гайд следует выбранному.",
	-- {npc:6254} Acolyte Wytula · {item:12647} Felhas Ruby
	["{npc:6254}: she gives you the {item:12647}"] = "{npc:6254}: она даст вам {item:12647}",
	-- {npc:6252} Acolyte Magaz · {item:12646} Infus Emerald
	["{npc:6252}: he gives you the {item:12646}"] = "{npc:6252}: он даст вам {item:12646}",

	-- Step 7: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace · {item:7291} Infernal Orb · {item:12647} Felhas Ruby · {npc:4678} Mana Eater · {item:12646} Infus Emerald · {npc:4676} Lesser Infernal
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["The demons of {area:602}, in southern {zone:1443}, have all you need. Burning Blade Summoners carry the {item:7291}. On the felhound path, use the {item:12647} on a {npc:4678}, a felhound, and kill it for its spirit; on the infernal path, use the {item:12646} on a {npc:4676} and kill it."] = "Все нужное есть у демонов ({area:602}) на юге зоны {zone:1443}. {item:7291} – у призывателей из клана Пылающего Клинка. На пути гончей Скверны используйте {item:12647} на гончей Скверны ({npc:4678}) и убейте ее ради духа; на пути инфернала используйте {item:12646} на цели {npc:4676} и убейте ее.",
	-- {item:7291} Infernal Orb
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["{item:7291}, from the Burning Blade Summoners"] = "{item:7291}: призыватели из клана Пылающего Клинка",
	-- {item:12648} Imprisoned Felhound Spirit · {npc:4678} Mana Eater
	["{item:12648}, from a {npc:4678}"] = "{item:12648}, добыча: {npc:4678}",
	-- {item:12649} Imprisoned Infernal Spirit · {npc:4676} Lesser Infernal
	["{item:12649}, from a {npc:4676}"] = "{item:12649}, добыча: {npc:4676}",

	-- Step 8: The demon's spirit
	["The demon's spirit"] = "Дух демона",
	-- {npc:6266} Menara Voidrender · {area:392} Ratchet · {npc:6546} Tabetha
	["Back to {npc:6266} in the tower above {area:392} with the spirit first: {npc:6546}'s cleansing follows it."] = "Сначала вернитесь с духом в башню над местом {area:392}. Цель: {npc:6266}. Затем – очищение (это {npc:6546}).",

	-- Step 9: Tabetha
	-- {npc:6546} Tabetha · {zone:1445} Dustwallow Marsh · {npc:6549} Demon of the Orb · {item:7291} Infernal Orb
	["{npc:6546} lives at her farm in western {zone:1445}. She calls the {npc:6549} out of the {item:7291}; it is elite: grouping up is advised."] = "{npc:6546} живет на своей ферме на западе зоны {zone:1445}. Она вызовет из предмета {item:7291} демона ({npc:6549}); он элитный: лучше собрать группу.",

	-- Step 10: The Orb of Dar'Orahil
	-- {item:15108} Orb of Dar'Orahil
	["The {item:15108}"] = "{item:15108}",
	-- {npc:6266} Menara Voidrender · {area:392} Ratchet · {item:15108} Orb of Dar'Orahil
	["Back to {npc:6266} in the tower above {area:392} with the cleansed orb. On the felhound path, wait while she completes the {item:15108}, then speak to her again."] = "Вернитесь с очищенной сферой к {npc:6266} в башню над местом {area:392}. На пути гончей Скверны подождите, пока она завершит {item:15108}, затем снова поговорите с ней.",
	["Wait for the orb"] = "Дождитесь сферы",

	-- Step 11: The Orb of Noh'Orahil
	-- {item:15107} Orb of Noh'Orahil
	["The {item:15107}"] = "{item:15107}",
	-- {npc:6266} Menara Voidrender · {item:15107} Orb of Noh'Orahil
	["On the infernal path, wait while {npc:6266} completes the {item:15107}, then speak to her again."] = "На пути инфернала подождите, пока {npc:6266} завершит {item:15107}, затем снова поговорите с ней.",
}
