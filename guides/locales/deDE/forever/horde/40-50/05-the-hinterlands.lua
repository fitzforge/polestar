-- German (deDE): the guide forever/horde/40-50/05-the-hinterlands (forever/horde/40-50/05-the-hinterlands.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Flieg nach {area:272}",
	-- {area:1446} Thorium Point
	["{area:1446} flight master"] = "",

	-- Step 2: The Hinterlands
	-- {npc:7801} Gilveradin Sunchaser
	["{npc:7801}'s camp"] = "{npc:7801}s Lager",

	-- Step 3: Gilveradin Sunchaser's camp
	-- {area:272} Tarren Mill · {zone:1425} The Hinterlands · {npc:7801} Gilveradin Sunchaser · {area:350} Quel'Danil Lodge
	["Ride north-east from {area:272} into the {zone:1425} and east along the road; {npc:7801} camps on the hill south of the elves' {area:350}."] = "Reite von {area:272} nach Nordosten ins {zone:1425} und auf der Straße nach Osten; {npc:7801} lagert auf dem Hügel südlich der {area:350} der Elfen.",

	-- Step 4: Highvale
	["Highvale"] = "Hochtal",
	-- {area:350} Quel'Danil Lodge · {npc:7780} Rin'ji
	["The Highvale elves camp around {area:350}. Burn the report, the notes and the records in their camps. {npc:7780} is held inside the lodge: lead him out and fight off the ambush on the way.\nCareful: Groups of about three elves ambush the escort, usually twice."] = "",

	-- Step 5: Violet Tragan
	["East of the village, the violet flower grows in the hills."] = "Östlich des Dorfs wächst der Violette Tragan in den Hügeln.",
	["Underwater"] = "",

	-- Step 6: Revantusk Village
	-- {zone:1425} The Hinterlands
	["Follow the roads east across the {zone:1425} to the troll village on the eastern coast."] = "Folge den Straßen nach Osten durch das {zone:1425} zum Trolldorf an der Ostküste.",

	-- Step 8: Revantusk Village
	-- {quest:7849} Separation Anxiety · {quest:7845} Kidnapped Elder Torntusk! · {quest:7850} Dark Vessels · {area:354} Jintha'Alor · {npc:14736} Primal Torntusk · {npc:14731} Lard
	["{quest:7849}, {quest:7845} and {quest:7850} are group quests: they send you into {area:354}, whose trolls are elite (46-50). Take them with a group of three or more; skip them if you are alone, the route has you grind the experience back.\n{npc:14736} stands up on top of the inn, above {npc:14731}: go up, the arrow cannot tell the levels apart."] = "",

	-- Step 9: The Overlook Cliffs: kill these as you meet them
	-- {area:307} The Overlook Cliffs
	["{area:307}: kill these as you meet them"] = "",
	-- {npc:2491} Whiskey Slim · {area:307} The Overlook Cliffs
	["The big turtles crawl along the beaches north of the village, and {npc:2491}'s bottles of port lie on the same beaches, from the village up to the {area:307}: pick them up as you go. A snapjaw can drop OOX-09/HL's distress beacon, rarely: keep it."] = "",
	-- {object:2068} Pupellyverbos Port
	["{object:2068}, on the beaches"] = "",
	-- {item:8704} OOX-09/HL Distress Beacon
	["{item:8704}, a rare drop"] = "{item:8704}, eine seltene Beute",

	-- Step 10: The Overlook Cliffs: kill these as you meet them
	-- {npc:7977} Gammerita
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:7977} is a level 48 elite: most classes solo it at level 50, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 11: Rin'ji's Secret
	-- {area:307} The Overlook Cliffs
	["The secret lies on the {area:307}, above the beach."] = "Das Geheimnis liegt auf den {area:307}, über dem Strand.",
	-- {npc:7825} Oran Snakewrithe · {zone:1458} Undercity
	["for {npc:7825} in the {zone:1458}, around level 50"] = "für {npc:7825} in {zone:1458}, etwa ab Stufe 50",

	-- Step 12: Lard's lunch
	-- {npc:14731} Lard
	["{npc:14731}'s lunch"] = "Mittagessen von {npc:14731}",
	-- {npc:14731} Lard · {npc:14748} Vilebranch Kidnapper
	["North along the coast, {npc:14731}'s picnic basket is on the small island; a {npc:14748} guards it."] = "Nördlich an der Küste steht der Picknickkorb von {npc:14731} auf der kleinen Insel; ein {npc:14748} bewacht ihn.",

	-- Step 14: Shaol'watha: kill these as you meet them
	-- {area:1917} Shaol'watha
	["{area:1917}: kill these as you meet them"] = "",
	-- {area:1884} Agol'watha · {area:1917} Shaol'watha · {area:351} Skulk Rock · {item:9618} Wildkin Muisek Vessel · {npc:14738} Otho Moji'ko · {spell:7367} Infected Bite · {npc:2925} Silvermane Howler
	-- plural, as words: Silvermane Stalkers = {npc:2926} Silvermane Stalker · Savage Owlbeasts = {npc:2929} Savage Owlbeast · Razorbeak Skylords = {npc:2659} Razorbeak Skylord · Long Elegant Feathers = {item:4589} Long Elegant Feather
	["West of the island, the Vilebranch scalpers hold the temples of {area:1884} and {area:1917}. Slagtree's tools lie at one of the temples.\nThe Silvermane Stalkers, Savage Owlbeasts and Razorbeak Skylords share the hills between the temples and {area:351}. Use the {item:9618} on the owlbeasts you kill. The Skylords also drop Long Elegant Feathers: keep ten for {npc:14738}'s second message.\nCareful: Silvermane Stalkers are level 47-48 and stay stealthed while out of combat. Up close they use {spell:7367}. When a {npc:2925} falls to 50% health or lower, it calls for help from anything within 25 yd."] = "",

	-- Step 15: Skulk Rock
	-- {item:8684} Hinterlands Honey Ripple · {area:351} Skulk Rock
	["The crates of {item:8684} lie around the abandoned Horde camp at {area:351}, among the oozes."] = "Die Kisten mit {item:8684} liegen um das verlassene Hordelager am {area:351}, zwischen den Schlammen.",

	-- Step 16: Wildkin Muisek
	-- {area:1883} Valorwind Lake
	["Careful: Stealthed wolves and griffons roam the {area:1883} area."] = "",

	-- Step 17: The Altar of Zul: kill these as you meet them
	-- {area:355} The Altar of Zul
	["{area:355}: kill these as you meet them"] = "",
	-- {area:355} The Altar of Zul · {npc:8636} Morta'gya the Keeper
	-- plural, as words: Silvermane Howlers = {npc:2925} Silvermane Howler
	["South-west of the lake, the Vilebranch soothsayers hold the {area:355}, the troll temple south of the central hills. Qiaga and {npc:8636} (elite, 50) stand at its top: take the soothsayers on the lower steps.\nSouth-west, the Silvermane Howlers roam the hills east of the Witherbark villages."] = "",

	-- Step 18: OOX-09/HL
	["OOX-09/HL"] = "OOX-09/HL",
	-- {area:351} Skulk Rock · {area:307} The Overlook Cliffs · {area:35} Booty Bay
	["Only with the distress beacon: the robot sits at the head of the river west of {area:351}. Escort it east to the shore beyond the {area:307}; its reward waits with Oglethorpe in {area:35}.\nCareful: Two ambushes spawn during the escort: first three wildkin owlbeasts, then three trolls. Before each, the robot halts and announces it senses danger. Oozes, stealthed wolves and a large turtle along the path can join fights, and they respawn even if cleared beforehand."] = "",

	-- Step 19: Gilveradin Sunchaser's camp
	-- {npc:6986} Dran Droffers · {zone:1454} Orgrimmar
	["for {npc:6986} in {zone:1454}, around level 50"] = "für {npc:6986} in {zone:1454}, etwa ab Stufe 50",

	-- Step 20: Highvale
	-- {area:350} Quel'Danil Lodge
	["Back west to {area:350}; rangers and marksmen stay near the lodge, scouts and outrunners on the slopes south of it."] = "Zurück nach Westen zur {area:350}; Waldläuferinnen und Schützen bleiben nahe der Jagdhütte, Späher und Kundschafterinnen an den Hängen südlich davon.",

	-- Step 21: Jintha'Alor
	-- {area:354} Jintha'Alor · {npc:14757} Elder Torntusk
	["Huntsman Malkhor's skull lies on a pile below the Vilebranch ruins, his bones on a pile at the foot of {area:354}. The Vessels of Tainted Blood sit on the lower terraces, and {npc:14757} is held at the top. The trolls inside are elite: stay with your group and keep to the paths."] = "",
	-- {npc:14757} Elder Torntusk · {area:354} Jintha'Alor
	["{npc:14757}, at the top of {area:354}"] = "{npc:14757}, oben in {area:354}",
	-- {area:355} The Altar of Zul
	["His next request, going on to the {area:355}, is for a group."] = "Seine nächste Bitte, weiter zu {area:355}, ist etwas für eine Gruppe.",

	-- Step 22: Revantusk Village
	-- {npc:14731} Lard
	["{npc:14731}, inside"] = "",

	-- Step 23: Revantusk Village
	-- {npc:14736} Primal Torntusk · {npc:14731} Lard
	["{npc:14736} stands up on top of the inn, above {npc:14731}: go up, the arrow cannot tell the levels apart."] = "",

	-- Step 25: Level 49.02
	["Level 49.02"] = "",
	-- {quest:7816} Gammerita, Mon! · {area:354} Jintha'Alor · {area:2100} Maraudon
	["If you skipped {quest:7816} or the {area:354} group quests, grind here to level 49.02 to stay on the route's plan. Or, with a group, run the {area:2100} dungeon instead."] = "",
	-- {npc:2505} Saltwater Snapjaw
	["grind on {npc:2505}"] = "",

	-- Step 26: The Atal'ai Exile
	-- {area:353} Shadra'Alor
	["South-west again, the exile hides by the ruins of {area:353}."] = "Wieder nach Südwesten: Der Verbannte versteckt sich bei den Ruinen von {area:353}.",

	-- Step 28: Grim Message
	-- {item:15002} Nimboya's Pike
	["South of the lodge the Witherbark trolls hold their villages. Every one of them carries a skull: with twenty, use {item:15002} to make the Laden Pike, then plant it inside the village."] = "Südlich der Jagdhütte halten die Trolle der Witherbark ihre Dörfer. Jeder von ihnen trägt einen Schädel: Mit zwanzig benutzt du {item:15002}, um Nimboyas geladene Pike zu machen, und pflanzt sie dann im Dorf auf.",

	-- Step 29: Aerie Peak
	-- {area:348} Aerie Peak
	["Ride all the way west to the Wildhammer town of {area:348} and place the message by the well in its centre. The town is full of Alliance guards: get in, place it and get out."] = "Reite ganz nach Westen zur Stadt der Wildhammer, {area:348}, und leg die Nachricht beim Brunnen in ihrer Mitte ab. Die Stadt ist voller Wachen der Allianz: Rein, ablegen, raus.",
	-- {area:348} Aerie Peak
	["{area:348} well"] = "Brunnen von {area:348}",

	-- Step 31: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "Flieg nach {area:75}",
	-- {area:3317} Revantusk Village
	["{area:3317} flight master"] = "",

	-- Step 32: Fel'zerul
	["On the top floor"] = "",

	-- Step 33: Fallen Hero of the Horde
	-- {zone:1419} Blasted Lands
	["The ghostly orc stands by the road where the swamp meets the canyon into the {zone:1419}. Listen to his story."] = "",

	-- Step 35: Fallen Hero of the Horde
	-- {npc:7623} Dispatch Commander Ruag · {area:75} Stonard · {zone:1419} Blasted Lands
	["for {npc:7623} in {area:75}, after the {zone:1419}"] = "",

	-- Step 36: The bloodmages
	["The bloodmages"] = "Die Blutmagier",
	-- {area:75} Stonard · {zone:1419} Blasted Lands
	["Ride west out of {area:75} and south through the canyon into the {zone:1419}; the two bloodmages stand by the road just inside."] = "Reite nach Westen aus {area:75} und nach Süden durch die Schlucht in die {zone:1419}; die beiden Blutmagier stehen gleich dahinter an der Straße.",

	-- Step 37: Serpent's Coil: kill these as you meet them
	-- {area:1440} Serpent's Coil
	["{area:1440}: kill these as you meet them"] = "",
	-- {npc:5982} Black Slayer · {spell:5416} Venom Sting · {npc:8301} Clack the Reaver
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger
	["The five quests share the same parts: gather them all in one sweep. West of the road the {npc:5982} vultures, Starving Snickerfangs, Scorpok Stingers and Deatheye basilisks share the hills.\nEast of the road the Ashmane boars and Grunters root on the slopes beside the Redstone basilisks. Stay away from the level 52 Helboars further south.\nCareful: Scorpok Stingers use {spell:5416}; {npc:8301} adds Knockdown."] = "",

	-- Step 38: The bloodmages
	["Ride back north to the bloodmages."] = "Reite zurück nach Norden zu den Blutmagiern.",
	["Their follow-ups ask for the same parts again for a buff item and pay no experience: leave them."] = "Ihre Folgequests wollen dieselben Teile noch einmal für einen Buffgegenstand und geben keine Erfahrung: Lass sie liegen.",

	-- Step 39: Stonard
	-- {area:75} Stonard
	["Ride back north through the canyon to {area:75}."] = "",
	-- {npc:7643} Bengor · {npc:950} Swamp Talker
	["{npc:7643}'s The {npc:950} is a level 55 quest: leave it."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["East of the road the Ashmane boars and Grunters root on the slopes beside the Redstone basilisks. Stay away from the level 52 Helboars further south."] = "Östlich der Straße wühlen Aschmähneneber und Suhlamane an den Hängen neben den Rotsteinbasilisken. Halte dich von den Höllenebern der Stufe 52 weiter südlich fern.",
	-- ["Fly to the {area:1497}"] = "Flieg nach {area:1497}",
	-- ["Follow the roads east across the {area:47} to the troll village on the eastern coast."] = "Folge den Straßen nach Osten durch das {area:47} zum Trolldorf an der Ostküste.",
	-- ["From {area:1446}'s flight master."] = "Vom Flugmeister am {area:1446}.",
	-- ["Grind to 48"] = "Bis 48 grinden",
	-- ["Huntsman Malkhor's skull lies on a pile below the Vilebranch ruins, his bones on a pile at the foot of {area:354}. The Vessels of Tainted Blood sit on the lower terraces, and {npc:14757} is held at the top. Keep to the paths: the trolls inside are elite."] = "Malkors Schädel liegt auf einem Haufen unterhalb der Ruinen der Vilebranch, Malkors Knochen auf einem Haufen am Fuß von {area:354}. Die Gefäße mit besudeltem Blut stehen auf den unteren Terrassen, und {npc:14757} wird oben festgehalten. Bleib auf den Wegen: Die Trolle drinnen sind Elite.",
	-- ["Huntsman Malkhor's skull lies on a pile below the Vilebranch ruins, his bones on a pile at the foot of {area:354}. The Vessels of {spell:19478} sit on the lower terraces, and {npc:14757} is held at the top. Keep to the paths: the trolls inside are elite."] = "Der Schädel von Jäger Malkhor liegt auf einem Haufen unterhalb der Ruinen der Vilebranch, seine Knochen auf einem Haufen am Fuß von {area:354}. Die Gefäße mit {spell:19478} stehen auf den unteren Terrassen, und {npc:14757} wird oben festgehalten. Bleib auf den Wegen: Die Trolle drinnen sind Elite.",
	-- ["On the way back east, the Vilebranch soothsayers hold the {area:355}, the troll temple south of the central hills. Qiaga and {npc:8636} (elite, 50) stand at its top: take the soothsayers on the lower steps."] = "Auf dem Rückweg nach Osten halten die Sterndeuter der Vilebranch {area:355}, den Trolltempel südlich der zentralen Hügel. Qiaga und {npc:8636} (Elite, 50) stehen oben: Nimm dir die Sterndeuter auf den unteren Stufen vor.",
	-- ["Only if you are not level 48 yet."] = "Nur wenn du noch nicht Stufe 48 bist.",
	-- ["Only with the distress beacon: the robot sits at the head of the river west of {area:351}. Escort it east to the shore beyond the {area:307}; its reward waits with Oglethorpe in {area:35}."] = "Nur mit dem Notsignal: Der Roboter sitzt an der Quelle des Flusses westlich vom {area:351}. Eskortiere ihn nach Osten zum Ufer hinter den {area:307}; seine Belohnung wartet bei Oglethorpe in {area:35}.",
	-- ["Ride north back to {area:75} and fly to the {area:1497}."] = "Reite nach Norden zurück nach {area:75} und flieg nach {area:1497}.",
	-- ["Ride north-east from {area:272} into the {area:47} and east along the road; {npc:7801} camps on the hill south of the elves' {area:350}."] = "Reite von {area:272} nach Nordosten ins {area:47} und auf der Straße nach Osten; {npc:7801} lagert auf dem Hügel südlich der {area:350} der Elfen.",
	-- ["Saltwater Snapjaws"] = "Salzwasserschnappkiefer",
	-- ["Silvermane Howlers"] = "Silbermähnenheuler",
	-- ["South-west, the Silvermane Howlers roam the hills east of the Witherbark villages."] = "Im Südwesten streifen die Silbermähnenheuler durch die Hügel östlich der Dörfer der Witherbark.",
	-- ["The Highvale elves camp around {area:350}. Burn the report, the notes and the records in their camps. {npc:7780} is held inside the lodge: lead him out and fight off the ambush on the way."] = "Die Elfen des Hochtals lagern um {area:350}. Verbrenne den Bericht, die Notizen und die Aufzeichnungen in ihren Lagern. {npc:7780} wird in der Jagdhütte festgehalten: Führ ihn hinaus und wehr unterwegs den Hinterhalt ab.",
	-- ["The Silvermane Stalkers, Savage Owlbeasts and Razorbeak Skylords share the hills between the temples and {area:351}. Use the {item:9618} on the owlbeasts you kill. The Skylords also drop Long Elegant Feathers: keep ten for {npc:14738}'s second message."] = "Die Silbermähnenpirscher, Wilden Eulenbestien und Klingenschnabelhimmelsfürsten teilen sich die Hügel zwischen den Tempeln und {area:351}. Benutze {item:9618} an den Eulenbestien, die du tötest. Die Himmelsfürsten lassen auch Lange elegante Federn fallen: Behalte zehn für {npc:14738}s zweite Nachricht.",
	-- ["The Vilebranch temples"] = "Die Tempel der Vilebranch",
	-- ["The big turtles crawl along the beaches north of the village. {npc:2491}'s port bottles lie on these beaches too, but his quest is not on this route. A snapjaw can drop OOX-09/HL's distress beacon, rarely: keep it."] = "Die großen Schildkröten kriechen über die Strände nördlich des Dorfs. Die Portweinflaschen von {npc:2491} liegen auch an diesen Stränden, aber seine Quest ist nicht auf dieser Route. Ein Schnappkiefer kann selten das Notsignal von OOX-09/HL fallen lassen: Behalte es.",
	-- ["The central hills"] = "Die zentralen Hügel",
	-- ["The eastern slopes"] = "Die östlichen Hänge",
	-- ["The five quests share the same parts: gather them all in one sweep. West of the road the {npc:5982} vultures, Starving Snickerfangs, Scorpok Stingers and Deatheye basilisks share the hills."] = "Die fünf Quests teilen sich dieselben Teile: Sammle alle auf einem Durchgang. Westlich der Straße teilen sich {npc:5982}-Geier, Verhungernde Kicherfänge, Skorpokstecher und Todesaugen-Basilisken die Hügel.",
	-- ["The next guide starts here, at {area:3317}."] = "Der nächste Guide beginnt hier, in {area:3317}.",
	-- ["The northern beasts"] = "Die nördlichen Bestien",
	-- ["Vilebranch soothsayers"] = "Sterndeuter der Vilebranch",
	-- ["Vulture hills"] = "Geierhügel",
	-- ["West of the island, the Vilebranch scalpers hold the temples of {area:1884} and {area:1917}. Slagtree's tools lie at one of the temples."] = "Westlich der Insel halten die Skalpierer der Vilebranch die Tempel von {area:1884} und {area:1917}. Schmied Slagtrees Werkzeug liegt bei einem der Tempel.",
	-- ["grind on {npc:5982} at the northern hills, {zone:1419}"] = "grinde {npc:5982} in den nördlichen Hügeln, {zone:1419}",
	-- ["{npc:6741}: for {zone:1456}, around level 50"] = "{npc:6741}: für {zone:1456}, etwa ab Stufe 50",
	-- ["{npc:7825}, the {object:36126}"] = "{npc:7825}, {object:36126}",
}
