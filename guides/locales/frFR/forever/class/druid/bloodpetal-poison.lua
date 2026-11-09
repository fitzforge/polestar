-- French (frFR): the guide forever/class/druid/bloodpetal-poison (forever/class/druid/bloodpetal-poison.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Experience in Un'Goro at 50 and two healing potions; the Classic item choice may be gone in Forever."] = "De l'expérience à Un'Goro au niveau 50 et deux potions de soins ; le choix d'objet de Classic a peut-être disparu dans Forever.",

	-- Step 1: Loganaar
	-- {spell:18960} Teleport: Moonglade · {npc:12042} Loganaar · {area:2361} Nighthaven · {npc:3033} Turak Runetotem · {npc:4217} Mathrengyl Bearwalker · {zone:1453} Stormwind
	["Cast {spell:18960}. {npc:12042} stands in {area:2361}; your class trainer ({npc:3033}, {npc:4217} or Theridran in {zone:1453}) offers the same quest."] = "Lancez {spell:18960}. {npc:12042} se tient à {area:2361} ; votre maître de classe ({npc:3033}, {npc:4217} ou Theridran à {zone:1453}) propose la même quête.",

	-- Step 2: Torwa Pathfinder
	-- {area:976} Gadgetzan · {zone:1449} Un'Goro Crater · {npc:9619} Torwa Pathfinder
	["Fly to {area:976}, ride west to the long ramp down into {zone:1449}: {npc:9619} camps at its foot, in the south-east corner of the crater."] = "Prenez un vol pour {area:976}, puis allez à l'ouest jusqu'à la longue rampe qui descend dans {zone:1449} : {npc:9619} campe à son pied, dans le coin sud-est du cratère.",

	-- Step 3: Gorishi Stings and Bloodcap
	-- {item:22434} Bloodcap
	-- plural, as words: Gorishi Stings = {item:22435} Gorishi Sting
	["Gorishi Stings and {item:22434}"] = "Dards de Gorishi et {item:22434}",
	-- {area:540} Slithering Scar · {spell:8137} Silithid Pox · {area:541} Marshal's Refuge · {item:22434} Bloodcap
	-- plural, as words: Gorishi Wasps = {npc:6551} Gorishi Wasp · Bloodpetal Sprouts = {object:164958} Bloodpetal Sprout
	["Eight of each. The Gorishi Wasps and Stingers (level 51-52) in and around the {area:540}, the hive in the south-west of the crater, drop a sting about one kill in seven; the wasps share spawn points with the other bugs, so kill whatever stands near you to make room for more wasps (respawn five minutes). The bugs' {spell:8137} makes you take more physical damage for 30 minutes; Workers call for help when hurt. The Bloodpetal Sprouts grow all over the crater (around {area:541} and the western half): open them, about every other one gives a {item:22434}, back in three to five minutes."] = "Huit de chaque. Les Guêpes Gorishi et les Dards Gorishi (niveau 51-52), dans et autour de {area:540}, la ruche au sud-ouest du cratère, laissent tomber un dard environ une fois sur sept ; les guêpes partagent leurs points d'apparition avec les autres insectes, alors tuez tout ce qui se trouve près de vous pour faire place à d'autres guêpes (réapparition en cinq minutes). La {spell:8137} des insectes vous fait subir plus de dégâts physiques pendant 30 minutes ; les Ouvriers appellent à l'aide quand ils sont blessés. Les Pousses de Pétale-de-sang poussent dans tout le cratère (autour de {area:541} et dans la moitié ouest) : ouvrez-les, environ une sur deux donne un {item:22434}, elles reviennent en trois à cinq minutes.",

	-- Step 5: Toxic Test
	-- {npc:6498} Devilsaur · {spell:14099} Mighty Blow · {spell:339} Entangling Roots · {item:22432} Devilsaur Barb · {spell:2637} Hibernate · {npc:6499} Ironhide Devilsaur · {npc:9619} Torwa Pathfinder
	-- plural, as words: Tyrant Devilsaurs = {npc:6500} Tyrant Devilsaur · Devilsaurs = {npc:6498} Devilsaur
	["Any {npc:6498} counts, the Ironhide and Tyrant Devilsaurs too. They are elite (level 54-55), hit with {spell:14099} and outrun travel form. Grouping up is encouraged, but a druid can do it alone: Hibernate or {spell:339} it from range, stab it with the {item:22432} (the barb does not break {spell:2637}), then leave. The credit counts the moment the barb lands, even if you die after. The arrow points at the plain Devilsaurs of the west and north; an {npc:6499} roams the middle of the crater's south, nearer {npc:9619}."] = "",
	-- {npc:6498} Devilsaur · {item:22432} Devilsaur Barb
	["{npc:6498}: stab it with the {item:22432}"] = "{npc:6498} : piquez-le avec l'{item:22432}",
	-- {npc:6498} Devilsaur · {item:22432} Devilsaur Barb
	["Stab a {npc:6498} with the {item:22432}"] = "",

	-- Step 7: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "{area:1417}",
	-- {area:75} Stonard · {area:1438} Nethergarde Keep · {zone:1419} Blasted Lands · {area:1477} The Temple of Atal'Hakkar · {area:74} Pool of Tears · {zone:1435} Swamp of Sorrows · {npc:8580} Atal'alarion · {spell:12887} Sweeping Slam · {spell:6524} Ground Tremor · {item:22444} Putrid Vine
	["A five-player dungeon: needs a group of five, about level 50-55. Horde: fly to {area:75}; Alliance: fly to {area:1438} in the {zone:1419} and ride north. {area:1477} stands in the middle of the {area:74} in the {zone:1435}: climb the stairs on the ruin's south side, dive into the flooded hall, swim down through it and follow the stairs and passages down to the portal. {npc:8580} (level 50 elite, {spell:12887} and {spell:6524}) only appears when the six serpent statues on the balcony ring above the altar pit are clicked in order: South, North, South-west, South-east, North-west, North-east (each turns green when right; a wrong order fails). Clear the trash by each statue and the pit below first; jumping down into the water is the quick way down, but a knockback near the edge can kill. The {item:22444} always drops."] = "Un donjon à cinq joueurs : il faut un groupe de cinq, vers le niveau 50-55. Horde : prenez un vol pour {area:75} ; Alliance : prenez un vol pour {area:1438}, dans {zone:1419}, puis chevauchez vers le nord. {area:1477} se dresse au milieu de {area:74}, dans {zone:1435} : montez l'escalier sur le côté sud de la ruine, plongez dans la salle inondée, descendez-la à la nage et suivez les escaliers et les passages jusqu'au portail. {npc:8580} (élite de niveau 50, {spell:12887} et {spell:6524}) n'apparaît que si l'on clique dans l'ordre sur les six statues de serpent du balcon circulaire au-dessus de la fosse de l'autel : sud, nord, sud-ouest, sud-est, nord-ouest, nord-est (chacune devient verte quand c'est juste ; un mauvais ordre échoue). Nettoyez d'abord les monstres près de chaque statue et dans la fosse en dessous ; sauter dans l'eau est le chemin le plus rapide pour descendre, mais un repoussement près du bord peut tuer. La {item:22444} tombe toujours.",

	-- Step 8: A Better Ingredient
	-- {npc:9619} Torwa Pathfinder · {zone:1449} Un'Goro Crater
	["Back to {npc:9619} in the south-east corner of {zone:1449}."] = "Retournez voir {npc:9619} dans le coin sud-est de {zone:1449}.",
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619}: the old item choice may be gone, count on the experience"] = "{npc:9619} : l'ancien choix d'objet a peut-être disparu, comptez sur l'expérience",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast Teleport: {zone:1450}. {npc:12042} stands in {area:2361}; your class trainer offers the same quest."] = "Lancez Téléportation : {zone:1450}. {npc:12042} se tient à {area:2361} ; votre maître de classe propose la même quête.",
	-- ["Cast {spell:18960}. {npc:12042} stands in {area:2361}; your class trainer offers the same quest."] = "Lancez {spell:18960}. {npc:12042} se tient à {area:2361} ; votre maître de classe propose la même quête.",
	-- ["Experience in Un'Goro at 50 and two healing potions; Forever removed the Classic item choice."] = "De l'expérience à Un'Goro au niveau 50 et deux potions de soins ; Forever a retiré le choix d'objet de Classic.",
	-- ["The Gorishi wasps, workers and reavers of the hive in the south of the crater drop the stings; the Bloodpetal Sprouts that give the {item:22434} grow all over the crater's western half."] = "Les Guêpes, Ouvriers et Ravageurs Gorishi de la ruche au sud du cratère laissent tomber les dards ; les Pousses de Pétale-de-sang qui donnent le {item:22434} poussent dans toute la moitié ouest du cratère.",
	-- ["Use the {item:22432} on a living {npc:6498} (an Ironhide or {npc:6500}, or {npc:6584}, counts too): they are elite (level 54-55), hit with {spell:14099} and outrun travel form. Grouping up is encouraged, but a druid can do it alone: Hibernate or {spell:339} it from range, stab it (the barb does not break {spell:2637}), then leave. The credit counts the moment the barb lands, even if you die after. The nearest roams south-west of {area:541}."] = "Utilisez l'{item:22432} sur un {npc:6498} vivant (un Diablosaure Cuiracier, un {npc:6500} ou {npc:6584} comptent aussi) : ils sont élites (niveau 54-55), frappent avec {spell:14099} et distancent la forme de voyage. Mieux vaut être en groupe, mais un druide peut le faire seul : Hibernation ou {spell:339} à distance, piquez-le (l'aiguillon ne rompt pas {spell:2637}), puis partez. Le crédit compte dès que l'aiguillon touche, même si vous mourez ensuite. Le plus proche rôde au sud-ouest de {area:541}.",
	-- ["Use the {item:22432} on a {npc:6498}. Devilsaurs are elite (level 54-55) and roam the crater: grouping up is advised."] = "Utilisez l'{item:22432} sur un {npc:6498}. Les Diablosaures sont élites (niveau 54-55) et parcourent le cratère : un groupe est conseillé.",
	-- ["{area:1477} lies in the {area:74} in the {zone:1435}. {npc:8580} guards the bottom of the temple: a dungeon boss, so bring a group."] = "{area:1477} se trouve dans {area:74}, dans {zone:1435}. {npc:8580} garde le fond du temple : c'est un boss de donjon, venez en groupe.",
}
