-- Korean (koKR): the guide forever/horde/30-40/02-thousand-needles (forever/horde/30-40/02-thousand-needles.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "{zone:1454}행 비행선",

	-- Step 2: Alliance Relations
	-- {zone:1454} Orgrimmar · {npc:5639} Craven Drok · {npc:5640} Keldran · {object:172961} Valley of Spirits
	["The zeppelin lands at the tower outside {zone:1454}'s main gate. {npc:5639} walks the Drag: if he isn't at the arrow, look along its streets to the south-west. {npc:5640} stands in the {object:172961} on the west side of the city."] = "비행선은 {zone:1454} 정문 밖의 탑에 도착합니다. {npc:5639}은(는) 골목길을 돌아다닙니다. 화살표 위치에 없다면 남서쪽 거리를 따라 찾아보세요. {npc:5640}은(는) 도시 서쪽의 {object:172961}에 서 있습니다.",
	-- {npc:5639} Craven Drok
	["{npc:5639}: offered from level 30"] = "",
	-- {npc:5641} Takata Steelblade · {zone:1443} Desolace
	["for {npc:5641} in {zone:1443}, later in this guide"] = "",

	-- Step 3: Orgrimmar trainers
	-- {zone:1454} Orgrimmar
	["{zone:1454} trainers"] = "",
	["Train while you are in the city."] = "",

	-- Step 4: Searn Firewarder
	-- {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom
	["{npc:5892} stands in the {object:172957}."] = "{npc:5892}은(는) {object:172957}에 서 있습니다.",
	-- {npc:5892} Searn Firewarder · {npc:5905} Prate Cloudseer · {area:484} Freewind Post
	["{npc:5892}: for {npc:5905} by {area:484}, later in this guide"] = "",

	-- Step 5: Fly to the Crossroads
	["Fly to the Crossroads"] = "",
	-- {npc:3428} Korran · {quest:1145} The Swarm Grows
	["{npc:3428}'s {quest:1145} needed level 29 on the last guide's Crossroads stop: take it now, on a short flight to the Crossroads and back."] = "{npc:3428}의 {quest:1145}은(는) 지난 가이드에서 크로스로드에 들렀을 때 29레벨이 필요했습니다. 크로스로드까지 잠깐 날아갔다 돌아오며 지금 받으세요.",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454} 비행 조련사",

	-- Step 6: Korran
	-- {npc:3428} Korran
	["{npc:3428} stands beside the Crossroads flight master."] = "",
	-- {npc:3428} Korran · {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["{npc:3428}: for {npc:4485} in {zone:1454}"] = "",

	-- Step 7: Back to Orgrimmar
	-- {area:1637} Orgrimmar
	["Back to {area:1637}"] = "",
	["Crossroads flight master"] = "크로스로드 비행 조련사",

	-- Step 8: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["{npc:4485} stands in the {object:172958}."] = "",
	-- {npc:4483} Moktar Krin · {area:439} Shimmering Flats
	["for {npc:4483} in the {area:439}, later in this guide"] = "이 가이드 후반, {area:439}의 {npc:4483}용",

	-- Step 10: Thunder Bluff
	-- {zone:1454} Orgrimmar · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {area:484} Freewind Post
	["Fly from {zone:1454} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to {area:484} from there."] = "",

	-- Step 11: Islen Waterseer
	-- {zone:1454} Orgrimmar · {area:392} Ratchet · {npc:5901} Islen Waterseer · {area:484} Freewind Post
	["Fly from {zone:1454} to {area:392}. {npc:5901} camps on the coast a short walk south of the town; fly on to {area:484} from {area:392}."] = "",
	-- {npc:5901} Islen Waterseer · {npc:3527} Healing Stream Totem · {item:5177} Water Totem
	["{npc:5901}: {npc:3527} and your {item:5177}"] = "{npc:5901}: {npc:3527}와(과) {item:5177}",

	-- Step 12: Fly to Freewind Post
	-- {area:484} Freewind Post
	["Fly to {area:484}"] = "{area:484}(으)로 날아가기",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 13: Fly to Freewind Post
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 15: Prate Cloudseer
	-- {npc:5905} Prate Cloudseer
	["{npc:5905} hides in a small cave in the canyon wall north-east of the post, on the way east."] = "",
	-- {npc:5905} Prate Cloudseer · {item:5178} Air Totem
	["{npc:5905}: your {item:5178}"] = "{npc:5905}: {item:5178}",
	-- {npc:5905} Prate Cloudseer · {area:1717} Razorfen Kraul
	["{npc:5905} also starts Elemental Aid ({area:1717}), the 33-40 chain to The Tempest's Weapons: forever/class/shaman/call-of-air-horde."] = "{npc:5905}은(는) 폭풍의 무기로 이어지는 33-40 연계 퀘스트인 정기의 도움({area:1717})도 줍니다: forever/class/shaman/call-of-air-horde.",

	-- Step 16: Dorn Plainstalker
	-- {npc:2986} Dorn Plainstalker · {area:484} Freewind Post · {quest:1149} Test of Faith
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it.\n{npc:2986} waits on the mesa just north-east of {area:484}, across the rope bridges.\nFor the {quest:1149}, walk off the end of the planks beside him: you land safely."] = "경로의 이전 방문 때 이것을 놓쳤습니다. 지금 이것부터 합니다. 금방 끝나며 뒤에 이어지는 퀘스트를 열어 줍니다.\n{npc:2986}은(는) 밧줄 다리를 건너 {area:484} 바로 북동쪽의 고원에서 기다립니다.\n{quest:1149}에서는 그 옆 널빤지 끝에서 걸어 떨어지세요. 안전하게 착지합니다.",

	-- Step 17: Dorn Plainstalker
	-- {npc:2986} Dorn Plainstalker · {area:484} Freewind Post
	["{npc:2986} waits on the mesa just north-east of {area:484}, across the rope bridges."] = "{npc:2986}은(는) 밧줄 다리를 건너 {area:484} 바로 북동쪽의 고원에서 기다립니다.",
	-- {npc:2986} Dorn Plainstalker · {npc:4490} Grenka Bloodscreech
	["{npc:2986}: {npc:4490}, in the harpy den west of the post"] = "{npc:2986}: 거점 서쪽 하피 소굴의 {npc:4490}",

	-- Step 18: Jandia
	-- {npc:4877} Jandia · {area:484} Freewind Post
	["{npc:4877}, the trade supplies vendor, stands inside {area:484}'s inn. The previous guide works her harpies; this is for a character who arrives without them."] = "",
	-- {npc:4877} Jandia · {area:487} Roguefeather Den
	["{npc:4877}: the Screeching harpies of {area:487}"] = "{npc:4877}: {area:487}의 날카로운울음 하피",
	-- {npc:4877} Jandia
	["{npc:4877}: her stolen supplies lie in the same harpy den"] = "",

	-- Step 19: The Screeching Canyon: kill these as you meet them
	-- {area:483} The Screeching Canyon
	["{area:483}: kill these as you meet them"] = "",
	-- {area:2097} Darkcloud Pinnacle · {area:487} Roguefeather Den · {npc:4490} Grenka Bloodscreech · {npc:2986} Dorn Plainstalker · {npc:4877} Jandia · {quest:98069} Stolen Freewind Supplies · {zone:1440} Ashenvale · {zone:1441} Thousand Needles
	["West of Freewind Post, below {area:2097}, the harpies of {area:487} (28-30). {npc:4490} (31) walks among them: thin out the harpies around her before you pull her, for {npc:2986}'s claw. {npc:4877}'s harpies and {quest:98069} (on the ground along the foot of the cliff and in the cave up on top) are here for a character who didn't do them in the {zone:1440} & {zone:1441} guide."] = "",
	-- {quest:98069} Stolen Freewind Supplies
	["{quest:98069}, on the ground around the den"] = "",
	-- {item:5843} Grenka's Claw · {npc:4490} Grenka Bloodscreech
	["{item:5843}, from {npc:4490}"] = "{item:5843}, {npc:4490}에게서 획득",

	-- Step 20: Jandia
	-- {area:484} Freewind Post
	["Back east to {area:484}."] = "동쪽의 {area:484}(으)로 돌아가세요.",
	-- {npc:4877} Jandia
	["{npc:4877}, inside the inn"] = "여관 안의 {npc:4877}",

	-- Step 21: Dorn Plainstalker
	-- {npc:2986} Dorn Plainstalker · {npc:4499} Rok'Alim the Pounder
	["Back across to {npc:2986}'s mesa north-east of the post, then take the lift down to the canyon floor. {npc:2986}'s next test, {npc:4499}, is an elite: leave it."] = "다시 건너가 거점 북동쪽에 있는 {npc:2986}의 고원으로 간 뒤, 승강기를 타고 협곡 바닥으로 내려가세요. {npc:2986}의 다음 시험인 {npc:4499}은(는) 정예입니다. 그냥 두세요.",

	-- Step 22: Stormheart
	-- {npc:270094} Stormheart · {area:484} Freewind Post
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:270094} is a level 30 elite: most classes solo it at level 32, but you may need help. Skip it if you are alone: the route has you grind the XP back.\n{npc:270094} walks the canyon road east of {area:484}'s lift, on the way to the salt flats: kill him for his heart."] = "정예 몹입니다. 파티를 권장하니 함께할 사람을 찾아보십시오. {npc:270094}은(는) 30레벨 정예입니다. 대부분의 직업은 32레벨에 혼자 처치할 수 있지만, 도움이 필요할 수도 있습니다. 혼자라면 건너뛰십시오. 경로에서 사냥으로 경험치를 다시 채우게 됩니다.\n{npc:270094}은(는) 소금 평원으로 가는 길, {area:484} 승강기 동쪽의 협곡 길을 걸어 다닙니다. 처치해서 심장을 얻으십시오.",
	-- {item:279186} Stormheart's Still-beating Heart · {npc:270094} Stormheart
	["{item:279186}, from {npc:270094}"] = "{item:279186}: {npc:270094}에게서",

	-- Step 23: Moktar Krin
	-- {npc:4483} Moktar Krin
	["Take the lift down and follow the canyon east. {npc:4483} camps on the north-western edge of the salt flats."] = "",

	-- Step 24: Mirage Raceway
	-- {area:2240} Mirage Raceway
	["The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "",
	-- {npc:4452} Kravel Koalbeard · {quest:5762} Hemet Nesingwary
	["{npc:4452}'s crate for {quest:5762} in Stranglethorn, later on the route"] = "",

	-- Step 25: Shimmering Flats: kill these as you meet them
	-- {area:439} Shimmering Flats
	["{area:439}: kill these as you meet them"] = "",
	-- plural, as words: Saltstone Basilisks = {npc:4147} Saltstone Basilisk · Sparkleshell Tortoises = {npc:4142} Sparkleshell Tortoise · Salt Flats Scavengers = {npc:4154} Salt Flats Scavenger · Sparkleshell Snappers = {npc:4143} Sparkleshell Snapper · Scorpid Terrors = {npc:4139} Scorpid Terror
	["North-east of the raceway onto the flats. The Saltstone Basilisks (30-31) sun themselves north-west of it, and the Sparkleshell Tortoises (30-31) wander among them on the western flats; the Salt Flats Scavengers and Vultures circle the eastern flats. Every vulture drops a bone, about one tortoise in three a shell.\nCareful: Scavengers and Vultures use Execute when your health is low. The Sparkleshell Snappers (34-35) crowd round a half-buried ship in the north-east and are over you here: the Tortoises of the western flats drop the shells just as often, so stay with them. Take the venom from the Reavers (31-32) of the north half and leave the Scorpid Terrors (33-34) further south."] = "경주장 북동쪽의 평원으로 가세요. 소금바위 바실리스크(30-31)가 그 북서쪽에서 햇볕을 쬐고, 소금껍질거북(30-31)이 서쪽 평원에서 그 사이를 돌아다닙니다. 소금 평원 청소부독수리와 대머리수리는 동쪽 평원을 맴돕니다. 대머리수리는 모두 뼈를 떨어뜨리고, 거북은 약 세 마리 중 한 마리가 등껍질을 떨어뜨립니다.\n주의: 청소부독수리와 대머리수리는 생명력이 낮을 때 마무리 일격을 사용합니다. 무쇠턱 소금껍질거북(34-35)은 북동쪽의 반쯤 묻힌 배 주변에 몰려 있으며 레벨이 높습니다. 서쪽 평원의 소금껍질거북도 등껍질을 똑같이 자주 떨어뜨리니 그쪽에 머무르세요. 독은 북쪽의 붉은독전갈(31-32)에게서 얻고, 더 남쪽의 점박이독전갈(33-34)은 피하세요.",
	-- {item:5795} Hardened Tortoise Shell
	-- plural, as words: Sparkleshell Tortoises = {npc:4142} Sparkleshell Tortoise
	["{item:5795}, from the Sparkleshell Tortoises of the western flats"] = "{item:5795}, 서쪽 평원의 소금껍질거북에게서 획득",
	-- {object:19868} Rocket Car Rubble
	["{object:19868}, all over the northern flats: pick it on the western flats, away from the Snappers"] = "{object:19868}, 북쪽 평원 곳곳: 무쇠턱 소금껍질거북을 피해 서쪽 평원에서 주우세요",
	-- {quest:1104} Salt Flat Venom
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver
	["{quest:1104}, from the Scorpid Reavers of the north half"] = "",

	-- Step 26: Mirage Raceway
	["South-west back to the raceway."] = "",
	-- {npc:4452} Kravel Koalbeard · {quest:1111} Wharfmaster Dizzywig · {area:392} Ratchet
	["{npc:4452}: his parts order goes to {quest:1111} in {area:392}, later on the route"] = "",
	-- {npc:4454} Fizzle Brassbolts · {zone:1418} Badlands
	["{npc:4454}: his letter goes to Martek in the {zone:1418}, at 39"] = "",
	-- {npc:4630} Pozzik · {area:392} Ratchet
	["{npc:4630}: for Gazlowe in {area:392}, later on the route"] = "",

	-- Step 27: Level 32
	["Level 32"] = "32레벨",
	-- {zone:1443} Desolace · {area:1717} Razorfen Kraul
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver · Sparkleshell Snappers = {npc:4143} Sparkleshell Snapper · Scorpid Terrors = {npc:4139} Scorpid Terror
	["The flats' south and the silithid dig are 32-35, {zone:1443}'s quests 32-38. Still below 32 after the raceway's hand-ins? Back north on the flats, the Scorpid Reavers (31-32) roam among the basilisks and tortoises: kill them until level 32; leave the Sparkleshell Snappers (34-35) and the Scorpid Terrors (33-34) alone. Or, with a group, run the {area:1717} dungeon instead."] = "평원 남쪽과 실리시드 발굴지는 32-35레벨, {zone:1443}의 퀘스트는 32-38레벨입니다. 경주장 퀘스트를 제출한 뒤에도 32레벨이 안 되었나요? 평원 북쪽으로 돌아가면 붉은독전갈(31-32)이 바실리스크와 거북 사이를 돌아다닙니다. 32레벨까지 처치하세요. 무쇠턱 소금껍질거북(34-35)과 점박이독전갈(33-34)은 건드리지 마세요. 또는 파티가 있다면 대신 {area:1717} 던전을 도세요.",
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver
	["Scorpid Reavers"] = "붉은독전갈",
	-- {npc:4140} Scorpid Reaver
	["grind on {npc:4140}"] = "{npc:4140} 사냥",

	-- Step 28: The southern flats
	["The southern flats"] = "",
	-- plural, as words: Saltstone Crystalhides = {npc:4151} Saltstone Crystalhide
	["South of the raceway, the Saltstone Crystalhides (32-33) and Gazers (34-35) roam the far end of the flats.\nCareful: the level 35 Gazers can still be two over you: pull them one at a time from the camp's edge, never two together."] = "경주장 남쪽, 평원 끝에는 소금바위 수정바실리스크(32-33)와 응시자 바실리스크(34-35)가 돌아다닙니다.\n주의: 35레벨 응시자 바실리스크는 아직 2레벨 높을 수 있습니다. 무리 가장자리에서 한 마리씩 끌어오고, 절대 두 마리를 함께 끌지 마세요.",

	-- Step 29: The Rustmaul Dig Site
	-- {item:5877} Cracked Silithid Carapace · {npc:4132} Silithid Ravager
	["West of them the silithid swarm the dig site. Searchers and Hive Drones walk among the mounds; the Invaders (34-35) stay inside the hive cave. The first silithid you kill drops a {item:5877}: open it.\nCareful: Hive Drones call for help when they fall to 20% health, and the {npc:4132} (37, rare) walks the dig: take the Searchers and Drones (32-34) outside first, then pull the Invaders (34-35) one at a time from the cave mouth."] = "그 서쪽에서는 실리시드가 발굴지에 떼지어 있습니다. 탐색꾼과 벌집 일벌레는 흙더미 사이를 돌아다니고, 침략자(34-35)는 벌집 동굴 안에 머뭅니다. 처음 처치한 실리시드에게서 {item:5877}이(가) 떨어지니 열어 보세요.\n주의: 벌집 일벌레는 생명력이 20%가 되면 도움을 요청하고, {npc:4132}(37, 희귀)가 발굴지를 돌아다닙니다. 먼저 바깥의 탐색꾼과 일벌레(32-34)를 처치한 뒤, 동굴 입구에서 침략자(34-35)를 하나씩 끌어내세요.",

	-- Step 30: Parts of the Swarm
	["Keep killing silithid at the dig site for the heart, the talons and the carapaces."] = "",

	-- Step 31: Moktar Krin
	-- {npc:4483} Moktar Krin
	["North from the dig to {npc:4483}'s camp on the western edge of the flats."] = "",

	-- Step 32: Mirage Raceway
	-- {area:976} Gadgetzan
	["East to the raceway, on the way south to {area:976}."] = "남쪽 {area:976}(으)로 가는 길에 동쪽 경주장으로 가세요.",

	-- Step 33: Gadgetzan
	-- {zone:1446} Tanaris · {area:976} Gadgetzan · {area:484} Freewind Post
	["South from the raceway over the {zone:1446} border to {area:976}, the walled goblin town: learn its flight path and fly back to {area:484} from there, which is quicker than the walk west across the flats, and the next guides fly straight to {area:976}."] = "경주장에서 남쪽으로 {zone:1446} 경계를 넘어 성벽으로 둘러싸인 고블린 마을 {area:976}(으)로 가십시오. 비행 경로를 익히고 그곳에서 {area:484}(으)로 날아 돌아가십시오. 평원을 가로질러 서쪽으로 걷는 것보다 빠르며, 다음 가이드들은 {area:976}(으)로 곧장 비행합니다.",

	-- Step 35: Freewind Post
	-- {npc:10537} Cliffwatcher Longhorn
	["{npc:10537} stands in the middle of the post, on the way to the flight master."] = "",
	-- {npc:10537} Cliffwatcher Longhorn · {npc:11259} Nataka Longhorn · {zone:1443} Desolace
	["{npc:10537}: for {npc:11259} in {zone:1443}, next"] = "",

	-- Step 36: Fly to Sun Rock Retreat
	-- {area:460} Sun Rock Retreat
	["Fly to {area:460}"] = "{area:460}(으)로 날아가기",
	-- {area:484} Freewind Post
	["{area:484} flight master"] = "",

	-- Step 38: Scrabblescrew's Camp
	-- {zone:1443} Desolace · {npc:11596} Smeed Scrabblescrew
	["Head south out of Stonetalon into {zone:1443} and follow the road south to {npc:11596}'s camp."] = "",

	-- Step 39: Ghost Walker Post
	-- {npc:5395} Felgur Twocuts · {npc:11259} Nataka Longhorn · {npc:5641} Takata Steelblade · {npc:4498} Maurin Bonesplitter · {area:596} Kodo Graveyard
	["{npc:5395} stands in the post, {npc:11259} up on its rise; {npc:5641} and {npc:4498} wait on the rise west of it, above the {area:596}."] = "",
	-- {npc:11259} Nataka Longhorn
	["{npc:11259}, up on the rise"] = "",

	-- Step 41: Takata Steelblade and Maurin Bonesplitter
	-- {npc:5641} Takata Steelblade · {npc:4498} Maurin Bonesplitter
	["{npc:5641} and {npc:4498}"] = "{npc:5641}와(과) {npc:4498}",

	-- Step 42: Ethel Rethor
	-- {area:2405} Ethel Rethor · {npc:11863} Azore Aldamort · {area:599} Thunder Axe Fortress
	["From the rise, north-west across the plain to the ruined tower of {area:2405}: {npc:11863} waits inside. His errand is in {area:599}, the next stop; he takes it back on the walk up the coast later in this guide."] = "",

	-- Step 43: Thunder Axe Fortress
	-- {area:599} Thunder Axe Fortress · {item:6436} Burning Gem · {item:6435} Infused Burning Gem · {npc:13019} Burning Blade Seer · {item:20310} Flayed Demon Skin · {object:176581} Hand of Iruxos Crystal · {npc:11876} Demon Spirit · {zone:1443} Desolace
	["Head east to {area:599}. Beat a Burning Blade cultist down, then use the {item:6436} on it before it dies to fill one {item:6435}. The {npc:13019} stands on the fortress's top floor with the Sceptre. The cultists also drop a {item:20310} now and then (1-5%); if one drops, read it. Leave the red {object:176581} for now: its {npc:11876} is 37, and the second {zone:1443} visit comes back for it."] = "동쪽 {area:599}(으)로 가세요. 불타는칼날단 사교도를 빈사 상태로 만든 뒤 죽기 전에 {item:6436}을(를) 사용해 {item:6435}을(를) 하나씩 채우세요. {npc:13019}은(는) 요새 꼭대기 층에서 홀을 가지고 있습니다. 사교도는 가끔(1-5%) {item:20310}도 떨어뜨리니, 얻으면 읽어 보세요. 붉은 {object:176581}은(는) 지금은 두세요. {npc:11876}이(가) 37레벨이라 두 번째 {zone:1443} 방문 때 다시 옵니다.",
	["On the top floor"] = "",

	-- Step 44: Sargeron
	-- {area:603} Sargeron
	-- plural, as words: Hatefury Rogues = {npc:4670} Hatefury Rogue
	["East from the fortress along the northern hills to the satyrs' ruins of {area:603}. The Shadowstalkers walk unseen.\nCareful: Hatefury Rogues use Hide when they spawn, so they are stealthed until you find them."] = "",

	-- Step 45: Khan Dez'hepah
	-- {area:609} Kolkar Village · {quest:1365} Khan Dez'hepah
	-- plural, as words: Kolkar Battle Lords = {npc:4636} Kolkar Battle Lord
	["South to {area:609}. {quest:1365} (35) walks among the tents on the east side with a Battle Lord or two (32-33): clear around him, then pull him alone at full health.\nCareful: {quest:1365} is level 35, about two levels over you here, and Kolkar Battle Lords call nearby allies within 30 yd once they fall to 20% health."] = "",

	-- Step 46: Ghost Walker Post
	-- {npc:5641} Takata Steelblade · {npc:4498} Maurin Bonesplitter · {npc:5395} Felgur Twocuts · {npc:5412} Gurda Wildmane
	["South-west down the road to the post: {npc:5641} and {npc:4498} on the rise west of it, {npc:5395} and {npc:5412} side by side in the post."] = "",
	-- {npc:5641} Takata Steelblade · {npc:5640} Keldran · {zone:1454} Orgrimmar
	["{npc:5641}: for {npc:5640} in {zone:1454}, next guide"] = "",
	-- {npc:5641} Takata Steelblade · {npc:4498} Maurin Bonesplitter · {area:603} Sargeron
	["{npc:5641}'s next errand sends you after a demon lord with an elite guard, and {npc:4498}'s next Corrupter errand back to {area:603}: leave them."] = "",
	-- {npc:5395} Felgur Twocuts · {npc:11596} Smeed Scrabblescrew
	["{npc:5395}: the Magram centaurs south-east of the post, after {npc:11596}'s kodos"] = "",
	-- {npc:5412} Gurda Wildmane
	["{npc:5412}: her totems drop from the same Magram centaurs"] = "",

	-- Step 47: Kodo Graveyard
	-- {npc:11596} Smeed Scrabblescrew · {item:13892} Kodo Kombobulator · {npc:4702} Ancient Kodo · {npc:11521} Kodo Apparition
	["Use {npc:11596}'s {item:13892} on an Aged, Dying or {npc:4702} in the graveyard and walk the tamed kodo back to {npc:11596}. At his camp, talk to the kodo: that counts it and lets you tame the next. Five kodos, one at a time. Careful: leave the kodo skulls on the ground alone: opening one raises a {npc:11521} (37-38) that hits hard."] = "묘지의 늙은 코도, 죽어가는 코도 또는 {npc:4702}에게 {npc:11596}의 {item:13892}을(를) 사용한 뒤, 길들인 코도를 {npc:11596}에게 데려가세요. 야영지에서 코도에게 말을 걸면 집계되고 다음 코도를 길들일 수 있습니다. 한 번에 한 마리씩 총 다섯 마리입니다. 주의: 땅에 있는 코도 해골은 건드리지 마세요. 열면 강하게 때리는 {npc:11521}(37-38)이(가) 나타납니다.",
	-- {npc:4702} Ancient Kodo
	["on an Aged, Dying or {npc:4702} in the graveyard; don't kill it"] = "",
	-- {npc:11596} Smeed Scrabblescrew
	["the tamed kodo, at {npc:11596}'s camp: talk to it, five times"] = "",

	-- Step 49: Magram Village
	-- {npc:5395} Felgur Twocuts · {item:254432} Carved Centaur Totem
	-- plural, as words: Dread Rippers = {npc:4694} Dread Ripper
	["South-east of Smeed's camp, the Magram centaurs camp in the hills. The Scouts and Outrunners (32-33) and the Wranglers (33-34) hold the camp's north-western edge; any centaur can drop an ear for {npc:5395} and a {item:254432} for Gurda. Careful on the way: Scorpashi Venomlashes (38-39) and Dread Rippers (39-40) roam the ground just west of the camp's edge: give them room.\nCareful: the Stormers and Pack Runners (34-35), Marauders and Maulers (35-36) and the Bonepaws (37-38) hold the middle and south of the camp: stay on its north-western edge and pull one at a time."] = "",
	-- {item:6067} Centaur Ear
	-- plural, as words: Magram Scouts = {npc:4638} Magram Scout
	["{item:6067}, from the Magram Scouts, Outrunners and Wranglers"] = "",
	-- {item:254432} Carved Centaur Totem
	["{item:254432}, from the same centaurs"] = "",

	-- Step 50: Ghost Walker Post
	["Back north-west to the post, on your way west."] = "",

	-- Step 51: Shadowprey Village
	-- {area:606} Gelkis Village
	["Head west to the troll village on the coast, keeping clear of the {area:606} on the way."] = "",
	-- {npc:11877} Roon Wildmane · {quest:5762} Hemet Nesingwary
	["{npc:11877}: for {quest:5762} in Stranglethorn, next guide"] = "",
	-- {npc:6726} Thalon
	["{npc:6726}, at the village's south-west end"] = "",

	-- Step 52: Drulzegar Skraghook
	-- {npc:12340} Drulzegar Skraghook · {npc:12031} Mai'Lahii · {quest:6143} Other Fish to Fry · {area:598} Sar'theris Strand
	["{npc:12340} stands at the village's south end, near {npc:12031}. At your level his {quest:6143} fits the walk north along the coast: the southern half of {area:598}, from level 34."] = "",

	-- Step 53: Ethel Rethor
	-- {npc:11863} Azore Aldamort · {area:2406} Ranazjar Isle
	["North along the coast, then inland to {npc:11863}'s tower. The coast's clams and naga come next, on one walk north to {area:2406}."] = "",
	-- {npc:11863} Azore Aldamort · {item:15803} Book of the Ancients · {npc:12369} Lord Kragaru · {area:2406} Ranazjar Isle
	["{npc:11863}'s next errand, the {item:15803}, needs {npc:12369} (38) out on {area:2406}: leave it, he is over your level."] = "{npc:11863}의 다음 심부름인 {item:15803}에는 {area:2406}의 {npc:12369}(38)이(가) 필요합니다. 레벨이 높으니 건너뛰세요.",

	-- Step 54: Rackmore's Log
	-- {object:177787} Rackmore's Log · {npc:11863} Azore Aldamort
	["{object:177787} lies on the ground just south-west of {npc:11863}'s tower, on the way down to the shore: read it. Its two keys drop only while you have the quest."] = "{object:177787}은(는) {npc:11863}의 탑 바로 남서쪽, 해안으로 내려가는 길의 땅바닥에 놓여 있습니다. 읽어 보세요. 두 열쇠는 퀘스트를 받은 상태에서만 떨어집니다.",

	-- Step 55: Clam beds
	["Clam beds"] = "조개 서식지",
	-- {item:15874} Soft-shelled Clam · {item:15878} Rackmore's Silver Key
	-- plural, as words: Giant Softshell Clams = {object:177784} Giant Softshell Clam · Enraged Reef Crawlers = {npc:12347} Enraged Reef Crawler · Drysnap Crawlers = {npc:11562} Drysnap Crawler
	["West to the shore. Giant Softshell Clams lie in the shallows and the Enraged Reef Crawlers walk the beach: each clam you open on the sea floor, and some crawlers, give a {item:15874}. Open each one in your bags for its meat.\nThe Drysnap Crawlers and Pincers on the same beach carry {item:15878}, about one in seven."] = "서쪽 해안으로 가세요. 얕은 물에는 거대 물렁조개가 있고, 해변에는 성난 산호초 게가 돌아다닙니다. 해저에서 여는 조개마다, 그리고 일부 게에게서 {item:15874}을(를) 얻습니다. 가방에서 하나씩 열어 조갯살을 꺼내세요.\n같은 해변의 마른집게 게와 마른집게 집게발은 약 7마리 중 1마리꼴로 {item:15878}을(를) 지니고 있습니다.",
	-- plural, as words: Giant Softshell Clams = {object:177784} Giant Softshell Clam
	["Giant Softshell Clams, on the sea floor"] = "",
	-- {item:15874} Soft-shelled Clam
	["{item:15874}: open it in your bags"] = "",
	["Underwater"] = "물속",
	-- {item:15878} Rackmore's Silver Key
	["{item:15878}, from the Drysnap crabs"] = "{item:15878}, 마른집게 게에게서 획득",

	-- Step 56: Sar'theris Strand
	-- {area:598} Sar'theris Strand · {item:15881} Rackmore's Golden Key · {zone:1443} Desolace
	-- was: ["Keep north to {area:598} for {item:15881}: any Slitherblade can drop it.\nCareful: the Myrmidons (34-35) hold the beach's northern half with the Sea Witches and Oracles (34-36, casters), up to two over you at 33: work the Naga and Sorceresses (32-33) of the southern half until the key drops, and leave the north for the second {zone:1443} visit, at 38."] = "{item:15881}을(를) 얻으러 북쪽 {area:598}(으)로 계속 가세요. 칼날비늘 나가라면 누구든 떨어뜨릴 수 있습니다.\n주의: 해변 북쪽 절반은 미르미돈(34-35)과 바다 마녀, 예언자(34-36, 시전자)가 차지하고 있어 33레벨이면 최대 2레벨 높습니다. 열쇠가 나올 때까지 남쪽 절반의 나가와 마녀(32-33)를 잡고, 북쪽은 38레벨의 두 번째 {zone:1443} 방문 때 처리하세요."
	["Keep north to {area:598} for {item:15881}: any Slitherblade can drop it.\nCareful: the Myrmidons (34-35) hold the beach's northern half with the Sea Witches and Oracles (34-36, casters), up to two over you at 33: work the Naga and Sorceresses (32-33) of the southern half until the key drops, and leave the north for the second {zone:1443} visit, at about 37."] = "",
	-- {item:15881} Rackmore's Golden Key
	["{item:15881}, from the Slitherblade naga"] = "{item:15881}, 칼날비늘 나가에게서 획득",

	-- Step 57: Sar'theris Strand: Other Fish to Fry
	["Stay in the southern half of the strand, where Rackmore's key drops: eight Myrmidons (34-35) walk there among the Naga, Sorceresses and Warriors (32-34).\nCareful: the northern half belongs to the Sea Witches (35-36, casters) and, at its tip, the Tidehunters (36-37): keep south of the middle of the beach."] = "",
	-- {npc:4714} Slitherblade Myrmidon
	["{npc:4714}, in the strand's southern half"] = "",

	-- Step 58: Rackmore's Chest
	-- {area:2406} Ranazjar Isle · {object:177786} Rackmore's Chest · {object:177673} Serpent Statue
	["Swim out to {area:2406} off the far northern tip: {object:177786} stands on the shore beside the {object:177673}. Open it with both keys; leave the statue alone."] = "북쪽 끝에서 헤엄쳐 {area:2406}(으)로 가세요. {object:177786}은(는) 해안의 {object:177673} 옆에 있습니다. 두 열쇠로 여세요. 석상은 건드리지 마세요.",

	-- Step 59: Shadowprey Village
	["Hearth to Shadowprey (you bound it on the way in), or walk back south along the coast."] = "",
	-- {item:14547} Hand of Iruxos · {npc:12340} Drulzegar Skraghook · {quest:6143} Other Fish to Fry · {zone:1443} Desolace · {zone:1454} Orgrimmar · {zone:1434} Stranglethorn Vale
	["Taiga's {item:14547}, {npc:12340}'s {quest:6143} (unless you did it on the strand) and {zone:1443}'s other 37-40 quests wait for the second visit, at about 37: the next guides fly to {zone:1454} and take the zeppelin to {zone:1434}."] = "",

	-- Step 60: Drulzegar Skraghook
	-- {npc:12340} Drulzegar Skraghook · {npc:12031} Mai'Lahii
	["{npc:12340}, near {npc:12031}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back south to {npc:11863}'s tower."] = "남쪽으로 돌아가 {npc:11863}의 탑으로 가세요.",
	-- ["Head north along the coast, then inland to the ruined tower of {area:2405}: {npc:11863} waits inside. The coast's clams and naga come after {area:599}, on one walk north to {area:2406}."] = "해안을 따라 북쪽으로 간 뒤 내륙으로 들어가 {area:2405}의 폐허가 된 탑으로 가세요. {npc:11863}이(가) 안에서 기다립니다. 해안의 조개와 나가는 {area:599} 이후, {area:2406}까지 북쪽으로 한 번에 이동하며 처리합니다.",
	-- ["Keep north to {area:598} for {item:15881}: any Slitherblade can drop it.\nCareful: the Myrmidons (34-35) hold the beach's northern half with the Sea Witches and Oracles (34-36, casters), up to two over you at 33: work the Naga and Sorceresses (32-33) of the southern half until the key drops, and leave the north for the second {zone:1443} visit, at 38."] = "{item:15881}을(를) 얻으러 북쪽 {area:598}(으)로 계속 가세요. 칼날비늘 나가라면 누구든 떨어뜨릴 수 있습니다.\n주의: 해변 북쪽 절반은 미르미돈(34-35)과 바다 마녀, 예언자(34-36, 시전자)가 차지하고 있어 33레벨이면 최대 2레벨 높습니다. 열쇠가 나올 때까지 남쪽 절반의 나가와 마녀(32-33)를 잡고, 북쪽은 38레벨의 두 번째 {zone:1443} 방문 때 처리하세요.",
	-- ["Keep north to {area:598}. The Slitherblade Myrmidons, Naga and Sorceresses hold the beach; pull them one at a time. Any Slitherblade can drop {item:15881}."] = "북쪽으로 계속 가서 {area:598}에 도착하세요. 해변은 칼날비늘 전사, 나가, 마녀가 지키고 있습니다. 한 번에 하나씩 끌어내세요. 칼날비늘 나가라면 누구나 {item:15881}을(를) 떨어뜨릴 수 있습니다.",
	-- ["Shadowprey's {quest:5381} and the coast's naga want 33. Below that? The Kolkar centaurs (30-32) of {area:609}, a short way east of {npc:11596}'s camp, are the nearest camp at your level: kill them until level 33. The Scorpashi Lashers (34-35) on the slopes north of the camp are higher. Or, with a group, run the {area:1717} dungeon instead."] = "그늘수렵 마을의 {quest:5381}과(와) 해안의 나가는 33레벨이 필요합니다. 그보다 낮습니까? {npc:11596}의 야영지에서 동쪽으로 조금 떨어진 {area:609}의 콜카르일족 켄타우로스(30-32)가 레벨이 맞는 가장 가까운 야영지입니다. 33레벨이 될 때까지 처치하십시오. 야영지 북쪽 비탈의 Scorpashi Lashers(34-35)는 레벨이 더 높습니다. 또는 파티와 함께 대신 {area:1717} 던전을 도십시오.",
	-- ["Swim out to {area:2406} off the far northern tip and use the {item:15766} on the {object:177673}: {npc:12369} (38) rises; kill him for the {quest:6027}. He is well above you: rest to full first. {object:177786} stands on the shore beside the statue: open it with both keys."] = "북쪽 끝에서 {area:2406}까지 헤엄쳐 가서 {object:177673}에 {item:15766}을(를) 사용하세요. {npc:12369}(38)이(가) 나타납니다. 처치하여 {quest:6027}을(를) 얻으세요. 레벨이 훨씬 높으니 먼저 생명력을 가득 회복하세요. {object:177786}은(는) 석상 옆 해안에 있습니다. 두 열쇠로 여세요.",
	-- ["Taiga's {item:14547}, Drulzegar's Other Fish to Fry and {zone:1443}'s other 37-40 quests wait for the second visit, at 38: the next guides fly to {zone:1454} and take the zeppelin to {zone:1434}."] = "타이가의 {item:14547}, 드룰제가의 '더 중요한 일'과 {zone:1443}의 다른 37-40 퀘스트는 38레벨의 두 번째 방문 때 합니다. 다음 가이드는 {zone:1454}(으)로 날아가 {zone:1434}행 비행선을 탑니다.",
	-- ["West of Freewind Post, below {area:2097}, the harpies of {area:487} (28-30). The Screeching Harpies, Roguefeathers and Windcallers there are {npc:4877}'s; her {quest:98069} lie on the ground along the foot of the cliff and in the cave up on top. {npc:4490} (31) walks among them: thin out the harpies around her before you pull her, for {npc:2986}'s claw."] = "바람의 쉼터 서쪽, {area:2097} 아래에 있는 {area:487}의 하피(28-30). 그곳의 날카로운울음 하피, 도적깃털 하피, 바람부름이 하피는 {npc:4877}의 퀘스트 대상입니다. 그녀의 {quest:98069}은(는) 절벽 아래쪽 땅바닥과 꼭대기 동굴 안에 놓여 있습니다. {npc:4490}(31)이(가) 그들 사이를 돌아다닙니다. {npc:2986}의 발톱을 위해 주변 하피를 먼저 정리한 뒤 끌어오세요.",
	-- ["grind on {npc:4635}"] = "{npc:4635} 사냥",
	-- ["{item:15766}, on the {object:177673}"] = "{item:15766}, {object:177673}에 사용",
	-- ["{npc:4877}, the trade supplies vendor, stands inside {area:484}'s inn."] = "직업용품 상인 {npc:4877}은(는) {area:484} 여관 안에 서 있습니다.",
	-- ["{npc:5395} now offers Centaur Bounty: the second {zone:1443} visit, at 38, takes it on its way to the {area:607}."] = "{npc:5395}이(가) 이제 '켄타우로스 현상금'을 줍니다. 38레벨의 두 번째 {zone:1443} 방문 때 {area:607}(으)로 가는 길에 받습니다.",
	-- ["{npc:5641}'s next errand sends you after a demon lord with an elite guard: skip it."] = "{npc:5641}의 다음 심부름은 정예 호위병을 거느린 악마 군주를 쫓게 합니다. 건너뛰세요.",
}
