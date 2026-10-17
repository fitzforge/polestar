-- Spanish (Spain) (esES): the guide forever/alliance/50-60/03-winterspring (forever/alliance/50-60/03-winterspring.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Everlook
	-- {npc:11118} Innkeeper Vizzie
	["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118}: la guía anterior te vincula aquí, así que esto suele marcarse al instante",
	-- {npc:11629} Jessica Redpath · {area:2262} Darrowshire
	["{npc:11629}: keep it for {area:2262}"] = "{npc:11629}: guárdalo para {area:2262}",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}: keep both for the Plaguelands"] = "{npc:10431}: guarda ambos para las Tierras de la Peste",

	-- Step 2: Starfall Village
	["Ride west along the road to the night elf village."] = "Cabalga al oeste por el camino hasta el pueblo de los elfos de la noche.",

	-- Step 3: The Ruins of Kel'Theril
	-- {area:2253} Starfall Village
	-- plural, as words: Moontouched Feathers = {item:12383} Moontouched Feather
	["The ruins lie around the frozen lake south of {area:2253}. Pick up the four relic fragments lying in the ruins and the Moontouched Feathers on the ground where the wildkin roam."] = "Las ruinas rodean el lago helado al sur de {area:2253}. Recoge los cuatro fragmentos de reliquia que hay en las ruinas y las Plumas Lunadón del suelo, donde merodean los lechúcicos.",

	-- Step 4: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Follow the road west to {npc:9298}'s camp beside the hot springs."] = "Sigue el camino al oeste hasta el campamento de {npc:9298}, junto a las aguas termales.",
	-- {zone:1444} Feralas
	["Keep it: Gregan in {zone:1444} brews the elixir later"] = "Guárdalo: Gregan, en {zone:1444}, prepara el elixir más adelante",

	-- Step 5: Salfa
	-- {npc:11556} Salfa · {area:1769} Timbermaw Hold · {npc:9298} Donova Snowden
	["{npc:11556} guards the mouth of {area:1769}, north-west of {npc:9298}."] = "{npc:11556} guarda la entrada de {area:1769}, al noroeste de {npc:9298}.",

	-- Step 6: The Winterfall camp
	["The Winterfall camp"] = "El campamento Nevada",
	-- {npc:11556} Salfa · {npc:9298} Donova Snowden · {item:12771} Empty Firewater Flask · {quest:8471} Winterfall Ritual Totem · {quest:6031} Runecloth
	["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Any furbolg here can drop an {item:12771} (about one in ten) and, rarely, a {quest:8471}: right-click whichever drops. Keep the {quest:6031} the furbolgs drop for Meilosh."] = "El campamento Nevada del oeste está en las colinas entre {npc:11556} y {npc:9298}. Cualquier fúrbolg de aquí puede soltar un {item:12771} (más o menos uno de cada diez) y, rara vez, un {quest:8471}: haz clic derecho en el que caiga. Guarda el {quest:6031} que sueltan los fúrbolgs para Meilosh.",
	-- {item:12771} Empty Firewater Flask
	["{item:12771}, a rare drop"] = "{item:12771}, botín poco frecuente",
	-- {quest:8471} Winterfall Ritual Totem
	["{quest:8471}, a rare drop"] = "{quest:8471}, botín poco frecuente",
	-- {area:1769} Timbermaw Hold
	["For Kernda in {area:1769}: keep it"] = "Para Kernda en {area:1769}: guárdalo",
	-- {quest:6031} Runecloth
	["{quest:6031}, for Meilosh later"] = "{quest:6031}, para Meilosh más adelante",

	-- Step 7: Donova Snowden
	-- {zone:1448} Felwood
	["The Deadwood cauldron in {zone:1448}: keep it"] = "El caldero Muertobosque de {zone:1448}: guárdalo",

	-- Step 8: Winterfall Village
	-- {area:2255} Everlook · {npc:10738} High Chief Winterfall
	["The Winterfall furbolg village lies east of {area:2255}: Shaman (56-57), Den Watchers (55-56) and Ursa (57-58), all above you. Kill the Shaman first, they heal, and pull from the edge. {npc:10738} in the cave at the back is elite: stay out."] = "El poblado de los fúrbolgs Nevada está al este de {area:2255}: chamanes (56-57), vigilantes del cubil (55-56) y ursas (57-58), todos por encima de ti. Mata primero a los chamanes, que curan, y atrae desde el borde. {npc:10738}, en la cueva del fondo, es élite: no entres.",

	-- Step 9: The Ice Thistle Hills
	-- {area:2247} Ice Thistle Hills
	["The {area:2247}"] = "{area:2247}",
	-- {area:2244} Winterfall Village · {area:2255} Everlook
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["Ice Thistle yetis live in the hills south of {area:2244}, Chillwind Chimaeras in the valley toward {area:2255}."] = "Los yetis Cardo Nevado viven en las colinas al sur de {area:2244}, y las Quimeras venfresco en el valle hacia {area:2255}.",

	-- Step 11: Optional: Sunken Temple
	-- {area:1417} Sunken Temple
	["Optional: {area:1417}"] = "Opcional: {area:1417}",
	-- {area:1417} Sunken Temple · {area:2255} Everlook
	["Short of level 54 after the yetis? Running the {area:1417} (50-54) instead of grinding gets you there faster in a group. Come back to {area:2255} afterwards."] = "¿No llegas al nivel 54 después de los yetis? Hacer {area:1417} (50-54) en grupo en vez de matar enemigos te lleva allí más rápido. Después vuelve a {area:2255}.",

	-- Step 12: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "Cuernos de yeti prístinos",
	-- plural, as words: Ice Thistle Matriarchs = {npc:7459} Ice Thistle Matriarch
	["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns. Keep killing yetis until level 54: Harlo's wildkin quests are red before that."] = "Vuelve a las colinas: solo las Matriarcas Cardo Nevado y los patriarcas llevan los cuernos. Sigue matando yetis hasta el nivel 54: antes de eso, las misiones de lechúcicos de Harlo están en rojo.",
	-- {npc:7460} Ice Thistle Patriarch · {area:2247} Ice Thistle Hills · {zone:1452} Winterspring
	["grind on {npc:7460} at the {area:2247}, {zone:1452}"] = "mata {npc:7460} en {area:2247}, {zone:1452}",

	-- Step 13: Everlook
	-- {npc:10978} Legacki
	["On {npc:10978}, by the inn"] = "Sobre {npc:10978}, junto a la posada",
	-- {npc:10978} Legacki · {npc:7583} Sprinkle · {npc:10977} Quixxil
	["{npc:10978}: {npc:7583} and {npc:10977} come later"] = "{npc:10978}: {npc:7583} y {npc:10977} vienen después",

	-- Step 14: Starfall Village
	-- {npc:10301} Jaron Stoneshaper
	["Ride west along the road to {npc:10301}."] = "Cabalga al oeste por el camino hasta {npc:10301}.",

	-- Step 15: Jaron Stoneshaper's camp
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s camp"] = "El campamento de {npc:10301}",
	-- {npc:10301} Jaron Stoneshaper · {area:2245} Mazthoril
	["Ride south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "Cabalga al sureste valle abajo hasta la caja dañada de {npc:10301}, en la nieve de {area:2245}, con su carro destrozado justo al este.",

	-- Step 16: Jaron Stoneshaper's supplies
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s supplies"] = "Los suministros de {npc:10301}",
	-- {npc:10301} Jaron Stoneshaper
	["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "Recoge los suministros alrededor del carro y recupera el amuleto de {npc:10301} de las lechubestias cercanas.",

	-- Step 17: Darkwhisper Gorge
	-- {npc:9298} Donova Snowden · {area:2256} Darkwhisper Gorge
	["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "Sigue las indicaciones de {npc:9298} hasta la entrada de {area:2256}, pasando a los gigantes Machacahielo: pásalos de uno en uno.",

	-- Step 18: Starfall Village
	["Ride north-west back to the village."] = "Cabalga al noroeste de vuelta al pueblo.",

	-- Step 21: Winterfall Spirit Beads
	["The western Winterfall furbolgs drop the beads."] = "Los fúrbolgs Nevada del oeste sueltan las cuentas.",

	-- Step 23: Chillwind Camp
	-- {area:1769} Timbermaw Hold · {zone:1448} Felwood · {area:442} Auberdine · {area:150} Menethil Harbor · {area:271} Southshore · {area:3197} Chillwind Camp
	["Walk through {area:1769} to {zone:1448} and fly on to the Eastern Kingdoms ({area:442}, the boat to {area:150}). Fly to {area:271} and ride north up the road through Alterac to {area:3197}."] = "Atraviesa {area:1769} hasta {zone:1448} y vuela hacia Reinos del Este ({area:442}, el barco a {area:150}). Vuela a {area:271} y cabalga al norte por el camino a través de Montañas de Alterac hasta {area:3197}.",

	-- Step 24: Pamela Redpath
	-- {zone:1423} Eastern Plaguelands · {area:2262} Darrowshire · {npc:10926} Pamela Redpath
	["Follow the southern road east into the {zone:1423}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "Sigue el camino del sur hacia el este hasta {zone:1423}; las ruinas de {area:2262} están al sur. El fantasma de {npc:10926} juega junto a la casa en ruinas del extremo sur.",

	-- Step 25: Pamela Redpath's doll
	-- {npc:10926} Pamela Redpath
	["{npc:10926}'s doll"] = "La muñeca de {npc:10926}",
	-- {area:2262} Darrowshire
	["The three pieces of the doll lie in the ruined houses of {area:2262}; picking one up can call out ghosts. Combine them into the doll."] = "Las tres piezas de la muñeca están en las casas en ruinas de {area:2262}; al recoger una pueden aparecer fantasmas. Combínalas para formar la muñeca.",

	-- Step 26: Pamela Redpath
	-- {quest:5152} Auntie Marlene · {zone:1422} Western Plaguelands
	["{quest:5152}, in the {zone:1422}: keep it"] = "{quest:5152}, en {zone:1422}: guárdala",

	-- Step 27: Light's Hope Chapel
	["Follow the road east across the zone to the chapel."] = "Sigue el camino al este cruzando la zona hasta la capilla.",
	-- {npc:11038} Caretaker Alen · {npc:12250} Zaeldarr the Outcast
	["{npc:11038}: {npc:12250} is a level 54 elite"] = "{npc:11038}: {npc:12250} es un élite de nivel 54",

	-- Step 28: Corin's Crossing
	-- {area:2264} Corin's Crossing
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["The Scourge around {area:2264}, west of the chapel, drop both kinds of Scourgestone; Darrowshire Spirits rise from them: talk to each one to free it."] = "La Plaga alrededor de {area:2264}, al oeste de la capilla, suelta ambos tipos de Piedra de la Plaga; de ellos surgen espíritus de Villa Darrow ({npc:11064}): habla con cada uno para liberarlo.",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "Libera espíritus de Villa Darrow ({npc:11064}): habla con ellos",

	-- Step 30: The Undercroft
	-- {npc:12250} Zaeldarr the Outcast · {area:2261} The Undercroft
	["{npc:12250} is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "{npc:12250} es élite: se recomienda ir en grupo. Espera al fondo de {area:2261}, la cripta del suroeste de la zona.",

	-- Step 31: Augustus the Touched
	-- {area:2627} Terrordale · {npc:12384} Augustus the Touched
	["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "Cabalga al norte hasta {area:2627}. {npc:12384} vive en la choza en ruinas y su libro de recibos está en la posada en ruinas cercana.",

	-- Step 32: Light's Hope Chapel
	-- {area:3197} Chillwind Camp
	["The next guide starts here and flies to {area:3197}."] = "La siguiente guía empieza aquí y vuela a {area:3197}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Zaeldarr is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "Zaeldarr es élite: se recomienda ir en grupo. Espera al fondo de {area:2261}, la cripta del suroeste de la zona.",
}
