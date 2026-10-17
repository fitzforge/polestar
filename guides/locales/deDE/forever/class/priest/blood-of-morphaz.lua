-- German (deDE): the guide forever/class/priest/blood-of-morphaz (forever/class/priest/blood-of-morphaz.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1447} Azshara · {area:1417} Sunken Temple
	["Experience and gold at 50 through {zone:1447} and the {area:1417}; Forever removed the Classic item choice."] = "Erfahrung und Gold mit Stufe 50 durch {zone:1447} und den {area:1417}; Forever hat die Gegenstandsauswahl aus Classic entfernt.",
	["Experience and gold"] = "Erfahrung und Gold",

	-- Step 1: Cenarion Aid (Alliance)
	-- {quest:8254} Cenarion Aid
	["{quest:8254} (Alliance)"] = "{quest:8254} (Allianz)",
	-- {npc:5489} Brother Joshua · {zone:1453} Stormwind · {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {object:32386} Hall of Mysteries (no name in this language: may be words)
	["At 50 {npc:5489} in {zone:1453}'s Cathedral of Light or {npc:11406} in {zone:1455}'s {object:32386} offers it."] = "Mit Stufe 50 bietet sie {npc:5489} in der Kathedrale des Lichts in {zone:1453} oder {npc:11406} in der {object:32386} in {zone:1455} an.",

	-- Step 2: Cenarion Aid (Horde)
	-- {quest:8254} Cenarion Aid
	["{quest:8254} (Horde)"] = "{quest:8254} (Horde)",
	-- {npc:6018} Ur'kyo · {zone:1454} Orgrimmar · {object:172961} Valley of Spirits
	["At 50 {npc:6018} in {zone:1454}'s {object:172961} offers it."] = "Mit Stufe 50 bietet sie {npc:6018} im {object:172961} in {zone:1454} an.",

	-- Step 3: Ogtinc
	-- {npc:8405} Ogtinc · {area:1221} Ruins of Eldarath · {area:3137} Talrendis Point · {area:1237} Valormok
	["{npc:8405} lives atop the cliffs north-east of the {area:1221}. Alliance: fly to {area:3137}; Horde: fly to {area:1237}."] = "{npc:8405} lebt oben auf den Klippen nordöstlich des Gebiets {area:1221}. Allianz: Flieg zur {area:3137}; Horde: Flieg nach {area:1237}.",

	-- Step 4: Of Coursers We Know
	-- {zone:1447} Azshara · {item:20027} Healthy Courser Gland
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers graze all over {zone:1447}; about one in three drops a {item:20027}."] = "Mooshufrenner grasen überall in {zone:1447}; etwa jeder dritte lässt eine {item:20027} fallen.",

	-- Step 6: The Ichor of Undeath
	-- {npc:7864} Lingering Highborne · {area:1221} Ruins of Eldarath · {npc:8405} Ogtinc · {area:3137} Talrendis Point
	-- plural, as words: Highborne Apparitions = {npc:6116} Highborne Apparition
	["Any undead can drop it. The {npc:7864} in the {area:1221}, below {npc:8405}'s cliffs, are the nearest; Highborne Apparitions and Lichlings haunt the ruins near {area:3137}."] = "Jeder Untote kann es fallen lassen. Die {npc:7864} im Gebiet {area:1221}, unterhalb der Klippen von {npc:8405}, sind am nächsten; Erscheinungen von Hochgeborenen und Lichlinge von Hochgeborenen spuken in den Ruinen nahe der {area:3137}.",

	-- Step 8: Morphaz in the Sunken Temple
	-- {area:1417} Sunken Temple
	["Morphaz in the {area:1417}"] = "Morphaz im {area:1417}",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears · {area:75} Stonard · {area:42} Darkshire · {area:1438} Nethergarde Keep
	["Morphaz is an elite dragon boss inside the {area:1417}, a level 50 dungeon: bring a group of five. The temple stands in the middle of the {area:74}; swim down into it to reach the entrance. Horde: fly to {area:75}; Alliance: fly to {area:42} or {area:1438} and ride on."] = "Morphaz ist ein Elite-Drachenboss im {area:1417}, einem Dungeon der Stufe 50: Nimm eine Gruppe aus fünf mit. Der Tempel liegt mitten im {area:74}; tauch hinab, um den Eingang zu erreichen. Horde: Flieg nach {area:75}; Allianz: Flieg nach {area:42} oder zur {area:1438} und reite weiter.",
	-- {quest:8257} Blood of Morphaz · {area:1417} Sunken Temple
	["{quest:8257}: the {area:1417} entrance"] = "{quest:8257}: Eingang zum {area:1417}",

	-- Step 9: Greta Mosshoof
	-- {npc:10922} Greta Mosshoof · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["{npc:10922} is at the {area:2479} in southern {zone:1448}."] = "{npc:10922} ist im Gebiet {area:2479} im Süden von {zone:1448}.",
}
