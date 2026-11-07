-- Portuguese (Brazil) (ptBR): the guide forever/class/mage/astral-knot-garment (forever/class/mage/astral-knot-garment.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A robe or a blouse for Alliance mages in their late 20s."] = "Um manto ou uma blusa para magos da Aliança no fim dos 20 e poucos.",

	-- Step 1: Bink (Ironforge)
	-- {npc:5144} Bink · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind
	["{npc:5144} teaches mages in {zone:1455}'s {object:32362}. Take the {area:2257} from {object:171524} to {zone:1453} afterwards."] = "{npc:5144} treina magos na {object:32362} de {zone:1455}. Depois, pegue o {area:2257} em {object:171524} até {zone:1453}.",

	-- Step 2: Jennea Cannon (Stormwind)
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter
	["{npc:5497} stands at the top of the Wizard's Sanctum, the violet tower of the {object:2101}; the portal near the top of the spiral ramp takes you to her."] = "{npc:5497} fica no topo do Sacrário dos Teurgos, a torre violeta do {object:2101}; o portal perto do alto da rampa em espiral leva você até ela.",

	-- Step 3: High Sorcerer Andromath (Skyborne)
	-- {npc:5694} High Sorcerer Andromath
	["{npc:5694} (Skyborne)"] = "{npc:5694} (Celonatos)",
	-- {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:5694} High Sorcerer Andromath · {npc:5497} Jennea Cannon
	["You do not need a letter: at 26 climb the Wizard's Sanctum, the violet tower of {zone:1453}'s {object:2101}. {npc:5694} waits on the spiral walkway, just past the door of the portal room near the top, and has the quest for you. ({npc:5497} may also offer you {npc:5694}, the pointer quest; it is only a pointer and you can skip it.)"] = "Você não precisa de carta: no nível 26, suba o Sacrário dos Teurgos, a torre violeta do {object:2101} de {zone:1453}. {npc:5694} espera na passarela em espiral, logo depois da porta da sala dos portais perto do topo, e tem a missão para você. ({npc:5497} também pode oferecer {npc:5694}, a missão de indicação; é só uma indicação e dá para pular.)",

	-- Step 4: High Sorcerer Andromath
	-- {quest:1939} High Sorcerer Andromath
	["{quest:1939} waits on the spiral walkway of the Wizard's Sanctum, just past the door of the portal room as you walk down from the trainers."] = "{quest:1939} espera na passarela em espiral do Sacrário dos Teurgos, logo depois da porta da sala dos portais, descendo dos instrutores.",

	-- Step 5: The Tower of Ilgalar
	-- {area:96} Tower of Ilgalar
	["The {area:96}"] = "{area:96}",
	-- {zone:1429} Elwynn Forest · {area:69} Lakeshire · {area:96} Tower of Ilgalar · {spell:2691} Mana Burn
	["Head east through {zone:1429} into Redridge, or fly to {area:69}. The {area:96} stands alone in the east of the zone. Climb to the very top floor (not the one below): the treatise is the book sticking out of the shelf where the stairs come up. Two gnoll dogs and a gnoll caster guard the shelf; the dogs' {spell:2691} interrupts the click, so fight them on the stairs out of their sight. Morganth (level 26 elite) stands across the top floor: you do not need him, keep to the left edge of the ramp so he stays put. The book is back two seconds after anyone takes it. If you die, your ghost can run up and come back to life beside it."] = "Siga para leste por {zone:1429} até Cristarrubra, ou voe para {area:69}. {area:96} fica sozinha no leste da zona. Suba até o último andar (não o de baixo): o tratado é o livro saindo da estante onde a escada chega. Dois cães gnoll e um gnoll lançador de feitiço guardam a estante; o {spell:2691} dos cães interrompe o clique, então lute com eles na escada, fora da vista. Morganth (elite nível 26) fica do outro lado do último andar: você não precisa dele, fique na borda esquerda da rampa para ele não se mexer. O livro volta dois segundos depois que alguém pega. Se morrer, seu fantasma pode subir correndo e ressuscitar ao lado dele.",

	-- Step 6: Back to Andromath
	["Back to Andromath"] = "Volte a Andromath",

	-- Step 7: Carrion Recluses
	-- plural, as words: Carrion Recluses = {npc:949} Carrion Recluse
	["Carrion Recluses"] = "Reclusas Carniceiras",
	-- {area:492} Raven Hill Cemetery · {zone:1431} Duskwood · {spell:3609} Paralyzing Poison · {npc:522} Mor'Ladim
	-- plural, as words: Carrion Recluses = {npc:949} Carrion Recluse · Black Widow Hatchlings = {npc:930} Black Widow Hatchling
	["{area:492} in western {zone:1431}: the six Carrion Recluses (level 25-26, green, {spell:3609}) walk the graves, the central statue and the riverbank, and every one drops a silk; they come back after 5 minutes. The Black Widow Hatchlings (24-25) on the slopes east of the cemetery drop it about one time in six, so mix them in while you wait. {npc:522}, a level 35 elite skeleton, walks the cemetery: watch for him."] = "{area:492}, no oeste de {zone:1431}: as seis Reclusas Carniceiras (nível 25-26, verdes, {spell:3609}) andam pelos túmulos, pela estátua central e pela margem do rio, e toda uma deixa cair uma seda; voltam depois de 5 minutos. Os Filhotes de Viúva Negra (24-25) das encostas a leste do cemitério deixam cair mais ou menos uma vez a cada seis, então mate também enquanto espera. {npc:522}, um esqueleto elite de nível 35, anda pelo cemitério: fique de olho nele.",

	-- Step 8: Wynne Larson
	-- {npc:1309} Wynne Larson · {object:23296} Larson Clothiers · {object:2101} Mage Quarter
	["{npc:1309} works at {object:23296} in the {object:2101}. The robe gives intellect, stamina and spirit; the blouse more intellect and stamina but no spirit."] = "{npc:1309} trabalha na {object:23296}, no {object:2101}. O manto dá intelecto, vigor e espírito; a blusa dá mais intelecto e vigor, mas nada de espírito.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A robe or a blouse for Human and Gnome mages in their late 20s."] = "Um manto ou uma blusa para magos humanos e gnomos perto do nível 30.",
	-- ["Carrion Recluses lurk in the woods of western {zone:1431} and each one drops the silk. The Black Widow Hatchlings further east drop it now and then."] = "As Reclusas Carniceiras espreitam nos bosques do oeste de {zone:1431}, e todas soltam a seda. Os Filhotes de Viúva Negra mais a leste a soltam de vez em quando.",
	-- ["Ride east through {zone:1429} into Redridge. The fallen mage's tower of Ilgalar stands in the east of the zone; the treatise is in his library."] = "Cavalgue para o leste por {zone:1429} até as Montanhas Cristarrubra. A torre de Ilgalar, o mago caído, fica no leste da zona; o tratado está na biblioteca dele.",
	-- ["{npc:1309} works at {object:23296} in the {object:2101}."] = "{npc:1309} trabalha em {object:23296}, no {object:2101}.",
	-- ["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}."] = "{npc:5497} fica no Sacrário dos Teurgos, a torre do {object:2101}.",
	-- ["{quest:1939} is in the Wizard's Sanctum too."] = "{quest:1939} também fica no Sacrário dos Teurgos.",
}
