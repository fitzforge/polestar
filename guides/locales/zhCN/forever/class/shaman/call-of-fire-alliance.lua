-- Chinese (simplified) (zhCN): the guide forever/class/shaman/call-of-fire-alliance (forever/class/shaman/call-of-fire-alliance.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94449} Call of Fire
	["{quest:94449} (Alliance)"] = "{quest:94449}（联盟）",
	-- {item:5176} Fire Totem · {spell:3599} Searing Totem · {item:263412} Totem of Charged Flames
	["Your {item:5176} for every fire totem, {spell:3599} with it, and Forever's {item:263412}."] = "获得用于所有火焰图腾的{item:5176}、借此学会的{spell:3599}，以及无限的{item:263412}。",

	-- Step 1: Call of Fire
	-- {npc:258113} Ingrid Dunwald · {area:131} Kharanos · {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge · {npc:257597} Bruegs Kindleborn
	["At 10 {npc:258113}, the shaman trainer in {area:131}, or {npc:258098}, the shaman trainer in {zone:1455}, sends you to {npc:257597}."] = "10级时，{area:131}的萨满祭司训练师{npc:258113}，或{zone:1455}的萨满祭司训练师{npc:258098}，会派你去找{npc:257597}。",
	-- {npc:258113} Ingrid Dunwald · {area:131} Kharanos · {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge
	["{npc:258113}, {area:131}; or {npc:258098}, {zone:1455}"] = "{area:131} 的 {npc:258113}；或 {zone:1455} 的 {npc:258098}",

	-- Step 2: Bruegs Kindleborn
	-- {area:806} South Gate Outpost · {npc:1959} Mountaineer Barleybrew · {npc:257597} Bruegs Kindleborn · {item:6653} Torch of the Dormant Flame
	["Follow the road east to the tunnel towards {area:806}. Out of the first tunnel, keep left past {npc:1959} and the tower: a slim trail, hard to see but shown on the minimap, winds up the mountain to {npc:257597}' cave above the farm. He hands you the {item:6653}: keep it until the end of the chain."] = "沿路向东前往通向 {area:806} 的隧道。离开第一条隧道后靠左，经过 {npc:1959} 和塔楼：一条不易察觉、但会显示在微缩地图上的狭窄小径蜿蜒上山，通往农场上方 {npc:257597} 的洞穴。他会给你 {item:6653}：保留到任务线结束。",

	-- Step 3: Braldir Ashmantle
	-- {npc:257597} Bruegs Kindleborn · {zone:1432} Loch Modan · {npc:257808} Braldir Ashmantle · {area:144} Thelsamar
	["From {npc:257597}' ledge you can drop carefully down the mountain into {zone:1432}, or walk back through the tunnel. {npc:257808} keeps the shrine on the peak just south of {area:144}: a hidden trail along a cliff ledge, marked by stone totems, climbs to it from the road north of the peak."] = "从 {npc:257597} 所在的平台，可以小心跳下山进入 {zone:1432}，也可以沿隧道原路返回。{npc:257808} 看守着 {area:144} 南侧山顶的神龛：从山峰北侧的道路出发，沿一条悬崖边缘的隐秘小径攀登，沿途有石制图腾作为标记。",

	-- Step 4: Reagent Pouch
	-- {area:923} Stonesplinter Valley · {area:144} Thelsamar · {spell:1245113} Lightning Bolts
	-- plural, as words: Stonesplinter Seers = {npc:1166} Stonesplinter Seer
	["The Stonesplinter Seers (level 13-14) stand among the troggs of {area:923} in the south of the loch, and in the trogg camps north-east of {area:144}. They throw {spell:1245113} from 40 yards and run for help when hurt: pull one at a time. Respawn about five minutes."] = "碎石怪先知（13—14级）位于湖泊南部 {area:923} 的穴居人群中，以及 {area:144} 东北面的穴居人营地内。它们能从40码外施放 {spell:1245113}，受伤后会逃跑求援：一次只引一只。大约五分钟刷新。",

	-- Step 5: Fire Tar
	-- {area:149} Silver Stream Mine · {area:144} Thelsamar · {spell:2136} Fire Blast · {spell:134} Fire Shield
	-- plural, as words: Tunnel Rat Geomancers = {npc:1174} Tunnel Rat Geomancer
	["The Tunnel Rat Geomancers (level 12-13) work only inside the {area:149} at the north end of the loch, past {area:144}. They cast {spell:2136} behind a {spell:134} and run for help at low health."] = "坑道鼠地卜师（12-13级）只出现在洛克湖最北端、越过{area:144}后的{area:149}内。它们会在{spell:134}保护下施放{spell:2136}，低血量时会逃跑求援。",

	-- Step 6: Braldir Ashmantle
	-- {npc:257808} Braldir Ashmantle · {item:6636} Fire Sapta
	["Back up the trail to {npc:257808}. He makes the {item:6636} from the tar and the pouch: keep it with the torch."] = "沿小路返回上方的{npc:257808}处。他会用焦油和小袋制作{item:6636}：将它和火炬一起留着。",

	-- Step 7: Lost the Fire Sapta?
	-- {quest:94473} Fire Sapta
	["Lost the {quest:94473}?"] = "弄丢了{quest:94473}？",
	-- {quest:94473} Fire Sapta · {npc:257808} Braldir Ashmantle
	["Only if the {quest:94473} is gone from your bags: {npc:257808} gives you another."] = "仅在 {quest:94473} 已经不在背包里时需要：{npc:257808} 会再给你一份。",
	-- {npc:257808} Braldir Ashmantle · {quest:94473} Fire Sapta
	["{npc:257808}: a new {quest:94473}"] = "{npc:257808}：新的{quest:94473}",

	-- Step 8: The Shrine of Eternal Flame
	["The Shrine of Eternal Flame"] = "永恒之火神殿",
	-- {npc:257808} Braldir Ashmantle · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {spell:8017} Rockbiter Weapon · {spell:8042} Earth Shock · {item:6655} Glowing Ember
	["Climb on past {npc:257808} to the peak. Drink the {item:6636} beside the rock statue there to see the {npc:5893} (level 12): it waits until you strike, but grows stronger the longer it is left, and it is immune to fire. Open at once with {spell:8017} and {spell:8042}. Its {item:6655} drops every time."] = "经过 {npc:257808} 后继续爬到山顶。在那里的岩石雕像旁喝下 {item:6636}，即可看见 {npc:5893}（12 级）：它会等你先动手，但放置得越久就越强，而且免疫火焰伤害。立即用 {spell:8017} 和 {spell:8042} 开战。它必定掉落 {item:6655}。",
	-- {item:6636} Fire Sapta
	["{item:6636}, beside the statue"] = "{item:6636}，在雕像旁",

	-- Step 9: The Brazier of the Dormant Flame
	-- {object:61934} Brazier of the Dormant Flame
	["The {object:61934}"] = "{object:61934}",
	-- {object:61934} Brazier of the Dormant Flame · {item:277329} Torch of Eternal Flame
	["Click the {object:61934} atop the shrine with the torch in your bags to place the ember, then click it again for the next quest: the lit {item:277329}."] = "确保火炬在背包中，点击神殿顶上的 {object:61934} 来放置火种，然后再点击一次，接取下一个任务：获得点燃的 {item:277329}。",

	-- Step 10: Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn · {item:5176} Fire Totem
	["Back through the South Gate tunnel and up the trail to {npc:257597}' cave. Keep the {item:5176} in your bags for good: every fire totem needs it."] = "穿过南门隧道返回，沿小径上山到 {npc:257597} 的洞穴。把 {item:5176} 永久留在背包里：所有火焰系图腾都需要它。",
	-- {npc:257597} Bruegs Kindleborn · {spell:3599} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:257597}: {spell:3599}, your {item:5176} and the {item:263412}"] = "{npc:257597}：{spell:3599}、你的 {item:5176} 和 {item:263412}",
}
