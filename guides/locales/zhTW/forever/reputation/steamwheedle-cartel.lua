-- Chinese (traditional) (zhTW): the guide forever/reputation/steamwheedle-cartel (forever/reputation/steamwheedle-cartel.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Steamwheedle Cartel Reputation"] = "熱砂港聲望",
	-- {npc:14637} Zorbin Fandazzle · {npc:14338} Knot Thimblejack
	["Every goblin town at once: {npc:14637}'s zapped giants and {npc:14338}'s shackles, then five new quartermasters and their hats."] = "所有地精城鎮同時提升：{npc:14637}的電擊巨人和{npc:14338}的鐐銬，然後是五位新軍需官和他們的帽子。",
	["Forever's goblin quartermasters: gear for levels 20 to 50 at Friendly and Honored"] = "Forever的地精軍需官：友善和尊敬聲望下的20到50級裝備",

	-- Step 1: Zorbin Fandazzle
	-- {faction:470} Ratchet · {faction:21} Booty Bay · {faction:369} Gadgetzan · {faction:577} Everlook · {faction:2827} Powderfuse · {zone:2548} Riverglades · {npc:14637} Zorbin Fandazzle · {npc:4624} Booty Bay Bruiser · {zone:1444} Feralas
	["Five goblin towns share one reputation family, the Steamwheedle Cartel: {faction:470}, {faction:21}, {faction:369}, {faction:577} and Forever's new {faction:2827} in the {zone:2548}. Everyone starts each at Neutral (500 into it). A gain with one town gives the others half as much; a quest for the Cartel itself, like {npc:14637}'s, pays every town in full. Losses spread the same way: a {npc:4624} or any goblin of the towns costs 125 (half that with the other towns), and Bloodsail Buccaneers reputation is earned only that way. {npc:14637} camps on the road through central {zone:1444} and works for anyone, even players the goblins hate. His first two quests are level 48 and open his repeatables (level 55); Forever pays all of them in full at any level."] = "五個地精鎮子共用一個聲望體系，熱砂港：{faction:470}、{faction:21}、{faction:369}、{faction:577}和 Forever 在{zone:2548}新增的{faction:2827}。每個都是從中立開始（已入500）。在一個鎮子獲得聲望，其他鎮子得一半；直接給熱砂港的任務（比如{npc:14637}的）給每個鎮子足額。扣聲望也一樣分攤：殺一個{npc:4624}或鎮上的任何地精扣125（其他鎮子扣一半），血帆海盜的聲望只能這樣獲得。{npc:14637}在穿過{zone:1444}中部的路邊紮營，為任何人幹活，哪怕是地精痛恨的玩家。他頭兩個任務是48級，之後開放他的可重複任務（55級）；Forever 裡這些都任何等級足額給分。",
	-- {quest:7003} Zapped Giants
	["{quest:7003}: 150 to every town"] = "{quest:7003}：每座城鎮150",
	-- {quest:7721} Fuel for the Zapping
	["{quest:7721}: 150 to every town"] = "{quest:7721}：每座城鎮150",

	-- Step 2: Zapped giants
	["Zapped giants"] = "被縮小的巨人",
	-- {item:18904} Zorbin's Ultra-Shrinker · {npc:5357} Land Walker · {npc:5358} Cliff Giant · {npc:5361} Wave Strider · {item:18956} Miniaturization Residue
	-- plural, as words: Land Walkers = {npc:5357} Land Walker · Cliff Giants = {npc:5358} Cliff Giant
	["Use {item:18904} on a living giant ({npc:5357}, {npc:5358}, or a Shore, Deep or {npc:5361}, level 47-50) and it shrinks into a zapped version; kill that for its {item:18956}, one every time. The Land Walkers and Cliff Giants in the north-west hills are the thickest; the striders walk the coast and the shallows. The shrinker lasts two hours: if it runs out, abandon the quest and take it again."] = "對一隻活著的巨人使用{item:18904}（{npc:5357}、{npc:5358}，或海岸巨人、深海巨人、{npc:5361}，47-50級），它就會縮小成被電的版本；殺掉它拿{item:18956}，每次一個。西北丘陵的陸地行者和峭壁巨人最密集；涉行者則沿海岸和淺灘行走。縮小器持續兩小時：如果效果消失，就放棄任務重新接取。",
	-- {item:18904} Zorbin's Ultra-Shrinker
	["{item:18904}, on a living giant"] = "{item:18904}，對活著的巨人使用",
	-- {item:18956} Miniaturization Residue
	["{item:18956}, from the zapped giants"] = "{item:18956}，來自被電的巨人",

	-- Step 3: Sea Elementals and Sea Sprays
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["Sea Elementals and Sea Sprays"] = "海元素和海之飛濺",
	-- {area:1108} Forgotten Coast · {item:18958} Water Elemental Core
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["The Sea Elementals and Sea Sprays (level 47-49) drift along the {area:1108} and in the shallows below the giants: about half drop a {item:18958}."] = "海元素和海之飛濺（47-49級）沿著{area:1108}以及巨人們下方的淺灘漂游：約半數掉落一個{item:18958}。",
	-- {item:18958} Water Elemental Core
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["{item:18958}: Sea Elementals and Sea Sprays"] = "{item:18958}：海元素和海之飛濺",

	-- Step 4: Back to Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle
	["Back to {npc:14637}"] = "返回{npc:14637}",
	-- {npc:14637} Zorbin Fandazzle · {quest:7725} Again With the Zapped Giants · {quest:7726} Refuel for the Zapping
	["From now on {npc:14637} offers {quest:7725} (10 residue) and {quest:7726} (6 cores), again and again: 25 reputation with every town each time."] = "從此以後，{npc:14637}會反覆提供{quest:7725}（10個殘渣）和{quest:7726}（6個核心）：每次每座城鎮25點聲望。",

	-- Step 5: Lost Rigger Cove, below 56
	-- {area:1336} Lost Rigger Cove
	["{area:1336}, below 56"] = "{area:1336}，56級以下",
	-- {area:1336} Lost Rigger Cove · {zone:1446} Tanaris · {faction:369} Gadgetzan · {area:977} Steamwheedle Port · {quest:8366} Southsea Shakedown · {quest:8365} Pirate Hats Ahoy!
	-- plural, as words: Southsea Pirate Hats = {item:20519} Southsea Pirate Hat
	["The Southsea pirates of {area:1336} (level 44-45) on the east coast of {zone:1446} give {faction:369} 5 each up to the end of Honored, and the other towns half. Two quests at {area:977} pay 100 {faction:369} each: {quest:8366} (10 of each pirate) and {quest:8365} (20 Southsea Pirate Hats, one in ten pirates). From level 56 the pirates are grey and pay little: skip this step then."] = "位於{zone:1446}東海岸{area:1336}的南海海盜（44-45級）每隻給{faction:369} 5點，直到尊敬滿，其他城鎮減半。{area:977}的兩個任務各給{faction:369} 100點：{quest:8366}（每種海盜各10個）和{quest:8365}（20頂南海海盜帽，約十隻海盜掉一頂）。56級起這些海盜變灰，收益很少：屆時跳過本步驟。",

	-- Step 6: Tinkee Steamboil
	-- {npc:10267} Tinkee Steamboil · {area:251} Flame Crest · {zone:1428} Burning Steppes · {faction:577} Everlook · {item:12284} Draco-Incarcinatrix 900 · {quest:4726} Broodling Essence
	-- plural, as words: Scalding Broodlings = {npc:7048} Scalding Broodling · Flamescale Broodlings = {npc:7049} Flamescale Broodling · Black Broodlings = {npc:7047} Black Broodling
	["{npc:10267}, a goblin at {area:251} in the north of the {zone:1428}, has a chain that pays every town 150 and {faction:577} 150 more. Use her {item:12284} on a broodling, kill it while the device holds it, and pick up the {quest:4726} it leaves. The device takes only Black and Scalding Broodlings, not the Flamescale Broodlings of the west: Scalding Broodlings (level 53-54) roam just west and east of {area:251}, Black Broodlings (51-52) the north-east corner of the zone, the thickest group. They are few and spread out: the path passes both and ends among the Black Broodlings."] = "{npc:10267}是{zone:1428}北部{area:251}的一名地精，她的任務鏈讓每座城鎮得到150點，{faction:577}再多150點。對一隻雛龍使用她的{item:12284}，在裝置控制住它時將其擊殺，然後拾取它留下的{quest:4726}。裝置只對黑色雛龍和灼熱雛龍有效，對西邊的焰鱗雛龍無效：灼熱雛龍（53-54級）在{area:251}正西和正東遊蕩，黑色雛龍（51-52級）在該區域東北角，是最密集的一群。它們數量少且分散：路線會經過兩者，最後在黑色雛龍群中結束。",
	-- {area:251} Flame Crest
	-- plural, as words: Scalding Broodlings = {npc:7048} Scalding Broodling
	["Scalding Broodlings west of {area:251}"] = "{area:251}以西的灼熱雛龍",
	-- {area:251} Flame Crest
	-- plural, as words: Scalding Broodlings = {npc:7048} Scalding Broodling
	["Scalding Broodlings east of {area:251}"] = "{area:251}以東的灼熱雛龍",
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["Black Broodlings in the north-east"] = "東北方的黑色雛龍",
	-- {item:12284} Draco-Incarcinatrix 900 · {npc:7048} Scalding Broodling
	["{item:12284}, on a Black or {npc:7048}"] = "{item:12284}，對黑色雛龍或{npc:7048}使用",
	-- {quest:4726} Broodling Essence
	["{quest:4726}, left by the broodlings"] = "{quest:4726}，由雛龍留下",
	["100 to every town"] = "每座城鎮100",

	-- Step 7: Everlook: Felnok Steelspring
	-- {quest:4808} Felnok Steelspring · {faction:577} Everlook
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["{quest:4808} is in {faction:577}. The Chillwind Chimaeras (level 55-57) south-west of {faction:577} drop the horns one time in five."] = "{quest:4808}在{faction:577}。{faction:577}西南的寒風奇美拉（55-57級）約五次掉落一隻角。",
	-- {item:12444} Uncracked Chillwind Horn
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["{item:12444}: Chillwind Chimaeras"] = "{item:12444}：寒風奇美拉",

	-- Step 8: Back to Tinkee Steamboil
	-- {npc:10267} Tinkee Steamboil
	["Back to {npc:10267}"] = "返回{npc:10267}",
	-- {quest:4810} Return to Tinkee
	["{quest:4810} gives 50 to every town. Her later quests, Egg Freezing (150 to every town) and Egg Collection (200), are done in the Rookery of Upper Blackrock Spire, a ten-player dungeon: take them up with your group."] = "",

	-- Step 9: Dire Maul North: Knot Thimblejack
	-- {npc:14338} Knot Thimblejack
	["Dire Maul North: {npc:14338}"] = "厄運之槌北區：{npc:14338}",
	-- {npc:14338} Knot Thimblejack · {item:18250} Gordok Shackle Key · {npc:14321} Guard Fengus · {item:18258} Gordok Ogre Suit · {item:8170} Rugged Leather · {item:14341} Rune Thread · {item:18240} Ogre Tannin
	["{npc:14338} sits shackled in Dire Maul North, the Gordok ogres' wing (a five-player dungeon from level 57: group up). Every {item:18250} frees him once: 150 to every town, and he is shackled again on your next run. Gordok ogres drop the keys (about one in fifteen; {npc:14321} one in seven): a full run of the wing usually brings one. His {item:18258} pays 100 the first time and 50 after, for 4 Bolts of Runecloth, 8 {item:8170}, 2 {item:14341} and the {item:18240} from the basket in the wing. Under 57 when you get here? Unskip this step later."] = "",
	-- {item:18250} Gordok Shackle Key
	["{item:18250}, Gordok ogres"] = "{item:18250}，戈多克食人魔",
	-- {quest:5525} Free Knot! · {npc:14338} Knot Thimblejack
	["{quest:5525}: 150 to every town, handed in from {npc:14338}'s window"] = "{quest:5525}：每座城鎮150點聲望，在{npc:14338}的視窗中直接繳交",
	-- {quest:5525} Free Knot!
	["{quest:5525}, again on every later run: 150"] = "{quest:5525}，之後每趟再來一次：150",

	-- Step 10: Every town to Friendly
	["Every town to Friendly"] = "每座城鎮到友善",
	-- {npc:14637} Zorbin Fandazzle · {npc:10267} Tinkee Steamboil · {faction:470} Ratchet · {zone:1413} Barrens · {npc:3446} Mebok Mizzyrix · {faction:21} Booty Bay · {zone:1418} Badlands · {area:327} Faldir's Cove · {faction:369} Gadgetzan · {zone:1446} Tanaris · {item:8548} Divino-matic Rod · {faction:577} Everlook · {zone:1452} Winterspring · {npc:9298} Donova Snowden · {zone:1411} Durotar · {zone:1455} Ironforge
	["Neutral 500 to Friendly is 2,500 with each town. The quests above pay every town up to 700 ({npc:14637}'s two 300, {npc:10267}'s 150, the first Free Knot 150 and the first Ogre Suit 100); {npc:14637}'s repeatables do the rest, 25 to every town each: 10 residue (ten giants) or 6 cores (about twelve elementals). The towns' own quests count too, each giving the other towns half: {faction:470}'s in the {zone:1413} (levels 10-25, about 4,300: the Samophlange chain 625, {npc:3446}'s errands, the Wizzlecrank and Gilthares escorts 150 each), {faction:21}'s in Stranglethorn, Arathi and the {zone:1418} (30-50, about 6,500: the three OOX robot rescues 250 each, An OOX of Your Own 200, Stranglethorn Fever 200, Facing Negolash 200, the Sunken Treasure chain at {area:327}), {faction:369}'s in {zone:1446} (43-55, about 3,000: the {item:8548} 200, Wastewander Justice 100 each, the WANTED posters) and {faction:577}'s in {zone:1452} (52-60, about 1,450: {npc:9298}'s Winterfall chain, Umi's yeti quests). Forever adds a few low ones: A Simmering Storm and Stormy Potential in {zone:1411} and WANTED: Bruuz ({faction:470} 100 each), Important Heirlooms in {zone:1455} ({faction:369} 100). Forever pays them in full at any level. Kills help while they are not grey, 5 each: Southsea pirates in the {zone:1413} for {faction:470} and in {zone:1446} for {faction:369} and Stranglethorn's Venture Co. camps for {faction:21}, up to the end of Honored; Wastewander bandits for {faction:369} and Bloodsail pirates for {faction:21} only up to the end of Neutral. Friendly opens each quartermaster's first gear."] = "中立 500 到友善要每個鎮子2,500點。上面的任務給每個鎮子最多700（{npc:14637}的兩個300、{npc:10267}的150、第一個“自由的結”150、第一件食人魔套裝100）；剩下的靠{npc:14637}的可重複任務，每個鎮子每次25點：10份殘渣（十個巨人）或6個核心（約十二個元素）。各鎮子自己的任務也算，每個給其他鎮子一半：{faction:470}在{zone:1413}的任務（10-25級，約4,300：薩莫弗萊格鏈625、{npc:3446}的差事、維茲克蘭克和吉爾薩雷斯護送各150），{faction:21}在荊棘谷、阿拉希和{zone:1418}的任務（30-50級，約6,500：三次 OOX 機器人營救各250、“你自己的 OOX”200、“荊棘谷熱病”200、“直面尼格拉什”200、{area:327}的沉沒寶藏鏈），{faction:369}在{zone:1446}的任務（43-55級，約3,000：{item:8548} 200、荒地正義各100、通緝佈告）和{faction:577}在{zone:1452}的任務（52-60級，約1,450：{npc:9298}的冬泉鏈、烏米的雪人任務）。Forever 還加了幾個低階的：{zone:1411}的“醞釀中的風暴”和“風暴潛能”、通緝：布魯茲（{faction:470}各100），{zone:1455}的“重要的傳家寶”（{faction:369} 100）。Forever 裡它們任何等級都足額給。擊殺在怪還不是灰色時也算，每個5點：{zone:1413}的南海海盜給{faction:470}、{zone:1446}的給{faction:369}、荊棘谷的風險投資公司營地給{faction:21}，最多算到崇敬結束；{faction:369}的荒地土匪和{faction:21}的血帆海盜只算到中立結束。友善後開放各軍需官的第一批裝備。",
	-- {quest:7725} Again With the Zapped Giants
	["{quest:7725}: 10 residue"] = "{quest:7725}：10個殘渣",
	["25 to every town"] = "每座城鎮25",
	-- {quest:7726} Refuel for the Zapping
	["{quest:7726}: 6 cores"] = "{quest:7726}：6個核心",

	-- Step 11: Every town to Honored
	["Every town to Honored"] = "每座城鎮到尊敬",
	-- {npc:14637} Zorbin Fandazzle · {item:18250} Gordok Shackle Key
	["Friendly to Honored is 6,000: 240 of {npc:14637}'s turn-ins, or 40 Free Knot runs, or a mix. Nothing can be saved up: residue and cores drop only while their quest is in your log, and you can carry one {item:18250} at a time, so hand each in before the next run. Honored opens each quartermaster's blue items."] = "友善到尊敬需要6,000點：240次{npc:14637}的上交，或40趟“解救諾特”，也可以混合。無法提前囤積：殘渣和核心只在該任務在你的日誌中時才會掉落，而且你一次只能攜帶一個{item:18250}，所以每趟都要先把上一個交掉。尊敬會開放各軍需官的藍色裝備。",

	-- Step 12: Every town to Revered
	["Every town to Revered"] = "每座城鎮到崇敬",
	-- {npc:14637} Zorbin Fandazzle
	["Honored to Revered is 12,000 more: 480 of {npc:14637}'s turn-ins (4,800 residue) or 80 Free Knot runs. Revered opens the five cosmetic hats, the reason most players do this. Legacy Diplomat adds up to 10%."] = "尊敬到崇敬還需12,000點：480次{npc:14637}的上交（4,800個殘渣）或80趟“解救諾特”。崇敬會開放五頂裝飾用帽子，多數玩家就是為此而來。傳承專長“外交家”最多額外增加10%。",

	-- Step 13: Ratchet: Winklespark
	-- {npc:265574} Winklespark · {faction:470} Ratchet · {item:274740} Quilted Cloak · {item:274741} Rumpled Kilt · {item:274742} Ratchet Wristwraps · {item:274743} Defective Samophlange · {item:274744} Barrens Basher · {item:274021} Barrens Headband
	["{npc:265574}, {faction:470}'s quartermaster, by the docks. Friendly, level 20 gear: {item:274740} 41s (Stamina, Agility), {item:274741} 54s (Stamina, spell power), {item:274742} 34s (Intellect, Agility). Honored: {item:274743}, an off-hand, 66s (Intellect, Spirit); {item:274744}, a one-handed mace, 1g 65s (Stamina, Strength). Revered: the {item:274021}, a cosmetic hat, 2g."] = "{npc:265574}是{faction:470}的軍需官，在碼頭旁。友善，20級裝備：{item:274740} 41銀（耐力、敏捷），{item:274741} 54銀（耐力、法術強度），{item:274742} 34銀（智力、敏捷）。尊敬：{item:274743}，副手物品，66銀（智力、精神）；{item:274744}，單手錘，1金65銀（耐力、力量）。崇敬：{item:274021}，裝飾用帽子，2金。",
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
	["{npc:265575}, {faction:21}'s quartermaster. Friendly, level 30 gear: {item:274745} 1g 10s (Strength, Agility), {item:274746} 1g 48s (healing and spell damage), {item:274747} 1g 3s (Intellect, Spirit). Honored: {item:274748}, a gun, 3g 11s (attack power, Stamina); {item:274749}, a necklace, 1g 66s (health regeneration, Stamina). Revered: {item:274022}, 5g."] = "{npc:265575}是{faction:21}的軍需官。友善，30級裝備：{item:274745} 1金10銀（力量、敏捷），{item:274746} 1金48銀（治療和法術傷害），{item:274747} 1金3銀（智力、精神）。尊敬：{item:274748}，槍，3金11銀（攻擊強度、耐力）；{item:274749}，項鍊，1金66銀（生命回覆、耐力）。崇敬：{item:274022}，5金。",
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
	["{npc:265576}, {faction:369}'s quartermaster. Friendly, level 40 gear: {item:274750} 2g 74s (Intellect, healing, spell damage), {item:274751} 2g 94s (Agility, attack power), {item:274752}, a cloak, 2g 36s (Spirit, spell power). Honored: {item:274753}, a one-handed weapon, 9g 46s (Strength, Agility); {item:274754}, a ring, 3g 80s (Strength, Stamina). Revered: the {item:274023}, 10g."] = "{npc:265576}是{faction:369}的軍需官。友善，40級裝備：{item:274750} 2金74銀（智力、治療、法術傷害），{item:274751} 2金94銀（敏捷、攻擊強度），{item:274752}，披風，2金36銀（精神、法術強度）。尊敬：{item:274753}，單手武器，9金46銀（力量、敏捷）；{item:274754}，戒指，3金80銀（力量、耐力）。崇敬：{item:274023}，10金。",
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
	["{npc:265577}, {faction:577}'s quartermaster. Friendly, level 50 gear: {item:274755} 3g 10s (Spirit, Intellect), {item:274756} 5g 84s (Agility, Stamina, frost resistance), {item:274757} 4g 68s (Agility, attack power), {item:274758}, a chest, 10g 96s (Strength, Stamina). Honored, three trinkets at about 7g 55s: {item:274759} (nature resistance), {item:274760} (frost resistance) and {item:274761} (shadow resistance), the last two with a use. Revered: {item:274024}, 25g."] = "{npc:265577}是{faction:577}的軍需官。友善，50級裝備：{item:274755} 3金10銀（精神、智力），{item:274756} 5金84銀（敏捷、耐力、冰霜抗性），{item:274757} 4金68銀（敏捷、攻擊強度），{item:274758}，胸甲，10金96銀（力量、耐力）。尊敬：三件飾品約7金55銀：{item:274759}（自然抗性）、{item:274760}（冰霜抗性）和{item:274761}（暗影抗性），後兩件帶使用效果。崇敬：{item:274024}，25金。",
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
	["{npc:255897} sells {faction:2827}'s rewards in {area:16727}, on the east coast of the {zone:2548}, alongside general goods. Friendly, level 40 gear: {item:276200} 2g 74s (Stamina, attack power), {item:276201} 2g 94s (Intellect, Spirit), {item:276202} 2g 36s (Agility, Spirit). Honored: {item:276203}, a two-handed weapon, 9g 46s (Stamina, Strength, Agility); {item:276204}, a shield, 3g 80s (Stamina, spell damage, healing). Revered: {item:276199}, 10g."] = "{npc:255897}在{zone:2548}東海岸的{area:16727}出售{faction:2827}的獎勵，就在雜貨旁邊。友善，40級裝備：{item:276200} 2金74銀（耐力、攻擊強度），{item:276201} 2金94銀（智力、精神），{item:276202} 2金36銀（敏捷、精神）。尊敬：{item:276203}，雙手武器，9金46銀（耐力、力量、敏捷）；{item:276204}，盾牌，3金80銀（耐力、法術傷害、治療）。崇敬：{item:276199}，10金。",
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
	["Every town to Exalted"] = "每座城鎮到崇拜",
	-- {npc:14637} Zorbin Fandazzle
	["Revered to Exalted is 21,000 more with each town: 840 of {npc:14637}'s turn-ins or 140 Free Knot runs. No quartermaster sells anything for Exalted: this is for the title bar only."] = "崇敬到崇拜每座城鎮還需21,000點：840次{npc:14637}的上交或140趟“解救諾特”。沒有軍需官在崇拜時出售任何東西：這純粹是為了頭銜欄。",
}
