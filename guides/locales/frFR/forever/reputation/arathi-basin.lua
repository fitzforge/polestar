-- French (frFR): the guide forever/reputation/arathi-basin (forever/reputation/arathi-basin.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Arathi Basin Reputation"] = "Réputation : Bassin Arathi",

	-- Step 1: League of Arathor to Friendly
	["League of Arathor to Friendly"] = "La Ligue d'Arathor : Amical",
	-- {faction:509} The League of Arathor · {zone:1461} Arathi Basin · {area:320} Refuge Pointe
	["{faction:509} fights for {zone:1461} from {area:320}. Their reputation comes from the battleground: the resources your team gathers pay it to everyone, so holding more bases for longer pays more. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:509} se bat pour {zone:1461} depuis {area:320}. Sa réputation vient du champ de bataille : les ressources que votre équipe accumule la rapportent à tous, donc tenir plus de bases plus longtemps rapporte plus. Inscrivez-vous auprès de n'importe quel maître de guerre. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",
	-- {npc:14983} Field Marshal Oslight · {zone:1461} Arathi Basin · {npc:14984} Sergeant Maclear
	-- plural, as words: Arathi Resource Crates = {item:19725} Arathi Resource Crate
	["{npc:14983}'s The Battle for {zone:1461}! (assault every base) and Control Four Bases / Control Five Bases are one-time quests; {npc:14984} beside him takes Arathi Resource Crates."] = "La bataille pour {zone:1461} ! de {npc:14983} (attaquer chaque base) et Contrôler quatre bases / Prendre cinq bases sont des quêtes uniques ; {npc:14984}, à côté de lui, prend les Caisses de ressources d'Arathi.",

	-- Step 2: League of Arathor to Honored
	["League of Arathor to Honored"] = "La Ligue d'Arathor : Honoré",
	-- {zone:1461} Arathi Basin · {npc:15351} Alliance Brigadier General
	["Keep playing {zone:1461}. On Call to Arms: {zone:1461} weekends the {npc:15351} in the capitals takes three Arathi Basin Marks of Honor for extra reputation."] = "Continuez à jouer au {zone:1461}. Pendant les week-ends de l'Appel aux armes du {zone:1461}, {npc:15351} des capitales prend trois Marques d'honneur du bassin d'Arathi contre un supplément de réputation.",
	-- {npc:15127} Samuel Hawke
	["{npc:15127} hands out one Arathor care package by level"] = "{npc:15127} remet un colis d'Arathor par tranche de niveau",

	-- Step 3: League of Arathor to Revered
	["League of Arathor to Revered"] = "La Ligue d'Arathor : Révéré",
	-- {zone:1461} Arathi Basin
	["Keep playing {zone:1461}; wins with many bases held pay the most."] = "Continuez à jouer {zone:1461} ; les victoires avec beaucoup de bases tenues rapportent le plus.",

	-- Step 4: League of Arathor to Exalted
	["League of Arathor to Exalted"] = "La Ligue d'Arathor : Exalté",
	["Exalted with the League of Arathor earns a Legacy Point."] = "Être exalté auprès de La Ligue d'Arathor rapporte un point d'héritage.",

	-- Step 5: The Defilers to Friendly
	-- {faction:510} The Defilers
	["{faction:510} to Friendly"] = "{faction:510} : Amical",
	-- {faction:510} The Defilers · {zone:1461} Arathi Basin · {area:321} Hammerfall
	["{faction:510} fight for {zone:1461} from {area:321}. Their reputation comes from the battleground: the resources your team gathers pay it to everyone, so holding more bases for longer pays more. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:510} se battent pour {zone:1461} depuis {area:321}. Leur réputation vient du champ de bataille : les ressources que votre équipe accumule la rapportent à tous, donc tenir plus de bases plus longtemps rapporte plus. Inscrivez-vous auprès de n'importe quel maître de guerre. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",
	-- {npc:15021} Deathmaster Dwire · {zone:1461} Arathi Basin · {npc:15022} Deathstalker Mortis
	-- plural, as words: Arathi Resource Crates = {item:19725} Arathi Resource Crate
	["{npc:15021}'s The Battle for {zone:1461}! (assault every base) and Take Four Bases / Take Five Bases are one-time quests; {npc:15022} beside him takes Arathi Resource Crates."] = "La bataille pour {zone:1461} ! de {npc:15021} (attaquer chaque base) et Prendre quatre bases / Prendre cinq bases sont des quêtes uniques ; {npc:15022}, à côté de lui, prend les Caisses de ressources d'Arathi.",

	-- Step 6: The Defilers to Honored
	-- {faction:510} The Defilers
	["{faction:510} to Honored"] = "{faction:510} : Honoré",
	-- {zone:1461} Arathi Basin · {npc:15350} Horde Warbringer
	["Keep playing {zone:1461}. On Call to Arms: {zone:1461} weekends the {npc:15350} in the capitals takes three Arathi Basin Marks of Honor for extra reputation."] = "Continuez à jouer au {zone:1461}. Pendant les week-ends de l'Appel aux armes du {zone:1461}, {npc:15350} des capitales prend trois Marques d'honneur du bassin d'Arathi contre un supplément de réputation.",
	-- {npc:15126} Rutherford Twing
	["{npc:15126} hands out one Defiler's care package by level"] = "{npc:15126} remet un colis des Profanateurs par tranche de niveau",

	-- Step 7: The Defilers to Revered
	-- {faction:510} The Defilers
	["{faction:510} to Revered"] = "{faction:510} : Révéré",

	-- Step 8: The Defilers to Exalted
	-- {faction:510} The Defilers
	["{faction:510} to Exalted"] = "{faction:510} : Exalté",
	-- {faction:510} The Defilers
	["Exalted with {faction:510} earns a Legacy Point."] = "Être exalté auprès de {faction:510} rapporte un point d'héritage.",
}
