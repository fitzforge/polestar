-- Chinese (simplified) (zhCN): the guide forever/alliance/50-60/03-winterspring (forever/alliance/50-60/03-winterspring.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Everlook
	-- {npc:11118} Innkeeper Vizzie
	["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118}：上一份指南在这里绑定炉石，所以这一步通常会立即完成",
	-- {npc:11629} Jessica Redpath · {area:2262} Darrowshire
	["{npc:11629}: keep it for {area:2262}"] = "{npc:11629}：保留它，用于{area:2262}",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}: keep both for the Plaguelands"] = "{npc:10431}：两样都保留，用于瘟疫之地",

	-- Step 2: Starfall Village
	["Ride west along the road to the night elf village."] = "沿道路向西骑到暗夜精灵的村子（坠星村）。",

	-- Step 3: The Ruins of Kel'Theril
	-- {area:2253} Starfall Village
	-- plural, as words: Moontouched Feathers = {item:12383} Moontouched Feather
	["The ruins lie around the frozen lake south of {area:2253}. Pick up the four relic fragments lying in the ruins and the Moontouched Feathers on the ground where the wildkin roam."] = "废墟位于{area:2253}以南的冰湖周围。拾取废墟中的四块遗物碎片，以及枭兽游荡处地上的月光羽毛。",

	-- Step 4: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Follow the road west to {npc:9298}'s camp beside the hot springs."] = "沿道路向西前往温泉旁{npc:9298}的营地。",
	-- {zone:1444} Feralas
	["Keep it: Gregan in {zone:1444} brews the elixir later"] = "保留它：之后{zone:1444}的格雷甘·山酒会调制药剂",

	-- Step 5: Salfa
	-- {npc:11556} Salfa · {area:1769} Timbermaw Hold · {npc:9298} Donova Snowden
	["{npc:11556} guards the mouth of {area:1769}, north-west of {npc:9298}."] = "{npc:11556}守在{npc:9298}西北的{area:1769}入口处。",

	-- Step 6: The Winterfall camp
	["The Winterfall camp"] = "冬泉熊怪营地",
	-- {npc:11556} Salfa · {npc:9298} Donova Snowden · {item:12771} Empty Firewater Flask · {quest:8471} Winterfall Ritual Totem · {quest:6031} Runecloth
	["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Any furbolg here can drop an {item:12771} (about one in ten) and, rarely, a {quest:8471}: right-click whichever drops. Keep the {quest:6031} the furbolgs drop for Meilosh."] = "西边的冬泉熊怪营地位于{npc:11556}和{npc:9298}之间的山丘。这里任何熊怪都可能掉落{item:12771}（约十分之一），少数会掉落{quest:8471}：掉落哪个就右键点击哪个。保留熊怪掉落的{quest:6031}，交给梅罗什。",
	-- {item:12771} Empty Firewater Flask
	["{item:12771}, a rare drop"] = "{item:12771}，稀有掉落",
	-- {quest:8471} Winterfall Ritual Totem
	["{quest:8471}, a rare drop"] = "{quest:8471}，稀有掉落",
	-- {area:1769} Timbermaw Hold
	["For Kernda in {area:1769}: keep it"] = "交给{area:1769}的克尔达：保留它",
	-- {quest:6031} Runecloth
	["{quest:6031}, for Meilosh later"] = "{quest:6031}，之后交给梅罗什",

	-- Step 7: Donova Snowden
	-- {zone:1448} Felwood
	["The Deadwood cauldron in {zone:1448}: keep it"] = "{zone:1448}的死木熊怪大锅：保留它",

	-- Step 8: Winterfall Village
	-- {area:2255} Everlook · {npc:10738} High Chief Winterfall
	["The Winterfall furbolg village lies east of {area:2255}: Shaman (56-57), Den Watchers (55-56) and Ursa (57-58), all above you. Kill the Shaman first, they heal, and pull from the edge. {npc:10738} in the cave at the back is elite: stay out."] = "冬泉熊怪的村子位于{area:2255}以东：冬泉萨满祭司（56-57）、冬泉巢穴守卫（55-56）和冬泉巨熊怪（57-58），都比你等级高。先杀萨满祭司，它们会治疗，从边缘开始引怪。后方洞穴里的{npc:10738}是精英：别进去。",

	-- Step 9: The Ice Thistle Hills
	-- {area:2247} Ice Thistle Hills
	["The {area:2247}"] = "{area:2247}",
	-- {area:2244} Winterfall Village · {area:2255} Everlook
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["Ice Thistle yetis live in the hills south of {area:2244}, Chillwind Chimaeras in the valley toward {area:2255}."] = "冰蓟雪人住在{area:2244}以南的山丘，冰风奇美拉在通往{area:2255}的山谷中。",

	-- Step 11: Optional: Sunken Temple
	-- {area:1417} Sunken Temple
	["Optional: {area:1417}"] = "可选：{area:1417}",
	-- {area:1417} Sunken Temple · {area:2255} Everlook
	["Short of level 54 after the yetis? Running the {area:1417} (50-54) instead of grinding gets you there faster in a group. Come back to {area:2255} afterwards."] = "打完雪人还不到54级？组队刷{area:1417}（50-54）比练级更快。之后回到{area:2255}。",

	-- Step 12: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "完美的雪人角",
	-- plural, as words: Ice Thistle Matriarchs = {npc:7459} Ice Thistle Matriarch
	["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns. Keep killing yetis until level 54: Harlo's wildkin quests are red before that."] = "回到山丘：只有冰蓟雪人女王和冰蓟雪人族长携带角。一直杀雪人到54级：在此之前哈尔罗·巴纳比的枭兽任务是红色的。",
	-- {npc:7460} Ice Thistle Patriarch · {area:2247} Ice Thistle Hills · {zone:1452} Winterspring
	["grind on {npc:7460} at the {area:2247}, {zone:1452}"] = "在{zone:1452}的{area:2247}刷{npc:7460}",

	-- Step 13: Everlook
	-- {npc:10978} Legacki
	["On {npc:10978}, by the inn"] = "在旅店旁的{npc:10978}处",
	-- {npc:10978} Legacki · {npc:7583} Sprinkle · {npc:10977} Quixxil
	["{npc:10978}: {npc:7583} and {npc:10977} come later"] = "{npc:10978}：{npc:7583}和{npc:10977}之后再去",

	-- Step 14: Starfall Village
	-- {npc:10301} Jaron Stoneshaper
	["Ride west along the road to {npc:10301}."] = "沿道路向西骑到{npc:10301}处。",

	-- Step 15: Jaron Stoneshaper's camp
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s camp"] = "{npc:10301}的营地",
	-- {npc:10301} Jaron Stoneshaper · {area:2245} Mazthoril
	["Ride south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "向东南沿山谷而下，到{area:2245}雪地里{npc:10301}的破损箱子处，他被毁的马车就在东边。",

	-- Step 16: Jaron Stoneshaper's supplies
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s supplies"] = "{npc:10301}的补给",
	-- {npc:10301} Jaron Stoneshaper
	["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "拾取马车周围的补给，并从附近的枭兽身上夺回{npc:10301}的护符。",

	-- Step 17: Darkwhisper Gorge
	-- {npc:9298} Donova Snowden · {area:2256} Darkwhisper Gorge
	["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "按{npc:9298}的指引前往{area:2256}入口，途经霜槌巨人：一次只引一个过去。",

	-- Step 18: Starfall Village
	["Ride north-west back to the village."] = "向西北骑回村子。",

	-- Step 21: Winterfall Spirit Beads
	["The western Winterfall furbolgs drop the beads."] = "西边的冬泉熊怪掉落珠子。",

	-- Step 23: Chillwind Camp
	-- {area:1769} Timbermaw Hold · {zone:1448} Felwood · {area:442} Auberdine · {area:150} Menethil Harbor · {area:271} Southshore · {area:3197} Chillwind Camp
	["Walk through {area:1769} to {zone:1448} and fly on to the Eastern Kingdoms ({area:442}, the boat to {area:150}). Fly to {area:271} and ride north up the road through Alterac to {area:3197}."] = "穿过{area:1769}前往{zone:1448}，再飞往东部王国（{area:442}，乘船前往{area:150}）。飞往{area:271}，沿道路向北穿过奥特兰克前往{area:3197}。",

	-- Step 24: Pamela Redpath
	-- {zone:1423} Eastern Plaguelands · {area:2262} Darrowshire · {npc:10926} Pamela Redpath
	["Follow the southern road east into the {zone:1423}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "沿南边的道路向东进入{zone:1423}；{area:2262}的废墟在道路以南。{npc:10926}的鬼魂在南端的废屋旁玩耍。",

	-- Step 25: Pamela Redpath's doll
	-- {npc:10926} Pamela Redpath
	["{npc:10926}'s doll"] = "{npc:10926}的娃娃",
	-- {area:2262} Darrowshire
	["The three pieces of the doll lie in the ruined houses of {area:2262}; picking one up can call out ghosts. Combine them into the doll."] = "娃娃的三个部件在{area:2262}的废屋里；拾取时可能引出鬼魂。把它们合成娃娃。",

	-- Step 26: Pamela Redpath
	-- {quest:5152} Auntie Marlene · {zone:1422} Western Plaguelands
	["{quest:5152}, in the {zone:1422}: keep it"] = "{quest:5152}，在{zone:1422}：保留它",

	-- Step 27: Light's Hope Chapel
	["Follow the road east across the zone to the chapel."] = "沿道路向东穿过该地区前往圣光之愿礼拜堂。",
	-- {npc:11038} Caretaker Alen · {npc:12250} Zaeldarr the Outcast
	["{npc:11038}: {npc:12250} is a level 54 elite"] = "{npc:11038}：{npc:12250}是54级精英",

	-- Step 28: Corin's Crossing
	-- {area:2264} Corin's Crossing
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["The Scourge around {area:2264}, west of the chapel, drop both kinds of Scourgestone; Darrowshire Spirits rise from them: talk to each one to free it."] = "{area:2264}周围、礼拜堂西边的天灾军团会掉落两种天灾石；{npc:11064}会从它们身上升起：和每一个交谈以解放它。",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "解放{npc:11064}：与它们交谈",

	-- Step 30: The Undercroft
	-- {npc:12250} Zaeldarr the Outcast · {area:2261} The Undercroft
	["{npc:12250} is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "{npc:12250}是精英：建议组队。他在该地区西南的墓穴{area:2261}底层等候。",

	-- Step 31: Augustus the Touched
	-- {area:2627} Terrordale · {npc:12384} Augustus the Touched
	["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "向北骑到{area:2627}。{npc:12384}住在破屋里，他的收据簿在附近的废弃旅店里。",

	-- Step 32: Light's Hope Chapel
	-- {area:3197} Chillwind Camp
	["The next guide starts here and flies to {area:3197}."] = "下一份指南从这里开始，飞往{area:3197}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Zaeldarr is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "流亡者塞达尔是精英：建议组队。他在该地区西南的墓穴{area:2261}底层等候。",
}
