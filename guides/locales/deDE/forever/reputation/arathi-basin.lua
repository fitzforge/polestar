-- German (deDE): the guide forever/reputation/arathi-basin (forever/reputation/arathi-basin.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Arathi Basin Reputation"] = "Ruf: Arathibecken",
	["Every 200 resources your team gathers pays it; Exalted gives a Legacy Point, epic shoulders and the tabard."] = "Alle 200 gesammelten Ressourcen deines Teams zahlen sich aus; Ehrfürchtig gibt einen Vermächtnispunkt, epische Schultern und den Wappenrock.",
	["Master of Arathi Basin: a Legacy Point at Exalted"] = "Master of Arathi Basin: ein Vermächtnispunkt bei Ehrfürchtig",

	-- Step 1: Refuge Pointe
	-- {zone:1461} Arathi Basin
	["{zone:1461} is a 15 against 15 battle over five bases, from level 20: hold bases to gather resources, and the first team to 2000 wins. Queue at any battlemaster in the capitals or from the battleground screen. In Classic every 200 resources your team gathers pay everyone 10 reputation, so a win pays 100 and a close loss nearly as much; a game also pays 3 Arathi Basin Marks of Honor for a win, 1 for a loss. The three quests here pay 500 reputation together (200, 200 and 100), once. Forever's Legacy Diplomat perk adds up to 10% to every number in this guide."] = "{zone:1461} ist eine Schlacht 15 gegen 15 um fünf Basen, ab Stufe 20: Halte Basen, um Ressourcen zu sammeln; das Team, das zuerst 2000 erreicht, gewinnt. Reihe dich bei einem beliebigen Schlachtfeldmeister in den Hauptstädten oder über den Schlachtfeld-Bildschirm ein. In Classic zahlen je 200 gesammelte Ressourcen deines Teams allen 10 Ruf, ein Sieg bringt also 100 und eine knappe Niederlage fast ebenso viel; ein Spiel bringt außerdem 3 Ehrenabzeichen von Arathi Basin für einen Sieg, 1 für eine Niederlage. Die drei Quests hier zahlen zusammen 500 Ruf (200, 200 und 100), einmalig. Der Vermächtnis-Vorteil „Diplomat“ von Forever fügt jeder Zahl in diesem Guide bis zu 10% hinzu.",
	-- {npc:14983} Field Marshal Oslight
	["{npc:14983}: assault four bases, 200"] = "{npc:14983}: vier Basen angreifen, 200",
	-- {npc:14984} Sergeant Maclear
	["{npc:14984}: one mark, 200"] = "{npc:14984}: ein Abzeichen, 200",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: three marks, 100"] = "{npc:15351}: drei Abzeichen, 100",

	-- Step 2: Arathi Basin
	-- {npc:14984} Sergeant Maclear · {zone:1461} Arathi Basin
	["Assaulting a base means clicking its banner until it turns: you need not hold it. Four marks in all: one for {npc:14984}, three for the Brigadier General. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1461} marks: hand in or spend them before you reach that."] = "Eine Basis anzugreifen heißt, ihr Banner anzuklicken, bis es umschlägt: Du musst sie nicht halten. Insgesamt vier Abzeichen: eins für {npc:14984}, drei für den Brigadegeneral. Auch Forevers PvP-Ausrüstung kostet neben Ehre Ehrenabzeichen: Entscheide dich, was du willst, bevor du sie abgibst. Du kannst höchstens 30 Abzeichen von {zone:1461} tragen: Gib sie ab oder gib sie aus, bevor du das erreichst.",
	["Assault the Mine banner"] = "Greife das Banner der Mine an",
	-- {area:3422} Lumber Mill
	["Assault the {area:3422} banner"] = "Greife das Banner von {area:3422} an",
	["Assault the Blacksmith banner"] = "Greife das Banner der Schmiede an",
	["Assault the Farm banner"] = "Greife das Banner der Farm an",
	-- {item:20559} Arathi Basin Mark of Honor
	["one {item:20559}"] = "ein {item:20559}",
	["three more marks"] = "drei weitere Abzeichen",

	-- Step 3: Back to Refuge Pointe
	-- {area:320} Refuge Pointe
	["Back to {area:320}"] = "Zurück nach {area:320}",
	["hand in the three marks first"] = "gib zuerst die drei Abzeichen ab",

	-- Step 4: League of Arathor to Friendly
	["League of Arathor to Friendly"] = "Der Bund von Arathor auf Freundlich",
	-- {quest:8374} Claiming Arathi Basin · {area:320} Refuge Pointe
	["Neutral to Friendly is 3000 reputation. In Classic a win paid 100 and its 3 marks bring 50 more at the Brigadier General ({quest:8374}, again and again): about 150 a win, some 20 wins. Forever has not published its battleground rates, so count the games as a rough guide. Below level 50 the quests at {area:320} come in a version for your bracket (from level 20): 200 for assaulting the bases, 200 for one mark, then 100 and 50 per 3 marks at the Brigadier General."] = "Von Neutral bis Freundlich sind es 3000 Ruf. In Classic zahlte ein Sieg 100, und seine 3 Abzeichen bringen beim Brigadegeneral 50 mehr ({quest:8374}, immer wieder): etwa 150 pro Sieg, rund 20 Siege. Forever hat seine Schlachtfeld-Raten nicht veröffentlicht, nimm die Spielanzahl also als grobe Richtschnur. Unter Stufe 50 gibt es die Quests bei {area:320} in einer Version für deine Stufengruppe (ab Stufe 20): 200 für das Angreifen der Basen, 200 für ein Abzeichen, dann 100 und 50 pro 3 Abzeichen beim Brigadegeneral.",
	-- {npc:15351} Alliance Brigadier General · {quest:8374} Claiming Arathi Basin
	["{npc:15351}: {quest:8374} again, 50 reputation for 3 marks"] = "{npc:15351}: nochmals {quest:8374}, 50 Ruf für 3 Abzeichen",

	-- Step 5: Control Four Bases
	-- {npc:14983} Field Marshal Oslight · {quest:8115} Control Five Bases
	["At level 60 and Friendly, {npc:14983} asks your team to hold four bases at the same time: 200 reputation, once. It opens {quest:8115} for Exalted."] = "Auf Stufe 60 und Freundlich bittet {npc:14983} dein Team, vier Basen gleichzeitig zu halten: 200 Ruf, einmalig. Sie schaltet {quest:8115} für Ehrfürchtig frei.",
	["four bases held at once"] = "vier Basen gleichzeitig gehalten",

	-- Step 6: League of Arathor to Honored
	["League of Arathor to Honored"] = "Der Bund von Arathor auf Wohlwollend",
	-- {npc:15127} Samuel Hawke · {npc:14983} Field Marshal Oslight · {item:20071} Talisman of Arathor · {zone:1461} Arathi Basin
	["Friendly to Honored is 6000 reputation, about 40 wins at the Classic rate. Friendly opens the first rewards at {npc:15127} beside {npc:14983}: the {item:20071} trinket for levels 28, 38, 48 and 58 (72s to 4g12s), and food and bandages that work in {zone:1461} (10s to 20s). He also gives one Arathor care package at Friendly (pick the one for your level): 10 reputation and a bag of battleground food and bandages."] = "Von Freundlich bis Wohlwollend sind es 6000 Ruf, bei der Classic-Rate etwa 40 Siege. Freundlich schaltet die ersten Belohnungen bei {npc:15127} neben {npc:14983} frei: das Schmuckstück {item:20071} für die Stufen 28, 38, 48 und 58 (72s bis 4g12s) sowie Essen und Verbände, die in {zone:1461} funktionieren (10s bis 20s). Außerdem gibt er bei Freundlich ein Arathor-Versorgungspaket (nimm das für deine Stufe): 10 Ruf und eine Tasche mit Schlachtfeld-Essen und -Verbänden.",
	-- {npc:15127} Samuel Hawke
	["{npc:15127}: Friendly rewards"] = "{npc:15127}: Belohnungen für Freundlich",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: 50 reputation for 3 marks"] = "{npc:15351}: 50 Ruf für 3 Abzeichen",

	-- Step 7: League of Arathor to Revered
	["League of Arathor to Revered"] = "Der Bund von Arathor auf Respektvoll",
	["Honored to Revered is 12000 reputation, about 80 wins. Honored opens the Highlander's belts in plate, lamellar, chain, mail, leather, lizardhide and cloth for levels 28 to 58 (72s to 8g84s)."] = "Von Wohlwollend bis Respektvoll sind es 12000 Ruf, etwa 80 Siege. Wohlwollend schaltet die Gürtel des Highlanders in Platte, Lamellen, Kette, Schuppen, Leder, Echsenhaut und Stoff für die Stufen 28 bis 58 frei (72s bis 8g84s).",
	-- {npc:15127} Samuel Hawke
	["{npc:15127}: Honored rewards"] = "{npc:15127}: Belohnungen für Wohlwollend",

	-- Step 8: League of Arathor to Exalted
	["League of Arathor to Exalted"] = "Der Bund von Arathor auf Ehrfürchtig",
	["Revered to Exalted is 21000 reputation, about 140 wins: half of the whole climb. Revered opens the Highlander's boots and greaves for levels 28 to 58 (1g7s to 13g65s), the ones with the run-speed bonus."] = "Von Respektvoll bis Ehrfürchtig sind es 21000 Ruf, etwa 140 Siege: die Hälfte des ganzen Weges. Respektvoll schaltet die Stiefel und Beinschienen des Highlanders für die Stufen 28 bis 58 frei (1g7s bis 13g65s), die mit dem Laufgeschwindigkeitsbonus.",
	-- {npc:15127} Samuel Hawke
	["{npc:15127}: Revered rewards"] = "{npc:15127}: Belohnungen für Respektvoll",

	-- Step 9: Samuel Hawke
	-- {item:20073} Cloak of the Honor Guard · {item:20069} Ironbark Staff
	["Exalted gives the Legacy Point \"Master of Arathi Basin\" and opens the epics: the level 60 Highlander's shoulders in every armor type (12g33s to 18g50s), {item:20073} (12g14s), {item:20069} (55g10s) and Sageclaw (44g24s), both from level 55."] = "Ehrfürchtig gibt den Vermächtnispunkt „Master of Arathi Basin“ und schaltet die Epics frei: die Schultern des Highlanders für Stufe 60 in jeder Rüstungsart (12g33s bis 18g50s), {item:20073} (12g14s), {item:20069} (55g10s) und Sageclaw (44g24s), beide ab Stufe 55.",
	-- {npc:15127} Samuel Hawke
	["{npc:15127}: Exalted rewards"] = "{npc:15127}: Belohnungen für Ehrfürchtig",

	-- Step 10: Control Five Bases
	-- {npc:14983} Field Marshal Oslight · {item:20132} Arathor Battle Tabard
	["At Exalted, {npc:14983} asks your team to hold all five bases at the same time. It pays 200 reputation and the {item:20132}, the only way to get it."] = "Bei Ehrfürchtig bittet {npc:14983} dein Team, alle fünf Basen gleichzeitig zu halten. Das zahlt 200 Ruf und den {item:20132}, der nur so zu bekommen ist.",
	["all five bases held at once"] = "alle fünf Basen gleichzeitig gehalten",

	-- Step 11: Hammerfall
	-- {npc:15021} Deathmaster Dwire
	["{npc:15021}: assault four bases, 200"] = "{npc:15021}: vier Basen angreifen, 200",
	-- {npc:15022} Deathstalker Mortis
	["{npc:15022}: one mark, 200"] = "{npc:15022}: ein Abzeichen, 200",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: three marks, 100"] = "{npc:15350}: drei Abzeichen, 100",

	-- Step 12: Arathi Basin
	-- {npc:15022} Deathstalker Mortis · {zone:1461} Arathi Basin
	["Assaulting a base means clicking its banner until it turns: you need not hold it. Four marks in all: one for {npc:15022}, three for the Warbringer. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1461} marks: hand in or spend them before you reach that."] = "Eine Basis anzugreifen heißt, ihr Banner anzuklicken, bis es umschlägt: Du musst sie nicht halten. Insgesamt vier Abzeichen: eins für {npc:15022}, drei für den Kriegshetzer. Auch Forevers PvP-Ausrüstung kostet neben Ehre Ehrenabzeichen: Entscheide dich, was du willst, bevor du sie abgibst. Du kannst höchstens 30 Abzeichen von {zone:1461} tragen: Gib sie ab oder gib sie aus, bevor du das erreichst.",
	["Assault the Stables banner"] = "Greife das Banner der Ställe an",

	-- Step 13: Back to Hammerfall
	-- {area:321} Hammerfall
	["Back to {area:321}"] = "Zurück nach {area:321}",

	-- Step 14: The Defilers to Friendly
	-- {faction:510} The Defilers
	["{faction:510} to Friendly"] = "{faction:510} auf Freundlich",
	-- {quest:8370} Conquering Arathi Basin · {area:321} Hammerfall
	["Neutral to Friendly is 3000 reputation. In Classic a win paid 100 and its 3 marks bring 50 more at the Warbringer ({quest:8370}, again and again): about 150 a win, some 20 wins. Forever has not published its battleground rates, so count the games as a rough guide. Below level 50 the quests at {area:321} come in a version for your bracket (from level 20): 200 for assaulting the bases, 200 for one mark, then 100 and 50 per 3 marks at the Warbringer."] = "Von Neutral bis Freundlich sind es 3000 Ruf. In Classic zahlte ein Sieg 100, und seine 3 Abzeichen bringen beim Kriegshetzer 50 mehr ({quest:8370}, immer wieder): etwa 150 pro Sieg, rund 20 Siege. Forever hat seine Schlachtfeld-Raten nicht veröffentlicht, nimm die Spielanzahl also als grobe Richtschnur. Unter Stufe 50 gibt es die Quests bei {area:321} in einer Version für deine Stufengruppe (ab Stufe 20): 200 für das Angreifen der Basen, 200 für ein Abzeichen, dann 100 und 50 pro 3 Abzeichen beim Kriegshetzer.",
	-- {npc:15350} Horde Warbringer · {quest:8370} Conquering Arathi Basin
	["{npc:15350}: {quest:8370} again, 50 reputation for 3 marks"] = "{npc:15350}: nochmals {quest:8370}, 50 Ruf für 3 Abzeichen",

	-- Step 15: Take Four Bases
	-- {npc:15021} Deathmaster Dwire · {quest:8122} Take Five Bases
	["At level 60 and Friendly, {npc:15021} asks your team to hold four bases at the same time: 200 reputation, once. It opens {quest:8122} for Exalted."] = "Auf Stufe 60 und Freundlich bittet {npc:15021} dein Team, vier Basen gleichzeitig zu halten: 200 Ruf, einmalig. Sie schaltet {quest:8122} für Ehrfürchtig frei.",

	-- Step 16: The Defilers to Honored
	-- {faction:510} The Defilers
	["{faction:510} to Honored"] = "{faction:510} auf Wohlwollend",
	-- {npc:15126} Rutherford Twing · {npc:15021} Deathmaster Dwire · {item:20072} Defiler's Talisman · {zone:1461} Arathi Basin
	["Friendly to Honored is 6000 reputation, about 40 wins at the Classic rate. Friendly opens the first rewards at {npc:15126} beside {npc:15021}: the {item:20072} trinket for levels 28, 38, 48 and 58 (72s to 4g12s), and food and bandages that work in {zone:1461} (10s to 20s). He also gives one Defiler's care package at Friendly (pick the one for your level): 10 reputation and a bag of battleground food and bandages."] = "Von Freundlich bis Wohlwollend sind es 6000 Ruf, bei der Classic-Rate etwa 40 Siege. Freundlich schaltet die ersten Belohnungen bei {npc:15126} neben {npc:15021} frei: das Schmuckstück {item:20072} für die Stufen 28, 38, 48 und 58 (72s bis 4g12s) sowie Essen und Verbände, die in {zone:1461} funktionieren (10s bis 20s). Außerdem gibt er bei Freundlich ein Versorgungspaket des Entweihten (nimm das für deine Stufe): 10 Ruf und eine Tasche mit Schlachtfeld-Essen und -Verbänden.",
	-- {npc:15126} Rutherford Twing
	["{npc:15126}: Friendly rewards"] = "{npc:15126}: Belohnungen für Freundlich",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: 50 reputation for 3 marks"] = "{npc:15350}: 50 Ruf für 3 Abzeichen",

	-- Step 17: The Defilers to Revered
	-- {faction:510} The Defilers
	["{faction:510} to Revered"] = "{faction:510} auf Respektvoll",
	["Honored to Revered is 12000 reputation, about 80 wins. Honored opens the Defiler's belts in plate, lamellar, chain, mail, leather, lizardhide and cloth for levels 28 to 58 (75s to 8g78s)."] = "Von Wohlwollend bis Respektvoll sind es 12000 Ruf, etwa 80 Siege. Wohlwollend schaltet die Gürtel des Entweihten in Platte, Lamellen, Kette, Schuppen, Leder, Echsenhaut und Stoff für die Stufen 28 bis 58 frei (75s bis 8g78s).",
	-- {npc:15126} Rutherford Twing
	["{npc:15126}: Honored rewards"] = "{npc:15126}: Belohnungen für Wohlwollend",

	-- Step 18: The Defilers to Exalted
	-- {faction:510} The Defilers
	["{faction:510} to Exalted"] = "{faction:510} auf Ehrfürchtig",
	["Revered to Exalted is 21000 reputation, about 140 wins: half of the whole climb. Revered opens the Defiler's boots and greaves for levels 28 to 58 (1g12s to 13g41s), the ones with the run-speed bonus."] = "Von Respektvoll bis Ehrfürchtig sind es 21000 Ruf, etwa 140 Siege: die Hälfte des ganzen Weges. Respektvoll schaltet die Stiefel und Beinschienen des Entweihten für die Stufen 28 bis 58 frei (1g12s bis 13g41s), die mit dem Laufgeschwindigkeitsbonus.",
	-- {npc:15126} Rutherford Twing
	["{npc:15126}: Revered rewards"] = "{npc:15126}: Belohnungen für Respektvoll",

	-- Step 19: Rutherford Twing
	-- {item:20068} Deathguard's Cloak · {item:20069} Ironbark Staff
	["Exalted gives the Legacy Point \"Master of Arathi Basin\" and opens the epics: the level 60 Defiler's shoulders in every armor type (12g75s to 20g), {item:20068} (13g18s), {item:20069} (50g46s) and Mindfang (42g83s), both from level 55."] = "Ehrfürchtig gibt den Vermächtnispunkt „Master of Arathi Basin“ und schaltet die Epics frei: die Schultern des Entweihten für Stufe 60 in jeder Rüstungsart (12g75s bis 20g), {item:20068} (13g18s), {item:20069} (50g46s) und Mindfang (42g83s), beide ab Stufe 55.",
	-- {npc:15126} Rutherford Twing
	["{npc:15126}: Exalted rewards"] = "{npc:15126}: Belohnungen für Ehrfürchtig",

	-- Step 20: Take Five Bases
	-- {npc:15021} Deathmaster Dwire · {item:20131} Battle Tabard of the Defilers
	["At Exalted, {npc:15021} asks your team to hold all five bases at the same time. It pays 200 reputation and the {item:20131}, the only way to get it."] = "Bei Ehrfürchtig bittet {npc:15021} dein Team, alle fünf Basen gleichzeitig zu halten. Das zahlt 200 Ruf und den {item:20131}, der nur so zu bekommen ist.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Exalted with the League of Arathor earns a Legacy Point."] = "Ehrfürchtig beim Bund von Arathor bringt einen Vermächtnispunkt.",
	-- ["Exalted with {faction:510} earns a Legacy Point."] = "Ehrfürchtig bei {faction:510} bringt einen Vermächtnispunkt.",
	-- ["Keep playing {zone:1461}. On Call to Arms: {zone:1461} weekends the {npc:15350} in the capitals takes three Arathi Basin Marks of Honor for extra reputation."] = "Spiel weiter {zone:1461}. An Wochenenden mit „Zu den Waffen: {zone:1461}“ nimmt {npc:15350} in den Hauptstädten drei Ehrenabzeichen des Arathibeckens für zusätzlichen Ruf an.",
	-- ["Keep playing {zone:1461}. On Call to Arms: {zone:1461} weekends the {npc:15351} in the capitals takes three Arathi Basin Marks of Honor for extra reputation."] = "Spiel weiter {zone:1461}. An Wochenenden mit „Zu den Waffen: {zone:1461}“ nimmt {npc:15351} in den Hauptstädten drei Ehrenabzeichen des Arathibeckens für zusätzlichen Ruf an.",
	-- ["Keep playing {zone:1461}; wins with many bases held pay the most."] = "Spiel weiter {zone:1461}; Siege mit vielen gehaltenen Stützpunkten bringen am meisten.",
	-- ["{faction:509} fights for {zone:1461} from {area:320}. Their reputation comes from the battleground: the resources your team gathers pay it to everyone, so holding more bases for longer pays more. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:509} kämpft von {area:320} aus um {zone:1461}. Der Ruf kommt vom Schlachtfeld: Die Ressourcen, die dein Team sammelt, bringen allen Ruf, also bringt es mehr, mehr Stützpunkte länger zu halten. Melde dich bei einem beliebigen Kampfmeister an. Forevers Vermächtnis-Vorteil „Diplomat“ erhöht den Rufgewinn.",
	-- ["{faction:510} fight for {zone:1461} from {area:321}. Their reputation comes from the battleground: the resources your team gathers pay it to everyone, so holding more bases for longer pays more. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:510} kämpfen von {area:321} aus um {zone:1461}. Der Ruf kommt vom Schlachtfeld: Die Ressourcen, die dein Team sammelt, bringen allen Ruf, also bringt es mehr, mehr Stützpunkte länger zu halten. Melde dich bei einem beliebigen Kampfmeister an. Forevers Vermächtnis-Vorteil „Diplomat“ erhöht den Rufgewinn.",
	-- ["{npc:14983}'s The Battle for {zone:1461}! (assault every base) and Control Four Bases / Control Five Bases are one-time quests; {npc:14984} beside him takes Arathi Resource Crates."] = "Die Schlacht um das {zone:1461}! von {npc:14983} (greif jeden Stützpunkt an) und Kontrolliert vier Stützpunkte / Kontrolliert fünf Stützpunkte sind einmalige Quests; {npc:14984} neben ihm nimmt Arathivorratskisten an.",
	-- ["{npc:15021}'s The Battle for {zone:1461}! (assault every base) and Take Four Bases / Take Five Bases are one-time quests; {npc:15022} beside him takes Arathi Resource Crates."] = "Die Schlacht um das {zone:1461}! von {npc:15021} (greif jeden Stützpunkt an) und Erobert vier Stützpunkte / Erobert fünf Stützpunkte sind einmalige Quests; {npc:15022} neben ihm nimmt Arathivorratskisten an.",
	-- ["{npc:15126} hands out one Defiler's care package by level"] = "{npc:15126} gibt je nach Stufe ein Überlebenspaket der Entweihten aus",
	-- ["{npc:15127} hands out one Arathor care package by level"] = "{npc:15127} gibt je nach Stufe ein Überlebenspaket von Arathor aus",
}
