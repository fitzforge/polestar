-- German (deDE): the guide forever/reputation/arathi-basin (forever/reputation/arathi-basin.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Arathi Basin Reputation"] = "Ruf: Arathibecken",

	-- Step 1: League of Arathor to Friendly
	["League of Arathor to Friendly"] = "Der Bund von Arathor auf Freundlich",
	-- {faction:509} The League of Arathor · {zone:1461} Arathi Basin · {area:320} Refuge Pointe
	["{faction:509} fights for {zone:1461} from {area:320}. Their reputation comes from the battleground: the resources your team gathers pay it to everyone, so holding more bases for longer pays more. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:509} kämpft von {area:320} aus um {zone:1461}. Der Ruf kommt vom Schlachtfeld: Die Ressourcen, die dein Team sammelt, bringen allen Ruf, also bringt es mehr, mehr Stützpunkte länger zu halten. Melde dich bei einem beliebigen Kampfmeister an. Forevers Vermächtnis-Vorteil „Diplomat“ erhöht den Rufgewinn.",
	-- {npc:14983} Field Marshal Oslight · {zone:1461} Arathi Basin · {npc:14984} Sergeant Maclear
	-- plural, as words: Arathi Resource Crates = {item:19725} Arathi Resource Crate
	["{npc:14983}'s The Battle for {zone:1461}! (assault every base) and Control Four Bases / Control Five Bases are one-time quests; {npc:14984} beside him takes Arathi Resource Crates."] = "Die Schlacht um das {zone:1461}! von {npc:14983} (greif jeden Stützpunkt an) und Kontrolliert vier Stützpunkte / Kontrolliert fünf Stützpunkte sind einmalige Quests; {npc:14984} neben ihm nimmt Arathivorratskisten an.",

	-- Step 2: League of Arathor to Honored
	["League of Arathor to Honored"] = "Der Bund von Arathor auf Wohlwollend",
	-- {zone:1461} Arathi Basin · {npc:15351} Alliance Brigadier General
	["Keep playing {zone:1461}. On Call to Arms: {zone:1461} weekends the {npc:15351} in the capitals takes three Arathi Basin Marks of Honor for extra reputation."] = "Spiel weiter {zone:1461}. An Wochenenden mit „Zu den Waffen: {zone:1461}“ nimmt {npc:15351} in den Hauptstädten drei Ehrenabzeichen des Arathibeckens für zusätzlichen Ruf an.",
	-- {npc:15127} Samuel Hawke
	["{npc:15127} hands out one Arathor care package by level"] = "{npc:15127} gibt je nach Stufe ein Überlebenspaket von Arathor aus",

	-- Step 3: League of Arathor to Revered
	["League of Arathor to Revered"] = "Der Bund von Arathor auf Respektvoll",
	-- {zone:1461} Arathi Basin
	["Keep playing {zone:1461}; wins with many bases held pay the most."] = "Spiel weiter {zone:1461}; Siege mit vielen gehaltenen Stützpunkten bringen am meisten.",

	-- Step 4: League of Arathor to Exalted
	["League of Arathor to Exalted"] = "Der Bund von Arathor auf Ehrfürchtig",
	["Exalted with the League of Arathor earns a Legacy Point."] = "Ehrfürchtig beim Bund von Arathor bringt einen Vermächtnispunkt.",

	-- Step 5: The Defilers to Friendly
	-- {faction:510} The Defilers
	["{faction:510} to Friendly"] = "{faction:510} auf Freundlich",
	-- {faction:510} The Defilers · {zone:1461} Arathi Basin · {area:321} Hammerfall
	["{faction:510} fight for {zone:1461} from {area:321}. Their reputation comes from the battleground: the resources your team gathers pay it to everyone, so holding more bases for longer pays more. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:510} kämpfen von {area:321} aus um {zone:1461}. Der Ruf kommt vom Schlachtfeld: Die Ressourcen, die dein Team sammelt, bringen allen Ruf, also bringt es mehr, mehr Stützpunkte länger zu halten. Melde dich bei einem beliebigen Kampfmeister an. Forevers Vermächtnis-Vorteil „Diplomat“ erhöht den Rufgewinn.",
	-- {npc:15021} Deathmaster Dwire · {zone:1461} Arathi Basin · {npc:15022} Deathstalker Mortis
	-- plural, as words: Arathi Resource Crates = {item:19725} Arathi Resource Crate
	["{npc:15021}'s The Battle for {zone:1461}! (assault every base) and Take Four Bases / Take Five Bases are one-time quests; {npc:15022} beside him takes Arathi Resource Crates."] = "Die Schlacht um das {zone:1461}! von {npc:15021} (greif jeden Stützpunkt an) und Erobert vier Stützpunkte / Erobert fünf Stützpunkte sind einmalige Quests; {npc:15022} neben ihm nimmt Arathivorratskisten an.",

	-- Step 6: The Defilers to Honored
	-- {faction:510} The Defilers
	["{faction:510} to Honored"] = "{faction:510} auf Wohlwollend",
	-- {zone:1461} Arathi Basin · {npc:15350} Horde Warbringer
	["Keep playing {zone:1461}. On Call to Arms: {zone:1461} weekends the {npc:15350} in the capitals takes three Arathi Basin Marks of Honor for extra reputation."] = "Spiel weiter {zone:1461}. An Wochenenden mit „Zu den Waffen: {zone:1461}“ nimmt {npc:15350} in den Hauptstädten drei Ehrenabzeichen des Arathibeckens für zusätzlichen Ruf an.",
	-- {npc:15126} Rutherford Twing
	["{npc:15126} hands out one Defiler's care package by level"] = "{npc:15126} gibt je nach Stufe ein Überlebenspaket der Entweihten aus",

	-- Step 7: The Defilers to Revered
	-- {faction:510} The Defilers
	["{faction:510} to Revered"] = "{faction:510} auf Respektvoll",

	-- Step 8: The Defilers to Exalted
	-- {faction:510} The Defilers
	["{faction:510} to Exalted"] = "{faction:510} auf Ehrfürchtig",
	-- {faction:510} The Defilers
	["Exalted with {faction:510} earns a Legacy Point."] = "Ehrfürchtig bei {faction:510} bringt einen Vermächtnispunkt.",
}
