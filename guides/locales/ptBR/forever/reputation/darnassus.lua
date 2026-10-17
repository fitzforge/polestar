-- Portuguese (Brazil) (ptBR): the guide forever/reputation/darnassus (forever/reputation/darnassus.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Darnassus Reputation"] = "Reputação: Darnassus",

	-- Step 1: Raedon Duskstriker: A Donation of Wool
	-- {npc:14725} Raedon Duskstriker · {faction:69} Darnassus · {item:14047} Runecloth · {quest:7801} Additional Runecloth
	["{npc:14725} takes cloth for {faction:69} in {faction:69}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7801} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14725} recebe tecido para {faction:69} em {faction:69}. As primeiras doações de Lã, Seda, Magitrama e {item:14047} (60 tecidos cada) são feitas uma só vez e dão mais reputação por tecido; depois delas, {quest:7801} se repete até Exaltado. Exaltado com a cidade de outra raça permite comprar as montarias dessa raça. A vantagem de Legado Diplomata do Forever aumenta os ganhos de reputação.",

	-- Step 2: Wool Cloth
	-- plural, as words: Riverpaw Bandits = {npc:452} Riverpaw Bandit
	["Riverpaw Bandits and Taskmasters (level 16-18) drop it here. The Auction House works too."] = "Bandidos e Capatazes Pata Molhada (nível 16-18) deixam cair aqui. A Casa de Leilões também serve.",

	-- Step 4: Silk Cloth
	["Syndicate Mercenaries at Stromgarde (level 31-32) drop it here. The Auction House works too."] = "Mercenários da Camarilha em Stromgarde (nível 31-32) deixam cair aqui. A Casa de Leilões também serve.",

	-- Step 6: Mageweave Cloth
	["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Ogros Dunamalho (nível 45-48) deixam cair aqui. A Casa de Leilões também serve.",

	-- Step 8: Runecloth
	-- {object:92525} Argent Dawn (no name in this language: may be words)
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Adeptos das Trevas e Umbramantes (nível 58-60) deixam cair aqui; cada Flagelo morto aqui também conta para {object:92525} (veja esse guia). A Casa de Leilões também serve.",

	-- Step 9: Raedon Duskstriker: Runecloth delivered
	-- {npc:14725} Raedon Duskstriker · {item:14047} Runecloth
	["{npc:14725}: {item:14047} delivered"] = "{npc:14725}: {item:14047} entregue",

	-- Step 10: Additional Runecloth to Honored
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Honored"] = "{quest:7801} até Honrado",
	-- {quest:7801} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["{quest:7801} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7801} pede 20 {item:14047} por entrega e se repete quantas vezes você quiser. Traga {item:14047} em múltiplos de 20 e entregue tudo de uma vez, uma entrega após a outra. {item:14047}: Adeptos das Trevas e Umbramantes (nível 58-60) em {zone:1423}, ou a Casa de Leilões.",

	-- Step 11: Additional Runecloth to Revered
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Revered"] = "{quest:7801} até Reverenciado",
	-- {quest:7801} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7801}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continue entregando {quest:7801}, 20 {item:14047} por vez. {item:14047}: Adeptos das Trevas e Umbramantes (nível 58-60) em {zone:1423}, ou a Casa de Leilões.",

	-- Step 12: Additional Runecloth to Exalted
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Exalted"] = "{quest:7801} até Exaltado",
	-- {quest:7801} Additional Runecloth · {faction:69} Darnassus · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7801} until {faction:69} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continue entregando {quest:7801} até ficar Exaltado com {faction:69}. {item:14047}: Adeptos das Trevas e Umbramantes (nível 58-60) em {zone:1423}, ou a Casa de Leilões.",
}
