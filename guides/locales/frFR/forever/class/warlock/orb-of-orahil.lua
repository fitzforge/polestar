-- French (frFR): the guide forever/class/warlock/orb-of-orahil (forever/class/warlock/orb-of-orahil.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Orb of Orahil"] = "Orbe d'Orahil",
	["An off-hand orb or a staff for your late 30s, down the felhound's or the infernal's path, your pick."] = "Un orbe de main gauche ou un bâton vers la fin de la trentaine de niveaux, par la voie du gangrechien ou celle de l'infernal, au choix.",

	-- Step 1: Knowledge of the Orb of Orahil (Stormwind)
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 35 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:6266} in {area:392}."] = "Au niveau 35, {npc:461}, dans l'{object:2164}, dans le {object:2101}, vous envoie voir {npc:6266} à {area:392}.",

	-- Step 2: Knowledge of the Orb of Orahil (Ironforge)
	-- {npc:5172} Briarthorn · {zone:1455} Ironforge · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 35 {npc:5172} in {zone:1455} sends you to {npc:6266} in {area:392}."] = "Au niveau 35, {npc:5172}, à {zone:1455}, vous envoie voir {npc:6266} à {area:392}.",

	-- Step 3: Knowledge of the Orb of Orahil (Orgrimmar)
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 35 {npc:3326} in the {object:172960} sends you to {npc:6266} in {area:392}."] = "Au niveau 35, {npc:3326}, dans la {object:172960}, vous envoie voir {npc:6266} à {area:392}.",

	-- Step 4: Knowledge of the Orb of Orahil (Undercity)
	-- {npc:4563} Kaal Soulreaper · {object:36082} Magic Quarter · {npc:6266} Menara Voidrender · {area:392} Ratchet · {zone:1420} Tirisfal Glades · {zone:1411} Durotar
	["At 35 {npc:4563} in the {object:36082} sends you to {npc:6266} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}."] = "Au niveau 35, {npc:4563}, dans le {object:36082}, vous envoie voir {npc:6266} à {area:392}. Le zeppelin de {zone:1420} vole jusqu'à {zone:1411}.",

	-- Step 5: Menara Voidrender
	-- {npc:6266} Menara Voidrender · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["{npc:6266} and her two acolytes stand in {npc:6251}'s tower on the hill above {area:392}."] = "{npc:6266} et ses deux acolytes se tiennent dans la tour de {npc:6251}, sur la colline au-dessus de {area:392}.",

	-- Step 6: Choose an acolyte
	["Choose an acolyte"] = "Choisissez un acolyte",
	-- {npc:6254} Acolyte Wytula · {item:15106} Staff of Dar'Orahil · {npc:6252} Acolyte Magaz · {item:15105} Staff of Noh'Orahil
	["Pick one acolyte: you can take only one of their quests. {npc:6254}'s felhound path ends with the Orb or {item:15106}, the shadow versions; {npc:6252}'s infernal path with the Orb or {item:15105}, much the same items on the fire side. Most warlocks lean on shadow, but compare the four in their tooltips first. The guide follows the one you take. Keep the ruby or the emerald: it is handed back."] = "Choisissez un acolyte : vous ne pouvez prendre qu'une seule de leurs quêtes. La voie du chien corrompu de {npc:6254} se termine par l'orbe ou le {item:15106}, les versions d'ombre ; la voie de l'infernal de {npc:6252} par l'orbe ou le {item:15105}, à peu près les mêmes objets côté feu. La plupart des démonistes misent sur l'ombre, mais comparez d'abord les quatre dans leurs infobulles. Le guide suit celle que vous prenez. Gardez le rubis ou l'émeraude : on vous le reprend.",
	-- {npc:6254} Acolyte Wytula · {item:12647} Felhas Ruby
	["{npc:6254}: she gives you the {item:12647}"] = "{npc:6254} : elle vous remet le {item:12647}",
	-- {npc:6252} Acolyte Magaz · {item:12646} Infus Emerald
	["{npc:6252}: he gives you the {item:12646}"] = "{npc:6252} : il vous remet l'{item:12646}",

	-- Step 7: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace · {area:2408} Shadowprey Village · {item:7291} Infernal Orb · {spell:1120} Drain Soul
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner · Mana Eaters = {npc:4678} Mana Eater · Mage Hunters = {npc:4681} Mage Hunter · Ley Hunters = {npc:4685} Ley Hunter · Lesser Infernals = {npc:4676} Lesser Infernal
	["{area:602} fills south-central {zone:1443}, east of {area:2408}. The Burning Blade Summoners (level 38-39, warlocks with imps) carry the {item:7291} every time. For the spirit, bring your demon to low health with your damage over time, then channel the ruby or the emerald on it and keep channelling while it dies, as with {spell:1120}: the gem does no damage of its own. The ruby works on the coven's felhounds: the two Mana Eaters (37-38) in the north, and the Mage Hunters (38) and Ley Hunters (39) further south. The emerald works on the Lesser Infernals (36-37, sixteen of them, fire-resistant)."] = "Le {area:602} occupe le centre-sud de {zone:1443}, à l'est du {area:2408}. Les Invocateurs de la Lame ardente (niveau 38-39, des démonistes avec des diablotins) portent l'{item:7291} à chaque fois. Pour l'esprit, amenez le démon à peu de vie avec vos dégâts sur la durée, puis canalisez le rubis ou l'émeraude sur lui et continuez pendant qu'il meurt, comme avec {spell:1120} : la gemme ne fait aucun dégât par elle-même. Le rubis fonctionne sur les chiens corrompus du convent : les deux Mange-mana (37-38) au nord, et les Chasseurs de mages (38) et Chasseurs Ley (39) plus au sud. L'émeraude fonctionne sur les Infernaux mineurs (36-37, ils sont seize, résistants au feu).",
	-- {item:7291} Infernal Orb
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["{item:7291}, from the Burning Blade Summoners"] = "{item:7291}, sur les Invocateurs de la Lame ardente",
	-- {item:12648} Imprisoned Felhound Spirit · {npc:4678} Mana Eater · {npc:4681} Mage Hunter · {npc:4685} Ley Hunter
	["{item:12648}, from a {npc:4678}, {npc:4681} or {npc:4685}"] = "{item:12648}, sur un {npc:4678}, un {npc:4681} ou un {npc:4685}",
	-- {item:12649} Imprisoned Infernal Spirit · {npc:4676} Lesser Infernal
	["{item:12649}, from a {npc:4676}"] = "{item:12649}, sur un {npc:4676}",

	-- Step 8: The demon's spirit
	["The demon's spirit"] = "L'esprit du démon",
	-- {npc:6266} Menara Voidrender · {area:392} Ratchet
	["Back to {npc:6266} in the tower above {area:392} with the spirit and the gem first: her orb follows from it."] = "Retournez d'abord voir {npc:6266} dans la tour au-dessus de {area:392} avec l'esprit et la gemme : son orbe en découle.",

	-- Step 9: Tabetha
	-- {npc:6546} Tabetha · {zone:1445} Dustwallow Marsh · {zone:1413} Barrens · {npc:6549} Demon of the Orb · {spell:710} Banish
	["{npc:6546} lives at her farm in the middle of {zone:1445}, south of the road from the {zone:1413} and south-west of Theramore; a spirit healer stands beside it. Deadmire, a level 45 crocolisk, patrols the creeks just north-east. Before you accept Cleansing, clear the spiders and crocolisks around her paddock. Accepting starts a 3-minute timer: she walks to the paddock and lets the {npc:6549} out. It is elite (level 40): grouping up is encouraged; a warlock of about 40 can solo it with Fear or {spell:710} and damage over time, a level 35-38 one brings a friend. The timer keeps running after the kill, so hand in at once. If time runs out, abandon the quest and take it from {npc:6546} again."] = "{npc:6546} vit dans sa ferme au milieu du {zone:1445}, au sud de la route venant des {zone:1413} et au sud-ouest de Theramore ; un gardien des âmes se tient à côté. Deadmire, un crocilisque de niveau 45, patrouille les ruisseaux juste au nord-est. Avant d'accepter la purification, nettoyez les araignées et les crocilisques autour de son enclos. Accepter lance un compte à rebours de 3 minutes : elle marche jusqu'à l'enclos et libère le {npc:6549}. Il est élite (niveau 40) : mieux vaut former un groupe ; un démoniste d'environ 40 peut le battre seul avec Peur ou {spell:710} et des dégâts sur la durée, un démoniste de niveau 35-38 vient avec un ami. Le compte à rebours continue après la victoire, rendez donc la quête aussitôt. Si le temps s'écoule, abandonnez la quête et reprenez-la auprès de {npc:6546}.",

	-- Step 10: The Orb of Dar'Orahil
	-- {item:15108} Orb of Dar'Orahil
	["The {item:15108}"] = "L'{item:15108}",
	-- {npc:6266} Menara Voidrender · {area:392} Ratchet · {item:15108} Orb of Dar'Orahil
	["Back to {npc:6266} in the tower above {area:392} with the cleansed orb. On the felhound path, accept her last quest and wait beside her while she completes the {item:15108} (do not attack her: the quest log calls it a kill), then speak to her again and pick the off-hand orb or the staff."] = "Retournez voir {npc:6266} dans la tour au-dessus de {area:392} avec l'orbe purifiée. Sur la voie du chien corrompu, acceptez sa dernière quête et attendez à côté d'elle pendant qu'elle termine l'{item:15108} (ne l'attaquez pas : le journal de quêtes parle de la tuer), puis parlez-lui de nouveau et choisissez l'orbe de main gauche ou le bâton.",
	-- {npc:6266} Menara Voidrender
	["Wait beside {npc:6266} while she makes the orb"] = "Attendez à côté de {npc:6266} pendant qu'elle fabrique l'orbe",

	-- Step 11: The Orb of Noh'Orahil
	-- {item:15107} Orb of Noh'Orahil
	["The {item:15107}"] = "L'{item:15107}",
	-- {npc:6266} Menara Voidrender · {item:15107} Orb of Noh'Orahil
	["On the infernal path, accept her last quest and wait beside {npc:6266} while she completes the {item:15107}, then speak to her again and pick the off-hand orb or the staff."] = "Sur la voie de l'infernal, acceptez sa dernière quête et attendez à côté de {npc:6266} pendant qu'elle termine l'{item:15107}, puis parlez-lui de nouveau et choisissez l'orbe de main gauche ou le bâton.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:6266} in the tower above {area:392} with the cleansed orb. On the felhound path, wait while she completes the {item:15108}, then speak to her again."] = "Retournez voir {npc:6266} dans la tour au-dessus de {area:392} avec l'orbe purifié. Sur la voie du gangrechien, attendez qu'elle achève l'{item:15108}, puis parlez-lui à nouveau.",
	-- ["Back to {npc:6266} in the tower above {area:392} with the spirit first: {npc:6546}'s cleansing follows it."] = "Retournez d'abord voir {npc:6266} dans la tour au-dessus de {area:392} avec l'esprit : la purification de {npc:6546} vient ensuite.",
	-- ["On the infernal path, wait while {npc:6266} completes the {item:15107}, then speak to her again."] = "Sur la voie de l'infernal, attendez que {npc:6266} achève l'{item:15107}, puis parlez-lui à nouveau.",
	-- ["Pick one acolyte: you can take only one of their quests. {npc:6254}'s felhound path ends with the Orb or {item:15106}, {npc:6252}'s infernal path with the Orb or {item:15105}. The guide follows the one you take."] = "Choisissez un acolyte : vous ne pouvez prendre qu'une de leurs quêtes. La voie du gangrechien de {npc:6254} se termine par l'Orbe ou le {item:15106}, la voie de l'infernal de {npc:6252} par l'Orbe ou le {item:15105}. Le guide suit celle que vous prenez.",
	-- ["The demons of {area:602}, in southern {zone:1443}, have all you need. Burning Blade Summoners carry the {item:7291}. On the felhound path, use the {item:12647} on a {npc:4678}, a felhound, and kill it for its spirit; on the infernal path, use the {item:12646} on a {npc:4676} and kill it."] = "Les démons du {area:602}, dans le sud de {zone:1443}, ont tout ce qu'il vous faut. Les Invocateurs de la Lame ardente portent l'{item:7291}. Sur la voie du gangrechien, utilisez le {item:12647} sur un {npc:4678}, un gangrechien, et tuez-le pour son esprit ; sur la voie de l'infernal, utilisez l'{item:12646} sur un {npc:4676} et tuez-le.",
	-- ["Wait for the orb"] = "Attendez l'orbe",
	-- ["{item:12648}, from a {npc:4678}"] = "{item:12648}, sur un {npc:4678}",
	-- ["{npc:6266} and her two acolytes stand in the tower on the hill above {area:392}, beside {npc:6251}."] = "{npc:6266} et ses deux acolytes se tiennent dans la tour sur la colline au-dessus de {area:392}, à côté de {npc:6251}.",
	-- ["{npc:6546} lives at her farm in western {zone:1445}. She calls the {npc:6549} out of the {item:7291}; it is elite: grouping up is advised."] = "{npc:6546} vit dans sa ferme, dans l'ouest du {zone:1445}. Elle fait sortir le {npc:6549} de l'{item:7291} ; il est élite : il est conseillé de former un groupe.",
}
