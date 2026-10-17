-- Chinese (traditional) (zhTW): the guide forever/reputation/merchants-favor (forever/reputation/merchants-favor.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Merchant's Favor Reputation"] = "商人貢獻點聲望",

	-- Step 1: Azeroth Commerce Authority to Friendly
	-- {faction:2586} Azeroth Commerce Authority
	["{faction:2586} to Friendly"] = "{faction:2586}到友好",
	-- {faction:2586} Azeroth Commerce Authority · {area:1002} Three Corners · {zone:1433} Redridge Mountains · {object:1561} Sealed Crate · {npc:214101} Marcy Baker
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["The {faction:2586} is the Alliance's tradeskill faction in Forever. Its camp is at {area:1002} in western {zone:1433}. From level 10 mobs drop Waylaid Crates: fill each with the goods its label asks for and hand the {object:1561} to {npc:214101} at the camp for reputation and Merchant's Favor. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:2586}是 Forever 中聯盟的專業技能陣營。它的營地在{zone:1433}西部的{area:1002}。從10級起，怪物會掉落遭攔截的木箱：依標籤要求裝滿貨物，然後把{object:1561}交給營地的{npc:214101}，換取聲望和 Merchant's Favor。Forever的傳承外交官天賦可提高聲望獲取。",

	-- Step 2: Azeroth Commerce Authority to Honored
	-- {faction:2586} Azeroth Commerce Authority
	["{faction:2586} to Honored"] = "{faction:2586}到尊敬",
	-- {npc:214101} Marcy Baker
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["Keep filling Waylaid Crates for {npc:214101}."] = "繼續為{npc:214101}裝滿遭攔截的木箱。",

	-- Step 3: Azeroth Commerce Authority to Revered
	-- {faction:2586} Azeroth Commerce Authority
	["{faction:2586} to Revered"] = "{faction:2586}到崇敬",

	-- Step 4: Azeroth Commerce Authority to Exalted
	-- {faction:2586} Azeroth Commerce Authority
	["{faction:2586} to Exalted"] = "{faction:2586}到崇拜",
	-- {npc:214101} Marcy Baker
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["Keep filling Waylaid Crates for {npc:214101} until Exalted."] = "繼續為{npc:214101}裝滿遭攔截的木箱，直到崇拜。",

	-- Step 5: Durotar Supply and Logistics to Friendly
	-- {faction:2587} Durotar Supply and Logistics
	["{faction:2587} to Friendly"] = "{faction:2587}到友好",
	-- {faction:2587} Durotar Supply and Logistics · {area:380} Crossroads · {zone:1413} Barrens · {object:1561} Sealed Crate
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["{faction:2587} is the Horde's tradeskill faction in Forever. Its camp is just outside the {area:380} in the {zone:1413}. From level 10 mobs drop Waylaid Crates: fill each with the goods its label asks for and hand the {object:1561} to Dokimi at the camp for reputation and Merchant's Favor. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:2587}是 Forever 中部落的專業技能陣營。它的營地就在{zone:1413}的{area:380}外面。從10級起，怪物會掉落遭攔截的木箱：依標籤要求裝滿貨物，然後把{object:1561}交給營地的朵奇米，換取聲望和 Merchant's Favor。Forever的傳承外交官天賦可提高聲望獲取。",
	["Dokimi"] = "朵奇米",

	-- Step 6: Durotar Supply and Logistics to Honored
	-- {faction:2587} Durotar Supply and Logistics
	["{faction:2587} to Honored"] = "{faction:2587}到尊敬",
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["Keep filling Waylaid Crates for Dokimi."] = "繼續為朵奇米裝滿遭攔截的木箱。",

	-- Step 7: Durotar Supply and Logistics to Revered
	-- {faction:2587} Durotar Supply and Logistics
	["{faction:2587} to Revered"] = "{faction:2587}到崇敬",

	-- Step 8: Durotar Supply and Logistics to Exalted
	-- {faction:2587} Durotar Supply and Logistics
	["{faction:2587} to Exalted"] = "{faction:2587}到崇拜",
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["Keep filling Waylaid Crates for Dokimi until Exalted."] = "繼續為朵奇米裝滿遭攔截的木箱，直到崇拜。",
}
