-- Portuguese (Brazil) (ptBR): the guide forever/alliance/50-60/03-winterspring (forever/alliance/50-60/03-winterspring.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Winterspring
	-- {zone:1452} Winterspring
	["Into {zone:1452}"] = "",

	-- Step 2: Salfa
	-- {npc:11556} Salfa · {zone:1452} Winterspring
	["{npc:11556} stands right at the {zone:1452} exit of Timbermaw Hold's tunnel, where you come out."] = "",

	-- Step 4: Everlook
	["Everlook"] = "",
	-- {npc:11118} Innkeeper Vizzie
	["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118}: o guia anterior vincula você aqui, então isto costuma ser marcado na hora",
	-- {npc:11629} Jessica Redpath
	["{npc:11629}: keep it for Darrowshire; inside"] = "",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}: keep both for the Plaguelands; inside"] = "",
	-- {npc:11754} Meggi Peppinrocker
	["{npc:11754} walks around Everlook: look inside the circle on the map"] = "",
	-- {item:12383} Moontouched Feather
	["{item:12383}, 110 yd north"] = "",

	-- Step 6: Ice Thistle Hills: kill these as you meet them
	["Ice Thistle Hills: kill these as you meet them"] = "",
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["Ice Thistle yetis live in the hills south of Winterfall Village, Chillwind Chimaeras in the valley toward Everlook."] = "",

	-- Step 7: The Ruins of Kel'Theril
	-- {object:177132} Starfall Village (no name in this language: may be words)
	-- plural, as words: Moontouched Feathers = {item:12383} Moontouched Feather
	["The ruins lie around the frozen lake south of {object:177132}. Pick up the four relic fragments lying in the ruins and the Moontouched Feathers on the ground where the wildkin roam."] = "",

	-- Step 8: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Follow the road west to {npc:9298}'s camp beside the hot springs."] = "Siga a estrada para oeste até o acampamento de {npc:9298}, ao lado das fontes termais.",
	-- {zone:1444} Feralas
	["Keep it: Gregan in {zone:1444} brews the elixir later"] = "Guarde-o: Gregan em {zone:1444} prepara o elixir mais tarde",

	-- Step 9: Frostfire Hot Springs: kill these as you meet them
	["Frostfire Hot Springs: kill these as you meet them"] = "",
	-- {npc:11556} Salfa · {npc:9298} Donova Snowden · {item:12771} Empty Firewater Flask · {quest:8471} Winterfall Ritual Totem · {quest:6031} Runecloth
	["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Any furbolg here can drop an {item:12771} (about one in ten) and, rarely, a {quest:8471}: right-click whichever drops. Keep the {quest:6031} the furbolgs drop for Meilosh."] = "O acampamento oeste dos Invernosos fica nas colinas entre {npc:11556} e {npc:9298}. Qualquer furbolg daqui pode deixar cair um {item:12771} (cerca de um em dez) e, raramente, um {quest:8471}: clique com o botão direito no que cair. Guarde o {quest:6031} que os furbolgs deixam cair para Meilosh.",
	-- {item:12771} Empty Firewater Flask
	["{item:12771}, a rare drop"] = "{item:12771}, item raro",
	-- {quest:6031} Runecloth
	["{quest:6031}, for Meilosh later"] = "{quest:6031}, para Meilosh mais tarde",
	-- {quest:8471} Winterfall Ritual Totem
	["{quest:8471}, a rare drop"] = "{quest:8471}, item raro",
	["For Kernda in Timbermaw Hold: keep it"] = "",

	-- Step 10: Donova Snowden
	-- {zone:1448} Felwood
	["The Deadwood cauldron in {zone:1448}: keep it"] = "O caldeirão Lenha Morta em {zone:1448}: guarde-o",

	-- Step 11: Level 55.05
	["Level 55.05"] = "",
	["Top up here to level 55.05 before the hand-ins at Everlook: they take you to level 56. Grind the Winterfall furbolgs camped by Frostfire Hot Springs (Pathfinders, Totemics, Den Watchers): killing them raises your Timbermaw reputation, which the quests here and the walk through Timbermaw Hold need. Or, with a group, run the Blackrock Depths dungeon or the Blackrock Spire dungeon (Lower) instead."] = "",
	-- {npc:7442} Winterfall Pathfinder
	["grind on {npc:7442}"] = "",

	-- Step 13: Winterfall Village
	["Winterfall Village"] = "",
	-- {npc:10738} High Chief Winterfall
	["The Winterfall furbolg village lies east of Everlook: Shaman (56-57), Den Watchers (55-56) and Ursa (57-58), all above you. Kill the Shaman first, they heal, and pull from the edge. {npc:10738} in the cave at the back is elite: stay out."] = "",

	-- Step 14: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "Chifres Impolutos de Yeti",
	-- plural, as words: Ice Thistle Matriarchs = {npc:7459} Ice Thistle Matriarch
	["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns."] = "",

	-- Step 15: Everlook
	-- {npc:10978} Legacki
	["On {npc:10978}, by the inn"] = "Em {npc:10978}, perto da estalagem",
	-- {npc:10978} Legacki · {npc:7583} Sprinkle · {npc:10977} Quixxil
	["{npc:10978}: {npc:7583} and {npc:10977} come later"] = "{npc:10978}: {npc:7583} e {npc:10977} vêm depois",

	-- Step 17: Fly to Theramore
	["Fly to Theramore"] = "Voe para a Ilha Theramore",
	["Everlook flight master"] = "",

	-- Step 18: Boat to Menethil Harbor
	-- {object:1162} Menethil Harbor (no name in this language: may be words)
	["Boat to {object:1162}"] = "",

	-- Step 19: Fly to Southshore
	["Fly to Southshore"] = "",
	-- {object:1162} Menethil Harbor (no name in this language: may be words)
	["{object:1162} flight master"] = "",

	-- Step 21: Chillwind Camp
	["Chillwind Camp"] = "",
	["From Southshore, ride north up the road through Alterac to Chillwind Camp."] = "",
	-- {npc:11616} Nathaniel Dumah
	["{npc:11616}: the termites come later, in Terrordale"] = "",
	-- {npc:10838} Commander Ashlam Valorfist
	["{npc:10838}: the watchtowers are in Andorhal, keep it"] = "",
	-- {npc:11053} High Priestess MacDonnell
	["{npc:11053}: the cauldron is at Dalson's Tears, keep it"] = "",

	-- Step 22: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {zone:1423} Eastern Plaguelands
	["{npc:10739} stands by the farm at the Writhing Haunt, on the road east to the {zone:1423}."] = "",
	["Inside"] = "",

	-- Step 23: Into Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Into {zone:1423}"] = "",

	-- Step 25: Pamela Redpath
	-- {zone:1423} Eastern Plaguelands · {npc:10926} Pamela Redpath
	["Follow the southern road east into the {zone:1423}; the ruins of Darrowshire lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "",

	-- Step 26: Pamela Redpath's doll
	-- {npc:10926} Pamela Redpath
	["{npc:10926}'s doll"] = "A boneca de {npc:10926}",
	["The three pieces of the doll lie in the ruined houses of Darrowshire; picking one up can call out ghosts. Combine them into the doll."] = "",
	-- {item:12886} Pamela's Doll's Head
	["{item:12886}; inside"] = "",
	-- {item:12888} Pamela's Doll's Right Side
	["{item:12888}; inside"] = "",

	-- Step 27: Pamela Redpath
	-- {quest:5152} Auntie Marlene · {zone:1422} Western Plaguelands
	["{quest:5152}, in the {zone:1422}: keep it"] = "{quest:5152}, nas {zone:1422}: guarde-a",

	-- Step 28: Light's Hope Chapel
	["Light's Hope Chapel"] = "",
	["Follow the road east across the zone to the chapel."] = "Siga a estrada para leste atravessando a zona até a capela.",
	-- {npc:11038} Caretaker Alen
	["{npc:11038}: Zaeldarr is a level 54 elite"] = "",

	-- Step 29: Corin's Crossing
	-- {object:176970} Corin's Crossing (no name in this language: may be words)
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["The Scourge around {object:176970}, west of the chapel, drop both kinds of Scourgestone; Darrowshire Spirits rise from them: talk to each one to free it."] = "",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "Liberte os Espíritos da Vila das Flechas: fale com eles",

	-- Step 30: The Undercroft
	["The Undercroft"] = "",
	["Zaeldarr is elite: grouping up is advised. He waits at the bottom of the Undercroft, the crypt in the south-west of the zone."] = "",
	-- {item:15785} Zaeldarr's Head
	["{item:15785}; below ground"] = "",

	-- Step 31: Browman Mill: kill these as you meet them
	["Browman Mill: kill these as you meet them"] = "",
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Careful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "",

	-- Step 32: Light's Hope Chapel
	["The next guide starts here and flies to Chillwind Camp."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns. Keep killing yetis until level 54: Harlo's wildkin quests are red before that."] = "De volta às colinas: só as Matriarcas e os Patriarcas Cardo de Gelo levam os chifres. Continue matando yetis até o nível 54: as missões de plumacuns de Harlo ficam vermelhas antes disso.",
	-- ["Follow the southern road east into the {zone:1423}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "Siga a estrada do sul para leste até as {zone:1423}; as ruínas de {area:2262} ficam ao sul dela. O fantasma de {npc:10926} brinca junto à casa em ruínas no extremo sul.",
	-- ["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "Siga as instruções de {npc:9298} até a entrada do {area:2256}, passando pelos gigantes Friomalho: passe por eles um de cada vez.",
	-- ["For Kernda in {area:1769}: keep it"] = "Para Kernda em {area:1769}: guarde-o",
	-- ["Ice Thistle yetis live in the hills south of {area:2244}, Chillwind Chimaeras in the valley toward {area:2255}."] = "Yetis Cardo de Gelo vivem nas colinas ao sul da {area:2244}, Quimeras Ventogelantes no vale rumo a {area:2255}.",
	-- ["Optional: {area:1417}"] = "Opcional: {area:1417}",
	-- ["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "Pegue os suprimentos em volta da carroça e tome de volta o amuleto de {npc:10301} dos corujursos próximos.",
	-- ["Pristine Yeti Horns"] = "Chifres Impolutos de Yeti",
	-- ["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "Cavalgue para o norte até {area:2627}. {npc:12384} mora na cabana em ruínas, e o livro de recibos dele está na estalagem em ruínas ali perto.",
	-- ["Ride north-west back to the village."] = "Cavalgue para noroeste de volta à aldeia.",
	-- ["Ride south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "Cavalgue para sudeste descendo o vale até o caixote danificado de {npc:10301} na neve em {area:2245}, com a carroça destruída dele logo a leste.",
	-- ["Ride west along the road to the night elf village."] = "Cavalgue para oeste pela estrada até a aldeia dos elfos noturnos.",
	-- ["Ride west along the road to {npc:10301}."] = "Cavalgue para oeste pela estrada até {npc:10301}.",
	-- ["Short of level 54 after the yetis? Running the {area:1417} (50-54) instead of grinding gets you there faster in a group. Come back to {area:2255} afterwards."] = "Abaixo do nível 54 depois dos yetis? Fazer o {area:1417} (50-54) em grupo em vez de farmar leva você lá mais rápido. Volte a {area:2255} depois.",
	-- ["The Scourge around {area:2264}, west of the chapel, drop both kinds of Scourgestone; Darrowshire Spirits rise from them: talk to each one to free it."] = "O Flagelo em volta de {area:2264}, a oeste da capela, deixa cair os dois tipos de Pedra do Flagelo; Espíritos da Vila das Flechas surgem deles: fale com cada um para libertá-lo.",
	-- ["The Winterfall camp"] = "O acampamento dos Invernosos",
	-- ["The Winterfall furbolg village lies east of {area:2255}: Shaman (56-57), Den Watchers (55-56) and Ursa (57-58), all above you. Kill the Shaman first, they heal, and pull from the edge. {npc:10738} in the cave at the back is elite: stay out."] = "A aldeia dos furbolgs Invernosos fica a leste de {area:2255}: Xamãs (56-57), Vigias do Covil (55-56) e Ursinos (57-58), todos acima de você. Mate os Xamãs primeiro, eles curam, e atraia pelas bordas. {npc:10738}, na caverna dos fundos, é elite: fique longe.",
	-- ["The next guide starts here and flies to {area:3197}."] = "O próximo guia começa aqui e voa para o {area:3197}.",
	-- ["The ruins lie around the frozen lake south of {area:2253}. Pick up the four relic fragments lying in the ruins and the Moontouched Feathers on the ground where the wildkin roam."] = "As ruínas ficam em volta do lago congelado ao sul de {area:2253}. Pegue os quatro fragmentos de relíquia caídos nas ruínas e as Penas Lunamarca no chão onde os plumacuns vagam.",
	-- ["The three pieces of the doll lie in the ruined houses of {area:2262}; picking one up can call out ghosts. Combine them into the doll."] = "As três partes da boneca estão nas casas em ruínas de {area:2262}; pegar uma pode chamar fantasmas. Junte-as na boneca.",
	-- ["The western Winterfall furbolgs drop the beads."] = "Os furbolgs Invernosos do oeste deixam cair as contas.",
	-- ["The {area:2247}"] = "As {area:2247}",
	-- ["Walk through {area:1769} to {zone:1448} and fly on to the Eastern Kingdoms ({area:442}, the boat to {area:150}). Fly to {area:271} and ride north up the road through Alterac to {area:3197}."] = "Atravesse {area:1769} até {zone:1448} e voe para os Reinos do Leste ({area:442}, o navio para {area:150}). Voe até {area:271} e cavalgue para o norte pela estrada através de Alterac até o {area:3197}.",
	-- ["grind on {npc:7460} at the {area:2247}, {zone:1452}"] = "farme {npc:7460} nas {area:2247}, {zone:1452}",
	-- ["{npc:10301}'s camp"] = "Acampamento de {npc:10301}",
	-- ["{npc:10301}'s supplies"] = "Suprimentos de {npc:10301}",
	-- ["{npc:10431}: keep both for the Plaguelands"] = "{npc:10431}: guarde os dois para as Terras Pestilentas",
	-- ["{npc:11038}: {npc:12250} is a level 54 elite"] = "{npc:11038}: {npc:12250} é elite de nível 54",
	-- ["{npc:11556} guards the mouth of {area:1769}, north-west of {npc:9298}."] = "{npc:11556} guarda a entrada de {area:1769}, a noroeste de {npc:9298}.",
	-- ["{npc:11629}: keep it for {area:2262}"] = "{npc:11629}: guarde-o para {area:2262}",
	-- ["{npc:12250} is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "{npc:12250} é elite: é recomendado formar grupo. Ele espera no fundo da {area:2261}, a cripta no sudoeste da zona.",
	-- ["{quest:5152}, in the {zone:1422}: keep it"] = "{quest:5152}, nas {zone:1422}: guarde-a",
}
