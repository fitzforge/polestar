-- French (frFR): the guide forever/class/mage/destroy-morphaz (forever/class/mage/destroy-morphaz.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1447} Azshara · {area:1417} Sunken Temple
	["Experience at 50 through {zone:1447} and the {area:1417}; Forever removed the Classic item choice."] = "De l'expérience au niveau 50 via {zone:1447} et {area:1417} ; Forever a supprimé le choix d'objet de Classic.",
	["Experience"] = "Expérience",

	-- Step 1: Magecraft (Stormwind)
	-- {npc:331} Maginor Dumas · {zone:1453} Stormwind · {object:2101} Mage Quarter · {zone:1455} Ironforge
	["{npc:331}, the Master Mage, stands in the Wizard's Sanctum in {zone:1453}'s {object:2101}; Dink in {zone:1455} gives the same quest."] = "{npc:331}, le maître des mages, se tient dans la tour de {object:2101} de {zone:1453} ; Dink, à {zone:1455}, donne la même quête.",

	-- Step 2: Magecraft (Orgrimmar)
	-- {npc:7311} Uthel'nay · {zone:1454} Orgrimmar · {npc:4567} Pierce Shackleton · {zone:1458} Undercity · {npc:3047} Archmage Shymm · {zone:1456} Thunder Bluff
	["{npc:7311}, one of {zone:1454}'s mage trainers, gives it; so do {npc:4567} in the {zone:1458} and {npc:3047} in {zone:1456}."] = "{npc:7311}, l'un des maîtres des mages d'{zone:1454}, la donne ; tout comme {npc:4567} à {zone:1458} et {npc:3047} à {zone:1456}.",

	-- Step 3: Sanath Lim-yo
	-- {area:3137} Talrendis Point · {area:1237} Valormok · {npc:8395} Sanath Lim-yo · {zone:1447} Azshara · {area:1221} Ruins of Eldarath · {npc:8379} Archmage Xylem
	["Fly to {area:3137} (Alliance) or {area:1237} (Horde). {npc:8395} camps below his master's tower: from the fork of {zone:1447}'s main road at the {area:1221}, head straight north to the cliffs. He teleports you up to {npc:8379}."] = "Volez jusqu'à {area:3137} (Alliance) ou {area:1237} (Horde). {npc:8395} campe au pied de la tour de son maître : depuis la fourche de la route principale d'{zone:1447}, à {area:1221}, allez droit au nord jusqu'aux falaises. Il vous téléporte auprès de {npc:8379}.",
	-- {npc:8379} Archmage Xylem
	["{npc:8379}, in the tower"] = "{npc:8379}, dans la tour",

	-- Step 4: Glittering Dust
	-- {zone:1447} Azshara
	-- plural, as words: Blood Elf Surveyors = {npc:6198} Blood Elf Surveyor
	["The blood elves camp along the cliffs of north-eastern {zone:1447}; Blood Elf Surveyors and Reclaimers drop the dust."] = "Les elfes de sang campent le long des falaises au nord-est d'{zone:1447} ; les Géomètres et Vengeurs elfes de sang lâchent la poussière.",

	-- Step 5: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo
	["Back to {npc:8395}, who teleports you up to the tower."] = "Retournez voir {npc:8395}, qui vous téléporte dans la tour.",

	-- Step 6: Enchanted Coral
	-- {area:1221} Ruins of Eldarath
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren
	["The Spitelash Sirens walk the ruins and beaches around the {area:1221} and the bay; they carry the coral."] = "Les Sirènes Fouette-bile arpentent les ruines et les plages autour de {area:1221} et de la baie ; elles portent le corail.",

	-- Step 7: Archmage Xylem again
	-- {npc:8379} Archmage Xylem
	["{npc:8379} again"] = "De nouveau {npc:8379}",
	-- {npc:8395} Sanath Lim-yo
	["Back to {npc:8395} and up to the tower."] = "Retournez voir {npc:8395} et montez dans la tour.",

	-- Step 8: Morphaz
	["Morphaz"] = "Morphaz",
	-- {area:1477} Temple of Atal'Hakkar · {area:1417} Sunken Temple · {area:74} Pool of Tears · {item:20085} Arcane Shard
	["Morphaz, a green drake, waits deep in the {area:1477}, the {area:1417} in the {area:74}: a group of five, level 50-54. Kill him for the {item:20085}."] = "Morphaz, un drake vert, attend au fond de {area:1477}, {area:1417} dans {area:74} : groupe de cinq, niveaux 50-54. Tuez-le pour {item:20085}.",
	-- {item:20085} Arcane Shard
	["{item:20085}: Morphaz"] = "{item:20085} : Morphaz",

	-- Step 9: The Arcane Shard
	-- {item:20085} Arcane Shard
	["The {item:20085}"] = "{item:20085}",
	-- {zone:1447} Azshara · {npc:8395} Sanath Lim-yo
	["Back to {zone:1447}, {npc:8395} and the tower."] = "Retournez en {zone:1447}, auprès de {npc:8395} et à la tour.",
}
