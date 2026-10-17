-- German (deDE): the guide forever/class/mage/mages-wand (forever/class/mage/mages-wand.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A wand of your school for the 30s: frost, arcane or fire."] = "Ein Zauberstab deiner Schule für Stufe 30+: Frost, Arkan oder Feuer.",

	-- Step 1: Journey to the Marsh (Stormwind)
	-- {npc:5497} Jennea Cannon · {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:6546} Tabetha · {zone:1455} Ironforge
	["{npc:5497} in the Wizard's Sanctum, {zone:1453}'s {object:2101}, sends you to {npc:6546}; Bink in {zone:1455} gives the same quest."] = "{npc:5497} im Magiersanktum im Gebiet {object:2101} in {zone:1453} schickt dich zu {npc:6546}; Bink in {zone:1455} gibt dieselbe Quest.",

	-- Step 2: Journey to the Marsh (Orgrimmar)
	-- {npc:5885} Deino · {zone:1454} Orgrimmar · {npc:6546} Tabetha · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity · {npc:3048} Ursyn Ghull · {zone:1456} Thunder Bluff
	["{npc:5885}, one of {zone:1454}'s mage trainers, sends you to {npc:6546}; {npc:4568} in the {zone:1458} and {npc:3048} in {zone:1456} give the same quest."] = "{npc:5885}, einer der Magierlehrer in {zone:1454}, schickt dich zu {npc:6546}; {npc:4568} in {zone:1458} und {npc:3048} in {zone:1456} geben dieselbe Quest.",

	-- Step 3: Tabetha
	-- {npc:6546} Tabetha · {area:508} Stonemaul Ruins
	["{npc:6546}, a hermit, lives in a cottage deep in the marsh west of Theramore, just north of the {area:508}."] = "{npc:6546}, eine Einsiedlerin, lebt in einer Hütte tief im Sumpf westlich von Theramore, direkt nördlich des Gebiets {area:508}.",

	-- Step 4: Magus Tirth
	-- {npc:6548} Magus Tirth · {area:439} Shimmering Flats · {zone:1441} Thousand Needles
	["{npc:6548} spends his days at the race track in the {area:439}, south-east {zone:1441}."] = "{npc:6548} verbringt seine Tage an der Rennstrecke im Gebiet {area:439}, im Südosten von {zone:1441}.",

	-- Step 5: "Plucky" Johnson
	["\"Plucky\" Johnson"] = "Eisenherz Johnson",
	["Tirth's apprentice is \"Plucky\" Johnson, a small grey chicken by the race track. Target him and type /beckon: he turns human for a moment, long enough to talk to him."] = "Tirths Lehrling ist Eisenherz Johnson, ein kleines graues Huhn an der Rennstrecke. Nimm ihn ins Ziel und tippe /beckon: Er wird kurz wieder menschlich, lange genug, um mit ihm zu reden.",

	-- Step 6: Rituals of Power
	-- {area:796} Scarlet Monastery · {zone:1420} Tirisfal Glades · {npc:6487} Arcanist Doan
	["Tirth sold the book to the Scarlet Brotherhood. The {area:796} stands in north-eastern {zone:1420}; take the Library wing. The book juts out of the wall on the left as you enter the Athenaeum, before {npc:6487}."] = "Tirth hat das Buch an den Scharlachroten Kreuzzug verkauft. {area:796} steht im Nordosten von {zone:1420}; nimm den Flügel Bibliothek. Das Buch ragt links aus der Wand, wenn du das Athenaeum betrittst, vor {npc:6487}.",
	-- {quest:1951} Rituals of Power
	["{quest:1951}: Scarlet Monastery Library"] = "{quest:1951}: Das Scharlachrote Kloster, Bibliothek",

	-- Step 7: Back to Tabetha
	-- {npc:6546} Tabetha
	["Back to {npc:6546}"] = "Zurück zu {npc:6546}",

	-- Step 8: Witherbark trolls
	["Witherbark trolls"] = "Trolle der Witherbark",
	-- {zone:1417} Arathi Highlands · {item:7273} Witherbark Totem Stick · {item:7272} Bolt Charged Bramble · {npc:6546} Tabetha · {item:1529} Jade
	-- plural, as words: Tin Veins = {object:1732} Tin Vein
	["The Witherbark trolls hold south-eastern {zone:1417}; every one of them can drop a {item:7273}. Then take the ten sticks north-west to the binding circle where they become the {item:7272}. {npc:6546} also wants a {item:1529}: buy one at an Auction House on the way; miners sometimes find one in Tin Veins."] = "Die Trolle der Witherbark halten den Südosten von {zone:1417}; jeder von ihnen kann einen {item:7273} fallen lassen. Bring die zehn Stecken dann nach Nordwesten zum Bindungskreis, wo sie zum {item:7272} werden. {npc:6546} will auch einen {item:1529}: Kauf ihn unterwegs in einem Auktionshaus; Bergleute finden manchmal einen in Zinnvorkommen.",

	-- Step 9: Tabetha's ritual
	-- {npc:6546} Tabetha
	["{npc:6546}'s ritual"] = "Das Ritual von {npc:6546}",
}
