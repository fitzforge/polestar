-- French (frFR): the guide forever/class/priest/touch-of-weakness-and-dark-sacrifice (forever/class/priest/touch-of-weakness-and-dark-sacrifice.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:2652} Touch of Weakness · {quest:5644} Dark Sacrifice
	["{spell:2652} and {quest:5644}"] = "{spell:2652} et {quest:5644}",
	-- {spell:2652} Touch of Weakness · {quest:5644} Dark Sacrifice
	["The Undead priest spells: {spell:2652} at 10, {quest:5644} (new in Forever) at 20. Free, no objectives."] = "Les sorts de prêtre mort-vivant : {spell:2652} au niveau 10, {quest:5644} (nouveau dans Forever) au niveau 20. Gratuits, sans objectif.",

	-- Step 1: Touch of Weakness: Tai'jin
	-- {zone:1411} Durotar · {npc:3706} Tai'jin · {area:362} Razor Hill · {spell:2652} Touch of Weakness · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["At 10 in {zone:1411}, {npc:3706}, the priest trainer inside the barracks of {area:362}, hands you a {spell:2652} letter for {npc:4606} in the {zone:1458}."] = "Au niveau 10 en {zone:1411}, {npc:3706}, le maître des prêtres dans la caserne de {area:362}, vous remet une lettre {spell:2652} pour {npc:4606} à {zone:1458}.",
	-- {npc:3706} Tai'jin · {spell:2652} Touch of Weakness
	["{npc:3706}: take his {spell:2652} letter"] = "{npc:3706} : prenez sa lettre {spell:2652}",

	-- Step 2: Touch of Weakness: Ur'kyo
	-- {zone:1454} Orgrimmar · {npc:6018} Ur'kyo · {object:172961} Valley of Spirits · {spell:2652} Touch of Weakness · {npc:4606} Aelthalyste · {zone:1458} Undercity · {zone:1420} Tirisfal Glades
	["At 10 in {zone:1454}, {npc:6018} in the {object:172961} hands you a {spell:2652} letter for {npc:4606} in the {zone:1458}. The zeppelin to {zone:1420} leaves from the tower outside {zone:1454}'s front gate."] = "Au niveau 10 à {zone:1454}, {npc:6018}, dans {object:172961}, vous remet une lettre {spell:2652} pour {npc:4606} à {zone:1458}. Le zeppelin pour {zone:1420} part de la tour devant la porte principale d'{zone:1454}.",
	-- {npc:6018} Ur'kyo · {spell:2652} Touch of Weakness
	["{npc:6018}: take his {spell:2652} letter"] = "{npc:6018} : prenez sa lettre {spell:2652}",

	-- Step 3: Touch of Weakness: Var'jun
	-- {zone:1412} Mulgore · {npc:11407} Var'jun · {area:222} Bloodhoof Village · {spell:2652} Touch of Weakness · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["At 10 in {zone:1412}, {npc:11407}, just south-west of {area:222}, hands you a {spell:2652} letter for {npc:4606} in the {zone:1458}."] = "Au niveau 10 en {zone:1412}, {npc:11407}, juste au sud-ouest du {area:222}, vous remet une lettre {spell:2652} pour {npc:4606} à {zone:1458}.",
	-- {npc:11407} Var'jun · {spell:2652} Touch of Weakness
	["{npc:11407}: take the {spell:2652} letter"] = "{npc:11407} : prenez la lettre {spell:2652}",

	-- Step 4: Touch of Weakness: Miles Welsh
	-- {zone:1456} Thunder Bluff · {npc:3044} Miles Welsh · {area:1640} Spirit Rise · {spell:2652} Touch of Weakness · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["At 10 in {zone:1456}, {npc:3044}, the priest trainer in the cave under {area:1640}, hands you a {spell:2652} letter for {npc:4606} in the {zone:1458}."] = "Au niveau 10 aux {zone:1456}, {npc:3044}, le maître des prêtres dans la grotte sous la {area:1640}, vous remet une lettre {spell:2652} pour {npc:4606} à {zone:1458}.",
	-- {npc:3044} Miles Welsh · {spell:2652} Touch of Weakness
	["{npc:3044}: take his {spell:2652} letter"] = "{npc:3044} : prenez sa lettre {spell:2652}",

	-- Step 5: Touch of Weakness: Aelthalyste
	-- {npc:4606} Aelthalyste · {zone:1458} Undercity · {object:36070} War Quarter · {quest:5658} Touch of Weakness · {area:159} Brill
	["At 10, go to {npc:4606}, the priest trainer in the {zone:1458}'s {object:36070}: she gives {quest:5658} and takes it back at once. No letter needed. From {area:159}, follow the road south to the ruined city of Lordaeron; the {zone:1458}'s lifts are at the back of the throne room. {quest:5658} strikes the next melee attacker for Shadow damage and lowers its melee attack power for 2 minutes."] = "Au niveau 10, allez voir {npc:4606}, la maîtresse des prêtres du {object:36070} de {zone:1458} : elle donne {quest:5658} et la reprend aussitôt. Pas besoin de lettre. Depuis {area:159}, suivez la route vers le sud jusqu'à la ville en ruine de Lordaeron ; les ascenseurs de {zone:1458} sont au fond de la salle du trône. {quest:5658} frappe le prochain attaquant de mêlée de dégâts d'Ombre et réduit sa puissance d'attaque en mêlée pendant 2 minutes.",

	-- Step 6: Touch of Weakness: Tai'jin's letter
	-- {quest:5660} Touch of Weakness · {npc:3706} Tai'jin
	["{quest:5660}: {npc:3706}'s letter"] = "{quest:5660} : la lettre de {npc:3706}",
	-- {npc:4606} Aelthalyste · {zone:1458} Undercity · {object:36070} War Quarter · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["Hand the letter to {npc:4606} in the {zone:1458}'s {object:36070}: the zeppelin from the tower outside {zone:1454} lands in {zone:1420}, a short walk from the {zone:1458}."] = "Remettez la lettre à {npc:4606} dans le {object:36070} de {zone:1458} : le zeppelin qui part de la tour devant {zone:1454} se pose dans les {zone:1420}, à quelques pas de {zone:1458}.",

	-- Step 7: Touch of Weakness: Var'jun's letter
	-- {quest:5661} Touch of Weakness · {npc:11407} Var'jun
	["{quest:5661}: {npc:11407}'s letter"] = "{quest:5661} : la lettre de {npc:11407}",
	-- {npc:4606} Aelthalyste · {zone:1458} Undercity · {object:36070} War Quarter · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["Hand the letter to {npc:4606} in the {zone:1458}'s {object:36070}: travel to {zone:1454} and take the zeppelin to {zone:1420}."] = "Remettez la lettre à {npc:4606} dans le {object:36070} de {zone:1458} : rendez-vous à {zone:1454} et prenez le zeppelin pour les {zone:1420}.",

	-- Step 8: Touch of Weakness: Ur'kyo's letter
	-- {quest:5662} Touch of Weakness · {npc:6018} Ur'kyo
	["{quest:5662}: {npc:6018}'s letter"] = "{quest:5662} : la lettre de {npc:6018}",
	-- {npc:4606} Aelthalyste · {zone:1458} Undercity · {object:36070} War Quarter · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["Hand the letter to {npc:4606} in the {zone:1458}'s {object:36070}: the zeppelin from the tower outside {zone:1454} lands in {zone:1420}."] = "Remettez la lettre à {npc:4606} dans le {object:36070} de {zone:1458} : le zeppelin qui part de la tour devant {zone:1454} se pose dans les {zone:1420}.",

	-- Step 9: Touch of Weakness: Miles Welsh's letter
	-- {quest:5663} Touch of Weakness · {npc:3044} Miles Welsh
	["{quest:5663}: {npc:3044}'s letter"] = "{quest:5663} : la lettre de {npc:3044}",

	-- Step 10: Dark Sacrifice: Ur'kyo
	-- {zone:1454} Orgrimmar · {npc:6018} Ur'kyo · {object:172961} Valley of Spirits · {quest:5644} Dark Sacrifice · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["At 20 in {zone:1454}, {npc:6018} in the {object:172961} hands you a {quest:5644} letter for {npc:4606} in the {zone:1458}."] = "Au niveau 20 à {zone:1454}, {npc:6018}, dans {object:172961}, vous remet une lettre {quest:5644} pour {npc:4606} à {zone:1458}.",
	-- {npc:6018} Ur'kyo · {quest:5644} Dark Sacrifice
	["{npc:6018}: take his {quest:5644} letter"] = "{npc:6018} : prenez sa lettre {quest:5644}",

	-- Step 11: Dark Sacrifice: Miles Welsh
	-- {zone:1456} Thunder Bluff · {npc:3044} Miles Welsh · {area:1640} Spirit Rise · {quest:5644} Dark Sacrifice · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["At 20 in {zone:1456}, {npc:3044} in the cave under {area:1640} hands you a {quest:5644} letter for {npc:4606} in the {zone:1458}."] = "Au niveau 20 aux {zone:1456}, {npc:3044}, dans la grotte sous la {area:1640}, vous remet une lettre {quest:5644} pour {npc:4606} à {zone:1458}.",
	-- {npc:3044} Miles Welsh · {quest:5644} Dark Sacrifice
	["{npc:3044}: take his {quest:5644} letter"] = "{npc:3044} : prenez sa lettre {quest:5644}",

	-- Step 12: Dark Sacrifice: Aelthalyste
	-- {npc:4606} Aelthalyste · {object:36070} War Quarter · {quest:5644} Dark Sacrifice · {spell:2944} Devouring Plague
	["At 20, {npc:4606} in the {object:36070} teaches {quest:5644} with a quest she gives and takes back at once (its text still speaks of {spell:2944}, which every priest now learns from the trainer)."] = "Au niveau 20, {npc:4606}, dans le {object:36070}, vous apprend {quest:5644} avec une quête qu'elle donne et reprend aussitôt (son texte parle encore de {spell:2944}, que tous les prêtres apprennent désormais auprès de leur maître).",

	-- Step 13: Dark Sacrifice: Ur'kyo's letter
	-- {quest:5646} Dark Sacrifice · {npc:6018} Ur'kyo
	["{quest:5646}: {npc:6018}'s letter"] = "{quest:5646} : la lettre de {npc:6018}",

	-- Step 14: Dark Sacrifice: Miles Welsh's letter
	-- {quest:5644} Dark Sacrifice · {npc:3044} Miles Welsh
	["{quest:5644}: {npc:3044}'s letter"] = "{quest:5644} : la lettre de {npc:3044}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10, go to {npc:4606} in the {zone:1458}'s {object:36070}. Priest trainers elsewhere ({npc:6018} in {zone:1454}, {npc:3706} in {area:362}, {npc:3044} in {zone:1456}) send you to her with a quest of the same name."] = "Au niveau 10, allez voir {npc:4606} dans le {object:36070} de {zone:1458}. Les maîtres des prêtres d'ailleurs ({npc:6018} à {zone:1454}, {npc:3706} à {area:362}, {npc:3044} aux {zone:1456}) vous envoient à elle avec une quête du même nom.",
	-- ["At 20, {npc:4606} teaches {quest:5644}. {npc:6018} in {zone:1454} and {npc:3044} in {zone:1456} send you to her with a quest of the same name."] = "Au niveau 20, {npc:4606} enseigne {quest:5644}. {npc:6018} à {zone:1454} et {npc:3044} aux {zone:1456} vous envoient à elle avec une quête du même nom.",
	-- ["The Undead priest spells: {spell:2652} at 10, {quest:5644} at 20."] = "Les sorts de prêtre morts-vivants : {spell:2652} au niveau 10, {quest:5644} au niveau 20.",
}
