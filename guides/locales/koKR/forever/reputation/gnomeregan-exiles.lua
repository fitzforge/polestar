-- Korean (koKR): the guide forever/reputation/gnomeregan-exiles (forever/reputation/gnomeregan-exiles.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Gnomeregan Exiles Reputation"] = "놈리건 평판",

	-- Step 1: Bubulo Acerbus: A Donation of Wool
	-- {npc:14724} Bubulo Acerbus · {faction:54} Gnomeregan Exiles · {object:171524} Tinker Town · {zone:1455} Ironforge · {item:14047} Runecloth · {quest:7812} Additional Runecloth
	["{npc:14724} takes cloth for {faction:54} in {object:171524}, {zone:1455}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7812} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14724}은(는) {zone:1455} {object:171524}에서 {faction:54}을(를) 위한 옷감을 받습니다. 양모, 비단, 마법 옷감, {item:14047}의 첫 기부(각 옷감 60개)는 한 번만 할 수 있고 옷감당 평판이 가장 많습니다. 그 뒤로는 {quest:7812}을(를) 확고한 동맹까지 반복합니다. 다른 종족의 도시와 확고한 동맹이 되면 그 종족의 탈것을 구매할 수 있습니다. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",

	-- Step 2: Wool Cloth
	-- plural, as words: Riverpaw Bandits = {npc:452} Riverpaw Bandit
	["Riverpaw Bandits and Taskmasters (level 16-18) drop it here. The Auction House works too."] = "이곳의 갈퀴발일족 무법자와 전사(레벨 16-18)가 떨어뜨립니다. 경매장도 이용할 수 있습니다.",

	-- Step 4: Silk Cloth
	["Syndicate Mercenaries at Stromgarde (level 31-32) drop it here. The Auction House works too."] = "스트롬가드 요새의 비밀결사대 용병(레벨 31-32)이 떨어뜨립니다. 경매장도 이용할 수 있습니다.",

	-- Step 6: Mageweave Cloth
	["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "이곳의 모래망치 오우거(레벨 45-48)가 떨어뜨립니다. 경매장도 이용할 수 있습니다.",

	-- Step 8: Runecloth
	-- {object:92525} Argent Dawn
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "이곳의 암흑의 수행사제와 어둠마법사(레벨 58-60)가 떨어뜨립니다. 이곳에서 스컬지를 처치할 때마다 {object:92525} 평판도 오릅니다(해당 가이드 참고). 경매장도 이용할 수 있습니다.",

	-- Step 9: Bubulo Acerbus: Runecloth delivered
	-- {npc:14724} Bubulo Acerbus · {item:14047} Runecloth
	["{npc:14724}: {item:14047} delivered"] = "{npc:14724}: {item:14047} 기부 완료",

	-- Step 10: Additional Runecloth to Honored
	-- {quest:7812} Additional Runecloth
	["{quest:7812} to Honored"] = "{quest:7812}: 우호적까지",
	-- {quest:7812} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["{quest:7812} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7812}은(는) 한 번에 {item:14047} 20개를 받으며 원하는 만큼 반복할 수 있습니다. {item:14047}을(를) 20개 단위로 가져와 한 번에 연달아 모두 제출하십시오. {item:14047}: {zone:1423}의 암흑의 수행사제와 어둠마법사(레벨 58-60) 또는 경매장.",

	-- Step 11: Additional Runecloth to Revered
	-- {quest:7812} Additional Runecloth
	["{quest:7812} to Revered"] = "{quest:7812}: 매우 우호적까지",
	-- {quest:7812} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7812}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{item:14047} 20개씩 {quest:7812}을(를) 계속 제출하십시오. {item:14047}: {zone:1423}의 암흑의 수행사제와 어둠마법사(레벨 58-60) 또는 경매장.",

	-- Step 12: Additional Runecloth to Exalted
	-- {quest:7812} Additional Runecloth
	["{quest:7812} to Exalted"] = "{quest:7812}: 확고한 동맹까지",
	-- {quest:7812} Additional Runecloth · {faction:54} Gnomeregan Exiles · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7812} until {faction:54} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{faction:54}와(과) 확고한 동맹이 될 때까지 {quest:7812}을(를) 계속 제출하십시오. {item:14047}: {zone:1423}의 암흑의 수행사제와 어둠마법사(레벨 58-60) 또는 경매장.",
}
