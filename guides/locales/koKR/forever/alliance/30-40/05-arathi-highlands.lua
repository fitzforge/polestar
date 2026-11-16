-- Korean (koKR): the guide forever/alliance/30-40/05-arathi-highlands (forever/alliance/30-40/05-arathi-highlands.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:327} Faldir's Cove
	["For characters of 35 to 37. {area:327}, where the naga and the professor's water elementals are 38-40, is a group stop: skip it if you are alone."] = "35~37레벨 캐릭터용입니다. 나가와 교수의 물의 정령이 38-40레벨인 {area:327}은(는) 파티용이니 혼자라면 건너뛰세요.",

	-- Step 1: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "{area:42}(으)로 날아가세요",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "",

	-- Step 3: Watcher Biggs
	-- {npc:5476} Watcher Biggs · {npc:217412} Amaryllis Webb · {quest:93176} My Little Friends
	["{npc:5476} guards the road junction in the west of the swamp. {npc:217412} stands a short way north of him.\n{npc:217412} may not be here on Forever: if {npc:217412} doesn't offer {quest:93176}, skip it."] = "",
	-- {npc:217412} Amaryllis Webb · {zone:1443} Desolace
	["{npc:217412}: three critters to catch in Arathi, {zone:1443} and Stranglethorn"] = "{npc:217412}: 아라시, {zone:1443}, 가시덤불 골짜기에서 잡을 동물 세 마리",

	-- Step 4: The western swamp
	["The western swamp"] = "서쪽 늪",
	-- plural, as words: Sorrow Spinners = {npc:858} Sorrow Spinner · Swamp Jaguars = {npc:767} Swamp Jaguar
	["Young crocolisks, Sorrow Spinners and Swamp Jaguars all roam the swamp around the road."] = "새끼 악어, 늪그물거미, 늪지재규어가 모두 길 주변 늪을 돌아다닙니다.",

	-- Step 6: Father Tuttle
	-- {npc:255597} Father Tuttle · {area:657} Harborage
	["North-west of Watcher Biggs, {npc:255597} (level 34) waits by the road: lead him north to the {area:657}, on your way there. Stay close to him and clear what attacks him; if he falls, abandon the quest and go on."] = "감시병 빅스 북서쪽 길가에서 {npc:255597}(34레벨)이(가) 기다립니다. 가는 길에 그를 북쪽의 {area:657}(으)로 호위하세요. 곁에 붙어 그를 공격하는 적을 처치하세요. 그가 죽으면 퀘스트를 포기하고 계속 가세요.",

	-- Step 7: Harborage
	-- {area:657} Harborage · {npc:254775} Karana · {npc:254770} Pelluk · {npc:1776} Magtoor · {area:76} Fallow Sanctuary
	-- plural, as words: Lost Ones = {npc:254797} Lost One
	["Follow the road north to the draenei of the {area:657}. {npc:254775} and {npc:254770} stand beside {npc:1776}: their Lost Ones are the ones you meet in the {area:76} anyway."] = "길을 따라 북쪽의 {area:657} 드레나이에게 가세요. {npc:254775}와(과) {npc:254770}은(는) {npc:1776} 옆에 서 있습니다. 그들의 드레노어 난민은 어차피 {area:76}에서 만나게 됩니다.",
	-- {npc:1776} Magtoor · {npc:255597} Father Tuttle
	["{npc:1776}: {npc:255597}'s escort"] = "{npc:1776}: {npc:255597} 호위",

	-- Step 8: Fallow Sanctuary
	-- {area:76} Fallow Sanctuary · {quest:1389} Draenethyst Crystals · {npc:254797} Lost One · {npc:254775} Karana · {npc:254770} Pelluk · {item:258530} Lucky Lure · {quest:1392} Noboru the Cudgel · {npc:1776} Magtoor
	-- plural, as words: Lost Ones = {npc:254797} Lost One
	["East along the road to the {area:76}. The {quest:1389} are the glowing blue crystals among the Lost Ones' tents: click them. Any {npc:254797} counts for {npc:254775}, and the Lost One Fishermen on the sanctuary's west side carry {npc:254770}'s {item:258530}. {quest:1392} walks a long path through the ruins; his cudgel starts a quest for {npc:1776}. Don't wait for him.\nCareful: Noboru is level 39, two over you here: fight him only with a friend or from level 38; otherwise let him pass."] = "길을 따라 동쪽의 {area:76}(으)로 가세요. {quest:1389}은(는) 드레노어 난민들의 천막 사이에서 빛나는 푸른 수정이니 클릭하세요. {npc:254797}은(는) 모두 {npc:254775}의 목표로 인정되며, 성역 서쪽의 드레노어 난민 낚시꾼이 {npc:254770}의 {item:258530}을(를) 가지고 있습니다. {quest:1392}은(는) 폐허를 지나는 긴 경로를 걸어 다니며, 그의 곤봉은 {npc:1776}의 퀘스트를 시작합니다. 그를 기다리지 마세요.\n주의: 노보루는 39레벨로 지금보다 두 레벨 높습니다. 친구와 함께이거나 38레벨 이상일 때만 싸우고, 아니면 그냥 보내세요.",
	-- {quest:1392} Noboru the Cudgel
	["from {quest:1392}: he walks a path through the ruins"] = "{quest:1392}에게서: 폐허를 지나는 길을 돌아다닙니다",
	-- {item:6071} Draenethyst Crystal
	["{item:6071}, the blue crystals by the tents"] = "{item:6071}, 천막 옆의 푸른 수정",
	-- {item:258530} Lucky Lure · {npc:757} Lost One Fisherman
	["{item:258530}, from a {npc:757}"] = "{item:258530}, {npc:757}에게서",
	-- plural, as words: Lost Ones = {npc:254797} Lost One
	["Lost Ones: Hunters, Muckdwellers, Seers and Riftseekers all count"] = "드레노어 난민: 사냥꾼, 진흙거주자, 선견자, 균열추적자 모두 해당됩니다",

	-- Step 9: The Lost Caravan
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	-- plural, as words: Lost Ones = {npc:254797} Lost One
	["The wrecked caravan's chest lies at the north end of the {area:76}, beside {npc:5391}'s cage.\nCareful: The camp is full of Lost Ones around level 38. They stand in linked groups of 2-3, many are casters, and they respawn quickly."] = "",

	-- Step 10: Galen Goodward
	-- {npc:5391} Galen Goodward
	-- plural, as words: Lost One Riftseekers = {npc:762} Lost One Riftseeker · Lost Ones = {npc:254797} Lost One
	["{npc:5391} is caged at the north end of the sanctuary. Free him and keep him alive on the walk out; his strongbox waits by the road afterwards. Careful: on the walk out the camp's Lost One Riftseekers (37-38) and their pets, with the Lost Ones around them, turn on {npc:5391}: clear the cage and the start of his path first, stay beside him and pull every attacker onto yourself. Many players lose him the first time; if he dies, abandon the quest and take it again at his cage."] = "{npc:5391}은(는) 성역 북쪽 끝에 갇혀 있습니다. 그를 풀어주고 나가는 동안 살려두세요. 그 후 그의 금고가 길가에서 기다립니다. 주의: 나가는 길에 야영지의 길 잃은 균열추적자(37-38)와 그들의 애완동물이 주변의 길 잃은 자들과 함께 {npc:5391}을(를) 공격합니다. 먼저 우리와 그가 갈 길의 시작 부분을 정리하고, 그의 곁에 머물며 모든 공격자를 자신에게 끌어오세요. 많은 플레이어가 처음에 그를 잃습니다. 그가 죽으면 퀘스트를 포기하고 그의 우리에서 다시 받으세요.",

	-- Step 11: Harborage
	-- {npc:5391} Galen Goodward · {area:657} Harborage
	["West along the road from {npc:5391}'s strongbox to the {area:657}."] = "",
	-- {npc:1776} Magtoor
	["{npc:1776}: Noboru's cudgel"] = "",
	-- {npc:1776} Magtoor · {quest:93464} The Visiting Mage · {npc:11863} Azore Aldamort · {zone:1443} Desolace
	["{npc:1776}: {quest:93464}, for {npc:11863} in {zone:1443}, on the {zone:1443} guide at the end of 30-40"] = "{npc:1776}: {quest:93464}, {zone:1443}의 {npc:11863}에게 전달, 30-40 마지막의 {zone:1443} 가이드에서",

	-- Step 12: Watcher Biggs
	-- {npc:5476} Watcher Biggs
	["South down the road to {npc:5476}, on the way west out of the swamp."] = "",

	-- Step 14: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "{zone:1453}(으)로 날아가세요",
	-- {zone:1430} Deadwind Pass · {area:42} Darkshire
	["Back west through {zone:1430} to {area:42}."] = "{zone:1430}을(를) 지나 서쪽으로 {area:42}까지 돌아가세요.",

	-- Step 15: Stormwind
	-- {npc:1141} Angus Stern · {area:17203} Stormwind Harbor
	["{npc:1141}, {area:17203} road"] = "{npc:1141}, {area:17203} 길",

	-- Step 16: The Binding
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {item:6913} Heartswood Core · {quest:65602} What Is Love? · {item:190309} Wooden Figurine
	["{npc:6122} waits in the {object:2164}'s cellar, in the {object:2101}. Use the {item:6913} at the summoning circle there and defeat the succubus it calls. If you took {quest:65602}, hand him the {item:190309} too, place it at the same circle and defeat the incubus."] = "{npc:6122}은(는) {object:2101}에 있는 {object:2164}의 지하실에서 기다립니다. 그곳 소환진에서 {item:6913}을(를) 사용하고 나타나는 서큐버스를 물리치세요. {quest:65602}을(를) 받았다면 그에게 {item:190309}도 건네고, 같은 소환진에 놓은 뒤 인큐버스를 물리치세요.",
	-- {npc:5677} Summoned Succubus
	["{npc:5677}, at the summoning circle"] = "",
	-- {quest:65602} What Is Love?
	["{quest:65602}, if you took it"] = "{quest:65602}, 받았다면",
	-- {npc:185335} Summoned Incubus
	["{npc:185335}, at the same circle"] = "{npc:185335}, 같은 소환진에서",
	-- {npc:6122} Gakin the Darkbinder
	["{npc:6122} binds the incubus to you"] = "{npc:6122}이(가) 인큐버스를 당신에게 귀속시킵니다",

	-- Step 17: Stormwind
	-- {npc:12336} Brother Crowley
	["{npc:12336}, Cathedral of Light"] = "{npc:12336}, 빛의 대성당",

	-- Step 19: Stormwind
	-- {npc:1440} Milton Sheaf
	["{npc:1440}, the Royal Library in the keep"] = "{npc:1440}, 성채 안 왕실 도서관",

	-- Step 20: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "",

	-- Step 21: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "{area:271}(으)로 날아가세요",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "{zone:1455} 비행 조련사",

	-- Step 22: Southshore
	-- {npc:2276} Magistrate Henry Maleb
	["{npc:2276}, inside, if 30-40/01 didn't take it: the Syndicate camp is on the way to Arathi"] = "{npc:2276}, 내부, 30-40/01에서 수락하지 않았다면: 비밀결사대 야영지는 아라시로 가는 길에 있습니다",

	-- Step 23: Shadowy Assassin
	-- {npc:2434} Shadowy Assassin · {area:271} Southshore · {npc:2276} Magistrate Henry Maleb
	["A {npc:2434} (37-38) lurks stealthed on the edge of {area:271}, and few players find him. Careful: he is a level or two over you; fight him only at full health, or leave him. His contract goes to {npc:2276}. Don't wait for him: the rest of this step doesn't need him."] = "{npc:2434}(37-38)이(가) {area:271} 외곽에 은신한 채 숨어 있어 그를 찾는 플레이어는 드뭅니다. 주의: 당신보다 한두 레벨 높습니다. 생명력이 가득할 때만 싸우거나 그냥 두세요. 그의 계약서는 {npc:2276}에게 가져갑니다. 그를 기다리지는 마세요. 이 단계의 나머지는 그가 없어도 됩니다.",
	-- {npc:2434} Shadowy Assassin
	["{npc:2434}, if you spot him"] = "{npc:2434}, 발견한 경우",
	-- {npc:2276} Magistrate Henry Maleb
	["{npc:2276}, inside"] = "",

	-- Step 25: Alterac Mountains
	["Syndicate camp"] = "비밀결사대 야영지",

	-- Step 26: Syndicate camp
	-- {area:271} Southshore · {area:272} Tarren Mill
	-- plural, as words: Syndicate Wizards = {npc:2319} Syndicate Wizard
	["North out of {area:271} to the Syndicate camp on the Alterac border, west of {area:272} (Horde): its Footpads and Thieves are the Syndicate Maleb wants, and the documents lie in the camp. Then back to the road and east to Arathi.\nCareful: a few Syndicate Wizards (34-35) stand among the tents and cast from range: pull them one at a time."] = "{area:271}에서 북쪽으로 나가 {area:272}(호드) 서쪽, 알터랙 경계의 비밀결사대 야영지로 가세요. 그곳의 노상강도와 도둑이 말레브가 원하는 비밀결사대이며, 문서는 야영지에 있습니다. 그다음 길로 돌아가 동쪽 아라시로 가세요.\n주의: 비밀결사대 마술사(34-35) 몇 명이 천막 사이에 서서 원거리 주문을 시전합니다. 한 번에 하나씩 끌어오세요.",

	-- Step 28: Refuge Pointe
	-- {area:1057} Thoradin's Wall · {area:320} Refuge Pointe
	["From the Syndicate camp, follow the road east over {area:1057} to {area:320}."] = "비밀결사대 야영지에서 길을 따라 동쪽으로 {area:1057}을(를) 넘어 {area:320}까지 가세요.",
	-- {npc:2700} Captain Nials · {npc:1075} Rhag Garmason
	["{npc:2700}: {npc:1075}'s plea, from 01-hillsbrad-foothills"] = "",

	-- Step 29: Northfold Manor
	-- {area:320} Refuge Pointe
	["The Syndicate hold the farm north-west of {area:320}.\nCareful: Syndicate Highwaymen are level 30-31 and can cast Sneak while out of combat, so they are often stealthed and hard to spot."] = "",

	-- Step 30: Hay Weevil
	-- {quest:681} Northfold Manor · {npc:217412} Amaryllis Webb · {item:213565} Entomology Starter Kit
	-- plural, as words: Hay Weevils = {npc:217589} Hay Weevil
	["Hay Weevils crawl about the north end of {quest:681}'s farm: catch one with the tool from {npc:217412}'s {item:213565}."] = "",

	-- Step 31: Shards of Myzrael
	-- {quest:681} Northfold Manor · {area:333} Circle of East Binding · {area:314} Go'Shek Farm
	["East from {quest:681} across the north of the Highlands; the shards glitter on the hill by the {area:333}, north of {area:314}."] = "{quest:681}에서 동쪽으로 고원 북부를 가로지르세요. 파편은 {area:314} 북쪽, {area:333} 옆 언덕에서 반짝입니다.",
	["Only if Gluggle gave you the pendant in Stranglethorn"] = "가시덤불 골짜기에서 글루글에게 펜던트를 받은 경우에만",

	-- Step 32: Drywhisker Gorge: kill these as you meet them
	-- {area:318} Drywhisker Gorge
	["{area:318}: kill these as you meet them"] = "",
	-- {area:321} Hammerfall · {skill:186} Mining
	-- plural, as words: Lesser Bloodstone Deposits = {object:2653} Lesser Bloodstone Deposit
	["The Drywhisker kobolds dig in the gorge east of {area:321} (Horde); skirt the town to the north. They drop the Motes of Myzrael, not Krazek's ore. Lesser Bloodstone Deposits need {skill:186} 75: mine four ore, buy them at the Auction House, or ask a miner friend. The ore goal is optional; continue with Myzrael if you cannot get it. Careful: Every kobold type runs off for help when low on health (Kobolds at 30%, Surveyors and Diggers at 15%), which can pull more of them."] = "마른수염 코볼트는 {area:321}(호드) 동쪽 협곡에서 땅을 팝니다. 마을은 북쪽으로 돌아가세요. 이들은 미즈라엘의 결정 파편을 떨어뜨리지만, 크라제크의 광석은 떨어뜨리지 않습니다. 저급 혈석 광맥은 {skill:186} 75가 필요합니다. 광석 4개를 캐거나, 경매장에서 사거나, 채광하는 친구에게 부탁하세요. 광석 목표는 선택 사항입니다. 구할 수 없으면 미즈라엘 퀘스트를 계속하세요. 주의: 모든 코볼트는 생명력이 낮아지면 도움을 청하러 도망가므로(코볼트는 30%, 흙점쟁이와 채굴꾼은 15%) 더 많이 끌려올 수 있습니다.",
	-- {item:4435} Mote of Myzrael · {npc:2572} Drywhisker Kobold · {npc:2573} Drywhisker Surveyor · {npc:2574} Drywhisker Digger
	["{item:4435} from {npc:2572}, {npc:2573} and {npc:2574}, by this stop"] = "",

	-- Step 33: Iridescent Shards
	-- {area:318} Drywhisker Gorge
	["The shards lie at the far end of {area:318}."] = "파편은 {area:318}의 맨 끝에 있습니다.",
	["Below ground"] = "지하",

	-- Step 34: Iridescent Shards
	-- {quest:651} Stones of Binding · {object:2691} Stone of East Binding
	-- plural, as words: Cresting Exiles = {npc:2761} Cresting Exile
	["{quest:651} is a group quest at this level: three Cresting Exiles (38-39) guard the {object:2691} and attack together. Grouping up is encouraged, look for people to do it with. Skip it if you are alone."] = "{quest:651}은(는) 이 레벨에서 파티 퀘스트입니다. 떠도는 물의 정령(38-39) 셋이 {object:2691}을(를) 지키며 함께 공격합니다. 파티를 권장하니 함께할 사람을 찾아보세요. 혼자라면 건너뛰세요.",

	-- Step 35: Witherbark Village
	-- {area:318} Drywhisker Gorge · {area:314} Go'Shek Farm · {area:317} Witherbark Village
	["South from {area:318}, past {area:314}, to {area:317} in the hills: the Witch Doctors stand among the huts and the Shadow Hunters guard the far end of the valley. Every troll can drop a tusk."] = "{area:318}에서 남쪽으로 {area:314}을(를) 지나 언덕의 {area:317}까지 가세요. 의술사는 오두막 사이에 서 있고, 어둠사냥꾼은 계곡 맨 끝을 지킵니다. 모든 트롤이 엄니를 떨어뜨릴 수 있습니다.",
	-- {item:5040} Shadow Hunter Knife
	["{item:5040}; below ground"] = "",

	-- Step 36: Quae
	-- {npc:2712} Quae · {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["North-west out of the Witherbark valley; {npc:2712} and {npc:2713} camp in the hills just north of {area:314}."] = "마른나무껍질 계곡을 나와 북서쪽으로 가세요. {npc:2712}와(과) {npc:2713}은(는) {area:314} 바로 북쪽 언덕에 진을 치고 있습니다.",

	-- Step 37: Forsaken Courier
	-- {area:314} Go'Shek Farm
	["The courier walks the road from {area:314} west across the Highlands, as far as about 24,45, and back, with two guards: the arrow follows the road west until you meet him. Pull them off the road."] = "급사는 경비병 둘과 함께 {area:314}에서 서쪽으로 고원을 가로질러 약 24,45까지 길을 걸었다가 되돌아옵니다. 그를 만날 때까지 화살표가 서쪽으로 길을 따라갑니다. 길에서 끌어내세요.",

	-- Step 39: Quae and Kinelory
	-- {npc:2712} Quae · {npc:2713} Kinelory
	["{npc:2712} and {npc:2713}"] = "{npc:2712}와(과) {npc:2713}",

	-- Step 40: Kinelory's errand
	-- {npc:2713} Kinelory
	["{npc:2713}'s errand"] = "{npc:2713}의 심부름",
	-- {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["Stay with {npc:2713} while she sneaks into {area:314} and back; Horde orcs jump you on the way.\nCareful: Orcs that drop to low health run away. {npc:2713} follows them and can pull more mobs, so kill or slow runners fast."] = "{npc:2713}이(가) {area:314}에 몰래 들어갔다 나오는 동안 곁에 있으세요. 가는 길에 호드 오크가 덤벼듭니다.\n주의: 생명력이 낮아진 오크는 도망칩니다. {npc:2713}이(가) 그들을 쫓아가 몹을 더 끌어올 수 있으니, 도망치는 적은 빨리 처치하거나 느리게 하세요.",

	-- Step 41: Quae
	-- {npc:2711} Phin Odelic · {area:271} Southshore
	["For {npc:2711} in {area:271}"] = "{area:271}의 {npc:2711}에게",

	-- Step 42: Stones of Binding
	-- {npc:2712} Quae · {object:2691} Stone of East Binding · {area:314} Go'Shek Farm · {object:2702} Stone of Inner Binding · {area:320} Refuge Pointe
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["From {npc:2712}'s camp, a short way north-east to the {object:2691}, by the shards' hill north of {area:314}. The {object:2702}, where the three keys go, stands west of {area:320}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "{npc:2712}의 야영지에서 북동쪽으로 조금 가면 {area:314} 북쪽 파편 언덕 옆에 {object:2691}이(가) 있습니다. 세 열쇠를 가져갈 {object:2702}은(는) {area:320} 서쪽에 서 있습니다.\n주의: 각 중앙 돌은 39레벨 정도의 정령 셋가량이 지키며, 처치하지 않고 돌을 클릭하면 함께 공격합니다. 서부는 떠도는 불의 정령, 외곽은 떠도는 천둥 정령, 동부는 떠도는 물의 정령입니다.",

	-- Step 43: Refuge Pointe
	-- {area:320} Refuge Pointe
	["West along the road to {area:320}."] = "길을 따라 서쪽으로 {area:320}까지 가세요.",
	-- {npc:2789} Skuerto · {npc:2793} Kor'gresh Coldrage · {object:2689} Stone of West Binding
	["{npc:2789}: {npc:2793}'s cave, west past the {object:2689}"] = "{npc:2789}: {npc:2793}의 동굴, {object:2689}을(를) 지나 서쪽",

	-- Step 45: Faldir's Cove
	-- {npc:2768} Professor Phizzlethorpe
	["A group stop: two level 40 water elementals ambush {npc:2768}'s escort, and the Daggerspine naga in the reef are 38-40, with Sorceresses among them. Grouping up is encouraged, look for people to do it with. Skip it if you are alone.\nSouth along the west coast to the goblins' cove; Lolo keeps watch on the rocks above it."] = "파티 구간: 40레벨 물의 정령 둘이 {npc:2768} 호위를 기습하고, 암초의 가시돋친 나가는 38-40이며 마녀도 섞여 있습니다. 파티를 권장하니 함께할 사람을 찾아보세요. 혼자라면 건너뛰세요.\n서해안을 따라 남쪽으로 고블린의 만까지 가세요. 롤로가 그 위 바위에서 망을 봅니다.",

	-- Step 46: Phizzlethorpe
	["Phizzlethorpe"] = "피즐솔프",
	["Escort the professor up the hill to the cave above the cove and guard him while he works. Two level 40 water elementals ambush him there, and they are immune to frost. Hold them at the cave mouth, away from him: if the fight happens inside the cave, he joins in instead of working and more elementals keep coming."] = "",

	-- Step 48: The Drowned Reef: kill these as you meet them
	-- {area:328} The Drowned Reef
	["{area:328}: kill these as you meet them"] = "",
	["The two wrecks lie in the bay west of the cove. The charts and logs are inside them; the gems lie on the sea floor around them. Daggerspine naga swim the whole bay."] = "난파선 두 척은 만 서쪽 바다에 있습니다. 해도와 일지는 배 안에 있고, 보석은 주변 바다 바닥에 있습니다. 비수가시일족 나가가 바다 전체를 헤엄칩니다.",
	-- {npc:2595} Daggerspine Raider
	["{npc:2595}, underwater"] = "",
	-- {item:4492} Elven Gem
	["{item:4492}; underwater"] = "",
	-- {npc:2596} Daggerspine Sorceress
	["{npc:2596}, underwater"] = "",
	-- {object:2709} Maiden's Folly Log
	["{object:2709}; underwater"] = "",
	-- {object:2707} Maiden's Folly Charts
	["{object:2707}; underwater"] = "",
	-- {object:2710} Spirit of Silverpine Log
	["{object:2710}; underwater"] = "",
	-- {object:2708} Spirit of Silverpine Charts
	["{object:2708}; underwater"] = "",

	-- Step 49: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["For {npc:2487} in {area:35}: keep it"] = "{area:35}의 {npc:2487}에게: 보관하세요",

	-- Step 50: Kor'gresh Coldrage
	-- {npc:2793} Kor'gresh Coldrage
	["South-east through the hills: {npc:2793}, an ogre mage, holds the cave at the southern end of the Witherbark valley.\nCareful: {npc:2793} is level 39, a caster, one or two over you here: clear the cave mouth first, then pull him alone at full health."] = "언덕을 지나 남동쪽으로 가세요. 오우거 마법사 {npc:2793}이(가) 마른나무껍질 계곡 남쪽 끝 동굴을 차지하고 있습니다.\n주의: {npc:2793}은(는) 39레벨 주문시전자로, 이 시점의 당신보다 한두 레벨 높습니다. 동굴 입구를 먼저 정리한 뒤, 생명력이 가득할 때 그만 따로 끌어오세요.",
	-- {item:4525} Trelane's Wand of Invocation
	["{item:4525}; below ground"] = "",

	-- Step 51: Foggy MacKreel
	-- {npc:2793} Kor'gresh Coldrage · {area:880} Thandol Span · {npc:2696} Foggy MacKreel · {quest:647} MacKreel's Moonshine · {npc:2705} Brewmeister Bilger · {area:271} Southshore · {area:320} Refuge Pointe
	["South-west from {npc:2793}'s cave to the {area:880}: {npc:2696} stands on a broken section of the bridge; jump down to him from its north end. {quest:647} must reach {npc:2705} in {area:271} within 15 minutes: go straight back to {area:320} and fly to {area:271}."] = "",

	-- Step 53: Fly to Southshore
	-- {area:320} Refuge Pointe
	["{area:320} flight master"] = "",

	-- Step 54: Brewmeister Bilger
	-- {area:271} Southshore · {npc:2276} Magistrate Henry Maleb · {npc:2277} Loremaster Dibbs · {area:280} Strahnbrad
	["Off the flight, straight to the {area:271} inn. Then {npc:2276} and {npc:2277}, in the town hall, take the Syndicate camp's quests and send you north to {area:280}."] = "비행에서 내리면 곧장 {area:271} 여관으로 가세요. 그다음 마을회관의 {npc:2276}와(과) {npc:2277}이(가) 비밀결사대 야영지 퀘스트를 받고 당신을 북쪽 {area:280}(으)로 보냅니다.",
	-- {npc:2705} Brewmeister Bilger
	["{npc:2705}, below ground"] = "",
	-- {npc:2276} Magistrate Henry Maleb · {area:280} Strahnbrad
	["{npc:2276}: the signet rings are in {area:280}"] = "{npc:2276}: 인장 반지는 {area:280}에 있습니다",
	-- {npc:1356} Prospector Stormpike · {zone:1455} Ironforge
	["For {npc:1356} in {zone:1455}, at the end of this guide"] = "{zone:1455}의 {npc:1356}에게, 이 가이드 마지막에",

	-- Step 56: Gavin's Naze
	-- {area:271} Southshore · {area:280} Strahnbrad
	["Follow the road north out of {area:271} into the mountains. Mountain lions roam the slopes; the Syndicate in {area:280} wear the signet rings."] = "길을 따라 북쪽으로 {area:271}을(를) 나가 산으로 들어가세요. 산사자가 비탈을 돌아다니고, {area:280}의 비밀결사대가 인장 반지를 끼고 있습니다.",

	-- Step 57: Ruins of Alterac: kill these as you meet them
	-- {area:281} Ruins of Alterac
	["{area:281}: kill these as you meet them"] = "",
	-- {area:280} Strahnbrad
	-- plural, as words: Argus Shadow Mages = {npc:2318} Argus Shadow Mage · Crushridge Warmongers = {npc:2287} Crushridge Warmonger · Crushridge Maulers = {npc:2254} Crushridge Mauler · Crushridge Ogres = {npc:2252} Crushridge Ogre
	["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins.\nCareful: Crushridge Warmongers call nearby allies within 15 yd once they fall below half health.\nThe Crushridge Maulers, Mages, Enforcers and Warmongers (36-39) are elite; the Crushridge Ogres and Brutes (34-35) are not and carry the tomes too: pull one at a time, or group up."] = "",
	-- {item:3658} Recovered Tome
	["{item:3658}: Crushridge ogres"] = "{item:3658}: 산사태 오우거",
	-- {item:3659} Worn Leather Book · {object:1760} Weathered Bookcase · {quest:540} Preserving Knowledge
	["{item:3659}: the {object:1760}, beside Muckrake (40, elite): get it with a group, or abandon {quest:540}; inside"] = "{item:3659}: Muckrake(40, 정예) 옆의 {object:1760}: 파티와 함께 얻거나 {quest:540}을(를) 포기하십시오; 내부",

	-- Step 58: Ruins of Alterac: kill these as you meet them
	-- {npc:2417} Grel'borg the Miser
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:2417} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back.\n{npc:2417} walks from the arrow north-east through the ruins to about 40,47 and back: if he isn't at the arrow, follow his path."] = "정예 몹입니다. 파티를 맺는 것을 권장하니 함께할 사람을 찾아보세요. {npc:2417}은(는) 40레벨 정예입니다. 대부분의 직업은 42레벨에 혼자 처치할 수 있지만, 도움이 필요할 수도 있습니다. 혼자라면 건너뛰세요. 경로에서 사냥으로 경험치를 다시 채우게 됩니다.\n{npc:2417}은(는) 화살표 지점에서 폐허를 지나 북동쪽으로 약 40,47까지 걸었다가 되돌아옵니다. 화살표 지점에 없다면 그의 경로를 따라가세요.",

	-- Step 59: Strahnbrad: kill these as you meet them
	-- {area:280} Strahnbrad
	["{area:280}: kill these as you meet them"] = "",
	-- {npc:2306} Baron Vardus · {area:280} Strahnbrad
	["Careful: Syndicate Spies and Assassins can be stealthed. Assassins also poison you.\nCareful: {npc:2306} (40) turns up in one spot at a time: the cellar of {area:280}'s inn, or one of the Syndicate tent camps north of the village. Leave him be."] = "주의: 비밀결사대 첩자와 암살자는 은신해 있을 수 있습니다. 암살자는 독도 겁니다.\n주의: {npc:2306}(40)은(는) 한 번에 한 곳에만 나타납니다. {area:280} 여관의 지하실, 또는 마을 북쪽의 비밀결사대 천막 야영지 중 한 곳입니다. 그는 내버려 두세요.",

	-- Step 60: Crushridge ogres
	["Crushridge ogres"] = "산사태 오우거",
	-- {area:280} Strahnbrad
	-- plural, as words: Crushridge Maulers = {npc:2254} Crushridge Mauler · Crushridge Ogres = {npc:2252} Crushridge Ogre
	["The Crushridge ogres hold the hills north of {area:280}. Careful: Nagaz (40) stands far to the north-west by a worn wooden chest, with Syndicate guards: stay with the ogres.\nThe Crushridge Maulers, Mages, Enforcers and Warmongers (36-39) are elite; the Crushridge Ogres and Brutes (34-35) are not and drop the knucklebones too: pull one at a time, or group up."] = "산사태 오우거는 {area:280} 북쪽 언덕을 차지하고 있습니다. 주의: 나가즈(40)가 멀리 북서쪽의 낡은 나무 상자 옆에 비밀결사대 경비병들과 함께 서 있습니다. 오우거 근처에 머무르십시오.\n산사태일족 싸움꾼, 마법사, 집행자, 전쟁광(36-39)은 정예이고, 산사태 오우거와 산사태 야수(34-35)는 정예가 아니며 손가락뼈도 떨어뜨립니다. 하나씩 끌어오거나 파티를 맺으십시오.",

	-- Step 62: Dalaran
	-- {area:279} Dalaran · {zone:1421} Silverpine Forest · {npc:269127} Image of Archmage Modera
	["South-west to the Kirin Tor camp on the lake shore west of {area:279}, just over the border into {zone:1421}: the {npc:269127} stands there. Archmage Ansirem stands south-east of it, by the dome."] = "남서쪽으로 {area:279} 서쪽 호숫가의 키린 토 야영지로 가세요. {zone:1421} 경계를 막 넘은 곳으로, {npc:269127}이(가) 그곳에 서 있습니다. 대마법사 앤자이럼은 그 남동쪽, 돔 옆에 서 있습니다.",
	-- {npc:2542} Catelyn the Blade · {area:35} Booty Bay
	["For {npc:2542} in {area:35}: keep it"] = "{area:35}의 {npc:2542}에게: 보관하세요",

	-- Step 63: Image of Archmage Modera
	-- {npc:269127} Image of Archmage Modera · {quest:92458} Heart of Disruption · {item:277507} Dalaran Sewer Key
	["For your City of Dalaran run, next: the {npc:269127} wants the arcane remnants in the city thinned out and a mote from the heart of the disruption. {quest:92458} brings the {item:277507}, which opens the grate."] = "달라란 시 공략용(다음): {npc:269127}은(는) 도시의 비전 잔재를 줄이고 교란의 중심에서 티끌 하나를 가져오기를 원합니다. {quest:92458}은(는) 창살을 여는 {item:277507}을(를) 줍니다.",

	-- Step 64: City of Dalaran
	["City of Dalaran"] = "달라란 시",
	-- {quest:92457} Starving Arcane · {item:251961} Arcane Mote · {quest:92458} Heart of Disruption
	-- plural, as words: Seeking Remnants = {npc:247003} Seeking Remnant · Saturated Remnants = {npc:247001} Saturated Remnant
	["The City of Dalaran is a dungeon for a group of five at about level 28 to 33: at your level it goes quickly. Its way in is the sewer grate in the city's western wall, by the lake, 30 yards from Modera's camp.\nInside: the Seeking Remnants, Saturated Remnants and Mana Echoes are Modera's {quest:92457}; the {item:251961} for {quest:92458} drops inside too."] = "달라란 시는 약 28~33레벨 5인 파티용 던전으로, 지금 레벨이면 빠르게 끝납니다. 입구는 호숫가, 도시 서쪽 성벽의 하수구 창살로, 모데라 야영지에서 30야드 거리입니다.\n내부: Seeking Remnant, Saturated Remnant, Mana Echo는 모데라의 {quest:92457} 대상이며, {quest:92458}의 {item:251961}도 내부에서 떨어집니다.",
	-- {quest:92457} Starving Arcane
	["{quest:92457}: the remnants and echoes, inside"] = "{quest:92457}: 잔재와 메아리, 내부",
	-- {quest:92458} Heart of Disruption · {item:251961} Arcane Mote
	["{quest:92458}: the {item:251961}, inside"] = "",

	-- Step 65: Image of Archmage Modera
	["Back out of the grate to Modera's camp on the lake shore."] = "창살 밖으로 나와 호숫가의 모데라 야영지로 돌아가십시오.",

	-- Step 68: Southshore
	-- {npc:1440} Milton Sheaf · {zone:1453} Stormwind
	["For {npc:1440} in {zone:1453}: keep it"] = "{zone:1453}의 {npc:1440}에게: 보관하세요",

	-- Step 69: Bartolo Ginsetti
	-- {npc:2438} Bartolo Ginsetti · {npc:2381} Micha Yance · {item:2321} Fine Thread
	["{npc:2438} stands between the flight master and the inn; {npc:2381} beside him sells {item:2321} if you have none."] = "",
	-- {item:2321} Fine Thread · {npc:2381} Micha Yance
	["{item:2321}, from {npc:2381}"] = "",

	-- Step 71: Ironforge
	-- {npc:1356} Prospector Stormpike · {npc:1344} Prospector Ironband · {zone:1432} Loch Modan
	["{npc:1356}: for {npc:1344} in {zone:1432}, next"] = "{npc:1356}: {zone:1432}의 {npc:1344}에게, 다음 단계",

	-- Step 72: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "{area:144}(으)로 비행",

	-- Step 73: To Thelsamar
	-- {area:144} Thelsamar
	["To {area:144}"] = "",
	-- {zone:1455} Ironforge · {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {area:144} Thelsamar
	["From {zone:1455} take the tunnel east through {zone:1426} into {zone:1432} and follow the road to {area:144}."] = "{zone:1455}에서 동쪽 굴을 지나 {zone:1426}을(를) 거쳐 {zone:1432}에 들어간 뒤, 길을 따라 {area:144}까지 가세요.",

	-- Step 74: Thelsamar
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, below ground"] = "",

	-- Step 75: Prospector Ironband
	["South-east along the loch to the dig site."] = "호수를 따라 남동쪽으로 발굴 현장까지 가세요.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {npc:2434} lurks stealthed on the edge of {area:271}, and few players find him. If you spot him, kill him and read the contract he carries: {npc:2276} takes it. Don't wait for him: the rest of this step doesn't need him."] = "{npc:2434}이(가) {area:271} 외곽에 은신한 채 숨어 있어 그를 찾는 플레이어는 드뭅니다. 발견하면 처치하고 그가 지닌 계약서를 읽으세요. {npc:2276}이(가) 받습니다. 그를 기다리지는 마세요. 이 단계의 나머지는 그가 없어도 됩니다.",
	-- ["A {npc:2434} lurks unseen on the edge of {area:271}; kill him and read the contract he carries."] = "{npc:2434}이(가) {area:271} 외곽에 보이지 않게 숨어 있습니다. 그를 처치하고 그가 지닌 계약서를 읽으세요.",
	-- ["Each key lies at one of the Highlands' standing-stone circles: east of the shards, near {area:320} and in the west. The {object:2702} stands west of {area:320}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "각 열쇠는 아라시 고원의 선돌 원 중 하나에 있습니다. 파편 동쪽, {area:320} 근처, 그리고 서쪽입니다. {object:2702}은(는) {area:320} 서쪽에 서 있습니다.\n주의: 각 중앙 돌은 39레벨 정도의 정령 셋가량이 지키며, 처치하지 않고 돌을 클릭하면 함께 공격합니다. 서쪽은 불타는 추방자, 외곽은 천둥치는 추방자, 동쪽은 물마루 추방자입니다.",
	-- ["East along the road to the {area:76}. {npc:256028} mobs drop the crystals. {quest:1392} walks a long path through the ruins: if you meet him, kill him, his cudgel starts a quest for {npc:1776}. Don't wait for him."] = "길을 따라 동쪽으로 {area:76}까지 가세요. {npc:256028} 몹이 수정을 떨어뜨립니다. {quest:1392}은(는) 폐허를 지나는 긴 길을 돌아다닙니다. 마주치면 처치하세요. 그의 곤봉으로 {npc:1776}의 퀘스트가 시작됩니다. 그를 기다리지는 마세요.",
	-- ["East along the road to the {area:76}. {npc:256028} mobs drop the crystals; Noboru walks the ruins and drops his cudgel."] = "길을 따라 동쪽으로 {area:76}까지 가세요. {npc:256028} 몹이 수정을 떨어뜨리고, 노보루는 폐허를 돌아다니며 곤봉을 떨어뜨립니다.",
	-- ["East from {area:327} through the southern hills: {npc:2793}, an ogre mage, holds the cave at the southern end of the Witherbark valley."] = "{area:327}에서 동쪽으로 남쪽 언덕을 지나십시오. 오우거 마법사 {npc:2793}은(는) 마른나무껍질 계곡 남쪽 끝의 동굴을 차지하고 있습니다.",
	-- ["Ebenezer Rustlocke"] = "에벤에셀 러스트로크",
	-- ["Escort the professor to the beach north of the cove and guard him while he works; naga attack in waves."] = "학자를 만 북쪽 해변까지 호위하고 그가 작업하는 동안 지키세요. 나가가 여러 차례 공격해 옵니다.",
	-- ["Follow the road east out of {area:287} over {area:1057} to {area:320}."] = "길을 따라 동쪽으로 {area:287}을(를) 나가 {area:1057}을(를) 넘어 {area:320}까지 가세요.",
	-- ["Follow the road north out of {area:271} into the mountains. Mountain lions roam the slopes; the Syndicate in {area:280} wear the signet rings, and {npc:2306} walks the manor grounds on the north side of town."] = "길을 따라 북쪽으로 {area:271}을(를) 나가 산으로 들어가세요. 산사자가 비탈을 돌아다니고, {area:280}의 비밀결사대가 인장 반지를 끼고 있으며, {npc:2306}은(는) 마을 북쪽 저택 부지를 돌아다닙니다.",
	-- ["Follow the road north out of {area:271} into the mountains. Mountain lions roam the slopes; the Syndicate in {area:280} wear the signet rings. {npc:2306} (40) turns up in one spot at a time: the cellar of {area:280}'s inn, or one of the Syndicate tent camps in the uplands north and north-west of the village."] = "길을 따라 북쪽으로 {area:271}을(를) 나가 산으로 들어가세요. 산사자가 비탈을 돌아다니고, {area:280}의 비밀결사대가 인장 반지를 끼고 있습니다. {npc:2306}(40)은(는) 한 번에 한 곳에만 나타납니다. {area:280} 여관의 지하실, 또는 마을 북쪽과 북서쪽 고지대에 있는 비밀결사대 천막 야영지 중 한 곳입니다.",
	-- ["Follow the road north to the draenei of the {area:657}."] = "길을 따라 북쪽으로 {area:657}의 드레나이에게 가세요.",
	-- ["Follow the road south over the bridge to {area:205} at the {zone:1437} end, where {npc:1075} waits."] = "길을 따라 남쪽으로 다리를 건너 {zone:1437} 쪽 끝의 {area:205}까지 가세요. 그곳에서 {npc:1075}이(가) 기다립니다.",
	-- ["For characters of 36 to 38, but {area:327} and the Alterac Syndicate quests are level 40: on purpose, for their experience. {npc:2768}'s two water elementals (40) are immune to frost, and {npc:2306} (40) waits among his Syndicate: pull them one at a time."] = "36~38레벨 캐릭터용이지만, {area:327}와(과) 알터랙 비밀결사대 퀘스트는 40레벨입니다. 경험치를 위해 일부러 넣었습니다. {npc:2768}의 물의 정령 둘(40)은 냉기에 면역이며, {npc:2306}(40)은(는) 비밀결사대 무리 사이에서 기다립니다. 하나씩 끌어내십시오.",
	-- ["From {area:42} follow the road east through {zone:1430} into the {zone:1435}; Biggs guards the road junction just inside it. {npc:217412} stands a short way north of him."] = "{area:42}에서 길을 따라 동쪽으로 {zone:1430}을(를) 지나 {zone:1435}에 들어가세요. 비그스는 그 입구 바로 안쪽의 갈림길을 지킵니다. {npc:217412}은(는) 그의 조금 북쪽에 서 있습니다.",
	-- ["From {zone:1455} take the tunnel east through {zone:1426} into {area:38} and follow the road to {area:144}."] = "{zone:1455}에서 동쪽 굴을 지나 {zone:1426}을(를) 거쳐 {area:38}에 들어간 뒤, 길을 따라 {area:144}까지 가세요.",
	-- ["Gyll, {area:35}"] = "가일, {area:35}",
	-- ["Head back south from the eastern circle; {npc:2712} and {npc:2713} camp in the hills just north of {area:314}."] = "동쪽 환상열석에서 남쪽으로 돌아가세요. {npc:2712}와(과) {npc:2713}은(는) {area:314} 바로 북쪽 언덕에 진을 치고 있습니다.",
	-- ["Head north past {area:314}; the shards glitter on the hill by the {area:333}."] = "{area:314}을(를) 지나 북쪽으로 가세요. 파편은 {area:333} 옆 언덕에서 반짝입니다.",
	-- ["Ride back north-east past {area:320}; {npc:2712} and {npc:2713} camp in the hills north of {area:314}."] = "{area:320}을(를) 지나 북동쪽으로 돌아가세요. {npc:2712}와(과) {npc:2713}은(는) {area:314} 북쪽 언덕에 진을 치고 있습니다.",
	-- ["Shaman training"] = "주술사 훈련",
	-- ["South along the west coast to the goblins' cove; Lolo keeps watch on the rocks above it."] = "서쪽 해안을 따라 남쪽으로 고블린의 만까지 가세요. 롤로는 그 위 바위에서 망을 봅니다.",
	-- ["South from the {object:2691}, past {area:314}, to {area:317} in the hills: the Witch Doctors stand among the huts and the Shadow Hunters guard the far end of the valley. Every troll can drop a tusk."] = "{object:2691}에서 남쪽으로 {area:314}을(를) 지나 언덕의 {area:317}까지 가세요. 의술사는 오두막 사이에 서 있고, 어둠사냥꾼은 계곡 맨 끝을 지킵니다. 모든 트롤이 엄니를 떨어뜨릴 수 있습니다.",
	-- ["South-west to the Kirin Tor camp on the lake shore west of {area:279}, just over the border into {area:130}: the {npc:269127} stands there. Archmage Ansirem stands south-east of it, by the dome."] = "남서쪽으로 {area:279} 서쪽 호숫가의 키린 토 야영지로 가세요. {area:130} 경계를 막 넘은 곳으로, {npc:269127}이(가) 그곳에 서 있습니다. 대마법사 앤자이럼은 그 남동쪽, 돔 옆에 서 있습니다.",
	-- ["Subdue the succubus"] = "서큐버스 제압",
	-- ["Summon Succubus"] = "서큐버스 소환",
	-- ["The Crushridge ogres hold the hills north of {area:280}. Farther north, a worn wooden chest holds the {item:3706}; {npc:2320} of the {quest:537} stands right by it.\nThe Crushridge Maulers, Mages, Enforcers and Warmongers (36-39) are elite; the Crushridge Ogres and Brutes (34-35) are not and drop the knucklebones too: pull one at a time, or group up."] = "산사태 오우거는 {area:280} 북쪽 언덕을 차지하고 있습니다. 더 북쪽의 낡은 나무 상자에 {item:3706}이(가) 들어 있고, {quest:537}의 {npc:2320}이(가) 바로 옆에 서 있습니다.\n산사태 투사, 마법사, 집행자, 전쟁광(36-39)은 정예이고, 산사태 오우거와 산사태 야수(34-35)는 정예가 아니며 손가락뼈도 떨어뜨립니다. 하나씩 끌어오거나 파티를 맺으십시오.",
	-- ["The Drywhisker kobolds dig in the gorge east of {area:321} (Horde); skirt the town to the north. They drop both the motes and Krazek's ore."] = "마른수염 코볼트는 {area:321}(호드) 동쪽 협곡에서 땅을 팝니다. 마을은 북쪽으로 돌아가세요. 그들은 티끌과 크라젝의 광석을 모두 떨어뜨립니다.",
	-- ["The Syndicate hold the farm north-west of {area:320}. A {npc:217589} crawls about the farm: catch one with {npc:217412}'s Entomology Starter Kit, then tick it off."] = "비밀결사대가 {area:320} 북서쪽 농장을 차지하고 있습니다. 농장에는 {npc:217589}이(가) 기어다닙니다. {npc:217412}의 곤충학 입문 도구로 한 마리를 잡은 뒤 목록에서 체크하세요.",
	-- ["The Witherbark trolls live in the hills south of {area:314}; Witch Doctors stand in the village, Shadow Hunters guard the far end of the valley."] = "마른나무껍질 트롤은 {area:314} 남쪽 언덕에 삽니다. 의술사는 마을에 서 있고, 어둠사냥꾼은 계곡 맨 끝을 지킵니다.",
	-- ["The courier walks the road west of {area:314} with two guards; pull them off the road."] = "급사는 경비병 둘과 함께 {area:314} 서쪽 길을 걸어다닙니다. 길에서 끌어내세요.",
	-- ["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins."] = "고서는 {area:280} 서쪽의 무너진 성채에 있습니다. 아르거스재림회 어둠마법사가 폐허를 차지하고 있습니다.",
	-- ["The wrecked caravan lies off the road near Biggs."] = "부서진 대상단 마차는 비그스 근처 길가에 있습니다.",
	-- ["The wrecks"] = "난파선",
	-- ["Walk back onto the span: Ebenezer lies under its Arathi end."] = "다리 위로 다시 걸어가세요. 에벤에셀은 다리의 아라시 쪽 끝 아래에 쓰러져 있습니다.",
	-- ["{item:2321} for {npc:2438}'s cloak, from {npc:2381}, if you have none"] = "{npc:2438}의 망토용 {item:2321}, 없다면 {npc:2381}에게서",
	-- ["{item:3659}: the {object:1760}"] = "{item:3659}: {object:1760}",
	-- ["{npc:217589}: catch it, for {quest:93176}"] = "{npc:217589}: {quest:93176}을(를) 위해 잡으세요",
	-- ["{npc:252085}, in the City of Dalaran"] = "{npc:252085}, 달라란 도시 안",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train with {npc:258098}. {npc:1573} in the {object:32372} flies to {area:271} too."] = "{zone:1453}에는 주술사 상급자가 없습니다. {object:28027}에서 {area:2257}을(를) 타고 {zone:1455}(으)로 가서 {npc:258098}에게 훈련을 받으세요. {object:32372}의 {npc:1573}도 {area:271}(으)로 날아갑니다.",
}
