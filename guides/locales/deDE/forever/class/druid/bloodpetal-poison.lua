-- German (deDE): the guide forever/class/druid/bloodpetal-poison (forever/class/druid/bloodpetal-poison.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Experience in Un'Goro at 50 and two healing potions; the Classic item choice may be gone in Forever."] = "Erfahrung in Un'Goro bei Stufe 50 und zwei Heiltränke; die Classic-Gegenstandsauswahl gibt es in Forever womöglich nicht mehr.",

	-- Step 1: Loganaar
	-- {spell:18960} Teleport: Moonglade · {npc:12042} Loganaar · {area:2361} Nighthaven · {npc:3033} Turak Runetotem · {npc:4217} Mathrengyl Bearwalker · {zone:1453} Stormwind
	["Cast {spell:18960}. {npc:12042} stands in {area:2361}; your class trainer ({npc:3033}, {npc:4217} or Theridran in {zone:1453}) offers the same quest."] = "Wirke {spell:18960}. {npc:12042} steht in {area:2361}; dein Klassenlehrer ({npc:3033}, {npc:4217} oder Theridran in {zone:1453}) bietet dieselbe Quest an.",

	-- Step 2: Torwa Pathfinder
	-- {area:976} Gadgetzan · {zone:1449} Un'Goro Crater · {npc:9619} Torwa Pathfinder
	["Fly to {area:976}, ride west to the long ramp down into {zone:1449}: {npc:9619} camps at its foot, in the south-east corner of the crater."] = "Flieg nach {area:976} und reite nach Westen zur langen Rampe hinab in den {zone:1449}: {npc:9619} lagert an ihrem Fuß, in der Südostecke des Kraters.",

	-- Step 3: Gorishi Stings and Bloodcap
	-- {item:22434} Bloodcap
	-- plural, as words: Gorishi Stings = {item:22435} Gorishi Sting
	["Gorishi Stings and {item:22434}"] = "Gorishistachel und {item:22434}",
	-- {area:540} Slithering Scar · {spell:8137} Silithid Pox · {area:541} Marshal's Refuge · {item:22434} Bloodcap
	-- plural, as words: Gorishi Wasps = {npc:6551} Gorishi Wasp · Bloodpetal Sprouts = {object:164958} Bloodpetal Sprout
	["Eight of each. The Gorishi Wasps and Stingers (level 51-52) in and around the {area:540}, the hive in the south-west of the crater, drop a sting about one kill in seven; the wasps share spawn points with the other bugs, so kill whatever stands near you to make room for more wasps (respawn five minutes). The bugs' {spell:8137} makes you take more physical damage for 30 minutes; Workers call for help when hurt. The Bloodpetal Sprouts grow all over the crater (around {area:541} and the western half): open them, about every other one gives a {item:22434}, back in three to five minutes."] = "Je acht. Die Gorishi Wasps und Stingers (Stufe 51-52) in und um {area:540}, den Bienenstock im Südwesten des Kraters, lassen etwa bei jedem siebten Kill einen Stachel fallen; die Wespen teilen sich Spawnpunkte mit den anderen Käfern, also töte alles in deiner Nähe, damit mehr Wespen nachspawnen (Respawn fünf Minuten). Die {spell:8137} der Käfer lässt dich 30 Minuten lang mehr körperlichen Schaden erleiden; Arbeiter rufen bei Verletzung um Hilfe. Die Bloodpetal Sprouts wachsen überall im Krater (um {area:541} und in der westlichen Hälfte): Öffne sie, etwa jeder zweite gibt {item:22434}, nach drei bis fünf Minuten sind sie wieder da.",

	-- Step 5: Toxic Test
	-- {npc:6498} Devilsaur · {spell:14099} Mighty Blow · {spell:339} Entangling Roots · {item:22432} Devilsaur Barb · {spell:2637} Hibernate · {npc:6499} Ironhide Devilsaur · {npc:9619} Torwa Pathfinder
	-- plural, as words: Tyrant Devilsaurs = {npc:6500} Tyrant Devilsaur · Devilsaurs = {npc:6498} Devilsaur
	["Any {npc:6498} counts, the Ironhide and Tyrant Devilsaurs too. They are elite (level 54-55), hit with {spell:14099} and outrun travel form. Grouping up is encouraged, but a druid can do it alone: Hibernate or {spell:339} it from range, stab it with the {item:22432} (the barb does not break {spell:2637}), then leave. The credit counts the moment the barb lands, even if you die after. The arrow points at the plain Devilsaurs of the west and north; an {npc:6499} roams the middle of the crater's south, nearer {npc:9619}."] = "Jeder {npc:6498} zählt, auch die Ironhide- und Tyrant-Teufelssaurier. Sie sind Elite (Stufe 54-55), schlagen mit {spell:14099} zu und sind schneller als die Reisegestalt. Sich zu gruppieren wird empfohlen, aber ein Druide schafft es auch allein: Lass ihn aus der Ferne mit Winterschlaf oder {spell:339} ausschalten, stich ihn mit {item:22432} (der Stachel unterbricht {spell:2637} nicht), dann geh. Das Ziel zählt in dem Moment, in dem der Stachel trifft, auch wenn du danach stirbst. Der Pfeil zeigt auf die einfachen Teufelssaurier im Westen und Norden; ein {npc:6499} streift durch die Mitte des Kratersüdens, näher an {npc:9619}.",
	-- {npc:6498} Devilsaur · {item:22432} Devilsaur Barb
	["{npc:6498}: stab it with the {item:22432}"] = "{npc:6498}: Stich ihn mit {item:22432}",
	-- {npc:6498} Devilsaur · {item:22432} Devilsaur Barb
	["Stab a {npc:6498} with the {item:22432}"] = "Stich einen {npc:6498} mit {item:22432}",

	-- Step 7: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "{area:1417}",
	-- {area:75} Stonard · {area:1438} Nethergarde Keep · {zone:1419} Blasted Lands · {area:1477} The Temple of Atal'Hakkar · {area:74} Pool of Tears · {zone:1435} Swamp of Sorrows · {npc:8580} Atal'alarion · {spell:12887} Sweeping Slam · {spell:6524} Ground Tremor · {item:22444} Putrid Vine
	["A five-player dungeon: needs a group of five, about level 50-55. Horde: fly to {area:75}; Alliance: fly to {area:1438} in the {zone:1419} and ride north. {area:1477} stands in the middle of the {area:74} in the {zone:1435}: climb the stairs on the ruin's south side, dive into the flooded hall, swim down through it and follow the stairs and passages down to the portal. {npc:8580} (level 50 elite, {spell:12887} and {spell:6524}) only appears when the six serpent statues on the balcony ring above the altar pit are clicked in order: South, North, South-west, South-east, North-west, North-east (each turns green when right; a wrong order fails). Clear the trash by each statue and the pit below first; jumping down into the water is the quick way down, but a knockback near the edge can kill. The {item:22444} always drops."] = "Ein Dungeon für fünf Spieler: Du brauchst eine Gruppe aus fünf, etwa Stufe 50-55. Horde: Flieg nach {area:75}; Allianz: Flieg nach {area:1438} in {zone:1419} und reite nach Norden. {area:1477} liegt mitten in {area:74} in {zone:1435}: Steig die Treppe an der Südseite der Ruine hinauf, tauch in die geflutete Halle, schwimm durch sie nach unten und folge den Treppen und Gängen hinab zum Portal. {npc:8580} (Elite der Stufe 50, {spell:12887} und {spell:6524}) erscheint erst, wenn die sechs Schlangenstatuen auf dem Balkonring über der Altargrube der Reihe nach angeklickt werden: Süden, Norden, Südwesten, Südosten, Nordwesten, Nordosten (jede leuchtet grün, wenn sie stimmt; eine falsche Reihenfolge scheitert). Räum zuerst den Trash bei jeder Statue und die Grube darunter; der Sprung ins Wasser ist der schnelle Weg nach unten, aber ein Rückstoß nahe der Kante kann tödlich sein. {item:22444} fällt immer.",

	-- Step 8: A Better Ingredient
	-- {npc:9619} Torwa Pathfinder · {zone:1449} Un'Goro Crater
	["Back to {npc:9619} in the south-east corner of {zone:1449}."] = "Zurück zu {npc:9619} in der Südostecke des {zone:1449}.",
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619}: the old item choice may be gone, count on the experience"] = "{npc:9619}: Die alte Gegenstandsauswahl gibt es womöglich nicht mehr, rechne mit der Erfahrung",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast {spell:18960}. {npc:12042} stands in {area:2361}; your class trainer offers the same quest."] = "Wirke {spell:18960}. {npc:12042} steht in {area:2361}; dein Klassenlehrer bietet dieselbe Quest an.",
	-- ["Experience in Un'Goro at 50 and two healing potions; Forever removed the Classic item choice."] = "Erfahrung in Un'Goro mit 50 und zwei Heiltränke; Forever hat die Gegenstandswahl aus Classic entfernt.",
	-- ["The Gorishi wasps, workers and reavers of the hive in the south of the crater drop the stings; the Bloodpetal Sprouts that give the {item:22434} grow all over the crater's western half."] = "Die Wespen, Arbeiter und Häscher der Gorishi im Stock im Süden des Kraters lassen die Stachel fallen; die Blutblütensprösslinge, die {item:22434} geben, wachsen überall in der Westhälfte des Kraters.",
	-- ["Use the {item:22432} on a {npc:6498}. Devilsaurs are elite (level 54-55) and roam the crater: grouping up is advised."] = "Benutze {item:22432} an einem {npc:6498}. Teufelssaurier sind Elite (Stufe 54-55) und streifen durch den Krater: Eine Gruppe wird empfohlen.",
	-- ["{area:1477} lies in the {area:74} in the {zone:1435}. {npc:8580} guards the bottom of the temple: a dungeon boss, so bring a group."] = "{area:1477} liegt im {area:74} in den {zone:1435}. {npc:8580} bewacht den Grund des Tempels: ein Dungeonboss, also bring eine Gruppe mit.",
}
