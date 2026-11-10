-- Korean (koKR): the guide forever/class/rogue/poisons-horde (forever/class/rogue/poisons-horde.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Poisons (Horde)"] = "",
	-- {item:7676} Thistle Tea
	["Forever teaches Poisons through this chain, not the trainer; the {item:7676} recipe comes with it."] = "",

	-- Step 1: Lockpicking practice
	["Lockpicking practice"] = "",
	-- {object:129127} Gallywix's Lockbox · {spell:1804} Pick Lock · {npc:3401} Shenthul · {object:172960} Cleft of Shadow · {item:5060} Thieves' Tools · {area:392} Ratchet
	["{object:129127} at the end of the tower job needs Lockpicking of about 70-75. Train {spell:1804} from Gest or {npc:3401} in the {object:172960} if you lack it, carry {item:5060}, and pick the Buccaneer's Strongboxes on the middle deck of the Tide Razor, the beached pirate ship south of {area:392}: they come back fast. Your cap rises 5 per level."] = "",
	["Tide Razor"] = "",
	["Lockpicking about 75: pick the Buccaneer's Strongboxes on the Tide Razor"] = "",

	-- Step 2: The Shattered Salute
	-- {npc:3401} Shenthul · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["{npc:3401} stands in the {object:172960}, the canyon under the {object:172982}. Take the quest and wait: he speaks three lines and salutes you. After his third line, target him and type /salute. If it does not count, abandon the quest and take it again. The tower job ahead is built around Ambush, which needs a dagger: if you have none, Kareth, the blade merchant in the {object:172960}, sells a Jambiya."] = "",
	-- {npc:3401} Shenthul
	["/salute {npc:3401}"] = "/경례 {npc:3401}",
	-- {quest:2458} Deep Cover · {item:8051} Flare Gun
	["{quest:2458}: keep the {item:8051}"] = "{quest:2458}: {item:8051}을(를) 보관하세요",

	-- Step 3: Taskmaster Fizzule
	-- {area:382} Sludge Fen · {item:8051} Flare Gun · {npc:3401} Shenthul
	["Fly to the Crossroads and head north to the Venture Co. tower above the {area:382}. Fizzule stands under a tree east of the tower, outside it, and is hostile until signalled. Target him from about 50 yards and fire the {item:8051} twice, then walk up in front of him and /salute. In any other order he attacks. Lost the {item:8051}? Abandon and retake from {npc:3401}."] = "",
	-- {item:8051} Flare Gun
	["{item:8051}, twice, at Fizzule"] = "",

	-- Step 4: Silixiz's Tower Key
	-- {item:8066} Fizzule's Whistle · {npc:7287} Foreman Silixiz · {spell:921} Pick Pocket
	["Keep {item:8066} in your bags and use it on him every time you come near, or he turns hostile. {npc:7287} (level 22) walks by the tower: hug the wall, stealth up behind him and {spell:921} the key. Killing him does not give it; if his pockets are empty, kill him and wait 4 1/2 minutes for him to come back."] = "",
	-- {item:8072} Silixiz's Tower Key
	["Pick Pocket Foreman Silixiz for {item:8072}"] = "",

	-- Step 5: The Venture Co. tower
	["The Venture Co. tower"] = "",
	-- {spell:1943} Rupture · {spell:2098} Eviscerate · {npc:7288} Grand Foreman Puzik Gallywix · {spell:1776} Gouge · {spell:5277} Evasion · {item:7676} Thistle Tea · {object:129127} Gallywix's Lockbox · {spell:9810} Touch of Zanzil · {npc:2391} Serge Hinott
	-- plural, as words: Mutated Venture Co. Drones = {npc:7310} Mutated Venture Co. Drone
	["Inside, floor by floor (everything comes back after 4 1/2 minutes): the Mutated Venture Co. Drones (level 25) on the ground floor die to one Ambush with a dagger; the Patrollers on the second floor take half their health from a one-point {spell:1943}; the Lookouts on the open third floor from a one-point {spell:2098}. {npc:7288} waits on the top floor: a level 23 elite, back 10 minutes after a kill. Open with Ambush (about half his health), then {spell:1776}, {spell:5277}, a healing potion and {item:7676}; a friend makes it easy. One head per kill. Then pick {object:129127} beside him for the cache: it poisons you with the {spell:9810}, which weakens your stealth and agility until {npc:2391} cures it."] = "",
	-- {item:8074} Gallywix's Head · {npc:7288} Grand Foreman Puzik Gallywix
	["{item:8074}: {npc:7288} (elite)"] = "{item:8074}: {npc:7288} (정예)",

	-- Step 6: Back to Shenthul
	-- {npc:3401} Shenthul
	["Back to {npc:3401}"] = "{npc:3401}에게 돌아가기",
	-- {zone:1454} Orgrimmar · {area:392} Ratchet · {item:8072} Silixiz's Tower Key · {area:263} Cleft · {item:2928} Dust of Decay · {item:6947} Instant Poison
	-- plural, as words: Empty Vials = {item:3371} Empty Vial
	["Fly back to {zone:1454} ({area:392} or the Crossroads; dying at the tower and taking the spirit healer's way back to the Crossroads is quicker). Keep {item:8072} afterwards. Before you leave the {area:263}, buy {item:2928} and Empty Vials from Rekkul: once Hinott teaches Poisons, each batch of {item:6947} takes one of each."] = "",

	-- Step 7: Serge Hinott
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {zone:1421} Silverpine Forest · {area:287} Hillsbrad · {area:272} Tarren Mill · {npc:2391} Serge Hinott · {npc:2216} Apothecary Lydon · {npc:3401} Shenthul · {item:6947} Instant Poison
	["Take the zeppelin from {zone:1454} to the {zone:1458} and follow the road south through {zone:1421} into {area:287}, to {area:272}. {npc:2391} works in the building next to the flight path, beside {npc:2216}, a wagon outside. If you lost the Sample of Zanzil's Mixture, abandon and retake from {npc:3401}. Stay beside him for about a minute while he brews the cure; if it never finishes, abandon and retake from him. Then open Poisons from your spellbook to make {item:6947} from Rekkul's dust and vials, and use it on your weapon."] = "",
	["Wait for the cure"] = "해독제 기다리기",
	-- {npc:2391} Serge Hinott
	["{npc:2391}: Poisons"] = "{npc:2391}: 독 조제",
	-- {item:8095} Hinott's Oil · {spell:9810} Touch of Zanzil
	["{item:8095}: clears the {spell:9810}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 20 {npc:3401} stands in the {object:172960}, the canyon under the {object:172982}. Target him and type /salute."] = "20레벨에 {npc:3401}은(는) {object:172982} 아래 협곡인 {object:172960}에 서 있습니다. 그를 대상으로 잡고 /경례를 입력하세요.",
	-- ["Fly back to {zone:1454}."] = "{zone:1454}(으)로 날아 돌아가세요.",
	-- ["Fly to the {area:380} and ride north to the Venture Co. tower north of the {area:382}. In sight of the tower, fire the {item:8051} twice, then /salute {npc:7233} before he attacks you."] = "{area:380}(으)로 날아가 북쪽으로 {area:382} 북쪽의 투자개발회사 탑까지 가세요. 탑이 보이는 곳에서 {item:8051}을(를) 두 번 쏜 뒤, {npc:7233}이(가) 공격하기 전에 /경례를 하세요.",
	-- ["Forever teaches {spell:2842} through this chain, not the trainer; the {item:7676} recipe comes with it."] = "Forever에서는 {spell:2842}을(를) 상급자가 아니라 이 연계 퀘스트로 배웁니다. {item:7676} 제조법도 함께 얻습니다.",
	-- ["Stay stealthed. {npc:7287} carries the tower key; Gallywix (elite) and his lockbox are at the top of the tower. Kill two each of the drones, patrollers and lookouts around it."] = "은신을 유지하세요. {npc:7287}이(가) 탑 열쇠를 지니고 있습니다. 갤리윅스(정예)와 그의 금고는 탑 꼭대기에 있습니다. 주변의 일꾼, 순찰대원, 망꾼을 각각 두 명씩 처치하세요.",
	-- ["Take the zeppelin from {zone:1454} to the {zone:1458} and ride south through {zone:1421} to {area:272} in {area:287}. {npc:2391} stands in {area:272}; wait beside him while he brews the cure."] = "{zone:1454}에서 비행선을 타고 {zone:1458}(으)로 간 뒤, 남쪽으로 {zone:1421}을(를) 지나 {area:287}의 {area:272}까지 가세요. {npc:2391}은(는) {area:272}에 서 있습니다. 그가 해독제를 만드는 동안 옆에서 기다리세요.",
	-- ["{item:8051}, twice, in sight of the tower"] = "{item:8051}, 탑이 보이는 곳에서 두 번",
	-- ["{spell:2842} (Horde)"] = "{spell:2842} (호드)",
}
