-- Russian (ruRU): the guide forever/alliance/50-60/01-burning-steppes (forever/alliance/50-60/01-burning-steppes.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: To Ironforge
	-- {zone:1455} Ironforge
	["To {zone:1455}"] = "В таверну: {zone:1455}",
	-- {zone:1455} Ironforge · {zone:1425} Hinterlands
	-- was: ["Your Hearthstone is set at {zone:1455} (the {zone:1425} guide binds it there): hearth back to the inn."] = "Ваш камень возвращения привязан к городу {zone:1455} (его привязывает там гайд по зоне {zone:1425}): вернитесь в таверну."
	["Your Hearthstone is set at {zone:1455} (the {zone:1425} guide binds it there): hearth back to the inn from Un'Goro."] = "",
	-- {zone:1455} Ironforge
	["{zone:1455} inn"] = "Таверна: {zone:1455}",

	-- Step 2: Mystic Ward
	-- {npc:11406} High Priest Rohan · {npc:8405} Ogtinc · {zone:1447} Azshara
	["{npc:11406}: for {npc:8405} in {zone:1447}, at the end of this guide: keep it"] = "",
	-- {npc:7312} Dink · {npc:8395} Sanath Lim-yo · {zone:1447} Azshara
	["{npc:7312}, the mage trainer: for {npc:8395} in {zone:1447}, at the end of this guide: keep it"] = "",

	-- Step 4: Courier Hammerfall
	-- {npc:10877} Courier Hammerfall
	["{npc:10877} rides around the city's ring on his ram: catch him as he passes."] = "",
	-- {npc:10838} Commander Ashlam Valorfist · {area:3197} Chillwind Camp
	["For {npc:10838} at {area:3197}, the next stop"] = "",

	-- Step 5: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}."] = "Аркессон стоит рядом с королем Магни ({object:171709}).",

	-- Step 6: Royal Historian Archesonus
	-- {quest:3701} The Smoldering Ruins of Thaurissan · {npc:8978} Thauris Balgarr · {zone:1428} Burning Steppes
	-- plural, as words: War Reavers = {npc:7039} War Reaver
	["{quest:3701} is a group quest at this level: its relics stand among War Reavers and Firewalkers of 53-55, with {npc:8978} (57) close by, two to five over you, and the route has no later {zone:1428} visit. Grouping up is encouraged, look for people to do it with. Skip it if you are alone."] = "«{quest:3701}» на этом уровне – групповое задание: реликвии стоят среди боевых разорителей и огнеходов 53-55 уровня, рядом {npc:8978} (57), на два-пять уровней выше вас, а в зону {zone:1428} маршрут больше не вернется. Лучше собрать группу, поищите, с кем пойти. Если вы один, пропустите.",
	-- {zone:1428} Burning Steppes
	["The relics are in the {zone:1428}: keep it"] = "Реликвии – в зоне {zone:1428}: сохраните",

	-- Step 7: Fly to Aerie Peak
	-- {area:348} Aerie Peak
	["Fly to {area:348}"] = "Летите сюда: {area:348}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Распорядитель полетов ({zone:1455})",

	-- Step 8: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Летите сюда: {area:271}",

	-- Step 9: The Super Snapper FX
	-- {item:9328} Super Snapper FX · {zone:1425} Hinterlands · {area:307} Overlook Cliffs
	["Gammerita need not die: target her and use the {item:9328}. She is a level 48 elite, so keep your distance.\nGammerita walks the {zone:1425} shore below the {area:307}, from the arrow south to about 75,66 and north to about 82,52: if she isn't at the arrow, follow the shore."] = "",
	-- {item:9328} Super Snapper FX
	["the {item:9328} on Gammerita: no kill"] = "",

	-- Step 10: Fly to Southshore
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "Распорядитель полетов: {area:348}",

	-- Step 11: Orphan Matron Aria
	-- {area:271} Southshore · {area:279} Dalaran · {npc:34365} Orphan Matron Aria · {npc:266524} Lieutenant Connar · {area:1438} Nethergarde Keep
	["Ride north from {area:271} into Alterac and west to the walls of {area:279}: {npc:34365} stands outside them. Her quest goes to {npc:266524} in {area:1438}, where this guide flies later."] = "Езжайте на север из места {area:271} в Альтерак и на запад к стенам города {area:279}: {npc:34365} стоит за ними. Ее задание ведет к NPC {npc:266524} ({area:1438}), куда этот гайд полетит позже.",

	-- Step 12: Western Plaguelands
	-- {area:271} Southshore · {area:3197} Chillwind Camp
	["Ride north from {area:271} up the road through Alterac to {area:3197}."] = "",

	-- Step 13: Chillwind Camp
	-- {npc:10838} Commander Ashlam Valorfist
	["{npc:10838} stands in the middle of the camp."] = "",

	-- Step 14: Sorrow Hill: kill these as you meet them
	-- {area:197} Sorrow Hill
	["{area:197}: kill these as you meet them"] = "{area:197}: убивайте их по пути",
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Skeletal Flayers and Slavering Ghouls (50) roam the fields north of the camp; all the Scourge here drop Scourgestones.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "",

	-- Step 15: Chillwind Camp
	["Ride back south to the camp."] = "Езжайте назад на юг к лагерю.",
	-- {area:199} Felstone Field · {zone:1422} Western Plaguelands
	["keep it: the {area:199} cauldron waits for the {zone:1422} guide"] = "",

	-- Step 16: Fly to Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["Fly to {area:2418}"] = "Летите сюда: {area:2418}",
	-- {area:3197} Chillwind Camp
	["{area:3197} flight master"] = "Распорядитель полетов: {area:3197}",

	-- Step 17: Fly to Lakeshire
	-- {area:69} Lakeshire
	["Fly to {area:69}"] = "Летите сюда: {area:69}",

	-- Step 18: Morgan's Vigil flight master
	-- {area:2418} Morgan's Vigil
	["{area:2418} flight master"] = "Распорядитель полетов: {area:2418}",
	-- {area:69} Lakeshire · {zone:1428} Burning Steppes · {area:2418} Morgan's Vigil
	["Ride east out of {area:69} and up the pass into the {zone:1428}: {area:2418} stands at the top."] = "Езжайте на восток из места {area:69} и вверх по перевалу в зону {zone:1428}: {area:2418} – наверху.",

	-- Step 19: Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["{area:2418} sits in the south-east of the Steppes, at the top of the pass up from Redridge."] = "",

	-- Step 20: Dreadmaul Rock
	-- {area:249} Dreadmaul Rock · {npc:9602} Hahk'Zor · {npc:9604} Gorgon'och
	-- plural, as words: Firegut Ogres = {npc:7033} Firegut Ogre · Escaped Core Hounds = {npc:227746} Escaped Core Hound
	["The Firegut ogres hold the great rock north of the Vigil, with the Brutes on its east side.\nCareful: the Firegut Ogres are 50 and the Ogre Mages 51, but the Brutes on the rock's east side are 52: take the ogres on the near side first and pull the Brutes one at a time.\nCareful: Escaped Core Hounds (level 60) roam the Steppes, a few on the slopes west and south of {area:249}: pull the ogres on the rock itself and look around before each pull.\nCareful: the Firegut chiefs {npc:9602} and {npc:9604} (54) stand on the rock's east side among the Brutes: leave them be."] = "",
	-- {npc:7034} Firegut Ogre Mage
	["{npc:7034}, below ground"] = "{npc:7034}, под землей",

	-- Step 21: Morgan's Vigil
	-- {npc:9177} Oralius · {npc:9176} Gor'tesh · {area:254} Blackrock Mountain
	-- plural, as words: Blackrock Medallions = {item:11467} Blackrock Medallion
	["{npc:9177}' next tasks ({npc:9176}, and fifty Blackrock Medallions) send you among the Blackrock orcs of 55-58 at the foot of {area:254}: skip them."] = "Следующие задания NPC {npc:9177} ({npc:9176} и пятьдесят медальонов Черной горы) отправят вас к оркам Черной горы 55-58 уровня у подножия места {area:254}: пропустите их.",

	-- Step 22: Flame Crest
	-- {area:251} Flame Crest
	["Follow the road west, then climb north to the goblin camp on {area:251}."] = "Идите по дороге на запад, затем поднимитесь на север к лагерю гоблинов: {area:251}.",

	-- Step 23: Ruins of Thaurissan: kill these as you meet them
	-- {area:250} Ruins of Thaurissan
	["{area:250}: kill these as you meet them"] = "{area:250}: убивайте их по пути",
	-- {item:12284} Draco-Incarcinatrix 900 · {npc:7047} Black Broodling · {area:251} Flame Crest · {npc:8981} Malfunctioning Reaver · {npc:7040} Black Dragonspawn
	-- was: ["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves.\nCareful: a {npc:8981} (level 56, rare) walks the slopes by the broodlings, and the {npc:7040} and Wyrmkin around them are elite: use the Incarcinatrix on a broodling at the edge and look around before each pull."] = "Используйте {item:12284} на существе {npc:7047} на склонах к востоку от места {area:251} прямо перед его смертью, затем заберите оставшуюся эссенцию.\nОсторожно: {npc:8981} (56-й уровень, редкий) ходит по склонам у детенышей, а {npc:7040} и драконы вокруг них – элитные: используйте инкарцинатор на детеныше с краю и осматривайтесь перед каждым нападением."
	["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves.\nCareful: a {npc:8981} (level 56, rare) walks the slopes by the broodlings, Volchan (60, a rare fire elemental) roams the hills east of {area:251}, and the {npc:7040} and Wyrmkin around them are elite: use the Incarcinatrix on a broodling at the edge and look around before each pull."] = "",

	-- Step 24: Ruins of Thaurissan
	-- {area:250} Ruins of Thaurissan · {area:251} Flame Crest · {npc:8978} Thauris Balgarr · {object:147516} Dark Iron
	-- plural, as words: War Reavers = {npc:7039} War Reaver · Thaurissan Firewalkers = {npc:7037} Thaurissan Firewalker
	["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered. Take the ones on the ruins' southern edge, nearest {area:251}.\nCareful: the ruins' War Reavers and Thaurissan Firewalkers are 53-55, and {npc:8978} (57) holds the {object:147516} camp south-west of {area:251}: take the relics at the edge of the ruins, pull one at a time, and keep away from the camp."] = "Реликвии – резные камни, разбросанные по месту {area:250} вокруг места {area:251}: нажимайте на них, пока сведения не будут восстановлены. Берите те, что на южном краю руин, ближе к месту {area:251}.\nОсторожно: боевые разорители и огнеходы Тауриссана – 53-55 уровня, а {npc:8978} (57) занимает лагерь ({object:147516}) к юго-западу от места {area:251}: берите реликвии с края руин, выманивайте по одному и держитесь подальше от лагеря.",

	-- Step 25: Flame Crest
	-- {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Ends with {quest:4808} in {area:2255}, {zone:1452}: keep it"] = "Завершается заданием «{quest:4808}» ({area:2255}, {zone:1452}): сохраните",

	-- Step 26: Cyrus Therepentous
	-- {item:10569} Hoard of the Black Dragonflight · {zone:1427} Searing Gorge · {item:10575} Black Dragonflight Molt · {npc:9459} Cyrus Therepentous
	["Open the {item:10569} from {zone:1427} for its {item:10575}, then tell {npc:9459} you bring proof of your deeds: no drake to fight.\nCareful: Volchan (60, a rare fire elemental) roams the hills around {npc:9459}'s cave: if he is about, wait for him to pass."] = "",
	["Below ground"] = "Под землей",
	-- {item:10575} Black Dragonflight Molt
	["{item:10575}, from the hoard"] = "{item:10575}, из клада",

	-- Step 28: A Taste of Flame
	-- {npc:9461} Frenzied Black Drake
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:9461} is a level 54 elite: most classes solo it at level 56, but you may need help. Skip it if you are alone."] = "",

	-- Step 30: Morgan's Vigil
	["Ride back east along the road to the Vigil."] = "Езжайте по дороге назад на восток к Дозору.",

	-- Step 31: Fly to Nethergarde Keep
	-- {area:1438} Nethergarde Keep
	["Fly to {area:1438}"] = "Летите в {area:1438}",

	-- Step 32: Ambassador Ardalan
	-- {area:1438} Nethergarde Keep
	["Ardalan is inside {area:1438}."] = "Ардалан находится внутри крепости ({area:1438}).",
	-- {npc:266524} Lieutenant Connar · {npc:266508} Sergeant Danneth · {area:1440} Serpent's Coil
	["{npc:266524}: {npc:266508} is in the {area:1440} caverns, on this loop"] = "",
	-- {quest:2990} Thadius Grimshade
	["{quest:2990}, at the top of the keep"] = "{quest:2990}, на вершине крепости",
	-- {npc:8022} Thadius Grimshade · {item:9471} Nekrum's Medallion · {area:978} Zul'Farrak
	["{npc:8022}' next task, {item:9471}, is a {area:978} quest: skip it."] = "Следующее поручение {npc:8022}, {item:9471}, — задание для подземелья {area:978}: пропустите.",
	-- {npc:3546} Bernie Heisten · {quest:87295} Deflective Surface
	["{npc:3546}: {quest:87295}, the scales come from the basilisks ahead"] = "{npc:3546}: «{quest:87295}», чешуя – с василисков впереди",

	-- Step 33: Swamp of Sorrows
	-- {zone:1419} Blasted Lands · {zone:1435} Swamp of Sorrows · {npc:10996} Fallen Hero · {area:75} Stonard
	["Ride north out of the {zone:1419} into the {zone:1435}: the {npc:10996} stands by the road from the {zone:1419}. Keep clear of {area:75}, the Horde town to the north-east."] = "Езжайте на север из зоны {zone:1419} в зону {zone:1435}: {npc:10996} стоит у дороги, ведущей из зоны {zone:1419}. Держитесь подальше от места {area:75} – это город Орды на северо-востоке.",

	-- Step 34: Fallen Hero of the Horde
	["Listen to his tale, then ride back south to Kum'isha."] = "Выслушайте его рассказ, затем езжайте назад на юг к Кум'ише.",

	-- Step 35: Back to the Blasted Lands
	-- {zone:1419} Blasted Lands
	["Back to the {zone:1419}"] = "Назад в зону {zone:1419}",

	-- Step 36: Blasted Lands: kill these as you meet them
	-- {zone:1419} Blasted Lands
	["{zone:1419}: kill these as you meet them"] = "{zone:1419}: убивайте их по пути",
	-- {zone:1419} Blasted Lands · {npc:5982} Black Slayer · {npc:221740} Calefactus the Unleashed · {npc:247015} Vek'zol · {npc:8301} Clack the Reaver · {npc:8298} Akubar the Seer · {area:1440} Serpent's Coil · {item:8244} Flawless Draenethyst Sphere
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger · Ashmane Boars = {npc:5992} Ashmane Boar · Redstone Basilisks = {npc:5990} Redstone Basilisk · Snickerfang Matriarchs = {npc:272386} Snickerfang Matriarch
	["Ride back south into the {zone:1419} for the bloodmages' beasts: Starving Snickerfangs roam the dry hills south of the bloodmages' camp, Scorpok Stingers scuttle across the middle of the north and {npc:5982} vultures circle over all of it. Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep.\nCareful: two elites roam here: {npc:221740} (50) in the middle of the zone around 44,34, and {npc:247015} (55) on the ridge around 39,32. When you see one, hunt somewhere else.\nCareful: {npc:8301} (53, a rare scorpid) walks the north around 47,36, {npc:8298} (54, rare) the middle around 45,48, and Snickerfang Matriarchs (60) roam the ground east of here, between Kum'isha's hill and the {area:1440} (about 54-62, 31-47): give them room.\nAny mob here may drop a {item:8244}: keep it for Kum'isha."] = "",
	-- {item:8244} Flawless Draenethyst Sphere
	["{item:8244}, a rare drop"] = "",

	-- Step 38: Kum'isha the Collector
	-- {area:2517} Rise of the Defiler · {zone:1419} Blasted Lands · {npc:7664} Razelikh the Defiler · {spell:2691} Mana Burn · {spell:8255} Strong Cleave · {object:141891} Razelikh's Tear · {spell:10854} Flames of Chaos · {npc:247015} Vek'zol
	-- plural, as words: Imperfect Draenethyst Fragments = {item:10593} Imperfect Draenethyst Fragment
	["Kum'isha waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have. Come at her hill straight from the keep, along the road, and leave by the same way.\nCareful: Felcular, {npc:7664} and Ilifar are all level 60 elites. Razelikh casts {spell:2691}, {spell:8255} and Decimate, and as its health drops it adds {object:141891}, {spell:10854} and then Enrage at 15%.\nCareful: {npc:247015}, a level 55 elite, stands by Kum'isha's hill (about 50,35) and to the west (about 39,32), and the Dreadmaul and Shadowsworn camps around it are 53-55: take the fragments from the mobs on the way from the keep, not beside him."] = "Кум'иша ждет на холме ({area:2517}) к юго-западу от крепости. Противники зоны {zone:1419} по пути роняют несовершенные фрагменты дренетиста; принесите ей, сколько есть. Подходите к ее холму прямо от крепости, по дороге, и уходите тем же путем.\nОсторожно: Фелкулар, {npc:7664} и Илифар – элитные противники 60-го уровня. Разелих применяет {spell:2691}, {spell:8255} и Истребление, а по мере потери здоровья добавляет {object:141891}, {spell:10854}, а затем Исступление на 15%.\nОсторожно: {npc:247015}, элитный противник 55-го уровня, стоит у холма Кум'иши (около 50,35) и западнее (около 39,32), а лагеря Жуткой Тучи и Клятвы Тени вокруг – 53-55 уровня: добывайте фрагменты с противников по пути от крепости, а не рядом с ним.",
	-- {npc:7363} Kum'isha the Collector
	["{npc:7363} walks around here: look inside the circle on the map"] = "",

	-- Step 39: Kum'isha the Collector
	-- {zone:1419} Blasted Lands · {item:8244} Flawless Draenethyst Sphere
	["A {zone:1419} mob dropped a {item:8244}: Kum'isha pays for it too."] = "",

	-- Step 40: Sergeant Danneth
	-- {area:1440} Serpent's Coil · {area:1438} Nethergarde Keep · {npc:7728} Kirith the Damned · {npc:7666} Archmage Allistarj
	-- plural, as words: Snickerfang Matriarchs = {npc:272386} Snickerfang Matriarch · Shadowsworn Cultists = {npc:6004} Shadowsworn Cultist
	["Ride east from Kum'isha's hill to the mouth of the {area:1440} caverns, due south of {area:1438}: Danneth hides just inside.\nCareful: Snickerfang Matriarchs (60) roam the ground between Kum'isha's hill and the caverns: watch for them on the ride and go round them, there and back.\nCareful: Shadowsworn Cultists, Thugs and Adepts (51-52) guard the caves, and the deeper chambers hold {npc:7728} (55, elite) and {npc:7666} (58, elite): stay near the mouth, pull one at a time, and lead Danneth straight out.\nWalk him out of the caves and north to {area:1438}: Connar takes him there."] = "",

	-- Step 41: Nethergarde Keep
	-- {area:1438} Nethergarde Keep · {npc:3546} Bernie Heisten
	["Back north into {area:1438}: Connar, then Danneth again once he is home. {npc:3546} takes his scales here too."] = "",
	-- {npc:34365} Orphan Matron Aria · {zone:1423} Eastern Plaguelands · {area:3197} Chillwind Camp
	["For {npc:34365} in Alterac, on the Western & {zone:1423} guide's ride to {area:3197}: keep it"] = "",

	-- Step 42: The bloodmages
	["The bloodmages"] = "Маги крови",
	-- {zone:1419} Blasted Lands
	["Ride west out of the keep to the bloodmages' camp beside the road into the {zone:1419}."] = "",
	["The bloodmages' second tier pays for the same parts with a buff item and no experience: skip it."] = "Вторая ступень заданий магов крови платит за те же части предметом-усилением без опыта: пропустите.",

	-- Step 43: To Ironforge
	-- {zone:1455} Ironforge
	["Hearth back to {zone:1455}'s inn."] = "Вернитесь камнем возвращения в таверну ({zone:1455}).",

	-- Step 44: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "Летите сюда: {area:144}",

	-- Step 47: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Лететь в {area:1537}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "Распорядитель полетов: {area:144}",

	-- Step 49: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}: the relics you read in the Steppes are his."] = "Аркессон стоит рядом с королем Магни ({object:171709}): реликвии, которые вы прочли в Пылающих степях, – для него.",

	-- Step 50: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Летите сюда: {area:150}",

	-- Step 52: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "Летите сюда: {area:415}",
	-- {area:442} Auberdine · {area:415} Astranaar · {zone:1448} Felwood · {zone:1457} Darnassus
	["The boat lands in {area:442}: fly straight on to {area:415}. Erelas, Jenal and Gracina take their deliveries on the {zone:1448} guide's {zone:1457} stop, which goes there anyway."] = "",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "Распорядитель полетов: {area:442}",

	-- Step 53: Into Azshara
	-- {zone:1447} Azshara
	["Into {zone:1447}"] = "В зону {zone:1447}",
	-- {area:415} Astranaar · {area:2358} Forest Song · {zone:1447} Azshara · {area:1235} Shadowsong Shrine
	["From {area:415}, ride east along the road past {area:2358} into {zone:1447}: {area:1235} lies just over the border, in {zone:1447}'s south-west corner."] = "Из города {area:415} езжайте на восток по дороге мимо места {area:2358} в зону {zone:1447}: {area:1235} – сразу за границей, в юго-западном углу зоны {zone:1447}.",
	-- {area:1235} Shadowsong Shrine
	["East along the road to {area:1235}"] = "На восток по дороге: {area:1235}",

	-- Step 54: Shadowsong Shrine
	-- {zone:1447} Azshara · {area:3137} Talrendis Point
	["The shrine lies in the south-west corner of {zone:1447}, south of {area:3137}."] = "Святилище лежит в юго-западном углу зоны {zone:1447}, к югу от заставы ({area:3137}).",

	-- Step 55: Talrendis Point
	-- {npc:239822} Commander Truesong · {npc:240482} Berdun Cliffbrew · {area:3137} Talrendis Point
	["Just north-east of the shrine: {npc:239822} and {npc:240482} keep the Alliance camp at {area:3137}."] = "Сразу к северо-востоку от святилища: {npc:239822} и {npc:240482} держат лагерь Альянса ({area:3137}).",

	-- Step 56: Mosshoof Runners
	-- plural, as words: Mosshoof Runners = {npc:8759} Mosshoof Runner
	["Mosshoof Runners"] = "Мохокопытные бегуны",
	-- {area:3137} Talrendis Point
	-- plural, as words: Mosshoof Runners = {npc:8759} Mosshoof Runner
	["The Mosshoof Runners (45-47) graze the hills north of {area:3137}, on the way to the satyrs."] = "Мохокопытные бегуны (45-47) пасутся на холмах к северу от места {area:3137}, по пути к сатирам.",

	-- Step 57: Azshara: kill these as you meet them
	-- {zone:1447} Azshara
	["{zone:1447}: kill these as you meet them"] = "{zone:1447}: убивайте их по пути",
	-- {npc:222478} Sentinel Keldara Sunblade
	["The Highborne ghosts haunt the ruins around the shrine; the Haldarr satyrs hold the camp just north of it. {npc:222478} is held in the satyrs' camp: free her and walk her out."] = "Призраки высокорожденных бродят по руинам вокруг святилища; сатиры из племени Халдарр занимают лагерь сразу к северу от него. {npc:222478} в плену в лагере сатиров: освободите ее и выведите оттуда.",
	-- {npc:222478} Sentinel Keldara Sunblade
	["{npc:222478}, in the camp"] = "{npc:222478} – в лагере",

	-- Step 58: The western shore
	["The western shore"] = "Западный берег",
	-- plural, as words: Spitelash Warriors = {npc:6190} Spitelash Warrior
	["The Spitelash Warriors (46-47) and Screamers (47-48) hold the western shore north-east of the satyrs."] = "Воины (46-47) и крикуны (47-48) из клана Бича Злобы занимают западный берег к северо-востоку от сатиров.",

	-- Step 59: Talrendis Point
	-- {area:3137} Talrendis Point
	["Back south-west to {area:3137}."] = "Обратно на юго-запад: {area:3137}.",
	-- {npc:239822} Commander Truesong · {quest:88809} Preserving Eldarath · {area:1221} Ruins of Eldarath
	["{npc:239822}: {quest:88809}, the relics drop from the naga of the {area:1221} ahead"] = "",
	-- {npc:239822} Commander Truesong · {quest:92345} Beneath Nordrassil · {npc:4217} Mathrengyl Bearwalker · {zone:1457} Darnassus · {zone:1448} Felwood
	["{npc:239822}: {quest:92345}, for {npc:4217} in {zone:1457}, on the {zone:1448} guide: keep it"] = "",

	-- Step 62: Ogtinc
	-- {npc:8405} Ogtinc · {area:1224} Bear's Head
	["Ride north-east from the shrine: {npc:8405} camps at the {area:1224}, in the hills above the road."] = "Езжайте от святилища на северо-восток: {npc:8405} стоит лагерем здесь – {area:1224}, в холмах над дорогой.",

	-- Step 63: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo · {npc:8379} Archmage Xylem
	["Get off your mount before you talk to {npc:8395}: he teleports you up to {npc:8379}'s tower on the cliff above his camp."] = "",

	-- Step 64: Archmage Xylem
	["The apprentice at the top of the tower sends you back down."] = "",
	-- {area:1220} Thalassian Base Camp · {npc:8420} Kim'jael
	["The blood elves are at the {area:1220}, on the way to {npc:8420}"] = "",

	-- Step 65: The Ruins of Eldarath
	-- {area:1221} Ruins of Eldarath
	["The {area:1221}"] = "{area:1221}",
	-- {area:1221} Ruins of Eldarath · {item:13815} Some Rune · {item:10445} Drawing Kit
	-- was: ["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s four runes stand among the ruins: use his {item:10445} on each."] = "Наги из клана Бича Злобы ({area:1221}) носят предмет {item:13815}. Четыре руны, которые нужны NPC {npc:8507}, стоят среди руин: используйте на каждой его {item:10445}."
	["The Spitelash naga of the {area:1221} carry {item:13815}. Tymor's runes stand among the ruins: use his {item:10445} on each."] = "",

	-- Step 66: Lord Sarthiss
	-- {npc:239939} Lord Sarthiss
	-- plural, as words: Eldarath Relics = {item:280608} Eldarath Relic
	-- was: ["The Spitelash naga of these ruins drop Truesong's Eldarath Relics, top-up or not. {npc:239939} (52) stands in the ruins of Eldarath, south-west of the Myrmidons: pull him alone."] = "Наги из клана Бича Злобы в этих руинах роняют эльдаратские реликвии для Верной Песни, добираете вы опыт или нет. {npc:239939} (52) стоит в руинах Эльдарата, к юго-западу от мирмидонов: выманивайте его в одиночку."
	["The Spitelash naga of these ruins drop Truesong's Eldarath Relics. {npc:239939} (52) stands in the ruins of Eldarath, south-west of the Myrmidons: pull him alone."] = "",

	-- Step 67: Ekkal
	-- {npc:235903} Ekkal · {npc:8420} Kim'jael
	["{npc:235903} camps by the road north to {npc:8420}: his satyrs are in {npc:8420}'s camp."] = "{npc:235903} стоит лагерем у дороги на север к NPC {npc:8420}: его сатиры – в лагере NPC {npc:8420}.",

	-- Step 68: Mosshoof Coursers
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers"] = "Мохоногие олени",
	-- {area:1224} Bear's Head · {area:1219} Legashi Encampment
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	-- was: ["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south.\nCareful: the Mosshoof Coursers are 52-53, a level or two over you here: pull them one at a time from the herd's edge."] = "Ближайшие мохоногие олени пасутся в холмах к северо-востоку от места {area:1224}, в сторону места {area:1219}; стадо побольше бродит по открытой местности на юге.\nОсторожно: мохоногие олени – 52-53 уровня, на уровень-два выше вас: выманивайте их по одному с края стада."
	["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south.\nCareful: the Mosshoof Coursers are 52-53: pull them one at a time from the herd's edge."] = "",

	-- Step 71: Kim'jael
	-- {npc:8420} Kim'jael · {area:1219} Legashi Encampment · {area:1220} Thalassian Base Camp · {npc:6647} Magister Hawkhelm · {npc:235903} Ekkal
	-- plural, as words: Blood Elf Surveyors = {npc:6198} Blood Elf Surveyor · Legashi Soulstealers = {npc:236867} Legashi Soulstealer
	["{npc:8420} camps at the {area:1219} in the north; his equipment lies all over the {area:1220} just south-east of him.\nCareful: the Blood Elf Surveyors are 51-52 and the Reclaimers 52-53, with {npc:6647} (53) among them: take the equipment from the camp's edge and pull the elves one at a time.\n{npc:235903}'s satyrs, rogues and hellcallers (51-53) are the Legashi around {npc:8420}'s camp; the Legashi Soulstealers, Hellraisers and Blackguards (53) further east are not part of it: stay west of them."] = "{npc:8420} стоит лагерем здесь – {area:1219}, на севере; его снаряжение разбросано по всей территории ({area:1220}) чуть к юго-востоку от него.\nОсторожно: эльфы крови-геодезисты – 51-52 уровня, а мелиораторы – 52-53, среди них {npc:6647} (53): собирайте снаряжение с края лагеря и выманивайте эльфов по одному.\nСатиры, разбойники и призыватели (51-53), нужные NPC {npc:235903}, – это легаши вокруг лагеря NPC {npc:8420}; похитители душ, адские зачинщики и черные стражи Легаши (53) дальше на восток не нужны: держитесь западнее.",
	-- {item:20028} Glittering Dust
	["{item:20028}, from the blood elf surveyors and reclaimers"] = "",

	-- Step 74: Ekkal
	-- {npc:235903} Ekkal
	["On the road back south, {npc:235903} takes the satyrs."] = "На обратном пути на юг сдайте сатиров NPC {npc:235903}.",

	-- Step 75: Rubbing: Rune of Sael'hai
	-- {item:7972} Ichor of Undeath · {npc:7864} Lingering Highborne
	["{item:7972}: the {npc:7864}, about 10%"] = "{item:7972}: {npc:7864}, около 10%",

	-- Step 76: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo
	["Ride back west to {npc:8395}'s camp and get off your mount: he teleports you up to Xylem again."] = "",

	-- Step 78: The Temple of Zin-Malor
	-- {area:1223} Temple of Zin-Malor
	["The {area:1223}"] = "{area:1223}",
	-- {area:1223} Temple of Zin-Malor · {npc:8395} Sanath Lim-yo
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren
	["The Spitelash Sirens wander the ruins and the beach around the {area:1223}, just south of {npc:8395}. Only the Sirens carry the coral, not the Screamers."] = "",

	-- Step 79: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo
	["Back up through {npc:8395}'s teleport."] = "",
	-- {area:1417} Sunken Temple
	["Xylem's last task, Destroy Morphaz, is in the {area:1417}: skip it."] = "",

	-- Step 81: Ravencrest Monument
	-- {zone:1447} Azshara · {npc:8392} Pilot Xiggs Fuselighter · {item:10444} Standard Issue Flare Gun
	["Swim to the small island off the southern tip of {zone:1447}. If {npc:8392} isn't there, fire your {item:10444} to signal him, and wait for him to land."] = "Доплывите до островка у южной оконечности зоны {zone:1447}. Если NPC {npc:8392} там нет, подайте ему сигнал из предмета {item:10444} и дождитесь, пока он приземлится.",
	-- {zone:1455} Ironforge · {zone:1422} Western Plaguelands
	["Tymor in {zone:1455}, on the {zone:1422} guide's {zone:1455} stop: keep it"] = "",

	-- Step 82: Talrendis Point
	-- {area:3137} Talrendis Point · {zone:1448} Felwood
	["Back to Truesong at {area:3137}: {zone:1448}, the next guide, is a short ride west."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to Truesong at {area:3137} before you hearth."] = "Вернитесь к Верной Песне ({area:3137}), прежде чем использовать камень возвращения.",
	-- ["Back to {npc:3546} in {area:1438} before you hearth."] = "Вернитесь к NPC {npc:3546} ({area:1438}), прежде чем использовать камень возвращения.",
	-- ["Bloodmages' camp"] = "Лагерь магов крови",
	-- ["Class trainer"] = "Учитель класса",
	-- ["Climb back to {npc:8405} at the {area:1224}, above the ruins."] = "Поднимитесь назад к NPC {npc:8405} ({area:1224}) над руинами.",
	-- ["Climb to the top of {area:249} and plant the head in the soft dirt mound."] = "Поднимитесь на вершину скалы ({area:249}) и посадите голову в кучу мягкой земли.",
	-- ["Druid training"] = "Обучение друида",
	-- ["Fly from {zone:1455} to {area:150} and take the boat to {area:442}."] = "Летите из города {zone:1455} в {area:150} и сядьте на корабль до места {area:442}.",
	-- ["Fly from {zone:1455} to {area:69}."] = "Летите из города {zone:1455} в {area:69}.",
	-- ["Fly to {area:150} and take the boat to {area:442}, then the boat on to {area:702}."] = "Летите в {area:150} и сядьте на корабль до места {area:442}, затем на корабль дальше: {area:702}.",
	-- ["Fly to {area:702}"] = "Летите сюда: {area:702}",
	-- ["For {npc:5594} in {area:976}, on the {zone:1422} guide: keep it"] = "Для NPC {npc:5594} ({area:976}) из гайда по зоне {zone:1422}: сохраните задание",
	-- ["For {zone:1453}: keep it"] = "Для города {zone:1453}: сохраните задание",
	-- ["From the {area:442} dock, fly to {area:415}."] = "От причала ({area:442}) летите в {area:415}.",
	-- ["Help her escape the camp"] = "Помогите ей сбежать из лагеря",
	-- ["Level 51.3 on the way north"] = "Уровень 51.3 по пути на север",
	-- ["Level 52 at {area:249}"] = "Уровень 52 у места {area:249}",
	-- ["Open the {item:10569} from {zone:1427} for its {item:10575}, then tell {npc:9459} you bring proof of your deeds: no drake to fight."] = "Откройте {item:10569} из зоны {zone:1427}, чтобы достать {item:10575}, затем скажите NPC {npc:9459}, что принесли доказательство своих подвигов: сражаться с драконом не придется.",
	-- ["Optional: {npc:8395} wants two Undamaged Hippogryph Feathers from the hippogryphs around his camp. The data lists no experience for it."] = "Необязательно: {npc:8395} хочет два неповрежденных пера гиппогрифа с гиппогрифов вокруг его лагеря. По данным, опыта за это не дают.",
	-- ["Optional: {npc:8888}'s ghost stands on his tomb on the great chain inside {area:254}, and only the dead can see him. If you die near the mountain anyway, run your spirit to him before resurrecting."] = "Необязательно: призрак {npc:8888} стоит на своей гробнице на огромной цепи внутри горы ({area:254}), и видят его только мертвые. Если вы все равно погибнете у горы, доберитесь до него духом, прежде чем воскреснуть.",
	-- ["Portal to {zone:1438}"] = "Портал: {zone:1438}",
	-- ["Priests and Mages trained here at the end of the Un'Goro guide"] = "Жрецы и маги уже обучились здесь в конце гайда по Ун'Горо",
	-- ["Read the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript."] = "Прочитайте табличку в лагере ({object:147516}) среди руин к юго-западу от места {area:251}, чтобы скопировать текст.",
	-- ["Ride back south into the {zone:1419} for the bloodmages' beasts: Starving Snickerfangs roam the dry hills south of the bloodmages' camp, Scorpok Stingers scuttle across the middle of the north and {npc:5982} vultures circle over all of it. Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep.\nCareful: two elites roam here: {npc:221740} (50) in the middle of the zone around 44,34, and {npc:247015} (55) on the ridge around 39,32. When you see one, hunt somewhere else."] = "Езжайте назад на юг в зону {zone:1419} за зверями для магов крови: голодные хохотуны бродят по сухим холмам к югу от лагеря магов крови, скорпоки-острожалы снуют посередине северной части, а черные душегубы ({npc:5982}) кружат над всем этим. Пеплогривые кабаны и краснокаменные василиски обитают на склонах к юго-западу от крепости.\nОсторожно: здесь бродят два элитных противника: {npc:221740} (50) посреди зоны около 44,34 и {npc:247015} (55) на гребне около 39,32. Увидев одного из них, охотьтесь в другом месте.",
	-- ["Ride back to {area:1438} and fly to {area:348}. The Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "Езжайте назад в {area:1438} и летите в {area:348}. Перья диких совухов лежат на земле по всей зоне {zone:1425}, к югу и востоку от места {area:348}, где бродят совухи; здешние существа теперь намного ниже вас уровнем.",
	-- ["Ride east along the road out of {zone:1440} into {zone:1447} to the Sentinels' camp at {area:3137}."] = "Езжайте по дороге на восток из зоны {zone:1440} в зону {zone:1447} к лагерю часовых: {area:3137}.",
	-- ["Ride north out of the {zone:1419} into the {zone:1435}: the {npc:10996} stands by the road from the {zone:1419}. Keep clear of {area:75}, the Horde town to the north-east. Listen to his tale, then ride back south to Kum'isha."] = "Езжайте на север из зоны {zone:1419} в зону {zone:1435}: {npc:10996} стоит у дороги, ведущей из зоны {zone:1419}. Держитесь подальше от места {area:75} – это город Орды на северо-востоке. Выслушайте его рассказ, затем езжайте назад на юг к Кум'ише.",
	-- ["Ride north out of {area:69} through the pass into the {zone:1428}; {area:2418} sits at the top, in the south-east of the Steppes."] = "Езжайте на север из поселка {area:69} через перевал в зону {zone:1428}; {area:2418} – наверху, на юго-востоке степей.",
	-- ["Ride north to the bloodmages' camp beside the road into the {zone:1419}."] = "Езжайте на север к лагерю магов крови у дороги в зону {zone:1419}.",
	-- ["Swim to the small island off the southern tip of {area:16}: {npc:8392} waits by the monument."] = "Доплывите до островка у южной оконечности зоны {area:16}: {npc:8392} ждет у памятника.",
	-- ["Swim to the small island off the southern tip of {zone:1447}: {npc:8392} waits by the monument."] = "Доплывите до островка у южной оконечности зоны {zone:1447}: {npc:8392} ждет у памятника.",
	-- ["Thaurissan Relics"] = "Мощи Тауриссана",
	-- ["The Firegut ogres hold the great rock north of the Vigil, with the Brutes on its east side.\nCareful: Escaped Core Hounds (level 60) roam the Steppes, a few on the slopes west and south of {area:249}: pull the ogres on the rock itself and look around before each pull."] = "Огры из клана Огненного Чрева занимают большую скалу к северу от Дозора, громилы – на ее восточной стороне.\nОсторожно: по Степям бродят сбежавшие гончие Недр (60-й уровень), несколько – на склонах к западу и югу от места {area:249}: выманивайте огров на самой скале и осматривайтесь перед каждым нападением.",
	-- ["The Highborne ghosts haunt the ruins around the shrine; the Haldarr satyrs hold the camp just north of it."] = "Призраки высокорожденных бродят по руинам вокруг святилища; сатиры из племени Халдарр занимают лагерь сразу к северу от него.",
	-- ["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s four runes stand among the ruins: use his {item:10445} on each."] = "Наги из клана Бича Злобы ({area:1221}) носят предмет {item:13815}. Четыре руны, которые нужны NPC {npc:8507}, стоят среди руин: используйте на каждой его {item:10445}.",
	-- ["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s runes stand among the ruins: use his {item:10445} on each. The naga here are the ones the top-up below asks for, so these kills count towards it."] = "Наги из клана Бича Злобы ({area:1221}) носят предмет {item:13815}. Руны, которые нужны NPC {npc:8507}, стоят среди руин: используйте на каждой его {item:10445}. Здешние наги – те самые, которых требует добор опыта ниже, так что эти убийства засчитываются.",
	-- ["The Spitelash naga of these ruins drop Truesong's Eldarath Relics, top-up or not. {npc:239939} (52) stands in the ruins of Eldarath, south-west of the Myrmidons: pull him alone."] = "Наги из клана Бича Злобы в этих руинах роняют эльдаратские реликвии для Верной Песни, добираете вы опыт или нет. {npc:239939} (52) стоит в руинах Эльдарата, к юго-западу от мирмидонов: выманивайте его в одиночку.",
	-- ["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south."] = "Ближайшие мохоногие олени пасутся в холмах к северо-востоку от места {area:1224}, в сторону места {area:1219}; стадо побольше бродит по открытой местности на юге.",
	-- ["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south.\nCareful: the Mosshoof Coursers are 52-53, a level or two over you here: pull them one at a time from the herd's edge."] = "Ближайшие мохоногие олени пасутся в холмах к северо-востоку от места {area:1224}, в сторону места {area:1219}; стадо побольше бродит по открытой местности на юге.\nОсторожно: мохоногие олени – 52-53 уровня, на уровень-два выше вас: выманивайте их по одному с края стада.",
	-- ["The portal in {area:702} leads up to {zone:1457}: {npc:9047} waits in the {area:1658}, in the north of the city."] = "Портал в деревне {area:702} ведет наверх, в город {zone:1457}: {npc:9047} ждет в анклаве ({area:1658}) на севере города.",
	-- ["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered."] = "Мощи – это резные камни, разбросанные по руинам ({area:250}) вокруг места {area:251}: щелкайте по ним, пока не восстановите сведения.",
	-- ["The shrine lies in the south-west corner of {area:16}, south of {area:3137}."] = "Святилище лежит в юго-западном углу зоны {area:16}, к югу от заставы ({area:3137}).",
	-- ["The wildkin are in {zone:1452}: keep it"] = "Дикие совухи – в зоне {zone:1452}: сохраните",
	-- ["The {quest:4296}"] = "{quest:4296}",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:7977} (level 48 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back.\n{npc:7977} walks the {zone:1425} shore below the {area:307}, from the arrow south to about 75,66 and north to about 82,52: if she isn't at the arrow, follow the shore."] = "Это элитные противники: лучше собрать группу, поищите, с кем пойти. {npc:7977} (элитный, 48-й уровень) требует группы из 2 человек. Если вы один, пропустите это: маршрут возместит опыт за счет охоты на монстров.\n{npc:7977} ходит по берегу зоны {zone:1425} под утесами ({area:307}), от стрелки на юг примерно до 75,66 и на север примерно до 82,52: если ее нет у стрелки, идите вдоль берега.",
	-- ["Top up first to level 52 on the Firegut Ogres (50-51) on the near side of {area:249}, north of the Vigil: the Brutes on its east side are 52-53. Or, with a group, run the {area:1417} dungeon instead."] = "Сначала доберите опыт до уровня 52 на ограх из клана Огненного Чрева (50-51) на ближней стороне места {area:249}, к северу от Дозора: громилы на восточной стороне – 52-53 уровня. Или, с группой, пройдите вместо этого подземелье {area:1417}.",
	-- ["Top up to level 51.3 on the Spitelash Myrmidons (50-51) of the ruins between {npc:8395}'s camp and the north: the blood elves at {npc:8420}'s camp are 51-53. Or, with a group, run the {area:1417} dungeon instead."] = "Доберите опыт до уровня 51.3 на мирмидонах из клана Бича Злобы (50-51) в руинах между лагерем NPC {npc:8395} и севером: эльфы крови в лагере NPC {npc:8420} – 51-53 уровня. Или, с группой, пройдите вместо этого подземелье {area:1417}.",
	-- ["Upstairs"] = "Наверху",
	-- ["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves."] = "Используйте {item:12284} на противнике {npc:7047} на склонах к востоку от места {area:251} незадолго до его смерти, затем заберите оставшуюся эссенцию.",
	-- ["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves.\nCareful: a {npc:8981} (level 56, rare) walks the slopes by the broodlings, and the {npc:7040} and Wyrmkin around them are elite: use the Incarcinatrix on a broodling at the edge and look around before each pull."] = "Используйте {item:12284} на существе {npc:7047} на склонах к востоку от места {area:251} прямо перед его смертью, затем заберите оставшуюся эссенцию.\nОсторожно: {npc:8981} (56-й уровень, редкий) ходит по склонам у детенышей, а {npc:7040} и драконы вокруг них – элитные: используйте инкарцинатор на детеныше с краю и осматривайтесь перед каждым нападением.",
	-- ["Wildkin feathers"] = "Перья диких совухов",
	-- ["Your Hearthstone is set at {zone:1455} (the {zone:1425} guide binds it there): hearth back to the inn."] = "Ваш камень возвращения привязан к городу {zone:1455} (его привязывает там гайд по зоне {zone:1425}): вернитесь в таверну.",
	-- ["grind on {npc:6196}"] = "убивайте: {npc:6196}",
	-- ["grind on {npc:7033}"] = "охота: {npc:7033}",
	-- ["grind on {npc:9690}"] = "убивайте: {npc:9690}",
	-- ["keep it: the {area:199} cauldron waits for the {zone:1452} guide's Chillwind stop, at about 55"] = "сохраните: котел ({area:199}) ждет остановки в лагере Промозглого Ветра в гайде по зоне {zone:1452}, примерно на 55",
	-- ["{area:199} cauldron"] = "Котел: {area:199}",
	-- ["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "Призрак {npc:10778} бродит у дома ({area:199}) к западу от места {area:200}; ее посылка лежит внутри.",
	-- ["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075} охраняет котел ({area:199}) к западу от Андорала.",
	-- ["{npc:239822}: {quest:88809}, the relics drop from the naga of the top-up ahead"] = "{npc:239822}: {quest:88809} – реликвии падают с наг при доборе опыта далее",
	-- ["{npc:239822}: {quest:92345}, for {npc:4217} in {zone:1457}, keep it"] = "{npc:239822}: «{quest:92345}» для NPC {npc:4217} ({zone:1457}), сохраните",
	-- ["{npc:4217} is upstairs in the druids' building of the {area:1658}: go in by its south door."] = "{npc:4217} – наверху в здании друидов в анклаве ({area:1658}): входите через южную дверь.",
	-- ["{npc:4217}, upstairs"] = "{npc:4217}, наверху",
	-- ["{npc:5111}: the last guide binds here, so this usually ticks at once"] = "{npc:5111}: предыдущий гайд привязывает вас здесь, так что это обычно отмечается сразу",
	-- ["{npc:7363} waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have."] = "{npc:7363} ждет на холме к юго-западу от крепости ({area:2517}). С существ зоны {zone:1419} по пути падают несовершенные фрагменты дренетиста; принесите ей, сколько есть.",
	-- ["{npc:7740} stands beside Tyrande in the Temple of the Moon, in the south of the city."] = "{npc:7740} стоит рядом с Тирандой в Храме Луны, на юге города.",
	-- ["{npc:7740}: {quest:162}, from {area:976}"] = "{npc:7740}: {quest:162}, из места {area:976}",
	-- ["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "{npc:7907} стоит наверху, над NPC {npc:7916}: поднимитесь внутри здания, стрелка не различает этажи.",
	-- ["{npc:8395} wants two Undamaged Hippogryph Feathers from the Thunderhead hippogryphs around his camp, the ones you top up on here: about one in three carries one."] = "{npc:8395} хочет два неповрежденных пера гиппогрифа с громоглавых гиппогрифов вокруг его лагеря – тех, на которых вы здесь добираете опыт: перо есть примерно у каждого третьего.",
	-- ["{npc:8420} camps at the {area:1219} in the north; his equipment lies all over the {area:1220} just south-east of him."] = "{npc:8420} стоит лагерем на севере ({area:1219}); его снаряжение разбросано по всему месту {area:1220} сразу к юго-востоку от него.",
	-- ["{npc:9047}, in the {area:1658}"] = "{npc:9047}, в анклаве ({area:1658})",
	-- ["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty.\nCareful: {npc:9176} has a guard linked to him that joins the fight, and a second soldier patrols close by; clear the patrol before pulling.\nCareful: Firesworn, level 60 fire elementals, wander the Steppes, some between the Blackrock camps: look before each pull and let them pass."] = "{npc:9176} и орки из клана Черной Горы занимают лагеря и крепость у подножия горы ({area:254}), к западу от места {area:251}. Выманивайте их по одному; медальон может выпасть с любого орка и ворга, так что убивайте, пока не наберете пятьдесят.\nОсторожно: с NPC {npc:9176} связан страж, который вступит в бой, а рядом патрулирует второй солдат; перебейте патруль, прежде чем нападать.\nОсторожно: по Пылающим степям бродят Огнеклятые, элементали огня 60-го уровня, иногда между лагерями Черной Горы: осматривайтесь перед каждым нападением и пропускайте их.",
	-- ["{npc:9177}: the Blackrock orcs drop the medallions, keep it open all through the Steppes"] = "{npc:9177}: медальоны падают с орков из клана Черной Горы, держите задание открытым всё время в Пылающих степях",
	-- ["{object:175894}, inside"] = "{object:175894}, внутри",
	-- ["{zone:1455} has no druid trainer"] = "В городе {zone:1455} нет учителя друидов",
	-- ["{zone:1455} has no druid trainer: take the portal up to {zone:1457} and train in the {area:1658}, then come back down to {area:702}."] = "В городе {zone:1455} нет учителя друидов: поднимитесь порталом в город {zone:1457}, обучитесь в анклаве ({area:1658}) и спуститесь назад: {area:702}.",
}
