-- Portuguese (Brazil) (ptBR): the guide forever/class/rogue/poisons-alliance (forever/class/rogue/poisons-alliance.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Poisons (Alliance)"] = "Venenos (Aliança)",
	-- {item:7676} Thistle Tea
	["Forever teaches Poisons through this chain, not the trainer; the {item:7676} recipe comes with it."] = "O Forever ensina Venenos por esta cadeia, não pelo instrutor; a receita de {item:7676} vem junto.",

	-- Step 1: Mathias and the Defias
	-- {npc:332} Master Mathias Shaw · {object:2100} Old Town · {npc:7024} Agent Kearnen · {zone:1436} Westfall
	["At 20 {npc:332}, upstairs in the SI:7 building in {object:2100}, sends you to {npc:7024} in {zone:1436}. This chain is how you learn Poisons on Forever, so do not skip it."] = "No nível 20, {npc:332}, no andar de cima do prédio da SI:7, em {object:2100}, manda você para {npc:7024}, em {zone:1436}. Esta cadeia é como se aprende Venenos no Forever, então não pule.",

	-- Step 2: Agent Kearnen
	-- {npc:7053} Klaven Mortwake · {zone:1436} Westfall · {zone:1431} Duskwood · {item:8046} Kearnen's Journal
	["Kearnen hides stealthed against the west side of a big tree with two small trees in front of it, just north of {npc:7053}'s Defias tower in the far east of {zone:1436}, by the {zone:1431} border. Read {item:8046} for the tower's layout if you like."] = "Kearnen se esconde em furtividade encostado no lado oeste de uma árvore grande com duas árvores pequenas na frente, logo ao norte da torre dos Défias de {npc:7053}, no extremo leste de {zone:1436}, na divisa com {zone:1431}. Leia {item:8046} para ver a planta da torre, se quiser.",

	-- Step 3: The Defias Tower Key
	-- {item:7923} Defias Tower Key
	["The {item:7923}"] = "{item:7923}",
	-- {npc:7051} Malformed Defias Drone · {spell:921} Pick Pocket · {spell:2983} Sprint
	-- plural, as words: Defias Drones = {npc:7050} Defias Drone
	["Get the key first. The {npc:7051} (level 23, not elite) starts at the tower entrance and walks a loop around the outside; it is the spiky-haired one trailing yellow sparkles. Stealth up and {spell:921} it from behind: it always has the key. It hits hard: if stealth breaks, {spell:2983} away. Watch for the pair of Defias Drones that also patrol."] = "Pegue a chave primeiro. O {npc:7051} (nível 23, não elite) começa na entrada da torre e dá uma volta por fora; é o de cabelo espetado, deixando um rastro de faíscas amarelas. Entre em furtividade e use {spell:921} nele pelas costas: ele sempre tem a chave. Ele bate forte: se a furtividade quebrar, use {spell:2983} para sair. Cuidado com o par de Parasitas Défias que também patrulha.",
	-- {spell:921} Pick Pocket · {npc:7051} Malformed Defias Drone · {item:7923} Defias Tower Key
	["{spell:921} the {npc:7051} for the {item:7923}"] = "Use {spell:921} no {npc:7051} para pegar a {item:7923}",

	-- Step 4: Klaven's journal
	["Klaven's journal"] = "O diário de Filipe Pinel",
	-- {npc:7053} Klaven Mortwake · {object:123214} Duskwood Chest · {area:97} Alther's Mill · {spell:9810} Touch of Zanzil
	-- plural, as words: Defias Tower Patrollers = {npc:7052} Defias Tower Patroller
	["Sneak up the tower. Defias Tower Patrollers (23) and Sentries (24) guard the floors; an Ambush with a dagger kills them outright if you would rather clear them. {npc:7053}, a level 26 elite, waits on the top floor: Sap him, or bring a friend. The {object:123214} beside his desk needs Lockpicking of about 70-75 (practise on the boxes at {area:97} in Redridge first). A trick: while the Sentries are away, jump from the chair to the lamp to the bookshelf above the chest, step out of stealth and open the chest from there. Opening it poisons you with the {spell:9810}, which stops your stealth for a while and lets the drone see you; that is why the key comes first. Then get out."] = "Suba a torre em silêncio. Patrulheiros da Torre Défias (23) e Sentinelas (24) guardam os andares; uma Emboscada com adaga mata na hora, se você preferir limpar. {npc:7053}, um elite de nível 26, espera no último andar: use Sap nele, ou leve um amigo. {object:123214}, ao lado da mesa dele, pede Arrombamento de uns 70-75 (treine antes nas caixas de {area:97}, em Cristarrubra). Um truque: enquanto as Sentinelas estão longe, pule da cadeira para o lampião e dele para a estante acima do baú, saia da furtividade e abra o baú de lá. Abri-lo envenena você com {spell:9810}, o que interrompe sua furtividade por um tempo e deixa o parasita ver você; é por isso que a chave vem primeiro. Depois saia.",
	-- {item:7908} Klaven Mortwake's Journal · {object:123214} Duskwood Chest
	["{item:7908}: the {object:123214}, top floor"] = "{item:7908}: {object:123214}, último andar",

	-- Step 5: Master Mathias Shaw
	-- {zone:1453} Stormwind · {item:7676} Thistle Tea · {item:6947} Instant Poison · {item:2928} Dust of Decay · {item:3371} Empty Vial · {npc:1325} Jasper Fel · {npc:1326} Sloan McCoy · {object:2100} Old Town
	["Head north through Elwynn to {zone:1453}; Mathias Shaw is upstairs in SI:7. He teaches Poisons and gives you the {item:7676} recipe. Poisons are made, not bought: each batch of {item:6947} takes a {item:2928} and an {item:3371}, which {npc:1325} and {npc:1326} sell in {object:2100} next to SI:7. Buy a stack of each, open Poisons from your spellbook to make them, then use a poison on your weapon."] = "Vá para o norte por Elwynn até {zone:1453}; Mathias Shaw fica no andar de cima da SI:7. Ele ensina Venenos e entrega a receita de {item:7676}. Venenos são fabricados, não comprados: cada lote de {item:6947} leva {item:2928} e {item:3371}, que {npc:1325} e {npc:1326} vendem em {object:2100}, ao lado da SI:7. Compre uma pilha de cada, abra Venenos pelo grimório para fabricar e depois use um veneno na sua arma.",
	-- {npc:332} Master Mathias Shaw
	["{npc:332}: Poisons"] = "{npc:332}: Venenos",

	-- Step 6: Doc Mixilpixil
	-- {quest:2607} The Touch of Zanzil · {npc:7207} Doc Mixilpixil · {npc:1325} Jasper Fel
	["{quest:2607} still sits on you. {npc:7207} works in the cellar of the SI:7 building: the stairs down are under the stairs to the upper floor, behind {npc:1325}. Target him and type /lay (nothing after it) to be examined, then wait. If he does nothing, abandon the quest, take it again and wait until he asks you to lie down."] = "{quest:2607} ainda está com você. {npc:7207} trabalha no porão do prédio da SI:7: a escada para baixo fica embaixo da escada para o andar de cima, atrás de {npc:1325}. Selecione-o como alvo e digite /lay (nada depois) para ser examinado, depois espere. Se ele não fizer nada, abandone a missão, pegue de novo e espere até ele pedir que você se deite.",
	["/lay with the Doc targeted"] = "/lay com o Doutor selecionado",

	-- Step 7: The cure's ingredients
	["The cure's ingredients"] = "Os ingredientes da cura",
	-- {zone:1453} Stormwind · {item:3421} Simple Wildflowers · {npc:1303} Felicia Gump · {object:2096} Trade District · {item:3372} Leaded Vial · {npc:1257} Keldric Boucher · {npc:1325} Jasper Fel · {item:4371} Bronze Tube · {item:8431} Spool of Light Chartreuse Silk Thread · {object:2177} The Finest Thread (no name in this language: may be words) · {item:6452} Anti-Venom · {skill:129} First Aid · {spell:526} Cure Poison · {spell:9810} Touch of Zanzil
	["All four are in {zone:1453}. {item:3421}: Bernard or {npc:1303}'s flower shop by the {object:2096} canal. A {item:3372}: many general goods and alchemy vendors ({npc:1257}, {npc:1325} and others). A {item:4371}: the Auction House in the {object:2096}; the engineering suppliers keep only one and are nearly always sold out, and an engineer can make one. The {item:8431} lies on the floor beside the left end of the counter in {object:2177}, the tailor's shop on the canals; you can only pick it up with this quest. If you skip the cure, an {item:6452} ({skill:129}) or a druid's {spell:526} also clears the {spell:9810}."] = "Todos os quatro estão em {zone:1453}. {item:3421}: Bernardo ou a floricultura de {npc:1303}, perto do canal do {object:2096}. Um {item:3372}: muitos vendedores de bens gerais e de alquimia ({npc:1257}, {npc:1325} e outros). Um {item:4371}: a Casa de Leilões no {object:2096}; os fornecedores de engenharia só mantêm um e quase sempre estão sem estoque, e um engenheiro pode fazer um. O {item:8431} fica no chão ao lado da ponta esquerda do balcão em {object:2177}, a alfaiataria nos canais; só dá para pegá-lo com esta missão. Se você pular a cura, um {item:6452} ({skill:129}) ou o {spell:526} de um druida também remove {spell:9810}.",
	-- {item:4371} Bronze Tube
	["{item:4371}: the Auction House"] = "{item:4371}: a Casa de Leilões",

	-- Step 8: Back to Doc Mixilpixil
	-- {npc:7207} Doc Mixilpixil
	["Back to {npc:7207}"] = "De volta a {npc:7207}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["/lay down"] = "/lay down",
	-- ["At 20 {npc:332} at SI:7 in {object:2100} sends you to {npc:7024} in {zone:1436}."] = "No nível 20, {npc:332} na AVIN, em {object:2100}, manda você até {npc:7024} em {zone:1436}.",
	-- ["Everything is in {zone:1453}: the Gumps sell {item:3421}, the {item:8431} lies in the city, and the nearest vendors sell a {item:3372} and a {item:4371}."] = "Está tudo em {zone:1453}: os Gump vendem {item:3421}, a {item:8431} está na cidade, e os vendedores mais próximos vendem um {item:3372} e um {item:4371}.",
	-- ["Forever teaches {spell:2842} through this chain, not the trainer; the {item:7676} recipe comes with it."] = "O Forever ensina {spell:2842} por esta série, não pelo instrutor; a receita de {item:7676} vem junto.",
	-- ["Ride north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "Cavalgue para o norte pela Floresta de Elwynn até {zone:1453}; Mestre Mathias Shaw está na AVIN, em {object:2100}.",
	-- ["{item:7908}, in the {object:123214}"] = "{item:7908}, no {object:123214}",
	-- ["{npc:7024} watches {npc:7053}'s tower from the hills in the far east of {zone:1436}, by the {zone:1431} border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "{npc:7024} vigia a torre de {npc:7053} das colinas no extremo leste de {zone:1436}, junto à fronteira de {zone:1431}. O {npc:7051} (nível 23) que guarda a torre leva a chave dela; o diário de Filipe está no baú lá no alto.",
	-- ["{npc:7207} works in the cellar of SI:7, the Barracks. Type /lay down beside him to be examined."] = "{npc:7207} trabalha no porão da AVIN, o Quartel. Digite /lay down ao lado dele para ser examinado.",
	-- ["{spell:2842} (Alliance)"] = "{spell:2842} (Aliança)",
}
