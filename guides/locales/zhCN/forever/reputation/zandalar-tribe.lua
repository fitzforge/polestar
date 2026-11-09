-- Chinese (simplified) (zhCN): the guide forever/reputation/zandalar-tribe (forever/reputation/zandalar-tribe.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Zandalar Tribe Reputation"] = "赞达拉部族声望",
	-- {area:19} Zul'Gurub
	["Shoulder and head enchants, a class necklace upgraded at every standing, and {area:19}'s set pieces."] = "肩部和头部附魔、每个声望等级都会升级的职业项链，以及{area:19}的套装部件。",
	["Your class's necklace at Friendly, upgraded at Honored, Revered and Exalted"] = "友善时获得本职业项链，尊敬、崇敬和崇拜时升级",
	-- {npc:15042} Zanza the Restless
	["{npc:15042}'s head and leg enchants, from Friendly"] = "{npc:15042}的头部和腿部附魔，友善起可用",

	-- Step 1: Yojamba Isle
	-- {area:3357} Yojamba Isle · {zone:1434} Stranglethorn Vale · {area:122} Zuuldaia Ruins · {faction:270} Zandalar Tribe · {npc:15070} Vinchaxa · {npc:14921} Rin'wosho the Trader · {npc:14902} Jin'rokh the Breaker · {npc:14903} Al'tabim the All-Seeing · {npc:14904} Maywiki of Zuldazar · {npc:14905} Falthir the Sightless · {area:19} Zul'Gurub
	["{area:3357} is the small island off the north-west coast of {zone:1434}, west of the {area:122}: swim over from the coast. Everyone starts Neutral with the {faction:270}. {npc:15070} takes coins and bijous, {npc:14921} sells the recipes and trades Honor Tokens, and {npc:14902}, {npc:14903}, {npc:14904} and {npc:14905} hand out the class necklaces and the set pieces. Almost all Zandalar reputation comes from {area:19}, a 20-player raid, and {area:19} is not among the first raids Blizzard has announced for Forever: until it opens there is no Zandalar reputation to earn, and no coins or bijous on the auction house either. Once it is open, the only solo way is buying coins and bijous on the auction house (75 per bijou, 25 per set of three coins). The Legacy perk Diplomat adds up to 10% to every gain; the numbers in this guide are without it."] = "{area:3357} 是 {zone:1434} 西北海岸外、{area:122} 西侧的小岛：从岸边游过去。所有角色与 {faction:270} 的初始关系都是中立。{npc:15070} 收取硬币和宝石，{npc:14921} 出售配方并兑换荣誉勋章，{npc:14902}、{npc:14903}、{npc:14904} 和 {npc:14905} 提供职业项链和套装部件。几乎所有赞达拉声望都来自20人团队副本 {area:19}，而 {area:19} 不在暴雪已公布的无限服首批团队副本中：开放之前无法获取赞达拉声望，拍卖行也不会有硬币或宝石。开放后，独自获取的唯一方式是从拍卖行购买硬币和宝石（每颗宝石75声望，每组三枚硬币25声望）。传承特权外交家会使每次声望获取最多提高10%；本指南的数值未计入该加成。",

	-- Step 2: Zul'Gurub to Friendly
	-- {area:19} Zul'Gurub
	["{area:19} to Friendly"] = "{area:19}到友善",
	-- {area:19} Zul'Gurub · {zone:1434} Stranglethorn Vale · {area:3398} Edge of Madness · {npc:15114} Gahz'ranka · {npc:11382} Bloodlord Mandokir · {item:22637} Primal Hakkari Idol · {item:19881} Channeler's Head · {quest:8240} A Bijou for Zanza
	["{area:19} is the troll city in the north-east of {zone:1434}: a 20-player raid. Trash pays 3 to 5 each until 11,999 of 12,000 Honored, one point short of Revered; the Speakers 15, Ohgan 15, the {area:3398} boss 25, {npc:15114} and the five High Priests 100, {npc:11382} and Jin'do 200 and Hakkar 400, all the way to Exalted. A full clear is about 4,050: one clear reaches Friendly (3,000). Loot every coin, bijou, {item:22637}, {item:19881} and Primal Hakkari set piece. Coins and bijous pay the same at any standing: save them until the trash stops counting, except one bijou for {quest:8240}."] = "{area:19}是{zone:1434}东北部的巨魔城市：20人团队副本。小怪每只奖励3到5点声望，直到尊敬11,999/12,000、距崇敬还差一点；发言者15、奥根15、{area:3398}首领25、{npc:15114}和五名高阶祭司各100、{npc:11382}和金度各200、哈卡400，这些一直奖励到崇拜。全通一次约4,050：通一次即可到友善（3,000）。拾取所有硬币、宝石、{item:22637}、{item:19881}和原始哈卡莱套装兑换部件。硬币和宝石在任何声望阶段奖励相同：除了{quest:8240}所需的一颗宝石外，都留到小怪不再奖励声望时再用。",
	-- {item:19707} Red Hakkari Bijou
	["{item:19707}; any of the nine colours does"] = "{item:19707}；九种颜色中的任意一种都可以。",

	-- Step 3: A Bijou for Zanza
	-- {object:180367} Altar of Zanza (no name in this language: may be words) · {area:3357} Yojamba Isle · {npc:15070} Vinchaxa · {item:19858} Zandalar Honor Token
	["Destroy one bijou at the {object:180367}, the stone altar on the west side of {area:3357} (right-click the bijou there), then tell {npc:15070}: 150 reputation and an extra {item:19858}, once. From then on every bijou you destroy at the altar pays 75 reputation and a token, and every set of three coins {npc:15070} takes pays 25 and a token. They never stop counting."] = "在{object:180367}摧毁一颗宝石，那是{area:3357}西侧的石祭坛（在那里右键点击宝石），然后告诉{npc:15070}：一次性奖励150声望和一个额外的{item:19858}。此后每在祭坛摧毁一颗宝石，都奖励75声望和一枚奖章；{npc:15070}每收取一组三枚硬币，则奖励25声望和一枚奖章。这些奖励永远有效。",

	-- Step 4: Friendly: your class necklace
	["Friendly: your class necklace"] = "友善：你的职业项链",
	-- {item:19766} Pattern: Bloodvine Boots · {item:19687} Primal Batskin Bracers · {item:19778} Plans: Bloodsoul Gauntlets · {item:19695} Darksoul Shoulders · {item:20001} Schematic: Bloodvine Lens · {item:20012} Recipe: Greater Dreamless Sleep · {item:20757} Formula: Brilliant Mana Oil
	["At Friendly your class's trainer on the isle gives a necklace for free (100 reputation); the same NPC upgrades it at Honored, Revered and Exalted (100 each) with no raid item needed. Friendly also opens Rin'wosho's first recipes ({item:19766}, {item:19687}, {item:19778}, {item:19695}, {item:20001}, {item:20012}, 5g each; {item:20757}, 4g) and the Paragons of Power bracers (150 for the Primal Hakkari bracer token of your class)."] = "友善后，岛上对应你职业的训练师会免费给一条项链（100声望）；同一NPC会在尊敬、崇敬和崇拜时升级项链（每次100声望），无需团队副本物品。友善还会解锁商人林沃斯的首批配方（{item:19766}、{item:19687}、{item:19778}、{item:19695}、{item:20001}、{item:20012}，各5金币；{item:20757}，4金币），以及权力珍宝护腕（提交本职业的原始哈卡莱护腕兑换物，奖励150声望）。",
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
	["{npc:15042}'s enchants, from Friendly"] = "{npc:15042} 的附魔，友善起可用",
	-- {npc:15042} Zanza the Restless · {area:19} Zul'Gurub · {item:22637} Primal Hakkari Idol · {npc:11380} Jin'do the Hexxer · {npc:11382} Bloodlord Mandokir · {item:19813} Punctured Voodoo Doll
	-- plural, as words: Jinxed Hoodoo Piles = {object:180228} Jinxed Hoodoo Pile
	["{npc:15042}, a spirit just inside {area:19}'s entrance, trades your class's head and leg enchant for a {item:22637} ({npc:11380} or {npc:11382}, about 90%) and your class's {item:19813} (the Jinxed Hoodoo Piles scattered through {area:19}, now and then from its trash): 100 reputation each, as often as you like."] = "{npc:15042} 是一位幽灵，就在 {area:19} 入口内，可用一个 {item:22637}（{npc:11380} 或 {npc:11382} 掉落，概率约90%）和一个本职业的 {item:19813}（来自 {area:19} 各处的厄运巫毒堆，普通怪偶尔也会掉落）换取本职业的头部及腿部附魔：每次奖励100点声望，可无限重复。",
	-- {item:22637} Primal Hakkari Idol
	["{item:22637}, Jin'do or Mandokir"] = "{item:22637}，金度或曼多基尔",
	-- {item:19813} Punctured Voodoo Doll
	["your class's {item:19813}"] = "你所属职业的 {item:19813}。",
	-- {npc:15042} Zanza the Restless
	["{npc:15042}: idol and doll, 100"] = "{npc:15042}：神像和人偶，100点",

	-- Step 6: Zul'Gurub to Honored
	-- {area:19} Zul'Gurub
	["{area:19} to Honored"] = "{area:19}至尊敬",
	-- {item:19683} Bloodvine Leggings · {item:19686} Primal Batskin Gloves · {item:19689} Blood Tiger Shoulders · {item:19691} Bloodsoul Shoulders · {item:19694} Darksoul Leggings · {item:20004} Major Troll's Blood Elixir · {item:20000} Schematic: Bloodvine Goggles · {item:20756} Formula: Brilliant Wizard Oil · {spell:471400} Magnificent Trollshine · {quest:8196} Essence Mangoes · {item:22635} Savage Guard
	["Friendly to Honored is 6,000: one and a half clears. Honored opens {item:19683}, {item:19686}, {item:19689}, {item:19691}, {item:19694} and {item:20004} (5g each), {item:20000} (12g), {item:20756} (4g) and {spell:471400} (4g), the Paragons of Power belts and mantles (150 each), {quest:8196} (one Honor Token) and The {item:22635}."] = "友善到尊敬需要 6,000 点声望：约通关一次半。尊敬后解锁 {item:19683}、{item:19686}、{item:19689}、{item:19691}、{item:19694} 和 {item:20004}（各 5 金币）、{item:20000}（12 金币）、{item:20756}（4 金币）及 {spell:471400}（4 金币），以及权力珍宝腰带和衬肩（各 150）、{quest:8196}（一枚赞达拉荣誉勋章）和 {item:22635}。",

	-- Step 7: Honored: necklace, Savage Guard and mangoes
	-- {item:22635} Savage Guard
	["Honored: necklace, {item:22635} and mangoes"] = "尊敬：项链、{item:22635} 和芒果",
	-- {npc:15042} Zanza the Restless · {item:18331} Arcanum of Protection · {item:22635} Savage Guard · {npc:14368} Lorekeeper Lydros · {area:2577} Dire Maul · {item:18335} Pristine Black Diamond · {item:12735} Frayed Abomination Stitching · {item:12938} Blood of Heroes · {item:12753} Skin of Shadow · {npc:14921} Rin'wosho the Trader · {quest:8196} Essence Mangoes
	-- plural, as words: Large Brilliant Shards = {item:14344} Large Brilliant Shard
	["{npc:15042} takes an {item:18331}, Rapidity or Focus for the {item:22635} head and leg enchant: 200 reputation each, again and again. The Arcanum binds to you, so it never sells: {npc:14368} in the library of {area:2577} makes it from the matching Libram ({area:2577} drops, and on the auction house), a {item:18335} and Large Brilliant Shards, plus {item:12735}, two {item:12938} or two {item:12753}. {npc:14921} trades {quest:8196} for an Honor Token."] = "{npc:15042}收取一个{item:18331}、急速秘药或专注秘药，兑换头部和腿部附魔{item:22635}：每次200声望，可反复交还。秘药会与你绑定，因此无法出售：{area:2577}图书馆的{npc:14368}会用对应圣典（{area:2577}掉落，也可在拍卖行购买）、一个{item:18335}和大块魔光碎片，再加上{item:12735}、两个{item:12938}或两个{item:12753}来制作。{npc:14921}会用{quest:8196}交换一枚荣誉奖章。",
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
	["{quest:8196}: one {item:19858}"] = "{quest:8196}：一个{item:19858}",

	-- Step 8: Zul'Gurub to Revered
	-- {area:19} Zul'Gurub
	["{area:19} to Revered"] = "在 {area:19} 提升至崇敬。",
	-- {quest:8201} A Collection of Heads · {npc:14910} Exzhal · {item:19883} Sacred Cord · {quest:8183} The Heart of Hakkar · {npc:14875} Molthor · {item:19682} Bloodvine Vest · {item:19685} Primal Batskin Jerkin · {item:19688} Blood Tiger Breastplate · {item:19690} Bloodsoul Breastplate · {item:19693} Darksoul Breastplate · {item:20007} Mageblood Elixir · {quest:8243} Zanza's Potent Potables
	-- plural, as words: Channeler's Heads = {item:19881} Channeler's Head
	["Honored to Revered is 12,000: about three clears. Two one-time quests help: {quest:8201} ({npc:14910} on the isle: 200 for five Channeler's Heads from the High Priests, strung on his {item:19883}) and {quest:8183} (one per kill, for whoever loots it; {npc:14875} on the isle pays 200 and a Zandalarian Hero badge, charm or medallion). Revered opens {item:19682}, {item:19685}, {item:19688}, {item:19690}, {item:19693} and {item:20007} (5g each), the Paragons of Power chests and mantles (150) and {quest:8243}."] = "尊敬到崇敬需要 12,000 点声望：约通关三次。两个一次性任务有助于提升：{quest:8201}（岛上的 {npc:14910}：用他的 {item:19883} 串起高阶祭司掉落的五个导魔师的头颅，奖励 200）和 {quest:8183}（每次击杀只掉一个，由拾取者获得；岛上的 {npc:14875} 奖励 200，以及赞达拉英雄徽记、护符或勋章之一）。崇敬后解锁 {item:19682}、{item:19685}、{item:19688}、{item:19690}、{item:19693} 和 {item:20007}（各 5 金币）、权力珍宝胸甲和衬肩（150）以及 {quest:8243}。",

	-- Step 9: Revered: necklace, coins and bijous
	["Revered: necklace, coins and bijous"] = "崇敬：项链、硬币与宝石",
	-- {npc:15042} Zanza the Restless · {item:22635} Savage Guard · {item:20081} Swiftness of Zanza
	["Trash stopped counting at 11,999 Honored. Revered to Exalted is 21,000: bosses give about 1,350 a clear, and now the saved coins and bijous pay: 75 per bijou (280 bijous alone), 25 per coin set. Coins and bijous are tradeable, so the auction house is the only solo way. Each Paragons piece pays 150, each {npc:15042} enchant 100, each {item:22635} 200. Rin'wosho trades one of {npc:15042}'s potables (Spirit, Sheen or {item:20081}) for an Honor Token."] = "普通怪到尊敬11,999点就不再奖励声望。从崇敬到崇拜需要21,000点：首领每次全通约奖励1,350点，现在就可以交还攒下的硬币和宝石：每颗宝石75点（只交宝石需280颗），每套硬币25点。硬币和宝石都能交易，因此拍卖行是唯一的单人途径。权力珍宝每个部件奖励150点，每次 {npc:15042} 附魔100点，每个 {item:22635} 200点。在商人林沃斯处可用一枚荣誉勋章兑换 {npc:15042} 的一种药剂（精神、光泽或 {item:20081}）。",
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
	["{npc:15070}: 3 coins, 25 and a token"] = "{npc:15070}：3枚硬币，25声望和一枚勋章",
	["25 and a token"] = "25 点声望和一枚奖券",
	-- {quest:8243} Zanza's Potent Potables
	["{quest:8243}: one token"] = "{quest:8243}：一枚奖券",

	-- Step 10: Exalted: the Signets of the Zandalar
	-- {quest:8246} Signets of the Zandalar
	["Exalted: the {quest:8246}"] = "崇拜：{quest:8246}",
	-- {item:20013} Recipe: Living Action Potion
	-- plural, as words: Zandalar Honor Tokens = {item:19858} Zandalar Honor Token
	["At Exalted your necklace takes its last upgrade, Rin'wosho sells {item:20013} (5g), and Rin'wosho trades 15 Zandalar Honor Tokens for one Signet of the Zandalar, the shoulder enchant: Might (attack power), Mojo (spell damage) or Serenity (healing)."] = "崇拜后，你的项链可进行最后一次升级，林沃斯会出售 {item:20013}（5 金），还可用 15 枚赞达拉荣誉勋章向林沃斯兑换一个赞达拉徽记，即肩部附魔：力量（攻击强度）、魔精（法术伤害）或宁静（治疗）。",
	-- {npc:14902} Jin'rokh the Breaker · {item:19576} Strength of Mugamba
	["{npc:14902}: {item:19576}, Exalted"] = "{npc:14902}：{item:19576}，崇拜。",
	-- {npc:14902} Jin'rokh the Breaker · {item:19586} Heathen's Brand
	["{npc:14902}: {item:19586}, Exalted"] = "{npc:14902}：{item:19586}，崇拜。",
	-- {npc:14903} Al'tabim the All-Seeing · {quest:8051} The Eye of Zuldazar
	["{npc:14903}: {quest:8051}, Exalted"] = "{npc:14903}：{quest:8051}，崇拜",
	-- {npc:14903} Al'tabim the All-Seeing · {item:19600} Pebble of Kajaro
	["{npc:14903}: {item:19600}, Exalted"] = "{npc:14903}：{item:19600}，崇拜。",
	-- {npc:14903} Al'tabim the All-Seeing · {quest:8108} Kezan's Taint
	["{npc:14903}: {quest:8108}, Exalted"] = "{npc:14903}：{quest:8108}，崇拜",
	-- {npc:14904} Maywiki of Zuldazar · {quest:8112} Enchanted South Seas Kelp
	["{npc:14904}: {quest:8112}, Exalted"] = "{npc:14904}：{quest:8112}，崇拜",
	-- {npc:14904} Maywiki of Zuldazar · {quest:8118} Vision of Voodress
	["{npc:14904}: {quest:8118}, Exalted"] = "{npc:14904}：{quest:8118}，崇拜",
	-- {npc:14905} Falthir the Sightless · {quest:8143} Zandalarian Shadow Talisman
	["{npc:14905}: {quest:8143}, Exalted"] = "{npc:14905}：{quest:8143}，崇拜",
	-- {npc:14905} Falthir the Sightless · {item:19620} Maelstrom's Tendril
	["{npc:14905}: {item:19620}, Exalted"] = "{npc:14905}：{item:19620}，崇拜。",
	-- {quest:8246} Signets of the Zandalar
	["{quest:8246}: 15 Honor Tokens"] = "{quest:8246}：15枚荣誉勋章",
}
