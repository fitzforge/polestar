-- Spanish (Spain) (esES): the guide forever/professions/fishing (forever/professions/fishing.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Fishing
	-- {skill:356} Fishing
	["Learn {skill:356}"] = "Aprende {skill:356}",
	["No character level needed."] = "",

	-- Step 2: Buy a Fishing Pole
	-- {item:6256} Fishing Pole
	["Buy a {item:6256}"] = "",
	["Equipped like a weapon while you fish."] = "",

	-- Step 3: Buy 2 Shiny Baubles
	-- plural, as words: Shiny Baubles = {item:6529} Shiny Bauble
	["Buy 2 Shiny Baubles"] = "",
	-- {skill:356} Fishing
	["A lure: +25 {skill:356} for ten minutes, so fewer fish get away."] = "",

	-- Step 4: Equip the Fishing Pole
	-- {item:6256} Fishing Pole
	["Equip the {item:6256}"] = "",
	-- {skill:356} Fishing
	["{skill:356} needs the pole in your hands; your weapon goes back on after."] = "",

	-- Step 5: Put a Shiny Bauble on the pole
	-- {item:6529} Shiny Bauble
	["Put a {item:6529} on the pole"] = "",
	["It lasts ten minutes."] = "",

	-- Step 6: Fish near your starting area until 75 · Fishing: Professions tab (K by default)
	-- {skill:356} Fishing
	["Fish near your starting area until 75 · {skill:356}: Professions tab (K by default)"] = "",
	["Every catch gives a point."] = "",
	["Cast, then right-click the bobber when it splashes."] = "",

	-- Step 8: Reach level 10
	["Reach level 10"] = "",
	-- {skill:356} Fishing
	["Journeyman {skill:356} needs level 10."] = "",

	-- Step 9: Train Journeyman Fishing
	-- {skill:356} Fishing
	["Train Journeyman {skill:356}"] = "",
	-- {skill:356} Fishing
	["Needs {skill:356} skill 50 and level 10."] = "",

	-- Step 10: Fish in a capital or a nearby lake until 150 · Fishing: Professions tab (K by default)
	-- {skill:356} Fishing
	["Fish in a capital or a nearby lake until 150 · {skill:356}: Professions tab (K by default)"] = "",
	-- {item:6530} Nightcrawlers
	["{item:6530} on the pole help when fish keep getting away."] = "",

	-- Step 11: Reach level 20
	["Reach level 20"] = "",
	-- {skill:356} Fishing
	["Expert {skill:356} needs level 20."] = "",

	-- Step 12: Buy Expert Fishing - The Bass and You · Old Man Heming, Booty Bay
	-- {item:16083} Expert Fishing - The Bass and You · {npc:2626} Old Man Heming · {area:35} Booty Bay
	["Buy {item:16083} · {npc:2626}, {area:35}"] = "",
	["Sold there only, or at the Auction House."] = "",

	-- Step 13: Read Expert Fishing - The Bass and You
	-- {item:16083} Expert Fishing - The Bass and You
	-- was: ["Buy and read {item:16083} (Expert {skill:356})"] = "Compra y lee {item:16083} ({skill:356} de experto)"
	["Read {item:16083}"] = "",
	-- {skill:356} Fishing
	["It teaches Expert {skill:356}: needs {skill:356} skill 125 and level 20."] = "",

	-- Step 14: Buy 11 Bright Baubles
	-- {item:6532} Bright Baubles
	["Buy 11 {item:6532}"] = "",
	["For the water that loses fish below 225: ten minutes each, about 11 to 225."] = "",

	-- Step 15: Fish in the mid-level waters until 225 · Fishing: Professions tab (K by default)
	-- {skill:356} Fishing
	["Fish in the mid-level waters until 225 · {skill:356}: Professions tab (K by default)"] = "",
	-- {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh
	["{npc:12919}, who teaches Artisan, fishes in {zone:1445}."] = "",

	-- Step 16: Reach level 35
	["Reach level 35"] = "",
	-- {npc:12919} Nat Pagle
	["{npc:12919}'s quests need level 35."] = "",

	-- Step 17: Accept I Got Nothin' Left! · Grimnur Stonebrand, Ironforge
	-- {quest:6609} I Got Nothin' Left! · {npc:5161} Grimnur Stonebrand · {zone:1455} Ironforge
	["Accept {quest:6609} · {npc:5161}, {zone:1455}"] = "",
	-- {npc:12919} Nat Pagle
	["The fishing trainer sends you to {npc:12919}, who teaches Artisan."] = "",

	-- Step 18: Accept You Too Good. · Lumak, Orgrimmar
	-- {quest:6608} You Too Good. · {npc:3332} Lumak · {zone:1454} Orgrimmar
	["Accept {quest:6608} · {npc:3332}, {zone:1454}"] = "",

	-- Step 19: Hand in I Got Nothin' Left! · Nat Pagle, island off Dustwallow Marsh
	-- {quest:6609} I Got Nothin' Left! · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh
	["Hand in {quest:6609} · {npc:12919}, island off {zone:1445}"] = "",
	["His island lies off the east coast, south of Theramore."] = "",

	-- Step 20: Hand in You Too Good. · Nat Pagle, island off Dustwallow Marsh
	-- {quest:6608} You Too Good. · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh
	["Hand in {quest:6608} · {npc:12919}, island off {zone:1445}"] = "",

	-- Step 21: Accept Nat Pagle, Angler Extreme · Nat Pagle
	-- {quest:6607} Nat Pagle, Angler Extreme · {npc:12919} Nat Pagle
	["Accept {quest:6607} · {npc:12919}"] = "",
	["Four fish, each from its own water; about one catch in five brings it up there."] = "",

	-- Step 22: Catch a Sar'theris Striker · Desolace's northern coast, by the tower · Fishing: Professions tab (K by default)
	-- {item:16968} Sar'theris Striker · {zone:1443} Desolace · {skill:356} Fishing
	["Catch a {item:16968} · {zone:1443}'s northern coast, by the tower · {skill:356}: Professions tab (K by default)"] = "",
	["It bites nowhere else."] = "",

	-- Step 23: Catch a Sar'theris Striker · Desolace coast by Shadowprey Village · Fishing: Professions tab (K by default)
	-- {item:16968} Sar'theris Striker · {zone:1443} Desolace · {area:2408} Shadowprey Village · {skill:356} Fishing
	["Catch a {item:16968} · {zone:1443} coast by {area:2408} · {skill:356}: Professions tab (K by default)"] = "",

	-- Step 24: Buy 2 Bright Baubles
	-- {item:6532} Bright Baubles
	["Buy 2 {item:6532}"] = "",
	-- {zone:1444} Feralas
	["Fish get away in {zone:1444} below skill 300; a lure adds 75 for ten minutes."] = "",

	-- Step 25: Catch a Feralas Ahi · Verdantis River, west of the road bridge · Fishing: Professions tab (K by default)
	-- {item:16967} Feralas Ahi · {area:2521} Verdantis River · {skill:356} Fishing
	["Catch a {item:16967} · {area:2521}, west of the road bridge · {skill:356}: Professions tab (K by default)"] = "",

	-- Step 26: Catch a Savage Coast Blue Sailfin · Savage Coast, Stranglethorn Vale · Fishing: Professions tab (K by default)
	-- {item:16969} Savage Coast Blue Sailfin · {area:301} Savage Coast · {zone:1434} Stranglethorn Vale · {skill:356} Fishing
	["Catch a {item:16969} · {area:301}, {zone:1434} · {skill:356}: Professions tab (K by default)"] = "",
	-- {item:8364} Mithril Head Trout
	["Only {item:8364} and Catfish biting means another spot."] = "",

	-- Step 28: Catch a Misty Reed Mahi Mahi · Misty Reed Strand, Swamp of Sorrows · Fishing: Professions tab (K by default)
	-- {item:16970} Misty Reed Mahi Mahi · {area:300} Misty Reed Strand · {zone:1435} Swamp of Sorrows · {skill:356} Fishing
	["Catch a {item:16970} · {area:300}, {zone:1435} · {skill:356}: Professions tab (K by default)"] = "",
	["The small islands keep you clear of the murlocs."] = "",

	-- Step 29: Hand in Nat Pagle, Angler Extreme
	-- {quest:6607} Nat Pagle, Angler Extreme
	["Hand in {quest:6607}"] = "",

	-- Step 30: Train Artisan Fishing
	-- {skill:356} Fishing
	["Train Artisan {skill:356}"] = "",
	-- {npc:12919} Nat Pagle · {skill:356} Fishing
	["{npc:12919} teaches it once his quest is done: needs {skill:356} skill 225 and level 35."] = "",

	-- Step 31: Buy 16 Bright Baubles
	-- {item:6532} Bright Baubles
	["Buy 16 {item:6532}"] = "",
	["For the water that loses fish below 300: ten minutes each, about 16 to 300."] = "",

	-- Step 32: Fish in the high-level waters until 300 · Fishing: Professions tab (K by default)
	-- {skill:356} Fishing
	["Fish in the high-level waters until 300 · {skill:356}: Professions tab (K by default)"] = "",
	["Fish get away here without a lure."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} (character level 5); the arrow picks the nearest. Buy a {item:6256} from a trade goods or fishing vendor and equip it."] = "Cualquier instructor de {skill:356} de tu facción enseña {skill:356} de aprendiz (nivel de personaje 5); la flecha elige el más cercano. Compra una {item:6256} a un proveedor de mercancías o de pesca y equípala.",
	-- ["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} at any character level (1s); the arrow picks the nearest, and every starting area has one on its lake or shore. Buy a {item:6256} (23c) from a trade goods or fishing vendor and equip it (you can only fish with a pole in your hands), and two or three Shiny Baubles (+25, 50c each): a lure adds its bonus to your skill for ten minutes, so fewer fish get away at the start. If you sat at your starting area's campfire for The Great Outdoors, the camping guide there also offers Camping 101: {skill:356}, handed in to the fishing trainer it names at skill 20 for the {spell:1229745} recipe."] = "Cualquier instructor de {skill:356} de tu facción enseña {skill:356} de aprendiz a cualquier nivel de personaje (1s); la flecha elige el más cercano, y cada zona inicial tiene uno en su lago u orilla. Compra una {item:6256} (23c) a un mercader de objetos comerciables o de pesca y equípala (solo puedes pescar con una caña en las manos), y dos o tres Adornos lustrosos (+25, 50c cada uno): un cebo suma su bonificación a tu habilidad durante diez minutos, así que al principio se escapan menos peces. Si te sentaste junto a la hoguera de tu zona inicial para «El gran mundo exterior», el guía de acampada de allí también ofrece «Acampada para novatos: {skill:356}», que se entrega al instructor de pesca que indica, con habilidad 20, a cambio de la receta de {spell:1229745}.",
	-- ["Artisan {skill:356}"] = "{skill:356} de artesano",
	-- ["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1454} sends you to him; the quest needs skill 225 and level 35."] = "{skill:356} de artesano (límite 300) se consigue con {npc:12919} en {zone:1445}. El instructor de pesca de {zone:1454} te envía con él; la misión requiere 225 de habilidad y nivel 35.",
	-- ["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1455} sends you to him; the quest needs skill 225 and level 35."] = "{skill:356} de artesano (límite 300) se consigue con {npc:12919} en {zone:1445}. El instructor de pesca de {zone:1455} te envía con él; la misión requiere 225 de habilidad y nivel 35.",
	-- ["Buy and read {item:16083} (Expert {skill:356})"] = "Compra y lee {item:16083} ({skill:356} de experto)",
	-- ["Expert {skill:356}"] = "{skill:356} de experto",
	-- ["Expert {skill:356} (cap 225) is a book, not a trainer rank: {npc:2626} sells {item:16083} (1g) on the lowest dock of {area:35}, at the south tip of {zone:1434}, to both factions. Buy it and read it; it needs skill 125 and level 20. At level 20 the safe way in is the boat from {area:392} in {zone:1413}, not the road through Stranglethorn. He also sells {item:6532} (+75 from skill 100, 2s 50c each), the lure for the rest of the way."] = "{skill:356} de experto (límite 225) es un libro, no un rango de instructor: {npc:2626} vende {item:16083} (1 o) en el muelle más bajo de {area:35}, en la punta sur de {zone:1434}, a ambas facciones. Cómpralo y léelo; requiere 125 de habilidad y nivel 20. A nivel 20, la forma segura de llegar es el barco desde {area:392} en {zone:1413}, no el camino por Tuercespina. También vende {item:6532} (+75 a partir de habilidad 100, 2 p 50 c cada uno), el cebo para el resto del camino.",
	-- ["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:3550} ({zone:1420}) or {npc:4574} ({zone:1458})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:3550} ({zone:1420}))."] = "Pesca aquí hasta habilidad 50, unas 50 capturas: por debajo de 75, cada captura sube la habilidad. Lanza {skill:356} desde tu libro de hechizos y haz clic en el corcho cuando salpique. Guarda los peces: son tus primeros ingredientes de {skill:185}. Aquí los peces se escapan por debajo de habilidad 25; un cebo en la caña suma a tu habilidad durante diez minutos y cubre la diferencia. Para cocinar lo que pesques: {item:6325} para {item:6291} de lagos y ríos ({skill:185} 1, 40 c: {npc:3550} ({zone:1420}) o {npc:4574} ({zone:1458})); {item:6326} para {item:6303} de la costa ({skill:185} 1, 40 c: {npc:3550} ({zone:1420})).",
	-- ["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:5940} ({zone:1412}) or {npc:3029} ({zone:1456})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:5942} ({zone:1411}))."] = "Pesca aquí hasta habilidad 50, unas 50 capturas: por debajo de 75, cada captura sube la habilidad. Lanza {skill:356} desde tu libro de hechizos y haz clic en el corcho cuando salpique. Guarda los peces: son tus primeros ingredientes de {skill:185}. Aquí los peces se escapan por debajo de habilidad 25; un cebo en la caña suma a tu habilidad durante diez minutos y cubre la diferencia. Para cocinar lo que pesques: {item:6325} para {item:6291} de lagos y ríos ({skill:185} 1, 40 c: {npc:5940} ({zone:1412}) o {npc:3029} ({zone:1456})); {item:6326} para {item:6303} de la costa ({skill:185} 1, 40 c: {npc:5942} ({zone:1411})).",
	-- ["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:66} ({zone:1429}) or {npc:5494} ({zone:1453})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:4305} ({zone:1436}) or {npc:5162} ({zone:1455}))."] = "Pesca aquí hasta habilidad 50, unas 50 capturas: por debajo de 75, cada captura sube la habilidad. Lanza {skill:356} desde tu libro de hechizos y haz clic en el corcho cuando salpique. Guarda los peces: son tus primeros ingredientes de {skill:185}. Aquí los peces se escapan por debajo de habilidad 25; un cebo en la caña suma a tu habilidad durante diez minutos y cubre la diferencia. Para cocinar lo que pesques: {item:6325} para {item:6291} de lagos y ríos ({skill:185} 1, 40 c: {npc:66} ({zone:1429}) o {npc:5494} ({zone:1453})); {item:6326} para {item:6303} de la costa ({skill:185} 1, 40 c: {npc:4305} ({zone:1436}) o {npc:5162} ({zone:1455})).",
	-- ["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:8508} ({zone:1426}) or {npc:1684} ({zone:1432})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:5162} ({zone:1455}) or {npc:4305} ({zone:1436}))."] = "Pesca aquí hasta habilidad 50, unas 50 capturas: por debajo de 75, cada captura sube la habilidad. Lanza {skill:356} desde tu libro de hechizos y haz clic en el corcho cuando salpique. Guarda los peces: son tus primeros ingredientes de {skill:185}. Aquí los peces se escapan por debajo de habilidad 25; un cebo en la caña suma a tu habilidad durante diez minutos y cubre la diferencia. Para cocinar lo que pesques: {item:6325} para {item:6291} de lagos y ríos ({skill:185} 1, 40 c: {npc:8508} ({zone:1426}) o {npc:1684} ({zone:1432})); {item:6326} para {item:6303} de la costa ({skill:185} 1, 40 c: {npc:5162} ({zone:1455}) o {npc:4305} ({zone:1436})).",
	-- ["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:257006} ({zone:2521})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:257006} ({zone:2521}))."] = "Pesca aquí hasta habilidad 50, unas 50 capturas: por debajo de 75, cada captura sube la habilidad. Lanza {skill:356} desde tu libro de hechizos y haz clic en el corcho cuando salpique. Guarda los peces: son tus primeros ingredientes de {skill:185}. Para cocinar lo que pesques: {item:6325} para {item:6291} de lagos y ríos ({skill:185} 1, 40 c: {npc:257006} ({zone:2521})); {item:6326} para {item:6303} de la costa ({skill:185} 1, 40 c: {npc:257006} ({zone:2521})).",
	-- ["Fish here until skill 50. Click the bobber when it splashes; every catch can raise the skill."] = "Pesca aquí hasta 50 de habilidad. Haz clic en el corcho cuando salpique; cada captura puede subir la habilidad.",
	-- ["Fish in the {area:2521} in {zone:1444} until you catch a {item:16967}; it only bites there."] = "Pesca en {area:2521}, en {zone:1444}, hasta que captures un {item:16967}; solo pica allí.",
	-- ["Fish in the {area:300}, the south-east shore of {zone:1435} until you catch a {item:16970}; it only bites there."] = "Pesca en {area:300}, la orilla sureste de {zone:1435}, hasta que captures un {item:16970}; solo pica allí.",
	-- ["Fish in the {area:301}, the north-west shore of {zone:1434} until you catch a {item:16969}; it only bites there."] = "Pesca en {area:301}, la orilla noroeste de {zone:1434}, hasta que captures un {item:16969}; solo pica allí.",
	-- ["Fish in {area:598}, the north-west coast of {zone:1443} (Slitherblade naga shore) until you catch a {item:16968}; it only bites there."] = "Pesca en {area:598}, la costa noroeste de {zone:1443} (orilla de los nagas Filozante), hasta que captures un {item:16968}; solo pica allí.",
	-- ["Fish the pools along the coast here (eels, snappers, wreckage) until skill 300. {area:35} sells bait and {item:6530} for a small fishing bonus."] = "Pesca en los bancos a lo largo de la costa (anguilas, pargos, restos de naufragio) hasta 300 de habilidad. En {area:35} venden cebo y {item:6530} para una pequeña bonificación de pesca.",
	-- ["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6328} for the {item:6289} of lakes and rivers ({skill:185} 50, 4s: Nyoma ({zone:1438})); {item:6368} for the {item:6361} of the coast ({skill:185} 50, 4s: {npc:4307} ({zone:1439}) or {npc:10118} ({zone:1438})). {item:12238} bites only here: eat it as it is. {npc:10216} ({zone:1439}) takes 6 for The Family and the {item:6256}, which gives the {item:12221}. {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "Pesca en los bancos y en aguas abiertas hasta habilidad 125, unas 120 capturas: desde 75, las capturas suben la habilidad con menos frecuencia (una de cada dos hacia 100, una de cada tres hacia 125). Los bancos (restos flotantes, bancos de peces) también dan botín adicional. {item:6530} (+50 desde habilidad 50, 1 p cada uno) es el doble de fuerte que un {item:6529}. {item:6365} (+5 desde habilidad 10, 9 p 1 c) tiene existencias limitadas en los vendedores de pesca: cómprala cuando la veas. Aquí los peces se escapan por debajo de habilidad 75; un cebo en la caña suma a tu habilidad durante diez minutos y cubre la diferencia. Para cocinar lo que pesques: {item:6328} para {item:6289} de lagos y ríos ({skill:185} 50, 4 p: Nyoma ({zone:1438})); {item:6368} para {item:6361} de la costa ({skill:185} 50, 4 p: {npc:4307} ({zone:1439}) o {npc:10118} ({zone:1438})). {item:12238} solo pica aquí: cómelo tal cual. {npc:10216} ({zone:1439}) recoge 6 para The Family and the {item:6256}, que da la {item:12221}. {item:6358} de los bancos de aquí no es comida: los alquimistas hacen {item:6370} con él ({skill:171} 80); guárdalo para vender o comerciar.",
	-- ["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6328} for the {item:6289} of lakes and rivers ({skill:185} 50, 4s: {npc:5748} ({zone:1421}) or {npc:4574} ({zone:1458})); {item:6368} for the {item:6361} of the coast ({skill:185} 50, 4s: {npc:4553} ({zone:1458}) or {npc:5748} ({zone:1421})). {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "Pesca en los bancos y en aguas abiertas hasta habilidad 125, unas 120 capturas: desde 75, las capturas suben la habilidad con menos frecuencia (una de cada dos hacia 100, una de cada tres hacia 125). Los bancos (restos flotantes, bancos de peces) también dan botín adicional. {item:6530} (+50 desde habilidad 50, 1 p cada uno) es el doble de fuerte que un {item:6529}. {item:6365} (+5 desde habilidad 10, 9 p 1 c) tiene existencias limitadas en los vendedores de pesca: cómprala cuando la veas. Aquí los peces se escapan por debajo de habilidad 75; un cebo en la caña suma a tu habilidad durante diez minutos y cubre la diferencia. Para cocinar lo que pesques: {item:6328} para {item:6289} de lagos y ríos ({skill:185} 50, 4 p: {npc:5748} ({zone:1421}) o {npc:4574} ({zone:1458})); {item:6368} para {item:6361} de la costa ({skill:185} 50, 4 p: {npc:4553} ({zone:1458}) o {npc:5748} ({zone:1421})). {item:6358} de los bancos de aquí no es comida: los alquimistas hacen {item:6370} con él ({skill:171} 80); guárdalo para vender o comerciar.",
	-- ["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6328} for the {item:6289} of lakes and rivers ({skill:185} 50, 4s: {npc:5940} ({zone:1412}) or {npc:3027} ({zone:1456})); {item:6368} for the {item:6361} of the coast ({skill:185} 50, 4s: {npc:5942} ({zone:1411}) or {npc:3333} ({zone:1454})). {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "Pesca en los bancos y en aguas abiertas hasta habilidad 125, unas 120 capturas: desde 75, las capturas suben la habilidad con menos frecuencia (una de cada dos hacia 100, una de cada tres hacia 125). Los bancos (restos flotantes, bancos de peces) también dan botín adicional. {item:6530} (+50 desde habilidad 50, 1 p cada uno) es el doble de fuerte que un {item:6529}. {item:6365} (+5 desde habilidad 10, 9 p 1 c) tiene existencias limitadas en los vendedores de pesca: cómprala cuando la veas. Aquí los peces se escapan por debajo de habilidad 75; un cebo en la caña suma a tu habilidad durante diez minutos y cubre la diferencia. Para cocinar lo que pesques: {item:6328} para {item:6289} de lagos y ríos ({skill:185} 50, 4 p: {npc:5940} ({zone:1412}) o {npc:3027} ({zone:1456})); {item:6368} para {item:6361} de la costa ({skill:185} 50, 4 p: {npc:5942} ({zone:1411}) o {npc:3333} ({zone:1454})). {item:6358} de los bancos de aquí no es comida: los alquimistas hacen {item:6370} con él ({skill:171} 80); guárdalo para vender o comerciar.",
	-- ["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6328} for the {item:6289} of lakes and rivers ({skill:185} 50, 4s: {npc:66} ({zone:1429}) or {npc:5162} ({zone:1455})); {item:6368} for the {item:6361} of the coast ({skill:185} 50, 4s: {npc:5494} ({zone:1453}) or {npc:4305} ({zone:1436})). {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "Pesca en los bancos y en aguas abiertas hasta habilidad 125, unas 120 capturas: desde 75, las capturas suben la habilidad con menos frecuencia (una de cada dos hacia 100, una de cada tres hacia 125). Los bancos (restos flotantes, bancos de peces) también dan botín adicional. {item:6530} (+50 desde habilidad 50, 1 p cada uno) es el doble de fuerte que un {item:6529}. {item:6365} (+5 desde habilidad 10, 9 p 1 c) tiene existencias limitadas en los vendedores de pesca: cómprala cuando la veas. Aquí los peces se escapan por debajo de habilidad 75; un cebo en la caña suma a tu habilidad durante diez minutos y cubre la diferencia. Para cocinar lo que pesques: {item:6328} para {item:6289} de lagos y ríos ({skill:185} 50, 4 p: {npc:66} ({zone:1429}) o {npc:5162} ({zone:1455})); {item:6368} para {item:6361} de la costa ({skill:185} 50, 4 p: {npc:5494} ({zone:1453}) o {npc:4305} ({zone:1436})). {item:6358} de los bancos de aquí no es comida: los alquimistas hacen {item:6370} con él ({skill:171} 80); guárdalo para vender o comerciar.",
	-- ["Fish the pools and open water here until skill 125. Pools (floating debris, schools of fish) also drop extra loot."] = "Pesca en los bancos y en aguas abiertas aquí hasta 125 de habilidad. Los bancos (restos flotantes, bancos de peces) también dan botín extra.",
	-- ["Fish the pools here until skill 225, about 500 catches: one in three raises the skill at 125, one in seven by 225, so this is the long stretch. Forever's second camping item, the {item:279965} (from skill 140), is a blueprint that drops from Gelihast in {area:2797}. Fish get away here below skill 150; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6330} for the {item:6308} of lakes and rivers ({skill:185} 100, 12s: {npc:2383} ({zone:1424}) or {npc:5494} ({zone:1453})); {item:6369} for the {item:6362} of the coast ({skill:185} 175, 22s: {npc:3178} ({zone:1437}) or {npc:5162} ({zone:1455})). {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "Pesca en los bancos de aquí hasta habilidad 225, unas 500 capturas: una de cada tres sube la habilidad a 125, una de cada siete hacia 225, así que este es el tramo largo. El segundo objeto de acampada de Forever, {item:279965} (desde habilidad 140), es un plano que suelta Gelihast en {area:2797}. Aquí los peces se escapan por debajo de habilidad 150; un cebo en la caña suma a tu habilidad durante diez minutos y cubre la diferencia. Para cocinar lo que pesques: {item:6330} para {item:6308} de lagos y ríos ({skill:185} 100, 12 p: {npc:2383} ({zone:1424}) o {npc:5494} ({zone:1453})); {item:6369} para {item:6362} de la costa ({skill:185} 175, 22 p: {npc:3178} ({zone:1437}) o {npc:5162} ({zone:1455})). {item:6358} de los bancos de aquí no es comida: los alquimistas hacen {item:6370} con él ({skill:171} 80); guárdalo para vender o comerciar.",
	-- ["Fish the pools here until skill 225, about 500 catches: one in three raises the skill at 125, one in seven by 225, so this is the long stretch. Forever's second camping item, the {item:279965} (from skill 140), is a blueprint that drops from Gelihast in {area:2797}. Fish get away here below skill 150; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6330} for the {item:6308} of lakes and rivers ({skill:185} 100, 12s: {npc:2397} ({zone:1424}) or {npc:4553} ({zone:1458})); {item:6369} for the {item:6362} of the coast ({skill:185} 175, 22s: {npc:4574} ({zone:1458})). {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "Pesca en los bancos de aquí hasta habilidad 225, unas 500 capturas: una de cada tres sube la habilidad a 125, una de cada siete hacia 225, así que este es el tramo largo. El segundo objeto de acampada de Forever, {item:279965} (desde habilidad 140), es un plano que suelta Gelihast en {area:2797}. Aquí los peces se escapan por debajo de habilidad 150; un cebo en la caña suma a tu habilidad durante diez minutos y cubre la diferencia. Para cocinar lo que pesques: {item:6330} para {item:6308} de lagos y ríos ({skill:185} 100, 12 p: {npc:2397} ({zone:1424}) o {npc:4553} ({zone:1458})); {item:6369} para {item:6362} de la costa ({skill:185} 175, 22 p: {npc:4574} ({zone:1458})). {item:6358} de los bancos de aquí no es comida: los alquimistas hacen {item:6370} con él ({skill:171} 80); guárdalo para vender o comerciar.",
	-- ["Fish the pools here until skill 225, about 500 catches: one in three raises the skill at 125, one in seven by 225, so this is the long stretch. Forever's second camping item, the {item:279965} (from skill 140), is a blueprint that drops from Gelihast in {area:2797}. Fish get away here below skill 150; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6330} for the {item:6308} of lakes and rivers ({skill:185} 100, 12s: {npc:3029} ({zone:1456}) or {npc:3027} ({zone:1456})); {item:6369} for the {item:6362} of the coast ({skill:185} 175, 22s: {npc:12962} ({zone:1440}) or Wulan ({zone:1443}))."] = "Pesca en los bancos de aquí hasta habilidad 225, unas 500 capturas: una de cada tres sube la habilidad a 125, una de cada siete hacia 225, así que este es el tramo largo. El segundo objeto de acampada de Forever, {item:279965} (desde habilidad 140), es un plano que suelta Gelihast en {area:2797}. Aquí los peces se escapan por debajo de habilidad 150; un cebo en la caña suma a tu habilidad durante diez minutos y cubre la diferencia. Para cocinar lo que pesques: {item:6330} para {item:6308} de lagos y ríos ({skill:185} 100, 12 p: {npc:3029} ({zone:1456}) o {npc:3027} ({zone:1456})); {item:6369} para {item:6362} de la costa ({skill:185} 175, 22 p: {npc:12962} ({zone:1440}) o Wulan ({zone:1443})).",
	-- ["Fish the pools here until skill 225. If fish keep getting away, fish easier water until your skill catches up."] = "Pesca en los bancos de aquí hasta 225 de habilidad. Si los peces se te escapan a menudo, pesca en aguas más fáciles hasta que tu habilidad mejore.",
	-- ["Journeyman {skill:356}"] = "{skill:356} de oficial",
	-- ["Journeyman {skill:356} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:356} trainer of your faction."] = "{skill:356} de oficial sube el límite a 150; requiere 50 de habilidad y nivel de personaje 10. La flecha elige el instructor de {skill:356} de tu facción más cercano.",
	-- ["Vile Fin shore"] = "Orilla de los Anca Vil",
	-- ["{area:287} coast"] = "Costa de {area:287}",
	-- ["{area:35} coast"] = "Costa de {area:35}",
	-- ["{area:442} shore"] = "Orilla de {area:442}",
	-- ["{npc:12919} fishes from the shore of a small island off the east coast, south of Theramore; swim over from the coast."] = "{npc:12919} pesca desde la orilla de un islote frente a la costa este, al sur de Isla de Theramore; cruza a nado desde la costa.",
	-- ["{zone:1411} coast"] = "Costa de {zone:1411}",
	-- ["{zone:1413} oasis"] = "Oasis de {zone:1413}",
	-- ["{zone:1436} coast"] = "Costa de {zone:1436}",
	-- ["{zone:1437} coast"] = "Costa de {zone:1437}",
	-- ["{zone:1439} coast"] = "Costa de {zone:1439}",
	-- ["{zone:1440} waters"] = "Aguas de {zone:1440}",
}
