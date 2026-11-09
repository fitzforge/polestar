-- Chinese (simplified) (zhCN): the guide forever/class/rogue/poisons-alliance (forever/class/rogue/poisons-alliance.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Poisons (Alliance)"] = "毒药（联盟）",
	-- {item:7676} Thistle Tea
	["Forever teaches Poisons through this chain, not the trainer; the {item:7676} recipe comes with it."] = "无限 通过这条任务线而不是训练师教授毒药；同时获得{item:7676}的配方。",

	-- Step 1: Mathias and the Defias
	-- {npc:332} Master Mathias Shaw · {object:2100} Old Town · {npc:7024} Agent Kearnen · {zone:1436} Westfall
	["At 20 {npc:332}, upstairs in the SI:7 building in {object:2100}, sends you to {npc:7024} in {zone:1436}. This chain is how you learn Poisons on Forever, so do not skip it."] = "20级时，{object:2100}军情七处大楼楼上的{npc:332}会让你去找{zone:1436}的{npc:7024}。在无限，这条任务链用于学习毒药技能，不要跳过。",

	-- Step 2: Agent Kearnen
	-- {npc:7053} Klaven Mortwake · {zone:1436} Westfall · {zone:1431} Duskwood · {item:8046} Kearnen's Journal
	["Kearnen hides stealthed against the west side of a big tree with two small trees in front of it, just north of {npc:7053}'s Defias tower in the far east of {zone:1436}, by the {zone:1431} border. Read {item:8046} for the tower's layout if you like."] = "密探吉尔妮潜行藏在一棵大树的西侧，树前有两棵小树；位置在{zone:1436}最东面、{npc:7053}的迪菲亚塔楼正北方，靠近{zone:1431}边界。想了解塔楼内部布局，可以阅读{item:8046}。",

	-- Step 3: The Defias Tower Key
	-- {item:7923} Defias Tower Key
	["The {item:7923}"] = "{item:7923}",
	-- {npc:7051} Malformed Defias Drone · {spell:921} Pick Pocket · {spell:2983} Sprint
	-- plural, as words: Defias Drones = {npc:7050} Defias Drone
	["Get the key first. The {npc:7051} (level 23, not elite) starts at the tower entrance and walks a loop around the outside; it is the spiky-haired one trailing yellow sparkles. Stealth up and {spell:921} it from behind: it always has the key. It hits hard: if stealth breaks, {spell:2983} away. Watch for the pair of Defias Drones that also patrol."] = "先拿钥匙。{npc:7051}（23级，非精英）从塔楼入口出发，绕外侧巡逻；就是那个尖刺发型、身后拖着黄色光点的敌人。潜行靠近，从背后对其使用{spell:921}：必定能偷到钥匙。它伤害很高，若潜行被打破，就用{spell:2983}逃离。也要留意同时巡逻的两名迪菲亚苦工。",
	-- {spell:921} Pick Pocket · {npc:7051} Malformed Defias Drone · {item:7923} Defias Tower Key
	["{spell:921} the {npc:7051} for the {item:7923}"] = "对{npc:7051}使用{spell:921}，获得{item:7923}",

	-- Step 4: Klaven's journal
	["Klaven's journal"] = "克拉文的日记",
	-- {npc:7053} Klaven Mortwake · {object:123214} Duskwood Chest · {area:97} Alther's Mill · {spell:9810} Touch of Zanzil
	-- plural, as words: Defias Tower Patrollers = {npc:7052} Defias Tower Patroller
	["Sneak up the tower. Defias Tower Patrollers (23) and Sentries (24) guard the floors; an Ambush with a dagger kills them outright if you would rather clear them. {npc:7053}, a level 26 elite, waits on the top floor: Sap him, or bring a friend. The {object:123214} beside his desk needs Lockpicking of about 70-75 (practise on the boxes at {area:97} in Redridge first). A trick: while the Sentries are away, jump from the chair to the lamp to the bookshelf above the chest, step out of stealth and open the chest from there. Opening it poisons you with the {spell:9810}, which stops your stealth for a while and lets the drone see you; that is why the key comes first. Then get out."] = "潜行上塔。迪菲亚巡塔员（23级）和哨兵（24级）守着各层；如果想清掉它们，用匕首伏击可以直接击杀。{npc:7053} 是26级精英，在顶层等候：用闷棍控制他，或找个朋友帮忙。他书桌旁的 {object:123214} 需要约70—75点开锁技能（先去赤脊山 {area:97} 的箱子上练习）。一个技巧：趁哨兵不在时，从椅子跳到灯上，再跳到箱子上方的书架上，解除潜行，从那里打开箱子。开箱会使你中了 {spell:9810}，让你一段时间内无法潜行，也会让无人机发现你；因此要先拿钥匙。然后离开。",
	-- {item:7908} Klaven Mortwake's Journal · {object:123214} Duskwood Chest
	["{item:7908}: the {object:123214}, top floor"] = "{item:7908}：顶层的 {object:123214}",

	-- Step 5: Master Mathias Shaw
	-- {zone:1453} Stormwind · {item:7676} Thistle Tea · {item:6947} Instant Poison · {item:2928} Dust of Decay · {item:3371} Empty Vial · {npc:1325} Jasper Fel · {npc:1326} Sloan McCoy · {object:2100} Old Town
	["Head north through Elwynn to {zone:1453}; Mathias Shaw is upstairs in SI:7. He teaches Poisons and gives you the {item:7676} recipe. Poisons are made, not bought: each batch of {item:6947} takes a {item:2928} and an {item:3371}, which {npc:1325} and {npc:1326} sell in {object:2100} next to SI:7. Buy a stack of each, open Poisons from your spellbook to make them, then use a poison on your weapon."] = "穿过艾尔文森林北上前往 {zone:1453}；马迪亚斯·肖尔在军情七处楼上。他会教你毒药技能，并给你 {item:7676} 配方。毒药需要制作，不能直接购买：每批 {item:6947} 需要一份 {item:2928} 和一个 {item:3371}，军情七处旁 {object:2100} 的 {npc:1325} 和 {npc:1326} 都有出售。各买一组，从法术书中打开毒药界面制作，再将毒药涂在武器上。",
	-- {npc:332} Master Mathias Shaw
	["{npc:332}: Poisons"] = "{npc:332}：毒药",

	-- Step 6: Doc Mixilpixil
	-- {quest:2607} The Touch of Zanzil · {npc:7207} Doc Mixilpixil · {npc:1325} Jasper Fel
	["{quest:2607} still sits on you. {npc:7207} works in the cellar of the SI:7 building: the stairs down are under the stairs to the upper floor, behind {npc:1325}. Target him and type /lay (nothing after it) to be examined, then wait. If he does nothing, abandon the quest, take it again and wait until he asks you to lie down."] = "你身上仍有{quest:2607}。{npc:7207}在军情七处大楼的地下室工作：向下的楼梯就在上楼楼梯下方、{npc:1325}身后。选中他并输入 /lay（后面不要加任何内容）让他检查，然后等待。若他没有反应，放弃任务后重新接受，等他要求你躺下。",
	["/lay with the Doc targeted"] = "选中医生后输入 /lay。",

	-- Step 7: The cure's ingredients
	["The cure's ingredients"] = "解药的材料",
	-- {zone:1453} Stormwind · {item:3421} Simple Wildflowers · {npc:1303} Felicia Gump · {object:2096} Trade District · {item:3372} Leaded Vial · {npc:1257} Keldric Boucher · {npc:1325} Jasper Fel · {item:4371} Bronze Tube · {item:8431} Spool of Light Chartreuse Silk Thread · {object:2177} The Finest Thread (no name in this language: may be words) · {item:6452} Anti-Venom · {skill:129} First Aid · {spell:526} Cure Poison · {spell:9810} Touch of Zanzil
	["All four are in {zone:1453}. {item:3421}: Bernard or {npc:1303}'s flower shop by the {object:2096} canal. A {item:3372}: many general goods and alchemy vendors ({npc:1257}, {npc:1325} and others). A {item:4371}: the Auction House in the {object:2096}; the engineering suppliers keep only one and are nearly always sold out, and an engineer can make one. The {item:8431} lies on the floor beside the left end of the counter in {object:2177}, the tailor's shop on the canals; you can only pick it up with this quest. If you skip the cure, an {item:6452} ({skill:129}) or a druid's {spell:526} also clears the {spell:9810}."] = "",
	-- {item:4371} Bronze Tube
	["{item:4371}: the Auction House"] = "",

	-- Step 8: Back to Doc Mixilpixil
	-- {npc:7207} Doc Mixilpixil
	["Back to {npc:7207}"] = "回到{npc:7207}处",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["/lay down"] = "/lay down",
	-- ["All four are in {zone:1453}. {item:3421}: Bernard or {npc:1303}'s flower shop by the {object:2096} canal. A {item:3372}: many general goods and alchemy vendors ({npc:1257}, {npc:1325} and others). A {item:4371}: an engineering supplier, who keeps only a few (or an engineer or the Auction House). The {item:8431} lies on the floor beside the left end of the counter in {object:2177}, the tailor's shop on the canals; you can only pick it up with this quest. If you skip the cure, an {item:6452} ({skill:129}) or a druid's {spell:526} also clears the {spell:9810}."] = "四样东西都在 {zone:1453}。{item:3421}：在 {object:2096} 运河旁的伯纳德或 {npc:1303} 的花店购买。一个 {item:3372}：许多杂货商和炼金商人都有售（如 {npc:1257}、{npc:1325} 等）。一个 {item:4371}：找工程学供应商购买，存货很少（也可以找工程师或去拍卖行）。{item:8431} 位于运河旁裁缝店 {object:2177} 柜台左端旁的地板上；只有接到本任务后才能拾取。如果跳过解药任务，{item:6452}（{skill:129}）或德鲁伊的 {spell:526} 也能移除 {spell:9810}。",
	-- ["At 20 {npc:332} at SI:7 in {object:2100} sends you to {npc:7024} in {zone:1436}."] = "20级时，{object:2100}军情七处的{npc:332}会让你去找{zone:1436}的{npc:7024}。",
	-- ["Everything is in {zone:1453}: the Gumps sell {item:3421}, the {item:8431} lies in the city, and the nearest vendors sell a {item:3372} and a {item:4371}."] = "所有东西都在{zone:1453}：加姆一家出售{item:3421}，{item:8431}在城里某处，最近的商人出售{item:3372}和{item:4371}。",
	-- ["Forever teaches {spell:2842} through this chain, not the trainer; the {item:7676} recipe comes with it."] = "Forever 通过这条任务线而不是训练师教授{spell:2842}；同时获得{item:7676}的配方。",
	-- ["Ride north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "向北穿过艾尔文森林前往{zone:1453}；马迪亚斯·肖尔在{object:2100}的军情七处。",
	-- ["{item:7908}, in the {object:123214}"] = "{item:7908}，在{object:123214}里",
	-- ["{npc:7024} watches {npc:7053}'s tower from the hills in the far east of {zone:1436}, by the {zone:1431} border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "{npc:7024}在{zone:1436}最东边、靠近{zone:1431}边界的山丘上监视{npc:7053}的塔楼。守卫塔楼的{npc:7051}（23级）身上有钥匙；克拉文的日记在塔顶的箱子里。",
	-- ["{npc:7207} works in the cellar of SI:7, the Barracks. Type /lay down beside him to be examined."] = "{npc:7207}在军情七处（兵营）的地下室工作。在他旁边输入 /lay down 接受检查。",
	-- ["{spell:2842} (Alliance)"] = "{spell:2842}（联盟）",
}
