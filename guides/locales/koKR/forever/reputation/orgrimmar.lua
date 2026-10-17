-- Korean (koKR): the guide forever/reputation/orgrimmar (forever/reputation/orgrimmar.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Orgrimmar Reputation"] = "오그리마 평판",

	-- Step 1: Rashona Straglash: A Donation of Wool
	-- {npc:14726} Rashona Straglash · {faction:76} Orgrimmar · {item:14047} Runecloth · {quest:7832} Additional Runecloth
	["{npc:14726} takes cloth for {faction:76} in {faction:76}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7832} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14726}은(는) {faction:76}에서 {faction:76}을(를) 위한 옷감을 받습니다. 양모, 비단, 마법 옷감, {item:14047}의 첫 기부(각 옷감 60개)는 한 번만 할 수 있고 옷감당 평판이 가장 많습니다. 그 뒤로는 {quest:7832}을(를) 확고한 동맹까지 반복합니다. 다른 종족의 도시와 확고한 동맹이 되면 그 종족의 탈것을 구매할 수 있습니다. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",

	-- Step 2: Wool Cloth
	-- {area:381} Boulder Lode Mine
	-- plural, as words: Venture Co. Enforcers = {npc:3283} Venture Co. Enforcer
	["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "{area:381}의 투자개발회사 집행자(레벨 16-17)가 떨어뜨립니다. 경매장도 이용할 수 있습니다.",

	-- Step 4: Silk Cloth
	["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "콜카르 켄타우로스(레벨 30-33)가 떨어뜨립니다. 경매장도 이용할 수 있습니다.",

	-- Step 6: Mageweave Cloth
	["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "이곳의 모래망치 오우거(레벨 45-48)가 떨어뜨립니다. 경매장도 이용할 수 있습니다.",

	-- Step 8: Runecloth
	-- {object:92525} Argent Dawn
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "이곳의 암흑의 수행사제와 어둠마법사(레벨 58-60)가 떨어뜨립니다. 이곳에서 스컬지를 처치할 때마다 {object:92525} 평판도 오릅니다(해당 가이드 참고). 경매장도 이용할 수 있습니다.",

	-- Step 9: Rashona Straglash: Runecloth delivered
	-- {npc:14726} Rashona Straglash · {item:14047} Runecloth
	["{npc:14726}: {item:14047} delivered"] = "{npc:14726}: {item:14047} 기부 완료",

	-- Step 10: Additional Runecloth to Honored
	-- {quest:7832} Additional Runecloth
	["{quest:7832} to Honored"] = "{quest:7832}: 우호적까지",
	-- {quest:7832} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["{quest:7832} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7832}은(는) 한 번에 {item:14047} 20개를 받으며 원하는 만큼 반복할 수 있습니다. {item:14047}을(를) 20개 단위로 가져와 한 번에 연달아 모두 제출하십시오. {item:14047}: {zone:1423}의 암흑의 수행사제와 어둠마법사(레벨 58-60) 또는 경매장.",

	-- Step 11: Additional Runecloth to Revered
	-- {quest:7832} Additional Runecloth
	["{quest:7832} to Revered"] = "{quest:7832}: 매우 우호적까지",
	-- {quest:7832} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7832}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{item:14047} 20개씩 {quest:7832}을(를) 계속 제출하십시오. {item:14047}: {zone:1423}의 암흑의 수행사제와 어둠마법사(레벨 58-60) 또는 경매장.",

	-- Step 12: Additional Runecloth to Exalted
	-- {quest:7832} Additional Runecloth
	["{quest:7832} to Exalted"] = "{quest:7832}: 확고한 동맹까지",
	-- {quest:7832} Additional Runecloth · {faction:76} Orgrimmar · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7832} until {faction:76} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{faction:76}와(과) 확고한 동맹이 될 때까지 {quest:7832}을(를) 계속 제출하십시오. {item:14047}: {zone:1423}의 암흑의 수행사제와 어둠마법사(레벨 58-60) 또는 경매장.",
}
