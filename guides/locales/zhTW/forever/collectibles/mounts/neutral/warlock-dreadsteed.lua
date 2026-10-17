-- Chinese (traditional) (zhTW): the guide forever/collectibles/mounts/neutral/warlock-dreadsteed (forever/collectibles/mounts/neutral/warlock-dreadsteed.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Warlock Dreadsteed"] = "術士恐懼戰馬",
	["Your epic mount at 60: summoned anywhere, with no gold spent on an epic horse."] = "60級的史詩坐騎：隨處可召喚，不必花金幣買史詩馬。",

	-- Step 1: Mor'zul Bloodbringer (Stormwind)
	-- {npc:5520} Spackle Thornberry · {object:2164} Slaughtered Lamb · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5520} in the {object:2164} sends you to {quest:7562} in the {zone:1428}."] = "60級時，{object:2164}的{npc:5520}會派你去找{zone:1428}的{quest:7562}。",

	-- Step 2: Mor'zul Bloodbringer (Ironforge)
	-- {npc:6382} Jubahl Corpseseeker · {zone:1455} Ironforge · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:6382} in {zone:1455} sends you to {quest:7562} in the {zone:1428}."] = "60級時，{zone:1455}的{npc:6382}會派你去找{zone:1428}的{quest:7562}。",

	-- Step 3: Mor'zul Bloodbringer (Orgrimmar)
	-- {npc:5815} Kurgul · {object:172960} Cleft of Shadow · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5815} in the {object:172960} sends you to {quest:7562} in the {zone:1428}."] = "60級時，{object:172960}的{npc:5815}會派你去找{zone:1428}的{quest:7562}。",

	-- Step 4: Mor'zul Bloodbringer (Undercity)
	-- {npc:5753} Martha Strain · {object:36082} Magic Quarter · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5753} in the {object:36082} sends you to {quest:7562} in the {zone:1428}."] = "60級時，{object:36082}的{npc:5753}會派你去找{zone:1428}的{quest:7562}。",

	-- Step 5: Mor'zul Bloodbringer
	-- {quest:7562} Mor'zul Bloodbringer · {npc:14437} Gorzeeki Wildeyes · {area:255} Altar of Storms · {zone:1428} Burning Steppes · {area:254} Blackrock Mountain
	["{quest:7562} and his goblin {npc:14437} camp at the {area:255}, in the north-west of the {zone:1428}, west of {area:254}. The chain is long, costs gold at {npc:14437}'s and ends in two dungeons."] = "{quest:7562}和他的哥布林{npc:14437}在{zone:1428}西北部、{area:254}西邊的{area:255}紮營。這條任務鏈很長，要在{npc:14437}那裡花金幣，最後在兩個地城結束。",

	-- Step 6: Raging Beast's Blood
	-- {zone:1452} Winterspring · {area:2255} Everlook · {spell:417141} Berserk
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["The owlbeasts of {zone:1452} drop the blood, about one in three: the Ragged and Raging Owlbeasts west of and around {area:2255}, the Crazed, Moontouched and {spell:417141} ones in the east. While you hunt, start on the materials of the next step: the Auction House has them all."] = "{zone:1452}的梟獸會掉落血，機率約三分之一：{area:2255}西邊和周圍的蓬毛梟獸和狂怒的梟獸，東部的瘋狂的梟獸、月光梟獸和{spell:417141}梟獸。狩獵時，先開始準備下一步的材料：拍賣場都有。",

	-- Step 7: Wildeyes
	-- {npc:14436} Mor'zul Bloodbringer · {item:18591} Case of Blood · {npc:14437} Gorzeeki Wildeyes · {zone:1448} Felwood
	-- plural, as words: Shadowy Potions = {item:18802} Shadowy Potion
	["Back to {npc:14436}, then hand his {item:18591} to {npc:14437} beside him. {npc:14436} then asks for three ritual pieces and {npc:14437} sends you to {zone:1448}: buy two Shadowy Potions from {npc:14437} for that trip."] = "返回{npc:14436}，然後把他的{item:18591}交給他身旁的{npc:14437}。接著{npc:14436}要三件儀式物品，{npc:14437}則派你去{zone:1448}：為這趟行程向{npc:14437}買兩瓶暗影藥水。",
	-- {item:18591} Case of Blood
	["he gives you the {item:18591}"] = "他會給你{item:18591}",
	-- {item:18802} Shadowy Potion · {npc:14437} Gorzeeki Wildeyes
	["{item:18802}, from {npc:14437}"] = "{item:18802}，向{npc:14437}購買",

	-- Step 8: The ritual pieces
	["The ritual pieces"] = "儀式物品",
	-- {npc:14437} Gorzeeki Wildeyes · {skill:171} Alchemy · {skill:333} Enchanting · {item:11370} Dark Iron Ore · {skill:186} Mining · {area:1584} Blackrock Depths · {zone:1427} Searing Gorge · {skill:393} Skinning · {zone:1428} Burning Steppes
	-- plural, as words: Large Brilliant Shards = {item:14344} Large Brilliant Shard · Black Dragonscales = {item:15416} Black Dragonscale
	["{npc:14437} wants 10 Elixirs of Shadow Power ({skill:171}), 6 Large Brilliant Shards ({skill:333}), 25 {item:11370} ({skill:186}, in {area:1584} and the {zone:1427}) and 35 Black Dragonscales ({skill:393}, black dragonkin of the {zone:1428}). Make or gather what your professions allow; buy the rest at the Auction House."] = "{npc:14437}要10瓶暗影之力藥劑（{skill:171}）、6個大塊魔光碎片（{skill:333}）、25個{item:11370}（{skill:186}，在{area:1584}和{zone:1427}）和35個黑龍鱗片（{skill:393}，{zone:1428}的黑龍族）。能用你的專業製作或採集的就自己來；其餘在拍賣場購買。",

	-- Step 9: Arcanite
	-- {npc:14437} Gorzeeki Wildeyes
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["Hand the three pieces to {npc:14437}. He then wants 3 Arcanite Bars: alchemists transmute them, everyone else buys them at the Auction House."] = "把三件物品交給{npc:14437}。接著他要3根奧金錠：鍊金術師可以轉化，其他人在拍賣場購買。",

	-- Step 10: Lord Banehollow
	-- {area:1763} Jaedenar · {zone:1448} Felwood · {item:18802} Shadowy Potion · {quest:7623} Lord Banehollow · {area:1770} Shadow Hold
	["{area:1763} is in western {zone:1448}. Drink a {item:18802} before you go in: the Shadow Council cultists turn friendly for a while, the demons do not. {quest:7623} waits deep inside {area:1770}, the cave above {area:1763}, across a bridge in the great root chamber."] = "{area:1763}位於{zone:1448}西部。進去前喝一瓶{item:18802}：Shadow Council的教徒會暫時變得友善，惡魔則不會。{quest:7623}在{area:1763}上方的洞穴{area:1770}深處，穿過巨大樹根廳中的一座橋。",

	-- Step 11: Ulathek the Traitor
	-- {npc:14523} Ulathek · {npc:9516} Lord Banehollow
	["{npc:14523} waits in a side chamber by a bridge on the way back up. Speak to him and he and his four guards attack; none are elite. Take his heart back to {npc:9516}, drinking another potion if the first wore off."] = "{npc:14523}在回程往上走時、一座橋旁的側室中等著。和他交談後，他和四名守衛會發動攻擊；都不是精英。把他的心臟帶回給{npc:9516}，如果第一瓶藥水效果消失了就再喝一瓶。",

	-- Step 12: Xorothian Stardust
	-- {npc:14522} Ur'dan · {quest:7623} Lord Banehollow · {item:18687} Xorothian Stardust · {item:18802} Shadowy Potion
	["{npc:14522}, beside {quest:7623}, sells the {item:18687}; he only deals with you while a {item:18802} is active. Bring plenty of gold."] = "{quest:7623}旁邊的{npc:14522}出售{item:18687}；只有在{item:18802}生效時他才會和你交易。多帶點金幣。",
	-- {item:18687} Xorothian Stardust · {npc:14522} Ur'dan
	["{item:18687}, from {npc:14522}"] = "{item:18687}，向{npc:14522}購買",

	-- Step 13: Imp Delivery
	-- {npc:14437} Gorzeeki Wildeyes · {item:18688} Imp in a Jar · {area:2057} Scholomance
	["Back to {npc:14437} with the stardust. He gives you the {item:18688} for the {area:2057}."] = "帶著星塵返回{npc:14437}。他會給你{item:18688}，用於{area:2057}。",

	-- Step 14: The Scholomance
	-- {area:2057} Scholomance
	["The {area:2057}"] = "{area:2057}",
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:13873} Viewing Room Key · {item:18688} Imp in a Jar · {npc:10508} Ras Frostwhisper · {npc:14500} J'eevee
	["The {area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}: you need its key or a rogue to open the door, and Rattlegore's {item:13873} to go deeper. Use the {item:18688} at the alchemy lab in {npc:10508}'s room; {npc:14500} makes the parchment. Bring a group."] = "{area:2057}位於{zone:1422}東南方的島嶼城鎮{area:2298}之下：你需要它的鑰匙或盜賊來開門，還需要血骨傀儡的{item:13873}才能深入。在{npc:10508}房間的鍊金實驗室使用{item:18688}；{npc:14500}會製作羊皮紙。找小隊一起去。",
	-- {item:18688} Imp in a Jar
	["Use the {item:18688} at the alchemy lab"] = "在鍊金實驗室使用{item:18688}",

	-- Step 15: Dreadsteed of Xoroth
	-- {npc:14437} Gorzeeki Wildeyes · {npc:14436} Mor'zul Bloodbringer · {item:18663} J'eevee's Jar · {item:18629} Black Lodestone · {item:18670} Xorothian Glyphs
	-- plural, as words: Soul Shards = {item:6265} Soul Shard
	["Back to {npc:14437}, then {npc:14436} hands you his instructions for the ritual. Buy {item:18663}, the {item:18629} and the {item:18670} from {npc:14437}, and carry ten or more Soul Shards."] = "返回{npc:14437}，然後{npc:14436}會交給你儀式的說明。向{npc:14437}購買{item:18663}、{item:18629}和{item:18670}，並攜帶十個以上的靈魂碎片。",

	-- Step 16: The ritual in Dire Maul
	-- {area:2577} Dire Maul
	["The ritual in {area:2577}"] = "{area:2577}的儀式",
	-- {area:2577} Dire Maul · {zone:1444} Feralas · {npc:11496} Immol'thar · {item:18249} Crescent Key · {item:18663} J'eevee's Jar · {item:18629} Black Lodestone · {item:6265} Soul Shard · {item:18670} Xorothian Glyphs · {npc:14502} Xorothian Dreadsteed · {npc:14504} Dreadsteed Spirit
	["{area:2577} stands in the ruins of central {zone:1444}; the ritual circle is in its west wing, past {npc:11496}, and the door needs the {item:18249} or a rogue. Use {item:18663} to start; when the bell, the wheel or the candle fades, click it with the {item:18629} (a {item:6265} each). When the demons stop coming, use the {item:18670}, defeat the {npc:14502} and its dreadlord master, and speak to the {npc:14504}. Bring a group."] = "{area:2577}位於{zone:1444}中部的廢墟中；儀式法陣在西區，經過{npc:11496}之後，門需要{item:18249}或盜賊開啟。使用{item:18663}開始；當鈴鐺、輪子或蠟燭消退時，用{item:18629}點擊它（每次一個{item:6265}）。惡魔不再出現後，使用{item:18670}，擊敗{npc:14502}及其恐懼魔王主人，然後與{npc:14504}交談。找小隊一起去。",
	-- {npc:14504} Dreadsteed Spirit
	["{npc:14504}: it binds itself to you"] = "{npc:14504}：它會與你綁定",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Gorzeeki wants 10 Elixirs of {spell:5896} ({skill:171}), 6 Large Brilliant Shards ({skill:333}), 25 {item:11370} ({skill:186}, in {area:1584} and the {zone:1427}) and 35 Black Dragonscales ({skill:393}, black dragonkin of the {zone:1428}). Make or gather what your professions allow; buy the rest at the Auction House."] = "戈瑟奇要10瓶{spell:5896}藥劑（{skill:171}）、6個大塊魔光碎片（{skill:333}）、25個{item:11370}（{skill:186}，在{area:1584}和{zone:1427}）和35個黑龍鱗片（{skill:393}，{zone:1428}的黑龍族）。能用你的專業製作或採集的就自己來；其餘在拍賣場購買。",
}
