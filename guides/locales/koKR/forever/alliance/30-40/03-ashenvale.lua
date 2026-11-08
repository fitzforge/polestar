-- Korean (koKR): the guide forever/alliance/30-40/03-ashenvale (forever/alliance/30-40/03-ashenvale.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Menethil Harbor
	-- {object:1162} Menethil Harbor (no name in this language: may be words)
	["Fly to {object:1162}"] = "",

	-- Step 2: Glorin Steelbrow
	-- {npc:1217} Glorin Steelbrow
	["{npc:1217} stands on the upper floor of Menethil's keep."] = "{npc:1217}은(는) 메네실 항구 성채의 위층에 있습니다.",
	["Inside"] = "",

	-- Step 3: Deepwater Tavern
	["Deepwater Tavern"] = "",

	-- Step 4: Waterlogged Chest
	["The wreck of the Flying Osprey lies in the shallows south of the keep."] = "Flying Osprey의 난파선은 성채 남쪽 얕은 물에 있습니다.",

	-- Step 5: Lightforge Ingots
	["The Bluegill murlocs on the beach south-west of Menethil carry the ingots."] = "메네실 항구 남서쪽 해변의 푸른아가미멀록들이 주괴를 지니고 있습니다.",
	-- {item:2702} Lightforge Ingot
	["{item:2702}; underwater"] = "",

	-- Step 6: Glorin Steelbrow
	-- {npc:1416} Grimand Elmore · {zone:1453} Stormwind
	["For {npc:1416} in {zone:1453}, after Stranglethorn"] = "",

	-- Step 8: Theramore
	["Theramore"] = "테라모어",
	-- {object:21057} Foothold Citadel (no name in this language: may be words) · {npc:5083} Clerk Lendry · {npc:4964} Commander Samaul
	["The flight master stands by the gate of {object:21057}; {npc:5083} and {npc:4964} are inside the citadel."] = "",
	-- {npc:5083} Clerk Lendry
	["{npc:5083}, on the top floor"] = "",
	-- {npc:4964} Commander Samaul
	["{npc:4964}, on the top floor"] = "",
	-- {npc:4456} Fiora Longears · {zone:1441} Thousand Needles
	["{npc:4456}: the wyverns are in {zone:1441}, later in this guide"] = "",

	-- Step 9: The Shady Rest Inn
	-- {zone:1413} Barrens
	["Follow the road west out of Theramore to the burned inn on the road toward the {zone:1413}: the black shield lies in the ashes and the hoofprints are in the mud beside the inn."] = "",

	-- Step 10: Into Barrens
	-- {zone:1413} Barrens
	["Into {zone:1413}"] = "",

	-- Step 11: Takar the Seer
	-- {zone:1413} Barrens · {npc:6244} Takar the Seer
	["On the road south through the {zone:1413}, {npc:6244} camps east of the road, north-east of Camp Taurajo; come in from the east and keep clear of the Horde guards."] = "",
	-- {quest:1738} Heartswood · {zone:1440} Ashenvale · {zone:1443} Desolace
	["{quest:1738}: in {zone:1440}, on the way to {zone:1443}"] = "{quest:1738}: {zone:1443}(으)로 가는 길에 {zone:1440}에서",
	-- {quest:65602} What Is Love? · {item:190309} Wooden Figurine · {quest:1738} Heartswood
	["{quest:65602}: the incubus, beside the succubus; the {item:190309} is near the {quest:1738}"] = "{quest:65602}: 서큐버스 옆의 인큐버스. {item:190309}은(는) {quest:1738} 근처에 있습니다",

	-- Step 12: Highperch
	["Highperch"] = "",
	-- {object:19844} Great Lift · {zone:1441} Thousand Needles
	["Down the {object:19844} into {zone:1441}, then west to the wyverns' cliffs at Highperch. Every wyvern there can drop a venom sac."] = "",

	-- Step 15: Mirage Raceway
	["Mirage Raceway"] = "",
	["Follow the canyons east to the salt flats. The goblins and gnomes of the Mirage Raceway are neutral and give quests to both factions."] = "",
	-- {quest:5762} Hemet Nesingwary
	["For {quest:5762} in Stranglethorn, later"] = "나중에 가시덤불 골짜기에서 {quest:5762}에게",

	-- Step 16: Mirage Raceway: kill these as you meet them
	["Mirage Raceway: kill these as you meet them"] = "",
	-- {object:19868} Rocket Car Rubble
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver · Salt Flats Scavengers = {npc:4154} Salt Flats Scavenger · Sparkleshell Snappers = {npc:4143} Sparkleshell Snapper · Saltstone Basilisks = {npc:4147} Saltstone Basilisk
	["{object:19868} lies all over the flats. Scorpid Reavers and Salt Flats Scavengers roam the north half, Sparkleshell Snappers (tortoises) the whole flats. Saltstone Basilisks and Crystalhides hold the middle; the Gazers (34-35) only the far south."] = "",

	-- Step 17: Mirage Raceway
	-- {npc:4454} Fizzle Brassbolts · {zone:1418} Badlands
	["{npc:4454}: for Martek in the {zone:1418}, at the end of 30-40"] = "",

	-- Step 18: Gadgetzan
	["Gadgetzan"] = "",
	-- {object:151976} Shimmering Flats (no name in this language: may be words) · {zone:1446} Tanaris · {npc:7823} Bera Stonehammer
	["From the raceway follow the road south out of the {object:151976} into {zone:1446}; Gadgetzan is a short walk down it. Keep to the road. {npc:7823}, the Alliance flight master, stands inside the walls."] = "",

	-- Step 19: Fly to Theramore
	["Fly to Theramore"] = "테라모어 섬으로 비행",
	["Gadgetzan flight master"] = "",

	-- Step 20: Theramore
	-- {npc:4456} Fiora Longears · {object:21057} Foothold Citadel (no name in this language: may be words) · {npc:4941} Caz Twosprocket
	["{npc:4456} is in the north of town, Captain Vimes in {object:21057}; {npc:4941} stands in the town."] = "",

	-- Step 21: Boat to Menethil Harbor
	-- {object:1162} Menethil Harbor (no name in this language: may be words)
	["Boat to {object:1162}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back west along the road to the satyr camps of {area:429}."] = "길을 따라 서쪽으로 {area:429}의 사티로스 야영지에 돌아가십시오.",
	-- ["Dartol's Rod"] = "다르톨의 변신마법봉",
	-- ["Follow the road east to the satyr camps of {area:429}; {npc:3920} hides at their edge."] = "길을 따라 동쪽으로 {area:429}의 사티로스 야영지까지 가십시오. {npc:3920}은(는) 야영지 가장자리에 숨어 있습니다.",
	-- ["Follow the road west out of {area:415}; {area:413} lies north of it."] = "길을 따라 {area:415} 서쪽으로 나가십시오. {area:413}은(는) 길 북쪽에 있습니다.",
	-- ["From {area:608}"] = "{area:608}에서",
	-- ["Geltharis"] = "겔타리스",
	-- ["Insane druids"] = "미치광이 드루이드",
	-- ["Lightforge Ingots"] = "라이트포지 주괴",
	-- ["Melyria and {npc:3901}"] = "파수꾼 멜리리아 프로스트섀도와 {npc:3901}",
	-- ["Rusty chests lie around the Shadethicket furbolg camps west of the Forsaken; open them until one holds the pommel."] = "포세이큰 야영지 서쪽의 그늘덤불 야영지 주변에 녹슨 궤짝이 있습니다. 철제 머리장식이 나올 때까지 열어 보십시오.",
	-- ["Take the boat to {area:150} from {area:442}'s docks."] = "{area:442} 부두에서 {area:150}행 배를 타십시오.",
	-- ["Take the tunnel into the {area:419}; the tome lies in the ruins at its west end."] = "굴을 지나 {area:419}(으)로 들어가십시오. 마법책은 서쪽 끝 폐허에 있습니다.",
	-- ["The Crazed and Withered Ancients north of the moonwell carry the {item:5475}; the worn chest it opens stands among them."] = "달샘 북쪽의 광기어린 고대정령과 부패한 고대정령이 {item:5475}을(를) 지니고 있습니다. 그 열쇠로 여는 낡은 궤짝은 그들 사이에 있습니다.",
	-- ["The Forsaken's camp lies in the woods south of {area:2358}."] = "포세이큰 야영지는 {area:2358} 남쪽 숲에 있습니다.",
	-- ["The moonwell lies in the hills north-east of {area:415}."] = "달샘은 {area:415} 북동쪽 언덕에 있습니다.",
	-- ["The second {object:19901} lies in the valley of {area:428}, on the way west."] = "두 번째 {object:19901}은(는) 서쪽으로 가는 길, {area:428} 골짜기에 있습니다.",
	-- ["The shrine sits on the hill just south-east of the moonwell; follow the winding path up."] = "제단은 달샘 바로 남동쪽 언덕 위에 있습니다. 구불구불한 길을 따라 올라가십시오.",
	-- ["The three druids stand together at the Forsaken camp south of {area:2358}."] = "세 드루이드는 {area:2358} 남쪽 포세이큰 야영지에 함께 있습니다.",
	-- ["The two stand together at the western end of the road."] = "두 사람은 길 서쪽 끝에 함께 서 있습니다.",
	-- ["The wreck of the Flying Osprey lies in the shallows south of the keep."] = "Flying Osprey의 난파선은 성채 남쪽 얕은 물에 있습니다.",
	-- ["The {npc:3931} walks the shore of {quest:1035}, south-west of the chests; the {object:669176} lies north of the lake, on the way."] = "{npc:3931}은(는) 궤짝 남서쪽의 {quest:1035} 호숫가를 걷습니다. {object:669176}은(는) 가는 길, 호수 북쪽에 있습니다.",
	-- ["The {object:19901} stands in the satyr camp of {area:430}, further east along the road."] = "{object:19901}은(는) 길을 따라 더 동쪽, {area:430}의 사티로스 야영지에 있습니다.",
	-- ["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} and {npc:221269} stand there."] = "길 동쪽 끝의 나이트 엘프 전초기지 {area:2358}: {npc:3848}와(과) {npc:221269}이(가) 그곳에 있습니다.",
	-- ["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} stands there."] = "길 동쪽 끝의 나이트 엘프 전초기지 {area:2358}: {npc:3848}이(가) 그곳에 있습니다.",
	-- ["{area:429} satyrs"] = "{area:429} 사티로스",
	-- ["{npc:1217} stands on the upper floor of Menethil's keep."] = "{npc:1217}은(는) 메네실 항구 성채의 위층에 있습니다.",
	-- ["{npc:3696} and his guards camp just east of {npc:3897}."] = "{npc:3696}와(과) 그의 경비병들은 {npc:3897} 바로 동쪽에 진을 치고 있습니다.",
	-- ["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below {area:421}."] = "타락하지 않은 펄볼그 {npc:3897}은(는) {area:421} 아래 길 남쪽에 앉아 있습니다.",
	-- ["{npc:3970}: for {npc:1480} in Menethil, at the end of this guide"] = "{npc:3970}: 이 가이드 끝에서 메네실 항구의 {npc:1480}에게",
	-- ["{npc:4619} leads the {area:429} satyrs; he carries the branch."] = "{npc:4619}은(는) {area:429} 사티로스의 우두머리이며 나뭇가지를 지니고 있습니다.",
	-- ["{npc:5082}, {npc:4963} and Tapoke Jahn are all at Menethil's inn; {npc:4962} fights you when you talk to {npc:4963}, but gives up once beaten. {npc:1480} stands a short walk north-east of the inn."] = "{npc:5082}, {npc:4963}, {npc:4962}은(는) 모두 메네실 항구 여관에 있습니다. {npc:4963}와(과) 대화하면 타포케가 덤벼들지만, 쓰러뜨리면 포기합니다. {npc:1480}은(는) 여관에서 북동쪽으로 조금 걸어간 곳에 있습니다.",
	-- ["{object:669176}: for {npc:3961} in {area:415}"] = "{object:669176}: {area:415}의 {npc:3961}에게",
}
