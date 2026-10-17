-- French (frFR): the guide forever/horde/40-50/02-feralas (forever/horde/40-50/02-feralas.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Prendre un vol pour {object:3202}",
	-- {area:1978} Misty Reed Post · {area:75} Stonard · {object:3202} Grom'gol (no name in this language: may be words)
	["Ride back north-west from {area:1978} to {area:75} and fly to {object:3202}."] = "Depuis {area:1978}, retournez au nord-ouest jusqu'à {area:75} et prenez un vol pour {object:3202}.",

	-- Step 2: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zeppelin pour {zone:1454}",
	-- {zone:1454} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words)
	["The {zone:1454} zeppelin leaves from the tower beside {object:3202}; it lands just outside {zone:1454}'s main gate."] = "Le zeppelin pour {zone:1454} part de la tour à côté de {object:3202} ; il arrive juste devant la grande porte de {zone:1454}.",
	["Zeppelin tower"] = "Tour des zeppelins",

	-- Step 4: Riding at 40
	["Riding at 40"] = "Monte au niveau 40",
	-- {npc:4752} Kildar · {object:172958} Valley of Honor · {npc:3362} Ogunaro Wolfrunner
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel; no Skyborne riding trainer is known, so Skyborne try {npc:4752} too. Your race's other mounts are 20 gold each: Collectibles, Mounts · Level 40 has a guide for each."] = "La monte demande le niveau 40 et coûte 100 pièces d'or ; l'apprendre vous donne une monture. {npc:4752} l'enseigne aux orcs dans {object:172958}, près du chenil de {npc:3362} ; aucun maître de monte skyborne n'est connu, les Éolides essaient donc aussi {npc:4752}. Les autres montures de votre race coûtent 20 pièces d'or chacune : Objets de collection, Montures · Niveau 40 a un guide pour chacune.",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}, maître de monte",
	-- {npc:3362} Ogunaro Wolfrunner · {npc:4752} Kildar
	["Wolves: {npc:3362}, beside {npc:4752}."] = "Loups : {npc:3362}, à côté de {npc:4752}.",
	-- {npc:265756} Genn Fairweather · {area:16638} Valanaar
	["Galestriders: {npc:265756}, in {area:16638} on Zephras Isle."] = "Galestriders : {npc:265756}, à {area:16638} sur l'Île de Zéphras.",

	-- Step 5: Riding at 40
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village · {zone:1411} Durotar · {npc:4752} Kildar · {zone:1454} Orgrimmar · {object:172958} Valley of Honor
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:7953} in {area:367} on the {zone:1411} coast, with Zjolnir's raptors (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "La monte demande le niveau 40 et coûte 100 pièces d'or ; l'apprendre vous donne une monture. En Classic, chaque race l'apprend auprès du maître de sa race : le vôtre est {npc:7953} à {area:367}, sur la côte de {zone:1411}, avec les raptors de Zjolnir (20 pièces d'or chacun) à côté de lui. Forever permet peut-être à toute race d'apprendre auprès de n'importe quel maître de monte (non confirmé) : essayez d'abord {npc:4752}, dans {object:172958} de {zone:1454}, car c'est le plus proche, et passez cette étape s'il vous l'enseigne.",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}, maître de monte",
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village
	["Raptors: Zjolnir, beside {npc:7953} in {area:367}."] = "Raptors : Zjolnir, à côté de {npc:7953} à {area:367}.",

	-- Step 6: Riding at 40
	-- {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village · {npc:3685} Harb Clawhoof · {npc:4752} Kildar · {zone:1454} Orgrimmar · {object:172958} Valley of Honor
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:3690} in {area:222}, with {npc:3685}'s kodos (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "La monte demande le niveau 40 et coûte 100 pièces d'or ; l'apprendre vous donne une monture. En Classic, chaque race l'apprend auprès du maître de sa race : le vôtre est {npc:3690} à {area:222}, avec les kodos de {npc:3685} (20 pièces d'or chacun) à côté de lui. Forever permet peut-être à toute race d'apprendre auprès de n'importe quel maître de monte (non confirmé) : essayez d'abord {npc:4752}, dans {object:172958} de {zone:1454}, car c'est le plus proche, et passez cette étape s'il vous l'enseigne.",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}, maître de monte",
	-- {npc:3685} Harb Clawhoof · {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village
	["Kodos: {npc:3685}, beside {npc:3690} in {area:222}."] = "Kodos : {npc:3685}, à côté de {npc:3690} à {area:222}.",

	-- Step 7: Riding at 40
	-- {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {npc:4752} Kildar · {zone:1454} Orgrimmar · {object:172958} Valley of Honor
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, with {npc:4731}'s skeletal horses (20 gold each) beside her. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "La monte demande le niveau 40 et coûte 100 pièces d'or ; l'apprendre vous donne une monture. En Classic, chaque race l'apprend auprès du maître de sa race : le vôtre est {npc:4773} à {area:159}, avec les chevaux squelettes de {npc:4731} (20 pièces d'or chacun) à côté d'elle. Forever permet peut-être à toute race d'apprendre auprès de n'importe quel maître de monte (non confirmé) : essayez d'abord {npc:4752}, dans {object:172958} de {zone:1454}, car c'est le plus proche, et passez cette étape s'il vous l'enseigne.",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}, maîtresse de monte",
	-- {npc:4731} Zachariah Post · {npc:4773} Velma Warnam · {area:159} Brill
	["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "Chevaux squelettes : {npc:4731}, à côté de {npc:4773} à {area:159}.",

	-- Step 8: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful · {zone:1454} Orgrimmar · {area:484} Freewind Post
	["Your trainer is in {area:1638}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly there from {zone:1454}, then on to {area:484}."] = "Votre maître est à {area:1638} : {npc:3033} (druides) sur {area:1639}, {npc:246344} (paladins). Prenez un vol depuis {zone:1454}, puis continuez vers {area:484}.",

	-- Step 9: Ratchet for the Felsteed
	-- {area:392} Ratchet
	["{area:392} for the Felsteed"] = "{area:392} pour le Palefroi corrompu",

	-- Step 10: Fly to Freewind Post
	-- {area:484} Freewind Post
	["Fly to {area:484}"] = "Prendre un vol pour {area:484}",
	-- {area:484} Freewind Post · {zone:1446} Tanaris
	["Fly to {area:484}, ride down the lift east of the post and across the salt flats, then south into {zone:1446}."] = "Prenez un vol pour {area:484}, descendez par l'ascenseur à l'est du poste et traversez les Salines, puis allez au sud jusqu'à {zone:1446}.",

	-- Step 11: Gadgetzan
	-- {area:976} Gadgetzan · {zone:1446} Tanaris
	["{area:976} is the walled goblin town just past the {zone:1446} border."] = "{area:976} est la ville gobeline fortifiée juste après la frontière de {zone:1446}.",
	-- {object:150075} Wanted Poster
	["the {object:150075} in the square"] = "l'{object:150075} sur la place",

	-- Step 12: Eastern Wastewander camps
	["Eastern Wastewander camps"] = "Camps Bat-le-désert de l'est",
	-- {area:976} Gadgetzan
	["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: keep ten, five for each of Luglunket's bounties."] = "Les Bandits et Larrons Bat-le-désert campent dans les dunes à l'est de {area:976}. Chaque Bat-le-désert peut porter une Outre de Bat-le-désert : gardez-en dix, cinq pour chaque prime de l'Opérateur du robinet Luglunket.",
	["water pouches in your bags"] = "Outres de Bat-le-désert dans vos sacs",

	-- Step 14: Southern Wastewander camps
	["Southern Wastewander camps"] = "Camps Bat-le-désert du sud",
	-- {area:976} Gadgetzan
	["The shadow mages, rogues and assassins camp south-east of {area:976}."] = "Les Mages de l'ombre, Voleurs et Assassins Bat-le-désert campent au sud-est de {area:976}.",

	-- Step 15: Steamwheedle Port
	["Ride north-east to the goblin harbour on the coast."] = "Allez au nord-est jusqu'au port gobelin sur la côte.",
	-- {npc:8579} Yeh'kinya · {zone:1444} Feralas
	["{npc:8579}: the screechers live in {zone:1444}"] = "{npc:8579} : les hurleurs vivent à {zone:1444}",

	-- Step 16: Lost Rigger Cove
	-- {npc:7883} Andre Firebeard
	["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often."] = "Plus au sud sur la côte, les pirates des Mers du sud tiennent la crique. {npc:7883} et la cargaison volée sont sur les quais, tout au fond. Tout pirate peut laisser tomber un Chapeau de pirate des Mers du sud, les Kidnappeurs des mers du Sud le plus souvent.",

	-- Step 17: Steamwheedle Port
	-- {area:35} Booty Bay
	["for {area:35}, around level 50"] = "pour {area:35}, vers le niveau 50",

	-- Step 18: Gadgetzan
	-- {area:976} Gadgetzan
	["Ride back west to {area:976}."] = "Retournez à l'ouest jusqu'à {area:976}.",

	-- Step 19: Fly to Freewind Post
	-- {area:484} Freewind Post · {area:2237} Whitereach Post · {zone:1444} Feralas · {area:1099} Camp Mojache
	["Fly to {area:484}, then ride west through the canyons past {area:2237}; the road climbs into the {zone:1444} jungle and on to {area:1099}."] = "Prenez un vol pour {area:484}, puis allez à l'ouest par les canyons après {area:2237} ; la route monte dans la jungle de {zone:1444} jusqu'à {area:1099}.",

	-- Step 20: Camp Mojache
	-- {npc:8115} Witch Doctor Uzer'i · {zone:1454} Orgrimmar
	["{npc:8115}: for {zone:1454}, around level 45"] = "{npc:8115} : pour {zone:1454}, vers le niveau 45",

	-- Step 21: Woodpaw north camp
	["Woodpaw north camp"] = "Camp Griffebois du nord",
	["The Woodpaw gnolls camp in the hills just north-west of Mojache; any of them can drop a mane."] = "Les gnolls Griffebois campent dans les collines juste au nord-ouest de Mojache ; chacun peut laisser tomber une Crinière de gnoll Griffebois.",

	-- Step 22: Gordunni Outpost
	["North of the gnolls the ogres hold a hilltop outpost; pull the ogre-magi to you. The cobalt is in the dirt mounds around the outpost, and the scroll lies on the ground inside it."] = "Au nord des gnolls, les ogres tiennent un avant-poste sur une colline ; attirez les Ogres-mages Gordunni vers vous. Le Cobalt Gordunni est dans les tas de terre autour de l'avant-poste, et le Parchemin Gordunni est par terre à l'intérieur.",

	-- Step 23: Camp Mojache
	-- {quest:2863} Alpha Strike
	["{quest:2863}: one hour from now"] = "{quest:2863} : dans une heure",

	-- Step 24: Sprite darters and Woodpaw alphas
	["Sprite darters and Woodpaw alphas"] = "Fées fléchetteuses et Alphas Griffebois",
	["The sprite darters flit over the grove just west of Mojache; nearly every one drops a wing. The Woodpaw alphas lead the camps south-west of it: kill them within the hour."] = "Les Fées fléchetteuses voltigent au-dessus du bosquet juste à l'ouest de Mojache ; presque toutes laissent tomber une aile. Les Alphas Griffebois dirigent les camps au sud-ouest : tuez-les dans l'heure.",

	-- Step 26: Grimtotem camp
	["Grimtotem camp"] = "Camp du Totem sinistre",
	["The Grimtotem tauren camp beside the sprite darters' grove; raiders, naturalists and shamans all carry horns."] = "Les taurens du Totem sinistre campent à côté du bosquet des Fées fléchetteuses ; Ecumeurs, Naturalistes et Chamans portent tous des Cornes de Totem sinistre.",

	-- Step 27: Woodpaw battle map
	["Woodpaw battle map"] = "Plan de bataille des Griffebois",
	["The battle map lies in the Woodpaw camp south of Mojache."] = "Le Plan de bataille des Griffebois se trouve dans le camp Griffebois au sud de Mojache.",

	-- Step 28: Southern Gordunni ruins
	["Southern Gordunni ruins"] = "Ruines Gordunni du sud",
	-- {area:1105} Feral Scar Vale
	["Ride south-west to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb."] = "Allez au sud-ouest jusqu'aux ruines ogres sous {area:1105}. Chamans, Démonistes et Marteleurs Gordunni les peuplent ; les Seigneurs-mages Gordunni, au bout sud, portent l'Orbe Gordunni.",

	-- Step 29: Camp Mojache
	-- {zone:1454} Orgrimmar
	["for {zone:1454}, around level 45"] = "pour {zone:1454}, vers le niveau 45",

	-- Step 30: The Writhing Deep
	-- {quest:7731} Stinglasher
	["The Zukk'ash hive burrows into the hills south-east of the camp; {quest:7731} waits in its deepest chamber."] = "La ruche des Zukk'ash s'enfonce dans les collines au sud-est du camp ; {quest:7731} attend dans sa chambre la plus profonde.",

	-- Step 32: Rogue Vale screechers
	["Rogue Vale screechers"] = "Hurleurs des vallées insoumis",
	-- {zone:1444} Feralas · {npc:5308} Rogue Vale Screecher · {item:10699} Yeh'kinya's Bramble
	["Ride west into the middle of {zone:1444}. Kill a {npc:5308}, use {item:10699} on its body and kill the spirit that rises."] = "Allez à l'ouest jusqu'au centre de {zone:1444}. Tuez un {npc:5308}, utilisez {item:10699} sur son cadavre et tuez l'esprit qui s'en élève.",

	-- Step 33: The Forgotten Coast
	-- plural, as words: Coast Crawl Deepseers = {npc:5328} Coast Crawl Deepseer
	["Keep riding west to the coast. The Coast Crawl Deepseers and Snapclaws on the beaches drop OOX-22/FE's distress beacon about one kill in forty: if one drops, use it to start the quest."] = "Continuez à l'ouest jusqu'à la côte. Les Enfouisseurs côtiers et les Claque-pinces côtiers des plages laissent tomber la Balise de détresse OOX-22/FE environ une fois sur quarante : si vous l'obtenez, utilisez-la pour commencer la quête.",

	-- Step 34: Homing Robot OOX-22/FE
	-- {area:1105} Feral Scar Vale · {area:1108} The Forgotten Coast · {area:35} Booty Bay
	["Only with the distress beacon: the robot sits in a small cave on the north side of {area:1105}. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit."] = "Seulement avec la balise de détresse : le robot se trouve dans une petite grotte au nord de {area:1105}. Escortez-le jusqu'au quai de la {area:1108} ; des yétis et des gorilles vous tendent des embuscades en chemin. Sa récompense vous attend à {area:35}, lors d'une visite ultérieure.",

	-- Step 35: Hearth to Camp Mojache
	-- {area:1099} Camp Mojache
	["Hearth to {area:1099}"] = "Pierre de foyer vers {area:1099}",

	-- Step 36: Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}. The Droffers brothers run their shop in the Drag."] = "Volez jusqu'à {area:1637}. Les frères Droffers tiennent leur boutique dans la Herse.",
	-- {zone:1425} Hinterlands
	["for the {zone:1425}, around level 48"] = "pour {zone:1425}, vers le niveau 48",

	-- Step 37: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Zeppelin to {object:3202}"] = "Zeppelin pour {object:3202}",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {zone:1454} Orgrimmar
	["The {object:3202} zeppelin leaves from the tower just north-east of {zone:1454}'s main gate."] = "Le zeppelin pour {object:3202} part de la tour juste au nord-est de la grande porte de {zone:1454}.",

	-- Step 38: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "Prendre un vol pour {area:75}",
	-- {area:75} Stonard
	["Thysta, the flight master, stands just east of the zeppelin tower. Fly to {area:75}: the next guide starts there."] = "Thysta, la maîtresse de vol, se tient juste à l'est de la tour des zeppelins. Prenez un vol pour {area:75} : le guide suivant commence là.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly to {area:1637}. The Droffers brothers run their shop in the {object:172959}."] = "Prenez un vol pour {area:1637}. Dran et Malton Droffers tiennent leur boutique dans {object:172959}.",
	-- ["Only with the distress beacon: the robot sits in a small cave on the north side of {area:1105}. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit."] = "Seulement avec la balise de détresse : le robot se trouve dans une petite grotte au nord de {area:1105}. Escortez-le jusqu'au quai de {area:1108} ; des yétis et des gorilles vous tendent des embuscades en chemin. Sa récompense vous attend à {area:35}, lors d'une visite ultérieure.",
}
