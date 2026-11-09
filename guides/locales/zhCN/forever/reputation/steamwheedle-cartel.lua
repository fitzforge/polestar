-- Chinese (simplified) (zhCN): the guide forever/reputation/steamwheedle-cartel (forever/reputation/steamwheedle-cartel.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Steamwheedle Cartel Reputation"] = "热砂港声望",
	-- {npc:14637} Zorbin Fandazzle · {npc:14338} Knot Thimblejack
	["Every goblin town at once: {npc:14637}'s zapped giants and {npc:14338}'s shackles, then five new quartermasters and their hats."] = "所有地精城镇同时提升：{npc:14637}的电击巨人和{npc:14338}的镣铐，然后是五位新军需官和他们的帽子。",
	["Forever's goblin quartermasters: gear for levels 20 to 50 at Friendly and Honored"] = "无限的地精军需官：友善和尊敬声望下的20到50级装备",

	-- Step 1: Zorbin Fandazzle
	-- {faction:470} Ratchet · {faction:21} Booty Bay · {faction:369} Gadgetzan · {faction:577} Everlook · {faction:2827} Powderfuse · {zone:2548} Riverglades · {npc:14637} Zorbin Fandazzle · {npc:4624} Booty Bay Bruiser · {zone:1444} Feralas
	["Five goblin towns share one reputation family, the Steamwheedle Cartel: {faction:470}, {faction:21}, {faction:369}, {faction:577} and Forever's new {faction:2827} in the {zone:2548}. Everyone starts each at Neutral (500 into it). A gain with one town gives the others half as much; a quest for the Cartel itself, like {npc:14637}'s, pays every town in full. Losses spread the same way: a {npc:4624} or any goblin of the towns costs 125 (half that with the other towns), and Bloodsail Buccaneers reputation is earned only that way. {npc:14637} camps on the road through central {zone:1444} and works for anyone, even players the goblins hate. His first two quests are level 48 and open his repeatables (level 55); Forever pays all of them in full at any level."] = "",
	-- {quest:7003} Zapped Giants
	["{quest:7003}: 150 to every town"] = "{quest:7003}：每座城镇 150 点声望",
	-- {quest:7721} Fuel for the Zapping
	["{quest:7721}: 150 to every town"] = "{quest:7721}：每座城镇 150 点声望",

	-- Step 2: Zapped giants
	["Zapped giants"] = "被缩小的巨人",
	-- {item:18904} Zorbin's Ultra-Shrinker · {npc:5357} Land Walker · {npc:5358} Cliff Giant · {npc:5361} Wave Strider · {item:18956} Miniaturization Residue
	-- plural, as words: Land Walkers = {npc:5357} Land Walker · Cliff Giants = {npc:5358} Cliff Giant
	["Use {item:18904} on a living giant ({npc:5357}, {npc:5358}, or a Shore, Deep or {npc:5361}, level 47-50) and it shrinks into a zapped version; kill that for its {item:18956}, one every time. The Land Walkers and Cliff Giants in the north-west hills are the thickest; the striders walk the coast and the shallows. The shrinker lasts two hours: if it runs out, abandon the quest and take it again."] = "对一只活着的巨人使用 {item:18904}（{npc:5357}、{npc:5358}，或海岸巨人、深海巨人、{npc:5361}，47—50级），它会缩成被压缩的形态；击杀后获得 {item:18956}，每只必掉一个。西北山丘的大地行者和峭壁巨人最密集；海巨人在海岸和浅滩行走。压缩器持续两小时：如果到期，就放弃任务再重接。",
	-- {item:18904} Zorbin's Ultra-Shrinker
	["{item:18904}, on a living giant"] = "对一只活着的巨人使用{item:18904}",
	-- {item:18956} Miniaturization Residue
	["{item:18956}, from the zapped giants"] = "{item:18956}，由被缩小射线命中的巨人掉落",

	-- Step 3: Sea Elementals and Sea Sprays
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["Sea Elementals and Sea Sprays"] = "海元素和巨型海元素",
	-- {area:1108} Forgotten Coast · {item:18958} Water Elemental Core
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["The Sea Elementals and Sea Sprays (level 47-49) drift along the {area:1108} and in the shallows below the giants: about half drop a {item:18958}."] = "海元素和巨型海元素（47—49级）在 {area:1108} 沿岸及巨人下方的浅滩游荡：约有一半会掉落 {item:18958}。",
	-- {item:18958} Water Elemental Core
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["{item:18958}: Sea Elementals and Sea Sprays"] = "{item:18958}：海元素和巨型海元素",

	-- Step 4: Back to Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle
	["Back to {npc:14637}"] = "返回{npc:14637}处",
	-- {npc:14637} Zorbin Fandazzle · {quest:7725} Again With the Zapped Giants · {quest:7726} Refuel for the Zapping
	["From now on {npc:14637} offers {quest:7725} (10 residue) and {quest:7726} (6 cores), again and again: 25 reputation with every town each time."] = "从现在起，{npc:14637} 会反复提供 {quest:7725}（10 个残渣）和 {quest:7726}（6 个核心）：每次给每座城镇 25 点声望。",

	-- Step 5: Lost Rigger Cove, below 56
	-- {area:1336} Lost Rigger Cove
	["{area:1336}, below 56"] = "{area:1336}，低于56级",
	-- {area:1336} Lost Rigger Cove · {zone:1446} Tanaris · {faction:369} Gadgetzan · {area:977} Steamwheedle Port · {quest:8366} Southsea Shakedown · {quest:8365} Pirate Hats Ahoy!
	-- plural, as words: Southsea Pirate Hats = {item:20519} Southsea Pirate Hat
	["The Southsea pirates of {area:1336} (level 44-45) on the east coast of {zone:1446} give {faction:369} 5 each up to the end of Honored, and the other towns half. Two quests at {area:977} pay 100 {faction:369} each: {quest:8366} (10 of each pirate) and {quest:8365} (20 Southsea Pirate Hats, one in ten pirates). From level 56 the pirates are grey and pay little: skip this step then."] = "{zone:1446} 东海岸 {area:1336} 的南海海盗（44-45 级），每名给予 {faction:369} 5 点声望，直到尊敬满，其他城镇获得一半。{area:977} 的两个任务各奖励 100 点 {faction:369} 声望：{quest:8366}（每种海盗各 10 名）和 {quest:8365}（20 顶南海海盗帽，海盗掉率十分之一）。56 级起，这些海盗会变成灰色，声望很少：到时跳过本步骤。",

	-- Step 6: Tinkee Steamboil
	-- {npc:10267} Tinkee Steamboil · {area:251} Flame Crest · {zone:1428} Burning Steppes · {faction:577} Everlook · {item:12284} Draco-Incarcinatrix 900 · {quest:4726} Broodling Essence
	-- plural, as words: Scalding Broodlings = {npc:7048} Scalding Broodling · Flamescale Broodlings = {npc:7049} Flamescale Broodling · Black Broodlings = {npc:7047} Black Broodling
	["{npc:10267}, a goblin at {area:251} in the north of the {zone:1428}, has a chain that pays every town 150 and {faction:577} 150 more. Use her {item:12284} on a broodling, kill it while the device holds it, and pick up the {quest:4726} it leaves. The device takes only Black and Scalding Broodlings, not the Flamescale Broodlings of the west: Scalding Broodlings (level 53-54) roam just west and east of {area:251}, Black Broodlings (51-52) the north-east corner of the zone, the thickest group. They are few and spread out: the path passes both and ends among the Black Broodlings."] = "{zone:1428}北部{area:251}的地精{npc:10267}有一条任务线，为每座城镇奖励150声望，并额外奖励150点{faction:577}声望。对小龙使用她的{item:12284}，在装置控制住它时击杀，再捡起留下的{quest:4726}。装置只对黑色小龙和炽热小龙有效，对西边的火鳞小龙无效：炽热小龙（53-54级）就在{area:251}东西两侧不远处，黑色小龙（51-52级）在本地区东北角，那里最密集。它们数量不多、分布分散：这条路线会经过两种小龙，最后到黑色小龙群中。",
	-- {area:251} Flame Crest
	-- plural, as words: Scalding Broodlings = {npc:7048} Scalding Broodling
	["Scalding Broodlings west of {area:251}"] = "{area:251}西侧的炽热小龙",
	-- {area:251} Flame Crest
	-- plural, as words: Scalding Broodlings = {npc:7048} Scalding Broodling
	["Scalding Broodlings east of {area:251}"] = "{area:251} 东边的炽热小龙",
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["Black Broodlings in the north-east"] = "东北方的黑色小龙",
	-- {item:12284} Draco-Incarcinatrix 900 · {npc:7048} Scalding Broodling
	["{item:12284}, on a Black or {npc:7048}"] = "对一只黑色雏龙或 {npc:7048} 使用 {item:12284}。",
	-- {quest:4726} Broodling Essence
	["{quest:4726}, left by the broodlings"] = "{quest:4726}，小龙留下的",
	["100 to every town"] = "每座城镇 100 点声望",

	-- Step 7: Everlook: Felnok Steelspring
	-- {quest:4808} Felnok Steelspring · {faction:577} Everlook
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["{quest:4808} is in {faction:577}. The Chillwind Chimaeras (level 55-57) south-west of {faction:577} drop the horns one time in five."] = "{quest:4808} 位于 {faction:577}。{faction:577} 西南面的冰风奇美拉（55—57级）掉落角的概率为五分之一。",
	-- {item:12444} Uncracked Chillwind Horn
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["{item:12444}: Chillwind Chimaeras"] = "{item:12444}：冰风奇美拉",

	-- Step 8: Back to Tinkee Steamboil
	-- {npc:10267} Tinkee Steamboil
	["Back to {npc:10267}"] = "返回{npc:10267}处",
	-- {quest:4810} Return to Tinkee
	["{quest:4810} gives 50 to every town. Her later quests, Egg Freezing (150 to every town) and Egg Collection (200), are done in the Rookery of Upper Blackrock Spire, a ten-player dungeon: take them up with your group."] = "{quest:4810} 给每座城镇50声望。她后续的“冷冻龙蛋”（每座城镇150）和“收集龙蛋”（200）在十人地下城黑石塔上层的孵化间完成：随小队一起上去时做。",

	-- Step 9: Dire Maul North: Knot Thimblejack
	-- {npc:14338} Knot Thimblejack
	["Dire Maul North: {npc:14338}"] = "厄运之槌北区：{npc:14338}",
	-- {npc:14338} Knot Thimblejack · {item:18250} Gordok Shackle Key · {npc:14321} Guard Fengus · {item:18258} Gordok Ogre Suit · {item:8170} Rugged Leather · {item:14341} Rune Thread · {item:18240} Ogre Tannin
	["{npc:14338} sits shackled in Dire Maul North, the Gordok ogres' wing (a five-player dungeon from level 57: group up). Every {item:18250} frees him once: 150 to every town, and he is shackled again on your next run. Gordok ogres drop the keys (about one in fifteen; {npc:14321} one in seven): a full run of the wing usually brings one. His {item:18258} pays 100 the first time and 50 after, for 4 Bolts of Runecloth, 8 {item:8170}, 2 {item:14341} and the {item:18240} from the basket in the wing. Under 57 when you get here? Unskip this step later."] = "{npc:14338}被锁在厄运之槌北区，也就是戈多克食人魔所在区域（57级起的五人地下城：请组队）。每把{item:18250}可释放他一次：所有城镇各150声望，下次进本他又会被锁住。戈多克食人魔掉落钥匙（约十五分之一；{npc:14321}约七分之一）：完整打通该区通常能获得一把。他的{item:18258}首次奖励100，之后50，需要4卷符文布卷、8个{item:8170}、2个{item:14341}，以及本区篮子里的{item:18240}。来到这里时还没到57级？以后再取消跳过此步骤。",
	-- {item:18250} Gordok Shackle Key
	["{item:18250}, Gordok ogres"] = "{item:18250}，戈多克食人魔",
	-- {quest:5525} Free Knot!
	["{quest:5525}: 150 to every town"] = "{quest:5525}：每座城镇 150 点声望",
	-- {quest:5525} Free Knot!
	["{quest:5525}, again on every later run: 150"] = "{quest:5525}，之后每次进本都能再做：150点",

	-- Step 10: Every town to Friendly
	["Every town to Friendly"] = "将所有城镇声望提升到友善。",
	-- {npc:14637} Zorbin Fandazzle · {npc:10267} Tinkee Steamboil · {faction:470} Ratchet · {zone:1413} Barrens · {npc:3446} Mebok Mizzyrix · {faction:21} Booty Bay · {zone:1418} Badlands · {area:327} Faldir's Cove · {faction:369} Gadgetzan · {zone:1446} Tanaris · {item:8548} Divino-matic Rod · {faction:577} Everlook · {zone:1452} Winterspring · {npc:9298} Donova Snowden · {zone:1411} Durotar · {zone:1455} Ironforge
	["Neutral 500 to Friendly is 2,500 with each town. The quests above pay every town up to 700 ({npc:14637}'s two 300, {npc:10267}'s 150, the first Free Knot 150 and the first Ogre Suit 100); {npc:14637}'s repeatables do the rest, 25 to every town each: 10 residue (ten giants) or 6 cores (about twelve elementals). The towns' own quests count too, each giving the other towns half: {faction:470}'s in the {zone:1413} (levels 10-25, about 4,300: the Samophlange chain 625, {npc:3446}'s errands, the Wizzlecrank and Gilthares escorts 150 each), {faction:21}'s in Stranglethorn, Arathi and the {zone:1418} (30-50, about 6,500: the three OOX robot rescues 250 each, An OOX of Your Own 200, Stranglethorn Fever 200, Facing Negolash 200, the Sunken Treasure chain at {area:327}), {faction:369}'s in {zone:1446} (43-55, about 3,000: the {item:8548} 200, Wastewander Justice 100 each, the WANTED posters) and {faction:577}'s in {zone:1452} (52-60, about 1,450: {npc:9298}'s Winterfall chain, Umi's yeti quests). Forever adds a few low ones: A Simmering Storm and Stormy Potential in {zone:1411} and WANTED: Bruuz ({faction:470} 100 each), Important Heirlooms in {zone:1455} ({faction:369} 100). Forever pays them in full at any level. Kills help while they are not grey, 5 each: Southsea pirates in the {zone:1413} for {faction:470} and in {zone:1446} for {faction:369} and Stranglethorn's Venture Co. camps for {faction:21}, up to the end of Honored; Wastewander bandits for {faction:369} and Bloodsail pirates for {faction:21} only up to the end of Neutral. Friendly opens each quartermaster's first gear."] = "",
	-- {quest:7725} Again With the Zapped Giants
	["{quest:7725}: 10 residue"] = "{quest:7725}：10 个残渣。",
	["25 to every town"] = "向每座城镇提供 25 点声望。",
	-- {quest:7726} Refuel for the Zapping
	["{quest:7726}: 6 cores"] = "{quest:7726}：6个核心",

	-- Step 11: Every town to Honored
	["Every town to Honored"] = "所有城镇至尊敬",
	-- {npc:14637} Zorbin Fandazzle · {item:18250} Gordok Shackle Key
	["Friendly to Honored is 6,000: 240 of {npc:14637}'s turn-ins, or 40 Free Knot runs, or a mix. Nothing can be saved up: residue and cores drop only while their quest is in your log, and you can carry one {item:18250} at a time, so hand each in before the next run. Honored opens each quartermaster's blue items."] = "从友善到尊敬需要 6,000 点：交还 240 次 {npc:14637} 的任务，或刷 40 次解救诺特，也可以两者混用。无法提前囤积：只有任务在日志中时才会掉落残渣和核心，而 {item:18250} 一次只能携带一个，因此每次刷完都要先交还再进行下一次。尊敬后会解锁各军需官的蓝色物品。",

	-- Step 12: Every town to Revered
	["Every town to Revered"] = "所有城镇达到崇敬",
	-- {npc:14637} Zorbin Fandazzle
	["Honored to Revered is 12,000 more: 480 of {npc:14637}'s turn-ins (4,800 residue) or 80 Free Knot runs. Revered opens the five cosmetic hats, the reason most players do this. Legacy Diplomat adds up to 10%."] = "从尊敬到崇敬还需12,000点：相当于完成 {npc:14637} 的交还任务480次（4,800份残渣），或解救诺特80次。崇敬可解锁五顶装饰帽，大多数玩家就是为此而刷。传承天赋“外交家” 最多增加10%。",

	-- Step 13: Ratchet: Winklespark
	-- {npc:265574} Winklespark · {faction:470} Ratchet · {item:274740} Quilted Cloak · {item:274741} Rumpled Kilt · {item:274742} Ratchet Wristwraps · {item:274743} Defective Samophlange · {item:274744} Barrens Basher · {item:274021} Barrens Headband
	["{npc:265574}, {faction:470}'s quartermaster, by the docks. Friendly, level 20 gear: {item:274740} 41s (Stamina, Agility), {item:274741} 54s (Stamina, spell power), {item:274742} 34s (Intellect, Agility). Honored: {item:274743}, an off-hand, 66s (Intellect, Spirit); {item:274744}, a one-handed mace, 1g 65s (Stamina, Strength). Revered: the {item:274021}, a cosmetic hat, 2g."] = "{faction:470} 的军需官 {npc:265574} 在码头旁。友善，20级装备：{item:274740}，41银币（耐力、敏捷）；{item:274741}，54银币（耐力、法术强度）；{item:274742}，34银币（智力、敏捷）。尊敬：副手 {item:274743}，66银币（智力、精神）；单手锤 {item:274744}，1金币65银币（耐力、力量）。崇敬：装饰帽 {item:274021}，2金币。",
	-- {item:274740} Quilted Cloak
	["{item:274740}, Friendly"] = "{item:274740}，友善",
	-- {item:274741} Rumpled Kilt
	["{item:274741}, Friendly"] = "{item:274741}，友善",
	-- {item:274742} Ratchet Wristwraps
	["{item:274742}, Friendly"] = "{item:274742}，友善",
	-- {item:274743} Defective Samophlange
	["{item:274743}, Honored"] = "{item:274743}，尊敬",
	-- {item:274744} Barrens Basher
	["{item:274744}, Honored"] = "{item:274744}，尊敬",
	-- {item:274021} Barrens Headband
	["{item:274021}, Revered"] = "{item:274021}，崇敬",

	-- Step 14: Booty Bay: Gezzy Gunkgear
	-- {npc:265575} Gezzy Gunkgear · {faction:21} Booty Bay · {item:274745} Deckswabber's Mitts · {item:274746} Sea Giant's Toe Ring · {item:274747} Soggy Boots · {item:274748} Booty Bay Bruiser's Buckshot · {item:274749} Souvenir Sea Shell · {item:274022} Tough Guy's Eyepatch
	["{npc:265575}, {faction:21}'s quartermaster. Friendly, level 30 gear: {item:274745} 1g 10s (Strength, Agility), {item:274746} 1g 48s (healing and spell damage), {item:274747} 1g 3s (Intellect, Spirit). Honored: {item:274748}, a gun, 3g 11s (attack power, Stamina); {item:274749}, a necklace, 1g 66s (health regeneration, Stamina). Revered: {item:274022}, 5g."] = "{npc:265575}，{faction:21}军需官。友善，30级装备：{item:274745}，1金10银（力量、敏捷）；{item:274746}，1金48银（治疗和法术伤害）；{item:274747}，1金3银（智力、精神）。尊敬：枪械{item:274748}，3金11银（攻击强度、耐力）；项链{item:274749}，1金66银（生命值回复、耐力）。崇敬：{item:274022}，5金。",
	-- {item:274745} Deckswabber's Mitts
	["{item:274745}, Friendly"] = "{item:274745}，友善",
	-- {item:274746} Sea Giant's Toe Ring
	["{item:274746}, Friendly"] = "{item:274746}，友善",
	-- {item:274747} Soggy Boots
	["{item:274747}, Friendly"] = "{item:274747}，友善",
	-- {item:274748} Booty Bay Bruiser's Buckshot
	["{item:274748}, Honored"] = "{item:274748}，尊敬",
	-- {item:274749} Souvenir Sea Shell
	["{item:274749}, Honored"] = "{item:274749}，尊敬",
	-- {item:274022} Tough Guy's Eyepatch
	["{item:274022}, Revered"] = "{item:274022}，崇敬",

	-- Step 15: Gadgetzan: Rettrick
	-- {npc:265576} Rettrick · {faction:369} Gadgetzan · {item:274750} Reflective Wristguards · {item:274751} Sunburn Spaulders · {item:274752} Sandstorm Cover · {item:274753} Jhordy's Misplaced Screwdriver · {item:274754} Suspicious Spare Part · {item:274023} Stolen Wastewander Cowl
	["{npc:265576}, {faction:369}'s quartermaster. Friendly, level 40 gear: {item:274750} 2g 74s (Intellect, healing, spell damage), {item:274751} 2g 94s (Agility, attack power), {item:274752}, a cloak, 2g 36s (Spirit, spell power). Honored: {item:274753}, a one-handed weapon, 9g 46s (Strength, Agility); {item:274754}, a ring, 3g 80s (Strength, Stamina). Revered: the {item:274023}, 10g."] = "{npc:265576}，{faction:369} 军需官。友善，40 级装备：{item:274750}，2 金 74 银（智力、治疗、法术伤害）；{item:274751}，2 金 94 银（敏捷、攻击强度）；披风 {item:274752}，2 金 36 银（精神、法术强度）。尊敬：单手武器 {item:274753}，9 金 46 银（力量、敏捷）；戒指 {item:274754}，3 金 80 银（力量、耐力）。崇敬：{item:274023}，10 金币。",
	-- {item:274750} Reflective Wristguards
	["{item:274750}, Friendly"] = "{item:274750}，友善",
	-- {item:274751} Sunburn Spaulders
	["{item:274751}, Friendly"] = "{item:274751}，友善",
	-- {item:274752} Sandstorm Cover
	["{item:274752}, Friendly"] = "{item:274752}，友善",
	-- {item:274753} Jhordy's Misplaced Screwdriver
	["{item:274753}, Honored"] = "{item:274753}，尊敬",
	-- {item:274754} Suspicious Spare Part
	["{item:274754}, Honored"] = "{item:274754}，尊敬",
	-- {item:274023} Stolen Wastewander Cowl
	["{item:274023}, Revered"] = "{item:274023}，崇敬",

	-- Step 16: Everlook: Zippie Fizzbolt
	-- {npc:265577} Zippie Fizzbolt · {faction:577} Everlook · {item:274755} Steamwheedle Grips · {item:274756} Impractical Headwarmer · {item:274757} Substandard Belt Chain · {item:274758} Coldmetal Guard · {item:274759} Everlook Pathcarver · {item:274760} Everlook Delivery Bot · {item:274761} Parachute-Priest Pager · {item:274024} Fizzbolt's Fashionable Fedora
	["{npc:265577}, {faction:577}'s quartermaster. Friendly, level 50 gear: {item:274755} 3g 10s (Spirit, Intellect), {item:274756} 5g 84s (Agility, Stamina, frost resistance), {item:274757} 4g 68s (Agility, attack power), {item:274758}, a chest, 10g 96s (Strength, Stamina). Honored, three trinkets at about 7g 55s: {item:274759} (nature resistance), {item:274760} (frost resistance) and {item:274761} (shadow resistance), the last two with a use. Revered: {item:274024}, 25g."] = "{npc:265577}，{faction:577} 的军需官。友善，50级装备：{item:274755} 3金币10银币（精神、智力）、{item:274756} 5金币84银币（敏捷、耐力、冰霜抗性）、{item:274757} 4金币68银币（敏捷、攻击强度）、胸甲 {item:274758} 10金币96银币（力量、耐力）。尊敬，三件饰品各约7金币55银币：{item:274759}（自然抗性）、{item:274760}（冰霜抗性）和 {item:274761}（暗影抗性），后两件带有使用效果。崇敬：{item:274024}，25金币。",
	-- {item:274755} Steamwheedle Grips
	["{item:274755}, Friendly"] = "{item:274755}，友善",
	-- {item:274756} Impractical Headwarmer
	["{item:274756}, Friendly"] = "{item:274756}，友善",
	-- {item:274757} Substandard Belt Chain
	["{item:274757}, Friendly"] = "{item:274757}，友善",
	-- {item:274758} Coldmetal Guard
	["{item:274758}, Friendly"] = "{item:274758}，友善",
	-- {item:274759} Everlook Pathcarver
	["{item:274759}, Honored"] = "{item:274759}，尊敬",
	-- {item:274760} Everlook Delivery Bot
	["{item:274760}, Honored"] = "{item:274760}，尊敬",
	-- {item:274761} Parachute-Priest Pager
	["{item:274761}, Honored"] = "{item:274761}，尊敬",
	-- {item:274024} Fizzbolt's Fashionable Fedora
	["{item:274024}, Revered"] = "{item:274024}，崇敬",

	-- Step 17: Powderfuse: Friz Frazzlespark
	-- {npc:255897} Friz Frazzlespark · {faction:2827} Powderfuse · {area:16727} Powderfuse Port · {zone:2548} Riverglades · {item:276200} Crawler's Clackers · {item:276201} Misplaced Pantaloons · {item:276202} Disengagement Ring · {item:276203} Primitive Fishing Pole · {item:276204} Thrash's Trash · {item:276199} Haughty Fellow's Monocle
	["{npc:255897} sells {faction:2827}'s rewards in {area:16727}, on the east coast of the {zone:2548}, alongside general goods. Friendly, level 40 gear: {item:276200} 2g 74s (Stamina, attack power), {item:276201} 2g 94s (Intellect, Spirit), {item:276202} 2g 36s (Agility, Spirit). Honored: {item:276203}, a two-handed weapon, 9g 46s (Stamina, Strength, Agility); {item:276204}, a shield, 3g 80s (Stamina, spell damage, healing). Revered: {item:276199}, 10g."] = "{npc:255897}在{zone:2548}东海岸的{area:16727}出售{faction:2827}奖励，也出售杂货。友善，40级装备：{item:276200}，2金74银（耐力、攻击强度）；{item:276201}，2金94银（智力、精神）；{item:276202}，2金36银（敏捷、精神）。尊敬：{item:276203}，双手武器，9金46银（耐力、力量、敏捷）；{item:276204}，盾牌，3金80银（耐力、法术伤害、治疗）。崇敬：{item:276199}，10金币。",
	-- {item:276200} Crawler's Clackers
	["{item:276200}, Friendly"] = "{item:276200}，友善",
	-- {item:276201} Misplaced Pantaloons
	["{item:276201}, Friendly"] = "{item:276201}，友善",
	-- {item:276202} Disengagement Ring
	["{item:276202}, Friendly"] = "{item:276202}，友善",
	-- {item:276203} Primitive Fishing Pole
	["{item:276203}, Honored"] = "{item:276203}，尊敬",
	-- {item:276204} Thrash's Trash
	["{item:276204}, Honored"] = "{item:276204}，尊敬",
	-- {item:276199} Haughty Fellow's Monocle
	["{item:276199}, Revered"] = "{item:276199}，崇敬",

	-- Step 18: Every town to Exalted
	["Every town to Exalted"] = "将所有城镇声望提升到崇拜。",
	-- {npc:14637} Zorbin Fandazzle
	["Revered to Exalted is 21,000 more with each town: 840 of {npc:14637}'s turn-ins or 140 Free Knot runs. No quartermaster sells anything for Exalted: this is for the title bar only."] = "每座城镇从崇敬到崇拜还需要21,000：交还{npc:14637}的任务840次，或解救诺特140趟。没有军需官出售要求崇拜的商品：只为声望栏上的等级。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Five goblin towns share one reputation family, the Steamwheedle Cartel: {faction:470}, {faction:21}, {faction:369}, {faction:577} and Forever's new {faction:2827} in the {zone:2548}. Everyone starts each at Neutral (500 into it). A gain with one town gives the others half as much; a quest for the Cartel itself, like {npc:14637}'s, pays every town in full. Losses spread the same way: a {npc:4624} or any goblin of the towns costs 125 (half that with the other towns), and Bloodsail Buccaneers reputation is earned only that way. {npc:14637} camps on the road through central {zone:1444} and works for anyone, even players the goblins hate. His first two quests are level 48: in Classic they paid less once you were 6 or more levels above them (a fifth at 57 and up), but they open his repeatables, which are level 55 and pay in full at 60."] = "五座地精城镇属于同一声望体系——热砂港：{faction:470}、{faction:21}、{faction:369}、{faction:577}，以及无限新增的、位于 {zone:2548} 的 {faction:2827}。所有角色在各城镇的初始声望均为中立（已积累 500 点）。提升一座城镇的声望，会让其他城镇各获得一半；直接为热砂港服务的任务，例如 {npc:14637} 的任务，则会向每座城镇提供全额声望。声望损失也按同样方式传递：击杀一个 {npc:4624} 或任意城镇地精，会损失 125 点声望（其他城镇各损失一半），血帆海盗声望只能通过这种方式获取。{npc:14637} 驻扎在穿过 {zone:1444} 中部的道路旁，愿意为任何人提供任务，即使地精对你仇恨也一样。他最初两个任务为 48 级：在经典旧世中，当你的等级比任务高至少 6 级时，声望奖励会减少（57 级及以上降至五分之一），但它们会解锁 55 级的可重复任务，这些任务在 60 级仍提供全额声望。",
	-- ["Neutral 500 to Friendly is 2,500 with each town. The quests above pay every town up to 700 ({npc:14637}'s two 300, {npc:10267}'s 150, the first Free Knot 150 and the first Ogre Suit 100; less when you are well above their level); {npc:14637}'s repeatables do the rest, 25 to every town each: 10 residue (ten giants) or 6 cores (about twelve elementals). The towns' own quests count too, each giving the other towns half: {faction:470}'s in the {zone:1413} (levels 10-25, about 4,300: the Samophlange chain 625, {npc:3446}'s errands, the Wizzlecrank and Gilthares escorts 150 each), {faction:21}'s in Stranglethorn, Arathi and the {zone:1418} (30-50, about 6,500: the three OOX robot rescues 250 each, An OOX of Your Own 200, Stranglethorn Fever 200, Facing Negolash 200, the Sunken Treasure chain at {area:327}), {faction:369}'s in {zone:1446} (43-55, about 3,000: the {item:8548} 200, Wastewander Justice 100 each, the WANTED posters) and {faction:577}'s in {zone:1452} (52-60, about 1,450: {npc:9298}'s Winterfall chain, Umi's yeti quests). Forever adds a few low ones: A Simmering Storm and Stormy Potential in {zone:1411} and WANTED: Bruuz ({faction:470} 100 each), Important Heirlooms in {zone:1455} ({faction:369} 100). In Classic they pay in full only while at most 5 levels below you; past that each level takes a fifth off, down to a fifth. Kills help while they are not grey, 5 each: Southsea pirates in the {zone:1413} for {faction:470} and in {zone:1446} for {faction:369} and Stranglethorn's Venture Co. camps for {faction:21}, up to the end of Honored; Wastewander bandits for {faction:369} and Bloodsail pirates for {faction:21} only up to the end of Neutral. Friendly opens each quartermaster's first gear."] = "每座城镇从中立500到友善都需要2,500声望。上面的任务最多给每座城镇700（{npc:14637} 的两个任务共300、{npc:10267} 的任务150、首次解救诺特150、首次食人魔装束100；若你的等级远高于任务等级，收益会减少）；剩下靠 {npc:14637} 的重复任务，每次给每座城镇25：交10份残留物（十只巨人）或6个核心（约十二只元素）。各城镇自己的任务也算，其他城镇获得一半声望：{faction:470} 在 {zone:1413} 的任务（10—25级，约4,300：什么什么平衡器 任务链625、{npc:3446} 的差事、维兹克兰克 和基尔萨瑞斯·火枝的护送各150）；{faction:21} 在荆棘谷、阿拉希和 {zone:1418} 的任务（30—50级，约6,500：三次OOX机器人营救各250、“你自己的OOX”200、“荆棘谷热疫”200、“挑战奈古拉什”200，以及 {area:327} 的“水下宝藏”任务链）；{faction:369} 在 {zone:1446} 的任务（43—55级，约3,000：{item:8548} 200、“废土的公正”各100，以及通缉告示）；{faction:577} 在 {zone:1452} 的任务（52—60级，约1,450：{npc:9298} 的冬泉熊怪任务链、乌米的雪人任务）。无限服还新增了几个低等级任务：{zone:1411} 的“酝酿中的风暴”和“风暴潜能”，以及“通缉：布鲁兹”（各给 {faction:470} 100），“重要的传家宝”在 {zone:1455}（{faction:369} 100）。在经典旧世中，任务最多低于你5级才给全额；超过后每低一级减少五分之一，最低为五分之一。怪物尚未变灰时，击杀也有帮助，每只5点：{zone:1413} 的南海海盗给 {faction:470}、{zone:1446} 的南海海盗给 {faction:369}、荆棘谷的风险投资公司营地给 {faction:21}，都可持续到尊敬上限；废土强盗给 {faction:369}、血帆海盗给 {faction:21}，都只到中立上限。友善后可购买各军需官的首批装备。",
}
