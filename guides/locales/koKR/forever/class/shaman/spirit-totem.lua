-- Korean (koKR): the guide forever/class/shaman/spirit-totem (forever/class/shaman/spirit-totem.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:8412} Spirit Totem · {quest:8413} Da Voodoo
	["{quest:8412} and {quest:8413}"] = "{quest:8412} 및 {quest:8413}",
	-- {area:1417} Sunken Temple
	["Experience and gold at 50, ending in the {area:1417}; Forever removed the Classic item choice."] = "50레벨에 얻는 경험치와 골드이며, {area:1417}에서 끝납니다. Forever에서는 클래식의 아이템 선택 보상이 제거되었습니다.",
	["Experience and gold"] = "경험치와 골드",

	-- Step 1: Sagorne Creststrider
	-- {npc:13417} Sagorne Creststrider · {object:172957} Valley of Wisdom · {npc:6176} Bath'rah the Windwatcher
	["At 50 {npc:13417}, the shaman trainer in the {object:172957}, sends you to {npc:6176}."] = "50레벨에 {object:172957}의 주술사 상급자 {npc:13417}이(가) {npc:6176}에게 보냅니다.",

	-- Step 2: Beram Skychaser
	-- {npc:3032} Beram Skychaser · {zone:1456} Thunder Bluff · {npc:6176} Bath'rah the Windwatcher
	["At 50 {npc:3032}, a shaman trainer in {zone:1456}, sends you to {npc:6176}."] = "50레벨에 {zone:1456}의 주술사 상급자 {npc:3032}이(가) {npc:6176}에게 보냅니다.",

	-- Step 3: The four elements
	["The four elements"] = "네 가지 원소",
	-- {item:7069} Elemental Air
	["One each of {item:7069}, Fire, Earth and Water. The Exiles of Arathi Highlands drop them, one element each, about one kill in ten: Thundering (air), Burning (fire), Rumbling (earth) and Cresting (water). Or buy them at the auction house."] = "{item:7069}, 불, 대지, 물을 하나씩 모으십시오. 아라시 고원의 떠도는 정령들이 각자 원소 하나씩을 약 열 번에 한 번 떨어뜨립니다: 떠도는 천둥 정령(공기), 떠도는 불의 정령(불), 떠도는 바위 정령(대지), 떠도는 물의 정령(물). 경매장에서 구매해도 됩니다.",
	-- {item:7069} Elemental Air
	-- plural, as words: Thundering Exiles = {npc:2762} Thundering Exile
	["{item:7069}: Thundering Exiles"] = "{item:7069}: 떠도는 천둥 정령",
	-- {item:7068} Elemental Fire
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile
	["{item:7068}: Burning Exiles"] = "{item:7068}: 떠도는 불의 정령",
	-- {item:7067} Elemental Earth
	-- plural, as words: Rumbling Exiles = {npc:2592} Rumbling Exile
	["{item:7067}: Rumbling Exiles"] = "{item:7067}: 떠도는 바위 정령",
	-- {item:7070} Elemental Water
	-- plural, as words: Cresting Exiles = {npc:2761} Cresting Exile
	["{item:7070}: Cresting Exiles"] = "{item:7070}: 떠도는 물의 정령",

	-- Step 4: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher · {zone:1416} Alterac Mountains · {area:272} Tarren Mill
	["{npc:6176} camps in the east of {zone:1416}, north-east of {area:272}."] = "{npc:6176}은(는) {area:272} 북동쪽, {zone:1416} 동부에 야영하고 있습니다.",

	-- Step 5: Spider eye and bear claw
	["Spider eye and bear claw"] = "거미 눈과 곰 발톱",
	-- {zone:1422} Western Plaguelands · {item:20610} Bloodshot Spider Eye · {item:20611} Thick Black Claw
	-- plural, as words: Venom Mist Lurkers = {npc:1822} Venom Mist Lurker · Diseased Black Bears = {npc:1815} Diseased Black Bear
	["In the {zone:1422}, the Venom Mist Lurkers drop the {item:20610} and the Diseased Black Bears the {item:20611} (about one kill in five each)."] = "{zone:1422}에서 독안개 늑대거미가 {item:20610}을(를), 오염된 흑곰이 {item:20611}을(를) 떨어뜨립니다(각각 약 다섯 번에 한 번).",

	-- Step 7: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "{area:1417}",
	-- {area:1417} Sunken Temple · {area:1477} Temple of Atal'Hakkar · {area:74} Pool of Tears · {npc:5716} Zul'Lor · {item:20606} Amber Voodoo Feather
	["The {area:1417} ({area:1477}) lies under the {area:74}; the arrow points at its entrance. Gasher or {npc:5716} drop the {item:20606}, Hukku or Mijan the Blue, Zolo or Loro the Green: all six are elite trolls inside. Bring a group."] = "{area:1417}({area:1477})은(는) {area:74} 아래에 있으며, 화살표가 입구를 가리킵니다. 게이셔 또는 {npc:5716}이(가) {item:20606}을(를), 후쿠 또는 마이잔이 파란색을, 졸로 또는 로로가 녹색을 떨어뜨립니다. 여섯 모두 내부의 정예 트롤입니다. 파티를 꾸리십시오.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["One each of {item:7069}, Fire, Earth and Water. The Exiles of {zone:1417} drop them, one element each, about one kill in ten: Thundering (air), Burning (fire), Rumbling (earth) and Cresting (water). Or buy them at the auction house."] = "{item:7069}, 불, 대지, 물을 하나씩 모으십시오. {zone:1417}의 떠도는 정령들이 각자 원소 하나씩을 약 열 번에 한 번 떨어뜨립니다: 떠도는 천둥 정령(공기), 떠도는 불의 정령(불), 떠도는 바위 정령(대지), 떠도는 물의 정령(물). 경매장에서 구매해도 됩니다.",
}
