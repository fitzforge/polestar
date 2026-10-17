-- Portuguese (Brazil) (ptBR): the guide forever/reputation/hydraxian-waterlords (forever/reputation/hydraxian-waterlords.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Hydraxian Waterlords Reputation"] = "Reputação: Senhores das Águas Hidraxianos",

	-- Step 1: Duke Hydraxis
	-- {npc:13278} Duke Hydraxis · {zone:1447} Azshara · {faction:749} Hydraxian Waterlords
	["{npc:13278} stands on a small island off the eastern coast of {zone:1447}; swim or walk the shallows out to him. The {faction:749} start out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:13278} fica numa ilhota ao largo da costa leste de {zone:1447}; nade ou caminhe pela parte rasa até ele. Os {faction:749} começam em Neutro. A vantagem de Legado Diplomata do Forever aumenta os ganhos de reputação.",

	-- Step 2: Dust Stormers and Desert Rumblers
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["Dust Stormers and Desert Rumblers"] = "Tempestades de Poeira e Estrondores do Deserto",
	-- {zone:1451} Silithus
	["Both elementals roam north-western {zone:1451}; the Rumblers cluster a little further north."] = "Os dois elementais vagam pelo noroeste de {zone:1451}; os Estrondores ficam um pouco mais ao norte.",

	-- Step 3: Poisoned Water
	-- {item:17310} Aspect of Neptulon · {zone:1423} Eastern Plaguelands · {item:17309} Discordant Bracers
	["Use the {item:17310} on the poisoned water elementals of {zone:1423}, then loot their {item:17309} (12)."] = "Use o {item:17310} nos elementais da água envenenados de {zone:1423} e depois saqueie as {item:17309} (12).",

	-- Step 4: Back to Duke Hydraxis
	-- {npc:13278} Duke Hydraxis
	["Back to {npc:13278}"] = "Volte a {npc:13278}",

	-- Step 5: Eye of the Emberseer
	-- {npc:9816} Pyroguard Emberseer · {quest:6821} Eye of the Emberseer
	["{npc:9816} in Upper Blackrock Spire drops the {quest:6821}. This needs a raid group."] = "{npc:9816}, no Pico da Rocha Negra Superior, deixa cair {quest:6821}. Isso exige um grupo de raide.",

	-- Step 6: The Molten Core
	-- {npc:11668} Firelord · {npc:11658} Molten Giant · {npc:11673} Ancient Core Hound · {npc:12101} Lava Surger · {area:2717} Molten Core
	["Kill a {npc:11668}, a {npc:11658}, an {npc:11673} and a {npc:12101} in the {area:2717}. Every {area:2717} elemental and boss also counts toward the Waterlords."] = "Mate um {npc:11668}, um {npc:11658}, um {npc:11673} e um {npc:12101} em {area:2717}. Todo elemental e chefe de {area:2717} também conta para os Senhores das Águas.",

	-- Step 7: Agent of Hydraxis
	-- {quest:6823} Agent of Hydraxis · {npc:13278} Duke Hydraxis · {item:17333} Aqual Quintessence · {area:2717} Molten Core · {npc:12018} Majordomo Executus · {item:22754} Eternal Quintessence
	["{quest:6823} needs Honored. At Honored, {npc:13278} hands out {item:17333}, used to douse the runes in the {area:2717} that summon {npc:12018}; at Revered, the reusable {item:22754}."] = "{quest:6823} exige Honrado. Em Honrado, {npc:13278} entrega {item:17333}, usada para apagar as runas em {area:2717} que invocam {npc:12018}; em Reverenciado, a reutilizável {item:22754}.",

	-- Step 8: Hands of the Enemy
	-- {area:2717} Molten Core
	["Bring the Hands of Lucifron, Gehennas, Shazzrah and Sulfuron from the {area:2717}."] = "Traga as Mãos de Lúcifron, Geena, Shazzrah e Sulfuron de {area:2717}.",

	-- Step 9: Hydraxian Waterlords to Revered
	-- {faction:749} Hydraxian Waterlords
	["{faction:749} to Revered"] = "{faction:749} até Reverenciado",
	-- {area:2717} Molten Core
	["{area:2717} clears carry the rest. Bosses always count; in Classic, trash kills stop giving Waterlords reputation partway up, so late on the bosses do the work."] = "Limpezas de {area:2717} fazem o resto. Chefes sempre contam; no Classic, mortes de monstros comuns deixam de dar reputação com os Senhores das Águas a certa altura, então mais adiante são os chefes que fazem o trabalho.",

	-- Step 10: Hydraxian Waterlords to Exalted
	-- {faction:749} Hydraxian Waterlords
	["{faction:749} to Exalted"] = "{faction:749} até Exaltado",
	-- {area:2717} Molten Core
	["Keep clearing the {area:2717} until Exalted."] = "Continue limpando {area:2717} até Exaltado.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Use the {item:17310} on the poisoned water elementals of {zone:1423}, then loot their {item:17309} (12). Our data has no spawn points for those elementals."] = "Use o {item:17310} nos elementais da água envenenados de {zone:1423} e depois saqueie as {item:17309} (12). Nossos dados não têm pontos de surgimento desses elementais.",
}
