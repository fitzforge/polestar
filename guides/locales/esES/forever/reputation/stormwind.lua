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
	-- {faction:72} Stormwind · {zone:1428} Burning Steppes
	["About 1,150 {faction:72} reputation from level 52-58 quests at Chillwind Camp and in the {zone:1428}"] = "",
	-- {faction:72} Stormwind
	["About 4,500 {faction:72} reputation from low-level quests in Elwynn and the Stockade (in Classic, a fifth of it at 60)"] = "",

	-- Step 1: Clavicus Knavingham, the cloth quartermaster
	-- {npc:14722} Clavicus Knavingham
	["{npc:14722}, the cloth quartermaster"] = "",
	-- {npc:14722} Clavicus Knavingham · {faction:72} Stormwind · {item:14047} Runecloth · {quest:7796} Additional Runecloth · {zone:1436} Westfall · {zone:1431} Duskwood · {zone:1422} Western Plaguelands · {zone:1428} Burning Steppes · {zone:1455} Ironforge · {zone:1457} Darnassus
	["{npc:14722} takes cloth for {faction:72}. The arrow leads to him; he stands upstairs inside his building. Each first donation of 60 Wool, Silk, Mageweave and {item:14047} pays 150 reputation once; after the {item:14047} one, {quest:7796} pays 50 for every 20 {item:14047}, as often as you like. The Auction House is the quickest source of cloth. In Classic, quests pay full reputation while they are at most 5 levels below you, so do Elwynn (levels 1-10), {zone:1436} (10-18), Redridge (15-25) and {zone:1431} (20-30) while you level through them. After the donations come the level 52-58 quests of the {zone:1422} and the {zone:1428} (about 1,150), then the optional low-level hubs, best rate first: Northshire and the city errands (about 40 a minute at full value), the Stockade (30), Eastvale and Goldshire (25). Every {faction:72} gain also gives a quarter as much to {zone:1455}, {zone:1457} and the Gnomeregan Exiles, except quests in the level 1-10 start areas. Legacy Diplomat adds up to 10% to every gain."] = "",
	-- {item:2592} Wool Cloth · {zone:1436} Westfall
	["{item:2592}: Defias, gnolls and kobolds in {zone:1436} and Redridge"] = "",

	-- Step 2: A Donation of Silk
	-- {item:4306} Silk Cloth · {object:102} Raven Hill (no name in this language: may be words)
	["{item:4306} drops from humanoids level 23 to 40: Syndicate in Alterac and Arathi, the Defias of Duskwood's {object:102}, Stranglethorn's trolls."] = "",

	-- Step 3: A Donation of Mageweave
	-- {item:4338} Mageweave Cloth · {zone:1446} Tanaris · {zone:1444} Feralas · {zone:1418} Badlands
	["{item:4338} drops from humanoids level 35 to 50: the Dunemaul ogres of {zone:1446}, the Hatecrest naga of {zone:1444}, the Shadowforge dwarves of the {zone:1418}."] = "",

	-- Step 4: A Donation of Runecloth
	-- {item:14047} Runecloth · {zone:1448} Felwood · {zone:1452} Winterspring · {quest:7796} Additional Runecloth
	["{item:14047} drops from humanoids level 50 and up: the Scourge cultists and Scarlet Crusade in the Plaguelands, the Deadwood furbolgs of {zone:1448}, the Winterfall furbolgs of {zone:1452}. Keep any {item:14047} past the first 60: it all goes to {quest:7796} later."] = "",

	-- Step 5: Chillwind Camp: Clear the Way
	-- {quest:5092} Clear the Way
	["Chillwind Camp: {quest:5092}"] = "",
	-- {npc:10838} Commander Ashlam Valorfist · {npc:11053} High Priestess MacDonnell · {zone:1422} Western Plaguelands · {faction:72} Stormwind · {object:92525} Argent Dawn
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul
	["These quests are level 52 to 58, so they pay in full at 60, or nearly. {npc:10838} and {npc:11053} at Chillwind Camp, in the south of the {zone:1422}, send you against the four Scourge cauldrons: 820 {faction:72} reputation in all and 600 {object:92525} on the side (in Classic about 690 {faction:72} at 60, as the first quests are level 52 and 53). The Skeletal Flayers and Slavering Ghouls roam the fields north of the camp."] = "",

	-- Step 6: Andorhal and Felstone Field
	["Andorhal and Felstone Field"] = "",
	-- {item:12815} Beacon Torch · {npc:11075} Cauldron Lord Bilemaw · {npc:10778} Janice Felstone · {faction:72} Stormwind
	["Mark the four watchtowers around Andorhal, north of the camp, with the {item:12815} at each door. {npc:11075} guards the cauldron at Felstone Field, west of Andorhal; his key opens it. {npc:10778}'s ghost wanders by the Felstone farmhouse, and her parcel lies inside: it goes to {faction:72} for 150 more."] = "",
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

	-- Step 7: Chillwind Camp: Dalson's Tears
	["Chillwind Camp: Dalson's Tears"] = "",

	-- Step 8: Dalson's Tears
	["Dalson's Tears"] = "",
	-- {npc:11077} Cauldron Lord Malvinious
	["{npc:11077} guards the cauldron at Dalson's Tears, north-east of Felstone Field."] = "",
	-- {object:177289} Scourge Cauldron
	["the {object:177289}"] = "",

	-- Step 9: Chillwind Camp: the Writhing Haunt
	["Chillwind Camp: the Writhing Haunt"] = "",

	-- Step 10: The Writhing Haunt
	["The Writhing Haunt"] = "",
	-- {npc:11076} Cauldron Lord Razarch
	["{npc:11076} guards the cauldron at the Writhing Haunt, the farm east of Dalson's Tears."] = "",
	-- {object:176393} Scourge Cauldron
	["the {object:176393}"] = "",

	-- Step 11: Chillwind Camp: Gahrron's Withering
	["Chillwind Camp: Gahrron's Withering"] = "",

	-- Step 12: Gahrron's Withering
	["Gahrron's Withering"] = "",
	-- {npc:11078} Cauldron Lord Soulwrath
	["{npc:11078} guards the cauldron at Gahrron's Withering, in the east of the zone."] = "",
	-- {object:176392} Scourge Cauldron
	["the {object:176392}"] = "",

	-- Step 13: Chillwind Camp: done
	["Chillwind Camp: done"] = "",
	-- {npc:11056} Alchemist Arbington
	["{npc:11056} in the camp also ends The Key to Scholomance (200), after a longer chain that needs a Scholomance group."] = "",

	-- Step 14: Stormwind: Janice Felstone's parcel
	-- {faction:72} Stormwind · {npc:10778} Janice Felstone
	["{faction:72}: {npc:10778}'s parcel"] = "",
	-- {npc:10782} Royal Factor Bathrilor · {object:2098} Cathedral Square · {npc:1646} Baros Alexston · {npc:3520} Ol' Emma
	["{npc:10782} stands in the city hall on {object:2098}, beside {npc:1646}; {npc:3520} walks the canals."] = "",

	-- Step 15: Morgan's Vigil: Dragonkin Menace
	-- {quest:4182} Dragonkin Menace
	["Morgan's Vigil: {quest:4182}"] = "",
	-- {npc:9562} Helendis Riverhorn · {zone:1428} Burning Steppes · {quest:4183} The True Masters · {object:2117} Stormwind Keep · {faction:72} Stormwind · {zone:1457} Darnassus · {npc:7044} Black Drake · {npc:7040} Black Dragonspawn · {npc:7041} Black Wyrmkin
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["{npc:9562} at Morgan's Vigil, in the south-east of the {zone:1428}, starts {quest:4183}: a chain to Lakeshire and {object:2117}, 175 {faction:72} and 175 {zone:1457} reputation (level 54: in Classic four fifths of it at 60). The Black Broodlings and the {npc:7044} live on the slopes north of the Vigil; the {npc:7040} and {npc:7041} west of it, in the middle of the zone."] = "",

	-- Step 16: Lakeshire: Magistrate Solomon
	-- {npc:344} Magistrate Solomon
	["Lakeshire: {npc:344}"] = "",
	-- {npc:344} Magistrate Solomon
	["{npc:344} waits in the town hall of Lakeshire."] = "",

	-- Step 17: Stormwind Keep
	-- {npc:1748} Highlord Bolvar Fordragon · {object:2117} Stormwind Keep · {npc:1749} Lady Katrana Prestor
	["{npc:1748} holds court in {object:2117} with {npc:1749} at his side: speak with her for the second of his quests."] = "",
	-- {npc:1749} Lady Katrana Prestor
	["Speak with {npc:1749}"] = "",

	-- Step 18: Lakeshire: Solomon again
	["Lakeshire: Solomon again"] = "",
	-- {npc:9023} Marshal Windsor · {faction:72} Stormwind · {npc:11878} Nathanos Blightcaller · {zone:1423} Eastern Plaguelands
	["With a group the chain goes on into Blackrock Depths: {npc:9023}, Jail Break! and The Great Masquerade back in {faction:72} pay about 750 {faction:72} more, Maxwell's Mission (Lower Blackrock Spire) 250, Delivery to Ridgewell 135. Order Must Be Restored ({npc:11878} in the {zone:1423}) pays 200, The Key to Scholomance 200; Onyxia's head 400 and Nefarian's 200 when the raids open."] = "",

	-- Step 19: Stormwind errands
	-- {faction:72} Stormwind
	["{faction:72} errands"] = "",
	-- {faction:72} Stormwind
	["Optional: four quick deliveries inside {faction:72} for 200 reputation (40 at a fifth) in about five minutes. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "",

	-- Step 20: The Stockade: two quests
	["The Stockade: two quests"] = "",
	-- {faction:72} Stormwind · {object:2101} Mage Quarter · {npc:1719} Warden Thelwater · {npc:1721} Nikova Raskol · {object:2100} Old Town · {npc:1696} Targorr the Dread · {npc:859} Guard Berton · {npc:1663} Dextren Ward · {npc:270} Councilman Millstipe · {npc:639} Edwin VanCleef
	["Optional: the Stockade is {faction:72}'s prison, a dungeon in the canals of the {object:2101}. At 60 you clear it alone in ten minutes: 300 reputation (60 at a fifth). {npc:1719} stands at the gate, {npc:1721} in {object:2100}. Two more Stockade quests start outside the city, 100 each, if you pass by: What Comes Around... ({npc:1696}) from {npc:859} in Lakeshire and Crime and Punishment ({npc:1663}) from {npc:270} in Darkshire. (The Stockade Riots, 100 more, needs the Unsent Letter from {npc:639} in the Deadmines first.) In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "",

	-- Step 21: Inside the Stockade
	["Inside the Stockade"] = "",
	-- {npc:1716} Bazil Thredd
	-- plural, as words: Red Wool Bandanas = {item:2909} Red Wool Bandana
	["Kill the prisoners, convicts and insurgents in the cells; the Red Wool Bandanas drop from the Defias inside. {npc:1716} waits in the far end."] = "",

	-- Step 22: The Stockade: hand in
	["The Stockade: hand in"] = "",

	-- Step 23: Northshire Valley
	["Northshire Valley"] = "",
	-- {npc:823} Deputy Willem · {npc:197} Marshal McBride · {object:89} Northshire Abbey (no name in this language: may be words)
	["Optional: the Human start valley north of Goldshire: about 1,600 reputation (320 at a fifth) in 40 minutes at 60, the best rate of the hubs. {npc:823} and {npc:197} stand at {object:89}. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "",

	-- Step 24: Northshire: kobolds, wolves and bandanas
	["Northshire: kobolds, wolves and bandanas"] = "",
	-- {npc:6} Kobold Vermin · {item:247834} Nibbled-On Book
	["The {npc:6} dig at the camp north of the abbey; the wolves roam the valley; the Defias at the vineyard east of the abbey drop the bandanas. Keep any {item:247834} a kobold drops: it starts Forever's book chain."] = "",
	-- {item:247834} Nibbled-On Book
	["{item:247834}, from the kobolds"] = "",

	-- Step 25: Northshire: back at the abbey
	["Northshire: back at the abbey"] = "",

	-- Step 26: Northshire: Echo Ridge, Garrick Padfoot and the vineyard
	-- {npc:103} Garrick Padfoot
	["Northshire: Echo Ridge, {npc:103} and the vineyard"] = "",
	-- {npc:103} Garrick Padfoot · {quest:3904} Milly's Harvest · {object:83763} Stolen Books
	-- plural, as words: Kobold Workers = {npc:257} Kobold Worker
	["The Kobold Workers are in Echo Ridge Mine north of the abbey; {npc:103} stands in the Defias camp east of the vineyard; {quest:3904} crates lie in the vineyard; the rats carrying the {object:83763} run about the abbey grounds."] = "",

	-- Step 27: Northshire: second hand-in
	["Northshire: second hand-in"] = "",

	-- Step 28: Northshire: the mine and the books
	["Northshire: the mine and the books"] = "",
	-- {npc:80} Kobold Laborer
	["{npc:80}, deep in Echo Ridge Mine"] = "",

	-- Step 29: Northshire: last hand-in
	["Northshire: last hand-in"] = "",
	-- {object:563442} Kobold Tracks
	["{object:563442}, east of the abbey"] = "",

	-- Step 30: Northshire: the books end in Goldshire
	["Northshire: the books end in Goldshire"] = "",
	-- {npc:240} Marshal Dughan
	-- plural, as words: Lost Books = {item:248001} Lost Book
	["{npc:240} stands in front of the Lion's Pride Inn in Goldshire. The Lost Books drop from the kobolds of Fargodeep Mine south of Goldshire; the picture book and the two rare books from the named kobolds there."] = "",
	["Arcane Explainer"] = "",
	-- {npc:951} Brother Paxton
	["{npc:951}, back at the abbey"] = "",

	-- Step 31: Goldshire
	["Goldshire"] = "",
	-- {npc:240} Marshal Dughan · {npc:241} Remy "Two Times" · {npc:253} William Pestle
	["Optional: Goldshire, Westbrook and the farms south of Goldshire: about 1,450 reputation (290 at a fifth) in an hour at 60. {npc:240}, {npc:241} and {npc:253} stand around the Lion's Pride Inn. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "",

	-- Step 32: Goldshire: the mines
	["Goldshire: the mines"] = "",
	-- {item:773} Gold Dust
	["Fargodeep Mine is south of Goldshire, Jasperlode Mine north-east of it. The kobolds in both drop the candles and the {item:773}; the wolves around Goldshire the pelts."] = "",

	-- Step 33: Goldshire: back at the inn
	["Goldshire: back at the inn"] = "",

	-- Step 34: Goldshire: Jasperlode Mine
	["Goldshire: Jasperlode Mine"] = "",
	["walk into the mine"] = "",

	-- Step 35: Goldshire: Westbrook and Hogger
	-- {npc:448} Hogger
	["Goldshire: Westbrook and {npc:448}"] = "",
	-- {npc:448} Hogger · {object:93} Westbrook Garrison (no name in this language: may be words)
	["{npc:448} is an elite gnoll west of {object:93}; at 60 he is no trouble. The Wanted poster hangs on the garrison."] = "",
	-- {item:782} Painted Gnoll Armband
	["{item:782}, from the Riverpaw gnolls"] = "",
	-- {item:1931} Huge Gnoll Claw · {npc:448} Hogger
	["{item:1931}, from {npc:448}"] = "",

	-- Step 36: The farms south of Goldshire
	["The farms south of Goldshire"] = "",
	-- {quest:87} Goldtooth · {npc:330} Princess
	["The Stonefields' farm and the Maclures' farm lie on either side of the road south of Goldshire. {quest:87} guards the back of Fargodeep Mine; {npc:330} the boar roams the Brackwell Pumpkin Patch."] = "",
	-- {item:1006} Brass Collar · {npc:330} Princess
	["{item:1006}, from {npc:330}"] = "",

	-- Step 37: Goldtooth and the kelp
	-- {quest:87} Goldtooth
	["{quest:87} and the kelp"] = "",
	-- {item:981} Bernice's Necklace · {quest:87} Goldtooth
	["{item:981}, from {quest:87}"] = "",
	-- {item:1256} Crystal Kelp Frond
	["{item:1256}, from the murlocs of Crystal Lake"] = "",

	-- Step 38: Goldshire: last hand-in
	["Goldshire: last hand-in"] = "",

	-- Step 39: Shipment to Stormwind
	-- {npc:279} Morgan Pestle · {object:2096} Trade District
	["{npc:279}, in the {object:2096}"] = "",

	-- Step 40: Eastvale
	["Eastvale"] = "",
	-- {npc:261} Guard Thomas
	["Optional: eastern Elwynn, around {npc:261} on the bridge and the Tower of Azora, about 1,000 reputation (200 at a fifth) in 40 minutes at 60. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "",

	-- Step 41: Eastvale: the work
	["Eastvale: the work"] = "",
	-- plural, as words: Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear · Kobold Geomancers = {npc:476} Kobold Geomancer
	["The murlocs along the river south of the bridge drop the fins; Prowlers and Young Forest Bears roam the woods; the Defias around the Brackwell farm and the Tower of Azora carry the bandanas; the enchanting supplies lie in their camps north of the tower; the Kobold Geomancers dig at Jasperlode Mine; the tools and the river finds lie along the river north of the logging camp."] = "",

	-- Step 42: Eastvale: hand in
	["Eastvale: hand in"] = "",

	-- Step 43: Eastvale: Defias Rogue Wizards
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["Eastvale: Defias Rogue Wizards"] = "",
	-- {npc:240} Marshal Dughan
	["{npc:240}, Goldshire"] = "",
	["opens with Thomas' report"] = "",
	-- {item:780} Torn Murloc Fin
	["{item:780}, from the murlocs south of the bridge"] = "",

	-- Step 44: Additional Runecloth to Honored
	-- {quest:7796} Additional Runecloth
	["{quest:7796} to Honored"] = "{quest:7796} hasta Honorable",
	-- {quest:7796} Additional Runecloth · {item:14047} Runecloth · {faction:72} Stormwind · {zone:1436} Westfall · {zone:1431} Duskwood
	["{quest:7796}: 50 reputation for 20 {item:14047}, as often as you like. After the four first donations a non-Human stands at Friendly 700 of 6,000, so Honored is 5,300 away: 106 turn-ins, 2,120 {item:14047} (Humans start 900 higher: 88 turn-ins; a Skyborne's Exploring the Alliance paid 100, two fewer). The level 52-58 quests above take 23 turn-ins off; every Elwynn hub you did takes 20 to 30 more off if it paid in full. More quest hubs pay {faction:72}, in full while they are no more than 5 levels below you: {zone:1436} (about 2,500 in all), Redridge's Lakeshire (about 3,000) and {zone:1431}'s Darkshire (about 2,900). Every city gain also gives a quarter as much to the other three Alliance cities (not counted here). Hand in all your {item:14047} at once."] = "",

	-- Step 45: Additional Runecloth to Revered
	-- {quest:7796} Additional Runecloth
	["{quest:7796} to Revered"] = "{quest:7796} hasta Venerado",
	-- {npc:384} Katie Hunter · {item:14047} Runecloth
	["Honored: in Classic Stormwind's vendors take 10% off for you, {npc:384}'s horses (20g, the swift ones 200g) included; Forever has not settled it, and guide sites report 5% at Friendly rising to 20% at Exalted. Honored to Revered is 12,000 reputation: 240 turn-ins, 4,800 {item:14047}."] = "",

	-- Step 46: Additional Runecloth to Exalted
	-- {quest:7796} Additional Runecloth
	["{quest:7796} to Exalted"] = "{quest:7796} hasta Exaltado",
	-- {item:14047} Runecloth · {npc:384} Katie Hunter · {object:95} Eastvale Logging Camp (no name in this language: may be words)
	["Revered to Exalted is 21,000 reputation: 420 turn-ins, 8,400 {item:14047}. At Exalted, {npc:384} at {object:95} sells her horses to other races in Classic; the Horse and Swift Horse guides cover them."] = "",

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
