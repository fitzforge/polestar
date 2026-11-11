-- German (deDE): the guide forever/reputation/warsong-gulch (forever/reputation/warsong-gulch.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Warsong Gulch Reputation"] = "Ruf: Warsongschlucht",
	["Flag captures and Marks of Honor raise it; Exalted gives a Legacy Point and epic bracers and legs."] = "Flaggeneroberungen und Ehrenabzeichen steigern ihn; Ehrfürchtig gibt einen Vermächtnispunkt sowie epische Armschienen und Beinschutz.",
	["Master of Warsong Gulch: a Legacy Point at Exalted"] = "Master of Warsong Gulch: ein Vermächtnispunkt bei Ehrfürchtig",

	-- Step 1: Sentinel Farsong
	-- {zone:1460} Warsong Gulch · {npc:14733} Sentinel Farsong
	["{zone:1460} is a 10 against 10 capture-the-flag battle, from level 10. Queue at any battlemaster in the capitals or from the battleground screen. In Classic every flag your team captures pays everyone 35 reputation (45 on the {zone:1460} holiday weekend), and a game pays 3 Warsong Gulch Marks of Honor for a win, 1 for a loss. {npc:14733} pays 200 reputation for one mark, once per character: the best mark you will ever turn in. Forever's Legacy Diplomat perk adds up to 10% to every number in this guide."] = "{zone:1460} ist ein Capture-the-Flag-Gefecht 10 gegen 10, ab Stufe 10. Reihe dich bei einem beliebigen Schlachtmeister in den Hauptstädten oder über das Schlachtfeld-Fenster ein. In Classic zahlt jede Flagge, die dein Team erobert, allen 35 Ruf (45 am Feiertagswochenende der {zone:1460}), und ein Spiel zahlt 3 Ehrenabzeichen der Warsongschlucht für einen Sieg, 1 für eine Niederlage. {npc:14733} zahlt 200 Ruf für ein Abzeichen, einmal pro Charakter: das beste Abzeichen, das du je abgeben wirst. Der Vermächtnis-Vorteil „Diplomat“ von Forever fügt jeder Zahl in diesem Guide bis zu 10% hinzu.",
	-- {item:20558} Warsong Gulch Mark of Honor
	["one {item:20558}: play a game"] = "ein {item:20558}: spiel ein Spiel",

	-- Step 2: Alliance Brigadier General
	-- {npc:15351} Alliance Brigadier General · {quest:8372} Fight for Warsong Gulch · {area:3319} Silverwing Grove · {npc:14733} Sentinel Farsong · {zone:1453} Stormwind · {zone:1455} Ironforge · {zone:1457} Darnassus · {area:320} Refuge Pointe · {zone:1417} Arathi Highlands · {zone:1459} Alterac Valley · {zone:1460} Warsong Gulch
	["The {npc:15351} pays 100 reputation for 3 Warsong Gulch Marks of Honor the first time, then 50 for every 3 more ({quest:8372}). One stands right here at {area:3319} beside {npc:14733}; others in {zone:1453}, {zone:1455} and {zone:1457}, at {area:320} in the {zone:1417} and at both gates of {zone:1459}. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1460} marks: hand in or spend them before you reach that."] = "Der {npc:15351} zahlt beim ersten Mal 100 Ruf für 3 Ehrenabzeichen der Warsongschlucht, danach 50 für je 3 weitere ({quest:8372}). Einer steht gleich hier bei {area:3319} neben {npc:14733}; weitere in {zone:1453}, {zone:1455} und {zone:1457}, bei {area:320} in {zone:1417} und an beiden Toren von {zone:1459}. Auch die PvP-Ausrüstung von Forever kostet Ehrenabzeichen zusätzlich zu Ehre: Entscheide, was du willst, bevor du sie abgibst. Du kannst höchstens 30 Abzeichen der {zone:1460} tragen: Gib sie ab oder gib sie aus, bevor du das erreichst.",
	["three Warsong Gulch Marks of Honor"] = "drei Ehrenabzeichen der Warsongschlucht",

	-- Step 3: Silverwing Sentinels to Friendly
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Friendly"] = "{faction:890} bis Freundlich",
	-- {npc:14733} Sentinel Farsong · {quest:8372} Fight for Warsong Gulch
	["Neutral to Friendly is 3000 reputation. In Classic a 3-capture win paid 105, and its 3 marks bring 50 more at the Brigadier General: about 155 a win, so some 20 wins. Losses still pay 35 for each flag your team captured. Forever has not published its battleground rates, so count the games as a rough guide. Below level 50, {npc:14733}'s one-mark quest and the Brigadier General's {quest:8372} come in a version for your bracket (from 20 and from 10): 200 once, then 100 and 50 per 3 marks."] = "Von Neutral bis Freundlich sind es 3000 Ruf. In Classic zahlte ein Sieg mit 3 Eroberungen 105, und seine 3 Abzeichen bringen 50 mehr beim Brigadegeneral: etwa 155 pro Sieg, also rund 20 Siege. Niederlagen zahlen trotzdem 35 für jede Flagge, die dein Team erobert hat. Forever hat seine Schlachtfeld-Raten nicht veröffentlicht, zähle die Spiele also als grobe Richtschnur. Unter Stufe 50 gibt es die Ein-Abzeichen-Quest von {npc:14733} und die {quest:8372} des Brigadegeneral in einer Version für deine Stufengruppe (ab 20 und ab 10): einmal 200, dann 100 und 50 pro 3 Abzeichen.",
	-- {npc:15351} Alliance Brigadier General · {quest:8372} Fight for Warsong Gulch
	["{npc:15351}: {quest:8372} again, 50 reputation for 3 marks"] = "{npc:15351}: wieder {quest:8372}, 50 Ruf für 3 Abzeichen",

	-- Step 4: Silverwing Sentinels to Honored
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Honored"] = "{faction:890} bis Wohlwollend",
	-- {npc:14753} Illiyana Moonblaze · {npc:14733} Sentinel Farsong · {item:21567} Rune of Duty · {item:21565} Rune of Perfection
	["Friendly to Honored is 6000 reputation, about 39 wins at the Classic rate. Friendly opens the first rewards at {npc:14753} beside {npc:14733}: the {item:21567} and {item:21565} trinkets (2g at level 20, 4g at level 40) and food, bandages and draughts that work in the battleground (5s to 20s). She also gives one Sentinel care package at Friendly (pick the one for your level): 10 reputation and a bag of battleground food and bandages."] = "Von Freundlich bis Wohlwollend sind es 6000 Ruf, bei der Rate von Classic etwa 39 Siege. Freundlich öffnet die ersten Belohnungen bei {npc:14753} neben {npc:14733}: die Schmuckstücke {item:21567} und {item:21565} (2g auf Stufe 20, 4g auf Stufe 40) und Essen, Verbände und Tränke, die im Schlachtfeld funktionieren (5s bis 20s). Sie gibt dir bei Freundlich auch ein Sentinel-Fürsorgepaket (wähle das für deine Stufe): 10 Ruf und eine Tasche mit Schlachtfeld-Essen und Verbänden.",
	-- {npc:14753} Illiyana Moonblaze
	["{npc:14753}: Friendly rewards"] = "{npc:14753}: Belohnungen bei Freundlich",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: 50 reputation for 3 marks"] = "{npc:15351}: 50 Ruf für 3 Abzeichen",

	-- Step 5: Silverwing Sentinels to Revered
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Revered"] = "{faction:890} bis Respektvoll",
	-- {item:19530} Caretaker's Cape · {item:19538} Sentinel's Medallion · {item:19522} Lorekeeper's Ring · {item:19514} Protector's Band
	["Honored to Revered is 12000 reputation, about 78 wins. Honored opens the {item:19530} (cloak), {item:19538} (neck), {item:19522} and {item:19514}, each sold for levels 18, 28, 38, 48 and 58 (cloak 36s50c to 8g55s, the rest 2g to 7g50s), and the Major Healing and Mana Draughts (10s)."] = "Von Wohlwollend bis Respektvoll sind es 12000 Ruf, etwa 78 Siege. Wohlwollend öffnet {item:19530} (Umhang), {item:19538} (Hals), {item:19522} und {item:19514}, jeweils verkauft für die Stufen 18, 28, 38, 48 und 58 (Umhang 36s50c bis 8g55s, der Rest 2g bis 7g50s), und die Großen Heil- und Manatränke (10s).",
	-- {npc:14753} Illiyana Moonblaze
	["{npc:14753}: Honored rewards"] = "{npc:14753}: Belohnungen bei Wohlwollend",

	-- Step 6: Silverwing Sentinels to Exalted
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Exalted"] = "{faction:890} bis Ehrfürchtig",
	-- {item:19546} Sentinel's Blade · {item:19554} Protector's Sword · {item:19562} Outrunner's Bow · {item:19570} Lorekeeper's Staff
	["Revered to Exalted is 21000 reputation, about 136 wins: half of the whole climb. Revered opens the weapons for levels 18 to 58: {item:19546} (dagger), {item:19554}, {item:19562} and {item:19570} (91s to 35g61s). Forever's quartermaster also sells level-25 versions of the four weapons, Resilient helms for level 20 (2g50s) and the Trainee's Sentinel Nightsaber mount (level 25, 10g) with no standing listed."] = "Von Respektvoll bis Ehrfürchtig sind es 21000 Ruf, etwa 136 Siege: die Hälfte des ganzen Aufstiegs. Respektvoll öffnet die Waffen für die Stufen 18 bis 58: {item:19546} (Dolch), {item:19554}, {item:19562} und {item:19570} (91s bis 35g61s). Der Quartiermeister von Forever verkauft außerdem Versionen der vier Waffen für Stufe 25, Resilient-Helme für Stufe 20 (2g50s) und das Reittier Trainee's Sentinel Nightsaber (Stufe 25, 10g), ohne dass ein Ruf angegeben ist.",
	-- {npc:14753} Illiyana Moonblaze
	["{npc:14753}: Revered rewards"] = "{npc:14753}: Belohnungen bei Respektvoll",

	-- Step 7: Illiyana Moonblaze
	-- {item:19578} Berserker Bracers · {item:19582} Windtalker's Wristguards · {item:19587} Forest Stalker's Bracers · {item:19595} Dryad's Wrist Bindings · {item:19506} Silverwing Battle Tabard
	["Exalted gives the Legacy Point \"Master of Warsong Gulch\" and opens the epics: {item:19578} (plate), {item:19582} (mail), {item:19587} (leather) and {item:19595} (cloth) for levels 40, 50 and 60 (2g47s to 12g11s), and the level 60 Sentinel's legs in plate, lamellar, chain, leather, lizardhide and silk (16g63s to 24g22s). The {item:19506} is 5g."] = "Ehrfürchtig gibt den Vermächtnispunkt „Master of Warsong Gulch“ und öffnet die Epics: {item:19578} (Platte), {item:19582} (Kette), {item:19587} (Leder) und {item:19595} (Stoff) für die Stufen 40, 50 und 60 (2g47s bis 12g11s) sowie den Beinschutz des Sentinel der Stufe 60 in Platte, Lamellen, Kette, Leder, Echsenhaut und Seide (16g63s bis 24g22s). Das {item:19506} kostet 5g.",
	-- {item:19506} Silverwing Battle Tabard
	["{item:19506}, 5g"] = "{item:19506}, 5g",

	-- Step 8: Captain Shatterskull
	-- {zone:1460} Warsong Gulch · {area:1599} Mor'shan Base Camp · {npc:14781} Captain Shatterskull
	["{zone:1460} is a 10 against 10 capture-the-flag battle, from level 10. Queue at any battlemaster in the capitals or from the battleground screen; the Horde gate is here at {area:1599}. In Classic every flag your team captures pays everyone 35 reputation (45 on the {zone:1460} holiday weekend), and a game pays 3 Warsong Gulch Marks of Honor for a win, 1 for a loss. {npc:14781} pays 200 reputation for one mark, once per character: the best mark you will ever turn in. Forever's Legacy Diplomat perk adds up to 10% to every number in this guide."] = "{zone:1460} ist ein Capture-the-Flag-Gefecht 10 gegen 10, ab Stufe 10. Reihe dich bei einem beliebigen Schlachtmeister in den Hauptstädten oder über das Schlachtfeld-Fenster ein; das Tor der Horde ist hier bei {area:1599}. In Classic zahlt jede Flagge, die dein Team erobert, allen 35 Ruf (45 am Feiertagswochenende der {zone:1460}), und ein Spiel zahlt 3 Ehrenabzeichen der Warsongschlucht für einen Sieg, 1 für eine Niederlage. {npc:14781} zahlt 200 Ruf für ein Abzeichen, einmal pro Charakter: das beste Abzeichen, das du je abgeben wirst. Der Vermächtnis-Vorteil „Diplomat“ von Forever fügt jeder Zahl in diesem Guide bis zu 10% hinzu.",

	-- Step 9: Horde Warbringer
	-- {npc:15350} Horde Warbringer · {quest:8368} Battle of Warsong Gulch · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {zone:1458} Undercity · {area:321} Hammerfall · {zone:1417} Arathi Highlands · {zone:1459} Alterac Valley · {zone:1416} Alterac Mountains · {zone:1460} Warsong Gulch
	["The {npc:15350} pays 100 reputation for 3 Warsong Gulch Marks of Honor the first time, then 50 for every 3 more ({quest:8368}). One stands right here at Mor'shan; others in {zone:1454}, {zone:1456} (and on the plain below it) and the {zone:1458}, at {area:321} in the {zone:1417} and at the {zone:1459} gate in the {zone:1416}. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1460} marks: hand in or spend them before you reach that."] = "Der {npc:15350} zahlt beim ersten Mal 100 Ruf für 3 Ehrenabzeichen der Warsongschlucht, danach 50 für je 3 weitere ({quest:8368}). Einer steht gleich hier bei Mor'shan; weitere in {zone:1454}, {zone:1456} (und auf der Ebene darunter) und {zone:1458}, bei {area:321} in {zone:1417} und am Tor von {zone:1459} im {zone:1416}. Auch die PvP-Ausrüstung von Forever kostet Ehrenabzeichen zusätzlich zu Ehre: Entscheide, was du willst, bevor du sie abgibst. Du kannst höchstens 30 Abzeichen der {zone:1460} tragen: Gib sie ab oder gib sie aus, bevor du das erreichst.",

	-- Step 10: Warsong Outriders to Friendly
	-- {faction:889} Warsong Outriders
	["{faction:889} to Friendly"] = "{faction:889} bis Freundlich",
	-- {npc:14781} Captain Shatterskull · {quest:8368} Battle of Warsong Gulch
	["Neutral to Friendly is 3000 reputation. In Classic a 3-capture win paid 105, and its 3 marks bring 50 more at the Warbringer: about 155 a win, so some 20 wins. Losses still pay 35 for each flag your team captured. Forever has not published its battleground rates, so count the games as a rough guide. Below level 50, {npc:14781}'s one-mark quest and the Warbringer's {quest:8368} come in a version for your bracket (from 20 and from 10): 200 once, then 100 and 50 per 3 marks."] = "Von Neutral bis Freundlich sind es 3000 Ruf. In Classic zahlte ein Sieg mit 3 Eroberungen 105, und seine 3 Abzeichen bringen 50 mehr beim Kriegshetzer: etwa 155 pro Sieg, also rund 20 Siege. Niederlagen zahlen trotzdem 35 für jede Flagge, die dein Team erobert hat. Forever hat seine Schlachtfeld-Raten nicht veröffentlicht, zähle die Spiele also als grobe Richtschnur. Unter Stufe 50 gibt es die Ein-Abzeichen-Quest von {npc:14781} und die {quest:8368} des Kriegshetzer in einer Version für deine Stufengruppe (ab 20 und ab 10): einmal 200, dann 100 und 50 pro 3 Abzeichen.",
	-- {npc:15350} Horde Warbringer · {quest:8368} Battle of Warsong Gulch
	["{npc:15350}: {quest:8368} again, 50 reputation for 3 marks"] = "{npc:15350}: wieder {quest:8368}, 50 Ruf für 3 Abzeichen",

	-- Step 11: Warsong Outriders to Honored
	-- {faction:889} Warsong Outriders
	["{faction:889} to Honored"] = "{faction:889} bis Wohlwollend",
	-- {npc:14754} Kelm Hargunth · {npc:14781} Captain Shatterskull · {item:21567} Rune of Duty · {item:21565} Rune of Perfection
	["Friendly to Honored is 6000 reputation, about 39 wins at the Classic rate. Friendly opens the first rewards at {npc:14754} beside {npc:14781}: the {item:21567} and {item:21565} trinkets (2g at level 20, 4g at level 40) and food, bandages and draughts that work in the battleground (5s to 20s). He also gives one Outrider care package at Friendly (pick the one for your level): 10 reputation and a bag of battleground food and bandages."] = "Von Freundlich bis Wohlwollend sind es 6000 Ruf, bei der Rate von Classic etwa 39 Siege. Freundlich öffnet die ersten Belohnungen bei {npc:14754} neben {npc:14781}: die Schmuckstücke {item:21567} und {item:21565} (2g auf Stufe 20, 4g auf Stufe 40) und Essen, Verbände und Tränke, die im Schlachtfeld funktionieren (5s bis 20s). Er gibt dir bei Freundlich auch ein Outrider-Fürsorgepaket (wähle das für deine Stufe): 10 Ruf und eine Tasche mit Schlachtfeld-Essen und Verbänden.",
	-- {npc:14754} Kelm Hargunth
	["{npc:14754}: Friendly rewards"] = "{npc:14754}: Belohnungen bei Freundlich",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: 50 reputation for 3 marks"] = "{npc:15350}: 50 Ruf für 3 Abzeichen",

	-- Step 12: Warsong Outriders to Revered
	-- {faction:889} Warsong Outriders
	["{faction:889} to Revered"] = "{faction:889} bis Respektvoll",
	-- {item:19526} Battle Healer's Cloak · {item:19534} Scout's Medallion · {item:19518} Advisor's Ring · {item:19510} Legionnaire's Band
	["Honored to Revered is 12000 reputation, about 78 wins. Honored opens the {item:19526}, {item:19534} (neck), {item:19518} and {item:19510}, each sold for levels 18, 28, 38, 48 and 58 (cloak 36s50c to 9g6s, the rest 2g to 7g50s), and the Major Healing and Mana Draughts (10s)."] = "Von Wohlwollend bis Respektvoll sind es 12000 Ruf, etwa 78 Siege. Wohlwollend öffnet {item:19526}, {item:19534} (Hals), {item:19518} und {item:19510}, jeweils verkauft für die Stufen 18, 28, 38, 48 und 58 (Umhang 36s50c bis 9g6s, der Rest 2g bis 7g50s), und die Großen Heil- und Manatränke (10s).",
	-- {npc:14754} Kelm Hargunth
	["{npc:14754}: Honored rewards"] = "{npc:14754}: Belohnungen bei Wohlwollend",

	-- Step 13: Warsong Outriders to Exalted
	-- {faction:889} Warsong Outriders
	["{faction:889} to Exalted"] = "{faction:889} bis Ehrfürchtig",
	-- {item:19542} Scout's Blade · {item:19550} Legionnaire's Sword · {item:19558} Outrider's Bow · {item:19566} Advisor's Gnarled Staff
	["Revered to Exalted is 21000 reputation, about 136 wins: half of the whole climb. Revered opens the weapons for levels 18 to 58: {item:19542} (dagger), {item:19550}, {item:19558} and {item:19566} (91s to 35g9s). Forever's quartermaster also sells level-25 versions of the four weapons, Resilient helms for level 20 (2g50s) and the Trainee's Outrider Wolf mount (level 25, 10g) with no standing listed."] = "Von Respektvoll bis Ehrfürchtig sind es 21000 Ruf, etwa 136 Siege: die Hälfte des ganzen Aufstiegs. Respektvoll öffnet die Waffen für die Stufen 18 bis 58: {item:19542} (Dolch), {item:19550}, {item:19558} und {item:19566} (91s bis 35g9s). Der Quartiermeister von Forever verkauft außerdem Versionen der vier Waffen für Stufe 25, Resilient-Helme für Stufe 20 (2g50s) und das Reittier Trainee's Outrider Wolf (Stufe 25, 10g), ohne dass ein Ruf angegeben ist.",
	-- {npc:14754} Kelm Hargunth
	["{npc:14754}: Revered rewards"] = "{npc:14754}: Belohnungen bei Respektvoll",

	-- Step 14: Kelm Hargunth
	-- {item:19578} Berserker Bracers · {item:19582} Windtalker's Wristguards · {item:19587} Forest Stalker's Bracers · {item:19595} Dryad's Wrist Bindings · {item:19505} Warsong Battle Tabard
	["Exalted gives the Legacy Point \"Master of Warsong Gulch\" and opens the epics: {item:19578} (plate), {item:19582} (mail), {item:19587} (leather) and {item:19595} (cloth) for levels 40, 50 and 60 (2g47s to 12g11s), and the level 60 Outrider's legs in plate, chain, mail, leather, lizardhide and silk (16g57s to 25g33s). The {item:19505} is 5g."] = "Ehrfürchtig gibt den Vermächtnispunkt „Master of Warsong Gulch“ und öffnet die Epics: {item:19578} (Platte), {item:19582} (Kette), {item:19587} (Leder) und {item:19595} (Stoff) für die Stufen 40, 50 und 60 (2g47s bis 12g11s) sowie den Beinschutz des Outrider der Stufe 60 in Platte, Kette, Schuppen, Leder, Echsenhaut und Seide (16g57s bis 25g33s). Das {item:19505} kostet 5g.",
	-- {item:19505} Warsong Battle Tabard
	["{item:19505}, 5g"] = "{item:19505}, 5g",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Exalted with the {faction:889} earns a Legacy Point."] = "Ehrfürchtig bei {faction:889} bringt einen Vermächtnispunkt.",
	-- ["Exalted with the {faction:890} earns a Legacy Point."] = "Ehrfürchtig bei {faction:890} bringt einen Vermächtnispunkt.",
	-- ["Keep capturing flags in {zone:1460}."] = "Erobere weiter Flaggen in {zone:1460}.",
	-- ["Keep playing {zone:1460} and capturing flags. On Call to Arms: {zone:1460} weekends the {npc:15350} in the capitals takes three Warsong Gulch Marks of Honor for extra reputation."] = "Spiel weiter {zone:1460} und erobere Flaggen. An Wochenenden mit „Zu den Waffen: {zone:1460}“ nimmt {npc:15350} in den Hauptstädten drei Ehrenabzeichen der Warsongschlucht für zusätzlichen Ruf an.",
	-- ["Keep playing {zone:1460} and capturing flags. On Call to Arms: {zone:1460} weekends the {npc:15351} in the capitals takes three Warsong Gulch Marks of Honor for extra reputation."] = "Spiel weiter {zone:1460} und erobere Flaggen. An Wochenenden mit „Zu den Waffen: {zone:1460}“ nimmt {npc:15351} in den Hauptstädten drei Ehrenabzeichen der Warsongschlucht für zusätzlichen Ruf an.",
	-- ["The {faction:889} are the Orcs logging {zone:1440}. Their reputation comes from the battleground: every enemy flag your team captures pays it to the whole team. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:889} sind die Orcs, die in {zone:1440} Holz schlagen. Ihr Ruf kommt vom Schlachtfeld: Jede gegnerische Flagge, die dein Team erobert, bringt dem ganzen Team Ruf. Melde dich bei einem beliebigen Kampfmeister an. Forevers Vermächtnis-Vorteil „Diplomat“ erhöht den Rufgewinn.",
	-- ["The {faction:890} are the Night Elves holding {zone:1460}. Their reputation comes from the battleground: every enemy flag your team captures pays it to the whole team. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:890} sind die Nachtelfen, die {zone:1460} halten. Ihr Ruf kommt vom Schlachtfeld: Jede gegnerische Flagge, die dein Team erobert, bringt dem ganzen Team Ruf. Melde dich bei einem beliebigen Kampfmeister an. Forevers Vermächtnis-Vorteil „Diplomat“ erhöht den Rufgewinn.",
	-- ["{npc:14733} takes Warsong Gulch Marks of Honor for Vanquish the Invaders!, once per level bracket (data); check them live."] = "{npc:14733} nimmt Ehrenabzeichen der Warsongschlucht für Besiegt die Eindringlinge! an, einmal pro Stufenbereich (laut Daten); prüf es im Spiel.",
	-- ["{npc:14753} hands out one Sentinel care package by level"] = "{npc:14753} gibt ein Überlebenspaket der Schildwache pro Stufe aus",
	-- ["{npc:14754} hands out one Outrider care package by level"] = "{npc:14754} gibt ein Überlebenspaket der Vorhut pro Stufe aus",
	-- ["{npc:14781} takes Warsong Gulch Marks of Honor for Quell the Silverwing Usurpers, once per level bracket (data); check them live."] = "{npc:14781} nimmt Ehrenabzeichen der Warsongschlucht für Bezwingt die Eindringlinge der Silverwing an, einmal pro Stufenbereich (laut Daten); prüf es im Spiel.",
}
