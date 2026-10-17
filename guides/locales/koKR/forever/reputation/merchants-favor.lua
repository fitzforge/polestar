-- Korean (koKR): the guide forever/reputation/merchants-favor (forever/reputation/merchants-favor.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Merchant's Favor Reputation"] = "상인의 호의 평판",

	-- Step 1: Azeroth Commerce Authority to Friendly
	-- {faction:2586} Azeroth Commerce Authority
	["{faction:2586} to Friendly"] = "{faction:2586}: 약간 우호적까지",
	-- {faction:2586} Azeroth Commerce Authority · {area:1002} Three Corners · {zone:1433} Redridge Mountains · {object:1561} Sealed Crate · {npc:214101} Marcy Baker
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["The {faction:2586} is the Alliance's tradeskill faction in Forever. Its camp is at {area:1002} in western {zone:1433}. From level 10 mobs drop Waylaid Crates: fill each with the goods its label asks for and hand the {object:1561} to {npc:214101} at the camp for reputation and Merchant's Favor. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:2586}은(는) Forever에서 얼라이언스의 전문 기술 세력입니다. 야영지는 {zone:1433} 서부의 {area:1002}에 있습니다. 레벨 10부터 몹이 잘못 놓인 보급품을 떨어뜨립니다. 상자마다 라벨에 적힌 물품을 채운 뒤 {object:1561}을(를) 야영지의 {npc:214101}에게 건네면 평판과 Merchant's Favor를 얻습니다. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",

	-- Step 2: Azeroth Commerce Authority to Honored
	-- {faction:2586} Azeroth Commerce Authority
	["{faction:2586} to Honored"] = "{faction:2586}: 우호적까지",
	-- {npc:214101} Marcy Baker
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["Keep filling Waylaid Crates for {npc:214101}."] = "{npc:214101}에게 줄 잘못 놓인 보급품을 계속 채우십시오.",

	-- Step 3: Azeroth Commerce Authority to Revered
	-- {faction:2586} Azeroth Commerce Authority
	["{faction:2586} to Revered"] = "{faction:2586}: 매우 우호적까지",

	-- Step 4: Azeroth Commerce Authority to Exalted
	-- {faction:2586} Azeroth Commerce Authority
	["{faction:2586} to Exalted"] = "{faction:2586}: 확고한 동맹까지",
	-- {npc:214101} Marcy Baker
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["Keep filling Waylaid Crates for {npc:214101} until Exalted."] = "확고한 동맹이 될 때까지 {npc:214101}에게 줄 잘못 놓인 보급품을 계속 채우십시오.",

	-- Step 5: Durotar Supply and Logistics to Friendly
	-- {faction:2587} Durotar Supply and Logistics
	["{faction:2587} to Friendly"] = "{faction:2587}: 약간 우호적까지",
	-- {faction:2587} Durotar Supply and Logistics · {area:380} Crossroads · {zone:1413} Barrens · {object:1561} Sealed Crate
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["{faction:2587} is the Horde's tradeskill faction in Forever. Its camp is just outside the {area:380} in the {zone:1413}. From level 10 mobs drop Waylaid Crates: fill each with the goods its label asks for and hand the {object:1561} to Dokimi at the camp for reputation and Merchant's Favor. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:2587}은(는) Forever에서 호드의 전문 기술 세력입니다. 야영지는 {zone:1413}의 {area:380} 바로 바깥에 있습니다. 레벨 10부터 몹이 잘못 놓인 보급품을 떨어뜨립니다. 상자마다 라벨에 적힌 물품을 채운 뒤 {object:1561}을(를) 야영지의 도키미에게 건네면 평판과 Merchant's Favor를 얻습니다. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",
	["Dokimi"] = "도키미",

	-- Step 6: Durotar Supply and Logistics to Honored
	-- {faction:2587} Durotar Supply and Logistics
	["{faction:2587} to Honored"] = "{faction:2587}: 우호적까지",
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["Keep filling Waylaid Crates for Dokimi."] = "도키미에게 줄 잘못 놓인 보급품을 계속 채우십시오.",

	-- Step 7: Durotar Supply and Logistics to Revered
	-- {faction:2587} Durotar Supply and Logistics
	["{faction:2587} to Revered"] = "{faction:2587}: 매우 우호적까지",

	-- Step 8: Durotar Supply and Logistics to Exalted
	-- {faction:2587} Durotar Supply and Logistics
	["{faction:2587} to Exalted"] = "{faction:2587}: 확고한 동맹까지",
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["Keep filling Waylaid Crates for Dokimi until Exalted."] = "확고한 동맹이 될 때까지 도키미에게 줄 잘못 놓인 보급품을 계속 채우십시오.",
}
