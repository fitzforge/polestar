-- Portuguese (Brazil) (ptBR): the guide forever/alliance/50-60/02-felwood (forever/alliance/50-60/02-felwood.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "Voe para {area:415}",
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "Mestre de voo de {area:702}",

	-- Step 2: Felwood
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 3: The Emerald Sanctuary
	-- {area:415} Astranaar · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Ride north out of {area:415} into {zone:1448} to the {area:2479}, the druids' camp by the road."] = "Siga para o norte, saindo de {area:415}, até {zone:1448}, até {area:2479}, o acampamento dos druidas junto à estrada.",
	-- {npc:9528} Arathandris Silversky · {npc:11554} Grazle
	["{npc:9528}, in the ruins just east of {npc:11554}"] = "{npc:9528}, nas ruínas logo a leste de {npc:11554}",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "{npc:9116}, lá dentro",

	-- Step 4: Grazle
	-- {npc:11554} Grazle · {area:2479} Emerald Sanctuary
	["{npc:11554} the furbolg stands by the road just south of the {area:2479}."] = "{npc:11554}, o furbolg, fica junto à estrada, logo ao sul de {area:2479}.",

	-- Step 5: Deadwood Village
	-- {npc:11554} Grazle
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop."] = "Os furbolgs de Lenha Morta vivem na aldeia logo a sudoeste de {npc:11554}; guarde as Penas do Cocar de Lenha Morta que eles deixam cair.",

	-- Step 6: Level 52.58
	["Level 52.58"] = "Nível 52.58",
	-- {item:9328} Super Snapper FX · {area:1417} Sunken Temple · {area:2100} Maraudon
	["If you skipped The Horn of the Beast or The {item:9328}, grind here to level 52.58 to stay on the route's plan. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "Se você pulou O chifre da fera ou {item:9328}, mate monstros aqui até o nível 52.58 para seguir o plano da rota. Ou, com um grupo, faça a masmorra {area:1417} ou a masmorra {area:2100}.",
	-- {npc:7153} Deadwood Warrior
	["grind on {npc:7153}"] = "mate {npc:7153} até subir",

	-- Step 7: Grazle
	-- {npc:15395} Nafien · {zone:1448} Felwood
	["{npc:15395} waits at the north end of {zone:1448}"] = "{npc:15395} espera no extremo norte de {zone:1448}",
	["Five feathers buy a little Timbermaw reputation"] = "Cinco penas rendem um pouco de reputação com os Presamatos",

	-- Step 8: Level 52.69
	["Level 52.69"] = "Nível 52.69",
	-- {area:1763} Jaedenar · {area:1417} Sunken Temple · {area:2100} Maraudon
	["Top up here to level 52.69 before the hand-ins at {area:1763}: they take you to level 53. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "Complete aqui até o nível 52.69 antes das entregas em {area:1763}: elas levam você ao nível 53. Ou, com um grupo, faça a masmorra {area:1417} ou a masmorra {area:2100}.",
	-- {npc:7155} Deadwood Pathfinder
	["grind on {npc:7155}"] = "mate {npc:7155} até subir",

	-- Step 9: Jadefire Glen
	-- {npc:9454} Xavathras · {spell:7992} Slowing Poison
	-- plural, as words: Jadefire Shadowstalkers = {npc:7110} Jadefire Shadowstalker · Cursed Oozes = {npc:7086} Cursed Ooze
	["The Jadefire satyrs hold the glen west of the road, with {npc:9454} at its back.\nCareful: Jadefire Shadowstalkers (level 51-52) use Sneak and {spell:7992} and are stealthed, so they often join fights uninvited.\nCursed Oozes slide about the glen's streams: kill them and use Laris's Empty Ooze Jar on their remains."] = "Os sátiros Flamejade dominam o vale a oeste da estrada, com {npc:9454} nos fundos.\nCuidado: os Assombrantes Flamejade (nível 51-52) usam Furtividade e {spell:7992} e ficam furtivos, então costumam entrar nas lutas sem serem chamados.\nGosmas Amaldiçoadas deslizam pelos riachos do vale: mate-as e use o Laris's Empty Ooze Jar nos restos delas.",
	-- {npc:7109} Jadefire Felsworn
	["grind on {npc:7109}"] = "mate {npc:7109} até subir",

	-- Step 11: Jaedenar
	-- {area:1763} Jaedenar
	["{area:1763} is the ruined temple north of the glen."] = "{area:1763} é o templo em ruínas ao norte do vale.",
	-- {item:11949} Filled Tainted Ooze Jar · {area:1763} Jaedenar
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["{item:11949}: Tainted Oozes slide about {area:1763}'s fel pools"] = "{item:11949}: Gosmas Maculadas deslizam pelas poças vis de {area:1763}",
	-- {npc:7125} Jaedenar Hound
	["grind on {npc:7125}"] = "mate {npc:7125} até subir",

	-- Step 12: Level 52.9
	["Level 52.9"] = "Nível 52.9",
	-- {area:2479} Emerald Sanctuary · {area:1417} Sunken Temple · {area:2100} Maraudon
	["Top up here to level 52.9 before the hand-ins at {area:2479}: they take you to level 53. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "Complete aqui até o nível 52.9 antes das entregas em {area:2479}: elas levam você ao nível 53. Ou, com um grupo, faça a masmorra {area:1417} ou a masmorra {area:2100}.",

	-- Step 14: Shatter Scar Vale
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["Follow the road north to the cratered vale and walk to each crater, killing the Entropic Beasts and Horrors between them."] = "Siga a estrada para o norte até o vale de crateras e vá até cada cratera, matando as Feras Entrópicas e os Horrores entre elas.",
	["First crater"] = "Primeira cratera",
	["Second crater"] = "Segunda cratera",
	["Third crater"] = "Terceira cratera",

	-- Step 15: Irontree Woods
	-- {area:1767} Irontree Woods · {area:2618} Jadefire Run · {item:11503} Blood Amber
	["The Warpwood treants of {area:1767}, east of {area:2618}, carry the {item:11503}."] = "Os arvorosos Lenhatorta de {area:1767}, a leste de {area:2618}, carregam {item:11503}.",
	["Below ground"] = "No subterrâneo",

	-- Step 16: Nafien
	-- {area:1769} Timbermaw Hold · {npc:15395} Nafien
	["Follow the road north to the cave mouth of {area:1769}; {npc:15395} guards it."] = "Siga a estrada para o norte até a entrada da caverna de {area:1769}; {npc:15395} a guarda.",

	-- Step 17: Felpaw Village
	-- {area:1762} Felpaw Village · {quest:8470} Deadwood Ritual Totem · {npc:11558} Kernda · {area:1769} Timbermaw Hold
	["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. Keep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 58.\nCareful: Den Watchers are level 53-54; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "Os furbolgs de Lenha Morta de {area:1762} ocupam as colinas a oeste da caverna. Continue matando-os até um soltar {quest:8470}, cerca de uma morte em trinta, e então clique nele com o botão direito: {npc:11558}, em {area:1769}, aceita-o quando os Presamatos estiverem Neutros com você, agora, se já estiverem, ou quando o último guia passar pela caverna de novo no nível 58.\nCuidado: os Vigias do Covil são de nível 53-54; chamam aliados próximos a até 25 metros quando ficam abaixo de 50% de vida e fogem para pedir ajuda abaixo de 15%.",

	-- Step 18: Nafien
	-- {zone:1452} Winterspring
	["Salfa stands at the {zone:1452} end of the tunnel: keep it"] = "Salfa fica na saída do túnel para {zone:1452}: guarde-a",

	-- Step 20: Timbermaw Hold
	-- {npc:11558} Kernda
	["Step into the cave: {npc:11558} stands just inside."] = "Entre na caverna: {npc:11558} fica logo na entrada.",
	-- {npc:11558} Kernda
	["{npc:11558}: the Timbermaw speak to you only from Neutral; walks around here: look inside the circle on the map"] = "{npc:11558}: os Presamatos só falam com você a partir de Neutro; anda por aqui: procure dentro do círculo no mapa",

	-- Step 21: Jadefire Run: kill these as you meet them
	-- {area:2618} Jadefire Run
	["{area:2618}: kill these as you meet them"] = "{area:2618}: vá matando estes pelo caminho",
	-- {area:2618} Jadefire Run · {npc:10648} Xavaric · {quest:939} Flute of Xavaric · {item:11674} Jadefire Felbind
	["{area:2618} is the satyr valley in the north-west, with {npc:10648} at its far end. He drops the {quest:939}; every Jadefire satyr can drop {item:11674}."] = "{area:2618} é o vale dos sátiros no noroeste, com {npc:10648} no fundo. Ele deixa cair {quest:939}; todo sátiro Flamejade pode deixar cair {item:11674}.",

	-- Step 22: Jaedenar again
	-- {area:1763} Jaedenar
	["{area:1763} again"] = "{area:1763} de novo",
	-- {item:12922} Empty Canteen · {area:1763} Jaedenar
	["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}."] = "Use {item:12922} no poço lunar corrompido no meio de {area:1763}.",

	-- Step 23: The Emerald Sanctuary
	-- {area:1763} Jaedenar · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Ride south-east from {area:1763} to the {area:2479}, the druids' camp by the road in southern {zone:1448}."] = "Siga para sudeste, de {area:1763} até {area:2479}, o acampamento dos druidas junto à estrada, no sul de {zone:1448}.",

	-- Step 24: The Emerald Sanctuary
	-- {zone:1457} Darnassus
	["The vial is filled in {zone:1457}: keep it; inside"] = "O frasco se enche em {zone:1457}: guarde; lá dentro",
	-- {zone:1413} Barrens
	["Ends in the {zone:1413}: keep it"] = "Termina em {zone:1413}: guarde-a",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly from {area:1998} to the Sanctuary's end of the road, or ride south along it."] = "Voe de {area:1998} até o Santuário, no fim da estrada, ou siga por ela para o sul.",
	-- ["Keep her alive until she is out of the cave"] = "Mantenha-a viva até ela sair da caverna",
	-- ["Oozes"] = "Gosmas",
	-- ["Ride east to the night elf camp at {area:1998}."] = "Siga para o leste até o acampamento dos elfos noturnos em {area:1998}.",
	-- ["Ride north out of {area:415} into {zone:1448}. {npc:11554} the furbolg stands by the road just south of the {area:2479}."] = "Siga para o norte saindo de {area:415} até {zone:1448}. O furbolg {npc:11554} fica junto à estrada, logo ao sul de {area:2479}.",
	-- ["Ride north to {area:1769} (or fly back to {area:1998} first) and through the tunnel into {zone:1452}; follow the road east to the goblin town of {area:2255}."] = "Siga para o norte até {area:1769} (ou antes volte voando para {area:1998}) e atravesse o túnel até {zone:1452}; siga a estrada para o leste até a cidade goblin de {area:2255}.",
	-- ["Step into the cave: {npc:11558} and {npc:11557} stand just inside."] = "Entre na caverna: {npc:11558} e {npc:11557} ficam logo na entrada.",
	-- ["Take the boat from {area:702} to {area:442} and fly to {area:415}."] = "Pegue o barco de {area:702} para {area:442} e voe para {area:415}.",
	-- ["The Cursed and Tainted Oozes slide about the streams and fel pools around {area:1763} and {area:1765}: kill them and use Laris's Empty Ooze Jars on their remains."] = "As Gosmas Amaldiçoadas e as Gosmas Maculadas deslizam pelos córregos e poças vis ao redor de {area:1763} e {area:1765}: mate-as e use as Jarras de Gosma vazias de Laris Vagarroda nos restos delas.",
	-- ["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. The Avengers can drop a {quest:8470}."] = "Os furbolgs de Lenha Morta de {area:1762} enchem as colinas a oeste da caverna. Os Vingadores de Lenha Morta podem deixar cair um {quest:8470}.",
	-- ["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. The Avengers can drop a {quest:8470}.\nCareful: Den Watchers are level 53-54; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "Os furbolgs de Lenha Morta de {area:1762} lotam as colinas a oeste da caverna. Os Vingadores podem deixar cair um {quest:8470}.\nCuidado: os Vigias do Covil são nível 53-54; chamam aliados num raio de 25 m quando ficam abaixo de 50% de vida e saem correndo atrás de ajuda abaixo de 15%.",
	-- ["The Jadefire satyrs hold the glen west of the road, with {npc:9454} at its back."] = "Os sátiros Flamejade ocupam o vale a oeste da estrada, com {npc:9454} no fundo.",
	-- ["The vial is filled in {zone:1457}: keep it"] = "A ampola é enchida em {zone:1457}: guarde-a",
	-- ["Trey Lightforge's remains lie beside her."] = "Os restos mortais de Trey Forjaleve estão ao lado dela.",
	-- ["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}. If you freed {npc:11018}, go back into {area:1770} for the succubus {npc:9518}."] = "Use o {item:12922} no poço lunar corrompido no meio de {area:1763}. Se você libertou {npc:11018}, volte a {area:1770} atrás da súcubo {npc:9518}.",
	-- ["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}. If you freed {npc:11018}, go back into {area:1770} for the succubus {npc:9518}; Trey Lightforge's remains lie beside her."] = "Use o {item:12922} no poço lunar corrompido no meio de {area:1763}. Se você libertou {npc:11018}, volte a {area:1770} atrás da súcubo {npc:9518}; os Restos Mortais de Trey Forjaleve estão ao lado dela.",
	-- ["{area:1763} is the ruined temple north of the glen. Some of its cultists drop a {item:13140}, about one kill in thirty: it opens {npc:11018}'s cell in {area:1770}, the cave at the back. If it drops, clear the way out before you free her; if not, skip her quests."] = "{area:1763} é o templo em ruínas ao norte do vale. Alguns dos seus sectários deixam cair uma {item:13140}, cerca de uma vez a cada trinta mortes: ela abre a cela de {npc:11018} em {area:1770}, a caverna no fundo. Se ela cair, limpe o caminho de saída antes de libertá-la; se não, pule as missões dela.",
	-- ["{item:13140}, a rare drop"] = "{item:13140}, um saque raro",
	-- ["{npc:11016}, in {area:1770}"] = "{npc:11016}, em {area:1770}",
	-- ["{npc:11016}, in {area:1770}; below ground"] = "{npc:11016}, em {area:1770}; no subterrâneo",
	-- ["{npc:11020}, below ground"] = "{npc:11020}, no subterrâneo",
	-- ["{npc:11557}: thirty {quest:6031}, handed in when you pass through again at 57"] = "{npc:11557}: trinta {quest:6031}, entregues quando você passar por aqui de novo no nível 57",
	-- ["{npc:11557}: thirty {quest:6031}, handed in when you pass through again at 57; below ground"] = "{npc:11557}: trinta {quest:6031}, entregues quando você passar de novo no nível 57; no subterrâneo",
	-- ["{npc:11558}: the Timbermaw speak to you only from Neutral"] = "{npc:11558}: os Presamatos só falam com você a partir de Neutro",
	-- ["{npc:15395} waits at the north end of {area:361}"] = "{npc:15395} espera no extremo norte de {area:361}",
	-- ["{npc:9518}, below ground"] = "{npc:9518}, no subterrâneo",
	-- ["{quest:8470}, a rare drop"] = "{quest:8470}, um saque raro",
}
