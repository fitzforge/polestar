-- Spanish (Spain) (esES): the guide forever/reputation/centaur-clans (forever/reputation/centaur-clans.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Gelkis and Magram Centaur Reputation"] = "",
	-- {zone:1443} Desolace
	["{zone:1443}'s feuding clans, reworked in Forever: pick one, buy its friendship, and trade totems for recipes."] = "",
	-- {quest:93224} Carved Centaur Totems
	["12 recipes for {quest:93224} at the clan quartermasters, no standing needed"] = "12 recetas por {quest:93224} en los intendentes de los clanes, sin necesidad de reputación",
	-- {npc:5601} Khan Jehn
	["{npc:5601}'s quest: a clan title and a choice of three rare level 35 weapons"] = "",

	-- Step 1: Pick your clan
	["Pick your clan"] = "",
	-- {zone:1443} Desolace · {npc:5396} Captain Pentigast · {area:608} Nijel's Point · {quest:1382} Strange Alliance · {quest:1385} Brutal Politics · {npc:5412} Gurda Wildmane · {quest:1368} Gelkis Alliance · {quest:1367} Magram Alliance · {quest:93224} Carved Centaur Totems
	["The Gelkis (south-west {zone:1443}) and the Magram (south-east) are at war: every kill of one clan gives the other 20 and costs its own clan 100, and every quest of one clan costs the other five times what it pays (Buying Friendship: 3,000 for yours, 15,000 off the other), so you can only climb with one. Both start Neutral. Forever's quests are worth far more than kills now. Alliance: {npc:5396} at {area:608} offers {quest:1382} (Gelkis) and {quest:1385} (Magram). Horde: {npc:5412} offers {quest:1368} and {quest:1367}. Take the one of your clan, and {quest:93224}: each clan's Buying Friendship (3,000) is offered once you bring the totems back. Then tick the task. The guide goes on with the Gelkis; take the Magram's quests instead and it goes to the Magram half. Forever pays these quests in full at any level."] = "",
	-- {quest:1382} Strange Alliance
	["{quest:1382}: Gelkis"] = "",
	["Take the quests of one clan"] = "",

	-- Step 2: Carved Centaur Totems
	-- {area:608} Nijel's Point
	["The Kolkar centaurs (level 30-33) in the camps along the eastern road, south of {area:608}, drop the totems, and so do the Magram and the Maraudine. Bring five back, then take your clan's Buying Friendship (Gelkis below; the Magram's instead for the Magram)."] = "Los centauros Kolkar (nivel 30-33) de los campamentos junto al camino del este, al sur de {area:608}, sueltan los tótems, y también los Magram y los Maraudine. Trae cinco y luego acepta la «Buying Friendship» de tu clan (la de los Gelkis, abajo; la de los Magram si vas con los Magram).",
	-- {item:254432} Carved Centaur Totem
	["{item:254432}: Kolkar centaurs"] = "{item:254432}: centauros Kolkar",

	-- Step 3: Gelkis or Magram
	["Gelkis or Magram"] = "Gelkis o Magram",
	["No clan's quests in your log: the guide goes on with the Gelkis. For the Magram, take their choice quest and Buying Friendship and the guide goes to the Magram half."] = "Ninguna misión de clan en tu registro: la guía sigue con los Gelkis. Para los Magram, acepta su misión de elección y «Buying Friendship», y la guía pasa a la mitad de los Magram.",

	-- Step 4: Gelkis: the choice quest
	["Gelkis: the choice quest"] = "Gelkis: la misión de elección",
	-- {npc:5397} Uthek the Wise · {area:606} Gelkis Village
	["The Gelkis half starts with the clan's choice quest from the giver you just handed the totems to: {npc:5397}'s quests in {area:606} follow from it, and Buying Friendship alone does not open them."] = "La mitad de los Gelkis empieza con la misión de elección del clan del asignador de misiones al que acabas de entregar los tótems: de ella vienen las misiones de {npc:5397} en {area:606}, y «Buying Friendship» por sí sola no las abre.",

	-- Step 5: Gelkis Village: Uthek the Wise and Molkar
	-- {area:606} Gelkis Village · {npc:5397} Uthek the Wise · {npc:253140} Molkar
	["{area:606}: {npc:5397} and {npc:253140}"] = "",
	-- {area:606} Gelkis Village · {zone:1443} Desolace · {npc:5397} Uthek the Wise · {npc:253140} Molkar
	["{area:606} sits in the hills of south-west {zone:1443}; {npc:5397} stands at its heart. {npc:253140}, the Gelkis quartermaster, is at the south end of the village. Buying Friendship alone takes you from Neutral to Friendly."] = "",

	-- Step 6: Gelkis: the Kolkar camps
	["Gelkis: the Kolkar camps"] = "",
	-- {area:608} Nijel's Point · {item:6079} Crude Charm
	["The Kolkar centaurs (level 30-33) hold the camps south of {area:608}, along the eastern road. About one in four drops a {item:6079}."] = "",
	-- {item:6079} Crude Charm
	["{item:6079}: Kolkar centaurs"] = "",

	-- Step 7: Gelkis: Magram Village
	-- {area:604} Magram Village
	["Gelkis: {area:604}"] = "",
	-- {area:604} Magram Village
	["The Sacks of Meat lie about {area:604}, in the south-east. Every Magram you kill on the way pays the Gelkis 20."] = "",
	-- {item:6069} Crudely Dried Meat
	["{item:6069}: Sacks of Meat"] = "",
	-- {npc:4640} Magram Wrangler
	["{npc:4640}: 20 Gelkis"] = "",
	-- {npc:4641} Magram Windchaser
	["{npc:4641}: 20 Gelkis"] = "",

	-- Step 8: Gelkis: Ongeku
	-- {quest:1373} Ongeku
	["Gelkis: {quest:1373}"] = "",
	-- {npc:5397} Uthek the Wise · {zone:1435} Swamp of Sorrows · {quest:1373} Ongeku · {area:76} Fallow Sanctuary · {area:75} Stonard
	["Back to {npc:5397}, then east to the {zone:1435}: {quest:1373} (level 37) waits by a black cauldron in {area:76}, north-east of {area:75}."] = "",

	-- Step 9: Gelkis: totems and kills to Honored
	["Gelkis: totems and kills to Honored"] = "",
	-- {npc:253140} Molkar · {quest:92812} Economic Warfare · {quest:93224} Carved Centaur Totems · {zone:1443} Desolace · {item:10008} White Bandit Mask · {item:5739} Barbaric Harness
	-- plural, as words: Greater Mystic Essences = {item:11135} Greater Mystic Essence
	["Friendly to Honored is 6,000; after the clan's quests you are about 4,000 into it, so 2,000 to go. {npc:253140}'s {quest:92812} takes 5 {quest:93224} for 750, again and again: three turn-ins, 15 totems. The Maraudine centaurs (level 36-40) of western {zone:1443} drop them; the totems do not bind, so the auction house is the other source. Magram kills add 20 each, but Forever's kill data stops them at the end of Friendly, 1 short of Honored. At Friendly the village also has three craft orders for 1,000 each: Halea wants 3 Greater Mystic Essences, {npc:253140} a {item:10008} (tailoring) and Talra a {item:5739} (leatherworking). Legacy Diplomat adds up to 10%."] = "De Amistoso a Honorable hay 6000; tras las misiones del clan llevas unos 4000, así que faltan 2000. {quest:92812} de {npc:253140} pide 5 {quest:93224} por 750, una y otra vez: tres entregas, 15 tótems. Los centauros Maraudine (nivel 36-40) del oeste de {zone:1443} los sueltan; los tótems no se ligan, así que la casa de subastas es la otra fuente. Las muertes de Magram suman 20 cada una, pero los datos de muertes de Forever las detienen al final de Amistoso, a 1 de Honorable. En Amistoso, el poblado también tiene tres encargos de fabricación de 1000 cada uno: Halea quiere 3 Esencias místicas superiores, {npc:253140} una {item:10008} (sastrería) y Talra un {item:5739} (peletería). Estudio dedicado, del Legado, añade hasta un 10%.",
	-- {item:254432} Carved Centaur Totem
	["{item:254432}: Maraudine centaurs"] = "",

	-- Step 10: Gelkis: Uthek the Wise sends you to the valley
	-- {npc:5397} Uthek the Wise
	["Gelkis: {npc:5397} sends you to the valley"] = "",
	-- {npc:5397} Uthek the Wise · {npc:253177} Nerlokh · {quest:93034} Valley of Bones · {zone:1443} Desolace · {zone:2652} Shen'dralas · {quest:92811} Economic Warfare
	["At Honored and level 35, {npc:5397} sends you east to {npc:253177}, a Gelkis scout at the western mouth of the {quest:93034}, where the south of {zone:1443} runs into {zone:2652}. The valley steps follow Forever's quest data: nobody who records their play has done these quests yet, so a spot or the order may be off. Every valley quest asks you to stay Honored with the Gelkis, and each costs the Magram five times what it pays. Honored to Revered is 12,000; the valley pays 10,625 of it, {quest:92811} the rest."] = "",

	-- Step 11: Gelkis: Nerlokh
	-- {npc:253177} Nerlokh
	["Gelkis: {npc:253177}"] = "",
	-- {npc:253177} Nerlokh · {npc:11559} Outcast Necromancer
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager
	["From the quest data: {npc:253177} waits at the valley's western mouth. He wants six Undead Ravagers put to rest and the ritual garb of an {npc:11559}: the outcasts are Gelkis exiles who took up the Magram's necromancy."] = "",

	-- Step 12: Gelkis: the valley's mouth
	["Gelkis: the valley's mouth"] = "",
	-- {quest:92846} Outcast Necromancers · {npc:253177} Nerlokh · {npc:253136} Orgrul
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager
	["From the quest data: the Undead Ravagers and the {quest:92846} fill the valley from {npc:253177} north-east to {npc:253136}'s post at its northern mouth; players have met them all along it. {npc:253136}'s Magram are hostile to a friend of the Gelkis. Corpsefeeders, elite and level 45, walk the valley and attack anyone."] = "",

	-- Step 13: Gelkis: Facing the Truth
	-- {quest:93041} Facing the Truth
	["Gelkis: {quest:93041}"] = "",
	-- {npc:253177} Nerlokh · {item:255941} Gelkis Necromantic Garb · {npc:5397} Uthek the Wise · {item:255945} Accursed Skull
	["From the quest data: {npc:253177} gives you a {item:255941} to show {npc:5397}, with an {item:255945} you find yourself: a freshly cursed skull, hoarded in the jaws of one of the valley's giant skeletons. The game's data has no spot for it."] = "",
	-- {item:255945} Accursed Skull
	["{item:255945}: in a giant skeleton's jaws"] = "",

	-- Step 14: Gelkis: Uthek the Wise and Mulara
	-- {npc:5397} Uthek the Wise · {npc:253713} Mulara
	["Gelkis: {npc:5397} and {npc:253713}"] = "",
	-- {npc:5397} Uthek the Wise · {area:606} Gelkis Village · {npc:253713} Mulara · {npc:253140} Molkar · {quest:92812} Economic Warfare
	["From the quest data: back west to {npc:5397} in {area:606}. She needs Tears of Theradras: {npc:253713}, the Voice of Theradras, keeps them in the cave in the south of the village, past {npc:253140}. Ask her for them on {npc:5397}'s behalf and bring three back. {npc:253140} takes {quest:92812} on the way."] = "",
	-- {npc:253713} Mulara
	["{npc:253713}, in the cave"] = "",
	["three Tears of Theradras"] = "",

	-- Step 15: Gelkis: Test Your Theory
	-- {quest:93045} Test Your Theory
	["Gelkis: {quest:93045}"] = "",
	-- {npc:5397} Uthek the Wise · {item:6071} Draenethyst Crystal · {item:256061} Uthek's Draenethyst Staff · {item:255945} Accursed Skull · {npc:253177} Nerlokh
	["From the quest data: {npc:5397} gives you her staff and a {item:6071}. Put them together into {item:256061}, take it to the ritual site by the pond just east of the village and dispel the curse on the {item:255945}. Then east again to {npc:253177}."] = "",
	-- {item:255945} Accursed Skull
	["dispel the {item:255945} by the pond"] = "",

	-- Step 16: Gelkis: back to Nerlokh
	-- {npc:253177} Nerlokh
	["Gelkis: back to {npc:253177}"] = "",
	-- {npc:253177} Nerlokh · {item:271794} Centaur Spear · {item:271795} Wanderer's Broadsword · {item:271799} Desert Crawler's Claw
	["From the quest data: {npc:253177} pays 500 and your pick of three weapons for level 35: {item:271794} (polearm), {item:271795} (two-handed sword) or {item:271799} (dagger). Then he has two jobs deeper in the valley."] = "",

	-- Step 17: Gelkis: the heart of the valley
	["Gelkis: the heart of the valley"] = "",
	-- {npc:253177} Nerlokh · {npc:253446} Haggard Bones · {item:256061} Uthek's Draenethyst Staff
	-- plural, as words: Gelkis Captives = {npc:253431} Gelkis Captive · Magram Necrokhans = {npc:253274} Magram Necrokhan
	["From the quest data: east of {npc:253177}, in the heart of the valley, the Magram hold Gelkis Captives: free five. Among them lie {npc:253446}, failed summons stuck in the ground: lay eight to rest with {item:256061}, which the quest gives you. Corpsefeeders and Magram Necrokhans, elite and level 45, walk the valley and attack a friend of the Gelkis: let them pass before you pull."] = "",
	-- {npc:253446} Haggard Bones
	["Lay {npc:253446} to rest"] = "",
	-- plural, as words: Gelkis Captives = {npc:253431} Gelkis Captive
	["free five Gelkis Captives"] = "",

	-- Step 18: Gelkis: Checking Things Out
	-- {quest:93122} Checking Things Out
	["Gelkis: {quest:93122}"] = "",
	-- {npc:253177} Nerlokh · {zone:2652} Shen'dralas · {area:16675} Magram Front · {area:16676} Outcast Hideaway
	["From the quest data: {npc:253177}'s next order takes you deeper into {zone:2652} to scout two places: the {area:16675}, a Magram camp south-east of the valley, and the {area:16676}, the exiles' camp west of the Shen'dralar town, further south."] = "",

	-- Step 19: Gelkis: the Magram Front and the Outcast Hideaway
	-- {area:16675} Magram Front · {area:16676} Outcast Hideaway
	["Gelkis: the {area:16675} and the {area:16676}"] = "",
	-- {area:16675} Magram Front · {area:16676} Outcast Hideaway · {npc:254040} Rokren · {npc:253177} Nerlokh
	-- plural, as words: Outcast Necrokhans = {npc:253275} Outcast Necrokhan
	["From the quest data: walk into the Magram camp at the {area:16675}, then south-west into the {area:16676}, where Outcast Necrokhans, elite and level 45, stand guard. In a tent there {npc:254040}, a Gelkis the outcasts hold, asks you to get him out: escort him clear of the hideaway, then tell {npc:253177}."] = "",
	-- {npc:254040} Rokren
	["escort {npc:254040} out of the hideaway"] = "",

	-- Step 20: Gelkis: Nerlokh's last order
	-- {npc:253177} Nerlokh
	["Gelkis: {npc:253177}'s last order"] = "",
	-- {npc:253177} Nerlokh
	["From the quest data: with the Magram's warriors busy at the Front, {npc:253177} sees a chance at their khan."] = "",

	-- Step 21: Gelkis: Khan Jehn
	-- {npc:5601} Khan Jehn
	["Gelkis: {npc:5601}"] = "",
	-- {npc:5601} Khan Jehn · {area:604} Magram Village · {npc:253177} Nerlokh · {npc:5397} Uthek the Wise · {item:271801} Abandoned Ferocity · {item:271802} Bludgeon of Betrayed Virtues · {item:271805} Thrice-Damned Effigy
	-- plural, as words: Magram Necrokhans = {npc:253274} Magram Necrokhan
	["From the quest data: {npc:5601} (level 37) leads the Magram from the west side of {area:604}, north-east of {npc:253177}. The village is hostile to a friend of the Gelkis, and two Magram Necrokhans, elite and level 45, stand a little west of the khan. {npc:5397} pays 6,000, a title, and your pick of three rare level 35 weapons: {item:271801} (two-handed axe: Strength, Stamina, Agility), {item:271802} (one-handed mace: Strength, Stamina, Agility) or {item:271805} (off-hand: Spirit, Intellect, Stamina). The quest costs the Magram 30,000."] = "",

	-- Step 22: Gelkis: totems to Exalted
	["Gelkis: totems to Exalted"] = "",
	-- {quest:92812} Economic Warfare
	["From Revered on only {quest:92812} is left: Revered to Exalted is 21,000, 28 turn-ins, 140 totems. Nothing is sold for standing; the recipes below need only totems."] = "",

	-- Step 23: Gelkis done
	["Gelkis done"] = "Gelkis completado",
	["No Gelkis quests done: on to the Magram, south-east."] = "Ninguna misión de los Gelkis completada: sigue con los Magram, al sureste.",

	-- Step 24: Magram Village: Warug and Gorhak
	-- {area:604} Magram Village · {npc:5398} Warug · {npc:253139} Gorhak
	["{area:604}: {npc:5398} and {npc:253139}"] = "",
	-- {area:604} Magram Village · {zone:1443} Desolace · {npc:5398} Warug · {npc:253139} Gorhak
	["{area:604} fills the valley of south-east {zone:1443}; {npc:5398} stands on its north side, {npc:253139}, the Magram quartermaster, near the lake. Buying Friendship alone takes you from Neutral to Friendly."] = "",

	-- Step 25: Magram: the Kolkar camps
	["Magram: the Kolkar camps"] = "",
	-- {area:608} Nijel's Point
	["The Kolkar centaurs (level 30-33) hold the camps south of {area:608}."] = "",

	-- Step 26: Magram: Broken Tears
	-- {quest:1369} Broken Tears
	["Magram: {quest:1369}"] = "",
	-- {area:606} Gelkis Village
	["The Tears of Theradras are crystals in the cave behind {area:606}, in the south-west. Every Gelkis you kill on the way pays the Magram 20."] = "",
	-- {quest:1369} Broken Tears · {object:22246} Tear of Theradras
	["{quest:1369}: the {object:22246} crystals"] = "",
	-- {npc:4648} Gelkis Stamper
	["{npc:4648}: 20 Magram"] = "",
	-- {npc:4649} Gelkis Windchaser
	["{npc:4649}: 20 Magram"] = "",

	-- Step 27: Magram: Gizmo for Warug
	-- {quest:1371} Gizmo for Warug
	["Magram: {quest:1371}"] = "",
	-- {npc:5398} Warug · {item:4392} Advanced Target Dummy · {item:4234} Heavy Leather · {item:4389} Gyrochronatom · {item:4382} Bronze Framework · {item:4387} Iron Strut · {item:269900} Centaur Banner Deployment Device · {item:269902} Hoof-Shaped Foot Pedal
	["{npc:5398} wants an {item:4392}: engineers make it (4 {item:4234}, a {item:4389}, a {item:4382} and an {item:4387}); others buy one. It pays 1,000 and a choice of two engineering schematics, the {item:269900} or the {item:269902}."] = "",
	-- {item:4392} Advanced Target Dummy
	["{item:4392}: made by engineers, or bought"] = "",

	-- Step 28: Magram: totems and kills to Honored
	["Magram: totems and kills to Honored"] = "",
	-- {quest:1371} Gizmo for Warug · {npc:253139} Gorhak · {quest:92811} Economic Warfare · {quest:93224} Carved Centaur Totems · {zone:1443} Desolace · {npc:5398} Warug · {quest:92743} A Conqueror's Crown · {item:254392} Conqueror's Helm · {zone:1418} Badlands · {quest:92841} Valley of Bones
	-- plural, as words: Greater Shadow Protection Potions = {item:13459} Greater Shadow Protection Potion · Massive Iron Axes = {item:3855} Massive Iron Axe
	["Friendly to Honored is 6,000; after the clan's quests you are about 3,000 into it (4,000 with {quest:1371}), so 2,000 to 3,000 to go. {npc:253139}'s {quest:92811} takes 5 {quest:93224} for 750, again and again; the Maraudine centaurs (level 36-40) of western {zone:1443} drop them, and the totems do not bind, so the auction house is the other source. Gelkis kills add 20 each, but Forever's kill data stops them at the end of Friendly, 1 short of Honored. At Friendly the village has two craft orders for 1,000 each: Mirda's 3 Greater Shadow Protection Potions and Grolkar's 2 Massive Iron Axes (blacksmithing). {npc:5398}'s {quest:92743} (1,000) is no craft order: he wants a {item:254392} from a crypt in the {zone:1418}, and Forever's quest pages put it in his chain before the {quest:92841}, so bring it before you reach Honored. Legacy Diplomat adds up to 10%."] = "De Amistoso a Honorable hay 6000; tras las misiones del clan llevas unos 3000 (4000 con {quest:1371}), así que faltan de 2000 a 3000. {quest:92811} de {npc:253139} pide 5 {quest:93224} por 750, una y otra vez; los centauros Maraudine (nivel 36-40) del oeste de {zone:1443} los sueltan, y los tótems no se ligan, así que la casa de subastas es la otra fuente. Las muertes de Gelkis suman 20 cada una, pero los datos de muertes de Forever las detienen al final de Amistoso, a 1 de Honorable. En Amistoso, el poblado tiene dos encargos de fabricación de 1000 cada uno: las 3 Pociones de protección de las Sombras superiores de Mirda y las 2 Hachas de hierro macizo de Grolkar (herrería). {quest:92743} de {npc:5398} (1000) no es un encargo de fabricación: quiere un {item:254392} de una cripta de {zone:1418}, y las páginas de misiones de Forever lo ponen en su cadena antes de {quest:92841}, así que llévaselo antes de llegar a Honorable. Estudio dedicado, del Legado, añade hasta un 10%.",

	-- Step 29: Magram: Warug sends you to the valley
	-- {npc:5398} Warug
	["Magram: {npc:5398} sends you to the valley"] = "",
	-- {quest:92743} A Conqueror's Crown · {npc:5398} Warug · {npc:253136} Orgrul · {area:604} Magram Village · {quest:92841} Valley of Bones · {quest:92811} Economic Warfare
	["At Honored and level 35, after {quest:92743}, {npc:5398} sends you to {npc:253136} at the south end of {area:604}, the northern mouth of the {quest:92841}. The valley steps follow Forever's quest data: nobody who records their play has done these quests yet, so a spot or the order may be off. Every valley quest asks you to stay Honored with the Magram, and each costs the Gelkis five times what it pays. Honored to Revered is 12,000; the valley pays 11,125 of it, {quest:92811} the rest."] = "",

	-- Step 30: Magram: Orgrul
	-- {npc:253136} Orgrul
	["Magram: {npc:253136}"] = "",
	-- {npc:253136} Orgrul · {quest:92846} Outcast Necromancers
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager
	["From the quest data: {npc:253136} wants bones from the valley's Undead Ravagers (the quest log counts them in hundreds) and six {quest:92846} dead: Gelkis exiles meddling with the Magram's new magic."] = "",

	-- Step 31: Magram: the valley's mouth
	["Magram: the valley's mouth"] = "",
	-- {quest:92846} Outcast Necromancers · {npc:253136} Orgrul · {npc:253177} Nerlokh
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager
	["From the quest data: the Undead Ravagers and the {quest:92846} fill the valley from {npc:253136} south-west to {npc:253177}'s post at its western mouth; players have met them all along it. {npc:253177} is a Gelkis scout. Corpsefeeders, elite and level 45, walk the valley and attack anyone."] = "",
	-- plural, as words: Gently Cursed Bones = {item:254663} Gently Cursed Bone · Undead Ravagers = {npc:11561} Undead Ravager
	["Gently Cursed Bones: Undead Ravagers"] = "",

	-- Step 32: Magram: Corrupting Tears
	-- {quest:92847} Corrupting Tears
	["Magram: {quest:92847}"] = "",
	-- {npc:253136} Orgrul · {item:254841} Petrified Bark · {item:254840} Imbued Tears · {npc:5398} Warug
	["From the quest data: {npc:253136} wants three {item:254841} from the valley's accursed trees (the game's data has no spot for them) and three {item:254840}: {npc:5398} keeps the crystals you took from the Gelkis, so ask him."] = "",
	-- {item:254841} Petrified Bark
	["{item:254841}: the valley's accursed trees"] = "",

	-- Step 33: Magram: Proof of Concept
	-- {quest:92873} Proof of Concept
	["Magram: {quest:92873}"] = "",
	-- {npc:253136} Orgrul · {item:254870} Rudimentary Necromancy Staff
	-- plural, as words: Nascent Undead Ravagers = {npc:253360} Nascent Undead Ravager · Well Cursed Bones = {item:254842} Well Cursed Bone
	["From the quest data: {npc:253136} gives you a {item:254870}. He laid out two skeletons on the hill just east of his post: put the staff to use there, and the Nascent Undead Ravagers give the Well Cursed Bones."] = "",
	-- plural, as words: Well Cursed Bones = {item:254842} Well Cursed Bone · Nascent Undead Ravagers = {npc:253360} Nascent Undead Ravager
	["Well Cursed Bones: Nascent Undead Ravagers"] = "",

	-- Step 34: Magram: Orgrul's next tasks
	-- {npc:253136} Orgrul
	["Magram: {npc:253136}'s next tasks"] = "",
	-- {npc:253136} Orgrul · {item:271796} Blade of the Magram Clan · {item:271797} Staff of Revelations · {item:271798} Desperate Barrier
	["From the quest data: {npc:253136} pays 500 and your pick of three items for level 35: {item:271796} (one-handed sword), {item:271797} (staff) or {item:271798} (shield)."] = "",

	-- Step 35: Magram: the heart of the valley
	["Magram: the heart of the valley"] = "",
	-- {npc:253136} Orgrul · {npc:253446} Haggard Bones
	-- plural, as words: Gelkis Captives = {npc:253431} Gelkis Captive · Magram Necrokhans = {npc:253274} Magram Necrokhan
	["From the quest data: south-east of {npc:253136}, in the heart of the valley, the Magram keep Gelkis Captives: kill five. The {npc:253446} there are failed summons stuck in the ground: raise ten with the Enhanced Necromancy Staff Orgrul gave you, and kill the ones that fight back. Corpsefeeders, elite and level 45, walk the valley and attack anyone; the Magram Necrokhans, elite too, leave a friend of the Magram alone."] = "",
	-- {npc:253446} Haggard Bones
	["Raise or slay {npc:253446}"] = "",

	-- Step 36: Magram: Bristleback Retreat
	-- {quest:93066} Bristleback Retreat
	["Magram: {quest:93066}"] = "",
	-- {npc:253136} Orgrul · {quest:93066} Bristleback Retreat
	["From the quest data: back to {npc:253136}, then east to {quest:93066} for his next order."] = "",

	-- Step 37: Magram: the quilboar
	["Magram: the quilboar"] = "",
	-- {quest:93066} Bristleback Retreat · {npc:253527} Kog'thug the Brave · {npc:255678} Quolga the Wise · {npc:253851} Hagiak · {area:16675} Magram Front
	["From the quest data: the Bristleback quilboar hold {quest:93066}, east of the valley. {npc:253527} (elite, level 43) and {npc:255678} (elite, level 42) lead them: leave those two be. Then report to {npc:253851} at the {area:16675}, south of the Retreat."] = "",

	-- Step 38: Magram: Hagiak at the Magram Front
	-- {npc:253851} Hagiak · {area:16675} Magram Front
	["Magram: {npc:253851} at the {area:16675}"] = "",
	-- {npc:253851} Hagiak · {area:16676} Outcast Hideaway
	["From the quest data: {npc:253851} sends you south-west to the {area:16676}, the exiles' camp west of the Shen'dralar town."] = "",

	-- Step 39: Magram: the Outcast Hideaway
	-- {area:16676} Outcast Hideaway
	["Magram: the {area:16676}"] = "",
	-- {item:256892} Stolen Supplies · {quest:92846} Outcast Necromancers · {npc:253136} Orgrul · {npc:253177} Nerlokh
	-- plural, as words: Outcast Scouts = {npc:254283} Outcast Scout · Outcast Necrokhans = {npc:253275} Outcast Necrokhan
	["From the quest data: Outcast Scouts and Marauders hold the hideaway, with Outcast Necrokhans, elite and level 45, among them. The {item:256892} are crates in its west. The quest wants {quest:92846} here too; players have met them only in the valley between {npc:253136} and {npc:253177} so far, so take them there if the hideaway has none."] = "",
	-- {item:256892} Stolen Supplies
	["{item:256892}: crates"] = "",

	-- Step 40: Magram: back to Hagiak
	-- {npc:253851} Hagiak
	["Magram: back to {npc:253851}"] = "",

	-- Step 41: Magram: Orgrul's ritual
	-- {npc:253136} Orgrul
	["Magram: {npc:253136}'s ritual"] = "",
	-- {quest:93196} Khan Jehn · {npc:253136} Orgrul
	["From the quest data: {quest:93196} has been slain by outsiders working for the Gelkis, and {npc:253136} means to raise him."] = "",

	-- Step 42: Magram: Khan Jehn
	-- {quest:93196} Khan Jehn
	["Magram: {quest:93196}"] = "",
	-- {item:257517} Ultimate Necromancy Staff · {area:604} Magram Village · {quest:93196} Khan Jehn · {item:271800} Scavenged Magram Armament · {item:271803} Greatstaff of the Necrokhans · {item:271804} Soulsplatter Mace
	["From the quest data: take the {item:257517} to the ritual site, a tent by the lake in the middle of {area:604}, and raise {quest:93196}. The risen khan takes the quest: 6,000, a title, and your pick of three rare level 35 weapons: {item:271800} (polearm: Stamina, attack power, Agility), {item:271803} (staff: Intellect, Stamina, Spirit) or {item:271804} (main-hand mace: Intellect, Stamina, Spirit). The quest costs the Gelkis 30,000."] = "",
	-- {quest:93196} Khan Jehn
	["raise {quest:93196} at the tent by the lake"] = "",

	-- Step 43: Magram: totems to Exalted
	["Magram: totems to Exalted"] = "",
	-- {quest:92811} Economic Warfare
	["From Revered on only {quest:92811} is left: Revered to Exalted is 21,000, 28 turn-ins, 140 totems."] = "",

	-- Step 44: The totem recipes
	["The totem recipes"] = "",
	-- {quest:93224} Carved Centaur Totems · {item:273613} Enchant Bracer - Lesser Agility · {item:250941} Greater Frenzy Potion · {item:250538} Hard Gold Gauntlet · {item:250606} Iron Morningstar · {item:252462} Mystic Thick Armor Kit · {item:253973} Silk Reagent Bag · {item:10011} Stormcloth Gloves · {item:274490} Centaur Hoofwarmers · {item:269900} Centaur Banner Deployment Device · {item:269902} Hoof-Shaped Foot Pedal
	["Both quartermasters sell the same 12 recipes for {quest:93224}, no standing needed: {item:273613} and - Lesser Healing Power; Greater Spellblasting and {item:250941}; {item:250538} and {item:250606} plans; {item:252462}, {item:253973}, {item:10011} and {item:274490} patterns; the {item:269900} and {item:269902} schematics. Keep the totems you need for them before you hand the rest in."] = "Ambos intendentes venden las mismas 12 recetas por {quest:93224}, sin necesidad de reputación: {item:273613} y poder de sanación inferior; Explosión de hechizos superior y {item:250941}; diseños de {item:250538} y {item:250606}; patrones de {item:252462}, {item:253973}, {item:10011} y {item:274490}; los esquemas de {item:269900} y {item:269902}. Guarda los tótems que necesites para ellas antes de entregar el resto.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Gelkis (south-west {zone:1443}) and the Magram (south-east) are at war: every kill of one clan gives the other 20 and costs its own clan 100, so you can only climb with one. Both start Neutral. Forever's quests are worth far more than kills now, and the choice quests no longer cost the other clan anything. Alliance: {npc:5396} at {area:608} offers {quest:1382} (Gelkis) and {quest:1385} (Magram). Horde: {npc:5412} offers {quest:1368} and {quest:1367}. Take the one of your clan, and {quest:93224}: each clan's Buying Friendship (3,000) is offered once you bring the totems back. Then tick the task. The guide goes on with the Gelkis; take the Magram's quests instead and it goes to the Magram half. Forever pays these quests in full at any level."] = "Los Gelkis (suroeste de {zone:1443}) y los Magram (sureste) están en guerra: cada muerte de un clan da 20 al otro y le cuesta 100 a su propio clan, así que solo puedes subir con uno. Ambos empiezan en Neutral. Las misiones de Forever valen ahora mucho más que las muertes, y las misiones de elección ya no le cuestan nada al otro clan. Alianza: {npc:5396}, en {area:608}, ofrece {quest:1382} (Gelkis) y {quest:1385} (Magram). Horda: {npc:5412} ofrece {quest:1368} y {quest:1367}. Acepta la de tu clan y {quest:93224}: la «Buying Friendship» de cada clan (3000) se ofrece cuando traes los tótems. Después marca la tarea. La guía sigue con los Gelkis; acepta en su lugar las misiones de los Magram y pasará a la mitad de los Magram. Forever paga estas misiones completas a cualquier nivel.",
}
