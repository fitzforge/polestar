-- Portuguese (Brazil) (ptBR): the guide forever/alliance/50-60/02-felwood (forever/alliance/50-60/02-felwood.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Felwood
	-- {area:3137} Talrendis Point · {area:2358} Forest Song · {zone:1448} Felwood · {area:2479} Emerald Sanctuary · {zone:1440} Ashenvale
	["From {area:3137} ride west along the road past {area:2358}, then north-west into {zone:1448}: the {area:2479} is the druids' camp on the road just past the {zone:1440} border."] = "",
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 2: The Emerald Sanctuary
	-- {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["The {area:2479} is the druids' camp by the road in southern {zone:1448}."] = "",
	-- {npc:9528} Arathandris Silversky · {npc:11554} Grazle
	["{npc:9528}, in the ruins just east of {npc:11554}"] = "{npc:9528}, nas ruínas logo a leste de {npc:11554}",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "{npc:9116}, lá dentro",
	-- {npc:10920} Kelek Skykeeper · {quest:86577} A Sampling of Putrescence · {zone:1448} Felwood
	["{npc:10920}: {quest:86577}, from the bears and wolves you meet in {zone:1448}"] = "{npc:10920}: {quest:86577}, dos ursos e lobos que encontrar em {zone:1448}",

	-- Step 3: Grazle
	-- {npc:11554} Grazle · {area:2479} Emerald Sanctuary
	["{npc:11554} the furbolg stands by the road just south of the {area:2479}."] = "{npc:11554}, o furbolg, fica junto à estrada, logo ao sul de {area:2479}.",

	-- Step 4: Deadwood Village
	-- {npc:11554} Grazle · {npc:15395} Nafien
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	-- was: ["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop."] = "Os furbolgs de Lenha Morta vivem na aldeia logo a sudoeste de {npc:11554}; guarde as Penas do Cocar de Lenha Morta que eles deixam cair."
	["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop: {npc:11554} and {npc:15395} each take five."] = "",

	-- Step 5: Grazle
	-- {npc:15395} Nafien · {zone:1448} Felwood
	["{npc:15395} waits at the north end of {zone:1448}"] = "{npc:15395} espera no extremo norte de {zone:1448}",

	-- Step 6: Jadefire Glen
	-- {npc:9454} Xavathras · {spell:7992} Slowing Poison
	-- plural, as words: Jadefire Shadowstalkers = {npc:7110} Jadefire Shadowstalker · Cursed Oozes = {npc:7086} Cursed Ooze
	["The Jadefire satyrs hold the glen west of the road, with {npc:9454} at its back.\nCareful: Jadefire Shadowstalkers (level 51-52) use Sneak and {spell:7992} and are stealthed, so they often join fights uninvited.\nCursed Oozes slide about the glen's streams: kill them and use Laris's Empty Ooze Jar on their remains."] = "Os sátiros Flamejade dominam o vale a oeste da estrada, com {npc:9454} nos fundos.\nCuidado: os Assombrantes Flamejade (nível 51-52) usam Furtividade e {spell:7992} e ficam furtivos, então costumam entrar nas lutas sem serem chamados.\nGosmas Amaldiçoadas deslizam pelos riachos do vale: mate-as e use o Laris's Empty Ooze Jar nos restos delas.",

	-- Step 7: Ruins of Constellas
	-- {npc:9454} Xavathras · {area:2481} Ruins of Constellas
	["Careful: {npc:9454} (54) stands at the back of the {area:2481}, at about 32.2,67.1, with Shadowstalkers around him: clear them one at a time, then pull him alone at full health."] = "Cuidado: {npc:9454} (54) fica no fundo de {area:2481}, por volta de 32.2,67.1, com Espreitadores Sombrios ao redor: elimine-os um de cada vez e depois puxe-o sozinho com a vida cheia.",

	-- Step 8: Jaedenar
	-- {area:1763} Jaedenar · {npc:11141} Spirit of Trey Lightforge
	["{area:1763} is the ruined temple north of the glen.\nCareful: the {npc:11141} (53, elite) haunts the west end of {area:1763}, around 35,60: work the south-east, where the arrow points, and pull the cultists and hounds away from him."] = "",
	-- {item:11949} Filled Tainted Ooze Jar · {area:1763} Jaedenar
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["{item:11949}: Tainted Oozes slide about {area:1763}'s fel pools"] = "{item:11949}: Gosmas Maculadas deslizam pelas poças vis de {area:1763}",

	-- Step 9: Putrescent organs: kill these as you meet them
	["Putrescent organs: kill these as you meet them"] = "Órgãos pútridos: mate estes conforme os encontrar",
	-- {zone:1448} Felwood · {npc:10920} Kelek Skykeeper · {area:1763} Jaedenar
	["{zone:1448}'s Angerclaw bears and Felpaw wolves carry the putrescent organs {npc:10920} wants: the Bears and Wolves (47-48) of the south and the Maulers and Scavengers (49-50) along the road north of {area:1763}. Kill them as you ride between the stops."] = "Os ursos Garrafúria e os lobos Patavil de {zone:1448} carregam os órgãos pútridos que {npc:10920} quer: os Ursos e Lobos (47-48) do sul e os Espancadores e Carniceiros (49-50) ao longo da estrada ao norte de {area:1763}. Mate-os enquanto cavalga entre as paradas.",

	-- Step 11: Shatter Scar Vale
	-- {npc:7136} Infernal Sentry
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["Follow the road north to the cratered vale and walk to each crater, killing the Entropic Beasts and Horrors between them.\nCareful: an {npc:7136} (53, elite) stands among the craters: walk round it."] = "Siga a estrada para o norte até o vale de crateras e vá até cada cratera, matando as Feras Entrópicas e os Horrores entre elas.\nCuidado: uma {npc:7136} (53, elite) fica entre as crateras: contorne-a.",
	["First crater"] = "Primeira cratera",
	["Second crater"] = "Segunda cratera",
	["Third crater"] = "Terceira cratera",

	-- Step 12: Irontree Woods
	-- {area:1767} Irontree Woods · {area:2618} Jadefire Run · {item:11503} Blood Amber
	["The Warpwood treants of {area:1767}, east of {area:2618}, carry the {item:11503}."] = "Os arvorosos Lenhatorta de {area:1767}, a leste de {area:2618}, carregam {item:11503}.",
	["Below ground"] = "No subterrâneo",

	-- Step 13: Jadefire Run: kill these as you meet them
	-- {area:2618} Jadefire Run
	["{area:2618}: kill these as you meet them"] = "{area:2618}: vá matando estes pelo caminho",
	-- {area:2618} Jadefire Run · {npc:10648} Xavaric · {quest:939} Flute of Xavaric · {item:11674} Jadefire Felbind
	["{area:2618} is the satyr valley in the north-west, with {npc:10648} at its far end. He drops the {quest:939}; every Jadefire satyr can drop {item:11674}.\nCareful: {npc:10648} (55) stands at the valley's far end with Hellcallers (53-54) around him: clear them one at a time before you pull him."] = "{area:2618} é o vale dos sátiros no noroeste, com {npc:10648} no fundo. Ele deixa cair {quest:939}; todo sátiro Flamejade pode deixar cair {item:11674}.\nCuidado: {npc:10648} (55) fica no fundo do vale com Invocadores Infernais (53-54) ao redor: elimine-os um de cada vez antes de puxá-lo.",

	-- Step 14: Jaedenar again
	-- {area:1763} Jaedenar
	["{area:1763} again"] = "{area:1763} de novo",
	-- {item:12922} Empty Canteen · {area:1763} Jaedenar
	["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}."] = "Use {item:12922} no poço lunar corrompido no meio de {area:1763}.",

	-- Step 15: The Emerald Sanctuary
	-- {area:1763} Jaedenar · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Ride south-east from {area:1763} to the {area:2479}, the druids' camp by the road in southern {zone:1448}."] = "Siga para sudeste, de {area:1763} até {area:2479}, o acampamento dos druidas junto à estrada, no sul de {zone:1448}.",

	-- Step 16: The Emerald Sanctuary
	-- {zone:1457} Darnassus
	["The vial is filled in {zone:1457}, later in this guide: keep it; inside"] = "",
	-- {area:392} Ratchet
	["Ends in {area:392}, on the next guide: keep it"] = "",

	-- Step 17: Nafien
	-- {area:1769} Timbermaw Hold · {npc:15395} Nafien
	["Ride north up the road from the Sanctuary, all the way to the cave mouth of {area:1769}; {npc:15395} guards it."] = "Cavalgue para o norte pela estrada a partir do Santuário, até a entrada da caverna de {area:1769}; {npc:15395} a guarda.",

	-- Step 18: Felpaw Village
	-- {area:1762} Felpaw Village
	-- was: ["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. The Avengers can drop a {quest:8470}.\nCareful: Den Watchers are level 53-54; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "Os furbolgs de Lenha Morta de {area:1762} lotam as colinas a oeste da caverna. Os Vingadores podem deixar cair um {quest:8470}.\nCuidado: os Vigias do Covil são nível 53-54; chamam aliados num raio de 25 m quando ficam abaixo de 50% de vida e saem correndo atrás de ajuda abaixo de 15%."
	["The Deadwood furbolgs of {area:1762} fill the hills west of the cave.\nCareful: Den Watchers are level 53-54 and the Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "",

	-- Step 19: Deadwood Ritual Totem
	-- {quest:8470} Deadwood Ritual Totem · {npc:11558} Kernda · {area:1769} Timbermaw Hold
	["Only if the Timbermaw are already Neutral to you: the Deadwood furbolgs drop a {quest:8470} about one kill in thirty, and {npc:11558} just inside {area:1769} takes it. Below Neutral the quest is refused: it needs Neutral with the Timbermaw; the reputation guide gets you there."] = "",

	-- Step 20: Nafien
	-- {npc:11556} Salfa · {zone:1452} Winterspring
	-- was: ["Salfa stands at the {zone:1452} end of the tunnel: keep it"] = "Salfa fica na saída do túnel para {zone:1452}: guarde-a"
	["{npc:11556} stands at the {zone:1452} end of the tunnel"] = "",

	-- Step 22: Timbermaw Hold
	-- {npc:11558} Kernda
	["Step into the cave: {npc:11558} stands just inside. She needs Neutral with the Timbermaw; the reputation guide gets you there."] = "",
	-- {npc:11558} Kernda
	["{npc:11558}: walks around here: look inside the circle on the map"] = "{npc:11558}: anda por aqui: procure dentro do círculo no mapa",

	-- Step 23: Into Winterspring
	-- {zone:1452} Winterspring
	["Into {zone:1452}"] = "Rumo a {zone:1452}",
	-- {area:1769} Timbermaw Hold · {zone:1452} Winterspring
	["Walk through {area:1769}'s tunnel to its {zone:1452} end."] = "",

	-- Step 24: Salfa
	-- {npc:11556} Salfa · {zone:1452} Winterspring · {area:1769} Timbermaw Hold
	["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "{npc:11556} fica bem na saída de {zone:1452} do túnel de {area:1769}, por onde você sai.",

	-- Step 25: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Ride south to {npc:9298}'s camp beside the hot springs."] = "",
	-- {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["Keep it: {npc:7775} in {zone:1444}, later in this guide, brews the elixir"] = "",

	-- Step 26: Everlook
	-- {area:2255} Everlook
	["Ride east along the road to {area:2255}."] = "Siga a estrada para o leste até {area:2255}.",
	-- {zone:1452} Winterspring
	["The Chillwind horns come on the next guide's {zone:1452} loop: keep it"] = "",

	-- Step 27: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "Voe para {area:702}",
	-- {npc:11138} Maethrya
	["{npc:11138}, the Alliance flight master"] = "",

	-- Step 28: Rut'theran Village
	-- {npc:7916} Erelas Ambersky · {quest:3661} Favored of Elune? · {zone:1425} Hinterlands
	["{npc:7916}: {quest:3661}, the feathers from the {zone:1425}"] = "",
	-- {npc:7916} Erelas Ambersky · {zone:1452} Winterspring
	["{npc:7916}: the wildkin feathers lie along {zone:1452}'s road, on the next guide; {npc:7916} takes them on the Plaguelands guide's way through: keep it"] = "",

	-- Step 29: Daryn Lightwind
	-- {npc:7907} Daryn Lightwind · {npc:7916} Erelas Ambersky
	["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "{npc:7907} fica no andar de cima, acima de {npc:7916}: suba por dentro, a seta não diferencia os andares.",

	-- Step 31: The Temple Gardens
	-- {item:11682} Eridan's Vial
	["Fill {item:11682} at the moonwell inside the Temple of the Moon."] = "",

	-- Step 32: Astarii Starseeker
	-- {npc:4090} Astarii Starseeker · {quest:3378} Prayer to Elune · {zone:1427} Searing Gorge
	["{npc:4090}, in the Temple of the Moon: {quest:3378}, from the {zone:1427}"] = "",

	-- Step 33: Gracina Spiritmight
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740} stands beside Tyrande in the Temple of the Moon."] = "",
	-- {npc:7740} Gracina Spiritmight · {quest:162} Rise of the Silithid · {area:976} Gadgetzan
	["{npc:7740}: {quest:162}, from {area:976}"] = "{npc:7740}: {quest:162}, vinda de {area:976}",
	-- {npc:5594} Alchemist Pestlezugg · {area:976} Gadgetzan · {zone:1446} Tanaris · {zone:1452} Winterspring
	["For {npc:5594} in {area:976}, on the {zone:1446} and {zone:1452} guide: keep it"] = "",

	-- Step 34: Jenal
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["{npc:9047} waits in the {area:1658}, west of the druids' building."] = "",
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave · {quest:3764} Un'Goro Soil
	["{npc:9047}, in the {area:1658}: {quest:3764}"] = "",

	-- Step 36: Arch Druid Fandral Staghelm
	-- {npc:4217} Mathrengyl Bearwalker
	["Fandral stands at the top of the druids' building; {npc:4217}, next, is lower down inside it."] = "",
	-- {npc:3516} Arch Druid Fandral Staghelm
	["{npc:3516}, upstairs"] = "",

	-- Step 38: Mathrengyl Bearwalker
	-- {npc:4217} Mathrengyl Bearwalker
	["{npc:4217}, upstairs"] = "{npc:4217}, no andar de cima",
	-- {npc:4217} Mathrengyl Bearwalker · {item:11040} Morrowgrain
	["{npc:4217}'s next task grows ten {item:11040} from a pouch over several hours: skip it."] = "",
	-- {zone:1455} Ironforge
	["{zone:1455} has no druid trainer"] = "{zone:1455} não tem instrutor de druida",

	-- Step 39: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "Portal para {zone:1438}",

	-- Step 40: Rut'theran Village flight master
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "Mestre de voo de {area:702}",

	-- Step 41: Feathermoon Stronghold
	-- {area:702} Rut'theran Village · {area:1116} Feathermoon Stronghold
	["From {area:702}, fly to {area:1116}."] = "De {area:702}, voe para {area:1116}.",

	-- Step 43: Boat to The Forgotten Coast
	-- {area:1108} The Forgotten Coast
	["Boat to {area:1108}"] = "Barco para {area:1108}",

	-- Step 44: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle
	["Take the boat to the mainland: {npc:14637} waits on the dock where it lands."] = "",

	-- Step 45: The Forgotten Coast: kill these as you meet them
	-- {area:1108} The Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "{area:1108}: vá matando estes pelo caminho",
	-- {item:18904} Zorbin's Ultra-Shrinker · {npc:14637} Zorbin Fandazzle
	-- plural, as words: Sea Sprays = {npc:5462} Sea Spray · Water Elemental Cores = {item:18958} Water Elemental Core · Sea Elementals = {npc:5461} Sea Elemental · Deep Striders = {npc:5360} Deep Strider
	["The Sea Sprays (46-47) wash along the shore just south of the dock: they drop the Water Elemental Cores as well as the Sea Elementals (47) do. The Wave and Deep Striders (47) wade in the water off the same beach: zap them with {item:18904} first, and shrunken they lose their elite strength.\nThe Ultra-Shrinker lasts two hours: hand both quests back to {npc:14637} before you leave the coast."] = "",
	-- {item:18958} Water Elemental Core
	-- plural, as words: Sea Sprays = {npc:5462} Sea Spray
	["{item:18958}, from the Sea Sprays"] = "{item:18958}, dos Borrifos do Mar",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Deep Striders = {npc:5360} Deep Strider
	["{item:18904}, on the Wave and Deep Striders in the water"] = "{item:18904}, nos Andarilhos das Ondas e Fundívagos na água",

	-- Step 46: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle
	["Back to {npc:14637} on the dock."] = "Volte até {npc:14637} no cais.",

	-- Step 47: Gregan Brewspewer
	-- {area:1119} Twin Colossals · {npc:7775} Gregan Brewspewer · {item:11243} Videre Elixir · {item:11242} Evoroot
	["Ride north-east from the dock past the {area:1119} to {npc:7775}'s camp. He brews the {item:11243} from an {item:11242}: take his errand for one."] = "",

	-- Step 48: Rockbiter
	-- {npc:7765} Rockbiter · {npc:7775} Gregan Brewspewer
	["The giant {npc:7765} sits just north-west of {npc:7775}'s camp."] = "O gigante {npc:7765} fica logo a noroeste do acampamento de {npc:7775}.",

	-- Step 49: Evoroot
	-- {item:11242} Evoroot · {npc:7765} Rockbiter
	["The {item:11242} grows inside a ruined building north of {npc:7765}: climb in through the break in its wall from the ledge beside it."] = "O {item:11242} cresce dentro de uma construção em ruínas ao norte de {npc:7765}: entre pela abertura na parede, a partir da saliência ao lado.",

	-- Step 50: Shay Leafrunner
	-- {npc:7774} Shay Leafrunner · {item:9189} Shay's Bell
	["Ride west into the Ravenwind Ruins: {npc:7774} hides in the small round building at the back. Open the chest beside her for {item:9189}: it lasts 15 minutes, like the quest."] = "Cavalgue para o oeste, até as Ruínas dos Ventos Corvejantes: {npc:7774} se esconde na pequena construção redonda dos fundos. Abra o baú ao lado dela para pegar {item:9189}: dura 15 minutos, como a missão.",

	-- Step 51: Wandering Shay
	-- {npc:7774} Shay Leafrunner · {npc:7765} Rockbiter
	["Lead {npc:7774} back to {npc:7765} at walking pace: she wanders off, so ring the bell to call her back (not in combat), and clear the harpies on the way before she reaches them."] = "Leve {npc:7774} de volta até {npc:7765} em ritmo de caminhada: ela se afasta, então toque o sino para chamá-la de volta (fora de combate) e limpe as harpias do caminho antes que ela chegue a elas.",

	-- Step 52: Gregan Brewspewer
	-- {npc:7775} Gregan Brewspewer · {npc:7765} Rockbiter · {item:11242} Evoroot · {npc:9298} Donova Snowden · {area:976} Gadgetzan
	-- plural, as words: Videre Elixirs = {item:11243} Videre Elixir
	["Back to {npc:7775}'s camp, just south-east of {npc:7765}: the {item:11242} buys three Videre Elixirs. Keep them: {npc:9298} takes one at the start of the next guide, and Gaeriyan in {area:976} shows himself only to someone who has drunk one."] = "",

	-- Step 53: Feralas
	-- {area:489} Thalanaar · {zone:1441} Thousand Needles
	["Ride east along the road to {area:489}, on the {zone:1441} border: the next guide flies from there."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ends in the {zone:1413}: keep it"] = "Termina em {zone:1413}: guarde-a",
	-- ["Five feathers buy a little Timbermaw reputation"] = "Cinco penas rendem um pouco de reputação com os Presamatos",
	-- ["Fly from {area:1998} to the Sanctuary's end of the road, or ride south along it."] = "Voe de {area:1998} até o Santuário, no fim da estrada, ou siga por ela para o sul.",
	-- ["Fly to {area:415}"] = "Voe para {area:415}",
	-- ["Follow the road north to the cratered vale and walk to each crater, killing the Entropic Beasts and Horrors between them."] = "Siga a estrada para o norte até o vale de crateras e vá até cada cratera, matando as Feras Entrópicas e os Horrores entre elas.",
	-- ["If you skipped The Horn of the Beast or The {item:9328}, grind here to level 52.58 to stay on the route's plan."] = "Se você pulou O chifre da fera ou {item:9328}, mate monstros aqui até o nível 52.58 para seguir o plano da rota.",
	-- ["Keep her alive until she is out of the cave"] = "Mantenha-a viva até ela sair da caverna",
	-- ["Level 52.58"] = "Nível 52.58",
	-- ["Level 52.69"] = "Nível 52.69",
	-- ["Level 52.9"] = "Nível 52.9",
	-- ["Oozes"] = "Gosmas",
	-- ["Ride east to the night elf camp at {area:1998}."] = "Siga para o leste até o acampamento dos elfos noturnos em {area:1998}.",
	-- ["Ride north out of {area:415} into {zone:1448} to the {area:2479}, the druids' camp by the road."] = "Siga para o norte, saindo de {area:415}, até {zone:1448}, até {area:2479}, o acampamento dos druidas junto à estrada.",
	-- ["Ride north out of {area:415} into {zone:1448}. {npc:11554} the furbolg stands by the road just south of the {area:2479}."] = "Siga para o norte saindo de {area:415} até {zone:1448}. O furbolg {npc:11554} fica junto à estrada, logo ao sul de {area:2479}.",
	-- ["Ride north to {area:1769} (or fly back to {area:1998} first) and through the tunnel into {zone:1452}; follow the road east to the goblin town of {area:2255}."] = "Siga para o norte até {area:1769} (ou antes volte voando para {area:1998}) e atravesse o túnel até {zone:1452}; siga a estrada para o leste até a cidade goblin de {area:2255}.",
	-- ["Salfa stands at the {zone:1452} end of the tunnel: keep it"] = "Salfa fica na saída do túnel para {zone:1452}: guarde-a",
	-- ["Step into the cave: {npc:11558} and {npc:11557} stand just inside."] = "Entre na caverna: {npc:11558} e {npc:11557} ficam logo na entrada.",
	-- ["Step into the cave: {npc:11558} stands just inside."] = "Entre na caverna: {npc:11558} fica logo na entrada.",
	-- ["Still short of level 52.9 after the {area:2479}'s hand-ins? Top up on the Entropic Beasts in {area:1766}, the next stop north."] = "Ainda abaixo do nível 52.9 depois das entregas de {area:2479}? Complete nas Feras Entrópicas em {area:1766}, a próxima parada ao norte.",
	-- ["Take the boat from {area:702} to {area:442} and fly to {area:415}."] = "Pegue o barco de {area:702} para {area:442} e voe para {area:415}.",
	-- ["The Cursed and Tainted Oozes slide about the streams and fel pools around {area:1763} and {area:1765}: kill them and use Laris's Empty Ooze Jars on their remains."] = "As Gosmas Amaldiçoadas e as Gosmas Maculadas deslizam pelos córregos e poças vis ao redor de {area:1763} e {area:1765}: mate-as e use as Jarras de Gosma vazias de Laris Vagarroda nos restos delas.",
	-- ["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop."] = "Os furbolgs de Lenha Morta vivem na aldeia logo a sudoeste de {npc:11554}; guarde as Penas do Cocar de Lenha Morta que eles deixam cair.",
	-- ["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. Keep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 58.\nCareful: Den Watchers are level 53-54 and the Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "Os furbolgs de Lenha Morta de {area:1762} ocupam as colinas a oeste da caverna. Continue matando-os até um soltar {quest:8470}, cerca de uma morte em trinta, e então clique nele com o botão direito: {npc:11558}, em {area:1769}, aceita-o quando os Presamatos estiverem Neutros com você, agora, se já estiverem, ou quando o último guia passar pela caverna de novo no nível 58.\nCuidado: os Vigias do Covil são de nível 53-54 e os Vingadores 54-55; chamam aliados próximos a até 25 metros quando ficam abaixo de 50% de vida e fogem para pedir ajuda abaixo de 15%.",
	-- ["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. Keep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 58.\nCareful: Den Watchers are level 53-54; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "Os furbolgs de Lenha Morta de {area:1762} ocupam as colinas a oeste da caverna. Continue matando-os até um soltar {quest:8470}, cerca de uma morte em trinta, e então clique nele com o botão direito: {npc:11558}, em {area:1769}, aceita-o quando os Presamatos estiverem Neutros com você, agora, se já estiverem, ou quando o último guia passar pela caverna de novo no nível 58.\nCuidado: os Vigias do Covil são de nível 53-54; chamam aliados próximos a até 25 metros quando ficam abaixo de 50% de vida e fogem para pedir ajuda abaixo de 15%.",
	-- ["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. The Avengers can drop a {quest:8470}."] = "Os furbolgs de Lenha Morta de {area:1762} enchem as colinas a oeste da caverna. Os Vingadores de Lenha Morta podem deixar cair um {quest:8470}.",
	-- ["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. The Avengers can drop a {quest:8470}.\nCareful: Den Watchers are level 53-54; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "Os furbolgs de Lenha Morta de {area:1762} lotam as colinas a oeste da caverna. Os Vingadores podem deixar cair um {quest:8470}.\nCuidado: os Vigias do Covil são nível 53-54; chamam aliados num raio de 25 m quando ficam abaixo de 50% de vida e saem correndo atrás de ajuda abaixo de 15%.",
	-- ["The Jadefire satyrs hold the glen west of the road, with {npc:9454} at its back."] = "Os sátiros Flamejade ocupam o vale a oeste da estrada, com {npc:9454} no fundo.",
	-- ["The vial is filled in {zone:1457}: keep it"] = "A ampola é enchida em {zone:1457}: guarde-a",
	-- ["The vial is filled in {zone:1457}: keep it; inside"] = "O frasco se enche em {zone:1457}: guarde; lá dentro",
	-- ["Top up here to level 52.69 before the hand-ins at {area:1763}: they take you to level 53."] = "Complete aqui até o nível 52.69 antes das entregas em {area:1763}: elas levam você ao nível 53.",
	-- ["Top up here to level 52.9 before the hand-ins at {area:2479}: they take you to level 53. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "Complete aqui até o nível 52.9 antes das entregas em {area:2479}: elas levam você ao nível 53. Ou, com um grupo, faça a masmorra {area:1417} ou a masmorra {area:2100}.",
	-- ["Trey Lightforge's remains lie beside her."] = "Os restos mortais de Trey Forjaleve estão ao lado dela.",
	-- ["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}. If you freed {npc:11018}, go back into {area:1770} for the succubus {npc:9518}."] = "Use o {item:12922} no poço lunar corrompido no meio de {area:1763}. Se você libertou {npc:11018}, volte a {area:1770} atrás da súcubo {npc:9518}.",
	-- ["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}. If you freed {npc:11018}, go back into {area:1770} for the succubus {npc:9518}; Trey Lightforge's remains lie beside her."] = "Use o {item:12922} no poço lunar corrompido no meio de {area:1763}. Se você libertou {npc:11018}, volte a {area:1770} atrás da súcubo {npc:9518}; os Restos Mortais de Trey Forjaleve estão ao lado dela.",
	-- ["grind on {npc:7109}"] = "mate {npc:7109} até subir",
	-- ["grind on {npc:7153}"] = "mate {npc:7153} até subir",
	-- ["grind on {npc:7155}"] = "mate {npc:7155} até subir",
	-- ["grind on {npc:9878}"] = "mate {npc:9878} até subir",
	-- ["{area:1763} is the ruined temple north of the glen."] = "{area:1763} é o templo em ruínas ao norte do vale.",
	-- ["{area:1763} is the ruined temple north of the glen. Some of its cultists drop a {item:13140}, about one kill in thirty: it opens {npc:11018}'s cell in {area:1770}, the cave at the back. If it drops, clear the way out before you free her; if not, skip her quests."] = "{area:1763} é o templo em ruínas ao norte do vale. Alguns dos seus sectários deixam cair uma {item:13140}, cerca de uma vez a cada trinta mortes: ela abre a cela de {npc:11018} em {area:1770}, a caverna no fundo. Se ela cair, limpe o caminho de saída antes de libertá-la; se não, pule as missões dela.",
	-- ["{area:2618} is the satyr valley in the north-west, with {npc:10648} at its far end. He drops the {quest:939}; every Jadefire satyr can drop {item:11674}."] = "{area:2618} é o vale dos sátiros no noroeste, com {npc:10648} no fundo. Ele deixa cair {quest:939}; todo sátiro Flamejade pode deixar cair {item:11674}.",
	-- ["{item:13140}, a rare drop"] = "{item:13140}, um saque raro",
	-- ["{npc:10924}: for {npc:11079} in {zone:1452}, keep it"] = "{npc:10924}: para {npc:11079} em {zone:1452}, guarde-a",
	-- ["{npc:11016}, in {area:1770}"] = "{npc:11016}, em {area:1770}",
	-- ["{npc:11016}, in {area:1770}; below ground"] = "{npc:11016}, em {area:1770}; no subterrâneo",
	-- ["{npc:11020}, below ground"] = "{npc:11020}, no subterrâneo",
	-- ["{npc:11557}: thirty {quest:6031}, handed in when you pass through again at 57"] = "{npc:11557}: trinta {quest:6031}, entregues quando você passar por aqui de novo no nível 57",
	-- ["{npc:11557}: thirty {quest:6031}, handed in when you pass through again at 57; below ground"] = "{npc:11557}: trinta {quest:6031}, entregues quando você passar de novo no nível 57; no subterrâneo",
	-- ["{npc:11558}: the Timbermaw speak to you only from Neutral"] = "{npc:11558}: os Presamatos só falam com você a partir de Neutro",
	-- ["{npc:11558}: the Timbermaw speak to you only from Neutral; walks around here: look inside the circle on the map"] = "{npc:11558}: os Presamatos só falam com você a partir de Neutro; anda por aqui: procure dentro do círculo no mapa",
	-- ["{npc:15395} waits at the north end of {area:361}"] = "{npc:15395} espera no extremo norte de {area:361}",
	-- ["{npc:9518}, below ground"] = "{npc:9518}, no subterrâneo",
	-- ["{quest:8470}, a rare drop"] = "{quest:8470}, um saque raro",
}
