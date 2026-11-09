-- Korean (koKR): the guide forever/alliance/04-redridge-mountains (forever/alliance/04-redridge-mountains.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Stormwind
	-- {zone:1429} Elwynn Forest · {quest:174} Look to the Stars · {area:42} Darkshire · {item:4371} Bronze Tube · {npc:3133} Herble Baubbletump · {object:2096} Trade District
	["Train, then leave by the main gate and follow the road east through {zone:1429}.\n{quest:174} in {area:42} needs a {item:4371}. Its vendors keep only one or two, and {npc:3133} in {area:42} is nearly always sold out: buy one at the Auction House in the {object:2096} on your way out. An engineer can make one too."] = "",
	["Level 18 and 20 spells"] = "18레벨과 20레벨 주문",
	-- {item:4371} Bronze Tube · {quest:174} Look to the Stars · {area:42} Darkshire
	["{item:4371}: the Auction House, for {quest:174} in {area:42}"] = "",

	-- Step 2: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Polearms from {npc:11867} ({object:2096}, 1 gold); two-handers level a Warrior fastest."] = "",

	-- Step 3: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Polearms from {npc:11867} ({object:2096}, 1 gold); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "",

	-- Step 4: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "",

	-- Step 5: Shaman training
	["Shaman training"] = "주술사 훈련",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back."] = "{zone:1453}에는 주술사 상급자가 없습니다. {object:28027}에서 {area:2257}을(를) 타고 {zone:1455}(으)로 가서 {npc:258098}에게 훈련을 받은 뒤, 지하철을 타고 돌아오세요.",

	-- Step 6: Fly to Sentinel Hill
	-- {area:108} Sentinel Hill
	["Fly to {area:108}"] = "",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "",

	-- Step 7: Half Pendant of Aquatic Endurance
	-- {area:108} Sentinel Hill · {object:177790} Strange Lockbox
	["Fly to {area:108} and head north-west to the coast: the {object:177790} lies on the sea floor off the shore. Then head east along the road through Elwynn."] = "",
	-- {item:15882} Half Pendant of Aquatic Endurance · {object:177790} Strange Lockbox
	["{item:15882}: the {object:177790}"] = "{item:15882}: {object:177790}",

	-- Step 8: Back to Elwynn Forest
	-- {zone:1429} Elwynn Forest
	["Back to {zone:1429}"] = "",
	-- {zone:1429} Elwynn Forest
	["The road into {zone:1429}"] = "",

	-- Step 9: Elwynn Forest
	-- {area:91} Tower of Azora
	["The {area:91}"] = "{area:91}",

	-- Step 10: Theocritus
	["On the top floor"] = "",

	-- Step 11: Henze Faulk
	-- {area:91} Tower of Azora · {area:86} Stone Cairn Lake · {npc:6172} Henze Faulk · {item:6866} Symbol of Life · {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["On the road east, past the {area:91}, head north from the bridge to {area:86}. {npc:6172} lies south of the lake: use the {item:6866} on him. The Defias Rogue Wizards around him carry the {item:6846}."] = "",
	-- {item:6866} Symbol of Life · {npc:6172} Henze Faulk
	["Use the {item:6866} on {npc:6172}"] = "{npc:6172}에게 {item:6866} 사용",
	-- {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["{item:6846}: Defias Rogue Wizards"] = "{item:6846}: 데피아즈단 견습마술사",

	-- Step 12: Three Corners
	-- {area:1002} Three Corners · {zone:1431} Duskwood
	["The road east through Elwynn crosses into Redridge at {area:1002}, where the roads to Redridge, {zone:1431} and Elwynn meet: south to {zone:1431} first."] = "",

	-- Step 14: Darkshire
	-- {area:1002} Three Corners · {zone:1431} Duskwood · {area:42} Darkshire · {item:4371} Bronze Tube · {quest:174} Look to the Stars · {npc:3133} Herble Baubbletump · {npc:276} Viktori Prism'Antras
	["Follow the road south from {area:1002} into {zone:1431}; {area:42} lies on the east side of the forest.\nNo {item:4371} for {quest:174}? {npc:3133}, in the house beside {npc:276}, keeps only one and is usually sold out. Without one, right-click the quest in the guide window and skip it.\n{npc:276}'s house stands at the east end of town. {npc:3133} sells engineering goods in the house beside it."] = "",
	-- {npc:2409} Felicia Maline
	["{npc:2409}, at the north end of town"] = "{npc:2409}, 마을 북쪽 끝",
	-- {npc:265} Madame Eva
	["{npc:265}, in her house by the tavern; inside"] = "",
	-- {npc:265} Madame Eva
	["{npc:265}, inside"] = "",
	-- {npc:6790} Innkeeper Trelayne
	["{npc:6790}, Scarlet Raven Tavern"] = "{npc:6790}, 여관",
	-- {npc:267} Clerk Daltry
	["{npc:267}, in the town hall"] = "{npc:267}, 마을 회관",
	-- {npc:264} Commander Althea Ebonlocke
	["{npc:264}, in the town hall"] = "{npc:264}, 마을 회관",
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, in the house behind the town hall"] = "{npc:268}, 마을 회관 뒤 집",
	-- {npc:633} Elaine Carevin
	["{npc:633}, at the south end of town; inside"] = "",
	-- {npc:633} Elaine Carevin · {npc:288} Jitters · {quest:163} Raven Hill
	["{npc:633}: {npc:288}, at {quest:163}"] = "",
	-- {item:4371} Bronze Tube · {npc:3133} Herble Baubbletump
	["{item:4371}, from {npc:3133}, if you have none"] = "{item:4371}, 없다면 {npc:3133}에게서",
	-- {npc:276} Viktori Prism'Antras
	["{npc:276}, inside"] = "",
	-- {npc:302} Blind Mary
	["For {npc:302}, on the hill south-east of town"] = "",

	-- Step 15: Tranquil Gardens Cemetery: kill these as you meet them
	-- {area:121} Tranquil Gardens Cemetery
	["{area:121}: kill these as you meet them"] = "",
	-- {area:42} Darkshire · {npc:302} Blind Mary · {zone:1431} Duskwood · {item:2378} Skeleton Finger
	-- plural, as words: Skeletal Warriors = {npc:48} Skeletal Warrior · Skeletal Mages = {npc:203} Skeletal Mage
	["Skeletal Warriors and Skeletal Mages walk among the graves south-east of {area:42}, below {npc:302}'s house on the hill. Every skeleton in {zone:1431} can drop a {item:2378}.\nCareful: Because the skeletons stand near each other, running straight in tends to pull several at once."] = "",

	-- Step 16: Watcher Dodds
	-- {npc:888} Watcher Dodds · {area:245} Yorgen Farmstead
	["{npc:888} stands south of the road, at the {area:245}."] = "{npc:888}은(는) 길 남쪽 {area:245}에 서 있습니다.",

	-- Step 17: Raven Hill
	-- {quest:163} Raven Hill · {object:673515} Memory of Valor · {npc:288} Jitters
	["Continue west to {quest:163}. The {object:673515} glows by the ruined house south of the road; {npc:288} hides in the house at the west end of the village."] = "",
	-- {item:281046} Raven Hill Tome · {object:673515} Memory of Valor
	["{item:281046}, from the {object:673515}"] = "{object:673515}에서 {item:281046}",
	-- {npc:272} Chef Grual · {area:42} Darkshire
	["for {npc:272} in {area:42}"] = "",

	-- Step 18: Sven's Camp
	-- {npc:311} Sven Yorgen · {npc:893} Lars
	["Follow the road north-west past the cemetery to {npc:311}'s camp on the far west edge of the forest. {npc:893} stands beside {npc:311}."] = "묘지를 지나 길을 따라 북서쪽으로, 숲 서쪽 끝의 {npc:311}의 야영지까지 가십시오. {npc:893}은(는) {npc:311} 옆에 서 있습니다.",

	-- Step 19: The Hushed Bank: kill these as you meet them
	-- {area:1097} The Hushed Bank
	["{area:1097}: kill these as you meet them"] = "",
	-- {npc:289} Abercrombie · {area:1097} The Hushed Bank · {quest:163} Raven Hill · {npc:311} Sven Yorgen · {zone:1436} Westfall
	-- plural, as words: Pygmy Venom Web Spiders = {npc:539} Pygmy Venom Web Spider
	["Rabid Dire Wolves roam the woods around the cemetery and {npc:289}, Starving Dire Wolves the hills north-east of him. Pygmy Venom Web Spiders are the small spiders, and few: most crawl along the {area:1097} west of {quest:163}, fewer up north towards {npc:311}'s camp; they drop the venom too. Every ghoul of the cemetery's northern half can drop a fang. Wolves and the bigger spiders share the {zone:1436} border, so pull with care."] = "",
	-- {item:1130} Vial of Spider Venom
	-- plural, as words: Pygmy Venom Web Spiders = {npc:539} Pygmy Venom Web Spider · Venom Web Spiders = {npc:217} Venom Web Spider · Green Recluses = {npc:569} Green Recluse
	["{item:1130}: Pygmy Venom Web Spiders, Venom Web Spiders and Green Recluses"] = "",

	-- Step 20: Abercrombie
	-- {area:492} Raven Hill Cemetery
	["The hermit's shack stands in the woods north-east of the {area:492}."] = "은둔자의 오두막은 {area:492} 북동쪽 숲속에 있습니다.",

	-- Step 21: Raven Hill Cemetery: kill these as you meet them
	-- {area:492} Raven Hill Cemetery
	["{area:492}: kill these as you meet them"] = "",
	-- {npc:522} Mor'Ladim
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Skeletal Fiends = {npc:531} Skeletal Fiend
	["The cemetery lies north of the village. Skeletal Horrors and Skeletal Fiends walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "묘지는 마을 북쪽에 있습니다. 묘지 남쪽 절반에는 해골 병사와 해골 악령이 돌아다닙니다. 정예인 {npc:522}이(가) 무덤 사이를 배회하니 멀리하십시오.",

	-- Step 22: Watcher Dodds
	-- {area:245} Yorgen Farmstead
	["Head back east along the road to the {area:245}."] = "",

	-- Step 23: Yorgen Farmstead
	["The mound of loose dirt lies south of the farmhouse, by the old stump."] = "대충 덮인 흙무더기는 농가 남쪽, 오래된 그루터기 옆에 있습니다.",

	-- Step 24: Darkshire
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, inside"] = "",
	-- {npc:272} Chef Grual
	["{npc:272}, in the Scarlet Raven Tavern"] = "",
	-- {npc:663} Calor
	["{npc:663}, by the town hall"] = "{npc:663}, 마을 회관 옆",

	-- Step 26: Redridge Mountains
	-- {area:42} Darkshire · {area:1002} Three Corners
	["Back north along the road from {area:42} to {area:1002}."] = "",

	-- Step 27: Lakeridge Highway
	-- {area:68} Lake Everstill · {npc:903} Guard Howe
	["Follow the road along the south shore of {area:68} to the gryphon master. {npc:903} stands by the road next to her."] = "",

	-- Step 28: Lake Everstill's murlocs: kill these as you meet them
	-- {area:68} Lake Everstill
	["{area:68}'s murlocs: kill these as you meet them"] = "",
	-- {area:68} Lake Everstill
	-- plural, as words: Murloc Flesheaters = {npc:422} Murloc Flesheater
	["Murloc Flesheaters and Tidecallers line the south shore of {area:68}, just east of the gryphons and the bridge. Any of them can carry a fin."] = "",

	-- Step 29: Lakeshire
	-- {npc:381} Dockmaster Baren · {npc:900} Bailiff Conacher · {npc:342} Martie Jainrose · {npc:382} Marshal Marris · {quest:98386} Alther's Mill
	["Cross the long bridge north into town: {npc:381} on the docks, {npc:900} in the town hall, the innkeeper in the inn, {npc:342} in her garden at the west end. {npc:382}'s Blackrock quests and {quest:98386} came with you from your first Redridge visit."] = "",
	-- {npc:900} Bailiff Conacher
	["{npc:900}, in the town hall"] = "",
	["The Wanted poster by the inn"] = "여관 옆의 현상수배 전단",

	-- Step 30: Bellygrub
	-- {npc:345} Bellygrub · {area:69} Lakeshire · {npc:342} Martie Jainrose
	["{npc:345} (level 24) roots around the pen just west of {area:69}, beside {npc:342}'s garden. Pull him away from the other boars and fight at full health."] = "",

	-- Step 31: Martie Jainrose
	-- {npc:342} Martie Jainrose
	["{npc:342}'s garden is at the west end of town."] = "",

	-- Step 32: Lakeshire
	-- {npc:342} Martie Jainrose
	["Back east through town from {npc:342}'s garden: two Wanted posters hang on the town hall doorway."] = "",
	["The Wanted poster on the town hall doorway"] = "",
	["The Wanted poster beside it"] = "",

	-- Step 33: Alther's Mill
	-- {quest:98386} Alther's Mill
	-- plural, as words: Greater Tarantulas = {npc:505} Greater Tarantula · Tarantula Eggs = {object:673101} Tarantula Egg
	["Greater Tarantulas crawl on the slopes around {quest:98386}, north-east of the lake; their Tarantula Eggs lie on the ground among them: click six."] = "",

	-- Step 34: Blackrock camps
	["Blackrock camps"] = "",
	-- {area:1000} Galardell Valley · {area:2099} Stonewatch Keep
	["South-east from the mill, west of {area:1000}'s gnolls, to the Blackrock camps east of {area:2099}. Renegades, Grunts and Outrunners fill them; keep east of the keep, whose orcs are elite. Weapon racks and swords lie about the camps; meat haunches, grain sacks and water barrels hold the supplies."] = "",
	-- {item:280841} Stolen Weapon
	["{item:280841}: weapon racks and swords on the ground"] = "",
	-- {item:280839} Blackrock Supplies
	["{item:280839}: meat haunches, grain sacks, water barrels"] = "",

	-- Step 35: Incinerator Gar'im
	["Gar'im keeps to the cave at the camps' south end with his imp and two orcs. Elite: group up if you can; solo, pull the orcs at the mouth first and interrupt his fire cast."] = "",

	-- Step 36: Galardell Valley
	-- {npc:703} Lieutenant Fangore · {area:2099} Stonewatch Keep
	["North up the valley's east side. Shadowhide gnolls fill it; {npc:703} (26) and his two guards stand at its north end: clear the gnolls around him first and fight at full health. Stay out of {area:2099} to the west until the watch tower: its orcs are elite."] = "",
	-- {item:1075} Shadowhide Pendant
	["{item:1075}: any Shadowhide gnoll"] = "{item:1075}: 아무 잿빛가죽 놀",

	-- Step 37: A Watchful Eye
	-- {object:31} Old Lion Statue
	["The {object:31} stands at the valley's east edge."] = "",

	-- Step 38: Looking Further
	-- {area:2099} Stonewatch Keep
	["West to the intact watch tower beside {area:2099}: climb it and leave the Glyph in the empty jar at the top."] = "",

	-- Step 39: Stonewatch Keep
	-- {npc:334} Gath'Ilzogg
	-- plural, as words: Blackrock Shadowcasters = {npc:436} Blackrock Shadowcaster
	["The keep stands beside the tower. {npc:334} (elite) waits in the keep's top room with two guards and a dragon; Blackrock Shadowcasters (elite) and Sentries stand on its west side, so pull one at a time on the way in, and hug the right wall as you enter his room so you don't pull him at once. Elite: group up if you can."] = "",

	-- Step 40: Render's Valley
	-- {area:95} Redridge Canyons · {area:997} Render's Valley · {area:69} Lakeshire
	-- plural, as words: Blackrock Champions = {npc:435} Blackrock Champion
	["From the keep head back west along the lake's north shore and north up the {area:95} to {area:997}; {area:69}'s hand-ins wait for Keeshan's escort, which ends there. Blackrock Champions camp in the valley."] = "",
	-- {npc:435} Blackrock Champion
	["{npc:435}, below ground"] = "",

	-- Step 41: Corporal Keeshan
	-- {zone:1428} Burning Steppes · {area:69} Lakeshire
	["Keeshan hides at the very north end of the valley, by the {zone:1428} border. Escort him down to {area:69}; Blackrock orcs ambush you on the way."] = "키샨은 계곡 맨 북쪽 끝, {zone:1428} 경계 근처에 숨어 있습니다. 그를 호위하여 {area:69}까지 내려가세요. 가는 길에 검은바위부족 오크가 습격합니다.",
	-- {npc:349} Corporal Keeshan
	["{npc:349}, below ground"] = "",

	-- Step 42: Magistrate Solomon: Gath'Ilzogg
	-- {npc:344} Magistrate Solomon
	["{npc:344}, in the town hall"] = "{npc:344}, 마을 회관 안",

	-- Step 44: Back to Lakeshire
	-- {area:69} Lakeshire
	["Back to {area:69}"] = "{area:69}(으)로 돌아가기",
	-- {area:69} Lakeshire · {npc:900} Bailiff Conacher · {npc:344} Magistrate Solomon · {npc:382} Marshal Marris · {npc:341} Foreman Oslow · {npc:903} Guard Howe
	["Into {area:69} from the north with Keeshan: {npc:900} and {npc:344} in the town hall, {npc:382} and {npc:341} at the north end of the bridge, then over the bridge to {npc:903} and the gryphons."] = "",
	-- {npc:903} Guard Howe
	["{npc:903}, by the gryphons south of the bridge"] = "{npc:903}, 다리 남쪽 그리폰 옆",
	-- {area:42} Darkshire · {zone:1431} Duskwood
	["Next: the gryphon to {area:42} for {zone:1431}'s second loop (05-duskwood)."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Bellygrub"] = "서리먹보",
	-- ["Cross the long bridge north into town. {npc:341} and {npc:382} stand at the north end of the bridge, {npc:900} in the town hall, {npc:381} and {npc:266} on the docks, {npc:343} at the inn, {npc:342} in her garden at the west end."] = "긴 다리를 건너 북쪽 마을로 들어가세요. {npc:341}와(과) {npc:382}은(는) 다리 북쪽 끝에, {npc:900}은(는) 마을 회관에, {npc:381}와(과) {npc:266}은(는) 부두에, {npc:343}은(는) 여관에, {npc:342}은(는) 서쪽 끝 자기 정원에 있습니다.",
	-- ["East past the mill and across the river. Shadowhide gnolls fill the valley; {npc:703} (26, well above you) leads them at its north end: clear his escort first and fight him at full health. Stay out of {area:2099} to the south: its orcs are elite."] = "방앗간을 지나 동쪽으로 강을 건너세요. 계곡에는 잿빛가죽 놀이 가득합니다. {npc:703}(26레벨, 당신보다 훨씬 높음)이 계곡 북쪽 끝에서 그들을 이끕니다. 호위병을 먼저 처치하고 생명력이 가득 찬 상태로 싸우세요. 남쪽의 {area:2099}에는 들어가지 마세요. 그곳의 오크는 정예입니다.",
	-- ["Fly to {area:108} and ride north-west to the coast: the {object:177790} lies on the sea floor off the shore. Then ride east along the road through Elwynn to Redridge."] = "{area:108}(으)로 날아가 북서쪽 해안으로 가세요. {object:177790}은(는) 해안 앞바다의 바닥에 있습니다. 그런 다음 길을 따라 동쪽으로 엘윈 숲을 지나 붉은마루 산맥으로 가세요.",
	-- ["Follow the road along the south shore of {area:68} to the gryphon master. {npc:1070} and {npc:903} stand by the road next to her."] = "{area:68}의 남쪽 기슭을 따라 길을 가면 그리폰 조련사가 있습니다. {npc:1070}와(과) {npc:903}은(는) 그녀 옆 길가에 서 있습니다.",
	-- ["For {npc:3649}, on the return to {area:442} (06-ashenvale)"] = "{npc:3649}에게, {area:442}로 돌아갈 때 (06-ashenvale)",
	-- ["Gnolls toward {area:1002}"] = "{area:1002} 쪽의 놀",
	-- ["Greater Tarantulas crawl on the slopes around the mill north-east of the lake; Blackrock Renegades hold the mill itself."] = "거대한 타란툴라는 호수 북동쪽 방앗간 주변 비탈을 기어다니고, 검은바위부족 보초병은 방앗간 자체를 차지하고 있습니다.",
	-- ["Head north out of {area:69} up the {area:95} to {area:997}. Blackrock Champions camp in the valley."] = "{area:69}에서 북쪽으로 나가 {area:95}을(를) 올라 {area:997}(으)로 가세요. 검은바위부족 용사가 계곡에 진을 치고 있습니다.",
	-- ["Lake murlocs"] = "호수 멀록",
	-- ["Murloc Flesheaters and Tidecallers line the south shore east of the bridge. Any of them can carry a {item:1467} or a fin."] = "멀록 청소부와 파도술사는 다리 동쪽 남쪽 기슭에 늘어서 있습니다. 누구든 {item:1467}이나 지느러미를 지니고 있을 수 있습니다.",
	-- ["Redridge Mongrels and other gnolls hold the hills east of {area:1002}, north of the road; Redridge Thrashers prowl among them, Poachers camp south of the road. Dire Condors and Great Goretusks roam the same hills."] = "붉은마루일족 싸움꾼과 다른 놀들은 {area:1002} 동쪽, 길 북쪽의 언덕을 차지하고 있습니다. 붉은마루일족 약탈자가 그 사이를 배회하고, 밀렵꾼은 길 남쪽에 진을 치고 있습니다. 광포한 대머리수리와 큰 뿔엄니멧돼지도 같은 언덕을 돌아다닙니다.",
	-- ["Swim east from the bridge into {area:68}; the chest lies on the lake bed."] = "다리에서 동쪽으로 헤엄쳐 {area:68}(으)로 가세요. 상자는 호수 바닥에 있습니다.",
	-- ["The Wanted poster by the inn: {npc:703}, in {area:1000}"] = "여관 옆 현상수배 게시판: {npc:703}, {area:1000}에 있음",
	-- ["The road from Elwynn enters Redridge at {area:1002}. {npc:464} stands where the roads to Redridge and {zone:1431} meet."] = "엘윈 숲에서 오는 길은 {area:1002}에서 붉은마루 산맥으로 들어갑니다. {npc:464}은(는) 붉은마루 산맥과 {zone:1431}(으)로 가는 길이 만나는 곳에 서 있습니다.",
	-- ["The {area:442} boat docks at {area:17203}. Walk up into the city for training and {npc:1646}, then leave by the main gate and follow the road east through {zone:1429}."] = "{area:442}행 배는 {area:17203}에 정박합니다. 도시로 올라가 훈련을 받고 {npc:1646}을(를) 만난 뒤, 정문으로 나가 길을 따라 동쪽으로 {zone:1429}을(를) 지나가세요.",
	-- ["{item:1075}: any Shadowhide gnoll"] = "{item:1075}: 아무 잿빛가죽 놀",
	-- ["{item:280911}: Redridge Thrashers"] = "{item:280911}: 붉은마루일족 약탈자",
	-- ["{item:3014}: any Blackrock orc"] = "{item:3014}: 아무 검은바위부족 오크",
	-- ["{item:3014}: the Blackrock Renegades at the mill"] = "{item:3014}: 방앗간의 검은바위부족 보초병",
	-- ["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646}: {area:442}에서 온 툰드리스의 편지",
	-- ["{npc:266}, by the docks"] = "{npc:266}, 부두 옆",
	-- ["{npc:332} is at SI:7 in {object:2100}, {npc:6122} in the {object:2164}'s cellar in the {object:2101}, {npc:376} in the Cathedral of Light."] = "{npc:332}은(는) {object:2100}의 SI:7에, {npc:6122}은(는) {object:2101}에 있는 {object:2164}의 지하실에, {npc:376}은(는) 빛의 대성당에 있습니다.",
	-- ["{npc:332}: {npc:7024} in {zone:1436} takes it, at the end of {zone:1431}"] = "{npc:332}: {zone:1436}의 {npc:7024}에게 제출합니다. {zone:1431} 진행 막바지에",
	-- ["{npc:341}: after {quest:89}"] = "{npc:341}: {quest:89} 이후",
	-- ["{npc:344}, in the town hall"] = "{npc:344}, 마을 회관 안",
	-- ["{npc:345} (level 24) roots around the pen just west of {area:69}. Pull him away from the other boars and fight at full health."] = "{npc:345}(24레벨)는 {area:69} 바로 서쪽 우리에서 땅을 파헤칩니다. 다른 멧돼지들과 떨어뜨려 끌어온 뒤 생명력이 가득 찬 상태로 싸우세요.",
	-- ["{npc:376}: {npc:11401} in {zone:1457} takes it, later"] = "{npc:376}: {zone:1457}의 {npc:11401}에게 제출합니다. 나중에",
	-- ["{npc:376}: {npc:11406} in {zone:1455} takes it, later"] = "{npc:376}: {zone:1455}의 {npc:11406}에게 제출합니다. 나중에",
	-- ["{npc:376}: {npc:258785} in {zone:1455} takes it, later"] = "{npc:376}: {zone:1455}의 {npc:258785}에게 제출합니다. 나중에",
	-- ["{npc:6122}: {npc:6244} in the {zone:1413} takes it, later"] = "{npc:6122}: {zone:1413}의 {npc:6244}에게 제출합니다. 나중에",
	-- ["{zone:1431} is next: follow the road west to {area:1002}, then south to {area:42}."] = "다음은 {zone:1431}입니다. 길을 따라 서쪽으로 {area:1002}까지 간 뒤, 남쪽으로 {area:42}까지 가세요.",
	-- ["{zone:1453} class quests"] = "{zone:1453} 직업 퀘스트",
}
