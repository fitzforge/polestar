-- French (frFR): the guide forever/collectibles/mounts/alliance/paladin-charger (forever/collectibles/mounts/alliance/paladin-charger.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {spell:23214} Summon Charger · {area:2279} Stratholme · {area:2057} Scholomance · {item:14047} Runecloth · {item:8836} Arthas' Tears · {npc:6171} Duthorian Rall
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["The {spell:23214} chain is long: {area:2279}, Dire Maul West and {area:2057} with a group, 350 gold in donations, and materials worth several hundred more (6 Arcanite Bars, 40 {item:14047}, 10 {item:8836}, two diamonds). Start saving early. Lord Grayson stands in the Cathedral of Light, {npc:6171} nearby."] = "La chaîne de {spell:23214} est longue : {area:2279}, Haches-Tripes Ouest et {area:2057} en groupe, 350 pièces d'or en dons, et des matériaux valant plusieurs centaines de plus (6 Barres d'arcanite, 40 {item:14047}, 10 {item:8836}, deux diamants). Commencez à économiser tôt. Le seigneur Grayson se tient dans la cathédrale de la Lumière, {npc:6171} tout près.",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}, Cathedral of Light"] = "{npc:6171}, cathédrale de la Lumière",

	-- Step 3: High Priest Rohan
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward
	["{npc:11406}, the priest trainer, walks about the {object:32386} in {zone:1455}'s {object:32362}. He gives you his censer for a donation of 150 gold, taken at the hand-in. Keep the censer."] = "{npc:11406}, le maître des prêtres, déambule dans la salle des Mystères de la {object:32362} de {zone:1455}. Il vous donne son encensoir contre un don de 150 pièces d'or, prélevé quand vous rendez la quête. Gardez l'encensoir.",
	-- {npc:11406} High Priest Rohan
	["{npc:11406}: 150 gold"] = "{npc:11406} : 150 pièces d'or",

	-- Step 4: Back to Lord Grayson
	["Back to Lord Grayson"] = "Retour auprès du seigneur Grayson",
	-- {item:18752} Exorcism Censer · {area:2627} Terrordale
	["Lord Grayson blesses the censer into the {item:18752} for {area:2627}."] = "Le seigneur Grayson bénit l'encensoir, qui devient l'{item:18752}, pour {area:2627}.",

	-- Step 5: Exorcising Terrordale
	-- {area:2627} Terrordale · {zone:1423} Eastern Plaguelands · {area:2279} Stratholme · {object:179747} Terrordale Haunting Spirit (no name in this language: may be words) · {item:18752} Exorcism Censer · {spell:7713} Wailing Dead · {spell:2878} Turn Undead
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit
	["{area:2627} lies in the far north-west of the {zone:1423}, west of the {area:2279} gates. Stand inside a green glowing patch on the ground (a {object:179747}; some are inside the ruined houses) and use the {item:18752}: up to three Terrordale Spirits (level 59-60) rise and attack. Their {spell:7713} lowers all your stats by 30%: fight them one at a time and use {spell:2878}. The patches come back quickly; several paladins can work side by side."] = "{area:2627} se trouve à l'extrême nord-ouest des {zone:1423}, à l'ouest des portes de {area:2279}. Placez-vous dans une tache verte lumineuse au sol (un esprit hanteur de Val-Terreur ; certaines sont dans les maisons en ruine) et utilisez l'{item:18752} : jusqu'à trois Esprits de Val-Terreur (niveau 59-60) s'élèvent et attaquent. Leur {spell:7713} réduit toutes vos caractéristiques de 30 % : combattez-les un par un et utilisez {spell:2878}. Les taches reviennent vite ; plusieurs paladins peuvent travailler côte à côte.",
	-- {item:18752} Exorcism Censer
	["{item:18752}, inside a green patch"] = "{item:18752}, dans une tache verte",
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit
	["Terrordale Spirits x25"] = "Esprits de Val-Terreur x25",

	-- Step 6: Lord Grayson Shadowbreaker
	["Lord Grayson takes the censer back."] = "Le seigneur Grayson reprend l'encensoir.",

	-- Step 7: Grimand Elmore
	-- {npc:1416} Grimand Elmore · {zone:1453} Stormwind · {object:28027} Dwarven District · {item:18753} Arcanite Barding
	["{npc:1416} works in {zone:1453}'s {object:28027}. He forges the {item:18753} from your materials and 150 gold."] = "{npc:1416} travaille dans le {object:28027} de {zone:1453}. Il forge le {item:18753} avec vos matériaux et 150 pièces d'or.",

	-- Step 8: Grimand Elmore's materials
	-- {npc:1416} Grimand Elmore
	["{npc:1416}'s materials"] = "Matériaux de {npc:1416}",
	-- {item:14047} Runecloth · {area:2255} Everlook · {area:2577} Dire Maul · {item:8836} Arthas' Tears · {skill:182} Herbalism · {area:3197} Chillwind Camp · {item:12360} Arcanite Bar · {item:12359} Thorium Bar · {item:12363} Arcane Crystal
	["{item:14047} drops from humanoids of level 50 and up ({area:2255}'s Bruisers, the Scarlet Crusade in the Plaguelands, the {area:2577} ogres). {item:8836} is a Plaguelands herb ({skill:182} 220), common around {area:3197}. An {item:12360} is an alchemist's transmute from a {item:12359} and an {item:12363}, once every two days per alchemist: ask a guild alchemist early, or buy the bars. The Auction House sells all three."] = "Le {item:14047} tombe sur les humanoïdes de niveau 50 et plus (les Cogneurs d'{area:2255}, la Croisade écarlate dans les Maleterres, les ogres de {area:2577}). Les {item:8836} sont une herbe des Maleterres ({skill:182} 220), courante autour du {area:3197}. Une {item:12360} est une transmutation d'alchimiste à partir d'une {item:12359} et d'un {item:12363}, une fois tous les deux jours par alchimiste : demandez tôt à un alchimiste de votre guilde, ou achetez les barres. L'hôtel des ventes vend les trois.",
	-- {item:14047} Runecloth
	["{item:14047} x40"] = "{item:14047} x40",
	-- {item:8836} Arthas' Tears
	["{item:8836} x10"] = "{item:8836} x10",
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["Arcanite Bars x6: an alchemist, or the Trade District Auction House"] = "Barres d'arcanite x6 : un alchimiste, ou l'hôtel des ventes du quartier commerçant",

	-- Step 9: Stratholme Holy Water
	-- {area:2279} Stratholme · {zone:1423} Eastern Plaguelands
	-- plural, as words: Stratholme Supply Crates = {object:181085} Stratholme Supply Crate
	["{area:2279} is a dungeon for a group of five at 58-60, at the north end of the {zone:1423}. Stratholme Supply Crates along the streets of both halves hold the Holy Water, one to three each; they come back after three minutes. Some crates let out a swarm of plagued rats or maggots: be ready. The main gate (the Scarlet half) needs no key."] = "{area:2279} est un donjon pour un groupe de cinq au niveau 58-60, au nord des {zone:1423}. Les Caisses de fournitures de Stratholme, le long des rues des deux moitiés, contiennent l'eau bénite, une à trois chacune ; elles reviennent au bout de trois minutes. Certaines caisses libèrent un essaim de rats ou d'asticots pestiférés : soyez prêt. La porte principale (la moitié écarlate) ne demande pas de clé.",
	-- plural, as words: Stratholme Supply Crates = {object:181085} Stratholme Supply Crate
	["Stratholme Supply Crates, inside"] = "Caisses de fournitures de Stratholme, à l'intérieur",

	-- Step 10: Grimand Elmore
	-- {npc:1416} Grimand Elmore · {item:18753} Arcanite Barding
	["Bring the materials and 150 gold, taken at the hand-in. {npc:1416} walks to his forge and hands you the {item:18753}."] = "Apportez les matériaux et 150 pièces d'or, prélevées quand vous rendez la quête. {npc:1416} va jusqu'à sa forge et vous remet le {item:18753}.",
	-- {npc:1416} Grimand Elmore
	["{npc:1416}: 150 gold"] = "{npc:1416} : 150 pièces d'or",

	-- Step 11: Lord Grayson Shadowbreaker
	["Lord Grayson keeps the barding for now: you get it back with the next quest."] = "Le seigneur Grayson garde le caparaçon pour l'instant : vous le récupérez avec la quête suivante.",
	-- {npc:928} Lord Grayson Shadowbreaker · {item:18753} Arcanite Barding
	["{npc:928}: the {item:18753}"] = "{npc:928} : {item:18753}",

	-- Step 12: Enriched Manna Biscuits
	-- plural, as words: Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Enriched Manna Biscuits"] = "Biscuits enrichis en manne",
	-- {object:2160} The Argent Dawn · {object:92525} Argent Dawn · {npc:10857} Argent Quartermaster Lightspark · {area:3197} Chillwind Camp · {npc:11536} Quartermaster Miranda Breechlock · {area:2268} Light's Hope Chapel
	-- plural, as words: Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["{object:2160} quartermasters sell Enriched Manna Biscuits, five for 60 silver, once the {object:92525} is Friendly with you: {npc:10857} at {area:3197} or {npc:11536} at {area:2268}. Scourgestones and the Plaguelands quests raise the standing."] = "Les intendants de l'{object:2160} vendent les Biscuits enrichis en manne, cinq pour 60 pièces d'argent, une fois que l'{object:92525} vous est Amicale : {npc:10857} au {area:3197} ou {npc:11536} à la {area:2268}. Les pierres du Fléau et les quêtes des Maleterres font monter la réputation.",
	-- {npc:10857} Argent Quartermaster Lightspark · {area:3197} Chillwind Camp
	-- plural, as words: Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Enriched Manna Biscuits: {npc:10857}, {area:3197}"] = "Biscuits enrichis en manne : {npc:10857}, {area:3197}",

	-- Step 13: Merideth Carlson
	-- {npc:2357} Merideth Carlson · {area:271} Southshore · {quest:7645} Manna-Enriched Horse Feed
	["{npc:2357} breeds horses in {area:271}'s stable. She makes the {quest:7645} from the 20 biscuits and 50 gold, taken at the hand-in."] = "{npc:2357} élève des chevaux dans l'écurie d'{area:271}. Elle prépare le {quest:7645} avec les 20 biscuits et 50 pièces d'or, prélevées quand vous rendez la quête.",

	-- Step 14: Dire Maul: Tendris Warpwood
	-- {area:2577} Dire Maul · {zone:1444} Feralas · {item:18249} Crescent Key · {npc:11489} Tendris Warpwood · {npc:11459} Ironbark Protector · {quest:7643} Ancient Equine Spirit · {item:18753} Arcanite Barding
	["{area:2577} lies in central {zone:1444}. From the gate at the foot of the ruins, walk up through the outer courtyards to the West wing's door at their north end; it needs a {item:18249} (from Pusillin in Dire Maul East) or a rogue's lockpicking. {npc:11489} (level 60 elite) stands at the far end of the West wing's first courtyard. Once attacked he calls every {npc:11459} still alive in the courtyard: kill them first. His death frees the {quest:7643}: talk to it to give it the horse feed and the {item:18753}, and it blesses the barding. A group of five at 60."] = "{area:2577} se trouve au centre de {zone:1444}. Depuis la porte au pied des ruines, montez à travers les cours extérieures jusqu'à la porte de l'aile Ouest, à leur extrémité nord ; elle exige une {item:18249} (de Pusillin, à Haches-Tripes Est) ou le crochetage d'un voleur. {npc:11489} (élite de niveau 60) se tient au fond de la première cour de l'aile Ouest. Une fois attaqué, il appelle chaque {npc:11459} encore en vie dans la cour : tuez-les d'abord. Sa mort libère l'{quest:7643} : parlez-lui pour lui donner la nourriture pour cheval et le {item:18753}, et il bénit le caparaçon. Un groupe de cinq au niveau 60.",
	["Dire Maul West's door"] = "La porte de Haches-Tripes Ouest",
	-- {npc:11489} Tendris Warpwood
	["{npc:11489}, inside the West wing"] = "{npc:11489}, dans l'aile Ouest",

	-- Step 16: Two diamonds
	["Two diamonds"] = "Deux diamants",
	-- {item:12800} Azerothian Diamond · {item:18335} Pristine Black Diamond · {npc:14695} Lord Blackwood
	["An {item:12800} comes from Thorium veins and obsidian, about one vein in a hundred; a {item:18335} drops rarely from elites of level 59 and up (Revanchion and {npc:14695} about one kill in nine and one in a hundred). The Auction House is the usual source of both."] = "Un {item:12800} provient des filons de thorium et de l'obsidienne, environ un filon sur cent ; un {item:18335} tombe rarement sur les élites de niveau 59 et plus (Revanchion et {npc:14695}, environ une victime sur neuf et une sur cent). L'hôtel des ventes est la source habituelle des deux.",

	-- Step 17: Lord Grayson Shadowbreaker
	-- {item:18804} Lord Grayson's Satchel · {item:18746} Divination Scryer · {item:18792} Blessed Arcanite Barding
	["Lord Grayson hands you {item:18804}: open it for the {item:18746} and the {item:18792}. Keep both."] = "Le seigneur Grayson vous remet la {item:18804} : ouvrez-la pour le {item:18746} et le {item:18792}. Gardez les deux.",
	-- {item:18792} Blessed Arcanite Barding
	["{item:18792}, from the satchel"] = "{item:18792}, dans la sacoche",

	-- Step 18: The Great Ossuary
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:13704} Skeleton Key · {object:179746} The Great Ossuary (no name in this language: may be words) · {item:18746} Divination Scryer · {spell:1105} Seal of Wisdom · {npc:14516} Death Knight Darkreaver · {item:18749} Charger's Lost Soul · {item:18792} Blessed Arcanite Barding · {npc:14568} Darkreaver's Fallen Charger
	["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}; the door needs the {item:13704} (The Key to {area:2057}). Clear the {object:179746}, Rattlegore's room in the basement, then use the {item:18746} at its centre. Four waves of spirits come, each ending with an Aspect: players judge them with {spell:1105}, Justice, Righteousness and then Light, which stuns them. {npc:14516} (level 62 elite) comes after the last; he mind-controls players. Loot the {item:18749}, use it inside the Ossuary to redeem it, and give it and the {item:18792} to {npc:14568}. If the group wipes, the gates lock and the scryer is gone: abandon the quest and take it again from Lord Grayson for a new satchel. A group of five at 60. Again Into the {object:179746}, after the mount, lets you fight him again."] = "{area:2057} se trouve sous {area:2298}, la ville insulaire au sud-est des {zone:1422} ; la porte exige la {item:13704} (La clé de {area:2057}). Nettoyez le Grand ossuaire, la salle de Cliquettripes au sous-sol, puis utilisez le {item:18746} en son centre. Quatre vagues d'esprits arrivent, chacune terminée par un Aspect : les joueurs les jugent avec {spell:1105}, Justice, Piété puis Lumière, ce qui les étourdit. {npc:14516} (élite de niveau 62) vient après la dernière ; il contrôle l'esprit des joueurs. Ramassez l'{item:18749}, utilisez-la dans l'ossuaire pour la racheter, et donnez-la avec le {item:18792} au {npc:14568}. Si le groupe est anéanti, les grilles se ferment et le cristal disparaît : abandonnez la quête et reprenez-la auprès du seigneur Grayson pour une nouvelle sacoche. Un groupe de cinq au niveau 60. « De nouveau dans le Grand ossuaire », après la monture, permet de l'affronter de nouveau.",
	-- {item:18749} Charger's Lost Soul · {object:179746} The Great Ossuary (no name in this language: may be words)
	["{item:18749}, inside the {object:179746}"] = "{item:18749}, dans le Grand ossuaire",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["An {item:12800} comes from Thorium veins, a {item:18335} from the elites of the {zone:1422}, both rarely: the Auction House is the usual source."] = "{item:12800} provient des filons de thorium, {item:18335} des élites de {zone:1422}, tous deux rarement : l'hôtel des ventes est la source habituelle.",
	-- ["Arcanite Bars: the Auction House"] = "Barres d'arcanite : l'hôtel des ventes",
	-- ["Bring 150 gold for {npc:1416} along with the materials."] = "Apportez 150 pièces d'or pour {npc:1416} avec les matériaux.",
	-- ["Supply Crates, inside"] = "Caisses de fournitures, à l'intérieur",
	-- ["Terrordale Spirits"] = "Esprits de Val-Terreur ({npc:14564})",
	-- ["The {spell:23214} chain is long: it takes you through {area:2279}, {area:2577} and {area:2057}, and costs about 350 gold in donations on top of the materials. Lord Grayson stands in the Cathedral of Light."] = "La suite de quêtes {spell:23214} est longue : elle vous mène à {area:2279}, {area:2577} et {area:2057}, et coûte environ 350 pièces d'or de dons en plus des matériaux. Le seigneur Grayson se tient dans la cathédrale de la Lumière.",
	-- ["he hands you the {item:18746}"] = "il vous remet {item:18746}",
	-- ["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. Use the {item:18746} in the heart of the {object:179746}'s basement, defeat the spirits it calls and then {npc:14516}, and give his Fallen Charger the {item:18799} and the {item:18792}. All are elite: bring a group. If the attempt fails, Lord Grayson gives you a new scryer through Again Into the {object:179746}."] = "{area:2057} se trouve sous {area:2298}, la ville insulaire au sud-est de {zone:1422}. Utilisez {item:18746} au cœur du sous-sol du Grand ossuaire, vainquez les esprits qu'il appelle puis {npc:14516}, et donnez à son Destrier déchu {item:18799} et {item:18792}. Tous sont élites : venez en groupe. Si la tentative échoue, le seigneur Grayson vous donne un nouveau cristal via la quête Retour au Grand ossuaire.",
	-- ["{area:2279} is a group of five, level 58-60, at the north end of the {zone:1423}. The Supply Crates scattered through the city hold the {item:13180}."] = "{area:2279} se fait en groupe de cinq, niveau 58-60, à l'extrémité nord de {zone:1423}. Les Caisses de fournitures dispersées dans la ville contiennent {item:13180}.",
	-- ["{area:2577} lies in central {zone:1444}; {npc:11489} guards the start of the West wing. Defeat him to free the {quest:7643}, feed it the {item:18775} and hand it the {item:18753} to bless. Bring a group."] = "{area:2577} se trouve au centre de {zone:1444} ; {npc:11489} garde le début de l'aile Ouest. Vainquez-le pour libérer {quest:7643}, donnez-lui {item:18775} et remettez-lui {item:18753} à bénir. Venez en groupe.",
	-- ["{area:2627} lies in the far north-west of the {zone:1423}, by the {zone:1422} border. Use the {item:18752} there to drive out the spirits, then defeat them."] = "{area:2627} se trouve à l'extrême nord-ouest de {zone:1423}, près de la frontière de {zone:1422}. Utilisez-y {item:18752} pour faire sortir les esprits, puis vainquez-les.",
	-- ["{item:14047} drops from humanoids around level 50 and up; {item:8836} is an herb of the Plaguelands and {zone:1448}; Arcanite Bars are an {skill:171} transmute. The Auction House in {zone:1453}'s {object:2096} sells all three, and so do crafters."] = "{item:14047} est lâchée par les humanoïdes à partir du niveau 50 environ ; {item:8836} est une herbe des Maleterres et de {zone:1448} ; les Barres d'arcanite sont une transmutation d'{skill:171}. L'hôtel des ventes de {zone:1453}, dans {object:2096}, vend les trois, tout comme les artisans.",
	-- ["{npc:11406} is in {zone:1455}'s {object:32362}. Bring 150 gold: the censer is yours for a donation."] = "{npc:11406} est à {zone:1455}, dans {object:32362}. Apportez 150 pièces d'or : l'encensoir est à vous contre un don.",
	-- ["{npc:1416} works in {zone:1453}'s {object:28027}."] = "{npc:1416} travaille à {zone:1453}, dans {object:28027}.",
	-- ["{npc:2357} breeds horses in {area:271}. She also wants 50 gold."] = "{npc:2357} élève des chevaux à {area:271}. Elle demande aussi 50 pièces d'or.",
	-- ["{object:2160} quartermasters sell the biscuits in fives once the {object:92525} is Friendly with you: {npc:10857} at {area:3197}, {npc:11536} at {area:2268}, {npc:10856} at the {area:813}."] = "Les intendants de {object:2160} vendent les biscuits par cinq dès que vous êtes Amical avec {object:92525} : {npc:10857} à {area:3197}, {npc:11536} à {area:2268}, {npc:10856} à {area:813}.",
}
