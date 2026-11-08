-- Spanish (Latin America) (esMX): the guide forever/class/mage/destroy-morphaz (forever/class/mage/destroy-morphaz.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1447} Azshara · {area:1417} Sunken Temple
	["Experience at 50 through {zone:1447} and the {area:1417}; Classic's item choice may be gone on Forever."] = "",
	["Experience"] = "Experiencia",

	-- Step 1: Magecraft (Stormwind)
	-- {npc:331} Maginor Dumas · {zone:1453} Stormwind · {object:2101} Mage Quarter · {zone:1455} Ironforge
	["{npc:331}, the Master Mage, stands in the Wizard's Sanctum in {zone:1453}'s {object:2101}; Dink in {zone:1455} gives the same quest."] = "{npc:331}, el maestro mago, está en la torre del {object:2101} de {zone:1453}; Dink, en {zone:1455}, da la misma misión.",

	-- Step 2: Magecraft (Orgrimmar)
	-- {npc:7311} Uthel'nay · {zone:1454} Orgrimmar · {object:173161} Darkbriar Lodge (no name in this language: may be words) · {npc:4567} Pierce Shackleton · {zone:1458} Undercity · {npc:3047} Archmage Shymm · {zone:1456} Thunder Bluff
	["{npc:7311}, one of {zone:1454}'s mage trainers in {object:173161}, gives it; so do {npc:4567} in the {zone:1458} and {npc:3047} in {zone:1456}."] = "",

	-- Step 3: Sanath Lim-yo
	-- {area:3137} Talrendis Point · {area:1237} Valormok · {npc:8395} Sanath Lim-yo · {zone:1447} Azshara · {area:1221} Ruins of Eldarath · {npc:8379} Archmage Xylem
	["Fly to {area:3137} (Alliance) or {area:1237} (Horde). {npc:8395} camps below his master's tower, a short way east of {area:1237}: from the fork of {zone:1447}'s main road at the {area:1221}, head straight north to the cliffs. Get off your mount before he teleports you up, or the teleport may not take you. A trail with no enemies climbs to {npc:8379} at the top of the tower; an attendant at the top sends you back down, as often as you like."] = "",
	-- {npc:8379} Archmage Xylem
	["{npc:8379}, in the tower"] = "{npc:8379}, en la torre",

	-- Step 4: Glittering Dust
	-- {area:1220} Thalassian Base Camp · {zone:1447} Azshara · {spell:8349} Fire Nova · {spell:133} Fireball · {spell:139} Renew
	-- plural, as words: Blood Elf Surveyors = {npc:6198} Blood Elf Surveyor
	["The blood elves hold the {area:1220} on the hills of north-eastern {zone:1447}. Blood Elf Surveyors (51-52, {spell:8349} up close) and Reclaimers (52-53, {spell:133}, and they heal and {spell:139} each other) each drop the dust about one time in four; they spot you from far off, so pull at the edges. They come back after 5 1/2 minutes."] = "",

	-- Step 5: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo
	["Back to {npc:8395}, who teleports you up to the tower."] = "Regresa con {npc:8395}, que te teletransporta a la torre.",

	-- Step 6: Enchanted Coral
	-- {area:1221} Ruins of Eldarath · {area:1237} Valormok · {area:1223} Temple of Zin-Malor · {npc:7864} Lingering Highborne
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren · Spitelash Screamers = {npc:6193} Spitelash Screamer
	["The Spitelash Sirens (level 50-52) walk the ruins and beaches around the {area:1221} and the bay east of {area:1237}, often three together, and a few stand inside the {area:1223}; each drops a coral about one time in four. The Spitelash Screamers look almost the same but never drop it. Killing the other naga there makes more Sirens appear in their spots. {npc:7864} ghosts wander the ruins: watch your back."] = "",

	-- Step 7: Archmage Xylem again
	-- {npc:8379} Archmage Xylem
	["{npc:8379} again"] = "{npc:8379} otra vez",
	-- {npc:8395} Sanath Lim-yo
	["Back to {npc:8395} and up to the tower."] = "Regresa con {npc:8395} y sube a la torre.",

	-- Step 8: Morphaz
	["Morphaz"] = "Morphaz",
	-- {area:1477} The Temple of Atal'Hakkar · {area:1417} Sunken Temple · {area:74} Pool of Tears · {npc:5710} Jammal'an the Prophet · {npc:5711} Ogom the Wretched · {spell:12533} Acid Breath · {spell:11019} Wing Flap
	["{area:1477}, the {area:1417}, lies in the {area:74}: climb the steps into the sunken building, swim down through it and follow the passage down to the portal. A group of five, level 50-54. Morphaz is not waiting when you arrive. First kill the six troll guardians (elites of 50-52) on the platforms around the upper ring; that opens the way down (the left-hand ramp from the entrance) to {npc:5710} and {npc:5711} in the Pit of Sacrifice. Once Jammal'an dies, two green drakes, Weaver and Dreamscythe, come out and patrol the pit: pull them one at a time. When both are dead, Morphaz (level 52 elite, {spell:12533} and {spell:11019}) and Hazzas appear together and cannot be split, so fight both. The shard always drops. Hunters, Priests and Rogues of 50 need Morphaz too: a group of them shares one clear."] = "",
	-- {item:20085} Arcane Shard
	["{item:20085}: Morphaz"] = "{item:20085}: Morphaz",

	-- Step 9: The Arcane Shard
	-- {item:20085} Arcane Shard
	["The {item:20085}"] = "{item:20085}",
	-- {zone:1447} Azshara · {npc:8395} Sanath Lim-yo · {item:20037} Arcane Crystal Pendant · {item:20036} Fire Ruby · {item:20035} Glacial Spike
	["Back to {zone:1447}, {npc:8395} and the tower. Look at the reward window before you hand in: Classic offered the {item:20037}, the {item:20036} or the {item:20035}, and Forever's notes say the choice may be gone."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {zone:1447}, {npc:8395} and the tower."] = "Regresa a {zone:1447}, con {npc:8395} y a la torre.",
	-- ["Experience at 50 through {zone:1447} and the {area:1417}; Forever removed the Classic item choice."] = "Experiencia a nivel 50 por {zone:1447} y {area:1417}; Forever quitó la elección de objeto de Classic.",
	-- ["Fly to {area:3137} (Alliance) or {area:1237} (Horde). {npc:8395} camps below his master's tower: from the fork of {zone:1447}'s main road at the {area:1221}, head straight north to the cliffs. He teleports you up to {npc:8379}."] = "Vuela a {area:3137} (Alianza) o {area:1237} (Horda). {npc:8395} acampa bajo la torre de su maestro: desde la bifurcación del camino principal de {zone:1447} en {area:1221}, ve directo al norte hasta los acantilados. Te teletransporta arriba con {npc:8379}.",
	-- ["Morphaz, a green drake, waits deep in the {area:1477}, the {area:1417} in the {area:74}: a group of five, level 50-54. Kill him for the {item:20085}."] = "Morphaz, un draco verde, espera en lo profundo de {area:1477}, {area:1417} en {area:74}: grupo de cinco, nivel 50-54. Mátalo para obtener el {item:20085}.",
	-- ["The Spitelash Sirens walk the ruins and beaches around the {area:1221} and the bay; they carry the coral."] = "Las Sirenas Látigo de Ira recorren las ruinas y playas alrededor de {area:1221} y la bahía; llevan el coral.",
	-- ["The blood elves camp along the cliffs of north-eastern {zone:1447}; Blood Elf Surveyors and Reclaimers drop the dust."] = "Los elfos de sangre acampan en los acantilados del noreste de {zone:1447}; los Peritos y Reivindicadores elfos de sangre sueltan el polvo.",
	-- ["{npc:7311}, one of {zone:1454}'s mage trainers, gives it; so do {npc:4567} in the {zone:1458} and {npc:3047} in {zone:1456}."] = "La da {npc:7311}, uno de los instructores de magos de {zone:1454}; también {npc:4567} en {zone:1458} y {npc:3047} en {zone:1456}.",
}
