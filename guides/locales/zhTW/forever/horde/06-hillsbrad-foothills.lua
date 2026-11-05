-- Chinese (traditional) (zhTW): the guide forever/horde/06-hillsbrad-foothills (forever/horde/06-hillsbrad-foothills.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Tarren Mill
	-- {area:272} Tarren Mill
	["{area:272} is your base for this guide: the hearth brings you back here twice. Everyone stands around the town square."] = "{area:272}是本指南的據點：爐石會兩次帶你回到這裡。所有人都站在鎮上廣場周圍。",
	["Inside"] = "",
	-- {item:7768} Empty Red Waterskin · {object:107045} Spring Well
	["Fill the {item:7768} at the {object:107045} beside the inn"] = "在旅店旁的{object:107045}裝滿{item:7768}",
	-- {npc:2388} Innkeeper Shay
	["{npc:2388}: the last guide binds here, so this usually ticks at once"] = "{npc:2388}：上一份指南在這裡綁定爐石，所以這一步通常會立即完成",
	-- {object:556670} WANTED (no name in this language: may be words)
	["The {object:556670} poster by the inn"] = "",
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "",
	-- {quest:567} Dangerous!
	["The {quest:567} poster: its targets come up along the way; inside"] = "",

	-- Step 2: Serge Hinott
	-- {quest:2479} Hinott's Assistance · {npc:2391} Serge Hinott · {area:272} Tarren Mill
	["After returning Mission: Possible But Not Probable to Shenthul, bring {quest:2479} to {npc:2391} in {area:272}. Stay beside him until the brewing objective completes, then hand in the follow-up to learn Poisons. Finish it even if the Zanzil poison has already been removed; removing the debuff alone does not teach the skill."] = "",
	-- {npc:2391} Serge Hinott
	["{npc:2391}: Poisons"] = "{npc:2391}：毒藥",
	["Poison chain unfinished? Resume your current stage in the Class guide Poisons (Horde); completed quests do not need restarting. Arrange a group for Gallywix, finish the Hinott follow-up, then return to this leveling guide."] = "",

	-- Step 3: Bears, creepers and lions
	["Bears, creepers and lions"] = "熊、食苔蛛和山地獅",
	-- {item:3477} Creeper Ichor
	-- plural, as words: Gray Bears = {npc:2351} Gray Bear · Forest Moss Creepers = {npc:2350} Forest Moss Creeper · Starving Mountain Lions = {npc:2384} Starving Mountain Lion
	["West of Tarren Mill, Gray Bears, Forest Moss Creepers and Starving Mountain Lions roam the hills on the way down to the farms. The creepers drop {item:3477} rarely; you need only one."] = "在塔倫米爾西邊，灰熊、森林食苔蛛和饑餓的山地獅在通往農場的山丘上遊蕩。食苔蛛很少掉落{item:3477}；你只需要一個。",

	-- Step 4: Tarren Mill
	-- {npc:2216} Apothecary Lydon
	["{npc:2216}, inside"] = "",
	-- {npc:2230} Umpi
	["{npc:2230}, next to Lydon; inside"] = "",

	-- Step 5: Tarren Mill
	-- {area:272} Tarren Mill
	["Follow the road east along the river, then north-east up into the hills to {area:272}."] = "",

	-- Step 6: Mountain Lion Blood
	["Careful: When one lion is attacked, nearby lions come to its aid, and the Vicious Black Bears sharing those fields can also join the fight."] = "",

	-- Step 7: Hillsbrad Fields
	-- {area:287} Hillsbrad · {npc:232} Farmer Ray · {npc:2403} Farmer Getz · {npc:2451} Farmer Kalaba
	["The farms east of {area:287} town. {npc:232} works the field by the northern farmhouse, {npc:2403} the one further south-east; Farmhands and Farmers are everywhere. {npc:2451} tends the field south of the farms."] = "{area:287}鎮東邊的農場。{npc:232}在北邊農舍旁的田地工作，{npc:2403}在更東南邊的那塊；希爾斯布萊德雇農和希爾斯布萊德農夫到處都是。{npc:2451}照料農場南邊的田地。",
	-- {npc:2451} Farmer Kalaba · {area:286} Hillsbrad Fields
	["{npc:2451} walks around {area:286}: look inside the circle on the map"] = "",

	-- Step 9: Stanley
	-- {npc:2274} Stanley · {npc:232} Farmer Ray · {area:286} Hillsbrad Fields
	["{npc:2274} is {npc:232}'s dog, at the northern farmhouse in {area:286}."] = "{npc:2274}是{npc:232}的狗，在{area:286}北邊的農舍。",

	-- Step 10: Hillsbrad Fields: kill these as you meet them
	-- {area:286} Hillsbrad Fields
	["{area:286}: kill these as you meet them"] = "",
	-- {area:287} Hillsbrad
	["The Peasants work the fields south of the farmhouses. Every {area:287} human drops skulls; the Peasants drop them most often.\nCareful: A fleeing peasant that reaches the town hall can bring back many adds, including {area:287} footmen; snares, roots or similar effects keep them from escaping."] = "",
	-- {item:3692} Hillsbrad Human Skull
	["{item:3692}: the Peasants in the fields"] = "{item:3692}：田裡的希爾斯布萊德農民",

	-- Step 11: Hearth to Tarren Mill
	-- {area:272} Tarren Mill
	["Hearth to {area:272}"] = "",

	-- Step 12: Tarren Mill
	-- {npc:2215} High Executor Darthalia · {npc:270438} Deathstalker Masoj
	["{npc:2215}: orders for {npc:270438}, on the way to Durnholde"] = "{npc:2215}：給{npc:270438}的命令，在前往敦霍爾德城堡的路上",

	-- Step 13: Durnholde Keep: kill these as you meet them
	-- {area:275} Durnholde Keep
	["{area:275}: kill these as you meet them"] = "",
	-- {npc:2238} Tog'thar · {area:275} Durnholde Keep · {area:272} Tarren Mill
	["Drull and {npc:2238} are chained inside {area:275}'s courtyard buildings; open both locks.\nFrom {area:272} go south-east into the hills on the way to {area:275}. Rogues and Watchmen hold the camps along the way."] = "",
	-- {npc:2261} Syndicate Watchman
	["{npc:2261} walks around here: look inside the circle on the map"] = "",
	["Drull's ball and chain"] = "德盧爾的腳鐐",
	-- {npc:2238} Tog'thar
	["{npc:2238}'s ball and chain"] = "{npc:2238}的腳鐐",

	-- Step 14: Mudsnout Blossoms
	-- {item:3502} Mudsnout Blossoms
	["South-west of Durnholde, the {item:3502} grow on the hillsides above the river."] = "在敦霍爾德城堡西南方，{item:3502}生長在河流上方的山坡上。",

	-- Step 15: Deathstalker Masoj
	-- {area:290} Dun Garok
	["Masoj hides on the hillside above {area:290}, south of Durnholde, on the way down to the blossoms."] = "亡靈哨兵馬索吉躲在敦霍爾德城堡南邊、{area:290}上方的山坡上，就在下山前往花叢的路上。",

	-- Step 16: The smithy
	["The smithy"] = "鐵匠鋪",
	-- {area:287} Hillsbrad · {npc:2404} Blacksmith Verringtan · {object:1736} Shipment of Iron · {npc:2449} Citizen Wilkes
	["The smithy stands in the middle of {area:287} town. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks the street north of it."] = "鐵匠鋪位於{area:287}鎮中央。{npc:2404}和他的學徒在熔爐邊工作；{object:1736}堆在旁邊。{npc:2449}在鐵匠鋪北邊的街上走動。",

	-- Step 17: Tarren Mill
	-- {npc:2055} Master Apothecary Faranell · {zone:1458} Undercity
	["{npc:2055}, in the {zone:1458}"] = "{npc:2055}，在{zone:1458}",

	-- Step 18: Town hall
	["Town hall"] = "市政廳",
	-- {area:287} Hillsbrad · {npc:2335} Magistrate Burnside · {npc:2448} Clerk Horrace Whitesteed
	["The town hall is on the west side of {area:287}. {npc:2335} (30) and {npc:2448} are inside with the Town Registry; the Proclamation is pinned up beside it. Councilmen walk the town."] = "市政廳在{area:287}西側。{npc:2335}（30級）和{npc:2448}在裡面，旁邊有希爾斯布萊德城鎮文檔；希爾斯布萊德宣言貼在旁邊。希爾斯布萊德議員在鎮上走動。",
	-- {object:1761} Hillsbrad Proclamation
	["{object:1761}, inside"] = "",

	-- Step 20: Azurelode Mine
	-- {area:288} Azurelode Mine · {area:287} Hillsbrad · {npc:2305} Foreman Bonds · {npc:2450} Miner Hackett
	["The {area:288} lies south of {area:287} town. Miners work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside."] = "{area:288}位於{area:287}鎮南邊。希爾斯布萊德礦工在隧道中工作；{npc:2305}（30級）和{npc:2450}（29級）在深處。",
	-- {area:288} Azurelode Mine
	["Inside {area:288}"] = "",

	-- Step 24: To the Undercity
	-- {zone:1458} Undercity
	["To the {zone:1458}"] = "",
	-- {area:380} Crossroads · {zone:1454} Orgrimmar · {area:85} Tirisfal Glades · {zone:1458} Undercity · {area:153} Ruins of Lordaeron · {object:36078} Trade Quarter
	["Head east to the {area:380} and fly to {zone:1454}. Take the zeppelin from the towers outside {zone:1454} to {area:85}; the {zone:1458} lies below the {area:153}. The bat handler is in the {object:36078}."] = "",
	-- {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter · {quest:93739} Exploring the Horde
	["Speak with {npc:10181}, in the {object:36126}: {quest:93739}"] = "",
	-- {npc:10181} Lady Sylvanas Windrunner
	["Talk to {npc:10181}"] = "",

	-- Step 25: Aelthalyste
	-- {npc:4606} Aelthalyste · {object:36070} War Quarter
	["{npc:4606} stands in the {object:36070}."] = "",

	-- Step 26: Master Apothecary Faranell
	-- {npc:2055} Master Apothecary Faranell
	["{npc:2055}, in the Apothecarium"] = "{npc:2055}，在皇家藥劑師協會",
	-- {area:287} Hillsbrad
	["Keep it: the {area:287} coast, later on the route"] = "先留著：之後路線上的{area:287}海岸",

	-- Step 27: Archibald
	-- {spell:202} Two-Handed Swords · {npc:11870} Archibald · {object:36070} War Quarter
	["While you're here: learn {spell:202} from {npc:11870} ({object:36070}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 28: Archibald
	-- {npc:11870} Archibald · {object:36070} War Quarter
	["While you're here: learn Polearms from {npc:11870} ({object:36070}, 1 gold); two-handers level a Warrior fastest."] = "",

	-- Step 29: Archibald
	-- {spell:202} Two-Handed Swords · {npc:11870} Archibald · {object:36070} War Quarter
	["While you're here: learn {spell:202} from {npc:11870} ({object:36070}, 10 silver); two-handers level a Paladin fastest."] = "",

	-- Step 30: Archibald
	-- {npc:11870} Archibald · {object:36070} War Quarter
	["While you're here: learn Polearms from {npc:11870} ({object:36070}, 1 gold); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "",

	-- Step 31: Archibald
	-- {npc:11870} Archibald · {object:36070} War Quarter
	["While you're here: learn Swords from {npc:11870} ({object:36070}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "",

	-- Step 32: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "",

	-- Step 34: Orgrimmar
	-- {zone:1458} Undercity · {zone:1454} Orgrimmar
	["Take the zeppelin from the towers outside the {zone:1458} to {zone:1454} and train before you fly on."] = "從{zone:1458}外的塔搭飛艇前往{zone:1454}，在繼續飛行前先訓練。",

	-- Step 35: Camp Taurajo
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {area:378} Camp Taurajo
	["From {zone:1454} (zeppelin from the towers outside the {zone:1458}) fly to {area:378}."] = "從{zone:1454}（從{zone:1458}外的塔搭飛艇）飛往{area:378}。",

	-- Step 37: Brine
	-- {npc:5899} Brine · {area:378} Camp Taurajo · {area:359} Bael Modan
	["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}, on the way to {area:359}."] = "{npc:5899}的小屋在{area:378}南邊、野豬人水坑上方的山脊上，在前往{area:359}的路上。",
	-- {npc:5899} Brine · {area:272} Tarren Mill
	["{npc:5899}: the red waterskin from {area:272}"] = "{npc:5899}：來自{area:272}的紅色水袋",
	-- {npc:5899} Brine · {zone:1440} Ashenvale
	["{npc:5899}: the blue waterskin is filled in {zone:1440}, next guide"] = "{npc:5899}：藍色水袋在下一份指南的{zone:1440}裝滿",

	-- Step 38: Tear of the Moons
	-- {area:359} Bael Modan · {npc:3421} Feegly the Exiled · {object:3646} General Twinbraid's Strongbox
	["Follow the road south to the dwarf dig site at {area:359}. {npc:3421} hides at the south edge of the dig; {object:3646} sits at the bottom of the excavation."] = "沿道路向南前往{area:359}的矮人挖掘場。{npc:3421}躲在挖掘場的南緣；{object:3646}在挖掘坑的底部。",
	-- {object:3646} General Twinbraid's Strongbox
	["{object:3646}; below ground"] = "",

	-- Step 39: Great Lift
	-- {npc:12576} Grish Longrunner · {area:1718} Great Lift
	["South-west of Bael Modan, {npc:12576} waits at the top of the {area:1718}."] = "",

	-- Step 40: The Great Lift
	-- {area:1718} Great Lift
	["The {area:1718}"] = "",
	-- {zone:1456} Thunder Bluff · {area:378} Camp Taurajo · {area:1718} Great Lift · {area:17} The Barrens
	["Fly from {zone:1456} to {area:378} and take the road south to the {area:1718} at the bottom of the {area:17}."] = "",
	-- {npc:10079} Brave Moonhorn
	["{npc:10079}, at the top of the lift"] = "",

	-- Step 41: Hearth to Camp Taurajo
	-- {area:378} Camp Taurajo
	["Hearth to {area:378}"] = "",

	-- Step 42: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "",
	-- {area:378} Camp Taurajo
	["{area:378} flight master"] = "",

	-- Step 43: Ratchet
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["{npc:3442}, by the docks in {area:392}"] = "{npc:3442}，在{area:392}的碼頭旁",

	-- Step 44: Merchant Coast
	-- {area:378} Camp Taurajo · {area:392} Ratchet · {quest:874} Mahren Skyseer
	["Hearth to {area:378} and fly to {area:392}. {quest:874} camps on the shore north of {area:392}."] = "用爐石回到{area:378}，飛往{area:392}。{quest:874}在{area:392}北邊的海岸紮營。",

	-- Step 45: Isha Awak
	-- {quest:873} Isha Awak · {area:391} Merchant Coast · {npc:3388} Mahren Skyseer
	["{quest:873}, a big threshadon, swims in the shallows off the {area:391}, east of {npc:3388}."] = "{quest:873}是一隻巨大的長頸龍，在{area:391}外的淺水中游動，位於{npc:3388}東邊。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Drull and {npc:2238} are chained inside {area:275}'s courtyard buildings; open both locks."] = "德盧爾和{npc:2238}被鎖在{area:275}庭院的建築裡；打開兩把鎖。",
	-- ["From {area:272} go south-east into the hills on the way to {area:275}. Rogues and Watchmen hold the camps along the way."] = "從{area:272}向東南進入通往{area:275}途中的丘陵。辛迪加盜賊和辛迪加衛士佔據沿途的營地。",
	-- ["From {zone:1454} (zeppelin from the towers outside the {zone:1458}) fly to {area:1638} and train on {area:1639}, then fly on to {area:378}."] = "從{zone:1454}（從{zone:1458}外的塔搭飛艇）飛往{area:1638}，在{area:1639}訓練，然後繼續飛往{area:378}。",
	-- ["No Gallywix yet? The Class guide Poisons (Horde) runs the chain from Shenthul again, with a group for Gallywix."] = "還沒打倒加里維克斯？職業指南「毒藥（部落）」會從申蘇爾那裡重新跑這條任務鏈，並組隊對付加里維克斯。",
	-- ["No Gallywix yet? The Class guide {spell:2842} (Horde) runs the chain from Shenthul again, with a group for Gallywix."] = "還沒打倒加里維克斯？職業指南{spell:2842}（部落）會從申蘇爾那裡重新跑這條任務鏈，並組隊對付加里維克斯。",
	-- ["Only if Gallywix fell in the {zone:1413} (Mission: Possible But Not Probable): {npc:2391} stands in {area:272}. Wait beside him while he brews the cure, then take your reward: Poisons."] = "只有在你已於{zone:1413}擊敗加里維克斯時（基本不可能的任務）：{npc:2391}站在{area:272}。在他旁邊等他調製解藥，然後領取獎勵：毒藥。",
	-- ["Only if Gallywix fell in the {zone:1413} (Mission: Possible But Not Probable): {npc:2391} stands in {area:272}. Wait beside him while he brews the cure, then take your reward: {spell:2842}."] = "只有在你已於{zone:1413}擊敗加里維克斯時（基本不可能的任務）：{npc:2391}站在{area:272}。在他旁邊等他調製解藥，然後領取獎勵：{spell:2842}。",
	-- ["Peasants and skulls"] = "農民與頭骨",
	-- ["South-west of Bael Modan, {npc:12576} waits at the top of the {area:485}."] = "在巴爾莫丹西南方，{npc:12576}在{area:485}頂端等著。",
	-- ["Syndicate camps"] = "辛迪加營地",
	-- ["The Peasants work the fields south of the farmhouses. Every {area:287} human drops skulls; the Peasants drop them most often."] = "希爾斯布萊德農民在農舍南邊的田裡工作。每個{area:287}的人類都會掉落頭骨；農民掉落最頻繁。",
	-- ["The smithy stands in the middle of {area:287} town. {npc:2404} and his apprentices work at the forge; the {item:3564} is stacked beside it. {npc:2449} walks the street north of it."] = "鐵匠鋪位於{area:287}鎮中央。{npc:2404}和他的學徒在熔爐邊工作；{item:3564}堆在旁邊。{npc:2449}在鐵匠鋪北邊的街上走動。",
	-- ["The {object:1763} poster by the inn"] = "旅店旁的{object:1763}海報",
	-- ["The {quest:567} poster: its targets come up along the way"] = "{quest:567}海報：目標會在途中陸續出現",
	-- ["You arrive bound at the {area:272} inn. Everyone stands around the town square."] = "你抵達時綁定在{area:272}的旅店。所有人都站在鎮上廣場周圍。",
	-- ["{npc:2230}, next to Lydon"] = "{npc:2230}，在藥劑師林度恩旁邊",
}
