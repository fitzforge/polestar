-- Korean (koKR): the guide forever/reputation/argent-dawn (forever/reputation/argent-dawn.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Argent Dawn Reputation"] = "은빛 여명회 평판",

	-- Step 1: Argent Dawn Commission (Alliance)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Alliance)"] = "{quest:5401} (얼라이언스)",
	-- {object:2160} The Argent Dawn · {npc:10840} Argent Officer Pureheart · {area:3197} Chillwind Camp · {quest:5401} Argent Dawn Commission
	["{object:2160} starts out Neutral. Take the Commission from {npc:10840} at {area:3197} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "{object:2160}은(는) 중립에서 시작합니다. {area:3197}의 {npc:10840}에게서 위임장을 받아 착용하세요. 클래식에서는 {quest:5401} 장신구를 착용해야만 스컬지석이 떨어집니다. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",

	-- Step 2: Argent Dawn Commission (Horde)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Horde)"] = "{quest:5401} (호드)",
	-- {object:2160} The Argent Dawn · {npc:10839} Argent Officer Garush · {area:813} The Bulwark · {quest:5401} Argent Dawn Commission
	["{object:2160} starts out Neutral. Take the Commission from {npc:10839} at {area:813} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "{object:2160}은(는) 중립에서 시작합니다. {area:813}의 {npc:10839}에게서 위임장을 받아 착용하세요. 클래식에서는 {quest:5401} 장신구를 착용해야만 스컬지석이 떨어집니다. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",

	-- Step 3: Minion's Scourgestones to Friendly
	-- plural, as words: Minion's Scourgestones = {item:12840} Minion's Scourgestone
	["Minion's Scourgestones to Friendly"] = "{item:12840}: 약간 우호적까지",
	-- {zone:1422} Western Plaguelands · {area:3197} Chillwind Camp · {area:813} The Bulwark · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel · {item:12844} Argent Dawn Valor Token
	-- plural, as words: Minion's Scourgestones = {item:12840} Minion's Scourgestone
	["Ghouls and skeletons all over {zone:1422} drop Minion's Scourgestones about half the time; this cluster is dense. Hand them in 20 at a time to any Argent Officer (Pureheart at {area:3197}, Garush at {area:813}, {npc:11039} at {area:2268}). Each turn-in also pays an {item:12844} for the Argent quartermasters."] = "{zone:1422} 곳곳의 구울과 해골이 절반 정도의 확률로 {item:12840}을(를) 떨어뜨립니다. 이 무리는 밀집해 있습니다. 20개씩 은빛장교에게 제출하세요({area:3197}의 퓨어하트, {area:813}의 가루쉬, {area:2268}의 {npc:11039}). 제출할 때마다 은빛 병참장교에게 쓸 {item:12844}도 받습니다.",

	-- Step 4: Invader's Scourgestones to Honored
	-- plural, as words: Invader's Scourgestones = {item:12841} Invader's Scourgestone
	["Invader's Scourgestones to Honored"] = "{item:12841}: 우호적까지",
	-- {item:14047} Runecloth · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept · Invader's Scourgestones = {item:12841} Invader's Scourgestone
	["Dark Adepts and Shadowmages (level 58-60) drop Invader's Scourgestones here, along with Minion's stones and {item:14047}. Hand Invader's in 10 at a time and Minion's 20 at a time to {npc:11039} at {area:2268}. In Classic both stop giving reputation at Honored."] = "{npc:8546}와(과) 어둠마법사(58-60레벨)가 이곳에서 {item:12841}을(를) 떨어뜨리며, 앞잡이의 스컬지석과 {item:14047}도 떨어뜨립니다. {area:2268}의 {npc:11039}에게 침입자의 스컬지석은 10개씩, 앞잡이의 스컬지석은 20개씩 제출하세요. 클래식에서는 둘 다 우호적부터 평판을 주지 않습니다.",

	-- Step 5: Corruptor's Scourgestones and dungeons to Revered
	-- plural, as words: Corruptor's Scourgestones = {item:12843} Corruptor's Scourgestone
	["Corruptor's Scourgestones and dungeons to Revered"] = "{item:12843}와(과) 던전: 매우 우호적까지",
	-- {area:2279} Stratholme · {area:2057} Scholomance · {npc:1853} Darkmaster Gandling · {npc:10433} Marduk Blackpool · {npc:1852} Araj the Summoner · {zone:1422} Western Plaguelands
	-- plural, as words: Corruptor's Scourgestones = {item:12843} Corruptor's Scourgestone
	["From Honored on, Corruptor's Scourgestones (one per turn-in) and Scourge kills in {area:2279} and {area:2057} carry the reputation. Corruptor's stones drop from the Scourge bosses there ({npc:1853}, {npc:10433}, Vectus) and from {npc:1852} and Putridius in {zone:1422}. Many dungeon runs pay off faster than any open-world farm."] = "우호적부터는 {item:12843}(제출당 1개)와(과) {area:2279}, {area:2057}의 스컬지 처치가 평판을 줍니다. 타락자의 스컬지석은 그곳의 스컬지 우두머리({npc:1853}, {npc:10433}, 벡투스)와 {zone:1422}의 {npc:1852}, 퓨트리디우스가 떨어뜨립니다. 던전을 여러 번 도는 편이 어떤 필드 사냥보다 빠릅니다.",
	-- {area:2279} Stratholme · {area:2057} Scholomance
	["Run {area:2279} (both wings) and {area:2057}, killing every Scourge you pass."] = "{area:2279}(양쪽 구역)와(과) {area:2057}을(를) 돌며 지나가는 스컬지를 모두 처치하세요.",

	-- Step 6: Argent Dawn to Exalted
	-- {faction:529} Argent Dawn
	["{faction:529} to Exalted"] = "{faction:529}: 확고한 동맹까지",
	-- {area:2279} Stratholme · {area:2057} Scholomance · {item:12843} Corruptor's Scourgestone · {area:2268} Light's Hope Chapel
	["Keep running {area:2279} and {area:2057} and turning in every {item:12843} at {area:2268} until Exalted."] = "확고한 동맹이 될 때까지 {area:2279}와(과) {area:2057}을(를) 계속 돌고 {item:12843}을(를) 모두 {area:2268}에 제출하세요.",
}
