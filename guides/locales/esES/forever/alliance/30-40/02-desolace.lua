-- Spanish (Spain) (esES): the guide forever/alliance/30-40/02-desolace (forever/alliance/30-40/02-desolace.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Menethil Harbor
	-- {zone:1455} Ironforge · {npc:1573} Gryth Thurden
	["From {zone:1455}'s {npc:1573}"] = "Desde {npc:1573}, en {zone:1455}",

	-- Step 2: Auberdine
	-- {area:442} Auberdine · {npc:3649} Thundris Windweaver
	["Take the boat to {area:442} from Menethil's docks. {npc:3649} stands in {area:442}, north of the flight master."] = "Toma el barco a {area:442} en los muelles de Puerto de Menethil. {npc:3649} está en {area:442}, al norte del maestro de vuelo.",
	-- {npc:3649} Thundris Windweaver · {item:279915} Nord'el
	["{npc:3649}: {item:279915}, from Sylessa in Menethil"] = "{npc:3649}: {item:279915}, de Sylessa en Puerto de Menethil",

	-- Step 3: Heartswood
	-- {area:415} Astranaar · {quest:1738} Heartswood · {area:413} Maestra's Post · {quest:65602} What Is Love? · {item:190309} Wooden Figurine · {area:1276} Talondeep Path
	["From {area:415} ride north-west into the hills: the {quest:1738} is a glowing tree north of the road to {area:413}. If you took {quest:65602}, the {item:190309} lies in a house among the trees north of {area:413} (26.6,22.0). Then back past {area:415} to the {area:1276}."] = "Desde {area:415}, cabalga hacia el noroeste por las colinas: {quest:1738} es un árbol brillante al norte del camino a {area:413}. Si aceptaste {quest:65602}, la {item:190309} está en una casa entre los árboles al norte de {area:413} (26.6,22.0). Después vuelve pasando por {area:415} hasta {area:1276}.",
	-- {item:190309} Wooden Figurine · {area:413} Maestra's Post
	["{item:190309}, north of {area:413}"] = "{item:190309}, al norte de {area:413}",

	-- Step 4: Talondeep Path
	-- {area:415} Astranaar · {area:1276} Talondeep Path
	["From {area:415} head south-west to the {area:1276}, a tunnel through the mountains into Stonetalon."] = "Desde {area:415}, ve al suroeste hasta {area:1276}, un túnel a través de las montañas hasta Sierra Espolón.",

	-- Step 5: Nijel's Point
	-- {area:460} Sun Rock Retreat · {area:465} Charred Vale · {zone:1443} Desolace · {area:608} Nijel's Point
	["Follow the road west past {area:460} (Horde) and south-west through the {area:465} into {zone:1443}; {area:608} stands at the top of the pass."] = "Sigue el camino hacia el oeste pasando {area:460} (Horda) y al suroeste por {area:465} hasta {zone:1443}; {area:608} está en lo alto del paso.",

	-- Step 6: Sargeron
	-- {area:603} Sargeron · {area:608} Nijel's Point
	["The Hatefury satyrs hold the ruins of {area:603}, east of {area:608}."] = "Los sátiros Odio Feroz ocupan las ruinas de {area:603}, al este de {area:608}.",

	-- Step 8: Malem chest
	["Malem chest"] = "Cofre de Malem",
	-- {area:608} Nijel's Point
	["The chest lies in the ruins south-west of {area:608}."] = "El cofre está en las ruinas al suroeste de {area:608}.",

	-- Step 10: Azore Aldamort
	-- {npc:11863} Azore Aldamort · {area:599} Thunder Axe Fortress
	["{npc:11863}'s tower stands on the hill west of {area:599}: take his quest first, the sceptre he wants is in the fortress."] = "La torre de {npc:11863} Aldamort está en la colina al oeste de {area:599}: acepta antes su misión; el cetro que quiere está en la fortaleza.",

	-- Step 11: Dalinda Malem
	-- {npc:5644} Dalinda Malem · {area:608} Nijel's Point
	["{npc:5644} hides inside the Burning Blade's fortress south-west of {area:608}."] = "{npc:5644} Malem se esconde en la fortaleza del Filo Ardiente, al suroeste de {area:608}.",

	-- Step 12: Tyranis Malem and the Seer
	-- {npc:5643} Tyranis Malem
	["{npc:5643} and the Seer"] = "{npc:5643} Malem y el Vidente",
	-- {npc:5643} Tyranis Malem · {npc:13019} Burning Blade Seer
	["Her brother {npc:5643} (36) walks the fortress with the Burning Blade cultists (30-33): pull him alone. The {npc:13019} keeps the sceptre in the fortress's main building."] = "Su hermano {npc:5643} Malem (36) recorre la fortaleza con los Fieles Filo Ardiente (30-33): atráelo solo. {npc:13019} guarda el cetro en el edificio principal de la fortaleza.",

	-- Step 13: Escort Dalinda Malem
	-- {npc:5644} Dalinda Malem
	["Escort {npc:5644}"] = "Escolta a {npc:5644} Malem",
	["Out of Thunder Axe Fortress"] = "Fuera de la Fortaleza del Hacha de Trueno",
	-- {npc:5644} Dalinda Malem · {npc:5642} Vahlarriel Demonslayer · {area:608} Nijel's Point
	["Lead {npc:5644} out of the fortress; she walks off once you are clear of it. {npc:5642} takes the turn-in at {area:608} at the end of the guide."] = "Saca a {npc:5644} Malem de la fortaleza; se marcha cuando estéis fuera. {npc:5642} recibe la entrega en {area:608} al final de la guía.",

	-- Step 15: Scorpashi venom
	["Scorpashi venom"] = "Veneno Scorpashi",
	-- {area:2407} Kormek's Hut
	["The Scorpashi scorpids hunt the hills around {area:2407} on the road south."] = "Los escórpidos Scorpashi cazan en las colinas alrededor de {area:2407}, en el camino al sur.",

	-- Step 16: Cork Gizelton
	-- {area:2407} Kormek's Hut
	["The Gizelton Caravan waits at {area:2407}."] = "La caravana Gizelton espera en {area:2407}.",

	-- Step 17: Escort the caravan
	["Escort the caravan"] = "Escolta la caravana",
	-- {area:609} Kolkar Village · {area:2617} Scrabblescrew's Camp
	["Walk with the caravan south past {area:609}; Kolkar ambushers jump it on the way. Stay close until it stops at {area:2617}. The ambushers are 34-35 and come in waves: skip it if you are below 33."] = "Acompaña a la caravana hacia el sur pasando {area:609}; los Emboscadores Kolkar la asaltan por el camino. Quédate cerca hasta que pare en {area:2617}. Los emboscadores son de nivel 34-35 y vienen en oleadas: omítela si eres de nivel inferior a 33.",

	-- Step 18: Smeed Scrabblescrew
	-- {npc:11596} Smeed Scrabblescrew · {area:609} Kolkar Village · {area:596} Kodo Graveyard
	["{npc:11596}'s camp is on the road south of {area:609}, by the {area:596}."] = "El campamento de {npc:11596} está en el camino al sur de {area:609}, junto a {area:596}.",

	-- Step 19: Kodo Graveyard
	-- {npc:11596} Smeed Scrabblescrew · {item:13892} Kodo Kombobulator · {npc:4700} Aged Kodo
	-- plural, as words: Aged Kodos = {npc:4700} Aged Kodo
	["Use {npc:11596}'s {item:13892} on an {npc:4700} and walk the tamed kodo back to his camp, five times; Aged Kodos also drop the hides."] = "Usa el {item:13892} de {npc:11596} en un {npc:4700} y lleva el kodo domado a su campamento, cinco veces; los Kodos envejecidos también sueltan los pellejos.",

	-- Step 21: Kolkar Village
	-- {area:609} Kolkar Village · {npc:5752} Corporal Melkins
	["The Kolkar roam the plains around {area:609}; their ears are for {npc:5752}."] = "Los Kolkar recorren las llanuras alrededor de {area:609}; sus orejas son para {npc:5752}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {area:1276}"] = "{area:1276}",
}
