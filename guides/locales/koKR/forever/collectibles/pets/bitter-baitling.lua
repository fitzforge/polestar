-- Korean (koKR): the guide forever/collectibles/pets/bitter-baitling (forever/collectibles/pets/bitter-baitling.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Riggle Bassbait
	-- {item:276275} Bitter Baitling · {item:274026} Extravagant Extravaganza Coin · {area:35} Booty Bay · {npc:15077} Riggle Bassbait · {quest:8193} Master Angler · {skill:356} Fishing
	["The {item:276275} costs one {item:274026}, the prize for winning the Stranglethorn Fishing Extravaganza. The contest runs on Sundays from 2 to 4 pm server time: be on the {area:35} docks by {npc:15077} when it starts. {quest:8193} is not a quest you take: {npc:15077} takes the fish straight from his window when you bring them. Bring your best {skill:356} skill and lures so no fish gets away, a mount and empty bags, and bind your hearthstone in {area:35}."] = "{item:276275}은(는) 가시덤불 골짜기 낚시 대회 우승 상품인 {item:274026} 1개로 살 수 있습니다. 대회는 서버 시간으로 매주 일요일 오후 2시부터 4시까지 열립니다. 시작할 때 {area:35} 부두의 {npc:15077} 옆에 있으세요. {quest:8193}은(는) 받는 퀘스트가 아닙니다. 물고기를 가져가면 {npc:15077}이(가) 대화창에서 바로 받습니다. 물고기를 놓치지 않도록 {skill:356} 숙련도를 최대한 올리고 미끼를 챙기고, 탈것과 빈 가방을 준비하고, {area:35}에 귀환석을 귀속하세요.",

	-- Step 2: Schools of Tastyfish
	["Schools of Tastyfish"] = "맛있는 물고기 떼",
	-- {item:19807} Speckled Tastyfish · {area:35} Booty Bay
	["While the contest runs, schools of {item:19807} appear along the Stranglethorn coast, none inside {area:35}. Fish 40 {item:19807} from them; each school lasts only a few casts, so ride on to the next as soon as one is gone. The arrow takes you up the west coast north of {area:35}; more schools lie further north and just south of {area:35}."] = "대회가 진행되는 동안 스트랭글쏜 해안에 {item:19807} 떼가 나타나며 {area:35} 안에는 없습니다. 떼에서 {item:19807} 40마리를 잡으세요. 떼는 몇 번 낚시하면 사라지니 하나가 사라지면 곧 다음으로 말을 타고 가세요. 화살표는 {area:35} 북쪽 서부 해안을 따라 안내합니다. 더 북쪽과 {area:35} 바로 남쪽에도 떼가 있습니다.",

	-- Step 3: Back to Riggle Bassbait
	-- {npc:15077} Riggle Bassbait
	["Back to {npc:15077}"] = "{npc:15077}에게 돌아가기",
	-- {npc:15077} Riggle Bassbait · {npc:15078} Jang
	["Hurry back and hand the 40 Tastyfish to {npc:15077}: the first players to do so win, and the winners get the coin with their prize. If you are too late to win, {npc:15078} still pays a little gold for every 5 Tastyfish."] = "서둘러 돌아가 {npc:15077}에게 물고기 40마리를 제출하세요. 먼저 제출한 플레이어가 이기고 우승자에게 동전과 상품을 줍니다. 늦었어도 {npc:15078}이(가) 물고기 5마리마다 약간의 골드를 줍니다.",
	-- {npc:15077} Riggle Bassbait
	["The winner's coin, from {npc:15077}"] = "우승자의 동전, {npc:15077}에게서",

	-- Step 4: Jang
	-- {npc:15078} Jang · {npc:15077} Riggle Bassbait · {area:35} Booty Bay · {item:276275} Bitter Baitling
	["{npc:15078}, {npc:15077}'s apprentice, stands beside him on the {area:35} docks and trades the {item:276275} for the coin."] = "{npc:15078}은(는) {npc:15077}의 제자로 {area:35} 부두에서 그 곁에 서서 동전을 {item:276275}으로 교환해 줍니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {item:276275} is a fishing reward: {npc:15078} trades it for one {item:274026}, a reward of the fishing contest {npc:15078} runs in {area:35}. The coin's exact source is not published yet."] = "{item:276275}은(는) 낚시 보상입니다. {npc:15078}이(가) {item:274026} 하나와 교환해 줍니다. 이 주화는 {npc:15078}이(가) {area:35}에서 여는 낚시 대회의 보상입니다. 주화의 정확한 획득처는 아직 공개되지 않았습니다.",
	-- ["{npc:15078} stands on the {area:35} docks."] = "{npc:15078}은(는) {area:35} 부두에 서 있습니다.",
}
