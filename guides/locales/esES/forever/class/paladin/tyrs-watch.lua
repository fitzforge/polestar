-- Spanish (Spain) (esES): the guide forever/class/paladin/tyrs-watch (forever/class/paladin/tyrs-watch.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:7328} Redemption
	["Tyr's Watch and {spell:7328}"] = "La Guardia de Tyr y {spell:7328}",
	-- {spell:7328} Redemption
	["{spell:7328} to raise fallen allies, plus a weapon and a shield for a new Forsaken paladin."] = "{spell:7328} para resucitar a aliados caídos, además de un arma y un escudo para un nuevo paladín renegado.",

	-- Step 1: Shari Stilwell
	-- {npc:246152} Shari Stilwell · {area:159} Brill
	["{npc:246152}, who trains Paladins in {area:159}, sends you to the order's keep on the west coast."] = "{npc:246152}, que entrena a los paladines en {area:159}, te envía a la fortaleza de la orden en la costa oeste.",

	-- Step 2: Bandarion Keep
	-- {area:16602} Bandarion Keep · {area:156} Solliden Farmstead · {npc:246349} Breton Samuels
	["{area:16602} stands on the bluffs north-west of the {area:156}. {npc:246349} waits at the gate."] = "{area:16602} se alza en los riscos al noroeste de la {area:156}. {npc:246349} espera en la puerta.",

	-- Step 3: Murlocs at the Gates
	["The Vile Fin murlocs lurk on the bluffs along the road east of the keep and in the camps around the lake to the west."] = "Los múrlocs Anca Vil acechan en los riscos junto al camino al este de la fortaleza y en los campamentos alrededor del lago, al oeste.",
	-- plural, as words: Vile Fin Attackers = {npc:250283} Vile Fin Attacker
	["Vile Fin Attackers"] = "Atacantes Anca Vil",
	-- plural, as words: Vile Fin Seers = {npc:250282} Vile Fin Seer
	["Vile Fin Seers"] = "Videntes Anca Vil",

	-- Step 5: Danitha Morr
	-- {npc:246378} Danitha Morr · {npc:246393} Jorin Croge
	["{npc:246378} leads the order from inside the keep; {npc:246393} stands beside it."] = "{npc:246378} dirige la orden desde el interior de la fortaleza; {npc:246393} está a su lado.",

	-- Step 6: Shadowvale
	-- {quest:91317} The Tarnished · {area:16881} Shadowvale · {area:16616} Whispering Forest · {item:246213} Sturdy Lumber · {npc:259431} Rudolph Gelhardt
	["{quest:91317} hold the ruined village of {area:16881} in the {area:16616}, south-west of the keep. The {item:246213} is piled in the root cellar of one of its houses; Commander {npc:259431} walks among his Tarnished."] = "{quest:91317} ocupan la aldea en ruinas de {area:16881}, en {area:16616}, al suroeste de la fortaleza. {item:246213} está apilada en la bodega de una de sus casas; el comandante {npc:259431} camina entre sus mancillados.",
	-- {object:554626} Lumber Pile
	["{object:554626}, in the root cellar"] = "{object:554626}, en la bodega",
	-- plural, as words: Tarnished Drudges = {npc:259434} Tarnished Drudge
	["Tarnished Drudges"] = "Braceros mancillados",
	-- plural, as words: Tarnished Zealots = {npc:259433} Tarnished Zealot
	["Tarnished Zealots"] = "Zelotes mancillados",

	-- Step 7: Back to the keep
	["Back to the keep"] = "Vuelve a la fortaleza",

	-- Step 8: A Lesson in Divinity
	-- {npc:246378} Danitha Morr
	["{npc:246378} offers the first Lesson in Divinity at level 12."] = "{npc:246378} ofrece la primera lección de divinidad a nivel 12.",

	-- Step 9: The Undercity
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter · {npc:257648} Tanis Alderwood · {object:36078} Trade Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:10181} holds court in the {object:36126}; {npc:257648} begs in the {object:36078}."] = "Ve al sur desde {area:159} hasta las {area:153} y baja a {zone:1458}. {npc:10181} preside su corte en el {object:36126}; {npc:257648} mendiga en el {object:36078}.",

	-- Step 10: Linen Cloth
	-- {npc:257648} Tanis Alderwood · {item:2589} Linen Cloth
	-- plural, as words: Scarlet Zealots = {npc:1537} Scarlet Zealot · Scarlet Friars = {npc:1538} Scarlet Friar
	["{npc:257648} needs 10 {item:2589}. Scarlet Zealots and Scarlet Friars drop it about three times in ten; bring it along if you already carry some."] = "{npc:257648} necesita 10 de {item:2589}. Los Integristas Escarlata y los Frailes Escarlata lo sueltan unas tres veces de cada diez; tráelo si ya llevas.",

	-- Step 12: The Symbol of Life
	-- {item:6866} Symbol of Life
	["The {item:6866}"] = "{item:6866}",
	-- {area:16602} Bandarion Keep · {npc:246378} Danitha Morr · {item:6866} Symbol of Life · {npc:257655} Deathguard Billmuth
	["Back to {area:16602}. {npc:246378} gives you the {item:6866}; {npc:257655} waits downstairs in the keep."] = "Vuelve a {area:16602}. {npc:246378} te da {item:6866}; {npc:257655} espera en la planta baja de la fortaleza.",

	-- Step 13: Deathguard Falgan
	-- {area:812} Venomweb Vale · {item:6866} Symbol of Life · {npc:257663} Deathguard Falgan · {npc:246378} Danitha Morr
	["{area:812} is at the far east end of the glades. Use the {item:6866} on {npc:257663}, then speak to him. If you lose the symbol, {npc:246378} gives you another."] = "{area:812} está en el extremo este de los claros. Usa {item:6866} en {npc:257663} y luego habla con él. Si pierdes el símbolo, {npc:246378} te da otro.",

	-- Step 14: The Scarlet attack plans
	["The Scarlet attack plans"] = "Los planes de ataque Escarlata",
	-- {area:812} Venomweb Vale
	-- plural, as words: Scarlet Crusaders = {npc:239036} Scarlet Crusader
	["The Scarlet Crusaders camped around {area:812} carry the attack plans."] = "Los Cruzados Escarlata acampados alrededor de {area:812} llevan los planes de ataque.",

	-- Step 15: Redemption
	-- {area:16602} Bandarion Keep · {npc:246378} Danitha Morr · {spell:7328} Redemption
	["Back to {area:16602}: Billmuth takes the plans, {npc:246378} teaches you {spell:7328}."] = "Vuelve a {area:16602}: Billmuth recoge los planes y {npc:246378} te enseña {spell:7328}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{object:181686}, in the root cellar"] = "{object:181686}, en la bodega",
}
