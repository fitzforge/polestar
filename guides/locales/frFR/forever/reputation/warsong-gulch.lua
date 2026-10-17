-- French (frFR): the guide forever/reputation/warsong-gulch (forever/reputation/warsong-gulch.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Warsong Gulch Reputation"] = "Réputation : Goulet des Chanteguerres",

	-- Step 1: Silverwing Sentinels to Friendly
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Friendly"] = "{faction:890} jusqu'à Amical",
	-- {faction:890} Silverwing Sentinels · {zone:1460} Warsong Gulch
	["The {faction:890} are the Night Elves holding {zone:1460}. Their reputation comes from the battleground: every enemy flag your team captures pays it to the whole team. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "Les {faction:890} sont les elfes de la nuit qui tiennent le {zone:1460}. Leur réputation vient du champ de bataille : chaque drapeau ennemi capturé par votre équipe en rapporte à toute l'équipe. Inscrivez-vous auprès de n'importe quel maître de guerre. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",
	-- {npc:14733} Sentinel Farsong
	["{npc:14733} takes Warsong Gulch Marks of Honor for Vanquish the Invaders!, once per level bracket (data); check them live."] = "{npc:14733} prend des Marques d'honneur du goulet des Chanteguerres pour Triomphez des envahisseurs !, une fois par tranche de niveau (données) ; vérifiez-les en jeu.",

	-- Step 2: Silverwing Sentinels to Honored
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Honored"] = "{faction:890} jusqu'à Honoré",
	-- {zone:1460} Warsong Gulch · {npc:15351} Alliance Brigadier General
	["Keep playing {zone:1460} and capturing flags. On Call to Arms: {zone:1460} weekends the {npc:15351} in the capitals takes three Warsong Gulch Marks of Honor for extra reputation."] = "Continuez à jouer au {zone:1460} et à capturer des drapeaux. Pendant les week-ends de l'Appel aux armes du {zone:1460}, {npc:15351} des capitales prend trois Marques d'honneur du goulet des Chanteguerres contre un supplément de réputation.",
	-- {npc:14753} Illiyana Moonblaze
	["{npc:14753} hands out one Sentinel care package by level"] = "{npc:14753} donne un Paquetage de Sentinelle selon le niveau",

	-- Step 3: Silverwing Sentinels to Revered
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Revered"] = "{faction:890} jusqu'à Révéré",
	-- {zone:1460} Warsong Gulch
	["Keep capturing flags in {zone:1460}."] = "Continuez à capturer des drapeaux au {zone:1460}.",

	-- Step 4: Silverwing Sentinels to Exalted
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Exalted"] = "{faction:890} jusqu'à Exalté",
	-- {faction:890} Silverwing Sentinels
	["Exalted with the {faction:890} earns a Legacy Point."] = "Être Exalté auprès des {faction:890} rapporte un point d'Héritage.",

	-- Step 5: Warsong Outriders to Friendly
	-- {faction:889} Warsong Outriders
	["{faction:889} to Friendly"] = "{faction:889} jusqu'à Amical",
	-- {faction:889} Warsong Outriders · {zone:1440} Ashenvale
	["The {faction:889} are the Orcs logging {zone:1440}. Their reputation comes from the battleground: every enemy flag your team captures pays it to the whole team. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "Les {faction:889} sont les orcs qui exploitent le bois d'{zone:1440}. Leur réputation vient du champ de bataille : chaque drapeau ennemi capturé par votre équipe en rapporte à toute l'équipe. Inscrivez-vous auprès de n'importe quel maître de guerre. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",
	-- {npc:14781} Captain Shatterskull
	["{npc:14781} takes Warsong Gulch Marks of Honor for Quell the Silverwing Usurpers, once per level bracket (data); check them live."] = "{npc:14781} prend des Marques d'honneur du goulet des Chanteguerres pour Écrasez les usurpateurs d'Aile-argent, une fois par tranche de niveau (données) ; vérifiez-les en jeu.",

	-- Step 6: Warsong Outriders to Honored
	-- {faction:889} Warsong Outriders
	["{faction:889} to Honored"] = "{faction:889} jusqu'à Honoré",
	-- {zone:1460} Warsong Gulch · {npc:15350} Horde Warbringer
	["Keep playing {zone:1460} and capturing flags. On Call to Arms: {zone:1460} weekends the {npc:15350} in the capitals takes three Warsong Gulch Marks of Honor for extra reputation."] = "Continuez à jouer au {zone:1460} et à capturer des drapeaux. Pendant les week-ends de l'Appel aux armes du {zone:1460}, {npc:15350} des capitales prend trois Marques d'honneur du goulet des Chanteguerres contre un supplément de réputation.",
	-- {npc:14754} Kelm Hargunth
	["{npc:14754} hands out one Outrider care package by level"] = "{npc:14754} donne un Paquetage de Voltigeur selon le niveau",

	-- Step 7: Warsong Outriders to Revered
	-- {faction:889} Warsong Outriders
	["{faction:889} to Revered"] = "{faction:889} jusqu'à Révéré",

	-- Step 8: Warsong Outriders to Exalted
	-- {faction:889} Warsong Outriders
	["{faction:889} to Exalted"] = "{faction:889} jusqu'à Exalté",
	-- {faction:889} Warsong Outriders
	["Exalted with the {faction:889} earns a Legacy Point."] = "Être Exalté auprès des {faction:889} rapporte un point d'Héritage.",
}
