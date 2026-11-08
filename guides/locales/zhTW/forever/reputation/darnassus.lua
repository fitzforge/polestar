-- Chinese (traditional) (zhTW): the guide forever/reputation/darnassus (forever/reputation/darnassus.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Darnassus Reputation"] = "達納蘇斯聲望",
	-- {item:11040} Morrowgrain · {zone:1438} Teldrassil · {zone:1439} Darkshore
	["Cloth, {item:11040} and the {zone:1438} and {zone:1439} hubs: the quests pay most while you level."] = "",
	-- {faction:69} Darnassus
	["Exalted with {faction:69}: in Classic, other races may buy the nightsabers"] = "",
	-- {quest:3803} Morrowgrain to Darnassus · {item:11040} Morrowgrain
	["{quest:3803}: 50 reputation for every 10 {item:11040}, as often as you like"] = "",
	-- {faction:69} Darnassus · {zone:1438} Teldrassil · {zone:1439} Darkshore
	["About 3,700 {faction:69} reputation from low-level quests in {zone:1438} and {zone:1439} (in Classic, a fifth of it at 60)"] = "",

	-- Step 1: Raedon Duskstriker, the cloth quartermaster
	-- {npc:14725} Raedon Duskstriker
	["{npc:14725}, the cloth quartermaster"] = "",
	-- {npc:14725} Raedon Duskstriker · {faction:69} Darnassus · {item:14047} Runecloth · {quest:7801} Additional Runecloth · {zone:1438} Teldrassil · {zone:1439} Darkshore · {zone:1440} Ashenvale · {quest:4183} The True Masters · {zone:1428} Burning Steppes · {item:11040} Morrowgrain · {zone:1453} Stormwind · {zone:1455} Ironforge
	["{npc:14725} takes cloth for {faction:69}; he stands in the Craftsmen's Terrace, in the north-east of {faction:69}, by the tailors. Each first donation of 60 Wool, Silk, Mageweave and {item:14047} pays 150 reputation once; after the {item:14047} one, {quest:7801} pays 50 for every 20 {item:14047}, as often as you like. The Auction House in the Tradesmen's Terrace is the quickest source of cloth. In Classic, quests pay full reputation while they are at most 5 levels below you, so do {zone:1438} (levels 1-12), {zone:1439} (11-20) and {zone:1440} (18-30) while you level through them. After the donations come {quest:4183} in the {zone:1428} and {item:11040}, a second repeatable turn-in; then the optional hubs, best rate first: Shadowglen (about 35 a minute at full value), Dolanaar (28), Auberdine (23). Every {faction:69} gain also gives a quarter as much to {zone:1453}, {zone:1455} and the Gnomeregan Exiles, except quests in the level 1-10 start areas. Legacy Diplomat adds up to 10% to every gain."] = "",
	-- {item:2592} Wool Cloth · {zone:1439} Darkshore · {zone:1440} Ashenvale
	["{item:2592}: furbolgs, satyrs and naga in {zone:1439} and {zone:1440}"] = "",

	-- Step 2: A Donation of Silk
	-- {item:4306} Silk Cloth · {zone:1440} Ashenvale
	["{item:4306} drops from humanoids level 23 to 40: the satyrs and furbolgs of {zone:1440}, the Thistlefur and Foulweald camps, the Grimtotem of Stonetalon."] = "",

	-- Step 3: A Donation of Mageweave
	-- {item:4338} Mageweave Cloth · {zone:1444} Feralas · {zone:1446} Tanaris
	["{item:4338} drops from humanoids level 35 to 50: the Hatecrest naga and Gordunni ogres of {zone:1444}, the Dunemaul ogres of {zone:1446}."] = "",

	-- Step 4: A Donation of Runecloth
	-- {item:14047} Runecloth · {zone:1448} Felwood · {zone:1452} Winterspring · {quest:7801} Additional Runecloth
	["{item:14047} drops from humanoids level 50 and up: the Deadwood furbolgs of {zone:1448}, the Winterfall furbolgs of {zone:1452}, the Scourge cultists of the Plaguelands. Keep any {item:14047} past the first 60 for {quest:7801}."] = "",

	-- Step 5: Morgan's Vigil: Dragonkin Menace
	-- {quest:4182} Dragonkin Menace
	["Morgan's Vigil: {quest:4182}"] = "",
	-- {npc:9562} Helendis Riverhorn · {zone:1428} Burning Steppes · {quest:4183} The True Masters · {faction:69} Darnassus · {object:2117} Stormwind Keep · {zone:1453} Stormwind · {npc:7044} Black Drake · {npc:7040} Black Dragonspawn · {npc:7041} Black Wyrmkin
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["{npc:9562} at Morgan's Vigil, in the south-east of the {zone:1428}, starts {quest:4183}: 175 {faction:69} reputation for two quests (level 54: in Classic 140 at 60), and the chain goes on to {object:2117} for 175 {zone:1453}. The Black Broodlings and the {npc:7044} live on the slopes north of the Vigil; the {npc:7040} and {npc:7041} west of it, in the middle of the zone."] = "",

	-- Step 6: Lakeshire: Magistrate Solomon
	-- {npc:344} Magistrate Solomon
	["Lakeshire: {npc:344}"] = "",
	-- {npc:344} Magistrate Solomon · {object:2117} Stormwind Keep · {zone:1453} Stormwind · {faction:69} Darnassus · {npc:7916} Erelas Ambersky · {zone:1452} Winterspring · {zone:1448} Felwood · {npc:10739} Mulgris Deepriver · {zone:1422} Western Plaguelands · {item:12663} Glyphed Oaken Branch
	["{npc:344} waits in the town hall of Lakeshire; his next quest takes you to {object:2117} (the {zone:1453} guide follows it). Other {faction:69} quests at this level, for when you pass by: {npc:7916} in Rut'theran Village has a wildkin chain into {zone:1452} (325 in all, with Ranshalla's escort), Arei's escort in {zone:1448} pays 150 after the Emerald Sanctuary's chain, {npc:10739} at the Writhing Haunt in the {zone:1422} 100 for the {item:12663}, and Put Her Down in Upper Blackrock Spire 100 with a group."] = "",

	-- Step 7: Morrowgrain (optional)
	-- {item:11040} Morrowgrain
	["{item:11040} (optional)"] = "",
	-- {quest:3803} Morrowgrain to Darnassus · {item:11040} Morrowgrain · {npc:6735} Innkeeper Saelienne · {npc:3516} Arch Druid Fandral Staghelm · {quest:3764} Un'Goro Soil · {zone:1453} Stormwind · {zone:1455} Ironforge
	["{quest:3803} takes 10 {item:11040} for 50, as often as you like, and pays in full at 60. The chain before it is level 50 (in Classic a fifth at 60): 220 at full. {npc:6735} sends you to {npc:3516} in the Cenarion Enclave; he wants 20 {quest:3764}. (The innkeepers of {zone:1453} and {zone:1455} give the same start.)"] = "",

	-- Step 8: Un'Goro Crater: Un'Goro Soil
	-- {quest:3764} Un'Goro Soil · {item:11040} Morrowgrain
	["Dig {quest:3764} from the dirt mounds all over the crater; most of the crater's beasts and the Gorishi silithids drop it too, about one kill in three. Take far more than 20: every pouch use takes 2, about 18 for each 10 {item:11040}."] = "",

	-- Step 9: Darnassus: Morrowgrain Research
	-- {npc:9047} Jenal · {npc:4217} Mathrengyl Bearwalker · {item:11020} Evergreen Pouch · {quest:3764} Un'Goro Soil · {item:11024} Evergreen Herb Casing · {item:11040} Morrowgrain
	["{npc:9047}, beside Fandral in the Cenarion Enclave, takes the soil. {npc:4217} sells the {item:11020} and Packets of Tharlendris Seeds. With a seed packet and 2 {quest:3764} in your bags, use the pouch to grow an {item:11024} and open it: about one casing in three holds {item:11040} (1 to 5), the rest other herbs. The pouch works once every 10 minutes, so use it whenever it is ready while you do other things."] = "",
	-- {item:11040} Morrowgrain
	["{item:11040}: grow it here and open the casings"] = "",

	-- Step 10: Morrowgrain to Darnassus
	-- {item:11040} Morrowgrain · {npc:4217} Mathrengyl Bearwalker · {quest:3764} Un'Goro Soil · {item:14047} Runecloth · {npc:7879} Quintis Jonespyre · {object:152576} Feathermoon Stronghold (no name in this language: may be words) · {zone:1444} Feralas
	["Every 10 {item:11040}: 50 reputation at {npc:4217}. Keep the pouch and buy seeds as you go. It is slow: about 9 casings, 90 minutes of pouch waits, 18 {quest:3764} and 9 seed packets for each hand-in, a little over 30 reputation an hour, so run it beside the {item:14047}. {npc:7879} at {object:152576} in {zone:1444} takes {item:11040} at the same rate, 25 for 5, after his own quest."] = "",

	-- Step 11: Shadowglen
	["Shadowglen"] = "",
	-- {zone:1438} Teldrassil
	["Optional: the Night Elf start glade in north-east {zone:1438}, about 1,050 reputation (210 at a fifth) in 30 minutes at 60. The givers stand around Aldrassil, the great tree. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "",

	-- Step 12: Shadowglen: the glade and the spider den
	["Shadowglen: the glade and the spider den"] = "",
	-- {item:3297} Fel Moss · {npc:8584} Iverron
	["The nightsabers and boars roam the glade; the grells around Aldrassil drop the {item:3297}; the totems stand in the furbolg camp north-west of the tree; the Webwood spiders live in the cave north of the glade. {npc:8584} waits outside that cave."] = "",

	-- Step 13: Shadowglen: first hand-in
	["Shadowglen: first hand-in"] = "",

	-- Step 14: Shadowglen: the egg and the antidote
	["Shadowglen: the egg and the antidote"] = "",
	-- {quest:917} Webwood Egg · {item:10640} Webwood Ichor
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker
	["The {quest:917} lies at the back of the spider cave; the mushrooms grow by the trees, the lilies by the pools, and the {item:10640} drops from the Webwood Lurkers."] = "",

	-- Step 15: Shadowglen: last hand-in
	["Shadowglen: last hand-in"] = "",
	-- {npc:8584} Iverron
	["{npc:8584}, outside the spider cave"] = "",

	-- Step 16: Dolanaar
	["Dolanaar"] = "",
	-- {faction:69} Darnassus
	["Optional: the village on the road to {faction:69}, about 1,250 reputation (250 at a fifth) in 45 minutes at 60. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "",

	-- Step 17: Dolanaar: Denalan and the lake
	-- {npc:2080} Denalan
	["Dolanaar: {npc:2080} and the lake"] = "",
	-- {npc:2080} Denalan · {npc:2107} Gaerolas Talvethren · {object:12352} Starbreeze Village (no name in this language: may be words)
	["{npc:2080} tends his garden on the south-east shore of Lake Al'Ameth; {npc:2107} stands upstairs in a house in {object:12352}, east of Dolanaar: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 18: Dolanaar: the woods around the village
	["Dolanaar: the woods around the village"] = "",
	-- {faction:69} Darnassus · {npc:2038} Lord Melenas · {npc:2107} Gaerolas Talvethren
	-- plural, as words: Gnarlpine Ambushers = {npc:2152} Gnarlpine Ambusher
	["The timberlings by the lake drop seeds and sprouts; the Gnarlpine Ambushers lurk on the road west to {faction:69}; {npc:2038} waits deep in Fel Rock, north-west of the village; the dreamcatcher lies in the furbolg camp east of the village, by {npc:2107}; the Nightsabers west of the village carry the pelts."] = "",

	-- Step 19: Dolanaar: first hand-in
	["Dolanaar: first hand-in"] = "",

	-- Step 20: Dolanaar: the relics and Ferocitas
	["Dolanaar: the relics and Ferocitas"] = "",
	-- plural, as words: Gnarlpine Mystics = {npc:7235} Gnarlpine Mystic
	["The four relics of Wakening lie in the Ban'ethil Barrow Den, south-west of Dolanaar; Ferocitas and the Gnarlpine Mystics camp east of the village."] = "",
	-- {item:8050} Tallonkai's Jewel · {quest:2459} Ferocitas the Dream Eater
	["{item:8050}, from {quest:2459}"] = "",

	-- Step 21: Dolanaar: Ursal the Mauler
	-- {quest:486} Ursal the Mauler
	["Dolanaar: {quest:486}"] = "",
	-- {quest:486} Ursal the Mauler · {zone:1438} Teldrassil
	["{quest:486}, a big bear, roams the Pools of Arlithrien in south-west {zone:1438}."] = "",

	-- Step 22: Auberdine
	["Auberdine"] = "",
	-- {zone:1439} Darkshore
	["Optional: Auberdine in {zone:1439}, a boat trip from Rut'theran Village, about 1,400 reputation (280 at a fifth) in an hour at 60. The givers stand along the town's street and pier. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "",

	-- Step 23: Auberdine: the coast and the woods
	["Auberdine: the coast and the woods"] = "",
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["The furbolg camp south of town counts for How Big a Threat; the Rabid Thistle Bears roam the woods south of town; the Highborne ghosts of the Ruins of Ameth'Aran, south-east of town, carry the relics, and Anaya's ghost walks there too; the bones lie on the beach south of town; the mushrooms grow in the Cliffspring Falls cave to the north-east."] = "",
	-- {quest:954} Bashal'Aran
	["the blue aura in the ruins of {quest:954}"] = "",

	-- Step 24: Auberdine: first hand-in
	["Auberdine: first hand-in"] = "",

	-- Step 25: Auberdine: the furbolgs, the bears and the grells
	["Auberdine: the furbolgs, the bears and the grells"] = "",
	-- {quest:955} Bashal'Aran
	["The Blackwood furbolgs camp south of town; the grells of {quest:955}, east of town, drop the earrings; the sea turtle remains lie on the beach west of town."] = "",

	-- Step 26: Auberdine: second hand-in
	["Auberdine: second hand-in"] = "",

	-- Step 27: Auberdine: the seal, the Den Mother and the pelts
	-- {npc:6788} Den Mother
	["Auberdine: the seal, the {npc:6788} and the pelts"] = "",
	-- {item:5338} Ancient Moonstone Seal · {quest:956} Bashal'Aran · {npc:6788} Den Mother · {zone:1439} Darkshore
	-- plural, as words: Moonstalker Sires = {npc:2237} Moonstalker Sire
	["The {item:5338} drops from the satyrs of {quest:956}; destroy the seal at the flame there. The {npc:6788} lairs north-east of {quest:956}; the Moonstalker Sires and Matriarchs roam the south of {zone:1439}."] = "",
	["the seal at the ancient flame"] = "",

	-- Step 28: Additional Runecloth to Honored
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Honored"] = "{quest:7801}到尊敬",
	-- {quest:7801} Additional Runecloth · {item:14047} Runecloth · {quest:4183} The True Masters · {item:11040} Morrowgrain · {faction:69} Darnassus · {zone:1439} Darkshore · {zone:1440} Ashenvale · {zone:1444} Feralas
	["{quest:7801}: 50 reputation for 20 {item:14047}, as often as you like. After the four first donations a Human, Dwarf or Gnome stands at Friendly 700 of 6,000, so Honored is 5,300 away: 106 turn-ins, 2,120 {item:14047} (Night Elves start 900 higher: 88 turn-ins; Skyborne start at Neutral 500, so 7,900 away: 158, two fewer after Exploring the Alliance). {quest:4183} and the {item:11040} chain above take 8 turn-ins off, and every 10 {item:11040} you hand in counts as one more; each hub you did takes 20 to 28 more off if it paid in full. More quests pay {faction:69}, in full while they are no more than 5 levels below you: the rest of {zone:1439} (about 3,400 more), Astranaar in {zone:1440} (about 3,900) and Feathermoon in {zone:1444} (about 1,700). Every city gain also gives a quarter as much to the other three Alliance cities (not counted here). Hand in all your {item:14047} at once."] = "",

	-- Step 29: Additional Runecloth to Revered
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Revered"] = "{quest:7801}到崇敬",
	-- {item:14047} Runecloth
	["Honored: in Classic Darnassus's vendors take 10% off for you, Lelanai's nightsabers (20g, the swift ones 200g) included; Forever has not settled it, and guide sites report 5% at Friendly rising to 20% at Exalted. Honored to Revered is 12,000 reputation: 240 turn-ins, 4,800 {item:14047}."] = "",

	-- Step 30: Additional Runecloth to Exalted
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Exalted"] = "{quest:7801}到崇拜",
	-- {item:14047} Runecloth · {faction:69} Darnassus
	["Revered to Exalted is 21,000 reputation: 420 turn-ins, 8,400 {item:14047}. At Exalted, Lelanai at the Cenarion Enclave in {faction:69} sells her nightsabers to other races in Classic; the Saber and Swift Saber guides cover them."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "黑暗教徒和暗影法師（58-60級）在這裡會掉落；在這裡每擊殺一隻天譴軍團也會計入{object:92525}（見該指南）。拍賣場也買得到。",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "砂槌巨魔（45-48級）在這裡會掉落。拍賣場也買得到。",
	-- ["Keep handing in {quest:7801} until {faction:69} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "持續繳交{quest:7801}，直到{faction:69}崇拜。{item:14047}：{zone:1423}的黑暗教徒和暗影法師（58-60級），或拍賣場。",
	-- ["Keep handing in {quest:7801}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "持續繳交{quest:7801}，每次20個{item:14047}。{item:14047}：{zone:1423}的黑暗教徒和暗影法師（58-60級），或拍賣場。",
	-- ["Riverpaw Bandits and Taskmasters (level 16-18) drop it here. The Auction House works too."] = "河爪強盜和河爪監工（16-18級）在這裡會掉落。拍賣場也買得到。",
	-- ["Syndicate Mercenaries at Stromgarde (level 31-32) drop it here. The Auction House works too."] = "激流堡的辛迪加雇傭兵（31-32級）在這裡會掉落。拍賣場也買得到。",
	-- ["{npc:14725} takes cloth for {faction:69} in {faction:69}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7801} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14725}在{faction:69}收取布料以提升{faction:69}聲望。毛料、絲綢、魔紋布和{item:14047}的首次捐獻（各60塊布）只能做一次，每塊布給的聲望最多；之後{quest:7801}可重複到崇拜。與其他種族主城崇拜後，可購買該種族的坐騎。Forever的傳承外交官天賦可提高聲望獲取。",
	-- ["{npc:14725}: {item:14047} delivered"] = "{npc:14725}：{item:14047}已交付",
	-- ["{quest:7801} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7801}每次繳交需要20個{item:14047}，可無限次重複。以20的倍數攜帶{item:14047}，一次全部連續繳交。{item:14047}：{zone:1423}的黑暗教徒和暗影法師（58-60級），或拍賣場。",
}
