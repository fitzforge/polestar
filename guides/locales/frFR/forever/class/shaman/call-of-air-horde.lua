-- French (frFR): the guide forever/class/shaman/call-of-air-horde (forever/class/shaman/call-of-air-horde.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:1531} Call of Air
	["{quest:1531} and the Tempest's Weapons (Horde)"] = "{quest:1531} et les armes de la Tempête (Horde)",
	-- {item:5178} Air Totem
	["The {item:5178} that lets you place air totems, then a weapon of your choice at 40."] = "{item:5178}, qui permet de poser les totems d'air, puis une arme de votre choix au niveau 40.",

	-- Step 1: Searn Firewarder
	-- {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom · {npc:5905} Prate Cloudseer · {zone:1441} Thousand Needles · {spell:10596} Nature Resistance · {item:5178} Air Totem
	["At 30 {npc:5892} in the {object:172957} sends you to {npc:5905} in {zone:1441}. Your level 30 air totems (Grounding, {spell:10596}) need the {item:5178} she gives."] = "Au niveau 30, {npc:5892}, dans la {object:172957}, vous envoie voir {npc:5905} dans {zone:1441}. Vos totems d'air du niveau 30 (Glèbe, {spell:10596}) exigent le {item:5178} qu'elle donne.",

	-- Step 2: Alaana Stormwalker
	-- {quest:96136} Call of Air · {npc:259119} Alaana Stormwalker · {zone:1412} Mulgore · {zone:1456} Thunder Bluff · {npc:5906} Xanis Flameweaver
	["At 30 Skyborne shamans get their own {quest:96136}. {npc:259119} waits where the airship from Zephras Isle lands, in northern {zone:1412} beside {zone:1456}. Your level 30 air totems need the Air Totem Prate Cloudseer gives. If she has nothing for you, head up to {npc:5906} in {zone:1456} (next step): the trainers' {quest:96136} is open to Skyborne and gives the same totem."] = "Au niveau 30, les chamans éolides ont leur propre {quest:96136}. {npc:259119} attend là où se pose l'aéronef venu de l'Île de Zéphras, au nord de {zone:1412}, à côté des {zone:1456}. Vos totems d'air du niveau 30 exigent le Totem d'air que donne Prate Cherchenuée. Si elle n'a rien pour vous, montez voir {npc:5906} aux {zone:1456} (étape suivante) : la quête {quest:96136} des maîtres est ouverte aux Éolides et donne le même totem.",

	-- Step 3: Xanis Flameweaver
	-- {npc:5906} Xanis Flameweaver · {area:1640} Spirit Rise · {zone:1456} Thunder Bluff · {npc:5905} Prate Cloudseer · {zone:1441} Thousand Needles · {spell:10596} Nature Resistance · {npc:5892} Searn Firewarder · {quest:1531} Call of Air · {zone:1454} Orgrimmar
	["At 30 {npc:5906}, a shaman trainer on {area:1640} in {zone:1456}, sends you to {npc:5905} in {zone:1441}. Your level 30 air totems (Grounding, {spell:10596}) need the Air Totem Prate gives. Already carry {npc:5892}'s {quest:1531} from {zone:1454}? It goes to {npc:5905} too: skip {npc:5906}."] = "Au niveau 30, {npc:5906}, maître des chamans sur la {area:1640} aux {zone:1456}, vous envoie voir {npc:5905} dans {zone:1441}. Vos totems d'air du niveau 30 (Glèbe, {spell:10596}) exigent le Totem d'air que donne Prate. Vous avez déjà la quête {quest:1531} de {npc:5892}, venue d'{zone:1454} ? Elle mène aussi à {npc:5905} : passez {npc:5906}.",

	-- Step 4: Prate Cloudseer
	-- {area:484} Freewind Post · {npc:5905} Prate Cloudseer
	["Fly to {area:484}. {npc:5905} stands on a ledge above a cave mouth in the canyon wall north-east of the post, not inside the cave: climb the slope beside it. She also gives you an hour of faster attacks and running."] = "Volez jusqu'au {area:484}. {npc:5905} se tient sur une corniche au-dessus de l'entrée d'une grotte, dans la paroi du canyon au nord-est du poste, pas dans la grotte : montez la pente à côté. Elle vous donne aussi une heure d'attaques et de course plus rapides.",

	-- Step 5
	-- {npc:5905} Prate Cloudseer · {item:5178} Air Totem
	["{npc:5905}: your {item:5178}"] = "{npc:5905} : votre {item:5178}",

	-- Step 9: Charlga Razorflank
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {npc:4421} Charlga Razorflank · {spell:8292} Chain Bolt · {spell:139} Renew · {item:274463} Tattered Note
	["{area:1717} is a five-player dungeon at the southern edge of the {zone:1413} (the arrow points at its entrance); {npc:4421} (level 33 elite) is its last boss. She casts {spell:8292}, {spell:139} on her allies and Purity; the {item:274463} drops only from her."] = "{area:1717} est un donjon à cinq joueurs à la lisière sud des {zone:1413} (la flèche montre son entrée) ; {npc:4421} (élite de niveau 33) en est le dernier boss. Elle lance {spell:8292}, {spell:139} sur ses alliés et Purification ; la {item:274463} ne tombe que sur elle.",
	-- {item:274463} Tattered Note · {npc:4421} Charlga Razorflank
	["{item:274463}, from {npc:4421}"] = "{item:274463}, sur {npc:4421}",

	-- Step 10: Rau Cliffrunner
	-- {npc:4722} Rau Cliffrunner · {area:484} Freewind Post
	["{npc:4722} stands at {area:484}."] = "{npc:4722} se tient au {area:484}.",

	-- Step 12: Twisted Air Totems
	-- plural, as words: Twisted Air Totems = {item:274047} Twisted Air Totem
	["Twisted Air Totems"] = "Twisted Air Totems",
	-- {area:2408} Shadowprey Village · {zone:1443} Desolace · {spell:9654} Jumping Lightning
	-- plural, as words: Twisted Air Totems = {item:274047} Twisted Air Totem
	["Five Twisted Air Totems. The Maraudine centaurs (level 36-40) north and north-east of {area:2408} in western {zone:1443} carry them; the Scouts drop one nearly every other kill. Wranglers Net and Disarm, Windchasers heal, Stormers throw {spell:9654}: pull one at a time. Respawn about five minutes."] = "Cinq Totems d'air tordus. Les centaures Maraudine (niveau 36-40) au nord et au nord-est du {area:2408}, dans l'ouest de {zone:1443}, en portent ; les Éclaireurs en lâchent un presque une fois sur deux. Les Dresseurs lancent Filet et Désarmement, les Chasse-vent soignent, les Tempêtes lancent {spell:9654} : attirez-les un par un. Réapparition en cinq minutes environ.",

	-- Step 13: Twisted Water Totems
	-- plural, as words: Twisted Water Totems = {item:274046} Twisted Water Totem
	["Twisted Water Totems"] = "Twisted Water Totems",
	-- {area:496} Brackenwall Village · {zone:1445} Dustwallow Marsh
	-- plural, as words: Twisted Water Totems = {item:274046} Twisted Water Totem
	["Five Twisted Water Totems. The Mirefin murlocs (level 35-38) north-east of {area:496} in northern {zone:1445} carry them."] = "Cinq Totems d'eau tordus. Les murlocs Aileboue (niveau 35-38) au nord-est du {area:496}, dans le nord du {zone:1445}, en portent.",

	-- Step 14: Twisted Fire Totems
	-- plural, as words: Twisted Fire Totems = {item:274044} Twisted Fire Totem
	["Twisted Fire Totems"] = "Twisted Fire Totems",
	-- {area:338} Angor Fortress · {zone:1418} Badlands · {npc:3560} Healing Ward
	-- plural, as words: Twisted Fire Totems = {item:274044} Twisted Fire Totem · Fire Nova Totems = {npc:5879} Fire Nova Totem
	["Five Twisted Fire Totems. The Stonevault troggs (Skullthumpers, Bonesnappers and Shamans, level 37-41) south of {area:338} in the {zone:1418} carry them; the Shamans drop Fire Nova Totems and a {npc:3560}, the Bonesnappers run for help when hurt. Respawn about five minutes."] = "Cinq Totems de feu tordus. Les troggs de la Voûte de pierre (Cogne-crânes, Brise-os et Chamans, niveau 37-41) au sud de la {area:338}, dans les {zone:1418}, en portent ; les Chamans posent des totems Nova de feu et une {npc:3560}, les Brise-os fuient chercher de l'aide quand ils sont blessés. Réapparition en cinq minutes environ.",

	-- Step 15: Twisted Earth Totems
	-- plural, as words: Twisted Earth Totems = {item:274045} Twisted Earth Totem
	["Twisted Earth Totems"] = "Twisted Earth Totems",
	-- {area:75} Stonard · {zone:1435} Swamp of Sorrows
	-- plural, as words: Twisted Earth Totems = {item:274045} Twisted Earth Totem · The Lost Ones = {npc:256028} The Lost One
	["Five Twisted Earth Totems. The Lost Ones (murlocs, level 34-39) north and north-east of {area:75} in the {zone:1435} carry them; most run for help when hurt."] = "Cinq Totems de terre tordus. Les Introuvables (des murlocs, niveau 34-39) au nord et au nord-est de {area:75}, dans le {zone:1435}, en portent ; la plupart fuient chercher de l'aide quand ils sont blessés.",

	-- Step 17: The steam pools
	["The steam pools"] = "Les bassins de vapeur",
	-- {npc:5905} Prate Cloudseer · {item:268582} Corrupted Totems · {area:484} Freewind Post · {npc:216474} Ravaging Tempest · {item:212792} Eye of the Tempest
	["{npc:5905} hands you the {item:268582}. Place the {item:268582} at the steam pools north-west of {area:484} to call the corrupted elementals and then the {npc:216474}; Razormane quilboar join the fight while the ritual runs. A group quest: bring at least one or two friends. The {item:212792} drops about every other kill, and every group member can loot it."] = "{npc:5905} vous remet les {item:268582}. Posez les {item:268582} près des bassins de vapeur au nord-ouest du {area:484} pour appeler les élémentaires corrompus, puis la {npc:216474} ; des hurans Tranchecrin se joignent au combat pendant le rituel. Quête de groupe : venez avec au moins un ou deux amis. L'{item:212792} tombe environ une fois sur deux, et chaque membre du groupe peut la ramasser.",
	-- {item:212792} Eye of the Tempest · {npc:216474} Ravaging Tempest
	["{item:212792}, from the {npc:216474}"] = "{item:212792}, sur {npc:216474}",

	-- Step 19: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher · {zone:1416} Alterac Mountains · {area:272} Tarren Mill · {item:280607} Lightning's Grasp · {item:280605} Tidebringer's Claw · {item:280604} Rage of the Storm · {item:280696} Elementalist's Guard
	["{npc:6176} camps in the ruins in the east of {zone:1416}: from {area:272} follow the river east of town north into the hills. Pick your weapon: {item:280607}, {item:280605} or {item:280604}; the {item:280696} shield comes with it."] = "{npc:6176} campe dans les ruines à l'est des {zone:1416} : depuis {area:272}, suivez vers le nord, dans les collines, la rivière à l'est du village. Choisissez votre arme : {item:280607}, {item:280605} ou {item:280604} ; le bouclier {item:280696} l'accompagne.",
	-- {npc:6176} Bath'rah the Windwatcher · {item:280696} Elementalist's Guard
	["{npc:6176}: the {item:280696} and your weapon"] = "{npc:6176} : le {item:280696} et votre arme",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 30 {npc:5892} in the {object:172957} sends you to {npc:5905} in {zone:1441}."] = "Au niveau 30, {npc:5892}, à {object:172957}, vous envoie voir {npc:5905} dans {zone:1441}.",
	-- ["At 30 {npc:5906}, a shaman trainer in {zone:1456}, sends you to {npc:5905} in {zone:1441}."] = "Au niveau 30, {npc:5906}, maître des chamans à {zone:1456}, vous envoie voir {npc:5905} dans {zone:1441}.",
	-- ["Fly to {area:484}. {npc:5905} hides in a small cave in the canyon wall north-east of the post. Skyborne: your own {quest:1531} (96136) ends with her too."] = "Volez jusqu'au {area:484}. {npc:5905} se cache dans une petite grotte de la paroi du canyon, au nord-est du poste. Éolides : votre propre {quest:1531} (96136) se rend aussi auprès d'elle.",
	-- ["The Lost Ones in the north of the {zone:1435} carry the Twisted Earth Totems."] = "Les Perdus du nord de {zone:1435} portent les Twisted Earth Totems.",
	-- ["The Maraudine centaurs of western {zone:1443} carry the Twisted Air Totems."] = "Les centaures maraudine de l'ouest de {zone:1443} portent les Twisted Air Totems.",
	-- ["The Mirefin murlocs of northern {zone:1445} carry the Twisted Water Totems."] = "Les murlocs Aileron boueux du nord de {zone:1445} portent les Twisted Water Totems.",
	-- ["The Stonevault troggs in the south of the {zone:1418} carry the Twisted Fire Totems."] = "Les troggs Cavepierre du sud de {zone:1418} portent les Twisted Fire Totems.",
	-- ["{area:1717} is a dungeon at the southern edge of the {zone:1413} (the arrow points at its entrance); {npc:4421} is its last boss. Bring a group."] = "{area:1717} est un donjon au bord sud de {zone:1413} (la flèche indique son entrée) ; {npc:4421} en est le dernier boss. Venez en groupe.",
	-- ["{npc:5905} hands you the {item:268582}: place them at the steam pools west of {area:484} and defeat the {npc:216474} they call. {quest:79366} is an elite quest: grouping up is advised."] = "{npc:5905} Cloudseer vous remet {item:268582} : placez-les aux bassins de vapeur à l'ouest du {area:484} et vainquez {npc:216474} qu'ils appellent. {quest:79366} est une quête élite : il est conseillé de grouper.",
	-- ["{npc:6176} camps in the east of {zone:1416}, north-east of {area:272}."] = "{npc:6176} campe dans l'est de {zone:1416}, au nord-est de {area:272}.",
	-- ["{npc:6176}: the {item:213086} and your weapon"] = "{npc:6176} : {item:213086} et votre arme",
}
