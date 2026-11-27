-- Chinese (traditional) (zhTW): the guide forever/reputation/timbermaw-hold (forever/reputation/timbermaw-hold.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Timbermaw Hold Reputation"] = "木喉要塞聲望",
	["Safe passage through the tunnels, agility enchants and furbolg recipes; the trinket at Exalted."] = "安全穿過隧道，獲得敏捷附魔和熊怪配方；崇拜時可獲得飾品。",
	["Recipes for Leatherworkers, Tailors, Enchanters and Alchemists from Friendly to Revered"] = "友善到崇敬期間可獲得制皮、裁縫、附魔和鍊金術配方",

	-- Step 1: Grazle
	-- {faction:576} Timbermaw Hold · {npc:11554} Grazle · {npc:15395} Nafien · {npc:11556} Salfa · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["{faction:576} starts at Hostile (2,500 of 3,000), so its furbolgs attack you in their tunnels; {npc:11554}, {npc:15395} and {npc:11556} talk to everyone. {npc:11554} waits by the road in the south of {zone:1448}, near the {area:2479}. Every Deadwood and Winterfall furbolg you kill gives 5 reputation up to the last point of Honored, so the quests below pay twice. The Legacy perk Diplomat adds up to 10% to every gain."] = "{faction:576}從中立開始就是敵對（3,000點中已有2,500），所以它的熊怪會在隧道裡攻擊你；{npc:11554}、{npc:15395}和{npc:11556}則與所有人交談。{npc:11554}在{zone:1448}南部的路邊等候，靠近{area:2479}。你殺的每個死木和冬泉熊怪都給5點聲望，直到尊敬的最後一刻，所以下面的任務會付雙份。傳承專長“外交家”會讓每次獲得的聲望最多增加10%。",

	-- Step 2: Deadwood Village
	-- {zone:1448} Felwood · {item:21377} Deadwood Headdress Feather · {npc:9464} Overlord Ror · {npc:14342} Ragepaw
	["The Deadwood furbolgs (level 48-50) hold the village at the south end of {zone:1448}. Keep every {item:21377}: they are worth 10 reputation each later and never stop counting. {npc:9464} (15 reputation) and the rare {npc:14342} (25) live here and count until Exalted. Forever pays quests in full at any level; in Classic grey mobs gave about a fifth, about 1 a kill for these furbolgs at 60. Do it while leveling if you can."] = "死木熊怪（48-50級）佔據著{zone:1448}南端的村子。{item:21377}全部留著：以後每個值10點聲望，而且一直計入。{npc:9464}（15點聲望）和稀有的{npc:14342}（25點）住在這裡，一直算到崇拜。Forever 裡任務任何等級都足額給分；經典版裡灰色怪只給約五分之一，60級時這些熊怪每隻約1點。能練級時做就練級時做。",
	-- {npc:14342} Ragepaw
	["{npc:14342}, rare"] = "{npc:14342}，稀有",

	-- Step 3: Back to Grazle
	-- {npc:11554} Grazle
	["Back to {npc:11554}"] = "返回{npc:11554}",

	-- Step 4: Nafien
	-- {npc:15395} Nafien · {zone:1448} Felwood
	["{npc:15395} stands at the {zone:1448} mouth of the Timbermaw tunnel, at the top of the road in the north of {zone:1448}."] = "{npc:15395}站在木喉隧道的{zone:1448}入口，就在{zone:1448}北部道路的頂端。",

	-- Step 5: Felpaw Village
	-- {npc:9462} Chieftain Bloodmaw
	["The northern Deadwood (level 53-55) camp just south of the tunnel. They drop feathers about half the time: the best feather spot. {npc:9462} gives 15 until Exalted."] = "北方的死木熊怪（53-55級）在隧道南邊不遠處紮營。牠們大約有一半機率掉落羽毛：這是刷羽毛的最佳地點。{npc:9462}在崇拜之前每次給15點。",

	-- Step 6: Back to Nafien
	-- {npc:15395} Nafien
	["Back to {npc:15395}"] = "返回{npc:15395}",
	-- {quest:8460} Timbermaw Ally
	["These quests and their kills bring you just past Unfriendly (500 from the start). If {quest:8460} paid you less (at level 60 in Classic: 30), kill about 40 more northern Deadwood. From Unfriendly the Timbermaw in the tunnel leave you alone."] = "這些任務及其擊殺會把你剛好帶過冷淡（從開始算500點）。如果{quest:8460}給你的較少（經典舊世60級時為30點），就再殺約40隻北邊死木熊怪。達到冷淡後，隧道裡的木喉就不會再攻擊你。",

	-- Step 7: Salfa
	-- {zone:1452} Winterspring · {npc:11556} Salfa
	["Walk through the tunnel to its {zone:1452} mouth; {npc:11556} stands just outside. Do not attack any Timbermaw: each one costs 25 reputation."] = "穿過隧道走到{zone:1452}一側的出口；{npc:11556}就站在外面。不要攻擊任何木喉：每隻扣25點聲望。",

	-- Step 8: Winterfall Village
	-- {area:2244} Winterfall Village · {zone:1452} Winterspring · {area:2255} Everlook · {item:21383} Winterfall Spirit Beads · {npc:10199} Grizzle Snowpaw · {npc:10738} High Chief Winterfall
	["{area:2244} lies in the east of {zone:1452}, just past {area:2255}. Keep every {item:21383} you loot (10 reputation each later). The Shamans, Den Watchers and Ursas share their spawn points, so kill every furbolg in the village to make the ones you need appear; more Ursas walk the ridge just south-west of the village. {npc:10199} (rare) and {npc:10738}, in the cave at the back, give 25 until Exalted. Alliance: the Wintersaber Trainers' Winterfall Intrusion asks for the same Shamans and Ursas."] = "{area:2244}在{zone:1452}東部，就在{area:2255}過去一點。拾到的每串{item:21383}都留著（之後每串10點聲望）。薩滿、巢穴守望者和巨熊共享重生點，所以把村子裡的熊怪全部殺掉，才能讓你需要的那些出現；村子西南的山脊上還有更多巨熊走動。{npc:10199}（稀有）和洞穴深處的{npc:10738}給25點，直到崇拜。聯盟：冬刃豹訓練師的《冬泉入侵》也需要同樣的薩滿和巨熊。",
	-- {npc:10199} Grizzle Snowpaw
	["{npc:10199}, rare"] = "{npc:10199}，稀有",
	-- {npc:10738} High Chief Winterfall
	["{npc:10738}, elite"] = "{npc:10738}，精英",

	-- Step 9: Back to Salfa
	-- {npc:11556} Salfa
	["Back to {npc:11556}"] = "返回{npc:11556}",
	-- {quest:8466} Feathers for Grazle · {quest:8467} Feathers for Nafien · {quest:8469} Beads for Salfa
	["{quest:8466}, {quest:8467} and {quest:8469} are open now: 50 reputation for 5 feathers or 5 beads, as often as you like. Do not hand them in yet."] = "{quest:8466}、{quest:8467}和{quest:8469}現已開放：5根羽毛或5串念珠換50點聲望，想交多少次都行。先別急著交。",

	-- Step 10: Unfriendly to Neutral
	["Unfriendly to Neutral"] = "冷淡到中立",
	-- {zone:1448} Felwood · {area:2246} Frostfire Hot Springs · {area:2243} Timbermaw Post · {npc:11556} Salfa · {area:2244} Winterfall Village
	["Unfriendly to Neutral is 3,000: about 540 more kills after these quests. Three camps: the northern Deadwood by the {zone:1448} mouth of the tunnel; the Winterfall camps around {area:2246} and {area:2243}, just south and south-east of {npc:11556} (Pathfinders give 6 a kill, Den Watchers and Totemics 5, the shortest walk to a turn-in); and {area:2244} in the east. Pick the least crowded. Keep all feathers and beads."] = "冷淡到中立是3,000點：這些任務後還需約540次擊殺。三處營地：隧道{zone:1448}入口旁北邊的死木；{area:2246}和{area:2243}周圍的冬泉營地，就在{npc:11556}正南和東南（探路者每隻給6點，巢穴守望者和圖騰師5點，是離上交點最近的）；以及東邊的{area:2244}。挑人最少的一處。所有羽毛和念珠都留著。",
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["Deadwood Headdress Feathers: keep them"] = "死木頭飾羽毛：留著",
	-- {item:21383} Winterfall Spirit Beads
	["{item:21383}: keep them"] = "{item:21383}：留著",
	-- {area:2246} Frostfire Hot Springs
	-- plural, as words: Winterfall Pathfinders = {npc:7442} Winterfall Pathfinder
	["Winterfall Pathfinders, {area:2246}"] = "冬泉探路者，{area:2246}",

	-- Step 11: Deadwood Ritual Totem
	-- {quest:8470} Deadwood Ritual Totem · {npc:11558} Kernda · {zone:1448} Felwood
	-- plural, as words: Mana Potions = {item:3827} Mana Potion
	["The northern Deadwood rarely drop a {quest:8470} (about 3%). From Neutral, {npc:11558} takes it in the tunnel, on the {zone:1448} side: 150 reputation and two Major Healing and Mana Potions."] = "北邊的死木熊怪很少掉落{quest:8470}（約3%）。從中立起，{npc:11558}會在隧道{zone:1448}一側收：150點聲望，外加兩瓶強效治療藥水和兩瓶強效法力藥水。",

	-- Step 12: Kernda: the Deadwood totem
	-- {npc:11558} Kernda
	["{npc:11558}: the Deadwood totem"] = "{npc:11558}：死木圖騰",

	-- Step 13: Winterfall Ritual Totem
	-- {quest:8471} Winterfall Ritual Totem · {npc:11558} Kernda
	-- plural, as words: Mana Potions = {item:3827} Mana Potion
	["The Winterfall furbolgs rarely drop a {quest:8471} (3-4%). {npc:11558} takes it in the tunnel too: 150 reputation and three Major Healing and Mana Potions."] = "冬泉熊怪很少掉落{quest:8471}（3-4%）。{npc:11558}也在隧道裡收：150點聲望，外加三瓶強效治療藥水和三瓶強效法力藥水。",

	-- Step 14: Kernda: the Winterfall totem
	-- {npc:11558} Kernda
	["{npc:11558}: the Winterfall totem"] = "{npc:11558}：冬寒圖騰",

	-- Step 15: To Azshara
	-- {zone:1447} Azshara
	["To {zone:1447}"] = "",
	-- {area:1225} Ursolan · {zone:1447} Azshara · {npc:11555} Gorn One Eye · {faction:576} Timbermaw Hold · {area:1237} Valormok · {area:3137} Talrendis Point · {npc:235903} Ekkal
	["Neutral opens {area:1225}, the camp of the Blackmaw furbolgs in northern {zone:1447}: their quests and {npc:11555}'s in {faction:576} are levels 53-55, about 50,000 experience below level 60, all outdoors. Below Neutral the Blackmaw attack you. The nearest flight masters are {area:1237} (Horde) and {area:3137} (Alliance); {npc:235903} camps by the road between them and {area:1225}."] = "",
	-- {npc:235903} Ekkal
	["{npc:235903}'s camp"] = "",

	-- Step 16: Ekkal
	-- {npc:235903} Ekkal · {zone:1447} Azshara · {area:1219} Legashi Encampment
	-- plural, as words: Legashi Satyrs = {npc:6200} Legashi Satyr
	["{npc:235903} camps by the road in the middle of {zone:1447}. His satyrs come first: the Legashi Satyrs, Rogues and Hellcallers (51-53) of the {area:1219}, north-east of him."] = "",

	-- Step 17: The Legashi Encampment
	-- {area:1219} Legashi Encampment
	["The {area:1219}"] = "",

	-- Step 20: Ursolan
	-- {area:1225} Ursolan · {npc:235909} Furze · {npc:236573} Gatekeeper Rageroar · {npc:235906} Elder Bramblesnap
	["Ride north up the road to {area:1225}. {npc:235909} sits on the camp's south-east side; {npc:236573} and {npc:235906} stand together on its west side."] = "",

	-- Step 21: The Legashi Cauldron
	-- {object:506307} Legashi Cauldron (no name in this language: may be words)
	["The {object:506307}"] = "",
	-- {area:1219} Legashi Encampment
	["Ride east to the {area:1219}: the satyrs' cauldron stands in the middle of their camp."] = "",

	-- Step 22: The Legashi Encampment
	["Any of the encampment's satyrs may carry the recipe."] = "",

	-- Step 24: Satyrweed
	-- plural, as words: Satyrweed Brambles = {object:507746} Satyrweed Bramble
	["The Satyrweed Brambles grow all around the encampment."] = "",

	-- Step 25: Korsa
	-- {area:16234} Legashi Stronghold · {npc:236770} Korsa
	["East to the {area:16234}: {npc:236770}, the missing Blackmaw scout, waits outside it."] = "",

	-- Step 26: Graal
	-- {npc:237007} Graal · {npc:235892} Prince Halanox
	["{npc:237007} is held at the north end of the stronghold: free {npc:237007} and see the breakout through. Careful: {npc:235892} (55, elite) stands just south of there, around 67,19."] = "",

	-- Step 27: The Legashi Stronghold: kill these as you meet them
	-- {area:16234} Legashi Stronghold
	["The {area:16234}: kill these as you meet them"] = "",
	-- {npc:235892} Prince Halanox
	["The Hellraisers, Soulstealers and Blackguards (53-54) hold the stronghold. Careful: {npc:235892} (55, elite) stands at its north-east end, around 67,19: leave him be."] = "",

	-- Step 28: Master Feardred
	-- {quest:86777} Master Feardred · {item:235471} Fel Mote
	["{quest:86777} (53) walks the stronghold's south side; the {item:235471} floats nearby."] = "",

	-- Step 30: The Legashi Cauldron
	["Back west to the cauldron."] = "",

	-- Step 31: Ursolan
	-- {area:1225} Ursolan
	["Back west to {area:1225}."] = "",
	-- {npc:11555} Gorn One Eye · {faction:576} Timbermaw Hold
	["For {npc:11555} in {faction:576}, at the end of this part"] = "",

	-- Step 32: Mosshoof Coursers
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers"] = "苔蹄快步者",
	-- {area:1225} Ursolan · {item:221199} Satyrweed Tincture
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser · Thunderhead Skystormers = {npc:6378} Thunderhead Skystormer
	["The Mosshoof Coursers (52-53) and Thunderhead Skystormers (50-52) graze just east of {area:1225}: bring one low, then use the {item:221199} on it. Three times."] = "",

	-- Step 34: Furze
	-- {npc:235909} Furze
	["Give {npc:235909} the panacea."] = "",

	-- Step 36: To Timbermaw Hold
	-- {area:1769} Timbermaw Hold
	["To {area:1769}"] = "",
	-- {zone:1448} Felwood · {area:1997} Bloodvenom Post · {area:1998} Talonbranch Glade
	["Back to {zone:1448}: fly to {area:1997} (Horde) or {area:1998} (Alliance) and ride north up the road to the {zone:1448} mouth of the tunnel."] = "",

	-- Step 37: Gorn One Eye
	-- {npc:11555} Gorn One Eye · {npc:11558} Kernda · {npc:11557} Meilosh
	["{npc:11555} stands just inside the tunnel, by {npc:11558} and {npc:11557}."] = "",

	-- Step 38: Chieftain Bloodmaw
	-- {npc:9462} Chieftain Bloodmaw
	["{npc:9462} (55-56) leads the Deadwood of Felpaw Village, just west of the tunnel."] = "",

	-- Step 39: Gorn One Eye
	-- {zone:1447} Azshara · {npc:235892} Prince Halanox
	["His next task, Blackmaw Counter-Offensive, sends you back to {zone:1447} against {npc:235892}, a level 55 elite: bring a friend."] = "",

	-- Step 40: Neutral to Friendly
	["Neutral to Friendly"] = "中立到友善",
	["Neutral to Friendly is 3,000: 600 kills. Keep all feathers and beads."] = "中立到友善是3,000點：600次擊殺。所有羽毛和念珠都留著。",

	-- Step 41: Meilosh
	-- {npc:11557} Meilosh · {zone:1448} Felwood · {item:13484} Recipe: Transmute Earth to Water · {item:22392} Formula: Enchant 2H Weapon - Agility · {item:20253} Pattern: Warbear Harness · {item:15065} Warbear Woolies · {quest:6031} Runecloth · {item:14342} Mooncloth · {item:15802} Mooncloth Boots
	["{npc:11557} stands in the tunnel, near its {zone:1448} mouth. From Friendly he sells: {item:13484} (1 gold 50 silver), {item:22392} (2 gold 50 silver), {item:20253} (1 gold 60 silver) and {item:15065} (2 gold). He also takes 30 {quest:6031} once for 100 reputation and a choice of shoulders or gauntlets, and Tailors with skill 290 can bring him 2 {item:14342} for 100 more and the {item:15802} pattern."] = "{npc:11557}站在隧道裡，靠近{zone:1448}一側的入口。從友善起他出售：{item:13484}（1金50銀）、{item:22392}（2金50銀）、{item:20253}（1金60銀）和{item:15065}（2金）。他還會一次性收下30個{quest:6031}，給100點聲望和護肩或護手任選其一；技能290的裁縫可以帶2塊{item:14342}給他，換100點聲望和{item:15802}圖樣。",

	-- Step 42: Runecloth for Meilosh
	-- {quest:6031} Runecloth · {npc:11557} Meilosh
	["{quest:6031} for {npc:11557}"] = "{quest:6031}交給{npc:11557}",
	-- {quest:6031} Runecloth
	["{quest:6031} drops from the humanoids of the level 50-60 zones, the Deadwood and Winterfall furbolgs among them."] = "{quest:6031}由50-60級區域的人形怪掉落，其中也包括死木和冬泉熊怪。",

	-- Step 43: Sacred Cloth
	-- {npc:11557} Meilosh · {item:14342} Mooncloth · {item:15802} Mooncloth Boots
	["Tailors with skill 290: {npc:11557} takes 2 {item:14342} once for 100 reputation and teaches the {item:15802}."] = "裁縫技能290：{npc:11557}一次性收下2塊{item:14342}，給100點聲望，並教你{item:15802}。",

	-- Step 44: Friendly to Honored
	["Friendly to Honored"] = "友善到尊敬",
	-- {npc:11557} Meilosh · {item:19445} Formula: Enchant Weapon - Agility · {item:19202} Pattern: Heavy Timbermaw Belt · {item:19044} Might of the Timbermaw · {skill:165} Leatherworking · {item:19047} Wisdom of the Timbermaw · {skill:197} Tailoring
	["Friendly to Honored is 6,000: 1,200 kills. Keep all feathers and beads. Honored opens at {npc:11557}: {item:19445} (3 gold), and for 2 gold 20 silver each {item:19202} and {item:19044} ({skill:165}) and {item:19047} ({skill:197})."] = "友善到尊敬是6,000點：1,200次擊殺。所有羽毛和念珠都留著。尊敬後可在{npc:11557}處購買：{item:19445}（3金），以及每張2金20銀的{item:19202}和{item:19044}（{skill:165}）以及{item:19047}（{skill:197}）。",

	-- Step 45: Honored to Revered
	["Honored to Revered"] = "尊敬到崇敬",
	["Honored to Revered is 12,000: 2,400 kills, the last ones that count. Kills stop at 11,999 of 12,000 Honored and never tip you into Revered: when they stop, hand in one set of 5 feathers or beads to cross over. Saving every feather and bead pays off now: about 4,800 kills from the start to the end of Honored leave you with about 2,100 feathers and beads, and that is all of Revered to Exalted. Turning them in early would cost you about 2,400 more kills."] = "從尊敬到崇敬需要12,000聲望：2,400次擊殺，這是最後能靠擊殺獲得的聲望。到尊敬11,999/12,000時，擊殺不再提供聲望，無法靠它升到崇敬：此時交一組5根羽毛或5顆珠子跨過上限。之前保留的所有羽毛和珠子現在派上用場：從起點刷到尊敬上限，約4,800次擊殺會留下約2,100個羽毛和珠子，足以覆蓋崇敬到崇拜的全部需求。提前交還會讓你多刷約2,400只怪。",
	-- {item:19445} Formula: Enchant Weapon - Agility · {skill:333} Enchanting
	["{item:19445} ({skill:333}), 3 gold"] = "{item:19445}（{skill:333}），3金",
	-- {quest:8467} Feathers for Nafien
	["{quest:8467}: once your kills stop, 5 feathers into Revered"] = "{quest:8467}：擊殺不再計數後，用5根羽毛跨入崇敬",
	-- {quest:8469} Beads for Salfa
	["{quest:8469}: or 5 beads"] = "{quest:8469}：或者5串念珠",

	-- Step 46: Revered to Exalted
	["Revered to Exalted"] = "崇敬到崇拜",
	-- {npc:15395} Nafien · {npc:11554} Grazle · {npc:11556} Salfa · {npc:14342} Ragepaw · {npc:10199} Grizzle Snowpaw · {npc:10738} High Chief Winterfall · {npc:11557} Meilosh · {item:19204} Pattern: Heavy Timbermaw Boots · {item:19049} Timbermaw Brawlers · {skill:165} Leatherworking · {item:19050} Mantle of the Timbermaw · {skill:197} Tailoring
	["Kills stopped at the end of Honored. Revered to Exalted is 21,000: 420 turn-ins, 2,100 feathers and beads. Hand in the feathers to {npc:15395} at the tunnel or {npc:11554} in the south, the beads to {npc:11556}, five at a time. The named furbolgs (Ror, Bloodmaw, {npc:14342}, {npc:10199}, {npc:10738}) still count. Revered opens at {npc:11557}, for 4 gold each: {item:19204} and {item:19049} ({skill:165}) and {item:19050} ({skill:197})."] = "擊殺在尊敬結束處停止。崇敬到崇拜是21,000點：420次上交，2,100根羽毛和念珠。羽毛交給隧道裡的{npc:15395}或南邊的{npc:11554}，念珠交給{npc:11556}，每次五個。那些有名有姓的熊怪（羅爾、血牙、{npc:14342}、{npc:10199}、{npc:10738}）仍然計數。崇敬後可在{npc:11557}處購買，每張4金：{item:19204}和{item:19049}（{skill:165}）以及{item:19050}（{skill:197}）。",
	-- {quest:8467} Feathers for Nafien
	["{quest:8467}: 5 feathers, 50 reputation"] = "{quest:8467}：5根羽毛，50點聲望",
	-- {quest:8466} Feathers for Grazle
	["{quest:8466}: 5 feathers, 50 reputation"] = "{quest:8466}：5根羽毛，50點聲望",
	-- {quest:8469} Beads for Salfa
	["{quest:8469}: 5 beads, 50 reputation"] = "{quest:8469}：5串念珠，50點聲望",

	-- Step 47: The Root of All Evil
	-- {npc:11555} Gorn One Eye · {npc:11557} Meilosh · {quest:8481} The Root of All Evil · {item:21144} Demon Summoning Torch · {npc:10738} High Chief Winterfall · {npc:15623} Xandivious · {item:21326} Defender of the Timbermaw
	["At Exalted, {npc:11555}, in the tunnel by {npc:11557}, gives {quest:8481}: plant his {item:21144} in the mouth of {npc:10738}'s cave and defeat the demon {npc:15623} (level 62, elite: bring a group). The reward is {item:21326}, a trinket that calls a Timbermaw ally, and 200 reputation."] = "崇拜時，{npc:11555}在隧道裡、{npc:11557}旁邊，給你{quest:8481}：把他的{item:21144}插在{npc:10738}的洞口，並擊敗惡魔{npc:15623}（62級，精英：帶隊伍去）。獎勵是{item:21326}，一枚召喚木喉盟友的飾品，外加200點聲望。",

	-- Step 48: Xandivious
	-- {area:2244} Winterfall Village · {npc:15623} Xandivious
	["{area:2244}, the cave at the back. Clear the furbolgs around the mouth first, plant the torch, kill {npc:15623} and loot the Essence from his Demon Bag."] = "{area:2244}，洞穴深處。先清掉洞口周圍的熊怪，插下火炬，殺掉{npc:15623}，再從它的惡魔包裡拾取精華。",
	-- {npc:15623} Xandivious
	["{npc:15623}, 25 reputation"] = "{npc:15623}，25點聲望",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Alternate Deadwood feathers ({npc:15395}) and Winterfall beads ({npc:11556}), whichever camp is less crowded."] = "輪流收集死木羽毛（{npc:15395}）和冬泉念珠（{npc:11556}），看哪個營地人比較少。",
	-- ["Deadwood furbolgs (level 48-50) camp at the southern end of {zone:1448}. Keep every {item:21377} they drop: {npc:11554} and {npc:15395} take them later."] = "死木熊怪（48-50級）在{zone:1448}南端紮營。留著牠們掉落的每一個{item:21377}：{npc:11554}和{npc:15395}之後會收。",
	-- ["Feathers and beads to Friendly"] = "羽毛和念珠到友好",
	-- ["Feathers for {npc:11554} and Feathers for {npc:15395} (Deadwood Headdress Feathers) and Beads for {npc:11556} ({item:21383}) repeat as often as you like; every Deadwood or Winterfall kill counts as well. {area:2244} is the densest bead spot."] = "給{npc:11554}的羽毛、給{npc:15395}的羽毛（死木頭飾羽毛）和給{npc:11556}的念珠（{item:21383}）可以無限次重複；每次擊殺死木或冬泉熊怪也會計入。{area:2244}是念珠最密集的地點。",
	-- ["Feathers to Honored"] = "羽毛到尊敬",
	-- ["Go through {faction:576} to its {zone:1452} exit; {npc:11556} stands just outside. The quests and kills so far usually reach Unfriendly, and then the Timbermaw let you pass. If they still show red, kill more Deadwood by the tunnel first."] = "穿過{faction:576}，到達通往{zone:1452}的出口；{npc:11556}就站在外面。到目前為止的任務和擊殺通常能達到冷淡，木喉熊怪就會讓你通過。如果牠們仍顯示紅色，先在隧道附近多殺些死木熊怪。",
	-- ["Keep turning in feathers and beads until Exalted."] = "持續繳交羽毛和念珠直到崇拜。",
	-- ["The northern Deadwood camps by the tunnel are the densest feather spot (35% drop chance there). Hand feathers to {npc:15395} at the tunnel, or to {npc:11554} in the south."] = "隧道旁的北方死木營地是羽毛最密集的地點（那裡掉落率35%）。把羽毛交給隧道口的{npc:15395}，或南邊的{npc:11554}。",
	-- ["{area:2244} sits on the eastern side of {zone:1452}. Keep every {item:21383} you loot: {npc:11556} takes them."] = "{area:2244}位於{zone:1452}東側。留著你拾取的每一個{item:21383}：{npc:11556}會收。",
	-- ["{faction:576} starts out Hostile, and its furbolgs in the tunnels attack until you reach Unfriendly. Every Deadwood and Winterfall furbolg you kill raises it, so the quests below pay twice. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:576}初始為敵對，在你達到冷淡之前，隧道裡的熊怪會攻擊你。擊殺的每一隻死木和冬泉熊怪都會提升聲望，所以下面的任務有雙重收益。Forever的傳承外交官天賦可提高聲望獲取。",
	-- ["{faction:576} to Exalted"] = "{faction:576}到崇拜",
	-- ["{faction:576} to Revered"] = "{faction:576}到崇敬",
	-- ["{npc:11556}: Beads for {npc:11556}"] = "{npc:11556}：給{npc:11556}的念珠",
	-- ["{npc:15395} waits in northern {zone:1448} at the tunnel into {faction:576}."] = "{npc:15395}在{zone:1448}北部通往{faction:576}的隧道口等著。",
	-- ["{npc:15395}: Feathers for {npc:15395}"] = "{npc:15395}：給{npc:15395}的羽毛",
}
