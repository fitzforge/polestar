-- Portuguese (Brazil) (ptBR): the guide forever/alliance/40-50/06-searing-gorge (forever/alliance/40-50/06-searing-gorge.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Hearth to Stoutlager Inn
	-- {area:2101} Stoutlager Inn
	["Hearth to {area:2101}"] = "",

	-- Step 2: To Stoutlager Inn
	-- {area:2101} Stoutlager Inn
	["To {area:2101}"] = "",

	-- Step 3: Into Searing Gorge
	-- {area:51} Searing Gorge
	["Into {area:51}"] = "",

	-- Step 5: The Grimesilt outhouse
	["The Grimesilt outhouse"] = "A casinha de Pedrassuja",
	-- {area:247} Grimesilt Dig Site · {item:4306} Silk Cloth · {object:175704} Singed Letter · {area:1959} Dustfire Valley
	-- plural, as words: Dark Iron Geologists = {npc:5839} Dark Iron Geologist
	["Ride east across the Cauldron to the {area:247} in the south-east. The prisoner in the wooden outhouse wants 15 {item:4306} and eight dead Dark Iron Geologists from the dig site around it. The outhouse also opens with the key, if you found one.\nThe dwarf stands by the road at the dig site. When it is over, read the {object:175704} he leaves on the road in {area:1959}."] = "",

	-- Step 7: Level 48.27
	["Level 48.27"] = "",
	-- {item:3985} Monogrammed Sash
	["If you skipped The {item:3985} or Facing Negolash, grind here to level 48.27 to stay on the route's plan."] = "",
	-- {npc:5839} Dark Iron Geologist
	["grind on {npc:5839}"] = "",

	-- Step 8: Thorium Point
	-- {area:144} Thelsamar · {zone:1418} Badlands · {area:340} Kargath · {area:51} Searing Gorge · {area:1446} Thorium Point
	["From {area:144} ride south into the {zone:1418}, then west past the Horde town of {area:340} (give it room) and up the trail into {area:51}. {area:1446} is the scaffolded camp on the north-west rim."] = "",
	-- {object:179827} Wanted/Missing/Lost & Found
	["The {object:179827} board"] = "O quadro {object:179827}",

	-- Step 10: Greater Lava Spider on the way
	-- {npc:5858} Greater Lava Spider
	["{npc:5858} on the way"] = "",

	-- Step 11: Zamael Lunthistle
	-- {area:1446} Thorium Point
	["The night elf stands alone west of {area:1446}. Hear his story."] = "O elfo noturno está sozinho a oeste de {area:1446}. Ouça a história dele.",

	-- Step 14: Kalaran Windblade
	-- {area:1446} Thorium Point
	["Kalaran stands on the rim of the Cauldron, south of {area:1446}. Listen to his story."] = "Kalaran fica na borda de O Caldeirão, ao sul de {area:1446}. Ouça a história dele.",

	-- Step 17: On the way
	["On the way"] = "",
	-- {npc:5846} Dark Iron Taskmaster · {area:1446} Thorium Point
	["{npc:5846} along the way to {area:1446}"] = "",
	-- {npc:5844} Dark Iron Slaver · {area:1446} Thorium Point
	["{npc:5844} along the way to {area:1446}"] = "",

	-- Step 18: Firewatch Ridge: kill these as you meet them
	-- {area:1442} Firewatch Ridge
	["{area:1442}: kill these as you meet them"] = "",
	-- {item:10551} Thorium Plated Dagger · {item:18959} Smithing Tuyere · {object:147516} Dark Iron (no name in this language: may be words) · {item:11818} Grimesilt Outhouse Key
	-- plural, as words: Heavy War Golems = {npc:5854} Heavy War Golem · Magma Elementals = {npc:5855} Magma Elemental · Dark Iron Slavers = {npc:5844} Dark Iron Slaver
	["The spiders roam the plateaus and lava pools in the south-west of the gorge.\nHeavy War Golems patrol the floor of the Cauldron below Kalaran; Magma Elementals drift among them. Golems and elementals drop the oil, elementals the hearts.\nTaskmasters and Slavers drive the slaves all over the Cauldron, and any of them can carry a {item:10551}. The Steamsmiths work at the furnaces in the middle (the {item:18959}), the Lookouts stand on the southern ridges (the Spyglass). Any {object:147516} may drop the {item:11818}: keep it.\nCareful: Dark Iron Slavers (level 45-46) call for help from allies within 15 yd when pulled, cast Net from up to 15 yd, and use Rend in melee."] = "",

	-- Step 19: Thorium Plated Dagger on the way
	-- {item:10551} Thorium Plated Dagger
	["{item:10551} on the way"] = "",

	-- Step 21: Incendosaur on the way
	-- {npc:9318} Incendosaur
	["{npc:9318} on the way"] = "",
	-- {npc:9318} Incendosaur · {area:1446} Thorium Point
	["{npc:9318} along the way to {area:1446}"] = "",

	-- Step 22: Searing Gorge: kill these as you meet them
	-- {area:51} Searing Gorge
	["{area:51}: kill these as you meet them"] = "",
	-- {area:1443} The Slag Pit · {npc:14621} Overseer Maltorius
	-- plural, as words: Incendosaurs = {npc:9318} Incendosaur
	["{area:1443} opens in the north of the Cauldron. The Secret Plans lie on its upper ledge; Incendosaurs swim in the lava pools further in, so pull them to the edge. Stay clear of {npc:14621} and his elite guards deep inside."] = "{area:1443} se abre no norte de O Caldeirão. As Instruções Secretas: Fluxo Ígneo ficam na saliência superior; Incendossauros nadam nas poças de lava mais adentro, então puxe-os até a borda. Fique longe de {npc:14621} e de seus guardas de elite lá no fundo.",
	-- {item:18922} Secret Plans: Fiery Flux
	["{item:18922}; below ground"] = "",

	-- Step 23: Searing Gorge: kill these as you meet them
	-- {npc:14621} Overseer Maltorius
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:14621} is a level 50 elite: most classes solo it at level 52, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 25: Level 48.66
	["Level 48.66"] = "",
	-- {quest:7701} WANTED: Overseer Maltorius
	["If you skipped {quest:7701}, grind here to level 48.66 to stay on the route's plan."] = "",
	-- {npc:9318} Incendosaur
	["grind on {npc:9318}"] = "",

	-- Step 27: Dark Iron dwarves
	-- {object:147516} Dark Iron (no name in this language: may be words)
	["{object:147516} dwarves"] = "",

	-- Step 29: The Flame's Casing
	-- {npc:5860} Twilight Dark Shaman
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:5860} (level 50 elite) needs a group of 3. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 31: Level 48.98
	["Level 48.98"] = "",
	-- {quest:3452} The Flame's Casing
	["If you skipped {quest:3452}, grind here to level 48.98 to stay on the route's plan."] = "",
	-- {npc:5844} Dark Iron Slaver
	["grind on {npc:5844}"] = "",

	-- Step 32: Margol's Horn
	-- {quest:3181} The Horn of the Beast
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:3181} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "",
	["Below ground"] = "",

	-- Step 33: Camp Cagg
	-- {zone:1446} Tanaris · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh
	["The prisoner's next task, Ledger from {zone:1446}, sends you to the {zone:1435} and {zone:1445}: skip it."] = "A próxima tarefa do prisioneiro, Livro-Caixa de {zone:1446}, manda você para {zone:1435} e {zone:1445}: pule.",

	-- Step 34: Dustfire Valley
	-- {npc:8256} Curator Thorius · {area:1537} Ironforge
	["For {npc:8256} in {area:1537}, later"] = "",

	-- Step 36: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "",
	-- {area:1446} Thorium Point
	["{area:1446} flight master"] = "",

	-- Step 37: Class trainer
	["Class trainer"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["For {npc:8256} in {zone:1455}, later"] = "Para {npc:8256} em {zone:1455}, depois",
	-- ["From {area:144} ride south into the {zone:1418}, then west past the Horde town of {area:340} (give it room) and up the trail into {zone:1427}. {area:1446} is the scaffolded camp on the north-west rim."] = "De {area:144}, cavalgue para o sul até {zone:1418}, depois para o oeste passando pela cidade da Horda, {area:340} (mantenha distância), e suba a trilha até {zone:1427}. {area:1446} é o acampamento com andaimes na borda noroeste.",
	-- ["Golems and elementals"] = "Golems e elementais",
	-- ["Greater Lava Spiders"] = "Aranhas de Lava Abrasadoras",
	-- ["Heavy War Golems patrol the floor of the Cauldron below Kalaran; Magma Elementals drift among them. Golems and elementals drop the oil, elementals the hearts."] = "Golems de Guerra Pesados patrulham o fundo de O Caldeirão, abaixo de Kalaran; Elementais de Magma vagam entre eles. Golems e elementais deixam cair o óleo; os elementais, os corações.",
	-- ["Ride east across the Cauldron to the {area:247} in the south-east. The prisoner in the wooden outhouse wants 15 {item:4306} and eight dead Dark Iron Geologists from the dig site around it. The outhouse also opens with the key, if you found one."] = "Cavalgue para o leste pelo Caldeirão até {area:247}, no sudeste. O prisioneiro na casinha de madeira quer 15 {item:4306} e oito Geólogos Ferro Negro mortos da escavação ao redor. A casinha também abre com a chave, se você encontrou uma.",
	-- ["Taskmasters and Slavers drive the slaves all over the Cauldron, and any of them can carry a {item:10551}. The Steamsmiths work at the furnaces in the middle (the {item:18959}), the Lookouts stand on the southern ridges (the Spyglass). Any {object:147516} may drop the {item:11818}: keep it."] = "Capatazes Ferro Negro e Feitores Ferro Negro tocam os escravos por todo O Caldeirão, e qualquer um deles pode carregar uma {item:10551}. Os Vaporistas Ferro Negro trabalham nas fornalhas no meio (a {item:18959}); os Atalaias Ferro Negro ficam nas cristas do sul (a Luneta do Espia). Qualquer {object:147516} pode deixar cair a {item:11818}: guarde-a.",
	-- ["The dwarf stands by the road at the dig site. Follow him north along the road and fight off the {object:147516} ambushes. When it is over, read the {object:175704} he leaves on the road in {area:1959}."] = "O anão fica à beira da estrada, na escavação. Siga-o para o norte pela estrada e repila as emboscadas {object:147516}. No fim, leia a {object:175704} que ele deixa na estrada em {area:1959}.",
	-- ["The spiders roam the plateaus and lava pools in the south-west of the gorge."] = "As aranhas vagam pelos platôs e poças de lava no sudoeste da garganta.",
	-- ["{npc:6734}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6734}: o guia anterior leva você até aqui com a pedra de regresso, então isto costuma ser marcado na hora",
	-- ["{object:147516} dwarves"] = "Anões {object:147516}",
}
