-- Korean (koKR): the guide forever/reputation/timbermaw-hold (forever/reputation/timbermaw-hold.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Timbermaw Hold Reputation"] = "나무구렁 요새 평판",
	["Safe passage through the tunnels, agility enchants and furbolg recipes; the trinket at Exalted."] = "",
	["Recipes for Leatherworkers, Tailors, Enchanters and Alchemists from Friendly to Revered"] = "",

	-- Step 1: Grazle
	-- {faction:576} Timbermaw Hold · {npc:11554} Grazle · {npc:15395} Nafien · {npc:11556} Salfa · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["{faction:576} starts at Hostile (2,500 of 3,000), so its furbolgs attack you in their tunnels; {npc:11554}, {npc:15395} and {npc:11556} talk to everyone. {npc:11554} waits by the road in the south of {zone:1448}, near the {area:2479}. Every Deadwood and Winterfall furbolg you kill gives 5 reputation up to the last point of Honored, so the quests below pay twice. The Legacy perk Diplomat adds up to 10% to every gain."] = "",

	-- Step 2: Deadwood Village
	-- {zone:1448} Felwood · {item:21377} Deadwood Headdress Feather · {npc:9464} Overlord Ror · {npc:14342} Ragepaw
	["The Deadwood furbolgs (level 48-50) hold the village at the south end of {zone:1448}. Keep every {item:21377}: they are worth 10 reputation each later and never stop counting. {npc:9464} (15 reputation) and the rare {npc:14342} (25) live here and count until Exalted. Forever pays quests in full at any level; in Classic grey mobs gave about a fifth, about 1 a kill for these furbolgs at 60. Do it while leveling if you can."] = "",
	-- {npc:14342} Ragepaw
	["{npc:14342}, rare"] = "",

	-- Step 3: Back to Grazle
	-- {npc:11554} Grazle
	["Back to {npc:11554}"] = "{npc:11554}에게 돌아가기",

	-- Step 4: Nafien
	-- {npc:15395} Nafien · {zone:1448} Felwood
	["{npc:15395} stands at the {zone:1448} mouth of the Timbermaw tunnel, at the top of the road in the north of {zone:1448}."] = "",

	-- Step 5: Felpaw Village
	-- {npc:9462} Chieftain Bloodmaw
	["The northern Deadwood (level 53-55) camp just south of the tunnel. They drop feathers about half the time: the best feather spot. {npc:9462} gives 15 until Exalted."] = "북쪽의 마른가지일족(레벨 53-55)이 동굴 바로 남쪽에 야영하고 있습니다. 약 절반의 확률로 깃털을 떨어뜨리며, 깃털을 모으기에 가장 좋은 곳입니다. {npc:9462}은(는) 확고한 동맹까지 15를 줍니다.",

	-- Step 6: Back to Nafien
	-- {npc:15395} Nafien
	["Back to {npc:15395}"] = "{npc:15395}에게 돌아가기",
	-- {quest:8460} Timbermaw Ally
	["These quests and their kills bring you just past Unfriendly (500 from the start). If {quest:8460} paid you less (at level 60 in Classic: 30), kill about 40 more northern Deadwood. From Unfriendly the Timbermaw in the tunnel leave you alone."] = "",

	-- Step 7: Salfa
	-- {zone:1452} Winterspring · {npc:11556} Salfa
	["Walk through the tunnel to its {zone:1452} mouth; {npc:11556} stands just outside. Do not attack any Timbermaw: each one costs 25 reputation."] = "",

	-- Step 8: Winterfall Village
	-- {area:2244} Winterfall Village · {zone:1452} Winterspring · {area:2255} Everlook · {item:21383} Winterfall Spirit Beads · {npc:10199} Grizzle Snowpaw · {npc:10738} High Chief Winterfall
	["{area:2244} lies in the east of {zone:1452}, just past {area:2255}. Keep every {item:21383} you loot (10 reputation each later). The Shamans, Den Watchers and Ursas share their spawn points, so kill every furbolg in the village to make the ones you need appear; more Ursas walk the ridge just south-west of the village. {npc:10199} (rare) and {npc:10738}, in the cave at the back, give 25 until Exalted. Alliance: the Wintersaber Trainers' Winterfall Intrusion asks for the same Shamans and Ursas."] = "",
	-- {npc:10199} Grizzle Snowpaw
	["{npc:10199}, rare"] = "",
	-- {npc:10738} High Chief Winterfall
	["{npc:10738}, elite"] = "",

	-- Step 9: Back to Salfa
	-- {npc:11556} Salfa
	["Back to {npc:11556}"] = "{npc:11556}에게 돌아가기",
	-- {quest:8466} Feathers for Grazle · {quest:8467} Feathers for Nafien · {quest:8469} Beads for Salfa
	["{quest:8466}, {quest:8467} and {quest:8469} are open now: 50 reputation for 5 feathers or 5 beads, as often as you like. Do not hand them in yet."] = "",

	-- Step 10: Unfriendly to Neutral
	["Unfriendly to Neutral"] = "",
	-- {zone:1448} Felwood · {area:2246} Frostfire Hot Springs · {area:2243} Timbermaw Post · {npc:11556} Salfa · {area:2244} Winterfall Village
	["Unfriendly to Neutral is 3,000: about 540 more kills after these quests. Three camps: the northern Deadwood by the {zone:1448} mouth of the tunnel; the Winterfall camps around {area:2246} and {area:2243}, just south and south-east of {npc:11556} (Pathfinders give 6 a kill, Den Watchers and Totemics 5, the shortest walk to a turn-in); and {area:2244} in the east. Pick the least crowded. Keep all feathers and beads."] = "",
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["Deadwood Headdress Feathers: keep them"] = "",
	-- {item:21383} Winterfall Spirit Beads
	["{item:21383}: keep them"] = "",
	-- {area:2246} Frostfire Hot Springs
	-- plural, as words: Winterfall Pathfinders = {npc:7442} Winterfall Pathfinder
	["Winterfall Pathfinders, {area:2246}"] = "",

	-- Step 11: Deadwood Ritual Totem
	-- {quest:8470} Deadwood Ritual Totem · {npc:11558} Kernda · {zone:1448} Felwood
	-- plural, as words: Mana Potions = {item:3827} Mana Potion
	["The northern Deadwood rarely drop a {quest:8470} (about 3%). From Neutral, {npc:11558} takes it in the tunnel, on the {zone:1448} side: 150 reputation and two Major Healing and Mana Potions."] = "",

	-- Step 12: Kernda: the Deadwood totem
	-- {npc:11558} Kernda
	["{npc:11558}: the Deadwood totem"] = "",

	-- Step 13: Winterfall Ritual Totem
	-- {quest:8471} Winterfall Ritual Totem · {npc:11558} Kernda
	-- plural, as words: Mana Potions = {item:3827} Mana Potion
	["The Winterfall furbolgs rarely drop a {quest:8471} (3-4%). {npc:11558} takes it in the tunnel too: 150 reputation and three Major Healing and Mana Potions."] = "",

	-- Step 14: Kernda: the Winterfall totem
	-- {npc:11558} Kernda
	["{npc:11558}: the Winterfall totem"] = "",

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
	["Mosshoof Coursers"] = "{npc:8761}",
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
	["Neutral to Friendly"] = "중립에서 우호적",
	["Neutral to Friendly is 3,000: 600 kills. Keep all feathers and beads."] = "",

	-- Step 41: Meilosh
	-- {npc:11557} Meilosh · {zone:1448} Felwood · {item:13484} Recipe: Transmute Earth to Water · {item:22392} Formula: Enchant 2H Weapon - Agility · {item:20253} Pattern: Warbear Harness · {item:15065} Warbear Woolies · {quest:6031} Runecloth · {item:14342} Mooncloth · {item:15802} Mooncloth Boots
	["{npc:11557} stands in the tunnel, near its {zone:1448} mouth. From Friendly he sells: {item:13484} (1 gold 50 silver), {item:22392} (2 gold 50 silver), {item:20253} (1 gold 60 silver) and {item:15065} (2 gold). He also takes 30 {quest:6031} once for 100 reputation and a choice of shoulders or gauntlets, and Tailors with skill 290 can bring him 2 {item:14342} for 100 more and the {item:15802} pattern."] = "",

	-- Step 42: Runecloth for Meilosh
	-- {quest:6031} Runecloth · {npc:11557} Meilosh
	["{quest:6031} for {npc:11557}"] = "",
	-- {quest:6031} Runecloth
	["{quest:6031} drops from the humanoids of the level 50-60 zones, the Deadwood and Winterfall furbolgs among them."] = "",

	-- Step 43: Sacred Cloth
	-- {npc:11557} Meilosh · {item:14342} Mooncloth · {item:15802} Mooncloth Boots
	["Tailors with skill 290: {npc:11557} takes 2 {item:14342} once for 100 reputation and teaches the {item:15802}."] = "",

	-- Step 44: Friendly to Honored
	["Friendly to Honored"] = "우호적에서 존경",
	-- {npc:11557} Meilosh · {item:19445} Formula: Enchant Weapon - Agility · {item:19202} Pattern: Heavy Timbermaw Belt · {item:19044} Might of the Timbermaw · {skill:165} Leatherworking · {item:19047} Wisdom of the Timbermaw · {skill:197} Tailoring
	["Friendly to Honored is 6,000: 1,200 kills. Keep all feathers and beads. Honored opens at {npc:11557}: {item:19445} (3 gold), and for 2 gold 20 silver each {item:19202} and {item:19044} ({skill:165}) and {item:19047} ({skill:197})."] = "",

	-- Step 45: Honored to Revered
	["Honored to Revered"] = "존경에서 평판 우호",
	["Honored to Revered is 12,000: 2,400 kills, the last ones that count. Kills stop at 11,999 of 12,000 Honored and never tip you into Revered: when they stop, hand in one set of 5 feathers or beads to cross over. Saving every feather and bead pays off now: about 4,800 kills from the start to the end of Honored leave you with about 2,100 feathers and beads, and that is all of Revered to Exalted. Turning them in early would cost you about 2,400 more kills."] = "",
	-- {item:19445} Formula: Enchant Weapon - Agility · {skill:333} Enchanting
	["{item:19445} ({skill:333}), 3 gold"] = "",
	-- {quest:8467} Feathers for Nafien
	["{quest:8467}: once your kills stop, 5 feathers into Revered"] = "",
	-- {quest:8469} Beads for Salfa
	["{quest:8469}: or 5 beads"] = "",

	-- Step 46: Revered to Exalted
	["Revered to Exalted"] = "평판 우호에서 확고",
	-- {npc:15395} Nafien · {npc:11554} Grazle · {npc:11556} Salfa · {npc:14342} Ragepaw · {npc:10199} Grizzle Snowpaw · {npc:10738} High Chief Winterfall · {npc:11557} Meilosh · {item:19204} Pattern: Heavy Timbermaw Boots · {item:19049} Timbermaw Brawlers · {skill:165} Leatherworking · {item:19050} Mantle of the Timbermaw · {skill:197} Tailoring
	["Kills stopped at the end of Honored. Revered to Exalted is 21,000: 420 turn-ins, 2,100 feathers and beads. Hand in the feathers to {npc:15395} at the tunnel or {npc:11554} in the south, the beads to {npc:11556}, five at a time. The named furbolgs (Ror, Bloodmaw, {npc:14342}, {npc:10199}, {npc:10738}) still count. Revered opens at {npc:11557}, for 4 gold each: {item:19204} and {item:19049} ({skill:165}) and {item:19050} ({skill:197})."] = "",
	-- {quest:8467} Feathers for Nafien
	["{quest:8467}: 5 feathers, 50 reputation"] = "",
	-- {quest:8466} Feathers for Grazle
	["{quest:8466}: 5 feathers, 50 reputation"] = "",
	-- {quest:8469} Beads for Salfa
	["{quest:8469}: 5 beads, 50 reputation"] = "",

	-- Step 47: The Root of All Evil
	-- {npc:11555} Gorn One Eye · {npc:11557} Meilosh · {quest:8481} The Root of All Evil · {item:21144} Demon Summoning Torch · {npc:10738} High Chief Winterfall · {npc:15623} Xandivious · {item:21326} Defender of the Timbermaw
	["At Exalted, {npc:11555}, in the tunnel by {npc:11557}, gives {quest:8481}: plant his {item:21144} in the mouth of {npc:10738}'s cave and defeat the demon {npc:15623} (level 62, elite: bring a group). The reward is {item:21326}, a trinket that calls a Timbermaw ally, and 200 reputation."] = "",

	-- Step 48: Xandivious
	-- {area:2244} Winterfall Village · {npc:15623} Xandivious
	["{area:2244}, the cave at the back. Clear the furbolgs around the mouth first, plant the torch, kill {npc:15623} and loot the Essence from his Demon Bag."] = "",
	-- {npc:15623} Xandivious
	["{npc:15623}, 25 reputation"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Alternate Deadwood feathers ({npc:15395}) and Winterfall beads ({npc:11556}), whichever camp is less crowded."] = "덜 붐비는 야영지에 따라 마른가지일족 깃털({npc:15395})과 눈사태일족 구슬({npc:11556})을 번갈아 모으세요.",
	-- ["Deadwood furbolgs (level 48-50) camp at the southern end of {zone:1448}. Keep every {item:21377} they drop: {npc:11554} and {npc:15395} take them later."] = "마른가지일족 퍼볼그(레벨 48-50)가 {zone:1448} 남쪽 끝에 진을 치고 있습니다. 이들이 떨어뜨리는 {item:21377}은(는) 모두 챙기세요. 나중에 {npc:11554}와(과) {npc:15395}이(가) 받습니다.",
	-- ["Feathers and beads to Friendly"] = "깃털과 구슬로 약간 우호적까지",
	-- ["Feathers for {npc:11554} and Feathers for {npc:15395} (Deadwood Headdress Feathers) and Beads for {npc:11556} ({item:21383}) repeat as often as you like; every Deadwood or Winterfall kill counts as well. {area:2244} is the densest bead spot."] = "{npc:11554}을(를) 위한 깃털, {npc:15395}을(를) 위한 깃털(마른가지일족 깃털 머리장식), {npc:11556}에게 구슬 가져다주기({item:21383})는 원하는 만큼 반복할 수 있습니다. 마른가지일족이나 눈사태일족 처치도 평판에 포함됩니다. 구슬은 {area:2244}에서 가장 많이 나옵니다.",
	-- ["Feathers to Honored"] = "깃털로 우호적까지",
	-- ["Go through {faction:576} to its {zone:1452} exit; {npc:11556} stands just outside. The quests and kills so far usually reach Unfriendly, and then the Timbermaw let you pass. If they still show red, kill more Deadwood by the tunnel first."] = "{faction:576}을(를) 지나 {zone:1452} 쪽 출구로 가세요. {npc:11556}은(는) 출구 바로 밖에 있습니다. 지금까지의 퀘스트와 처치로 보통 약간 적대적에 도달하며, 그러면 나무구렁일족이 지나가게 해 줍니다. 아직 빨간색이면 먼저 동굴 근처의 마른가지일족을 더 처치하세요.",
	-- ["Keep turning in feathers and beads until Exalted."] = "확고한 동맹이 될 때까지 깃털과 구슬을 계속 제출하세요.",
	-- ["The northern Deadwood camps by the tunnel are the densest feather spot (35% drop chance there). Hand feathers to {npc:15395} at the tunnel, or to {npc:11554} in the south."] = "동굴 옆 북쪽 마른가지일족 야영지가 깃털이 가장 많이 나오는 곳입니다(획득 확률 35%). 깃털은 동굴 입구의 {npc:15395}(이)나 남쪽의 {npc:11554}에게 건네세요.",
	-- ["{area:2244} sits on the eastern side of {zone:1452}. Keep every {item:21383} you loot: {npc:11556} takes them."] = "{area:2244}은(는) {zone:1452} 동쪽에 있습니다. 획득한 {item:21383}은(는) 모두 챙기세요. {npc:11556}이(가) 받습니다.",
	-- ["{faction:576} starts out Hostile, and its furbolgs in the tunnels attack until you reach Unfriendly. Every Deadwood and Winterfall furbolg you kill raises it, so the quests below pay twice. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:576} 평판은 적대적에서 시작하며, 약간 적대적이 될 때까지 동굴의 나무구렁일족 퍼볼그가 공격합니다. 마른가지일족과 눈사태일족 퍼볼그를 처치할 때마다 평판이 오르므로 아래 퀘스트는 두 배로 보상합니다. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",
	-- ["{faction:576} to Exalted"] = "{faction:576}: 확고한 동맹까지",
	-- ["{faction:576} to Revered"] = "{faction:576}: 매우 우호적까지",
	-- ["{npc:11556}: Beads for {npc:11556}"] = "{npc:11556}: {npc:11556}에게 정기의 구슬 가져다주기",
	-- ["{npc:15395} waits in northern {zone:1448} at the tunnel into {faction:576}."] = "{npc:15395}은(는) {zone:1448} 북쪽, {faction:576}(으)로 들어가는 동굴 입구에서 기다립니다.",
	-- ["{npc:15395}: Feathers for {npc:15395}"] = "{npc:15395}: {npc:15395}을(를) 위한 깃털",
}
