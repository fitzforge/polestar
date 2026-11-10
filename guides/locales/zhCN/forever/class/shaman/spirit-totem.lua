-- Chinese (simplified) (zhCN): the guide forever/class/shaman/spirit-totem (forever/class/shaman/spirit-totem.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:8412} Spirit Totem · {quest:8413} Da Voodoo
	["{quest:8412} and {quest:8413}"] = "{quest:8412}与{quest:8413}",
	-- {area:1417} Sunken Temple
	["Experience and gold at 50, ending in the {area:1417}; the Classic item choice may be gone in Forever."] = "50级时获取经验和金币，最终前往{area:1417}；无限 可能取消了经典版的物品选择。",
	["Experience and gold"] = "经验和金币",

	-- Step 1: Sagorne Creststrider
	-- {npc:13417} Sagorne Creststrider · {object:172957} Valley of Wisdom · {npc:6176} Bath'rah the Windwatcher
	["At 50 {npc:13417}, the shaman trainer in the {object:172957}, asks for the four elements for {npc:6176}."] = "50级时，{object:172957} 内的萨满祭司训练师 {npc:13417} 会让你收集四种元素，交给 {npc:6176}。",

	-- Step 2: Beram Skychaser
	-- {npc:3032} Beram Skychaser · {area:1640} Spirit Rise · {zone:1456} Thunder Bluff · {npc:6176} Bath'rah the Windwatcher · {quest:8410} Elemental Mastery · {quest:8412} Spirit Totem · {quest:8411} Mastering the Elements
	["At 50 {npc:3032}, a shaman trainer on {area:1640} in {zone:1456}, asks for the four elements for {npc:6176}. Skyborne: Forever's quest page lists {quest:8410} and {quest:8412} for Orcs, Tauren and Trolls only; if {npc:3032} has nothing for you, {npc:6176}'s own {quest:8411} is open to every Horde race, but {quest:8412} after it may still turn you away."] = "50级时，{zone:1456}的{area:1640}上的萨满祭司训练师{npc:3032}会让你为{npc:6176}收集四种元素。天裔注意：无限服任务页面列出的{quest:8410}和{quest:8412}仅限兽人、牛头人和巨魔；如果{npc:3032}没有任务给你，{npc:6176}自己的{quest:8411}向所有部落种族开放，但后续{quest:8412}仍可能不让你接受。",

	-- Step 3: The four elements
	["The four elements"] = "四种元素",
	-- {item:7069} Elemental Air · {zone:1417} Arathi Highlands · {area:320} Refuge Pointe · {npc:2794} Summoned Guardian · {zone:1447} Azshara · {npc:14269} Seeker Aqualon · {area:69} Lakeshire
	-- plural, as words: Thundering Exiles = {npc:2762} Thundering Exile · Rumbling Exiles = {npc:2592} Rumbling Exile · Burning Exiles = {npc:2760} Burning Exile
	["One each of {item:7069}, Fire, Earth and Water; all four trade, so the auction house is quickest. To farm them, {zone:1417} has the exiles near {area:320} (level 38-39, about one kill in eight to ten, respawn under seven minutes): Thundering Exiles south-east of it (air), Rumbling Exiles south-west (earth), Burning Exiles far to the north-west (fire), and the {npc:2794} far to the south-west (water, about one in seven). Water comes easier from the Patches of Elemental Water in {zone:1447} (two in five) or {npc:14269} by {area:69} in Redridge."] = "{item:7069}、元素火焰、元素之土和元素之水各一个；四种都可交易，所以拍卖行最快。自行刷取的话，{zone:1417}的{area:320}附近有流放者（38-39级，约八到十只出一个，刷新不到七分钟）：东南方的雷霆流放者掉空气，西南方的顽石流放者掉土，远处西北方的烈焰流放者掉火，远处西南方的{npc:2794}掉水（约七只出一个）。水更容易从{zone:1447}的元素之水水域（五次出两个），或赤脊山{area:69}旁的{npc:14269}处获得。",
	-- {item:7069} Elemental Air
	-- plural, as words: Thundering Exiles = {npc:2762} Thundering Exile
	["{item:7069}: Thundering Exiles"] = "{item:7069}：{npc:2762}",
	-- {item:7068} Elemental Fire
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile
	["{item:7068}: Burning Exiles"] = "{item:7068}：{npc:2760}",
	-- {item:7067} Elemental Earth
	-- plural, as words: Rumbling Exiles = {npc:2592} Rumbling Exile
	["{item:7067}: Rumbling Exiles"] = "{item:7067}：{npc:2592}",
	-- {item:7070} Elemental Water · {npc:2794} Summoned Guardian · {zone:1447} Azshara
	["{item:7070}: the {npc:2794}, or {zone:1447}'s water patches"] = "{item:7070}：由 {npc:2794} 掉落，或前往 {zone:1447} 的水域寻找",

	-- Step 4: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher · {zone:1416} Alterac Mountains · {area:272} Tarren Mill
	["{npc:6176} camps in the ruins of the east of {zone:1416}: from {area:272} follow the river east of town north into the hills."] = "{npc:6176} 在 {zone:1416} 东部的废墟中扎营：从 {area:272} 沿镇东的河流向北进入山地。",

	-- Step 5: Spider eye and bear claw
	["Spider eye and bear claw"] = "蜘蛛眼和熊爪",
	-- {area:813} Bulwark · {zone:1422} Western Plaguelands · {area:3197} Chillwind Camp · {item:20610} Bloodshot Spider Eye · {spell:3427} Infected Wound · {item:20611} Thick Black Claw · {area:159} Brill
	-- plural, as words: Venom Mist Lurkers = {npc:1822} Venom Mist Lurker · Diseased Black Bears = {npc:1815} Diseased Black Bear · Carrion Vultures = {npc:1809} Carrion Vulture · Plague Lurkers = {npc:1824} Plague Lurker
	["Eight of each. Fly or ride to the {area:813} and on to the west edge of the {zone:1422}, north-west of {area:3197}: the Venom Mist Lurkers (level 50-51, they poison) give the {item:20610} and the Diseased Black Bears (level 51-52, {spell:3427}) the {item:20611}, one kill in five each; the two Carrion Vultures there drop either. The bigger Diseased Grizzlies and Plague Lurkers further east almost never drop them. A few bears and lurkers also roam south-east of {area:159} in Tirisfal."] = "每种各八个。飞行或骑马前往 {area:813}，再到 {zone:1422} 西缘、{area:3197} 西北方：毒雾潜伏者（50—51级，会施毒）掉落 {item:20610}，生病的黑熊（51—52级，使用 {spell:3427}）掉落 {item:20611}，两者掉率均为五分之一；那里的两只食腐秃鹫则两种都可能掉落。更东边体形较大的生病的灰熊和瘟疫潜伏者几乎不掉。提瑞斯法的 {area:159} 东南方也有少量熊和潜伏者游荡。",

	-- Step 7: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "{area:1417}",
	-- {area:75} Stonard · {area:1417} Sunken Temple · {area:1477} Temple of Atal'Hakkar · {area:74} Pool of Tears · {npc:5716} Zul'Lor · {spell:139} Renew · {npc:3560} Healing Ward
	-- plural, as words: Shadow Bolt Volleys = {spell:9081} Shadow Bolt Volley
	["A five-player dungeon: needs a group of five, about level 50-55. Fly to {area:75} and ride east. The {area:1417} ({area:1477}) stands in the middle of the {area:74}: climb the stairs on the ruin's south side, dive into the flooded hall, swim down through it and follow the stairs and passages down to the portal. Two feathers of each colour, one from each of six elite troll mini-bosses (level 51-52) on the balconies around the temple's great round room, every kill, and each player on the quest loots their own: Gasher and {npc:5716} the Amber, Hukku and Mijan the Blue, Zolo and Loro the Green. Mijan heals the others ({spell:139}, a {npc:3560}): kill him first; Hukku summons guardians and throws Shadow Bolt Volleys."] = "这是五人地下城：需要约 50-55 级的五人小队。飞往 {area:75}，骑马向东。{area:1417}（{area:1477}）位于 {area:74} 中央：登上遗迹南侧的阶梯，潜入被水淹没的大厅，向下游过大厅，再沿楼梯和通道继续向下到传送门。神庙圆形大厅周围的阳台上有六名精英巨魔小首领（51-52 级），每名都必定掉落一根羽毛，每种颜色共两根，队伍中每位有任务的玩家都能拾取自己的：加什尔和 {npc:5716} 掉落琥珀色，胡库和米杉掉落蓝色，祖罗和洛若掉落绿色。米杉会治疗其他首领（{spell:139}、{npc:3560}）：先杀他；胡库会召唤守卫并施放群体暗影箭。",
	-- {item:20606} Amber Voodoo Feather · {npc:5716} Zul'Lor
	["{item:20606}: Gasher, {npc:5716}"] = "{item:20606}：加什尔、{npc:5716}",
	-- {item:20607} Blue Voodoo Feather
	["{item:20607}: Hukku, Mijan"] = "{item:20607}：胡库、米杉",
	-- {item:20608} Green Voodoo Feather
	["{item:20608}: Zolo, Loro"] = "{item:20608}：祖罗、洛若尔",

	-- Step 8: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher
	["{npc:6176}: the old item choice may be gone, count on the experience"] = "{npc:6176}：原来的物品奖励选项可能已移除，按只有经验奖励来打算。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 50 {npc:13417}, the shaman trainer in the {object:172957}, sends you to {npc:6176}."] = "50级时，{object:172957}的萨满祭司训练师{npc:13417}会让你去找{npc:6176}。",
	-- ["At 50 {npc:3032}, a shaman trainer in {zone:1456}, sends you to {npc:6176}."] = "50级时，{zone:1456}的萨满祭司训练师{npc:3032}会让你去找{npc:6176}。",
	-- ["Experience and gold at 50, ending in the {area:1417}; Forever removed the Classic item choice."] = "50级时获取经验和金币，最终前往{area:1417}；Forever 取消了经典版的物品选择。",
	-- ["In the {zone:1422}, the Venom Mist Lurkers drop the {item:20610} and the Diseased Black Bears the {item:20611} (about one kill in five each). Carrion birds can drop either, so keep what they give you on the way."] = "在{zone:1422}，{npc:1822}掉落{item:20610}，{npc:1815}掉落{item:20611}（各自大约五次击杀掉落一次）。食腐鸟可能掉落其中任一种，路上得到的也要留着。",
	-- ["One each of {item:7069}, Fire, Earth and Water. The Exiles of Arathi Highlands drop them, one element each, about one kill in ten: Thundering (air), Burning (fire), Rumbling (earth) and Cresting (water). Or buy them at the auction house."] = "{item:7069}、元素火焰、元素之土和元素之水各一份。阿拉希高地的流放者会掉落它们，每种对应一个元素，大约十次击杀掉落一次：雷霆流放者（空气）、烈焰流放者（火焰）、顽石流放者（土）和水浪流放者（水）。也可以在拍卖行购买。",
	-- ["One each of {item:7069}, Fire, Earth and Water. The Exiles of {zone:1417} drop them, one element each, about one kill in ten: Thundering (air), Burning (fire), Rumbling (earth) and Cresting (water). Or buy them at the auction house."] = "{item:7069}、元素火焰、元素之土和元素之水各一份。{zone:1417}的流放者会掉落它们，每种对应一个元素，大约十次击杀掉落一次：雷霆流放者（空气）、烈焰流放者（火焰）、顽石流放者（土）和水浪流放者（水）。也可以在拍卖行购买。",
	-- ["The {area:1417} ({area:1477}) lies under the {area:74}; the arrow points at its entrance. Gasher or {npc:5716} drop the {item:20606}, Hukku or Mijan the Blue, Zolo or Loro the Green: all six are elite trolls inside. Bring a group."] = "{area:1417}（{area:1477}）位于{area:74}下方；箭头指向其入口。加什尔或{npc:5716}掉落{item:20606}，胡库或米杉掉落蓝色，祖罗或洛若尔掉落绿色：六个都是里面的精英巨魔。组队前往。",
	-- ["{item:7070}: Cresting Exiles"] = "{item:7070}：{npc:2761}",
	-- ["{npc:6176} camps in the east of {zone:1416}, north-east of {area:272}."] = "{npc:6176}在{zone:1416}东部、{area:272}东北边扎营。",
}
