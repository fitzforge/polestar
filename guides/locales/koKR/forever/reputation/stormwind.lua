-- Korean (koKR): the guide forever/reputation/stormwind (forever/reputation/stormwind.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Stormwind Reputation"] = "스톰윈드 평판",

	-- Step 1: Clavicus Knavingham: A Donation of Wool
	-- {npc:14722} Clavicus Knavingham · {faction:72} Stormwind · {zone:1453} Stormwind City · {item:14047} Runecloth · {quest:7796} Additional Runecloth
	["{npc:14722} takes cloth for {faction:72} in {zone:1453}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7796} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{zone:1453}의 {npc:14722}이(가) {faction:72}을(를) 위한 옷감을 받습니다. 양모, 비단, 마법 직물, {item:14047}의 첫 기부(각 60개)는 한 번만 할 수 있으며 옷감당 평판이 가장 높습니다. 그 후에는 확고한 동맹까지 {quest:7796}이(가) 반복됩니다. 다른 종족의 도시와 확고한 동맹이 되면 그 종족의 탈것을 구매할 수 있습니다. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",

	-- Step 2: Wool Cloth
	-- plural, as words: Riverpaw Bandits = {npc:452} Riverpaw Bandit
	["Riverpaw Bandits and Taskmasters (level 16-18) drop it here. The Auction House works too."] = "이곳의 갈퀴발일족 무법자와 갈퀴발일족 전사(16-18레벨)가 떨어뜨립니다. 경매장도 이용할 수 있습니다.",

	-- Step 4: Silk Cloth
	["Syndicate Mercenaries at Stromgarde (level 31-32) drop it here. The Auction House works too."] = "스트롬가드의 비밀결사대 용병(31-32레벨)이 떨어뜨립니다. 경매장도 이용할 수 있습니다.",

	-- Step 6: Mageweave Cloth
	["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "이곳의 모래망치 오우거(45-48레벨)가 떨어뜨립니다. 경매장도 이용할 수 있습니다.",

	-- Step 8: Runecloth
	-- {object:92525} Argent Dawn
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "이곳의 암흑의 수행사제와 어둠마법사(58-60레벨)가 떨어뜨립니다. 이곳의 스컬지 처치는 {object:92525}에도 집계됩니다(해당 가이드 참고). 경매장도 이용할 수 있습니다.",

	-- Step 9: Clavicus Knavingham: Runecloth delivered
	-- {npc:14722} Clavicus Knavingham · {item:14047} Runecloth
	["{npc:14722}: {item:14047} delivered"] = "{npc:14722}: {item:14047} 전달 완료",

	-- Step 10: Additional Runecloth to Honored
	-- {quest:7796} Additional Runecloth
	["{quest:7796} to Honored"] = "{quest:7796}(으)로 우대까지",
	-- {quest:7796} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["{quest:7796} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7796}은(는) 제출당 {item:14047} 20개를 받으며 원하는 만큼 반복할 수 있습니다. {item:14047}을(를) 20의 배수로 가져와 연달아 한꺼번에 제출하십시오. {item:14047}: {zone:1423}의 암흑의 수행사제와 어둠마법사(58-60레벨), 또는 경매장.",

	-- Step 11: Additional Runecloth to Revered
	-- {quest:7796} Additional Runecloth
	["{quest:7796} to Revered"] = "{quest:7796}(으)로 존경까지",
	-- {quest:7796} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7796}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7796}을(를) 계속 제출하십시오. 한 번에 {item:14047} 20개입니다. {item:14047}: {zone:1423}의 암흑의 수행사제와 어둠마법사(58-60레벨), 또는 경매장.",

	-- Step 12: Additional Runecloth to Exalted
	-- {quest:7796} Additional Runecloth
	["{quest:7796} to Exalted"] = "{quest:7796}(으)로 확고한 동맹까지",
	-- {quest:7796} Additional Runecloth · {faction:72} Stormwind · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7796} until {faction:72} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{faction:72} 평판이 확고한 동맹이 될 때까지 {quest:7796}을(를) 계속 제출하십시오. {item:14047}: {zone:1423}의 암흑의 수행사제와 어둠마법사(58-60레벨), 또는 경매장.",
}
