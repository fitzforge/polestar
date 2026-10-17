-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/mounts/alliance/paladin-warhorse (forever/collectibles/mounts/alliance/paladin-warhorse.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Paladin Warhorse"] = "Cavalo de Guerra de Paladino",
	["Your first mount at 40, summoned at will: a paladin buys no horse."] = "Sua primeira montaria no nível 40, evocada à vontade: paladinos não compram cavalo.",

	-- Step 1: The Tome of Nobility (Ironforge)
	-- {npc:5149} Brandur Ironhammer · {object:32362} Mystic Ward (no name in this language: may be words) · {npc:6171} Duthorian Rall · {zone:1453} Stormwind · {zone:1455} Ironforge
	["At 40 {npc:5149} in the {object:32362} sends you to {npc:6171} in {zone:1453}'s Cathedral of Light. Take the tram from {zone:1455} to {zone:1453}."] = "No nível 40, {npc:5149} na {object:32362} manda você até {npc:6171} na Catedral da Luz de {zone:1453}. Pegue o metrô de {zone:1455} para {zone:1453}.",

	-- Step 2: Summon Warhorse
	-- {npc:6171} Duthorian Rall · {item:6779} Tome of Nobility · {spell:13819} Summon Warhorse
	["{npc:6171} stands in the Cathedral of Light. Turning in the {item:6779} teaches {spell:13819}; Paladins do not buy a mount."] = "{npc:6171} fica na Catedral da Luz. Entregar o {item:6779} ensina {spell:13819}; paladinos não compram montaria.",
}
