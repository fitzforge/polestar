-- Portuguese (Brazil) (ptBR): the guide forever/horde/40-50/02-feralas (forever/horde/40-50/02-feralas.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Voe para {object:3202}",
	-- {area:1978} Misty Reed Post · {area:75} Stonard · {object:3202} Grom'gol (no name in this language: may be words)
	["Ride back north-west from {area:1978} to {area:75} and fly to {object:3202}."] = "Volte para o noroeste de {area:1978} até {area:75} e voe para {object:3202}.",

	-- Step 2: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelim para {zone:1454}",
	-- {zone:1454} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words)
	["The {zone:1454} zeppelin leaves from the tower beside {object:3202}; it lands just outside {zone:1454}'s main gate."] = "O zepelim para {zone:1454} sai da torre ao lado de {object:3202}; ele pousa logo fora do portão principal de {zone:1454}.",
	["Zeppelin tower"] = "Torre do zepelim",

	-- Step 4: Riding at 40
	["Riding at 40"] = "Montaria no 40",
	-- {npc:4752} Kildar · {object:172958} Valley of Honor (no name in this language: may be words) · {npc:3362} Ogunaro Wolfrunner
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel; no Skyborne riding trainer is known, so Skyborne try {npc:4752} too. Your race's other mounts are 20 gold each: Collectibles, Mounts · Level 40 has a guide for each."] = "Montaria exige nível 40 e custa 100 de ouro; aprender dá uma montaria. {npc:4752} ensina Orcs em {object:172958}, junto ao canil de {npc:3362}; não se conhece instrutor de montaria celonato, então os Celonatos também tentam {npc:4752}. As outras montarias da sua raça custam 20 de ouro cada: Colecionáveis, Montarias · Nível 40 tem um guia para cada.",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}, instrutor de montaria",
	-- {npc:3362} Ogunaro Wolfrunner · {npc:4752} Kildar
	["Wolves: {npc:3362}, beside {npc:4752}."] = "Lobos: {npc:3362}, ao lado de {npc:4752}.",
	-- {npc:265756} Genn Fairweather · {area:16638} Valanaar
	["Galestriders: {npc:265756}, in {area:16638} on Zephras Isle."] = "Vagaventos: {npc:265756}, em {area:16638}, na Ilha de Zefras.",

	-- Step 5: Riding at 40
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village · {zone:1411} Durotar · {npc:4752} Kildar · {zone:1454} Orgrimmar · {object:172958} Valley of Honor (no name in this language: may be words)
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:7953} in {area:367} on the {zone:1411} coast, with Zjolnir's raptors (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "Montaria exige nível 40 e custa 100 de ouro; aprender dá uma montaria. No Classic cada raça aprende com o instrutor da própria raça: o seu é {npc:7953} em {area:367}, no litoral de {zone:1411}, com os raptores de Zjolnir (20 de ouro cada) ao lado. O Forever talvez deixe qualquer raça aprender com qualquer instrutor de montaria (não confirmado): tente primeiro {npc:4752} em {object:172958} de {zone:1454}, que é o mais próximo, e pule esta etapa se ele ensinar você.",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}, instrutor de montaria",
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village
	["Raptors: Zjolnir, beside {npc:7953} in {area:367}."] = "Raptores: Zjolnir, ao lado de {npc:7953} em {area:367}.",

	-- Step 6: Riding at 40
	-- {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village · {npc:3685} Harb Clawhoof · {npc:4752} Kildar · {zone:1454} Orgrimmar · {object:172958} Valley of Honor (no name in this language: may be words)
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:3690} in {area:222}, with {npc:3685}'s kodos (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "Montaria exige nível 40 e custa 100 de ouro; aprender dá uma montaria. No Classic cada raça aprende com o instrutor da própria raça: o seu é {npc:3690} em {area:222}, com os kodos de {npc:3685} (20 de ouro cada) ao lado. O Forever talvez deixe qualquer raça aprender com qualquer instrutor de montaria (não confirmado): tente primeiro {npc:4752} em {object:172958} de {zone:1454}, que é o mais próximo, e pule esta etapa se ele ensinar você.",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}, instrutor de montaria",
	-- {npc:3685} Harb Clawhoof · {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village
	["Kodos: {npc:3685}, beside {npc:3690} in {area:222}."] = "Kodos: {npc:3685}, ao lado de {npc:3690} em {area:222}.",

	-- Step 7: Riding at 40
	-- {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {npc:4752} Kildar · {zone:1454} Orgrimmar · {object:172958} Valley of Honor (no name in this language: may be words)
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, with {npc:4731}'s skeletal horses (20 gold each) beside her. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "Montaria exige nível 40 e custa 100 de ouro; aprender dá uma montaria. No Classic cada raça aprende com o instrutor da própria raça: o seu é {npc:4773} em {area:159}, com os cavalos esqueléticos de {npc:4731} (20 de ouro cada) ao lado dela. O Forever talvez deixe qualquer raça aprender com qualquer instrutor de montaria (não confirmado): tente primeiro {npc:4752} em {object:172958} de {zone:1454}, que é o mais próximo, e pule esta etapa se ele ensinar você.",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}, instrutora de montaria",
	-- {npc:4731} Zachariah Post · {npc:4773} Velma Warnam · {area:159} Brill
	["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "Cavalos esqueléticos: {npc:4731}, ao lado de {npc:4773} em {area:159}.",

	-- Step 8: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful · {zone:1454} Orgrimmar · {area:484} Freewind Post
	["Your trainer is in {area:1638}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly there from {zone:1454}, then on to {area:484}."] = "Seu instrutor fica em {area:1638}: {npc:3033} (Druidas) em {area:1639}, {npc:246344} (Paladinos). Voe para lá de {zone:1454} e depois siga para {area:484}.",

	-- Step 9: Ratchet for the Felsteed
	-- {area:392} Ratchet
	["{area:392} for the Felsteed"] = "{area:392} para o Corcel Vil",

	-- Step 10: Fly to Freewind Post
	-- {area:484} Freewind Post
	["Fly to {area:484}"] = "Voe para {area:484}",
	-- {area:484} Freewind Post · {zone:1446} Tanaris
	["Fly to {area:484}, ride down the lift east of the post and across the salt flats, then south into {zone:1446}."] = "Voe para {area:484}, desça pelo elevador a leste do posto, atravesse as salinas e siga para o sul até {zone:1446}.",

	-- Step 11: Gadgetzan
	-- {area:976} Gadgetzan · {zone:1446} Tanaris
	["{area:976} is the walled goblin town just past the {zone:1446} border."] = "{area:976} é a cidade goblin murada logo depois da fronteira de {zone:1446}.",
	-- {object:150075} Wanted Poster
	["the {object:150075} in the square"] = "{object:150075} na praça",

	-- Step 12: Eastern Wastewander camps
	["Eastern Wastewander camps"] = "Acampamentos Errantes do leste",
	-- {area:976} Gadgetzan
	["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: keep ten, five for each of Luglunket's bounties."] = "Os Bandidos e Ladrões Errantes acampam nas dunas a leste de {area:976}. Todo Errante pode carregar uma bolsa de água: guarde dez, cinco para cada recompensa de Rastamala.",
	["water pouches in your bags"] = "bolsas de água nas bolsas",

	-- Step 14: Southern Wastewander camps
	["Southern Wastewander camps"] = "Acampamentos Errantes do sul",
	-- {area:976} Gadgetzan
	["The shadow mages, rogues and assassins camp south-east of {area:976}."] = "Os Magos das Sombras, Ladinos e Assassinos Errantes acampam a sudeste de {area:976}.",

	-- Step 15: Steamwheedle Port
	["Ride north-east to the goblin harbour on the coast."] = "Siga para o nordeste até o porto goblin na costa.",
	-- {npc:8579} Yeh'kinya · {zone:1444} Feralas
	["{npc:8579}: the screechers live in {zone:1444}"] = "{npc:8579}: os guinchadores vivem em {zone:1444}",

	-- Step 16: Lost Rigger Cove
	-- {npc:7883} Andre Firebeard
	["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often."] = "Ao sul pela costa, os piratas dos Mares do Sul ocupam a enseada. {npc:7883} e a carga roubada ficam no cais, no fundo dela. Qualquer pirata pode deixar cair um chapéu, os Sequestradores com mais frequência.",

	-- Step 17: Steamwheedle Port
	-- {area:35} Booty Bay
	["for {area:35}, around level 50"] = "para {area:35}, por volta do nível 50",

	-- Step 18: Gadgetzan
	-- {area:976} Gadgetzan
	["Ride back west to {area:976}."] = "Volte para o oeste até {area:976}.",

	-- Step 19: Fly to Freewind Post
	-- {area:484} Freewind Post · {area:2237} Whitereach Post · {zone:1444} Feralas · {area:1099} Camp Mojache
	["Fly to {area:484}, then ride west through the canyons past {area:2237}; the road climbs into the {zone:1444} jungle and on to {area:1099}."] = "Voe para {area:484} e siga para o oeste pelos cânions, passando por {area:2237}; a estrada sobe para a selva de {zone:1444} e segue até {area:1099}.",

	-- Step 20: Camp Mojache
	-- {npc:8115} Witch Doctor Uzer'i · {zone:1454} Orgrimmar
	["{npc:8115}: for {zone:1454}, around level 45"] = "{npc:8115}: para {zone:1454}, por volta do nível 45",

	-- Step 21: Woodpaw north camp
	["Woodpaw north camp"] = "Acampamento Patábua do norte",
	["The Woodpaw gnolls camp in the hills just north-west of Mojache; any of them can drop a mane."] = "Os gnolls Patábua acampam nas colinas logo a noroeste de Mojache; qualquer um deles pode deixar cair uma juba.",

	-- Step 22: Gordunni Outpost
	["North of the gnolls the ogres hold a hilltop outpost; pull the ogre-magi to you. The cobalt is in the dirt mounds around the outpost, and the scroll lies on the ground inside it."] = "Ao norte dos gnolls, os ogros ocupam um posto no alto de uma colina; puxe os Ogros-magos até você. O cobalto está nos montes de terra em volta do posto, e o pergaminho fica no chão lá dentro.",

	-- Step 23: Camp Mojache
	-- {quest:2863} Alpha Strike
	["{quest:2863}: one hour from now"] = "{quest:2863}: daqui a uma hora",

	-- Step 24: Sprite darters and Woodpaw alphas
	["Sprite darters and Woodpaw alphas"] = "Dardejantes e Machos Alfa Patábua",
	["The sprite darters flit over the grove just west of Mojache; nearly every one drops a wing. The Woodpaw alphas lead the camps south-west of it: kill them within the hour."] = "Os Dardejantes voejam sobre o bosque logo a oeste de Mojache; quase todos deixam cair uma asa. Os Machos Alfa Patábua lideram os acampamentos a sudoeste dele: mate-os dentro de uma hora.",

	-- Step 26: Grimtotem camp
	["Grimtotem camp"] = "Acampamento Temível Totem",
	["The Grimtotem tauren camp beside the sprite darters' grove; raiders, naturalists and shamans all carry horns."] = "Os taurens Temível Totem acampam ao lado do bosque dos Dardejantes; Saqueadores, Naturalistas e Xamãs carregam chifres.",

	-- Step 27: Woodpaw battle map
	["Woodpaw battle map"] = "Mapa de batalha Patábua",
	["The battle map lies in the Woodpaw camp south of Mojache."] = "O mapa de batalha fica no acampamento Patábua ao sul de Mojache.",

	-- Step 28: Southern Gordunni ruins
	["Southern Gordunni ruins"] = "Ruínas Gordunni do sul",
	-- {area:1105} Feral Scar Vale
	["Ride south-west to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb."] = "Siga para o sudoeste até as ruínas dos ogros abaixo de {area:1105}. Xamãs, Bruxos e Espancadores as ocupam; os Lordes-magos na ponta sul carregam o orbe.",

	-- Step 29: Camp Mojache
	-- {zone:1454} Orgrimmar
	["for {zone:1454}, around level 45"] = "para {zone:1454}, por volta do nível 45",

	-- Step 30: The Writhing Deep
	-- {quest:7731} Stinglasher
	["The Zukk'ash hive burrows into the hills south-east of the camp; {quest:7731} waits in its deepest chamber."] = "A colmeia Zukk'ash se entoca nas colinas a sudeste do acampamento; {quest:7731} espera na câmara mais funda.",

	-- Step 32: Rogue Vale screechers
	["Rogue Vale screechers"] = "Guinchadores Errantes do Vale",
	-- {zone:1444} Feralas · {npc:5308} Rogue Vale Screecher · {item:10699} Yeh'kinya's Bramble
	["Ride west into the middle of {zone:1444}. Kill a {npc:5308}, use {item:10699} on its body and kill the spirit that rises."] = "Siga para o oeste até o meio de {zone:1444}. Mate um {npc:5308}, use {item:10699} no corpo e mate o espírito que surgir.",

	-- Step 33: The Forgotten Coast
	-- plural, as words: Coast Crawl Deepseers = {npc:5328} Coast Crawl Deepseer
	["Keep riding west to the coast. The Coast Crawl Deepseers and Snapclaws on the beaches drop OOX-22/FE's distress beacon about one kill in forty: if one drops, use it to start the quest."] = "Continue para o oeste até a costa. Os Olhabismos e Estalagarras da Areia nas praias deixam cair o sinalizador de socorro do OOX-22/FE em cerca de uma morte a cada quarenta: se cair, use-o para iniciar a missão.",

	-- Step 34: Homing Robot OOX-22/FE
	-- {area:1105} Feral Scar Vale · {area:1108} The Forgotten Coast · {area:35} Booty Bay
	["Only with the distress beacon: the robot sits in a small cave on the north side of {area:1105}. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit."] = "Só com o sinalizador de socorro: o robô fica numa pequena caverna no lado norte de {area:1105}. Escolte-o até o cais na {area:1108}; yetis e gorilas emboscam você no caminho. A recompensa espera em {area:35} para uma visita futura.",

	-- Step 35: Hearth to Camp Mojache
	-- {area:1099} Camp Mojache
	["Hearth to {area:1099}"] = "Regresse para {area:1099}",

	-- Step 36: Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}. The Droffers brothers run their shop in the Drag."] = "Voe para {area:1637}. Os irmãos Droffers têm sua loja no Drag.",
	-- {zone:1425} Hinterlands
	["for the {zone:1425}, around level 48"] = "para {zone:1425}, por volta do nível 48",

	-- Step 37: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Zeppelin to {object:3202}"] = "Zepelim para {object:3202}",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {zone:1454} Orgrimmar
	["The {object:3202} zeppelin leaves from the tower just north-east of {zone:1454}'s main gate."] = "O zepelim para {object:3202} sai da torre logo a nordeste do portão principal de {zone:1454}.",

	-- Step 38: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "Voe para {area:75}",
	-- {area:75} Stonard
	["Thysta, the flight master, stands just east of the zeppelin tower. Fly to {area:75}: the next guide starts there."] = "Thysta, a mestre de voo, fica logo a leste da torre do zepelim. Voe para {area:75}: o próximo guia começa lá.",
}
