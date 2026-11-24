-- Korean (koKR): the guide forever/class/druid/cat-form (forever/class/druid/cat-form.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:768} Cat Form
	["Your stealth and melee form: in Forever this chain gives {spell:768} at 20, not the trainer."] = "은신과 근접 전투 변신: Forever에서는 {spell:768}을(를) 상급자가 아니라 이 연계 퀘스트로 20레벨에 얻습니다.",

	-- Step 1: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {zone:1457} Darnassus · {spell:18960} Teleport: Moonglade · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village · {spell:1066} Aquatic Form · {npc:11802} Dendrite Starblaze · {area:493} Moonglade
	["{npc:4217} stands in the {area:1658}. Skyborne far from {zone:1457}: cast {spell:18960} and take {npc:11800}'s flight from the middle of {area:2361} (she flies druids to {area:702}, no flight path needed), then the portal up. No {spell:1066} yet? Take A Lesson to Learn from him too: it also goes to {npc:11802}, and its Trial of the Lake (the {spell:1066} guide) is in the same {area:493}."] = "{npc:4217}은(는) {area:1658}에 서 있습니다. {zone:1457}에서 멀리 있는 스카이본이라면 {spell:18960}을(를) 시전하고 {area:2361} 중앙에서 {npc:11800}의 비행편을 타세요(드루이드를 {area:702}까지 태워 주며, 비행 경로가 필요 없습니다). 그다음 차원문을 타고 올라가세요. 아직 {spell:1066}이(가) 없나요? 그에게서 '귀중한 교훈'도 받으세요. 이 퀘스트도 {npc:11802}에게 가며, 이어지는 '엘룬아라 호수의 시험'({spell:1066} 가이드)도 같은 {area:493}에 있습니다.",

	-- Step 3: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:493} Moonglade · {npc:10897} Sindrayl
	["Cast {spell:18960}. {npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart. No {area:493} flight path yet? Learn it from {npc:10897}, south of the lake: the flight master in {area:2361} flies only Druids, from her gossip, and has none to learn."] = "{spell:18960}을(를) 시전하세요. {npc:11802}은(는) {area:2361}에 있는 자기 건물 위층에 서 있습니다. 건물 안에서 올라가세요. 화살표는 층을 구분하지 못합니다. 아직 {area:493} 비행 경로가 없나요? 호수 남쪽의 {npc:10897}에게서 배우세요. {area:2361}의 비행 조련사는 대화를 통해 드루이드만 태워주며, 배울 비행 경로가 없습니다.",

	-- Step 4: The relics of the Barrow Dens
	["The relics of the Barrow Dens"] = "지하굴의 성물",
	-- {quest:98394} The Great Cat Spirit · {area:493} Moonglade · {npc:272054} Avatar of Saeyleenan · {area:2361} Nighthaven · {area:2363} Stormrage Barrow Dens
	["{quest:98394} (Night Elves) waits on the hill above the bridge in southern {area:493}; the {npc:272054} (Skyborne) stands on high ground past the twin bridges, south-west of {area:2361}: climb up to it. The relics lie in the {area:2363} east of the lake: leave your form and click the statue at the den's entrance for a short stealth (five minutes), then go deep into the cave and over the bridge. Enraged spirits guard the relics and attack anything they see: stay in the statue's stealth and keep moving. Each relic is a small orb beside a cat statue in an alcove: the Fang and the Claw have one spot each, the Silent Shadow two, and it is the one players camp. A relic shows as unusable while another player loots it: wait a moment and try again. Stealth gone? Walk back to the entrance statue for more."] = "{quest:98394}(나이트 엘프)은(는) 남부 {area:493}의 다리 위 언덕에서 기다리고, {npc:272054}(스카이본)은(는) 쌍다리 너머 {area:2361} 남서쪽 높은 지대에 있습니다. 올라가세요. 유물은 호수 동쪽 {area:2363}에 있습니다. 변신을 풀고 소굴 입구 동상을 클릭하면 짧은 은신(5분)이 걸립니다. 동굴 깊이 들어가 다리를 건너세요. 격분한 영혼이 유물을 지키며 보이는 모든 것을 공격하니 동상의 은신을 유지하며 계속 움직이세요. 유물은 벽감의 고양이 동상 옆 작은 구슬입니다. 어금니와 발톱은 지점이 하나이고 고요한 그림자는 두 곳이며 플레이어들이 캠핑하는 곳입니다. 다른 플레이어가 줍는 동안에는 사용할 수 없게 표시되니 잠시 뒤 다시 시도하세요. 은신이 끝났나요? 입구 동상으로 돌아가 다시 받으세요.",

	-- Step 5: Back to Dendrite Starblaze
	-- {npc:11802} Dendrite Starblaze
	["Back to {npc:11802}"] = "{npc:11802}에게 돌아가기",
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11800} Silva Fil'naveth · {area:702} Rut'theran Village
	["Cast {spell:18960} to land by {npc:11802} in {area:2361} (nobody on Zephras Isle takes the Skyborne quest), then take {npc:11800}'s flight to {area:702}: she stands in the middle of {area:2361} and flies druids there, no flight path needed. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{spell:18960}을(를) 시전해 {area:2361}의 {npc:11802} 곁에 착륙하세요(제프라스 섬에는 스카이본 퀘스트를 받는 이가 아무도 없습니다). 그런 다음 {npc:11800}의 비행을 타고 {area:702}로 가세요. 그녀는 {area:2361} 중앙에 서서 드루이드를 태워다 주며 비행 경로가 필요 없습니다. {npc:11802}은(는) 자기 건물 위층에 있으니 건물 안에서 올라가세요. 화살표는 층을 구분하지 못합니다.",

	-- Step 6: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {spell:768} Cat Form
	["Take the portal up to {npc:4217}, upstairs in the {area:1658}: he teaches you {spell:768}."] = "차원문을 타고 {area:1658}의 위층에 있는 {npc:4217}에게 올라가십시오. 그가 {spell:768}을(를) 가르쳐 줍니다.",

	-- Step 8: The Great Cat Spirit
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:1066} Aquatic Form · {npc:11802} Dendrite Starblaze · {area:493} Moonglade
	["{npc:3033} stands in the druids' hut on {area:1639}. No {spell:1066} yet? Take A Lesson to Learn from him too: it also goes to {npc:11802}, and its Trial of the Lake (the {spell:1066} guide) is in the same {area:493}."] = "{npc:3033}은(는) {area:1639}의 드루이드 오두막에 서 있습니다. 아직 {spell:1066}이(가) 없나요? 그에게서 '꼭 배워야 할 교훈'도 받으세요. 이 퀘스트도 {npc:11802}에게 가며, 이어지는 '엘룬아라 호수의 시험'({spell:1066} 가이드)도 같은 {area:493}에 있습니다.",

	-- Step 9: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart."] = "{spell:18960}을(를) 시전하세요. {npc:11802}은(는) {area:2361}에 있는 자기 건물 위층에 서 있습니다. 건물 안에서 올라가세요. 화살표는 층을 구분하지 못합니다.",

	-- Step 10: The Stormrage Barrow Dens
	-- {area:2363} Stormrage Barrow Dens
	["The {area:2363}"] = "{area:2363}",
	-- {quest:98342} The Great Cat Spirit · {area:493} Moonglade · {npc:272054} Avatar of Saeyleenan · {area:2361} Nighthaven · {area:2363} Stormrage Barrow Dens
	["{quest:98342} (Tauren) waits on the hill above the bridge in southern {area:493}; the {npc:272054} (Skyborne) stands on high ground past the twin bridges, south-west of {area:2361}: climb up to it. The relics lie in the {area:2363} east of the lake: leave your form and click the statue at the den's entrance for a short stealth (five minutes), then go deep into the cave and over the bridge. Enraged spirits guard the relics and attack anything they see: stay in the statue's stealth and keep moving. Each relic is a small orb beside a cat statue in an alcove: the Fang and the Claw have one spot each, the Silent Shadow two, and it is the one players camp. A relic shows as unusable while another player loots it: wait a moment and try again. Stealth gone? Walk back to the entrance statue for more."] = "{quest:98342}(타우렌)은(는) 남부 {area:493}의 다리 위 언덕에서 기다리고, {npc:272054}(스카이본)은(는) 쌍다리 너머 {area:2361} 남서쪽 높은 지대에 있습니다. 올라가세요. 유물은 호수 동쪽 {area:2363}에 있습니다. 변신을 풀고 소굴 입구 동상을 클릭하면 짧은 은신(5분)이 걸립니다. 동굴 깊이 들어가 다리를 건너세요. 격분한 영혼이 유물을 지키며 보이는 모든 것을 공격하니 동상의 은신을 유지하며 계속 움직이세요. 유물은 벽감의 고양이 동상 옆 작은 구슬입니다. 어금니와 발톱은 지점이 하나이고 고요한 그림자는 두 곳이며 플레이어들이 캠핑하는 곳입니다. 다른 플레이어가 줍는 동안에는 사용할 수 없게 표시되니 잠시 뒤 다시 시도하세요. 은신이 끝났나요? 입구 동상으로 돌아가 다시 받으세요.",

	-- Step 11: Back to Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960} to land by {npc:11802} in {area:2361} (nobody on Zephras Isle takes the Skyborne quest), then take {npc:11798}'s flight to {area:1638}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{spell:18960}을(를) 시전해 {area:2361}의 {npc:11802} 곁에 착륙하세요(제프라스 섬에는 스카이본 퀘스트를 받는 이가 아무도 없습니다). 그런 다음 {npc:11798}의 비행을 타고 {area:1638}로 가세요. {npc:11802}은(는) 자기 건물 위층에 있으니 건물 안에서 올라가세요. 화살표는 층을 구분하지 못합니다.",

	-- Step 12: To Thunder Bluff
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:768} Cat Form
	["{npc:3033} on {area:1639} teaches you {spell:768}."] = "{area:1639}의 {npc:3033}이(가) {spell:768}을(를) 가르쳐 줍니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:11802} in {area:2361}, then fly to {area:702}."] = "{area:2361}의 {npc:11802}에게 돌아간 뒤 {area:702}(으)로 비행하십시오.",
	-- ["Back to {npc:11802} in {area:2361}, then take {npc:11798}'s flight to {area:1638}."] = "{area:2361}의 {npc:11802}에게 돌아간 뒤 {npc:11798}의 비행편으로 {area:1638}에 가십시오.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}."] = "{spell:18960}을(를) 시전하세요. {npc:11802}은(는) {area:2361}에 있습니다.",
	-- ["Cast {spell:18960}. {npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart. Learn the flight path there if you do not have it."] = "{spell:18960}을(를) 시전하세요. {npc:11802}은(는) {area:2361}에 있는 자기 건물 위층에 서 있습니다. 건물 안에서 올라가세요. 화살표는 층을 구분하지 못합니다. 비행 경로가 없다면 그곳에서 배우세요.",
	-- ["{npc:4217} stands in the {area:1658}. Skyborne without the Rut'theran flight path: take the boat from {area:442}."] = "{npc:4217}은(는) {area:1658}에 있습니다. 루테란 비행 경로가 없는 스카이본이라면 {area:442}에서 배를 타십시오.",
	-- ["{quest:98342} (Tauren) waits on the southern hill above the bridge, the {npc:272054} (Skyborne) south of the twin bridges. The relics lie in the {area:2363} east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue. A relic gives no loot while another player is looting it: wait a moment and try again."] = "{quest:98342}(타우렌)은(는) 다리 위 남쪽 언덕에서, {npc:272054}(스카이본)은(는) 쌍둥이 다리 남쪽에서 기다립니다. 성물은 호수 동쪽 {area:2363}에 있습니다. 변신을 풀고, 입구의 석상을 클릭해 5분 동안 은신한 뒤, 안의 정령을 피해 성물을 하나씩 챙기십시오. {item:280680}은(는) 흰 고양이 석상 발치에 있습니다. 다른 플레이어가 전리품을 획득하는 동안에는 성물에서 아무것도 얻을 수 없으니 잠시 기다렸다가 다시 시도하십시오.",
	-- ["{quest:98394} (Night Elves) waits on the southern hill above the bridge, the {npc:272054} (Skyborne) south of the twin bridges. The relics lie in the {area:2363} east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue. A relic gives no loot while another player is looting it: wait a moment and try again."] = "{quest:98394}(나이트 엘프)은(는) 다리 위 남쪽 언덕에서, {npc:272054}(스카이본)은(는) 쌍둥이 다리 남쪽에서 기다립니다. 성물은 호수 동쪽 {area:2363}에 있습니다. 변신을 풀고, 입구의 석상을 클릭해 5분 동안 은신한 뒤, 안의 정령을 피해 성물을 하나씩 챙기십시오. {item:280680}은(는) 흰 고양이 석상 발치에 있습니다. 다른 플레이어가 전리품을 획득하는 동안에는 성물에서 아무것도 얻을 수 없으니 잠시 기다렸다가 다시 시도하십시오.",
}
