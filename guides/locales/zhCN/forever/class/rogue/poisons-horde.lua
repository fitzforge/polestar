-- Chinese (simplified) (zhCN): the guide forever/class/rogue/poisons-horde (forever/class/rogue/poisons-horde.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Poisons (Horde)"] = "毒药（部落）",
	-- {item:7676} Thistle Tea
	["Forever teaches Poisons through this chain, not the trainer; the {item:7676} recipe comes with it."] = "无限通过这条任务线而不是训练师来传授毒药；同时附带{item:7676}配方。",

	-- Step 1: Lockpicking practice
	["Lockpicking practice"] = "开锁练习",
	-- {object:129127} Gallywix's Lockbox · {spell:1804} Pick Lock · {npc:3401} Shenthul · {object:172960} Cleft of Shadow · {item:5060} Thieves' Tools · {area:392} Ratchet
	["{object:129127} at the end of the tower job needs Lockpicking of about 70-75. Train {spell:1804} from Gest or {npc:3401} in the {object:172960} if you lack it, carry {item:5060}, and pick the Buccaneer's Strongboxes on the middle deck of the Tide Razor, the beached pirate ship south of {area:392}: they come back fast. Your cap rises 5 per level."] = "塔楼任务最后的 {object:129127} 需要约70—75点开锁技能。如果还不会 {spell:1804}，就向盖斯特或 {object:172960} 的 {npc:3401} 学习；带上 {item:5060}，到 {area:392} 南边搁浅的海盗船“海浪剃刀号”的中层甲板，练习打开海盗的保险箱：它们刷新很快。你的技能上限每升一级提高5点。",
	["Tide Razor"] = "海浪剃刀号",
	["Lockpicking about 75: pick the Buccaneer's Strongboxes on the Tide Razor"] = "开锁技能约75点：打开 海浪剃刀号上的海盗的保险箱",

	-- Step 2: The Shattered Salute
	-- {npc:3401} Shenthul · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["{npc:3401} stands in the {object:172960}, the canyon under the {object:172982}. Take the quest and wait: he speaks three lines and salutes you. After his third line, target him and type /salute. If it does not count, abandon the quest and take it again. The tower job ahead is built around Ambush, which needs a dagger: if you have none, Kareth, the blade merchant in the {object:172960}, sells a Jambiya."] = "{npc:3401} 在 {object:172960}，也就是 {object:172982} 下方的峡谷里。接任务后等待：他会说三句话，然后向你敬礼。等第三句话说完，选中他并输入 /salute。如果没有完成目标，就放弃任务重新接取。接下来的高塔任务主要靠伏击，需要匕首：如果没有，{object:172960} 的刀剑商人卡雷斯出售曲刃短剑。",
	-- {npc:3401} Shenthul
	["/salute {npc:3401}"] = "对{npc:3401}使用/salute",
	-- {quest:2458} Deep Cover · {item:8051} Flare Gun
	["{quest:2458}: keep the {item:8051}"] = "{quest:2458}：保留{item:8051}",

	-- Step 3: Taskmaster Fizzule
	-- {area:382} Sludge Fen · {item:8051} Flare Gun · {npc:3401} Shenthul
	["Fly to the Crossroads and head north to the Venture Co. tower above the {area:382}. Fizzule stands under a tree east of the tower, outside it, and is hostile until signalled. Target him from about 50 yards and fire the {item:8051} twice, then walk up in front of him and /salute. In any other order he attacks. Lost the {item:8051}? Abandon and retake from {npc:3401}."] = "飞往十字路口，向北前往{area:382}上方的风险投资公司高塔。费苏勒站在塔东边外面的一棵树下，发出信号前处于敌对状态。约50码外选中他，使用{item:8051}发射两次，再走到他面前使用/salute。顺序不对他就会攻击。丢了{item:8051}？放弃任务，再找{npc:3401}重接。",
	-- {item:8051} Flare Gun
	["{item:8051}, twice, at Fizzule"] = "在费苏勒处使用两次 {item:8051}。",

	-- Step 4: Silixiz's Tower Key
	-- {item:8066} Fizzule's Whistle · {npc:7287} Foreman Silixiz · {spell:921} Pick Pocket
	["Keep {item:8066} in your bags and use it on him every time you come near, or he turns hostile. {npc:7287} (level 22) walks by the tower: hug the wall, stealth up behind him and {spell:921} the key. Killing him does not give it; if his pockets are empty, kill him and wait 4 1/2 minutes for him to come back."] = "把{item:8066}留在背包中，每次靠近他时都对他使用，否则他会变为敌对。{npc:7287}（22级）在塔楼旁走动：紧贴墙壁，潜行绕到他身后，用{spell:921}偷取钥匙。击杀他不会获得钥匙；如果他口袋里空了，就杀掉他，等4分半钟刷新。",
	-- {item:8072} Silixiz's Tower Key
	["Pick Pocket Foreman Silixiz for {item:8072}"] = "对工头希利克斯使用搜索，获得{item:8072}",

	-- Step 5: The Venture Co. tower
	["The Venture Co. tower"] = "风险投资公司的塔楼",
	-- {spell:1943} Rupture · {spell:2098} Eviscerate · {npc:7288} Grand Foreman Puzik Gallywix · {spell:1776} Gouge · {spell:5277} Evasion · {item:7676} Thistle Tea · {object:129127} Gallywix's Lockbox · {spell:9810} Touch of Zanzil · {npc:2391} Serge Hinott
	-- plural, as words: Mutated Venture Co. Drones = {npc:7310} Mutated Venture Co. Drone
	["Inside, floor by floor (everything comes back after 4 1/2 minutes): the Mutated Venture Co. Drones (level 25) on the ground floor die to one Ambush with a dagger; the Patrollers on the second floor take half their health from a one-point {spell:1943}; the Lookouts on the open third floor from a one-point {spell:2098}. {npc:7288} waits on the top floor: a level 23 elite, back 10 minutes after a kill. Open with Ambush (about half his health), then {spell:1776}, {spell:5277}, a healing potion and {item:7676}; a friend makes it easy. One head per kill. Then pick {object:129127} beside him for the cache: it poisons you with the {spell:9810}, which weakens your stealth and agility until {npc:2391} cures it."] = "进入后逐层推进（所有小怪都在 4 1/2 分钟后刷新）：底层的变异风险投资公司工人（25 级）会被一次匕首伏击直接杀死；二层的巡逻者会被一星 {spell:1943} 打掉一半生命值；三层露天的哨兵则会被一星 {spell:2098} 打掉一半生命值。{npc:7288} 在顶层等着：23 级精英，击杀后 10 分钟刷新。先用伏击起手（约打掉一半生命值），再用 {spell:1776}、{spell:5277}、治疗药水和 {item:7676}；有朋友帮忙会轻松很多。每次击杀只有一个头颅。然后撬开他身边的 {object:129127} 获取藏品：这会让你染上 {spell:9810}，削弱潜行和敏捷，直到 {npc:2391} 将其治好。",
	-- {item:8074} Gallywix's Head · {npc:7288} Grand Foreman Puzik Gallywix
	["{item:8074}: {npc:7288} (elite)"] = "{item:8074}：{npc:7288}（精英）",

	-- Step 6: Back to Shenthul
	-- {npc:3401} Shenthul
	["Back to {npc:3401}"] = "回到{npc:3401}处",
	-- {zone:1454} Orgrimmar · {area:392} Ratchet · {item:8072} Silixiz's Tower Key · {area:263} Cleft · {item:2928} Dust of Decay · {item:6947} Instant Poison
	-- plural, as words: Empty Vials = {item:3371} Empty Vial
	["Fly back to {zone:1454} ({area:392} or the Crossroads; dying at the tower and taking the spirit healer's way back to the Crossroads is quicker). Keep {item:8072} afterwards. Before you leave the {area:263}, buy {item:2928} and Empty Vials from Rekkul: once Hinott teaches Poisons, each batch of {item:6947} takes one of each."] = "飞回{zone:1454}（从{area:392}或十字路口起飞；在塔边死亡，再通过灵魂医者回到十字路口更快）。之后保留{item:8072}。离开{area:263}前，向雷库尔购买{item:2928}和空瓶：希诺特教会你制毒后，每制作一份{item:6947}都要各用一个。",

	-- Step 7: Serge Hinott
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {zone:1421} Silverpine Forest · {area:287} Hillsbrad · {area:272} Tarren Mill · {npc:2391} Serge Hinott · {npc:2216} Apothecary Lydon · {npc:3401} Shenthul · {item:6947} Instant Poison
	["Take the zeppelin from {zone:1454} to the {zone:1458} and follow the road south through {zone:1421} into {area:287}, to {area:272}. {npc:2391} works in the building next to the flight path, beside {npc:2216}, a wagon outside. If you lost the Sample of Zanzil's Mixture, abandon and retake from {npc:3401}. Stay beside him for about a minute while he brews the cure; if it never finishes, abandon and retake from him. Then open Poisons from your spellbook to make {item:6947} from Rekkul's dust and vials, and use it on your weapon."] = "从 {zone:1454} 乘飞艇前往 {zone:1458}，再沿道路向南穿过 {zone:1421}，进入 {area:287}，前往 {area:272}。{npc:2391} 在飞行点旁的建筑中工作，就在 {npc:2216} 旁边，屋外有一辆货车。若弄丢了赞吉尔的药剂样品，放弃任务，再从 {npc:3401} 处重新接受。待在他身边约一分钟，等他调配解药；如果一直无法完成，放弃任务，再从他那里重新接受。随后在法术书中打开毒药，用雷库尔的粉尘和瓶子制作 {item:6947}，并将其涂在武器上。",
	["Wait for the cure"] = "等待解药",
	-- {npc:2391} Serge Hinott
	["{npc:2391}: Poisons"] = "{npc:2391}：毒药",
	-- {item:8095} Hinott's Oil · {spell:9810} Touch of Zanzil
	["{item:8095}: clears the {spell:9810}"] = "{item:8095}：清除 {spell:9810}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 20 {npc:3401} stands in the {object:172960}, the canyon under the {object:172982}. Target him and type /salute."] = "20级时，{npc:3401}站在{object:172982}下方的峡谷{object:172960}中。选中他并输入/salute。",
	-- ["Fly back to {zone:1454}."] = "飞回{zone:1454}。",
	-- ["Fly to the {area:380} and ride north to the Venture Co. tower north of the {area:382}. In sight of the tower, fire the {item:8051} twice, then /salute {npc:7233} before he attacks you."] = "飞往{area:380}，向北骑到{area:382}以北的风险投资公司塔楼。在能看到塔楼的地方发射两次{item:8051}，然后在{npc:7233}攻击你之前对他使用/salute。",
	-- ["Forever teaches {spell:2842} through this chain, not the trainer; the {item:7676} recipe comes with it."] = "Forever通过这条任务线而不是训练师来传授{spell:2842}；同时附带{item:7676}配方。",
	-- ["Stay stealthed. {npc:7287} carries the tower key; Gallywix (elite) and his lockbox are at the top of the tower. Kill two each of the drones, patrollers and lookouts around it."] = "保持潜行。{npc:7287}带着塔楼钥匙；加里维克斯（精英）和他的保险箱在塔顶。在塔周围的风险投资公司雄蜂、巡逻员和看守各击杀两个。",
	-- ["Take the zeppelin from {zone:1454} to the {zone:1458} and ride south through {zone:1421} to {area:272} in {area:287}. {npc:2391} stands in {area:272}; wait beside him while he brews the cure."] = "从{zone:1454}乘飞艇前往{zone:1458}，向南骑行穿过{zone:1421}，到达{area:287}的{area:272}。{npc:2391}站在{area:272}；在他旁边等他调制解药。",
	-- ["{item:8051}, twice, in sight of the tower"] = "{item:8051}，在能看到塔楼处发射两次",
	-- ["{spell:2842} (Horde)"] = "{spell:2842}（部落）",
}
