-- Korean (koKR): the guide forever/class/mage/destroy-morphaz (forever/class/mage/destroy-morphaz.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1447} Azshara · {area:1417} Sunken Temple
	["Experience at 50 through {zone:1447} and the {area:1417}; Classic's item choice may be gone on Forever."] = "50레벨에 {zone:1447}와(과) {area:1417}을(를) 거치며 얻는 경험치. Forever에서는 클래식의 아이템 보상 선택이 사라졌을 수 있습니다.",
	["Experience"] = "경험치",

	-- Step 1: Magecraft (Stormwind)
	-- {npc:331} Maginor Dumas · {zone:1453} Stormwind · {object:2101} Mage Quarter · {zone:1455} Ironforge
	["{npc:331}, the Master Mage, stands in the Wizard's Sanctum in {zone:1453}'s {object:2101}; Dink in {zone:1455} gives the same quest."] = "마법사 길드장 {npc:331}은(는) {zone:1453} {object:2101}의 마법사의 성소에 있습니다. {zone:1455}의 딩크도 같은 퀘스트를 줍니다.",

	-- Step 2: Magecraft (Orgrimmar)
	-- {npc:7311} Uthel'nay · {zone:1454} Orgrimmar · {object:173161} Darkbriar Lodge · {npc:4567} Pierce Shackleton · {zone:1458} Undercity · {npc:3047} Archmage Shymm · {zone:1456} Thunder Bluff
	["{npc:7311}, one of {zone:1454}'s mage trainers in {object:173161}, gives it; so do {npc:4567} in the {zone:1458} and {npc:3047} in {zone:1456}."] = "{zone:1454}의 {object:173161}에 있는 마법사 상급자 중 한 명인 {npc:7311}이(가) 줍니다. {zone:1458}의 {npc:4567}와(과) {zone:1456}의 {npc:3047}도 줍니다.",

	-- Step 3: Sanath Lim-yo
	-- {area:3137} Talrendis Point · {area:1237} Valormok · {npc:8395} Sanath Lim-yo · {zone:1447} Azshara · {area:1221} Ruins of Eldarath · {npc:8379} Archmage Xylem
	["Fly to {area:3137} (Alliance) or {area:1237} (Horde). {npc:8395} camps below his master's tower, a short way east of {area:1237}: from the fork of {zone:1447}'s main road at the {area:1221}, head straight north to the cliffs. Get off your mount before he teleports you up, or the teleport may not take you. A trail with no enemies climbs to {npc:8379} at the top of the tower; an attendant at the top sends you back down, as often as you like."] = "{area:3137}(얼라이언스) 또는 {area:1237}(호드)(으)로 날아가세요. {npc:8395}은(는) {area:1237}에서 동쪽으로 조금 떨어진 스승의 탑 아래에 야영합니다. {zone:1447} 큰길의 {area:1221} 갈림길에서 곧장 북쪽 절벽으로 가세요. 그가 순간이동시켜 주기 전에 탈것에서 내리세요. 그렇지 않으면 순간이동이 되지 않을 수 있습니다. 적이 없는 오솔길이 탑 꼭대기의 {npc:8379}에게 이어지며, 꼭대기의 시종이 원하는 만큼 다시 내려보내 줍니다.",
	-- {npc:8379} Archmage Xylem
	["{npc:8379}, in the tower"] = "탑 안의 {npc:8379}",

	-- Step 4: Glittering Dust
	-- {area:1220} Thalassian Base Camp · {zone:1447} Azshara · {spell:8349} Fire Nova · {spell:133} Fireball · {spell:139} Renew
	-- plural, as words: Blood Elf Surveyors = {npc:6198} Blood Elf Surveyor
	["The blood elves hold the {area:1220} on the hills of north-eastern {zone:1447}. Blood Elf Surveyors (51-52, {spell:8349} up close) and Reclaimers (52-53, {spell:133}, and they heal and {spell:139} each other) each drop the dust about one time in four; they spot you from far off, so pull at the edges. They come back after 5 1/2 minutes."] = "블러드 엘프가 {zone:1447} 동북부 언덕의 {area:1220}을(를) 지킵니다. 블러드 엘프 측량사(51-52레벨, 가까이서 {spell:8349})와 재건자(52-53레벨, {spell:133}을(를) 쓰고 서로 치료하고 {spell:139}도 시전)가 네 번에 한 번꼴로 가루를 떨어뜨립니다. 멀리서 눈치채니 가장자리에서 끌어오세요. 5분 30초 후 다시 나옵니다.",

	-- Step 5: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo
	["Back to {npc:8395}, who teleports you up to the tower."] = "{npc:8395}에게 돌아가면 탑 위로 순간이동시켜 줍니다.",

	-- Step 6: Enchanted Coral
	-- {area:1221} Ruins of Eldarath · {area:1237} Valormok · {area:1223} Temple of Zin-Malor · {npc:7864} Lingering Highborne
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren · Spitelash Screamers = {npc:6193} Spitelash Screamer
	["The Spitelash Sirens (level 50-52) walk the ruins and beaches around the {area:1221} and the bay east of {area:1237}, often three together, and a few stand inside the {area:1223}; each drops a coral about one time in four. The Spitelash Screamers look almost the same but never drop it. Killing the other naga there makes more Sirens appear in their spots. {npc:7864} ghosts wander the ruins: watch your back."] = "원한채찍 사이렌(50-52레벨)이 {area:1221} 주변 폐허와 해변, {area:1237} 동쪽 만을 돌아다니며 보통 세 마리씩이고 {area:1223} 안에도 몇 마리가 있습니다. 네 번에 한 번꼴로 산호를 떨어뜨립니다. 원한채찍 비명지음이는 거의 똑같이 생겼지만 산호를 떨어뜨리지 않습니다. 그곳의 다른 나가를 처치하면 사이렌이 그 지점에 더 나타납니다. {npc:7864} 유령이 폐허를 배회하니 뒤를 살피세요.",

	-- Step 7: Archmage Xylem again
	-- {npc:8379} Archmage Xylem
	["{npc:8379} again"] = "다시 {npc:8379}",
	-- {npc:8395} Sanath Lim-yo
	["Back to {npc:8395} and up to the tower."] = "{npc:8395}에게 돌아가 탑으로 올라가세요.",

	-- Step 8: Morphaz
	["Morphaz"] = "몰파즈",
	-- {area:1477} The Temple of Atal'Hakkar · {area:1417} Sunken Temple · {area:74} Pool of Tears · {npc:5710} Jammal'an the Prophet · {npc:5711} Ogom the Wretched · {spell:12533} Acid Breath · {spell:11019} Wing Flap
	["{area:1477}, the {area:1417}, lies in the {area:74}: climb the steps into the sunken building, swim down through it and follow the passage down to the portal. A group of five, level 50-54. Morphaz is not waiting when you arrive. First kill the six troll guardians (elites of 50-52) on the platforms around the upper ring; that opens the way down (the left-hand ramp from the entrance) to {npc:5710} and {npc:5711} in the Pit of Sacrifice. Once Jammal'an dies, two green drakes, Weaver and Dreamscythe, come out and patrol the pit: pull them one at a time. When both are dead, Morphaz (level 52 elite, {spell:12533} and {spell:11019}) and Hazzas appear together and cannot be split, so fight both. The shard always drops. Hunters, Priests and Rogues of 50 need Morphaz too: a group of them shares one clear."] = "{area:1477}, 즉 {area:1417}은(는) {area:74}에 있습니다. 계단을 올라 가라앉은 건물로 들어가 수영해 내려가 통로를 따라 차원문까지 가세요. 50-54레벨 5인 파티입니다. 모르파즈는 도착했을 때 없습니다. 먼저 상층 고리 주변 발판의 트롤 여섯 명(50-52레벨 정예)을 처치하면 입구 왼쪽 경사로로 {npc:5710}과(와) {npc:5711}이(가) 있는 희생의 구덩이에 내려갑니다. 잠말란이 죽으면 녹색 용 직조자와 꿈낫 두 마리가 나와 구덩이를 순찰하니 하나씩 끌어오세요. 둘 다 죽으면 모르파즈(52레벨 정예, {spell:12533}, {spell:11019})와 하자스가 함께 나타나 떼어낼 수 없으니 둘 다 상대하세요. 파편은 반드시 떨어집니다. 50레벨 사냥꾼, 사제, 도적도 모르파즈가 필요하니 파티가 한 번 돌면 모두 해결됩니다.",
	-- {item:20085} Arcane Shard
	["{item:20085}: Morphaz"] = "{item:20085}: 몰파즈",

	-- Step 9: The Arcane Shard
	-- {item:20085} Arcane Shard
	["The {item:20085}"] = "{item:20085}",
	-- {zone:1447} Azshara · {npc:8395} Sanath Lim-yo · {item:20037} Arcane Crystal Pendant · {item:20036} Fire Ruby · {item:20035} Glacial Spike
	["Back to {zone:1447}, {npc:8395} and the tower. Look at the reward window before you hand in: Classic offered the {item:20037}, the {item:20036} or the {item:20035}, and Forever's notes say the choice may be gone."] = "{zone:1447}, {npc:8395}과(와) 탑으로 돌아가세요. 제출하기 전에 보상 창을 확인하세요. 클래식에서는 {item:20037}, {item:20036} 또는 {item:20035}을(를) 선택했지만 Forever 변경 사항에는 선택이 사라졌을 수 있다고 적혀 있습니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {zone:1447}, {npc:8395} and the tower."] = "{zone:1447}의 {npc:8395}에게 돌아가 탑으로 가세요.",
	-- ["Morphaz, a green drake, waits deep in the {area:1477}, the {area:1417} in the {area:74}: a group of five, level 50-54. Kill him for the {item:20085}."] = "녹색 비룡 몰파즈는 {area:74}에 있는 {area:1417}, {area:1477} 깊숙한 곳에서 기다립니다. 5인 파티, 레벨 50-54. 그를 처치해 {item:20085}을(를) 얻으세요.",
	-- ["The Spitelash Sirens walk the ruins and beaches around the {area:1221} and the bay; they carry the coral."] = "원한의꼬리일족 세이렌이 {area:1221}와(과) 만 주변의 폐허와 해변을 돌아다니며, 산호를 가지고 있습니다.",
	-- ["The blood elves camp along the cliffs of north-eastern {zone:1447}; Blood Elf Surveyors and Reclaimers drop the dust."] = "블러드 엘프들은 {zone:1447} 북동부 절벽을 따라 야영합니다. 블러드 엘프 감정관과 블러드 엘프 수색꾼이 가루를 떨어뜨립니다.",
}
