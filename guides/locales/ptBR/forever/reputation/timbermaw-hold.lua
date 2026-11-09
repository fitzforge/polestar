-- Portuguese (Brazil) (ptBR): the guide forever/reputation/timbermaw-hold (forever/reputation/timbermaw-hold.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Timbermaw Hold Reputation"] = "Reputação: Domínio dos Presamatos",
	["Safe passage through the tunnels, agility enchants and furbolg recipes; the trinket at Exalted."] = "Passagem segura pelos túneis, encantamentos de agilidade e receitas de furbolg; o berloque no Exaltado.",
	["Recipes for Leatherworkers, Tailors, Enchanters and Alchemists from Friendly to Revered"] = "Receitas para Coureiros, Alfaiates, Encantadores e Alquimistas, de Amigável a Reverenciado",

	-- Step 1: Grazle
	-- {faction:576} Timbermaw Hold · {npc:11554} Grazle · {npc:15395} Nafien · {npc:11556} Salfa · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["{faction:576} starts at Hostile (2,500 of 3,000), so its furbolgs attack you in their tunnels; {npc:11554}, {npc:15395} and {npc:11556} talk to everyone. {npc:11554} waits by the road in the south of {zone:1448}, near the {area:2479}. Every Deadwood and Winterfall furbolg you kill gives 5 reputation up to the last point of Honored, so the quests below pay twice. The Legacy perk Diplomat adds up to 10% to every gain."] = "{faction:576} começa em Hostil (2.500 de 3.000), então os furbolgs deles atacam você nos túneis; {npc:11554}, {npc:15395} e {npc:11556} falam com todo mundo. {npc:11554} fica na estrada no sul de {zone:1448}, perto de {area:2479}. Cada furbolg Lenha Morta e Invernosos que você mata dá 5 de reputação até o último ponto de Honrado, então as missões abaixo pagam em dobro. A vantagem do Legado Diplomata soma até 10% a cada ganho.",

	-- Step 2: Deadwood Village
	-- {zone:1448} Felwood · {item:21377} Deadwood Headdress Feather · {npc:9464} Overlord Ror · {npc:14342} Ragepaw
	["The Deadwood furbolgs (level 48-50) hold the village at the south end of {zone:1448}. Keep every {item:21377}: they are worth 10 reputation each later and never stop counting. {npc:9464} (15 reputation) and the rare {npc:14342} (25) live here and count until Exalted. Forever pays quests in full at any level; in Classic grey mobs gave about a fifth, about 1 a kill for these furbolgs at 60. Do it while leveling if you can."] = "Os furbolgs Lenha Morta (nível 48-50) dominam a vila no extremo sul de {zone:1448}. Guarde cada {item:21377}: vale 10 de reputação mais tarde e nunca deixa de contar. {npc:9464} (15 de reputação) e o raro {npc:14342} (25) vivem aqui e contam até Exaltado. O Forever paga missões por inteiro em qualquer nível; no Classic, mobs cinza davam cerca de um quinto, cerca de 1 por morte desses furbolgs no 60. Faça isso enquanto sobe de nível, se puder.",
	-- {npc:14342} Ragepaw
	["{npc:14342}, rare"] = "{npc:14342}, raro",

	-- Step 3: Back to Grazle
	-- {npc:11554} Grazle
	["Back to {npc:11554}"] = "De volta a {npc:11554}",

	-- Step 4: Nafien
	-- {npc:15395} Nafien · {zone:1448} Felwood
	["{npc:15395} stands at the {zone:1448} mouth of the Timbermaw tunnel, at the top of the road in the north of {zone:1448}."] = "{npc:15395} fica na entrada do túnel dos Presamatos do lado de {zone:1448}, no alto da estrada ao norte de {zone:1448}.",

	-- Step 5: Felpaw Village
	-- {npc:9462} Chieftain Bloodmaw
	["The northern Deadwood (level 53-55) camp just south of the tunnel. They drop feathers about half the time: the best feather spot. {npc:9462} gives 15 until Exalted."] = "Os Lenha Morta do norte (nível 53-55) acampam logo ao sul do túnel. Eles soltam penas cerca de metade das vezes: o melhor lugar para penas. {npc:9462} dá 15 até o Exaltado.",

	-- Step 6: Back to Nafien
	-- {npc:15395} Nafien
	["Back to {npc:15395}"] = "De volta a {npc:15395}",
	-- {quest:8460} Timbermaw Ally
	["These quests and their kills bring you just past Unfriendly (500 from the start). If {quest:8460} paid you less (at level 60 in Classic: 30), kill about 40 more northern Deadwood. From Unfriendly the Timbermaw in the tunnel leave you alone."] = "Estas missões e as mortes delas levam você um pouco além de Inamistoso (500 desde o início). Se a {quest:8460} pagou menos (no nível 60 no Classic: 30), mate mais uns 40 Lenha Morta do norte. A partir de Inamistoso, os Presamatos no túnel deixam você em paz.",

	-- Step 7: Salfa
	-- {zone:1452} Winterspring · {npc:11556} Salfa
	["Walk through the tunnel to its {zone:1452} mouth; {npc:11556} stands just outside. Do not attack any Timbermaw: each one costs 25 reputation."] = "Atravesse o túnel até a saída em {zone:1452}; {npc:11556} fica logo do lado de fora. Não ataque nenhum Presamatos: cada um custa 25 de reputação.",

	-- Step 8: Winterfall Village
	-- {area:2244} Winterfall Village · {zone:1452} Winterspring · {area:2255} Everlook · {item:21383} Winterfall Spirit Beads · {npc:10199} Grizzle Snowpaw · {npc:10738} High Chief Winterfall
	["{area:2244} lies in the east of {zone:1452}, just past {area:2255}. Keep every {item:21383} you loot (10 reputation each later). The Shamans, Den Watchers and Ursas share their spawn points, so kill every furbolg in the village to make the ones you need appear; more Ursas walk the ridge just south-west of the village. {npc:10199} (rare) and {npc:10738}, in the cave at the back, give 25 until Exalted. Alliance: the Wintersaber Trainers' Winterfall Intrusion asks for the same Shamans and Ursas."] = "{area:2244} fica a leste de {zone:1452}, logo depois de {area:2255}. Guarde todo {item:21383} que saquear (10 de reputação cada, mais tarde). Os Xamãs, Vigias do Covil e Ursas dividem os mesmos pontos de nascimento, então mate todos os furbolgs da vila para fazer aparecerem os que você precisa; mais Ursas andam pela crista logo a sudoeste da vila. {npc:10199} (raro) e {npc:10738}, na caverna dos fundos, dão 25 até o Exaltado. Aliança: a Invasão dos Invernosos dos Treinadores de Sabres-do-inverno pede os mesmos Xamãs e Ursas.",
	-- {npc:10199} Grizzle Snowpaw
	["{npc:10199}, rare"] = "{npc:10199}, raro",
	-- {npc:10738} High Chief Winterfall
	["{npc:10738}, elite"] = "{npc:10738}, elite",

	-- Step 9: Back to Salfa
	-- {npc:11556} Salfa
	["Back to {npc:11556}"] = "De volta a {npc:11556}",
	-- {quest:8466} Feathers for Grazle · {quest:8467} Feathers for Nafien · {quest:8469} Beads for Salfa
	["{quest:8466}, {quest:8467} and {quest:8469} are open now: 50 reputation for 5 feathers or 5 beads, as often as you like. Do not hand them in yet."] = "{quest:8466}, {quest:8467} e {quest:8469} já estão abertas: 50 de reputação por 5 penas ou 5 contas, quantas vezes quiser. Não entregue ainda.",

	-- Step 10: Unfriendly to Neutral
	["Unfriendly to Neutral"] = "De Inamistoso a Neutro",
	-- {zone:1448} Felwood · {area:2246} Frostfire Hot Springs · {area:2243} Timbermaw Post · {npc:11556} Salfa · {area:2244} Winterfall Village
	["Unfriendly to Neutral is 3,000: about 540 more kills after these quests. Three camps: the northern Deadwood by the {zone:1448} mouth of the tunnel; the Winterfall camps around {area:2246} and {area:2243}, just south and south-east of {npc:11556} (Pathfinders give 6 a kill, Den Watchers and Totemics 5, the shortest walk to a turn-in); and {area:2244} in the east. Pick the least crowded. Keep all feathers and beads."] = "De Inamistoso a Neutro são 3.000: cerca de 540 mortes a mais depois dessas missões. Três acampamentos: os Lenha Morta do norte, na saída do túnel em {zone:1448}; os acampamentos Invernosos ao redor de {area:2246} e {area:2243}, logo ao sul e sudeste de {npc:11556} (Desbravadores dão 6 por morte, Vigias do Covil e Totêmicos 5, a caminhada mais curta até uma entrega); e {area:2244} a leste. Escolha o menos cheio. Guarde todas as penas e contas.",
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["Deadwood Headdress Feathers: keep them"] = "Penas do Cocar de Lenha Morta: guarde-as",
	-- {item:21383} Winterfall Spirit Beads
	["{item:21383}: keep them"] = "{item:21383}: guarde-os",
	-- {area:2246} Frostfire Hot Springs
	-- plural, as words: Winterfall Pathfinders = {npc:7442} Winterfall Pathfinder
	["Winterfall Pathfinders, {area:2246}"] = "Desbravadores Invernosos, {area:2246}",

	-- Step 11: Deadwood Ritual Totem
	-- {quest:8470} Deadwood Ritual Totem · {npc:11558} Kernda · {zone:1448} Felwood
	-- plural, as words: Mana Potions = {item:3827} Mana Potion
	["The northern Deadwood rarely drop a {quest:8470} (about 3%). From Neutral, {npc:11558} takes it in the tunnel, on the {zone:1448} side: 150 reputation and two Major Healing and Mana Potions."] = "Os Lenha Morta do norte raramente soltam uma {quest:8470} (cerca de 3%). A partir de Neutro, {npc:11558} a aceita no túnel, do lado de {zone:1448}: 150 de reputação e duas Poções de Mana e Cura Maiores.",

	-- Step 12: Winterfall Ritual Totem
	-- {quest:8471} Winterfall Ritual Totem · {npc:11558} Kernda
	-- plural, as words: Mana Potions = {item:3827} Mana Potion
	["The Winterfall furbolgs rarely drop a {quest:8471} (3-4%). {npc:11558} takes it in the tunnel too: 150 reputation and three Major Healing and Mana Potions."] = "Os furbolgs Invernosos raramente soltam uma {quest:8471} (3-4%). {npc:11558} também a aceita no túnel: 150 de reputação e três Poções de Mana e Cura Maiores.",

	-- Step 13: Neutral to Friendly
	["Neutral to Friendly"] = "Neutro a Amigável",
	["Neutral to Friendly is 3,000: 600 kills. Keep all feathers and beads."] = "De Neutro a Amigável são 3.000: 600 mortes. Guarde todas as penas e contas.",

	-- Step 14: Meilosh
	-- {npc:11557} Meilosh · {zone:1448} Felwood · {item:13484} Recipe: Transmute Earth to Water · {item:22392} Formula: Enchant 2H Weapon - Agility · {item:20253} Pattern: Warbear Harness · {item:15065} Warbear Woolies · {quest:6031} Runecloth · {item:14342} Mooncloth · {item:15802} Mooncloth Boots
	["{npc:11557} stands in the tunnel, near its {zone:1448} mouth. From Friendly he sells: {item:13484} (1 gold 50 silver), {item:22392} (2 gold 50 silver), {item:20253} (1 gold 60 silver) and {item:15065} (2 gold). He also takes 30 {quest:6031} once for 100 reputation and a choice of shoulders or gauntlets, and Tailors with skill 290 can bring him 2 {item:14342} for 100 more and the {item:15802} pattern."] = "{npc:11557} fica no túnel, perto da saída em {zone:1448}. A partir de Amigável ele vende: {item:13484} (1 de ouro e 50 pratas), {item:22392} (2 de ouro e 50 pratas), {item:20253} (1 de ouro e 60 pratas) e {item:15065} (2 de ouro). Ele também aceita 30 {quest:6031} uma vez por 100 de reputação e à sua escolha ombreiras ou manoplas, e Alfaiates com perícia 290 podem levar 2 {item:14342} por mais 100 e o padrão {item:15802}.",

	-- Step 15: Runecloth for Meilosh
	-- {quest:6031} Runecloth · {npc:11557} Meilosh
	["{quest:6031} for {npc:11557}"] = "{quest:6031} para {npc:11557}",
	-- {quest:6031} Runecloth
	["{quest:6031} drops from the humanoids of the level 50-60 zones, the Deadwood and Winterfall furbolgs among them."] = "{quest:6031} cai dos humanoides das zonas de nível 50-60, entre eles os furbolgs Lenha Morta e Invernosos.",

	-- Step 16: Sacred Cloth
	-- {npc:11557} Meilosh · {item:14342} Mooncloth · {item:15802} Mooncloth Boots
	["Tailors with skill 290: {npc:11557} takes 2 {item:14342} once for 100 reputation and teaches the {item:15802}."] = "Alfaiates com perícia 290: {npc:11557} aceita 2 {item:14342} uma vez por 100 de reputação e ensina as {item:15802}.",

	-- Step 17: Friendly to Honored
	["Friendly to Honored"] = "Amigável a Honrado",
	-- {npc:11557} Meilosh · {item:19445} Formula: Enchant Weapon - Agility · {item:19202} Pattern: Heavy Timbermaw Belt · {item:19044} Might of the Timbermaw · {skill:165} Leatherworking · {item:19047} Wisdom of the Timbermaw · {skill:197} Tailoring
	["Friendly to Honored is 6,000: 1,200 kills. Keep all feathers and beads. Honored opens at {npc:11557}: {item:19445} (3 gold), and for 2 gold 20 silver each {item:19202} and {item:19044} ({skill:165}) and {item:19047} ({skill:197})."] = "De Amigável a Honrado são 6.000: 1.200 mortes. Guarde todas as penas e contas. Honrado libera em {npc:11557}: {item:19445} (3 de ouro), e por 2 de ouro e 20 pratas cada, os padrões {item:19202} e {item:19044} ({skill:165}) e {item:19047} ({skill:197}).",

	-- Step 18: Honored to Revered
	["Honored to Revered"] = "De Honrado a Reverenciado",
	["Honored to Revered is 12,000: 2,400 kills, the last ones that count. Kills stop at 11,999 of 12,000 Honored and never tip you into Revered: when they stop, hand in one set of 5 feathers or beads to cross over. Saving every feather and bead pays off now: about 4,800 kills from the start to the end of Honored leave you with about 2,100 feathers and beads, and that is all of Revered to Exalted. Turning them in early would cost you about 2,400 more kills."] = "De Honrado a Reverenciado são 12.000: 2.400 mortes, as últimas que contam. As mortes param em 11.999 de 12.000 de Honrado e nunca fazem você passar para Reverenciado: quando pararem, entregue um conjunto de 5 penas ou contas para cruzar. Guardar todas as penas e contas compensa agora: cerca de 4.800 mortes do início ao fim de Honrado deixam você com cerca de 2.100 penas e contas, e isso é todo o trecho de Reverenciado a Exaltado. Entregá-las antes custaria cerca de 2.400 mortes a mais.",
	-- {item:19445} Formula: Enchant Weapon - Agility · {skill:333} Enchanting
	["{item:19445} ({skill:333}), 3 gold"] = "{item:19445} ({skill:333}), 3 de ouro",
	-- {quest:8467} Feathers for Nafien
	["{quest:8467}: once your kills stop, 5 feathers into Revered"] = "{quest:8467}: quando as mortes pararem, 5 penas para Reverenciado",
	-- {quest:8469} Beads for Salfa
	["{quest:8469}: or 5 beads"] = "{quest:8469}: ou 5 contas",

	-- Step 19: Revered to Exalted
	["Revered to Exalted"] = "De Reverenciado a Exaltado",
	-- {npc:15395} Nafien · {npc:11554} Grazle · {npc:11556} Salfa · {npc:14342} Ragepaw · {npc:10199} Grizzle Snowpaw · {npc:10738} High Chief Winterfall · {npc:11557} Meilosh · {item:19204} Pattern: Heavy Timbermaw Boots · {item:19049} Timbermaw Brawlers · {skill:165} Leatherworking · {item:19050} Mantle of the Timbermaw · {skill:197} Tailoring
	["Kills stopped at the end of Honored. Revered to Exalted is 21,000: 420 turn-ins, 2,100 feathers and beads. Hand in the feathers to {npc:15395} at the tunnel or {npc:11554} in the south, the beads to {npc:11556}, five at a time. The named furbolgs (Ror, Bloodmaw, {npc:14342}, {npc:10199}, {npc:10738}) still count. Revered opens at {npc:11557}, for 4 gold each: {item:19204} and {item:19049} ({skill:165}) and {item:19050} ({skill:197})."] = "As mortes pararam no fim de Honrado. De Reverenciado a Exaltado são 21.000: 420 entregas, 2.100 penas e contas. Entregue as penas a {npc:15395} no túnel ou a {npc:11554} no sul, as contas a {npc:11556}, cinco por vez. Os furbolgs nomeados (Ror, Gorjassangue, {npc:14342}, {npc:10199}, {npc:10738}) ainda contam. Reverenciado libera em {npc:11557}, por 4 de ouro cada: os padrões {item:19204} e {item:19049} ({skill:165}) e {item:19050} ({skill:197}).",
	-- {quest:8467} Feathers for Nafien
	["{quest:8467}: 5 feathers, 50 reputation"] = "{quest:8467}: 5 penas, 50 de reputação",
	-- {quest:8466} Feathers for Grazle
	["{quest:8466}: 5 feathers, 50 reputation"] = "{quest:8466}: 5 penas, 50 de reputação",
	-- {quest:8469} Beads for Salfa
	["{quest:8469}: 5 beads, 50 reputation"] = "{quest:8469}: 5 contas, 50 de reputação",

	-- Step 20: The Root of All Evil
	-- {npc:11555} Gorn One Eye · {npc:11557} Meilosh · {quest:8481} The Root of All Evil · {item:21144} Demon Summoning Torch · {npc:10738} High Chief Winterfall · {npc:15623} Xandivious · {item:21326} Defender of the Timbermaw
	["At Exalted, {npc:11555}, in the tunnel by {npc:11557}, gives {quest:8481}: plant his {item:21144} in the mouth of {npc:10738}'s cave and defeat the demon {npc:15623} (level 62, elite: bring a group). The reward is {item:21326}, a trinket that calls a Timbermaw ally, and 200 reputation."] = "No Exaltado, {npc:11555}, no túnel ao lado de {npc:11557}, dá a {quest:8481}: plante a {item:21144} dele na entrada da caverna de {npc:10738} e derrote o demônio {npc:15623} (nível 62, elite: leve um grupo). A recompensa é {item:21326}, um berloque que chama um aliado Presamatos, e 200 de reputação.",

	-- Step 21: Xandivious
	-- {area:2244} Winterfall Village · {npc:15623} Xandivious
	["{area:2244}, the cave at the back. Clear the furbolgs around the mouth first, plant the torch, kill {npc:15623} and loot the Essence from his Demon Bag."] = "{area:2244}, a caverna dos fundos. Limpe primeiro os furbolgs ao redor da entrada, plante a tocha, mate {npc:15623} e saqueie a Essência da Bolsa de Demônio dele.",
	-- {npc:15623} Xandivious
	["{npc:15623}, 25 reputation"] = "{npc:15623}, 25 de reputação",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Alternate Deadwood feathers ({npc:15395}) and Winterfall beads ({npc:11556}), whichever camp is less crowded."] = "Alterne penas dos Lenha Morta ({npc:15395}) e contas dos Invernosos ({npc:11556}), conforme o acampamento menos cheio.",
	-- ["Deadwood furbolgs (level 48-50) camp at the southern end of {zone:1448}. Keep every {item:21377} they drop: {npc:11554} and {npc:15395} take them later."] = "Os pelursos Lenha Morta (nível 48-50) acampam no extremo sul de {zone:1448}. Guarde cada {item:21377} que eles deixarem cair: {npc:11554} e {npc:15395} as recebem depois.",
	-- ["Feathers and beads to Friendly"] = "Penas e contas até Amistoso",
	-- ["Feathers for {npc:11554} and Feathers for {npc:15395} (Deadwood Headdress Feathers) and Beads for {npc:11556} ({item:21383}) repeat as often as you like; every Deadwood or Winterfall kill counts as well. {area:2244} is the densest bead spot."] = "Penas para {npc:11554} e Penas para {npc:15395} (Penas do Cocar de Lenha Morta) e Contas para {npc:11556} ({item:21383}) se repetem quantas vezes quiser; cada Lenha Morta ou Invernoso morto também conta. {area:2244} é o melhor lugar para contas.",
	-- ["Feathers to Honored"] = "Penas até Honrado",
	-- ["Go through {faction:576} to its {zone:1452} exit; {npc:11556} stands just outside. The quests and kills so far usually reach Unfriendly, and then the Timbermaw let you pass. If they still show red, kill more Deadwood by the tunnel first."] = "Atravesse {faction:576} até a saída para {zone:1452}; {npc:11556} fica logo do lado de fora. As missões e mortes até aqui costumam chegar a Inamistoso, e então os Presamatos deixam você passar. Se ainda aparecerem em vermelho, mate mais Lenha Morta perto do túnel antes.",
	-- ["Keep turning in feathers and beads until Exalted."] = "Continue entregando penas e contas até Exaltado.",
	-- ["The Deadwood furbolgs (level 48-50) hold the village at the south end of {zone:1448}. Keep every {item:21377}: they are worth 10 reputation each later and never stop counting. {npc:9464} (15 reputation) and the rare {npc:14342} (25) live here and count until Exalted. In Classic, quests 6 or more levels below you pay less and grey mobs give about a fifth: at level 60 {quest:8460} paid 30 instead of 150 and these furbolgs about 1 a kill. Do it while leveling if you can."] = "Os furbolgs Lenha Morta (nível 48-50) dominam a vila no extremo sul de {zone:1448}. Guarde todo {item:21377}: cada um vale 10 de reputação mais tarde e nunca para de contar. {npc:9464} (15 de reputação) e o raro {npc:14342} (25) vivem aqui e contam até o Exaltado. No Classic, missões 6 ou mais níveis abaixo de você pagam menos e criaturas cinzas dão cerca de um quinto: no nível 60, {quest:8460} pagou 30 em vez de 150 e esses furbolgs cerca de 1 por morte. Faça enquanto sobe de nível, se puder.",
	-- ["The northern Deadwood (level 53-55) hold the camps just south of the tunnel. Keep their feathers too."] = "Os Lenha Morta do norte (nível 53-55) ocupam os acampamentos logo ao sul do túnel. Guarde as penas deles também.",
	-- ["The northern Deadwood camps by the tunnel are the densest feather spot (35% drop chance there). Hand feathers to {npc:15395} at the tunnel, or to {npc:11554} in the south."] = "Os acampamentos Lenha Morta do norte, junto ao túnel, são o melhor lugar para penas (35% de chance de saque ali). Entregue as penas a {npc:15395} no túnel, ou a {npc:11554} no sul.",
	-- ["{area:2244} sits on the eastern side of {zone:1452}. Keep every {item:21383} you loot: {npc:11556} takes them."] = "{area:2244} fica no lado leste de {zone:1452}. Guarde todas as {item:21383} que saquear: {npc:11556} as recebe.",
	-- ["{faction:576} starts out Hostile, and its furbolgs in the tunnels attack until you reach Unfriendly. Every Deadwood and Winterfall furbolg you kill raises it, so the quests below pay twice. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:576} começa Hostil, e seus pelursos nos túneis atacam até você chegar a Inamistoso. Cada pelurso Lenha Morta e Invernoso que você mata aumenta a reputação, então as missões abaixo rendem em dobro. A vantagem de Legado Diplomata do Forever aumenta os ganhos de reputação.",
	-- ["{faction:576} to Exalted"] = "{faction:576} até Exaltado",
	-- ["{faction:576} to Revered"] = "{faction:576} até Reverenciado",
	-- ["{npc:11556}: Beads for {npc:11556}"] = "{npc:11556}: Contas para {npc:11556}",
	-- ["{npc:15395} waits in northern {zone:1448} at the tunnel into {faction:576}."] = "{npc:15395} espera no norte de {zone:1448}, no túnel para {faction:576}.",
	-- ["{npc:15395}: Feathers for {npc:15395}"] = "{npc:15395}: Penas para {npc:15395}",
}
