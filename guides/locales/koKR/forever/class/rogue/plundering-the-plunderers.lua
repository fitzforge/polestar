-- Korean (koKR): the guide forever/class/rogue/plundering-the-plunderers (forever/class/rogue/plundering-the-plunderers.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7676} Thistle Tea
	["Ten {item:7676}, the rogue energy drink, from the Horde lockpicking jobs at 16."] = "16레벨 호드 자물쇠 따기 임무로 얻는 도적용 기력 음료 {item:7676} 10개.",

	-- Step 1: To Orgrimmar!
	-- {npc:3170} Kaplak · {area:362} Razor Hill · {npc:3401} Shenthul · {zone:1454} Orgrimmar
	["At 16 {npc:3170}, the rogue trainer in {area:362}, sends you to {npc:3401} in {zone:1454}."] = "16레벨에 {area:362}의 도적 상급자 {npc:3170}이(가) {zone:1454}의 {npc:3401}에게 보냅니다.",

	-- Step 2: Find the Shattered Hand
	-- {npc:6467} Mennet Carkad · {object:36073} Rogues' Quarter · {npc:3401} Shenthul · {zone:1454} Orgrimmar · {quest:1998} Fenwick Thatros · {zone:1421} Silverpine Forest
	["At 16 {npc:6467} in the {object:36073} sends you to {npc:3401} in {zone:1454}. Take {quest:1998} from him too; it is done in {zone:1421} at the end of this guide."] = "16레벨에 {object:36073}의 {npc:6467}이(가) {zone:1454}의 {npc:3401}에게 보냅니다. 그에게서 {quest:1998}도 받으십시오. 이 가이드 마지막에 {zone:1421}에서 완료합니다.",

	-- Step 3: Shenthul and Zando'zan
	-- {npc:3401} Shenthul · {quest:2379} Zando'zan
	["{npc:3401} and {quest:2379}"] = "{npc:3401}와(과) {quest:2379}",
	-- {zone:1458} Undercity · {zone:1411} Durotar · {npc:3401} Shenthul · {quest:2379} Zando'zan · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["Undead take the zeppelin from the towers outside the {zone:1458} to {zone:1411}. {npc:3401} and {quest:2379} stand in the {object:172960}, the canyon under the {object:172982}."] = "언데드는 {zone:1458} 밖의 탑에서 비행선을 타고 {zone:1411}(으)로 가십시오. {npc:3401}와(과) {quest:2379}은(는) {object:172982} 아래 협곡인 {object:172960}에 있습니다.",

	-- Step 4: Wrenix the Wretched
	-- {area:392} Ratchet · {zone:1413} Barrens · {npc:7161} Wrenix the Wretched · {item:7970} E.C.A.C. · {item:5060} Thieves' Tools
	["Fly or ride to {area:392} on the {zone:1413} coast. {npc:7161} stands in town with his Gizmotronic Apparatus: buy an {item:7970} and {item:5060} from the apparatus before you go."] = "{zone:1413} 해안의 {area:392}(으)로 비행하거나 달려가십시오. {npc:7161}은(는) 마을에서 레닉스의 기계장치와 함께 서 있습니다. 떠나기 전에 기계장치에서 {item:7970}와(과) {item:5060}을(를) 구매하십시오.",

	-- Step 5: Southsea Treasure
	-- {area:392} Ratchet · {item:7970} E.C.A.C.
	["South along the coast from {area:392}, at the Southsea pirates' camp. If an unusually hostile parrot attacks you, use the {item:7970} on it (the quest's own advice)."] = "{area:392}에서 해안을 따라 남쪽, 남쪽바다 해적단 야영지입니다. 유난히 적대적인 앵무새가 공격하면 {item:7970}을(를) 사용하십시오(퀘스트 자체의 조언입니다).",

	-- Step 6: Back to Wrenix the Wretched
	-- {npc:7161} Wrenix the Wretched
	["Back to {npc:7161}"] = "{npc:7161}에게 돌아가기",
	-- {npc:7161} Wrenix the Wretched · {item:7676} Thistle Tea
	["{npc:7161}: ten {item:7676}"] = "{npc:7161}: {item:7676} 10개",

	-- Step 7: Fenwick Thatros
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {quest:1998} Fenwick Thatros · {area:228} Sepulcher
	["Take the zeppelin from {zone:1454} to the {zone:1458} and ride south into Silverpine. {quest:1998} stands north-east of the {area:228}."] = "{zone:1454}에서 비행선을 타고 {zone:1458}(으)로 간 뒤 남쪽 은빛소나무 숲으로 달려가십시오. {quest:1998}은(는) {area:228} 북동쪽에 있습니다.",

	-- Step 9: Ambermill
	-- {area:233} Ambermill · {object:103815} Ambermill Strongbox
	["The Kirin Tor keep their reports at {area:233}, in south-east Silverpine: pick the lock on the {object:103815}."] = "키린 토는 은빛소나무 숲 남동쪽의 {area:233}에 보고서를 보관합니다: {object:103815}의 자물쇠를 따십시오.",

	-- Step 10: Back to Mennet Carkad
	-- {npc:6467} Mennet Carkad
	["Back to {npc:6467}"] = "{npc:6467}에게 돌아가기",
}
