-- Korean (koKR): the guide forever/horde/40-50/01b-riverglades (forever/horde/40-50/01b-riverglades.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:16743} Rog'mar
	["About 70 quests in Forever's new zone, from the fort of {area:16743}."] = "Forever의 새 지역에서 {area:16743} 요새를 거점으로 하는 약 70개의 퀘스트.",

	-- Step 1: Fly to Kargath
	-- {area:340} Kargath
	["Fly to {area:340}"] = "",
	-- {zone:2548} Riverglades · {area:3} Badlands · {area:657} Harborage · {area:75} Stonard · {area:340} Kargath
	["The {zone:2548} lie south of the {area:3}. Ride east from the {area:657} to {area:75} and fly to {area:340}: the way down into the zone starts there."] = "{zone:2548}은(는) {area:3} 남쪽에 있습니다. {area:657}에서 동쪽 {area:75}(으)로 가서 {area:340}(으)로 날아가세요. 지역으로 내려가는 길이 그곳에서 시작됩니다.",
	-- {area:75} Stonard
	["{area:75} flight master"] = "",

	-- Step 2: Into the Riverglades
	-- {area:16591} Riverglades
	["Into the {area:16591}"] = "{area:16591}(으)로",
	-- {area:16591} Riverglades · {area:340} Kargath · {area:3} Badlands · {area:16685} Twilight's Shroud · {area:16743} Rog'mar
	["New in Forever: this guide follows what players did in the {area:16591}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\nFrom {area:340}, ride south-east across the {area:3} to the zone's southern edge: the pass of {area:16685} leads down into the {area:16591}. {area:16743}, the Horde's fort, stands in the middle of the zone, east along the valley."] = "Forever 신규 지역: 이 가이드는 플레이어들이 {area:16591}에서 진행한 내용을 따릅니다. 잘못된 단계가 있으면 Polestar의 Discord나 GitHub에 단계 이름과 함께 알려 주세요.\n{area:340}에서 남동쪽으로 {area:3}을(를) 가로질러 지역 남쪽 끝으로 가세요. {area:16685} 고개를 따라 {area:16591}(으)로 내려갑니다. 호드 요새 {area:16743}은(는) 골짜기를 따라 동쪽, 지역 한가운데에 있습니다.",

	-- Step 3: Fly to Freewind Post
	-- {area:484} Freewind Post
	["Fly to {area:484}"] = "{area:484}(으)로 날아가기",
	-- {zone:2548} Riverglades · {zone:1446} Tanaris · {area:977} Steamwheedle Port · {area:976} Gadgetzan · {area:16727} Powderfuse Port · {area:484} Freewind Post · {zone:1441} Thousand Needles · {area:439} Shimmering Flats · {area:340} Kargath · {area:3} Badlands · {area:16685} Twilight's Shroud
	["New in Forever: this guide follows what players did in the {zone:2548}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\nThe {zone:2548} lie across the sea from {zone:1446}: a goblin boat sails from {area:977}, north-east of {area:976}, to {area:16727}. Fly to {area:484} in {zone:1441} and head south-east through the {area:439} to {area:976}. (If you already know {area:340} in the {area:3}, the way in through {area:16685} works too.)"] = "Forever 신규 지역: 이 가이드는 플레이어들이 {zone:2548}에서 진행한 내용을 따릅니다. 잘못된 단계가 있으면 Polestar의 Discord나 GitHub에 단계 이름과 함께 알려 주세요.\n{zone:2548}은(는) {zone:1446}에서 바다 건너편에 있습니다. {area:976} 북동쪽 {area:977}에서 고블린 배가 {area:16727}(으)로 갑니다. {zone:1441}의 {area:484}(으)로 날아가 남동쪽으로 {area:439}을(를) 지나 {area:976}(으)로 가세요. ({area:3}의 {area:340} 비행 경로가 이미 있다면 {area:16685}(으)로 들어가는 길도 됩니다.)",

	-- Step 4: Gadgetzan
	-- {area:976} Gadgetzan
	["Learn {area:976}'s flight path: it saves the ride next time."] = "{area:976}의 비행 경로를 익히세요. 다음에 이동 시간을 아낄 수 있습니다.",

	-- Step 5: Boat to Powderfuse Port
	-- {area:16727} Powderfuse Port
	["Boat to {area:16727}"] = "",
	-- {area:977} Steamwheedle Port · {area:976} Gadgetzan · {area:16727} Powderfuse Port
	["{area:977} is on the coast north-east of {area:976}: wait on the pier for the goblin boat to {area:16727}."] = "{area:977}은(는) {area:976} 북동쪽 해안에 있습니다. 부두에서 {area:16727}행 고블린 배를 기다리세요.",

	-- Step 6: Powderfuse Port
	-- {npc:255897} Friz Frazzlespark
	["New in Forever: if a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\n{npc:255897} keeps a stall at the west end of the docks. The port's other jobs are for later in this guide: this crate goes to the Horde's fort."] = "Forever 신규 지역: 잘못된 단계가 있으면 Polestar의 Discord나 GitHub에 단계 이름과 함께 알려 주세요.\n{npc:255897}은(는) 부두 서쪽 끝에서 노점을 운영합니다. 항구의 다른 일은 이 가이드 후반에 합니다. 이 상자는 호드 요새로 가져갑니다.",
	-- {quest:95062} Frazzlespark's Crate · {npc:256418} Krom'rosh · {area:16743} Rog'mar
	["{quest:95062}: for {npc:256418} in {area:16743}"] = "{quest:95062}: {area:16743}의 {npc:256418}에게",

	-- Step 7: Sleebo Fizzlespout's workshop
	-- {npc:263367} Sleebo Fizzlespout
	["{npc:263367}'s workshop"] = "{npc:263367}의 작업장",
	-- {npc:263367} Sleebo Fizzlespout · {npc:258031} Neza Bloodsnout
	["West up the road from the port: {npc:263367} has his workshop on the hill. The gas vents are in the marsh south-west of it, on your first hunt for {npc:258031}."] = "항구에서 길을 따라 서쪽으로 올라가세요. {npc:263367}의 작업장이 언덕 위에 있습니다. 가스 분출구는 그 남서쪽 습지에 있으며, {npc:258031}의 첫 사냥 때 들릅니다.",

	-- Step 8: Rog'mar
	-- {area:16743} Rog'mar · {npc:258031} Neza Bloodsnout · {npc:256657} Kreza Darkthorn · {npc:256418} Krom'rosh · {npc:255993} Grakna · {npc:256675} Innkeeper Toka · {npc:263190} Tan'jani
	["West to {area:16743}, the Horde's fort in the middle of the zone. {npc:258031} stands on its east side, {npc:256657} and {npc:256418} in the middle with {npc:255993}, the wind rider master; {npc:256675} and {npc:263190} on the west side."] = "서쪽으로 지역 한가운데의 호드 요새 {area:16743}(으)로 가세요. {npc:258031}은(는) 동쪽에, {npc:256657}와(과) {npc:256418}은(는) 와이번 조련사 {npc:255993}와(과) 함께 중앙에, {npc:256675}와(과) {npc:263190}은(는) 서쪽에 있습니다.",
	-- {npc:256418} Krom'rosh · {object:3202} Grom'gol
	["{npc:256418}: Aggro'gosh's report from {object:3202}, if you carry it"] = "{npc:256418}: {object:3202}에서 받은 아그로고쉬의 보고서(가지고 있다면)",
	-- {npc:255993} Grakna
	["{npc:255993}, in the middle of the fort"] = "요새 중앙의 {npc:255993}",
	-- {npc:263190} Tan'jani · {quest:95033} On the Other Side · {npc:8115} Witch Doctor Uzer'i · {area:1099} Camp Mojache · {zone:1444} Feralas
	["{npc:263190}: {quest:95033}, for {npc:8115} at {area:1099} in the {zone:1444} guide"] = "{npc:263190}: {quest:95033}, {zone:1444} 가이드에서 {area:1099}의 {npc:8115}에게",

	-- Step 9: Krom'rosh
	-- {npc:256418} Krom'rosh
	["Frazzlespark's crate from the port goes to {npc:256418}, in the middle of the fort."] = "항구에서 받은 프라즐스파크의 상자는 요새 중앙의 {npc:256418}에게 가져가세요.",

	-- Step 10: Sleebo Fizzlespout's workshop
	-- {area:16727} Powderfuse Port · {npc:263367} Sleebo Fizzlespout · {npc:258031} Neza Bloodsnout
	["East of Rog'mar, on the hill above the road to {area:16727}: {npc:263367} has his workshop there. The gas vents are in the marsh south-west of it, on your first hunt for {npc:258031}."] = "로그마르 동쪽, {area:16727}(으)로 가는 길 위 언덕에 {npc:263367}의 작업장이 있습니다. 가스 분출구는 그 남서쪽 습지에 있으며, {npc:258031}의 첫 사냥 때 들릅니다.",

	-- Step 11: The plains and the marsh
	["The plains and the marsh"] = "평원과 습지",
	-- {area:16729} Terral's Watch · {quest:96103} A Feast for Buzzards
	-- plural, as words: Low Plains Buzzards = {npc:263343} Low Plains Buzzard
	["South-east of Rog'mar the plains run down to {area:16729}. The Low Plains Buzzards circle everywhere; a picked carcass lies in the grass (its skull starts {quest:96103}), and the marsh vents are just past it."] = "로그마르 남동쪽으로 평원이 {area:16729}까지 이어집니다. 저지대 대머리수리가 곳곳을 맴돌고, 풀밭에 뜯어먹힌 사체가 있으며(두개골로 {quest:96103} 시작), 습지 분출구는 그 바로 너머에 있습니다.",

	-- Step 12: Sleebo Fizzlespout
	-- {npc:263367} Sleebo Fizzlespout
	["North-east to the workshop. {npc:263367}'s stress test is a fight with his G45-B4G beside the workshop: hand the quest in once it's beaten."] = "북동쪽 작업장으로 가세요. {npc:263367}의 스트레스 테스트는 작업장 옆 G45-B4G와의 전투입니다. 물리치면 퀘스트를 제출하세요.",
	["the stress test: beat G45-B4G beside the workshop"] = "스트레스 테스트: 작업장 옆의 G45-B4G 쓰러뜨리기",

	-- Step 13: Neza Bloodsnout
	-- {area:16743} Rog'mar
	["West back to {area:16743}'s east side."] = "서쪽으로 {area:16743}의 동쪽으로 돌아가세요.",

	-- Step 14: The vipers and the tallstriders
	["The vipers and the tallstriders"] = "독사와 타조",
	-- {npc:257079} Cavalry Scout Alturin · {area:16729} Terral's Watch · {area:16725} Wheeler's Grange
	-- plural, as words: Glade Vipers = {npc:263307} Glade Viper · Roving Tallstriders = {npc:263348} Roving Tallstrider
	["The Glade Vipers hide in the long grass south-east of town; the Roving Tallstriders graze beside them. {npc:257079}, an Alliance elite (level 45), rides the road from {area:16729} to {area:16725} along the grass's south-west edge: keep clear of him."] = "숲속 독사는 마을 남동쪽의 긴 풀숲에 숨어 있고, 떠도는 타조가 그 옆에서 풀을 뜯습니다. 얼라이언스 정예인 {npc:257079}(45레벨)이(가) 풀숲 남서쪽 가장자리를 따라 {area:16729}에서 {area:16725}까지 길을 달립니다. 가까이 가지 마세요.",

	-- Step 16: King of the Wild Plains
	-- {npc:263315} Ombassa · {area:16743} Rog'mar
	["{npc:263315}, an elite lion (level 41), prowls the plains south of {area:16743}, where the lions are: grouping up is advised."] = "정예 사자 {npc:263315}(41레벨)이(가) 사자들이 있는 {area:16743} 남쪽 평원을 배회합니다. 파티를 권장합니다.",

	-- Step 17: The lions
	["The lions"] = "사자",
	-- {area:16743} Rog'mar · {npc:263315} Ombassa
	["The Wildplains lions roam the plains just south of {area:16743}.\nCareful: {npc:263315}, an elite lion (level 41), prowls the same plains around 59.6,53.2: keep an eye out for him and pull the lions away from where he walks."] = "야생평원 사자는 {area:16743} 바로 남쪽 평원을 돌아다닙니다.\n주의: 정예 사자 {npc:263315}(41레벨)이(가) 같은 평원의 59.6,53.2 부근을 배회합니다. 잘 살피고 사자를 그가 다니는 곳에서 멀리 끌어내세요.",

	-- Step 20: Neza Bloodsnout's elites
	-- {npc:258031} Neza Bloodsnout
	["{npc:258031}'s elites"] = "{npc:258031}의 정예",

	-- Step 21: Snargl's Snout
	-- {npc:255906} Snargl · {area:16737} Bristle Hills
	["{npc:255906} is an elite gnoll (level 40) who roams the south-western camps of the {area:16737}: grouping up is advised."] = "{npc:255906}은(는) {area:16737}의 남서쪽 야영지를 돌아다니는 정예 놀(40레벨)입니다. 파티를 권장합니다.",

	-- Step 23: Turner's Logging Camp
	-- {npc:263380} Ghostmaw
	-- plural, as words: Wood Bundles = {item:271629} Wood Bundle · Peasant Woodpiles = {object:645516} Peasant Woodpile · Makeshift Stickin' Spears = {item:271630} Makeshift Stickin' Spear
	["South-west across the river to the Alliance lumber camp. The lumberjacks carry the axes. Loot Wood Bundles from the Peasant Woodpiles around the camp and use them to fletch Makeshift Stickin' Spears. {npc:263380}, an elite (level 42), prowls the river by the camp: if he comes your way, back off and let him pass."] = "남서쪽으로 강을 건너 얼라이언스 벌목장으로 가세요. 벌목꾼이 도끼를 지니고 있습니다. 벌목장 주변의 농부 장작더미에서 목재 묶음을 얻어 급조한 찌르기 창을 만드세요. 정예인 {npc:263380}(42레벨)이(가) 벌목장 옆 강을 배회합니다. 다가오면 물러나서 지나가게 두세요.",
	-- {item:271629} Wood Bundle
	-- plural, as words: Peasant Woodpiles = {object:645516} Peasant Woodpile
	["{item:271629}, from the Peasant Woodpiles"] = "농부 장작더미에서 얻는 {item:271629}",
	-- {item:271629} Wood Bundle
	-- plural, as words: Makeshift Stickin' Spears = {item:271630} Makeshift Stickin' Spear
	["{item:271629}: fletch it into Makeshift Stickin' Spears"] = "{item:271629}: 급조한 찌르기 창으로 만드세요",

	-- Step 24: The Bristle Hills
	-- {area:16737} Bristle Hills
	["The {area:16737}"] = "{area:16737}",
	-- {area:16737} Bristle Hills · {npc:255906} Snargl
	["West into the {area:16737}: the Redridge gnolls camp along the slopes and carry the stolen ore. Work south-west through their camps.\nCareful: {npc:255906}, an elite gnoll (level 40), roams the south-western camps: pull the gnolls away from him."] = "서쪽 {area:16737}(으)로 가세요. 붉은마루 놈놀이 비탈을 따라 야영하며 훔친 광석을 지니고 있습니다. 야영지를 거치며 남서쪽으로 가세요.\n주의: 정예 놈놀 {npc:255906}(40레벨)이(가) 남서쪽 야영지를 돌아다닙니다. 놈놀을 그에게서 멀리 끌어내세요.",

	-- Step 26: Gelinda Coppergleam
	-- {npc:262399} Gelinda Coppergleam
	["South-east out of the hills: {npc:262399}, a prospector who deals with both sides, has camped by the Cinderscale dragonkin's hollow."] = "언덕을 나와 남동쪽으로 가세요. 양쪽 진영과 거래하는 탐광꾼 {npc:262399}이(가) 잿빛비늘 용족의 분지 옆에 야영하고 있습니다.",

	-- Step 27: The Cinderscale hollow
	["The Cinderscale hollow"] = "잿빛비늘 분지",
	-- {item:271611} Cubic Draconia
	["The whelps nest all over the hollow; the warriors guard its back, by the {item:271611}. The warriors are level 41-42: pull them one at a time. Scaldaron, a rare elite drake, can be up here too: leave him be unless you have a group."] = "새끼용은 분지 곳곳에 둥지를 틀고 있고, 전사는 분지 안쪽 {item:271611} 옆을 지킵니다. 전사는 41-42레벨이니 하나씩 끌어내세요. 희귀 정예 비룡 스칼다론도 여기 있을 수 있습니다. 파티가 없으면 건드리지 마세요.",

	-- Step 29: Meadowsbrook
	-- {area:16735} Meadowsbrook · {area:16744} Southern Watch · {npc:263380} Ghostmaw
	["East to {area:16735}, the Alliance farm by the river: the farmhands work the fields and the feed satchels lie by the barns. {area:16744}, the Alliance outpost on the road, has guards: pass south of it.\nCareful: {npc:263380}, an elite (level 42), hunts along the river by the farm: keep an eye on the riverbank."] = "동쪽으로 강가의 얼라이언스 농장 {area:16735}(으)로 가세요. 농장 일꾼이 밭에서 일하고 사료 가방은 헛간 옆에 있습니다. 길가의 얼라이언스 전초기지 {area:16744}에는 경비병이 있으니 남쪽으로 지나가세요.\n주의: 정예인 {npc:263380}(42레벨)이(가) 농장 옆 강을 따라 사냥합니다. 강가를 잘 살피세요.",

	-- Step 30: Rog'mar
	-- {area:16743} Rog'mar · {npc:263190} Tan'jani · {npc:256418} Krom'rosh · {npc:256655} Gorg · {npc:256657} Kreza Darkthorn · {npc:258031} Neza Bloodsnout
	["Back to {area:16743}, where your Hearthstone is set: {npc:263190} on the fort's west side first, then {npc:256418}, {npc:256655} by the cook fire, {npc:256657} and {npc:258031} on your way east through the fort."] = "귀환석이 설정된 {area:16743}(으)로 돌아가세요. 먼저 요새 서쪽의 {npc:263190}, 그다음 요새를 지나 동쪽으로 가며 {npc:256418}, 화톳불 옆의 {npc:256655}, {npc:256657}, {npc:258031}에게 가세요.",
	-- {npc:256655} Gorg
	["{npc:256655}, by the cook fire"] = "화톳불 옆의 {npc:256655}",
	-- {quest:93976} The Goblin Trader · {npc:255897} Friz Frazzlespark · {area:16727} Powderfuse Port
	["{quest:93976}: for {npc:255897} in {area:16727}, keep it"] = "{quest:93976}: {area:16727}의 {npc:255897}에게 가져갈 것이니 보관하세요",

	-- Step 32: WANTED: Ghostmaw
	-- {npc:263380} Ghostmaw · {area:16743} Rog'mar
	["{npc:263380} is an elite (level 42) who hunts along the river south-west of {area:16743}, by the Farholde camp you go to next: grouping up is advised. The poster hangs in the middle of the fort."] = "{npc:263380}은(는) 다음에 갈 파홀드 야영지 옆, {area:16743} 남서쪽 강을 따라 사냥하는 정예(42레벨)입니다. 파티를 권장합니다. 벽보는 요새 한가운데에 걸려 있습니다.",
	-- {object:645164} WANTED! (no name in this language: may be words)
	["the {object:645164} poster"] = "{object:645164} 벽보",

	-- Step 33: The training grounds
	["The training grounds"] = "훈련장",
	-- {npc:256655} Gorg · {item:265066} Hearty Stew · {npc:263380} Ghostmaw
	-- plural, as words: Rog'mar Trainees = {npc:256749} Rog'mar Trainee
	["North of the fort the Rog'mar Trainees drill: use {npc:256655}'s {item:265066} on them.\nCareful: {npc:263380}, an elite (level 42), can come up from the river south of the fort: let him pass."] = "요새 북쪽에서 로그마르 훈련병들이 훈련하고 있습니다. 그들에게 {npc:256655}의 {item:265066}을(를) 사용하세요.\n주의: 정예(42레벨)인 {npc:263380}이(가) 요새 남쪽 강에서 올라올 수 있습니다. 지나갈 때까지 기다리세요.",

	-- Step 35: The river and the Farholde camp
	["The river and the Farholde camp"] = "강과 파홀드 야영지",
	-- {npc:263190} Tan'jani · {npc:257079} Cavalry Scout Alturin · {npc:263380} Ghostmaw
	-- plural, as words: Freshwater Crocolisks = {npc:259046} Freshwater Crocolisk
	["South-west of Rog'mar the river runs between the farms: impale the Freshwater Crocolisks with {npc:263190}'s spears. The Alliance trains its scouts and priests at a camp on the far bank. {npc:257079}, the Alliance elite, rides the road just east of the camp: pull the scouts and priests away from it.\nCareful: {npc:263380}, an elite (level 42), hunts along this river: if he comes your way, back off and let him pass."] = "로그마르 남서쪽에서 강이 농장 사이를 흐릅니다. {npc:263190}의 창으로 민물 악어를 꿰뚫으세요. 얼라이언스는 건너편 강둑의 야영지에서 정찰병과 사제를 훈련합니다. 얼라이언스 정예인 {npc:257079}이(가) 야영지 바로 동쪽 길을 순찰합니다. 정찰병과 사제를 그에게서 떼어 끌어오세요.\n주의: 정예(42레벨)인 {npc:263380}이(가) 이 강을 따라 사냥합니다. 다가오면 물러나서 지나가게 두세요.",
	-- {npc:263190} Tan'jani
	-- plural, as words: Freshwater Crocolisks = {npc:259046} Freshwater Crocolisk
	["{npc:263190}'s spears, on the Freshwater Crocolisks in the river"] = "",

	-- Step 39: Tran'gul
	-- {npc:256710} Tran'gul · {npc:256418} Krom'rosh · {area:16743} Rog'mar · {area:16723} Sunnyglade
	["{npc:256710} stands beside {npc:256418} in the middle of {area:16743}: now that the Farholde camp has had its lesson, he has work in {area:16723}."] = "{npc:256710}은(는) {area:16743} 한가운데 {npc:256418} 옆에 있습니다. 파홀드 야영지가 본때를 맛봤으니, 이제 {area:16723}에서 할 일을 줍니다.",

	-- Step 40: Fuzzle
	-- {area:16723} Sunnyglade · {npc:259158} Fuzzle
	["West of Rog'mar the Twilight cult holds the farm town of {area:16723}. {npc:259158}, a kobold who wants out, hides in the middle of the town."] = "로그마르 서쪽에서 황혼의 망치단이 농장 마을 {area:16723}을(를) 장악하고 있습니다. 빠져나가고 싶어 하는 코볼트 {npc:259158}이(가) 마을 한가운데 숨어 있습니다.",

	-- Step 41: Sunnyglade
	-- {npc:256899} Chogg'Zac · {area:16723} Sunnyglade
	["The cultists fill the streets and fields; the Shadowmancers on the town's northern side carry the missives. The finger bones drop from all of them.\nCareful: {npc:256899}, an elite ogre (level 41), walks the western streets of {area:16723}, around 44-47,47-52. Pull the cultists out towards you and let him pass."] = "신도들이 거리와 들판을 가득 메우고 있습니다. 마을 북쪽의 어둠술사가 서신을 지니고 있습니다. 손가락뼈는 모두에게서 떨어집니다.\n주의: 정예 오우거(41레벨)인 {npc:256899}이(가) {area:16723} 서쪽 거리, 44-47,47-52 주변을 돌아다닙니다. 신도들을 끌어오고 그는 지나가게 두세요.",

	-- Step 42: Fuzzle
	-- {npc:259158} Fuzzle · {area:16723} Sunnyglade
	["{npc:259158} wants out of {area:16723}: lead him west to his treasure at the edge of town and keep the cultists off him."] = "{npc:259158}은(는) {area:16723}을(를) 빠져나가고 싶어 합니다: 서쪽 마을 끝의 보물까지 데려가며 교단원을 막아 주십시오.",
	-- {npc:259158} Fuzzle · {area:16723} Sunnyglade
	["lead {npc:259158} out of {area:16723} to his treasure, west of the town"] = "{npc:259158}을(를) {area:16723} 밖으로 데리고 마을 서쪽의 보물까지 가십시오",

	-- Step 43: Tran'gul
	-- {area:16743} Rog'mar
	["East back to {area:16743}."] = "동쪽 {area:16743}(으)로 돌아가세요.",
	-- {quest:94727} Digging for Answers · {npc:260931} Clubtoe · {area:16723} Sunnyglade
	["{quest:94727}: for {npc:260931} in {area:16723}"] = "{quest:94727}: {area:16723}의 {npc:260931}용",

	-- Step 44: Clubtoe
	-- {area:16723} Sunnyglade · {npc:260931} Clubtoe · {npc:256710} Tran'gul
	["West to {area:16723} again: {npc:260931}, a Twilight miner who wants out, waits at the town's eastern edge. Talk him round, then hand {npc:256710}'s quest in; one of the missing ogres stands a few steps west."] = "다시 서쪽 {area:16723}(으)로 가세요. 빠져나가고 싶어 하는 황혼의 망치단 광부 {npc:260931}이(가) 마을 동쪽 끝에서 기다립니다. 그를 설득한 뒤 {npc:256710}의 퀘스트를 제출하세요. 실종된 오우거 중 하나가 조금 서쪽에 있습니다.",
	-- {npc:260931} Clubtoe
	["talk {npc:260931} round"] = "{npc:260931} 설득",
	-- {npc:261208} Twilight Brute
	["{npc:261208}, a few steps west"] = "{npc:261208}, 조금 서쪽",

	-- Step 45: The ritual grounds
	["The ritual grounds"] = "의식의 터",
	-- {area:16723} Sunnyglade · {npc:256899} Chogg'Zac
	["The ritualists and their empowered brutes gather at the ritual circles in the middle of {area:16723}: wreck five of the circles.\nCareful: {npc:256899}, the elite ogre (level 41), walks through here from the western streets: watch for him before each pull."] = "의식술사와 강화된 난폭자들이 {area:16723} 한가운데의 의식 법진에 모여 있습니다. 법진 다섯 개를 파괴하세요.\n주의: 정예 오우거(41레벨)인 {npc:256899}이(가) 서쪽 거리에서 이곳을 지나다닙니다. 매번 끌어오기 전에 살피세요.",
	-- plural, as words: Twilight Ritual Circles = {npc:262006} Twilight Ritual Circle
	["destroy 5 Twilight Ritual Circles"] = "황혼의 의식 법진 5개 파괴",

	-- Step 47: Chogg'Zac
	-- {npc:256899} Chogg'Zac · {area:16723} Sunnyglade · {npc:255829} Clugfist · {area:16726} Bolder'ok · {quest:95420} Land of Giants · {npc:258570} Da'grosh
	["Careful: {npc:256899}, the two-headed ogre at the western edge of {area:16723}, is an elite (level 41): grouping up is advised under 43. Clear the cultists around him first and come in with full health and mana: recorded players of 42-43 killed him alone. {npc:255829}'s quests in {area:16726} wait on this one: skip him and {quest:95420}, the {area:16726} quests and {npc:258570}'s camp in the west go with him (about 21,000 XP); the guide then leaves them out."] = "주의: {area:16723} 서쪽 끝의 머리 둘 달린 오우거 {npc:256899}은(는) 정예(41레벨)입니다. 43레벨 미만이라면 파티를 권장합니다. 주변 신도들을 먼저 처리하고 생명력과 마나를 가득 채운 채 덤비세요. 42-43레벨 플레이어가 혼자 처치한 기록이 있습니다. {area:16726}에서 받는 {npc:255829}의 퀘스트가 이것에 달려 있습니다. 그를 건너뛰면 {quest:95420}, {area:16726} 퀘스트, 서쪽의 {npc:258570} 야영지도 함께 빠지며(약 21,000 경험치), 이후 가이드에서 제외됩니다.",

	-- Step 48: Clubtoe
	-- {quest:95418} Spread the Word · {npc:256710} Tran'gul · {area:16743} Rog'mar
	["{quest:95418}: for {npc:256710} in {area:16743}"] = "{quest:95418}: {area:16743}의 {npc:256710}용",

	-- Step 49: Tran'gul
	-- {area:16743} Rog'mar · {npc:260931} Clubtoe · {npc:256710} Tran'gul · {npc:255829} Clugfist
	["East back to {area:16743}: {npc:260931}'s word goes to {npc:256710}, and {npc:256710}'s to {npc:255829}, the ogres' chieftain."] = "동쪽 {area:16743}(으)로 돌아가세요. {npc:260931}의 소식은 {npc:256710}에게, {npc:256710}의 소식은 오우거 족장 {npc:255829}에게 전해집니다.",
	-- {quest:95420} Land of Giants · {npc:255829} Clugfist · {area:16726} Bolder'ok
	["{quest:95420}: for {npc:255829} in {area:16726}"] = "{quest:95420}: {area:16726}의 {npc:255829}용",

	-- Step 50: WANTED: Scoutmaster Vargas
	-- {npc:260211} Scoutmaster Vargas · {npc:256728} Na'zok · {npc:258031} Neza Bloodsnout
	["{npc:260211} is an elite (level 42) at the Alliance scouts' camp in the hills south-east of {npc:256728}, where you go next: grouping up is advised. The poster hangs in the middle of the fort; {npc:258031} takes the eye, later in this guide."] = "{npc:260211}은(는) 다음 목적지인 {npc:256728} 남동쪽 언덕의 얼라이언스 정찰병 야영지에 있는 정예(42레벨)입니다. 파티를 권장합니다. 현상 수배 전단은 요새 한가운데 걸려 있으며, 눈은 이 가이드 후반에 {npc:258031}에게 제출합니다.",
	-- {object:707249} Wanted (no name in this language: may be words)
	["the {object:707249} poster"] = "{object:707249} 벽보",

	-- Step 51: Na'zok's camp
	-- {npc:256728} Na'zok
	["{npc:256728}'s camp"] = "{npc:256728}의 야영지",
	-- {area:16743} Rog'mar · {npc:256728} Na'zok
	["North-east from {area:16743} up into the hills: {npc:256728} watches the Paletusk boars from his camp."] = "{area:16743}에서 북동쪽 언덕으로 올라가세요. {npc:256728}이(가) 야영지에서 창백엄니 멧돼지들을 지켜보고 있습니다.",

	-- Step 52: Bolder'ok
	-- {area:16726} Bolder'ok · {npc:255829} Clugfist
	["North-west to {area:16726}, the ogres' town. {npc:255829}, its chieftain, sits on the hill. The ogres are friendly while you leave them alone."] = "북서쪽의 오우거 마을 {area:16726}(으)로 가세요. 족장 {npc:255829}이(가) 언덕 위에 앉아 있습니다. 건드리지 않는 한 오우거들은 우호적입니다.",

	-- Step 53: The Twilight ogres' camp
	["The Twilight ogres' camp"] = "황혼의 오우거 야영지",
	-- {npc:256728} Na'zok · {npc:260973} Klunk · {item:269257} Skullbasher · {npc:260211} Scoutmaster Vargas
	-- plural, as words: Twilight Maulers = {npc:260968} Twilight Mauler · Farholde Ambushers = {npc:260023} Farholde Ambusher
	["The Twilight Maulers and Firecallers camp on the ridge east of {npc:256728}. {npc:260973}, who carries the {item:269257}, stands among them. Just south of the ogres, {npc:260211} (an Alliance elite, level 42) and his Farholde Ambushers hold the scouts' camp: keep north of it unless you came with a group for him."] = "황혼의 난타꾼과 황혼의 불소환사들이 {npc:256728} 동쪽 산등성이에 진을 치고 있습니다. {item:269257}을(를) 지닌 {npc:260973}이(가) 그들 사이에 있습니다. 오우거 바로 남쪽에는 {npc:260211}(얼라이언스 정예, 42레벨)와(과) 파홀드 매복병들이 정찰병 야영지를 지키고 있습니다. 그를 잡을 파티가 없다면 야영지 북쪽으로 다니세요.",
	-- {item:269257} Skullbasher · {npc:260973} Klunk
	["{item:269257}, from {npc:260973}"] = "{npc:260973}에게서 얻는 {item:269257}",

	-- Step 55: The paletusks
	["The paletusks"] = "창백엄니 멧돼지",
	-- {npc:256728} Na'zok
	-- plural, as words: Young Paletusks = {npc:258331} Young Paletusk · Mature Paletusks = {npc:255851} Mature Paletusk
	["South down the hills, round the west side of the Alliance scouts' camp: tap the Young Paletusks with {npc:256728}'s staff to send them home; the Mature Paletusks around the hills drop the boar meat."] = "언덕을 따라 남쪽으로 내려가 얼라이언스 정찰병 야영지 서쪽을 돌아가세요. 어린 창백엄니에게 {npc:256728}의 지팡이를 사용해 집으로 돌려보내고, 언덕 주변의 다 자란 창백엄니에게서 멧돼지 고기를 얻으세요.",
	-- {item:268521} Swineherd's Staff
	-- plural, as words: Young Paletusks = {npc:258331} Young Paletusk
	["{item:268521}, on the Young Paletusks"] = "어린 창백엄니에게 {item:268521} 사용",
	-- {item:769} Chunk of Boar Meat
	-- plural, as words: Mature Paletusks = {npc:255851} Mature Paletusk
	["{item:769}, from the Mature Paletusks"] = "다 자란 창백엄니에게서 얻는 {item:769}",

	-- Step 57: Jom-jom's Escape
	-- {npc:258048} Jom-jom · {npc:256728} Na'zok · {area:16726} Bolder'ok
	["{npc:258048} waits by the Twilight ogres' camp north-east of {npc:256728}: take him home to {area:16726} and keep the cultists off him. If he falls, take the quest from him again."] = "{npc:258048}이(가) {npc:256728} 북동쪽 황혼의 오우거 야영지 옆에서 기다리고 있습니다. 그를 {area:16726}까지 데려가며 사교도들로부터 지켜 주세요. 그가 쓰러지면 다시 퀘스트를 받으세요.",
	-- {npc:258048} Jom-jom
	["{npc:258048}, in the cave"] = "",
	-- {npc:258048} Jom-jom · {area:16726} Bolder'ok
	["help {npc:258048} reach {area:16726}"] = "{npc:258048}이(가) {area:16726}에 도착하도록 돕기",

	-- Step 58: Bolder'ok
	-- {npc:255829} Clugfist · {npc:257062} Jezap Jinglesprocket · {quest:94668} Bloodmaster's Ring
	["Back to {npc:255829} on his hill. {npc:257062} runs the {quest:94668} just below it."] = "언덕 위의 {npc:255829}에게 돌아가세요. 바로 아래에서 {npc:257062}이(가) {quest:94668}을(를) 운영합니다.",

	-- Step 59: Clugfist
	-- {quest:95428} Clugfist's Decree · {npc:256418} Krom'rosh · {area:16743} Rog'mar
	["{quest:95428}: for {npc:256418} in {area:16743}, later in this guide"] = "{quest:95428}: 이 가이드 후반에 {area:16743}의 {npc:256418}에게 제출",
	-- {quest:94669} Pay to Play
	["{quest:94669}: the Ring's bouts, one-on-one fights with elites (41-45); a deposit first"] = "{quest:94669}: 투기장 시합, 정예와의 1대1 대결(41-45). 먼저 보증금 필요",

	-- Step 60: The Bloodmaster's Ring: Buzzbeak
	-- {quest:94670} Bloodmaster's Ring
	["The {quest:94670}: Buzzbeak"] = "{quest:94670}: 윙윙부리",
	-- {npc:255829} Clugfist · {npc:258626} Mog'thar · {npc:257059} Chub'chob · {npc:257062} Jezap Jinglesprocket
	["Each bout is a fight in the ring below {npc:255829}'s hill against an elite: Buzzbeak (41), Kronk and Bonegnaw (42), {npc:258626} (43), Snufflesnout (44) and {npc:257059} (45). Come in rested, with full health and mana; if a bout goes wrong, {npc:257062} offers it again."] = "각 시합은 {npc:255829}의 언덕 아래 투기장에서 정예와 싸우는 것입니다: 윙윙부리(41), 크롱크와 뼈갉이(42), {npc:258626}(43), 킁킁코(44), {npc:257059}(45). 휴식 경험치 상태로 생명력과 마나를 가득 채우고 들어가세요. 시합에 실패하면 {npc:257062}이(가) 다시 제안합니다.",
	-- {quest:94670} Bloodmaster's Ring
	["{quest:94670}: Buzzbeak"] = "{quest:94670}: 윙윙부리",
	["beat Buzzbeak"] = "윙윙부리 처치",

	-- Step 61: The Bloodmaster's Ring: Kronk and Bonegnaw
	-- {quest:94670} Bloodmaster's Ring
	["The {quest:94670}: Kronk and Bonegnaw"] = "{quest:94670}: 크롱크와 뼈갉이",
	["Kronk"] = "크롱크",
	["Bonegnaw"] = "뼈갉이",

	-- Step 62: The Bloodmaster's Ring: Mog'thar
	-- {quest:94962} Bloodmaster's Ring · {npc:258626} Mog'thar
	["The {quest:94962}: {npc:258626}"] = "{quest:94962}: {npc:258626}",

	-- Step 63: The Bloodmaster's Ring: Snufflesnout and Chub'chob
	-- {quest:94964} Bloodmaster's Ring · {npc:257059} Chub'chob
	["The {quest:94964}: Snufflesnout and {npc:257059}"] = "{quest:94964}: 킁킁코와 {npc:257059}",
	-- {npc:257062} Jezap Jinglesprocket · {npc:258626} Mog'thar
	["{npc:257062} offers the last two once Gobam's errands are done (players' recordings), which this guide leaves out. They are level 44 and 45: leave them for later if {npc:258626} was a close fight."] = "고밤의 심부름을 마치면 {npc:257062}이(가) 마지막 두 퀘스트를 주지만(플레이어 기록 기준), 이 가이드에서는 다루지 않습니다. 44레벨과 45레벨이니 {npc:258626}와의 싸움이 아슬아슬했다면 나중으로 미루세요.",
	["Snufflesnout (44)"] = "킁킁주둥이 (44)",
	-- {npc:255829} Clugfist
	["{npc:255829}, on the hill"] = "언덕 위의 {npc:255829}",

	-- Step 64: Powderfuse Port
	-- {area:16727} Powderfuse Port · {npc:255897} Friz Frazzlespark · {npc:259962} Fimbo Greasemitz · {npc:259961} Wharfmaster Whizzbuzz
	["South-east down out of the hills to {area:16727}, the goblins' harbour on the coast. {npc:255897} keeps a stall at the west end of the docks, {npc:259962} cooks by the inn, and {npc:259961} works the north pier."] = "언덕을 내려와 남동쪽으로 해안의 고블린 항구인 {area:16727}(으)로 가세요. {npc:255897}은(는) 부두 서쪽 끝에서 노점을 열고 있고, {npc:259962}은(는) 여관 옆에서 요리하며, {npc:259961}은(는) 북쪽 부두에서 일합니다.",
	-- {object:628948} WANTED! (no name in this language: may be words) · {npc:260235} Trapclaw
	["The {object:628948} poster by the inn: {npc:260235}"] = "여관 옆 {object:628948} 벽보: {npc:260235}",

	-- Step 65: Wharfmaster Whizzbuzz
	-- {npc:259961} Wharfmaster Whizzbuzz · {item:277974} Twice Reordered Package
	["{npc:259961} on the north pier takes Lozgil's {item:277974}."] = "북쪽 부두의 {npc:259961}에게 로즈길의 {item:277974}을(를) 전달하세요.",

	-- Step 66: WANTED: Old Rot-Chum
	-- {npc:257001} Old Rot-Chum
	["{npc:257001} is an elite (level 42) on the south shore: grouping up is advised."] = "{npc:257001}은(는) 남쪽 해안의 정예(42레벨)입니다. 파티를 권장합니다.",
	-- {object:628948} WANTED! (no name in this language: may be words)
	["The {object:628948} poster by the inn"] = "여관 옆 {object:628948} 벽보",

	-- Step 67: The murlocs, south-west
	["The murlocs, south-west"] = "남서쪽의 멀록",
	-- {quest:95260} Terrors From the Deep · {npc:260231} Argo Brinewhistle
	["South-west along the shore from the port: the saltwater murlocs camp on the beaches. On the way, a painted hide is stretched beside the path: it starts {quest:95260} for {npc:260231} at the docks."] = "항구에서 해안을 따라 남서쪽으로 가십시오. 바닷물 멀록이 해변에 진을 치고 있습니다. 가는 길에 길가에 칠한 가죽이 펼쳐져 있는데, 부두의 {npc:260231}을(를) 위한 {quest:95260}이(가) 시작됩니다.",

	-- Step 69: Back through the port
	["Back through the port"] = "항구를 거쳐 돌아가기",
	["Back north along the shore: hand in the murlocs and the hide on the docks on your way to the crawlers."] = "해안을 따라 북쪽으로 돌아가십시오. 게들에게 가는 길에 부두에서 멀록 퀘스트와 가죽 퀘스트를 제출하십시오.",
	-- {quest:95261} It Takes Guts
	["{quest:95261}: the beasts' entrails come as you go; the mushrooms grow on the ridge west of the pirates"] = "{quest:95261}: 야수 내장은 진행하면서 모이고, 버섯은 해적 서쪽 능선에서 자람",

	-- Step 70: Beast Entrails as you go
	-- {item:268632} Beast Entrails
	["{item:268632} as you go"] = "이동하며 {item:268632} 모으기",
	-- {zone:2548} Riverglades · {item:268632} Beast Entrails · {npc:260231} Argo Brinewhistle · {npc:257001} Old Rot-Chum · {npc:263380} Ghostmaw
	["Most beasts in the {zone:2548} drop {item:268632} for {npc:260231}: the shore crawlers on this coast and the boars on the ridge west of the pirates.\nCareful: {npc:257001} (elite, 42) wanders the shore and {npc:263380} (elite, 42) the river: take your beasts away from them."] = "{zone:2548}의 야수 대부분이 {npc:260231}에게 줄 {item:268632}을(를) 떨어뜨립니다. 이 해안의 해안 기어다니는 놈들과 해적 서쪽 능선의 멧돼지가 좋습니다.\n주의: {npc:257001}(정예, 42)이(가) 해안을, {npc:263380}(정예, 42)이(가) 강을 돌아다니니 야수를 그들에게서 멀리 끌어내 잡으세요.",

	-- Step 71: The crawlers and Trapclaw
	-- {npc:260235} Trapclaw
	["The crawlers and {npc:260235}"] = "게와 {npc:260235}",
	-- {npc:259962} Fimbo Greasemitz · {npc:260231} Argo Brinewhistle · {npc:260235} Trapclaw · {npc:259758} Gul'gash
	["North along the beach from the docks: the crawlers drop the meat for {npc:259962}, and their entrails count for {npc:260231}. {npc:260235}, a big crab, scuttles along the rocks east of the docks. {npc:259758}, a rare elite of level 49, roams this coast from the docks up to the pirates' camp: if you see him, keep well away."] = "부두에서 해변을 따라 북쪽으로 가세요. 기어다니는 놈들이 {npc:259962}에게 줄 고기를 떨어뜨리고, 내장은 {npc:260231}의 퀘스트에 포함됩니다. 큰 게인 {npc:260235}은(는) 부두 동쪽 바위를 따라 돌아다닙니다. 49레벨 희귀 정예인 {npc:259758}이(가) 부두부터 해적 야영지까지 이 해안을 배회하니, 보이면 멀리 피하세요.",

	-- Step 72: The Eastsea pirates
	["The Eastsea pirates"] = "동부해 해적",
	-- {npc:259758} Gul'gash
	["North-east along the coast to the pirates' camp on the cliffs. The buccaneers and musketeers carry the smuggled goods. {npc:259758} walks the camp too: keep an eye out for him."] = "해안을 따라 북동쪽, 절벽 위 해적 야영지로 가십시오. 해적과 머스킷병이 밀수품을 지니고 있습니다. {npc:259758}도 야영지를 돌아다니니 주의하십시오.",

	-- Step 73: Powderfuse Port
	["Back to the port, from the north pier west through the docks."] = "북쪽 부두에서 서쪽으로 선착장을 지나 항구로 돌아가십시오.",
	-- {quest:95293} Smuggler's Special · {npc:260390} Captain Bentcoin
	["{quest:95293}: for {npc:260390} at the pirates' camp"] = "{quest:95293}: 해적 야영지의 {npc:260390}에게",

	-- Step 75: The pirates' second wave
	["The pirates' second wave"] = "해적의 두 번째 무리",
	-- {npc:259758} Gul'gash
	-- plural, as words: Eastsea Raiders = {npc:257915} Eastsea Raider
	["North along the coast from the port: the Eastsea raiders and bombardiers have dug in on the slopes west of the buccaneers' camp, among their powder kegs. Watch for {npc:259758} on these cliffs.\nCareful: the Eastsea Raiders are level 44-45, a level or two over you here: pull them one at a time from the edge of the slopes and keep clear of the camp behind them."] = "항구에서 해안을 따라 북쪽으로 가세요. 동쪽바다 약탈자와 폭격수들이 해적 야영지 서쪽 비탈의 화약통 사이에 진을 쳤습니다. 이 절벽에서 {npc:259758}을(를) 조심하세요.\n주의: 동쪽바다 약탈자는 44-45레벨로 여러분보다 한두 레벨 높습니다. 비탈 가장자리에서 하나씩 끌어내고 뒤쪽 야영지에는 접근하지 마세요.",

	-- Step 76: Captain Bentcoin
	-- {npc:260390} Captain Bentcoin · {npc:260391} Captain Haynes
	["East along the cliffs to the far end of the pirates' camp: {npc:260390} waits by the water, {npc:260391} beside him."] = "절벽을 따라 동쪽으로 해적 야영지 맨 끝까지 가십시오. {npc:260390}이(가) 물가에, 그 옆에 {npc:260391}이(가) 있습니다.",

	-- Step 77: Powderfuse Port
	["Back to the port."] = "항구로 돌아가십시오.",
	-- {npc:255897} Friz Frazzlespark · {quest:95296} Shipping and Handling · {npc:260405} Wharfmaster Steamfizzle · {area:977} Steamwheedle Port · {zone:1444} Feralas · {zone:1446} Tanaris
	["{npc:255897}: {quest:95296}, for {npc:260405} at {area:977} in the {zone:1444} & {zone:1446} guide"] = "{npc:255897}: {quest:95296}, {zone:1444} & {zone:1446} 가이드의 {area:977}에 있는 {npc:260405}에게",

	-- Step 78: The pirates' ships
	["The pirates' ships"] = "해적선",
	-- {quest:95124} Admiral Lamora · {npc:259758} Gul'gash
	["Out to the pirates' cliffs once more. Plant Whizzbuzz's charges on the three ships moored below the camp, south to north; {quest:95124} stands by the middle one, with her loot chest beside her. Keep an eye out for {npc:259758} on the way.\nCareful: {quest:95124} is level 45, a level or two over you here: clear the deck around her first and come in with full health."] = "다시 해적 절벽으로 가세요. 야영지 아래 정박한 배 세 척에 남쪽부터 북쪽 순으로 위즈버즈의 폭약을 설치하세요. {quest:95124}은(는) 가운데 배 옆에 있고, 그 옆에 전리품 상자가 있습니다. 가는 길에 {npc:259758}을(를) 조심하세요.\n주의: {quest:95124}은(는) 45레벨로 여러분보다 한두 레벨 높습니다. 주변 갑판을 먼저 정리하고 생명력을 가득 채운 뒤 덤비세요.",
	-- {item:268505} Remote Explosive Charge
	["{item:268505}, the southern ship"] = "{item:268505}, 남쪽 배",
	["the middle ship"] = "가운데 배",
	["the northern ship"] = "북쪽 배",

	-- Step 79: Rotflesh Mushrooms
	-- plural, as words: Rotflesh Mushrooms = {item:268664} Rotflesh Mushroom
	["Rotflesh Mushrooms"] = "부패살점 버섯",
	-- plural, as words: Rotflesh Mushrooms = {item:268664} Rotflesh Mushroom · Mature Paletusks = {npc:255851} Mature Paletusk
	["West from the northern ship, up the ridge: the Rotflesh Mushrooms grow among the rocks, close to the Twilight ogres' camp. The Mature Paletusks on the ridge give entrails too."] = "북쪽 배에서 서쪽으로 능선을 오르십시오. 부패살점 버섯은 황혼의 망치 오우거 야영지 근처 바위 사이에 자랍니다. 능선의 다 자란 흰엄니도 내장을 줍니다.",

	-- Step 80: Finish the Beast Entrails
	-- {item:268632} Beast Entrails
	["Finish the {item:268632}"] = "{item:268632} 마저 모으기",
	-- {npc:259758} Gul'gash
	["South-east back towards the port: the shore crawlers on the beach north of the docks are the quickest entrails. {npc:259758} wanders down to this beach too."] = "남동쪽으로 항구 쪽으로 돌아가세요. 부두 북쪽 해변의 해안 기어다니는 놈들이 내장을 모으기 가장 빠릅니다. {npc:259758}은(는) 이 해변까지도 내려옵니다.",

	-- Step 81: Powderfuse Port
	["Down to the port."] = "항구로 내려가십시오.",
	-- {quest:95267} The Monster Surfaces · {npc:257001} Old Rot-Chum
	["{quest:95267}: a big beast in the shallows south-west of the port, near {npc:257001}, the elite"] = "{quest:95267}: 항구 남서쪽 얕은 물, 정예 {npc:257001} 근처의 큰 야수",

	-- Step 82: The Monster Surfaces
	-- {npc:260244} Monstrous Threshadon · {npc:257001} Old Rot-Chum
	["The {npc:260244} prowls the shallows south-west of the port, below the murlocs' beaches. {npc:257001}, an elite, walks the shore close by: give him room."] = "{npc:260244}은(는) 항구 남서쪽, 멀록 해변 아래 얕은 물을 배회합니다. 정예인 {npc:257001}이(가) 근처 해안을 걸어 다니니 거리를 두십시오.",

	-- Step 84: Rog'mar
	-- {area:16743} Rog'mar · {npc:256418} Krom'rosh · {npc:255829} Clugfist · {npc:258570} Da'grosh
	["Back to {area:16743} from the port, where your Hearthstone is set. {npc:256418} in the middle of the fort: {npc:255829}'s word sends him looking for {npc:258570}, his warrior in the west."] = "항구에서 귀환석이 설정된 {area:16743}(으)로 돌아가세요. 요새 중앙의 {npc:256418}: {npc:255829}의 전갈을 들으면 서쪽에 있는 자신의 전사 {npc:258570}을(를) 찾게 합니다.",
	-- {quest:94744} The Wayward Warrior · {npc:258570} Da'grosh · {area:16723} Sunnyglade
	["{quest:94744}: for {npc:258570}, west of {area:16723}"] = "{quest:94744}: {area:16723} 서쪽의 {npc:258570}에게",

	-- Step 86: Da'grosh
	-- {area:16743} Rog'mar · {area:16723} Sunnyglade · {area:16685} Twilight's Shroud · {npc:258570} Da'grosh · {npc:256418} Krom'rosh
	["West from {area:16743} through {area:16723} and on up the valley towards {area:16685}: {npc:258570}, {npc:256418}'s wayward warrior, keeps a camp in the hills below the Twilight cult's fortress."] = "{area:16743}에서 서쪽으로 {area:16723}을(를) 지나 계곡을 따라 {area:16685} 쪽으로 올라가세요. {npc:256418}의 길 잃은 전사 {npc:258570}이(가) 황혼 교단 요새 아래 언덕에 야영지를 차리고 있습니다.",

	-- Step 87: Crag'rog
	-- {npc:260993} Crag'rog · {area:16726} Bolder'ok · {npc:258570} Da'grosh
	["{npc:260993}, a {area:16726} ogre, hides in the cave west of {npc:258570}'s camp."] = "{area:16726} 오우거인 {npc:260993}은(는) {npc:258570}의 야영지 서쪽 동굴에 숨어 있습니다.",

	-- Step 88: The Twilight camps
	["The Twilight camps"] = "황혼의 야영지",
	-- {npc:258570} Da'grosh · {npc:256881} Overlord Kilgar · {npc:256891} Executioner Morg · {npc:258023} Sergeant Riftan
	-- plural, as words: Rog'mar Scouts = {npc:257450} Rog'mar Scout · Twilight Enforcers = {npc:256800} Twilight Enforcer · Farholde Lookouts = {npc:258686} Farholde Lookout
	["The cult's camps fill the valley south and west of {npc:258570}. Free the captive Rog'mar Scouts as you find them. Twilight Enforcers (elites, level 45) patrol through the camps: watch where they walk before each pull. {npc:256881} and {npc:256891} (elites, 46) hold the fortress at the valley's head: pull the cultists away from them. {npc:258023}'s Alliance camp sits at the valley's south end, and its Farholde Lookouts (level 46) attack the Horde: stay north of it."] = "교단의 야영지가 {npc:258570}의 남쪽과 서쪽 골짜기를 채우고 있습니다. 붙잡힌 로그마르 정찰병을 보이는 대로 풀어 주세요. 황혼의 집행자(정예, 45레벨)가 야영지를 순찰합니다. 몹을 끌기 전에 매번 동선을 확인하세요. {npc:256881}와(과) {npc:256891}(정예, 46)이(가) 골짜기 끝의 요새를 지키고 있습니다. 교단원을 그들에게서 떨어진 곳으로 끌어내세요. 골짜기 남쪽 끝에는 {npc:258023}의 얼라이언스 야영지가 있으며, 그곳의 파홀드 감시병(46레벨)이 호드를 공격합니다. 그 북쪽에 머무르세요.",
	-- plural, as words: Rog'mar Scouts = {npc:257450} Rog'mar Scout
	["free five captive Rog'mar Scouts"] = "붙잡힌 로그마르 정찰병 5명 풀어 주기",

	-- Step 89: The ogre mine
	["The ogre mine"] = "오우거 광산",
	-- plural, as words: Twilight Enforcers = {npc:256800} Twilight Enforcer
	["North of the camps the cult works ogre miners in a mine: talk five of them into rising up against their masters.\nCareful: Twilight Enforcers (elites, level 45) walk past the mine's mouth on their way through the camps. Wait for one to pass before you go in."] = "야영지 북쪽 광산에서 교단이 오우거 광부를 부리고 있습니다. 그중 다섯 명을 설득해 주인에게 맞서게 하세요.\n주의: 황혼의 집행자(정예, 45레벨)가 야영지를 오가며 광산 입구를 지나갑니다. 지나갈 때까지 기다렸다가 들어가세요.",
	-- plural, as words: Ogre Miners = {npc:260995} Ogre Miner
	["recruit five Ogre Miners"] = "오우거 광부 5명 포섭하기",

	-- Step 92: Bring Me His Head
	-- {npc:256881} Overlord Kilgar
	["{npc:256881} is an elite (level 46) in the fortress at the head of the valley, with the Enforcers around him: grouping up is advised."] = "{npc:256881}은(는) 골짜기 끝 요새에 있는 정예(46레벨)이며 주위에 집행자들이 있습니다. 파티를 권장합니다.",

	-- Step 93: Twilight's Shroud
	-- {area:340} Kargath · {area:3} Badlands · {npc:258570} Da'grosh · {area:16685} Twilight's Shroud
	["The next guide flies from {area:340} in the {area:3}: north out of {npc:258570}'s valley and up through {area:16685}, the way through to the {area:3}."] = "다음 가이드는 {area:3}의 {area:340}에서 비행으로 시작합니다. {npc:258570}의 골짜기에서 북쪽으로 나가 {area:3}(으)로 통하는 {area:16685}을(를) 지나 올라가세요.",

	-- Step 94: Kargath
	-- {area:3} Badlands · {area:340} Kargath
	["Across the {area:3} to {area:340}, the Horde fortress built into the cliffs at the zone's western edge: its flight master stands at the foot of the fortress."] = "{area:3}을(를) 가로질러 지역 서쪽 끝 절벽에 지어진 호드 요새 {area:340}(으)로 가세요. 비행 조련사는 요새 아래에 있습니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:263190}'s spears, on the Freshwater Crocolisks"] = "민물 악어에게 {npc:263190}의 창 사용",
}
