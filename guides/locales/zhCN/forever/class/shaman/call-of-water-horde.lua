-- Chinese (simplified) (zhCN): the guide forever/class/shaman/call-of-water-horde (forever/class/shaman/call-of-water-horde.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:63} Call of Water
	["{quest:63} (Horde)"] = "{quest:63}（部落）",
	-- {item:5177} Water Totem · {spell:5394} Healing Stream Totem
	["The {item:5177} that lets you place water totems, and {spell:5394} with it."] = "让你能放置水图腾的{item:5177}，以及随之而来的{spell:5394}。",

	-- Step 1: Searn Firewarder
	-- {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom · {npc:5901} Islen Waterseer · {zone:1413} Barrens · {area:362} Razor Hill
	["At 20 {npc:5892} in the {object:172957} sends you to {npc:5901} in the {zone:1413}. (Swart in {area:362} gives the same letter: carry either.)"] = "达到 20 级后，{object:172957} 中的 {npc:5892} 会让你去找 {zone:1413} 的 {npc:5901}。（{area:362} 的斯瓦特也会给你同样的信：带任意一封即可。）",

	-- Step 2: Xanis Flameweaver
	-- {npc:5906} Xanis Flameweaver · {area:1640} Spirit Rise · {zone:1456} Thunder Bluff · {npc:5901} Islen Waterseer · {zone:1413} Barrens · {npc:3066} Narm Skychaser · {area:222} Bloodhoof Village
	["At 20 {npc:5906}, a shaman trainer on {area:1640} in {zone:1456}, sends you to {npc:5901} in the {zone:1413}. ({npc:3066} in {area:222} gives the same letter: carry either.)"] = "20级时，{zone:1456} 的 {area:1640} 上的萨满祭司训练师 {npc:5906} 会派你去 {zone:1413} 找 {npc:5901}。（{area:222} 的 {npc:3066} 也会给同样的信：带任意一封即可。）",

	-- Step 3: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} is not in {area:392}: take the small coast road south from {area:392} past the pirate camp and over a low hill; her fishing hut, with a shark strung up outside, stands by the water before the pirate ship. If you reach the ship you went too far."] = "{npc:5901} 不在 {area:392} 里：从 {area:392} 沿海边小路向南，经过海盗营地，翻过一座小山；她的钓鱼小屋在海盗船前的水边，屋外挂着一条鲨鱼。走到船边就过头了。",

	-- Step 4
	-- {npc:5901} Islen Waterseer · {npc:5892} Searn Firewarder
	["{npc:5901}: {npc:5892}'s letter"] = "{npc:5901}：{npc:5892} 的信。",

	-- Step 5
	-- {npc:5901} Islen Waterseer · {npc:5906} Xanis Flameweaver
	["{npc:5901}: {npc:5906}' letter"] = "{npc:5901}：{npc:5906}的信",

	-- Step 6
	-- {npc:5901} Islen Waterseer
	["{npc:5901}: Swart's letter"] = "{npc:5901}：斯瓦特的信",

	-- Step 7
	-- {npc:5901} Islen Waterseer
	["{npc:5901}: Narm's letter"] = "{npc:5901}：纳姆的信。",

	-- Step 9: Brine
	-- {npc:5899} Brine · {zone:1413} Barrens · {area:378} Camp Taurajo · {area:1701} Blackthorn Ridge
	["{npc:5899} lives in the southern {zone:1413}, south of {area:378}: her hut sits on a hilltop of {area:1701} with a spinning windmill beside it, and the way up is the ridge by the lone tree. Quilboar camp all around the hill; Stormhides, thunderhawks and hyenas roam the plains on the way."] = "{npc:5899} 住在 {zone:1413} 南部、{area:378} 以南：她的小屋在 {area:1701} 的山顶，旁边有一座转动的风车，沿孤树旁的山脊可以上去。山周围到处是野猪人营地；沿途平原有雷角蜥蜴、雷鹰和土狼游荡。",

	-- Step 10: The Quilboar Watering Hole
	-- {object:107046} Quilboar Watering Hole
	["The {object:107046}"] = "{object:107046}",
	-- {npc:5899} Brine · {item:7766} Empty Brown Waterskin · {npc:3456} Razormane Pathfinder
	["The muddy pond below {npc:5899}'s hut. Step right into the puddle before you use the {item:7766} (too far away and it refuses). Filling it calls a hostile {npc:3456} (level 20): kill it, and watch for the quilboar hunter by the pond, who may start shooting afterwards."] = "就在 {npc:5899} 小屋下方的泥塘。先走进水洼，再使用 {item:7766}（距离太远会无法使用）。装水会召来一只敌对的 {npc:3456}（20 级）：击杀它，并留意池边的野猪人猎人，后者可能随后开始射击。",
	-- {item:7766} Empty Brown Waterskin
	["{item:7766}, standing in the puddle"] = "{item:7766}，站在水洼里使用",

	-- Step 12: The Spring Well
	-- {object:107045} Spring Well
	["The {object:107045}"] = "{object:107045}",
	-- {object:107045} Spring Well · {area:272} Tarren Mill · {zone:1413} Barrens · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1458} Undercity · {zone:1421} Silverpine Forest · {area:287} Hillsbrad · {item:7768} Empty Red Waterskin
	["The {object:107045} stands in the middle of {area:272}, just outside the church. From the {zone:1413}: the zeppelin from {zone:1454} to {zone:1420}, then south past the {zone:1458} and through {zone:1421} (or fly once you have the {area:272} flight path). {area:287} is contested: Alliance players may attack. Stand beside the well and use the {item:7768}."] = "{object:107045} 就在 {area:272} 中央、教堂外面。从 {zone:1413} 出发：在 {zone:1454} 坐飞艇到 {zone:1420}，然后向南经过 {zone:1458}，穿过 {zone:1421}（开通 {area:272} 的飞行路线后也可以飞过去）。{area:287} 是争夺中的领土：联盟玩家可能会攻击你。站在井旁使用 {item:7768}。",
	-- {item:7768} Empty Red Waterskin
	["{item:7768}, beside the well"] = "{item:7768}，在井边",

	-- Step 14: The Ruins of Stardust
	-- {area:415} Astranaar · {zone:1413} Barrens · {area:1703} Mor'shan Rampart · {npc:12836} Wandering Protector · {zone:1440} Ashenvale · {item:7767} Empty Blue Waterskin
	["The right fountain stands in a ring of standing stones on the island of the small green lake south of {area:415}, west of Lake Mystral (not the island in Lake Mystral itself). From the {zone:1413} take the road north through the {area:1703} and on west. Water elementals and walking treants guard the lake and root you in place; an elite {npc:12836} roams {zone:1440} and can pass close by. Use the {item:7767} beside the fountain."] = "正确的泉水位于{area:415}以南、密斯特拉湖以西的绿色小湖岛上，周围有一圈竖石（不是密斯特拉湖本身的岛）。从{zone:1413}沿路向北穿过{area:1703}，再向西走。湖边有水元素和巡游的树人守卫，它们会将你定身；精英{npc:12836}在{zone:1440}游荡，可能从附近经过。在泉水旁使用{item:7767}。",
	-- {item:7767} Empty Blue Waterskin
	["{item:7767}, beside the fountain"] = "{item:7767}，在喷泉旁",

	-- Step 15: Brine
	-- {npc:5899} Brine · {item:7810} Vial of Purest Water · {npc:5901} Islen Waterseer
	["Back to {npc:5899}. She gives you the {item:7810} for {npc:5901}."] = "返回{npc:5899}身边。她会给你{item:7810}，让你交给{npc:5901}。",
	-- {item:7810} Vial of Purest Water · {npc:5901} Islen Waterseer
	["the {item:7810}, for {npc:5901}"] = "{item:7810}，交给{npc:5901}",

	-- Step 16: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {item:6637} Water Sapta · {item:7811} Remaining Drops of Purest Water
	["{npc:5901} hands you the {item:6637} and the {item:7811}: take everything she offers before you leave for Silverpine, or you will be back for more."] = "{npc:5901} 会给你 {item:6637} 和 {item:7811}：前往银松森林前，拿齐她给的所有物品，否则还得回来补拿。",
	-- {npc:5901} Islen Waterseer · {item:6637} Water Sapta
	["{npc:5901}: your {item:6637}"] = "{npc:5901}：你的{item:6637}",

	-- Step 17: Lost the Water Sapta?
	-- {quest:972} Water Sapta
	["Lost the {quest:972}?"] = "弄丢了{quest:972}？",
	-- {quest:972} Water Sapta · {npc:5901} Islen Waterseer
	["Only if the {quest:972} is gone from your bags: {npc:5901} gives you another."] = "仅在 {quest:972} 已经不在背包里时需要：{npc:5901} 会再给你一份。",
	-- {npc:5901} Islen Waterseer · {quest:972} Water Sapta
	["{npc:5901}: a new {quest:972}"] = "{npc:5901}：新的{quest:972}",

	-- Step 18: The Brazier of Everfount
	-- {object:113791} Brazier of Everfount
	["The {object:113791}"] = "{object:113791}",
	-- {area:228} Sepulcher · {item:6637} Water Sapta · {npc:5894} Corrupt Minor Manifestation of Water · {spell:8056} Frost Shock · {spell:122} Frost Nova
	["Fly to the {area:228}. The shrine lies in a hollow just south-west of it: go round the back of the crypt to the thick tree between the two hills, hop past it onto the rocks and drop west down the slope to the pool (each drop costs a little health). Drink the {item:6637} beside the tall standing stone by the pool: several water elementals appear, and only the corrupt one near the middle can be attacked (Tab picks it). The {npc:5894} is level 22 and casts {spell:8056} and {spell:122}; if someone just killed it, it is back in about three minutes. Its bracers always drop."] = "飞往{area:228}。神龛在其西南不远处的洼地中：绕到墓穴后方，找到两座山丘之间的粗树，跳过树旁登上岩石，再向西沿坡跳下到水池（每次落下都会损失少量生命值）。在池边高耸的竖石旁喝下{item:6637}：会出现几个水元素，只有接近中央的腐化水元素能攻击（按 Tab 可选中）。{npc:5894}为22级，会施放{spell:8056}和{spell:122}；若刚被别人击杀，约3分钟后刷新。它必定掉落护腕。",
	-- {item:6637} Water Sapta
	["{item:6637}, beside the standing stone"] = "在竖立的石碑旁使用 {item:6637}。",

	-- Step 19: The Minor Manifestation of Water
	-- {npc:5895} Minor Manifestation of Water
	["The {npc:5895}"] = "{npc:5895}",
	-- {object:113791} Brazier of Everfount · {npc:5895} Minor Manifestation of Water · {spell:8202} Sapta Sight · {item:7813} Shard of Water · {npc:5901} Islen Waterseer · {quest:63} Call of Water · {quest:972} Water Sapta · {npc:7007} Tiev Mordune
	["Click the {object:113791} to place the bracers and the drops. A few seconds later the pure {npc:5895} rises on the stone in the middle of the pool: speak to it while the {spell:8202} lasts (drink again by the stone if it has worn off). It gives you the {item:7813} for {npc:5901}. Gone before you could speak to it? Back at {npc:5901} ask for {quest:63} (a fresh {quest:972} for {npc:7007}, who stands just west of the shrine): hand it to Tiev, stay close while he calls the spirit back, then speak to it."] = "点击 {object:113791}，放上护腕和水滴。几秒后，纯净的 {npc:5895} 会在池中央的石头上出现：趁 {spell:8202} 仍然有效时与它交谈（若效果已经消失，在石头旁再喝一次）。它会给你要带给 {npc:5901} 的 {item:7813}。还没来得及交谈它就消失了？回 {npc:5901} 处索取 {quest:63}（一份新的 {quest:972}，交给站在神殿西侧不远处的 {npc:7007}）：把它交给提夫，留在附近等他再次召唤灵魂，再与灵魂交谈。",

	-- Step 20: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet · {item:5177} Water Totem
	["Back to {npc:5901} south of {area:392}. Keep the {item:5177} in your bags for good: every water totem needs it."] = "返回 {area:392} 南侧的 {npc:5901} 处。务必将 {item:5177} 永久留在背包中：所有水之图腾都需要它。",
	-- {npc:5901} Islen Waterseer · {spell:5394} Healing Stream Totem · {item:5177} Water Totem
	["{npc:5901}: {spell:5394} and your {item:5177}"] = "{npc:5901}：{spell:5394}和你的{item:5177}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 20 {npc:5892} in the {object:172957} sends you to {npc:5901} in the {zone:1413}."] = "20级时，{object:172957}的{npc:5892}会让你去{zone:1413}找{npc:5901}。",
	-- ["At 20 {npc:5906}, a shaman trainer in {zone:1456}, sends you to {npc:5901} in the {zone:1413}."] = "20级时，{zone:1456}的萨满祭司训练师{npc:5906}会让你去{zone:1413}找{npc:5901}。",
	-- ["Fill the {item:7766} at the quilboar watering hole"] = "在野猪人水坑装满{item:7766}",
	-- ["Fill the {item:7767} at the fountain"] = "在喷泉装满{item:7767}",
	-- ["Fill the {item:7768} at the {object:107045}"] = "在{object:107045}装满{item:7768}",
	-- ["Fly to the {area:228}: the {object:113791} stands on the hill just south-west of it. Drink the {item:6637} there, beat the {npc:5894} for its bracers and place them in the brazier, then speak to the {npc:5895} and keep the {item:7813} for {npc:5901}."] = "飞往{area:228}：{object:113791}就在它西南边的山丘上。在那里喝下{item:6637}，击败{npc:5894}拿到它的护腕并放进火盆，然后与{npc:5895}交谈，把{item:7813}留给{npc:5901}。",
	-- ["Take the zeppelin from {zone:1454} to {zone:1420} and travel south to {area:272}. The {object:107045} stands beside the inn."] = "从{zone:1454}乘飞艇前往{zone:1420}，然后向南前往{area:272}。{object:107045}就在旅店旁边。",
	-- ["The fountain stands in the middle of the {area:418}, in south-western {zone:1440}."] = "喷泉位于{zone:1440}西南部{area:418}的中央。",
	-- ["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}."] = "{npc:5899}的小屋位于{area:378}南边、野猪人水坑上方的山脊上。",
	-- ["{npc:5901} waits on the hill south of {area:392}."] = "{npc:5901}在{area:392}南边的山丘上等候。",
}
