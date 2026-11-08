-- French (frFR): the guide forever/reputation/warsong-gulch (forever/reputation/warsong-gulch.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Warsong Gulch Reputation"] = "Réputation : Goulet des Chanteguerres",
	["Flag captures and Marks of Honor raise it; Exalted gives a Legacy Point and epic bracers and legs."] = "Les captures de drapeau et les marques d'honneur la font monter ; Exalté donne un point d'Héritage et des brassards et jambières épiques.",
	["Master of Warsong Gulch: a Legacy Point at Exalted"] = "Master of Warsong Gulch : un point d'Héritage à Exalté",

	-- Step 1: Sentinel Farsong
	-- {zone:1460} Warsong Gulch · {npc:14733} Sentinel Farsong
	["{zone:1460} is a 10 against 10 capture-the-flag battle, from level 10. Queue at any battlemaster in the capitals or from the battleground screen. In Classic every flag your team captures pays everyone 35 reputation (45 on the {zone:1460} holiday weekend), and a game pays 3 Warsong Gulch Marks of Honor for a win, 1 for a loss. {npc:14733} pays 200 reputation for one mark, once per character: the best mark you will ever turn in. Forever's Legacy Diplomat perk adds up to 10% to every number in this guide."] = "Le {zone:1460} est une bataille de capture du drapeau à 10 contre 10, dès le niveau 10. Inscrivez-vous auprès de n'importe quel maître de guerre des capitales ou depuis l'écran des champs de bataille. Dans Classic, chaque drapeau capturé par votre équipe rapporte 35 de réputation à chacun (45 pendant le week-end du {zone:1460}), et une partie rapporte 3 marques d'honneur du goulet des Chanteguerres en cas de victoire, 1 en cas de défaite. {npc:14733} donne 200 de réputation pour une marque, une fois par personnage : la meilleure marque que vous rendrez jamais. L'atout Diplomate de l'Héritage de Forever ajoute jusqu'à 10 % à chaque chiffre de ce guide.",
	-- {item:20558} Warsong Gulch Mark of Honor
	["one {item:20558}: play a game"] = "une {item:20558} : jouez une partie",

	-- Step 2: Alliance Brigadier General
	-- {npc:15351} Alliance Brigadier General · {quest:8372} Fight for Warsong Gulch · {npc:14733} Sentinel Farsong · {zone:1453} Stormwind · {zone:1455} Ironforge · {zone:1457} Darnassus · {object:2685} Refuge Pointe (no name in this language: may be words) · {zone:1417} Arathi Highlands · {zone:1459} Alterac Valley · {zone:1460} Warsong Gulch
	["The {npc:15351} pays 100 reputation for 3 Warsong Gulch Marks of Honor the first time, then 50 for every 3 more ({quest:8372}). One stands right here at Silverwing Grove beside {npc:14733}; others in {zone:1453}, {zone:1455} and {zone:1457}, at {object:2685} in the {zone:1417} and at both gates of {zone:1459}. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1460} marks: hand in or spend them before you reach that."] = "",
	["three Warsong Gulch Marks of Honor"] = "trois marques d'honneur du goulet des Chanteguerres",

	-- Step 3: Silverwing Sentinels to Friendly
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Friendly"] = "{faction:890} jusqu'à Amical",
	-- {npc:14733} Sentinel Farsong · {quest:8372} Fight for Warsong Gulch
	["Neutral to Friendly is 3000 reputation. In Classic a 3-capture win paid 105, and its 3 marks bring 50 more at the Brigadier General: about 155 a win, so some 20 wins. Losses still pay 35 for each flag your team captured. Forever has not published its battleground rates, so count the games as a rough guide. Below level 50, {npc:14733}'s one-mark quest and the Brigadier General's {quest:8372} come in a version for your bracket (from 20 and from 10): 200 once, then 100 and 50 per 3 marks."] = "De Neutre à Amical, il faut 3000 de réputation. Dans Classic, une victoire à 3 captures rapportait 105, et ses 3 marques donnent 50 de plus auprès du général de brigade : environ 155 par victoire, soit une vingtaine de victoires. Les défaites rapportent quand même 35 par drapeau capturé par votre équipe. Forever n'a pas publié ses taux de champ de bataille : prenez ce nombre de parties comme un ordre de grandeur. Sous le niveau 50, la quête à une marque de {npc:14733} et la quête {quest:8372} du général de brigade existent dans une version pour votre tranche (dès 20 et dès 10) : 200 une fois, puis 100 et 50 par lot de 3 marques.",
	-- {npc:15351} Alliance Brigadier General · {quest:8372} Fight for Warsong Gulch
	["{npc:15351}: {quest:8372} again, 50 reputation for 3 marks"] = "{npc:15351} : de nouveau {quest:8372}, 50 de réputation pour 3 marques",

	-- Step 4: Silverwing Sentinels to Honored
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Honored"] = "{faction:890} jusqu'à Honoré",
	-- {npc:14753} Illiyana Moonblaze · {npc:14733} Sentinel Farsong · {item:21567} Rune of Duty · {item:21565} Rune of Perfection
	["Friendly to Honored is 6000 reputation, about 39 wins at the Classic rate. Friendly opens the first rewards at {npc:14753} beside {npc:14733}: the {item:21567} and {item:21565} trinkets (2g at level 20, 4g at level 40) and food, bandages and draughts that work in the battleground (5s to 20s). She also gives one Sentinel care package at Friendly (pick the one for your level): 10 reputation and a bag of battleground food and bandages."] = "D'Amical à Honoré, il faut 6000 de réputation, environ 39 victoires au taux de Classic. Amical débloque les premières récompenses chez {npc:14753}, à côté de {npc:14733} : les bijoux {item:21567} et {item:21565} (2 po au niveau 20, 4 po au niveau 40) et de la nourriture, des bandages et des breuvages qui fonctionnent dans le champ de bataille (5 pa à 20 pa). Elle donne aussi un colis de Sentinelle à Amical (prenez celui de votre niveau) : 10 de réputation et un sac de nourriture et de bandages de champ de bataille.",
	-- {npc:14753} Illiyana Moonblaze
	["{npc:14753}: Friendly rewards"] = "{npc:14753} : récompenses d'Amical",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: 50 reputation for 3 marks"] = "{npc:15351} : 50 de réputation pour 3 marques",

	-- Step 5: Silverwing Sentinels to Revered
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Revered"] = "{faction:890} jusqu'à Révéré",
	-- {item:19530} Caretaker's Cape · {item:19538} Sentinel's Medallion · {item:19522} Lorekeeper's Ring · {item:19514} Protector's Band
	["Honored to Revered is 12000 reputation, about 78 wins. Honored opens the {item:19530} (cloak), {item:19538} (neck), {item:19522} and {item:19514}, each sold for levels 18, 28, 38, 48 and 58 (cloak 36s50c to 8g55s, the rest 2g to 7g50s), and the Major Healing and Mana Draughts (10s)."] = "D'Honoré à Révéré, il faut 12000 de réputation, environ 78 victoires. Honoré débloque {item:19530} (cape), {item:19538} (cou), {item:19522} et {item:19514}, chacun vendu pour les niveaux 18, 28, 38, 48 et 58 (cape de 36 pa 50 pc à 8 po 55 pa, le reste de 2 po à 7 po 50 pa), et les breuvages de soins majeurs et de mana majeurs (10 pa).",
	-- {npc:14753} Illiyana Moonblaze
	["{npc:14753}: Honored rewards"] = "{npc:14753} : récompenses d'Honoré",

	-- Step 6: Silverwing Sentinels to Exalted
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Exalted"] = "{faction:890} jusqu'à Exalté",
	-- {item:19546} Sentinel's Blade · {item:19554} Protector's Sword · {item:19562} Outrunner's Bow · {item:19570} Lorekeeper's Staff
	["Revered to Exalted is 21000 reputation, about 136 wins: half of the whole climb. Revered opens the weapons for levels 18 to 58: {item:19546} (dagger), {item:19554}, {item:19562} and {item:19570} (91s to 35g61s). Forever's quartermaster also sells level-25 versions of the four weapons, Resilient helms for level 20 (2g50s) and the Trainee's Sentinel Nightsaber mount (level 25, 10g) with no standing listed."] = "De Révéré à Exalté, il faut 21000 de réputation, environ 136 victoires : la moitié de toute l'ascension. Révéré débloque les armes des niveaux 18 à 58 : {item:19546} (dague), {item:19554}, {item:19562} et {item:19570} (91 pa à 35 po 61 pa). L'intendante de Forever vend aussi des versions de niveau 25 des quatre armes, des heaumes Resilient de niveau 20 (2 po 50 pa) et la monture Trainee's Sentinel Nightsaber (niveau 25, 10 po), sans réputation indiquée.",
	-- {npc:14753} Illiyana Moonblaze
	["{npc:14753}: Revered rewards"] = "{npc:14753} : récompenses Révéré",

	-- Step 7: Illiyana Moonblaze
	-- {item:19578} Berserker Bracers · {item:19582} Windtalker's Wristguards · {item:19587} Forest Stalker's Bracers · {item:19595} Dryad's Wrist Bindings · {item:19506} Silverwing Battle Tabard
	["Exalted gives the Legacy Point \"Master of Warsong Gulch\" and opens the epics: {item:19578} (plate), {item:19582} (mail), {item:19587} (leather) and {item:19595} (cloth) for levels 40, 50 and 60 (2g47s to 12g11s), and the level 60 Sentinel's legs in plate, lamellar, chain, leather, lizardhide and silk (16g63s to 24g22s). The {item:19506} is 5g."] = "Exalté donne le point d'Héritage « Master of Warsong Gulch » et débloque les épiques : {item:19578} (plaques), {item:19582} (mailles), {item:19587} (cuir) et {item:19595} (tissu) pour les niveaux 40, 50 et 60 (2 po 47 pa à 12 po 11 pa), et les jambières de Sentinelle de niveau 60 en plaques, lamellaire, mailles, cuir, peau de lézard et soie (16 po 63 pa à 24 po 22 pa). Le {item:19506} coûte 5 po.",
	-- {item:19506} Silverwing Battle Tabard
	["{item:19506}, 5g"] = "{item:19506}, 5 po",

	-- Step 8: Captain Shatterskull
	-- {zone:1460} Warsong Gulch · {npc:14781} Captain Shatterskull
	["{zone:1460} is a 10 against 10 capture-the-flag battle, from level 10. Queue at any battlemaster in the capitals or from the battleground screen; the Horde gate is here at Mor'shan Base Camp. In Classic every flag your team captures pays everyone 35 reputation (45 on the {zone:1460} holiday weekend), and a game pays 3 Warsong Gulch Marks of Honor for a win, 1 for a loss. {npc:14781} pays 200 reputation for one mark, once per character: the best mark you will ever turn in. Forever's Legacy Diplomat perk adds up to 10% to every number in this guide."] = "",

	-- Step 9: Horde Warbringer
	-- {npc:15350} Horde Warbringer · {quest:8368} Battle of Warsong Gulch · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {zone:1458} Undercity · {zone:1417} Arathi Highlands · {zone:1459} Alterac Valley · {zone:1416} Alterac Mountains · {zone:1460} Warsong Gulch
	["The {npc:15350} pays 100 reputation for 3 Warsong Gulch Marks of Honor the first time, then 50 for every 3 more ({quest:8368}). One stands right here at Mor'shan; others in {zone:1454}, {zone:1456} (and on the plain below it) and the {zone:1458}, at Hammerfall in the {zone:1417} and at the {zone:1459} gate in the {zone:1416}. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1460} marks: hand in or spend them before you reach that."] = "",

	-- Step 10: Warsong Outriders to Friendly
	-- {faction:889} Warsong Outriders
	["{faction:889} to Friendly"] = "{faction:889} jusqu'à Amical",
	-- {npc:14781} Captain Shatterskull · {quest:8368} Battle of Warsong Gulch
	["Neutral to Friendly is 3000 reputation. In Classic a 3-capture win paid 105, and its 3 marks bring 50 more at the Warbringer: about 155 a win, so some 20 wins. Losses still pay 35 for each flag your team captured. Forever has not published its battleground rates, so count the games as a rough guide. Below level 50, {npc:14781}'s one-mark quest and the Warbringer's {quest:8368} come in a version for your bracket (from 20 and from 10): 200 once, then 100 and 50 per 3 marks."] = "De Neutre à Amical, il faut 3000 de réputation. Dans Classic, une victoire à 3 captures rapportait 105, et ses 3 marques donnent 50 de plus auprès du Porteguerre : environ 155 par victoire, soit une vingtaine de victoires. Les défaites rapportent quand même 35 par drapeau capturé par votre équipe. Forever n'a pas publié ses taux de champ de bataille : prenez ce nombre de parties comme un ordre de grandeur. Sous le niveau 50, la quête à une marque de {npc:14781} et la quête {quest:8368} du Porteguerre existent dans une version pour votre tranche (dès 20 et dès 10) : 200 une fois, puis 100 et 50 par lot de 3 marques.",
	-- {npc:15350} Horde Warbringer · {quest:8368} Battle of Warsong Gulch
	["{npc:15350}: {quest:8368} again, 50 reputation for 3 marks"] = "{npc:15350} : de nouveau {quest:8368}, 50 de réputation pour 3 marques",

	-- Step 11: Warsong Outriders to Honored
	-- {faction:889} Warsong Outriders
	["{faction:889} to Honored"] = "{faction:889} jusqu'à Honoré",
	-- {npc:14754} Kelm Hargunth · {npc:14781} Captain Shatterskull · {item:21567} Rune of Duty · {item:21565} Rune of Perfection
	["Friendly to Honored is 6000 reputation, about 39 wins at the Classic rate. Friendly opens the first rewards at {npc:14754} beside {npc:14781}: the {item:21567} and {item:21565} trinkets (2g at level 20, 4g at level 40) and food, bandages and draughts that work in the battleground (5s to 20s). He also gives one Outrider care package at Friendly (pick the one for your level): 10 reputation and a bag of battleground food and bandages."] = "D'Amical à Honoré, il faut 6000 de réputation, environ 39 victoires au taux de Classic. Amical débloque les premières récompenses chez {npc:14754}, à côté de {npc:14781} : les bijoux {item:21567} et {item:21565} (2 po au niveau 20, 4 po au niveau 40) et de la nourriture, des bandages et des breuvages qui fonctionnent dans le champ de bataille (5 pa à 20 pa). Il donne aussi un colis de Voltigeur à Amical (prenez celui de votre niveau) : 10 de réputation et un sac de nourriture et de bandages de champ de bataille.",
	-- {npc:14754} Kelm Hargunth
	["{npc:14754}: Friendly rewards"] = "{npc:14754} : récompenses d'Amical",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: 50 reputation for 3 marks"] = "{npc:15350} : 50 de réputation pour 3 marques",

	-- Step 12: Warsong Outriders to Revered
	-- {faction:889} Warsong Outriders
	["{faction:889} to Revered"] = "{faction:889} jusqu'à Révéré",
	-- {item:19526} Battle Healer's Cloak · {item:19534} Scout's Medallion · {item:19518} Advisor's Ring · {item:19510} Legionnaire's Band
	["Honored to Revered is 12000 reputation, about 78 wins. Honored opens the {item:19526}, {item:19534} (neck), {item:19518} and {item:19510}, each sold for levels 18, 28, 38, 48 and 58 (cloak 36s50c to 9g6s, the rest 2g to 7g50s), and the Major Healing and Mana Draughts (10s)."] = "D'Honoré à Révéré, il faut 12000 de réputation, environ 78 victoires. Honoré débloque {item:19526}, {item:19534} (cou), {item:19518} et {item:19510}, chacun vendu pour les niveaux 18, 28, 38, 48 et 58 (cape de 36 pa 50 pc à 9 po 6 pa, le reste de 2 po à 7 po 50 pa), et les breuvages de soins majeurs et de mana majeurs (10 pa).",
	-- {npc:14754} Kelm Hargunth
	["{npc:14754}: Honored rewards"] = "{npc:14754} : récompenses d'Honoré",

	-- Step 13: Warsong Outriders to Exalted
	-- {faction:889} Warsong Outriders
	["{faction:889} to Exalted"] = "{faction:889} jusqu'à Exalté",
	-- {item:19542} Scout's Blade · {item:19550} Legionnaire's Sword · {item:19558} Outrider's Bow · {item:19566} Advisor's Gnarled Staff
	["Revered to Exalted is 21000 reputation, about 136 wins: half of the whole climb. Revered opens the weapons for levels 18 to 58: {item:19542} (dagger), {item:19550}, {item:19558} and {item:19566} (91s to 35g9s). Forever's quartermaster also sells level-25 versions of the four weapons, Resilient helms for level 20 (2g50s) and the Trainee's Outrider Wolf mount (level 25, 10g) with no standing listed."] = "De Révéré à Exalté, il faut 21000 de réputation, environ 136 victoires : la moitié de toute l'ascension. Révéré débloque les armes des niveaux 18 à 58 : {item:19542} (dague), {item:19550}, {item:19558} et {item:19566} (91 pa à 35 po 9 pa). L'intendant de Forever vend aussi des versions de niveau 25 des quatre armes, des heaumes Resilient de niveau 20 (2 po 50 pa) et la monture Trainee's Outrider Wolf (niveau 25, 10 po), sans réputation indiquée.",
	-- {npc:14754} Kelm Hargunth
	["{npc:14754}: Revered rewards"] = "{npc:14754} : récompenses Révéré",

	-- Step 14: Kelm Hargunth
	-- {item:19578} Berserker Bracers · {item:19582} Windtalker's Wristguards · {item:19587} Forest Stalker's Bracers · {item:19595} Dryad's Wrist Bindings · {item:19505} Warsong Battle Tabard
	["Exalted gives the Legacy Point \"Master of Warsong Gulch\" and opens the epics: {item:19578} (plate), {item:19582} (mail), {item:19587} (leather) and {item:19595} (cloth) for levels 40, 50 and 60 (2g47s to 12g11s), and the level 60 Outrider's legs in plate, chain, mail, leather, lizardhide and silk (16g57s to 25g33s). The {item:19505} is 5g."] = "Exalté donne le point d'Héritage « Master of Warsong Gulch » et débloque les épiques : {item:19578} (plaques), {item:19582} (mailles), {item:19587} (cuir) et {item:19595} (tissu) pour les niveaux 40, 50 et 60 (2 po 47 pa à 12 po 11 pa), et les jambières de Voltigeur de niveau 60 en plaques, chaînes, mailles, cuir, peau de lézard et soie (16 po 57 pa à 25 po 33 pa). Le {item:19505} coûte 5 po.",
	-- {item:19505} Warsong Battle Tabard
	["{item:19505}, 5g"] = "{item:19505}, 5 po",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Exalted with the {faction:889} earns a Legacy Point."] = "Être Exalté auprès des {faction:889} rapporte un point d'Héritage.",
	-- ["Exalted with the {faction:890} earns a Legacy Point."] = "Être Exalté auprès des {faction:890} rapporte un point d'Héritage.",
	-- ["Keep capturing flags in {zone:1460}."] = "Continuez à capturer des drapeaux au {zone:1460}.",
	-- ["Keep playing {zone:1460} and capturing flags. On Call to Arms: {zone:1460} weekends the {npc:15350} in the capitals takes three Warsong Gulch Marks of Honor for extra reputation."] = "Continuez à jouer au {zone:1460} et à capturer des drapeaux. Pendant les week-ends de l'Appel aux armes du {zone:1460}, {npc:15350} des capitales prend trois Marques d'honneur du goulet des Chanteguerres contre un supplément de réputation.",
	-- ["Keep playing {zone:1460} and capturing flags. On Call to Arms: {zone:1460} weekends the {npc:15351} in the capitals takes three Warsong Gulch Marks of Honor for extra reputation."] = "Continuez à jouer au {zone:1460} et à capturer des drapeaux. Pendant les week-ends de l'Appel aux armes du {zone:1460}, {npc:15351} des capitales prend trois Marques d'honneur du goulet des Chanteguerres contre un supplément de réputation.",
	-- ["The {faction:889} are the Orcs logging {zone:1440}. Their reputation comes from the battleground: every enemy flag your team captures pays it to the whole team. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "Les {faction:889} sont les orcs qui exploitent le bois d'{zone:1440}. Leur réputation vient du champ de bataille : chaque drapeau ennemi capturé par votre équipe en rapporte à toute l'équipe. Inscrivez-vous auprès de n'importe quel maître de guerre. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",
	-- ["The {faction:890} are the Night Elves holding {zone:1460}. Their reputation comes from the battleground: every enemy flag your team captures pays it to the whole team. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "Les {faction:890} sont les elfes de la nuit qui tiennent le {zone:1460}. Leur réputation vient du champ de bataille : chaque drapeau ennemi capturé par votre équipe en rapporte à toute l'équipe. Inscrivez-vous auprès de n'importe quel maître de guerre. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",
	-- ["The {npc:15350} pays 100 reputation for 3 Warsong Gulch Marks of Honor the first time, then 50 for every 3 more ({quest:8368}). One stands right here at Mor'shan; others in {zone:1454}, {zone:1456} (and on the plain below it) and the {zone:1458}, at {area:321} in the {zone:1417} and at the {zone:1459} gate in the {zone:1416}. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1460} marks: hand in or spend them before you reach that."] = "Le {npc:15350} donne 100 de réputation pour 3 marques d'honneur du goulet des Chanteguerres la première fois, puis 50 pour chaque lot de 3 ({quest:8368}). L'un se tient ici même à Mor'shan ; d'autres à {zone:1454}, aux {zone:1456} (et dans la plaine en contrebas) et à {zone:1458}, à {area:321} dans les {zone:1417} et à la porte de la {zone:1459} dans les {zone:1416}. L'équipement JcJ de Forever coûte aussi des marques d'honneur en plus de l'honneur : décidez ce que vous voulez avant de les rendre. Vous pouvez porter au plus 30 marques du {zone:1460} : rendez-les ou dépensez-les avant d'y arriver.",
	-- ["The {npc:15351} pays 100 reputation for 3 Warsong Gulch Marks of Honor the first time, then 50 for every 3 more ({quest:8372}). One stands right here at {area:3319} beside {npc:14733}; others in {zone:1453}, {zone:1455} and {zone:1457}, at {area:320} in the {zone:1417} and at both gates of {zone:1459}. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1460} marks: hand in or spend them before you reach that."] = "Le {npc:15351} donne 100 de réputation pour 3 marques d'honneur du goulet des Chanteguerres la première fois, puis 50 pour chaque lot de 3 ({quest:8372}). L'un se tient ici même au {area:3319}, à côté de {npc:14733} ; d'autres à {zone:1453}, {zone:1455} et {zone:1457}, au {area:320} dans les {zone:1417} et aux deux portes de la {zone:1459}. L'équipement JcJ de Forever coûte aussi des marques d'honneur en plus de l'honneur : décidez ce que vous voulez avant de les rendre. Vous pouvez porter au plus 30 marques du {zone:1460} : rendez-les ou dépensez-les avant d'y arriver.",
	-- ["{npc:14733} takes Warsong Gulch Marks of Honor for Vanquish the Invaders!, once per level bracket (data); check them live."] = "{npc:14733} prend des Marques d'honneur du goulet des Chanteguerres pour Triomphez des envahisseurs !, une fois par tranche de niveau (données) ; vérifiez-les en jeu.",
	-- ["{npc:14753} hands out one Sentinel care package by level"] = "{npc:14753} donne un Paquetage de Sentinelle selon le niveau",
	-- ["{npc:14754} hands out one Outrider care package by level"] = "{npc:14754} donne un Paquetage de Voltigeur selon le niveau",
	-- ["{npc:14781} takes Warsong Gulch Marks of Honor for Quell the Silverwing Usurpers, once per level bracket (data); check them live."] = "{npc:14781} prend des Marques d'honneur du goulet des Chanteguerres pour Écrasez les usurpateurs d'Aile-argent, une fois par tranche de niveau (données) ; vérifiez-les en jeu.",
	-- ["{zone:1460} is a 10 against 10 capture-the-flag battle, from level 10. Queue at any battlemaster in the capitals or from the battleground screen; the Horde gate is here at {area:1599}. In Classic every flag your team captures pays everyone 35 reputation (45 on the {zone:1460} holiday weekend), and a game pays 3 Warsong Gulch Marks of Honor for a win, 1 for a loss. {npc:14781} pays 200 reputation for one mark, once per character: the best mark you will ever turn in. Forever's Legacy Diplomat perk adds up to 10% to every number in this guide."] = "Le {zone:1460} est une bataille de capture du drapeau à 10 contre 10, dès le niveau 10. Inscrivez-vous auprès de n'importe quel maître de guerre des capitales ou depuis l'écran des champs de bataille ; la porte de la Horde est ici, au {area:1599}. Dans Classic, chaque drapeau capturé par votre équipe rapporte 35 de réputation à chacun (45 pendant le week-end du {zone:1460}), et une partie rapporte 3 marques d'honneur du goulet des Chanteguerres en cas de victoire, 1 en cas de défaite. {npc:14781} donne 200 de réputation pour une marque, une fois par personnage : la meilleure marque que vous rendrez jamais. L'atout Diplomate de l'Héritage de Forever ajoute jusqu'à 10 % à chaque chiffre de ce guide.",
}
