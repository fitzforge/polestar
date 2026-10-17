-- Chinese (traditional) (zhTW): the guide forever/collectibles/mounts/alliance/paladin-charger (forever/collectibles/mounts/alliance/paladin-charger.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Paladin Charger"] = "聖騎士軍馬",
	["Your epic mount at 60, summoned at will: the faster step up from the Warhorse."] = "60級的史詩坐騎，可隨時召喚：比戰馬更快的升級。",

	-- Step 1: Lord Grayson Shadowbreaker (Ironforge)
	-- {npc:5149} Brandur Ironhammer · {object:32362} Mystic Ward · {quest:7638} Lord Grayson Shadowbreaker · {zone:1453} Stormwind
	["At 60 {npc:5149} in the {object:32362} sends you to {quest:7638} in {zone:1453}'s Cathedral of Light."] = "60級時，{object:32362}的{npc:5149}會派你去找{zone:1453}光明大教堂的{quest:7638}。",

	-- Step 2: Lord Grayson Shadowbreaker
	-- {spell:23214} Summon Charger · {area:2279} Stratholme · {area:2577} Dire Maul · {area:2057} Scholomance
	["The {spell:23214} chain is long: it takes you through {area:2279}, {area:2577} and {area:2057}, and costs about 350 gold in donations on top of the materials. Lord Grayson stands in the Cathedral of Light."] = "{spell:23214}任務鏈很長：會帶你進入{area:2279}、{area:2577}和{area:2057}，除了材料之外還要捐獻約350金幣。格雷森公爵站在光明大教堂裡。",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}, Cathedral of Light"] = "{npc:6171}，光明大教堂",

	-- Step 3: High Priest Rohan
	-- {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {object:32362} Mystic Ward
	["{npc:11406} is in {zone:1455}'s {object:32362}. Bring 150 gold: the censer is yours for a donation."] = "{npc:11406}在{zone:1455}的{object:32362}。帶150金幣：捐獻後香爐就歸你。",
	-- {npc:11406} High Priest Rohan
	["{npc:11406}: 150 gold"] = "{npc:11406}：150金幣",

	-- Step 4: Back to Lord Grayson
	["Back to Lord Grayson"] = "回到格雷森公爵那裡",

	-- Step 5: Exorcising Terrordale
	-- {area:2627} Terrordale · {zone:1423} Eastern Plaguelands · {zone:1422} Western Plaguelands · {item:18752} Exorcism Censer
	["{area:2627} lies in the far north-west of the {zone:1423}, by the {zone:1422} border. Use the {item:18752} there to drive out the spirits, then defeat them."] = "{area:2627}位於{zone:1423}的最西北方，靠近{zone:1422}邊界。在那裡使用{item:18752}驅出靈魂，然後擊敗它們。",
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit
	["Terrordale Spirits"] = "恐懼谷的靈魂",

	-- Step 7: Grimand Elmore
	-- {npc:1416} Grimand Elmore · {zone:1453} Stormwind · {object:28027} Dwarven District
	["{npc:1416} works in {zone:1453}'s {object:28027}."] = "{npc:1416}在{zone:1453}的{object:28027}工作。",

	-- Step 8: Grimand Elmore's materials
	-- {npc:1416} Grimand Elmore
	["{npc:1416}'s materials"] = "{npc:1416}的材料",
	-- {item:14047} Runecloth · {item:8836} Arthas' Tears · {zone:1448} Felwood · {skill:171} Alchemy · {zone:1453} Stormwind · {object:2096} Trade District
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["{item:14047} drops from humanoids around level 50 and up; {item:8836} is an herb of the Plaguelands and {zone:1448}; Arcanite Bars are an {skill:171} transmute. The Auction House in {zone:1453}'s {object:2096} sells all three, and so do crafters."] = "{item:14047}由50級以上的人型生物掉落；{item:8836}是瘟疫之地和{zone:1448}的草藥；奧金錠是{skill:171}轉化產物。{zone:1453}{object:2096}的拍賣場三樣都有賣，工匠也有。",
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["Arcanite Bars: the Auction House"] = "奧金錠：拍賣場",

	-- Step 9: Stratholme Holy Water
	-- {area:2279} Stratholme · {zone:1423} Eastern Plaguelands · {item:13180} Stratholme Holy Water
	-- plural, as words: Supply Crates = {item:4629} Supply Crate
	["{area:2279} is a group of five, level 58-60, at the north end of the {zone:1423}. The Supply Crates scattered through the city hold the {item:13180}."] = "{area:2279}是五人地城，等級58-60，位於{zone:1423}北端。散落在城中的補給箱裝有{item:13180}。",
	-- plural, as words: Supply Crates = {item:4629} Supply Crate
	["Supply Crates, inside"] = "補給箱，在裡面",

	-- Step 10: Grimand Elmore
	-- {npc:1416} Grimand Elmore
	["Bring 150 gold for {npc:1416} along with the materials."] = "除了材料，再帶150金幣給{npc:1416}。",
	-- {npc:1416} Grimand Elmore
	["{npc:1416}: 150 gold"] = "{npc:1416}：150金幣",

	-- Step 11: Lord Grayson Shadowbreaker
	-- {npc:928} Lord Grayson Shadowbreaker · {item:18753} Arcanite Barding
	["{npc:928}: the {item:18753}"] = "{npc:928}：{item:18753}",

	-- Step 12: Enriched Manna Biscuits
	-- plural, as words: Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Enriched Manna Biscuits"] = "可口的魔法點心",
	-- {object:2160} The Argent Dawn · {object:92525} Argent Dawn · {npc:10857} Argent Quartermaster Lightspark · {area:3197} Chillwind Camp · {npc:11536} Quartermaster Miranda Breechlock · {area:2268} Light's Hope Chapel · {npc:10856} Argent Quartermaster Hasana · {area:813} Bulwark
	["{object:2160} quartermasters sell the biscuits in fives once the {object:92525} is Friendly with you: {npc:10857} at {area:3197}, {npc:11536} at {area:2268}, {npc:10856} at the {area:813}."] = "{object:92525}對你友善後，{object:2160}軍需官會以五個為一組出售點心：{area:3197}的{npc:10857}、{area:2268}的{npc:11536}、{area:813}的{npc:10856}。",
	-- {npc:10857} Argent Quartermaster Lightspark · {area:3197} Chillwind Camp
	-- plural, as words: Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Enriched Manna Biscuits: {npc:10857}, {area:3197}"] = "可口的魔法點心：{npc:10857}，{area:3197}",

	-- Step 13: Merideth Carlson
	-- {npc:2357} Merideth Carlson · {area:271} Southshore
	["{npc:2357} breeds horses in {area:271}. She also wants 50 gold."] = "{npc:2357}在{area:271}養馬。她也要50金幣。",

	-- Step 14: Dire Maul: Tendris Warpwood
	-- {area:2577} Dire Maul · {zone:1444} Feralas · {npc:11489} Tendris Warpwood · {quest:7643} Ancient Equine Spirit · {item:18775} Manna-Enriched Horse Feed · {item:18753} Arcanite Barding
	["{area:2577} lies in central {zone:1444}; {npc:11489} guards the start of the West wing. Defeat him to free the {quest:7643}, feed it the {item:18775} and hand it the {item:18753} to bless. Bring a group."] = "{area:2577}位於{zone:1444}中部；{npc:11489}守在西區的入口。擊敗他以釋放{quest:7643}，餵牠{item:18775}，並把{item:18753}交給牠祝福。請帶小隊。",
	-- {npc:11489} Tendris Warpwood
	["{npc:11489}, inside the West wing"] = "{npc:11489}，在西區裡",

	-- Step 16: Two diamonds
	["Two diamonds"] = "兩顆鑽石",
	-- {item:12800} Azerothian Diamond · {item:18335} Pristine Black Diamond · {zone:1422} Western Plaguelands
	["An {item:12800} comes from Thorium veins, a {item:18335} from the elites of the {zone:1422}, both rarely: the Auction House is the usual source."] = "{item:12800}來自瑟銀礦脈，{item:18335}來自{zone:1422}的精英怪，兩者都很稀有：通常從拍賣場取得。",

	-- Step 17: Lord Grayson Shadowbreaker
	-- {item:18746} Divination Scryer
	["he hands you the {item:18746}"] = "他會給你{item:18746}",

	-- Step 18: The Great Ossuary
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:18746} Divination Scryer · {object:179746} The Great Ossuary (no name in this language: may be words) · {npc:14516} Death Knight Darkreaver · {item:18799} Charger's Redeemed Soul · {item:18792} Blessed Arcanite Barding
	["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. Use the {item:18746} in the heart of the {object:179746}'s basement, defeat the spirits it calls and then {npc:14516}, and give his Fallen Charger the {item:18799} and the {item:18792}. All are elite: bring a group. If the attempt fails, Lord Grayson gives you a new scryer through Again Into the {object:179746}."] = "{area:2057}位於{zone:1422}東南部的島上城鎮{area:2298}之下。在大藏骨堂地下室的中央使用{item:18746}，擊敗它召來的靈魂，再擊敗{npc:14516}，然後把{item:18799}和{item:18792}交給達克雷爾的墮落戰馬。全都是精英：請帶小隊。如果失敗，格雷森公爵會透過「重回大藏骨堂」給你新的預言水晶球。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. Use the {item:18746} in the heart of the {object:179746}'s basement, defeat the spirits it calls and then {npc:14516}, and give his Fallen Charger the {item:18799} and the {item:18792}. All are elite: bring a group. If the attempt fails, Lord Grayson gives you a new scryer through Again Into the {object:179746}."] = "{area:2057}位於{zone:1422}東南部的島上城鎮{area:2298}之下。在{object:179746}地下室的中央使用{item:18746}，擊敗它召來的靈魂，再擊敗{npc:14516}，然後把{item:18799}和{item:18792}交給達克雷爾的墮落戰馬。全都是精英：請帶小隊。如果失敗，格雷森公爵會透過「重回{object:179746}」給你新的預言水晶球。",
}
