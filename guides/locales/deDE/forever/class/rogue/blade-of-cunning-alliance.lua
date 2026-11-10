-- German (deDE): the guide forever/class/rogue/blade-of-cunning-alliance (forever/class/rogue/blade-of-cunning-alliance.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7298} Blade of Cunning
	["{item:7298} (Alliance)"] = "{item:7298} (Allianz)",
	["A dagger at 10 from your home town's rogue quests."] = "Ein Dolch auf Stufe 10 aus den Schurkenquests deiner Heimatstadt.",

	-- Step 1: Seek out SI: 7
	-- {npc:917} Keryn Sylvius · {area:87} Goldshire · {npc:332} Master Mathias Shaw · {zone:1453} Stormwind · {spell:921} Pick Pocket
	["At 10 {npc:917}, the rogue trainer upstairs in the Lion's Pride Inn in {area:87}, gives you a package for {npc:332} in {zone:1453}. Train {spell:921} if you lack it: this chain needs it."] = "Mit 10 gibt dir {npc:917}, der Schurkenlehrer oben im Lion's Pride Inn in {area:87}, ein Paket für {npc:332} in {zone:1453}. Lerne {spell:921}, falls du es noch nicht kannst: Diese Questreihe braucht es.",

	-- Step 2: Master Mathias Shaw
	-- {zone:1453} Stormwind · {object:2100} Old Town
	["Head north to {zone:1453}. Shaw stands upstairs in the SI:7 building in {object:2100} (the quest says the Barracks; it means SI:7)."] = "Geh nach Norden nach {zone:1453}. Shaw steht oben im SI:7-Gebäude in {object:2100} (die Quest sagt Kaserne; gemeint ist SI:7).",

	-- Step 3: Defias Dockmaster
	-- {npc:6846} Defias Dockmaster · {area:797} Jerod's Landing · {area:87} Goldshire · {spell:921} Pick Pocket · {spell:2070} Sap
	["The {npc:6846} (level 10, a goblin) works in the dock house at {area:797}, on the river at Elwynn's southern edge, south of {area:87}. Stealth in and {spell:921} him from behind: the schedule never drops from his corpse. Do not open with {spell:2070} or a fight: he calls in three waves of bodyguards. Keep away from the fireplaces in the house; they burn you out of stealth. He is back 2 to 5 minutes after a death."] = "Der {npc:6846} (Stufe 10, ein Goblin) arbeitet im Dockhaus bei {area:797}, am Fluss am südlichen Rand von Elwynn, südlich von {area:87}. Schleiche dich hinein und wende {spell:921} von hinten an ihm an: Der Zeitplan fällt nie von seiner Leiche. Beginne nicht mit {spell:2070} oder einem Kampf: Er ruft drei Wellen Leibwächter. Halte dich von den Kaminen im Haus fern; sie brennen dich aus der Tarnung. Er ist 2 bis 5 Minuten nach einem Tod zurück.",
	-- {spell:921} Pick Pocket · {npc:6846} Defias Dockmaster · {item:7675} Defias Shipping Schedule
	["{spell:921} the {npc:6846} for the {item:7675}"] = "{spell:921} beim {npc:6846} für {item:7675}",

	-- Step 4: Back to Mathias Shaw
	["Back to Mathias Shaw"] = "Zurück zu Mathias Shaw",
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, SI:7"] = "{npc:332}, SI:7",

	-- Step 5: Road to Salvation
	-- {npc:1234} Hogral Bakkan · {area:2102} Thunderbrew Distillery · {area:131} Kharanos · {npc:5165} Hulfdan Blackbeard · {zone:1455} Ironforge
	["At 10 {npc:1234}, the rogue trainer in the {area:2102} in {area:131}, sends you to {npc:5165} in {zone:1455}."] = "Auf Stufe 10 schickt dich {npc:1234}, der Schurkenlehrer in der {area:2102} in {area:131}, zu {npc:5165} in {zone:1455}.",

	-- Step 6: Hulfdan Blackbeard
	-- {npc:5165} Hulfdan Blackbeard · {object:32383} Forlorn Cavern · {zone:1455} Ironforge
	["{npc:5165} is in the {object:32383}, the rogue quarter in the north of {zone:1455}: go into the building with a shady dealer outside and down the stairs."] = "{npc:5165} ist im {object:32383}, dem Schurkenviertel im Norden von {zone:1455}: Geh in das Gebäude mit einem zwielichtigen Händler davor und die Treppe hinunter.",

	-- Step 7: Onin MacHammar
	-- {area:133} Gnomeregan · {npc:6886} Onin MacHammar · {npc:1211} Leper Gnome
	["Head west to {area:133}. Beside the road to its entrance stands a wooden spiral tower: {npc:6886} waits stealthed on the top platform, next to a level 10 {npc:1211}, so you only see him up close."] = "Geh nach Westen nach {area:133}. Neben der Straße zu seinem Eingang steht ein hölzerner Wendelturm: {npc:6886} wartet getarnt auf der obersten Plattform, neben einem {npc:1211} der Stufe 10, sodass du ihn erst aus der Nähe siehst.",

	-- Step 8: Back to Hulfdan Blackbeard
	-- {npc:5165} Hulfdan Blackbeard
	["Back to {npc:5165}"] = "Zurück zu {npc:5165}",

	-- Step 9: The Apple Falls
	-- {npc:3599} Jannok Breezesong · {area:186} Dolanaar · {npc:4163} Syurna · {zone:1457} Darnassus
	["At 10 {npc:3599}, the rogue trainer in the {area:186} inn, gives you a rose for {npc:4163} in {zone:1457}. If you lose the rose, abandon the quest and take it again."] = "Mit 10 gibt dir {npc:3599}, der Schurkenlehrer im Gasthaus von {area:186}, eine Rose für {npc:4163} in {zone:1457}. Wenn du die Rose verlierst, brich die Quest ab und nimm sie erneut an.",

	-- Step 10: Syurna
	-- {zone:1457} Darnassus · {npc:4163} Syurna · {area:1658} Cenarion Enclave
	["Head west to {zone:1457}. {npc:4163} is below ground in the {area:1658}: the way down is the opening at the foot of the split tree left of the Arch Druid's tree, near the nightsaber trainer. Her map marker shows above ground."] = "Geh nach Westen nach {zone:1457}. {npc:4163} ist unter der Erde in der {area:1658}: Der Weg nach unten ist die Öffnung am Fuß des gespaltenen Baums links vom Baum des Erzdruiden, in der Nähe des Nachtsäbler-Lehrers. Ihre Kartenmarkierung erscheint über der Erde.",

	-- Step 11: Sethir the Ancient
	-- {npc:6909} Sethir the Ancient · {area:264} Oracle Glade · {spell:2983} Sprint
	["{npc:6909} (level 12 satyr) lives out on a great branch north of the {area:264}: go through the V-shaped gap in the wall north of the glade and out along the branch. Pick his pocket for the journal; killing him does not give it, and a fight brings out three Minions of Sethir. He walks between the main branch and a side branch: wait stealthed at the far end of the main branch and pick him from behind when he comes back. Then {spell:2983} away. He is back 8 1/2 minutes after a death."] = "{npc:6909} (Satyr der Stufe 12) lebt draußen auf einem großen Ast nördlich von {area:264}: Geh durch die V-förmige Lücke in der Wand nördlich der Lichtung und hinaus auf den Ast. Stiehl ihm das Tagebuch per Taschendiebstahl; ihn zu töten bringt es nicht, und ein Kampf ruft drei Minions of Sethir herbei. Er läuft zwischen dem Hauptast und einem Seitenast hin und her: Warte getarnt am äußersten Ende des Hauptasts und bestiehl ihn von hinten, wenn er zurückkommt. Dann verschwinde mit {spell:2983}. Er ist 8 1/2 Minuten nach einem Tod zurück.",
	-- {item:7737} Sethir's Journal
	["Pick Pocket Sethir the Ancient for {item:7737}"] = "Bestiehl Sethir the Ancient und erhalte {item:7737}",

	-- Step 12: Back to Syurna
	-- {npc:4163} Syurna
	["Back to {npc:4163}"] = "Zurück zu {npc:4163}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10 {npc:3599}, the rogue trainer in {area:186}, gives you a rose for {npc:4163} in {zone:1457}."] = "Auf Stufe 10 gibt dir {npc:3599}, der Schurkenlehrer in {area:186}, eine Rose für {npc:4163} in {zone:1457}.",
	-- ["At 10 {npc:917}, the rogue trainer in the Lion's Pride Inn in {area:87}, gives you a package for {npc:332} in {zone:1453}."] = "Auf Stufe 10 gibt dir {npc:917}, der Schurkenlehrer im Gasthaus „Zur Höhle des Löwen“ in {area:87}, ein Paket für {npc:332} in {zone:1453}.",
	-- ["Head north to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "Geh nach Norden nach {zone:1453}; Mathias Shaw ist bei SI:7 in der {object:2100}.",
	-- ["Head west to {zone:1457}. {npc:4163} stands in the north-west of the city."] = "Geh nach Westen nach {zone:1457}. {npc:4163} steht im Nordwesten der Stadt.",
	-- ["Ride north to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "Reite nach Norden nach {zone:1453}; Mathias Shaw ist bei SI:7 in {object:2100}.",
	-- ["Ride west to {zone:1457}. {npc:4163} stands in the north-west of the city."] = "Reite nach Westen nach {zone:1457}. {npc:4163} steht im Nordwesten der Stadt.",
	-- ["The {npc:6846} stands by the river at Elwynn's southern edge, south of {area:87}. He carries the shipping schedule."] = "Der {npc:6846} steht am Fluss am Südrand des Waldes von Elwynn, südlich von {area:87}. Er trägt den Lieferzeitplan.",
	-- ["{npc:5165} stands in the north of {zone:1455}."] = "{npc:5165} steht im Norden von {zone:1455}.",
	-- ["{npc:6886} waits near {area:133}, in western {zone:1426}."] = "{npc:6886} wartet nahe {area:133}, im westlichen {zone:1426}.",
	-- ["{npc:6909} lives in the north of {zone:1438}, north-east of {zone:1457}. Take his journal."] = "{npc:6909} lebt im Norden von {zone:1438}, nordöstlich von {zone:1457}. Nimm sein Tagebuch.",
}
