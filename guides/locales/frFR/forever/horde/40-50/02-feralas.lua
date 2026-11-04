-- French (frFR): the guide forever/horde/40-50/02-feralas (forever/horde/40-50/02-feralas.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Prendre un vol pour {object:3202}",
	-- {area:75} Stonard
	["{area:75} flight master"] = "",

	-- Step 3: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zeppelin pour {zone:1454}",

	-- Step 6: Riding at 40
	["Riding at 40"] = "Monte au niveau 40",
	-- {npc:4752} Kildar · {object:172958} Valley of Honor · {npc:3362} Ogunaro Wolfrunner · {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel. Skyborne learn it from {npc:265756} at the {area:17684} in {area:16638} on Zephras Isle, with a Galestrider: the skyboat to the isle leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes. Your race's other mounts are 20 gold each: Collectibles, Mounts · Level 40 has a guide for each."] = "",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}, maître de monte",
	-- {npc:3362} Ogunaro Wolfrunner · {npc:4752} Kildar
	["Wolves: {npc:3362}, beside {npc:4752}."] = "Loups : {npc:3362}, à côté de {npc:4752}.",
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["Riding and Galestriders: {npc:265756}, at the {area:17684} in {area:16638} on Zephras Isle."] = "",

	-- Step 8: Fly to Freewind Post
	-- {area:484} Freewind Post
	["Fly to {area:484}"] = "Prendre un vol pour {area:484}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 10: Gadgetzan
	-- {area:976} Gadgetzan · {area:440} Tanaris
	["{area:976} is the walled goblin town just past the {area:440} border."] = "",

	-- Step 11: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "",

	-- Step 13: Riding at 40
	-- {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village · {npc:3685} Harb Clawhoof · {npc:4752} Kildar · {zone:1454} Orgrimmar
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:3690} in {area:222}, with {npc:3685}'s kodos (20 gold each) beside him. Another race's trainer ({npc:4752} in {zone:1454}) teaches you only once you are Exalted with his city."] = "",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}, maître de monte",
	-- {npc:3685} Harb Clawhoof · {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village
	["Kodos: {npc:3685}, beside {npc:3690} in {area:222}."] = "Kodos : {npc:3685}, à côté de {npc:3690} à {area:222}.",

	-- Step 14: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "",

	-- Step 15: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "",

	-- Step 16: Riding at 40
	-- {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {npc:4752} Kildar · {zone:1454} Orgrimmar
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, with {npc:4731}'s skeletal horses (20 gold each) beside her. Another race's trainer ({npc:4752} in {zone:1454}) teaches you only once you are Exalted with his city."] = "",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}, maîtresse de monte",
	-- {npc:4731} Zachariah Post · {npc:4773} Velma Warnam · {area:159} Brill
	["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "Chevaux squelettes : {npc:4731}, à côté de {npc:4773} à {area:159}.",

	-- Step 18: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "",

	-- Step 20: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful · {zone:1454} Orgrimmar · {area:484} Freewind Post
	["Your trainer is in {area:1638}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly there from {zone:1454}, then on to {area:484}."] = "Votre maître est à {area:1638} : {npc:3033} (druides) sur {area:1639}, {npc:246344} (paladins). Prenez un vol depuis {zone:1454}, puis continuez vers {area:484}.",

	-- Step 24: Ratchet for the Felsteed
	-- {area:392} Ratchet
	["{area:392} for the Felsteed"] = "{area:392} pour le Palefroi corrompu",

	-- Step 25: Back to Gadgetzan
	-- {area:976} Gadgetzan
	["Back to {area:976}"] = "",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 26: Back to Gadgetzan
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 30: Noonshade Ruins: kill these as you meet them
	-- {area:1937} Noonshade Ruins
	["{area:1937}: kill these as you meet them"] = "",
	-- {area:976} Gadgetzan
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: keep ten, five for each of Luglunket's bounties.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "",
	["water pouches in your bags"] = "Outres de Bat-le-désert dans vos sacs",

	-- Step 32: Steamwheedle Port
	["Ride north-east to the goblin harbour on the coast."] = "Allez au nord-est jusqu'au port gobelin sur la côte.",
	-- {npc:7882} Security Chief Bilgewhizzle
	["{npc:7882}, inside"] = "",
	-- {npc:7881} Stoley
	["{npc:7881}, inside"] = "",

	-- Step 33: Lost Rigger Cove: kill these as you meet them
	-- {area:1336} Lost Rigger Cove
	["{area:1336}: kill these as you meet them"] = "",
	-- {npc:7883} Andre Firebeard
	["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883}, and many more pirates from the town join the fight once it starts."] = "",
	["Upstairs"] = "",

	-- Step 34: Waterspring Field: kill these as you meet them
	-- {area:985} Waterspring Field
	["{area:985}: kill these as you meet them"] = "",
	-- {area:976} Gadgetzan · {npc:7847} Caliph Scorpidsting
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["The shadow mages, rogues and assassins camp south-east of {area:976}.\nSouth-east of Gadgetzan the Wastewander bandits camp in the dunes; {npc:7847} stands in the eastern camp.\nCareful: Wastewander Rogues keep Sneak up while out of combat, so hidden rogues can join a fight you start at a camp.\nCareful: Two stealthed Wastewander Rogues travel with him wherever he goes. At his spawn camp, two shadowmages and their minions are close enough to join a fight with him. Out by the towers you can fight him without them."] = "",

	-- Step 38: Camp Mojache
	-- {npc:7777} Rok Orhan · {area:1099} Camp Mojache
	["{npc:7777} walks around {area:1099}: look inside the circle on the map"] = "",
	-- {npc:8115} Witch Doctor Uzer'i · {zone:1454} Orgrimmar
	["{npc:8115}: for {zone:1454}, around level 45"] = "{npc:8115} : pour {zone:1454}, vers le niveau 45",
	-- {npc:7854} Jangdor Swiftstrider
	["{npc:7854}, inside"] = "",

	-- Step 39: Gordunni Outpost
	["North of the gnolls the ogres hold a hilltop outpost; pull the ogre-magi to you. The cobalt is in the dirt mounds around the outpost, and the scroll lies on the ground inside it."] = "Au nord des gnolls, les ogres tiennent un avant-poste sur une colline ; attirez les Ogres-mages Gordunni vers vous. Le Cobalt Gordunni est dans les tas de terre autour de l'avant-poste, et le Parchemin Gordunni est par terre à l'intérieur.",

	-- Step 40: Woodpaw north camp
	["Woodpaw north camp"] = "Camp Griffebois du nord",
	["The Woodpaw gnolls camp in the hills just north-west of Mojache; any of them can drop a mane.\nCareful: Every Woodpaw gnoll except the Alpha runs off for help at 15% health, which can pull more gnolls into the fight."] = "",

	-- Step 41: Camp Mojache
	-- {quest:2863} Alpha Strike
	["{quest:2863}: one hour from now"] = "{quest:2863} : dans une heure",

	-- Step 42: Feralas: kill these as you meet them
	-- {area:357} Feralas
	["{area:357}: kill these as you meet them"] = "",
	["The sprite darters flit over the grove just west of Mojache; nearly every one drops a wing. The Woodpaw alphas lead the camps south-west of it: kill them within the hour.\nCareful: Most Alphas sit in small tent camps with 2-4 other gnolls that join the fight, and other gnolls patrol between the camps."] = "",

	-- Step 44: Grimtotem camp
	["Grimtotem camp"] = "Camp du Totem sinistre",
	["The Grimtotem tauren camp beside the sprite darters' grove; raiders, naturalists and shamans all carry horns."] = "Les taurens du Totem sinistre campent à côté du bosquet des Fées fléchetteuses ; Ecumeurs, Naturalistes et Chamans portent tous des Cornes de Totem sinistre.",

	-- Step 45: Woodpaw battle map
	["Woodpaw battle map"] = "Plan de bataille des Griffebois",
	["The battle map lies in the Woodpaw camp south of Mojache."] = "Le Plan de bataille des Griffebois se trouve dans le camp Griffebois au sud de Mojache.",

	-- Step 46: Ruins of Isildien: kill these as you meet them
	-- {area:2522} Ruins of Isildien
	["{area:2522}: kill these as you meet them"] = "",
	-- {area:1105} Feral Scar Vale
	["Ride south-west to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb."] = "Allez au sud-ouest jusqu'aux ruines ogres sous {area:1105}. Chamans, Démonistes et Marteleurs Gordunni les peuplent ; les Seigneurs-mages Gordunni, au bout sud, portent l'Orbe Gordunni.",
	-- {npc:5234} Gordunni Mauler · {area:2522} Ruins of Isildien
	["{npc:5234} walks around {area:2522}: look inside the circle on the map"] = "",

	-- Step 47: Hearth to Camp Mojache
	-- {area:1099} Camp Mojache
	["Hearth to {area:1099}"] = "Pierre de foyer vers {area:1099}",

	-- Step 48: Camp Mojache
	-- {zone:1454} Orgrimmar
	["for {zone:1454}, around level 45"] = "pour {zone:1454}, vers le niveau 45",

	-- Step 49: The Writhing Deep
	-- {quest:7731} Stinglasher
	["The Zukk'ash hive burrows into the hills south-east of the camp; {quest:7731} waits in its deepest chamber."] = "La ruche des Zukk'ash s'enfonce dans les collines au sud-est du camp ; {quest:7731} attend dans sa chambre la plus profonde.",

	-- Step 50: Camp Mojache
	-- {npc:7875} Hadoken Swiftstrider · {npc:7010} Zilzibin Drumlore · {zone:1454} Orgrimmar
	["{npc:7875}: for {npc:7010} in {zone:1454}, around level 50"] = "",

	-- Step 52: The Forgotten Coast
	-- plural, as words: Coast Crawl Deepseers = {npc:5328} Coast Crawl Deepseer
	["Keep riding west to the coast. The Coast Crawl Deepseers and Snapclaws on the beaches drop OOX-22/FE's distress beacon about one kill in forty: if one drops, use it to start the quest."] = "Continuez à l'ouest jusqu'à la côte. Les Enfouisseurs côtiers et les Claque-pinces côtiers des plages laissent tomber la Balise de détresse OOX-22/FE environ une fois sur quarante : si vous l'obtenez, utilisez-la pour commencer la quête.",

	-- Step 54: Homing Robot OOX-22/FE
	-- {area:1105} Feral Scar Vale · {area:1108} The Forgotten Coast · {area:35} Booty Bay
	["Only with the distress beacon: the robot sits in a small cave on the north side of {area:1105}. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit.\nCareful: Three ambushes spawn during the escort, and the robot warns you before each one. The first is 3 yetis, just after the robot leaves the cave and climbs toward the road. The second is 3 gorillas, on the path that runs along the cliff. The third is about 4 gnolls, one of them a caster, where the route turns off toward the dock."] = "",

	-- Step 56: Fly to Orgrimmar
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "",

	-- Step 57: Orgrimmar
	-- {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {object:172960} Cleft of Shadow · {object:172961} Valley of Spirits
	["Fly to {zone:1454}. The Droffers brothers run their shop in the Drag.\n{object:172958}, then the {object:172960} and the {object:172961}."] = "",
	-- {zone:1425} Hinterlands
	["for the {zone:1425}, around level 48"] = "pour {zone:1425}, vers le niveau 48",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Eastern Wastewander camps"] = "Camps Bat-le-désert de l'est",
	-- ["Fly to {area:1637}. The Droffers brothers run their shop in the Drag."] = "Volez jusqu'à {area:1637}. Les frères Droffers tiennent leur boutique dans la Herse.",
	-- ["Fly to {area:1637}. The Droffers brothers run their shop in the {object:172959}."] = "Prenez un vol pour {area:1637}. Dran et Malton Droffers tiennent leur boutique dans {object:172959}.",
	-- ["Fly to {area:484}, ride down the lift east of the post and across the salt flats, then south into {zone:1446}."] = "Prenez un vol pour {area:484}, descendez par l'ascenseur à l'est du poste et traversez les Salines, puis allez au sud jusqu'à {zone:1446}.",
	-- ["Fly to {area:484}, then ride west through the canyons past {area:2237}; the road climbs into the {zone:1444} jungle and on to {area:1099}."] = "Prenez un vol pour {area:484}, puis allez à l'ouest par les canyons après {area:2237} ; la route monte dans la jungle de {zone:1444} jusqu'à {area:1099}.",
	-- ["Fly to {area:75}"] = "Prendre un vol pour {area:75}",
	-- ["Galestriders: {npc:265756}, in {area:16638} on Zephras Isle."] = "Galestriders : {npc:265756}, à {area:16638} sur l'Île de Zéphras.",
	-- ["Only with the distress beacon: the robot sits in a small cave on the north side of {area:1105}. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit."] = "Seulement avec la balise de détresse : le robot se trouve dans une petite grotte au nord de {area:1105}. Escortez-le jusqu'au quai de la {area:1108} ; des yétis et des gorilles vous tendent des embuscades en chemin. Sa récompense vous attend à {area:35}, lors d'une visite ultérieure.",
	-- ["Raptors: Zjolnir, beside {npc:7953} in {area:367}."] = "Raptors : Zjolnir, à côté de {npc:7953} à {area:367}.",
	-- ["Ride back north-west from {area:1978} to {area:75} and fly to {object:3202}."] = "Depuis {area:1978}, retournez au nord-ouest jusqu'à {area:75} et prenez un vol pour {object:3202}.",
	-- ["Ride back west to {area:976}."] = "Retournez à l'ouest jusqu'à {area:976}.",
	-- ["Ride west into the middle of {zone:1444}. Kill a {npc:5308}, use {item:10699} on its body and kill the spirit that rises."] = "Allez à l'ouest jusqu'au centre de {zone:1444}. Tuez un {npc:5308}, utilisez {item:10699} sur son cadavre et tuez l'esprit qui s'en élève.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:3690} in {area:222}, with {npc:3685}'s kodos (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "La monte demande le niveau 40 et coûte 100 pièces d'or ; l'apprendre vous donne une monture. En Classic, chaque race l'apprend auprès du maître de sa race : le vôtre est {npc:3690} à {area:222}, avec les kodos de {npc:3685} (20 pièces d'or chacun) à côté de lui. Forever permet peut-être à toute race d'apprendre auprès de n'importe quel maître de monte (non confirmé) : essayez d'abord {npc:4752}, dans {object:172958} de {zone:1454}, car c'est le plus proche, et passez cette étape s'il vous l'enseigne.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, with {npc:4731}'s skeletal horses (20 gold each) beside her. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "La monte demande le niveau 40 et coûte 100 pièces d'or ; l'apprendre vous donne une monture. En Classic, chaque race l'apprend auprès du maître de sa race : le vôtre est {npc:4773} à {area:159}, avec les chevaux squelettes de {npc:4731} (20 pièces d'or chacun) à côté d'elle. Forever permet peut-être à toute race d'apprendre auprès de n'importe quel maître de monte (non confirmé) : essayez d'abord {npc:4752}, dans {object:172958} de {zone:1454}, car c'est le plus proche, et passez cette étape s'il vous l'enseigne.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:7953} in {area:367} on the {zone:1411} coast, with Zjolnir's raptors (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "La monte demande le niveau 40 et coûte 100 pièces d'or ; l'apprendre vous donne une monture. En Classic, chaque race l'apprend auprès du maître de sa race : le vôtre est {npc:7953} à {area:367}, sur la côte de {zone:1411}, avec les raptors de Zjolnir (20 pièces d'or chacun) à côté de lui. Forever permet peut-être à toute race d'apprendre auprès de n'importe quel maître de monte (non confirmé) : essayez d'abord {npc:4752}, dans {object:172958} de {zone:1454}, car c'est le plus proche, et passez cette étape s'il vous l'enseigne.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel; no Skyborne riding trainer is known, so Skyborne try {npc:4752} too. Your race's other mounts are 20 gold each: Collectibles, Mounts · Level 40 has a guide for each."] = "La monte demande le niveau 40 et coûte 100 pièces d'or ; l'apprendre vous donne une monture. {npc:4752} l'enseigne aux orcs dans {object:172958}, près du chenil de {npc:3362} ; aucun maître de monte skyborne n'est connu, les Éolides essaient donc aussi {npc:4752}. Les autres montures de votre race coûtent 20 pièces d'or chacune : Objets de collection, Montures · Niveau 40 a un guide pour chacune.",
	-- ["Rogue Vale screechers"] = "Hurleurs des vallées insoumis",
	-- ["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often."] = "Plus au sud sur la côte, les pirates des Mers du sud tiennent la crique. {npc:7883} et la cargaison volée sont sur les quais, tout au fond. Tout pirate peut laisser tomber un Chapeau de pirate des Mers du sud, les Kidnappeurs des mers du Sud le plus souvent.",
	-- ["Southern Gordunni ruins"] = "Ruines Gordunni du sud",
	-- ["Southern Wastewander camps"] = "Camps Bat-le-désert du sud",
	-- ["Sprite darters and Woodpaw alphas"] = "Fées fléchetteuses et Alphas Griffebois",
	-- ["The Woodpaw gnolls camp in the hills just north-west of Mojache; any of them can drop a mane."] = "Les gnolls Griffebois campent dans les collines juste au nord-ouest de Mojache ; chacun peut laisser tomber une Crinière de gnoll Griffebois.",
	-- ["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: keep ten, five for each of Luglunket's bounties."] = "Les Bandits et Larrons Bat-le-désert campent dans les dunes à l'est de {area:976}. Chaque Bat-le-désert peut porter une Outre de Bat-le-désert : gardez-en dix, cinq pour chaque prime de l'Opérateur du robinet Luglunket.",
	-- ["The shadow mages, rogues and assassins camp south-east of {area:976}."] = "Les Mages de l'ombre, Voleurs et Assassins Bat-le-désert campent au sud-est de {area:976}.",
	-- ["The sprite darters flit over the grove just west of Mojache; nearly every one drops a wing. The Woodpaw alphas lead the camps south-west of it: kill them within the hour."] = "Les Fées fléchetteuses voltigent au-dessus du bosquet juste à l'ouest de Mojache ; presque toutes laissent tomber une aile. Les Alphas Griffebois dirigent les camps au sud-ouest : tuez-les dans l'heure.",
	-- ["The {object:3202} zeppelin leaves from the tower just north-east of {zone:1454}'s main gate."] = "Le zeppelin pour {object:3202} part de la tour juste au nord-est de la grande porte de {zone:1454}.",
	-- ["The {zone:1454} zeppelin leaves from the tower beside {object:3202}; it lands just outside {zone:1454}'s main gate."] = "Le zeppelin pour {zone:1454} part de la tour à côté de {object:3202} ; il arrive juste devant la grande porte de {zone:1454}.",
	-- ["Thysta, the flight master, stands just east of the zeppelin tower. Fly to {area:75}: the next guide starts there."] = "Thysta, la maîtresse de vol, se tient juste à l'est de la tour des zeppelins. Prenez un vol pour {area:75} : le guide suivant commence là.",
	-- ["Zeppelin to {object:3202}"] = "Zeppelin pour {object:3202}",
	-- ["Zeppelin tower"] = "Tour des zeppelins",
	-- ["for {area:35}, around level 50"] = "pour {area:35}, vers le niveau 50",
	-- ["the {object:150075} in the square"] = "l'{object:150075} sur la place",
	-- ["{area:976} is the walled goblin town just past the {zone:1446} border."] = "{area:976} est la ville gobeline fortifiée juste après la frontière de {zone:1446}.",
	-- ["{npc:7953}, riding trainer"] = "{npc:7953}, maître de monte",
	-- ["{npc:8579}: the screechers live in {zone:1444}"] = "{npc:8579} : les hurleurs vivent à {zone:1444}",
}
