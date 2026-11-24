-- Chinese (traditional) (zhTW): the guide forever/class/priest/blood-of-morphaz (forever/class/priest/blood-of-morphaz.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1447} Azshara · {area:1417} Sunken Temple
	["17,060 XP and 1g55s at 50: {zone:1447}, then Morphaz in the {area:1417} (group of 5). The item choice may be gone."] = "50級時可得17,060經驗和1金55銀：先到{zone:1447}，再進{area:1417}殺莫法茲（5人隊伍）。物品選擇可能已經取消。",
	["17,060 experience and 1 gold 55 silver"] = "17,060經驗和1金55銀",

	-- Step 1: Cenarion Aid: High Priest Rohan
	-- {zone:1455} Ironforge · {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries · {object:32362} Mystic Ward · {quest:8254} Cenarion Aid · {item:7972} Ichor of Undeath
	["At 50 in {zone:1455}, {npc:11406} in the {object:32386} ({object:32362}) offers {quest:8254}. Before you leave a city, buy an {item:7972} at the Auction House (a few silver): the third quest asks for one and it drops rarely."] = "50級時在{zone:1455}，{object:32386}（{object:32362}）裡的{npc:11406}會提供{quest:8254}。離開城市前，先在拍賣行買一個{item:7972}（幾個銀幣）：第三個任務要一個，而且它掉落率極低。",

	-- Step 2: Cenarion Aid: Brother Joshua
	-- {npc:5489} Brother Joshua · {zone:1453} Stormwind · {quest:8254} Cenarion Aid · {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {item:7972} Ichor of Undeath · {object:2096} Trade District
	["At 50, {npc:5489} at the altar of {zone:1453}'s Cathedral of Light offers {quest:8254} ({npc:11406} in {zone:1455} has it too). Before you leave, buy an {item:7972} at the Auction House in the {object:2096} (a few silver): the third quest asks for one and it drops rarely."] = "50級時，{zone:1453}光明大教堂祭壇旁的{npc:5489}提供{quest:8254}（{zone:1455}的{npc:11406}也有）。離開前，先在{object:2096}的拍賣行買一個{item:7972}（幾個銀幣）：第三個任務要一個，而且它掉落率極低。",

	-- Step 3: Cenarion Aid: Ur'kyo
	-- {npc:6018} Ur'kyo · {zone:1454} Orgrimmar · {object:172961} Valley of Spirits · {quest:8254} Cenarion Aid · {item:7972} Ichor of Undeath
	["At 50, {npc:6018} in {zone:1454}'s {object:172961} offers {quest:8254}. Before you leave, buy an {item:7972} at the Auction House (a few silver): the third quest asks for one and it drops rarely."] = "50級時，{zone:1454}{object:172961}裡的{npc:6018}提供{quest:8254}。離開前，先在拍賣行買一個{item:7972}（幾個銀幣）：第三個任務要一個，而且它掉落率極低。",

	-- Step 4: Ogtinc
	-- {npc:8405} Ogtinc · {area:1221} Ruins of Eldarath · {area:3137} Talrendis Point · {area:1237} Valormok
	["{npc:8405}, a furbolg, lives on the clifftop north-east of the {area:1221}. Alliance: fly to {area:3137}; Horde: fly to {area:1237}. Ride east and leave the road at the fork before the ruins, then follow the northern cliff edge east to him: the naga ruins and the beach below are walled in by cliffs with no way up."] = "{npc:8405}是個熊怪，住在{area:1221}東北的崖頂。聯盟：飛到{area:3137}；部落：飛到{area:1237}。向東騎行，在廢墟前的岔路離開道路，然後沿北面崖邊向東走到他那裡：下方的納迦廢墟和海灘被峭壁圍住，無路可上。",

	-- Step 5: Of Coursers We Know
	-- {zone:1447} Azshara · {npc:8405} Ogtinc · {item:20027} Healthy Courser Gland · {item:7972} Ichor of Undeath
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers (level 52-53, not elite) graze all over {zone:1447}, thickest north-east of {npc:8405} and south of the mountains; about one in three drops a {item:20027}, so plan on a dozen kills for four. They enrage at 30% health: finish them fast. Killing them costs no Cenarion Circle reputation. Keep any {item:7972} you loot."] = "苔蹄駿馬（52-53級，非精英）遍佈{zone:1447}，{npc:8405}東北和山脈以南最密集；約三殺掉一個{item:20027}，所以四塊大概要殺十幾個。它們在血量30%時會狂暴：快點解決。殺它們不損失塞納里奧議會聲望。拾到的{item:7972}都留著。",

	-- Step 7: The Ichor of Undeath
	-- {item:7972} Ichor of Undeath · {npc:7864} Lingering Highborne · {area:1221} Ruins of Eldarath · {npc:8405} Ogtinc · {zone:1447} Azshara · {zone:1440} Ashenvale · {npc:7523} Suffering Highborne · {zone:1452} Winterspring
	["Carrying an {item:7972} already? It counts at once. Otherwise any undead may drop one, rarely: the {npc:7864} (level 48) in the {area:1221} below {npc:8405}'s cliff drop it about one kill in ten, the highborne ghosts on {zone:1447}'s border with {zone:1440} (level 45-46) a little less, the Anguished and {npc:7523} in {zone:1452} (54-55) about one in eight. The Auction House is usually quicker."] = "身上已經帶著{item:7972}？會立即計入。否則任何亡靈都可能極罕見地掉落一個：{npc:8405}崖下的{area:1221}中，{npc:7864}（48級）約十殺掉一個；{zone:1447}與{zone:1440}交界處的上層精靈鬼魂（45-46級）略低一些；{zone:1452}裡的痛苦者與{npc:7523}（54-55級）約八分之一。拍賣行通常更快。",

	-- Step 9: Morphaz in the Sunken Temple
	-- {area:1417} Sunken Temple
	["Morphaz in the {area:1417}"] = "{area:1417}的摩弗拉斯",
	-- {area:1417} Sunken Temple · {area:75} Stonard · {area:1438} Nethergarde Keep · {zone:1419} Blasted Lands · {area:74} Pool of Tears · {npc:5710} Jammal'an the Prophet
	["Morphaz is a level 52 elite green dragon inside the {area:1417}, a five-player dungeon: bring a group of five (a level 60 group clears it with ease). Horde: fly to {area:75}; Alliance: fly to {area:1438} in the {zone:1419} and ride north. The temple stands in the middle of the {area:74}: climb the steps on its south side, swim down through the flooded hall and take the stairs to the portal. Inside, Morphaz only appears late: kill the six troll minibosses on the upper balconies, then {npc:5710} below them; that wakes the drakes Weaver and Dreamscythe in the Pit of Sacrifice, and killing both brings Morphaz and Hazzas. The pair patrols together and cannot be split: pull them into a hallway and have the tank face them away from the group (breath and a knockback). Loot him in a party, not a raid group: the blood always drops."] = "摩弗拉斯是 {area:1417} 內的一條 52 級精英綠龍，這是五人地下城：帶上五人小隊（60 級小隊打起來很輕鬆）。部落：飛往 {area:75}；聯盟：飛往 {zone:1419} 的 {area:1438}，再騎馬向北。神廟位於 {area:74} 中央：從南側臺階上去，遊過被淹沒的大廳，再沿樓梯走到傳送門。進入後，要推進到後段摩弗拉斯才會出現：先殺死上層陽臺上的六名巨魔小首領，再殺死下方的 {npc:5710}；這會喚醒獻祭之池的德拉維沃爾和德姆塞卡爾，殺死兩者後，摩弗拉斯和哈扎斯才會出現。這兩條龍一起巡邏，無法拆開引：把它們拉進走廊，由坦克讓龍頭背對隊伍（有吐息和擊退）。拾取時要處於小隊，而不是團隊中：龍血必定掉落。",
	-- {quest:8257} Blood of Morphaz · {area:1417} Sunken Temple
	["{quest:8257}: the {area:1417} entrance"] = "{quest:8257}：{area:1417}入口",

	-- Step 10: Greta Mosshoof
	-- {npc:10922} Greta Mosshoof · {area:2479} Emerald Sanctuary · {zone:1448} Felwood · {area:1997} Bloodvenom Post · {area:415} Astranaar · {zone:1440} Ashenvale · {item:19990} Blessed Prayer Beads · {item:20006} Circle of Hope
	["{npc:10922} is at the {area:2479} in southern {zone:1448}. Horde: fly to {area:1997} and ride south-east; Alliance: fly to {area:415} in {zone:1440} and ride north into {zone:1448}. She takes the blood for experience and gold. Look at the reward window before you hand in: Classic let you pick {item:19990}, {item:20006} or Woestave, and Forever's notes say that choice may be gone."] = "{npc:10922}在{zone:1448}南部的{area:2479}。部落：飛到{area:1997}，然後向東南騎行；聯盟：飛到{zone:1440}的{area:415}，再向北進入{zone:1448}。她會收下血液，給你經驗和金幣。交任務前先看清獎勵視窗：經典舊世讓你選{item:19990}、{item:20006}或Woestave，而Forever的說明稱那個選項可能已經沒有了。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any undead can drop it. The {npc:7864} in the {area:1221}, below {npc:8405}'s cliffs, are the nearest; Highborne Apparitions and Lichlings haunt the ruins near {area:3137}."] = "任何不死生物都可能掉落。{npc:8405}所在懸崖下方{area:1221}的{npc:7864}是最近的；高等精靈的幻影和高等精靈鬼巫在{area:3137}附近的廢墟出沒。",
	-- ["At 50 {npc:5489} in {zone:1453}'s Cathedral of Light or {npc:11406} in {zone:1455}'s {object:32386} offers it."] = "50級時，{zone:1453}光明大教堂的{npc:5489}或{zone:1455}{object:32386}的{npc:11406}會提供此任務。",
	-- ["At 50 {npc:6018} in {zone:1454}'s {object:172961} offers it."] = "50級時，{zone:1454}{object:172961}的{npc:6018}會提供此任務。",
	-- ["Experience and gold"] = "經驗值和金幣",
	-- ["Experience and gold at 50 through {zone:1447} and the {area:1417}; Forever removed the Classic item choice."] = "50級時經由{zone:1447}和{area:1417}獲得經驗值和金幣；Forever移除了經典版的物品選擇。",
	-- ["Morphaz is an elite dragon boss inside the {area:1417}, a level 50 dungeon: bring a group of five. The temple stands in the middle of the {area:74}; swim down into it to reach the entrance. Horde: fly to {area:75}; Alliance: fly to {area:42} or {area:1438} and ride on."] = "摩弗拉斯是{area:1417}裡的精英龍類首領，這是50級地城：請帶五人小隊。神廟位於{area:74}中央；潛入水中往下游就能到入口。部落：飛往{area:75}；聯盟：飛往{area:42}或{area:1438}，再騎過去。",
	-- ["Mosshoof Coursers graze all over {zone:1447}; about one in three drops a {item:20027}."] = "苔蹄快步者在{zone:1447}各處吃草；大約三隻中有一隻會掉落{item:20027}。",
	-- ["{npc:10922} is at the {area:2479} in southern {zone:1448}."] = "{npc:10922}在{zone:1448}南部的{area:2479}。",
	-- ["{npc:8405} lives atop the cliffs north-east of the {area:1221}. Alliance: fly to {area:3137}; Horde: fly to {area:1237}."] = "{npc:8405}住在{area:1221}東北方的懸崖頂上。聯盟：飛往{area:3137}；部落：飛往{area:1237}。",
	-- ["{quest:8254} (Alliance)"] = "{quest:8254}（聯盟）",
	-- ["{quest:8254} (Horde)"] = "{quest:8254}（部落）",
}
