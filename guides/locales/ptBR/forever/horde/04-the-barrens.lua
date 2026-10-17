-- Portuguese (Brazil) (ptBR): the guide forever/horde/04-the-barrens (forever/horde/04-the-barrens.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Voe para {area:392}",
	-- {object:172982} Valley of Strength (no name in this language: may be words)
	["Doras, the wind rider master, stands on the tower in the {object:172982}."] = "Doraso, o mestre de mantícoras, fica na torre em {object:172982}.",

	-- Step 2: Ratchet
	-- {npc:3442} Sputtervalve · {quest:1483} Ziz Fizziks
	["{npc:3442}, beside the wind rider master. Keep it: {quest:1483} is in Stonetalon, later"] = "{npc:3442}, ao lado do mestre de mantícoras. Guarde-a: {quest:1483} fica na Cordilheira das Torres de Pedra, mais tarde",
	-- {object:3972} WANTED
	["{object:3972} poster"] = "cartaz {object:3972}",
	-- {npc:3453} Wharfmaster Dizzywig
	["{npc:3453}, on the dock"] = "{npc:3453}, no cais",

	-- Step 3: Bruuz
	-- {npc:209797} Bruuz · {area:392} Ratchet
	["{npc:209797} swims in the harbour just off {area:392}'s docks. {npc:209797} is elite: grouping up is advised."] = "{npc:209797} nada no porto, logo além do cais de {area:392}. {npc:209797} é elite: é recomendado formar um grupo.",

	-- Step 4: Baron Longshore
	-- {area:392} Ratchet · {npc:3467} Baron Longshore
	["The pirates camp on the beach south of {area:392}; {npc:3467} stands at its southern end."] = "Os piratas acampam na praia ao sul de {area:392}; {npc:3467} fica na ponta sul.",

	-- Step 5: Northwatch Hold
	-- {area:385} Northwatch Hold · {npc:3393} Captain Fairmount
	-- plural, as words: Theramore Marines = {npc:3385} Theramore Marine
	["{area:385}, on the coast further south. The Theramore Marines and Preservers (15-16) drop the medals; {npc:3393} (20) and the two cannoneers (19) stand in the keep and on its walls, and they are why the hold waits until now."] = "{area:385}, mais ao sul pela costa. Os Fuzileiros e as Preservadoras de Theramore (15-16) deixam cair as medalhas; {npc:3393} (20) e os dois canhoneiros (19) ficam na fortaleza e nas muralhas, e é por eles que o forte ficou para agora.",

	-- Step 6: Free From the Hold
	-- {npc:3465} Gilthares Firebough · {area:392} Ratchet
	["{npc:3465} is chained inside the hold. Talk to him to start the escort and stay close: Theramore soldiers attack on the way out. He walks you back to {area:392}."] = "{npc:3465} está acorrentado dentro do forte. Fale com ele para iniciar a escolta e fique perto: soldados de Theramore atacam na saída. Ele leva você de volta a {area:392}.",

	-- Step 8: Raptor Horns
	-- {area:380} Crossroads · {area:1697} Raptor Grounds · {area:392} Ratchet
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["Sunscale Scytheclaws hunt the plains south of the {area:380}, around the {area:1697}; they drop the horns. Hand them in on your next pass through {area:392}."] = "Garrafoices Helióscamos caçam nas planícies ao sul de {area:380}, em volta de {area:1697}; eles deixam cair os chifres. Entregue-os na próxima passagem por {area:392}.",

	-- Step 9: Crossroads
	-- {npc:3429} Thork · {area:1703} Mor'shan Rampart
	["{npc:3429}. Keep it: Kadrak at the {area:1703}, next guide"] = "{npc:3429}. Guarde-a: Kadrak em {area:1703}, próximo guia",
	-- {npc:3428} Korran · {area:390} Field of Giants
	["{npc:3428}: the eggs are in the {area:390}, later"] = "{npc:3428}: os ovos ficam em {area:390}, mais tarde",
	-- {npc:3429} Thork
	["{npc:3429}, at the top of the tower"] = "{npc:3429}, no alto da torre",

	-- Step 10: Dreadmist Peak
	-- {area:380} Crossroads · {area:384} Dreadmist Peak · {item:15842} Empty Dreadmist Peak Sampler · {object:19464} Dreadmist Peak Pool (no name in this language: may be words) · {npc:3448} Tonga Runetotem · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["Ride north from the {area:380} to {area:384} and fill the {item:15842} at the {object:19464}, then back to {npc:3448} in the {area:380}. No {skill:182}? {npc:3490} beside him sells {item:2449}, three at a time until he restocks."] = "Siga para o norte de {area:380} até {area:384} e encha o {item:15842} em {object:19464}, depois volte a {npc:3448} em {area:380}. Sem {skill:182}? {npc:3490}, ao lado dele, vende {item:2449}, três por vez até repor o estoque.",
	-- {item:2449} Earthroot · {npc:3490} Hula'mahi
	["{item:2449} from {npc:3490}; herbalists pick it on the plains"] = "{item:2449} de {npc:3490}; herbalistas colhem nas planícies",

	-- Step 11: Level 20
	["Level 20"] = "Nível 20",
	-- {zone:1454} Orgrimmar · {npc:3354} Sorek · {npc:5892} Searn Firewarder · {area:380} Crossroads · {area:388} Stagnant Oasis
	-- plural, as words: Thunderhawk Hatchlings = {npc:3247} Thunderhawk Hatchling
	["The level-20 class quests in {zone:1454} ({npc:3354}, {npc:5892}, the Warlock and Rogue trainers) are only offered from level 20, so finish the level here before you fly. The Thunderhawk Hatchlings (18) on the plains south-west of the {area:380} and the Kolkar (14-15) at the {area:388} are the nearest mobs worth killing; you need well under a level."] = "As missões de classe de nível 20 em {zone:1454} ({npc:3354}, {npc:5892}, os instrutores de Bruxo e Ladino) só são oferecidas a partir do nível 20, então complete o nível aqui antes de voar. Os Filhotes de Falcotrom (18) nas planícies a sudoeste de {area:380} e os Kolkar (14-15) em {area:388} são as criaturas mais próximas que valem a pena; falta bem menos de um nível.",
	-- {area:380} Crossroads
	-- plural, as words: Thunderhawk Hatchlings = {npc:3247} Thunderhawk Hatchling
	["grind on Thunderhawk Hatchlings south-west of the {area:380}"] = "mate Filhotes de Falcotrom a sudoeste de {area:380}",

	-- Step 12: Orgrimmar
	-- {area:1637} Orgrimmar · {npc:3354} Sorek · {object:172958} Valley of Honor (no name in this language: may be words) · {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom (no name in this language: may be words)
	["Fly to {area:1637} to train your level 20 ranks. {npc:3354} is in the {object:172958}, {npc:5892} in the {object:172957}."] = "Voe para {area:1637} para treinar as habilidades de nível 20. {npc:3354} fica em {object:172958}, {npc:5892} em {object:172957}.",

	-- Step 13: Gan'rul Bloodeye
	-- {object:172960} Cleft of Shadow (no name in this language: may be words) · {object:172982} Valley of Strength (no name in this language: may be words)
	["The {object:172960} is the canyon under the {object:172982}."] = "O {object:172960} é o cânion sob o {object:172982}.",
	-- {npc:5909} Cazul
	["{npc:5909}, a few steps away"] = "{npc:5909}, a poucos passos",

	-- Step 14: Shenthul
	-- {npc:3401} Shenthul · {object:172960} Cleft of Shadow (no name in this language: may be words) · {quest:2460} The Shattered Salute
	["{npc:3401} stands in the {object:172960}. Target him and type /salute to finish {quest:2460}."] = "{npc:3401} fica em {object:172960}. Selecione-o e digite /saudar para concluir {quest:2460}.",
	-- {quest:2458} Deep Cover · {npc:7233} Taskmaster Fizzule · {area:382} Sludge Fen
	["{quest:2458}: {npc:7233}, by the {area:382}"] = "{quest:2458}: {npc:7233}, junto a {area:382}",

	-- Step 15: Ur'kyo
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits (no name in this language: may be words)
	["{npc:6018} stands in the {object:172961}, on the city's west side."] = "{npc:6018} fica em {object:172961}, no lado oeste da cidade.",
	-- {npc:6018} Ur'kyo · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["{npc:6018}: {npc:4606} in the {zone:1458}, two guides on"] = "{npc:6018}: {npc:4606} em {zone:1458}, daqui a dois guias",

	-- Step 16: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Fly to {area:1638} and train your level 20 ranks: {npc:3033} is on {area:1639}."] = "Voe para {area:1638} e treine as habilidades de nível 20: {npc:3033} fica em {area:1639}.",

	-- Step 17: Back to the Crossroads
	-- {area:380} Crossroads
	["Back to the {area:380}"] = "De volta a {area:380}",

	-- Step 18: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate · {area:380} Crossroads
	["{npc:3389} stands at the Kolkar watch post just west of the {area:380}."] = "{npc:3389} fica no posto de vigia kolkar logo a oeste de {area:380}.",

	-- Step 19: Barak Kodobane
	-- {npc:3394} Barak Kodobane · {npc:3389} Regthar Deathgate
	["{npc:3394} stands in the Kolkar camp north-west of {npc:3389}."] = "{npc:3394} fica no acampamento kolkar a noroeste de {npc:3389}.",
	-- {item:15852} Kodo Horn
	-- plural, as words: Lost Barrens Kodos = {npc:3234} Lost Barrens Kodo
	["{item:15852}: Lost Barrens Kodos on the plains around the Kolkar camp"] = "{item:15852}: Kodos Perdidos dos Sertões nas planícies em volta do acampamento kolkar",
	-- {item:2449} Earthroot
	["{item:2449}: herbalists pick it here"] = "{item:2449}: herbalistas colhem aqui",

	-- Step 21: Ken'zigla
	-- {npc:4197} Ken'zigla · {area:2539} Malaka'jin · {npc:3389} Regthar Deathgate
	["{npc:4197} lives in {area:2539}, the troll village just inside Stonetalon at the end of the road west from {npc:3389}."] = "{npc:4197} vive em {area:2539}, a aldeia troll logo na entrada da Cordilheira das Torres de Pedra, no fim da estrada a oeste de {npc:3389}.",

	-- Step 22: Vrang Wildgore
	-- {area:383} Dry Hills · {npc:3682} Vrang Wildgore · {npc:261366} Walton
	["North to the {area:383}. {npc:3682} camps below the hills; {npc:261366}, the hermit on the ridge behind him, has work for you only once {npc:3682} sends you up."] = "Para o norte, até {area:383}. {npc:3682} acampa abaixo das colinas; {npc:261366}, o eremita na serra atrás dele, só tem trabalho para você depois que {npc:3682} mandar você subir.",

	-- Step 23: Dry Hills
	-- {area:392} Ratchet · {quest:876} Serena Bloodfeather
	-- plural, as words: Savannah Patriarchs = {npc:3241} Savannah Patriarch · Sprung Traps = {object:640104} Sprung Trap
	["Savannah Patriarchs roam the plains east of the hills, and the Sprung Traps lie among them, so do both here and skip the Matriarchs by {area:392}. {quest:876} leads the Witchwing harpies in the hills to the west."] = "",

	-- Step 26: Trouble in the Valley
	-- {npc:262119} Corporal Adamore · {npc:261366} Walton
	["{npc:262119} and his marines hold the wrecked caravan south of {npc:261366}."] = "{npc:262119} e seus fuzileiros ocupam a caravana destruída ao sul de {npc:261366}.",

	-- Step 27: Walton
	-- {npc:261366} Walton · {npc:261367} Terry Longdrink · {area:21} Kul Tiras
	["Assist {npc:261366}: stay by him when {npc:261367} and the {area:21} marines come up the ridge"] = "Ajude {npc:261366}: fique ao lado dele quando {npc:261367} e os fuzileiros de {area:21} subirem a serra",

	-- Step 28: Strange Lockbox
	-- {object:177792} Strange Lockbox · {area:382} Sludge Fen · {item:15883} Half Pendant of Aquatic Agility · {quest:30} Trial of the Sea Lion
	["The {object:177792} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "{object:177792} fica na borda norte de {area:382}, junto à torre da Empreendimentos S.A. Contém {item:15883} para {quest:30}.",

	-- Step 29: Ignition
	-- {area:382} Sludge Fen · {npc:3439} Wizzlecrank's Shredder · {npc:3445} Supervisor Lugwizzle
	["East to the {area:382}. {npc:3439} stands inside the Venture Co. camp; {npc:3445} carries the key."] = "Para o leste, até {area:382}. {npc:3439} fica dentro do acampamento da Empreendimentos S.A.; {npc:3445} carrega a chave.",

	-- Step 30: The Escape
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["Wizzlecrank drives his shredder out of the camp: stay with him and kill whatever attacks him. {npc:3442} takes it in {area:392}."] = "Manivela pilota o retalhador para fora do acampamento: fique com ele e mate o que o atacar. {npc:3442} o recebe em {area:392}.",

	-- Step 31: Taskmaster Fizzule
	-- {area:382} Sludge Fen
	["Fizzule runs the Venture Co. camp at the east end of the {area:382}. He attacks strangers: target him and /salute before he does."] = "Fizzule comanda o acampamento da Empreendimentos S.A. na ponta leste de {area:382}. Ele ataca estranhos: selecione-o e use /saudar antes que ele ataque.",

	-- Step 32: Mission: Possible But Not Probable
	-- {npc:7287} Foreman Silixiz
	["Stay stealthed: {npc:7287} carries the key to the tower; Gallywix and his lockbox are at the top. Gallywix is elite: grouping up is advised."] = "Fique em furtividade: {npc:7287} carrega a chave da torre; Gallywix e o cofre dele ficam no alto. Gallywix é elite: é recomendado formar um grupo.",
	["Venture Co. tower"] = "Torre da Empreendimentos S.A.",

	-- Step 33: Boulder Lode Mine
	-- {item:5097} Cats Eye Emerald
	-- plural, as words: Venture Co. Overseers = {npc:3286} Venture Co. Overseer
	["The Venture Co. Overseers and Enforcers at the mine in the north-east corner of the zone drop the {item:5097}."] = "Os Feitores e Seguranças da Empreendimentos S.A. na mina do canto nordeste da zona deixam cair {item:5097}.",

	-- Step 34: Hearth to the Crossroads
	-- {area:380} Crossroads
	["Hearth to the {area:380}"] = "Regresse para {area:380}",
	-- {item:15826} Curative Animal Salve
	["He gives you the {item:15826}"] = "Ele dá a você {item:15826}",

	-- Step 35: Verog the Dervish
	-- {npc:3395} Verog the Dervish · {area:388} Stagnant Oasis · {area:380} Crossroads
	["{npc:3395} walks among the Kolkar at the {area:388} south-east of the {area:380}."] = "{npc:3395} anda entre os Kolkar em {area:388}, a sudeste de {area:380}.",
	-- {npc:12296} Sickly Gazelle · {item:15826} Curative Animal Salve · {area:380} Crossroads
	["{npc:12296}: use the {item:15826} on them; they roam the plains all around the {area:380}"] = "{npc:12296}: use {item:15826} nelas; elas vagam pelas planícies em volta de {area:380}",

	-- Step 36: Camp Taurajo
	-- {area:458} Gold Road · {area:378} Camp Taurajo
	["Follow the {area:458} south to {area:378}."] = "Siga {area:458} para o sul até {area:378}.",
	-- {npc:3430} Mangletooth
	["{npc:3430}, in the cage"] = "{npc:3430}, na jaula",
	-- {npc:3433} Tatternack Steelforge
	["{npc:3433}, at the north edge of the camp"] = "{npc:3433}, na borda norte do acampamento",

	-- Step 37: Bristleback camps
	["Bristleback camps"] = "Acampamentos Costagulha",
	-- {area:378} Camp Taurajo · {area:458} Gold Road · {npc:3432} Mankrik · {item:5075} Blood Shard · {quest:883} Lakota'mani
	["The Bristleback quilboar camps spread over the plains north of {area:378}, either side of the {area:458}. Every Bristleback drops a tusk; {npc:3432}'s wife lies at the north edge. Keep one {item:5075}. {quest:883}, a grey kodo, sometimes wanders here: his hoof starts a quest."] = "Os acampamentos dos javatuscos Costagulha se espalham pelas planícies ao norte de {area:378}, dos dois lados de {area:458}. Todo Costagulha deixa cair uma presa; a esposa de {npc:3432} jaz na borda norte. Guarde um {item:5075}. {quest:883}, um kodo cinza, às vezes passa por aqui: o casco dele inicia uma missão.",

	-- Step 38: Grunt Dogran
	["Dogran is chained up in the quilboar camp west of the road."] = "Dogran está acorrentado no acampamento de javatuscos a oeste da estrada.",
	-- {npc:5875} Gan'rul Bloodeye · {zone:1454} Orgrimmar
	["Keep it: {npc:5875} in {zone:1454}, at the end of this guide"] = "Guarde-a: {npc:5875} em {zone:1454}, no fim deste guia",

	-- Step 40: Stolen Silver
	-- {area:385} Northwatch Hold
	["East across the plains toward the coast: the stolen silver lies in a raptor nest north-west of {area:385}."] = "Para o leste pelas planícies, rumo à costa: a prata roubada está num ninho de raptores a noroeste de {area:385}.",

	-- Step 41: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} waits on the hill south of {area:392}, on your way north."] = "{npc:5901} espera na colina ao sul de {area:392}, no caminho para o norte.",

	-- Step 43: Ishamuhale
	-- {quest:882} Ishamuhale · {area:392} Ratchet · {area:380} Crossroads
	["{quest:882}, a big Sunscale raptor, hunts the plains north of the road from {area:392} to the {area:380}."] = "{quest:882}, um grande raptor Helióscamo, caça nas planícies ao norte da estrada de {area:392} para {area:380}.",

	-- Step 44: Crossroads
	-- {npc:3432} Mankrik · {quest:95774} Her Name Is Olgra · {quest:4921} Lost in Battle
	["{npc:3432} offers {quest:95774} once {quest:4921} is handed in"] = "{npc:3432} oferece {quest:95774} depois que {quest:4921} for entregue",

	-- Step 46: Hezrul Bloodmark
	-- {npc:3396} Hezrul Bloodmark · {area:387} Lushwater Oasis · {npc:3389} Regthar Deathgate · {area:380} Crossroads
	["{npc:3396} leads the Kolkar on the west shore of {area:387}, south of {npc:3389}. Hand his head to {npc:3389} on your last {area:380} stop."] = "{npc:3396} lidera os Kolkar na margem oeste de {area:387}, ao sul de {npc:3389}. Entregue a cabeça dele a {npc:3389} na última parada em {area:380}.",

	-- Step 47: Olgra's Adornments
	-- {area:458} Gold Road · {area:378} Camp Taurajo · {item:277277} Olgra's Adornments · {npc:3432} Mankrik · {area:380} Crossroads
	-- plural, as words: Razormane Raiders = {npc:268624} Razormane Raider
	["On the way back down the {area:458} to {area:378}: the Razormane Raiders among the Bristleback camps, either side of the road north of the camp, carry {item:277277}. Hand them to {npc:3432} on your last {area:380} stop."] = "Na volta por {area:458} até {area:378}: os Saqueadores Crinavalha entre os acampamentos Costagulha, dos dois lados da estrada ao norte do acampamento, carregam {item:277277}. Entregue-os a {npc:3432} na última parada em {area:380}.",

	-- Step 48: Camp Taurajo
	-- {area:458} Gold Road · {area:378} Camp Taurajo
	["Down the {area:458} to {area:378} again."] = "Desça {area:458} até {area:378} de novo.",
	-- {npc:12696} Senani Thunderheart · {zone:1440} Ashenvale
	["Keep it: {npc:12696} in {zone:1440}, next guide"] = "Guarde-a: {npc:12696} em {zone:1440}, próximo guia",

	-- Step 49: Enraged Thunder Lizards
	-- {area:378} Camp Taurajo · {quest:884} Owatanka
	-- plural, as words: Thunderheads = {npc:3239} Thunderhead
	["Thunderheads graze on the plains just south of {area:378}. {quest:884}, a blue thunder lizard, roams among them: his Tailspike starts a quest."] = "Cabeças-de-trovão pastam nas planícies logo ao sul de {area:378}. {quest:884}, um lagarto-trovão azul, vaga entre eles: a Ponta da Cauda dele inicia uma missão.",

	-- Step 51: Cry of the Thunderhawk
	-- plural, as words: Thunderhawk Cloudscrapers = {npc:3424} Thunderhawk Cloudscraper
	["Thunderhawk Cloudscrapers circle over the same plains south of the camp."] = "Falcotrons Raspa-nuvens voam em círculos sobre as mesmas planícies ao sul do acampamento.",

	-- Step 53: Field of Giants
	-- {area:390} Field of Giants
	-- plural, as words: Silithid Mounds = {object:3685} Silithid Mound · Silithid Swarmers = {npc:3252} Silithid Swarmer · Silithid Harvesters = {npc:3253} Silithid Harvester
	["South of Camp Taurajo the Silithid Mounds dot the {area:390}; the eggs lie in them, and Silithid Swarmers come out to defend them. Silithid Harvesters are rare: if you see one, kill it for its head."] = "Ao sul do Acampamento Taurajo, Montes de Terra Silitídeos se espalham por {area:390}; os ovos ficam neles, e Enxameadores Silitídeos saem para defendê-los. Ceifadores Silitídeos são raros: se vir um, mate-o pela cabeça.",

	-- Step 54: Gann Stonespire
	-- {npc:3341} Gann Stonespire · {area:359} Bael Modan
	["{npc:3341} waits in a small camp further south, on the road toward {area:359}."] = "{npc:3341} espera num pequeno acampamento mais ao sul, na estrada para {area:359}.",
	-- {npc:14242} Sulhasa · {npc:3341} Gann Stonespire
	["{npc:14242}, up in the tree just east of {npc:3341}"] = "{npc:14242}, no alto da árvore logo a leste de {npc:3341}",
	-- {npc:5899} Brine · {npc:3341} Gann Stonespire
	["{npc:5899}, just west of {npc:3341}"] = "{npc:5899}, logo a oeste de {npc:3341}",
	-- {item:7766} Empty Brown Waterskin
	["Fill the {item:7766} at the quilboar watering hole"] = "Encha o {item:7766} no bebedouro dos javatuscos",
	-- {object:107045} Spring Well (no name in this language: may be words) · {area:272} Tarren Mill
	["Keep it: the {object:107045} is beside {area:272}"] = "Guarde-a: {object:107045} fica ao lado de {area:272}",

	-- Step 55: Blackthorn Ridge
	-- {area:1701} Blackthorn Ridge · {npc:3436} Kuz · {npc:3434} Nak · {npc:3435} Lok Orcbane · {npc:5859} Hagg Taurenbane · {npc:3238} Stormhide · {npc:3341} Gann Stonespire · {quest:885} Washte Pawne
	-- plural, as words: Hecklefang Stalkers = {npc:4128} Hecklefang Stalker
	["West of Gann, the Razormane hold {area:1701}. {npc:3436} is on the east side, {npc:3434} to the south, {npc:3435} at the west end. Lok (25) and the Warfrenzies (24-25) are a few levels above you; {npc:5859}, a rare elite, sometimes walks the ridge: leave him. Pathfinders and Stalkers drop the Backstabber, Seers the Wand, Warfrenzies the War Shield. {npc:3238} lizards and Hecklefang Stalkers roam the plain between {npc:3341} and the ridge. {quest:885}, a rare red wind serpent, flies over the ridge: its feather starts a quest."] = "A oeste de {npc:3341}, os Crinavalha ocupam {area:1701}. {npc:3436} fica no lado leste, {npc:3434} ao sul, {npc:3435} na ponta oeste. Lok (25) e os Belicosos (24-25) estão alguns níveis acima de você; {npc:5859}, um elite raro, às vezes anda pela serra: deixe-o em paz. Desbravadores e Espreitadores deixam cair o Punhal, Videntes a Varinha, Belicosos o Escudo de Guerra. Lagartos {npc:3238} e Espreitadores Presavaia vagam pela planície entre Gann e a serra. {quest:885}, uma serpente alada vermelha rara, sobrevoa a serra: a pena dela inicia uma missão.",
	-- {npc:3238} Stormhide · {npc:3341} Gann Stonespire
	["{npc:3238}, on the plain between {npc:3341} and the ridge"] = "{npc:3238}, na planície entre {npc:3341} e a serra",

	-- Step 56: Bael Modan
	-- {area:359} Bael Modan · {npc:3392} Prospector Khazgorm
	["South of Gann, the Bael'dun dwarves dig at {area:359}. Excavators and Foremen work the pit; {npc:3392} (26) carries the journal: pull him alone."] = "Ao sul de Gann, os anões de Bael'dun escavam em {area:359}. Escavadores e Encarregados trabalham no fosso; {npc:3392} (26) carrega o diário: puxe-o sozinho.",

	-- Step 58: Bael'dun fortress
	["Bael'dun fortress"] = "Fortaleza de Bael'dun",
	-- plural, as words: Bael'dun Soldiers = {npc:3376} Bael'dun Soldier
	["The Bael'dun Soldiers, Riflemen and Officers guard the fortress on the east side of the dig; all three items drop from them."] = "Os Soldados, Carabineiros e Oficiais de Bael'dun guardam a fortaleza no lado leste da escavação; os três itens caem deles.",

	-- Step 60: The flying machine
	["The flying machine"] = "A máquina voadora",
	["The dwarves' flying machine sits on its platform inside the dig site."] = "A máquina voadora dos anões fica na plataforma dentro do sítio de escavação.",

	-- Step 62: Twitching Antennae
	["Twitching Antennae"] = "Antenas Agitadas",
	-- {area:390} Field of Giants · {area:378} Camp Taurajo
	-- plural, as words: Silithid Swarmers = {npc:3252} Silithid Swarmer
	["The antennae vanish fifteen minutes after they drop, so gather them now, on the way back north: kill the Silithid Swarmers and Creepers at the {area:390}' mounds until you have five, then hearth to {area:378} straight away."] = "As antenas somem quinze minutos depois de cair, então colete-as agora, na volta para o norte: mate Enxameadores e Rastejantes Silitídeos nos montes de {area:390} até ter cinco, depois regresse para {area:378} imediatamente.",
	["Twitching Antennae from the silithid"] = "Antenas Agitadas dos silitídeos",

	-- Step 66: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:380} Crossroads
	["{npc:5878} camps beside the road east of the {area:380}."] = "{npc:5878} acampa ao lado da estrada a leste de {area:380}.",
	-- {quest:1838} Brutal Armor · {area:1717} Razorfen Kraul
	["He offers {quest:1838} next (1838, level 30): it needs {area:1717} and sends you all over Kalimdor and the Eastern Kingdoms. The Warrior class guide {quest:1838} covers it."] = "Em seguida ele oferece {quest:1838} (1838, nível 30): ela exige {area:1717} e manda você por toda Kalimdor e pelos Reinos do Leste. O guia da classe Guerreiro {quest:1838} cobre essa missão.",

	-- Step 67: Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637} to train."] = "Voe para {area:1637} para treinar.",

	-- Step 68: Thunder Bluff
	-- {npc:246344} Alodan the Hopeful · {area:1638} Thunder Bluff · {area:378} Camp Taurajo · {zone:1412} Mulgore · {npc:2995} Tal
	["{npc:246344} teaches Paladins in {area:1638}. You have no flight path there yet: fly to {area:378}, ride west through {zone:1412} and up a lift, and take the flight path from {npc:2995} on the central rise."] = "{npc:246344} treina Paladinos em {area:1638}. Você ainda não tem rota de voo lá: voe para {area:378}, siga para o oeste por {zone:1412}, suba um elevador e pegue a rota de voo com {npc:2995} no platô central.",

	-- Step 69: The Binding
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow (no name in this language: may be words) · {item:6626} Dogran's Pendant
	["{npc:5875} stands in the {object:172960}. Use {item:6626} on the summoning circle there and defeat the succubus to bind her."] = "{npc:5875} fica em {object:172960}. Use {item:6626} no círculo de invocação ali e derrote a súcubo para vinculá-la.",

	-- Step 70: Shenthul
	-- {npc:2391} Serge Hinott · {area:272} Tarren Mill
	["{npc:2391} in {area:272} teaches Poisons: keep it"] = "{npc:2391}, em {area:272}, ensina Venenos: guarde-a",

	-- Step 71: The Great Cat Spirit
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Fly to {area:1638} to train: {npc:3033} is on {area:1639}."] = "Voe para {area:1638} para treinar: {npc:3033} fica em {area:1639}.",

	-- Step 72: Moonglade
	-- {spell:18960} Teleport: Moonglade · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. Tauren: join the two pendant halves at the {area:2362}, on the north-west shore of the lake, before you see {npc:11802} in {area:2361}."] = "Lance {spell:18960}. Taurens: juntem as duas metades do pingente em {area:2362}, na margem noroeste do lago, antes de falar com {npc:11802} em {area:2361}.",
	-- {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos
	["{item:15885}: use a half at the {area:2362}"] = "{item:15885}: use uma metade em {area:2362}",
	-- {npc:11802} Dendrite Starblaze · {npc:3033} Turak Runetotem
	["{npc:11802}: the welcome from {npc:3033}"] = "{npc:11802}: as boas-vindas de {npc:3033}",

	-- Step 73: The Stormrage Barrow Dens
	-- {area:2363} Stormrage Barrow Dens
	["The {area:2363}"] = "{area:2363}",
	-- {npc:11957} Great Cat Spirit · {npc:272054} Avatar of Saeyleenan · {item:280680} Relic of the Silent Shadow
	["Tauren: the {npc:11957} waits on the southern hill above the bridge. Skyborne: the {npc:272054} stands south of the twin bridges. Then the dens east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue."] = "Taurens: {npc:11957} espera na colina ao sul, acima da ponte. Celonatos: {npc:272054} fica ao sul das pontes gêmeas. Depois, as tocas a leste do lago: saia da forma, clique na estátua da entrada para ganhar cinco minutos de furtividade, evite os espíritos lá dentro e pegue uma de cada relíquia; {item:280680} fica ao pé da estátua do gato branco.",

	-- Step 75: Turak Runetotem
	-- {npc:11798} Bunthen Plainswind · {area:2361} Nighthaven
	["{npc:11798} in {area:2361} flies druids there"] = "{npc:11798}, em {area:2361}, leva druidas voando até lá",

	-- Step 76: Back to the Crossroads
	-- {area:380} Crossroads · {area:1703} Mor'shan Rampart · {zone:1440} Ashenvale
	["Fly back to the {area:380}. The next guide starts here and takes the road north to the {area:1703} and {zone:1440}."] = "Volte voando para {area:380}. O próximo guia começa aqui e segue a estrada para o norte até {area:1703} e {zone:1440}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Bruuz"] = "Bruuz",
	-- ["Savannah Patriarchs roam the plains east of the hills, and the Sprung Traps lie among them. {quest:876} leads the Witchwing harpies in the hills to the west."] = "Patriarcas da Savana vagam pelas planícies a leste das colinas, e as Armadilhas Disparadas ficam entre eles. {quest:876} lidera as harpias Asabruxa nas colinas a oeste.",
	-- ["The {area:380}"] = "{area:380}",
	-- ["The {area:383}"] = "{area:383}",
}
