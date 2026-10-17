-- Spanish (Latin America) (esMX): the guide forever/collectibles/mounts/alliance/paladin-charger (forever/collectibles/mounts/alliance/paladin-charger.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Paladin Charger"] = "Destrero de paladín",
	["Your epic mount at 60, summoned at will: the faster step up from the Warhorse."] = "Tu montura épica a nivel 60, invocada a voluntad: el paso más rápido tras el caballo de guerra.",

	-- Step 1: Lord Grayson Shadowbreaker (Ironforge)
	-- {npc:5149} Brandur Ironhammer · {object:32362} Mystic Ward (no name in this language: may be words) · {quest:7638} Lord Grayson Shadowbreaker · {zone:1453} Stormwind
	["At 60 {npc:5149} in the {object:32362} sends you to {quest:7638} in {zone:1453}'s Cathedral of Light."] = "A nivel 60, {npc:5149} en {object:32362} te manda con {quest:7638} en la Catedral de la Luz de {zone:1453}.",

	-- Step 2: Lord Grayson Shadowbreaker
	-- {spell:23214} Summon Charger · {area:2279} Stratholme · {area:2577} Dire Maul · {area:2057} Scholomance
	["The {spell:23214} chain is long: it takes you through {area:2279}, {area:2577} and {area:2057}, and costs about 350 gold in donations on top of the materials. Lord Grayson stands in the Cathedral of Light."] = "La cadena de {spell:23214} es larga: te lleva por {area:2279}, {area:2577} y {area:2057}, y cuesta unos 350 de oro en donaciones además de los materiales. Lord Grisillo está en la Catedral de la Luz.",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}, Cathedral of Light"] = "{npc:6171}, Catedral de la Luz",

	-- Step 3: High Priest Rohan
	-- {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words)
	["{npc:11406} is in {zone:1455}'s {object:32362}. Bring 150 gold: the censer is yours for a donation."] = "{npc:11406} está en {object:32362} de {zone:1455}. Lleva 150 de oro: el incensario es tuyo a cambio de una donación.",
	-- {npc:11406} High Priest Rohan
	["{npc:11406}: 150 gold"] = "{npc:11406}: 150 de oro",

	-- Step 4: Back to Lord Grayson
	["Back to Lord Grayson"] = "Vuelve con Lord Grisillo",

	-- Step 5: Exorcising Terrordale
	-- {area:2627} Terrordale · {zone:1423} Eastern Plaguelands · {zone:1422} Western Plaguelands · {item:18752} Exorcism Censer
	["{area:2627} lies in the far north-west of the {zone:1423}, by the {zone:1422} border. Use the {item:18752} there to drive out the spirits, then defeat them."] = "El {area:2627} está en el extremo noroeste de {zone:1423}, junto al límite con {zone:1422}. Usa ahí el {item:18752} para expulsar a los espíritus y luego derrótalos.",
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit
	["Terrordale Spirits"] = "Espíritus del Valle del Terror ({npc:14564})",

	-- Step 7: Grimand Elmore
	-- {npc:1416} Grimand Elmore · {zone:1453} Stormwind · {object:28027} Dwarven District
	["{npc:1416} works in {zone:1453}'s {object:28027}."] = "{npc:1416} trabaja en {object:28027} de {zone:1453}.",

	-- Step 8: Grimand Elmore's materials
	-- {npc:1416} Grimand Elmore
	["{npc:1416}'s materials"] = "Materiales de {npc:1416}",
	-- {item:14047} Runecloth · {item:8836} Arthas' Tears · {zone:1448} Felwood · {skill:171} Alchemy · {zone:1453} Stormwind · {object:2096} Trade District
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["{item:14047} drops from humanoids around level 50 and up; {item:8836} is an herb of the Plaguelands and {zone:1448}; Arcanite Bars are an {skill:171} transmute. The Auction House in {zone:1453}'s {object:2096} sells all three, and so do crafters."] = "El {item:14047} lo sueltan humanoides de nivel 50 en adelante; {item:8836} es una hierba de las Tierras de la Peste y de {zone:1448}; las Barras de arcanita son una transmutación de {skill:171}. La casa de subastas de {object:2096} de {zone:1453} vende las tres, y también los artesanos.",
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["Arcanite Bars: the Auction House"] = "Barras de arcanita: la casa de subastas",

	-- Step 9: Stratholme Holy Water
	-- {area:2279} Stratholme · {zone:1423} Eastern Plaguelands · {item:13180} Stratholme Holy Water
	-- plural, as words: Supply Crates = {item:4629} Supply Crate
	["{area:2279} is a group of five, level 58-60, at the north end of the {zone:1423}. The Supply Crates scattered through the city hold the {item:13180}."] = "{area:2279} es para un grupo de cinco, nivel 58-60, en el extremo norte de {zone:1423}. Los Cajones de suministros repartidos por la ciudad contienen el {item:13180}.",
	-- plural, as words: Supply Crates = {item:4629} Supply Crate
	["Supply Crates, inside"] = "Cajones de suministros, dentro",

	-- Step 10: Grimand Elmore
	-- {npc:1416} Grimand Elmore
	["Bring 150 gold for {npc:1416} along with the materials."] = "Lleva 150 de oro para {npc:1416} junto con los materiales.",
	-- {npc:1416} Grimand Elmore
	["{npc:1416}: 150 gold"] = "{npc:1416}: 150 de oro",

	-- Step 11: Lord Grayson Shadowbreaker
	-- {npc:928} Lord Grayson Shadowbreaker · {item:18753} Arcanite Barding
	["{npc:928}: the {item:18753}"] = "{npc:928}: la {item:18753}",

	-- Step 12: Enriched Manna Biscuits
	-- plural, as words: Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Enriched Manna Biscuits"] = "Galletas enriquecidas con maná",
	-- {object:2160} The Argent Dawn · {object:92525} Argent Dawn · {npc:10857} Argent Quartermaster Lightspark · {area:3197} Chillwind Camp · {npc:11536} Quartermaster Miranda Breechlock · {area:2268} Light's Hope Chapel · {npc:10856} Argent Quartermaster Hasana · {area:813} Bulwark
	["{object:2160} quartermasters sell the biscuits in fives once the {object:92525} is Friendly with you: {npc:10857} at {area:3197}, {npc:11536} at {area:2268}, {npc:10856} at the {area:813}."] = "Los intendentes de {object:2160} venden las galletas de cinco en cinco cuando eres Amistoso con {object:92525}: {npc:10857} en el {area:3197}, {npc:11536} en la {area:2268}, {npc:10856} en {area:813}.",
	-- {npc:10857} Argent Quartermaster Lightspark · {area:3197} Chillwind Camp
	-- plural, as words: Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Enriched Manna Biscuits: {npc:10857}, {area:3197}"] = "Galletas enriquecidas con maná: {npc:10857}, {area:3197}",

	-- Step 13: Merideth Carlson
	-- {npc:2357} Merideth Carlson · {area:271} Southshore
	["{npc:2357} breeds horses in {area:271}. She also wants 50 gold."] = "{npc:2357} cría caballos en {area:271}. También quiere 50 de oro.",

	-- Step 14: Dire Maul: Tendris Warpwood
	-- {area:2577} Dire Maul · {zone:1444} Feralas · {npc:11489} Tendris Warpwood · {quest:7643} Ancient Equine Spirit · {item:18775} Manna-Enriched Horse Feed · {item:18753} Arcanite Barding
	["{area:2577} lies in central {zone:1444}; {npc:11489} guards the start of the West wing. Defeat him to free the {quest:7643}, feed it the {item:18775} and hand it the {item:18753} to bless. Bring a group."] = "{area:2577} está en el centro de {zone:1444}; {npc:11489} guarda el inicio del ala oeste. Derrótalo para liberar a {quest:7643}, dale el {item:18775} y entrégale la {item:18753} para que la bendiga. Lleva un grupo.",
	-- {npc:11489} Tendris Warpwood
	["{npc:11489}, inside the West wing"] = "{npc:11489}, dentro del ala oeste",

	-- Step 16: Two diamonds
	["Two diamonds"] = "Dos diamantes",
	-- {item:12800} Azerothian Diamond · {item:18335} Pristine Black Diamond · {zone:1422} Western Plaguelands
	["An {item:12800} comes from Thorium veins, a {item:18335} from the elites of the {zone:1422}, both rarely: the Auction House is the usual source."] = "Un {item:12800} sale de los filones de torio y un {item:18335} de los élites de {zone:1422}, ambos rara vez: lo habitual es la casa de subastas.",

	-- Step 17: Lord Grayson Shadowbreaker
	-- {item:18746} Divination Scryer
	["he hands you the {item:18746}"] = "te da el {item:18746}",

	-- Step 18: The Great Ossuary
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:18746} Divination Scryer · {object:179746} The Great Ossuary · {npc:14516} Death Knight Darkreaver · {item:18799} Charger's Redeemed Soul · {item:18792} Blessed Arcanite Barding
	["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. Use the {item:18746} in the heart of the {object:179746}'s basement, defeat the spirits it calls and then {npc:14516}, and give his Fallen Charger the {item:18799} and the {item:18792}. All are elite: bring a group. If the attempt fails, Lord Grayson gives you a new scryer through Again Into the {object:179746}."] = "{area:2057} está bajo {area:2298}, el pueblo de la isla al sureste de {zone:1422}. Usa el {item:18746} en el centro del sótano de {object:179746}, derrota a los espíritus que invoca y luego a {npc:14516}, y dale a su Arremetedor Atracoscuro el {item:18799} y la {item:18792}. Todos son élite: lleva un grupo. Si el intento falla, Lord Grisillo te da un nuevo cristal con la misión El regreso a {object:179746}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. Use the {item:18746} in the heart of the {object:179746}'s basement, defeat the spirits it calls and then {npc:14516}, and give his Fallen Charger the {item:18799} and the {item:18792}. All are elite: bring a group. If the attempt fails, Lord Grayson gives you a new scryer through Again Into the {object:179746}."] = "{area:2057} está bajo {area:2298}, el pueblo de la isla al sureste de {zone:1422}. Usa el {item:18746} en el centro del sótano de {object:179746}, derrota a los espíritus que invoca y luego a {npc:14516}, y dale a su Arremetedor Atracoscuro el {item:18799} y la {item:18792}. Todos son élite: lleva un grupo. Si el intento falla, Lord Grisillo te da un nuevo cristal con la misión Again Into the {object:179746}.",
}
