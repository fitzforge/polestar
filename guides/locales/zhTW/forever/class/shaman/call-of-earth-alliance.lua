-- Chinese (traditional) (zhTW): the guide forever/class/shaman/call-of-earth-alliance (forever/class/shaman/call-of-earth-alliance.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94373} Call of Earth
	["{quest:94373} (Alliance)"] = "{quest:94373}（聯盟）",
	-- {item:5175} Earth Totem · {spell:8071} Stoneskin Totem
	["Your {item:5175}: without it no earth totem can be cast. {spell:8071} comes with it at level 4."] = "你的{item:5175}：沒有它就無法施放任何大地圖騰。4級時隨之獲得{spell:8071}。",

	-- Step 1: Archaic Rune
	-- {quest:94373} Call of Earth · {quest:98581} Archaic Rune · {npc:658} Sten Stoutarm · {area:132} Coldridge Valley · {quest:179} Dwarven Outfitters · {npc:257446} Teo Hammerstorm · {area:77} Anvilmar
	["Teo's {quest:94373} needs the {quest:98581} handed in first: {npc:658}, where you entered {area:132}, gives it to Dwarf shamans after his {quest:179}. Bring it up the road to {npc:257446} inside {area:77}."] = "提奧的{quest:94373}要求先交掉{quest:98581}：你進入{area:132}的地方那個{npc:658}，在完成他的{quest:179}之後會給矮人薩滿。把它沿路送到{area:77}裡面的{npc:257446}處。",

	-- Step 2: Teo Hammerstorm
	-- {npc:257446} Teo Hammerstorm · {area:77} Anvilmar · {area:132} Coldridge Valley · {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge · {npc:258113} Ingrid Dunwald · {area:131} Kharanos · {quest:94373} Call of Earth
	["{npc:257446} trains shamans inside {area:77}, the hall at the south end of {area:132}. The quest opens at level 4. Never took it and now 10 or more? {npc:258098} in {zone:1455} or {npc:258113} in {area:131} gives you {quest:94373}, a pointer back to Teo: take it for the experience on the way."] = "{npc:257446}在{area:132}南端大廳、{area:77}內訓練薩滿。任務4級開放。從沒接過而現在已10級以上？{zone:1455}的{npc:258098}或{area:131}的{npc:258113}會給你{quest:94373}，指向提奧：順路接下拿經驗。",

	-- Step 3: Iceclaw Bear Pendants
	-- plural, as words: Iceclaw Bear Pendants = {item:264356} Iceclaw Bear Pendant
	["Iceclaw Bear Pendants"] = "冰爪熊吊墜",
	-- {area:77} Anvilmar
	-- plural, as words: Frostmane Troll Whelps = {npc:706} Frostmane Troll Whelp · Frostmane Novices = {npc:946} Frostmane Novice · Frostbolts = {spell:116} Frostbolt
	["The Frostmane Troll Whelps (level 3-4) hold the snowy slopes west and south-west of {area:77}, and the Frostmane Novices (level 3-4, they throw Frostbolts from range) camp south of it. Both carry the pendants; they respawn in about three minutes."] = "霜鬃食人妖幼崽（3-4級）佔據{area:77}西邊和西南的雪坡，霜鬃新兵（3-4級，會遠端投擲寒冰箭）紮營在其南邊。兩者都攜帶吊墜；約三分鐘重新出現。",

	-- Step 4: Teo Hammerstorm
	-- {area:77} Anvilmar · {item:6635} Earth Sapta
	["Back to Teo inside {area:77}. He hands you the {item:6635}: do not drink it yet."] = "回到{area:77}裡的提奧。他會給你{item:6635}：先別喝。",

	-- Step 5: Lost the Earth Sapta?
	-- {quest:94472} Earth Sapta
	["Lost the {quest:94472}?"] = "{quest:94472}丟了？",
	-- {quest:94472} Earth Sapta
	["Only if the {quest:94472} is gone from your bags (drunk away from the stone, or sold): Teo gives you another."] = "只有當{quest:94472}從你揹包裡消失時（在石塊以外的地方喝掉或賣掉）：提奧會再給你一個。",
	-- {npc:257446} Teo Hammerstorm · {quest:94472} Earth Sapta
	["{npc:257446}: a new {quest:94472}"] = "{npc:257446}：新的{quest:94472}",

	-- Step 6: The Spirit Stone
	["The Spirit Stone"] = "靈魂之石",
	-- {area:77} Anvilmar · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth
	["The Spirit Stone stands on a snowy ridge north-west of {area:77}. The trail is easy to miss: it climbs the hill from the valley floor; at the small camp near the top turn left and the stone comes into view. Stand beside it, drink the {item:6635} and speak to the {npc:5891} before it fades."] = "靈魂之石立在{area:77}西北的雪脊上。小路很容易錯過：它從谷底爬上山丘；在接近頂部的小營地左轉就能看見石頭。站在石旁，喝下{item:6635}，趁它消失前與{npc:5891}交談。",
	-- {item:6635} Earth Sapta
	["{item:6635}, beside the Spirit Stone"] = "{item:6635}，在靈石旁邊",
	-- {item:6656} Rough Quartz
	["it hands you the {item:6656}: keep it"] = "它會給你{item:6656}：留著",

	-- Step 7: Teo Hammerstorm
	-- {item:6656} Rough Quartz · {area:77} Anvilmar · {item:5175} Earth Totem
	["Bring the {item:6656} back to Teo inside {area:77}. Keep the {item:5175} in your bags for good: every earth totem needs it."] = "把{item:6656}帶回{area:77}裡的提奧。把{item:5175}永久留在揹包裡：每個大地圖騰都需要它。",
	-- {npc:257446} Teo Hammerstorm · {spell:8071} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:257446}: {spell:8071} and your {item:5175}"] = "{npc:257446}：{spell:8071}與你的{item:5175}",
	["the level 4 shaman spells"] = "4級薩滿法術",
}
