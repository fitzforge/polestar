-- Spanish (Spain) (esES): the guide forever/class/druid/bloodpetal-poison (forever/class/druid/bloodpetal-poison.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Experience in Un'Goro at 50 and two healing potions; the Classic item choice may be gone in Forever."] = "Experiencia en Un'Goro a nivel 50 y dos pociones de sanación; puede que Forever haya eliminado la elección de objeto de Classic.",

	-- Step 1: Loganaar
	-- {spell:18960} Teleport: Moonglade · {npc:12042} Loganaar · {area:2361} Nighthaven · {npc:3033} Turak Runetotem · {npc:4217} Mathrengyl Bearwalker · {zone:1453} Stormwind
	["Cast {spell:18960}. {npc:12042} stands in {area:2361}; your class trainer ({npc:3033}, {npc:4217} or Theridran in {zone:1453}) offers the same quest."] = "Lanza {spell:18960}. {npc:12042} está en {area:2361}; tu instructor de clase ({npc:3033}, {npc:4217} o Theridran en {zone:1453}) ofrece la misma misión.",

	-- Step 2: Torwa Pathfinder
	-- {area:976} Gadgetzan · {zone:1449} Un'Goro Crater · {npc:9619} Torwa Pathfinder
	["Fly to {area:976}, ride west to the long ramp down into {zone:1449}: {npc:9619} camps at its foot, in the south-east corner of the crater."] = "Vuela a {area:976} y cabalga al oeste hasta la larga rampa que baja a {zone:1449}: {npc:9619} acampa al pie, en la esquina sureste del cráter.",

	-- Step 3: Gorishi Stings and Bloodcap
	-- {item:22434} Bloodcap
	-- plural, as words: Gorishi Stings = {item:22435} Gorishi Sting
	["Gorishi Stings and {item:22434}"] = "Aguijones Gorishi y {item:22434}",
	-- {area:540} Slithering Scar · {spell:8137} Silithid Pox · {area:541} Marshal's Refuge · {item:22434} Bloodcap
	-- plural, as words: Gorishi Wasps = {npc:6551} Gorishi Wasp · Bloodpetal Sprouts = {object:164958} Bloodpetal Sprout
	["Eight of each. The Gorishi Wasps and Stingers (level 51-52) in and around the {area:540}, the hive in the south-west of the crater, drop a sting about one kill in seven; the wasps share spawn points with the other bugs, so kill whatever stands near you to make room for more wasps (respawn five minutes). The bugs' {spell:8137} makes you take more physical damage for 30 minutes; Workers call for help when hurt. The Bloodpetal Sprouts grow all over the crater (around {area:541} and the western half): open them, about every other one gives a {item:22434}, back in three to five minutes."] = "Ocho de cada. Los avispas y aguijoneros Gorishi (51-52) dentro y alrededor del {area:540}, el panal al suroeste del cráter, sueltan un aguijón en unos siete tiroteos; las avispas comparten puntos de aparición con los demás bichos, así que mata lo que tengas cerca para dejar sitio a más avispas (reaparecen a los cinco minutos). El {spell:8137} de los bichos te hace recibir más daño físico durante 30 minutos; los obreros piden ayuda cuando sufren. Los brotes de Pétalo Sangriento crecen por todo el cráter (alrededor del {area:541} y la mitad oeste): ábrelos, uno de cada dos da un {item:22434}, y vuelven en tres a cinco minutos.",

	-- Step 5: Toxic Test
	-- {spell:14099} Mighty Blow · {spell:339} Entangling Roots · {item:22432} Devilsaur Barb · {spell:2637} Hibernate · {npc:6499} Ironhide Devilsaur · {npc:9619} Torwa Pathfinder
	-- plural, as words: Tyrant Devilsaurs = {npc:6500} Tyrant Devilsaur
	-- was: ["Any {npc:6498} counts, the Ironhide and Tyrant Devilsaurs too. They are elite (level 54-55), hit with {spell:14099} and outrun travel form. Grouping up is encouraged, but a druid can do it alone: Hibernate or {spell:339} it from range, stab it with the {item:22432} (the barb does not break {spell:2637}), then leave. The credit counts the moment the barb lands, even if you die after. The arrow points at the plain Devilsaurs of the west and north; an {npc:6499} roams the middle of the crater's south, nearer {npc:9619}."] = "Sirve cualquier {npc:6498}, también los acorazados de hierro y los demosaurios tiranos. Son élite (54-55), pegan con {spell:14099} y superan a la forma de viaje. Se anima a ir en grupo, pero un druida puede hacerlo solo: Hibernate o {spell:339} a distancia, apuñálalo con el {item:22432} (la púa no rompe {spell:2637}) y marcha. El crédito cuenta en el momento en que la púa impacta, aunque mueras después. La flecha señala los demosaurios del oeste y el norte; un {npc:6499} vaga por el centro del sur del cráter, más cerca de {npc:9619}."
	["Any Devilsaur counts, the Ironhide and Tyrant Devilsaurs too. They are elite (level 54-55), hit with {spell:14099} and outrun travel form. Grouping up is encouraged, but a druid can do it alone: Hibernate or {spell:339} it from range, stab it with the {item:22432} (the barb does not break {spell:2637}), then leave. The credit counts the moment the barb lands, even if you die after. The arrow points at the plain Devilsaurs of the west and north; an {npc:6499} roams the middle of the crater's south, nearer {npc:9619}."] = "",
	-- {item:22432} Devilsaur Barb
	-- was: ["{npc:6498}: stab it with the {item:22432}"] = "{npc:6498}: apuñálalo con {item:22432}"
	["Devilsaur: stab it with the {item:22432}"] = "",
	-- {item:22432} Devilsaur Barb
	["Stab a Devilsaur with the {item:22432}"] = "",

	-- Step 7: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "El {area:1417}",
	-- {area:75} Stonard · {area:1438} Nethergarde Keep · {zone:1419} Blasted Lands · {area:1477} The Temple of Atal'Hakkar · {area:74} Pool of Tears · {zone:1435} Swamp of Sorrows · {npc:8580} Atal'alarion · {spell:12887} Sweeping Slam · {spell:6524} Ground Tremor · {item:22444} Putrid Vine
	["A five-player dungeon: needs a group of five, about level 50-55. Horde: fly to {area:75}; Alliance: fly to {area:1438} in the {zone:1419} and ride north. {area:1477} stands in the middle of the {area:74} in the {zone:1435}: climb the stairs on the ruin's south side, dive into the flooded hall, swim down through it and follow the stairs and passages down to the portal. {npc:8580} (level 50 elite, {spell:12887} and {spell:6524}) only appears when the six serpent statues on the balcony ring above the altar pit are clicked in order: South, North, South-west, South-east, North-west, North-east (each turns green when right; a wrong order fails). Clear the trash by each statue and the pit below first; jumping down into the water is the quick way down, but a knockback near the edge can kill. The {item:22444} always drops."] = "Una mazmorra de cinco: hace falta un grupo de cinco, de nivel 50-55. Horda: vuela a {area:75}; Alianza: vuela al {area:1438} en el {zone:1419} y cabalga hacia el norte. El {area:1477} está en medio del {area:74} en el {zone:1435}: sube las escaleras del lado sur de la ruina, zambúllete en el salón inundado, nada a través de él y sigue las escaleras y pasadizos hasta el portal. {npc:8580} (50, élite, {spell:12887} y {spell:6524}) solo aparece cuando se pulsan en orden las seis estatuas de serpiente del balcón sobre el foso del altar: Sur, Norte, Suroeste, Sureste, Noroeste, Noreste (cada una se vuelve verde al acertar; un orden equivocado falla). Limpia los esbirros de cada estatua y el foso de abajo primero; saltar al agua es la forma rápida de bajar, pero un empujón cerca del borde puede matarte. El {item:22444} siempre cae.",

	-- Step 8: A Better Ingredient
	-- {npc:9619} Torwa Pathfinder · {zone:1449} Un'Goro Crater
	["Back to {npc:9619} in the south-east corner of {zone:1449}."] = "Vuelve con {npc:9619}, en la esquina sureste de {zone:1449}.",
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619}: the old item choice may be gone, count on the experience"] = "{npc:9619}: la vieja elección de objeto puede haber desaparecido, cuenta con la experiencia",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {npc:6498} counts, the Ironhide and Tyrant Devilsaurs too. They are elite (level 54-55), hit with {spell:14099} and outrun travel form. Grouping up is encouraged, but a druid can do it alone: Hibernate or {spell:339} it from range, stab it with the {item:22432} (the barb does not break {spell:2637}), then leave. The credit counts the moment the barb lands, even if you die after. The arrow points at the plain Devilsaurs of the west and north; an {npc:6499} roams the middle of the crater's south, nearer {npc:9619}."] = "Sirve cualquier {npc:6498}, también los acorazados de hierro y los demosaurios tiranos. Son élite (54-55), pegan con {spell:14099} y superan a la forma de viaje. Se anima a ir en grupo, pero un druida puede hacerlo solo: Hibernate o {spell:339} a distancia, apuñálalo con el {item:22432} (la púa no rompe {spell:2637}) y marcha. El crédito cuenta en el momento en que la púa impacta, aunque mueras después. La flecha señala los demosaurios del oeste y el norte; un {npc:6499} vaga por el centro del sur del cráter, más cerca de {npc:9619}.",
	-- ["Cast {spell:18960}. {npc:12042} stands in {area:2361}; your class trainer offers the same quest."] = "Lanza {spell:18960}. {npc:12042} está en {area:2361}; tu instructor de clase ofrece la misma misión.",
	-- ["Stab a {npc:6498} with the {item:22432}"] = "Apuñala a un {npc:6498} con el {item:22432}",
	-- ["The Gorishi wasps, workers and reavers of the hive in the south of the crater drop the stings; the Bloodpetal Sprouts that give the {item:22434} grow all over the crater's western half."] = "Las avispas, obreras y atracadoras Gorishi de la colmena del sur del cráter sueltan los aguijones; los Brotes pétalo de sangre que dan {item:22434} crecen por toda la mitad oeste del cráter.",
	-- ["Use the {item:22432} on a {npc:6498}. Devilsaurs are elite (level 54-55) and roam the crater: grouping up is advised."] = "Usa {item:22432} en un {npc:6498}. Los devilsaurios son élite (nivel 54-55) y recorren el cráter: se recomienda ir en grupo.",
	-- ["{area:1477} lies in the {area:74} in the {zone:1435}. {npc:8580} guards the bottom of the temple: a dungeon boss, so bring a group."] = "{area:1477} está en {area:74}, en {zone:1435}. {npc:8580} guarda el fondo del templo: es un jefe de mazmorra, así que lleva un grupo.",
	-- ["{npc:6498}: stab it with the {item:22432}"] = "{npc:6498}: apuñálalo con {item:22432}",
}
