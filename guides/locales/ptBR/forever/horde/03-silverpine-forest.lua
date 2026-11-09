-- Portuguese (Brazil) (ptBR): the guide forever/horde/03-silverpine-forest (forever/horde/03-silverpine-forest.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Orgrimmar
	-- {npc:3310} Doras · {object:172982} Valley of Strength (no name in this language: may be words) · {npc:268701} Thatog
	["Walk in by the main gate. {npc:3310}, the wind rider master, stands on the tower in the {object:172982}; {npc:268701} by the bank below it."] = "Entre pelo portão principal. {npc:3310}, o mestre de mantícoras, fica na torre em {object:172982}; {npc:268701} junto ao banco, logo abaixo.",

	-- Step 2: Borstan
	-- {object:173016} Borstan's Firepit (no name in this language: may be words)
	["{object:173016} is a few steps north."] = "{object:173016} fica a poucos passos ao norte.",

	-- Step 3: Neeru Fireblade
	-- {object:172960} Cleft of Shadow (no name in this language: may be words) · {object:172982} Valley of Strength (no name in this language: may be words) · {quest:829} Neeru Fireblade
	["The {object:172960} is the canyon under the {object:172982}; {quest:829} stands at its far end."] = "O {object:172960} é o cânion sob o {object:172982}; {quest:829} fica no fundo dele.",

	-- Step 4: The Drag
	-- {npc:3348} Kor'geld · {npc:3347} Yelmak · {npc:11046} Whuut
	["{npc:3348} and {npc:3347} run the alchemy shop in the Drag; {npc:11046} is next door."] = "{npc:3348} e {npc:3347} cuidam da loja de alquimia no Drag; {npc:11046} fica ao lado.",

	-- Step 5: Valley of Honor
	-- {object:172958} Valley of Honor (no name in this language: may be words)
	["The cattails and speargrass grow along the water in the {object:172958}, east of the Drag."] = "As taboas e o capim-lança crescem junto à água no {object:172958}, a leste do Drag.",

	-- Step 6: Class trainer
	["Class trainer"] = "Instrutor de classe",
	["Train while you are in the city: Druids and Paladins have no trainer here."] = "Treine enquanto estiver na cidade: Druidas e Paladinos não têm instrutor aqui.",

	-- Step 7: Sayoc
	-- {spell:197} Two-Handed Axes · {npc:11868} Sayoc · {object:172958} Valley of Honor (no name in this language: may be words)
	["While you're here: learn {spell:197} from {npc:11868} ({object:172958}, 10 silver); two-handers level a Warrior fastest."] = "Já que está aqui: aprenda {spell:197} com {npc:11868} ({object:172958}, 10 pratas); arma de duas mãos é o jeito mais rápido de upar Guerreiro.",

	-- Step 8: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor (no name in this language: may be words)
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "Já que está aqui: aprenda Cajados com {npc:2704} ({object:172958}, 10 pratas); a arma corpo a corpo do Caçador vale pelos atributos, e as de duas mãos são as que mais trazem.",

	-- Step 9: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor (no name in this language: may be words)
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "Já que está aqui: aprenda Cajados com {npc:2704} ({object:172958}, 10 pratas); enquanto você sobe de nível, um cajado traz mais atributos de feitiço que uma arma de uma mão.",

	-- Step 12: Valley of Wisdom
	-- {npc:268684} Thra · {npc:268682} Migi · {object:172957} Valley of Wisdom (no name in this language: may be words)
	-- plural, as words: Smooth Boulders = {item:277952} Smooth Boulder
	["{npc:268684} and {npc:268682} sit behind Grommash Hold in the {object:172957}; the Smooth Boulders lie around them."] = "{npc:268684} e {npc:268682} ficam atrás da Fortaleza Grommash, em {object:172957}; os Pedregulhos Lisos estão em volta deles.",

	-- Step 13: Thrall
	-- {npc:4949} Thrall · {quest:98024} Journey to the Crossroads · {quest:93739} Exploring the Horde · {quest:95350} Welcome to Azeroth
	["{npc:4949} stands in Grommash Hold. He offers {quest:98024} and {quest:93739} once {quest:95350} is handed in."] = "{npc:4949} fica na Fortaleza Grommash. Ele oferece {quest:98024} e {quest:93739} depois que você entregar {quest:95350}.",
	-- {npc:4949} Thrall
	["{npc:4949}, inside Grommash Hold"] = "{npc:4949}, dentro da Fortaleza Grommash",
	-- {npc:4949} Thrall · {zone:1413} Barrens
	["{npc:4949}: keep it, Thork at the Crossroads in the {zone:1413} guide"] = "{npc:4949}: guarde, Thork na Encruzilhada, no guia de {zone:1413}",
	-- {npc:4949} Thrall · {quest:93739} Exploring the Horde
	["{npc:4949}: {quest:93739}, a tour of the Horde's leaders"] = "{npc:4949}: {quest:93739}, um passeio pelos líderes da Horda",
	-- {npc:3230} Nazgrel
	["Speak with {npc:3230}, in Grommash Hold"] = "Fale com {npc:3230}, na Fortaleza Grommash",
	-- {npc:3230} Nazgrel
	["Talk to {npc:3230}"] = "Fale com {npc:3230}",
	-- {npc:10540} Vol'jin
	["Speak with {npc:10540}, in Grommash Hold"] = "Fale com {npc:10540}, na Fortaleza Grommash",
	-- {npc:10540} Vol'jin
	["Talk to {npc:10540}"] = "Fale com {npc:10540}",

	-- Step 14: Nazgrel
	-- {npc:3230} Nazgrel
	["{npc:3230}, in Grommash Hold"] = "{npc:3230}, na Fortaleza Grommash",

	-- Step 15: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zepelim para {zone:1458}",

	-- Step 16: Brill
	-- {area:159} Brill · {npc:1738} Deathguard Terrence · {npc:1518} Apothecary Johaan
	["{area:159} is a short walk north up the road from the zeppelin towers: {npc:1738} stands by the road into town, {npc:1518} in the apothecary's house on the west side of the square."] = "{area:159} fica a uma caminhada curta ao norte pela estrada, saindo das torres do zepelim: {npc:1738} fica junto à estrada de entrada da cidade e {npc:1518}, na casa do boticário, no lado oeste da praça.",
	-- {npc:1518} Apothecary Johaan
	["{npc:1518}, inside"] = "{npc:1518}, lá dentro",

	-- Step 17: Hadric Harlson
	-- {npc:1495} Deathguard Linnea · {npc:267009} Hadric Harlson
	["Back down the road past the zeppelin towers and east to {npc:1495}'s camp: {npc:267009} stands beside her."] = "De volta pela estrada, passando as torres do zepelim, e a leste até o acampamento de {npc:1495}: {npc:267009} fica ao lado dela.",

	-- Step 18: The Cult of the Damned
	-- {npc:267009} Hadric Harlson
	-- plural, as words: Dark Neophytes = {npc:267006} Dark Neophyte · Dark Enforcers = {npc:275437} Dark Enforcer · Necrotic Crystal Fragments = {item:275851} Necrotic Crystal Fragment
	["The cultists camp a short walk south-east of {npc:267009}. Dark Neophytes and Dark Enforcers drop the Necrotic Crystal Fragments; more fragments, black crystals, lie on the ground among the tents."] = "Os sectários acampam a uma caminhada curta a sudeste de {npc:267009}. Os Neófitos Sombrios e os Impositores Sombrios deixam cair os Fragmentos de Cristal Necrótico; há mais fragmentos, cristais negros, no chão entre as tendas.",

	-- Step 20: Brill
	-- {npc:246152} Shari Stilwell · {area:159} Brill
	["{npc:246152} trains Paladins in {area:159}, a short walk north up the road from the zeppelin towers. Come back down the same road for Silverpine."] = "{npc:246152} treina Paladinos em {area:159}, a uma curta caminhada para o norte pela estrada a partir das torres de zepelim. Volte pela mesma estrada para Pinhaprata.",

	-- Step 22: The Sepulcher
	-- {area:228} The Sepulcher · {npc:2226} Karos Razok
	["{area:228} is the Forsaken crypt-town in the middle of the forest. Everyone you need stands around the crypt entrance; {npc:2226}, the bat handler, is just east of it."] = "{area:228} é a cidade-cripta dos Renegados no meio da floresta. Todos de quem você precisa ficam em volta da entrada da cripta; {npc:2226}, o adestrador de morcegos, fica logo a leste dela.",
	-- {npc:1952} High Executor Hadrec
	["{npc:1952}, below ground"] = "{npc:1952}, no subterrâneo",

	-- Step 24: Border Crossings
	-- {object:1627} Dalaran Crate
	["Follow the road south. The {object:1627} sits beside it, north of Pyrewood."] = "Siga a estrada para o sul. O {object:1627} fica ao lado dela, ao norte de Lenhardente.",

	-- Step 25: The Dead Field
	-- {area:228} The Sepulcher · {npc:1983} Nightlash · {area:240} The Dead Field
	["North of the {area:228}. {npc:1983} haunts the {area:240}: kill it, then walk across the field."] = "Ao norte do {area:228}. {npc:1983} assombra o {area:240}: mate-o e depois atravesse o campo.",

	-- Step 26: Malden's Orchard
	-- {area:238} Malden's Orchard
	["Follow the road north-east to the Yoricks' house at {area:238}."] = "Siga a estrada para nordeste até a casa dos Yorick no {area:238}.",

	-- Step 27: Mottled Worgs
	-- plural, as words: Mottled Worgs = {npc:1766} Mottled Worg
	["Mottled Worgs"] = "Worgs Mosqueados",
	-- plural, as words: Mottled Worgs = {npc:1766} Mottled Worg
	["Mottled Worgs prowl the hills around the house."] = "Worgs Mosqueados rondam as colinas em volta da casa.",

	-- Step 28: Escorting Erland
	-- {npc:1978} Deathstalker Erland · {npc:1950} Rane Yorick
	["{npc:1978} waits north-east of the house. Escort him back to {npc:1950}; worgs attack on the way."] = "{npc:1978} espera a nordeste da casa. Escolte-o de volta até {npc:1950}; worgs atacam no caminho.",
	-- {npc:1978} Deathstalker Erland
	["{npc:1978}, inside"] = "{npc:1978}, lá dentro",

	-- Step 31: The Sepulcher
	-- {npc:1938} Dalar Dawnweaver · {area:227} Valgan's Field
	["{npc:1938}: his books lie in the {area:227} farmhouse, on the walk north"] = "{npc:1938}: os livros dele ficam na casa da fazenda de {area:227}, na caminhada para o norte",
	-- {npc:1937} Apothecary Renferrel · {zone:1458} Undercity
	["{npc:1937}: Zinge in the {zone:1458}, on the way to the zeppelin at the end"] = "{npc:1937}: Zilda em {zone:1458}, no caminho para o zepelim, no fim",
	-- {area:233} Ambermill
	["{area:233} comes later, down the lake shore"] = "{area:233} vem depois, descendo pela margem do lago",

	-- Step 32: Valgan's Field farmhouse
	-- {area:227} Valgan's Field
	["{area:227} farmhouse"] = "Casa da fazenda de {area:227}",
	-- {area:227} Valgan's Field · {object:1571} Dusty Spellbooks · {npc:1770} Moonrage Darkrunner
	["On the road north, the farmhouse at {area:227}: go upstairs, the {object:1571} lie on the floor in the back room. Looting them brings a {npc:1770}."] = "Na estrada para o norte, a casa da fazenda em {area:227}: suba, os {object:1571} estão no chão do quarto dos fundos. Saquear os livros traz um {npc:1770}.",
	-- {object:1571} Dusty Spellbooks
	["{object:1571}; upstairs"] = "{object:1571}; no andar de cima",

	-- Step 33: Quinn Yorick
	["North again to the Yoricks' house."] = "De novo ao norte até a casa dos Yorick.",
	-- {npc:1951} Quinn Yorick
	["{npc:1951}, inside"] = "{npc:1951}, lá dentro",

	-- Step 34: Vile Fin murlocs
	["Vile Fin murlocs"] = "Murlocs Pinavil",
	-- plural, as words: Vile Fin Shredders = {npc:1767} Vile Fin Shredder
	["Follow the lake shore south-east from the Yoricks' house: the Vile Fin Shredders and Tidehunters along it drop the murloc eyes."] = "Siga a margem do lago para o sudeste a partir da casa dos Yorick: os Retalhadores Pinavil e os Caçamarés que andam por ela soltam os olhos de murloc.",

	-- Step 35: The Decrepit Ferry
	-- {object:1593} Corpse Laden Boat · {area:233} Ambermill
	["Follow the lake shore south from the murlocs: the {object:1593} lies at the ferry landing, on the way to {area:233}."] = "Siga a margem do lago para o sul, saindo dos murlocs: {object:1593} fica no embarcadouro da balsa, a caminho de {area:233}.",

	-- Step 36: Ambermill
	-- {area:233} Ambermill · {npc:2120} Archmage Ataeric
	["Keep south along the shore from the ferry to {area:233}. Protectors guard the outskirts and Mages the town; both drop pendants. Stay out of the middle, where {npc:2120} stands."] = "Continue ao sul pela margem, saindo da balsa, até {area:233}. Protetoras guardam a periferia e Magos a cidade; ambos deixam cair pingentes. Fique longe do meio, onde fica {npc:2120}.",

	-- Step 37: The Sepulcher
	-- {area:228} The Sepulcher
	["Back north-west up the road to the {area:228}."] = "De volta ao noroeste pela estrada, até {area:228}.",
	-- {npc:1937} Apothecary Renferrel
	["{npc:1937}: for Quinn, on the road north at the end"] = "{npc:1937}: para o Quintino, na estrada ao norte, no final",
	-- {npc:1938} Dalar Dawnweaver
	["{npc:1938}, just north of Allister"] = "{npc:1938}, logo ao norte de Allister",
	-- {npc:1499} Magistrate Sevren · {area:159} Brill
	["{npc:1499} in {area:159}, on the way to the zeppelin at the end"] = "{npc:1499} em {area:159}, a caminho do zepelim no fim",

	-- Step 38: The Ivar Patch
	-- {zone:1420} Tirisfal Glades · {area:238} Malden's Orchard · {quest:425} Ivar the Foul
	["Take the road north toward {zone:1420}: the Yoricks' house at {area:238} is on the way. {quest:425} lurks a short walk west of it."] = "Pegue a estrada para o norte rumo a {zone:1420}: a casa dos Yorick, em {area:238}, fica no caminho. {quest:425} espreita a uma curta caminhada a oeste dela.",
	["Inside"] = "Lá dentro",

	-- Step 40: Magistrate Sevren
	-- {area:159} Brill · {npc:1499} Magistrate Sevren
	["{area:159} is a short walk north up the road from the zeppelin towers; {npc:1499} is in the town hall."] = "{area:159} fica a uma curta caminhada para o norte pela estrada, saindo das torres do zepelim; {npc:1499} está na prefeitura.",

	-- Step 42: The Undercity
	-- {object:1661} The Undercity (no name in this language: may be words) · {area:153} Ruins of Lordaeron · {npc:2050} Raleigh Andrean · {npc:7683} Alessandro Luca · {npc:11044} Doctor Martin Felben · {npc:5204} Apothecary Zinge · {npc:2055} Master Apothecary Faranell
	["{object:1661} lies under the {area:153}, beside the zeppelin towers. {npc:2050} stands at the inn by the way down; {npc:7683} on the way down to the Apothecarium, where {npc:11044} and {npc:5204} stand beside {npc:2055}."] = "{object:1661} fica sob {area:153}, ao lado das torres dos zepelins. {npc:2050} fica na estalagem, junto à descida; {npc:7683} na descida para o Apothecarium, onde {npc:11044} e {npc:5204} ficam ao lado de {npc:2055}.",
	-- {npc:11044} Doctor Martin Felben
	["{npc:11044}, in the Apothecarium"] = "{npc:11044}, no Apothecarium",
	-- {npc:5204} Apothecary Zinge
	["{npc:5204}, in the Apothecarium"] = "{npc:5204}, no Apothecarium",
	-- {npc:5204} Apothecary Zinge
	["{npc:5204}: Helbrim at the Crossroads, in the next guide"] = "{npc:5204}: Hermógenes na Encruzilhada, no próximo guia",
	-- {npc:260093} Garen Largo · {area:1497} Undercity
	["{npc:260093}, the {area:1497}'s paladin trainer"] = "{npc:260093}, o treinador de paladinos da {area:1497}",

	-- Step 43: Lady Sylvanas Windrunner
	-- {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter (no name in this language: may be words)
	["{npc:10181} holds court in the {object:36126}."] = "{npc:10181} despacha em {object:36126}.",
	-- {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter (no name in this language: may be words) · {quest:93739} Exploring the Horde
	["Speak with {npc:10181}, in the {object:36126}: {quest:93739}"] = "Fale com {npc:10181}, no {object:36126}: {quest:93739}",
	-- {npc:10181} Lady Sylvanas Windrunner
	["Talk to {npc:10181}"] = "Fale com {npc:10181}",

	-- Step 44: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelim para {zone:1454}",

	-- Step 45: Orgrimmar
	-- {zone:1454} Orgrimmar · {object:172982} Valley of Strength (no name in this language: may be words)
	["{zone:1454}'s {object:172982}"] = "",

	-- Step 46: Valley of Strength
	-- {npc:268701} Thatog · {object:172982} Valley of Strength (no name in this language: may be words)
	["Walk in through the main gate. {npc:268701} stands in the {object:172982}."] = "Entre pelo portão principal. {npc:268701} fica em {object:172982}.",

	-- Step 52: Sayoc
	-- {spell:197} Two-Handed Axes · {npc:11868} Sayoc · {object:172958} Valley of Honor (no name in this language: may be words)
	["While you're here: learn {spell:197} from {npc:11868} ({object:172958}, 10 silver); two-handers level a Paladin fastest."] = "Já que está aqui: aprenda {spell:197} com {npc:11868} ({object:172958}, 10 pratas); arma de duas mãos é o jeito mais rápido de upar Paladino.",

	-- Step 54: Valley of Wisdom
	-- {npc:268684} Thra · {npc:268682} Migi · {object:172957} Valley of Wisdom (no name in this language: may be words) · {area:379} Far Watch Post
	-- plural, as words: Smooth Boulders = {item:277952} Smooth Boulder
	["{npc:268684} and {npc:268682} sit behind Grommash Hold in the {object:172957}; the Smooth Boulders lie around them. Train while you are in the city (Druids and Paladins have no trainer here). The next guide walks from here to {area:379} and the Crossroads."] = "{npc:268684} e {npc:268682} ficam atrás da Fortaleza Grommash, em {object:172957}; os Pedregulhos Lisos estão em volta deles. Treine enquanto estiver na cidade (Druidas e Paladinos não têm instrutor aqui). O próximo guia vai daqui até {area:379} e a Encruzilhada.",

	-- Step 55: Zor Lonetree
	-- {npc:4047} Zor Lonetree · {npc:4049} Seereth Stonebreak
	["{npc:4047}: {npc:4049}, on the road into Stonetalon in the next guide"] = "{npc:4047}: {npc:4049}, na estrada que entra em Torres de Pedra, no próximo guia",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At the {area:2362}"] = "Em {area:2362}",
	-- ["Cast {spell:18960}; {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Lance {spell:18960}; {npc:11802} está em {area:2361}. Os Adornos de Altar ficam no fundo de {area:656} e somem em poucos minutos: nade com um direto até {area:2362} na margem noroeste, use-o lá e fale com {npc:11799}.",
	-- ["Druid trainer"] = "Instrutor de druida",
	-- ["Fly to {area:1638}: {npc:3033} trains you on {area:1639}. Skyborne: fly back to {zone:1454} for the zeppelin afterwards."] = "Voe até {area:1638}: {npc:3033} treina você no {area:1639}. Nascido nos Céus: depois, voe de volta a {zone:1454} para o zepelim.",
	-- ["Follow the lake shore south-east and swim out to {area:172}. Rot Hide gnolls cover the island; every type drops ichor. Stay out of {area:235} on its north side unless you go for the optional niche: the gnolls there are level 18-22."] = "Siga a margem do lago para sudeste e nade até {area:172}. Gnolls Putricouro cobrem a ilha; todo tipo deixa cair linfa. Fique fora de {area:235}, no lado norte, a menos que vá ao nicho opcional: os gnolls lá são de nível 18-22.",
	-- ["Follow the lake shore south-east toward {area:172}: the Vile Fin Shredders and Tidehunters along it drop the murloc eyes."] = "Siga a margem do lago para sudeste rumo a {area:172}: os Retalhadores e Caçamarés Pinavil ao longo dela deixam cair os olhos de murloc.",
	-- ["Follow the road north out of Silverpine into {zone:1420} and east to the zeppelin towers outside the {area:153}. Take the zeppelin to {zone:1454}."] = "Siga a estrada para o norte saindo de Pinhaprata até {zone:1420} e para leste até as torres de zepelim do lado de fora das {area:153}. Pegue o zepelim para {zone:1454}.",
	-- ["Follow the road north out of Silverpine into {zone:1420} and on to {area:159}: {npc:246152} trains Paladins there. The zeppelin towers are a short walk south down the road."] = "Siga a estrada para o norte saindo de Pinhaprata até {zone:1420} e continue até {area:159}: {npc:246152} treina Paladinos lá. As torres de zepelim ficam a uma curta caminhada para o sul pela estrada.",
	-- ["From the {area:380}, follow the road north-east to {area:1637} and walk in by the main gate. {npc:3310}, the wind rider master, stands on the tower in the {object:172982}."] = "Da {area:380}, siga a estrada para nordeste até {area:1637} e entre pelo portão principal. {npc:3310}, o mestre de mantícoras, fica na torre do {object:172982}.",
	-- ["Hearth to the {area:228}"] = "Regressar para o {area:228}",
	-- ["Into Silverpine"] = "Rumo a Pinhaprata",
	-- ["Keep it: Thork at the {area:380}"] = "Guarde-o: Thork na {area:380}",
	-- ["Keep it: {npc:2216} in {area:272}, a later guide"] = "Guarde-o: {npc:2216} em {area:272}, num guia posterior",
	-- ["Moonrage Bloodhowlers"] = "Uivassangues Lunafúria",
	-- ["Mottled Worgs prowl the hills around the house. Then walk south along the lake shore: the Vile Fin Shredders and Tidehunters there drop the murloc eyes."] = "Worgs Mosqueados rondam as colinas em volta da casa. Depois ande para o sul pela margem do lago: os Retalhadores e Caçamarés Pinavil de lá deixam cair os olhos de murloc.",
	-- ["North again to the Yoricks' house. {quest:425} lurks a short walk west of it."] = "De novo ao norte até a casa dos Yorick. {quest:425} espreita a uma curta caminhada a oeste dela.",
	-- ["North-east of the refugees, the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "A nordeste dos refugiados, os Mourejantes e Guardiões Corvinalle assombram as ruínas de {quest:516}, no sudeste da floresta.",
	-- ["Only if {npc:1938} gave you {quest:98298}: the Bloodhowlers prowl the woods south-west of {area:233}, east of Pyrewood; they drop the {item:280375}."] = "Só se {npc:1938} lhe deu {quest:98298}: os Uivassangues rondam a mata a sudoeste de {area:233}, a leste de Lenhardente; eles deixam cair os {item:280375}.",
	-- ["Paladin trainer"] = "Instrutor de paladino",
	-- ["Road to Silverpine"] = "Estrada para Pinhaprata",
	-- ["South-east down the road to {area:233}. Protectors guard the outskirts and Mages the town; both drop pendants. Wizards and Watchers patrol the roads around it. Stay out of the middle, where {npc:2120} stands."] = "Para sudeste pela estrada até {area:233}. Protetoras guardam os arredores e Magos a cidade; ambos deixam cair pingentes. Teurgos e Vigias patrulham as estradas em volta. Fique longe do centro, onde {npc:2120} fica.",
	-- ["South-west of Ambermill, the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "A sudoeste de Lenhâmbar, os Mourejantes e Guardiões Corvinalle assombram as ruínas de {quest:516}, no sudeste da floresta.",
	-- ["Swim back and follow the road west to the {area:228}."] = "Nade de volta e siga a estrada para oeste até o {area:228}.",
	-- ["Take the road north toward {area:85}: the Yoricks' house at {area:238} is on the way. {quest:425} lurks a short walk west of it."] = "Pegue a estrada para o norte rumo a {area:85}: a casa dos Yorick, em {area:238}, fica no caminho. {quest:425} espreita a uma curta caminhada a oeste dela.",
	-- ["The Sickly and Haggard Refugees shamble along the road south of Pyrewood toward the {area:230}."] = "Os Refugiados Adoentados e Famintos se arrastam pela estrada ao sul de Lenhardente rumo à {area:230}.",
	-- ["The Vile Fin Lakestalkers and Oracles sit on the lake shore south of the {area:237}, east of the {area:228}."] = "Os Espreita-Lagos e Oráculos Pinavil ficam na margem do lago ao sul da {area:237}, a leste do {area:228}.",
	-- ["The refugees"] = "Os refugiados",
	-- ["The zeppelin lands at the towers outside the {area:153}. Walk west along the road past the ruins and south into {zone:1421}; follow the road to the {area:228}."] = "O zepelim pousa nas torres do lado de fora das {area:153}. Ande para oeste pela estrada passando as ruínas e para o sul até {zone:1421}; siga a estrada até o {area:228}.",
	-- ["The zeppelin towers stand just outside {zone:1454}'s main gate. Take the zeppelin to {zone:1420} (the other one goes to {object:3202})."] = "As torres de zepelim ficam logo fora do portão principal de {zone:1454}. Pegue o zepelim para {zone:1420} (o outro vai para {object:3202}).",
	-- ["The {area:228}"] = "{area:228}",
	-- ["The {object:1593} lies at the ferry landing on the lake shore east of the {area:228}."] = "O {object:1593} fica no atracadouro da balsa na margem do lago a leste do {area:228}.",
	-- ["The {object:177790} lies on the coast west of the {area:240}. It holds the {item:15882} for Trial of the Sea Lion."] = "O {object:177790} fica na costa a oeste do {area:240}. Ele guarda a {item:15882} para Missão do leão marinho.",
	-- ["To {area:1637}"] = "Até {area:1637}",
	-- ["Walk in through the main gate. {npc:268701} stands in the {object:172982}; {object:173016} is a few steps north."] = "Entre pelo portão principal. {npc:268701} fica no {object:172982}; a {object:173016} fica alguns passos ao norte.",
	-- ["Worgs and murlocs"] = "Worgs e murlocs",
	-- ["Zeppelin to {zone:1420}"] = "Zepelim para {zone:1420}",
	-- ["Zeppelin tower"] = "Torre de zepelim",
	-- ["grind on {npc:1909} at {area:1338}, {zone:1421}"] = "farme {npc:1909} no {area:1338}, {zone:1421}",
	-- ["{area:1338} shore"] = "Margem do {area:1338}",
	-- ["{area:233} comes later, on the southern loop"] = "{area:233} vem depois, no circuito sul",
	-- ["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}, de um {object:177785} no lago",
	-- ["{item:3317}: a rare drop from the gnolls"] = "{item:3317}: item raro dos gnolls",
	-- ["{npc:11798} in {area:2361} flies druids there; then fly on to {zone:1454} for the zeppelin"] = "{npc:11798}, em {area:2361}, leva druidas voando até lá; depois voe até {zone:1454} para o zepelim",
	-- ["{npc:11799}, at the {area:2362}"] = "{npc:11799}, no {area:2362}",
	-- ["{npc:1938}: take it if he offers it; it may follow his {quest:98298} series, which the route does not run"] = "{npc:1938}: pegue-a se ele oferecer; ela pode vir depois da série {quest:98298} dele, que a rota não faz",
	-- ["{npc:2121}: {quest:516}, on the south loop"] = "{npc:2121}: {quest:516}, no circuito sul",
	-- ["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{npc:246344} em {zone:1456}; {zone:1454} não tem instrutor de paladino",
	-- ["{npc:268684} and {npc:268682} sit behind Grommash Hold in the {object:172957}; the Smooth Boulders lie around them. Train while you are in the city (Druids and Paladins have no trainer here). The next guide starts at {npc:3310}, the wind rider master in the {object:172982}."] = "{npc:268684} e {npc:268682} ficam sentados atrás da Fortaleza Grommash no {object:172957}; os Pedregulhos Lisos ficam em volta deles. Treine enquanto estiver na cidade (Druidas e Paladinos não têm instrutor aqui). O próximo guia começa com {npc:3310}, o mestre de mantícoras no {object:172982}.",
	-- ["{npc:3034} in {zone:1412}; {zone:1454} has no druid trainer"] = "{npc:3034} em {zone:1412}; {zone:1454} não tem instrutor de druida",
	-- ["{npc:6018} stands in the {object:172961} on the city's west side."] = "{npc:6018} fica no {object:172961}, no lado oeste da cidade.",
	-- ["{object:112888}, inside the keep"] = "{object:112888}, dentro da fortaleza",
	-- ["{object:1599}, just east of the keep"] = "{object:1599}, logo a leste da fortaleza",
	-- ["{quest:6127}: {area:384}, next guide"] = "{quest:6127}: {area:384}, próximo guia",
	-- ["{zone:1454} class quests"] = "Missões de classe em {zone:1454}",
}
