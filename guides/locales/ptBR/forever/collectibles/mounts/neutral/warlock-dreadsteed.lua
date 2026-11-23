-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/mounts/neutral/warlock-dreadsteed (forever/collectibles/mounts/neutral/warlock-dreadsteed.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Warlock Dreadsteed"] = "Corcel Medonho de Bruxo",
	["Your epic mount at 60, summoned anywhere: no epic horse to buy and no 1,000g Journeyman Riding needed."] = "Sua montaria épica no nível 60, invocada em qualquer lugar: sem cavalo épico para comprar e sem precisar da Equitação de Profissional de 1.000g.",

	-- Step 1: Mor'zul Bloodbringer (Stormwind)
	-- {npc:5520} Spackle Thornberry · {object:2164} Slaughtered Lamb · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5520}, the demon trainer in the {object:2164}, sends you to {quest:7562} in the {zone:1428}."] = "No nível 60, {npc:5520}, o instrutor de demônios no {object:2164}, manda você para {quest:7562}, em {zone:1428}.",

	-- Step 2: Mor'zul Bloodbringer (Ironforge)
	-- {npc:6382} Jubahl Corpseseeker · {zone:1455} Ironforge · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:6382}, the demon trainer in {zone:1455}, sends you to {quest:7562} in the {zone:1428}."] = "No nível 60, {npc:6382}, o instrutor de demônios em {zone:1455}, manda você para {quest:7562}, em {zone:1428}.",

	-- Step 3: Mor'zul Bloodbringer (Orgrimmar)
	-- {npc:5815} Kurgul · {object:172960} Cleft of Shadow (no name in this language: may be words) · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5815}, the demon trainer in the {object:172960}, sends you to {quest:7562} in the {zone:1428}."] = "No nível 60, {npc:5815}, o instrutor de demônios na Fenda das Sombras, manda você para {quest:7562}, em {zone:1428}.",

	-- Step 4: Mor'zul Bloodbringer (Undercity)
	-- {npc:5753} Martha Strain · {object:36082} Magic Quarter (no name in this language: may be words) · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5753}, the demon trainer in the {object:36082}, sends you to {quest:7562} in the {zone:1428}."] = "No nível 60, {npc:5753}, o instrutor de demônios no Bairro Mágico, manda você para {quest:7562}, em {zone:1428}.",

	-- Step 5: Mor'zul Bloodbringer
	-- {quest:7562} Mor'zul Bloodbringer · {npc:14437} Gorzeeki Wildeyes · {area:255} Altar of Storms · {zone:1428} Burning Steppes · {area:254} Blackrock Mountain · {npc:14522} Ur'dan · {area:2057} Scholomance · {area:2577} Dire Maul
	["{quest:7562} and his goblin {npc:14437} camp on the hill across the road from the {area:255}, in the far north-west of the {zone:1428}, west of {area:254}. The chain is long: about 420 gold in {npc:14437}'s and {npc:14522}'s goods, a pile of crafted materials, the {area:2057} and {area:2577}. Start buying or gathering the materials of the next steps now."] = "{quest:7562} e o goblin dele, {npc:14437}, acampam no morro do outro lado da estrada de {area:255}, no extremo noroeste de {zone:1428}, a oeste de {area:254}. A cadeia é longa: cerca de 420 de ouro em mercadorias de {npc:14437} e {npc:14522}, uma pilha de materiais fabricados, {area:2057} e {area:2577}. Comece a comprar ou juntar os materiais dos próximos passos desde já.",

	-- Step 6: Raging Beast's Blood
	-- {zone:1452} Winterspring · {area:2250} Owl Wing Thicket · {area:2242} Hidden Grove
	["Every owlbeast of {zone:1452} (level 53-58, none elite) drops the blood about one time in three: about ninety kills for thirty. {area:2250}, in the north-east, and the {area:2242}'s surroundings are packed with them, and they respawn in five and a half minutes."] = "Todo urso-coruja de {zone:1452} (nível 53-58, nenhum elite) solta o sangue em cerca de uma vez em três: uns noventa abates para trinta. {area:2250}, no nordeste, e os arredores de {area:2242} são cheios deles, e eles voltam em cinco minutos e meio.",

	-- Step 7: Wildeyes
	-- {npc:14436} Mor'zul Bloodbringer · {item:18591} Case of Blood · {npc:14437} Gorzeeki Wildeyes · {quest:7623} Lord Banehollow · {area:1763} Jaedenar · {npc:14523} Ulathek
	-- plural, as words: Shadowy Potions = {item:18802} Shadowy Potion
	["Back to {npc:14436}: he gives you the {item:18591} for {npc:14437} beside him. Then {npc:14436} asks for the bell, the wheel and the candle, and {npc:14437} sends you to {quest:7623} in {area:1763}: buy three Shadowy Potions from him for that trip (6 gold each: one to walk in, one after {npc:14523}, and a spare in case one runs out) and bring 150 gold for the stardust."] = "De volta a {npc:14436}: ele entrega {item:18591} a você, para {npc:14437} ao lado dele. Depois {npc:14436} pede o sino, a roda e a vela, e {npc:14437} manda você até {quest:7623}, em {area:1763}: compre três Poções Sombrias dele para essa viagem (6 de ouro cada: uma para entrar, uma depois de {npc:14523} e uma reserva, caso uma acabe) e leve 150 de ouro para o pó de estrela.",
	-- {item:18591} Case of Blood
	["he gives you the {item:18591}"] = "ele lhe dá o {item:18591}",
	-- {item:18802} Shadowy Potion · {npc:14437} Gorzeeki Wildeyes
	["{item:18802}, from {npc:14437}"] = "{item:18802}, de {npc:14437}",

	-- Step 8: The ritual pieces
	["The ritual pieces"] = "As peças do ritual",
	-- {npc:14437} Gorzeeki Wildeyes · {skill:171} Alchemy · {item:8925} Crystal Vial · {skill:333} Enchanting · {item:11370} Dark Iron Ore · {skill:186} Mining · {zone:1428} Burning Steppes · {area:1584} Blackrock Depths · {skill:393} Skinning · {npc:7043} Flamescale Wyrmkin
	-- plural, as words: Ghost Mushrooms = {item:8845} Ghost Mushroom · Large Brilliant Shards = {item:14344} Large Brilliant Shard · Dark Iron Deposits = {object:165658} Dark Iron Deposit · Black Dragonscales = {item:15416} Black Dragonscale
	["{npc:14437} wants 10 Elixirs of Shadow Power ({skill:171}: 3 Ghost Mushrooms and a {item:8925} each), 6 Large Brilliant Shards ({skill:333}: disenchant level 51+ blue items), 25 {item:11370} ({skill:186} 230: the Dark Iron Deposits of the {zone:1428} and {area:1584}) and 35 Black Dragonscales ({skill:393}: the black dragonkin of the {zone:1428}, a few percent a kill, best from the {npc:7043}). Make or gather what your professions allow and buy the rest at the Auction House; it can take a while to find 35 scales."] = "{npc:14437} quer 10 Elixires de Poder das Sombras ({skill:171}: 3 Cogumelos-fantasma e {item:8925} cada), 6 Estilhaços Brilhantes Grandes ({skill:333}: desencante itens azuis de nível 51+), 25 {item:11370} ({skill:186} 230: os Depósitos de Ferro Negro de {zone:1428} e {area:1584}) e 35 Escamas de Dragão Negro ({skill:393}: os dragonários negros de {zone:1428}, uns poucos por cento por morte, melhor em {npc:7043}). Fabrique ou junte o que suas profissões permitirem e compre o resto na Casa de Leilões; pode levar um tempo achar 35 escamas.",
	-- {item:9264} Elixir of Shadow Power
	["{item:9264}: the Auction House"] = "{item:9264}: a Casa de Leilões",
	-- {item:14344} Large Brilliant Shard
	["{item:14344}: the Auction House"] = "{item:14344}: a Casa de Leilões",

	-- Step 9: Arcanite
	-- {npc:14437} Gorzeeki Wildeyes · {item:18629} Black Lodestone · {item:12363} Arcane Crystal · {item:12359} Thorium Bar
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["Hand the three pieces to {npc:14437}. He then wants 3 Arcanite Bars for the {item:18629}: alchemists transmute them (an {item:12363} and a {item:12359} each, on a long cooldown); everyone else buys them."] = "Entregue as três peças a {npc:14437}. Ele então quer 3 Barras de Arcanita para {item:18629}: alquimistas transmutam (um {item:12363} e uma {item:12359} cada, com recarga longa); todos os outros compram.",
	-- {item:12360} Arcanite Bar
	["{item:12360}: the Auction House"] = "{item:12360}: a Casa de Leilões",

	-- Step 10: Lord Banehollow
	-- {area:1763} Jaedenar · {area:1997} Bloodvenom Post · {zone:1448} Felwood · {area:1770} Shadow Hold · {item:18802} Shadowy Potion · {spell:23179} Taint of Shadow · {quest:7623} Lord Banehollow
	["{area:1763} lies just south of {area:1997} in western {zone:1448}, west of the road; of its two caves, {area:1770} is the northern one, further up the hill. Drink a {item:18802} at its mouth: for 20 minutes the Shadow Council there treat you as one of their own ({spell:23179}). The oozes in the red pool and the succubus Rakaiah beyond them still attack: hug the wall past them. Go down past the second, red pool, up the ramp and across two bridges to {quest:7623}, a great winged dreadlord at the back. He talks to you only while the potion lasts."] = "{area:1763} fica logo ao sul de {area:1997}, no oeste de {zone:1448}, a oeste da estrada; das duas cavernas, {area:1770} é a do norte, mais acima no morro. Beba {item:18802} na boca dela: por 20 minutos o Conselho das Sombras de lá trata você como um dos seus ({spell:23179}). As gosmas na poça vermelha e a súcubo Rakaiah, depois delas, ainda atacam: cole na parede ao passar. Desça passando a segunda poça, a vermelha, suba a rampa e atravesse duas pontes até {quest:7623}, um grande senhor do terror alado no fundo. Ele só fala com você enquanto a poção durar.",

	-- Step 11: Ulathek the Traitor
	-- {npc:14523} Ulathek · {spell:23179} Taint of Shadow · {npc:9516} Lord Banehollow
	["{npc:14523} waits in a small side room up a bridge you passed on the way down. Speak to him and he and four guards attack (all level 57, none elite): let your voidwalker hold the guards and burn {npc:14523}, sacrificing it if you must. Or click off your {spell:23179} aura to start the fight, kill {npc:14523}, then drink another potion: the guards stop at once. Take his heart back to {npc:9516} with a potion active."] = "{npc:14523} espera numa pequena sala lateral, numa ponte pela qual você passou na descida. Fale com ele e ele e quatro guardas atacam (todos de nível 57, nenhum elite): deixe seu emissário do caos segurar os guardas e queime {npc:14523}, sacrificando o emissário se precisar. Ou clique para tirar sua aura de {spell:23179} para começar a luta, mate {npc:14523} e beba outra poção: os guardas param na hora. Leve o coração dele a {npc:9516} com uma poção ativa.",

	-- Step 12: Xorothian Stardust
	-- {npc:14522} Ur'dan · {quest:7623} Lord Banehollow · {item:18687} Xorothian Stardust · {item:18802} Shadowy Potion
	["{npc:14522}, beside {quest:7623}, sells the {item:18687} for 150 gold. He deals with you only while a {item:18802} is active."] = "{npc:14522}, ao lado de {quest:7623}, vende {item:18687} por 150 de ouro. Ele só negocia com você enquanto {item:18802} estiver ativa.",
	-- {item:18687} Xorothian Stardust · {npc:14522} Ur'dan
	["{item:18687}, from {npc:14522}"] = "{item:18687}, de {npc:14522}",

	-- Step 13: Imp Delivery
	-- {npc:14437} Gorzeeki Wildeyes · {quest:7630} Arcanite · {item:18688} Imp in a Jar · {area:2057} Scholomance
	["Back to {npc:14437} with the stardust; with the {quest:7630} also done he gives you the {item:18688} for the {area:2057}. Put a group of five together now: a party, not a raid group."] = "De volta a {npc:14437} com o pó de estrela; com {quest:7630} também concluída, ele entrega {item:18688} a você, para {area:2057}. Forme agora um grupo de cinco: um grupo, não uma raide.",
	-- {quest:7625} Xorothian Stardust · {npc:14522} Ur'dan
	["{quest:7625}, from {npc:14522}"] = "{quest:7625}, de {npc:14522}",

	-- Step 14: The Scholomance
	-- {area:2057} Scholomance
	["The {area:2057}"] = "{area:2057}",
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:13704} Skeleton Key · {npc:10508} Ras Frostwhisper · {item:18688} Imp in a Jar · {npc:14500} J'eevee
	["The {area:2057} (level 58-60, a group of five) lies under {area:2298}, the island town in the south-east of the {zone:1422}: someone needs the {item:13704} or a rogue to open the door. Fight down to {npc:10508}'s room and use the {item:18688} at the alchemy lab tables to the right: {npc:14500} makes the parchment. You need not kill Ras, but it only counts at this lab and only in a party."] = "{area:2057} (nível 58-60, grupo de cinco) fica embaixo de {area:2298}, a cidade na ilha no sudeste de {zone:1422}: alguém precisa de {item:13704} ou de um ladino para abrir a porta. Lute até a sala de {npc:10508} e use {item:18688} nas mesas do laboratório de alquimia à direita: {npc:14500} faz o pergaminho. Você não precisa matar Ras, mas só conta neste laboratório e só em grupo.",
	-- {item:18688} Imp in a Jar
	["Use the {item:18688} at the alchemy lab inside"] = "Use {item:18688} no laboratório de alquimia lá dentro",

	-- Step 15: Dreadsteed of Xoroth
	-- {npc:14437} Gorzeeki Wildeyes · {npc:14436} Mor'zul Bloodbringer · {item:18663} J'eevee's Jar · {item:18629} Black Lodestone · {item:18670} Xorothian Glyphs
	-- plural, as words: Soul Shards = {item:6265} Soul Shard
	["Back to {npc:14437}, then {npc:14436} hands you his instructions. Buy {item:18663} (150 gold), the {item:18629} (50) and the {item:18670} (50) from {npc:14437}; a warlock friend who owns them can bring theirs instead. Every other warlock who will recharge the nodes needs a Lodestone of their own. Carry 15 or more Soul Shards."] = "De volta a {npc:14437}, e depois {npc:14436} entrega as instruções dele a você. Compre {item:18663} (150 de ouro), {item:18629} (50) e {item:18670} (50) de {npc:14437}; um amigo bruxo que já os tenha pode levar os dele no lugar. Todo outro bruxo que for recarregar os nós precisa de uma Magnetita própria. Leve 15 ou mais Estilhaços de Alma.",
	-- {item:18663} J'eevee's Jar
	["{item:18663}, 150 gold"] = "{item:18663}, 150 de ouro",
	-- {item:18629} Black Lodestone
	["{item:18629}, 50 gold"] = "{item:18629}, 50 de ouro",
	-- {item:18670} Xorothian Glyphs
	["{item:18670}, 50 gold"] = "{item:18670}, 50 de ouro",

	-- Step 16: Into Dire Maul West
	["Into Dire Maul West"] = "Em Gládio Cruel Oeste",
	-- {area:2577} Dire Maul · {zone:1444} Feralas · {item:18249} Crescent Key · {npc:11496} Immol'thar
	["{area:2577} stands in the ruins of central {zone:1444}: from the gate at the foot of the ruins, walk up through the outer courtyards to the west wing's door at the north end. That door and an inner door need the {item:18249} (it drops from Pusillin in Dire Maul East) or a rogue with 300 Lockpicking. Bring a party of five. Lower {npc:11496}'s shield by killing the guardians of the five pylons (two stand in his own room), then kill {npc:11496}: his dais is the summoning circle. Rest and rebuff before you start."] = "{area:2577} fica nas ruínas do centro de {zone:1444}: a partir do portão ao pé das ruínas, suba pelos pátios externos até a porta da ala oeste, no extremo norte. Essa porta e uma porta interna precisam de {item:18249} (cai de Pusillin, em Gládio Cruel Leste) ou de um ladino com 300 de Arrombamento. Leve um grupo de cinco. Baixe o escudo de {npc:11496} matando os guardiões dos cinco pilares (dois ficam na sala dele) e depois mate {npc:11496}: o estrado dele é o círculo de invocação. Descanse e reforce suas bênçãos antes de começar.",
	-- {npc:11496} Immol'thar
	["{npc:11496}, inside the west wing"] = "{npc:11496}, dentro da ala oeste",

	-- Step 17: The ritual
	["The ritual"] = "O ritual",
	-- {item:18663} J'eevee's Jar · {npc:14500} J'eevee · {item:6265} Soul Shard · {item:18670} Xorothian Glyphs · {npc:14502} Xorothian Dreadsteed · {npc:14506} Lord Hel'nurath · {npc:14504} Dreadsteed Spirit
	-- plural, as words: Dread Guards = {npc:14483} Dread Guard
	["Stand on the dais and use {item:18663}: {npc:14500} sets out the Bell, the Wheel and the Candle. The Bell heals warlocks, the Wheel shields the party, the Candle burns the imps: ignore the imps and kill the Dread Guards (elite felguards, about ten, sometimes two at once); Banish or Enslave helps. Give one player each node to watch: when one sags, tilts and sounds, a warlock with a Lodestone recharges it, a 3-second cast that any hit breaks (a {item:6265} each), so keep attackers off them. If all three fail, the ritual ends and you start again; while one stands it survives even a wipe. After about six minutes nine symbols glow and a red vortex closes the circle: walk out and the remaining demons vanish at its edge. Rest, then use the {item:18670}. Kill the {npc:14502} (level 62, elite); at half health {npc:14506} joins, a hard hitter who knocks you back. Speak to the {npc:14504}: every warlock in the party who is on this quest can bind it."] = "Fique no estrado e use {item:18663}: {npc:14500} coloca o Sino, a Roda e a Vela. O Sino cura os bruxos, a Roda protege o grupo, a Vela queima os diabretes: ignore os diabretes e mate os Dread Guards (guardas vis elite, uns dez, às vezes dois de uma vez); Banir ou Escravizar ajuda. Dê a cada jogador um nó para vigiar: quando um cede, se inclina e soa, um bruxo com Magnetita recarrega, uma conjuração de 3 segundos que qualquer golpe quebra (um {item:6265} cada), então mantenha os atacantes longe deles. Se os três falharem, o ritual termina e você recomeça; enquanto um estiver de pé, ele sobrevive até a um wipe. Depois de uns seis minutos, nove símbolos brilham e um vórtice vermelho fecha o círculo: saia andando e os demônios restantes somem na borda dele. Descanse, depois use {item:18670}. Mate {npc:14502} (elite de nível 62); com metade da vida, {npc:14506} se junta, um golpeador forte que repele você. Fale com {npc:14504}: todo bruxo do grupo que esteja nesta missão pode prendê-lo.",
	-- {item:18663} J'eevee's Jar · {npc:11496} Immol'thar
	["{item:18663}, on {npc:11496}'s dais"] = "{item:18663}, no estrado de {npc:11496}",
	-- {item:18670} Xorothian Glyphs
	["{item:18670}, once the circle is complete"] = "{item:18670}, quando o círculo estiver completo",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 60 {npc:5520} in the {object:2164} sends you to {quest:7562} in the {zone:1428}."] = "No nível 60, {npc:5520} no {object:2164} manda você a {quest:7562} nas {zone:1428}.",
	-- ["At 60 {npc:5753} in the {object:36082} sends you to {quest:7562} in the {zone:1428}."] = "No nível 60, {npc:5753} no {object:36082} manda você a {quest:7562} nas {zone:1428}.",
	-- ["At 60 {npc:5815} in the {object:172960} sends you to {quest:7562} in the {zone:1428}."] = "No nível 60, {npc:5815} na {object:172960} manda você a {quest:7562} nas {zone:1428}.",
	-- ["At 60 {npc:6382} in {zone:1455} sends you to {quest:7562} in the {zone:1428}."] = "No nível 60, {npc:6382} em {zone:1455} manda você a {quest:7562} nas {zone:1428}.",
	-- ["Back to {npc:14436}, then hand his {item:18591} to {npc:14437} beside him. {npc:14436} then asks for three ritual pieces and {npc:14437} sends you to {zone:1448}: buy two Shadowy Potions from {npc:14437} for that trip."] = "De volta a {npc:14436}, depois entregue o {item:18591} dele a {npc:14437}, ao lado. {npc:14436} então pede três peças do ritual e {npc:14437} manda você a {zone:1448}: compre duas Poções Sombrias de {npc:14437} para essa viagem.",
	-- ["Back to {npc:14437} with the stardust. He gives you the {item:18688} for the {area:2057}."] = "De volta a {npc:14437} com a poeira estelar. Ele lhe dá o {item:18688} para {area:2057}.",
	-- ["Back to {npc:14437}, then {npc:14436} hands you his instructions for the ritual. Buy {item:18663}, the {item:18629} and the {item:18670} from {npc:14437}, and carry ten or more Soul Shards."] = "De volta a {npc:14437}, depois {npc:14436} lhe entrega as instruções do ritual. Compre o {item:18663}, a {item:18629} e os {item:18670} de {npc:14437} e leve dez ou mais Estilhaços de Alma.",
	-- ["Hand the three pieces to {npc:14437}. He then wants 3 Arcanite Bars: alchemists transmute them, everyone else buys them at the Auction House."] = "Entregue as três peças a {npc:14437}. Ele então quer 3 Barras de Arcanita: alquimistas as transmutam, os demais as compram na Casa de Leilões.",
	-- ["The owlbeasts of {zone:1452} drop the blood, about one in three: the Ragged and Raging Owlbeasts west of and around {area:2255}, the Crazed, Moontouched and {spell:417141} ones in the east. While you hunt, start on the materials of the next step: the Auction House has them all."] = "Os corujursos de {zone:1452} deixam cair o sangue, cerca de um em três: as Ferujas Maltrapilhas e Furiosas a oeste e em volta de {area:2255}, as Enlouquecidas, Lunamarca e {spell:417141} no leste. Enquanto caça, comece os materiais da próxima etapa: a Casa de Leilões tem todos.",
	-- ["The ritual in {area:2577}"] = "O ritual em {area:2577}",
	-- ["The {area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}: you need its key or a rogue to open the door, and Rattlegore's {item:13873} to go deeper. Use the {item:18688} at the alchemy lab in {npc:10508}'s room; {npc:14500} makes the parchment. Bring a group."] = "{area:2057} fica embaixo de {area:2298}, a cidade na ilha do sudeste das {zone:1422}: você precisa da chave ou de um ladino para abrir a porta, e da {item:13873} de Ossorrange para ir mais fundo. Use o {item:18688} no laboratório de alquimia da sala de {npc:10508}; {npc:14500} faz o pergaminho. Leve um grupo.",
	-- ["Use the {item:18688} at the alchemy lab"] = "Use o {item:18688} no laboratório de alquimia",
	-- ["Your epic mount at 60: summoned anywhere, with no gold spent on an epic horse."] = "Sua montaria épica no nível 60: evocada em qualquer lugar, sem gastar ouro num cavalo épico.",
	-- ["{area:1763} is in western {zone:1448}. Drink a {item:18802} before you go in: the Shadow Council cultists turn friendly for a while, the demons do not. {quest:7623} waits deep inside {area:1770}, the cave above {area:1763}, across a bridge in the great root chamber."] = "{area:1763} fica no oeste de {zone:1448}. Beba uma {item:18802} antes de entrar: os sectários do Concílio das Sombras ficam amistosos por um tempo, os demônios não. {quest:7623} espera no fundo do {area:1770}, a caverna acima de {area:1763}, depois de uma ponte na grande câmara das raízes.",
	-- ["{area:2577} stands in the ruins of central {zone:1444}; the ritual circle is in its west wing, past {npc:11496}, and the door needs the {item:18249} or a rogue. Use {item:18663} to start; when the bell, the wheel or the candle fades, click it with the {item:18629} (a {item:6265} each). When the demons stop coming, use the {item:18670}, defeat the {npc:14502} and its dreadlord master, and speak to the {npc:14504}. Bring a group."] = "{area:2577} fica nas ruínas do centro de {zone:1444}; o círculo do ritual fica na ala oeste, depois de {npc:11496}, e a porta requer a {item:18249} ou um ladino. Use o {item:18663} para começar; quando o sino, a roda ou a vela enfraquecer, clique nele com a {item:18629} (um {item:6265} cada). Quando os demônios pararem de vir, use os {item:18670}, derrote o {npc:14502} e seu mestre senhor do medo e fale com o {npc:14504}. Leve um grupo.",
	-- ["{npc:14437} wants 10 Elixirs of Shadow Power ({skill:171}), 6 Large Brilliant Shards ({skill:333}), 25 {item:11370} ({skill:186}, in {area:1584} and the {zone:1427}) and 35 Black Dragonscales ({skill:393}, black dragonkin of the {zone:1428}). Make or gather what your professions allow; buy the rest at the Auction House."] = "{npc:14437} quer 10 Elixires de Poder Sombrio ({skill:171}), 6 Estilhaços Brilhantes Grandes ({skill:333}), 25 {item:11370} ({skill:186}, em {area:1584} e em {zone:1427}) e 35 Escamas de Dragão Negro ({skill:393}, dragonídeos negros de {zone:1428}). Faça ou colete o que suas profissões permitirem; compre o resto na Casa de Leilões.",
	-- ["{npc:14504}: it binds itself to you"] = "{npc:14504}: ele se vincula a você",
	-- ["{npc:14522}, beside {quest:7623}, sells the {item:18687}; he only deals with you while a {item:18802} is active. Bring plenty of gold."] = "{npc:14522}, ao lado de {quest:7623}, vende a {item:18687}; ele só negocia com você enquanto uma {item:18802} estiver ativa. Leve bastante ouro.",
	-- ["{npc:14523} waits in a side chamber by a bridge on the way back up. Speak to him and he and his four guards attack; none are elite. Take his heart back to {npc:9516}, drinking another potion if the first wore off."] = "{npc:14523} espera numa câmara lateral junto a uma ponte no caminho de volta. Fale com ele e ele e seus quatro guardas atacam; nenhum é elite. Leve o coração dele de volta a {npc:9516}, bebendo outra poção se a primeira tiver passado.",
	-- ["{quest:7562} and his goblin {npc:14437} camp at the {area:255}, in the north-west of the {zone:1428}, west of {area:254}. The chain is long, costs gold at {npc:14437}'s and ends in two dungeons."] = "{quest:7562} e o goblin dele, {npc:14437}, acampam no {area:255}, no noroeste das {zone:1428}, a oeste da {area:254}. A série é longa, custa ouro com {npc:14437} e termina em duas masmorras.",
}
