-- Portuguese (Brazil) (ptBR): the guide forever/alliance/50-60/02-felwood (forever/alliance/50-60/02-felwood.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Auberdine
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {area:415} Astranaar
	["Take the boat from {area:702} to {area:442} and fly to {area:415}."] = "Pegue o barco de {area:702} para {area:442} e voe para {area:415}.",

	-- Step 2: Grazle
	-- {area:415} Astranaar · {zone:1448} Felwood · {npc:11554} Grazle · {area:2479} Emerald Sanctuary
	["Ride north out of {area:415} into {zone:1448}. {npc:11554} the furbolg stands by the road just south of the {area:2479}."] = "Siga para o norte saindo de {area:415} até {zone:1448}. O furbolg {npc:11554} fica junto à estrada, logo ao sul de {area:2479}.",

	-- Step 3: Deadwood Village
	-- {npc:11554} Grazle
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop."] = "Os furbolgs de Lenha Morta vivem na aldeia logo a sudoeste de {npc:11554}; guarde as Penas do Cocar de Lenha Morta que eles deixam cair.",

	-- Step 4: Grazle
	-- {npc:15395} Nafien · {zone:1448} Felwood
	["{npc:15395} waits at the north end of {zone:1448}"] = "{npc:15395} espera no extremo norte de {zone:1448}",
	["Five feathers buy a little Timbermaw reputation"] = "Cinco penas rendem um pouco de reputação com os Presamatos",

	-- Step 5: The Emerald Sanctuary
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",
	-- {npc:9528} Arathandris Silversky · {npc:11554} Grazle
	["{npc:9528}, in the ruins just east of {npc:11554}"] = "{npc:9528}, nas ruínas logo a leste de {npc:11554}",

	-- Step 6: Jadefire Glen
	-- {npc:9454} Xavathras
	["The Jadefire satyrs hold the glen west of the road, with {npc:9454} at its back."] = "Os sátiros Flamejade ocupam o vale a oeste da estrada, com {npc:9454} no fundo.",

	-- Step 7: Jaedenar
	-- {area:1763} Jaedenar · {item:13140} Blood Red Key · {npc:11018} Arko'narin · {area:1770} Shadow Hold
	["{area:1763} is the ruined temple north of the glen. Some of its cultists drop a {item:13140}, about one kill in thirty: it opens {npc:11018}'s cell in {area:1770}, the cave at the back. If it drops, clear the way out before you free her; if not, skip her quests."] = "{area:1763} é o templo em ruínas ao norte do vale. Alguns dos seus sectários deixam cair uma {item:13140}, cerca de uma vez a cada trinta mortes: ela abre a cela de {npc:11018} em {area:1770}, a caverna no fundo. Se ela cair, limpe o caminho de saída antes de libertá-la; se não, pule as missões dela.",
	-- {item:13140} Blood Red Key
	["{item:13140}, a rare drop"] = "{item:13140}, um saque raro",
	-- {npc:11016} Captured Arko'narin · {area:1770} Shadow Hold
	["{npc:11016}, in {area:1770}"] = "{npc:11016}, em {area:1770}",
	["Keep her alive until she is out of the cave"] = "Mantenha-a viva até ela sair da caverna",

	-- Step 9: Jaedenar again
	-- {area:1763} Jaedenar
	["{area:1763} again"] = "{area:1763} de novo",
	-- {item:12922} Empty Canteen · {area:1763} Jaedenar · {npc:11018} Arko'narin · {area:1770} Shadow Hold · {npc:9518} Rakaiah
	["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}. If you freed {npc:11018}, go back into {area:1770} for the succubus {npc:9518}; Trey Lightforge's remains lie beside her."] = "Use o {item:12922} no poço lunar corrompido no meio de {area:1763}. Se você libertou {npc:11018}, volte a {area:1770} atrás da súcubo {npc:9518}; os Restos Mortais de Trey Forjaleve estão ao lado dela.",

	-- Step 10: Oozes
	["Oozes"] = "Gosmas",
	-- {area:1763} Jaedenar · {area:1765} Bloodvenom Falls
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["The Cursed and Tainted Oozes slide about the streams and fel pools around {area:1763} and {area:1765}: kill them and use Laris's Empty Ooze Jars on their remains."] = "As Gosmas Amaldiçoadas e as Gosmas Maculadas deslizam pelos córregos e poças vis ao redor de {area:1763} e {area:1765}: mate-as e use as Jarras de Gosma vazias de Laris Vagarroda nos restos delas.",

	-- Step 11: Shatter Scar Vale
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["Follow the road north to the cratered vale and walk to each crater, killing the Entropic Beasts and Horrors between them."] = "Siga a estrada para o norte até o vale de crateras e vá até cada cratera, matando as Feras Entrópicas e os Horrores entre elas.",
	["First crater"] = "Primeira cratera",
	["Second crater"] = "Segunda cratera",
	["Third crater"] = "Terceira cratera",

	-- Step 12: Jadefire Run
	-- {area:2618} Jadefire Run · {npc:10648} Xavaric · {quest:939} Flute of Xavaric · {item:11674} Jadefire Felbind
	["{area:2618} is the satyr valley in the north-west, with {npc:10648} at its far end. He drops the {quest:939}; every Jadefire satyr can drop {item:11674}."] = "{area:2618} é o vale dos sátiros no noroeste, com {npc:10648} no fundo. Ele deixa cair {quest:939}; todo sátiro Flamejade pode deixar cair {item:11674}.",

	-- Step 13: Irontree Woods
	-- {area:1767} Irontree Woods · {area:2618} Jadefire Run · {item:11503} Blood Amber
	["The Warpwood treants of {area:1767}, east of {area:2618}, carry the {item:11503}."] = "Os arvorosos Lenhatorta de {area:1767}, a leste de {area:2618}, carregam {item:11503}.",

	-- Step 14: Talonbranch Glade
	-- {area:1998} Talonbranch Glade
	["Ride east to the night elf camp at {area:1998}."] = "Siga para o leste até o acampamento dos elfos noturnos em {area:1998}.",

	-- Step 15: Nafien
	-- {area:1769} Timbermaw Hold · {npc:15395} Nafien
	["Follow the road north to the cave mouth of {area:1769}; {npc:15395} guards it."] = "Siga a estrada para o norte até a entrada da caverna de {area:1769}; {npc:15395} a guarda.",

	-- Step 16: Felpaw Village
	-- {area:1762} Felpaw Village · {quest:8470} Deadwood Ritual Totem
	["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. The Avengers can drop a {quest:8470}."] = "Os furbolgs de Lenha Morta de {area:1762} enchem as colinas a oeste da caverna. Os Vingadores de Lenha Morta podem deixar cair um {quest:8470}.",
	-- {quest:8470} Deadwood Ritual Totem
	["{quest:8470}, a rare drop"] = "{quest:8470}, um saque raro",

	-- Step 17: Nafien
	-- {zone:1452} Winterspring
	["Salfa stands at the {zone:1452} end of the tunnel: keep it"] = "Salfa fica na saída do túnel para {zone:1452}: guarde-a",

	-- Step 18: Timbermaw Hold
	-- {npc:11558} Kernda · {npc:11557} Meilosh
	["Step into the cave: {npc:11558} and {npc:11557} stand just inside."] = "Entre na caverna: {npc:11558} e {npc:11557} ficam logo na entrada.",
	-- {npc:11558} Kernda
	["{npc:11558}: the Timbermaw speak to you only from Neutral"] = "{npc:11558}: os Presamatos só falam com você a partir de Neutro",
	-- {npc:11557} Meilosh · {quest:6031} Runecloth
	["{npc:11557}: thirty {quest:6031}, handed in when you pass through again at 57"] = "{npc:11557}: trinta {quest:6031}, entregues quando você passar por aqui de novo no nível 57",

	-- Step 19: The Emerald Sanctuary
	-- {area:1998} Talonbranch Glade
	["Fly from {area:1998} to the Sanctuary's end of the road, or ride south along it."] = "Voe de {area:1998} até o Santuário, no fim da estrada, ou siga por ela para o sul.",
	-- {zone:1457} Darnassus
	["The vial is filled in {zone:1457}: keep it"] = "A ampola é enchida em {zone:1457}: guarde-a",
	-- {zone:1413} Barrens
	["Ends in the {zone:1413}: keep it"] = "Termina em {zone:1413}: guarde-a",

	-- Step 20: Everlook
	-- {area:1769} Timbermaw Hold · {area:1998} Talonbranch Glade · {zone:1452} Winterspring · {area:2255} Everlook
	["Ride north to {area:1769} (or fly back to {area:1998} first) and through the tunnel into {zone:1452}; follow the road east to the goblin town of {area:2255}."] = "Siga para o norte até {area:1769} (ou antes volte voando para {area:1998}) e atravesse o túnel até {zone:1452}; siga a estrada para o leste até a cidade goblin de {area:2255}.",
}
