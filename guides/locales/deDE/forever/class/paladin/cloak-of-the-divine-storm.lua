-- German (deDE): the guide forever/class/paladin/cloak-of-the-divine-storm (forever/class/paladin/cloak-of-the-divine-storm.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:407778} Divine Storm
	["A rare cloak at 30 from the old {spell:407778} story; for now only Alliance paladins can finish it."] = "Ein seltener Umhang auf Stufe 30 aus der alten Geschichte um {spell:407778}; derzeit können nur Paladine der Allianz sie abschließen.",

	-- Step 1: The Strange Orb
	["The Strange Orb"] = "Die Strange Orb",
	-- {area:444} Tower of Althalaxx · {zone:1439} Darkshore
	["Climb to the top of the {area:444} in northern {zone:1439}. Loot the Strange Orb up there: it gives you the Althalaxx Orb, which starts the quest."] = "Klettere ganz nach oben auf {area:444} im nördlichen {zone:1439}. Plündere dort oben die Strange Orb: Sie gibt dir die Althalaxx Orb, die die Quest startet.",
	-- {area:444} Tower of Althalaxx
	["Strange Orb atop the {area:444}: right-click the Althalaxx Orb it gives"] = "Strange Orb oben auf {area:444}: Rechtsklick auf die Althalaxx Orb, die sie gibt",

	-- Step 2: Delgren the Purifier
	-- {npc:3663} Delgren the Purifier · {area:413} Maestra's Post · {zone:1440} Ashenvale
	["{npc:3663} stands at {area:413} in western {zone:1440}."] = "{npc:3663} steht bei {area:413} im westlichen {zone:1440}.",

	-- Step 3: Katherine the Pure
	-- {npc:5492} Katherine the Pure
	["{npc:5492} is in the Cathedral of Light."] = "{npc:5492} ist in der Kathedrale des Lichts.",

	-- Step 4: Ursula Deline
	-- {object:2101} Mage Quarter · {npc:5495} Ursula Deline
	["Katherine sends you to the warlocks in the {object:2101}; {npc:5495} speaks for them."] = "Katherine schickt dich zu den Hexenmeistern im {object:2101}; {npc:5495} spricht für sie.",

	-- Step 5: Summoner's Salt
	-- {item:209778} Summoner's Salt
	-- plural, as words: Blackrock Summoners = {npc:4463} Blackrock Summoner
	["Blackrock Summoners, Champions and Trackers camp in the north-west of Redridge; they drop the {item:209778}."] = "Beschwörer, Helden und Fährtenleser der Blackrock lagern im Nordwesten des Rotkammgebirges; sie lassen das {item:209778} fallen.",

	-- Step 6: Back to Ursula Deline
	-- {npc:5495} Ursula Deline
	["Back to {npc:5495}"] = "Zurück zu {npc:5495}",

	-- Step 7: Motes of Mannoroth
	["Motes of Mannoroth"] = "Partikel von Mannoroth",
	-- {area:435} Demon Fall Canyon · {zone:1440} Ashenvale
	-- plural, as words: Mannoroc Lashers = {npc:11697} Mannoroc Lasher · Searing Infernals = {npc:6073} Searing Infernal · Legion Hounds = {npc:6071} Legion Hound
	["{area:435} is in south-east {zone:1440}. The Mannoroc Lashers, Searing Infernals, Felguards and Legion Hounds in it drop the Motes of Mannoroth."] = "Der {area:435} liegt im Südosten von {zone:1440}. Die Mannoroc-Peitscher, Sengenden Höllenbestien, Teufelswachen und Legionshunde dort lassen die Partikel von Mannoroth fallen.",

	-- Step 8: The Spear of Mannoroth
	-- {object:409311} Spear of Mannoroth
	["The {object:409311}"] = "Der {object:409311}",
	-- {object:409311} Spear of Mannoroth · {area:435} Demon Fall Canyon · {object:409315} Shattered Orb
	["The {object:409311} stands at the east end of {area:435}. Shatter the orb on it; the {object:409315} appears beside it."] = "{object:409311} steht am Ostende von {area:435}. Zerschmettere die Kugel darauf; {object:409315} erscheint daneben.",
	-- {object:409315} Shattered Orb
	["from the {object:409315}"] = "von der {object:409315}",

	-- Step 9: Return to Delgren
	-- {area:413} Maestra's Post
	["Back to {area:413}."] = "Zurück zu {area:413}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {object:409311} stands at the east end of {area:435}. {spell:11170} the orb on it; the {object:409315} appears beside it."] = "{object:409311} steht am Ostende von {area:435}. Wirke {spell:11170} auf die Kugel darauf; {object:409315} erscheint daneben.",
}
