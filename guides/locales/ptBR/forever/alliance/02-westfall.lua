-- Portuguese (Brazil) (ptBR): the guide forever/alliance/02-westfall (forever/alliance/02-westfall.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle · {npc:821} Captain Danuvin · {npc:491} Quartermaster Lewis · {npc:878} Scout Galiaan · {npc:253092} Alba Fairmoon · {npc:523} Thor
	["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} and {npc:253092} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234} e {npc:821} ficam no alto da torre de pedra. {npc:491} está na torre; {npc:878} e {npc:253092}, no lado sul do morro, junto à estalagem e a {npc:523}, o mestre de grifos.",
	-- {npc:523} Thor
	["{npc:523}; skip the free flight it offers"] = "{npc:523}; pule o voo grátis que ele oferece",

	-- Step 2: Saldean's Farm
	-- {npc:233} Farmer Saldean · {npc:235} Salma Saldean · {npc:253395} Ozwin Ironsprocket
	["Follow the road north. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west."] = "Siga a estrada para o norte. {npc:233} fica do lado de fora, {npc:235} dentro da casa e {npc:253395} no celeiro a oeste.",

	-- Step 3: The Jansen Stead
	["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go and fill the vial at the stead's well."] = "Mais ao norte pela estrada. Os Taturana estão sentados junto à fazenda incendiada. No caminho, colete a aveia dos Sacos de Aveia nos campos e encha o frasco no poço da propriedade.",
	-- {item:1972} Westfall Deed
	["Only if you looted a {item:1972} in Elwynn: right-click it"] = "Só se você saqueou uma {item:1972} na Floresta de Elwynn: clique nela com o botão direito",
	["Fill the vial at the well"] = "Encha o frasco no poço",
	["Sacks of Oats"] = "Sacos de Aveia",

	-- Step 4: Saldean's Farm
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way back."] = "Goretuscos Jovens e Ripa-carnes vagam pelos campos ao redor da fazenda: comece a juntar fígados e a carne do ensopado na volta.",

	-- Step 5: Molsen Farm
	-- {item:732} Okra · {item:255155} Precessive Autocognition Assembly · {npc:573} Foe Reaper 4000
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["West of Saldean's. Harvest Watchers and Golems work the fields; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone. Keep killing Goretusks and Fleshrippers on every leg of this loop."] = "A oeste da fazenda Saldanha. Guarda-colheitas e Golens Colheiteiros trabalham nos campos; eles soltam as isomolas, os giroestabilizadores, {item:732} e às vezes um {item:255155}. {npc:573}, um raro de nível 20, anda por aqui: deixe-o em paz. Continue matando Goretuscos e Ripa-carnes em cada trecho deste circuito.",
	["Fill the vial at the farm's well"] = "Encha o frasco no poço da fazenda",
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Harvest Watchers"] = "Guarda-colheitas",
	-- {item:729} Stringy Vulture Meat
	["{item:729}: Fleshrippers"] = "{item:729}: Ripa-carnes",

	-- Step 6: The Gold Coast Quarry
	-- {area:113} Gold Coast Quarry
	["The {area:113}"] = "{area:113}",
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["West of Molsen Farm, toward the coast. Riverpaw Miners work the quarry."] = "A oeste da Fazenda dos Peçanha, rumo ao litoral. Mineradores Pata Molhada trabalham na pedreira.",
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["Riverpaw Miners"] = "Mineradores Pata Molhada",

	-- Step 7: Jangolode Mine
	-- {object:290} Furlbrow's Wardrobe
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper · Kobold Diggers = {npc:1236} Kobold Digger
	["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine, Kobold Diggers work inside. {object:290} stands by the ruined house east of the mine."] = "Ao norte da Fazenda dos Peçanha. Coureadores e Contrabandistas Défias acampam do lado de fora da mina; Escavadores Kobold trabalham lá dentro. {object:290} fica junto à casa em ruínas a leste da mina.",
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Kobold Diggers"] = "Escavadores Kobold",
	-- {quest:153} Red Leather Bandanas
	["{quest:153}: every Defias drops them"] = "{quest:153}: todos os Défias as soltam",

	-- Step 8: The north coast
	["The north coast"] = "O litoral norte",
	-- plural, as words: Murloc Coastrunners = {npc:126} Murloc Coastrunner
	["Murloc Coastrunners and Raiders line the beach north of the mine. They flee at low health: pull one at a time."] = "Murlocs Correcosta e Murlocs Saqueadores ocupam a praia ao norte da mina. Eles fogem com pouca vida: puxe um de cada vez.",
	-- plural, as words: Longshore Murloc Gills = {item:254548} Longshore Murloc Gill
	["Longshore Murloc Gills"] = "Barbatanas de Murloc da Praia Grande",

	-- Step 9: The gnoll hills
	["The gnoll hills"] = "As colinas dos gnolls",
	-- {area:916} The Jansen Stead
	-- plural, as words: Riverpaw Gnolls = {npc:117} Riverpaw Gnoll
	["Riverpaw Gnolls and Scouts roam the hills between the coast and the {area:916}."] = "Gnolls e Batedores Pata Molhada vagam pelas colinas entre o litoral e o {area:916}.",
	-- plural, as words: Gnoll Paws = {item:725} Gnoll Paw
	["Gnoll Paws"] = "Patas de Gnoll",

	-- Step 11: Saldean's Farm
	["Only if he takes the isosprings alone"] = "Só se ele aceitar apenas as isomolas",

	-- Step 13: The western farms
	["The western farms"] = "As fazendas do oeste",
	-- {area:108} Sentinel Hill · {area:20} Moonbrook
	-- plural, as words: Defias Pillagers = {npc:589} Defias Pillager
	["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}."] = "Pilhadores e Gatunos Défias ocupam as fazendas a oeste de {area:108}, entre a estrada do litoral e {area:20}.",

	-- Step 15: Moonbrook and the Defias hills
	-- {area:20} Moonbrook
	["{area:20} and the Defias hills"] = "{area:20} e as colinas Défias",
	-- {area:20} Moonbrook · {area:1581} The Deadmines
	-- plural, as words: Defias Pathstalkers = {npc:121} Defias Pathstalker
	["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon."] = "Tocaiantes e Rufiões Défias andam por {area:20}; Bandoleiros (nível 17) patrulham em duplas as colinas ao sul e a leste: puxe-os separados. A entrada de {area:1581}, na ferraria, é uma masmorra de grupo.",
	-- {item:254676} Suspicious Industrial Supplies · {area:20} Moonbrook
	["{item:254676}, from the crates around {area:20}"] = "{item:254676}, dos caixotes ao redor de {area:20}",

	-- Step 16: Back to Sentinel Hill
	-- {area:108} Sentinel Hill
	["Back to {area:108}"] = "De volta a {area:108}",
	["Hearthstone on cooldown? Follow the road north-east."] = "Pedra de Regresso em recarga? Siga a estrada para o nordeste.",
	-- {npc:266} Wiley the Black · {area:69} Lakeshire
	["For {npc:266} in {area:69}, Redridge"] = "Para {npc:266} em {area:69}, Montanhas Cristarrubra",
	-- {npc:11026} Sprite Jumpsprocket · {zone:1453} Stormwind · {object:28027} Dwarven District
	["For {npc:11026} in {zone:1453}'s {object:28027}"] = "Para {npc:11026} em {object:28027}, {zone:1453}",

	-- Step 17: Defensive Stance
	-- {zone:1453} Stormwind · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern
	["Fly or ride to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "Voe ou cavalgue até {zone:1453}. {npc:5480} treina guerreiros em {object:2100}; {npc:6089} e {npc:6090} ficam juntos perto de {object:2152}, ali. {npc:6090} luta com você pela caneca dele.",

	-- Step 18: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena
	["Fly or ride to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "Voe ou cavalgue até {zone:1453}. {npc:376} está na Catedral da Luz.",

	-- Step 19: Shaman training
	["Shaman training"] = "Treinamento de xamã",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["Ride to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "Cavalgue até {zone:1453}. Lá não há instrutor de xamãs: pegue o {area:2257} em {object:28027} até {zone:1455}, treine com {npc:258098} e volte de metrô para pegar o barco.",

	-- Step 20: Stormwind
	-- {zone:1453} Stormwind · {object:2100} Old Town · {object:2101} Mage Quarter · {npc:11026} Sprite Jumpsprocket · {object:28027} Dwarven District · {npc:279} Morgan Pestle · {object:2096} Trade District
	["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids). {npc:11026} works in the {object:28027}, {npc:279} in the {object:2096}."] = "Voe ou cavalgue até {zone:1453}. Instrutores: {object:2100} (guerreiros, ladinos), a Catedral da Luz (paladinos, sacerdotes), {object:2101} (magos, bruxos), o Parque (druidas). {npc:11026} trabalha em {object:28027}; {npc:279}, em {object:2096}.",
	["Level 12, 14 and 16 spells"] = "Feitiços de nível 12, 14 e 16",
	-- {item:2449} Earthroot · {zone:1439} Darkshore · {npc:1313} Maria Lumere
	["{item:2449} for Gathering the Cure (6123) in {zone:1439}: {npc:1313}, Alchemy Supplies; herbalists pick it there instead"] = "{item:2449} para Colhendo a cura (6123) em {zone:1439}: {npc:1313}, Suprimentos de Alquimia; herbalistas a colhem lá mesmo",
	-- {npc:5497} Jennea Cannon · {quest:1861} Mirror Lake
	["{npc:5497}, Wizard's Sanctum: {quest:1861}"] = "{npc:5497}, no Sacrário dos Teurgos: {quest:1861}",

	-- Step 21: Fishin' Time
	-- {npc:5494} Catherine Leland · {object:2096} Trade District · {npc:267118} Gilbert Gray
	["{npc:5494} sells fishing supplies along the canal just west of the {object:2096}; {npc:267118} fishes at the harbor, on the way to the boat."] = "{npc:5494} vende suprimentos de pesca junto ao canal, logo a oeste de {object:2096}; {npc:267118} pesca no porto, a caminho do barco.",
	-- {item:6529} Shiny Bauble · {npc:5494} Catherine Leland
	["{item:6529}, from {npc:5494}"] = "{item:6529}, de {npc:5494}",
}
