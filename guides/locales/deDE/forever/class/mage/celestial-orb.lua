-- German (deDE): the guide forever/class/mage/celestial-orb (forever/class/mage/celestial-orb.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7515} Celestial Orb
	["{item:7515} and Stave"] = "{item:7515} und Stab",
	["An off-hand orb or a staff for the late 30s, your pick."] = "Eine Schildhand-Kugel oder ein Stab für die späten 30er, nach deiner Wahl.",

	-- Step 1: Return to the Marsh (Stormwind)
	-- {npc:5497} Jennea Cannon · {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:6546} Tabetha · {zone:1455} Ironforge
	["{npc:5497} in the Wizard's Sanctum, {zone:1453}'s {object:2101}, sends you back to {npc:6546}; Bink in {zone:1455} gives the same quest."] = "{npc:5497} im Wizard's Sanctum im {object:2101} von {zone:1453} schickt dich zurück zu {npc:6546}; Bink in {zone:1455} gibt dieselbe Quest.",

	-- Step 2: Return to the Marsh (Orgrimmar)
	-- {npc:5885} Deino · {zone:1454} Orgrimmar · {npc:6546} Tabetha · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity · {npc:3048} Ursyn Ghull · {zone:1456} Thunder Bluff
	["{npc:5885}, one of {zone:1454}'s mage trainers, sends you back to {npc:6546}; {npc:4568} in the {zone:1458} and {npc:3048} in {zone:1456} give the same quest."] = "{npc:5885}, einer der Magierlehrer von {zone:1454}, schickt dich zurück zu {npc:6546}; {npc:4568} in {zone:1458} und {npc:3048} in {zone:1456} geben dieselbe Quest.",

	-- Step 3: Tabetha
	-- {npc:6546} Tabetha · {area:508} Stonemaul Ruins
	["{npc:6546}'s cottage is deep in the marsh west of Theramore, just north of the {area:508}."] = "Die Hütte von {npc:6546} liegt tief im Marschland westlich von Theramore, knapp nördlich der {area:508}.",

	-- Step 4: The Infernal Orb
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace · {item:7291} Infernal Orb
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["The Burning Blade Summoners work the {area:602} in southern {zone:1443}; any of them carries an {item:7291}."] = "Die Beschwörer der Burning Blade treiben im {area:602} im Süden von {zone:1443} ihr Werk; jeder von ihnen trägt eine {item:7291}.",

	-- Step 5: The Exorcism
	-- {npc:6546} Tabetha · {npc:6549} Demon of the Orb
	["{npc:6546} draws the demon out of the orb beside her cottage. The {npc:6549} is elite: grouping up is advised. You have three minutes before it slips back into the orb."] = "{npc:6546} zieht den Dämon neben ihrer Hütte aus der Kugel. {npc:6549} ist Elite: Eine Gruppe wird empfohlen. Du hast drei Minuten, bevor er in die Kugel zurückschlüpft.",

	-- Step 6: Power in Uldaman
	-- {area:1517} Uldaman · {zone:1418} Badlands · {object:178824} Meeting Stone · {npc:7023} Obsidian Sentinel
	["{area:1517} is a dungeon in the northern {zone:1418}, by the {object:178824}: a group of five. Defeat the {npc:7023} inside for its power source."] = "{area:1517} ist ein Dungeon im Norden des {zone:1418} beim {object:178824}: eine Gruppe für fünf. Besiege drinnen {npc:7023} für seine Energiequelle.",

	-- Step 7: Mana Surges
	-- {npc:6546} Tabetha · {quest:1957} Mana Surges
	["Back to {npc:6546}. She opens a mana rift beside her cottage: kill twelve {quest:1957} within ten minutes."] = "Zurück zu {npc:6546}. Sie öffnet neben ihrer Hütte einen Manariss: Töte innerhalb von zehn Minuten zwölf {quest:1957}.",
}
