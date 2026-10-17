-- Korean (koKR): the guide forever/alliance/50-60/03-winterspring (forever/alliance/50-60/03-winterspring.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Everlook
	-- {npc:11629} Jessica Redpath · {area:2262} Darrowshire
	["{npc:11629}: keep it for {area:2262}"] = "{npc:11629}: {area:2262}을(를) 위해 보관하세요",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}: keep both for the Plaguelands"] = "{npc:10431}: 둘 다 역병지대를 위해 보관하세요",

	-- Step 2: Starfall Village
	["Ride west along the road to the night elf village."] = "길을 따라 서쪽으로 나이트 엘프 마을까지 가세요.",

	-- Step 3: The Ruins of Kel'Theril
	-- {area:2253} Starfall Village
	-- plural, as words: Moontouched Feathers = {item:12383} Moontouched Feather
	["The ruins lie around the frozen lake south of {area:2253}. Pick up the four relic fragments lying in the ruins and the Moontouched Feathers on the ground where the wildkin roam."] = "폐허는 {area:2253} 남쪽의 얼어붙은 호수 주변에 있습니다. 폐허에 놓인 유물 조각 네 개를 줍고, 올빼미야수가 돌아다니는 땅에서 달빛 깃든 깃털을 주우세요.",

	-- Step 4: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Follow the road west to {npc:9298}'s camp beside the hot springs."] = "길을 따라 서쪽으로 온천 옆 {npc:9298}의 야영지까지 가세요.",
	-- {zone:1444} Feralas
	["Keep it: Gregan in {zone:1444} brews the elixir later"] = "보관하세요: 나중에 {zone:1444}의 그레간이 비약을 만듭니다",

	-- Step 5: Salfa
	-- {npc:11556} Salfa · {area:1769} Timbermaw Hold · {npc:9298} Donova Snowden
	["{npc:11556} guards the mouth of {area:1769}, north-west of {npc:9298}."] = "{npc:11556}은(는) {npc:9298} 북서쪽의 {area:1769} 입구를 지킵니다.",

	-- Step 6: The Winterfall camp
	["The Winterfall camp"] = "눈사태일족 야영지",
	-- {npc:11556} Salfa · {npc:9298} Donova Snowden · {item:12771} Empty Firewater Flask · {quest:8471} Winterfall Ritual Totem · {quest:6031} Runecloth
	["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Any furbolg here can drop an {item:12771} (about one in ten) and, rarely, a {quest:8471}: right-click whichever drops. Keep the {quest:6031} the furbolgs drop for Meilosh."] = "서쪽 눈사태일족 야영지는 {npc:11556}와(과) {npc:9298} 사이의 언덕에 있습니다. 이곳의 펄볼그는 누구든 {item:12771}(약 10분의 1 확률)을, 드물게 {quest:8471}을(를) 떨어뜨릴 수 있습니다. 떨어진 것을 오른쪽 클릭하세요. 펄볼그가 떨어뜨리는 {quest:6031}은(는) 메일로쉬를 위해 보관하세요.",
	-- {item:12771} Empty Firewater Flask
	["{item:12771}, a rare drop"] = "{item:12771}, 드문 전리품",
	-- {quest:8471} Winterfall Ritual Totem
	["{quest:8471}, a rare drop"] = "{quest:8471}, 드문 전리품",
	-- {area:1769} Timbermaw Hold
	["For Kernda in {area:1769}: keep it"] = "{area:1769}의 케른다에게: 보관하세요",
	-- {quest:6031} Runecloth
	["{quest:6031}, for Meilosh later"] = "{quest:6031}, 나중에 메일로쉬에게",

	-- Step 7: Donova Snowden
	-- {zone:1448} Felwood
	["The Deadwood cauldron in {zone:1448}: keep it"] = "{zone:1448}의 마른가지일족 가마솥: 보관하세요",

	-- Step 8: Winterfall Village
	-- {area:2255} Everlook · {npc:10738} High Chief Winterfall
	["The Winterfall furbolg village lies east of {area:2255}: Shaman (56-57), Den Watchers (55-56) and Ursa (57-58), all above you. Kill the Shaman first, they heal, and pull from the edge. {npc:10738} in the cave at the back is elite: stay out."] = "눈사태일족 펄볼그 마을은 {area:2255} 동쪽에 있습니다. 주술사(56-57), 보초(55-56), 펄볼그(57-58) 모두 당신보다 높습니다. 치유하는 주술사를 먼저 처치하고, 가장자리부터 끌어오세요. 뒤쪽 동굴의 {npc:10738}은(는) 정예이니 들어가지 마세요.",

	-- Step 9: The Ice Thistle Hills
	-- {area:2247} Ice Thistle Hills
	["The {area:2247}"] = "{area:2247}",
	-- {area:2244} Winterfall Village · {area:2255} Everlook
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["Ice Thistle yetis live in the hills south of {area:2244}, Chillwind Chimaeras in the valley toward {area:2255}."] = "얼음엉겅퀴설인은 {area:2244} 남쪽 언덕에, 서리바람 키메라는 {area:2255} 쪽 계곡에 삽니다.",

	-- Step 11: Optional: Sunken Temple
	-- {area:1417} Sunken Temple
	["Optional: {area:1417}"] = "선택: {area:1417}",
	-- {area:1417} Sunken Temple · {area:2255} Everlook
	["Short of level 54 after the yetis? Running the {area:1417} (50-54) instead of grinding gets you there faster in a group. Come back to {area:2255} afterwards."] = "설인 사냥 후에도 54레벨이 안 되나요? 사냥 대신 파티로 {area:1417}(50-54)을(를) 돌면 더 빨리 도달합니다. 그 후 {area:2255}(으)로 돌아오세요.",

	-- Step 12: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "온전한 설인 뿔",
	-- plural, as words: Ice Thistle Matriarchs = {npc:7459} Ice Thistle Matriarch
	["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns. Keep killing yetis until level 54: Harlo's wildkin quests are red before that."] = "언덕으로 돌아가세요. 맹렬한 얼음엉겅퀴설인과 덩치큰 얼음엉겅퀴설인만 뿔을 지니고 있습니다. 54레벨이 될 때까지 설인을 계속 처치하세요. 그 전에는 하를로의 올빼미야수 퀘스트가 빨간색입니다.",
	-- {npc:7460} Ice Thistle Patriarch · {area:2247} Ice Thistle Hills · {zone:1452} Winterspring
	["grind on {npc:7460} at the {area:2247}, {zone:1452}"] = "{zone:1452}의 {area:2247}에서 {npc:7460}을(를) 사냥하세요",

	-- Step 13: Everlook
	-- {npc:10978} Legacki
	["On {npc:10978}, by the inn"] = "{npc:10978}에게, 여관 옆",
	-- {npc:10978} Legacki · {npc:7583} Sprinkle · {npc:10977} Quixxil
	["{npc:10978}: {npc:7583} and {npc:10977} come later"] = "{npc:10978}: {npc:7583}와(과) {npc:10977}은(는) 나중에",

	-- Step 14: Starfall Village
	-- {npc:10301} Jaron Stoneshaper
	["Ride west along the road to {npc:10301}."] = "길을 따라 서쪽으로 {npc:10301}에게 가세요.",

	-- Step 15: Jaron Stoneshaper's camp
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s camp"] = "{npc:10301}의 야영지",
	-- {npc:10301} Jaron Stoneshaper · {area:2245} Mazthoril
	["Ride south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "계곡을 따라 남동쪽으로 내려가 {area:2245}의 눈 속에 있는 {npc:10301}의 부서진 상자로 가세요. 부서진 마차가 그 바로 동쪽에 있습니다.",

	-- Step 16: Jaron Stoneshaper's supplies
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s supplies"] = "{npc:10301}의 보급품",
	-- {npc:10301} Jaron Stoneshaper
	["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "마차 주변의 보급품을 줍고, 근처 올빼미야수에게서 {npc:10301}의 목걸이를 되찾으세요.",

	-- Step 17: Darkwhisper Gorge
	-- {npc:9298} Donova Snowden · {area:2256} Darkwhisper Gorge
	["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "{npc:9298}의 안내를 따라 서리망치거인들을 지나 {area:2256} 입구로 가세요. 거인은 하나씩 지나가세요.",

	-- Step 18: Starfall Village
	["Ride north-west back to the village."] = "북서쪽으로 마을까지 돌아가세요.",

	-- Step 21: Winterfall Spirit Beads
	["The western Winterfall furbolgs drop the beads."] = "서쪽 눈사태일족 펄볼그가 구슬을 떨어뜨립니다.",

	-- Step 23: Chillwind Camp
	-- {area:1769} Timbermaw Hold · {zone:1448} Felwood · {area:442} Auberdine · {area:150} Menethil Harbor · {area:271} Southshore · {area:3197} Chillwind Camp
	["Walk through {area:1769} to {zone:1448} and fly on to the Eastern Kingdoms ({area:442}, the boat to {area:150}). Fly to {area:271} and ride north up the road through Alterac to {area:3197}."] = "{area:1769}을(를) 지나 {zone:1448}(으)로 간 뒤 동부 왕국으로 날아가세요({area:442}, {area:150}행 배). {area:271}(으)로 날아가 알터랙을 지나는 길을 따라 북쪽으로 {area:3197}까지 가세요.",

	-- Step 24: Pamela Redpath
	-- {zone:1423} Eastern Plaguelands · {area:2262} Darrowshire · {npc:10926} Pamela Redpath
	["Follow the southern road east into the {zone:1423}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "남쪽 길을 따라 동쪽으로 {zone:1423}에 들어가세요. {area:2262}의 폐허는 그 남쪽에 있습니다. {npc:10926}의 유령은 남쪽 끝의 무너진 집 옆에서 놀고 있습니다.",

	-- Step 25: Pamela Redpath's doll
	-- {npc:10926} Pamela Redpath
	["{npc:10926}'s doll"] = "{npc:10926}의 인형",
	-- {area:2262} Darrowshire
	["The three pieces of the doll lie in the ruined houses of {area:2262}; picking one up can call out ghosts. Combine them into the doll."] = "인형 조각 세 개는 {area:2262}의 무너진 집들에 있습니다. 하나를 주울 때 유령이 나타날 수 있습니다. 조각을 합쳐 인형을 만드세요.",

	-- Step 26: Pamela Redpath
	-- {quest:5152} Auntie Marlene · {zone:1422} Western Plaguelands
	["{quest:5152}, in the {zone:1422}: keep it"] = "{quest:5152}, {zone:1422}에서: 보관하세요",

	-- Step 27: Light's Hope Chapel
	["Follow the road east across the zone to the chapel."] = "길을 따라 동쪽으로 지역을 가로질러 예배당까지 가세요.",
	-- {npc:11038} Caretaker Alen · {npc:12250} Zaeldarr the Outcast
	["{npc:11038}: {npc:12250} is a level 54 elite"] = "{npc:11038}: {npc:12250}은(는) 54레벨 정예입니다",

	-- Step 28: Corin's Crossing
	-- {area:2264} Corin's Crossing
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["The Scourge around {area:2264}, west of the chapel, drop both kinds of Scourgestone; Darrowshire Spirits rise from them: talk to each one to free it."] = "예배당 서쪽, {area:2264} 주변의 스컬지는 두 종류의 스컬지석을 모두 떨어뜨립니다. 그들에게서 {npc:11064}이(가) 솟아오르니 하나하나 대화해 풀어 주세요.",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "{npc:11064} 해방: 대화하기",

	-- Step 30: The Undercroft
	-- {npc:12250} Zaeldarr the Outcast · {area:2261} The Undercroft
	["{npc:12250} is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "{npc:12250}은(는) 정예이니 파티를 권장합니다. 그는 지역 남서쪽의 지하실인 {area:2261}의 맨 아래에서 기다립니다.",

	-- Step 31: Augustus the Touched
	-- {area:2627} Terrordale · {npc:12384} Augustus the Touched
	["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "북쪽으로 {area:2627}까지 가세요. {npc:12384}은(는) 무너진 오두막에 살고, 그의 영수증 장부는 근처의 무너진 여관에 있습니다.",

	-- Step 32: Light's Hope Chapel
	-- {area:3197} Chillwind Camp
	["The next guide starts here and flies to {area:3197}."] = "다음 가이드는 여기서 시작해 {area:3197}(으)로 날아갑니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Zaeldarr is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "잴다르는 정예이니 파티를 권장합니다. 그는 지역 남서쪽의 지하실인 {area:2261}의 맨 아래에서 기다립니다.",
}
