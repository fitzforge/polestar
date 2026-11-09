-- Portuguese (Brazil) (ptBR): the guide forever/alliance/40-50/06-searing-gorge (forever/alliance/40-50/06-searing-gorge.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: To Stoutlager Inn
	-- {area:2101} Stoutlager Inn
	["To {area:2101}"] = "Para {area:2101}",

	-- Step 2: Into Searing Gorge
	-- {zone:1427} Searing Gorge
	["Into {zone:1427}"] = "Rumo a {zone:1427}",

	-- Step 3: Searing Gorge
	["The Grimesilt outhouse"] = "A casinha de Pedrassuja",

	-- Step 4: The Grimesilt outhouse
	-- {area:144} Thelsamar · {zone:1418} Badlands · {area:340} Kargath · {zone:1427} Searing Gorge · {area:247} Grimesilt Dig Site · {item:4306} Silk Cloth
	-- plural, as words: Dark Iron Geologists = {npc:5839} Dark Iron Geologist
	["From {area:144} ride south into the {zone:1418}, then west past the Horde town of {area:340} (give it room) and up the trail into {zone:1427}: the {area:247} is just inside, in the south-east. The prisoner in the wooden outhouse wants 15 {item:4306} and eight dead Dark Iron Geologists from the dig site around it. The outhouse also opens with the key, if you found one."] = "De {area:144}, siga para o sul até {zone:1418}, depois a oeste, passando pela cidade da Horda de {area:340} (dê espaço a ela), e suba a trilha até {zone:1427}: {area:247} fica logo na entrada, no sudeste. O prisioneiro na casinha de madeira quer 15 {item:4306} e oito Geólogos Ferro Negro mortos do sítio de escavação em volta. A casinha também abre com a chave, se você encontrou uma.",

	-- Step 5: The Grimesilt outhouse
	-- {zone:1446} Tanaris · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh
	["The prisoner's next task, Ledger from {zone:1446}, sends you to the {zone:1435} and {zone:1445}: skip it."] = "A próxima tarefa do prisioneiro, Livro-Caixa de {zone:1446}, manda você para {zone:1435} e {zone:1445}: pule.",

	-- Step 6: Level 48.27
	["Level 48.27"] = "Nível 48.27",
	-- {item:3985} Monogrammed Sash · {area:2100} Maraudon · {area:978} Zul'Farrak
	["If you skipped The {item:3985} or Facing Negolash, grind here to level 48.27 to stay on the route's plan. Or, with a group, run the {area:2100} dungeon or the {area:978} dungeon instead."] = "Se você pulou {item:3985} ou Confrontando Negolash, mate monstros aqui até o nível 48.27 para seguir o plano da rota. Ou, com um grupo, faça a masmorra {area:2100} ou a masmorra {area:978}.",
	-- {npc:5839} Dark Iron Geologist
	["grind on {npc:5839}"] = "mate {npc:5839} até subir",

	-- Step 7: Dorius Stonetender
	-- {area:247} Grimesilt Dig Site · {area:1959} Dustfire Valley · {object:175704} Singed Letter
	["Dorius stands by the road beside the {area:247}. Escort him north-east to {area:1959} and keep him alive; when it is over, read the {object:175704} he leaves on the road."] = "Dório fica junto à estrada, ao lado de {area:247}. Escolte-o para nordeste até {area:1959} e mantenha-o vivo; quando acabar, leia {object:175704}, que ele deixa na estrada.",
	-- {npc:8256} Curator Thorius · {area:1537} Ironforge
	["For {npc:8256} in {area:1537}, later"] = "Para {npc:8256} em {area:1537}, depois",

	-- Step 8: Thorium Point
	-- {area:1446} Thorium Point
	["Ride west along the north of the Gorge to {area:1446}, the scaffolded camp on the north-west rim."] = "Cavalgue para oeste pelo norte da Garganta até {area:1446}, o acampamento de andaimes na borda noroeste.",
	-- {object:179827} Wanted/Missing/Lost & Found
	["The {object:179827} board"] = "O quadro {object:179827}",

	-- Step 10: Zamael Lunthistle
	-- {area:1446} Thorium Point
	["The night elf stands alone west of {area:1446}. Hear his story."] = "O elfo noturno está sozinho a oeste de {area:1446}. Ouça a história dele.",

	-- Step 13: Greater Lava Spiders
	-- plural, as words: Greater Lava Spiders = {npc:5858} Greater Lava Spider
	["Greater Lava Spiders"] = "Aranhas de Lava Abrasadoras",
	-- {npc:8436} Zamael Lunthistle · {npc:8479} Velarok Windblade
	["The spiders roam the plateaus and lava pools south of {npc:8436}, on the way to {npc:8479}."] = "As aranhas rondam os platôs e as poças de lava ao sul de {npc:8436}, no caminho até {npc:8479}.",

	-- Step 14: Velarok Windblade
	-- {npc:8479} Velarok Windblade · {area:1446} Thorium Point
	["{npc:8479} stands on the rim of the Cauldron, south of {area:1446}. Listen to his story."] = "{npc:8479} fica na borda de O Caldeirão, ao sul de {area:1446}. Ouça a história dele.",

	-- Step 17: Golems and elementals
	["Golems and elementals"] = "Golems e elementais",
	-- {npc:8479} Velarok Windblade
	-- plural, as words: Heavy War Golems = {npc:5854} Heavy War Golem · Magma Elementals = {npc:5855} Magma Elemental
	["Heavy War Golems patrol the floor of the Cauldron below {npc:8479}; Magma Elementals drift among them. Golems and elementals drop the oil, elementals the hearts."] = "Golens de Guerra Pesados patrulham o fundo de O Caldeirão, abaixo de {npc:8479}; Elementais de Magma vagam entre eles. Golens e elementais deixam cair o óleo; os elementais, os corações.",

	-- Step 19: Dark Iron dwarves: kill these as you meet them
	-- {object:147516} Dark Iron (no name in this language: may be words)
	["{object:147516} dwarves: kill these as you meet them"] = "Anões {object:147516}: vá matando estes pelo caminho",
	-- {item:10551} Thorium Plated Dagger · {item:18959} Smithing Tuyere · {object:147516} Dark Iron (no name in this language: may be words) · {item:11818} Grimesilt Outhouse Key
	-- plural, as words: Dark Iron Slavers = {npc:5844} Dark Iron Slaver
	["Taskmasters and Slavers drive the slaves all over the Cauldron, and any of them can carry a {item:10551}. The Steamsmiths work at the furnaces in the middle (the {item:18959}), the Lookouts stand on the southern ridges (the Spyglass). Any {object:147516} may drop the {item:11818}: keep it.\nCareful: Dark Iron Slavers (level 45-46) call for help from allies within 15 yd when pulled, cast Net from up to 15 yd, and use Rend in melee."] = "Capatazes e Feitores comandam os escravos por todo o Caldeirão, e qualquer um deles pode carregar {item:10551}. Os Vaporistas trabalham nas fornalhas do meio ({item:18959}), os Atalaias ficam nas cristas do sul (a Luneta). Qualquer {object:147516} pode soltar {item:11818}: guarde-o.\nCuidado: Feitores Ferro Negro (nível 45-46) chamam aliados a até 15 metros quando são puxados, lançam Rede a até 15 metros e usam Rasgar em combate corpo a corpo.",

	-- Step 22: Searing Gorge: kill these as you meet them
	-- {zone:1427} Searing Gorge
	["{zone:1427}: kill these as you meet them"] = "{zone:1427}: vá matando estes pelo caminho",
	-- {area:1443} The Slag Pit · {npc:14621} Overseer Maltorius
	-- plural, as words: Incendosaurs = {npc:9318} Incendosaur
	["{area:1443} opens in the north of the Cauldron. The Secret Plans lie on its upper ledge; Incendosaurs swim in the lava pools further in, so pull them to the edge. Stay clear of {npc:14621} and his elite guards deep inside."] = "{area:1443} se abre no norte de O Caldeirão. As Instruções Secretas: Fluxo Ígneo ficam na saliência superior; Incendossauros nadam nas poças de lava mais adentro, então puxe-os até a borda. Fique longe de {npc:14621} e de seus guardas de elite lá no fundo.",
	-- {item:18922} Secret Plans: Fiery Flux
	["{item:18922}; below ground"] = "{item:18922}; no subterrâneo",

	-- Step 23: Searing Gorge: kill these as you meet them
	-- {npc:14621} Overseer Maltorius
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:14621} is a level 50 elite: most classes solo it at level 52, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {npc:14621} é elite de nível 50: a maioria das classes encara sozinha no nível 52, mas talvez você precise de ajuda. Se estiver sozinho, pule: a rota faz você recuperar a XP matando monstros.",

	-- Step 25: Level 48.66
	["Level 48.66"] = "Nível 48.66",
	-- {quest:7701} WANTED: Overseer Maltorius · {area:2100} Maraudon · {area:978} Zul'Farrak
	["If you skipped {quest:7701}, grind here to level 48.66 to stay on the route's plan. Or, with a group, run the {area:2100} dungeon or the {area:978} dungeon instead."] = "Se você pulou {quest:7701}, mate monstros aqui até o nível 48.66 para seguir o plano da rota. Ou, com um grupo, faça a masmorra {area:2100} ou a masmorra {area:978}.",
	-- {npc:9318} Incendosaur
	["grind on {npc:9318}"] = "mate {npc:9318} até subir",

	-- Step 27: The Flame's Casing
	-- {npc:5860} Twilight Dark Shaman
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:5860} (level 50 elite) needs a group of 3. Skip it if you are alone: the route has you grind the XP back."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {npc:5860} (elite nível 50) pede um grupo de 3. Se estiver sozinho, pule: a rota faz você recuperar a XP matando monstros.",

	-- Step 29: Level 48.98
	["Level 48.98"] = "Nível 48.98",
	-- {quest:3452} The Flame's Casing · {area:2100} Maraudon · {area:978} Zul'Farrak
	["If you skipped {quest:3452}, grind here to level 48.98 to stay on the route's plan. Or, with a group, run the {area:2100} dungeon or the {area:978} dungeon instead."] = "Se você pulou {quest:3452}, mate monstros aqui até o nível 48.98 para seguir o plano da rota. Ou, com um grupo, faça a masmorra {area:2100} ou a masmorra {area:978}.",
	-- {npc:5844} Dark Iron Slaver
	["grind on {npc:5844}"] = "mate {npc:5844} até subir",

	-- Step 30: Margol's Horn
	-- {quest:3181} The Horn of the Beast
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:3181} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {quest:3181} pede um grupo de 2. Se estiver sozinho, pule: a rota faz você recuperar a XP matando monstros.",
	["Below ground"] = "No subterrâneo",

	-- Step 33: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Voe para {area:1537}",
	-- {area:1446} Thorium Point
	["{area:1446} flight master"] = "Mestre de voo de {area:1446}",

	-- Step 34: Class trainer
	["Class trainer"] = "Instrutor de classe",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["From {area:144} ride south into the {zone:1418}, then west past the Horde town of {area:340} (give it room) and up the trail into {zone:1427}. {area:1446} is the scaffolded camp on the north-west rim."] = "De {area:144}, cavalgue para o sul até {zone:1418}, depois para o oeste passando pela cidade da Horda, {area:340} (mantenha distância), e suba a trilha até {zone:1427}. {area:1446} é o acampamento com andaimes na borda noroeste.",
	-- ["Greater Lava Spiders"] = "Aranhas de Lava Abrasadoras",
	-- ["Kalaran Windblade"] = "Kalaran Finalâmina",
	-- ["Ride east across the Cauldron to the {area:247} in the south-east. The prisoner in the wooden outhouse wants 15 {item:4306} and eight dead Dark Iron Geologists from the dig site around it. The outhouse also opens with the key, if you found one."] = "Cavalgue para o leste pelo Caldeirão até {area:247}, no sudeste. O prisioneiro na casinha de madeira quer 15 {item:4306} e oito Geólogos Ferro Negro mortos da escavação ao redor. A casinha também abre com a chave, se você encontrou uma.",
	-- ["Ride north-west across the Cauldron to {area:1446}, the scaffolded camp on the north-west rim."] = "Siga para noroeste pelo Caldeirão até {area:1446}, o acampamento de andaimes na borda noroeste.",
	-- ["Taskmasters and Slavers drive the slaves all over the Cauldron, and any of them can carry a {item:10551}. The Steamsmiths work at the furnaces in the middle (the {item:18959}), the Lookouts stand on the southern ridges (the Spyglass). Any {object:147516} may drop the {item:11818}: keep it."] = "Capatazes Ferro Negro e Feitores Ferro Negro tocam os escravos por todo O Caldeirão, e qualquer um deles pode carregar uma {item:10551}. Os Vaporistas Ferro Negro trabalham nas fornalhas no meio (a {item:18959}); os Atalaias Ferro Negro ficam nas cristas do sul (a Luneta do Espia). Qualquer {object:147516} pode deixar cair a {item:11818}: guarde-a.",
	-- ["The dwarf stands by the road at the dig site. Follow him north along the road and fight off the {object:147516} ambushes. When it is over, read the {object:175704} he leaves on the road in {area:1959}."] = "O anão fica à beira da estrada, na escavação. Siga-o para o norte pela estrada e repila as emboscadas {object:147516}. No fim, leia a {object:175704} que ele deixa na estrada em {area:1959}.",
	-- ["The spiders roam the plateaus and lava pools in the south-west of the gorge."] = "As aranhas vagam pelos platôs e poças de lava no sudoeste da garganta.",
	-- ["{area:1442}: kill these as you meet them"] = "{area:1442}: vá matando estes pelo caminho",
	-- ["{npc:6734}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6734}: o guia anterior leva você até aqui com a pedra de regresso, então isto costuma ser marcado na hora",
	-- ["{object:147516} dwarves"] = "Anões {object:147516}",
}
