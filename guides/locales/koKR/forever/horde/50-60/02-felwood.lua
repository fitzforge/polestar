-- Korean (koKR): the guide forever/horde/50-60/02-felwood (forever/horde/50-60/02-felwood.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "{area:1497}(으)로 날아가기",
	-- {area:2268} Light's Hope Chapel · {area:1497} Undercity
	["From {area:2268}'s flight master, fly to the {area:1497}."] = "{area:2268}의 비행 조련사에게서 {area:1497}(으)로 날아가세요.",

	-- Step 2: Janice Felstone
	-- {area:1497} Undercity · {zone:1420} Tirisfal Glades · {area:152} Bulwark · {npc:10778} Janice Felstone
	["Leave the {area:1497} and ride east along the road through {zone:1420}, past the {area:152}. Felstone Farm is the first farm along the road; {npc:10778} waits in the house."] = "{area:1497}을(를) 나와 길을 따라 동쪽으로 {zone:1420}을(를) 지나 {area:152}을(를) 지나가세요. 펠스톤 농장은 길을 따라 처음 나오는 농장이며, {npc:10778}은(는) 집 안에서 기다립니다.",
	-- {object:175894} Janice's Parcel
	["{object:175894}, beside the house"] = "집 옆의 {object:175894}",
	-- {npc:10781} Royal Overseer Bauhaus · {area:1497} Undercity
	["Keep the parcel: {npc:10781} is in the {area:1497}."] = "꾸러미를 보관하세요: {npc:10781}은(는) {area:1497}에 있습니다.",

	-- Step 3: Scarlet forward camp
	["Scarlet forward camp"] = "붉은십자군 전진 야영지",
	-- {area:199} Felstone Field · {area:200} Dalson's Tears · {object:176092} Box of Incendiaries
	["The Scarlet Crusade's tents stand between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner."] = "붉은십자군의 천막은 {area:199}와(과) {area:200} 사이에 있습니다. {object:176092}(으)로 지휘 천막을 불태우고 스컬지 깃발을 꽂으세요.",

	-- Step 4: Dalson's Tears farmhouse
	-- {area:200} Dalson's Tears
	["{area:200} farmhouse"] = "{area:200} 농가",
	-- {npc:10816} Wandering Skeleton · {npc:10836} Farmer Dalson
	["The diary lies in the farmhouse, the cabinet stands inside and the outhouse is behind it. A {npc:10816} carries the outhouse key; {npc:10836} comes out when you open the outhouse and carries the cabinet key."] = "일기는 농가 안에, 장식장은 그 안에, 변소는 그 뒤에 있습니다. {npc:10816}이(가) 변소 열쇠를 지니고 있습니다. 변소를 열면 {npc:10836}이(가) 나오며, 그가 장식장 열쇠를 지니고 있습니다.",

	-- Step 5: Mulgris Deepriver
	-- {area:202} Writhing Haunt · {area:200} Dalson's Tears
	["He camps by the {area:202}, south-east of {area:200}."] = "그는 {area:200} 남동쪽, {area:202} 옆에 야영하고 있습니다.",

	-- Step 6: Sorrow Hill
	-- {area:202} Writhing Haunt · {area:197} Sorrow Hill · {npc:10927} Marlene Redpath · {npc:10936} Joseph Redpath
	["Ride south past the {area:202} to {area:197}; {npc:10927}'s house stands by the road, and {npc:10936}'s monument is in the graveyard behind it. Kill the Diseased Wolves you meet in the fields on the way."] = "남쪽으로 {area:202}을(를) 지나 {area:197}(으)로 가세요. {npc:10927}의 집은 길가에 있고, {npc:10936}의 기념비는 그 뒤 묘지에 있습니다. 가는 길에 들판에서 만나는 역병에 걸린 늑대를 처치하세요.",
	-- {npc:10840} Argent Officer Pureheart
	["{npc:10840}, at the graveyard's south end"] = "묘지 남쪽 끝의 {npc:10840}",
	-- {quest:5142} Little Pamela · {area:2262} Darrowshire
	["Keep {quest:5142}: Pamela is in {area:2262}, visited again later."] = "{quest:5142}을(를) 보관하세요: 파멜라는 나중에 다시 들르는 {area:2262}에 있습니다.",

	-- Step 7: Chromie
	-- {npc:10667} Chromie
	["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "북서쪽의 안돌할로 가세요. {npc:10667}은(는) 마을 서쪽의 무너진 여관에서 기다립니다. 안쪽의 해골은 54-57레벨이니 가장자리로만 다니세요.",

	-- Step 8: The Annals of Darrowshire
	-- plural, as words: Musty Tomes = {object:176150} Musty Tome
	["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "연대기는 안돌할 시청의 곰팡이 슨 고서 사이에 있습니다. 맞는 것을 찾을 때까지 열어 보세요.",

	-- Step 9: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel
	["{quest:5210} goes to {area:2268}: keep it for later."] = "{quest:5210}은(는) {area:2268}(으)로 갑니다. 나중을 위해 보관하세요.",

	-- Step 10: Diseased Wolves
	["Diseased Wolves"] = "역병에 걸린 늑대",
	-- {area:200} Dalson's Tears · {area:202} Writhing Haunt
	["The wolves roam the fields between Andorhal, {area:200} and the {area:202}. Finish them on the ride back east."] = "늑대는 안돌할, {area:200}, {area:202} 사이의 들판을 돌아다닙니다. 동쪽으로 돌아가는 길에 마저 처치하세요.",

	-- Step 12: Diseased Grizzlies
	["Diseased Grizzlies"] = "오염된 불곰",
	-- {area:202} Writhing Haunt
	["The bears roam the hills north and east of the {area:202}."] = "곰은 {area:202} 북쪽과 동쪽 언덕을 돌아다닙니다.",

	-- Step 13: Mulgris Deepriver
	-- {npc:5770} Nara Wildmane · {zone:1456} Thunder Bluff
	["Keep the branch: {npc:5770} is in {zone:1456}."] = "가지를 보관하세요: {npc:5770}은(는) {zone:1456}에 있습니다.",

	-- Step 14: Tirion Fordring
	-- {area:2620} Thondroril River · {zone:1423} Eastern Plaguelands
	["Ride north along the eastern hills; Tirion lives in a small house by the {area:2620}, at the border with the {zone:1423}."] = "동쪽 언덕을 따라 북쪽으로 가세요. 티리온은 {zone:1423}와(과)의 경계, {area:2620} 옆의 작은 집에 삽니다.",
	-- {zone:1423} Eastern Plaguelands
	["Tirion's hunts are in the {zone:1423}: keep them for later."] = "티리온의 사냥은 {zone:1423}에서 합니다. 나중을 위해 보관하세요.",

	-- Step 15: Kirsta Deepshadow
	-- {area:192} Northridge Lumber Camp · {npc:11610} Kirsta Deepshadow
	["Ride west to the {area:192}; {npc:11610} hides on the hill north-east of it."] = "서쪽의 {area:192}(으)로 가세요. {npc:11610}은(는) 그 북동쪽 언덕에 숨어 있습니다.",

	-- Step 16: Scarlet Crusade
	["Scarlet Crusade"] = "붉은십자군",
	-- {area:192} Northridge Lumber Camp
	["Knights and magi work the {area:192}; the medics and hunters camp south of it."] = "기사와 학자는 {area:192}에서 일하고, 의무병과 사냥꾼은 그 남쪽에 야영하고 있습니다.",

	-- Step 18: Radley and Durgen
	["Radley and Durgen"] = "래들리와 더건",
	-- {npc:11613} Huntsman Radley · {npc:11611} Cavalier Durgen · {npc:11610} Kirsta Deepshadow · {area:190} Hearthglen
	["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}."] = "{npc:11613}은(는) 벌목지 동쪽에 서 있고, {npc:11611}은(는) {npc:11610} 북동쪽, {area:190}(으)로 가는 길을 지키고 있습니다.",

	-- Step 20: Northridge Lumber Camp
	-- {npc:11610} Kirsta Deepshadow
	-- plural, as words: Scarlet Knights = {npc:1833} Scarlet Knight
	["{npc:11610}'s last task needs level 53. The Scarlet Knights and Magi (54-55) working the lumber camp just south-west of her are the closest camp."] = "{npc:11610}의 마지막 임무는 53레벨이 필요합니다. 그녀 바로 남서쪽 벌목지에서 일하는 붉은십자군 기사와 학자(54-55)가 가장 가까운 사냥터입니다.",
	-- {area:192} Northridge Lumber Camp · {zone:1422} Western Plaguelands
	-- plural, as words: Scarlet Knights = {npc:1833} Scarlet Knight
	["grind on Scarlet Knights at {area:192}, {zone:1422}"] = "{zone:1422} {area:192}에서 붉은십자군 기사 사냥",

	-- Step 22: Hearthglen
	-- {area:190} Hearthglen
	["{area:190}'s Scarlets are level 58-60. Ride in to the high point marked on your map, look over the town, and get out."] = "{area:190}의 붉은십자군은 58-60레벨입니다. 지도에 표시된 높은 곳까지 들어가 마을을 살펴본 뒤 빠져나오세요.",

	-- Step 24: Bulwark
	-- {area:152} Bulwark
	["Ride south-west past Felstone Farm and follow the road west back to the {area:152}."] = "남서쪽으로 펠스톤 농장을 지나 길을 따라 서쪽의 {area:152}(으)로 돌아가세요.",
	-- {npc:11615} Mickey Levine
	["Derrington's watchtowers, Vandis' cauldron and {npc:11615}'s barrel are done on a later visit: keep them."] = "데링턴의 감시탑, 반디스의 가마솥, {npc:11615}의 통은 나중에 들를 때 처리합니다. 보관하세요.",

	-- Step 25: To Felwood
	-- {zone:1448} Felwood
	["To {zone:1448}"] = "{zone:1448}(으)로",
	-- {area:1497} Undercity · {zone:1454} Orgrimmar · {area:431} Splintertree Post · {zone:1448} Felwood
	["Ride back to the {area:1497}, take the zeppelin to {zone:1454} and fly to {area:431}. Follow the road west out of Splintertree and take the fork north into {zone:1448}."] = "{area:1497}(으)로 돌아가 {zone:1454}행 비행선을 타고 {area:431}(으)로 날아가세요. 길을 따라 토막나무 주둔지에서 서쪽으로 나가, 갈림길에서 북쪽 {zone:1448}(으)로 가세요.",

	-- Step 26: Emerald Sanctuary
	["The druids' camp is just past the border."] = "드루이드 야영지는 경계를 막 지나서 있습니다.",
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, just west of the camp"] = "야영지 바로 서쪽의 {npc:9529}",

	-- Step 27: Southern Jaedenar
	-- {area:1763} Jaedenar
	["Southern {area:1763}"] = "{area:1763} 남부",
	-- {area:1763} Jaedenar
	["Follow the road north-west. The south of {area:1763}, around its corrupted moonwell, is held by Shadow Council cultists, adepts, guardsmen and their hounds."] = "길을 따라 북서쪽으로 가세요. {area:1763} 남부, 오염된 달샘 주변은 어둠의 의회 이교도, 숙련사제, 수호병과 사냥개가 차지하고 있습니다.",

	-- Step 28: A Strange Red Key
	-- {item:13140} Blood Red Key · {npc:11018} Arko'narin · {area:1770} Shadow Hold · {area:1763} Jaedenar
	["Only if a {item:13140} dropped: use it to start the quest, then free {npc:11018} in her cage in {area:1770}, the cave at the north end of {area:1763}, and escort her out."] = "{item:13140}을(를) 얻었을 때만: 사용해 퀘스트를 시작한 뒤, {area:1763} 북쪽 끝 동굴인 {area:1770}의 우리에 갇힌 {npc:11018}을(를) 풀어 주고 밖으로 호위하세요.",

	-- Step 29: Emerald Sanctuary
	["Ride back south-east to the Sanctuary."] = "남동쪽의 성소로 돌아가세요.",
	-- {npc:11554} Grazle
	["{npc:11554}, at the south edge of the camp"] = "야영지 남쪽 가장자리의 {npc:11554}",

	-- Step 30: Deadwood Village
	-- {area:1769} Timbermaw Hold
	["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers."] = "마른가지일족 털보숭이 마을은 성소 바로 남쪽에 있습니다. 마른가지일족을 처치할 때마다 {area:1769} 평판도 오릅니다. 깃털 머리장식은 보관하세요.",

	-- Step 31: Grazle
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["Only with 5 Deadwood Headdress Feathers"] = "마른가지일족 깃털 머리장식 5개가 있을 때만",

	-- Step 32: The Jaedenar moonwell
	-- {area:1763} Jaedenar
	["The {area:1763} moonwell"] = "{area:1763} 달샘",
	-- {area:1763} Jaedenar · {npc:10922} Greta Mosshoof
	["Back north to {area:1763}. Fill {npc:10922}'s canteen at the corrupted moonwell in the middle of the southern camp."] = "북쪽의 {area:1763}(으)로 돌아가세요. 남쪽 야영지 한가운데의 오염된 달샘에서 {npc:10922}의 수통을 채우세요.",

	-- Step 33: Rakaiah
	-- {npc:11018} Arko'narin · {npc:9518} Rakaiah · {area:1763} Jaedenar · {npc:11020} Remains of Trey Lightforge
	["Only if you rescued {npc:11018}: the succubus {npc:9518} waits in the middle of {area:1763}, beside the {npc:11020}."] = "{npc:11018}을(를) 구출했을 때만: 서큐버스 {npc:9518}이(가) {area:1763} 한가운데, {npc:11020} 옆에서 기다립니다.",

	-- Step 34: Bloodvenom Post
	-- {area:1763} Jaedenar
	["The Horde camp just north of {area:1763}."] = "{area:1763} 바로 북쪽의 호드 야영지입니다.",
	-- {npc:10306} Trull Failbane · {zone:1452} Winterspring
	["{npc:10306}: the owlbeasts are in {zone:1452}"] = "{npc:10306}: 올빼미야수는 {zone:1452}에 있습니다",

	-- Step 35: The Jadefire moonwell
	["The Jadefire moonwell"] = "비취불꽃 달샘",
	-- {area:1763} Jaedenar · {npc:9996} Winna Hazzard
	["Ride back south past {area:1763} to the corrupted moonwell of the Jadefire satyrs and fill {npc:9996}'s flasket there."] = "남쪽으로 {area:1763}을(를) 지나 비취불꽃의 사티로스가 있는 오염된 달샘으로 돌아가, 그곳에서 {npc:9996}의 작은 병을 채우세요.",

	-- Step 37: Winna Hazzard's kitten
	-- {npc:9996} Winna Hazzard
	["{npc:9996}'s kitten"] = "{npc:9996}의 새끼 고양이",
	-- {npc:10042} Corrupted Saber · {npc:9996} Winna Hazzard
	["Take the kitten to the same moonwell and release it there; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "새끼 고양이를 같은 달샘에 데려가 풀어 주세요. {npc:10042}(으)로 변하면 {npc:9996}에게 데려가 클릭해서 건네세요.",
	["Jadefire moonwell"] = "비취불꽃 달샘",

	-- Step 39: Shatter Scar Vale
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["East of Bloodvenom Post, the cratered vale where the Entropic Beasts and Horrors roam. Kill two of each, then walk to each of the three fel-water craters."] = "피멍울 초소 동쪽, 혼돈의 불길과 혼돈의 소산물이 돌아다니는 구덩이투성이 골짜기입니다. 각각 두 마리씩 처치한 뒤, 지옥 물 구덩이 세 곳을 모두 걸어서 찾아가세요.",
	["Southern crater"] = "남쪽 구덩이",
	["Western crater"] = "서쪽 구덩이",
	["Northern crater"] = "북쪽 구덩이",

	-- Step 40: Irontree Woods
	-- {area:1767} Irontree Woods · {item:11503} Blood Amber
	-- plural, as words: Warpwood Moss Flayers = {npc:7100} Warpwood Moss Flayer · Felpaw Ravagers = {npc:8961} Felpaw Ravager
	["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo."] = "길을 따라 북동쪽의 {area:1767}(으)로 가세요. 숲 동쪽의 굽이나무 이끼늪괴물과 갈퀴늪괴물은 각각 {item:11503}을(를) 지니고 있습니다. 같은 숲에서 탈로를 위해 성난발톱불곰과 갈퀴발톱 악령발늑대를 처치하세요.",

	-- Step 41: Nafien
	-- {npc:15395} Nafien · {area:1769} Timbermaw Hold
	["The road ends at {npc:15395}, outside the {area:1769} tunnel in the far north-east."] = "길은 맨 북동쪽 {area:1769} 터널 밖의 {npc:15395}에서 끝납니다.",

	-- Step 42: Felpaw Village
	-- {npc:9462} Chieftain Bloodmaw · {npc:11557} Meilosh
	["The Deadwood furbolg village just west of the tunnel. {npc:9462} (56) stands among them. {npc:11557}, a friendly furbolg, sits at the north end of the village."] = "터널 바로 서쪽의 마른가지일족 털보숭이 마을입니다. {npc:9462}(56)이(가) 그들 사이에 서 있습니다. 우호적인 털보숭이 {npc:11557}은(는) 마을 북쪽 끝에 앉아 있습니다.",
	-- {npc:11557} Meilosh · {quest:6031} Runecloth
	["{npc:11557}: keep 30 {quest:6031} for him; he trades only at Neutral with the Timbermaw"] = "{npc:11557}: {quest:6031} 30개를 보관하세요. 나무구렁 평판이 중립일 때만 거래합니다",
	-- {quest:8470} Deadwood Ritual Totem
	["{quest:8470}, a rare drop"] = "드물게 떨어지는 {quest:8470}",

	-- Step 43: Nafien
	-- {quest:8465} Speak to Salfa · {zone:1452} Winterspring
	["Keep {quest:8465} for {zone:1452}."] = "{zone:1452}을(를) 위해 {quest:8465}을(를) 보관하세요.",

	-- Step 44: Emerald Sanctuary
	-- {zone:1448} Felwood
	["Ride the road south through {zone:1448} to the Sanctuary."] = "길을 따라 남쪽으로 {zone:1448}을(를) 지나 성소로 가세요.",
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, on the west side of the Sanctuary"] = "성소 서쪽의 {npc:9529}",
	-- {quest:5158} Seeking Spiritual Aid · {npc:5901} Islen Waterseer · {zone:1413} Barrens
	["Keep {quest:5158}: {npc:5901} is in the {zone:1413}."] = "{quest:5158}을(를) 보관하세요: {npc:5901}은(는) {zone:1413}에 있습니다.",

	-- Step 45: Overlord Ror
	-- {area:1761} Deadwood Village
	["Ror stands at the far south end of {area:1761}."] = "로르는 {area:1761} 남쪽 끝에 서 있습니다.",

	-- Step 46: Bloodvenom Post
	["Ride north up the road again."] = "다시 길을 따라 북쪽으로 가세요.",

	-- Step 47: Felpaw Village
	-- {area:1762} Felpaw Village
	["Back at {area:1762}, the Deadwood furbolgs (53-54) are close to the tunnel and every kill raises your Timbermaw reputation."] = "{area:1762}에 돌아오면 마른가지일족 털보숭이(53-54)가 터널 가까이 있고, 처치할 때마다 나무구렁 평판이 오릅니다.",
	-- {area:1762} Felpaw Village · {zone:1448} Felwood
	-- plural, as words: Deadwood Avengers = {npc:7157} Deadwood Avenger
	["grind on Deadwood Avengers at {area:1762}, {zone:1448}"] = "{zone:1448} {area:1762}에서 마른가지일족 복수자 사냥",
	-- {npc:11558} Kernda
	["{npc:11558}, at the tunnel mouth"] = "터널 입구의 {npc:11558}",

	-- Step 48: Through Timbermaw Hold
	-- {area:1769} Timbermaw Hold
	["Through {area:1769}"] = "{area:1769} 통과",
	-- {area:1769} Timbermaw Hold · {npc:15395} Nafien · {zone:1452} Winterspring · {area:2255} Everlook
	["Walk into the {area:1769} tunnel beside {npc:15395} and never attack the Timbermaw furbolgs inside. The tunnel opens into {zone:1452}; follow the road east to {area:2255}, the goblin town where the next guide starts."] = "{npc:15395} 옆의 {area:1769} 터널로 들어가세요. 안쪽의 나무구렁 털보숭이는 절대 공격하지 마세요. 터널은 {zone:1452}(으)로 이어집니다. 길을 따라 동쪽으로 다음 가이드가 시작되는 고블린 마을 {area:2255}(으)로 가세요.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {area:152}"] = "{area:152}",
}
