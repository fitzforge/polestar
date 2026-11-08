-- Spanish (Spain) (esES): the guide forever/class/druid/bloodpetal-poison (forever/class/druid/bloodpetal-poison.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Experience in Un'Goro at 50 and two healing potions; the Classic item choice may be gone in Forever."] = "",

	-- Step 1: Loganaar
	-- {zone:1450} Moonglade · {npc:12042} Loganaar · {npc:3033} Turak Runetotem · {npc:4217} Mathrengyl Bearwalker · {zone:1453} Stormwind
	["Cast Teleport: {zone:1450}. {npc:12042} stands in Nighthaven; your class trainer ({npc:3033}, {npc:4217} or Theridran in {zone:1453}) offers the same quest."] = "",

	-- Step 2: Torwa Pathfinder
	-- {zone:1449} Un'Goro Crater · {npc:9619} Torwa Pathfinder
	["Fly to Gadgetzan, ride west to the long ramp down into {zone:1449}: {npc:9619} camps at its foot, in the south-east corner of the crater."] = "",

	-- Step 3: Gorishi Stings and Bloodcap
	-- {item:22434} Bloodcap
	-- plural, as words: Gorishi Stings = {item:22435} Gorishi Sting
	["Gorishi Stings and {item:22434}"] = "Aguijones Gorishi y {item:22434}",
	-- {item:22434} Bloodcap
	-- plural, as words: Gorishi Wasps = {npc:6551} Gorishi Wasp · Bloodpetal Sprouts = {object:164958} Bloodpetal Sprout
	["Eight of each. The Gorishi Wasps and Stingers (level 51-52) in and around the Slithering Scar, the hive in the south-west of the crater, drop a sting about one kill in seven; the wasps share spawn points with the other bugs, so kill whatever stands near you to make room for more wasps (respawn five minutes). The bugs' Silithid Pox makes you take more physical damage for 30 minutes; Workers call for help when hurt. The Bloodpetal Sprouts grow all over the crater (around Marshal's Refuge and the western half): open them, about every other one gives a {item:22434}, back in three to five minutes."] = "",

	-- Step 5: Toxic Test
	-- {item:22432} Devilsaur Barb · {npc:6498} Devilsaur · {npc:6500} Tyrant Devilsaur · {npc:6584} King Mosh
	["Use the {item:22432} on a living {npc:6498} (an Ironhide or {npc:6500}, or {npc:6584}, counts too): they are elite (level 54-55), hit with Mighty Blow and outrun travel form. Grouping up is encouraged, but a druid can do it alone: Hibernate or Entangling Roots it from range, stab it (the barb does not break Hibernate), then leave. The credit counts the moment the barb lands, even if you die after. The nearest roams south-west of Marshal's Refuge."] = "",
	-- {npc:6498} Devilsaur · {item:22432} Devilsaur Barb
	["{npc:6498}: stab it with the {item:22432}"] = "{npc:6498}: apuñálalo con {item:22432}",

	-- Step 7: The Sunken Temple
	["The Sunken Temple"] = "",
	-- {zone:1419} Blasted Lands · {zone:1435} Swamp of Sorrows · {npc:8580} Atal'alarion · {item:22444} Putrid Vine
	["A five-player dungeon: needs a group of five, about level 50-55. Horde: fly to Stonard; Alliance: fly to Nethergarde Keep in the {zone:1419} and ride north. The Temple of Atal'Hakkar stands in the middle of the Pool of Tears in the {zone:1435}: climb the stairs on the ruin's south side, dive into the flooded hall, swim down through it and follow the stairs and passages down to the portal. {npc:8580} (level 50 elite, Sweeping Slam and Ground Tremor) only appears when the six serpent statues on the balcony ring above the altar pit are clicked in order: South, North, South-west, South-east, North-west, North-east (each turns green when right; a wrong order fails). Clear the trash by each statue and the pit below first; jumping down into the water is the quick way down, but a knockback near the edge can kill. The {item:22444} always drops."] = "",
	["The Temple of Atal'Hakkar"] = "",

	-- Step 8: A Better Ingredient
	-- {npc:9619} Torwa Pathfinder · {zone:1449} Un'Goro Crater
	["Back to {npc:9619} in the south-east corner of {zone:1449}."] = "Vuelve con {npc:9619}, en la esquina sureste de {zone:1449}.",
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619}: the old item choice may be gone, count on the experience"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast Teleport: {zone:1450}. {npc:12042} stands in {area:2361}; your class trainer offers the same quest."] = "Lanza Teletransporte: {zone:1450}. {npc:12042} está en {area:2361}; tu instructor de clase ofrece la misma misión.",
	-- ["Cast {spell:18960}. {npc:12042} stands in {area:2361}; your class trainer offers the same quest."] = "Lanza {spell:18960}. {npc:12042} está en {area:2361}; tu instructor de clase ofrece la misma misión.",
	-- ["Experience in Un'Goro at 50 and two healing potions; Forever removed the Classic item choice."] = "Experiencia en Un'Goro a nivel 50 y dos pociones de sanación; Forever eliminó la elección de objeto de Classic.",
	-- ["Fly to {area:976}, ride west to the long ramp down into {zone:1449}: {npc:9619} camps at its foot, in the south-east corner of the crater."] = "Vuela a {area:976} y cabalga al oeste hasta la larga rampa que baja a {zone:1449}: {npc:9619} acampa al pie, en la esquina sureste del cráter.",
	-- ["The Gorishi wasps, workers and reavers of the hive in the south of the crater drop the stings; the Bloodpetal Sprouts that give the {item:22434} grow all over the crater's western half."] = "Las avispas, obreras y atracadoras Gorishi de la colmena del sur del cráter sueltan los aguijones; los Brotes pétalo de sangre que dan {item:22434} crecen por toda la mitad oeste del cráter.",
	-- ["The {area:1417}"] = "El {area:1417}",
	-- ["Use the {item:22432} on a {npc:6498}. Devilsaurs are elite (level 54-55) and roam the crater: grouping up is advised."] = "Usa {item:22432} en un {npc:6498}. Los devilsaurios son élite (nivel 54-55) y recorren el cráter: se recomienda ir en grupo.",
	-- ["{area:1477} lies in the {area:74} in the {zone:1435}. {npc:8580} guards the bottom of the temple: a dungeon boss, so bring a group."] = "{area:1477} está en {area:74}, en {zone:1435}. {npc:8580} guarda el fondo del templo: es un jefe de mazmorra, así que lleva un grupo.",
}
