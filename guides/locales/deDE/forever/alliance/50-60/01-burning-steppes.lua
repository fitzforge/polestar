-- German (deDE): the guide forever/alliance/50-60/01-burning-steppes (forever/alliance/50-60/01-burning-steppes.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Azshara
	-- {zone:1447} Azshara
	["Into {zone:1447}"] = "Nach {zone:1447}",
	-- {area:415} Astranaar · {area:2358} Forest Song · {zone:1447} Azshara · {area:1235} Shadowsong Shrine
	["From {area:415}, ride east along the road past {area:2358} into {zone:1447}: {area:1235} lies just over the border, in {zone:1447}'s south-west corner."] = "Reite von {area:415} nach Osten die Straße entlang, an {area:2358} vorbei, nach {zone:1447}: {area:1235} liegt gleich hinter der Grenze, in der Südwestecke von {zone:1447}.",
	-- {area:1235} Shadowsong Shrine
	["East along the road to {area:1235}"] = "Nach Osten die Straße entlang zu {area:1235}",

	-- Step 2: Shadowsong Shrine
	-- {zone:1447} Azshara · {area:3137} Talrendis Point
	["The shrine lies in the south-west corner of {zone:1447}, south of {area:3137}."] = "Der Schrein liegt in der Südwestecke von {zone:1447}, südlich von {area:3137}.",

	-- Step 3: Talrendis Point
	-- {npc:239822} Commander Truesong · {npc:240482} Berdun Cliffbrew · {area:3137} Talrendis Point
	["Just north-east of the shrine: {npc:239822} and {npc:240482} keep the Alliance camp at {area:3137}."] = "Gleich nordöstlich des Schreins: {npc:239822} und {npc:240482} halten das Lager der Allianz an der {area:3137}.",

	-- Step 4: Mosshoof Runners
	-- plural, as words: Mosshoof Runners = {npc:8759} Mosshoof Runner
	["Mosshoof Runners"] = "Mooshufläufer",
	-- {area:3137} Talrendis Point
	-- plural, as words: Mosshoof Runners = {npc:8759} Mosshoof Runner
	["The Mosshoof Runners (45-47) graze the hills north of {area:3137}, on the way to the satyrs."] = "Die Mooshufläufer (45-47) grasen in den Hügeln nördlich der {area:3137}, auf dem Weg zu den Satyrn.",

	-- Step 5: Azshara: kill these as you meet them
	-- {zone:1447} Azshara
	["{zone:1447}: kill these as you meet them"] = "{zone:1447}: Töte sie, wenn du ihnen begegnest",
	-- {npc:222478} Sentinel Keldara Sunblade
	["The Highborne ghosts haunt the ruins around the shrine; the Haldarr satyrs hold the camp just north of it. {npc:222478} is held in the satyrs' camp: free her and walk her out."] = "Die Geister der Hochgeborenen spuken in den Ruinen um den Schrein; die Satyrn der Haldarr halten das Lager gleich nördlich davon. {npc:222478} wird im Lager der Satyrn gefangen gehalten: Befreie sie und geleite sie hinaus.",
	-- {npc:222478} Sentinel Keldara Sunblade
	["{npc:222478}, in the camp"] = "{npc:222478}, im Lager",
	["Help her escape the camp"] = "Hilf ihr, aus dem Lager zu fliehen",

	-- Step 6: The western shore
	["The western shore"] = "Die Westküste",
	-- plural, as words: Spitelash Warriors = {npc:6190} Spitelash Warrior
	["The Spitelash Warriors (46-47) and Screamers (47-48) hold the western shore north-east of the satyrs."] = "Die Krieger der Grollflossen (46-47) und Kreischer (47-48) halten die Westküste nordöstlich der Satyrn.",

	-- Step 7: Talrendis Point
	-- {area:3137} Talrendis Point
	["Back south-west to {area:3137}."] = "Zurück nach Südwesten zur {area:3137}.",
	-- {npc:239822} Commander Truesong · {quest:88809} Preserving Eldarath
	["{npc:239822}: {quest:88809}, the relics drop from the naga of the top-up ahead"] = "{npc:239822}: {quest:88809}, die Relikte lassen die Naga fallen, an denen du gleich auflevelst",
	-- {npc:239822} Commander Truesong · {quest:92345} Beneath Nordrassil · {npc:4217} Mathrengyl Bearwalker · {zone:1457} Darnassus
	["{npc:239822}: {quest:92345}, for {npc:4217} in {zone:1457}, keep it"] = "{npc:239822}: {quest:92345}, für {npc:4217} in {zone:1457}, behalte sie",

	-- Step 10: Ogtinc
	-- {npc:8405} Ogtinc · {area:1224} Bear's Head
	["Ride north-east from the shrine: {npc:8405} camps at the {area:1224}, in the hills above the road."] = "Reite vom Schrein nach Nordosten: {npc:8405} lagert beim {area:1224}, in den Hügeln über der Straße.",

	-- Step 11: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo · {npc:8379} Archmage Xylem
	["Get off your mount before you talk to {npc:8395}: he teleports you up to {npc:8379}'s tower on the cliff above his camp."] = "Steig von deinem Reittier ab, bevor du mit {npc:8395} sprichst: Er teleportiert dich hinauf zum Turm von {npc:8379} auf der Klippe über seinem Lager.",

	-- Step 12: Archmage Xylem
	["The apprentice at the top of the tower sends you back down."] = "Der Lehrling oben im Turm schickt dich wieder nach unten.",
	-- {area:1220} Thalassian Base Camp · {npc:8420} Kim'jael
	["The blood elves are at the {area:1220}, on the way to {npc:8420}"] = "Die Blutelfen sind im {area:1220}, auf dem Weg zu {npc:8420}",

	-- Step 13: The Ruins of Eldarath
	-- {area:1221} Ruins of Eldarath
	["The {area:1221}"] = "{area:1221}",
	-- {area:1221} Ruins of Eldarath · {item:13815} Some Rune · {npc:8507} Tymor · {item:10445} Drawing Kit
	["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s runes stand among the ruins: use his {item:10445} on each. The naga here are the ones the top-up below asks for, so these kills count towards it."] = "Die Naga der Grollflossen in {area:1221} tragen {item:13815}. Die Runen von {npc:8507} stehen zwischen den Ruinen: Benutze sein {item:10445} an jeder. Die Naga hier sind genau die, die das Grinden unten verlangt, diese Kills zählen also dafür mit.",

	-- Step 14: Level 51.3 on the way north
	["Level 51.3 on the way north"] = "Stufe 51.3 auf dem Weg nach Norden",
	-- {npc:8395} Sanath Lim-yo · {npc:8420} Kim'jael · {area:1417} Sunken Temple
	-- plural, as words: Spitelash Myrmidons = {npc:6196} Spitelash Myrmidon
	["Top up to level 51.3 on the Spitelash Myrmidons (50-51) of the ruins between {npc:8395}'s camp and the north: the blood elves at {npc:8420}'s camp are 51-53. Or, with a group, run the {area:1417} dungeon instead."] = "Grinde auf Stufe 51.3 an den Myrmidonen der Grollflossen (50-51) in den Ruinen zwischen dem Lager von {npc:8395} und dem Norden: Die Blutelfen im Lager von {npc:8420} sind 51-53. Oder lauf mit einer Gruppe stattdessen den Dungeon {area:1417}.",
	-- {npc:6196} Spitelash Myrmidon
	["grind on {npc:6196}"] = "Grinde an {npc:6196}",

	-- Step 15: Lord Sarthiss
	-- {npc:239939} Lord Sarthiss
	-- plural, as words: Eldarath Relics = {item:280608} Eldarath Relic
	["The Spitelash naga of these ruins drop Truesong's Eldarath Relics, top-up or not. {npc:239939} (52) stands in the ruins of Eldarath, south-west of the Myrmidons: pull him alone."] = "Die Naga der Grollflossen in diesen Ruinen lassen Relikte von Eldarath fallen, ob du grindest oder nicht. {npc:239939} (52) steht in den Ruinen von Eldarath, südwestlich der Myrmidonen: Zieh ihn allein.",

	-- Step 16: Ekkal
	-- {npc:235903} Ekkal · {npc:8420} Kim'jael
	["{npc:235903} camps by the road north to {npc:8420}: his satyrs are in {npc:8420}'s camp."] = "{npc:235903} lagert an der Straße nach Norden zu {npc:8420}: Seine Satyrn sind im Lager von {npc:8420}.",

	-- Step 17: Mosshoof Coursers
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers"] = "Mooshufrenner",
	-- {area:1224} Bear's Head · {area:1219} Legashi Encampment
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south.\nCareful: the Mosshoof Coursers are 52-53, a level or two over you here: pull them one at a time from the herd's edge."] = "Die nächsten Mooshufrenner grasen in den Hügeln nordöstlich des {area:1224}, Richtung {area:1219}; eine größere Herde streift durch das offene Gelände im Süden.\nVorsicht: Die Mooshufrenner sind 52-53, hier ein oder zwei Stufen über dir: Zieh sie einzeln vom Rand der Herde.",

	-- Step 20: Kim'jael
	-- {npc:8420} Kim'jael · {area:1219} Legashi Encampment · {area:1220} Thalassian Base Camp · {npc:6647} Magister Hawkhelm · {npc:235903} Ekkal
	-- plural, as words: Blood Elf Surveyors = {npc:6198} Blood Elf Surveyor · Legashi Soulstealers = {npc:236867} Legashi Soulstealer
	["{npc:8420} camps at the {area:1219} in the north; his equipment lies all over the {area:1220} just south-east of him.\nCareful: the Blood Elf Surveyors are 51-52 and the Reclaimers 52-53, with {npc:6647} (53) among them: take the equipment from the camp's edge and pull the elves one at a time.\n{npc:235903}'s satyrs, rogues and hellcallers (51-53) are the Legashi around {npc:8420}'s camp; the Legashi Soulstealers, Hellraisers and Blackguards (53) further east are not part of it: stay west of them."] = "{npc:8420} lagert am {area:1219} im Norden; seine Ausrüstung liegt überall im {area:1220} gleich südöstlich von ihm.\nVorsicht: Die Blutelfenfeldmesser sind 51-52 und die Rückeroberer 52-53, mit {npc:6647} (53) unter ihnen: Nimm die Ausrüstung vom Rand des Lagers und zieh die Elfen einzeln.\nDie Satyrn, Schurken und Höllenrufer (51-53) für {npc:235903} sind die Legashi um das Lager von {npc:8420}; die Seelenräuber, Höllenschürer und Schwarzgardisten der Legashi (53) weiter östlich gehören nicht dazu: Bleib westlich von ihnen.",
	-- {item:20028} Glittering Dust
	["{item:20028}, from the blood elf surveyors and reclaimers"] = "{item:20028}, von den Blutelfen-Vermessern und -Rückgewinnern",

	-- Step 23: Ekkal
	-- {npc:235903} Ekkal
	["On the road back south, {npc:235903} takes the satyrs."] = "Auf der Straße zurück nach Süden nimmt {npc:235903} die Satyrn an.",

	-- Step 24: Rubbing: Rune of Sael'hai
	-- {item:7972} Ichor of Undeath · {npc:7864} Lingering Highborne
	["{item:7972}: the {npc:7864}, about 10%"] = "{item:7972}: der {npc:7864}, etwa 10%",

	-- Step 25: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo
	["Ride back west to {npc:8395}'s camp and get off your mount: he teleports you up to Xylem again."] = "Reite zurück nach Westen zum Lager von {npc:8395} und steig von deinem Reittier ab: Er teleportiert dich wieder zu Xylem hinauf.",

	-- Step 27: The Temple of Zin-Malor
	-- {area:1223} Temple of Zin-Malor
	["The {area:1223}"] = "{area:1223}",
	-- {area:1223} Temple of Zin-Malor · {npc:8395} Sanath Lim-yo
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren
	["The Spitelash Sirens wander the ruins and the beach around the {area:1223}, just south of {npc:8395}. Only the Sirens carry the coral, not the Screamers."] = "Die Spitelash Sirens streifen durch die Ruinen und über den Strand um {area:1223}, gleich südlich von {npc:8395}. Nur die Sirens tragen die Koralle, nicht die Screamers.",

	-- Step 28: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo
	["Back up through {npc:8395}'s teleport."] = "Wieder hinauf durch den Teleport von {npc:8395}.",
	-- {area:1417} Sunken Temple
	["Xylem's last task, Destroy Morphaz, is in the {area:1417}: skip it."] = "Xylems letzte Aufgabe, Destroy Morphaz, liegt im {area:1417}: Überspring sie.",

	-- Step 30: Ravencrest Monument
	-- {zone:1447} Azshara · {npc:8392} Pilot Xiggs Fuselighter · {item:10444} Standard Issue Flare Gun
	["Swim to the small island off the southern tip of {zone:1447}. If {npc:8392} isn't there, fire your {item:10444} to signal him, and wait for him to land."] = "Schwimm zur kleinen Insel vor der Südspitze von {zone:1447}. Ist {npc:8392} nicht da, feuere deine {item:10444} ab, um ihm ein Signal zu geben, und warte, bis er landet.",

	-- Step 31: Talrendis Point
	-- {area:3137} Talrendis Point
	["Back to Truesong at {area:3137} before you hearth."] = "Zurück zu Truesong in {area:3137}, bevor du den Ruhestein benutzt.",

	-- Step 32: To Ironforge
	-- {zone:1455} Ironforge
	["To {zone:1455}"] = "Zum {zone:1455}",
	-- {zone:1455} Ironforge · {zone:1425} Hinterlands
	["Your Hearthstone is set at {zone:1455} (the {zone:1425} guide binds it there): hearth back to the inn."] = "Dein Ruhestein ist auf {zone:1455} gesetzt (der Guide für {zone:1425} bindet ihn dort): Kehr mit ihm zum Gasthaus zurück.",
	-- {zone:1455} Ironforge
	["{zone:1455} inn"] = "Gasthaus von {zone:1455}",

	-- Step 34: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}."] = "Archesonus steht neben König Magni im {object:171709}.",

	-- Step 35: Royal Historian Archesonus
	-- {quest:3701} The Smoldering Ruins of Thaurissan · {npc:8978} Thauris Balgarr · {zone:1428} Burning Steppes
	-- plural, as words: War Reavers = {npc:7039} War Reaver
	["{quest:3701} is a group quest at this level: its relics stand among War Reavers and Firewalkers of 53-55, with {npc:8978} (57) close by, two to five over you, and the route has no later {zone:1428} visit. Grouping up is encouraged, look for people to do it with. Skip it if you are alone."] = "{quest:3701} ist auf dieser Stufe eine Gruppenquest: Ihre Relikte stehen zwischen Kriegshäschern und Feuerwandlern der Stufe 53-55, mit {npc:8978} (57) in der Nähe, zwei bis fünf Stufen über dir, und die Route kehrt nicht mehr in die {zone:1428} zurück. Gruppenspiel wird empfohlen, such dir Leute dafür. Überspring sie, wenn du allein bist.",
	-- {zone:1428} Burning Steppes
	["The relics are in the {zone:1428}: keep it"] = "Die Relikte sind in der {zone:1428}: Behalte es",

	-- Step 36: Fly to Aerie Peak
	-- {area:348} Aerie Peak
	["Fly to {area:348}"] = "Flieg nach {area:348}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Flugmeister von {zone:1455}",

	-- Step 37: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Flieg nach {area:271}",

	-- Step 38: The Super Snapper FX
	-- {npc:7977} Gammerita · {zone:1425} Hinterlands · {area:307} Overlook Cliffs
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:7977} (level 48 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back.\n{npc:7977} walks the {zone:1425} shore below the {area:307}, from the arrow south to about 75,66 and north to about 82,52: if she isn't at the arrow, follow the shore."] = "Das sind Elitegegner: Gruppenspiel wird empfohlen, such dir Leute dafür. {npc:7977} (Stufe 48, Elite) braucht eine Gruppe von 2. Überspring es, wenn du allein bist: Die Route lässt dich die EP wieder ergrinden.\n{npc:7977} wandert am Ufer des {zone:1425} unterhalb der {area:307} entlang, vom Pfeil nach Süden bis etwa 75,66 und nach Norden bis etwa 82,52: Ist sie nicht beim Pfeil, folge dem Ufer.",

	-- Step 39: Fly to Southshore
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "Flugmeister von {area:348}",

	-- Step 40: Orphan Matron Aria
	-- {area:271} Southshore · {area:279} Dalaran · {npc:34365} Orphan Matron Aria · {npc:266524} Lieutenant Connar · {area:1438} Nethergarde Keep
	["Ride north from {area:271} into Alterac and west to the walls of {area:279}: {npc:34365} stands outside them. Her quest goes to {npc:266524} in {area:1438}, where this guide flies later."] = "Reite von {area:271} nach Norden ins Alteracgebirge und nach Westen zu den Mauern von {area:279}: {npc:34365} steht davor. Ihre Quest geht an {npc:266524} in {area:1438}, wohin dieser Guide später fliegt.",

	-- Step 41: Western Plaguelands
	-- {area:271} Southshore · {area:3197} Chillwind Camp
	["Ride north from {area:271} up the road through Alterac to {area:3197}."] = "Reite von {area:271} nach Norden die Straße durch Alterac entlang bis {area:3197}.",

	-- Step 42: Chillwind Camp
	-- {npc:10838} Commander Ashlam Valorfist
	["{npc:10838} stands in the middle of the camp."] = "{npc:10838} steht mitten im Lager.",

	-- Step 43: Sorrow Hill: kill these as you meet them
	-- {area:197} Sorrow Hill
	["{area:197}: kill these as you meet them"] = "{area:197}: Töte sie, wenn du ihnen begegnest",
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "Skeletal Flayers und Slavering Ghouls streifen über die Felder nördlich des Lagers; alle Geißel-Mobs hier lassen Geißelsteine (Scourgestones) fallen.\nVorsicht: Diese Untoten bemerken dich schon von weitem, und weitere Untote in der Nähe schließen sich dem Kampf an, wenn einer gepullt wird.\nVorsicht: Das {npc:10411} (3 Spawns, 15 Min. Respawn) wird unsichtbar, wenn es nicht im Kampf ist, und ruft Rockwing Gargoyles, sobald ein Kampf beginnt.",

	-- Step 44: Chillwind Camp
	["Ride back south to the camp."] = "Reite zurück nach Süden zum Lager.",
	-- {area:199} Felstone Field · {zone:1452} Winterspring
	["keep it: the {area:199} cauldron waits for the {zone:1452} guide's Chillwind stop, at about 55"] = "Behalte sie: Der Kessel von {area:199} wartet auf den Halt im Lager Kühlwind im Guide für {zone:1452}, etwa auf Stufe 55",

	-- Step 45: Janice Felstone
	-- {npc:10778} Janice Felstone · {area:199} Felstone Field · {area:200} Dalson's Tears
	["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "{npc:10778}s Geist wandert beim Bauernhaus im {area:199} umher, westlich von {area:200}; ihr Paket liegt drinnen.",
	["Upstairs"] = "Oben",
	-- {object:175894} Janice's Parcel
	["{object:175894}, inside"] = "{object:175894}, drinnen",
	-- {zone:1453} Stormwind
	["For {zone:1453}: keep it"] = "Für {zone:1453}: Behalte es",

	-- Step 46: Fly to Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["Fly to {area:2418}"] = "Flieg nach {area:2418}",
	-- {area:3197} Chillwind Camp
	["{area:3197} flight master"] = "Flugmeister in {area:3197}",

	-- Step 47: Fly to Lakeshire
	-- {area:69} Lakeshire
	["Fly to {area:69}"] = "Flieg nach {area:69}",

	-- Step 48: Morgan's Vigil flight master
	-- {area:2418} Morgan's Vigil
	["{area:2418} flight master"] = "Flugmeister von {area:2418}",
	-- {area:69} Lakeshire · {zone:1428} Burning Steppes · {area:2418} Morgan's Vigil
	["Ride east out of {area:69} and up the pass into the {zone:1428}: {area:2418} stands at the top."] = "Reite nach Osten aus {area:69} hinaus und den Pass hinauf in die {zone:1428}: {area:2418} liegt oben.",

	-- Step 49: Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["{area:2418} sits in the south-east of the Steppes, at the top of the pass up from Redridge."] = "{area:2418} liegt im Südosten der Steppe, oben am Pass von Rotkammgebirge herauf.",

	-- Step 50: Level 52 at Dreadmaul Rock
	-- {area:249} Dreadmaul Rock
	["Level 52 at {area:249}"] = "Stufe 52 am {area:249}",
	-- {area:249} Dreadmaul Rock · {area:1417} Sunken Temple
	-- plural, as words: Firegut Ogres = {npc:7033} Firegut Ogre
	["Top up first to level 52 on the Firegut Ogres (50-51) on the near side of {area:249}, north of the Vigil: the Brutes on its east side are 52-53. Or, with a group, run the {area:1417} dungeon instead."] = "Grinde zuerst auf Stufe 52 an den Ogern der Feuermägen (50-51) auf der nahen Seite von {area:249}, nördlich der Wacht: Die Schläger auf der Ostseite sind 52-53. Oder lauf mit einer Gruppe stattdessen den Dungeon {area:1417}.",
	-- {npc:7033} Firegut Ogre
	["grind on {npc:7033}"] = "Grinde an {npc:7033}",

	-- Step 51: Dreadmaul Rock
	-- {area:249} Dreadmaul Rock
	-- plural, as words: Escaped Core Hounds = {npc:227746} Escaped Core Hound
	["The Firegut ogres hold the great rock north of the Vigil, with the Brutes on its east side.\nCareful: Escaped Core Hounds (level 60) roam the Steppes, a few on the slopes west and south of {area:249}: pull the ogres on the rock itself and look around before each pull."] = "Die Oger der Feuermägen halten den großen Felsen nördlich der Wacht, mit den Schlägern auf seiner Ostseite.\nVorsicht: Entkommene Kernhunde (Stufe 60) streifen durch die Steppe, ein paar an den Hängen westlich und südlich von {area:249}: Zieh die Oger auf dem Felsen selbst und sieh dich vor jedem Pull um.",
	-- {npc:7034} Firegut Ogre Mage
	["{npc:7034}, below ground"] = "{npc:7034}, unterirdisch",

	-- Step 52: Morgan's Vigil
	-- {npc:9177} Oralius · {npc:9176} Gor'tesh · {area:254} Blackrock Mountain
	-- plural, as words: Blackrock Medallions = {item:11467} Blackrock Medallion
	["{npc:9177}' next tasks ({npc:9176}, and fifty Blackrock Medallions) send you among the Blackrock orcs of 55-58 at the foot of {area:254}: skip them."] = "Die nächsten Aufgaben von {npc:9177} ({npc:9176} und fünfzig Medaillons der Blackrock) schicken dich zu den Orcs der Blackrock (55-58) am Fuß des {area:254}: Überspring sie.",

	-- Step 53: Flame Crest
	-- {area:251} Flame Crest
	["Follow the road west, then climb north to the goblin camp on {area:251}."] = "Folge der Straße nach Westen und klettere dann nach Norden zum Goblinlager am {area:251}.",

	-- Step 54: Ruins of Thaurissan: kill these as you meet them
	-- {area:250} Ruins of Thaurissan
	["{area:250}: kill these as you meet them"] = "{area:250}: Töte sie, wenn du ihnen begegnest",
	-- {item:12284} Draco-Incarcinatrix 900 · {npc:7047} Black Broodling · {area:251} Flame Crest · {npc:8981} Malfunctioning Reaver · {npc:7040} Black Dragonspawn
	["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves.\nCareful: a {npc:8981} (level 56, rare) walks the slopes by the broodlings, and the {npc:7040} and Wyrmkin around them are elite: use the Incarcinatrix on a broodling at the edge and look around before each pull."] = "Benutze {item:12284} an einem {npc:7047} an den Hängen östlich von {area:251}, kurz bevor er stirbt, und plündere dann die Essenz, die er hinterlässt.\nVorsicht: An den Hängen bei den Brutlingen läuft {npc:8981} (Stufe 56, Rare) umher, und {npc:7040} und die Wyrmkin um sie herum sind Elite: Benutze die Incarcinatrix an einem Brutling am Rand und sieh dich vor jedem Pull um.",

	-- Step 55: Ruins of Thaurissan
	-- {area:250} Ruins of Thaurissan · {area:251} Flame Crest · {npc:8978} Thauris Balgarr · {object:147516} Dark Iron
	-- plural, as words: War Reavers = {npc:7039} War Reaver · Thaurissan Firewalkers = {npc:7037} Thaurissan Firewalker
	["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered. Take the ones on the ruins' southern edge, nearest {area:251}.\nCareful: the ruins' War Reavers and Thaurissan Firewalkers are 53-55, and {npc:8978} (57) holds the {object:147516} camp south-west of {area:251}: take the relics at the edge of the ruins, pull one at a time, and keep away from the camp."] = "Die Relikte sind die geschnitzten Steine, die über {area:250} um {area:251} verstreut liegen: Klicke sie an, bis die Informationen wiederhergestellt sind. Nimm die am Südrand der Ruinen, am nächsten zu {area:251}.\nVorsicht: Die Kriegshäscher und Thaurissanischen Feuerwandler der Ruinen sind 53-55, und {npc:8978} (57) hält das Lager {object:147516} südwestlich von {area:251}: Nimm die Relikte am Rand der Ruinen, zieh die Gegner einzeln und halte dich vom Lager fern.",

	-- Step 56: Flame Crest
	-- {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Ends with {quest:4808} in {area:2255}, {zone:1452}: keep it"] = "Endet bei {quest:4808} in {area:2255}, {zone:1452}: Behalte es",

	-- Step 57: Cyrus Therepentous
	-- {item:10569} Hoard of the Black Dragonflight · {zone:1427} Searing Gorge · {item:10575} Black Dragonflight Molt · {npc:9459} Cyrus Therepentous
	["Open the {item:10569} from {zone:1427} for its {item:10575}, then tell {npc:9459} you bring proof of your deeds: no drake to fight."] = "Öffne den {item:10569} aus der {zone:1427}, um an seine {item:10575} zu kommen, und sag dann {npc:9459}, dass du einen Beweis deiner Taten bringst: Du musst keinen Drachen bekämpfen.",
	["Below ground"] = "Unter der Erde",
	-- {item:10575} Black Dragonflight Molt
	["{item:10575}, from the hoard"] = "{item:10575}, aus dem Hort",

	-- Step 59: A Taste of Flame
	-- {npc:9461} Frenzied Black Drake
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:9461} is a level 54 elite: most classes solo it at level 56, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "Das sind Elite-Mobs: Sich zusammenzutun wird empfohlen, such dir Leute dafür. {npc:9461} ist ein Elite der Stufe 54: Die meisten Klassen schaffen ihn auf Stufe 56 allein, aber vielleicht brauchst du Hilfe. Überspring ihn, wenn du allein bist: Die Route lässt dich die EP wieder hereingrinden.",

	-- Step 61: Level 52.08
	["Level 52.08"] = "Stufe 52,08",
	-- {quest:4022} A Taste of Flame · {area:1417} Sunken Temple
	["If you skipped {quest:4022}, grind here to level 52.08 to stay on the route's plan. Or, with a group, run the {area:1417} dungeon instead."] = "Wenn du {quest:4022} übersprungen hast, grinde hier bis Stufe 52,08, um im Plan der Route zu bleiben. Oder lauf mit einer Gruppe stattdessen den Dungeon {area:1417}.",
	-- {npc:9690} Ember Worg
	["grind on {npc:9690}"] = "Grinde an {npc:9690}",

	-- Step 62: Morgan's Vigil
	["Ride back east along the road to the Vigil."] = "Reite die Straße zurück nach Osten zur Wacht.",

	-- Step 63: Fly to Nethergarde Keep
	-- {area:1438} Nethergarde Keep
	["Fly to {area:1438}"] = "Flieg nach {area:1438}",

	-- Step 64: Ambassador Ardalan
	-- {area:1438} Nethergarde Keep
	["Ardalan is inside {area:1438}."] = "Ardalan ist in {area:1438}.",
	-- {npc:3546} Bernie Heisten · {quest:87295} Deflective Surface
	["{npc:3546}: {quest:87295}, the scales come from the basilisks ahead"] = "{npc:3546}: {quest:87295}, die Schuppen stammen von den Basilisken vor dir",

	-- Step 65: Swamp of Sorrows
	-- {zone:1419} Blasted Lands · {zone:1435} Swamp of Sorrows · {npc:10996} Fallen Hero · {area:75} Stonard
	["Ride north out of the {zone:1419} into the {zone:1435}: the {npc:10996} stands by the road from the {zone:1419}. Keep clear of {area:75}, the Horde town to the north-east."] = "Reite nach Norden aus den {zone:1419} hinaus in die {zone:1435}: Der {npc:10996} steht an der Straße, die aus den {zone:1419} kommt. Halte dich von {area:75} fern, der Stadt der Horde im Nordosten.",

	-- Step 66: Fallen Hero of the Horde
	["Listen to his tale, then ride back south to Kum'isha."] = "Hör dir seine Geschichte an und reite dann zurück nach Süden zu Kum'isha.",

	-- Step 67: Back to the Blasted Lands
	-- {zone:1419} Blasted Lands
	["Back to the {zone:1419}"] = "Zurück in die {zone:1419}",
	["Bloodmages' camp"] = "Lager der Blutmagier",

	-- Step 68: Blasted Lands: kill these as you meet them
	-- {zone:1419} Blasted Lands
	["{zone:1419}: kill these as you meet them"] = "{zone:1419}: Töte diese, sobald sie dir begegnen",
	-- {zone:1419} Blasted Lands · {npc:5982} Black Slayer · {npc:221740} Calefactus the Unleashed · {npc:247015} Vek'zol
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger · Ashmane Boars = {npc:5992} Ashmane Boar · Redstone Basilisks = {npc:5990} Redstone Basilisk
	["Ride back south into the {zone:1419} for the bloodmages' beasts: Starving Snickerfangs roam the dry hills south of the bloodmages' camp, Scorpok Stingers scuttle across the middle of the north and {npc:5982} vultures circle over all of it. Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep.\nCareful: two elites roam here: {npc:221740} (50) in the middle of the zone around 44,34, and {npc:247015} (55) on the ridge around 39,32. When you see one, hunt somewhere else."] = "Reite zurück nach Süden in die {zone:1419} für die Bestien der Blutmagier: Verhungernde Kicherfänge streifen durch die trockenen Hügel südlich des Lagers der Blutmagier, Skorpokstecher krabbeln durch die Mitte des Nordens, und {npc:5982}-Geier kreisen über allem. Aschmähneneber und Rotsteinbasilisken teilen sich die Hänge südwestlich der Festung.\nVorsicht: Zwei Elites streifen hier umher: {npc:221740} (50) in der Mitte des Gebiets um 44,34 und {npc:247015} (55) auf dem Grat um 39,32. Siehst du einen, jage woanders.",

	-- Step 70: Kum'isha the Collector
	-- {area:2517} Rise of the Defiler · {zone:1419} Blasted Lands · {npc:7664} Razelikh the Defiler · {spell:2691} Mana Burn · {spell:8255} Strong Cleave · {object:141891} Razelikh's Tear · {spell:10854} Flames of Chaos · {npc:247015} Vek'zol
	-- plural, as words: Imperfect Draenethyst Fragments = {item:10593} Imperfect Draenethyst Fragment
	["Kum'isha waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have. Come at her hill straight from the keep, along the road, and leave by the same way.\nCareful: Felcular, {npc:7664} and Ilifar are all level 60 elites. Razelikh casts {spell:2691}, {spell:8255} and Decimate, and as its health drops it adds {object:141891}, {spell:10854} and then Enrage at 15%.\nCareful: {npc:247015}, a level 55 elite, stands by Kum'isha's hill (about 50,35) and to the west (about 39,32), and the Dreadmaul and Shadowsworn camps around it are 53-55: take the fragments from the mobs on the way from the keep, not beside him."] = "Kum'isha wartet am {area:2517}, dem Hügel südwestlich der Festung. Die Mobs in den {zone:1419} auf dem Weg lassen die Unvollständigen Draenethystfragmente fallen; bring ihr, was du hast. Komm direkt von der Festung über die Straße zu ihrem Hügel und geh auf demselben Weg wieder.\nVorsicht: Felcular, {npc:7664} und Ilifar sind alle Elites der Stufe 60. Razelikh wirkt {spell:2691}, {spell:8255} und Dezimieren, und wenn seine Gesundheit sinkt, kommen {object:141891}, {spell:10854} und bei 15 % Wutanfall hinzu.\nVorsicht: {npc:247015}, ein Elite der Stufe 55, steht bei Kum'ishas Hügel (etwa 50,35) und im Westen (etwa 39,32), und die Lager der Dreadmaul und Shadowsworn ringsum sind 53-55: Hol dir die Fragmente von den Mobs auf dem Weg von der Festung, nicht neben ihm.",
	-- {npc:7363} Kum'isha the Collector
	["{npc:7363} walks around here: look inside the circle on the map"] = "{npc:7363} läuft hier umher: Schau in den Kreis auf der Karte",

	-- Step 71: The bloodmages
	["The bloodmages"] = "Die Blutmagier",
	-- {zone:1419} Blasted Lands
	["Ride north to the bloodmages' camp beside the road into the {zone:1419}."] = "Reite nach Norden zum Lager der Blutmagier neben der Straße in die {zone:1419}.",
	["The bloodmages' second tier pays for the same parts with a buff item and no experience: skip it."] = "Die zweite Stufe der Blutmagier bezahlt dieselben Teile mit einem Buff-Gegenstand und ohne Erfahrung: Überspring sie.",

	-- Step 72: Bernie Heisten
	-- {npc:3546} Bernie Heisten · {area:1438} Nethergarde Keep
	["Back to {npc:3546} in {area:1438} before you hearth."] = "Zurück zu {npc:3546} in {area:1438}, bevor du den Ruhestein benutzt.",

	-- Step 73: To Ironforge
	-- {zone:1455} Ironforge
	["Hearth back to {zone:1455}'s inn."] = "Ruhestein zurück zum Gasthaus von {zone:1455}.",

	-- Step 74: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "Flieg nach {area:144}",

	-- Step 77: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Flieg nach {area:1537}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "Flugmeister in {area:144}",

	-- Step 80: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}: the relics you read in the Steppes are his."] = "Archesonus steht neben König Magni im {object:171709}: Die Relikte, die du in der Steppe gelesen hast, gehören ihm.",

	-- Step 81: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Flieg nach {area:150}",

	-- Step 83: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "Flieg nach {area:702}",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "Flugmeister von {area:442}",

	-- Step 84: Rut'theran Village
	-- {zone:1452} Winterspring
	["The wildkin are in {zone:1452}: keep it"] = "Die Wildekin sind in {zone:1452}: Behalte es",

	-- Step 87: Darnassus
	-- {area:702} Rut'theran Village · {zone:1457} Darnassus · {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["The portal in {area:702} leads up to {zone:1457}: {npc:9047} waits in the {area:1658}, in the north of the city."] = "Das Portal in {area:702} führt hinauf nach {zone:1457}: {npc:9047} wartet im {area:1658}, im Norden der Stadt.",
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["{npc:9047}, in the {area:1658}"] = "{npc:9047}, im {area:1658}",
	-- {zone:1455} Ironforge
	["{zone:1455} has no druid trainer"] = "{zone:1455} hat keinen Druidenlehrer",

	-- Step 88: Mathrengyl Bearwalker
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217} is upstairs in the druids' building of the {area:1658}: go in by its south door."] = "{npc:4217} ist oben im Gebäude der Druiden in der {area:1658}: Geh durch die Südtür hinein.",
	-- {npc:4217} Mathrengyl Bearwalker
	["{npc:4217}, upstairs"] = "{npc:4217}, oben",

	-- Step 89: Gracina Spiritmight
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740} stands beside Tyrande in the Temple of the Moon, in the south of the city."] = "{npc:7740} steht neben Tyrande im Tempel des Mondes, im Süden der Stadt.",
	-- {npc:7740} Gracina Spiritmight · {quest:162} Rise of the Silithid · {area:976} Gadgetzan
	["{npc:7740}: {quest:162}, from {area:976}"] = "{npc:7740}: {quest:162}, aus {area:976}",
	-- {npc:5594} Alchemist Pestlezugg · {area:976} Gadgetzan · {zone:1422} Western Plaguelands
	["For {npc:5594} in {area:976}, on the {zone:1422} guide: keep it"] = "Für {npc:5594} in {area:976}, im Guide für {zone:1422}: Behalte es",

	-- Step 90: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "Portal nach {zone:1438}",

	-- Step 91: Daryn Lightwind
	-- {npc:7907} Daryn Lightwind · {npc:7916} Erelas Ambersky
	["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "{npc:7907} steht oben, über {npc:7916}: Geh drinnen nach oben, der Pfeil kann die Stockwerke nicht unterscheiden.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Class trainer"] = "Klassenlehrer",
	-- ["Climb back to {npc:8405} at the {area:1224}, above the ruins."] = "Klettere zurück zu {npc:8405} beim {area:1224}, oberhalb der Ruinen.",
	-- ["Climb to the top of {area:249} and plant the head in the soft dirt mound."] = "Klettere auf den {area:249} und pflanze den Kopf in den Haufen weicher Erde.",
	-- ["Druid training"] = "Druidentraining",
	-- ["Fly from {zone:1455} to {area:150} and take the boat to {area:442}."] = "Flieg von {zone:1455} nach {area:150} und nimm das Boot nach {area:442}.",
	-- ["Fly from {zone:1455} to {area:69}."] = "Flieg von {zone:1455} nach {area:69}.",
	-- ["Fly to {area:1438}."] = "Flieg nach {area:1438}.",
	-- ["Fly to {area:150} and take the boat to {area:442}, then the boat on to {area:702}."] = "Flieg nach {area:150} und nimm das Boot nach {area:442}, dann das Boot weiter nach {area:702}.",
	-- ["From the {area:442} dock, fly to {area:415}."] = "Flieg vom Steg in {area:442} nach {area:415}.",
	-- ["Kum'isha waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have.\nCareful: Felcular, {npc:7664} and Ilifar are all level 60 elites. Razelikh casts {spell:2691}, {spell:8255} and Decimate, and as its health drops it adds {object:141891}, {spell:10854} and then Enrage at 15%.\nCareful: {npc:247015}, a level 55 elite, stands by Kum'isha's hill (about 50,35) and to the west (about 39,32): take the fragments from the mobs on the way from the keep, not beside him."] = "Kum'isha wartet am {area:2517}, dem Hügel südwestlich der Festung. Die Mobs in {zone:1419} auf dem Weg lassen die Imperfect Draenethyst Fragments fallen; bring ihr, was du hast.\nVorsicht: Felcular, {npc:7664} und Ilifar sind alle Elites der Stufe 60. Razelikh wirkt {spell:2691}, {spell:8255} und Decimate, und wenn seine Gesundheit sinkt, kommen {object:141891}, {spell:10854} und bei 15 % Wutanfall hinzu.\nVorsicht: {npc:247015}, ein Elite der Stufe 55, steht bei Kum'ishas Hügel (etwa 50,35) und im Westen (etwa 39,32): Hol dir die Fragmente von den Mobs auf dem Weg von der Festung, nicht neben ihm.",
	-- ["Level 52"] = "Stufe 52",
	-- ["Optional: {npc:8395} wants two Undamaged Hippogryph Feathers from the hippogryphs around his camp. The data lists no experience for it."] = "Optional: {npc:8395} will zwei Unbeschädigte Hippogryphenfedern von den Hippogryphen um sein Lager. Die Daten nennen dafür keine Erfahrung.",
	-- ["Optional: {npc:8888}'s ghost stands on his tomb on the great chain inside {area:254}, and only the dead can see him. If you die near the mountain anyway, run your spirit to him before resurrecting."] = "Optional: {npc:8888}s Geist steht auf seinem Grab an der großen Kette im {area:254}, und nur Tote können ihn sehen. Stirbst du ohnehin nahe dem Berg, lauf als Geist zu ihm, bevor du wiederbelebt wirst.",
	-- ["Priests and Mages trained here at the end of the Un'Goro guide"] = "Priester und Magier haben hier schon am Ende des Un'Goro-Guides trainiert",
	-- ["Read the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript."] = "Lies die Tafel im Lager von {object:147516} zwischen den Ruinen südwestlich des {area:251}, um die Abschrift anzufertigen.",
	-- ["Ride back to {area:1438} and fly to {area:348}. The Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "Reite zurück nach {area:1438} und flieg nach {area:348}. Die Wildekinfedern liegen überall im {zone:1425} auf dem Boden, südlich und östlich von {area:348}, wo die Eulenbestien umherstreifen; die Gegner hier sind jetzt weit unter dir.",
	-- ["Ride east along the road out of {zone:1440} into {zone:1447} to the Sentinels' camp at {area:3137}."] = "Reite die Straße nach Osten aus {zone:1440} hinaus nach {zone:1447} zum Lager der Schildwachen bei {area:3137}.",
	-- ["Ride north out of the {zone:1419} into the {zone:1435}: the {npc:10996} stands by the road from the {zone:1419}. Keep clear of {area:75}, the Horde town to the north-east. Listen to his tale, then ride back south to Kum'isha."] = "Reite nach Norden aus den {zone:1419} hinaus in die {zone:1435}: Der {npc:10996} steht an der Straße, die aus den {zone:1419} kommt. Halte dich von {area:75} fern, der Stadt der Horde im Nordosten. Hör dir seine Geschichte an und reite dann zurück nach Süden zu Kum'isha.",
	-- ["Ride north out of {area:69} through the pass into the {zone:1428}; {area:2418} sits at the top, in the south-east of the Steppes."] = "Reite nach Norden aus {area:69} durch den Pass in die {zone:1428}; {area:2418} liegt oben, im Südosten der Steppe.",
	-- ["Swim to the small island off the southern tip of {area:16}: {npc:8392} waits by the monument."] = "Schwimm zur kleinen Insel vor der Südspitze von {area:16}: {npc:8392} wartet beim Denkmal.",
	-- ["Swim to the small island off the southern tip of {zone:1447}: {npc:8392} waits by the monument."] = "Schwimm zur kleinen Insel vor der Südspitze von {zone:1447}: {npc:8392} wartet beim Denkmal.",
	-- ["Thaurissan Relics"] = "Thauris-Relikte",
	-- ["The Highborne ghosts haunt the ruins around the shrine; the Haldarr satyrs hold the camp just north of it."] = "Die Geister der Hochgeborenen spuken in den Ruinen um den Schrein; die Satyrn der Haldarr halten das Lager gleich nördlich davon.",
	-- ["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s four runes stand among the ruins: use his {item:10445} on each."] = "Die Naga der Grollflossen in {area:1221} tragen {item:13815}. Die vier Runen von {npc:8507} stehen zwischen den Ruinen: Benutze sein {item:10445} an jeder.",
	-- ["The Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "Die Wildkin Feathers liegen im {zone:1425} auf dem Boden, südlich und östlich von {area:348}, wo die Eulenbestien umherziehen; die Mobs hier sind jetzt weit unter deiner Stufe.",
	-- ["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south."] = "Die nächsten Mooshufrenner grasen in den Hügeln nordöstlich des {area:1224}, Richtung {area:1219}; eine größere Herde streift durch das offene Gelände im Süden.",
	-- ["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered."] = "Die Relikte sind die behauenen Steine, verstreut in den {area:250} um den {area:251}: Klick sie an, bis die Informationen geborgen sind.",
	-- ["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered.\nRead the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript.\nUse the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves.\nCareful: a {npc:8981} (level 56, rare) walks the slopes by the broodlings, and the {npc:7040} and Wyrmkin around them are elite: use the Incarcinatrix on a broodling at the edge and look around before each pull."] = "Die Relikte sind die geschnitzten Steine, die über {area:250} um {area:251} verstreut liegen: Klicke sie an, bis die Informationen wiederhergestellt sind.\nLies die Tafel im Lager {object:147516} inmitten der Ruinen, südwestlich von {area:251}, um das Protokoll zu kopieren.\nBenutze {item:12284} an einem {npc:7047} an den Hängen östlich von {area:251}, kurz bevor er stirbt, und plündere dann die Essenz, die er hinterlässt.\nVorsicht: An den Hängen bei den Brutlingen läuft {npc:8981} (Stufe 56, Rare) umher, und {npc:7040} und die Wyrmkin um sie herum sind Elite: Benutze die Incarcinatrix an einem Brutling am Rand und sieh dich vor jedem Pull um.",
	-- ["The shrine lies in the south-west corner of {area:16}, south of {area:3137}."] = "Der Schrein liegt in der Südwestecke von {area:16}, südlich von {area:3137}.",
	-- ["The {quest:4296}"] = "{quest:4296}",
	-- ["Top up here to level 52 on the ogres of {area:249}, on the way to {area:251}: the hand-ins there take you to level 53. Or, with a group, run the {area:1417} dungeon instead."] = "Grinde hier auf Stufe 52 an den Ogern von {area:249}, auf dem Weg nach {area:251}: Die Abgaben dort bringen dich auf Stufe 53. Oder lauf mit einer Gruppe stattdessen den Dungeon {area:1417}.",
	-- ["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves."] = "Benutze die {item:12284} an einem {npc:7047} an den Hängen östlich des {area:251} kurz vor seinem Tod und plündere dann die Essenz, die er hinterlässt.",
	-- ["Wildkin feathers"] = "Wildekinfedern",
	-- ["grind on {npc:6375}"] = "Grinde an {npc:6375}",
	-- ["grind on {npc:7033}: {npc:9177} gives {quest:4283} from level 51"] = "Grinde an {npc:7033}: {npc:9177} gibt dir {quest:4283} ab Stufe 51",
	-- ["grind on {npc:7034}"] = "Grinde an {npc:7034}",
	-- ["{area:199} cauldron"] = "Kessel im {area:199}",
	-- ["{item:11467}; inside"] = "{item:11467}; drinnen",
	-- ["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075} bewacht den Kessel im {area:199}, westlich von Andorhal.",
	-- ["{npc:5111}: the last guide binds here, so this usually ticks at once"] = "{npc:5111}: Der letzte Guide bindet dich hier, daher ist das meist sofort abgehakt",
	-- ["{npc:7363} waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have."] = "{npc:7363} wartet beim {area:2517}, dem Hügel südwestlich der Burg. Die Gegner der {zone:1419} unterwegs lassen die Unvollständigen Draenethystfragmente fallen; bring ihr, was du hast.",
	-- ["{npc:8395} wants two Undamaged Hippogryph Feathers from the Thunderhead hippogryphs around his camp, the ones you top up on here: about one in three carries one."] = "{npc:8395} will zwei Unbeschädigte Hippogryphenfedern von den Donnerkopfhippogryphen um sein Lager, an denen du hier auch Erfahrung sammelst: Etwa jeder dritte trägt eine.",
	-- ["{npc:8420} camps at the {area:1219} in the north; his equipment lies all over the {area:1220} just south-east of him."] = "{npc:8420} lagert bei {area:1219} im Norden; seine Ausrüstung liegt überall in {area:1220} gleich südöstlich von ihm verstreut.",
	-- ["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty."] = "{npc:9176} und die Orcs der Blackrock halten die Lager und die Festung am Fuß des {area:254}, westlich des {area:251}. Zieh sie einzeln; jeder Orc und Worg kann ein Medaillon fallen lassen, töte sie also, bis du fünfzig hast.",
	-- ["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty.\nCareful: {npc:9176} has a guard linked to him that joins the fight, and a second soldier patrols close by; clear the patrol before pulling.\nCareful: Firesworn, level 60 fire elementals, wander the Steppes, some between the Blackrock camps: look before each pull and let them pass."] = "{npc:9176} und die Orcs des Schwarzfels halten die Lager und die Festung am Fuß von {area:254}, westlich von {area:251}. Zieh sie einzeln heran; jeder Orc und Worg kann ein Medaillon fallen lassen, also töte sie, bis du fünfzig hast.\nVorsicht: {npc:9176} hat eine Wache bei sich, die sich dem Kampf anschließt, und ein zweiter Soldat patrouilliert in der Nähe; räume die Patrouille, bevor du pullst.\nVorsicht: Feuergeschworene, Feuerelementare der Stufe 60, wandern durch die Steppe, manche zwischen den Lagern des Schwarzfels: Sieh dich vor jedem Pull um und lass sie vorbeiziehen.",
	-- ["{npc:9177}: the Blackrock orcs drop the medallions, keep it open all through the Steppes"] = "{npc:9177}: Die Orcs der Blackrock lassen die Medaillons fallen, lass sie die ganze Steppe über offen",
	-- ["{zone:1455} has no druid trainer: take the portal up to {zone:1457} and train in the {area:1658}, then come back down to {area:702}."] = "{zone:1455} hat keinen Druidenlehrer: Nimm das Portal hinauf nach {zone:1457} und trainiere im {area:1658}, dann komm zurück hinab nach {area:702}.",
}
