-- Portuguese (Brazil) (ptBR): the guide forever/alliance/30-40/05-arathi-highlands (forever/alliance/30-40/05-arathi-highlands.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "Voar para {area:42}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Mestre de voo de {area:35}",

	-- Step 3: Watcher Biggs
	-- {npc:5476} Watcher Biggs · {npc:217412} Amaryllis Webb · {quest:93176} My Little Friends
	["{npc:5476} guards the road junction in the west of the swamp. {npc:217412} stands a short way north of him.\n{npc:217412} may not be here on Forever: if {npc:217412} doesn't offer {quest:93176}, skip it."] = "{npc:5476} guarda o cruzamento de estradas no oeste do pântano. {npc:217412} fica um pouco ao norte dele.\n{npc:217412} pode não estar aqui no Forever: se {npc:217412} não oferecer {quest:93176}, pule.",
	-- {npc:217412} Amaryllis Webb · {zone:1443} Desolace
	["{npc:217412}: three critters to catch in Arathi, {zone:1443} and Stranglethorn"] = "{npc:217412}: três bichinhos para capturar em Arathi, {zone:1443} e no Espinhaço",

	-- Step 4: The western swamp
	["The western swamp"] = "O pântano oeste",
	-- plural, as words: Sorrow Spinners = {npc:858} Sorrow Spinner · Swamp Jaguars = {npc:767} Swamp Jaguar
	["Young crocolisks, Sorrow Spinners and Swamp Jaguars all roam the swamp around the road."] = "Crocoliscos jovens, Tece-mágoas e Jaguares do Pântano vagam pelo pântano em volta da estrada.",

	-- Step 6: The Harborage
	-- {area:657} The Harborage
	["Follow the road north to the draenei of the {area:657}."] = "Siga a estrada para o norte até os draeneis do {area:657}.",

	-- Step 7: Fallow Sanctuary
	-- {area:76} Fallow Sanctuary · {npc:256028} The Lost One
	["East along the road to the {area:76}. {npc:256028} mobs drop the crystals; Noboru walks the ruins and drops his cudgel."] = "Para leste pela estrada até o {area:76}. Os {npc:256028} deixam cair os cristais; Noboru anda pelas ruínas e deixa cair sua borduna.",

	-- Step 8: The Lost Caravan
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	-- plural, as words: Lost Ones = {npc:254797} Lost One
	["The wrecked caravan's chest lies at the north end of the {area:76}, beside {npc:5391}'s cage.\nCareful: The camp is full of Lost Ones around level 38. They stand in linked groups of 2-3, many are casters, and they respawn quickly."] = "O baú da caravana destruída fica no extremo norte de {area:76}, ao lado da jaula de {npc:5391}.\nCuidado: o acampamento está cheio de Perdidos de nível 38 ou perto disso. Eles ficam em grupos ligados de 2-3, muitos são conjuradores, e renascem rápido.",

	-- Step 9: Galen Goodward
	-- {npc:5391} Galen Goodward
	["{npc:5391} is caged at the north end of the sanctuary. Free him and keep him alive on the walk out; his strongbox waits by the road afterwards."] = "{npc:5391} está preso numa jaula no extremo norte do santuário. Liberte-o e mantenha-o vivo na saída; o cofre dele aparece depois junto à estrada.",

	-- Step 10: The Harborage
	-- {npc:5391} Galen Goodward · {area:657} The Harborage
	["West along the road from {npc:5391}'s strongbox to the {area:657}."] = "Para oeste pela estrada, do cofre de {npc:5391} até {area:657}.",
	-- {npc:1776} Magtoor
	["{npc:1776}: Noboru's cudgel"] = "{npc:1776}: a borduna de Noboru",

	-- Step 11: Watcher Biggs
	-- {npc:5476} Watcher Biggs
	["South down the road to {npc:5476}, on the way west out of the swamp."] = "Ao sul pela estrada até {npc:5476}, no caminho para oeste, saindo do pântano.",

	-- Step 13: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Voar para {zone:1453}",
	-- {zone:1430} Deadwind Pass · {area:42} Darkshire
	["Back west through {zone:1430} to {area:42}."] = "De volta para oeste por {zone:1430} até {area:42}.",

	-- Step 14: Stormwind
	-- {npc:1141} Angus Stern · {area:17203} Stormwind Harbor
	["{npc:1141}, {area:17203} road"] = "{npc:1141}, na estrada do {area:17203}",

	-- Step 15: The Binding
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {item:6913} Heartswood Core · {quest:65602} What Is Love? · {item:190309} Wooden Figurine
	["{npc:6122} waits in the {object:2164}'s cellar, in the {object:2101}. Use the {item:6913} at the summoning circle there and defeat the succubus it calls. If you took {quest:65602}, hand him the {item:190309} too, place it at the same circle and defeat the incubus."] = "{npc:6122} espera no porão do {object:2164}, no {object:2101}. Use o {item:6913} no círculo de evocação de lá e derrote a súcubo que ele chama. Se você pegou {quest:65602}, entregue também a {item:190309} a ele, coloque-a no mesmo círculo e derrote o íncubo.",
	-- {npc:5677} Summoned Succubus
	["{npc:5677}, at the summoning circle"] = "{npc:5677}, no círculo de evocação",
	-- {quest:65602} What Is Love?
	["{quest:65602}, if you took it"] = "{quest:65602}, se você a pegou",
	-- {npc:185335} Summoned Incubus
	["{npc:185335}, at the same circle"] = "{npc:185335}, no mesmo círculo",
	-- {npc:6122} Gakin the Darkbinder
	["{npc:6122} binds the incubus to you"] = "{npc:6122} vincula o íncubo a você",

	-- Step 16: Stormwind
	-- {npc:12336} Brother Crowley
	["{npc:12336}, Cathedral of Light"] = "{npc:12336}, Catedral da Luz",

	-- Step 18: Stormwind
	-- {npc:1440} Milton Sheaf
	["{npc:1440}, the Royal Library in the keep"] = "{npc:1440}, na Biblioteca Real da fortaleza",

	-- Step 19: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "Metrô para {zone:1455}",

	-- Step 20: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Voar para {area:271}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Mestre de voo de {zone:1455}",

	-- Step 22: Shadowy Assassin
	-- {npc:2434} Shadowy Assassin · {area:271} Southshore
	["A {npc:2434} lurks unseen on the edge of {area:271}; kill him and read the contract he carries."] = "Um {npc:2434} espreita invisível na borda de {area:271}; mate-o e leia o contrato que ele carrega.",
	-- {npc:2276} Magistrate Henry Maleb
	["{npc:2276}, inside"] = "{npc:2276}, lá dentro",

	-- Step 25: Refuge Pointe
	-- {area:287} Hillsbrad · {area:1057} Thoradin's Wall · {area:320} Refuge Pointe
	["Follow the road east out of {area:287} over {area:1057} to {area:320}."] = "Siga a estrada para leste saindo de {area:287}, passando a {area:1057}, até o {area:320}.",
	-- {npc:2700} Captain Nials · {npc:1075} Rhag Garmason
	["{npc:2700}: {npc:1075}'s plea, from 01-hillsbrad-foothills"] = "{npc:2700}: o apelo de {npc:1075}, de 01-hillsbrad-foothills",

	-- Step 26: Northfold Manor
	-- {area:320} Refuge Pointe
	["The Syndicate hold the farm north-west of {area:320}.\nCareful: Syndicate Highwaymen are level 30-31 and can cast Sneak while out of combat, so they are often stealthed and hard to spot."] = "A Camarilha ocupa a fazenda a noroeste de {area:320}.\nCuidado: os Bandoleiros da Camarilha são de nível 30-31 e ficam furtivos fora de combate, então costumam estar escondidos e difíceis de ver.",

	-- Step 27: Hay Weevil
	-- {quest:681} Northfold Manor · {npc:217412} Amaryllis Webb
	-- plural, as words: Hay Weevils = {npc:217589} Hay Weevil
	["Hay Weevils crawl about the north end of {quest:681}'s farm: catch one with the tool from {npc:217412}'s Entomology Starter Kit."] = "Gorgulhos do Feno rastejam pela ponta norte da fazenda de {quest:681}: pegue um com a ferramenta do kit de entomologia de {npc:217412}.",

	-- Step 28: Witherbark Village
	-- {area:314} Go'Shek Farm
	["A few Witherbark trolls camp south of Northfold, on the way; the main village lies in the hills south of {area:314} in the south-east, where the Witch Doctors stand and the Shadow Hunters guard the far end of the valley. Every troll can drop a tusk."] = "Alguns trolls Cascasseca acampam ao sul de Northfold, no caminho; a aldeia principal fica nas colinas ao sul de {area:314}, no sudeste, onde ficam os Mandingueiros e os Caçadores Sombrios guardam a outra ponta do vale. Todo troll pode soltar uma presa.",
	-- {item:5040} Shadow Hunter Knife
	["{item:5040}; below ground"] = "{item:5040}; no subterrâneo",

	-- Step 29: Shards of Myzrael
	-- {area:314} Go'Shek Farm · {area:333} Circle of East Binding
	["Head north past {area:314}; the shards glitter on the hill by the {area:333}."] = "Siga para o norte, passando a {area:314}; os estilhaços brilham na colina junto ao {area:333}.",
	["Only if Gluggle gave you the pendant in Stranglethorn"] = "Só se Glubglub lhe deu o pingente no Espinhaço",

	-- Step 30: Drywhisker Gorge: kill these as you meet them
	-- {area:318} Drywhisker Gorge
	["{area:318}: kill these as you meet them"] = "{area:318}: vá matando estes pelo caminho",
	-- {area:321} Hammerfall
	["The Drywhisker kobolds dig in the gorge east of {area:321} (Horde); skirt the town to the north. They drop both the motes and Krazek's ore.\nCareful: Every kobold type runs off for help when low on health (Kobolds at 30%, Surveyors and Diggers at 15%), which can pull more of them."] = "Os kobolds Bigodesseco cavam no desfiladeiro a leste de {area:321} (Horda); contorne a cidade pelo norte. Eles deixam cair tanto as partículas quanto o minério do Krazek.\nCuidado: todo tipo de kobold sai correndo atrás de ajuda com pouca vida (Kobolds com 30%, Topógrafos e Escavadores com 15%), o que pode trazer mais deles.",
	-- {item:4435} Mote of Myzrael · {npc:2572} Drywhisker Kobold · {npc:2573} Drywhisker Surveyor · {npc:2574} Drywhisker Digger
	["{item:4435} from {npc:2572}, {npc:2573} and {npc:2574}, by this stop"] = "{item:4435} de {npc:2572}, {npc:2573} e {npc:2574}, perto desta parada",

	-- Step 31: Iridescent Shards
	-- {area:318} Drywhisker Gorge
	["The shards lie at the far end of {area:318}."] = "Os estilhaços estão no fundo do {area:318}.",
	["Below ground"] = "No subterrâneo",

	-- Step 32: Stones of Binding
	-- {area:320} Refuge Pointe · {object:2702} Stone of Inner Binding
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["Each key lies at one of the Highlands' standing-stone circles: east of the shards, near {area:320} and in the west. The {object:2702} stands west of {area:320}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "Cada chave fica num dos círculos de monólitos do Planalto: a leste dos estilhaços, perto de {area:320} e no oeste. A {object:2702} fica a oeste de {area:320}.\nCuidado: cada pedra central é guardada por uns três elementais perto do nível 39, que atacam juntos se você clicar na pedra sem limpá-los antes: Exilados em Chamas no Oeste, Exilados Trovejantes no Externo, Exilados Vagalhantes no Leste.",

	-- Step 33: Quae
	-- {area:320} Refuge Pointe · {npc:2712} Quae · {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["Head back north-east past {area:320}; {npc:2712} and {npc:2713} camp in the hills north of {area:314}."] = "Volte para nordeste, passando por {area:320}; {npc:2712} e {npc:2713} acampam nas colinas ao norte de {area:314}.",

	-- Step 34: Forsaken Courier
	-- {area:314} Go'Shek Farm
	["The courier walks the road west of {area:314} with two guards; pull them off the road."] = "A mensageira anda pela estrada a oeste da {area:314} com dois guardas; atraia-os para fora da estrada.",

	-- Step 36: Quae and Kinelory
	-- {npc:2712} Quae · {npc:2713} Kinelory
	["{npc:2712} and {npc:2713}"] = "{npc:2712} e {npc:2713}",

	-- Step 37: Kinelory's errand
	-- {npc:2713} Kinelory
	["{npc:2713}'s errand"] = "A tarefa de {npc:2713}",
	-- {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["Stay with {npc:2713} while she sneaks into {area:314} and back; Horde orcs jump you on the way.\nCareful: Orcs that drop to low health run away. {npc:2713} follows them and can pull more mobs, so kill or slow runners fast."] = "Fique com {npc:2713} enquanto ela se esgueira até {area:314} e volta; orcs da Horda pulam em vocês no caminho.\nCuidado: orcs com pouca vida fogem. {npc:2713} vai atrás deles e pode puxar mais monstros, então mate ou deixe lentos os fujões rapidinho.",

	-- Step 38: Quae
	-- {npc:2711} Phin Odelic · {area:271} Southshore
	["For {npc:2711} in {area:271}"] = "Para {npc:2711} em {area:271}",

	-- Step 39: Refuge Pointe
	-- {area:320} Refuge Pointe · {object:2689} Stone of West Binding
	["West along the road to {area:320}, on the way to the {object:2689}."] = "Para oeste pela estrada até {area:320}, a caminho de {object:2689}.",
	-- {npc:2789} Skuerto · {npc:2793} Kor'gresh Coldrage · {area:327} Faldir's Cove
	["{npc:2789}: {npc:2793}'s cave comes after {area:327}"] = "{npc:2789}: a caverna de {npc:2793} vem depois de {area:327}",

	-- Step 41: Faldir's Cove
	["South along the west coast to the goblins' cove; Lolo keeps watch on the rocks above it."] = "Siga para o sul pela costa oeste até a enseada dos goblins; Lolo vigia das pedras acima dela.",

	-- Step 42: Phizzlethorpe
	["Phizzlethorpe"] = "Bruzundanga",
	["Escort the professor up the hill to the cave above the cove and guard him while he works. Two level 40 water elementals ambush him there, and they are immune to frost. Hold them at the cave mouth, away from him: if the fight happens inside the cave, he joins in instead of working and more elementals keep coming."] = "Escolte o professor morro acima até a caverna acima da enseada e proteja-o enquanto ele trabalha. Dois elementais da água de nível 40 o emboscam ali, e eles são imunes a gelo. Segure-os na boca da caverna, longe dele: se a luta for dentro da caverna, ele entra na briga em vez de trabalhar e continuam aparecendo mais elementais.",

	-- Step 44: The Drowned Reef: kill these as you meet them
	-- {area:328} The Drowned Reef
	["{area:328}: kill these as you meet them"] = "{area:328}: vá matando estes pelo caminho",
	["The two wrecks lie in the bay west of the cove. The charts and logs are inside them; the gems lie on the sea floor around them. Daggerspine naga swim the whole bay."] = "Os dois naufrágios ficam na baía a oeste da enseada. As cartas náuticas e os diários estão dentro deles; as gemas estão no fundo do mar em volta. Nagas Espinhadaga nadam pela baía inteira.",
	-- {npc:2595} Daggerspine Raider
	["{npc:2595}, underwater"] = "{npc:2595}, debaixo d'água",
	-- {item:4492} Elven Gem
	["{item:4492}; underwater"] = "{item:4492}; debaixo d'água",
	-- {npc:2596} Daggerspine Sorceress
	["{npc:2596}, underwater"] = "{npc:2596}, debaixo d'água",
	-- {object:2709} Maiden's Folly Log
	["{object:2709}; underwater"] = "{object:2709}; debaixo d'água",
	-- {object:2707} Maiden's Folly Charts
	["{object:2707}; underwater"] = "{object:2707}; debaixo d'água",
	-- {object:2710} Spirit of Silverpine Log
	["{object:2710}; underwater"] = "{object:2710}; debaixo d'água",
	-- {object:2708} Spirit of Silverpine Charts
	["{object:2708}; underwater"] = "{object:2708}; debaixo d'água",

	-- Step 45: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["For {npc:2487} in {area:35}: keep it"] = "Para {npc:2487} em {area:35}: guarde-o",

	-- Step 46: Kor'gresh Coldrage
	-- {area:327} Faldir's Cove · {npc:2793} Kor'gresh Coldrage
	["East from {area:327} through the southern hills: {npc:2793}, an ogre mage, holds the cave at the southern end of the Witherbark valley."] = "A leste de {area:327}, pelas colinas do sul: {npc:2793}, um ogro mago, ocupa a caverna no extremo sul do vale Cascasseca.",
	-- {item:4525} Trelane's Wand of Invocation
	["{item:4525}; below ground"] = "{item:4525}; no subterrâneo",

	-- Step 47: Foggy MacKreel
	-- {npc:2793} Kor'gresh Coldrage · {area:880} Thandol Span · {npc:2696} Foggy MacKreel · {quest:647} MacKreel's Moonshine · {npc:2705} Brewmeister Bilger · {area:271} Southshore · {area:320} Refuge Pointe
	["South-west from {npc:2793}'s cave to the {area:880}: {npc:2696} stands on a broken section of the bridge; jump down to him from its north end. {quest:647} must reach {npc:2705} in {area:271} within 15 minutes: go straight back to {area:320} and fly to {area:271}."] = "Ao sudoeste da caverna de {npc:2793} até {area:880}: {npc:2696} fica num trecho quebrado da ponte; pule até ele pelo extremo norte. {quest:647} precisa chegar a {npc:2705} em {area:271} em 15 minutos: volte direto a {area:320} e voe até {area:271}.",

	-- Step 49: Fly to Southshore
	-- {area:320} Refuge Pointe
	["{area:320} flight master"] = "Mestre de voo de {area:320}",

	-- Step 50: Brewmeister Bilger
	-- {area:271} Southshore
	["Off the flight, straight to the {area:271} inn."] = "Ao descer do voo, direto para a estalagem de {area:271}.",
	-- {npc:2705} Brewmeister Bilger
	["{npc:2705}, below ground"] = "{npc:2705}, no subterrâneo",

	-- Step 52: Gavin's Naze
	-- {area:271} Southshore · {area:280} Strahnbrad · {npc:2306} Baron Vardus
	["Follow the road north out of {area:271} into the mountains. Mountain lions roam the slopes; the Syndicate in {area:280} wear the signet rings, and {npc:2306} walks the manor grounds on the north side of town."] = "Siga a estrada para o norte saindo de {area:271} até as montanhas. Leões da montanha vagam pelas encostas; a Camarilha em {area:280} usa os anéis de sinete, e {npc:2306} anda pelos terrenos do solar no lado norte da cidade.",

	-- Step 53: Ruins of Alterac: kill these as you meet them
	-- {area:281} Ruins of Alterac
	["{area:281}: kill these as you meet them"] = "{area:281}: vá matando estes pelo caminho",
	-- {area:280} Strahnbrad
	-- plural, as words: Argus Shadow Mages = {npc:2318} Argus Shadow Mage · Crushridge Warmongers = {npc:2287} Crushridge Warmonger · Crushridge Maulers = {npc:2254} Crushridge Mauler · Crushridge Ogres = {npc:2252} Crushridge Ogre
	["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins.\nCareful: Crushridge Warmongers call nearby allies within 15 yd once they fall below half health.\nThe Crushridge Maulers, Mages, Enforcers and Warmongers (36-39) are elite; the Crushridge Ogres and Brutes (34-35) are not and carry the tomes too: pull one at a time, or group up."] = "Os tomos estão na fortaleza em ruínas a oeste de {area:280}; Magos das Sombras Argus dominam as ruínas.\nCuidado: Fomentadores da Guerra Massacrista chamam aliados próximos a até 15 metros quando ficam abaixo de metade da vida.\nOs Espancadores, Magos, Impositores e Fomentadores da Guerra Massacrista (36-39) são elite; os Ogros e Brutamontes Massacrista (34-35) não são e também carregam os tomos: puxe um de cada vez, ou forme grupo.",
	-- {item:3658} Recovered Tome
	["{item:3658}: Crushridge ogres"] = "{item:3658}: ogros Massacrista",
	-- {item:3659} Worn Leather Book · {object:1760} Weathered Bookcase
	["{item:3659}: the {object:1760}; inside"] = "{item:3659}: a {object:1760}; lá dentro",

	-- Step 54: Ruins of Alterac: kill these as you meet them
	-- {npc:2417} Grel'borg the Miser
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:2417} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {npc:2417} é elite de nível 40: a maioria das classes encara sozinha no nível 42, mas talvez você precise de ajuda. Se estiver sozinho, pule: a rota faz você recuperar a XP matando monstros.",

	-- Step 55: Strahnbrad: kill these as you meet them
	-- {area:280} Strahnbrad
	["{area:280}: kill these as you meet them"] = "{area:280}: vá matando estes pelo caminho",
	-- {npc:2320} Nagaz
	["Careful: Syndicate Spies and Assassins can be stealthed. Assassins also poison you.\nCareful: About three stealthed Syndicate mobs are inside {npc:2320}'s house. {npc:2320} does not join when they are pulled, and a ranged attack through the doorway brings him out by himself."] = "Cuidado: Espiões e Assassinos da Camarilha podem estar furtivos. Os Assassinos ainda envenenam você.\nCuidado: há uns três da Camarilha furtivos dentro da casa de {npc:2320}. {npc:2320} não entra quando eles são puxados, e um ataque à distância pela porta traz só ele para fora.",

	-- Step 56: Crushridge ogres
	["Crushridge ogres"] = "Ogros Massacristas",
	-- {area:280} Strahnbrad · {item:3706} Ensorcelled Parchment · {npc:2320} Nagaz · {quest:537} Dark Council
	-- plural, as words: Crushridge Maulers = {npc:2254} Crushridge Mauler · Crushridge Ogres = {npc:2252} Crushridge Ogre
	["The Crushridge ogres hold the hills north of {area:280}. Farther north, a worn wooden chest holds the {item:3706}; {npc:2320} of the {quest:537} stands right by it.\nThe Crushridge Maulers, Mages, Enforcers and Warmongers (36-39) are elite; the Crushridge Ogres and Brutes (34-35) are not and drop the knucklebones too: pull one at a time, or group up."] = "Os ogros Massacrista dominam as colinas ao norte de {area:280}. Mais ao norte, um baú de madeira gasto guarda {item:3706}; {npc:2320}, de {quest:537}, fica bem ao lado dele.\nOs Espancadores, Magos, Impositores e Fomentadores da Guerra Massacrista (36-39) são elite; os Ogros e Brutamontes Massacrista (34-35) não são e também soltam os Nós dos Dedos Sujos: puxe um de cada vez, ou forme grupo.",
	["Inside"] = "Lá dentro",

	-- Step 58: Dalaran
	-- {area:279} Dalaran · {zone:1421} Silverpine Forest · {npc:269127} Image of Archmage Modera
	["South-west to the Kirin Tor camp on the lake shore west of {area:279}, just over the border into {zone:1421}: the {npc:269127} stands there. Archmage Ansirem stands south-east of it, by the dome."] = "Para sudoeste até o acampamento do Kirin Tor na margem do lago a oeste de {area:279}, logo depois da divisa com {zone:1421}: a {npc:269127} fica lá. O Arquimago Ansirem fica a sudeste dela, junto à cúpula.",
	-- {npc:2542} Catelyn the Blade · {area:35} Booty Bay
	["For {npc:2542} in {area:35}: keep it"] = "Para {npc:2542} em {area:35}: guarde-o",

	-- Step 60: Southshore
	-- {npc:1440} Milton Sheaf · {zone:1453} Stormwind
	["For {npc:1440} in {zone:1453}: keep it"] = "Para {npc:1440} em {zone:1453}: guarde-o",
	-- {npc:2277} Loremaster Dibbs
	["{npc:2277}: the parchment"] = "{npc:2277}: o pergaminho",

	-- Step 61: Bartolo Ginsetti
	-- {npc:2438} Bartolo Ginsetti · {npc:2381} Micha Yance · {item:2321} Fine Thread
	["{npc:2438} stands between the flight master and the inn; {npc:2381} beside him sells {item:2321} if you have none."] = "{npc:2438} fica entre o mestre de voo e a estalagem; {npc:2381}, ao lado dele, vende {item:2321}, se você não tiver.",
	-- {item:2321} Fine Thread · {npc:2381} Micha Yance
	["{item:2321}, from {npc:2381}"] = "{item:2321}, de {npc:2381}",

	-- Step 64: Ironforge
	-- {npc:1356} Prospector Stormpike · {object:32356} Hall of Explorers (no name in this language: may be words) · {npc:1344} Prospector Ironband · {zone:1432} Loch Modan
	["{npc:1356}, {object:32356}: for {npc:1344} in {zone:1432}, next"] = "{npc:1356}, {object:32356}: para {npc:1344} em {zone:1432}, em seguida",

	-- Step 65: To Thelsamar
	-- {area:144} Thelsamar
	["To {area:144}"] = "",

	-- Step 66: Thelsamar
	-- {zone:1455} Ironforge · {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {area:144} Thelsamar
	["From {zone:1455} take the tunnel east through {zone:1426} into {zone:1432} and follow the road to {area:144}."] = "De {zone:1455}, pegue o túnel para leste por {zone:1426} até {zone:1432} e siga a estrada até {area:144}.",
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, below ground"] = "{npc:1470}, no subterrâneo",

	-- Step 67: Prospector Ironband
	["South-east along the loch to the dig site."] = "Para sudeste ao longo do lago até o sítio de escavação.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Each key lies at one of the Highlands' standing-stone circles: east of the shards, near {area:320} and in the west. The {object:2702} stands west of {area:320}."] = "Cada chave está num dos círculos de menires do Planalto: a leste dos estilhaços, perto do {area:320} e no oeste. A {object:2702} fica a oeste do {area:320}.",
	-- ["Ebenezer Rustlocke"] = "Ebenezer Ferratranca",
	-- ["Escort the professor to the beach north of the cove and guard him while he works; naga attack in waves."] = "Escolte o professor até a praia ao norte da enseada e proteja-o enquanto ele trabalha; os nagas atacam em ondas.",
	-- ["Follow the road south over the bridge to {area:205} at the {zone:1437} end, where {npc:1075} waits."] = "Siga a estrada para o sul pela ponte até {area:205}, no lado do {zone:1437}, onde {npc:1075} espera.",
	-- ["From {area:42} follow the road east through {zone:1430} into the {zone:1435}; Biggs guards the road junction just inside it. {npc:217412} stands a short way north of him."] = "De {area:42}, siga a estrada para leste por {zone:1430} até o {zone:1435}; Biggs vigia o cruzamento logo na entrada. {npc:217412} fica um pouco ao norte dele.",
	-- ["From {zone:1455} take the tunnel east through {zone:1426} into {area:38} and follow the road to {area:144}."] = "De {zone:1455}, pegue o túnel para leste por {zone:1426} até {area:38} e siga a estrada até {area:144}.",
	-- ["Gyll, {area:35}"] = "Gyll, {area:35}",
	-- ["Ride back north-east past {area:320}; {npc:2712} and {npc:2713} camp in the hills north of {area:314}."] = "Cavalgue de volta para nordeste, passando o {area:320}; {npc:2712} e {npc:2713} acampam nas colinas ao norte da {area:314}.",
	-- ["Shaman training"] = "Treino de xamã",
	-- ["South-east from Northfold to the Witherbark trolls in the hills south of {area:314}; Witch Doctors stand in the village, Shadow Hunters guard the far end of the valley. Every troll here can drop a tusk."] = "Ao sudeste de Northfold até os trolls Cascasseca nas colinas ao sul de {area:314}; Mandingueiros ficam na aldeia, Caçadores Sombrios guardam o extremo do vale. Todo troll daqui pode soltar uma presa.",
	-- ["South-west to the Kirin Tor camp on the lake shore west of {area:279}, just over the border into {area:130}: the {npc:269127} stands there. Archmage Ansirem stands south-east of it, by the dome."] = "Para sudoeste até o acampamento do Kirin Tor na margem do lago a oeste de {area:279}, logo depois da divisa com {area:130}: a {npc:269127} fica lá. O Arquimago Ansirem fica a sudeste dela, junto à cúpula.",
	-- ["Stay with {npc:2713} while she sneaks into {area:314} and back; Horde orcs jump you on the way."] = "Fique com {npc:2713} enquanto ela entra às escondidas na {area:314} e volta; orcs da Horda atacam vocês no caminho.",
	-- ["Subdue the succubus"] = "Subjugue a súcubo",
	-- ["The Crushridge ogres hold the hills north of {area:280}. Farther north, a worn wooden chest holds the {item:3706}; {npc:2320} of the {quest:537} stands right by it."] = "Os ogros Massacristas ocupam as colinas ao norte de {area:280}. Mais ao norte, um baú de madeira gasto guarda o {item:3706}; {npc:2320}, do {quest:537}, fica bem ao lado.",
	-- ["The Drywhisker kobolds dig in the gorge east of {area:321} (Horde); skirt the town to the north. They drop both the motes and Krazek's ore."] = "Os kobolds Bigodesseco cavam no desfiladeiro a leste de {area:321} (Horda); contorne a cidade pelo norte. Eles deixam cair tanto as partículas quanto o minério de Krazek.",
	-- ["The Syndicate hold the farm north-west of {area:320}. A {npc:217589} crawls about the farm: catch one with {npc:217412}'s Entomology Starter Kit, then tick it off."] = "A Camarilha ocupa a fazenda a noroeste do {area:320}. Um {npc:217589} rasteja pela fazenda: capture um com o kit de entomologia de {npc:217412} e depois marque-o.",
	-- ["The Syndicate hold the farm north-west of {area:320}. A {npc:217589} crawls about the farm: catch one with {npc:217412}'s Entomology Starter Kit, then tick it off.\nCareful: Syndicate Highwaymen are level 30-31 and can cast Sneak while out of combat, so they are often stealthed and hard to spot."] = "A Camarilha ocupa a fazenda a noroeste de {area:320}. Um {npc:217589} rasteja pela fazenda: pegue um com o kit de entomologia de {npc:217412} e marque.\nCuidado: os Bandoleiros da Camarilha são nível 30-31 e ficam furtivos fora de combate, então costumam estar escondidos e difíceis de ver.",
	-- ["The Witherbark trolls live in the hills south of {area:314}; Witch Doctors stand in the village, Shadow Hunters guard the far end of the valley."] = "Os trolls Cascasseca vivem nas colinas ao sul da {area:314}; os Mandingueiros ficam na aldeia, os Caçadores Sombrios guardam o fundo do vale.",
	-- ["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins."] = "Os tomos estão na fortaleza em ruínas a oeste de {area:280}; Magos das Sombras Argus ocupam as ruínas.",
	-- ["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins.\nCareful: Crushridge Warmongers call nearby allies within 15 yd once they fall below half health."] = "Os tomos estão na fortaleza em ruínas a oeste de {area:280}; Magos das Sombras Argus ocupam as ruínas.\nCuidado: os Fomentadores da Guerra Massacrista chamam aliados num raio de 15 m quando ficam abaixo de metade da vida.",
	-- ["The wrecked caravan lies off the road near Biggs."] = "A caravana destruída fica fora da estrada, perto de Biggs.",
	-- ["The wrecks"] = "Os naufrágios",
	-- ["Walk back onto the span: Ebenezer lies under its Arathi end."] = "Volte para a ponte: Ebenezer está embaixo da ponta do lado de Arathi.",
	-- ["West along the coast to the goblins' cove; Lolo keeps watch on the rocks above it."] = "Para oeste pela costa até a enseada dos goblins; Lolo vigia das pedras acima dela.",
	-- ["{item:2321} for {npc:2438}'s cloak, from {npc:2381}, if you have none"] = "{item:2321} para o manto de {npc:2438}, de {npc:2381}, se você não tiver",
	-- ["{item:3659}: the {object:1760}"] = "{item:3659}: {object:1760}",
	-- ["{npc:217589}: catch it, for {quest:93176}"] = "{npc:217589}: capture-o, para {quest:93176}",
	-- ["{npc:2438}, if you took his cloak quest"] = "{npc:2438}, se você pegou a missão do manto dele",
	-- ["{npc:252085}, in the City of Dalaran"] = "{npc:252085}, na Cidade de Dalaran",
	-- ["{npc:2793}, an ogre mage, holds the cave at the southern end of the Witherbark valley."] = "{npc:2793}, um ogro mago, ocupa a caverna no extremo sul do vale Cascasseca.",
	-- ["{npc:5476} guards the road junction in the west of the swamp. {npc:217412} stands a short way north of him."] = "{npc:5476} guarda o entroncamento no oeste do pântano. {npc:217412} fica um pouco ao norte dele.",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train with {npc:258098}. {npc:1573} in the {object:32372} flies to {area:271} too."] = "{zone:1453} não tem instrutor de xamã: pegue o {area:2257} no {object:28027} até {zone:1455} e treine com {npc:258098}. {npc:1573}, na {object:32372}, também voa para {area:271}.",
}
