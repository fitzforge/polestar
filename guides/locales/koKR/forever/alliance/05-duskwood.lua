-- Korean (koKR): the guide forever/alliance/05-duskwood (forever/alliance/05-duskwood.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "{area:42}(으)로 날아가세요",
	-- {area:42} Darkshire · {zone:1431} Duskwood · {area:69} Lakeshire
	["Fly to {area:42} for {zone:1431}'s second loop: from {area:69}'s gryphon master if you come from the Redridge guide."] = "{zone:1431}의 두 번째 순회를 위해 {area:42}(으)로 날아가십시오: 붉은마루 산맥 가이드에서 왔다면 {area:69}의 그리폰 조련사에게서 출발합니다.",

	-- Step 2: Blind Mary
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	["Her house stands on the hill south-east of {area:42}, above the {area:121}."] = "그녀의 집은 {area:42} 남동쪽 언덕 위, {area:121} 위쪽에 있습니다.",
	["Inside"] = "내부",
	-- {item:1946} Mary's Looking Glass · {npc:511} Insane Ghoul
	["{item:1946}: the {npc:511}, in the crypt of the cemetery just below"] = "",

	-- Step 3: Tranquil Gardens Cemetery
	-- {npc:511} Insane Ghoul · {area:121} Tranquil Gardens Cemetery · {area:42} Darkshire
	["The {npc:511} (26) hides in the small crypt by the {area:121}, south of {area:42}; the glass is inside."] = "",
	-- {item:1946} Mary's Looking Glass
	["{item:1946}; inside"] = "{item:1946}; 내부",
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["{quest:337}: a rare drop from {zone:1431}'s mobs"] = "{quest:337}: {zone:1431} 몹이 드물게 떨어뜨림",

	-- Step 4: Viktori Prism'Antras
	-- {area:42} Darkshire · {npc:276} Viktori Prism'Antras
	["North into {area:42}: {npc:276}'s house stands at the east end of town, on the way in."] = "",
	-- {npc:276} Viktori Prism'Antras
	["{npc:276}, inside"] = "{npc:276}, 내부",
	-- {quest:177} Look to the Stars · {zone:1431} Duskwood
	["{quest:177}: the ogres of Vul'Gol, on your {zone:1431} return"] = "",

	-- Step 6: Abercrombie
	["Head west along the road once more."] = "다시 한 번 길을 따라 서쪽으로 가십시오.",

	-- Step 7: Raven Hill Cemetery: kill these as you meet them
	-- {area:492} Raven Hill Cemetery
	["{area:492}: kill these as you meet them"] = "{area:492}: 만나는 대로 처치하세요",
	-- {npc:311} Sven Yorgen · {area:94} Raven Hill · {npc:522} Mor'Ladim
	-- plural, as words: Skeletal Fiends = {npc:531} Skeletal Fiend · Skeletal Horrors = {npc:202} Skeletal Horror
	["On the way west to {npc:311}: Skeletal Fiends and Skeletal Horrors walk the cemetery's southern half, north of {area:94}. {npc:522}, an elite, wanders the graves: keep away from him."] = "",

	-- Step 8: Gooey Spider Legs
	-- plural, as words: Gooey Spider Legs = {item:2251} Gooey Spider Leg
	["Gooey Spider Legs"] = "",
	-- {npc:311} Sven Yorgen
	-- plural, as words: Carrion Recluses = {npc:949} Carrion Recluse · Venom Web Spiders = {npc:217} Venom Web Spider · Pygmy Venom Web Spiders = {npc:539} Pygmy Venom Web Spider · Green Recluses = {npc:569} Green Recluse
	["Carrion Recluses lurk in the woods on the way west, and Venom Web Spiders, Pygmy Venom Web Spiders and Green Recluses crawl just south of {npc:311}'s camp: each can drop a leg."] = "",

	-- Step 9: Lars
	-- {npc:893} Lars · {npc:311} Sven Yorgen
	["{npc:893}, at {npc:311}'s camp"] = "{npc:893}, {npc:311}의 야영지",

	-- Step 11: Moonbrook
	-- {quest:67} The Legend of Stalvan · {npc:311} Sven Yorgen · {zone:1436} Westfall · {area:20} Moonbrook · {object:3643} Old Footlocker · {area:42} Darkshire
	["{quest:67}: west from {npc:311}'s camp over the border into {zone:1436} and on to {area:20}, where the {object:3643} stands among the Defias (15-18). Then hearth back to {area:42}."] = "",

	-- Step 12: Moonbrook
	-- {quest:67} The Legend of Stalvan · {object:3643} Old Footlocker · {area:20} Moonbrook · {area:42} Darkshire
	["{quest:67}: the {object:3643} in {area:20}, among the Defias (15-18), holds the next part. Then hearth back to {area:42}."] = "{quest:67}: {area:20}의 데피아즈단(15-18) 사이에 있는 {object:3643}에 다음 부분이 있습니다. 그런 다음 귀환석으로 {area:42}(으)로 돌아가십시오.",

	-- Step 13: Back to Darkshire
	-- {area:42} Darkshire
	["Back to {area:42}"] = "{area:42}(으)로 돌아가기",
	-- {area:42} Darkshire
	["Hearth back to {area:42} if you bound at the Scarlet Raven Tavern on the first loop, or head back east along the road."] = "",
	-- {npc:265} Madame Eva
	["{npc:265}, inside"] = "{npc:265}, 내부",
	-- {npc:267} Clerk Daltry
	["{npc:267}, in the town hall"] = "{npc:267}, 마을 회관",
	-- {npc:264} Commander Althea Ebonlocke
	["{npc:264}, in the town hall"] = "{npc:264}, 마을 회관",
	-- {npc:264} Commander Althea Ebonlocke · {npc:289} Abercrombie
	-- plural, as words: Plague Spreaders = {npc:604} Plague Spreader
	["{npc:264}: the Plague Spreaders, with {npc:289}'s ghouls on the next trip west"] = "",
	-- {npc:273} Tavernkeep Smitts
	["{npc:273}, in the tavern"] = "{npc:273}, 주점",

	-- Step 14: Clerk Daltry
	-- {quest:68} The Legend of Stalvan · {npc:267} Clerk Daltry
	["{quest:68}: {npc:267}, in the town hall, takes the footlocker's contents."] = "",
	-- {npc:267} Clerk Daltry · {npc:295} Innkeeper Farley · {area:87} Goldshire · {zone:1453} Stormwind
	["{npc:267}: for {npc:295} in {area:87}, on the walk north to {zone:1453}"] = "",

	-- Step 15: Chef Grual
	-- {npc:272} Chef Grual
	["{npc:272} is in the Scarlet Raven Tavern too."] = "{npc:272}도 주점에 있습니다.",
	-- {npc:288} Jitters · {area:94} Raven Hill
	["For {npc:288}, at {area:94} on the way west"] = "",

	-- Step 16: Chef Grual
	-- {npc:272} Chef Grual
	["{npc:272} is in the Scarlet Raven Tavern."] = "{npc:272}은(는) 붉은까마귀 선술집에 있습니다.",

	-- Step 17: Rot Blossoms
	-- plural, as words: Rot Blossoms = {item:1598} Rot Blossom
	["Rot Blossoms"] = "{item:1598}",
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Rot Blossoms = {item:1598} Rot Blossom
	["Skeletal Horrors walk the hillside between {area:42} and the {area:121}, south-east of town; they drop the Rot Blossoms."] = "{npc:202}은(는) {area:42}와(과) 마을 남동쪽 {area:121} 사이의 언덕을 돌아다니며, {item:1598}을(를) 떨어뜨립니다.",

	-- Step 19: Abercrombie
	["Head west to the hermit once more."] = "다시 한 번 서쪽의 은둔자에게 가십시오.",

	-- Step 20: Ghoul Ribs
	-- plural, as words: Ghoul Ribs = {item:884} Ghoul Rib
	["Ghoul Ribs"] = "구울 해골",
	-- {area:492} Raven Hill Cemetery · {npc:522} Mor'Ladim · {npc:948} Rotted One · {spell:3428} Summon Flesh Eating Worms · {npc:503} Lord Malathrom · {npc:771} Commander Felstrom · {npc:1200} Morbent Fel
	-- plural, as words: Flesh Eaters = {npc:3} Flesh Eater · Bone Chewers = {npc:210} Bone Chewer · Plague Spreaders = {npc:604} Plague Spreader · Brain Eaters = {npc:570} Brain Eater
	["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters and Bone Chewers (24-27) are the easier kills; Plague Spreaders and Brain Eaters (27-29) drop them too. {npc:522}, an elite, wanders the graves: keep away from him.\nCareful: A {npc:948} casts {spell:3428} as it dies, which brings extra adds.\nCareful: {npc:503} (31) and {npc:771} (32), both rares, haunt the cemetery's north and west, and {npc:1200} (32, elite) keeps to the house at its western edge: leave them be."] = "",
	-- {npc:604} Plague Spreader · {quest:58} The Night Watch
	["{npc:604}, for {quest:58}"] = "",

	-- Step 22: Jitters
	-- {npc:288} Jitters · {area:94} Raven Hill
	["{npc:288} hides in the house at the west end of {area:94}."] = "{npc:288}은(는) {area:94} 서쪽 끝의 집에 숨어 있습니다.",

	-- Step 25: Skeletal Raiders
	-- plural, as words: Skeletal Raiders = {npc:1110} Skeletal Raider
	["Skeletal Raiders"] = "",
	-- {area:492} Raven Hill Cemetery · {npc:311} Sven Yorgen · {npc:522} Mor'Ladim · {npc:771} Commander Felstrom
	-- plural, as words: Skeletal Raiders = {npc:1110} Skeletal Raider
	["From level 28: the Skeletal Raiders, Healers and Warders stand in the west part of the {area:492}, just east of {npc:311}'s camp.\nCareful: The Warders are 28-29 and the skeletons stand close together: pull one at a time.\nCareful: {npc:522}, an elite (35), wanders these graves too, and {npc:771} (32, rare) haunts the west part: keep away from both."] = "",

	-- Step 26: Sven Yorgen
	-- {zone:1453} Stormwind · {area:150} Menethil Harbor · {zone:1437} Wetlands
	["Next: training, then the flight from {zone:1453} to {area:150} for the {zone:1437}."] = "다음: 수련 후 {zone:1453}에서 {area:150}(으)로 비행해 {zone:1437}(으)로 향합니다.",
	-- {npc:1212} Bishop Farthing · {zone:1453} Stormwind
	["For {npc:1212} in {zone:1453}'s Cathedral, on the walk north"] = "",

	-- Step 28: Agent Kearnen
	-- {area:94} Raven Hill · {zone:1436} Westfall · {npc:7024} Agent Kearnen · {npc:7053} Klaven Mortwake · {npc:7051} Malformed Defias Drone
	["Head west along the road out of {area:94} into {zone:1436}. {npc:7024} watches {npc:7053}'s tower from the hills just inside the border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "길을 따라 서쪽으로 {area:94}을(를) 벗어나 {zone:1436}(으)로 가십시오. {npc:7024}은(는) 경계 바로 안쪽 언덕에서 {npc:7053}의 탑을 감시합니다. 탑을 지키는 {npc:7051}(레벨 23)이(가) 열쇠를 가지고 있으며, 클라벤의 일지는 꼭대기의 상자에 있습니다.",
	-- {item:7908} Klaven Mortwake's Journal
	["{item:7908}, in the chest"] = "상자 안의 {item:7908}",

	-- Step 29: Master Mathias Shaw
	-- {area:1519} Stormwind · {object:2100} Old Town
	-- was: ["Head north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "엘윈 숲을 지나 북쪽 {zone:1453}(으)로 가십시오. 마티아스 쇼는 {object:2100}의 SI:7에 있습니다."
	["Head north through Elwynn to {area:1519}; Mathias Shaw is at SI:7 in {object:2100}."] = "",
	-- {npc:332} Master Mathias Shaw · {item:18160} Recipe: Thistle Tea
	["{npc:332}: Poisons, and {item:18160}"] = "{npc:332}: 독, {item:18160}",
	-- {quest:2607} The Touch of Zanzil · {npc:7207} Doc Mixilpixil
	["{quest:2607}: {npc:7207}, in the cellar of the Barracks"] = "{quest:2607}: {npc:7207}, 병영 지하실",
	-- {npc:7207} Doc Mixilpixil
	["/lay down beside {npc:7207}"] = "{npc:7207} 옆에서 /lay down",
	-- {item:3372} Leaded Vial · {npc:1313} Maria Lumere
	["{item:3372}: {npc:1313}, Alchemy Supplies"] = "{item:3372}: {npc:1313}, 연금술 용품",
	-- {item:4371} Bronze Tube · {object:2096} Trade District · {npc:5519} Billibub Cogspinner
	["{item:4371}: the Auction House, {object:2096}; {npc:5519} keeps one and is nearly always sold out"] = "",

	-- Step 30: Elwynn Forest
	-- {area:94} Raven Hill · {area:87} Goldshire · {zone:1453} Stormwind
	["North from {area:94} through Elwynn: {area:87} is on the road to {zone:1453}."] = "",

	-- Step 31: Class trainer
	["Class trainer"] = "직업 전문가",
	["Your new spells"] = "새 주문",

	-- Step 32: Innkeeper Farley
	-- {quest:69} The Legend of Stalvan · {npc:295} Innkeeper Farley · {area:87} Goldshire
	["{quest:69}: {npc:295} is in {area:87}'s Lion's Pride Inn; the chest with the letter is upstairs."] = "",
	-- {item:910} An Undelivered Letter · {object:1560} Storage Chest
	["{item:910}, from the {object:1560} upstairs"] = "",

	-- Step 33: Caretaker Folsom
	-- {zone:1453} Stormwind · {npc:297} Caretaker Folsom · {object:1561} Sealed Crate
	["On into {zone:1453}: {npc:297} (the arrow shows him) takes the letter; the {object:1561} beside him holds the next clue."] = "",
	-- {object:1561} Sealed Crate
	["{object:1561}, beside him"] = "",

	-- Step 34: Bishop Farthing
	-- {zone:1453} Stormwind · {npc:1212} Bishop Farthing · {npc:1217} Glorin Steelbrow · {area:150} Menethil Harbor
	["On into {zone:1453}: {npc:1212} stands in the Cathedral of Light, on the way to the gryphon master. His next quest is for {npc:1217} in {area:150}, where the flight lands."] = "",
	-- {npc:1212} Bishop Farthing
	["{npc:1212}, in the Cathedral of Light"] = "",
	-- {npc:1217} Glorin Steelbrow · {area:150} Menethil Harbor · {zone:1437} Wetlands
	["For {npc:1217} in {area:150} (the {zone:1437} guide)"] = "",

	-- Step 35: Gazin Tenorm
	-- {zone:1453} Stormwind · {npc:6173} Gazin Tenorm · {npc:6171} Duthorian Rall
	["On into {zone:1453}: {npc:6173} and {npc:6171} are in the Cathedral of Light, on the way to the gryphon master."] = "",
	["Cathedral of Light"] = "빛의 대성당",

	-- Step 36: Gazin Tenorm
	-- {item:6846} Defias Script · {npc:6173} Gazin Tenorm · {quest:1787} The Tome of Divinity
	["The {item:6846} is already with {npc:6173}: take the last part of {quest:1787} from him, in the Cathedral of Light."] = "{item:6846}은(는) 이미 {npc:6173}에게 있습니다: 빛의 대성당에서 그에게 {quest:1787}의 마지막 부분을 받으십시오.",

	-- Step 37: Duthorian Rall
	-- {npc:6171} Duthorian Rall · {npc:6173} Gazin Tenorm
	["{npc:6171} stands in the Cathedral of Light, beside {npc:6173}."] = "{npc:6171}은(는) 빛의 대성당 안, {npc:6173} 옆에 서 있습니다.",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}: Redemption"] = "{npc:6171}: 구원",

	-- Step 38: Stormwind
	-- {zone:1453} Stormwind · {object:28027} Dwarven District
	["{zone:1453}'s {object:28027}"] = "",

	-- Step 39: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "지하철을 타고 {zone:1455}(으)로",

	-- Step 40: Shaman training
	["Shaman training"] = "주술사 수련",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back."] = "{zone:1453}에는 주술사 상급자가 없습니다. {object:28027}에서 {area:2257}을(를) 타고 {zone:1455}(으)로 가서 {npc:258098}에게 훈련을 받은 뒤, 지하철을 타고 돌아오세요.",

	-- Step 41: Rogue training
	["Rogue training"] = "",
	-- {zone:1453} Stormwind
	["Train here, in {zone:1453}, before you go on."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Continue west to {area:94}. The {object:673515} glows by the ruined house south of the road."] = "서쪽 {area:94}(으)로 계속 가십시오. {object:673515}은(는) 길 남쪽 무너진 집 옆에서 빛나고 있습니다.",
	-- ["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters and Bone Chewers (24-27) are the easier kills; Plague Spreaders and Brain Eaters (27-29) drop them too. {npc:522}, an elite, wanders the graves: keep away from him.\nCareful: A {npc:948} casts {spell:3428} as it dies, which brings extra adds."] = "{area:492} 북쪽 절반의 모든 구울이 갈비뼈를 떨어뜨릴 수 있습니다. 굶주린 시체와 뼈만남은 시체(24-27)가 잡기 쉽고, 역병걸린 시체와 걸신들린 시체(27-29)도 떨어뜨립니다. 정예 {npc:522}이(가) 무덤 사이를 돌아다니니 멀리하십시오.\n주의: {npc:948}은(는) 죽을 때 {spell:3428}을(를) 시전해 몹을 추가로 불러냅니다.",
	-- ["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters, Bone Chewers, Plague Spreaders and Brain Eaters.\nCareful: A {npc:948} casts {spell:3428} as it dies, which brings extra adds."] = "{area:492} 북쪽 절반의 모든 구울이 해골을 떨어뜨릴 수 있습니다: 굶주린 시체, 뼈만남은 시체, 역병걸린 시체, 걸신들린 시체.\n주의: {npc:948}은(는) 죽을 때 {spell:3428}을(를) 시전해 몹을 추가로 불러냅니다.",
	-- ["Follow the road north-west past the cemetery to {npc:311}'s camp on the far west edge of the forest. {npc:893} stands beside {npc:311}."] = "묘지를 지나 길을 따라 북서쪽으로, 숲 서쪽 끝의 {npc:311}의 야영지까지 가십시오. {npc:893}은(는) {npc:311} 옆에 서 있습니다.",
	-- ["Follow the road south from {area:1002} into {zone:1431}; {area:42} lies on the east side of the forest."] = "{area:1002}에서 길을 따라 남쪽 {zone:1431}(으)로 가십시오. {area:42}은(는) 숲 동쪽에 있습니다.",
	-- ["Head north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "엘윈 숲을 지나 북쪽 {zone:1453}(으)로 가십시오. 마티아스 쇼는 {object:2100}의 SI:7에 있습니다.",
	-- ["Head south through the cemetery towards {area:94}. Skeletal Fiends and Skeletal Horrors walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "묘지를 지나 남쪽 {area:94} 방향으로 가십시오. 묘지 남쪽 절반에는 해골 악령과 해골 병사가 돌아다닙니다. 정예인 {npc:522}이(가) 무덤 사이를 배회하니 멀리하십시오.",
	-- ["Level 22 and 24 spells"] = "레벨 22, 24 주문",
	-- ["Rabid Dire Wolves roam the woods around the cemetery and {npc:289}, Starving Dire Wolves the hills north-east of him. Pygmy Venom Web Spiders crawl east of the cemetery and drop the venom. Every ghoul of the cemetery's northern half can drop a fang."] = "광포한 그늘숲늑대는 묘지와 {npc:289} 주변 숲을, 굶주린 그늘숲늑대는 그의 북동쪽 언덕을 돌아다닙니다. 새끼 그물독거미는 묘지 동쪽을 기어다니며 독을 떨어뜨립니다. 묘지 북쪽 절반의 모든 구울이 송곳니를 떨어뜨릴 수 있습니다.",
	-- ["Ride back east along the road to the {area:245}."] = "길을 따라 동쪽 {area:245}(으)로 돌아가십시오.",
	-- ["Ride back east to {area:42}."] = "동쪽 {area:42}(으)로 돌아가십시오.",
	-- ["Skeletal Warriors and Skeletal Mages walk among the graves south-east of {area:42}, below {npc:302}'s house on the hill. Every skeleton in {zone:1431} can drop a {item:2378}."] = "해골 전사와 해골 마법사가 {area:42} 남동쪽, 언덕 위 {npc:302}의 집 아래 무덤 사이를 돌아다닙니다. {zone:1431}의 모든 해골이 {item:2378}을(를) 떨어뜨릴 수 있습니다.",
	-- ["The hermit's shack stands in the woods north-east of the {area:492}."] = "은둔자의 오두막은 {area:492} 북동쪽 숲속에 있습니다.",
	-- ["The mound of loose dirt lies south of the farmhouse, by the old stump."] = "대충 덮인 흙무더기는 농가 남쪽, 오래된 그루터기 옆에 있습니다.",
	-- ["Train in {zone:1453}, north through {zone:1429}. Then take the boat from {area:17203} to {area:442}."] = "{zone:1429}을(를) 지나 북쪽 {zone:1453}에서 수련하십시오. 그다음 {area:17203}에서 배를 타고 {area:442}(으)로 가십시오.",
	-- ["Wolves, spiders and ghouls"] = "늑대, 거미, 구울",
	-- ["{area:492}, south"] = "{area:492}, 남쪽",
	-- ["{area:69} flight master"] = "{area:69} 비행 조련사",
	-- ["{item:281046}, from the {object:673515}"] = "{object:673515}에서 {item:281046}",
	-- ["{item:4371}, from {npc:3133}: limited stock. Sold out? {npc:1448} in {area:150} sells it too."] = "{npc:3133}에게서 {item:4371}: 재고 한정. 매진되었다면 {area:150}의 {npc:1448}도 팝니다.",
	-- ["{npc:2409}, at the north end of town"] = "{npc:2409}, 마을 북쪽 끝",
	-- ["{npc:265}, in her house by the tavern"] = "{npc:265}, 주점 옆 그녀의 집",
	-- ["{npc:268}, in the house behind the town hall"] = "{npc:268}, 마을 회관 뒤 집",
	-- ["{npc:276}'s house stands at the east end of town. {npc:3133} sells engineering goods in the house beside it."] = "{npc:276}의 집은 마을 동쪽 끝에 있습니다. 그 옆집에서 {npc:3133}이(가) 기계공학 용품을 팝니다.",
	-- ["{npc:332}: {spell:2842}, and {item:18160}"] = "{npc:332}: {spell:2842}, {item:18160}",
	-- ["{npc:633}, at the south end of town"] = "{npc:633}, 마을 남쪽 끝",
	-- ["{npc:888} stands south of the road, at the {area:245}."] = "{npc:888}은(는) 길 남쪽 {area:245}에 서 있습니다.",
	-- ["{quest:337}: a rare drop from {zone:1431}'s mobs"] = "{quest:337}: {zone:1431} 몹이 드물게 떨어뜨림",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the {area:442} boat."] = "{zone:1453}에는 주술사 상급자가 없습니다: {object:28027}에서 {area:2257}을(를) 타고 {zone:1455}(으)로 가서 {npc:258098}에게 수련한 뒤, 지하철로 돌아와 {area:442}행 배를 타십시오.",
}
