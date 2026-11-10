-- Spanish (Spain) (esES): the guide forever/reputation/stormwind (forever/reputation/stormwind.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Stormwind Reputation"] = "Reputación: Ventormenta",
	-- {zone:1422} Western Plaguelands
	["Cloth, the {zone:1422}' cauldron quests and the Elwynn hubs: the quests pay most while you level."] = "",
	-- {faction:72} Stormwind
	["Exalted with {faction:72}: in Classic, other races may buy the horses"] = "",
	-- {faction:72} Stormwind · {area:3197} Chillwind Camp · {zone:1428} Burning Steppes
	["About 1,150 {faction:72} reputation from level 52-58 quests at {area:3197} and in the {zone:1428}"] = "",
	-- {faction:72} Stormwind · {area:717} Stockade
	["About 4,500 {faction:72} reputation from low-level quests in Elwynn and the {area:717}"] = "",

	-- Step 1: Clavicus Knavingham, the cloth quartermaster
	-- {npc:14722} Clavicus Knavingham
	["{npc:14722}, the cloth quartermaster"] = "",
	-- {npc:14722} Clavicus Knavingham · {faction:72} Stormwind · {item:14047} Runecloth · {quest:7796} Additional Runecloth · {zone:1436} Westfall · {zone:1431} Duskwood · {zone:1422} Western Plaguelands · {zone:1428} Burning Steppes · {area:717} Stockade · {area:87} Goldshire · {zone:1455} Ironforge · {zone:1457} Darnassus
	["{npc:14722} takes cloth for {faction:72}. The arrow leads to him; he stands upstairs inside his building. Each first donation of 60 Wool, Silk, Mageweave and {item:14047} pays 150 reputation once; after the {item:14047} one, {quest:7796} pays 50 for every 20 {item:14047}, as often as you like. The Auction House is the quickest source of cloth. In Classic, quests pay full reputation while they are at most 5 levels below you, so do Elwynn (levels 1-10), {zone:1436} (10-18), Redridge (15-25) and {zone:1431} (20-30) while you level through them. After the donations come the level 52-58 quests of the {zone:1422} and the {zone:1428} (about 1,150), then the optional low-level hubs, best rate first: Northshire and the city errands (about 40 a minute at full value), the {area:717} (30), Eastvale and {area:87} (25). Every {faction:72} gain also gives a quarter as much to {zone:1455}, {zone:1457} and the Gnomeregan Exiles, except quests in the level 1-10 start areas. Legacy Diplomat adds up to 10% to every gain."] = "",
	-- {item:2592} Wool Cloth · {zone:1436} Westfall
	["{item:2592}: Defias, gnolls and kobolds in {zone:1436} and Redridge"] = "",

	-- Step 2: Stormwind errands
	-- {faction:72} Stormwind
	["{faction:72} errands"] = "",
	-- {faction:72} Stormwind
	["Optional: four quick deliveries inside {faction:72} for 200 reputation in about five minutes. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "",

	-- Step 3: Northshire Valley
	-- {area:87} Goldshire · {npc:823} Deputy Willem · {npc:197} Marshal McBride · {area:24} Northshire Abbey
	["Optional: the Human start valley north of {area:87}: about 1,600 reputation in 40 minutes at 60, the best rate of the hubs. {npc:823} and {npc:197} stand at {area:24}. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "",

	-- Step 4: Northshire: kobolds, wolves and bandanas
	["Northshire: kobolds, wolves and bandanas"] = "",
	-- {npc:6} Kobold Vermin · {item:247834} Nibbled-On Book
	["The {npc:6} dig at the camp north of the abbey; the wolves roam the valley; the Defias at the vineyard east of the abbey drop the bandanas. Keep any {item:247834} a kobold drops: it starts Forever's book chain."] = "",
	-- {item:247834} Nibbled-On Book
	["{item:247834}, from the kobolds"] = "",

	-- Step 5: Northshire: back at the abbey
	["Northshire: back at the abbey"] = "",

	-- Step 6: Northshire: Echo Ridge, Garrick Padfoot and the vineyard
	-- {npc:103} Garrick Padfoot
	["Northshire: Echo Ridge, {npc:103} and the vineyard"] = "",
	-- {area:34} Echo Ridge Mine · {npc:103} Garrick Padfoot · {quest:3904} Milly's Harvest · {object:83763} Stolen Books
	-- plural, as words: Kobold Workers = {npc:257} Kobold Worker
	["The Kobold Workers are in {area:34} north of the abbey; {npc:103} stands in the Defias camp east of the vineyard; {quest:3904} crates lie in the vineyard; the rats carrying the {object:83763} run about the abbey grounds."] = "",

	-- Step 7: Northshire: second hand-in
	["Northshire: second hand-in"] = "",

	-- Step 8: Northshire: the mine and the books
	["Northshire: the mine and the books"] = "",
	-- {npc:80} Kobold Laborer · {area:34} Echo Ridge Mine
	["{npc:80}, deep in {area:34}"] = "",

	-- Step 9: Northshire: last hand-in
	["Northshire: last hand-in"] = "",
	-- {object:563442} Kobold Tracks
	["{object:563442}, east of the abbey"] = "",

	-- Step 10: Northshire: the books end in Goldshire
	-- {area:87} Goldshire
	["Northshire: the books end in {area:87}"] = "",
	-- {npc:240} Marshal Dughan · {area:87} Goldshire · {area:57} Fargodeep Mine
	-- plural, as words: Lost Books = {item:248001} Lost Book
	["{npc:240} stands in front of the Lion's Pride Inn in {area:87}. The Lost Books drop from the kobolds of {area:57} south of {area:87}; the picture book and the two rare books from the named kobolds there."] = "",
	["Arcane Explainer"] = "",
	-- {npc:951} Brother Paxton
	["{npc:951}, back at the abbey"] = "",

	-- Step 11: Goldshire
	-- {area:87} Goldshire · {npc:240} Marshal Dughan · {npc:241} Remy "Two Times" · {npc:253} William Pestle
	["Optional: {area:87}, Westbrook and the farms south of {area:87}: about 1,450 reputation in an hour at 60. {npc:240}, {npc:241} and {npc:253} stand around the Lion's Pride Inn. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "",

	-- Step 12: Goldshire: the mines
	-- {area:87} Goldshire
	["{area:87}: the mines"] = "",
	-- {area:57} Fargodeep Mine · {area:87} Goldshire · {area:54} Jasperlode Mine · {item:773} Gold Dust
	["{area:57} is south of {area:87}, {area:54} north-east of it. The kobolds in both drop the candles and the {item:773}; the wolves around {area:87} the pelts."] = "",

	-- Step 13: Goldshire: back at the inn
	-- {area:87} Goldshire
	["{area:87}: back at the inn"] = "",

	-- Step 14: Goldshire: Jasperlode Mine
	["walk into the mine"] = "",

	-- Step 15: Goldshire: Westbrook and Hogger
	-- {area:87} Goldshire · {npc:448} Hogger
	["{area:87}: Westbrook and {npc:448}"] = "",
	-- {npc:448} Hogger · {area:120} Westbrook Garrison
	["{npc:448} is an elite gnoll west of {area:120}; at 60 he is no trouble. The Wanted poster hangs on the garrison."] = "",
	-- {item:782} Painted Gnoll Armband
	["{item:782}, from the Riverpaw gnolls"] = "",
	-- {item:1931} Huge Gnoll Claw · {npc:448} Hogger
	["{item:1931}, from {npc:448}"] = "",

	-- Step 16: The farms south of Goldshire
	-- {area:87} Goldshire
	["The farms south of {area:87}"] = "",
	-- {area:87} Goldshire · {quest:87} Goldtooth · {area:57} Fargodeep Mine · {npc:330} Princess · {area:62} Brackwell Pumpkin Patch
	["The Stonefields' farm and the Maclures' farm lie on either side of the road south of {area:87}. {quest:87} guards the back of {area:57}; {npc:330} the boar roams the {area:62}."] = "",
	-- {item:1006} Brass Collar · {npc:330} Princess
	["{item:1006}, from {npc:330}"] = "",

	-- Step 17: Goldtooth and the kelp
	-- {quest:87} Goldtooth
	["{quest:87} and the kelp"] = "",
	-- {item:981} Bernice's Necklace · {quest:87} Goldtooth
	["{item:981}, from {quest:87}"] = "",
	-- {item:1256} Crystal Kelp Frond · {area:18} Crystal Lake
	["{item:1256}, from the murlocs of {area:18}"] = "",

	-- Step 18: Goldshire: last hand-in
	-- {area:87} Goldshire
	["{area:87}: last hand-in"] = "",

	-- Step 19: Shipment to Stormwind
	-- {npc:279} Morgan Pestle · {object:2096} Trade District
	["{npc:279}, in the {object:2096}"] = "",

	-- Step 20: Eastvale
	["Eastvale"] = "",
	-- {npc:261} Guard Thomas · {area:91} Tower of Azora
	["Optional: eastern Elwynn, around {npc:261} on the bridge and the {area:91}, about 1,000 reputation in 40 minutes at 60. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "",

	-- Step 21: Eastvale: the work
	["Eastvale: the work"] = "",
	-- {area:91} Tower of Azora · {area:54} Jasperlode Mine
	-- plural, as words: Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear · Kobold Geomancers = {npc:476} Kobold Geomancer
	["The murlocs along the river south of the bridge drop the fins; Prowlers and Young Forest Bears roam the woods; the Defias around the Brackwell farm and the {area:91} carry the bandanas; the enchanting supplies lie in their camps north of the tower; the Kobold Geomancers dig at {area:54}; the tools and the river finds lie along the river north of the logging camp."] = "",

	-- Step 22: Eastvale: hand in
	["Eastvale: hand in"] = "",

	-- Step 23: Eastvale: Defias Rogue Wizards
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["Eastvale: Defias Rogue Wizards"] = "",
	["opens with Thomas' report"] = "",
	-- {item:780} Torn Murloc Fin
	["{item:780}, from the murlocs south of the bridge"] = "",

	-- Step 24: Stockade: two quests
	-- {area:717} Stockade
	["{area:717}: two quests"] = "",
	-- {area:717} Stockade · {faction:72} Stormwind · {object:2101} Mage Quarter · {npc:1719} Warden Thelwater · {npc:1721} Nikova Raskol · {object:2100} Old Town · {npc:1696} Targorr the Dread · {npc:859} Guard Berton · {area:69} Lakeshire · {npc:1663} Dextren Ward · {npc:270} Councilman Millstipe · {area:42} Darkshire · {npc:639} Edwin VanCleef · {area:1581} Deadmines
	["Optional: the {area:717} is {faction:72}'s prison, a dungeon in the canals of the {object:2101}. At 60 you clear it alone in ten minutes: 300 reputation. {npc:1719} stands at the gate, {npc:1721} in {object:2100}. Two more {area:717} quests start outside the city, 100 each, if you pass by: What Comes Around... ({npc:1696}) from {npc:859} in {area:69} and Crime and Punishment ({npc:1663}) from {npc:270} in {area:42}. (The Stockade Riots, 100 more, needs the Unsent Letter from {npc:639} in the {area:1581} first.) Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "",

	-- Step 25: Inside the Stockade
	-- {area:717} Stockade
	["Inside the {area:717}"] = "",
	-- {npc:1716} Bazil Thredd
	-- plural, as words: Red Wool Bandanas = {item:2909} Red Wool Bandana
	["Kill the prisoners, convicts and insurgents in the cells; the Red Wool Bandanas drop from the Defias inside. {npc:1716} waits in the far end."] = "",

	-- Step 26: Stockade: hand in
	-- {area:717} Stockade
	["{area:717}: hand in"] = "",

	-- Step 27: A Donation of Silk
	-- {item:4306} Silk Cloth · {area:94} Raven Hill
	["{item:4306} drops from humanoids level 23 to 40: Syndicate in Alterac and Arathi, the Defias of Duskwood's {area:94}, Stranglethorn's trolls."] = "",

	-- Step 28: A Donation of Mageweave
	-- {item:4338} Mageweave Cloth · {zone:1446} Tanaris · {zone:1444} Feralas · {zone:1418} Badlands
	["{item:4338} drops from humanoids level 35 to 50: the Dunemaul ogres of {zone:1446}, the Hatecrest naga of {zone:1444}, the Shadowforge dwarves of the {zone:1418}."] = "",

	-- Step 29: A Donation of Runecloth
	-- {item:14047} Runecloth · {zone:1448} Felwood · {zone:1452} Winterspring · {quest:7796} Additional Runecloth
	["{item:14047} drops from humanoids level 50 and up: the Scourge cultists and Scarlet Crusade in the Plaguelands, the Deadwood furbolgs of {zone:1448}, the Winterfall furbolgs of {zone:1452}. Keep any {item:14047} past the first 60: it all goes to {quest:7796} later."] = "",

	-- Step 30: Chillwind Camp: Clear the Way
	-- {npc:10838} Commander Ashlam Valorfist · {npc:11053} High Priestess MacDonnell · {area:3197} Chillwind Camp · {zone:1422} Western Plaguelands · {faction:72} Stormwind · {object:92525} Argent Dawn
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul
	["These quests are level 52 to 58, so they pay in full at 60. {npc:10838} and {npc:11053} at {area:3197}, in the south of the {zone:1422}, send you against the four Scourge cauldrons: 820 {faction:72} reputation in all and 600 {object:92525} on the side. The Skeletal Flayers and Slavering Ghouls roam the fields north of the camp."] = "",

	-- Step 31: Andorhal and Felstone Field
	-- {area:199} Felstone Field
	["Andorhal and {area:199}"] = "",
	-- {item:12815} Beacon Torch · {npc:11075} Cauldron Lord Bilemaw · {area:199} Felstone Field · {npc:10778} Janice Felstone · {faction:72} Stormwind
	["Mark the four watchtowers around Andorhal, north of the camp, with the {item:12815} at each door. {npc:11075} guards the cauldron at {area:199}, west of Andorhal; his key opens it. {npc:10778}'s ghost wanders by the Felstone farmhouse, and her parcel lies inside: it goes to {faction:72} for 150 more."] = "",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Marca la {npc:10902} con la {item:12815}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Marca la {npc:10903} con la {item:12815}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Marca la {npc:10904} con la {item:12815}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Marca la {npc:10905} con la {item:12815}",
	-- {item:13194} Felstone Field Cauldron Key · {npc:11075} Cauldron Lord Bilemaw
	["{item:13194}, from {npc:11075}"] = "",
	-- {object:176361} Scourge Cauldron
	["the {object:176361}"] = "",
	-- {object:175894} Janice's Parcel
	["{object:175894}, in the farmhouse"] = "",

	-- Step 33: Dalson's Tears
	-- {npc:11077} Cauldron Lord Malvinious · {area:200} Dalson's Tears · {area:199} Felstone Field
	["{npc:11077} guards the cauldron at {area:200}, north-east of {area:199}."] = "",
	-- {object:177289} Scourge Cauldron
	["the {object:177289}"] = "",

	-- Step 34: Chillwind Camp: the Writhing Haunt
	-- {area:3197} Chillwind Camp · {area:202} Writhing Haunt
	["{area:3197}: the {area:202}"] = "",

	-- Step 35: Writhing Haunt
	-- {npc:11076} Cauldron Lord Razarch · {area:202} Writhing Haunt · {area:200} Dalson's Tears
	["{npc:11076} guards the cauldron at the {area:202}, the farm east of {area:200}."] = "",
	-- {object:176393} Scourge Cauldron
	["the {object:176393}"] = "",

	-- Step 37: Gahrron's Withering
	-- {npc:11078} Cauldron Lord Soulwrath · {area:201} Gahrron's Withering
	["{npc:11078} guards the cauldron at {area:201}, in the east of the zone."] = "",
	-- {object:176392} Scourge Cauldron
	["the {object:176392}"] = "",

	-- Step 38: Chillwind Camp: done
	-- {area:3197} Chillwind Camp
	["{area:3197}: done"] = "",
	-- {npc:11056} Alchemist Arbington · {area:2057} Scholomance
	["{npc:11056} in the camp also ends The Key to {area:2057} (200), after a longer chain that needs a {area:2057} group."] = "",

	-- Step 39: Stormwind: Janice Felstone's parcel
	-- {faction:72} Stormwind · {npc:10778} Janice Felstone
	["{faction:72}: {npc:10778}'s parcel"] = "",
	-- {npc:10782} Royal Factor Bathrilor · {object:2098} Cathedral Square · {npc:1646} Baros Alexston · {npc:3520} Ol' Emma
	["{npc:10782} stands in the city hall on {object:2098}, beside {npc:1646}; {npc:3520} walks the canals."] = "",

	-- Step 40: Morgan's Vigil: Dragonkin Menace
	-- {npc:9562} Helendis Riverhorn · {area:2418} Morgan's Vigil · {zone:1428} Burning Steppes · {quest:4183} The True Masters · {area:69} Lakeshire · {object:2117} Stormwind Keep · {faction:72} Stormwind · {zone:1457} Darnassus · {npc:7044} Black Drake · {npc:7040} Black Dragonspawn · {npc:7041} Black Wyrmkin
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["{npc:9562} at {area:2418}, in the south-east of the {zone:1428}, starts {quest:4183}: a chain to {area:69} and {object:2117}, 175 {faction:72} and 175 {zone:1457} reputation (level 54). The Black Broodlings and the {npc:7044} live on the slopes north of the Vigil; the {npc:7040} and {npc:7041} west of it, in the middle of the zone."] = "",

	-- Step 41: Lakeshire: Magistrate Solomon
	-- {npc:344} Magistrate Solomon · {area:69} Lakeshire
	["{npc:344} waits in the town hall of {area:69}."] = "",

	-- Step 42: Stormwind Keep
	-- {npc:1748} Highlord Bolvar Fordragon · {object:2117} Stormwind Keep · {npc:1749} Lady Katrana Prestor
	["{npc:1748} holds court in {object:2117} with {npc:1749} at his side: speak with her for the second of his quests."] = "",
	-- {npc:1749} Lady Katrana Prestor
	["Speak with {npc:1749}"] = "",

	-- Step 43: Lakeshire: Solomon again
	-- {area:69} Lakeshire
	["{area:69}: Solomon again"] = "",
	-- {area:1584} Blackrock Depths · {npc:9023} Marshal Windsor · {faction:72} Stormwind · {area:1583} Blackrock Spire · {npc:11878} Nathanos Blightcaller · {zone:1423} Eastern Plaguelands · {area:2057} Scholomance
	["With a group the chain goes on into {area:1584}: {npc:9023}, Jail Break! and The Great Masquerade back in {faction:72} pay about 750 {faction:72} more, Maxwell's Mission (Lower {area:1583}) 250, Delivery to Ridgewell 135. Order Must Be Restored ({npc:11878} in the {zone:1423}) pays 200, The Key to {area:2057} 200; Onyxia's head 400 and Nefarian's 200 when the raids open."] = "",

	-- Step 44: Additional Runecloth to Honored
	-- {quest:7796} Additional Runecloth
	["{quest:7796} to Honored"] = "{quest:7796} hasta Honorable",
	-- {quest:7796} Additional Runecloth · {item:14047} Runecloth · {faction:72} Stormwind · {zone:1436} Westfall · {area:69} Lakeshire · {zone:1431} Duskwood · {area:42} Darkshire
	["{quest:7796}: 50 reputation for 20 {item:14047}, as often as you like. After the four first donations a non-Human stands at Friendly 700 of 6,000, so Honored is 5,300 away: 106 turn-ins, 2,120 {item:14047} (Humans start 900 higher: 88 turn-ins; a Skyborne's Exploring the Alliance paid 100, two fewer). The level 52-58 quests above take 23 turn-ins off; every Elwynn hub you did takes 20 to 30 more off. More quest hubs pay {faction:72}, in full while they are no more than 5 levels below you: {zone:1436} (about 2,500 in all), Redridge's {area:69} (about 3,000) and {zone:1431}'s {area:42} (about 2,900). Every city gain also gives a quarter as much to the other three Alliance cities (not counted here). Hand in all your {item:14047} at once."] = "",

	-- Step 45: Additional Runecloth to Revered
	-- {quest:7796} Additional Runecloth
	["{quest:7796} to Revered"] = "{quest:7796} hasta Venerado",
	-- {npc:384} Katie Hunter · {item:14047} Runecloth
	["Honored: in Classic Stormwind's vendors take 10% off for you, {npc:384}'s horses (20g, the swift ones 200g) included; Forever has not settled it, and guide sites report 5% at Friendly rising to 20% at Exalted. Honored to Revered is 12,000 reputation: 240 turn-ins, 4,800 {item:14047}."] = "",

	-- Step 46: Additional Runecloth to Exalted
	-- {quest:7796} Additional Runecloth
	["{quest:7796} to Exalted"] = "{quest:7796} hasta Exaltado",
	-- {item:14047} Runecloth · {npc:384} Katie Hunter · {area:88} Eastvale Logging Camp
	["Revered to Exalted is 21,000 reputation: 420 turn-ins, 8,400 {item:14047}. At Exalted, {npc:384} at {area:88} sells her horses to other races in Classic; the Horse and Swift Horse guides cover them."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Lo sueltan los Adeptos oscuros y Magos oscuros de aquí (nivel 58-60); cada miembro de la Plaga que mates aquí también cuenta para la reputación con {object:92525} (consulta esa guía). También puedes comprarlo en la casa de subastas.",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Lo sueltan los ogros Machacaduna de aquí (nivel 45-48). También puedes comprarlo en la casa de subastas.",
	-- ["Keep handing in {quest:7796} until {faction:72} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Sigue entregando {quest:7796} hasta llegar a Exaltado con {faction:72}. {item:14047}: Adeptos oscuros y Magos oscuros (nivel 58-60) en {zone:1423}, o la casa de subastas.",
	-- ["Keep handing in {quest:7796}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Sigue entregando {quest:7796}, 20 de {item:14047} cada vez. {item:14047}: Adeptos oscuros y Magos oscuros (nivel 58-60) en {zone:1423}, o la casa de subastas.",
	-- ["Riverpaw Bandits and Taskmasters (level 16-18) drop it here. The Auction House works too."] = "Lo sueltan los Bandidos y Capataces Zarparrío de aquí (nivel 16-18). También puedes comprarlo en la casa de subastas.",
	-- ["Syndicate Mercenaries at Stromgarde (level 31-32) drop it here. The Auction House works too."] = "Lo sueltan los Mercenarios de la Hermandad de Stromgarde (nivel 31-32). También puedes comprarlo en la casa de subastas.",
	-- ["{npc:14722} takes cloth for {faction:72} in {zone:1453}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7796} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14722} recoge paño para {faction:72} en {zone:1453}. Las primeras donaciones de lana, seda, paño mágico y {item:14047} (60 paños cada una) se hacen una sola vez y dan la mayor reputación por paño; después, {quest:7796} se repite hasta Exaltado. Ser Exaltado con la ciudad de otra raza te permite comprar sus monturas. La ventaja de Legado Diplomático de Forever aumenta la reputación obtenida.",
	-- ["{npc:14722}: {item:14047} delivered"] = "{npc:14722}: {item:14047} entregado",
	-- ["{quest:7796} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7796} pide 20 de {item:14047} por entrega y se repite tantas veces como quieras. Lleva {item:14047} en múltiplos de 20 y entrégalo todo de una vez, una entrega tras otra. {item:14047}: Adeptos oscuros y Magos oscuros (nivel 58-60) en {zone:1423}, o la casa de subastas.",
}
