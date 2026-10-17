-- Portuguese (Brazil) (ptBR): the guide forever/class/shaman/call-of-water-horde (forever/class/shaman/call-of-water-horde.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:63} Call of Water
	["{quest:63} (Horde)"] = "{quest:63} (Horda)",
	-- {item:5177} Water Totem · {spell:5394} Healing Stream Totem
	["The {item:5177} that lets you place water totems, and {spell:5394} with it."] = "O {item:5177}, que permite colocar totens de água, e com ele {spell:5394}.",

	-- Step 1: Searn Firewarder
	-- {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom (no name in this language: may be words) · {npc:5901} Islen Waterseer · {zone:1413} Barrens
	["At 20 {npc:5892} in the {object:172957} sends you to {npc:5901} in the {zone:1413}."] = "No nível 20, {npc:5892}, no {object:172957}, envia você a {npc:5901} nos {zone:1413}.",

	-- Step 2: Xanis Flameweaver
	-- {npc:5906} Xanis Flameweaver · {zone:1456} Thunder Bluff · {npc:5901} Islen Waterseer · {zone:1413} Barrens
	["At 20 {npc:5906}, a shaman trainer in {zone:1456}, sends you to {npc:5901} in the {zone:1413}."] = "No nível 20, {npc:5906}, instrutor de xamãs em {zone:1456}, envia você a {npc:5901} nos {zone:1413}.",

	-- Step 3: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} waits on the hill south of {area:392}."] = "{npc:5901} espera na colina ao sul de {area:392}.",

	-- Step 4: Brine
	-- {npc:5899} Brine · {area:378} Camp Taurajo
	["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}."] = "A cabana de {npc:5899} fica na crista acima do bebedouro dos javaligs, ao sul do {area:378}.",
	-- {item:7766} Empty Brown Waterskin
	["Fill the {item:7766} at the quilboar watering hole"] = "Encha o {item:7766} no bebedouro dos javaligs",

	-- Step 5: The Spring Well
	-- {object:107045} Spring Well (no name in this language: may be words)
	["The {object:107045}"] = "{object:107045}",
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {area:272} Tarren Mill · {object:107045} Spring Well (no name in this language: may be words)
	["Take the zeppelin from {zone:1454} to {zone:1420} and travel south to {area:272}. The {object:107045} stands beside the inn."] = "Pegue o zepelim de {zone:1454} para {zone:1420} e viaje para o sul até {area:272}. {object:107045} fica ao lado da estalagem.",
	-- {item:7768} Empty Red Waterskin · {object:107045} Spring Well (no name in this language: may be words)
	["Fill the {item:7768} at the {object:107045}"] = "Encha o {item:7768} em {object:107045}",

	-- Step 7: The Ruins of Stardust
	-- {area:418} The Ruins of Stardust · {zone:1440} Ashenvale
	["The fountain stands in the middle of the {area:418}, in south-western {zone:1440}."] = "A fonte fica no meio das {area:418}, no sudoeste de {zone:1440}.",
	-- {item:7767} Empty Blue Waterskin
	["Fill the {item:7767} at the fountain"] = "Encha o {item:7767} na fonte",

	-- Step 8: Brine
	-- {item:7810} Vial of Purest Water · {npc:5901} Islen Waterseer
	["the {item:7810}, for {npc:5901}"] = "a {item:7810}, para {npc:5901}",

	-- Step 9: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {item:6637} Water Sapta
	["{npc:5901}: your {item:6637}"] = "{npc:5901}: sua {item:6637}",

	-- Step 10: The Brazier of Everfount
	-- {object:113791} Brazier of Everfount
	["The {object:113791}"] = "{object:113791}",
	-- {area:228} Sepulcher · {object:113791} Brazier of Everfount · {item:6637} Water Sapta · {npc:5894} Corrupt Minor Manifestation of Water · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water · {npc:5901} Islen Waterseer
	["Fly to the {area:228}: the {object:113791} stands on the hill just south-west of it. Drink the {item:6637} there, beat the {npc:5894} for its bracers and place them in the brazier, then speak to the {npc:5895} and keep the {item:7813} for {npc:5901}."] = "Voe até {area:228}: o {object:113791} fica na colina logo a sudoeste. Beba a {item:6637} lá, derrote a {npc:5894} para pegar as braçadeiras e coloque-as no braseiro; depois fale com a {npc:5895} e guarde o {item:7813} para {npc:5901}.",

	-- Step 11: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {spell:5394} Healing Stream Totem · {item:5177} Water Totem
	["{npc:5901}: {spell:5394} and your {item:5177}"] = "{npc:5901}: {spell:5394} e seu {item:5177}",
}
