-- Chinese (traditional) (zhTW): the guide forever/class/rogue/poisons-horde (forever/class/rogue/poisons-horde.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Poisons (Horde)"] = "毒藥（部落）",
	-- {item:7676} Thistle Tea
	["Forever teaches Poisons through this chain, not the trainer; the {item:7676} recipe comes with it."] = "Forever 透過這個任務鏈教授毒藥，而不是由訓練師教授；{item:7676}的配方也會一起給你。",

	-- Step 1: Lockpicking practice
	["Lockpicking practice"] = "開鎖練習",
	-- {object:129127} Gallywix's Lockbox · {spell:1804} Pick Lock · {npc:3401} Shenthul · {object:172960} Cleft of Shadow · {item:5060} Thieves' Tools · {area:392} Ratchet
	["{object:129127} at the end of the tower job needs Lockpicking of about 70-75. Train {spell:1804} from Gest or {npc:3401} in the {object:172960} if you lack it, carry {item:5060}, and pick the Buccaneer's Strongboxes on the middle deck of the Tide Razor, the beached pirate ship south of {area:392}: they come back fast. Your cap rises 5 per level."] = "塔樓任務最後的{object:129127}需要約70-75點開鎖。如果不會，就找{object:172960}裡的蓋斯特或{npc:3401}學習{spell:1804}，帶上{item:5060}，去撬潮汐剃刀號中層甲板上的海盜保險箱——那是{area:392}以南一艘擱淺的海盜船：重新出現很快。你的開鎖上限每級提高5點。",
	["Tide Razor"] = "潮汐剃刀號",
	["Lockpicking about 75: pick the Buccaneer's Strongboxes on the Tide Razor"] = "開鎖技能約75：撬開潮汐剃刀號上的海盜保險箱",

	-- Step 2: The Shattered Salute
	-- {npc:3401} Shenthul · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["{npc:3401} stands in the {object:172960}, the canyon under the {object:172982}. Take the quest and wait: he speaks three lines and salutes you. After his third line, target him and type /salute. If it does not count, abandon the quest and take it again. The tower job ahead is built around Ambush, which needs a dagger: if you have none, Kareth, the blade merchant in the {object:172960}, sells a Jambiya."] = "{npc:3401}站在{object:172960}裡，也就是{object:172982}下方的峽谷。接取任務後等著：他會說三句話，然後向你敬禮。等他說完第三句，選中他並輸入 /敬禮。如果沒算數，就放棄任務重新接取。前面的塔樓任務圍繞伏擊展開，需要匕首：如果沒有匕首，{object:172960}裡的武器商人卡雷斯出售一把詹比亞彎刀。",
	-- {npc:3401} Shenthul
	["/salute {npc:3401}"] = "對{npc:3401}輸入 /salute",
	-- {quest:2458} Deep Cover · {item:8051} Flare Gun
	["{quest:2458}: keep the {item:8051}"] = "{quest:2458}：保留{item:8051}",

	-- Step 3: Taskmaster Fizzule
	-- {area:382} Sludge Fen · {item:8051} Flare Gun · {npc:3401} Shenthul
	["Fly to the Crossroads and head north to the Venture Co. tower above the {area:382}. Fizzule stands under a tree east of the tower, outside it, and is hostile until signalled. Target him from about 50 yards and fire the {item:8051} twice, then walk up in front of him and /salute. In any other order he attacks. Lost the {item:8051}? Abandon and retake from {npc:3401}."] = "飛到十字路口，向北前往{area:382}上方風險投資公司的塔樓。菲祖爾站在塔樓東側的一棵樹下、塔外，在收到訊號前是敵對的。在約50碼外選中他，發射{item:8051}兩次，然後走到他面前 /敬禮。順序不對他就會攻擊。弄丟了{item:8051}？放棄任務，再找{npc:3401}重新接取。",
	-- {item:8051} Flare Gun
	["{item:8051}, twice, at Fizzule"] = "{item:8051}，對菲祖爾使用兩次",

	-- Step 4: The Venture Co. tower, with a group
	["The Venture Co. tower, with a group"] = "風險投資公司的塔，組隊",
	-- {npc:7288} Grand Foreman Puzik Gallywix · {item:8066} Fizzule's Whistle · {npc:7287} Foreman Silixiz · {object:129127} Gallywix's Lockbox · {spell:9810} Touch of Zanzil · {npc:2391} Serge Hinott
	-- plural, as words: Mutated Venture Co. Drones = {npc:7310} Mutated Venture Co. Drone
	["{npc:7288} on the top floor is a level 23 elite: easier at 23 or with a friend. Keep {item:8066} in your bags and use it on him every time you come near, or he turns hostile. First Pick Pocket Silixiz's Tower Key from {npc:7287} (level 22), who walks by the tower: stealth up behind him (killing him does not give it). Then clear the tower floor by floor (everything comes back after 4 1/2 minutes): Mutated Venture Co. Drones (25) on the ground floor, Patrollers on the second, Lookouts on the open third, Gallywix on top, back 10 minutes after a kill. Pick {object:129127} beside him for the cache: it poisons you with the {spell:9810}, which weakens your stealth and agility until {npc:2391} cures it."] = "頂樓的{npc:7288}是23級精英：23級或找朋友會比較輕鬆。把{item:8066}放在背包裡，每次靠近他時都對他使用，否則他會變成敵對。先從在塔旁走動的{npc:7287}（22級）身上偷取希里克斯的塔樓鑰匙：潛行到他背後（殺死他拿不到）。然後逐層清塔（所有怪4分半後重生）：一樓是變異風險投資公司工人（25級），二樓是巡邏者，開放的三樓是瞭望者，頂樓是加里維克斯，擊殺後10分鐘重生。打開他旁邊的{object:129127}取得寶箱物品：它會讓你中{spell:9810}之毒，削弱你的潛行和敏捷，直到{npc:2391}為你治療。",
	-- {item:8072} Silixiz's Tower Key
	["Pick Pocket Foreman Silixiz for {item:8072}"] = "對工頭希利克斯使用搜尋，獲得{item:8072}",
	-- {item:8074} Gallywix's Head · {npc:7288} Grand Foreman Puzik Gallywix
	["{item:8074}: {npc:7288} (elite)"] = "{item:8074}：{npc:7288}（精英）",

	-- Step 5: The Venture Co. tower, solo
	["The Venture Co. tower, solo"] = "風險投資公司的塔，單人",
	-- {item:8066} Fizzule's Whistle · {npc:7287} Foreman Silixiz · {spell:921} Pick Pocket · {spell:1943} Rupture · {spell:2098} Eviscerate · {npc:7288} Grand Foreman Puzik Gallywix · {spell:1776} Gouge · {spell:5277} Evasion · {item:7676} Thistle Tea · {object:129127} Gallywix's Lockbox · {spell:9810} Touch of Zanzil · {npc:2391} Serge Hinott
	-- plural, as words: Mutated Venture Co. Drones = {npc:7310} Mutated Venture Co. Drone
	["Keep {item:8066} in your bags and use it on him every time you come near, or he turns hostile. {npc:7287} (level 22) walks by the tower: hug the wall, stealth up behind him and {spell:921} the key. Killing him does not give it; if his pockets are empty, kill him and wait 4 1/2 minutes for him to come back. Inside, floor by floor (everything comes back after 4 1/2 minutes): the Mutated Venture Co. Drones (level 25) on the ground floor die to one Ambush with a dagger; the Patrollers on the second floor take half their health from a one-point {spell:1943}; the Lookouts on the open third floor from a one-point {spell:2098}. {npc:7288} waits on the top floor: a level 23 elite, back 10 minutes after a kill. Open with Ambush (about half his health), then {spell:1776}, {spell:5277}, a healing potion and {item:7676}; a friend makes it easy. One head per kill. Then pick {object:129127} beside him for the cache: it poisons you with the {spell:9810}, which weakens your stealth and agility until {npc:2391} cures it."] = "把{item:8066}放在背包裡，每次靠近他時都對他使用，否則他會變成敵對。{npc:7287}（22級）在塔旁走動：貼著牆，潛行到他背後用{spell:921}偷鑰匙。殺死他拿不到鑰匙；如果他口袋是空的，殺掉他並等4分半讓他重生。塔內逐層（所有怪4分半後重生）：一樓的變異風險投資公司工人（25級）用匕首一次伏擊就死；二樓的巡邏者吃一星{spell:1943}會掉一半血；開放的三樓的瞭望者則是一星{spell:2098}。{npc:7288}在頂樓等著：23級精英，擊殺後10分鐘重生。用伏擊開場（約他一半的血），然後{spell:1776}、{spell:5277}、治療藥水和{item:7676}；有朋友幫忙就很輕鬆。每次擊殺一顆頭。然後打開他旁邊的{object:129127}取得寶箱物品：它會讓你中{spell:9810}之毒，削弱你的潛行和敏捷，直到{npc:2391}為你治療。",

	-- Step 6: Back to Shenthul
	-- {npc:3401} Shenthul
	["Back to {npc:3401}"] = "返回{npc:3401}",
	-- {zone:1454} Orgrimmar · {area:392} Ratchet · {item:8072} Silixiz's Tower Key · {area:263} Cleft · {item:2928} Dust of Decay · {spell:8681} Instant Poison
	-- plural, as words: Empty Vials = {item:3371} Empty Vial
	["Fly back to {zone:1454} ({area:392} or the Crossroads; dying at the tower and taking the spirit healer's way back to the Crossroads is quicker). Keep {item:8072} afterwards. Before you leave the {area:263}, buy {item:2928} and Empty Vials from Rekkul: once Hinott teaches Poisons, each batch of {spell:8681} takes one of each."] = "飛回{zone:1454}（從{area:392}或十字路口起飛；在塔邊死亡，再透過靈魂醫者回到十字路口更快）。之後保留{item:8072}。離開{area:263}前，向雷庫爾購買{item:2928}和空瓶：希諾特教會你毒藥後，每製作一份{spell:8681}都要各用一個。",

	-- Step 7: Serge Hinott
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {zone:1421} Silverpine Forest · {area:287} Hillsbrad · {area:272} Tarren Mill · {npc:2391} Serge Hinott · {npc:2216} Apothecary Lydon · {npc:3401} Shenthul · {spell:8681} Instant Poison
	["Take the zeppelin from {zone:1454} to the {zone:1458} and follow the road south through {zone:1421} into {area:287}, to {area:272}. {npc:2391} works in the building next to the flight path, beside {npc:2216}, a wagon outside. If you lost the Sample of Zanzil's Mixture, abandon and retake from {npc:3401}. Stay beside him for about a minute while he brews the cure; if it never finishes, abandon and retake from him. Then open Poisons from your spellbook to make {spell:8681} from Rekkul's dust and vials, and use it on your weapon."] = "從{zone:1454}搭飛艇前往{zone:1458}，再沿道路往南穿過{zone:1421}進入{area:287}，前往{area:272}。{npc:2391}在飛行點旁的建築裡工作，就在{npc:2216}旁邊，屋外有一輛貨車。若弄丟了贊吉爾的藥劑樣品，放棄任務，再從{npc:3401}那裡重新接取。在他身邊待約一分鐘，等他調配解藥；如果一直沒有完成，放棄任務後再從他那裡重新接取。接著從法術書開啟毒藥，用雷庫爾的粉末和瓶子製作{spell:8681}，然後塗在武器上。",
	["Wait for the cure"] = "等待解藥",
	-- {npc:2391} Serge Hinott
	["{npc:2391}: Poisons"] = "{npc:2391}：毒藥",
	-- {item:8095} Hinott's Oil · {spell:9810} Touch of Zanzil
	["{item:8095}: clears the {spell:9810}"] = "{item:8095}：解除{spell:9810}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 20 {npc:3401} stands in the {object:172960}, the canyon under the {object:172982}. Target him and type /salute."] = "20級時，{npc:3401}站在{object:172960}，也就是{object:172982}下方的峽谷。選取他並輸入 /salute。",
	-- ["Fly back to {zone:1454}."] = "飛回{zone:1454}。",
	-- ["Fly to the {area:380} and ride north to the Venture Co. tower north of the {area:382}. In sight of the tower, fire the {item:8051} twice, then /salute {npc:7233} before he attacks you."] = "飛往{area:380}，向北騎往{area:382}北邊的風險投資公司塔樓。在看得到塔樓的地方發射兩次{item:8051}，然後在{npc:7233}攻擊你之前對他 /salute。",
	-- ["Stay stealthed. {npc:7287} carries the tower key; Gallywix (elite) and his lockbox are at the top of the tower. Kill two each of the drones, patrollers and lookouts around it."] = "保持潛行。{npc:7287}帶著塔樓的鑰匙；加里維克斯（精英）和他的帶鎖箱在塔頂。擊殺塔周圍的風險投資公司雄蜂、巡邏員和看守各兩個。",
	-- ["Take the zeppelin from {zone:1454} to the {zone:1458} and ride south through {zone:1421} to {area:272} in {area:287}. {npc:2391} stands in {area:272}; wait beside him while he brews the cure."] = "從{zone:1454}搭飛艇前往{zone:1458}，向南騎過{zone:1421}，前往{area:287}的{area:272}。{npc:2391}站在{area:272}；在他調製解藥時在旁邊等候。",
	-- ["{item:8051}, twice, in sight of the tower"] = "{item:8051}，兩次，在看得到塔樓的地方",
	-- ["{spell:2842} (Horde)"] = "{spell:2842}（部落）",
}
