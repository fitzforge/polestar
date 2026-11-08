-- German (deDE): the guide forever/alliance/50-60/05-silithus (forever/alliance/50-60/05-silithus.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Ratchet
	-- {area:541} Marshal's Refuge · {area:392} Ratchet
	["Fly from {area:541} to {area:392}."] = "",
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}, inside"] = "",

	-- Step 2: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "",

	-- Step 3: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Flieg nach {zone:1453}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "",

	-- Step 4: Stormwind
	-- {area:392} Ratchet · {area:35} Booty Bay · {zone:1453} Stormwind
	["Take the boat from {area:392} to {area:35} and fly to {zone:1453}."] = "Nimm das Boot von {area:392} nach {area:35} und flieg nach {zone:1453}.",
	-- {npc:3520} Ol' Emma
	["{npc:3520}, who walks the canals"] = "{npc:3520}, der an den Kanälen entlanggeht",
	-- {npc:10778} Janice Felstone
	["For {npc:10778}: keep it"] = "Für {npc:10778}: Behalte es",

	-- Step 5: Stormwind Keep
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, in SI:7"] = "{npc:332}, bei SI:7",
	-- {quest:6184} Flint Shadowmore · {area:3197} Chillwind Camp
	["{quest:6184} at {area:3197}: keep it"] = "{quest:6184} bei {area:3197}: Behalte es",

	-- Step 6: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "",

	-- Step 7: Ironforge
	["Its jars are filled on the next Un'Goro visit"] = "Die Gefäße werden beim nächsten Besuch in Un'Goro gefüllt",
	-- {npc:14724} Bubulo Acerbus
	["{npc:14724}, by the tram"] = "{npc:14724}, bei der Bahn",

	-- Step 8: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "Flieg zur {area:2268}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "",

	-- Step 9: Light's Hope Chapel
	-- {npc:11038} Caretaker Alen · {area:2627} Terrordale
	["{npc:11038}, by the graves south of the chapel: Egan is in {area:2627}, keep it"] = "",

	-- Step 10: Scourge Champions
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions"] = "Champions der Geißel",
	-- {area:2270} Noxious Glade · {area:2268} Light's Hope Chapel · {npc:11063} Carlin Redpath · {item:13156} Mystic Crystal
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions (59) roam the {area:2270}, north of {area:2268}. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants. Pull them one at a time."] = "Champions der Geißel (59) streifen durch {area:2270}, nördlich der {area:2268}. Halte {npc:11063}s {item:13156} über jeden, den du tötest: Die Schädel, die mitschwingen, sind die, die er will. Zieh sie einzeln.",
	-- {item:13155} Resonating Skull
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["{item:13155}, from the Scourge Champions"] = "{item:13155}, von den Champions der Geißel",

	-- Step 11: Light's Hope Chapel
	["Chromie in Andorhal: keep it"] = "Chromie in Andorhal: Behalte es",

	-- Step 12: Infiltrator Hameya
	-- {area:2277} Plaguewood · {area:2273} Zul'Mashar
	["Ride north to the {area:2277}'s north-eastern edge.\nCareful: The trolls along the path to {area:2273} are level 57-59. They run away at low health and call for help, so they often bring adds with them."] = "",

	-- Step 13: The Undercroft
	-- {area:2261} The Undercroft · {npc:11886} Mercutio Filthgorger
	["Ride south-west to the {area:2261}. The mound of dirt lies inside. {npc:11886} is elite: grouping up is advised.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "",
	-- {item:14613} Taelan's Hammer · {npc:11886} Mercutio Filthgorger
	["{item:14613}, from {npc:11886}"] = "{item:14613}, von {npc:11886}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Chromie in Andorhal: keep it"] = "Chromie in Andorhal: Behalte es",
	-- ["Dredge Crushers dig further west; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "Baggerbrecher graben weiter westlich; Steinpanzerzangen, Steinpanzerschinder und Felspirscher jagen im selben Sand.",
	-- ["Dredge Strikers dig in the dunes north-west of the hold; Stonelash Scorpids and Sand Skitterers roam all around."] = "Baggerschläger graben in den Dünen nordwestlich der Burg; Steinpanzerskorpide und Sandhuscher streifen überall umher.",
	-- ["Dredge and scorpids"] = "Bagger und Skorpide",
	-- ["Fly from {area:976} to {area:541}. {npc:8737}'s hut stands at the {area:538}, west of the refuge; {npc:9117} is up the hill behind it."] = "Flieg von {area:976} nach {area:541}. Die Hütte von {npc:8737} steht bei {area:538}, westlich der Zuflucht; {npc:9117} ist den Hügel dahinter hinauf.",
	-- ["Fly to {area:271} and ride north up the road toward Alterac: Haggerdin camps at {area:1056} beside it."] = "Flieg nach {area:271} und reite die Straße nach Norden Richtung Alterac: Haggerdin lagert bei {area:1056} daneben.",
	-- ["For {area:3197}: keep it"] = "Für {area:3197}: Behalte es",
	-- ["For {npc:10778}: keep it"] = "Für {npc:10778}: Behalte es",
	-- ["For {zone:1448}: keep it"] = "Für {zone:1448}: Behalte es",
	-- ["From {area:392}, fly to {area:976}."] = "Flieg von {area:392} nach {area:976}.",
	-- ["Its jars are filled on the next Un'Goro visit"] = "Die Gefäße werden beim nächsten Besuch in Un'Goro gefüllt",
	-- ["On {npc:7583}"] = "Bei {npc:7583}",
	-- ["Ride back to {area:3425} and fly to {area:392}."] = "Reite zurück nach {area:3425} und flieg nach {area:392}.",
	-- ["Ride east to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "Reite nach Osten zum Turm von {area:2742} in {area:2738}; klettere hinauf und töte die Angreifer, die beim Verkrusteten Silithidenobjekt auftauchen.",
	-- ["Ride east to {npc:13220}."] = "Reite nach Osten zu {npc:13220}.",
	-- ["Ride north to the {area:2277}'s north-eastern edge."] = "Reite nach Norden zum nordöstlichen Rand von {area:2277}.",
	-- ["Ride on north to {area:3197} and fly to {area:2268}."] = "Reite weiter nach Norden zum {area:3197} und flieg zur {area:2268}.",
	-- ["Ride out of the crater's north-western pass into {zone:1451} and on to {area:3425}."] = "Reite durch den Nordwestpass des Kraters hinaus nach {zone:1451} und weiter nach {area:3425}.",
	-- ["Ride south-west to the {area:2261}. The mound of dirt lies inside. {npc:11886} is elite: grouping up is advised."] = "Reite nach Südwesten zum {area:2261}. Der Erdhaufen liegt drinnen. {npc:11886} ist Elite: Eine Gruppe wird empfohlen.",
	-- ["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Reite nach Südwesten zum Lager von {npc:7771} bei {area:1938}.",
	-- ["Scourge Champions"] = "Champions der Geißel",
	-- ["Sixty {item:2592}, if you carry them"] = "Sechzig {item:2592}, falls du sie dabeihast",
	-- ["Take the {area:2257} to {zone:1455}."] = "Nimm die {area:2257} nach {zone:1455}.",
	-- ["Tar Beasts wallow in the {area:538}; the fire elementals of {area:537} in the middle carry the ash; the Gorishi wasps of the {area:540} in the south carry the gland. Every creature in the crater can drop {item:11018}."] = "Teerbestien suhlen sich in {area:538}; die Feuerelementare des {area:537} in der Mitte tragen die Asche; die Wespen der Gorishi in {area:540} im Süden tragen die Drüse. Jede Kreatur im Krater kann {item:11018} fallen lassen.",
	-- ["The crater"] = "Der Krater",
	-- ["The next guide starts here in {area:392}."] = "Der nächste Guide beginnt hier in {area:392}.",
	-- ["The tortured druids and sentinels haunt the ruined village south-west of {npc:13220}."] = "Die Gequälten Druiden und Schildwachen spuken im verfallenen Südwindposten südwestlich von {npc:13220}.",
	-- ["The western dunes"] = "Die westlichen Dünen",
	-- ["The {area:2742} tower"] = "Der Turm von {area:2742}",
	-- ["Umber in {zone:1450}: keep it"] = "Umber in {zone:1450}: Behalte es",
	-- ["grind on {npc:8532} at the {area:2258}, {zone:1423}"] = "Grinde an {npc:8532} im {area:2258}, {zone:1423}",
	-- ["{item:13155}, from the Scourge Champions"] = "{item:13155}, von den Champions der Geißel",
	-- ["{item:14613}, from {npc:11886}"] = "{item:14613}, von {npc:11886}",
	-- ["{npc:14724}, by the tram"] = "{npc:14724}, bei der Bahn",
	-- ["{npc:332}, in SI:7"] = "{npc:332}, bei SI:7",
	-- ["{npc:3520}, who walks the canals"] = "{npc:3520}, der an den Kanälen entlanggeht",
	-- ["{npc:9299} waits at the graveyard just east of town; the gravestone stands nearby."] = "{npc:9299} wartet auf dem Friedhof gleich östlich des Orts; der Grabstein steht in der Nähe.",
	-- ["{quest:3444} is in {area:392}"] = "{quest:3444} ist in {area:392}",
}
