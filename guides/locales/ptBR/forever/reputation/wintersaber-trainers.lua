-- Portuguese (Brazil) (ptBR): the guide forever/reputation/wintersaber-trainers (forever/reputation/wintersaber-trainers.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Wintersaber Trainers Reputation"] = "Reputação: Treinadores de Sabres-do-inverno",
	-- {spell:17229} Winterspring Frostsaber · {zone:1452} Winterspring
	["The {spell:17229}: 840 quest turn-ins in {zone:1452}, with Timbermaw reputation on the side."] = "{spell:17229}: 840 entregas de missão em {zone:1452}, com reputação com os Presamatos de bônus.",
	-- {area:1769} Timbermaw Hold · {item:21383} Winterfall Spirit Beads · {quest:5201} Winterfall Intrusion
	["{area:1769} reputation on the side: 50 and about 4 {item:21383} per {quest:5201}"] = "Reputação com {area:1769} de bônus: 50 e cerca de 4 {item:21383} por {quest:5201}",

	-- Step 1: Rivern Frostwind
	-- {npc:10618} Rivern Frostwind · {area:2241} Frostsaber Rock · {zone:1452} Winterspring · {faction:589} Wintersaber Trainers · {quest:4970} Frostsaber Provisions
	["{npc:10618} stands on top of {area:2241}, in the far north of {zone:1452}; the path winds up from the east side. Only the Alliance can earn the {faction:589}' favour, from Neutral, at level 58. All three of her quests pay 50 and repeat as often as you like: 840 turn-ins from Neutral to Exalted. The first one, {quest:4970}, is the only one open at the start."] = "{npc:10618} fica no topo de {area:2241}, no extremo norte de {zone:1452}; o caminho sobe em curvas pelo lado leste. Só a Aliança pode ganhar o favor dos {faction:589}, a partir de Neutro, no nível 58. As três missões dela pagam 50 e se repetem quantas vezes você quiser: 840 entregas de Neutro a Exaltado. A primeira, {quest:4970}, é a única aberta no começo.",

	-- Step 2: Shardtooth and Chillwind meat
	["Shardtooth and Chillwind meat"] = "Carne de Dentilhaço e de Ventogelante",
	-- {npc:7445} Elder Shardtooth · {area:2255} Everlook · {npc:7446} Rabid Shardtooth
	-- plural, as words: Chillwind Ravagers = {npc:7449} Chillwind Ravager · Chillwind Chimaeras = {npc:7448} Chillwind Chimaera · Shardtooth Bears = {npc:7444} Shardtooth Bear
	["The meat only drops while the quest is in your log, and a group shares no loot: farm it alone. The best droppers live right below the rock: {npc:7445} bears (about half the time) and Chillwind Ravagers (half the time) roam the snowfields east and south-east of it. Around {area:2255} the Chillwind Chimaeras drop it as often and the Shardtooth Bears a little less; the {npc:7446} by the giants' gorge in the south drop it most often (six in ten)."] = "A carne só cai enquanto a missão está no seu registro, e o grupo não divide saque: farme sozinho. Os melhores lugares ficam logo abaixo da rocha: ursos {npc:7445} (cerca de metade das vezes) e Assoladores Ventogelantes (metade das vezes) rondam os campos de neve a leste e sudeste dela. Ao redor de {area:2255} as Quimeras Ventogelantes soltam com a mesma frequência e os Ursos Dentilhaço um pouco menos; os {npc:7446} perto do desfiladeiro dos gigantes, no sul, soltam com mais frequência (seis em dez).",
	-- {item:12622} Shardtooth Meat
	["{item:12622}: the bears"] = "{item:12622}: os ursos",
	-- {item:12623} Chillwind Meat
	["{item:12623}: the chimaeras"] = "{item:12623}: as quimeras",

	-- Step 3: Back to Rivern Frostwind
	-- {npc:10618} Rivern Frostwind
	["Back to {npc:10618}"] = "De volta a {npc:10618}",

	-- Step 4: Neutral to Friendly: Frostsaber Provisions, then Winterfall Intrusion
	-- {quest:4970} Frostsaber Provisions · {quest:5201} Winterfall Intrusion
	["Neutral to Friendly: {quest:4970}, then {quest:5201}"] = "De Neutro a Amigável: {quest:4970}, depois {quest:5201}",
	-- {quest:4970} Frostsaber Provisions · {quest:5201} Winterfall Intrusion · {area:2244} Winterfall Village · {area:2255} Everlook
	-- plural, as words: Winterfall Shamans = {npc:7439} Winterfall Shaman · Winterfall Ursas = {npc:7438} Winterfall Ursa
	["Repeat {quest:4970}: 30 turn-ins reach Neutral 1,500, and then {quest:5201} opens: 5 Winterfall Shamans and 5 Winterfall Ursas in {area:2244}, just east of {area:2255}. The village has only a few Shamans, but every furbolg there shares their spawn points: kill all of them, not just the ones you need, and more Shamans and Ursas appear; more Ursas walk the ridge just south-west of the village. Take both quests on every trip: kill the furbolgs, pick up meat on the way back. Neutral to Friendly is 60 turn-ins."] = "Repita a {quest:4970}: 30 entregas levam você a Neutro 1.500, e então a {quest:5201} abre: 5 Xamãs Invernosos e 5 Ursinos Invernosos em {area:2244}, logo a leste de {area:2255}. A vila tem só alguns Xamãs, mas todo furbolg de lá divide os pontos de nascimento deles: mate todos, não só os que você precisa, e surgem mais Xamãs e Ursinos; mais Ursinos andam pela crista logo a sudoeste da vila. Pegue as duas missões a cada viagem: mate os furbolgs, junte carne na volta. De Neutro a Amigável são 60 entregas.",

	-- Step 5: Friendly to Honored
	["Friendly to Honored"] = "Amigável a Honrado",
	-- {quest:5201} Winterfall Intrusion · {quest:4970} Frostsaber Provisions · {area:1769} Timbermaw Hold · {item:21383} Winterfall Spirit Beads · {faction:589} Wintersaber Trainers
	["Friendly to Honored is 6,000: 120 turn-ins. {quest:5201} is the quickest; do {quest:4970} when the village is crowded or you pass the bears and chimaeras anyway. Every Winterfall furbolg you kill counts for {area:1769} too: 50 Timbermaw reputation per {quest:5201} up to the end of Honored with them, and about four {item:21383}. Take Salfa's Winterfall Activity (the Timbermaw guide) the first time you are in the village, and keep the beads until your Timbermaw kills stop counting: then each 5 pay 50. You will reach Exalted with the Timbermaw long before the {faction:589}."] = "De Amigável a Honrado são 6.000: 120 entregas. A {quest:5201} é a mais rápida; faça a {quest:4970} quando a vila estiver cheia ou você passar pelos ursos e quimeras de qualquer jeito. Todo furbolg Invernoso que você mata conta também para {area:1769}: 50 de reputação com os Presamatos por {quest:5201} até o fim de Honrado com eles, e cerca de quatro {item:21383}. Pegue a Atividade Invernosa de Salfa (o guia dos Presamatos) na primeira vez que estiver na vila, e guarde as contas até suas mortes pararem de contar para os Presamatos: então cada 5 pagam 50. Você chegará a Exaltado com os Presamatos muito antes dos {faction:589}.",

	-- Step 6: Honored to Exalted: Rampaging Giants too
	-- {quest:5981} Rampaging Giants
	["Honored to Exalted: {quest:5981} too"] = "De Honrado a Exaltado: {quest:5981} também",
	-- {quest:5981} Rampaging Giants · {area:2249} Frostwhisper Gorge · {zone:1452} Winterspring · {area:2244} Winterfall Village · {npc:7446} Rabid Shardtooth · {item:12622} Shardtooth Meat
	-- plural, as words: Frostmaul Giants = {npc:7428} Frostmaul Giant · Frostmaul Preservers = {npc:7429} Frostmaul Preserver
	["At Honored Rivern Frostwind adds {quest:5981}: 4 Frostmaul Giants and 4 Frostmaul Preservers, elite giants in {area:2249} in the south-east of {zone:1452}; the path down into the gorge starts at its north-west end. Take it on a trip south with a friend or two, or when {area:2244} is crowded; the {npc:7446} by the gorge drop {item:12622} most often. Honored to Exalted is 33,000: 660 turn-ins."] = "No Honrado, Ripárion Glaciares acrescenta a {quest:5981}: 4 Gigantes Friomalho e 4 Preservadores Friomalho, gigantes elite em {area:2249}, no sudeste de {zone:1452}; o caminho para o desfiladeiro começa na ponta noroeste dele. Faça numa viagem ao sul com um ou dois amigos, ou quando {area:2244} estiver cheia; os {npc:7446} perto do desfiladeiro soltam {item:12622} com mais frequência. De Honrado a Exaltado são 33.000: 660 entregas.",
	-- {npc:7428} Frostmaul Giant
	["{npc:7428}, elite"] = "{npc:7428}, elite",
	-- {npc:7429} Frostmaul Preserver
	["{npc:7429}, elite"] = "{npc:7429}, elite",
}
