-- French (frFR): the guide forever/collectibles/mounts/alliance/paladin-charger (forever/collectibles/mounts/alliance/paladin-charger.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Paladin Charger"] = "Destrier de paladin",
	["Your epic mount at 60, summoned at will: the faster step up from the Warhorse."] = "Votre monture épique au niveau 60, invoquée à volonté : l'étape plus rapide après le Cheval de guerre.",

	-- Step 1: Lord Grayson Shadowbreaker (Ironforge)
	-- {npc:5149} Brandur Ironhammer · {object:32362} Mystic Ward · {quest:7638} Lord Grayson Shadowbreaker · {zone:1453} Stormwind
	["At 60 {npc:5149} in the {object:32362} sends you to {quest:7638} in {zone:1453}'s Cathedral of Light."] = "Au niveau 60, {npc:5149}, dans {object:32362}, vous envoie voir {quest:7638} à la cathédrale de la Lumière de {zone:1453}.",

	-- Step 2: Lord Grayson Shadowbreaker
	-- {spell:23214} Summon Charger · {area:2279} Stratholme · {area:2577} Dire Maul · {area:2057} Scholomance
	["The {spell:23214} chain is long: it takes you through {area:2279}, {area:2577} and {area:2057}, and costs about 350 gold in donations on top of the materials. Lord Grayson stands in the Cathedral of Light."] = "La suite de quêtes {spell:23214} est longue : elle vous mène à {area:2279}, {area:2577} et {area:2057}, et coûte environ 350 pièces d'or de dons en plus des matériaux. Le seigneur Grayson se tient dans la cathédrale de la Lumière.",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}, Cathedral of Light"] = "{npc:6171}, cathédrale de la Lumière",

	-- Step 3: High Priest Rohan
	-- {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {object:32362} Mystic Ward
	["{npc:11406} is in {zone:1455}'s {object:32362}. Bring 150 gold: the censer is yours for a donation."] = "{npc:11406} est à {zone:1455}, dans {object:32362}. Apportez 150 pièces d'or : l'encensoir est à vous contre un don.",
	-- {npc:11406} High Priest Rohan
	["{npc:11406}: 150 gold"] = "{npc:11406} : 150 pièces d'or",

	-- Step 4: Back to Lord Grayson
	["Back to Lord Grayson"] = "Retour auprès du seigneur Grayson",

	-- Step 5: Exorcising Terrordale
	-- {area:2627} Terrordale · {zone:1423} Eastern Plaguelands · {zone:1422} Western Plaguelands · {item:18752} Exorcism Censer
	["{area:2627} lies in the far north-west of the {zone:1423}, by the {zone:1422} border. Use the {item:18752} there to drive out the spirits, then defeat them."] = "{area:2627} se trouve à l'extrême nord-ouest de {zone:1423}, près de la frontière de {zone:1422}. Utilisez-y {item:18752} pour faire sortir les esprits, puis vainquez-les.",
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit
	["Terrordale Spirits"] = "Esprits de Val-Terreur ({npc:14564})",

	-- Step 7: Grimand Elmore
	-- {npc:1416} Grimand Elmore · {zone:1453} Stormwind · {object:28027} Dwarven District
	["{npc:1416} works in {zone:1453}'s {object:28027}."] = "{npc:1416} travaille à {zone:1453}, dans {object:28027}.",

	-- Step 8: Grimand Elmore's materials
	-- {npc:1416} Grimand Elmore
	["{npc:1416}'s materials"] = "Matériaux de {npc:1416}",
	-- {item:14047} Runecloth · {item:8836} Arthas' Tears · {zone:1448} Felwood · {skill:171} Alchemy · {zone:1453} Stormwind · {object:2096} Trade District
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["{item:14047} drops from humanoids around level 50 and up; {item:8836} is an herb of the Plaguelands and {zone:1448}; Arcanite Bars are an {skill:171} transmute. The Auction House in {zone:1453}'s {object:2096} sells all three, and so do crafters."] = "{item:14047} est lâchée par les humanoïdes à partir du niveau 50 environ ; {item:8836} est une herbe des Maleterres et de {zone:1448} ; les Barres d'arcanite sont une transmutation d'{skill:171}. L'hôtel des ventes de {zone:1453}, dans {object:2096}, vend les trois, tout comme les artisans.",
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["Arcanite Bars: the Auction House"] = "Barres d'arcanite : l'hôtel des ventes",

	-- Step 9: Stratholme Holy Water
	-- {area:2279} Stratholme · {zone:1423} Eastern Plaguelands · {item:13180} Stratholme Holy Water
	-- plural, as words: Supply Crates = {item:4629} Supply Crate
	["{area:2279} is a group of five, level 58-60, at the north end of the {zone:1423}. The Supply Crates scattered through the city hold the {item:13180}."] = "{area:2279} se fait en groupe de cinq, niveau 58-60, à l'extrémité nord de {zone:1423}. Les Caisses de fournitures dispersées dans la ville contiennent {item:13180}.",
	-- plural, as words: Supply Crates = {item:4629} Supply Crate
	["Supply Crates, inside"] = "Caisses de fournitures, à l'intérieur",

	-- Step 10: Grimand Elmore
	-- {npc:1416} Grimand Elmore
	["Bring 150 gold for {npc:1416} along with the materials."] = "Apportez 150 pièces d'or pour {npc:1416} avec les matériaux.",
	-- {npc:1416} Grimand Elmore
	["{npc:1416}: 150 gold"] = "{npc:1416} : 150 pièces d'or",

	-- Step 11: Lord Grayson Shadowbreaker
	-- {npc:928} Lord Grayson Shadowbreaker · {item:18753} Arcanite Barding
	["{npc:928}: the {item:18753}"] = "{npc:928} : {item:18753}",

	-- Step 12: Enriched Manna Biscuits
	-- plural, as words: Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Enriched Manna Biscuits"] = "Biscuits enrichis en manne",
	-- {object:2160} The Argent Dawn · {object:92525} Argent Dawn · {npc:10857} Argent Quartermaster Lightspark · {area:3197} Chillwind Camp · {npc:11536} Quartermaster Miranda Breechlock · {area:2268} Light's Hope Chapel · {npc:10856} Argent Quartermaster Hasana · {area:813} Bulwark
	["{object:2160} quartermasters sell the biscuits in fives once the {object:92525} is Friendly with you: {npc:10857} at {area:3197}, {npc:11536} at {area:2268}, {npc:10856} at the {area:813}."] = "Les intendants de {object:2160} vendent les biscuits par cinq dès que vous êtes Amical avec {object:92525} : {npc:10857} à {area:3197}, {npc:11536} à {area:2268}, {npc:10856} à {area:813}.",
	-- {npc:10857} Argent Quartermaster Lightspark · {area:3197} Chillwind Camp
	-- plural, as words: Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Enriched Manna Biscuits: {npc:10857}, {area:3197}"] = "Biscuits enrichis en manne : {npc:10857}, {area:3197}",

	-- Step 13: Merideth Carlson
	-- {npc:2357} Merideth Carlson · {area:271} Southshore
	["{npc:2357} breeds horses in {area:271}. She also wants 50 gold."] = "{npc:2357} élève des chevaux à {area:271}. Elle demande aussi 50 pièces d'or.",

	-- Step 14: Dire Maul: Tendris Warpwood
	-- {area:2577} Dire Maul · {zone:1444} Feralas · {npc:11489} Tendris Warpwood · {quest:7643} Ancient Equine Spirit · {item:18775} Manna-Enriched Horse Feed · {item:18753} Arcanite Barding
	["{area:2577} lies in central {zone:1444}; {npc:11489} guards the start of the West wing. Defeat him to free the {quest:7643}, feed it the {item:18775} and hand it the {item:18753} to bless. Bring a group."] = "{area:2577} se trouve au centre de {zone:1444} ; {npc:11489} garde le début de l'aile Ouest. Vainquez-le pour libérer {quest:7643}, donnez-lui {item:18775} et remettez-lui {item:18753} à bénir. Venez en groupe.",
	-- {npc:11489} Tendris Warpwood
	["{npc:11489}, inside the West wing"] = "{npc:11489}, dans l'aile Ouest",

	-- Step 16: Two diamonds
	["Two diamonds"] = "Deux diamants",
	-- {item:12800} Azerothian Diamond · {item:18335} Pristine Black Diamond · {zone:1422} Western Plaguelands
	["An {item:12800} comes from Thorium veins, a {item:18335} from the elites of the {zone:1422}, both rarely: the Auction House is the usual source."] = "{item:12800} provient des filons de thorium, {item:18335} des élites de {zone:1422}, tous deux rarement : l'hôtel des ventes est la source habituelle.",

	-- Step 17: Lord Grayson Shadowbreaker
	-- {item:18746} Divination Scryer
	["he hands you the {item:18746}"] = "il vous remet {item:18746}",

	-- Step 18: The Great Ossuary
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:18746} Divination Scryer · {object:179746} The Great Ossuary (no name in this language: may be words) · {npc:14516} Death Knight Darkreaver · {item:18799} Charger's Redeemed Soul · {item:18792} Blessed Arcanite Barding
	["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. Use the {item:18746} in the heart of the {object:179746}'s basement, defeat the spirits it calls and then {npc:14516}, and give his Fallen Charger the {item:18799} and the {item:18792}. All are elite: bring a group. If the attempt fails, Lord Grayson gives you a new scryer through Again Into the {object:179746}."] = "{area:2057} se trouve sous {area:2298}, la ville insulaire au sud-est de {zone:1422}. Utilisez {item:18746} au cœur du sous-sol du Grand ossuaire, vainquez les esprits qu'il appelle puis {npc:14516}, et donnez à son Destrier déchu {item:18799} et {item:18792}. Tous sont élites : venez en groupe. Si la tentative échoue, le seigneur Grayson vous donne un nouveau cristal via la quête Retour au Grand ossuaire.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. Use the {item:18746} in the heart of the {object:179746}'s basement, defeat the spirits it calls and then {npc:14516}, and give his Fallen Charger the {item:18799} and the {item:18792}. All are elite: bring a group. If the attempt fails, Lord Grayson gives you a new scryer through Again Into the {object:179746}."] = "{area:2057} se trouve sous {area:2298}, la ville insulaire au sud-est de {zone:1422}. Utilisez {item:18746} au cœur du sous-sol de {object:179746}, vainquez les esprits qu'il appelle puis {npc:14516}, et donnez à son Destrier déchu {item:18799} et {item:18792}. Tous sont élites : venez en groupe. Si la tentative échoue, le seigneur Grayson vous donne un nouveau cristal via la quête Retour au Grand ossuaire ({object:179746}).",
}
