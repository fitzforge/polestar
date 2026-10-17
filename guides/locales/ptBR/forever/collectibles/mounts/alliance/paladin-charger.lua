-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/mounts/alliance/paladin-charger (forever/collectibles/mounts/alliance/paladin-charger.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {spell:23214} Summon Charger · {area:2279} Stratholme · {area:2577} Dire Maul · {area:2057} Scholomance
	["The {spell:23214} chain is long: it takes you through {area:2279}, {area:2577} and {area:2057}, and costs about 350 gold in donations on top of the materials. Lord Grayson stands in the Cathedral of Light."] = "A série de {spell:23214} é longa: passa por {area:2279}, {area:2577} e {area:2057}, e custa cerca de 350 de ouro em doações além dos materiais. Lorde Grayson fica na Catedral da Luz.",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}, Cathedral of Light"] = "{npc:6171}, Catedral da Luz",

	-- Step 3: High Priest Rohan
	-- {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words)
	["{npc:11406} is in {zone:1455}'s {object:32362}. Bring 150 gold: the censer is yours for a donation."] = "{npc:11406} está na {object:32362} de {zone:1455}. Leve 150 de ouro: o incensário é seu por uma doação.",
	-- {npc:11406} High Priest Rohan
	["{npc:11406}: 150 gold"] = "{npc:11406}: 150 de ouro",

	-- Step 4: Back to Lord Grayson
	["Back to Lord Grayson"] = "De volta a Lorde Grayson",

	-- Step 5: Exorcising Terrordale
	-- {area:2627} Terrordale · {zone:1423} Eastern Plaguelands · {zone:1422} Western Plaguelands · {item:18752} Exorcism Censer
	["{area:2627} lies in the far north-west of the {zone:1423}, by the {zone:1422} border. Use the {item:18752} there to drive out the spirits, then defeat them."] = "{area:2627} fica no extremo noroeste das {zone:1423}, na divisa com as {zone:1422}. Use o {item:18752} lá para expulsar os espíritos e depois derrote-os.",
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit
	["Terrordale Spirits"] = "Espíritos da Várzea do Medo",

	-- Step 7: Grimand Elmore
	-- {npc:1416} Grimand Elmore · {zone:1453} Stormwind · {object:28027} Dwarven District
	["{npc:1416} works in {zone:1453}'s {object:28027}."] = "{npc:1416} trabalha no {object:28027} de {zone:1453}.",

	-- Step 8: Grimand Elmore's materials
	-- {npc:1416} Grimand Elmore
	["{npc:1416}'s materials"] = "Materiais de {npc:1416}",
	-- {item:14047} Runecloth · {item:8836} Arthas' Tears · {zone:1448} Felwood · {skill:171} Alchemy · {zone:1453} Stormwind · {object:2096} Trade District
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["{item:14047} drops from humanoids around level 50 and up; {item:8836} is an herb of the Plaguelands and {zone:1448}; Arcanite Bars are an {skill:171} transmute. The Auction House in {zone:1453}'s {object:2096} sells all three, and so do crafters."] = "{item:14047} cai de humanoides a partir do nível 50; {item:8836} é uma erva das Terras Pestilentas e de {zone:1448}; Barras de Arcanita são uma transmutação de {skill:171}. A Casa de Leilões no {object:2096} de {zone:1453} vende os três, assim como os artesãos.",
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["Arcanite Bars: the Auction House"] = "Barras de Arcanita: a Casa de Leilões",

	-- Step 9: Stratholme Holy Water
	-- {area:2279} Stratholme · {zone:1423} Eastern Plaguelands · {item:13180} Stratholme Holy Water
	-- plural, as words: Supply Crates = {item:4629} Supply Crate
	["{area:2279} is a group of five, level 58-60, at the north end of the {zone:1423}. The Supply Crates scattered through the city hold the {item:13180}."] = "{area:2279} é para um grupo de cinco, nível 58-60, no extremo norte das {zone:1423}. Os Caixotes de Suprimentos espalhados pela cidade guardam a {item:13180}.",
	-- plural, as words: Supply Crates = {item:4629} Supply Crate
	["Supply Crates, inside"] = "Caixotes de Suprimentos, lá dentro",

	-- Step 10: Grimand Elmore
	-- {npc:1416} Grimand Elmore
	["Bring 150 gold for {npc:1416} along with the materials."] = "Leve 150 de ouro para {npc:1416} junto com os materiais.",
	-- {npc:1416} Grimand Elmore
	["{npc:1416}: 150 gold"] = "{npc:1416}: 150 de ouro",

	-- Step 11: Lord Grayson Shadowbreaker
	-- {npc:928} Lord Grayson Shadowbreaker · {item:18753} Arcanite Barding
	["{npc:928}: the {item:18753}"] = "{npc:928}: a {item:18753}",

	-- Step 12: Enriched Manna Biscuits
	-- plural, as words: Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Enriched Manna Biscuits"] = "Biscoitos de Maná Enriquecidos",
	-- {object:2160} The Argent Dawn · {object:92525} Argent Dawn (no name in this language: may be words) · {npc:10857} Argent Quartermaster Lightspark · {area:3197} Chillwind Camp · {npc:11536} Quartermaster Miranda Breechlock · {area:2268} Light's Hope Chapel · {npc:10856} Argent Quartermaster Hasana · {area:813} Bulwark
	["{object:2160} quartermasters sell the biscuits in fives once the {object:92525} is Friendly with you: {npc:10857} at {area:3197}, {npc:11536} at {area:2268}, {npc:10856} at the {area:813}."] = "Os intendentes da {object:2160} vendem os biscoitos de cinco em cinco quando a {object:92525} for Amistosa com você: {npc:10857} no {area:3197}, {npc:11536} na {area:2268}, {npc:10856} no {area:813}.",
	-- {npc:10857} Argent Quartermaster Lightspark · {area:3197} Chillwind Camp
	-- plural, as words: Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Enriched Manna Biscuits: {npc:10857}, {area:3197}"] = "Biscoitos de Maná Enriquecidos: {npc:10857}, {area:3197}",

	-- Step 13: Merideth Carlson
	-- {npc:2357} Merideth Carlson · {area:271} Southshore
	["{npc:2357} breeds horses in {area:271}. She also wants 50 gold."] = "{npc:2357} cria cavalos em {area:271}. Ela também quer 50 de ouro.",

	-- Step 14: Dire Maul: Tendris Warpwood
	-- {area:2577} Dire Maul · {zone:1444} Feralas · {npc:11489} Tendris Warpwood · {quest:7643} Ancient Equine Spirit · {item:18775} Manna-Enriched Horse Feed · {item:18753} Arcanite Barding
	["{area:2577} lies in central {zone:1444}; {npc:11489} guards the start of the West wing. Defeat him to free the {quest:7643}, feed it the {item:18775} and hand it the {item:18753} to bless. Bring a group."] = "{area:2577} fica no centro de {zone:1444}; {npc:11489} guarda o início da ala Oeste. Derrote-o para libertar {quest:7643}, alimente-o com a {item:18775} e entregue-lhe a {item:18753} para abençoar. Leve um grupo.",
	-- {npc:11489} Tendris Warpwood
	["{npc:11489}, inside the West wing"] = "{npc:11489}, dentro da ala Oeste",

	-- Step 16: Two diamonds
	["Two diamonds"] = "Dois diamantes",
	-- {item:12800} Azerothian Diamond · {item:18335} Pristine Black Diamond · {zone:1422} Western Plaguelands
	["An {item:12800} comes from Thorium veins, a {item:18335} from the elites of the {zone:1422}, both rarely: the Auction House is the usual source."] = "Um {item:12800} vem de veios de tório, um {item:18335} dos elites das {zone:1422}, ambos raramente: a Casa de Leilões é a fonte habitual.",

	-- Step 17: Lord Grayson Shadowbreaker
	-- {item:18746} Divination Scryer
	["he hands you the {item:18746}"] = "ele lhe entrega o {item:18746}",

	-- Step 18: The Great Ossuary
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:18746} Divination Scryer · {object:179746} The Great Ossuary (no name in this language: may be words) · {npc:14516} Death Knight Darkreaver · {item:18799} Charger's Redeemed Soul · {item:18792} Blessed Arcanite Barding
	["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. Use the {item:18746} in the heart of the {object:179746}'s basement, defeat the spirits it calls and then {npc:14516}, and give his Fallen Charger the {item:18799} and the {item:18792}. All are elite: bring a group. If the attempt fails, Lord Grayson gives you a new scryer through Again Into the {object:179746}."] = "{area:2057} fica embaixo de {area:2298}, a cidade na ilha do sudeste das {zone:1422}. Use o {item:18746} no centro do porão do Grande Ossuário, derrote os espíritos que ele chama e depois {npc:14516}, e dê ao Corcel Caído dele a {item:18799} e a {item:18792}. Todos são elite: leve um grupo. Se a tentativa falhar, Lorde Grayson lhe dá um novo vidente pela missão De volta ao Grande Ossuário.",
}
