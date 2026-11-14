-- Chinese (simplified) (zhCN): the guide forever/horde/03-silverpine-forest (forever/horde/03-silverpine-forest.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Orgrimmar
	-- {npc:3310} Doras · {object:172982} Valley of Strength · {npc:6929} Innkeeper Gryshka · {npc:268701} Thatog · {zone:1421} Silverpine Forest · {zone:1413} Barrens
	["Walk in by the main gate. {npc:3310}, the wind rider master, stands on the tower in the {object:172982}; {npc:6929} keeps the inn below it, {npc:268701} stands by the bank. Bind here: the Hearthstone brings you back from {zone:1421} beside the zeppelin towers and the road to the {zone:1413}."] = "从正门进城。驭风者管理员 {npc:3310} 站在 {object:172982} 的高塔上；{npc:6929} 在塔下经营旅店，{npc:268701} 站在银行旁。把炉石绑定在这里：炉石会把你从 {zone:1421} 带回这里，紧邻飞艇塔和通往 {zone:1413} 的道路。",

	-- Step 2: Borstan
	-- {object:173016} Borstan's Firepit
	["{object:173016} is a few steps north."] = "{object:173016} 就在北边几步处。",

	-- Step 3: Neeru Fireblade
	-- {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {quest:829} Neeru Fireblade
	["The {object:172960} is the canyon under the {object:172982}; {quest:829} stands at its far end."] = "{object:172960}是{object:172982}下方的峡谷；{quest:829}站在它的尽头。",
	-- {quest:829} Neeru Fireblade · {quest:809} Ak'Zeloth · {area:379} Far Watch Post
	["{quest:829}: {quest:809} stands at {area:379}, on the next guide's road to the Crossroads"] = "{quest:829}：{quest:809}站在{area:379}，就在下一份指南前往十字路口的路上",
	-- {quest:829} Neeru Fireblade · {quest:832} Burning Shadows · {item:4903} Eye of Burning Shadow · {zone:1411} Durotar
	["{quest:829}: {quest:832}, from the {item:4903} in {zone:1411}"] = "{quest:829}：{quest:832}，来自{zone:1411}的{item:4903}",

	-- Step 4: The Drag
	-- {npc:3348} Kor'geld · {npc:3347} Yelmak · {npc:11046} Whuut
	["{npc:3348} and {npc:3347} run the alchemy shop in the Drag; {npc:11046} is next door."] = "{npc:3348}和{npc:3347}在暗巷区经营炼金商店；{npc:11046}就在隔壁。",

	-- Step 5: Jandi
	-- {npc:3404} Jandi
	["{npc:3404}, the herbalism trainer, keeps her shop in the Drag."] = "草药学训练师{npc:3404}在暗巷区开店。",
	-- {npc:3404} Jandi · {zone:1411} Durotar
	["{npc:3404}: Camping 101, from Brakk's campfire in {zone:1411}"] = "{npc:3404}：露营入门，来自{zone:1411}布拉克的营火",

	-- Step 6: Jhag
	-- {npc:11066} Jhag
	["{npc:11066}, the enchanting trainer, works in the Drag."] = "附魔训练师{npc:11066}在暗巷区工作。",
	-- {npc:11066} Jhag · {zone:1411} Durotar
	["{npc:11066}: Camping 101, from Brakk's campfire in {zone:1411}"] = "{npc:11066}：露营入门，来自{zone:1411}布拉克的营火",

	-- Step 7: Valley of Honor
	-- {object:172958} Valley of Honor
	["The cattails and speargrass grow along the water in the {object:172958}, east of the Drag."] = "香蒲和矛草长在暗巷区东边{object:172958}的水边。",

	-- Step 8: Thuwd
	-- {npc:7088} Thuwd · {object:172958} Valley of Honor
	["{npc:7088}, the skinning trainer, stands in the {object:172958}."] = "剥皮训练师{npc:7088}站在{object:172958}。",
	-- {npc:7088} Thuwd · {zone:1411} Durotar
	["{npc:7088}: Camping 101, from Brakk's campfire in {zone:1411}"] = "{npc:7088}：露营入门，来自{zone:1411}布拉克的营火",

	-- Step 9: Karolek
	-- {npc:3365} Karolek · {object:172958} Valley of Honor
	["{npc:3365}, the leatherworking trainer, works in the {object:172958}."] = "制皮训练师{npc:3365}在{object:172958}工作。",
	-- {npc:3365} Karolek · {zone:1411} Durotar
	["{npc:3365}: Camping 101, from Brakk's campfire in {zone:1411}"] = "{npc:3365}：露营入门，来自{zone:1411}布拉克的营火",

	-- Step 10: Snang
	-- {npc:2855} Snang · {object:172958} Valley of Honor
	["{npc:2855}, the tailoring trainer, is in the {object:172958}."] = "裁缝训练师{npc:2855}在{object:172958}。",
	-- {npc:2855} Snang · {zone:1411} Durotar
	["{npc:2855}: Camping 101, from Brakk's campfire in {zone:1411}"] = "{npc:2855}：露营入门，来自{zone:1411}布拉克的营火",

	-- Step 11: Class trainer
	["Class trainer"] = "职业训练师",
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits · {quest:5654} Hex of Weakness
	["Train while you are in the city: Druids and Paladins have no trainer here. Troll Priests: train with {npc:6018} in the {object:172961}, who takes {quest:5654}."] = "趁在城里学习技能：这里没有德鲁伊和圣骑士训练师。巨魔牧师：到{object:172961}找{npc:6018}训练，他也接收{quest:5654}。",

	-- Step 12: Sayoc
	-- {spell:197} Two-Handed Axes · {npc:11868} Sayoc · {object:172958} Valley of Honor
	["While you're here: learn {spell:197} from {npc:11868} ({object:172958}, 10 silver); two-handers level a Warrior fastest."] = "趁在这里：向 {npc:11868} 学习 {spell:197}（{object:172958}，10 银币）；战士用双手武器升级最快。",

	-- Step 13: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "顺便：在{npc:2704}处学习法杖（{object:172958}，10银币）；猎人的近战武器主要看属性，而双手武器属性最多。",

	-- Step 14: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "顺便：向{npc:2704}（{object:172958}，10银币）学习法杖；升级期间，法杖提供的法术属性比单手武器多。",

	-- Step 17: Whuut
	-- {npc:11046} Whuut · {npc:3348} Kor'geld
	["{npc:11046}, the alchemy trainer, stands next door to {npc:3348}."] = "炼金术训练师{npc:11046}就在{npc:3348}隔壁。",
	-- {npc:11046} Whuut · {zone:1411} Durotar
	["{npc:11046}: Camping 101, from Brakk's campfire in {zone:1411}"] = "{npc:11046}：露营入门，来自{zone:1411}布拉克的营火",

	-- Step 18: Valley of Wisdom
	-- {npc:268684} Thra · {npc:268682} Migi · {object:172957} Valley of Wisdom
	-- plural, as words: Smooth Boulders = {item:277952} Smooth Boulder
	["{npc:268684} and {npc:268682} sit behind Grommash Hold in the {object:172957}; the Smooth Boulders lie around them."] = "{npc:268684} 和 {npc:268682} 坐在 {object:172957} 的 Grommash Hold 后方，光滑的巨石就在两人周围。",

	-- Step 19: Thrall
	-- {npc:4949} Thrall · {quest:98024} Journey to the Crossroads · {quest:93739} Exploring the Horde · {quest:95350} Welcome to Azeroth
	["{npc:4949} stands in Grommash Hold. He offers {quest:98024} and {quest:93739} once {quest:95350} is handed in."] = "{npc:4949} 站在 Grommash Hold 内。交掉 {quest:95350} 后，他会提供 {quest:98024} 和 {quest:93739}。",
	-- {npc:4949} Thrall
	["{npc:4949}, inside Grommash Hold"] = "{npc:4949}，在格罗玛什要塞里",
	-- {npc:4949} Thrall · {zone:1413} Barrens
	["{npc:4949}: keep it, Thork at the Crossroads in the {zone:1413} guide"] = "{npc:4949}：先留着，在 {zone:1413} 指南中交给十字路口的索克",
	-- {npc:4949} Thrall · {quest:93739} Exploring the Horde
	["{npc:4949}: {quest:93739}, a tour of the Horde's leaders"] = "{npc:4949}：{quest:93739}，游览部落各位领袖",
	-- {npc:3230} Nazgrel
	["Speak with {npc:3230}, in Grommash Hold"] = "与格罗玛什要塞里的{npc:3230}交谈",
	-- {npc:3230} Nazgrel
	["Talk to {npc:3230}"] = "与{npc:3230}交谈",
	-- {npc:10540} Vol'jin
	["Speak with {npc:10540}, in Grommash Hold"] = "与格罗玛什要塞里的{npc:10540}交谈",
	-- {npc:10540} Vol'jin
	["Talk to {npc:10540}"] = "与{npc:10540}交谈",

	-- Step 20: Nazgrel
	-- {npc:3230} Nazgrel
	["{npc:3230}, in Grommash Hold"] = "{npc:3230}，在 Grommash Hold 内",

	-- Step 21: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "乘飞艇前往{zone:1458}",

	-- Step 22: Brill
	-- {area:159} Brill · {npc:1738} Deathguard Terrence · {npc:1518} Apothecary Johaan · {npc:246152} Shari Stilwell
	["{area:159} is a short walk north up the road from the zeppelin towers: {npc:1738} stands by the road into town, {npc:1518} in the apothecary's house on the west side of the square; Paladins: {npc:246152} trains you in town."] = "从飞艇塔沿道路向北走一小段就到{area:159}：{npc:1738}站在进镇的路旁，{npc:1518}在广场西侧的药剂师房子里；圣骑士：{npc:246152}在镇上为你训练。",
	-- {npc:1518} Apothecary Johaan
	["{npc:1518}, inside"] = "{npc:1518}：在屋内",
	-- {npc:246152} Shari Stilwell · {area:159} Brill
	["{npc:246152}, in {area:159}"] = "{npc:246152}，在{area:159}",

	-- Step 23: Hadric Harlson
	-- {npc:1495} Deathguard Linnea · {npc:267009} Hadric Harlson
	["Back down the road past the zeppelin towers and east to {npc:1495}'s camp: {npc:267009} stands beside her."] = "沿道路返回，经过飞艇塔后向东走到{npc:1495}的营地：{npc:267009}站在她旁边。",

	-- Step 24: The Cult of the Damned
	-- {npc:267009} Hadric Harlson
	-- plural, as words: Dark Neophytes = {npc:267006} Dark Neophyte · Dark Enforcers = {npc:275437} Dark Enforcer · Necrotic Crystal Fragments = {item:275851} Necrotic Crystal Fragment
	["The cultists camp a short walk south-east of {npc:267009}. Dark Neophytes and Dark Enforcers drop the Necrotic Crystal Fragments; more fragments, black crystals, lie on the ground among the tents."] = "邪教徒在{npc:267009}东南方不远处扎营。黑暗新教徒和黑暗执行者会掉落死灵水晶碎片；帐篷间的地面上也有黑色水晶，可以收集更多碎片。",

	-- Step 27: The Sepulcher
	-- {area:228} The Sepulcher · {npc:2226} Karos Razok
	["{area:228} is the Forsaken crypt-town in the middle of the forest. Everyone you need stands around the crypt entrance; {npc:2226}, the bat handler, is just east of it."] = "{area:228}是森林中央的被遗忘者墓穴小镇。你要找的人都站在墓穴入口周围；蝙蝠管理员{npc:2226}就在入口东边。",
	-- {npc:2226} Karos Razok · {npc:4556} Gordon Wendham · {zone:1458} Undercity
	["{npc:2226}: {npc:4556} in the {zone:1458}, at the end of this guide; no need to buy the flight"] = "{npc:2226}：交给{zone:1458}的{npc:4556}，在本指南最后完成；无需购买飞行路线",
	-- {npc:1952} High Executor Hadrec
	["{npc:1952}, below ground"] = "{npc:1952}：在地下",

	-- Step 28: The Sepulcher
	-- {quest:264} Until Death Do Us Part · {object:24776} Yuriv's Tombstone
	["{quest:264} is handed in at {object:24776}, a grave a few steps south of the crypt entrance, not to a person."] = "{quest:264}要在{object:24776}交付，那是墓穴入口南边几步远的一座坟墓，而不是交给某个人。",

	-- Step 29: Border Crossings
	-- {object:1627} Dalaran Crate
	-- plural, as words: Dalaran Apprentices = {npc:1867} Dalaran Apprentice
	["Follow the road south. The {object:1627} sits beside it, north of Pyrewood. Careful: Dalaran Apprentices (13) stand around the crate: pull them one at a time before you open it."] = "沿道路向南。{object:1627}就在路边，焚木村北边。小心：达拉然学徒（13级）站在箱子周围：打开箱子前一次引一个。",

	-- Step 30: The Dead Field
	-- {area:228} The Sepulcher · {npc:1983} Nightlash · {area:240} The Dead Field
	["North of the {area:228}. {npc:1983} haunts the {area:240}: kill it, then walk across the field. Careful: {npc:1983} (14) rises once you have killed rot hide gnolls in the field: fight her with full health."] = "在{area:228}北边。{npc:1983}在{area:240}出没：杀死它，然后穿过田野。小心：在田里杀死腐皮豺狼人后，{npc:1983}（14级）就会出现：满血再和她战斗。",

	-- Step 31: Malden's Orchard
	-- {area:238} Malden's Orchard
	["Follow the road north-east to the Yoricks' house at {area:238}."] = "沿道路向东北前往{area:238}的尤瑞克家。",

	-- Step 32: Mottled Worgs
	-- plural, as words: Mottled Worgs = {npc:1766} Mottled Worg
	["Mottled Worgs"] = "杂斑座狼",
	-- plural, as words: Mottled Worgs = {npc:1766} Mottled Worg
	["Mottled Worgs prowl the hills around the house."] = "杂斑座狼在房子周围的山丘上游荡。",

	-- Step 33: Escorting Erland
	-- {npc:1978} Deathstalker Erland · {npc:1950} Rane Yorick
	["{npc:1978} waits north-east of the house. Escort him back to {npc:1950}; worgs attack on the way."] = "{npc:1978}在房子东北边等候。护送他回到{npc:1950}那里；途中会有座狼袭击。",
	-- {npc:1978} Deathstalker Erland
	["{npc:1978}, inside"] = "{npc:1978}：在屋内",

	-- Step 36: The Sepulcher
	-- {npc:1938} Dalar Dawnweaver · {area:227} Valgan's Field
	["{npc:1938}: his books lie in the {area:227} farmhouse, on the walk north"] = "{npc:1938}：他的书在 {area:227} 的农舍里，向北走时顺路拾取",
	-- {npc:1937} Apothecary Renferrel · {zone:1458} Undercity
	["{npc:1937}: Zinge in the {zone:1458}, on the way to the zeppelin at the end"] = "{npc:1937}：交给 {zone:1458} 的金格，在最后前往飞艇时顺路完成",
	-- {area:233} Ambermill
	["{area:233} comes later, down the lake shore"] = "{area:233} 留到后面，沿湖岸往下走时再去",

	-- Step 37: Valgan's Field farmhouse
	-- {area:227} Valgan's Field
	["{area:227} farmhouse"] = "{area:227} 农舍",
	-- {area:227} Valgan's Field · {object:1571} Dusty Spellbooks · {npc:1770} Moonrage Darkrunner
	["On the road north, the farmhouse at {area:227}: go upstairs, the {object:1571} lie on the floor in the back room. Looting them brings a {npc:1770}."] = "沿路向北，到 {area:227} 的农舍：上楼，{object:1571} 就在后面房间的地板上。拾取后会出现一只 {npc:1770}。",
	-- {object:1571} Dusty Spellbooks
	["{object:1571}; upstairs"] = "{object:1571}；在楼上",

	-- Step 38: Quinn Yorick
	["North again to the Yoricks' house."] = "再次向北前往尤瑞克家。",
	-- {npc:1951} Quinn Yorick
	["{npc:1951}, inside"] = "{npc:1951}：在屋内",

	-- Step 39: Vile Fin murlocs
	["Vile Fin murlocs"] = "邪鳍鱼人",
	-- plural, as words: Vile Fin Shredders = {npc:1767} Vile Fin Shredder
	["Follow the lake shore south-east from the Yoricks' house: the Vile Fin Shredders and Tidehunters along it drop the murloc eyes."] = "从尤瑞克家沿湖岸向东南走：沿岸的邪鳍切割者和邪鳍潮行者会掉落鱼人眼球。",

	-- Step 40: The Decrepit Ferry
	-- {object:1593} Corpse Laden Boat · {area:233} Ambermill
	["Follow the lake shore south from the murlocs: the {object:1593} lies at the ferry landing, on the way to {area:233}."] = "从鱼人处沿湖岸向南走：{object:1593} 就在渡口，去 {area:233} 的路上。",

	-- Step 41: Ambermill
	-- {area:233} Ambermill · {npc:2540} Dalaran Serpent · {npc:2120} Archmage Ataeric
	["Keep south along the shore from the ferry to {area:233}. Protectors guard the outskirts and Mages the town; both drop pendants. Careful: each Mage (15) fights with a {npc:2540} (15) beside it: pull one Mage at a time from the outskirts. Stay out of the middle, where {npc:2120} (22) stands."] = "从渡口继续沿湖岸向南到 {area:233}。达拉然保卫者守卫外围，达拉然法师守在镇内；两者都会掉落坠饰。小心：每个达拉然法师（15级）身边都有一个 {npc:2540}（15级）协同作战：从外围一次只引一个法师。避开镇中心，{npc:2120}（22级）就在那里。",

	-- Step 42: The Sepulcher
	-- {area:228} The Sepulcher
	["Back north-west up the road to the {area:228}."] = "沿道路向西北返回{area:228}。",
	-- {npc:1937} Apothecary Renferrel
	["{npc:1937}: for Quinn, on the road north at the end"] = "{npc:1937}：为了奎恩，最后在北边的路上",
	-- {npc:1938} Dalar Dawnweaver
	["{npc:1938}, just north of Allister"] = "{npc:1938}，就在暗影牧师奥利斯特北边",
	-- {npc:1499} Magistrate Sevren · {area:159} Brill
	["{npc:1499} in {area:159}, on the way to the zeppelin at the end"] = "交给 {area:159} 的 {npc:1499}，在最后前往飞艇时顺路完成",

	-- Step 43: The Ivar Patch
	-- {zone:1420} Tirisfal Glades · {area:238} Malden's Orchard · {quest:425} Ivar the Foul
	["Take the road north toward {zone:1420}: the Yoricks' house at {area:238} is on the way. {quest:425} lurks a short walk west of it."] = "沿道路向北朝{zone:1420}走：{area:238}的尤瑞克家就在路上。{quest:425}潜伏在房子西边不远处。",
	["Inside"] = "在里面",

	-- Step 45: Magistrate Sevren
	-- {area:159} Brill · {npc:1499} Magistrate Sevren
	["{area:159} is a short walk north up the road from the zeppelin towers; {npc:1499} is in the town hall."] = "从飞艇塔沿路向北走不远就是{area:159}；{npc:1499}在镇公所内。",

	-- Step 47: The Undercity
	-- {object:1661} The Undercity · {area:153} Ruins of Lordaeron · {npc:2050} Raleigh Andrean · {npc:7683} Alessandro Luca · {npc:11044} Doctor Martin Felben · {npc:5204} Apothecary Zinge · {npc:2055} Master Apothecary Faranell
	["{object:1661} lies under the {area:153}, beside the zeppelin towers. {npc:2050} stands at the inn by the way down; {npc:7683} on the way down to the Apothecarium, where {npc:11044} and {npc:5204} stand beside {npc:2055}."] = "{object:1661} 位于 {area:153} 地下，旁边就是飞艇塔。{npc:2050} 在下去入口旁的旅店；{npc:7683} 在通往炼金房的路上，{npc:11044} 和 {npc:5204} 就在炼金房内的 {npc:2055} 旁。",
	-- {npc:4556} Gordon Wendham
	["{npc:4556}, the weapon merchant beside the bat handler"] = "{npc:4556}，蝙蝠管理员旁边的武器商人",
	-- {npc:4551} Michael Garrett
	["{npc:4551}, the bat handler"] = "{npc:4551}，蝙蝠管理员",
	-- {npc:4551} Michael Garrett · {item:16210} Gordon's Crate · {area:228} The Sepulcher
	["{npc:4551}: keep {item:16210}, Podrig takes it on the next stop at the {area:228}, at 22"] = "{npc:4551}：留着{item:16210}，22级时在下一站{area:228}交给波德里格",
	-- {npc:11044} Doctor Martin Felben
	["{npc:11044}, in the Apothecarium"] = "{npc:11044}，在炼金房",
	-- {npc:5204} Apothecary Zinge
	["{npc:5204}, in the Apothecarium"] = "{npc:5204}，在炼金房内",
	-- {npc:5204} Apothecary Zinge
	["{npc:5204}: Helbrim at the Crossroads, in the next guide"] = "{npc:5204}：交给十字路口的赫布瑞姆，见下一篇指南",
	-- {npc:260093} Garen Largo · {area:1497} Undercity
	["{npc:260093}, the {area:1497}'s paladin trainer"] = "{npc:260093}，{area:1497}的圣骑士训练师",

	-- Step 48: Brom Killian
	-- {npc:4598} Brom Killian · {zone:1458} Undercity
	["{npc:4598}, the mining trainer, works in the {zone:1458}."] = "采矿训练师{npc:4598}在{zone:1458}工作。",
	-- {npc:4598} Brom Killian · {npc:265812} Eleanor Shackleton
	["{npc:4598}: Camping 101, from {npc:265812}'s campfire in Tirisfal"] = "{npc:4598}：露营入门，来自提瑞斯法林地{npc:265812}的营火",

	-- Step 49: Basil Frye
	-- {npc:4605} Basil Frye · {zone:1458} Undercity
	["{npc:4605}, the blacksmithing trainer, works in the {zone:1458}."] = "锻造训练师{npc:4605}在{zone:1458}工作。",
	-- {npc:4605} Basil Frye · {npc:265812} Eleanor Shackleton
	["{npc:4605}: Camping 101, from {npc:265812}'s campfire in Tirisfal"] = "{npc:4605}：露营入门，来自提瑞斯法林地{npc:265812}的营火",

	-- Step 50: Graham Van Talen
	-- {npc:4586} Graham Van Talen · {zone:1458} Undercity
	["{npc:4586}, the engineering trainer, works in the {zone:1458}."] = "工程学训练师{npc:4586}在{zone:1458}工作。",
	-- {npc:4586} Graham Van Talen · {npc:265812} Eleanor Shackleton
	["{npc:4586}: Camping 101, from {npc:265812}'s campfire in Tirisfal"] = "{npc:4586}：露营入门，来自提瑞斯法林地{npc:265812}的营火",

	-- Step 51: Lady Sylvanas Windrunner
	-- {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter
	["{npc:10181} holds court in the {object:36126}."] = "{npc:10181} 在 {object:36126} 主持议事。",
	-- {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter · {quest:93739} Exploring the Horde
	["Speak with {npc:10181}, in the {object:36126}: {quest:93739}"] = "与{object:36126}的{npc:10181}交谈：{quest:93739}",
	-- {npc:10181} Lady Sylvanas Windrunner
	["Talk to {npc:10181}"] = "与{npc:10181}交谈",

	-- Step 52: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "乘飞艇前往{zone:1454}",

	-- Step 53: Orgrimmar
	-- {zone:1454} Orgrimmar · {object:172982} Valley of Strength
	["{zone:1454}'s {object:172982}"] = "{zone:1454}的{object:172982}",

	-- Step 54: Valley of Strength
	-- {npc:268701} Thatog · {object:172982} Valley of Strength
	["Walk in through the main gate. {npc:268701} stands in the {object:172982}."] = "从正门进入。{npc:268701} 站在 {object:172982} 内。",

	-- Step 57: Neeru Fireblade
	-- {area:2437} Ragefire Chasm · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {npc:3216} Neeru Fireblade
	["For your {area:2437} run: the {object:172960} is the canyon under the {object:172982}; {npc:3216} stands at its far end, next to the {area:2437} portal."] = "为{area:2437}之行做准备：{object:172960}是{object:172982}下方的峡谷；{npc:3216}站在它的尽头，{area:2437}传送门旁边。",

	-- Step 58: Ragefire Chasm
	-- {area:2437} Ragefire Chasm · {object:172960} Cleft of Shadow · {npc:3216} Neeru Fireblade · {npc:11520} Taragaman the Hungerer · {npc:11518} Jergosh the Invoker · {npc:4949} Thrall
	["{area:2437} is a dungeon for a group of five, about levels 13 to 18, and a full run takes 30 to 45 minutes. Its portal is in the {object:172960}, beside {npc:3216}.\nInside: past Oggleflint and his troggs, {npc:11520} waits in the lava cave and drops his heart. {npc:11518} and Bazzalan, further in, are for {npc:4949}'s Hidden Enemies, which this route leaves out."] = "{area:2437}是适合13-18级左右五人小队的地下城，完整打一次需要30到45分钟。传送门在{object:172960}，{npc:3216}旁边。\n副本内：经过奥格弗林特和他的穴居人后，{npc:11520}在熔岩洞里等着，掉落他的心脏。更深处的{npc:11518}和巴扎兰对应{npc:4949}的“隐藏的敌人”，本路线不做。",

	-- Step 59: Neeru Fireblade
	-- {npc:3216} Neeru Fireblade
	["Back out through the portal: {npc:3216} stands beside it."] = "从传送门出来：{npc:3216}就站在旁边。",

	-- Step 63: Sayoc
	-- {spell:197} Two-Handed Axes · {npc:11868} Sayoc · {object:172958} Valley of Honor
	["While you're here: learn {spell:197} from {npc:11868} ({object:172958}, 10 silver); two-handers level a Paladin fastest."] = "趁在这里：向 {npc:11868} 学习 {spell:197}（{object:172958}，10 银币）；圣骑士用双手武器升级最快。",

	-- Step 65: Zor Lonetree
	-- {npc:4047} Zor Lonetree · {npc:4049} Seereth Stonebreak
	["{npc:4047}: {npc:4049}, on the road into Stonetalon in the next guide"] = "{npc:4047}：交给 {npc:4049}，她在下一篇指南进入石爪山脉的路上",

	-- Step 66: Valley of Wisdom
	-- {npc:268684} Thra · {npc:268682} Migi · {object:172957} Valley of Wisdom · {area:379} Far Watch Post
	-- plural, as words: Smooth Boulders = {item:277952} Smooth Boulder
	["{npc:268684} and {npc:268682} sit behind Grommash Hold in the {object:172957}; the Smooth Boulders lie around them. The next guide walks from here to {area:379} and the Crossroads."] = "{npc:268684} 和 {npc:268682} 坐在 {object:172957} 的 Grommash Hold 后方，光滑的巨石就在两人周围。下一篇指南会从这里步行前往 {area:379} 和十字路口。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At the {area:2362}"] = "在{area:2362}",
	-- ["Cast {spell:18960}; {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "施放{spell:18960}；{npc:11802}在{area:2361}。神殿灵珠躺在{area:656}的湖底，几分钟内就会消失：拿到一个后直接游到西北岸的{area:2362}，在那里使用它并与{npc:11799}交谈。",
	-- ["Cast {spell:18960}; {npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "施放{spell:18960}；{npc:11802}在{area:2361}他那栋建筑的楼上：从室内上楼，箭头无法区分楼层。神殿灵珠躺在{area:656}的湖底，几分钟内就会消失：拿到一个后直接游到西北岸的{area:2362}，在那里使用它并与{npc:11799}交谈。",
	-- ["Druid trainer"] = "德鲁伊训练师",
	-- ["Fly to {area:1637}"] = "飞往{area:1637}",
	-- ["Fly to {area:1638}: {npc:3033} trains you on {area:1639}. Skyborne: fly back to {zone:1454} for the zeppelin afterwards."] = "飞往{area:1638}：{npc:3033}在{area:1639}训练你。天裔：之后飞回{zone:1454}乘坐飞艇。",
	-- ["Follow the lake shore south-east and swim out to {area:172}. Rot Hide gnolls cover the island; every type drops ichor. Stay out of {area:235} on its north side unless you go for the optional niche: the gnolls there are level 18-22."] = "沿湖岸向东南走，游到{area:172}。岛上到处是腐皮豺狼人；每种都会掉落脓液。除非你要做可选的额外内容，否则别进入岛北侧的{area:235}：那里的豺狼人是18-22级。",
	-- ["Follow the lake shore south-east toward {area:172}: the Vile Fin Shredders and Tidehunters along it drop the murloc eyes."] = "沿湖岸向东南朝{area:172}走：沿途的邪鳍切割者和邪鳍潮行者会掉落鱼人的眼球。",
	-- ["Follow the road north out of Silverpine into {zone:1420} and east to the zeppelin towers outside the {area:153}. Take the zeppelin to {zone:1454}."] = "沿道路向北离开银松森林进入{zone:1420}，再向东前往{area:153}外的飞艇塔。乘坐前往{zone:1454}的飞艇。",
	-- ["Follow the road north out of Silverpine into {zone:1420} and on to {area:159}: {npc:246152} trains Paladins there. The zeppelin towers are a short walk south down the road."] = "沿道路向北离开银松森林进入{zone:1420}，继续前往{area:159}：{npc:246152}在那里训练圣骑士。飞艇塔沿道路向南步行不远即到。",
	-- ["From the {area:380}, follow the road north-east to {area:1637} and walk in by the main gate. {npc:3310}, the wind rider master, stands on the tower in the {object:172982}."] = "从{area:380}沿道路向东北前往{area:1637}，从正门进城。双足飞龙管理员{npc:3310}站在{object:172982}的塔上。",
	-- ["Hearth to the {area:228}"] = "用炉石回到{area:228}",
	-- ["Into Silverpine"] = "进入银松森林",
	-- ["Keep it: Thork at the {area:380}"] = "留着它：交给{area:380}的索克",
	-- ["Keep it: {npc:2216} in {area:272}, a later guide"] = "留着它：交给{area:272}的{npc:2216}，在之后的指南中",
	-- ["Moonrage Bloodhowlers"] = "月怒血啸者",
	-- ["Mottled Worgs prowl the hills around the house. Then walk south along the lake shore: the Vile Fin Shredders and Tidehunters there drop the murloc eyes."] = "杂斑座狼在房子周围的山丘上游荡。然后沿湖岸向南走：那里的邪鳍切割者和邪鳍潮行者会掉落鱼人的眼球。",
	-- ["North again to the Yoricks' house. {quest:425} lurks a short walk west of it."] = "再次向北前往尤瑞克家。{quest:425}潜伏在房子西边不远处。",
	-- ["North of the {area:228}. Nightlash haunts the {area:240}: kill it, then walk across the field."] = "在{area:228}北边。奈塔拉什在{area:240}出没：杀死它，然后穿过田野。",
	-- ["North-east of the refugees, the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "在难民东北边，鸦爪苦工和鸦爪守护者在森林东南部的{quest:516}废墟中出没。",
	-- ["Only if {npc:1938} gave you {quest:98298}: the Bloodhowlers prowl the woods south-west of {area:233}, east of Pyrewood; they drop the {item:280375}."] = "仅当{npc:1938}给了你{quest:98298}时：血啸者在{area:233}西南、焚木村东边的林中游荡；它们掉落{item:280375}。",
	-- ["Paladin trainer"] = "圣骑士训练师",
	-- ["Road to Silverpine"] = "通往银松森林的道路",
	-- ["South down the shore to {area:233}. Protectors guard the outskirts and Mages the town; both drop pendants. Wizards and Watchers patrol the roads around it. Stay out of the middle, where {npc:2120} stands."] = "沿湖岸向南前往{area:233}。达拉然保卫者守卫外围，达拉然法师守在镇里；两者都会掉落坠饰。达拉然巫师和达拉然卫士在周围的道路上巡逻。别进入镇中心，{npc:2120}就站在那里。",
	-- ["South-east down the road to {area:233}. Protectors guard the outskirts and Mages the town; both drop pendants. Wizards and Watchers patrol the roads around it. Stay out of the middle, where {npc:2120} stands."] = "沿道路向东南前往{area:233}。达拉然保卫者守卫外围，达拉然法师守在镇里；两者都会掉落坠饰。达拉然巫师和达拉然卫士在周围的道路上巡逻。别进入镇中心，{npc:2120}就站在那里。",
	-- ["South-west of Ambermill, the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "安伯米尔西南方，森林东南部的{quest:516}废墟中出没着鸦爪苦工和鸦爪守护者。",
	-- ["Swim back and follow the road west to the {area:228}."] = "游回去，沿道路向西前往{area:228}。",
	-- ["Swim back to the shore and follow it south: the Vile Fin Lakestalkers and Oracles sit on the lake shore south of the {area:237}, on the way to {area:233}."] = "游回岸边并沿岸向南：邪鳍巡湖者和邪鳍智者在{area:237}南边的湖岸上，就在前往{area:233}的路上。",
	-- ["Take the road north toward {area:85}: the Yoricks' house at {area:238} is on the way. {quest:425} lurks a short walk west of it."] = "沿道路向北朝{area:85}走：{area:238}的尤瑞克家就在路上。{quest:425}潜伏在房子西边不远处。",
	-- ["The Sickly and Haggard Refugees shamble along the road south of Pyrewood toward the {area:230}."] = "病怏怏的难民和哈迦德难民沿着焚木村南边通往{area:230}的道路蹒跚而行。",
	-- ["The Vile Fin Lakestalkers and Oracles sit on the lake shore south of the {area:237}, east of the {area:228}."] = "邪鳍巡湖者和邪鳍智者在{area:237}南边、{area:228}东边的湖岸上。",
	-- ["The refugees"] = "难民",
	-- ["The zeppelin lands at the towers outside the {area:153}. Walk west along the road past the ruins and south into {zone:1421}; follow the road to the {area:228}."] = "飞艇降落在{area:153}外的塔上。沿道路向西经过废墟，再向南进入{zone:1421}；沿道路前往{area:228}。",
	-- ["The zeppelin towers stand just outside {zone:1454}'s main gate. Take the zeppelin to {zone:1420} (the other one goes to {object:3202})."] = "飞艇塔就在{zone:1454}正门外。乘坐前往{zone:1420}的飞艇（另一艘去{object:3202}）。",
	-- ["The {area:228}"] = "{area:228}",
	-- ["The {object:1593} lies at the ferry landing on the lake shore east of the {area:228}."] = "{object:1593}停在{area:228}东边湖岸的渡口。",
	-- ["The {object:177790} lies on the coast west of the {area:240}. It holds the {item:15882} for Trial of the Sea Lion."] = "{object:177790}在{area:240}西侧海岸。里面有海狮试炼所需的{item:15882}。",
	-- ["To {area:1637}"] = "前往{area:1637}",
	-- ["Walk in through the main gate. {npc:268701} stands in the {object:172982}; {object:173016} is a few steps north."] = "从正门进城。{npc:268701}站在{object:172982}；{object:173016}就在北边几步远。",
	-- ["Worgs and murlocs"] = "座狼和鱼人",
	-- ["Zeppelin to {zone:1420}"] = "乘飞艇前往{zone:1420}",
	-- ["Zeppelin tower"] = "飞艇塔",
	-- ["grind on {npc:1909} at {area:1338}, {zone:1421}"] = "在{zone:1421}的{area:1338}刷{npc:1909}",
	-- ["{area:1338} shore"] = "{area:1338}湖岸",
	-- ["{area:1637} flight master"] = "{area:1637}飞行管理员",
	-- ["{area:233} comes later, on the southern loop"] = "{area:233}稍后在南线环路中前往",
	-- ["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}，来自湖中的{object:177785}",
	-- ["{item:3317}: a rare drop from the gnolls"] = "{item:3317}：豺狼人的稀有掉落",
	-- ["{npc:11066}, the enchanting trainer, works in the Drag."] = "附魔训练师{npc:11066}在暗巷区工作。",
	-- ["{npc:11798} in {area:2361} flies druids there; then fly on to {zone:1454} for the zeppelin"] = "{area:2361}的{npc:11798}载德鲁伊飞往那里；然后继续飞往{zone:1454}乘坐飞艇",
	-- ["{npc:11799}, at the {area:2362}"] = "{npc:11799}，在{area:2362}",
	-- ["{npc:1938}: take it if he offers it; it may follow his {quest:98298} series, which the route does not run"] = "{npc:1938}：如果他提供就接受；它可能接在他的{quest:98298}系列之后，而本路线不做该系列",
	-- ["{npc:2121}: {quest:516}, on the south loop"] = "{npc:2121}：{quest:516}，在南线环路中完成",
	-- ["{npc:2121}: {quest:516}, on the southern loop"] = "{npc:2121}：{quest:516}，在南线环路中完成",
	-- ["{npc:246152} trains Paladins in {area:159}, a short walk north up the road from the zeppelin towers. Come back down the same road for Silverpine."] = "{npc:246152}在{area:159}训练圣骑士，从飞艇塔沿道路向北步行不远即到。之后沿同一条路回来，前往银松森林。",
	-- ["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{zone:1456}的{npc:246344}；{zone:1454}没有圣骑士训练师",
	-- ["{npc:268684} and {npc:268682} sit behind Grommash Hold in the {object:172957}; the Smooth Boulders lie around them. Train while you are in the city (Druids and Paladins have no trainer here). The next guide starts at {npc:3310}, the wind rider master in the {object:172982}."] = "{npc:268684}和{npc:268682}坐在{object:172957}的格罗玛什要塞后面；光滑的巨石就在他们周围。趁在城里时训练（德鲁伊和圣骑士在这里没有训练师）。下一个指南从{object:172982}的双足飞龙管理员{npc:3310}开始。",
	-- ["{npc:3034} in {zone:1412}; {zone:1454} has no druid trainer"] = "{npc:3034} 在 {zone:1412}；{zone:1454} 没有德鲁伊训练师",
	-- ["{npc:3365}, the leatherworking trainer, works in the {object:172958}."] = "制皮训练师{npc:3365}在{object:172958}工作。",
	-- ["{npc:3404}, the herbalism trainer, keeps her shop in the Drag."] = "草药学训练师{npc:3404}在暗巷区开店。",
	-- ["{npc:4551}: keep {item:16210}, Podrig takes it on the ride through the {area:228} at 22"] = "{npc:4551}：留着{item:16210}，22级时乘坐蝙蝠途经{area:228}时交给波德里格",
	-- ["{npc:4949} offers {quest:98024} and {quest:93739} once {quest:95350} is handed in to him."] = "向{npc:4949}交还{quest:95350}后，他会提供{quest:98024}和{quest:93739}。",
	-- ["{npc:6018} stands in the {object:172961} on the city's west side."] = "{npc:6018}在城西侧的{object:172961}。",
	-- ["{npc:7088}, the skinning trainer, stands in the {object:172958}."] = "剥皮训练师{npc:7088}站在{object:172958}。",
	-- ["{object:112888}, inside the keep"] = "{object:112888}，在城堡里",
	-- ["{object:1599}, just east of the keep"] = "{object:1599}，就在城堡东边",
	-- ["{quest:6127}: {area:384}, next guide"] = "{quest:6127}：{area:384}，见下一个指南",
	-- ["{zone:1454} class quests"] = "{zone:1454}职业任务",
}
