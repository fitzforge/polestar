-- Chinese (simplified) (zhCN): the guide forever/reputation/timbermaw-hold (forever/reputation/timbermaw-hold.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Timbermaw Hold Reputation"] = "木喉要塞声望",
	["Safe passage through the tunnels, agility enchants and furbolg recipes; the trinket at Exalted."] = "安全穿过隧道，获得敏捷附魔和熊怪配方；崇拜时可获得饰品。",
	["Recipes for Leatherworkers, Tailors, Enchanters and Alchemists from Friendly to Revered"] = "友善到崇敬期间可获得制皮、裁缝、附魔和炼金术配方",

	-- Step 1: Grazle
	-- {faction:576} Timbermaw Hold · {npc:11554} Grazle · {npc:15395} Nafien · {npc:11556} Salfa · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["{faction:576} starts at Hostile (2,500 of 3,000), so its furbolgs attack you in their tunnels; {npc:11554}, {npc:15395} and {npc:11556} talk to everyone. {npc:11554} waits by the road in the south of {zone:1448}, near the {area:2479}. Every Deadwood and Winterfall furbolg you kill gives 5 reputation up to the last point of Honored, so the quests below pay twice. The Legacy perk Diplomat adds up to 10% to every gain."] = "{faction:576} 的初始声望为敌对（3,000 点中的 2,500 点），因此隧道里的熊怪会攻击你；{npc:11554}、{npc:15395} 和 {npc:11556} 则愿意与所有人交谈。{npc:11554} 在 {zone:1448} 南部、{area:2479} 附近的路旁等候。每杀一只死木或冬泉熊怪可获得 5 点声望，直到尊敬的最后一点，因此下面的任务既有任务声望，也有击杀声望。传承天赋“外交家”使每次获取量最多额外提高 10%。",

	-- Step 2: Deadwood Village
	-- {zone:1448} Felwood · {item:21377} Deadwood Headdress Feather · {npc:9464} Overlord Ror · {npc:14342} Ragepaw
	["The Deadwood furbolgs (level 48-50) hold the village at the south end of {zone:1448}. Keep every {item:21377}: they are worth 10 reputation each later and never stop counting. {npc:9464} (15 reputation) and the rare {npc:14342} (25) live here and count until Exalted. Forever pays quests in full at any level; in Classic grey mobs gave about a fifth, about 1 a kill for these furbolgs at 60. Do it while leveling if you can."] = "",
	-- {npc:14342} Ragepaw
	["{npc:14342}, rare"] = "{npc:14342}，稀有",

	-- Step 3: Back to Grazle
	-- {npc:11554} Grazle
	["Back to {npc:11554}"] = "回到{npc:11554}那里",

	-- Step 4: Nafien
	-- {npc:15395} Nafien · {zone:1448} Felwood
	["{npc:15395} stands at the {zone:1448} mouth of the Timbermaw tunnel, at the top of the road in the north of {zone:1448}."] = "{npc:15395} 站在木喉隧道的 {zone:1448} 一侧入口，位于 {zone:1448} 北部道路的顶端。",

	-- Step 5: Felpaw Village
	-- {npc:9462} Chieftain Bloodmaw
	["The northern Deadwood (level 53-55) camp just south of the tunnel. They drop feathers about half the time: the best feather spot. {npc:9462} gives 15 until Exalted."] = "北部的死木熊怪（53—55级）就在隧道南边不远处扎营。羽毛掉率约为一半：这是刷羽毛最好的地点。击杀 {npc:9462} 奖励15点，直到崇拜。",

	-- Step 6: Back to Nafien
	-- {npc:15395} Nafien
	["Back to {npc:15395}"] = "回到{npc:15395}那里",
	-- {quest:8460} Timbermaw Ally
	["These quests and their kills bring you just past Unfriendly (500 from the start). If {quest:8460} paid you less (at level 60 in Classic: 30), kill about 40 more northern Deadwood. From Unfriendly the Timbermaw in the tunnel leave you alone."] = "这些任务及沿途击杀会让你刚刚进入冷淡（从初始声望起增加 500 点）。如果 {quest:8460} 给你的奖励较少（经典怀旧服中，60 级为 30 点），就再杀约 40 只北部死木熊怪。到冷淡后，隧道内的木喉熊怪就不会主动攻击你。",

	-- Step 7: Salfa
	-- {zone:1452} Winterspring · {npc:11556} Salfa
	["Walk through the tunnel to its {zone:1452} mouth; {npc:11556} stands just outside. Do not attack any Timbermaw: each one costs 25 reputation."] = "穿过隧道来到 {zone:1452} 一侧的出口；{npc:11556} 就站在洞外。不要攻击任何木喉熊怪：每杀一只会损失25点声望。",

	-- Step 8: Winterfall Village
	-- {area:2244} Winterfall Village · {zone:1452} Winterspring · {area:2255} Everlook · {item:21383} Winterfall Spirit Beads · {npc:10199} Grizzle Snowpaw · {npc:10738} High Chief Winterfall
	["{area:2244} lies in the east of {zone:1452}, just past {area:2255}. Keep every {item:21383} you loot (10 reputation each later). The Shamans, Den Watchers and Ursas share their spawn points, so kill every furbolg in the village to make the ones you need appear; more Ursas walk the ridge just south-west of the village. {npc:10199} (rare) and {npc:10738}, in the cave at the back, give 25 until Exalted. Alliance: the Wintersaber Trainers' Winterfall Intrusion asks for the same Shamans and Ursas."] = "{area:2244} 位于 {zone:1452} 东部，刚过 {area:2255} 就到。保留所有拾取到的 {item:21383}（之后每个值10声望）。萨满祭司、冬泉巢穴守卫 和 冬泉巨熊怪 共用刷新点，因此要击杀村内所有熊怪，让需要的种类刷出来；村庄西南面不远的山脊上还有更多 冬泉巨熊怪。{npc:10199}（稀有）和后方洞穴内的 {npc:10738} 各给25声望，直到崇拜。联盟：冬刃豹训练师的“冬泉熊怪的侵扰”也要求击杀这些萨满祭司和 冬泉巨熊怪。",
	-- {npc:10199} Grizzle Snowpaw
	["{npc:10199}, rare"] = "{npc:10199}，稀有",
	-- {npc:10738} High Chief Winterfall
	["{npc:10738}, elite"] = "{npc:10738}，精英",

	-- Step 9: Back to Salfa
	-- {npc:11556} Salfa
	["Back to {npc:11556}"] = "回到{npc:11556}那里",
	-- {quest:8466} Feathers for Grazle · {quest:8467} Feathers for Nafien · {quest:8469} Beads for Salfa
	["{quest:8466}, {quest:8467} and {quest:8469} are open now: 50 reputation for 5 feathers or 5 beads, as often as you like. Do not hand them in yet."] = "现在已可接受 {quest:8466}、{quest:8467} 和 {quest:8469}：每 5 根羽毛或 5 颗珠串换取 50 点声望，可以无限重复。先不要交还。",

	-- Step 10: Unfriendly to Neutral
	["Unfriendly to Neutral"] = "冷淡到中立",
	-- {zone:1448} Felwood · {area:2246} Frostfire Hot Springs · {area:2243} Timbermaw Post · {npc:11556} Salfa · {area:2244} Winterfall Village
	["Unfriendly to Neutral is 3,000: about 540 more kills after these quests. Three camps: the northern Deadwood by the {zone:1448} mouth of the tunnel; the Winterfall camps around {area:2246} and {area:2243}, just south and south-east of {npc:11556} (Pathfinders give 6 a kill, Den Watchers and Totemics 5, the shortest walk to a turn-in); and {area:2244} in the east. Pick the least crowded. Keep all feathers and beads."] = "冷淡到中立需要3,000：完成这些任务后还需击杀约540只。有三处营地：北部死木熊怪营地，靠近隧道的{zone:1448}一端；{area:2246}和{area:2243}周围的冬泉营地，就在{npc:11556}南方及东南方不远处（探路者每只6点，巢穴守卫和图腾师每只5点，离交还点最近）；以及东部的{area:2244}。选人最少的。保留所有羽毛和珠串。",
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["Deadwood Headdress Feathers: keep them"] = "死木头饰羽毛：保留",
	-- {item:21383} Winterfall Spirit Beads
	["{item:21383}: keep them"] = "{item:21383}：保留它们",
	-- {area:2246} Frostfire Hot Springs
	-- plural, as words: Winterfall Pathfinders = {npc:7442} Winterfall Pathfinder
	["Winterfall Pathfinders, {area:2246}"] = "冬泉探路者，{area:2246}",

	-- Step 11: Deadwood Ritual Totem
	-- {quest:8470} Deadwood Ritual Totem · {npc:11558} Kernda · {zone:1448} Felwood
	-- plural, as words: Mana Potions = {item:3827} Mana Potion
	["The northern Deadwood rarely drop a {quest:8470} (about 3%). From Neutral, {npc:11558} takes it in the tunnel, on the {zone:1448} side: 150 reputation and two Major Healing and Mana Potions."] = "北部的死木熊怪有较低概率掉落 {quest:8470}（约 3%）。从中立起，可交给隧道中 {zone:1448} 一侧的 {npc:11558}：奖励 150 点声望，以及特效治疗药水和特效法力药水各两瓶。",

	-- Step 12: Winterfall Ritual Totem
	-- {quest:8471} Winterfall Ritual Totem · {npc:11558} Kernda
	-- plural, as words: Mana Potions = {item:3827} Mana Potion
	["The Winterfall furbolgs rarely drop a {quest:8471} (3-4%). {npc:11558} takes it in the tunnel too: 150 reputation and three Major Healing and Mana Potions."] = "冬泉熊怪有小概率掉落 {quest:8471}（3-4%）。隧道里的 {npc:11558} 也会收取它：奖励 150 点声望，以及特效治疗药水和法力药水各三瓶。",

	-- Step 13: Neutral to Friendly
	["Neutral to Friendly"] = "中立到友善",
	["Neutral to Friendly is 3,000: 600 kills. Keep all feathers and beads."] = "中立到友善需要3,000：击杀600只。保留所有羽毛和珠串。",

	-- Step 14: Meilosh
	-- {npc:11557} Meilosh · {zone:1448} Felwood · {item:13484} Recipe: Transmute Earth to Water · {item:22392} Formula: Enchant 2H Weapon - Agility · {item:20253} Pattern: Warbear Harness · {item:15065} Warbear Woolies · {quest:6031} Runecloth · {item:14342} Mooncloth · {item:15802} Mooncloth Boots
	["{npc:11557} stands in the tunnel, near its {zone:1448} mouth. From Friendly he sells: {item:13484} (1 gold 50 silver), {item:22392} (2 gold 50 silver), {item:20253} (1 gold 60 silver) and {item:15065} (2 gold). He also takes 30 {quest:6031} once for 100 reputation and a choice of shoulders or gauntlets, and Tailors with skill 290 can bring him 2 {item:14342} for 100 more and the {item:15802} pattern."] = "{npc:11557} 站在隧道里，靠近 {zone:1448} 一侧的出口。从友善起，他会出售：{item:13484}（1金币50银币）、{item:22392}（2金币50银币）、{item:20253}（1金币60银币）和 {item:15065}（2金币）。他还会一次性收取30份 {quest:6031}，奖励100点声望，并可选择肩甲或护手；技能290的裁缝还能带给他2块 {item:14342}，再获得100点声望及 {item:15802} 图样。",

	-- Step 15: Runecloth for Meilosh
	-- {quest:6031} Runecloth · {npc:11557} Meilosh
	["{quest:6031} for {npc:11557}"] = "{quest:6031}，交给 {npc:11557}",
	-- {quest:6031} Runecloth
	["{quest:6031} drops from the humanoids of the level 50-60 zones, the Deadwood and Winterfall furbolgs among them."] = "{quest:6031} 由 50-60 级地区的人型生物掉落，包括死木熊怪和冬泉熊怪。",

	-- Step 16: Sacred Cloth
	-- {npc:11557} Meilosh · {item:14342} Mooncloth · {item:15802} Mooncloth Boots
	["Tailors with skill 290: {npc:11557} takes 2 {item:14342} once for 100 reputation and teaches the {item:15802}."] = "技能290的裁缝：{npc:11557} 会一次性收取2块 {item:14342}，奖励100声望，并教授 {item:15802}。",

	-- Step 17: Friendly to Honored
	["Friendly to Honored"] = "友善到尊敬",
	-- {npc:11557} Meilosh · {item:19445} Formula: Enchant Weapon - Agility · {item:19202} Pattern: Heavy Timbermaw Belt · {item:19044} Might of the Timbermaw · {skill:165} Leatherworking · {item:19047} Wisdom of the Timbermaw · {skill:197} Tailoring
	["Friendly to Honored is 6,000: 1,200 kills. Keep all feathers and beads. Honored opens at {npc:11557}: {item:19445} (3 gold), and for 2 gold 20 silver each {item:19202} and {item:19044} ({skill:165}) and {item:19047} ({skill:197})."] = "友善到尊敬需要6,000声望：击杀1,200只。保留所有羽毛和珠串。尊敬后可向{npc:11557}购买：{item:19445}（3金币），以及每份2金20银的{item:19202}和{item:19044}（{skill:165}）、{item:19047}（{skill:197}）。",

	-- Step 18: Honored to Revered
	["Honored to Revered"] = "尊敬到崇敬",
	["Honored to Revered is 12,000: 2,400 kills, the last ones that count. Kills stop at 11,999 of 12,000 Honored and never tip you into Revered: when they stop, hand in one set of 5 feathers or beads to cross over. Saving every feather and bead pays off now: about 4,800 kills from the start to the end of Honored leave you with about 2,100 feathers and beads, and that is all of Revered to Exalted. Turning them in early would cost you about 2,400 more kills."] = "从尊敬到崇敬需要12,000声望：2,400次击杀，这是最后能靠击杀获得的声望。到尊敬11,999/12,000时，击杀不再提供声望，无法靠它升到崇敬：此时交一组5根羽毛或5颗珠子跨过上限。之前保留的所有羽毛和珠子现在派上用场：从起点刷到尊敬上限，约4,800次击杀会留下约2,100个羽毛和珠子，足以覆盖崇敬到崇拜的全部需求。提前交还会让你多刷约2,400只怪。",
	-- {item:19445} Formula: Enchant Weapon - Agility · {skill:333} Enchanting
	["{item:19445} ({skill:333}), 3 gold"] = "{item:19445}（{skill:333}），3 金",
	-- {quest:8467} Feathers for Nafien
	["{quest:8467}: once your kills stop, 5 feathers into Revered"] = "{quest:8467}：击杀不再涨声望后，交 5 根羽毛进入崇敬",
	-- {quest:8469} Beads for Salfa
	["{quest:8469}: or 5 beads"] = "{quest:8469}：或5串珠串",

	-- Step 19: Revered to Exalted
	["Revered to Exalted"] = "崇敬到崇拜",
	-- {npc:15395} Nafien · {npc:11554} Grazle · {npc:11556} Salfa · {npc:14342} Ragepaw · {npc:10199} Grizzle Snowpaw · {npc:10738} High Chief Winterfall · {npc:11557} Meilosh · {item:19204} Pattern: Heavy Timbermaw Boots · {item:19049} Timbermaw Brawlers · {skill:165} Leatherworking · {item:19050} Mantle of the Timbermaw · {skill:197} Tailoring
	["Kills stopped at the end of Honored. Revered to Exalted is 21,000: 420 turn-ins, 2,100 feathers and beads. Hand in the feathers to {npc:15395} at the tunnel or {npc:11554} in the south, the beads to {npc:11556}, five at a time. The named furbolgs (Ror, Bloodmaw, {npc:14342}, {npc:10199}, {npc:10738}) still count. Revered opens at {npc:11557}, for 4 gold each: {item:19204} and {item:19049} ({skill:165}) and {item:19050} ({skill:197})."] = "尊敬满后，击杀普通怪不再奖励声望。崇敬到崇拜需要21,000声望：交还420次，共2,100个羽毛和珠串。羽毛交给隧道旁的{npc:15395}或南面的{npc:11554}，珠串交给{npc:11556}，每次五个。具名熊怪（主宰洛尔、血喉酋长、{npc:14342}、{npc:10199}、{npc:10738}）仍会奖励声望。崇敬后可向{npc:11557}以每份4金币购买：{item:19204}和{item:19049}（{skill:165}）、{item:19050}（{skill:197}）。",
	-- {quest:8467} Feathers for Nafien
	["{quest:8467}: 5 feathers, 50 reputation"] = "{quest:8467}：5根羽毛，50声望",
	-- {quest:8466} Feathers for Grazle
	["{quest:8466}: 5 feathers, 50 reputation"] = "{quest:8466}：5根羽毛，50声望",
	-- {quest:8469} Beads for Salfa
	["{quest:8469}: 5 beads, 50 reputation"] = "{quest:8469}：5 颗珠串，50 点声望。",

	-- Step 20: The Root of All Evil
	-- {npc:11555} Gorn One Eye · {npc:11557} Meilosh · {quest:8481} The Root of All Evil · {item:21144} Demon Summoning Torch · {npc:10738} High Chief Winterfall · {npc:15623} Xandivious · {item:21326} Defender of the Timbermaw
	["At Exalted, {npc:11555}, in the tunnel by {npc:11557}, gives {quest:8481}: plant his {item:21144} in the mouth of {npc:10738}'s cave and defeat the demon {npc:15623} (level 62, elite: bring a group). The reward is {item:21326}, a trinket that calls a Timbermaw ally, and 200 reputation."] = "崇拜后，隧道内 {npc:11557} 身边的 {npc:11555} 会给予 {quest:8481}：把他的 {item:21144} 插在 {npc:10738} 的洞口，击败恶魔 {npc:15623}（62 级精英：带上小队）。奖励为可召唤木喉盟友的饰品 {item:21326}，以及 200 点声望。",

	-- Step 21: Xandivious
	-- {area:2244} Winterfall Village · {npc:15623} Xandivious
	["{area:2244}, the cave at the back. Clear the furbolgs around the mouth first, plant the torch, kill {npc:15623} and loot the Essence from his Demon Bag."] = "{area:2244}，后方的洞穴。先清掉洞口周围的熊怪，再插下火把，杀死 {npc:15623}，从他的恶魔之包里拾取精华。",
	-- {npc:15623} Xandivious
	["{npc:15623}, 25 reputation"] = "{npc:15623}，25声望",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Alternate Deadwood feathers ({npc:15395}) and Winterfall beads ({npc:11556}), whichever camp is less crowded."] = "轮流上交死木羽毛（{npc:15395}）和冬泉珠串（{npc:11556}），哪个营地人少就去哪个。",
	-- ["Deadwood furbolgs (level 48-50) camp at the southern end of {zone:1448}. Keep every {item:21377} they drop: {npc:11554} and {npc:15395} take them later."] = "死木熊怪（48-50级）在{zone:1448}南端扎营。保留它们掉落的每一根{item:21377}：{npc:11554}和{npc:15395}之后会收取。",
	-- ["Feathers and beads to Friendly"] = "用羽毛和珠串刷到友善",
	-- ["Feathers for {npc:11554} and Feathers for {npc:15395} (Deadwood Headdress Feathers) and Beads for {npc:11556} ({item:21383}) repeat as often as you like; every Deadwood or Winterfall kill counts as well. {area:2244} is the densest bead spot."] = "“给{npc:11554}的羽毛”、“给{npc:15395}的羽毛”（{item:21377}）以及“给{npc:11556}的珠串”（{item:21383}）可以无限重复；每次击杀死木或冬泉熊怪也算数。{area:2244}是珠串最密集的地方。",
	-- ["Feathers to Honored"] = "用羽毛刷到尊敬",
	-- ["Go through {faction:576} to its {zone:1452} exit; {npc:11556} stands just outside. The quests and kills so far usually reach Unfriendly, and then the Timbermaw let you pass. If they still show red, kill more Deadwood by the tunnel first."] = "穿过{faction:576}到达通往{zone:1452}的出口；{npc:11556}就站在外面。到目前为止的任务和击杀通常能达到冷淡，然后木喉熊怪就会放你通过。如果它们仍显示红色，先在隧道旁多杀些死木熊怪。",
	-- ["Keep turning in feathers and beads until Exalted."] = "继续上交羽毛和珠串，直到崇拜。",
	-- ["The Deadwood furbolgs (level 48-50) hold the village at the south end of {zone:1448}. Keep every {item:21377}: they are worth 10 reputation each later and never stop counting. {npc:9464} (15 reputation) and the rare {npc:14342} (25) live here and count until Exalted. In Classic, quests 6 or more levels below you pay less and grey mobs give about a fifth: at level 60 {quest:8460} paid 30 instead of 150 and these furbolgs about 1 a kill. Do it while leveling if you can."] = "死木熊怪（48-50级）占据了{zone:1448}最南端的村庄。保留所有{item:21377}：以后每个可换10声望，而且永远有效。{npc:9464}（15声望）和稀有{npc:14342}（25）住在这里，击杀声望一直持续到崇拜。经典旧世中，比你低至少6级的任务奖励会减少，灰名怪也只给约五分之一：60级时，{quest:8460}只给30而非150，这些熊怪每只约1点。尽可能在练级时完成。",
	-- ["The northern Deadwood (level 53-55) hold the camps just south of the tunnel. Keep their feathers too."] = "北部的死木熊怪（53-55级）占据着隧道南边不远处的营地。它们的羽毛也要保留。",
	-- ["The northern Deadwood camps by the tunnel are the densest feather spot (35% drop chance there). Hand feathers to {npc:15395} at the tunnel, or to {npc:11554} in the south."] = "隧道旁的北部死木营地是羽毛最密集的地方（那里掉率35%）。把羽毛交给隧道口的{npc:15395}，或南边的{npc:11554}。",
	-- ["{area:2244} sits on the eastern side of {zone:1452}. Keep every {item:21383} you loot: {npc:11556} takes them."] = "{area:2244}位于{zone:1452}东侧。保留你拾取的每一个{item:21383}：{npc:11556}会收取。",
	-- ["{faction:576} starts out Hostile, and its furbolgs in the tunnels attack until you reach Unfriendly. Every Deadwood and Winterfall furbolg you kill raises it, so the quests below pay twice. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:576}初始为敌对，隧道里的熊怪会攻击你，直到你达到冷淡。每杀一只死木和冬泉熊怪都会提升声望，所以下面的任务等于双倍回报。Forever的传承外交官特权可提高声望获取。",
	-- ["{faction:576} to Exalted"] = "{faction:576}刷到崇拜",
	-- ["{faction:576} to Revered"] = "{faction:576}刷到崇敬",
	-- ["{npc:11556}: Beads for {npc:11556}"] = "{npc:11556}：给{npc:11556}的珠串",
	-- ["{npc:15395} waits in northern {zone:1448} at the tunnel into {faction:576}."] = "{npc:15395}在{zone:1448}北部通往{faction:576}的隧道口等候。",
	-- ["{npc:15395}: Feathers for {npc:15395}"] = "{npc:15395}：给{npc:15395}的羽毛",
}
