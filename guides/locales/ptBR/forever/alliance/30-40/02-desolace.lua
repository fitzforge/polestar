-- Portuguese (Brazil) (ptBR): the guide forever/alliance/30-40/02-desolace (forever/alliance/30-40/02-desolace.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Nijel's Point
	-- {area:460} Sun Rock Retreat · {area:465} Charred Vale · {zone:1443} Desolace · {area:608} Nijel's Point
	["Follow the road west past {area:460} (Horde) and south-west through the {area:465} into {zone:1443}; {area:608} stands at the top of the pass."] = "Siga a estrada para o oeste, passando por {area:460} (Horda), e para o sudoeste por {area:465} até {zone:1443}; {area:608} fica no alto do desfiladeiro.",
	-- {npc:5642} Vahlarriel Demonslayer · {area:599} Thunder Axe Fortress
	["{npc:5642}: the Burning Blade in {area:599}, where her search leads"] = "{npc:5642}: a Lâmina Ardente em {area:599}, para onde a busca dela leva",

	-- Step 2: Malem chest
	["Malem chest"] = "Baú de Malem",
	-- {area:608} Nijel's Point
	["The chest lies in the ruins south-west of {area:608}."] = "O baú está nas ruínas a sudoeste de {area:608}.",

	-- Step 3: Sargeron
	-- {area:603} Sargeron · {area:608} Nijel's Point
	-- plural, as words: Hatefury Rogues = {npc:4670} Hatefury Rogue · Hatefury Tricksters = {npc:4671} Hatefury Trickster
	["The Hatefury satyrs hold the ruins of {area:603}, east of {area:608}.\nCareful: Hatefury Rogues spawn stealthed, and Hatefury Tricksters have a poison proc on their attacks."] = "Os sátiros Furiódio ocupam as ruínas de {area:603}, a leste de {area:608}.\nCuidado: os Errantes Furiódio surgem furtivos, e os Trapaceiros Furiódio podem envenenar a cada golpe.",

	-- Step 6: Azore Aldamort
	-- {npc:11863} Azore Aldamort · {area:599} Thunder Axe Fortress
	["{npc:11863}'s tower stands on the hill west of {area:599}: take his quest first, the sceptre he wants is in the fortress."] = "A torre de {npc:11863} fica no morro a oeste de {area:599}: pegue a missão dele primeiro; o cetro que ele quer está na fortaleza.",

	-- Step 7: Dalinda Malem
	-- {npc:5644} Dalinda Malem · {area:608} Nijel's Point
	["{npc:5644} hides inside the Burning Blade's fortress south-west of {area:608}."] = "{npc:5644} se esconde na fortaleza da Lâmina Ardente, a sudoeste de {area:608}.",
	["Inside"] = "Lá dentro",

	-- Step 8: Tyranis Malem and the Seer
	-- {npc:5643} Tyranis Malem
	["{npc:5643} and the Seer"] = "{npc:5643} e o Vidente",
	-- {npc:5643} Tyranis Malem · {npc:13019} Burning Blade Seer · {npc:5642} Vahlarriel Demonslayer
	["Her brother {npc:5643} (36) walks the fortress with the Burning Blade cultists (30-33): pull him alone. The {npc:13019} keeps the sceptre in the fortress's main building. {npc:5642} wants four of each kind of cultist on the way."] = "O irmão dela, {npc:5643} (36), anda pela fortaleza com os sectários da Lâmina Ardente (30-33): puxe-o sozinho. {npc:13019} guarda o cetro no prédio principal da fortaleza. {npc:5642} quer quatro de cada tipo de sectário pelo caminho.",
	-- {item:6767} Tyranis' Pendant
	["{item:6767}; inside"] = "{item:6767}; lá dentro",
	-- {quest:5741} Sceptre of Light
	["{quest:5741}; on the top floor"] = "{quest:5741}; no último andar",

	-- Step 9: Escort Dalinda Malem
	-- {npc:5644} Dalinda Malem
	["Escort {npc:5644}"] = "Escolte {npc:5644}",
	-- {npc:5644} Dalinda Malem
	["{npc:5644}, inside"] = "{npc:5644}, lá dentro",
	["Out of Thunder Axe Fortress"] = "Para fora da Fortaleza Machado do Trovão",
	-- {npc:5644} Dalinda Malem · {npc:5642} Vahlarriel Demonslayer · {area:608} Nijel's Point
	["Lead {npc:5644} out of the fortress; she walks off once you are clear of it. {npc:5642} takes the turn-in at {area:608} at the end of the guide."] = "Leve {npc:5644} para fora da fortaleza; ela vai embora quando vocês saírem. {npc:5642} recebe a entrega em {area:608}, no fim do guia.",

	-- Step 10: Smeed Scrabblescrew
	-- {npc:11596} Smeed Scrabblescrew · {area:609} Kolkar Village · {area:596} Kodo Graveyard
	["{npc:11596}'s camp is on the road south of {area:609}, by the {area:596}."] = "O acampamento de {npc:11596} fica na estrada ao sul de {area:609}, perto de {area:596}.",

	-- Step 11: Kodo Graveyard
	-- {npc:11596} Smeed Scrabblescrew · {item:13892} Kodo Kombobulator · {npc:4702} Ancient Kodo
	-- plural, as words: Aged Kodos = {npc:4700} Aged Kodo · Scorpashi Lashers = {npc:4697} Scorpashi Lasher
	["Use {npc:11596}'s {item:13892} on an Aged, Dying or {npc:4702}: it becomes a tamed kodo that follows you. Walk it back to {npc:11596}'s camp; there, talk to the kodo: that counts it and lets you tame the next. Five kodos, one at a time; Aged Kodos also drop the hides, and the Scorpashi Lashers that hunt around the graveyard carry the venom."] = "",
	-- {npc:4702} Ancient Kodo
	["on an Aged, Dying or {npc:4702} in the graveyard; don't kill it"] = "",
	-- {npc:11596} Smeed Scrabblescrew
	["the tamed kodo, at {npc:11596}'s camp: talk to it, five times"] = "",

	-- Step 13: Kolkar Village
	-- {area:609} Kolkar Village · {npc:5752} Corporal Melkins
	["The Kolkar roam the plains around {area:609}; their ears are for {npc:5752}."] = "Os Kolkar vagam pelas planícies ao redor de {area:609}; as orelhas deles são para {npc:5752}.",

	-- Step 15: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "Voe para {area:442}",
	-- {area:608} Nijel's Point
	["{area:608} flight master"] = "Mestre de voo de {area:608}",

	-- Step 16: Boat to Stormwind Harbor
	-- {area:17203} Stormwind Harbor
	["Boat to {area:17203}"] = "Barco para {area:17203}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Escort the caravan"] = "Escolte a caravana",
	-- ["From {area:415} head south-west to the {area:1276}, a tunnel through the mountains into Stonetalon."] = "De {area:415}, siga para o sudoeste até {area:1276}, um túnel pelas montanhas até a Cordilheira das Torres de Pedra.",
	-- ["From {area:415} ride north-west into the hills: the {quest:1738} is a glowing tree north of the road to {area:413}. If you took {quest:65602}, the {item:190309} lies in a house among the trees north of {area:413} (26.6,22.0). Then back past {area:415} to the {area:1276}."] = "De {area:415}, cavalgue para o noroeste até as colinas: {quest:1738} é uma árvore brilhante ao norte da estrada para {area:413}. Se você pegou {quest:65602}, {item:190309} está numa casa entre as árvores ao norte de {area:413} (26.6,22.0). Depois volte, passando por {area:415}, até {area:1276}.",
	-- ["From {zone:1455}'s {npc:1573}"] = "Com {npc:1573}, em {zone:1455}",
	-- ["Scorpashi venom"] = "Peçonha de Scorpachi",
	-- ["Take the boat to {area:442} from Menethil's docks."] = "Pegue o barco para {area:442} nas docas do Porto de Menethil.",
	-- ["Take the boat to {area:442} from Menethil's docks. {npc:3649} stands in {area:442}, north of the flight master."] = "Pegue o barco para {area:442} nas docas do Porto de Menethil. {npc:3649} fica em {area:442}, ao norte do mestre de voo.",
	-- ["The Gizelton Caravan waits at {area:2407}."] = "A caravana dos Gizelton espera em {area:2407}.",
	-- ["The Hatefury satyrs hold the ruins of {area:603}, east of {area:608}."] = "Os sátiros Furiódio ocupam as ruínas de {area:603}, a leste de {area:608}.",
	-- ["The Scorpashi scorpids hunt the hills around {area:2407} on the road south."] = "Os escorpídeos Escorpachi caçam nas colinas ao redor de {area:2407}, na estrada para o sul.",
	-- ["The {area:1276}"] = "{area:1276}",
	-- ["Use {npc:11596}'s {item:13892} on an {npc:4700} and walk the tamed kodo back to his camp, five times; Aged Kodos also drop the hides."] = "Use o {item:13892} de {npc:11596} num {npc:4700} e leve o kodo domado até o acampamento dele, cinco vezes; Kodos Idosos também soltam os pelegos.",
	-- ["Use {npc:11596}'s {item:13892} on an {npc:4700} and walk the tamed kodo back to his camp. There, talk to the kodo: that counts it and lets you tame the next. Five kodos, one at a time; Aged Kodos also drop the hides, and the Scorpashi Lashers that hunt around the graveyard carry the venom."] = "Use o {item:13892} de {npc:11596} em um {npc:4700} e leve o kodo domado de volta ao acampamento dele. Lá, fale com o kodo: isso o conta e deixa você domar o próximo. Cinco kodos, um de cada vez; os Kodos Idosos também soltam as peles, e os Escorpachis Açoitadores que caçam em volta do cemitério levam o veneno.",
	-- ["Walk with the caravan south past {area:609}; Kolkar ambushers jump it on the way. Stay close until it stops at {area:2617}. The ambushers are 34-35 and come in waves: skip it if you are below 33."] = "Acompanhe a caravana para o sul, passando por {area:609}; Emboscadores Kolkar a atacam no caminho. Fique perto até ela parar em {area:2617}. Os emboscadores são de nível 34-35 e vêm em ondas: pule se você estiver abaixo do 33.",
	-- ["{item:190309}, north of {area:413}"] = "{item:190309}, ao norte de {area:413}",
	-- ["{npc:3649}: {item:279915}, from Sylessa in Menethil"] = "{npc:3649}: {item:279915}, de Sylessa, no Porto de Menethil",
}
