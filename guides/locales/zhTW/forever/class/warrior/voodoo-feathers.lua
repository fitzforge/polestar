-- Chinese (traditional) (zhTW): the guide forever/class/warrior/voodoo-feathers (forever/class/warrior/voodoo-feathers.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:1417} Sunken Temple
	["Experience at 50, ending in the {area:1417}; Classic's item choice may be gone on Forever."] = "50級的經驗值，最後在{area:1417}結束；經典版的物品選擇在Forever中可能已經沒有了。",
	["Experience"] = "經驗值",

	-- Step 1: A Troubled Spirit (Stormwind)
	-- {npc:5479} Wu Shen · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows
	["At 50, {npc:5479}, beside {npc:5480} in the warrior trainers' building of {object:2100}, sends you to the {npc:7572} in the {zone:1435}."] = "50級時，在{object:2100}戰士訓練師建築裡{npc:5480}旁邊的{npc:5479}會派你去{zone:1435}找{npc:7572}。",

	-- Step 2: A Troubled Spirit (Ironforge)
	-- {npc:5113} Kelv Sternhammer · {zone:1455} Ironforge · {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows
	["At 50, {npc:5113}, the warrior trainer of {zone:1455}, sends you to the {npc:7572} in the {zone:1435}."] = "50級時，{zone:1455}的戰士訓練師{npc:5113}會派你去{zone:1435}找{npc:7572}。",

	-- Step 3: A Troubled Spirit (Darnassus)
	-- {npc:7315} Darnath Bladesinger · {zone:1457} Darnassus · {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows
	["At 50, {npc:7315}, the warrior trainer of {zone:1457}, sends you to the {npc:7572} in the {zone:1435}."] = "50級時，{zone:1457}的戰士訓練師{npc:7315}會派你去{zone:1435}找{npc:7572}。",

	-- Step 4: A Troubled Spirit (Orgrimmar)
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows
	["At 50, {npc:3354} in the {object:172958} sends you to the {npc:7572} in the {zone:1435}."] = "50級時，{object:172958}的{npc:3354}會派你去{zone:1435}找{npc:7572}。",

	-- Step 5: A Troubled Spirit (Thunder Bluff)
	-- {npc:3041} Torm Ragetotem · {zone:1456} Thunder Bluff · {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows
	["At 50, {npc:3041}, the warrior trainer of {zone:1456}, sends you to the {npc:7572} in the {zone:1435}."] = "50級時，{zone:1456}的戰士訓練師{npc:3041}會派你去{zone:1435}找{npc:7572}。",

	-- Step 6: A Troubled Spirit (Undercity)
	-- {npc:4593} Christoph Walker · {zone:1458} Undercity · {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows
	["At 50, {npc:4593}, a warrior trainer of the {zone:1458}, sends you to the {npc:7572} in the {zone:1435}."] = "50級時，{zone:1458}的戰士訓練師之一{npc:4593}會派你去{zone:1435}找{npc:7572}。",

	-- Step 7: The Fallen Hero of the Horde
	-- {npc:7572} Fallen Hero of the Horde
	["The {npc:7572}"] = "{npc:7572}",
	-- {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows · {zone:1419} Blasted Lands · {area:75} Stonard · {area:1438} Nethergarde Keep
	["The {npc:7572}, a ghost, stands in the south-west of the {zone:1435}, at the pass into the {zone:1419}, a short ride south-west of {area:75}. Horde: fly to {area:75}. Alliance: fly to {area:1438} in the {zone:1419} and ride north through the pass. High-level beasts roam the way."] = "{npc:7572}是個幽靈，站在{zone:1435}西南、通往{zone:1419}的山口處，從{area:75}向西南騎一小段就到。部落：飛到{area:75}。聯盟：飛到{zone:1419}的{area:1438}，然後向北穿過山口。路上有高等級野獸遊蕩。",

	-- Step 8: Helboars
	-- plural, as words: Helboars = {npc:5993} Helboar
	["Helboars"] = "地獄野豬",
	-- {zone:1419} Blasted Lands · {area:1438} Nethergarde Keep · {spell:8349} Fire Nova
	-- plural, as words: Helboars = {npc:5993} Helboar
	["Seven Helboars (level 52-53, not elite) roam the north-west of the {zone:1419}, south-west of {area:1438}; some stand near the ogres on the mountainside by the road. They charge from 25 yards and cast {spell:8349}. They share spawn points with the Felbeasts and scorpids: if no boars are around, kill those and boars may appear instead. Back in 5 minutes."] = "七隻地獄野豬（52-53級，非精英）在{zone:1419}西北、{area:1438}西南一帶遊蕩；有幾隻站在路邊山坡上的食人魔附近。它們會從25碼外衝鋒，並施放{spell:8349}。它們與地獄獸和蠍子共用重生點：如果附近沒有野豬，就殺掉那些，野豬可能會取而代之出現。5分鐘後回來。",

	-- Step 10: Shadowsworn camps
	["Shadowsworn camps"] = "魔誓營地",
	-- {area:1440} Serpent's Coil · {area:1438} Nethergarde Keep · {area:72} Dark Portal · {spell:1766} Kick
	["The Shadowsworn camp around the mouth of the {area:1440} cave, south of {area:1438} on the way to the {area:72}. You need 20 Adepts (level 52-53, they leech blood and heal hurt allies: kill them first), 10 Cultists (51-52, they throw from range, so close in) and 20 Thugs (52-53, Thrash and {spell:1766}). Thugs can run short before the others: kill every Shadowsworn you pass."] = "暗影誓縛營地分佈在{area:1440}洞口周圍，在{area:1438}以南、通往{area:72}的路上。你需要20個侍僧（52-53級，他們會吸血並治療受傷的同伴：先殺他們）、10個教徒（51-52級，遠端投擲，所以貼上去）和20個暴徒（52-53級，會橫掃和{spell:1766}）。暴徒可能先於其他兩種殺不夠：路過時把所有暗影誓縛都殺掉。",

	-- Step 12: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "{area:1417}",
	-- {area:1417} Sunken Temple · {npc:5710} Jammal'an the Prophet · {npc:5716} Zul'Lor · {area:74} Pool of Tears · {zone:1435} Swamp of Sorrows · {spell:9081} Shadow Bolt Volley · {spell:8282} Curse of Blood · {spell:139} Renew · {npc:3560} Healing Ward · {spell:331} Healing Wave
	["You need two feathers of each colour from the six Atal'ai troll guardians (level 51-52, elite) on the {area:1417}'s balcony, who hold the barrier in front of {npc:5710}: Gasher and {npc:5716} drop the amber, Hukku and Mijan the blue, Zolo and Loro the green, every kill; each player on the quest loots their own set. The {area:1417} is a five-player dungeon: needs a group of five. It lies in the {area:74} in eastern {zone:1435}: climb the temple's outer steps, dive into the flooded hall and follow the stairs down to the entrance. Inside, reach the balcony by the stairs or the path on the right, not the spiral stairs. Hukku calls guardians and casts {spell:9081} and {spell:8282}; Mijan heals the others ({spell:139}, a {npc:3560}, {spell:331} below half health): kill her or her ward fast; {npc:5716} cleaves."] = "你需要每種顏色的兩根羽毛，來自{area:1417}陽臺上把守{npc:5710}前屏障的六個阿塔萊食人妖守衛（51-52級精英）：加什爾和{npc:5716}掉琥珀色，胡庫和米詹掉藍色，佐洛和洛若掉綠色，每次擊殺必掉；每個接了任務的玩家各自拾取自己的一套。{area:1417}是五人地城：需要五人隊伍。它位於{zone:1435}東部的{area:74}：登上神廟外臺階，潛入淹水大廳，沿樓梯下到入口。進去後，走樓梯或右側的小路到陽臺，別走螺旋樓梯。胡庫會召喚守衛並施放{spell:9081}和{spell:8282}；米詹會治療其他人（{spell:139}，一個{npc:3560}，血量低於一半時用{spell:331}）：快點殺掉她或她的守護；{npc:5716}會順劈斬。",
	-- {item:20606} Amber Voodoo Feather · {npc:5716} Zul'Lor
	["{item:20606}, from Gasher and {npc:5716}"] = "{item:20606}，來自加什爾和{npc:5716}",
	-- {item:20607} Blue Voodoo Feather
	["{item:20607}, from Hukku and Mijan"] = "{item:20607}，來自胡庫和米詹",
	-- {item:20608} Green Voodoo Feather
	["{item:20608}, from Zolo and Loro"] = "{item:20608}，來自佐洛和洛若",

	-- Step 13: Back to the Fallen Hero
	-- {npc:10996} Fallen Hero
	["Back to the {npc:10996}"] = "返回{npc:10996}",
	-- {npc:10996} Fallen Hero · {item:20130} Diamond Flask · {item:20521} Fury Visor · {item:20517} Razorsteel Shoulders
	["In Classic the {npc:10996} let you choose the {item:20130}, the {item:20521} or the {item:20517} here. Forever's change notes say the choice is gone, though its quest page still lists three unnamed rewards: look at the reward window before you hand in."] = "經典舊世裡，{npc:10996}讓你在這裡選擇{item:20130}、{item:20521}或{item:20517}。Forever的更新說明稱該選擇已取消，但它的任務頁面仍列出三項未具名的獎勵：交任務前先看獎勵視窗。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Helboars roam the north of the {zone:1419}, south of the {npc:10996}."] = "地獄野豬在{zone:1419}北部、{npc:10996}的南邊遊蕩。",
	-- ["The Shadowsworn cultists hold the east of the {zone:1419}."] = "魔誓教徒佔據{zone:1419}東部。",
	-- ["The {area:1417} lies under the {area:74} in the east of the {zone:1435}. Each of the six Atal'ai trolls on the balcony drops a voodoo feather: Gasher or {npc:5716} the amber, Hukku or Mijan the blue, Zolo or Loro the green. The {area:1417} is a dungeon and the trolls are elite: grouping up is advised."] = "{area:1417}位於{zone:1435}東部的{area:74}底下。陽台上的六個阿塔萊食人妖各會掉落一根巫毒羽毛：加什爾或{npc:5716}掉琥珀色，胡庫或米杉掉藍色，祖羅或洛若爾掉綠色。{area:1417}是地城，這些食人妖是精英：建議組隊。",
	-- ["The {npc:7572} stands in the south-west of the {zone:1435}, at the entrance to the {zone:1419}."] = "{npc:7572}站在{zone:1435}西南部，位於{zone:1419}的入口。",
}
