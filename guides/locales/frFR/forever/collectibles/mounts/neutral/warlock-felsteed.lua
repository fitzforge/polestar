-- French (frFR): the guide forever/collectibles/mounts/neutral/warlock-felsteed (forever/collectibles/mounts/neutral/warlock-felsteed.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Warlock Felsteed"] = "Palefroi corrompu (démoniste)",
	["Your own mount at 40, summoned anywhere: no 100g riding training needed."] = "Votre propre monture au niveau 40, invoquée n'importe où : pas d'apprentissage de monte à 100 po.",

	-- Step 1: Summon Felsteed (Stormwind)
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 40 {npc:461}, in the cellar of the {object:2164} in the {object:2101}, sends you to {npc:6251} in {area:392}. No quest offered? Finish the felhunter chain first: players report the mount comes after it."] = "Au niveau 40, {npc:461}, dans la cave de l'{object:2164} du {object:2101}, vous envoie voir {npc:6251} à {area:392}. Aucune quête proposée ? Terminez d'abord la chaîne du chasseur corrompu : d'après les joueurs, la monture vient après.",

	-- Step 2: Summon Felsteed (Ironforge)
	-- {npc:5172} Briarthorn · {zone:1455} Ironforge · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 40 {npc:5172}, by the warlock trainers in {zone:1455}, sends you to {npc:6251} in {area:392}. No quest offered? Finish the felhunter chain first: players report the mount comes after it."] = "Au niveau 40, {npc:5172}, près des maîtres des démonistes de {zone:1455}, vous envoie voir {npc:6251} à {area:392}. Aucune quête proposée ? Terminez d'abord la chaîne du chasseur corrompu : d'après les joueurs, la monture vient après.",

	-- Step 3: Summon Felsteed (Orgrimmar)
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 40 {npc:3326}, in the {object:172960}, sends you to {npc:6251} in {area:392}. No quest offered? Finish the felhunter chain first: players report the mount comes after it."] = "Au niveau 40, {npc:3326}, dans la {object:172960}, vous envoie voir {npc:6251} à {area:392}. Aucune quête proposée ? Terminez d'abord la chaîne du chasseur corrompu : d'après les joueurs, la monture vient après.",

	-- Step 4: Summon Felsteed (Undercity)
	-- {npc:4563} Kaal Soulreaper · {object:36082} Magic Quarter · {npc:6251} Strahad Farsan · {area:392} Ratchet · {zone:1420} Tirisfal Glades · {zone:1411} Durotar · {zone:1454} Orgrimmar
	["At 40 {npc:4563}, in the {object:36082}, sends you to {npc:6251} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}; {area:392} is a short flight from {zone:1454}. No quest offered? Finish the felhunter chain first: players report the mount comes after it."] = "Au niveau 40, {npc:4563}, dans le {object:36082}, vous envoie voir {npc:6251} à {area:392}. Le zeppelin de {zone:1420} vole vers {zone:1411} ; {area:392} est à un court vol d'{zone:1454}. Aucune quête proposée ? Terminez d'abord la chaîne du chasseur corrompu : d'après les joueurs, la monture vient après.",

	-- Step 5: Strahad Farsan in Ratchet
	-- {npc:6251} Strahad Farsan · {area:392} Ratchet
	["{npc:6251} in {area:392}"] = "{npc:6251} à {area:392}",
	-- {area:392} Ratchet · {zone:1413} Barrens · {area:35} Booty Bay · {npc:6251} Strahad Farsan · {quest:3631} Summon Felsteed
	["{area:392} is the goblin port on the {zone:1413} coast, east of the Crossroads; from the Alliance side take the boat from {area:35}. {npc:6251} stands by his small tower on the hill above the town, not down at the docks. Hand in, then take his own {quest:3631} and hand it straight back: that teaches you the mount. No fight, and the quests ask for nothing."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 40 {npc:3326} in the {object:172960} sends you to {npc:6251} in {area:392}."] = "Au niveau 40, {npc:3326}, dans la {object:172960}, vous envoie voir {npc:6251} à {area:392}.",
	-- ["At 40 {npc:4563} in the {object:36082} sends you to {npc:6251} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}."] = "Au niveau 40, {npc:4563}, dans le {object:36082}, vous envoie voir {npc:6251} à {area:392}. Le zeppelin des {zone:1420} vole vers {zone:1411}.",
	-- ["At 40 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:6251} in {area:392}."] = "Au niveau 40, {npc:461}, à {object:2164} dans le {object:2101}, vous envoie voir {npc:6251} à {area:392}.",
	-- ["At 40 {npc:5172} in {zone:1455} sends you to {npc:6251} in {area:392}."] = "Au niveau 40, {npc:5172} à {zone:1455} vous envoie voir {npc:6251} à {area:392}.",
	-- ["Your own mount at 40, summoned anywhere, with no gold spent on a riding horse."] = "Votre propre monture au niveau 40, invocable partout, sans dépenser d'or pour un cheval.",
	-- ["{area:392} is on the {zone:1413} coast east of the {area:380}; from the Alliance side, take the boat from {area:35}. {npc:6251}'s follow-up teaches {quest:3631}."] = "{area:392} se trouve sur la côte des {zone:1413}, à l'est de {area:380} ; côté Alliance, prenez le bateau à {area:35}. La suite de {npc:6251} enseigne {quest:3631}.",
	-- ["{area:392} is the goblin port on the {zone:1413} coast, east of the {area:380}; from the Alliance side take the boat from {area:35}. {npc:6251} stands by his small tower on the hill above the town, not down at the docks. Hand in, then take his own {quest:3631} and hand it straight back: that teaches you the mount. No fight, and the quests ask for nothing."] = "{area:392} est le port gobelin sur la côte des {zone:1413}, à l'est de la {area:380} ; côté Alliance, prenez le bateau depuis {area:35}. {npc:6251} se tient près de sa petite tour sur la colline au-dessus de la ville, pas en bas sur les quais. Rendez la quête, puis prenez sa propre quête {quest:3631} et rendez-la aussitôt : elle vous apprend la monture. Pas de combat, et les quêtes ne demandent rien.",
}
