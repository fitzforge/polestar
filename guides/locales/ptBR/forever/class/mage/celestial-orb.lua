-- Portuguese (Brazil) (ptBR): the guide forever/class/mage/celestial-orb (forever/class/mage/celestial-orb.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7515} Celestial Orb
	["{item:7515} and Stave"] = "{item:7515} e Báculo",
	["An off-hand orb or a staff for the late 30s, your pick."] = "Um orbe de mão secundária ou um cajado para o fim dos 30, à sua escolha.",

	-- Step 1: Return to the Marsh (Stormwind)
	-- {npc:5497} Jennea Cannon · {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:6546} Tabetha · {zone:1455} Ironforge
	["{npc:5497} at the top of the Wizard's Sanctum, {zone:1453}'s {object:2101}, sends you back to {npc:6546}; Bink in {zone:1455} gives the same quest."] = "{npc:5497}, no topo do Sacrário dos Teurgos, no {object:2101} de {zone:1453}, manda você de volta a {npc:6546}; Bink, em {zone:1455}, dá a mesma missão.",

	-- Step 2: Return to the Marsh (Orgrimmar)
	-- {npc:5885} Deino · {zone:1454} Orgrimmar · {object:173161} Darkbriar Lodge (no name in this language: may be words) · {npc:6546} Tabetha · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity · {npc:3048} Ursyn Ghull · {zone:1456} Thunder Bluff
	["{npc:5885}, one of {zone:1454}'s mage trainers in {object:173161}, sends you back to {npc:6546}; {npc:4568} in the {zone:1458} and {npc:3048} in {zone:1456} give the same quest."] = "{npc:5885}, um dos instrutores de mago de {zone:1454}, em {object:173161}, manda você de volta a {npc:6546}; {npc:4568} em {zone:1458} e {npc:3048} em {zone:1456} dão a mesma missão.",

	-- Step 3: Tabetha
	-- {npc:6546} Tabetha · {area:508} Stonemaul Ruins
	["{npc:6546}'s cottage is deep in the marsh west of Theramore, just north of the {area:508}; come in from the west road, the elites roam its east side."] = "A cabana de {npc:6546} fica lá no fundo do pântano a oeste de Theramore, logo ao norte de {area:508}; chegue pela estrada do oeste, os elites andam pelo lado leste.",

	-- Step 4: The Infernal Orb
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace · {area:2408} Shadowprey Village · {item:7291} Infernal Orb · {spell:686} Shadow Bolt · {zone:1412} Mulgore · {zone:1456} Thunder Bluff
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner · Nether Maidens = {npc:4679} Nether Maiden
	["The Burning Blade Summoners (level 38-39, not elite) work the {area:602} in southern {zone:1443}, east of {area:2408}, and every one carries an {item:7291}. They cast {spell:686} from 40 yards, keep an imp at their side and run for help at low health; Nether Maidens patrol the pillared ruin beside them, so pull with care. Horde mages: one more summoner stands alone in western {zone:1412}, south-west of {zone:1456}."] = "Os Evocadores da Lâmina Ardente (nível 38-39, não elite) trabalham em {area:602}, no sul de {zone:1443}, a leste de {area:2408}, e todos carregam um {item:7291}. Eles soltam {spell:686} de 40 metros, têm um diabrete do lado e fogem atrás de ajuda com pouca vida; Donzelas do Éter patrulham a ruína de colunas ao lado, então puxe com cuidado. Magos da Horda: tem mais um evocador sozinho no oeste de {zone:1412}, a sudoeste de {zone:1456}.",

	-- Step 5: The Exorcism
	-- {npc:6546} Tabetha · {quest:1955} The Exorcism · {npc:6549} Demon of the Orb
	["Back at {npc:6546}'s. Kill the critters around the cottage first: they join the fight. Accepting {quest:1955} starts a 3 minute timer, and {npc:6546} calls the {npc:6549} out in her garden: a level 40 elite that resists many spells, roots and slows. Grouping up is encouraged: a mage of 40 may need help or potions, at about 45 it is soloable. You can pull it from range from the dock. The timer keeps running after it dies, so hand the quest in straight away. If time runs out, abandon the quest and take it again; she calls the demon again."] = "De volta à casa de {npc:6546}. Mate os bichinhos em volta da cabana antes: eles entram na briga. Aceitar {quest:1955} começa um cronômetro de 3 minutos, e {npc:6546} chama o {npc:6549} no jardim dela: um elite de nível 40 que resiste a muitos feitiços, enraizamentos e lentidões. Vale ir em grupo: um mago de nível 40 pode precisar de ajuda ou de poções; lá pelo 45, dá para encarar sozinho. Dá para puxar de longe, lá do cais. O cronômetro continua correndo depois que ele morre, então entregue a missão na hora. Se o tempo acabar, abandone a missão e pegue de novo; ela chama o demônio outra vez.",
	-- {npc:6549} Demon of the Orb
	["{npc:6549} (elite, 40)"] = "{npc:6549} (elite, 40)",

	-- Step 6: Power in Uldaman
	-- {area:1517} Uldaman · {zone:1418} Badlands · {area:1898} Dustwind Gulch · {npc:7023} Obsidian Sentinel · {npc:7209} Obsidian Shard
	["{area:1517} is a dungeon in the northern {zone:1418}: a group of five. Go in by the rear entrance, a cave in {area:1898} south-east of the main entrance (elite dragons fly nearby): the {npc:7023} (level 42 elite) stands just past the first door. At 80, 60, 40 and 20 percent it breaks off an {npc:7209}, an elite too; while a shard lives, both reflect targeted spells, so use area spells and your wand on them. A solo trick: step out through the nearby zone line each time a shard appears; the Sentinel heals but keeps shrinking. It always drops the power source, and takes 2 hours to come back."] = "{area:1517} é uma masmorra no norte de {zone:1418}: grupo de cinco. Entre pela entrada dos fundos, uma caverna em {area:1898}, a sudeste da entrada principal (dragões elite voam por perto): a {npc:7023} (elite nível 42) fica logo depois da primeira porta. Com 80, 60, 40 e 20 por cento ela solta um {npc:7209}, também elite; enquanto um estilhaço estiver vivo, os dois refletem feitiços com alvo, então use feitiços de área e a varinha neles. Truque para quem está sozinho: saia pela divisa de zona ali perto toda vez que surgir um estilhaço; a Sentinela se cura, mas vai encolhendo. Ela sempre deixa cair a fonte de poder e leva 2 horas para voltar.",

	-- Step 7: Mana Surges
	-- {npc:6546} Tabetha · {quest:1957} Mana Surges · {spell:403} Lightning Bolt
	["Back to {npc:6546}. Accepting {quest:1957} opens a rift beside her cottage and starts a 10 minute timer: twelve {quest:1957} (level 40, Shock and {spell:403}) come out about four at a time. Attacking one does not pull the rest. Standing at the edge of the field draws them all; the tree south-west of it is out of their reach but in your spell range. Kill twelve and hand in before the timer runs out."] = "De volta a {npc:6546}. Aceitar {quest:1957} abre uma fenda ao lado da cabana dela e começa um cronômetro de 10 minutos: doze {quest:1957} (nível 40, Choque e {spell:403}) saem mais ou menos quatro de cada vez. Atacar um não puxa os outros. Ficar na borda do campo atrai todos; a árvore a sudoeste dele fica fora do alcance deles, mas dentro do alcance dos seus feitiços. Mate doze e entregue antes de o cronômetro acabar.",
	-- {quest:1958} Celestial Power · {item:7515} Celestial Orb · {item:9517} Celestial Stave
	["{quest:1958}: the {item:7515} (off-hand) or the {item:9517}"] = "{quest:1958}: o {item:7515} (mão secundária) ou o {item:9517}",

	-- Step 8: Tabetha's Task (optional)
	-- {quest:2861} Tabetha's Task
	["{quest:2861} (optional)"] = "{quest:2861} (opcional)",
	-- {npc:6546} Tabetha · {npc:5497} Jennea Cannon · {npc:4568} Anastasia Hartwell · {npc:5885} Deino · {quest:2861} Tabetha's Task · {quest:2846} Tiara of the Deep · {npc:7795} Hydromancer Velratha · {area:978} Zul'Farrak · {zone:1446} Tanaris · {item:9527} Spellshifter Rod · {item:9531} Gemshale Pauldrons
	["At 40 the mage trainers who send you to {npc:6546} ({npc:5497}, Bink, {npc:4568}, {npc:5885}) also have {quest:2861}, a quest any class can do. {npc:6546} then wants the {quest:2846} from {npc:7795}, a level 46 elite naga in {area:978}, the troll dungeon in north-western {zone:1446}: a group of five, level 44-54. She is one of the bosses by the sacred pool, and the tiara always drops. The reward window shows the {item:9527} and the {item:9531}."] = "No nível 40, os instrutores de mago que mandam você a {npc:6546} ({npc:5497}, Bink, {npc:4568}, {npc:5885}) também têm {quest:2861}, uma missão que qualquer classe pode fazer. {npc:6546} então quer a {quest:2846} de {npc:7795}, uma naga elite de nível 46 em {area:978}, a masmorra troll no noroeste de {zone:1446}: grupo de cinco, nível 44-54. Ela é uma das chefes junto ao poço sagrado, e a tiara sempre cai. A janela de recompensa mostra o {item:9527} e as {item:9531}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:6546}. She opens a mana rift beside her cottage: kill twelve {quest:1957} within ten minutes."] = "De volta a {npc:6546}. Ela abre uma fenda de mana ao lado da cabana: mate doze {quest:1957} em dez minutos.",
	-- ["The Burning Blade Summoners work the {area:602} in southern {zone:1443}; any of them carries an {item:7291}."] = "Os Evocadores da Lâmina Ardente trabalham no {area:602}, no sul de {zone:1443}; qualquer um deles leva um {item:7291}.",
	-- ["{area:1517} is a dungeon in the northern {zone:1418}, by the {object:178824}: a group of five. Defeat the {npc:7023} inside for its power source."] = "{area:1517} é uma masmorra no norte de {zone:1418}, junto à {object:178824}: um grupo de cinco. Derrote o {npc:7023} lá dentro para pegar a fonte de energia dele.",
	-- ["{npc:5497} in the Wizard's Sanctum, {zone:1453}'s {object:2101}, sends you back to {npc:6546}; Bink in {zone:1455} gives the same quest."] = "{npc:5497}, na torre do {object:2101} de {zone:1453}, manda você de volta a {npc:6546}; Bink em {zone:1455} dá a mesma missão.",
	-- ["{npc:6546} draws the demon out of the orb beside her cottage. The {npc:6549} is elite: grouping up is advised. You have three minutes before it slips back into the orb."] = "{npc:6546} tira o demônio do orbe ao lado da cabana dela. O {npc:6549} é elite: é recomendado formar grupo. Você tem três minutos antes que ele volte para o orbe.",
	-- ["{npc:6546}'s cottage is deep in the marsh west of Theramore, just north of the {area:508}."] = "A cabana de {npc:6546} fica no fundo do pântano a oeste de Theramore, logo ao norte das {area:508}.",
}
