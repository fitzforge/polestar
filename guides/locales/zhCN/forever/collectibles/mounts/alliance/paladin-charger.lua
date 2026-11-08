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
	-- {spell:23214} Summon Charger · {item:14047} Runecloth · {item:8836} Arthas' Tears · {npc:6171} Duthorian Rall
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["The {spell:23214} chain is long: Stratholme, Dire Maul West and Scholomance with a group, 350 gold in donations, and materials worth several hundred more (6 Arcanite Bars, 40 {item:14047}, 10 {item:8836}, two diamonds). Start saving early. Lord Grayson stands in the Cathedral of Light, {npc:6171} nearby."] = "",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}, Cathedral of Light"] = "{npc:6171}，光明大教堂",

	-- Step 3: High Priest Rohan
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries · {zone:1455} Ironforge · {object:32362} Mystic Ward
	["{npc:11406}, the priest trainer, walks about the {object:32386} in {zone:1455}'s {object:32362}. He gives you his censer for a donation of 150 gold, taken at the hand-in. Keep the censer."] = "",
	-- {npc:11406} High Priest Rohan
	["{npc:11406}: 150 gold"] = "{npc:11406}：150金",

	-- Step 4: Back to Lord Grayson
	["Back to Lord Grayson"] = "回到格雷森·沙东布瑞克公爵处",
	-- {item:18752} Exorcism Censer
	["Lord Grayson blesses the censer into the {item:18752} for Terrordale."] = "",

	-- Step 5: Exorcising Terrordale
	-- {zone:1423} Eastern Plaguelands · {object:179747} Terrordale Haunting Spirit (no name in this language: may be words) · {item:18752} Exorcism Censer
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit
	["Terrordale lies in the far north-west of the {zone:1423}, west of the Stratholme gates. Stand inside a green glowing patch on the ground (a {object:179747}; some are inside the ruined houses) and use the {item:18752}: up to three Terrordale Spirits (level 59-60) rise and attack. Their Wailing Dead lowers all your stats by 30%: fight them one at a time and use Turn Undead. The patches come back quickly; several paladins can work side by side."] = "",
	-- {item:18752} Exorcism Censer
	["{item:18752}, inside a green patch"] = "",
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit
	["Terrordale Spirits x25"] = "",

	-- Step 6: Lord Grayson Shadowbreaker
	["Lord Grayson takes the censer back."] = "",

	-- Step 7: Grimand Elmore
	-- {npc:1416} Grimand Elmore · {zone:1453} Stormwind · {object:28027} Dwarven District · {item:18753} Arcanite Barding
	["{npc:1416} works in {zone:1453}'s {object:28027}. He forges the {item:18753} from your materials and 150 gold."] = "",

	-- Step 8: Grimand Elmore's materials
	-- {npc:1416} Grimand Elmore
	["{npc:1416}'s materials"] = "{npc:1416}的材料",
	-- {item:14047} Runecloth · {item:8836} Arthas' Tears · {skill:182} Herbalism · {item:12360} Arcanite Bar · {item:12359} Thorium Bar · {item:12363} Arcane Crystal
	["{item:14047} drops from humanoids of level 50 and up (Everlook's Bruisers, the Scarlet Crusade in the Plaguelands, the Dire Maul ogres). {item:8836} is a Plaguelands herb ({skill:182} 220), common around Chillwind Camp. An {item:12360} is an alchemist's transmute from a {item:12359} and an {item:12363}, once every two days per alchemist: ask a guild alchemist early, or buy the bars. The Auction House sells all three."] = "",
	-- {item:14047} Runecloth
	["{item:14047} x40"] = "",
	-- {item:8836} Arthas' Tears
	["{item:8836} x10"] = "",
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["Arcanite Bars x6: an alchemist, or the Trade District Auction House"] = "",

	-- Step 9: Stratholme Holy Water
	-- {zone:1423} Eastern Plaguelands
	-- plural, as words: Stratholme Supply Crates = {object:181085} Stratholme Supply Crate
	["Stratholme is a dungeon for a group of five at 58-60, at the north end of the {zone:1423}. Stratholme Supply Crates along the streets of both halves hold the Holy Water, one to three each; they come back after three minutes. Some crates let out a swarm of plagued rats or maggots: be ready. The main gate (the Scarlet half) needs no key."] = "",
	["Stratholme"] = "",
	-- plural, as words: Stratholme Supply Crates = {object:181085} Stratholme Supply Crate
	["Stratholme Supply Crates, inside"] = "",

	-- Step 10: Grimand Elmore
	-- {npc:1416} Grimand Elmore · {item:18753} Arcanite Barding
	["Bring the materials and 150 gold, taken at the hand-in. {npc:1416} walks to his forge and hands you the {item:18753}."] = "",
	-- {npc:1416} Grimand Elmore
	["{npc:1416}: 150 gold"] = "{npc:1416}：150金",

	-- Step 11: Lord Grayson Shadowbreaker
	["Lord Grayson keeps the barding for now: you get it back with the next quest."] = "",
	-- {npc:928} Lord Grayson Shadowbreaker · {item:18753} Arcanite Barding
	["{npc:928}: the {item:18753}"] = "{npc:928}：{item:18753}",

	-- Step 12: Enriched Manna Biscuits
	-- plural, as words: Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Enriched Manna Biscuits"] = "可口的魔法点心",
	-- {object:2160} The Argent Dawn · {object:92525} Argent Dawn · {npc:10857} Argent Quartermaster Lightspark · {npc:11536} Quartermaster Miranda Breechlock
	-- plural, as words: Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["{object:2160} quartermasters sell Enriched Manna Biscuits, five for 60 silver, once the {object:92525} is Friendly with you: {npc:10857} at Chillwind Camp or {npc:11536} at Light's Hope Chapel. Scourgestones and the Plaguelands quests raise the standing."] = "",
	-- {npc:10857} Argent Quartermaster Lightspark
	-- plural, as words: Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Enriched Manna Biscuits: {npc:10857}, Chillwind Camp"] = "",

	-- Step 13: Merideth Carlson
	-- {npc:2357} Merideth Carlson · {quest:7645} Manna-Enriched Horse Feed
	["{npc:2357} breeds horses in Southshore's stable. She makes the {quest:7645} from the 20 biscuits and 50 gold, taken at the hand-in."] = "",

	-- Step 14: Dire Maul: Tendris Warpwood
	-- {npc:11489} Tendris Warpwood
	["Dire Maul: {npc:11489}"] = "",
	-- {zone:1444} Feralas · {item:18249} Crescent Key · {npc:11489} Tendris Warpwood · {npc:11459} Ironbark Protector · {quest:7643} Ancient Equine Spirit · {item:18753} Arcanite Barding
	["Dire Maul lies in central {zone:1444}. From the gate at the foot of the ruins, walk up through the outer courtyards to the West wing's door at their north end; it needs a {item:18249} (from Pusillin in Dire Maul East) or a rogue's lockpicking. {npc:11489} (level 60 elite) stands at the far end of the West wing's first courtyard. Once attacked he calls every {npc:11459} still alive in the courtyard: kill them first. His death frees the {quest:7643}: talk to it to give it the horse feed and the {item:18753}, and it blesses the barding. A group of five at 60."] = "",
	["Dire Maul West's door"] = "",
	-- {npc:11489} Tendris Warpwood
	["{npc:11489}, inside the West wing"] = "{npc:11489}，在西区内",

	-- Step 16: Two diamonds
	["Two diamonds"] = "两颗钻石",
	-- {item:12800} Azerothian Diamond · {item:18335} Pristine Black Diamond · {npc:14695} Lord Blackwood
	["An {item:12800} comes from Thorium veins and obsidian, about one vein in a hundred; a {item:18335} drops rarely from elites of level 59 and up (Revanchion and {npc:14695} about one kill in nine and one in a hundred). The Auction House is the usual source of both."] = "",

	-- Step 17: Lord Grayson Shadowbreaker
	-- {item:18804} Lord Grayson's Satchel · {item:18746} Divination Scryer · {item:18792} Blessed Arcanite Barding
	["Lord Grayson hands you {item:18804}: open it for the {item:18746} and the {item:18792}. Keep both."] = "",
	-- {item:18792} Blessed Arcanite Barding
	["{item:18792}, from the satchel"] = "",

	-- Step 18: The Great Ossuary
	-- {zone:1422} Western Plaguelands · {item:13704} Skeleton Key · {object:179746} The Great Ossuary (no name in this language: may be words) · {item:18746} Divination Scryer · {npc:14516} Death Knight Darkreaver · {item:18749} Charger's Lost Soul · {item:18792} Blessed Arcanite Barding · {npc:14568} Darkreaver's Fallen Charger
	["Scholomance lies under Caer Darrow, the island town in the south-east of the {zone:1422}; the door needs the {item:13704} (The Key to Scholomance). Clear the {object:179746}, Rattlegore's room in the basement, then use the {item:18746} at its centre. Four waves of spirits come, each ending with an Aspect: players judge them with Seal of Wisdom, Justice, Righteousness and then Light, which stuns them. {npc:14516} (level 62 elite) comes after the last; he mind-controls players. Loot the {item:18749}, use it inside the Ossuary to redeem it, and give it and the {item:18792} to {npc:14568}. If the group wipes, the gates lock and the scryer is gone: abandon the quest and take it again from Lord Grayson for a new satchel. A group of five at 60. Again Into the {object:179746}, after the mount, lets you fight him again."] = "",
	["Scholomance"] = "",
	-- {item:18749} Charger's Lost Soul · {object:179746} The Great Ossuary (no name in this language: may be words)
	["{item:18749}, inside the {object:179746}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["An {item:12800} comes from Thorium veins, a {item:18335} from the elites of the {zone:1422}, both rarely: the Auction House is the usual source."] = "{item:12800}来自瑟银矿脉，{item:18335}来自{zone:1422}的精英怪，两者都很少见：通常在拍卖行购买。",
	-- ["Arcanite Bars: the Auction House"] = "奥金锭：拍卖行",
	-- ["Bring 150 gold for {npc:1416} along with the materials."] = "除材料外，还要带150金给{npc:1416}。",
	-- ["Enriched Manna Biscuits: {npc:10857}, {area:3197}"] = "可口的魔法点心：{npc:10857}，{area:3197}",
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
