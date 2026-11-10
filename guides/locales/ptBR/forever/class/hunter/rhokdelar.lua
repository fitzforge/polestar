-- Portuguese (Brazil) (ptBR): the guide forever/class/hunter/rhokdelar (forever/class/hunter/rhokdelar.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Rhok'delar and Lok'delar"] = "Rhok'delar e Lok'delar",
	["The hunter's epic bow chain: in Classic the stave and sinew became Rhok'delar and Lok'delar (unconfirmed in Forever)."] = "A série do arco épico do caçador: no Classic, o báculo e o tendão viravam Rhok'delar e Lok'delar (não confirmado no Forever).",

	-- Step 1: The Ancient Petrified Leaf
	-- {item:18703} Ancient Petrified Leaf
	["The {item:18703}"] = "A {item:18703}",
	-- {area:2717} Molten Core · {area:254} Blackrock Mountain · {npc:12018} Majordomo Executus · {object:179703} Cache of the Firelord · {item:18703} Ancient Petrified Leaf
	["{area:2717} is a 40-player raid inside {area:254}. When {npc:12018} yields, the {object:179703} appears; it holds the {item:18703} about half the time, one per kill, so it may take several weeks of raids. Right-click the leaf to start the quest."] = "{area:2717} é uma raide de 40 jogadores dentro de {area:254}. Quando {npc:12018} se rende, aparece o {object:179703}; ele tem a {item:18703} mais ou menos metade das vezes, uma por abate, então pode levar várias semanas de raide. Clique com o botão direito na folha para começar a missão.",
	-- {item:18703} Ancient Petrified Leaf
	["from the {item:18703}"] = "da {item:18703}",

	-- Step 2: Vartrus the Ancient
	-- {npc:14526} Hastat the Ancient · {area:1767} Irontree Woods · {zone:1448} Felwood · {area:1998} Talonbranch Glade · {area:1997} Bloodvenom Post · {quest:7636} Stave of the Ancients
	["Vartrus, Stoma and {npc:14526} are petrified trees on a small island in a ring-shaped lake in {area:1767}, north {zone:1448}. Their spirits only appear when someone carrying the leaf climbs the island's little hill to its east edge. Alliance: fly to {area:1998}; Horde: fly to {area:1997}. Vartrus gives {quest:7636}, Stoma A Proper String, Hastat the quiver; each can be handed in on its own."] = "Vartrus, Stoma e {npc:14526} são árvores petrificadas numa ilhota de um lago em forma de anel em {area:1767}, no norte de {zone:1448}. Os espíritos deles só aparecem quando alguém com a folha sobe o morrinho da ilha até a borda leste. Aliança: voe para {area:1998}; Horda: voe para {area:1997}. Vartrus dá {quest:7636}, Stoma dá A melhor corda, Hastat dá a aljava; cada uma pode ser entregue separada.",
	-- {npc:14526} Hastat the Ancient
	["{npc:14526}: the quiver, last in this guide"] = "{npc:14526}: a aljava, por último neste guia",

	-- Step 3: Before the demons
	["Before the demons"] = "Antes dos demônios",
	-- {item:9224} Potion of Demon Slaying · {skill:171} Alchemy · {spell:19878} Track Demons
	-- plural, as words: Major Mana Potions = {item:13444} Major Mana Potion
	["The four demons are level 60 elites disguised as friendly travellers; talk to one and say you know what it is, and it turns into its demon form. Fight every one alone: no pet (dismiss it), no other player's heal, buff or attack once the fight starts, or the demon calls you a coward and vanishes, with a 3 hour wait for it to return (also after it dies). Buffs and potions you take before the pull are fine, and a friend may stand by to kill wandering monsters or enemy players, as long as they never touch the demon or you. Bring a {item:9224} ({skill:171} or the auction house), Major Mana Potions for the long kites, and a melee weapon with the Demonslaying enchant if you can. {spell:19878}, from your trainer, shows the disguised demons on the minimap. In a group, set loot to free for all so you can loot the head."] = "Os quatro demônios são elites de nível 60 disfarçados de viajantes amigáveis; fale com um deles e diga que sabe o que ele é, e ele assume a forma demoníaca. Enfrente cada um sozinho: sem ajudante (dispense-o) e sem cura, aprimoramento ou ataque de outro jogador depois que a luta começar, ou o demônio chama você de covarde e some, e só volta depois de 3 horas (também depois de morrer). Aprimoramentos e poções usados antes de puxar valem, e um amigo pode ficar por perto para matar monstros errantes ou jogadores inimigos, desde que nunca encoste no demônio nem em você. Leve um {item:9224} ({skill:171} ou casa de leilões), Poções Elevadas de Mana para as fugas longas e uma arma corpo a corpo com o encantamento de Demonicídio, se puder. {spell:19878}, do seu instrutor, mostra os demônios disfarçados no minimapa. Em grupo, deixe o saque liberado para todos, para poder saquear a cabeça.",
	-- {spell:19878} Track Demons
	["Learn {spell:19878} and get demon-slaying potions"] = "Aprenda {spell:19878} e arrume poções de matança de demônios",

	-- Step 4: Simone the Inconspicuous
	-- {npc:14527} Simone the Inconspicuous · {spell:19878} Track Demons · {npc:14533} Simone the Seductress · {spell:421} Chain Lightning · {spell:3034} Viper Sting · {spell:23205} Temptress' Kiss
	["{npc:14527}, a troll with a wolf, walks a long path that starts at the lake in western Un'Goro and can reach the south of the crater; use {spell:19878}. Talk to her and she becomes {npc:14533}, and her wolf Precious a Felstalker. The hardest of the four: Freezing Trap Precious and pull Simone well away from it, or kite Precious away and kill it first, let Simone reset and come back for her alone. Her {spell:421} hits hard, so drain her mana with {spell:3034} (a 15-second cooldown on Forever) and keep her busy; her {spell:23205} cuts your ranged attack power, so finish her in melee. Loot her head before Precious breaks free."] = "{npc:14527}, uma troll com um lobo, faz um caminho longo que começa no lago do oeste de Un'Goro e pode chegar ao sul da cratera; use {spell:19878}. Fale com ela e ela vira {npc:14533}, e o lobo Precioso vira um Espreitador Vil. É o mais difícil dos quatro: congele o Precioso com a Armadilha Congelante e puxe a Simone para bem longe dele, ou arraste o Precioso para longe e mate-o primeiro, deixe a Simone resetar e volte para pegá-la sozinha. A {spell:421} dela bate forte, então drene a mana dela com {spell:3034} (recarga de 15 segundos no Forever) e mantenha-a ocupada; o {spell:23205} dela corta seu poder de ataque à distância, então termine no corpo a corpo. Saqueie a cabeça antes de o Precioso se soltar.",

	-- Step 5: Franklin the Friendly
	-- {npc:14529} Franklin the Friendly · {zone:1428} Burning Steppes · {area:254} Blackrock Mountain · {npc:14534} Klinfran the Crazed · {spell:3043} Scorpid Sting · {spell:23257} Demonic Frenzy · {spell:19801} Tranquilizing Shot · {spell:2974} Wing Clip · {spell:2973} Raptor Strike
	["{npc:14529}, a human, wanders the western {zone:1428} south of {area:254}. Talk to him and he becomes {npc:14534}, the easiest of the four. Keep {spell:3043} on him the whole fight: while it lasts he barely hurts you. When he goes into {spell:23257}, remove it with {spell:19801} and never stand in melee while it is up; between frenzies you can fight him in melee with {spell:2974} and {spell:2973}. He cannot leave the {zone:1428}, so kite him around the trees if needed."] = "{npc:14529}, um humano, perambula pelo oeste de {zone:1428}, ao sul de {area:254}. Fale com ele e ele vira {npc:14534}, o mais fácil dos quatro. Mantenha {spell:3043} nele a luta inteira: enquanto durar, ele mal machuca você. Quando ele entrar em {spell:23257}, tire com {spell:19801} e nunca fique no corpo a corpo enquanto durar; entre um frenesi e outro dá para lutar corpo a corpo com {spell:2974} e {spell:2973}. Ele não sai de {zone:1428}, então arraste-o em volta das árvores se precisar.",

	-- Step 6: Nelson the Nice
	-- {npc:14536} Nelson the Nice · {area:3428} Ahn'Qiraj · {zone:1451} Silithus · {npc:14530} Solenor the Slayer · {spell:23272} Soul Flame · {object:164639} Frost Trap (no name in this language: may be words) · {spell:5384} Feign Death · {spell:2974} Wing Clip · {npc:14761} Creeping Doom · {spell:2643} Multi-Shot
	["{npc:14536}, a gnome, walks around the gates of {area:3428} in the far south-west of {zone:1451}. Talk to him and he becomes {npc:14530}. He enrages with {spell:23272} as he turns: drop a {object:164639}, {spell:5384}, and he resets without the enrage. {spell:2974} roots him for a long time; while rooted he fears you and sends beetles ({npc:14761}): kill them fast with traps and {spell:2643} before they wear you down."] = "{npc:14536}, um gnomo, anda em volta dos portões de {area:3428}, no extremo sudoeste de {zone:1451}. Fale com ele e ele vira {npc:14530}. Ele fica enfurecido com {spell:23272} ao se transformar: solte uma {object:164639}, use {spell:5384}, e ele reinicia sem a fúria. {spell:2974} o prende por bastante tempo; enquanto está preso, ele aterroriza você e manda besouros ({npc:14761}): mate-os rápido com armadilhas e {spell:2643} antes que eles desgastem você.",

	-- Step 7: Artorius the Amiable
	-- {npc:14531} Artorius the Amiable · {zone:1452} Winterspring · {area:2255} Everlook · {npc:14535} Artorius the Doombringer · {spell:23298} Demonic Doom · {spell:5118} Aspect of the Cheetah · {spell:1978} Serpent Sting · {spell:23299} Stinging Trauma · {spell:23257} Demonic Frenzy · {spell:19801} Tranquilizing Shot
	["{npc:14531}, a tauren, walks a loop in the rocks of northern {zone:1452}, north of {area:2255}. Talk to him and he becomes {npc:14535}. Within 30 yards of him {spell:23298} hits hard: keep your distance and kite him the whole fight, {spell:5118} on, south down the road. {spell:1978} on him adds {spell:23299}, extra Nature damage, so keep it ticking while you run; his {spell:23257} can be removed with {spell:19801}, but distance matters more. It is a long fight: bring mana potions and plan your kiting path."] = "{npc:14531}, um tauren, faz uma volta entre as pedras do norte de {zone:1452}, ao norte de {area:2255}. Fale com ele e ele vira {npc:14535}. A até 30 metros dele, {spell:23298} bate forte: mantenha distância e arraste-o a luta inteira, com {spell:5118} ligado, estrada abaixo para o sul. {spell:1978} nele soma {spell:23299}, dano extra de Natureza, então mantenha ativo enquanto corre; o {spell:23257} dele sai com {spell:19801}, mas a distância importa mais. É uma luta longa: leve poções de mana e planeje o caminho da corrida.",

	-- Step 8: Onyxia
	["Onyxia"] = "Onyxia",
	-- {area:2159} Onyxia's Lair · {area:511} Wyrmbog · {zone:1445} Dustwallow Marsh · {item:18705} Mature Black Dragon Sinew
	["Onyxia is the 40-player raid boss of {area:2159}, a cave in the {area:511} of southern {zone:1445}; she returns once a week. She drops one {item:18705} in about two kills of five, lootable without the quest, so only one hunter per kill gets it: settle who first."] = "Onyxia é a chefe de raide de 40 jogadores de {area:2159}, uma caverna em {area:511}, no sul de {zone:1445}; ela volta uma vez por semana. Ela deixa cair um {item:18705} em mais ou menos dois de cada cinco abates, saqueável sem a missão, então só um caçador por abate leva: combinem antes quem fica.",
	-- {item:18705} Mature Black Dragon Sinew
	["{item:18705}, from Onyxia"] = "{item:18705}, de Onyxia",

	-- Step 9: Back to the Ancients
	["Back to the Ancients"] = "De volta aos Ancientes",

	-- Step 10: Rhok'delar and Lok'delar
	-- {item:18707} Ancient Rune Etched Stave · {item:18724} Enchanted Black Dragon Sinew · {item:18715} Lok'delar, Stave of the Ancient Keepers
	["Not confirmed in Forever. In Classic, using the {item:18707} with the {item:18724} in your bags made Rhok'delar, and talking to Vartrus once more then gave {item:18715}, at no extra cost."] = "Não confirmado no Forever. No Classic, usar o {item:18707} com o {item:18724} nas bolsas fazia o Rhok'delar, e falar com o Vartrus mais uma vez dava {item:18715}, sem custo extra.",
	-- {item:18707} Ancient Rune Etched Stave
	["{item:18707}, by Vartrus"] = "{item:18707}, por Vartrus",
	-- {npc:14524} Vartrus the Ancient
	["{npc:14524}: Lok'delar in Classic"] = "{npc:14524}: Lok'delar no Classic",

	-- Step 11: Azuregos
	-- {item:18704} Mature Blue Dragon Sinew · {npc:6109} Azuregos · {zone:1447} Azshara · {area:2245} Mazthoril · {area:2255} Everlook · {zone:1452} Winterspring
	["Hastat's quiver needs the {item:18704}. {npc:6109}, a world boss for a raid, stands in southern {zone:1447}, returns only every two to four days and drops it nearly every kill. The elite Cobalt dragonkin in and around {area:2245}, the cave south of {area:2255} in {zone:1452}, drop it about once in 200 kills; Manaclaw there a little more often. Skip the rest of this guide if you do not want the quiver."] = "A aljava do Hastat pede o {item:18704}. {npc:6109}, um chefe de mundo para raide, fica no sul de {zone:1447}, só volta a cada dois a quatro dias e deixa cair quase todo abate. Os dracônicos Cobalto elite em {area:2245} e em volta, a caverna ao sul de {area:2255}, em {zone:1452}, deixam cair mais ou menos uma vez a cada 200 abates; o Patamana de lá, um pouco mais. Pule o resto deste guia se não quiser a aljava.",
	-- {item:18704} Mature Blue Dragon Sinew · {npc:6109} Azuregos
	["{item:18704}, from {npc:6109}"] = "{item:18704}, de {npc:6109}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Azuregos"] = "Azuregos",
	-- ["Hastat's quiver needs the {item:18704}. {npc:6109}, a world boss for a raid, roams the south of {zone:1447} and drops it most of the time; the Cobalt dragonkin of {zone:1452} drop it very rarely. Skip the rest of this guide if you do not want the quiver."] = "A aljava de Hastat requer o {item:18704}. {npc:6109}, um chefe mundial para raide, vaga pelo sul de {zone:1447} e o deixa cair na maioria das vezes; os dragonídeos Cobalto de {zone:1452} o deixam cair muito raramente. Pule o resto deste guia se não quiser a aljava.",
	-- ["Not confirmed in Forever. In Classic, using the {item:18707} with the {item:18724} in your bags made Rhok'delar, and Vartrus then gave {item:18715} ({spell:425121})."] = "Não confirmado no Forever. No Classic, usar o {item:18707} com o {item:18724} nas bolsas criava Rhok'delar, e Vartrus então dava {item:18715} ({spell:425121}).",
	-- ["Onyxia drops the {item:18705}; she is the 40-player raid boss of {area:2159}, a cave in the {area:511} of southern {zone:1445}."] = "Onyxia deixa cair o {item:18705}; ela é a chefe da raide de 40 jogadores do {area:2159}, uma caverna no {area:511}, no sul do {zone:1445}.",
	-- ["The {object:179703} appears in {area:2717} when {npc:12018} yields; it holds the {item:18703} about half the time. {area:2717} is a 40-player raid inside {area:254}. Right-click the leaf to start the quest."] = "O {object:179703} aparece no {area:2717} quando {npc:12018} se rende; ele tem a {item:18703} em cerca de metade das vezes. {area:2717} é uma raide de 40 jogadores dentro da {area:254}. Clique com o botão direito na folha para iniciar a missão.",
	-- ["Vartrus, Stoma and {npc:14526} stand together in the north of {zone:1448}. Alliance: {area:1998} is the nearest flight point; Horde: {area:1997}."] = "Vartrus, Stoma e {npc:14526} ficam juntos no norte de {zone:1448}. Aliança: {area:1998} é o ponto de voo mais próximo; Horda: {area:1997}.",
	-- ["{npc:14527}, a troll, stands in the west of {zone:1449}. Talk to her and she becomes {npc:14533}, with a pet of her own. Alone, without your pet."] = "{npc:14527}, uma troll, fica no oeste da {zone:1449}. Fale com ela e ela se torna {npc:14533}, com um ajudante próprio. Sozinho, sem seu ajudante.",
	-- ["{npc:14529}, a human, stands in the west of the {zone:1428}. Talk to him and he becomes {npc:14534}. Alone, without your pet."] = "{npc:14529}, um humano, fica no oeste das {zone:1428}. Fale com ele e ele se torna {npc:14534}. Sozinho, sem seu ajudante.",
	-- ["{npc:14531}, a tauren, waits in the north-east of {zone:1452}. Talk to him and he becomes {npc:14535}. Fight every demon alone and without your pet: help of any kind makes it vanish. Loot the head."] = "{npc:14531}, um tauren, espera no nordeste de {zone:1452}. Fale com ele e ele se torna {npc:14535}. Lute contra cada demônio sozinho e sem seu ajudante: qualquer tipo de ajuda o faz sumir. Saqueie a cabeça.",
	-- ["{npc:14536}, a gnome, stands in the south-west of {zone:1451}. Talk to him and he becomes {npc:14530}. Alone, without your pet; keep away from the beetles he calls."] = "{npc:14536}, um gnomo, fica no sudoeste de {zone:1451}. Fale com ele e ele se torna {npc:14530}. Sozinho, sem seu ajudante; fique longe dos besouros que ele chama.",
}
