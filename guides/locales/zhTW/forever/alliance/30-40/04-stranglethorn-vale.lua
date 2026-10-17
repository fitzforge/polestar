-- Chinese (traditional) (zhTW): the guide forever/alliance/30-40/04-stranglethorn-vale (forever/alliance/30-40/04-stranglethorn-vale.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Ironforge
	-- {area:150} Menethil Harbor · {area:1537} Ironforge
	["Fly from {area:150} to {area:1537} and train."] = "從{area:150}飛往{area:1537}並訓練。",

	-- Step 2: Druid training
	["Druid training"] = "德魯伊訓練",
	-- {area:1537} Ironforge · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind · {npc:5504} Sheldras Moontree
	["{area:1537} has no druid trainer: take the {area:2257} from {object:171524} to {zone:1453} and train with {npc:5504}."] = "{area:1537}沒有德魯伊訓練師：從{object:171524}搭乘{area:2257}前往{zone:1453}，向{npc:5504}學習。",

	-- Step 3: Darkshire
	-- {area:42} Darkshire · {npc:1573} Gryth Thurden · {area:1537} Ironforge · {object:32372} Great Forge · {npc:352} Dungar Longdrink · {zone:1453} Stormwind · {object:2096} Trade District
	["Fly to {area:42}: {npc:1573} in {area:1537}'s {object:32372}, or {npc:352} in {zone:1453}'s {object:2096}."] = "飛往{area:42}：{area:1537}{object:32372}的{npc:1573}，或{zone:1453}{object:2096}的{npc:352}。",

	-- Step 4: Nesingwary's Expedition
	-- {zone:1431} Duskwood · {area:99} Rebel Camp
	["From {zone:1431} take the road south into Stranglethorn; the hunters' tents stand just west of the road past the {area:99} turn-off."] = "從{zone:1431}沿道路向南進入荊棘谷；獵人的帳篷就在過了{area:99}岔路後的道路西邊。",
	-- {npc:715} Hemet Nesingwary · {zone:1441} Thousand Needles
	["{npc:715}, from {zone:1441}"] = "{npc:715}，來自{zone:1441}",

	-- Step 5: Young tigers and panthers
	["Young tigers and panthers"] = "小荊棘谷猛虎與小獵豹",
	["Both roam the grass around the camp and along the road north."] = "兩者都在營地周圍的草地和往北的道路沿線遊蕩。",

	-- Step 7: Stranglethorn Tigers
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["Stranglethorn Tigers"] = "荊棘谷猛虎",
	["The adult tigers prowl the hills just south and west of the camp."] = "成年猛虎在營地南邊和西邊不遠的丘陵徘徊。",

	-- Step 8: Ajeck Rouack
	-- {area:99} Rebel Camp
	["The elder tigers come later, on the way back from the {area:99}"] = "老年荊棘谷猛虎之後再打，在從{area:99}回來的路上",

	-- Step 9: Rebel Camp
	-- {npc:738} Private Thorsen
	["Take the road north; {npc:738} stands on it, the camp sits in the hills to the west."] = "沿道路向北；{npc:738}站在路上，營地在西邊的丘陵中。",
	-- {npc:469} Lieutenant Doren
	["{npc:469}, in the hut"] = "{npc:469}，在小屋裡",

	-- Step 10: Kurzen's Compound
	-- {area:99} Rebel Camp
	["The Kurzen rebels hold the camp east of the {area:99}; work its outer edge, where Jungle Fighters and Medicine Men stand, and loot the supply crates by the tents."] = "庫爾森叛軍佔據{area:99}東邊的營地；在外圍活動，那裡有庫爾森叢林戰士和庫爾森藥草師，並拾取帳篷旁的補給箱。",
	-- {item:2634} Venom Fern Extract · {object:263} Kurzen Supplies
	["{item:2634}, from a {object:263} crate"] = "{item:2634}，來自{object:263}箱子",

	-- Step 11: Bookie Herod
	["Herod's records lie in a hut on the compound's west side; his strongbox sits farther east, by the cave mouth."] = "書呆子赫羅德的檔案在營地西側的一間小屋裡；他的保險箱在更東邊的洞口旁。",

	-- Step 13: Panthers, raptors and elder tigers
	["Panthers, raptors and elder tigers"] = "黑豹、迅猛龍與老年猛虎",
	-- plural, as words: Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Back south past Nesingwary: Panthers and Stranglethorn Raptors run in the clearings west of the camp toward the coast; the elder tigers hold the hills south-west."] = "往南經過赫米特·奈辛瓦里：黑豹和荊棘谷迅猛龍在營地西邊通往海岸的空地上奔跑；老年荊棘谷猛虎佔據西南方的丘陵。",
	-- {item:4614} Pendant of Myzrael
	["Gluggle, a rare murloc on the coast west of camp, drops the {item:4614}: take it if you meet him"] = "戈魯格爾是營地西邊海岸上的稀有魚人，會掉落{item:4614}：遇到就拿",

	-- Step 15: Sin'Dall and the Lashtail raptors
	-- {npc:729} Sin'Dall
	["{npc:729} and the Lashtail raptors"] = "{npc:729}與鞭尾迅猛龍",
	-- {npc:729} Sin'Dall · {area:35} Booty Bay
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{npc:729}, the great tiger, lairs on the hilltop south-west of the camp; Lashtail Raptors run south of it, along the way to {area:35}."] = "巨虎{npc:729}的巢穴在營地西南方的山頂；鞭尾迅猛龍在它南邊、前往{area:35}的路上奔跑。",

	-- Step 16: Down to Booty Bay
	-- {area:35} Booty Bay
	["Down to {area:35}"] = "前往{area:35}",
	-- {object:3202} Grom'gol · {area:35} Booty Bay
	["Follow the main road south the length of the jungle, past the {object:3202} turn-off, to {area:35} on the southern cape."] = "沿主要道路向南穿過整片叢林，經過{object:3202}岔路，到達南端海角的{area:35}。",
	["Gyll, on the top floor by the docks"] = "蓋爾，在碼頭旁的頂樓",
	-- {npc:2832} Nixxrax Fillamug · {object:56910} The Salty Sailor Tavern
	["{npc:2832}, in the {object:56910}"] = "{npc:2832}，在{object:56910}",
	-- {npc:2495} Drizzlik
	["{npc:2495}, by the bank"] = "{npc:2495}，在銀行旁",
	-- {npc:773} Krazek
	["{npc:773}, in the tavern"] = "{npc:773}，在酒館裡",
	-- {npc:737} Kebok
	["{npc:737}, in the tavern"] = "{npc:737}，在酒館裡",

	-- Step 17: Crystalvein Mine
	-- {area:310} Crystalvein Mine
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["Walk back north; the {area:310} lies west of the road in the middle of the jungle. The Crystal Spine Basilisks there drop the shards."] = "往北走回去；{area:310}在叢林中部的道路西邊。那裡的晶背蜥蜴會掉落碎片。",

	-- Step 18: Bloodscalp trolls
	["Bloodscalp trolls"] = "血頂食人妖",
	["The Bloodscalp trolls hold the ruins on the coast west of Nesingwary's camp."] = "血頂食人妖佔據奈辛瓦里營地西邊海岸上的廢墟。",

	-- Step 19: Nesingwary's Expedition
	-- {quest:201} Investigate the Camp
	["{quest:201}: just look around the hunters' camp"] = "{quest:201}：只需在獵人營地四處看看",

	-- Step 20: Private Thorsen
	-- {area:99} Rebel Camp
	["Thorsen patrols the road north of camp, toward the {area:99}."] = "列兵索爾森在營地北邊、朝{area:99}方向的道路上巡邏。",

	-- Step 21: River crocolisks
	["River crocolisks"] = "淡水鱷",
	-- {area:99} Rebel Camp
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["River Crocolisks swim the river by the {area:99}."] = "淡水鱷在{area:99}旁的河中游動。",

	-- Step 23: Snapjaw Crocolisks
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks"] = "鉗嘴鱷魚",
	-- {area:35} Booty Bay
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks bask on the shore and islands along the coast north of {area:35}."] = "鉗嘴鱷魚在{area:35}北邊海岸和島嶼上曬太陽。",

	-- Step 24: Booty Bay
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs in the tavern"] = "{npc:2496}，在酒館樓上",

	-- Step 25: The haunted island
	["The haunted island"] = "鬧鬼的島",
	["Follow the west coast north; the haunted island lies off the shore west of Nesingwary's camp. Just reach it."] = "沿西海岸向北；鬧鬼的島在奈辛瓦里營地西邊的外海。只要到達那裡即可。",

	-- Step 26: Nesingwary's Expedition
	-- {npc:716} Barnil Stonepot · {item:2755} Green Hills of Stranglethorn
	["{npc:716} collects the {item:2755}: the pages drop from almost every humanoid in the jungle. Turn the pages into chapters as you go."] = "{npc:716}收集{item:2755}：叢林中幾乎每個人形生物都會掉落書頁。邊走邊把書頁整理成章節。",

	-- Step 28: Kurzen's Compound
	["Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave. Pick up Green Hills pages as they drop."] = "庫爾森精神醫師站在營地更深處；庫爾森特種兵潛行埋伏在營地周圍和洞穴中。掉落的荊棘谷的青山書頁都撿起來。",

	-- Step 29: The jungle ruins
	["The jungle ruins"] = "叢林廢墟",
	-- {area:37} Lake Nazferiti
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Loop through the troll ruins of the north and centre: each holds one stone tablet of the troll legends. Shadowmaw Panthers prowl stealthed in the jungle around them; the Venture Co. camp on {area:37} carries the Tumbled Crystals."] = "繞行北部和中部的食人妖廢墟：每處都有一塊記載食人妖傳說的石板。深喉獵豹潛行在周圍的叢林中；{area:37}的風險投資公司營地身上帶著打磨過的水晶。",
	-- {quest:207} Kurzen's Mystery
	["{quest:207}: four troll legends"] = "{quest:207}：四個食人妖傳說",

	-- Step 30: Rebel Camp
	-- {npc:770} Corporal Kaleb · {npc:773} Krazek · {area:35} Booty Bay
	["{npc:770}: for {npc:773} in {area:35}"] = "{npc:770}：給{area:35}的{npc:773}",

	-- Step 32: Skullsplitter trolls
	["Skullsplitter trolls"] = "劈顱食人妖",
	-- {object:3202} Grom'gol
	["The Skullsplitter trolls hold the ruins east of the road between Nesingwary and {object:3202}."] = "劈顱食人妖佔據奈辛瓦里與{object:3202}之間道路東邊的廢墟。",

	-- Step 34: Booty Bay
	-- {zone:1417} Arathi Highlands
	["The ore drops from Drywhisker kobolds in {zone:1417}"] = "礦石由{zone:1417}的枯鬚狗頭人掉落",

	-- Step 36: Baron Revilgaz
	-- {zone:1416} Alterac Mountains
	["For Archmage Ansirem in {zone:1416}"] = "給{zone:1416}的大法師安斯雷姆·魯因維沃爾",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:2832}, in the {object:56910}"] = "{npc:2832}，在{object:56910}",
}
