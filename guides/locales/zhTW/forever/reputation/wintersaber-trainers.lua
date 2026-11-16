-- Chinese (traditional) (zhTW): the guide forever/reputation/wintersaber-trainers (forever/reputation/wintersaber-trainers.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Wintersaber Trainers Reputation"] = "冬刃豹訓練師聲望",
	-- {spell:17229} Winterspring Frostsaber · {zone:1452} Winterspring
	["The {spell:17229}: 840 quest turn-ins in {zone:1452}, with Timbermaw reputation on the side."] = "{spell:17229}：在{zone:1452}做840次任務上交，順帶還有木喉聲望。",
	-- {area:1769} Timbermaw Hold · {item:21383} Winterfall Spirit Beads · {quest:5201} Winterfall Intrusion
	["{area:1769} reputation on the side: 50 and about 4 {item:21383} per {quest:5201}"] = "{area:1769}聲望順帶獲得：每完成一次{quest:5201}給50點，外加約4個{item:21383}",

	-- Step 1: Rivern Frostwind
	-- {npc:10618} Rivern Frostwind · {area:2241} Frostsaber Rock · {zone:1452} Winterspring · {faction:589} Wintersaber Trainers · {quest:4970} Frostsaber Provisions
	["{npc:10618} stands on top of {area:2241}, in the far north of {zone:1452}; the path winds up from the east side. Only the Alliance can earn the {faction:589}' favour, from Neutral, at level 58. All three of her quests pay 50 and repeat as often as you like: 840 turn-ins from Neutral to Exalted. The first one, {quest:4970}, is the only one open at the start."] = "{npc:10618}站在{area:2241}頂上，位於{zone:1452}最北端；小路從東側蜿蜒而上。只有聯盟能獲得{faction:589}的好感，從中立開始，需要58級。她的三個任務都各給50點，且可無限重複：從中立到崇拜需840次上交。第一個任務{quest:4970}是開局唯一可接的。",

	-- Step 2: Shardtooth and Chillwind meat
	["Shardtooth and Chillwind meat"] = "碎齒熊與寒風奇美拉的肉",
	-- {npc:7445} Elder Shardtooth · {area:2255} Everlook · {npc:7446} Rabid Shardtooth
	-- plural, as words: Chillwind Ravagers = {npc:7449} Chillwind Ravager · Chillwind Chimaeras = {npc:7448} Chillwind Chimaera · Shardtooth Bears = {npc:7444} Shardtooth Bear
	["The meat only drops while the quest is in your log, and a group shares no loot: farm it alone. The best droppers live right below the rock: {npc:7445} bears (about half the time) and Chillwind Ravagers (half the time) roam the snowfields east and south-east of it. Around {area:2255} the Chillwind Chimaeras drop it as often and the Shardtooth Bears a little less; the {npc:7446} by the giants' gorge in the south drop it most often (six in ten)."] = "這個肉只在你任務日誌裡有該任務時才會掉落，而且隊伍不共享拾取：獨自去刷。最好的掉落者就在岩石下方：{npc:7445}熊（約一半機率）和寒風掠奪者（一半機率）在它東邊和東南的雪原上游蕩。{area:2255}附近，寒風奇美拉掉率相同，碎齒熊稍低；南邊巨人峽谷旁的{npc:7446}掉得最勤（十次有六次）。",
	-- {item:12622} Shardtooth Meat
	["{item:12622}: the bears"] = "{item:12622}：熊",
	-- {item:12623} Chillwind Meat
	["{item:12623}: the chimaeras"] = "{item:12623}：奇美拉",

	-- Step 3: Back to Rivern Frostwind
	-- {npc:10618} Rivern Frostwind
	["Back to {npc:10618}"] = "返回{npc:10618}",

	-- Step 4: Neutral to Friendly: Frostsaber Provisions, then Winterfall Intrusion
	-- {quest:4970} Frostsaber Provisions · {quest:5201} Winterfall Intrusion
	["Neutral to Friendly: {quest:4970}, then {quest:5201}"] = "中立到友善：先做{quest:4970}，再做{quest:5201}",
	-- {quest:4970} Frostsaber Provisions · {quest:5201} Winterfall Intrusion · {area:2244} Winterfall Village · {area:2255} Everlook
	-- plural, as words: Winterfall Shamans = {npc:7439} Winterfall Shaman · Winterfall Ursas = {npc:7438} Winterfall Ursa
	["Repeat {quest:4970}: 30 turn-ins reach Neutral 1,500, and then {quest:5201} opens: 5 Winterfall Shamans and 5 Winterfall Ursas in {area:2244}, just east of {area:2255}. The village has only a few Shamans, but every furbolg there shares their spawn points: kill all of them, not just the ones you need, and more Shamans and Ursas appear; more Ursas walk the ridge just south-west of the village. Take both quests on every trip: kill the furbolgs, pick up meat on the way back. Neutral to Friendly is 60 turn-ins."] = "重複{quest:4970}：30次上交達到中立1,500，然後{quest:5201}開放：5個冬泉薩滿和5個冬泉巨熊，在{area:2255}正東的{area:2244}。村子裡只有幾個薩滿，但那裡每個熊怪共享重新整理點：把全部殺掉，而不只是你要的那些，就會有更多薩滿和巨熊出現；村子西南的山脊上還有更多巨熊在走動。每次來都接這兩個任務：殺熊怪，返程時撿肉。中立到友善是60次上交。",

	-- Step 5: Friendly to Honored
	["Friendly to Honored"] = "友善到尊敬",
	-- {quest:5201} Winterfall Intrusion · {quest:4970} Frostsaber Provisions · {area:1769} Timbermaw Hold · {item:21383} Winterfall Spirit Beads · {faction:589} Wintersaber Trainers
	["Friendly to Honored is 6,000: 120 turn-ins. {quest:5201} is the quickest; do {quest:4970} when the village is crowded or you pass the bears and chimaeras anyway. Every Winterfall furbolg you kill counts for {area:1769} too: 50 Timbermaw reputation per {quest:5201} up to the end of Honored with them, and about four {item:21383}. Take Salfa's Winterfall Activity (the Timbermaw guide) the first time you are in the village, and keep the beads until your Timbermaw kills stop counting: then each 5 pay 50. You will reach Exalted with the Timbermaw long before the {faction:589}."] = "友善到尊敬是6,000點：120次上交。{quest:5201}最快；村子人多或本來就要經過熊和奇美拉時做{quest:4970}。你殺的每個冬泉熊怪也計入{area:1769}：每完成一次{quest:5201}給50點木喉聲望，直到與他們尊敬滿，還能拿到約四個{item:21383}。第一次到村子時就接索爾法的“冬泉活動”（木喉攻略裡有），把念珠留著，直到你的木喉擊殺不再計數：之後每5個給50點。你會遠早於{faction:589}達到木喉崇拜。",

	-- Step 6: Honored to Exalted: Rampaging Giants too
	-- {quest:5981} Rampaging Giants
	["Honored to Exalted: {quest:5981} too"] = "尊敬到崇拜：也要做{quest:5981}",
	-- {quest:5981} Rampaging Giants · {area:2249} Frostwhisper Gorge · {zone:1452} Winterspring · {area:2244} Winterfall Village · {npc:7446} Rabid Shardtooth · {item:12622} Shardtooth Meat
	-- plural, as words: Frostmaul Giants = {npc:7428} Frostmaul Giant · Frostmaul Preservers = {npc:7429} Frostmaul Preserver
	["At Honored Rivern Frostwind adds {quest:5981}: 4 Frostmaul Giants and 4 Frostmaul Preservers, elite giants in {area:2249} in the south-east of {zone:1452}; the path down into the gorge starts at its north-west end. Take it on a trip south with a friend or two, or when {area:2244} is crowded; the {npc:7446} by the gorge drop {item:12622} most often. Honored to Exalted is 33,000: 660 turn-ins."] = "尊敬後，裡文·霜風會追加{quest:5981}：4個霜槌巨人和4個霜槌守護者，都是{zone:1452}東南部{area:2249}裡的精英巨人；下到峽谷的小路從它西北端開始。和一兩個朋友南下時接，或者{area:2244}人多時接；峽谷旁的{npc:7446}最常掉{item:12622}。尊敬到崇拜是33,000點：660次上交。",
	-- {npc:7428} Frostmaul Giant
	["{npc:7428}, elite"] = "{npc:7428}，精英",
	-- {npc:7429} Frostmaul Preserver
	["{npc:7429}, elite"] = "{npc:7429}，精英",
}
