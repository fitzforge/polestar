-- Korean (koKR): the guide forever/horde/02-the-barrens (forever/horde/02-the-barrens.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Crossroads
	-- {area:380} The Crossroads
	["{area:380} is your base for this guide. Everyone you need stands within a few steps of the inn."] = "이 가이드에서는 {area:380}이(가) 거점입니다. 필요한 사람은 모두 여관에서 몇 걸음 거리에 있습니다.",
	-- {npc:3615} Devrak
	["{npc:3615}, the wind rider master"] = "윈드라이더 조련사 {npc:3615}",
	-- {npc:3449} Darsok Swiftdagger · {area:383} Dry Hills
	["{npc:3449}: the harpies come later, in the {area:383}"] = "{npc:3449}: 하피는 나중에 {area:383}에서 처리합니다",

	-- Step 2: Plainstriders and raptors
	["Plainstriders and raptors"] = "초원타조와 랩터",
	-- {area:380} The Crossroads
	["Plainstriders and Sunscale raptors roam the plains all around the {area:380}, thickest to the north."] = "초원타조와 열대초원랩터가 {area:380} 주변 평원 곳곳을 돌아다니며, 북쪽에 가장 많습니다.",

	-- Step 4: The Zhevra
	-- plural, as words: Zhevra Runners = {npc:3242} Zhevra Runner
	["Zhevra Runners graze north and east of town."] = "굶주린 얼룩말은 마을 북쪽과 동쪽에서 풀을 뜯습니다.",
	["Zhevra"] = "얼룩말",

	-- Step 6: Razormane camp
	["Razormane camp"] = "서슬갈기일족 야영지",
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["The Savannah Prowlers hunt the plains between town and the Razormane camp to the east. In the camp, Water Seekers and Thornweavers hold the western half, Hunters the middle; the supply crates sit at its eastern end."] = "굶주린 사바나 사자는 마을과 동쪽의 서슬갈기일족 야영지 사이 평원에서 사냥합니다. 야영지 서쪽 절반은 풍수사와 가시마술사가, 가운데는 사냥꾼이 차지하고 있으며, 보급품 상자는 동쪽 끝에 있습니다.",

	-- Step 7: Kranal Fiss
	-- {npc:5907} Kranal Fiss
	["{npc:5907} stands on the ridge north of the Razormane camp."] = "{npc:5907}은(는) 서슬갈기일족 야영지 북쪽 능선에 서 있습니다.",

	-- Step 8: Far Watch Post
	-- {area:814} Southfury River
	["Follow the road east to the outpost above the {area:814}."] = "길을 따라 동쪽으로 가서 {area:814} 위의 전초기지로 가세요.",

	-- Step 9: Thunder lizards across the river
	["Thunder lizards across the river"] = "강 건너편의 천둥도마뱀",
	-- {area:379} Far Watch Post
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze just across the bridge below {area:379}."] = "천둥도마뱀과 번개도마뱀은 {area:379} 아래 다리 바로 건너편에서 풀을 뜯습니다.",

	-- Step 11: Telf Joolam
	-- {npc:5900} Telf Joolam · {area:379} Far Watch Post
	["{npc:5900} waits on the riverbank south of {area:379}, across the bridge."] = "{npc:5900}은(는) 다리 건너 {area:379} 남쪽 강기슭에서 기다립니다.",

	-- Step 12: Dustwind Gulch cultists
	-- {area:1898} Dustwind Gulch
	["{area:1898} cultists"] = "{area:1898}의 이교도",
	-- {area:1898} Dustwind Gulch · {zone:1411} Durotar · {item:6652} Reagent Pouch · {item:5026} Fire Tar
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["Burning Blade Cultists hold {area:1898} in northern {zone:1411}; they drop the {item:6652}. The {item:5026} comes from the Razormane on your next visit to their camp."] = "불타는칼날단 이교도는 {zone:1411} 북부의 {area:1898}을(를) 차지하고 있으며, {item:6652}을(를) 떨어뜨립니다. {item:5026}은(는) 다음에 서슬갈기일족 야영지에 갈 때 그들에게서 얻습니다.",

	-- Step 13: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:380} The Crossroads · {area:392} Ratchet · {object:58369} Stolen Iron Chest
	["{npc:5878} camps beside the road from the {area:380} to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "{npc:5878}은(는) {area:380}에서 {area:392}(으)로 가는 길가에 야영하고 있습니다. {object:58369}은(는) 그 바로 북쪽, 서슬갈기일족 야영지 남쪽에 있습니다.",

	-- Step 14: Ratchet
	-- {area:392} Ratchet
	["Follow the road south-east to {area:392} on the coast."] = "길을 따라 남동쪽으로 해안의 {area:392}까지 가세요.",
	-- {npc:3442} Sputtervalve · {area:382} Sludge Fen
	["{npc:3442}: the console is in the {area:382}, later"] = "{npc:3442}: 제어판은 나중에 {area:382}에서 처리합니다",
	-- {quest:1492} Wharfmaster Dizzywig
	["{quest:1492}, on the dock"] = "부두의 {quest:1492}",

	-- Step 15: Southsea beach
	["Southsea beach"] = "남쪽바다해적단 해변",
	-- {area:392} Ratchet
	["The pirates camp on the beach south of {area:392}. The piles of complicated parts lie in the sand among them."] = "해적들은 {area:392} 남쪽 해변에 야영하고 있습니다. 복잡한 부품 더미는 그들 사이의 모래밭에 있습니다.",

	-- Step 17: Stolen Booty
	["Back down the beach, past the pirate camp: the crate of boots and the fragile crate with the lens sit at its south end."] = "해적 야영지를 지나 해변을 따라 다시 내려가세요. 장화 상자와 렌즈가 든 깨지기 쉬운 상자는 해변 남쪽 끝에 있습니다.",

	-- Step 19: The Crossroads
	-- {area:380} The Crossroads
	["Walk back west along the road to the {area:380}."] = "길을 따라 서쪽의 {area:380}로 돌아가세요.",

	-- Step 20: The Disruption Ends
	-- {npc:3438} Kreenig Snarlsnout
	["Back to the Razormane camp. Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "서슬갈기일족 야영지로 돌아가세요. 동쪽 절반은 흙점쟁이와 파수병이 차지하고 있으며, {npc:3438}은(는) 그들 사이를 돌아다닙니다.",

	-- Step 21: Telf Joolam
	-- {npc:5900} Telf Joolam · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember
	["{npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "{npc:5900}이(가) 타르와 주머니로 {item:6636}을(를) 만들어 줍니다. 그 옆의 화로 곁에서 사용해 {npc:5893}을(를) 드러내고, 처치해 {item:6655}을(를) 얻은 뒤 잉걸불을 화로에 넣으세요.",

	-- Step 22: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:5907}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:5907}: {npc:2523}, {item:5176}, {item:263412}",

	-- Step 23: Echeyakee
	-- {quest:881} Echeyakee
	["{quest:881}, a white lion, prowls the plains north of the Razormane camp."] = "흰 사자 {quest:881}은(는) 서슬갈기일족 야영지 북쪽 평원을 돌아다닙니다.",

	-- Step 24: Samophlange
	-- {object:4141} Control Console · {area:382} Sludge Fen · {item:5089} Console Key · {npc:3471} Tinkerer Sniggles
	["The {object:4141} stands at the Venture Co. research site west of the {area:382}. Close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471} beside it."] = "{object:4141}은(는) {area:382} 서쪽의 투자개발회사 연구 현장에 있습니다. 시추기 주변의 밸브 세 개를 잠그고 제어판을 다시 사용한 뒤, 그 옆의 {npc:3471}에게서 {item:5089}을(를) 얻으세요.",
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["{npc:3442} in {area:392}: later, on the way"] = "{area:392}의 {npc:3442}: 나중에 가는 길에",

	-- Step 25: Dry Hills
	-- {area:383} Dry Hills · {quest:819} Chen's Empty Keg
	["West to the {area:383}. The Witchwing harpies nest all over them; any of them can drop a talon. {quest:819} lies in their hills."] = "서쪽의 {area:383}(으)로 가세요. 칼날바람하피가 곳곳에 둥지를 틀고 있으며, 누구나 발톱을 떨어뜨릴 수 있습니다. {quest:819}은(는) 그 언덕에 있습니다.",

	-- Step 26: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate
	["South to {npc:3389}'s watch post on the Kolkar border."] = "남쪽으로 콜카르일족 경계의 {npc:3389} 감시 초소로 가세요.",

	-- Step 27: The Forgotten Pools
	-- {npc:3389} Regthar Deathgate
	-- plural, as words: Laden Mushrooms = {object:3640} Laden Mushroom
	["The pools lie just north of {npc:3389}. Walk into the water to explore them; the Laden Mushrooms for Helbrim grow around them. Kill every Kolkar you pass for bracers."] = "웅덩이는 {npc:3389} 바로 북쪽에 있습니다. 물에 들어가 탐험하세요. 헬브림에게 줄 숙성한 버섯은 그 주변에 자랍니다. 지나가며 만나는 콜카르일족은 모두 처치해 손목보호대를 얻으세요.",

	-- Step 28: Kolkar camps
	["Kolkar camps"] = "콜카르일족 야영지",
	-- {npc:3389} Regthar Deathgate
	-- plural, as words: Kolkar Wranglers = {npc:3272} Kolkar Wrangler
	["Kolkar Wranglers and Stormers hold the camps south of {npc:3389}."] = "콜카르일족 사냥꾼과 번개술사는 {npc:3389} 남쪽 야영지를 차지하고 있습니다.",

	-- Step 31: The Stagnant Oasis
	-- {area:380} The Crossroads
	["South-east of the {area:380}. Test the seeds at the bubbling fissure on the oasis' east bank."] = "{area:380} 남동쪽입니다. 오아시스 동쪽 기슭의 부글거리는 균열에서 씨앗을 시험하세요.",

	-- Step 32: Raptor nests
	["Raptor nests"] = "랩터 둥지",
	-- {area:1697} Raptor Grounds
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["The three nests sit together in the {area:1697} south-west of the oasis; Sunscale Scytheclaws guard them."] = "둥지 세 개는 오아시스 남서쪽 {area:1697}에 모여 있으며, 갈퀴발톱 열대초원랩터가 지키고 있습니다.",

	-- Step 33: Ratchet
	-- {area:392} Ratchet
	["East to {area:392}, on the coast."] = "동쪽 해안의 {area:392}(으)로 가세요.",

	-- Step 34: The Crossroads
	["Back west along the road."] = "길을 따라 서쪽으로 돌아가세요.",

	-- Step 35: Lushwater Oasis
	-- {area:387} Lushwater Oasis · {area:380} The Crossroads · {area:388} Stagnant Oasis
	-- plural, as words: Oasis Snapjaws = {npc:3461} Oasis Snapjaw
	["Oasis Snapjaws crawl around {area:387}, south-west of the {area:380}, and around the {area:388}."] = "오아시스 무쇠턱거북은 {area:380} 남서쪽의 {area:387}와(과) {area:388} 주변을 기어다닙니다.",

	-- Step 36: The Crossroads
	-- {quest:3301} Mura Runetotem · {area:228} Sepulcher · {zone:1421} Silverpine Forest
	["{quest:3301}: the {area:228} in {zone:1421}, next guide"] = "{quest:3301}: 다음 가이드에서 {zone:1421}의 {area:228}",

	-- Step 37: Harpy Lieutenants
	-- {area:383} Dry Hills
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["The Witchwing Slayers hold the western {area:383}; they wear the rings."] = "칼날바람일족 암살자는 {area:383} 서부를 차지하고 있으며, 반지를 끼고 있습니다.",

	-- Step 38: Wenikee Boltbucket
	-- {area:1703} Mor'shan Rampart · {npc:9316} Wenikee Boltbucket
	["East to the {area:1703}; {npc:9316} stands at the camp just south of it."] = "동쪽의 {area:1703}(으)로 가세요. {npc:9316}은(는) 그 바로 남쪽 야영지에 있습니다.",

	-- Step 39: Nugget Slugs
	-- {area:382} Sludge Fen · {npc:9316} Wenikee Boltbucket
	["The tool buckets with the slugs lie around the Venture Co. drill site in the {area:382}, east of {npc:9316}."] = "민달팽이가 든 공구 양동이는 {npc:9316} 동쪽, {area:382}의 투자개발회사 시추 현장 주변에 있습니다.",

	-- Step 40: Wenikee Boltbucket
	-- {quest:3923} Rilli Greasygob · {zone:1454} Orgrimmar
	["Keep it: {quest:3923} stands outside {zone:1454}; a later guide hands it in"] = "보관하세요: {quest:3923}은(는) {zone:1454} 밖에 있으며, 나중 가이드에서 완료합니다",

	-- Step 41: The Crossroads
	-- {area:380} The Crossroads · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["Walk back south to the {area:380}. The next guide starts here and takes you to {zone:1454} and the zeppelin to {zone:1420}."] = "남쪽의 {area:380}로 걸어서 돌아가세요. 다음 가이드는 여기서 시작해 {zone:1454}와(과) {zone:1420}행 비행선으로 안내합니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Oasis Snapjaws crawl around {area:387}, south-west of the {area:380}, and around the {area:388}."] = "오아시스 무쇠턱거북은 {area:380} 남서쪽의 {area:387}와(과) {area:388} 주변을 기어다닙니다.",
	-- ["Plainstriders and Sunscale raptors roam the plains all around the {area:380}, thickest to the north."] = "초원타조와 열대초원랩터가 {area:380} 주변 평원 곳곳을 돌아다니며, 북쪽에 가장 많습니다.",
	-- ["South-east of the {area:380}. Test the seeds at the bubbling fissure on the oasis' east bank."] = "{area:380} 남동쪽입니다. 오아시스 동쪽 기슭의 부글거리는 균열에서 씨앗을 시험하세요.",
	-- ["The {area:383}"] = "{area:383}",
	-- ["Thun'grim camps beside the road from the {area:380} to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "툰그림은 {area:380}에서 {area:392}(으)로 가는 길가에 야영하고 있습니다. {object:58369}은(는) 그 바로 북쪽, 서슬갈기일족 야영지 남쪽에 있습니다.",
	-- ["Walk back south to the {area:380}. The next guide starts here and takes you to {zone:1454} and the zeppelin to {zone:1420}."] = "남쪽의 {area:380}(으)로 걸어서 돌아가세요. 다음 가이드는 여기서 시작해 {zone:1454}와(과) {zone:1420}행 비행선으로 안내합니다.",
	-- ["Walk back west along the road to the {area:380}."] = "길을 따라 서쪽의 {area:380}(으)로 돌아가세요.",
}
