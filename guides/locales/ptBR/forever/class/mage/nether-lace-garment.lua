-- Portuguese (Brazil) (ptBR): the guide forever/class/mage/nether-lace-garment (forever/class/mage/nether-lace-garment.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A robe or a tunic for Horde mages in their late 20s."] = "Um manto ou uma túnica para magos da Horda no fim dos 20 e poucos.",

	-- Step 1: Anastasia Hartwell
	-- {npc:4568} Anastasia Hartwell · {zone:1458} Undercity · {object:36082} Magic Quarter (no name in this language: may be words) · {spell:3563} Teleport: Undercity · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["{npc:4568} stands in the {zone:1458}'s {object:36082}. Orcs and Trolls use {spell:3563} or take the zeppelin from {zone:1454} to {zone:1420} for her."] = "{npc:4568} fica no {object:36082} da {zone:1458}. Orcs e Trolls usam {spell:3563} ou pegam o zepelim de {zone:1454} até {zone:1420} para chegar a ela.",

	-- Step 2: Deino
	-- {zone:1454} Orgrimmar · {spell:3567} Teleport: Orgrimmar · {object:173161} Darkbriar Lodge (no name in this language: may be words) · {npc:5885} Deino · {object:172961} Valley of Spirits (no name in this language: may be words) · {item:7269} Deino's Flask
	["Take the zeppelin to {zone:1454} (or use {spell:3567}, which lands you on the upper floor of {object:173161}). {npc:5885} stands with the mage trainers on the lower floor of {object:173161} in the {object:172961}. She hands you {item:7269}."] = "Pegue o zepelim até {zone:1454} (ou use {spell:3567}, que deixa você no andar de cima de {object:173161}). {npc:5885} fica com os instrutores de mago no andar de baixo de {object:173161}, no {object:172961}. Ela entrega {item:7269}.",

	-- Step 3: The Xavian Waterfall
	-- {object:174797} Xavian Waterfall (no name in this language: may be words)
	["The {object:174797}"] = "A {object:174797}",
	-- {area:431} Splintertree Post · {area:429} Xavian
	["Fly to {area:431} and swim north up the river past the big lake to its far northern end, where the zone text reads {area:429}; satyrs hold the ruins around it and a few river beasts are in the way. Swim right in under the highest waterfall until you touch the rock wall, then use the flask (you can stay in the water). The waterfalls on the western Falfarren fork do not work."] = "Voe para {area:431} e nade rio acima para o norte, passando o lago grande, até a ponta norte, onde o texto da zona diz {area:429}; sátiros ocupam as ruínas em volta e alguns bichos do rio atrapalham. Nade bem para baixo da cachoeira mais alta até encostar na parede de pedra e use o frasco (dá para ficar na água). As cachoeiras do braço de Falfarren, a oeste, não funcionam.",
	-- {item:7269} Deino's Flask
	["{item:7269}, under the falls"] = "{item:7269}, embaixo da cachoeira",

	-- Step 4: Back to Deino
	-- {npc:5885} Deino
	["Back to {npc:5885}"] = "De volta a {npc:5885}",

	-- Step 5: The Laughing Sisters
	-- {quest:1945} Laughing Sisters
	["The {quest:1945}"] = "As {quest:1945}",
	-- {quest:1945} Laughing Sisters · {area:426} Raynewood Retreat · {zone:1440} Ashenvale
	["The {quest:1945}, dryads of level 24-25, roam around the {area:426} in central {zone:1440}; every one drops a hair and they come back after 5 minutes. They often resist fire (and some frost and shadow): arcane spells land best. Each runs for help at low health. Keep clear of the guards by the white tower of the retreat, who hit hard."] = "As {quest:1945}, dríades de nível 24-25, andam em volta de {area:426}, no centro de {zone:1440}; toda uma deixa cair um fio de cabelo, e voltam depois de 5 minutos. Elas costumam resistir a fogo (e algumas a gelo e sombra): feitiço arcano pega melhor. Cada uma foge atrás de ajuda com pouca vida. Fique longe dos guardas junto à torre branca do retiro, que batem forte.",

	-- Step 6: Kil'hala
	-- {npc:3484} Kil'hala
	["{npc:3484}, a troll tailor, works at the Crossroads. The robe gives intellect, stamina and spirit; the tunic more intellect and stamina but no spirit."] = "{npc:3484}, uma alfaiate troll, trabalha em A Encruzilhada. O manto dá intelecto, vigor e espírito; a túnica dá mais intelecto e vigor, mas nada de espírito.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A robe or a tunic for Undead and Troll mages in their late 20s."] = "Uma veste ou túnica para magos Mortos-vivos e Trolls no fim dos níveis 20.",
	-- ["Satyrs hold the ruins of {area:429} in eastern {zone:1440}. {spell:9052} at the bottom of the highest waterfall."] = "Sátiros dominam as ruínas de {area:429}, no leste de {zone:1440}. {spell:9052} no pé da cachoeira mais alta.",
	-- ["Take the zeppelin to {zone:1454}. {npc:5885} is one of {zone:1454}'s mage trainers."] = "Pegue o zepelim para {zone:1454}. {npc:5885} é um dos instrutores de magos de {zone:1454}.",
	-- ["The {quest:1945}, dryads, gather near the {area:426} in central {zone:1440}."] = "As {quest:1945}, dríades, se reúnem perto do {area:426}, no centro de {zone:1440}.",
	-- ["{npc:3484}, a troll tailor, works at the {area:380}."] = "{npc:3484}, uma alfaiate troll, trabalha na {area:380}.",
	-- ["{npc:4568} stands in the {zone:1458}'s {object:36082}. Trolls take the zeppelin from {zone:1454} to {zone:1420} for her."] = "{npc:4568} fica no {object:36082} de {zone:1458}. Trolls pegam o zepelim de {zone:1454} para {zone:1420} para chegar até ela.",
}
