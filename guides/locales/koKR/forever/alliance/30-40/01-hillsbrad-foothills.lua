-- Korean (koKR): the guide forever/alliance/30-40/01-hillsbrad-foothills (forever/alliance/30-40/01-hillsbrad-foothills.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: To Deepwater Tavern
	-- {area:2104} Deepwater Tavern
	["To {area:2104}"] = "",

	-- Step 2: Angerfang Encampment
	-- {area:1036} Angerfang Encampment · {object:671518} Tattered Spellbook
	["South-east from Menethil to the Dragonmaw's {area:1036}: the first catapult stands on the way, and the {object:671518} lies in the camp."] = "",

	-- Step 4: Angerfang Encampment
	-- {quest:474} Defeat Nek'rosh
	["The next step, {quest:474}, pits you against an elite chieftain: skip it."] = "다음 단계인 {quest:474}는 정예 족장과 싸워야 합니다. 건너뛰십시오.",
	-- {object:671518} Tattered Spellbook · {npc:2104} Captain Stoutfist
	["{object:671518}: for {npc:2104}"] = "{object:671518}: {npc:2104}에게",

	-- Step 5: Defeat Nek'rosh
	-- {npc:2091} Chieftain Nek'rosh
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:2091} is a level 32 elite: most classes solo it at level 34, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Shadowcasters stand on either side of him, and at least one is linked to him, so it joins when he is pulled. Non-elite centurions and captains are spread around his ring of tents."] = "",

	-- Step 6: Golm
	-- {npc:271462} Golm · {npc:271338} Ados · {npc:271458} Neru · {npc:271460} Modr · {item:279996} Goaz Stone
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:271462}, {npc:271338}, {npc:271458} and {npc:271460} are level 32 elites, each called up by using the {item:279996} beside it. Skip them if you are alone. {npc:271462} stands in the south-eastern hills."] = "",

	-- Step 7: Ados
	-- {area:1038} Dragonmaw Gates · {npc:271338} Ados · {item:279996} Goaz Stone
	["North-east to the {area:1038}: {npc:271338} stands at the gates (use the {item:279996})."] = "",

	-- Step 8: Dragonmaw Gates: kill these as you meet them
	-- {area:1038} Dragonmaw Gates
	["{area:1038}: kill these as you meet them"] = "",
	-- {area:1036} Angerfang Encampment · {quest:98283} Carnage · {area:205} Dun Modr
	["The whelps nest in the hills north-east of the {area:1036}; {quest:98283} prowls further north, and the Razormaw raptors hunt the highlands on the way north to {area:205}.\n{quest:98283} is elite: grouping up is advised."] = "",

	-- Step 9: Razormaw nests
	["Razormaw nests"] = "",
	-- {quest:98246} Trying Times · {quest:98283} Carnage
	-- plural, as words: Perfect Razormaw Eggs = {item:280132} Perfect Razormaw Egg
	["The Perfect Razormaw Eggs for {quest:98246} lie in the raptors' nests in the hills around {quest:98283}."] = "",

	-- Step 10: Neru
	-- {npc:271458} Neru · {area:1038} Dragonmaw Gates · {area:205} Dun Modr · {item:279996} Goaz Stone
	["{npc:271458} stands in the hills between the {area:1038} and {area:205} (use the {item:279996})."] = "",

	-- Step 11: The Green Belt
	-- {area:1025} The Green Belt · {npc:1244} Rethiel the Greenwarden · {quest:98283} Carnage
	-- plural, as words: Maddened Rotclaws = {npc:271334} Maddened Rotclaw
	["Maddened Rotclaws roam the {area:1025} around {npc:1244}; one of them drops the flesh. {npc:1244} takes the quest only with {quest:98283}'s head too."] = "",

	-- Step 12: Rethiel the Greenwarden
	-- {quest:98283} Carnage
	["With {quest:98283}'s head and the flesh"] = "",

	-- Step 13: Dun Modr
	-- {area:205} Dun Modr · {npc:1071} Longbraid the Grim · {npc:1075} Rhag Garmason · {object:147516} Dark Iron
	["North along the road to {area:205}. {npc:1071} and {npc:1075} stand together in the dwarves' camp on the east side of the road; the {object:147516} ruins west of it are full of elites."] = "",

	-- Step 14: Captive Fire Elemental
	-- {npc:271481} Captive Fire Elemental · {object:147516} Dark Iron · {npc:1364} Balgaras the Foul · {npc:1072} Roggo Harlbarrow
	["These are elite mobs: grouping up is encouraged, look for people to do it with. The {npc:271481} is held at the far west end of the {object:147516} ruins, past level 27-30 elite dwarves, and {npc:1364} (34, elite) can be among them. Lead it east out of the ruins, then hand it in to {npc:1072} in the camp. Skip it if you are alone."] = "",

	-- Step 15: Modr
	-- {npc:271460} Modr · {area:205} Dun Modr · {item:279996} Goaz Stone
	["{npc:271460} stands in the ruins of {area:205} (use the {item:279996})."] = "",

	-- Step 16: The Villards
	["The Villards"] = "빌라드 남매",
	-- {npc:5683} Corma Villard · {area:205} Dun Modr · {area:880} Thandol Span · {npc:271322} Essene Villard · {npc:1075} Rhag Garmason · {quest:87318} Hearts of the Lost
	-- plural, as words: Dark Iron Saboteurs = {npc:1052} Dark Iron Saboteur
	["{npc:5683} waits on the road north of {area:205}, towards the {area:880}; {npc:271322} a short walk further north-east, and Ebenezer Rustlocke's corpse lies under the span beside her. Rustlocke's parchment goes back to {npc:1075}.\n{npc:5683} may not offer {quest:87318} yet: if she doesn't, skip it.\nTwo elite Dark Iron Saboteurs stand by the corpse inside the span: pull them one at a time, or loot the corpse and run out."] = "",
	-- {object:2652} Ebenezer Rustlocke's Corpse
	["{object:2652}, inside"] = "",
	["the same corpse"] = "",

	-- Step 17: Rhag Garmason
	-- {area:205} Dun Modr · {npc:1075} Rhag Garmason · {object:147516} Dark Iron
	["Back down the road to {area:205}: {npc:1075} wants the {object:147516} explosives under the far end of the span destroyed."] = "",

	-- Step 18: The Cache of Explosives
	-- {object:2704} Cache of Explosives
	["The {object:2704}"] = "",
	-- {area:880} Thandol Span
	-- plural, as words: Dark Irons = {object:147516} Dark Iron
	["Over the {area:880}: the Dark Irons' cache of explosives sits by its Arathi end."] = "",

	-- Step 19: Waterlogged Envelope
	["Underwater"] = "",

	-- Step 20: Rhag Garmason again
	-- {npc:1075} Rhag Garmason
	["{npc:1075} again"] = "",
	-- {area:205} Dun Modr
	["Back over the span and down the road through {area:205} on the way south."] = "",
	-- {npc:2700} Captain Nials · {area:320} Refuge Pointe
	["for {npc:2700} at {area:320}, in 05-arathi-highlands"] = "",

	-- Step 22: Howin Kindfeather
	-- {quest:98246} Trying Times
	["{quest:98246}: the eggs"] = "",

	-- Step 23: Prospector Whelgar
	["Below ground"] = "",
	-- {npc:2916} Historian Karnik · {zone:1455} Ironforge
	["For {npc:2916} in {zone:1455}, at the end of this guide"] = "{zone:1455}의 {npc:2916}에게, 이 가이드 마지막에",

	-- Step 24: Menethil Harbor
	["West along the road to Menethil."] = "길을 따라 서쪽 메네실 항구로 가십시오.",
	["On the top floor"] = "",
	-- {npc:4455} Red Jack Flint · {quest:1132} Fiora Longears
	["{npc:4455}, by the keep's door: for {quest:1132} in Theramore, in the next guide"] = "",

	-- Step 25: Menethil Harbor
	-- {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep
	["{npc:2104} stands on the top floor of {area:2103}: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:2104} Captain Stoutfist · {npc:270637} Howin Kindfeather
	["{npc:2104}: for {npc:270637}, back east along the road"] = "",

	-- Step 26: Howin Kindfeather
	-- {area:1025} The Green Belt · {npc:270637} Howin Kindfeather · {npc:1244} Rethiel the Greenwarden
	["Back east along the road to the {area:1025}: {npc:270637} camps among the Fenrunners, just west of {npc:1244}. Then west again to Menethil for the boat."] = "",
	-- {zone:1455} Ironforge
	["For King Magni in {zone:1455}, at the end of this guide"] = "{zone:1455}의 국왕 마그니 브론즈비어드에게, 이 가이드 마지막에",

	-- Step 27: Level 30.8
	["Level 30.8"] = "",
	-- {quest:474} Defeat Nek'rosh · {area:133} Gnomeregan · {area:796} Scarlet Monastery
	["Skipped {quest:474} and short of 30.8? Kill the Bluegill murlocs on the coast south of Menethil until level 30.8. Or, with a group, run the {area:133} dungeon or the {area:796} dungeon (Graveyard) instead."] = "",
	-- {npc:1418} Bluegill Raider
	["grind on {npc:1418}"] = "",

	-- Step 29: Boat to Southshore
	-- {area:271} Southshore
	["Boat to {area:271}"] = "{area:271}행 배",

	-- Step 30: Southshore
	-- {npc:2711} Phin Odelic · {npc:2430} Chef Jessen · {npc:2382} Darren Malvew · {npc:2381} Micha Yance · {npc:2438} Bartolo Ginsetti · {npc:2366} Barkeep Kelly · {quest:98463} Talk of the Town
	["Off the boat, walk up the pier into town: {npc:2711} and Lieutenant Farren stand by the inn, {npc:2430} upstairs, {npc:2382} east of it; the flight master is at the north end, {npc:2381} and {npc:2438} between her and the inn, Maleb in the town hall at the west side.\n{npc:2366} may not offer {quest:98463} on Forever: if she doesn't, skip it."] = "",
	-- {npc:2711} Phin Odelic
	["{npc:2711}: his trail leads to Arathi"] = "{npc:2711}: 그의 흔적은 아라시 고원으로 이어집니다",
	-- {npc:2228} Lieutenant Farren Orinelle
	["{npc:2228}, inside"] = "",
	-- {npc:2366} Barkeep Kelly · {area:35} Booty Bay
	["{npc:2366}, in the inn: for {area:35} (04-stranglethorn-vale)"] = "{npc:2366}, 여관 안: {area:35}용 (04-stranglethorn-vale)",
	-- {npc:2430} Chef Jessen
	["{npc:2430}, upstairs"] = "",
	-- {npc:2382} Darren Malvew
	["{npc:2382}: the lions come later"] = "{npc:2382}: 사자는 나중에",
	-- {item:3713} Soothing Spices · {npc:2381} Micha Yance
	["{item:3713}, from {npc:2381}"] = "{item:3713}, {npc:2381}에게서",
	-- {npc:2276} Magistrate Henry Maleb
	["{npc:2276}, inside"] = "",

	-- Step 31: Bartolo Ginsetti
	-- {npc:2438} Bartolo Ginsetti · {item:3719} Hillman's Cloak · {skill:165} Leatherworking · {item:2997} Bolt of Woolen Cloth · {skill:197} Tailoring
	["{npc:2438} makes a yeti fur cloak for anyone who brings a {item:3719} ({skill:165}) and a {item:2997} ({skill:197}); no vendor sells either, so this step shows only when you carry both."] = "",
	-- {npc:2438} Bartolo Ginsetti · {item:3719} Hillman's Cloak · {item:2997} Bolt of Woolen Cloth
	["{npc:2438}, between the flight master and the inn: he wants a {item:3719} and a {item:2997} too"] = "",

	-- Step 32: Torn Fin murlocs
	["Torn Fin murlocs"] = "너덜지느러미멀록",
	-- {area:295} Western Strand · {area:271} Southshore
	["The Torn Fin murlocs crowd the {area:295}, south-west of {area:271}.\nCareful: One camp holds a tight cluster of Oracles that all aggro together."] = "",

	-- Step 33: Farren
	["Farren"] = "파렌",
	["Inside"] = "",

	-- Step 34: Murloc heads
	["Murloc heads"] = "멀록 머리",
	["Back to the same murlocs; not every one drops a head."] = "같은 멀록에게 돌아가십시오. 모두 머리를 떨어뜨리지는 않습니다.",

	-- Step 36: Daggerspine naga
	["Daggerspine naga"] = "비수가시일족 나가",
	-- {area:271} Southshore
	["The naga hold the shore south-east of {area:271}."] = "나가가 {area:271} 남동쪽 해안을 차지하고 있습니다.",

	-- Step 37: Farren
	-- {object:2117} Stormwind Keep
	["A report for {object:2117}; inside"] = "",

	-- Step 39: Southshore
	-- {npc:251493} Captain McManus · {quest:98059} Hillsbrad's Hoard · {item:279386} Sealed Company Request · {area:287} Hillsbrad · {area:271} Southshore
	["{npc:251493} stands north-west of the flight master, on the way north to the yeti cave.\n{quest:98059}: {npc:251493} hands you a {item:279386} for the {area:287} council, in the farms west of {area:271}; you deliver it after the Syndicate camp."] = "",

	-- Step 40: Yeti cave
	["Yeti cave"] = "설인 동굴",
	-- {area:271} Southshore
	["The yetis live in the cave in the hills north of {area:271}, on the way north to the Syndicate camp."] = "",

	-- Step 41: Alterac Mountains
	["Syndicate camp"] = "비밀결사대 야영지",

	-- Step 42: Syndicate camp
	-- {area:287} Hillsbrad · {area:272} Tarren Mill
	["The Syndicate camp sits on the Alterac border in northern {area:287}, west of {area:272} (Horde); the documents lie in the camp, and its Footpads and Thieves are the Syndicate Maleb wants."] = "",

	-- Step 43: Hillsbrad Fields
	-- {area:286} Hillsbrad Fields
	["South-west from the Syndicate camp to the {area:286} farms."] = "",

	-- Step 44: Hillsbrad council
	-- {area:287} Hillsbrad
	["{area:287} council"] = "",
	-- {item:279386} Sealed Company Request · {area:287} Hillsbrad
	["Use the {item:279386} at the {area:287} council."] = "",

	-- Step 45: Snapjaws
	["Snapjaws"] = "무쇠턱거북",
	-- {area:271} Southshore · {area:272} Tarren Mill
	["The Snapjaw turtles bask along the river east of {area:271}, south of {area:272} (Horde)."] = "무쇠턱거북이 {area:271} 동쪽, {area:272}(호드) 남쪽 강을 따라 햇볕을 쬡니다.",

	-- Step 47: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "",
	-- {area:271} Southshore
	["{area:271} flight master"] = "",

	-- Step 48: Hall of Explorers
	-- {npc:1356} Prospector Stormpike · {npc:2916} Historian Karnik · {npc:5637} Roetten Stonehammer · {object:32356} Hall of Explorers (no name in this language: may be words)
	["{npc:1356}, {npc:2916} and {npc:5637} stand in the {object:32356}, north-east of the flight master."] = "",
	["Level 30 and 32 spells"] = "30, 32레벨 주문",

	-- Step 52: King Magni Bronzebeard
	-- {npc:2784} King Magni Bronzebeard · {object:171709} High Seat
	["{npc:2784}, the {object:171709}"] = "{npc:2784}, {object:171709}",

	-- Step 53: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "{zone:1453}로 비행",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "",

	-- Step 54: Elling Trias
	-- {object:2096} Trade District
	["The cheese shop in the {object:2096}."] = "{object:2096}의 치즈 가게입니다.",

	-- Step 55: Dashel Stonefist
	-- {npc:4961} Dashel Stonefist · {object:2100} Old Town
	["{npc:4961} waits in the Pig and Whistle tavern in {object:2100}; he and his two thugs fight you, but stop once beaten."] = "{npc:4961}은(는) {object:2100}의 돼지와 휘파람 선술집에서 기다립니다. 그와 부하 둘이 덤벼들지만 쓰러뜨리면 멈춥니다.",
	-- {npc:4961} Dashel Stonefist
	["Beat {npc:4961} and his thugs: they give up"] = "",

	-- Step 56: The Islander
	-- {npc:5479} Wu Shen · {object:2100} Old Town · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens · {area:392} Ratchet
	["{npc:5479} trains warriors in {object:2100}, beside the Pig and Whistle. {npc:6236} waits on {area:720} in the {zone:1413}, on the way to {area:392} much later (40-50/01)."] = "{npc:5479}은(는) {object:2100}의 돼지와 휘파람 선술집 옆에서 전사를 가르칩니다. {npc:6236}은(는) {zone:1413}의 {area:720}에서 기다립니다. 한참 뒤 {area:392}(으)로 가는 길에 있습니다(40-50/01).",

	-- Step 58: Cathedral of Light
	["Cathedral of Light"] = "빛의 대성당",

	-- Step 60: Mage Quarter
	-- {npc:2708} Archmage Malin · {object:2164} Slaughtered Lamb · {npc:5081} Connor Rivers · {object:2101} Mage Quarter
	["{npc:2708} is in the {object:2164}; {npc:5081} south of the {object:2101}."] = "",

	-- Step 61: Druid training
	["Druid training"] = "드루이드 수련",
	-- {zone:1455} Ironforge · {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {object:2101} Mage Quarter
	["{zone:1455} has no druid trainer: {npc:5504} stands in {zone:1453}, north-west of the {object:2101}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A new {item:279996}, for the four titan watchers around the {zone:1437}"] = "새 {item:279996}, {zone:1437} 주변 티탄 감시자 넷을 위한 것",
	-- ["A report for {object:2117}"] = "{object:2117}에 보낼 보고서",
	-- ["Back south down the road to the excavation site."] = "길을 따라 남쪽 발굴 현장으로 돌아가십시오.",
	-- ["Destroy the four sets of Attack Plans in the camp for {quest:98221}."] = "{quest:98221}을(를) 위해 야영지의 공격 계획 네 묶음을 파괴하십시오.",
	-- ["Fly to {zone:1453}"] = "{zone:1453}(으)로 비행",
	-- ["Follow the road east to {area:118}."] = "길을 따라 동쪽 {area:118}(으)로 가십시오.",
	-- ["Follow the road north-east into the {area:1025}: {npc:270637} camps beside it, {npc:1244} a short way east."] = "길을 따라 북동쪽 {area:1025}로 가십시오. {npc:270637}은(는) 그 옆에 야영하고 있고, {npc:1244}은(는) 조금 동쪽에 있습니다.",
	-- ["For King Magni in {zone:1455}, at the end of this guide"] = "{zone:1455}의 국왕 마그니 브론즈비어드에게, 이 가이드 마지막에",
	-- ["For {npc:2916} in {zone:1455}, at the end of this guide"] = "{zone:1455}의 {npc:2916}에게, 이 가이드 마지막에",
	-- ["From {npc:2432} in {area:271}"] = "{area:271}의 {npc:2432}에게서",
	-- ["Golm"] = "골름",
	-- ["North along the road to {area:205}. {npc:271460} stands in the ruins (use the {item:279996}); the {npc:271481} is held on the west side: lead it out to {npc:1072}."] = "길을 따라 북쪽 {area:205}(으)로 가십시오. {npc:271460}은(는) 폐허 안에 있습니다({item:279996} 사용). {npc:271481}은(는) 서쪽에 갇혀 있으니 {npc:1072}에게 데려가십시오.",
	-- ["North-east to the {area:1038}: the {npc:271373} are held there, and {npc:271338} stands at the gates (use the {item:279996})."] = "북동쪽 {area:1038}(으)로 가십시오. {npc:271373}이(가) 그곳에 갇혀 있으며, {npc:271338}이(가) 성문에 있습니다({item:279996} 사용).",
	-- ["Pick up everything in town before heading out. Off the boat, {npc:251493} is the first you meet, north-west of the flight master; {npc:2381} and {npc:2438} stand between the flight master and the inn, Farren and {npc:2366} at the inn, Maleb in the town hall."] = "출발 전에 마을의 퀘스트를 모두 수락하십시오. 배에서 내리면 비행 조련사 북서쪽의 {npc:251493}을(를) 먼저 만납니다. {npc:2381}와(과) {npc:2438}은(는) 비행 조련사와 여관 사이에, 파렌과 {npc:2366}은(는) 여관에, 말레브는 마을 회관에 있습니다.",
	-- ["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; Neru stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "새끼 붉은용이 성문 서쪽 언덕에, 광기에 물든 썩은발톱이 {area:1025}에, 무쇠턱 랩터가 북쪽 비탈에 가득합니다. 네루는 북동쪽에 있습니다({item:279996} 사용).\n{quest:98283}은(는) 정예이므로 파티를 권장합니다.",
	-- ["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; {npc:271458} stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "새끼 붉은용이 성문 서쪽 언덕에, 광기에 물든 썩은발톱이 {area:1025}에, 무쇠턱 랩터가 북쪽 비탈에 가득합니다. {npc:271458}은(는) 북동쪽에 있습니다({item:279996} 사용).\n{quest:98283}은(는) 정예이므로 파티를 권장합니다.",
	-- ["South to the Dragonmaw's {area:1036}: the first catapult stands on the way, and the {object:671518} lies in the camp."] = "남쪽의 용아귀부족 {area:1036}(으)로 가십시오. 가는 길에 첫 번째 투석기가 있고, {object:671518}은(는) 야영지 안에 있습니다.",
	-- ["South to the Dragonmaw's {area:1036}; the {object:671518} lies in the camp."] = "남쪽의 용아귀부족 {area:1036}(으)로 가십시오. {object:671518}은(는) 야영지 안에 있습니다.",
	-- ["Take the {area:2257} from the {object:28027} to {zone:1455}."] = "{object:28027}에서 {area:2257}을(를) 타고 {zone:1455}(으)로 가십시오.",
	-- ["The Goaz Warders stand just west of Whelgar's camp: use the {item:279996} he gave you beside one."] = "Goaz Warder들은 웰가의 야영지 바로 서쪽에 있습니다. 그 중 하나 옆에서 그가 준 {item:279996}을(를) 사용하십시오.",
	-- ["The Syndicate camp sits on the Alterac border in northern {area:287}, west of {area:272} (Horde); the documents lie in the camp."] = "비밀결사대 야영지는 {area:272}(호드) 서쪽, {area:287} 북부의 알터랙 경계에 있습니다. 문서는 야영지 안에 있습니다.",
	-- ["The Torn Fin murlocs crowd the {area:295}, south-west of {area:271}."] = "너덜지느러미멀록이 {area:271} 남서쪽 {area:295}에 몰려 있습니다.",
	-- ["The yetis live in the cave in the hills north of {area:271}, on your way back south."] = "설인은 {area:271} 북쪽 언덕의 동굴에 삽니다. 남쪽으로 돌아가는 길에 있습니다.",
	-- ["West to the farms of {area:287}: place the {item:279386} on the bookkeeping table in the town hall, where {npc:2335} and the councilmen stand."] = "서쪽 {area:287} 농장으로 가십시오. {npc:2335}와(과) 원로들이 있는 마을 회관의 장부 탁자에 {item:279386}을(를) 놓으십시오.",
	-- ["Whelps, raptors and {npc:271458}"] = "새끼 용, 랩터, {npc:271458}",
	-- ["{area:287} town hall"] = "{area:287} 마을 회관",
	-- ["{area:287}'s town hall"] = "{area:287} 마을 회관",
	-- ["{npc:1244}: {quest:98283}, an elite raptor"] = "{npc:1244}: {quest:98283}, 정예 랩터",
	-- ["{npc:2104} stands in {area:2103}; {npc:2094} and {npc:270844} stand together by the north gate."] = "{npc:2104}은(는) {area:2103}에 있으며, {npc:2094}와(과) {npc:270844}은(는) 북문 옆에 함께 있습니다.",
	-- ["{npc:2104} stands in {area:2103}; {npc:2094} stands by the north gate."] = "{npc:2104}은(는) {area:2103}에 있으며, {npc:2094}은(는) 북문 옆에 있습니다.",
	-- ["{npc:2104}: for {npc:270637}"] = "{npc:2104}: {npc:270637}에게",
	-- ["{npc:2438} also wants a {item:3719}, a {item:2997} and {item:2321}: crafted or bought; the cloak is turned in when you are back in {area:271} later."] = "{npc:2438}은(는) {item:3719}, {item:2997}, {item:2321}도 원합니다. 제작하거나 구매하십시오. 망토는 나중에 {area:271}에 돌아와서 제출합니다.",
	-- ["{npc:270844}: for {npc:3649} in {area:442} (02-desolace)"] = "{npc:270844}: {area:442}의 {npc:3649}에게 (02-desolace)",
	-- ["{npc:2708} is in the {object:2164}; {npc:211033} near the canal; {npc:5081} south of the {object:2101}."] = "{npc:2708}은(는) {object:2164}에, {npc:211033}은(는) 운하 근처에, {npc:5081}은(는) {object:2101} 남쪽에 있습니다.",
	-- ["{npc:271462} stands in the south-eastern hills: use the {item:279996} beside it."] = "{npc:271462}은(는) 남동쪽 언덕에 있습니다. 그 옆에서 {item:279996}을(를) 사용하십시오.",
	-- ["{npc:2784}, the {object:171709}"] = "{npc:2784}, {object:171709}",
	-- ["{npc:5683} waits north of {area:205} by the {area:881}; {npc:271322} a short walk further north-east."] = "{npc:5683}은(는) {area:205} 북쪽 {area:881} 옆에서 기다리고, {npc:271322}은(는) 조금 더 북동쪽에 있습니다.",
	-- ["{zone:1455} has no druid trainer: train with {npc:5504} in {zone:1453} before the tram."] = "{zone:1455}에는 드루이드 상급자가 없습니다. 전차를 타기 전에 {zone:1453}의 {npc:5504}에게 수련하십시오.",
}
