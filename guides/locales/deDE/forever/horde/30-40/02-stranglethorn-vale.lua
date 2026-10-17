-- German (deDE): the guide forever/horde/30-40/02-stranglethorn-vale (forever/horde/30-40/02-stranglethorn-vale.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Zeppelin to {object:3202}"] = "Zeppelin nach {object:3202}",
	-- {zone:1458} Undercity · {object:3202} Grom'gol (no name in this language: may be words)
	["Leave the {zone:1458} by the lift and walk up through the ruins to the zeppelin towers; the {object:3202} zeppelin is the one on the south-west tower."] = "Verlass {zone:1458} mit dem Aufzug und geh durch die Ruinen hinauf zu den Zeppelintürmen; der Zeppelin nach {object:3202} ist der am südwestlichen Turm.",
	["Zeppelin towers"] = "Zeppelintürme",

	-- Step 2: Grom'gol Base Camp
	["The zeppelin lands at the tower on the west side of the camp."] = "Der Zeppelin landet am Turm auf der Westseite des Lagers.",

	-- Step 3: Orgrimmar
	-- {zone:1454} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words)
	["Take the {zone:1454} zeppelin from the tower on the west side of {object:3202} and train in the city before you fly on."] = "Nimm den Zeppelin nach {zone:1454} vom Turm auf der Westseite von {object:3202} und trainiere in der Stadt, bevor du weiterfliegst.",

	-- Step 4: Islen Waterseer
	-- {zone:1454} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words) · {area:392} Ratchet · {npc:5901} Islen Waterseer
	["Take the {zone:1454} zeppelin from the tower on the west side of {object:3202} and fly to {area:392}. {npc:5901} camps on the coast a short ride south of it."] = "Nimm den Zeppelin nach {zone:1454} vom Turm auf der Westseite von {object:3202} und flieg nach {area:392}. {npc:5901} lagert an der Küste, ein kurzes Stück südlich davon.",
	-- {npc:5901} Islen Waterseer · {npc:3527} Healing Stream Totem · {item:5177} Water Totem
	["{npc:5901}: {npc:3527} and your {item:5177}"] = "{npc:5901}: {npc:3527} und dein {item:5177}",

	-- Step 5: Back to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Back to {object:3202}"] = "Zurück nach {object:3202}",

	-- Step 6: Nesingwary's camp
	["Nesingwary's camp"] = "Lager von Nesingwary",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {quest:338} The Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. From here on, keep every page of {quest:338} you loot: {npc:716} asks for them later."] = "Folge der Straße von {object:3202} nach Norden; Nesingwarys Jagdlager liegt auf dem Hügel nordöstlich des Flusses. Ab hier behältst du jede Seite von {quest:338}, die du erbeutest: {npc:716} Stonepot will sie später.",

	-- Step 7: Young tigers and panthers
	["Young tigers and panthers"] = "Junge Tiger und Panther",
	-- plural, as words: Young Stranglethorn Tigers = {npc:681} Young Stranglethorn Tiger · Young Panthers = {npc:683} Young Panther
	["Young Stranglethorn Tigers prowl west of the camp, Young Panthers south and east of it."] = "Junge Schlingendorntiger streifen westlich des Lagers umher, Junge Panther südlich und östlich davon.",

	-- Step 9: Tigers and panthers
	["Tigers and panthers"] = "Tiger und Panther",
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["Stranglethorn Tigers and Panthers (32-33) roam the hills east of the camp, along the lake shore."] = "Schlingendorntiger und Panther (32-33) streifen durch die Hügel östlich des Lagers am Seeufer.",

	-- Step 10: Raptors and the Bloodscalp trolls
	["Raptors and the Bloodscalp trolls"] = "Raptoren und die Trolle der Bloodscalp",
	-- {item:4614} Pendant of Myzrael
	-- plural, as words: Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Head west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it."] = "Geh westlich am Lager vorbei. Schlingendornraptoren (33-34) jagen auf den Lichtungen, und die Trolle der Bloodscalp halten die Ruinen an der Küste: Jeder von ihnen kann einen Hauer droppen. Ein {item:4614} ist ein sehr seltener Drop von ihnen: Wenn einer droppt, lies ihn.",

	-- Step 12: Elder tigers and Lashtail raptors
	["Elder tigers and Lashtail raptors"] = "Alte Tiger und Schmetterschwänze",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger · Lashtail Raptors = {npc:686} Lashtail Raptor
	["The Elder Stranglethorn Tigers (34-35) roam the hills south-west of the camp; the Lashtail Raptors (35-36) hunt further south, towards {object:3202}."] = "Die Alten Schlingendorntiger (34-35) streifen durch die Hügel südwestlich des Lagers; die Schmetterschwänze (35-36) jagen weiter südlich, Richtung {object:3202}.",

	-- Step 13: Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Follow the road south to {object:3202}."] = "Folge der Straße nach Süden nach {object:3202}.",

	-- Step 14: Nesingwary's camp
	["Back north to the camp."] = "Zurück nach Norden zum Lager.",

	-- Step 15: Sin'Dall
	-- {npc:729} Sin'Dall
	["{npc:729}, a level 37 tiger, prowls the hilltop south-west of the camp."] = "{npc:729}, ein Tiger der Stufe 37, streift über die Hügelkuppe südwestlich des Lagers.",

	-- Step 17: Bloodscalp headhunters
	["Bloodscalp headhunters"] = "Kopfjäger der Bloodscalp",
	-- plural, as words: Bloodscalp Headhunters = {npc:671} Bloodscalp Headhunter
	["The Bloodscalp Headhunters (36-37) in the village on the coast carry the shrunken heads."] = "Die Kopfjäger der Bloodscalp (36-37) im Dorf an der Küste tragen die Schrumpfköpfe.",

	-- Step 18: Hearth to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Hearth to {object:3202}"] = "Ruhestein nach {object:3202}",

	-- Step 19: Booty Bay
	-- {area:35} Booty Bay · {npc:2858} Gringer
	["Follow the road south to {area:35} at the southern tip of the vale and enter through the tunnel in the cliffs. Stay on the road: the jungle beside it is well above your level. {npc:2858}, the Horde flight master, waits on the upper deck."] = "Folge der Straße nach Süden nach {area:35} an der Südspitze des Tals und geh durch den Tunnel in den Klippen hinein. Bleib auf der Straße: Der Dschungel daneben liegt weit über deiner Stufe. {npc:2858}, der Flugmeister der Horde, wartet auf dem oberen Deck.",

	-- Step 20: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Flieg nach {object:3202}",

	-- Step 21: The camp by the river
	["The camp by the river"] = "Das Lager am Fluss",
	-- {npc:773} Krazek
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["{npc:773}'s missing hunters' camp is Nesingwary's: walk among its tents and the investigation completes. River Crocolisks lie along the river below the camp."] = "Das Lager der vermissten Jäger von {npc:773} ist das von Nesingwary: Geh zwischen den Zelten umher, dann ist die Untersuchung abgeschlossen. Flusskrokilisken liegen am Fluss unterhalb des Lagers.",

	-- Step 22: Basilisks and the Bloodscalp village
	["Basilisks and the Bloodscalp village"] = "Basilisken und das Dorf der Bloodscalp",
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear."] = "Westlich am Lager vorbei sitzen Kristallrückenbasilisken (34-35) auf den Felsen; jeder Troll der Bloodscalp im Dorf dahinter kann ein Ohr droppen.",

	-- Step 23: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Flieg nach {area:35}",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {area:35} Booty Bay
	["Ride south down the coast to {object:3202} and fly to {area:35}."] = "Reite die Küste hinunter nach Süden nach {object:3202} und flieg nach {area:35}.",

	-- Step 24: Fly to Grom'gol
	-- {npc:2497} Nimboya
	["{npc:2497}: for Arathi, later on the route"] = "{npc:2497}: für das Arathihochland, später auf der Route",

	-- Step 25: Lashtail raptors
	["Lashtail raptors"] = "Schmetterschwänze",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["The Lashtail Raptors (35-36) hunt the jungle just north-east of {object:3202}."] = "Die Schmetterschwänze (35-36) jagen im Dschungel gleich nordöstlich von {object:3202}.",

	-- Step 27: Mosh'Ogg camp
	["Mosh'Ogg camp"] = "Lager der Mosh'Ogg",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The Mosh'Ogg ogres camp in the hills just east of {object:3202}. Kill one Brute and one Witch Doctor (36-37); pull them one at a time."] = "Die Oger der Mosh'Ogg lagern in den Hügeln gleich östlich von {object:3202}. Töte einen Schläger der Mosh'Ogg und einen Hexendoktor der Mosh'Ogg (36-37); zieh sie einzeln.",

	-- Step 28: Shadowmaw jungle and the Snapjaw river
	["Shadowmaw jungle and the Snapjaw river"] = "Dschungel der Schattentatzen und Fluss der Schnappkiefer",
	-- {npc:2495} Drizzlik
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["East of the ogres, Shadowmaw Panthers (37-38) stalk unseen until they strike; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}."] = "Östlich der Oger schleichen Schattentatzenpanther (37-38) ungesehen, bis sie zuschlagen; Schlingendorntigerinnen streifen im selben Gebiet und droppen ab und zu einen makellosen Fangzahn. Schnappkieferkrokilisken säumen den Fluss gleich westlich des Dschungels; behalte ihre Häute für {npc:2495}.",

	-- Step 29: Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Back to {object:3202}."] = "Zurück nach {object:3202}.",

	-- Step 30: The Vile Reef
	-- {area:104} Vile Reef · {item:4094} Tablet Shard
	["North-west of Grom'gol the {area:104} lies under the water off the coast. The {item:4094} rests on the sea floor by the sunken ruins; watch your breath and the murlocs."] = "Nordwestlich von Grom'gol liegt {area:104} unter Wasser vor der Küste. Die {item:4094} liegt auf dem Meeresgrund bei den versunkenen Ruinen; achte auf deinen Atem und die Murlocs.",

	-- Step 31: Bloodscalp ruins
	["Bloodscalp ruins"] = "Ruinen der Bloodscalp",
	-- {item:3915} Bloody Bone Necklace · {quest:338} The Green Hills of Stranglethorn
	["The Bloodscalp trolls hold the ruins up the coast north of the reef and the village beyond; every one can drop a {item:3915}. Keep looting pages of {quest:338}."] = "Die Trolle der Bloodscalp halten die Ruinen an der Küste nördlich des Riffs und das Dorf dahinter; jeder kann eine {item:3915} droppen. Erbeute weiter Seiten von {quest:338}.",

	-- Step 32: Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Ride back south to {object:3202}."] = "Reite zurück nach Süden nach {object:3202}.",

	-- Step 33: Nesingwary's camp
	["Follow the road north to the camp."] = "Folge der Straße nach Norden zum Lager.",

	-- Step 34: Green Hills pages
	["Green Hills pages"] = "Seiten der Grünen Hügel",
	-- {item:2755} Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; keep every page you loot and look on the auction house for the rest. {npc:716} takes the chapters later in this guide."] = "Seiten von {item:2755} droppen mit je etwa 1% von den Trollen der Bloodscalp und der Skullsplitter; behalte jede Seite, die du erbeutest, und schau im Auktionshaus nach dem Rest. {npc:716} Stonepot nimmt die Kapitel später in diesem Guide.",

	-- Step 35: Shadowmaw panthers
	["Shadowmaw panthers"] = "Schattentatzenpanther",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers (37-38) stalk the jungle east of the Mosh'Ogg hills and north-east towards the lake; they strike from stealth. Loot every Green Hills page you find on the way."] = "Die Schattentatzenpanther (37-38) schleichen durch den Dschungel östlich der Hügel der Mosh'Ogg und nordöstlich Richtung See; sie greifen aus der Verstohlenheit an. Erbeute unterwegs jede Seite der Grünen Hügel.",

	-- Step 36: Green Hills pages
	-- {item:2755} Green Hills of Stranglethorn
	["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; take what drops and check the Auction House for the rest."] = "Seiten von {item:2755} droppen mit je etwa 1% von den Trollen der Bloodscalp und der Skullsplitter; nimm, was droppt, und schau im Auktionshaus nach dem Rest.",

	-- Step 39: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "Dschungelpirscher",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights."] = "Die Dschungelpirscher (40-41) jagen an der Küste südlich von {object:3202}. Sie liegen weit über dir: Zieh sie einzeln und ruh dich zwischen den Kämpfen aus.",

	-- Step 41: Mistvale gorillas
	["Mistvale gorillas"] = "Nebeltalgorillas",
	-- {area:35} Booty Bay · {area:1737} Mistvale Valley
	-- plural, as words: Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["Take the road south towards {area:35}. The Elder Mistvale Gorillas (40-41) live in {area:1737}, east of the road; about one in twenty carries an aged sinew."] = "Nimm die Straße nach Süden Richtung {area:35}. Die Alten Nebeltalgorillas (40-41) leben im {area:1737}, östlich der Straße; etwa jeder zwanzigste trägt eine Sehne eines alten Gorillas.",

	-- Step 42: Booty Bay
	-- {area:35} Booty Bay
	["Follow the road on south into {area:35}."] = "Folge der Straße weiter nach Süden nach {area:35}.",
	-- {npc:2495} Drizzlik
	["{npc:2495}: the Snapjaw skins gathered earlier"] = "{npc:2495}: die Schnappkieferkrokiliskenhäute von vorhin",

	-- Step 44: Venture Co. camp
	["Venture Co. camp"] = "Lager der Venture Co.",
	-- plural, as words: Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Ride north past Nesingwary's camp to the lake. The Venture Co. Geologists (34-36) work the camps along its western shore; they carry the Tumbled Crystals."] = "Reite nördlich an Nesingwarys Lager vorbei zum See. Die Geologen der Venture Co. (34-36) arbeiten in den Lagern am Westufer; sie tragen die Gerommelten Kristalle.",

	-- Step 45: Hearth to Booty Bay
	-- {area:35} Booty Bay
	["Hearth to {area:35}"] = "Ruhestein nach {area:35}",
	-- {area:272} Tarren Mill · {zone:1417} Arathi Highlands
	["The next guide flies you north to {area:272} and into the {zone:1417}."] = "Der nächste Guide fliegt dich nach Norden nach {area:272} und ins {zone:1417}.",
}
