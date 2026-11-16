-- Chinese (traditional) (zhTW): the guide forever/class/mage/manaweave-robe (forever/class/mage/manaweave-robe.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1453} Stormwind · {zone:1432} Loch Modan
	["A robe at 15 for Alliance mages, from {zone:1453} and {zone:1432}."] = "聯盟法師15級的長袍，任務在{zone:1453}和{zone:1432}。",

	-- Step 1: Zaldimar Wefhellt (Goldshire)
	-- {npc:328} Zaldimar Wefhellt · {area:87} Goldshire
	["{npc:328} is the {area:87} mage trainer, upstairs in the Lion's Pride Inn."] = "{npc:328}是{area:87}的法師訓練師，在獅王之傲旅店樓上。",

	-- Step 2: Dink (Ironforge)
	-- {npc:7312} Dink · {zone:1455} Ironforge · {object:32362} Mystic Ward · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind
	["{npc:7312} teaches mages in {zone:1455}'s {object:32362}. Take the {area:2257} from {object:171524} to {zone:1453} afterwards."] = "{npc:7312}在{zone:1455}的{object:32362}訓練法師。之後從{object:171524}搭乘{area:2257}前往{zone:1453}。",

	-- Step 3: Jennea Cannon
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {item:7247} Chest of Containment Coffers · {item:7308} Cantation of Manifestation
	["{npc:5497} stands at the top of the Wizard's Sanctum, the violet tower of the {object:2101}: climb the spiral ramp and take the portal near the top. The {item:7247} and the {item:7308} lie on the table behind her (both come back 5 minutes after someone takes them). You hand both in at the end, so keep them."] = "{npc:5497}站在巫師聖殿頂端，即{object:2101}的紫色高塔：沿螺旋坡道爬到頂上，用靠近頂部的傳送門。{item:7247}和{item:7308}放在她身後的桌上（被人拿走後都會在5分鐘後重新整理）。兩者最後都要交上去，所以都留著。",

	-- Step 4: The Blue Recluse
	-- {object:2169} The Blue Recluse · {object:2101} Mage Quarter · {item:7308} Cantation of Manifestation · {spell:122} Frost Nova · {item:7247} Chest of Containment Coffers · {item:7292} Filled Containment Coffer
	-- plural, as words: Rift Spawns = {npc:6492} Rift Spawn
	["{object:2169} is the tavern in the {object:2101}. Read the {item:7308} inside to make the invisible Rift Spawns (level 16-17) show: in the basement it brings out one, on the balcony or in the kitchen two, in the main room or by the door three, so read it downstairs. They hit hard and break out of {spell:122} fast. Beat one down: it does not die but sits stunned with a spiral over its head; use the {item:7247} on it while it is stunned, then click the {item:7292} it leaves on the floor (clicking before it appears wastes a charge). You need three, and the cantation works only once every 5 minutes (logging out does not reset it), so plan on three rounds."] = "{object:2169}是{object:2101}裡的酒館。在裡面閱讀{item:7308}，讓隱形的裂隙生物（16-17級）現形：在地下室讀到會引出一隻，在陽臺或廚房讀到引出兩隻，在主廳或門旁讀到引出三隻，所以要在樓下讀。它們攻擊很疼，而且很快就能掙脫{spell:122}。打倒一隻：它不會死，而是頭頂螺旋、昏迷地坐著；趁它昏迷時對它使用{item:7247}，然後點選它落在地上的{item:7292}（在它出現前點選會浪費一次充能）。你需要三隻，而吟唱每5分鐘才能生效一次（登出不會重置），所以按三輪準備。",
	-- {npc:6492} Rift Spawn
	["{npc:6492}, down to the stun"] = "{npc:6492}，打到昏迷為止",
	-- {item:7247} Chest of Containment Coffers · {npc:6492} Rift Spawn
	["{item:7247}, on the stunned {npc:6492}"] = "{item:7247}，在昏迷的{npc:6492}身上",

	-- Step 5: Back to Jennea Cannon
	-- {npc:5497} Jennea Cannon
	["Back to {npc:5497}"] = "返回{npc:5497}",

	-- Step 6: Linen Cloth
	-- {item:2589} Linen Cloth · {area:149} Silver Stream Mine · {object:2096} Trade District
	["Any humanoid drops {item:2589}, and the Tunnel Rats in the {area:149} drop it while you gather the gems; the Auction House in the {object:2096} sells it. You hand in ten."] = "任何人形怪都會掉落{item:2589}，{area:149}裡的隧道鼠在你採集寶石時也會掉；{object:2096}的拍賣行有售。你需要交十個。",
	-- {item:2589} Linen Cloth
	["{item:2589}: humanoids, or the Auction House"] = "{item:2589}：人型生物，或拍賣場",

	-- Step 7: The Silver Stream Mine
	-- {area:149} Silver Stream Mine
	["The {area:149}"] = "{area:149}",
	-- {area:2257} Deeprun Tram · {zone:1455} Ironforge · {zone:1432} Loch Modan · {area:149} Silver Stream Mine · {area:144} Thelsamar · {object:271} Miners' League Crates
	["Take the {area:2257} to {zone:1455}, then the road east through the South Gate tunnel into {zone:1432}. The {area:149} is at the north end of the loch, north of {area:144}; Tunnel Rat kobolds hold it. The gems come only from the tall stacked {object:271} (the cursor shows a cog over them; single boxes hold nothing): every crate gives one, there are fourteen and they come back after 3 to 5 minutes. You may have to go as deep as the end chamber for six. The same crates serve the dwarves' Filthy Paws quest."] = "乘{area:2257}到{zone:1455}，然後沿路向東，穿過南門隧道進入{zone:1432}。{area:149}在湖的北端、{area:144}以北；隧道鼠狗頭人佔據那裡。寶石只來自堆疊的{object:271}（滑鼠指標移到上面會顯示齒輪；單個箱子什麼都沒有）：每個木箱給一顆，共十四個，3到5分鐘後重新整理。為了六顆，你可能得深入到最後面的房間。同樣的木箱也用於矮人的“骯髒的爪子”任務。",

	-- Step 8: Wynne Larson
	-- {zone:1453} Stormwind · {npc:1309} Wynne Larson · {object:23296} Larson Clothiers · {object:2101} Mage Quarter
	["Back to {zone:1453} by the tram. {npc:1309} works at {object:23296} in the {object:2101}."] = "搭地鐵回到{zone:1453}。{npc:1309}在{object:2101}的{object:23296}工作。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Humanoids drop {item:2589}; the Auction House in the {object:2096} sells it."] = "人型生物會掉落{item:2589}；{object:2096}的拍賣場也有賣。",
	-- ["Take the {area:2257} to {zone:1455}, then the road east through the South Gate tunnel into {zone:1432}. The dwarven miners' league left the crates in the {area:149} at the north end of the loch; Tunnel Rat troggs hold the mine."] = "搭乘{area:2257}前往{zone:1455}，然後沿著道路向東穿過南門隧道進入{zone:1432}。矮人礦工聯盟把箱子留在湖北端的{area:149}；坑道鼠佔據礦坑。",
	-- ["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}. The {item:7247} and the {item:7308} lie behind her."] = "{npc:5497}站在{object:2101}的高塔裡。{item:7247}和{item:7308}放在她身後。",
	-- ["{object:2169} is the tavern in the {object:2101}. Use the {item:7308} inside to make the {npc:6492} visible, subdue one with your spells, then use the {item:7247} to throw down a coffer and capture it."] = "{object:2169}是{object:2101}的酒館。在裡面使用{item:7308}讓{npc:6492}現形，用法術制服一隻，然後使用{item:7247}丟出一個容器捕捉它。",
}
