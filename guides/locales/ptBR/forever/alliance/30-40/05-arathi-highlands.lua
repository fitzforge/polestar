-- Portuguese (Brazil) (ptBR): the guide forever/alliance/30-40/05-arathi-highlands (forever/alliance/30-40/05-arathi-highlands.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	["Gyll, {area:35}"] = "Gyll, {area:35}",

	-- Step 2: Watcher Biggs
	-- {area:42} Darkshire · {zone:1430} Deadwind Pass · {zone:1435} Swamp of Sorrows · {npc:217412} Amaryllis Webb
	["From {area:42} follow the road east through {zone:1430} into the {zone:1435}; Biggs guards the road junction just inside it. {npc:217412} stands a short way north of him."] = "De {area:42}, siga a estrada para leste por {zone:1430} até o {zone:1435}; Biggs vigia o cruzamento logo na entrada. {npc:217412} fica um pouco ao norte dele.",
	-- {npc:217412} Amaryllis Webb · {zone:1443} Desolace
	["{npc:217412}: three critters to catch in Arathi, {zone:1443} and Stranglethorn"] = "{npc:217412}: três bichinhos para capturar em Arathi, {zone:1443} e no Espinhaço",

	-- Step 3: The western swamp
	["The western swamp"] = "O pântano oeste",
	-- plural, as words: Sorrow Spinners = {npc:858} Sorrow Spinner · Swamp Jaguars = {npc:767} Swamp Jaguar
	["Young crocolisks, Sorrow Spinners and Swamp Jaguars all roam the swamp around the road."] = "Crocoliscos jovens, Tece-mágoas e Jaguares do Pântano vagam pelo pântano em volta da estrada.",

	-- Step 5: The Lost Caravan
	["The wrecked caravan lies off the road near Biggs."] = "A caravana destruída fica fora da estrada, perto de Biggs.",

	-- Step 7: The Harborage
	-- {area:657} The Harborage
	["Follow the road north to the draenei of the {area:657}."] = "Siga a estrada para o norte até os draeneis do {area:657}.",

	-- Step 8: Fallow Sanctuary
	-- {area:76} Fallow Sanctuary · {npc:256028} The Lost One
	["East along the road to the {area:76}. {npc:256028} mobs drop the crystals; Noboru walks the ruins and drops his cudgel."] = "Para leste pela estrada até o {area:76}. Os {npc:256028} deixam cair os cristais; Noboru anda pelas ruínas e deixa cair sua borduna.",

	-- Step 9: Galen Goodward
	-- {npc:5391} Galen Goodward
	["{npc:5391} is caged at the north end of the sanctuary. Free him and keep him alive on the walk out; his strongbox waits by the road afterwards."] = "{npc:5391} está preso numa jaula no extremo norte do santuário. Liberte-o e mantenha-o vivo na saída; o cofre dele aparece depois junto à estrada.",

	-- Step 11: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Voar para {zone:1453}",
	-- {zone:1430} Deadwind Pass · {area:42} Darkshire
	["Back west through {zone:1430} to {area:42}."] = "De volta para oeste por {zone:1430} até {area:42}.",

	-- Step 12: Stormwind
	-- {npc:1141} Angus Stern · {area:17203} Stormwind Harbor
	["{npc:1141}, {area:17203} road"] = "{npc:1141}, na estrada do {area:17203}",
	-- {npc:12336} Brother Crowley
	["{npc:12336}, Cathedral of Light"] = "{npc:12336}, Catedral da Luz",
	-- {npc:1440} Milton Sheaf
	["{npc:1440}, the Royal Library in the keep"] = "{npc:1440}, na Biblioteca Real da fortaleza",

	-- Step 13: The Binding
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {item:6913} Heartswood Core · {quest:65602} What Is Love? · {item:190309} Wooden Figurine
	["{npc:6122} waits in the {object:2164}'s cellar, in the {object:2101}. Use the {item:6913} at the summoning circle there and defeat the succubus it calls. If you took {quest:65602}, hand him the {item:190309} too, place it at the same circle and defeat the incubus."] = "{npc:6122} espera no porão do {object:2164}, no {object:2101}. Use o {item:6913} no círculo de evocação de lá e derrote a súcubo que ele chama. Se você pegou {quest:65602}, entregue também a {item:190309} a ele, coloque-a no mesmo círculo e derrote o íncubo.",
	["Subdue the succubus"] = "Subjugue a súcubo",
	-- {quest:65602} What Is Love?
	["{quest:65602}, if you took it"] = "{quest:65602}, se você a pegou",
	-- {npc:185335} Summoned Incubus
	["{npc:185335}, at the same circle"] = "{npc:185335}, no mesmo círculo",
	-- {npc:6122} Gakin the Darkbinder
	["{npc:6122} binds the incubus to you"] = "{npc:6122} vincula o íncubo a você",

	-- Step 14: Shaman training
	["Shaman training"] = "Treino de xamã",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker · {npc:1573} Gryth Thurden · {object:32372} Great Forge (no name in this language: may be words) · {area:271} Southshore
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train with {npc:258098}. {npc:1573} in the {object:32372} flies to {area:271} too."] = "{zone:1453} não tem instrutor de xamã: pegue o {area:2257} no {object:28027} até {zone:1455} e treine com {npc:258098}. {npc:1573}, na {object:32372}, também voa para {area:271}.",

	-- Step 15: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Voar para {area:271}",

	-- Step 17: Shadowy Assassin
	-- {npc:2434} Shadowy Assassin · {area:271} Southshore
	["A {npc:2434} lurks unseen on the edge of {area:271}; kill him and read the contract he carries."] = "Um {npc:2434} espreita invisível na borda de {area:271}; mate-o e leia o contrato que ele carrega.",

	-- Step 18: Refuge Pointe
	-- {area:287} Hillsbrad · {area:1057} Thoradin's Wall · {area:320} Refuge Pointe
	["Follow the road east out of {area:287} over {area:1057} to {area:320}."] = "Siga a estrada para leste saindo de {area:287}, passando a {area:1057}, até o {area:320}.",

	-- Step 19: Northfold Manor
	-- {area:320} Refuge Pointe · {npc:217589} Hay Weevil · {npc:217412} Amaryllis Webb
	["The Syndicate hold the farm north-west of {area:320}. A {npc:217589} crawls about the farm: catch one with {npc:217412}'s Entomology Starter Kit, then tick it off."] = "A Camarilha ocupa a fazenda a noroeste do {area:320}. Um {npc:217589} rasteja pela fazenda: capture um com o kit de entomologia de {npc:217412} e depois marque-o.",
	-- {npc:217589} Hay Weevil · {quest:93176} My Little Friends
	["{npc:217589}: catch it, for {quest:93176}"] = "{npc:217589}: capture-o, para {quest:93176}",

	-- Step 21: Thandol Span
	-- {area:205} Dun Modr · {zone:1437} Wetlands · {npc:1075} Rhag Garmason
	["Follow the road south over the bridge to {area:205} at the {zone:1437} end, where {npc:1075} waits."] = "Siga a estrada para o sul pela ponte até {area:205}, no lado do {zone:1437}, onde {npc:1075} espera.",

	-- Step 22: Ebenezer Rustlocke
	["Ebenezer Rustlocke"] = "Ebenezer Ferratranca",
	["Walk back onto the span: Ebenezer lies under its Arathi end."] = "Volte para a ponte: Ebenezer está embaixo da ponta do lado de Arathi.",

	-- Step 23: Faldir's Cove
	["West along the coast to the goblins' cove; Lolo keeps watch on the rocks above it."] = "Para oeste pela costa até a enseada dos goblins; Lolo vigia das pedras acima dela.",

	-- Step 24: Phizzlethorpe
	["Phizzlethorpe"] = "Bruzundanga",
	["Escort the professor to the beach north of the cove and guard him while he works; naga attack in waves."] = "Escolte o professor até a praia ao norte da enseada e proteja-o enquanto ele trabalha; os nagas atacam em ondas.",

	-- Step 26: The wrecks
	["The wrecks"] = "Os naufrágios",
	["The two wrecks lie in the bay west of the cove. The charts and logs are inside them; the gems lie on the sea floor around them. Daggerspine naga swim the whole bay."] = "Os dois naufrágios ficam na baía a oeste da enseada. As cartas náuticas e os diários estão dentro deles; as gemas estão no fundo do mar em volta. Nagas Espinhadaga nadam pela baía inteira.",

	-- Step 27: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["For {npc:2487} in {area:35}: keep it"] = "Para {npc:2487} em {area:35}: guarde-o",

	-- Step 28: Quae
	-- {area:320} Refuge Pointe · {npc:2712} Quae · {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["Ride back north-east past {area:320}; {npc:2712} and {npc:2713} camp in the hills north of {area:314}."] = "Cavalgue de volta para nordeste, passando o {area:320}; {npc:2712} e {npc:2713} acampam nas colinas ao norte da {area:314}.",

	-- Step 29: Forsaken Courier
	-- {area:314} Go'Shek Farm
	["The courier walks the road west of {area:314} with two guards; pull them off the road."] = "A mensageira anda pela estrada a oeste da {area:314} com dois guardas; atraia-os para fora da estrada.",

	-- Step 30: Quae and Kinelory
	-- {npc:2712} Quae · {npc:2713} Kinelory
	["{npc:2712} and {npc:2713}"] = "{npc:2712} e {npc:2713}",

	-- Step 31: Kinelory's errand
	-- {npc:2713} Kinelory
	["{npc:2713}'s errand"] = "A tarefa de {npc:2713}",
	-- {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["Stay with {npc:2713} while she sneaks into {area:314} and back; Horde orcs jump you on the way."] = "Fique com {npc:2713} enquanto ela entra às escondidas na {area:314} e volta; orcs da Horda atacam vocês no caminho.",

	-- Step 32: Quae
	-- {npc:2711} Phin Odelic · {area:271} Southshore
	["For {npc:2711} in {area:271}"] = "Para {npc:2711} em {area:271}",

	-- Step 33: Shards of Myzrael
	-- {area:314} Go'Shek Farm · {area:333} Circle of East Binding
	["Head north past {area:314}; the shards glitter on the hill by the {area:333}."] = "Siga para o norte, passando a {area:314}; os estilhaços brilham na colina junto ao {area:333}.",
	["Only if Gluggle gave you the pendant in Stranglethorn"] = "Só se Glubglub lhe deu o pingente no Espinhaço",

	-- Step 34: Drywhisker Gorge
	-- {area:321} Hammerfall
	["The Drywhisker kobolds dig in the gorge east of {area:321} (Horde); skirt the town to the north. They drop both the motes and Krazek's ore."] = "Os kobolds Bigodesseco cavam no desfiladeiro a leste de {area:321} (Horda); contorne a cidade pelo norte. Eles deixam cair tanto as partículas quanto o minério de Krazek.",

	-- Step 35: Iridescent Shards
	-- {area:318} Drywhisker Gorge
	["The shards lie at the far end of {area:318}."] = "Os estilhaços estão no fundo do {area:318}.",

	-- Step 36: Witherbark Village
	-- {area:314} Go'Shek Farm
	["The Witherbark trolls live in the hills south of {area:314}; Witch Doctors stand in the village, Shadow Hunters guard the far end of the valley."] = "Os trolls Cascasseca vivem nas colinas ao sul da {area:314}; os Mandingueiros ficam na aldeia, os Caçadores Sombrios guardam o fundo do vale.",

	-- Step 37: Stones of Binding
	-- {area:320} Refuge Pointe · {object:2702} Stone of Inner Binding
	["Each key lies at one of the Highlands' standing-stone circles: east of the shards, near {area:320} and in the west. The {object:2702} stands west of {area:320}."] = "Cada chave está num dos círculos de menires do Planalto: a leste dos estilhaços, perto do {area:320} e no oeste. A {object:2702} fica a oeste do {area:320}.",

	-- Step 39: Kor'gresh Coldrage
	-- {npc:2793} Kor'gresh Coldrage
	["{npc:2793}, an ogre mage, holds the cave at the southern end of the Witherbark valley."] = "{npc:2793}, um ogro mago, ocupa a caverna no extremo sul do vale Cascasseca.",

	-- Step 41: Alterac Mountains
	-- {area:271} Southshore · {area:280} Strahnbrad · {npc:2306} Baron Vardus
	["Follow the road north out of {area:271} into the mountains. Mountain lions roam the slopes; the Syndicate in {area:280} wear the signet rings, and {npc:2306} walks the manor grounds on the north side of town."] = "Siga a estrada para o norte saindo de {area:271} até as montanhas. Leões da montanha vagam pelas encostas; a Camarilha em {area:280} usa os anéis de sinete, e {npc:2306} anda pelos terrenos do solar no lado norte da cidade.",

	-- Step 42: Crushridge ogres
	["Crushridge ogres"] = "Ogros Massacristas",
	-- {area:280} Strahnbrad · {item:3706} Ensorcelled Parchment · {npc:2320} Nagaz · {quest:537} Dark Council
	["The Crushridge ogres hold the hills north of {area:280}. Farther north, a worn wooden chest holds the {item:3706}; {npc:2320} of the {quest:537} stands right by it."] = "Os ogros Massacristas ocupam as colinas ao norte de {area:280}. Mais ao norte, um baú de madeira gasto guarda o {item:3706}; {npc:2320}, do {quest:537}, fica bem ao lado.",

	-- Step 43: Ruins of Alterac
	-- {area:280} Strahnbrad
	-- plural, as words: Argus Shadow Mages = {npc:2318} Argus Shadow Mage
	["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins."] = "Os tomos estão na fortaleza em ruínas a oeste de {area:280}; Magos das Sombras Argus ocupam as ruínas.",

	-- Step 44: Dalaran
	-- {area:279} Dalaran · {zone:1421} Silverpine Forest · {npc:269127} Image of Archmage Modera
	["South-west to the Kirin Tor camp on the lake shore west of {area:279}, just over the border into {zone:1421}: the {npc:269127} stands there. Archmage Ansirem stands south-east of it, by the dome."] = "Para sudoeste até o acampamento do Kirin Tor na margem do lago a oeste de {area:279}, logo depois da divisa com {zone:1421}: a {npc:269127} fica lá. O Arquimago Ansirem fica a sudeste dela, junto à cúpula.",
	-- {npc:2542} Catelyn the Blade · {area:35} Booty Bay
	["For {npc:2542} in {area:35}: keep it"] = "Para {npc:2542} em {area:35}: guarde-o",
	-- {npc:252085} Archmage Celindra
	["{npc:252085}, in the City of Dalaran"] = "{npc:252085}, na Cidade de Dalaran",

	-- Step 45: Southshore
	-- {item:2321} Fine Thread · {npc:2438} Bartolo Ginsetti · {npc:2381} Micha Yance
	["{item:2321} for {npc:2438}'s cloak, from {npc:2381}, if you have none"] = "{item:2321} para o manto de {npc:2438}, de {npc:2381}, se você não tiver",
	-- {npc:1440} Milton Sheaf · {zone:1453} Stormwind
	["For {npc:1440} in {zone:1453}: keep it"] = "Para {npc:1440} em {zone:1453}: guarde-o",

	-- Step 47: Thelsamar
	-- {zone:1455} Ironforge · {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {area:144} Thelsamar
	["From {zone:1455} take the tunnel east through {zone:1426} into {zone:1432} and follow the road to {area:144}."] = "De {zone:1455}, pegue o túnel para leste por {zone:1426} até {zone:1432} e siga a estrada até {area:144}.",

	-- Step 48: Ironband's Excavation Site
	["South-east along the loch to the dig site."] = "Para sudeste ao longo do lago até o sítio de escavação.",
}
