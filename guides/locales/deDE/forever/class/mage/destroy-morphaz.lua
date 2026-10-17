-- German (deDE): the guide forever/class/mage/destroy-morphaz (forever/class/mage/destroy-morphaz.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1447} Azshara · {area:1417} Sunken Temple
	["Experience at 50 through {zone:1447} and the {area:1417}; Forever removed the Classic item choice."] = "Erfahrung mit Stufe 50 durch {zone:1447} und den {area:1417}; Forever hat die Gegenstandsauswahl aus Classic entfernt.",
	["Experience"] = "Erfahrung",

	-- Step 1: Magecraft (Stormwind)
	-- {npc:331} Maginor Dumas · {zone:1453} Stormwind · {object:2101} Mage Quarter · {zone:1455} Ironforge
	["{npc:331}, the Master Mage, stands in the Wizard's Sanctum in {zone:1453}'s {object:2101}; Dink in {zone:1455} gives the same quest."] = "{npc:331}, der Meistermagier, steht im Magiersanktum im Gebiet {object:2101} in {zone:1453}; Dink in {zone:1455} gibt dieselbe Quest.",

	-- Step 2: Magecraft (Orgrimmar)
	-- {npc:7311} Uthel'nay · {zone:1454} Orgrimmar · {npc:4567} Pierce Shackleton · {zone:1458} Undercity · {npc:3047} Archmage Shymm · {zone:1456} Thunder Bluff
	["{npc:7311}, one of {zone:1454}'s mage trainers, gives it; so do {npc:4567} in the {zone:1458} and {npc:3047} in {zone:1456}."] = "{npc:7311}, einer der Magierlehrer in {zone:1454}, gibt sie; ebenso {npc:4567} in {zone:1458} und {npc:3047} in {zone:1456}.",

	-- Step 3: Sanath Lim-yo
	-- {area:3137} Talrendis Point · {area:1237} Valormok · {npc:8395} Sanath Lim-yo · {zone:1447} Azshara · {area:1221} Ruins of Eldarath · {npc:8379} Archmage Xylem
	["Fly to {area:3137} (Alliance) or {area:1237} (Horde). {npc:8395} camps below his master's tower: from the fork of {zone:1447}'s main road at the {area:1221}, head straight north to the cliffs. He teleports you up to {npc:8379}."] = "Flieg zur {area:3137} (Allianz) oder nach {area:1237} (Horde). {npc:8395} lagert unterhalb des Turms seines Meisters: Geh von der Gabelung der Hauptstraße von {zone:1447} im Gebiet {area:1221} geradeaus nach Norden zu den Klippen. Er teleportiert dich hinauf zu {npc:8379}.",
	-- {npc:8379} Archmage Xylem
	["{npc:8379}, in the tower"] = "{npc:8379}, im Turm",

	-- Step 4: Glittering Dust
	-- {zone:1447} Azshara
	-- plural, as words: Blood Elf Surveyors = {npc:6198} Blood Elf Surveyor
	["The blood elves camp along the cliffs of north-eastern {zone:1447}; Blood Elf Surveyors and Reclaimers drop the dust."] = "Die Blutelfen lagern an den Klippen im Nordosten von {zone:1447}; Blutelfenfeldmesser und Blutelfenwiederbeschafferinnen lassen den Staub fallen.",

	-- Step 5: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo
	["Back to {npc:8395}, who teleports you up to the tower."] = "Zurück zu {npc:8395}, der dich hinauf zum Turm teleportiert.",

	-- Step 6: Enchanted Coral
	-- {area:1221} Ruins of Eldarath
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren
	["The Spitelash Sirens walk the ruins and beaches around the {area:1221} and the bay; they carry the coral."] = "Die Sirenen der Grollflossen streifen durch die Ruinen und Strände im Gebiet {area:1221} und an der Bucht; sie tragen die Koralle.",

	-- Step 7: Archmage Xylem again
	-- {npc:8379} Archmage Xylem
	["{npc:8379} again"] = "Wieder zu {npc:8379}",
	-- {npc:8395} Sanath Lim-yo
	["Back to {npc:8395} and up to the tower."] = "Zurück zu {npc:8395} und hinauf zum Turm.",

	-- Step 8: Morphaz
	["Morphaz"] = "Morphaz",
	-- {area:1477} Temple of Atal'Hakkar · {area:1417} Sunken Temple · {area:74} Pool of Tears · {item:20085} Arcane Shard
	["Morphaz, a green drake, waits deep in the {area:1477}, the {area:1417} in the {area:74}: a group of five, level 50-54. Kill him for the {item:20085}."] = "Morphaz, ein grüner Drache, wartet tief im Gebiet {area:1477}, dem {area:1417} im {area:74}: eine Gruppe aus fünf, Stufe 50-54. Töte ihn für den {item:20085}.",
	-- {item:20085} Arcane Shard
	["{item:20085}: Morphaz"] = "{item:20085}: Morphaz",

	-- Step 9: The Arcane Shard
	-- {item:20085} Arcane Shard
	["The {item:20085}"] = "Der {item:20085}",
	-- {zone:1447} Azshara · {npc:8395} Sanath Lim-yo
	["Back to {zone:1447}, {npc:8395} and the tower."] = "Zurück nach {zone:1447}, zu {npc:8395} und zum Turm.",
}
