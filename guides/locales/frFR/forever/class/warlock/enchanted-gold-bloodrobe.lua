-- French (frFR): the guide forever/class/warlock/enchanted-gold-bloodrobe (forever/class/warlock/enchanted-gold-bloodrobe.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:6266} Menara Voidrender
	["A rare cloth robe for your 30s, which {npc:6266} makes from the parts you bring her."] = "Une robe en tissu rare pour vos niveaux 30, que {npc:6266} confectionne avec les pièces que vous lui apportez.",

	-- Step 1: In Search of Menara Voidrender (Stormwind)
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 31 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:6266} in {area:392}."] = "Au niveau 31, {npc:461}, à {object:2164} dans {object:2101}, vous envoie voir {npc:6266} à {area:392}.",

	-- Step 2: In Search of Menara Voidrender (Ironforge)
	-- {npc:5172} Briarthorn · {zone:1455} Ironforge · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 31 {npc:5172} in {zone:1455} sends you to {npc:6266} in {area:392}."] = "Au niveau 31, {npc:5172} à {zone:1455} vous envoie voir {npc:6266} à {area:392}.",

	-- Step 3: In Search of Menara Voidrender (Orgrimmar)
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 31 {npc:3326} in the {object:172960} sends you to {npc:6266} in {area:392}."] = "Au niveau 31, {npc:3326}, dans {object:172960}, vous envoie voir {npc:6266} à {area:392}.",

	-- Step 4: In Search of Menara Voidrender (Undercity)
	-- {npc:4563} Kaal Soulreaper · {object:36082} Magic Quarter · {npc:6266} Menara Voidrender · {area:392} Ratchet · {zone:1420} Tirisfal Glades · {zone:1411} Durotar
	["At 31 {npc:4563} in the {object:36082} sends you to {npc:6266} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}."] = "Au niveau 31, {npc:4563}, dans {object:36082}, vous envoie voir {npc:6266} à {area:392}. Le zeppelin de {zone:1420} va à {zone:1411}.",

	-- Step 5: Menara Voidrender
	-- {npc:6266} Menara Voidrender · {area:392} Ratchet · {npc:6251} Strahad Farsan
	["{npc:6266} stands in the tower on the hill above {area:392}, beside {npc:6251}."] = "{npc:6266} se trouve dans la tour sur la colline au-dessus de {area:392}, à côté de {npc:6251}.",

	-- Step 6: Robes of Arcana
	-- {npc:6266} Menara Voidrender · {item:5770} Robes of Arcana · {item:3577} Gold Bar · {item:2776} Gold Ore
	["Bring {npc:6266} a {item:5770}: tailors sew it from a pattern that drops; otherwise buy one at the Auction House. Her next errand needs a {item:3577}: smelted from {item:2776}, or from the Auction House."] = "Apportez à {npc:6266} une {item:5770} : les tailleurs la cousent à partir d'un patron trouvé sur les monstres ; sinon, achetez-en une à l'hôtel des ventes. Sa course suivante demande un {item:3577} : fondu à partir de {item:2776}, ou acheté à l'hôtel des ventes.",

	-- Step 7: Xizk Goodstitch
	-- {npc:2670} Xizk Goodstitch · {area:35} Booty Bay · {item:3577} Gold Bar
	["{npc:2670} sells tailoring supplies in {area:35}. Bring him the {item:3577}."] = "{npc:2670} vend des fournitures de couture à {area:35}. Apportez-lui le {item:3577}.",

	-- Step 8: Back to Menara Voidrender
	-- {npc:6266} Menara Voidrender
	["Back to {npc:6266}"] = "Retour auprès de {npc:6266}",

	-- Step 9: Desolace demons
	-- {zone:1443} Desolace
	["{zone:1443} demons"] = "Démons de {zone:1443}",
	-- {area:603} Sargeron · {zone:1443} Desolace
	-- plural, as words: Lesser Infernals = {npc:4676} Lesser Infernal
	["The Hatefury satyrs of {area:603}, in north-eastern {zone:1443}, carry the blood; the Lesser Infernals of Mannoroc Coven, in the south, the stone."] = "Les satyres Fielfurie de {area:603}, dans le nord-est de {zone:1443}, portent le sang ; les Infernaux mineurs du Convent de Mannoroc, au sud, la pierre.",
	["Vials of Hatefury Blood"] = "Fioles de sang de Fielfurie",

	-- Step 10: Menara Voidrender again
	-- {npc:6266} Menara Voidrender
	["{npc:6266} again"] = "Encore {npc:6266}",

	-- Step 11: Fine Gold Thread
	-- {npc:2670} Xizk Goodstitch · {area:35} Booty Bay
	["{npc:2670} in {area:35} has the thread for you."] = "{npc:2670} à {area:35} a le fil pour vous.",

	-- Step 12: Smoldering Coal
	-- {zone:1417} Arathi Highlands
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile
	["The Burning Exiles, fire elementals in western {zone:1417}, drop the coal."] = "Les Exilés ardents, des élémentaires de feu de l'ouest de {zone:1417}, laissent tomber le charbon.",

	-- Step 13: The Completed Robe
	-- {npc:6266} Menara Voidrender · {item:6265} Soul Shard
	["Back to {npc:6266} with the thread, the coal and a {item:6265}. Wait while she completes the robe, then speak to her again."] = "Retournez voir {npc:6266} avec le fil, le charbon et un {item:6265}. Attendez qu'elle termine la robe, puis parlez-lui de nouveau.",
	["Wait for the robe"] = "Attendre la robe",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Hatefury satyrs of {area:603}, in north-eastern {zone:1443}, carry the blood; the Lesser Infernals of {area:602}, in the south, the stone."] = "Les satyres Fielfurie de {area:603}, dans le nord-est de {zone:1443}, portent le sang ; les Infernaux mineurs de {area:602}, au sud, la pierre.",
}
