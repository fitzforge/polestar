-- Portuguese (Brazil) (ptBR): the guide forever/reputation/darkspear-trolls (forever/reputation/darkspear-trolls.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Darkspear Trolls Reputation"] = "Reputação: Trolls Lançanegra",
	-- {item:14047} Runecloth · {zone:1411} Durotar · {zone:1454} Orgrimmar
	["{item:14047} to Exalted, with the old {zone:1411} quests as a fast extra that pays {zone:1454} too."] = "{item:14047} até Exaltado, com as velhas missões de {zone:1411} como um extra rápido que também paga {zone:1454}.",
	-- {faction:530} Darkspear Trolls
	["Exalted with the {faction:530}"] = "Exaltado com os {faction:530}",

	-- Step 1: Vehena: how it works
	-- {npc:14727} Vehena
	["{npc:14727}: how it works"] = "{npc:14727}: como funciona",
	-- {npc:14727} Vehena · {zone:1454} Orgrimmar · {object:172961} Valley of Spirits (no name in this language: may be words) · {quest:7837} Additional Runecloth · {item:14047} Runecloth · {faction:530} Darkspear Trolls · {zone:1456} Thunder Bluff · {zone:1458} Undercity · {zone:1411} Durotar · {area:414} Zoram Strand · {zone:1440} Ashenvale · {object:3202} Grom'gol (no name in this language: may be words)
	["Darkspear reputation comes from quests and cloth. {npc:14727}, the Darkspear cloth quartermaster, stands in {zone:1454}'s {object:172961}. She takes four one-time donations of 60 cloth (150 each) and then {quest:7837}, 20 {item:14047} for 50, as often as you like. Every point you earn with the {faction:530} also gives a quarter as much to {zone:1454}, {zone:1456} and the {zone:1458}. While you level, do the Darkspear quests within 5 levels of them: {zone:1411} at 5 to 12, {area:414} in {zone:1440} at 19 to 27, {object:3202} in Stranglethorn at 34 to 46. The Legacy perk Diplomat adds up to 10%. Rewards: at Honored the Darkspear merchants sell to you for 10% less (the Classic rule), the raptor vendor included; at Exalted other races can buy the raptors: 20 gold for a level 40 raptor, 200 gold for a swift raptor at level 60, once you have mount training. The {faction:530} have no tabard or other reward."] = "A reputação com os Lançanegra vem de missões e de tecido. {npc:14727}, a intendente de tecido dos Lançanegra, fica em {object:172961} de {zone:1454}. Ela aceita quatro doações únicas de 60 tecidos (150 cada) e depois {quest:7837}, 20 {item:14047} por 50, quantas vezes você quiser. Cada ponto que você ganha com {faction:530} também dá um quarto disso para {zone:1454}, {zone:1456} e {zone:1458}. Enquanto sobe de nível, faça as missões dos Lançanegra a até 5 níveis delas: {zone:1411} do 5 ao 12, {area:414} em {zone:1440} do 19 ao 27, {object:3202} na Selva do Espinhaço do 34 ao 46. A vantagem do Legado Diplomata soma até 10%. Recompensas: em Honrado, os mercadores Lançanegra vendem para você 10% mais barato (regra do Classic), inclusive o vendedor de raptores; em Exaltado, outras raças podem comprar os raptores: 20 de ouro por um raptor de nível 40, 200 de ouro por um raptor veloz no nível 60, desde que você tenha o treinamento de equitação. {faction:530} não têm tabardo nem outra recompensa.",

	-- Step 2: Valley of Trials (optional hub)
	-- {area:363} Valley of Trials
	["{area:363} (optional hub)"] = "{area:363} (hub opcional)",
	-- {area:363} Valley of Trials · {zone:1454} Orgrimmar · {npc:3143} Gornek · {npc:10176} Kaltunk
	["Forever pays these old quests in full at any level. The {area:363} is the best of them: about 1,400 {zone:1454} and 1,400 Darkspear reputation in 25 minutes. {npc:3143} waits in the Den, the big hut; {npc:10176} stands outside it."] = "O Forever paga estas missões antigas por inteiro em qualquer nível. A melhor delas é {area:363}: cerca de 1.400 de reputação com {zone:1454} e 1.400 com os Lançanegra em 25 minutos. {npc:3143} espera no Covil, a cabana grande; {npc:10176} fica do lado de fora.",
	-- {npc:3144} Eitrigg · {zone:1454} Orgrimmar · {quest:787} The New Horde
	["{npc:3144}, in {zone:1454}: {quest:787}, +50"] = "{npc:3144}, em {zone:1454}: {quest:787}, +50",
	-- {npc:5765} Ruzan · {quest:792} Vile Familiars
	["{npc:5765}: {quest:792}, warlocks only"] = "{npc:5765}: {quest:792}, só bruxos",

	-- Step 3: Boars, weapons and peons
	["Boars, weapons and peons"] = "Javalis, armas e peões",
	-- {npc:10556} Lazy Peon · {item:16114} Foreman's Blackjack
	["The training weapons lie on the ground in the Den and among the boars to the north. For the peons: target a sleeping {npc:10556} and use the {item:16114} on it."] = "As armas de treino estão no chão do Covil e entre os javalis ao norte. Para os peões: mire em um {npc:10556} dormindo e use {item:16114} nele.",
	-- {npc:10556} Lazy Peon · {item:16114} Foreman's Blackjack
	["{npc:10556}: hit it with the {item:16114}"] = "{npc:10556}: acerte com {item:16114}",
	-- {npc:10556} Lazy Peon
	["Wake {npc:10556}"] = "",

	-- Step 4: The Den: hand in
	-- {area:364} The Den
	["{area:364}: hand in"] = "{area:364}: entregue",

	-- Step 5: North of the Den
	["North of the Den"] = "Ao norte do Covil",
	-- {npc:3287} Hana'zua · {quest:790} Sarkoth · {quest:792} Vile Familiars · {area:365} Burning Blade Coven · {quest:6394} Thazz'ril's Pick
	["The cactus apples grow beside the cacti north of the Den. {npc:3287} lies wounded by the rocks to the north; {quest:790}, his big scorpid, roams close by. {quest:792} swarm at the mouth of the {area:365}; {quest:6394} lies inside: take the middle tunnel where it splits three ways."] = "As sabras crescem ao lado dos cactos ao norte do Covil. {npc:3287} jaz ferido junto às pedras ao norte; {quest:790}, seu grande escorpídeo, vaga por perto. {quest:792} fervilham na boca de {area:365}; {quest:6394} está lá dentro: pegue o túnel do meio, onde se divide em três.",
	-- {quest:6394} Thazz'ril's Pick
	["{quest:6394}, in the cave"] = "{quest:6394}, na caverna",

	-- Step 6: The Den: hand in again
	-- {area:364} The Den
	["{area:364}: hand in again"] = "{area:364}: entregue de novo",

	-- Step 7: Burning Blade Coven
	-- {npc:3183} Yarrog Baneshadow
	["Go back into the cave and keep to the right-hand wall all the way, over a small stream, to {npc:3183} on a ledge above a pool."] = "Volte para dentro da caverna e siga sempre pela parede da direita, sobre um riacho pequeno, até {npc:3183}, numa saliência acima de uma poça.",
	-- {quest:794} Burning Blade Medallion · {npc:3183} Yarrog Baneshadow
	["{quest:794}, from {npc:3183}"] = "{quest:794}, com {npc:3183}",
	-- {npc:3145} Zureetha Fargaze
	["{npc:3145}, in the Den"] = "{npc:3145}, no Covil",
	-- {quest:805} Report to Sen'jin Village · {quest:97225} Forgotten Loa Idols
	["{quest:805}, +50: {quest:97225} waits on it"] = "{quest:805}, +50: {quest:97225} vem depois",

	-- Step 9: Sen'jin Village (optional hub)
	-- {area:367} Sen'jin Village
	["{area:367} (optional hub)"] = "{area:367} (hub opcional)",
	-- {area:367} Sen'jin Village · {area:368} Echo Isles · {zone:1454} Orgrimmar · {npc:3188} Master Gadrin · {npc:3304} Master Vornal · {npc:3194} Vel'rin Fang · {npc:7953} Xar'Ti
	["Forever pays these old quests in full at any level. {area:367} and the {area:368}: about 625 {zone:1454} and 650 Darkspear reputation in 25 minutes. {npc:3188} and {npc:3304} stand by the huts, {npc:3194} near the water, {npc:7953} south of the village."] = "O Forever paga estas missões antigas por inteiro em qualquer nível. {area:367} e {area:368}: cerca de 625 de reputação com {zone:1454} e 650 com os Lançanegra em 25 minutos. {npc:3188} e {npc:3304} ficam junto às cabanas, {npc:3194} perto da água, {npc:7953} ao sul da vila.",
	-- {quest:97225} Forgotten Loa Idols · {quest:805} Report to Sen'jin Village
	["{quest:97225}, +100: needs {quest:805} from the Den"] = "{quest:97225}, +100: precisa de {quest:805}, do Covil",

	-- Step 10: The Echo Isles
	-- {area:368} Echo Isles
	["The {area:368}"] = "{area:368}",
	-- {area:368} Echo Isles · {quest:826} Zalazane
	-- plural, as words: Durotar Tigers = {npc:3121} Durotar Tiger
	["Swim to the largest of the {area:368}, south-east of the village. {quest:826}, the idols and the skulls at the circle of power are all there; the Durotar Tigers prowl the smaller islands."] = "Nade até a maior de {area:368}, a sudeste da vila. {quest:826}, os ídolos e as caveiras do círculo de poder estão todos lá; os Tigres de Durotar rondam as ilhas menores.",
	-- {quest:808} Minshina's Skull · {object:3237} Imprisoned Darkspear
	["{quest:808}: click an {object:3237} skull"] = "{quest:808}: clique em uma caveira de {object:3237}",

	-- Step 11: The coast and the road
	["The coast and the road"] = "A costa e a estrada",
	-- {quest:97223} Bloodtalon Matriarch
	["Makrura and surf crawlers walk the beaches east and south of Sen'jin. The {quest:97223} is east of the village."] = "Makrura e surfatiscos andam pelas praias a leste e ao sul de Sen'jin. {quest:97223} fica a leste da vila.",

	-- Step 12: Sen'jin Village: hand in
	-- {area:367} Sen'jin Village
	["{area:367}: hand in"] = "{area:367}: entregue",

	-- Step 13: Razor Hill: Sen'jin hand-ins
	-- {area:362} Razor Hill
	["{area:362}: Sen'jin hand-ins"] = "{area:362}: entregas de Sen'jin",

	-- Step 14: Razor Hill (optional hub)
	-- {area:362} Razor Hill
	["{area:362} (optional hub)"] = "{area:362} (hub opcional)",
	-- {area:362} Razor Hill · {zone:1411} Durotar · {zone:1454} Orgrimmar · {npc:3142} Orgnil Soulscar · {npc:3139} Gar'Thok · {npc:3191} Cook Torka · {npc:3147} Furl Scornbrow
	["Forever pays these old quests in full at any level. {area:362} and north {zone:1411}: about 1,650 {zone:1454} and 1,650 Darkspear reputation in 80 minutes. {npc:3142} and {npc:3139} stand in the middle of the town, {npc:3191} by the barracks, {npc:3147} and Turroc at the edges."] = "O Forever paga estas missões antigas por inteiro em qualquer nível. {area:362} e o norte de {zone:1411}: cerca de 1.650 de reputação com {zone:1454} e 1.650 com os Lançanegra em 80 minutos. {npc:3142} e {npc:3139} ficam no meio da cidade, {npc:3191} junto ao quartel, {npc:3147} e Turroc nas pontas.",
	-- {quest:806} Dark Storms · {quest:823} Report to Orgnil
	["{quest:806}, +100: needs {quest:823} from Sen'jin"] = "{quest:806}, +100: exige {quest:823} de Sen'jin",

	-- Step 15: Tiragarde Keep
	-- {area:362} Razor Hill · {npc:3192} Lieutenant Benedict · {object:3239} Benedict's Chest · {item:4881} Aged Envelope · {quest:830} The Admiral's Orders · {item:4870} Canvas Scraps
	["The keep is south of {area:362} on the coast. {npc:3192} is in the keep's only building; his key opens {object:3239} on the roof, and the {item:4881} inside starts {quest:830}. The sailors and marines drop the {item:4870}."] = "A fortaleza fica ao sul de {area:362}, na costa. {npc:3192} está no único prédio da fortaleza; a chave dele abre {object:3239} no telhado, e {item:4881} lá dentro inicia {quest:830}. Os marujos e fuzileiros soltam {item:4870}.",

	-- Step 16: Razormane Grounds and the Echo Isles
	-- {area:816} Razormane Grounds · {area:368} Echo Isles
	["{area:816} and the {area:368}"] = "{area:816} e {area:368}",
	-- {area:362} Razor Hill · {area:368} Echo Isles · {object:3240} Taillasher Eggs
	["The Razormane camps are south-west and west of {area:362}. Then head to the {area:368} for the {object:3240}: each nest gives an egg every time."] = "Os acampamentos Crinavalha ficam a sudoeste e a oeste de {area:362}. Depois vá para {area:368}, para {object:3240}: cada ninho dá um ovo toda vez.",

	-- Step 17: Razor Hill: hand in
	-- {area:362} Razor Hill
	["{area:362}: hand in"] = "{area:362}: entregue",
	-- {quest:830} The Admiral's Orders · {npc:3230} Nazgrel · {zone:1454} Orgrimmar
	["{quest:830}, +100: to {npc:3230} in {zone:1454}"] = "{quest:830}, +100: para {npc:3230} em {zone:1454}",

	-- Step 18: The wreck
	["The wreck"] = "O naufrágio",
	-- {area:372} Tiragarde Keep
	["The wrecked ship lies in the shallows east of {area:372}. Open the Gnomish Toolboxes."] = "O navio naufragado fica nas águas rasas a leste de {area:372}. Abra as Caixas de Ferramentas Gnômicas.",
	-- {npc:3139} Gar'Thok · {area:362} Razor Hill
	["back at {npc:3139} in {area:362}"] = "de volta a {npc:3139} em {area:362}",

	-- Step 19: North Durotar
	-- {zone:1411} Durotar
	["North {zone:1411}"] = "Norte de {zone:1411}",
	-- {npc:3293} Rezlak · {area:362} Razor Hill · {npc:3193} Misha Tor'kren
	["{npc:3293} stands on the road north of {area:362}, {npc:3193} at her farm west of it."] = "{npc:3293} fica na estrada ao norte de {area:362}, {npc:3193} na fazenda dela, a oeste.",

	-- Step 20: Thunder Ridge and Razorwind Canyon
	-- {area:369} Thunder Ridge · {area:410} Razorwind Canyon
	["{area:369} and {area:410}"] = "{area:369} e {area:410}",
	-- {npc:3203} Fizzle Darkstorm · {area:369} Thunder Ridge · {zone:1454} Orgrimmar · {area:410} Razorwind Canyon · {area:362} Razor Hill · {item:4891} Kron's Amulet
	["{npc:3203} keeps a Burning Blade camp in {area:369}, south of {zone:1454}, among the thunder lizards. The supply sacks lie in {area:410}, north of {area:362}. {item:4891} drops from the crocolisks along the river to the west, about one in ten."] = "{npc:3203} mantém um acampamento da Lâmina Ardente em {area:369}, ao sul de {zone:1454}, entre os lagartos trovejantes. Os sacos de suprimentos ficam em {area:410}, ao norte de {area:362}. {item:4891} cai dos crocolriscos ao longo do rio a oeste, cerca de um em dez.",

	-- Step 21: Rezlak and Misha
	-- {npc:3293} Rezlak
	["{npc:3293} and Misha"] = "{npc:3293} e Misha",
	-- {npc:3118} Dustwind Storm Witch · {item:277661} Dull Storm Orb · {quest:97281} A Simmering Storm · {npc:3293} Rezlak · {quest:97282} Stormy Potential
	["A {npc:3118} may drop a {item:277661}: use it to start {quest:97281}. Once you hand that in, {npc:3293} offers {quest:97282}."] = "Um {npc:3118} pode soltar {item:277661}: use-o para iniciar {quest:97281}. Depois de entregá-la, {npc:3293} oferece {quest:97282}.",
	-- {npc:3117} Dustwind Savage · {area:370} Drygulch Ravine
	["{npc:3117}, in {area:370}"] = "{npc:3117}, em {area:370}",

	-- Step 22: Stormy Potential
	-- {area:369} Thunder Ridge · {npc:3293} Rezlak
	-- plural, as words: Charged Thunder Lizard Organs = {item:277665} Charged Thunder Lizard Organ
	["The Charged Thunder Lizard Organs come from the thunder lizards on {area:369}, just west of {npc:3293}."] = "Os Órgãos de Lagarto Trovejante Carregados vêm dos lagartos trovejantes em {area:369}, a oeste de {npc:3293}.",

	-- Step 24: Skull Rock
	-- {quest:828} Margoz · {quest:827} Skull Rock · {zone:1454} Orgrimmar
	["{quest:828} camps outside {quest:827}, the cave just east of {zone:1454}."] = "{quest:828} acampa fora de {quest:827}, a caverna logo a leste de {zone:1454}.",

	-- Step 25: Orgrimmar: Neeru Fireblade and Nazgrel
	-- {zone:1454} Orgrimmar · {npc:3216} Neeru Fireblade · {npc:3230} Nazgrel
	["{zone:1454}: {npc:3216} and {npc:3230}"] = "{zone:1454}: {npc:3216} e {npc:3230}",
	-- {quest:829} Neeru Fireblade · {object:172960} Cleft of Shadow (no name in this language: may be words) · {npc:3230} Nazgrel
	["{quest:829} is in the {object:172960}; {npc:3230} in Grommash Hold beside Thrall."] = "{quest:829} fica em {object:172960}; {npc:3230} na Fortaleza Grommash, ao lado de Thrall.",

	-- Step 26: Far Watch Post
	-- {zone:1454} Orgrimmar · {zone:1413} Barrens · {npc:3337} Kargal Battlescar · {quest:809} Ak'Zeloth · {area:379} Far Watch Post
	["Run out of {zone:1454}'s west gate and over the bridge into the {zone:1413}. {npc:3337} and {quest:809} stand at {area:379}."] = "Saia pelo portão oeste de {zone:1454} e atravesse a ponte para {zone:1413}. {npc:3337} e {quest:809} ficam em {area:379}.",
	-- {quest:842} Crossroads Conscription · {npc:3338} Sergra Darkthorn
	["{quest:842}, +100: to {npc:3338}"] = "{quest:842}, +100: para {npc:3338}",

	-- Step 28: Vehena: A Donation of Wool
	-- {npc:14727} Vehena · {item:14047} Runecloth · {quest:7837} Additional Runecloth
	["From here it is cloth. Wool, Silk and Mageweave must all be handed in before {npc:14727} offers the {item:14047} donation, and {quest:7837} needs the {item:14047} donation. Buy cloth at the Auction House, or farm it: humanoids drop it, Wool from level 15 to 25, Silk 25 to 40, Mageweave 40 to 50, {item:14047} 50 and up. At 60 farm mobs of level 52 or more: lower ones are grey."] = "Daqui em diante é tecido. Lã, Seda e Magitrama precisam ser entregues antes de {npc:14727} oferecer a doação de {item:14047}, e {quest:7837} exige a doação de {item:14047}. Compre tecido na Casa de Leilões ou farme: humanoides o soltam, Lã do nível 15 ao 25, Seda do 25 ao 40, Magitrama do 40 ao 50, {item:14047} do 50 em diante. No 60, farme monstros de nível 52 ou mais: os menores são cinzas.",
	-- {item:2592} Wool Cloth
	["{item:2592}: the Thistlefur furbolgs drop it about one kill in four"] = "{item:2592}: os furbolgs Pelocardo a soltam em cerca de uma a cada quatro mortes",

	-- Step 29: A Donation of Silk
	-- {area:287} Hillsbrad
	["Silk: the Syndicate in {area:287} and Alterac drop it about one kill in three, or buy it."] = "Seda: a Camarilha em {area:287} e Alterac a soltam em cerca de uma a cada três mortes, ou compre.",
	-- {item:4306} Silk Cloth
	["{item:4306}: the Syndicate"] = "{item:4306}: a Camarilha",

	-- Step 30: A Donation of Mageweave
	-- {zone:1448} Felwood · {zone:1446} Tanaris
	["Mageweave: the Jadefire satyrs in southern {zone:1448} and the Dunemaul ogres in {zone:1446} drop it about one kill in three, or buy it."] = "Magitrama: os sátiros Flamejade do sul de {zone:1448} e os ogros Dunamalho de {zone:1446} a soltam em cerca de uma a cada três mortes, ou compre.",
	-- {item:4338} Mageweave Cloth
	["{item:4338}: the Jadefire satyrs"] = "{item:4338}: os sátiros Flamejade",

	-- Step 31: A Donation of Runecloth
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand · {zone:1423} Eastern Plaguelands · {area:2577} Dire Maul · {zone:1444} Feralas · {zone:1451} Silithus
	["{item:14047}: the Scarlet at {area:2266} in the {zone:1423}, the Gordok ogres outside {area:2577} in {zone:1444} and the Twilight camps of {zone:1451} drop it about one kill in three. The Auction House is faster if you have gold."] = "{item:14047}: os Escarlates em {area:2266}, em {zone:1423}, os ogros Gordok fora de {area:2577}, em {zone:1444}, e os acampamentos do Crepúsculo de {zone:1451} a soltam em cerca de uma a cada três mortes. A Casa de Leilões é mais rápida se você tiver ouro.",
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand
	["{item:14047}: the Scarlet outside {area:2266}"] = "{item:14047}: os Escarlates fora de {area:2266}",

	-- Step 32: Everlook: A Little Luck
	-- {quest:969} Luck Be With You · {npc:11755} Harlo Wigglesworth · {area:2255} Everlook · {npc:10307} Witch Doctor Mau'ari · {item:12334} Frostmaul Shards · {area:2249} Frostwhisper Gorge · {zone:1452} Winterspring
	-- plural, as words: Frostmaul Giants = {npc:7428} Frostmaul Giant
	["{quest:969} is level 60, so it pays in full. {npc:11755} in {area:2255} sends you to {npc:10307}, who stands in the same town. The {item:12334} lie on the ground in {area:2249}, the canyon at the south end of {zone:1452}, and the Frostmaul Giants there drop them too (about one in five). The giants are elite level 59 and 60 and stand close together: pick the shards at the edges, pull one giant at a time, or bring a friend."] = "{quest:969} é de nível 60, então paga por inteiro. {npc:11755} em {area:2255} envia você a {npc:10307}, que fica na mesma cidade. As {item:12334} estão no chão em {area:2249}, o desfiladeiro no extremo sul de {zone:1452}, e os Gigantes Friomalho de lá também os soltam (cerca de um em cinco). Os gigantes são elites de nível 59 e 60 e ficam bem juntos: pegue os fragmentos nas bordas, puxe um gigante por vez ou leve um amigo.",

	-- Step 33: Blackrock Mountain, with a group
	["Blackrock Mountain, with a group"] = "Montanha Rocha Negra, com um grupo",
	-- {area:1583} Blackrock Spire · {faction:530} Darkspear Trolls · {area:340} Kargath · {zone:1418} Badlands · {quest:4903} Warlord's Command · {npc:3144} Eitrigg · {zone:1458} Undercity · {area:978} Zul'Farrak · {zone:1425} Hinterlands
	["For The Horde! (Rend's head, {area:1583}) and The Lord of Blackrock (Nefarian's head) pay 200 to every Horde city, the {faction:530} included. {area:340} in the {zone:1418} starts the Rend chain: {quest:4903}, {npc:3144}'s Wisdom, then For The Horde!. Take them when your group goes. The Spider God chain of the {zone:1458} guide ({area:978} and the {zone:1425}) pays 225 Darkspear on the way."] = "Pela Horda! (a cabeça de Rend, {area:1583}) e O Senhor dos Rocha Negra (a cabeça de Nefarian) pagam 200 a toda cidade da Horda, inclusive os {faction:530}. {area:340} em {zone:1418} inicia a cadeia de Rend: {quest:4903}, a Sabedoria de {npc:3144}, depois Pela Horda!. Pegue-as quando o seu grupo for. A cadeia da Deusa Aranha do guia de {zone:1458} ({area:978} e {zone:1425}) paga 225 Lançanegra pelo caminho.",
	-- {npc:9077} Warlord Goretooth · {quest:4903} Warlord's Command
	["{npc:9077}: {quest:4903}, a group of five"] = "{npc:9077}: {quest:4903}, um grupo de cinco",

	-- Step 34: Additional Runecloth to Honored
	-- {quest:7837} Additional Runecloth
	["{quest:7837} to Honored"] = "{quest:7837} até Honrado",
	-- {quest:7837} Additional Runecloth · {item:14047} Runecloth
	["{quest:7837}: 20 {item:14047} for 50 reputation, as often as you like. Friendly to Honored is 6,000: 120 hand-ins, 2,400 {item:14047}, less what the quests gave you (a troll starts at Friendly 1,000: 100 hand-ins; an Undead or Skyborne at Neutral 2,000 first needs 20 more to reach Friendly). Hand in every 20 you carry, one after another."] = "{quest:7837}: 20 {item:14047} por 50 de reputação, quantas vezes você quiser. De Amigável a Honrado são 6.000: 120 entregas, 2.400 {item:14047}, menos o que as missões deram (um troll começa em Amigável 1.000: 100 entregas; um Morto-vivo ou Celonato em Neutro 2.000 primeiro precisa de mais 20 para chegar a Amigável). Entregue a cada 20 que carregar, uma depois da outra.",

	-- Step 35: Additional Runecloth to Revered
	-- {quest:7837} Additional Runecloth
	["{quest:7837} to Revered"] = "{quest:7837} até Reverenciado",
	-- {item:14047} Runecloth
	["Honored to Revered is 12,000: 240 hand-ins, 4,800 {item:14047}. The Auction House price of a stack decides whether to farm or buy."] = "De Honrado a Reverenciado são 12.000: 240 entregas, 4.800 {item:14047}. O preço de uma pilha na Casa de Leilões decide entre farmar e comprar.",

	-- Step 36: Additional Runecloth to Exalted
	-- {quest:7837} Additional Runecloth
	["{quest:7837} to Exalted"] = "{quest:7837} até Exaltado",
	-- {item:14047} Runecloth · {npc:7952} Zjolnir · {area:367} Sen'jin Village
	["Revered to Exalted is 21,000: 420 hand-ins, 8,400 {item:14047}. At Exalted, {npc:7952} in {area:367} sells the raptors to every Horde race: 20 gold for a level 40 raptor, 200 gold for a swift raptor at level 60 (Forever's prices); in Classic other races needed Exalted to buy them."] = "De Reverenciado a Exaltado são 21.000: 420 entregas, 8.400 {item:14047}. Em Exaltado, {npc:7952} em {area:367} vende os raptores a todas as raças da Horda: 20 de ouro por um raptor de nível 40, 200 de ouro por um raptor veloz no nível 60 (preços do Forever); no Classic, outras raças precisavam de Exaltado para comprá-los.",
	-- {npc:7952} Zjolnir
	["{npc:7952}: the raptors"] = "{npc:7952}: os raptores",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Adeptos das Trevas e Umbramantes (nível 58-60) deixam cair aqui; cada Flagelo morto aqui também conta para {object:92525} (veja esse guia). A Casa de Leilões também serve.",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Ogros Dunamalho (nível 45-48) deixam cair aqui. A Casa de Leilões também serve.",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. The {area:363} is the best of them: about 1,400 {zone:1454} and 1,400 Darkspear reputation in 25 minutes (about 280 each at a fifth). {npc:3143} waits in the Den, the big hut; {npc:10176} stands outside it."] = "No Classic, missões 6 ou mais níveis abaixo de você pagam menos (um quinto no 60); um relato da beta do Forever diz que pagaram por inteiro. Sua primeira entrega mostra qual vale: se pagar um quinto, pule estes hubs. {area:363} é o melhor deles: cerca de 1.400 de {zone:1454} e 1.400 de reputação Lançanegra em 25 minutos (cerca de 280 cada, com um quinto). {npc:3143} espera no Covil, a cabana grande; {npc:10176} fica do lado de fora.",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. {area:362} and north {zone:1411}: about 1,800 {zone:1454} and 1,650 Darkspear reputation in 80 minutes (360 and 330 at a fifth). {npc:3142} and {npc:3139} stand in the middle of the town, {npc:3191} by the barracks, {npc:3147} and {npc:266940} at the edges."] = "No Classic, missões 6 ou mais níveis abaixo de você pagam menos (um quinto no 60); um relato da beta do Forever diz que pagaram por inteiro. Sua primeira entrega mostra qual vale: se pagar um quinto, pule estes hubs. {area:362} e o norte de {zone:1411}: cerca de 1.800 de {zone:1454} e 1.650 de reputação Lançanegra em 80 minutos (360 e 330, com um quinto). {npc:3142} e {npc:3139} ficam no meio da cidade, {npc:3191} perto do quartel, {npc:3147} e {npc:266940} nas bordas.",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. {area:367} and the {area:368}: about 700 {zone:1454} and 650 Darkspear reputation in 25 minutes (140 and 130 at a fifth). {npc:3188} and {npc:3304} stand by the huts, {npc:3194} near the water, {npc:7953} south of the village."] = "No Classic, missões 6 ou mais níveis abaixo de você pagam menos (um quinto no 60); um relato da beta do Forever diz que pagaram por inteiro. Sua primeira entrega mostra qual vale: se pagar um quinto, pule estes hubs. {area:367} e {area:368}: cerca de 700 de {zone:1454} e 650 de reputação Lançanegra em 25 minutos (140 e 130, com um quinto). {npc:3188} e {npc:3304} ficam perto das cabanas, {npc:3194} perto da água, {npc:7953} ao sul da vila.",
	-- ["Keep handing in {quest:7837} until {faction:530} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continue entregando {quest:7837} até ficar Exaltado com {faction:530}. {item:14047}: Adeptos das Trevas e Umbramantes (nível 58-60) em {zone:1423}, ou a Casa de Leilões.",
	-- ["Keep handing in {quest:7837}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continue entregando {quest:7837}, 20 {item:14047} por vez. {item:14047}: Adeptos das Trevas e Umbramantes (nível 58-60) em {zone:1423}, ou a Casa de Leilões.",
	-- ["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "Centauros Kolkar (nível 30-33) deixam cair aqui. A Casa de Leilões também serve.",
	-- ["Makrura and surf crawlers walk the beaches east and south of Sen'jin. The {quest:97223} is east of the village. The Ridgeshade spiders are along the road south of {area:362} and north-east of the Den."] = "Makrura e surfatiscos andam pelas praias a leste e ao sul de Sen'jin. {quest:97223} fica a leste da vila. As aranhas Ridgeshade ficam ao longo da estrada ao sul de {area:362} e a nordeste do Covil.",
	-- ["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "Seguranças da Empreendimentos S.A. em {area:381} (nível 16-17) deixam cair aqui. A Casa de Leilões também serve.",
	-- ["{npc:14727} takes cloth for {faction:530} in the {object:172961}, {zone:1454}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7837} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14727} recebe tecido para {faction:530} em {object:172961}, {zone:1454}. As primeiras doações de Lã, Seda, Magitrama e {item:14047} (60 tecidos cada) são feitas uma vez só e dão mais reputação por tecido; depois delas, {quest:7837} se repete até Exaltado. Exaltado com a cidade de outra raça permite comprar as montarias dessa raça. A vantagem de Legado Diplomata do Forever aumenta os ganhos de reputação.",
	-- ["{npc:14727}: {item:14047} delivered"] = "{npc:14727}: {item:14047} entregue",
	-- ["{quest:7837} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7837} pede 20 {item:14047} por entrega e se repete quantas vezes quiser. Traga {item:14047} em múltiplos de 20 e entregue tudo de uma vez, uma entrega após a outra. {item:14047}: Adeptos das Trevas e Umbramantes (nível 58-60) em {zone:1423}, ou a Casa de Leilões.",
}
