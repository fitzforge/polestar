-- French (frFR): the guide forever/reputation/arathi-basin (forever/reputation/arathi-basin.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Arathi Basin Reputation"] = "Réputation : Bassin Arathi",
	["Every 200 resources your team gathers pays it; Exalted gives a Legacy Point, epic shoulders and the tabard."] = "Chaque tranche de 200 ressources que votre équipe récolte en rapporte ; Exalté donne un point d'héritage, des épaulières épiques et le tabard.",
	["Master of Arathi Basin: a Legacy Point at Exalted"] = "Master of Arathi Basin : un point d'héritage à Exalté",

	-- Step 1: Refuge Pointe
	-- {zone:1461} Arathi Basin
	["{zone:1461} is a 15 against 15 battle over five bases, from level 20: hold bases to gather resources, and the first team to 2000 wins. Queue at any battlemaster in the capitals or from the battleground screen. In Classic every 200 resources your team gathers pay everyone 10 reputation, so a win pays 100 and a close loss nearly as much; a game also pays 3 Arathi Basin Marks of Honor for a win, 1 for a loss. The three quests here pay 500 reputation together (200, 200 and 100), once. Forever's Legacy Diplomat perk adds up to 10% to every number in this guide."] = "{zone:1461} est une bataille à 15 contre 15 autour de cinq bases, dès le niveau 20 : tenez des bases pour récolter des ressources, et la première équipe à 2000 gagne. Inscrivez-vous auprès de n'importe quel maître de guerre des capitales ou depuis l'écran des champs de bataille. Dans Classic, chaque tranche de 200 ressources récoltées par votre équipe rapporte 10 de réputation à chacun, donc une victoire rapporte 100 et une défaite serrée presque autant ; une partie rapporte aussi 3 Marques d'honneur du bassin Arathi en cas de victoire, 1 en cas de défaite. Les trois quêtes ici rapportent 500 de réputation à elles toutes (200, 200 et 100), une seule fois. L'atout Diplomate de l'Héritage de Forever ajoute jusqu'à 10 % à chaque chiffre de ce guide.",
	-- {npc:14983} Field Marshal Oslight
	["{npc:14983}: assault four bases, 200"] = "{npc:14983} : attaquez quatre bases, 200",
	-- {npc:14984} Sergeant Maclear
	["{npc:14984}: one mark, 200"] = "{npc:14984} : une marque, 200",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: three marks, 100"] = "{npc:15351} : trois marques, 100",

	-- Step 2: Arathi Basin
	-- {npc:14984} Sergeant Maclear · {zone:1461} Arathi Basin
	["Assaulting a base means clicking its banner until it turns: you need not hold it. Four marks in all: one for {npc:14984}, three for the Brigadier General. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1461} marks: hand in or spend them before you reach that."] = "Attaquer une base, c'est cliquer sur sa bannière jusqu'à ce qu'elle change : inutile de la tenir. Quatre marques en tout : une pour {npc:14984}, trois pour le général de brigade. L'équipement JcJ de Forever coûte aussi des Marques d'honneur en plus de l'honneur : décidez de ce que vous voulez avant de les rendre. Vous pouvez porter au plus 30 marques de {zone:1461} : rendez-les ou dépensez-les avant d'atteindre ce nombre.",
	["Assault the Mine banner"] = "Attaquez la bannière de la mine",
	["Assault the Lumber Mill banner"] = "",
	["Assault the Blacksmith banner"] = "Attaquez la bannière de la forge",
	["Assault the Farm banner"] = "Attaquez la bannière de la ferme",
	-- {item:20559} Arathi Basin Mark of Honor
	["one {item:20559}"] = "une {item:20559}",
	["three more marks"] = "trois marques de plus",

	-- Step 3: Back to Refuge Pointe
	-- {object:2685} Refuge Pointe (no name in this language: may be words)
	["Back to {object:2685}"] = "",
	["hand in the three marks first"] = "rendez d'abord les trois marques",

	-- Step 4: League of Arathor to Friendly
	["League of Arathor to Friendly"] = "La Ligue d'Arathor : Amical",
	-- {quest:8374} Claiming Arathi Basin · {object:2685} Refuge Pointe (no name in this language: may be words)
	["Neutral to Friendly is 3000 reputation. In Classic a win paid 100 and its 3 marks bring 50 more at the Brigadier General ({quest:8374}, again and again): about 150 a win, some 20 wins. Forever has not published its battleground rates, so count the games as a rough guide. Below level 50 the quests at {object:2685} come in a version for your bracket (from level 20): 200 for assaulting the bases, 200 for one mark, then 100 and 50 per 3 marks at the Brigadier General."] = "",
	-- {npc:15351} Alliance Brigadier General · {quest:8374} Claiming Arathi Basin
	["{npc:15351}: {quest:8374} again, 50 reputation for 3 marks"] = "{npc:15351} : {quest:8374} à nouveau, 50 de réputation pour 3 marques",

	-- Step 5: Control Four Bases
	-- {npc:14983} Field Marshal Oslight · {quest:8115} Control Five Bases
	["At level 60 and Friendly, {npc:14983} asks your team to hold four bases at the same time: 200 reputation, once. It opens {quest:8115} for Exalted."] = "Au niveau 60 et Amical, {npc:14983} demande à votre équipe de tenir quatre bases en même temps : 200 de réputation, une seule fois. Cela débloque {quest:8115} pour Exalté.",
	["four bases held at once"] = "quatre bases tenues en même temps",

	-- Step 6: League of Arathor to Honored
	["League of Arathor to Honored"] = "La Ligue d'Arathor : Honoré",
	-- {npc:15127} Samuel Hawke · {npc:14983} Field Marshal Oslight · {item:20071} Talisman of Arathor · {zone:1461} Arathi Basin
	["Friendly to Honored is 6000 reputation, about 40 wins at the Classic rate. Friendly opens the first rewards at {npc:15127} beside {npc:14983}: the {item:20071} trinket for levels 28, 38, 48 and 58 (72s to 4g12s), and food and bandages that work in {zone:1461} (10s to 20s). He also gives one Arathor care package at Friendly (pick the one for your level): 10 reputation and a bag of battleground food and bandages."] = "D'Amical à Honoré, il faut 6000 de réputation, environ 40 victoires au taux de Classic. Amical débloque les premières récompenses chez {npc:15127}, à côté de {npc:14983} : le bijou {item:20071} pour les niveaux 28, 38, 48 et 58 (72 pa à 4 po 12 pa), et de la nourriture et des bandages qui fonctionnent dans {zone:1461} (10 pa à 20 pa). Il donne aussi un paquetage d'Arathor à Amical (prenez celui de votre niveau) : 10 de réputation et un sac de nourriture et de bandages de champ de bataille.",
	-- {npc:15127} Samuel Hawke
	["{npc:15127}: Friendly rewards"] = "{npc:15127} : récompenses Amical",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: 50 reputation for 3 marks"] = "{npc:15351} : 50 de réputation pour 3 marques",

	-- Step 7: League of Arathor to Revered
	["League of Arathor to Revered"] = "La Ligue d'Arathor : Révéré",
	["Honored to Revered is 12000 reputation, about 80 wins. Honored opens the Highlander's belts in plate, lamellar, chain, mail, leather, lizardhide and cloth for levels 28 to 58 (72s to 8g84s)."] = "D'Honoré à Révéré, il faut 12000 de réputation, environ 80 victoires. Honoré débloque les ceinturons des Hautes-terres en plaques, lamellaires, mailles, anneaux, cuir, peau de lézard et tissu pour les niveaux 28 à 58 (72 pa à 8 po 84 pa).",
	-- {npc:15127} Samuel Hawke
	["{npc:15127}: Honored rewards"] = "{npc:15127} : récompenses Honoré",

	-- Step 8: League of Arathor to Exalted
	["League of Arathor to Exalted"] = "La Ligue d'Arathor : Exalté",
	["Revered to Exalted is 21000 reputation, about 140 wins: half of the whole climb. Revered opens the Highlander's boots and greaves for levels 28 to 58 (1g7s to 13g65s), the ones with the run-speed bonus."] = "De Révéré à Exalté, il faut 21000 de réputation, environ 140 victoires : la moitié de toute l'ascension. Révéré débloque les bottes et grèves des Hautes-terres pour les niveaux 28 à 58 (1 po 7 pa à 13 po 65 pa), celles qui donnent un bonus de vitesse de course.",
	-- {npc:15127} Samuel Hawke
	["{npc:15127}: Revered rewards"] = "{npc:15127} : récompenses Révéré",

	-- Step 9: Samuel Hawke
	-- {item:20073} Cloak of the Honor Guard · {item:20069} Ironbark Staff
	["Exalted gives the Legacy Point \"Master of Arathi Basin\" and opens the epics: the level 60 Highlander's shoulders in every armor type (12g33s to 18g50s), {item:20073} (12g14s), {item:20069} (55g10s) and Sageclaw (44g24s), both from level 55."] = "Exalté donne le point d'héritage « Master of Arathi Basin » et débloque les épiques : les espauliers des Hautes-terres de niveau 60 dans chaque type d'armure (12 po 33 pa à 18 po 50 pa), la {item:20073} (12 po 14 pa), le {item:20069} (55 po 10 pa) et la Griffe du sage (44 po 24 pa), ces deux derniers dès le niveau 55.",
	-- {npc:15127} Samuel Hawke
	["{npc:15127}: Exalted rewards"] = "{npc:15127} : récompenses Exalté",

	-- Step 10: Control Five Bases
	-- {npc:14983} Field Marshal Oslight · {item:20132} Arathor Battle Tabard
	["At Exalted, {npc:14983} asks your team to hold all five bases at the same time. It pays 200 reputation and the {item:20132}, the only way to get it."] = "À Exalté, {npc:14983} demande à votre équipe de tenir les cinq bases en même temps. Cela rapporte 200 de réputation et le {item:20132}, seul moyen de l'obtenir.",
	["all five bases held at once"] = "les cinq bases tenues en même temps",

	-- Step 11: Hammerfall
	["Hammerfall"] = "",
	-- {npc:15021} Deathmaster Dwire
	["{npc:15021}: assault four bases, 200"] = "{npc:15021} : attaquez quatre bases, 200",
	-- {npc:15022} Deathstalker Mortis
	["{npc:15022}: one mark, 200"] = "{npc:15022} : une marque, 200",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: three marks, 100"] = "{npc:15350} : trois marques, 100",

	-- Step 12: Arathi Basin
	-- {npc:15022} Deathstalker Mortis · {zone:1461} Arathi Basin
	["Assaulting a base means clicking its banner until it turns: you need not hold it. Four marks in all: one for {npc:15022}, three for the Warbringer. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1461} marks: hand in or spend them before you reach that."] = "Attaquer une base, c'est cliquer sur sa bannière jusqu'à ce qu'elle change : inutile de la tenir. Quatre marques en tout : une pour {npc:15022}, trois pour le Porteguerre. L'équipement JcJ de Forever coûte aussi des Marques d'honneur en plus de l'honneur : décidez de ce que vous voulez avant de les rendre. Vous pouvez porter au plus 30 marques de {zone:1461} : rendez-les ou dépensez-les avant d'atteindre ce nombre.",
	["Assault the Stables banner"] = "Attaquez la bannière des écuries",

	-- Step 13: Back to Hammerfall
	["Back to Hammerfall"] = "",

	-- Step 14: The Defilers to Friendly
	-- {faction:510} The Defilers
	["{faction:510} to Friendly"] = "{faction:510} : Amical",
	-- {quest:8370} Conquering Arathi Basin
	["Neutral to Friendly is 3000 reputation. In Classic a win paid 100 and its 3 marks bring 50 more at the Warbringer ({quest:8370}, again and again): about 150 a win, some 20 wins. Forever has not published its battleground rates, so count the games as a rough guide. Below level 50 the quests at Hammerfall come in a version for your bracket (from level 20): 200 for assaulting the bases, 200 for one mark, then 100 and 50 per 3 marks at the Warbringer."] = "",
	-- {npc:15350} Horde Warbringer · {quest:8370} Conquering Arathi Basin
	["{npc:15350}: {quest:8370} again, 50 reputation for 3 marks"] = "{npc:15350} : {quest:8370} à nouveau, 50 de réputation pour 3 marques",

	-- Step 15: Take Four Bases
	-- {npc:15021} Deathmaster Dwire · {quest:8122} Take Five Bases
	["At level 60 and Friendly, {npc:15021} asks your team to hold four bases at the same time: 200 reputation, once. It opens {quest:8122} for Exalted."] = "Au niveau 60 et Amical, {npc:15021} demande à votre équipe de tenir quatre bases en même temps : 200 de réputation, une seule fois. Cela débloque {quest:8122} pour Exalté.",

	-- Step 16: The Defilers to Honored
	-- {faction:510} The Defilers
	["{faction:510} to Honored"] = "{faction:510} : Honoré",
	-- {npc:15126} Rutherford Twing · {npc:15021} Deathmaster Dwire · {item:20072} Defiler's Talisman · {zone:1461} Arathi Basin
	["Friendly to Honored is 6000 reputation, about 40 wins at the Classic rate. Friendly opens the first rewards at {npc:15126} beside {npc:15021}: the {item:20072} trinket for levels 28, 38, 48 and 58 (72s to 4g12s), and food and bandages that work in {zone:1461} (10s to 20s). He also gives one Defiler's care package at Friendly (pick the one for your level): 10 reputation and a bag of battleground food and bandages."] = "D'Amical à Honoré, il faut 6000 de réputation, environ 40 victoires au taux de Classic. Amical débloque les premières récompenses chez {npc:15126}, à côté de {npc:15021} : le bijou {item:20072} pour les niveaux 28, 38, 48 et 58 (72 pa à 4 po 12 pa), et de la nourriture et des bandages qui fonctionnent dans {zone:1461} (10 pa à 20 pa). Il donne aussi un paquetage de Profanateur à Amical (prenez celui de votre niveau) : 10 de réputation et un sac de nourriture et de bandages de champ de bataille.",
	-- {npc:15126} Rutherford Twing
	["{npc:15126}: Friendly rewards"] = "{npc:15126} : récompenses Amical",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: 50 reputation for 3 marks"] = "{npc:15350} : 50 de réputation pour 3 marques",

	-- Step 17: The Defilers to Revered
	-- {faction:510} The Defilers
	["{faction:510} to Revered"] = "{faction:510} : Révéré",
	["Honored to Revered is 12000 reputation, about 80 wins. Honored opens the Defiler's belts in plate, lamellar, chain, mail, leather, lizardhide and cloth for levels 28 to 58 (75s to 8g78s)."] = "D'Honoré à Révéré, il faut 12000 de réputation, environ 80 victoires. Honoré débloque les ceinturons de profanateur en plaques, lamellaires, mailles, anneaux, cuir, peau de lézard et tissu pour les niveaux 28 à 58 (75 pa à 8 po 78 pa).",
	-- {npc:15126} Rutherford Twing
	["{npc:15126}: Honored rewards"] = "{npc:15126} : récompenses Honoré",

	-- Step 18: The Defilers to Exalted
	-- {faction:510} The Defilers
	["{faction:510} to Exalted"] = "{faction:510} : Exalté",
	["Revered to Exalted is 21000 reputation, about 140 wins: half of the whole climb. Revered opens the Defiler's boots and greaves for levels 28 to 58 (1g12s to 13g41s), the ones with the run-speed bonus."] = "De Révéré à Exalté, il faut 21000 de réputation, environ 140 victoires : la moitié de toute l'ascension. Révéré débloque les bottes et grèves de profanateur pour les niveaux 28 à 58 (1 po 12 pa à 13 po 41 pa), celles qui donnent un bonus de vitesse de course.",
	-- {npc:15126} Rutherford Twing
	["{npc:15126}: Revered rewards"] = "{npc:15126} : récompenses Révéré",

	-- Step 19: Rutherford Twing
	-- {item:20068} Deathguard's Cloak · {item:20069} Ironbark Staff
	["Exalted gives the Legacy Point \"Master of Arathi Basin\" and opens the epics: the level 60 Defiler's shoulders in every armor type (12g75s to 20g), {item:20068} (13g18s), {item:20069} (50g46s) and Mindfang (42g83s), both from level 55."] = "Exalté donne le point d'héritage « Master of Arathi Basin » et débloque les épiques : les espauliers de profanateur de niveau 60 dans chaque type d'armure (12 po 75 pa à 20 po), la {item:20068} (13 po 18 pa), le {item:20069} (50 po 46 pa) et le Croc de l'esprit (42 po 83 pa), ces deux derniers dès le niveau 55.",
	-- {npc:15126} Rutherford Twing
	["{npc:15126}: Exalted rewards"] = "{npc:15126} : récompenses Exalté",

	-- Step 20: Take Five Bases
	-- {npc:15021} Deathmaster Dwire · {item:20131} Battle Tabard of the Defilers
	["At Exalted, {npc:15021} asks your team to hold all five bases at the same time. It pays 200 reputation and the {item:20131}, the only way to get it."] = "À Exalté, {npc:15021} demande à votre équipe de tenir les cinq bases en même temps. Cela rapporte 200 de réputation et le {item:20131}, seul moyen de l'obtenir.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Assault the {area:3422} banner"] = "Attaquez la bannière de la {area:3422}",
	-- ["Back to {area:320}"] = "Retour à {area:320}",
	-- ["Back to {area:321}"] = "Retour à {area:321}",
	-- ["Exalted with the League of Arathor earns a Legacy Point."] = "Être exalté auprès de La Ligue d'Arathor rapporte un point d'héritage.",
	-- ["Exalted with {faction:510} earns a Legacy Point."] = "Être exalté auprès de {faction:510} rapporte un point d'héritage.",
	-- ["Keep playing {zone:1461}. On Call to Arms: {zone:1461} weekends the {npc:15350} in the capitals takes three Arathi Basin Marks of Honor for extra reputation."] = "Continuez à jouer au {zone:1461}. Pendant les week-ends de l'Appel aux armes du {zone:1461}, {npc:15350} des capitales prend trois Marques d'honneur du bassin d'Arathi contre un supplément de réputation.",
	-- ["Keep playing {zone:1461}. On Call to Arms: {zone:1461} weekends the {npc:15351} in the capitals takes three Arathi Basin Marks of Honor for extra reputation."] = "Continuez à jouer au {zone:1461}. Pendant les week-ends de l'Appel aux armes du {zone:1461}, {npc:15351} des capitales prend trois Marques d'honneur du bassin d'Arathi contre un supplément de réputation.",
	-- ["Keep playing {zone:1461}; wins with many bases held pay the most."] = "Continuez à jouer {zone:1461} ; les victoires avec beaucoup de bases tenues rapportent le plus.",
	-- ["Neutral to Friendly is 3000 reputation. In Classic a win paid 100 and its 3 marks bring 50 more at the Brigadier General ({quest:8374}, again and again): about 150 a win, some 20 wins. Forever has not published its battleground rates, so count the games as a rough guide. Below level 50 the quests at {area:320} come in a version for your bracket (from level 20): 200 for assaulting the bases, 200 for one mark, then 100 and 50 per 3 marks at the Brigadier General."] = "De Neutre à Amical, il faut 3000 de réputation. Dans Classic, une victoire rapportait 100 et ses 3 marques en rapportent 50 de plus chez le général de brigade ({quest:8374}, encore et encore) : environ 150 par victoire, soit une vingtaine de victoires. Forever n'a pas publié ses taux de champs de bataille, alors comptez les parties à titre indicatif. Sous le niveau 50, les quêtes de {area:320} existent en une version pour votre tranche (dès le niveau 20) : 200 pour l'attaque des bases, 200 pour une marque, puis 100 et 50 par lot de 3 marques chez le général de brigade.",
	-- ["Neutral to Friendly is 3000 reputation. In Classic a win paid 100 and its 3 marks bring 50 more at the Warbringer ({quest:8370}, again and again): about 150 a win, some 20 wins. Forever has not published its battleground rates, so count the games as a rough guide. Below level 50 the quests at {area:321} come in a version for your bracket (from level 20): 200 for assaulting the bases, 200 for one mark, then 100 and 50 per 3 marks at the Warbringer."] = "De Neutre à Amical, il faut 3000 de réputation. Dans Classic, une victoire rapportait 100 et ses 3 marques en rapportent 50 de plus chez le Porteguerre ({quest:8370}, encore et encore) : environ 150 par victoire, soit une vingtaine de victoires. Forever n'a pas publié ses taux de champs de bataille, alors comptez les parties à titre indicatif. Sous le niveau 50, les quêtes de {area:321} existent en une version pour votre tranche (dès le niveau 20) : 200 pour l'attaque des bases, 200 pour une marque, puis 100 et 50 par lot de 3 marques chez le Porteguerre.",
	-- ["{faction:509} fights for {zone:1461} from {area:320}. Their reputation comes from the battleground: the resources your team gathers pay it to everyone, so holding more bases for longer pays more. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:509} se bat pour {zone:1461} depuis {area:320}. Sa réputation vient du champ de bataille : les ressources que votre équipe accumule la rapportent à tous, donc tenir plus de bases plus longtemps rapporte plus. Inscrivez-vous auprès de n'importe quel maître de guerre. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",
	-- ["{faction:510} fight for {zone:1461} from {area:321}. Their reputation comes from the battleground: the resources your team gathers pay it to everyone, so holding more bases for longer pays more. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:510} se battent pour {zone:1461} depuis {area:321}. Leur réputation vient du champ de bataille : les ressources que votre équipe accumule la rapportent à tous, donc tenir plus de bases plus longtemps rapporte plus. Inscrivez-vous auprès de n'importe quel maître de guerre. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",
	-- ["{npc:14983}'s The Battle for {zone:1461}! (assault every base) and Control Four Bases / Control Five Bases are one-time quests; {npc:14984} beside him takes Arathi Resource Crates."] = "La bataille pour {zone:1461} ! de {npc:14983} (attaquer chaque base) et Contrôler quatre bases / Prendre cinq bases sont des quêtes uniques ; {npc:14984}, à côté de lui, prend les Caisses de ressources d'Arathi.",
	-- ["{npc:15021}'s The Battle for {zone:1461}! (assault every base) and Take Four Bases / Take Five Bases are one-time quests; {npc:15022} beside him takes Arathi Resource Crates."] = "La bataille pour {zone:1461} ! de {npc:15021} (attaquer chaque base) et Prendre quatre bases / Prendre cinq bases sont des quêtes uniques ; {npc:15022}, à côté de lui, prend les Caisses de ressources d'Arathi.",
	-- ["{npc:15126} hands out one Defiler's care package by level"] = "{npc:15126} remet un colis des Profanateurs par tranche de niveau",
	-- ["{npc:15127} hands out one Arathor care package by level"] = "{npc:15127} remet un colis d'Arathor par tranche de niveau",
}
