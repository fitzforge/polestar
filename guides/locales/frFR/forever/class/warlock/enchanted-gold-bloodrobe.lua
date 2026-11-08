-- French (frFR): the guide forever/class/warlock/enchanted-gold-bloodrobe (forever/class/warlock/enchanted-gold-bloodrobe.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6266} Menara Voidrender · {area:392} Ratchet · {item:5770} Robes of Arcana · {item:3577} Gold Bar
	["At 31 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:6266} in {area:392}. Buy a {item:5770} and a {item:3577} first (next steps) to save a trip."] = "Au niveau 31, {npc:461}, dans l'{object:2164} du {object:2101}, vous envoie voir {npc:6266} à {area:392}. Achetez d'abord une {item:5770} et une {item:3577} (étapes suivantes) pour vous éviter un voyage.",

	-- Step 2: In Search of Menara Voidrender (Ironforge)
	-- {npc:5172} Briarthorn · {zone:1455} Ironforge · {npc:6266} Menara Voidrender · {area:392} Ratchet · {item:5770} Robes of Arcana · {item:3577} Gold Bar
	["At 31 {npc:5172} in {zone:1455} sends you to {npc:6266} in {area:392}. Buy a {item:5770} and a {item:3577} first (next steps) to save a trip."] = "Au niveau 31, {npc:5172}, à {zone:1455}, vous envoie voir {npc:6266} à {area:392}. Achetez d'abord une {item:5770} et une {item:3577} (étapes suivantes) pour vous éviter un voyage.",

	-- Step 3: In Search of Menara Voidrender (Orgrimmar)
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow · {npc:6266} Menara Voidrender · {area:392} Ratchet · {item:5770} Robes of Arcana · {item:3577} Gold Bar
	["At 31 {npc:3326} in the {object:172960} sends you to {npc:6266} in {area:392}. Buy a {item:5770} and a {item:3577} first (next steps) to save a trip."] = "Au niveau 31, {npc:3326}, dans la {object:172960}, vous envoie voir {npc:6266} à {area:392}. Achetez d'abord une {item:5770} et une {item:3577} (étapes suivantes) pour vous éviter un voyage.",

	-- Step 4: In Search of Menara Voidrender (Undercity)
	-- {npc:4563} Kaal Soulreaper · {object:36082} Magic Quarter · {npc:6266} Menara Voidrender · {area:392} Ratchet · {zone:1420} Tirisfal Glades · {zone:1411} Durotar · {item:5770} Robes of Arcana · {item:3577} Gold Bar
	["At 31 {npc:4563} in the {object:36082} sends you to {npc:6266} in {area:392}; the zeppelin from {zone:1420} flies to {zone:1411}. Buy a {item:5770} and a {item:3577} first (next steps) to save a trip."] = "Au niveau 31, {npc:4563}, dans le {object:36082}, vous envoie voir {npc:6266} à {area:392} ; le zeppelin de {zone:1420} vole vers {zone:1411}. Achetez d'abord une {item:5770} et une {item:3577} (étapes suivantes) pour vous éviter un voyage.",

	-- Step 5: Robes of Arcana and a Gold Bar
	-- {item:5770} Robes of Arcana · {item:3577} Gold Bar
	["{item:5770} and a {item:3577}"] = "{item:5770} et une {item:3577}",
	-- {item:5770} Robes of Arcana · {item:2776} Gold Ore · {npc:6266} Menara Voidrender
	-- plural, as words: Gold Bars = {item:3577} Gold Bar
	["Tailors sew the {item:5770} from a rare pattern; miners smelt Gold Bars from {item:2776}. Everyone else buys both at the Auction House. If you wear the robe, take it off: {npc:6266} keeps it."] = "Les tailleurs cousent la {item:5770} grâce à un patron rare ; les mineurs fondent des Barres d'or à partir de {item:2776}. Tous les autres achètent les deux à l'hôtel des ventes. Si vous portez la robe, retirez-la : {npc:6266} la garde.",
	-- {item:5770} Robes of Arcana
	["{item:5770}: the Auction House"] = "{item:5770} : l'hôtel des ventes",
	-- {item:3577} Gold Bar
	["{item:3577}: the Auction House"] = "{item:3577} : l'hôtel des ventes",

	-- Step 6: Menara Voidrender
	-- {npc:6266} Menara Voidrender · {npc:6251} Strahad Farsan · {area:392} Ratchet · {npc:2670} Xizk Goodstitch · {area:35} Booty Bay
	["{npc:6266} stands by {npc:6251}'s tower on the hill above {area:392}, behind the engineers' hut. She takes the robe, then sends the gold bar to {npc:2670} in {area:35}."] = "{npc:6266} se tient près de la tour de {npc:6251}, sur la colline au-dessus de {area:392}, derrière la cabane des ingénieurs. Elle prend la robe, puis vous envoie porter la barre d'or à {npc:2670}, à {area:35}.",

	-- Step 7: Xizk Goodstitch
	-- {area:392} Ratchet · {area:35} Booty Bay · {npc:2670} Xizk Goodstitch · {object:59851} A Tailor to Cities (no name in this language: may be words) · {item:3577} Gold Bar
	["The boat from {area:392} sails to {area:35}. {npc:2670} runs {object:59851} on an upper level of the town. Give him the {item:3577}; he will spin the thread later."] = "Le bateau de {area:392} va à {area:35}. {npc:2670} tient la boutique de couture « Un tailleur pour les cités » à un étage supérieur de la ville. Donnez-lui la {item:3577} ; il filera le fil plus tard.",

	-- Step 8: Back to Menara Voidrender
	-- {npc:6266} Menara Voidrender
	["Back to {npc:6266}"] = "Retour auprès de {npc:6266}",
	-- {npc:6266} Menara Voidrender · {zone:1443} Desolace
	["You need no thread yet: {npc:6266} wants demon parts from {zone:1443} next."] = "Vous n'avez pas encore besoin du fil : {npc:6266} veut ensuite des morceaux de démons de {zone:1443}.",

	-- Step 9: Desolace demons
	-- {zone:1443} Desolace
	["{zone:1443} demons"] = "Démons de {zone:1443}",
	-- {area:603} Sargeron · {zone:1443} Desolace · {area:608} Nijel's Point · {area:602} Mannoroc Coven · {spell:686} Shadow Bolt
	-- plural, as words: Lesser Infernals = {npc:4676} Lesser Infernal · Demon Portal Guardians = {npc:11937} Demon Portal Guardian
	["The Hatefury satyrs (level 31-32) hold {area:603} in the far north-east of {zone:1443}, past {area:608}: two kills in five give a vial, so plan on about 25. The Lesser Infernals (36-37) and Demon Portal Guardians (38) of {area:602}, in the south, drop the stone half the time; they resist fire, so use {spell:686} and Corruption."] = "Les satyres Haine-furie (niveau 31-32) tiennent {area:603}, à l'extrême nord-est de {zone:1443}, après {area:608} : deux victimes sur cinq donnent une fiole, comptez donc environ 25. Les Infernaux mineurs (36-37) et les Gardiens du Portail démoniaque (38) du {area:602}, au sud, lâchent la pierre une fois sur deux ; ils résistent au feu, utilisez donc {spell:686} et Corruption.",
	["Vials of Hatefury Blood"] = "Fioles de sang de Fielfurie",

	-- Step 10: Menara Voidrender again
	-- {npc:6266} Menara Voidrender
	["{npc:6266} again"] = "Encore {npc:6266}",

	-- Step 11: Fine Gold Thread
	-- {npc:2670} Xizk Goodstitch · {area:35} Booty Bay · {quest:4785} Fine Gold Thread
	["Back to {npc:2670} in {area:35}: he offers {quest:4785} as a quest you hand straight back to him. He may show no quest marker; talk to him anyway."] = "Retournez voir {npc:2670} à {area:35} : il propose {quest:4785}, une quête que vous lui rendez aussitôt. Il n'affiche parfois aucun marqueur de quête ; parlez-lui quand même.",

	-- Step 12: Smoldering Coal
	-- {area:334} Circle of West Binding · {zone:1417} Arathi Highlands · {spell:686} Shadow Bolt · {area:321} Hammerfall · {item:6265} Soul Shard · {spell:1120} Drain Soul
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Cresting Charms = {item:4481} Cresting Charm · Cresting Exiles = {npc:2761} Cresting Exile
	["The Burning Exiles (level 38-39), fire elementals at the {area:334} in western {zone:1417}, drop the coal about one time in three. They resist fire: {spell:686} and Corruption. Below 38 they hit hard; the Cresting Charms from the Cresting Exiles near {area:321} finish one off once you have hurt it. Make a {item:6265} with {spell:1120} on the way."] = "Les Exilés ardents (niveau 38-39), des élémentaires de feu au {area:334}, dans l'ouest des {zone:1417}, lâchent le charbon environ une fois sur trois. Ils résistent au feu : {spell:686} et Corruption. En dessous du niveau 38, ils frappent fort ; les Charmes armoriés des Exilés grimpeurs près de {area:321} en achèvent un une fois que vous l'avez blessé. Créez un {item:6265} avec {spell:1120} en chemin.",
	-- {item:6265} Soul Shard · {spell:1120} Drain Soul
	["{item:6265}: {spell:1120} on an Exile as it dies"] = "{item:6265} : {spell:1120} sur un Exilé au moment où il meurt",

	-- Step 13: The Completed Robe
	-- {npc:6266} Menara Voidrender · {item:6265} Soul Shard
	["Back to {npc:6266} with the thread, the coals and a {item:6265}. Then wait beside her while she works the robe (do not attack her: the quest log calls it a kill), and speak to her again."] = "Retournez voir {npc:6266} avec le fil, les charbons et un {item:6265}. Attendez ensuite à côté d'elle pendant qu'elle travaille la robe (ne l'attaquez pas : le journal de quêtes parle de la tuer), puis parlez-lui de nouveau.",
	-- {npc:6266} Menara Voidrender
	["Wait beside {npc:6266} while she finishes the robe"] = "Attendez à côté de {npc:6266} pendant qu'elle termine la robe",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 31 {npc:3326} in the {object:172960} sends you to {npc:6266} in {area:392}."] = "Au niveau 31, {npc:3326}, dans {object:172960}, vous envoie voir {npc:6266} à {area:392}.",
	-- ["At 31 {npc:4563} in the {object:36082} sends you to {npc:6266} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}."] = "Au niveau 31, {npc:4563}, dans {object:36082}, vous envoie voir {npc:6266} à {area:392}. Le zeppelin de {zone:1420} va à {zone:1411}.",
	-- ["At 31 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:6266} in {area:392}."] = "Au niveau 31, {npc:461}, à {object:2164} dans {object:2101}, vous envoie voir {npc:6266} à {area:392}.",
	-- ["At 31 {npc:5172} in {zone:1455} sends you to {npc:6266} in {area:392}."] = "Au niveau 31, {npc:5172} à {zone:1455} vous envoie voir {npc:6266} à {area:392}.",
	-- ["Back to {npc:6266} with the thread, the coal and a {item:6265}. Wait while she completes the robe, then speak to her again."] = "Retournez voir {npc:6266} avec le fil, le charbon et un {item:6265}. Attendez qu'elle termine la robe, puis parlez-lui de nouveau.",
	-- ["Bring {npc:6266} a {item:5770}: tailors sew it from a pattern that drops; otherwise buy one at the Auction House. Her next errand needs a {item:3577}: smelted from {item:2776}, or from the Auction House."] = "Apportez à {npc:6266} une {item:5770} : les tailleurs la cousent à partir d'un patron trouvé sur les monstres ; sinon, achetez-en une à l'hôtel des ventes. Sa course suivante demande un {item:3577} : fondu à partir de {item:2776}, ou acheté à l'hôtel des ventes.",
	-- ["The Burning Exiles, fire elementals in western {zone:1417}, drop the coal."] = "Les Exilés ardents, des élémentaires de feu de l'ouest de {zone:1417}, laissent tomber le charbon.",
	-- ["The Hatefury satyrs of {area:603}, in north-eastern {zone:1443}, carry the blood; the Lesser Infernals of Mannoroc Coven, in the south, the stone."] = "Les satyres Fielfurie de {area:603}, dans le nord-est de {zone:1443}, portent le sang ; les Infernaux mineurs du Convent de Mannoroc, au sud, la pierre.",
	-- ["The Hatefury satyrs of {area:603}, in north-eastern {zone:1443}, carry the blood; the Lesser Infernals of {area:602}, in the south, the stone."] = "Les satyres Fielfurie de {area:603}, dans le nord-est de {zone:1443}, portent le sang ; les Infernaux mineurs de {area:602}, au sud, la pierre.",
	-- ["Wait for the robe"] = "Attendre la robe",
	-- ["{npc:2670} in {area:35} has the thread for you."] = "{npc:2670} à {area:35} a le fil pour vous.",
	-- ["{npc:2670} sells tailoring supplies in {area:35}. Bring him the {item:3577}."] = "{npc:2670} vend des fournitures de couture à {area:35}. Apportez-lui le {item:3577}.",
	-- ["{npc:6266} stands in the tower on the hill above {area:392}, beside {npc:6251}."] = "{npc:6266} se trouve dans la tour sur la colline au-dessus de {area:392}, à côté de {npc:6251}.",
}
