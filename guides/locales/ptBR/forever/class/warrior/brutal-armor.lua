-- Portuguese (Brazil) (ptBR): the guide forever/class/warrior/brutal-armor (forever/class/warrior/brutal-armor.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Starts now at 20 at your trainer; four armor pieces at 30 (hauberk, helm, gauntlets, legguards), a shield on the way."] = "Começa agora no nível 20, com seu instrutor; quatro peças de armadura no 30 (cota, elmo, manoplas, perneiras), um escudo no caminho.",

	-- Step 1: Speak with Ruga (Orgrimmar)
	-- {npc:3354} Sorek · {object:172958} Valley of Honor (no name in this language: may be words) · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:3354} in the {object:172958} sends you to {npc:6394} in {area:378}."] = "No nível 20, {npc:3354} no {object:172958} manda você a {npc:6394} no {area:378}.",

	-- Step 2: Speak with Ruga (Thunder Bluff)
	-- {npc:3041} Torm Ragetotem · {zone:1456} Thunder Bluff · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:3041}, the warrior trainer of {zone:1456}, sends you to {npc:6394} in {area:378}."] = "No nível 20, {npc:3041}, o instrutor de guerreiro de {zone:1456}, manda você a {npc:6394} no {area:378}.",

	-- Step 3: Speak with Ruga (Undercity)
	-- {npc:4595} Baltus Fowler · {zone:1458} Undercity · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:4595}, a warrior trainer of the {zone:1458}, sends you to {npc:6394} in {area:378}."] = "No nível 20, {npc:4595}, um instrutor de guerreiro de {zone:1458}, manda você a {npc:6394} no {area:378}.",

	-- Step 4: Ruga Ragetotem
	-- {area:378} Camp Taurajo · {npc:6394} Ruga Ragetotem
	["Fly to {area:378}. {npc:6394} stands in the hut with the leatherworking and tailoring trainers."] = "Voe para {area:378}. {npc:6394} fica na cabana com os instrutores de couraria e alfaiataria.",

	-- Step 5: Trial at the Field of Giants
	-- {item:7119} Twitching Antenna · {area:390} Field of Giants · {area:378} Camp Taurajo · {item:7120} Ruga's Bulwark
	-- plural, as words: Silithid Mounds = {object:3685} Silithid Mound
	["You have 30 minutes, and each {item:7119} rots 15 minutes after you loot it, so take the quest only when ready (logging out does not stop the clock). The Silithid Mounds dot the {area:390} south of {area:378}; every silithid drops an antenna. Creepers (level 20-21) and Grubs are the easiest: Swarmers (21-22) call small swarms and Creepers lay eggs that hatch adds. The eastern part of the field has plenty of Creepers. {item:7120}, a shield, is the reward."] = "Você tem 30 minutos, e cada {item:7119} apodrece 15 minutos depois de saqueada, então pegue a missão só quando estiver pronto (deslogar não para o relógio). Os Montes de Terra Silitídeos se espalham por {area:390}, ao sul de {area:378}; todo silitídeo solta uma antena. Os Rastejantes (nível 20-21) e as Larvas são os mais fáceis: os Enxameadores (21-22) chamam pequenos enxames e os Rastejantes botam ovos que chocam reforços. A parte leste do campo tem Rastejantes de sobra. {item:7120}, um escudo, é a recompensa.",
	-- {item:7119} Twitching Antenna
	["{item:7119}, from the silithid"] = "{item:7119}, do silitídeo",

	-- Step 6: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:1699} Thorn Hill · {quest:1838} Brutal Armor · {item:7587} Thun'grim's Instructions
	["{npc:5878}'s hut sits on top of {area:1699}, east of the Crossroads: climb the broad ridge on the north or east side. {quest:1838} is a level 30 quest; take it now and gather on the way. {item:7587} list where each material comes from."] = "A cabana de {npc:5878} fica no alto de {area:1699}, a leste da Encruzilhada: suba pela crista larga do lado norte ou leste. {quest:1838} é uma missão de nível 30; pegue-a agora e vá coletando pelo caminho. {item:7587} indicam de onde vem cada material.",

	-- Step 7: Roogug in Razorfen Kraul
	-- {area:1717} Razorfen Kraul
	["Roogug in {area:1717}"] = "Rugug em {area:1717}",
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {spell:403} Lightning Bolt
	["Roogug is an elite quilboar (level 28) inside {area:1717}, the dungeon at the south end of the {zone:1413}; a five-player dungeon: needs a group of five, his guards come with him. Inside take the left path at the first fork, cross the vine bridge over the pig pens, go past the room with the big cauldron: he waits in the room on the right. He casts {spell:403} and calls Earth Rumblers. The vial always drops."] = "Rugug é um quilboar elite (nível 28) dentro de {area:1717}, a masmorra no extremo sul de {zone:1413}; uma masmorra para cinco jogadores: precisa de um grupo de cinco, os guardas dele vêm junto. Lá dentro, pegue o caminho da esquerda na primeira bifurcação, atravesse a ponte de cipós sobre os chiqueiros e passe pela sala do caldeirão grande: ele espera na sala da direita. Ele lança {spell:403} e chama Estrondores da Terra. O frasco sempre cai.",
	-- {item:6841} Vial of Phlogiston
	["{item:6841}, from Roogug"] = "{item:6841}, de Rugug",

	-- Step 8: Windshear Mine
	-- {area:2160} Windshear Mine · {area:461} Windshear Crag · {area:460} Sun Rock Retreat · {spell:116} Frostbolt
	-- plural, as words: Smoky Iron Ingots = {item:7126} Smoky Iron Ingot
	["You need 15 Smoky Iron Ingots. The {area:2160} lies at the east end of {area:461}, east of {area:460}; every Windshear kobold (level 19-23) drops an ingot four kills in five. Stonecutters, Geomancers and Overlords run for help when low; Geomancers cast {spell:116}."] = "Você precisa de 15 Lingotes Fumegantes de Ferro. {area:2160} fica no extremo leste de {area:461}, a leste de {area:460}; todo kobold Cortavento (nível 19-23) solta um lingote em quatro de cada cinco mortes. Os Cortapedras, Geomantes e Senhores correm atrás de ajuda quando com pouca vida; os Geomantes lançam {spell:116}.",
	-- {item:7126} Smoky Iron Ingot
	["{item:7126}, from the Windshear kobolds"] = "{item:7126}, dos kobolds Cortavento",

	-- Step 9: Hillsbrad Miners
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["Hillsbrad Miners"] = "Mineradores de Eira dos Montes",
	-- {item:7127} Powdered Azurite · {area:271} Southshore · {spell:71} Defensive Stance · {area:272} Tarren Mill
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["You need 10 {item:7127}. The Hillsbrad Miners (level 26-27) work the mine in the hills west of {area:271} and drop the azurite four kills in five; they fight in {spell:71}, sunder your armor and run for help at 30% health. Fly to {area:272} and head south-west."] = "Você precisa de 10 {item:7127}. Os Mineradores de Eira dos Montes (nível 26-27) trabalham na mina nas colinas a oeste de {area:271} e soltam a azurita em quatro de cada cinco mortes; eles lutam em {spell:71}, destroem sua armadura e correm atrás de ajuda com 30% de vida. Voe para {area:272} e siga para sudoeste.",
	-- {item:7127} Powdered Azurite
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["{item:7127}, from the Hillsbrad Miners"] = "{item:7127}, dos Mineradores de Eira dos Montes",

	-- Step 10: Iron Bars
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Iron Bars"] = "Barras de Ferro",
	-- {item:2772} Iron Ore · {spell:3307} Smelt Iron · {skill:186} Mining · {zone:1454} Orgrimmar
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["You need 10 Iron Bars. Miners smelt them from {item:2772} (one ore a bar, {spell:3307} at {skill:186} 125); everyone else buys them at the auction house in {zone:1454}."] = "Você precisa de 10 Barras de Ferro. Mineiros fundem a partir de {item:2772} (um minério por barra, {spell:3307} em {skill:186} 125); todos os outros compram na Casa de Leilões de {zone:1454}.",
	-- {npc:8673} Auctioneer Thathung
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Iron Bars: {npc:8673}"] = "Barras de Ferro: {npc:8673}",

	-- Step 11: Brutal Hauberk
	-- {npc:5878} Thun'grim Firegaze · {area:1699} Thorn Hill · {quest:1848} Brutal Hauberk
	["Back to {npc:5878} on {area:1699}. {quest:1848} is the first piece; he then sends you to three crafters, one per piece: take all three."] = "De volta a {npc:5878}, em {area:1699}. {quest:1848} é a primeira peça; depois ele manda você para três artesãos, um por peça: pegue as três.",

	-- Step 12: Ula'elek
	-- {npc:6408} Ula'elek · {area:367} Sen'jin Village · {zone:1411} Durotar
	["{npc:6408} is in {area:367} on the {zone:1411} coast. He wants 7 Uncloven Satyr Hooves."] = "{npc:6408} fica em {area:367}, na costa de {zone:1411}. Ele quer 7 Cascos Não Fendidos de Sátiro.",

	-- Step 13: Satyr Hooves
	-- {area:430} Satyrnaar · {area:431} Splintertree Post · {area:429} Xavian · {spell:6925} Gift of the Xavian
	-- plural, as words: Fireballs = {spell:133} Fireball
	["The satyrs of {area:430}, north-east of {area:431} ({area:429}, level 28-30), and the Felmusk satyrs north-west of the post (25-27) drop a hoof four kills in five. A {area:429} satyr at 15% health may cast {spell:6925} and heal to full: finish it fast or stun it. Hellcallers throw Fireballs from 40 yards; Felmusk satyrs reek in melee and run for help at 15%."] = "Os sátiros de {area:430}, a nordeste de {area:431} ({area:429}, nível 28-30), e os sátiros Felmusk a noroeste do posto (25-27) soltam um casco em quatro de cada cinco mortes. Um sátiro de {area:429} com 15% de vida pode lançar {spell:6925} e se curar por completo: acabe com ele rápido ou atordoe. Os Infernarautos jogam Bolas de Fogo a 40 metros; os sátiros Felmusk fedem em combate corpo a corpo e correm atrás de ajuda com 15%.",

	-- Step 15: Orm Stonehoof
	-- {npc:6410} Orm Stonehoof · {zone:1456} Thunder Bluff
	["{npc:6410} works on {zone:1456}'s lowest level, close to the blacksmith."] = "{npc:6410} trabalha no andar mais baixo de {zone:1456}, perto do ferreiro.",

	-- Step 16: Chimaeric Horn
	-- {npc:6167} Chimaera Matriarch · {area:465} Charred Vale · {zone:1443} Desolace · {item:6840} Galvanized Horn · {spell:3396} Corrosive Poison
	["The {npc:6167} (level 28, not elite, larger than the young ones around her) roams the south edge of the {area:465} in south-west Stonetalon, near the road to {zone:1443}. She is the only one: she returns 5 minutes after dying and drops the {item:6840} four kills in five. She spits {spell:3396} from 30 yards."] = "{npc:6167} (nível 28, não elite, maior que as jovens em volta dela) ronda a borda sul de {area:465}, no sudoeste das Torres de Pedra, perto da estrada para {zone:1443}. Ela é a única: volta 5 minutos depois de morrer e solta {item:6840} em quatro de cada cinco mortes. Ela cospe {spell:3396} a 30 metros.",
	-- {item:6840} Galvanized Horn · {npc:6167} Chimaera Matriarch
	["{item:6840}, from the {npc:6167}"] = "{item:6840}, de {npc:6167}",

	-- Step 18: Velora Nitely
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {npc:6411} Velora Nitely · {zone:1458} Undercity · {object:36078} Trade Quarter (no name in this language: may be words)
	-- plural, as words: Sturdy Dragonmaw Shinbones = {item:7134} Sturdy Dragonmaw Shinbone
	["Take the zeppelin from {zone:1454} to {zone:1420}; {npc:6411} works in the {zone:1458}'s {object:36078}. She wants 8 Sturdy Dragonmaw Shinbones."] = "Pegue o zepelim de {zone:1454} até {zone:1420}; {npc:6411} trabalha no {object:36078} da {zone:1458}. Ela quer 8 Tíbias Firmes de Presa do Dragão.",

	-- Step 19: Dragonmaw Shinbones
	-- {zone:1437} Wetlands · {area:321} Hammerfall · {area:881} Thandol Span · {area:150} Menethil Harbor · {item:7131} Dragonmaw Shinbone · {spell:686} Shadow Bolt
	["The Dragonmaw orcs (level 26-30) camp in the middle of the {zone:1437}; from {area:321} in Arathi head south over the {area:881} ({area:150} is Alliance). Every Raider, Swamprunner, Centurion, Shadowwarder and Bonewarder drops a {item:7131}: right-click it to test it, and about one in four comes out sturdy, the rest break, so expect 30 or more kills for 8. You can test while moving or fighting. The orcs run for help at 15%; Raiders net you, Centurions shield-bash, Shadowwarders cast {spell:686}, Bonewarders raise skeletons."] = "Os orcs Presa do Dragão (nível 26-30) acampam no meio de {zone:1437}; a partir de {area:321}, em Arathi, siga para o sul pela {area:881} ({area:150} é da Aliança). Todo Saqueador, Corredor do Pântano, Centurião, Guarda-sombras e Guarda-ossos solta {item:7131}: clique com o botão direito para testar, e cerca de um em quatro sai firme, o resto quebra, então conte com 30 ou mais mortes para conseguir 8. Dá para testar andando ou lutando. Os orcs correm atrás de ajuda com 15%; os Saqueadores prendem você em rede, os Centuriões dão pancada de escudo, os Guarda-sombras lançam {spell:686}, os Guarda-ossos levantam esqueletos.",
	["from the Dragonmaw orcs: right-click to test it"] = "dos orcs Presa do Dragão: clique com o botão direito para testar",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:5878} beside the road east of the {area:380}. {quest:1848} is the first piece; he then sends you to three crafters for the rest."] = "De volta a {npc:5878}, junto à estrada a leste da {area:380}. {quest:1848} é a primeira peça; depois ele manda você a três artesãos para o resto.",
	-- ["Fly to {area:378}. South of the camp the Silithid Mounds dot the {area:390}: the silithid there carry the Twitching Antennae."] = "Voe até o {area:378}. Ao sul do acampamento, os Montes de Terra Silitídeos salpicam o {area:390}: os silitídeos de lá levam as Antenas Agitadas.",
	-- ["Four armor pieces at 30 (hauberk, helm, gauntlets, legguards) and a shield on the way."] = "Quatro peças de armadura no nível 30 (camisão, elmo, manoplas, perneiras) e um escudo no caminho.",
	-- ["Miners smelt Iron Bars from {item:2772} ({skill:186} 125); everyone else buys them at the auction house in {zone:1454}."] = "Mineradores fundem Barras de Ferro a partir de {item:2772} ({skill:186} 125); os demais as compram na casa de leilões de {zone:1454}.",
	-- ["Roogug is an elite quilboar inside {area:1717}, the dungeon at the south end of the {zone:1413}; he drops the {item:6841}. {area:1717} is a dungeon: grouping up is advised."] = "Rugug é um javaligno de elite dentro de {area:1717}, a masmorra no extremo sul de {zone:1413}; ele deixa cair o {item:6841}. {area:1717} é uma masmorra: é recomendado formar grupo.",
	-- ["Smoky Iron Ingots from the Windshear kobolds"] = "Lingotes Fumegantes de Ferro dos kobolds de Rochedo Cortavento",
	-- ["Sturdy Dragonmaw Shinbones"] = "Tíbias Firmes de Presa do Dragão",
	-- ["Take the zeppelin from {zone:1454} to {zone:1420}; the {zone:1458} lies below the {area:153}."] = "Pegue o zepelim de {zone:1454} até {zone:1420}; {zone:1458} fica embaixo das {area:153}.",
	-- ["The Dragonmaw orcs camp in the middle of the {zone:1437}, south of the road; Raiders, Swamprunners, Centurions, Shadowwarders and Bonewarders all drop the Sturdy Dragonmaw Shinbones."] = "Os orcs Presa do Dragão acampam no meio de {zone:1437}, ao sul da estrada; Saqueadores, Corre-brejos, Centuriões, Guarda-sombras e Guarda-ossos deixam cair Tíbias Firmes de Presa do Dragão.",
	-- ["The Hillsbrad Miners work the mine in the west of {zone:1424}; they drop the {item:7127}. Take the zeppelin from {zone:1454} to {zone:1420} and ride south through {zone:1421}."] = "Os Mineradores de Eira dos Montes trabalham na mina no oeste de {zone:1424}; eles deixam cair a {item:7127}. Pegue o zepelim de {zone:1454} até {zone:1420} e cavalgue para o sul por {zone:1421}.",
	-- ["The {area:2160} lies at the east end of {area:461} in Stonetalon. Its kobolds drop the Smoky Iron Ingots."] = "A {area:2160} fica no extremo leste do {area:461}, na Cordilheira das Torres de Pedra. Os kobolds de lá deixam cair os Lingotes Fumegantes de Ferro.",
	-- ["The {area:429} satyrs camp in eastern {zone:1440}, with the Felmusk satyrs further west; both drop Uncloven Satyr Hooves."] = "Os sátiros de {area:429} acampam no leste de {zone:1440}, com os sátiros Malmíscar mais a oeste; ambos deixam cair Cascos Não Fendidos de Sátiro.",
	-- ["The {npc:6167} roams the south-west of Stonetalon near the Fledgling and Young Chimaeras; she drops the {item:6840}."] = "A {npc:6167} vaga pelo sudoeste da Cordilheira das Torres de Pedra perto das Quimeras Filhotes e Jovens; ela deixa cair o {item:6840}.",
	-- ["Twitching Antennae from the silithid"] = "Antenas Agitadas dos silitídeos",
	-- ["Uncloven {quest:1842}"] = "{quest:1842} intactos",
	-- ["{item:6840} from the {npc:6167}"] = "{item:6840} da {npc:6167}",
	-- ["{item:7127} from the Hillsbrad Miners"] = "{item:7127} dos Mineradores de Eira dos Montes",
	-- ["{npc:5878} camps beside the road east of the {area:380}. {quest:1838} is a level 30 quest; you can take it now and gather for it on the way."] = "{npc:5878} acampa junto à estrada a leste da {area:380}. {quest:1838} é uma missão de nível 30; você pode pegá-la agora e coletar para ela no caminho.",
	-- ["{npc:6408} is in {area:367} on the {zone:1411} coast."] = "{npc:6408} está em {area:367}, na costa de {zone:1411}.",
}
