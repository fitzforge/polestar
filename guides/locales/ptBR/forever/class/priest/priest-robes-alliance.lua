-- Portuguese (Brazil) (ptBR): the guide forever/class/priest/priest-robes-alliance (forever/class/priest/priest-robes-alliance.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Priest Robes at 5 (Alliance)"] = "Vestes de Sacerdote no nível 5 (Aliança)",
	["A free uncommon robe at 5: heal and fortify a wounded guard near your first town."] = "Uma veste incomum de graça no nível 5: cure e fortifique um guarda ferido perto da sua primeira cidade.",

	-- Step 1: In Favor of the Light
	-- {npc:375} Priestess Anetta · {area:24} Northshire Abbey · {npc:377} Priestess Josetta · {area:87} Goldshire · {spell:613} Lesser Heal
	["At 5, {npc:375}, the priest trainer inside {area:24}, sends you to {npc:377} in {area:87}. Train {spell:613} (Rank 2) from Anetta while you are here: it opens at level 4 for 1 silver, and the next quest needs exactly that rank."] = "No nível 5, {npc:375}, o instrutor de sacerdote dentro de {area:24}, manda você até {npc:377}, em {area:87}. Aprenda {spell:613} (Grau 2) com Anetta enquanto está aqui: ele abre no nível 4 por 1 prata, e a próxima missão pede exatamente esse grau.",

	-- Step 2: Priestess Josetta
	-- {area:9} Northshire Valley · {area:87} Goldshire · {npc:377} Priestess Josetta
	["Follow the road south out of {area:9} to {area:87}. {npc:377} is upstairs in the Lion's Pride Inn."] = "Siga a estrada para o sul saindo de {area:9} até {area:87}. {npc:377} está no andar de cima da Estalagem Orgulho do Leão.",
	-- {spell:613} Lesser Heal
	["{spell:613} (Rank 2), if Anetta did not teach it yet"] = "{spell:613} (Grau 2), se Anetta ainda não ensinou",

	-- Step 3: Guard Roberts
	-- {npc:12423} Guard Roberts · {area:87} Goldshire · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12423} kneels by a tree on the lake shore east of {area:87}, off the road: walk along the shore, the minimap misses him from the road. Cast {spell:613} (Rank 2) on him first, then {spell:1243}. Rank 1 of {spell:613} does not count; drag Rank 2 onto your bar from the spellbook (or cast both from the spellbook if an action bar addon gets in the way). He walks off once both land and is back in about 3 minutes."] = "{npc:12423} fica ajoelhado ao lado de uma árvore na margem do lago, a leste de {area:87}, fora da estrada: ande pela margem, o minimapa não o mostra de quem está na estrada. Lance {spell:613} (Grau 2) nele primeiro, depois {spell:1243}. O Grau 1 de {spell:613} não vale; arraste o Grau 2 do grimório para a sua barra (ou lance os dois pelo grimório, se um addon de barra de ação atrapalhar). Ele vai embora quando os dois pegam e volta em cerca de 3 minutos.",
	-- {npc:12423} Guard Roberts
	["Heal and fortify {npc:12423}"] = "Cure e fortifique {npc:12423}",

	-- Step 4: Priestess Josetta
	-- {item:16605} Friar's Robes of the Light
	["Back upstairs in the Lion's Pride Inn: Josetta gives you {item:16605}."] = "De volta ao andar de cima da Lion's Pride Inn: Joselita entrega {item:16605} a você.",

	-- Step 5: In Favor of the Light
	-- {npc:837} Branstock Khalder · {area:77} Anvilmar · {area:132} Coldridge Valley · {npc:1226} Maxan Anvol · {area:131} Kharanos · {spell:613} Lesser Heal
	["At 5, {npc:837}, the priest trainer inside {area:77} in {area:132}, sends you to {npc:1226} in {area:131}. Train {spell:613} (Rank 2) from him while you are here: it opens at level 4 for 1 silver, and the next quest needs exactly that rank."] = "No nível 5, {npc:837}, o instrutor de sacerdote dentro de {area:77}, em {area:132}, manda você até {npc:1226}, em {area:131}. Aprenda {spell:613} (Grau 2) com ele enquanto está aqui: abre no nível 4 por 1 prata, e a próxima missão pede exatamente esse grau.",

	-- Step 6: Maxan Anvol
	-- {area:132} Coldridge Valley · {area:131} Kharanos · {npc:1226} Maxan Anvol · {area:2102} Thunderbrew Distillery
	["Take the tunnel north-east out of {area:132} and follow the road east to {area:131}. {npc:1226} is inside the {area:2102}."] = "Pegue o túnel a nordeste saindo de {area:132} e siga a estrada para leste até {area:131}. {npc:1226} está dentro da {area:2102}.",
	-- {spell:613} Lesser Heal · {npc:837} Branstock Khalder
	["{spell:613} (Rank 2), if {npc:837} did not teach it yet"] = "{spell:613} (Grau 2), se {npc:837} ainda não ensinou",

	-- Step 7: Mountaineer Dolf
	-- {npc:12427} Mountaineer Dolf · {area:131} Kharanos · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12427} kneels on a ridge between two low walls just south of {area:131}, across the road from the hunter pet trainer: if the road starts going downhill, you have passed him. Cast {spell:613} (Rank 2) on him first, then {spell:1243}; he speaks after each spell. Rank 1 of {spell:613} does not count."] = "{npc:12427} fica ajoelhado numa elevação entre dois muros baixos, logo ao sul de {area:131}, do outro lado da estrada em relação ao instrutor de mascotes de caçador: se a estrada começar a descer, você passou dele. Lance {spell:613} (Grau 2) nele primeiro, depois {spell:1243}; ele fala depois de cada magia. O Grau 1 de {spell:613} não vale.",
	-- {npc:12427} Mountaineer Dolf
	["Heal and fortify {npc:12427}"] = "Cure e fortifique {npc:12427}",

	-- Step 8: Maxan Anvol
	-- {area:2102} Thunderbrew Distillery · {npc:1226} Maxan Anvol · {item:16605} Friar's Robes of the Light
	["Back inside the {area:2102}: {npc:1226} gives you {item:16605}."] = "De volta à {area:2102}: {npc:1226} entrega {item:16605} a você.",

	-- Step 9: In Favor of Elune
	-- {npc:3595} Shanda · {area:256} Aldrassil · {area:188} Shadowglen · {npc:3600} Laurna Morninglight · {area:186} Dolanaar · {spell:613} Lesser Heal
	["At 5, {npc:3595}, the priest trainer on the second level of {area:256}, the great tree in {area:188}, sends you to {npc:3600} in {area:186}. Train {spell:613} (Rank 2) from her while you are here: it opens at level 4 for 1 silver, and the next quest needs exactly that rank."] = "No nível 5, {npc:3595}, a instrutora de sacerdote no segundo nível de {area:256}, a grande árvore de {area:188}, manda você até {npc:3600}, em {area:186}. Aprenda {spell:613} (Grau 2) com ela enquanto está aqui: abre no nível 4 por 1 prata, e a próxima missão pede exatamente esse grau.",

	-- Step 10: Laurna Morninglight
	-- {area:188} Shadowglen · {area:186} Dolanaar · {npc:3600} Laurna Morninglight
	["Leave {area:188} by the ramp and follow the road south-west to {area:186}. {npc:3600} is in the building at the north edge of the village."] = "Saia de {area:188} pela rampa e siga a estrada para sudoeste até {area:186}. {npc:3600} está no prédio da borda norte da vila.",
	-- {spell:613} Lesser Heal · {npc:3595} Shanda
	["{spell:613} (Rank 2), if {npc:3595} did not teach it yet"] = "{spell:613} (Grau 2), se {npc:3595} ainda não ensinou",

	-- Step 11: Sentinel Shaya
	-- {npc:12429} Sentinel Shaya · {area:259} Lake Al'Ameth · {area:186} Dolanaar · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12429} kneels on the rocks at the edge of {area:259}, about 100 yards south of {area:186}, with no quest mark over her. Cast {spell:613} (Rank 2) on her first, then {spell:1243}; she runs off toward the lake once both land and is back in about 5 minutes. Rank 1 of {spell:613} does not count."] = "{npc:12429} fica ajoelhada nas pedras da beira de {area:259}, uns 100 metros ao sul de {area:186}, sem marca de missão sobre ela. Lance {spell:613} (Grau 2) nela primeiro, depois {spell:1243}; ela corre para o lago quando os dois pegam e volta em cerca de 5 minutos. O Grau 1 de {spell:613} não vale.",
	-- {npc:12429} Sentinel Shaya
	["Heal and fortify {npc:12429}"] = "Cure e fortifique {npc:12429}",

	-- Step 12: Laurna Morninglight
	-- {area:186} Dolanaar · {npc:3600} Laurna Morninglight · {item:16604} Moon Robes of Elune
	["Back at the north edge of {area:186}: {npc:3600} gives you the {item:16604}."] = "De volta à borda norte de {area:186}: {npc:3600} entrega {item:16604} a você.",
}
