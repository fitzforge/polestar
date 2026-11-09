-- Chinese (simplified) (zhCN): the guide forever/class/shaman/call-of-earth-alliance (forever/class/shaman/call-of-earth-alliance.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94373} Call of Earth
	["{quest:94373} (Alliance)"] = "{quest:94373}（联盟）",
	-- {item:5175} Earth Totem · {spell:8071} Stoneskin Totem
	["Your {item:5175}: without it no earth totem can be cast. {spell:8071} comes with it at level 4."] = "你的{item:5175}：没有它就无法施放任何大地图腾。4级时随之获得{spell:8071}。",

	-- Step 1: Archaic Rune
	-- {quest:94373} Call of Earth · {quest:98581} Archaic Rune · {npc:658} Sten Stoutarm · {area:132} Coldridge Valley · {quest:179} Dwarven Outfitters · {npc:257446} Teo Hammerstorm · {area:77} Anvilmar
	["Teo's {quest:94373} needs the {quest:98581} handed in first: {npc:658}, where you entered {area:132}, gives it to Dwarf shamans after his {quest:179}. Bring it up the road to {npc:257446} inside {area:77}."] = "",

	-- Step 2: Teo Hammerstorm
	-- {npc:257446} Teo Hammerstorm · {area:77} Anvilmar · {area:132} Coldridge Valley · {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge · {npc:258113} Ingrid Dunwald · {area:131} Kharanos · {quest:94373} Call of Earth
	["{npc:257446} trains shamans inside {area:77}, the hall at the south end of {area:132}. The quest opens at level 4. Never took it and now 10 or more? {npc:258098} in {zone:1455} or {npc:258113} in {area:131} gives you {quest:94373}, a pointer back to Teo: take it for the experience on the way."] = "{npc:257446}在{area:77}内训练萨满祭司，那是{area:132}南端的大厅。任务4级即可接受。如果一直没做，现在已到10级或更高，{zone:1455}的{npc:258098}或{area:131}的{npc:258113}会给你{quest:94373}，指引你回去找提欧·暴风之锤：顺路接上，赚些经验。",

	-- Step 3: Iceclaw Bear Pendants
	-- plural, as words: Iceclaw Bear Pendants = {item:264356} Iceclaw Bear Pendant
	["Iceclaw Bear Pendants"] = "冰爪熊坠饰",
	-- {area:77} Anvilmar
	-- plural, as words: Frostmane Troll Whelps = {npc:706} Frostmane Troll Whelp · Frostmane Novices = {npc:946} Frostmane Novice · Frostbolts = {spell:116} Frostbolt
	["The Frostmane Troll Whelps (level 3-4) hold the snowy slopes west and south-west of {area:77}, and the Frostmane Novices (level 3-4, they throw Frostbolts from range) camp south of it. Both carry the pendants; they respawn in about three minutes."] = "霜鬃巨魔幼崽（3-4 级）占据 {area:77} 西边和西南的雪坡，霜鬃巨魔新兵（3-4 级，会在远处发射寒冰箭）则驻扎在南边。两者都携带坠饰，大约三分钟刷新。",

	-- Step 4: Teo Hammerstorm
	-- {area:77} Anvilmar · {item:6635} Earth Sapta
	["Back to Teo inside {area:77}. He hands you the {item:6635}: do not drink it yet."] = "回到 {area:77} 内找提欧·暴风之锤。他会给你 {item:6635}：先不要喝。",

	-- Step 5: Lost the Earth Sapta?
	-- {quest:94472} Earth Sapta
	["Lost the {quest:94472}?"] = "弄丢了{quest:94472}？",
	-- {quest:94472} Earth Sapta
	["Only if the {quest:94472} is gone from your bags (drunk away from the stone, or sold): Teo gives you another."] = "只有当背包里的 {quest:94472} 已经不见了（在石头以外的地方喝掉，或卖掉）才需要：提欧·暴风之锤会再给你一份。",
	-- {npc:257446} Teo Hammerstorm · {quest:94472} Earth Sapta
	["{npc:257446}: a new {quest:94472}"] = "{npc:257446}：新的{quest:94472}",

	-- Step 6: The Spirit Stone
	["The Spirit Stone"] = "灵魂石",
	-- {area:77} Anvilmar · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth
	["The Spirit Stone stands on a snowy ridge north-west of {area:77}. The trail is easy to miss: it climbs the hill from the valley floor; at the small camp near the top turn left and the stone comes into view. Stand beside it, drink the {item:6635} and speak to the {npc:5891} before it fades."] = "用于与大地元素沟通的石头位于{area:77}西北面的积雪山脊上。小径很容易错过：从谷底沿山坡爬上去，在接近山顶的小营地左转就能看到石头。站在旁边喝下{item:6635}，在效果消失前与{npc:5891}交谈。",
	-- {item:6635} Earth Sapta
	["{item:6635}, beside the Spirit Stone"] = "{item:6635}，在灵魂石旁",
	-- {item:6656} Rough Quartz
	["it hands you the {item:6656}: keep it"] = "它会给你 {item:6656}：留着它",

	-- Step 7: Teo Hammerstorm
	-- {item:6656} Rough Quartz · {area:77} Anvilmar · {item:5175} Earth Totem
	["Bring the {item:6656} back to Teo inside {area:77}. Keep the {item:5175} in your bags for good: every earth totem needs it."] = "把{item:6656}带回{area:77}里的提欧·暴风之锤处。永久将{item:5175}留在背包里：所有大地图腾都需要它。",
	-- {npc:257446} Teo Hammerstorm · {spell:8071} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:257446}: {spell:8071} and your {item:5175}"] = "{npc:257446}：{spell:8071}和你的{item:5175}",
	["the level 4 shaman spells"] = "4级萨满祭司法术",
}
