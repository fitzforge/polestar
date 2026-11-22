-- Korean (koKR): the guide forever/class/rogue/the-azure-key (forever/class/rogue/the-azure-key.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ravenholdt reputation and experience at 50; Classic's item choice may be gone on Forever."] = "50레벨에 얻는 라벤홀트 암살단 평판과 경험치. Forever에서는 클래식의 아이템 선택 보상이 없어졌을 수 있습니다.",
	["Ravenholdt reputation"] = "라벤홀트 암살단 평판",

	-- Step 1: A Simple Request (Alliance)
	-- {quest:8233} A Simple Request
	["{quest:8233} (Alliance)"] = "{quest:8233} (얼라이언스)",
	-- {npc:918} Osborne the Night Man · {zone:1453} Stormwind · {object:2100} Old Town · {zone:1457} Darnassus · {npc:5165} Hulfdan Blackbeard · {zone:1455} Ironforge
	["At 50 {npc:918} in {zone:1453}'s {object:2100} has it; so do Syurna in {zone:1457} and {npc:5165} in {zone:1455}."] = "50레벨에 {zone:1453} {object:2100}의 {npc:918}이(가) 줍니다. {zone:1457}의 시우르나, {zone:1455}의 {npc:5165}도 줍니다.",

	-- Step 2: A Simple Request (Horde)
	-- {quest:8233} A Simple Request
	["{quest:8233} (Horde)"] = "{quest:8233} (호드)",
	-- {npc:3328} Ormok · {object:172960} Cleft of Shadow · {npc:4583} Miles Dexter · {zone:1458} Undercity · {object:36073} Rogues' Quarter
	["At 50 {npc:3328} in the {object:172960} has it; so does {npc:4583} in the {zone:1458}'s {object:36073}."] = "50레벨에 {object:172960}의 {npc:3328}이(가) 줍니다. {zone:1458} {object:36073}의 {npc:4583}도 줍니다.",

	-- Step 3: Lord Jorach Ravenholdt
	-- {area:3486} Ravenholdt Manor · {area:272} Tarren Mill · {area:271} Southshore · {area:275} Durnholde Keep · {zone:1416} Alterac Mountains
	["{area:3486} hides in the hills east of {area:272}. Horde fly to {area:272}, Alliance to {area:271}. The trail starts behind the plateau north of {area:275}, climbs into the hills and runs through a small tunnel into the {zone:1416}; Lord Jorach is inside the manor. Do not attack anyone at the manor: lost Ravenholdt reputation makes him refuse to speak to you."] = "{area:3486}은(는) {area:272} 동쪽 언덕에 숨어 있습니다. 호드는 {area:272}로, 얼라이언스는 {area:271}로 날아가세요. 길은 {area:275} 북쪽 고원 뒤에서 시작해 언덕으로 올라가 작은 터널을 지나 {zone:1416}으로 이어집니다. 저택 안에 조사원이 있습니다. 저택에서 아무도 공격하지 마세요. 레이븐홀드 평판이 깎이면 그가 말을 거부합니다.",

	-- Step 4: Sealed Azure Bag
	-- {area:3137} Talrendis Point · {area:1237} Valormok · {zone:1447} Azshara · {spell:921} Pick Pocket · {area:1769} Timbermaw Hold · {spell:403} Lightning Bolt · {spell:6535} Lightning Cloud
	-- plural, as words: Timbermaw Shamans = {npc:6188} Timbermaw Shaman
	["Alliance fly to {area:3137}, Horde to {area:1237}. Only the level 50-51 Timbermaw Shamans in the furbolg hills of northern {zone:1447} carry the bag (the level 47-49 furbolgs further south do not): about one kill in thirty drops it. {spell:921} them instead and you lose no Timbermaw reputation; if you are Unfriendly or better with {area:1769}, mark them At War in your reputation panel first. They cast {spell:403} and {spell:6535}, heal each other and run at low health."] = "얼라이언스는 {area:3137}로, 호드는 {area:1237}로 날아가세요. {zone:1447} 북부 퍼볼그 언덕의 50-51레벨 나무엄니 술사만 가방을 지닙니다(더 남쪽의 47-49레벨 퍼볼그는 아님). 서른 마리쯤 잡으면 하나가 나옵니다. 대신 {spell:921}을(를) 쓰면 나무엄니 평판이 깎이지 않습니다. {area:1769}과(와) 중립 이상이라면 평판 창에서 먼저 전쟁 상태로 표시하세요. 그들은 {spell:403}과(와) {spell:6535}을(를) 시전하고 서로를 치료하며 체력이 낮아지면 도망칩니다.",

	-- Step 5: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo · {area:1237} Valormok
	["{npc:8395}, camped below the cliffs just east of {area:1237}, teleports you up (dismount first); a trail leads to Xylem's tower."] = "{npc:8395}은(는) {area:1237} 바로 동쪽 절벽 아래에 야영하며 위로 텔레포트해 줍니다(먼저 하차하세요). 길이 틸럼의 탑으로 이어집니다.",

	-- Step 6: Encoded Fragments
	-- {spell:6907} Diseased Slime · {area:2497} Bitter Reaches · {zone:1447} Azshara · {area:1237} Valormok
	-- plural, as words: Forest Oozes = {npc:8766} Forest Ooze · Mistwing Ravagers = {npc:8764} Mistwing Ravager
	["The Forest Oozes (level 52-53, {spell:6907} up close) drop a fragment four times in five: the biggest group, seven of them, is in the {area:2497} hills of north-eastern {zone:1447}, four more south-east of {area:1237}. Pick their pockets before the kill for an extra fragment or two. Killing the Mistwing Ravagers and hippogryphs that share their spots makes more oozes appear."] = "숲 점액질(52-53레벨, 가까이서 {spell:6907})은 다섯 번 중 네 번 파편을 떨어뜨립니다. 가장 큰 무리는 {zone:1447} 동북부 {area:2497} 언덕의 일곱 마리이고, {area:1237} 동남쪽에 네 마리가 더 있습니다. 처치 전에 주머니를 털면 파편이 하나 더 나올 수 있습니다. 같은 지점에 나오는 안개날개 약탈자와 히포그리프를 처치하면 점액질이 더 나타납니다.",

	-- Step 7: Back to Xylem
	["Back to Xylem"] = "실렘에게 돌아가기",

	-- Step 8: Morphaz in the Sunken Temple
	-- {area:1417} Sunken Temple
	["Morphaz in the {area:1417}"] = "{area:1417}의 몰파즈",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears · {area:75} Stonard · {area:1438} Nethergarde Keep · {npc:5710} Jammal'an the Prophet · {spell:12533} Acid Breath · {spell:2094} Blind
	["Morphaz, a level 52 elite green drake, lives deep in the {area:1417}: a group of five, level 50-54. The temple stands in the {area:74}; climb into the sunken building, swim down through it and follow the passage to the portal. Horde: fly to {area:75}; Alliance: fly to {area:1438} and ride on. He is not there when you arrive: first kill the six troll guardians (elites of 50-52) on the platforms around the upper ring, which opens the way down (the left-hand ramp from the entrance) to {npc:5710} in the Pit of Sacrifice. Jammal'an's death brings out two drakes, Weaver and Dreamscythe; when both are dead, Morphaz and Hazzas appear together and fight as a pair. Their {spell:12533} is nature damage: nature protection potions help; poisons and {spell:2094} do not work on them. The key always drops. Hunters, Priests and Mages of 50 need Morphaz too: one clear serves them all."] = "모르파즈는 {area:1417} 깊은 곳에 사는 52레벨 정예 녹색 용입니다. 50-54레벨 5인 파티가 필요합니다. 사원은 {area:74}에 있습니다. 가라앉은 건물로 올라가 안에서 수영해 내려가 통로를 따라 차원문으로 가세요. 호드는 {area:75}로, 얼라이언스는 {area:1438}로 날아가 말을 타고 가세요. 도착할 때 그는 없습니다. 먼저 상층 발판의 트롤 여섯 명(50-52레벨 정예)을 처치하면 입구 왼쪽 경사로로 {npc:5710}이(가) 있는 희생의 구덩이에 내려갑니다. 잠말란이 죽으면 직조자와 꿈낫이 나오고, 둘 다 죽으면 모르파즈와 하자스가 함께 나와 한 쌍으로 싸웁니다. 그들의 {spell:12533}은 자연 피해이니 자연 저항 물약이 도움이 되며 독과 {spell:2094}은(는) 통하지 않습니다. 열쇠는 반드시 떨어집니다. 50레벨 사냥꾼, 사제, 마법사도 모르파즈가 필요하니 한 번 돌면 모두 해결됩니다.",
	-- {item:20022} Azure Key
	["{item:20022}: Morphaz, inside the temple"] = "{item:20022}: 신전 안의 몰파즈",

	-- Step 9: Lord Ravenholdt
	["Lord Ravenholdt"] = "라벤홀트 경",
	-- {item:19982} Duskbat Drape · {item:19984} Ebon Mask · {item:20255} Whisperwalk Boots
	["Look at the reward window before you hand in: Classic offered the {item:19982}, the {item:19984} or the {item:20255}, and Forever's notes say the choice may be gone."] = "제출하기 전에 보상 창을 확인하세요. 클래식에서는 {item:19982}, {item:19984} 또는 {item:20255}을(를) 선택했지만 Forever 변경 사항에는 선택이 사라졌을 수 있다고 적혀 있습니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Alliance fly to {area:3137}, Horde to {area:1237}. The Timbermaw Shamans in {zone:1447}'s northern hills drop the bag, about one in thirty."] = "얼라이언스는 {area:3137}, 호드는 {area:1237}(으)로 비행하십시오. {zone:1447} 북쪽 언덕의 나무구렁일족 주술사가 약 30분의 1 확률로 자루를 떨어뜨립니다.",
	-- ["Morphaz, a green drake, is an elite boss deep in the {area:1417}, a level 50 dungeon: bring a group of five. The temple stands in the {area:74}; swim down to the entrance. Horde: fly to {area:75}; Alliance: fly to {area:1438} and ride on."] = "녹색 비룡 몰파즈는 레벨 50 던전인 {area:1417} 깊은 곳의 정예 우두머리입니다: 5인 파티를 꾸리십시오. 신전은 {area:74}에 있으니 입구까지 헤엄쳐 내려가십시오. 호드는 {area:75}(으)로, 얼라이언스는 {area:1438}(으)로 비행한 뒤 달려가십시오.",
	-- ["The Forest Oozes of southern {zone:1447} drop the fragments."] = "{zone:1447} 남부의 숲수액괴물이 페이지를 떨어뜨립니다.",
	-- ["{area:3486} hides in the hills east of {area:272}, up a path into the {zone:1416}. Horde fly to {area:272}, Alliance to {area:271}."] = "{area:3486}은(는) {area:272} 동쪽 언덕, {zone:1416}(으)로 올라가는 길 위에 숨어 있습니다. 호드는 {area:272}, 얼라이언스는 {area:271}(으)로 비행하십시오.",
	-- ["{npc:6768}: no item choices in Forever"] = "{npc:6768}: Forever에서는 아이템 선택 없음",
}
