-- Korean (koKR): the guide forever/class/warrior/voodoo-feathers (forever/class/warrior/voodoo-feathers.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:1417} Sunken Temple
	["Experience at 50, ending in the {area:1417}; Forever removed the Classic item choice."] = "50레벨에 얻는 경험치이며, {area:1417}에서 끝납니다. Forever에서는 클래식의 아이템 선택 보상이 제거되었습니다.",
	["Experience"] = "경험치",

	-- Step 1: A Troubled Spirit (Stormwind)
	-- {npc:5479} Wu Shen · {object:2100} Old Town · {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows
	["At 50, {npc:5479} in {object:2100}, beside the Pig and Whistle, sends you to the {npc:7572} in the {zone:1435}."] = "50레벨에 돼지와 휘파람 선술집 옆 {object:2100}의 {npc:5479}이(가) {zone:1435}의 {npc:7572}에게 보냅니다.",

	-- Step 2: A Troubled Spirit (Ironforge)
	-- {npc:5113} Kelv Sternhammer · {zone:1455} Ironforge · {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows
	["At 50, {npc:5113}, the warrior trainer of {zone:1455}, sends you to the {npc:7572} in the {zone:1435}."] = "50레벨에 {zone:1455}의 전사 상급자 {npc:5113}이(가) {zone:1435}의 {npc:7572}에게 보냅니다.",

	-- Step 3: A Troubled Spirit (Darnassus)
	-- {npc:7315} Darnath Bladesinger · {zone:1457} Darnassus · {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows
	["At 50, {npc:7315}, the warrior trainer of {zone:1457}, sends you to the {npc:7572} in the {zone:1435}."] = "50레벨에 {zone:1457}의 전사 상급자 {npc:7315}이(가) {zone:1435}의 {npc:7572}에게 보냅니다.",

	-- Step 4: A Troubled Spirit (Orgrimmar)
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows
	["At 50, {npc:3354} in the {object:172958} sends you to the {npc:7572} in the {zone:1435}."] = "50레벨에 {object:172958}의 {npc:3354}이(가) {zone:1435}의 {npc:7572}에게 보냅니다.",

	-- Step 5: A Troubled Spirit (Thunder Bluff)
	-- {npc:3041} Torm Ragetotem · {zone:1456} Thunder Bluff · {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows
	["At 50, {npc:3041}, the warrior trainer of {zone:1456}, sends you to the {npc:7572} in the {zone:1435}."] = "50레벨에 {zone:1456}의 전사 상급자 {npc:3041}이(가) {zone:1435}의 {npc:7572}에게 보냅니다.",

	-- Step 6: A Troubled Spirit (Undercity)
	-- {npc:4593} Christoph Walker · {zone:1458} Undercity · {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows
	["At 50, {npc:4593}, a warrior trainer of the {zone:1458}, sends you to the {npc:7572} in the {zone:1435}."] = "50레벨에 {zone:1458}의 전사 상급자 {npc:4593}이(가) {zone:1435}의 {npc:7572}에게 보냅니다.",

	-- Step 7: The Fallen Hero of the Horde
	-- {npc:7572} Fallen Hero of the Horde
	["The {npc:7572}"] = "{npc:7572}",
	-- {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows · {zone:1419} Blasted Lands
	["The {npc:7572} stands in the south-west of the {zone:1435}, at the entrance to the {zone:1419}."] = "{npc:7572}은(는) {zone:1435} 남서쪽, {zone:1419} 입구에 있습니다.",

	-- Step 8: Helboars
	-- plural, as words: Helboars = {npc:5993} Helboar
	["Helboars"] = "지옥멧돼지",
	-- {zone:1419} Blasted Lands · {npc:10996} Fallen Hero
	-- plural, as words: Helboars = {npc:5993} Helboar
	["The Helboars roam the north of the {zone:1419}, south of the {npc:10996}."] = "지옥멧돼지는 {npc:10996} 남쪽, {zone:1419} 북부를 돌아다닙니다.",

	-- Step 10: Shadowsworn camps
	["Shadowsworn camps"] = "어둠의혈맹 야영지",
	-- {zone:1419} Blasted Lands
	["The Shadowsworn cultists hold the east of the {zone:1419}."] = "어둠의혈맹 이교도들이 {zone:1419} 동부를 차지하고 있습니다.",

	-- Step 12: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "{area:1417}",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears · {zone:1435} Swamp of Sorrows · {npc:5716} Zul'Lor
	["The {area:1417} lies under the {area:74} in the east of the {zone:1435}. Each of the six Atal'ai trolls on the balcony drops a voodoo feather: Gasher or {npc:5716} the amber, Hukku or Mijan the blue, Zolo or Loro the green. The {area:1417} is a dungeon and the trolls are elite: grouping up is advised."] = "{area:1417}은(는) {zone:1435} 동부의 {area:74} 아래에 있습니다. 발코니의 아탈라이 트롤 여섯이 각각 부두 깃털을 떨어뜨립니다: 게이셔 또는 {npc:5716}은(는) 호박색, 후쿠 또는 마이잔은 파란색, 졸로 또는 로로는 녹색입니다. {area:1417}은(는) 던전이고 트롤은 정예이므로 파티를 권장합니다.",

	-- Step 13: Back to the Fallen Hero
	-- {npc:10996} Fallen Hero
	["Back to the {npc:10996}"] = "{npc:10996}에게 돌아가기",
}
