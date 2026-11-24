-- Korean (koKR): the guide forever/reputation/alterac-valley (forever/reputation/alterac-valley.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Alterac Valley Reputation"] = "알터랙 계곡 평판",
	["One-time quests worth 2,000 and big wins make it the quickest of the four; Exalted gives a Legacy Point."] = "일회성 퀘스트 2,000과 큰 승리가 넷 중 가장 빠르고, 확고한 동맹에서 유산 포인트를 줍니다.",
	["Master of Alterac Valley: a Legacy Point at Exalted"] = "알터랙 계곡의 달인: 확고한 동맹에서 유산 포인트",

	-- Step 1: Lieutenant Rotimer
	-- {zone:1459} Alterac Valley · {zone:1455} Ironforge · {npc:13843} Lieutenant Rotimer · {object:32372} Great Forge (no name in this language: may be words)
	["{zone:1459} is a 40 against 40 battle for level 51 and up, and the fastest of the four battleground reputations: it has about 2,000 reputation of one-time quests, and a full win pays several hundred. The same one-time quests also pay 1,870 {zone:1455} reputation. {npc:13843} recruits outside the {object:32372}. Forever's Legacy Diplomat perk adds up to 10% to every number in this guide."] = "{zone:1459}은(는) 51레벨 이상을 위한 40 대 40 전투로, 네 전장 평판 중 가장 빠릅니다. 일회성 퀘스트 평판이 약 2,000 있고, 완승은 수백을 줍니다. 같은 일회성 퀘스트가 {zone:1455} 평판 1,870도 줍니다. {npc:13843}이(가) {object:32372} 밖에서 모집합니다. Forever의 유산 특성 외교관은 이 가이드의 모든 수치에 최대 10%를 더합니다.",

	-- Step 2: Lieutenant Haggerdin
	-- {zone:1459} Alterac Valley · {zone:1416} Alterac Mountains · {area:287} Hillsbrad
	["The Stormpike camp stands outside the {zone:1459} gate, on the {zone:1416} side above {area:287}. Take every quest here: they all pay 100 or more, once."] = "스톰파이크 야영지는 {area:287} 위 {zone:1416} 쪽, {zone:1459} 문 밖에 있습니다. 여기의 퀘스트를 모두 받으세요. 전부 한 번씩 100 이상을 줍니다.",
	-- {quest:7162} Proving Grounds · {item:17849} Stormpike Banner · {area:3058} Icewing Cavern
	["{quest:7162}: the {item:17849} in {area:3058}, 100"] = "{quest:7162}: {area:3058}의 {item:17849}, 100",
	-- {npc:13777} Sergeant Durgen Stormpike
	["{npc:13777}: assault a graveyard, 100"] = "{npc:13777}: 공동묘지 공격, 100",
	["destroy a tower or bunker banner, 100"] = "탑이나 벙커 깃발 파괴, 100",
	["capture a mine, 100"] = "광산 점령, 100",

	-- Step 3: Dun Baldar
	-- {area:2959} Dun Baldar
	["Queue at the gate, at any battlemaster or from the battleground screen; you enter at {area:2959} in the north. Before the gates open, take the quests in the town: they are done during the battle."] = "문에서, 아무 전장 사령관에게서나 전장 화면에서 줄을 서세요. 북쪽 {area:2959}에서 입장합니다. 문이 열리기 전에 마을의 퀘스트를 받으세요. 전투 중에 하는 것들입니다.",

	-- Step 4: Icewing Cavern
	-- {area:3058} Icewing Cavern · {area:2959} Dun Baldar · {item:17849} Stormpike Banner
	["{area:3058} lies southwest of {area:2959}. The {item:17849} stands at the back of the cave, past the yetis and harpies."] = "{area:3058}은(는) {area:2959} 남서쪽에 있습니다. {item:17849}은(는) 유티와 하피를 지나 동굴 안쪽에 있습니다.",

	-- Step 5: The battle
	["The battle"] = "전투",
	-- {npc:11946} Drek'Thar · {quest:7223} Armor Scraps · {area:3301} Snowfall Graveyard · {area:2963} Coldtooth Mine · {npc:13154} Commander Louis Philips · {area:2962} Tower Point · {npc:13597} Frostwolf Explosives Expert · {area:2961} Frostwolf Village · {quest:7301} Fallen Sky Lords · {npc:11947} Captain Galvangar
	["Most of this happens on the way to {npc:11946}. Loot {quest:7223} from Horde players and guards you kill. Assault the {area:3301} or any Horde graveyard, burn a Horde tower (click its banner), and take {area:2963}. {npc:13154} stands at {area:2962}; the {npc:13597} at {area:2961}. {quest:7301} asks you to find where the three wing commanders landed. In Classic every tower, graveyard or mine paid 12 reputation, {npc:11947} 125 and {npc:11946} about 300."] = "이 대부분은 {npc:11946}에게 가는 길에서 벌어집니다. 처치하는 호드 플레이어와 경비병에게 {quest:7223}을(를) 전리하세요. {area:3301}이나 아무 호드 공동묘지를 공격하고, 호드 탑을 불태우고(깃발 클릭), {area:2963}을(를) 점령하세요. {npc:13154}은(는) {area:2962}에 서 있고, {npc:13597}은(는) {area:2961}에 있습니다. {quest:7301}은(는) 비행중대장 셋이 착지한 곳을 찾으라고 합니다. 고전에서는 탑, 공동묘지, 광산마다 평판 12, {npc:11947}에게 125, {npc:11946}에게 약 300이었습니다.",
	["assault a graveyard"] = "공동묘지 공격",
	["Iceblood Tower banner"] = "얼음피 탑 깃발",
	-- {npc:13437} Wing Commander Ichman
	["{npc:13437}'s spot"] = "{npc:13437}의 자리",
	-- {npc:13439} Wing Commander Vipore
	["{npc:13439}'s spot"] = "{npc:13439}의 자리",
	-- {npc:13438} Wing Commander Slidore
	["{npc:13438}'s spot"] = "{npc:13438}의 자리",

	-- Step 6: Back in Dun Baldar
	-- {area:2959} Dun Baldar
	["Back in {area:2959}"] = "{area:2959}로 돌아가기",

	-- Step 7: Back at the gate
	["Back at the gate"] = "문으로 돌아가기",
	-- {npc:15351} Alliance Brigadier General · {npc:13841} Lieutenant Haggerdin · {quest:8375} Remember Alterac Valley! · {zone:1459} Alterac Valley
	["Your first Alterac Valley Marks of Honor go to the {npc:15351} beside {npc:13841}: 150 the first time ({quest:8375}), then 100 for every 3 more. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1459} marks: hand in or spend them before you reach that."] = "첫 알터랙 계곡 명예 훈장은 {npc:13841} 옆의 {npc:15351}에게 갑니다: 처음엔 150({quest:8375}), 이후엔 3개마다 100. Forever의 PvP 장비도 명예와 함께 명예 훈장을 요구하니 반납하기 전에 원하는 것을 정하세요. {zone:1459} 훈장은 최대 30개까지 지닐 수 있으니 그에 도달하기 전에 반납하거나 쓰세요.",
	["Alterac Valley Marks of Honor: play games"] = "알터랙 계곡 명예 훈장: 게임을 하세요",

	-- Step 8: Stormpike Guard to Friendly
	-- {faction:730} Stormpike Guard
	["{faction:730} to Friendly"] = "{faction:730}: 약간 우호적까지",
	-- {npc:13816} Prospector Stonehewer · {npc:11946} Drek'Thar · {quest:8271} Hero of the Stormpike
	["{npc:13816} by the gate wants {npc:11946} dead: win a game in which your team kills him. Then he lets you pick a weapon ({quest:8271})."] = "문 곁의 {npc:13816}이(가) {npc:11946}의 죽음을 원합니다: 아군이 그를 죽이는 게임에서 승리하세요. 그러면 무기를 고르게 해 줍니다({quest:8271}).",
	-- {quest:8271} Hero of the Stormpike
	["{quest:8271}, 10 and a weapon"] = "{quest:8271}, 10과 무기",

	-- Step 9: Rise and Be Recognized
	-- {npc:13841} Lieutenant Haggerdin · {item:17354} Master Ryson's All Seeing Eye · {npc:12159} Korrak the Bloodrager · {item:19032} Stormpike Battle Tabard · {npc:13217} Thanthaldis Snowgleam
	["Friendly lets {npc:13841} upgrade your insignia: 100 reputation. Friendly to Honored is 6000 reputation. In Classic a full win paid 300 to 700 with its 3 marks; the Brigadier General keeps taking 3 marks for 100. Inside, {item:17354} (75, from the Winterax caves) repeats every game; {npc:12159} (200, when he appears in the middle of the valley) goes back to {npc:13841} here. Friendly opens the {item:19032} (1g) and the Superior Healing and Mana Draughts (5s) at {npc:13217} beside him."] = "약간 우호적이면 {npc:13841}이(가) 휘장을 강화합니다: 평판 100. 약간 우호적에서 우호적은 6,000 평판. 고전에서는 완승이 훈장 3개와 함께 300~700을 줬고, 준장은 계속 3개마다 100을 받습니다. 내부에서는 {item:17354}(75, 윈터액스 동굴)가 매 게임 반복되고, {npc:12159}(200, 계곡 한가운데에 나타날 때)가 여기 {npc:13841}에게 돌아갑니다. 약간 우호적은 {npc:13217}의 {item:19032}(1골)와 상급 치유 및 마나 물약(5실)을 엽니다.",
	-- {item:19032} Stormpike Battle Tabard
	["{item:19032}, 1g"] = "{item:19032}, 1골드",
	-- {npc:15351} Alliance Brigadier General · {quest:8375} Remember Alterac Valley!
	["{npc:15351}: {quest:8375} again, 100 for 3 marks"] = "{npc:15351}: {quest:8375} 다시, 훈장 3개에 100",

	-- Step 10: Honored Amongst the Guard
	-- {npc:13217} Thanthaldis Snowgleam · {npc:13841} Lieutenant Haggerdin
	-- plural, as words: Sage's Cloaks = {item:6614} Sage's Cloak
	["Honored: insignia rank 3, 100 reputation. Honored to Revered is 12000 reputation. {npc:13217} beside {npc:13841} sells the Stormpike Soldier's and Sage's Cloaks and Pendants (about 7g each), the Stormpike belts (4g74s to 7g12s) and the Major Healing and Mana Draughts (10s)."] = "우호적: 휘장 등급 3, 평판 100. 우호적에서 매우 우호적은 12,000 평판. {npc:13841} 옆의 {npc:13217}이(가) 스톰파이크 병사 및 현인 망토와 펜던트(각 약 7골), 스톰파이크 허리띠(4골 74실~7골 12실), 일급 치유 및 마나 물약(10실)을 팝니다.",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: 100 for 3 marks"] = "{npc:15351}: 훈장 3개에 100",

	-- Step 11: Earned Reverence
	-- {npc:13217} Thanthaldis Snowgleam · {item:19100} Electrified Dagger · {item:19102} Crackling Staff · {item:19104} Stormstrike Hammer · {npc:14752} Stormpike Battle Standard · {zone:1459} Alterac Valley · {zone:1461} Arathi Basin · {zone:1460} Warsong Gulch
	["Revered: insignia rank 4, 150 reputation. Revered to Exalted is 21000 reputation, half the climb. Revered opens the weapons at {npc:13217}: {item:19100}, {item:19102} and {item:19104} (31g65s to 39g85s), and the {npc:14752} (5g). At 51 and up Concerted Efforts (3 marks each from {zone:1459}, {zone:1461} and {zone:1460}) pays 200 the first time and 150 after, plus reputation for the other two battlegrounds."] = "매우 우호적: 휘장 등급 4, 평판 150. 매우 우호적에서 확고한 동맹은 21,000 평판으로 전체의 절반입니다. 매우 우호적은 {npc:13217}의 무기를 엽니다: {item:19100}, {item:19102}, {item:19104}(31골 65실~39골 85실), 그리고 {npc:14752}(5골). 51레벨 이상이면 합동 노력({zone:1459}, {zone:1461}, {zone:1460} 각각 훈장 3개)이 처음에 200, 이후에 150을 주고 다른 두 전장 평판도 줍니다.",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: Concerted Efforts"] = "{npc:15351}: 합동 노력",
	-- {npc:13217} Thanthaldis Snowgleam
	["{npc:13217}: Revered rewards"] = "{npc:13217}: 매우 우호적 보상",

	-- Step 12: Legendary Heroes
	-- {npc:13217} Thanthaldis Snowgleam · {item:19030} Stormpike Battle Charger · {item:19325} Don Julio's Band · {item:21563} Don Rodrigo's Band · {item:19323} The Unstoppable Force · {item:19321} The Immovable Object · {item:19324} The Lobotomizer
	["Exalted gives the Legacy Point \"Master of Alterac Valley\" and the last two insignia, 400 reputation that no longer counts for anything but the insignia. {npc:13217} sells the {item:19030} (200g, level 60; its own guide), {item:19325} and {item:21563} (75g56s), {item:19323} (156g49s), {item:19321} (79g53s), {item:19324} (125g66s) and the 50g tomes and off-hands."] = "확고한 동맹은 유산 포인트 「알터랙 계곡의 달인」과 마지막 휘장 둘을 주고, 이제는 휘장 외에 아무짝에도 쓸모없는 평판 400입니다. {npc:13217}이(가) {item:19030}(200골, 60레벨, 자체 가이드), {item:19325}와(과) {item:21563}(75골 56실), {item:19323}(156골 49실), {item:19321}(79골 53실), {item:19324}(125골 66실), 그리고 50골 두루마리와 보조장비를 팝니다.",
	-- {npc:13217} Thanthaldis Snowgleam
	["{npc:13217}: Exalted rewards"] = "{npc:13217}: 확고한 동맹 보상",

	-- Step 13: Frostwolf Ambassador Rokhstrom
	-- {zone:1459} Alterac Valley · {zone:1454} Orgrimmar · {npc:13842} Frostwolf Ambassador Rokhstrom · {object:172982} Valley of Strength
	["{zone:1459} is a 40 against 40 battle for level 51 and up, and the fastest of the four battleground reputations: it has about 2,000 reputation of one-time quests, and a full win pays several hundred. The same one-time quests also pay 1,870 {zone:1454} reputation. {npc:13842} stands in the {object:172982}. Forever's Legacy Diplomat perk adds up to 10% to every number in this guide."] = "{zone:1459}은(는) 51레벨 이상을 위한 40 대 40 전투로, 네 전장 평판 중 가장 빠릅니다. 일회성 퀘스트 평판이 약 2,000 있고, 완승은 수백을 줍니다. 같은 일회성 퀘스트가 {zone:1454} 평판 1,870도 줍니다. {npc:13842}이(가) {object:172982}에 서 있습니다. Forever의 유산 특성 외교관은 이 가이드의 모든 수치에 최대 10%를 더합니다.",

	-- Step 14: Warmaster Laggrond
	-- {zone:1459} Alterac Valley · {zone:1416} Alterac Mountains
	["The Frostwolf camp stands outside the {zone:1459} gate in the {zone:1416}. Take every quest here: they all pay 100 or more, once."] = "프로스트울프 야영지는 {zone:1416}의 {zone:1459} 문 밖에 있습니다. 여기의 퀘스트를 모두 받으세요. 전부 한 번씩 100 이상을 줍니다.",
	-- {quest:7161} Proving Grounds · {item:17850} Frostwolf Banner · {area:3337} Wildpaw Cavern
	["{quest:7161}: the {item:17850} in {area:3337}, 100"] = "{quest:7161}: {area:3337}의 {item:17850}, 100",
	-- {npc:13776} Corporal Teeka Bloodsnarl
	["{npc:13776}: assault a graveyard, 100"] = "{npc:13776}: 공동묘지 공격, 100",
	["capture a tower or bunker, 100"] = "탑이나 벙커 점령, 100",

	-- Step 15: Frostwolf Village
	-- {area:2961} Frostwolf Village
	["Queue at the gate, at any battlemaster or from the battleground screen; you enter at {area:2961} in the south. Before the gates open, take the quests in the village: they are done during the battle."] = "문에서, 아무 전장 사령관에게서나 전장 화면에서 줄을 서세요. 남쪽 {area:2961}에서 입장합니다. 문이 열리기 전에 마을의 퀘스트를 받으세요. 전투 중에 하는 것들입니다.",

	-- Step 16: Wildpaw Cavern
	-- {area:3337} Wildpaw Cavern · {area:2978} Frostwolf Keep · {item:17850} Frostwolf Banner
	["{area:3337} lies south of {area:2978}. The {item:17850} stands at the back of the cave, past the gnolls."] = "{area:3337}은(는) {area:2978} 남쪽에 있습니다. {item:17850}은(는) 그놀을 지나 동굴 안쪽에 있습니다.",

	-- Step 17: The battle
	-- {npc:11948} Vanndar Stormpike · {item:17422} Armor Scraps · {area:3301} Snowfall Graveyard · {area:2957} Irondeep Mine · {npc:13320} Commander Karl Philips · {area:3304} Icewing Bunker · {npc:13598} Stormpike Explosives Expert · {area:2959} Dun Baldar · {quest:7302} Fallen Sky Lords · {npc:11949} Captain Balinda Stonehearth
	["Most of this happens on the way to {npc:11948}. Loot {item:17422} from Alliance players and guards you kill. Assault the {area:3301} or any Alliance graveyard, burn an Alliance bunker (click its banner), and take {area:2957}. {npc:13320} stands at {area:3304}; the {npc:13598} in {area:2959}. {quest:7302} asks you to find where the three wing commanders landed. In Classic every tower, graveyard or mine paid 12 reputation, {npc:11949} 125 and Vanndar about 300."] = "이 대부분은 {npc:11948}에게 가는 길에서 벌어집니다. 처치하는 얼라이언스 플레이어와 경비병에게 {item:17422}을(를) 전리하세요. {area:3301}이나 아무 얼라이언스 공동묘지를 공격하고, 얼라이언스 벙커를 불태우고(깃발 클릭), {area:2957}을(를) 점령하세요. {npc:13320}은(는) {area:3304}에 서 있고, {npc:13598}은(는) {area:2959}에 있습니다. {quest:7302}은(는) 비행중대장 셋이 착지한 곳을 찾으라고 합니다. 고전에서는 탑, 공동묘지, 광산마다 평판 12, {npc:11949}에게 125, 반다르에게 약 300이었습니다.",
	-- {area:3305} Stonehearth Bunker
	["{area:3305} banner"] = "{area:3305} 깃발",
	-- {npc:13179} Wing Commander Guse
	["{npc:13179}'s spot"] = "{npc:13179}의 자리",
	-- {npc:13180} Wing Commander Jeztor
	["{npc:13180}'s spot"] = "{npc:13180}의 자리",
	-- {npc:13181} Wing Commander Mulverick
	["{npc:13181}'s spot"] = "{npc:13181}의 자리",

	-- Step 18: Back in Frostwolf Village
	-- {area:2961} Frostwolf Village
	["Back in {area:2961}"] = "{area:2961}로 돌아가기",

	-- Step 19: Back at the gate
	-- {npc:15350} Horde Warbringer · {quest:8369} Invaders of Alterac Valley · {zone:1459} Alterac Valley
	["Your first Alterac Valley Marks of Honor go to the {npc:15350} by the gate: 150 the first time ({quest:8369}), then 100 for every 3 more. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1459} marks: hand in or spend them before you reach that."] = "첫 알터랙 계곡 명예 훈장은 문 곁의 {npc:15350}에게 갑니다: 처음엔 150({quest:8369}), 이후엔 3개마다 100. Forever의 PvP 장비도 명예와 함께 명예 훈장을 요구하니 반납하기 전에 원하는 것을 정하세요. {zone:1459} 훈장은 최대 30개까지 지닐 수 있으니 그에 도달하기 전에 반납하거나 쓰세요.",

	-- Step 20: Frostwolf Clan to Friendly
	-- {faction:729} Frostwolf Clan
	["{faction:729} to Friendly"] = "{faction:729}: 약간 우호적까지",
	-- {npc:13817} Voggah Deathgrip · {npc:11948} Vanndar Stormpike · {quest:8272} Hero of the Frostwolf
	["{npc:13817} by the gate wants {npc:11948} dead: win a game in which your team kills him. Then he lets you pick a weapon ({quest:8272})."] = "문 곁의 {npc:13817}이(가) {npc:11948}의 죽음을 원합니다: 아군이 그를 죽이는 게임에서 승리하세요. 그러면 무기를 고르게 해 줍니다({quest:8272}).",
	-- {quest:8272} Hero of the Frostwolf
	["{quest:8272}, 10 and a weapon"] = "{quest:8272}, 10과 무기",

	-- Step 21: Rise and Be Recognized
	-- {npc:13840} Warmaster Laggrond · {item:17354} Master Ryson's All Seeing Eye · {item:19031} Frostwolf Battle Tabard · {npc:13219} Jekyll Flandring
	["Friendly lets {npc:13840} upgrade your insignia: 100 reputation. Friendly to Honored is 6000 reputation. In Classic a full win paid 300 to 700 with its 3 marks; the Warbringer keeps taking 3 marks for 100. Inside, {item:17354} (75, from the Winterax caves) repeats every game; The Legend of Korrak (200, when he appears in the middle of the valley) goes back to {npc:13840} here. Friendly opens the {item:19031} (1g) and the Superior Healing and Mana Draughts (5s) at {npc:13219} beside him."] = "약간 우호적이면 {npc:13840}이(가) 휘장을 강화합니다: 평판 100. 약간 우호적에서 우호적은 6,000 평판. 고전에서는 완승이 훈장 3개와 함께 300~700을 줬고, 전쟁인도자는 계속 3개마다 100을 받습니다. 내부에서는 {item:17354}(75, 윈터액스 동굴)가 매 게임 반복되고, 코라크의 전설(200, 계곡 한가운데에 나타날 때)이 여기 {npc:13840}에게 돌아갑니다. 약간 우호적은 {npc:13219}의 {item:19031}(1골)과 상급 치유 및 마나 물약(5실)을 엽니다.",
	-- {item:19031} Frostwolf Battle Tabard
	["{item:19031}, 1g"] = "{item:19031}, 1골드",
	-- {npc:15350} Horde Warbringer · {quest:8369} Invaders of Alterac Valley
	["{npc:15350}: {quest:8369} again, 100 for 3 marks"] = "{npc:15350}: {quest:8369} 다시, 훈장 3개에 100",

	-- Step 22: Honored Amongst the Clan
	-- {npc:13219} Jekyll Flandring · {npc:13840} Warmaster Laggrond · {npc:12051} Frostwolf Legionnaire
	["Honored: insignia rank 3, 100 reputation. Honored to Revered is 12000 reputation. {npc:13219} beside {npc:13840} sells the {npc:12051}'s and Advisor's Cloaks and Pendants (about 7g each), the Frostwolf belts (5g9s to 7g66s) and the Major Healing and Mana Draughts (10s)."] = "우호적: 휘장 등급 3, 평판 100. 우호적에서 매우 우호적은 12,000 평판. {npc:13840} 옆의 {npc:13219}이(가) {npc:12051}과(와) 고문의 망토와 펜던트(각 약 7골), 프로스트울프 허리띠(5골 9실~7골 66실), 일급 치유 및 마나 물약(10실)을 팝니다.",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: 100 for 3 marks"] = "{npc:15350}: 훈장 3개에 100",

	-- Step 23: Earned Reverence
	-- {npc:13219} Jekyll Flandring · {item:19099} Glacial Blade · {item:19101} Whiteout Staff · {npc:14751} Frostwolf Battle Standard · {zone:1459} Alterac Valley · {zone:1461} Arathi Basin · {zone:1460} Warsong Gulch
	["Revered: insignia rank 4, 150 reputation. Revered to Exalted is 21000 reputation, half the climb. Revered opens the weapons at {npc:13219}: {item:19099}, {item:19101} and Frostbite (31g53s to 39g71s), and the {npc:14751} (5g). At 51 and up For Great Honor (3 marks each from {zone:1459}, {zone:1461} and {zone:1460}) pays 200 the first time and 150 after, plus reputation for the other two battlegrounds."] = "매우 우호적: 휘장 등급 4, 평판 150. 매우 우호적에서 확고한 동맹은 21,000 평판으로 전체의 절반입니다. 매우 우호적은 {npc:13219}의 무기를 엽니다: {item:19099}, {item:19101}, 서리이빨(31골 53실~39골 71실), 그리고 {npc:14751}(5골). 51레벨 이상이면 위대한 명예({zone:1459}, {zone:1461}, {zone:1460} 각각 훈장 3개)가 처음에 200, 이후에 150을 주고 다른 두 전장 평판도 줍니다.",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: For Great Honor"] = "{npc:15350}: 위대한 명예",
	-- {npc:13219} Jekyll Flandring
	["{npc:13219}: Revered rewards"] = "{npc:13219}: 매우 우호적 보상",

	-- Step 24: Legendary Heroes
	-- {npc:13219} Jekyll Flandring · {item:19029} Horn of the Frostwolf Howler · {item:19325} Don Julio's Band · {item:21563} Don Rodrigo's Band · {item:19323} The Unstoppable Force · {item:19321} The Immovable Object · {item:19324} The Lobotomizer
	["Exalted gives the Legacy Point \"Master of Alterac Valley\" and the last two insignia, 400 reputation that no longer counts for anything but the insignia. {npc:13219} sells the {item:19029} (200g, level 60; its own guide), {item:19325} and {item:21563} (75g56s), {item:19323} (156g49s), {item:19321} (79g53s), {item:19324} (125g66s) and the 50g tomes and off-hands."] = "확고한 동맹은 유산 포인트 「알터랙 계곡의 달인」과 마지막 휘장 둘을 주고, 이제는 휘장 외에 아무짝에도 쓸모없는 평판 400입니다. {npc:13219}이(가) {item:19029}(200골, 60레벨, 자체 가이드), {item:19325}와(과) {item:21563}(75골 56실), {item:19323}(156골 49실), {item:19321}(79골 53실), {item:19324}(125골 66실), 그리고 50골 두루마리와 보조장비를 팝니다.",
	-- {npc:13219} Jekyll Flandring
	["{npc:13219}: Exalted rewards"] = "{npc:13219}: 확고한 동맹 보상",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Exalted with the {faction:729} earns a Legacy Point."] = "{faction:729}와(과) 확고한 동맹이 되면 유산 점수 1점을 얻습니다.",
	-- ["Exalted with the {faction:730} earns a Legacy Point."] = "{faction:730}와(과) 확고한 동맹이 되면 유산 점수 1점을 얻습니다.",
	-- ["Full games that kill {npc:11946} after the towers fall pay the most."] = "탑을 모두 무너뜨린 뒤 {npc:11946}까지 처치하는 완전한 전투가 가장 많은 평판을 줍니다.",
	-- ["Full games that kill {npc:11948} after the towers fall pay the most."] = "탑을 모두 무너뜨린 뒤 {npc:11948}까지 처치하는 완전한 전투가 가장 많은 평판을 줍니다.",
	-- ["Keep winning {zone:1459}. More Booty! ({npc:13176}), {item:17306} for {npc:13236} (it summons {npc:13256}) and Alterac Ram Hides for the {npc:13441} all repeat."] = "{zone:1459}에서 계속 승리하세요. 추가 전리품!({npc:13176}), {npc:13236}에게 주는 {item:17306}({npc:13256} 소환), {npc:13441}에게 주는 {item:17642}은(는) 모두 반복할 수 있습니다.",
	-- ["Keep winning {zone:1459}. More {quest:7223} ({npc:13257}), Storm Crystals for {npc:13442} (they summon {npc:13419}) and Frostwolf Hides for the {npc:13577} all repeat."] = "{zone:1459}에서 계속 승리하십시오. {quest:7223} 추가 제출({npc:13257}), {npc:13442}에게 폭풍 수정 제출({npc:13419} 소환), {npc:13577}에게 서리늑대 통가죽 제출은 모두 반복할 수 있습니다.",
	-- ["The {faction:729} holds {area:2978} in the south of {zone:1459}. Destroying towers, taking graveyards and mines, and killing captains and generals all pay reputation to the whole team. Loot {item:17422} from fallen enemies for {npc:13176}. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:729}은(는) {zone:1459} 남쪽의 {area:2978}을(를) 지키고 있습니다. 탑 파괴, 무덤과 광산 점령, 대위와 장군 처치는 모두 팀 전체에 평판을 줍니다. 쓰러진 적에게서 {item:17422}을(를) 획득해 {npc:13176}에게 가져가십시오. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",
	-- ["The {faction:730} holds {area:2959} in the north of {zone:1459}. Destroying towers, taking graveyards and mines, and killing captains and generals all pay reputation to the whole team. Loot {quest:7223} from fallen enemies for {npc:13257}. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:730}은(는) {zone:1459} 북쪽의 {area:2959}을(를) 지키고 있습니다. 탑 파괴, 무덤과 광산 점령, 대위와 장군 처치는 모두 팀 전체에 평판을 줍니다. 쓰러진 적에게서 {quest:7223}을(를) 획득해 {npc:13257}에게 가져가십시오. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",
	-- ["{faction:729} to Exalted"] = "{faction:729}: 확고한 동맹까지",
	-- ["{faction:729} to Honored"] = "{faction:729}: 우호적까지",
	-- ["{faction:729} to Revered"] = "{faction:729}: 매우 우호적까지",
	-- ["{faction:730} to Exalted"] = "{faction:730}: 확고한 동맹까지",
	-- ["{faction:730} to Honored"] = "{faction:730}: 우호적까지",
	-- ["{faction:730} to Revered"] = "{faction:730}: 매우 우호적까지",
	-- ["{npc:12096}: Irondeep and {item:17542} from the mines"] = "{npc:12096}: 광산에서 얻은 깊은무쇠 광산 보급품과 {item:17542}",
	-- ["{npc:12097}: Coldtooth and {item:17522} from the mines"] = "{npc:12097}: 광산에서 얻은 얼음이빨 광산 보급품과 {item:17522}",
	-- ["{npc:13176}: More Booty!"] = "{npc:13176}: 추가 전리품!",
	-- ["{npc:13236}: A Gallon of Blood"] = "{npc:13236}: 한 사발의 피",
	-- ["{npc:13257}: More {quest:7223}"] = "{npc:13257}: {quest:7223} 추가 제출",
	-- ["{npc:13442}: Crystal Cluster"] = "{npc:13442}: 폭풍 수정 묶음",
}
