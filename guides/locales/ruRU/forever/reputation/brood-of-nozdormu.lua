-- Russian (ruRU): the guide forever/reputation/brood-of-nozdormu (forever/reputation/brood-of-nozdormu.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Brood of Nozdormu Reputation"] = "Репутация: Род Ноздорму",
	["The Bronze Dragonflight's ring, upgraded at every standing; a long climb from Hated, mostly in raids."] = "Кольцо бронзовых драконов улучшается на каждом уровне репутации; долгий путь от ненависти, в основном в рейдах.",
	-- {item:21175} The Scepter of the Shifting Sands
	["{item:21175} quest chain"] = "Цепочка заданий {item:21175}",

	-- Step 1: Baristolth in Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Baristolth in {area:3425}"] = "",
	-- {faction:910} Brood of Nozdormu · {npc:15192} Anachronos · {npc:15180} Baristolth of the Shifting Sands · {area:3425} Cenarion Hold · {area:2677} Blackwing Lair · {area:16076} Temple of Ahn'Qiraj
	["The {faction:910} is not in your reputation list until you meet {npc:15192}. {npc:15180}, in the main building of {area:3425}, sends you to him. Meeting him sets you at Hated, 0 of 36,000: Neutral is 42,000 reputation away, and almost all of it comes from raids. {area:2677} and the {area:16076} are not among the first raids Blizzard has announced for Forever: until one of them opens, the 100 from Baristolth's first quest is all the Brood reputation there is. The Legacy perk Diplomat adds up to 10% to every gain; the numbers in this guide are without it."] = "",

	-- Step 2: Anachronos at the Caverns of Time
	-- {npc:15192} Anachronos · {area:2300} Caverns of Time
	["{npc:15192} at the {area:2300}"] = "",
	-- {npc:15192} Anachronos · {area:2300} Caverns of Time · {zone:1446} Tanaris · {area:976} Gadgetzan
	["{npc:15192}, a bronze dragon in elf form, stands at the mouth of the {area:2300} in eastern {zone:1446}, south-east of {area:976}. Walk up to him."] = "",
	-- {npc:15192} Anachronos
	["Meet {npc:15192}"] = "",

	-- Step 3: Back to Baristolth
	["Back to Baristolth"] = "",
	-- {quest:8288} Only One May Rise · {npc:12017} Broodlord Lashlayer · {area:2677} Blackwing Lair · {area:254} Blackrock Mountain · {quest:8286} What Tomorrow Brings
	["{quest:8288} wants the head of {npc:12017}, the third boss of {area:2677} (a 40-player raid in {area:254}). Everything after it needs the head, the fragment turn-ins included: until you have it, {quest:8286} is all the Brood reputation there is, solo or not."] = "",

	-- Step 4: Broodlord Lashlayer
	-- {area:2677} Blackwing Lair · {area:254} Blackrock Mountain · {npc:12017} Broodlord Lashlayer
	["{area:2677} is a 40-player raid at the top of {area:254}. {npc:12017} always drops his head."] = "",
	-- {item:20383} Head of the Broodlord Lashlayer
	["{item:20383}: raid of 40"] = "",

	-- Step 5: The Path of the Righteous
	-- {quest:8301} The Path of the Righteous · {area:3425} Cenarion Hold · {area:2743} Hive'Zora · {area:2744} Hive'Regal
	-- plural, as words: Silithid Carapace Fragments = {item:20384} Silithid Carapace Fragment · Hive'Ashi Workers = {npc:11721} Hive'Ashi Worker
	["{quest:8301} wants 200 Silithid Carapace Fragments. Every hive silithid drops one to three on most kills: the Hive'Ashi Workers, Stingers, Swarmers and Defenders north and north-west of {area:3425}, and those of {area:2743} in the west and {area:2744} in the south. Almost all of them are elites of level 57 to 60: one at a time solo, faster in a group."] = "",

	-- Step 6: Hated to Neutral
	["Hated to Neutral"] = "",
	-- {quest:8302} The Hand of the Righteous · {area:16076} Temple of Ahn'Qiraj · {item:21230} Ancient Qiraji Artifact · {item:21229} Qiraji Lord's Insignia
	["After The Path, Baristolth takes 200 more fragments for {quest:8302}: 200 reputation, again and again, but only until Neutral. From Hated 500 that is 208 turn-ins, 41,600 fragments, 20,000 to 30,000 elite kills: the only way without the Temple, and a very long one. With the {area:16076} open (a 40-player raid) it is far quicker: every Temple trash mob gives 100 until 2,999 of 3,000 Neutral, about 9,500 a full clear, so four to five clears reach Neutral. Save every {item:21230} and {item:21229} you loot until the trash stops counting: they pay the same later."] = "",
	-- {quest:8302} The Hand of the Righteous
	["{quest:8302}: 200 fragments, 200"] = "",

	-- Step 7: Anachronos's quests
	-- {quest:8303} Anachronos
	["{quest:8303}'s quests"] = "",
	-- {quest:8303} Anachronos
	["Neutral opens the rest of the Scepter of the Shifting Sands chain. Baristolth sends you back to {quest:8303}."] = "",

	-- Step 9: The Crystalline Tear
	-- {object:180633} Crystalline Tear
	["The {object:180633}"] = "",
	-- {object:180633} Crystalline Tear · {area:3428} Ahn'Qiraj · {zone:1451} Silithus
	["The {object:180633} is a small red crystal on the ground just outside the gates of {area:3428}, in the far south-west of {zone:1451}. Click it, then stay and watch the vision of the War of the Shifting Sands to its end. If it is cut short, abandon the quest and click the Tear again."] = "",
	["Watch the vision"] = "",

	-- Step 10: The Charge of the Dragonflights
	-- {npc:15192} Anachronos · {item:21200} Signet Ring of the Bronze Dragonflight · {quest:8555} The Charge of the Dragonflights
	["{npc:15192} now offers the {item:21200} in three kinds: the Path of the Protector (tanks), of the Conqueror (melee fighters) or of the Invoker (casters). Take one: the other two close. Each standing from Friendly to Exalted brings an upgrade of the same ring, 100 reputation each. {quest:8555} sends you after the three shards of the Scepter of the Shifting Sands."] = "",
	["Pick one: The Path of the Protector, the Conqueror or the Invoker, 100"] = "",

	-- Step 11: The red shard: Vaelastrasz
	["The red shard: Vaelastrasz"] = "",
	-- {npc:13020} Vaelastrasz the Corrupt · {area:2677} Blackwing Lair · {quest:8730} Nefarius's Corruption · {item:21138} Red Scepter Shard
	["The red shard: {npc:13020}, the second boss of {area:2677}, gives {quest:8730} before his fight; Nefarian, the last boss, drops the {item:21138} for one raider on the quest each kill. The quest lasts five hours."] = "",
	-- {npc:13020} Vaelastrasz the Corrupt · {area:2677} Blackwing Lair
	["{npc:13020}, {area:2677}: raid of 40"] = "",
	-- {item:21138} Red Scepter Shard
	["{item:21138}, Nefarian"] = "",

	-- Step 12: The blue shard: Azuregos's ledger
	["The blue shard: Azuregos's ledger"] = "",
	-- {npc:15481} Spirit of Azuregos · {zone:1447} Azshara · {npc:11811} Narain Soothfancy · {zone:1446} Tanaris
	["The {npc:15481} stands on the south coast of {zone:1447}. His ledger starts {npc:11811}'s long chain in {zone:1446}."] = "",

	-- Step 13: Narain Soothfancy
	-- {npc:11811} Narain Soothfancy · {area:976} Gadgetzan · {zone:1421} Silverpine Forest · {zone:1446} Tanaris · {npc:8125} Dirge Quikcleave
	["{npc:11811}, a goblin seer, lives in a hut north-east of {area:976}. He sends you three ways at once: to Stewvul's crate in {zone:1421}, to an island off the south coast of {zone:1446}, and to {npc:8125} in {area:976}."] = "",

	-- Step 14: Stewvul's crate
	["Stewvul's crate"] = "",
	-- {object:180642} Inconspicuous Crate · {area:230} Greymane Wall · {zone:1421} Silverpine Forest
	["The {object:180642} leans on the {area:230} at the south end of {zone:1421}, left of the closed gate."] = "",

	-- Step 15: Meridith the Mermaiden
	-- {object:180652} Freshly Dug Dirt · {area:987} Land's End Beach · {npc:15526} Meridith the Mermaiden · {quest:8599} Love Song for Narain
	["The {object:180652} lies on the farther of two islands south of {area:987}, past the fatigue line. {npc:15526}, on the sea floor south of the beach's crashed gyrocopter, gives {quest:8599} and a three-minute swim-speed blessing that gets you across."] = "",

	-- Step 16: The island off Land's End Beach
	-- {area:987} Land's End Beach
	["The island off {area:987}"] = "",

	-- Step 17: Back to Narain Soothfancy
	-- {npc:11811} Narain Soothfancy
	["Back to {npc:11811}"] = "",
	-- {quest:8606} Decoy! · {npc:11811} Narain Soothfancy · {area:2255} Everlook · {zone:1452} Winterspring · {npc:15554} Number Two
	["{quest:8606} sends you, disguised with {npc:11811}'s turban, to a drop-off point south of {area:2255} in {zone:1452}. Leave the bag of gold there: {npc:15554}, a level 61 elite, comes for it (group of 3 to 5)."] = "",

	-- Step 18: Decoy!
	-- {npc:15554} Number Two
	["{npc:15554}, elite: group of 3 to 5"] = "",

	-- Step 19: Dirge Quikcleave
	-- {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {area:1121} Isle of Dread · {zone:1444} Feralas
	["{npc:8125} cooks in {area:976}. He sends you to the {area:1121} off southern {zone:1444} for a Chimaerok feast."] = "",

	-- Step 20: The Isle of Dread
	-- {area:1121} Isle of Dread
	["The {area:1121}"] = "",
	-- {npc:12803} Lord Lakmaeran · {area:1121} Isle of Dread
	["{npc:12803} and the Chimaerok on the {area:1121} are elites of level 60 to 62 that respawn every ten minutes: a raid's work. The Chimaerok drop a tenderloin about half the time, Lakmaeran two to four now and then."] = "",
	-- {item:21027} Lakmaeran's Carcass · {npc:12803} Lord Lakmaeran
	["{item:21027}, {npc:12803}: raid"] = "",

	-- Step 21: Draconic for Dummies, Volume II
	-- {quest:8597} Draconic for Dummies
	["{quest:8597}, Volume II"] = "",
	-- {quest:8620} The Only Prescription · {quest:8597} Draconic for Dummies · {npc:15552} Doctor Weavil · {area:2079} Alcaz Island · {zone:1419} Blasted Lands · {area:2255} Everlook · {zone:1458} Undercity · {npc:11811} Narain Soothfancy
	-- plural, as words: Felguard Elites = {npc:8717} Felguard Elite · Doomguard Commanders = {npc:12396} Doomguard Commander
	["{quest:8620} needs the eight chapters of {quest:8597}, Volume II: from {npc:15552} in his house on {area:2079} (a level 63 elite with guards, raid), the Felguard Elites, Doomguard Commanders and Dreadlords of the {zone:1419}, the Hederine south of {area:2255}, and a book in the {zone:1458}. {npc:11811} hands out the binding when you accept."] = "",
	-- {quest:8597} Draconic for Dummies
	["{quest:8597}: Volume II"] = "",

	-- Step 22: Dirge Quikcleave's Chops
	-- {npc:8125} Dirge Quikcleave
	["{npc:8125}'s Chops"] = "",
	-- {npc:8125} Dirge Quikcleave · {item:9061} Goblin Rocket Fuel · {item:8150} Deeprock Salt · {npc:11811} Narain Soothfancy · {item:18562} Elementium Ore · {item:21136} Arcanite Buoy · {object:180669} Swirling Maelstrom (no name in this language: may be words) · {zone:1447} Azshara · {area:1227} Bay of Storms · {npc:15571} Maws · {item:21137} Blue Scepter Shard
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar · Azerothian Diamonds = {item:12800} Azerothian Diamond · Blue Sapphires = {item:12361} Blue Sapphire
	["{npc:8125} wants 20 {item:9061} and 20 {item:8150} with the meat. {npc:11811} then wants 20 Arcanite Bars, 10 {item:18562}, 10 Azerothian Diamonds and 10 Blue Sapphires, and gives you an {item:21136}: placed at the {object:180669} in {zone:1447}'s {area:1227}, it calls up {npc:15571}, a level 63 boss for a raid. {npc:15571} drops the {item:21137} for one raider on the quest each kill."] = "",
	-- {item:12360} Arcanite Bar
	["{item:12360}: Alchemists, or the auction house"] = "",
	-- {item:18562} Elementium Ore · {area:2677} Blackwing Lair
	["{item:18562}: {area:2677}, or the auction house"] = "",

	-- Step 23: Maws
	-- {item:21137} Blue Scepter Shard · {npc:15571} Maws
	["{item:21137}, {npc:15571}: raid"] = "",

	-- Step 24: The green shard: Eranikus
	["The green shard: Eranikus"] = "",
	-- {npc:15362} Malfurion Stormrage · {npc:5709} Shade of Eranikus · {area:1477} Temple of Atal'Hakkar · {npc:15624} Forest Wisp · {zone:1457} Darnassus · {npc:11832} Keeper Remulos · {zone:1450} Moonglade
	["{npc:15362} appears beside the {npc:5709} at the bottom of the {area:1477} (a five-player dungeon). He sends you to a {npc:15624} outside {zone:1457} (Horde players walk past the city's guards), then to {npc:11832} in {zone:1450}."] = "",
	-- {npc:15362} Malfurion Stormrage · {area:1477} Temple of Atal'Hakkar
	["{npc:15362}, inside the {area:1477}"] = "",

	-- Step 25: The Forest Wisp
	-- {npc:15624} Forest Wisp
	["The {npc:15624}"] = "",
	-- {npc:15624} Forest Wisp
	["{npc:15624}: 25 (and 25 Cenarion Circle)"] = "",

	-- Step 26: Keeper Remulos
	-- {quest:8735} The Nightmare's Corruption · {zone:1440} Ashenvale · {zone:1444} Feralas · {zone:1425} Hinterlands · {npc:15625} Twilight Corrupter · {zone:1431} Duskwood
	["{quest:8735} wants a fragment from each of the four Dragons of Nightmare portals: elite dragonkin at the {zone:1440}, {zone:1444} and {zone:1425} portals (5% each) and the {npc:15625} in {zone:1431}. Raid content."] = "",
	["10 (and 100 Cenarion Circle)"] = "",

	-- Step 27: The Ashenvale portal
	-- {zone:1440} Ashenvale
	["The {zone:1440} portal"] = "",
	["The four dream portals sit in groves guarded by elite dragonkin of level 60 to 62 that respawn every 30 minutes; each drops the portal's fragment one time in twenty. Raid content."] = "",

	-- Step 28: The Duskwood portal
	-- {zone:1431} Duskwood
	["The {zone:1431} portal"] = "",
	-- {npc:15625} Twilight Corrupter
	["The {npc:15625} (level 63 boss) always drops its fragment."] = "",

	-- Step 29: The Feralas portal
	-- {zone:1444} Feralas
	["The {zone:1444} portal"] = "",

	-- Step 30: Hinterlands portal
	-- {zone:1425} Hinterlands
	["{zone:1425} portal"] = "",

	-- Step 31: The Nightmare Manifests
	-- {npc:11832} Keeper Remulos · {area:2361} Nighthaven
	["A raid event: follow {npc:11832} toward {area:2361} and keep him alive against Eranikus and his nightmare adds until Tyrande arrives and redeems Eranikus. Do not kill Eranikus."] = "",
	["100 (and 100 Cenarion Circle)"] = "",
	["The Redemption of Eranikus: raid"] = "",
	["200 (and 200 Cenarion Circle)"] = "",

	-- Step 32: The Scepter of the Shifting Sands
	-- {npc:15192} Anachronos · {object:180717} Scarab Gong · {area:3428} Ahn'Qiraj
	["With the three shards, {npc:15192} makes the Scepter of the Shifting Sands. In Classic its first holder rings the {object:180717} once for the whole realm, opening the gates of {area:3428}, and those who finish within ten hours earn the black qiraji crystal mount; whether Forever's realms get that event is not known."] = "",

	-- Step 33: Scarab Gong
	-- {object:180717} Scarab Gong · {area:3428} Ahn'Qiraj · {npc:15693} Jonathan the Revelator · {quest:8745} Treasure of the Timeless One
	["{object:180717} hangs before the gates of {area:3428}. {npc:15693} appears beside it once the gong has been rung, with {quest:8745}: a weapon and 200 reputation."] = "",

	-- Step 34: Neutral to Friendly in the Temple
	["Neutral to Friendly in the Temple"] = "",
	-- {area:16076} Temple of Ahn'Qiraj · {area:2737} Scarab Wall · {item:21230} Ancient Qiraji Artifact · {npc:15502} Andorgos · {item:21229} Qiraji Lord's Insignia · {npc:15503} Kandrostrasz · {area:3454} Ruins of Ahn'Qiraj
	["Neutral to Friendly is 3,000 reputation. Every trash mob of the {area:16076} (a 40-player raid behind the {area:2737}) gives 100, and the Twin Emperors 210 each, until 2,999 of 3,000 Neutral, one point short of Friendly; there they stop. Then hand in one saved {item:21230} (1,000, to {npc:15502}) or {item:21229} (500, to {npc:15503}) to tip you over. The shoulder and boot exchanges of the Temple's tier set need no standing: the token, two idols and ten scarabs to {npc:15502} (shoulders) or {npc:15503} (boots) pay 200 each. The {area:3454} (20 players) give a little from bosses: Kurinnaxx, Moam, Buru and Ayamiss 50 each, Rajaxx 34, Ossirian 100, to Exalted."] = "",
	-- {item:21229} Qiraji Lord's Insignia
	["{item:21229}, Temple bosses"] = "",

	-- Step 35: The ring at Friendly
	["The ring at Friendly"] = "",
	-- {npc:15192} Anachronos
	["At Friendly, {npc:15192} upgrades the ring of the path you chose: The Path of the Protector, Conqueror or Invoker. Bring the ring you wear; 100 reputation."] = "",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Friendly ring quest of your path"] = "",

	-- Step 36: Friendly to Honored: the turn-ins
	["Friendly to Honored: the turn-ins"] = "",
	-- {item:21230} Ancient Qiraji Artifact · {quest:8784} Secrets of the Qiraji · {npc:15502} Andorgos · {item:21229} Qiraji Lord's Insignia · {npc:15503} Kandrostrasz · {quest:8595} Mortal Champions · {npc:15727} C'Thun
	["Now hand in what you saved. Each {item:21230} (any Temple trash, 1% to 9%) starts {quest:8784}: 1,000 reputation from {npc:15502}, one of the three bronze dragons inside the Temple. Each {item:21229} (nearly every Temple boss) goes to {npc:15503} for {quest:8595}: 500 here and 100 Cenarion Circle. {npc:15727} gives 2,500, to Exalted. Friendly to Honored is 6,000: six artifacts or twelve insignias. Friendly also opens the helm and leg exchanges of the Temple's tier set (200 reputation each) at {npc:15502} and {npc:15503}."] = "",
	-- {item:21230} Ancient Qiraji Artifact · {npc:15502} Andorgos
	["{item:21230}: right-click it, then {npc:15502}"] = "",
	-- {quest:8595} Mortal Champions
	["{quest:8595}: 1 insignia, 500"] = "",

	-- Step 37: The ring at Honored
	["The ring at Honored"] = "",
	-- {npc:15192} Anachronos
	["At Honored, {npc:15192} upgrades the ring of the path you chose: The Path of the Protector, Conqueror or Invoker. Bring the ring you wear; 100 reputation."] = "",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Honored ring quest of your path"] = "",

	-- Step 38: Honored to Revered
	["Honored to Revered"] = "",
	-- {npc:15727} C'Thun · {quest:8595} Mortal Champions · {quest:8789} Imperial Qiraji Armaments · {npc:15380} Arygos · {npc:15378} Merithra of the Dream · {item:18562} Elementium Ore
	["Honored to Revered is 12,000: twelve artifacts, 24 insignias, or a mix with {npc:15727} (2,500). After the first, each insignia is the repeatable {quest:8595}. Every Temple boss sometimes drops an {quest:8789} or Regalia (about one time in twenty): {npc:15380} and {npc:15378}, inside the Temple once {npc:15727} is dead, take it with 3 {item:18562} for 200 and a weapon. Honored opens the chest exchange of the tier set (200)."] = "",
	-- {item:18562} Elementium Ore · {area:2677} Blackwing Lair
	["{item:18562}, {area:2677} or the auction house"] = "",
	-- {npc:15380} Arygos · {item:18562} Elementium Ore
	["{npc:15380}: Armaments and 3 {item:18562}, 200"] = "",
	-- {npc:15378} Merithra of the Dream · {item:18562} Elementium Ore
	["{npc:15378}: Regalia and 3 {item:18562}, 200"] = "",

	-- Step 39: The ring at Revered
	["The ring at Revered"] = "",
	-- {npc:15192} Anachronos
	["At Revered, {npc:15192} upgrades the ring of the path you chose: The Path of the Protector, Conqueror or Invoker. Bring the ring you wear; 100 reputation."] = "",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Revered ring quest of your path"] = "",

	-- Step 40: Revered to Exalted
	["Revered to Exalted"] = "",
	-- {npc:15727} C'Thun · {quest:8801} C'Thun's Legacy · {npc:15379} Caelestrasz
	["Revered to Exalted is 21,000: 21 artifacts or 42 insignias, with {npc:15727}'s 2,500 a week. {npc:15727}'s eye starts {quest:8801} for {npc:15379} (200, and 200 Cenarion Circle). At Exalted Anachronos gives the last ring: The Protector of Kalimdor, The Qiraji Conqueror or The Grand Invoker."] = "",

	-- Step 41: The Exalted ring
	["The Exalted ring"] = "",
	-- {npc:15192} Anachronos
	["At Exalted, {npc:15192} gives the last ring of your path: The Protector of Kalimdor, The Qiraji Conqueror or The Grand Invoker. Bring the Revered ring; 100 reputation."] = "",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Exalted ring quest of your path"] = "",
}
