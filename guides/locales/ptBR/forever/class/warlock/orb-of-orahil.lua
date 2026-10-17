-- Portuguese (Brazil) (ptBR): the guide forever/class/warlock/orb-of-orahil (forever/class/warlock/orb-of-orahil.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Orb of Orahil"] = "Orbe de Orahil",
	["An off-hand orb or a staff for your late 30s, down the felhound's or the infernal's path, your pick."] = "Um orbe de mão secundária ou um cajado perto do nível 40, pelo caminho do canisvil ou do infernal, à sua escolha.",

	-- Step 1: Knowledge of the Orb of Orahil (Stormwind)
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 35 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:6266} in {area:392}."] = "No nível 35, {npc:461}, em {object:2164}, no {object:2101}, envia você a {npc:6266} em {area:392}.",

	-- Step 2: Knowledge of the Orb of Orahil (Ironforge)
	-- {npc:5172} Briarthorn · {zone:1455} Ironforge · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 35 {npc:5172} in {zone:1455} sends you to {npc:6266} in {area:392}."] = "No nível 35, {npc:5172}, em {zone:1455}, envia você a {npc:6266} em {area:392}.",

	-- Step 3: Knowledge of the Orb of Orahil (Orgrimmar)
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow (no name in this language: may be words) · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 35 {npc:3326} in the {object:172960} sends you to {npc:6266} in {area:392}."] = "No nível 35, {npc:3326}, na {object:172960}, envia você a {npc:6266} em {area:392}.",

	-- Step 4: Knowledge of the Orb of Orahil (Undercity)
	-- {npc:4563} Kaal Soulreaper · {object:36082} Magic Quarter (no name in this language: may be words) · {npc:6266} Menara Voidrender · {area:392} Ratchet · {zone:1420} Tirisfal Glades · {zone:1411} Durotar
	["At 35 {npc:4563} in the {object:36082} sends you to {npc:6266} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}."] = "No nível 35, {npc:4563}, no {object:36082}, envia você a {npc:6266} em {area:392}. O zepelim de {zone:1420} voa para {zone:1411}.",

	-- Step 5: Menara Voidrender
	-- {npc:6266} Menara Voidrender · {area:392} Ratchet · {npc:6251} Strahad Farsan
	["{npc:6266} and her two acolytes stand in the tower on the hill above {area:392}, beside {npc:6251}."] = "{npc:6266} e suas duas acólitas ficam na torre da colina acima de {area:392}, ao lado de {npc:6251}.",

	-- Step 6: Choose an acolyte
	["Choose an acolyte"] = "Escolha uma acólita",
	-- {npc:6254} Acolyte Wytula · {item:15106} Staff of Dar'Orahil · {npc:6252} Acolyte Magaz · {item:15105} Staff of Noh'Orahil
	["Pick one acolyte: you can take only one of their quests. {npc:6254}'s felhound path ends with the Orb or {item:15106}, {npc:6252}'s infernal path with the Orb or {item:15105}. The guide follows the one you take."] = "Escolha uma acólita: você só pode pegar a missão de uma delas. O caminho do canisvil, de {npc:6254}, termina com o Orbe ou o {item:15106}; o caminho do infernal, de {npc:6252}, com o Orbe ou o {item:15105}. O guia segue a que você pegar.",
	-- {npc:6254} Acolyte Wytula · {item:12647} Felhas Ruby
	["{npc:6254}: she gives you the {item:12647}"] = "{npc:6254}: ela lhe dá o {item:12647}",
	-- {npc:6252} Acolyte Magaz · {item:12646} Infus Emerald
	["{npc:6252}: he gives you the {item:12646}"] = "{npc:6252}: ela lhe dá a {item:12646}",

	-- Step 7: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace · {item:7291} Infernal Orb · {item:12647} Felhas Ruby · {npc:4678} Mana Eater · {item:12646} Infus Emerald · {npc:4676} Lesser Infernal
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["The demons of {area:602}, in southern {zone:1443}, have all you need. Burning Blade Summoners carry the {item:7291}. On the felhound path, use the {item:12647} on a {npc:4678}, a felhound, and kill it for its spirit; on the infernal path, use the {item:12646} on a {npc:4676} and kill it."] = "Os demônios de {area:602}, no sul da {zone:1443}, têm tudo o que você precisa. Os Evocadores da Lâmina Ardente carregam o {item:7291}. No caminho do canisvil, use o {item:12647} num {npc:4678}, um canisvil, e mate-o para pegar o espírito; no caminho do infernal, use a {item:12646} num {npc:4676} e mate-o.",
	-- {item:7291} Infernal Orb
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["{item:7291}, from the Burning Blade Summoners"] = "{item:7291}, dos Evocadores da Lâmina Ardente",
	-- {item:12648} Imprisoned Felhound Spirit · {npc:4678} Mana Eater
	["{item:12648}, from a {npc:4678}"] = "{item:12648}, de um {npc:4678}",
	-- {item:12649} Imprisoned Infernal Spirit · {npc:4676} Lesser Infernal
	["{item:12649}, from a {npc:4676}"] = "{item:12649}, de um {npc:4676}",

	-- Step 8: The demon's spirit
	["The demon's spirit"] = "O espírito do demônio",
	-- {npc:6266} Menara Voidrender · {area:392} Ratchet · {npc:6546} Tabetha
	["Back to {npc:6266} in the tower above {area:392} with the spirit first: {npc:6546}'s cleansing follows it."] = "Primeiro, volte com o espírito a {npc:6266}, na torre acima de {area:392}: a purificação de {npc:6546} vem depois.",

	-- Step 9: Tabetha
	-- {npc:6546} Tabetha · {zone:1445} Dustwallow Marsh · {npc:6549} Demon of the Orb · {item:7291} Infernal Orb
	["{npc:6546} lives at her farm in western {zone:1445}. She calls the {npc:6549} out of the {item:7291}; it is elite: grouping up is advised."] = "{npc:6546} mora na fazenda dela, no oeste do {zone:1445}. Ela chama o {npc:6549} para fora do {item:7291}; ele é elite: é recomendado ir em grupo.",

	-- Step 10: The Orb of Dar'Orahil
	-- {item:15108} Orb of Dar'Orahil
	["The {item:15108}"] = "{item:15108}",
	-- {npc:6266} Menara Voidrender · {area:392} Ratchet · {item:15108} Orb of Dar'Orahil
	["Back to {npc:6266} in the tower above {area:392} with the cleansed orb. On the felhound path, wait while she completes the {item:15108}, then speak to her again."] = "Volte a {npc:6266}, na torre acima de {area:392}, com o orbe purificado. No caminho do canisvil, espere enquanto ela conclui o {item:15108} e fale com ela de novo.",
	["Wait for the orb"] = "Espere o orbe",

	-- Step 11: The Orb of Noh'Orahil
	-- {item:15107} Orb of Noh'Orahil
	["The {item:15107}"] = "{item:15107}",
	-- {npc:6266} Menara Voidrender · {item:15107} Orb of Noh'Orahil
	["On the infernal path, wait while {npc:6266} completes the {item:15107}, then speak to her again."] = "No caminho do infernal, espere enquanto {npc:6266} conclui o {item:15107} e fale com ela de novo.",
}
