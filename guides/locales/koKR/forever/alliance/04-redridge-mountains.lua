-- Korean (koKR): the guide forever/alliance/04-redridge-mountains (forever/alliance/04-redridge-mountains.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Stormwind
	-- {area:442} Auberdine · {area:17203} Stormwind Harbor · {npc:1646} Baros Alexston · {zone:1429} Elwynn Forest
	["The {area:442} boat docks at {area:17203}. Walk up into the city for training and {npc:1646}, then leave by the main gate and follow the road east through {zone:1429}."] = "{area:442}행 배는 {area:17203}에 정박합니다. 도시로 올라가 훈련을 받고 {npc:1646}을(를) 만난 뒤, 정문으로 나가 길을 따라 동쪽으로 {zone:1429}을(를) 지나가세요.",
	["Level 18 and 20 spells"] = "18레벨과 20레벨 주문",
	-- {npc:1646} Baros Alexston · {area:442} Auberdine
	["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646}: {area:442}에서 온 툰드리스의 편지",
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["For {npc:3649}, on the return to {area:442} (06-ashenvale)"] = "{npc:3649}에게, {area:442}로 돌아갈 때 (06-ashenvale)",

	-- Step 2: Shaman training
	["Shaman training"] = "주술사 훈련",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back."] = "{zone:1453}에는 주술사 상급자가 없습니다. {object:28027}에서 {area:2257}을(를) 타고 {zone:1455}(으)로 가서 {npc:258098}에게 훈련을 받은 뒤, 지하철을 타고 돌아오세요.",

	-- Step 3: Stormwind class quests
	-- {zone:1453} Stormwind
	["{zone:1453} class quests"] = "{zone:1453} 직업 퀘스트",
	-- {npc:332} Master Mathias Shaw · {object:2100} Old Town · {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:376} High Priestess Laurena
	["{npc:332} is at SI:7 in {object:2100}, {npc:6122} in the {object:2164}'s cellar in the {object:2101}, {npc:376} in the Cathedral of Light."] = "{npc:332}은(는) {object:2100}의 SI:7에, {npc:6122}은(는) {object:2101}에 있는 {object:2164}의 지하실에, {npc:376}은(는) 빛의 대성당에 있습니다.",
	-- {npc:332} Master Mathias Shaw · {npc:7024} Agent Kearnen · {zone:1436} Westfall · {zone:1431} Duskwood
	["{npc:332}: {npc:7024} in {zone:1436} takes it, at the end of {zone:1431}"] = "{npc:332}: {zone:1436}의 {npc:7024}에게 제출합니다. {zone:1431} 진행 막바지에",
	-- {npc:6122} Gakin the Darkbinder · {npc:6244} Takar the Seer · {zone:1413} Barrens
	["{npc:6122}: {npc:6244} in the {zone:1413} takes it, later"] = "{npc:6122}: {zone:1413}의 {npc:6244}에게 제출합니다. 나중에",
	-- {npc:376} High Priestess Laurena · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["{npc:376}: {npc:11406} in {zone:1455} takes it, later"] = "{npc:376}: {zone:1455}의 {npc:11406}에게 제출합니다. 나중에",
	-- {npc:376} High Priestess Laurena · {npc:258785} High Priestess Mims · {zone:1455} Ironforge
	["{npc:376}: {npc:258785} in {zone:1455} takes it, later"] = "{npc:376}: {zone:1455}의 {npc:258785}에게 제출합니다. 나중에",
	-- {npc:376} High Priestess Laurena · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["{npc:376}: {npc:11401} in {zone:1457} takes it, later"] = "{npc:376}: {zone:1457}의 {npc:11401}에게 제출합니다. 나중에",

	-- Step 4: Half Pendant of Aquatic Endurance
	-- {area:108} Sentinel Hill · {object:177790} Strange Lockbox
	["Fly to {area:108} and ride north-west to the coast: the {object:177790} lies on the sea floor off the shore. Then ride east along the road through Elwynn to Redridge."] = "{area:108}(으)로 날아가 북서쪽 해안으로 가세요. {object:177790}은(는) 해안 앞바다의 바닥에 있습니다. 그런 다음 길을 따라 동쪽으로 엘윈 숲을 지나 붉은마루 산맥으로 가세요.",
	-- {item:15882} Half Pendant of Aquatic Endurance · {object:177790} Strange Lockbox
	["{item:15882}: the {object:177790}"] = "{item:15882}: {object:177790}",

	-- Step 5: Three Corners
	-- {area:1002} Three Corners · {npc:464} Guard Parker · {zone:1431} Duskwood
	["The road from Elwynn enters Redridge at {area:1002}. {npc:464} stands where the roads to Redridge and {zone:1431} meet."] = "엘윈 숲에서 오는 길은 {area:1002}에서 붉은마루 산맥으로 들어갑니다. {npc:464}은(는) 붉은마루 산맥과 {zone:1431}(으)로 가는 길이 만나는 곳에 서 있습니다.",

	-- Step 6: Lakeridge Highway
	-- {area:68} Lake Everstill · {npc:1070} Deputy Feldon · {npc:903} Guard Howe
	["Follow the road along the south shore of {area:68} to the gryphon master. {npc:1070} and {npc:903} stand by the road next to her."] = "{area:68}의 남쪽 기슭을 따라 길을 가면 그리폰 조련사가 있습니다. {npc:1070}와(과) {npc:903}은(는) 그녀 옆 길가에 서 있습니다.",

	-- Step 7: Lakeshire
	-- {npc:341} Foreman Oslow · {npc:382} Marshal Marris · {npc:900} Bailiff Conacher · {npc:381} Dockmaster Baren · {npc:266} Wiley the Black · {npc:343} Chef Breanna · {npc:342} Martie Jainrose
	["Cross the long bridge north into town. {npc:341} and {npc:382} stand at the north end of the bridge, {npc:900} in the town hall, {npc:381} and {npc:266} on the docks, {npc:343} at the inn, {npc:342} in her garden at the west end."] = "긴 다리를 건너 북쪽 마을로 들어가세요. {npc:341}와(과) {npc:382}은(는) 다리 북쪽 끝에, {npc:900}은(는) 마을 회관에, {npc:381}와(과) {npc:266}은(는) 부두에, {npc:343}은(는) 여관에, {npc:342}은(는) 서쪽 끝 자기 정원에 있습니다.",
	-- {npc:266} Wiley the Black
	["{npc:266}, by the docks"] = "{npc:266}, 부두 옆",

	-- Step 8: Sunken Chest
	-- {area:68} Lake Everstill
	["Swim east from the bridge into {area:68}; the chest lies on the lake bed."] = "다리에서 동쪽으로 헤엄쳐 {area:68}(으)로 가세요. 상자는 호수 바닥에 있습니다.",

	-- Step 9: Gnolls toward Three Corners
	-- {area:1002} Three Corners
	["Gnolls toward {area:1002}"] = "{area:1002} 쪽의 놀",
	-- {area:1002} Three Corners
	-- plural, as words: Redridge Mongrels = {npc:423} Redridge Mongrel · Redridge Thrashers = {npc:712} Redridge Thrasher · Dire Condors = {npc:428} Dire Condor · Great Goretusks = {npc:547} Great Goretusk
	["Redridge Mongrels and other gnolls hold the hills east of {area:1002}, north of the road; Redridge Thrashers prowl among them, Poachers camp south of the road. Dire Condors and Great Goretusks roam the same hills."] = "붉은마루일족 싸움꾼과 다른 놀들은 {area:1002} 동쪽, 길 북쪽의 언덕을 차지하고 있습니다. 붉은마루일족 약탈자가 그 사이를 배회하고, 밀렵꾼은 길 남쪽에 진을 치고 있습니다. 광포한 대머리수리와 큰 뿔엄니멧돼지도 같은 언덕을 돌아다닙니다.",
	-- {item:280911} Spiked Collar
	-- plural, as words: Redridge Thrashers = {npc:712} Redridge Thrasher
	["{item:280911}: Redridge Thrashers"] = "{item:280911}: 붉은마루일족 약탈자",

	-- Step 10: Bellygrub
	-- {npc:345} Bellygrub · {area:69} Lakeshire
	["{npc:345} (level 24) roots around the pen just west of {area:69}. Pull him away from the other boars and fight at full health."] = "{npc:345}(24레벨)는 {area:69} 바로 서쪽 우리에서 땅을 파헤칩니다. 다른 멧돼지들과 떨어뜨려 끌어온 뒤 생명력이 가득 찬 상태로 싸우세요.",

	-- Step 12: Lakeshire
	-- {npc:703} Lieutenant Fangore · {area:1000} Galardell Valley
	["The Wanted poster by the inn: {npc:703}, in {area:1000}"] = "여관 옆 현상수배 게시판: {npc:703}, {area:1000}에 있음",

	-- Step 13: Lake murlocs
	["Lake murlocs"] = "호수 멀록",
	-- {item:1467} Spotted Sunfish
	-- plural, as words: Murloc Flesheaters = {npc:422} Murloc Flesheater
	["Murloc Flesheaters and Tidecallers line the south shore east of the bridge. Any of them can carry a {item:1467} or a fin."] = "멀록 청소부와 파도술사는 다리 동쪽 남쪽 기슭에 늘어서 있습니다. 누구든 {item:1467}이나 지느러미를 지니고 있을 수 있습니다.",

	-- Step 14: Alther's Mill
	-- plural, as words: Greater Tarantulas = {npc:505} Greater Tarantula · Blackrock Renegades = {npc:437} Blackrock Renegade
	["Greater Tarantulas crawl on the slopes around the mill north-east of the lake; Blackrock Renegades hold the mill itself."] = "거대한 타란툴라는 호수 북동쪽 방앗간 주변 비탈을 기어다니고, 검은바위부족 보초병은 방앗간 자체를 차지하고 있습니다.",
	-- {item:3014} Battleworn Axe
	["{item:3014}: any Blackrock orc"] = "{item:3014}: 아무 검은바위부족 오크",

	-- Step 15: Galardell Valley
	-- {npc:703} Lieutenant Fangore · {area:2099} Stonewatch Keep
	["East past the mill and across the river. Shadowhide gnolls fill the valley; {npc:703} (26, well above you) leads them at its north end: clear his escort first and fight him at full health. Stay out of {area:2099} to the south: its orcs are elite."] = "방앗간을 지나 동쪽으로 강을 건너세요. 계곡에는 잿빛가죽 놀이 가득합니다. {npc:703}(26레벨, 당신보다 훨씬 높음)이 계곡 북쪽 끝에서 그들을 이끕니다. 호위병을 먼저 처치하고 생명력이 가득 찬 상태로 싸우세요. 남쪽의 {area:2099}에는 들어가지 마세요. 그곳의 오크는 정예입니다.",
	-- {item:1075} Shadowhide Pendant
	["{item:1075}: any Shadowhide gnoll"] = "{item:1075}: 아무 잿빛가죽 놀",

	-- Step 16: Back to Lakeshire
	-- {area:69} Lakeshire
	["Back to {area:69}"] = "{area:69}(으)로 돌아가기",
	-- {npc:344} Magistrate Solomon
	["{npc:344}, in the town hall"] = "{npc:344}, 마을 회관 안",

	-- Step 17: Render's Valley
	-- {area:69} Lakeshire · {area:95} Redridge Canyons · {area:997} Render's Valley
	-- plural, as words: Blackrock Champions = {npc:435} Blackrock Champion
	["Head north out of {area:69} up the {area:95} to {area:997}. Blackrock Champions camp in the valley."] = "{area:69}에서 북쪽으로 나가 {area:95}을(를) 올라 {area:997}(으)로 가세요. 검은바위부족 용사가 계곡에 진을 치고 있습니다.",

	-- Step 18: Corporal Keeshan
	-- {zone:1428} Burning Steppes · {area:69} Lakeshire
	["Keeshan hides at the very north end of the valley, by the {zone:1428} border. Escort him down to {area:69}; Blackrock orcs ambush you on the way."] = "키샨은 계곡 맨 북쪽 끝, {zone:1428} 경계 근처에 숨어 있습니다. 그를 호위하여 {area:69}까지 내려가세요. 가는 길에 검은바위부족 오크가 습격합니다.",

	-- Step 19: Lakeshire
	-- {npc:903} Guard Howe
	["{npc:903}, by the gryphons south of the bridge"] = "{npc:903}, 다리 남쪽 그리폰 옆",
	-- {zone:1431} Duskwood · {area:1002} Three Corners · {area:42} Darkshire
	["{zone:1431} is next: follow the road west to {area:1002}, then south to {area:42}."] = "다음은 {zone:1431}입니다. 길을 따라 서쪽으로 {area:1002}까지 간 뒤, 남쪽으로 {area:42}까지 가세요.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Bellygrub"] = "서리먹보",
}
