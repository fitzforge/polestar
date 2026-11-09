-- Portuguese (Brazil) (ptBR): the guide forever/reputation/orgrimmar (forever/reputation/orgrimmar.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Orgrimmar Reputation"] = "Reputação: Orgrimmar",
	-- {zone:1411} Durotar · {zone:1448} Felwood · {zone:1447} Azshara · {item:14047} Runecloth
	["{zone:1411} and Crossroads quests while you level, {zone:1448} and {zone:1447} quests from 55, then {item:14047} to Exalted."] = "Missões de {zone:1411} e da Encruzilhada enquanto você sobe de nível, missões de {zone:1448} e {zone:1447} a partir do 55, depois {item:14047} até Exaltado.",
	-- {faction:76} Orgrimmar
	["Exalted with {faction:76}"] = "Exaltado com {faction:76}",

	-- Step 1: Orgrimmar: how it works
	-- {faction:76} Orgrimmar
	["{faction:76}: how it works"] = "{faction:76}: como funciona",
	-- {faction:76} Orgrimmar · {npc:14726} Rashona Straglash · {quest:7832} Additional Runecloth · {item:14047} Runecloth · {zone:1456} Thunder Bluff · {zone:1458} Undercity · {zone:1411} Durotar · {npc:4949} Thrall · {quest:5726} Hidden Enemies
	["{faction:76} reputation comes from quests and cloth. {npc:14726}, the cloth quartermaster, stands in the Drag beside the cloth and leather armor shop. She takes four one-time donations of 60 cloth (150 each) and then {quest:7832}, 20 {item:14047} for 50, as often as you like. Every point you earn with {faction:76} also gives a quarter as much to {zone:1456}, the {zone:1458} and the Darkspear Trolls. While you level, do {faction:76}'s quests within 5 levels of them: {zone:1411} at 5 to 12, the Crossroads at 12 to 20, {npc:4949}'s {quest:5726} at 12 to 16. The Legacy perk Diplomat adds up to 10%. Rewards: at Honored Orgrimmar's merchants sell to you for 10% less (the Classic rule), the wolf vendor included; at Exalted other races can buy the wolves: 20 gold for a level 40 wolf, 200 gold for a swift wolf at level 60, once you have mount training. {faction:76} has no tabard or other reward."] = "A reputação com {faction:76} vem de missões e de tecido. {npc:14726}, a intendente de tecido, fica no Drag, ao lado da loja de armaduras de tecido e couro. Ela aceita quatro doações únicas de 60 tecidos (150 cada) e depois {quest:7832}, 20 {item:14047} por 50, quantas vezes você quiser. Cada ponto que você ganha com {faction:76} também dá um quarto disso para {zone:1456}, {zone:1458} e os Lançanegra. Enquanto sobe de nível, faça as missões de {faction:76} a até 5 níveis delas: {zone:1411} do 5 ao 12, a Encruzilhada do 12 ao 20, {quest:5726} de {npc:4949} do 12 ao 16. A vantagem do Legado Diplomata soma até 10%. Recompensas: em Honrado, os mercadores de Orgrimmar vendem para você 10% mais barato (regra do Classic), inclusive o vendedor de lobos; em Exaltado, outras raças podem comprar os lobos: 20 de ouro por um lobo de nível 40, 200 de ouro por um lobo veloz no nível 60, desde que você tenha o treinamento de equitação. {faction:76} não tem tabardo nem outra recompensa.",

	-- Step 2: Valley of Trials (optional hub)
	-- {area:363} Valley of Trials
	["{area:363} (optional hub)"] = "{area:363} (hub opcional)",
	-- {area:363} Valley of Trials · {faction:76} Orgrimmar · {npc:3143} Gornek · {npc:10176} Kaltunk
	["Forever pays these old quests in full at any level. The {area:363} is the best of them: about 1,400 {faction:76} and 1,400 Darkspear reputation in 25 minutes. {npc:3143} waits in the Den, the big hut; {npc:10176} stands outside it."] = "O Forever paga estas missões antigas por inteiro em qualquer nível. A melhor delas é {area:363}: cerca de 1.400 de reputação com {faction:76} e 1.400 com os Lançanegra em 25 minutos. {npc:3143} espera no Covil, a cabana grande; {npc:10176} fica do lado de fora.",
	-- {npc:3144} Eitrigg · {faction:76} Orgrimmar · {quest:787} The New Horde
	["{npc:3144}, in {faction:76}: {quest:787}, +50"] = "{npc:3144}, em {faction:76}: {quest:787}, +50",
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
	-- {area:367} Sen'jin Village · {area:368} Echo Isles · {faction:76} Orgrimmar · {npc:3188} Master Gadrin · {npc:3304} Master Vornal · {npc:3194} Vel'rin Fang · {npc:7953} Xar'Ti
	["Forever pays these old quests in full at any level. {area:367} and the {area:368}: about 700 {faction:76} and 650 Darkspear reputation in 25 minutes. {npc:3188} and {npc:3304} stand by the huts, {npc:3194} near the water, {npc:7953} south of the village."] = "O Forever paga estas missões antigas por inteiro em qualquer nível. {area:367} e {area:368}: cerca de 700 de reputação com {faction:76} e 650 com os Lançanegra em 25 minutos. {npc:3188} e {npc:3304} ficam junto às cabanas, {npc:3194} perto da água, {npc:7953} ao sul da vila.",
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
	-- {quest:97223} Bloodtalon Matriarch · {area:362} Razor Hill
	["Makrura and surf crawlers walk the beaches east and south of Sen'jin. The {quest:97223} is east of the village. The Ridgeshade spiders are along the road south of {area:362} and north-east of the Den."] = "Makrura e surfatiscos andam pelas praias a leste e ao sul de Sen'jin. {quest:97223} fica a leste da vila. As aranhas Ridgeshade ficam ao longo da estrada ao sul de {area:362} e a nordeste do Covil.",

	-- Step 12: Sen'jin Village: hand in
	-- {area:367} Sen'jin Village
	["{area:367}: hand in"] = "{area:367}: entregue",

	-- Step 13: Thrall: Hidden Enemies (optional hub)
	-- {npc:4949} Thrall · {quest:5726} Hidden Enemies
	["{npc:4949}: {quest:5726} (optional hub)"] = "{npc:4949}: {quest:5726} (polo opcional)",
	-- {quest:5726} Hidden Enemies · {faction:76} Orgrimmar · {area:2437} Ragefire Chasm
	["Forever pays these old quests in full at any level. {quest:5726}: 400 {faction:76} reputation in 20 minutes, with a run through {area:2437} that a level 60 clears alone."] = "O Forever paga estas missões antigas por inteiro em qualquer nível. {quest:5726}: 400 de reputação com {faction:76} em 20 minutos, com uma passagem por {area:2437} que um nível 60 limpa sozinho.",

	-- Step 14: Skull Rock: the Lieutenant's Insignia
	-- {quest:827} Skull Rock · {item:14544} Lieutenant's Insignia
	["{quest:827}: the {item:14544}"] = "{quest:827}: a {item:14544}",
	-- {quest:827} Skull Rock · {faction:76} Orgrimmar
	-- plural, as words: Burning Blade Fanatics = {npc:3197} Burning Blade Fanatic
	["{quest:827} is the cave just east of {faction:76}. Burning Blade Fanatics and Apprentices inside drop the insignia about one kill in five."] = "{quest:827} é a caverna logo a leste de {faction:76}. Os Fanáticos e Aprendizes da Lâmina Ardente lá dentro soltam a insígnia a cada cinco mortes, mais ou menos.",

	-- Step 15: Orgrimmar: Thrall and Neeru Fireblade
	-- {faction:76} Orgrimmar · {npc:4949} Thrall · {npc:3216} Neeru Fireblade
	["{faction:76}: {npc:4949} and {npc:3216}"] = "{faction:76}: {npc:4949} e {npc:3216}",
	-- {npc:3216} Neeru Fireblade · {object:172960} Cleft of Shadow (no name in this language: may be words)
	["{npc:3216} is in the {object:172960}. Tell him he may speak openly and click through his story."] = "{npc:3216} está em {object:172960}. Diga a ele que pode falar abertamente e clique na história dele.",
	-- {npc:3216} Neeru Fireblade
	["{npc:3216}: hear him out"] = "{npc:3216}: ouça-o até o fim",

	-- Step 16: Ragefire Chasm
	-- {area:2437} Ragefire Chasm · {object:172960} Cleft of Shadow (no name in this language: may be words) · {npc:11518} Jergosh the Invoker · {npc:11519} Bazzalan
	["{area:2437} opens off the {object:172960}. {npc:11518} and {npc:11519} wait at the far end."] = "{area:2437} abre a partir de {object:172960}. {npc:11518} e {npc:11519} esperam no fundo.",
	-- {npc:11518} Jergosh the Invoker · {npc:11519} Bazzalan
	["{npc:11518} and {npc:11519}"] = "{npc:11518} e {npc:11519}",

	-- Step 17: Orgrimmar: Hidden Enemies done
	-- {faction:76} Orgrimmar · {quest:5728} Hidden Enemies
	["{faction:76}: {quest:5728} done"] = "{faction:76}: {quest:5728} concluída",

	-- Step 18: Razor Hill: Sen'jin hand-ins
	-- {area:362} Razor Hill
	["{area:362}: Sen'jin hand-ins"] = "{area:362}: entregas de Sen'jin",

	-- Step 19: Razor Hill (optional hub)
	-- {area:362} Razor Hill
	["{area:362} (optional hub)"] = "{area:362} (hub opcional)",
	-- {area:362} Razor Hill · {zone:1411} Durotar · {faction:76} Orgrimmar · {npc:3142} Orgnil Soulscar · {npc:3139} Gar'Thok · {npc:3191} Cook Torka · {npc:3147} Furl Scornbrow · {npc:266940} Turroc
	["Forever pays these old quests in full at any level. {area:362} and north {zone:1411}: about 1,800 {faction:76} and 1,650 Darkspear reputation in 80 minutes. {npc:3142} and {npc:3139} stand in the middle of the town, {npc:3191} by the barracks, {npc:3147} and {npc:266940} at the edges."] = "O Forever paga estas missões antigas por inteiro em qualquer nível. {area:362} e o norte de {zone:1411}: cerca de 1.800 de reputação com {faction:76} e 1.650 com os Lançanegra em 80 minutos. {npc:3142} e {npc:3139} ficam no meio da cidade, {npc:3191} junto ao quartel, {npc:3147} e {npc:266940} nas pontas.",
	-- {quest:806} Dark Storms · {quest:823} Report to Orgnil
	["{quest:806}, +100: needs {quest:823} from Sen'jin"] = "{quest:806}, +100: exige {quest:823} de Sen'jin",

	-- Step 20: Tiragarde Keep
	-- {area:362} Razor Hill · {npc:3192} Lieutenant Benedict · {object:3239} Benedict's Chest · {item:4881} Aged Envelope · {quest:830} The Admiral's Orders · {item:4870} Canvas Scraps · {item:275713} Raider's Bow
	["The keep is south of {area:362} on the coast. {npc:3192} is in the keep's only building; his key opens {object:3239} on the roof, and the {item:4881} inside starts {quest:830}. The sailors and marines drop the {item:4870}; the {item:275713}, Battleaxe and Shield lie outside the keep."] = "A fortaleza fica ao sul de {area:362}, na costa. {npc:3192} está no único prédio da fortaleza; a chave dele abre {object:3239} no telhado, e {item:4881} lá dentro inicia {quest:830}. Os marujos e fuzileiros soltam {item:4870}; {item:275713}, o Machado de Batalha e o Escudo ficam do lado de fora da fortaleza.",

	-- Step 21: Razormane Grounds and the Echo Isles
	-- {area:816} Razormane Grounds · {area:368} Echo Isles
	["{area:816} and the {area:368}"] = "{area:816} e {area:368}",
	-- {area:362} Razor Hill · {area:368} Echo Isles · {object:3240} Taillasher Eggs
	["The Razormane camps are south-west and west of {area:362}; the Prickly Pear cacti grow among them. Then head to the {area:368} for the {object:3240}: each nest gives an egg every time."] = "Os acampamentos Crinavalha ficam a sudoeste e a oeste de {area:362}; os cactos de figo-da-índia crescem entre eles. Depois vá para {area:368}, para {object:3240}: cada ninho dá um ovo toda vez.",

	-- Step 22: Razor Hill: hand in
	-- {area:362} Razor Hill
	["{area:362}: hand in"] = "{area:362}: entregue",
	-- {quest:830} The Admiral's Orders · {npc:3230} Nazgrel · {faction:76} Orgrimmar
	["{quest:830}, +100: to {npc:3230} in {faction:76}"] = "{quest:830}, +100: para {npc:3230} em {faction:76}",

	-- Step 23: The wreck
	["The wreck"] = "O naufrágio",
	-- {area:372} Tiragarde Keep
	["The wrecked ship lies in the shallows east of {area:372}. Open the Gnomish Toolboxes."] = "O navio naufragado fica nas águas rasas a leste de {area:372}. Abra as Caixas de Ferramentas Gnômicas.",
	-- {npc:3139} Gar'Thok · {area:362} Razor Hill
	["back at {npc:3139} in {area:362}"] = "de volta a {npc:3139} em {area:362}",

	-- Step 24: North Durotar
	-- {zone:1411} Durotar
	["North {zone:1411}"] = "Norte de {zone:1411}",
	-- {npc:3293} Rezlak · {area:362} Razor Hill · {npc:3193} Misha Tor'kren
	["{npc:3293} stands on the road north of {area:362}, {npc:3193} at her farm west of it."] = "{npc:3293} fica na estrada ao norte de {area:362}, {npc:3193} na fazenda dela, a oeste.",

	-- Step 25: Thunder Ridge and Razorwind Canyon
	-- {area:369} Thunder Ridge · {area:410} Razorwind Canyon
	["{area:369} and {area:410}"] = "{area:369} e {area:410}",
	-- {npc:3203} Fizzle Darkstorm · {area:369} Thunder Ridge · {faction:76} Orgrimmar · {area:410} Razorwind Canyon · {area:362} Razor Hill · {item:4891} Kron's Amulet
	["{npc:3203} keeps a Burning Blade camp in {area:369}, south of {faction:76}, among the thunder lizards. The supply sacks lie in {area:410}, north of {area:362}. {item:4891} drops from the crocolisks along the river to the west, about one in ten."] = "{npc:3203} mantém um acampamento da Lâmina Ardente em {area:369}, ao sul de {faction:76}, entre os lagartos-trovão. Os sacos de suprimentos ficam em {area:410}, ao norte de {area:362}. {item:4891} cai dos crocolisques do rio, a oeste, mais ou menos um a cada dez.",

	-- Step 26: Rezlak and Misha
	-- {npc:3293} Rezlak
	["{npc:3293} and Misha"] = "{npc:3293} e Misha",
	-- {npc:3118} Dustwind Storm Witch · {item:277661} Dull Storm Orb · {quest:97281} A Simmering Storm · {npc:3293} Rezlak · {quest:97282} Stormy Potential
	["A {npc:3118} may drop a {item:277661}: use it to start {quest:97281}. Once you hand that in, {npc:3293} offers {quest:97282}."] = "Um {npc:3118} pode soltar {item:277661}: use-o para iniciar {quest:97281}. Depois de entregá-la, {npc:3293} oferece {quest:97282}.",
	-- {npc:3117} Dustwind Savage · {area:370} Drygulch Ravine
	["{npc:3117}, in {area:370}"] = "{npc:3117}, em {area:370}",

	-- Step 27: Stormy Potential
	-- {area:369} Thunder Ridge · {npc:3293} Rezlak
	-- plural, as words: Charged Thunder Lizard Organs = {item:277665} Charged Thunder Lizard Organ
	["The Charged Thunder Lizard Organs come from the thunder lizards on {area:369}, just west of {npc:3293}."] = "Os Órgãos de Lagarto Trovejante Carregados vêm dos lagartos trovejantes em {area:369}, a oeste de {npc:3293}.",

	-- Step 29: Skull Rock
	-- {quest:828} Margoz · {quest:827} Skull Rock · {faction:76} Orgrimmar
	["{quest:828} camps outside {quest:827}, the cave just east of {faction:76}."] = "{quest:828} acampa do lado de fora de {quest:827}, a caverna logo a leste de {faction:76}.",

	-- Step 30: Orgrimmar: Neeru Fireblade and Nazgrel
	-- {faction:76} Orgrimmar · {npc:3216} Neeru Fireblade · {npc:3230} Nazgrel
	["{faction:76}: {npc:3216} and {npc:3230}"] = "{faction:76}: {npc:3216} e {npc:3230}",
	-- {quest:829} Neeru Fireblade · {object:172960} Cleft of Shadow (no name in this language: may be words) · {npc:3230} Nazgrel · {npc:4949} Thrall
	["{quest:829} is in the {object:172960}; {npc:3230} in Grommash Hold beside {npc:4949}."] = "{quest:829} fica em {object:172960}; {npc:3230} na Fortaleza Grommash, ao lado de {npc:4949}.",

	-- Step 31: Far Watch Post
	-- {faction:76} Orgrimmar · {zone:1413} Barrens · {npc:3337} Kargal Battlescar · {quest:809} Ak'Zeloth · {area:379} Far Watch Post
	["Run out of {faction:76}'s west gate and over the bridge into the {zone:1413}. {npc:3337} and {quest:809} stand at {area:379}."] = "Saia correndo pelo portão oeste de {faction:76} e atravesse a ponte para {zone:1413}. {npc:3337} e {quest:809} ficam em {area:379}.",
	-- {quest:842} Crossroads Conscription · {npc:3338} Sergra Darkthorn
	["{quest:842}, +100: to {npc:3338}"] = "{quest:842}, +100: para {npc:3338}",

	-- Step 33: The Crossroads (optional hub)
	-- {area:380} The Crossroads
	["{area:380} (optional hub)"] = "{area:380} (polo opcional)",
	-- {area:380} The Crossroads · {faction:76} Orgrimmar · {npc:3338} Sergra Darkthorn · {npc:3464} Gazrog · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger · {npc:267310} Gur'ak · {npc:3432} Mankrik
	["Forever pays these old quests in full at any level. {area:380}: about 1,500 {faction:76} reputation in 70 minutes, {faction:76}'s only. {npc:3338}, {npc:3464}, {npc:3429}, {npc:3449} and {npc:267310} stand in the town, {npc:3432} by the inn."] = "O Forever paga estas missões antigas por inteiro em qualquer nível. {area:380}: cerca de 1.500 de reputação de {faction:76} em 70 minutos, só para {faction:76}. {npc:3338}, {npc:3464}, {npc:3429}, {npc:3449} e {npc:267310} ficam na cidade, {npc:3432} junto à estalagem.",

	-- Step 34: Around the Crossroads
	["Around the Crossroads"] = "Em volta da Encruzilhada",
	-- {npc:267307} Chol'aruk · {area:1699} Thorn Hill · {npc:10668} Beaten Corpse · {area:378} Camp Taurajo
	["The Razormane camps and the supply crates are north-east of the town; {npc:267307}, an elite boar, sits deep in the {area:1699} cave there. The Witchwing harpies nest far to the north-west. The {npc:10668} lies north-east of {area:378}, in the south: right-click it. Raptors and plainstriders are everywhere."] = "Os acampamentos dos Lâminas Navalhas e as caixas de suprimentos ficam a nordeste da cidade; {npc:267307}, um javali de elite, está no fundo da caverna de {area:1699}. As harpias Asabruxa fazem ninho bem ao noroeste. O {npc:10668} fica a nordeste de {area:378}, no sul: clique com o botão direito nele. Raptores e corredores-das-planícies estão por toda parte.",
	-- {npc:10668} Beaten Corpse
	["{npc:10668}: right-click it"] = "{npc:10668}: clique com o botão direito",

	-- Step 35: The Crossroads: hand in
	-- {area:380} The Crossroads
	["{area:380}: hand in"] = "{area:380}: entregar",

	-- Step 36: Zhevras, quilboars, harpies and the Raptor Grounds
	-- {area:1697} Raptor Grounds
	["Zhevras, quilboars, harpies and the {area:1697}"] = "Zevras, javalis-espinho, harpias e {area:1697}",
	-- {npc:3438} Kreenig Snarlsnout · {quest:3281} Stolen Silver · {area:1697} Raptor Grounds · {area:378} Camp Taurajo
	-- plural, as words: Zhevra Runners = {npc:3242} Zhevra Runner · Witchwing Slayers = {npc:3278} Witchwing Slayer
	["Zhevra Runners graze south and west of the town. {npc:3438} leads the Razormane camps north-east. The Witchwing Slayers carry the rings. The {quest:3281} is in the {area:1697} east of {area:378}: follow the nest-lined path on its left side to the last nest."] = "As Zevras Corredoras pastam ao sul e a oeste da cidade. {npc:3438} comanda os acampamentos dos Lâminas Navalhas a nordeste. As Asabruxas Matadoras carregam os anéis. {quest:3281} fica em {area:1697}, a leste de {area:378}: siga o caminho cheio de ninhos pelo lado esquerdo até o último ninho.",

	-- Step 37: The Crossroads: hand in again
	-- {area:380} The Crossroads
	["{area:380}: hand in again"] = "{area:380}: entregar de novo",

	-- Step 38: Prowlers, Serena Bloodfeather and Echeyakee
	-- {npc:3452} Serena Bloodfeather · {quest:881} Echeyakee
	["Prowlers, {npc:3452} and {quest:881}"] = "Predadores, {npc:3452} e {quest:881}",
	-- {quest:876} Serena Bloodfeather · {npc:3338} Sergra Darkthorn · {item:10327} Horn of Echeyakee · {object:147524} Echeyakee's Lair (no name in this language: may be words)
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["Savannah Prowlers lie west and north of the Crossroads. {quest:876} leads the Witchwing harpies in the far north-west. Then {npc:3338} gives you the {item:10327}: blow it beside the kodo bones at {object:147524}, north of the town, and kill the white lion."] = "Os Predadores da Savana ficam a oeste e ao norte da Encruzilhada. {quest:876} comanda as harpias Asabruxa no extremo noroeste. Depois {npc:3338} entrega a você o {item:10327}: sopre-o ao lado dos ossos de kodo em {object:147524}, ao norte da cidade, e mate o leão branco.",

	-- Step 39: Chen's Empty Keg (optional hub)
	-- {quest:819} Chen's Empty Keg
	["{quest:819} (optional hub)"] = "{quest:819} (polo opcional)",
	-- {quest:819} Chen's Empty Keg · {zone:1413} Barrens · {npc:3292} Brewmaster Drohn · {area:392} Ratchet · {faction:76} Orgrimmar
	["Forever pays it in full at any level. {quest:819} lies on the ground at one of several spots in the central and northern {zone:1413}, most of them by the roads around the Crossroads; once someone takes it, it turns up at another. {npc:3292} in {area:392} pays 250 {faction:76} reputation for the keg and its first filling, then 50 for every filling after, as often as you like."] = "O Forever a paga por inteiro em qualquer nível. {quest:819} fica no chão em um de vários pontos do centro e do norte de {zone:1413}, a maioria junto às estradas ao redor da Encruzilhada; quando alguém a pega, ela aparece em outro. {npc:3292} em {area:392} paga 250 de reputação com {faction:76} pelo barril e pelo primeiro enchimento, depois 50 por cada enchimento seguinte, quantas vezes quiser.",
	-- {quest:819} Chen's Empty Keg
	["{quest:819}: look for it by the roads"] = "{quest:819}: procure nas estradas",

	-- Step 41: Lions, plainstriders and a thunder lizard
	["Lions, plainstriders and a thunder lizard"] = "Leões, corredores-das-planícies e um lagarto-trovão",
	-- {zone:1413} Barrens
	["Savannah lions, plainstriders and thunder lizards roam the whole northern {zone:1413}. The lions drop a tusk about every other kill, the plainstriders a kidney about two kills in five; any thunder lizard may drop the horn, about one in five."] = "Leões da savana, corredores-das-planícies e lagartos-trovão vagam por todo o norte de {zone:1413}. Os leões soltam uma presa mais ou menos a cada duas mortes, os corredores-das-planícies um rim em cerca de duas mortes em cinco; qualquer lagarto-trovão pode soltar o chifre, cerca de um em cinco.",

	-- Step 42: Ratchet: the repeatable keg
	-- {area:392} Ratchet
	["{area:392}: the repeatable keg"] = "{area:392}: o barril repetível",
	-- {item:4897} Thunderhawk Saliva Gland · {item:4896} Kodo Liver · {npc:3238} Stormhide · {area:378} Camp Taurajo · {area:392} Ratchet
	-- plural, as words: Lightning Glands = {item:4898} Lightning Gland · Greater Thunderhawks = {npc:3249} Greater Thunderhawk
	["From now on Drohn takes 5 Lightning Glands, a {item:4897} and a {item:4896} for 50, as often as you like. The {npc:3238} thunder lizards (a gland about every other kill), the Greater Thunderhawks and the kodos south of {area:378} drop them. Gather several sets before you head back to {area:392}."] = "A partir de agora, Drohn aceita 5 Glândulas Relampejantes, uma {item:4897} e um {item:4896} por 50, quantas vezes você quiser. Os lagartos-trovão {npc:3238} (uma glândula a cada duas mortes, mais ou menos), os Grandes Falcotrons e os kodos ao sul de {area:378} as soltam. Junte vários conjuntos antes de voltar a {area:392}.",
	-- {item:4898} Lightning Gland
	-- plural, as words: Stormhides = {npc:3238} Stormhide
	["{item:4898}, from Stormhides"] = "{item:4898}, dos Borrascouros",
	-- {item:4897} Thunderhawk Saliva Gland
	-- plural, as words: Greater Thunderhawks = {npc:3249} Greater Thunderhawk
	["{item:4897}, from Greater Thunderhawks"] = "{item:4897}, dos Grandes Falcotrons",
	-- {item:4896} Kodo Liver
	["{item:4896}, from the kodos"] = "{item:4896}, dos kodos",

	-- Step 43: Rashona Straglash: A Donation of Wool
	-- {npc:14726} Rashona Straglash · {item:14047} Runecloth · {quest:7832} Additional Runecloth
	["From here it is cloth. Wool, Silk and Mageweave must all be handed in before {npc:14726} offers the {item:14047} donation, and {quest:7832} needs the {item:14047} donation. Buy cloth at the Auction House, or farm it: humanoids drop it, Wool from level 15 to 25, Silk 25 to 40, Mageweave 40 to 50, {item:14047} 50 and up. At 60 farm mobs of level 52 or more: lower ones are grey."] = "Daqui em diante é tecido. Lã, Seda e Tecido Arcano precisam ser entregues antes de {npc:14726} oferecer a doação de {item:14047}, e {quest:7832} exige a doação de {item:14047}. Compre tecido na Casa de Leilões ou farme: humanoides o soltam, Lã do nível 15 ao 25, Seda do 25 ao 40, Tecido Arcano do 40 ao 50, {item:14047} do 50 em diante. No 60, farme criaturas de nível 52 ou mais: as menores ficam cinzas.",
	-- {item:2592} Wool Cloth
	["{item:2592}: the Thistlefur furbolgs drop it about one kill in four"] = "{item:2592}: os furbolgs Pelocardo a soltam em cerca de uma a cada quatro mortes",

	-- Step 44: A Donation of Silk
	-- {area:287} Hillsbrad
	["Silk: the Syndicate in {area:287} and Alterac drop it about one kill in three, or buy it."] = "Seda: a Camarilha em {area:287} e Alterac a soltam em cerca de uma a cada três mortes, ou compre.",
	-- {item:4306} Silk Cloth
	["{item:4306}: the Syndicate"] = "{item:4306}: a Camarilha",

	-- Step 45: A Donation of Mageweave
	-- {zone:1448} Felwood · {zone:1446} Tanaris
	["Mageweave: the Jadefire satyrs in southern {zone:1448} and the Dunemaul ogres in {zone:1446} drop it about one kill in three, or buy it."] = "Magitrama: os sátiros Flamejade do sul de {zone:1448} e os ogros Dunamalho de {zone:1446} a soltam em cerca de uma a cada três mortes, ou compre.",
	-- {item:4338} Mageweave Cloth
	["{item:4338}: the Jadefire satyrs"] = "{item:4338}: os sátiros Flamejade",

	-- Step 46: A Donation of Runecloth
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand · {zone:1423} Eastern Plaguelands · {area:2577} Dire Maul · {zone:1444} Feralas · {zone:1451} Silithus
	["{item:14047}: the Scarlet at {area:2266} in the {zone:1423}, the Gordok ogres outside {area:2577} in {zone:1444} and the Twilight camps of {zone:1451} drop it about one kill in three. The Auction House is faster if you have gold."] = "{item:14047}: os Escarlates em {area:2266}, em {zone:1423}, os ogros Gordok fora de {area:2577}, em {zone:1444}, e os acampamentos do Crepúsculo de {zone:1451} a soltam em cerca de uma a cada três mortes. A Casa de Leilões é mais rápida se você tiver ouro.",
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand
	["{item:14047}: the Scarlet outside {area:2266}"] = "{item:14047}: os Escarlates fora de {area:2266}",

	-- Step 47: Bloodvenom Post: Wild Guardians
	-- {npc:10306} Trull Failbane · {area:1997} Bloodvenom Post · {zone:1452} Winterspring · {zone:1448} Felwood
	["These quests are level 56 to 59, so they pay in full at 60. {npc:10306} stands at {area:1997}; the owlbeasts live in {zone:1452}, through the Timbermaw tunnel north of {zone:1448}."] = "Estas missões são de nível 56 a 59, então pagam o valor cheio no 60. {npc:10306} fica em {area:1997}; as corujas-feras vivem em {zone:1452}, passando pelo túnel dos Madeiraguarda, ao norte de {zone:1448}.",

	-- Step 48: Winterspring: owlbeasts
	-- {zone:1452} Winterspring
	["{zone:1452}: owlbeasts"] = "{zone:1452}: corujas-feras",
	-- {area:2255} Everlook
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast · Ragged Owlbeasts = {npc:7450} Ragged Owlbeast
	["Raging Owlbeasts north-west of {area:2255}, Ragged Owlbeasts further west."] = "Ferujas Furiosas a noroeste de {area:2255}, Ferujas Maltrapilhas mais a oeste.",

	-- Step 49: Bloodvenom Post: hand in
	-- {area:1997} Bloodvenom Post
	["{area:1997}: hand in"] = "{area:1997}: entregar",

	-- Step 50: Winterspring: Moontouched Owlbeasts
	-- {zone:1452} Winterspring
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["{zone:1452}: Moontouched Owlbeasts"] = "{zone:1452}: Ferujas Lunamarcas",
	-- {area:2255} Everlook
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Moontouched Owlbeasts north of {area:2255} and south of it."] = "Ferujas Lunamarcas ao norte de {area:2255} e ao sul dele.",

	-- Step 51: Bloodvenom Post: hand in again
	-- {area:1997} Bloodvenom Post
	["{area:1997}: hand in again"] = "{area:1997}: entregar de novo",

	-- Step 52: Winterspring: Berserk Owlbeasts
	-- {zone:1452} Winterspring
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["{zone:1452}: Berserk Owlbeasts"] = "{zone:1452}: Ferujas Berserk",
	-- {area:2255} Everlook · {item:12558} Blue-feathered Necklace · {quest:4882} Guarding Secrets
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["Most Berserk Owlbeasts are north of {area:2255}. A {item:12558} may drop from the owlbeasts now: use it to start {quest:4882}."] = "A maioria das Ferujas Berserk fica ao norte de {area:2255}. Um {item:12558} pode cair das corujas-feras agora: use-o para começar {quest:4882}.",

	-- Step 53: Bloodvenom Post: last hand-in
	-- {area:1997} Bloodvenom Post
	["{area:1997}: last hand-in"] = "{area:1997}: última entrega",
	-- {quest:4882} Guarding Secrets · {zone:1456} Thunder Bluff · {npc:5770} Nara Wildmane · {area:1639} Elder Rise
	["{quest:4882}, +100 {zone:1456}: to {npc:5770} on {area:1639} in {zone:1456}"] = "{quest:4882}, +100 {zone:1456}: para {npc:5770} em {area:1639}, em {zone:1456}",
	-- {quest:4721} Wild Guardians · {faction:76} Orgrimmar
	["{quest:4721}: 300 {faction:76} reputation."] = "{quest:4721}: 300 de reputação com {faction:76}.",

	-- Step 54: Belgrom Rockmaul: Betrayed
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor (no name in this language: may be words) · {object:173084} Hall of the Brave (no name in this language: may be words) · {quest:3504} Betrayed
	["{npc:4485} stands in the {object:172958} outside the {object:173084}. The first two {quest:3504} quests are level 53 and pay in full at 60 too, as every quest does in Forever."] = "{npc:4485} fica no {object:172958}, do lado de fora do {object:173084}. As duas primeiras missões de {quest:3504} são de nível 53 e também pagam por inteiro no 60, como toda missão no Forever.",

	-- Step 55: Valormok
	-- {area:1237} Valormok · {zone:1447} Azshara · {npc:8576} Ag'tor Bloodfist
	["Fly to {area:1237} in western {zone:1447}. {npc:8576} sends you north-east to the blood elf camp on the bluffs of the northern peninsula."] = "Voe até {area:1237}, no oeste de {zone:1447}. {npc:8576} manda você para nordeste, até o acampamento dos elfos de sangue nos penhascos da península norte.",

	-- Step 56: Magus Rimtori's camp
	-- {npc:8578} Magus Rimtori
	["{npc:8578}'s camp"] = "O acampamento da {npc:8578}",
	-- {object:151286} Kaldorei Tome of Summoning · {npc:8578} Magus Rimtori
	["Kill the Reclaimers and Surveyors, then walk up to the book inside the ring of stone pillars. Read the {object:151286} there to start the next quest: break the crystals around the circle, kill the guard that comes, then {npc:8578}."] = "Mate os Reclamadores e os Agrimensores, depois suba até o livro dentro do círculo de pilares de pedra. Leia o {object:151286} ali para começar a próxima missão: quebre os cristais ao redor do círculo, mate o guarda que aparecer e então {npc:8578}.",
	-- {npc:8578} Magus Rimtori
	["Find {npc:8578}'s camp"] = "Encontre o acampamento de {npc:8578}",
	-- {object:151286} Kaldorei Tome of Summoning
	["the {object:151286}"] = "o {object:151286}",

	-- Step 57: Valormok and Orgrimmar
	-- {area:1237} Valormok · {faction:76} Orgrimmar
	["{area:1237} and {faction:76}"] = "{area:1237} e {faction:76}",
	-- {npc:4485} Belgrom Rockmaul · {faction:76} Orgrimmar
	["{npc:4485}, in {faction:76}"] = "{npc:4485}, em {faction:76}",
	-- {quest:3506} Betrayed · {faction:76} Orgrimmar
	["{quest:3506}: 300 {faction:76} reputation at 60."] = "{quest:3506}: 300 de reputação com {faction:76} no 60.",

	-- Step 58: Blackrock Mountain, with a group
	["Blackrock Mountain, with a group"] = "Montanha Rocha Negra, com um grupo",
	-- {area:340} Kargath · {zone:1418} Badlands · {faction:76} Orgrimmar · {area:1584} Blackrock Depths · {area:1583} Blackrock Spire · {quest:4724} The Pack Mistress · {item:12652} Bijou's Reconnaissance Report · {quest:4903} Warlord's Command · {npc:3144} Eitrigg
	["{area:340} in the {zone:1418} hands out {faction:76} quests for {area:1584} and {area:1583}, all level 58 to 60 and paid in full: Precarious Predicament and Operation: Death to Angerforge (150 each), {quest:4724} and {item:12652} (100 each), {quest:4903} (150), {npc:3144}'s Wisdom (100) and For The Horde! (Rend's head, 200 to every Horde city). These are dungeon quests: take them when your group goes."] = "{area:340}, em {zone:1418}, entrega missões de {faction:76} para {area:1584} e {area:1583}, todas de nível 58 a 60 e com pagamento cheio: Situação precária e Operação: Morte aos Ira de Ferro (150 cada), {quest:4724} e {item:12652} (100 cada), {quest:4903} (150), a Sabedoria de {npc:3144} (100) e Pela Horda! (a cabeça de Rend, 200 para cada cidade da Horda). São missões de masmorra: pegue-as quando o seu grupo for.",
	-- {npc:9077} Warlord Goretooth · {quest:4903} Warlord's Command
	["{npc:9077}: {quest:4903}, +150, a group of five"] = "{npc:9077}: {quest:4903}, +150, grupo de cinco",
	-- {npc:9081} Galamav the Marksman · {quest:4724} The Pack Mistress
	["{npc:9081}: {quest:4724}, +100, a group of five"] = "{npc:9081}: {quest:4724}, +100, grupo de cinco",

	-- Step 59: Additional Runecloth to Honored
	-- {quest:7832} Additional Runecloth
	["{quest:7832} to Honored"] = "{quest:7832} até Honrado",
	-- {quest:7832} Additional Runecloth · {item:14047} Runecloth
	["{quest:7832}: 20 {item:14047} for 50 reputation, as often as you like. Friendly to Honored is 6,000: 120 hand-ins, 2,400 {item:14047}, less what the quests gave you (an orc starts at Friendly 1,000: 100 hand-ins; an Undead or Skyborne starts at Neutral 2,000 and first needs 20 hand-ins, 400 {item:14047}, to reach Friendly). Hand in every 20 you carry, one after another."] = "{quest:7832}: 20 {item:14047} por 50 de reputação, quantas vezes você quiser. De Amigável a Honrado são 6.000: 120 entregas, 2.400 {item:14047}, menos o que as missões deram (um orc começa em Amigável 1.000: 100 entregas; um Renegado ou Celonato começa em Neutro 2.000 e antes precisa de 20 entregas, 400 {item:14047}, para chegar a Amigável). Entregue a cada 20 que você carregar, uma depois da outra.",

	-- Step 60: Additional Runecloth to Revered
	-- {quest:7832} Additional Runecloth
	["{quest:7832} to Revered"] = "{quest:7832} até Reverenciado",
	-- {item:14047} Runecloth
	["Honored to Revered is 12,000: 240 hand-ins, 4,800 {item:14047}. The Auction House price of a stack decides whether to farm or buy."] = "De Honrado a Reverenciado são 12.000: 240 entregas, 4.800 {item:14047}. O preço de uma pilha na Casa de Leilões decide entre farmar e comprar.",

	-- Step 61: Additional Runecloth to Exalted
	-- {quest:7832} Additional Runecloth
	["{quest:7832} to Exalted"] = "{quest:7832} até Exaltado",
	-- {item:14047} Runecloth · {faction:76} Orgrimmar · {npc:3362} Ogunaro Wolfrunner · {object:172958} Valley of Honor (no name in this language: may be words)
	["Revered to Exalted is 21,000: 420 hand-ins, 8,400 {item:14047}. Raid heads pay too: The Lord of Blackrock (Nefarian) 200 to every Horde city and Victory for the Horde (Onyxia) 400 to {faction:76}. At Exalted, {npc:3362} in the {object:172958} sells the wolves to every Horde race: 20 gold for a level 40 wolf, 200 gold for a swift wolf at level 60 (Forever's prices); in Classic other races needed Exalted to buy them."] = "De Reverenciado a Exaltado são 21.000: 420 entregas, 8.400 {item:14047}. Chefes de raide também pagam: O Senhor dos Rocha Negra (Nefarian) 200 para toda cidade da Horda e Vitória para a Horda (Onyxia) 400 para {faction:76}. Em Exaltado, {npc:3362} em {object:172958} vende os lobos para toda raça da Horda: 20 de ouro por um lobo de nível 40, 200 de ouro por um lobo veloz no nível 60 (preços do Forever); no Classic, outras raças precisavam de Exaltado para comprá-los.",
	-- {npc:3362} Ogunaro Wolfrunner
	["{npc:3362}: the wolves"] = "{npc:3362}: os lobos",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Adeptos das Trevas e Umbramantes (nível 58-60) o deixam cair aqui; cada Flagelo morto aqui também conta para {object:92525} (veja esse guia). A Casa de Leilões também serve.",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Ogros Dunamalho (nível 45-48) o deixam cair aqui. A Casa de Leilões também serve.",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. The {area:363} is the best of them: about 1,400 {faction:76} and 1,400 Darkspear reputation in 25 minutes (about 280 each at a fifth). {npc:3143} waits in the Den, the big hut; {npc:10176} stands outside it."] = "No Classic, missões 6 ou mais níveis abaixo do seu pagam menos (um quinto no 60); um relato do beta do Forever diz que pagaram o valor cheio. Sua primeira entrega mostra qual é o caso: se pagar um quinto, pule estes polos. {area:363} é o melhor deles: cerca de 1.400 de {faction:76} e 1.400 de reputação com os Lançanegra em 25 minutos (cerca de 280 cada, com um quinto). {npc:3143} espera na Toca, a cabana grande; {npc:10176} fica do lado de fora.",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. {area:362} and north {zone:1411}: about 1,800 {faction:76} and 1,650 Darkspear reputation in 80 minutes (360 and 330 at a fifth). {npc:3142} and {npc:3139} stand in the middle of the town, {npc:3191} by the barracks, {npc:3147} and {npc:266940} at the edges."] = "No Classic, missões 6 ou mais níveis abaixo do seu pagam menos (um quinto no 60); um relato do beta do Forever diz que pagaram o valor cheio. Sua primeira entrega mostra qual é o caso: se pagar um quinto, pule estes polos. {area:362} e o norte de {zone:1411}: cerca de 1.800 de {faction:76} e 1.650 de reputação com os Lançanegra em 80 minutos (360 e 330, com um quinto). {npc:3142} e {npc:3139} ficam no meio da cidade, {npc:3191} perto do quartel, {npc:3147} e {npc:266940} nas bordas.",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. {area:367} and the {area:368}: about 700 {faction:76} and 650 Darkspear reputation in 25 minutes (140 and 130 at a fifth). {npc:3188} and {npc:3304} stand by the huts, {npc:3194} near the water, {npc:7953} south of the village."] = "No Classic, missões 6 ou mais níveis abaixo do seu pagam menos (um quinto no 60); um relato do beta do Forever diz que pagaram o valor cheio. Sua primeira entrega mostra qual é o caso: se pagar um quinto, pule estes polos. {area:367} e {area:368}: cerca de 700 de {faction:76} e 650 de reputação com os Lançanegra em 25 minutos (140 e 130, com um quinto). {npc:3188} e {npc:3304} ficam perto das cabanas, {npc:3194} perto da água, {npc:7953} ao sul da vila.",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. {area:380}: about 1,500 {faction:76} reputation in 70 minutes (300 at a fifth), {faction:76}'s only. {npc:3338}, {npc:3464}, {npc:3429}, {npc:3449} and {npc:267310} stand in the town, {npc:3432} by the inn."] = "No Classic, missões 6 ou mais níveis abaixo do seu pagam menos (um quinto no 60); um relato do beta do Forever diz que pagaram o valor cheio. Sua primeira entrega mostra qual é o caso: se pagar um quinto, pule estes polos. {area:380}: cerca de 1.500 de reputação com {faction:76} em 70 minutos (300, com um quinto), só de {faction:76}. {npc:3338}, {npc:3464}, {npc:3429}, {npc:3449} e {npc:267310} ficam na cidade, {npc:3432} perto da estalagem.",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. {quest:5726}: 400 {faction:76} reputation in 20 minutes (80 at a fifth), with a run through {area:2437} that a level 60 clears alone."] = "No Classic, missões 6 ou mais níveis abaixo do seu pagam menos (um quinto no 60); um relato do beta do Forever diz que pagaram o valor cheio. Sua primeira entrega mostra qual é o caso: se pagar um quinto, pule estes polos. {quest:5726}: 400 de reputação com {faction:76} em 20 minutos (80, com um quinto), com uma incursão por {area:2437} que um nível 60 faz sozinho.",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip this. {quest:819} lies on the ground at one of several spots in the central and northern {zone:1413}, most of them by the roads around the Crossroads; once someone takes it, it turns up at another. {npc:3292} in {area:392} pays 250 {faction:76} reputation for the keg and its first filling, then 50 for every filling after, as often as you like (10 at a fifth)."] = "No Classic, as missões 6 ou mais níveis abaixo de você pagam menos (um quinto no 60); um relato do beta do Forever diz que pagaram o valor cheio. Sua primeira entrega mostra qual vale: se pagar um quinto, pule isto. {quest:819} fica no chão em um de vários pontos do centro e do norte de {zone:1413}, a maioria junto às estradas em volta da Encruzilhada; quando alguém a pega, ela aparece em outro. {npc:3292}, em {area:392}, paga 250 de reputação com {faction:76} pelo barril e pela primeira enchida, depois 50 por cada enchida seguinte, quantas vezes você quiser (10 com um quinto).",
	-- ["Keep handing in {quest:7832} until {faction:76} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continue entregando {quest:7832} até ficar Exaltado com {faction:76}. {item:14047}: Adeptos das Trevas e Umbramantes (nível 58-60) em {zone:1423}, ou a Casa de Leilões.",
	-- ["Keep handing in {quest:7832}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continue entregando {quest:7832}, 20 {item:14047} de cada vez. {item:14047}: Adeptos das Trevas e Umbramantes (nível 58-60) em {zone:1423}, ou a Casa de Leilões.",
	-- ["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "Centauros Kolkar (nível 30-33) a deixam cair aqui. A Casa de Leilões também serve.",
	-- ["Level 56-60 quests and {item:14047} to Exalted, with the old {zone:1411} quests as a fast extra if they still pay in full."] = "Missões de nível 56 a 60 e {item:14047} até Exaltado, com as antigas missões de {zone:1411} como extra rápido, se ainda pagarem o valor cheio.",
	-- ["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "Seguranças da Empreendimentos S.A. em {area:381} (nível 16-17) o deixam cair aqui. A Casa de Leilões também serve.",
	-- ["{npc:14726} takes cloth for {faction:76} in {faction:76}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7832} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14726} aceita tecido para {faction:76} em {faction:76}. Os primeiros donativos de Lã, Seda, Magitrama e {item:14047} (60 tecidos cada) são feitos uma vez só e dão mais reputação por tecido; depois deles, {quest:7832} se repete até Exaltado. Ficar Exaltado com a cidade de outra raça permite comprar as montarias dessa raça. A vantagem de Legado Diplomata do Forever aumenta os ganhos de reputação.",
	-- ["{npc:14726}: {item:14047} delivered"] = "{npc:14726}: {item:14047} entregue",
	-- ["{npc:4485} stands in the {object:172958} outside the {object:173084}. The first two {quest:3504} quests are level 53 and pay a little less at 60 (in Classic 30 and 45); the last two pay in full."] = "{npc:4485} fica em {object:172958}, do lado de fora de {object:173084}. As duas primeiras missões de {quest:3504} são de nível 53 e pagam um pouco menos no 60 (no Classic, 30 e 45); as duas últimas pagam o valor cheio.",
	-- ["{quest:7832} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7832} pede 20 {item:14047} por entrega e se repete quantas vezes você quiser. Traga {item:14047} em múltiplos de 20 e entregue tudo de uma vez, uma entrega após a outra. {item:14047}: Adeptos das Trevas e Umbramantes (nível 58-60) em {zone:1423}, ou a Casa de Leilões.",
}
