-- Chinese (traditional) (zhTW): the guide forever/reputation/zandalar-tribe (forever/reputation/zandalar-tribe.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Zandalar Tribe Reputation"] = "贊達拉部族聲望",
	-- {area:19} Zul'Gurub
	["Shoulder and head enchants, a class necklace upgraded at every standing, and {area:19}'s set pieces."] = "肩部和頭部附魔、隨每級聲望升級的職業項鍊，以及{area:19}的套裝部件。",
	["Your class's necklace at Friendly, upgraded at Honored, Revered and Exalted"] = "友善時獲得本職業項鍊，尊敬、崇敬和崇拜時升級",
	-- {npc:15042} Zanza the Restless
	["{npc:15042}'s head and leg enchants, from Friendly"] = "{npc:15042}的頭部和腿部附魔，友善起可用",

	-- Step 1: Yojamba Isle
	-- {area:3357} Yojamba Isle · {zone:1434} Stranglethorn Vale · {area:122} Zuuldaia Ruins · {faction:270} Zandalar Tribe · {npc:15070} Vinchaxa · {npc:14921} Rin'wosho the Trader · {npc:14902} Jin'rokh the Breaker · {npc:14903} Al'tabim the All-Seeing · {npc:14904} Maywiki of Zuldazar · {npc:14905} Falthir the Sightless · {area:19} Zul'Gurub
	["{area:3357} is the small island off the north-west coast of {zone:1434}, west of the {area:122}: swim over from the coast. Everyone starts Neutral with the {faction:270}. {npc:15070} takes coins and bijous, {npc:14921} sells the recipes and trades Honor Tokens, and {npc:14902}, {npc:14903}, {npc:14904} and {npc:14905} hand out the class necklaces and the set pieces. Almost all Zandalar reputation comes from {area:19}, a 20-player raid, and {area:19} is not among the first raids Blizzard has announced for Forever: until it opens there is no Zandalar reputation to earn, and no coins or bijous on the auction house either. Once it is open, the only solo way is buying coins and bijous on the auction house (75 per bijou, 25 per set of three coins). The Legacy perk Diplomat adds up to 10% to every gain; the numbers in this guide are without it."] = "{area:3357}是{zone:1434}西北海岸外的小島，位於{area:122}以西：從海岸游過去。每個人與{faction:270}都從中立開始。{npc:15070}收硬幣和小飾物，{npc:14921}出售配方並兌換榮譽徽章，{npc:14902}、{npc:14903}、{npc:14904}和{npc:14905}發放職業項鍊和套裝部件。幾乎所有贊達拉聲望都來自20人團隊副本{area:19}，而{area:19}並不在暴雪為Forever公佈的首批團隊副本中：在它開放之前，沒有贊達拉聲望可賺，拍賣行上也不會有硬幣或小飾物。一旦開放，唯一的單人途徑就是在拍賣行購買硬幣和小飾物（每枚小飾物75點，每套三枚硬幣25點）。傳承特長“外交家”會讓每次收益最多增加10%；本篇攻略中的數字不含它。",

	-- Step 2: Zul'Gurub to Friendly
	-- {area:19} Zul'Gurub
	["{area:19} to Friendly"] = "{area:19}到友善",
	-- {area:19} Zul'Gurub · {zone:1434} Stranglethorn Vale · {area:3398} Edge of Madness · {npc:15114} Gahz'ranka · {npc:11382} Bloodlord Mandokir · {item:22637} Primal Hakkari Idol · {item:19881} Channeler's Head · {quest:8240} A Bijou for Zanza
	["{area:19} is the troll city in the north-east of {zone:1434}: a 20-player raid. Trash pays 3 to 5 each until 11,999 of 12,000 Honored, one point short of Revered; the Speakers 15, Ohgan 15, the {area:3398} boss 25, {npc:15114} and the five High Priests 100, {npc:11382} and Jin'do 200 and Hakkar 400, all the way to Exalted. A full clear is about 4,050: one clear reaches Friendly (3,000). Loot every coin, bijou, {item:22637}, {item:19881} and Primal Hakkari set piece. Coins and bijous pay the same at any standing: save them until the trash stops counting, except one bijou for {quest:8240}."] = "{area:19}是{zone:1434}東北的巨魔城市：一個20人團隊副本。小怪每個給3到5點，直到尊敬的12,000點中的11,999點，距崇敬只差一點；演講者15點，奧甘15點，{area:3398}的首領25點，{npc:15114}和五位高階祭司100點，{npc:11382}和金度200點，哈卡400點，一直算到崇拜。全通一趟約4,050點：一趟就能到友善（3,000點）。拾取每一枚硬幣、每一件小飾物、{item:22637}、{item:19881}和原始哈卡萊套裝部件。硬幣和小飾物在任何聲望等級給的都一樣：留到小怪不再計數時再交，但{quest:8240}需要一枚小飾物除外。",
	-- {item:19707} Red Hakkari Bijou
	["{item:19707}; any of the nine colours does"] = "{item:19707}；九種顏色中任意一種都行",

	-- Step 3: A Bijou for Zanza
	-- {object:180367} Altar of Zanza (no name in this language: may be words) · {area:3357} Yojamba Isle · {npc:15070} Vinchaxa · {item:19858} Zandalar Honor Token
	["Destroy one bijou at the {object:180367}, the stone altar on the west side of {area:3357} (right-click the bijou there), then tell {npc:15070}: 150 reputation and an extra {item:19858}, once. From then on every bijou you destroy at the altar pays 75 reputation and a token, and every set of three coins {npc:15070} takes pays 25 and a token. They never stop counting."] = "在{area:3357}西側的石祭壇{object:180367}處銷燬一枚小飾物（在那裡右鍵點選小飾物），然後告訴{npc:15070}：一次性獲得150點聲望和一個額外的{item:19858}。此後，你在祭壇銷燬的每枚小飾物都給75點聲望和一枚徽章，{npc:15070}每收下一套三枚硬幣也給25點和一枚徽章。它們永遠會計數。",

	-- Step 4: Friendly: your class necklace
	["Friendly: your class necklace"] = "友善：你職業的項鍊",
	-- {item:19766} Pattern: Bloodvine Boots · {item:19687} Primal Batskin Bracers · {item:19778} Plans: Bloodsoul Gauntlets · {item:19695} Darksoul Shoulders · {item:20001} Schematic: Bloodvine Lens · {item:20012} Recipe: Greater Dreamless Sleep · {item:20757} Formula: Brilliant Mana Oil
	["At Friendly your class's trainer on the isle gives a necklace for free (100 reputation); the same NPC upgrades it at Honored, Revered and Exalted (100 each) with no raid item needed. Friendly also opens Rin'wosho's first recipes ({item:19766}, {item:19687}, {item:19778}, {item:19695}, {item:20001}, {item:20012}, 5g each; {item:20757}, 4g) and the Paragons of Power bracers (150 for the Primal Hakkari bracer token of your class)."] = "友善時，島上你職業的訓練師會免費給你一條項鍊（100點聲望）；同一個NPC會在尊敬、崇敬和崇拜時升級它（每次100點），不需要團隊副本物品。友善還會開放林沃紹的第一批配方（{item:19766}、{item:19687}、{item:19778}、{item:19695}、{item:20001}、{item:20012}，每張5金；{item:20757}，4金）以及力量典範護腕（用你職業的原始哈卡萊護腕徽記加150點）。",
	-- {npc:14902} Jin'rokh the Breaker · {item:19574} Strength of Mugamba
	["{npc:14902}: {item:19574}, Friendly"] = "{npc:14902}：{item:19574}，友善",
	-- {npc:14902} Jin'rokh the Breaker · {item:19579} Heathen's Brand
	["{npc:14902}: {item:19579}, Friendly"] = "{npc:14902}：{item:19579}，友善",
	-- {npc:14903} Al'tabim the All-Seeing · {quest:8049} The Eye of Zuldazar
	["{npc:14903}: {quest:8049}, Friendly"] = "{npc:14903}：{quest:8049}，友善",
	-- {npc:14903} Al'tabim the All-Seeing · {item:19598} Pebble of Kajaro
	["{npc:14903}: {item:19598}, Friendly"] = "{npc:14903}：{item:19598}，友善",
	-- {npc:14903} Al'tabim the All-Seeing · {quest:8106} Kezan's Taint
	["{npc:14903}: {quest:8106}, Friendly"] = "{npc:14903}：{quest:8106}，友善",
	-- {npc:14904} Maywiki of Zuldazar · {quest:8110} Enchanted South Seas Kelp
	["{npc:14904}: {quest:8110}, Friendly"] = "{npc:14904}：{quest:8110}，友善",
	-- {npc:14904} Maywiki of Zuldazar · {quest:8116} Vision of Voodress
	["{npc:14904}: {quest:8116}, Friendly"] = "{npc:14904}：{quest:8116}，友善",
	-- {npc:14905} Falthir the Sightless · {quest:8141} Zandalarian Shadow Talisman
	["{npc:14905}: {quest:8141}, Friendly"] = "{npc:14905}：{quest:8141}，友善",
	-- {npc:14905} Falthir the Sightless · {item:19618} Maelstrom's Tendril
	["{npc:14905}: {item:19618}, Friendly"] = "{npc:14905}：{item:19618}，友善",

	-- Step 5: Zanza the Restless's enchants, from Friendly
	-- {npc:15042} Zanza the Restless
	["{npc:15042}'s enchants, from Friendly"] = "{npc:15042}的附魔，友善起",
	-- {npc:15042} Zanza the Restless · {area:19} Zul'Gurub · {item:22637} Primal Hakkari Idol · {npc:11380} Jin'do the Hexxer · {npc:11382} Bloodlord Mandokir · {item:19813} Punctured Voodoo Doll
	-- plural, as words: Jinxed Hoodoo Piles = {object:180228} Jinxed Hoodoo Pile
	["{npc:15042}, a spirit just inside {area:19}'s entrance, trades your class's head and leg enchant for a {item:22637} ({npc:11380} or {npc:11382}, about 90%) and your class's {item:19813} (the Jinxed Hoodoo Piles scattered through {area:19}, now and then from its trash): 100 reputation each, as often as you like."] = "{npc:15042}是{area:19}入口內不遠處的靈魂，可用一個{item:22637}（{npc:11380}或{npc:11382}，約90%）和你職業的{item:19813}（散佈在{area:19}各處的被詛咒的巫毒堆，小怪偶爾也會掉）換取你職業的頭部和腿部附魔：每次100點聲望，想交多少次都行。",
	-- {item:22637} Primal Hakkari Idol
	["{item:22637}, Jin'do or Mandokir"] = "{item:22637}，金度或曼多基爾",
	-- {item:19813} Punctured Voodoo Doll
	["your class's {item:19813}"] = "你職業的{item:19813}",
	-- {npc:15042} Zanza the Restless
	["{npc:15042}: idol and doll, 100"] = "{npc:15042}：神像和人偶，100",

	-- Step 6: Zul'Gurub to Honored
	-- {area:19} Zul'Gurub
	["{area:19} to Honored"] = "{area:19}到尊敬",
	-- {item:19683} Bloodvine Leggings · {item:19686} Primal Batskin Gloves · {item:19689} Blood Tiger Shoulders · {item:19691} Bloodsoul Shoulders · {item:19694} Darksoul Leggings · {item:20004} Major Troll's Blood Elixir · {item:20000} Schematic: Bloodvine Goggles · {item:20756} Formula: Brilliant Wizard Oil · {item:232611} Magnificent Trollshine · {quest:8196} Essence Mangoes · {item:22635} Savage Guard
	["Friendly to Honored is 6,000: one and a half clears. Honored opens {item:19683}, {item:19686}, {item:19689}, {item:19691}, {item:19694} and {item:20004} (5g each), {item:20000} (12g), {item:20756} (4g) and {item:232611} (4g), the Paragons of Power belts and mantles (150 each), {quest:8196} (one Honor Token) and The {item:22635}."] = "",

	-- Step 7: Honored: necklace, Savage Guard and mangoes
	-- {item:22635} Savage Guard
	["Honored: necklace, {item:22635} and mangoes"] = "尊敬：項鍊、{item:22635}和芒果",
	-- {npc:15042} Zanza the Restless · {item:18331} Arcanum of Protection · {item:22635} Savage Guard · {npc:14368} Lorekeeper Lydros · {area:2577} Dire Maul · {item:18335} Pristine Black Diamond · {item:12735} Frayed Abomination Stitching · {item:12938} Blood of Heroes · {item:12753} Skin of Shadow · {npc:14921} Rin'wosho the Trader · {quest:8196} Essence Mangoes
	-- plural, as words: Large Brilliant Shards = {item:14344} Large Brilliant Shard
	["{npc:15042} takes an {item:18331}, Rapidity or Focus for the {item:22635} head and leg enchant: 200 reputation each, again and again. The Arcanum binds to you, so it never sells: {npc:14368} in the library of {area:2577} makes it from the matching Libram ({area:2577} drops, and on the auction house), a {item:18335} and Large Brilliant Shards, plus {item:12735}, two {item:12938} or two {item:12753}. {npc:14921} trades {quest:8196} for an Honor Token."] = "{npc:15042}接受{item:18331}——迅速或專注——用於{item:22635}的頭部和腿部附魔：每次給200點聲望，可反覆交。秘文拾取即繫結，所以永遠不會出售：{area:2577}圖書館裡的{npc:14368}會用對應的聖典（{area:2577}掉落，也在拍賣行有售）、一個{item:18335}和大塊魔光碎片，再加上{item:12735}、兩個{item:12938}或兩個{item:12753}來製作。{npc:14921}可用{quest:8196}換一枚榮譽徽章。",
	-- {npc:14902} Jin'rokh the Breaker · {item:19574} Strength of Mugamba
	["{npc:14902}: {item:19574}, Honored"] = "{npc:14902}：{item:19574}，尊敬",
	-- {npc:14902} Jin'rokh the Breaker · {item:19579} Heathen's Brand
	["{npc:14902}: {item:19579}, Honored"] = "{npc:14902}：{item:19579}，尊敬",
	-- {npc:14903} Al'tabim the All-Seeing · {quest:8049} The Eye of Zuldazar
	["{npc:14903}: {quest:8049}, Honored"] = "{npc:14903}：{quest:8049}，尊敬",
	-- {npc:14903} Al'tabim the All-Seeing · {item:19598} Pebble of Kajaro
	["{npc:14903}: {item:19598}, Honored"] = "{npc:14903}：{item:19598}，尊敬",
	-- {npc:14903} Al'tabim the All-Seeing · {quest:8106} Kezan's Taint
	["{npc:14903}: {quest:8106}, Honored"] = "{npc:14903}：{quest:8106}，尊敬",
	-- {npc:14904} Maywiki of Zuldazar · {quest:8110} Enchanted South Seas Kelp
	["{npc:14904}: {quest:8110}, Honored"] = "{npc:14904}：{quest:8110}，尊敬",
	-- {npc:14904} Maywiki of Zuldazar · {quest:8116} Vision of Voodress
	["{npc:14904}: {quest:8116}, Honored"] = "{npc:14904}：{quest:8116}，尊敬",
	-- {npc:14905} Falthir the Sightless · {quest:8141} Zandalarian Shadow Talisman
	["{npc:14905}: {quest:8141}, Honored"] = "{npc:14905}：{quest:8141}，尊敬",
	-- {npc:14905} Falthir the Sightless · {item:19618} Maelstrom's Tendril
	["{npc:14905}: {item:19618}, Honored"] = "{npc:14905}：{item:19618}，尊敬",
	-- {quest:8196} Essence Mangoes · {item:19858} Zandalar Honor Token
	["{quest:8196}: one {item:19858}"] = "{quest:8196}：一個{item:19858}",

	-- Step 8: Zul'Gurub to Revered
	-- {area:19} Zul'Gurub
	["{area:19} to Revered"] = "{area:19}到崇敬",
	-- {quest:8201} A Collection of Heads · {npc:14910} Exzhal · {item:19883} Sacred Cord · {quest:8183} The Heart of Hakkar · {npc:14875} Molthor · {item:19682} Bloodvine Vest · {item:19685} Primal Batskin Jerkin · {item:19688} Blood Tiger Breastplate · {item:19690} Bloodsoul Breastplate · {item:19693} Darksoul Breastplate · {item:20007} Mageblood Elixir · {quest:8243} Zanza's Potent Potables
	-- plural, as words: Channeler's Heads = {item:19881} Channeler's Head
	["Honored to Revered is 12,000: about three clears. Two one-time quests help: {quest:8201} ({npc:14910} on the isle: 200 for five Channeler's Heads from the High Priests, strung on his {item:19883}) and {quest:8183} (one per kill, for whoever loots it; {npc:14875} on the isle pays 200 and a Zandalarian Hero badge, charm or medallion). Revered opens {item:19682}, {item:19685}, {item:19688}, {item:19690}, {item:19693} and {item:20007} (5g each), the Paragons of Power chests and mantles (150) and {quest:8243}."] = "尊敬到崇敬是12,000點：約三趟副本。兩個一次性任務能幫上忙：{quest:8201}（島上的{npc:14910}：用五位高階祭司的五個引導者之頭，串在他的{item:19883}上，給200點）和{quest:8183}（每次擊殺一個，誰拾取歸誰；島上的{npc:14875}給200點和一個贊達拉英雄徽章、護符或獎章）。崇敬會開放{item:19682}、{item:19685}、{item:19688}、{item:19690}、{item:19693}和{item:20007}（每張5金）、力量典範胸甲和披肩（150點）以及{quest:8243}。",

	-- Step 9: Revered: necklace, coins and bijous
	["Revered: necklace, coins and bijous"] = "崇敬：項鍊、硬幣和小飾物",
	-- {npc:15042} Zanza the Restless · {item:22635} Savage Guard · {item:20081} Swiftness of Zanza
	["Trash stopped counting at 11,999 Honored. Revered to Exalted is 21,000: bosses give about 1,350 a clear, and now the saved coins and bijous pay: 75 per bijou (280 bijous alone), 25 per coin set. Coins and bijous are tradeable, so the auction house is the only solo way. Each Paragons piece pays 150, each {npc:15042} enchant 100, each {item:22635} 200. Rin'wosho trades one of {npc:15042}'s potables (Spirit, Sheen or {item:20081}) for an Honor Token."] = "小怪的計數在尊敬的11,999處停止。崇敬到崇拜是21,000點：首領每趟約給1,350點，而現在之前攢下的硬幣和小飾物開始生效：每枚小飾物75點（僅小飾物就有280枚），每套硬幣25點。硬幣和小飾物可以交易，所以拍賣行是唯一的單人途徑。每件力量典範部件給150點，每個{npc:15042}的附魔給100點，每個{item:22635}給200點。林沃紹可用一瓶{npc:15042}的藥水（靈魂、光澤或{item:20081}）換一枚榮譽徽章。",
	-- {npc:14902} Jin'rokh the Breaker · {item:19575} Strength of Mugamba
	["{npc:14902}: {item:19575}, Revered"] = "{npc:14902}：{item:19575}，崇敬",
	-- {npc:14902} Jin'rokh the Breaker · {item:19585} Heathen's Brand
	["{npc:14902}: {item:19585}, Revered"] = "{npc:14902}：{item:19585}，崇敬",
	-- {npc:14903} Al'tabim the All-Seeing · {quest:8050} The Eye of Zuldazar
	["{npc:14903}: {quest:8050}, Revered"] = "{npc:14903}：{quest:8050}，崇敬",
	-- {npc:14903} Al'tabim the All-Seeing · {item:19599} Pebble of Kajaro
	["{npc:14903}: {item:19599}, Revered"] = "{npc:14903}：{item:19599}，崇敬",
	-- {npc:14903} Al'tabim the All-Seeing · {quest:8107} Kezan's Taint
	["{npc:14903}: {quest:8107}, Revered"] = "{npc:14903}：{quest:8107}，崇敬",
	-- {npc:14904} Maywiki of Zuldazar · {quest:8111} Enchanted South Seas Kelp
	["{npc:14904}: {quest:8111}, Revered"] = "{npc:14904}：{quest:8111}，崇敬",
	-- {npc:14904} Maywiki of Zuldazar · {quest:8117} Vision of Voodress
	["{npc:14904}: {quest:8117}, Revered"] = "{npc:14904}：{quest:8117}，崇敬",
	-- {npc:14905} Falthir the Sightless · {quest:8142} Zandalarian Shadow Talisman
	["{npc:14905}: {quest:8142}, Revered"] = "{npc:14905}：{quest:8142}，崇敬",
	-- {npc:14905} Falthir the Sightless · {item:19619} Maelstrom's Tendril
	["{npc:14905}: {item:19619}, Revered"] = "{npc:14905}：{item:19619}，崇敬",
	-- {npc:15070} Vinchaxa
	["{npc:15070}: 3 coins, 25 and a token"] = "{npc:15070}：3枚硬幣，25點和一枚徽章",
	["25 and a token"] = "25點和一枚徽章",
	-- {quest:8243} Zanza's Potent Potables
	["{quest:8243}: one token"] = "{quest:8243}：一枚徽章",

	-- Step 10: Exalted: the Signets of the Zandalar
	-- {quest:8246} Signets of the Zandalar
	["Exalted: the {quest:8246}"] = "崇拜：{quest:8246}",
	-- {item:20013} Recipe: Living Action Potion
	-- plural, as words: Zandalar Honor Tokens = {item:19858} Zandalar Honor Token
	["At Exalted your necklace takes its last upgrade, Rin'wosho sells {item:20013} (5g), and Rin'wosho trades 15 Zandalar Honor Tokens for one Signet of the Zandalar, the shoulder enchant: Might (attack power), Mojo (spell damage) or Serenity (healing)."] = "崇拜時，你的項鍊完成最後一次升級，林沃紹出售{item:20013}（5金），並且林沃紹可用15枚贊達拉榮譽徽章換一枚贊達拉徽記，即肩部附魔：力量（攻擊強度）、魔精（法術傷害）或寧靜（治療）。",
	-- {npc:14902} Jin'rokh the Breaker · {item:19576} Strength of Mugamba
	["{npc:14902}: {item:19576}, Exalted"] = "{npc:14902}：{item:19576}，崇拜",
	-- {npc:14902} Jin'rokh the Breaker · {item:19586} Heathen's Brand
	["{npc:14902}: {item:19586}, Exalted"] = "{npc:14902}：{item:19586}，崇拜",
	-- {npc:14903} Al'tabim the All-Seeing · {quest:8051} The Eye of Zuldazar
	["{npc:14903}: {quest:8051}, Exalted"] = "{npc:14903}：{quest:8051}，崇拜",
	-- {npc:14903} Al'tabim the All-Seeing · {item:19600} Pebble of Kajaro
	["{npc:14903}: {item:19600}, Exalted"] = "{npc:14903}：{item:19600}，崇拜",
	-- {npc:14903} Al'tabim the All-Seeing · {quest:8108} Kezan's Taint
	["{npc:14903}: {quest:8108}, Exalted"] = "{npc:14903}：{quest:8108}，崇拜",
	-- {npc:14904} Maywiki of Zuldazar · {quest:8112} Enchanted South Seas Kelp
	["{npc:14904}: {quest:8112}, Exalted"] = "{npc:14904}：{quest:8112}，崇拜",
	-- {npc:14904} Maywiki of Zuldazar · {quest:8118} Vision of Voodress
	["{npc:14904}: {quest:8118}, Exalted"] = "{npc:14904}：{quest:8118}，崇拜",
	-- {npc:14905} Falthir the Sightless · {quest:8143} Zandalarian Shadow Talisman
	["{npc:14905}: {quest:8143}, Exalted"] = "{npc:14905}：{quest:8143}，崇拜",
	-- {npc:14905} Falthir the Sightless · {item:19620} Maelstrom's Tendril
	["{npc:14905}: {item:19620}, Exalted"] = "{npc:14905}：{item:19620}，崇拜",
	-- {quest:8246} Signets of the Zandalar
	["{quest:8246}: 15 Honor Tokens"] = "{quest:8246}：15枚榮譽徽章",
}
