-- German (deDE): the guide forever/class/warlock/orb-of-soranruk (forever/class/warlock/orb-of-soranruk.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A rare off-hand orb or staff for your 20s, for fragments from two dungeons."] = "Eine seltene Nebenhand-Kugel oder ein Stab für deine Zwanziger, für Fragmente aus zwei Dungeons.",

	-- Step 1: Doan Karhan
	-- {npc:6247} Doan Karhan · {npc:6244} Takar the Seer · {area:378} Camp Taurajo · {zone:1413} Barrens · {area:392} Ratchet · {area:2797} Blackfathom Deeps · {area:236} Shadowfang Keep
	["{npc:6247} camps beside {npc:6244}, at a tent just north-east of {area:378} in the southern {zone:1413}. Alliance warlocks reach him from {area:392} or Theramore; Horde ones head south from the Crossroads. He wants fragments from two dungeons: take the quest before your {area:2797} and {area:236} runs."] = "{npc:6247} lagert neben {npc:6244} an einem Zelt direkt nordöstlich von {area:378} im südlichen {zone:1413}. Allianz-Hexenmeister erreichen ihn von {area:392} oder Theramore aus; Horde-Hexenmeister gehen von den Crossroads nach Süden. Er will Fragmente aus zwei Dungeons: Nimm die Quest vor deinen Durchläufen von {area:2797} und {area:236}.",

	-- Step 2: Blackfathom Deeps
	-- {area:2797} Blackfathom Deeps · {zone:1440} Ashenvale · {area:414} Zoram Strand · {npc:4832} Twilight Lord Kelris · {npc:4829} Aku'mai
	-- plural, as words: Twilight Acolytes = {npc:4809} Twilight Acolyte
	["{area:2797} (level 24-32, a group of five) opens in the ruins on the north-west coast of {zone:1440}, under the water at {area:414}. The Twilight Acolytes (level 24-25, elite, healers) stand in the last halls, around {npc:4832} and the altar before {npc:4829}; each one drops a fragment, but only three spawn in a run and they do not come back for two hours, so one run covers one warlock: kill them first, before they heal the rest."] = "{area:2797} (Stufe 24-32, Gruppe aus fünf) öffnet sich in den Ruinen an der Nordwestküste von {zone:1440}, unter Wasser bei {area:414}. Die Twilight Acolytes (Stufe 24-25, Elite, Heiler) stehen in den letzten Hallen, um {npc:4832} und den Altar vor {npc:4829}; jeder lässt ein Fragment fallen, aber pro Durchlauf spawnen nur drei und sie kommen zwei Stunden nicht zurück, ein Durchlauf reicht also für einen Hexenmeister: Töte sie zuerst, bevor sie die anderen heilen.",
	-- plural, as words: Soran'ruk Fragments = {item:6914} Soran'ruk Fragment · Twilight Acolytes = {npc:4809} Twilight Acolyte
	["Soran'ruk Fragments, from the Twilight Acolytes inside"] = "Soran'ruk-Fragmente, von den Twilight Acolytes drinnen",

	-- Step 3: Shadowfang Keep
	-- {area:236} Shadowfang Keep · {area:228} Sepulcher
	-- plural, as words: Shadowfang Darksouls = {npc:3855} Shadowfang Darksoul
	["{area:236} (level 22-30, a group of five) stands on the hill south of the {area:228}. Free the prisoner in the cells right of the entrance and he opens the way into the courtyard. The Shadowfang Darksouls (level 20-21, elite) are not in the courtyard: they walk the halls past it, up the ramp that curves left and in the building after. About twelve stand in a run and one in five drops the Large Fragment, so clear every Darksoul and run it again if it does not drop."] = "{area:236} (Stufe 22-30, Gruppe aus fünf) liegt auf dem Hügel südlich von {area:228}. Befreie den Gefangenen in den Zellen rechts vom Eingang, dann öffnet er dir den Weg in den Hof. Die Shadowfang Darksouls (Stufe 20-21, Elite) sind nicht im Hof: Sie laufen in den Hallen dahinter, die nach links gekrümmte Rampe hinauf und im Gebäude danach. Etwa zwölf stehen in einem Durchlauf, und eine von fünf lässt das Große Fragment fallen, töte also jede Darksoul und wiederhole den Durchlauf, falls es nicht fällt.",
	-- {item:6915} Large Soran'ruk Fragment
	-- plural, as words: Shadowfang Darksouls = {npc:3855} Shadowfang Darksoul
	["{item:6915}, from the Shadowfang Darksouls inside"] = "{item:6915}, von den Shadowfang Darksouls drinnen",

	-- Step 4: Back to Doan Karhan
	-- {npc:6247} Doan Karhan
	["Back to {npc:6247}"] = "Zurück zu {npc:6247}",
	-- {item:6898} Orb of Soran'ruk · {item:15109} Staff of Soran'ruk
	["Choose the off-hand {item:6898} or the two-handed {item:15109}."] = "Wähle die Nebenhand {item:6898} oder den Zweihandstab {item:15109}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A rare off-hand orb or staff for your late 20s, for fragments from two dungeons."] = "Eine seltene Kugel für die Schildhand oder ein Stab für deine späten 20er, für Fragmente aus zwei Dungeons.",
	-- ["The Shadowfang Darksouls inside {area:236}, a level 20-30 dungeon, drop the Large Fragment about one time in five: bring a group. The keep stands south of the {area:228}."] = "Die Shadowfang-Dunkelseelen in {area:236}, einem Dungeon der Stufe 20-30, lassen das Große Soran'ruk-Fragment etwa einmal in fünf fallen: Bring eine Gruppe mit. Die Burg steht südlich von {area:228}.",
	-- ["The Twilight Acolytes inside {area:2797}, a level 24-32 dungeon, each drop a {item:6914}: bring a group. The entrance is in the ruins on the north-west coast of {zone:1440}."] = "Die Twilight-Akolythen in {area:2797}, einem Dungeon der Stufe 24-32, lassen je ein {item:6914} fallen: Bring eine Gruppe mit. Der Eingang liegt in den Ruinen an der Nordwestküste von {zone:1440}.",
	-- ["{item:6914}, from the Twilight Acolytes"] = "{item:6914}, von den Twilight-Akolythen",
	-- ["{item:6915}, from the Shadowfang Darksouls"] = "{item:6915}, von den Shadowfang-Dunkelseelen",
	-- ["{npc:6247} camps in the southern {zone:1413}, east of the road north-east of {area:378}."] = "{npc:6247} lagert im südlichen {zone:1413}, östlich der Straße nordöstlich von {area:378}.",
}
