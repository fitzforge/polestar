-- German (deDE): the guide forever/horde/50-60/04-azshara (forever/horde/50-60/04-azshara.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Orgrimmar
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659}, the {object:172960}"] = "{npc:8659}, {object:172960}",
	-- {npc:15188} Cenarion Emissary Blackhoof · {object:172957} Valley of Wisdom · {zone:1451} Silithus
	["{npc:15188}, {object:172957}: keep it for {zone:1451}"] = "{npc:15188}, {object:172957}: Behalte sie für {zone:1451}",

	-- Step 2: Fly to the Crossroads
	-- {area:380} Crossroads
	["Fly to the {area:380}"] = "Flieg nach {area:380}",

	-- Step 3: Dokimi's crates
	-- {npc:256386} Dokimi
	["{npc:256386}'s crates"] = "Kisten von {npc:256386}",
	-- {npc:256386} Dokimi · {area:380} Crossroads
	["{npc:256386} stands in the {area:380}. Open each crate she hands you and bring back what is inside."] = "{npc:256386} steht in {area:380}. Öffne jede Kiste, die sie dir gibt, und bring zurück, was darin ist.",

	-- Step 4: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Flieg nach {area:392}",

	-- Step 5: Liv Rizzlefix
	-- {area:392} Ratchet · {object:149036} Marvon's Chest
	["Liv's workshop is at the north end of {area:392}'s docks; {object:149036} stands inside it."] = "Livs Werkstatt ist am Nordende der Docks von {area:392}; {object:149036} steht darin.",

	-- Step 6: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} camps on the shore just north of {area:392}."] = "{npc:5901} lagert am Ufer gleich nördlich von {area:392}.",
	-- {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Cleansed Water goes to the {area:2479} in {zone:1448}: keep it for later."] = "Das gereinigte Wasser geht zum {area:2479} im {zone:1448}: Behalte es für später.",

	-- Step 7: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Flieg nach {area:1637}",

	-- Step 8: Vehena
	-- {object:172961} Valley of Spirits
	["In the {object:172961}. Have the Wool, Silk and Mageweave in your bags."] = "Im {object:172961}. Hab Wolle, Seide und Magiestoff in deinen Taschen.",

	-- Step 9: Rashona Straglash
	-- {object:172958} Valley of Honor
	["In the {object:172958}."] = "Im {object:172958}.",
	-- {item:14047} Runecloth
	["Both {item:14047} donations are handed in later in the route: start saving {item:14047}."] = "Beide Spenden von {item:14047} gibst du später auf der Route ab: Fang an, {item:14047} zu sammeln.",

	-- Step 10: Fly to Valormok
	-- {area:1237} Valormok
	["Fly to {area:1237}"] = "Flieg nach {area:1237}",

	-- Step 12: Ruins of Eldarath
	["Ride east to the ruins on the coast. Fill Cuely's four vials at the tide pools along the shore; Spitelash naga patrol between them."] = "Reite nach Osten zu den Ruinen an der Küste. Füll Cuelys vier Phiolen an den Gezeitentümpeln am Ufer; Naga der Grollflossen patrouillieren dazwischen.",

	-- Step 13: Thalassian Base Camp
	-- {area:1227} Bay of Storms
	["The blood elves camp on the cliffs in the north-east, by the {area:1227}."] = "Die Blutelfen lagern auf den Klippen im Nordosten, an der {area:1227}.",

	-- Step 14: Magus Rimtori's camp
	-- {npc:8578} Magus Rimtori
	["{npc:8578}'s camp"] = "Lager von {npc:8578}",
	-- {object:151286} Kaldorei Tome of Summoning
	["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there, then kill the Magus."] = "Rimtoris Lager ist am Ostende des Stützpunkts. Lies dort {object:151286} und töte dann den Magus.",

	-- Step 15: Ag'tor Bloodfist
	-- {area:1237} Valormok
	["Ride back west to {area:1237}."] = "Reite zurück nach Westen nach {area:1237}.",

	-- Step 16: Belgrom Rockmaul
	-- {area:1637} Orgrimmar · {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["Fly to {area:1637}; {npc:4485} is in the {object:172958}."] = "Flieg nach {area:1637}; {npc:4485} ist im {object:172958}.",

	-- Step 17: Zeppelin to the Undercity
	-- {zone:1458} Undercity
	["Zeppelin to the {zone:1458}"] = "Zeppelin nach {zone:1458}",
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity
	["The zeppelin tower stands just north-east of {zone:1454}'s main gate; take the {zone:1458} zeppelin."] = "Der Zeppelinturm steht gleich nordöstlich des Haupttors von {zone:1454}; nimm den Zeppelin nach {zone:1458}.",
	["Zeppelin tower"] = "Zeppelinturm",

	-- Step 18: The Apothecarium
	-- {npc:8393} Thersa Windsong
	["{npc:8393}, beside him"] = "{npc:8393}, neben ihm",

	-- Step 19: Royal Quarter
	-- {npc:8403} Jeremiah Payson
	["{npc:8403}, nearby"] = "{npc:8403}, in der Nähe",
	-- {quest:5050} Good Luck Charm · {npc:10778} Janice Felstone · {zone:1422} Western Plaguelands
	["{quest:5050} goes back to {npc:10778} in the {zone:1422}: keep it."] = "{quest:5050} geht zurück zu {npc:10778} in den {zone:1422}: Behalte sie.",

	-- Step 20: Owen Thadd
	-- {quest:79095} The Apothecary's Metaphysical Primer · {area:159} Brill
	-- plural, as words: Library Books = {object:386691} Library Book
	["Only with {quest:79095} from {area:159}'s alchemy shop in your bags (the Library Books guide)"] = "Nur mit {quest:79095} aus dem Alchemieladen von {area:159} in deinen Taschen (der Guide Bibliotheksbücher)",

	-- Step 21: Prompt Potion Runner
	-- {npc:11044} Doctor Martin Felben
	["{npc:11044}, in the Apothecarium"] = "{npc:11044}, im Apothekarium",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Open {object:149036} for the {item:10556}"] = "Öffne {object:149036} für {item:10556}",
}
