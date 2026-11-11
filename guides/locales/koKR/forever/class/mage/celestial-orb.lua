-- Korean (koKR): the guide forever/class/mage/celestial-orb (forever/class/mage/celestial-orb.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7515} Celestial Orb
	["{item:7515} and Stave"] = "{item:7515}와(과) 천상의 지팡이",
	["An off-hand orb or a staff for the late 30s, your pick."] = "30대 후반용 보조장비 구슬이나 지팡이 중 선택.",

	-- Step 1: Return to the Marsh (Stormwind)
	-- {npc:5497} Jennea Cannon · {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:6546} Tabetha · {zone:1455} Ironforge
	["{npc:5497} at the top of the Wizard's Sanctum, {zone:1453}'s {object:2101}, sends you back to {npc:6546}; Bink in {zone:1455} gives the same quest."] = "",

	-- Step 2: Return to the Marsh (Orgrimmar)
	-- {npc:5885} Deino · {zone:1454} Orgrimmar · {object:173161} Darkbriar Lodge (no name in this language: may be words) · {npc:6546} Tabetha · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity · {npc:3048} Ursyn Ghull · {zone:1456} Thunder Bluff
	["{npc:5885}, one of {zone:1454}'s mage trainers in {object:173161}, sends you back to {npc:6546}; {npc:4568} in the {zone:1458} and {npc:3048} in {zone:1456} give the same quest."] = "",

	-- Step 3: Tabetha
	-- {npc:6546} Tabetha · {area:508} Stonemaul Ruins
	["{npc:6546}'s cottage is deep in the marsh west of Theramore, just north of the {area:508}; come in from the west road, the elites roam its east side."] = "",

	-- Step 4: The Infernal Orb
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace · {area:2408} Shadowprey Village · {item:7291} Infernal Orb · {spell:686} Shadow Bolt · {zone:1412} Mulgore · {zone:1456} Thunder Bluff
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner · Nether Maidens = {npc:4679} Nether Maiden
	["The Burning Blade Summoners (level 38-39, not elite) work the {area:602} in southern {zone:1443}, east of {area:2408}, and every one carries an {item:7291}. They cast {spell:686} from 40 yards, keep an imp at their side and run for help at low health; Nether Maidens patrol the pillared ruin beside them, so pull with care. Horde mages: one more summoner stands alone in western {zone:1412}, south-west of {zone:1456}."] = "",

	-- Step 5: The Exorcism
	-- {npc:6546} Tabetha · {quest:1955} The Exorcism · {npc:6549} Demon of the Orb
	["Back at {npc:6546}'s. Hand in the orb now; {quest:1955} waits for level 38. Kill the critters around the cottage first: they join the fight. Accepting {quest:1955} starts a 3 minute timer, and {npc:6546} calls the {npc:6549} out in her garden: a level 40 elite that resists many spells, roots and slows. Grouping up is encouraged: a mage of 40 may need help or potions, at about 45 it is soloable. You can pull it from range from the dock. The timer keeps running after it dies, so hand the quest in straight away. If time runs out, abandon the quest and take it again; she calls the demon again."] = "{npc:6546}에게 돌아가세요. 지금 보주를 제출하세요. {quest:1955}은(는) 38레벨이 될 때까지 기다립니다. 먼저 오두막 주변의 동물들을 처치하세요. 전투에 끼어듭니다. {quest:1955}을(를) 수락하면 3분 타이머가 시작되고, {npc:6546}이(가) 정원으로 {npc:6549}을(를) 불러냅니다. 많은 주문, 이동 불가, 감속에 저항하는 40레벨 정예입니다. 파티를 권장합니다. 40레벨 마법사는 도움이나 물약이 필요할 수 있고, 45레벨쯤이면 혼자 잡을 수 있습니다. 부두에서 원거리로 끌어올 수 있습니다. 처치한 뒤에도 타이머는 계속 흐르니 바로 퀘스트를 제출하세요. 시간이 다 되면 퀘스트를 포기하고 다시 받으세요. 그녀가 악마를 다시 불러냅니다.",
	-- {npc:6549} Demon of the Orb
	["{npc:6549} (elite, 40)"] = "",

	-- Step 6: Power in Uldaman
	-- {area:1517} Uldaman · {zone:1418} Badlands · {area:1898} Dustwind Gulch · {npc:7023} Obsidian Sentinel · {npc:7209} Obsidian Shard
	["{area:1517} is a dungeon in the northern {zone:1418}: a group of five, from level 40 here. Go in by the rear entrance, a cave in {area:1898} south-east of the main entrance (elite dragons fly nearby): the {npc:7023} (level 42 elite) stands just past the first door. At 80, 60, 40 and 20 percent it breaks off an {npc:7209}, an elite too; while a shard lives, both reflect targeted spells, so use area spells and your wand on them. A solo trick: step out through the nearby zone line each time a shard appears; the Sentinel heals but keeps shrinking. It always drops the power source, and takes 2 hours to come back."] = "{area:1517}은(는) {zone:1418} 북부의 던전입니다. 5인 파티가 필요하며, 이 가이드는 40레벨부터 갑니다. 정문 남동쪽 {area:1898}의 동굴인 뒷문으로 들어가세요(근처에 정예 용이 날아다닙니다). {npc:7023}(42레벨 정예)은(는) 첫 번째 문 바로 뒤에 서 있습니다. 생명력 80, 60, 40, 20%에서 역시 정예인 {npc:7209}을(를) 떼어 냅니다. 파편이 살아 있는 동안 둘 다 대상 지정 주문을 반사하므로 광역 주문과 마법봉을 쓰세요. 혼자 하는 요령: 파편이 나타날 때마다 근처의 지역 경계 밖으로 나가세요. 파수병은 회복하지만 계속 작아집니다. 동력원은 항상 떨어지며, 다시 나타나는 데 2시간이 걸립니다.",

	-- Step 7: Mana Surges
	-- {npc:6546} Tabetha · {quest:1957} Mana Surges · {spell:403} Lightning Bolt
	["Back to {npc:6546}. Accepting {quest:1957} opens a rift beside her cottage and starts a 10 minute timer: twelve {quest:1957} (level 40, Shock and {spell:403}) come out about four at a time. Attacking one does not pull the rest. Standing at the edge of the field draws them all; the tree south-west of it is out of their reach but in your spell range. Kill twelve and hand in before the timer runs out."] = "",
	-- {quest:1958} Celestial Power · {item:7515} Celestial Orb · {item:9517} Celestial Stave
	["{quest:1958}: the {item:7515} (off-hand) or the {item:9517}"] = "",

	-- Step 8: Tabetha's Task (optional)
	-- {quest:2861} Tabetha's Task
	["{quest:2861} (optional)"] = "",
	-- {npc:6546} Tabetha · {npc:5497} Jennea Cannon · {npc:4568} Anastasia Hartwell · {npc:5885} Deino · {quest:2861} Tabetha's Task · {quest:2846} Tiara of the Deep · {npc:7795} Hydromancer Velratha · {area:978} Zul'Farrak · {zone:1446} Tanaris · {item:9527} Spellshifter Rod · {item:9531} Gemshale Pauldrons
	["At 40 the mage trainers who send you to {npc:6546} ({npc:5497}, Bink, {npc:4568}, {npc:5885}) also have {quest:2861}, a quest any class can do. {npc:6546} then wants the {quest:2846} from {npc:7795}, a level 46 elite naga in {area:978}, the troll dungeon in north-western {zone:1446}: a group of five, level 44-54. The reward window shows the {item:9527} and the {item:9531}."] = "40레벨이 되면 {npc:6546}에게 보내 주는 마법사 상급자들({npc:5497}, 빙크, {npc:4568}, {npc:5885})이 어느 직업이나 할 수 있는 {quest:2861}도 줍니다. 그다음 {npc:6546}은(는) {zone:1446} 북서쪽의 트롤 던전 {area:978}에 있는 46레벨 정예 나가 {npc:7795}의 {quest:2846}을(를) 원합니다. 5인 파티, 44-54레벨 던전입니다. 보상 창에 {item:9527}와(과) {item:9531}이(가) 표시됩니다.",

	-- Step 9: Tiara of the Deep in Zul'Farrak
	-- {quest:2846} Tiara of the Deep · {area:978} Zul'Farrak
	["{quest:2846} in {area:978}"] = "{area:978}의 {quest:2846}",
	-- {area:978} Zul'Farrak · {zone:1446} Tanaris · {npc:7795} Hydromancer Velratha
	["{area:978}, the troll dungeon in north-western {zone:1446}, needs a group of five; the guide waits for level 44. {npc:7795} is one of the bosses by the sacred pool, and the tiara always drops."] = "{zone:1446} 북서쪽의 트롤 던전 {area:978}은(는) 5인 파티가 필요합니다. 가이드는 44레벨까지 기다립니다. {npc:7795}은(는) 신성한 연못 옆의 우두머리 중 하나이며, 보관은 항상 떨어집니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:6546}. She opens a mana rift beside her cottage: kill twelve {quest:1957} within ten minutes."] = "{npc:6546}에게 돌아가세요. 그녀가 오두막 옆에 마나 균열을 엽니다. 10분 안에 {quest:1957} 12마리를 처치하세요.",
	-- ["The Burning Blade Summoners work the {area:602} in southern {zone:1443}; any of them carries an {item:7291}."] = "불타는칼날단 소환사는 {zone:1443} 남부의 {area:602}에서 활동합니다. 누구든 {item:7291}을(를) 지니고 있습니다.",
	-- ["{area:1517} is a dungeon in the northern {zone:1418}, by the {object:178824}: a group of five. Defeat the {npc:7023} inside for its power source."] = "{area:1517}은(는) {zone:1418} 북부, {object:178824} 옆에 있는 5인 던전입니다. 안에서 {npc:7023}을(를) 물리치고 동력원을 얻으세요.",
	-- ["{npc:5497} in the Wizard's Sanctum, {zone:1453}'s {object:2101}, sends you back to {npc:6546}; Bink in {zone:1455} gives the same quest."] = "{zone:1453} {object:2101}의 마법사의 성소에 있는 {npc:5497}이(가) 당신을 {npc:6546}에게 다시 보냅니다. {zone:1455}의 빙크도 같은 퀘스트를 줍니다.",
	-- ["{npc:5885}, one of {zone:1454}'s mage trainers, sends you back to {npc:6546}; {npc:4568} in the {zone:1458} and {npc:3048} in {zone:1456} give the same quest."] = "{zone:1454}의 마법사 상급자 중 하나인 {npc:5885}이(가) 당신을 {npc:6546}에게 다시 보냅니다. {zone:1458}의 {npc:4568}와(과) {zone:1456}의 {npc:3048}도 같은 퀘스트를 줍니다.",
	-- ["{npc:6546} draws the demon out of the orb beside her cottage. The {npc:6549} is elite: grouping up is advised. You have three minutes before it slips back into the orb."] = "{npc:6546}이(가) 오두막 옆에서 구슬 속 악마를 끌어냅니다. {npc:6549}은(는) 정예이니 파티를 권장합니다. 악마가 구슬로 돌아가기까지 3분이 있습니다.",
	-- ["{npc:6546}'s cottage is deep in the marsh west of Theramore, just north of the {area:508}."] = "{npc:6546}의 오두막은 테라모어 서쪽 늪 깊숙한 곳, {area:508} 바로 북쪽에 있습니다.",
}
