-- Spanish (Latin America) (esMX): the guide forever/class/warlock/felhunter-horde (forever/class/warlock/felhunter-horde.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Felhunter (Horde)"] = "Manáfago (Horda)",
	-- {item:22244} Box of Souls
	["The felhunter, the demon to bring against spellcasters, and a {item:22244} for your shards."] = "El manáfago, el demonio ideal contra lanzadores de hechizos, y una {item:22244} para tus fragmentos.",

	-- Step 1: Seeking Strahad (Orgrimmar)
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 30 {npc:5875}, in the {object:172960} under the {object:172982}, sends you to {npc:6251} in {area:392}."] = "A nivel 30, {npc:5875}, en {object:172960} bajo {object:172982}, te envía con {npc:6251} en {area:392}.",

	-- Step 2: Seeking Strahad (Undercity)
	-- {npc:5675} Carendin Halgar · {object:36082} Magic Quarter · {npc:6251} Strahad Farsan · {area:392} Ratchet · {zone:1420} Tirisfal Glades · {zone:1411} Durotar · {quest:2996} Seeking Strahad
	["At 30 {npc:5675}, in the {object:36082}, sends you to {npc:6251} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}. Take only one {quest:2996}: if {npc:6251} offers nothing, drop the duplicate from your log."] = "A nivel 30, {npc:5675}, en {object:36082}, te manda con {npc:6251} en {area:392}. El zepelín desde {zone:1420} vuela a {zone:1411}. Toma solo una {quest:2996}: si {npc:6251} no te ofrece nada, quita la repetida de tu registro.",

	-- Step 3: Strahad Farsan
	-- {area:392} Ratchet · {zone:1454} Orgrimmar · {npc:6251} Strahad Farsan · {npc:6266} Menara Voidrender · {npc:6293} Jorah Annison · {zone:1458} Undercity
	["{area:392}'s flight point is a short flight from {zone:1454}'s. {npc:6251} stands on the hill above the town, behind the engineers' hut, by his little tower; {npc:6266} and two acolytes are with him. He sends you to {npc:6293} in the {zone:1458}."] = "El punto de vuelo de {area:392} está a un vuelo corto del de {zone:1454}. {npc:6251} está en la colina sobre el pueblo, detrás de la choza de los ingenieros, junto a su torrecita; {npc:6266} y dos acólitos están con él. Te manda con {npc:6293} en {zone:1458}.",

	-- Step 4: Jorah Annison
	-- {npc:6293} Jorah Annison · {object:36082} Magic Quarter · {zone:1458} Undercity · {quest:1801} Tome of the Cabal · {area:287} Hillsbrad · {zone:1441} Thousand Needles
	["{npc:6293} is in the {object:36082} of the {zone:1458}. He wants two lost pieces of the {quest:1801}: one on the {area:287} coast, one in {zone:1441}."] = "{npc:6293} está en {object:36082} de {zone:1458}. Quiere dos partes perdidas de {quest:1801}: una en la costa de {area:287} y otra en {zone:1441}.",

	-- Step 5: Moldy Tome
	-- {area:271} Southshore
	["The tome is a small grey-blue book lying in the sand of a murloc camp on the shore south-west of {area:271}, near the water's edge. Six or seven murlocs guard it and more lurk underwater: they come in groups, so Fear one and keep your voidwalker on the rest. Walk down to the water to click it; from the hillside the crates block the cursor."] = "El tomo es un librito gris azulado que está en la arena de un campamento múrloc en la orilla al suroeste de {area:271}, cerca del agua. Seis o siete múrlocs lo custodian y hay más acechando bajo el agua: vienen en grupo, así que aterra a uno y mantén a tu abisario con el resto. Baja hasta el agua para hacer clic en él; desde la ladera, las cajas tapan el cursor.",
	-- {item:6931} Moldy Tome · {quest:1803} Tome of the Cabal
	["{item:6931}, from the {quest:1803} on the sand"] = "{item:6931}, de {quest:1803} en la arena",

	-- Step 6: Tattered Manuscript
	-- {area:484} Freewind Post
	["The centaur cave opens in the cliffs north of {area:484}. Inside, keep right at each fork, cross the pool by the small waterfall, and open the small dark box against the wall beside a larger chest: the larger one is the wrong one. You can open it only while on the quest. The centaurs respawn behind you on the way out."] = "La cueva de los centauros se abre en los acantilados al norte de {area:484}. Adentro, ve por la derecha en cada bifurcación, cruza la poza junto a la cascadita y abre la cajita oscura contra la pared, al lado de un cofre más grande: el grande no es. Solo puedes abrirla mientras tienes la misión. Los centauros reaparecen detrás de ti al salir.",
	-- {item:6997} Tattered Manuscript · {object:92423} Damaged Chest
	["{item:6997}, in the {object:92423}"] = "{item:6997}, en {object:92423}",

	-- Step 7: Back to Jorah Annison
	-- {npc:6293} Jorah Annison
	["Back to {npc:6293}"] = "De vuelta con {npc:6293}",
	-- {npc:6293} Jorah Annison · {item:7006} Reconstructed Tome · {npc:6251} Strahad Farsan
	["{npc:6293} pieces the tome together and gives you the {item:7006}: keep it, {npc:6251} takes it with the rods."] = "{npc:6293} arma el tomo y te da {item:7006}: guárdalo, {npc:6251} lo recibe con las varas.",

	-- Step 8: Rods of Channeling
	["Rods of Channeling"] = "Varas de mediación",
	-- {area:1036} Angerfang Encampment · {zone:1437} Wetlands · {area:881} Thandol Span · {zone:1417} Arathi Highlands
	["The Dragonmaw hold {area:1036} in the hills east of the road through the {zone:1437}, south of the {area:881} you cross from {zone:1417}. Only the casters drop the rods, four kills in five: the Bonewarders (level 27, with skeleton pets) and Shadowwarders (28). A steep path north of the central spirit healer leads up into the camp past most of the warriors."] = "Los Faucedraco ocupan {area:1036} en las colinas al este del camino que cruza {zone:1437}, al sur de {area:881}, que cruzas desde {zone:1417}. Solo los lanzadores de hechizos sueltan las varas, cuatro de cada cinco veces: los guardahuesos (nivel 27, con mascotas esqueleto) y los guardasombras (28). Un sendero empinado al norte del ángel de la resurrección central sube al campamento evitando a la mayoría de los guerreros.",
	["Rods of Channeling, from the Dragonmaw casters"] = "Varas de canalización, de los lanzadores de hechizos Faucedraco",

	-- Step 9: The Binding
	-- {npc:6251} Strahad Farsan · {area:392} Ratchet · {quest:1804} Tome of the Cabal · {quest:1795} The Binding
	["Back to {npc:6251} in {area:392}. When you accept, he draws the summoning circle and his acolytes channel a greater circle over it: wait inside the tower until both are done. Then use the {quest:1804} on the circle. The felhunter (level 30, not elite) silences and eats mana, and it vanishes after two minutes: have your voidwalker out, open with your damage over time at once and let the voidwalker tank. If you die or it wins, abandon {quest:1795} and take it again from {npc:6251}. Keep the tome: {npc:6251} takes it back."] = "De vuelta con {npc:6251} en {area:392}. Cuando aceptas, dibuja el círculo de invocación y sus acólitos canalizan un círculo mayor encima: espera dentro de la torre hasta que terminen los dos. Luego usa {quest:1804} sobre el círculo. El manáfago (nivel 30, no élite) silencia y come maná, y desaparece a los dos minutos: ten afuera a tu abisario, empieza enseguida con tu daño en el tiempo y deja que el abisario aguante. Si mueres o gana él, abandona {quest:1795} y vuelve a tomarla con {npc:6251}. Guarda el tomo: {npc:6251} lo recupera.",
	-- {quest:1804} Tome of the Cabal
	["{quest:1804}, on the circle"] = "{quest:1804}, sobre el círculo",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 30 {npc:5675}, in the {object:36082}, sends you to {npc:6251} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}."] = "A nivel 30, {npc:5675}, en {object:36082}, te envía con {npc:6251} en {area:392}. El zepelín de {zone:1420} vuela a {zone:1411}.",
	-- ["Back to {npc:6251} in {area:392}. Use the {quest:1804} on the summoning circle beside him and defeat the felhunter to bind it."] = "Regresa con {npc:6251} en {area:392}. Usa {quest:1804} en el círculo de invocación junto a él y derrota al manáfago para atarlo.",
	-- ["Fly to {area:392}; {npc:6251} stands on the hill in town."] = "Vuela a {area:392}; {npc:6251} está en la colina del pueblo.",
	-- ["The Dragonmaw Bonewarders and Shadowwarders hold the hills east of the road through the {zone:1437}: the rods drop from them."] = "Los Guardahuesos Faucedraco y los Depositarios de sombras Faucedraco ocupan las colinas al este del camino que cruza {zone:1437}: ellos sueltan las varas.",
	-- ["The {item:6931} lies on the shore west of {area:271}, past the Torn Fin murloc camps."] = "El {item:6931} está en la orilla al oeste de {area:271}, pasando los campamentos múrloc Rompeanca.",
	-- ["The {object:92423} lies in the canyon north of {area:484}."] = "{object:92423} está en el cañón al norte de {area:484}.",
	-- ["{npc:6251}: he binds the felhunter to you"] = "{npc:6251}: te ata al manáfago",
	-- ["{npc:6293} stands in the {object:36082}."] = "{npc:6293} está en {object:36082}.",
}
