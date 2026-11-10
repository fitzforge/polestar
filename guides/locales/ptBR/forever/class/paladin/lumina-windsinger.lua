-- Portuguese (Brazil) (ptBR): the guide forever/class/paladin/lumina-windsinger (forever/class/paladin/lumina-windsinger.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:268484} Moonsilver Blade · {item:267369} Wolfsbane
	["{item:268484} and {item:267369} (Forsaken)"] = "{item:268484} e {item:267369} (Renegados)",
	-- {quest:91862} Lumina Windsinger · {quest:95140} Old Fire-Eye
	["The Forsaken paladin's two-handed sword: rescue {quest:91862}, gather three parts, slay {quest:95140}."] = "A espada de duas mãos do paladino Renegado: resgate {quest:91862}, junte três partes e mate o {quest:95140}.",

	-- Step 1: Danitha Morr
	-- {npc:246378} Danitha Morr · {area:16602} Bandarion Keep · {area:156} Solliden Farmstead · {area:228} Sepulcher · {zone:1421} Silverpine Forest
	["At 18 {npc:246378}, inside {area:16602} on the bluffs north-west of the {area:156}, sends you south to the {area:228} in {zone:1421}."] = "No nível 18, {npc:246378}, dentro de {area:16602}, nos penhascos a noroeste de {area:156}, manda você para o sul até {area:228}, em {zone:1421}.",

	-- Step 2: Sepulcher
	-- {npc:248840} Trevan Rol · {area:228} Sepulcher · {npc:259611} Deathguard Baldren
	["{npc:248840} stands in the lower part of the {area:228}, below the surface; {npc:259611} keeps watch near the town's entrance."] = "{npc:248840} fica na parte de baixo de {area:228}, debaixo da terra; {npc:259611} vigia perto da entrada da vila.",

	-- Step 3: The pyre on Fenris Isle
	-- {area:172} Fenris Isle
	["The pyre on {area:172}"] = "A pira em {area:172}",
	-- {area:172} Fenris Isle · {area:228} Sepulcher · {object:566037} Charred Remains (no name in this language: may be words)
	["{area:172} lies in the lake north-east of the {area:228}. The gnolls' pyre, with the {object:566037}, is on its shore: click the remains to hand in, and click them again for the next quest. The body is a tauren's, not the elf's."] = "{area:172} fica no lago a nordeste de {area:228}. A pira dos gnolls, com {object:566037}, fica na margem: clique nos restos para entregar e clique de novo para a próxima missão. O corpo é de um tauren, não do elfo.",
	-- {object:566037} Charred Remains (no name in this language: may be words)
	["from the {object:566037}"] = "dos {object:566037}",

	-- Step 4: Fenris Keep
	-- {quest:91862} Lumina Windsinger · {area:235} Fenris Keep · {item:267412} Fenris Isle Key · {npc:1944} Rot Hide Bruiser
	["{quest:91862} is caged in the basement of {area:235}, at the north end of the isle. The Rot Hide gnolls (level 18-19) fill the keep: they pull in big groups across floors and players report very fast respawns, so clear a path and keep moving. Any of them can carry the {item:267412} (often the first kill); the rare {npc:1944} (22) and Snarlmane (23) can too. If her cage is empty, another player is escorting her: wait for her to come back."] = "{quest:91862} está presa numa jaula no porão de {area:235}, na ponta norte da ilha. Os gnolls Putricouro (nível 18-19) lotam a fortaleza: vêm em bandos grandes entre os andares e a galera relata que renascem muito rápido, então abra um caminho e não pare. Qualquer um pode estar com a {item:267412} (muitas vezes o primeiro que você mata); o raro {npc:1944} (22) e o Rosnajuba (23) também podem. Se a jaula estiver vazia, outro jogador está escoltando ela: espere ela voltar.",
	-- {item:267412} Fenris Isle Key
	["{item:267412}, from the Rot Hide gnolls"] = "{item:267412}, dos Gnolls Putricouro",

	-- Step 5: Free Lumina Windsinger
	-- {npc:248755} Lumina Windsinger
	["Free {npc:248755}"] = "Liberte {npc:248755}",
	-- {npc:248755} Lumina Windsinger · {area:228} Sepulcher
	["Hand in the key first: starting the escort before that gives the key quest no credit. Then open the cage: {npc:248755} walks out through the keep and its courtyard while the gnolls attack, then runs for the dock and makes her own way back to the {area:228}. Stay close and keep her alive; if she dies, take the quest again when she is back in her cage."] = "Entregue a chave primeiro: começar a escolta antes disso não conta para a missão da chave. Depois abra a jaula: {npc:248755} sai andando pela fortaleza e pelo pátio enquanto os gnolls atacam, depois corre para o cais e volta sozinha para {area:228}. Fique perto e mantenha-a viva; se ela morrer, pegue a missão de novo quando ela voltar para a jaula.",

	-- Step 6: Back to the Sepulcher
	-- {area:228} Sepulcher
	["Back to the {area:228}"] = "De volta ao {area:228}",
	-- {npc:259620} Lumina Windsinger · {npc:248840} Trevan Rol · {area:228} Sepulcher · {quest:95034} The Debt
	["{npc:259620} waits beside {npc:248840} in the {area:228} (a different {npc:259620} from the one you escorted). For {quest:95034}, click through every line of her story."] = "{npc:259620} espera ao lado de {npc:248840}, em {area:228} (uma {npc:259620} diferente da que você escoltou). Para {quest:95034}, clique em todas as falas da história dela.",
	-- {npc:259620} Lumina Windsinger · {area:228} Sepulcher
	["{npc:259620}, the {area:228}"] = "{npc:259620}, {area:228}",
	-- {npc:259620} Lumina Windsinger
	["{npc:259620}: hear her story to the end"] = "{npc:259620}: ouça a história dela até o fim",

	-- Step 7: A Moon-Kissed Blade
	-- {npc:259620} Lumina Windsinger · {quest:95140} Old Fire-Eye · {npc:248840} Trevan Rol
	["At 20 {npc:259620} asks for a blade that can kill {quest:95140}. Talk to {npc:248840} beside her for his Weapon Notes, which list the parts, and keep them: he wants them back with the parts. Three parts, in any order: two from dungeons (a group of five each) and a gem from elite naga outside a third."] = "No nível 20, {npc:259620} pede uma lâmina capaz de matar o {quest:95140}. Fale com {npc:248840}, ao lado dela, para pegar as Anotações sobre Armas, que listam as partes, e guarde: ele quer de volta junto com as partes. Três partes, em qualquer ordem: duas de masmorras (grupo de cinco cada) e uma gema de nagas elite do lado de fora de uma terceira.",
	-- {item:267454} Trevan's Weapon Notes · {npc:248840} Trevan Rol
	["{item:267454}: talk to {npc:248840}"] = "{item:267454}: fale com {npc:248840}",

	-- Step 8: The Enchanted Silver Ingot
	-- {item:267361} Enchanted Silver Ingot
	["The {item:267361}"] = "O {item:267361}",
	-- {area:236} Shadowfang Keep · {npc:4275} Archmage Arugal
	["{area:236} is the dungeon in south Silverpine, for a group of five in the low to mid 20s. The ingot sits on the table next to {npc:4275} at the very end. A friend's cleared instance works: walk in and run to the table."] = "{area:236} é a masmorra do sul de Pinhaprata, para grupo de cinco por volta do nível 20 a 25. O lingote fica na mesa ao lado de {npc:4275}, bem no final. A instância já limpa de um amigo serve: entre e corra até a mesa.",
	-- {item:267361} Enchanted Silver Ingot
	["{item:267361}, on Arugal's table"] = "{item:267361}, na mesa do Arugal",

	-- Step 9: Whitestone Oak Lumber
	-- {area:1581} The Deadmines · {area:20} Moonbrook · {zone:1436} Westfall · {zone:1458} Undercity · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1434} Stranglethorn Vale · {zone:1431} Duskwood
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["{area:1581} lies under {area:20} in {zone:1436}, Alliance land: a group of five at about 17-24. From the {zone:1458} take the zeppelin to {object:3202} in {zone:1434} and go north through {zone:1431} into {zone:1436}. The way in is the {area:20} mine. The Goblin Woodcarvers (elite, level 18-19) in Sneed's mast room drop the lumber every time."] = "{area:1581} fica embaixo de {area:20}, em {zone:1436}, terra da Aliança: grupo de cinco por volta do nível 17-24. De {zone:1458}, pegue o zepelim até {object:3202}, em {zone:1434}, e siga para o norte por {zone:1431} até {zone:1436}. A entrada é a mina de {area:20}. Os Goblins Entalhadores (elite, nível 18-19) na sala do mastro do Sneed sempre deixam cair a madeira.",
	-- {area:1581} The Deadmines · {area:20} Moonbrook
	["{area:1581}, in the {area:20} mine"] = "{area:1581}, na mina de {area:20}",
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["Goblin Woodcarvers, inside"] = "Goblins Entalhadores, lá dentro",

	-- Step 10: Ulric Frostveil
	-- {npc:259649} Ulric Frostveil · {area:2897} Zoram'gar Outpost · {zone:1440} Ashenvale · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1458} Undercity · {zone:1454} Orgrimmar · {zone:1413} Barrens
	["{npc:259649} waits at {area:2897} on {zone:1440}'s west coast: take the zeppelin from {object:3202} (or the {zone:1458}) to {zone:1454}, then go north through the {zone:1413} into {zone:1440} and west along the road. Andruk, the outpost's wind rider master, saves you the walk next time. Take {npc:259649}'s quest before you hunt the naga: the Kor Gem only drops while you have it."] = "{npc:259649} espera em {area:2897}, na costa oeste de {zone:1440}: pegue o zepelim de {object:3202} (ou de {zone:1458}) para {zone:1454}, depois siga para o norte por {zone:1413} até {zone:1440} e para oeste pela estrada. O Andruk, mestre de mantícoras do posto, poupa a caminhada da próxima vez. Pegue a missão de {npc:259649} antes de caçar os nagas: a Gema Kor só cai enquanto você estiver com ela.",

	-- Step 11: The Corrupted Kor Gem
	-- {item:6995} Corrupted Kor Gem
	["The {item:6995}"] = "A {item:6995}",
	-- {area:2797} Blackfathom Deeps · {item:6995} Corrupted Kor Gem · {spell:122} Frost Nova
	["The naga stand in the flooded ruins and passages around the {area:2797} entrance, just north of Zoram'gar: you do not need to enter the instance (its first naga drop the gem too). Tide Priestesses (level 20-21), Oracles (21-22) and Sea Witches (23-24) drop the {item:6995}, one in two. All are elite: grouping up is encouraged. Players solo them one at a time, with difficulty; a group of three makes it easy. They heal themselves, run for help at low health, and the Sea Witches cast {spell:122} up close. Some players report no drop while in a raid group."] = "Os nagas ficam nas ruínas alagadas e nas passagens em volta da entrada de {area:2797}, logo ao norte de Zoram'gar: você não precisa entrar na instância (os primeiros nagas de dentro também deixam cair a gema). Sacerdotisas da Maré (nível 20-21), Oráculos (21-22) e Bruxas do Mar (23-24) deixam cair a {item:6995}, uma vez em duas. Todos são elite: vale ir em grupo. A galera encara um de cada vez sozinha, com dificuldade; com três fica fácil. Eles se curam, fogem atrás de ajuda com pouca vida, e as Bruxas do Mar soltam {spell:122} de perto. Há quem relate que não cai nada em grupo de raide.",

	-- Step 12: The Purified Kor Gem
	-- {item:272448} Purified Kor Gem
	["The {item:272448}"] = "A {item:272448}",
	-- {npc:259649} Ulric Frostveil · {item:272448} Purified Kor Gem · {npc:248840} Trevan Rol
	["Back to {npc:259649} at Zoram'gar: he cleanses the gem. Keep the {item:272448} for {npc:248840}."] = "De volta a {npc:259649}, em Zoram'gar: ele purifica a gema. Guarde a {item:272448} para {npc:248840}.",

	-- Step 13: Trevan Rol
	-- {npc:248840} Trevan Rol · {area:228} Sepulcher · {item:268192} Bundle of Blacksmithing Materials · {area:272} Tarren Mill
	["Bring the lumber, the ingot and the gem to {npc:248840} in the {area:228}. He gives you a {item:268192} for a smith in {area:272}: keep it in your bags."] = "Leve a madeira, o lingote e a gema para {npc:248840}, em {area:228}. Ele dá um {item:268192} para um ferreiro em {area:272}: guarde nas bolsas.",

	-- Step 14: Ott
	-- {npc:3539} Ott · {area:272} Tarren Mill · {zone:1424} Hillsbrad Foothills · {quest:95125} Ott's Masterwork
	["{npc:3539}, the weaponsmith, stands just south of {area:272} in {zone:1424}. Accepting {quest:95125} starts the forging: step back and wait near him until he is done."] = "{npc:3539}, o armeiro, fica logo ao sul de {area:272}, em {zone:1424}. Aceitar {quest:95125} começa a forja: dê um passo para trás e espere perto dele até ele terminar.",
	-- {npc:3539} Ott
	["Watch {npc:3539} forge the blade"] = "Assista a {npc:3539} forjar a lâmina",
	-- {npc:3539} Ott · {quest:95125} Ott's Masterwork
	["{npc:3539} gives you {quest:95125}"] = "{npc:3539} dá {quest:95125}",

	-- Step 15: The Moonsilver Blade
	-- {npc:248840} Trevan Rol · {area:228} Sepulcher · {item:268484} Moonsilver Blade
	["Back to {npc:248840} in the {area:228}'s lower part: he hands you the {item:268484}, a two-handed sword."] = "De volta a {npc:248840}, na parte de baixo de {area:228}: ele entrega a {item:268484}, uma espada de duas mãos.",

	-- Step 16: Two-Handed Swords
	-- {npc:11870} Archibald · {zone:1458} Undercity · {object:36070} War Quarter (no name in this language: may be words) · {spell:202} Two-Handed Swords
	["The blade is a two-handed sword, and you need the skill to hit a level 25 elite with it. {npc:11870}, the weapon master in the {zone:1458}'s {object:36070}, teaches {spell:202} for a small fee; then swing it on easy mobs until the skill is near its cap (five points per level)."] = "A lâmina é uma espada de duas mãos, e você precisa da habilidade para acertar com ela um elite de nível 25. {npc:11870}, o mestre de armas no {object:36070} da {zone:1458}, ensina {spell:202} por uma pequena taxa; depois, golpeie com ela monstros fáceis até a habilidade chegar perto do limite (cinco pontos por nível).",

	-- Step 17: Old Fire-Eye
	-- {item:268484} Moonsilver Blade · {quest:95140} Old Fire-Eye · {area:228} Sepulcher · {area:17065} Gilneas
	["Equip the {item:268484}. {quest:95140}, the great worgen, roams the woods south of the {area:228} toward the gates of {area:17065}. He is elite (level 25): grouping up is encouraged; one player needed a second, another soloed him at 25. A purple shield guards him until your first swing with the blade lands: a message tells you it broke."] = "Equipe a {item:268484}. {quest:95140}, o worgen grandão, anda pela mata ao sul de {area:228}, rumo aos portões de {area:17065}. Ele é elite (nível 25): vale ir em grupo; um jogador precisou de mais um, outro matou sozinho no nível 25. Um escudo roxo protege ele até o seu primeiro golpe com a lâmina acertar: uma mensagem avisa que quebrou.",
	-- {quest:95140} Old Fire-Eye · {item:268484} Moonsilver Blade
	["{quest:95140}, with the {item:268484} equipped"] = "{quest:95140}, com a {item:268484} equipada",

	-- Step 18: Wolfsbane
	-- {npc:259620} Lumina Windsinger · {area:228} Sepulcher · {item:268484} Moonsilver Blade · {item:267369} Wolfsbane
	["Back to {npc:259620} in the {area:228} with the {item:268484} (the quest asks for it): she takes it and blesses it with the magic of her people into {item:267369}."] = "De volta a {npc:259620}, em {area:228}, com a {item:268484} (a missão pede): ela pega e abençoa com a magia do povo dela, transformando em {item:267369}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Free her with the key, then stay close while she fights her way out of the keep."] = "Liberte-a com a chave e fique perto enquanto ela abre caminho para fora da fortaleza.",
	-- ["No item yet: a Forsaken paladin rescue story; its sequel, the {item:268484}, cannot be finished yet."] = "Ainda sem item: uma história de resgate de paladino Renegado; a continuação, a {item:268484}, ainda não pode ser concluída.",
	-- ["Once she is clear of {area:235}, {npc:259620} waits for you in the {area:228}. Speak with her again to hear what really happened on the road."] = "Assim que sair de {area:235}, {npc:259620} espera você no {area:228}. Fale com ela de novo para saber o que realmente aconteceu na estrada.",
	-- ["Rescuing {quest:91862}"] = "Resgatando {quest:91862}",
	-- ["Ride south through {zone:1421} to the {area:228}. {npc:248840} stands in the town; {npc:259611} keeps watch near its entrance."] = "Siga para o sul por {zone:1421} até o {area:228}. {npc:248840} fica na cidade; {npc:259611} vigia perto da entrada.",
	-- ["{area:1581} lies under {area:20} in {zone:1436}, Alliance land: a group of five at about 17-24. The way in is the {area:20} mine. The Goblin Woodcarvers (elite, level 18-19) in Sneed's mast room drop the lumber every time."] = "{area:1581} fica embaixo de {area:20}, em {zone:1436}, terra da Aliança: grupo de cinco por volta do nível 17-24. A entrada é a mina de {area:20}. Os Goblins Entalhadores (elite, nível 18-19) na sala do mastro do Sneed sempre deixam cair a madeira.",
	-- ["{area:172} lies in the lake east of the {area:228}. The charred remains are on its shore."] = "{area:172} fica no lago a leste do {area:228}. Os restos carbonizados estão na margem.",
	-- ["{npc:246378} leads the Paladins of Tyr's Watch from inside {area:16602}, on the bluffs north-west of the {area:156}."] = "{npc:246378} lidera os Paladinos da Vigília de Tyr de dentro de {area:16602}, nos penhascos a noroeste de {area:156}.",
	-- ["{quest:91862} is caged inside {area:235}, at the north end of the isle. The Rot Hide gnolls around her carry the key."] = "{quest:91862} está presa numa jaula dentro de {area:235}, no extremo norte da ilha. Os Gnolls Putricouro em volta dela carregam a chave.",
	-- ["{zone:1458} and Earthen Ring reputation"] = "Reputação com {zone:1458} e Harmonia Telúrica",
}
