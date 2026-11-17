-- Spanish (Spain) (esES): the guide forever/class/rogue/poisons-alliance (forever/class/rogue/poisons-alliance.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Poisons (Alliance)"] = "",
	-- {item:7676} Thistle Tea
	["Forever teaches Poisons through this chain, not the trainer; the {item:7676} recipe comes with it."] = "En Forever, Venenos se aprende con esta cadena, no con el instructor; incluye la receta de {item:7676}.",

	-- Step 1: Mathias and the Defias
	-- {npc:332} Master Mathias Shaw · {object:2100} Old Town · {npc:7024} Agent Kearnen · {zone:1436} Westfall
	["At 20 {npc:332}, upstairs in the SI:7 building in {object:2100}, sends you to {npc:7024} in {zone:1436}. This chain is how you learn Poisons on Forever, so do not skip it."] = "A nivel 20, {npc:332}, en el piso de arriba del edificio del IV:7 de {object:2100}, te envía con {npc:7024} en {zone:1436}. Esta cadena es como aprendes Venenos en Forever, así que no te la saltes.",

	-- Step 2: Agent Kearnen
	-- {npc:7053} Klaven Mortwake · {zone:1436} Westfall · {zone:1431} Duskwood · {item:8046} Kearnen's Journal
	["Kearnen hides stealthed against the west side of a big tree with two small trees in front of it, just north of {npc:7053}'s Defias tower in the far east of {zone:1436}, by the {zone:1431} border. Read {item:8046} for the tower's layout if you like."] = "",

	-- Step 3: Klaven's Tower, with a group
	-- {quest:2359} Klaven's Tower
	["{quest:2359}, with a group"] = "{quest:2359}, en grupo",
	-- {npc:7053} Klaven Mortwake · {npc:7051} Malformed Defias Drone · {spell:921} Pick Pocket · {object:123214} Duskwood Chest · {spell:9810} Touch of Zanzil
	-- plural, as words: Defias Tower Patrollers = {npc:7052} Defias Tower Patroller
	["{npc:7053} on the top floor is a level 26 elite: easier at 24 or with a friend. Get the key first: the {npc:7051} (level 23, the spiky-haired one trailing yellow sparkles) walks a loop around the tower; stealth up and {spell:921} it from behind. Then up the tower past the Defias Tower Patrollers (23) and Sentries (24) to the {object:123214} beside Klaven's desk (Lockpicking about 70-75). Opening it poisons you with the {spell:9810}, which stops your stealth for a while."] = "{npc:7053}, en el piso superior, es un élite de nivel 26: más fácil a nivel 24 o con un amigo. Consigue primero la llave: el {npc:7051} (nivel 23, el del pelo de punta que deja un rastro de chispas amarillas) da vueltas alrededor de la torre; entra en sigilo y usa {spell:921} por detrás. Luego sube la torre pasando a los guardias de torre Defias (23) y los centinelas (24) hasta el {object:123214} junto al escritorio de Klaven (Forzar cerraduras sobre 70-75). Al abrirlo te envenena con {spell:9810}, que te impide usar el sigilo durante un rato.",
	-- {spell:921} Pick Pocket · {npc:7051} Malformed Defias Drone · {item:7923} Defias Tower Key
	["{spell:921} the {npc:7051} for the {item:7923}"] = "",
	-- {item:7908} Klaven Mortwake's Journal · {object:123214} Duskwood Chest
	["{item:7908}: the {object:123214}, top floor"] = "{item:7908}: {object:123214}, piso de arriba del todo",

	-- Step 4: Klaven's Tower, solo
	-- {quest:2359} Klaven's Tower
	["{quest:2359}, solo"] = "{quest:2359}, en solitario",
	-- {npc:7051} Malformed Defias Drone · {spell:921} Pick Pocket · {spell:2983} Sprint · {npc:7053} Klaven Mortwake · {object:123214} Duskwood Chest · {area:97} Alther's Mill · {spell:9810} Touch of Zanzil
	-- plural, as words: Defias Drones = {npc:7050} Defias Drone · Defias Tower Patrollers = {npc:7052} Defias Tower Patroller
	["Get the key first. The {npc:7051} (level 23, not elite) starts at the tower entrance and walks a loop around the outside; it is the spiky-haired one trailing yellow sparkles. Stealth up and {spell:921} it from behind: it always has the key. It hits hard: if stealth breaks, {spell:2983} away. Watch for the pair of Defias Drones that also patrol. Then sneak up the tower. Defias Tower Patrollers (23) and Sentries (24) guard the floors; an Ambush with a dagger kills them outright if you would rather clear them. {npc:7053}, a level 26 elite, waits on the top floor: Sap him, or bring a friend. The {object:123214} beside his desk needs Lockpicking of about 70-75 (practise on the boxes at {area:97} in Redridge first). A trick: while the Sentries are away, jump from the chair to the lamp to the bookshelf above the chest, step out of stealth and open the chest from there. Opening it poisons you with the {spell:9810}, which stops your stealth for a while and lets the drone see you; that is why the key comes first. Then get out."] = "Consigue primero la llave. El {npc:7051} (nivel 23, no élite) empieza en la entrada de la torre y da vueltas por fuera; es el del pelo de punta que deja un rastro de chispas amarillas. Entra en sigilo y usa {spell:921} por detrás: siempre lleva la llave. Pega fuerte: si se rompe el sigilo, huye con {spell:2983}. Atento a la pareja de zánganos Defias que también patrulla. Luego sube a hurtadillas por la torre. Los guardias de torre Defias (23) y los centinelas (24) vigilan los pisos; una Emboscada con daga los mata de golpe si prefieres limpiarlos. {npc:7053}, un élite de nivel 26, espera en el piso superior: aplícale Aporrear o lleva a un amigo. El {object:123214} junto a su escritorio necesita Forzar cerraduras sobre 70-75 (practica antes con las cajas de {area:97} en Montañas Crestagrana). Un truco: mientras los centinelas no están, salta de la silla a la lámpara y a la estantería sobre el cofre, sal del sigilo y ábrelo desde ahí. Al abrirlo te envenena con {spell:9810}, que te impide usar el sigilo durante un rato y permite que el zángano te vea; por eso la llave va primero. Después, sal de ahí.",

	-- Step 5: Master Mathias Shaw
	-- {zone:1453} Stormwind · {item:7676} Thistle Tea · {spell:8681} Instant Poison · {item:2928} Dust of Decay · {item:3371} Empty Vial · {npc:1325} Jasper Fel · {npc:1326} Sloan McCoy · {object:2100} Old Town
	["Head north through Elwynn to {zone:1453}; Mathias Shaw is upstairs in SI:7. He teaches Poisons and gives you the {item:7676} recipe. Poisons are made, not bought: each batch of {spell:8681} takes a {item:2928} and an {item:3371}, which {npc:1325} and {npc:1326} sell in {object:2100} next to SI:7. Buy a stack of each, open Poisons from your spellbook to make them, then use a poison on your weapon."] = "Ve al norte por Elwynn hasta {zone:1453}; Mathias Shaw está en el piso de arriba de IV:7. Te enseña Venenos y te da la receta de {item:7676}. Los venenos se fabrican, no se compran: cada tanda de {spell:8681} lleva un {item:2928} y un {item:3371}, que {npc:1325} y {npc:1326} venden en {object:2100}, junto a IV:7. Compra un montón de cada uno, abre Venenos desde tu libro de hechizos para fabricarlos y luego aplica un veneno a tu arma.",
	-- {npc:332} Master Mathias Shaw
	["{npc:332}: Poisons"] = "",

	-- Step 6: Doc Mixilpixil
	-- {quest:2607} The Touch of Zanzil · {npc:7207} Doc Mixilpixil · {npc:1325} Jasper Fel
	["{quest:2607} still sits on you. {npc:7207} works in the cellar of the SI:7 building: the stairs down are under the stairs to the upper floor, behind {npc:1325}. Target him and type /lay (nothing after it) to be examined, then wait. If he does nothing, abandon the quest, take it again and wait until he asks you to lie down."] = "Todavía tienes {quest:2607} encima. {npc:7207} trabaja en el sótano del edificio del IV:7: la bajada está debajo de la escalera al piso de arriba, detrás de {npc:1325}. Selecciónalo y escribe /lay (sin nada después) para que te examine, y espera. Si no hace nada, abandona la misión, vuelve a tomarla y espera a que te pida que te acuestes.",
	["/lay with the Doc targeted"] = "/lay con el Doc seleccionado",

	-- Step 7: The cure's ingredients
	["The cure's ingredients"] = "Los ingredientes de la cura",
	-- {zone:1453} Stormwind · {item:3421} Simple Wildflowers · {npc:1303} Felicia Gump · {object:2096} Trade District · {item:3372} Leaded Vial · {npc:1257} Keldric Boucher · {npc:1325} Jasper Fel · {item:4371} Bronze Tube · {item:8431} Spool of Light Chartreuse Silk Thread · {object:2177} The Finest Thread · {item:6452} Anti-Venom · {skill:129} First Aid · {spell:526} Cure Poison · {spell:9810} Touch of Zanzil
	["All four are in {zone:1453}. {item:3421}: Bernard or {npc:1303}'s flower shop by the {object:2096} canal. A {item:3372}: many general goods and alchemy vendors ({npc:1257}, {npc:1325} and others). A {item:4371}: the Auction House in the {object:2096}; the engineering suppliers keep only one and are nearly always sold out, and an engineer can make one. The {item:8431} lies on the floor beside the left end of the counter in {object:2177}, the tailor's shop on the canals; you can only pick it up with this quest. If you skip the cure, an {item:6452} ({skill:129}) or a druid's {spell:526} also clears the {spell:9810}."] = "",
	-- {item:4371} Bronze Tube
	["{item:4371}: the Auction House"] = "",

	-- Step 8: Back to Doc Mixilpixil
	-- {npc:7207} Doc Mixilpixil
	["Back to {npc:7207}"] = "De vuelta con {npc:7207}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["/lay down"] = "/lay down",
	-- ["Everything is in {zone:1453}: the Gumps sell {item:3421}, the {item:8431} lies in the city, and the nearest vendors sell a {item:3372} and a {item:4371}."] = "Todo está en {zone:1453}: los Gump venden {item:3421}, el {item:8431} está en la ciudad y los mercaderes más cercanos venden un {item:3372} y un {item:4371}.",
	-- ["Ride north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "Cabalga al norte por el Bosque de Elwynn hasta {zone:1453}; Mathias Shaw está en el IV:7, en {object:2100}.",
	-- ["{npc:7024} watches {npc:7053}'s tower from the hills in the far east of {zone:1436}, by the {zone:1431} border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "{npc:7024} vigila la torre de {npc:7053} desde las colinas del extremo este de {zone:1436}, junto a la frontera con {zone:1431}. El {npc:7051} (nivel 23) que guarda la torre lleva su llave; el diario de Klaven está en el cofre de arriba.",
	-- ["{npc:7207} works in the cellar of SI:7, the Barracks. Type /lay down beside him to be examined."] = "{npc:7207} trabaja en el sótano del IV:7, el Cuartel. Escribe /lay down a su lado para que te examine.",
	-- ["{spell:2842} (Alliance)"] = "{spell:2842} (Alianza)",
}
