-- Spanish (Latin America) (esMX): the guide forever/class/warlock/enchanted-gold-bloodrobe (forever/class/warlock/enchanted-gold-bloodrobe.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:6266} Menara Voidrender
	["A rare cloth robe for your 30s from {npc:6266}; its last parts wait for levels 35 and 37."] = "Una túnica de tela rara para tus 30, de {npc:6266}; sus últimas piezas esperan a los niveles 35 y 37.",

	-- Step 1: In Search of Menara Voidrender (Stormwind)
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6266} Menara Voidrender · {area:392} Ratchet · {item:5770} Robes of Arcana · {item:3577} Gold Bar
	["At 31 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:6266} in {area:392}. Buy a {item:5770} and a {item:3577} first (next steps) to save a trip."] = "A nivel 31, {npc:461}, en {object:2164}, en {object:2101}, te manda con {npc:6266} en {area:392}. Compra antes {item:5770} y {item:3577} (pasos siguientes) para ahorrarte un viaje.",

	-- Step 2: In Search of Menara Voidrender (Ironforge)
	-- {npc:5172} Briarthorn · {zone:1455} Ironforge · {npc:6266} Menara Voidrender · {area:392} Ratchet · {item:5770} Robes of Arcana · {item:3577} Gold Bar
	["At 31 {npc:5172} in {zone:1455} sends you to {npc:6266} in {area:392}. Buy a {item:5770} and a {item:3577} first (next steps) to save a trip."] = "A nivel 31, {npc:5172} en {zone:1455} te manda con {npc:6266} en {area:392}. Compra antes {item:5770} y {item:3577} (pasos siguientes) para ahorrarte un viaje.",

	-- Step 3: In Search of Menara Voidrender (Orgrimmar)
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow · {npc:6266} Menara Voidrender · {area:392} Ratchet · {item:5770} Robes of Arcana · {item:3577} Gold Bar
	["At 31 {npc:3326} in the {object:172960} sends you to {npc:6266} in {area:392}. Buy a {item:5770} and a {item:3577} first (next steps) to save a trip."] = "A nivel 31, {npc:3326} en {object:172960} te manda con {npc:6266} en {area:392}. Compra antes {item:5770} y {item:3577} (pasos siguientes) para ahorrarte un viaje.",

	-- Step 4: In Search of Menara Voidrender (Undercity)
	-- {npc:4563} Kaal Soulreaper · {object:36082} Magic Quarter · {npc:6266} Menara Voidrender · {area:392} Ratchet · {zone:1420} Tirisfal Glades · {zone:1411} Durotar · {item:5770} Robes of Arcana · {item:3577} Gold Bar
	["At 31 {npc:4563} in the {object:36082} sends you to {npc:6266} in {area:392}; the zeppelin from {zone:1420} flies to {zone:1411}. Buy a {item:5770} and a {item:3577} first (next steps) to save a trip."] = "A nivel 31, {npc:4563} en {object:36082} te manda con {npc:6266} en {area:392}; el zepelín desde {zone:1420} vuela a {zone:1411}. Compra antes {item:5770} y {item:3577} (pasos siguientes) para ahorrarte un viaje.",

	-- Step 5: Robes of Arcana and a Gold Bar
	-- {item:5770} Robes of Arcana · {item:3577} Gold Bar
	["{item:5770} and a {item:3577}"] = "{item:5770} y {item:3577}",
	-- {item:5770} Robes of Arcana · {item:2776} Gold Ore · {npc:6266} Menara Voidrender
	-- plural, as words: Gold Bars = {item:3577} Gold Bar
	["Tailors sew the {item:5770} from a rare pattern; miners smelt Gold Bars from {item:2776}. Everyone else buys both at the Auction House. If you wear the robe, take it off: {npc:6266} keeps it."] = "Los sastres cosen {item:5770} con un patrón raro; los mineros funden Barras de oro con {item:2776}. Los demás compran ambos en la casa de subastas. Si llevas puesta la túnica, quítatela: {npc:6266} se la queda.",
	-- {item:5770} Robes of Arcana
	["{item:5770}: the Auction House"] = "{item:5770}: la casa de subastas",
	-- {item:3577} Gold Bar
	["{item:3577}: the Auction House"] = "{item:3577}: la casa de subastas",

	-- Step 6: Menara Voidrender
	-- {npc:6266} Menara Voidrender · {npc:6251} Strahad Farsan · {area:392} Ratchet · {npc:2670} Xizk Goodstitch · {area:35} Booty Bay
	["{npc:6266} stands by {npc:6251}'s tower on the hill above {area:392}, behind the engineers' hut. She takes the robe, then sends the gold bar to {npc:2670} in {area:35}."] = "{npc:6266} está junto a la torre de {npc:6251}, en la colina sobre {area:392}, detrás de la choza de los ingenieros. Recibe la túnica y luego manda la barra de oro a {npc:2670} en {area:35}.",

	-- Step 7: Xizk Goodstitch
	-- {area:392} Ratchet · {area:35} Booty Bay · {npc:2670} Xizk Goodstitch · {object:59851} A Tailor to Cities (no name in this language: may be words) · {item:3577} Gold Bar
	["The boat from {area:392} sails to {area:35}. {npc:2670} runs {object:59851} on an upper level of the town. Give him the {item:3577}; he will spin the thread later."] = "El barco de {area:392} navega a {area:35}. {npc:2670} atiende {object:59851} en un nivel superior del pueblo. Dale {item:3577}; él hilará el hilo después.",

	-- Step 8: Back to Menara Voidrender
	-- {npc:6266} Menara Voidrender
	["Back to {npc:6266}"] = "Regresa con {npc:6266}",
	-- {npc:6266} Menara Voidrender · {zone:1443} Desolace
	["You need no thread yet: {npc:6266} wants demon parts from {zone:1443} next."] = "Todavía no necesitas el hilo: {npc:6266} quiere después partes de demonio de {zone:1443}.",

	-- Step 9: Hatefury satyrs
	["Hatefury satyrs"] = "Sátiros Odio Feroz",
	-- {area:603} Sargeron · {zone:1443} Desolace · {area:608} Nijel's Point
	["The Hatefury satyrs (level 31-32) hold {area:603} in the far north-east of {zone:1443}, past {area:608}: two kills in five give a vial, so plan on about 25."] = "Los sátiros Odio Feroz (nivel 31-32) ocupan {area:603}, en el extremo noreste de {zone:1443}, pasando {area:608}: dos de cada cinco muertes dan un vial, así que cuenta con unas 25.",
	["Vials of Hatefury Blood"] = "Viales de sangre de odio feroz",

	-- Step 10: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace · {spell:686} Shadow Bolt
	-- plural, as words: Lesser Infernals = {npc:4676} Lesser Infernal · Demon Portal Guardians = {npc:11937} Demon Portal Guardian
	["The Lesser Infernals (36-37) and Demon Portal Guardians (38) of {area:602}, in the south of {zone:1443}, drop the stone half the time. The guide waits for level 35 first: at 31 they are too strong to solo. They resist fire, so use {spell:686} and Corruption."] = "Los Infernales inferiores (36-37) y los Guardianes del portal de demonios (38) de {area:602}, en el sur de {zone:1443}, sueltan la piedra la mitad de las veces. La guía espera primero al nivel 35: a nivel 31 son demasiado fuertes para ir solo. Resisten el fuego, así que usa {spell:686} y Corrupción.",

	-- Step 11: Menara Voidrender again
	-- {npc:6266} Menara Voidrender
	["{npc:6266} again"] = "{npc:6266} otra vez",

	-- Step 12: Fine Gold Thread
	-- {npc:2670} Xizk Goodstitch · {area:35} Booty Bay · {quest:4785} Fine Gold Thread
	["Back to {npc:2670} in {area:35}: he offers {quest:4785} as a quest you hand straight back to him. He may show no quest marker; talk to him anyway."] = "De vuelta con {npc:2670} en {area:35}: ofrece {quest:4785} como una misión que le devuelves enseguida. Puede que no muestre marca de misión; háblale igual.",
	-- {npc:2670} Xizk Goodstitch · {quest:4785} Fine Gold Thread
	["{npc:2670}: {quest:4785}, handed straight back"] = "{npc:2670}: {quest:4785}, se le devuelve en el acto",

	-- Step 13: Smoldering Coal
	-- {area:334} Circle of West Binding · {zone:1417} Arathi Highlands · {spell:686} Shadow Bolt · {area:321} Hammerfall · {item:6265} Soul Shard · {spell:1120} Drain Soul
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Cresting Charms = {item:4481} Cresting Charm · Cresting Exiles = {npc:2761} Cresting Exile
	["The Burning Exiles (level 38-39), fire elementals at the {area:334} in western {zone:1417}, drop the coal about one time in three. The guide waits for level 37 first: below it they hit too hard to solo. They resist fire: {spell:686} and Corruption. The Cresting Charms from the Cresting Exiles near {area:321} finish one off once you have hurt it. Make a {item:6265} with {spell:1120} on the way."] = "Los Exiliados ardientes (nivel 38-39), elementales de fuego en {area:334}, en el oeste de {zone:1417}, sueltan el carbón aproximadamente una de cada tres veces. La guía espera primero al nivel 37: por debajo pegan demasiado fuerte para ir solo. Resisten el fuego: {spell:686} y Corrupción. Los Talismanes blasonados de los Exiliados acuosos cerca de {area:321} rematan a uno cuando ya lo dañaste. Crea un {item:6265} con {spell:1120} en el camino.",
	-- {item:6265} Soul Shard · {spell:1120} Drain Soul
	["{item:6265}: {spell:1120} on an Exile as it dies"] = "{item:6265}: {spell:1120} sobre un exiliado mientras muere",

	-- Step 14: The Completed Robe
	-- {npc:6266} Menara Voidrender · {item:6265} Soul Shard
	["Back to {npc:6266} with the thread, the coals and a {item:6265}. Then wait beside her while she works the robe (do not attack her: the quest log calls it a kill), and speak to her again."] = "De vuelta con {npc:6266} con el hilo, las brasas y una {item:6265}. Luego espera a su lado mientras trabaja la túnica (no la ataques: el registro de misiones lo llama matar) y vuelve a hablarle.",
	-- {npc:6266} Menara Voidrender
	["Wait beside {npc:6266} while she finishes the robe"] = "Espera junto a {npc:6266} mientras termina la túnica",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A rare cloth robe for your 30s, which {npc:6266} makes from the parts you bring her."] = "Una túnica de tela rara para tus 30, que {npc:6266} confecciona con las piezas que le lleves.",
	-- ["At 31 {npc:3326} in the {object:172960} sends you to {npc:6266} in {area:392}."] = "A nivel 31, {npc:3326} en {object:172960} te envía con {npc:6266} en {area:392}.",
	-- ["At 31 {npc:4563} in the {object:36082} sends you to {npc:6266} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}."] = "A nivel 31, {npc:4563} en {object:36082} te envía con {npc:6266} en {area:392}. El zepelín de {zone:1420} vuela a {zone:1411}.",
	-- ["At 31 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:6266} in {area:392}."] = "A nivel 31, {npc:461} en {object:2164}, en {object:2101}, te envía con {npc:6266} en {area:392}.",
	-- ["At 31 {npc:5172} in {zone:1455} sends you to {npc:6266} in {area:392}."] = "A nivel 31, {npc:5172} en {zone:1455} te envía con {npc:6266} en {area:392}.",
	-- ["Back to {npc:6266} with the thread, the coal and a {item:6265}. Wait while she completes the robe, then speak to her again."] = "Regresa con {npc:6266} con el hilo, el carbón y una {item:6265}. Espera mientras termina la túnica y luego vuelve a hablar con ella.",
	-- ["Bring {npc:6266} a {item:5770}: tailors sew it from a pattern that drops; otherwise buy one at the Auction House. Her next errand needs a {item:3577}: smelted from {item:2776}, or from the Auction House."] = "Lleva a {npc:6266} una {item:5770}: los sastres la cosen con un patrón que se obtiene como botín; si no, compra una en la casa de subastas. Su siguiente encargo requiere una {item:3577}: fundida de {item:2776} o de la casa de subastas.",
	-- ["The Burning Exiles, fire elementals in western {zone:1417}, drop the coal."] = "Los exiliados ardientes, elementales de fuego del oeste de {zone:1417}, sueltan el carbón.",
	-- ["The Hatefury satyrs of {area:603}, in north-eastern {zone:1443}, carry the blood; the Lesser Infernals of Mannoroc Coven, in the south, the stone."] = "Los sátiros Odio Feroz de {area:603}, en el noreste de {zone:1443}, llevan la sangre; los infernales inferiores ({npc:4676}) de Aquelarre Mannoroc, en el sur, la piedra.",
	-- ["The Hatefury satyrs of {area:603}, in north-eastern {zone:1443}, carry the blood; the Lesser Infernals of {area:602}, in the south, the stone."] = "Los sátiros Odio Feroz de {area:603}, en el noreste de {zone:1443}, llevan la sangre; los infernales inferiores de {area:602}, en el sur, la piedra.",
	-- ["Wait for the robe"] = "Espera la túnica",
	-- ["{npc:2670} in {area:35} has the thread for you."] = "{npc:2670} en {area:35} tiene el hilo para ti.",
	-- ["{npc:2670} sells tailoring supplies in {area:35}. Bring him the {item:3577}."] = "{npc:2670} vende suministros de sastrería en {area:35}. Llévale la {item:3577}.",
	-- ["{npc:6266} stands in the tower on the hill above {area:392}, beside {npc:6251}."] = "{npc:6266} está en la torre de la colina sobre {area:392}, junto a {npc:6251}.",
	-- ["{zone:1443} demons"] = "Demonios de {zone:1443}",
}
