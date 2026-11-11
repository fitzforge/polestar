-- Portuguese (Brazil) (ptBR): the guide forever/class/shaman/darkreaver (forever/class/shaman/darkreaver.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:2057} Scholomance · {item:20134} Skyfury Helm
	["A {area:2057} fight at 60 for Horde reputation; the {item:20134} may be gone in Forever."] = "Uma luta em {area:2057} no nível 60 por reputação da Horda; {item:20134} pode ter sumido no Forever.",
	["200 Horde reputation"] = "200 de reputação com a Horda",

	-- Step 1: Sagorne Creststrider
	-- {npc:13417} Sagorne Creststrider · {object:172957} Valley of Wisdom (no name in this language: may be words)
	["At 58 {npc:13417}, the shaman trainer in the {object:172957}, asks for two rare diamonds; every Horde shaman goes to him. Skyborne: Forever's quest page lists this quest for Orcs, Tauren and Trolls only: ask before you buy the diamonds."] = "No nível 58, {npc:13417}, o instrutor de xamã no {object:172957}, pede dois diamantes raros; todo xamã da Horda vai até ele. Celonatos: a página de missão do Forever lista esta missão só para Orcs, Taurens e Trolls: confirme antes de comprar os diamantes.",

	-- Step 2: Two diamonds
	["Two diamonds"] = "Dois diamantes",
	-- {item:12800} Azerothian Diamond · {area:2418} Morgan's Vigil · {zone:1428} Burning Steppes · {item:18335} Pristine Black Diamond
	-- plural, as words: Small Thorium Veins = {object:324} Small Thorium Vein
	["Both diamonds are rare: the auction house is the quick way. Miners find the {item:12800} in about one Thorium vein in a hundred (the Small Thorium Veins north of {area:2418} in the {zone:1428} respawn every five minutes). The {item:18335} drops from high-level elites at about one in a hundred, best from the rare elite Revanchion (about one in nine)."] = "Os dois diamantes são raros: a Casa de Leilões é o jeito rápido. Mineiros acham {item:12800} em cerca de um veio de Tório a cada cem (os Veios de Tório Escasso ao norte de {area:2418}, em {zone:1428}, voltam a cada cinco minutos). {item:18335} cai de elites de nível alto em cerca de um a cada cem, melhor do elite raro Revanchion (cerca de um a cada nove).",

	-- Step 3: Sagorne Creststrider
	-- {quest:7668} The Darkreaver Menace
	["{quest:7668} needs level 60."] = "{quest:7668} requer nível 60.",
	-- {item:18746} Divination Scryer
	["he hands you the {item:18746}"] = "ele lhe entrega o {item:18746}",

	-- Step 4: The Great Ossuary
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {object:179746} The Great Ossuary (no name in this language: may be words) · {item:18746} Divination Scryer · {npc:14516} Death Knight Darkreaver · {spell:686} Shadow Bolt · {spell:6958} Blood Leech
	-- plural, as words: Cleaves = {spell:845} Cleave
	["A five-player dungeon event: {area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. In the {object:179746}'s basement, first clear every mob in the room, then use the {item:18746} at its centre: four waves of spirits follow, each closing with an Aspect mini-boss (the first wave weak and slow, the rest elite). Fight in a corner so nothing else joins, and drink between waves: it is long. Then {npc:14516} (level 62 elite) appears: he Cleaves, casts {spell:686} and {spell:6958}, and Dominates a player's mind against the group. His head always drops."] = "Um evento de masmorra para cinco jogadores: {area:2057} fica sob {area:2298}, a cidade-ilha no sudeste de {zone:1422}. No porão do {object:179746}, primeiro mate todos os monstros da sala, depois use o {item:18746} no centro dela: seguem-se quatro ondas de espíritos, cada uma terminando com um mini-chefe Aspecto (a primeira onda fraca e lenta, as outras elite). Lute num canto para nada mais se juntar, e beba entre as ondas: é longo. Depois {npc:14516} (elite de nível 62) aparece: ele golpeia em arco, lança {spell:686} e {spell:6958} e domina a mente de um jogador contra o grupo. A cabeça dele sempre cai.",

	-- Step 5: Sagorne Creststrider
	-- {npc:13417} Sagorne Creststrider · {item:20134} Skyfury Helm
	["{npc:13417}: 200 Horde reputation; the {item:20134} may be gone"] = "{npc:13417}: 200 de reputação da Horda; {item:20134} pode ter sumido",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {area:2057} fight at 60 for Horde reputation; Forever removed the {item:20134}."] = "Uma luta em {area:2057} no nível 60 por reputação com a Horda; o Forever removeu o {item:20134}.",
	-- ["An {item:12800} comes from Thorium veins, a {item:18335} from the elites of the {zone:1422}, both rarely: buy them at the auction house if you can."] = "Um {item:12800} vem de veios de tório, um {item:18335} dos elites das {zone:1422}, ambos raramente: compre-os na casa de leilões se puder.",
	-- ["At 58 {npc:13417}, the shaman trainer in the {object:172957}, asks for two rare diamonds."] = "No nível 58, {npc:13417}, o instrutor de xamã no {object:172957}, pede dois diamantes raros.",
	-- ["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. Use the {item:18746} in the heart of the {object:179746}'s basement, beat the spirits it calls, then {npc:14516}. All are elite: bring a group."] = "{area:2057} fica embaixo de {area:2298}, a cidade na ilha do sudeste das {zone:1422}. Use o {item:18746} no centro do porão do Grande Ossuário, derrote os espíritos que ele chama e depois {npc:14516}. Todos são elite: leve um grupo.",
}
