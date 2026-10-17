-- Portuguese (Brazil) (ptBR): the guide forever/reputation/arathi-basin (forever/reputation/arathi-basin.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Arathi Basin Reputation"] = "Reputação: Bacia Arathi",

	-- Step 1: League of Arathor to Friendly
	["League of Arathor to Friendly"] = "A Liga de Arathor até Respeitado",
	-- {faction:509} The League of Arathor · {zone:1461} Arathi Basin · {area:320} Refuge Pointe
	["{faction:509} fights for {zone:1461} from {area:320}. Their reputation comes from the battleground: the resources your team gathers pay it to everyone, so holding more bases for longer pays more. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:509} luta por {zone:1461} a partir de {area:320}. A reputação vem do campo de batalha: os recursos que seu time junta dão reputação a todos, então manter mais bases por mais tempo dá mais. Entre na fila com qualquer mestre de batalha. A vantagem de Legado Diplomata do Forever aumenta os ganhos de reputação.",
	-- {npc:14983} Field Marshal Oslight · {zone:1461} Arathi Basin · {npc:14984} Sergeant Maclear
	-- plural, as words: Arathi Resource Crates = {item:19725} Arathi Resource Crate
	["{npc:14983}'s The Battle for {zone:1461}! (assault every base) and Control Four Bases / Control Five Bases are one-time quests; {npc:14984} beside him takes Arathi Resource Crates."] = "A Batalha pela {zone:1461}! (ataque todas as bases) e Controlar quatro bases / Controlar cinco bases, de {npc:14983}, são missões únicas; {npc:14984}, ao lado dele, aceita Caixas de Recursos Arathi.",

	-- Step 2: League of Arathor to Honored
	["League of Arathor to Honored"] = "A Liga de Arathor até Honrado",
	-- {zone:1461} Arathi Basin · {npc:15351} Alliance Brigadier General
	["Keep playing {zone:1461}. On Call to Arms: {zone:1461} weekends the {npc:15351} in the capitals takes three Arathi Basin Marks of Honor for extra reputation."] = "Continue jogando {zone:1461}. Nos fins de semana de Chamado às Armas: {zone:1461}, o {npc:15351} nas capitais aceita três Marcas de Honra da Bacia Arathi por reputação extra.",
	-- {npc:15127} Samuel Hawke
	["{npc:15127} hands out one Arathor care package by level"] = "{npc:15127} entrega um Kit de Sobrevivência de Arathor por nível",

	-- Step 3: League of Arathor to Revered
	["League of Arathor to Revered"] = "A Liga de Arathor até Reverenciado",
	-- {zone:1461} Arathi Basin
	["Keep playing {zone:1461}; wins with many bases held pay the most."] = "Continue jogando {zone:1461}; vitórias com muitas bases dominadas dão mais.",

	-- Step 4: League of Arathor to Exalted
	["League of Arathor to Exalted"] = "A Liga de Arathor até Exaltado",
	["Exalted with the League of Arathor earns a Legacy Point."] = "Exaltado com A Liga de Arathor rende um Ponto de Legado.",

	-- Step 5: The Defilers to Friendly
	-- {faction:510} The Defilers
	["{faction:510} to Friendly"] = "{faction:510} até Respeitado",
	-- {faction:510} The Defilers · {zone:1461} Arathi Basin · {area:321} Hammerfall
	["{faction:510} fight for {zone:1461} from {area:321}. Their reputation comes from the battleground: the resources your team gathers pay it to everyone, so holding more bases for longer pays more. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:510} lutam por {zone:1461} a partir de {area:321}. A reputação vem do campo de batalha: os recursos que seu time junta dão reputação a todos, então manter mais bases por mais tempo dá mais. Entre na fila com qualquer mestre de batalha. A vantagem de Legado Diplomata do Forever aumenta os ganhos de reputação.",
	-- {npc:15021} Deathmaster Dwire · {zone:1461} Arathi Basin · {npc:15022} Deathstalker Mortis
	-- plural, as words: Arathi Resource Crates = {item:19725} Arathi Resource Crate
	["{npc:15021}'s The Battle for {zone:1461}! (assault every base) and Take Four Bases / Take Five Bases are one-time quests; {npc:15022} beside him takes Arathi Resource Crates."] = "A batalha pela {zone:1461}! (ataque todas as bases) e Tome quatro bases / Tome cinco bases, de {npc:15021}, são missões únicas; {npc:15022}, ao lado dele, aceita Caixas de Recursos Arathi.",

	-- Step 6: The Defilers to Honored
	-- {faction:510} The Defilers
	["{faction:510} to Honored"] = "{faction:510} até Honrado",
	-- {zone:1461} Arathi Basin · {npc:15350} Horde Warbringer
	["Keep playing {zone:1461}. On Call to Arms: {zone:1461} weekends the {npc:15350} in the capitals takes three Arathi Basin Marks of Honor for extra reputation."] = "Continue jogando {zone:1461}. Nos fins de semana de Chamado às Armas: {zone:1461}, o {npc:15350} nas capitais aceita três Marcas de Honra da Bacia Arathi por reputação extra.",
	-- {npc:15126} Rutherford Twing
	["{npc:15126} hands out one Defiler's care package by level"] = "{npc:15126} entrega um Kit de Sobrevivência do Profanador por nível",

	-- Step 7: The Defilers to Revered
	-- {faction:510} The Defilers
	["{faction:510} to Revered"] = "{faction:510} até Reverenciado",

	-- Step 8: The Defilers to Exalted
	-- {faction:510} The Defilers
	["{faction:510} to Exalted"] = "{faction:510} até Exaltado",
	-- {faction:510} The Defilers
	["Exalted with {faction:510} earns a Legacy Point."] = "Exaltado com {faction:510} rende um Ponto de Legado.",
}
