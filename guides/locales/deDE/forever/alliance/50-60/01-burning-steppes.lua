-- German (deDE): the guide forever/alliance/50-60/01-burning-steppes (forever/alliance/50-60/01-burning-steppes.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Menethil Harbor
	-- {zone:1455} Ironforge · {area:150} Menethil Harbor · {area:442} Auberdine
	["Fly from {zone:1455} to {area:150} and take the boat to {area:442}."] = "Flieg von {zone:1455} nach {area:150} und nimm das Boot nach {area:442}.",

	-- Step 2: Auberdine
	-- {area:442} Auberdine · {area:415} Astranaar
	["From the {area:442} dock, fly to {area:415}."] = "Flieg vom Steg in {area:442} nach {area:415}.",

	-- Step 3: Talrendis Point
	-- {zone:1440} Ashenvale · {zone:1447} Azshara · {area:3137} Talrendis Point
	["Ride east along the road out of {zone:1440} into {zone:1447} to the Sentinels' camp at {area:3137}."] = "Reite die Straße nach Osten aus {zone:1440} hinaus nach {zone:1447} zum Lager der Schildwachen bei {area:3137}.",

	-- Step 4: Shadowsong Shrine
	-- {zone:1447} Azshara · {area:3137} Talrendis Point
	["The shrine lies in the south-west corner of {zone:1447}, south of {area:3137}."] = "Der Schrein liegt in der Südwestecke von {zone:1447}, südlich von {area:3137}.",

	-- Step 5: Haldarr Encampment
	["The Highborne ghosts haunt the ruins around the shrine; the Haldarr satyrs hold the camp just north of it."] = "Die Geister der Hochgeborenen spuken in den Ruinen um den Schrein; die Satyrn der Haldarr halten das Lager gleich nördlich davon.",

	-- Step 7: Ogtinc
	-- {npc:8405} Ogtinc · {area:1224} Bear's Head
	["Ride north-east from the shrine: {npc:8405} camps at the {area:1224}, in the hills above the road."] = "Reite vom Schrein nach Nordosten: {npc:8405} lagert beim {area:1224}, in den Hügeln über der Straße.",

	-- Step 8: Mosshoof Coursers
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers"] = "Mooshufrenner",
	-- {area:1224} Bear's Head · {area:1219} Legashi Encampment
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south."] = "Die nächsten Mooshufrenner grasen in den Hügeln nordöstlich des {area:1224}, Richtung {area:1219}; eine größere Herde streift durch das offene Gelände im Süden.",

	-- Step 10: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo
	-- plural, as words: Undamaged Hippogryph Feathers = {item:10450} Undamaged Hippogryph Feather
	["Optional: {npc:8395} wants two Undamaged Hippogryph Feathers from the hippogryphs around his camp. The data lists no experience for it."] = "Optional: {npc:8395} will zwei Unbeschädigte Hippogryphenfedern von den Hippogryphen um sein Lager. Die Daten nennen dafür keine Erfahrung.",

	-- Step 11: Kim'jael
	-- {npc:8420} Kim'jael · {area:1219} Legashi Encampment · {area:1220} Thalassian Base Camp
	["{npc:8420} camps at the {area:1219} in the north; his equipment lies all over the {area:1220} just south-east of him."] = "{npc:8420} lagert bei {area:1219} im Norden; seine Ausrüstung liegt überall in {area:1220} gleich südöstlich von ihm verstreut.",

	-- Step 12: The Ruins of Eldarath
	-- {area:1221} Ruins of Eldarath
	["The {area:1221}"] = "{area:1221}",
	-- {area:1221} Ruins of Eldarath · {item:13815} Some Rune · {npc:8507} Tymor · {item:10445} Drawing Kit
	["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s four runes stand among the ruins: use his {item:10445} on each."] = "Die Naga der Grollflossen in {area:1221} tragen {item:13815}. Die vier Runen von {npc:8507} stehen zwischen den Ruinen: Benutze sein {item:10445} an jeder.",
	-- {item:7972} Ichor of Undeath · {npc:7864} Lingering Highborne
	["{item:7972}: the {npc:7864}, about 10%"] = "{item:7972}: der {npc:7864}, etwa 10%",

	-- Step 13: Ogtinc
	-- {npc:8405} Ogtinc · {area:1224} Bear's Head
	["Climb back to {npc:8405} at the {area:1224}, above the ruins."] = "Klettere zurück zu {npc:8405} beim {area:1224}, oberhalb der Ruinen.",

	-- Step 15: Ravencrest Monument
	-- {zone:1447} Azshara · {npc:8392} Pilot Xiggs Fuselighter
	["Swim to the small island off the southern tip of {zone:1447}: {npc:8392} waits by the monument."] = "Schwimm zur kleinen Insel vor der Südspitze von {zone:1447}: {npc:8392} wartet beim Denkmal.",

	-- Step 17: Lakeshire
	-- {zone:1455} Ironforge · {area:69} Lakeshire
	["Fly from {zone:1455} to {area:69}."] = "Flieg von {zone:1455} nach {area:69}.",

	-- Step 18: Morgan's Vigil
	-- {area:69} Lakeshire · {zone:1428} Burning Steppes · {area:2418} Morgan's Vigil
	["Ride north out of {area:69} through the pass into the {zone:1428}; {area:2418} sits at the top, in the south-east of the Steppes."] = "Reite nach Norden aus {area:69} durch den Pass in die {zone:1428}; {area:2418} liegt oben, im Südosten der Steppe.",
	-- {npc:9177} Oralius
	["{npc:9177}: the Blackrock orcs drop the medallions, keep it open all through the Steppes"] = "{npc:9177}: Die Orcs der Blackrock lassen die Medaillons fallen, lass sie die ganze Steppe über offen",

	-- Step 19: Dreadmaul Rock
	["The Firegut ogres hold the great rock north of the Vigil, with the Brutes on its east side."] = "Die Oger der Feuermägen halten den großen Felsen nördlich der Wacht, mit den Schlägern auf seiner Ostseite.",

	-- Step 21: Flame Crest
	-- {area:251} Flame Crest
	["Follow the road west, then climb north to the goblin camp on {area:251}."] = "Folge der Straße nach Westen und klettere dann nach Norden zum Goblinlager am {area:251}.",

	-- Step 22: Thaurissan Relics
	-- plural, as words: Thaurissan Relics = {object:153556} Thaurissan Relic
	["Thaurissan Relics"] = "Thauris-Relikte",
	-- {area:250} Ruins of Thaurissan · {area:251} Flame Crest
	["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered."] = "Die Relikte sind die behauenen Steine, verstreut in den {area:250} um den {area:251}: Klick sie an, bis die Informationen geborgen sind.",

	-- Step 23: The Tablet of the Seven
	-- {quest:4296} Tablet of the Seven
	["The {quest:4296}"] = "{quest:4296}",
	-- {object:147516} Dark Iron · {area:251} Flame Crest
	["Read the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript."] = "Lies die Tafel im Lager von {object:147516} zwischen den Ruinen südwestlich des {area:251}, um die Abschrift anzufertigen.",

	-- Step 24: Broodling Essence
	-- {item:12284} Draco-Incarcinatrix 900 · {npc:7047} Black Broodling · {area:251} Flame Crest
	["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves."] = "Benutze die {item:12284} an einem {npc:7047} an den Hängen östlich des {area:251} kurz vor seinem Tod und plündere dann die Essenz, die er hinterlässt.",

	-- Step 25: Flame Crest
	-- {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Ends with {quest:4808} in {area:2255}, {zone:1452}: keep it"] = "Endet bei {quest:4808} in {area:2255}, {zone:1452}: Behalte es",

	-- Step 26: Blackrock Stronghold
	-- {npc:9176} Gor'tesh · {area:254} Blackrock Mountain · {area:251} Flame Crest
	["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty."] = "{npc:9176} und die Orcs der Blackrock halten die Lager und die Festung am Fuß des {area:254}, westlich des {area:251}. Zieh sie einzeln; jeder Orc und Worg kann ein Medaillon fallen lassen, töte sie also, bis du fünfzig hast.",

	-- Step 27: Franclorn Forgewright
	-- {npc:8888} Franclorn Forgewright · {area:254} Blackrock Mountain
	["Optional: {npc:8888}'s ghost stands on his tomb on the great chain inside {area:254}, and only the dead can see him. If you die near the mountain anyway, run your spirit to him before resurrecting."] = "Optional: {npc:8888}s Geist steht auf seinem Grab an der großen Kette im {area:254}, und nur Tote können ihn sehen. Stirbst du ohnehin nahe dem Berg, lauf als Geist zu ihm, bevor du wiederbelebt wirst.",

	-- Step 28: Morgan's Vigil
	["Ride back east along the road to the Vigil."] = "Reite die Straße zurück nach Osten zur Wacht.",

	-- Step 29: Dreadmaul Rock
	-- {area:249} Dreadmaul Rock
	["Climb to the top of {area:249} and plant the head in the soft dirt mound."] = "Klettere auf den {area:249} und pflanze den Kopf in den Haufen weicher Erde.",

	-- Step 31: Nethergarde Keep
	-- {area:1438} Nethergarde Keep
	["Fly to {area:1438}."] = "Flieg nach {area:1438}.",

	-- Step 32: Kum'isha the Collector
	-- {npc:7363} Kum'isha the Collector · {area:2517} Rise of the Defiler · {zone:1419} Blasted Lands
	-- plural, as words: Imperfect Draenethyst Fragments = {item:10593} Imperfect Draenethyst Fragment
	["{npc:7363} waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have."] = "{npc:7363} wartet beim {area:2517}, dem Hügel südwestlich der Burg. Die Gegner der {zone:1419} unterwegs lassen die Unvollständigen Draenethystfragmente fallen; bring ihr, was du hast.",

	-- Step 33: Wildkin feathers
	["Wildkin feathers"] = "Wildekinfedern",
	-- {area:1438} Nethergarde Keep · {area:348} Aerie Peak · {zone:1425} Hinterlands
	-- plural, as words: Wildkin Feathers = {item:10819} Wildkin Feather
	["Ride back to {area:1438} and fly to {area:348}. The Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "Reite zurück nach {area:1438} und flieg nach {area:348}. Die Wildekinfedern liegen überall im {zone:1425} auf dem Boden, südlich und östlich von {area:348}, wo die Eulenbestien umherstreifen; die Gegner hier sind jetzt weit unter dir.",

	-- Step 35: Menethil Harbor
	-- {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village
	["Fly to {area:150} and take the boat to {area:442}, then the boat on to {area:702}."] = "Flieg nach {area:150} und nimm das Boot nach {area:442}, dann das Boot weiter nach {area:702}.",

	-- Step 36: Rut'theran Village
	-- {zone:1452} Winterspring
	["The wildkin are in {zone:1452}: keep it"] = "Die Wildekin sind in {zone:1452}: Behalte es",

	-- Step 37: Druid training
	["Druid training"] = "Druidentraining",
	-- {zone:1455} Ironforge · {zone:1457} Darnassus · {area:1658} Cenarion Enclave · {area:702} Rut'theran Village
	["{zone:1455} has no druid trainer: take the portal up to {zone:1457} and train in the {area:1658}, then come back down to {area:702}."] = "{zone:1455} hat keinen Druidenlehrer: Nimm das Portal hinauf nach {zone:1457} und trainiere im {area:1658}, dann komm zurück hinab nach {area:702}.",
}
