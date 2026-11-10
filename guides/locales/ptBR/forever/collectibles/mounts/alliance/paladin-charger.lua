-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/mounts/alliance/paladin-charger (forever/collectibles/mounts/alliance/paladin-charger.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Paladin Charger"] = "Corcel de Paladino",
	["Your epic mount at 60, summoned at will: the faster step up from the Warhorse."] = "Sua montaria épica no nível 60, evocada quando quiser: o passo mais rápido depois do Cavalo de Guerra.",

	-- Step 1: Lord Grayson Shadowbreaker (Ironforge)
	-- {npc:5149} Brandur Ironhammer · {object:32362} Mystic Ward (no name in this language: may be words) · {quest:7638} Lord Grayson Shadowbreaker · {zone:1453} Stormwind
	["At 60 {npc:5149} in the {object:32362} sends you to {quest:7638} in {zone:1453}'s Cathedral of Light."] = "No nível 60, {npc:5149} na {object:32362} manda você a {quest:7638} na Catedral da Luz de {zone:1453}.",

	-- Step 2: Lord Grayson Shadowbreaker
	-- {spell:23214} Summon Charger · {area:2279} Stratholme · {area:2057} Scholomance · {item:14047} Runecloth · {item:8836} Arthas' Tears · {npc:6171} Duthorian Rall
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["The {spell:23214} chain is long: {area:2279}, Dire Maul West and {area:2057} with a group, 350 gold in donations, and materials worth several hundred more (6 Arcanite Bars, 40 {item:14047}, 10 {item:8836}, two diamonds). Start saving early. Lord Grayson stands in the Cathedral of Light, {npc:6171} nearby."] = "A cadeia de {spell:23214} é longa: {area:2279}, Gládio Cruel Oeste e {area:2057} com grupo, 350 de ouro em doações e materiais que valem várias centenas a mais (6 Barras de Arcanita, 40 {item:14047}, 10 {item:8836}, dois diamantes). Comece a juntar cedo. Lord Grayson fica na Catedral da Luz, {npc:6171} por perto.",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}, Cathedral of Light"] = "{npc:6171}, Catedral da Luz",

	-- Step 3: High Priest Rohan
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words)
	["{npc:11406}, the priest trainer, walks about the {object:32386} in {zone:1455}'s {object:32362}. He gives you his censer for a donation of 150 gold, taken at the hand-in. Keep the censer."] = "{npc:11406}, o instrutor de sacerdote, anda pelo Salão dos Mistérios, no Ala Mística de {zone:1455}. Ele entrega o incensário dele por uma doação de 150 de ouro, cobrada na entrega. Guarde o incensário.",
	-- {npc:11406} High Priest Rohan
	["{npc:11406}: 150 gold"] = "{npc:11406}: 150 de ouro",

	-- Step 4: Back to Lord Grayson
	["Back to Lord Grayson"] = "De volta a Lorde Grayson",
	-- {item:18752} Exorcism Censer · {area:2627} Terrordale
	["Lord Grayson blesses the censer into the {item:18752} for {area:2627}."] = "Lord Grayson abençoa o incensário e o transforma em {item:18752}, para {area:2627}.",

	-- Step 5: Exorcising Terrordale
	-- {area:2627} Terrordale · {zone:1423} Eastern Plaguelands · {area:2279} Stratholme · {object:179747} Terrordale Haunting Spirit (no name in this language: may be words) · {item:18752} Exorcism Censer · {spell:7713} Wailing Dead · {spell:2878} Turn Undead
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit
	["{area:2627} lies in the far north-west of the {zone:1423}, west of the {area:2279} gates. Stand inside a green glowing patch on the ground (a {object:179747}; some are inside the ruined houses) and use the {item:18752}: up to three Terrordale Spirits (level 59-60) rise and attack. Their {spell:7713} lowers all your stats by 30%: fight them one at a time and use {spell:2878}. The patches come back quickly; several paladins can work side by side."] = "{area:2627} fica no extremo noroeste de {zone:1423}, a oeste dos portões de {area:2279}. Fique dentro de uma mancha verde brilhante no chão (Terrordale Haunting Spirit; algumas ficam dentro das casas em ruínas) e use {item:18752}: até três Espíritos da Várzea do Medo (nível 59-60) se erguem e atacam. O {spell:7713} deles reduz todos os seus atributos em 30%: lute com um de cada vez e use {spell:2878}. As manchas voltam rápido; vários paladinos podem trabalhar lado a lado.",
	-- {item:18752} Exorcism Censer
	["{item:18752}, inside a green patch"] = "{item:18752}, dentro de uma mancha verde",
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit
	["Terrordale Spirits x25"] = "Espíritos da Várzea do Medo x25",

	-- Step 6: Lord Grayson Shadowbreaker
	["Lord Grayson takes the censer back."] = "Lord Grayson pega o incensário de volta.",

	-- Step 7: Grimand Elmore
	-- {npc:1416} Grimand Elmore · {zone:1453} Stormwind · {object:28027} Dwarven District · {item:18753} Arcanite Barding
	["{npc:1416} works in {zone:1453}'s {object:28027}. He forges the {item:18753} from your materials and 150 gold."] = "{npc:1416} trabalha no {object:28027} de {zone:1453}. Ele forja {item:18753} com seus materiais e 150 de ouro.",

	-- Step 8: Grimand Elmore's materials
	-- {npc:1416} Grimand Elmore
	["{npc:1416}'s materials"] = "Materiais de {npc:1416}",
	-- {item:14047} Runecloth · {area:2255} Everlook · {area:2577} Dire Maul · {item:8836} Arthas' Tears · {skill:182} Herbalism · {area:3197} Chillwind Camp · {item:12360} Arcanite Bar · {item:12359} Thorium Bar · {item:12363} Arcane Crystal
	["{item:14047} drops from humanoids of level 50 and up ({area:2255}'s Bruisers, the Scarlet Crusade in the Plaguelands, the {area:2577} ogres). {item:8836} is a Plaguelands herb ({skill:182} 220), common around {area:3197}. An {item:12360} is an alchemist's transmute from a {item:12359} and an {item:12363}, once every two days per alchemist: ask a guild alchemist early, or buy the bars. The Auction House sells all three."] = "{item:14047} cai de humanoides de nível 50 ou mais (os Brutamontes de {area:2255}, a Cruzada Escarlate nas Terras Pestilentas, os ogros de {area:2577}). {item:8836} é uma erva das Terras Pestilentas ({skill:182} 220), comum em volta de {area:3197}. {item:12360} é uma transmutação de alquimista, feita de {item:12359} e {item:12363}, uma vez a cada dois dias por alquimista: peça cedo a um alquimista da guilda, ou compre as barras. A Casa de Leilões vende os três.",
	-- {item:14047} Runecloth
	["{item:14047} x40"] = "{item:14047} x40",
	-- {item:8836} Arthas' Tears
	["{item:8836} x10"] = "{item:8836} x10",
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["Arcanite Bars x6: an alchemist, or the Trade District Auction House"] = "Barras de Arcanita x6: um alquimista, ou a Casa de Leilões do Distrito Comercial",

	-- Step 9: Stratholme Holy Water
	-- {area:2279} Stratholme · {zone:1423} Eastern Plaguelands
	-- plural, as words: Stratholme Supply Crates = {object:181085} Stratholme Supply Crate
	["{area:2279} is a dungeon for a group of five at 58-60, at the north end of the {zone:1423}. Stratholme Supply Crates along the streets of both halves hold the Holy Water, one to three each; they come back after three minutes. Some crates let out a swarm of plagued rats or maggots: be ready. The main gate (the Scarlet half) needs no key."] = "{area:2279} é uma masmorra para um grupo de cinco no nível 58-60, no extremo norte de {zone:1423}. Os Caixotes de Suprimentos de Stratholme pelas ruas das duas metades guardam a Água Benta, de um a três cada; voltam depois de três minutos. Alguns caixotes soltam um enxame de ratos pestilentos ou larvas: esteja preparado. O portão principal (a metade Escarlate) não precisa de chave.",
	-- plural, as words: Stratholme Supply Crates = {object:181085} Stratholme Supply Crate
	["Stratholme Supply Crates, inside"] = "Caixotes de Suprimentos de Stratholme, lá dentro",

	-- Step 10: Grimand Elmore
	-- {npc:1416} Grimand Elmore · {item:18753} Arcanite Barding
	["Bring the materials and 150 gold, taken at the hand-in. {npc:1416} walks to his forge and hands you the {item:18753}."] = "Leve os materiais e 150 de ouro, cobrados na entrega. {npc:1416} vai até a forja dele e entrega {item:18753} a você.",
	-- {npc:1416} Grimand Elmore
	["{npc:1416}: 150 gold"] = "{npc:1416}: 150 de ouro",

	-- Step 11: Lord Grayson Shadowbreaker
	["Lord Grayson keeps the barding for now: you get it back with the next quest."] = "Lord Grayson fica com a armadura de montaria por enquanto: você a recebe de volta com a próxima missão.",
	-- {npc:928} Lord Grayson Shadowbreaker · {item:18753} Arcanite Barding
	["{npc:928}: the {item:18753}"] = "{npc:928}: a {item:18753}",

	-- Step 12: Enriched Manna Biscuits
	-- plural, as words: Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Enriched Manna Biscuits"] = "Biscoitos de Maná Enriquecidos",
	-- {object:2160} The Argent Dawn · {object:92525} Argent Dawn (no name in this language: may be words) · {npc:10857} Argent Quartermaster Lightspark · {area:3197} Chillwind Camp · {npc:11536} Quartermaster Miranda Breechlock · {area:2268} Light's Hope Chapel
	-- plural, as words: Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["{object:2160} quartermasters sell Enriched Manna Biscuits, five for 60 silver, once the {object:92525} is Friendly with you: {npc:10857} at {area:3197} or {npc:11536} at {area:2268}. Scourgestones and the Plaguelands quests raise the standing."] = "Os intendentes de {object:2160} vendem Biscoitos de Maná Enriquecidos, cinco por 60 pratas, quando Aurora Argêntea está Amigável com você: {npc:10857} em {area:3197} ou {npc:11536} em {area:2268}. As Pedras do Flagelo e as missões das Terras Pestilentas aumentam a reputação.",
	-- {npc:10857} Argent Quartermaster Lightspark · {area:3197} Chillwind Camp
	-- plural, as words: Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Enriched Manna Biscuits: {npc:10857}, {area:3197}"] = "Biscoitos de Maná Enriquecidos: {npc:10857}, {area:3197}",

	-- Step 13: Merideth Carlson
	-- {npc:2357} Merideth Carlson · {area:271} Southshore · {quest:7645} Manna-Enriched Horse Feed
	["{npc:2357} breeds horses in {area:271}'s stable. She makes the {quest:7645} from the 20 biscuits and 50 gold, taken at the hand-in."] = "{npc:2357} cria cavalos no estábulo de {area:271}. Ela faz {quest:7645} com os 20 biscoitos e 50 de ouro, cobrados na entrega.",

	-- Step 14: Dire Maul: Tendris Warpwood
	-- {area:2577} Dire Maul · {zone:1444} Feralas · {item:18249} Crescent Key · {npc:11489} Tendris Warpwood · {npc:11459} Ironbark Protector · {quest:7643} Ancient Equine Spirit · {item:18753} Arcanite Barding
	["{area:2577} lies in central {zone:1444}. From the gate at the foot of the ruins, walk up through the outer courtyards to the West wing's door at their north end; it needs a {item:18249} (from Pusillin in Dire Maul East) or a rogue's lockpicking. {npc:11489} (level 60 elite) stands at the far end of the West wing's first courtyard. Once attacked he calls every {npc:11459} still alive in the courtyard: kill them first. His death frees the {quest:7643}: talk to it to give it the horse feed and the {item:18753}, and it blesses the barding. A group of five at 60."] = "{area:2577} fica no centro de {zone:1444}. A partir do portão ao pé das ruínas, suba pelos pátios externos até a porta da ala Oeste, no extremo norte deles; ela precisa de {item:18249} (de Pusillin, em Gládio Cruel Leste) ou do arrombamento de um ladino. {npc:11489} (elite de nível 60) fica no fundo do primeiro pátio da ala Oeste. Quando atacado, ele chama todos os {npc:11459} ainda vivos no pátio: mate-os primeiro. A morte dele liberta {quest:7643}: fale com ele para entregar a ração do cavalo e {item:18753}, e ele abençoa a armadura de montaria. Um grupo de cinco no nível 60.",
	["Dire Maul West's door"] = "A porta de Gládio Cruel Oeste",
	-- {npc:11489} Tendris Warpwood
	["{npc:11489}, inside the West wing"] = "{npc:11489}, dentro da ala Oeste",

	-- Step 16: Two diamonds
	["Two diamonds"] = "Dois diamantes",
	-- {item:12800} Azerothian Diamond · {item:18335} Pristine Black Diamond · {npc:14695} Lord Blackwood
	["An {item:12800} comes from Thorium veins and obsidian, about one vein in a hundred; a {item:18335} drops rarely from elites of level 59 and up (Revanchion and {npc:14695} about one kill in nine and one in a hundred). The Auction House is the usual source of both."] = "{item:12800} vem de veios de Tório e obsidiana, cerca de um veio em cem; {item:18335} cai raramente de elites de nível 59 ou mais (Revanchion e {npc:14695}, cerca de uma morte em nove e uma em cem). A Casa de Leilões é a fonte de costume dos dois.",

	-- Step 17: Lord Grayson Shadowbreaker
	-- {item:18804} Lord Grayson's Satchel · {item:18746} Divination Scryer · {item:18792} Blessed Arcanite Barding
	["Lord Grayson hands you {item:18804}: open it for the {item:18746} and the {item:18792}. Keep both."] = "Lord Grayson entrega {item:18804} a você: abra para pegar {item:18746} e {item:18792}. Guarde os dois.",
	-- {item:18792} Blessed Arcanite Barding
	["{item:18792}, from the satchel"] = "{item:18792}, da sacola",

	-- Step 18: The Great Ossuary
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:13704} Skeleton Key · {object:179746} The Great Ossuary (no name in this language: may be words) · {item:18746} Divination Scryer · {spell:1105} Seal of Wisdom · {npc:14516} Death Knight Darkreaver · {item:18749} Charger's Lost Soul · {item:18792} Blessed Arcanite Barding · {npc:14568} Darkreaver's Fallen Charger
	["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}; the door needs the {item:13704} (The Key to {area:2057}). Clear the {object:179746}, Rattlegore's room in the basement, then use the {item:18746} at its centre. Four waves of spirits come, each ending with an Aspect: players judge them with {spell:1105}, Justice, Righteousness and then Light, which stuns them. {npc:14516} (level 62 elite) comes after the last; he mind-controls players. Loot the {item:18749}, use it inside the Ossuary to redeem it, and give it and the {item:18792} to {npc:14568}. If the group wipes, the gates lock and the scryer is gone: abandon the quest and take it again from Lord Grayson for a new satchel. A group of five at 60. Again Into the {object:179746}, after the mount, lets you fight him again."] = "{area:2057} fica embaixo de {area:2298}, a cidade na ilha no sudeste de {zone:1422}; a porta precisa de {item:13704} (A Chave de {area:2057}). Limpe O Grande Ossuário, a sala de Rattlegore no porão, e use {item:18746} no centro. Vêm quatro ondas de espíritos, cada uma terminando com um Aspecto: os jogadores os julgam com {spell:1105}, Justiça, Retidão e depois Luz, que os atordoa. {npc:14516} (elite de nível 62) vem depois da última; ele controla a mente de jogadores. Saqueie {item:18749}, use no Ossuário para redimir e entregue-o, junto com {item:18792}, a {npc:14568}. Se o grupo morrer, os portões se trancam e o vidente some: abandone a missão e pegue de novo com Lord Grayson para receber uma sacola nova. Um grupo de cinco no nível 60. A missão Again Into the O Grande Ossuário, depois da montaria, permite lutar com ele de novo.",
	-- {item:18749} Charger's Lost Soul · {object:179746} The Great Ossuary (no name in this language: may be words)
	["{item:18749}, inside the {object:179746}"] = "{item:18749}, dentro de O Grande Ossuário",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["An {item:12800} comes from Thorium veins, a {item:18335} from the elites of the {zone:1422}, both rarely: the Auction House is the usual source."] = "Um {item:12800} vem de veios de tório, um {item:18335} dos elites das {zone:1422}, ambos raramente: a Casa de Leilões é a fonte habitual.",
	-- ["Arcanite Bars: the Auction House"] = "Barras de Arcanita: a Casa de Leilões",
	-- ["Bring 150 gold for {npc:1416} along with the materials."] = "Leve 150 de ouro para {npc:1416} junto com os materiais.",
	-- ["Supply Crates, inside"] = "Caixotes de Suprimentos, lá dentro",
	-- ["Terrordale Spirits"] = "Espíritos da Várzea do Medo",
	-- ["The {spell:23214} chain is long: it takes you through {area:2279}, {area:2577} and {area:2057}, and costs about 350 gold in donations on top of the materials. Lord Grayson stands in the Cathedral of Light."] = "A série de {spell:23214} é longa: passa por {area:2279}, {area:2577} e {area:2057}, e custa cerca de 350 de ouro em doações além dos materiais. Lorde Grayson fica na Catedral da Luz.",
	-- ["he hands you the {item:18746}"] = "ele lhe entrega o {item:18746}",
	-- ["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. Use the {item:18746} in the heart of the {object:179746}'s basement, defeat the spirits it calls and then {npc:14516}, and give his Fallen Charger the {item:18799} and the {item:18792}. All are elite: bring a group. If the attempt fails, Lord Grayson gives you a new scryer through Again Into the {object:179746}."] = "{area:2057} fica embaixo de {area:2298}, a cidade na ilha do sudeste das {zone:1422}. Use o {item:18746} no centro do porão do Grande Ossuário, derrote os espíritos que ele chama e depois {npc:14516}, e dê ao Corcel Caído dele a {item:18799} e a {item:18792}. Todos são elite: leve um grupo. Se a tentativa falhar, Lorde Grayson lhe dá um novo vidente pela missão De volta ao Grande Ossuário.",
	-- ["{area:2279} is a group of five, level 58-60, at the north end of the {zone:1423}. The Supply Crates scattered through the city hold the {item:13180}."] = "{area:2279} é para um grupo de cinco, nível 58-60, no extremo norte das {zone:1423}. Os Caixotes de Suprimentos espalhados pela cidade guardam a {item:13180}.",
	-- ["{area:2577} lies in central {zone:1444}; {npc:11489} guards the start of the West wing. Defeat him to free the {quest:7643}, feed it the {item:18775} and hand it the {item:18753} to bless. Bring a group."] = "{area:2577} fica no centro de {zone:1444}; {npc:11489} guarda o início da ala Oeste. Derrote-o para libertar {quest:7643}, alimente-o com a {item:18775} e entregue-lhe a {item:18753} para abençoar. Leve um grupo.",
	-- ["{area:2627} lies in the far north-west of the {zone:1423}, by the {zone:1422} border. Use the {item:18752} there to drive out the spirits, then defeat them."] = "{area:2627} fica no extremo noroeste das {zone:1423}, na divisa com as {zone:1422}. Use o {item:18752} lá para expulsar os espíritos e depois derrote-os.",
	-- ["{item:14047} drops from humanoids around level 50 and up; {item:8836} is an herb of the Plaguelands and {zone:1448}; Arcanite Bars are an {skill:171} transmute. The Auction House in {zone:1453}'s {object:2096} sells all three, and so do crafters."] = "{item:14047} cai de humanoides a partir do nível 50; {item:8836} é uma erva das Terras Pestilentas e de {zone:1448}; Barras de Arcanita são uma transmutação de {skill:171}. A Casa de Leilões no {object:2096} de {zone:1453} vende os três, assim como os artesãos.",
	-- ["{npc:11406} is in {zone:1455}'s {object:32362}. Bring 150 gold: the censer is yours for a donation."] = "{npc:11406} está na {object:32362} de {zone:1455}. Leve 150 de ouro: o incensário é seu por uma doação.",
	-- ["{npc:1416} works in {zone:1453}'s {object:28027}."] = "{npc:1416} trabalha no {object:28027} de {zone:1453}.",
	-- ["{npc:2357} breeds horses in {area:271}. She also wants 50 gold."] = "{npc:2357} cria cavalos em {area:271}. Ela também quer 50 de ouro.",
	-- ["{object:2160} quartermasters sell the biscuits in fives once the {object:92525} is Friendly with you: {npc:10857} at {area:3197}, {npc:11536} at {area:2268}, {npc:10856} at the {area:813}."] = "Os intendentes da {object:2160} vendem os biscoitos de cinco em cinco quando a {object:92525} for Amistosa com você: {npc:10857} no {area:3197}, {npc:11536} na {area:2268}, {npc:10856} no {area:813}.",
}
