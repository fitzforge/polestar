-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/alliance/paladin-charger (forever/collectibles/mounts/alliance/paladin-charger.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Paladin Charger"] = "圣骑士军马",
	["Your epic mount at 60, summoned at will: the faster step up from the Warhorse."] = "60级的史诗坐骑，可随时召唤：比战马更快的升级。",

	-- Step 1: Lord Grayson Shadowbreaker (Ironforge)
	-- {npc:5149} Brandur Ironhammer · {object:32362} Mystic Ward · {quest:7638} Lord Grayson Shadowbreaker · {zone:1453} Stormwind
	["At 60 {npc:5149} in the {object:32362} sends you to {quest:7638} in {zone:1453}'s Cathedral of Light."] = "60级时，{object:32362}的{npc:5149}会让你去找{zone:1453}光明大教堂的{quest:7638}。",

	-- Step 2: Lord Grayson Shadowbreaker
	-- {spell:23214} Summon Charger · {area:2279} Stratholme · {area:2057} Scholomance · {item:14047} Runecloth · {item:8836} Arthas' Tears · {npc:6171} Duthorian Rall
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["The {spell:23214} chain is long: {area:2279}, Dire Maul West and {area:2057} with a group, 350 gold in donations, and materials worth several hundred more (6 Arcanite Bars, 40 {item:14047}, 10 {item:8836}, two diamonds). Start saving early. Lord Grayson stands in the Cathedral of Light, {npc:6171} nearby."] = "{spell:23214} 任务线很长：需要组队前往 {area:2279}、厄运之槌西区和 {area:2057}，捐赠350金币，还要准备价值数百金币的材料（6块奥金锭、40块 {item:14047}、10株 {item:8836} 和两颗钻石）。尽早开始攒钱。格雷森公爵在圣光大教堂，{npc:6171} 就在附近。",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}, Cathedral of Light"] = "{npc:6171}，光明大教堂",

	-- Step 3: High Priest Rohan
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries · {zone:1455} Ironforge · {object:32362} Mystic Ward
	["{npc:11406}, the priest trainer, walks about the {object:32386} in {zone:1455}'s {object:32362}. He gives you his censer for a donation of 150 gold, taken at the hand-in. Keep the censer."] = "牧师训练师{npc:11406}在{zone:1455}的{object:32362}内的{object:32386}走动。捐赠150金币即可获得他的香炉，金币会在交还任务时扣除。请保留香炉。",
	-- {npc:11406} High Priest Rohan
	["{npc:11406}: 150 gold"] = "{npc:11406}：150金",

	-- Step 4: Back to Lord Grayson
	["Back to Lord Grayson"] = "回到格雷森·沙东布瑞克公爵处",
	-- {item:18752} Exorcism Censer · {area:2627} Terrordale
	["Lord Grayson blesses the censer into the {item:18752} for {area:2627}."] = "格雷森公爵会将香炉祝福为用于 {area:2627} 的 {item:18752}。",

	-- Step 5: Exorcising Terrordale
	-- {area:2627} Terrordale · {zone:1423} Eastern Plaguelands · {area:2279} Stratholme · {object:179747} Terrordale Haunting Spirit (no name in this language: may be words) · {item:18752} Exorcism Censer · {spell:7713} Wailing Dead · {spell:2878} Turn Undead
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit
	["{area:2627} lies in the far north-west of the {zone:1423}, west of the {area:2279} gates. Stand inside a green glowing patch on the ground (a {object:179747}; some are inside the ruined houses) and use the {item:18752}: up to three Terrordale Spirits (level 59-60) rise and attack. Their {spell:7713} lowers all your stats by 30%: fight them one at a time and use {spell:2878}. The patches come back quickly; several paladins can work side by side."] = "{area:2627}在{zone:1423}最西北端、{area:2279}大门以西。站进地面上一块发绿光的区域（即{object:179747}；有些在废屋内），使用{item:18752}：最多会出现三只恐惧谷的灵魂（59-60级）并攻击你。它们的{spell:7713}会使你的所有属性降低30%：逐个对付，并使用{spell:2878}。绿光区域刷新很快，多位圣骑士可以同时在附近做任务。",
	-- {item:18752} Exorcism Censer
	["{item:18752}, inside a green patch"] = "{item:18752}，在一片绿色区域内",
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit
	["Terrordale Spirits x25"] = "恐惧谷的灵魂 x25",

	-- Step 6: Lord Grayson Shadowbreaker
	["Lord Grayson takes the censer back."] = "格雷森公爵会收回香炉。",

	-- Step 7: Grimand Elmore
	-- {npc:1416} Grimand Elmore · {zone:1453} Stormwind · {object:28027} Dwarven District · {item:18753} Arcanite Barding
	["{npc:1416} works in {zone:1453}'s {object:28027}. He forges the {item:18753} from your materials and 150 gold."] = "{npc:1416} 在 {zone:1453} 的 {object:28027} 工作。他会用你的材料和 150 金币铸造 {item:18753}。",

	-- Step 8: Grimand Elmore's materials
	-- {npc:1416} Grimand Elmore
	["{npc:1416}'s materials"] = "{npc:1416}的材料",
	-- {item:14047} Runecloth · {area:2255} Everlook · {area:2577} Dire Maul · {item:8836} Arthas' Tears · {skill:182} Herbalism · {area:3197} Chillwind Camp · {item:12360} Arcanite Bar · {item:12359} Thorium Bar · {item:12363} Arcane Crystal
	["{item:14047} drops from humanoids of level 50 and up ({area:2255}'s Bruisers, the Scarlet Crusade in the Plaguelands, the {area:2577} ogres). {item:8836} is a Plaguelands herb ({skill:182} 220), common around {area:3197}. An {item:12360} is an alchemist's transmute from a {item:12359} and an {item:12363}, once every two days per alchemist: ask a guild alchemist early, or buy the bars. The Auction House sells all three."] = "50级及以上的人型生物会掉落{item:14047}（{area:2255}的恶棍、瘟疫之地的血色十字军、{area:2577}的食人魔）。{item:8836}是瘟疫之地的草药（需要{skill:182}220），在{area:3197}周围很常见。炼金师用一块{item:12359}和一块{item:12363}转化成一块{item:12360}，每位炼金师每两天只能转化一次：尽早请公会炼金师帮忙，或直接购买锭。拍卖行可买到这三种材料。",
	-- {item:14047} Runecloth
	["{item:14047} x40"] = "{item:14047} × 40",
	-- {item:8836} Arthas' Tears
	["{item:8836} x10"] = "{item:8836} × 10",
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["Arcanite Bars x6: an alchemist, or the Trade District Auction House"] = "奥金锭 x6：找炼金师，或去贸易区拍卖行",

	-- Step 9: Stratholme Holy Water
	-- {area:2279} Stratholme · {zone:1423} Eastern Plaguelands
	-- plural, as words: Stratholme Supply Crates = {object:181085} Stratholme Supply Crate
	["{area:2279} is a dungeon for a group of five at 58-60, at the north end of the {zone:1423}. Stratholme Supply Crates along the streets of both halves hold the Holy Water, one to three each; they come back after three minutes. Some crates let out a swarm of plagued rats or maggots: be ready. The main gate (the Scarlet half) needs no key."] = "{area:2279} 是适合 58-60 级五人小队的地下城，位于 {zone:1423} 最北端。两侧区域街道上的斯坦索姆物资箱都可能装有圣水，每箱一至三瓶；箱子每三分钟刷新。有些箱子会放出一群染疫老鼠或蛆虫：做好准备。正门（血色区一侧）不需要钥匙。",
	-- plural, as words: Stratholme Supply Crates = {object:181085} Stratholme Supply Crate
	["Stratholme Supply Crates, inside"] = "斯坦索姆物资箱，在内部",

	-- Step 10: Grimand Elmore
	-- {npc:1416} Grimand Elmore · {item:18753} Arcanite Barding
	["Bring the materials and 150 gold, taken at the hand-in. {npc:1416} walks to his forge and hands you the {item:18753}."] = "带齐材料和 150 金币，交还任务时会扣除。{npc:1416} 会走到他的熔炉旁，并交给你 {item:18753}。",
	-- {npc:1416} Grimand Elmore
	["{npc:1416}: 150 gold"] = "{npc:1416}：150金",

	-- Step 11: Lord Grayson Shadowbreaker
	["Lord Grayson keeps the barding for now: you get it back with the next quest."] = "格雷森·沙东布瑞克公爵暂时保管马铠：下一个任务会还给你。",
	-- {npc:928} Lord Grayson Shadowbreaker · {item:18753} Arcanite Barding
	["{npc:928}: the {item:18753}"] = "{npc:928}：{item:18753}",

	-- Step 12: Enriched Manna Biscuits
	-- plural, as words: Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Enriched Manna Biscuits"] = "可口的魔法点心",
	-- {object:2160} The Argent Dawn · {object:92525} Argent Dawn · {npc:10857} Argent Quartermaster Lightspark · {area:3197} Chillwind Camp · {npc:11536} Quartermaster Miranda Breechlock · {area:2268} Light's Hope Chapel
	-- plural, as words: Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["{object:2160} quartermasters sell Enriched Manna Biscuits, five for 60 silver, once the {object:92525} is Friendly with you: {npc:10857} at {area:3197} or {npc:11536} at {area:2268}. Scourgestones and the Plaguelands quests raise the standing."] = "当{object:92525}对你的声望达到友善时，{object:2160}的军需官会出售可口的魔法点心，五块60银：可找{area:3197}的{npc:10857}或{area:2268}的{npc:11536}。交还天灾石和完成瘟疫之地任务都能提高声望。",
	-- {npc:10857} Argent Quartermaster Lightspark · {area:3197} Chillwind Camp
	-- plural, as words: Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Enriched Manna Biscuits: {npc:10857}, {area:3197}"] = "可口的魔法点心：{npc:10857}，{area:3197}",

	-- Step 13: Merideth Carlson
	-- {npc:2357} Merideth Carlson · {area:271} Southshore · {quest:7645} Manna-Enriched Horse Feed
	["{npc:2357} breeds horses in {area:271}'s stable. She makes the {quest:7645} from the 20 biscuits and 50 gold, taken at the hand-in."] = "{npc:2357} 在 {area:271} 的马厩饲养马匹。她会用 20 块饼干和 50 金币制作 {quest:7645}，材料和金币会在交还任务时扣除。",

	-- Step 14: Dire Maul: Tendris Warpwood
	-- {area:2577} Dire Maul · {zone:1444} Feralas · {item:18249} Crescent Key · {npc:11489} Tendris Warpwood · {npc:11459} Ironbark Protector · {quest:7643} Ancient Equine Spirit · {item:18753} Arcanite Barding
	["{area:2577} lies in central {zone:1444}. From the gate at the foot of the ruins, walk up through the outer courtyards to the West wing's door at their north end; it needs a {item:18249} (from Pusillin in Dire Maul East) or a rogue's lockpicking. {npc:11489} (level 60 elite) stands at the far end of the West wing's first courtyard. Once attacked he calls every {npc:11459} still alive in the courtyard: kill them first. His death frees the {quest:7643}: talk to it to give it the horse feed and the {item:18753}, and it blesses the barding. A group of five at 60."] = "{area:2577} 位于 {zone:1444} 中部。从废墟脚下的大门沿路向上，穿过外庭院，抵达北端的西区大门；需要 {item:18249}（由厄运之槌东区的普希林掉落）或潜行者开锁。{npc:11489}（60 级精英）站在西区第一个庭院的最深处。他一旦受到攻击，就会召来庭院里所有仍然存活的 {npc:11459}：先清掉它们。他死亡后会释放 {quest:7643}：与它交谈，将马粮和 {item:18753} 交给它，它就会祝福铠甲。需要一支 60 级五人小队。",
	["Dire Maul West's door"] = "厄运之槌西区的大门",
	-- {npc:11489} Tendris Warpwood
	["{npc:11489}, inside the West wing"] = "{npc:11489}，在西区内",

	-- Step 16: Two diamonds
	["Two diamonds"] = "两颗钻石",
	-- {item:12800} Azerothian Diamond · {item:18335} Pristine Black Diamond · {npc:14695} Lord Blackwood
	["An {item:12800} comes from Thorium veins and obsidian, about one vein in a hundred; a {item:18335} drops rarely from elites of level 59 and up (Revanchion and {npc:14695} about one kill in nine and one in a hundred). The Auction House is the usual source of both."] = "{item:12800}来自瑟银矿和黑曜石，约一百个矿点出一个；{item:18335}由59级及以上精英低概率掉落（雷瓦克安约九只出一个，{npc:14695}约一百只出一个）。这两种材料通常都从拍卖行购买。",

	-- Step 17: Lord Grayson Shadowbreaker
	-- {item:18804} Lord Grayson's Satchel · {item:18746} Divination Scryer · {item:18792} Blessed Arcanite Barding
	["Lord Grayson hands you {item:18804}: open it for the {item:18746} and the {item:18792}. Keep both."] = "格雷森公爵会给你 {item:18804}：打开可取得 {item:18746} 和 {item:18792}。两者都要保留。",
	-- {item:18792} Blessed Arcanite Barding
	["{item:18792}, from the satchel"] = "{item:18792}，来自挎包",

	-- Step 18: The Great Ossuary
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:13704} Skeleton Key · {object:179746} The Great Ossuary (no name in this language: may be words) · {item:18746} Divination Scryer · {spell:1105} Seal of Wisdom · {npc:14516} Death Knight Darkreaver · {item:18749} Charger's Lost Soul · {item:18792} Blessed Arcanite Barding · {npc:14568} Darkreaver's Fallen Charger
	["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}; the door needs the {item:13704} (The Key to {area:2057}). Clear the {object:179746}, Rattlegore's room in the basement, then use the {item:18746} at its centre. Four waves of spirits come, each ending with an Aspect: players judge them with {spell:1105}, Justice, Righteousness and then Light, which stuns them. {npc:14516} (level 62 elite) comes after the last; he mind-controls players. Loot the {item:18749}, use it inside the Ossuary to redeem it, and give it and the {item:18792} to {npc:14568}. If the group wipes, the gates lock and the scryer is gone: abandon the quest and take it again from Lord Grayson for a new satchel. A group of five at 60. Again Into the {object:179746}, after the mount, lets you fight him again."] = "{area:2057} 位于 {zone:1422} 东南部岛上城镇 {area:2298} 的地下；开门需要 {item:13704}（通往 {area:2057} 的钥匙）。清空地下室血骨傀儡所在的 {object:179746}，然后在房间中央使用 {item:18746}。随后会来四波幽灵，每波最后都有一个具象：玩家依次用 {spell:1105}、公正、正义和圣光进行审判，可将它们击晕。最后一波结束后，{npc:14516}（62级精英）会出现；他会精神控制玩家。拾取 {item:18749}，在藏骨室内使用以将其救赎，然后将它和 {item:18792} 一起交给 {npc:14568}。如果小队全灭，大门会锁上，占卜器也会消失：放弃任务，再向格雷森公爵重接，以获得新的背包。需要五名60级玩家。获得坐骑后，完成“再次进入{object:179746}”可再次挑战他。",
	-- {item:18749} Charger's Lost Soul · {object:179746} The Great Ossuary (no name in this language: may be words)
	["{item:18749}, inside the {object:179746}"] = "{item:18749}，在 {object:179746} 内",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["An {item:12800} comes from Thorium veins, a {item:18335} from the elites of the {zone:1422}, both rarely: the Auction House is the usual source."] = "{item:12800}来自瑟银矿脉，{item:18335}来自{zone:1422}的精英怪，两者都很少见：通常在拍卖行购买。",
	-- ["Arcanite Bars: the Auction House"] = "奥金锭：拍卖行",
	-- ["Bring 150 gold for {npc:1416} along with the materials."] = "除材料外，还要带150金给{npc:1416}。",
	-- ["Supply Crates, inside"] = "补给箱，在副本内",
	-- ["Terrordale Spirits"] = "{npc:14564}",
	-- ["The {spell:23214} chain is long: it takes you through {area:2279}, {area:2577} and {area:2057}, and costs about 350 gold in donations on top of the materials. Lord Grayson stands in the Cathedral of Light."] = "{spell:23214}任务线很长：要经过{area:2279}、{area:2577}和{area:2057}，除材料外还要捐献约350金。格雷森·沙东布瑞克公爵站在光明大教堂里。",
	-- ["he hands you the {item:18746}"] = "他会交给你{item:18746}",
	-- ["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. Use the {item:18746} in the heart of the {object:179746}'s basement, defeat the spirits it calls and then {npc:14516}, and give his Fallen Charger the {item:18799} and the {item:18792}. All are elite: bring a group. If the attempt fails, Lord Grayson gives you a new scryer through Again Into the {object:179746}."] = "{area:2057}位于{zone:1422}东南部的岛上小镇{area:2298}之下。在尸骨储藏所地下室的中央使用{item:18746}，击败它召来的灵魂，再击败{npc:14516}，然后把{item:18799}和{item:18792}交给达克雷尔的堕落战马。全都是精英：请带上小队。如果失败，格雷森·沙东布瑞克公爵会通过“重回尸骨储藏所”给你一个新的水晶球。",
	-- ["{area:2279} is a group of five, level 58-60, at the north end of the {zone:1423}. The Supply Crates scattered through the city hold the {item:13180}."] = "{area:2279}是58-60级的五人副本，位于{zone:1423}北端。散布在城中的补给箱里装有{item:13180}。",
	-- ["{area:2577} lies in central {zone:1444}; {npc:11489} guards the start of the West wing. Defeat him to free the {quest:7643}, feed it the {item:18775} and hand it the {item:18753} to bless. Bring a group."] = "{area:2577}位于{zone:1444}中部；{npc:11489}守在西区入口处。击败他以解放{quest:7643}，喂它{item:18775}，并把{item:18753}交给它祝福。请带上小队。",
	-- ["{area:2627} lies in the far north-west of the {zone:1423}, by the {zone:1422} border. Use the {item:18752} there to drive out the spirits, then defeat them."] = "{area:2627}位于{zone:1423}最西北端，靠近{zone:1422}边界。在那里使用{item:18752}驱出灵魂，然后击败它们。",
	-- ["{item:14047} drops from humanoids around level 50 and up; {item:8836} is an herb of the Plaguelands and {zone:1448}; Arcanite Bars are an {skill:171} transmute. The Auction House in {zone:1453}'s {object:2096} sells all three, and so do crafters."] = "{item:14047}由约50级及以上的人型生物掉落；{item:8836}是瘟疫之地和{zone:1448}的草药；奥金锭由{skill:171}转化而来。{zone:1453}{object:2096}的拍卖行三样都有售，工匠也会出售。",
	-- ["{npc:11406} is in {zone:1455}'s {object:32362}. Bring 150 gold: the censer is yours for a donation."] = "{npc:11406}在{zone:1455}的{object:32362}。带上150金：捐献后香炉就归你了。",
	-- ["{npc:1416} works in {zone:1453}'s {object:28027}."] = "{npc:1416}在{zone:1453}的{object:28027}工作。",
	-- ["{npc:2357} breeds horses in {area:271}. She also wants 50 gold."] = "{npc:2357}在{area:271}养马。她还要50金。",
	-- ["{object:2160} quartermasters sell the biscuits in fives once the {object:92525} is Friendly with you: {npc:10857} at {area:3197}, {npc:11536} at {area:2268}, {npc:10856} at the {area:813}."] = "与{object:92525}达到友善后，{object:2160}的军需官会以五个一组出售点心：{area:3197}的{npc:10857}、{area:2268}的{npc:11536}、{area:813}的{npc:10856}。",
}
