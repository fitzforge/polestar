-- Korean (koKR): the guide forever/alliance/gnome/01-dun-morogh (forever/alliance/gnome/01-dun-morogh.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Sten Stoutarm
	-- {area:77} Anvilmar · {npc:658} Sten Stoutarm
	["You start in front of {area:77}, the stone hall at the north end of the valley. {npc:658} waits outside the door."] = "당신은 골짜기 북쪽 끝의 석조 전당인 {area:77} 앞에서 시작합니다. {npc:658}은(는) 문 밖에서 기다립니다.",

	-- Step 2: Young wolves
	["Young wolves"] = "새끼 늑대",
	-- {area:77} Anvilmar
	["Ragged Young Wolves roam the snow just south of {area:77}."] = "새끼 회색갈기늑대가 {area:77} 바로 남쪽 눈밭을 돌아다닙니다.",

	-- Step 3: Anvilmar
	-- {npc:713} Balir Frosthammer · {npc:658} Sten Stoutarm
	["{npc:713}, next to {npc:658}"] = "{npc:713}, {npc:658} 옆",
	-- {npc:912} Thran Khorman
	["{npc:912}, the warrior trainer"] = "{npc:912}, 전사 상급자",
	-- {npc:916} Solm Hargrin
	["{npc:916}, the rogue trainer"] = "{npc:916}, 도적 상급자",
	-- {npc:837} Branstock Khalder
	["{npc:837}, the priest trainer"] = "{npc:837}, 사제 상급자",
	-- {npc:944} Marryk Nurribit · {area:77} Anvilmar
	["{npc:944}, the mage trainer, inside {area:77}"] = "{npc:944}, 마법사 상급자, {area:77} 안",
	-- {npc:460} Alamar Grimm · {area:77} Anvilmar
	["{npc:460}, inside {area:77}"] = "{npc:460}, {area:77} 안",
	-- {area:77} Anvilmar
	["Inside {area:77}"] = "{area:77} 안",

	-- Step 4: The troggs
	["The troggs"] = "트로그",
	-- {area:77} Anvilmar
	-- plural, as words: Rockjaw Troggs = {npc:707} Rockjaw Trogg · Burly Rockjaw Troggs = {npc:724} Burly Rockjaw Trogg
	["Rockjaw Troggs and Burly Rockjaw Troggs dig all over the valley floor south of {area:77}."] = "바위턱트로그와 힘센 바위턱트로그가 {area:77} 남쪽 골짜기 바닥 곳곳에서 땅을 팝니다.",

	-- Step 5: Back to Anvilmar
	-- {area:77} Anvilmar
	["Back to {area:77}"] = "{area:77}(으)로 돌아가기",
	-- {npc:8416} Felix Whindlebolt · {area:77} Anvilmar
	["{npc:8416}, by the door of {area:77}; inside"] = "{npc:8416}, {area:77} 문 앞, 안",

	-- Step 6: Talin Keeneye
	-- {npc:714} Talin Keeneye · {item:10438} Felix's Box
	["{npc:714}'s camp is at the west end of the valley. {item:10438} lies in the snow south of it, his Chest by the troll cave and his Bucket of Bolts east of the cave: grab them as you pass."] = "{npc:714}의 야영지는 골짜기 서쪽 끝에 있습니다. {item:10438}은(는) 그 남쪽 눈밭에, 펠릭스의 궤짝은 트롤 동굴 옆에, 펠릭스의 나사통은 동굴 동쪽에 있습니다. 지나가면서 챙기세요.",

	-- Step 7: The boars
	["The boars"] = "멧돼지",
	-- {npc:714} Talin Keeneye
	-- plural, as words: Small Crag Boars = {npc:708} Small Crag Boar
	["Small Crag Boars graze around {npc:714}'s camp and along the west side of the valley."] = "작은 멧돼지가 {npc:714}의 야영지 주변과 골짜기 서쪽을 따라 풀을 뜯습니다.",

	-- Step 9: Grelin Whitebeard
	-- {npc:786} Grelin Whitebeard · {npc:12738} Nori Pridedrift
	["{npc:786} and {npc:12738} camp at the south-west edge of the valley, below the troll cave."] = "{npc:786}와(과) {npc:12738}은(는) 트롤 동굴 아래, 골짜기 남서쪽 가장자리에 진을 치고 있습니다.",

	-- Step 10: Coldridge Valley: kill these as you meet them
	-- {area:132} Coldridge Valley
	["{area:132}: kill these as you meet them"] = "{area:132}: 만나는 대로 처치하세요",
	-- {npc:786} Grelin Whitebeard
	-- plural, as words: Frostmane Troll Whelps = {npc:706} Frostmane Troll Whelp
	["Frostmane Troll Whelps fill the slopes south and east of {npc:786}'s camp."] = "{npc:706}은(는) {npc:786}의 야영지 남쪽과 동쪽 비탈에 가득합니다.",
	-- plural, as words: Feather Charms = {item:6753} Feather Charm · Frostmane Novices = {npc:946} Frostmane Novice
	["Feather Charms, from the Frostmane Novices"] = "깃털 부적, 서리갈기부족 견습마법사에게서",

	-- Step 11: Grelin Whitebeard
	-- {npc:12738} Nori Pridedrift · {npc:836} Durnan Furcutter · {area:77} Anvilmar
	["{npc:12738}: timed, five minutes to reach {npc:836} in {area:77}"] = "{npc:12738}: 시간 제한, 5분 안에 {area:77}의 {npc:836}에게 가야 합니다",

	-- Step 12: Anvilmar
	-- {npc:836} Durnan Furcutter · {area:77} Anvilmar
	["The Scalding Mornbrew lasts five minutes: go straight north to {npc:836} inside {area:77}."] = "두르난의 뜨거운 새벽주는 5분 동안 유지됩니다. 곧장 북쪽으로 {area:77} 안의 {npc:836}에게 가세요.",
	-- {npc:836} Durnan Furcutter · {area:77} Anvilmar
	["{npc:836}, inside {area:77}; below ground"] = "{npc:836}, {area:77} 안, 지하",
	["Level 4 spells"] = "4레벨 주문",
	-- {npc:8416} Felix Whindlebolt
	["{npc:8416}, at the door on the way out; inside"] = "{npc:8416}, 나가는 길의 문 앞, 안",
	["The troll cave"] = "트롤 동굴",

	-- Step 13: Grik'nir the Cold
	-- {npc:808} Grik'nir the Cold · {npc:786} Grelin Whitebeard
	["{npc:808} is inside the troll cave east of {npc:786}'s camp, not on the hill above it: go in at the mouth and follow the tunnel to the back."] = "{npc:808}은(는) {npc:786}의 야영지 동쪽 트롤 동굴 안에 있습니다. 그 위 언덕이 아닙니다. 입구로 들어가 굴을 따라 안쪽 끝까지 가세요.",
	-- {item:2004} Grelin Whitebeard's Journal
	["{item:2004}; below ground"] = "{item:2004}, 지하",

	-- Step 14: Grelin Whitebeard
	-- {npc:12738} Nori Pridedrift
	["{npc:12738}, next to him"] = "{npc:12738}, 그의 옆",

	-- Step 15: Grund and Gozwin
	-- {area:77} Anvilmar · {npc:2756} Grund Drokda · {npc:8416} Felix Whindlebolt · {npc:269075} Snow Leopard Prowler
	["Back north to {area:77} on the way to the tunnel: {npc:2756} stands by {npc:8416} at its door. Gozwin's camp is in the hills just north-west; the {npc:269075} (level 6) prowls around it."] = "터널로 가는 길에 북쪽 {area:77}으로 돌아가세요. {npc:2756}은(는) 문 앞에서 {npc:8416} 옆에 서 있습니다. 고즈윈의 야영지는 바로 북서쪽 언덕에 있으며, {npc:269075}(6레벨)이(가) 그 주변을 배회합니다.",
	-- {npc:2756} Grund Drokda
	["{npc:2756}, inside"] = "{npc:2756}, 내부",
	-- {item:277976} Gozwin's Mechanic's Log
	["{item:277976}, in the camp"] = "{item:277976}, 야영지 안",

	-- Step 16: Branstock Khalder
	-- {area:77} Anvilmar · {npc:786} Grelin Whitebeard · {npc:837} Branstock Khalder · {npc:1226} Maxan Anvol · {area:131} Kharanos
	["{area:77} is on the way north from {npc:786}'s camp to the tunnel: {npc:837}, the priest trainer inside, sends priests of level 5 to {npc:1226} in {area:131}."] = "{area:77}은(는) {npc:786}의 야영지에서 북쪽으로 굴까지 가는 길에 있습니다. 그 안의 사제 상급자 {npc:837}은(는) 5레벨 사제를 {area:131}의 {npc:1226}에게 보냅니다.",
	-- {npc:837} Branstock Khalder · {area:77} Anvilmar
	["{npc:837}, inside {area:77}"] = "{npc:837}, {area:77} 안",

	-- Step 17: The tunnel
	["The tunnel"] = "굴",
	-- {npc:1965} Mountaineer Thalos · {area:77} Anvilmar · {npc:6782} Hands Springsprocket
	["{npc:1965} guards the tunnel out of the valley, east of {area:77}; {npc:6782} stands beside him at its mouth."] = "{npc:1965}은(는) {area:77} 동쪽, 골짜기 밖으로 나가는 굴을 지킵니다. {npc:6782}은(는) 굴 입구에서 그 옆에 서 있습니다.",

	-- Step 18: The Great Outdoors
	-- {npc:1241} Tognus Flintfire · {skill:129} First Aid · {npc:2326} Thamner Pol · {area:131} Kharanos · {area:189} Steelgrill's Depot · {npc:1700} Paxton Ganter · {area:137} Brewnall Village · {zone:1455} Ironforge
	["Sit by Eric's campfire (type /sit) and wait for the buff. With a profession learned, Eric also offers its Camping 101, which its trainer takes: blacksmithing with {npc:1241} and {skill:129} with {npc:2326} in {area:131}, mining and engineering at {area:189}, fishing with {npc:1700} by {area:137}, herbalism, skinning, leatherworking and tailoring in {zone:1455}. In {zone:1455} the alchemy and enchanting trainers give their own."] = "에릭의 모닥불 옆에 앉아(/sit 입력) 효과를 기다리십시오. 전문 기술을 배웠다면 에릭은 해당 야영 101도 주며, 그 상급자가 받습니다: 대장기술은 {npc:1241}, {skill:129}은(는) {area:131}의 {npc:2326}, 채광과 기계공학은 {area:189}, 낚시는 {area:137} 옆의 {npc:1700}, 약초채집, 무두질, 가죽세공, 재봉술은 {zone:1455}. {zone:1455}에서는 연금술과 마법부여 상급자가 각자의 퀘스트를 줍니다.",

	-- Step 19: Camping 101: First Aid
	-- {npc:2326} Thamner Pol · {skill:129} First Aid
	["{npc:2326} takes it once your {skill:129} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "{skill:129} 숙련도가 20이 되면 {npc:2326}이(가) 받습니다. 그때까지 채집하거나 제작하십시오. 그동안 가이드는 계속 진행됩니다.",
	-- {npc:265813} Eric Brighthammer · {npc:2326} Thamner Pol · {area:2102} Thunderbrew Distillery
	["{npc:265813}: for {npc:2326} in the {area:2102}"] = "{npc:265813}: {area:2102}의 {npc:2326}에게 제출",

	-- Step 20: Camping 101: Mining
	-- {npc:5392} Yarr Hammerstone · {skill:186} Mining
	["{npc:5392} takes it once your {skill:186} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "{skill:186} 숙련도가 20이 되면 {npc:5392}이(가) 받습니다. 그때까지 채집하거나 제작하십시오. 그동안 가이드는 계속 진행됩니다.",
	-- {npc:265813} Eric Brighthammer · {npc:5392} Yarr Hammerstone · {area:189} Steelgrill's Depot
	["{npc:265813}: for {npc:5392} at {area:189}"] = "{npc:265813}: {area:189}의 {npc:5392}에게 제출",

	-- Step 21: Camping 101: Engineering
	-- {npc:1702} Bronk Guzzlegear · {skill:202} Engineering
	["{npc:1702} takes it once your {skill:202} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "{skill:202} 숙련도가 20이 되면 {npc:1702}이(가) 받습니다. 그때까지 채집하거나 제작하십시오. 그동안 가이드는 계속 진행됩니다.",
	-- {npc:265813} Eric Brighthammer · {npc:1702} Bronk Guzzlegear · {area:189} Steelgrill's Depot
	["{npc:265813}: for {npc:1702} at {area:189}"] = "{npc:265813}: {area:189}의 {npc:1702}에게 제출",

	-- Step 22: Camping 101: Herbalism
	-- {npc:5137} Reyna Stonebranch · {skill:182} Herbalism
	["{npc:5137} takes it once your {skill:182} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "{skill:182} 숙련도가 20이 되면 {npc:5137}이(가) 받습니다: 그때까지 채집하거나 제작하십시오. 그동안 가이드는 계속됩니다.",
	-- {npc:265813} Eric Brighthammer · {npc:5137} Reyna Stonebranch · {zone:1455} Ironforge
	["{npc:265813}: for {npc:5137} in {zone:1455}"] = "{npc:265813}: {zone:1455}의 {npc:5137}에게",

	-- Step 23: Camping 101: Skinning
	-- {npc:6291} Balthus Stoneflayer · {skill:393} Skinning
	["{npc:6291} takes it once your {skill:393} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "{skill:393} 숙련도가 20이 되면 {npc:6291}이(가) 받습니다: 그때까지 채집하거나 제작하십시오. 그동안 가이드는 계속됩니다.",
	-- {npc:265813} Eric Brighthammer · {npc:6291} Balthus Stoneflayer · {zone:1455} Ironforge
	["{npc:265813}: for {npc:6291} in {zone:1455}"] = "{npc:265813}: {zone:1455}의 {npc:6291}에게",

	-- Step 24: Camping 101: Leatherworking
	-- {npc:1466} Gretta Finespindle · {skill:165} Leatherworking
	["{npc:1466} takes it once your {skill:165} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "{skill:165} 숙련도가 20이 되면 {npc:1466}이(가) 받습니다: 그때까지 채집하거나 제작하십시오. 그동안 가이드는 계속됩니다.",
	-- {npc:265813} Eric Brighthammer · {npc:1466} Gretta Finespindle · {zone:1455} Ironforge
	["{npc:265813}: for {npc:1466} in {zone:1455}"] = "{npc:265813}: {zone:1455}의 {npc:1466}에게",

	-- Step 25: Camping 101: Tailoring
	-- {npc:1703} Uthrar Threx · {skill:197} Tailoring
	["{npc:1703} takes it once your {skill:197} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "{skill:197} 숙련도가 20이 되면 {npc:1703}이(가) 받습니다: 그때까지 채집하거나 제작하십시오. 그동안 가이드는 계속됩니다.",
	-- {npc:265813} Eric Brighthammer · {npc:1703} Uthrar Threx · {zone:1455} Ironforge
	["{npc:265813}: for {npc:1703} in {zone:1455}"] = "{npc:265813}: {zone:1455}의 {npc:1703}에게",

	-- Step 26: Camping 101: Fishing
	-- {npc:1700} Paxton Ganter · {skill:356} Fishing
	["{npc:1700} takes it once your {skill:356} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "{skill:356} 숙련도가 20이 되면 {npc:1700}이(가) 받습니다: 그때까지 채집하거나 제작하십시오. 그동안 가이드는 계속됩니다.",
	-- {npc:265813} Eric Brighthammer · {npc:1700} Paxton Ganter · {area:137} Brewnall Village
	["{npc:265813}: for {npc:1700} by {area:137}"] = "{npc:265813}: {area:137} 옆 {npc:1700}에게",

	-- Step 27: Kharanos
	-- {area:131} Kharanos · {npc:1252} Senir Whitebeard · {area:2102} Thunderbrew Distillery · {npc:1872} Tharek Blackstone · {npc:6806} Tannok Frosthammer · {npc:1226} Maxan Anvol · {npc:1267} Ragnar Thunderbrew · {npc:1699} Gremlock Pilsnor · {skill:185} Cooking
	["Follow the road through the tunnel and north-east to {area:131}. Start outside: {npc:1252} and Eric's campfire are in front of the {area:2102}.\n{npc:1872} works the forge west of the distillery.\nThen go in: {npc:6806}, the innkeeper, {npc:1226} and {npc:1267}. {npc:1699}'s {skill:185} lesson waits for the return with the ribs, when the copper is there for it."] = "터널을 지나 길을 따라 북동쪽 {area:131}(으)로 가세요. 밖에서 시작합니다: {npc:1252}과(와) 에릭의 모닥불이 {area:2102} 앞에 있습니다.\n{npc:1872}은(는) 증류장 서쪽의 대장간에서 일합니다.\n그런 다음 안으로 들어가세요: {npc:6806} 여관주인, {npc:1226}, {npc:1267}이(가) 있습니다. {npc:1699}의 {skill:185} 수업은 구리가 준비되면 갈비뼈를 갖고 돌아와서 받으세요.",
	-- {npc:1241} Tognus Flintfire
	["{npc:1241}, below ground"] = "{npc:1241}, 지하",
	-- {npc:6806} Tannok Frosthammer
	["{npc:6806}, inside"] = "{npc:6806}, 내부",
	-- {npc:1226} Maxan Anvol
	["{npc:1226}, upstairs"] = "{npc:1226}, 위층",
	-- {npc:1226} Maxan Anvol · {npc:12427} Mountaineer Dolf · {area:131} Kharanos
	["{npc:1226}: heal {npc:12427} south of {area:131}"] = "{npc:1226}: {area:131} 남쪽의 {npc:12427} 치유",
	["Last: some classes' trainers stand outside"] = "마지막: 일부 직업의 상급자는 밖에 서 있습니다",

	-- Step 28: Camping 101: Blacksmithing
	-- {npc:1241} Tognus Flintfire · {skill:164} Blacksmithing
	["{npc:1241} takes it once your {skill:164} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "{skill:164} 숙련도가 20이 되면 {npc:1241}이(가) 받습니다. 그때까지 채집하거나 제작하십시오. 그동안 가이드는 계속 진행됩니다.",
	-- {npc:265813} Eric Brighthammer · {npc:1241} Tognus Flintfire
	["{npc:265813}: for {npc:1241}, in the cellar west of the distillery"] = "{npc:265813}: 양조장 서쪽 지하실의 {npc:1241}에게 제출",

	-- Step 29: Thamner Pol
	["talk to the trainer"] = "전문 기술자에게 말 걸기",
	-- {npc:2326} Thamner Pol
	["{npc:2326}, inside the distillery"] = "{npc:2326}, 양조장 안",

	-- Step 30: Tognus Flintfire
	-- {npc:1241} Tognus Flintfire
	["{npc:1241}, in the cellar west of the distillery"] = "{npc:1241}, 양조장 서쪽 지하실",

	-- Step 31: Steelgrill's Depot
	-- {area:131} Kharanos · {zone:1455} Ironforge
	["Follow the road north-east from {area:131} to the depot below the {zone:1455} road."] = "{area:131}에서 길을 따라 북동쪽으로 {zone:1455} 길 아래의 정거장까지 가세요.",
	-- {npc:1694} Loslor Rudge
	["{npc:1694}, beside him"] = "{npc:1694}, 그의 옆",

	-- Step 32: Yarr Hammerstone
	-- {npc:5392} Yarr Hammerstone
	["{npc:5392}, at the depot"] = "{npc:5392}, 정거장에서",

	-- Step 33: Bronk Guzzlegear
	-- {npc:1702} Bronk Guzzlegear · {npc:5392} Yarr Hammerstone
	["{npc:1702}, beside {npc:5392}"] = "{npc:1702}, {npc:5392} 옆",

	-- Step 34: Rumbleshot's Ammo
	-- {object:176785} Ammo Crate · {npc:271546} Mountaineer Gretchen · {area:136} Grizzled Den
	["The {object:176785} sits next to {npc:271546}, south of the {area:136}."] = "{object:176785}은(는) {area:136} 남쪽, {npc:271546} 옆에 있습니다.",
	-- {item:13850} Rumbleshot's Ammo · {object:176785} Ammo Crate
	["{item:13850}: the {object:176785}"] = "{item:13850}: {object:176785}",

	-- Step 35: Mountaineer Gretchen
	-- {area:136} Grizzled Den · {area:131} Kharanos · {area:137} Brewnall Village
	-- plural, as words: Elder Wendigos = {npc:271530} Elder Wendigo
	["Gretchen camps just outside the {area:136}, the wendigo cave south-west of {area:131}. The den comes after {area:137}, once its level 8 Elder Wendigos and Shamans are no longer above you."] = "그레첸은 {area:131} 남서쪽의 웬디고 동굴인 {area:136} 바로 밖에 야영하고 있습니다. 이 동굴은 {area:137} 다음에, 8레벨 장로 웬디고와 주술사가 더 이상 레벨이 높지 않을 때 가세요.",

	-- Step 36: Rumbleshot's Ammo
	-- {npc:1243} Hegnar Rumbleshot
	["{npc:1243} camps south-west of it, by the road to Coldridge."] = "{npc:1243}은(는) 그것 남서쪽, 콜드리지로 가는 길가에 진을 칩니다.",

	-- Step 37: Dun Morogh: kill these as you meet them
	-- {zone:1426} Dun Morogh
	["{zone:1426}: kill these as you meet them"] = "{zone:1426}: 만나는 대로 처치하십시오",
	-- {area:131} Kharanos
	-- plural, as words: Crag Boars = {npc:1125} Crag Boar · Young Black Bears = {npc:1128} Young Black Bear
	["Crag Boars and Young Black Bears roam the fields from Rumbleshot's camp north-east to {area:131} and the depot: kill them on the walk back."] = "멧돼지와 새끼 흑곰이 럼블샷의 야영지에서 북동쪽 {area:131}와(과) 정거장까지 들판을 돌아다닙니다. 돌아오는 길에 처치하세요.",

	-- Step 38: Mountaineer Dolf
	-- {npc:12427} Mountaineer Dolf · {area:131} Kharanos · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12427} kneels wounded on the ridge between two low walls just south of {area:131}, across the road from the hunter pet trainer, on the walk back from Rumbleshot's camp. Cast {spell:613} (Rank 2) on him, then {spell:1243}: Rank 1 of {spell:613} does not count."] = "{npc:12427}은(는) {area:131} 바로 남쪽, 낮은 두 담 사이 능선에 부상당한 채 무릎을 꿇고 있습니다. 사냥꾼 야수 조련사 맞은편 길 건너이며, 럼블샷의 야영지에서 돌아오는 길에 있습니다. 그에게 {spell:613}(2레벨)을 시전한 뒤 {spell:1243}을(를) 시전하세요. {spell:613} 1레벨은 인정되지 않습니다.",
	-- {npc:12427} Mountaineer Dolf
	["Heal and fortify {npc:12427}"] = "{npc:12427} 치유 및 인내",

	-- Step 39: Thunderbrew Distillery
	-- {npc:1267} Ragnar Thunderbrew · {npc:1699} Gremlock Pilsnor · {skill:185} Cooking
	-- plural, as words: Crag Boars = {npc:1125} Crag Boar
	["Kill the Crag Boars on the way: their ribs drop before you have {npc:1267}'s quest and count toward it. Back in the distillery: {npc:1699} teaches {skill:185}, then the ribs go to {npc:1267}."] = "가는 길에 바위발굽멧돼지를 처치하세요: 갈비뼈는 {npc:1267}의 퀘스트를 받기 전에 떨어지며 그 퀘스트에 포함됩니다. 증류장으로 돌아가면 {npc:1699}이(가) {skill:185}을(를) 가르치고, 갈비뼈는 {npc:1267}에게 가져갑니다.",
	-- {item:2894} Rhapsody Malt · {npc:1247} Innkeeper Belm
	["{item:2894}, from {npc:1247}; upstairs"] = "{item:2894}, {npc:1247}에게서, 위층",
	-- {npc:1699} Gremlock Pilsnor
	["{npc:1699}: Camping 101 asks you to learn it; below ground"] = "{npc:1699}: 야영 101을 배우게 합니다, 지하",
	-- {npc:1226} Maxan Anvol · {item:16605} Friar's Robes of the Light
	["{npc:1226}, upstairs: {item:16605}"] = "{npc:1226}, 위층: {item:16605}",
	["Upstairs"] = "위층",

	-- Step 40: Kharanos and the depot
	-- {area:131} Kharanos
	["{area:131} and the depot"] = "{area:131}와(과) 정거장",
	-- {npc:1269} Razzle Sprysprocket · {area:131} Kharanos
	["The pilots stand at the depot; {npc:1269} is on the road back west, north of {area:131}."] = "비행 조종사들은 정거장에 서 있습니다; {npc:1269}은(는) {area:131} 북쪽, 서쪽으로 돌아가는 길에 있습니다.",
	-- {npc:1269} Razzle Sprysprocket
	["{npc:1269}, on the way back; below ground"] = "{npc:1269}, 돌아가는 길, 지하",

	-- Step 41: Brewnall Village
	-- {area:137} Brewnall Village · {area:131} Kharanos · {npc:8508} Gretta Ganter · {npc:1374} Rejold Barleybrew · {npc:1375} Marleth Barleybrew
	["{area:137} sits on the lake west of {area:131}. {npc:8508}'s dock is the first stop; {npc:1374} and {npc:1375} are in the village beyond it."] = "{area:137}은(는) {area:131} 서쪽 호수 위에 있습니다. {npc:8508}의 부두가 첫 번째 들름새이고, {npc:1374}와(과) {npc:1375}은(는) 그 너머 마을에 있습니다.",
	-- {npc:8508} Gretta Ganter
	["{npc:8508}, on the dock"] = "부두의 {npc:8508}",

	-- Step 42: Brewnall: kill these as you meet them
	["Brewnall: kill these as you meet them"] = "브루날: 마주치는 대로 처치하세요",
	-- {area:137} Brewnall Village
	-- plural, as words: Ice Claw Bears = {npc:1196} Ice Claw Bear · Elder Crag Boars = {npc:1127} Elder Crag Boar · Snow Leopards = {npc:1201} Snow Leopard
	["Ice Claw Bears, Elder Crag Boars and Snow Leopards roam the hills around the lake and {area:137}."] = "얼음발톱흰곰, 덩치큰 멧돼지, 눈표범이 호수와 {area:137} 주변 언덕을 돌아다닙니다.",

	-- Step 44: Grizzled Den
	-- {area:136} Grizzled Den · {area:131} Kharanos · {npc:271546} Mountaineer Gretchen · {npc:278166} Mountaineer Cornelius · {quest:98326} Frosthowl · {item:280426} Sack of Fish
	-- plural, as words: Elder Wendigos = {npc:271530} Elder Wendigo · Wendigo Shamans = {npc:271486} Wendigo Shaman
	["Back to the {area:136}, the wendigo cave south-west of {area:131} where {npc:271546} camps. Flintfire's shipments lie on the cave floor, {npc:278166} is missing deep inside, and {quest:98326} (level 9) keeps the {item:280426} at the back.\nCareful: Wendigos, Elder Wendigos and Wendigo Shamans (up to level 8) stand close together inside the cave, so fights easily pull several at once; drawing them out one at a time with ranged attacks avoids this."] = "{npc:271546}이(가) 야영하는, {area:131} 남서쪽의 웬디고 동굴 {area:136}(으)로 돌아가세요. 플린트파이어의 화물은 동굴 바닥에 있고, {npc:278166}은(는) 동굴 깊숙한 곳에서 실종되었으며, {quest:98326}(9레벨)이(가) 안쪽 끝에서 {item:280426}을(를) 지키고 있습니다.\n주의: 동굴 안에는 웬디고, 장로 웬디고, 웬디고 주술사(최대 8레벨)가 붙어 있어 여러 마리가 한꺼번에 끌려오기 쉽습니다. 원거리 공격으로 한 마리씩 끌어내면 피할 수 있습니다.",
	-- {item:280426} Sack of Fish · {quest:98326} Frosthowl
	["{item:280426}: {quest:98326}, at the back"] = "{item:280426}: 안쪽 끝의 {quest:98326}",

	-- Step 46: Kharanos
	-- {npc:1252} Senir Whitebeard · {area:2102} Thunderbrew Distillery · {npc:1241} Tognus Flintfire · {npc:1373} Jarven Thunderbrew · {item:2686} Thunder Ale · {npc:1247} Innkeeper Belm · {spell:8553} Barleybrew Scalder
	["{npc:1252} stands by Eric's campfire in front of the {area:2102}; {npc:1241} is in the cellar west of it. {npc:1373} guards the {item:2686} barrels in the distillery basement. Buy a {item:2686} from {npc:1247}, click the guarded barrel, then hand the ale to {npc:1373} from his quest window (there is no quest to accept); after that, the unguarded barrel takes the {spell:8553}."] = "{npc:1252}은(는) {area:2102} 앞 에릭의 모닥불 옆에 서 있고, {npc:1241}은(는) 그 서쪽 지하실에 있습니다. {npc:1373}은(는) 양조장 지하에서 {item:2686} 통을 지키고 있습니다. {npc:1247}에게서 {item:2686}을(를) 사서 지켜지는 통을 클릭한 뒤, {npc:1373}의 퀘스트 창에서 맥주를 건네세요(수락할 퀘스트는 없습니다). 그 후에는 지키는 이 없는 통에 {spell:8553}을(를) 넣을 수 있습니다.",
	-- {item:2686} Thunder Ale · {npc:1247} Innkeeper Belm
	["{item:2686}, from {npc:1247} in the distillery; upstairs"] = "{item:2686}, 증류장의 {npc:1247}에게서, 위층",
	-- {object:269} Guarded Thunder Ale Barrel
	["The {object:269} in the basement"] = "지하실의 {object:269}",
	-- {npc:1373} Jarven Thunderbrew
	["{npc:1373}, beside the barrel; below ground"] = "{npc:1373}, 통 옆, 지하",
	-- {object:270} Unguarded Thunder Ale Barrel
	["The {object:270} in the distillery; below ground"] = "증류장의 {object:270}, 지하",

	-- Step 47: Shimmerweed
	-- {item:2676} Shimmerweed · {area:802} Shimmer Ridge · {area:131} Kharanos
	-- plural, as words: Frostmane Seers = {npc:1397} Frostmane Seer
	["The {item:2676} grows in baskets up on {area:802}, the snowy slope north of the road between {area:131} and Brewnall: climb from the road west of {area:131}. The Frostmane Seers camped on the ridge drop it too."] = "{item:2676}은(는) {area:131}과(와) 브루눌 사이 길 북쪽의 눈 덮인 비탈 {area:802} 위쪽 바구니에서 자랍니다: {area:131} 서쪽 길에서 오르세요. 능선에 진을 친 서리갈기부족 예언자도 이것을 떨어뜨립니다.",

	-- Step 50: The Gnomeregan road
	-- {area:133} Gnomeregan
	["The {area:133} road"] = "{area:133} 길",
	-- {area:133} Gnomeregan · {area:137} Brewnall Village · {area:135} Frostmane Hold
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome
	["Leper Gnomes wander the {area:133} road north of {area:137} and carry the cogs and gears. {area:135} comes next, in the hills south-west of the village.\nCareful: the Leper Gnomes (8-10) walk the road in twos and threes, and many players died here: pull them one at a time."] = "오염된 노움은 {area:137} 북쪽 {area:133} 길을 돌아다니며 톱니와 기어를 지니고 있습니다. 다음은 마을 남서쪽 언덕의 {area:135}입니다.\n주의: 오염된 노움(8-10)은 두세 마리씩 길을 다니며 많은 플레이어가 여기서 죽었습니다. 한 마리씩 끌어오세요.",
	-- {item:3083} Restabilization Cog
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome
	["{item:3083}: Leper Gnomes"] = "{item:3083}: 오염된 노움",
	-- {item:3084} Gyromechanic Gear
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome
	["{item:3084}: Leper Gnomes"] = "{item:3084}: 오염된 노움",

	-- Step 51: Frostmane Hold
	-- {area:135} Frostmane Hold · {area:137} Brewnall Village
	-- plural, as words: Frostmane Hideskinners = {npc:1122} Frostmane Hideskinner
	-- was: ["{area:135} is the troll cave in the hills south-west of {area:137}. Kill Headhunters at its mouth and walk through to its far end.\nCareful: the Frostmane Hideskinners inside the Hold are level 9-10 and stand in pairs: pull them one at a time back to the mouth."] = "{area:135}은(는) {area:137} 남서쪽 언덕의 트롤 동굴입니다. 입구의 머리사냥꾼을 처치하고 가장 안쪽 끝까지 걸어가세요.\n주의: 소굴 안의 서리갈기부족 무두장이는 9-10레벨이고 둘씩 서 있습니다. 한 마리씩 입구로 끌어오세요."
	["{area:135} is the troll cave in the hills south-west of {area:137}. Kill Headhunters at its mouth, then walk through the cave to its far end: Fully explore {area:135} ticks only in there, not on the hill above it.\nCareful: the Frostmane Hideskinners inside the Hold are level 9-10 and stand in pairs: pull them one at a time back to the mouth."] = "",
	-- {npc:1123} Frostmane Headhunter
	["{npc:1123}, below ground"] = "{npc:1123}, 지하",

	-- Step 52: Tundra MacGrann
	-- {npc:1266} Tundra MacGrann · {area:801} Chill Breeze Valley · {area:131} Kharanos · {npc:1271} Old Icebeard
	["{npc:1266} camps in {area:801}, south of the road back east from Brewnall to {area:131}. His meats are in the locker in {npc:1271}'s cave, east of his camp. {npc:1271} is an elite yeti: wait out of sight until he wanders off on his patrol, then take the meats and leave before he comes back. You don't need to fight him."] = "{npc:1266}은(는) 브루눌에서 {area:131}로 돌아오는 동쪽 길 남쪽의 {area:801}에 진을 칩니다. 그의 고기는 야영지 동쪽 {npc:1271}의 동굴 안 보관함에 있습니다. {npc:1271}은(는) 정예 설인입니다: 그가 순찰을 돌아다니는 동안 보이지 않는 곳에서 기다렸다가 고기를 챙기고 그가 돌아오기 전에 나가세요. 싸울 필요는 없습니다.",
	-- {item:2667} MacGrann's Dried Meats
	["{item:2667}: the meat locker; below ground"] = "{item:2667}: 고기 보관함, 지하",

	-- Step 53: Kharanos
	-- {area:131} Kharanos · {npc:1252} Senir Whitebeard · {quest:287} Frostmane Hold · {npc:1269} Razzle Sprysprocket
	-- plural, as words: Ice Claw Bears = {npc:1196} Ice Claw Bear · Snow Leopards = {npc:1201} Snow Leopard · Large Crag Boars = {npc:1126} Large Crag Boar
	["Back east through {area:131}: {npc:1252} by Eric's campfire takes the {quest:287} report, and {npc:1269} the cogs and gears. The Shaman quest here waits for level 10: a Shaman still short of it finishes on the Ice Claw Bears (7-8), Snow Leopards and Large Crag Boars in the fields just south of {area:131}."] = "{area:131}을(를) 지나 동쪽으로 돌아가세요. 에릭의 모닥불 옆 {npc:1252}에게 {quest:287} 보고를, {npc:1269}에게 톱니와 기어를 제출합니다. 이곳의 주술사 퀘스트는 10레벨이 필요합니다. 아직 모자라는 주술사는 {area:131} 바로 남쪽 들판의 얼음발톱흰곰(7-8), 눈표범, 큰 멧돼지를 잡아 채우세요.",
	-- {npc:1252} Senir Whitebeard · {npc:1274} Senator Barin Redstone · {zone:1455} Ironforge
	["{npc:1252}: {npc:1274} in {zone:1455} takes it"] = "{npc:1252}: {zone:1455}의 {npc:1274}이(가) 받습니다",
	-- {npc:1269} Razzle Sprysprocket
	["{npc:1269}, below ground"] = "{npc:1269}, 지하",
	-- {npc:258113} Ingrid Dunwald · {npc:257597} Bruegs Kindleborn
	["{npc:258113}: {npc:257597} by the South Gate takes it"] = "{npc:258113}: 남문 옆 {npc:257597}에게 제출합니다",

	-- Step 54: Steelgrill's Depot
	-- {area:131} Kharanos · {zone:1426} Dun Morogh
	["Follow the road north-east from {area:131} to the depot: the whole east of {zone:1426} is one sweep from here."] = "{area:131}에서 길을 따라 북동쪽 정거장까지 가세요: 여기서 {zone:1426} 동부 전체를 한 바퀴 돌 수 있습니다.",
	-- {npc:1377} Pilot Stonegear
	["{npc:1377}, beside him"] = "{npc:1377}, 그의 옆",

	-- Step 55: Misty Pine Refuge
	-- {area:138} Misty Pine Refuge
	["Follow the road east past the depot to {area:138}."] = "길을 따라 동쪽으로 정거장을 지나 {area:138}까지 가세요.",

	-- Step 56: Firewood
	["Firewood"] = "장작",
	["The firewood lies in the snow around the frozen lake by the refuge."] = "장작은 피난처 옆 얼어붙은 호수 주변 눈밭에 있습니다.",

	-- Step 58: Minor Ice Elemental on the way
	-- {npc:276003} Minor Ice Elemental
	["{npc:276003} on the way"] = "{npc:276003}, 가는 길에",
	-- {npc:276003} Minor Ice Elemental · {npc:1253} Father Gavin
	["{npc:276003} along the way to {npc:1253}"] = "{npc:276003}, {npc:1253}에게 가는 길에",

	-- Step 59: Misty Pine Refuge: kill these as you meet them
	-- {area:138} Misty Pine Refuge
	["{area:138}: kill these as you meet them"] = "{area:138}: 만나는 대로 처치하세요",
	-- {quest:99160} Rime's Wrath
	-- plural, as words: Minor Ice Elementals = {npc:276003} Minor Ice Elemental
	["The three rifles lie in the snow around the frozen lake by the refuge. Minor Ice Elementals drift around the lake and along the way: kill them as you go for {quest:99160}.\nFinish off the Minor Ice Elementals around the small lake just west of the refuge if you are still short."] = "소총 세 자루는 야영지 옆 얼어붙은 호수 주변 눈 속에 놓여 있습니다. 하급 얼음 정령이 호수 주변과 길을 따라 떠다닙니다: {quest:99160}을(를) 위해 가는 길에 처치하세요.\n모자라면 야영지 바로 서쪽 작은 호수 주변의 하급 얼음 정령을 마저 처치하십시오.",
	-- {npc:276003} Minor Ice Elemental
	["{npc:276003}, around the small lake"] = "{npc:276003}, 작은 호수 주변",

	-- Step 61: Avala's Core
	-- {item:286325} Avala's Core
	["{item:286325} is by the frozen lake, among the ice elementals."] = "{item:286325}은(는) 얼어붙은 호수 옆, 얼음 정령들 사이에 있습니다.",

	-- Step 66: Earthseer Farsen
	-- {area:134} Gol'Bolar Quarry
	["Farsen camps on the ridge overlooking the {area:134} from the west. Talk to him for his farsight."] = "파르센은 서쪽에서 {area:134}을(를) 내려다보는 능선에 진을 치고 있습니다. 그에게 말을 걸어 원시를 받으세요.",

	-- Step 69: Gol'Bolar Quarry
	["The quarry lies just east of Farsen's ridge."] = "채석장은 파르센 능선 바로 동쪽에 있습니다.",
	-- {npc:1977} Senator Mehr Stonehallow
	["{npc:1977}, in the quarry"] = "{npc:1977}, 채석장 안",
	-- {npc:1698} Frast Dokner
	["{npc:1698}: blacksmiths only"] = "{npc:1698}: 대장장이만",

	-- Step 70: The quarry troggs
	["The quarry troggs"] = "채석장 트로그",
	-- {item:268548} Empty Powder Keg
	-- plural, as words: Rockjaw Skullthumpers = {npc:1115} Rockjaw Skullthumper
	["Rockjaw Skullthumpers, Bonesnappers and Ambushers share the quarry and the slopes north of it; the Ambushers drop the {item:268548}."] = "바위턱일족 망치잡이, 바위턱일족 뼈다귀싸움꾼, 바위턱일족 잠복꾼이 채석장과 그 북쪽 비탈에 함께 있으며, 잠복꾼이 {item:268548}을(를) 떨어뜨립니다.",

	-- Step 73: Helm's Bed Lake
	-- {area:212} Helm's Bed Lake · {quest:95214} Stolen Blasting Powder · {item:274268} Dark Iron Map
	-- plural, as words: Rockjaw Ambushers = {npc:1116} Rockjaw Ambusher · Rockjaw Backbreakers = {npc:1118} Rockjaw Backbreaker
	["Rockjaw Ambushers by {area:212}, north of the quarry, and Rockjaw Backbreakers further east drop the {quest:95214}. Dark Iron Spies sneak around the lake shore east of the quarry; one of them drops the {item:274268}."] = "{area:212} 옆, 채석장 북쪽의 바위턱일족 잠복꾼과 더 동쪽의 바위턱일족 투사가 {quest:95214}을(를) 떨어뜨립니다. 검은무쇠 첩자가 채석장 동쪽 호숫가를 맴돌고, 그중 하나가 {item:274268}을(를) 떨어뜨립니다.",

	-- Step 74: Dun Morogh: kill these as you meet them
	-- {item:2770} Copper Ore
	-- plural, as words: Snow Leopards = {npc:1201} Snow Leopard · Copper Bars = {item:2840} Copper Bar
	["Snow Leopards and boars roam the snow between the ranch and the quarry. Blacksmiths: Copper Bars come from smelting {item:2770} or the trade vendors."] = "눈표범과 멧돼지가 농장과 채석장 사이 눈밭을 돌아다닙니다. 대장장이: 구리 주괴는 {item:2770}을(를) 제련하거나 직업용품 상인에게서 구합니다.",

	-- Step 77: Protecting the Herd
	-- {npc:1388} Vagash · {area:38} Loch Modan
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:1388} is a level 12 elite: take him on with a group. Alone, skip it: the {area:38} quests ahead make up the experience."] = "정예 몹입니다. 파티를 권장하니 사람을 구해 함께 하세요. {npc:1388}은(는) 12레벨 정예이니 파티로 상대하세요. 혼자라면 건너뛰세요. 다음 {area:38} 퀘스트들이 경험치를 채워 줍니다.",
	["Below ground"] = "지하",

	-- Step 78: Rudra Amberstill
	-- {zone:1455} Ironforge
	["On the road back west to {zone:1455}."] = "{zone:1455}(으)로 서쪽으로 돌아가는 길에.",

	-- Step 81: North Gate Outpost
	-- {area:808} North Gate Outpost · {npc:1960} Pilot Hammerfoot · {area:38} Loch Modan
	["Follow the road east and take its northern fork to the {area:808}: {npc:1960} waits there, and the dwarven corpse lies up the pass to the west of him. The South Gate and its tunnel into {area:38} come next, down the road to the south."] = "길을 따라 동쪽으로 가다 북쪽 갈림길로 {area:808}에 가십시오: {npc:1960}이(가) 그곳에서 기다리고, 드워프 시체는 그의 서쪽 고갯길 위에 있습니다. 남쪽 관문과 {area:38}(으)로 가는 터널은 그다음, 남쪽 길 아래에 있습니다.",

	-- Step 82: South Gate Outpost
	-- {area:806} South Gate Outpost · {area:38} Loch Modan
	["Back south down the road to the {area:806} at the {area:38} tunnel."] = "길을 따라 남쪽 {area:38} 터널의 {area:806}(으)로 돌아가십시오.",

	-- Step 83: Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn · {area:806} South Gate Outpost
	["{npc:257597} waits in a cave above the farm north-west of the {area:806}; the path up starts behind the farm."] = "{npc:257597}은(는) {area:806} 북서쪽 농장 위의 동굴에서 기다립니다. 올라가는 길은 농장 뒤에서 시작합니다.",

	-- Step 85: Braldir Ashmantle
	-- {area:38} Loch Modan · {npc:257808} Braldir Ashmantle
	["Go through the tunnel into {area:38}. Just past it, a path marked by stones climbs the hills on the right of the road north to {npc:257808}'s camp."] = "터널을 지나 {area:38}으로 들어가세요. 지나자마자 돌로 표시된 길이 도로 오른쪽 언덕을 올라 {npc:257808}의 야영지로 이어집니다.",

	-- Step 86: The tunnel post
	["The tunnel post"] = "터널 초소",
	-- {area:38} Loch Modan · {npc:1089} Mountaineer Cobbleflint · {npc:1092} Captain Rugelfuss
	["East through the South Gate tunnel into {area:38}. {npc:1089} and {npc:1092} stand at the dwarven post just past it."] = "남문 터널을 지나 동쪽으로 {area:38}에 들어가세요. {npc:1089}과(와) {npc:1092}은(는) 터널 바로 너머 드워프 초소에 있습니다.",

	-- Step 87: Stonesplinter troggs
	["Stonesplinter troggs"] = "가루바위일족 트로그",
	-- plural, as words: Stonesplinter Scouts = {npc:1162} Stonesplinter Scout
	["North of the post, west of the road: the Stonesplinter troggs and scouts camp in the hills. Both drop the Trogg Stone Teeth.\nCareful: pull the Stonesplinter Scouts and Troggs one at a time. Stay at the north edge of the valley; Headsplitter patrols the deeper camps."] = "초소 북쪽, 도로 서쪽: 돌조각 트로그와 정찰병이 언덕에 야영합니다. 둘 다 트로그 이빨을 떨어뜨립니다.\n주의: 돌조각 정찰병과 트로그를 하나씩 끌어오세요. 계곡 북쪽 가장자리에 머무르세요. 머리갈라치기는 더 안쪽 야영지를 순찰합니다.",

	-- Step 88: Back to the tunnel post
	["Back to the tunnel post"] = "터널 초소로 돌아가기",

	-- Step 89: Thelsamar
	-- {area:144} Thelsamar · {npc:1340} Mountaineer Kadrell · {npc:1963} Vidra Hearthstove · {area:2101} Stoutlager Inn · {npc:1681} Brock Stoneseeker · {npc:1572} Thorgrum Borrelson
	["North up the road to {area:144}. {npc:1340} walks the road through town, {npc:1963} stands outside the {area:2101}, {npc:1681} on the east side of town; {npc:1572} keeps the gryphons."] = "도로를 따라 북쪽 {area:144}(으)로 가세요. {npc:1340}은(는) 마을을 관통하는 길을 걷고, {npc:1963}은(는) {area:2101} 밖에 서 있으며, {npc:1681}은(는) 마을 동쪽에 있습니다; {npc:1572}은(는) 그리폰을 돌봅니다.",
	-- {npc:1572} Thorgrum Borrelson
	["{npc:1572}, the gryphon master"] = "{npc:1572}, 그리폰 조련사",
	-- {npc:1572} Thorgrum Borrelson · {npc:4256} Golnir Bouldertoe · {zone:1455} Ironforge
	["{npc:1572}: for {npc:4256} in {zone:1455}"] = "{npc:1572}: {zone:1455}의 {npc:4256}에게",

	-- Step 90: The west hills and the Algaz Station
	-- {area:925} Algaz Station
	["The west hills and the {area:925}"] = "서쪽 언덕과 {area:925}",
	-- {npc:1343} Mountaineer Stormpike · {area:925} Algaz Station
	-- plural, as words: Elder Black Bears = {npc:1186} Elder Black Bear · Mountain Boars = {npc:1190} Mountain Boar · Forest Lurkers = {npc:1195} Forest Lurker
	["North through the hills west of the road to {npc:1343} at the {area:925}. The Tunnel Rat kobolds dig in the hills on the way; Elder Black Bears, Mountain Boars and Forest Lurkers roam the same ground."] = "도로 서쪽 언덕을 통해 북쪽으로 {area:925}의 {npc:1343}에게 가세요. 터널 쥐 코볼트가 가는 길 언덕에서 땅을 파고, 덩치큰 흑곰, 산돼지, 숲늑대거미가 같은 땅을 배회합니다.",
	-- {item:3110} Tunnel Rat Ear
	["{item:3110}: Tunnel Rat kobolds"] = "{item:3110}: 터널 쥐 코볼트",
	-- {item:3172} Boar Intestines
	-- plural, as words: Mountain Boars = {npc:1190} Mountain Boar
	["{item:3172}: Mountain Boars"] = "{item:3172}: 산돼지",
	-- {item:3173} Bear Meat
	-- plural, as words: Elder Black Bears = {npc:1186} Elder Black Bear
	["{item:3173}: Elder Black Bears"] = "{item:3173}: 덩치큰 흑곰",
	-- {item:3174} Spider Ichor
	-- plural, as words: Forest Lurkers = {npc:1195} Forest Lurker
	["{item:3174}: Forest Lurkers"] = "{item:3174}: 숲늑대거미",
	-- {npc:5413} Furen Longbeard · {zone:1453} Stormwind
	["{npc:5413} in {zone:1453} takes it"] = "{zone:1453}의 {npc:5413}에게 제출합니다",

	-- Step 91: Silver Stream Mine
	-- {item:5026} Fire Tar
	-- plural, as words: Tunnel Rat Geomancers = {npc:1174} Tunnel Rat Geomancer
	["East along the hills to the mine at the north end of the loch: the Miners' League crates sit in its tunnels, among more Tunnel Rats. Shamans: the Tunnel Rat Geomancers (level 12-13) here carry the {item:5026}.\nCareful: the Tunnel Rat Geomancers (12-13) cast from range in the narrow tunnels: pull them one at a time."] = "언덕을 따라 동쪽으로 호수 북쪽 끝의 광산으로 가세요. 광부 연맹 상자들이 굴 안 동굴쥐일족 사이에 있습니다. 주술사: 이곳의 동굴쥐일족 흙점쟁이(12-13레벨)가 {item:5026}을(를) 지니고 있습니다.\n주의: 동굴쥐일족 흙점쟁이(12-13)는 좁은 굴에서 원거리 주문을 시전합니다. 한 마리씩 끌어오세요.",
	-- {item:2640} Miners' Gear
	["{item:2640}, from the crates"] = "{item:2640}, 상자에서",
	-- {item:5026} Fire Tar
	-- plural, as words: Tunnel Rat Geomancers = {npc:1174} Tunnel Rat Geomancer
	["{item:5026}: Tunnel Rat Geomancers"] = "{item:5026}: 동굴쥐일족 흙점쟁이",

	-- Step 92: Back to the Algaz Station
	-- {area:925} Algaz Station
	["Back to the {area:925}"] = "{area:925}로 돌아가기",

	-- Step 93: Thelsamar
	-- {area:144} Thelsamar · {npc:1340} Mountaineer Kadrell
	["South down the road to {area:144}, finishing the ears, meat and ichor on the way. {npc:1340} walks the road through town."] = "길을 따라 남쪽으로 {area:144}까지 내려가면서 귀, 고기, 체액을 마저 모으세요. {npc:1340}은(는) 마을을 지나는 길을 걸어 다닙니다.",

	-- Step 94: The Reagent Pouch
	-- {item:6652} Reagent Pouch
	["The {item:6652}"] = "{item:6652}",
	-- {area:923} Stonesplinter Valley
	-- plural, as words: Stonesplinter Seers = {npc:1166} Stonesplinter Seer
	["South down the road past the tunnel post into {area:923}: the Stonesplinter Seers (level 13-14) stand among the troggs in its middle. Stay out of the far south end, where Shamans and Bonesnappers (level 15-16) camp, and keep clear of Headsplitter (15) on his walk. The Seers come with other troggs and cast from range: pull one at a time."] = "굴 초소를 지나 길을 따라 남쪽 {area:923}(으)로 가세요. 가루바위일족 점쟁이(13-14레벨)가 중앙의 트로그들 사이에 있습니다. 주술사와 뼈다귀분쇄자(15-16레벨)가 진을 친 남쪽 끝은 피하고, 돌아다니는 헤드스플리터(15)도 멀리하세요. 점쟁이는 다른 트로그와 함께 있고 원거리 주문을 시전합니다. 한 마리씩 끌어오세요.",
	-- {item:6652} Reagent Pouch
	-- plural, as words: Stonesplinter Seers = {npc:1166} Stonesplinter Seer
	["{item:6652}: Stonesplinter Seers"] = "{item:6652}: 가루바위일족 점쟁이",

	-- Step 95: The Fire Spirit Stone
	["The Fire Spirit Stone"] = "불의 정령석",
	-- {npc:257808} Braldir Ashmantle · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember · {object:61934} Brazier of the Dormant Flame
	["Back north to {npc:257808}'s camp above the tunnel. {npc:257808} gives you the {item:6636}. Climb to the peak above his camp, drink the Sapta beside the Spirit Stone and defeat the {npc:5893}, then place its {item:6655} in the {object:61934}, atop the Shrine of Eternal Flame."] = "굴 위쪽 {npc:257808}의 야영지로 북쪽으로 돌아가세요. {npc:257808}이(가) {item:6636}을(를) 줍니다. 그의 야영지 위 봉우리로 올라가 정령석 옆에서 삽타를 마시고 {npc:5893}을(를) 물리친 뒤, 영원의 불꽃 제단 꼭대기의 {object:61934}에 {item:6655}을(를) 넣으세요.",
	-- {item:6636} Fire Sapta
	["{item:6636}, beside the Spirit Stone"] = "{item:6636}, 정령석 옆",

	-- Step 96: Back to Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn
	["Back to {npc:257597}"] = "{npc:257597}에게 돌아가기",
	-- {npc:257597} Bruegs Kindleborn · {zone:1455} Ironforge
	["Back through the tunnel to {npc:257597}' cave above the farm, then west along the road to {zone:1455}."] = "굴을 지나 농장 위 {npc:257597}의 동굴로 돌아간 뒤, 길을 따라 서쪽 {zone:1455}(으)로 가세요.",
	-- {npc:257597} Bruegs Kindleborn · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:257597}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:257597}: {npc:2523}, {item:5176}, {item:263412}",

	-- Step 97: Golnir Bouldertoe
	-- {npc:4256} Golnir Bouldertoe · {object:32372} Great Forge (no name in this language: may be words) · {npc:1573} Gryth Thurden · {area:144} Thelsamar
	["{npc:4256} works at the {object:32372}'s north end, and {npc:1573} keeps the gryphons in the {object:32372}, where the flight from {area:144} lands."] = "{npc:4256}은(는) {object:32372} 북쪽 끝에서 일하고, {npc:1573}은(는) {area:144}에서 오는 비행편이 내리는 {object:32372}에서 그리핀을 돌봅니다.",
	-- {npc:4256} Golnir Bouldertoe · {object:32372} Great Forge (no name in this language: may be words)
	["{npc:4256}, in the {object:32372}"] = "{npc:4256}, {object:32372} 안",
	-- {npc:1573} Gryth Thurden · {object:32372} Great Forge (no name in this language: may be words)
	["{npc:1573}, the gryphon master in the {object:32372}"] = "{npc:1573}, {object:32372}의 그리핀 조련사",

	-- Step 100: Gretta Finespindle
	-- {npc:1466} Gretta Finespindle · {npc:6291} Balthus Stoneflayer · {quest:96031} Camping 101: Leatherworking
	["{npc:1466}, beside {npc:6291}: {quest:96031}"] = "{npc:1466}, {npc:6291} 옆: {quest:96031}",

	-- Step 102: Camping 101: Alchemy
	-- {npc:1246} Vosur Brakthel · {skill:171} Alchemy
	["{npc:1246} gives it and takes it back once your {skill:171} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "{npc:1246}이(가) 퀘스트를 주고 {skill:171} 숙련도가 20이 되면 다시 받습니다: 그때까지 채집하거나 제작하십시오. 그동안 가이드는 계속됩니다.",

	-- Step 103: Vosur Brakthel
	-- {npc:1246} Vosur Brakthel
	["{npc:1246}, who gave it"] = "{npc:1246}, 퀘스트를 준 사람",

	-- Step 104: Camping 101: Enchanting
	-- {npc:11065} Thonys Pillarstone · {skill:333} Enchanting
	["{npc:11065} gives it and takes it back once your {skill:333} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "{npc:11065}이(가) 퀘스트를 주고 {skill:333} 숙련도가 20이 되면 다시 받습니다: 그때까지 채집하거나 제작하십시오. 그동안 가이드는 계속됩니다.",

	-- Step 105: Thonys Pillarstone
	-- {npc:11065} Thonys Pillarstone
	["{npc:11065}, who gave it"] = "{npc:11065}, 퀘스트를 준 사람",

	-- Step 106: Tinker Town
	-- {object:32372} Great Forge (no name in this language: may be words) · {object:171524} Tinker Town · {object:660964} Misplaced Packages · {object:32383} Forlorn Cavern · {object:32362} Mystic Ward (no name in this language: may be words) · {object:171709} High Seat · {object:32359} Military Ward (no name in this language: may be words)
	["East from the {object:32372} into {object:171524}: the {object:660964} lie by its mailbox. From here the guide goes once round the city: north to the {object:32383}, west to the {object:32362}, south through the Commons to the {object:171709}, east through the {object:32359} and back to {object:171524} for the tram."] = "{object:32372}에서 동쪽으로 {object:171524}(으)로 들어가세요: {object:660964}은(는) 그 쪽 우편함 옆에 있습니다. 여기서 가이드는 도시를 한 바퀴 돕니다: 북쪽으로 {object:32383}, 서쪽으로 {object:32362}, 공동 구역을 통해 남쪽으로 {object:171709}, 동쪽으로 {object:32359}를 지나 지하철을 탈 {object:171524}(으)로 돌아갑니다.",
	-- {object:660964} Misplaced Packages · {object:171524} Tinker Town
	["{object:660964}, by the mailbox in {object:171524}"] = "{object:660964}, {object:171524}의 우체통 옆",

	-- Step 107: Forlorn Cavern
	-- {object:32372} Great Forge (no name in this language: may be words) · {npc:258098} Eldrun Stormbreaker · {object:32383} Forlorn Cavern · {npc:6120} Lago Blackwrench
	["North of the {object:32372}: {npc:258098}, the shaman trainer, stands at the south end of the {object:32383}, the rogue and warlock trainers and {npc:6120} just north of him."] = "{object:32372} 북쪽: 샤먼 훈련사 {npc:258098}이(가) {object:32383} 남쪽 끝에 서 있고, 도적과 흑마법사 훈련사, {npc:6120}은(는) 그 바로 북쪽에 있습니다.",
	-- {npc:6120} Lago Blackwrench · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind
	["{npc:6120}: {npc:6122} in {zone:1453} takes it"] = "{npc:6120}: {zone:1453}의 {npc:6122}에게 제출합니다",

	-- Step 108: The Tome of Divinity
	-- {item:6775} Tome of Divinity
	["The {item:6775}"] = "{item:6775}",
	-- {object:32383} Forlorn Cavern · {object:32362} Mystic Ward (no name in this language: may be words) · {npc:5149} Brandur Ironhammer · {npc:6179} Tiza Battleforge · {npc:6178} Muiredon Battleforge · {object:32386} Hall of Mysteries (no name in this language: may be words) · {npc:6175} John Turner · {item:2589} Linen Cloth · {zone:1426} Dun Morogh
	["West from the {object:32383} into the {object:32362}: {npc:5149}, {npc:6179} and {npc:6178} are in the {object:32386}, Tiza and Muiredon on its upper floor: the stairs up start just north-east of {npc:5149}. {npc:6175}, a beggar, wanders the city. He asks for ten {item:2589}: the troggs and trolls of {zone:1426} drop it, and the Auction House sells it."] = "{object:32383}에서 서쪽으로 {object:32362}(으)로 들어가세요: {npc:5149}, {npc:6179}, {npc:6178}이(가) {object:32386} 안에 있고, 티자와 무리든은 그 위층에 있습니다: 위층으로 올라가는 계단은 {npc:5149}의 바로 북동쪽에서 시작됩니다. 거지 {npc:6175}이(가) 도시를 배회합니다. 그는 {item:2589} 열 개를 원합니다: {zone:1426}의 트로그와 트롤이 떨어뜨리고, 경매장에서도 팝니다.",

	-- Step 109: Narm Faulk
	-- {zone:1455} Ironforge · {area:212} Helm's Bed Lake · {npc:6177} Narm Faulk · {item:6866} Symbol of Life
	["Head back out of {zone:1455} and east along the road to {area:212}. {npc:6177} lies dead by its shore: use the {item:6866} on him. The Dark Iron Spies sneaking around the lake carry the script."] = "{zone:1455}을(를) 나와 길을 따라 동쪽으로 {area:212}까지 가세요. {npc:6177}은(는) 그 기슭에서 죽어 있습니다: 그에게 {item:6866}을(를) 사용하세요. 호숫가를 맴도는 검은무쇠 첩자가 서류를 가지고 있습니다.",

	-- Step 111: Mystic Ward
	-- {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward (no name in this language: may be words)
	["The paladin, priest and mage trainers are in the {object:32386}, in the {object:32362}."] = "성기사, 사제, 마법사 훈련사는 {object:32362}에 있는 {object:32386} 안에 있습니다.",
	-- {npc:258785} High Priestess Mims · {quest:94817} Confounding Flash
	["{npc:258785}: {quest:94817}, her own copy of the letter"] = "{npc:258785}: {quest:94817}, 그녀 자신의 편지 사본",

	-- Step 112: High Seat
	-- {npc:1274} Senator Barin Redstone · {object:171709} High Seat
	["South through the Commons: {npc:1274} stands in the {object:171709} with King Magni."] = "공동 구역을 통해 남쪽으로: {npc:1274}이(가) 국왕 마그니와 함께 {object:171709}에 서 있습니다.",
	-- {npc:1274} Senator Barin Redstone · {object:171709} High Seat
	["{npc:1274}, in the {object:171709} with King Magni"] = "{npc:1274}, 국왕 마그니와 함께 {object:171709}에",

	-- Step 113: Buliwyf Stonehand
	-- {spell:197} Two-Handed Axes · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward (no name in this language: may be words)
	["While you're here: learn {spell:197} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Paladin fastest."] = "여기 있을 때: {npc:11865}에게 {spell:197}을(를) 배우세요({object:32359}, 은화 10개); 양손 무기가 성기사를 가장 빨리 키웁니다.",

	-- Step 114: Military Ward
	-- {object:32359} Military Ward (no name in this language: may be words) · {npc:11865} Buliwyf Stonehand · {object:32390} Hall of Arms (no name in this language: may be words)
	["East to the {object:32359}: the warrior trainers and {npc:11865} in the {object:32390}, the hunter trainers beside it."] = "동쪽으로 {object:32359}까지: 전사 훈련사와 {npc:11865}은(는) {object:32390} 안에, 사냥꼬 훈련사는 그 옆에 있습니다.",

	-- Step 115: Buliwyf Stonehand
	-- {spell:197} Two-Handed Axes · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward (no name in this language: may be words)
	["While you're here: learn {spell:197} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "여기 있을 때: {npc:11865}에게 {spell:197}을(를) 배우세요({object:32359}, 은화 10개); 양손 무기가 전사를 가장 빨리 키웁니다.",

	-- Step 116: Buliwyf Stonehand
	-- {spell:199} Two-Handed Maces · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward (no name in this language: may be words)
	["While you're here: learn {spell:199} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "여기 있을 때: {npc:11865}에게 {spell:199}을(를) 배우세요({object:32359}, 은화 10개); 양손 무기가 전사를 가장 빨리 키웁니다.",

	-- Step 117: Druid trainer
	["Druid trainer"] = "드루이드 상급자",
	-- {npc:5505} Theridran · {zone:1453} Stormwind · {zone:1426} Dun Morogh
	["{npc:5505} in {zone:1453}; {zone:1426} has no druid trainer"] = "{zone:1453}의 {npc:5505}; {zone:1426}에는 드루이드 훈련사가 없습니다",

	-- Step 118: The Deeprun Tram
	-- {area:2257} Deeprun Tram
	["The {area:2257}"] = "{area:2257}",
	-- {object:171524} Tinker Town · {area:2257} Deeprun Tram · {zone:1453} Stormwind
	["East back into {object:171524}: the {area:2257} leaves from its east end. Ride it to {zone:1453}."] = "동쪽으로 다시 {object:171524}(으)로 들어가세요: {area:2257}은(는) 그 동쪽 끝에서 출발합니다. 타고 {zone:1453}(으)로 가세요.",

	-- Step 119: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "지하철을 타고 {zone:1453}(으)로",
	-- {zone:1455} Ironforge · {area:2257} Deeprun Tram · {npc:12997} Monty · {item:17117} Rat Catcher's Flute · {npc:13018} Nipsy · {zone:1453} Stormwind
	-- plural, as words: Deeprun Rats = {npc:13016} Deeprun Rat
	["On the {zone:1455} platform of the {area:2257}, {npc:12997} asks for help with the rats: use his {item:17117} on the Deeprun Rats around the platform, hand them in, then take his letter to his brother {npc:13018} at the {zone:1453} end. The tram has no map inside. The city markers show the entrances, not the two brothers."] = "{zone:1455}의 {area:2257} 승강장에서 {npc:12997}이(가) 쥐 문제를 도와달라고 합니다. 승강장 주변 깊은굴 쥐에게 {item:17117}을(를) 쓰고 제출한 뒤 그의 편지를 {zone:1453} 쪽 끝의 형제 {npc:13018}에게 전하세요. 전차 안에는 지도가 없습니다. 도시 표시는 출입구를 가리킬 뿐 두 형제를 가리키지 않습니다.",
	-- {npc:12997} Monty · {zone:1455} Ironforge
	["{npc:12997}, on the {zone:1455} platform"] = "{npc:12997}, {zone:1455} 승강장",
	-- {npc:13016} Deeprun Rat · {item:17117} Rat Catcher's Flute
	["{npc:13016}: use the {item:17117}"] = "{npc:13016}: {item:17117} 사용",
	-- {npc:13016} Deeprun Rat
	["Catch {npc:13016}"] = "{npc:13016} 잡기",

	-- Step 120: Nipsy
	-- {zone:1453} Stormwind · {npc:13018} Nipsy · {npc:5413} Furen Longbeard · {object:28027} Dwarven District
	["Ride the tram to {zone:1453}: {npc:13018} waits on the {zone:1453} platform. {npc:5413} stands in the {object:28027}, just outside the tram."] = "지하철을 타고 {zone:1453}(으)로 가세요: {npc:13018}이(가) {zone:1453} 승강장에서 기다립니다. {npc:5413}은(는) 지하철 바로 밖의 {object:28027}에 서 있습니다.",
	-- {npc:13018} Nipsy · {zone:1453} Stormwind
	["{npc:13018}, on the {zone:1453} platform"] = "{npc:13018}, {zone:1453} 승강장",

	-- Step 121: From the tram to Stormwind
	-- {area:1519} Stormwind
	["From the tram to {area:1519}"] = "전차에서 {area:1519}(으)로",

	-- Step 122: Baros Alexston
	-- {object:28027} Dwarven District · {object:2098} Cathedral Square · {npc:1646} Baros Alexston · {zone:1436} Westfall · {object:2096} Trade District
	["From the {object:28027} south-west to {object:2098}: {npc:1646}'s compass is in his old house in {zone:1436}, on the way. The flight master and the {object:2096} are south of the square."] = "{object:28027}에서 남서쪽으로 {object:2098}까지: {npc:1646}의 나침반은 가는 길인 {zone:1436}, 그의 옛 집에 있습니다. 비행 조련사와 {object:2096}은(는) 광장 남쪽에 있습니다.",

	-- Step 123: Stormwind flight master
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "{zone:1453} 비행 조련사",

	-- Step 124: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Paladin fastest."] = "여기 있을 때: {npc:11867}에게 {spell:202}을(를) 배우세요({object:2096}, 은화 10개); 양손 무기가 성기사를 가장 빨리 키웁니다.",

	-- Step 125: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "여기 있을 때: {npc:11867}에게 지팡이를 배우세요({object:2096}, 은화 10개); 사냥꼬의 근접 무기는 대개 능력치가 중요하고, 양손 무기가 가장 높습니다.",

	-- Step 126: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Swords from {npc:11867} ({object:2096}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "여기 있을 때: {npc:11867}에게 검을 배우세요({object:2096}, 은화 10개); 주무기에 검이면 도적이 꾸준히 성장합니다.",

	-- Step 127: Defensive Stance
	-- {npc:5480} Ilsa Corbin · {object:2100} Old Town · {zone:1455} Ironforge · {object:28027} Dwarven District · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern · {quest:1638} A Warrior's Training · {quest:1639} Bartleby the Drunk
	["{npc:5480} trains warriors in {object:2100}, near Osric's shop; the tram from {zone:1455} arrives in the {object:28027}, north of it. {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug. If {npc:5480} doesn't offer {quest:1638}, go straight to {npc:6089}: he gives {quest:1639} without it."] = "{npc:5480}은(는) 오스릭의 상점 근처 {object:2100}에서 전사를 훈련시킵니다. {zone:1455}에서 오는 지하철은 그 북쪽의 {object:28027}에 도착합니다. {npc:6089}와(과) {npc:6090}은(는) 그곳 {object:2152} 옆에 함께 서 있습니다. {npc:6090}은(는) 자기 잔을 걸고 당신과 싸웁니다. {npc:5480}이(가) {quest:1638}을(를) 주지 않으면 곧장 {npc:6089}에게 가세요. 그는 그 퀘스트 없이도 {quest:1639}을(를) 줍니다.",

	-- Step 128: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "여기 있을 때: {npc:11867}에게 {spell:202}을(를) 배우세요({object:2096}, 은화 10개); 양손 무기가 전사를 가장 빨리 키웁니다.",

	-- Step 129: Gakin the Darkbinder
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["{npc:6122} waits in the cellar of the {object:2164}, in the {object:2101}."] = "{npc:6122}은(는) {object:2101}에 있는 {object:2164}의 지하실에서 기다립니다.",
	-- {quest:1688} Surena Caledon · {zone:1436} Westfall
	["{quest:1688}: her choker and The Binding are on {zone:1436}'s east-Elwynn loop"] = "{quest:1688}: 그녀의 목걸이와 '속박'은 {zone:1436} 가이드의 엘윈 동부 순회에서 처리합니다",

	-- Step 130: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "여기 있을 때: {npc:11867}에게 지팡이를 배우세요({object:2096}, 은화 10개); 성장 중에는 지팡이가 한손 무기보다 주문 능력치가 더 높습니다.",

	-- Step 131: Jennea Cannon
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {quest:1861} Mirror Lake
	["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}; she gives you a flask for the {quest:1861} waterfall."] = "{npc:5497}은(는) {object:2101}의 탑인 마법사의 성소에 서 있습니다. 그녀가 {quest:1861} 폭포용 플라스크를 줍니다.",

	-- Step 132: Mirror Lake
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {zone:1436} Westfall · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {zone:1436}: fill {item:7207} at its base."] = "정문으로 {zone:1453}을(를) 나가십시오. {quest:1861} 폭포는 성문 남서쪽, 서쪽 {zone:1436}(으)로 가는 길에 있습니다. 폭포 아래에서 {item:7207}을(를) 채우십시오.",

	-- Step 133: Goldshire
	-- {zone:1453} Stormwind · {area:87} Goldshire · {zone:1436} Westfall
	["Leave {zone:1453} by the main gate and follow the road south to {area:87}: east Elwynn comes before {zone:1436}."] = "정문으로 {zone:1453}을(를) 나가 길을 따라 남쪽 {area:87}까지 가세요: 동부 엘윈 삼림이 {zone:1436}보다 먼저 옵니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back through the tunnel to {npc:257597}' cave above the farm."] = "굴을 지나 농장 위 {npc:257597}의 동굴로 돌아가세요.",
	-- ["Back to {npc:257446} in {area:77}. He gives you the {item:6635}: take the rubble-marked path that climbs west from the south of the valley to the Spirit Stone on the ridge, drink the Sapta beside it and speak to the {npc:5891}, then bring its {item:6656} back to Teo."] = "{area:77}의 {npc:257446}에게 돌아가세요. 그가 {item:6635}을(를) 줍니다. 골짜기 남쪽에서 서쪽으로 올라가는 돌무더기 표시 길을 따라 능선의 정령석까지 가서, 그 옆에서 삽타를 마시고 {npc:5891}에게 말을 건 뒤, 그 {item:6656}을(를) 테오에게 가져가세요.",
	-- ["Follow the road all the way east to the {area:806} at the {area:38} tunnel."] = "도로를 따라 끝까지 동쪽으로 가 {area:38} 터널의 {area:806}까지 가세요.",
	-- ["Follow the road up to {zone:1455} and train with your class trainer. The {area:2257} leaves from {object:171524}, in the east of the city. Ride it to {zone:1453}."] = "길을 따라 {zone:1455}(으)로 올라가 직업 상급자에게 훈련을 받으세요. {area:2257}은(는) 도시 동쪽의 {object:171524}에서 출발합니다. 그것을 타고 {zone:1453}(으)로 가세요.",
	-- ["Iceclaw Bear Pendants, from the Frostmane Troll Whelps on the slopes above the camp"] = "{item:264356}, 야영지 위 비탈의 {npc:706}에게서",
	-- ["Leave {zone:1453} by the main gate, go south to {area:87} and east along the road to the {area:62}. {npc:881} (level 9) stands by its farmhouse."] = "정문으로 {zone:1453}을(를) 나가 남쪽으로 {area:87}까지 간 뒤, 길을 따라 동쪽으로 {area:62}까지 가세요. {npc:881}(9레벨)은(는) 농가 옆에 서 있습니다.",
	-- ["Leper Gnomes around Brewnall and the {area:133} road carry the cogs and gears. Ice Claw Bears, Elder Crag Boars and Snow Leopards roam the hills around the lake."] = "브루날 마을과 {area:133} 길 주변의 오염된 노움이 톱니와 기어를 지니고 있습니다. 얼음발톱흰곰, 덩치큰 멧돼지, 눈표범이 호수 주변 언덕을 돌아다닙니다.",
	-- ["Level 4 spells, before Gozwin's camp"] = "4레벨 주문, 고즈윈의 야영지 전에",
	-- ["Sit by Eric's campfire (type /sit) and wait for the buff. With a profession learned, Eric also offers its Camping 101, which its trainer takes: blacksmithing with {npc:1241} and {skill:129} with {npc:2326} in {area:131}, mining and engineering at {area:189}."] = "에릭의 모닥불 옆에 앉아(/앉기 입력) 강화 효과를 기다리세요. 전문 기술을 배웠다면 에릭은 해당 기술의 야영 101도 주며, 그 기술의 전문 기술자에게 제출합니다. 대장기술은 {npc:1241}, {skill:129}은(는) {area:131}의 {npc:2326}, 채광과 기계공학은 {area:189}입니다.",
	-- ["Stonesplinter Seers (level 13) stand among the troggs in the south of {area:923}, south of {npc:257808}; Tunnel Rat Geomancers (level 12) work the {area:149} at the north end of the loch. The troggs come in packs and some throw from range: pull one at a time."] = "가루바위일족 점쟁이(13레벨)는 {npc:257808} 남쪽, {area:923} 남부의 트로그들 사이에 서 있고, 동굴쥐일족 흙점쟁이(12레벨)는 호수 북쪽 끝의 {area:149}에서 일합니다. 트로그는 무리 지어 다니고 일부는 원거리 공격을 합니다. 하나씩 끌어오세요.",
	-- ["Subdue the voidwalker"] = "공허방랑자 제압",
	-- ["The tram arrives in the {object:28027}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "지하철은 {object:28027}에 도착합니다. {npc:5480}은(는) {object:2100}에서 전사를 훈련시킵니다. {npc:6089}와(과) {npc:6090}은(는) 그곳 {object:2152} 옆에 함께 서 있습니다. {npc:6090}은(는) 자기 잔을 걸고 당신과 싸웁니다.",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:1388} is a level 12 elite: take him on with a group. Alone, skip it: the {zone:1432} quests ahead make up the experience."] = "정예 몹들입니다. 파티를 권장하니 함께할 사람을 찾으세요. {npc:1388}은(는) 12레벨 정예입니다. 파티로 상대하세요. 혼자라면 건너뛰세요. 앞으로의 {zone:1432} 퀘스트로 경험치를 메울 수 있습니다.",
	-- ["{area:135} is the troll cave in the hills south-west of {area:137}. Kill Headhunters at its mouth and walk through to its far end.\nCareful: the Frostmane Hideskinners inside the Hold are level 9-10 and stand in pairs: pull them one at a time back to the mouth."] = "{area:135}은(는) {area:137} 남서쪽 언덕의 트롤 동굴입니다. 입구의 머리사냥꾼을 처치하고 가장 안쪽 끝까지 걸어가세요.\n주의: 소굴 안의 서리갈기부족 무두장이는 9-10레벨이고 둘씩 서 있습니다. 한 마리씩 입구로 끌어오세요.",
	-- ["{item:5026} and the {item:6652}"] = "{item:5026}와(과) {item:6652}",
	-- ["{item:6635}, beside the Spirit Stone"] = "{item:6635}, 정령석 옆",
	-- ["{npc:1226}: {npc:258785} in {zone:1455} takes it"] = "{npc:1226}: {zone:1455}의 {npc:258785}에게 제출합니다",
	-- ["{npc:1241}, below ground: Camping 101, blacksmiths"] = "{npc:1241}, 지하: 야영 기초, 대장장이",
	-- ["{npc:1377}, at the depot"] = "{npc:1377}, 정거장에서",
	-- ["{npc:1702}, beside him: Camping 101, engineers"] = "{npc:1702}, 그의 옆: 야영 기초, 기계공학자",
	-- ["{npc:1960} waits at the {area:808}, north of the South Gate; the dwarven corpse lies up the pass to the west of him."] = "{npc:1960}은(는) 남쪽 관문 북쪽의 {area:808}에서 기다립니다; 드워프 시체는 그의 서쪽 고개 위에 놓여 있습니다.",
	-- ["{npc:2326}, inside: Camping 101, {skill:129}"] = "{npc:2326}, 안: 야영 기초, {skill:129}",
	-- ["{npc:257446}, inside {area:77}"] = "{npc:257446}, {area:77} 안",
	-- ["{npc:257446}: {npc:5873} and your {item:5175}"] = "{npc:257446}: {npc:5873}와(과) {item:5175}",
	-- ["{npc:257808} gives you the {item:6636}. Climb to the peak above his camp, drink the Sapta beside the Spirit Stone and defeat the {npc:5893}, then place its {item:6655} in the {object:61934}, atop the Shrine of Eternal Flame."] = "{npc:257808}이(가) {item:6636}을(를) 줍니다. 그의 야영지 위 봉우리로 올라가 정령석 옆에서 삽타를 마시고 {npc:5893}을(를) 물리친 뒤, 영원의 불꽃 제단 꼭대기의 {object:61934}에 {item:6655}을(를) 넣으세요.",
	-- ["{npc:258098}, the shaman trainer, north of the {object:32372}"] = "{npc:258098}, 주술사 상급자, {object:32372} 북쪽",
	-- ["{npc:265813}, blacksmiths: for {npc:1241}"] = "{npc:265813}, 대장장이: {npc:1241}에게 제출",
	-- ["{npc:265813}, engineers: for {npc:1702}"] = "{npc:265813}, 기계공학자: {npc:1702}에게 제출",
	-- ["{npc:265813}, miners: for {npc:5392}"] = "{npc:265813}, 광부: {npc:5392}에게 제출",
	-- ["{npc:265813}, {skill:129}: for {npc:2326}"] = "{npc:265813}, {skill:129}: {npc:2326}에게 제출",
	-- ["{npc:2756} stands by {npc:8416} at the door of {area:77}. Gozwin's camp is in the hills just north-west; the {npc:269075} prowls around it."] = "{npc:2756}은(는) {area:77} 문 앞에서 {npc:8416} 옆에 서 있습니다. 고즈윈의 야영지는 바로 북서쪽 언덕에 있으며, {npc:269075}이(가) 그 주변을 배회합니다.",
	-- ["{npc:5392}: Camping 101, miners"] = "{npc:5392}: 야영 기초, 광부",
	-- ["{zone:1455} class quests"] = "{zone:1455} 직업 퀘스트",
}
