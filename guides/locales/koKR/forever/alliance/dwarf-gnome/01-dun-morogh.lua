-- Korean (koKR): the guide forever/alliance/dwarf-gnome/01-dun-morogh (forever/alliance/dwarf-gnome/01-dun-morogh.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {npc:912} Thran Khorman
	["{npc:912}, the warrior trainer"] = "{npc:912}, 전사 상급자",
	-- {npc:926} Bromos Grummner
	["{npc:926}, the paladin trainer"] = "{npc:926}, 성기사 상급자",
	-- {npc:658} Sten Stoutarm · {npc:895} Thorgas Grimson
	["{npc:658}: a rune for {npc:895}"] = "{npc:658}: {npc:895}에게 줄 룬",
	-- {npc:895} Thorgas Grimson
	["{npc:895}, the hunter trainer"] = "{npc:895}, 사냥꾼 상급자",
	-- {npc:916} Solm Hargrin
	["{npc:916}, the rogue trainer"] = "{npc:916}, 도적 상급자",
	-- {npc:837} Branstock Khalder
	["{npc:837}, the priest trainer"] = "{npc:837}, 사제 상급자",
	-- {npc:658} Sten Stoutarm · {quest:98581} Archaic Rune
	["{npc:658}: read the {quest:98581}"] = "{npc:658}: {quest:98581}을(를) 읽으세요",
	-- {npc:257446} Teo Hammerstorm · {area:77} Anvilmar
	["{npc:257446}, inside {area:77}"] = "{npc:257446}, {area:77} 안",
	-- {npc:944} Marryk Nurribit · {area:77} Anvilmar
	["{npc:944}, the mage trainer, inside {area:77}"] = "{npc:944}, 마법사 상급자, {area:77} 안",
	-- {npc:460} Alamar Grimm · {area:77} Anvilmar
	["{npc:460}, inside {area:77}"] = "{npc:460}, {area:77} 안",
	-- {npc:713} Balir Frosthammer · {npc:658} Sten Stoutarm
	["{npc:713}, next to {npc:658}"] = "{npc:713}, {npc:658} 옆",
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
	["A few more troggs outside if you are short"] = "모자라면 밖에서 트로그를 몇 마리 더",
	-- {npc:8416} Felix Whindlebolt · {area:77} Anvilmar
	["{npc:8416}, by the door of {area:77}"] = "{npc:8416}, {area:77} 문 옆",

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
	-- plural, as words: Frostmane Troll Whelps = {npc:706} Frostmane Troll Whelp
	["A few Frostmane Troll Whelps if you are short"] = "부족하면 {npc:706} 몇 마리",

	-- Step 10: The troll cave
	["The troll cave"] = "트롤 동굴",
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
	["{npc:836}, inside {area:77}"] = "{npc:836}, {area:77} 안",
	["Level 4 spells, before Gozwin's camp"] = "4레벨 주문, 고즈윈의 야영지 전에",

	-- Step 13: Grund and Gozwin
	-- {npc:2756} Grund Drokda · {npc:8416} Felix Whindlebolt · {area:77} Anvilmar · {npc:269075} Snow Leopard Prowler
	["{npc:2756} stands by {npc:8416} at the door of {area:77}. Gozwin's camp is in the hills just north-west; the {npc:269075} prowls around it."] = "{npc:2756}은(는) {area:77} 문 앞에서 {npc:8416} 옆에 서 있습니다. 고즈윈의 야영지는 바로 북서쪽 언덕에 있으며, {npc:269075}이(가) 그 주변을 배회합니다.",
	-- {item:277976} Gozwin's Mechanic's Log
	["{item:277976}, in the camp"] = "{item:277976}, 야영지 안",

	-- Step 14: Grik'nir the Cold
	-- {npc:808} Grik'nir the Cold · {npc:786} Grelin Whitebeard
	["{npc:808} is inside the troll cave east of {npc:786}'s camp, not on the hill above it: go in at the mouth and follow the tunnel to the back."] = "{npc:808}은(는) {npc:786}의 야영지 동쪽 트롤 동굴 안에 있습니다. 그 위 언덕이 아닙니다. 입구로 들어가 굴을 따라 안쪽 끝까지 가세요.",

	-- Step 15: Grelin Whitebeard
	-- {npc:12738} Nori Pridedrift
	["{npc:12738}, next to him"] = "{npc:12738}, 그의 옆",
	-- plural, as words: Iceclaw Bear Pendants = {item:264356} Iceclaw Bear Pendant · Frostmane Troll Whelps = {npc:706} Frostmane Troll Whelp
	["Iceclaw Bear Pendants, from the Frostmane Troll Whelps on the slopes above the camp"] = "{item:264356}, 야영지 위 비탈의 {npc:706}에게서",

	-- Step 16: Call of Earth
	-- {npc:257446} Teo Hammerstorm · {area:77} Anvilmar · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth · {item:6656} Rough Quartz
	["Back to {npc:257446} in {area:77}. He gives you the {item:6635}: take the rubble-marked path that climbs west from the south of the valley to the Spirit Stone on the ridge, drink the Sapta beside it and speak to the {npc:5891}, then bring its {item:6656} back to Teo."] = "{area:77}의 {npc:257446}에게 돌아가세요. 그가 {item:6635}을(를) 줍니다. 골짜기 남쪽에서 서쪽으로 올라가는 돌무더기 표시 길을 따라 능선의 정령석까지 가서, 그 옆에서 삽타를 마시고 {npc:5891}에게 말을 건 뒤, 그 {item:6656}을(를) 테오에게 가져가세요.",
	-- {item:6635} Earth Sapta
	["{item:6635}, beside the Spirit Stone"] = "{item:6635}, 정령석 옆",
	-- {npc:257446} Teo Hammerstorm · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:257446}: {npc:5873} and your {item:5175}"] = "{npc:257446}: {npc:5873}와(과) {item:5175}",

	-- Step 17: The tunnel
	["The tunnel"] = "굴",
	-- {npc:1965} Mountaineer Thalos · {area:77} Anvilmar · {npc:6782} Hands Springsprocket
	["{npc:1965} guards the tunnel out of the valley, east of {area:77}; {npc:6782} stands beside him at its mouth."] = "{npc:1965}은(는) {area:77} 동쪽, 골짜기 밖으로 나가는 굴을 지킵니다. {npc:6782}은(는) 굴 입구에서 그 옆에 서 있습니다.",

	-- Step 18: Kharanos
	-- {area:131} Kharanos · {npc:1267} Ragnar Thunderbrew · {npc:1252} Senir Whitebeard · {area:2102} Thunderbrew Distillery · {npc:6806} Tannok Frosthammer · {npc:1226} Maxan Anvol · {npc:1872} Tharek Blackstone
	-- plural, as words: Crag Boars = {npc:1125} Crag Boar
	["Follow the road through the tunnel and north-east to {area:131}. Kill the Crag Boars on the way: their ribs drop before you have {npc:1267}'s quest and count toward it. {npc:1252}, Eric and his campfire are outside the {area:2102}. {npc:6806}, {npc:1226} and {npc:1267} are inside. {npc:1872} works the forge."] = "굴을 지나 길을 따라 북동쪽으로 {area:131}까지 가세요. 가는 길에 멧돼지를 처치하세요. {npc:1267}의 퀘스트를 받기 전에도 갈비가 떨어지며 퀘스트에 포함됩니다. {npc:1252}, 에릭과 그의 모닥불은 {area:2102} 밖에 있습니다. {npc:6806}, {npc:1226}, {npc:1267}은(는) 안에 있습니다. {npc:1872}은(는) 대장간에서 일합니다.",
	-- {npc:6806} Tannok Frosthammer
	["{npc:6806}, in the distillery"] = "{npc:6806}, 양조장 안",
	-- {npc:1226} Maxan Anvol · {npc:6806} Tannok Frosthammer
	["{npc:1226}, next to {npc:6806}"] = "{npc:1226}, {npc:6806} 옆",
	-- {item:2894} Rhapsody Malt · {npc:1247} Innkeeper Belm
	["{item:2894}, from {npc:1247}"] = "{item:2894}, {npc:1247}에게서",

	-- Step 19: The Great Outdoors
	-- {npc:1699} Gremlock Pilsnor
	["Sit by Eric's campfire (type /sit) and wait for the buff, then {npc:1699} in the distillery teaches you cooking."] = "에릭의 모닥불 옆에 앉아(/앉기 입력) 버프를 기다린 뒤, 양조장 안의 {npc:1699}에게 요리를 배우세요.",
	-- {npc:1699} Gremlock Pilsnor
	["Speak with {npc:1699}"] = "{npc:1699}에게 말을 거세요",

	-- Step 20: Steelgrill's Depot
	-- {area:131} Kharanos · {zone:1455} Ironforge
	["Follow the road north-east from {area:131} to the depot below the {zone:1455} road."] = "{area:131}에서 길을 따라 북동쪽으로 {zone:1455} 길 아래의 정거장까지 가세요.",

	-- Step 21: Boars and bears
	["Boars and bears"] = "멧돼지와 곰",
	-- {area:131} Kharanos
	-- plural, as words: Crag Boars = {npc:1125} Crag Boar · Young Black Bears = {npc:1128} Young Black Bear
	["Crag Boars and Young Black Bears roam the fields around {area:131} and the depot."] = "멧돼지와 새끼 흑곰이 {area:131}와(과) 정거장 주변 들판을 돌아다닙니다.",

	-- Step 24: The Grizzled Den
	-- {quest:313} The Grizzled Den · {area:131} Kharanos
	["{quest:313} is the wendigo cave south-west of {area:131}. Flintfire's shipments lie on the cave floor."] = "{quest:313}은(는) {area:131} 남서쪽의 웬디고 동굴입니다. 플린트파이어의 화물은 동굴 바닥에 있습니다.",

	-- Step 26: Mountaineer Cornelius
	-- {area:136} Grizzled Den
	["Cornelius is missing in the {area:136}: find him inside, then go back to Gretchen."] = "{area:136}에서 Cornelius가 실종되었습니다. 안에서 그를 찾은 뒤 그레첸에게 돌아가세요.",

	-- Step 28: Kharanos and the depot
	-- {area:131} Kharanos
	["{area:131} and the depot"] = "{area:131}와(과) 정거장",
	-- {npc:1377} Pilot Stonegear
	["{npc:1377}, at the depot"] = "{npc:1377}, 정거장에서",
	-- {npc:1269} Razzle Sprysprocket
	["{npc:1269}, by the depot"] = "{npc:1269}, 정거장 옆",

	-- Step 29: Rumbleshot's Ammo
	-- {area:802} Shimmer Ridge · {npc:1243} Hegnar Rumbleshot
	["The ammo crate sits in the Frostmane camp on {area:802}; {npc:1243} camps south of it, by the road to Coldridge."] = "탄약 상자는 {area:802}의 서리갈기부족 야영지에 있습니다. {npc:1243}은(는) 그 남쪽, 눈마루 골짜기로 가는 길가에 진을 치고 있습니다.",

	-- Step 30: Frostmane Hold
	-- {area:135} Frostmane Hold · {area:137} Brewnall Village
	["{area:135} is the troll cave in the hills west of {area:137}. Kill Headhunters at its mouth and walk through to its far end."] = "{area:135}은(는) {area:137} 서쪽 언덕의 트롤 동굴입니다. 입구에서 인간사냥꾼을 처치하고 안쪽 끝까지 걸어가세요.",

	-- Step 31: Brewnall Village
	-- {area:137} Brewnall Village · {area:135} Frostmane Hold
	["{area:137} sits on the lake north-west of {area:135}."] = "{area:137}은(는) {area:135} 북서쪽 호숫가에 있습니다.",

	-- Step 32: Gnomes, bears and leopards
	["Gnomes, bears and leopards"] = "노움, 곰, 표범",
	-- {area:133} Gnomeregan
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome · Ice Claw Bears = {npc:1196} Ice Claw Bear · Elder Crag Boars = {npc:1127} Elder Crag Boar · Snow Leopards = {npc:1201} Snow Leopard
	["Leper Gnomes around Brewnall and the {area:133} road carry the cogs and gears. Ice Claw Bears, Elder Crag Boars and Snow Leopards roam the hills around the lake."] = "브루날 마을과 {area:133} 길 주변의 오염된 노움이 톱니와 기어를 지니고 있습니다. 얼음발톱흰곰, 덩치큰 멧돼지, 눈표범이 호수 주변 언덕을 돌아다닙니다.",

	-- Step 35: Kharanos
	-- {npc:1373} Jarven Thunderbrew · {item:2686} Thunder Ale · {npc:1247} Innkeeper Belm · {spell:8553} Barleybrew Scalder
	["{npc:1373} guards the {item:2686} barrels in the distillery basement. Buy a {item:2686} from {npc:1247}, click the guarded barrel, then hand the ale to {npc:1373} from his quest window (there is no quest to accept); after that, the unguarded barrel takes the {spell:8553}."] = "{npc:1373}은(는) 양조장 지하실에서 {item:2686} 통을 지킵니다. {npc:1247}에게서 {item:2686}을(를) 사서 지키는 통을 클릭한 뒤, {npc:1373}의 퀘스트 창에서 맥주를 건네세요(수락할 퀘스트는 없습니다). 그 후에는 지키지 않는 통에서 {spell:8553}을(를) 가져갈 수 있습니다.",
	-- {item:2686} Thunder Ale · {npc:1247} Innkeeper Belm
	["{item:2686}, from {npc:1247} in the distillery"] = "{item:2686}, 양조장 안 {npc:1247}에게서",
	-- {object:269} Guarded Thunder Ale Barrel
	["The {object:269} in the basement"] = "지하실의 {object:269}",
	-- {npc:1373} Jarven Thunderbrew
	["{npc:1373}, beside the barrel"] = "{npc:1373}, 통 옆",
	-- {object:270} Unguarded Thunder Ale Barrel
	["The {object:270} in the distillery"] = "양조장 안의 {object:270}",

	-- Step 37: Misty Pine Refuge
	-- {area:138} Misty Pine Refuge
	["Follow the road east past the depot to {area:138}."] = "길을 따라 동쪽으로 정거장을 지나 {area:138}까지 가세요.",

	-- Step 38: Firewood
	["Firewood"] = "장작",
	["The firewood lies in the snow around the frozen lake by the refuge."] = "장작은 피난처 옆 얼어붙은 호수 주변 눈밭에 있습니다.",

	-- Step 40: The cold
	["The cold"] = "추위",
	-- plural, as words: Minor Ice Elementals = {npc:276003} Minor Ice Elemental
	["Minor Ice Elementals drift around the frozen lake by the refuge. The three rifles are in the snow around it."] = "하급 얼음 정령이 피난처 옆 얼어붙은 호수 주변을 떠다닙니다. 소총 세 자루는 그 주변 눈밭에 있습니다.",

	-- Step 42: Avala's Core
	-- {item:286325} Avala's Core
	["{item:286325} is by the frozen lake, among the ice elementals."] = "{item:286325}은(는) 얼어붙은 호수 옆, 얼음 정령들 사이에 있습니다.",

	-- Step 45: Gol'Bolar Quarry
	["The quarry lies south-east of the ranch."] = "채석장은 농장 남동쪽에 있습니다.",
	-- {npc:1698} Frast Dokner
	["{npc:1698}: blacksmiths only"] = "{npc:1698}: 대장장이만",

	-- Step 46: The quarry troggs
	["The quarry troggs"] = "채석장 트로그",
	-- {area:212} Helm's Bed Lake · {item:268548} Empty Powder Keg
	-- plural, as words: Rockjaw Skullthumpers = {npc:1115} Rockjaw Skullthumper · Rockjaw Ambushers = {npc:1116} Rockjaw Ambusher
	["Rockjaw Skullthumpers fill the quarry; Rockjaw Ambushers by {area:212} drop the {item:268548}."] = "바위턱일족 망치잡이가 채석장에 가득하고, {area:212} 옆의 바위턱일족 잠복꾼이 {item:268548}을(를) 떨어뜨립니다.",

	-- Step 47: Foreman Stonebrow and Quarrymaster Thesten
	-- {npc:1254} Foreman Stonebrow · {npc:1256} Quarrymaster Thesten
	["{npc:1254} and {npc:1256}"] = "{npc:1254}와(과) {npc:1256}",

	-- Step 48: Stolen Blasting Powder
	-- {area:212} Helm's Bed Lake · {quest:95214} Stolen Blasting Powder
	-- plural, as words: Rockjaw Ambushers = {npc:1116} Rockjaw Ambusher · Rockjaw Backbreakers = {npc:1118} Rockjaw Backbreaker
	["Rockjaw Ambushers by {area:212}, north of the quarry, and Rockjaw Backbreakers further east drop the {quest:95214}."] = "채석장 북쪽 {area:212} 옆의 바위턱일족 잠복꾼과 더 동쪽의 바위턱일족 투사가 {quest:95214}을(를) 떨어뜨립니다.",

	-- Step 49: Leopards and boars
	["Leopards and boars"] = "표범과 멧돼지",
	-- {item:2770} Copper Ore
	-- plural, as words: Snow Leopards = {npc:1201} Snow Leopard · Blacksmiths = {area:3421} Blacksmith · Copper Bars = {item:2840} Copper Bar
	["Snow Leopards and boars roam the snow between the ranch and the quarry. Blacksmiths: Copper Bars come from smelting {item:2770} or the trade vendors."] = "눈표범과 멧돼지가 농장과 채석장 사이 눈밭을 돌아다닙니다. 대장장이: 구리 주괴는 {item:2770}을(를) 제련하거나 직업용품 상인에게서 구합니다.",

	-- Step 52: North Gate Outpost
	-- {npc:1960} Pilot Hammerfoot · {area:808} North Gate Outpost
	["{npc:1960} waits at the {area:808}; the dwarven corpse lies up the pass to the west of him."] = "{npc:1960}은(는) {area:808}에서 기다립니다. 드워프의 시체는 그 서쪽 고갯길 위에 있습니다.",

	-- Step 53: Hearth to Kharanos
	-- {area:131} Kharanos
	["Hearth to {area:131}"] = "{area:131}(으)로 귀환",
	-- {npc:1231} Grif Wildheart
	["{npc:1231}, at the smithy"] = "{npc:1231}, 대장간에서",
	-- {npc:258113} Ingrid Dunwald · {npc:257597} Bruegs Kindleborn
	["{npc:258113}: {npc:257597} by the South Gate takes it"] = "{npc:258113}: 남문 옆 {npc:257597}에게 제출합니다",
	-- {npc:1226} Maxan Anvol · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["{npc:1226}: {npc:376} in {zone:1453} takes it"] = "{npc:1226}: {zone:1453}의 {npc:376}에게 제출합니다",
	-- {npc:1226} Maxan Anvol · {npc:258785} High Priestess Mims · {zone:1455} Ironforge
	["{npc:1226}: {npc:258785} in {zone:1455} takes it"] = "{npc:1226}: {zone:1455}의 {npc:258785}에게 제출합니다",

	-- Step 54: Taming the Beast
	-- {item:15908} Taming Rod · {area:131} Kharanos
	-- plural, as words: Large Crag Boars = {npc:1126} Large Crag Boar · Snow Leopards = {npc:1201} Snow Leopard · Ice Claw Bears = {npc:1196} Ice Claw Bear
	["Each of Grif Wildheart's quests hands you a {item:15908}: use it on the beast he names, then bring the rod back to him at the {area:131} smithy. Large Crag Boars, Snow Leopards and Ice Claw Bears all roam the fields just south and east of {area:131}."] = "그리프 와일드하트의 퀘스트마다 {item:15908}을(를) 줍니다. 그가 지정한 야수에게 사용한 뒤, {area:131} 대장간의 그에게 막대를 가져가세요. 큰 바위멧돼지, 눈표범, 얼음발톱흰곰 모두 {area:131} 바로 남쪽과 동쪽 들판을 돌아다닙니다.",
	-- {npc:1126} Large Crag Boar · {item:15908} Taming Rod
	["{npc:1126}: tame it with the {item:15908}"] = "{npc:1126}: {item:15908}(으)로 길들이세요",
	-- {npc:1201} Snow Leopard · {item:15908} Taming Rod
	["{npc:1201}: tame it with the {item:15908}"] = "{npc:1201}: {item:15908}(으)로 길들이세요",
	-- {npc:1196} Ice Claw Bear · {item:15908} Taming Rod
	["{npc:1196}: tame it with the {item:15908}"] = "{npc:1196}: {item:15908}(으)로 길들이세요",
	-- {npc:10090} Belia Thundergranite · {zone:1455} Ironforge
	["{npc:10090} in {zone:1455} takes it"] = "{zone:1455}의 {npc:10090}에게 제출합니다",

	-- Step 55: Shimmerweed
	-- {item:2676} Shimmerweed · {area:137} Brewnall Village
	["{item:2676} bushes grow on the hills around {area:137}."] = "{item:2676} 덤불은 {area:137} 주변 언덕에 자랍니다.",

	-- Step 58: South Gate Outpost
	-- {area:806} South Gate Outpost · {zone:1432} Loch Modan
	["Follow the road all the way east to the {area:806} at the {zone:1432} tunnel."] = "길을 따라 동쪽 끝까지 가서 {zone:1432} 굴 앞의 {area:806}(으)로 가세요.",

	-- Step 59: Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn · {area:806} South Gate Outpost
	["{npc:257597} waits in a cave above the farm north-west of the {area:806}; the path up starts behind the farm."] = "{npc:257597}은(는) {area:806} 북서쪽 농장 위의 동굴에서 기다립니다. 올라가는 길은 농장 뒤에서 시작합니다.",

	-- Step 60: Braldir Ashmantle
	-- {zone:1432} Loch Modan · {npc:257808} Braldir Ashmantle
	["Go through the tunnel into {zone:1432}. Just past it, a path marked by stones climbs the hills on the right of the road north to {npc:257808}'s camp."] = "굴을 지나 {zone:1432}에 들어가세요. 굴을 지나자마자 돌로 표시된 길이 북쪽으로 가는 길 오른편 언덕을 올라 {npc:257808}의 야영지로 이어집니다.",

	-- Step 61: Fire Tar and the Reagent Pouch
	-- {item:5026} Fire Tar · {item:6652} Reagent Pouch
	["{item:5026} and the {item:6652}"] = "{item:5026}와(과) {item:6652}",
	-- {area:923} Stonesplinter Valley · {npc:257808} Braldir Ashmantle · {area:149} Silver Stream Mine
	-- plural, as words: Stonesplinter Seers = {npc:1166} Stonesplinter Seer · Tunnel Rat Geomancers = {npc:1174} Tunnel Rat Geomancer
	["Stonesplinter Seers (level 13) stand among the troggs in the south of {area:923}, south of {npc:257808}; Tunnel Rat Geomancers (level 12) work the {area:149} at the north end of the loch. The troggs come in packs and some throw from range: pull one at a time."] = "가루바위일족 점쟁이(13레벨)는 {npc:257808} 남쪽, {area:923} 남부의 트로그들 사이에 서 있고, 동굴쥐일족 흙점쟁이(12레벨)는 호수 북쪽 끝의 {area:149}에서 일합니다. 트로그는 무리 지어 다니고 일부는 원거리 공격을 합니다. 하나씩 끌어오세요.",
	-- {item:6652} Reagent Pouch
	-- plural, as words: Stonesplinter Seers = {npc:1166} Stonesplinter Seer
	["{item:6652}: Stonesplinter Seers"] = "{item:6652}: 가루바위일족 점쟁이",
	-- {item:5026} Fire Tar
	-- plural, as words: Tunnel Rat Geomancers = {npc:1174} Tunnel Rat Geomancer
	["{item:5026}: Tunnel Rat Geomancers"] = "{item:5026}: 동굴쥐일족 흙점쟁이",

	-- Step 62: The Fire Spirit Stone
	["The Fire Spirit Stone"] = "불의 정령석",
	-- {npc:257808} Braldir Ashmantle · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember · {object:61934} Brazier of the Dormant Flame
	["{npc:257808} gives you the {item:6636}. Climb to the peak above his camp, drink the Sapta beside the Spirit Stone and defeat the {npc:5893}, then place its {item:6655} in the {object:61934}, atop the Shrine of Eternal Flame."] = "{npc:257808}이(가) {item:6636}을(를) 줍니다. 그의 야영지 위 봉우리로 올라가 정령석 옆에서 삽타를 마시고 {npc:5893}을(를) 물리친 뒤, 영원의 불꽃 제단 꼭대기의 {object:61934}에 {item:6655}을(를) 넣으세요.",
	-- {item:6636} Fire Sapta
	["{item:6636}, beside the Spirit Stone"] = "{item:6636}, 정령석 옆",

	-- Step 63: Back to Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn
	["Back to {npc:257597}"] = "{npc:257597}에게 돌아가기",
	-- {npc:257597} Bruegs Kindleborn
	["Back through the tunnel to {npc:257597}' cave above the farm."] = "굴을 지나 농장 위 {npc:257597}의 동굴로 돌아가세요.",
	-- {npc:257597} Bruegs Kindleborn · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:257597}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:257597}: {npc:2523}, {item:5176}, {item:263412}",

	-- Step 64: Earthseer Farsen
	-- {area:134} Gol'Bolar Quarry
	["Farsen camps on the ridge overlooking the {area:134} from the west. Talk to him for his farsight."] = "파르센은 서쪽에서 {area:134}을(를) 내려다보는 능선에 진을 치고 있습니다. 그에게 말을 걸어 원시를 받으세요.",
	-- {npc:1977} Senator Mehr Stonehallow
	["{npc:1977}, in the quarry"] = "{npc:1977}, 채석장 안",

	-- Step 65: Spies and Bonesnappers
	["Spies and Bonesnappers"] = "첩자와 뼈다귀싸움꾼",
	-- {area:212} Helm's Bed Lake · {item:274268} Dark Iron Map
	-- plural, as words: Rockjaw Bonesnappers = {npc:1117} Rockjaw Bonesnapper
	["Rockjaw Bonesnappers prowl the quarry and {area:212}; Dark Iron Spies sneak around the lake shore. One spy drops the {item:274268}."] = "{npc:1117}은(는) 채석장과 {area:212}을(를) 어슬렁거리고, 검은무쇠단 비밀요원은 호숫가를 몰래 돌아다닙니다. 비밀요원 하나가 {item:274268}을(를) 떨어뜨립니다.",

	-- Step 68: Tundra MacGrann
	-- {npc:1266} Tundra MacGrann · {area:801} Chill Breeze Valley · {npc:1271} Old Icebeard
	["{npc:1266} camps in {area:801}, south of Brewnall. His meats are in the locker in {npc:1271}'s cave to the north-east of his camp: grab them and leave quickly."] = "{npc:1266}은(는) 브루날 마을 남쪽 {area:801}에 진을 치고 있습니다. 그의 고기는 야영지 북동쪽 {npc:1271}의 동굴 안 보관함에 있습니다. 챙겨서 빨리 나오세요.",

	-- Step 69: The Tome of Divinity
	-- {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {npc:5149} Brandur Ironhammer · {npc:6179} Tiza Battleforge · {npc:6178} Muiredon Battleforge · {object:32386} Hall of Mysteries (no name in this language: may be words) · {npc:6175} John Turner · {item:2589} Linen Cloth · {zone:1426} Dun Morogh
	["Follow the road up to {zone:1455} and take the {object:32362}: {npc:5149}, {npc:6179} and {npc:6178} are in the {object:32386}. {npc:6175}, a beggar, wanders the city. He asks for ten {item:2589}: the troggs and trolls of {zone:1426} drop it, and the Auction House sells it."] = "길을 따라 {zone:1455}(으)로 올라가 {object:32362}(으)로 가세요. {npc:5149}, {npc:6179}, {npc:6178}은(는) {object:32386}에 있습니다. 거지인 {npc:6175}은(는) 도시를 돌아다닙니다. 그는 {item:2589} 10개를 요구합니다. {zone:1426}의 트로그와 트롤이 떨어뜨리고, 경매장에서도 팝니다.",
	-- {quest:2997} Tome of Divinity
	["From the {quest:2997} she gives you"] = "그녀가 주는 {quest:2997}에서",

	-- Step 70: Narm Faulk
	-- {zone:1455} Ironforge · {area:212} Helm's Bed Lake · {npc:6177} Narm Faulk · {item:6866} Symbol of Life
	["Ride back out of {zone:1455} and east along the road to {area:212}. {npc:6177} lies dead by its shore: use the {item:6866} on him. The Dark Iron Spies sneaking around the lake carry the script."] = "{zone:1455}에서 나와 길을 따라 동쪽으로 {area:212}까지 가세요. {npc:6177}은(는) 호숫가에 죽어 있습니다. 그에게 {item:6866}을(를) 사용하세요. 호수 주변을 몰래 돌아다니는 검은무쇠단 비밀요원이 문서를 가지고 있습니다.",
	-- {item:6866} Symbol of Life · {npc:6177} Narm Faulk
	["Use the {item:6866} on {npc:6177}"] = "{npc:6177}에게 {item:6866}을(를) 사용하세요",
	-- {item:6847} Dark Iron Script
	["{item:6847}: Dark Iron Spies"] = "{item:6847}: 검은무쇠단 비밀요원",

	-- Step 71: Muiredon Battleforge
	-- {npc:6179} Tiza Battleforge
	["{npc:6179}: Redemption"] = "{npc:6179}: 구원",

	-- Step 72: Ironforge class quests
	-- {zone:1455} Ironforge
	["{zone:1455} class quests"] = "{zone:1455} 직업 퀘스트",
	-- {npc:10090} Belia Thundergranite · {object:32390} Hall of Arms (no name in this language: may be words) · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {npc:6120} Lago Blackwrench · {object:32383} Forlorn Cavern
	["{npc:10090} is in the {object:32390}, {npc:258785} in the {object:32386}, {npc:6120} in the {object:32383}."] = "{npc:10090}은(는) {object:32390}에, {npc:258785}은(는) {object:32386}에, {npc:6120}은(는) {object:32383}에 있습니다.",
	-- {npc:6120} Lago Blackwrench · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind
	["{npc:6120}: {npc:6122} in {zone:1453} takes it"] = "{npc:6120}: {zone:1453}의 {npc:6122}에게 제출합니다",

	-- Step 73: The Deeprun Tram
	-- {area:2257} Deeprun Tram
	["The {area:2257}"] = "{area:2257}",
	-- {zone:1455} Ironforge · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind
	["Follow the road up to {zone:1455} and train with your class trainer. The {area:2257} leaves from {object:171524}, in the east of the city. Ride it to {zone:1453}."] = "길을 따라 {zone:1455}(으)로 올라가 직업 상급자에게 훈련을 받으세요. {area:2257}은(는) 도시 동쪽의 {object:171524}에서 출발합니다. 그것을 타고 {zone:1453}(으)로 가세요.",
	-- {object:660964} Misplaced Packages · {object:171524} Tinker Town
	["{object:660964}, by the mailbox in {object:171524}"] = "{object:660964}, {object:171524}의 우체통 옆",
	-- {npc:258098} Eldrun Stormbreaker · {object:32372} Great Forge (no name in this language: may be words)
	["{npc:258098}, the shaman trainer, north of the {object:32372}"] = "{npc:258098}, 주술사 상급자, {object:32372} 북쪽",

	-- Step 74: Defensive Stance
	-- {object:28027} Dwarven District · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern
	["The tram arrives in the {object:28027}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "지하철은 {object:28027}에 도착합니다. {npc:5480}은(는) {object:2100}에서 전사를 훈련시킵니다. {npc:6089}와(과) {npc:6090}은(는) 그곳 {object:2152} 옆에 함께 서 있습니다. {npc:6090}은(는) 자기 잔을 걸고 당신과 싸웁니다.",

	-- Step 75: Desperate Prayer
	-- {npc:376} High Priestess Laurena
	["{npc:376} is in the Cathedral of Light."] = "{npc:376}은(는) 빛의 대성당에 있습니다.",

	-- Step 76: Gakin the Darkbinder
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["{npc:6122} waits in the cellar of the {object:2164}, in the {object:2101}."] = "{npc:6122}은(는) {object:2101}에 있는 {object:2164}의 지하실에서 기다립니다.",

	-- Step 77: Surena Caledon
	-- {zone:1453} Stormwind · {area:87} Goldshire · {area:62} Brackwell Pumpkin Patch · {npc:881} Surena Caledon
	["Leave {zone:1453} by the main gate, go south to {area:87} and east along the road to the {area:62}. {npc:881} (level 9) stands by its farmhouse."] = "정문으로 {zone:1453}을(를) 나가 남쪽으로 {area:87}까지 간 뒤, 길을 따라 동쪽으로 {area:62}까지 가세요. {npc:881}(9레벨)은(는) 농가 옆에 서 있습니다.",

	-- Step 78: The Binding
	-- {npc:6122} Gakin the Darkbinder · {item:6928} Bloodstone Choker · {object:2164} Slaughtered Lamb · {zone:1436} Westfall · {area:87} Goldshire
	["Back to {npc:6122}. Use the {item:6928} at the summoning circle in the {object:2164}'s cellar and defeat the voidwalker it calls. {zone:1436} is next, west of {area:87}."] = "{npc:6122}에게 돌아가세요. {object:2164} 지하실의 소환진에서 {item:6928}을(를) 사용하고 나타나는 공허방랑자를 물리치세요. 다음은 {area:87} 서쪽의 {zone:1436}입니다.",
	["Subdue the voidwalker"] = "공허방랑자 제압",

	-- Step 79: Jennea Cannon
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {quest:1861} Mirror Lake
	["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}; she gives you a flask for the {quest:1861} waterfall."] = "{npc:5497}은(는) {object:2101}의 탑인 마법사의 성소에 서 있습니다. 그녀가 {quest:1861} 폭포용 플라스크를 줍니다.",

	-- Step 80: Mirror Lake
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {zone:1436} Westfall · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {zone:1436}: fill {item:7207} at its base."] = "정문으로 {zone:1453}을(를) 나가세요. {quest:1861} 폭포는 성문 남서쪽, 서쪽 {zone:1436}(으)로 가는 길에 있습니다. 폭포 아래에서 {item:7207}을(를) 채우세요.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to Gakin. Use the {item:6928} at the summoning circle in the {object:2164}'s cellar and defeat the voidwalker it calls. {zone:1436} is next, west of {area:87}."] = "가킨에게 돌아가세요. {object:2164} 지하실의 소환진에서 {item:6928}을(를) 사용하고 나타나는 공허방랑자를 물리치세요. 다음은 {area:87} 서쪽의 {zone:1436}입니다.",
	-- ["Braldir gives you the {item:6636}. Climb to the peak above his camp, drink the Sapta beside the Spirit Stone and defeat the {npc:5893}, then place its {item:6655} in the {object:61934}, atop the Shrine of {object:148418}."] = "Braldir가 {item:6636}을(를) 줍니다. 그의 야영지 위 봉우리로 올라가 정령석 옆에서 삽타를 마시고 {npc:5893}을(를) 물리친 뒤, {object:148418} 제단 꼭대기의 {object:61934}에 {item:6655}을(를) 넣으세요.",
	-- ["Leave {zone:1453} by the main gate, go south to {area:87} and east along the road to the {area:62}. {quest:1688} (level 9) stands by its farmhouse."] = "정문으로 {zone:1453}을(를) 나가 남쪽으로 {area:87}까지 간 뒤, 길을 따라 동쪽으로 {area:62}까지 가세요. {quest:1688}(9레벨)은(는) 농가 옆에 서 있습니다.",
}
