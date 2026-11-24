-- Chinese (traditional) (zhTW): the guide forever/miscellaneous/the-drowned-city-horde (forever/miscellaneous/the-drowned-city-horde.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:16550} The Drowned City
	["{area:16550} (Horde)"] = "{area:16550}（部落）",
	-- {area:16550} The Drowned City
	["Every Horde quest of the {area:16550} in one run, lead-ins included."] = "一次跑完{area:16550}的所有部落任務，包括前置任務。",

	-- Step 2: The Vile Reef
	-- {object:58} Gri'lek the Wanderer · {area:104} Vile Reef · {object:3202} Grom'gol
	["The tablet, {object:58}, lies on the sea floor of the {area:104}, west of {object:3202}. Mind your breath."] = "石板{object:58}在{area:104}的海底，{object:3202}西邊。注意呼吸。",

	-- Step 4: Fall of Gurubashi
	-- {area:102} Ruins of Zul'Kunda · {area:104} Vile Reef
	["In the {area:102}, on the hill north of the {area:104}. Click the tablet for the rubbing."] = "在{area:102}，{area:104}北邊的山丘上。點選石板拓印。",

	-- Step 6: The Lost City's entrance
	["The Lost City's entrance"] = "失落之城的入口",
	-- {area:104} Vile Reef · {area:17853} Sunken Hollow · {object:3202} Grom'gol
	-- plural, as words: Brinescale Skirmishers = {npc:262397} Brinescale Skirmisher
	["Brinescale Skirmishers around the {area:104} drop the tridents. The cavern entrance the quest asks for is under the reef, in {area:17853}: due west of {object:3202} and south-west of the reef's tablet."] = "{area:104}周圍的海鱗爭鬥者掉落三叉戟。任務要求的洞穴入口在礁石下方的{area:17853}：位於{object:3202}正西、礁石石板的西南。",

	-- Step 8: Krazek
	-- {area:35} Booty Bay
	["In {area:35}. Both factions take his two quests, from level 34."] = "在{area:35}。兩個陣營都能接他的兩個任務，從34級開始。",

	-- Step 9: Mazu'kon
	-- {zone:1412} Mulgore
	["Northern {zone:1412}. A long trip, but the idol only drops while his quest is in your log."] = "{zone:1412}北部。路很遠，但只有任務在日誌裡時才會掉落神像。",

	-- Step 10: To the The Drowned City
	-- {area:16550} The Drowned City
	["To the {area:16550}"] = "前往{area:16550}",
	-- {area:17853} Sunken Hollow · {area:104} Vile Reef · {object:3202} Grom'gol
	["A dungeon for five players of level 35 to 42. Meet your group at its entrance in {area:17853}, under the {area:104}: from the shore west of {object:3202}, swim due west. Water breathing helps."] = "適合35-42級的五人地下城。在{area:104}下方的{area:17853}入口與小隊會合：從{object:3202}西邊的海岸向正西遊。水下呼吸有幫助。",

	-- Step 11: First tablet
	["First tablet"] = "第一塊石板",
	-- {npc:258905} Zul'Alai
	-- plural, as words: Makrura Snappers = {npc:258897} Makrura Snapper · Chasm Crawlers = {npc:258818} Chasm Crawler
	["Past the Makrura Snappers and Chasm Crawlers waits {npc:258905}, the first boss. The first tablet comes soon after him: click it for the rubbing."] = "經過瑪克魯拉咬蟹和裂谷爬行者後，{npc:258905}——第一個首領——在前面等待。第一塊石板就在他之後不遠：點選它拓印。",

	-- Step 12: Var'Taka
	-- {npc:258924} Var'Taka · {npc:260042} Captain Dreadrise
	-- plural, as words: Brinescale Explorers = {npc:258799} Brinescale Explorer
	["Brinescale Explorers and Sorceresses guard the way to {npc:258924}, the second boss. The second tablet is close to him. Once he is dead, disrupt the barrier close to where he fell; you do it once more after {npc:260042}."] = "鹽鱗探險者和女法師守在{npc:258924}——第二個首領——的路上。第二塊石板就在他旁邊。他死後，摧毀他倒下的地方附近的屏障；在{npc:260042}之後還要再做一次。",

	-- Step 13: Captain Dreadrise
	["The Saltseer pirates hold his ground: Murderers, Manhunters, Cultists and Coroners, and any of them can drop an artifact. The third tablet is among them, before you reach the captain. After he dies, disrupt the barrier a second time."] = "鹽海海盜守著他的地盤：兇手、獵人者、邪教徒和驗屍官，他們任何一方都可能掉落神器。第三塊石板就在他們中間，在到達船長之前。他死後，第二次摧毀屏障。",
	-- {npc:773} Krazek
	["One pass through the pirates may give fewer than ten: {npc:773} takes the quest whenever you have them."] = "清一遍海盜可能不到十個：{npc:773}隨時會接受這個任務。",

	-- Step 14: Deathless Marrow
	-- {npc:260202} Deathless Marrow
	["Past the Champions of the Deep, {npc:260202} fights with his guardians. He drops the idol."] = "經過深海冠軍後，{npc:260202}與他的守衛戰鬥。他掉落神像。",

	-- Step 15: Min'loth the Serpent
	["The last boss. The fourth tablet is near him, and its rubbing still counts after he dies."] = "最後一個首領。第四塊石板就在他旁邊，他死後仍可拓印。",

	-- Step 17: Krazek
	["Once you have the ten artifacts."] = "集齊十件神器後。",

	-- Step 18: Master Gadrin
	-- {area:367} Sen'jin Village · {zone:1411} Durotar
	["{area:367}, in southern {zone:1411}."] = "{area:367}，在{zone:1411}南部。",
}
