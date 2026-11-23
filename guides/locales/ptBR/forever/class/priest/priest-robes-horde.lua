-- Portuguese (Brazil) (ptBR): the guide forever/class/priest/priest-robes-horde (forever/class/priest/priest-robes-horde.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Priest Robes at 5 (Horde)"] = "Vestes de Sacerdote no nível 5 (Horda)",
	["A free uncommon robe at 5: heal and fortify a wounded guard near your first town."] = "Uma veste incomum de graça no nível 5: cure e fortifique um guarda ferido perto da sua primeira cidade.",

	-- Step 1: In Favor of Spirituality
	-- {npc:3707} Ken'jai · {area:363} Valley of Trials · {npc:3706} Tai'jin · {area:362} Razor Hill · {spell:613} Lesser Heal
	["At 5, {npc:3707}, the priest trainer in the Den in the middle of the {area:363}, sends you to {npc:3706} in {area:362}. Train {spell:613} (Rank 2) from him while you are here: it opens at level 4 for 1 silver, and the next quest needs exactly that rank."] = "No nível 5, {npc:3707}, o instrutor de sacerdote na Toca, no meio de {area:363}, manda você até {npc:3706}, em {area:362}. Aprenda {spell:613} (Grau 2) com ele enquanto está aqui: abre no nível 4 por 1 prata, e a próxima missão pede exatamente esse grau.",

	-- Step 2: Tai'jin
	-- {area:363} Valley of Trials · {area:362} Razor Hill · {npc:3706} Tai'jin
	["Follow the road out of the {area:363} north-east to {area:362}. {npc:3706} is inside the barracks, the first building on the right as you come into town."] = "Siga a estrada para nordeste saindo de {area:363} até {area:362}. {npc:3706} está dentro do quartel, o primeiro prédio à direita de quem chega à cidade.",
	-- {spell:613} Lesser Heal · {npc:3707} Ken'jai
	["{spell:613} (Rank 2), if {npc:3707} did not teach it yet"] = "{spell:613} (Grau 2), se {npc:3707} ainda não ensinou",

	-- Step 3: Grunt Kor'ja
	-- {npc:12430} Grunt Kor'ja · {area:362} Razor Hill · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12430} kneels behind a group of rocks just off the road, a short walk south of {area:362}. Cast {spell:613} (Rank 2) on her first, then {spell:1243}. Rank 1 of {spell:613} does not count; drag Rank 2 onto your bar from the spellbook. She leaves once both land and is back in about 5 minutes."] = "{npc:12430} fica ajoelhada atrás de um grupo de pedras ao lado da estrada, uma caminhada curta ao sul de {area:362}. Lance {spell:613} (Grau 2) nela primeiro, depois {spell:1243}. O Grau 1 de {spell:613} não vale; arraste o Grau 2 do grimório para a sua barra. Ela vai embora quando os dois pegam e volta em cerca de 5 minutos.",
	-- {npc:12430} Grunt Kor'ja
	["Heal and fortify {npc:12430}"] = "Cure e fortifique {npc:12430}",

	-- Step 4: Tai'jin
	-- {area:362} Razor Hill · {npc:3706} Tai'jin · {item:16606} Juju Hex Robes
	["Back in the {area:362} barracks: {npc:3706} gives you the {item:16606}."] = "De volta ao quartel de {area:362}: {npc:3706} entrega {item:16606} a você.",

	-- Step 5: In Favor of Darkness
	-- {npc:2123} Dark Cleric Duesten · {area:154} Deathknell · {npc:2129} Dark Cleric Beryl · {area:159} Brill · {spell:613} Lesser Heal
	["At 5, {npc:2123}, the priest trainer in the chapel of {area:154}, sends you to {npc:2129} in {area:159}. Train {spell:613} (Rank 2) from him while you are here: it opens at level 4 for 1 silver, and the next quest needs exactly that rank."] = "No nível 5, {npc:2123}, o instrutor de sacerdote na capela de {area:154}, manda você até {npc:2129}, em {area:159}. Aprenda {spell:613} (Grau 2) com ele enquanto está aqui: abre no nível 4 por 1 prata, e a próxima missão pede exatamente esse grau.",

	-- Step 6: Dark Cleric Beryl
	-- {area:154} Deathknell · {area:159} Brill · {npc:2129} Dark Cleric Beryl · {area:2119} Gallows' End Tavern
	["Follow the road east out of {area:154} to {area:159}. {npc:2129} is upstairs in the inn, {area:2119}."] = "Siga a estrada para leste saindo de {area:154} até {area:159}. {npc:2129} está no andar de cima da estalagem, {area:2119}.",
	-- {spell:613} Lesser Heal
	["{spell:613} (Rank 2), if Duesten did not teach it yet"] = "{spell:613} (Grau 2), se Duesten ainda não ensinou",

	-- Step 7: Deathguard Kel
	-- {npc:12428} Deathguard Kel · {area:159} Brill · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12428} kneels, half-dead, beside the north gate of {area:159}'s graveyard, a short walk north of the inn. Cast {spell:613} (Rank 2) on him first, then {spell:1243}: Fortitude first does not count, nor does Rank 1 of {spell:613}. If an addon gets in the way, cast both from the spellbook."] = "{npc:12428} fica ajoelhado, meio morto, ao lado do portão norte do cemitério de {area:159}, uma caminhada curta ao norte da estalagem. Lance {spell:613} (Grau 2) nele primeiro, depois {spell:1243}: Fortitude primeiro não vale, nem o Grau 1 de {spell:613}. Se um addon atrapalhar, lance os dois pelo grimório.",
	-- {npc:12428} Deathguard Kel
	["Heal and fortify {npc:12428}"] = "Cure e fortifique {npc:12428}",

	-- Step 8: Dark Cleric Beryl
	-- {area:159} Brill · {item:16607} Acolyte's Sacrificial Robes
	["Back upstairs in the {area:159} inn: Beryl gives you the {item:16607}."] = "De volta ao andar de cima da estalagem de {area:159}: Beryl entrega {item:16607} a você.",
}
