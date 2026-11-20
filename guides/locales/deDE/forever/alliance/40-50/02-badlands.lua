-- German (deDE): the guide forever/alliance/40-50/02-badlands (forever/alliance/40-50/02-badlands.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thelsamar
	-- {npc:1470} Ghak Healtouch · {area:144} Thelsamar · {area:1517} Uldaman · {zone:1418} Badlands
	["{npc:1470} is below ground in {area:144}, by the inn, where the flight lands. His mushrooms grow in the {area:1517} dig at the {zone:1418}' northern edge, on this guide's loop back north."] = "{npc:1470} ist unter der Erde in {area:144}, beim Gasthaus, wo der Flug landet. Seine Pilze wachsen an der Ausgrabung von {area:1517} am Nordrand des {zone:1418}, auf der Runde dieses Guides zurück nach Norden.",
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, below ground"] = "{npc:1470}, unter der Erde",

	-- Step 3: Hammertoe's Digsite
	-- {zone:1432} Loch Modan · {zone:1418} Badlands · {npc:2860} Sigrun Ironhew
	["Ride south out of {zone:1432} through the pass into the {zone:1418}; {npc:2860} camps at the dig."] = "Reite nach Süden aus {zone:1432} durch den Pass ins {zone:1418}; {npc:2860} lagert bei der Ausgrabung.",
	-- {quest:706} Fiery Blaze Enchantments · {item:4612} Black Drake's Heart
	["{quest:706}: its {item:4612} is a rare drop, so the work and hand-in are optional too"] = "{quest:706}: {item:4612} ist ein seltener Drop, daher sind das Sammeln und die Abgabe ebenfalls optional",

	-- Step 4: Garek
	-- {npc:2888} Garek · {area:1898} Dustwind Gulch
	["{npc:2888} camps by himself in {area:1898}, south-east of the digsite."] = "{npc:2888} lagert allein in {area:1898}, südöstlich der Ausgrabungsstätte.",

	-- Step 5: Agmond's End
	-- {npc:269577} Dorgaron · {item:278404} Pristine Mattock · {quest:739} Murdaloc · {quest:705} Pearl Diving
	-- plural, as words: Blue Pearls = {item:4611} Blue Pearl · Giant Clams = {object:2744} Giant Clam
	["{npc:269577}'s {item:278404} lies in the middle of the Stonevault trogg camp, where {quest:739} walks.\nStill carrying {quest:705} without nine Blue Pearls? The Giant Clams were on the north-west Stranglethorn coast. Keep it for another visit rather than going back from here."] = "",

	-- Step 6: Valley of Fangs
	-- {npc:2817} Rigglefuzz
	-- plural, as words: Blue Pearls = {item:4611} Blue Pearl
	["{npc:2817}: Blue Pearls from Stranglethorn"] = "{npc:2817}: Blue Pearls aus Schlingendorntal",
	-- {npc:2817} Rigglefuzz
	["{npc:2817}'s next quest pays no experience: skip it."] = "Die nächste Quest von {npc:2817} gibt keine Erfahrung: Überspring sie.",

	-- Step 7: Boss Tho'grun
	-- {npc:2944} Boss Tho'grun · {area:342} Camp Boff · {zone:1418} Badlands
	["{npc:2944} does not stay at {area:342}: he walks a long loop around the {zone:1418} with his guards, from the camp in the west along the south of the zone to about 61,69, north to about 49,49 and back west to the camp. The arrow follows his loop west from here until you meet him."] = "{npc:2944} bleibt nicht bei {area:342}: Er läuft mit seinen Wachen eine lange Runde durch das {zone:1418}, vom Lager im Westen am Südrand der Zone entlang bis etwa 61,69, nach Norden bis etwa 49,49 und zurück nach Westen zum Lager. Der Pfeil folgt seiner Runde von hier aus nach Westen, bis du ihn triffst.",

	-- Step 8: Garek
	-- {area:1898} Dustwind Gulch
	["Ride back east to {area:1898}."] = "Reite zurück nach Osten zu {area:1898}.",
	-- {npc:2888} Garek
	["{npc:2888}'s next task is an elite hunt: skip it."] = "Die nächste Aufgabe von {npc:2888} ist eine Elitejagd: Überspring sie.",

	-- Step 9: Lethlor Ravine
	-- {npc:2888} Garek · {item:4612} Black Drake's Heart
	-- plural, as words: Scalding Whelps = {npc:2725} Scalding Whelp · Scorched Guardians = {npc:2726} Scorched Guardian
	["The Scalding Whelps nest in the ravine east of {npc:2888}; leave the Scorched Guardians (elite) alone. The {item:4612} drops rarely: take it if it comes while you grind."] = "Die Brühenden Welpen nisten in der Klamm östlich von {npc:2888}; lass die Versengten Wächter (Elite) in Ruhe. {item:4612} fällt selten: Nimm es mit, wenn es beim Grinden kommt.",

	-- Step 11: Dorgaron
	-- {npc:269577} Dorgaron · {zone:1432} Loch Modan
	["{npc:269577} camps at the foot of the pass into {zone:1432}, on the way north."] = "{npc:269577} lagert am Fuß des Passes nach {zone:1432}, auf dem Weg nach Norden.",

	-- Step 12: Into Loch Modan
	-- {zone:1432} Loch Modan
	["Into {zone:1432}"] = "Nach {zone:1432}",

	-- Step 13: Ironband's Excavation Site
	-- {zone:1432} Loch Modan
	["Ride north through the pass into {zone:1432} and east along the south shore to Ironband's camp."] = "Reite nach Norden durch den Pass nach {zone:1432} und nach Osten entlang des Südufers zu Ironbands Lager.",

	-- Step 14: Into Badlands
	-- {zone:1418} Badlands
	["Into {zone:1418}"] = "Hinein nach {zone:1418}",

	-- Step 15: Badlands
	-- {area:1517} Uldaman
	["The {area:1517} dig"] = "Die Ausgrabung bei {area:1517}",

	-- Step 16: The Uldaman dig
	-- {area:1517} Uldaman · {zone:1418} Badlands
	["Back through the pass: the Stonevault troggs dig outside {area:1517} at the {zone:1418}' northern edge. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "Zurück durch den Pass: Die Stonevault-Troggs graben vor {area:1517} am nördlichen Rand von {zone:1418}. Die geschnitzten Urnen und die magentafarbenen Pilzgruppen stehen in ihren Höhlen und Tunneln, außerhalb des Dungeons selbst.",
	-- {item:8047} Magenta Fungus Cap
	["{item:8047}; below ground"] = "{item:8047}; unter der Erde",
	-- {object:2743} Carved Stone Urn
	["{object:2743}; below ground"] = "{object:2743}; unter der Erde",

	-- Step 17: Back to Loch Modan
	-- {zone:1432} Loch Modan
	["Back to {zone:1432}"] = "Zurück nach {zone:1432}",

	-- Step 18: Ironband's Excavation Site
	["Ride back north to Ironband's camp."] = "Reite zurück nach Norden zu Ironbands Lager.",

	-- Step 19: Thelsamar
	-- {area:144} Thelsamar
	["Ride west along the loch to {area:144}."] = "Reite am See entlang nach Westen nach {area:144}.",

	-- Step 20: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Flieg nach {area:271}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "Flugmeister in {area:144}",

	-- Step 21: Southshore
	-- {npc:3980} Raleigh the Devout
	["{npc:3980} preaches by the inn."] = "{npc:3980} predigt beim Gasthaus.",
	-- {npc:3980} Raleigh the Devout
	["{npc:3980}, upstairs"] = "{npc:3980}, oben",
	-- {area:796} Scarlet Monastery
	["Raleigh's next errand is in the {area:796}: skip it."] = "Raleighs nächster Auftrag ist im {area:796}: Überspring ihn.",

	-- Step 22: Loremaster Dibbs
	-- {npc:2277} Loremaster Dibbs · {area:271} Southshore
	["{npc:2277} stands in {area:271}, by the inn."] = "{npc:2277} steht in {area:271}, beim Gasthaus.",

	-- Step 24: Aerie Peak
	-- {area:271} Southshore · {zone:1425} The Hinterlands · {area:348} Aerie Peak · {npc:5635} Falstad Wildhammer · {quest:1450} Gryphon Master Talonaxe · {npc:7884} Fraggar Thundermantle
	["Ride north-east out of {area:271} on the road into the {zone:1425}; {area:348} sits just past the border. {npc:5635} holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "Reite auf der Straße nach Nordosten aus {area:271} ins {zone:1425}; {area:348} liegt gleich hinter der Grenze. {npc:5635} hält oben Hof, {quest:1450} kümmert sich um den Greifenhorst und {npc:7884} steht beim Gasthaus.",
	-- {quest:1450} Gryphon Master Talonaxe
	["{quest:1450}, inside"] = "{quest:1450}, drinnen",
	-- {npc:7884} Fraggar Thundermantle
	["{npc:7884}, inside"] = "{npc:7884}, drinnen",

	-- Step 25: Rhapsody Shindigger
	-- {npc:5634} Rhapsody Shindigger · {area:348} Aerie Peak
	["{npc:5634} camps on the road east of {area:348}."] = "{npc:5634} lagert an der Straße östlich von {area:348}.",

	-- Step 26: Witherbark villages
	["Witherbark villages"] = "Dörfer der Witherbark",
	-- {npc:5634} Rhapsody Shindigger · {npc:270772} Witch Doctor Ti'ik
	["The first two cages stand together in the Witherbark village south of {npc:5634}; the third is in the next village to the east. Every Witherbark troll can drop a necklace.\nCareful: {npc:270772} (49) and his Hexed Larvae (45) keep to the huts of the western village, around 25,64: take the necklaces from the trolls outside."] = "Die ersten beiden Käfige stehen zusammen im Dorf der Witherbark südlich von {npc:5634}; der dritte ist im nächsten Dorf östlich davon. Jeder Troll der Witherbark kann eine Halskette fallen lassen.\nVorsicht: {npc:270772} (49) und seine Verhexten Larven (45) halten sich in den Hütten des westlichen Dorfs auf, bei etwa 25,64: Hol dir die Halsketten von den Trollen draußen.",

	-- Step 27: Aerie Peak
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, beside the flight master at the top; inside"] = "{npc:5636}, neben dem Flugmeister ganz oben; drinnen",
	-- {zone:1425} The Hinterlands
	["Talonaxe's next task waits for a later {zone:1425} guide."] = "Talonaxes nächste Aufgabe wartet auf einen späteren Guide für das {zone:1425}.",

	-- Step 28: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Flieg nach {area:150}",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "Flugmeister von {area:348}",

	-- Step 30: Theramore
	["Theramore"] = "Theramore",
	-- {npc:4944} Captain Garran Vimes
	["{npc:4944}, on the top floor"] = "{npc:4944}, im obersten Stockwerk",
	-- {npc:4794} Morgan Stern
	["{npc:4794}, inside"] = "{npc:4794}, drinnen",

	-- Step 31: Mudsprocket
	["Mudsprocket"] = "Morastwinkel",
	-- {area:511} Wyrmbog · {npc:270723} Drazzit Dripvalve · {npc:270727} Gizzix Grimegurgle
	["Take the road south-west out of Theramore to Mudsprocket, the goblin camp at the edge of the {area:511}. {npc:270723} and {npc:270727} stand together in the camp."] = "Nimm die Straße südwestlich aus Theramore nach Morastwinkel, dem Goblinlager am Rand des {area:511}. {npc:270723} und {npc:270727} stehen zusammen im Lager.",

	-- Step 32: The Wyrmbog
	-- {area:511} Wyrmbog
	["The {area:511}"] = "{area:511}",
	-- {item:280092} Wyrmtail
	-- plural, as words: Searing Hatchlings = {npc:4323} Searing Hatchling · Firemane Scalebanes = {npc:4328} Firemane Scalebane
	["The {item:280092} grows in the bog east of the camp: gather it first. Then the Searing Hatchlings and Whelps (41-43) and the Firemane dragonkin nest in the bog north and west of Mudsprocket, on the way back; all of them drop the shed scales.\nCareful: the Firemane Scalebanes and Flamecallers are 43-44 and cast fire: pull them one at a time."] = "Die {item:280092} wächst im Sumpf östlich des Lagers: Sammle sie zuerst. Dann nisten die Sengenden Jungtiere und Welpen (41-43) und die Drachkin der Feuermähnen im Sumpf nördlich und westlich von Morastwinkel, auf dem Rückweg; alle lassen die abgeworfenen Schuppen fallen.\nVorsicht: Die Bannschuppen und Flammenrufer der Feuermähnen sind 43-44 und wirken Feuerzauber: Zieh sie einzeln.",

	-- Step 33: Mudsprocket
	["Then ride back north-east to Theramore's flight master."] = "Reite dann zurück nach Nordosten zum Flugmeister von Theramore.",

	-- Step 34: Theramore flight master
	["Theramore flight master"] = "Flugmeister von Theramore",

	-- Step 36: Warlock: Summon Felsteed
	-- {quest:3631} Summon Felsteed
	["Warlock: {quest:3631}"] = "Hexenmeister: {quest:3631}",
	-- {zone:1413} Barrens · {area:392} Ratchet · {npc:6251} Strahad Farsan
	["From Theramore, ride north into the {zone:1413} to {area:392}, or fly if you know its flight path. {npc:6251} teaches in the house by the bank."] = "Reite von Theramore nach Norden ins {zone:1413} nach {area:392}, oder flieg, falls du die Flugroute kennst. {npc:6251} lehrt im Haus neben der Bank.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Blue Pearls from Stranglethorn"] = "Blaue Perlen aus dem Schlingendorntal",
	-- ["Fly to {area:392}; {npc:6251} teaches in the house by the bank. Fly back to Theramore afterwards."] = "Flieg nach {area:392}; {npc:6251} lehrt im Haus bei der Bank. Flieg danach zurück nach Theramore.",
	-- ["Fly to {area:608}, ride south through {zone:1443} into {zone:1444} and follow the road to the dock on the {area:1108}; the boat crosses to {area:1116}, where the next guide starts."] = "Flieg nach {area:608}, reite nach Süden durch {zone:1443} nach {zone:1444} und folge der Straße zum Steg an der {area:1108}; das Schiff fährt hinüber zur {area:1116}, wo der nächste Guide beginnt.",
	-- ["Inside {area:498}"] = "In {area:498}",
	-- ["On to Feathermoon"] = "Weiter nach Feathermoon",
	-- ["Ride north to {area:144} and fly to {area:271}. {npc:3980} preaches by the inn."] = "Reite nach Norden nach {area:144} und flieg nach {area:271}. {npc:3980} predigt beim Gasthaus.",
	-- ["Ride north-east out of {area:271} on the road into the {area:47}; {area:348} sits just past the border. {npc:5635} holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "Reite auf der Straße nach Nordosten aus {area:271} ins {area:47}; {area:348} liegt gleich hinter der Grenze. {npc:5635} hält oben Hof, {quest:1450} kümmert sich um den Greifenhorst und {npc:7884} steht beim Gasthaus.",
	-- ["Ride north-east out of {area:271} on the road into the {zone:1425}; {area:348} sits just past the border. Falstad holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "Reite auf der Straße nach Nordosten aus {area:271} ins {zone:1425}; {area:348} liegt gleich hinter der Grenze. Falstad hält oben Hof, {quest:1450} kümmert sich um den Greifenhorst und {npc:7884} steht beim Gasthaus.",
	-- ["Ride south out of {zone:1432} through the pass into the {zone:1418}; {npc:2860} camps at the dig."] = "Reite nach Süden aus {zone:1432} durch den Pass ins {zone:1418}; {npc:2860} lagert bei der Ausgrabung.",
	-- ["Ride west across the {area:3} to the Dustbelcher camp at {area:342}. {npc:2944} stands in its middle with Wyrmhunters and Maulers around him."] = "Reite nach Westen durch das {area:3} zum Lager der Staubspeier bei {area:342}. {npc:2944} steht in der Mitte, umgeben von Wyrmjägern und Raufern.",
	-- ["Ride west across the {zone:1418} to the Dustbelcher camp at {area:342}. {npc:2944} stands in its middle with Wyrmhunters and Maulers around him."] = "Reite nach Westen durch das {zone:1418} zum Lager der Staubspeier bei {area:342}. {npc:2944} steht in der Mitte, umgeben von Wyrmjägern und Raufern.",
	-- ["Ride west to the {area:1877} in the middle of the {zone:1418}; {npc:2817} camps beside Martek."] = "Reite nach Westen ins {area:1877} mitten im {zone:1418}; {npc:2817} lagert neben Martek.",
	-- ["Take the boat to Theramore from the far pier."] = "Nimm vom hinteren Pier das Schiff nach Theramore.",
	-- ["Talonaxe's next task waits for a later {area:47} guide."] = "Talonaxes nächste Aufgabe wartet auf einen späteren Guide für das {area:47}.",
	-- ["The battered skeleton lies at the edge of the Stonevault trogg camp; {quest:739}, Agmond's killer, walks among the Bonesnappers."] = "Das zerschlagene Skelett liegt am Rand des Lagers der Steingrufttroggs; {quest:739}, Agmonds Mörder, läuft zwischen den Knochenknackern herum.",
	-- ["grind on {npc:2725} at {area:339}, {zone:1418}"] = "grinde {npc:2725} in {area:339}, {zone:1418}",
	-- ["{npc:1573}, the {object:32372}"] = "{npc:1573}, {object:32372}",
	-- ["{npc:2616} stands on the docks where the boat lands."] = "{npc:2616} steht an den Docks, wo das Schiff anlegt.",
	-- ["{npc:269577}'s {item:278404} lies in the middle of the Stonevault trogg camp, where {quest:739} walks."] = "Die {item:278404} für {npc:269577} liegt mitten im Lager der Steingewölbetroggs, wo {quest:739} umherläuft.",
	-- ["{npc:2888} camps by himself in {area:1898}, south-east of the digsite."] = "{npc:2888} lagert allein in {area:1898}, südöstlich der Ausgrabungsstätte.",
	-- ["{npc:4968}, on the top floor"] = "{npc:4968}, im obersten Stockwerk",
	-- ["{npc:5634}'s cocktail needs parts from Kalimdor: skip it."] = "{npc:5634}s Cocktail braucht Zutaten aus Kalimdor: Überspring ihn.",
	-- ["{npc:5636}, beside the flight master at the top"] = "{npc:5636}, oben neben dem Flugmeister",
	-- ["{npc:7744}; below ground"] = "{npc:7744}; unter der Erde",
	-- ["{npc:7884} keeps paying for necklaces: hand in any extras"] = "{npc:7884} zahlt weiter für Halsketten: Gib alle übrigen ab",
}
