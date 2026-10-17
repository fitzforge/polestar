-- Korean (koKR): the guide forever/class/paladin/lumina-windsinger (forever/class/paladin/lumina-windsinger.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:91862} Lumina Windsinger
	["Rescuing {quest:91862}"] = "{quest:91862} 구출",
	-- {item:268484} Moonsilver Blade
	["No item yet: a Forsaken paladin rescue story; its sequel, the {item:268484}, cannot be finished yet."] = "아직 아이템 없음: 포세이큰 성기사 구출 이야기입니다. 후속인 {item:268484}은(는) 아직 완료할 수 없습니다.",
	-- {zone:1458} Undercity
	["{zone:1458} and Earthen Ring reputation"] = "{zone:1458} 및 대지 고리회 평판",

	-- Step 1: Danitha Morr
	-- {npc:246378} Danitha Morr · {area:16602} Bandarion Keep · {area:156} Solliden Farmstead
	["{npc:246378} leads the Paladins of Tyr's Watch from inside {area:16602}, on the bluffs north-west of the {area:156}."] = "{npc:246378}은(는) {area:156} 북서쪽 절벽 위 {area:16602} 안에서 Tyr's Watch의 성기사들을 이끕니다.",

	-- Step 2: The Sepulcher
	-- {zone:1421} Silverpine Forest · {area:228} The Sepulcher · {npc:248840} Trevan Rol · {npc:259611} Deathguard Baldren
	["Ride south through {zone:1421} to the {area:228}. {npc:248840} stands in the town; {npc:259611} keeps watch near its entrance."] = "{zone:1421}을(를) 지나 남쪽의 {area:228}로 가십시오. {npc:248840}은(는) 마을 안에 있고, {npc:259611}은(는) 입구 근처에서 경계를 섭니다.",

	-- Step 3: The pyre on Fenris Isle
	-- {area:172} Fenris Isle
	["The pyre on {area:172}"] = "{area:172}의 화장단",
	-- {area:172} Fenris Isle · {area:228} The Sepulcher
	["{area:172} lies in the lake east of the {area:228}. The charred remains are on its shore."] = "{area:172}은(는) {area:228} 동쪽 호수에 있습니다. 불탄 유해는 그 물가에 있습니다.",
	-- {object:566037} Charred Remains (no name in this language: may be words)
	["from the {object:566037}"] = "{object:566037}에서",

	-- Step 4: Fenris Keep
	-- {quest:91862} Lumina Windsinger · {area:235} Fenris Keep
	["{quest:91862} is caged inside {area:235}, at the north end of the isle. The Rot Hide gnolls around her carry the key."] = "{quest:91862}은(는) 섬 북쪽 끝 {area:235} 안에 갇혀 있습니다. 그녀 주변의 썩은가죽일족 놀이 열쇠를 가지고 있습니다.",
	-- {item:267412} Fenris Isle Key
	["{item:267412}, from the Rot Hide gnolls"] = "{item:267412}, 썩은가죽일족 놀에게서",

	-- Step 5: Free Lumina Windsinger
	-- {npc:248755} Lumina Windsinger
	["Free {npc:248755}"] = "{npc:248755} 풀어주기",
	["Free her with the key, then stay close while she fights her way out of the keep."] = "열쇠로 그녀를 풀어준 뒤, 그녀가 싸우며 성채를 빠져나가는 동안 가까이 있으십시오.",

	-- Step 6: Back to the The Sepulcher
	-- {area:228} The Sepulcher
	["Back to the {area:228}"] = "{area:228}로 돌아가기",
	-- {area:235} Fenris Keep · {npc:259620} Lumina Windsinger · {area:228} The Sepulcher
	["Once she is clear of {area:235}, {npc:259620} waits for you in the {area:228}. Speak with her again to hear what really happened on the road."] = "{area:235}을(를) 벗어나면 {npc:259620}이(가) {area:228}에서 기다립니다. 다시 대화하여 길에서 실제로 무슨 일이 있었는지 들으십시오.",
	-- {npc:259620} Lumina Windsinger · {area:228} The Sepulcher
	["{npc:259620}, the {area:228}"] = "{npc:259620}, {area:228}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the {area:228}"] = "{area:228}(으)로 돌아가기",
	-- ["Once she is clear of {area:235}, Lumina waits for you in the {area:228}. Speak with her again to hear what really happened on the road."] = "{area:235}을(를) 벗어나면 Lumina가 {area:228}에서 기다립니다. 다시 대화하여 길에서 실제로 무슨 일이 있었는지 들으십시오.",
	-- ["Ride south through {zone:1421} to the {area:228}. {npc:248840} stands in the town; {npc:259611} keeps watch near its entrance."] = "{zone:1421}을(를) 지나 남쪽의 {area:228}(으)로 가십시오. {npc:248840}은(는) 마을 안에 있고, {npc:259611}은(는) 입구 근처에서 경계를 섭니다.",
	-- ["{area:172} lies in the lake east of the {area:228}. The charred remains are on its shore."] = "{area:172}은(는) {area:228} 동쪽 호수에 있습니다. 불탄 유해는 그 물가에 있습니다.",
	-- ["{npc:259620}, the {area:228}"] = "{npc:259620}, {area:228}",
}
