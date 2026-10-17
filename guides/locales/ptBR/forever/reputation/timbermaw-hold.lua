-- Portuguese (Brazil) (ptBR): the guide forever/reputation/timbermaw-hold (forever/reputation/timbermaw-hold.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Timbermaw Hold Reputation"] = "Reputação: Domínio dos Presamatos",

	-- Step 1: Grazle
	-- {faction:576} Timbermaw Hold
	["{faction:576} starts out Hostile, and its furbolgs in the tunnels attack until you reach Unfriendly. Every Deadwood and Winterfall furbolg you kill raises it, so the quests below pay twice. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:576} começa Hostil, e seus pelursos nos túneis atacam até você chegar a Inamistoso. Cada pelurso Lenha Morta e Invernoso que você mata aumenta a reputação, então as missões abaixo rendem em dobro. A vantagem de Legado Diplomata do Forever aumenta os ganhos de reputação.",

	-- Step 2: Deadwood Village
	-- {zone:1448} Felwood · {item:21377} Deadwood Headdress Feather · {npc:11554} Grazle · {npc:15395} Nafien
	["Deadwood furbolgs (level 48-50) camp at the southern end of {zone:1448}. Keep every {item:21377} they drop: {npc:11554} and {npc:15395} take them later."] = "Os pelursos Lenha Morta (nível 48-50) acampam no extremo sul de {zone:1448}. Guarde cada {item:21377} que eles deixarem cair: {npc:11554} e {npc:15395} as recebem depois.",

	-- Step 3: Back to Grazle
	-- {npc:11554} Grazle
	["Back to {npc:11554}"] = "De volta a {npc:11554}",

	-- Step 4: Nafien
	-- {npc:15395} Nafien · {zone:1448} Felwood · {faction:576} Timbermaw Hold
	["{npc:15395} waits in northern {zone:1448} at the tunnel into {faction:576}."] = "{npc:15395} espera no norte de {zone:1448}, no túnel para {faction:576}.",

	-- Step 5: Deadwood of the North
	["The northern Deadwood (level 53-55) hold the camps just south of the tunnel. Keep their feathers too."] = "Os Lenha Morta do norte (nível 53-55) ocupam os acampamentos logo ao sul do túnel. Guarde as penas deles também.",

	-- Step 6: Back to Nafien
	-- {npc:15395} Nafien
	["Back to {npc:15395}"] = "De volta a {npc:15395}",

	-- Step 7: Salfa
	-- {faction:576} Timbermaw Hold · {zone:1452} Winterspring · {npc:11556} Salfa
	["Go through {faction:576} to its {zone:1452} exit; {npc:11556} stands just outside. The quests and kills so far usually reach Unfriendly, and then the Timbermaw let you pass. If they still show red, kill more Deadwood by the tunnel first."] = "Atravesse {faction:576} até a saída para {zone:1452}; {npc:11556} fica logo do lado de fora. As missões e mortes até aqui costumam chegar a Inamistoso, e então os Presamatos deixam você passar. Se ainda aparecerem em vermelho, mate mais Lenha Morta perto do túnel antes.",

	-- Step 8: Winterfall Village
	-- {area:2244} Winterfall Village · {zone:1452} Winterspring · {item:21383} Winterfall Spirit Beads · {npc:11556} Salfa
	["{area:2244} sits on the eastern side of {zone:1452}. Keep every {item:21383} you loot: {npc:11556} takes them."] = "{area:2244} fica no lado leste de {zone:1452}. Guarde todas as {item:21383} que saquear: {npc:11556} as recebe.",

	-- Step 9: Back to Salfa
	-- {npc:11556} Salfa
	["Back to {npc:11556}"] = "De volta a {npc:11556}",

	-- Step 10: Feathers and beads to Friendly
	["Feathers and beads to Friendly"] = "Penas e contas até Amistoso",
	-- {npc:11554} Grazle · {npc:15395} Nafien · {npc:11556} Salfa · {item:21383} Winterfall Spirit Beads · {area:2244} Winterfall Village
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["Feathers for {npc:11554} and Feathers for {npc:15395} (Deadwood Headdress Feathers) and Beads for {npc:11556} ({item:21383}) repeat as often as you like; every Deadwood or Winterfall kill counts as well. {area:2244} is the densest bead spot."] = "Penas para {npc:11554} e Penas para {npc:15395} (Penas do Cocar de Lenha Morta) e Contas para {npc:11556} ({item:21383}) se repetem quantas vezes quiser; cada Lenha Morta ou Invernoso morto também conta. {area:2244} é o melhor lugar para contas.",
	-- {npc:11556} Salfa
	["{npc:11556}: Beads for {npc:11556}"] = "{npc:11556}: Contas para {npc:11556}",

	-- Step 11: Feathers to Honored
	["Feathers to Honored"] = "Penas até Honrado",
	-- {npc:15395} Nafien · {npc:11554} Grazle
	["The northern Deadwood camps by the tunnel are the densest feather spot (35% drop chance there). Hand feathers to {npc:15395} at the tunnel, or to {npc:11554} in the south."] = "Os acampamentos Lenha Morta do norte, junto ao túnel, são o melhor lugar para penas (35% de chance de saque ali). Entregue as penas a {npc:15395} no túnel, ou a {npc:11554} no sul.",
	-- {npc:15395} Nafien
	["{npc:15395}: Feathers for {npc:15395}"] = "{npc:15395}: Penas para {npc:15395}",

	-- Step 12: Timbermaw Hold to Revered
	-- {faction:576} Timbermaw Hold
	["{faction:576} to Revered"] = "{faction:576} até Reverenciado",
	-- {npc:15395} Nafien · {npc:11556} Salfa
	["Alternate Deadwood feathers ({npc:15395}) and Winterfall beads ({npc:11556}), whichever camp is less crowded."] = "Alterne penas dos Lenha Morta ({npc:15395}) e contas dos Invernosos ({npc:11556}), conforme o acampamento menos cheio.",

	-- Step 13: Timbermaw Hold to Exalted
	-- {faction:576} Timbermaw Hold
	["{faction:576} to Exalted"] = "{faction:576} até Exaltado",
	["Keep turning in feathers and beads until Exalted."] = "Continue entregando penas e contas até Exaltado.",
}
