-- Chinese (simplified) (zhCN): the guide forever/reputation/wintersaber-trainers (forever/reputation/wintersaber-trainers.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Wintersaber Trainers Reputation"] = "冬刃豹训练师声望",
	-- {spell:17229} Winterspring Frostsaber · {zone:1452} Winterspring
	["The {spell:17229}: 840 quest turn-ins in {zone:1452}, with Timbermaw reputation on the side."] = "{spell:17229}：在{zone:1452}交还840次任务，顺带获得木喉要塞声望。",
	-- {area:1769} Timbermaw Hold · {item:21383} Winterfall Spirit Beads · {quest:5201} Winterfall Intrusion
	["{area:1769} reputation on the side: 50 and about 4 {item:21383} per {quest:5201}"] = "顺带获得{area:1769}声望：每次{quest:5201}获得50点声望和约4个{item:21383}",

	-- Step 1: Rivern Frostwind
	-- {npc:10618} Rivern Frostwind · {area:2241} Frostsaber Rock · {zone:1452} Winterspring · {faction:589} Wintersaber Trainers · {quest:4970} Frostsaber Provisions
	["{npc:10618} stands on top of {area:2241}, in the far north of {zone:1452}; the path winds up from the east side. Only the Alliance can earn the {faction:589}' favour, from Neutral, at level 58. All three of her quests pay 50 and repeat as often as you like: 840 turn-ins from Neutral to Exalted. The first one, {quest:4970}, is the only one open at the start."] = "{npc:10618} 站在 {zone:1452} 最北部的 {area:2241} 顶上；小路从东侧蜿蜒而上。只有联盟能从 58 级起、以中立声望开始赢得 {faction:589} 的好感。她的三个任务每次都提供 50 点，可以无限重复：从中立到崇拜需要交还 840 次。最开始只开放第一个任务 {quest:4970}。",

	-- Step 2: Shardtooth and Chillwind meat
	["Shardtooth and Chillwind meat"] = "碎齿熊肉和冰风奇美拉肉",
	-- {npc:7445} Elder Shardtooth · {area:2255} Everlook · {npc:7446} Rabid Shardtooth
	-- plural, as words: Chillwind Ravagers = {npc:7449} Chillwind Ravager · Chillwind Chimaeras = {npc:7448} Chillwind Chimaera · Shardtooth Bears = {npc:7444} Shardtooth Bear
	["The meat only drops while the quest is in your log, and a group shares no loot: farm it alone. The best droppers live right below the rock: {npc:7445} bears (about half the time) and Chillwind Ravagers (half the time) roam the snowfields east and south-east of it. Around {area:2255} the Chillwind Chimaeras drop it as often and the Shardtooth Bears a little less; the {npc:7446} by the giants' gorge in the south drop it most often (six in ten)."] = "只有任务在日志中时才会掉肉，而且组队无法共享掉落：单独刷。掉率最高的就在岩石下方：熊类{npc:7445}（约一半概率）和冰风破坏者（一半概率）在岩石东侧和东南侧的雪原游荡。{area:2255}周围的冰风奇美拉掉率相同，碎齿熊略低；南方巨人峡谷旁的{npc:7446}掉率最高（十分之六）。",
	-- {item:12622} Shardtooth Meat
	["{item:12622}: the bears"] = "{item:12622}：来自熊。",
	-- {item:12623} Chillwind Meat
	["{item:12623}: the chimaeras"] = "{item:12623}：奇美拉",

	-- Step 3: Back to Rivern Frostwind
	-- {npc:10618} Rivern Frostwind
	["Back to {npc:10618}"] = "返回{npc:10618}处",

	-- Step 4: Neutral to Friendly: Frostsaber Provisions, then Winterfall Intrusion
	-- {quest:4970} Frostsaber Provisions · {quest:5201} Winterfall Intrusion
	["Neutral to Friendly: {quest:4970}, then {quest:5201}"] = "中立到友善：先做{quest:4970}，再做{quest:5201}",
	-- {quest:4970} Frostsaber Provisions · {quest:5201} Winterfall Intrusion · {area:2244} Winterfall Village · {area:2255} Everlook
	-- plural, as words: Winterfall Shamans = {npc:7439} Winterfall Shaman · Winterfall Ursas = {npc:7438} Winterfall Ursa
	["Repeat {quest:4970}: 30 turn-ins reach Neutral 1,500, and then {quest:5201} opens: 5 Winterfall Shamans and 5 Winterfall Ursas in {area:2244}, just east of {area:2255}. The village has only a few Shamans, but every furbolg there shares their spawn points: kill all of them, not just the ones you need, and more Shamans and Ursas appear; more Ursas walk the ridge just south-west of the village. Take both quests on every trip: kill the furbolgs, pick up meat on the way back. Neutral to Friendly is 60 turn-ins."] = "重复{quest:4970}：交还30次达到中立1,500，随后开放{quest:5201}：击杀{area:2255}正东边{area:2244}的5名冬泉萨满祭司和5只冬泉巨熊怪。村里只有少量萨满祭司，但所有熊怪共用刷新点：全部击杀，别只杀任务需要的，就会刷出更多萨满祭司和巨熊怪；村庄西南方不远的山脊还有巨熊怪。每趟两个任务都接：先杀熊怪，回程捡肉。中立到友善共需交还60次。",

	-- Step 5: Friendly to Honored
	["Friendly to Honored"] = "友善到尊敬",
	-- {quest:5201} Winterfall Intrusion · {quest:4970} Frostsaber Provisions · {area:1769} Timbermaw Hold · {item:21383} Winterfall Spirit Beads · {faction:589} Wintersaber Trainers
	["Friendly to Honored is 6,000: 120 turn-ins. {quest:5201} is the quickest; do {quest:4970} when the village is crowded or you pass the bears and chimaeras anyway. Every Winterfall furbolg you kill counts for {area:1769} too: 50 Timbermaw reputation per {quest:5201} up to the end of Honored with them, and about four {item:21383}. Take Salfa's Winterfall Activity (the Timbermaw guide) the first time you are in the village, and keep the beads until your Timbermaw kills stop counting: then each 5 pay 50. You will reach Exalted with the Timbermaw long before the {faction:589}."] = "从友善到尊敬需要6,000点：交还120次。{quest:5201} 最快；村里人多，或正好路过熊和奇美拉时，就做 {quest:4970}。每击杀一只冬泉熊怪，也会提升 {area:1769} 的声望：每次完成 {quest:5201}，可获得50点木喉声望，直到木喉尊敬封顶，还能获得约四个 {item:21383}。第一次到村庄时，接取萨尔法的“冬泉熊怪的活动”（参见木喉指南），珠串先留着，等击杀不再奖励木喉声望后再交：届时每5个奖励50点。你会比 {faction:589} 早得多达到木喉崇拜。",

	-- Step 6: Honored to Exalted: Rampaging Giants too
	-- {quest:5981} Rampaging Giants
	["Honored to Exalted: {quest:5981} too"] = "尊敬到崇拜：也做 {quest:5981}",
	-- {quest:5981} Rampaging Giants · {area:2249} Frostwhisper Gorge · {zone:1452} Winterspring · {area:2244} Winterfall Village · {npc:7446} Rabid Shardtooth · {item:12622} Shardtooth Meat
	-- plural, as words: Frostmaul Giants = {npc:7428} Frostmaul Giant · Frostmaul Preservers = {npc:7429} Frostmaul Preserver
	["At Honored Rivern Frostwind adds {quest:5981}: 4 Frostmaul Giants and 4 Frostmaul Preservers, elite giants in {area:2249} in the south-east of {zone:1452}; the path down into the gorge starts at its north-west end. Take it on a trip south with a friend or two, or when {area:2244} is crowded; the {npc:7446} by the gorge drop {item:12622} most often. Honored to Exalted is 33,000: 660 turn-ins."] = "达到尊敬后，雷沃·霜翼会新增 {quest:5981}：击杀 4 名霜槌巨人和 4 名霜槌保卫者，它们是 {zone:1452} 东南部 {area:2249} 的精英巨人；下到峡谷的小路从其西北端开始。可以与一两个朋友向南出行时一起做，或在 {area:2244} 人多时改做；峡谷旁的 {npc:7446} 掉落 {item:12622} 的概率最高。从尊敬到崇拜需要 33,000 点：交还 660 次。",
	-- {npc:7428} Frostmaul Giant
	["{npc:7428}, elite"] = "{npc:7428}，精英",
	-- {npc:7429} Frostmaul Preserver
	["{npc:7429}, elite"] = "{npc:7429}，精英",
}
