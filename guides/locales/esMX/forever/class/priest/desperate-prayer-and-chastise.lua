-- Spanish (Latin America) (esMX): the guide forever/class/priest/desperate-prayer-and-chastise (forever/class/priest/desperate-prayer-and-chastise.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:5634} Desperate Prayer · {quest:5641} Chastise
	["{quest:5634} and {quest:5641}"] = "{quest:5634} y {quest:5641}",
	-- {quest:5634} Desperate Prayer · {quest:5641} Chastise
	["The Dwarf priest spells: {quest:5634} at 10, {quest:5641} (new in Forever) at 20. Free, no objectives."] = "Los hechizos de sacerdote enano: {quest:5634} a nivel 10, {quest:5641} (nuevo en Forever) a nivel 20. Gratis, sin objetivos.",

	-- Step 1: Desperate Prayer: Maxan Anvol
	-- {npc:1226} Maxan Anvol · {area:2102} Thunderbrew Distillery · {area:131} Kharanos · {quest:5634} Desperate Prayer · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["At 10, {npc:1226}, the priest trainer inside the {area:2102} in {area:131}, hands you a {quest:5634} letter for {npc:11406}. {area:131} is on the road up to {zone:1455}."] = "A nivel 10, {npc:1226}, el instructor de sacerdotes dentro de {area:2102} en {area:131}, te da una carta de {quest:5634} para {npc:11406}. {area:131} está en el camino de subida a {zone:1455}.",
	-- {npc:1226} Maxan Anvol · {quest:5634} Desperate Prayer
	["{npc:1226}: take his {quest:5634} letter"] = "{npc:1226}: toma su carta de {quest:5634}",

	-- Step 2: Desperate Prayer: Priestess Josetta
	-- {zone:1429} Elwynn Forest · {npc:377} Priestess Josetta · {area:87} Goldshire · {quest:5634} Desperate Prayer · {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {area:2257} Deeprun Tram · {zone:1453} Stormwind · {object:28027} Dwarven District
	["At 10 in {zone:1429}, {npc:377}, upstairs in the Lion's Pride Inn in {area:87}, hands you a {quest:5634} letter for {npc:11406} in {zone:1455} (the {area:2257} from {zone:1453}'s {object:28027})."] = "A nivel 10 en {zone:1429}, {npc:377}, en el piso de arriba de la Posada Orgullo de León en {area:87}, te da una carta de {quest:5634} para {npc:11406} en {zone:1455} ({area:2257} desde {object:28027} de {zone:1453}).",
	-- {npc:377} Priestess Josetta · {quest:5634} Desperate Prayer
	["{npc:377}: take her {quest:5634} letter"] = "{npc:377}: toma su carta de {quest:5634}",

	-- Step 3: Desperate Prayer: Nara Meideros
	-- {zone:1453} Stormwind · {npc:11397} Nara Meideros · {quest:5634} Desperate Prayer · {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {npc:376} High Priestess Laurena
	["At 10 in {zone:1453}, {npc:11397}, the priest trainer in the Park (the night elf quarter on the city's west side), hands you a {quest:5634} letter for {npc:11406} in {zone:1455}. {npc:376} in the Cathedral has none for Dwarves."] = "A nivel 10 en {zone:1453}, {npc:11397}, la instructora de sacerdotes en el Parque (el barrio elfo de la noche, en el lado oeste de la ciudad), te da una carta de {quest:5634} para {npc:11406} en {zone:1455}. {npc:376}, en la Catedral, no tiene para enanos.",
	-- {npc:11397} Nara Meideros · {quest:5634} Desperate Prayer
	["{npc:11397}: take her {quest:5634} letter"] = "{npc:11397}: toma su carta de {quest:5634}",

	-- Step 4: Desperate Prayer: Laurna Morninglight
	-- {zone:1438} Teldrassil · {npc:3600} Laurna Morninglight · {area:186} Dolanaar · {quest:5634} Desperate Prayer · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["At 10 in {zone:1438}, {npc:3600}, in the building at the north edge of {area:186}, hands you a {quest:5634} letter for {npc:11406} in {zone:1455}."] = "A nivel 10 en {zone:1438}, {npc:3600}, en el edificio del borde norte de {area:186}, te da una carta de {quest:5634} para {npc:11406} en {zone:1455}.",
	-- {npc:3600} Laurna Morninglight · {quest:5634} Desperate Prayer
	["{npc:3600}: take her {quest:5634} letter"] = "{npc:3600}: toma su carta de {quest:5634}",

	-- Step 5: Desperate Prayer: Priestess Alathea
	-- {zone:1457} Darnassus · {npc:11401} Priestess Alathea · {npc:7999} Tyrande Whisperwind · {quest:5634} Desperate Prayer · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["At 10 in {zone:1457}, {npc:11401}, on the upper balcony of the Temple of the Moon beside {npc:7999}, hands you a {quest:5634} letter for {npc:11406} in {zone:1455}."] = "A nivel 10 en {zone:1457}, {npc:11401}, en el balcón superior del Templo de la Luna junto a {npc:7999}, te da una carta de {quest:5634} para {npc:11406} en {zone:1455}.",
	-- {npc:11401} Priestess Alathea · {quest:5634} Desperate Prayer
	["{npc:11401}: take her {quest:5634} letter"] = "{npc:11401}: toma su carta de {quest:5634}",

	-- Step 6: Desperate Prayer: High Priest Rohan
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {quest:5634} Desperate Prayer
	["At 10, go to {npc:11406} in the {object:32386}, in {zone:1455}'s {object:32362} (north-west of the city): he gives {quest:5634} and takes it back at once. No letter needed. {quest:5634} heals you instantly, costs no mana and has a long cooldown: keep it for emergencies."] = "A nivel 10, ve con {npc:11406} en {object:32386}, en {object:32362} de {zone:1455} (al noroeste de la ciudad): te da {quest:5634} y la recibe enseguida. No hace falta carta. {quest:5634} te cura al instante, no cuesta maná y tiene una reutilización larga: guárdala para emergencias.",

	-- Step 7: Desperate Prayer: Maxan Anvol's letter
	-- {quest:5637} Desperate Prayer · {npc:1226} Maxan Anvol
	["{quest:5637}: {npc:1226}'s letter"] = "{quest:5637}: la carta de {npc:1226}",
	-- {area:131} Kharanos · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {quest:5637} Desperate Prayer · {zone:1453} Stormwind
	["Follow the road up from {area:131} into {zone:1455} and west to the {object:32362}: {npc:11406} in the {object:32386} takes the letter and teaches {quest:5637}. The letter tells you to head to {zone:1453}, but the one who wants you is Rohan in {zone:1455}."] = "Sigue el camino de subida desde {area:131} hasta {zone:1455} y al oeste hasta {object:32362}: {npc:11406} en {object:32386} recibe la carta y enseña {quest:5637}. La carta te dice que vayas a {zone:1453}, pero quien te busca es Rohan en {zone:1455}.",

	-- Step 8: Desperate Prayer: Josetta's letter
	-- {quest:5635} Desperate Prayer
	["{quest:5635}: Josetta's letter"] = "{quest:5635}: la carta de Josetta",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {area:2257} Deeprun Tram · {zone:1453} Stormwind · {object:28027} Dwarven District
	["Hand the letter to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}: the {area:2257} from {zone:1453}'s {object:28027}."] = "Entrégale la carta a {npc:11406} en {object:32386}, {object:32362} de {zone:1455}: {area:2257} desde {object:28027} de {zone:1453}.",

	-- Step 9: Desperate Prayer: Nara's letter
	-- {quest:5638} Desperate Prayer
	["{quest:5638}: Nara's letter"] = "{quest:5638}: la carta de Nara",

	-- Step 10: Desperate Prayer: Laurna Morninglight's letter
	-- {quest:5636} Desperate Prayer · {npc:3600} Laurna Morninglight
	["{quest:5636}: {npc:3600}'s letter"] = "{quest:5636}: la carta de {npc:3600}",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {zone:1438} Teldrassil · {area:702} Rut'theran Village · {area:442} Auberdine · {area:150} Menethil Harbor · {zone:1437} Wetlands · {zone:1432} Loch Modan · {area:17203} Stormwind Harbor · {area:2257} Deeprun Tram
	["Hand the letter to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}: from {zone:1438}, the boat from {area:702} to {area:442}, the boat to {area:150} and the road north through the {zone:1437} and {zone:1432} (or the boat to {area:17203} and the {area:2257})."] = "Entrégale la carta a {npc:11406} en {object:32386}, {object:32362} de {zone:1455}: desde {zone:1438}, el barco de {area:702} a {area:442}, el barco a {area:150} y el camino al norte por {zone:1437} y {zone:1432} (o el barco a {area:17203} y {area:2257}).",

	-- Step 11: Desperate Prayer: Alathea's letter
	-- {quest:5640} Desperate Prayer
	["{quest:5640}: Alathea's letter"] = "{quest:5640}: la carta de Alathea",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {zone:1453} Stormwind · {zone:1457} Darnassus · {area:702} Rut'theran Village · {area:442} Auberdine · {area:150} Menethil Harbor · {area:17203} Stormwind Harbor · {area:2257} Deeprun Tram
	["Hand the letter to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}: its text says {zone:1453}, but Rohan is in {zone:1455}. From {zone:1457}, the portal down to {area:702}, the boat to {area:442}, then {area:150} and the road north (or {area:17203} and the {area:2257})."] = "Entrégale la carta a {npc:11406} en {object:32386}, {object:32362} de {zone:1455}: su texto dice {zone:1453}, pero Rohan está en {zone:1455}. Desde {zone:1457}, el portal de bajada a {area:702}, el barco a {area:442}, luego {area:150} y el camino al norte (o {area:17203} y {area:2257}).",

	-- Step 12: Desperate Prayer: an old letter
	-- {quest:5634} Desperate Prayer
	["{quest:5634}: an old letter"] = "{quest:5634}: una carta vieja",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words)
	["This letter also goes to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}."] = "Esta carta también va para {npc:11406} en {object:32386}, {object:32362} de {zone:1455}.",

	-- Step 13: Chastise: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena · {quest:5641} Chastise · {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {area:2257} Deeprun Tram · {object:28027} Dwarven District
	["At 20 in {zone:1453}, {npc:376} at the altar of the Cathedral of Light hands you a {quest:5641} letter for {npc:11406} in {zone:1455} (the {area:2257} from the {object:28027})."] = "A nivel 20 en {zone:1453}, {npc:376}, en el altar de la Catedral de la Luz, te da una carta de {quest:5641} para {npc:11406} en {zone:1455} ({area:2257} desde {object:28027}).",
	-- {npc:376} High Priestess Laurena · {quest:5641} Chastise
	["{npc:376}: take her {quest:5641} letter"] = "{npc:376}: toma su carta de {quest:5641}",

	-- Step 14: Chastise: Priestess Alathea
	-- {zone:1457} Darnassus · {npc:11401} Priestess Alathea · {npc:7999} Tyrande Whisperwind · {quest:5641} Chastise · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["At 20 in {zone:1457}, {npc:11401}, on the upper balcony of the Temple of the Moon beside {npc:7999}, hands you a {quest:5641} letter for {npc:11406} in {zone:1455}."] = "A nivel 20 en {zone:1457}, {npc:11401}, en el balcón superior del Templo de la Luna junto a {npc:7999}, te da una carta de {quest:5641} para {npc:11406} en {zone:1455}.",
	-- {npc:11401} Priestess Alathea · {quest:5641} Chastise
	["{npc:11401}: take her {quest:5641} letter"] = "{npc:11401}: toma su carta de {quest:5641}",

	-- Step 15: Chastise: High Priest Rohan
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {quest:5641} Chastise · {spell:6346} Fear Ward
	["At 20, {npc:11406} in the {object:32386} teaches {quest:5641} with a quest he gives and takes back at once. Forever renamed it from A Lack of Fear: {quest:5641} damages a humanoid and roots it for 2 seconds (instant, 2-minute cooldown), and every priest now trains {spell:6346}."] = "A nivel 20, {npc:11406} en {object:32386} enseña {quest:5641} con una misión que te da y recibe enseguida. Forever le cambió el nombre, antes Falta de miedo: {quest:5641} daña a un humanoide y lo enraíza 2 segundos (instantáneo, 2 minutos de reutilización), y ahora todos los sacerdotes entrenan {spell:6346}.",

	-- Step 16: Chastise: Laurena's letter
	-- {quest:5645} Chastise
	["{quest:5645}: Laurena's letter"] = "{quest:5645}: la carta de Laurena",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {quest:5645} Chastise
	["Hand Laurena's letter to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}: he teaches {quest:5645}."] = "Entrégale la carta de Laurena a {npc:11406} en {object:32386}, {object:32362} de {zone:1455}: enseña {quest:5645}.",

	-- Step 17: Chastise: Alathea's letter
	-- {quest:5647} Chastise
	["{quest:5647}: Alathea's letter"] = "{quest:5647}: la carta de Alathea",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {zone:1457} Darnassus · {area:702} Rut'theran Village · {area:442} Auberdine · {area:150} Menethil Harbor · {zone:1437} Wetlands · {zone:1432} Loch Modan · {area:17203} Stormwind Harbor · {area:2257} Deeprun Tram
	["Hand Alathea's letter to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}: from {zone:1457}, the boats via {area:702} and {area:442} to {area:150}, then the road north through the {zone:1437} and {zone:1432} (or the boat to {area:17203} and the {area:2257})."] = "Entrégale la carta de Alathea a {npc:11406} en {object:32386}, {object:32362} de {zone:1455}: desde {zone:1457}, los barcos vía {area:702} y {area:442} hasta {area:150}, luego el camino al norte por {zone:1437} y {zone:1432} (o el barco a {area:17203} y {area:2257}).",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10, go to {npc:11406} in the {object:32386}, in {zone:1455}'s {object:32362}. Forever's quest text names Rohan, but the quest data has {npc:376} in {zone:1453}'s Cathedral of Light take it: try Rohan first, then Laurena (the {area:2257} links the cities)."] = "A nivel 10, ve con {npc:11406} en {object:32386}, en {object:32362} de {zone:1455}. El texto de la misión de Forever nombra a Rohan, pero según los datos de la misión la recibe {npc:376}, en la Catedral de la Luz de {zone:1453}: prueba primero con Rohan y luego con Laurena (el {area:2257} une las ciudades).",
	-- ["At 20, {npc:11406} teaches {quest:5641}. {npc:376} in {zone:1453} and {npc:11401} in {zone:1457} send you to him with a quest of the same name."] = "A nivel 20, {npc:11406} enseña {quest:5641}. {npc:376} en {zone:1453} y {npc:11401} en {zone:1457} te envían con él mediante una misión del mismo nombre.",
	-- ["If Rohan did not take it: {npc:376} is in the Cathedral of Light. Take the {area:2257} from {object:171524}."] = "Si Rohan no la aceptó: {npc:376} está en la Catedral de la Luz. Toma el {area:2257} desde {object:171524}.",
	-- ["The Human and Dwarf priest spells: {quest:5634} at 10, {quest:5641} for Dwarves at 20."] = "Los hechizos de sacerdote humano y enano: {quest:5634} a nivel 10, {quest:5641} para enanos a nivel 20.",
}
