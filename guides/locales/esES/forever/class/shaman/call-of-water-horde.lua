-- Spanish (Spain) (esES): the guide forever/class/shaman/call-of-water-horde (forever/class/shaman/call-of-water-horde.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:63} Call of Water
	["{quest:63} (Horde)"] = "{quest:63} (Horda)",
	-- {item:5177} Water Totem · {spell:5394} Healing Stream Totem
	["The {item:5177} that lets you place water totems, and {spell:5394} with it."] = "{item:5177}, que te permite colocar tótems de agua, y con él {spell:5394}.",

	-- Step 1: Searn Firewarder
	-- {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom · {npc:5901} Islen Waterseer · {zone:1413} Barrens
	["At 20 {npc:5892} in the {object:172957} sends you to {npc:5901} in the {zone:1413}."] = "A nivel 20, {npc:5892}, en el {object:172957}, te envía con {npc:5901} en {zone:1413}.",

	-- Step 2: Xanis Flameweaver
	-- {npc:5906} Xanis Flameweaver · {zone:1456} Thunder Bluff · {npc:5901} Islen Waterseer · {zone:1413} Barrens
	["At 20 {npc:5906}, a shaman trainer in {zone:1456}, sends you to {npc:5901} in the {zone:1413}."] = "A nivel 20, {npc:5906}, instructora de chamanes en {zone:1456}, te envía con {npc:5901} en {zone:1413}.",

	-- Step 3: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} waits on the hill south of {area:392}."] = "{npc:5901} espera en la colina al sur de {area:392}.",

	-- Step 4: Brine
	-- {npc:5899} Brine · {area:378} Camp Taurajo
	["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}."] = "La choza de {npc:5899} está en la loma sobre el abrevadero de los jabaespines, al sur del {area:378}.",
	-- {item:7766} Empty Brown Waterskin
	["Fill the {item:7766} at the quilboar watering hole"] = "Llena {item:7766} en el abrevadero de los jabaespines",

	-- Step 5: The Spring Well
	-- {object:107045} Spring Well
	["The {object:107045}"] = "{object:107045}",
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {area:272} Tarren Mill · {object:107045} Spring Well
	["Take the zeppelin from {zone:1454} to {zone:1420} and travel south to {area:272}. The {object:107045} stands beside the inn."] = "Toma el zepelín de {zone:1454} a {zone:1420} y viaja al sur hasta {area:272}. {object:107045} está junto a la posada.",
	-- {item:7768} Empty Red Waterskin · {object:107045} Spring Well
	["Fill the {item:7768} at the {object:107045}"] = "Llena {item:7768} en {object:107045}",

	-- Step 7: The Ruins of Stardust
	-- {area:418} The Ruins of Stardust · {zone:1440} Ashenvale
	["The fountain stands in the middle of the {area:418}, in south-western {zone:1440}."] = "La fuente está en el centro de {area:418}, en el suroeste de {zone:1440}.",
	-- {item:7767} Empty Blue Waterskin
	["Fill the {item:7767} at the fountain"] = "Llena {item:7767} en la fuente",

	-- Step 8: Brine
	-- {item:7810} Vial of Purest Water · {npc:5901} Islen Waterseer
	["the {item:7810}, for {npc:5901}"] = "{item:7810}, para {npc:5901}",

	-- Step 9: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {item:6637} Water Sapta
	["{npc:5901}: your {item:6637}"] = "{npc:5901}: tu {item:6637}",

	-- Step 10: The Brazier of Everfount
	-- {object:113791} Brazier of Everfount
	["The {object:113791}"] = "{object:113791}",
	-- {area:228} Sepulcher · {object:113791} Brazier of Everfount · {item:6637} Water Sapta · {npc:5894} Corrupt Minor Manifestation of Water · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water · {npc:5901} Islen Waterseer
	["Fly to the {area:228}: the {object:113791} stands on the hill just south-west of it. Drink the {item:6637} there, beat the {npc:5894} for its bracers and place them in the brazier, then speak to the {npc:5895} and keep the {item:7813} for {npc:5901}."] = "Vuela a {area:228}: {object:113791} está en la colina justo al suroeste. Bebe allí {item:6637}, derrota a la {npc:5894} para conseguir sus brazales y ponlos en el blandón; luego habla con la {npc:5895} y guarda {item:7813} para {npc:5901}.",

	-- Step 11: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {spell:5394} Healing Stream Totem · {item:5177} Water Totem
	["{npc:5901}: {spell:5394} and your {item:5177}"] = "{npc:5901}: {spell:5394} y tu {item:5177}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The fountain stands in the middle of the {area:418}, in south-western {zone:1440}."] = "La fuente está en el centro de {area:418}, en el suroeste de {zone:1440}.",
}
