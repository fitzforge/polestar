-- Chinese (traditional) (zhTW): the guide forever/horde/03-silverpine-forest (forever/horde/03-silverpine-forest.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Orgrimmar
	-- {npc:3310} Doras · {object:172982} Valley of Strength · {npc:6929} Innkeeper Gryshka · {npc:268701} Thatog · {zone:1421} Silverpine Forest · {zone:1413} Barrens
	["Walk in by the main gate. {npc:3310}, the wind rider master, stands on the tower in the {object:172982}; {npc:6929} keeps the inn below it, {npc:268701} stands by the bank. Bind here: the Hearthstone brings you back from {zone:1421} beside the zeppelin towers and the road to the {zone:1413}."] = "從正門走進去。雙足飛龍管理員{npc:3310}站在{object:172982}的塔上；{npc:6929}經營塔下的旅店，{npc:268701}站在銀行旁。在這裡綁定爐石：爐石會把你從{zone:1421}帶回飛艇塔和通往{zone:1413}的道路旁。",

	-- Step 2: Borstan
	-- {object:173016} Borstan's Firepit
	["{object:173016} is a few steps north."] = "",

	-- Step 3: Neeru Fireblade
	-- {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {quest:829} Neeru Fireblade
	["The {object:172960} is the canyon under the {object:172982}; {quest:829} stands at its far end."] = "{object:172960}是{object:172982}下方的峽谷；{quest:829}站在峽谷盡頭。",
	-- {quest:829} Neeru Fireblade · {quest:809} Ak'Zeloth · {area:379} Far Watch Post
	["{quest:829}: {quest:809} stands at {area:379}, on the next guide's road to the Crossroads"] = "{quest:829}：{quest:809}站在{area:379}，就在下一份指南前往十字路口的路上",
	-- {quest:829} Neeru Fireblade · {quest:832} Burning Shadows · {item:4903} Eye of Burning Shadow · {zone:1411} Durotar
	["{quest:829}: {quest:832}, from the {item:4903} in {zone:1411}"] = "{quest:829}：{quest:832}，來自{zone:1411}的{item:4903}",

	-- Step 4: The Drag
	-- {npc:3348} Kor'geld · {npc:3347} Yelmak · {npc:11046} Whuut
	["{npc:3348} and {npc:3347} run the alchemy shop in the Drag; {npc:11046} is next door."] = "{npc:3348}和{npc:3347}在the Drag經營煉金店；{npc:11046}在隔壁。",

	-- Step 5: Jandi
	-- {npc:3404} Jandi
	["{npc:3404}, the herbalism trainer, keeps her shop in the Drag."] = "{npc:3404}是草藥學訓練師，她的店在the Drag。",
	-- {npc:3404} Jandi · {zone:1411} Durotar
	["{npc:3404}: Camping 101, from Brakk's campfire in {zone:1411}"] = "{npc:3404}：野營入門，來自{zone:1411}布拉克的營火",

	-- Step 6: Jhag
	-- {npc:11066} Jhag
	["{npc:11066}, the enchanting trainer, works in the Drag."] = "{npc:11066}是附魔訓練師，在the Drag工作。",
	-- {npc:11066} Jhag · {zone:1411} Durotar
	["{npc:11066}: Camping 101, from Brakk's campfire in {zone:1411}"] = "{npc:11066}：野營入門，來自{zone:1411}布拉克的營火",

	-- Step 7: Valley of Honor
	-- {object:172958} Valley of Honor
	["The cattails and speargrass grow along the water in the {object:172958}, east of the Drag."] = "香蒲和長矛草沿著the Drag東邊{object:172958}的水邊生長。",

	-- Step 8: Thuwd
	-- {npc:7088} Thuwd · {object:172958} Valley of Honor
	["{npc:7088}, the skinning trainer, stands in the {object:172958}."] = "{npc:7088}是剝皮訓練師，站在{object:172958}。",
	-- {npc:7088} Thuwd · {zone:1411} Durotar
	["{npc:7088}: Camping 101, from Brakk's campfire in {zone:1411}"] = "{npc:7088}：野營入門，來自{zone:1411}布拉克的營火",

	-- Step 9: Karolek
	-- {npc:3365} Karolek · {object:172958} Valley of Honor
	["{npc:3365}, the leatherworking trainer, works in the {object:172958}."] = "{npc:3365}是製皮訓練師，在{object:172958}工作。",
	-- {npc:3365} Karolek · {zone:1411} Durotar
	["{npc:3365}: Camping 101, from Brakk's campfire in {zone:1411}"] = "{npc:3365}：野營入門，來自{zone:1411}布拉克的營火",

	-- Step 10: Snang
	-- {npc:2855} Snang · {object:172958} Valley of Honor
	["{npc:2855}, the tailoring trainer, is in the {object:172958}."] = "{npc:2855}是裁縫訓練師，在{object:172958}。",
	-- {npc:2855} Snang · {zone:1411} Durotar
	["{npc:2855}: Camping 101, from Brakk's campfire in {zone:1411}"] = "{npc:2855}：野營入門，來自{zone:1411}布拉克的營火",

	-- Step 11: Class trainer
	["Class trainer"] = "職業訓練師",
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits · {quest:5654} Hex of Weakness
	["Train while you are in the city: Druids and Paladins have no trainer here. Troll Priests: train with {npc:6018} in the {object:172961}, who takes {quest:5654}."] = "",

	-- Step 12: Sayoc
	-- {spell:197} Two-Handed Axes · {npc:11868} Sayoc · {object:172958} Valley of Honor
	["While you're here: learn {spell:197} from {npc:11868} ({object:172958}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 13: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "",

	-- Step 14: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "",

	-- Step 17: Whuut
	-- {npc:11046} Whuut · {npc:3348} Kor'geld
	["{npc:11046}, the alchemy trainer, stands next door to {npc:3348}."] = "{npc:11046}是煉金術訓練師，站在{npc:3348}隔壁。",
	-- {npc:11046} Whuut · {zone:1411} Durotar
	["{npc:11046}: Camping 101, from Brakk's campfire in {zone:1411}"] = "{npc:11046}：野營入門，來自{zone:1411}布拉克的營火",

	-- Step 18: Valley of Wisdom
	-- {npc:268684} Thra · {npc:268682} Migi · {object:172957} Valley of Wisdom
	-- plural, as words: Smooth Boulders = {item:277952} Smooth Boulder
	["{npc:268684} and {npc:268682} sit behind Grommash Hold in the {object:172957}; the Smooth Boulders lie around them."] = "",

	-- Step 19: Thrall
	-- {npc:4949} Thrall · {quest:98024} Journey to the Crossroads · {quest:93739} Exploring the Horde · {quest:95350} Welcome to Azeroth
	["{npc:4949} stands in Grommash Hold. He offers {quest:98024} and {quest:93739} once {quest:95350} is handed in."] = "",
	-- {npc:4949} Thrall
	["{npc:4949}, inside Grommash Hold"] = "{npc:4949}，在Grommash Hold裡",
	-- {npc:4949} Thrall · {zone:1413} Barrens
	["{npc:4949}: keep it, Thork at the Crossroads in the {zone:1413} guide"] = "{npc:4949}：保留此任務，{zone:1413}指南中十字路口的索克",
	-- {npc:4949} Thrall · {quest:93739} Exploring the Horde
	["{npc:4949}: {quest:93739}, a tour of the Horde's leaders"] = "{npc:4949}：{quest:93739}，拜訪部落各領袖",
	-- {npc:3230} Nazgrel
	["Speak with {npc:3230}, in Grommash Hold"] = "與Grommash Hold裡的{npc:3230}交談",
	-- {npc:3230} Nazgrel
	["Talk to {npc:3230}"] = "",
	-- {npc:10540} Vol'jin
	["Speak with {npc:10540}, in Grommash Hold"] = "與Grommash Hold裡的{npc:10540}交談",
	-- {npc:10540} Vol'jin
	["Talk to {npc:10540}"] = "",

	-- Step 20: Nazgrel
	-- {npc:3230} Nazgrel
	["{npc:3230}, in Grommash Hold"] = "",

	-- Step 21: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "",

	-- Step 22: Brill
	-- {area:159} Brill · {npc:1738} Deathguard Terrence · {npc:1518} Apothecary Johaan · {npc:246152} Shari Stilwell
	["{area:159} is a short walk north up the road from the zeppelin towers: {npc:1738} stands by the road into town, {npc:1518} in the apothecary's house on the west side of the square; Paladins: {npc:246152} trains you in town."] = "",
	-- {npc:1518} Apothecary Johaan
	["{npc:1518}, inside"] = "",
	-- {npc:246152} Shari Stilwell · {area:159} Brill
	["{npc:246152}, in {area:159}"] = "{npc:246152}，在{area:159}",

	-- Step 23: Hadric Harlson
	-- {npc:1495} Deathguard Linnea · {npc:267009} Hadric Harlson
	["Back down the road past the zeppelin towers and east to {npc:1495}'s camp: {npc:267009} stands beside her."] = "",

	-- Step 24: The Cult of the Damned
	-- {npc:267009} Hadric Harlson
	-- plural, as words: Dark Neophytes = {npc:267006} Dark Neophyte · Dark Enforcers = {npc:275437} Dark Enforcer · Necrotic Crystal Fragments = {item:275851} Necrotic Crystal Fragment
	["The cultists camp a short walk south-east of {npc:267009}. Dark Neophytes and Dark Enforcers drop the Necrotic Crystal Fragments; more fragments, black crystals, lie on the ground among the tents."] = "",

	-- Step 27: The Sepulcher
	-- {area:228} The Sepulcher · {npc:2226} Karos Razok
	["{area:228} is the Forsaken crypt-town in the middle of the forest. Everyone you need stands around the crypt entrance; {npc:2226}, the bat handler, is just east of it."] = "{area:228}是森林中央的被遺忘者墓穴城鎮。你需要找的人都站在墓穴入口周圍；蝙蝠管理員{npc:2226}就在入口東邊。",
	-- {npc:2226} Karos Razok · {npc:4556} Gordon Wendham · {zone:1458} Undercity
	["{npc:2226}: {npc:4556} in the {zone:1458}, at the end of this guide; no need to buy the flight"] = "{npc:2226}：{zone:1458}的{npc:4556}，在本指南的最後；不需要購買飛行路線",
	-- {npc:1952} High Executor Hadrec
	["{npc:1952}, below ground"] = "",

	-- Step 28: The Sepulcher
	-- {quest:264} Until Death Do Us Part · {object:24776} Yuriv's Tombstone
	["{quest:264} is handed in at {object:24776}, a grave a few steps south of the crypt entrance, not to a person."] = "{quest:264}要在{object:24776}交，那是墓穴入口南邊幾步遠的一座墳墓，不是交給某個人。",

	-- Step 29: Border Crossings
	-- {object:1627} Dalaran Crate
	-- plural, as words: Dalaran Apprentices = {npc:1867} Dalaran Apprentice
	["Follow the road south. The {object:1627} sits beside it, north of Pyrewood. Careful: Dalaran Apprentices (13) stand around the crate: pull them one at a time before you open it."] = "沿著道路向南走。{object:1627}在路旁，位於焚木村北邊。小心：達拉然學徒（13級）站在箱子周圍：打開之前一次拉一個。",

	-- Step 30: The Dead Field
	-- {area:228} The Sepulcher · {npc:1983} Nightlash · {area:240} The Dead Field
	["North of the {area:228}. {npc:1983} haunts the {area:240}: kill it, then walk across the field. Careful: {npc:1983} (14) rises once you have killed rot hide gnolls in the field: fight her with full health."] = "在{area:228}北邊。{npc:1983}在{area:240}出沒：殺了它，然後走過整片田地。小心：在田裡殺掉腐皮豺狼人後，{npc:1983}（14級）就會出現：滿血再跟她打。",

	-- Step 31: Malden's Orchard
	-- {area:238} Malden's Orchard
	["Follow the road north-east to the Yoricks' house at {area:238}."] = "沿著道路向東北前往{area:238}的尤瑞克家。",

	-- Step 32: Mottled Worgs
	-- plural, as words: Mottled Worgs = {npc:1766} Mottled Worg
	["Mottled Worgs"] = "雜斑座狼",
	-- plural, as words: Mottled Worgs = {npc:1766} Mottled Worg
	["Mottled Worgs prowl the hills around the house."] = "雜斑座狼在房子周圍的山丘徘徊。",

	-- Step 33: Escorting Erland
	-- {npc:1978} Deathstalker Erland · {npc:1950} Rane Yorick
	["{npc:1978} waits north-east of the house. Escort him back to {npc:1950}; worgs attack on the way."] = "{npc:1978}在房子東北方等候。護送他回到{npc:1950}那裡；途中會有座狼攻擊。",
	-- {npc:1978} Deathstalker Erland
	["{npc:1978}, inside"] = "",

	-- Step 36: The Sepulcher
	-- {npc:1938} Dalar Dawnweaver · {area:227} Valgan's Field
	["{npc:1938}: his books lie in the {area:227} farmhouse, on the walk north"] = "",
	-- {npc:1937} Apothecary Renferrel · {zone:1458} Undercity
	["{npc:1937}: Zinge in the {zone:1458}, on the way to the zeppelin at the end"] = "",
	-- {area:233} Ambermill
	["{area:233} comes later, down the lake shore"] = "{area:233}稍後沿著湖岸往下時前往",

	-- Step 37: Valgan's Field farmhouse
	-- {area:227} Valgan's Field
	["{area:227} farmhouse"] = "",
	-- {area:227} Valgan's Field · {object:1571} Dusty Spellbooks · {npc:1770} Moonrage Darkrunner
	["On the road north, the farmhouse at {area:227}: go upstairs, the {object:1571} lie on the floor in the back room. Looting them brings a {npc:1770}."] = "",
	-- {object:1571} Dusty Spellbooks
	["{object:1571}; upstairs"] = "",

	-- Step 38: Quinn Yorick
	["North again to the Yoricks' house."] = "再次向北前往尤瑞克家。",
	-- {npc:1951} Quinn Yorick
	["{npc:1951}, inside"] = "",

	-- Step 39: Vile Fin murlocs
	["Vile Fin murlocs"] = "邪鰭魚人",
	-- plural, as words: Vile Fin Shredders = {npc:1767} Vile Fin Shredder
	["Follow the lake shore south-east from the Yoricks' house: the Vile Fin Shredders and Tidehunters along it drop the murloc eyes."] = "從約里克家沿著湖岸向東南走：沿途的邪鰭切割者和邪鰭潮行者會掉落魚人眼睛。",

	-- Step 40: The Decrepit Ferry
	-- {object:1593} Corpse Laden Boat · {area:233} Ambermill
	["Follow the lake shore south from the murlocs: the {object:1593} lies at the ferry landing, on the way to {area:233}."] = "",

	-- Step 41: Ambermill
	-- {area:233} Ambermill · {npc:2540} Dalaran Serpent · {npc:2120} Archmage Ataeric
	["Keep south along the shore from the ferry to {area:233}. Protectors guard the outskirts and Mages the town; both drop pendants. Careful: each Mage (15) fights with a {npc:2540} (15) beside it: pull one Mage at a time from the outskirts. Stay out of the middle, where {npc:2120} (22) stands."] = "",

	-- Step 42: The Sepulcher
	-- {area:228} The Sepulcher
	["Back north-west up the road to the {area:228}."] = "沿著道路向西北回到{area:228}。",
	-- {npc:1937} Apothecary Renferrel
	["{npc:1937}: for Quinn, on the road north at the end"] = "{npc:1937}：為了奎恩，最後在北邊的路上",
	-- {npc:1938} Dalar Dawnweaver
	["{npc:1938}, just north of Allister"] = "",
	-- {npc:1499} Magistrate Sevren · {area:159} Brill
	["{npc:1499} in {area:159}, on the way to the zeppelin at the end"] = "",

	-- Step 43: The Ivar Patch
	-- {zone:1420} Tirisfal Glades · {area:238} Malden's Orchard · {quest:425} Ivar the Foul
	["Take the road north toward {zone:1420}: the Yoricks' house at {area:238} is on the way. {quest:425} lurks a short walk west of it."] = "沿道路向北朝{zone:1420}走：{area:238}的尤瑞克家就在路上。{quest:425}潛伏在房子西邊不遠處。",
	["Inside"] = "",

	-- Step 45: Magistrate Sevren
	-- {area:159} Brill · {npc:1499} Magistrate Sevren
	["{area:159} is a short walk north up the road from the zeppelin towers; {npc:1499} is in the town hall."] = "{area:159}從飛艇塔沿著道路往北走一小段就到；{npc:1499}在市政廳裡。",

	-- Step 47: The Undercity
	-- {object:1661} The Undercity · {area:153} Ruins of Lordaeron · {npc:2050} Raleigh Andrean · {npc:7683} Alessandro Luca · {npc:11044} Doctor Martin Felben · {npc:5204} Apothecary Zinge · {npc:2055} Master Apothecary Faranell
	["{object:1661} lies under the {area:153}, beside the zeppelin towers. {npc:2050} stands at the inn by the way down; {npc:7683} on the way down to the Apothecarium, where {npc:11044} and {npc:5204} stand beside {npc:2055}."] = "",
	-- {npc:4556} Gordon Wendham
	["{npc:4556}, the weapon merchant beside the bat handler"] = "{npc:4556}，蝙蝠管理員旁邊的武器商人",
	-- {npc:4551} Michael Garrett
	["{npc:4551}, the bat handler"] = "{npc:4551}，蝙蝠管理員",
	-- {npc:4551} Michael Garrett · {item:16210} Gordon's Crate · {area:228} The Sepulcher
	["{npc:4551}: keep {item:16210}, Podrig takes it on the next stop at the {area:228}, at 22"] = "{npc:4551}：保留{item:16210}，22級時在下一站{area:228}交給波崔格",
	-- {npc:11044} Doctor Martin Felben
	["{npc:11044}, in the Apothecarium"] = "{npc:11044}，在 Apothecarium",
	-- {npc:5204} Apothecary Zinge
	["{npc:5204}, in the Apothecarium"] = "",
	-- {npc:5204} Apothecary Zinge
	["{npc:5204}: Helbrim at the Crossroads, in the next guide"] = "",
	-- {npc:260093} Garen Largo · {area:1497} Undercity
	["{npc:260093}, the {area:1497}'s paladin trainer"] = "",

	-- Step 48: Brom Killian
	-- {npc:4598} Brom Killian · {zone:1458} Undercity
	["{npc:4598}, the mining trainer, works in the {zone:1458}."] = "{npc:4598}是採礦訓練師，在{zone:1458}工作。",
	-- {npc:4598} Brom Killian · {npc:265812} Eleanor Shackleton
	["{npc:4598}: Camping 101, from {npc:265812}'s campfire in Tirisfal"] = "{npc:4598}：野營入門，來自提里斯法{npc:265812}的營火",

	-- Step 49: Basil Frye
	-- {npc:4605} Basil Frye · {zone:1458} Undercity
	["{npc:4605}, the blacksmithing trainer, works in the {zone:1458}."] = "{npc:4605}是鍛造訓練師，在{zone:1458}工作。",
	-- {npc:4605} Basil Frye · {npc:265812} Eleanor Shackleton
	["{npc:4605}: Camping 101, from {npc:265812}'s campfire in Tirisfal"] = "{npc:4605}：野營入門，來自提里斯法{npc:265812}的營火",

	-- Step 50: Graham Van Talen
	-- {npc:4586} Graham Van Talen · {zone:1458} Undercity
	["{npc:4586}, the engineering trainer, works in the {zone:1458}."] = "{npc:4586}是工程學訓練師，在{zone:1458}工作。",
	-- {npc:4586} Graham Van Talen · {npc:265812} Eleanor Shackleton
	["{npc:4586}: Camping 101, from {npc:265812}'s campfire in Tirisfal"] = "{npc:4586}：野營入門，來自提里斯法{npc:265812}的營火",

	-- Step 51: Lady Sylvanas Windrunner
	-- {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter
	["{npc:10181} holds court in the {object:36126}."] = "",
	-- {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter · {quest:93739} Exploring the Horde
	["Speak with {npc:10181}, in the {object:36126}: {quest:93739}"] = "與{object:36126}的{npc:10181}交談：{quest:93739}",
	-- {npc:10181} Lady Sylvanas Windrunner
	["Talk to {npc:10181}"] = "",

	-- Step 52: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "搭飛艇前往{zone:1454}",

	-- Step 53: Orgrimmar
	-- {zone:1454} Orgrimmar · {object:172982} Valley of Strength
	["{zone:1454}'s {object:172982}"] = "",

	-- Step 54: Valley of Strength
	-- {npc:268701} Thatog · {object:172982} Valley of Strength
	["Walk in through the main gate. {npc:268701} stands in the {object:172982}."] = "從正門走進去。{npc:268701}站在{object:172982}。",

	-- Step 57: Neeru Fireblade
	-- {area:2437} Ragefire Chasm · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {npc:3216} Neeru Fireblade
	["For your {area:2437} run: the {object:172960} is the canyon under the {object:172982}; {npc:3216} stands at its far end, next to the {area:2437} portal."] = "為了你的{area:2437}之行：{object:172960}是{object:172982}下方的峽谷；{npc:3216}站在峽谷盡頭，{area:2437}傳送門旁邊。",

	-- Step 58: Ragefire Chasm
	-- {area:2437} Ragefire Chasm · {object:172960} Cleft of Shadow · {npc:3216} Neeru Fireblade · {npc:11520} Taragaman the Hungerer · {npc:11518} Jergosh the Invoker · {npc:4949} Thrall
	["{area:2437} is a dungeon for a group of five, about levels 13 to 18, and a full run takes 30 to 45 minutes. Its portal is in the {object:172960}, beside {npc:3216}.\nInside: past Oggleflint and his troggs, {npc:11520} waits in the lava cave and drops his heart. {npc:11518} and Bazzalan, further in, are for {npc:4949}'s Hidden Enemies, which this route leaves out."] = "{area:2437}是五人地城，約13到18級，完整打一次要30到45分鐘。傳送門在{object:172960}，{npc:3216}旁邊。\n裡面：經過歐格弗林特和他的穴居人後，{npc:11520}在熔岩洞穴裡等著，會掉落他的心臟。更深處的{npc:11518}和巴札蘭是{npc:4949}的「隱藏的敵人」任務目標，本路線略過該任務。",

	-- Step 59: Neeru Fireblade
	-- {npc:3216} Neeru Fireblade
	["Back out through the portal: {npc:3216} stands beside it."] = "從傳送門出來：{npc:3216}就站在旁邊。",

	-- Step 63: Sayoc
	-- {spell:197} Two-Handed Axes · {npc:11868} Sayoc · {object:172958} Valley of Honor
	["While you're here: learn {spell:197} from {npc:11868} ({object:172958}, 10 silver); two-handers level a Paladin fastest."] = "",

	-- Step 65: Zor Lonetree
	-- {npc:4047} Zor Lonetree · {npc:4049} Seereth Stonebreak
	["{npc:4047}: {npc:4049}, on the road into Stonetalon in the next guide"] = "",

	-- Step 66: Valley of Wisdom
	-- {npc:268684} Thra · {npc:268682} Migi · {object:172957} Valley of Wisdom · {area:379} Far Watch Post
	-- plural, as words: Smooth Boulders = {item:277952} Smooth Boulder
	["{npc:268684} and {npc:268682} sit behind Grommash Hold in the {object:172957}; the Smooth Boulders lie around them. The next guide walks from here to {area:379} and the Crossroads."] = "{npc:268684}和{npc:268682}坐在{object:172957}的Grommash Hold後面；光滑巨石就在他們周圍。下一份指南從這裡走到{area:379}和十字路口。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At the {area:2362}"] = "在{area:2362}",
	-- ["Cast {spell:18960}; {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "施放{spell:18960}；{npc:11802}在{area:2361}。神殿靈珠躺在{area:656}的湖底，幾分鐘內就會消失：拿到一個後直接游到西北岸的{area:2362}，在那裡使用它，然後與{npc:11799}交談。",
	-- ["Fly to {area:1638}: {npc:3033} trains you on {area:1639}. Skyborne: fly back to {zone:1454} for the zeppelin afterwards."] = "飛往{area:1638}：{npc:3033}在{area:1639}為你訓練。天裔精靈：之後飛回{zone:1454}搭飛艇。",
	-- ["Follow the lake shore south-east and swim out to {area:172}. Rot Hide gnolls cover the island; every type drops ichor. Stay out of {area:235} on its north side unless you go for the optional niche: the gnolls there are level 18-22."] = "沿著湖岸向東南走，游到{area:172}。島上滿是腐皮豺狼人；每一種都會掉落膿液。不要進入島北側的{area:235}，除非你要做可選的壁龕任務：那裡的豺狼人是18-22級。",
	-- ["Follow the road north out of Silverpine into {zone:1420} and east to the zeppelin towers outside the {area:153}. Take the zeppelin to {zone:1454}."] = "沿著道路向北離開銀松森林進入{zone:1420}，向東前往{area:153}外的飛艇塔。搭乘前往{zone:1454}的飛艇。",
	-- ["Follow the road north out of Silverpine into {zone:1420} and on to {area:159}: {npc:246152} trains Paladins there. The zeppelin towers are a short walk south down the road."] = "沿著道路向北離開銀松森林進入{zone:1420}，繼續前往{area:159}：{npc:246152}在那裡訓練聖騎士。飛艇塔沿著道路往南走一小段就到。",
	-- ["From the {area:380}, follow the road north-east to {area:1637} and walk in by the main gate. {npc:3310}, the wind rider master, stands on the tower in the {object:172982}."] = "從{area:380}沿著道路向東北前往{area:1637}，從正門走進去。雙足飛龍管理員{npc:3310}站在{object:172982}的塔上。",
	-- ["Hearth to the {area:228}"] = "用爐石回{area:228}",
	-- ["Into Silverpine"] = "進入銀松森林",
	-- ["Keep it: {npc:2216} in {area:272}, a later guide"] = "保留此任務：{area:272}的{npc:2216}，之後的指南",
	-- ["Moonrage Bloodhowlers"] = "月怒血嘯者",
	-- ["Mottled Worgs prowl the hills around the house. Then walk south along the lake shore: the Vile Fin Shredders and Tidehunters there drop the murloc eyes."] = "雜斑座狼在房子周圍的山丘徘徊。然後沿著湖岸向南走：那裡的邪鰭切割者和邪鰭潮行者會掉落魚人眼睛。",
	-- ["North again to the Yoricks' house. {quest:425} lurks a short walk west of it."] = "再次向北前往尤瑞克家。{quest:425}潛伏在房子西邊不遠處。",
	-- ["North of the {area:228}. Nightlash haunts the {area:240}: kill it, then walk across the field."] = "在{area:228}北邊。奈塔拉什在{area:240}出沒：殺了它，然後走過整片田地。",
	-- ["North-east of the refugees, the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "在難民的東北方，鴉爪苦工和鴉爪守護者在森林東南部的{quest:516}廢墟出沒。",
	-- ["Only if {npc:1938} gave you {quest:98298}: the Bloodhowlers prowl the woods south-west of {area:233}, east of Pyrewood; they drop the {item:280375}."] = "僅限{npc:1938}給了你{quest:98298}時：血嘯者在{area:233}西南方、焚木村東邊的樹林中徘徊；牠們會掉落{item:280375}。",
	-- ["Road to Silverpine"] = "前往銀松森林的道路",
	-- ["South-east down the road to {area:233}. Protectors guard the outskirts and Mages the town; both drop pendants. Wizards and Watchers patrol the roads around it. Stay out of the middle, where {npc:2120} stands."] = "沿著道路向東南前往{area:233}。達拉然保衛者守衛外圍，達拉然法師守著城鎮；兩者都會掉落墜飾。達拉然巫師和達拉然衛士在周圍的道路巡邏。不要進入中央，{npc:2120}站在那裡。",
	-- ["South-west of Ambermill, the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "安伯米爾西南方，森林東南部的{quest:516}廢墟中出沒著鴉爪苦工和鴉爪守護者。",
	-- ["Take the road north toward {area:85}: the Yoricks' house at {area:238} is on the way. {quest:425} lurks a short walk west of it."] = "沿道路向北朝{area:85}走：{area:238}的尤瑞克家就在路上。{quest:425}潛伏在房子西邊不遠處。",
	-- ["The Sickly and Haggard Refugees shamble along the road south of Pyrewood toward the {area:230}."] = "病怏怏的難民和憔悴的難民在焚木村南邊、通往{area:230}的道路上蹣跚而行。",
	-- ["The Vile Fin Lakestalkers and Oracles sit on the lake shore south of the {area:237}, east of the {area:228}."] = "邪鰭巡湖者和邪鰭智者在{area:237}南邊、{area:228}東邊的湖岸上。",
	-- ["The refugees"] = "難民",
	-- ["The zeppelin lands at the towers outside the {area:153}. Walk west along the road past the ruins and south into {zone:1421}; follow the road to the {area:228}."] = "飛艇停靠在{area:153}外的塔。沿著道路向西經過廢墟，再往南進入{zone:1421}；沿著道路前往{area:228}。",
	-- ["The zeppelin towers stand just outside {zone:1454}'s main gate. Take the zeppelin to {zone:1420} (the other one goes to {object:3202})."] = "飛艇塔就在{zone:1454}正門外。搭乘前往{zone:1420}的飛艇（另一艘前往{object:3202}）。",
	-- ["The {area:228}"] = "{area:228}",
	-- ["The {object:1593} lies at the ferry landing on the lake shore east of the {area:228}."] = "{object:1593}在{area:228}東邊湖岸的渡口。",
	-- ["The {object:177790} lies on the coast west of the {area:240}. It holds the {item:15882} for Trial of the Sea Lion."] = "{object:177790}在{area:240}西邊的海岸上。裡面有海獅試煉要的{item:15882}。",
	-- ["To {area:1637}"] = "前往{area:1637}",
	-- ["Worgs and murlocs"] = "座狼與魚人",
	-- ["Zeppelin to {zone:1420}"] = "搭飛艇前往{zone:1420}",
	-- ["Zeppelin tower"] = "飛艇塔",
	-- ["grind on {npc:1909} at {area:1338}, {zone:1421}"] = "在{zone:1421}的{area:1338}擊殺{npc:1909}練等",
	-- ["{area:1338} shore"] = "{area:1338}湖岸",
	-- ["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}，來自湖中的{object:177785}",
	-- ["{item:3317}: a rare drop from the gnolls"] = "{item:3317}：豺狼人的稀有掉落",
	-- ["{npc:11066}, the enchanting trainer, works in the Drag."] = "{npc:11066}是附魔訓練師，在the Drag工作。",
	-- ["{npc:11798} in {area:2361} flies druids there; then fly on to {zone:1454} for the zeppelin"] = "{area:2361}的{npc:11798}會載德魯伊飛到那裡；然後繼續飛往{zone:1454}搭飛艇",
	-- ["{npc:11799}, at the {area:2362}"] = "{npc:11799}，在{area:2362}",
	-- ["{npc:1938}: take it if he offers it; it may follow his {quest:98298} series, which the route does not run"] = "{npc:1938}：如果他提供就接受；它可能接在他的{quest:98298}系列之後，而本路線不做那個系列",
	-- ["{npc:2121}: {quest:516}, on the south loop"] = "{npc:2121}：{quest:516}，在南方路線",
	-- ["{npc:3365}, the leatherworking trainer, works in the {object:172958}."] = "{npc:3365}是製皮訓練師，在{object:172958}工作。",
	-- ["{npc:3404}, the herbalism trainer, keeps her shop in the Drag."] = "{npc:3404}是草藥學訓練師，她的店在the Drag。",
	-- ["{npc:4551}: keep {item:16210}, Podrig takes it on the ride through the {area:228} at 22"] = "{npc:4551}：保留{item:16210}，22級騎乘途經{area:228}時交給波崔格",
	-- ["{npc:6018} stands in the {object:172961} on the city's west side."] = "{npc:6018}站在城市西側的{object:172961}。",
	-- ["{npc:7088}, the skinning trainer, stands in the {object:172958}."] = "{npc:7088}是剝皮訓練師，站在{object:172958}。",
	-- ["{object:112888}, inside the keep"] = "{object:112888}，在城堡裡",
	-- ["{object:1599}, just east of the keep"] = "{object:1599}，就在城堡東邊",
	-- ["{quest:6127}: {area:384}, next guide"] = "{quest:6127}：{area:384}，下一份指南",
	-- ["{zone:1454} class quests"] = "{zone:1454}職業任務",
}
