-- Chinese (simplified) (zhCN): the guide forever/class/shaman/call-of-earth-horde (forever/class/shaman/call-of-earth-horde.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:1516} Call of Earth
	["{quest:1516} (Horde)"] = "{quest:1516}（部落）",
	-- {item:5175} Earth Totem · {spell:8071} Stoneskin Totem
	["Your {item:5175}: without it no earth totem can be cast. {spell:8071} comes with it at level 4."] = "你的{item:5175}：没有它就无法施放任何大地图腾。4级时随之获得{spell:8071}。",

	-- Step 1: Canaga Earthcaller
	-- {npc:5887} Canaga Earthcaller · {area:363} Valley of Trials
	["{npc:5887} stands just outside the Den, the cave in the middle of the {area:363}. The quest opens at level 4."] = "{npc:5887}站在大兽穴外，兽穴就是{area:363}中央的洞穴。任务4级开放。",

	-- Step 2: Felstalker Hooves
	["Felstalker Hooves"] = "地狱捕猎者的蹄子",
	-- {area:365} Burning Blade Coven · {npc:3102} Felstalker
	-- plural, as words: Felstalkers = {npc:3102} Felstalker · Vile Familiars = {npc:3101} Vile Familiar
	["Felstalkers (level 3-4) prowl the slope below the {area:365}, the cave in the north of the valley, and just inside its mouth among the Vile Familiars. Nearly every {npc:3102} drops a hoof (four kills in five); they respawn in a little over three minutes."] = "地狱捕猎者（3-4级）在山谷北部洞穴{area:365}下方的斜坡，以及洞口内的邪灵劣魔之间游荡。{npc:3102}几乎每只都会掉落蹄子（约五只出四个）；刷新时间略多于三分钟。",

	-- Step 3: Canaga Earthcaller
	-- {npc:5887} Canaga Earthcaller · {quest:1462} Earth Sapta
	["Back to {npc:5887} outside the Den. She hands you the {quest:1462}: do not drink it yet."] = "返回 大兽穴 外的{npc:5887}身边。她会给你{quest:1462}：先别喝。",

	-- Step 4: Lost the Earth Sapta?
	-- {quest:1463} Earth Sapta
	["Lost the {quest:1463}?"] = "弄丢了{quest:1463}？",
	-- {quest:1463} Earth Sapta · {npc:5887} Canaga Earthcaller
	["Only if the {quest:1463} is gone from your bags (drunk away from the rock, or sold): {npc:5887} gives you another."] = "仅在 {quest:1463} 已经不在背包里时需要（在远离岩石的地方喝掉了，或卖掉了）：{npc:5887} 会再给你一份。",
	-- {npc:5887} Canaga Earthcaller · {quest:1463} Earth Sapta
	["{npc:5887}: a new {quest:1463}"] = "{npc:5887}：新的{quest:1463}",

	-- Step 5: Spirit Rock
	-- {area:639} Spirit Rock · {area:638} Hidden Path · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth
	["{area:639} sits on a ledge in the hills just south of the Den. The {area:638} up starts at the foot of the hills south-west of the Den, between two idle peons; it climbs south-west into the hills, then bends back east to the rock. Stand right beside the stone and drink the {item:6635}: the {npc:5891} appears for a short while, so speak to it at once (walk almost under it if it does not answer). Coming back, you can drop down the ledge towards the Den instead of walking the path."] = "{area:639}位于大兽穴正南方山丘的一处凸台上。上行的{area:638}从兽穴西南方山脚、两名闲置苦工之间开始，先向西南爬上山丘，再转向东到达岩石。紧靠石头站好，喝下{item:6635}：{npc:5891}只会短暂出现，立刻与它交谈（如果没有回应，就走到几乎位于它正下方的位置）。返回时可朝兽穴方向跳下凸台，无需沿原路步行。",
	-- {item:6635} Earth Sapta · {area:639} Spirit Rock
	["{item:6635}, beside {area:639}"] = "{item:6635}，在 {area:639} 旁边",
	-- {item:6656} Rough Quartz
	["it hands you the {item:6656}: keep it"] = "它会给你 {item:6656}：留着它",

	-- Step 6: Canaga Earthcaller
	-- {item:6656} Rough Quartz · {npc:5887} Canaga Earthcaller · {item:5175} Earth Totem
	["Bring the {item:6656} back to {npc:5887} outside the Den. Keep the {item:5175} she gives you in your bags for good: every earth totem needs it."] = "将{item:6656}带回给 大兽穴 外的{npc:5887}。她给你的{item:5175}要永久保留在背包中：所有大地图腾都需要它。",
	-- {npc:5887} Canaga Earthcaller · {spell:8071} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5887}: {spell:8071} and your {item:5175}"] = "{npc:5887}：{spell:8071}和你的{item:5175}",
	["the level 4 shaman spells"] = "4级萨满祭司法术",

	-- Step 7: Seer Ravenfeather
	-- {npc:5888} Seer Ravenfeather · {area:221} Camp Narache
	["{npc:5888} stands in {area:221}. She may show no quest mark over her head: speak to her anyway. The quest opens at level 4."] = "{npc:5888} 站在 {area:221}。她头顶可能没有任务标记：仍然与她交谈。该任务4级开放。",

	-- Step 8: Ritual Salve
	-- {area:358} Brambleblade Ravine · {spell:403} Lightning Bolt
	-- plural, as words: Bristleback Shamans = {npc:2953} Bristleback Shaman
	["The Bristleback Shamans (level 3-4) stand among the quilboar huts of {area:358}, east of the camp, and throw the odd {spell:403}. Four kills in five drop a salve; they respawn in about four minutes."] = "刺背萨满祭司（3—4级）在营地东边 {area:358} 的野猪人小屋之间，偶尔会施放 {spell:403}。药膏掉率为五次击杀约四次；它们大约四分钟刷新。",

	-- Step 9: Seer Ravenfeather
	-- {area:221} Camp Narache · {quest:1462} Earth Sapta
	["Back to the Seer in {area:221}. She hands you the {quest:1462}: do not drink it yet."] = "返回 {area:221} 的先知处。她会给你 {quest:1462}：先不要喝。",

	-- Step 10: Lost the Earth Sapta?
	-- {quest:1462} Earth Sapta
	["Lost the {quest:1462}?"] = "弄丢了{quest:1462}？",
	-- {quest:1462} Earth Sapta
	["Only if the {quest:1462} is gone from your bags: the Seer gives you another."] = "仅当背包中的 {quest:1462} 已经不在时：先知会再给你一份。",
	-- {npc:5888} Seer Ravenfeather · {quest:1462} Earth Sapta
	["{npc:5888}: a new {quest:1462}"] = "{npc:5888}：新的{quest:1462}",

	-- Step 11: Kodo Rock
	-- {area:637} Kodo Rock · {npc:2991} Greatmother Hawkwind · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth
	["{area:637} is a small pillar on a low mound due east of {npc:2991}'s well, east of the camp; it only shows from about fifteen yards away, and hostile boars graze around it. Stand beside it and drink the {item:6635}, then speak to the {npc:5891} before it fades (drink again if it does)."] = "{area:637}是营地东面、{npc:2991}水井正东边矮土丘上的一根小石柱；大约15码内才能看到，周围有敌对野猪觅食。站在旁边喝下{item:6635}，再在效果消失前与{npc:5891}交谈（如果消失了就再喝一次）。",
	-- {item:6635} Earth Sapta · {area:637} Kodo Rock
	["{item:6635}, beside {area:637}"] = "{item:6635}，在 {area:637} 旁边",

	-- Step 12: Seer Ravenfeather
	-- {item:6656} Rough Quartz · {item:5175} Earth Totem
	["Bring the {item:6656} back to the Seer. Keep the {item:5175} in your bags for good: every earth totem needs it."] = "把 {item:6656} 带回给先知。将 {item:5175} 永久保留在背包中：所有大地图腾都需要它。",
	-- {npc:5888} Seer Ravenfeather · {spell:8071} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5888}: {spell:8071} and your {item:5175}"] = "{npc:5888}：{spell:8071}和你的{item:5175}",

	-- Step 13: Windshaper Boro
	-- {npc:251374} Windshaper Boro · {area:16635} Thendal Village
	["{npc:251374}, the shaman trainer, stands in {area:16635}. The quest opens at level 3."] = "萨满祭司训练师{npc:251374}站在{area:16635}。任务3级开放。",

	-- Step 14: Signet of Akir
	-- {item:251924} Signet of Akir · {npc:252095} Hanaa Nightwind
	["Any Al'Aketh cultist can carry the {item:251924}: the Converts (level 2-3) around the standing stones just east of the village, or the Brutes and Neophytes (level 4) in the camp beyond {npc:252095}, south-west of the village. Keep killing until one drops it."] = "任何奥拉凯斯教徒都可能携带{item:251924}：村庄正东边立石周围的奥拉凯斯信徒（2-3级），或村庄西南方、{npc:252095}后面营地中的蛮兵和奥拉凯斯新教徒（4级）。持续击杀，直到掉落为止。",

	-- Step 15: Windshaper Boro
	-- {area:16635} Thendal Village · {quest:1462} Earth Sapta
	["Back to Boro in {area:16635}. He hands you the {quest:1462}: do not drink it yet."] = "返回 {area:16635} 的波罗处。他会给你 {quest:1462}：先不要喝。",

	-- Step 16: The Rise of Spirits
	-- {area:16988} Rise of Spirits
	["The {area:16988}"] = "{area:16988}",
	-- {area:16988} Rise of Spirits · {item:6635} Earth Sapta · {npc:251166} Minor Manifestation of Earth
	["The {area:16988} is the hilltop shrine north-east of Boro: the path up starts on the hill just above the clearing where the flies were. Drink the {item:6635} beside the shrine and speak to the {npc:251166} before it fades."] = "{area:16988} 是波罗东北方山顶的神殿：上山小路的起点就在之前有苍蝇的空地上方的山坡上。在神殿旁喝下 {item:6635}，并在效果消失前与 {npc:251166} 交谈。",
	-- {item:6635} Earth Sapta
	["{item:6635}, beside the shrine"] = "在神龛旁使用{item:6635}",

	-- Step 17: Windshaper Boro
	-- {item:6656} Rough Quartz · {item:5175} Earth Totem
	["Bring the {item:6656} back to Boro. Keep the {item:5175} in your bags for good: every earth totem needs it."] = "把 {item:6656} 带回给波罗。把 {item:5175} 永久留在背包里：所有大地系图腾都需要它。",
	-- {npc:251374} Windshaper Boro · {spell:8071} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:251374}: {spell:8071} and your {item:5175}"] = "{npc:251374}：{spell:8071}和你的{item:5175}",
}
