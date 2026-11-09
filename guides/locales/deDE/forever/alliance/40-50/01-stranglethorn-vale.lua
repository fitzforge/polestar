-- German (deDE): the guide forever/alliance/40-50/01-stranglethorn-vale (forever/alliance/40-50/01-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Theramore
	["Theramore"] = "Theramore",
	-- {quest:1260} Morgan Stern · {npc:4897} Helenia Olden
	["{quest:1260} stands near the inn; {npc:4897}, a trade supplier a few steps south, sells the spices Jarl wants."] = "{quest:1260} steht nahe dem Gasthaus; {npc:4897}, ein Handwerkswarenhändler ein paar Schritte südlich, verkauft die Gewürze, die Jarl will.",
	-- {quest:1260} Morgan Stern
	["{quest:1260}, inside"] = "",
	-- {npc:4964} Commander Samaul · {area:514} Foothold Citadel
	["{npc:4964}, on the top floor of {area:514}"] = "",
	-- {item:3713} Soothing Spices
	["{item:3713}, for \"Swamp Eye\" Jarl"] = "{item:3713}, für Sumpfauge Jarl",

	-- Step 2: Sentry Point
	-- {area:503} Sentry Point
	-- plural, as words: Mudrock Burrowers = {npc:4398} Mudrock Burrower
	["Follow the road north-west out of Theramore to the watchtower at {area:503}. Mudrock Burrowers roam the marsh around it."] = "Folge der Straße nach Nordwesten aus Theramore hinaus zum Wachturm bei {area:503}. Schlammpanzereinbuddler streifen durch den Sumpf darum herum.",

	-- Step 3: Archmage Tervosh
	-- {area:514} Foothold Citadel
	["Back in Theramore: Tervosh waits with Lady Jaina in the tower of {area:514}."] = "Zurück in Theramore: Tervosh wartet mit Lady Jaina im Turm von {area:514}.",
	["Upstairs"] = "",

	-- Step 4: Theramore
	-- {npc:4794} Morgan Stern
	["{npc:4794}, inside"] = "",
	-- {npc:4794} Morgan Stern · {zone:1435} Swamp of Sorrows
	["{npc:4794}: the crawlers are on the {zone:1435} shore, keep it"] = "",

	-- Step 5: Swamplight Manor
	-- {quest:1218} Soothing Spices · {npc:4897} Helenia Olden
	["Take the road north to the ruined manor; Jarl lives in the shack beside it and the loose dirt is at the corner of the house. Jarl wants three {quest:1218}: if you passed {npc:4897}, buy them from her in Theramore first."] = "",
	["with the spices from Theramore"] = "mit den Gewürzen aus Theramore",

	-- Step 6: "Stinky" Ignatz
	["\"Stinky\" Ignatz"] = "Stinki Ignatz",
	-- {area:504} North Point Tower
	["Stinky waits west of the manor, in the marsh below {area:504}. Lead him to his Bogbean leaves and keep the swamp creatures off him."] = "Stinki wartet westlich des Anwesens, im Sumpf unterhalb von {area:504}. Führ ihn zu seinen Sumpfbohnenblättern und halte die Sumpfkreaturen von ihm fern.",

	-- Step 7: North Point Tower
	-- {npc:4966} Private Hendel
	["{npc:4966} holds the tower with a few deserters. He turns on you: beat him until he yields.\nCareful: Hendel has two guards who join the fight when he turns hostile. The guards flee once he surrenders."] = "",

	-- Step 8: Darkmist Cavern
	-- plural, as words: Darkmist Lurkers = {npc:4377} Darkmist Lurker
	["The Darkmist spiders nest around the cavern in the north-west of the marsh; every spider drops eyes.\nCareful: Darkmist Lurkers move about stealthed and use poison once in combat. The spiders stand close together, so adds are common; pulling single targets from the outer edge cuts down on them."] = "",

	-- Step 9: Mudcrush Durtfeet
	["Ride south to the giant's hut in the middle of the marsh."] = "Reite nach Süden zur Hütte des Riesen mitten im Sumpf.",

	-- Step 10: The Shady Rest Inn
	-- {area:17} Barrens
	["The burned inn stands on the road west, toward the {area:17}; the guard's badge lies in the ashes."] = "",

	-- Step 11: Theramore
	-- {area:514} Foothold Citadel
	["Follow the road east back to Theramore. Tervosh, Lady Jaina and the officers are in the tower and {area:514}."] = "Folge der Straße nach Osten zurück nach Theramore. Tervosh, Lady Jaina und die Offiziere sind im Turm und in {area:514}.",
	-- {npc:4967} Archmage Tervosh
	["{npc:4967}, upstairs"] = "",
	-- {npc:4968} Lady Jaina Proudmoore
	["{npc:4968}, on the top floor"] = "",
	["On the top floor"] = "",
	-- {npc:4948} Adjutant Tesoran
	["{npc:4948}, on the top floor"] = "",

	-- Step 12: Mirefin murlocs
	["Mirefin murlocs"] = "Murlocs der Schlammflossen",
	-- {area:497} Swamplight Manor
	["The Mirefin murlocs crowd the north coast past {area:497}; finish the tongues on the tortoises beside them."] = "Die Murlocs der Schlammflossen drängen sich an der Nordküste hinter {area:497}; sammle die restlichen Zungen bei den Schildkröten daneben.",

	-- Step 13: Swamplight Manor
	-- {item:3853} Moonsteel Broadsword
	["only if you carry a {item:3853} (a blacksmith's craft)"] = "nur wenn du einen {item:3853} dabeihast (von Schmieden hergestellt)",

	-- Step 15: Balos Jacken
	-- {npc:4503} Mudcrush Durtfeet
	["The deserters camp south of the road, west of {npc:4503}'s hut."] = "Die Deserteure lagern südlich der Straße, westlich von {npc:4503}s Hütte.",

	-- Step 17: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {area:391} Merchant Coast · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["On the ride north to {area:392}, {area:720} lies off the {area:391} south of the town: wade over the sand bar shallows. {npc:6236} sends four challengers and then {npc:6238} (level 33) at you, one at a time."] = "Auf dem Ritt nach Norden nach {area:392} liegt {area:720} vor der {area:391} südlich des Orts: Wate über die Untiefen der Sandbank. {npc:6236} schickt dir nacheinander vier Herausforderer und dann {npc:6238} (Stufe 33) entgegen.",
	-- {npc:6238} Big Will
	["Defeat the challengers and {npc:6238}"] = "Besiege die Herausforderer und {npc:6238}",
	-- {npc:6236} Klannoc Macleod
	["{npc:6236} offers The Windwatcher next (1791): the Whirlwind weapon chain, with an elite at the end, is in the Warrior class guide Whirlwind Weapon."] = "{npc:6236} bietet als Nächstes Der Windbehüter (1791) an: Die Questreihe um die Waffe für Wirbelwind, mit einem Elite am Ende, steht im Kriegerklassen-Guide „Wirbelwaffe“.",

	-- Step 18: Foothold Citadel
	-- {npc:4944} Captain Garran Vimes · {area:514} Foothold Citadel
	["The boat leaves from Theramore: report to {npc:4944} on the top floor of {area:514} on the way to the docks."] = "",
	-- {npc:4944} Captain Garran Vimes
	["{npc:4944}, on the top floor"] = "",

	-- Step 19: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Schiff nach {area:150}",

	-- Step 20: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Flieg nach {zone:1453}",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "",

	-- Step 22: Riding at 40
	["Riding at 40"] = "Reiten mit 40",
	-- {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {npc:384} Katie Hunter
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4732} teaches Humans at {area:88} in eastern {zone:1429}, beside {npc:384}'s horses. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "Mit 40 und 100 Gold kannst du reiten lernen, und dabei erhältst du ein Reittier. {npc:4732} lehrt Menschen in {area:88} im östlichen {zone:1429}, neben den Pferden von {npc:384}. In Forever kann womöglich jedes Volk bei jedem Reitlehrer lernen (unbestätigt). Sammelobjekte, Reittiere · Stufe 40 listet alle Farben.",
	-- {npc:384} Katie Hunter
	["{npc:384}: other colours, 20g"] = "{npc:384}: andere Farben, 20g",

	-- Step 23: Riding at 40
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar · {area:279} Dalaran
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. Skyborne learn it from {npc:265756}, the stablemaster and riding trainer at the {area:17684} in {area:16638} on Zephras Isle, who also sells the Galestriders: the skyboat to the isle leaves the north side of {area:279} about every five minutes. Collectibles, Mounts · Level 40 lists the Galestriders."] = "",
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["Riding and Galestriders: {npc:265756}, at the {area:17684} in {area:16638} on Zephras Isle."] = "",
	-- {area:279} Dalaran
	["Skyboat to Zephras Isle: the north side of {area:279}, about every five minutes."] = "",

	-- Step 24: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Boot nach {area:35}",

	-- Step 45: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Flieg nach {area:35}",
	-- {area:42} Darkshire
	["{area:42} flight master"] = "",

	-- Step 46: Booty Bay
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "",
	-- {npc:770} Corporal Kaleb · {area:99} Rebel Camp
	["for {npc:770} at the {area:99}, on the northern loop"] = "für {npc:770} beim {area:99}, auf der nördlichen Runde",
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, top floor"] = "{npc:2487}, oberstes Stockwerk",
	-- {npc:737} Kebok
	["{npc:737}, upstairs: the Skullsplitter trolls, on the northern loop"] = "",
	["Inside"] = "",
	["Seahorn's next errand goes back to Arathi: skip it."] = "Seehorns nächster Auftrag führt zurück nach Arathi: Überspring ihn.",
	-- {npc:2542} Catelyn the Blade
	["{npc:2542}, upstairs"] = "",

	-- Step 47: Bloodsail camp
	["Bloodsail camp"] = "Lager der Blutsegelbukaniere",
	["Leave town by the tunnel and follow the coast north; the letter lies in the Bloodsail camp on the beach, where \"Pretty Boy\" Duncan walks."] = "Verlass den Ort durch den Tunnel und folge der Küste nach Norden; der Brief liegt im Lager der Blutsegelbukaniere am Strand, wo Schönling Duncan umhergeht.",

	-- Step 48: Booty Bay
	-- {npc:2488} Deeg
	["{npc:2488}, on the top floor"] = "",
	-- {npc:2624} Gazban
	["{npc:2624} swims off the north-west coast, on the northern loop"] = "{npc:2624} schwimmt vor der Nordwestküste, auf der nördlichen Runde",

	-- Step 49: Wild Shore: kill these as you meet them
	-- {area:43} Wild Shore
	["{area:43}: kill these as you meet them"] = "",
	-- {npc:2493} Dizzy One-Eye · {area:43} Wild Shore · {area:35} Booty Bay
	["Every Bloodsail drops Snuff and one of them carries {npc:2493}'s eye; the Swashbucklers walk the shore just north of town. The charts and orders lie in the pirate camp on the {area:43}, south of {area:35}."] = "Jeder Blutsegelbukanier lässt Schnupftabak fallen, und einer trägt {npc:2493}s Auge; die Schwadroneure gehen gleich nördlich des Orts am Ufer entlang. Die Karten und Befehle liegen im Piratenlager an der {area:43} südlich von {area:35}.",

	-- Step 50: Booty Bay
	-- {quest:604} The Bloodsail Buccaneers
	["Seahorn now offers {quest:604}: leave it. Its three captains are level 45-48 with crews around them, and the route brings you back to Seahorn at 48 for it."] = "",

	-- Step 51: Gorilla hills
	["Gorilla hills"] = "Gorillahügel",
	-- {npc:1449} Witch Doctor Unbagwa
	-- plural, as words: Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["Ride inland to the Mistvale gorilla hills. Elder Mistvale Gorillas drop the giblets; {npc:1449} sits among them."] = "Reite ins Landesinnere zu den Gorillahügeln im Nebeltal. Alte Nebeltalgorillas lassen die Innereien fallen; {npc:1449} sitzt zwischen ihnen.",
	-- {npc:1449} Witch Doctor Unbagwa · {area:1742} Spirit Den
	["{npc:1449}, inside {area:1742}"] = "",

	-- Step 52: Unbagwa's ritual
	["Unbagwa's ritual"] = "Unbagwas Ritual",
	-- {npc:1514} Mokk the Savage
	["Hand in the fangs and stay: three waves of gorillas come, {npc:1514} last. Fight at full health."] = "Gib die Fangzähne ab und bleib: Drei Wellen Gorillas kommen, {npc:1514} zuletzt. Kämpfe mit voller Gesundheit.",

	-- Step 53: Naga Explorers
	-- plural, as words: Naga Explorers = {npc:1907} Naga Explorer
	["Naga Explorers"] = "Forscher der Naga",
	["The naga comb the beaches north of the Bloodsail camp; they drop the reeds."] = "Die Naga durchkämmen die Strände nördlich des Lagers der Blutsegelbukaniere; sie lassen das Schilf fallen.",

	-- Step 54: Booty Bay
	["Ride back down to town; Shaky stands at the tunnel mouth."] = "Reite zurück hinab in den Ort; Zitterhand steht am Tunneleingang.",
	-- {npc:2616} Privateer Groy
	["for {npc:2616} in Theramore: keep it"] = "für {npc:2616} in Theramore: Behalte es",
	-- {zone:1446} Tanaris
	["for Stoley in {zone:1446}: keep it; on the top floor"] = "",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "",

	-- Step 55: The Bloodsail captains
	["The Bloodsail captains"] = "Die Kapitäne der Blutsegelbukaniere",
	-- {area:43} Wild Shore · {npc:2546} Fleet Master Firallon
	["The captains stand on the ships anchored off the {area:43}, each with a crew of 42-45 pirates: Stillwater (45) and Keelhaul (46) on the nearer decks, {npc:2546} (48) on the flagship. At 42 this is a fight for a group or for the end of the guide; clear each deck first if you go. Cortello's scroll lies on the wreck by the shore."] = "Die Kapitäne stehen auf den Schiffen vor der {area:43}, jeder mit einer Mannschaft aus Piraten der Stufe 42-45: Stillwasser (45) und Kielhol (46) auf den näheren Decks, {npc:2546} (48) auf dem Flaggschiff. Mit 42 ist das ein Kampf für eine Gruppe oder fürs Ende des Guides; säubere jedes Deck vorher, falls du gehst. Cortellos Schriftrolle liegt auf dem Wrack am Ufer.",
	-- {zone:1435} Swamp of Sorrows
	["for the {zone:1435} later"] = "für die {zone:1435} später",

	-- Step 56: Zanzil's village
	["Zanzil's village"] = "Zanzils Dorf",
	-- {npc:2537} Chucky "Ten Thumbs"
	["Every Zanzil follower can drop the mixture; {npc:2537} walks the south of the camp."] = "Jeder Anhänger von Zanzil kann die Mixtur fallen lassen; {npc:2537} geht im Süden des Lagers umher.",

	-- Step 57: Maury "Club Foot" Wilkins and Jon-Jon the Crow
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow
	["{npc:2535} and {npc:2536}"] = "{npc:2535} und {npc:2536}",
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow
	["Ride north to the hills west of the road. {npc:2535} and {npc:2536} stand together just north of Zanzil's village."] = "Reite nach Norden in die Hügel westlich der Straße. {npc:2535} und {npc:2536} stehen zusammen gleich nördlich von Zanzils Dorf.",

	-- Step 58: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "Dschungelpirscher",
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers roam the slopes west of the mine."] = "",

	-- Step 59: The north-west coast
	["The north-west coast"] = "Die Nordwestküste",
	-- {npc:2624} Gazban · {item:4034} Stone of the Tides
	-- plural, as words: Giant Clams = {object:2744} Giant Clam
	["Ride north-west from the mine to the bay on the north-west coast. The Giant Clams lie on its floor and hold the pearls; {npc:2624} swims among them and drops the {item:4034}."] = "Reite von der Mine nach Nordwesten zur Bucht an der Nordwestküste. Die Riesenmuscheln liegen auf ihrem Grund und enthalten die Perlen; {npc:2624} schwimmt zwischen ihnen und lässt {item:4034} fallen.",
	-- {item:4611} Blue Pearl
	["{item:4611}; underwater"] = "",

	-- Step 62: Arbor Tarantula
	-- {npc:217588} Arbor Tarantula · {area:99} Rebel Camp · {npc:217412} Amaryllis Webb
	["An {npc:217588} crawls in the jungle south-east of Nesingwary's camp, on the way to the {area:99}: catch one with the tool from {npc:217412}'s Entomology Starter Kit."] = "",

	-- Step 63: Rebel Camp
	["Ride north-east past Nesingwary's camp and follow the road north to the camp at the top of the vale."] = "",

	-- Step 65: Panther Mastery
	-- {npc:728} Bhag'thera
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:728} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 66: Level 42.16 at Zul'Mamwe
	["Level 42.16 at Zul'Mamwe"] = "",
	-- {npc:737} Kebok · {area:1517} Uldaman
	["Alone, you skip Nesingwary's three elite hunts: take their experience from the Skullsplitter trolls of Zul'Mamwe instead, just east of the mine, so every kill also counts for {npc:737}'s tusks. Or, with a group, run the {area:1517} dungeon instead."] = "",
	-- {npc:667} Skullsplitter Warrior
	["grind on {npc:667}"] = "",

	-- Step 67: Ruins of Zul'Mamwe: kill these as you meet them
	-- {area:103} Ruins of Zul'Mamwe
	["{area:103}: kill these as you meet them"] = "",
	-- {area:310} Crystalvein Mine
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Skullsplitter trolls hold the ruins just east of the mine; any of them can drop tusks, their panthers always do.\nFollow the road north-east to the Venture Co. camp at the {area:310}; the miners, surveyors and foremen drop the crystals.\nCareful: Stealthed Shadowmaw Panthers and Stranglethorn Tigresses roam the area around the camp."] = "",

	-- Step 68: Raptor Mastery
	-- {npc:730} Tethis
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:730} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 72: Big Game Hunter
	-- {npc:731} King Bangalash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:731} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Tigers and stealthed shadowmaw panthers roam close to him. Clear them before you pull him. When he is pulled, {npc:731} calls for help from creatures within 20 yd."] = "",

	-- Step 74: Level 42.16
	["Level 42.16"] = "",
	-- {area:310} Crystalvein Mine · {area:35} Booty Bay · {area:1517} Uldaman
	-- plural, as words: Cold Eye Basilisks = {npc:690} Cold Eye Basilisk
	["Still short of level 42.16 after the hunts you did? Make up the rest on the Cold Eye Basilisks by the {area:310}, on your way south to {area:35}. Or, with a group, run the {area:1517} dungeon instead."] = "",
	-- {npc:690} Cold Eye Basilisk
	["grind on {npc:690}"] = "",

	-- Step 75: Booty Bay
	-- {area:35} Booty Bay
	["Ride south down the road to {area:35}."] = "",
	-- {npc:2498} Crank Fizzlebub · {zone:1441} Thousand Needles
	["{npc:2498}'s next Zanzil errand starts in {zone:1441}: skip it."] = "{npc:2498}s nächster Zanzil-Auftrag beginnt in {zone:1441}: Überspring ihn.",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "",
	["MacKinley's next task sends you after elite ogres: skip it."] = "MacKinleys nächster Auftrag schickt dich zu Elite-Ogern: Überspring ihn.",
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {zone:1446} Tanaris
	["{npc:773}: for {quest:2864} in {zone:1446}, keep it"] = "{npc:773}: für {quest:2864} in {zone:1446}, behalte es",

	-- Step 76: Fly to Stormwind
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "",

	-- Step 77: Stormwind
	-- {npc:1141} Angus Stern · {object:2169} Blue Recluse · {npc:5384} Brohann Caskbelly · {object:28027} Dwarven District
	["{npc:1141} cooks in the {object:2169}; {npc:5384} is in the {object:28027}."] = "{npc:1141} kocht im {object:2169}; {npc:5384} ist im {object:28027}.",
	-- {npc:5694} High Sorcerer Andromath · {npc:5464} Watchmaster Sorigal · {area:42} Darkshire
	["{npc:5694}: for {npc:5464} in {area:42}, on the way to the swamp"] = "",

	-- Step 78: Stormwind
	-- {npc:1440} Milton Sheaf · {object:2117} Stormwind Keep
	["{npc:1440}, the Royal Library in {object:2117}"] = "{npc:1440}, Königliche Bibliothek in {object:2117}",

	-- Step 80: Paladin: The Tome of Nobility
	-- {quest:1661} The Tome of Nobility
	["Paladin: {quest:1661}"] = "Paladin: {quest:1661}",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}, in the Cathedral of Light"] = "{npc:6171}, in der Kathedrale des Lichts",

	-- Step 81: Stormwind City
	["Stormwind City"] = "",

	-- Step 82: Warlock: Summon Felsteed
	-- {quest:3631} Summon Felsteed
	["Warlock: {quest:3631}"] = "Hexenmeister: {quest:3631}",
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["{npc:461}, in the {object:2164}: {npc:6251} in {area:392} takes it at the end of the next guide"] = "{npc:461}, im {object:2164}: {npc:6251} in {area:392} nimmt es am Ende des nächsten Guides an",

	-- Step 84: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "",

	-- Step 87: Riding at 40
	-- {npc:4753} Jartsam · {zone:1457} Darnassus · {npc:4730} Lelanai · {area:17203} Stormwind Harbor · {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4753} teaches Night Elves in {zone:1457}, beside {npc:4730}'s sabers: the boat from {area:17203} to {area:442}, then the flight to {area:702}. Forever may let any race learn from any riding trainer (unconfirmed), such as {npc:4732} at {area:88} in {zone:1429}. Collectibles, Mounts · Level 40 lists every colour."] = "Mit 40 und 100 Gold kannst du reiten lernen, und dabei erhältst du ein Reittier. {npc:4753} lehrt Nachtelfen in {zone:1457}, neben den Säblern von {npc:4730}: das Boot vom {area:17203} nach {area:442}, dann der Flug nach {area:702}. In Forever kann womöglich jedes Volk bei jedem Reitlehrer lernen (unbestätigt), etwa bei {npc:4732} in {area:88} im {zone:1429}. Sammelobjekte, Reittiere · Stufe 40 listet alle Farben.",
	-- {npc:4730} Lelanai
	["{npc:4730}: other colours, 20g"] = "{npc:4730}: andere Farben, 20g",

	-- Step 89: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "",
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "",

	-- Step 90: Boat to Stormwind Harbor
	-- {area:17203} Stormwind Harbor
	["Boat to {area:17203}"] = "",

	-- Step 91: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "Flieg nach {area:42}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "",

	-- Step 92: Darkshire
	-- {npc:5464} Watchmaster Sorigal
	["{npc:5464}, by the flight master"] = "",

	-- Step 94: Misty Valley
	["The scroll lies in the marsh north of Biggs. The Swampwalkers north of it can drop Khadgar's essays."] = "Die Schriftrolle liegt im Sumpf nördlich von Biggs. Die Sumpfwandler nördlich davon können Khadgars Aufsätze fallen lassen.",

	-- Step 96: Level 42.46
	["Level 42.46"] = "",
	-- {quest:543} The Perenolde Tiara · {area:1517} Uldaman
	["If you skipped {quest:543}, grind here to level 42.46 to stay on the route's plan. Or, with a group, run the {area:1517} dungeon instead."] = "",
	-- {npc:766} Tangled Horror
	["grind on {npc:766}"] = "",

	-- Step 97: Cortello's Riddle
	-- {npc:217412} Amaryllis Webb · {quest:93176} My Little Friends
	["{npc:217412}: {quest:93176}, from 30-40/05-arathi-highlands"] = "{npc:217412}: {quest:93176}, aus 30-40/05-arathi-highlands",

	-- Step 98: Watcher Biggs
	-- {npc:5476} Watcher Biggs
	["{npc:5476} stands by the road junction in the west of the swamp."] = "",

	-- Step 99: The sunken temple
	["The sunken temple"] = "Der versunkene Tempel",
	-- {area:74} Pool of Tears
	-- plural, as words: Tangled Horrors = {npc:766} Tangled Horror
	["Ride east; the Tangled Horrors along the way also drop the essays. Search the edge of the {area:74}, where the temple's ruins break the water."] = "Reite nach Osten; die Wuchernden Schrecken unterwegs lassen auch die Aufsätze fallen. Durchsuche den Rand des {area:74}, wo die Ruinen des Tempels aus dem Wasser ragen.",

	-- Step 100: Misty Reed Strand
	["The driftwood washes up along the eastern shore."] = "Das Treibholz wird am Ostufer angeschwemmt.",
	-- {item:5938} Pristine Crawler Leg
	-- plural, as words: Silt Crawlers = {npc:922} Silt Crawler
	["{item:5938}, from the Silt Crawlers on the same shore"] = "",

	-- Step 101: Watcher Biggs
	-- {area:1438} Nethergarde Keep
	["for {area:1438}: keep it"] = "für {area:1438}: Behalte es",

	-- Step 104: Stormwind
	-- {npc:5635} Falstad Wildhammer · {area:348} Aerie Peak
	["for {npc:5635} at {area:348}: keep it"] = "für {npc:5635} in {area:348}: Behalte es",

	-- Step 105: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "",

	-- Step 108: Ironforge
	-- {npc:5637} Roetten Stonehammer · {object:32356} Hall of Explorers (no name in this language: may be words) · {npc:2786} Gerrig Bonegrip · {object:32383} Forlorn Cavern
	["{npc:5637} is in the Reclaimers' hall by the {object:32356}, {npc:2786} in the {object:32383}."] = "",
	-- {zone:1453} Stormwind
	["{zone:1453} has no shaman trainer"] = "{zone:1453} hat keinen Schamanenlehrer",

	-- Step 110: Riding at 40
	-- {npc:4772} Ultham Ironhorn · {area:803} Amberstill Ranch · {area:131} Kharanos · {zone:1432} Loch Modan · {npc:1261} Veron Amberstill
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4772} teaches Dwarves at {area:803}, east of {area:131} on the road to {zone:1432}, beside {npc:1261}'s rams. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "Mit 40 und 100 Gold kannst du reiten lernen, und dabei erhältst du ein Reittier. {npc:4772} lehrt Zwerge in {area:803}, östlich von {area:131} an der Straße nach {zone:1432}, neben den Widdern von {npc:1261}. In Forever kann womöglich jedes Volk bei jedem Reitlehrer lernen (unbestätigt). Sammelobjekte, Reittiere · Stufe 40 listet alle Farben.",
	-- {npc:1261} Veron Amberstill
	["{npc:1261}: other colours, 20g"] = "{npc:1261}: andere Farben, 20g",

	-- Step 112: Riding at 40
	-- {npc:7954} Binjy Featherwhistle · {area:189} Steelgrill's Depot · {area:131} Kharanos · {npc:7955} Milli Featherwhistle
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:7954} teaches Gnomes at {area:189}, just east of {area:131}, beside {npc:7955}'s mechanostriders. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "Mit 40 und 100 Gold kannst du reiten lernen, und dabei erhältst du ein Reittier. {npc:7954} lehrt Gnome in {area:189}, gleich östlich von {area:131}, neben den Roboschreitern von {npc:7955}. In Forever kann womöglich jedes Volk bei jedem Reitlehrer lernen (unbestätigt). Sammelobjekte, Reittiere · Stufe 40 listet alle Farben.",
	-- {npc:7955} Milli Featherwhistle
	["{npc:7955}: other colours, 20g"] = "{npc:7955}: andere Farben, 20g",

	-- Step 113: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "",

	-- Step 114: Loch Modan
	-- {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {area:144} Thelsamar
	["Ride east out of {zone:1426} through the tunnel into {zone:1432} and on along the road to {area:144}."] = "",

	-- Step 115: Thelsamar
	-- {npc:1470} Ghak Healtouch · {area:144} Thelsamar · {area:1517} Uldaman · {zone:1418} Badlands
	["{npc:1470} is below ground in {area:144}, by the inn. His mushrooms grow in the {area:1517} dig in the {zone:1418}; the next guide takes you there and back through {area:144}."] = "",
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, below ground"] = "",

	-- Step 117: Hammertoe's Digsite
	-- {zone:1432} Loch Modan · {zone:1418} Badlands · {npc:2860} Sigrun Ironhew
	["Ride south out of {zone:1432} through the pass into the {zone:1418}; {npc:2860} camps at the dig."] = "Reite nach Süden aus {zone:1432} durch den Pass ins {zone:1418}; {npc:2860} lagert bei der Ausgrabung.",

	-- Step 118: Garek
	-- {npc:2888} Garek · {area:1898} Dustwind Gulch
	["{npc:2888} camps by himself in {area:1898}, south-east of the digsite."] = "{npc:2888} lagert allein in {area:1898}, südöstlich der Ausgrabungsstätte.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. No Skyborne riding trainer is known; the Forever client files {spell:1285849} under the one Riding skill, so {npc:4732} at {area:88} in eastern {zone:1429}, the nearest trainer to {zone:1453}, should teach it (unconfirmed). The Galestriders are sold by {npc:265756} in {area:16638} on Zephras Isle; Collectibles, Mounts · Level 40 lists them."] = "Mit 40 und 100 Gold kannst du reiten lernen, und dabei erhältst du ein Reittier. Es ist kein Reitlehrer der Himmelsgeborenen bekannt; der Forever-Client führt {spell:1285849} unter der einen Reitfertigkeit, also sollte {npc:4732} in {area:88} im östlichen {zone:1429}, der nächste Lehrer bei {zone:1453}, es lehren (unbestätigt). Die Windschreiter verkauft {npc:265756} in {area:16638} auf der Insel Zephras; Sammelobjekte, Reittiere · Stufe 40 listet sie.",
	-- ["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4732} teaches Humans at {area:88} in eastern {area:12}, beside {npc:384}'s horses. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "Mit 40 und 100 Gold kannst du reiten lernen, und dabei erhältst du ein Reittier. {npc:4732} lehrt Menschen in {area:88} im östlichen {area:12}, neben den Pferden von {npc:384}. In Forever kann womöglich jedes Volk bei jedem Reitlehrer lernen (unbestätigt). Sammelobjekte, Reittiere · Stufe 40 listet alle Farben.",
	-- ["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4753} teaches Night Elves in {zone:1457}, beside {npc:4730}'s sabers: the boat from {area:17203} to {area:442}, then the flight to {area:702}. Forever may let any race learn from any riding trainer (unconfirmed), such as {npc:4732} at {area:88} in {area:12}. Collectibles, Mounts · Level 40 lists every colour."] = "Mit 40 und 100 Gold kannst du reiten lernen, und dabei erhältst du ein Reittier. {npc:4753} lehrt Nachtelfen in {zone:1457}, neben den Säblern von {npc:4730}: das Boot vom {area:17203} nach {area:442}, dann der Flug nach {area:702}. In Forever kann womöglich jedes Volk bei jedem Reitlehrer lernen (unbestätigt), etwa bei {npc:4732} in {area:88} im {area:12}. Sammelobjekte, Reittiere · Stufe 40 listet alle Farben.",
	-- ["Bloodsail pirates"] = "Piraten der Blutsegelbukaniere",
	-- ["Cold Eye Basilisks"] = "Kaltaugenbasilisken",
	-- ["Fly to {area:42} and ride east through {zone:1430} into the {zone:1435}; {npc:5476} stands by the road just past the border."] = "Flieg nach {area:42} und reite nach Osten durch den {zone:1430} in die {zone:1435}; {npc:5476} steht gleich hinter der Grenze an der Straße.",
	-- ["Follow the road north-east to the Venture Co. camp at the {area:310}; the miners, surveyors and foremen drop the crystals."] = "Folge der Straße nach Nordosten zum Lager der Venture Co. an der {area:310}; Minenarbeiter, Feldmesser und Großknechte lassen die Kristalle fallen.",
	-- ["Galestriders: {npc:265756}, in {area:16638} on Zephras Isle."] = "Windschreiter: {npc:265756}, in {area:16638} auf der Insel Zephras.",
	-- ["Klannoc offers The Windwatcher next (1791): the {spell:1680} weapon chain, with an elite at the end, is in the Warrior class guide Whirlwind Weapon."] = "Klannoc bietet als Nächstes Der Windbehüter (1791) an: Die Questreihe um die Waffe für {spell:1680}, mit einem Elite am Ende, steht im Kriegerklassen-Guide „Wirbelwind-Waffe“.",
	-- ["Mudrock tortoises"] = "Schlammpanzerschildkröten",
	-- ["Ride back west along the road; {npc:217412} stands a short way north of Biggs."] = "Reite die Straße zurück nach Westen; {npc:217412} steht ein kurzes Stück nördlich von Biggs.",
	-- ["Ride from Theramore west along the Dustwallow road into the {zone:1413} and north to {area:392} on the coast. Learn the flight path from {npc:16227}, then take the boat to {area:35} from the dock."] = "Reite von Theramore nach Westen über die Straße der Marschen ins {zone:1413} und nach Norden nach {area:392} an der Küste. Hol dir die Flugroute bei {npc:16227}, dann nimm am Steg das Boot nach {area:35}.",
	-- ["Ride north-east past Nesingwary's camp and follow the road north to the camp at the top of the vale. On the way, an {npc:217588} crawls in the jungle south-east of Nesingwary's camp: catch one with the Entomology Starter Kit, then tick it off."] = "Reite nach Nordosten an Nesingwarys Lager vorbei und folge der Straße nach Norden zum Lager am oberen Ende des Tals. Unterwegs krabbelt eine {npc:217588} im Dschungel südöstlich von Nesingwarys Lager: Fang eine mit dem Einsteigerpaket für Entomologen und hak sie dann ab.",
	-- ["Ride south out of {zone:1432} through the pass into the {area:3}; {npc:2860} camps at the dig."] = "Reite nach Süden aus {zone:1432} durch den Pass ins {area:3}; {npc:2860} lagert bei der Ausgrabung.",
	-- ["Skullsplitter ruins"] = "Ruinen der Skullsplitter",
	-- ["Take the road north to the ruined manor; Jarl lives in the shack beside it and the loose dirt is at the corner of the house."] = "Nimm die Straße nach Norden zum zerstörten Anwesen; Jarl wohnt in der Hütte daneben, und die lockere Erde ist an der Hausecke.",
	-- ["Take the {area:2257} from the {object:28027}. {npc:5637} is in the Reclaimers' hall by the {object:32356}, {npc:1356} in the hall itself, {npc:2786} in the {object:32383}. The next guide flies on to {area:144}."] = "Nimm die {area:2257} vom {object:28027}. {npc:5637} ist in der Halle der Forscherliga beim {object:32356}, {npc:1356} in der Halle selbst, {npc:2786} im {object:32383}. Der nächste Guide fliegt weiter nach {area:144}.",
	-- ["The Cold Eye Basilisks lie on the rocks west of the mine."] = "Die Kaltaugenbasilisken liegen auf den Felsen westlich der Mine.",
	-- ["The Darkmist spiders nest around the cavern in the north-west of the marsh; every spider drops eyes."] = "Die Graunebelspinnen nisten um die Höhle im Nordwesten des Sumpfs; jede Spinne lässt Augen fallen.",
	-- ["The Mudrock Tortoises and Spikeshells sun themselves on the shore north-east of the manor."] = "Die Schlammpanzerschildkröten und Dornenschlammpanzer sonnen sich am Ufer nordöstlich des Anwesens.",
	-- ["The Skullsplitter trolls hold the ruins just east of the mine; any of them can drop tusks, their panthers always do."] = "Die Skullsplitter-Trolle halten die Ruinen gleich östlich der Mine; jeder von ihnen kann Hauer fallen lassen, ihre Panther immer.",
	-- ["The burned inn stands on the road west, toward the {zone:1413}; the guard's badge lies in the ashes and the hoofprints are in the mud beside the inn."] = "Das abgebrannte Gasthaus Zur süßen Ruh steht an der Straße nach Westen, Richtung {zone:1413}; die Plakette der Wache liegt in der Asche, und die Hufabdrücke sind im Schlamm neben dem Gasthaus.",
	-- ["The riddle's next scroll lies in western Dustwallow: skip it."] = "Die nächste Schriftrolle des Rätsels liegt im Westen der Marschen von Dustwallow: Überspring sie.",
	-- ["for Stoley in {zone:1446}: keep it"] = "für Stoley in {zone:1446}: Behalte es",
	-- ["for the {area:8} later"] = "für die {area:8} später",
	-- ["{item:3713}, for \"Swamp Eye\" Jarl"] = "{item:3713}, für Sumpfauge Jarl",
	-- ["{npc:1356}: for {npc:1344} in {zone:1432}, keep it"] = "{npc:1356}: für {npc:1344} in {zone:1432}, behalte es",
	-- ["{npc:217588}: catch it, for {quest:93176}"] = "{npc:217588}: Fang sie, für {quest:93176}",
	-- ["{npc:4966} holds the tower with a few deserters. He turns on you: beat him until he yields."] = "{npc:4966} hält den Turm mit ein paar Deserteuren. Er wendet sich gegen dich: Schlag ihn, bis er aufgibt.",
	-- ["{npc:5694}: for {area:1438}, keep it"] = "{npc:5694}: für {area:1438}, behalte es",
	-- ["{object:56910} is the tall building over the harbour; most of the quest givers are on its floors or the docks below."] = "{object:56910} ist das hohe Gebäude über dem Hafen; die meisten Questgeber sind auf seinen Stockwerken oder unten an den Docks.",
	-- ["{quest:1218}, for \"Swamp Eye\" Jarl"] = "{quest:1218}, für „Sumpfauge“ Jarl",
	-- ["{quest:1260} stands near the inn; {npc:4897}, a trade supplier a few steps south, sells the spices Jarl wants."] = "{quest:1260} steht nahe dem Gasthaus; {npc:4897}, ein Handwerkswarenhändler ein paar Schritte südlich, verkauft die Gewürze, die Jarl will.",
}
