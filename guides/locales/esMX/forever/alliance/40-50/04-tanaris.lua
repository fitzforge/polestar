-- Spanish (Latin America) (esMX): the guide forever/alliance/40-50/04-tanaris (forever/alliance/40-50/04-tanaris.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Mirage Raceway
	-- {area:1108} Forgotten Coast · {area:489} Thalanaar · {zone:1441} Thousand Needles · {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {npc:4454} Fizzle Brassbolts · {npc:4630} Pozzik · {npc:4709} Zamek
	["From the {area:1108} dock, boat to Feathermoon and fly to {area:489}, then ride east through {zone:1441} to the {area:2240} on the {area:439}. {npc:4454} and {npc:4630} are in the camps beside the track; {npc:4709} stands by the goblin camp."] = "Desde el muelle de {area:1108}, toma el barco a Plumaluna y vuela a {area:489}; luego cabalga al este por {zone:1441} hasta {area:2240}, en {area:439}. {npc:4454} y {npc:4630} están en los campamentos junto a la pista; {npc:4709} está junto al campamento goblin.",
	["He runs off to keep Rizzle busy"] = "Se va corriendo para entretener a Rizzle Pernolatón",

	-- Step 2: Rizzle's plans
	["Rizzle's plans"] = "Los planos de Rizzle Pernolatón",
	-- {npc:4709} Zamek
	["While {npc:4709} keeps Rizzle talking, his plans lie unguarded in the gnome camp across the track."] = "Mientras {npc:4709} distrae a Rizzle Pernolatón, sus planos quedan sin vigilancia en el campamento gnomo al otro lado de la pista.",

	-- Step 4: Gadgetzan
	-- {area:439} Shimmering Flats · {zone:1446} Tanaris · {area:976} Gadgetzan
	["Ride south-east off the {area:439} into {zone:1446}. {area:976} is just inside the border."] = "Cabalga al sureste desde {area:439} hacia {zone:1446}. {area:976} está justo al cruzar la frontera.",
	-- {quest:2864} Tran'rek
	["{quest:2864}, north side of town"] = "{quest:2864}, en el lado norte del pueblo",
	-- {npc:7407} Chief Engineer Bilgewhizzle
	["{npc:7407}, by the water tower"] = "{npc:7407}, junto a la torre de agua",
	-- {npc:7408} Spigot Operator Luglunket
	["{npc:7408}, next to him"] = "{npc:7408}, a su lado",

	-- Step 5: Steamwheedle Port
	["Ride east across the dunes to the goblin harbour on the north-east coast."] = "Cabalga al este por las dunas hasta el puerto goblin de la costa noreste.",
	-- {npc:7881} Stoley
	["{npc:7881}, in the port's tavern"] = "{npc:7881}, en la taberna del puerto",
	["The Wanted poster beside him"] = "El cartel de Se busca a su lado",
	-- {npc:7847} Caliph Scorpidsting · {area:976} Gadgetzan
	["The same poster: {npc:7847} comes much later, after {area:976}"] = "El mismo cartel: {npc:7847} llega mucho más tarde, después de {area:976}",

	-- Step 6: Lost Rigger Cove
	-- {npc:7883} Andre Firebeard · {npc:7881} Stoley
	["Follow the coast south to the pirate cove. Southsea pirates crowd the beach and the boats: work along the edge and pull one at a time. {npc:7883} stands on the far side; {npc:7881}'s stolen cargo lies in the camp."] = "Sigue la costa al sur hasta la cala pirata. Los piratas de los Mares del Sur llenan la playa y los barcos: avanza por el borde y atráelos de uno en uno. {npc:7883} está en el otro extremo; la carga robada de {npc:7881} está en el campamento.",

	-- Step 7: Steamwheedle Port
	-- {npc:7881} Stoley · {area:35} Booty Bay
	["{npc:7881}'s next delivery goes back to {area:35}: skip it."] = "La siguiente entrega de {npc:7881} vuelve a {area:35}: omítela.",

	-- Step 8: Wastewander bandits
	["Wastewander bandits"] = "Bandidos Vagayermo",
	-- {area:976} Gadgetzan
	["Ride back west toward {area:976}. The Wastewander bandits and thieves hold the dunes on the way; any of them can carry a water pouch."] = "Cabalga de vuelta al oeste hacia {area:976}. Los bandidos y ladrones Vagayermo ocupan las dunas en el camino; cualquiera puede llevar una bolsa de agua.",

	-- Step 10: Waterspring Field
	-- {area:976} Gadgetzan · {npc:7847} Caliph Scorpidsting
	["The tougher Wastewander rogues, shadow mages and assassins camp south-east of {area:976}, south of the bandits. Leave {npc:7847} in the middle of the southern camp for later."] = "Los pícaros, magos oscuros y asesinos Vagayermo, más duros, acampan al sureste de {area:976}, al sur de los bandidos. Deja a {npc:7847}, en el centro del campamento del sur, para más tarde.",

	-- Step 11: Gadgetzan
	-- {npc:7763} Curgle Cranklehop · {area:702} Rut'theran Village
	["{npc:7763}: his crate goes to {area:702}, later"] = "{npc:7763}: su caja va a {area:702}, más adelante",

	-- Step 12: The pool by Sandsorrow Watch
	-- {area:979} Sandsorrow Watch
	["The pool by {area:979}"] = "El estanque junto a {area:979}",
	-- {area:979} Sandsorrow Watch · {item:8584} Untapped Dowsing Widget
	["Ride north-west to the Sandfury troll camp at {area:979}. Use the {item:8584} at the edge of its pool; the trolls stand close, so pull the nearest first."] = "Cabalga al noroeste hasta el campamento trol Furiarena en {area:979}. Usa el {item:8584} al borde de su estanque; los trols están cerca, así que atrae primero al más cercano.",
	-- {item:8585} Tapped Dowsing Widget
	["Gives the {item:8585}"] = "Da el {item:8585}",
	-- {area:979} Sandsorrow Watch
	["Pool by {area:979}"] = "Estanque junto a {area:979}",

	-- Step 14: The Broken Pillar
	-- {area:1938} Broken Pillar
	["The {area:1938}"] = "{area:1938}",
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {quest:3161} Gahz'ridian
	["Ride south to the dig camp at the {area:1938}. {npc:7771} hands you a detector helm: wear it to see the {quest:3161} mounds, which lie thick in the sand around the camp and south-west toward the ogres."] = "Cabalga al sur hasta el campamento de excavación en {area:1938}. {npc:7771} te da un yelmo detector: póntelo para ver los montículos de {quest:3161}, abundantes en la arena alrededor del campamento y al suroeste, hacia los ogros.",

	-- Step 15: Dunemaul Compound
	-- {npc:12046} Gor'marok the Ravager
	["Ride south-west to the ogre compound. Brutes and Enforcers (46-48) fill it; {npc:12046} (49) stands in the middle with guards around him: clear them first."] = "Cabalga al suroeste hasta la base ogra. La llenan toscos y déspotas (46-48); {npc:12046} (49) está en el centro rodeado de guardias: elimínalos primero.",

	-- Step 16: The Noxious Lair
	["Ride north-west to the Centipaar hive in the dunes. Any Centipaar can drop insect parts."] = "Cabalga al noroeste hasta la colmena Centipaar en las dunas. Cualquier Centipaar puede soltar partes de insecto.",

	-- Step 17: Thistleshrub Valley
	-- {quest:3362} Thistleshrub Valley
	-- plural, as words: Gnarled Thistleshrubs = {npc:5490} Gnarled Thistleshrub
	["Ride south into {quest:3362}. The Dew Collectors drop the glands; only some are full, so keep the Laden one. Gnarled Thistleshrubs and Rootshapers share the valley. The Thistleshrubs are 48-50, above you: pull one at a time."] = "Cabalga al sur hacia {quest:3362}. Los colectores de rocío Cardizal sueltan las glándulas; solo algunas están llenas, así que guarda la cargada. Los cardizales nudosos y enraizadores Cardizal comparten el valle. Los Cardizal son de nivel 48-50, por encima del tuyo: atráelos de uno en uno.",

	-- Step 18: Tooga's escort
	-- {npc:5955} Tooga
	["{npc:5955}'s escort"] = "La escolta de {npc:5955}",
	-- {npc:5955} Tooga · {npc:6015} Torta · {area:977} Steamwheedle Port
	["The little turtle {npc:5955} hides at the north end of the valley. Lead him home to his wife {npc:6015}, by the water just east of {area:977}: he walks slowly and the desert's beasts go for him, so keep him alive."] = "La pequeña tortuga {npc:5955} se esconde en el extremo norte del valle. Llévalo a casa con su esposa {npc:6015}, junto al agua justo al este de {area:977}: camina despacio y las bestias del desierto lo atacan, así que mantenlo con vida.",

	-- Step 19: Gadgetzan
	-- {area:976} Gadgetzan
	["Ride back west to {area:976}."] = "Cabalga de vuelta al oeste hasta {area:976}.",
	-- {npc:11758} Andi Lynn
	["{npc:11758}, on the east side of town"] = "{npc:11758}, en el lado este del pueblo",
	-- {npc:7583} Sprinkle · {zone:1425} Hinterlands
	["{npc:7583}'s next ingredient grows in the {zone:1425}, and the route never brings it back: skip it."] = "El siguiente ingrediente de {npc:7583} crece en {zone:1425} y la ruta nunca te trae de vuelta: omítelo.",

	-- Step 20: Caliph Scorpidsting
	-- {area:985} Waterspring Field · {npc:7847} Caliph Scorpidsting
	["Ride south-east to {area:985}. {npc:7847} stands in the middle of the southern Wastewander camp: clear around him first."] = "Cabalga al sureste hasta {area:985}. El {npc:7847} está en el centro del campamento Vagayermo del sur: limpia primero a su alrededor.",

	-- Step 21: The Gaping Chasm
	-- {area:1938} Broken Pillar · {area:981} The Gaping Chasm
	["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside."] = "Cabalga al sur más allá de {area:1938} hasta {area:981}, los túneles Hazzali; el equipo de Scrimshank está en lo más profundo.",

	-- Step 22: Gadgetzan
	-- {area:976} Gadgetzan
	["Hearth to {area:976}."] = "Usa la Piedra de hogar para volver a {area:976}.",
	-- {zone:1457} Darnassus
	["for {zone:1457}: the route takes you there at 47"] = "para {zone:1457}: la ruta te lleva allí a nivel 47",

	-- Step 23: Ironforge
	-- {area:976} Gadgetzan · {area:150} Menethil Harbor · {area:1537} Ironforge
	["Fly from {area:976} to Theramore, take the boat to {area:150} and fly to {area:1537}. Train."] = "Vuela de {area:976} a Theramore, toma el barco a {area:150} y vuela a {area:1537}. Entrena.",

	-- Step 24: Aerie Peak
	-- {area:348} Aerie Peak · {zone:1425} Hinterlands
	["Fly to {area:348}. {zone:1425} guide starts here."] = "Vuela a {area:348}. La guía de {zone:1425} empieza aquí.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly to {area:348}. {zone:1425} guide starts here."] = "Vuela a {area:348}. La guía de {zone:1425} empieza aquí.",
	-- ["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside."] = "Cabalga al sur más allá de {area:1938} hasta {area:981}, los túneles Hazzali; el equipo de Scrimshank está en lo más profundo.",
	-- ["The Wanted poster by {npc:7882}"] = "El cartel de Se busca junto a {npc:7882}",
}
