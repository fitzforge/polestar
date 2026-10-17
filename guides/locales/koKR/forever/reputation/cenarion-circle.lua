-- Korean (koKR): the guide forever/reputation/cenarion-circle (forever/reputation/cenarion-circle.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Cenarion Circle Reputation"] = "세나리온 의회 평판",

	-- Step 1: Cenarion Hold
	-- {area:3425} Cenarion Hold · {zone:1451} Silithus · {npc:15270} Huum Wildmane · {faction:609} Cenarion Circle
	["{area:3425} is the walled town in north-central {zone:1451}. Bor and {npc:15270} stand together inside. The {faction:609} starts out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{area:3425}은(는) {zone:1451} 중북부의 성벽 마을입니다. 보르 와일드메인과 {npc:15270}이(가) 안에 함께 있습니다. {faction:609} 평판은 중립에서 시작합니다. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",
	-- {quest:8320} Twilight Geolords
	["{quest:8320} needs level 60"] = "{quest:8320}은(는) 60레벨 필요",

	-- Step 2: Twilight Base Camp
	-- {zone:1451} Silithus · {quest:8320} Twilight Geolords · {item:20404} Encrypted Twilight Text · {faction:609} Cenarion Circle
	["Twilight's Hammer cultists hold the camps in western {zone:1451}. {quest:8320} and Stonecallers mix here; any cultist can drop an {item:20404}. Every cultist kill also counts toward the {faction:609}. The Geolords count for {quest:8320} only if you are 60 and took it."] = "황혼의망치단 신도들이 {zone:1451} 서부의 야영지를 차지하고 있습니다. 이곳에는 {quest:8320}와(과) 황혼의 돌소환사가 섞여 있으며, 어느 신도든 {item:20404}을(를) 떨어뜨릴 수 있습니다. 신도를 처치할 때마다 {faction:609} 평판도 오릅니다. 대지술사는 60레벨이고 {quest:8320}을(를) 수락했을 때만 집계됩니다.",

	-- Step 3: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "{area:3425}(으)로 돌아가기",

	-- Step 4: Encrypted Twilight Texts to Friendly
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["Encrypted Twilight Texts to Friendly"] = "암호화된 황혼의 문서로 우호까지",
	-- {npc:15306} Bor Wildmane
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["Encrypted Twilight Texts repeats: {npc:15306} takes more texts again and again. The cultist camps are the place to farm them."] = "암호화된 황혼의 문서는 반복 퀘스트입니다. {npc:15306}이(가) 문서를 계속 받습니다. 신도 야영지에서 모으십시오.",
	-- {npc:15306} Bor Wildmane
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:15306}: Encrypted Twilight Texts"] = "{npc:15306}: 암호화된 황혼의 문서",

	-- Step 5: Cenarion Circle to Honored
	-- {faction:609} Cenarion Circle
	["{faction:609} to Honored"] = "{faction:609} 우대까지",
	-- {npc:15282} Aurel Goldleaf · {npc:15306} Bor Wildmane
	-- plural, as words: Wind Stones = {object:180461} Wind Stone · Abyssal Crests = {item:20513} Abyssal Crest
	["Keep farming the Twilight camps. Wearing the Twilight Trappings (the Twilight cultist set plus a Medallion of Station, from {npc:15282}'s Medallion of Station quest) lets you summon Abyssal Templars at the Wind Stones; their Abyssal Crests go to {npc:15306}."] = "황혼의 야영지에서 계속 사냥하십시오. Twilight Trappings(황혼의 신도 세트와 {npc:15282}의 황혼의 신도 계급장 퀘스트에서 얻는 계급장)를 착용하면 바람의 돌에서 Abyssal Templar를 소환할 수 있으며, 그들의 심연의 문장은 {npc:15306}에게 가져가십시오.",

	-- Step 6: Cenarion Circle to Revered
	-- {faction:609} Cenarion Circle
	["{faction:609} to Revered"] = "{faction:609} 존경까지",
	-- {area:3454} Ruins of Ahn'Qiraj
	["From here on, the {area:3454} raid and the Abyssal Council turn-ins (crests, signets, scepters) carry most of the reputation."] = "이제부터는 {area:3454} 공격대와 Abyssal Council 반납품(문장, 인장, 홀)이 평판 대부분을 줍니다.",
	-- {npc:15306} Bor Wildmane
	-- plural, as words: Abyssal Crests = {item:20513} Abyssal Crest · Abyssal Signets = {item:20514} Abyssal Signet · Abyssal Scepters = {item:20515} Abyssal Scepter
	["Abyssal Crests, Abyssal Signets and Abyssal Scepters are repeatable at {npc:15306} once their opening quests are done."] = "심연의 문장, 심연의 인장, 심연의 홀은 시작 퀘스트를 마치면 {npc:15306}에게 반복해서 제출할 수 있습니다.",

	-- Step 7: Cenarion Circle to Exalted
	-- {faction:609} Cenarion Circle
	["{faction:609} to Exalted"] = "{faction:609} 확고한 동맹까지",
	-- {area:3454} Ruins of Ahn'Qiraj
	["Keep running the {area:3454} and turning in Abyssal Council insignia until Exalted."] = "확고한 동맹이 될 때까지 {area:3454}을(를) 계속 돌고 Abyssal Council 휘장을 제출하십시오.",
}
