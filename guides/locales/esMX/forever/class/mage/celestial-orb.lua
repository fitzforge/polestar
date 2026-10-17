-- Spanish (Latin America) (esMX): the guide forever/class/mage/celestial-orb (forever/class/mage/celestial-orb.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7515} Celestial Orb
	["{item:7515} and Stave"] = "{item:7515} y báculo",
	["An off-hand orb or a staff for the late 30s, your pick."] = "Un orbe de mano izquierda o un bastón para finales de los 30, a tu elección.",

	-- Step 1: Return to the Marsh (Stormwind)
	-- {npc:5497} Jennea Cannon · {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:6546} Tabetha · {zone:1455} Ironforge
	["{npc:5497} in the Wizard's Sanctum, {zone:1453}'s {object:2101}, sends you back to {npc:6546}; Bink in {zone:1455} gives the same quest."] = "{npc:5497}, en el Sagrario del Mago, en {object:2101} de {zone:1453}, te manda de vuelta con {npc:6546}; Bink en {zone:1455} da la misma misión.",

	-- Step 2: Return to the Marsh (Orgrimmar)
	-- {npc:5885} Deino · {zone:1454} Orgrimmar · {npc:6546} Tabetha · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity · {npc:3048} Ursyn Ghull · {zone:1456} Thunder Bluff
	["{npc:5885}, one of {zone:1454}'s mage trainers, sends you back to {npc:6546}; {npc:4568} in the {zone:1458} and {npc:3048} in {zone:1456} give the same quest."] = "{npc:5885}, uno de los instructores de magos de {zone:1454}, te manda de vuelta con {npc:6546}; {npc:4568} en {zone:1458} y {npc:3048} en {zone:1456} dan la misma misión.",

	-- Step 3: Tabetha
	-- {npc:6546} Tabetha · {area:508} Stonemaul Ruins
	["{npc:6546}'s cottage is deep in the marsh west of Theramore, just north of the {area:508}."] = "La cabaña de {npc:6546} está en lo profundo del pantano al oeste de Theramore, justo al norte de {area:508}.",

	-- Step 4: The Infernal Orb
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace · {item:7291} Infernal Orb
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["The Burning Blade Summoners work the {area:602} in southern {zone:1443}; any of them carries an {item:7291}."] = "Los Invocadores Filo Ardiente trabajan en {area:602}, al sur de {zone:1443}; cualquiera de ellos lleva un {item:7291}.",

	-- Step 5: The Exorcism
	-- {npc:6546} Tabetha · {npc:6549} Demon of the Orb
	["{npc:6546} draws the demon out of the orb beside her cottage. The {npc:6549} is elite: grouping up is advised. You have three minutes before it slips back into the orb."] = "{npc:6546} saca al demonio del orbe junto a su cabaña. El {npc:6549} es élite: se recomienda ir en grupo. Tienes tres minutos antes de que vuelva al orbe.",

	-- Step 6: Power in Uldaman
	-- {area:1517} Uldaman · {zone:1418} Badlands · {object:178824} Meeting Stone (no name in this language: may be words) · {npc:7023} Obsidian Sentinel
	["{area:1517} is a dungeon in the northern {zone:1418}, by the {object:178824}: a group of five. Defeat the {npc:7023} inside for its power source."] = "{area:1517} es un calabozo al norte de {zone:1418}, junto a la {object:178824}: grupo de cinco. Derrota a la {npc:7023} de dentro para obtener su fuente de poder.",

	-- Step 7: Mana Surges
	-- {npc:6546} Tabetha · {quest:1957} Mana Surges
	["Back to {npc:6546}. She opens a mana rift beside her cottage: kill twelve {quest:1957} within ten minutes."] = "Vuelve con {npc:6546}. Abre una falla de maná junto a su cabaña: mata doce {quest:1957} en diez minutos.",
}
