-- German (deDE): the guide forever/horde/02-the-barrens (forever/horde/02-the-barrens.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Far Watch Post
	-- {zone:1454} Orgrimmar · {zone:1411} Durotar · {area:814} Southfury River · {area:379} Far Watch Post · {zone:1413} The Barrens · {npc:3337} Kargal Battlescar · {quest:809} Ak'Zeloth · {npc:5810} Uzzek
	["Leave {zone:1454} by the main gate and follow the road south through {zone:1411}, then west over the {area:814} bridge: {area:379} sits just above it on the {zone:1413} side. {npc:3337}, {quest:809} and {npc:5810} stand together."] = "Verlasse {zone:1454} durch das Haupttor und folge der Straße nach Süden durch {zone:1411}, dann westlich über die Brücke von {area:814}: {area:379} liegt direkt oberhalb davon auf der Seite von {zone:1413}. {npc:3337}, {quest:809} und {npc:5810} stehen zusammen.",
	-- {npc:3337} Kargal Battlescar · {quest:840} Conscript of the Horde · {zone:1411} Durotar
	["{npc:3337}: {quest:840}, from {zone:1411}"] = "{npc:3337}: {quest:840}, aus {zone:1411}",
	-- {quest:809} Ak'Zeloth · {npc:3337} Kargal Battlescar · {npc:3216} Neeru Fireblade · {zone:1454} Orgrimmar
	["{quest:809}, beside {npc:3337}: from {npc:3216} in {zone:1454}"] = "{quest:809}, neben {npc:3337}: von {npc:3216} in {zone:1454}",

	-- Step 3: Far Watch Post
	-- {zone:1454} Orgrimmar · {zone:1411} Durotar · {area:814} Southfury River · {npc:5810} Uzzek · {area:379} Far Watch Post
	["Leave {zone:1454} by the main gate and follow the road south through {zone:1411}, then west over the {area:814} bridge: {npc:5810} stands at {area:379} just above it, on the road to the Crossroads."] = "Verlasse {zone:1454} durch das Haupttor und folge der Straße nach Süden durch {zone:1411}, dann westlich über die Brücke von {area:814}: {npc:5810} steht direkt darüber bei {area:379}, an der Straße zum Wegekreuz.",

	-- Step 4: The Crossroads
	-- {area:379} Far Watch Post · {npc:3489} Zargh · {npc:3338} Sergra Darkthorn · {npc:3464} Gazrog · {npc:3615} Devrak · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger
	["You arrive from {area:379}. {npc:3489} and {npc:3338} stand by the inn, Helbrim and {npc:3464} by the north gate; {npc:3615}, {npc:3429} and {npc:3449} on the tower platform."] = "Du kommst von {area:379}. {npc:3489} und {npc:3338} stehen beim Gasthaus, Helbrim und {npc:3464} am Nordtor; {npc:3615}, {npc:3429} und {npc:3449} auf der Turmplattform.",
	-- {npc:3390} Apothecary Helbrim · {quest:1358} Sample for Helbrim
	["{npc:3390}: {quest:1358}, from Zinge"] = "{npc:3390}: {quest:1358}, von Zinge",
	-- {npc:3615} Devrak
	["{npc:3615}, on the tower"] = "{npc:3615}, auf dem Turm",
	-- {npc:3449} Darsok Swiftdagger · {area:383} Dry Hills
	["{npc:3449}: the harpies come later, in the {area:383}"] = "{npc:3449}: Die Harpyien kommen später, in {area:383}",

	-- Step 5: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:392} Ratchet
	["{npc:5878} camps beside the road east toward {area:392}."] = "{npc:5878} lagert an der Straße nach Osten Richtung {area:392}.",

	-- Step 6: Razormane camp
	["Razormane camp"] = "Lager der Grimmhauer",
	-- {object:58369} Stolen Iron Chest · {item:5026} Fire Tar
	["The Razormane camp lies east of the Crossroads. Warriors: the {object:58369} stands in the camp. Shamans: the quilboar drop the {item:5026}.\nCareful: The chest stands next to a broken wagon, guarded by a pair of Razormanes, including hunters that can pull more quilboar into the fight."] = "Das Lager der Klingenmähnen liegt östlich des Wegekreuzes. Krieger: Die {object:58369} steht im Lager. Schamanen: Die Stacheleber lassen den {item:5026} fallen.\nVorsicht: Die Truhe steht neben einem kaputten Wagen und wird von zwei Klingenmähnen bewacht, darunter Jäger, die weitere Stacheleber in den Kampf ziehen können.",

	-- Step 7: Razormane camp: Thork's quilboar
	-- {npc:3429} Thork
	["Razormane camp: {npc:3429}'s quilboar"] = "Lager der Klingenmähnen: die Stacheleber von {npc:3429}",
	-- {npc:3429} Thork
	-- plural, as words: Razormane Flesheaters = {npc:267308} Razormane Flesheater
	["While you are in the camp: {npc:3429}'s Water Seekers and Thornweavers in its western half, the Hunters in the middle, the supply crates at its eastern end.\nCareful: Razormane Flesheaters and Berserkers (18-19) are elites; they stand in the camp's north-east, beside the supply crates: pull the quilboar away from them one at a time."] = "Wenn du schon im Lager bist: die Wassersucher und Dornenwirker für {npc:3429} in der westlichen Hälfte, die Jäger in der Mitte, die Vorratskisten am östlichen Ende.\nVorsicht: Fleischfresser und Berserker der Grimmhauer (18-19) sind Elites; sie stehen im Nordosten des Lagers neben den Vorratskisten: Zieh die Stacheleber einzeln von ihnen weg.",

	-- Step 9: Telf Joolam
	-- {npc:5900} Telf Joolam · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember
	["Back east over the bridge and up the trail to {npc:5900}'s shrine again. {npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "Zurück nach Osten über die Brücke und den Pfad hinauf wieder zum Schrein von {npc:5900}. {npc:5900} stellt aus dem Teer und dem Beutel {item:6636} her. Benutze es am Kohlebecken neben ihm, um die {npc:5893} sichtbar zu machen, töte sie für die {item:6655} und lege die Glut dann ins Kohlebecken.",

	-- Step 11: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:5907}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:5907}: {npc:2523}, dein {item:5176} und {item:263412}",

	-- Step 13: The Crossroads
	-- {area:380} The Crossroads · {npc:3338} Sergra Darkthorn · {npc:3464} Gazrog · {npc:3615} Devrak · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger · {npc:3448} Tonga Runetotem
	["{area:380} is your base for this guide. Everyone you need stands within a few steps of the inn: {npc:3338} by the inn, Helbrim and {npc:3464} by the north gate, then up the tower to {npc:3615}, the wind rider master, {npc:3429} and {npc:3449}, and {npc:3448} at the south gate on the way out."] = "{area:380} ist deine Basis für diesen Guide. Alle, die du brauchst, stehen nur wenige Schritte vom Gasthaus entfernt: {npc:3338} beim Gasthaus, Helbrim und {npc:3464} am Nordtor, dann den Turm hinauf zu {npc:3615}, dem Windreitermeister, {npc:3429} und {npc:3449}, und {npc:3448} am Südtor auf dem Weg hinaus.",
	-- {npc:3429} Thork
	["{npc:3429}, at the top of the tower"] = "{npc:3429}, oben auf dem Turm",

	-- Step 14: Raptor Heads as you go
	-- plural, as words: Raptor Heads = {item:5062} Raptor Head
	["Raptor Heads as you go"] = "Raptorköpfe unterwegs",
	-- plural, as words: Sunscale Screechers = {npc:3255} Sunscale Screecher
	["Sunscale raptors roam the plains north and east of the Crossroads, and about three in four drop a head: kill the ones you pass on the way. Careful: Sunscale Screechers call nearby allies within 30 yd once below 30% health."] = "Sunscaleraptoren streifen durch die Ebenen nördlich und östlich des Wegekreuzes, und etwa drei von vier lassen einen Kopf fallen: Töte die, an denen du vorbeikommst. Vorsicht: Sunscale-Kreischer rufen nahe Verbündete im Umkreis von 30 yd, sobald sie unter 30% Gesundheit fallen.",

	-- Step 15: Plainstrider Beaks as you go
	-- plural, as words: Plainstrider Beaks = {item:5087} Plainstrider Beak
	["Plainstrider Beaks as you go"] = "Weideläufer-Schnäbel unterwegs",
	-- {zone:1413} The Barrens
	["Plainstriders roam the plains all over the {zone:1413}, and about one in four drops a beak: kill the ones you pass on the way."] = "Weideläufer streifen überall durch die Ebenen von {zone:1413}, und etwa einer von vier lässt einen Schnabel fallen: Töte die, an denen du vorbeikommst.",

	-- Step 16: Razormane camp
	-- plural, as words: Razormane Flesheaters = {npc:267308} Razormane Flesheater
	["In the camp, Water Seekers and Thornweavers hold the western half, Hunters the middle; the supply crates sit at its eastern end.\nPlainstriders here count toward the beaks.\nCareful: Razormane Flesheaters and Berserkers (18-19) are elites; they stand in the camp's north-east, beside the supply crates: pull the quilboar away from them one at a time."] = "Im Lager halten Wassersucher und Dornenwirker die westliche Hälfte, Jäger die Mitte; die Vorratskisten stehen am östlichen Ende.\nEbenenschreiter hier zählen für die Schnäbel.\nVorsicht: Fleischfresser und Berserker der Grimmhauer (18-19) sind Elites; sie stehen im Nordosten des Lagers neben den Vorratskisten: Zieh die Stacheleber einzeln von ihnen weg.",

	-- Step 17: Finish the Plainstrider Beaks
	-- plural, as words: Plainstrider Beaks = {item:5087} Plainstrider Beak
	["Finish the Plainstrider Beaks"] = "Schließe die Weideläufer-Schnäbel ab",
	["Still short of seven? Plainstriders are thickest on the plains north of the Crossroads, along the road north."] = "Fehlen dir noch welche zu sieben? Weideläufer gibt es am dichtesten in den Ebenen nördlich des Wegekreuzes, entlang der Straße nach Norden.",

	-- Step 19: The Zhevra
	-- {area:392} Ratchet
	-- plural, as words: Zhevra Runners = {npc:3242} Zhevra Runner
	["Zhevra Runners graze along the road east toward {area:392}: take their hooves on the way out."] = "Zhevra-Läufer grasen entlang der Straße nach Osten Richtung {area:392}: Nimm ihre Hufe auf dem Weg hinaus mit.",

	-- Step 20: Ratchet
	-- {area:392} Ratchet
	["Follow the road south-east to {area:392} on the coast."] = "Folge der Straße nach Südosten nach {area:392} an der Küste.",
	-- {npc:3391} Gazlowe
	["{npc:3391}, upstairs"] = "{npc:3391}, oben",
	-- {npc:3442} Sputtervalve · {area:382} Sludge Fen
	["{npc:3442}: the console is in the {area:382}, later"] = "{npc:3442}: Die Konsole ist in {area:382}, später",
	-- {npc:16227} Bragok · {npc:3442} Sputtervalve
	["{npc:16227}, beside {npc:3442}"] = "{npc:16227}, neben {npc:3442}",
	-- {object:3972} WANTED
	["{object:3972} poster"] = "Plakat „{object:3972}“",
	-- {quest:1492} Wharfmaster Dizzywig
	["{quest:1492}, on the dock"] = "{quest:1492}, am Kai",
	-- {quest:1492} Wharfmaster Dizzywig · {area:381} Boulder Lode Mine
	["{quest:1492}: the emerald comes from the {area:381}, later"] = "{quest:1492}: Der Smaragd kommt später aus der {area:381}",

	-- Step 21: The Barrens: kill these as you meet them
	-- {zone:1413} The Barrens
	["{zone:1413}: kill these as you meet them"] = "{zone:1413}: Töte diese, wenn sie dir begegnen",
	-- {area:392} Ratchet · {npc:3467} Baron Longshore
	["The pirates camp on the beach south of {area:392}: the piles of complicated parts lie in the sand among them, and {npc:3467} stands at the camp's southern end."] = "Die Piraten lagern am Strand südlich von {area:392}: Die Haufen komplizierter Teile liegen im Sand zwischen ihnen, und {npc:3467} steht am südlichen Ende des Lagers.",

	-- Step 22: Ratchet
	-- {npc:3391} Gazlowe · {area:385} Northwatch Hold
	["{npc:3391}: the crates lie at the south end of the beach camp, on the walk to {area:385} at 18"] = "{npc:3391}: Die Kisten liegen am Südende des Strandlagers, auf dem Weg nach {area:385} bei 18",

	-- Step 23: Fly to Crossroads
	["Fly to Crossroads"] = "Flieg zum Wegekreuz",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Flugmeister in {area:392}",

	-- Step 25: Gur'ak
	-- {npc:267310} Gur'ak · {quest:97003} Chol'aruk the Ravener · {npc:267307} Chol'aruk · {area:1699} Thorn Hill · {npc:3438} Kreenig Snarlsnout
	["{npc:267310} stands on the north-east side of the Crossroads. {quest:97003} is a group quest: {npc:267307} is a level 20 elite boar in the Razormane's {area:1699} cave, east of the town, where the route goes back for {npc:3438} later."] = "{npc:267310} steht auf der Nordostseite des Wegekreuzes. {quest:97003} ist eine Gruppenquest: {npc:267307} ist ein Elite-Eber der Stufe 20 in der Höhle der Klingenmähnen in {area:1699}, östlich der Stadt, wohin die Route später für {npc:3438} zurückkehrt.",

	-- Step 26: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate
	["West to {npc:3389}'s watch post on the Kolkar border."] = "Nach Westen zum Wachposten von {npc:3389} an der Grenze zu den Kolkar.",

	-- Step 27: The Barrens: kill these as you meet them
	-- {npc:3389} Regthar Deathgate · {npc:3394} Barak Kodobane
	-- plural, as words: Laden Mushrooms = {object:3640} Laden Mushroom
	["The pools lie just north of {npc:3389}. Walk into the water to explore them; the Laden Mushrooms for Helbrim grow around them. Kill every Kolkar you pass for bracers. {npc:3394} stands in the Kolkar camp west of the pools."] = "Die Tümpel liegen direkt nördlich von {npc:3389}. Geh ins Wasser, um sie zu erkunden; die Beladenen Pilze für Helbrim wachsen um sie herum. Töte jeden Kolkar, an dem du vorbeikommst, für Armschienen. {npc:3394} steht im Lager der Kolkar westlich der Tümpel.",

	-- Step 28: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate · {npc:3395} Verog the Dervish · {area:388} Stagnant Oasis
	["{npc:3389}: {npc:3395} walks with the Kolkar at the {area:388}, later"] = "{npc:3389}: {npc:3395} wandert später mit den Kolkar an der {area:388}",

	-- Step 29: Dry Hills
	-- {area:383} Dry Hills · {quest:819} Chen's Empty Keg · {npc:3389} Regthar Deathgate
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler · Witchwing Ambushers = {npc:3279} Witchwing Ambusher
	["West to the {area:383}. The Witchwing harpies nest all over them; any of them can drop a talon. {quest:819} lies in their hills. Savannah Prowlers hunt the plains between {npc:3389} and the hills: take their claws on the way.\nCareful: There are 2 Witchwing Ambushers (level 17-18). They stay stealthed with Sneak while out of combat."] = "Nach Westen zu den {area:383}. Die Harpyien der Witchwing nisten überall dort; jede von ihnen kann eine Klaue fallen lassen. {quest:819} liegt in ihren Hügeln. Savannah prowler jagen in den Ebenen zwischen {npc:3389} und den Hügeln: Nimm ihre Klauen auf dem Weg mit.\nVorsicht: Es gibt 2 Witchwing-Hinterhalter (Stufe 17-18). Sie bleiben außerhalb des Kampfes mit Schleichen verborgen.",

	-- Step 30: Samophlange
	-- {object:4141} Control Console · {area:382} Sludge Fen · {item:5089} Console Key · {npc:3471} Tinkerer Sniggles
	["The {object:4141} stands at the Venture Co. research site west of the {area:382}. Close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471} beside it.\nCareful: Several guards stand within aggro range of the valves, respawn in under about 3 minutes, and run at low health to bring back help; nearby mobs also join if you use a valve while they are close."] = "Die {object:4141} steht an der Forschungsstätte der Venture Co. westlich der {area:382}. Schließe die drei Ventile um den Bohrer, benutze die Konsole noch einmal und nimm dann den {item:5089} von {npc:3471} daneben.\nVorsicht: Mehrere Wachen stehen in Aggro-Reichweite der Ventile, respawnen in unter etwa 3 Minuten und rennen bei niedriger Gesundheit los, um Hilfe zu holen; auch Mobs in der Nähe greifen ein, wenn du ein Ventil benutzt, während sie nah sind.",
	["Inside"] = "Drinnen",
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["{npc:3442} in {area:392}: on the next {area:392} stop"] = "{npc:3442} in {area:392}: beim nächsten Halt in {area:392}",

	-- Step 31: The Disruption Ends
	-- {npc:3438} Kreenig Snarlsnout · {npc:267307} Chol'aruk · {area:1699} Thorn Hill
	-- plural, as words: Razormane Flesheaters = {npc:267308} Razormane Flesheater
	["Back to the Razormane camp. Geomancers and Defenders hold its eastern half; {npc:3438} walks among them. Careful: Razormane Flesheaters and Berserkers (18-19) are elites in the camp's north-east, near {npc:3438} and the supply crates, and {npc:267307} (20, elite) lies in the cave under {area:1699} beside them: pull {npc:3438} and the quilboar away from them one at a time, and leave the cave alone unless you are in a group."] = "Zurück zum Lager der Grimmhauer. Geomanten und Verteidiger halten die östliche Hälfte; {npc:3438} läuft zwischen ihnen herum. Vorsicht: Fleischfresser und Berserker der Grimmhauer (18-19) sind Elites im Nordosten des Lagers, nahe {npc:3438} und den Vorratskisten, und {npc:267307} (20, Elite) liegt in der Höhle unter {area:1699} neben ihnen: Zieh {npc:3438} und die Stacheleber einzeln von ihnen weg und lass die Höhle in Ruhe, außer du bist in einer Gruppe.",

	-- Step 32: Chol'aruk
	-- {npc:267307} Chol'aruk · {area:1699} Thorn Hill
	-- plural, as words: Razormane Flesheaters = {npc:267308} Razormane Flesheater
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:267307} (level 20 elite) needs a group of 3 and sits deep in the cave under {area:1699}, past the Razormane Flesheaters and Berserkers (18-19, elite). Skip it if you are alone."] = "Das sind Elite-Mobs: Eine Gruppe wird empfohlen, such dir Leute dafür. {npc:267307} (Elite der Stufe 20) braucht eine Gruppe aus 3 und sitzt tief in der Höhle unter {area:1699}, hinter den Razormane Flesheaters und Berserkers (18-19, Elite). Überspring ihn, wenn du allein bist.",

	-- Step 33: The Crossroads
	-- {npc:3338} Sergra Darkthorn · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger · {npc:3432} Mankrik · {npc:3448} Tonga Runetotem · {npc:3395} Verog the Dervish · {area:388} Stagnant Oasis · {area:383} Dry Hills · {quest:853} Apothecary Zamah · {zone:1456} Thunder Bluff
	["{npc:3338} by the inn first, then Helbrim by the north gate, {npc:3429} and {npc:3449} on the tower platform, {npc:3432} by the inn, and {npc:3448} at the south gate last. His seed test waits for the {npc:3395} pass at the {area:388}: go straight on north-west to the {area:383}. After the spores Helbrim offers {quest:853}, a delivery to {zone:1456} within 45 minutes: this route doesn't go there, so leave it (Druids take it on the next Crossroads stop, right before their flight to {zone:1456})."] = "Zuerst {npc:3338} beim Gasthaus, dann Helbrim beim Nordtor, {npc:3429} und {npc:3449} auf der Turmplattform, {npc:3432} beim Gasthaus und zuletzt {npc:3448} am Südtor. Sein Samentest wartet auf den Abstecher zu {npc:3395} bei {area:388}: Geh direkt weiter nach Nordwesten zu {area:383}. Nach den Sporen bietet Helbrim {quest:853} an, eine Lieferung nach {zone:1456} innerhalb von 45 Minuten: Diese Route geht nicht dorthin, also lass sie liegen (Druiden nehmen sie beim nächsten Halt in Crossroads an, direkt vor ihrem Flug nach {zone:1456}).",
	-- {npc:3432} Mankrik
	["{npc:3432}: his wife lies at the north edge of the Bristleback camps, later"] = "{npc:3432}: Seine Frau liegt später am Nordrand der Lager der Borstennacken",
	-- {npc:3448} Tonga Runetotem · {area:388} Stagnant Oasis · {npc:3395} Verog the Dervish
	["{npc:3448}: the bubbling fissure at the {area:388}, on the {npc:3395} pass"] = "{npc:3448}: die blubbernde Spalte bei {area:388}, beim Abstecher zu {npc:3395}",

	-- Step 35: Harpy Lieutenants
	-- {area:383} Dry Hills
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["North-west to the {area:383}: the Witchwing Slayers hold their western end; they wear the rings.\nCareful: Some stealthed harpy ambushers wait in the area and stay hidden until you get close. A level 19 elite harpy also patrols there."] = "Nach Nordwesten zu den {area:383}: Die Witchwing-Schlächter halten ihr westliches Ende; sie tragen die Ringe.\nVorsicht: Einige getarnte Harpyien-Hinterhalter lauern in dem Gebiet und bleiben verborgen, bis du nah herankommst. Außerdem patrouilliert dort eine Elite-Harpyie der Stufe 19.",

	-- Step 37: Raptor Horns
	-- {quest:881} Echeyakee · {area:383} Dry Hills · {item:5055} Intact Raptor Horn · {npc:3446} Mebok Mizzyrix · {area:392} Ratchet
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["On the way east to {quest:881}: Sunscale Scytheclaws prowl the plains east of the {area:383}; any of them can drop an {item:5055} for {npc:3446} in {area:392}."] = "Auf dem Weg nach Osten zu {quest:881}: Sunscale-Sichelklauen streifen durch die Ebenen östlich der {area:383}; jede von ihnen kann ein {item:5055} für {npc:3446} in {area:392} fallen lassen.",

	-- Step 38: Echeyakee
	-- {quest:881} Echeyakee
	["South-east on the way back to the Crossroads: {quest:881}, a white lion, prowls the plains north of the Razormane camp.\nCareful: Savannah Huntresses roam around the lair. They respawn quickly and often join the fight alongside {quest:881}, so clear them out before you blow the horn.\nSunscale raptors here count toward the heads."] = "Nach Südosten auf dem Rückweg zum Wegekreuz: {quest:881}, ein weißer Löwe, streift durch die Ebenen nördlich des Lagers der Klingenmähnen.\nVorsicht: Savannah jägerinnen streifen um die Höhle. Sie respawnen schnell und greifen oft zusammen mit {quest:881} an, also räume sie weg, bevor du das Horn bläst.\nSunscaleraptoren hier zählen für die Köpfe.",

	-- Step 39: Finish the Raptor Heads
	-- plural, as words: Raptor Heads = {item:5062} Raptor Head
	["Finish the Raptor Heads"] = "Schließe die Raptorköpfe ab",
	-- {quest:881} Echeyakee
	-- plural, as words: Sunscale Lashtails = {npc:3254} Sunscale Lashtail
	["Still short of twelve? Sunscale Lashtails and Screechers roam the plains north-east of the Crossroads, on the way back south from {quest:881}'s lair."] = "Fehlen dir noch welche zu zwölf? Sunscale-Peitschenschwänze und -Kreischer streifen durch die Ebenen nordöstlich des Wegekreuzes, auf dem Rückweg nach Süden von der Höhle von {quest:881}.",

	-- Step 40: The Crossroads
	-- {npc:3464} Gazrog · {npc:3338} Sergra Darkthorn · {npc:3449} Darsok Swiftdagger · {npc:3429} Thork
	["In from the north gate: {npc:3464} first, {npc:3338} by the inn, then up to {npc:3449} and {npc:3429} on the tower platform, where the flight master stands."] = "Durch das Nordtor hinein: zuerst {npc:3464}, {npc:3338} beim Gasthaus, dann hinauf zu {npc:3449} und {npc:3429} auf der Turmplattform, wo der Flugmeister steht.",
	-- {npc:3464} Gazrog · {quest:3281} Stolen Silver · {area:385} Northwatch Hold
	["{npc:3464}: the {quest:3281}, in a raptor nest north-west of {area:385}"] = "{npc:3464}: das {quest:3281}, in einem Raptornest nordwestlich von {area:385}",
	-- {npc:3390} Apothecary Helbrim · {zone:1456} Thunder Bluff
	["{npc:3390}: 45 minutes, for Zamah on the {zone:1456} step next"] = "{npc:3390}: 45 Minuten, für Zamah im nächsten Schritt in {zone:1456}",
	-- {npc:3338} Sergra Darkthorn
	["{npc:3338}: the raptor nests south of the Crossroads"] = "{npc:3338}: die Raptornester südlich des Wegekreuzes",
	-- {npc:3449} Darsok Swiftdagger · {quest:876} Serena Bloodfeather · {area:383} Dry Hills
	["{npc:3449}, on the tower: {quest:876} leads the harpies in the {area:383}"] = "{npc:3449}, auf dem Turm: {quest:876} führt die Harpyien in den {area:383} an",
	-- {npc:3429} Thork · {area:1703} Mor'shan Rampart
	["{npc:3429}, on the tower, from level 17. Keep it: Kadrak at the {area:1703}, next guide"] = "{npc:3429}, auf dem Turm, ab Stufe 17. Behalte es: Kadrak am {area:1703}, im nächsten Guide",

	-- Step 41: Thunder Bluff
	-- {area:1638} Thunder Bluff · {quest:853} Apothecary Zamah · {area:2197} Pools of Vision · {area:1640} Spirit Rise · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Fly from the Crossroads to {area:1638}. {quest:853} waits in the {area:2197}, the cave under {area:1640}: hand in the spores there first, while their time runs. Then {npc:3033} trains you on {area:1639}."] = "Flieg von Crossroads nach {area:1638}. {quest:853} wartet in {area:2197}, der Höhle unter {area:1640}: Gib dort zuerst die Sporen ab, solange ihre Zeit läuft. Dann lässt dich {npc:3033} auf {area:1639} trainieren.",
	-- {quest:853} Apothecary Zamah · {area:2197} Pools of Vision
	["{quest:853}, in the {area:2197}"] = "{quest:853}, in {area:2197}",

	-- Step 42: Moonglade
	-- {spell:18960} Teleport: Moonglade
	["Cast {spell:18960}"] = "Wirke {spell:18960}",

	-- Step 43: Trial of the Lake
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri · {quest:28} Trial of the Lake
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["{npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}. {quest:28} runs on a timer: no teleport or Hearthstone until {npc:11799} has it."] = "{npc:11802} steht oben in seinem Gebäude in {area:2361}: Geh drinnen nach oben, der Pfeil kann die Stockwerke nicht unterscheiden. Die Schreinkugeln liegen auf dem Grund von {area:656} und vergehen nach wenigen Minuten: Schwimm mit einer direkt zum {area:2362} am Nordwestufer, benutze sie dort und sprich mit {npc:11799}. {quest:28} läuft auf Zeit: Kein Teleport und kein Ruhestein, bis {npc:11799} sie hat.",
	-- {quest:6127} The Principal Source · {area:384} Dreadmist Peak
	["{quest:6127}: {area:384}, next guide"] = "{quest:6127}: {area:384}, nächster Guide",
	-- {item:15877} Shrine Bauble · {object:177785} Bauble Container
	["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}, aus einem {object:177785} im See",
	-- {area:2362} Shrine of Remulos
	["At the {area:2362}"] = "Am {area:2362}",
	-- {npc:11799} Tajarri · {area:2362} Shrine of Remulos
	["{npc:11799}, at the {area:2362}"] = "{npc:11799}, am Schrein: {area:2362}",
	-- {quest:30} Trial of the Sea Lion · {area:382} Sludge Fen · {area:287} Hillsbrad
	["{quest:30}, carried: one half pendant in the {area:382} in this guide, the other underwater off Silverpine on the way to {area:287} at 21; the pendant is handed in after {area:287}"] = "{quest:30}, mitgeführt: eine Anhängerhälfte im {area:382} in diesem Guide, die andere unter Wasser vor Silberwald auf dem Weg nach {area:287} bei 21; der Anhänger wird nach {area:287} abgegeben",
	-- {npc:11798} Bunthen Plainswind · {area:2361} Nighthaven
	["{npc:11798} in {area:2361} flies druids there"] = "{npc:11798} in {area:2361} fliegt Druiden dorthin",

	-- Step 44: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Flieg nach {area:392}",
	-- {zone:1456} Thunder Bluff · {area:392} Ratchet
	["Fly from {zone:1456} straight on to {area:392}."] = "Flieg von {zone:1456} direkt weiter nach {area:392}.",

	-- Step 45: Fly to Ratchet
	["Crossroads flight master"] = "Flugmeister des Wegekreuzes",

	-- Step 47: Ratchet
	-- {npc:3446} Mebok Mizzyrix · {object:3972} WANTED · {area:392} Ratchet
	["{npc:3446}, beside the {object:3972} poster: take it now if he did not offer it on the first {area:392} stop"] = "{npc:3446}, neben dem Plakat {object:3972}: Nimm sie jetzt an, falls er sie beim ersten Halt in {area:392} nicht angeboten hat",

	-- Step 48: Ratchet
	-- {npc:3446} Mebok Mizzyrix · {object:3972} WANTED
	["{npc:3446}, beside the {object:3972} poster"] = "{npc:3446}, neben dem Plakat {object:3972}",

	-- Step 49: Mebok Mizzyrix
	-- {area:718} Wailing Caverns · {npc:3446} Mebok Mizzyrix · {quest:1491} Smart Drinks
	["For your {area:718} run: {npc:3446}'s next errand, {quest:1491}."] = "Für deinen Run durch {area:718}: der nächste Auftrag von {npc:3446}, {quest:1491}.",

	-- Step 51: Ratchet
	-- {npc:3442} Sputtervalve · {quest:1483} Ziz Fizziks · {area:1076} Webwinder Path
	["{npc:3442}: keep it, {quest:1483} is on the {area:1076} in Stonetalon, at the end of this guide"] = "{npc:3442}: Behalte sie, {quest:1483} liegt am {area:1076} im Steinkrallengebirge, am Ende dieses Guides",
	-- {npc:3442} Sputtervalve · {npc:9316} Wenikee Boltbucket · {area:382} Sludge Fen
	["{npc:3442}: {npc:9316} stands on the road north of the Crossroads, on the way to the {area:382}"] = "{npc:3442}: {npc:9316} steht an der Straße nördlich des Wegekreuzes, auf dem Weg zum {area:382}",

	-- Step 52: Bruuz
	-- {npc:209797} Bruuz
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:209797} (level 20 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "Dies sind Elite-Mobs: Eine Gruppe wird empfohlen, such dir Leute dafür. {npc:209797} (Elite der Stufe 20) braucht eine Gruppe von 2. Überspringe ihn, wenn du allein bist: Die Route lässt dich die EP wieder grinden.",

	-- Step 53: Ratchet
	-- {npc:3391} Gazlowe
	["{npc:3391} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:3391} steht oben in seinem Gebäude: Geh drinnen nach oben, der Pfeil kann die Stockwerke nicht unterscheiden.",

	-- Step 54: Raptor nests
	["Raptor nests"] = "Raptornester",
	-- {area:392} Ratchet · {area:1697} Raptor Grounds · {item:5165} Sunscale Feather
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["South-west from {area:392} across the plains to the {area:1697}: the three nests sit together south-west of the oasis, and Sunscale Scytheclaws guard them. Each nest needs a {item:5165}: kill Sunscale raptors (most drop one) until you have three, then use a feather at each nest."] = "Von {area:392} nach Südwesten über die Ebenen zu {area:1697}: Die drei Nester liegen zusammen südwestlich der Oase; Bluthornsensenklauen bewachen sie. Jedes Nest braucht {item:5165}: Töte Raptoren der Bluthorn (die meisten lassen eine fallen), bis du drei hast, und benutze dann an jedem Nest eine Feder.",

	-- Step 55: Raptor Grounds: kill these as you meet them
	-- {area:1697} Raptor Grounds
	["{area:1697}: kill these as you meet them"] = "{area:1697}: Töte diese, wenn sie dir begegnen",
	-- {area:1697} Raptor Grounds · {npc:3446} Mebok Mizzyrix · {area:392} Ratchet · {area:385} Northwatch Hold
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["Sunscale Scytheclaws hunt the plains around the {area:1697}; they drop the horns. {npc:3446} takes them when the escort brings you back to {area:392}.\nSouth-east toward the coast: the stolen silver lies in a raptor nest north-west of {area:385}."] = "Sunscale-Sichelklauen jagen in den Ebenen um {area:1697}; sie lassen die Hörner fallen. {npc:3446} nimmt sie an, wenn die Eskorte dich zurück nach {area:392} bringt.\nNach Südosten Richtung Küste: Das gestohlene Silber liegt in einem Raptornest nordwestlich von {area:385}.",

	-- Step 56: Stolen Booty
	-- {area:385} Northwatch Hold
	["East to the beach, at the south end of the pirate camp: the crate of boots and the fragile crate with the lens sit there, a short walk north of {area:385}."] = "Nach Osten zum Strand, am Südende des Piratenlagers: Die Kiste mit Stiefeln und die zerbrechliche Kiste mit der Linse stehen dort, ein kurzes Stück nördlich von {area:385}.",

	-- Step 57: Northwatch Hold: kill these as you meet them
	-- {area:385} Northwatch Hold
	["{area:385}: kill these as you meet them"] = "{area:385}: Töte diese, wenn sie dir begegnen",
	-- {area:385} Northwatch Hold · {npc:3393} Captain Fairmount
	-- plural, as words: Theramore Marines = {npc:3385} Theramore Marine
	["{area:385}, on the coast just south of the pirate camp. The Theramore Marines and Preservers (15-16) drop the medals; {npc:3393} (20) and the two cannoneers (19) stand in the keep and on its walls, and they are why the hold waits until now.\nCareful: Each named target is linked to a healer and guards, and Fairmount has three extra marines with her. Killing the healer first makes the fight easier."] = "{area:385}, an der Küste direkt südlich des Piratenlagers. Die Marinesoldaten und Bewahrer von Theramore (15-16) lassen die Medaillen fallen; {npc:3393} (20) und die zwei Kanoniere (19) stehen in der Festung und auf ihren Mauern, und deshalb wartet die Feste bis jetzt.\nVorsicht: Jedes benannte Ziel ist mit einem Heiler und Wachen verbunden, und Fairmount hat drei zusätzliche Marinesoldaten bei sich. Den Heiler zuerst zu töten macht den Kampf leichter.",
	["On the top floor"] = "Im obersten Stockwerk",
	["Upstairs"] = "Oben",

	-- Step 58: Free From the Hold
	-- {npc:3465} Gilthares Firebough · {area:392} Ratchet
	["{npc:3465} is chained inside the hold. Talk to him to start the escort and stay close: Theramore soldiers attack on the way out. He walks you back to {area:392}."] = "{npc:3465} ist in der Feste angekettet. Sprich mit ihm, um die Eskorte zu starten, und bleib dicht dran: Soldaten von Theramore greifen auf dem Weg hinaus an. Er führt dich zurück nach {area:392}.",

	-- Step 66: Dreadmist Peak
	-- {area:384} Dreadmist Peak · {item:15842} Empty Dreadmist Peak Sampler · {object:19464} Dreadmist Peak Pool (no name in this language: may be words) · {npc:3448} Tonga Runetotem · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["Head north from the Crossroads to {area:384} and fill the {item:15842} at the {object:19464}, then back to {npc:3448} in the Crossroads. No {skill:182}? {npc:3490} beside him sells {item:2449}, three at a time until he restocks."] = "Geh nördlich vom Wegekreuz zum {area:384} und fülle den {item:15842} am {object:19464}, dann zurück zu {npc:3448} im Wegekreuz. Kein {skill:182}? {npc:3490} neben ihm verkauft {item:2449}, drei auf einmal, bis er neu auffüllt.",
	-- {item:2449} Earthroot · {npc:3490} Hula'mahi
	["{item:2449} from {npc:3490}; herbalists pick it on the plains"] = "{item:2449} von {npc:3490}; Kräuterkundige pflücken es auf den Ebenen",

	-- Step 67: Kolkar camp
	["Kolkar camp"] = "Lager der Kolkar",
	-- {npc:3389} Regthar Deathgate · {item:2449} Earthroot
	-- plural, as words: Lost Barrens Kodos = {npc:3234} Lost Barrens Kodo
	["Lost Barrens Kodos roam the plains around the Kolkar camp north-west of {npc:3389}; herbalists pick {item:2449} there too."] = "Verirrte Barrens-Kodos streifen durch die Ebenen um das Kolkar-Lager nordwestlich von {npc:3389}; Kräutersammler finden dort auch {item:2449}.",

	-- Step 68: Vrang Wildgore
	-- {area:383} Dry Hills · {npc:3682} Vrang Wildgore · {npc:261366} Walton
	["North to the {area:383}. {npc:3682} camps below the hills; {npc:261366}, the hermit on the ridge behind him, has work for you only once {npc:3682} sends you up."] = "Nach Norden zu {area:383}. {npc:3682} lagert unterhalb der Hügel; {npc:261366}, der Einsiedler auf dem Kamm hinter ihm, hat erst Arbeit für dich, wenn {npc:3682} dich hinaufschickt.",

	-- Step 69: The Barrens: kill these as you meet them
	-- {quest:876} Serena Bloodfeather
	-- plural, as words: Savannah Patriarchs = {npc:3241} Savannah Patriarch · Sprung Traps = {object:640104} Sprung Trap
	["Savannah Patriarchs roam the plains east of the hills, and the Sprung Traps lie among them. {quest:876} leads the Witchwing harpies in the hills to the west.\nCareful: The route in passes stealthed Harpy Ambushers and an elite harpy that patrols."] = "Savannah patriarchen streifen durch die Ebenen östlich der Hügel, und die Ausgelösten Fallen liegen zwischen ihnen. {quest:876} führt die Witchwing-Harpyien in den Hügeln im Westen an.\nVorsicht: Der Weg hinein führt an getarnten Harpyien-Hinterhaltern und einer patrouillierenden Elite-Harpyie vorbei.",
	-- {quest:865} Raptor Horns
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["{quest:865}, if still open: Sunscale Scytheclaws prowl among the lions"] = "{quest:865}, falls noch offen: Bluthornsensenklauen streifen zwischen den Löwen umher",

	-- Step 72: Trouble in the Valley
	-- {npc:262119} Corporal Adamore · {npc:261366} Walton
	["{npc:262119} and his marines hold the wrecked caravan south of {npc:261366}. The marines are linked: pulling one calls the rest. Pull from the edge and run; they leash short, so you can thin the camp one at a time before tackling the Corporal."] = "{npc:262119} und seine Marinesoldaten halten die zerstörte Karawane südlich von {npc:261366}. Die Marinesoldaten sind verbunden: Pullst du einen, rufst du den Rest. Zieh vom Rand und lauf; sie lassen schnell ab, sodass du das Lager einzeln ausdünnen kannst, bevor du den Korporal angehst.",

	-- Step 73: Walton
	-- {npc:261366} Walton · {npc:261367} Terry Longdrink · {area:21} Kul Tiras
	["Assist {npc:261366}: stay by him when {npc:261367} and the {area:21} marines come up the ridge"] = "Hilf {npc:261366}: Bleib bei ihm, wenn {npc:261367} und die Marinesoldaten von {area:21} den Kamm heraufkommen",

	-- Step 74: Wenikee Boltbucket
	-- {npc:261366} Walton · {area:382} Sludge Fen · {npc:9316} Wenikee Boltbucket
	["East from {npc:261366} toward the {area:382}: {npc:9316} stands at the camp on the road north of the Crossroads."] = "Von {npc:261366} nach Osten Richtung {area:382}: {npc:9316} steht im Lager an der Straße nördlich des Wegekreuzes.",

	-- Step 75: Ignition
	-- {npc:3439} Wizzlecrank's Shredder · {area:382} Sludge Fen · {npc:3445} Supervisor Lugwizzle
	["{npc:3439} stands inside the Venture Co. camp in the {area:382}; {npc:3445} carries the key."] = "{npc:3439} steht im Lager der Venture Co. im {area:382}; {npc:3445} trägt den Schlüssel.",

	-- Step 76: Strange Lockbox
	-- {object:177794} Strange Lockbox · {area:382} Sludge Fen · {item:15883} Half Pendant of Aquatic Agility · {quest:30} Trial of the Sea Lion
	["The {object:177794} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "{object:177794} liegt am Nordrand von {area:382}, beim Turm der Venture Co. Darin ist {item:15883} für {quest:30}.",

	-- Step 77: The Escape
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["Wizzlecrank drives his shredder out of the camp: stay with him and kill whatever attacks him. {npc:3442} takes it in {area:392}.\nCareful: The route leads west and climbs a ramp. Once you reach the top, two Venture Company mobs ambush you."] = "Wizzlecrank fährt seinen Schredder aus dem Lager: Bleib bei ihm und töte alles, was ihn angreift. {npc:3442} nimmt ihn in {area:392} an.\nVorsicht: Die Route führt nach Westen und eine Rampe hinauf. Sobald du oben bist, überfallen dich zwei Mobs der Venture Company.",

	-- Step 78: Nugget Slugs
	-- {area:382} Sludge Fen
	["The tool buckets with the slugs lie around the Venture Co. drill site in the {area:382}."] = "Die Werkzeugeimer mit den Schnecken liegen um die Bohrstelle der Venture Co. im {area:382}.",

	-- Step 79: Boulder Lode Mine
	-- {item:5097} Cats Eye Emerald
	-- plural, as words: Venture Co. Overseers = {npc:3286} Venture Co. Overseer
	["The Venture Co. Overseers and Enforcers at the mine in the north-east corner of the zone drop the {item:5097}."] = "Die Vorarbeiter und Vollstrecker der Venture Co. an der Mine in der Nordostecke des Gebiets lassen {item:5097} fallen.",

	-- Step 80: Wenikee Boltbucket
	-- {npc:9316} Wenikee Boltbucket
	["West from the mine to {npc:9316}'s camp, then south down the road to the Crossroads."] = "Von der Mine nach Westen zum Lager von {npc:9316}, dann die Straße nach Süden zum Wegekreuz.",
	-- {quest:3923} Rilli Greasygob · {zone:1454} Orgrimmar · {object:172958} Valley of Honor
	["Keep it: {quest:3923} is in {zone:1454}'s {object:172958}, on the {zone:1454} trip at 20"] = "Behalte sie: {quest:3923} ist im {object:172958} von {zone:1454}, auf der Reise nach {zone:1454} bei 20",

	-- Step 81: the Crossroads
	["the Crossroads"] = "das Wegekreuz",
	-- {npc:3449} Darsok Swiftdagger · {npc:3448} Tonga Runetotem
	["South down the road to the Crossroads: {npc:3449} stands on the tower platform, {npc:3448} at the south gate."] = "Die Straße nach Süden zum Wegekreuz: {npc:3449} steht auf der Turmplattform, {npc:3448} am Südtor.",
	-- {item:15826} Curative Animal Salve
	["He gives you the {item:15826}"] = "Er gibt dir {item:15826}",

	-- Step 82: Verog the Dervish
	-- {npc:3395} Verog the Dervish · {area:388} Stagnant Oasis · {npc:3448} Tonga Runetotem
	["{npc:3395} walks among the Kolkar at the {area:388} south-east of the Crossroads. Test {npc:3448}'s seeds at the bubbling fissure on the oasis' east bank while you are there."] = "{npc:3395} läuft zwischen den Kolkar bei {area:388} südöstlich von Crossroads herum. Teste die Samen von {npc:3448} an der blubbernden Spalte am Ostufer der Oase, wenn du schon dort bist.",
	["Underwater"] = "Unter Wasser",
	-- {npc:12296} Sickly Gazelle · {item:15826} Curative Animal Salve
	["{npc:12296}: use the {item:15826} on them; they roam the plains all around the Crossroads"] = "{npc:12296}: Benutze das {item:15826} an ihnen; sie streifen überall um das Wegekreuz durch die Ebenen",
	-- {npc:12296} Sickly Gazelle
	["Cure {npc:12296}"] = "Heile {npc:12296}",

	-- Step 83: Bristleback camps
	["Bristleback camps"] = "Lager der Borstennacken",
	-- {area:378} Camp Taurajo · {area:458} Gold Road · {npc:3432} Mankrik · {npc:3430} Mangletooth · {quest:883} Lakota'mani
	["The Bristleback quilboar camps spread over the plains north of {area:378}, either side of the {area:458}. {npc:3432}'s wife lies at their north edge, on your way south. Leave the quilboar for now: {npc:3430} in {area:378} wants the same camps cleared. {quest:883}, a grey kodo, sometimes wanders here: his hoof starts a quest."] = "Die Lager der Borstennacken-Stacheleber ziehen sich über die Ebenen nördlich von {area:378}, auf beiden Seiten der {area:458}. Die Frau von {npc:3432} liegt an ihrem Nordrand, auf deinem Weg nach Süden. Lass die Stacheleber vorerst in Ruhe: {npc:3430} in {area:378} will dieselben Lager geräumt haben. {quest:883}, ein grauer Kodo, streift manchmal hier umher: Sein Huf startet eine Quest.",

	-- Step 84: Camp Taurajo
	-- {area:458} Gold Road · {area:378} Camp Taurajo
	["Follow the {area:458} south to {area:378}."] = "Folge der {area:458} nach Süden zum {area:378}.",
	-- {npc:3430} Mangletooth
	["{npc:3430}, in the cage"] = "{npc:3430}, im Käfig",

	-- Step 85: Bramblescar
	-- {npc:3432} Mankrik · {npc:3430} Mangletooth · {item:5075} Blood Shard
	["Back north into the Bristleback camps. Any Bristleback can drop a tusk for {npc:3432}, so collect them while you kill these for {npc:3430}. Keep one {item:5075}."] = "Zurück nach Norden in die Lager der Borstennacken. Jeder Borstennacken kann einen Hauer für {npc:3432} fallen lassen, also sammle sie, während du diese für {npc:3430} tötest. Behalte einen {item:5075}.",

	-- Step 88: The Crossroads
	-- {area:458} Gold Road · {npc:3448} Tonga Runetotem · {npc:3432} Mankrik · {npc:3428} Korran · {item:5075} Blood Shard · {npc:3430} Mangletooth · {area:378} Camp Taurajo
	["North up the {area:458} to the Crossroads: {npc:3448} at the south gate, {npc:3432} by the inn, {npc:3428} west of the north gate. Keep the {item:5075}: {npc:3430} takes it on the next stop in {area:378}."] = "Die {area:458} hinauf nach Norden zum Wegekreuz: {npc:3448} am Südtor, {npc:3432} beim Gasthaus, {npc:3428} westlich des Nordtors. Behalte {item:5075}: {npc:3430} nimmt ihn beim nächsten Halt im {area:378} entgegen.",
	-- {npc:3448} Tonga Runetotem · {area:387} Lushwater Oasis · {npc:3396} Hezrul Bloodmark · {zone:1454} Orgrimmar
	-- plural, as words: Oasis Snapjaws = {npc:3461} Oasis Snapjaw
	["{npc:3448}: the Oasis Snapjaws at {area:387}, with {npc:3396} after the {zone:1454} trip"] = "{npc:3448}: die Oasenschnappkiefer bei {area:387}, mit {npc:3396} nach dem Ausflug nach {zone:1454}",
	-- {npc:3432} Mankrik · {quest:95774} Her Name Is Olgra · {quest:4921} Lost in Battle
	["{npc:3432} offers {quest:95774} once {quest:4921} is handed in"] = "{npc:3432} bietet {quest:95774} an, sobald {quest:4921} abgegeben ist",
	-- {npc:3428} Korran · {area:390} Field of Giants · {area:378} Camp Taurajo · {zone:1454} Orgrimmar
	["{npc:3428}: the eggs are in the {area:390}, south of {area:378}, after the {zone:1454} trip"] = "{npc:3428}: Die Eier liegen im {area:390}, südlich von {area:378}, nach der Reise nach {zone:1454}",

	-- Step 89: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Flieg nach {area:1637}",
	-- {area:1637} Orgrimmar · {npc:3615} Devrak
	["Train your level 20 ranks in {area:1637} now: fly from {npc:3615} on the Crossroads' tower."] = "Lerne jetzt deine Ränge für Stufe 20 in {area:1637}: Flieg von {npc:3615} auf dem Turm des Wegekreuzes ab.",

	-- Step 90: Orgrimmar
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom
	["{npc:3354} is in the {object:172958}, {npc:5892} in the {object:172957}."] = "{npc:3354} ist im {object:172958}, {npc:5892} im {object:172957}.",

	-- Step 91: Valley of Honor
	-- {quest:3923} Rilli Greasygob · {object:172958} Valley of Honor
	["{quest:3923} stands by the {object:172958}'s water, east of the Drag."] = "{quest:3923} steht am Wasser des {object:172958}, östlich der Drag.",

	-- Step 92: Shenthul
	-- {quest:2458} Deep Cover · {npc:7233} Taskmaster Fizzule · {area:382} Sludge Fen
	["{quest:2458}: {npc:7233}, by the {area:382} on the next guide's walk north"] = "{quest:2458}: {npc:7233}, beim {area:382} auf dem Weg nach Norden im nächsten Guide",

	-- Step 93: Orgrimmar class quests
	-- {zone:1454} Orgrimmar
	["{zone:1454} class quests"] = "Klassenquests in {zone:1454}",
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits
	["{npc:6018} stands in the {object:172961} on the city's west side."] = "{npc:6018} steht im {object:172961} auf der Westseite der Stadt.",

	-- Step 94: Gan'rul Bloodeye
	-- {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["The {object:172960} is the canyon under the {object:172982}."] = "{object:172960} ist die Schlucht unter dem {object:172982}.",
	-- {npc:5909} Cazul
	["{npc:5909}, a few steps away"] = "{npc:5909}, ein paar Schritte entfernt",

	-- Step 95: Ur'kyo
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits
	["{npc:6018} stands in the {object:172961}, on the city's west side."] = "{npc:6018} steht im {object:172961}, auf der Westseite der Stadt.",
	-- {npc:6018} Ur'kyo · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["{npc:6018}: {npc:4606} in the {zone:1458}, two guides on"] = "{npc:6018}: {npc:4606} in {zone:1458}, zwei Guides weiter",

	-- Step 97: Thunder Bluff
	-- {npc:246344} Alodan the Hopeful · {area:1638} Thunder Bluff · {zone:1454} Orgrimmar · {area:378} Camp Taurajo · {zone:1412} Mulgore · {npc:2995} Tal
	["Train your level 20 ranks: {npc:246344} teaches Paladins in {area:1638}; {zone:1454} has no Paladin trainer. You have no flight path there yet: fly to {area:378}, head west through {zone:1412} and up a lift, and take the flight path from {npc:2995} on the central rise."] = "Lerne deine Ränge für Stufe 20: {npc:246344} lehrt Paladine in {area:1638}; {zone:1454} hat keinen Paladinlehrer. Du hast dort noch keinen Flugpunkt: Flieg nach {area:378}, geh nach Westen durch {zone:1412} und einen Aufzug hinauf und nimm den Flugpunkt bei {npc:2995} auf der mittleren Anhöhe.",

	-- Step 99: The Great Cat Spirit
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:499} Cat Form · {spell:526} Cure Poison · {zone:1450} Moonglade · {npc:11798} Bunthen Plainswind · {area:392} Ratchet
	["Fly from the Crossroads to {area:1638} and train your level 20 ranks: {npc:3033} is on {area:1639}. {spell:499} and {spell:526} follow in {zone:1450} on the same trip, then {npc:11798} flies you back here and on to {area:392}."] = "Flieg vom Wegekreuz nach {area:1638} und lerne deine Ränge für Stufe 20: {npc:3033} ist auf {area:1639}. {spell:499} und {spell:526} folgen auf derselben Reise in {zone:1450}, dann fliegt dich {npc:11798} hierher zurück und weiter nach {area:392}.",

	-- Step 100: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart."] = "Wirke {spell:18960}. {npc:11802} steht oben in seinem Gebäude in {area:2361}: Geh drinnen nach oben, der Pfeil kann die Stockwerke nicht unterscheiden.",

	-- Step 102: Moonglade
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["{npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart."] = "{npc:11802} steht oben in seinem Gebäude in {area:2361}: Geh drinnen nach oben, der Pfeil kann die Stockwerke nicht unterscheiden.",

	-- Step 103: Moonglade
	-- {npc:11802} Dendrite Starblaze · {npc:3033} Turak Runetotem
	["{npc:11802}: the welcome from {npc:3033}"] = "{npc:11802}: der Willkommensgruß von {npc:3033}",

	-- Step 104: The Stormrage Barrow Dens
	-- {area:2363} Stormrage Barrow Dens
	["The {area:2363}"] = "Die {area:2363}",
	-- {npc:11957} Great Cat Spirit · {npc:272054} Avatar of Saeyleenan · {item:280680} Relic of the Silent Shadow
	-- plural, as words: Territorial Terrans = {npc:230558} Territorial Terran
	["Tauren: the {npc:11957} waits on the southern hill above the bridge. Skyborne: the {npc:272054} stands south of the twin bridges. Then the dens east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue. Careful: the spirits are Territorial Terrans (level 60) that kill whoever they see: stay off their paths, and click the statue again before the stealth runs out."] = "Tauren: {npc:11957} wartet auf dem südlichen Hügel über der Brücke. Himmelsgeborene: {npc:272054} steht südlich der Zwillingsbrücken. Dann die Grabhügel östlich des Sees: Verlass deine Gestalt, klick die Statue am Eingang an für fünf Minuten Verstohlenheit, halte dich von den Geistern darin fern und nimm von jedem Relikt eins; {item:280680} liegt am Fuß der weißen Katzenstatue. Vorsicht: Die Geister sind Territorial Terrans (Stufe 60), die jeden töten, den sie sehen: Bleib von ihren Wegen fern und klick die Statue erneut an, bevor die Verstohlenheit ausläuft.",

	-- Step 107: Fly to Ratchet
	-- {zone:1456} Thunder Bluff · {area:392} Ratchet
	["Fly from {zone:1456} on to {area:392}."] = "Flieg von {zone:1456} weiter nach {area:392}.",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Flugmeister von {zone:1456}",

	-- Step 108: Fly to Ratchet
	-- {area:392} Ratchet · {object:172982} Valley of Strength
	["Fly on to {area:392} from Doras on the tower in the {object:172982}."] = "Flieg von Doras auf dem Turm im {object:172982} weiter nach {area:392}.",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Flugmeister: {zone:1454}",

	-- Step 110: Ratchet: Wailing Caverns quests
	-- {area:392} Ratchet · {area:718} Wailing Caverns
	["{area:392}: {area:718} quests"] = "{area:392}: Quests für {area:718}",
	-- {area:718} Wailing Caverns · {npc:3446} Mebok Mizzyrix · {object:3972} WANTED · {npc:3665} Crane Operator Bigglefuzz · {npc:3396} Hezrul Bloodmark
	["Your {area:718} quests, if you have not taken them yet: {npc:3446} beside the {object:3972} poster, {npc:3665} on the dock by the flight master. The run is later in this guide, after {npc:3396}."] = "Deine Quests für {area:718}, falls du sie noch nicht angenommen hast: {npc:3446} neben dem Plakat {object:3972}, {npc:3665} auf dem Steg beim Flugmeister. Der Run kommt später in diesem Guide, nach {npc:3396}.",

	-- Step 111: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} waits on the hill south of {area:392}, on your way north."] = "{npc:5901} wartet auf dem Hügel südlich von {area:392}, auf deinem Weg nach Norden.",

	-- Step 112: Ishamuhale
	-- {quest:882} Ishamuhale · {item:10338} Fresh Zhevra Carcass · {object:147538} Dead Tree (no name in this language: may be words) · {area:392} Ratchet
	["{quest:882}, a big Sunscale raptor, only comes to a fresh kill: loot a {item:10338} from a zhevra, then use it at the {object:147538} north-west of {area:392}, north of the road to the Crossroads, and be ready when he arrives."] = "{quest:882}, ein großer Sunscaleraptor, kommt nur zu einem frischen Kadaver: Plündere ein {item:10338} von einem Zhevra, benutze es dann am {object:147538} nordwestlich von {area:392}, nördlich der Straße zum Wegekreuz, und sei bereit, wenn er ankommt.",
	-- {item:10338} Fresh Zhevra Carcass
	-- plural, as words: Zhevra Chargers = {npc:3426} Zhevra Charger
	["{item:10338}, from any zhevra; Zhevra Chargers graze around the tree"] = "{item:10338}, von jedem Zhevra; Zhevra-Stürmer grasen rund um den Baum",
	-- {object:147538} Dead Tree (no name in this language: may be words) · {quest:882} Ishamuhale
	["At the {object:147538}: summons {quest:882}"] = "Am toten Baum: beschwört {quest:882}",

	-- Step 113: Gazrog
	-- {npc:3464} Gazrog
	["{npc:3464}, by the Crossroads' north gate"] = "{npc:3464}, am Nordtor des Wegekreuzes",

	-- Step 116: Ken'zigla
	-- {npc:4197} Ken'zigla · {area:2539} Malaka'jin · {npc:3389} Regthar Deathgate
	["{npc:4197} lives in {area:2539}, the troll village just inside Stonetalon at the end of the road west from {npc:3389}."] = "{npc:4197} lebt in {area:2539}, dem Trolldorf gleich hinter der Grenze zum Steinkrallengebirge, am Ende der Straße westlich von {npc:3389}.",

	-- Step 117: To Regthar Deathgate
	-- {npc:3389} Regthar Deathgate
	["To {npc:3389}"] = "Zu {npc:3389}",

	-- Step 119: Hezrul Bloodmark
	-- {npc:3396} Hezrul Bloodmark · {area:387} Lushwater Oasis · {npc:3389} Regthar Deathgate · {npc:3448} Tonga Runetotem
	-- plural, as words: Oasis Snapjaws = {npc:3461} Oasis Snapjaw
	["{npc:3396} leads the Kolkar on the west shore of {area:387}, south of {npc:3389}. He walks that shore, from about 46,36 in the north to 46,42 in the south: if he isn't at the arrow, follow the shore until you meet him. Hand his head to {npc:3389} on your last Crossroads stop. Oasis Snapjaws crawl in the oasis' water there: their shells are for {npc:3448}."] = "{npc:3396} führt die Kolkar am Westufer von {area:387} an, südlich von {npc:3389}. Er läuft dieses Ufer ab, von etwa 46,36 im Norden bis 46,42 im Süden: Ist er nicht am Pfeil, folge dem Ufer, bis du ihn triffst. Gib seinen Kopf bei deinem letzten Halt in Crossroads bei {npc:3389} ab. Oasenschnappkiefer kriechen dort im Wasser der Oase: Ihre Panzer sind für {npc:3448}.",

	-- Step 120: Nalpak and Ebru
	-- {npc:5767} Nalpak · {npc:5768} Ebru
	["{npc:5767} and {npc:5768}"] = "{npc:5767} und {npc:5768}",
	-- {area:718} Wailing Caverns · {npc:5767} Nalpak · {npc:5768} Ebru
	["For your {area:718} run: {npc:5767} and {npc:5768} stand in a hidden cave in the rocks above the entrance, at the north end of the oasis' west shore: climb up from the west side. Follow the arrow up."] = "Für deinen Run durch {area:718}: {npc:5767} und {npc:5768} stehen in einer versteckten Höhle in den Felsen über dem Eingang, am Nordende des Westufers der Oase: Klettere von der Westseite hinauf. Folge dem Pfeil nach oben.",

	-- Step 121: Wailing Caverns
	-- {area:718} Wailing Caverns · {npc:3396} Hezrul Bloodmark · {area:387} Lushwater Oasis · {npc:5767} Nalpak · {npc:3655} Mad Magglish · {item:5334} 99-Year-Old Port · {npc:5768} Ebru · {item:6464} Wailing Essence · {npc:3678} Disciple of Naralex · {npc:3654} Mutanus the Devourer · {item:10441} Glowing Shard · {area:392} Ratchet · {npc:8418} Falla Sagewind
	["{area:718} is a dungeon for a group of five, about levels 17 to 24, and a full run takes about an hour. Its mouth is just north of {npc:3396}'s shore, at the north end of {area:387}, under {npc:5767}'s cave.\nIn the caves before the portal: {npc:3655}, stealthed, with the {item:5334} (he moves between a few spots and comes back slowly: leave him if he's gone). Inside: the Deviates for {npc:5768}, and their hides for {npc:5767} (they drop rarely: one run may not be enough, so leave the rest for another run), {item:6464} from the Ectoplasms. After the four Fanglords, the {npc:3678} at the entrance leads you to Naralex: {npc:3654} drops the {item:10441}: its quest (someone in {area:392}, then {npc:8418} above the caverns) is not on this route; the Dungeons page's hand-in guide takes it."] = "{area:718} ist ein Dungeon für eine Gruppe aus fünf Spielern, etwa Stufe 17 bis 24; ein kompletter Run dauert etwa eine Stunde. Der Eingang liegt gleich nördlich des Ufers von {npc:3396}, am Nordende von {area:387}, unter der Höhle von {npc:5767}.\nIn den Höhlen vor dem Portal: {npc:3655}, getarnt, mit {item:5334} (er wechselt zwischen ein paar Stellen und kommt nur langsam zurück: Lass ihn aus, wenn er weg ist). Drinnen: die Deviates für {npc:5768} und ihre Häute für {npc:5767} (sie droppen selten: Ein Run reicht vielleicht nicht, also heb dir den Rest für einen weiteren Run auf), {item:6464} von den Ectoplasms. Nach den vier Fanglords führt dich {npc:3678} am Eingang zu Naralex: {npc:3654} lässt {item:10441} fallen: Die Quest dazu (jemand in {area:392}, dann {npc:8418} über den Höhlen) ist nicht Teil dieser Route; der Abgabe-Guide der Seite „Dungeons“ übernimmt sie.",
	-- {item:6464} Wailing Essence
	["{item:6464}: the Ectoplasms"] = "{item:6464}: die Ectoplasms",

	-- Step 122: Nalpak
	["Back out of the caverns and up to the cave above the entrance."] = "Aus den Höhlen hinaus und hinauf zur Höhle über dem Eingang.",

	-- Step 124: Olgra's Adornments
	-- {area:458} Gold Road · {area:378} Camp Taurajo · {item:277277} Olgra's Adornments · {npc:3432} Mankrik
	-- plural, as words: Razormane Raiders = {npc:268624} Razormane Raider
	["On the way back down the {area:458} to {area:378}: the Razormane Raiders among the Bristleback camps, either side of the road north of the camp, carry {item:277277}. Hand them to {npc:3432} on your last Crossroads stop."] = "Auf dem Rückweg die {area:458} hinunter nach {area:378}: Die Klingenmähnen-Plünderer zwischen den Lagern der Borstennacken, auf beiden Seiten der Straße nördlich des Lagers, tragen {item:277277}. Gib sie bei deinem letzten Halt am Wegekreuz bei {npc:3432} ab.",

	-- Step 125: Camp Taurajo
	-- {area:458} Gold Road · {area:378} Camp Taurajo
	["Down the {area:458} to {area:378} again."] = "Die {area:458} wieder hinunter zum {area:378}.",
	-- {npc:12696} Senani Thunderheart · {zone:1440} Ashenvale
	["Keep it: {npc:12696} in {zone:1440}, next guide"] = "Behalte sie: {npc:12696} in {zone:1440}, nächster Guide",
	-- {npc:6394} Ruga Ragetotem
	["{npc:6394}, inside"] = "{npc:6394}, drinnen",

	-- Step 127: Grunt Dogran
	["Dogran is chained up in the quilboar camp west of the road."] = "Dogran ist im Stacheleberlager westlich der Straße angekettet.",
	-- {npc:5875} Gan'rul Bloodeye · {zone:1454} Orgrimmar
	["Keep it: {npc:5875} in {zone:1454}, on the next guide's {zone:1454} stop"] = "Behalte sie: {npc:5875} in {zone:1454}, beim nächsten Halt in {zone:1454} im nächsten Guide",

	-- Step 128: Enraged Thunder Lizards
	-- {area:378} Camp Taurajo · {quest:884} Owatanka
	-- plural, as words: Thunderheads = {npc:3239} Thunderhead
	["Thunderheads graze on the plains just south of {area:378}. {quest:884}, a blue thunder lizard, roams among them: his Tailspike starts a quest."] = "Donnerköpfe grasen auf den Ebenen gleich südlich vom {area:378}. {quest:884}, eine blaue Donnerechse, streift zwischen ihnen umher: Ihr Schwanzstachel startet eine Quest.",

	-- Step 129: Jorn Skyseer
	-- {quest:1824} Trial at the Field of Giants · {npc:6394} Ruga Ragetotem
	["Warriors: take {quest:1824} from {npc:6394} now: it runs for 30 minutes from the accept. The eggs and the antennae come first, at the same mounds, then straight back to {npc:6394}; the thunderhawks after."] = "Krieger: Nimm {quest:1824} jetzt bei {npc:6394} an: Sie läuft 30 Minuten ab dem Annehmen. Zuerst die Eier und die Fühler, an denselben Hügeln, dann direkt zurück zu {npc:6394}; die Donnerfalken danach.",

	-- Step 130: Field of Giants
	-- {area:390} Field of Giants
	-- plural, as words: Silithid Mounds = {object:3685} Silithid Mound · Silithid Swarmers = {npc:3252} Silithid Swarmer
	["South of Camp Taurajo, the Silithid Mounds dot the {area:390}; the eggs lie in them, and Silithid Swarmers come out to defend them.\nCareful: Silithid Swarmers in the area release many tiny adds that interrupt spells; damage shields such as Thorns kill them in one hit."] = "Südlich von Camp Taurajo liegen die Silithidhügel im {area:390}; die Eier liegen darin, und Silithid-Schwärmer kommen heraus, um sie zu verteidigen.\nVorsicht: Die Silithid-Schwärmer in dem Gebiet setzen viele winzige Adds frei, die Zauber unterbrechen; Schadensschilde wie Dornen töten sie mit einem Treffer.",

	-- Step 131: Twitching Antennae
	["Twitching Antennae"] = "Zuckende Fühler",
	-- {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo · {npc:4196} Silithid Swarm · {npc:5781} Silithid Creeper Egg · {npc:3253} Silithid Harvester
	-- plural, as words: Silithid Swarmers = {npc:3252} Silithid Swarmer · Silithid Creepers = {npc:3250} Silithid Creeper
	["The antennae vanish fifteen minutes after they drop: kill the Silithid Swarmers and Creepers at the same mounds until you have five, then take them straight to {npc:6394} in {area:378}, before the thunderhawks. Careful: Silithid Swarmers (level 21-22) cast {npc:4196} both in and out of combat, which brings several small adds; Silithid Creepers (level 20-21) periodically cast {npc:5781} in combat, which spawns extra adds. A {npc:3253} (24, rare) also wanders the mounds: leave it."] = "Die Fühler verschwinden fünfzehn Minuten, nachdem sie gedroppt sind: Töte die Silithid Swarmers und Creepers an denselben Hügeln, bis du fünf hast, und bring sie dann direkt zu {npc:6394} in {area:378}, vor den Donnerfalken. Vorsicht: Silithid Swarmers (Stufe 21-22) wirken {npc:4196} im Kampf und außerhalb, was mehrere kleine Adds bringt; Silithid Creepers (Stufe 20-21) wirken im Kampf regelmäßig {npc:5781}, was zusätzliche Adds erzeugt. Ein {npc:3253} (24, Rare) wandert ebenfalls über die Hügel: Lass ihn in Ruhe.",
	["Twitching Antennae from the silithid"] = "Zuckende Fühler von den Silithiden",

	-- Step 132: Ruga Ragetotem
	-- {area:378} Camp Taurajo · {npc:6394} Ruga Ragetotem
	["Back north into {area:378} before the antennae fade: {npc:6394} is inside."] = "Zurück nach Norden nach {area:378}, bevor die Fühler verfallen: {npc:6394} ist drinnen.",

	-- Step 133: Cry of the Thunderhawk
	-- plural, as words: Thunderhawk Cloudscrapers = {npc:3424} Thunderhawk Cloudscraper
	["Thunderhawk Cloudscrapers circle over the plains south of the camp."] = "Donnerfalkenwolkenkitzler kreisen über den Ebenen südlich des Lagers.",

	-- Step 134: Brine
	-- {npc:5899} Brine · {area:378} Camp Taurajo · {item:7766} Empty Brown Waterskin
	["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}: fill the {item:7766} at the watering hole below it."] = "Die Hütte von {npc:5899} steht auf dem Kamm über der Tränke der Stacheleber, südlich von {area:378}: Fülle den {item:7766} an der Tränke darunter.",
	-- {item:7766} Empty Brown Waterskin
	["Fill the {item:7766} at the quilboar watering hole"] = "Füll {item:7766} am Wasserloch der Stacheleber",
	-- {object:107045} Spring Well · {area:272} Tarren Mill · {area:287} Hillsbrad
	["Keep it: the {object:107045} is beside {area:272}, on the {area:287} guide"] = "Behalte sie: Der {object:107045} ist neben {area:272}, im Guide {area:287}",

	-- Step 135: Camp Taurajo
	-- {area:378} Camp Taurajo
	["Back north into {area:378} on the way to the Crossroads: Jorn takes the thunderhawk wings."] = "Zurück nach Norden nach {area:378}, auf dem Weg zum Wegekreuz: Jorn nimmt die Donnerfalkenschwingen.",

	-- Step 136: The Crossroads
	-- {area:458} Gold Road · {npc:3448} Tonga Runetotem · {npc:3432} Mankrik · {npc:3428} Korran
	["North up the {area:458} to the Crossroads: {npc:3448} at the south gate, {npc:3432} by the inn, {npc:3428} west of the north gate."] = "Nach Norden die {area:458} hinauf nach Crossroads: {npc:3448} am Südtor, {npc:3432} beim Gasthaus, {npc:3428} westlich des Nordtors.",

	-- Step 137: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze
	["{npc:5878} camps beside the road east of the Crossroads."] = "{npc:5878} lagert neben der Straße östlich des Wegekreuzes.",
	-- {quest:1838} Brutal Armor · {area:1717} Razorfen Kraul
	["He offers {quest:1838} next (1838, level 30): it needs {area:1717} and sends you all over Kalimdor and the Eastern Kingdoms. The Warrior class guide {quest:1838} covers it."] = "Als Nächstes bietet er {quest:1838} an (1838, Stufe 30): Sie erfordert {area:1717} und schickt dich durch ganz Kalimdor und die Östlichen Königreiche. Der Kriegerklassen-Guide {quest:1838} deckt sie ab.",

	-- Step 139: Counterattack!
	-- {npc:3389} Regthar Deathgate · {npc:9456} Warlord Krom'zar
	["Speak to {npc:3389} again to start the attack: the Kolkar charge the bunkers just west of him in waves. Fight beside the grunts until {npc:9456} (elite, 20) arrives with two bodyguards, usually from the south, then click the banner over his body."] = "Sprich noch einmal mit {npc:3389}, um den Angriff zu starten: Die Kolkar stürmen in Wellen die Bunker direkt westlich von ihm. Kämpfe neben den Grunts, bis {npc:9456} (Elite, 20) mit zwei Leibwächtern ankommt, meist aus dem Süden, und klicke dann das Banner über seiner Leiche an.",

	-- Step 140: Seereth Stonebreak's camp
	-- {npc:4049} Seereth Stonebreak
	["{npc:4049}'s camp"] = "Das Lager von {npc:4049}",

	-- Step 141: Seereth Stonebreak
	-- {npc:4049} Seereth Stonebreak · {npc:11857} Makaba Flathoof
	["{npc:4049} and {npc:11857} share the camp on the road west to Stonetalon."] = "{npc:4049} und {npc:11857} teilen sich das Lager an der Straße nach Westen ins Steinkrallengebirge.",
	-- {npc:4049} Seereth Stonebreak · {area:461} Windshear Crag
	["{npc:4049}: the Venture loggers at {area:461}"] = "{npc:4049}: die Holzfäller der Venture Co. bei {area:461}",

	-- Step 142: Grimtotem camp
	["Grimtotem camp"] = "Lager der Grimmtotem",
	-- {npc:11857} Makaba Flathoof
	["The Grimtotem camp is just north of {npc:11857}, a short walk off the road: Ruffians and Mercenaries stand among the tents."] = "Das Lager der Grimmtotem liegt direkt nördlich von {npc:11857}, ein kurzer Fußweg von der Straße: Raufbolde und Söldner stehen zwischen den Zelten.",

	-- Step 143: Makaba Flathoof
	-- {npc:11857} Makaba Flathoof
	["Back down to {npc:11857}."] = "Zurück hinunter zu {npc:11857}.",
	-- {npc:11858} Grundig Darkcloud · {area:1076} Webwinder Path
	["{npc:11858} waits up the {area:1076}"] = "{npc:11858} wartet den {area:1076} hinauf",

	-- Step 144: To Malaka'jin
	-- {area:2539} Malaka'jin
	["To {area:2539}"] = "Nach {area:2539}",

	-- Step 145: Malaka'jin
	-- {npc:4049} Seereth Stonebreak · {area:2539} Malaka'jin
	["Follow the road on west from {npc:4049} into Stonetalon. The troll village of {area:2539} sits at the entrance of the canyon."] = "Folge der Straße von {npc:4049} weiter nach Westen ins Steinkrallengebirge. Das Trolldorf {area:2539} liegt am Eingang der Schlucht.",
	-- {npc:12816} Xen'Zilla · {area:1076} Webwinder Path
	["{npc:12816}: the spiders along the {area:1076}"] = "{npc:12816}: die Spinnen entlang des {area:1076}",

	-- Step 146: Webwinder Path: kill these as you meet them
	-- {area:1076} Webwinder Path
	["{area:1076}: kill these as you meet them"] = "{area:1076}: Töte diese, wenn sie dir begegnen",
	-- {area:2539} Malaka'jin · {npc:11858} Grundig Darkcloud
	-- plural, as words: Grimtotem Brutes = {npc:11912} Grimtotem Brute · Deepmoss Creepers = {npc:4005} Deepmoss Creeper
	["North up the road from {area:2539}: {npc:11858} and his Grimtotem Brutes hold the bend in the road, and the Deepmoss Creepers and Venomspitters lurk in the webs on both sides of the path all the way up."] = "Die Straße nördlich von {area:2539} hinauf: {npc:11858} und seine Grimmtotem-Rohlinge halten die Biegung der Straße, und die Deepmoss-Schleicher und Giftspucker lauern in den Netzen zu beiden Seiten des Pfades, den ganzen Weg hinauf.",

	-- Step 147: Ziz Fizziks
	-- {area:1076} Webwinder Path · {quest:1483} Ziz Fizziks · {area:461} Windshear Crag
	["The road climbs north as the {area:1076}. {quest:1483} has a hut where the road forks east to {area:461}."] = "Die Straße steigt als {area:1076} nach Norden an. {quest:1483} hat eine Hütte, wo die Straße nach Osten zum {area:461} abzweigt.",
	-- {quest:1483} Ziz Fizziks
	["{quest:1483}, inside"] = "{quest:1483}, drinnen",

	-- Step 148: Windshear Crag
	-- {area:461} Windshear Crag
	["East of Ziz, the Venture Company is clear-cutting {area:461}; one of the Operators carries the blueprints."] = "Östlich von Ziz rodet die Venture Company {area:461}; einer der Bediener trägt die Pläne.",
	-- plural, as words: Venture Co. Loggers = {npc:3989} Venture Co. Logger
	["Venture Co. Loggers, all over the clear-cut"] = "Holzfäller der Venture Co., überall im Kahlschlag",

	-- Step 149: Piznik
	-- {npc:4276} Piznik · {area:2160} Windshear Mine
	["{npc:4276}'s defence is hard alone at this level: grouping up is encouraged, look for people to do it with. Skip it if you are alone.\n{npc:4276} mines at the bottom of the {area:2160} on the east side of the crag, past its kobolds (levels 19-23). Talk to him, then keep him alive for five minutes while he mines: a dozen or more kobolds come at him in waves, melee fighters first, then casters, and the mine's own kobolds respawn into the fight. If he dies, the quest fails."] = "Die Verteidigung von {npc:4276} ist auf dieser Stufe allein schwer: Eine Gruppe wird empfohlen, such dir Leute dafür. Überspringe es, wenn du allein bist.\n{npc:4276} baut am Grund der {area:2160} auf der Ostseite der Schlucht ab, hinter ihren Kobolden (Stufe 19-23). Sprich mit ihm und halte ihn dann fünf Minuten am Leben, während er abbaut: Ein Dutzend oder mehr Kobolde greifen ihn in Wellen an, erst Nahkämpfer, dann Zauberer, und die Kobolde der Mine respawnen mitten im Kampf. Wenn er stirbt, schlägt die Quest fehl.",
	-- {npc:4276} Piznik
	["{npc:4276}, below ground"] = "{npc:4276}, unter Tage",

	-- Step 150: Ziz Fizziks: Gerenzo's Orders
	-- {npc:4201} Ziz Fizziks
	["{npc:4201}, inside"] = "{npc:4201}, drinnen",

	-- Step 151: Ziz Fizziks
	-- {npc:4201} Ziz Fizziks · {npc:3442} Sputtervalve · {area:392} Ratchet · {zone:1413} The Barrens
	["{npc:4201}: for {npc:3442}, beside {area:392}'s flight master at the end of the {zone:1413} & Stonetalon guide"] = "{npc:4201}: für {npc:3442}, neben dem Flugmeister von {area:392}, am Ende des Guides für {zone:1413} & Steinkrallengebirge",

	-- Step 152: Kaya Flathoof
	-- {area:1076} Webwinder Path · {npc:11856} Kaya Flathoof · {npc:11858} Grundig Darkcloud · {area:2538} Camp Aparaje
	["On the way back down the {area:1076}, {npc:11856} is held in {npc:11858}'s hut at the bend in the road. Once you take her quest she walks straight off south-east to {area:2538}, the burned village, without waiting: stay close, or the quest fails.\nCareful: Three Grimtotems ambush her at the burned village and go for her, not you: pull them off her and kill their caster quickly."] = "Auf dem Rückweg den {area:1076} hinunter wird {npc:11856} in der Hütte von {npc:11858} an der Straßenbiegung festgehalten. Sobald du ihre Quest annimmst, läuft sie ohne zu warten direkt nach Südosten zum {area:2538}, dem niedergebrannten Dorf: Bleib dicht bei ihr, sonst schlägt die Quest fehl.\nVorsicht: Drei Grimmtotem lauern ihr im niedergebrannten Dorf auf und greifen sie an, nicht dich: Zieh sie von ihr weg und töte schnell ihren Zauberwirker.",
	-- {npc:11856} Kaya Flathoof · {npc:11858} Grundig Darkcloud
	["{npc:11856}, inside {npc:11858}'s hut"] = "{npc:11856}, in der Hütte von {npc:11858}",

	-- Step 153: Malaka'jin
	-- {area:2539} Malaka'jin · {npc:12816} Xen'Zilla
	["West from the burned village to {area:2539}: {npc:12816} stands just outside it, before the village."] = "Vom niedergebrannten Dorf nach Westen nach {area:2539}: {npc:12816} steht gleich davor, noch vor dem Dorf.",

	-- Step 155: Seereth Stonebreak
	-- {npc:4049} Seereth Stonebreak · {npc:11857} Makaba Flathoof
	["East along the road to {npc:4049} and {npc:11857}'s camp, on the way back out of Stonetalon."] = "Entlang der Straße nach Osten zum Lager von {npc:4049} und {npc:11857}, auf dem Rückweg aus dem Steinkrallengebirge.",
	-- {npc:11857} Makaba Flathoof · {npc:11864} Tammra Windfield · {area:460} Sun Rock Retreat · {zone:1413} The Barrens
	["{npc:11857}: keep it, {npc:11864} at {area:460} in the {zone:1413} & Stonetalon guide"] = "{npc:11857}: Behalte sie, {npc:11864} am {area:460} im Guide für {zone:1413} & Steinkrallengebirge",
	-- {zone:1413} The Barrens · {area:1703} Mor'shan Rampart · {zone:1440} Ashenvale
	["The next guide goes north-east across the {zone:1413} to the {area:1703} and {zone:1440}."] = "Der nächste Guide führt nach Nordosten über {zone:1413} zum {area:1703} und nach {zone:1440}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back down the beach, past the pirate camp: the crate of boots and the fragile crate with the lens sit at its south end."] = "Zurück den Strand hinunter, am Piratenlager vorbei: Die Kiste mit Stiefeln und die zerbrechliche Kiste mit der Linse stehen an seinem Südende.",
	-- ["Back north into {area:378} on the way to the Crossroads: {npc:3387} takes the thunderhawk wings."] = "Zurück nach Norden nach {area:378}, auf dem Weg zu den Crossroads: {npc:3387} nimmt die Donnerfalkenflügel.",
	-- ["Back to the Razormane camp. Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "Zurück zum Lager der Grimmhauer. Geomanten und Verteidiger halten die östliche Hälfte; {npc:3438} läuft zwischen ihnen herum.",
	-- ["Back west along the road."] = "Die Straße zurück nach Westen.",
	-- ["Bragok, beside {npc:3442}"] = "Bragok, neben {npc:3442}",
	-- ["Burning Blade Cultists hold {area:1898} in northern {area:14}; they drop the {item:6652}. The {item:5026} comes from the Razormane on your next visit to their camp."] = "Kultisten der Burning Blade halten {area:1898} im Norden von {area:14}; sie lassen {item:6652} fallen. {item:5026} bekommst du bei deinem nächsten Besuch im Lager der Grimmhauer.",
	-- ["Burning Blade Cultists hold {area:1898} in northern {zone:1411}; they drop the {item:6652}. The {item:5026} comes from the Razormane on your next visit to their camp."] = "Kultisten der Burning Blade halten {area:1898} im Norden von {zone:1411}; sie lassen {item:6652} fallen. {item:5026} bekommst du bei deinem nächsten Besuch im Lager der Grimmhauer.",
	-- ["Cast Teleport: {zone:1450}. {npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart."] = "Wirke Teleportieren: {zone:1450}. {npc:11802} steht oben in seinem Gebäude in {area:2361}: Geh drinnen nach oben, der Pfeil kann die Stockwerke nicht unterscheiden.",
	-- ["East to the {area:1703}; {npc:9316} stands at the camp just south of it."] = "Nach Osten zum {area:1703}; {npc:9316} steht im Lager gleich südlich davon.",
	-- ["East to {area:392}, on the coast."] = "Nach Osten nach {area:392} an der Küste.",
	-- ["Fly back to the Crossroads; the road west to Stonetalon starts at {npc:3389}'s bunkers."] = "Flieg zurück zum Wegekreuz; die Straße nach Westen ins Steinkrallengebirge beginnt bei den Bunkern von {npc:3389}.",
	-- ["Fly to {area:1638} to train: {npc:3033} is on {area:1639}."] = "Flieg zum Trainieren nach {area:1638}: {npc:3033} ist auf der {area:1639}.",
	-- ["Follow the road east to the outpost above the {area:814}."] = "Folge der Straße nach Osten zum Außenposten über dem {area:814}.",
	-- ["Keep it: {quest:3923} stands outside {zone:1454}; a later guide hands it in"] = "Behalte sie: {quest:3923} steht vor {zone:1454}; ein späterer Guide gibt sie ab",
	-- ["Kolkar Wranglers and Stormers hold the camps south of {npc:3389}."] = "Zänker und Sturmruferinnen der Kolkar halten die Lager südlich von {npc:3389}.",
	-- ["Kolkar camps"] = "Lager der Kolkar",
	-- ["Oasis Snapjaws crawl around {area:387}, south-west of the {area:380}, and around the {area:388}."] = "Oasenschnappkiefer kriechen um {area:387}, südwestlich von {area:380}, und um {area:388}.",
	-- ["Over the {area:814} bridge below {area:379} and south along the {zone:1411} bank to where a narrow trail climbs the mountain: {npc:5900} keeps the shrine at the top. Mind the edges on the way up, and come back down the same trail."] = "Über die Brücke von {area:814} unterhalb von {area:379} und am Ufer von {zone:1411} entlang nach Süden, bis ein schmaler Pfad den Berg hinaufführt: {npc:5900} hütet den Schrein oben. Pass auf dem Weg hinauf an den Kanten auf und komm denselben Pfad wieder herunter.",
	-- ["Plainstriders and Sunscale raptors roam the plains all around the {area:380}, thickest to the north."] = "Ebenenschreiter und Raptoren der Bluthorn streifen überall um {area:380} über die Ebenen, am dichtesten im Norden.",
	-- ["Plainstriders and raptors"] = "Ebenenschreiter und Raptoren",
	-- ["Raptor nests"] = "Raptornester",
	-- ["South to {npc:3389}'s watch post on the Kolkar border."] = "Nach Süden zu {npc:3389}s Wachposten an der Grenze zu den Kolkar.",
	-- ["South-east of the Crossroads. Test the seeds at the bubbling fissure on the oasis' east bank; {npc:3448} takes the result on the next Crossroads stop, so carry on north-west to the {area:383} from here."] = "Südöstlich vom Wegekreuz. Teste die Samen an der blubbernden Spalte am Ostufer der Oase; {npc:3448} nimmt das Ergebnis beim nächsten Halt am Wegekreuz entgegen, also geh von hier weiter nach Nordwesten zu {area:383}.",
	-- ["South-east of the {area:380}. Test the seeds at the bubbling fissure on the oasis' east bank."] = "Südöstlich von {area:380}. Teste die Samen an der blubbernden Spalte am Ostufer der Oase.",
	-- ["Southsea beach"] = "Strand der Südmeerfreibeuter",
	-- ["Sunscale raptors here count toward the heads."] = "Sunscaleraptoren hier zählen für die Köpfe.",
	-- ["The Savannah Prowlers hunt the plains between town and the Razormane camp to the east. In the camp, Water Seekers and Thornweavers hold the western half, Hunters the middle; the supply crates sit at its eastern end."] = "Die Savannenstreuner jagen auf den Ebenen zwischen dem Ort und dem Lager der Grimmhauer im Osten. Im Lager halten Wassersucher und Dornenwirker die westliche Hälfte, Jäger die Mitte; die Vorratskisten stehen am östlichen Ende.",
	-- ["The Witchwing Slayers hold the western {area:383}; they wear the rings."] = "Die Töterinnen der Hexenschwingen halten den Westen von {area:383}; sie tragen die Ringe.",
	-- ["The antennae vanish fifteen minutes after they drop: kill the Silithid Swarmers and Creepers at the same mounds until you have five, then take them straight to {npc:6394} in {area:378}, before the thunderhawks.\nCareful: Silithid Swarmers (level 21-22) cast {npc:4196} both in and out of combat, which brings several small adds. Silithid Creepers (level 20-21) periodically cast {npc:5781} in combat, which spawns extra adds."] = "Die Fühler verschwinden fünfzehn Minuten, nachdem sie fallen: Töte Silithidschwärmer und Silithidkrabbler an denselben Hügeln, bis du fünf hast, und bring sie dann direkt zu {npc:6394} in {area:378}, noch vor den Donnerfalken.\nVorsicht: Silithidschwärmer (Stufe 21-22) wirken {npc:4196} im und außerhalb des Kampfes, was mehrere kleine Adds herbeiholt. Silithidkrabbler (Stufe 20-21) wirken im Kampf regelmäßig {npc:5781}, was zusätzliche Adds hervorbringt.",
	-- ["The pirates camp on the beach south of {area:392}. The piles of complicated parts lie in the sand among them."] = "Die Piraten lagern am Strand südlich von {area:392}. Die Haufen komplizierter Teile liegen zwischen ihnen im Sand.",
	-- ["The pools lie just north of {npc:3389}. Walk into the water to explore them; the Laden Mushrooms for Helbrim grow around them. Kill every Kolkar you pass for bracers."] = "Die Teiche liegen gleich nördlich von {npc:3389}. Geh ins Wasser, um sie zu erkunden; die Potenten Pilze für Helbrim wachsen drumherum. Töte jeden Kolkar auf dem Weg für Armschienen.",
	-- ["The three nests sit together in the {area:1697} south-west of the oasis; Sunscale Scytheclaws guard them."] = "Die drei Nester liegen zusammen in {area:1697} südwestlich der Oase; Bluthornsensenklauen bewachen sie.",
	-- ["The thunder lizards across the river"] = "Die Donnerechsen jenseits des Flusses",
	-- ["The tool buckets with the slugs lie around the Venture Co. drill site in the {area:382}, east of {npc:9316}."] = "Die Werkzeugkisten mit den Patronen liegen um die Bohrstelle der Venture Co. in {area:382}, östlich von {npc:9316}.",
	-- ["The {area:383}"] = "{area:383}",
	-- ["The {object:4141} stands at the Venture Co. research site west of the {area:382}. Close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471} beside it."] = "{object:4141} steht bei der Forschungsstätte der Venture Co. westlich von {area:382}. Schließ die drei Ventile um den Bohrer, benutze die Konsole erneut und nimm dann {item:5089} von {npc:3471} daneben.",
	-- ["Thun'grim camps beside the road from the {area:380} to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "Thun'grim lagert an der Straße von {area:380} nach {area:392}. {object:58369} steht im Süden des Lagers der Grimmhauer gleich nördlich von ihm.",
	-- ["Thunder Lizards and Lightning Hides graze just across the bridge below {area:379}."] = "Donnerechsen und Blitzechsen grasen gleich jenseits der Brücke unterhalb von {area:379}.",
	-- ["Thunder Lizards and Lightning Hides graze just across the bridge below {area:379}.\nCareful: Halikor, a level 12 elite, roams {area:369} among the lizards: watch for him before you pull."] = "Donnerechsen und Blitzechsen grasen gleich jenseits der Brücke unterhalb von {area:379}.\nVorsicht: Halikor, eine Elite der Stufe 12, streift zwischen den Echsen über {area:369}: Achte auf ihn, bevor du pullst.",
	-- ["Thunder lizards across the river"] = "Donnerechsen jenseits des Flusses",
	-- ["Thunderhawk Cloudscrapers circle over the plains south of the camp."] = "Donnerfalkenwolkenkitzler kreisen über den Ebenen südlich des Lagers.",
	-- ["Walk back south to the {area:380}. The next guide starts here and takes you to {zone:1454} and the zeppelin to {zone:1420}."] = "Geh zurück nach Süden nach {area:380}. Der nächste Guide beginnt hier und bringt dich nach {zone:1454} und zum Zeppelin nach {zone:1420}.",
	-- ["Walk back west along the road to the {area:380}."] = "Geh die Straße zurück nach Westen nach {area:380}.",
	-- ["West to the {area:383}. The Witchwing harpies nest all over them; any of them can drop a talon. {quest:819} lies in their hills."] = "Nach Westen in {area:383}. Die Harpyien der Hexenschwingen nisten überall dort; jede kann eine Klaue fallen lassen. {quest:819} liegt in ihren Hügeln.",
	-- ["Zhevra"] = "Zhevras",
	-- ["Zhevra Runners graze north and east of town."] = "Zhevra-Läufer grasen nördlich und östlich des Orts.",
	-- ["{area:1898} cultists"] = "Kultisten in {area:1898}",
	-- ["{area:380} is your base for this guide. Everyone you need stands within a few steps of the inn."] = "{area:380} ist deine Basis für diesen Guide. Alle, die du brauchst, stehen nur wenige Schritte vom Gasthaus entfernt.",
	-- ["{item:15885}: use a half at the {area:2362}"] = "{item:15885}: Benutze eine Hälfte beim {area:2362}",
	-- ["{npc:3033}: Cat Form"] = "{npc:3033}: Katzengestalt",
	-- ["{npc:3033}: Cure Poison"] = "{npc:3033}: Vergiftung heilen",
	-- ["{npc:3395} walks among the Kolkar at the {area:388} south-east of the Crossroads. Oasis Snapjaws crawl in the water around it: their shells are for {npc:3448}."] = "{npc:3395} läuft zwischen den Kolkar an der {area:388} südöstlich vom Wegekreuz herum. Oasenschnappkiefer kriechen im Wasser drumherum: Ihre Panzer sind für {npc:3448}.",
	-- ["{npc:3442} in {area:392}: later, on the way"] = "{npc:3442} in {area:392}: später, auf dem Weg",
	-- ["{npc:3448}: the Oasis Snapjaws at the {area:388}, with {npc:3395}"] = "{npc:3448}: die Oasenschnappkiefer an der {area:388}, mit {npc:3395}",
	-- ["{npc:3615}, the wind rider master"] = "{npc:3615}, der Windreitermeister",
	-- ["{npc:5878} camps beside the road from the Crossroads to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "{npc:5878} lagert neben der Straße vom Wegekreuz nach {area:392}. Die {object:58369} steht im Süden des Lagers der Klingenmähnen, direkt nördlich von ihm.",
	-- ["{npc:5878} camps beside the road from the {area:380} to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "{npc:5878} lagert an der Straße von {area:380} nach {area:392}. {object:58369} steht im Süden des Lagers der Grimmhauer gleich nördlich von ihm.",
	-- ["{npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "{npc:5900} macht aus dem Teer und dem Beutel {item:6636}. Benutze es am Kohlenbecken neben ihm, um {npc:5893} sichtbar zu machen, töte sie für {item:6655} und leg die Glut dann ins Kohlenbecken.",
	-- ["{npc:5900} waits on the riverbank south of {area:379}, across the bridge."] = "{npc:5900} wartet am Flussufer südlich von {area:379}, jenseits der Brücke.",
	-- ["{npc:5907} stands on the ridge north of the Razormane camp."] = "{npc:5907} steht auf dem Kamm nördlich des Lagers der Grimmhauer.",
	-- ["{quest:3301}: the {area:228} in {zone:1421}, next guide"] = "{quest:3301}: {area:228} in {zone:1421}, nächster Guide",
	-- ["{quest:881}, a white lion, prowls the plains north of the Razormane camp."] = "{quest:881}, ein weißer Löwe, streift über die Ebenen nördlich des Lagers der Grimmhauer.",
}
