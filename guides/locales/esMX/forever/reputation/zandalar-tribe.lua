-- Spanish (Latin America) (esMX): the guide forever/reputation/zandalar-tribe (forever/reputation/zandalar-tribe.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Zandalar Tribe Reputation"] = "Reputación con la Tribu Zandalar",
	-- {area:19} Zul'Gurub
	["Shoulder and head enchants, a class necklace upgraded at every standing, and {area:19}'s set pieces."] = "Encantamientos de hombros y cabeza, un collar de clase que se mejora en cada nivel de reputación y las piezas de conjunto de {area:19}.",
	["Your class's necklace at Friendly, upgraded at Honored, Revered and Exalted"] = "El collar de tu clase en Amistoso, mejorado en Honorable, Reverenciado y Exaltado",
	-- {npc:15042} Zanza the Restless
	["{npc:15042}'s head and leg enchants, from Friendly"] = "Los encantamientos de cabeza y piernas de {npc:15042}, desde Amistoso",

	-- Step 1: Yojamba Isle
	-- {area:3357} Yojamba Isle · {zone:1434} Stranglethorn Vale · {area:122} Zuuldaia Ruins · {faction:270} Zandalar Tribe · {npc:15070} Vinchaxa · {npc:14921} Rin'wosho the Trader · {npc:14902} Jin'rokh the Breaker · {npc:14903} Al'tabim the All-Seeing · {npc:14904} Maywiki of Zuldazar · {npc:14905} Falthir the Sightless · {area:19} Zul'Gurub
	["{area:3357} is the small island off the north-west coast of {zone:1434}, west of the {area:122}: swim over from the coast. Everyone starts Neutral with the {faction:270}. {npc:15070} takes coins and bijous, {npc:14921} sells the recipes and trades Honor Tokens, and {npc:14902}, {npc:14903}, {npc:14904} and {npc:14905} hand out the class necklaces and the set pieces. Almost all Zandalar reputation comes from {area:19}, a 20-player raid, and {area:19} is not among the first raids Blizzard has announced for Forever: until it opens there is no Zandalar reputation to earn, and no coins or bijous on the auction house either. Once it is open, the only solo way is buying coins and bijous on the auction house (75 per bijou, 25 per set of three coins). The Legacy perk Diplomat adds up to 10% to every gain; the numbers in this guide are without it."] = "{area:3357} es la islita frente a la costa noroeste de {zone:1434}, al oeste de {area:122}: cruza nadando desde la costa. Todos empiezan en Neutral con {faction:270}. {npc:15070} acepta monedas y bijous, {npc:14921} vende las recetas y canjea fichas de honor, y {npc:14902}, {npc:14903}, {npc:14904} y {npc:14905} dan los collares de clase y las piezas de conjunto. Casi toda la reputación Zandalar sale de {area:19}, una banda de 20 jugadores, y {area:19} no está entre las primeras bandas que Blizzard anunció para Forever: hasta que abra no hay reputación Zandalar que ganar, ni monedas ni bijous en la casa de subastas. Una vez abierta, la única forma en solitario es comprar monedas y bijous en la casa de subastas (75 por bijou, 25 por cada juego de tres monedas). La ventaja Diplomático del Legado suma hasta un 10% a cada ganancia; los números de esta guía son sin ella.",

	-- Step 2: Zul'Gurub to Friendly
	-- {area:19} Zul'Gurub
	["{area:19} to Friendly"] = "{area:19} hasta Amistoso",
	-- {area:19} Zul'Gurub · {zone:1434} Stranglethorn Vale · {area:3398} Edge of Madness · {npc:15114} Gahz'ranka · {npc:11382} Bloodlord Mandokir · {item:22637} Primal Hakkari Idol · {item:19881} Channeler's Head · {quest:8240} A Bijou for Zanza
	["{area:19} is the troll city in the north-east of {zone:1434}: a 20-player raid. Trash pays 3 to 5 each until 11,999 of 12,000 Honored, one point short of Revered; the Speakers 15, Ohgan 15, the {area:3398} boss 25, {npc:15114} and the five High Priests 100, {npc:11382} and Jin'do 200 and Hakkar 400, all the way to Exalted. A full clear is about 4,050: one clear reaches Friendly (3,000). Loot every coin, bijou, {item:22637}, {item:19881} and Primal Hakkari set piece. Coins and bijous pay the same at any standing: save them until the trash stops counting, except one bijou for {quest:8240}."] = "{area:19} es la ciudad trol del noreste de {zone:1434}: una banda de 20 jugadores. Los enemigos menores pagan de 3 a 5 cada uno hasta 11.999 de 12.000 en Honorable, a un punto de Reverenciado; los Oradores 15, Ohgan 15, el jefe de {area:3398} 25, {npc:15114} y los cinco sumos sacerdotes 100, {npc:11382} y Jin'do 200 y Hakkar 400, hasta Exaltado. Despejarla completa da unos 4.050: con una pasada llegas a Amistoso (3.000). Saquea cada moneda, bijou, {item:22637}, {item:19881} y pieza de conjunto hakkari primigenia. Las monedas y bijous pagan lo mismo con cualquier reputación: guárdalos hasta que los enemigos menores dejen de contar, salvo un bijou para {quest:8240}.",
	-- {item:19707} Red Hakkari Bijou
	["{item:19707}; any of the nine colours does"] = "{item:19707}; sirve cualquiera de los nueve colores",

	-- Step 3: A Bijou for Zanza
	-- {object:180367} Altar of Zanza (no name in this language: may be words) · {area:3357} Yojamba Isle · {npc:15070} Vinchaxa · {item:19858} Zandalar Honor Token
	["Destroy one bijou at the {object:180367}, the stone altar on the west side of {area:3357} (right-click the bijou there), then tell {npc:15070}: 150 reputation and an extra {item:19858}, once. From then on every bijou you destroy at the altar pays 75 reputation and a token, and every set of three coins {npc:15070} takes pays 25 and a token. They never stop counting."] = "Destruye un bijou en el {object:180367}, el altar de piedra del lado oeste de {area:3357} (clic derecho en el bijou ahí), y luego avísale a {npc:15070}: 150 de reputación y una {item:19858} extra, una vez. Desde entonces, cada bijou que destruyas en el altar paga 75 de reputación y una ficha, y cada juego de tres monedas que acepta {npc:15070} paga 25 y una ficha. Nunca dejan de contar.",

	-- Step 4: Friendly: your class necklace
	["Friendly: your class necklace"] = "Amistoso: el collar de tu clase",
	-- {item:19766} Pattern: Bloodvine Boots · {item:19687} Primal Batskin Bracers · {item:19778} Plans: Bloodsoul Gauntlets · {item:19695} Darksoul Shoulders · {item:20001} Schematic: Bloodvine Lens · {item:20012} Recipe: Greater Dreamless Sleep · {item:20757} Formula: Brilliant Mana Oil
	["At Friendly your class's trainer on the isle gives a necklace for free (100 reputation); the same NPC upgrades it at Honored, Revered and Exalted (100 each) with no raid item needed. Friendly also opens Rin'wosho's first recipes ({item:19766}, {item:19687}, {item:19778}, {item:19695}, {item:20001}, {item:20012}, 5g each; {item:20757}, 4g) and the Paragons of Power bracers (150 for the Primal Hakkari bracer token of your class)."] = "En Amistoso, el instructor de tu clase en la isla te da un collar gratis (100 de reputación); el mismo PNJ lo mejora en Honorable, Reverenciado y Exaltado (100 cada vez) sin necesidad de objetos de banda. Amistoso también abre las primeras recetas de Rin'wosho ({item:19766}, {item:19687}, {item:19778}, {item:19695}, {item:20001}, {item:20012}, 5g cada una; {item:20757}, 4g) y los brazales de los Dechados de poder (150 por la ficha de brazales hakkari primigenia de tu clase).",
	-- {npc:14902} Jin'rokh the Breaker · {item:19574} Strength of Mugamba
	["{npc:14902}: {item:19574}, Friendly"] = "{npc:14902}: {item:19574}, Amistoso",
	-- {npc:14902} Jin'rokh the Breaker · {item:19579} Heathen's Brand
	["{npc:14902}: {item:19579}, Friendly"] = "{npc:14902}: {item:19579}, Amistoso",
	-- {npc:14903} Al'tabim the All-Seeing · {quest:8049} The Eye of Zuldazar
	["{npc:14903}: {quest:8049}, Friendly"] = "{npc:14903}: {quest:8049}, Amistoso",
	-- {npc:14903} Al'tabim the All-Seeing · {item:19598} Pebble of Kajaro
	["{npc:14903}: {item:19598}, Friendly"] = "{npc:14903}: {item:19598}, Amistoso",
	-- {npc:14903} Al'tabim the All-Seeing · {quest:8106} Kezan's Taint
	["{npc:14903}: {quest:8106}, Friendly"] = "{npc:14903}: {quest:8106}, Amistoso",
	-- {npc:14904} Maywiki of Zuldazar · {quest:8110} Enchanted South Seas Kelp
	["{npc:14904}: {quest:8110}, Friendly"] = "{npc:14904}: {quest:8110}, Amistoso",
	-- {npc:14904} Maywiki of Zuldazar · {quest:8116} Vision of Voodress
	["{npc:14904}: {quest:8116}, Friendly"] = "{npc:14904}: {quest:8116}, Amistoso",
	-- {npc:14905} Falthir the Sightless · {quest:8141} Zandalarian Shadow Talisman
	["{npc:14905}: {quest:8141}, Friendly"] = "{npc:14905}: {quest:8141}, Amistoso",
	-- {npc:14905} Falthir the Sightless · {item:19618} Maelstrom's Tendril
	["{npc:14905}: {item:19618}, Friendly"] = "{npc:14905}: {item:19618}, Amistoso",

	-- Step 5: Zanza the Restless's enchants, from Friendly
	-- {npc:15042} Zanza the Restless
	["{npc:15042}'s enchants, from Friendly"] = "Los encantamientos de {npc:15042}, desde Amistoso",
	-- {npc:15042} Zanza the Restless · {area:19} Zul'Gurub · {item:22637} Primal Hakkari Idol · {npc:11380} Jin'do the Hexxer · {npc:11382} Bloodlord Mandokir · {item:19813} Punctured Voodoo Doll
	-- plural, as words: Jinxed Hoodoo Piles = {object:180228} Jinxed Hoodoo Pile
	["{npc:15042}, a spirit just inside {area:19}'s entrance, trades your class's head and leg enchant for a {item:22637} ({npc:11380} or {npc:11382}, about 90%) and your class's {item:19813} (the Jinxed Hoodoo Piles scattered through {area:19}, now and then from its trash): 100 reputation each, as often as you like."] = "{npc:15042}, un espíritu justo al entrar a {area:19}, canjea el encantamiento de cabeza y piernas de tu clase por un {item:22637} ({npc:11380} o {npc:11382}, más o menos el 90%) y el {item:19813} de tu clase (los montones de vudú embrujados repartidos por {area:19}, y de vez en cuando de sus enemigos menores): 100 de reputación cada uno, cuantas veces quieras.",
	-- {item:22637} Primal Hakkari Idol
	["{item:22637}, Jin'do or Mandokir"] = "{item:22637}, Jin'do o Mandokir",
	-- {item:19813} Punctured Voodoo Doll
	["your class's {item:19813}"] = "el {item:19813} de tu clase",
	-- {npc:15042} Zanza the Restless
	["{npc:15042}: idol and doll, 100"] = "{npc:15042}: ídolo y muñeco, 100",

	-- Step 6: Zul'Gurub to Honored
	-- {area:19} Zul'Gurub
	["{area:19} to Honored"] = "{area:19} hasta Honorable",
	-- {item:19683} Bloodvine Leggings · {item:19686} Primal Batskin Gloves · {item:19689} Blood Tiger Shoulders · {item:19691} Bloodsoul Shoulders · {item:19694} Darksoul Leggings · {item:20004} Major Troll's Blood Elixir · {item:20000} Schematic: Bloodvine Goggles · {item:20756} Formula: Brilliant Wizard Oil · {item:232611} Magnificent Trollshine · {quest:8196} Essence Mangoes · {item:22635} Savage Guard
	["Friendly to Honored is 6,000: one and a half clears. Honored opens {item:19683}, {item:19686}, {item:19689}, {item:19691}, {item:19694} and {item:20004} (5g each), {item:20000} (12g), {item:20756} (4g) and {item:232611} (4g), the Paragons of Power belts and mantles (150 each), {quest:8196} (one Honor Token) and The {item:22635}."] = "",

	-- Step 7: Honored: necklace, Savage Guard and mangoes
	-- {item:22635} Savage Guard
	["Honored: necklace, {item:22635} and mangoes"] = "Honorable: collar, {item:22635} y mangos",
	-- {npc:15042} Zanza the Restless · {item:18331} Arcanum of Protection · {item:22635} Savage Guard · {npc:14368} Lorekeeper Lydros · {area:2577} Dire Maul · {item:18335} Pristine Black Diamond · {item:12735} Frayed Abomination Stitching · {item:12938} Blood of Heroes · {item:12753} Skin of Shadow · {npc:14921} Rin'wosho the Trader · {quest:8196} Essence Mangoes
	-- plural, as words: Large Brilliant Shards = {item:14344} Large Brilliant Shard
	["{npc:15042} takes an {item:18331}, Rapidity or Focus for the {item:22635} head and leg enchant: 200 reputation each, again and again. The Arcanum binds to you, so it never sells: {npc:14368} in the library of {area:2577} makes it from the matching Libram ({area:2577} drops, and on the auction house), a {item:18335} and Large Brilliant Shards, plus {item:12735}, two {item:12938} or two {item:12753}. {npc:14921} trades {quest:8196} for an Honor Token."] = "{npc:15042} acepta un {item:18331}, de Rapidez o de Concentración para el encantamiento de cabeza y piernas {item:22635}: 200 de reputación cada uno, una y otra vez. El Arcanum se liga a ti, así que nunca se vende: {npc:14368}, en la biblioteca de {area:2577}, lo hace con el Libram correspondiente (botín de {area:2577}, y en la casa de subastas), un {item:18335} y fragmentos brillantes grandes, más {item:12735}, dos {item:12938} o dos {item:12753}. {npc:14921} canjea {quest:8196} por una ficha de honor.",
	-- {npc:14902} Jin'rokh the Breaker · {item:19574} Strength of Mugamba
	["{npc:14902}: {item:19574}, Honored"] = "{npc:14902}: {item:19574}, Honorable",
	-- {npc:14902} Jin'rokh the Breaker · {item:19579} Heathen's Brand
	["{npc:14902}: {item:19579}, Honored"] = "{npc:14902}: {item:19579}, Honorable",
	-- {npc:14903} Al'tabim the All-Seeing · {quest:8049} The Eye of Zuldazar
	["{npc:14903}: {quest:8049}, Honored"] = "{npc:14903}: {quest:8049}, Honorable",
	-- {npc:14903} Al'tabim the All-Seeing · {item:19598} Pebble of Kajaro
	["{npc:14903}: {item:19598}, Honored"] = "{npc:14903}: {item:19598}, Honorable",
	-- {npc:14903} Al'tabim the All-Seeing · {quest:8106} Kezan's Taint
	["{npc:14903}: {quest:8106}, Honored"] = "{npc:14903}: {quest:8106}, Honorable",
	-- {npc:14904} Maywiki of Zuldazar · {quest:8110} Enchanted South Seas Kelp
	["{npc:14904}: {quest:8110}, Honored"] = "{npc:14904}: {quest:8110}, Honorable",
	-- {npc:14904} Maywiki of Zuldazar · {quest:8116} Vision of Voodress
	["{npc:14904}: {quest:8116}, Honored"] = "{npc:14904}: {quest:8116}, Honorable",
	-- {npc:14905} Falthir the Sightless · {quest:8141} Zandalarian Shadow Talisman
	["{npc:14905}: {quest:8141}, Honored"] = "{npc:14905}: {quest:8141}, Honorable",
	-- {npc:14905} Falthir the Sightless · {item:19618} Maelstrom's Tendril
	["{npc:14905}: {item:19618}, Honored"] = "{npc:14905}: {item:19618}, Honorable",
	-- {quest:8196} Essence Mangoes · {item:19858} Zandalar Honor Token
	["{quest:8196}: one {item:19858}"] = "{quest:8196}: una {item:19858}",

	-- Step 8: Zul'Gurub to Revered
	-- {area:19} Zul'Gurub
	["{area:19} to Revered"] = "{area:19} hasta Reverenciado",
	-- {quest:8201} A Collection of Heads · {npc:14910} Exzhal · {item:19883} Sacred Cord · {quest:8183} The Heart of Hakkar · {npc:14875} Molthor · {item:19682} Bloodvine Vest · {item:19685} Primal Batskin Jerkin · {item:19688} Blood Tiger Breastplate · {item:19690} Bloodsoul Breastplate · {item:19693} Darksoul Breastplate · {item:20007} Mageblood Elixir · {quest:8243} Zanza's Potent Potables
	-- plural, as words: Channeler's Heads = {item:19881} Channeler's Head
	["Honored to Revered is 12,000: about three clears. Two one-time quests help: {quest:8201} ({npc:14910} on the isle: 200 for five Channeler's Heads from the High Priests, strung on his {item:19883}) and {quest:8183} (one per kill, for whoever loots it; {npc:14875} on the isle pays 200 and a Zandalarian Hero badge, charm or medallion). Revered opens {item:19682}, {item:19685}, {item:19688}, {item:19690}, {item:19693} and {item:20007} (5g each), the Paragons of Power chests and mantles (150) and {quest:8243}."] = "De Honorable a Reverenciado son 12.000: unas tres pasadas. Dos misiones únicas ayudan: {quest:8201} ({npc:14910} en la isla: 200 por cinco cabezas de canalizador de los sumos sacerdotes, ensartadas en su {item:19883}) y {quest:8183} (una por muerte, para quien la saquee; {npc:14875} en la isla paga 200 y una insignia, amuleto o medallón de héroe zandalariano). Reverenciado abre {item:19682}, {item:19685}, {item:19688}, {item:19690}, {item:19693} y {item:20007} (5g cada una), las pecheras y mantos de los Dechados de poder (150) y {quest:8243}.",

	-- Step 9: Revered: necklace, coins and bijous
	["Revered: necklace, coins and bijous"] = "Reverenciado: collar, monedas y bijous",
	-- {npc:15042} Zanza the Restless · {item:22635} Savage Guard · {item:20081} Swiftness of Zanza
	["Trash stopped counting at 11,999 Honored. Revered to Exalted is 21,000: bosses give about 1,350 a clear, and now the saved coins and bijous pay: 75 per bijou (280 bijous alone), 25 per coin set. Coins and bijous are tradeable, so the auction house is the only solo way. Each Paragons piece pays 150, each {npc:15042} enchant 100, each {item:22635} 200. Rin'wosho trades one of {npc:15042}'s potables (Spirit, Sheen or {item:20081}) for an Honor Token."] = "Los enemigos menores dejaron de contar en 11.999 de Honorable. De Reverenciado a Exaltado son 21.000: los jefes dan unos 1.350 por pasada, y ahora pagan las monedas y bijous guardados: 75 por bijou (280 bijous solos), 25 por juego de monedas. Las monedas y bijous se pueden comerciar, así que la casa de subastas es la única forma en solitario. Cada pieza de los Dechados paga 150, cada encantamiento de {npc:15042} 100, cada {item:22635} 200. Rin'wosho canjea uno de los brebajes de {npc:15042} (Espíritu, Brillo o {item:20081}) por una ficha de honor.",
	-- {npc:14902} Jin'rokh the Breaker · {item:19575} Strength of Mugamba
	["{npc:14902}: {item:19575}, Revered"] = "{npc:14902}: {item:19575}, Reverenciado",
	-- {npc:14902} Jin'rokh the Breaker · {item:19585} Heathen's Brand
	["{npc:14902}: {item:19585}, Revered"] = "{npc:14902}: {item:19585}, Reverenciado",
	-- {npc:14903} Al'tabim the All-Seeing · {quest:8050} The Eye of Zuldazar
	["{npc:14903}: {quest:8050}, Revered"] = "{npc:14903}: {quest:8050}, Reverenciado",
	-- {npc:14903} Al'tabim the All-Seeing · {item:19599} Pebble of Kajaro
	["{npc:14903}: {item:19599}, Revered"] = "{npc:14903}: {item:19599}, Reverenciado",
	-- {npc:14903} Al'tabim the All-Seeing · {quest:8107} Kezan's Taint
	["{npc:14903}: {quest:8107}, Revered"] = "{npc:14903}: {quest:8107}, Reverenciado",
	-- {npc:14904} Maywiki of Zuldazar · {quest:8111} Enchanted South Seas Kelp
	["{npc:14904}: {quest:8111}, Revered"] = "{npc:14904}: {quest:8111}, Reverenciado",
	-- {npc:14904} Maywiki of Zuldazar · {quest:8117} Vision of Voodress
	["{npc:14904}: {quest:8117}, Revered"] = "{npc:14904}: {quest:8117}, Reverenciado",
	-- {npc:14905} Falthir the Sightless · {quest:8142} Zandalarian Shadow Talisman
	["{npc:14905}: {quest:8142}, Revered"] = "{npc:14905}: {quest:8142}, Reverenciado",
	-- {npc:14905} Falthir the Sightless · {item:19619} Maelstrom's Tendril
	["{npc:14905}: {item:19619}, Revered"] = "{npc:14905}: {item:19619}, Reverenciado",
	-- {npc:15070} Vinchaxa
	["{npc:15070}: 3 coins, 25 and a token"] = "{npc:15070}: 3 monedas, 25 y una ficha",
	["25 and a token"] = "25 y una ficha",
	-- {quest:8243} Zanza's Potent Potables
	["{quest:8243}: one token"] = "{quest:8243}: una ficha",

	-- Step 10: Exalted: the Signets of the Zandalar
	-- {quest:8246} Signets of the Zandalar
	["Exalted: the {quest:8246}"] = "Exaltado: los {quest:8246}",
	-- {item:20013} Recipe: Living Action Potion
	-- plural, as words: Zandalar Honor Tokens = {item:19858} Zandalar Honor Token
	["At Exalted your necklace takes its last upgrade, Rin'wosho sells {item:20013} (5g), and Rin'wosho trades 15 Zandalar Honor Tokens for one Signet of the Zandalar, the shoulder enchant: Might (attack power), Mojo (spell damage) or Serenity (healing)."] = "En Exaltado tu collar recibe su última mejora, Rin'wosho vende {item:20013} (5g), y Rin'wosho canjea 15 fichas de honor zandalar por un sello de los Zandalar, el encantamiento de hombros: de Poderío (poder de ataque), de Mojo (daño con hechizos) o de Serenidad (sanación).",
	-- {npc:14902} Jin'rokh the Breaker · {item:19576} Strength of Mugamba
	["{npc:14902}: {item:19576}, Exalted"] = "{npc:14902}: {item:19576}, Exaltado",
	-- {npc:14902} Jin'rokh the Breaker · {item:19586} Heathen's Brand
	["{npc:14902}: {item:19586}, Exalted"] = "{npc:14902}: {item:19586}, Exaltado",
	-- {npc:14903} Al'tabim the All-Seeing · {quest:8051} The Eye of Zuldazar
	["{npc:14903}: {quest:8051}, Exalted"] = "{npc:14903}: {quest:8051}, Exaltado",
	-- {npc:14903} Al'tabim the All-Seeing · {item:19600} Pebble of Kajaro
	["{npc:14903}: {item:19600}, Exalted"] = "{npc:14903}: {item:19600}, Exaltado",
	-- {npc:14903} Al'tabim the All-Seeing · {quest:8108} Kezan's Taint
	["{npc:14903}: {quest:8108}, Exalted"] = "{npc:14903}: {quest:8108}, Exaltado",
	-- {npc:14904} Maywiki of Zuldazar · {quest:8112} Enchanted South Seas Kelp
	["{npc:14904}: {quest:8112}, Exalted"] = "{npc:14904}: {quest:8112}, Exaltado",
	-- {npc:14904} Maywiki of Zuldazar · {quest:8118} Vision of Voodress
	["{npc:14904}: {quest:8118}, Exalted"] = "{npc:14904}: {quest:8118}, Exaltado",
	-- {npc:14905} Falthir the Sightless · {quest:8143} Zandalarian Shadow Talisman
	["{npc:14905}: {quest:8143}, Exalted"] = "{npc:14905}: {quest:8143}, Exaltado",
	-- {npc:14905} Falthir the Sightless · {item:19620} Maelstrom's Tendril
	["{npc:14905}: {item:19620}, Exalted"] = "{npc:14905}: {item:19620}, Exaltado",
	-- {quest:8246} Signets of the Zandalar
	["{quest:8246}: 15 Honor Tokens"] = "{quest:8246}: 15 fichas de honor",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Friendly to Honored is 6,000: one and a half clears. Honored opens {item:19683}, {item:19686}, {item:19689}, {item:19691}, {item:19694} and {item:20004} (5g each), {item:20000} (12g), {item:20756} (4g) and {spell:471400} (4g), the Paragons of Power belts and mantles (150 each), {quest:8196} (one Honor Token) and The {item:22635}."] = "De Amistoso a Honorable son 6.000: una pasada y media. Honorable abre {item:19683}, {item:19686}, {item:19689}, {item:19691}, {item:19694} y {item:20004} (5g cada una), {item:20000} (12g), {item:20756} (4g) y {spell:471400} (4g), los cinturones y mantos de los Dechados de poder (150 cada uno), {quest:8196} (una ficha de honor) y la {item:22635}.",
}
