-- Korean (koKR): the guide forever/horde/orc-troll/02-the-barrens (forever/horde/orc-troll/02-the-barrens.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Crossroads
	-- {area:379} Far Watch Post · {npc:3338} Sergra Darkthorn · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger · {npc:3464} Gazrog · {npc:3448} Tonga Runetotem
	["You arrive from {area:379}. {npc:3338} stands by the inn; {npc:3429} and {npc:3449} on the tower platform; Helbrim and {npc:3464} by the north gate; {npc:3448} at the south gate."] = "{area:379}에서 도착합니다. {npc:3338}은(는) 여관 옆에, {npc:3429}와(과) {npc:3449}은(는) 탑 위에, 헬브림과 {npc:3464}은(는) 북문 옆에, {npc:3448}은(는) 남문에 있습니다.",

	-- Step 2: Plainstriders and raptors
	["Plainstriders and raptors"] = "초원타조와 랩터",
	-- {area:380} The Crossroads
	["Plainstriders and Sunscale raptors roam the plains all around the {area:380}."] = "초원타조와 열대초원랩터가 {area:380} 주변 평원 곳곳을 돌아다닙니다.",

	-- Step 4: Zhevra and raptors
	["Zhevra and raptors"] = "얼룩말과 랩터",
	-- plural, as words: Zhevra Runners = {npc:3242} Zhevra Runner
	["Zhevra Runners graze on the same plains; finish the raptor heads as you go."] = "{npc:3242}도 같은 평원에서 풀을 뜯습니다. 가는 길에 랩터 머리도 마저 모으세요.",

	-- Step 5: The Crossroads
	-- {npc:3449} Darsok Swiftdagger
	["{npc:3449}, on the tower platform: needs level 12"] = "{npc:3449}, 탑 위: 12레벨 필요",

	-- Step 6: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:392} Ratchet
	["{npc:5878} camps beside the road east toward {area:392}."] = "{npc:5878}은(는) {area:392}(으)로 가는 동쪽 길 옆에 진을 치고 있습니다.",

	-- Step 7: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {area:380} The Crossroads
	["{npc:5907} stands on the ridge north of the Razormane camp, east of the {area:380}."] = "{npc:5907}은(는) {area:380} 동쪽, 서슬갈기일족 야영지 북쪽 능선에 서 있습니다.",

	-- Step 8: Telf Joolam
	-- {npc:5900} Telf Joolam · {zone:1411} Durotar · {area:814} Southfury River
	["{npc:5900} waits on the {zone:1411} bank of the {area:814}, east of the Razormane camp."] = "{npc:5900}은(는) 서슬갈기일족 야영지 동쪽, {area:814}의 {zone:1411} 쪽 강둑에서 기다립니다.",

	-- Step 9: Dustwind Gulch cultists
	-- {area:1898} Dustwind Gulch
	["{area:1898} cultists"] = "{area:1898} 이교도",
	-- {area:1898} Dustwind Gulch · {zone:1411} Durotar · {area:370} Drygulch Ravine · {item:6652} Reagent Pouch
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["Burning Blade Cultists hold {area:1898} in northern {zone:1411}, by {area:370}; they drop the {item:6652}."] = "{npc:3199}이(가) {zone:1411} 북부 {area:370} 옆의 {area:1898}을(를) 차지하고 있으며, {item:6652}을(를) 떨어뜨립니다.",

	-- Step 10: Razormane camp
	["Razormane camp"] = "서슬갈기일족 야영지",
	-- {area:380} The Crossroads · {object:58369} Stolen Iron Chest · {item:5026} Fire Tar
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["Water Seekers, Thornweavers and Hunters hold the camp east of the {area:380}. The supply crates sit at its eastern end. Warriors: the {object:58369} stands in the camp. Shamans: the quilboar drop the {item:5026}. Kill Savannah Prowlers you pass for their claws."] = "서슬갈기일족 풍수사, 가시마술사, 사냥꾼이 {area:380} 동쪽 야영지를 차지하고 있습니다. 보급품 상자는 야영지 동쪽 끝에 있습니다. 전사: {object:58369}은(는) 야영지 안에 있습니다. 주술사: 멧돼지인간이 {item:5026}을(를) 떨어뜨립니다. 지나가며 굶주린 사바나 사자를 처치해 발톱을 모으세요.",

	-- Step 11: Telf Joolam
	-- {npc:5900} Telf Joolam · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember
	["{npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "{npc:5900}이(가) 타르와 주머니로 {item:6636}을(를) 만들어 줍니다. 그 옆 화로에서 사용해 {npc:5893}을(를) 드러내고, 처치해 {item:6655}을(를) 얻은 뒤 잉걸불을 화로에 넣으세요.",

	-- Step 12: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:5907}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:5907}: {npc:2523}, {item:5176}, {item:263412}",

	-- Step 14: Ratchet
	-- {area:392} Ratchet
	["Follow the road south-east to {area:392} on the coast."] = "길을 따라 남동쪽으로 해안의 {area:392}까지 가세요.",
	-- {quest:1492} Wharfmaster Dizzywig
	["{quest:1492}, on the dock"] = "{quest:1492}, 부두 위",

	-- Step 15: Southsea beach
	["Southsea beach"] = "남쪽바다 해변",
	-- {area:392} Ratchet
	["The pirates camp along the beach south of {area:392}. The piles of complicated parts lie in and around their camp."] = "해적들이 {area:392} 남쪽 해변을 따라 진을 치고 있습니다. 복잡한 부품 더미는 야영지 안팎에 있습니다.",

	-- Step 17: Stolen Booty
	-- {object:3767} Drizzlik's Emporium
	["Back to the pirate camp: the boots are in the crate marked {object:3767} at the camp's south end, the lens in the Fragile crate just east of it."] = "해적 야영지로 돌아가세요. 장화는 야영지 남쪽 끝의 {object:3767} 표시 상자에, 렌즈는 그 바로 동쪽의 Fragile 상자에 있습니다.",

	-- Step 19: Back to the The Crossroads
	-- {area:380} The Crossroads
	["Back to the {area:380}"] = "{area:380}로 돌아가기",
	-- {area:380} The Crossroads
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["Walk back up the road to the {area:380}. Savannah Prowlers hunt along it and on the plains west of town: finish the claws before you hand them in."] = "길을 따라 {area:380}까지 걸어 돌아가세요. 굶주린 사바나 사자가 길가와 마을 서쪽 평원에서 사냥합니다. 제출하기 전에 발톱을 마저 모으세요.",

	-- Step 20: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate · {area:380} The Crossroads
	["{npc:3389} stands at the Kolkar watch post just west of the {area:380}."] = "{npc:3389}은(는) {area:380} 바로 서쪽의 콜카르 감시초소에 서 있습니다.",

	-- Step 21: Kolkar camps and the Forgotten Pools
	-- {area:386} Forgotten Pools
	["Kolkar camps and the {area:386}"] = "콜카르 야영지와 {area:386}",
	-- {npc:3389} Regthar Deathgate · {quest:855} Centaur Bracers · {area:386} Forgotten Pools
	-- plural, as words: Laden Mushrooms = {object:3640} Laden Mushroom · Savannah Prowlers = {npc:3425} Savannah Prowler
	["The Kolkar camps spread north-west of {npc:3389}; every Kolkar can drop {quest:855}. {area:386} lie in their middle, with Laden Mushrooms around the water. Savannah Prowlers roam the same plains."] = "콜카르 야영지는 {npc:3389} 북서쪽으로 퍼져 있습니다. 콜카르는 누구나 {quest:855}을(를) 떨어뜨릴 수 있습니다. {area:386}은(는) 그 한가운데에 있고, 물가에 독버섯이 있습니다. 굶주린 사바나 사자도 같은 평원을 돌아다닙니다.",
	["Wade into the pools to explore them"] = "웅덩이에 들어가 탐험하세요",

	-- Step 23: Witchwing harpies
	["Witchwing harpies"] = "칼날바람하피",
	-- {area:383} Dry Hills · {area:386} Forgotten Pools
	["The harpies nest in the {area:383} north-west of the {area:386}; any of them can drop a talon."] = "하피는 {area:386} 북서쪽 {area:383}에 둥지를 틀고 있습니다. 누구든 발톱을 떨어뜨릴 수 있습니다.",

	-- Step 24: The Sludge Fen
	-- {area:382} The Sludge Fen · {object:4141} Control Console · {item:5089} Console Key · {npc:3471} Tinkerer Sniggles
	["Head east to the Venture Co. research site west of the {area:382}. Use the {object:4141}, close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471}."] = "동쪽으로 {area:382} 서쪽의 투자개발회사 연구 현장으로 가세요. {object:4141}을(를) 사용하고, 시추기 주변의 밸브 세 개를 잠근 뒤, 다시 제어판을 사용하고 {npc:3471}에게서 {item:5089}을(를) 가져가세요.",

	-- Step 25: Echeyakee
	-- {quest:881} Echeyakee · {area:382} The Sludge Fen · {area:380} The Crossroads · {npc:3338} Sergra Darkthorn · {area:392} Ratchet
	["{quest:881}'s lair lies south of the {area:382}, north-east of the {area:380}. Use the horn {npc:3338} gave you there to call the white lion out. Then hearth to {area:392}."] = "{quest:881}의 굴은 {area:382} 남쪽, {area:380} 북동쪽에 있습니다. 그곳에서 {npc:3338}이(가) 준 뿔피리를 불어 흰 사자를 불러내세요. 그런 다음 {area:392}(으)로 귀환하세요.",

	-- Step 27: The Disruption Ends
	-- {area:380} The Crossroads · {npc:3438} Kreenig Snarlsnout
	["On the way back to the {area:380}, the Razormane camp again: Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "{area:380}로 돌아가는 길에 다시 서슬갈기일족 야영지로: 흙점쟁이와 파수병이 동쪽 절반을 차지하고 있으며, {npc:3438}이(가) 그 사이를 걸어다닙니다.",

	-- Step 29: The Stagnant Oasis
	-- {area:380} The Crossroads
	["The oasis lies south-east of the {area:380}. Test the seeds at the bubbling fissure in the middle of the water."] = "오아시스는 {area:380} 남동쪽에 있습니다. 물 한가운데 거품이 이는 균열에서 씨앗을 시험하세요.",

	-- Step 30: Raptor Grounds
	-- {area:1697} Raptor Grounds
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["The {area:1697} lie south-west of the oasis. Sunscale Scytheclaws drop the feathers you use on the three nests."] = "{area:1697}은(는) 오아시스 남서쪽에 있습니다. {npc:3256}이(가) 떨어뜨리는 깃털을 둥지 세 곳에 사용하세요.",

	-- Step 32: Lushwater Oasis
	-- {area:387} Lushwater Oasis · {area:380} The Crossroads
	-- plural, as words: Oasis Snapjaws = {npc:3461} Oasis Snapjaw
	["Oasis Snapjaws crowd the water of {area:387}, south-west of the {area:380}."] = "오아시스 무쇠턱거북이 {area:380} 남서쪽 {area:387}의 물에 가득합니다.",

	-- Step 34: Wenikee Boltbucket
	-- {area:1703} Mor'shan Rampart · {npc:9316} Wenikee Boltbucket
	["Follow the road north to the {area:1703}; {npc:9316} stands just south of it."] = "길을 따라 북쪽 {area:1703}까지 가세요. {npc:9316}은(는) 그 바로 남쪽에 서 있습니다.",

	-- Step 35: Nugget Slugs
	-- {area:382} The Sludge Fen · {npc:9316} Wenikee Boltbucket
	-- plural, as words: Tool Buckets = {object:161752} Tool Bucket
	["The Tool Buckets sit around the Venture Co. camp in the {area:382}, east of {npc:9316}."] = "연장통은 {npc:9316} 동쪽 {area:382}의 투자개발회사 야영지 주변에 있습니다.",

	-- Step 37: Witchwing Slayers
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["Witchwing Slayers"] = "{npc:3278}",
	-- {area:383} Dry Hills
	["The Slayers hold the western end of the {area:383}, past the harpies you fought before; they drop the rings."] = "암살자는 전에 싸운 하피들 너머 {area:383} 서쪽 끝을 차지하고 있으며, 반지를 떨어뜨립니다.",
	-- {area:383} Dry Hills · {zone:1413} The Barrens
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["grind on Witchwing Slayers at the {area:383}, {zone:1413}"] = "{zone:1413} {area:383}에서 {npc:3278} 사냥",

	-- Step 38: The Crossroads
	-- {area:380} The Crossroads
	["Back to the {area:380}; the next guide starts here."] = "{area:380}로 돌아가세요. 다음 가이드는 여기서 시작합니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the {area:380}"] = "{area:380}(으)로 돌아가기",
	-- ["Back to the {area:380}; the next guide starts here."] = "{area:380}(으)로 돌아가세요. 다음 가이드는 여기서 시작합니다.",
	-- ["Head east to the Venture Co. research site west of the {area:382}. Use the {object:4141}, close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471}."] = "동쪽으로 {area:382} 서쪽의 투자개발회사 연구 현장으로 가세요. {object:4141}을(를) 사용하고, 시추기 주변의 밸브 세 개를 잠근 뒤, 다시 제어판을 사용하고 {npc:3471}에게서 {item:5089}을(를) 가져가세요.",
	-- ["Oasis Snapjaws crowd the water of {area:387}, south-west of the {area:380}."] = "{npc:3461}이(가) {area:380} 남서쪽 {area:387}의 물에 가득합니다.",
	-- ["On the way back to the {area:380}, the Razormane camp again: Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "{area:380}(으)로 돌아가는 길에 다시 서슬갈기일족 야영지로: 흙점쟁이와 파수병이 동쪽 절반을 차지하고 있으며, {npc:3438}이(가) 그 사이를 걸어다닙니다.",
	-- ["Plainstriders and Sunscale raptors roam the plains all around the {area:380}."] = "초원타조와 열대초원랩터가 {area:380} 주변 평원 곳곳을 돌아다닙니다.",
	-- ["Regthar stands at the Kolkar watch post just west of the {area:380}."] = "렉타르는 {area:380} 바로 서쪽의 콜카르 감시초소에 서 있습니다.",
	-- ["The Kolkar camps spread north-west of Regthar; every Kolkar can drop {quest:855}. {area:386} lie in their middle, with Laden Mushrooms around the water. Savannah Prowlers roam the same plains."] = "콜카르 야영지는 렉타르 북서쪽으로 퍼져 있습니다. 콜카르는 누구나 {quest:855}을(를) 떨어뜨릴 수 있습니다. {area:386}은(는) 그 한가운데에 있고, 물가에 {object:3640}이(가) 있습니다. {npc:3425}도 같은 평원을 돌아다닙니다.",
	-- ["The Tool Buckets sit around the Venture Co. camp in the {area:382}, east of Wenikee."] = "{object:161752}은(는) 웨니키 동쪽 {area:382}의 투자개발회사 야영지 주변에 있습니다.",
	-- ["The oasis lies south-east of the {area:380}. Test the seeds at the bubbling fissure in the middle of the water."] = "오아시스는 {area:380} 남동쪽에 있습니다. 물 한가운데 거품이 이는 균열에서 씨앗을 시험하세요.",
	-- ["The {area:386}"] = "{area:386}",
	-- ["Walk back up the road to the {area:380}. Savannah Prowlers hunt along it and on the plains west of town: finish the claws before you hand them in."] = "길을 따라 {area:380}까지 걸어 돌아가세요. {npc:3425}이(가) 길가와 마을 서쪽 평원에서 사냥합니다. 제출하기 전에 발톱을 마저 모으세요.",
	-- ["Water Seekers, Thornweavers and Hunters hold the camp east of the {area:380}. The supply crates sit at its eastern end. Warriors: the {object:58369} stands in the camp. Shamans: the quilboar drop the {item:5026}. Kill Savannah Prowlers you pass for their claws."] = "서슬갈기일족 풍수사, 가시마술사, 사냥꾼이 {area:380} 동쪽 야영지를 차지하고 있습니다. 보급품 상자는 야영지 동쪽 끝에 있습니다. 전사: {object:58369}은(는) 야영지 안에 있습니다. 주술사: 멧돼지인간이 {item:5026}을(를) 떨어뜨립니다. 지나가며 {npc:3425}을(를) 처치해 발톱을 모으세요.",
	-- ["{npc:5907} stands on the ridge north of the Razormane camp, east of the {area:380}."] = "{npc:5907}은(는) {area:380} 동쪽, 서슬갈기일족 야영지 북쪽 능선에 서 있습니다.",
	-- ["{quest:881}'s lair lies south of the {area:382}, north-east of the {area:380}. Use the horn Sergra gave you there to call the white lion out. Then hearth to {area:392}."] = "{quest:881}의 굴은 {area:382} 남쪽, {area:380} 북동쪽에 있습니다. 그곳에서 셀그라가 준 뿔피리를 불어 흰 사자를 불러내세요. 그런 다음 {area:392}(으)로 귀환하세요.",
}
