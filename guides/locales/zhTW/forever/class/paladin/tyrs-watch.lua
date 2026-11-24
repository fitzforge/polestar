-- Chinese (traditional) (zhTW): the guide forever/class/paladin/tyrs-watch (forever/class/paladin/tyrs-watch.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:7328} Redemption
	["Tyr's Watch and {spell:7328} (Forsaken)"] = "Tyr's Watch與{spell:7328}（被遺忘者）",
	-- {spell:7328} Redemption
	["{spell:7328} to raise fallen allies, plus a weapon and a shield for a new Forsaken paladin."] = "用{spell:7328}復活倒下的盟友，另外還有給新的被遺忘者聖騎士的一把武器和一面盾牌。",

	-- Step 1: Aramis Hammerhand
	-- {npc:1569} Shadow Priest Sarvis · {item:282423} Consecrated Scroll · {quest:364} The Mindless Ones · {npc:244808} Aramis Hammerhand · {npc:259377} Injured Deathguard · {area:154} Deathknell · {spell:635} Holy Light
	["{npc:1569} gives you a {item:282423} after {quest:364}: read it, then bring it to {npc:244808} by the church. He asks you to heal five {npc:259377} lying around {area:154}. {spell:635} hurts a Forsaken paladin a little each time: watch your health."] = "完成{quest:364}後{npc:1569}給你一封{item:282423}：讀一下，然後帶給教堂旁的{npc:244808}。他要你治療躺在{area:154}各處的五名{npc:259377}。{spell:635}每次施放都會輕微傷害身為被遺忘者的聖騎士：注意自己的血量。",
	-- {npc:259377} Injured Deathguard · {spell:635} Holy Light
	["Heal 5 {npc:259377} with {spell:635}"] = "用{spell:635}治療5名{npc:259377}",

	-- Step 2: Coming to Terms
	-- {npc:244808} Aramis Hammerhand · {npc:246143} Frightened Paladin
	["At 4 {npc:244808} sends you after a {npc:246143} who fled into the hills west of the church, just south of the bat cave. Talk to her to offer aid: she turns on you, and you have to put her down (level 3, easy)."] = "4級時{npc:244808}讓你去追一名{npc:246143}，她逃進了教堂以西的山丘，就在蝙蝠洞南邊。與她交談提出幫助：她會突然翻臉攻擊你，你不得不將她擊殺（3級，簡單）。",
	-- {npc:246143} Frightened Paladin
	["Talk to the {npc:246143}, then defeat her"] = "與{npc:246143}交談，然後擊敗她",

	-- Step 3: Shari Stilwell
	-- {area:154} Deathknell · {area:159} Brill · {npc:246152} Shari Stilwell
	["Follow the road east out of {area:154} to {area:159}. {npc:246152}, the paladin trainer, stands in town; she trains you from here on."] = "沿道路向東出{area:154}前往{area:159}。聖騎士訓練師{npc:246152}就在鎮中；從現在起由她訓練你。",

	-- Step 4: A Second Home
	-- {npc:246152} Shari Stilwell · {area:159} Brill · {quest:91317} The Tarnished · {area:16881} Shadowvale
	["At 8 {npc:246152} in {area:159} sends you to the order's keep on the west coast. {quest:91317} in {area:16881} and the crypt under it hit hard at 8-9: come at 10 or later."] = "8級時{area:159}的{npc:246152}派你前往西海岸的騎士團城堡。{area:16881}的{quest:91317}及其下方的地穴在8-9級時很難打：10級或以後再來。",

	-- Step 5: Bandarion Keep
	-- {area:16602} Bandarion Keep · {area:156} Solliden Farmstead · {npc:246349} Breton Samuels · {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro · {quest:96896} A Righteous Cause · {npc:267009} Hadric Harlson · {area:159} Brill
	["{area:16602} stands on the bluffs north-west of the {area:156} (the road west starts near 29,46). {npc:246349} waits at the gate. {npc:246389}, the keep's trainer, and {npc:259190}, its stable master, stand at the forest's edge just south of him. They only have work for you from level 10 and after {quest:96896} from Leonid at the keep, the end of {npc:267009}'s chain that starts south-east of {area:159}; take their quests when you see them."] = "{area:16602}位於{area:156}西北的峭壁上（向西的路從29,46附近開始）。{npc:246349}在大門等你。城堡的訓練師{npc:246389}和獸欄管理員{npc:259190}站在他南邊森林的邊緣。他們要到10級後、且完成城堡裡列昂尼德給的{quest:96896}（{npc:267009}任務鏈的終點，起點在{area:159}東南）後才有工作給你；見到他們的任務就接。",

	-- Step 6: Murlocs at the Gates
	-- {area:16881} Shadowvale
	["The Vile Fin murlocs (level 9-11) lurk on the bluffs along the road east of the keep and in the camps around the lake to the south-west, on the way down to {area:16881}."] = "邪鰭魚人（9-11級）潛伏在要塞東邊道路沿線的崖頂上，以及西南邊湖泊周圍的營地中，就在往下前往{area:16881}的路上。",
	-- plural, as words: Vile Fin Attackers = {npc:250283} Vile Fin Attacker
	["Vile Fin Attackers x8"] = "邪鰭攻擊者 x8",
	-- plural, as words: Vile Fin Seers = {npc:250282} Vile Fin Seer
	["Vile Fin Seers x8"] = "邪鰭先知 x8",

	-- Step 7: Touring the Grounds
	-- {npc:246349} Breton Samuels · {npc:246389} Hilda the Breaker · {npc:246394} Ander Solliden · {npc:246393} Jorin Croge · {npc:246378} Danitha Morr
	["{npc:246349} gives you a weapon, then sends you round the keep to speak with four of its people: {npc:246389} just south of the gate, {npc:246394}, the lookout, who walks the road south-east of the keep, then {npc:246393} and {npc:246378} inside the keep. Pick the conversation option with each."] = "{npc:246349}給你一把武器，然後讓你在要塞裡轉一圈，和它的四個人說話：城門正南的{npc:246389}，在要塞東南路上走動的哨兵{npc:246394}，然後是要塞裡的{npc:246393}和{npc:246378}。每個人都選對話選項。",
	-- {npc:246349} Breton Samuels · {item:246164} Skullthumper · {item:246165} Driftwood Smasher
	["{npc:246349}: {item:246164} or {item:246165}"] = "{npc:246349}：{item:246164}或{item:246165}",

	-- Step 8: Danitha Morr
	-- {npc:246378} Danitha Morr · {npc:246393} Jorin Croge · {quest:91317} The Tarnished
	["{npc:246378} leads the order from inside the keep; {npc:246393} stands beside it. {quest:91317} need level 9."] = "{npc:246378}在要塞內領導騎士團；{npc:246393}站在要塞旁。{quest:91317}需要9級。",

	-- Step 9: Shadowvale
	-- {quest:91317} The Tarnished · {area:16881} Shadowvale · {area:16616} Whispering Forest · {npc:259431} Rudolph Gelhardt
	["{quest:91317} (level 8-9) hold the ruined village of {area:16881} in the {area:16616}, south-west of the keep. Commander {npc:259431} (level 10) stands on the upper floor of a house, with Drudges below him: clear the ground floor first."] = "{quest:91317}（8-9級）佔據著城堡西南{area:16616}中已成廢墟的{area:16881}村。指揮官{npc:259431}（10級）站在一所房子的二樓，樓下有苦工：先清完一樓。",
	-- plural, as words: Tarnished Drudges = {npc:259434} Tarnished Drudge
	["Tarnished Drudges x8"] = "晦暗苦工 x8",
	-- plural, as words: Tarnished Zealots = {npc:259433} Tarnished Zealot
	["Tarnished Zealots x6"] = "晦暗狂熱者 x6",

	-- Step 10: The crypt under Shadowvale
	-- {area:16881} Shadowvale
	["The crypt under {area:16881}"] = "{area:16881}下方的地穴",
	-- {item:246213} Sturdy Lumber · {npc:260396} Whispering Horror
	-- plural, as words: Lumber Piles = {object:554626} Lumber Pile
	["The cellar is under the village, not on the surface: the way down is inside a burned-out house, where the arrow points. Twelve Lumber Piles (stacked beams) lie in the cellar, each good for one {item:246213}. {npc:260396}, an elite (level 11-13), sits at the far end: leave it alone."] = "地窖在村子地下，不在地表：下去的入口在一座燒燬的房子裡，即箭頭所指處。十二堆木料堆（堆疊的橫樑）放在地窖中，每堆可拿一個{item:246213}。精英怪{npc:260396}（11-13級）守在最裡面：別招惹它。",
	-- plural, as words: Lumber Piles = {object:554626} Lumber Pile
	["Lumber Piles, in the cellar: the way down is here"] = "木料堆，在地窖裡：下去的入口在這裡",

	-- Step 11: Hilda the Breaker's bones
	-- {npc:246389} Hilda the Breaker
	["{npc:246389}'s bones"] = "{npc:246389}的骸骨",
	-- plural, as words: Shadowvale Lurchers = {npc:260428} Shadowvale Lurcher · Faintly Glowing Bones = {item:286259} Faintly Glowing Bone
	["The Shadowvale Lurchers and Mystics (level 8-10) in the crypt drop the Faintly Glowing Bones: about one in two from Lurchers, more from one kind of Mystic, less from the other."] = "地穴中的影谷蹣跚者和影谷秘法師（8-10級）掉落微光骸骨：蹣跚者大約每兩隻掉一個，一種秘法師掉得多一些，另一種少一些。",
	-- plural, as words: Faintly Glowing Bones = {item:286259} Faintly Glowing Bone
	["Faintly Glowing Bones x6"] = "微光骸骨x6",

	-- Step 12: Ephram Barbaro's crystal
	-- {npc:259190} Ephram Barbaro
	["{npc:259190}'s crystal"] = "{npc:259190}的水晶",
	-- {item:286269} Glowing Crystal Fragment
	["The {item:286269}, a green crystal, lies on the floor in the left-hand part of the crypt."] = "{item:286269}是一塊綠色水晶，就在地穴左半部分的地面上。",

	-- Step 13: Back to the keep
	["Back to the keep"] = "返回要塞",
	-- {npc:246378} Danitha Morr · {npc:259431} Rudolph Gelhardt
	["{npc:246378} hands you {npc:259431}'s head for Sylvanas: keep it in your bags, it is what you hand in."] = "{npc:246378}把{npc:259431}的頭顱交給你帶給希爾瓦娜斯：放在揹包裡，這就是你要上交的東西。",

	-- Step 14: Hilda the Breaker
	-- {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro
	["{npc:246389} and {npc:259190} wait at the forest's edge south of the gate."] = "{npc:246389}和{npc:259190}在大門南邊的森林邊緣等你。",

	-- Step 15: Ephram Barbaro
	-- {npc:259190} Ephram Barbaro · {npc:246389} Hilda the Breaker
	["{npc:259190} waits at the forest's edge south of the gate, a few steps west of {npc:246389}."] = "{npc:259190}在城門以南的森林邊緣等著，在{npc:246389}以西幾步遠。",

	-- Step 16: A Lesson in Divinity
	-- {npc:246378} Danitha Morr · {item:2589} Linen Cloth · {zone:1458} Undercity
	["{npc:246378} offers the first Lesson in Divinity at level 12. Bring 10 {item:2589} if you have it: the {zone:1458} asks for it next."] = "{npc:246378}在12級時提供第一個神性的教誨。如果你有10份{item:2589}就帶上：{zone:1458}接下來會要。",

	-- Step 17: The Undercity
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter · {npc:257648} Tanis Alderwood · {object:36078} Trade Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:10181} holds court in the {object:36126}; {npc:257648} begs in the {object:36078}."] = "從{area:159}向南走到{area:153}，再往下進入{zone:1458}。{npc:10181}在{object:36126}接見；{npc:257648}在{object:36078}乞討。",

	-- Step 18: Linen Cloth
	-- {npc:257648} Tanis Alderwood · {item:2589} Linen Cloth
	-- plural, as words: Scarlet Zealots = {npc:1537} Scarlet Zealot
	["{npc:257648} needs 10 {item:2589}. Humanoids drop it: the Scarlet Zealots and Friars of the glades about three kills in ten. The Undercity Auction House sells it too."] = "{npc:257648}需要10份{item:2589}。人型生物會掉落：林地裡的血色狂熱者和血色苦行修士大約每殺十隻掉三份。幽暗城的拍賣場也有販售。",
	-- {item:2589} Linen Cloth
	["{item:2589} x10"] = "{item:2589}×10",

	-- Step 20: The Symbol of Life
	-- {item:6866} Symbol of Life
	["The {item:6866}"] = "{item:6866}",
	-- {area:16602} Bandarion Keep · {npc:246378} Danitha Morr · {item:6866} Symbol of Life · {npc:257655} Deathguard Billmuth
	["Back to {area:16602}. {npc:246378} gives you the {item:6866}; {npc:257655} waits downstairs in the keep. If you lose the symbol, {npc:246378} gives you another."] = "回到{area:16602}。{npc:246378}會給你{item:6866}；{npc:257655}在要塞樓下等候。如果你弄丟了聖印，{npc:246378}會再給你一個。",
	-- {npc:257655} Deathguard Billmuth
	["{npc:257655}, downstairs"] = "{npc:257655}，在樓下",

	-- Step 21: Deathguard Falgan
	-- {area:812} Venomweb Vale · {item:6866} Symbol of Life
	-- plural, as words: Scarlet Crusaders = {npc:238286} Scarlet Crusader
	["{area:812} is at the far east end of the glades, a long walk. Falgan lies dead among the Scarlet Crusaders there: target his body and use the {item:6866}, then talk to him at once, as he does not stay alive long. If he is already up (another player), just talk to him; if he died again, raise him again."] = "{area:812}在林地最東端，要走很長一段路。Falgan死在那裡的血色十字軍之中：選中他的屍體使用{item:6866}，然後立刻與他交談，他活不了多久。如果他已經被複活（其他玩家乾的），直接交談即可；如果他又死了，就再復活一次。",

	-- Step 22: The Scarlet attack plans
	["The Scarlet attack plans"] = "血色十字軍的攻擊計畫",
	-- {area:812} Venomweb Vale
	-- plural, as words: Scarlet Zealots = {npc:1537} Scarlet Zealot
	["The Scarlet Zealots (level 8-9), Friars (9-10) and Tarnished around {area:812} carry the attack plans. They run for help at low health and respawn in five minutes."] = "{area:812}周圍的血色狂熱者（8-9級）、血色修士（9-10級）和鏽濁成員身上帶著進攻計劃。它們血量低時會逃跑呼救，五分鐘後重新出現。",

	-- Step 23: Redemption
	-- {area:16602} Bandarion Keep · {npc:246378} Danitha Morr · {spell:7328} Redemption
	["Back to {area:16602}, across the whole glades: Billmuth downstairs takes the plans, then {npc:246378}, back upstairs in the keep, teaches you {spell:7328}."] = "穿過整個林地回到{area:16602}：樓下的比爾穆收下計畫，然後回到要塞樓上的{npc:246378}會教你{spell:7328}。",
	-- {npc:246378} Danitha Morr · {spell:7328} Redemption
	["{npc:246378}, back upstairs: {spell:7328}"] = "{npc:246378}，回到樓上：{spell:7328}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Scarlet Crusaders camped around {area:812} carry the attack plans."] = "在{area:812}周圍紮營的{npc:239036}身上帶著攻擊計畫。",
	-- ["{area:16602} stands on the bluffs north-west of the {area:156}. {npc:246349} waits at the gate."] = "{area:16602}位於{area:156}西北方的崖頂上。{npc:246349}在大門等候。",
	-- ["{area:812} is at the far east end of the glades. Use the {item:6866} on {npc:257663}, then speak to him. If you lose the symbol, {npc:246378} gives you another."] = "{area:812}位於林地的最東端。對{npc:257663}使用{item:6866}，然後與他交談。如果你弄丟了符記，{npc:246378}會再給你一個。",
	-- ["{npc:246152}, who trains Paladins in {area:159}, sends you to the order's keep on the west coast."] = "在{area:159}訓練聖騎士的{npc:246152}會派你前往西海岸的騎士團要塞。",
	-- ["{object:181686}, in the root cellar"] = "{object:181686}，在地窖裡",
	-- ["{object:554626}, in the root cellar"] = "{object:554626}，在地窖裡",
	-- ["{quest:91317} hold the ruined village of {area:16881} in the {area:16616}, south-west of the keep. The {item:246213} is piled in the root cellar of one of its houses; Commander {npc:259431} walks among his Tarnished."] = "{quest:91317}佔據要塞西南方{area:16616}中的廢棄村莊{area:16881}。{item:246213}堆放在其中一間房子的地窖裡；{npc:259431}在他的晦暗者之間走動。",
}
