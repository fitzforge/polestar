-- Spanish (Spain) (esES): the guide forever/alliance/40-50/04-tanaris (forever/alliance/40-50/04-tanaris.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Mirage Raceway
	-- {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {zone:1441} Thousand Needles · {npc:4454} Fizzle Brassbolts
	["The {area:2240} lies on the {area:439} in south-east {zone:1441}: {npc:4454} is in the gnomes' camp beside the track, Zamek by the goblin camp."] = "{area:2240} está en {area:439}, al sureste de {zone:1441}: {npc:4454} está en el campamento de los gnomos junto a la pista, y Zamek, junto al campamento goblin.",
	-- {npc:4454} Fizzle Brassbolts · {quest:1137} News for Fizzle · {zone:1418} Badlands
	["{npc:4454}: {quest:1137}, from Martek in the {zone:1418}"] = "",

	-- Step 4: Gadgetzan
	-- {area:439} Shimmering Flats · {zone:1446} Tanaris · {area:976} Gadgetzan
	["Ride south-east off the {area:439} into {zone:1446}. {area:976} is just inside the border."] = "Cabalga hacia el sureste desde {area:439} hasta {zone:1446}. {area:976} está justo pasada la frontera.",
	-- {quest:2864} Tran'rek
	["{quest:2864}, north side of town"] = "{quest:2864}, en el lado norte del pueblo",
	-- {npc:7407} Chief Engineer Bilgewhizzle
	["{npc:7407}, by the water tower"] = "{npc:7407}, junto a la torre de agua",
	-- {npc:7408} Spigot Operator Luglunket
	["{npc:7408}, next to him"] = "{npc:7408}, a su lado",
	-- {npc:7763} Curgle Cranklehop · {area:702} Rut'theran Village
	["{npc:7763}: his crate goes to {area:702}, later"] = "{npc:7763}: su caja va a {area:702}, más adelante",

	-- Step 5: Gadgetzan
	-- {area:978} Zul'Farrak · {quest:2864} Tran'rek · {npc:7407} Chief Engineer Bilgewhizzle · {quest:2768} Divino-matic Rod
	["For your {area:978} run, later in this guide: {quest:2864} wants scarab shells, {npc:7407}, by the water tower, his {quest:2768} back, and Trenton Lighthammer Troll Temper from the Sandfury trolls."] = "Para tu incursión en {area:978}, más adelante en esta guía: {quest:2864} quiere caparazones de escarabajo, {npc:7407}, junto a la torre de agua, que le devuelvas su {quest:2768}, y Trenton Lighthammer, Temple de trol de los trols Furiarena.",

	-- Step 6: Steamwheedle Port
	["Ride east across the dunes to the goblin harbour on the north-east coast."] = "Cabalga hacia el este por las dunas hasta el puerto goblin de la costa noreste.",
	["The Wanted poster beside him"] = "El cartel de Se busca a su lado",
	-- {npc:7847} Caliph Scorpidsting · {area:976} Gadgetzan
	["The same poster: {npc:7847} comes much later, after {area:976}"] = "El mismo cartel: {npc:7847} llega mucho más tarde, después de {area:976}",
	-- {npc:7882} Security Chief Bilgewhizzle
	["{npc:7882}, inside"] = "",
	-- {npc:7881} Stoley
	["{npc:7881}, in the port's tavern; inside"] = "{npc:7881}, en la taberna del puerto; dentro",

	-- Step 7: Noonshade Ruins: kill these as you meet them
	-- {area:1937} Noonshade Ruins
	["{area:1937}: kill these as you meet them"] = "",
	-- {area:976} Gadgetzan
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["Ride back west toward {area:976}. The Wastewander bandits and thieves hold the dunes on the way; any of them can carry a water pouch.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "Vuelve al oeste hacia {area:976}. Los Bandidos y Ladrones Deambuladores ocupan las dunas del camino; cualquiera puede llevar un odre de agua.\nCuidado: los Pícaros Vagayermo (nivel 43-44) se mueven en sigilo, así que pueden acercarse sin que los veas.",

	-- Step 9: Waterspring Field
	-- {area:976} Gadgetzan · {npc:7847} Caliph Scorpidsting
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["The tougher Wastewander rogues, shadow mages and assassins camp south-east of {area:976}, south of the bandits. Leave {npc:7847} in the middle of the southern camp for later.\nCareful: Wastewander Rogues keep Sneak up while out of combat, so hidden rogues can join a fight you start at a camp."] = "Los Pícaros Vagayermo, Magos oscuros Deambuladores y Asesinos Vagayermo, más duros, acampan al sureste de {area:976}, al sur de los bandidos. Deja a {npc:7847}, en el centro del campamento del sur, para más tarde.\nCuidado: los Pícaros Vagayermo mantienen Sigilo fuera de combate, así que pícaros ocultos pueden unirse a una pelea que empieces en un campamento.",

	-- Step 10: Lost Rigger Cove: kill these as you meet them
	-- {area:1336} Lost Rigger Cove
	["{area:1336}: kill these as you meet them"] = "",
	-- {npc:7883} Andre Firebeard · {npc:7881} Stoley
	["Follow the coast south to the pirate cove. Southsea pirates crowd the beach and the boats: work along the edge and pull one at a time. {npc:7883} stands on the far side; {npc:7881}'s stolen cargo lies in the camp.\nCareful: Two or three pirates stand with {npc:7883}, and many more pirates from the town join the fight once it starts."] = "Sigue la costa hacia el sur hasta la cala pirata. Los piratas del Mar del Sur abarrotan la playa y los barcos: avanza por el borde y atráelos de uno en uno. {npc:7883} está en el lado opuesto; la carga robada de {npc:7881} está en el campamento.\nCuidado: dos o tres piratas acompañan a {npc:7883}, y muchos más piratas del pueblo se unen a la pelea en cuanto empieza.",
	-- {quest:2873} Stoley's Shipment
	["{quest:2873}; upstairs"] = "",

	-- Step 11: Steamwheedle Port
	-- {npc:7881} Stoley
	["{npc:7881}, inside"] = "",
	-- {area:35} Booty Bay · {zone:1425} Hinterlands
	["\"Sea Wolf\" MacKinley in {area:35}: the route takes you there at the end of the {zone:1425} guide, keep it"] = "",

	-- Step 12: Noonshade Ruins
	["Careful: Thieves cast Disarm. Rogues stay hidden with Sneak. Assassins use Execute when your health is at 20% or lower."] = "",

	-- Step 14: The pool by Sandsorrow Watch
	-- {area:979} Sandsorrow Watch
	["The pool by {area:979}"] = "La charca de {area:979}",
	-- {area:979} Sandsorrow Watch · {item:8584} Untapped Dowsing Widget
	["Ride north-west to the Sandfury troll camp at {area:979}. Use the {item:8584} at the edge of its pool; the trolls stand close, so pull the nearest first."] = "Cabalga hacia el noroeste hasta el campamento de los trols Furiarena en {area:979}. Usa el {item:8584} en el borde de su charca; los trols están cerca, así que atrae primero a los más próximos.",
	-- {item:8585} Tapped Dowsing Widget
	["Gives the {item:8585}"] = "Da el {item:8585}",
	-- {area:979} Sandsorrow Watch
	["Pool by {area:979}"] = "Charca de {area:979}",

	-- Step 15: Zul'Farrak
	-- {area:978} Zul'Farrak · {quest:3042} Troll Temper · {npc:7604} Sergeant Bly · {quest:2768} Divino-matic Rod
	["{area:978} is a dungeon for a group of five; its quests here are level 45 to 47. Its gate lies about 400 yards north of the pool.\nInside: the Scarabs drop the shells, every Sandfury troll can drop {quest:3042}, and {npc:7604} carries the {quest:2768}."] = "{area:978} es una mazmorra para un grupo de cinco; sus misiones de aquí son de nivel 45 a 47. Su puerta está a unos 400 metros al norte del estanque.\nDentro: los Escarabajos sueltan los caparazones, cualquier trol Furiarena puede soltar {quest:3042} y {npc:7604} lleva {quest:2768}.",
	-- {quest:2865} Scarab Shells
	["{quest:2865}: the Scarabs, inside"] = "{quest:2865}: los Escarabajos, dentro",
	-- {quest:3042} Troll Temper
	["{quest:3042}: the Sandfury trolls, inside"] = "{quest:3042}: los trols Furiarena, dentro",
	-- {quest:2768} Divino-matic Rod · {npc:7604} Sergeant Bly
	["{quest:2768}: {npc:7604}, inside"] = "{quest:2768}: {npc:7604}, dentro",

	-- Step 17: Tran'rek
	-- {area:978} Zul'Farrak · {npc:7876} Tran'rek
	["Your {area:978} scarab shells: {npc:7876}, on the north side of town."] = "Tus caparazones de escarabajo de {area:978}: {npc:7876}, en el lado norte del pueblo.",

	-- Step 18: Chief Engineer Bilgewhizzle
	-- {quest:2768} Divino-matic Rod · {npc:7407} Chief Engineer Bilgewhizzle
	["The {quest:2768}: {npc:7407}, by the water tower."] = "{quest:2768}: {npc:7407}, junto a la torre de agua.",

	-- Step 19: Trenton Lighthammer
	-- {quest:3042} Troll Temper · {npc:7804} Trenton Lighthammer
	["The {quest:3042}: {npc:7804}, in town."] = "{quest:3042}: {npc:7804}, en el pueblo.",

	-- Step 20: The Broken Pillar
	-- {area:1938} Broken Pillar
	["The {area:1938}"] = "El {area:1938}",
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {quest:3161} Gahz'ridian
	["Ride south to the dig camp at the {area:1938}. {npc:7771} hands you a detector helm: wear it to see the {quest:3161} mounds, which lie thick in the sand around the camp and south-west toward the ogres."] = "Cabalga hacia el sur hasta el campamento de excavación del {area:1938}. {npc:7771} te da un yelmo detector: póntelo para ver los montículos de {quest:3161}, abundantes en la arena alrededor del campamento y hacia el suroeste, hacia los ogros.",

	-- Step 22: The Noxious Lair
	-- {npc:4196} Silithid Swarm
	-- plural, as words: Centipaar Swarmers = {npc:5457} Centipaar Swarmer
	["Ride north-west to the Centipaar hive in the dunes. Any Centipaar can drop insect parts.\nCareful: Centipaar Swarmers cast {npc:4196} both in and out of combat, which brings small adds that interrupt you."] = "",

	-- Step 23: Dunemaul Compound
	-- {npc:12046} Gor'marok the Ravager · {quest:3362} Thistleshrub Valley
	-- plural, as words: Dunemaul Ogres = {npc:5471} Dunemaul Ogre
	["Ride south-west to the ogre compound. Brutes and Enforcers (46-48) fill it; {npc:12046} (49) stands in the middle with guards around him: clear them first.\nWhy the grind to 47: the {quest:3362} comes next, with mobs of 48-50 and quests of level 50. Grind it on the Dunemaul Ogres (45-46) at the compound's south end, the safer camp, not on the Brutes."] = "Cabalga hacia el suroeste hasta la Base Machacaduna. Está llena de Toscos y Déspotas Machacaduna (46-48); {npc:12046} (49) está en el centro rodeado de guardias: acaba primero con ellos.\nPor qué subir hasta el 47: {quest:3362} viene a continuación, con enemigos de nivel 48-50 y misiones de nivel 50. Sube con los Ogros Machacaduna (45-46) del extremo sur de la base, el campamento más seguro, no con los Toscos.",
	-- {npc:12046} Gor'marok the Ravager
	["{npc:12046}, below ground"] = "",
	-- {npc:5471} Dunemaul Ogre
	["grind on {npc:5471}, at the compound's south end"] = "sube nivel con {npc:5471}, en el extremo sur del recinto",

	-- Step 24: Thistleshrub Valley: kill these as you meet them
	-- {quest:3362} Thistleshrub Valley
	["{quest:3362}: kill these as you meet them"] = "",
	-- {quest:3362} Thistleshrub Valley
	-- plural, as words: Gnarled Thistleshrubs = {npc:5490} Gnarled Thistleshrub
	["Ride south into {quest:3362}. The Dew Collectors drop the glands; only some are full, so keep the Laden one. Gnarled Thistleshrubs and Rootshapers share the valley. The Thistleshrubs are 48-50, above you: pull one at a time.\nCareful: The other thistleshrub mobs in the area are level 49-50 and wander a lot, so you can easily pull extra mobs."] = "Cabalga hacia el sur hasta {quest:3362}. Los Colectores de rocío Cardizal sueltan las glándulas; solo algunas están llenas, así que quédate con la Glándula cargada de rocío. Cardizales nudosos y Enraizadores Cardizal comparten el valle. Los Cardizales son de nivel 48-50, por encima del tuyo: atráelos de uno en uno.\nCuidado: los demás cardizales de la zona son de nivel 49-50 y deambulan mucho, así que es fácil atraer enemigos de más.",

	-- Step 25: Tooga's escort
	-- {npc:5955} Tooga
	["{npc:5955}'s escort"] = "La escolta de {npc:5955}",
	-- {npc:5955} Tooga · {npc:6015} Torta · {area:977} Steamwheedle Port
	["The little turtle {npc:5955} hides at the north end of the valley. Lead him home to his wife {npc:6015}, by the water just east of {area:977}: he walks slowly and the desert's beasts go for him, so keep him alive."] = "La tortuguita {npc:5955} se esconde en el extremo norte del valle. Llévala a casa con su pareja {npc:6015}, junto al agua justo al este de {area:977}: camina despacio y las bestias del desierto van a por ella, así que mantenla con vida.",

	-- Step 26: Gadgetzan
	-- {area:976} Gadgetzan · {npc:11758} Andi Lynn
	["Ride back west to {area:976}: {npc:11758} stands on the east side of town, where you come in."] = "",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "",

	-- Step 27: Caliph Scorpidsting
	-- {area:985} Waterspring Field · {npc:7847} Caliph Scorpidsting
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["Ride south-east to {area:985}. {npc:7847} stands in the middle of the southern Wastewander camp: clear around him first.\nCareful: Two stealthed Wastewander Rogues travel with him wherever he goes. At his spawn camp, two shadowmages and their minions are close enough to join a fight with him. Out by the towers you can fight him without them."] = "",

	-- Step 28: The Gaping Chasm
	-- {area:1938} Broken Pillar · {area:981} The Gaping Chasm
	["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside.\nCareful: One bug guards the gear. Many bugs patrol the tunnels, some of them level 50, so fights often pull extra adds."] = "Cabalga hacia el sur, más allá del {area:1938}, hasta {area:981}, los túneles Hazzali; el equipo de Patagolpe está en lo más profundo.\nCuidado: un bicho vigila el equipo. Muchos bichos patrullan los túneles, algunos de nivel 50, así que los combates suelen atraer enemigos de más.",
	-- {item:8593} Scrimshank's Surveying Gear
	["{item:8593}; below ground"] = "",

	-- Step 29: Gadgetzan
	-- {zone:1457} Darnassus
	["for {zone:1457}, next"] = "para {zone:1457}, a continuación",

	-- Step 30: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "Vuela a {area:442}",
	-- {zone:1457} Darnassus · {npc:7763} Curgle Cranklehop · {area:442} Auberdine · {area:150} Menethil Harbor · {area:348} Aerie Peak
	["{zone:1457} first, while you are on this side of the sea: Troyas' answer, {npc:7763}'s crate, Tyrande and the soil errand, then the boat from {area:442} to {area:150} and the gryphon to {area:348}."] = "Primero {zone:1457}, ya que estás a este lado del mar: la respuesta de Troyas, la caja de {npc:7763}, Tyrande y el encargo de la tierra; luego el barco de {area:442} a {area:150} y el grifo a {area:348}.",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "",

	-- Step 31: Teldrassil
	-- {area:442} Auberdine · {area:702} Rut'theran Village · {npc:3838} Vesprystus
	["Take the boat from {area:442}'s dock to {area:702}; {npc:3838}, the hippogryph master, stands on the rise just east of the landing: learn the flight path on the way up to the village."] = "Toma el barco desde el muelle de {area:442} hasta {area:702}; {npc:3838}, el maestro de hipogrifos, está en la loma justo al este del embarcadero: aprende la ruta de vuelo de camino a la aldea.",
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "Maestro de vuelo de {area:702}",

	-- Step 32: Rut'theran Village
	-- {npc:7907} Daryn Lightwind · {npc:7916} Erelas Ambersky
	["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "{npc:7907} está en el piso de arriba, encima de {npc:7916}: sube por dentro, la flecha no distingue los pisos.",
	-- {npc:7907} Daryn Lightwind · {zone:1446} Tanaris
	["{npc:7907}'s next errand goes to {zone:1446}: skip it."] = "El siguiente encargo de {npc:7907} va a {zone:1446}: sáltalo.",
	-- {npc:7916} Erelas Ambersky · {zone:1425} Hinterlands
	["{npc:7916}: the feathers lie in the {zone:1425}, next"] = "{npc:7916}: las plumas están en {zone:1425}, a continuación",
	["the book on her table"] = "el libro de su mesa",

	-- Step 34: Temple of the Moon
	["Temple of the Moon"] = "Templo de la Luna",
	-- {zone:1457} Darnassus
	["Step through the portal into {zone:1457}. The Temple of the Moon is in the south of the city."] = "Cruza el portal a {zone:1457}. El Templo de la Luna está en el sur de la ciudad.",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}, beside her"] = "{npc:7740}, a su lado",

	-- Step 38: Cenarion Enclave
	-- {npc:3516} Arch Druid Fandral Staghelm
	["{npc:3516}, at the top of the tree"] = "{npc:3516}, en lo alto del árbol",

	-- Step 39: Class trainer
	["Class trainer"] = "Instructor de clase",

	-- Step 40: Cenarion Enclave
	-- {zone:1449} Un'Goro Crater
	["the soil comes from {zone:1449}, later"] = "la tierra viene de {zone:1449}, más adelante",

	-- Step 41: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "Portal a {zone:1438}",

	-- Step 43: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Barco a {area:150}",

	-- Step 44: Fly to Aerie Peak
	-- {area:348} Aerie Peak
	["Fly to {area:348}"] = "",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "",

	-- Step 45: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Vuela a {area:271}",

	-- Step 46: Hinterlands
	-- {area:348} Aerie Peak · {area:271} Southshore · {zone:1425} Hinterlands
	["No flight path to {area:348} yet: ride north-east out of {area:271} on the road into the {zone:1425}; {area:348} sits just past the border."] = "Aún no tienes la ruta de vuelo a {area:348}: sal de {area:271} hacia el noreste por el camino que entra en {zone:1425}; {area:348} está justo pasada la frontera.",

	-- Step 47: Aerie Peak
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, beside the flight master"] = "",
	-- {npc:7884} Fraggar Thundermantle
	["{npc:7884}, inside"] = "",

	-- Step 50: Sprinkle's Secret Ingredient
	["Underwater"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly from {area:976} to Theramore, take the boat to {area:150} and fly to {area:1537}. Train."] = "Vuela de {area:976} a Theramore, toma el barco a {area:150} y vuela a {area:1537}. Entrena.",
	-- ["Fly to {area:348}. {zone:1425} guide starts here."] = "Vuela a {area:348}. La guía de {zone:1425} empieza aquí.",
	-- ["From the {area:1108} dock, boat to Feathermoon and fly to {area:489}, then ride east through {zone:1441} to the {area:2240} on the {area:439}. {npc:4454} and {npc:4630} are in the camps beside the track; {npc:4709} stands by the goblin camp."] = "Desde el muelle de {area:1108}, toma el barco a Plumaluna y vuela a {area:489}; luego cabalga hacia el este por {zone:1441} hasta {area:2240}, en {area:439}. {npc:4454} y {npc:4630} están en los campamentos junto a la pista; {npc:4709} está junto al campamento goblin.",
	-- ["He runs off to keep Rizzle busy"] = "Sale corriendo para entretener a Rizzle",
	-- ["Hearth to {area:976}."] = "Usa la piedra de hogar para ir a {area:976}.",
	-- ["Ride back west to {area:976}."] = "Vuelve al oeste hasta {area:976}.",
	-- ["Ride north-west to the Centipaar hive in the dunes. Any Centipaar can drop insect parts."] = "Cabalga hacia el noroeste hasta la colmena Centipaar de las dunas. Cualquier Centipaar puede soltar trozos de insecto.",
	-- ["Ride south-east off the {area:439} into {area:440}. {area:976} is just inside the border."] = "Cabalga hacia el sureste desde {area:439} hasta {area:440}. {area:976} está justo pasada la frontera.",
	-- ["Ride south-east to {area:985}. {npc:7847} stands in the middle of the southern Wastewander camp: clear around him first."] = "Cabalga hacia el sureste hasta {area:985}. {npc:7847} está en el centro del campamento Vagayermo del sur: despeja primero a su alrededor.",
	-- ["Rizzle's plans"] = "Los planos de Rizzle",
	-- ["The Wanted poster by {npc:7882}"] = "El cartel de Se busca junto a {npc:7882}",
	-- ["Wastewander bandits"] = "Bandidos Deambuladores",
	-- ["While {npc:4709} keeps Rizzle talking, his plans lie unguarded in the gnome camp across the track."] = "Mientras {npc:4709} entretiene a Rizzle, sus planos quedan sin vigilancia en el campamento gnomo al otro lado de la pista.",
	-- ["for {zone:1457}: the route takes you there at 47"] = "para {zone:1457}: la ruta te lleva allí a nivel 47",
	-- ["{npc:11758}, on the east side of town"] = "{npc:11758}, en el lado este del pueblo",
	-- ["{npc:7583}'s next ingredient grows in the {zone:1425}, and the route never brings it back: skip it."] = "El siguiente ingrediente de {npc:7583} crece en {zone:1425} y la ruta nunca te trae de vuelta: omítelo.",
	-- ["{npc:7881}'s next delivery goes back to {area:35}: skip it."] = "La siguiente entrega de {npc:7881} vuelve a {area:35}: omítela.",
}
