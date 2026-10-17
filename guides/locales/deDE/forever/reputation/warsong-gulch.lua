-- German (deDE): the guide forever/reputation/warsong-gulch (forever/reputation/warsong-gulch.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Warsong Gulch Reputation"] = "Ruf: Warsongschlucht",

	-- Step 1: Silverwing Sentinels to Friendly
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Friendly"] = "{faction:890} bis Freundlich",
	-- {faction:890} Silverwing Sentinels · {zone:1460} Warsong Gulch
	["The {faction:890} are the Night Elves holding {zone:1460}. Their reputation comes from the battleground: every enemy flag your team captures pays it to the whole team. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:890} sind die Nachtelfen, die {zone:1460} halten. Ihr Ruf kommt vom Schlachtfeld: Jede gegnerische Flagge, die dein Team erobert, bringt dem ganzen Team Ruf. Melde dich bei einem beliebigen Kampfmeister an. Forevers Vermächtnis-Vorteil „Diplomat“ erhöht den Rufgewinn.",
	-- {npc:14733} Sentinel Farsong
	["{npc:14733} takes Warsong Gulch Marks of Honor for Vanquish the Invaders!, once per level bracket (data); check them live."] = "{npc:14733} nimmt Ehrenabzeichen der Warsongschlucht für Besiegt die Eindringlinge! an, einmal pro Stufenbereich (laut Daten); prüf es im Spiel.",

	-- Step 2: Silverwing Sentinels to Honored
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Honored"] = "{faction:890} bis Wohlwollend",
	-- {zone:1460} Warsong Gulch · {npc:15351} Alliance Brigadier General
	["Keep playing {zone:1460} and capturing flags. On Call to Arms: {zone:1460} weekends the {npc:15351} in the capitals takes three Warsong Gulch Marks of Honor for extra reputation."] = "Spiel weiter {zone:1460} und erobere Flaggen. An Wochenenden mit „Zu den Waffen: {zone:1460}“ nimmt {npc:15351} in den Hauptstädten drei Ehrenabzeichen der Warsongschlucht für zusätzlichen Ruf an.",
	-- {npc:14753} Illiyana Moonblaze
	["{npc:14753} hands out one Sentinel care package by level"] = "{npc:14753} gibt ein Überlebenspaket der Schildwache pro Stufe aus",

	-- Step 3: Silverwing Sentinels to Revered
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Revered"] = "{faction:890} bis Respektvoll",
	-- {zone:1460} Warsong Gulch
	["Keep capturing flags in {zone:1460}."] = "Erobere weiter Flaggen in {zone:1460}.",

	-- Step 4: Silverwing Sentinels to Exalted
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Exalted"] = "{faction:890} bis Ehrfürchtig",
	-- {faction:890} Silverwing Sentinels
	["Exalted with the {faction:890} earns a Legacy Point."] = "Ehrfürchtig bei {faction:890} bringt einen Vermächtnispunkt.",

	-- Step 5: Warsong Outriders to Friendly
	-- {faction:889} Warsong Outriders
	["{faction:889} to Friendly"] = "{faction:889} bis Freundlich",
	-- {faction:889} Warsong Outriders · {zone:1440} Ashenvale
	["The {faction:889} are the Orcs logging {zone:1440}. Their reputation comes from the battleground: every enemy flag your team captures pays it to the whole team. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:889} sind die Orcs, die in {zone:1440} Holz schlagen. Ihr Ruf kommt vom Schlachtfeld: Jede gegnerische Flagge, die dein Team erobert, bringt dem ganzen Team Ruf. Melde dich bei einem beliebigen Kampfmeister an. Forevers Vermächtnis-Vorteil „Diplomat“ erhöht den Rufgewinn.",
	-- {npc:14781} Captain Shatterskull
	["{npc:14781} takes Warsong Gulch Marks of Honor for Quell the Silverwing Usurpers, once per level bracket (data); check them live."] = "{npc:14781} nimmt Ehrenabzeichen der Warsongschlucht für Bezwingt die Eindringlinge der Silverwing an, einmal pro Stufenbereich (laut Daten); prüf es im Spiel.",

	-- Step 6: Warsong Outriders to Honored
	-- {faction:889} Warsong Outriders
	["{faction:889} to Honored"] = "{faction:889} bis Wohlwollend",
	-- {zone:1460} Warsong Gulch · {npc:15350} Horde Warbringer
	["Keep playing {zone:1460} and capturing flags. On Call to Arms: {zone:1460} weekends the {npc:15350} in the capitals takes three Warsong Gulch Marks of Honor for extra reputation."] = "Spiel weiter {zone:1460} und erobere Flaggen. An Wochenenden mit „Zu den Waffen: {zone:1460}“ nimmt {npc:15350} in den Hauptstädten drei Ehrenabzeichen der Warsongschlucht für zusätzlichen Ruf an.",
	-- {npc:14754} Kelm Hargunth
	["{npc:14754} hands out one Outrider care package by level"] = "{npc:14754} gibt ein Überlebenspaket der Vorhut pro Stufe aus",

	-- Step 7: Warsong Outriders to Revered
	-- {faction:889} Warsong Outriders
	["{faction:889} to Revered"] = "{faction:889} bis Respektvoll",

	-- Step 8: Warsong Outriders to Exalted
	-- {faction:889} Warsong Outriders
	["{faction:889} to Exalted"] = "{faction:889} bis Ehrfürchtig",
	-- {faction:889} Warsong Outriders
	["Exalted with the {faction:889} earns a Legacy Point."] = "Ehrfürchtig bei {faction:889} bringt einen Vermächtnispunkt.",
}
