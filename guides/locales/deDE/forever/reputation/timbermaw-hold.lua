-- German (deDE): the guide forever/reputation/timbermaw-hold (forever/reputation/timbermaw-hold.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Timbermaw Hold Reputation"] = "Ruf: Holzschlundfeste",

	-- Step 1: Grazle
	-- {faction:576} Timbermaw Hold
	["{faction:576} starts out Hostile, and its furbolgs in the tunnels attack until you reach Unfriendly. Every Deadwood and Winterfall furbolg you kill raises it, so the quests below pay twice. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:576} beginnt bei Feindselig, und ihre Furbolgs in den Tunneln greifen an, bis du Unfreundlich erreichst. Jeder Furbolg der Totenwaldfelle und der Winterfelle, den du tötest, erhöht ihn, die Quests unten zahlen sich also doppelt aus. Forevers Vermächtnis-Vorteil „Diplomat“ erhöht den Rufgewinn.",

	-- Step 2: Deadwood Village
	-- {zone:1448} Felwood · {item:21377} Deadwood Headdress Feather · {npc:11554} Grazle · {npc:15395} Nafien
	["Deadwood furbolgs (level 48-50) camp at the southern end of {zone:1448}. Keep every {item:21377} they drop: {npc:11554} and {npc:15395} take them later."] = "Furbolgs der Totenwaldfelle (Stufe 48-50) lagern am Südende des Gebiets {zone:1448}. Behalte jede {item:21377}, die sie fallen lassen: {npc:11554} und {npc:15395} nehmen sie später.",

	-- Step 3: Back to Grazle
	-- {npc:11554} Grazle
	["Back to {npc:11554}"] = "Zurück zu {npc:11554}",

	-- Step 4: Nafien
	-- {npc:15395} Nafien · {zone:1448} Felwood · {faction:576} Timbermaw Hold
	["{npc:15395} waits in northern {zone:1448} at the tunnel into {faction:576}."] = "{npc:15395} wartet im nördlichen {zone:1448} am Tunnel zur {faction:576}.",

	-- Step 5: Deadwood of the North
	["The northern Deadwood (level 53-55) hold the camps just south of the tunnel. Keep their feathers too."] = "Die nördlichen Totenwaldfelle (Stufe 53-55) halten die Lager gleich südlich des Tunnels. Behalte auch ihre Federn.",

	-- Step 6: Back to Nafien
	-- {npc:15395} Nafien
	["Back to {npc:15395}"] = "Zurück zu {npc:15395}",

	-- Step 7: Salfa
	-- {faction:576} Timbermaw Hold · {zone:1452} Winterspring · {npc:11556} Salfa
	["Go through {faction:576} to its {zone:1452} exit; {npc:11556} stands just outside. The quests and kills so far usually reach Unfriendly, and then the Timbermaw let you pass. If they still show red, kill more Deadwood by the tunnel first."] = "Geh durch die {faction:576} zum Ausgang nach {zone:1452}; {npc:11556} steht gleich draußen. Die bisherigen Quests und Kills reichen meist für Unfreundlich, dann lassen dich die Furbolgs der Holzschlundfeste durch. Sind sie noch rot, töte zuerst mehr Totenwaldfelle am Tunnel.",

	-- Step 8: Winterfall Village
	-- {area:2244} Winterfall Village · {zone:1452} Winterspring · {item:21383} Winterfall Spirit Beads · {npc:11556} Salfa
	["{area:2244} sits on the eastern side of {zone:1452}. Keep every {item:21383} you loot: {npc:11556} takes them."] = "Das {area:2244} liegt auf der Ostseite von {zone:1452}. Behalte alle {item:21383}, die du erbeutest: {npc:11556} nimmt sie.",

	-- Step 9: Back to Salfa
	-- {npc:11556} Salfa
	["Back to {npc:11556}"] = "Zurück zu {npc:11556}",

	-- Step 10: Feathers and beads to Friendly
	["Feathers and beads to Friendly"] = "Federn und Perlen bis Freundlich",
	-- {npc:11554} Grazle · {npc:15395} Nafien · {npc:11556} Salfa · {item:21383} Winterfall Spirit Beads · {area:2244} Winterfall Village
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["Feathers for {npc:11554} and Feathers for {npc:15395} (Deadwood Headdress Feathers) and Beads for {npc:11556} ({item:21383}) repeat as often as you like; every Deadwood or Winterfall kill counts as well. {area:2244} is the densest bead spot."] = "Federn für {npc:11554} und Federn für {npc:15395} (Kopfputzfedern der Totenwaldfelle) sowie Perlen für {npc:11556} ({item:21383}) lassen sich beliebig oft wiederholen; jeder Kill an Totenwaldfellen oder Winterfellen zählt auch. Im {area:2244} gibt es die meisten Perlen.",
	-- {npc:11556} Salfa
	["{npc:11556}: Beads for {npc:11556}"] = "{npc:11556}: Perlen für {npc:11556}",

	-- Step 11: Feathers to Honored
	["Feathers to Honored"] = "Federn bis Wohlwollend",
	-- {npc:15395} Nafien · {npc:11554} Grazle
	["The northern Deadwood camps by the tunnel are the densest feather spot (35% drop chance there). Hand feathers to {npc:15395} at the tunnel, or to {npc:11554} in the south."] = "Die nördlichen Lager der Totenwaldfelle am Tunnel sind der beste Ort für Federn (dort 35 % Dropchance). Gib die Federn bei {npc:15395} am Tunnel oder bei {npc:11554} im Süden ab.",
	-- {npc:15395} Nafien
	["{npc:15395}: Feathers for {npc:15395}"] = "{npc:15395}: Federn für {npc:15395}",

	-- Step 12: Timbermaw Hold to Revered
	-- {faction:576} Timbermaw Hold
	["{faction:576} to Revered"] = "{faction:576} bis Respektvoll",
	-- {npc:15395} Nafien · {npc:11556} Salfa
	["Alternate Deadwood feathers ({npc:15395}) and Winterfall beads ({npc:11556}), whichever camp is less crowded."] = "Wechsle zwischen Federn der Totenwaldfelle ({npc:15395}) und Perlen der Winterfelle ({npc:11556}), je nachdem, welches Lager weniger voll ist.",

	-- Step 13: Timbermaw Hold to Exalted
	-- {faction:576} Timbermaw Hold
	["{faction:576} to Exalted"] = "{faction:576} bis Ehrfürchtig",
	["Keep turning in feathers and beads until Exalted."] = "Gib weiter Federn und Perlen ab, bis Ehrfürchtig.",
}
