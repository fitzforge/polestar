-- Portuguese (Brazil) (ptBR): the guide forever/alliance/40-50/06-searing-gorge (forever/alliance/40-50/06-searing-gorge.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thorium Point
	-- {area:144} Thelsamar · {zone:1418} Badlands · {area:340} Kargath · {zone:1427} Searing Gorge · {area:1446} Thorium Point
	["From {area:144} ride south into the {zone:1418}, then west past the Horde town of {area:340} (give it room) and up the trail into {zone:1427}. {area:1446} is the scaffolded camp on the north-west rim."] = "De {area:144}, cavalgue para o sul até {zone:1418}, depois para o oeste passando pela cidade da Horda, {area:340} (mantenha distância), e suba a trilha até {zone:1427}. {area:1446} é o acampamento com andaimes na borda noroeste.",
	-- {object:179827} Wanted/Missing/Lost & Found
	["The {object:179827} board"] = "O quadro {object:179827}",

	-- Step 2: Zamael Lunthistle
	-- {area:1446} Thorium Point
	["The night elf stands alone west of {area:1446}. Hear his story."] = "O elfo noturno está sozinho a oeste de {area:1446}. Ouça a história dele.",

	-- Step 3: Kalaran Windblade
	-- {area:1446} Thorium Point
	["Kalaran stands on the rim of the Cauldron, south of {area:1446}. Listen to his story."] = "Kalaran fica na borda de O Caldeirão, ao sul de {area:1446}. Ouça a história dele.",

	-- Step 4: Golems and elementals
	["Golems and elementals"] = "Golems e elementais",
	-- plural, as words: Heavy War Golems = {npc:5854} Heavy War Golem · Magma Elementals = {npc:5855} Magma Elemental
	["Heavy War Golems patrol the floor of the Cauldron below Kalaran; Magma Elementals drift among them. Golems and elementals drop the oil, elementals the hearts."] = "Golems de Guerra Pesados patrulham o fundo de O Caldeirão, abaixo de Kalaran; Elementais de Magma vagam entre eles. Golems e elementais deixam cair o óleo; os elementais, os corações.",

	-- Step 6: Dark Iron dwarves
	-- {object:147516} Dark Iron (no name in this language: may be words)
	["{object:147516} dwarves"] = "Anões {object:147516}",
	-- {item:10551} Thorium Plated Dagger · {item:18959} Smithing Tuyere · {object:147516} Dark Iron (no name in this language: may be words) · {item:11818} Grimesilt Outhouse Key
	["Taskmasters and Slavers drive the slaves all over the Cauldron, and any of them can carry a {item:10551}. The Steamsmiths work at the furnaces in the middle (the {item:18959}), the Lookouts stand on the southern ridges (the Spyglass). Any {object:147516} may drop the {item:11818}: keep it."] = "Capatazes Ferro Negro e Feitores Ferro Negro tocam os escravos por todo O Caldeirão, e qualquer um deles pode carregar uma {item:10551}. Os Vaporistas Ferro Negro trabalham nas fornalhas no meio (a {item:18959}); os Atalaias Ferro Negro ficam nas cristas do sul (a Luneta do Espia). Qualquer {object:147516} pode deixar cair a {item:11818}: guarde-a.",

	-- Step 7: Greater Lava Spiders
	-- plural, as words: Greater Lava Spiders = {npc:5858} Greater Lava Spider
	["Greater Lava Spiders"] = "Aranhas de Lava Abrasadoras",
	["The spiders roam the plateaus and lava pools in the south-west of the gorge."] = "As aranhas vagam pelos platôs e poças de lava no sudoeste da garganta.",

	-- Step 9: The Slag Pit
	-- {area:1443} The Slag Pit · {npc:14621} Overseer Maltorius
	-- plural, as words: Incendosaurs = {npc:9318} Incendosaur
	["{area:1443} opens in the north of the Cauldron. The Secret Plans lie on its upper ledge; Incendosaurs swim in the lava pools further in, so pull them to the edge. Stay clear of {npc:14621} and his elite guards deep inside."] = "{area:1443} se abre no norte de O Caldeirão. As Instruções Secretas: Fluxo Ígneo ficam na saliência superior; Incendossauros nadam nas poças de lava mais adentro, então puxe-os até a borda. Fique longe de {npc:14621} e de seus guardas de elite lá no fundo.",

	-- Step 11: The Grimesilt outhouse
	["The Grimesilt outhouse"] = "A casinha de Pedrassuja",
	-- {area:247} Grimesilt Dig Site · {item:4306} Silk Cloth
	-- plural, as words: Dark Iron Geologists = {npc:5839} Dark Iron Geologist
	["Ride east across the Cauldron to the {area:247} in the south-east. The prisoner in the wooden outhouse wants 15 {item:4306} and eight dead Dark Iron Geologists from the dig site around it. The outhouse also opens with the key, if you found one."] = "Cavalgue para o leste pelo Caldeirão até {area:247}, no sudeste. O prisioneiro na casinha de madeira quer 15 {item:4306} e oito Geólogos Ferro Negro mortos da escavação ao redor. A casinha também abre com a chave, se você encontrou uma.",
	-- {zone:1446} Tanaris · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh
	["The prisoner's next task, Ledger from {zone:1446}, sends you to the {zone:1435} and {zone:1445}: skip it."] = "A próxima tarefa do prisioneiro, Livro-Caixa de {zone:1446}, manda você para {zone:1435} e {zone:1445}: pule.",

	-- Step 12: Dorius Stonetender
	-- {object:147516} Dark Iron (no name in this language: may be words) · {object:175704} Singed Letter · {area:1959} Dustfire Valley
	["The dwarf stands by the road at the dig site. Follow him north along the road and fight off the {object:147516} ambushes. When it is over, read the {object:175704} he leaves on the road in {area:1959}."] = "O anão fica à beira da estrada, na escavação. Siga-o para o norte pela estrada e repila as emboscadas {object:147516}. No fim, leia a {object:175704} que ele deixa na estrada em {area:1959}.",
	-- {npc:8256} Curator Thorius · {zone:1455} Ironforge
	["For {npc:8256} in {zone:1455}, later"] = "Para {npc:8256} em {zone:1455}, depois",
}
