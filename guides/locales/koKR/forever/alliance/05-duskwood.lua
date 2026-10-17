-- Korean (koKR): the guide forever/alliance/05-duskwood (forever/alliance/05-duskwood.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Darkshire
	-- {area:1002} Three Corners · {zone:1431} Duskwood · {area:42} Darkshire
	["Follow the road south from {area:1002} into {zone:1431}; {area:42} lies on the east side of the forest."] = "{area:1002}에서 길을 따라 남쪽 {zone:1431}(으)로 가십시오. {area:42}은(는) 숲 동쪽에 있습니다.",
	-- {npc:2409} Felicia Maline
	["{npc:2409}, at the north end of town"] = "{npc:2409}, 마을 북쪽 끝",
	-- {npc:6790} Innkeeper Trelayne
	["{npc:6790}, Scarlet Raven Tavern"] = "{npc:6790}, 주점",
	-- {npc:265} Madame Eva
	["{npc:265}, in her house by the tavern"] = "{npc:265}, 주점 옆 그녀의 집",
	-- {npc:264} Commander Althea Ebonlocke
	["{npc:264}, in the town hall"] = "{npc:264}, 마을 회관",
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, in the house behind the town hall"] = "{npc:268}, 마을 회관 뒤 집",
	-- {npc:633} Elaine Carevin
	["{npc:633}, at the south end of town"] = "{npc:633}, 마을 남쪽 끝",

	-- Step 2: Viktori Prism'Antras
	-- {npc:276} Viktori Prism'Antras · {npc:3133} Herble Baubbletump
	["{npc:276}'s house stands at the east end of town. {npc:3133} sells engineering goods in the house beside it."] = "{npc:276}의 집은 마을 동쪽 끝에 있습니다. 그 옆집에서 {npc:3133}이(가) 기계공학 용품을 팝니다.",
	-- {item:4371} Bronze Tube · {npc:3133} Herble Baubbletump · {npc:1448} Neal Allen · {area:150} Menethil Harbor
	["{item:4371}, from {npc:3133}: limited stock. Sold out? {npc:1448} in {area:150} sells it too."] = "{npc:3133}에게서 {item:4371}: 재고 한정. 매진되었다면 {area:150}의 {npc:1448}도 팝니다.",

	-- Step 3: Tranquil Gardens Cemetery
	-- {area:42} Darkshire · {npc:302} Blind Mary · {zone:1431} Duskwood · {item:2378} Skeleton Finger
	-- plural, as words: Skeletal Warriors = {npc:48} Skeletal Warrior · Skeletal Mages = {npc:203} Skeletal Mage
	["Skeletal Warriors and Skeletal Mages walk among the graves south-east of {area:42}, below {npc:302}'s house on the hill. Every skeleton in {zone:1431} can drop a {item:2378}."] = "해골 전사와 해골 마법사가 {area:42} 남동쪽, 언덕 위 {npc:302}의 집 아래 무덤 사이를 돌아다닙니다. {zone:1431}의 모든 해골이 {item:2378}을(를) 떨어뜨릴 수 있습니다.",
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["{quest:337}: a rare drop from {zone:1431}'s mobs"] = "{quest:337}: {zone:1431} 몹이 드물게 떨어뜨림",

	-- Step 5: Watcher Dodds
	-- {npc:888} Watcher Dodds · {area:245} Yorgen Farmstead
	["{npc:888} stands south of the road, at the {area:245}."] = "{npc:888}은(는) 길 남쪽 {area:245}에 서 있습니다.",

	-- Step 6: Raven Hill
	-- {area:94} Raven Hill · {object:673515} Memory of Valor
	["Continue west to {area:94}. The {object:673515} glows by the ruined house south of the road."] = "서쪽 {area:94}(으)로 계속 가십시오. {object:673515}은(는) 길 남쪽 무너진 집 옆에서 빛나고 있습니다.",
	-- {item:281046} Raven Hill Tome · {object:673515} Memory of Valor
	["{item:281046}, from the {object:673515}"] = "{object:673515}에서 {item:281046}",

	-- Step 7: Raven Hill Cemetery, south
	-- {area:492} Raven Hill Cemetery
	["{area:492}, south"] = "{area:492}, 남쪽",
	-- {npc:522} Mor'Ladim
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Skeletal Fiends = {npc:531} Skeletal Fiend
	["The cemetery lies north of the village. Skeletal Horrors and Skeletal Fiends walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "묘지는 마을 북쪽에 있습니다. 묘지 남쪽 절반에는 해골 병사와 해골 악령이 돌아다닙니다. 정예인 {npc:522}이(가) 무덤 사이를 배회하니 멀리하십시오.",

	-- Step 8: Sven's Camp
	-- {npc:311} Sven Yorgen · {npc:893} Lars
	["Follow the road north-west past the cemetery to {npc:311}'s camp on the far west edge of the forest. {npc:893} stands beside {npc:311}."] = "묘지를 지나 길을 따라 북서쪽으로, 숲 서쪽 끝의 {npc:311}의 야영지까지 가십시오. {npc:893}은(는) {npc:311} 옆에 서 있습니다.",

	-- Step 9: Abercrombie
	-- {area:492} Raven Hill Cemetery
	["The hermit's shack stands in the woods north-east of the {area:492}."] = "은둔자의 오두막은 {area:492} 북동쪽 숲속에 있습니다.",

	-- Step 10: Wolves, spiders and ghouls
	["Wolves, spiders and ghouls"] = "늑대, 거미, 구울",
	-- {npc:289} Abercrombie
	-- plural, as words: Pygmy Venom Web Spiders = {npc:539} Pygmy Venom Web Spider
	["Rabid Dire Wolves roam the woods around the cemetery and {npc:289}, Starving Dire Wolves the hills north-east of him. Pygmy Venom Web Spiders crawl east of the cemetery and drop the venom. Every ghoul of the cemetery's northern half can drop a fang."] = "광포한 그늘숲늑대는 묘지와 {npc:289} 주변 숲을, 굶주린 그늘숲늑대는 그의 북동쪽 언덕을 돌아다닙니다. 새끼 그물독거미는 묘지 동쪽을 기어다니며 독을 떨어뜨립니다. 묘지 북쪽 절반의 모든 구울이 송곳니를 떨어뜨릴 수 있습니다.",

	-- Step 11: Watcher Dodds
	-- {area:245} Yorgen Farmstead
	["Ride back east along the road to the {area:245}."] = "길을 따라 동쪽 {area:245}(으)로 돌아가십시오.",

	-- Step 12: Yorgen Farmstead
	["The mound of loose dirt lies south of the farmhouse, by the old stump."] = "대충 덮인 흙무더기는 농가 남쪽, 오래된 그루터기 옆에 있습니다.",

	-- Step 14: Blind Mary
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	["Her house stands on the hill south-east of {area:42}, above the {area:121}."] = "그녀의 집은 {area:42} 남동쪽 언덕 위, {area:121} 위쪽에 있습니다.",

	-- Step 16: Abercrombie
	["Ride west along the road once more."] = "다시 한 번 길을 따라 서쪽으로 가십시오.",

	-- Step 18: Back to Darkshire
	-- {area:42} Darkshire
	["Back to {area:42}"] = "{area:42}(으)로 돌아가기",
	-- {area:42} Darkshire
	["Ride back east to {area:42}."] = "동쪽 {area:42}(으)로 돌아가십시오.",
	-- {npc:267} Clerk Daltry
	["{npc:267}, in the town hall"] = "{npc:267}, 마을 회관",
	-- {npc:273} Tavernkeep Smitts
	["{npc:273}, in the tavern"] = "{npc:273}, 주점",

	-- Step 19: Rot Blossoms
	-- plural, as words: Rot Blossoms = {item:1598} Rot Blossom
	["Rot Blossoms"] = "{item:1598}",
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Rot Blossoms = {item:1598} Rot Blossom
	["Skeletal Horrors walk the hillside between {area:42} and the {area:121}, south-east of town; they drop the Rot Blossoms."] = "{npc:202}은(는) {area:42}와(과) 마을 남동쪽 {area:121} 사이의 언덕을 돌아다니며, {item:1598}을(를) 떨어뜨립니다.",

	-- Step 21: Abercrombie
	["Ride west to the hermit once more."] = "다시 한 번 서쪽의 은둔자에게 가십시오.",

	-- Step 22: Ghoul Ribs
	-- plural, as words: Ghoul Ribs = {item:884} Ghoul Rib
	["Ghoul Ribs"] = "구울 해골",
	-- {area:492} Raven Hill Cemetery
	-- plural, as words: Flesh Eaters = {npc:3} Flesh Eater · Bone Chewers = {npc:210} Bone Chewer · Plague Spreaders = {npc:604} Plague Spreader · Brain Eaters = {npc:570} Brain Eater
	["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters, Bone Chewers, Plague Spreaders and Brain Eaters."] = "{area:492} 북쪽 절반의 모든 구울이 해골을 떨어뜨릴 수 있습니다: 굶주린 시체, 뼈만남은 시체, 역병걸린 시체, 걸신들린 시체.",

	-- Step 24: Jitters
	-- {npc:288} Jitters · {area:94} Raven Hill
	["{npc:288} hides in the house at the west end of {area:94}."] = "{npc:288}은(는) {area:94} 서쪽 끝의 집에 숨어 있습니다.",

	-- Step 25: Sven's Camp
	-- {zone:1453} Stormwind · {area:17203} Stormwind Harbor · {area:442} Auberdine · {zone:1440} Ashenvale
	["Next: {zone:1453} for training, then the boat from {area:17203} to {area:442} for {zone:1440}."] = "다음: 수련을 위해 {zone:1453}(으)로 간 뒤, {area:17203}에서 배를 타고 {area:442}(으)로 가서 {zone:1440}(으)로 향합니다.",

	-- Step 26: Agent Kearnen
	-- {area:94} Raven Hill · {zone:1436} Westfall · {npc:7024} Agent Kearnen · {npc:7053} Klaven Mortwake · {npc:7051} Malformed Defias Drone
	["Ride west along the road out of {area:94} into {zone:1436}. {npc:7024} watches {npc:7053}'s tower from the hills just inside the border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "길을 따라 서쪽으로 {area:94}을(를) 벗어나 {zone:1436}(으)로 가십시오. {npc:7024}은(는) 경계 바로 안쪽 언덕에서 {npc:7053}의 탑을 감시합니다. 탑을 지키는 {npc:7051}(레벨 23)이(가) 열쇠를 가지고 있으며, 클라벤의 일지는 꼭대기의 상자에 있습니다.",
	-- {item:7908} Klaven Mortwake's Journal
	["{item:7908}, in the chest"] = "상자 안의 {item:7908}",

	-- Step 27: Master Mathias Shaw
	-- {zone:1453} Stormwind · {object:2100} Old Town
	["Ride north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "엘윈 숲을 지나 북쪽 {zone:1453}(으)로 달려가십시오. 마티아스 쇼는 {object:2100}의 SI:7에 있습니다.",
	-- {npc:332} Master Mathias Shaw · {item:18160} Recipe: Thistle Tea
	["{npc:332}: Poisons, and {item:18160}"] = "{npc:332}: 독, {item:18160}",
	-- {quest:2607} The Touch of Zanzil · {npc:7207} Doc Mixilpixil
	["{quest:2607}: {npc:7207}, in the cellar of the Barracks"] = "{quest:2607}: {npc:7207}, 병영 지하실",
	-- {npc:7207} Doc Mixilpixil
	["/lay down beside {npc:7207}"] = "{npc:7207} 옆에서 /lay down",
	-- {item:3372} Leaded Vial · {npc:1313} Maria Lumere
	["{item:3372}: {npc:1313}, Alchemy Supplies"] = "{item:3372}: {npc:1313}, 연금술 용품",

	-- Step 28: Stormwind
	-- {zone:1453} Stormwind · {zone:1429} Elwynn Forest · {area:17203} Stormwind Harbor · {area:442} Auberdine
	["Train in {zone:1453}, north through {zone:1429}. Then take the boat from {area:17203} to {area:442}."] = "{zone:1429}을(를) 지나 북쪽 {zone:1453}에서 수련하십시오. 그다음 {area:17203}에서 배를 타고 {area:442}(으)로 가십시오.",
	["Level 22 and 24 spells"] = "레벨 22, 24 주문",

	-- Step 29: Shaman training
	["Shaman training"] = "주술사 수련",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker · {area:442} Auberdine
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the {area:442} boat."] = "{zone:1453}에는 주술사 상급자가 없습니다: {object:28027}에서 {area:2257}을(를) 타고 {zone:1455}(으)로 가서 {npc:258098}에게 수련한 뒤, 지하철로 돌아와 {area:442}행 배를 타십시오.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:332}: {spell:2842}, and {item:18160}"] = "{npc:332}: {spell:2842}, {item:18160}",
}
