-- Korean (koKR): the guide forever/class/druid/bloodpetal-poison (forever/class/druid/bloodpetal-poison.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Experience in Un'Goro at 50 and two healing potions; the Classic item choice may be gone in Forever."] = "50레벨에 운고로 경험치와 치유 물약 두 개. Forever에서는 클래식의 아이템 선택이 사라졌을 수 있습니다.",

	-- Step 1: Loganaar
	-- {spell:18960} Teleport: Moonglade · {npc:12042} Loganaar · {area:2361} Nighthaven · {npc:3033} Turak Runetotem · {npc:4217} Mathrengyl Bearwalker · {zone:1453} Stormwind
	["Cast {spell:18960}. {npc:12042} stands in {area:2361}; your class trainer ({npc:3033}, {npc:4217} or Theridran in {zone:1453}) offers the same quest."] = "{spell:18960}을(를) 시전하세요. {npc:12042}은(는) {area:2361}에 서 있습니다. 직업 상급자({npc:3033}, {npc:4217} 또는 {zone:1453}의 테리드란)도 같은 퀘스트를 줍니다.",

	-- Step 2: Torwa Pathfinder
	-- {area:976} Gadgetzan · {zone:1449} Un'Goro Crater · {npc:9619} Torwa Pathfinder
	["Fly to {area:976}, ride west to the long ramp down into {zone:1449}: {npc:9619} camps at its foot, in the south-east corner of the crater."] = "{area:976}(으)로 날아가 서쪽으로 {zone:1449}(으)로 내려가는 긴 비탈까지 가세요. {npc:9619}은(는) 그 아래, 분화구 남동쪽 구석에 진을 치고 있습니다.",

	-- Step 3: Gorishi Stings and Bloodcap
	-- {item:22434} Bloodcap
	-- plural, as words: Gorishi Stings = {item:22435} Gorishi Sting
	["Gorishi Stings and {item:22434}"] = "고리쉬 독침과 {item:22434}",
	-- {area:540} Slithering Scar · {spell:8137} Silithid Pox · {area:541} Marshal's Refuge · {item:22434} Bloodcap
	-- plural, as words: Gorishi Wasps = {npc:6551} Gorishi Wasp · Bloodpetal Sprouts = {object:164958} Bloodpetal Sprout
	["Eight of each. The Gorishi Wasps and Stingers (level 51-52) in and around the {area:540}, the hive in the south-west of the crater, drop a sting about one kill in seven; the wasps share spawn points with the other bugs, so kill whatever stands near you to make room for more wasps (respawn five minutes). The bugs' {spell:8137} makes you take more physical damage for 30 minutes; Workers call for help when hurt. The Bloodpetal Sprouts grow all over the crater (around {area:541} and the western half): open them, about every other one gives a {item:22434}, back in three to five minutes."] = "각각 여덟 개가 필요합니다. 분화구 남서부 벌집 {area:540} 안팎의 고리시 말벌과 쏘는 놈(51-52레벨)이 일곱 번에 한 번꼴로 독침을 떨어뜨립니다. 말벌은 다른 벌레와 같은 지점에서 나오니 곁에 있는 것을 잡아 말벌 자리를 만들어 주세요(5분 후 리스폰). 벌레의 {spell:8137}은(는) 30분간 물리 피해를 더 받게 합니다. 일꾼은 다치면 도움을 부릅니다. 핏빛꽃 새싹은 분화구 전체({area:541} 주변과 서쪽 절반)에 자랍니다. 열어 보면 대략 두 번에 한 번 {item:22434}이(가) 나오고 3~5분 후 다시 자랍니다.",

	-- Step 5: Toxic Test
	-- {spell:14099} Mighty Blow · {spell:339} Entangling Roots · {item:22432} Devilsaur Barb · {spell:2637} Hibernate · {npc:6499} Ironhide Devilsaur · {npc:9619} Torwa Pathfinder
	-- plural, as words: Tyrant Devilsaurs = {npc:6500} Tyrant Devilsaur
	-- was: ["Any {npc:6498} counts, the Ironhide and Tyrant Devilsaurs too. They are elite (level 54-55), hit with {spell:14099} and outrun travel form. Grouping up is encouraged, but a druid can do it alone: Hibernate or {spell:339} it from range, stab it with the {item:22432} (the barb does not break {spell:2637}), then leave. The credit counts the moment the barb lands, even if you die after. The arrow points at the plain Devilsaurs of the west and north; an {npc:6499} roams the middle of the crater's south, nearer {npc:9619}."] = "어떤 {npc:6498}이나 상관없습니다. 철가죽과 폭군 데비소어도 포함됩니다. 정예(54-55레벨)이며 {spell:14099}으로 때리고 이동 형태보다 빠릅니다. 파티를 권장하지만 드루이드도 혼자 가능합니다. 원거리에서 수면 또는 {spell:339}을(를) 걸고 {item:22432}으로 찌른 뒤(가시가 {spell:2637}을 깨뜨리지 않습니다) 떠나세요. 가시가 박히는 순간 처리가 인정되니 그 뒤 죽어도 됩니다. 화살표는 서부와 북부의 일반 데비소어를 가리킵니다. {npc:6499}이(가) 분화구 남쪽 중앙, {npc:9619}에 더 가까운 곳을 배회합니다."
	["Any Devilsaur counts, the Ironhide and Tyrant Devilsaurs too. They are elite (level 54-55), hit with {spell:14099} and outrun travel form. Grouping up is encouraged, but a druid can do it alone: Hibernate or {spell:339} it from range, stab it with the {item:22432} (the barb does not break {spell:2637}), then leave. The credit counts the moment the barb lands, even if you die after. The arrow points at the plain Devilsaurs of the west and north; an {npc:6499} roams the middle of the crater's south, nearer {npc:9619}."] = "",
	-- {item:22432} Devilsaur Barb
	-- was: ["{npc:6498}: stab it with the {item:22432}"] = "{npc:6498}: {item:22432}(으)로 찌르세요"
	["Devilsaur: stab it with the {item:22432}"] = "",
	-- {item:22432} Devilsaur Barb
	["Stab a Devilsaur with the {item:22432}"] = "",

	-- Step 7: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "{area:1417}",
	-- {area:75} Stonard · {area:1438} Nethergarde Keep · {zone:1419} Blasted Lands · {area:1477} The Temple of Atal'Hakkar · {area:74} Pool of Tears · {zone:1435} Swamp of Sorrows · {npc:8580} Atal'alarion · {spell:12887} Sweeping Slam · {spell:6524} Ground Tremor · {item:22444} Putrid Vine
	["A five-player dungeon: needs a group of five, about level 50-55. Horde: fly to {area:75}; Alliance: fly to {area:1438} in the {zone:1419} and ride north. {area:1477} stands in the middle of the {area:74} in the {zone:1435}: climb the stairs on the ruin's south side, dive into the flooded hall, swim down through it and follow the stairs and passages down to the portal. {npc:8580} (level 50 elite, {spell:12887} and {spell:6524}) only appears when the six serpent statues on the balcony ring above the altar pit are clicked in order: South, North, South-west, South-east, North-west, North-east (each turns green when right; a wrong order fails). Clear the trash by each statue and the pit below first; jumping down into the water is the quick way down, but a knockback near the edge can kill. The {item:22444} always drops."] = "5인 던전입니다. 50-55레벨 5인 파티가 필요합니다. 호드는 {area:75}로, 얼라이언스는 {zone:1419}의 {area:1438}로 날아가 북쪽으로 말을 타고 가세요. {area:1477}은(는) {zone:1435}의 {area:74} 중앙에 있습니다. 폐허 남쪽 계단을 올라 물에 잠긴 홀로 들어가 수영해 내려가 계단과 통로를 따라 차원문까지 가세요. {npc:8580}(50레벨 정예, {spell:12887}, {spell:6524})은(는) 제대 웅덩이 위 발코니 고리의 뱀 동상 여섯 개를 순서대로 클릭해야만 나타납니다. 남, 북, 남서, 남동, 북서, 북동(맞으면 초록색으로 바뀌고 순서가 틀리면 실패합니다). 먼저 각 동상 곁과 아래 웅덩이의 잡몹을 정리하세요. 물로 뛰어내리는 게 빠르지만 가장자리에서 밀려나면 죽을 수 있습니다. {item:22444}은(는) 반드시 떨어집니다.",

	-- Step 8: A Better Ingredient
	-- {npc:9619} Torwa Pathfinder · {zone:1449} Un'Goro Crater
	["Back to {npc:9619} in the south-east corner of {zone:1449}."] = "{zone:1449} 남동쪽 구석의 {npc:9619}에게 돌아가세요.",
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619}: the old item choice may be gone, count on the experience"] = "{npc:9619}: 예전 아이템 선택이 사라졌을 수 있으니 경험치를 기대하세요",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {npc:6498} counts, the Ironhide and Tyrant Devilsaurs too. They are elite (level 54-55), hit with {spell:14099} and outrun travel form. Grouping up is encouraged, but a druid can do it alone: Hibernate or {spell:339} it from range, stab it with the {item:22432} (the barb does not break {spell:2637}), then leave. The credit counts the moment the barb lands, even if you die after. The arrow points at the plain Devilsaurs of the west and north; an {npc:6499} roams the middle of the crater's south, nearer {npc:9619}."] = "어떤 {npc:6498}이나 상관없습니다. 철가죽과 폭군 데비소어도 포함됩니다. 정예(54-55레벨)이며 {spell:14099}으로 때리고 이동 형태보다 빠릅니다. 파티를 권장하지만 드루이드도 혼자 가능합니다. 원거리에서 수면 또는 {spell:339}을(를) 걸고 {item:22432}으로 찌른 뒤(가시가 {spell:2637}을 깨뜨리지 않습니다) 떠나세요. 가시가 박히는 순간 처리가 인정되니 그 뒤 죽어도 됩니다. 화살표는 서부와 북부의 일반 데비소어를 가리킵니다. {npc:6499}이(가) 분화구 남쪽 중앙, {npc:9619}에 더 가까운 곳을 배회합니다.",
	-- ["Stab a {npc:6498} with the {item:22432}"] = "{npc:6498}에게 {item:22432}으로 찌르세요",
	-- ["The Gorishi wasps, workers and reavers of the hive in the south of the crater drop the stings; the Bloodpetal Sprouts that give the {item:22434} grow all over the crater's western half."] = "분화구 남쪽 벌집의 병정 고리쉬, 일꾼 고리쉬, 갈퀴발톱 고리쉬가 독침을 떨어뜨립니다. {item:22434}을(를) 주는 붉은꽃잎 씨앗은 분화구 서쪽 절반 곳곳에 자랍니다.",
	-- ["Use the {item:22432} on a {npc:6498}. Devilsaurs are elite (level 54-55) and roam the crater: grouping up is advised."] = "{npc:6498}에게 {item:22432}을(를) 사용하세요. 데빌사우루스는 정예(54-55레벨)이며 분화구를 돌아다닙니다. 파티를 권장합니다.",
	-- ["{area:1477} lies in the {area:74} in the {zone:1435}. {npc:8580} guards the bottom of the temple: a dungeon boss, so bring a group."] = "{area:1477}은(는) {zone:1435}의 {area:74}에 있습니다. {npc:8580}이(가) 사원 아래층을 지킵니다. 던전 우두머리이니 파티를 데려가세요.",
	-- ["{npc:6498}: stab it with the {item:22432}"] = "{npc:6498}: {item:22432}(으)로 찌르세요",
}
