-- Spanish (Latin America) (esMX): the guide forever/class/paladin/tome-of-divinity (forever/class/paladin/tome-of-divinity.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:7328} Redemption
	["{spell:7328} (Alliance)"] = "{spell:7328} (Alianza)",
	-- {spell:7328} Redemption
	["{spell:7328} at 12, the paladin's resurrection: an easy chain through your capital and its home zone."] = "{spell:7328} a nivel 12, la resurrección del paladín: una cadena fácil por tu capital y su zona de origen.",

	-- Step 1: The summons (Human)
	["The summons (Human)"] = "La convocatoria (humanos)",
	-- {npc:927} Brother Wilhelm · {area:87} Goldshire · {npc:6171} Duthorian Rall · {zone:1453} Stormwind · {npc:5149} Brandur Ironhammer · {zone:1455} Ironforge
	["At 12 {npc:927}, the paladin trainer in {area:87}, sends you to {npc:6171} in {zone:1453}'s Cathedral of Light. The errand is optional, a little XP: {npc:5149} in {zone:1455} gives the same one (taking one closes the other), and {npc:6171} starts the chain without it."] = "A nivel 12, {npc:927}, el instructor de paladines en {area:87}, te manda con {npc:6171} en la Catedral de la Luz de {zone:1453}. El encargo es opcional, algo de experiencia: {npc:5149} en {zone:1455} da el mismo (tomar uno cierra el otro), y {npc:6171} empieza la cadena sin él.",

	-- Step 2: The summons (Dwarf)
	["The summons (Dwarf)"] = "La convocatoria (enanos)",
	-- {npc:5149} Brandur Ironhammer · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {npc:6179} Tiza Battleforge · {npc:1232} Azar Stronghammer · {area:131} Kharanos · {npc:928} Lord Grayson Shadowbreaker · {zone:1453} Stormwind
	["At 12 {npc:5149}, the paladin trainer in {zone:1455}'s {object:32362}, sends you upstairs to {npc:6179}. The errand is optional, a little XP: {npc:1232} in {area:131} and {npc:928} in {zone:1453} give the same one (taking one closes the others), and {npc:6179} starts the chain without it."] = "A nivel 12, {npc:5149}, el instructor de paladines en {object:32362} de {zone:1455}, te manda arriba con {npc:6179}. El encargo es opcional, algo de experiencia: {npc:1232} en {area:131} y {npc:928} en {zone:1453} dan el mismo (tomar uno cierra los otros), y {npc:6179} empieza la cadena sin él.",

	-- Step 3: Duthorian Rall
	-- {npc:6171} Duthorian Rall
	["{npc:6171}, Cathedral of Light"] = "{npc:6171}, Catedral de la Luz",

	-- Step 5: The Tome of Divinity
	-- {npc:6171} Duthorian Rall · {quest:2998} Tome of Divinity · {item:2589} Linen Cloth
	["{npc:6171} stands inside the Cathedral of Light. He hands you the {quest:2998}: right-click it in your bags to start the next quest. If the book says the quest is already done, destroy it and ask {npc:6171} for a new copy. Bring 10 {item:2589} for the next step if you have it."] = "{npc:6171} está dentro de la Catedral de la Luz. Te da {quest:2998}: haz clic derecho en él en tus bolsas para empezar la siguiente misión. Si el libro dice que la misión ya está hecha, destrúyelo y pídele a {npc:6171} una copia nueva. Si tienes, lleva 10 {item:2589} para el siguiente paso.",
	-- {quest:2998} Tome of Divinity
	["Right-click the {quest:2998}"] = "Haz clic derecho en {quest:2998}",

	-- Step 6: Stephanie Turner
	-- {npc:6174} Stephanie Turner · {object:2096} Trade District · {item:2589} Linen Cloth · {zone:1436} Westfall
	["{npc:6174} stands at a corner in the middle of the {object:2096}, outside a general goods store. She wants 10 {item:2589}: humanoids drop it (Riverpaw gnolls in {zone:1436} about every other kill, Defias and kobolds a little less), or buy it at the Auction House a few steps away in the {object:2096}."] = "{npc:6174} está en una esquina en el centro de {object:2096}, afuera de una tienda de mercancías. Quiere 10 {item:2589}: los humanoides la sueltan (los gnolls Zarpa del Río en {zone:1436} más o menos en una de cada dos muertes, los Defias y kóbolds un poco menos), o cómprala en la casa de subastas, a pocos pasos en {object:2096}.",
	-- {item:2589} Linen Cloth
	["{item:2589} x10: humanoids, or the Auction House"] = "{item:2589} x10: humanoides, o la casa de subastas",

	-- Step 7: The Symbol of Life
	-- {item:6866} Symbol of Life
	["The {item:6866}"] = "{item:6866}",
	-- {npc:6171} Duthorian Rall · {item:6866} Symbol of Life · {npc:6173} Gazin Tenorm · {npc:6172} Henze Faulk
	["Back to the Cathedral. {npc:6171} gives you the {item:6866}; {npc:6173} lies wounded by the altar of the same hall. Keep the symbol: you need it on {npc:6172}. If you lose it, {npc:6171} gives you another (The {item:6866})."] = "De vuelta a la Catedral. {npc:6171} te da {item:6866}; {npc:6173} está herido junto al altar de la misma sala. Guarda el símbolo: lo necesitas sobre {npc:6172}. Si lo pierdes, {npc:6171} te da otro ({item:6866}).",

	-- Step 8: Henze Faulk
	-- {npc:6172} Henze Faulk · {area:56} Heroes' Vigil · {area:86} Stone Cairn Lake · {item:6866} Symbol of Life · {spell:116} Frostbolt
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["{npc:6172} lies dead on {area:56}, the island in {area:86} in eastern Elwynn, on top of one of the mounds around the stone circle. Target his body and use the {item:6866} to raise him, then speak to him. If another paladin just raised him, his body is back within about three minutes. The Defias Rogue Wizards on the island (level 9-10) cast {spell:116} from far off: they stand apart, so pull one at a time."] = "{npc:6172} yace muerto en {area:56}, la isla de {area:86}, en el este de Elwynn, encima de uno de los montículos alrededor del círculo de piedras. Selecciona su cuerpo y usa {item:6866} para revivirlo, luego háblale. Si otro paladín acaba de revivirlo, su cuerpo vuelve en unos tres minutos. Los magos rebeldes Defias de la isla (nivel 9-10) lanzan {spell:116} desde lejos: están separados, así que atráelos de a uno.",
	-- {item:6866} Symbol of Life · {npc:6172} Henze Faulk
	["{item:6866} on {npc:6172}'s body"] = "{item:6866} sobre el cuerpo de {npc:6172}",

	-- Step 9: The Defias Script
	-- {item:6846} Defias Script
	["The {item:6846}"] = "{item:6846}",
	-- {npc:6172} Henze Faulk · {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["The Defias Rogue Wizards around the big stone tablet east of {npc:6172} carry the {item:6846}: about one kill in two drops it, but some players need many kills. They respawn in three minutes."] = "Los magos rebeldes Defias alrededor de la gran tablilla de piedra al este de {npc:6172} llevan {item:6846}: más o menos una de cada dos muertes lo suelta, pero algunos jugadores necesitan muchas muertes. Reaparecen en tres minutos.",
	-- {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["{item:6846}: Defias Rogue Wizards"] = "{item:6846}: Zahoríes bribones de Defias",

	-- Step 10: Redemption
	-- {npc:6173} Gazin Tenorm · {npc:6171} Duthorian Rall · {spell:7328} Redemption
	["Back to the Cathedral of Light: {npc:6173} takes the script, {npc:6171} teaches you {spell:7328}."] = "De vuelta a la Catedral de la Luz: {npc:6173} recibe el escrito y {npc:6171} te enseña {spell:7328}.",

	-- Step 11: Tiza Battleforge
	-- {npc:6179} Tiza Battleforge · {object:32386} Hall of Mysteries (no name in this language: may be words)
	["{npc:6179}, upstairs in the {object:32386}"] = "{npc:6179}, en el piso de arriba de {object:32386}",

	-- Step 14: The Tome of Divinity
	-- {npc:6179} Tiza Battleforge · {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward (no name in this language: may be words) · {quest:2997} Tome of Divinity · {item:2589} Linen Cloth
	["{npc:6179} stands upstairs in the {object:32386}, in the {object:32362}: take the ramp at the back of the hall. She hands you the {quest:2997}: right-click it in your bags to start the next quest. If the book says the quest is already done, destroy it and ask {npc:6179} for a new copy. Bring 10 {item:2589} for the next step if you have it."] = "{npc:6179} está en el piso de arriba de {object:32386}, en {object:32362}: toma la rampa al fondo de la sala. Te da {quest:2997}: haz clic derecho en él en tus bolsas para empezar la siguiente misión. Si el libro dice que la misión ya está hecha, destrúyelo y pídele a {npc:6179} una copia nueva. Si tienes, lleva 10 {item:2589} para el siguiente paso.",
	-- {quest:2997} Tome of Divinity
	["Right-click the {quest:2997}"] = "Haz clic derecho en {quest:2997}",

	-- Step 15: John Turner
	-- {npc:6175} John Turner · {item:2589} Linen Cloth · {zone:1432} Loch Modan
	-- plural, as words: Dark Iron Ambushers = {npc:1981} Dark Iron Ambusher
	["{npc:6175} walks the outer ring of the Commons, past the front gate, the bank and the Auction House. He wants 10 {item:2589}: humanoids drop it (in {zone:1432} the Dark Iron Ambushers, Tunnel Rat kobolds and Stonesplinter troggs about two kills in five), or buy it at the Auction House on his ring."] = "{npc:6175} recorre el anillo exterior de la Explanada, pasando la puerta principal, el banco y la casa de subastas. Quiere 10 {item:2589}: los humanoides la sueltan (en {zone:1432}, los emboscadores Hierro Negro, los kóbolds Rata del Túnel y los troggs Rompecantos más o menos dos de cada cinco veces), o cómprala en la casa de subastas de su anillo.",

	-- Step 16: The Symbol of Life
	-- {object:32386} Hall of Mysteries (no name in this language: may be words) · {npc:6179} Tiza Battleforge · {item:6866} Symbol of Life · {npc:6178} Muiredon Battleforge · {npc:6177} Narm Faulk
	["Back upstairs in the {object:32386}. {npc:6179} gives you the {item:6866}; her husband {npc:6178} rests on the same floor. Keep the symbol: you need it on {npc:6177}. If you lose it, {npc:6179} gives you another (The {item:6866})."] = "De vuelta arriba en {object:32386}. {npc:6179} te da {item:6866}; su esposo {npc:6178} descansa en el mismo piso. Guarda el símbolo: lo necesitas sobre {npc:6177}. Si lo pierdes, {npc:6179} te da otro ({item:6866}).",

	-- Step 17: Narm Faulk
	-- {npc:6177} Narm Faulk · {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {area:131} Kharanos · {area:212} Helm's Bed Lake · {object:147516} Dark Iron (no name in this language: may be words) · {item:6866} Symbol of Life
	["{npc:6177} lies dead in {zone:1426}, not {zone:1432}: east past {area:131}, north-east of Ironband's compound, on the smallest of three little hills between {area:212} and the {object:147516} camp. Target his body and use the {item:6866} to raise him, then speak to him. If another paladin just raised him, his body is back within about three minutes."] = "{npc:6177} yace muerto en {zone:1426}, no en {zone:1432}: al este pasando {area:131}, al noreste del recinto de Ironband, en la más pequeña de tres colinitas entre {area:212} y el campamento de {object:147516}. Selecciona su cuerpo y usa {item:6866} para revivirlo, luego háblale. Si otro paladín acaba de revivirlo, su cuerpo vuelve en unos tres minutos.",
	-- {item:6866} Symbol of Life · {npc:6177} Narm Faulk
	["{item:6866} on {npc:6177}'s body"] = "{item:6866} sobre el cuerpo de {npc:6177}",

	-- Step 18: The Dark Iron Script
	-- {item:6847} Dark Iron Script
	["The {item:6847}"] = "{item:6847}",
	-- {item:6847} Dark Iron Script
	["The Dark Iron Spies (level 9-11, twelve of them) sneak around the little house below the lake, just south of Narm; you see them from his hill. About one kill in two drops the {item:6847}. They run for help at low health: finish them or step back. They respawn in three minutes."] = "Los espías Hierro Negro (nivel 9-11, son doce) merodean alrededor de la casita debajo del lago, justo al sur de Narm; los ves desde su colina. Más o menos una de cada dos muertes suelta {item:6847}. Huyen a pedir ayuda con poca salud: remátalos o retrocede. Reaparecen en tres minutos.",
	-- {item:6847} Dark Iron Script
	["{item:6847}: Dark Iron Spies"] = "{item:6847}: Espías Hierro Negro",

	-- Step 19: Redemption
	-- {object:32386} Hall of Mysteries (no name in this language: may be words) · {npc:6178} Muiredon Battleforge · {npc:6179} Tiza Battleforge · {spell:7328} Redemption
	["Back up to the {object:32386}: {npc:6178} takes the script, {npc:6179} teaches you {spell:7328}."] = "De vuelta arriba en {object:32386}: {npc:6178} recibe el escrito y {npc:6179} te enseña {spell:7328}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{item:2589} x10"] = "{item:2589} x10",
}
