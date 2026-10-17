-- German (deDE): the guide forever/horde/40-50/05-the-hinterlands (forever/horde/40-50/05-the-hinterlands.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "Flieg nach {area:75}",
	-- {area:1446} Thorium Point
	["From {area:1446}'s flight master."] = "Vom Flugmeister am {area:1446}.",

	-- Step 2: The bloodmages
	["The bloodmages"] = "Die Blutmagier",
	-- {area:75} Stonard · {zone:1419} Blasted Lands
	["Ride west out of {area:75} and south through the canyon into the {zone:1419}; the two bloodmages stand by the road just inside."] = "Reite nach Westen aus {area:75} und nach Süden durch die Schlucht in die {zone:1419}; die beiden Blutmagier stehen gleich dahinter an der Straße.",

	-- Step 3: The northern beasts
	["The northern beasts"] = "Die nördlichen Bestien",
	-- {npc:5982} Black Slayer
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger
	["The five quests share the same parts: gather them all in one sweep. West of the road the {npc:5982} vultures, Starving Snickerfangs, Scorpok Stingers and Deatheye basilisks share the hills."] = "Die fünf Quests teilen sich dieselben Teile: Sammle alle auf einem Durchgang. Westlich der Straße teilen sich {npc:5982}-Geier, Verhungernde Kicherfänge, Skorpokstecher und Todesaugen-Basilisken die Hügel.",

	-- Step 4: The eastern slopes
	["The eastern slopes"] = "Die östlichen Hänge",
	["East of the road the Ashmane boars and Grunters root on the slopes beside the Redstone basilisks. Stay away from the level 52 Helboars further south."] = "Östlich der Straße wühlen Aschmähneneber und Suhlamane an den Hängen neben den Rotsteinbasilisken. Halte dich von den Höllenebern der Stufe 52 weiter südlich fern.",

	-- Step 5: The bloodmages
	["Ride back north to the bloodmages."] = "Reite zurück nach Norden zu den Blutmagiern.",
	["Their follow-ups ask for the same parts again for a buff item and pay no experience: leave them."] = "Ihre Folgequests wollen dieselben Teile noch einmal für einen Buffgegenstand und geben keine Erfahrung: Lass sie liegen.",

	-- Step 6: Grind to 48
	["Grind to 48"] = "Bis 48 grinden",
	["Only if you are not level 48 yet."] = "Nur wenn du noch nicht Stufe 48 bist.",
	["Vulture hills"] = "Geierhügel",
	-- {npc:5982} Black Slayer · {zone:1419} Blasted Lands
	["grind on {npc:5982} at the northern hills, {zone:1419}"] = "grinde {npc:5982} in den nördlichen Hügeln, {zone:1419}",

	-- Step 7: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "Flieg nach {area:1497}",
	-- {area:75} Stonard · {area:1497} Undercity
	["Ride north back to {area:75} and fly to the {area:1497}."] = "Reite nach Norden zurück nach {area:75} und flieg nach {area:1497}.",

	-- Step 8: Undercity
	-- {npc:7825} Oran Snakewrithe · {object:36126} Royal Quarter
	["{npc:7825}, the {object:36126}"] = "{npc:7825}, {object:36126}",
	-- {npc:6741} Innkeeper Norman · {zone:1456} Thunder Bluff
	["{npc:6741}: for {zone:1456}, around level 50"] = "{npc:6741}: für {zone:1456}, etwa ab Stufe 50",

	-- Step 9: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Flieg nach {area:272}",

	-- Step 10: Gilveradin Sunchaser's camp
	-- {npc:7801} Gilveradin Sunchaser
	["{npc:7801}'s camp"] = "{npc:7801}s Lager",
	-- {area:272} Tarren Mill · {zone:1425} The Hinterlands · {npc:7801} Gilveradin Sunchaser · {area:350} Quel'Danil Lodge
	["Ride north-east from {area:272} into the {zone:1425} and east along the road; {npc:7801} camps on the hill south of the elves' {area:350}."] = "Reite von {area:272} nach Nordosten ins {zone:1425} und auf der Straße nach Osten; {npc:7801} lagert auf dem Hügel südlich der {area:350} der Elfen.",

	-- Step 11: Highvale
	["Highvale"] = "Hochtal",
	-- {area:350} Quel'Danil Lodge · {npc:7780} Rin'ji
	["The Highvale elves camp around {area:350}. Burn the report, the notes and the records in their camps. {npc:7780} is held inside the lodge: lead him out and fight off the ambush on the way."] = "Die Elfen des Hochtals lagern um {area:350}. Verbrenne den Bericht, die Notizen und die Aufzeichnungen in ihren Lagern. {npc:7780} wird in der Jagdhütte festgehalten: Führ ihn hinaus und wehr unterwegs den Hinterhalt ab.",

	-- Step 12: Grim Message
	-- {item:15002} Nimboya's Pike
	["South of the lodge the Witherbark trolls hold their villages. Every one of them carries a skull: with twenty, use {item:15002} to make the Laden Pike, then plant it inside the village."] = "Südlich der Jagdhütte halten die Trolle der Witherbark ihre Dörfer. Jeder von ihnen trägt einen Schädel: Mit zwanzig benutzt du {item:15002}, um Nimboyas geladene Pike zu machen, und pflanzt sie dann im Dorf auf.",

	-- Step 13: Violet Tragan
	["East of the village, the violet flower grows in the hills."] = "Östlich des Dorfs wächst der Violette Tragan in den Hügeln.",

	-- Step 14: The Atal'ai Exile
	-- {area:353} Shadra'Alor
	["South-west again, the exile hides by the ruins of {area:353}."] = "Wieder nach Südwesten: Der Verbannte versteckt sich bei den Ruinen von {area:353}.",

	-- Step 15: Revantusk Village
	-- {zone:1425} The Hinterlands
	["Follow the roads east across the {zone:1425} to the troll village on the eastern coast."] = "Folge den Straßen nach Osten durch das {zone:1425} zum Trolldorf an der Ostküste.",

	-- Step 16: Saltwater Snapjaws
	-- plural, as words: Saltwater Snapjaws = {npc:2505} Saltwater Snapjaw
	["Saltwater Snapjaws"] = "Salzwasserschnappkiefer",
	-- {npc:2491} Whiskey Slim
	["The big turtles crawl along the beaches north of the village. {npc:2491}'s port bottles lie on these beaches too, but his quest is not on this route. A snapjaw can drop OOX-09/HL's distress beacon, rarely: keep it."] = "Die großen Schildkröten kriechen über die Strände nördlich des Dorfs. Die Portweinflaschen von {npc:2491} liegen auch an diesen Stränden, aber seine Quest ist nicht auf dieser Route. Ein Schnappkiefer kann selten das Notsignal von OOX-09/HL fallen lassen: Behalte es.",
	-- {item:8704} OOX-09/HL Distress Beacon
	["{item:8704}, a rare drop"] = "{item:8704}, eine seltene Beute",

	-- Step 17: Rin'ji's Secret
	-- {area:307} Overlook Cliffs
	["The secret lies on the {area:307}, above the beach."] = "Das Geheimnis liegt auf den {area:307}, über dem Strand.",
	-- {npc:7825} Oran Snakewrithe · {zone:1458} Undercity
	["for {npc:7825} in the {zone:1458}, around level 50"] = "für {npc:7825} in {zone:1458}, etwa ab Stufe 50",

	-- Step 18: Lard's lunch
	-- {npc:14731} Lard
	["{npc:14731}'s lunch"] = "Mittagessen von {npc:14731}",
	-- {npc:14731} Lard · {npc:14748} Vilebranch Kidnapper
	["North along the coast, {npc:14731}'s picnic basket is on the small island; a {npc:14748} guards it."] = "Nördlich an der Küste steht der Picknickkorb von {npc:14731} auf der kleinen Insel; ein {npc:14748} bewacht ihn.",

	-- Step 19: The Vilebranch temples
	["The Vilebranch temples"] = "Die Tempel der Vilebranch",
	-- {area:1884} Agol'watha · {area:1917} Shaol'watha
	["West of the island, the Vilebranch scalpers hold the temples of {area:1884} and {area:1917}. Slagtree's tools lie at one of the temples."] = "Westlich der Insel halten die Skalpierer der Vilebranch die Tempel von {area:1884} und {area:1917}. Schmied Slagtrees Werkzeug liegt bei einem der Tempel.",

	-- Step 20: The central hills
	["The central hills"] = "Die zentralen Hügel",
	-- {area:351} Skulk Rock · {item:9618} Wildkin Muisek Vessel · {npc:14738} Otho Moji'ko
	-- plural, as words: Silvermane Stalkers = {npc:2926} Silvermane Stalker · Savage Owlbeasts = {npc:2929} Savage Owlbeast · Razorbeak Skylords = {npc:2659} Razorbeak Skylord · Long Elegant Feathers = {item:4589} Long Elegant Feather
	["The Silvermane Stalkers, Savage Owlbeasts and Razorbeak Skylords share the hills between the temples and {area:351}. Use the {item:9618} on the owlbeasts you kill. The Skylords also drop Long Elegant Feathers: keep ten for {npc:14738}'s second message."] = "Die Silbermähnenpirscher, Wilden Eulenbestien und Klingenschnabelhimmelsfürsten teilen sich die Hügel zwischen den Tempeln und {area:351}. Benutze {item:9618} an den Eulenbestien, die du tötest. Die Himmelsfürsten lassen auch Lange elegante Federn fallen: Behalte zehn für {npc:14738}s zweite Nachricht.",

	-- Step 21: Skulk Rock
	-- {item:8684} Hinterlands Honey Ripple · {area:351} Skulk Rock
	["The crates of {item:8684} lie around the abandoned Horde camp at {area:351}, among the oozes."] = "Die Kisten mit {item:8684} liegen um das verlassene Hordelager am {area:351}, zwischen den Schlammen.",

	-- Step 22: OOX-09/HL
	["OOX-09/HL"] = "OOX-09/HL",
	-- {area:351} Skulk Rock · {area:307} Overlook Cliffs · {area:35} Booty Bay
	["Only with the distress beacon: the robot sits at the head of the river west of {area:351}. Escort it east to the shore beyond the {area:307}; its reward waits with Oglethorpe in {area:35}."] = "Nur mit dem Notsignal: Der Roboter sitzt an der Quelle des Flusses westlich vom {area:351}. Eskortiere ihn nach Osten zum Ufer hinter den {area:307}; seine Belohnung wartet bei Oglethorpe in {area:35}.",

	-- Step 23: Silvermane Howlers
	-- plural, as words: Silvermane Howlers = {npc:2925} Silvermane Howler
	["Silvermane Howlers"] = "Silbermähnenheuler",
	-- plural, as words: Silvermane Howlers = {npc:2925} Silvermane Howler
	["South-west, the Silvermane Howlers roam the hills east of the Witherbark villages."] = "Im Südwesten streifen die Silbermähnenheuler durch die Hügel östlich der Dörfer der Witherbark.",

	-- Step 24: Highvale
	-- {area:350} Quel'Danil Lodge
	["Back west to {area:350}; rangers and marksmen stay near the lodge, scouts and outrunners on the slopes south of it."] = "Zurück nach Westen zur {area:350}; Waldläuferinnen und Schützen bleiben nahe der Jagdhütte, Späher und Kundschafterinnen an den Hängen südlich davon.",

	-- Step 25: Gilveradin Sunchaser's camp
	-- {npc:6986} Dran Droffers · {zone:1454} Orgrimmar
	["for {npc:6986} in {zone:1454}, around level 50"] = "für {npc:6986} in {zone:1454}, etwa ab Stufe 50",

	-- Step 26: Vilebranch soothsayers
	["Vilebranch soothsayers"] = "Sterndeuter der Vilebranch",
	-- {area:355} Altar of Zul · {npc:8636} Morta'gya the Keeper
	["On the way back east, the Vilebranch soothsayers hold the {area:355}, the troll temple south of the central hills. Qiaga and {npc:8636} (elite, 50) stand at its top: take the soothsayers on the lower steps."] = "Auf dem Rückweg nach Osten halten die Sterndeuter der Vilebranch {area:355}, den Trolltempel südlich der zentralen Hügel. Qiaga und {npc:8636} (Elite, 50) stehen oben: Nimm dir die Sterndeuter auf den unteren Stufen vor.",

	-- Step 27: Jintha'Alor
	-- {area:354} Jintha'Alor · {npc:14757} Elder Torntusk
	["Huntsman Malkhor's skull lies on a pile below the Vilebranch ruins, his bones on a pile at the foot of {area:354}. The Vessels of Tainted Blood sit on the lower terraces, and {npc:14757} is held at the top. Keep to the paths: the trolls inside are elite."] = "Malkors Schädel liegt auf einem Haufen unterhalb der Ruinen der Vilebranch, Malkors Knochen auf einem Haufen am Fuß von {area:354}. Die Gefäße mit besudelten Blut stehen auf den unteren Terrassen, und {npc:14757} wird oben festgehalten. Bleib auf den Wegen: Die Trolle drinnen sind Elite.",
	-- {npc:14757} Elder Torntusk · {area:354} Jintha'Alor
	["{npc:14757}, at the top of {area:354}"] = "{npc:14757}, oben in {area:354}",
	-- {area:355} Altar of Zul
	["His next request, going on to the {area:355}, is for a group."] = "Seine nächste Bitte, weiter zu {area:355}, ist etwas für eine Gruppe.",

	-- Step 29: Aerie Peak
	-- {area:348} Aerie Peak
	["Ride all the way west to the Wildhammer town of {area:348} and place the message by the well in its centre. The town is full of Alliance guards: get in, place it and get out."] = "Reite ganz nach Westen zur Stadt der Wildhammer, {area:348}, und leg die Nachricht beim Brunnen in ihrer Mitte ab. Die Stadt ist voller Wachen der Allianz: Rein, ablegen, raus.",
	-- {area:348} Aerie Peak
	["{area:348} well"] = "Brunnen von {area:348}",

	-- Step 30: Revantusk Village
	-- {area:3317} Revantusk Village
	["The next guide starts here, at {area:3317}."] = "Der nächste Guide beginnt hier, in {area:3317}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the roads east across the {zone:1425} to the troll village on the eastern coast."] = "Folge den Straßen nach Osten durch das {zone:1425} zum Trolldorf an der Ostküste.",
	-- ["Huntsman Malkhor's skull lies on a pile below the Vilebranch ruins, his bones on a pile at the foot of {area:354}. The Vessels of {spell:19478} sit on the lower terraces, and {npc:14757} is held at the top. Keep to the paths: the trolls inside are elite."] = "Der Schädel von Jäger Malkhor liegt auf einem Haufen unterhalb der Ruinen der Vilebranch, seine Knochen auf einem Haufen am Fuß von {area:354}. Die Gefäße mit {spell:19478} stehen auf den unteren Terrassen, und {npc:14757} wird oben festgehalten. Bleib auf den Wegen: Die Trolle drinnen sind Elite.",
	-- ["Ride north-east from {area:272} into the {zone:1425} and east along the road; {npc:7801} camps on the hill south of the elves' {area:350}."] = "Reite von {area:272} nach Nordosten ins {zone:1425} und auf der Straße nach Osten; {npc:7801} lagert auf dem Hügel südlich der {area:350} der Elfen.",
}
