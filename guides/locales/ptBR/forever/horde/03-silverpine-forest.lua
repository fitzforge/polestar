-- Portuguese (Brazil) (ptBR): the guide forever/horde/03-silverpine-forest (forever/horde/03-silverpine-forest.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: To Orgrimmar
	-- {area:1637} Orgrimmar
	["To {area:1637}"] = "Até {area:1637}",
	-- {area:380} Crossroads · {area:1637} Orgrimmar · {npc:3310} Doras · {object:172982} Valley of Strength (no name in this language: may be words)
	["From the {area:380}, follow the road north-east to {area:1637} and walk in by the main gate. {npc:3310}, the wind rider master, stands on the tower in the {object:172982}."] = "Da {area:380}, siga a estrada para nordeste até {area:1637} e entre pelo portão principal. {npc:3310}, o mestre de mantícoras, fica na torre do {object:172982}.",

	-- Step 2: Orgrimmar class quests
	-- {zone:1454} Orgrimmar
	["{zone:1454} class quests"] = "Missões de classe em {zone:1454}",
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits (no name in this language: may be words)
	["{npc:6018} stands in the {object:172961} on the city's west side."] = "{npc:6018} fica no {object:172961}, no lado oeste da cidade.",

	-- Step 3: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly to {area:1638}: {npc:3033} trains you on {area:1639}. Skyborne: fly back to {zone:1454} for the zeppelin afterwards."] = "Voe até {area:1638}: {npc:3033} treina você no {area:1639}. Nascido nos Céus: depois, voe de volta a {zone:1454} para o zepelim.",

	-- Step 4: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["Cast {spell:18960}; {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Lance {spell:18960}; {npc:11802} está em {area:2361}. Os Adornos de Altar ficam no fundo de {area:656} e somem em poucos minutos: nade com um direto até {area:2362} na margem noroeste, use-o lá e fale com {npc:11799}.",
	-- {quest:6127} The Principal Source · {area:384} Dreadmist Peak
	["{quest:6127}: {area:384}, next guide"] = "{quest:6127}: {area:384}, próximo guia",
	-- {npc:11799} Tajarri · {area:2362} Shrine of Remulos
	["{npc:11799}, at the {area:2362}"] = "{npc:11799}, no {area:2362}",
	-- {npc:11798} Bunthen Plainswind · {area:2361} Nighthaven · {zone:1454} Orgrimmar
	["{npc:11798} in {area:2361} flies druids there; then fly on to {zone:1454} for the zeppelin"] = "{npc:11798}, em {area:2361}, leva druidas voando até lá; depois voe até {zone:1454} para o zepelim",

	-- Step 5: Zeppelin to Tirisfal Glades
	-- {zone:1420} Tirisfal Glades
	["Zeppelin to {zone:1420}"] = "Zepelim para {zone:1420}",
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {object:3202} Grom'gol (no name in this language: may be words)
	["The zeppelin towers stand just outside {zone:1454}'s main gate. Take the zeppelin to {zone:1420} (the other one goes to {object:3202})."] = "As torres de zepelim ficam logo fora do portão principal de {zone:1454}. Pegue o zepelim para {zone:1420} (o outro vai para {object:3202}).",
	["Zeppelin tower"] = "Torre de zepelim",

	-- Step 6: Brill
	-- {npc:246152} Shari Stilwell · {area:159} Brill
	["{npc:246152} trains Paladins in {area:159}, a short walk north up the road from the zeppelin towers. Come back down the same road for Silverpine."] = "{npc:246152} treina Paladinos em {area:159}, a uma curta caminhada para o norte pela estrada a partir das torres de zepelim. Volte pela mesma estrada para Pinhaprata.",

	-- Step 7: Into Silverpine
	["Into Silverpine"] = "Rumo a Pinhaprata",
	-- {area:153} Ruins of Lordaeron · {zone:1421} Silverpine Forest · {area:228} Sepulcher
	["The zeppelin lands at the towers outside the {area:153}. Walk west along the road past the ruins and south into {zone:1421}; follow the road to the {area:228}."] = "O zepelim pousa nas torres do lado de fora das {area:153}. Ande para oeste pela estrada passando as ruínas e para o sul até {zone:1421}; siga a estrada até o {area:228}.",
	["Road to Silverpine"] = "Estrada para Pinhaprata",

	-- Step 8: Sepulcher
	-- {area:228} Sepulcher · {npc:2226} Karos Razok
	["{area:228} is the Forsaken crypt-town in the middle of the forest. Everyone you need stands around the crypt entrance; {npc:2226}, the bat handler, is just east of it."] = "{area:228} é a cidade-cripta dos Renegados no meio da floresta. Todos de quem você precisa ficam em volta da entrada da cripta; {npc:2226}, o adestrador de morcegos, fica logo a leste dela.",

	-- Step 9: Border Crossings
	-- {object:1627} Dalaran Crate
	["Follow the road south. The {object:1627} sits beside it, north of Pyrewood."] = "Siga a estrada para o sul. O {object:1627} fica ao lado dela, ao norte de Lenhardente.",

	-- Step 10: Sepulcher
	-- {area:233} Ambermill
	["{area:233} comes later, on the southern loop"] = "{area:233} vem depois, no circuito sul",

	-- Step 11: The Dead Field
	-- {area:228} Sepulcher · {npc:1983} Nightlash · {area:240} The Dead Field
	["North of the {area:228}. {npc:1983} haunts the {area:240}: kill it, then walk across the field."] = "Ao norte do {area:228}. {npc:1983} assombra o {area:240}: mate-o e depois atravesse o campo.",

	-- Step 12: Strange Lockbox
	-- {object:177790} Strange Lockbox · {area:240} The Dead Field · {item:15882} Half Pendant of Aquatic Endurance · {quest:30} Trial of the Sea Lion
	["The {object:177790} lies on the coast west of the {area:240}. It holds the {item:15882} for {quest:30}."] = "O {object:177790} fica na costa a oeste do {area:240}. Ele guarda a {item:15882} para {quest:30}.",

	-- Step 13: Malden's Orchard
	-- {area:238} Malden's Orchard
	["Follow the road north-east to the Yoricks' house at {area:238}."] = "Siga a estrada para nordeste até a casa dos Yorick no {area:238}.",

	-- Step 14: Escorting Erland
	-- {npc:1978} Deathstalker Erland · {npc:1950} Rane Yorick
	["{npc:1978} waits north-east of the house. Escort him back to {npc:1950}; worgs attack on the way."] = "{npc:1978} espera a nordeste da casa. Escolte-o de volta até {npc:1950}; worgs atacam no caminho.",

	-- Step 16: Worgs and murlocs
	["Worgs and murlocs"] = "Worgs e murlocs",
	-- plural, as words: Mottled Worgs = {npc:1766} Mottled Worg · Vile Fin Shredders = {npc:1767} Vile Fin Shredder
	["Mottled Worgs prowl the hills around the house. Then walk south along the lake shore: the Vile Fin Shredders and Tidehunters there drop the murloc eyes."] = "Worgs Mosqueados rondam as colinas em volta da casa. Depois ande para o sul pela margem do lago: os Retalhadores e Caçamarés Pinavil de lá deixam cair os olhos de murloc.",

	-- Step 17: Hearth to the Sepulcher
	-- {area:228} Sepulcher
	["Hearth to the {area:228}"] = "Regressar para o {area:228}",

	-- Step 18: The Decrepit Ferry
	-- {object:1593} Corpse Laden Boat · {area:228} Sepulcher
	["The {object:1593} lies at the ferry landing on the lake shore east of the {area:228}."] = "O {object:1593} fica no atracadouro da balsa na margem do lago a leste do {area:228}.",

	-- Step 20: The Ivar Patch
	-- {quest:425} Ivar the Foul
	["North again to the Yoricks' house. {quest:425} lurks a short walk west of it."] = "De novo ao norte até a casa dos Yorick. {quest:425} espreita a uma curta caminhada a oeste dela.",

	-- Step 21: Fenris Isle
	-- {area:172} Fenris Isle · {area:235} Fenris Keep
	["Follow the lake shore south-east and swim out to {area:172}. Rot Hide gnolls cover the island; every type drops ichor. Stay out of {area:235} on its north side unless you go for the optional niche: the gnolls there are level 18-22."] = "Siga a margem do lago para sudeste e nade até {area:172}. Gnolls Putricouro cobrem a ilha; todo tipo deixa cair linfa. Fique fora de {area:235}, no lado norte, a menos que vá ao nicho opcional: os gnolls lá são de nível 18-22.",
	-- {item:3317} A Talking Head
	["{item:3317}: a rare drop from the gnolls"] = "{item:3317}: item raro dos gnolls",
	-- {object:1599} Shallow Grave
	["{object:1599}, just east of the keep"] = "{object:1599}, logo a leste da fortaleza",
	-- {object:112888} Dusty Shelf
	["{object:112888}, inside the keep"] = "{object:112888}, dentro da fortaleza",

	-- Step 22: Sepulcher
	-- {area:228} Sepulcher
	["Swim back and follow the road west to the {area:228}."] = "Nade de volta e siga a estrada para oeste até o {area:228}.",
	-- {npc:2121} Shadow Priest Allister · {quest:516} Beren's Peril
	["{npc:2121}: {quest:516}, on the south loop"] = "{npc:2121}: {quest:516}, no circuito sul",
	-- {npc:1938} Dalar Dawnweaver · {quest:98298} Arugal's Folly
	["{npc:1938}: take it if he offers it; it may follow his {quest:98298} series, which the route does not run"] = "{npc:1938}: pegue-a se ele oferecer; ela pode vir depois da série {quest:98298} dele, que a rota não faz",

	-- Step 23: Ambermill
	-- {area:233} Ambermill · {npc:2120} Archmage Ataeric
	["South-east down the road to {area:233}. Protectors guard the outskirts and Mages the town; both drop pendants. Wizards and Watchers patrol the roads around it. Stay out of the middle, where {npc:2120} stands."] = "Para sudeste pela estrada até {area:233}. Protetoras guardam os arredores e Magos a cidade; ambos deixam cair pingentes. Teurgos e Vigias patrulham as estradas em volta. Fique longe do centro, onde {npc:2120} fica.",

	-- Step 24: Moonrage Bloodhowlers
	-- plural, as words: Moonrage Bloodhowlers = {npc:1924} Moonrage Bloodhowler
	["Moonrage Bloodhowlers"] = "Uivassangues Lunafúria",
	-- {npc:1938} Dalar Dawnweaver · {quest:98298} Arugal's Folly · {area:233} Ambermill · {item:280375} Worgen Bits
	["Only if {npc:1938} gave you {quest:98298}: the Bloodhowlers prowl the woods south-west of {area:233}, east of Pyrewood; they drop the {item:280375}."] = "Só se {npc:1938} lhe deu {quest:98298}: os Uivassangues rondam a mata a sudoeste de {area:233}, a leste de Lenhardente; eles deixam cair os {item:280375}.",

	-- Step 25: The refugees
	["The refugees"] = "Os refugiados",
	-- {area:230} Greymane Wall
	-- plural, as words: Haggard Refugees = {npc:2053} Haggard Refugee
	["The Sickly and Haggard Refugees shamble along the road south of Pyrewood toward the {area:230}."] = "Os Refugiados Adoentados e Famintos se arrastam pela estrada ao sul de Lenhardente rumo à {area:230}.",

	-- Step 26: Beren's Peril
	-- {quest:516} Beren's Peril
	-- plural, as words: Ravenclaw Drudgers = {npc:1974} Ravenclaw Drudger
	["North-east of the refugees, the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "A nordeste dos refugiados, os Mourejantes e Guardiões Corvinalle assombram as ruínas de {quest:516}, no sudeste da floresta.",

	-- Step 28: Lordamere Lake shore
	-- {area:1338} Lordamere Lake
	["{area:1338} shore"] = "Margem do {area:1338}",
	-- {area:237} Decrepit Ferry · {area:228} Sepulcher
	-- plural, as words: Vile Fin Lakestalkers = {npc:1909} Vile Fin Lakestalker
	["The Vile Fin Lakestalkers and Oracles sit on the lake shore south of the {area:237}, east of the {area:228}."] = "Os Espreita-Lagos e Oráculos Pinavil ficam na margem do lago ao sul da {area:237}, a leste do {area:228}.",
	-- {npc:1909} Vile Fin Lakestalker · {area:1338} Lordamere Lake · {zone:1421} Silverpine Forest
	["grind on {npc:1909} at {area:1338}, {zone:1421}"] = "farme {npc:1909} no {area:1338}, {zone:1421}",

	-- Step 29: Apothecary Renferrel
	-- {npc:2216} Apothecary Lydon · {area:272} Tarren Mill
	["Keep it: {npc:2216} in {area:272}, a later guide"] = "Guarde-o: {npc:2216} em {area:272}, num guia posterior",

	-- Step 30: Brill
	-- {zone:1420} Tirisfal Glades · {area:159} Brill · {npc:246152} Shari Stilwell
	["Follow the road north out of Silverpine into {zone:1420} and on to {area:159}: {npc:246152} trains Paladins there. The zeppelin towers are a short walk south down the road."] = "Siga a estrada para o norte saindo de Pinhaprata até {zone:1420} e continue até {area:159}: {npc:246152} treina Paladinos lá. As torres de zepelim ficam a uma curta caminhada para o sul pela estrada.",

	-- Step 31: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelim para {zone:1454}",
	-- {zone:1420} Tirisfal Glades · {area:153} Ruins of Lordaeron · {zone:1454} Orgrimmar
	["Follow the road north out of Silverpine into {zone:1420} and east to the zeppelin towers outside the {area:153}. Take the zeppelin to {zone:1454}."] = "Siga a estrada para o norte saindo de Pinhaprata até {zone:1420} e para leste até as torres de zepelim do lado de fora das {area:153}. Pegue o zepelim para {zone:1454}.",

	-- Step 32: Valley of Strength
	-- {npc:268701} Thatog · {object:172982} Valley of Strength (no name in this language: may be words) · {object:173016} Borstan's Firepit (no name in this language: may be words)
	["Walk in through the main gate. {npc:268701} stands in the {object:172982}; {object:173016} is a few steps north."] = "Entre pelo portão principal. {npc:268701} fica no {object:172982}; a {object:173016} fica alguns passos ao norte.",

	-- Step 33: Cleft of Shadow
	-- {object:172960} Cleft of Shadow (no name in this language: may be words) · {object:172982} Valley of Strength (no name in this language: may be words) · {npc:3216} Neeru Fireblade
	["The {object:172960} is the canyon under the {object:172982}; {npc:3216} stands at its far end."] = "O {object:172960} é o cânion sob o {object:172982}; {npc:3216} fica no fundo dele.",

	-- Step 34: The Drag
	-- {npc:3348} Kor'geld · {npc:3347} Yelmak · {npc:11046} Whuut
	["{npc:3348} and {npc:3347} run the alchemy shop in the Drag; {npc:11046} is next door."] = "{npc:3348} e {npc:3347} cuidam da loja de alquimia no Drag; {npc:11046} fica ao lado.",

	-- Step 35: Valley of Honor
	-- {object:172958} Valley of Honor (no name in this language: may be words)
	["The cattails and speargrass grow along the water in the {object:172958}, east of the Drag."] = "As taboas e o capim-lança crescem junto à água no {object:172958}, a leste do Drag.",

	-- Step 37: Valley of Wisdom
	-- {npc:268684} Thra · {npc:268682} Migi · {object:172957} Valley of Wisdom (no name in this language: may be words) · {npc:3310} Doras · {object:172982} Valley of Strength (no name in this language: may be words)
	-- plural, as words: Smooth Boulders = {item:277952} Smooth Boulder
	["{npc:268684} and {npc:268682} sit behind Grommash Hold in the {object:172957}; the Smooth Boulders lie around them. Train while you are in the city (Druids and Paladins have no trainer here). The next guide starts at {npc:3310}, the wind rider master in the {object:172982}."] = "{npc:268684} e {npc:268682} ficam sentados atrás da Fortaleza Grommash no {object:172957}; os Pedregulhos Lisos ficam em volta deles. Treine enquanto estiver na cidade (Druidas e Paladinos não têm instrutor aqui). O próximo guia começa com {npc:3310}, o mestre de mantícoras no {object:172982}.",
	-- {npc:4949} Thrall
	["{npc:4949}, inside Grommash Hold"] = "{npc:4949}, dentro da Fortaleza Grommash",
	-- {area:380} Crossroads
	["Keep it: Thork at the {area:380}"] = "Guarde-o: Thork na {area:380}",
	-- {npc:4949} Thrall · {quest:93739} Exploring the Horde
	["{npc:4949}: {quest:93739}, a tour of the Horde's leaders"] = "{npc:4949}: {quest:93739}, um passeio pelos líderes da Horda",
	-- {npc:3230} Nazgrel
	["Speak with {npc:3230}, in Grommash Hold"] = "Fale com {npc:3230}, na Fortaleza Grommash",
	-- {npc:10540} Vol'jin
	["Speak with {npc:10540}, in Grommash Hold"] = "Fale com {npc:10540}, na Fortaleza Grommash",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {area:228}"] = "{area:228}",
}
