-- Korean (koKR): the guide forever/class/rogue/certificate-of-thievery (forever/class/rogue/certificate-of-thievery.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:6966} Lucius · {quest:2282} Alther's Mill · {quest:2300} SI:7
	["Your first lockpicking job at 16: {npc:6966}'s lockbox at {quest:2282}, for {quest:2300}."] = "16레벨의 첫 자물쇠 따기 임무: {quest:2300}을(를) 위해 {quest:2282}에서 {npc:6966}의 금고를 엽니다.",

	-- Step 1: SI:7 (Goldshire)
	-- {npc:917} Keryn Sylvius · {area:87} Goldshire · {npc:6946} Renzik "The Shiv" · {zone:1453} Stormwind
	["At 16 {npc:917}, the rogue trainer in the Lion's Pride Inn in {area:87}, sends you to {npc:6946} in {zone:1453}."] = "16레벨에 {area:87} 사자무리 여관의 도적 상급자 {npc:917}이(가) {zone:1453}의 {npc:6946}에게 보냅니다.",

	-- Step 2: To Hulfdan! (Kharanos)
	-- {npc:1234} Hogral Bakkan · {area:2102} Thunderbrew Distillery · {area:131} Kharanos · {npc:5165} Hulfdan Blackbeard · {zone:1455} Ironforge
	["At 16 {npc:1234} in the {area:2102} in {area:131} sends you to {npc:5165}, in the north of {zone:1455}."] = "16레벨에 {area:131} {area:2102}의 {npc:1234}이(가) {zone:1455} 북쪽의 {npc:5165}에게 보냅니다.",

	-- Step 4: Erion Shadewhisper (Dolanaar)
	-- {npc:3599} Jannok Breezesong · {area:186} Dolanaar · {quest:2259} Erion Shadewhisper · {zone:1457} Darnassus
	["At 16 {npc:3599} in {area:186} sends you to {quest:2259} in {zone:1457}."] = "16레벨에 {area:186}의 {npc:3599}이(가) {zone:1457}의 {quest:2259}에게 보냅니다.",

	-- Step 6: Renzik "The Shiv"
	-- {npc:6946} Renzik "The Shiv" · {npc:332} Master Mathias Shaw · {quest:2300} SI:7 · {object:2100} Old Town · {area:2257} Deeprun Tram · {zone:1455} Ironforge · {area:442} Auberdine · {area:17203} Stormwind Harbor
	["{npc:6946} stands beside {npc:332} at {quest:2300} in {object:2100}. Dwarves and Gnomes take the {area:2257} from {zone:1455}; Night Elves take the boat from {area:442} to {area:17203}."] = "{npc:6946}은(는) {object:2100}의 {quest:2300}에서 {npc:332} 옆에 서 있습니다. 드워프와 노움은 {zone:1455}에서 {area:2257}을(를) 타십시오. 나이트 엘프는 {area:442}에서 배를 타고 {area:17203}(으)로 가십시오.",

	-- Step 7: Lucius
	-- {zone:1429} Elwynn Forest · {area:69} Lakeshire · {npc:6966} Lucius · {item:5060} Thieves' Tools
	["Ride east through {zone:1429} into Redridge, or fly to {area:69}. {npc:6966} waits on the west side of {area:69} and gives you {item:5060}."] = "{zone:1429}을(를) 지나 동쪽의 붉은마루 산맥으로 가거나 {area:69}(으)로 날아가십시오. {npc:6966}은(는) {area:69} 서쪽에서 기다리며 {item:5060}을(를) 줍니다.",

	-- Step 8: Alther's Mill
	-- {quest:2282} Alther's Mill · {area:69} Lakeshire · {object:121264} Lucius's Lockbox
	["{quest:2282} stands east of {area:69}, up off the road. Open {object:121264} there."] = "{quest:2282}은(는) {area:69} 동쪽, 길에서 벗어난 언덕 위에 있습니다. 그곳에서 {object:121264}을(를) 여십시오.",

	-- Step 9: Back to Lucius
	-- {npc:6966} Lucius
	["Back to {npc:6966}"] = "{npc:6966}에게 돌아가기",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{quest:2282} stands east of {area:69}, up off the road. Open {item:7869} there."] = "{quest:2282}은(는) {area:69} 동쪽, 길에서 벗어난 언덕 위에 있습니다. 그곳에서 {item:7869}을(를) 여십시오.",
}
