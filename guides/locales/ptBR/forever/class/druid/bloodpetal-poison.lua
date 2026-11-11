-- Portuguese (Brazil) (ptBR): the guide forever/class/druid/bloodpetal-poison (forever/class/druid/bloodpetal-poison.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Experience in Un'Goro at 50 and two healing potions; the Classic item choice may be gone in Forever."] = "Experiência em Un'Goro no nível 50 e duas poções de cura; a escolha de item do Classic pode não existir no Forever.",

	-- Step 1: Loganaar
	-- {spell:18960} Teleport: Moonglade · {npc:12042} Loganaar · {area:2361} Nighthaven · {npc:3033} Turak Runetotem · {npc:4217} Mathrengyl Bearwalker · {zone:1453} Stormwind
	["Cast {spell:18960}. {npc:12042} stands in {area:2361}; your class trainer ({npc:3033}, {npc:4217} or Theridran in {zone:1453}) offers the same quest."] = "Use {spell:18960}. {npc:12042} fica em {area:2361}; o seu instrutor de classe ({npc:3033}, {npc:4217} ou Theridran, em {zone:1453}) oferece a mesma missão.",

	-- Step 2: Torwa Pathfinder
	-- {area:976} Gadgetzan · {zone:1449} Un'Goro Crater · {npc:9619} Torwa Pathfinder
	["Fly to {area:976}, ride west to the long ramp down into {zone:1449}: {npc:9619} camps at its foot, in the south-east corner of the crater."] = "Voe até {area:976}, cavalgue para oeste até a longa rampa que desce para a {zone:1449}: {npc:9619} acampa ao pé dela, no canto sudeste da cratera.",

	-- Step 3: Gorishi Stings and Bloodcap
	-- {item:22434} Bloodcap
	-- plural, as words: Gorishi Stings = {item:22435} Gorishi Sting
	["Gorishi Stings and {item:22434}"] = "Ferrões de Gorishi e {item:22434}",
	-- {area:540} Slithering Scar · {spell:8137} Silithid Pox · {area:541} Marshal's Refuge · {item:22434} Bloodcap
	-- plural, as words: Gorishi Wasps = {npc:6551} Gorishi Wasp · Bloodpetal Sprouts = {object:164958} Bloodpetal Sprout
	["Eight of each. The Gorishi Wasps and Stingers (level 51-52) in and around the {area:540}, the hive in the south-west of the crater, drop a sting about one kill in seven; the wasps share spawn points with the other bugs, so kill whatever stands near you to make room for more wasps (respawn five minutes). The bugs' {spell:8137} makes you take more physical damage for 30 minutes; Workers call for help when hurt. The Bloodpetal Sprouts grow all over the crater (around {area:541} and the western half): open them, about every other one gives a {item:22434}, back in three to five minutes."] = "Oito de cada. As Vespas e Aguilhantes Gorishi (nível 51-52) em {area:540} e em volta, a colmeia do sudoeste da cratera, deixam cair um ferrão mais ou menos a cada sete abates; as vespas dividem os pontos de surgimento com os outros insetos, então mate o que estiver perto para abrir espaço para mais vespas (renascem em cinco minutos). A {spell:8137} dos insetos faz você levar mais dano físico por 30 minutos; as Trabalhadoras chamam ajuda quando feridas. Os Brotos de Pétala Sangrenta crescem pela cratera inteira (em volta de {area:541} e na metade oeste): abra; mais ou menos um sim, um não dá um {item:22434}, e voltam em três a cinco minutos.",

	-- Step 5: Toxic Test
	-- {npc:6498} Devilsaur · {spell:14099} Mighty Blow · {spell:339} Entangling Roots · {item:22432} Devilsaur Barb · {spell:2637} Hibernate · {npc:6499} Ironhide Devilsaur · {npc:9619} Torwa Pathfinder
	-- plural, as words: Tyrant Devilsaurs = {npc:6500} Tyrant Devilsaur · Devilsaurs = {npc:6498} Devilsaur
	["Any {npc:6498} counts, the Ironhide and Tyrant Devilsaurs too. They are elite (level 54-55), hit with {spell:14099} and outrun travel form. Grouping up is encouraged, but a druid can do it alone: Hibernate or {spell:339} it from range, stab it with the {item:22432} (the barb does not break {spell:2637}), then leave. The credit counts the moment the barb lands, even if you die after. The arrow points at the plain Devilsaurs of the west and north; an {npc:6499} roams the middle of the crater's south, nearer {npc:9619}."] = "Qualquer {npc:6498} conta, inclusive os Demossauros Couroférreo e Tirano. São elite (nível 54-55), batem com {spell:14099} e correm mais que a forma de viagem. Vale ir em grupo, mas um druida consegue sozinho: Hiberne ou use {spell:339} nele de longe, espete a {item:22432} (a farpa não quebra o {spell:2637}) e saia. Conta na hora em que a farpa acerta, mesmo que você morra depois. A seta aponta para os Demossauros comuns do oeste e do norte; um {npc:6499} vaga pelo meio do sul da cratera, mais perto de {npc:9619}.",
	-- {npc:6498} Devilsaur · {item:22432} Devilsaur Barb
	["{npc:6498}: stab it with the {item:22432}"] = "{npc:6498}: espete-o com a {item:22432}",
	-- {npc:6498} Devilsaur · {item:22432} Devilsaur Barb
	["Stab a {npc:6498} with the {item:22432}"] = "",

	-- Step 7: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "O {area:1417}",
	-- {area:75} Stonard · {area:1438} Nethergarde Keep · {zone:1419} Blasted Lands · {area:1477} The Temple of Atal'Hakkar · {area:74} Pool of Tears · {zone:1435} Swamp of Sorrows · {npc:8580} Atal'alarion · {spell:12887} Sweeping Slam · {spell:6524} Ground Tremor · {item:22444} Putrid Vine
	["A five-player dungeon: needs a group of five, about level 50-55. Horde: fly to {area:75}; Alliance: fly to {area:1438} in the {zone:1419} and ride north. {area:1477} stands in the middle of the {area:74} in the {zone:1435}: climb the stairs on the ruin's south side, dive into the flooded hall, swim down through it and follow the stairs and passages down to the portal. {npc:8580} (level 50 elite, {spell:12887} and {spell:6524}) only appears when the six serpent statues on the balcony ring above the altar pit are clicked in order: South, North, South-west, South-east, North-west, North-east (each turns green when right; a wrong order fails). Clear the trash by each statue and the pit below first; jumping down into the water is the quick way down, but a knockback near the edge can kill. The {item:22444} always drops."] = "Masmorra de cinco jogadores: pede um grupo de cinco, por volta do nível 50-55. Horda: voe para {area:75}; Aliança: voe para {area:1438}, em {zone:1419}, e cavalgue para o norte. {area:1477} fica no meio de {area:74}, em {zone:1435}: suba a escadaria do lado sul da ruína, mergulhe no salão alagado, nade até o fundo e siga as escadas e passagens até o portal. {npc:8580} (elite nível 50, {spell:12887} e {spell:6524}) só aparece quando as seis estátuas de serpente no anel da sacada acima do fosso do altar são clicadas em ordem: Sul, Norte, Sudoeste, Sudeste, Noroeste, Nordeste (cada uma fica verde quando acerta; ordem errada falha). Limpe os monstros de cada estátua e do fosso antes; pular na água é o jeito rápido de descer, mas um empurrão perto da borda pode matar. A {item:22444} sempre cai.",

	-- Step 8: A Better Ingredient
	-- {npc:9619} Torwa Pathfinder · {zone:1449} Un'Goro Crater
	["Back to {npc:9619} in the south-east corner of {zone:1449}."] = "De volta a {npc:9619}, no canto sudeste da {zone:1449}.",
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619}: the old item choice may be gone, count on the experience"] = "{npc:9619}: a escolha de item antiga pode não existir mais, conte com a experiência",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast {spell:18960}. {npc:12042} stands in {area:2361}; your class trainer offers the same quest."] = "Lance {spell:18960}. {npc:12042} fica em {area:2361}; seu instrutor de classe oferece a mesma missão.",
	-- ["Experience in Un'Goro at 50 and two healing potions; Forever removed the Classic item choice."] = "Experiência em Un'Goro no nível 50 e duas poções de cura; o Forever removeu a escolha de item do Classic.",
	-- ["The Gorishi wasps, workers and reavers of the hive in the south of the crater drop the stings; the Bloodpetal Sprouts that give the {item:22434} grow all over the crater's western half."] = "As vespas, trabalhadoras e aniquiladoras Gorishi da colmeia no sul da cratera deixam cair os ferrões; os Brotos de Pétala Sangrenta que dão o {item:22434} crescem por toda a metade oeste da cratera.",
	-- ["Use the {item:22432} on a living {npc:6498} (an Ironhide or {npc:6500}, or {npc:6584}, counts too): they are elite (level 54-55), hit with {spell:14099} and outrun travel form. Grouping up is encouraged, but a druid can do it alone: Hibernate or {spell:339} it from range, stab it (the barb does not break {spell:2637}), then leave. The credit counts the moment the barb lands, even if you die after. The nearest roams south-west of {area:541}."] = "Use a {item:22432} num {npc:6498} vivo (um Couroférreo, um {npc:6500} ou o {npc:6584} também contam): são elite (nível 54-55), batem com {spell:14099} e correm mais que a forma de viagem. Vale ir em grupo, mas um druida consegue sozinho: Hiberne ou use {spell:339} nele de longe, espete a farpa (ela não quebra o {spell:2637}) e saia. Conta na hora em que a farpa acerta, mesmo que você morra depois. O mais perto anda a sudoeste de {area:541}.",
	-- ["Use the {item:22432} on a {npc:6498}. Devilsaurs are elite (level 54-55) and roam the crater: grouping up is advised."] = "Use a {item:22432} num {npc:6498}. Demossauros são elite (nível 54-55) e vagam pela cratera: é recomendado formar grupo.",
	-- ["{area:1477} lies in the {area:74} in the {zone:1435}. {npc:8580} guards the bottom of the temple: a dungeon boss, so bring a group."] = "{area:1477} fica no {area:74}, no {zone:1435}. {npc:8580} guarda o fundo do templo: é chefe de masmorra, então leve um grupo.",
}
