-- German (deDE): the guide forever/horde/30-40/05-arathi-highlands (forever/horde/30-40/05-arathi-highlands.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "",

	-- Step 2: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "Lehrer in {zone:1458}",
	-- {zone:1458} Undercity · {object:36070} War Quarter · {object:36073} Rogues' Quarter · {object:36082} Magic Quarter · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "Trainiere, solange du in {zone:1458} bist: Die Lehrer stehen im {object:36070}, im {object:36073} und im {object:36082} (Paladine: {npc:260093}).",

	-- Step 3: Fly to Tarren Mill
	-- {object:1772} Tarren Mill (no name in this language: may be words)
	["Fly to {object:1772}"] = "",
	-- {zone:1458} Undercity
	["{zone:1458} flight master"] = "",

	-- Step 4: Tarren Mill
	-- {npc:2229} Krusk
	["{npc:2229}, inside the inn"] = "",

	-- Step 6: Gol'dir
	-- {npc:2431} Jailor Borhuin · {item:3704} Rusted Iron Key · {quest:503} Gol'dir
	["Head north past Valik's camp to Strahnbrad, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side.\nCareful: Stealthed Syndicate spies roam Strahnbrad, and the buildings hold many Syndicate mobs, mages among them."] = "",
	["Inside"] = "",
	-- {quest:503} Gol'dir
	["{quest:503}, on the top floor"] = "",

	-- Step 8: Tarren Mill
	-- {npc:2229} Krusk · {object:1772} Tarren Mill (no name in this language: may be words)
	["{npc:2229} waits inside the inn at {object:1772}, back south down the road."] = "",
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "",

	-- Step 9: Alterac Mountains
	["Perenolde manor"] = "",

	-- Step 10: Lord Aliden Perenolde
	-- {quest:507} Lord Aliden Perenolde · {npc:2317} Elysa
	["Head north-west through the mountains to the Perenolde manor on the northern shore of Lordamere Lake. {quest:507} (41) waits in a room upstairs: he shields himself, puts you to sleep and heals below half health. {npc:2317} stands beside him."] = "",

	-- Step 11: Old Dalaran Ruins: kill these as you meet them
	["Old Dalaran Ruins: kill these as you meet them"] = "",
	-- plural, as words: Dalaran Summoners = {npc:2358} Dalaran Summoner · Elemental Slaves = {npc:2359} Elemental Slave
	["South along the lake shore to the ruins around the Dalaran crater. The Dalaran Summoners lead Elemental Slaves; the bracers drop from the slaves."] = "",

	-- Step 13: Tarren Mill
	-- {object:1772} Tarren Mill (no name in this language: may be words)
	["Head back east to {object:1772}."] = "",
	-- {npc:2437} Keeper Bel'varil
	["{npc:2437}, inside"] = "",
	-- {npc:2410} Magus Wordeen Voidglare
	["{npc:2410}, inside"] = "",
	["The magus offers a dungeon errand next: leave it."] = "",

	-- Step 15: Northfold Manor
	["Northfold Manor"] = "",
	-- {object:1772} Tarren Mill (no name in this language: may be words)
	-- plural, as words: Bloodstone Amulets = {item:4495} Bloodstone Amulet
	["Head east out of {object:1772} through Thoradin's Wall. The Syndicate hold the walled manor and its farm north of the road; their Highwaymen, Mercenaries and Pathstalkers carry the Bloodstone Amulets.\nCareful: Highwaymen (level 30-31) can be in Sneak, so they may be hidden when you approach."] = "",

	-- Step 16: The Shards of Myzrael
	-- {object:138492} Shards of Myzrael
	["The {object:138492}"] = "{object:138492}",
	["Follow the road east. The violet shards glow just off the road a short way west of Hammerfall."] = "",

	-- Step 17: Hammerfall
	["Hammerfall"] = "",
	-- {npc:12920} Doctor Gregory Victor
	["{npc:12920}, at the south gate"] = "",

	-- Step 18: Stromgarde quests for a group
	["Stromgarde quests for a group"] = "",
	-- {npc:2703} Zengu · {quest:639} Sigil of Strom
	["{npc:2703}'s {quest:639} drops from the elite Syndicate (35-38) in Stromgarde's ruins, the west of the highlands. Great XP if you have a group for it: the route passes Stromgarde on its way to the inner circle."] = "",

	-- Step 19: Foul Magics with a group
	-- {quest:671} Foul Magics
	["{quest:671} with a group"] = "",
	-- {npc:2706} Tor'gan · {quest:671} Foul Magics · {npc:2783} Marez Cowl
	["{npc:2706}'s next {quest:671} is {npc:2783}, a level 40 elite warlock in Stromgarde's Syndicate quarter."] = "",

	-- Step 20: Drywhisker Gorge
	["Drywhisker Gorge"] = "",
	["North-east of Hammerfall the Drywhisker kobolds mine the gorge; the Kobolds at the mouth and the Diggers and Surveyors deeper in all drop the Motes of Myzrael.\nCareful: Every kobold type runs off for help when low on health (Kobolds at 30%, Surveyors and Diggers at 15%), which can pull more of them."] = "",

	-- Step 21: Iridescent Shards
	-- {object:2701} Iridescent Shards
	["The {object:2701} lie at the far end of the gorge."] = "{object:2701} liegen am hinteren Ende der Schlucht.",
	["Below ground"] = "",

	-- Step 22: The Stone of East Binding
	-- {object:2691} Stone of East Binding
	["The {object:2691}"] = "{object:2691}",
	-- {object:180105} Circle of Binding
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["Each {object:180105} is a ring of standing stones; the key sits on the stone at its heart. The eastern circle is on the hills north-west of Hammerfall.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "",

	-- Step 23: Boulderfist Hall
	["Boulderfist Hall"] = "",
	-- plural, as words: Boulderfist Brutes = {npc:2566} Boulderfist Brute
	["The Boulderfist Brutes camp outside the ogres' hall south of Hammerfall; the Magus stand among them. Pull them one at a time."] = "",

	-- Step 24: Fleshstalker raptors
	["Fleshstalker raptors"] = "Hochlandfleischpirscher",
	-- plural, as words: Highland Fleshstalkers = {npc:2561} Highland Fleshstalker
	["Highland Fleshstalkers (36-37) hunt the southern highlands, a pack north of Boulderfist Hall and another on the plain to its west. Pull them one at a time."] = "",

	-- Step 25: Go'shek Farm
	["Go'shek Farm"] = "",
	-- {npc:2733} Apothecary Jorell · {item:278462} Packaged Tonics
	["{npc:2733}'s lab shack stands at Go'shek Farm, south-west of the raptors' plain; the case of {item:278462} is inside."] = "",

	-- Step 26: Back to Hammerfall
	["Back to Hammerfall"] = "",
	["Back north-east to Hammerfall."] = "",

	-- Step 27: Boulderfist quests for a group
	["Boulderfist quests for a group"] = "",
	-- {npc:2771} Drum Fel · {quest:678} Call to Arms · {npc:2772} Korin Fel · {quest:680} The Real Threat
	["{npc:2771}'s next {quest:678} and {npc:2772}'s {quest:680} are the elite ogres (38-40) in Stromgarde's ogre quarter, on the same group trip as the Sigil."] = "",
	-- {npc:2772} Korin Fel
	["{npc:2772}, beside him"] = "",

	-- Step 28: The Stone of Outer Binding
	-- {object:2690} Stone of Outer Binding
	["The {object:2690}"] = "{object:2690}",
	["Head west; the outer circle stands in the middle of the highlands."] = "",

	-- Step 29: Circle of West Binding
	["Circle of West Binding"] = "",
	["The western circle is near Thoradin's Wall, north-west of the outer one."] = "",

	-- Step 30: The Stone of Inner Binding
	-- {object:2702} Stone of Inner Binding
	["The {object:2702}"] = "{object:2702}",
	["The inner circle lies south of the western circle, east of Stromgarde."] = "Der innere Kreis liegt südlich des westlichen Kreises, östlich von Stromgarde.",
	["The stone's next task needs Fozruk, a level 42 elite who roams west of Hammerfall: leave it."] = "",

	-- Step 31: Stromgarde
	["Stromgarde"] = "",
	-- {npc:2783} Marez Cowl · {npc:2773} Or'Kalar
	["West of the inner circle, Stromgarde's ruins: the Syndicate hold the east half (the Sigil drops from their Conjurors, Prowlers and Magi; {npc:2783} is among them), the Boulderfist the west half by the Tower of Arathor ({npc:2773} waits in one of the roofless houses beside it)."] = "",

	-- Step 32: Faldir's Cove
	["Faldir's Cove"] = "",
	-- {npc:2766} Lolo the Lookout
	["Head south to the goblins' cove on the southern coast. {npc:2766} keeps watch on the cliff above it."] = "",

	-- Step 33: Professor Phizzlethorpe
	["Escort the professor up the hill to the cave above the cove and guard him while he works. Two level 40 water elementals ambush him there, and they are immune to frost. Hold them at the cave mouth, away from him: if the fight happens inside the cave, he joins in instead of working and more elementals keep coming."] = "",

	-- Step 35: The Drowned Reef: kill these as you meet them
	["The Drowned Reef: kill these as you meet them"] = "",
	-- plural, as words: Daggerspine Raiders = {npc:2595} Daggerspine Raider
	["West of the cove the Daggerspine Raiders and Sorceresses (38-40) hold the shore: pull them one at a time. The two wrecks lie in the shallows off it, the charts and logs inside them; the gems lie on the sea floor around the wrecks."] = "Westlich der Bucht halten die Räuber und Zauberhexerinnen der Säbelflossen (38-40) das Ufer: Zieh sie einzeln. Die beiden Wracks liegen davor im seichten Wasser, die Karten und Logbücher darin; die Edelsteine liegen um die Wracks auf dem Meeresgrund.",
	["Underwater"] = "",

	-- Step 36: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {object:3204} Booty Bay (no name in this language: may be words)
	["for {npc:2487} in {object:3204}, around level 41"] = "",
	-- {object:2673} Thandol Span (no name in this language: may be words) · {zone:1437} Wetlands · {zone:1418} Badlands
	["The next guide crosses the {object:2673} into the {zone:1437} and heads for the {zone:1418}."] = "",

	-- Step 37: Back to Hammerfall
	-- {object:2673} Thandol Span (no name in this language: may be words)
	["Only if you ran Stromgarde with a group: back to Hammerfall for its hand-ins, then on to the {object:2673}."] = "",
}
