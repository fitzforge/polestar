-- French (frFR): the guide forever/class/shaman/call-of-air-alliance (forever/class/shaman/call-of-air-alliance.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94789} Call of Air
	["{quest:94789} and the Tempest's Weapons (Alliance)"] = "{quest:94789} et les armes de la Tempête (Alliance)",
	-- {item:5178} Air Totem
	["The {item:5178} that lets you place air totems, then a weapon of your choice at 40."] = "Le {item:5178} qui vous permet de poser des totems d'air, puis une arme de votre choix au niveau 40.",

	-- Step 1: Eldrun Stormbreaker
	-- {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge · {npc:259023} Veyric Thunderhame · {zone:1417} Arathi Highlands · {spell:10596} Nature Resistance · {item:5178} Air Totem
	["At 30 {npc:258098}, the shaman trainer in {zone:1455}, sends you to {npc:259023} in {zone:1417}. Your level 30 air totems (Grounding, {spell:10596}) need the {item:5178} he gives."] = "Au niveau 30, {npc:258098}, le maître des chamans de {zone:1455}, vous envoie voir {npc:259023} dans les {zone:1417}. Vos totems d'air du niveau 30 (Glèbe, {spell:10596}) ont besoin du {item:5178} qu'il vous donne.",

	-- Step 2: Veyric Thunderhame
	-- {npc:259023} Veyric Thunderhame · {area:321} Hammerfall · {area:320} Refuge Pointe
	["{npc:259023} camps in the hills just west of {area:321}, the Horde town in the north-east of Arathi: mind its guards. Fly to {area:320} and head north-east."] = "{npc:259023} campe dans les collines juste à l'ouest de {area:321}, la ville de la Horde au nord-est d'Arathi : méfiez-vous de ses gardes. Volez jusqu'au {area:320} et dirigez-vous vers le nord-est.",
	-- {npc:259023} Veyric Thunderhame · {item:5178} Air Totem
	["{npc:259023}: your {item:5178}"] = "{npc:259023} : votre {item:5178}",

	-- Step 3: Charlga Razorflank
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {npc:4421} Charlga Razorflank · {spell:8292} Chain Bolt · {spell:139} Renew · {item:274463} Tattered Note
	["{area:1717} is a five-player dungeon at the southern edge of the {zone:1413} (the arrow points at its entrance); {npc:4421} (level 33 elite) is its last boss. She casts {spell:8292}, {spell:139} on her allies and Purity; the {item:274463} drops only from her."] = "{area:1717} est un donjon à cinq joueurs à la limite sud des {zone:1413} (la flèche pointe vers son entrée) ; {npc:4421} (élite de niveau 33) en est le dernier boss. Elle lance {spell:8292}, {spell:139} sur ses alliés et Pureté ; la {item:274463} ne tombe que sur elle.",
	-- {item:274463} Tattered Note · {npc:4421} Charlga Razorflank
	["{item:274463}, from {npc:4421}"] = "{item:274463}, sur {npc:4421}",

	-- Step 5: Twisted Fire Totems
	-- plural, as words: Twisted Fire Totems = {item:274044} Twisted Fire Totem
	["Twisted Fire Totems"] = "Totems de feu tordus",
	-- {area:338} Angor Fortress · {zone:1418} Badlands · {npc:3560} Healing Ward
	-- plural, as words: Twisted Fire Totems = {item:274044} Twisted Fire Totem · Fire Nova Totems = {npc:5879} Fire Nova Totem
	["Five Twisted Fire Totems. The Stonevault troggs (Skullthumpers, Bonesnappers and Shamans, level 37-41) south of {area:338} in the {zone:1418} carry them; the Shamans drop Fire Nova Totems and a {npc:3560}, the Bonesnappers run for help when hurt. Respawn about five minutes."] = "Cinq Totems de feu tordus. Les troggs Cavepierre (Skullthumpers, Bonesnappers et Chamans, niveau 37-41) au sud de la {area:338}, dans les {zone:1418}, en portent ; les Chamans posent des Totems Nova de feu et un {npc:3560}, les Bonesnappers fuient chercher de l'aide quand ils sont blessés. Réapparition en cinq minutes environ.",

	-- Step 6: Twisted Earth Totems
	-- plural, as words: Twisted Earth Totems = {item:274045} Twisted Earth Totem
	["Twisted Earth Totems"] = "Totems de terre tordus",
	-- {area:75} Stonard · {zone:1435} Swamp of Sorrows
	-- plural, as words: Twisted Earth Totems = {item:274045} Twisted Earth Totem · The Lost Ones = {npc:256028} The Lost One
	["Five Twisted Earth Totems. The Lost Ones (murlocs, level 34-39) north and north-east of {area:75} in the {zone:1435} carry them; most run for help when hurt."] = "Cinq Totems de terre tordus. Les Introuvables (murlocs, niveau 34-39) au nord et au nord-est de {area:75}, dans le {zone:1435}, en portent ; la plupart fuient chercher de l'aide quand ils sont blessés.",

	-- Step 7: Twisted Water Totems
	-- plural, as words: Twisted Water Totems = {item:274046} Twisted Water Totem
	["Twisted Water Totems"] = "Totems d’eau tordus",
	-- {area:496} Brackenwall Village · {zone:1445} Dustwallow Marsh
	-- plural, as words: Twisted Water Totems = {item:274046} Twisted Water Totem
	["Five Twisted Water Totems. The Mirefin murlocs (level 35-38) north-east of {area:496} in northern {zone:1445} carry them."] = "Cinq Totems d'eau tordus. Les murlocs Aileron boueux (niveau 35-38) au nord-est du {area:496}, dans le nord du {zone:1445}, en portent.",

	-- Step 8: Twisted Air Totems
	-- plural, as words: Twisted Air Totems = {item:274047} Twisted Air Totem
	["Twisted Air Totems"] = "Totems d’air tordus",
	-- {area:2408} Shadowprey Village · {zone:1443} Desolace · {spell:9654} Jumping Lightning
	-- plural, as words: Twisted Air Totems = {item:274047} Twisted Air Totem
	["Five Twisted Air Totems. The Maraudine centaurs (level 36-40) north and north-east of {area:2408} in western {zone:1443} carry them; the Scouts drop one nearly every other kill. Wranglers Net and Disarm, Windchasers heal, Stormers throw {spell:9654}: pull one at a time. Respawn about five minutes."] = "Cinq Totems d'air tordus. Les centaures Maraudine (niveau 36-40) au nord et au nord-est du {area:2408}, dans l'ouest de {zone:1443}, en portent ; les Éclaireurs en laissent tomber un presque une fois sur deux. Les Querelleurs utilisent Filet et Désarmement, les Chasse-vent soignent, les Légion-tempête lancent {spell:9654} : attirez-les un par un. Réapparition en cinq minutes environ.",

	-- Step 10: The steam pools
	["The steam pools"] = "Les bassins de vapeur",
	-- {npc:259023} Veyric Thunderhame · {item:268582} Corrupted Totems · {zone:1441} Thousand Needles · {area:489} Thalanaar · {zone:1444} Feralas · {area:484} Freewind Post · {npc:216474} Ravaging Tempest · {item:212792} Eye of the Tempest
	["{npc:259023} hands you the {item:268582}. {zone:1441} is far: the boat to Theramore and the road west, or fly to {area:489} on the {zone:1444} border and head east into the canyon. Place the {item:268582} at the steam pools north-west of {area:484} to call the corrupted elementals and then the {npc:216474}; Razormane quilboar join the fight while the ritual runs. A group quest: bring at least one or two friends. The {item:212792} drops about every other kill, and every group member can loot it."] = "{npc:259023} vous remet les {item:268582}. Les {zone:1441} sont loin : le bateau pour Theramore puis la route vers l'ouest, ou volez jusqu'à {area:489}, à la frontière de {zone:1444}, et dirigez-vous vers l'est dans le canyon. Placez les {item:268582} aux bassins de vapeur au nord-ouest du {area:484} pour appeler les élémentaires corrompus puis la {npc:216474} ; des huttiers Tranchecrins se joignent au combat pendant le rituel. Une quête de groupe : venez avec au moins un ou deux amis. L'{item:212792} tombe environ une fois sur deux, et chaque membre du groupe peut la ramasser.",
	-- {item:212792} Eye of the Tempest · {npc:216474} Ravaging Tempest
	["{item:212792}, from the {npc:216474}"] = "{item:212792}, sur la {npc:216474}",

	-- Step 12: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher · {zone:1416} Alterac Mountains · {area:272} Tarren Mill · {item:280607} Lightning's Grasp · {item:280605} Tidebringer's Claw · {item:280604} Rage of the Storm
	["{npc:6176} camps in the ruins in the east of {zone:1416}: from {area:272} follow the river east of town north into the hills. Pick your weapon: {item:280607}, {item:280605} or {item:280604}."] = "{npc:6176} campe dans les ruines à l'est des {zone:1416} : depuis {area:272}, suivez vers le nord, dans les collines, la rivière qui passe à l'est de la ville. Choisissez votre arme : {item:280607}, {item:280605} ou {item:280604}.",
	-- {npc:6176} Bath'rah the Windwatcher · {item:280696} Elementalist's Guard
	["{npc:6176}: the {item:280696} and your weapon"] = "{npc:6176} : la {item:280696} et votre arme",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 30 {npc:258098}, the shaman trainer in {zone:1455}, sends you to {npc:259023} in {zone:1417}."] = "Au niveau 30, {npc:258098}, le maître des chamans de {zone:1455}, vous envoie voir {npc:259023} dans {zone:1417}.",
	-- ["The Lost Ones in the north of the {zone:1435} carry the Twisted Earth Totems."] = "Les Perdus du nord de {zone:1435} portent les Totems de terre tordus.",
	-- ["The Maraudine centaurs of western {zone:1443} carry the Twisted Air Totems."] = "Les centaures maraudine de l'ouest de {zone:1443} portent les Totems d’air tordus.",
	-- ["The Mirefin murlocs of northern {zone:1445} carry the Twisted Water Totems."] = "Les murlocs Aileron boueux du nord de {zone:1445} portent les Totems d’eau tordus.",
	-- ["The Stonevault troggs in the south of the {zone:1418} carry the Twisted Fire Totems."] = "Les troggs Cavepierre du sud de {zone:1418} portent les Totems de feu tordus.",
	-- ["{area:1717} is a dungeon at the southern edge of the {zone:1413} (the arrow points at its entrance); {npc:4421} is its last boss. Bring a group."] = "{area:1717} est un donjon à la limite sud de {zone:1413} (la flèche indique son entrée) ; {npc:4421} est son dernier boss. Venez en groupe.",
	-- ["{npc:259023} camps in the northern hills of {zone:1417}."] = "{npc:259023} campe dans les collines du nord de {zone:1417}.",
	-- ["{npc:259023} hands you the {item:268582}: place them at the steam pools of {zone:1441} and defeat the {npc:216474} they call. {quest:96135} is an elite quest: grouping up is advised."] = "{npc:259023} vous remet les {item:268582} : posez-les aux bassins de vapeur de {zone:1441} et vainquez la {npc:216474} qu'ils appellent. {quest:96135} est une quête élite : mieux vaut être en groupe.",
	-- ["{npc:6176} camps in the east of {zone:1416}, north-east of {area:272}."] = "{npc:6176} campe dans l'est de {zone:1416}, au nord-est de {area:272}.",
}
