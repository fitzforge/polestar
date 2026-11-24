-- Chinese (traditional) (zhTW): the guide forever/collectibles/mounts/neutral/warlock-dreadsteed (forever/collectibles/mounts/neutral/warlock-dreadsteed.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Warlock Dreadsteed"] = "術士恐懼戰馬",
	["Your epic mount at 60, summoned anywhere: no epic horse to buy and no 1,000g Journeyman Riding needed."] = "60級的史詩坐騎，隨處可召喚：不必買史詩馬，也不需要1,000金的中級騎術。",

	-- Step 1: Mor'zul Bloodbringer (Stormwind)
	-- {npc:5520} Spackle Thornberry · {object:2164} Slaughtered Lamb · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5520}, the demon trainer in the {object:2164}, sends you to {quest:7562} in the {zone:1428}."] = "60級時，{object:2164}的惡魔訓練師{npc:5520}會派你去找{zone:1428}的{quest:7562}。",

	-- Step 2: Mor'zul Bloodbringer (Ironforge)
	-- {npc:6382} Jubahl Corpseseeker · {zone:1455} Ironforge · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:6382}, the demon trainer in {zone:1455}, sends you to {quest:7562} in the {zone:1428}."] = "60級時，{zone:1455}的惡魔訓練師{npc:6382}會派你去找{zone:1428}的{quest:7562}。",

	-- Step 3: Mor'zul Bloodbringer (Orgrimmar)
	-- {npc:5815} Kurgul · {object:172960} Cleft of Shadow · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5815}, the demon trainer in the {object:172960}, sends you to {quest:7562} in the {zone:1428}."] = "60級時，{object:172960}的惡魔訓練師{npc:5815}會派你去找{zone:1428}的{quest:7562}。",

	-- Step 4: Mor'zul Bloodbringer (Undercity)
	-- {npc:5753} Martha Strain · {object:36082} Magic Quarter · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5753}, the demon trainer in the {object:36082}, sends you to {quest:7562} in the {zone:1428}."] = "60級時，{object:36082}的惡魔訓練師{npc:5753}會派你去找{zone:1428}的{quest:7562}。",

	-- Step 5: Mor'zul Bloodbringer
	-- {quest:7562} Mor'zul Bloodbringer · {npc:14437} Gorzeeki Wildeyes · {area:255} Altar of Storms · {zone:1428} Burning Steppes · {area:254} Blackrock Mountain · {npc:14522} Ur'dan · {area:2057} Scholomance · {area:2577} Dire Maul
	["{quest:7562} and his goblin {npc:14437} camp on the hill across the road from the {area:255}, in the far north-west of the {zone:1428}, west of {area:254}. The chain is long: about 420 gold in {npc:14437}'s and {npc:14522}'s goods, a pile of crafted materials, the {area:2057} and {area:2577}. Start buying or gathering the materials of the next steps now."] = "{quest:7562}和他的哥布林{npc:14437}在{area:255}對面路邊的山丘上紮營，位於{zone:1428}最西北、{area:254}以西。任務鏈很長：{npc:14437}和{npc:14522}的商品約需420金，還有一堆製作材料、{area:2057}和{area:2577}。現在就開始購買或收集後續步驟的材料吧。",

	-- Step 6: Raging Beast's Blood
	-- {zone:1452} Winterspring · {area:2250} Owl Wing Thicket · {area:2242} Hidden Grove
	["Every owlbeast of {zone:1452} (level 53-58, none elite) drops the blood about one time in three: about ninety kills for thirty. {area:2250}, in the north-east, and the {area:2242}'s surroundings are packed with them, and they respawn in five and a half minutes."] = "{zone:1452}的所有梟獸（53-58級，均非精英）都有約三分之一機率掉落血液：收集30份約需擊殺90只。東北面的{area:2250}和{area:2242}周圍分佈密集，重生時間為5分半。",

	-- Step 7: Wildeyes
	-- {npc:14436} Mor'zul Bloodbringer · {item:18591} Case of Blood · {npc:14437} Gorzeeki Wildeyes · {quest:7623} Lord Banehollow · {area:1763} Jaedenar · {npc:14523} Ulathek
	-- plural, as words: Shadowy Potions = {item:18802} Shadowy Potion
	["Back to {npc:14436}: he gives you the {item:18591} for {npc:14437} beside him. Then {npc:14436} asks for the bell, the wheel and the candle, and {npc:14437} sends you to {quest:7623} in {area:1763}: buy three Shadowy Potions from him for that trip (6 gold each: one to walk in, one after {npc:14523}, and a spare in case one runs out) and bring 150 gold for the stardust."] = "回到{npc:14436}：他給你{item:18591}，讓你交給旁邊的{npc:14437}。然後{npc:14436}索要鈴、輪和蠟燭，{npc:14437}會派你去{area:1763}的{quest:7623}：為這趟行程向他買三瓶暗影藥水（每瓶6金：一瓶走進去，一瓶在{npc:14523}之後，再留一瓶備用以防一瓶失效），並帶上150金買星塵。",
	-- {item:18591} Case of Blood
	["he gives you the {item:18591}"] = "他會給你{item:18591}",
	-- {item:18802} Shadowy Potion · {npc:14437} Gorzeeki Wildeyes
	["{item:18802}, from {npc:14437}"] = "{item:18802}，向{npc:14437}購買",

	-- Step 8: The ritual pieces
	["The ritual pieces"] = "儀式物品",
	-- {npc:14437} Gorzeeki Wildeyes · {skill:171} Alchemy · {item:8925} Crystal Vial · {skill:333} Enchanting · {item:11370} Dark Iron Ore · {skill:186} Mining · {zone:1428} Burning Steppes · {area:1584} Blackrock Depths · {skill:393} Skinning · {npc:7043} Flamescale Wyrmkin
	-- plural, as words: Ghost Mushrooms = {item:8845} Ghost Mushroom · Large Brilliant Shards = {item:14344} Large Brilliant Shard · Dark Iron Deposits = {object:165658} Dark Iron Deposit · Black Dragonscales = {item:15416} Black Dragonscale
	["{npc:14437} wants 10 Elixirs of Shadow Power ({skill:171}: 3 Ghost Mushrooms and a {item:8925} each), 6 Large Brilliant Shards ({skill:333}: disenchant level 51+ blue items), 25 {item:11370} ({skill:186} 230: the Dark Iron Deposits of the {zone:1428} and {area:1584}) and 35 Black Dragonscales ({skill:393}: the black dragonkin of the {zone:1428}, a few percent a kill, best from the {npc:7043}). Make or gather what your professions allow and buy the rest at the Auction House; it can take a while to find 35 scales."] = "{npc:14437}要10瓶暗影之力藥劑（{skill:171}：每瓶3個幽靈菇和一個{item:8925}）、6塊大塊魔光碎片（{skill:333}：分解51級以上藍色物品）、25個{item:11370}（{skill:186}230：{zone:1428}和{area:1584}的黑鐵礦脈）以及35片黑龍鱗片（{skill:393}：{zone:1428}的黑龍人，每隻幾個百分點，最好來自{npc:7043}）。用你的專業能做的就做、能採的就採，其餘的拍賣行買；35片鱗片可能要收一陣子。",
	-- {item:9264} Elixir of Shadow Power
	["{item:9264}: the Auction House"] = "{item:9264}：拍賣行",
	-- {item:14344} Large Brilliant Shard
	["{item:14344}: the Auction House"] = "{item:14344}：拍賣行",

	-- Step 9: Arcanite
	-- {npc:14437} Gorzeeki Wildeyes · {item:18629} Black Lodestone · {item:12363} Arcane Crystal · {item:12359} Thorium Bar
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["Hand the three pieces to {npc:14437}. He then wants 3 Arcanite Bars for the {item:18629}: alchemists transmute them (an {item:12363} and a {item:12359} each, on a long cooldown); everyone else buys them."] = "把三件物品交給{npc:14437}。接著他要3根奧金錠來製作{item:18629}：鍊金術師可以轉化（每根需要一個{item:12363}和一個{item:12359}，冷卻時間很長）；其他人用買的。",
	-- {item:12360} Arcanite Bar
	["{item:12360}: the Auction House"] = "{item:12360}：拍賣行",

	-- Step 10: Lord Banehollow
	-- {area:1763} Jaedenar · {area:1997} Bloodvenom Post · {zone:1448} Felwood · {area:1770} Shadow Hold · {item:18802} Shadowy Potion · {spell:23179} Taint of Shadow · {quest:7623} Lord Banehollow
	["{area:1763} lies just south of {area:1997} in western {zone:1448}, west of the road; of its two caves, {area:1770} is the northern one, further up the hill. Drink a {item:18802} at its mouth: for 20 minutes the Shadow Council there treat you as one of their own ({spell:23179}). The oozes in the red pool and the succubus Rakaiah beyond them still attack: hug the wall past them. Go down past the second, red pool, up the ramp and across two bridges to {quest:7623}, a great winged dreadlord at the back. He talks to you only while the potion lasts."] = "{area:1763}就在{zone:1448}西部{area:1997}的正南、道路以西；它有兩個洞穴，{area:1770}是北邊那個，位置更靠山上。在洞口喝下{item:18802}：20分鐘內，那裡的暗影議會會把你當作自己人（{spell:23179}）。紅色水池裡的軟泥怪和更遠處的魅魔拉凱亞仍會攻擊：貼著牆繞過它們。經過第二個紅色水池往下，上坡道，過兩座橋，到後面的{quest:7623}，一個巨大的有翼恐懼魔王。藥水持續期間他才會和你說話。",

	-- Step 11: Ulathek the Traitor
	-- {npc:14523} Ulathek · {spell:23179} Taint of Shadow · {npc:9516} Lord Banehollow
	["{npc:14523} waits in a small side room up a bridge you passed on the way down. Speak to him and he and four guards attack (all level 57, none elite): let your voidwalker hold the guards and burn {npc:14523}, sacrificing it if you must. Or click off your {spell:23179} aura to start the fight, kill {npc:14523}, then drink another potion: the guards stop at once. Take his heart back to {npc:9516} with a potion active."] = "{npc:14523}在下去途中經過的一座橋上方的小側室裡等候。和他說話後，他和四名守衛會攻擊（都是57級，非精英）：讓你的虛空行者拉住守衛，集火{npc:14523}，必要時犧牲虛空行者。或者點掉{spell:23179}增益來開戰，殺掉{npc:14523}，再喝一瓶藥水：守衛會立刻停止攻擊。帶著藥水效果把他的心臟帶回{npc:9516}。",

	-- Step 12: Xorothian Stardust
	-- {npc:14522} Ur'dan · {quest:7623} Lord Banehollow · {item:18687} Xorothian Stardust · {item:18802} Shadowy Potion
	["{npc:14522}, beside {quest:7623}, sells the {item:18687} for 150 gold. He deals with you only while a {item:18802} is active."] = "{quest:7623}旁邊的{npc:14522}以150金幣出售{item:18687}。只有在{item:18802}生效時他才會和你交易。",
	-- {item:18687} Xorothian Stardust · {npc:14522} Ur'dan
	["{item:18687}, from {npc:14522}"] = "{item:18687}，向{npc:14522}購買",

	-- Step 13: Imp Delivery
	-- {npc:14437} Gorzeeki Wildeyes · {quest:7630} Arcanite · {item:18688} Imp in a Jar · {area:2057} Scholomance
	["Back to {npc:14437} with the stardust; with the {quest:7630} also done he gives you the {item:18688} for the {area:2057}. Put a group of five together now: a party, not a raid group."] = "帶著星塵返回{npc:14437}；{quest:7630}也完成後，他會給你{item:18688}，用於{area:2057}。現在就組好五人隊伍：要小隊，不要團隊。",
	-- {quest:7625} Xorothian Stardust · {npc:14522} Ur'dan
	["{quest:7625}, from {npc:14522}"] = "{quest:7625}，來自{npc:14522}",

	-- Step 14: The Scholomance
	-- {area:2057} Scholomance
	["The {area:2057}"] = "{area:2057}",
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:13704} Skeleton Key · {npc:10508} Ras Frostwhisper · {item:18688} Imp in a Jar · {npc:14500} J'eevee
	["The {area:2057} (level 58-60, a group of five) lies under {area:2298}, the island town in the south-east of the {zone:1422}: someone needs the {item:13704} or a rogue to open the door. Fight down to {npc:10508}'s room and use the {item:18688} at the alchemy lab tables to the right: {npc:14500} makes the parchment. You need not kill Ras, but it only counts at this lab and only in a party."] = "{area:2057}（58-60級，五人隊伍）位於{zone:1422}東南的島上城鎮{area:2298}下方：需要有人帶著{item:13704}，或讓盜賊開門。一路打下去到{npc:10508}的房間，在右側鍊金實驗臺上使用{item:18688}：{npc:14500}會製作羊皮紙。不必殺掉萊斯，但只有在這個實驗臺、且必須在小隊中才算數。",
	-- {item:18688} Imp in a Jar
	["Use the {item:18688} at the alchemy lab inside"] = "在裡面的鍊金實驗室使用{item:18688}",

	-- Step 15: Dreadsteed of Xoroth
	-- {npc:14437} Gorzeeki Wildeyes · {npc:14436} Mor'zul Bloodbringer · {item:18663} J'eevee's Jar · {item:18629} Black Lodestone · {item:18670} Xorothian Glyphs
	-- plural, as words: Soul Shards = {item:6265} Soul Shard
	["Back to {npc:14437}, then {npc:14436} hands you his instructions. Buy {item:18663} (150 gold), the {item:18629} (50) and the {item:18670} (50) from {npc:14437}; a warlock friend who owns them can bring theirs instead. Every other warlock who will recharge the nodes needs a Lodestone of their own. Carry 15 or more Soul Shards."] = "回到{npc:14437}，然後{npc:14436}會把他的指示交給你。從{npc:14437}處購買{item:18663}（150金）、{item:18629}（50金）和{item:18670}（50金）；擁有的術士朋友可以帶自己的來。其他每一位要為節點充能的術士都需要自備一塊磁石。帶上15個以上靈魂碎片。",
	-- {item:18663} J'eevee's Jar
	["{item:18663}, 150 gold"] = "{item:18663}，150金",
	-- {item:18629} Black Lodestone
	["{item:18629}, 50 gold"] = "{item:18629}，50金",
	-- {item:18670} Xorothian Glyphs
	["{item:18670}, 50 gold"] = "{item:18670}，50金",

	-- Step 16: Into Dire Maul West
	["Into Dire Maul West"] = "進入厄運之槌西區",
	-- {area:2577} Dire Maul · {zone:1444} Feralas · {item:18249} Crescent Key · {npc:11496} Immol'thar
	["{area:2577} stands in the ruins of central {zone:1444}: from the gate at the foot of the ruins, walk up through the outer courtyards to the west wing's door at the north end. That door and an inner door need the {item:18249} (it drops from Pusillin in Dire Maul East) or a rogue with 300 Lockpicking. Bring a party of five. Lower {npc:11496}'s shield by killing the guardians of the five pylons (two stand in his own room), then kill {npc:11496}: his dais is the summoning circle. Rest and rebuff before you start."] = "{area:2577}立在{zone:1444}中部的廢墟中：從廢墟腳下的城門進去，穿過外圍庭院，走到北端西翼的門前。那扇門和裡面的一扇門需要{item:18249}（由厄運之槌東區的普希林掉落），或一名開鎖300的盜賊。帶一支五人隊伍。殺掉五座能量塔的守衛（其中兩個就在他自己的房間裡）以削弱{npc:11496}的護盾，然後殺掉{npc:11496}：他的臺座就是召喚法陣。開始前先休息並補好增益。",
	-- {npc:11496} Immol'thar
	["{npc:11496}, inside the west wing"] = "{npc:11496}，西翼內",

	-- Step 17: The ritual
	["The ritual"] = "儀式",
	-- {item:18663} J'eevee's Jar · {npc:14500} J'eevee · {item:6265} Soul Shard · {item:18670} Xorothian Glyphs · {npc:14502} Xorothian Dreadsteed · {npc:14506} Lord Hel'nurath · {npc:14504} Dreadsteed Spirit
	-- plural, as words: Dread Guards = {npc:14483} Dread Guard
	["Stand on the dais and use {item:18663}: {npc:14500} sets out the Bell, the Wheel and the Candle. The Bell heals warlocks, the Wheel shields the party, the Candle burns the imps: ignore the imps and kill the Dread Guards (elite felguards, about ten, sometimes two at once); Banish or Enslave helps. Give one player each node to watch: when one sags, tilts and sounds, a warlock with a Lodestone recharges it, a 3-second cast that any hit breaks (a {item:6265} each), so keep attackers off them. If all three fail, the ritual ends and you start again; while one stands it survives even a wipe. After about six minutes nine symbols glow and a red vortex closes the circle: walk out and the remaining demons vanish at its edge. Rest, then use the {item:18670}. Kill the {npc:14502} (level 62, elite); at half health {npc:14506} joins, a hard hitter who knocks you back. Speak to the {npc:14504}: every warlock in the party who is on this quest can bind it."] = "站到臺座上使用{item:18663}：{npc:14500}會擺出鈴、輪和蠟燭。鈴會治療術士，輪會為隊伍提供護盾，蠟燭會灼燒小鬼：無視小鬼，殺掉恐懼守衛（惡魔衛士精英，約十個，有時一次兩個）；放逐或奴役有幫助。給每個節點派一名玩家盯守：當某個節點下垂、傾斜併發聲時，由帶著磁石的術士為其充能，3秒施法，任何攻擊都會打斷（每次消耗一個{item:6265}），所以要讓攻擊者遠離他們。如果三個全部失效，儀式結束，你得重新開始；只要還有一個立著，即使團滅也能撐住。約六分鐘後九個符號亮起，一個紅色漩渦閉合圓圈：走出去，剩下的惡魔會在其邊緣消失。休息一下，然後使用{item:18670}。殺掉{npc:14502}（62級精英）；血量過半時{npc:14506}加入，是個會把你擊退的硬手。與{npc:14504}交談：隊伍中每個接了此任務的術士都能繫結它。",
	-- {item:18663} J'eevee's Jar · {npc:11496} Immol'thar
	["{item:18663}, on {npc:11496}'s dais"] = "{item:18663}，在{npc:11496}的臺座上",
	-- {item:18670} Xorothian Glyphs
	["{item:18670}, once the circle is complete"] = "{item:18670}，圓圈完成後",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:14436}, then hand his {item:18591} to {npc:14437} beside him. {npc:14436} then asks for three ritual pieces and {npc:14437} sends you to {zone:1448}: buy two Shadowy Potions from {npc:14437} for that trip."] = "返回{npc:14436}，然後把他的{item:18591}交給他身旁的{npc:14437}。接著{npc:14436}要三件儀式物品，{npc:14437}則派你去{zone:1448}：為這趟行程向{npc:14437}買兩瓶暗影藥水。",
	-- ["Back to {npc:14437}, then {npc:14436} hands you his instructions for the ritual. Buy {item:18663}, the {item:18629} and the {item:18670} from {npc:14437}, and carry ten or more Soul Shards."] = "返回{npc:14437}，然後{npc:14436}會交給你儀式的說明。向{npc:14437}購買{item:18663}、{item:18629}和{item:18670}，並攜帶十個以上的靈魂碎片。",
	-- ["Gorzeeki wants 10 Elixirs of {spell:5896} ({skill:171}), 6 Large Brilliant Shards ({skill:333}), 25 {item:11370} ({skill:186}, in {area:1584} and the {zone:1427}) and 35 Black Dragonscales ({skill:393}, black dragonkin of the {zone:1428}). Make or gather what your professions allow; buy the rest at the Auction House."] = "戈瑟奇要10瓶{spell:5896}藥劑（{skill:171}）、6個大塊魔光碎片（{skill:333}）、25個{item:11370}（{skill:186}，在{area:1584}和{zone:1427}）和35個黑龍鱗片（{skill:393}，{zone:1428}的黑龍族）。能用你的專業製作或採集的就自己來；其餘在拍賣場購買。",
	-- ["The owlbeasts of {zone:1452} drop the blood, about one in three: the Ragged and Raging Owlbeasts west of and around {area:2255}, the Crazed, Moontouched and {spell:417141} ones in the east. While you hunt, start on the materials of the next step: the Auction House has them all."] = "{zone:1452}的梟獸會掉落血，機率約三分之一：{area:2255}西邊和周圍的蓬毛梟獸和狂怒的梟獸，東部的瘋狂的梟獸、月光梟獸和{spell:417141}梟獸。狩獵時，先開始準備下一步的材料：拍賣場都有。",
	-- ["The ritual in {area:2577}"] = "{area:2577}的儀式",
	-- ["The {area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}: you need its key or a rogue to open the door, and Rattlegore's {item:13873} to go deeper. Use the {item:18688} at the alchemy lab in {npc:10508}'s room; {npc:14500} makes the parchment. Bring a group."] = "{area:2057}位於{zone:1422}東南方的島嶼城鎮{area:2298}之下：你需要它的鑰匙或盜賊來開門，還需要血骨傀儡的{item:13873}才能深入。在{npc:10508}房間的鍊金實驗室使用{item:18688}；{npc:14500}會製作羊皮紙。找小隊一起去。",
	-- ["{area:1763} is in western {zone:1448}. Drink a {item:18802} before you go in: the Shadow Council cultists turn friendly for a while, the demons do not. {quest:7623} waits deep inside {area:1770}, the cave above {area:1763}, across a bridge in the great root chamber."] = "{area:1763}位於{zone:1448}西部。進去前喝一瓶{item:18802}：Shadow Council的教徒會暫時變得友善，惡魔則不會。{quest:7623}在{area:1763}上方的洞穴{area:1770}深處，穿過巨大樹根廳中的一座橋。",
	-- ["{area:2577} stands in the ruins of central {zone:1444}; the ritual circle is in its west wing, past {npc:11496}, and the door needs the {item:18249} or a rogue. Use {item:18663} to start; when the bell, the wheel or the candle fades, click it with the {item:18629} (a {item:6265} each). When the demons stop coming, use the {item:18670}, defeat the {npc:14502} and its dreadlord master, and speak to the {npc:14504}. Bring a group."] = "{area:2577}位於{zone:1444}中部的廢墟中；儀式法陣在西區，經過{npc:11496}之後，門需要{item:18249}或盜賊開啟。使用{item:18663}開始；當鈴鐺、輪子或蠟燭消退時，用{item:18629}點擊它（每次一個{item:6265}）。惡魔不再出現後，使用{item:18670}，擊敗{npc:14502}及其恐懼魔王主人，然後與{npc:14504}交談。找小隊一起去。",
	-- ["{npc:14437} wants 10 Elixirs of Shadow Power ({skill:171}), 6 Large Brilliant Shards ({skill:333}), 25 {item:11370} ({skill:186}, in {area:1584} and the {zone:1427}) and 35 Black Dragonscales ({skill:393}, black dragonkin of the {zone:1428}). Make or gather what your professions allow; buy the rest at the Auction House."] = "{npc:14437}要10瓶暗影之力藥劑（{skill:171}）、6個大塊魔光碎片（{skill:333}）、25個{item:11370}（{skill:186}，在{area:1584}和{zone:1427}）和35個黑龍鱗片（{skill:393}，{zone:1428}的黑龍族）。能用你的專業製作或採集的就自己來；其餘在拍賣場購買。",
	-- ["{npc:14504}: it binds itself to you"] = "{npc:14504}：它會與你綁定",
	-- ["{npc:14523} waits in a side chamber by a bridge on the way back up. Speak to him and he and his four guards attack; none are elite. Take his heart back to {npc:9516}, drinking another potion if the first wore off."] = "{npc:14523}在回程往上走時、一座橋旁的側室中等著。和他交談後，他和四名守衛會發動攻擊；都不是精英。把他的心臟帶回給{npc:9516}，如果第一瓶藥水效果消失了就再喝一瓶。",
	-- ["{quest:7562} and his goblin {npc:14437} camp at the {area:255}, in the north-west of the {zone:1428}, west of {area:254}. The chain is long, costs gold at {npc:14437}'s and ends in two dungeons."] = "{quest:7562}和他的哥布林{npc:14437}在{zone:1428}西北部、{area:254}西邊的{area:255}紮營。這條任務鏈很長，要在{npc:14437}那裡花金幣，最後在兩個地城結束。",
}
