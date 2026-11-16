-- Spanish (Latin America) (esMX): the guide forever/reputation/centaur-clans (forever/reputation/centaur-clans.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Gelkis and Magram Centaur Reputation"] = "Reputación con los centauros Gelkis y Magram",
	-- {zone:1443} Desolace
	["{zone:1443}'s feuding clans, reworked in Forever: pick one, buy its friendship, and trade totems for recipes."] = "Los clanes enfrentados de {zone:1443}, renovados en Forever: elige uno, compra su amistad y cambia tótems por recetas.",
	-- {quest:93224} Carved Centaur Totems
	["12 recipes for {quest:93224} at the clan quartermasters, no standing needed"] = "12 recetas por {quest:93224} con los intendentes de los clanes, sin necesidad de reputación",
	-- {npc:5601} Khan Jehn
	["{npc:5601}'s quest: a clan title and a choice of three rare level 35 weapons"] = "La misión de {npc:5601}: un título de clan y a elegir entre tres armas raras de nivel 35",

	-- Step 1: Pick your clan
	["Pick your clan"] = "Elige tu clan",
	-- {zone:1443} Desolace · {npc:5396} Captain Pentigast · {area:608} Nijel's Point · {quest:1382} Strange Alliance · {quest:1385} Brutal Politics · {npc:5412} Gurda Wildmane · {quest:1368} Gelkis Alliance · {quest:1367} Magram Alliance · {quest:93224} Carved Centaur Totems
	["The Gelkis (south-west {zone:1443}) and the Magram (south-east) are at war: every kill of one clan gives the other 20 and costs its own clan 100, and every quest of one clan costs the other five times what it pays (Buying Friendship: 3,000 for yours, 15,000 off the other), so you can only climb with one. Both start Neutral. Forever's quests are worth far more than kills now. Alliance: {npc:5396} at {area:608} offers {quest:1382} (Gelkis) and {quest:1385} (Magram). Horde: {npc:5412} offers {quest:1368} and {quest:1367}. Take the one of your clan, and {quest:93224}: each clan's Buying Friendship (3,000) is offered once you bring the totems back. Then tick the task. The guide goes on with the Gelkis; take the Magram's quests instead and it goes to the Magram half. Forever pays these quests in full at any level."] = "Los Gelkis (suroeste de {zone:1443}) y los Magram (sureste) están en guerra: cada muerte de un clan da 20 al otro y le cuesta 100 a su propio clan, y cada misión de un clan le cuesta al otro cinco veces lo que paga (“Buying Friendship”: 3000 para el tuyo, 15000 menos para el otro), así que solo puedes subir con uno. Ambos empiezan en Neutral. Las misiones de Forever ahora valen mucho más que las muertes. Alianza: {npc:5396}, en {area:608}, ofrece {quest:1382} (Gelkis) y {quest:1385} (Magram). Horda: {npc:5412} ofrece {quest:1368} y {quest:1367}. Toma la de tu clan y {quest:93224}: la “Buying Friendship” de cada clan (3000) se ofrece cuando traes los tótems. Después marca la tarea. La guía sigue con los Gelkis; toma en su lugar las misiones de los Magram y pasará a la mitad de los Magram. Forever paga estas misiones completas a cualquier nivel.",
	-- {quest:1382} Strange Alliance
	["{quest:1382}: Gelkis"] = "{quest:1382}: Gelkis",
	["Take the quests of one clan"] = "Toma las misiones de un solo clan",

	-- Step 2: Carved Centaur Totems
	-- {area:608} Nijel's Point
	["The Kolkar centaurs (level 30-33) in the camps along the eastern road, south of {area:608}, drop the totems, and so do the Magram and the Maraudine. Bring five back, then take your clan's Buying Friendship (Gelkis below; the Magram's instead for the Magram)."] = "Los centauros Kolkar (nivel 30-33) de los campamentos junto al camino del este, al sur de {area:608}, sueltan los tótems, y también los Magram y los Maraudine. Trae cinco y luego toma la “Buying Friendship” de tu clan (la de los Gelkis, abajo; la de los Magram si vas con los Magram).",
	-- {item:254432} Carved Centaur Totem
	["{item:254432}: Kolkar centaurs"] = "{item:254432}: centauros Kolkar",

	-- Step 3: Gelkis or Magram
	["Gelkis or Magram"] = "Gelkis o Magram",
	["No clan's quests in your log: the guide goes on with the Gelkis. For the Magram, take their choice quest and Buying Friendship and the guide goes to the Magram half."] = "Ninguna misión de clan en tu registro: la guía sigue con los Gelkis. Para los Magram, toma su misión de elección y “Buying Friendship”, y la guía pasa a la mitad de los Magram.",

	-- Step 4: Gelkis: the choice quest
	["Gelkis: the choice quest"] = "Gelkis: la misión de elección",
	-- {npc:5397} Uthek the Wise · {area:606} Gelkis Village
	["The Gelkis half starts with the clan's choice quest from the giver you just handed the totems to: {npc:5397}'s quests in {area:606} follow from it, and Buying Friendship alone does not open them."] = "La mitad de los Gelkis empieza con la misión de elección del clan del asignador de misiones al que acabas de entregar los tótems: de ella vienen las misiones de {npc:5397} en {area:606}, y “Buying Friendship” por sí sola no las abre.",

	-- Step 5: Gelkis Village: Uthek the Wise and Molkar
	-- {area:606} Gelkis Village · {npc:5397} Uthek the Wise · {npc:253140} Molkar
	["{area:606}: {npc:5397} and {npc:253140}"] = "{area:606}: {npc:5397} y {npc:253140}",
	-- {area:606} Gelkis Village · {zone:1443} Desolace · {npc:5397} Uthek the Wise · {npc:253140} Molkar
	["{area:606} sits in the hills of south-west {zone:1443}; {npc:5397} stands at its heart. {npc:253140}, the Gelkis quartermaster, is at the south end of the village. Buying Friendship alone takes you from Neutral to Friendly."] = "{area:606} está en las colinas del suroeste de {zone:1443}; {npc:5397} está en su centro. {npc:253140}, el intendente Gelkis, está en el extremo sur de la aldea. Comprar amistad por sí sola te lleva de Neutral a Amistoso.",

	-- Step 6: Gelkis: the Kolkar camps
	["Gelkis: the Kolkar camps"] = "Gelkis: los campamentos Kolkar",
	-- {area:608} Nijel's Point · {item:6079} Crude Charm
	["The Kolkar centaurs (level 30-33) hold the camps south of {area:608}, along the eastern road. About one in four drops a {item:6079}."] = "Los centauros Kolkar (nivel 30-33) ocupan los campamentos al sur de {area:608}, a lo largo del camino del este. Más o menos uno de cada cuatro suelta un {item:6079}.",
	-- {item:6079} Crude Charm
	["{item:6079}: Kolkar centaurs"] = "{item:6079}: centauros Kolkar",

	-- Step 7: Gelkis: Magram Village
	-- {area:604} Magram Village
	["Gelkis: {area:604}"] = "Gelkis: {area:604}",
	-- {area:604} Magram Village
	["The Sacks of Meat lie about {area:604}, in the south-east. Every Magram you kill on the way pays the Gelkis 20."] = "Los sacos de carne están por {area:604}, en el sureste. Cada Magram que mates por el camino paga 20 a los Gelkis.",
	-- {item:6069} Crudely Dried Meat
	["{item:6069}: Sacks of Meat"] = "{item:6069}: sacos de carne",
	-- {npc:4640} Magram Wrangler
	["{npc:4640}: 20 Gelkis"] = "{npc:4640}: 20 Gelkis",
	-- {npc:4641} Magram Windchaser
	["{npc:4641}: 20 Gelkis"] = "{npc:4641}: 20 Gelkis",

	-- Step 8: Gelkis: Ongeku
	-- {quest:1373} Ongeku
	["Gelkis: {quest:1373}"] = "Gelkis: {quest:1373}",
	-- {npc:5397} Uthek the Wise · {zone:1435} Swamp of Sorrows · {quest:1373} Ongeku · {area:76} Fallow Sanctuary · {area:75} Stonard
	["Back to {npc:5397}, then east to the {zone:1435}: {quest:1373} (level 37) waits by a black cauldron in {area:76}, north-east of {area:75}."] = "De vuelta con {npc:5397}, y luego al este a {zone:1435}: {quest:1373} (nivel 37) espera junto a un caldero negro en {area:76}, al noreste de {area:75}.",

	-- Step 9: Gelkis: totems and kills to Honored
	["Gelkis: totems and kills to Honored"] = "Gelkis: tótems y muertes hasta Honorable",
	-- {npc:253140} Molkar · {quest:92812} Economic Warfare · {quest:93224} Carved Centaur Totems · {zone:1443} Desolace · {item:10008} White Bandit Mask · {item:5739} Barbaric Harness
	-- plural, as words: Greater Mystic Essences = {item:11135} Greater Mystic Essence
	["Friendly to Honored is 6,000; after the clan's quests you are about 4,000 into it, so 2,000 to go. {npc:253140}'s {quest:92812} takes 5 {quest:93224} for 750, again and again: three turn-ins, 15 totems. The Maraudine centaurs (level 36-40) of western {zone:1443} drop them; the totems do not bind, so the auction house is the other source. Magram kills add 20 each, but Forever's kill data stops them at the end of Friendly, 1 short of Honored. At Friendly the village also has three craft orders for 1,000 each: Halea wants 3 Greater Mystic Essences, {npc:253140} a {item:10008} (tailoring) and Talra a {item:5739} (leatherworking). Legacy Diplomat adds up to 10%."] = "De Amistoso a Honorable hay 6000; después de las misiones del clan llevas unos 4000, así que faltan 2000. {quest:92812} de {npc:253140} pide 5 {quest:93224} por 750, una y otra vez: tres entregas, 15 tótems. Los centauros Maraudine (nivel 36-40) del oeste de {zone:1443} los sueltan; los tótems no se ligan, así que la casa de subastas es la otra fuente. Las muertes de Magram suman 20 cada una, pero los datos de muertes de Forever las detienen al final de Amistoso, a 1 de Honorable. En Amistoso, el poblado también tiene tres encargos de fabricación de 1000 cada uno: Halea quiere 3 Esencias místicas superiores, {npc:253140} una {item:10008} (sastrería) y Talra un {item:5739} (peletería). Diplomático, del Legado, añade hasta un 10%.",
	-- {item:254432} Carved Centaur Totem
	["{item:254432}: Maraudine centaurs"] = "{item:254432}: centauros Maraudine",

	-- Step 10: Gelkis: Uthek the Wise sends you to the valley
	-- {npc:5397} Uthek the Wise
	["Gelkis: {npc:5397} sends you to the valley"] = "Gelkis: {npc:5397} te manda al valle",
	-- {npc:5397} Uthek the Wise · {npc:253177} Nerlokh · {quest:93034} Valley of Bones · {zone:1443} Desolace · {zone:2652} Shen'dralas · {quest:92811} Economic Warfare
	["At Honored and level 35, {npc:5397} sends you east to {npc:253177}, a Gelkis scout at the western mouth of the {quest:93034}, where the south of {zone:1443} runs into {zone:2652}. The valley steps follow Forever's quest data: nobody who records their play has done these quests yet, so a spot or the order may be off. Every valley quest asks you to stay Honored with the Gelkis, and each costs the Magram five times what it pays. Honored to Revered is 12,000; the valley pays 10,625 of it, {quest:92811} the rest."] = "Con Honorable y nivel 35, {npc:5397} te manda al este con {npc:253177}, un explorador Gelkis en la boca oeste de {quest:93034}, donde el sur de {zone:1443} da paso a {zone:2652}. Los pasos del valle siguen los datos de misiones de Forever: nadie que registre su juego ha hecho todavía estas misiones, así que un lugar o el orden pueden no ser exactos. Cada misión del valle te pide seguir en Honorable con los Gelkis, y cada una le cuesta a los Magram cinco veces lo que paga. De Honorable a Reverenciado hay 12000; el valle paga 10625, {quest:92811} el resto.",

	-- Step 11: Gelkis: Nerlokh
	-- {npc:253177} Nerlokh
	["Gelkis: {npc:253177}"] = "Gelkis: {npc:253177}",
	-- {npc:253177} Nerlokh · {npc:11559} Outcast Necromancer
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager
	["From the quest data: {npc:253177} waits at the valley's western mouth. He wants six Undead Ravagers put to rest and the ritual garb of an {npc:11559}: the outcasts are Gelkis exiles who took up the Magram's necromancy."] = "Según los datos de la misión: {npc:253177} espera en la boca oeste del valle. Quiere que hagas descansar a seis devastadores no-muertos y la vestimenta ritual de un {npc:11559}: los exiliados son desterrados Gelkis que adoptaron la nigromancia de los Magram.",

	-- Step 12: Gelkis: the valley's mouth
	["Gelkis: the valley's mouth"] = "Gelkis: la boca del valle",
	-- {quest:92846} Outcast Necromancers · {npc:253177} Nerlokh · {npc:253136} Orgrul
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager
	["From the quest data: the Undead Ravagers and the {quest:92846} fill the valley from {npc:253177} north-east to {npc:253136}'s post at its northern mouth; players have met them all along it. {npc:253136}'s Magram are hostile to a friend of the Gelkis. Corpsefeeders, elite and level 45, walk the valley and attack anyone."] = "Según los datos de la misión: los devastadores no-muertos y {quest:92846} llenan el valle desde {npc:253177} al noreste hasta el puesto de {npc:253136} en su boca norte; los jugadores los han encontrado a todo lo largo. Los Magram de {npc:253136} son hostiles con un amigo de los Gelkis. Los Corpsefeeders, élite y de nivel 45, recorren el valle y atacan a cualquiera.",

	-- Step 13: Gelkis: Facing the Truth
	-- {quest:93041} Facing the Truth
	["Gelkis: {quest:93041}"] = "Gelkis: {quest:93041}",
	-- {npc:253177} Nerlokh · {item:255941} Gelkis Necromantic Garb · {npc:5397} Uthek the Wise · {item:255945} Accursed Skull
	["From the quest data: {npc:253177} gives you a {item:255941} to show {npc:5397}, with an {item:255945} you find yourself: a freshly cursed skull, hoarded in the jaws of one of the valley's giant skeletons. The game's data has no spot for it."] = "Según los datos de la misión: {npc:253177} te da una {item:255941} para mostrársela a {npc:5397}, con un {item:255945} que encuentras tú mismo: un cráneo recién maldito, guardado en las fauces de uno de los esqueletos gigantes del valle. Los datos del juego no tienen un lugar para él.",
	-- {item:255945} Accursed Skull
	["{item:255945}: in a giant skeleton's jaws"] = "{item:255945}: en las fauces de un esqueleto gigante",

	-- Step 14: Gelkis: Uthek the Wise and Mulara
	-- {npc:5397} Uthek the Wise · {npc:253713} Mulara
	["Gelkis: {npc:5397} and {npc:253713}"] = "Gelkis: {npc:5397} y {npc:253713}",
	-- {npc:5397} Uthek the Wise · {area:606} Gelkis Village · {npc:253713} Mulara · {npc:253140} Molkar · {quest:92812} Economic Warfare
	["From the quest data: back west to {npc:5397} in {area:606}. She needs Tears of Theradras: {npc:253713}, the Voice of Theradras, keeps them in the cave in the south of the village, past {npc:253140}. Ask her for them on {npc:5397}'s behalf and bring three back. {npc:253140} takes {quest:92812} on the way."] = "Según los datos de la misión: de vuelta al oeste con {npc:5397} en {area:606}. Necesita Lágrimas de Theradras: {npc:253713}, la Voz de Theradras, las guarda en la cueva del sur de la aldea, pasando a {npc:253140}. Pídeselas en nombre de {npc:5397} y trae tres. {npc:253140} recibe {quest:92812} de paso.",
	-- {npc:253713} Mulara
	["{npc:253713}, in the cave"] = "{npc:253713}, en la cueva",
	["three Tears of Theradras"] = "tres Lágrimas de Theradras",

	-- Step 15: Gelkis: Test Your Theory
	-- {quest:93045} Test Your Theory
	["Gelkis: {quest:93045}"] = "Gelkis: {quest:93045}",
	-- {npc:5397} Uthek the Wise · {item:6071} Draenethyst Crystal · {item:256061} Uthek's Draenethyst Staff · {item:255945} Accursed Skull · {npc:253177} Nerlokh
	["From the quest data: {npc:5397} gives you her staff and a {item:6071}. Put them together into {item:256061}, take it to the ritual site by the pond just east of the village and dispel the curse on the {item:255945}. Then east again to {npc:253177}."] = "Según los datos de la misión: {npc:5397} te da su bastón y un {item:6071}. Únelos en {item:256061}, llévalo al sitio del ritual junto al estanque justo al este de la aldea y disipa la maldición de {item:255945}. Luego otra vez al este, con {npc:253177}.",
	-- {item:255945} Accursed Skull
	["dispel the {item:255945} by the pond"] = "disipa {item:255945} junto al estanque",

	-- Step 16: Gelkis: back to Nerlokh
	-- {npc:253177} Nerlokh
	["Gelkis: back to {npc:253177}"] = "Gelkis: de vuelta con {npc:253177}",
	-- {npc:253177} Nerlokh · {item:271794} Centaur Spear · {item:271795} Wanderer's Broadsword · {item:271799} Desert Crawler's Claw
	["From the quest data: {npc:253177} pays 500 and your pick of three weapons for level 35: {item:271794} (polearm), {item:271795} (two-handed sword) or {item:271799} (dagger). Then he has two jobs deeper in the valley."] = "Según los datos de la misión: {npc:253177} paga 500 y a elegir una de tres armas de nivel 35: {item:271794} (arma de asta), {item:271795} (espada de dos manos) o {item:271799} (daga). Luego tiene dos trabajos más adentro del valle.",

	-- Step 17: Gelkis: the heart of the valley
	["Gelkis: the heart of the valley"] = "Gelkis: el corazón del valle",
	-- {npc:253177} Nerlokh · {npc:253446} Haggard Bones · {item:256061} Uthek's Draenethyst Staff
	-- plural, as words: Gelkis Captives = {npc:253431} Gelkis Captive · Magram Necrokhans = {npc:253274} Magram Necrokhan
	["From the quest data: east of {npc:253177}, in the heart of the valley, the Magram hold Gelkis Captives: free five. Among them lie {npc:253446}, failed summons stuck in the ground: lay eight to rest with {item:256061}, which the quest gives you. Corpsefeeders and Magram Necrokhans, elite and level 45, walk the valley and attack a friend of the Gelkis: let them pass before you pull."] = "Según los datos de la misión: al este de {npc:253177}, en el corazón del valle, los Magram retienen cautivos Gelkis: libera a cinco. Entre ellos yacen {npc:253446}, invocaciones fallidas atascadas en el suelo: haz descansar a ocho con {item:256061}, que te da la misión. Los Corpsefeeders y los necrokhans Magram, élite y de nivel 45, recorren el valle y atacan a un amigo de los Gelkis: déjalos pasar antes de atraer.",
	-- {npc:253446} Haggard Bones
	["Lay {npc:253446} to rest"] = "Haz descansar a {npc:253446}",
	-- plural, as words: Gelkis Captives = {npc:253431} Gelkis Captive
	["free five Gelkis Captives"] = "libera a cinco cautivos Gelkis",

	-- Step 18: Gelkis: Checking Things Out
	-- {quest:93122} Checking Things Out
	["Gelkis: {quest:93122}"] = "Gelkis: {quest:93122}",
	-- {npc:253177} Nerlokh · {zone:2652} Shen'dralas · {area:16675} Magram Front · {area:16676} Outcast Hideaway
	["From the quest data: {npc:253177}'s next order takes you deeper into {zone:2652} to scout two places: the {area:16675}, a Magram camp south-east of the valley, and the {area:16676}, the exiles' camp west of the Shen'dralar town, further south."] = "Según los datos de la misión: la siguiente orden de {npc:253177} te lleva más adentro de {zone:2652} a explorar dos lugares: {area:16675}, un campamento Magram al sureste del valle, y {area:16676}, el campamento de los exiliados al oeste del pueblo Shen'dralar, más al sur.",

	-- Step 19: Gelkis: the Magram Front and the Outcast Hideaway
	-- {area:16675} Magram Front · {area:16676} Outcast Hideaway
	["Gelkis: the {area:16675} and the {area:16676}"] = "Gelkis: {area:16675} y {area:16676}",
	-- {area:16675} Magram Front · {area:16676} Outcast Hideaway · {npc:254040} Rokren · {npc:253177} Nerlokh
	-- plural, as words: Outcast Necrokhans = {npc:253275} Outcast Necrokhan
	["From the quest data: walk into the Magram camp at the {area:16675}, then south-west into the {area:16676}, where Outcast Necrokhans, elite and level 45, stand guard. In a tent there {npc:254040}, a Gelkis the outcasts hold, asks you to get him out: escort him clear of the hideaway, then tell {npc:253177}."] = "Según los datos de la misión: entra al campamento Magram de {area:16675}, luego ve al suroeste hacia {area:16676}, donde montan guardia necrokhans exiliados, élite y de nivel 45. En una tienda de ahí, {npc:254040}, un Gelkis retenido por los exiliados, te pide que lo saques: escóltalo fuera del escondite y luego avísale a {npc:253177}.",
	-- {npc:254040} Rokren
	["escort {npc:254040} out of the hideaway"] = "escolta a {npc:254040} fuera del escondite",

	-- Step 20: Gelkis: Nerlokh's last order
	-- {npc:253177} Nerlokh
	["Gelkis: {npc:253177}'s last order"] = "Gelkis: la última orden de {npc:253177}",
	-- {npc:253177} Nerlokh
	["From the quest data: with the Magram's warriors busy at the Front, {npc:253177} sees a chance at their khan."] = "Según los datos de la misión: con los guerreros Magram ocupados en el Frente, {npc:253177} ve una oportunidad contra su khan.",

	-- Step 21: Gelkis: Khan Jehn
	-- {npc:5601} Khan Jehn
	["Gelkis: {npc:5601}"] = "Gelkis: {npc:5601}",
	-- {npc:5601} Khan Jehn · {area:604} Magram Village · {npc:253177} Nerlokh · {npc:5397} Uthek the Wise · {item:271801} Abandoned Ferocity · {item:271802} Bludgeon of Betrayed Virtues · {item:271805} Thrice-Damned Effigy
	-- plural, as words: Magram Necrokhans = {npc:253274} Magram Necrokhan
	["From the quest data: {npc:5601} (level 37) leads the Magram from the west side of {area:604}, north-east of {npc:253177}. The village is hostile to a friend of the Gelkis, and two Magram Necrokhans, elite and level 45, stand a little west of the khan. {npc:5397} pays 6,000, a title, and your pick of three rare level 35 weapons: {item:271801} (two-handed axe: Strength, Stamina, Agility), {item:271802} (one-handed mace: Strength, Stamina, Agility) or {item:271805} (off-hand: Spirit, Intellect, Stamina). The quest costs the Magram 30,000."] = "Según los datos de la misión: {npc:5601} (nivel 37) dirige a los Magram desde el lado oeste de {area:604}, al noreste de {npc:253177}. La aldea es hostil con un amigo de los Gelkis, y dos necrokhans Magram, élite y de nivel 45, están un poco al oeste del khan. {npc:5397} paga 6,000, un título y a elegir una de tres armas raras de nivel 35: {item:271801} (hacha de dos manos: fuerza, aguante, agilidad), {item:271802} (maza de una mano: fuerza, aguante, agilidad) o {item:271805} (mano izquierda: espíritu, intelecto, aguante). La misión le cuesta 30,000 a los Magram.",

	-- Step 22: Gelkis: totems to Exalted
	["Gelkis: totems to Exalted"] = "Gelkis: tótems hasta Exaltado",
	-- {quest:92812} Economic Warfare
	["From Revered on only {quest:92812} is left: Revered to Exalted is 21,000, 28 turn-ins, 140 totems. Nothing is sold for standing; the recipes below need only totems."] = "Desde Reverenciado solo queda {quest:92812}: de Reverenciado a Exaltado son 21.000, 28 entregas, 140 tótems. No se vende nada por reputación; las recetas de abajo solo piden tótems.",

	-- Step 23: Gelkis done
	["Gelkis done"] = "Gelkis completado",
	["No Gelkis quests done: on to the Magram, south-east."] = "Ninguna misión de los Gelkis completada: sigue con los Magram, al sureste.",

	-- Step 24: Magram Village: Warug and Gorhak
	-- {area:604} Magram Village · {npc:5398} Warug · {npc:253139} Gorhak
	["{area:604}: {npc:5398} and {npc:253139}"] = "{area:604}: {npc:5398} y {npc:253139}",
	-- {area:604} Magram Village · {zone:1443} Desolace · {npc:5398} Warug · {npc:253139} Gorhak
	["{area:604} fills the valley of south-east {zone:1443}; {npc:5398} stands on its north side, {npc:253139}, the Magram quartermaster, near the lake. Buying Friendship alone takes you from Neutral to Friendly."] = "{area:604} llena el valle del sureste de {zone:1443}; {npc:5398} está en su lado norte, y {npc:253139}, el intendente Magram, cerca del lago. Comprar amistad por sí sola te lleva de Neutral a Amistoso.",

	-- Step 25: Magram: the Kolkar camps
	["Magram: the Kolkar camps"] = "Magram: los campamentos Kolkar",
	-- {area:608} Nijel's Point
	["The Kolkar centaurs (level 30-33) hold the camps south of {area:608}."] = "Los centauros Kolkar (nivel 30-33) ocupan los campamentos al sur de {area:608}.",

	-- Step 26: Magram: Broken Tears
	-- {quest:1369} Broken Tears
	["Magram: {quest:1369}"] = "Magram: {quest:1369}",
	-- {area:606} Gelkis Village
	["The Tears of Theradras are crystals in the cave behind {area:606}, in the south-west. Every Gelkis you kill on the way pays the Magram 20."] = "Las Lágrimas de Theradras son cristales en la cueva detrás de {area:606}, en el suroeste. Cada Gelkis que mates por el camino paga 20 a los Magram.",
	-- {quest:1369} Broken Tears · {object:22246} Tear of Theradras
	["{quest:1369}: the {object:22246} crystals"] = "{quest:1369}: los cristales {object:22246}",
	-- {npc:4648} Gelkis Stamper
	["{npc:4648}: 20 Magram"] = "{npc:4648}: 20 Magram",
	-- {npc:4649} Gelkis Windchaser
	["{npc:4649}: 20 Magram"] = "{npc:4649}: 20 Magram",

	-- Step 27: Magram: Gizmo for Warug
	-- {quest:1371} Gizmo for Warug
	["Magram: {quest:1371}"] = "Magram: {quest:1371}",
	-- {npc:5398} Warug · {item:4392} Advanced Target Dummy · {item:4234} Heavy Leather · {item:4389} Gyrochronatom · {item:4382} Bronze Framework · {item:4387} Iron Strut · {item:269900} Centaur Banner Deployment Device · {item:269902} Hoof-Shaped Foot Pedal
	["{npc:5398} wants an {item:4392}: engineers make it (4 {item:4234}, a {item:4389}, a {item:4382} and an {item:4387}); others buy one. It pays 1,000 and a choice of two engineering schematics, the {item:269900} or the {item:269902}."] = "{npc:5398} quiere un {item:4392}: lo fabrican los ingenieros (4 {item:4234}, un {item:4389}, un {item:4382} y un {item:4387}); los demás lo compran. Paga 1.000 y a elegir entre dos esquemas de ingeniería, el {item:269900} o el {item:269902}.",
	-- {item:4392} Advanced Target Dummy
	["{item:4392}: made by engineers, or bought"] = "{item:4392}: hecho por ingenieros, o comprado",

	-- Step 28: Magram: totems and kills to Honored
	["Magram: totems and kills to Honored"] = "Magram: tótems y muertes hasta Honorable",
	-- {quest:1371} Gizmo for Warug · {npc:253139} Gorhak · {quest:92811} Economic Warfare · {quest:93224} Carved Centaur Totems · {zone:1443} Desolace · {npc:5398} Warug · {quest:92743} A Conqueror's Crown · {item:254392} Conqueror's Helm · {zone:1418} Badlands · {quest:92841} Valley of Bones
	-- plural, as words: Greater Shadow Protection Potions = {item:13459} Greater Shadow Protection Potion · Massive Iron Axes = {item:3855} Massive Iron Axe
	["Friendly to Honored is 6,000; after the clan's quests you are about 3,000 into it (4,000 with {quest:1371}), so 2,000 to 3,000 to go. {npc:253139}'s {quest:92811} takes 5 {quest:93224} for 750, again and again; the Maraudine centaurs (level 36-40) of western {zone:1443} drop them, and the totems do not bind, so the auction house is the other source. Gelkis kills add 20 each, but Forever's kill data stops them at the end of Friendly, 1 short of Honored. At Friendly the village has two craft orders for 1,000 each: Mirda's 3 Greater Shadow Protection Potions and Grolkar's 2 Massive Iron Axes (blacksmithing). {npc:5398}'s {quest:92743} (1,000) is no craft order: he wants a {item:254392} from a crypt in the {zone:1418}, and Forever's quest pages put it in his chain before the {quest:92841}, so bring it before you reach Honored. Legacy Diplomat adds up to 10%."] = "De Amistoso a Honorable hay 6000; después de las misiones del clan llevas unos 3000 (4000 con {quest:1371}), así que faltan de 2000 a 3000. {quest:92811} de {npc:253139} pide 5 {quest:93224} por 750, una y otra vez; los centauros Maraudine (nivel 36-40) del oeste de {zone:1443} los sueltan, y los tótems no se ligan, así que la casa de subastas es la otra fuente. Las muertes de Gelkis suman 20 cada una, pero los datos de muertes de Forever las detienen al final de Amistoso, a 1 de Honorable. En Amistoso, el poblado tiene dos encargos de fabricación de 1000 cada uno: las 3 Pociones de Protección contra las Sombras superiores de Mirda y las 2 Hachas de hierro macizo de Grolkar (herrería). {quest:92743} de {npc:5398} (1000) no es un encargo de fabricación: quiere un {item:254392} de una cripta de {zone:1418}, y las páginas de misiones de Forever lo ponen en su cadena antes de {quest:92841}, así que llévaselo antes de llegar a Honorable. Diplomático, del Legado, añade hasta un 10%.",

	-- Step 29: Magram: Warug sends you to the valley
	-- {npc:5398} Warug
	["Magram: {npc:5398} sends you to the valley"] = "Magram: {npc:5398} te manda al valle",
	-- {quest:92743} A Conqueror's Crown · {npc:5398} Warug · {npc:253136} Orgrul · {area:604} Magram Village · {quest:92841} Valley of Bones · {quest:92811} Economic Warfare
	["At Honored and level 35, after {quest:92743}, {npc:5398} sends you to {npc:253136} at the south end of {area:604}, the northern mouth of the {quest:92841}. The valley steps follow Forever's quest data: nobody who records their play has done these quests yet, so a spot or the order may be off. Every valley quest asks you to stay Honored with the Magram, and each costs the Gelkis five times what it pays. Honored to Revered is 12,000; the valley pays 11,125 of it, {quest:92811} the rest."] = "Con Honorable y nivel 35, después de {quest:92743}, {npc:5398} te manda con {npc:253136} en el extremo sur de {area:604}, la boca norte de {quest:92841}. Los pasos del valle siguen los datos de misiones de Forever: nadie que registre su juego ha hecho todavía estas misiones, así que un lugar o el orden pueden no ser exactos. Cada misión del valle te pide seguir en Honorable con los Magram, y cada una le cuesta a los Gelkis cinco veces lo que paga. De Honorable a Reverenciado hay 12000; el valle paga 11125, {quest:92811} el resto.",

	-- Step 30: Magram: Orgrul
	-- {npc:253136} Orgrul
	["Magram: {npc:253136}"] = "Magram: {npc:253136}",
	-- {npc:253136} Orgrul · {quest:92846} Outcast Necromancers
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager
	["From the quest data: {npc:253136} wants bones from the valley's Undead Ravagers (the quest log counts them in hundreds) and six {quest:92846} dead: Gelkis exiles meddling with the Magram's new magic."] = "Según los datos de la misión: {npc:253136} quiere huesos de los devastadores no-muertos del valle (el registro de misiones los cuenta por cientos) y seis {quest:92846} muertos: exiliados Gelkis que se meten con la nueva magia de los Magram.",

	-- Step 31: Magram: the valley's mouth
	["Magram: the valley's mouth"] = "Magram: la boca del valle",
	-- {quest:92846} Outcast Necromancers · {npc:253136} Orgrul · {npc:253177} Nerlokh
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager
	["From the quest data: the Undead Ravagers and the {quest:92846} fill the valley from {npc:253136} south-west to {npc:253177}'s post at its western mouth; players have met them all along it. {npc:253177} is a Gelkis scout. Corpsefeeders, elite and level 45, walk the valley and attack anyone."] = "Según los datos de la misión: los devastadores no-muertos y {quest:92846} llenan el valle desde {npc:253136} al suroeste hasta el puesto de {npc:253177} en su boca oeste; los jugadores los han encontrado a todo lo largo. {npc:253177} es un explorador Gelkis. Los Corpsefeeders, élite y de nivel 45, recorren el valle y atacan a cualquiera.",
	-- plural, as words: Gently Cursed Bones = {item:254663} Gently Cursed Bone · Undead Ravagers = {npc:11561} Undead Ravager
	["Gently Cursed Bones: Undead Ravagers"] = "Huesos levemente malditos: devastadores no-muertos",

	-- Step 32: Magram: Corrupting Tears
	-- {quest:92847} Corrupting Tears
	["Magram: {quest:92847}"] = "Magram: {quest:92847}",
	-- {npc:253136} Orgrul · {item:254841} Petrified Bark · {item:254840} Imbued Tears · {npc:5398} Warug
	["From the quest data: {npc:253136} wants three {item:254841} from the valley's accursed trees (the game's data has no spot for them) and three {item:254840}: {npc:5398} keeps the crystals you took from the Gelkis, so ask him."] = "Según los datos de la misión: {npc:253136} quiere tres {item:254841} de los árboles malditos del valle (los datos del juego no tienen un lugar para ellos) y tres {item:254840}: {npc:5398} guarda los cristales que les quitaste a los Gelkis, así que pídeselos.",
	-- {item:254841} Petrified Bark
	["{item:254841}: the valley's accursed trees"] = "{item:254841}: los árboles malditos del valle",

	-- Step 33: Magram: Proof of Concept
	-- {quest:92873} Proof of Concept
	["Magram: {quest:92873}"] = "Magram: {quest:92873}",
	-- {npc:253136} Orgrul · {item:254870} Rudimentary Necromancy Staff
	-- plural, as words: Nascent Undead Ravagers = {npc:253360} Nascent Undead Ravager · Well Cursed Bones = {item:254842} Well Cursed Bone
	["From the quest data: {npc:253136} gives you a {item:254870}. He laid out two skeletons on the hill just east of his post: put the staff to use there, and the Nascent Undead Ravagers give the Well Cursed Bones."] = "Según los datos de la misión: {npc:253136} te da un {item:254870}. Dejó dos esqueletos en la colina justo al este de su puesto: usa ahí el bastón, y los devastadores no-muertos nacientes dan los huesos bien malditos.",
	-- plural, as words: Well Cursed Bones = {item:254842} Well Cursed Bone · Nascent Undead Ravagers = {npc:253360} Nascent Undead Ravager
	["Well Cursed Bones: Nascent Undead Ravagers"] = "Huesos bien malditos: devastadores no-muertos nacientes",

	-- Step 34: Magram: Orgrul's next tasks
	-- {npc:253136} Orgrul
	["Magram: {npc:253136}'s next tasks"] = "Magram: las siguientes tareas de {npc:253136}",
	-- {npc:253136} Orgrul · {item:271796} Blade of the Magram Clan · {item:271797} Staff of Revelations · {item:271798} Desperate Barrier
	["From the quest data: {npc:253136} pays 500 and your pick of three items for level 35: {item:271796} (one-handed sword), {item:271797} (staff) or {item:271798} (shield)."] = "Según los datos de la misión: {npc:253136} paga 500 y a elegir uno de tres objetos de nivel 35: {item:271796} (espada de una mano), {item:271797} (bastón) o {item:271798} (escudo).",

	-- Step 35: Magram: the heart of the valley
	["Magram: the heart of the valley"] = "Magram: el corazón del valle",
	-- {npc:253136} Orgrul · {npc:253446} Haggard Bones
	-- plural, as words: Gelkis Captives = {npc:253431} Gelkis Captive · Magram Necrokhans = {npc:253274} Magram Necrokhan
	["From the quest data: south-east of {npc:253136}, in the heart of the valley, the Magram keep Gelkis Captives: kill five. The {npc:253446} there are failed summons stuck in the ground: raise ten with the Enhanced Necromancy Staff Orgrul gave you, and kill the ones that fight back. Corpsefeeders, elite and level 45, walk the valley and attack anyone; the Magram Necrokhans, elite too, leave a friend of the Magram alone."] = "Según los datos de la misión: al sureste de {npc:253136}, en el corazón del valle, los Magram retienen cautivos Gelkis: mata a cinco. Los {npc:253446} de ahí son invocaciones fallidas atascadas en el suelo: levanta a diez con el bastón de nigromancia mejorado que te dio Orgrul, y mata a los que se defiendan. Los Corpsefeeders, élite y de nivel 45, recorren el valle y atacan a cualquiera; los necrokhans Magram, también élite, dejan en paz a un amigo de los Magram.",
	-- {npc:253446} Haggard Bones
	["Raise or slay {npc:253446}"] = "Levanta o mata a {npc:253446}",

	-- Step 36: Magram: Bristleback Retreat
	-- {quest:93066} Bristleback Retreat
	["Magram: {quest:93066}"] = "Magram: {quest:93066}",
	-- {npc:253136} Orgrul · {quest:93066} Bristleback Retreat
	["From the quest data: back to {npc:253136}, then east to {quest:93066} for his next order."] = "Según los datos de la misión: de vuelta con {npc:253136}, luego al este a {quest:93066} por su siguiente orden.",

	-- Step 37: Magram: the quilboar
	["Magram: the quilboar"] = "Magram: los jabaespines",
	-- {quest:93066} Bristleback Retreat · {npc:253527} Kog'thug the Brave · {npc:255678} Quolga the Wise · {npc:253851} Hagiak · {area:16675} Magram Front
	["From the quest data: the Bristleback quilboar hold {quest:93066}, east of the valley. {npc:253527} (elite, level 43) and {npc:255678} (elite, level 42) lead them: leave those two be. Then report to {npc:253851} at the {area:16675}, south of the Retreat."] = "Según los datos de la misión: los jabaespines Lomopelo ocupan {quest:93066}, al este del valle. {npc:253527} (élite, nivel 43) y {npc:255678} (élite, nivel 42) los dirigen: déjalos en paz. Luego preséntate con {npc:253851} en {area:16675}, al sur del Refugio.",

	-- Step 38: Magram: Hagiak at the Magram Front
	-- {npc:253851} Hagiak · {area:16675} Magram Front
	["Magram: {npc:253851} at the {area:16675}"] = "Magram: {npc:253851} en {area:16675}",
	-- {npc:253851} Hagiak · {area:16676} Outcast Hideaway
	["From the quest data: {npc:253851} sends you south-west to the {area:16676}, the exiles' camp west of the Shen'dralar town."] = "Según los datos de la misión: {npc:253851} te manda al suroeste a {area:16676}, el campamento de los exiliados al oeste del pueblo Shen'dralar.",

	-- Step 39: Magram: the Outcast Hideaway
	-- {area:16676} Outcast Hideaway
	["Magram: the {area:16676}"] = "Magram: {area:16676}",
	-- {item:256892} Stolen Supplies · {quest:92846} Outcast Necromancers · {npc:253136} Orgrul · {npc:253177} Nerlokh
	-- plural, as words: Outcast Scouts = {npc:254283} Outcast Scout · Outcast Necrokhans = {npc:253275} Outcast Necrokhan
	["From the quest data: Outcast Scouts and Marauders hold the hideaway, with Outcast Necrokhans, elite and level 45, among them. The {item:256892} are crates in its west. The quest wants {quest:92846} here too; players have met them only in the valley between {npc:253136} and {npc:253177} so far, so take them there if the hideaway has none."] = "Según los datos de la misión: los exploradores y merodeadores exiliados ocupan el escondite, con necrokhans exiliados, élite y de nivel 45, entre ellos. {item:256892} son cajas en su lado oeste. La misión también pide {quest:92846} aquí; hasta ahora los jugadores solo los han encontrado en el valle entre {npc:253136} y {npc:253177}, así que mátalos ahí si en el escondite no hay.",
	-- {item:256892} Stolen Supplies
	["{item:256892}: crates"] = "{item:256892}: cajas",

	-- Step 40: Magram: back to Hagiak
	-- {npc:253851} Hagiak
	["Magram: back to {npc:253851}"] = "Magram: de vuelta con {npc:253851}",

	-- Step 41: Magram: Orgrul's ritual
	-- {npc:253136} Orgrul
	["Magram: {npc:253136}'s ritual"] = "Magram: el ritual de {npc:253136}",
	-- {quest:93196} Khan Jehn · {npc:253136} Orgrul
	["From the quest data: {quest:93196} has been slain by outsiders working for the Gelkis, and {npc:253136} means to raise him."] = "Según los datos de la misión: {quest:93196} fue asesinado por forasteros que trabajan para los Gelkis, y {npc:253136} piensa levantarlo.",

	-- Step 42: Magram: Khan Jehn
	-- {quest:93196} Khan Jehn
	["Magram: {quest:93196}"] = "Magram: {quest:93196}",
	-- {item:257517} Ultimate Necromancy Staff · {area:604} Magram Village · {quest:93196} Khan Jehn · {item:271800} Scavenged Magram Armament · {item:271803} Greatstaff of the Necrokhans · {item:271804} Soulsplatter Mace
	["From the quest data: take the {item:257517} to the ritual site, a tent by the lake in the middle of {area:604}, and raise {quest:93196}. The risen khan takes the quest: 6,000, a title, and your pick of three rare level 35 weapons: {item:271800} (polearm: Stamina, attack power, Agility), {item:271803} (staff: Intellect, Stamina, Spirit) or {item:271804} (main-hand mace: Intellect, Stamina, Spirit). The quest costs the Gelkis 30,000."] = "Según los datos de la misión: lleva el {item:257517} al sitio del ritual, una tienda junto al lago en medio de {area:604}, y levanta a {quest:93196}. El khan resucitado recibe la misión: 6,000, un título y a elegir una de tres armas raras de nivel 35: {item:271800} (arma de asta: aguante, poder de ataque, agilidad), {item:271803} (bastón: intelecto, aguante, espíritu) o {item:271804} (maza de mano derecha: intelecto, aguante, espíritu). La misión le cuesta 30,000 a los Gelkis.",
	-- {quest:93196} Khan Jehn
	["raise {quest:93196} at the tent by the lake"] = "levanta a {quest:93196} en la tienda junto al lago",

	-- Step 43: Magram: totems to Exalted
	["Magram: totems to Exalted"] = "Magram: tótems hasta Exaltado",
	-- {quest:92811} Economic Warfare
	["From Revered on only {quest:92811} is left: Revered to Exalted is 21,000, 28 turn-ins, 140 totems."] = "Desde Reverenciado solo queda {quest:92811}: de Reverenciado a Exaltado son 21.000, 28 entregas, 140 tótems.",

	-- Step 44: The totem recipes
	["The totem recipes"] = "Las recetas de tótems",
	-- {quest:93224} Carved Centaur Totems · {item:273613} Enchant Bracer - Lesser Agility · {item:250941} Greater Frenzy Potion · {item:250538} Hard Gold Gauntlet · {item:250606} Iron Morningstar · {item:252462} Mystic Thick Armor Kit · {item:253973} Silk Reagent Bag · {item:10011} Stormcloth Gloves · {item:274490} Centaur Hoofwarmers · {item:269900} Centaur Banner Deployment Device · {item:269902} Hoof-Shaped Foot Pedal
	["Both quartermasters sell the same 12 recipes for {quest:93224}, no standing needed: {item:273613} and - Lesser Healing Power; Greater Spellblasting and {item:250941}; {item:250538} and {item:250606} plans; {item:252462}, {item:253973}, {item:10011} and {item:274490} patterns; the {item:269900} and {item:269902} schematics. Keep the totems you need for them before you hand the rest in."] = "Ambos intendentes venden las mismas 12 recetas por {quest:93224}, sin necesidad de reputación: {item:273613} y poder de sanación inferior; Hechicería explosiva superior y {item:250941}; diseños de {item:250538} y {item:250606}; patrones de {item:252462}, {item:253973}, {item:10011} y {item:274490}; los esquemas de {item:269900} y {item:269902}. Guarda los tótems que necesites para ellas antes de entregar el resto.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At Honored, and after {quest:92743}, {npc:5398} sends you to {npc:253136} at the northern entrance of the {quest:92841}, in {zone:2652}. {npc:253136}'s quests (500 each: {quest:92844}, {quest:92846}, Corrupting Tears, Proof of Concept, No Mercy for the Weak, Bone Raising) and Hagiak's at the {area:16675} ({area:16677}, Long-Term Solutions, Threat of Starvation, Return to {npc:253136}) end with {npc:5601}: raise the dead khan with {npc:253136}'s staff at the tent by the lake in {area:604}, for 6,000, a title and a rare level 35 weapon. They all ask you to stay Honored or better. Honored to Revered is 12,000: the valley's quests pay about 11,000 of it, two {quest:92811} turn-ins the rest."] = "En Honorable, y después de {quest:92743}, {npc:5398} te manda con {npc:253136}, en la entrada norte de {quest:92841}, en {zone:2652}. Las misiones de {npc:253136} (500 cada una: {quest:92844}, {quest:92846}, Lágrimas corruptoras, Prueba de concepto, Sin piedad para los débiles, Levantar huesos) y las de Hagiak en {area:16675} ({area:16677}, Soluciones a largo plazo, Amenaza de hambruna, Regreso con {npc:253136}) terminan con {npc:5601}: levanta al kan muerto con el bastón de {npc:253136} en la tienda junto al lago de {area:604}, por 6.000, un título y un arma rara de nivel 35. Todas piden que sigas en Honorable o más. De Honorable a Reverenciado son 12.000: las misiones del valle pagan unos 11.000, y dos entregas de {quest:92811} el resto.",
	-- ["At Honored, {npc:5397} sends you east to {npc:253177} at the southern entrance of the {quest:93034}, in {zone:2652}. {npc:253177}'s quests (500 each) take you among the undead and the outcasts there: {quest:93035}, {quest:93037} and {quest:93041}, then A Cleansing Cry from {npc:5397}, and a second line (Saving Our Own, Bone Burying, Checking Things Out) that ends with {npc:5601}: kill the Magram khan in his own village for 6,000, a title and a rare level 35 weapon. They all ask you to stay Honored or better. Honored to Revered is 12,000: the valley's quests pay about 10,600 of it, two or three {quest:92811} turn-ins the rest."] = "En Honorable, {npc:5397} te manda al este con {npc:253177}, en la entrada sur de {quest:93034}, en {zone:2652}. Las misiones de {npc:253177} (500 cada una) te llevan entre los no-muertos y los proscritos de ahí: {quest:93035}, {quest:93037} y {quest:93041}, luego Un grito purificador de {npc:5397}, y una segunda línea (Salvar a los nuestros, Enterrar huesos, Echar un vistazo) que termina con {npc:5601}: mata al kan Magram en su propia aldea por 6.000, un título y un arma rara de nivel 35. Todas piden que sigas en Honorable o más. De Honorable a Reverenciado son 12.000: las misiones del valle pagan unos 10.600, y dos o tres entregas de {quest:92811} el resto.",
	-- ["Gelkis: the {quest:93034}"] = "Gelkis: {quest:93034}",
	-- ["Magram: the {quest:92841}"] = "Magram: {quest:92841}",
	-- ["The ritual site is a tent by the lake in the middle of {area:604}. {npc:253136} pays 6,000, a title, and your pick of three rare level 35 weapons: {item:271800} (polearm: Stamina, attack power, Agility), {item:271803} (staff: Intellect, Stamina, Spirit) or {item:271804} (main-hand mace: Intellect, Stamina, Spirit)."] = "El lugar del ritual es una tienda junto al lago, en medio de {area:604}. {npc:253136} paga 6.000, un título y a elegir entre tres armas raras de nivel 35: {item:271800} (arma de asta: Aguante, poder de ataque, Agilidad), {item:271803} (bastón: Intelecto, Aguante, Espíritu) o {item:271804} (maza de mano derecha: Intelecto, Aguante, Espíritu).",
	-- ["{npc:5601} (level 37) leads the Magram from the west side of {area:604}, with his bodyguards. The kill costs the Magram 500. {npc:5397} pays 6,000, a title, and your pick of three rare level 35 weapons: {item:271801} (two-handed axe: Strength, Stamina, Agility), {item:271802} (one-handed mace: Strength, Stamina, Agility) or {item:271805} (off-hand: Spirit, Intellect, Stamina)."] = "{npc:5601} (nivel 37) dirige a los Magram desde el lado oeste de {area:604}, con sus guardaespaldas. Matarlo cuesta 500 con los Magram. {npc:5397} paga 6.000, un título y a elegir entre tres armas raras de nivel 35: {item:271801} (hacha a dos manos: Fuerza, Aguante, Agilidad), {item:271802} (maza a una mano: Fuerza, Aguante, Agilidad) o {item:271805} (mano izquierda: Espíritu, Intelecto, Aguante).",
}
