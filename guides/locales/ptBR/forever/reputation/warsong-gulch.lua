-- Portuguese (Brazil) (ptBR): the guide forever/reputation/warsong-gulch (forever/reputation/warsong-gulch.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Warsong Gulch Reputation"] = "Reputação: Ravina Brado Guerreiro",

	-- Step 1: Silverwing Sentinels to Friendly
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Friendly"] = "{faction:890} até Amigável",
	-- {faction:890} Silverwing Sentinels · {zone:1460} Warsong Gulch
	["The {faction:890} are the Night Elves holding {zone:1460}. Their reputation comes from the battleground: every enemy flag your team captures pays it to the whole team. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:890} são os elfos noturnos que defendem {zone:1460}. A reputação vem do campo de batalha: cada bandeira inimiga capturada pela sua equipe a concede à equipe inteira. Entre na fila com qualquer mestre de batalha. A vantagem de Legado Diplomata do Forever aumenta os ganhos de reputação.",
	-- {npc:14733} Sentinel Farsong
	["{npc:14733} takes Warsong Gulch Marks of Honor for Vanquish the Invaders!, once per level bracket (data); check them live."] = "{npc:14733} aceita Marcas de Honra da Ravina Brado Guerreiro pela missão Aniquile os invasores!, uma vez por faixa de nível (dados); confira no jogo.",

	-- Step 2: Silverwing Sentinels to Honored
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Honored"] = "{faction:890} até Honrado",
	-- {zone:1460} Warsong Gulch · {npc:15351} Alliance Brigadier General
	["Keep playing {zone:1460} and capturing flags. On Call to Arms: {zone:1460} weekends the {npc:15351} in the capitals takes three Warsong Gulch Marks of Honor for extra reputation."] = "Continue jogando {zone:1460} e capturando bandeiras. Nos fins de semana de Chamado às Armas: {zone:1460}, o {npc:15351} nas capitais aceita três Marcas de Honra da Ravina Brado Guerreiro por reputação extra.",
	-- {npc:14753} Illiyana Moonblaze
	["{npc:14753} hands out one Sentinel care package by level"] = "{npc:14753} dá um Kit de Sobrevivência de Sentinela por nível",

	-- Step 3: Silverwing Sentinels to Revered
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Revered"] = "{faction:890} até Reverenciado",
	-- {zone:1460} Warsong Gulch
	["Keep capturing flags in {zone:1460}."] = "Continue capturando bandeiras em {zone:1460}.",

	-- Step 4: Silverwing Sentinels to Exalted
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Exalted"] = "{faction:890} até Exaltado",
	-- {faction:890} Silverwing Sentinels
	["Exalted with the {faction:890} earns a Legacy Point."] = "Exaltado com {faction:890} rende um Ponto de Legado.",

	-- Step 5: Warsong Outriders to Friendly
	-- {faction:889} Warsong Outriders
	["{faction:889} to Friendly"] = "{faction:889} até Amigável",
	-- {faction:889} Warsong Outriders · {zone:1440} Ashenvale
	["The {faction:889} are the Orcs logging {zone:1440}. Their reputation comes from the battleground: every enemy flag your team captures pays it to the whole team. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:889} são os orcs que desmatam {zone:1440}. A reputação vem do campo de batalha: cada bandeira inimiga capturada pela sua equipe a concede à equipe inteira. Entre na fila com qualquer mestre de batalha. A vantagem de Legado Diplomata do Forever aumenta os ganhos de reputação.",
	-- {npc:14781} Captain Shatterskull
	["{npc:14781} takes Warsong Gulch Marks of Honor for Quell the Silverwing Usurpers, once per level bracket (data); check them live."] = "{npc:14781} aceita Marcas de Honra da Ravina Brado Guerreiro pela missão Domine os usurpadores da Asa de Prata, uma vez por faixa de nível (dados); confira no jogo.",

	-- Step 6: Warsong Outriders to Honored
	-- {faction:889} Warsong Outriders
	["{faction:889} to Honored"] = "{faction:889} até Honrado",
	-- {zone:1460} Warsong Gulch · {npc:15350} Horde Warbringer
	["Keep playing {zone:1460} and capturing flags. On Call to Arms: {zone:1460} weekends the {npc:15350} in the capitals takes three Warsong Gulch Marks of Honor for extra reputation."] = "Continue jogando {zone:1460} e capturando bandeiras. Nos fins de semana de Chamado às Armas: {zone:1460}, o {npc:15350} nas capitais aceita três Marcas de Honra da Ravina Brado Guerreiro por reputação extra.",
	-- {npc:14754} Kelm Hargunth
	["{npc:14754} hands out one Outrider care package by level"] = "{npc:14754} dá um Kit de Sobrevivência de Pioneiro por nível",

	-- Step 7: Warsong Outriders to Revered
	-- {faction:889} Warsong Outriders
	["{faction:889} to Revered"] = "{faction:889} até Reverenciado",

	-- Step 8: Warsong Outriders to Exalted
	-- {faction:889} Warsong Outriders
	["{faction:889} to Exalted"] = "{faction:889} até Exaltado",
	-- {faction:889} Warsong Outriders
	["Exalted with the {faction:889} earns a Legacy Point."] = "Exaltado com {faction:889} rende um Ponto de Legado.",
}
