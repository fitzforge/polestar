-- Chinese (traditional) (zhTW): the guide forever/reputation/ironforge (forever/reputation/ironforge.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ironforge Reputation"] = "鐵爐堡聲望",
	-- {zone:1428} Burning Steppes · {zone:1426} Dun Morogh · {zone:1459} Alterac Valley
	["Cloth, the {zone:1428} quests and the {zone:1426} hubs, which pay Gnomeregan too; {zone:1459} adds more."] = "",
	-- {faction:47} Ironforge
	["Exalted with {faction:47}: in Classic, other races may buy the rams"] = "",
	-- {faction:47} Ironforge · {zone:1428} Burning Steppes · {zone:1452} Winterspring · {zone:1459} Alterac Valley
	["About 600 {faction:47} reputation from level 52-59 quests in the {zone:1428} and {zone:1452}; {zone:1459}'s quests pay {faction:47} too"] = "",
	-- {faction:47} Ironforge · {zone:1426} Dun Morogh
	["About 2,900 {faction:47} reputation from low-level quests in {zone:1426}, most of it paid to Gnomeregan too (in Classic, a fifth of it at 60)"] = "",

	-- Step 1: Mistina Steelshield, the cloth quartermaster
	-- {npc:14723} Mistina Steelshield
	["{npc:14723}, the cloth quartermaster"] = "",
	-- {npc:14723} Mistina Steelshield · {faction:47} Ironforge · {object:32372} Great Forge · {item:14047} Runecloth · {quest:7806} Additional Runecloth · {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {zone:1437} Wetlands · {zone:1428} Burning Steppes · {zone:1452} Winterspring · {zone:1453} Stormwind · {zone:1457} Darnassus
	["{npc:14723} takes cloth for {faction:47}; she stands outside the clothier on the north side of the {object:32372}, among the tailors. Each first donation of 60 Wool, Silk, Mageweave and {item:14047} pays 150 reputation once; after the {item:14047} one, {quest:7806} pays 50 for every 20 {item:14047}, as often as you like. The Auction House in the Commons is the quickest source of cloth. In Classic, quests pay full reputation while they are at most 5 levels below you, so do {zone:1426} (levels 1-12), {zone:1432} (10-20) and the {zone:1437} (20-30) while you level through them. After the donations come the level 52-59 quests of the {zone:1428} and {zone:1452} (about 600), then the optional {zone:1426} hubs, best rate first: Coldridge Valley (about 37 a minute at full value), Kharanos (26), the quarry (17). Every {faction:47} gain also gives a quarter as much to {zone:1453}, {zone:1457} and the Gnomeregan Exiles, except quests in the level 1-10 start areas. Legacy Diplomat adds up to 10% to every gain."] = "",
	-- {item:2592} Wool Cloth · {zone:1432} Loch Modan · {zone:1437} Wetlands
	["{item:2592}: troggs, gnolls and kobolds in {zone:1432} and the {zone:1437}"] = "",

	-- Step 2: A Donation of Silk
	-- {item:4306} Silk Cloth · {zone:1437} Wetlands
	["{item:4306} drops from humanoids level 23 to 40: the Dragonmaw of the {zone:1437}, the Syndicate of Alterac and Arathi, Stranglethorn's trolls."] = "",

	-- Step 3: A Donation of Mageweave
	-- {item:4338} Mageweave Cloth · {object:147516} Dark Iron · {zone:1418} Badlands · {zone:1427} Searing Gorge · {zone:1446} Tanaris · {zone:1444} Feralas
	["{item:4338} drops from humanoids level 35 to 50: the Shadowforge and {object:147516} dwarves of the {zone:1418} and {zone:1427}, the Dunemaul ogres of {zone:1446}, the Hatecrest naga of {zone:1444}."] = "",

	-- Step 4: A Donation of Runecloth
	-- {item:14047} Runecloth · {zone:1448} Felwood · {zone:1452} Winterspring · {quest:7806} Additional Runecloth
	["{item:14047} drops from humanoids level 50 and up: the Scourge cultists and Scarlet Crusade in the Plaguelands, the Deadwood furbolgs of {zone:1448}, the Winterfall furbolgs of {zone:1452}. Keep any {item:14047} past the first 60 for {quest:7806}."] = "",

	-- Step 5: Ironforge: Royal Historian Archesonus
	-- {faction:47} Ironforge · {zone:1428} Burning Steppes · {npc:8879} Royal Historian Archesonus · {object:171709} High Seat
	["These quests are level 52 to 59, so they pay in full at 60, or nearly: about 600 {faction:47} reputation (in Classic about 450 at 60, as the {zone:1428} ones are level 52 to 54). {npc:8879} stands beside King Magni in the {object:171709}; he sends you to the ruins of Thaurissan in the {zone:1428}."] = "",
	-- {npc:8879} Royal Historian Archesonus
	["Hear {npc:8879} out"] = "",

	-- Step 6: Morgan's Vigil: Oralius
	-- {npc:9177} Oralius
	["Morgan's Vigil: {npc:9177}"] = "",
	-- {zone:1428} Burning Steppes · {npc:9177} Oralius
	["Morgan's Vigil sits in the south-east of the {zone:1428}, at the top of the pass up from Redridge. {npc:9177} wants the Firegut ogres of Dreadmaul Rock, north of the Vigil, thinned out; the Brutes keep to the rock's east side."] = "",

	-- Step 7: Thaurissan and Blackrock Stronghold
	["Thaurissan and Blackrock Stronghold"] = "",
	-- {npc:9176} Gor'tesh · {item:11467} Blackrock Medallion · {npc:9177} Oralius · {item:14047} Runecloth · {quest:7806} Additional Runecloth
	["The Thaurissan relics are the carved stones in the ruins around Flame Crest, west along the road: click twelve of them. {npc:9176} and the Blackrock orcs and worgs hold the camps at the foot of Blackrock Mountain, further west; each may drop a {item:11467} (about one kill in three), and {npc:9177} wants fifty. The orcs are level 50 and up, so they drop {item:14047} too: keep it for {quest:7806}."] = "",

	-- Step 8: Morgan's Vigil: hand in
	["Morgan's Vigil: hand in"] = "",
	-- {npc:9176} Gor'tesh
	["Plant {npc:9176}'s head on the soft dirt mound at the top of Dreadmaul Rock."] = "",

	-- Step 9: Ironforge: Archesonus again
	-- {faction:47} Ironforge
	["{faction:47}: Archesonus again"] = "",
	-- {npc:9021} Kharan Mighthammer · {npc:9177} Oralius · {zone:1459} Alterac Valley · {faction:47} Ironforge · {item:17542} Coldtooth Supplies
	-- plural, as words: Dark Iron Fanny Packs = {item:11468} Dark Iron Fanny Pack · Storm Crystals = {item:17423} Storm Crystal
	["With a group, Blackrock Depths pays more: Archesonus's chain goes on with {npc:9021} (100) and The Fate of the Kingdom (Emperor Thaurissan, 150), and {npc:9177} takes 20 Dark Iron Fanny Packs from the dwarves inside (The Good Stuff, 100). {zone:1459}, from level 51, pays {faction:47} too: its one-time quests about 1,900 as your Stormpike standing grows (the {zone:1459} guide walks them), and inside the battle 25 for every 10 Irondeep or {item:17542} and 50 for 5 Storm Crystals, as often as you like."] = "",

	-- Step 10: Winterspring: Enraged Wildkin
	-- {npc:11755} Harlo Wigglesworth · {npc:10301} Jaron Stoneshaper · {object:177132} Starfall Village (no name in this language: may be words) · {faction:47} Ironforge
	["{npc:11755} in Everlook sends you west to {npc:10301} at {object:177132}. {npc:10301}'s damaged crate and wrecked wagon lie at Mazthoril, down the valley to the south-east; his supplies lie around the wagon and the owlbeasts nearby carry his amulet. The last quest is level 59: 100 {faction:47} in full."] = "",

	-- Step 11: Coldridge Valley
	["Coldridge Valley"] = "",
	-- {npc:658} Sten Stoutarm · {npc:713} Balir Frosthammer
	["Optional: the Dwarf and Gnome start valley south-west of Kharanos, about 1,100 reputation (220 at a fifth) in 30 minutes at 60. {npc:658} and {npc:713} stand at Anvilmar. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "",

	-- Step 12: Coldridge: wolves, troggs and Felix Whindlebolt's things
	-- {npc:8416} Felix Whindlebolt
	["Coldridge: wolves, troggs and {npc:8416}'s things"] = "",
	-- {npc:8416} Felix Whindlebolt
	["The wolves roam the valley floor; the troggs dig in the camps east of Anvilmar; {npc:8416}'s box, chest and bucket lie in the trogg camps."] = "",

	-- Step 13: Coldridge: Anvilmar and Talin Keeneye
	-- {npc:714} Talin Keeneye
	["Coldridge: Anvilmar and {npc:714}"] = "",

	-- Step 14: Coldridge: Grelin Whitebeard and the troll cave
	-- {npc:786} Grelin Whitebeard
	["Coldridge: {npc:786} and the troll cave"] = "",
	-- {npc:786} Grelin Whitebeard
	["{npc:786} camps south of Anvilmar, at the mouth of the troll cave; the journal lies at the back of the cave."] = "",

	-- Step 15: Coldridge: the hot Mornbrew
	["Coldridge: the hot Mornbrew"] = "",
	-- {npc:836} Durnan Furcutter
	["The Scalding Mornbrew cools in five minutes: run straight to {npc:836} at Anvilmar."] = "",

	-- Step 16: Coldridge: on to Kharanos
	["Coldridge: on to Kharanos"] = "",
	-- {npc:1252} Senir Whitebeard
	["{npc:1252}, in Kharanos"] = "",
	-- {npc:6806} Tannok Frosthammer
	["{npc:6806}, in the inn"] = "",

	-- Step 17: Kharanos
	["Kharanos"] = "",
	["Optional: Kharanos and the Brewnall and Gnomeregan roads around it, about 1,300 reputation (260 at a fifth) in 50 minutes at 60. Most givers stand in and around the Thunderbrew Distillery and at Steelgrill's Depot east of it. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "",

	-- Step 18: Kharanos: the hills and the depot
	["Kharanos: the hills and the depot"] = "",
	["The boars and bears roam around Kharanos; the wendigos live in the Grizzled Den south-west of town; the leper gnomes at the Gnomeregan road carry the cogs and gears; Rumbleshot's ammo lies at his camp west of town."] = "",

	-- Step 19: Kharanos: back in town
	["Kharanos: back in town"] = "",

	-- Step 20: Kharanos: Brewnall and Frostmane Hold
	-- {quest:287} Frostmane Hold
	["Kharanos: Brewnall and {quest:287}"] = "",
	-- {npc:1374} Rejold Barleybrew · {quest:287} Frostmane Hold
	["{npc:1374} stands by Brewnall Village on the lake north-west of Kharanos; {quest:287} is the troll cave west of it."] = "",
	["walk to the back of the cave"] = "",

	-- Step 21: Kharanos: last hand-in
	["Kharanos: last hand-in"] = "",

	-- Step 22: The quarry and Amberstill Ranch
	["The quarry and Amberstill Ranch"] = "",
	-- {zone:1426} Dun Morogh · {npc:264936} Earthseer Farsen · {object:149024} Gol'Bolar Quarry (no name in this language: may be words)
	["Optional: eastern {zone:1426}, from {npc:264936}'s camp to the {object:149024} and Amberstill Ranch, about 500 reputation (100 at a fifth) in 30 minutes at 60. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "",

	-- Step 23: The quarry: troggs, spies and Vagash
	-- {npc:1388} Vagash
	["The quarry: troggs, spies and {npc:1388}"] = "",
	-- {object:149024} Gol'Bolar Quarry (no name in this language: may be words) · {npc:1388} Vagash
	["The Dark Iron Spies lurk around Farsen's camp; the troggs dig in the {object:149024}; {npc:1388}, a big snow leopard, prowls the hills above Amberstill Ranch."] = "",

	-- Step 24: The Reports
	-- {npc:1274} Senator Barin Redstone
	["{npc:1274}, in the throne room"] = "",

	-- Step 25: Additional Runecloth to Honored
	-- {quest:7806} Additional Runecloth
	["{quest:7806} to Honored"] = "{quest:7806}到尊敬",
	-- {quest:7806} Additional Runecloth · {item:14047} Runecloth · {zone:1426} Dun Morogh · {faction:47} Ironforge · {zone:1432} Loch Modan · {object:1162} Menethil Harbor (no name in this language: may be words) · {zone:1437} Wetlands · {zone:1459} Alterac Valley
	["{quest:7806}: 50 reputation for 20 {item:14047}, as often as you like. After the four first donations a Human, Night Elf or Gnome stands at Friendly 700 of 6,000, so Honored is 5,300 away: 106 turn-ins, 2,120 {item:14047} (Dwarves start 900 higher: 88 turn-ins; Skyborne start at Neutral 2,000, so 6,400 away: 128, two fewer after Exploring the Alliance). The level 52-59 quests above take 12 turn-ins off; each {zone:1426} hub you did takes 10 to 26 more off if it paid in full. More hubs pay {faction:47}, in full while they are no more than 5 levels below you: Thelsamar in {zone:1432} (about 3,500 in all) and {object:1162} in the {zone:1437} (about 2,500). From level 51 {zone:1459}'s one-time quests add about 1,900. Every city gain also gives a quarter as much to the other three Alliance cities (not counted here). Hand in all your {item:14047} at once."] = "",

	-- Step 26: Additional Runecloth to Revered
	-- {quest:7806} Additional Runecloth
	["{quest:7806} to Revered"] = "{quest:7806}到崇敬",
	-- {npc:1261} Veron Amberstill · {item:14047} Runecloth
	["Honored: in Classic Ironforge's vendors take 10% off for you, {npc:1261}'s rams (20g, the swift ones 200g) included; Forever has not settled it, and guide sites report 5% at Friendly rising to 20% at Exalted. Honored to Revered is 12,000 reputation: 240 turn-ins, 4,800 {item:14047}."] = "",

	-- Step 27: Additional Runecloth to Exalted
	-- {quest:7806} Additional Runecloth
	["{quest:7806} to Exalted"] = "{quest:7806}到崇拜",
	-- {item:14047} Runecloth · {npc:1261} Veron Amberstill · {zone:1426} Dun Morogh
	["Revered to Exalted is 21,000 reputation: 420 turn-ins, 8,400 {item:14047}. At Exalted, {npc:1261} at Amberstill Ranch in eastern {zone:1426} sells his rams to other races in Classic; the Ram and Swift Ram guides cover them."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "黑暗教徒和暗影法師（58-60級）在這裡會掉落；在這裡每擊殺一隻天譴軍團也會計入{object:92525}（見該指南）。拍賣場也買得到。",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "砂槌巨魔（45-48級）在這裡會掉落。拍賣場也買得到。",
	-- ["Keep handing in {quest:7806} until {faction:47} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "持續繳交{quest:7806}，直到{faction:47}崇拜。{item:14047}：{zone:1423}的黑暗教徒和暗影法師（58-60級），或拍賣場。",
	-- ["Keep handing in {quest:7806}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "持續繳交{quest:7806}，每次20個{item:14047}。{item:14047}：{zone:1423}的黑暗教徒和暗影法師（58-60級），或拍賣場。",
	-- ["Riverpaw Bandits and Taskmasters (level 16-18) drop it here. The Auction House works too."] = "河爪強盜和河爪監工（16-18級）在這裡會掉落。拍賣場也買得到。",
	-- ["Syndicate Mercenaries at Stromgarde (level 31-32) drop it here. The Auction House works too."] = "激流堡的辛迪加雇傭兵（31-32級）在這裡會掉落。拍賣場也買得到。",
	-- ["{npc:14723} takes cloth for {faction:47} in {faction:47}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7806} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14723}在{faction:47}收取布料以提升{faction:47}聲望。毛料、絲綢、魔紋布和{item:14047}的首次捐獻（各60塊布）只能做一次，每塊布給的聲望最多；之後{quest:7806}可重複到崇拜。與其他種族主城崇拜後，可購買該種族的坐騎。Forever的傳承外交官天賦可提高聲望獲取。",
	-- ["{npc:14723}: {item:14047} delivered"] = "{npc:14723}：{item:14047}已交付",
	-- ["{quest:7806} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7806}每次繳交需要20個{item:14047}，可無限次重複。以20的倍數攜帶{item:14047}，一次全部連續繳交。{item:14047}：{zone:1423}的黑暗教徒和暗影法師（58-60級），或拍賣場。",
}
