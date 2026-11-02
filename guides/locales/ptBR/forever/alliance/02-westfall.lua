-- Portuguese (Brazil) (ptBR): the guide forever/alliance/02-westfall (forever/alliance/02-westfall.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Jansen Stead
	-- {area:40} Westfall · {object:2724} Sack of Oats
	["Follow the road from Elwynn into {area:40}: the Furlbrows sit by their burned farm, the first one on the road. Pick up oats from any {object:2724} you pass on the loop: the rest are gathered in the fields here on the way back."] = "",
	-- {npc:237} Farmer Furlbrow · {npc:963} Deputy Rainer
	["{npc:237}; Humans took it from {npc:963} in Elwynn"] = "{npc:237}; Humanos tomaram de {npc:963} em Elwynn",

	-- Step 3: The Jansen Stead
	-- {item:1972} Westfall Deed
	["Only if you looted a {item:1972} in Elwynn: right-click it"] = "Só se você saqueou uma {item:1972} na Floresta de Elwynn: clique nela com o botão direito",

	-- Step 4: Saldean's Farm
	-- {npc:233} Farmer Saldean · {npc:235} Salma Saldean · {npc:253395} Ozwin Ironsprocket
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["South along the road, past the fork. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west. Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way."] = "Ao sul pela estrada, passando pelo cruzamento. {npc:233} está do lado de fora, {npc:235} dentro da casa, {npc:253395} no celeiro a oeste. Jovens Presas e Estraçalhadores rondam os campos ao redor da fazenda: comece pelos fígados e pela carne do ensopado pelo caminho.",
	-- {npc:235} Salma Saldean
	["{npc:235}, inside"] = "",

	-- Step 5: Goretusk Snout on the way
	-- {item:731} Goretusk Snout
	["{item:731} on the way"] = "",

	-- Step 6: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle · {npc:821} Captain Danuvin · {npc:491} Quartermaster Lewis · {npc:878} Scout Galiaan · {npc:523} Thor
	["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234} e {npc:821} ficam no alto da torre de pedra. {npc:491} está na torre; {npc:878}, no lado sul do morro, junto à estalagem e a {npc:523}, o mestre de grifos.",
	-- {npc:491} Quartermaster Lewis
	["{npc:491}, inside"] = "",
	-- {npc:523} Thor
	["{npc:523}; skip the free flight it offers"] = "{npc:523}; pule o voo grátis que ele oferece",
	-- {npc:253092} Alba Fairmoon · {npc:878} Scout Galiaan
	["{npc:253092}, beside {npc:878}"] = "{npc:253092}, ao lado de {npc:878}",

	-- Step 8: Westfall: kill these as you meet them
	-- {area:40} Westfall
	["{area:40}: kill these as you meet them"] = "",
	-- {object:290} Furlbrow's Wardrobe · {item:732} Okra · {item:255155} Precessive Autocognition Assembly · {npc:573} Foe Reaper 4000
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper · Harvest Watchers = {npc:114} Harvest Watcher
	["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine. {object:290} stands by the ruined house east of the mine.\nWest of Saldean's. Harvest Watchers and Golems work the fields; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone. Keep killing Goretusks and Fleshrippers on every leg of this loop."] = "",
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Harvest Watchers"] = "Guarda-colheitas",

	-- Step 10: The Jansen Stead
	["Fill the vial at the well"] = "Encha o frasco no poço",

	-- Step 11: Westfall: kill these as you meet them
	["Fill the vial at the farm's well"] = "Encha o frasco no poço da fazenda",
	-- {item:729} Stringy Vulture Meat
	["{item:729}: Fleshrippers"] = "{item:729}: Ripa-carnes",

	-- Step 12: Furlbrow's Pumpkin Farm: kill these as you meet them
	-- {area:109} Furlbrow's Pumpkin Farm
	["{area:109}: kill these as you meet them"] = "",
	-- {area:111} Jangolode Mine · {area:916} The Jansen Stead · {npc:502} Benny Blaanco
	-- plural, as words: Riverpaw Gnolls = {npc:117} Riverpaw Gnoll · Murloc Coastrunners = {npc:126} Murloc Coastrunner
	["Riverpaw Gnolls and Scouts (level 11-13) roam the hills south of the coast, from above {area:111} east to the {area:916}. The gnolls further south and west are 13-19: stay in the north hills.\nMurloc Coastrunners and Raiders line the beach north of the mine. They flee at low health: pull one at a time.\nCareful: Gnolls that stand close together tend to join a fight as a group. Pulling one at a time is safer.\nCareful: Two Defias stand guard inside the house, one of them the level 15 named {npc:502}. They are linked, so attacking either one brings both."] = "",
	-- {quest:153} Red Leather Bandanas
	["{quest:153}: every Defias drops them"] = "{quest:153}: todos os Défias as soltam",
	-- plural, as words: Gnoll Paws = {item:725} Gnoll Paw
	["Gnoll Paws"] = "Patas de Gnoll",
	-- {object:290} Furlbrow's Wardrobe
	["{object:290}; inside"] = "",
	-- plural, as words: Longshore Murloc Gills = {item:254548} Longshore Murloc Gill
	["Longshore Murloc Gills"] = "Barbatanas de Murloc da Praia Grande",

	-- Step 13: Handful of Oats
	["Sacks of Oats in the fields around the farm"] = "",

	-- Step 14: Saldean's Farm
	["Inside"] = "",

	-- Step 15: Sentinel Hill
	-- {npc:266} Wiley the Black · {area:69} Lakeshire
	["For {npc:266} in {area:69}, Redridge"] = "Para {npc:266} em {area:69}, Montanhas Cristarrubra",

	-- Step 16: Jangolode Mine
	-- {area:918} Molsen Farm
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Back north past {area:918} to the mine: Kobold Diggers work inside."] = "Volte ao norte, passando por {area:918}, até a mina: Escavadores Kobold trabalham lá dentro.",
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Kobold Diggers"] = "Escavadores Kobold",

	-- Step 17: The Gold Coast Quarry
	-- {area:113} Gold Coast Quarry
	["The {area:113}"] = "{area:113}",
	-- {area:918} Molsen Farm
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["South-west to the coast, west of {area:918}. Riverpaw Miners work the quarry."] = "Para sudoeste, até o litoral, a oeste de {area:918}. Mineradores Pata Molhada trabalham na pedreira.",
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["Riverpaw Miners"] = "Mineradores Pata Molhada",

	-- Step 18: Moonbrook: kill these as you meet them
	-- {area:20} Moonbrook
	["{area:20}: kill these as you meet them"] = "",
	-- {area:108} Sentinel Hill · {area:20} Moonbrook · {area:113} Gold Coast Quarry
	-- plural, as words: Defias Pillagers = {npc:589} Defias Pillager
	["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}.\nCareful: The {area:113} cave holds many Defias packed together, so it is easy to pull several at once there."] = "",

	-- Step 20: Moonbrook and the Defias hills
	-- {area:20} Moonbrook
	["{area:20} and the Defias hills"] = "{area:20} e as colinas Défias",
	-- {area:20} Moonbrook · {area:1581} The Deadmines
	-- plural, as words: Defias Pathstalkers = {npc:121} Defias Pathstalker
	["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon.\nCareful: The camps in the hills hold mixed groups of Defias, so it is easy to pull more than one at a time if you are low level."] = "",
	-- {item:254676} Suspicious Industrial Supplies · {area:20} Moonbrook
	["{item:254676}, from the crates around {area:20}"] = "{item:254676}, dos caixotes ao redor de {area:20}",

	-- Step 21: Hearth to Sentinel Hill
	-- {area:108} Sentinel Hill
	["Hearth to {area:108}"] = "",

	-- Step 22: Back to Sentinel Hill
	-- {area:108} Sentinel Hill
	["Back to {area:108}"] = "De volta a {area:108}",
	-- {npc:11026} Sprite Jumpsprocket · {zone:1453} Stormwind · {object:28027} Dwarven District
	["For {npc:11026} in {zone:1453}'s {object:28027}"] = "Para {npc:11026} em {object:28027}, {zone:1453}",

	-- Step 24: Defensive Stance
	-- {zone:1453} Stormwind · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern
	["Fly or walk to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "Voe ou caminhe até {zone:1453}. {npc:5480} treina guerreiros em {object:2100}; {npc:6089} e {npc:6090} ficam juntos perto de {object:2152} lá. {npc:6090} luta com você pela sua caneca.",

	-- Step 26: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena
	["Fly or walk to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "Voe ou caminhe até {zone:1453}. {npc:376} está na Catedral da Luz.",

	-- Step 28: The Tome of Divinity
	-- {npc:6171} Duthorian Rall · {npc:6173} Gazin Tenorm · {npc:6174} Stephanie Turner · {object:2096} Trade District · {item:2589} Linen Cloth
	["{npc:6171} and {npc:6173} are in the Cathedral of Light; {npc:6174} stands in the {object:2096} and asks for ten {item:2589} (humanoids drop it; the Auction House sells it)."] = "",
	-- {item:6775} Tome of Divinity
	["Right-click the {item:6775} he gives you"] = "",
	-- {npc:6172} Henze Faulk · {area:86} Stone Cairn Lake
	["{npc:6172}, by {area:86} in Elwynn, on the road to Redridge"] = "",

	-- Step 30: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "",

	-- Step 31: Shaman training
	["Shaman training"] = "Treinamento de xamã",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["Head to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "Vá até {zone:1453}. Não tem treinador de xamã: pegue o {area:2257} do {object:28027} até {zone:1455}, treine com {npc:258098}, depois pegue o bonde de volta para o barco.",

	-- Step 32: Stormwind
	-- {zone:1453} Stormwind · {object:2100} Old Town · {object:2101} Mage Quarter
	["Fly or walk to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids)."] = "Voe ou caminhe até {zone:1453}. Treinadores: {object:2100} (Guerreiros, Trapaceiros), a Catedral (Paladinos, Sacerdotes), {object:2101} (Magos, Bruxos), o Parque (Druidas).",
	["Level 12, 14 and 16 spells"] = "Feitiços de nível 12, 14 e 16",

	-- Step 33: Back to Stormwind City
	-- {area:1519} Stormwind City
	["Back to {area:1519}"] = "",

	-- Step 35: Stormwind
	-- {item:2449} Earthroot · {zone:1439} Darkshore · {npc:1313} Maria Lumere
	["{item:2449} for Gathering the Cure (6123) in {zone:1439}: {npc:1313}, Alchemy Supplies; herbalists pick it there instead"] = "{item:2449} para Colhendo a cura (6123) em {zone:1439}: {npc:1313}, Suprimentos de Alquimia; herbalistas a colhem lá mesmo",
	-- {npc:5497} Jennea Cannon · {quest:1861} Mirror Lake
	["{npc:5497}, Wizard's Sanctum: {quest:1861}"] = "{npc:5497}, no Sacrário dos Teurgos: {quest:1861}",

	-- Step 37: Stormwind City
	["Stormwind City"] = "",

	-- Step 38: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 39: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Paladin fastest."] = "",

	-- Step 40: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "",

	-- Step 41: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Swords from {npc:11867} ({object:2096}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "",

	-- Step 42: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "",

	-- Step 44: Fishin' Time
	-- {npc:5494} Catherine Leland · {object:2096} Trade District · {npc:267118} Gilbert Gray
	["{npc:5494} sells fishing supplies along the canal just west of the {object:2096}; {npc:267118} fishes at the harbor, on the way to the boat."] = "{npc:5494} vende suprimentos de pesca junto ao canal, logo a oeste de {object:2096}; {npc:267118} pesca no porto, a caminho do barco.",
	-- {item:6529} Shiny Bauble · {npc:5494} Catherine Leland
	["{item:6529}, from {npc:5494}"] = "{item:6529}, de {npc:5494}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon."] = "Tocaiantes e Rufiões Défias andam por {area:20}; Bandoleiros (nível 17) patrulham em duplas as colinas ao sul e a leste: puxe-os separados. A entrada de {area:1581}, na ferraria, é uma masmorra de grupo.",
	-- ["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}."] = "Pilhadores e Gatunos Défias ocupam as fazendas a oeste de {area:108}, entre a estrada do litoral e {area:20}.",
	-- ["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids)."] = "Voe ou cavalgue até {zone:1453}. Instrutores: {object:2100} (guerreiros, ladinos), a Catedral da Luz (paladinos, sacerdotes), {object:2101} (magos, bruxos), o Parque (druidas).",
	-- ["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids). {npc:11026} works in the {object:28027}, {npc:279} in the {object:2096}."] = "Voe ou cavalgue até {zone:1453}. Instrutores: {object:2100} (guerreiros, ladinos), a Catedral da Luz (paladinos, sacerdotes), {object:2101} (magos, bruxos), o Parque (druidas). {npc:11026} trabalha em {object:28027}; {npc:279}, em {object:2096}.",
	-- ["Fly or ride to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "Voe ou cavalgue até {zone:1453}. {npc:376} está na Catedral da Luz.",
	-- ["Fly or ride to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "Voe ou cavalgue até {zone:1453}. {npc:5480} treina guerreiros em {object:2100}; {npc:6089} e {npc:6090} ficam juntos perto de {object:2152}, ali. {npc:6090} luta com você pela caneca dele.",
	-- ["Follow the road from Elwynn into {zone:1436}: the Furlbrows sit by their burned farm, the first one on the road. Collect the oats from the Sacks of Oats in the fields as you go."] = "Siga a estrada de Elwynn para {zone:1436}: os Furlbrow estão sentados perto da fazenda queimada, a primeira na estrada. Colete a aveia dos Sacos de Aveia dos campos enquanto avança.",
	-- ["Follow the road north. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west."] = "Siga a estrada para o norte. {npc:233} fica do lado de fora, {npc:235} dentro da casa e {npc:253395} no celeiro a oeste.",
	-- ["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go and fill the vial at the stead's well."] = "Mais ao norte pela estrada. Os Taturana estão sentados junto à fazenda incendiada. No caminho, colete a aveia dos Sacos de Aveia nos campos e encha o frasco no poço da propriedade.",
	-- ["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go."] = "Mais ao norte pela estrada. Os Taturana estão sentados junto à fazenda incendiada. No caminho, colete a aveia dos Sacos de Aveia nos campos.",
	-- ["Hearthstone on cooldown? Follow the road north-east."] = "Pedra de Regresso em recarga? Siga a estrada para o nordeste.",
	-- ["Murloc Coastrunners and Raiders line the beach north of the mine. They flee at low health: pull one at a time."] = "Murlocs Correcosta e Murlocs Saqueadores ocupam a praia ao norte da mina. Eles fogem com pouca vida: puxe um de cada vez.",
	-- ["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine, Kobold Diggers work inside. {object:290} stands by the ruined house east of the mine."] = "Ao norte da Fazenda dos Peçanha. Coureadores e Contrabandistas Défias acampam do lado de fora da mina; Escavadores Kobold trabalham lá dentro. {object:290} fica junto à casa em ruínas a leste da mina.",
	-- ["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine. {object:290} stands by the ruined house east of the mine."] = "Ao norte da Fazenda dos Peçanha. Coureadores e Contrabandistas Défias acampam do lado de fora da mina. {object:290} fica junto à casa em ruínas a leste da mina.",
	-- ["Only if he takes the isosprings alone"] = "Só se ele aceitar apenas as isomolas",
	-- ["Ride to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "Cavalgue até {zone:1453}. Lá não há instrutor de xamãs: pegue o {area:2257} em {object:28027} até {zone:1455}, treine com {npc:258098} e volte de metrô para pegar o barco.",
	-- ["Riverpaw Gnolls and Scouts (level 11-13) roam the hills south of the coast, from above {area:111} east to the {area:916}. The gnolls further south and west are 13-19: stay in the north hills."] = "Gnolos e Exploradores Pata-do-Rio (nível 11-13) rondam as colinas ao sul da costa, de acima de {area:111} a leste até o {area:916}. Os gnolos mais ao sul e oeste são nível 13-19: fique nas colinas do norte.",
	-- ["Riverpaw Gnolls and Scouts roam the hills between the coast and the {area:916}."] = "Gnolls e Batedores Pata Molhada vagam pelas colinas entre o litoral e o {area:916}.",
	-- ["Sacks of Oats"] = "Sacos de Aveia",
	-- ["The gnoll hills"] = "As colinas dos gnolls",
	-- ["The north coast"] = "O litoral norte",
	-- ["The western farms"] = "As fazendas do oeste",
	-- ["West of Molsen Farm, toward the coast. Riverpaw Miners work the quarry."] = "A oeste da Fazenda dos Peçanha, rumo ao litoral. Mineradores Pata Molhada trabalham na pedreira.",
	-- ["West of Saldean's. Harvest Watchers and Golems work the fields; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone. Keep killing Goretusks and Fleshrippers on every leg of this loop."] = "A oeste da fazenda Saldanha. Guarda-colheitas e Golens Colheiteiros trabalham nos campos; eles soltam as isomolas, os giroestabilizadores, {item:732} e às vezes um {item:255155}. {npc:573}, um raro de nível 20, anda por aqui: deixe-o em paz. Continue matando Goretuscos e Ripa-carnes em cada trecho deste circuito.",
	-- ["Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way back."] = "Goretuscos Jovens e Ripa-carnes vagam pelos campos ao redor da fazenda: comece a juntar fígados e a carne do ensopado na volta.",
	-- ["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} and {npc:253092} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234} e {npc:821} ficam no alto da torre de pedra. {npc:491} está na torre; {npc:878} e {npc:253092}, no lado sul do morro, junto à estalagem e a {npc:523}, o mestre de grifos.",
}
