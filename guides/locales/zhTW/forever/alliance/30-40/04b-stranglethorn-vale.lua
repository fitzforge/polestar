-- Chinese (traditional) (zhTW): the guide forever/alliance/30-40/04b-stranglethorn-vale (forever/alliance/30-40/04b-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["For characters of 35 to 36, but several quests here are level 37-38: on purpose, for their experience. The water elementals are 36-37: pull them one at a time."] = "適合35到36級的角色，但這裡有幾個任務是37-38級：這是刻意安排的，為了它們的經驗值。水元素為36-37級：一次拉一隻。",

	-- Step 1: Collin Mauren
	-- {object:2164} Slaughtered Lamb
	["In the {object:2164}, if you still carry it"] = "在{object:2164}裡，如果你還帶著",

	-- Step 2: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "飛往{area:42}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "{zone:1453}飛行管理員",

	-- Step 3: Stranglethorn Vale
	-- {zone:1434} Stranglethorn Vale
	["Into {zone:1434}"] = "進入{zone:1434}",

	-- Step 4: Rebel Camp
	-- {zone:1431} Duskwood
	["From {zone:1431} take the road south; the camp sits in the hills west of the road."] = "從{zone:1431}沿路向南；營地在道路西邊的山丘裡。",
	-- {npc:770} Corporal Kaleb · {npc:773} Krazek · {area:35} Booty Bay
	["{npc:770}, if 30-40/04 didn't give it: for {npc:773} in {area:35}"] = "{npc:770}，如果30-40/04沒有接到：給{area:35}的{npc:773}",

	-- Step 5: Nesingwary's Expedition
	-- {npc:717} Ajeck Rouack
	["South along the road: the hunters' tents stand just west of it. {npc:717} and Hemet gave you these on the first loop: take them now only if you didn't."] = "沿道路向南：獵人的帳篷就在道路西邊。{npc:717}和赫米特在第一趟路線已給過你這些任務：只有當時沒接才現在接。",
	-- {npc:717} Ajeck Rouack · {npc:729} Sin'Dall
	["{npc:717}, if 30-40/04 didn't give it: {npc:729}, in the 40-50 Stranglethorn guide"] = "{npc:717}，如果30-40/04沒有接到：{npc:729}在40-50荊棘谷指南中",
	-- {npc:715} Hemet Nesingwary
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{npc:715}, if 30-40/04 didn't give it: the Lashtail Raptors, after the jungle ruins"] = "{npc:715}，如果30-40/04沒給這個任務：鞭尾迅猛龍，在叢林廢墟之後",

	-- Step 6: Bookie Herod
	-- {area:101} Kurzen's Compound
	["East to {area:101}: Herod's records lie in a hut on its west side."] = "向東前往{area:101}：赫洛德的帳本放在營地西側的一間小屋裡。",
	-- {object:287} Bookie Herod's Records
	["{object:287}, upstairs"] = "{object:287}，樓上",

	-- Step 7: Kurzen's Compound
	-- {npc:218230} Wendel Mathers · {spell:7964} Smoke Bomb · {npc:813} Colonel Kurzen
	-- plural, as words: Kurzen Commandos = {npc:938} Kurzen Commando
	["{npc:218230}, a cook, is caged at the compound's western edge: take his quest now and keep it, his cage key and the fighter's uniform come on the 40-50 Stranglethorn guide, when the Subchiefs and Elites are your level. Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave, and Herod's strongbox sits by the cave mouth. Pick up Green Hills pages as they drop.\nCareful: Kurzen Commandos are level 34-35, not elite, and often spawn stealthed; near death they use {spell:7964}. {npc:813}, an elite of 39-40, stands at the compound's north end: leave him be."] = "{npc:218230}是個廚師，被關在營地西緣的籠子裡：現在就接他的任務並保留著，他的籠子鑰匙和鬥士制服要等到40-50荊棘谷指南、副酋長和精英與你等級相當時再處理。縮頭術士站在營地深處；特種兵潛行在營地周圍和洞穴裡，赫洛德的保險箱就在洞口旁。綠丘書頁掉落時順手撿起。\n小心：庫爾森特種兵是34-35級，不是精英，常以潛行狀態出現；瀕死時會使用{spell:7964}。{npc:813}是39-40級精英，站在營地北端：別去惹他。",
	-- {npc:218230} Wendel Mathers
	["{npc:218230}, in his cage"] = "{npc:218230}，在他的籠子裡",
	-- {npc:941} Kurzen Headshrinker
	["{npc:941}, below ground"] = "{npc:941}，地下",
	-- {object:288} Bookie Herod's Strongbox
	["{object:288}, below ground"] = "{object:288}，地下",

	-- Step 8: Lake Nazferiti
	-- {area:37} Lake Nazferiti
	-- plural, as words: Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal · Venture Co. Agents = {npc:260429} Venture Co. Agent · Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["South from the compound to {area:37}: the Venture Co. Geologists in the camps on its shore carry the Tumbled Crystals. Careful: Venture Co. Agents (39) walk among them: take the Geologists on the camps' edges, one at a time. Shadowmaw Panthers (37-38) prowl stealthed in the jungle south and east of the lake: keep to the shore camps."] = "從營地向南前往{area:37}：湖岸營地中的風險投資公司地質學家身上帶著打磨過的水晶。小心：風險投資公司特務（39級）在他們之間走動：從營地邊緣一次拉一個地質學家。深喉獵豹（37-38級）潛行在湖泊南邊和東邊的叢林中：待在湖岸營地就好。",

	-- Step 9: The jungle ruins
	["The jungle ruins"] = "叢林廢墟",
	["West across the jungle to the troll ruins: each holds one stone tablet of the troll legends, the first two in the ruins south-west of Nesingwary's camp, the last two on the hill in the north-west.\nCareful: the Saltscale murlocs on the shore near the second tablet are elite (35-37): swim to the tablet from the water and keep clear of them."] = "向西穿過叢林前往食人妖廢墟：每處都有一塊記載食人妖傳說的石板，前兩塊在奈辛瓦里營地西南方的廢墟中，後兩塊在西北方的山丘上。\n小心：第二塊石板附近岸邊的鹽鱗魚人是精英（35-37級）：從水中游向石板，避開牠們。",
	-- {item:2006} The Second Troll Legend · {object:58} Gri'lek the Wanderer
	["{item:2006}: {object:58}; underwater"] = "{item:2006}：{object:58}；水下",

	-- Step 10: Water Elementals
	-- plural, as words: Lesser Water Elementals = {npc:691} Lesser Water Elemental
	["The haunted island lies just off the shore west of the second tablet: the Lesser Water Elementals rise from the water around it."] = "鬧鬼的小島就在第二塊石板西邊的岸外不遠處：次級水元素從小島周圍的水中冒出。",

	-- Step 11: The Ruins of Zul'Kunda
	-- {area:102} Ruins of Zul'Kunda
	["The {area:102}"] = "{area:102}",
	-- {npc:268992} Zimmix Sputterspark · {item:277957} Primitive Key
	-- plural, as words: Stolen Shipments = {item:277953} Stolen Shipment · Bloodscalp Berserkers = {npc:597} Bloodscalp Berserker
	["North along the coast to the ruins on the hill: the last two tablets lie there. {npc:268992}, a goblin, is caged beside the third tablet: any Bloodscalp can drop his {item:277957}, then lead him out of the ruins. The Stolen Shipments lie at the ruins' east edge. Pick up Green Hills pages as they drop.\nCareful: the Bloodscalp Berserkers, Headhunters and Witch Doctors (36-37) hold the ruins' core: pull them one at a time."] = "沿海岸向北前往山丘上的廢墟：最後兩塊石板就在那裡。哥布林{npc:268992}被關在第三塊石板旁的籠子裡：任何血頂食人妖都可能掉落他的{item:277957}，之後帶他走出廢墟。遭竊的貨物在廢墟東緣。綠丘書頁掉落時順手撿起。\n小心：血頂狂戰士、獵頭者和巫醫（36-37級）盤踞廢墟中心：一次拉一隻。",
	-- {npc:268992} Zimmix Sputterspark
	["{npc:268992}, in his cage beside the third tablet"] = "{npc:268992}，在第三塊石板旁的籠子裡",
	-- {item:277957} Primitive Key
	["{item:277957}, from the Bloodscalp trolls"] = "{item:277957}，血頂食人妖掉落",
	-- {npc:4631} Wharfmaster Lozgil · {area:35} Booty Bay
	["For {npc:4631} in {area:35}, at the end of this loop"] = "給{area:35}的{npc:4631}，在這趟路線的終點",

	-- Step 12: The Lashtail raptors
	["The Lashtail raptors"] = "鞭尾迅猛龍",
	-- {npc:729} Sin'Dall
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["East from the ruins to the hilltop south-west of Nesingwary's camp: the Lashtail Raptors run in the jungle around it. Leave {npc:729}, the great tiger (37) on the hilltop, to the 40-50 Stranglethorn guide: you're about 35 here. Then on to the hunters' tents."] = "從廢墟向東前往奈辛瓦里營地西南方的山頂：鞭尾迅猛龍在周圍的叢林中奔跑。山頂上的巨虎{npc:729}（37級）留給40-50荊棘谷指南：你這時大約35級。然後前往獵人的帳篷。",

	-- Step 13: Nesingwary's Expedition
	-- {npc:715} Hemet Nesingwary
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["{npc:715}: the Jungle Stalkers come in 40-50"] = "{npc:715}：叢林捕獵者在40-50再處理",

	-- Step 14: Rebel Camp
	-- {area:99} Rebel Camp
	["North-east up the road to the {area:99}, then back south through the jungle."] = "沿道路向東北前往{area:99}，然後穿過叢林往南回來。",
	-- {npc:733} Sergeant Yohwa
	["{npc:733}: the Commandos and Headshrinkers fell in the compound"] = "{npc:733}：在營地裡擊殺突擊隊員和縮顱者",
	-- plural, as words: Skullsplitter Witch Doctors = {npc:670} Skullsplitter Witch Doctor
	["keep it: the Skullsplitter Witch Doctors (41-42) wait for the 40-50 Stranglethorn guide"] = "保留著：劈顱巫醫（41-42級）留給40-50荊棘谷指南",

	-- Step 15: Snapjaw Crocolisks
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks"] = "鉗嘴鱷魚",
	-- {area:35} Booty Bay
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks bask along the river in the middle of the jungle, on the way south to {area:35}."] = "鉗嘴鱷魚在叢林中央的河邊曬太陽，就在往南前往{area:35}的路上。",

	-- Step 16: Booty Bay
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "{npc:2495}，室內",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs in the tavern"] = "{npc:2496}，在酒館樓上",
	-- {zone:1416} Alterac Mountains
	["For Archmage Ansirem in {zone:1416}"] = "給{zone:1416}的大法師安斯雷姆·魯因維沃爾",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}，樓上",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "{npc:773}，樓上",
	-- {npc:773} Krazek · {item:4278} Lesser Bloodstone Ore · {zone:1417} Arathi Highlands · {skill:186} Mining
	-- plural, as words: Lesser Bloodstone Deposits = {object:2653} Lesser Bloodstone Deposit
	["{npc:773}, upstairs: this optional quest needs four {item:4278}. Mine Lesser Bloodstone Deposits in {zone:1417} with {skill:186} 75, or buy the ore at the Auction House or ask a miner friend. The kobolds do not drop it; skip this quest if you cannot get the ore."] = "{npc:773}在樓上：這個可選任務需要四塊{item:4278}。在{zone:1417}用{skill:186} 75開採次級血石礦脈，或在拍賣場購買礦石，或請會採礦的朋友幫忙。狗頭人不會掉落它；拿不到礦石就跳過這個任務。",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}，室內",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "“海狼”麥金利，在頂層",
	-- {npc:4631} Wharfmaster Lozgil
	["{npc:4631}, on the docks"] = "{npc:4631}，在碼頭上",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["East to the {area:99}, on the way back to Nesingwary's camp."] = "向東前往{area:99}，順路返回奈辛瓦里營地。",
	-- ["For characters of 35 to 36, but several quests here are level 37-41: on purpose, for their experience. {quest:205}'s Skullsplitter trolls are 39-42, so pull them one at a time."] = "適合35到36級的角色，但這裡有幾個任務是37-41級：這是刻意安排的，為了它們的經驗值。{quest:205}的劈顱食人妖為39-42級，所以一次拉一隻。",
	-- ["Loop through the troll ruins of the north and centre: each holds one stone tablet of the troll legends. Shadowmaw Panthers prowl stealthed in the jungle around them; the Venture Co. camp on {area:37} carries the Tumbled Crystals."] = "繞行北部和中部的食人妖廢墟：每處都有一塊記載食人妖傳說的石板。深喉獵豹潛行在周圍的叢林中；{area:37}的風險投資公司營地身上帶著打磨過的水晶。",
	-- ["North along the coast to the ruins on the hill: the last two tablets lie there. Pick up Green Hills pages as they drop."] = "沿著海岸向北前往山丘上的廢墟：最後兩塊石板就在那裡。綠色山丘的書頁掉落時記得撿起來。",
	-- ["Skullsplitter trolls"] = "劈顱食人妖",
	-- ["South from the compound to {area:37}: the Venture Co. Geologists in the camps on its shore carry the Tumbled Crystals, and the Shadowmaw Panthers prowl stealthed in the jungle south and east of it."] = "從營地向南前往{area:37}：湖岸營地中的風險投資公司地質學家身上帶著打磨過的水晶，深喉獵豹則潛行在湖泊南邊和東邊的叢林中。",
	-- ["The Skullsplitter trolls hold the ruins east of the road between Nesingwary and {object:3202}."] = "劈顱食人妖佔據奈辛瓦里與{object:3202}之間道路東邊的廢墟。",
	-- ["West across the jungle to the troll ruins: each holds one stone tablet of the troll legends, the first two in the ruins south-west of Nesingwary's camp, the last two on the hill in the north-west."] = "向西穿過叢林前往食人妖廢墟：每處都有一塊記載食人妖傳說的石板，前兩塊在奈辛瓦里營地西南方的廢墟中，後兩塊在西北方的山丘上。",
	-- ["{npc:718}: the Shadowmaw Panthers prowl around {area:37}, after {area:101}"] = "{npc:718}：深喉獵豹在{area:37}周圍徘徊，先去{area:101}之後再來",
	-- ["{npc:770}: for {npc:773} in {area:35}"] = "{npc:770}：給{area:35}的{npc:773}",
}
