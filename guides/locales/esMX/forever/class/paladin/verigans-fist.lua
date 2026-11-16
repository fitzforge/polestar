-- Spanish (Latin America) (esMX): the guide forever/class/paladin/verigans-fist (forever/class/paladin/verigans-fist.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:5502} Sense Undead
	["The Alliance paladin's rare two-handed mace for the 20s, with a shield and {spell:5502} on the way."] = "La maza rara de dos manos del paladín de la Alianza para los veintes, con un escudo y {spell:5502} en el camino.",

	-- Step 1: The Tome of Valor (Ironforge)
	-- {npc:6179} Tiza Battleforge · {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward (no name in this language: may be words) · {item:6776} Tome of Valor · {npc:6171} Duthorian Rall · {zone:1453} Stormwind · {area:2257} Deeprun Tram · {zone:1455} Ironforge
	["At 20 {npc:6179}, upstairs in the {object:32386} in the {object:32362}, gives you the {item:6776}. Right-click it: it sends you to {npc:6171} in {zone:1453}'s Cathedral of Light. Take the {area:2257} from {zone:1455} to {zone:1453}."] = "A nivel 20, {npc:6179}, en el piso de arriba de {object:32386} en {object:32362}, te da {item:6776}. Haz clic derecho en él: te manda con {npc:6171} en la Catedral de la Luz de {zone:1453}. Toma {area:2257} de {zone:1455} a {zone:1453}.",

	-- Step 2: The Tome of Valor
	-- {npc:6171} Duthorian Rall · {item:6776} Tome of Valor
	["{npc:6171} stands in the Cathedral of Light. Humans get the {item:6776} from him. Right-click the book to start its quest and hand it straight back to him."] = "{npc:6171} está en la Catedral de la Luz. Los humanos reciben {item:6776} de él. Haz clic derecho en el libro para empezar su misión y devuélvesela enseguida.",
	-- {item:6776} Tome of Valor
	["Right-click the {item:6776}"] = "Haz clic derecho en {item:6776}",

	-- Step 3: Daphne Stilwell
	-- {npc:6182} Daphne Stilwell · {zone:1436} Westfall · {area:20} Moonbrook · {area:1581} Deadmines
	-- plural, as words: Defias Raiders = {npc:6180} Defias Raider
	["{npc:6182}'s farmhouse stands on the south-west coast of {zone:1436}, south of {area:20}: take the path that runs south beside the {area:1581}' back exit. When you take her quest, she walks from her orchard to the house and three waves of Defias Raiders (level 17-18) attack: three, then four, then five. Fight close to her so they do not swarm her, and heal her when she drops. You get time to eat and drink between waves, and she heals to full. If you or {npc:6182} die, the quest fails: abandon it and take it again from her (she is back five minutes after dying). Players find it hard alone before about 24."] = "La granja de {npc:6182} está en la costa suroeste de {zone:1436}, al sur de {area:20}: toma el sendero que va al sur junto a la salida trasera de {area:1581}. Cuando tomas su misión, camina desde su huerto hasta la casa y tres oleadas de asaltantes Defias (nivel 17-18) atacan: tres, luego cuatro, luego cinco. Pelea cerca de ella para que no la rodeen, y cúrala cuando baje. Tienes tiempo para comer y beber entre oleadas, y ella se cura por completo. Si tú o {npc:6182} mueren, la misión fracasa: abandónala y vuelve a tomarla con ella (vuelve cinco minutos después de morir). A los jugadores les cuesta solos antes del nivel 24 más o menos.",
	-- {npc:6182} Daphne Stilwell
	["Protect {npc:6182}: three waves"] = "Protege a {npc:6182}: tres oleadas",

	-- Step 4: Duthorian Rall
	-- {npc:6171} Duthorian Rall · {item:9607} Bastion of Stormwind · {spell:5502} Sense Undead
	["Back to the Cathedral of Light: {npc:6171} gives you the {item:9607} shield and teaches you {spell:5502}."] = "De vuelta a la Catedral de la Luz: {npc:6171} te da el escudo {item:9607} y te enseña {spell:5502}.",

	-- Step 5: Jordan Stilwell
	-- {npc:6181} Jordan Stilwell · {zone:1455} Ironforge · {item:6996} Jordan's Weapon Notes
	["{npc:6181} works outside the gates of {zone:1455}, not inside. He gives you {item:6996}: four parts, in any order. Keep the notes."] = "{npc:6181} trabaja afuera de las puertas de {zone:1455}, no adentro. Te da {item:6996}: cuatro partes, en cualquier orden. Guarda las notas.",

	-- Step 6: Bailor Stonehand
	-- {npc:6241} Bailor Stonehand · {area:144} Thelsamar
	["{npc:6241} is downstairs in the house of {area:144} that has a tailoring merchant outside. His quest only opens once you hold Jordan's."] = "{npc:6241} está abajo en la casa de {area:144} que tiene un vendedor de sastrería afuera. Su misión solo se abre cuando tienes la de Jordan.",

	-- Step 7: Bailor's Ore
	-- {zone:1432} Loch Modan
	["The crate of ore sits outdoors in the middle of the Mo'grosh ogre camp in north-east {zone:1432}, beside a big tree and a broken wagon, between the caves. The camp holds about fifteen Mo'grosh ogres, elite (level 18-19), who knock you down and come back after five minutes: grouping up is encouraged; at 20-22 it needs a group of about three. The crate is back two seconds after each loot, so every paladin in the group gets one."] = "La caja de mineral está al aire libre en el centro del campamento de ogros Mo'grosh, en el noreste de {zone:1432}, junto a un árbol grande y una carreta rota, entre las cuevas. El campamento tiene unos quince ogros Mo'grosh, élite (nivel 18-19), que te derriban y vuelven a los cinco minutos: se recomienda agruparse; a nivel 20-22 necesita un grupo de unos tres. La caja vuelve dos segundos después de cada saqueo, así que cada paladín del grupo recibe una.",
	-- {object:92420} Bailor's Ore
	["{object:92420} crate"] = "Caja de {object:92420}",

	-- Step 8: Back to Bailor Stonehand
	-- {npc:6241} Bailor Stonehand
	["Back to {npc:6241}"] = "Vuelve con {npc:6241}",
	-- {npc:6241} Bailor Stonehand · {item:6993} Jordan's Refined Ore Shipment
	["{npc:6241} turns the ore into {item:6993}, the part Jordan wants."] = "{npc:6241} convierte el mineral en {item:6993}, la parte que quiere Jordan.",

	-- Step 9: Whitestone Oak Lumber
	-- {area:1581} Deadmines · {area:20} Moonbrook
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["{area:1581} is a group of five under {area:20}; the instance portal is at the bottom of the {area:20} mine. The Goblin Woodcarvers (elite, level 18-19) in the mast room with Sneed drop the lumber every time."] = "{area:1581} es para un grupo de cinco, debajo de {area:20}; el portal de la instancia está al fondo de la mina de {area:20}. Los tallistas goblin (élite, nivel 18-19) de la sala del mástil con Sneed sueltan la madera siempre.",
	-- {area:1581} Deadmines · {area:20} Moonbrook
	["{area:1581}, in the {area:20} mine"] = "{area:1581}, en la mina de {area:20}",
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["Goblin Woodcarvers, inside"] = "Talladores de madera goblin, dentro",

	-- Step 10: Jordan's Smithing Hammer
	-- {area:236} Shadowfang Keep · {zone:1421} Silverpine Forest · {zone:1437} Wetlands · {area:287} Hillsbrad
	["{area:236} is a dungeon for a group of five in the low to mid 20s, in southern {zone:1421}, Horde land: a long trip for the Alliance, through the {zone:1437}, Arathi and {area:287}. The hammer lies on a crate across from the horses in the stables, early in the dungeon, at the far end of the courtyard before the ramp up; it is back five minutes after someone takes it."] = "{area:236} es una mazmorra para un grupo de cinco de nivel 20 a 25 más o menos, en el sur de {zone:1421}, tierra de la Horda: un viaje largo para la Alianza, por {zone:1437}, Arathi y {area:287}. El martillo está sobre una caja frente a los caballos en los establos, al principio de la mazmorra, en el extremo del patio antes de la rampa; vuelve cinco minutos después de que alguien lo toma.",
	-- {object:91138} Jordan's Hammer
	["{object:91138}, inside"] = "{object:91138}, dentro",

	-- Step 11: Thundris Windweaver
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["{npc:3649} is in {area:442}. Take his quest before you hunt naga: the Kor Gem never drops without it."] = "{npc:3649} está en {area:442}. Toma su misión antes de cazar nagas: la gema Kor nunca cae sin ella.",

	-- Step 12: The Corrupted Kor Gem
	-- {item:6995} Corrupted Kor Gem
	["The {item:6995}"] = "{item:6995}",
	-- {area:2797} Blackfathom Deeps · {zone:1440} Ashenvale · {item:6995} Corrupted Kor Gem · {spell:122} Frost Nova
	["The Blackfathom naga in the flooded passages around the {area:2797} entrance, on {zone:1440}'s north-west coast, drop the {item:6995}: Tide Priestesses (level 20-21), Oracles (21-22) and Sea Witches (23-24), one in two. You do not need to enter the instance. All are elite: grouping up is encouraged; players solo them one at a time, with difficulty. They heal themselves, run for help at low health, satyrs stand near some, and the Sea Witches cast {spell:122} up close. Some players report no drop while in a raid group."] = "Los nagas de Brazanegra en los pasajes inundados alrededor de la entrada de {area:2797}, en la costa noroeste de {zone:1440}, sueltan {item:6995}: sacerdotisas de las mareas (nivel 20-21), oráculos (21-22) y brujas del mar (23-24), una de cada dos veces. No hace falta entrar a la instancia. Todos son élite: se recomienda agruparse; los jugadores los hacen solos de a uno, con dificultad. Se curan solos, huyen a pedir ayuda con poca salud, hay sátiros cerca de algunos, y las brujas del mar lanzan {spell:122} de cerca. Algunos jugadores dicen que no cae estando en un grupo de banda.",

	-- Step 13: The Purified Kor Gem
	-- {item:7083} Purified Kor Gem
	["The {item:7083}"] = "{item:7083}",
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["Back to {npc:3649} in {area:442}: he purifies the gem."] = "Vuelve con {npc:3649} en {area:442}: él purifica la gema.",

	-- Step 14: Verigan's Fist
	-- {npc:6181} Jordan Stilwell · {zone:1455} Ironforge
	["Bring the four parts to {npc:6181} outside {zone:1455}. Accept his last quest and wait by him while he forges the mace at his anvil."] = "Lleva las cuatro partes a {npc:6181}, afuera de {zone:1455}. Acepta su última misión y espera a su lado mientras forja la maza en su yunque.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 20 {npc:6179} in the {object:32362} gives you the {item:6776}; it sends you to {npc:6171} in {zone:1453}'s Cathedral of Light. Take the tram from {zone:1455} to {zone:1453}."] = "A nivel 20, {npc:6179} en {object:32362} te da el {item:6776}; te manda con {npc:6171} en la Catedral de la Luz de {zone:1453}. Toma el tranvía de {zone:1455} a {zone:1453}.",
	-- ["Bring the four parts to {npc:6181} outside {zone:1455}."] = "Lleva las cuatro partes a {npc:6181}, fuera de {zone:1455}.",
	-- ["Protect {npc:6182}"] = "Protege a {npc:6182}",
	-- ["The Alliance paladin's rare two-handed mace for the 20s, with a shield on the way."] = "La maza rara de dos manos del paladín de la Alianza para los 20, con un escudo por el camino.",
	-- ["The Blackfathom naga by the entrance of {area:2797} on {zone:1440}'s north-west coast drop the {item:6995}. They are elite: grouping up is advised."] = "Los naga Brazanegra junto a la entrada de {area:2797}, en la costa noroeste de {zone:1440}, sueltan la {item:6995}. Son élite: se recomienda ir en grupo.",
	-- ["The ore crate lies by the trees in the middle of the Mo'grosh ogre camp in north-east {zone:1432}. The Mo'grosh ogres are elite: grouping up is advised."] = "La caja de mena está junto a los árboles en medio del campamento ogro Mo'grosh, al noreste de {zone:1432}. Los ogros Mo'grosh son élite: se recomienda ir en grupo.",
	-- ["from the {item:6776}"] = "del {item:6776}",
	-- ["{area:1581} is a group of five under {area:20}; the instance portal is inside the {area:20} mine. The Goblin Woodcarvers in the Mast Room, with Sneed, drop the lumber."] = "{area:1581} es para un grupo de cinco bajo {area:20}; el portal de la instancia está dentro de la mina de {area:20}. Los Talladores de madera goblin de la sala del mástil, con Sneed, sueltan la madera.",
	-- ["{area:236} is a level 20-30 dungeon in southern {zone:1421}. The hammer lies on a box inside the stables, at the far end of the courtyard before the ramp up."] = "{area:236} es un calabozo de nivel 20-30 al sur de {zone:1421}. El martillo está sobre una caja dentro de los establos, al fondo del patio antes de la rampa que sube.",
	-- ["{npc:3649} is in {area:442}."] = "{npc:3649} está en {area:442}.",
	-- ["{npc:6171} stands in the Cathedral of Light. Right-click the {item:6776} to start its quest."] = "{npc:6171} está en la Catedral de la Luz. Haz clic derecho en el {item:6776} para empezar su misión.",
	-- ["{npc:6181} stands outside the gates of {zone:1455}. He gives you {item:6996}, which list the four parts."] = "{npc:6181} está fuera de las puertas de {zone:1455}. Te da los {item:6996}, que enumeran las cuatro partes.",
	-- ["{npc:6182}'s farmhouse stands on the south-west coast of {zone:1436}. Waves of Defias attack it during her quest: keep her alive, and heal her if she needs it."] = "La granja de {npc:6182} está en la costa suroeste de {zone:1436}. Oleadas de Defias la atacan durante su misión: mantenla con vida y sánala si lo necesita.",
	-- ["{npc:6241} is in {area:144}."] = "{npc:6241} está en {area:144}.",
	-- ["{npc:6241} turns the ore into {item:6993}."] = "{npc:6241} convierte la mena en {item:6993}.",
}
