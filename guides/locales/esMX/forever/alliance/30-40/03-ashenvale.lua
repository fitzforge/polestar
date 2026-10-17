-- Spanish (Latin America) (esMX): the guide forever/alliance/30-40/03-ashenvale (forever/alliance/30-40/03-ashenvale.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Astranaar
	-- {area:608} Nijel's Point
	["From {area:608}"] = "Desde {area:608}",
	-- {npc:3970} Llana · {npc:1480} Caitlin Grassman
	["{npc:3970}: for {npc:1480} in Menethil, at the end of this guide"] = "{npc:3970}: para {npc:1480} en Menethil, al final de esta guía",

	-- Step 2: Delgren the Purifier
	-- {area:415} Astranaar · {area:413} Maestra's Post
	["Follow the road west out of {area:415}; {area:413} lies north of it."] = "Sigue el camino al oeste desde {area:415}; {area:413} está al norte de él.",

	-- Step 3: Melyria and Illiyana
	-- {npc:3901} Illiyana
	["Melyria and {npc:3901}"] = "Melyria Sombrigélida y {npc:3901}",
	["The two stand together at the western end of the road."] = "Las dos están juntas en el extremo oeste del camino.",

	-- Step 4: Shael'dryn
	-- {area:415} Astranaar
	["The moonwell lies in the hills north-east of {area:415}."] = "El pozo de la luna está en las colinas al noreste de {area:415}.",

	-- Step 5: Dartol's Rod
	["Dartol's Rod"] = "Vara de transformación de Dartol",
	-- {item:5475} Wooden Key
	-- plural, as words: Withered Ancients = {npc:3919} Withered Ancient
	["The Crazed and Withered Ancients north of the moonwell carry the {item:5475}; the worn chest it opens stands among them."] = "Los ancianos enloquecidos y marchitos al norte del pozo de la luna llevan la {item:5475}; el cofre desgastado que abre está entre ellos.",

	-- Step 6: The Howling Vale
	-- {area:419} Howling Vale
	["Take the tunnel into the {area:419}; the tome lies in the ruins at its west end."] = "Toma el túnel hacia {area:419}; el tomo está en las ruinas de su extremo oeste.",

	-- Step 8: Anilia
	-- {area:429} Xavian · {npc:3920} Anilia
	["Follow the road east to the satyr camps of {area:429}; {npc:3920} hides at their edge."] = "Sigue el camino al este hasta los campamentos sátiros de {area:429}; {npc:3920} se esconde en su borde.",

	-- Step 9: Geltharis
	-- {npc:4619} Geltharis · {area:429} Xavian
	["{npc:4619} leads the {area:429} satyrs; he carries the branch."] = "{npc:4619} dirige a los sátiros de {area:429}; él lleva la rama.",

	-- Step 10: Satyrnaar
	-- {object:19901} Circle of Imprisonment · {area:430} Satyrnaar
	["The {object:19901} stands in the satyr camp of {area:430}, further east along the road."] = "{object:19901} está en el campamento sátiro de {area:430}, más al este por el camino.",

	-- Step 11: Forest Song
	-- {area:2358} Forest Song · {npc:3848} Kayneth Stillwind
	["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} stands there."] = "{area:2358}, el puesto de los elfos de la noche en el extremo este del camino: allí está {npc:3848}.",

	-- Step 12: Bottle of Disease
	-- {area:2358} Forest Song
	["The Forsaken's camp lies in the woods south of {area:2358}."] = "El campamento de los Renegados está en el bosque al sur de {area:2358}.",

	-- Step 13: Iron Pommel
	["Rusty chests lie around the Shadethicket furbolg camps west of the Forsaken; open them until one holds the pommel."] = "Hay cofres oxidados alrededor de los campamentos fúrbolg Sombramatorral al oeste de los Renegados; ábrelos hasta que uno tenga el pomo.",

	-- Step 14: Fallen Sky Lake
	-- {npc:3931} Shadethicket Oracle · {quest:1035} Fallen Sky Lake · {object:669176} Gleaming Crescent Pendant
	["The {npc:3931} walks the shore of {quest:1035}, south-west of the chests; the {object:669176} lies north of the lake, on the way."] = "{npc:3931} recorre la orilla de {quest:1035}, al suroeste de los cofres; {object:669176} está al norte del lago, de camino.",
	-- {object:669176} Gleaming Crescent Pendant · {npc:3961} Maliynn · {area:415} Astranaar
	["{object:669176}: for {npc:3961} in {area:415}"] = "{object:669176}: para {npc:3961} en {area:415}",

	-- Step 16: Insane druids
	["Insane druids"] = "Druidas dementes",
	-- {area:2358} Forest Song
	["The three druids stand together at the Forsaken camp south of {area:2358}."] = "Los tres druidas están juntos en el campamento de los Renegados al sur de {area:2358}.",

	-- Step 18: Night Run
	-- {object:19901} Circle of Imprisonment · {area:428} Night Run
	["The second {object:19901} lies in the valley of {area:428}, on the way west."] = "El segundo {object:19901} está en el valle de {area:428}, de camino al oeste.",

	-- Step 20: Hidden Shrine
	["The shrine sits on the hill just south-east of the moonwell; follow the winding path up."] = "El santuario está en la colina justo al sureste del pozo de la luna; sube por el sendero sinuoso.",

	-- Step 23: Krolg
	-- {npc:3897} Krolg · {area:421} Mystral Lake
	["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below {area:421}."] = "{npc:3897}, un fúrbolg libre de la corrupción, está sentado al sur del camino, debajo de {area:421}.",

	-- Step 24: Ran Bloodtooth
	-- {npc:3696} Ran Bloodtooth · {npc:3897} Krolg
	["{npc:3696} and his guards camp just east of {npc:3897}."] = "{npc:3696} y sus guardias acampan justo al este de {npc:3897}.",

	-- Step 29: Auberdine
	-- {area:150} Menethil Harbor · {area:442} Auberdine
	["Take the boat to {area:150} from {area:442}'s docks."] = "Toma el barco a {area:150} desde los muelles de {area:442}.",

	-- Step 30: Glorin Steelbrow
	-- {npc:1217} Glorin Steelbrow
	["{npc:1217} stands on the upper floor of Menethil's keep."] = "{npc:1217} está en el piso superior del Castillo de Menethil.",

	-- Step 31: Waterlogged Chest
	["The wreck of the Flying Osprey lies in the shallows south of the keep."] = "El naufragio del Flying Osprey está en los bajíos al sur del Castillo de Menethil.",

	-- Step 32: Lightforge Ingots
	-- plural, as words: Lightforge Ingots = {item:2702} Lightforge Ingot
	["Lightforge Ingots"] = "Lingotes Forjaluz",
	["The Bluegill murlocs on the beach south-west of Menethil carry the ingots."] = "Los múrlocs Branquiazul de la playa al suroeste de Menethil llevan los lingotes.",

	-- Step 34: Deepwater Tavern
	-- {npc:5082} Vincent Hyal · {npc:4963} Mikhail · {npc:4962} Tapoke "Slim" Jahn · {npc:1480} Caitlin Grassman
	["{npc:5082}, {npc:4963} and Tapoke Jahn are all at Menethil's inn; {npc:4962} fights you when you talk to {npc:4963}, but gives up once beaten. {npc:1480} stands a short walk north-east of the inn."] = "{npc:5082}, {npc:4963} y {npc:4962} están en la posada de Menethil; Tapoke te ataca cuando hablas con {npc:4963}, pero se rinde al ser derrotado. {npc:1480} está a poca distancia al noreste de la posada.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back west along the road to the satyr camps of {area:429}."] = "Vuelve al oeste por el camino hasta los campamentos sátiros de {area:429}.",
	-- ["Geltharis"] = "Geltharis",
	-- ["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} and {npc:221269} stand there."] = "{area:2358}, el puesto de los elfos de la noche en el extremo este del camino: allí están {npc:3848} y {npc:221269}.",
	-- ["{area:429} satyrs"] = "Sátiros de {area:429}",
}
