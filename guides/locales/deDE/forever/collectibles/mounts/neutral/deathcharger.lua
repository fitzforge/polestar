-- German (deDE): the guide forever/collectibles/mounts/neutral/deathcharger (forever/collectibles/mounts/neutral/deathcharger.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Deathcharger"] = "Todesstreitross",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} (Geselle)",
	-- {item:13335} Deathcharger's Reins · {skill:762} Riding
	["{item:13335} needs level 60 and Journeyman {skill:762} to ride (Forever client). Train it at your race's riding trainer; see the Level 60 mount guides."] = "{item:13335} erfordert zum Reiten Stufe 60 und {skill:762} (Geselle) (Forever-Client). Trainiere es beim Reitlehrer deines Volkes; siehe die Guides für Reittiere mit Stufe 60.",

	-- Step 2: Stratholme: Baron Rivendare
	-- {area:2279} Stratholme · {object:175461} Service Entrance · {object:175440} Elders' Square · {zone:1423} Eastern Plaguelands · {npc:10440} Baron Rivendare
	["{area:2279} is a group of five, level 58-60. The {object:175461} at {object:175440}, in north-western {zone:1423}, leads to the undead side; {npc:10440} waits in the Slaughter House at its end. Our data gives the reins a 0.02% drop chance (pfQuest, Era): one in about five thousand kills. Nothing shows Forever changing it."] = "{area:2279} ist für eine Gruppe von fünf, Stufe 58-60. {object:175461} bei {object:175440} im Nordwesten von {zone:1423} führt zur Seite der Untoten; {npc:10440} wartet am Ende im Schlachthaus. Laut unseren Daten fallen die Zügel mit 0.02% Wahrscheinlichkeit (pfQuest, Era): etwa einmal in fünftausend Kills. Nichts deutet darauf hin, dass Forever das geändert hat.",
	-- {object:175461} Service Entrance
	["Stratholme {object:175461}"] = "{object:175461} von Stratholme",
}
