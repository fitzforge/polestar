-- Korean (koKR): the guide forever/alliance/30-40/02-desolace (forever/alliance/30-40/02-desolace.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Nijel's Point
	-- {area:460} Sun Rock Retreat · {area:465} Charred Vale · {zone:1443} Desolace · {area:608} Nijel's Point
	["Follow the road west past {area:460} (Horde) and south-west through the {area:465} into {zone:1443}; {area:608} stands at the top of the pass."] = "길을 따라 서쪽으로 {area:460}(호드)을(를) 지나, 남서쪽 {area:465}을(를) 거쳐 {zone:1443}(으)로 가십시오. {area:608}은(는) 고개 꼭대기에 있습니다.",
	-- {npc:5638} Kreldig Ungor · {npc:11863} Azore Aldamort · {area:599} Thunder Axe Fortress
	["{npc:5638}: the wreck's chest lies below {npc:11863}'s tower, on the way to {area:599}"] = "{npc:5638}: 난파선의 궤짝은 {npc:11863}의 탑 아래, {area:599}(으)로 가는 길에 있습니다",

	-- Step 2: Malem chest
	["Malem chest"] = "말렘의 궤짝",
	-- {area:608} Nijel's Point
	["The chest lies in the ruins south-west of {area:608}."] = "궤짝은 {area:608} 남서쪽 폐허에 있습니다.",

	-- Step 3: Sargeron
	-- {area:603} Sargeron · {area:608} Nijel's Point
	-- plural, as words: Hatefury Rogues = {npc:4670} Hatefury Rogue · Hatefury Tricksters = {npc:4671} Hatefury Trickster
	["The Hatefury satyrs hold the ruins of {area:603}, east of {area:608}.\nCareful: Hatefury Rogues spawn stealthed, and Hatefury Tricksters have a poison proc on their attacks."] = "",

	-- Step 5: Nijel's Point
	-- {npc:5642} Vahlarriel Demonslayer · {area:599} Thunder Axe Fortress
	["{npc:5642}: the Burning Blade in {area:599}, where her search leads"] = "",
	-- {npc:5752} Corporal Melkins
	["{npc:5752}: the Kolkar are at the end of this guide"] = "{npc:5752}: 콜카르는 이 가이드 끝에서 처리합니다",
	-- {npc:5396} Captain Pentigast · {npc:5752} Corporal Melkins
	["{npc:5396}, beside {npc:5752}"] = "{npc:5752} 옆의 {npc:5396}",

	-- Step 6: Azore Aldamort
	-- {npc:11863} Azore Aldamort · {area:599} Thunder Axe Fortress
	["{npc:11863}'s tower stands on the hill west of {area:599}: take his quest first, the sceptre he wants is in the fortress."] = "{npc:11863}의 탑은 {area:599} 서쪽 언덕에 있습니다. 먼저 그의 퀘스트를 수락하십시오. 그가 원하는 홀은 요새 안에 있습니다.",

	-- Step 7: Karnitol's Chest
	-- {npc:11863} Azore Aldamort · {object:177787} Rackmore's Log
	["The wrecked ship lies just south-west of {npc:11863}'s tower; its chest sits beside {object:177787}."] = "난파선은 {npc:11863}의 탑 바로 남서쪽에 있습니다. 궤짝은 {object:177787} 옆에 있습니다.",
	-- {npc:5638} Kreldig Ungor
	["For {npc:5638}, at the end of this guide"] = "{npc:5638}에게, 이 가이드 마지막에",
	-- {object:177787} Rackmore's Log
	["{object:177787}, beside the chest: its two keys drop only while you have the quest"] = "",

	-- Step 8: Rackmore's Silver Key
	-- {item:15878} Rackmore's Silver Key
	-- plural, as words: Drysnap Crawlers = {npc:11562} Drysnap Crawler
	["West to the shore: the Drysnap Crawlers and Pincers (33-35) on the beach and the clam beds around the wreck carry {item:15878}, about one in seven."] = "",
	-- {item:15878} Rackmore's Silver Key
	["{item:15878}, from the Drysnap crabs"] = "{item:15878}, 마른집게 게에게서 획득",

	-- Step 9: Sar'theris Strand
	-- {area:598} Sar'theris Strand · {item:15881} Rackmore's Golden Key
	["Keep north to {area:598} for {item:15881}: any Slitherblade can drop it. Work the Naga, Sorceresses and Warriors (32-34) of the strand's southern half until it drops.\nCareful: the Myrmidons (34-35) hold the beach's northern half with the Sea Witches and Oracles (34-36, casters), and Tidehunters (36-37) swim off the northern tip: on the way to the chest, keep to the beach and swim straight across."] = "",
	-- {item:15881} Rackmore's Golden Key
	["{item:15881}, from the Slitherblade naga"] = "",

	-- Step 10: Rackmore's Chest
	-- {area:2406} Ranazjar Isle · {object:177786} Rackmore's Chest · {object:177673} Serpent Statue
	["Swim out to {area:2406} off the far northern tip: {object:177786} stands on the shore beside the {object:177673}. Open it with both keys; leave the statue alone."] = "북쪽 끝에서 헤엄쳐 {area:2406}(으)로 가세요. {object:177786}은(는) 해안의 {object:177673} 옆에 있습니다. 두 열쇠로 여세요. 석상은 건드리지 마세요.",

	-- Step 11: Dalinda Malem
	-- {npc:11863} Azore Aldamort · {npc:5644} Dalinda Malem
	["Back south-east past {npc:11863}'s tower to the Burning Blade's fortress: {npc:5644} hides inside it."] = "",
	["Inside"] = "",

	-- Step 12: Tyranis Malem and the Seer
	-- {npc:5643} Tyranis Malem
	["{npc:5643} and the Seer"] = "{npc:5643}와(과) 현자",
	-- {npc:5643} Tyranis Malem · {npc:13019} Burning Blade Seer · {npc:5642} Vahlarriel Demonslayer
	["Her brother {npc:5643} (36) walks the fortress with the Burning Blade cultists (30-33): pull him alone. The {npc:13019} keeps the sceptre in the fortress's main building. {npc:5642} wants four of each kind of cultist on the way."] = "그녀의 오빠 {npc:5643}(36)는 불타는 칼날단 사교도(30-33)와 함께 요새를 돌아다닙니다. 그만 따로 끌어오세요. {npc:13019}은(는) 요새 본관에 홀을 가지고 있습니다. {npc:5642}은(는) 가는 길에 사교도를 종류별로 넷씩 원합니다.",
	-- {item:6767} Tyranis' Pendant
	["{item:6767}; inside"] = "",
	-- {quest:5741} Sceptre of Light
	["{quest:5741}; on the top floor"] = "",

	-- Step 13: Escort Dalinda Malem
	-- {npc:5644} Dalinda Malem
	["Escort {npc:5644}"] = "{npc:5644} 호위",
	-- {npc:5644} Dalinda Malem
	["{npc:5644}, inside"] = "",
	["Out of Thunder Axe Fortress"] = "천둥도끼 요새 밖으로",
	-- {npc:5644} Dalinda Malem · {npc:5642} Vahlarriel Demonslayer · {area:608} Nijel's Point
	["Lead {npc:5644} out of the fortress; she walks off once you are clear of it. {npc:5642} takes the turn-in at {area:608} at the end of the guide."] = "{npc:5644}을(를) 요새 밖으로 데려가십시오. 요새를 벗어나면 그녀가 떠납니다. 가이드 마지막에 {area:608}에서 {npc:5642}에게 완료 보고를 하십시오.",

	-- Step 14: Azore Aldamort
	-- {npc:11863} Azore Aldamort · {area:2407} Kormek's Hut
	["Back west up the hill to {npc:11863}'s tower with the sceptre, then south along the road to {area:2407}."] = "",
	-- {npc:11863} Azore Aldamort · {npc:12369} Lord Kragaru · {object:177673} Serpent Statue
	["{npc:11863}: {npc:12369} (38) rises at the {object:177673}, for the south loop at the end of 30-40 (06b): keep it"] = "",

	-- Step 15: Bibbly F'utzbuckle
	-- {area:2407} Kormek's Hut · {npc:11596} Smeed Scrabblescrew · {npc:11438} Bibbly F'utzbuckle · {object:176751} Kodo Bones · {area:596} Kodo Graveyard
	["{area:2407} stands by the road south of the fortress, on the way to {npc:11596}'s camp. {npc:11438} collects {object:176751}; they lie among the skeletons of the {area:596}, where {npc:11596}'s kodos are."] = "",

	-- Step 16: Smeed Scrabblescrew
	-- {npc:11596} Smeed Scrabblescrew · {area:609} Kolkar Village · {area:596} Kodo Graveyard
	["{npc:11596}'s camp is on the road south of {area:609}, by the {area:596}."] = "{npc:11596}의 야영지는 {area:609} 남쪽 길가, {area:596} 옆에 있습니다.",

	-- Step 17: Kodo Bones
	-- {area:596} Kodo Graveyard · {npc:11438} Bibbly F'utzbuckle · {object:176751} Kodo Bones · {object:417353} Extinguished Campfire (no name in this language: may be words) · {quest:79229} Highway Robbery
	["West into the {area:596} first: {npc:11438}'s {object:176751} lie among the skeletons on its western side. Just north of them an {object:417353} starts {quest:79229}, also for {npc:11438}."] = "",
	-- {item:13703} Kodo Bone
	["{item:13703}, among the skeletons"] = "",
	-- {quest:79229} Highway Robbery · {object:417353} Extinguished Campfire (no name in this language: may be words)
	["{quest:79229}: the {object:417353}"] = "",

	-- Step 18: Kodo Graveyard
	-- {npc:11596} Smeed Scrabblescrew · {item:13892} Kodo Kombobulator · {npc:4702} Ancient Kodo
	-- plural, as words: Aged Kodos = {npc:4700} Aged Kodo · Scorpashi Lashers = {npc:4697} Scorpashi Lasher · Ancient Kodos = {npc:4702} Ancient Kodo
	["Use {npc:11596}'s {item:13892} on an Aged, Dying or {npc:4702}: it becomes a tamed kodo that follows you. Walk it back to {npc:11596}'s camp; there, talk to the kodo: that counts it and lets you tame the next. Five kodos, one at a time; Aged Kodos also drop the hides, and the Scorpashi Lashers that hunt around the graveyard carry the venom. Careful: the Ancient Kodos (36-37) hit hard: tame them, and fight only the Aged Kodos for the hides."] = "",
	-- {npc:4702} Ancient Kodo
	["on an Aged, Dying or {npc:4702} in the graveyard; don't kill it"] = "",
	-- {npc:11596} Smeed Scrabblescrew
	["the tamed kodo, at {npc:11596}'s camp: talk to it, five times"] = "",

	-- Step 20: Kolkar Village
	-- {npc:11596} Smeed Scrabblescrew · {area:609} Kolkar Village · {area:608} Nijel's Point · {npc:5752} Corporal Melkins · {quest:93224} Carved Centaur Totems · {npc:5396} Captain Pentigast
	-- plural, as words: Centaur Ears = {item:6067} Centaur Ear
	["North-east from {npc:11596}'s camp to {area:609}, on the way back to {area:608}: every Kolkar drops Centaur Ears for {npc:5752} and {quest:93224} for {npc:5396}. The Magram south-east of {npc:11596}'s camp drop them too, but their village holds Necromancers (42-43) and Guardians (39-41): stay with the Kolkar (30-35)."] = "",

	-- Step 21: Kormek's Hut
	-- {area:609} Kolkar Village · {area:608} Nijel's Point · {npc:11438} Bibbly F'utzbuckle · {area:2407} Kormek's Hut · {area:35} Booty Bay
	["North-west from {area:609} back along the road to {area:608}: {npc:11438} waits at {area:2407}. He sends you after the robber to {area:35}, where the next guide ends: keep it."] = "",
	-- {npc:11438} Bibbly F'utzbuckle · {area:35} Booty Bay
	["{npc:11438}: Tokal waits in {area:35}, at the end of the next guide"] = "",

	-- Step 22: Nijel's Point
	-- {npc:5638} Kreldig Ungor · {zone:1443} Desolace
	-- was: ["{npc:5638}: the satchel lies off the north-west coast, on the south loop at the end of 30-40 (06-badlands): keep it"] = "{npc:5638}: 가방은 북서쪽 해안 앞바다에 있으며, 30-40(06-badlands) 마지막의 남쪽 순회 중에 얻습니다. 보관해 두십시오"
	["{npc:5638}: the satchel lies off the north-west coast, on {zone:1443}'s south loop at the end of 30-40: keep it"] = "",

	-- Step 23: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "{area:442}(으)로 비행",
	-- {area:608} Nijel's Point
	["{area:608} flight master"] = "",

	-- Step 24: Boat to Stormwind Harbor
	-- {area:17203} Stormwind Harbor
	["Boat to {area:17203}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Escort the caravan"] = "대상단 호위",
	-- ["From {area:415} head south-west to the {area:1276}, a tunnel through the mountains into Stonetalon."] = "{area:415}에서 남서쪽 {area:1276}(으)로 가십시오. 산을 뚫고 돌발톱 산맥으로 이어지는 터널입니다.",
	-- ["From {area:415} ride north-west into the hills: the {quest:1738} is a glowing tree north of the road to {area:413}. If you took {quest:65602}, the {item:190309} lies in a house among the trees north of {area:413} (26.6,22.0). Then back past {area:415} to the {area:1276}."] = "{area:415}에서 북서쪽 언덕으로 가십시오. {quest:1738}은(는) {area:413}(으)로 가는 길 북쪽의 빛나는 나무입니다. {quest:65602}을(를) 수락했다면 {item:190309}은(는) {area:413} 북쪽 나무 사이의 집 안에 있습니다(26.6,22.0). 그다음 {area:415}을(를) 지나 {area:1276}(으)로 돌아가십시오.",
	-- ["From {zone:1455}'s {npc:1573}"] = "{zone:1455}의 {npc:1573}에게서",
	-- ["Scorpashi venom"] = "스콜파시 독",
	-- ["Take the boat to {area:442} from Menethil's docks."] = "메네실 항구의 부두에서 {area:442}행 배를 타십시오.",
	-- ["Take the boat to {area:442} from Menethil's docks. {npc:3649} stands in {area:442}, north of the flight master."] = "메네실 항구의 부두에서 {area:442}행 배를 타십시오. {npc:3649}은(는) {area:442}의 비행 조련사 북쪽에 있습니다.",
	-- ["The Gizelton Caravan waits at {area:2407}."] = "기젤톤 대상단은 {area:2407}에서 기다립니다.",
	-- ["The Hatefury satyrs hold the ruins of {area:603}, east of {area:608}."] = "서릿발분노 사티로스가 {area:608} 동쪽 {area:603} 폐허를 차지하고 있습니다.",
	-- ["The Kolkar roam the plains around {area:609}; their ears are for {npc:5752}."] = "콜카르일족이 {area:609} 주변 평원을 돌아다닙니다. 귀는 {npc:5752}에게 가져가십시오.",
	-- ["The Scorpashi scorpids hunt the hills around {area:2407} on the road south."] = "스콜파시 전갈이 남쪽 길의 {area:2407} 주변 언덕에서 사냥합니다.",
	-- ["The {area:1276}"] = "{area:1276}",
	-- ["Use {npc:11596}'s {item:13892} on an {npc:4700} and walk the tamed kodo back to his camp, five times; Aged Kodos also drop the hides."] = "{npc:11596}의 {item:13892}을(를) {npc:4700}에게 사용하고 길들인 코도를 그의 야영지로 데려가십시오. 다섯 번 반복합니다. 늙은 코도는 가죽도 떨어뜨립니다.",
	-- ["Walk with the caravan south past {area:609}; Kolkar ambushers jump it on the way. Stay close until it stops at {area:2617}. The ambushers are 34-35 and come in waves: skip it if you are below 33."] = "대상단과 함께 {area:609}을(를) 지나 남쪽으로 걸어가십시오. 도중에 콜카르일족 매복병이 습격합니다. {area:2617}에서 멈출 때까지 가까이 있으십시오. 매복병은 34-35레벨이며 여러 차례 몰려오니, 33레벨 미만이면 건너뛰십시오.",
	-- ["{item:190309}, north of {area:413}"] = "{item:190309}, {area:413} 북쪽",
	-- ["{npc:3649}: {item:279915}, from Sylessa in Menethil"] = "{npc:3649}: {item:279915}, 메네실 항구의 Sylessa에게서",
	-- ["{npc:5638}: the satchel lies off the north-west coast, on the south loop at the end of 30-40 (06-badlands): keep it"] = "{npc:5638}: 가방은 북서쪽 해안 앞바다에 있으며, 30-40(06-badlands) 마지막의 남쪽 순회 중에 얻습니다. 보관해 두십시오",
	-- ["{npc:5644} hides inside the Burning Blade's fortress south-west of {area:608}."] = "{npc:5644}은(는) {area:608} 남서쪽에 있는 불타는칼날단의 요새 안에 숨어 있습니다.",
	-- ["{object:177787}, beside the chest: keep it, its keys and chest come on {zone:1443}'s south loop at the end of 30-40"] = "{object:177787}, 궤짝 옆: 보관하세요. 열쇠와 궤짝은 30-40 마지막의 {zone:1443} 남쪽 순회에서 처리합니다",
}
