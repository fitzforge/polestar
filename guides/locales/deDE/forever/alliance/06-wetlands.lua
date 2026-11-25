-- German (deDE): the guide forever/alliance/06-wetlands (forever/alliance/06-wetlands.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Moonglade
	-- {spell:18960} Teleport: Moonglade
	["Cast {spell:18960}"] = "Wirke {spell:18960}",

	-- Step 2: Trial of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. With both half pendants in your bags, stand by the {area:2362} on the north-west shore of the lake and use a half to join them, then go to {npc:11802} in {area:2361}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Wirke {spell:18960}. Wenn du beide Amulett-Hälften in deinen Taschen hast, stell dich zum {area:2362} am Nordwestufer des Sees und benutze eine Hälfte, um sie zusammenzufügen. Geh dann zu {npc:11802} in {area:2361}. {npc:11802} steht im Obergeschoss seines Gebäudes: Geh drinnen nach oben, der Pfeil kann die Stockwerke nicht unterscheiden.",
	-- {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos
	["{item:15885}: join the halves at the {area:2362}"] = "{item:15885}: Füge die Hälften am {area:2362} zusammen",

	-- Step 3: Aquatic Form
	-- {quest:5061} Aquatic Form · {npc:11802} Dendrite Starblaze · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["Take {quest:5061} from {npc:11802}, upstairs in his building. Then {npc:11800} in {area:2361} flies Druids straight to {area:702}."] = "Nimm {quest:5061} von {npc:11802} an, im Obergeschoss seines Gebäudes. Danach fliegt {npc:11800} in {area:2361} Druiden direkt nach {area:702}.",

	-- Step 5: Mathrengyl Bearwalker
	-- {area:1658} Cenarion Enclave · {area:442} Auberdine · {area:150} Menethil Harbor
	["Take the portal up to the {area:1658}, then fly back to {area:442} for the boat to {area:150}."] = "Nimm das Portal hinauf zur {area:1658} und flieg dann zurück nach {area:442}, um das Boot nach {area:150} zu nehmen.",

	-- Step 7: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "Flieg nach {area:702}",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "Flugmeister von {area:442}",

	-- Step 8: Into Darnassus
	-- {zone:1457} Darnassus
	["Into {zone:1457}"] = "Hinein nach {zone:1457}",

	-- Step 11: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Schiff nach {area:150}",
	-- {area:442} Auberdine · {area:150} Menethil Harbor
	["Take the boat from {area:442}'s dock to {area:150}."] = "Nimm das Boot vom Steg von {area:442} nach {area:150}.",

	-- Step 12: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Flieg nach {area:150}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Flugmeister von {zone:1453}",

	-- Step 13: First Mate Fitzsimmons
	-- {quest:288} The Third Fleet · {zone:1440} Ashenvale · {npc:1239} First Mate Fitzsimmons · {item:2594} Flagon of Dwarven Honeymead · {npc:1464} Innkeeper Helbrek
	["{quest:288}, if the {zone:1440} guide's Menethil stop didn't do it: {npc:1239} wants a {item:2594} from {npc:1464}, both in the inn."] = "{quest:288}, falls der Guide von {zone:1440} die Menethil-Stop nicht mitsetzen konnte: {npc:1239} möchte von {npc:1464} ein {item:2594}, beide im Gasthaus.",
	-- {npc:1239} First Mate Fitzsimmons
	["{npc:1239}, in the inn"] = "{npc:1239}, im Gasthaus",
	-- {item:2594} Flagon of Dwarven Honeymead · {npc:1464} Innkeeper Helbrek
	["{item:2594}, from {npc:1464}"] = "{item:2594}, von {npc:1464}",

	-- Step 14: Menethil Harbor
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, by the keep; on the top floor"] = "{npc:2104}, bei der Festung; im obersten Stockwerk",
	-- {npc:2104} Captain Stoutfist · {quest:98221} From the Ashes · {area:1036} Angerfang Encampment
	["{npc:2104}: {quest:98221}, the Attack Plans in the {area:1036}"] = "{npc:2104}: {quest:98221}, die Attack Plans im {area:1036}",
	-- {npc:1242} Karl Boran
	["{npc:1242}, on the pier north of the inn"] = "{npc:1242}, auf dem Pier nördlich des Gasthauses",
	-- {npc:2094} James Halloran
	["{npc:2094}, by the docks"] = "{npc:2094}, bei den Docks",
	-- {npc:270844} Sylessa Duskwhisper · {npc:2094} James Halloran
	["{npc:270844}, beside {npc:2094} by the docks"] = "{npc:270844}, neben {npc:2094} bei den Docks",

	-- Step 15: Harlo Barnaby
	-- {npc:2097} Harlo Barnaby · {npc:1071} Longbraid the Grim · {area:205} Dun Modr
	["{npc:2097}, by the north gate: {npc:1071} takes it at {area:205}, at the north end of this visit's east loop"] = "{npc:2097}, am nördlichen Tor: {npc:1071} nimmt es in {area:205}, am nördlichen Ende des östlichen Loops dieser Besichtigung.",

	-- Step 16: Glorin Steelbrow
	-- {quest:270} The Doomed Fleet · {npc:1212} Bishop Farthing · {zone:1453} Stormwind · {npc:1217} Glorin Steelbrow · {area:2104} Deepwater Tavern · {quest:321} Lightforge Iron · {item:279915} Nord'el
	["{quest:270}, from {npc:1212} in {zone:1453}: {npc:1217} stands in the {area:2104}, south of the keep. His {quest:321} lies in the wreck just south of town, by {item:279915}."] = "{quest:270}, von {npc:1212} in {zone:1453}: {npc:1217} steht in {area:2104} südlich des Schlosses. Sein {quest:321} liegt im Wrack direkt südlich der Stadt, bei {item:279915}.",
	["Inside"] = "Drinnen",

	-- Step 17: Glorin Steelbrow
	-- {quest:270} The Doomed Fleet · {npc:1217} Glorin Steelbrow · {quest:321} Lightforge Iron · {area:2104} Deepwater Tavern
	["{quest:270} is already with {npc:1217}: take {quest:321} from him in the {area:2104}, south of the keep."] = "{quest:270} ist bereits bei {npc:1217}: nimm {quest:321} von ihm in {area:2104}, südlich des Schlosses.",

	-- Step 18: James Halloran
	-- {area:17732} Excavation Site: Wetlands · {npc:2094} James Halloran
	["For your {area:17732} run, later in this guide: {npc:2094}, by the docks, wants hides from the raptors inside."] = "Für deinen Run durch {area:17732}, später in diesem Guide: {npc:2094} an den Docks will Häute von den Raptoren drinnen.",

	-- Step 19: Nord'el
	-- {item:279915} Nord'el · {area:150} Menethil Harbor
	["{item:279915} lies on the shore just south of {area:150}, a short walk past the town's south end. Then follow the coast north out of town to the hovels."] = "{item:279915} liegt am Ufer gleich südlich von {area:150}, ein kurzer Fußweg hinter dem Südende der Stadt. Folge dann der Küste nach Norden aus der Stadt hinaus zu den Hütten.",

	-- Step 20: Waterlogged Chest
	-- {item:279915} Nord'el
	["The wreck of the Flying Osprey lies in the shallows south of the keep, beside {item:279915}."] = "Das Wrack von Flying Osprey liegt in den flachen Gewässern südlich des Schlosses, neben {item:279915}.",

	-- Step 21: Lightforge Ingots
	-- plural, as words: Lightforge Ingots = {item:2702} Lightforge Ingot
	["Lightforge Ingots"] = "Lichtschmiedeblöcke",
	-- plural, as words: Bluegill Raiders = {npc:1418} Bluegill Raider
	["The Bluegill Raiders (28-29) on the beach south-west of Menethil carry the ingots."] = "Die Bluegill Raiders (28-29) am Strand südwestlich von Menethil tragen die Ingots.",
	-- {item:2702} Lightforge Ingot
	["{item:2702}; underwater"] = "{item:2702}; unter Wasser",

	-- Step 22: Glorin Steelbrow
	-- {npc:1217} Glorin Steelbrow · {area:2104} Deepwater Tavern
	["Back north through Menethil: {npc:1217} is in the {area:2104}, on the way to the hovels."] = "Nach Norden durch Menethil: {npc:1217} ist in {area:2104}, auf dem Weg zu den Höhlen.",
	-- {npc:1416} Grimand Elmore · {zone:1453} Stormwind
	["For {npc:1416} in {zone:1453}, on this guide's {zone:1453} stop"] = "Für {npc:1416} in {zone:1453}, auf diesem Guide's {zone:1453}-Stop",

	-- Step 23: The Bluegill hovels
	["The Bluegill hovels"] = "Die Hütten der Blaukiemen",
	-- {area:1022} Bluegill Marsh · {object:261} Damaged Crate · {object:142151} Sealed Barrel · {object:259} Half-buried Barrel
	["Follow the coast north out of Menethil into {area:1022}. Three containers in the murloc hovels, south to north: the {object:261}, then the {object:142151}, then the {object:259} at the north end."] = "Folge der Küste nach Norden aus Menethil hinaus in den {area:1022}. Drei Behälter in den Murlochütten, von Süd nach Nord: {object:261}, dann {object:142151}, dann {object:259} am nördlichen Ende.",

	-- Step 24: The Lost Fleet: kill these as you meet them
	-- {area:1039} The Lost Fleet
	["{area:1039}: kill these as you meet them"] = "{area:1039}: Töte diese, sobald sie dir begegnen",
	-- {npc:1159} First Mate Snellig
	-- plural, as words: Cursed Sailors = {npc:1157} Cursed Sailor · Cursed Marines = {npc:1158} Cursed Marine · Giant Wetlands Crocolisks = {npc:2089} Giant Wetlands Crocolisk · Fen Creepers = {npc:1040} Fen Creeper
	["Follow the coast north to the wrecked ship. Cursed Sailors walk the beach, Cursed Marines the deck; {npc:1159} stands on the beach by the bow. Giant Wetlands Crocolisks lurk on the coast just north of it.\nCareful: Fen Creepers hide in stealth where the river splits close to the ghost ship, and they can join a fight."] = "Folge der Küste nach Norden zum Schiffswrack. Cursed Sailors laufen am Strand, Cursed Marines auf dem Deck; {npc:1159} steht am Strand beim Bug. Giant Wetlands Crocolisks lauern an der Küste direkt nördlich davon.\nVorsicht: Fen Creepers verstecken sich getarnt dort, wo sich der Fluss nahe dem Geisterschiff teilt, und können in einen Kampf eingreifen.",
	-- {npc:1158} Cursed Marine · {npc:270589} Nightveiled Rotheap
	["{npc:1158}; careful: {npc:270589}, a level 31 elite, roams this coast"] = "{npc:1158}; Vorsicht: {npc:270589}, ein Elite der Stufe 31, streift an dieser Küste umher",

	-- Step 25: Menethil Harbor
	-- {npc:2094} James Halloran · {npc:1242} Karl Boran · {npc:2104} Captain Stoutfist · {npc:1239} First Mate Fitzsimmons
	["In from the north: {npc:2094} by the docks, {npc:1242} on the pier, {npc:2104} in the keep, then {npc:1239} in the inn."] = "Von Norden kommend: {npc:2094} bei den Docks, {npc:1242} auf dem Pier, {npc:2104} in der Festung, dann {npc:1239} im Gasthaus.",
	-- {npc:270844} Sylessa Duskwhisper
	["{npc:270844}, beside him"] = "{npc:270844}, neben ihm",
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["For {npc:3649} in {area:442}, on this guide's boat trip: keep it"] = "Für {npc:3649} in {area:442}, auf der Schiffsreise dieses Guides: behalte es",
	-- {npc:1242} Karl Boran · {npc:2104} Captain Stoutfist
	["{npc:1242}: for {npc:2104} in the keep"] = "{npc:1242}: für {npc:2104} in der Burg",
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, on the top floor"] = "{npc:2104}, im obersten Stockwerk",
	-- {object:2117} Stormwind Keep
	["For Bolvar Fordragon in {object:2117}: keep it"] = "Für Bolvar Fordragon in {object:2117}: behalte sie",
	-- {npc:1239} First Mate Fitzsimmons · {npc:1160} Captain Halyndor
	["{npc:1239}: {npc:1160} (30) is for the end of this visit, from level 29"] = "{npc:1239}: {npc:1160} (30) ist für das Ende dieser Besichtigung, ab Stufe 29.",

	-- Step 26: Raptor valley
	["Raptor valley"] = "Raptorental",
	-- {quest:295} Ormer's Revenge
	["Follow the road east: the bigger raptors for {quest:295} hunt in the valley just west of the excavation site."] = "Folge der Straße nach Osten: Die größeren Raptoren für {quest:295} jagen im Tal direkt westlich der Ausgrabungsstätte.",

	-- Step 27: Whelgar's Excavation Site
	-- {npc:1078} Ormer Ironbraid · {npc:1077} Prospector Whelgar
	["The excavation site sits on the hill south of the road: {npc:1078} at the top, {npc:1077} below ground."] = "Die Ausgrabungsstätte liegt auf dem Hügel südlich der Straße: {npc:1078} oben, {npc:1077} unter der Erde.",

	-- Step 28: Whelgar's Excavation Site: kill these as you meet them
	-- {area:118} Whelgar's Excavation Site
	["{area:118}: kill these as you meet them"] = "{area:118}: Töte diese, sobald sie dir begegnen",
	-- {npc:1353} Sarltooth · {object:331} Loose Soil
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["The relics lie in the dig itself. {npc:1353}, a big Razormaw, prowls the raptor valley just west of it.\nGoaz Warders (elite, 32) stand among the relics and the {object:331}: work around them; don't pull them."] = "Die Relikte liegen in der Grabung selbst. {npc:1353}, ein großer Razormaw, streift durch das Raptorental direkt westlich davon.\nGoazwärter (Elite, 32) stehen zwischen den Relikten und den Stellen mit {object:331}: Umgeh sie; zieh sie nicht.",
	-- {item:2661} Neru Fragment · {object:331} Loose Soil
	["{item:2661}: the {object:331}"] = "{item:2661}: die {object:331}",

	-- Step 29: Ormer Ironbraid and Whelgar
	-- {npc:1078} Ormer Ironbraid
	["{npc:1078} and Whelgar"] = "{npc:1078} und Whelgar",
	-- {npc:1077} Prospector Whelgar · {item:279993} Titanic Keystone
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["{npc:1077}, below ground: the {item:279993}, from the elite Goaz Warders"] = "{npc:1077}, unter der Erde: {item:279993}, von den Elite-Goaz Warders",

	-- Step 30: Goaz Warders
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["Goaz Warders"] = "Goaz Warders",
	-- {item:279996} Goaz Stone · {npc:270892} Goaz Warder
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["The Goaz Warders stand just west of Whelgar's camp: use the {item:279996} he gave you beside one.\n{npc:270892} is elite: grouping up is advised."] = "Die Goaz Warders stehen direkt westlich von Whelgars Lager: Benutze den {item:279996}, den er dir gegeben hat, neben einem von ihnen.\n{npc:270892} ist ein Elite: Eine Gruppe wird empfohlen.",

	-- Step 31: Prospector Whelgar
	["Below ground"] = "Unter der Erde",

	-- Step 32: Prospector Whelgar
	-- {item:279996} Goaz Stone · {zone:1437} Wetlands · {area:205} Dun Modr
	["A new {item:279996}, for the four titan watchers around the {zone:1437}; below ground. Their hearts drop from level 32 elites on the {area:205} visit"] = "Ein neuer {item:279996} für die vier Titanenwächter rund um {zone:1437}; unter der Erde. Ihre Herzen droppen von Elites der Stufe 32 beim Besuch in {area:205}",

	-- Step 33: Angerfang Encampment
	-- {zone:1455} Ironforge · {npc:2091} Chieftain Nek'rosh · {quest:98221} From the Ashes
	["North from the dig into the Dragonmaw camp: click the four sets of Attack Plans. The {zone:1455} plan lies at the camp's west end, the other three further east. {npc:2091}, an elite, stands apart to the south-east: {quest:98221} doesn't need him."] = "Nördlich der Grabung ins Lager der Drachenmaul: Klicke die vier Sets Attack Plans an. Der Plan für {zone:1455} liegt am Westende des Lagers, die anderen drei weiter östlich. {npc:2091}, ein Elite, steht abseits im Südosten: {quest:98221} braucht ihn nicht.",
	-- {item:3337} Dragonmaw War Banner
	["{item:3337}: the camp's Raiders and Swamprunners"] = "{item:3337}: von den Raiders und Swamprunners des Lagers",

	-- Step 34: Mosshide gnolls
	["Mosshide gnolls"] = "Gnolle der Moosfelle",
	-- {quest:277} Fire Taboo · {item:2611} Crude Flint · {area:309} Ironbeard's Tomb · {area:1025} Green Belt · {npc:1244} Rethiel the Greenwarden
	-- plural, as words: Mosshide Fenrunners = {npc:1010} Mosshide Fenrunner · Maddened Rotclaws = {npc:271334} Maddened Rotclaw · Mosshide Brutes = {npc:1012} Mosshide Brute
	["{quest:277} is still short of its nine {item:2611}: the Mosshide Fenrunners and Trappers (22-24) along the river north-west of the Angerfang camp, south-west of {area:309}, drop them. Almost every one carries some.\nCareful: Maddened Rotclaws (25-26) roam the {area:1025} around {npc:1244}; Mosshide Brutes, Mystics and Alphas (24-27) hold the hills north-west of the Fenrunners' camp."] = "{quest:277} ist noch nicht bei neun {item:2611}: die Moosversteckten Feenjäger und Fänger (22-24) entlang des Flusses nordwestlich des Angerfang-Lagers, südlich von {area:309}, lassen sie fallen. Fast jeder Trägt eine.\nVorsicht: Zornige Rotklaue (23) patrouilliert die {area:1025} um {npc:1244}; Moosfellbrüte, Mystische und Alphas (23) halten die Hügel nordwestlich des Fangenlagers.",

	-- Step 35: Rethiel the Greenwarden
	-- {area:1025} Green Belt · {npc:1244} Rethiel the Greenwarden · {quest:277} Fire Taboo · {zone:1437} Wetlands
	["Follow the road east to the {area:1025}; {npc:1244} stands by the river. {quest:277}'s flint came with you from your last {zone:1437} visit."] = "Folge der Straße nach Osten zum {area:1025}; {npc:1244} steht am Fluss. Der Feuerstein für {quest:277} kam schon von deinem letzten Besuch in {zone:1437} mit.",

	-- Step 36: Howin Kindfeather
	-- {npc:270637} Howin Kindfeather · {npc:1244} Rethiel the Greenwarden
	["{npc:270637} camps among the Fenrunners, just west of {npc:1244}."] = "{npc:270637} lagert zwischen den Fenrunners, direkt westlich von {npc:1244}.",
	-- {area:1038} Dragonmaw Gates
	-- plural, as words: Razormaw Incisors = {item:280103} Razormaw Incisor · Fen Creepers = {npc:1040} Fen Creeper
	["Razormaw Incisors: from the raptors by the {area:1038}, after the Fen Creepers"] = "Zahnhacker-Zähne: von den Raubvögeln bei {area:1038}, nach den Feuenberg-Rappeln",
	-- {quest:98246} Trying Times
	["{quest:98246}: the Razormaw eggs, on the same walk"] = "{quest:98246}: die Razormaw-Eier, auf dem gleichen Spaziergang",

	-- Step 37: Einar Stonegrip
	-- {npc:270637} Howin Kindfeather · {npc:2093} Einar Stonegrip
	["East from {npc:270637}: {npc:2093} stands beside the road."] = "Östlich von {npc:270637}: {npc:2093} steht neben der Straße.",
	-- {npc:2093} Einar Stonegrip · {npc:2094} James Halloran
	["{npc:2093}: for {npc:2094} in Menethil"] = "{npc:2093}: für {npc:2094} in Menethil",

	-- Step 38: Fen Creepers along the river
	-- plural, as words: Fen Creepers = {npc:1040} Fen Creeper
	["Fen Creepers along the river"] = "Fen Creepers am Fluss",
	-- {npc:2093} Einar Stonegrip · {area:1024} Sundown Marsh · {npc:1244} Rethiel the Greenwarden
	-- plural, as words: Fen Creepers = {npc:1040} Fen Creeper
	["North-west from {npc:2093} to the river: Fen Creepers hide in its pools and along its banks all the way west to {area:1024}. Work west along it until you have twelve, then back east to {npc:1244}.\nCareful: When out of combat, Fen Creepers cast Sneak from time to time, so they are stealthed and hard to see."] = "Nordwestlich von {npc:2093} zum Fluss: Fen Creepers verstecken sich in seinen Tümpeln und an seinen Ufern, den ganzen Weg nach Westen bis {area:1024}. Arbeite dich daran entlang nach Westen, bis du zwölf hast, und geh dann zurück nach Osten zu {npc:1244}.\nVorsicht: Außerhalb des Kampfes wirken Fen Creepers von Zeit zu Zeit Schleichen, sodass sie getarnt und schwer zu sehen sind.",

	-- Step 39: Rethiel the Greenwarden
	-- {quest:98283} Carnage · {npc:271334} Maddened Rotclaw · {zone:1437} Wetlands · {zone:1424} Hillsbrad Foothills
	["{quest:98283}, an elite raptor called out with a {npc:271334}'s flesh, on the {zone:1437} loop of the {zone:1424} guide"] = "{quest:98283}, eine Elite-Rauchfeder durch ein {npc:271334}'s Fleisch, auf dem {zone:1437}-Loop von Guide {zone:1424}",

	-- Step 40: Dragonmaw Gates: kill these as you meet them
	-- {area:1038} Dragonmaw Gates
	["{area:1038}: kill these as you meet them"] = "{area:1038}: Töte diese, sobald sie dir begegnen",
	-- {npc:1244} Rethiel the Greenwarden · {area:1036} Angerfang Encampment · {area:205} Dun Modr · {quest:98283} Carnage · {npc:270892} Goaz Warder · {area:1038} Dragonmaw Gates · {npc:270637} Howin Kindfeather
	-- plural, as words: Crimson Whelps = {npc:1069} Crimson Whelp · Highland Razormaws = {npc:1018} Highland Razormaw · Perfect Razormaw Eggs = {item:280132} Perfect Razormaw Egg
	["East from {npc:1244}: the Crimson Whelps (25-26) nest in the hills north-east of the {area:1036}, and the Highland Razormaws (27-28) hunt the highlands north of them, towards {area:205}. The Perfect Razormaw Eggs lie in the raptors' nests.\nCareful: {quest:98283}, an elite raptor, prowls the hills north of the whelps, and Ados, an elite {npc:270892} guardian, stands at the {area:1038}: give both room. The Dragonmaw east of {npc:270637} are elite too."] = "Östlich von {npc:1244}: Die Purpur-Welpen (25-26) nisten in den Hügeln nordöstlich von {area:1036}, und die Hochland-Razormaws (27-28) jagen in den Hochländern nördlich davon, Richtung {area:205}. Die perfekten Razormaw-Eier liegen in den Nestern der Raptoren.\nVorsicht: {quest:98283}, ein Elite-Raptor, streift durch die Hügel nördlich der Welpen, und Ados, ein Elite-{npc:270892}-Wächter, steht bei {area:1038}: Gib beiden Raum. Die Drachenmaul östlich von {npc:270637} sind ebenfalls Eliten.",

	-- Step 41: Longbraid the Grim
	-- {area:205} Dun Modr · {npc:1071} Longbraid the Grim · {npc:1075} Rhag Garmason · {object:147516} Dark Iron
	["North-west to the road and north along it to {area:205}. {npc:1071} and {npc:1075} stand together in the dwarves' camp on the east side of the road; the {object:147516} ruins west of it are full of elites: keep to the road.\nCareful: Modr (32, elite) walks the {object:147516} ruins about 55 yards west of {npc:1075}; players have met it from the camp and the road: stay on the camp's east side."] = "Nordwestlich zur Straße und nördlich daneben nach {area:205}. {npc:1071} und {npc:1075} standen zusammen im Zwergelager am östlichen Straßenrand; die Ruinen von {object:147516} westlich sind voller Eliten: bleibe an der Straße.\nVorsicht: Modr (32, Elite) patrouilliert die Ruinen von {object:147516} etwa 55 Yards westlich von {npc:1075}; Spieler haben es von Lager und Straße kennengelernt: bleibe an der östlichen Seite des Lagers.",

	-- Step 42: Dun Modr
	-- {npc:1075} Rhag Garmason · {npc:1071} Longbraid the Grim · {area:205} Dun Modr · {object:147516} Dark Iron
	["{npc:1075} stands beside {npc:1071} in the dwarves' camp at {area:205}, east of the road; keep out of the {object:147516} ruins west of it, where Modr (32, elite) walks."] = "{npc:1075} steht neben {npc:1071} im Zwergelager bei {area:205}, östlich der Straße; bleibe außerhalb der Ruinen von {object:147516} westlich, wo Modr (32, Elite) patroniert.",

	-- Step 43: Ebenezer Rustlocke
	["Ebenezer Rustlocke"] = "Ebenezer Rustlocke",
	-- {area:205} Dun Modr · {area:880} Thandol Span · {npc:1075} Rhag Garmason
	-- plural, as words: Dark Iron Saboteurs = {npc:1052} Dark Iron Saboteur
	["North along the road from {area:205} towards the {area:880}: Ebenezer Rustlocke's corpse lies under the span. His parchment goes back to {npc:1075}.\nCareful: Two elite Dark Iron Saboteurs (28-29) stand by the corpse inside the span: loot the corpse and walk straight out without fighting, or, from level 31, pull them one at a time."] = "Nördlich die Straße von {area:205} Richtung {area:880}: Ebenezer Rustlockes Leiche liegt unter dem Brückenbogen. Sein Pergament geht zurück an {npc:1075}.\nVorsicht: Zwei Elite-Dunkeleisen-Saboture (28-29) stehen bei der Leiche innerhalb des Bogens: Plündere die Leiche und geh direkt hinaus, ohne zu kämpfen, oder ab Stufe 31 ziehe sie einzeln.",
	-- {object:2652} Ebenezer Rustlocke's Corpse
	["{object:2652}, inside"] = "{object:2652}, drinnen",
	["the same corpse"] = "dieselbe Leiche",

	-- Step 44: Rhag Garmason
	-- {area:205} Dun Modr · {npc:1075} Rhag Garmason · {object:147516} Dark Iron
	["Back down the road to {area:205}: {npc:1075} wants the {object:147516} explosives under the far end of the span destroyed. Keep to the camp's east side, away from Modr (32, elite) in the ruins."] = "Rückwärts die Straße zu {area:205}: {npc:1075} möchte die Sprengstoffe von {object:147516} unter dem weiteren Ende der Brücke dem Bahndamm zerstören. Bleibe an der östlichen Seiten des Lagers, fern von Modr (32, Elite) in den Ruinen.",

	-- Step 45: The Cache of Explosives
	-- {object:2704} Cache of Explosives
	["The {object:2704}"] = "Die {object:2704}",
	-- {area:880} Thandol Span
	-- plural, as words: Dark Irons = {object:147516} Dark Iron · Dark Iron Shadowcasters = {npc:2577} Dark Iron Shadowcaster
	["Over the {area:880}: the Dark Irons' cache of explosives sits by its Arathi end.\nCareful: Dark Iron Shadowcasters (31-32) and Bombardiers (30-31), who fight from range, and a Supplier (31-32) stand within 15-25 yards of the cache: pull them one at a time to the bridge before you touch it."] = "Jenseits von {area:880}: Das Sprengstoffversteck der Dunkeleisen liegt an dessen Arathi-Ende.\nVorsicht: Dunkeleisen-Schattenwirker (31-32) und Bombardiere (30-31), die aus der Distanz kämpfen, sowie ein Versorger (31-32) stehen innerhalb von 15-25 Metern um das Versteck: Ziehe sie einzeln zur Brücke, bevor du es berührst.",

	-- Step 46: Waterlogged Envelope
	-- {item:4433} Waterlogged Envelope · {npc:2695} Sara Balloo · {zone:1455} Ironforge
	["In the river under the Arathi end of the span, a {item:4433} lies on the bottom: {npc:2695} in {zone:1455}, at the end of this guide, takes it."] = "Im Fluss unter dem Arathi-Ende der Brücke liegt ein {item:4433} am Boden: {npc:2695} in {zone:1455}, am Ende dieser Besichtigung, nimmt es.",
	["Underwater"] = "Unter Wasser",

	-- Step 47: Rhag Garmason again
	-- {npc:1075} Rhag Garmason
	["{npc:1075} again"] = "Noch einmal {npc:1075}",
	-- {area:205} Dun Modr
	["Back over the span and down the road to {area:205}, on the camp's east side, away from Modr (32, elite) in the ruins."] = "Über die Brücke und die Straße zurück zu {area:205}, an der östlichen Seiten des Lagers, fern von Modr (32, Elite) in den Ruinen.",
	-- {npc:2700} Captain Nials · {area:320} Refuge Pointe · {zone:1417} Arathi Highlands
	["For {npc:2700} at {area:320}, on your {zone:1417} visit (30-40)"] = "Für {npc:2700} in {area:320}, bei deinem Besuch in {zone:1417} (30-40)",

	-- Step 48: Howin Kindfeather
	-- {area:1025} Green Belt · {npc:270637} Howin Kindfeather · {npc:1244} Rethiel the Greenwarden
	["South along the road to the {area:1025}: {npc:270637} camps among the Fenrunners, just west of {npc:1244}."] = "Südlich entlang der Straße zum {area:1025}: {npc:270637} herrscht unter den Feenjägern, direkt westlich von {npc:1244}.",

	-- Step 49: Rethiel the Greenwarden
	-- {area:17732} Excavation Site: Wetlands · {npc:1244} Rethiel the Greenwarden · {npc:260808} Highland Horror
	["For your {area:17732} run, on the way back west: {npc:1244} wants the root core of a {npc:260808} inside."] = "Für deinen Run durch {area:17732}, auf dem Weg zurück nach Westen: {npc:1244} will den Wurzelkern von einem {npc:260808} drinnen.",

	-- Step 50: Excavation Site: Wetlands
	-- {area:17732} Excavation Site: Wetlands · {npc:260808} Highland Horror · {npc:1244} Rethiel the Greenwarden · {npc:260326} Relic Guardian · {item:270865} Titan Relic · {npc:1077} Prospector Whelgar
	["{area:17732} is a dungeon for a group of five at about level 28 to 31. Its entrance lies just south of the road west, east of Whelgar's dig.\nInside: the Thicket raptors and Shadetooth drop the hides for Halloran, a {npc:260808} the root core for {npc:1244}. Saltspine, Shadetooth and the {npc:260326} are the bosses; the {npc:260326} drops a {item:270865}, which starts a quest for {npc:1077}."] = "{area:17732} ist ein Dungeon für eine Gruppe aus fünf Spielern, etwa Stufe 28 bis 31. Der Eingang liegt gleich südlich der Straße nach Westen, östlich von Whelgars Ausgrabung.\nDrinnen: Die Thicket-Raptoren und Shadetooth lassen die Häute für Halloran fallen, ein {npc:260808} den Wurzelkern für {npc:1244}. Saltspine, Shadetooth und {npc:260326} sind die Bosse; {npc:260326} lässt {item:270865} fallen, das eine Quest für {npc:1077} startet.",
	-- {quest:98815} Highland Hides
	["{quest:98815}: the hides, inside"] = "{quest:98815}: die Häute, drinnen",
	-- {quest:95646} Horrors in the Highland
	["{quest:95646}: the root core, inside"] = "{quest:95646}: der Wurzelkern, drinnen",

	-- Step 51: Prospector Whelgar
	-- {item:270865} Titan Relic · {area:17732} Excavation Site: Wetlands · {npc:1077} Prospector Whelgar
	["The {item:270865} from your {area:17732} run: {npc:1077} is below ground in his dig, west of the entrance on the way back west."] = "{item:270865} aus deinem Run durch {area:17732}: {npc:1077} ist unter der Erde in seiner Ausgrabung, westlich vom Eingang auf dem Weg zurück nach Westen.",
	-- {npc:1077} Prospector Whelgar
	["{npc:1077}, below ground"] = "{npc:1077}, unter der Erde",
	-- {npc:1077} Prospector Whelgar · {npc:5387} High Explorer Magellas · {zone:1455} Ironforge
	["{npc:1077}: for {npc:5387} in {zone:1455}, at the end of this guide"] = "{npc:1077}: für {npc:5387} in {zone:1455}, am Ende dieses Guides",

	-- Step 52: Prospector Whelgar
	-- {item:287959} Titan Relic · {npc:1077} Prospector Whelgar · {quest:98824} Prehistoric Prism
	["The {item:287959} is already with {npc:1077}: take {quest:98824} from him, below ground in his dig."] = "Das {item:287959} ist bereits bei {npc:1077}: nimm {quest:98824} von ihm, unterirdisch in seinem Abzuge.",

	-- Step 53: Captain Stoutfist
	-- {area:150} Menethil Harbor · {area:2104} Deepwater Tavern · {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep · {npc:2094} James Halloran
	["Hearth back to {area:150} if you bound at the {area:2104}, or walk west along the road: {npc:2104} stands on the top floor of {area:2103}, {npc:2094} by the docks."] = "Ruhestein zurück zu {area:150}, falls du am {area:2104} gezündet hast, oder laufe westlich entlang der Straße: {npc:2104} steht auf dem oberen Stockwerk von {area:2103}, {npc:2094} am Hafen.",
	["On the top floor"] = "Im obersten Stockwerk",
	-- {zone:1437} Wetlands · {zone:1424} Hillsbrad Foothills
	["For the Dragonmaw catapult, on the {zone:1437} loop of the {zone:1424} guide"] = "Für die Drachenmaul-Katapulte, auf dem {zone:1437}-Loop von Guide {zone:1424}",

	-- Step 54: Captain Halyndor
	-- {npc:1160} Captain Halyndor · {npc:270589} Nightveiled Rotheap · {zone:1437} Wetlands
	-- plural, as words: Cursed Marines = {npc:1158} Cursed Marine
	["From level 29: north along the coast from Menethil to the wreck of the Intrepid. {npc:1160} (30) is aboard, and the locked strongbox sits in the wreck.\nCareful: Cursed Marines (27-28) crowd the deck around him: clear them first. {npc:270589}, a level 31-32 elite, roams the {zone:1437}: give it a wide berth."] = "Ab Stufe 29: Von Menethil nach Norden entlang der Küste zum Wrack der Intrepid. {npc:1160} (30) ist an Bord, und die verschlossene Geldkassette steht im Wrack.\nVorsicht: Verfluchte Marinesoldaten (27-28) drängen sich auf dem Deck um ihn herum: Räume sie zuerst ab. {npc:270589}, ein Elite der Stufe 31-32, streift durch das {zone:1437}: Mach einen großen Bogen um ihn.",
	-- {item:2629} Intrepid Strongbox Key · {npc:1160} Captain Halyndor
	["{item:2629}, from {npc:1160}"] = "{item:2629}, von {npc:1160}",

	-- Step 55: Glorin Steelbrow
	-- {npc:1217} Glorin Steelbrow · {area:2104} Deepwater Tavern
	["Back south to Menethil: {npc:1217} stands in the {area:2104}."] = "Zurück nach Süden nach Menethil: {npc:1217} steht in der {area:2104}.",
	-- {npc:1284} Archbishop Benedictus · {zone:1453} Stormwind
	["For {npc:1284} in {zone:1453}, at the end of this guide"] = "Für {npc:1284} in {zone:1453}, am Ende dieses Guides",

	-- Step 56: Level 28
	["Level 28"] = "Stufe 28",
	-- {zone:1437} Wetlands · {zone:1440} Ashenvale
	-- plural, as words: Bluegill Raiders = {npc:1418} Bluegill Raider
	["Still below level 28? That happens when you start this guide here without the {zone:1437} and {zone:1440} quests of the guides before it: top up on the Bluegill Raiders along the coast just south of Menethil before the boat, so {zone:1440}'s level 28-32 quests aren't too hard."] = "Noch unter Stufe 28? Das passiert, wenn du diesen Guide hier beginnst, ohne die Quests in {zone:1437} und {zone:1440} aus den Guides davor: Hol dir vor dem Boot den Rest an den Bluegill Raiders entlang der Küste gleich südlich von Menethil, damit die Quests der Stufe 28-32 in {zone:1440} nicht zu schwer sind.",
	-- {npc:1418} Bluegill Raider
	["grind on {npc:1418}"] = "Grinde an {npc:1418}",

	-- Step 57: James Halloran
	-- {npc:2094} James Halloran
	["Your Excavation Site hides: {npc:2094}, by the docks."] = "Deine Häute aus der Ausgrabungsstätte: {npc:2094}, bei den Docks.",

	-- Step 58: Boat to Auberdine
	-- {area:442} Auberdine
	["The boat to {area:442} leaves from the far end of Menethil's western pier."] = "Das Boot nach {area:442} legt am äußersten Ende des westlichen Piers von Menethil ab.",

	-- Step 59: Thundris Windweaver
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["{npc:3649} stands at the north end of {area:442}, up the road from the dock."] = "{npc:3649} steht am Nordende von {area:442}, die Straße vom Dock hinauf.",
	-- {item:279915} Nord'el · {npc:270844} Sylessa Duskwhisper · {area:150} Menethil Harbor
	["{item:279915}, from {npc:270844} in {area:150}"] = "{item:279915}, von {npc:270844} in {area:150}",

	-- Step 60: Thundris Windweaver
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["{npc:3649} stands at the north end of {area:442}."] = "{npc:3649} steht am Nordende von {area:442}.",
	-- {zone:1439} Darkshore · {area:442} Auberdine
	["Alexston's reply, if you still carry it (the route hands it in on the {zone:1439} return's first {area:442} stop)"] = "Alexstons Antwort, falls du sie noch trägst (die Route überlässt sie bei der ersten {area:442}-Stop der Rückkehr zu {zone:1439})",

	-- Step 61: Auberdine
	-- {npc:3693} Terenthis · {quest:990} Trek to Ashenvale · {npc:3694} Sentinel Selarin
	["{npc:3693} stands by the flight master. No {quest:990} yet? Give it a minute after the hand-in: {npc:3694} comes to {npc:3693}'s side shortly after Volcor's escort is handed in. Changing layer can also find her."] = "{npc:3693} steht beim Flugmeister. Noch kein {quest:990}? Warte nach der Abgabe eine Minute: {npc:3694} kommt kurz nach der Abgabe von Volcors Eskorte an die Seite von {npc:3693}. Ein Layerwechsel kann sie auch finden.",
	-- {npc:3693} Terenthis · {zone:1439} Darkshore
	["{npc:3693}: Volcor's escort from the end of {zone:1439}"] = "{npc:3693}: Volcors Eskorte vom Ende von {zone:1439}",
	-- {npc:3694} Sentinel Selarin · {quest:990} Trek to Ashenvale · {npc:3691} Raene Wolfrunner · {area:415} Astranaar
	["{npc:3694}, once she comes: {quest:990}, for {npc:3691} in {area:415}"] = "{npc:3694}, sobald sie da ist: {quest:990}, für {npc:3691} in {area:415}",

	-- Step 62: Gershala Nightwhisper
	-- {area:2797} Blackfathom Deeps · {npc:8997} Gershala Nightwhisper · {npc:3693} Terenthis
	["Your {area:2797} brain stems: {npc:8997} stands a short walk west of {npc:3693}."] = "Deine Corrupted Brain Stems aus {area:2797}: {npc:8997} steht ein kurzes Stück westlich von {npc:3693}.",

	-- Step 63: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "Flieg nach {area:415}",

	-- Step 64: Shindrell Swiftfire
	-- {npc:3845} Shindrell Swiftfire · {npc:3970} Llana · {area:415} Astranaar
	["{npc:3845} and {npc:3970} stand by {area:415}'s flight master."] = "{npc:3845} und {npc:3970} stehen beim Flugmeister von {area:415}.",
	-- {quest:4581} Kayneth Stillwind · {area:2358} Forest Song
	["For {quest:4581} at {area:2358}"] = "Für {quest:4581} in {area:2358}",
	-- {npc:3970} Llana · {quest:95737} Seeking Caitlin · {npc:1480} Caitlin Grassman · {area:150} Menethil Harbor
	["{npc:3970}: {quest:95737}, for {npc:1480} in {area:150}"] = "{npc:3970}: {quest:95737}, für {npc:1480} in {area:150}",

	-- Step 65: Astranaar
	-- {npc:3894} Pelturas Whitemoon
	["{npc:3894}, inside"] = "{npc:3894}, drinnen",

	-- Step 66: Raene Wolfrunner
	-- {npc:3691} Raene Wolfrunner
	["{npc:3691} stands in the inn, beside the innkeeper."] = "{npc:3691} steht im Gasthaus neben dem Gastwirt.",
	-- {npc:3691} Raene Wolfrunner · {quest:990} Trek to Ashenvale · {zone:1439} Darkshore
	["{npc:3691}: {quest:990}, if you still carry it from {zone:1439}"] = "{npc:3691}: {quest:990}, falls du sie noch aus {zone:1439} dabeihast",

	-- Step 67: Raene Wolfrunner
	-- {npc:3691} Raene Wolfrunner
	["{npc:3691}, at the inn, if you missed her first visit"] = "{npc:3691}, im Gasthaus, falls du ihren ersten Besuch verpasst hast",

	-- Step 68: Teronis' Corpse
	-- {area:415} Astranaar · {area:441} Lake Falathim
	["Go west from {area:415} to {area:441}. Teronis lies on the shore among the Saltspittle murlocs."] = "Gehe von {area:415} nach Westen zu {area:441}. Teronis liegt am Strand unter den Salzspitze-Murlocs.",

	-- Step 69: Glowing Gem
	-- {area:441} Lake Falathim · {item:5463} Glowing Gem
	["The Saltspittle murlocs around Teronis at {area:441} drop the {item:5463}."] = "Die Salzspitze-Murlocs um Teronis in {area:441} lassen das {item:5463} fallen.",

	-- Step 70: Melyria and Illiyana
	-- {npc:3901} Illiyana
	["Melyria and {npc:3901}"] = "Melyria und {npc:3901}",
	-- {area:415} Astranaar
	["The two stand together at the western end of the road, south-west of {area:415}."] = "Die beiden stehen zusammen am westlichen Ende der Straße, südwestlich von {area:415}.",

	-- Step 71: Therysil
	-- {npc:3585} Therysil · {area:416} Shrine of Aessina · {npc:3901} Illiyana
	["{npc:3585} stands at the {area:416}, a short walk from Melyria and {npc:3901}."] = "{npc:3585} steht am {area:416}, ein kurzes Stück von Melyria und {npc:3901} entfernt.",
	-- {npc:3585} Therysil · {quest:945} Therylune's Escape · {zone:1439} Darkshore
	["{npc:3585}: {quest:945}, if you still carry it from {zone:1439}"] = "{npc:3585}: {quest:945}, falls du sie noch aus {zone:1439} dabeihast",

	-- Step 72: Raene Wolfrunner
	-- {npc:3691} Raene Wolfrunner · {area:415} Astranaar
	["{npc:3691}, at the {area:415} inn"] = "{npc:3691}, am Gasthaus in {area:415}",

	-- Step 73: Raene Wolfrunner's delivery
	-- {npc:3691} Raene Wolfrunner
	["{npc:3691}'s delivery"] = "{npc:3691}'s Lieferung",
	-- {npc:3916} Shael'dryn
	["Take her message to {npc:3916} on the way east"] = "Nimm ihre Botschaft zu {npc:3916} auf dem Weg nach Osten",

	-- Step 74: Raene Wolfrunner's message
	-- {npc:3691} Raene Wolfrunner
	["{npc:3691}'s message"] = "{npc:3691}'s Nachricht",
	-- {area:419} Howling Vale · {npc:3916} Shael'dryn
	["Follow the road east to the {area:419}. {npc:3916} stands by the moonwell."] = "Folge der Straße nach Osten zu {area:419}. {npc:3916} steht am Mondbrunnen.",

	-- Step 75: Shael'dryn
	-- {area:419} Howling Vale · {npc:3916} Shael'dryn
	["Follow the road east to the {area:419}; {npc:3916} stands by the moonwell."] = "Folge der Straße nach Osten zu {area:419}; {npc:3916} steht am Mondbrunnen.",

	-- Step 76: Dartol's Rod
	["Dartol's Rod"] = "Dartols Rute der Transformation",
	-- {item:5475} Wooden Key
	-- plural, as words: Withered Ancients = {npc:3919} Withered Ancient
	["The Crazed and Withered Ancients north of the moonwell carry the {item:5475}; the worn chest it opens stands among them."] = "Die Wahnsinnigen und Welken Urtume nördlich des Mondbrunnens tragen den {item:5475}; die abgenutzte Truhe, die er öffnet, steht zwischen ihnen.",

	-- Step 78: Anilia
	-- {area:429} Xavian · {npc:3920} Anilia
	["Follow the road east to the satyr camps of {area:429}; {npc:3920} hides at their edge."] = "Folge der Straße nach Osten zu den Satyrlagern von {area:429}; {npc:3920} versteckt sich an ihrem Rand.",
	-- {npc:3920} Anilia · {quest:1031} The Branch of Cenarius · {npc:4619} Geltharis
	["{npc:3920}: {quest:1031}, from {npc:4619} (level 32): a fight for a group at this level"] = "{npc:3920}: {quest:1031}, von {npc:4619} (Stufe 32): ein Kampf für eine Gruppe auf dieser Stufe",

	-- Step 79: Geltharis
	-- {npc:4619} Geltharis · {area:429} Xavian
	["{npc:4619} leads the {area:429} satyrs; he carries the branch. He is level 32, above you here, among level 29-30 satyrs: grouping up is advised."] = "{npc:4619} führt die Satyrn von {area:429} an; er trägt den Zweig. Er ist Stufe 32, hier über deiner Stufe, umgeben von Satyrn der Stufe 29-30: Eine Gruppe wird empfohlen.",

	-- Step 80: Forest Song
	-- {area:2358} Forest Song · {npc:3848} Kayneth Stillwind · {npc:221269} Maseara Autumnmoon
	["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} stands there, {npc:221269} a few steps east of her."] = "{area:2358}, der Außenposten der Nachtelfen am Ostende der Straße: {npc:3848} steht dort, {npc:221269} ein paar Schritte östlich von ihr.",
	-- {npc:221269} Maseara Autumnmoon · {area:430} Satyrnaar
	["{npc:221269}: her husband's trail in {area:430}, on the way back from the lake"] = "{npc:221269}: die Spur ihres Mannes in {area:430}, auf dem Rückweg vom See",

	-- Step 81: The Dor'Danil Barrow Den: kill these as you meet them
	-- {area:432} The Dor'Danil Barrow Den
	["{area:432}: kill these as you meet them"] = "{area:432}: Töte diese, sobald sie dir begegnen",
	-- {area:2358} Forest Song · {object:19021} Rusty Chest
	-- plural, as words: Rotting Slimes = {npc:3928} Rotting Slime
	["The Forsaken's camp lies in the woods south of {area:2358}.\nRotting Slimes in and around the Barrow Den leave a {object:19021} when they die: open the chests until one holds the pommel.\nCareful: Non-elite Forsaken of about level 28-30 guard the camp. Some of them are stealthed, and the ones around the table often aggro together."] = "Das Lager der Verlassenen liegt im Wald südlich von {area:2358}.\nFäulnis-Schleime in und um die Grabruine lassen beim Tod eine {object:19021} zurück: Öffne die Truhen, bis eine den Knauf hält.\nVorsicht: Nicht-Elite-Verlassene von etwa Stufe 28-30 bewachen das Lager. Manche von ihnen sind getarnt, und die am Tisch greifen oft gemeinsam an.",

	-- Step 82: Fallen Sky Lake
	-- {npc:3931} Shadethicket Oracle · {quest:1035} Fallen Sky Lake · {object:669176} Gleaming Crescent Pendant
	["The {npc:3931} walks the shore of {quest:1035}, south-west of the chests; the {object:669176} lies north of the lake, on the way.\nCareful: Other mobs, some of them underwater, sit near the island. Clear them first so they don't join the fight when you pull the Oracle."] = "Das {npc:3931} läuft am Ufer von {quest:1035} entlang, südwestlich der Truhen; der {object:669176} liegt nördlich des Sees, auf dem Weg dorthin.\nVorsicht: Weitere Mobs, einige davon unter Wasser, stehen in der Nähe der Insel. Räum sie zuerst weg, damit sie nicht in den Kampf eingreifen, wenn du das Orakel ziehst.",
	-- {object:669176} Gleaming Crescent Pendant · {npc:3961} Maliynn · {area:415} Astranaar
	["{object:669176}: for {npc:3961} in {area:415}"] = "{object:669176}: für {npc:3961} in {area:415}",

	-- Step 83: Satyrnaar
	-- {area:430} Satyrnaar · {area:2358} Forest Song · {object:19901} Circle of Imprisonment · {object:673431} Kurothel's Knapsack (no name in this language: may be words) · {item:281014} Vine-Wrapped Scroll · {area:428} Night Run
	-- plural, as words: Felmusk Rogues = {npc:3759} Felmusk Rogue
	["North from the lake to the satyr camp of {area:430}, just west of {area:2358}: the {object:19901} stands in it, and {object:673431} lies beside it with the {item:281014}.\nCareful: The Felmusk Rogues in {area:428} often go stealthed, and {area:430} has satyr casters."] = "Vom See nach Norden zum Satyrlager von {area:430}, gleich westlich von {area:2358}: Der {object:19901} steht darin, und {object:673431} liegt daneben mit der {item:281014}.\nVorsicht: Die Teufelsmoschusschurken in {area:428} sind oft getarnt, und in {area:430} gibt es Satyr-Zauberwirker.",
	-- {item:281014} Vine-Wrapped Scroll · {object:673431} Kurothel's Knapsack (no name in this language: may be words)
	["{item:281014}, from {object:673431}"] = "{item:281014}, aus {object:673431}",

	-- Step 84: Kayneth Stillwind
	-- {npc:3848} Kayneth Stillwind · {quest:1012} Insane Druids · {area:432} The Dor'Danil Barrow Den
	["Optional: {npc:3848} also offers {quest:1012}, three level 32 druids deep in {area:432}, a cave of quickly respawning, stealthed mobs, and back to her afterwards. It is above your level here: take it only if you are grouped or want the extra XP; the guide doesn't need it."] = "Optional: {npc:3848} bietet auch {quest:1012} an: drei Druiden der Stufe 32 tief in {area:432}, einer Höhle mit schnell respawnenden, getarnten Mobs, und danach zurück zu ihr. Das liegt hier über deiner Stufe: Nimm sie nur an, wenn du in einer Gruppe bist oder die zusätzlichen Erfahrungspunkte willst; der Guide braucht sie nicht.",
	-- {npc:221269} Maseara Autumnmoon
	["{npc:221269}, a few steps east"] = "{npc:221269}, ein paar Schritte östlich",

	-- Step 85: The Dor'Danil Barrow Den's entrance
	-- {area:432} The Dor'Danil Barrow Den
	["{area:432}'s entrance"] = "Eingang von {area:432}",

	-- Step 86: Insane druids
	["Insane druids"] = "Wahnsinnige Druiden",
	-- {area:432} The Dor'Danil Barrow Den · {npc:3940} Taneel Darkwood · {npc:3941} Uthil Mooncall · {npc:3942} Mavoris Cloudsbreak
	["The three druids are inside {area:432}, apart from each other: go in at its mouth, south of the Forsaken camp, not over the hill above them. {npc:3940} is in the eastern halls, {npc:3941} deepest down at the north-east end and {npc:3942} at the western end.\nCareful: The den has many mobs that respawn quickly, including stealthed undead and patrols, so extra mobs often join a fight."] = "Die drei Druiden sind in {area:432}, voneinander getrennt: Geh an der Öffnung südlich des Lagers der Verlassenen hinein, nicht über den Hügel darüber. {npc:3940} ist in den östlichen Hallen, {npc:3941} am tiefsten am Nordostende und {npc:3942} am westlichen Ende.\nVorsicht: Die Höhle hat viele schnell respawnende Mobs, darunter getarnte Untote und Patrouillen, sodass sich oft weitere Mobs in einen Kampf einmischen.",
	-- {npc:3940} Taneel Darkwood · {area:432} The Dor'Danil Barrow Den
	["{npc:3940}, inside {area:432}"] = "{npc:3940}, in {area:432}",
	-- {npc:3941} Uthil Mooncall · {area:432} The Dor'Danil Barrow Den
	["{npc:3941}, inside {area:432}"] = "{npc:3941}, in {area:432}",
	-- {npc:3942} Mavoris Cloudsbreak · {area:432} The Dor'Danil Barrow Den
	["{npc:3942}, inside {area:432}"] = "{npc:3942}, in {area:432}",

	-- Step 88: Night Run
	-- {object:19901} Circle of Imprisonment · {area:428} Night Run
	["The second {object:19901} lies in the valley of {area:428}, on the way west."] = "Der zweite {object:19901} liegt im Tal {area:428}, auf dem Weg nach Westen.",

	-- Step 90: Hidden Shrine
	["The shrine sits on the hill just south-east of the moonwell; follow the winding path up."] = "Der Schrein liegt auf dem Hügel gleich südöstlich des Mondbrunnens; folge dem gewundenen Pfad hinauf.",

	-- Step 92: The Howling Vale
	-- {area:419} Howling Vale · {npc:3792} Terrowulf Packlord
	-- plural, as words: Terrowulf Fleshrippers = {npc:3789} Terrowulf Fleshripper
	["Take the tunnel into the {area:419}; the tome lies in the ruins at its west end. Careful: Terrowulf Fleshrippers and Shadow Weavers (28-30) stand in tight packs around the tome, and the {npc:3792}, a level 32 rare, walks the vale. Pull the wolves one at a time from the tunnel and let the Packlord pass first."] = "Nimm den Tunnel ins Gebiet {area:419}; der Foliant liegt in den Ruinen an seinem Westende. Vorsicht: Terrorwolf-Fleischreißer und Schattenweber (28-30) stehen in dichten Gruppen um den Folianten, und {npc:3792}, ein Rare der Stufe 32, läuft durch das Tal. Zieh die Wölfe einzeln aus dem Tunnel und lass den Rudelführer zuerst vorbeiziehen.",

	-- Step 93: Astranaar
	-- {npc:3691} Raene Wolfrunner · {npc:3961} Maliynn · {npc:3894} Pelturas Whitemoon
	["{npc:3691} and {npc:3961} are in the inn; {npc:3894} is inside the building just south of it."] = "{npc:3691} und {npc:3961} sind im Gasthaus; {npc:3894} ist im Gebäude direkt südlich davon.",
	-- {npc:3961} Maliynn
	["{npc:3961}, in the inn"] = "{npc:3961}, im Gasthaus",
	-- {npc:3894} Pelturas Whitemoon
	["{npc:3894}, inside the building south of the inn"] = "{npc:3894}, im Gebäude südlich des Gasthauses",

	-- Step 94: Raene Wolfrunner
	-- {zone:1440} Ashenvale · {npc:3691} Raene Wolfrunner · {quest:1025} An Aggressive Defense · {npc:3897} Krolg · {quest:1054} Culling the Threat · {npc:3987} Dal Bloodclaw · {area:413} Maestra's Post
	["Not done on your first {zone:1440} visit? {npc:3691} also has {quest:1025} (the Foulweald, on the way to {npc:3897}) and {quest:1054} ({npc:3987}, on the way back from {area:413})."] = "Nicht fertig bei deiner ersten {zone:1440}-Besichtigung? {npc:3691} hat auch {quest:1025} (das Foulweald, auf dem Weg zu {npc:3897}) und {quest:1054} ({npc:3987}, auf dem Weg zurück von {area:413}).",

	-- Step 95: The Foulweald
	["The Foulweald"] = "Die Fäulnisklauen",
	-- {npc:3897} Krolg · {area:415} Astranaar
	["On the way south-east to {npc:3897}: the Foulweald furbolgs live in the woods south of the road, south-east of {area:415}. The Den Watcher and the Ursas guard the den."] = "Auf dem Weg nach Südosten zu {npc:3897}: Die Faulgehölz-Furbolgs leben im Wald südlich der Straße, südöstlich von {area:415}. Der Höhlenwächter und die Ursas bewachen die Höhle.",

	-- Step 96: Mystral Lake
	-- {npc:3885} Sentinel Velene Starstrike · {area:420} Silverwind Refuge · {area:421} Mystral Lake · {npc:3897} Krolg · {npc:12759} Tideress
	-- plural, as words: Befouled Water Elementals = {npc:3917} Befouled Water Elemental
	["{npc:3885} stands at the {area:420} on the east shore of {area:421}, just north of the road to {npc:3897}. Befouled Water Elementals wade in the lake; {npc:12759}, a level 27 water elemental, walks among them and drops the bracers too."] = "{npc:3885} steht bei {area:420} am Ostufer von {area:421}, gleich nördlich der Straße zu {npc:3897}. Beschmutzte Wasserelementare waten im See; {npc:12759}, ein Wasserelementar der Stufe 27, läuft zwischen ihnen umher und lässt die Armschienen ebenfalls fallen.",
	-- {item:5456} Divining Scroll
	-- plural, as words: Intact Elemental Bracers = {item:12220} Intact Elemental Bracer
	["Kill the elementals for 5 Intact Elemental Bracers, then use the {item:5456}"] = "Töte die Elementare für 5 intakte Elementararmschienen und benutze dann {item:5456}",

	-- Step 97: Krolg
	-- {npc:3897} Krolg · {area:421} Mystral Lake · {item:5462} Dartol's Rod of Transformation
	["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below {area:421}. Use {item:5462} near him first: he only speaks to you in furbolg form."] = "{npc:3897}, ein Furbolg, den die Verderbnis nicht berührt hat, sitzt südlich der Straße unterhalb vom {area:421}. Benutze zuerst {item:5462} in seiner Nähe: Er spricht nur in Furbolggestalt mit dir.",

	-- Step 98: Ran Bloodtooth
	-- {npc:3696} Ran Bloodtooth · {npc:3897} Krolg
	["{npc:3696} and his guards camp just east of {npc:3897}.\nCareful: Wolves and spiders roam near the camp and can join a fight. Some of the wolves come in pairs."] = "{npc:3696} und seine Wachen lagern direkt östlich von {npc:3897}.\nVorsicht: Wölfe und Spinnen streifen in der Nähe des Lagers umher und können in einen Kampf eingreifen. Einige der Wölfe kommen paarweise.",
	-- {item:5388} Ran Bloodtooth's Skull · {npc:3696} Ran Bloodtooth
	["{item:5388}, from {npc:3696}"] = "{item:5388}, von {npc:3696}",

	-- Step 100: Melyria and Illiyana
	-- {npc:3897} Krolg · {area:416} Shrine of Aessina · {npc:3901} Illiyana
	["West from {npc:3897} along the southern hills to the {area:416}: Melyria and {npc:3901} stand together by it."] = "Von {npc:3897} nach Westen entlang der südlichen Hügel zum {area:416}: Melyria und {npc:3901} stehen zusammen dort.",
	-- {npc:3880} Sentinel Melyria Frostshadow · {npc:8026} Thyn'tel Bladeweaver · {zone:1457} Darnassus · {area:442} Auberdine
	["{npc:3880}: for {npc:8026} in {zone:1457}, a hop from {area:442} on the way to the boat"] = "{npc:3880}: für {npc:8026} in {zone:1457}, ein Sprung von {area:442} auf dem Weg zum Boot",

	-- Step 101: Illiyana
	-- {npc:3901} Illiyana
	["{npc:3901} stands beside Melyria."] = "{npc:3901} steht neben Melyria.",
	-- {npc:3901} Illiyana · {item:5461} Branch of Cenarius
	["{npc:3901}: the {item:5461}"] = "{npc:3901}: {item:5461}",

	-- Step 102: The Branch of Cenarius, taken alone
	-- {quest:1031} The Branch of Cenarius
	["{quest:1031}, taken alone"] = "{quest:1031}, allein angenommen",
	-- {quest:1031} The Branch of Cenarius · {npc:4619} Geltharis
	["Not grouped? {quest:1031} ({npc:4619}, 32) is a fight for a group at this level: abandon it, the route doesn't come back for it."] = "Nicht in einer Gruppe? {quest:1031} ({npc:4619}, 32) ist ein Kampf für eine Gruppe auf dieser Stufe: Brich sie ab, die Route kommt nicht dafür zurück.",

	-- Step 103: Insane Druids, taken alone
	-- {quest:1012} Insane Druids
	["{quest:1012}, taken alone"] = "{quest:1012}, allein angenommen",
	-- {quest:1012} Insane Druids · {area:432} The Dor'Danil Barrow Den
	["Not grouped? {quest:1012} (the {area:432}) is a fight for a group at this level: abandon it, the route doesn't come back for it."] = "Nicht in einer Gruppe? {quest:1012} ({area:432}) ist ein Kampf für eine Gruppe auf dieser Stufe: Brich sie ab, die Route kommt nicht dafür zurück.",

	-- Step 104: Delgren the Purifier
	-- {npc:3663} Delgren the Purifier · {quest:967} The Tower of Althalaxx · {zone:1439} Darkshore
	["{npc:3663}: {quest:967}, if you still carry it from {zone:1439}"] = "{npc:3663}: {quest:967}, falls du sie noch aus {zone:1439} dabeihast",

	-- Step 105: Delgren the Purifier
	-- {area:413} Maestra's Post
	["North to {area:413}."] = "Nach Norden nach {area:413}.",

	-- Step 106: Dal Bloodclaw
	-- {area:413} Maestra's Post · {area:415} Astranaar · {npc:3987} Dal Bloodclaw
	["From {area:413}, east to the Thistlefur camp north of {area:415}: {npc:3987} leads the furbolgs there. Then south to {area:415}.\nCareful: The furbolgs near him usually join in when he is pulled. Killing the ones along his path first lets you fight him alone."] = "Von {area:413} nach Osten zum Lager der Distelfelle nördlich von {area:415}: {npc:3987} führt dort die Furbolgs an. Dann nach Süden nach {area:415}.\nVorsicht: Die Furbolgs in seiner Nähe greifen meist mit ein, wenn du ihn ziehst. Töte zuerst die auf seinem Weg, dann kannst du ihn allein bekämpfen.",

	-- Step 107: Astranaar
	-- {area:413} Maestra's Post · {area:415} Astranaar · {npc:3691} Raene Wolfrunner
	["Back east along the road from {area:413} to {area:415}: {npc:3691} in the inn, the flight master at the west end."] = "Rückwärts die Straße von {area:413} nach {area:415}: {npc:3691} im Gasthaus, der Flugmeister am westlicken Ende.",

	-- Step 108: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "Flieg nach {area:442}",
	-- {area:415} Astranaar
	["{area:415} flight master"] = "Flugmeister von {area:415}",

	-- Step 109: Fly to Rut'theran Village
	-- {area:442} Auberdine · {area:702} Rut'theran Village
	["From {area:442}'s flight master, a short flight over the water to {area:702}."] = "Vom Flugmeister von {area:442} ein kurzer Flug über das Wasser zu {area:702}.",

	-- Step 110: Into Darnassus
	-- {area:702} Rut'theran Village · {zone:1457} Darnassus
	["Through the pink portal at {area:702}, up into {zone:1457}."] = "Durch den rosa Portal bei {area:702}, hinauf in {zone:1457}.",

	-- Step 111: Thyn'tel Bladeweaver
	-- {npc:8026} Thyn'tel Bladeweaver · {area:1660} Warrior's Terrace · {object:19877} Velinde's Locker
	["{npc:8026} stands on the {area:1660} in the north of the city; {object:19877} is in the south of it."] = "{npc:8026} steht auf dem {area:1660} im Norden der Stadt; {object:19877} liegt im Süden.",

	-- Step 112: Velinde's Locker
	-- {item:5520} Velinde's Journal · {object:19877} Velinde's Locker
	["{item:5520}, in {object:19877}"] = "{item:5520}, in {object:19877}",

	-- Step 113: Thyn'tel Bladeweaver
	-- {npc:8026} Thyn'tel Bladeweaver · {npc:3453} Wharfmaster Dizzywig · {area:392} Ratchet · {zone:1445} Dustwallow Marsh
	["{npc:8026}: for {npc:3453} in {area:392}, on your {zone:1445} trip at about 33 (30-40)"] = "{npc:8026}: für {npc:3453} in {area:392}, bei deiner Reise in {zone:1445} auf etwa Stufe 33 (30-40)",

	-- Step 114: Fly to Auberdine
	-- {area:702} Rut'theran Village · {area:442} Auberdine
	["Back through the portal to {area:702} and fly to {area:442} for the boat."] = " Durch das Portal zurück zu {area:702} und fliege zu {area:442} für das Boot.",

	-- Step 116: Caitlin Grassman
	-- {npc:1480} Caitlin Grassman
	["Off the boat, {npc:1480} stands beside Menethil's inn, on the way to the flight master."] = "Wenn du vom Boot kommst, steht {npc:1480} neben dem Gasthaus von Menethil, auf dem Weg zum Flugmeister.",

	-- Step 117: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Flieg nach {area:1537}",
	-- {npc:1571} Shellei Brondir
	["{npc:1571} is the flight master by Menethil's inn."] = "{npc:1571} ist der Flugmeister beim Gasthaus von Menethil.",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "Flugmeister von {area:150}",

	-- Step 119: High Explorer Magellas
	-- {quest:98824} Prehistoric Prism · {npc:5387} High Explorer Magellas · {object:32356} Hall of Explorers (no name in this language: may be words) · {object:32372} Great Forge (no name in this language: may be words)
	["{quest:98824}: {npc:5387} stands in the {object:32356}, north-east of the {object:32372}."] = "{quest:98824}: {npc:5387} steht in {object:32356}, nordöstlich von {object:32372}.",

	-- Step 120: Ironforge priests
	-- {zone:1455} Ironforge
	["{zone:1455} priests"] = "Priester in {zone:1455}",
	-- {npc:11406} High Priest Rohan · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward (no name in this language: may be words)
	["{npc:11406} and {npc:258785} are in the {object:32386}, in the {object:32362}."] = "{npc:11406} und {npc:258785} sind in {object:32386}, in {object:32362}.",

	-- Step 121: Sara Balloo
	-- {area:880} Thandol Span · {npc:2695} Sara Balloo · {zone:1455} Ironforge
	["Sully Balloo's letter, from the {area:880}: {npc:2695} takes it here in {zone:1455}."] = "Sully Balloo's Brief, von {area:880}: {npc:2695} nimmt ihn hier in {zone:1455}.",
	-- {npc:2695} Sara Balloo · {zone:1455} Ironforge
	["{npc:2695}: for King Magni, on the same {zone:1455} stop"] = "{npc:2695}: für König Magni, beim selben Halt in {zone:1455}",

	-- Step 122: King Magni Bronzebeard
	-- {npc:2784} King Magni Bronzebeard · {object:171709} High Seat
	["{npc:2784} holds court in the {object:171709}."] = "{npc:2784} hält Gericht in {object:171709}.",

	-- Step 123: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "Tiefenbahn nach {zone:1453}",

	-- Step 124: Baros Alexston
	-- {npc:1646} Baros Alexston · {object:2098} Cathedral Square
	["{npc:1646} stands in the {object:2098}."] = "{npc:1646} steht auf dem {object:2098}.",
	-- {npc:1646} Baros Alexston · {quest:97914} Expanding Horizons · {npc:3649} Thundris Windweaver
	["{npc:1646}: {quest:97914}, {npc:3649}'s letter, if you still carry it"] = "{npc:1646}: {quest:97914}, der Brief von {npc:3649}, falls du ihn noch dabeihast",

	-- Step 125: Grimand Elmore
	-- {object:28027} Dwarven District · {npc:1416} Grimand Elmore
	["The tram comes in at the {object:28027}: {npc:1416} works at the forge there."] = "Die Straßenbahn kommt an {object:28027}: {npc:1416} arbeitet dort am Schmieden.",
	-- {npc:1416} Grimand Elmore · {quest:322} Blessed Arm · {npc:1217} Glorin Steelbrow
	["{npc:1416}: {quest:322}, from {npc:1217} in Menethil"] = "{npc:1416}: {quest:322}, von {npc:1217} in Menethil",

	-- Step 126: Cathedral of Light
	["Cathedral of Light"] = "Kathedrale des Lichts",
	-- {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind · {object:28027} Dwarven District · {object:2098} Cathedral Square
	["Take the {area:2257} from {object:171524} to {zone:1453}'s {object:28027}, then walk to the {object:2098}."] = "Nimm {area:2257} von {object:171524} zu {object:28027} in {zone:1453} und geh dann zu {object:2098}.",
	-- {npc:4982} Thomas
	["{npc:4982}, in the Cathedral of Light"] = "{npc:4982}, in der Kathedrale des Lichts",

	-- Step 127: Archbishop Benedictus
	-- {quest:293} Cleansing the Eye · {npc:1217} Glorin Steelbrow · {npc:1284} Archbishop Benedictus
	["{quest:293}, from {npc:1217} in Menethil: {npc:1284} stands in the Cathedral of Light."] = "{quest:293}, von {npc:1217} in Menethil: {npc:1284} steht im Lichtdom.",

	-- Step 128: Stormwind Keep
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["Only if you looted {quest:337} in {zone:1431}"] = "Nur wenn du {quest:337} in {zone:1431} erbeutet hast",

	-- Step 129: Lord Grayson Shadowbreaker
	-- {npc:928} Lord Grayson Shadowbreaker
	["Back to the Cathedral of Light: {npc:928} stands inside."] = "Zurück zur Kathedrale des Lichts: {npc:928} steht drinnen.",
	-- {npc:2228} Lieutenant Farren Orinelle · {area:271} Southshore
	["For {npc:2228} in {area:271}: keep it"] = "Für {npc:2228} in {area:271}: behalte es",

	-- Step 130: Warden Thelwater
	-- {area:717} Stockade · {npc:1719} Warden Thelwater · {object:2098} Cathedral Square
	["For your {area:717} run: {npc:1719} keeps the {area:717}'s gate, south of the {object:2098}."] = "Für deinen Run durch {area:717}: {npc:1719} bewacht das Tor von {area:717}, südlich von {object:2098}.",

	-- Step 131: Warden Thelwater
	-- {npc:1719} Warden Thelwater · {quest:389} Bazil Thredd · {npc:1646} Baros Alexston
	["{npc:1719}: {quest:389}, from {npc:1646}"] = "{npc:1719}: {quest:389}, von {npc:1646}",

	-- Step 133: Stockade
	-- {area:717} Stockade · {npc:1719} Warden Thelwater · {object:2098} Cathedral Square · {npc:1663} Dextren Ward · {quest:389} Bazil Thredd
	["{area:717} is a dungeon for a group of five, about levels 23 to 29, and a run takes under an hour. Its gate is {npc:1719}'s, south of the {object:2098}.\nInside: the Defias prisoners, convicts and insurgents for Thelwater, {npc:1663}'s hand for Millstipe, and {quest:389} at the far end."] = "{area:717} ist ein Dungeon für eine Gruppe aus fünf Spielern, etwa Stufe 23 bis 29; ein Run dauert unter einer Stunde. Das Tor bewacht {npc:1719}, südlich von {object:2098}.\nDrinnen: die Gefangenen, Sträflinge und Aufständischen der Defias für Thelwater, die Hand von {npc:1663} für Millstipe und {quest:389} am hinteren Ende.",

	-- Step 134: Warden Thelwater
	-- {npc:1719} Warden Thelwater
	["{npc:1719}, at the gate"] = "{npc:1719}, am Tor",

	-- Step 136: Jorgen and Elling Trias
	-- {npc:4959} Jorgen · {npc:482} Elling Trias
	["{npc:4959} and {npc:482}"] = "{npc:4959} und {npc:482}",
	-- {npc:482} Elling Trias · {object:2096} Trade District
	["{npc:482}, the cheese shop in the {object:2096}"] = "{npc:482}, der Käseladen in {object:2096}",

	-- Step 137: Trade District
	-- {area:42} Darkshire
	["Next: fly to {area:42}."] = "Als Nächstes: Flieg nach {area:42}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Alexston's reply, if you still carry it (the route hands it in on 03-darkshore-return's first {area:442} stop)"] = "Alexstons Antwort, falls du sie noch bei dir hast (die Route gibt sie beim ersten Halt in {area:442} von 03-darkshore-return ab)",
	-- ["Flagon of Dwarven Honeymead, from {npc:1464}"] = "Flagon of Dwarven Honeymead, von {npc:1464}",
	-- ["For the Dragonmaw catapult, on the {zone:1437} loop of 30-40/01-hillsbrad-foothills"] = "Für die Drachenmaul-Katapulte, auf der Runde durch {zone:1437} in 30-40/01-hillsbrad-foothills",
	-- ["Hearth back to {area:150} if you bound at the {area:2104}, or walk west along the road: {npc:2104} stands on the top floor of {area:2103}, {npc:1217} in the {area:2104} south of it, {npc:2094} by the docks on the way to the boat."] = "Nutze den Ruhestein zurück nach {area:150}, wenn du im {area:2104} gebunden bist, oder geh die Straße nach Westen: {npc:2104} steht im obersten Stockwerk von {area:2103}, {npc:1217} im {area:2104} südlich davon, {npc:2094} bei den Docks auf dem Weg zum Boot.",
	-- ["Hearth back to {area:150} if you bound at the {area:2104}, or walk west along the road: {npc:2104} stands on the top floor of {area:2103}, {npc:2094} by the docks on the way to the boat."] = "Nutze den Ruhestein zurück nach {area:150}, wenn du in {area:2104} gebunden bist, oder geh die Straße nach Westen: {npc:2104} steht im obersten Stockwerk von {area:2103}, {npc:2094} bei den Docks auf dem Weg zum Boot.",
	-- ["Razormaw Incisors: from the raptors by the {area:1038}, on the {zone:1437} loop of 30-40/01-hillsbrad-foothills"] = "Razormaw Incisors: von den Raptoren beim {area:1038}, auf der Runde durch {zone:1437} in 30-40/01-hillsbrad-foothills",
	-- ["South from {npc:3987}'s camp to {area:415}: {npc:3691} in the inn, the flight master at the west end."] = "Von {npc:3987}s Lager nach Süden nach {area:415}: {npc:3691} im Gasthaus, der Flugmeister am Westende.",
	-- ["South-east along the road to {area:415}: {npc:3691} in the inn, the flight master at the west end."] = "Nach Südosten entlang der Straße nach {area:415}: {npc:3691} im Gasthaus, der Flugmeister am Westende.",
	-- ["Take the tunnel into the {area:419}; the tome lies in the ruins at its west end. Careful: Terrowulf Fleshrippers and Shadow Weavers (28-30) stand in tight packs around the tome, and the {npc:3792}, a level 32 rare, walks the vale. Pull the wolves one at a time from the tunnel and let the Packlord pass first."] = "Nimm den Tunnel ins Gebiet {area:419}; der Foliant liegt in den Ruinen an seinem Westende. Vorsicht: Terrowulf-Fleischreißer und -Schattenwirker (28-30) stehen in dichten Rudeln um den Folianten, und der {npc:3792}, ein seltener Gegner der Stufe 32, streift durch das Tal. Zieh die Wölfe einzeln vom Tunnel aus und lass den Rudelführer zuerst vorbeiziehen.",
	-- ["The Forsaken's camp lies in the woods south of {area:2358}.\nRusty chests lie around the Shadethicket furbolg camps west of the Forsaken; open them until one holds the pommel.\nCareful: Non-elite Forsaken of about level 28-30 guard the camp. Some of them are stealthed, and the ones around the table often aggro together."] = "Das Lager der Verlassenen liegt im Wald südlich von {area:2358}.\nRostige Truhen liegen rund um die Shadethicket-Furbolglager westlich der Verlassenen; öffne sie, bis eine den Knauf enthält.\nVorsicht: Nicht-Elite-Verlassene von etwa Stufe 28-30 bewachen das Lager. Einige von ihnen sind getarnt, und die am Tisch greifen oft gemeinsam an.",
	-- ["The captain walks the deck of the wrecked ship; his strongbox sits in the hold."] = "Der Kapitän wandelt auf dem Deck des Schiffswracks; seine Geldkassette steht im Laderaum.",
	-- ["The relics lie in the dig itself. {npc:1353}, a big Razormaw, prowls the raptor valley just west of it."] = "Die Relikte liegen in der Ausgrabung selbst. {npc:1353}, ein großer Scharfzahn, streift durch das Raptorental gleich westlich davon.",
	-- ["The relics lie in the dig itself. {npc:1353}, a big Razormaw, prowls the raptor valley just west of it.\nGoaz Warders (elite, 32) stand among the relics and the {object:331}: pull them away one at a time, or work around them."] = "Die Relikte liegen in der Grabung selbst. {npc:1353}, ein großer Razormaw, streift durch das Raptorental direkt westlich davon.\nGoaz Warders (Elite, 32) stehen zwischen den Relikten und der {object:331}: Zieh sie einzeln weg oder umgeh sie.",
	-- ["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} stands there."] = "{area:2358}, der Außenposten der Nachtelfen am Ostende der Straße: {npc:3848} steht dort.",
	-- ["{item:15885}: join the two halves"] = "{item:15885}: Füge die beiden Hälften zusammen",
	-- ["{npc:11406}: Chastise"] = "{npc:11406}: Züchtigen",
	-- ["{npc:1217}, in the {area:2104}"] = "{npc:1217}, im {area:2104}",
	-- ["{npc:2094}, by the docks, on the way to the boat"] = "{npc:2094}, bei den Docks, auf dem Weg zum Boot",
	-- ["{npc:2097}, by the north gate: {npc:1071} takes it on 30-40/01-hillsbrad-foothills' {area:205} stop"] = "{npc:2097}, beim Nordtor: {npc:1071} nimmt es beim Halt in {area:205} auf der Route 30-40/01-hillsbrad-foothills mit",
	-- ["{npc:3649}: Alexston's reply, if you took it in {zone:1453}"] = "{npc:3649}: Alexstons Antwort, falls du sie in {zone:1453} angenommen hast",
	-- ["{npc:3691}, in the inn"] = "{npc:3691}, im Gasthaus",
	-- ["{npc:3691}: {quest:1025}, the Foulweald on the way to {npc:3897}"] = "{npc:3691}: {quest:1025}, die Faulgehölz-Furbolgs auf dem Weg zu {npc:3897}",
	-- ["{npc:3691}: {quest:1054}, {npc:3987} on the way back from {area:413}"] = "{npc:3691}: {quest:1054}, {npc:3987} auf dem Rückweg von {area:413}",
	-- ["{npc:3693} stands by the flight master."] = "{npc:3693} steht beim Flugmeister.",
	-- ["{npc:3845} stands by {area:415}'s flight master."] = "{npc:3845} steht beim Flugmeister von {area:415}.",
	-- ["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below {area:421}."] = "{npc:3897}, ein Furbolg, den die Verderbnis nicht berührt hat, sitzt südlich der Straße unterhalb vom {area:421}.",
	-- ["{npc:4619} leads the {area:429} satyrs; he carries the branch."] = "{npc:4619} führt die Satyrn von {area:429} an; er trägt den Zweig.",
	-- ["{quest:98246}: the Razormaw eggs, on the same loop"] = "{quest:98246}: die Razormaw-Eier, auf derselben Runde",
	-- ["{quest:98283}, an elite raptor, on the {zone:1437} loop of 30-40/01-hillsbrad-foothills"] = "{quest:98283}, ein Elite-Raptor, auf der Runde durch {zone:1437} in 30-40/01-hillsbrad-foothills",
}
