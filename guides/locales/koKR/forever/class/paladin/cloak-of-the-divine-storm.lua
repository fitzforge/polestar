-- Korean (koKR): the guide forever/class/paladin/cloak-of-the-divine-storm (forever/class/paladin/cloak-of-the-divine-storm.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:407778} Divine Storm
	["A rare cloak at 30 from the old {spell:407778} story; for now only Alliance paladins can finish it."] = "옛 {spell:407778} 이야기에서 이어지는 30레벨 희귀 망토입니다. 지금은 얼라이언스 성기사만 완료할 수 있습니다.",

	-- Step 1: The Strange Orb
	["The Strange Orb"] = "Strange Orb",
	-- {area:444} Tower of Althalaxx · {zone:1439} Darkshore
	["Climb to the top of the {area:444} in northern {zone:1439}. Loot the Strange Orb up there: it gives you the Althalaxx Orb, which starts the quest."] = "{zone:1439} 북부의 {area:444} 꼭대기로 올라가십시오. 그곳의 Strange Orb에서 Althalaxx Orb를 얻으면 퀘스트가 시작됩니다.",
	-- {area:444} Tower of Althalaxx
	["Strange Orb atop the {area:444}: right-click the Althalaxx Orb it gives"] = "{area:444} 꼭대기의 Strange Orb: 얻은 Althalaxx Orb를 오른쪽 클릭",

	-- Step 2: Delgren the Purifier
	-- {npc:3663} Delgren the Purifier · {area:413} Maestra's Post · {zone:1440} Ashenvale
	["{npc:3663} stands at {area:413} in western {zone:1440}."] = "{npc:3663}은(는) {zone:1440} 서부의 {area:413}에 있습니다.",

	-- Step 3: Katherine the Pure
	-- {npc:5492} Katherine the Pure
	["{npc:5492} is in the Cathedral of Light."] = "{npc:5492}은(는) 빛의 대성당에 있습니다.",

	-- Step 4: Ursula Deline
	-- {object:2101} Mage Quarter · {npc:5495} Ursula Deline
	["Katherine sends you to the warlocks in the {object:2101}; {npc:5495} speaks for them."] = "캐서린은 당신을 {object:2101}의 흑마법사들에게 보냅니다. {npc:5495}이(가) 그들을 대변합니다.",

	-- Step 5: Summoner's Salt
	-- {item:209778} Summoner's Salt
	-- plural, as words: Blackrock Summoners = {npc:4463} Blackrock Summoner
	["Blackrock Summoners, Champions and Trackers camp in the north-west of Redridge; they drop the {item:209778}."] = "붉은마루 산맥 북서쪽에 진을 친 검은바위부족 소환사, 용사, 추적자가 {item:209778}을(를) 떨어뜨립니다.",

	-- Step 6: Back to Ursula Deline
	-- {npc:5495} Ursula Deline
	["Back to {npc:5495}"] = "{npc:5495}에게 돌아가기",

	-- Step 7: Motes of Mannoroth
	["Motes of Mannoroth"] = "만노로스의 티끌",
	-- {area:435} Demon Fall Canyon · {zone:1440} Ashenvale
	-- plural, as words: Mannoroc Lashers = {npc:11697} Mannoroc Lasher · Searing Infernals = {npc:6073} Searing Infernal · Legion Hounds = {npc:6071} Legion Hound
	["{area:435} is in south-east {zone:1440}. The Mannoroc Lashers, Searing Infernals, Felguards and Legion Hounds in it drop the Motes of Mannoroth."] = "{area:435}은(는) {zone:1440} 남동쪽에 있습니다. 그 안의 만노로크 채찍마녀, 불타는 지옥불정령, 지옥군단병, 군단 지옥사냥개가 만노로스의 티끌을 떨어뜨립니다.",

	-- Step 8: The Spear of Mannoroth
	-- {object:409311} Spear of Mannoroth (no name in this language: may be words)
	["The {object:409311}"] = "{object:409311}",
	-- {object:409311} Spear of Mannoroth (no name in this language: may be words) · {area:435} Demon Fall Canyon · {object:409315} Shattered Orb (no name in this language: may be words)
	["The {object:409311} stands at the east end of {area:435}. Shatter the orb on it; the {object:409315} appears beside it."] = "{object:409311}은(는) {area:435} 동쪽 끝에 서 있습니다. 그 위의 구슬을 깨뜨리면 옆에 {object:409315}이(가) 나타납니다.",
	-- {object:409315} Shattered Orb (no name in this language: may be words)
	["from the {object:409315}"] = "{object:409315}에서",

	-- Step 9: Return to Delgren
	-- {area:413} Maestra's Post
	["Back to {area:413}."] = "{area:413}(으)로 돌아가십시오.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {object:409311} stands at the east end of {area:435}. {spell:11170} the orb on it; the {object:409315} appears beside it."] = "{object:409311}은(는) {area:435} 동쪽 끝에 서 있습니다. 그 위의 구슬에 {spell:11170}을(를) 사용하면 옆에 {object:409315}이(가) 나타납니다.",
}
