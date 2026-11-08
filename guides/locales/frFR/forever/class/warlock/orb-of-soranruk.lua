-- French (frFR): the guide forever/class/warlock/orb-of-soranruk (forever/class/warlock/orb-of-soranruk.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A rare off-hand orb or staff for your 20s, for fragments from two dungeons."] = "Une orbe de main gauche ou un bâton rare pour votre vingtaine, contre des fragments de deux donjons.",

	-- Step 1: Doan Karhan
	-- {npc:6247} Doan Karhan · {npc:6244} Takar the Seer · {area:378} Camp Taurajo · {zone:1413} Barrens · {area:392} Ratchet · {area:2797} Blackfathom Deeps · {area:236} Shadowfang Keep
	["{npc:6247} camps beside {npc:6244}, at a tent just north-east of {area:378} in the southern {zone:1413}. Alliance warlocks reach him from {area:392} or Theramore; Horde ones head south from the Crossroads. He wants fragments from two dungeons: take the quest before your {area:2797} and {area:236} runs."] = "",

	-- Step 2: Blackfathom Deeps
	-- {area:2797} Blackfathom Deeps · {zone:1440} Ashenvale · {area:414} Zoram Strand · {npc:4832} Twilight Lord Kelris · {npc:4829} Aku'mai
	-- plural, as words: Twilight Acolytes = {npc:4809} Twilight Acolyte
	["{area:2797} (level 24-32, a group of five) opens in the ruins on the north-west coast of {zone:1440}, under the water at {area:414}. The Twilight Acolytes (level 24-25, elite, healers) stand in the last halls, around {npc:4832} and the altar before {npc:4829}; each one drops a fragment, but only three spawn in a run and they do not come back for two hours, so one run covers one warlock: kill them first, before they heal the rest."] = "{area:2797} (niveau 24-32, un groupe de cinq) s'ouvre dans les ruines de la côte nord-ouest d'{zone:1440}, sous l'eau à la {area:414}. Les Acolytes du crépuscule (niveau 24-25, élites, soigneurs) se tiennent dans les dernières salles, autour de {npc:4832} et de l'autel devant {npc:4829} ; chacun lâche un fragment, mais seuls trois apparaissent par expédition et ils ne reviennent pas avant deux heures, une expédition ne suffit donc qu'à un seul démoniste : tuez-les en premier, avant qu'ils ne soignent les autres.",
	-- plural, as words: Soran'ruk Fragments = {item:6914} Soran'ruk Fragment · Twilight Acolytes = {npc:4809} Twilight Acolyte
	["Soran'ruk Fragments, from the Twilight Acolytes inside"] = "Fragments de Soran'ruk, sur les Acolytes du crépuscule à l'intérieur",

	-- Step 3: Shadowfang Keep
	-- {area:236} Shadowfang Keep · {area:228} Sepulcher
	-- plural, as words: Shadowfang Darksouls = {npc:3855} Shadowfang Darksoul
	["{area:236} (level 22-30, a group of five) stands on the hill south of the {area:228}. Free the prisoner in the cells right of the entrance and he opens the way into the courtyard. The Shadowfang Darksouls (level 20-21, elite) are not in the courtyard: they walk the halls past it, up the ramp that curves left and in the building after. About twelve stand in a run and one in five drops the Large Fragment, so clear every Darksoul and run it again if it does not drop."] = "Le {area:236} (niveau 22-30, un groupe de cinq) se dresse sur la colline au sud du {area:228}. Libérez le prisonnier dans les cellules à droite de l'entrée et il vous ouvre le chemin de la cour. Les Ténébreux d'Ombrecroc (niveau 20-21, élites) ne sont pas dans la cour : ils parcourent les salles au-delà, en haut de la rampe qui tourne à gauche et dans le bâtiment suivant. Une douzaine se tiennent là par expédition et un sur cinq lâche le grand fragment : éliminez donc tous les Ténébreux et recommencez s'il ne tombe pas.",
	-- {item:6915} Large Soran'ruk Fragment
	-- plural, as words: Shadowfang Darksouls = {npc:3855} Shadowfang Darksoul
	["{item:6915}, from the Shadowfang Darksouls inside"] = "{item:6915}, sur les Ténébreux d'Ombrecroc à l'intérieur",

	-- Step 4: Back to Doan Karhan
	-- {npc:6247} Doan Karhan
	["Back to {npc:6247}"] = "Retour auprès de {npc:6247}",
	-- {item:6898} Orb of Soran'ruk · {item:15109} Staff of Soran'ruk
	["Choose the off-hand {item:6898} or the two-handed {item:15109}."] = "Choisissez l'{item:6898} de main gauche ou le {item:15109} à deux mains.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A rare off-hand orb or staff for your late 20s, for fragments from two dungeons."] = "Un orbe de main gauche ou un bâton rare pour la fin de vos niveaux 20, contre des fragments de deux donjons.",
	-- ["The Shadowfang Darksouls inside {area:236}, a level 20-30 dungeon, drop the Large Fragment about one time in five: bring a group. The keep stands south of the {area:228}."] = "Les Ténébreux d'Ombrecroc de {area:236}, un donjon de niveau 20-30, laissent tomber le Grand fragment environ une fois sur cinq : venez en groupe. Le donjon se dresse au sud de {area:228}.",
	-- ["The Twilight Acolytes inside {area:2797}, a level 24-32 dungeon, each drop a {item:6914}: bring a group. The entrance is in the ruins on the north-west coast of {zone:1440}."] = "Les Acolytes du crépuscule de {area:2797}, un donjon de niveau 24-32, laissent chacun tomber un {item:6914} : venez en groupe. L'entrée se trouve dans les ruines de la côte nord-ouest d'{zone:1440}.",
	-- ["{item:6914}, from the Twilight Acolytes"] = "{item:6914}, sur les Acolytes du crépuscule",
	-- ["{item:6915}, from the Shadowfang Darksouls"] = "{item:6915}, sur les Ténébreux d'Ombrecroc",
	-- ["{npc:6247} camps beside {npc:6244}, at a tent just north-east of {area:378} in the southern {zone:1413}. Alliance warlocks reach him from {area:392} or Theramore; Horde ones head south from the {area:380}. He wants fragments from two dungeons: take the quest before your {area:2797} and {area:236} runs."] = "{npc:6247} campe à côté de {npc:6244}, sous une tente juste au nord-est du {area:378}, dans le sud des {zone:1413}. Les démonistes de l'Alliance le rejoignent depuis {area:392} ou Theramore ; ceux de la Horde descendent au sud depuis la {area:380}. Il veut des fragments de deux donjons : prenez la quête avant vos expéditions à {area:2797} et au {area:236}.",
	-- ["{npc:6247} camps in the southern {zone:1413}, east of the road north-east of {area:378}."] = "{npc:6247} campe dans le sud de {zone:1413}, à l'est de la route au nord-est de {area:378}.",
}
