-- Chinese (simplified) (zhCN): the guide forever/class/priest/blood-of-morphaz (forever/class/priest/blood-of-morphaz.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1447} Azshara · {area:1417} Sunken Temple
	["17,060 XP and 1g55s at 50: {zone:1447}, then Morphaz in the {area:1417} (group of 5). The item choice may be gone."] = "50级时获得17,060 XP和1g55s：{zone:1447}，然后是{area:1417}中的摩弗拉斯（5人小队）。物品选择可能已被取消。",
	["17,060 experience and 1 gold 55 silver"] = "17,060经验和1金55银",

	-- Step 1: Cenarion Aid: High Priest Rohan
	-- {zone:1455} Ironforge · {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries · {object:32362} Mystic Ward · {quest:8254} Cenarion Aid · {item:7972} Ichor of Undeath
	["At 50 in {zone:1455}, {npc:11406} in the {object:32386} ({object:32362}) offers {quest:8254}. Before you leave a city, buy an {item:7972} at the Auction House (a few silver): the third quest asks for one and it drops rarely."] = "50级时，{zone:1455}的{object:32386}（{object:32362}）内的{npc:11406}会提供{quest:8254}。离开城市前，先在拍卖行买一个{item:7972}（几枚银币）：第三个任务会用到，而且掉率很低。",

	-- Step 2: Cenarion Aid: Brother Joshua
	-- {npc:5489} Brother Joshua · {zone:1453} Stormwind · {quest:8254} Cenarion Aid · {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {item:7972} Ichor of Undeath · {object:2096} Trade District
	["At 50, {npc:5489} at the altar of {zone:1453}'s Cathedral of Light offers {quest:8254} ({npc:11406} in {zone:1455} has it too). Before you leave, buy an {item:7972} at the Auction House in the {object:2096} (a few silver): the third quest asks for one and it drops rarely."] = "50级时，{zone:1453}圣光大教堂祭坛旁的{npc:5489}会提供{quest:8254}（{zone:1455}的{npc:11406}也有）。离开前，先在{object:2096}的拍卖行买一个{item:7972}（几枚银币）：第三个任务会用到，而且掉率很低。",

	-- Step 3: Cenarion Aid: Ur'kyo
	-- {npc:6018} Ur'kyo · {zone:1454} Orgrimmar · {object:172961} Valley of Spirits · {quest:8254} Cenarion Aid · {item:7972} Ichor of Undeath
	["At 50, {npc:6018} in {zone:1454}'s {object:172961} offers {quest:8254}. Before you leave, buy an {item:7972} at the Auction House (a few silver): the third quest asks for one and it drops rarely."] = "50级时，{zone:1454} 的 {object:172961} 中的 {npc:6018} 会提供 {quest:8254}。离开前先在拍卖行买一个 {item:7972}（几银币）：第三个任务会需要一个，而它的掉率很低。",

	-- Step 4: Ogtinc
	-- {npc:8405} Ogtinc · {area:1221} Ruins of Eldarath · {area:3137} Talrendis Point · {area:1237} Valormok
	["{npc:8405}, a furbolg, lives on the clifftop north-east of the {area:1221}. Alliance: fly to {area:3137}; Horde: fly to {area:1237}. Ride east and leave the road at the fork before the ruins, then follow the northern cliff edge east to him: the naga ruins and the beach below are walled in by cliffs with no way up."] = "熊怪{npc:8405}住在{area:1221}东北面的悬崖顶上。联盟飞往{area:3137}，部落飞往{area:1237}。骑马向东，在废墟前的岔路离开道路，然后沿北侧崖边向东找到他：娜迦废墟和下方海滩被悬崖围住，无法从下面上去。",

	-- Step 5: Of Coursers We Know
	-- {zone:1447} Azshara · {npc:8405} Ogtinc · {item:20027} Healthy Courser Gland · {item:7972} Ichor of Undeath
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers (level 52-53, not elite) graze all over {zone:1447}, thickest north-east of {npc:8405} and south of the mountains; about one in three drops a {item:20027}, so plan on a dozen kills for four. They enrage at 30% health: finish them fast. Killing them costs no Cenarion Circle reputation. Keep any {item:7972} you loot."] = "苔蹄快步者（52-53级，非精英）在{zone:1447}各处吃草，{npc:8405}东北方和山脉以南最多；掉落{item:20027}的概率约为三只出一个，因此凑齐四个预计要击杀十二只。它们在生命值降至30%时会激怒：尽快击杀。杀它们不会损失塞纳里奥议会声望。保留拾取到的所有{item:7972}。",

	-- Step 7: The Ichor of Undeath
	-- {item:7972} Ichor of Undeath · {npc:7864} Lingering Highborne · {area:1221} Ruins of Eldarath · {npc:8405} Ogtinc · {zone:1447} Azshara · {zone:1440} Ashenvale · {npc:7523} Suffering Highborne · {zone:1452} Winterspring
	["Carrying an {item:7972} already? It counts at once. Otherwise any undead may drop one, rarely: the {npc:7864} (level 48) in the {area:1221} below {npc:8405}'s cliff drop it about one kill in ten, the highborne ghosts on {zone:1447}'s border with {zone:1440} (level 45-46) a little less, the Anguished and {npc:7523} in {zone:1452} (54-55) about one in eight. The Auction House is usually quicker."] = "已经带着 {item:7972}？可以立即完成目标。否则，任何亡灵都有小概率掉落：在 {area:1221}、{npc:8405} 所在悬崖下的 {npc:7864}（48 级）约每十次击杀掉落一次；{zone:1447} 与 {zone:1440} 交界处的上层精灵鬼魂（45-46 级）掉率略低；{zone:1452} 的痛苦的上层精灵和 {npc:7523}（54-55 级）约每八次击杀掉落一次。去拍卖行通常更快。",

	-- Step 9: Morphaz in the Sunken Temple
	-- {area:1417} Sunken Temple
	["Morphaz in the {area:1417}"] = "{area:1417}中的摩弗拉斯",
	-- {area:1417} Sunken Temple · {area:75} Stonard · {area:1438} Nethergarde Keep · {zone:1419} Blasted Lands · {area:74} Pool of Tears · {npc:5710} Jammal'an the Prophet
	["Morphaz is a level 52 elite green dragon inside the {area:1417}, a five-player dungeon: bring a group of five (a level 60 group clears it with ease). Horde: fly to {area:75}; Alliance: fly to {area:1438} in the {zone:1419} and ride north. The temple stands in the middle of the {area:74}: climb the steps on its south side, swim down through the flooded hall and take the stairs to the portal. Inside, Morphaz only appears late: kill the six troll minibosses on the upper balconies, then {npc:5710} below them; that wakes the drakes Weaver and Dreamscythe in the Pit of Sacrifice, and killing both brings Morphaz and Hazzas. The pair patrols together and cannot be split: pull them into a hallway and have the tank face them away from the group (breath and a knockback). Loot him in a party, not a raid group: the blood always drops."] = "摩弗拉斯是 {area:1417} 内的一条 52 级精英绿龙，这是五人地下城：带上五人小队（60 级小队打起来很轻松）。部落：飞往 {area:75}；联盟：飞往 {zone:1419} 的 {area:1438}，再骑马向北。神庙位于 {area:74} 中央：从南侧台阶上去，游过被淹没的大厅，再沿楼梯走到传送门。进入后，要推进到后段摩弗拉斯才会出现：先杀死上层阳台上的六名巨魔小首领，再杀死下方的 {npc:5710}；这会唤醒献祭之池的德拉维沃尔和德姆塞卡尔，杀死两者后，摩弗拉斯和哈扎斯才会出现。这两条龙一起巡逻，无法拆开引：把它们拉进走廊，由坦克让龙头背对队伍（有吐息和击退）。拾取时要处于小队，而不是团队中：龙血必定掉落。",
	-- {quest:8257} Blood of Morphaz · {area:1417} Sunken Temple
	["{quest:8257}: the {area:1417} entrance"] = "{quest:8257}：{area:1417}入口",

	-- Step 10: Greta Mosshoof
	-- {npc:10922} Greta Mosshoof · {area:2479} Emerald Sanctuary · {zone:1448} Felwood · {area:1997} Bloodvenom Post · {area:415} Astranaar · {zone:1440} Ashenvale · {item:19990} Blessed Prayer Beads · {item:20006} Circle of Hope
	["{npc:10922} is at the {area:2479} in southern {zone:1448}. Horde: fly to {area:1997} and ride south-east; Alliance: fly to {area:415} in {zone:1440} and ride north into {zone:1448}. She takes the blood for experience and gold. Look at the reward window before you hand in: Classic let you pick {item:19990}, {item:20006} or Woestave, and Forever's notes say that choice may be gone."] = "{npc:10922}在{zone:1448}南部的{area:2479}。部落：飞往{area:1997}后向东南骑行；联盟：飞往{zone:1440}的{area:415}后向北骑行，进入{zone:1448}。把血交给她可获得经验和金币。交还前先查看奖励窗口：经典版可选{item:19990}、{item:20006}或悲哀之杖，而无限服的说明称这个选择可能已移除。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Already carrying an {item:7972}? It counts as soon as you take this stage. Otherwise any undead can drop it. The {npc:7864} in the {area:1221}, below {npc:8405}'s cliffs, are the nearest; Highborne Apparitions and Lichlings haunt the ruins near {area:3137}."] = "已经带着{item:7972}？接取这一阶段后它马上计入。否则任何亡灵都可能掉落。{npc:8405}的悬崖下方、{area:1221}中的{npc:7864}最近；{npc:6116}和上层精灵鬼巫出没于{area:3137}附近的废墟。",
	-- ["At 50 {npc:5489} in {zone:1453}'s Cathedral of Light or {npc:11406} in {zone:1455}'s {object:32386} offers it."] = "50级时，{zone:1453}光明大教堂的{npc:5489}或{zone:1455}{object:32386}的{npc:11406}提供此任务。",
	-- ["At 50 {npc:6018} in {zone:1454}'s {object:172961} offers it."] = "50级时，{zone:1454}{object:172961}的{npc:6018}提供此任务。",
	-- ["Experience and gold"] = "经验和金币",
	-- ["Experience and gold at 50 through {zone:1447} and the {area:1417}; Forever removed the Classic item choice."] = "50级时通过{zone:1447}和{area:1417}获取经验和金币；Forever 取消了经典版的物品选择。",
	-- ["Morphaz is an elite dragon boss inside the {area:1417}, a level 50 dungeon: bring a group of five. The temple stands in the middle of the {area:74}; swim down into it to reach the entrance. Horde: fly to {area:75}; Alliance: fly to {area:42} or {area:1438} and ride on."] = "摩弗拉斯是{area:1417}里的精英龙类首领，这是一个50级地下城：组一支五人小队。神庙位于{area:74}中央；潜入水中到达入口。部落：飞往{area:75}；联盟：飞往{area:42}或{area:1438}再骑过去。",
	-- ["Mosshoof Coursers graze all over {zone:1447}; about one in three drops a {item:20027}. Keep any {item:7972} you loot: {npc:8405}'s next stage asks for one."] = "{npc:8761}在{zone:1447}各处吃草；大约三只中有一只掉落{item:20027}。拾取到的{item:7972}要留着：{npc:8405}的下一阶段需要一份。",
	-- ["{npc:10922} is at the {area:2479} in southern {zone:1448}."] = "{npc:10922}在{zone:1448}南部的{area:2479}。",
	-- ["{npc:8405} lives atop the cliffs north-east of the {area:1221}. Alliance: fly to {area:3137}; Horde: fly to {area:1237}."] = "{npc:8405}住在{area:1221}东北的悬崖顶上。联盟：飞往{area:3137}；部落：飞往{area:1237}。",
	-- ["{quest:8254} (Alliance)"] = "{quest:8254}（联盟）",
	-- ["{quest:8254} (Horde)"] = "{quest:8254}（部落）",
}
