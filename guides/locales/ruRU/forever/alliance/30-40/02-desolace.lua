-- Russian (ruRU): the guide forever/alliance/30-40/02-desolace (forever/alliance/30-40/02-desolace.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Nijel's Point
	-- {area:460} Sun Rock Retreat · {area:465} Charred Vale · {zone:1443} Desolace · {area:608} Nijel's Point
	["Follow the road west past {area:460} (Horde) and south-west through the {area:465} into {zone:1443}; {area:608} stands at the top of the pass."] = "Идите по дороге на запад мимо места {area:460} (Орда) и на юго-запад через {area:465} в зону {zone:1443}; {area:608} – на вершине перевала.",
	-- {npc:5638} Kreldig Ungor · {npc:11863} Azore Aldamort · {area:599} Thunder Axe Fortress
	["{npc:5638}: the wreck's chest lies below {npc:11863}'s tower, on the way to {area:599}"] = "{npc:5638}: сундук с обломков корабля лежит под башней {npc:11863}, по пути к месту {area:599}",

	-- Step 2: Malem chest
	["Malem chest"] = "Сундук Малема",
	-- {area:608} Nijel's Point
	["The chest lies in the ruins south-west of {area:608}."] = "Сундук лежит в руинах к юго-западу (ориентир: {area:608}).",

	-- Step 3: Sargeron
	-- {area:603} Sargeron · {area:608} Nijel's Point
	-- plural, as words: Hatefury Rogues = {npc:4670} Hatefury Rogue · Hatefury Tricksters = {npc:4671} Hatefury Trickster
	["The Hatefury satyrs hold the ruins of {area:603}, east of {area:608}.\nCareful: Hatefury Rogues spawn stealthed, and Hatefury Tricksters have a poison proc on their attacks."] = "",

	-- Step 5: Nijel's Point
	-- {npc:5642} Vahlarriel Demonslayer · {area:599} Thunder Axe Fortress
	["{npc:5642}: the Burning Blade in {area:599}, where her search leads"] = "",
	-- {npc:5752} Corporal Melkins
	["{npc:5752}: the Kolkar are at the end of this guide"] = "{npc:5752}: колкары – в конце этого гайда",
	-- {npc:5396} Captain Pentigast · {npc:5752} Corporal Melkins
	["{npc:5396}, beside {npc:5752}"] = "{npc:5396} – рядом с NPC {npc:5752}",

	-- Step 6: Azore Aldamort
	-- {npc:11863} Azore Aldamort · {area:599} Thunder Axe Fortress
	["{npc:11863}'s tower stands on the hill west of {area:599}: take his quest first, the sceptre he wants is in the fortress."] = "Башня {npc:11863} стоит на холме к западу (ориентир: {area:599}): сначала возьмите его задание – нужный ему скипетр находится в крепости.",

	-- Step 7: Karnitol's Chest
	-- {npc:11863} Azore Aldamort · {object:177787} Rackmore's Log
	["The wrecked ship lies just south-west of {npc:11863}'s tower; its chest sits beside {object:177787}."] = "Разбитый корабль лежит чуть к юго-западу от башни {npc:11863}; его сундук стоит рядом с объектом {object:177787}.",
	-- {npc:5638} Kreldig Ungor
	["For {npc:5638}, at the end of this guide"] = "Для NPC {npc:5638}, в конце этого гайда",
	-- {object:177787} Rackmore's Log
	["{object:177787}, beside the chest: its two keys drop only while you have the quest"] = "",

	-- Step 8: Rackmore's Silver Key
	-- {item:15878} Rackmore's Silver Key
	-- plural, as words: Drysnap Crawlers = {npc:11562} Drysnap Crawler
	["West to the shore: the Drysnap Crawlers and Pincers (33-35) on the beach and the clam beds around the wreck carry {item:15878}, about one in seven."] = "",
	-- {item:15878} Rackmore's Silver Key
	["{item:15878}, from the Drysnap crabs"] = "{item:15878} – с сухощелких крабов",

	-- Step 9: Sar'theris Strand
	-- {area:598} Sar'theris Strand · {item:15881} Rackmore's Golden Key
	["Keep north to {area:598} for {item:15881}: any Slitherblade can drop it. Work the Naga, Sorceresses and Warriors (32-34) of the strand's southern half until it drops.\nCareful: the Myrmidons (34-35) hold the beach's northern half with the Sea Witches and Oracles (34-36, casters), and Tidehunters (36-37) swim off the northern tip: on the way to the chest, keep to the beach and swim straight across."] = "",
	-- {item:15881} Rackmore's Golden Key
	["{item:15881}, from the Slitherblade naga"] = "",

	-- Step 10: Rackmore's Chest
	-- {area:2406} Ranazjar Isle · {object:177786} Rackmore's Chest · {object:177673} Serpent Statue
	["Swim out to {area:2406} off the far northern tip: {object:177786} stands on the shore beside the {object:177673}. Open it with both keys; leave the statue alone."] = "Плывите к острову ({area:2406}) у северной оконечности: {object:177786} стоит на берегу рядом с объектом {object:177673}. Откройте его обоими ключами; статую не трогайте.",

	-- Step 11: Dalinda Malem
	-- {npc:11863} Azore Aldamort · {npc:5644} Dalinda Malem
	["Back south-east past {npc:11863}'s tower to the Burning Blade's fortress: {npc:5644} hides inside it."] = "",
	["Inside"] = "Внутри",

	-- Step 12: Tyranis Malem and the Seer
	-- {npc:5643} Tyranis Malem
	["{npc:5643} and the Seer"] = "{npc:5643} и Провидец",
	-- {npc:5643} Tyranis Malem · {npc:13019} Burning Blade Seer · {npc:5642} Vahlarriel Demonslayer
	["Her brother {npc:5643} (36) walks the fortress with the Burning Blade cultists (30-33): pull him alone. The {npc:13019} keeps the sceptre in the fortress's main building. {npc:5642} wants four of each kind of cultist on the way."] = "Ее брат {npc:5643} (36) ходит по крепости с культистами (Пылающий Клинок, 30-33): выманите его одного. {npc:13019} хранит скипетр в главном здании крепости. По пути {npc:5642} просит по четыре культиста каждого вида.",
	-- {item:6767} Tyranis' Pendant
	["{item:6767}; inside"] = "",
	-- {quest:5741} Sceptre of Light
	["{quest:5741}; on the top floor"] = "",

	-- Step 13: Escort Dalinda Malem
	-- {npc:5644} Dalinda Malem
	["Escort {npc:5644}"] = "Сопроводите {npc:5644}",
	-- {npc:5644} Dalinda Malem
	["{npc:5644}, inside"] = "{npc:5644}, внутри",
	["Out of Thunder Axe Fortress"] = "Выход из крепости Громового Топора",
	-- {npc:5644} Dalinda Malem · {npc:5642} Vahlarriel Demonslayer · {area:608} Nijel's Point
	["Lead {npc:5644} out of the fortress; she walks off once you are clear of it. {npc:5642} takes the turn-in at {area:608} at the end of the guide."] = "Выведите {npc:5644} из крепости; когда вы выберетесь, она уйдет сама. Задание принимает {npc:5642} ({area:608}) в конце гайда.",

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
	["{npc:11596}'s camp is on the road south of {area:609}, by the {area:596}."] = "Лагерь {npc:11596} – на дороге к югу (ориентир: {area:609}), у места {area:596}.",

	-- Step 17: Kodo Bones
	-- {area:596} Kodo Graveyard · {npc:11438} Bibbly F'utzbuckle · {object:176751} Kodo Bones · {object:417353} Extinguished Campfire (no name in this language: may be words) · {quest:79229} Highway Robbery
	["West into the {area:596} first: {npc:11438}'s {object:176751} lie among the skeletons on its western side. Just north of them an {object:417353} starts {quest:79229}, also for {npc:11438}."] = "",
	-- {item:13703} Kodo Bone
	["{item:13703}, among the skeletons"] = "",
	-- {quest:79229} Highway Robbery · {object:417353} Extinguished Campfire (no name in this language: may be words)
	["{quest:79229}: the {object:417353}"] = "",

	-- Step 18: Kodo Graveyard
	-- {npc:11596} Smeed Scrabblescrew · {item:13892} Kodo Kombobulator · {npc:4702} Ancient Kodo
	-- plural, as words: Ancient Kodos = {npc:4702} Ancient Kodo
	["Use {npc:11596}'s {item:13892} on an Aged, Dying or {npc:4702}: it becomes a tamed kodo that follows you. Walk it back to {npc:11596}'s camp; there, talk to the kodo: that counts it and lets you tame the next. Five kodos, one at a time. Careful: the Ancient Kodos (36-37) hit hard: tame them, don't fight them."] = "Используйте {item:13892} от NPC {npc:11596} на старом, умирающем или древнем кодо ({npc:4702}): он станет прирученным кодо и пойдет за вами. Отведите его в лагерь NPC {npc:11596}; там поговорите с кодо: это засчитает его и позволит приручить следующего. Пять кодо, по одному. Осторожно: древние кодо (36-37) бьют сильно: приручайте их, не сражайтесь с ними.",
	-- {npc:4702} Ancient Kodo
	["on an Aged, Dying or {npc:4702} in the graveyard; don't kill it"] = "",
	-- {npc:11596} Smeed Scrabblescrew
	["the tamed kodo, at {npc:11596}'s camp: talk to it, five times"] = "",

	-- Step 19: Kodo Graveyard: hides and venom
	-- {area:596} Kodo Graveyard
	["{area:596}: hides and venom"] = "{area:596}: шкуры и яд",
	-- plural, as words: Aged Kodos = {npc:4700} Aged Kodo · Scorpashi Lashers = {npc:4697} Scorpashi Lasher · Ancient Kodos = {npc:4702} Ancient Kodo
	["The Aged Kodos in the graveyard drop the hides, and the Scorpashi Lashers that hunt around it carry the venom. Careful: the Ancient Kodos (36-37) hit hard: fight only the Aged Kodos."] = "Старые кодо ({npc:4700}) на кладбище роняют шкуры, а скорпаши-хлестуны ({npc:4697}) вокруг него носят яд. Осторожно: древние кодо ({npc:4702}, 36-37) бьют сильно: сражайтесь только со старыми кодо.",

	-- Step 21: Kolkar Village
	-- {npc:11596} Smeed Scrabblescrew · {area:609} Kolkar Village · {area:608} Nijel's Point · {npc:5752} Corporal Melkins · {quest:93224} Carved Centaur Totems · {npc:5396} Captain Pentigast
	-- plural, as words: Centaur Ears = {item:6067} Centaur Ear
	["North-east from {npc:11596}'s camp to {area:609}, on the way back to {area:608}: every Kolkar drops Centaur Ears for {npc:5752} and {quest:93224} for {npc:5396}. The Magram south-east of {npc:11596}'s camp drop them too, but their village holds Necromancers (42-43) and Guardians (39-41): stay with the Kolkar (30-35)."] = "",

	-- Step 22: Kormek's Hut
	-- {area:609} Kolkar Village · {area:608} Nijel's Point · {npc:11438} Bibbly F'utzbuckle · {area:2407} Kormek's Hut · {area:35} Booty Bay
	["North-west from {area:609} back along the road to {area:608}: {npc:11438} waits at {area:2407}. He sends you after the robber to {area:35}, where the next guide ends: keep it."] = "",
	-- {npc:11438} Bibbly F'utzbuckle · {area:35} Booty Bay
	["{npc:11438}: Tokal waits in {area:35}, at the end of the next guide"] = "",

	-- Step 23: Nijel's Point
	-- {npc:5638} Kreldig Ungor · {zone:1443} Desolace
	-- was: ["{npc:5638}: the satchel lies off the north-west coast, on the south loop at the end of 30-40 (06-badlands): keep it"] = "{npc:5638}: сумка лежит у северо-западного побережья, на южном круге в конце 30-40 (06-badlands): сохраните ее"
	["{npc:5638}: the satchel lies off the north-west coast, on {zone:1443}'s south loop at the end of 30-40: keep it"] = "",

	-- Step 24: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "Летите сюда: {area:442}",
	-- {area:608} Nijel's Point
	["{area:608} flight master"] = "Распорядитель полетов: {area:608}",

	-- Step 25: Boat to Stormwind Harbor
	-- {area:17203} Stormwind Harbor
	["Boat to {area:17203}"] = "Корабль: {area:17203}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Escort the caravan"] = "Сопроводите караван",
	-- ["From {area:415} head south-west to the {area:1276}, a tunnel through the mountains into Stonetalon."] = "От места {area:415} идите на юго-запад. Цель: {area:1276} – туннель сквозь горы в Когтистые горы.",
	-- ["From {area:415} ride north-west into the hills: the {quest:1738} is a glowing tree north of the road to {area:413}. If you took {quest:65602}, the {item:190309} lies in a house among the trees north of {area:413} (26.6,22.0). Then back past {area:415} to the {area:1276}."] = "От места {area:415} езжайте на северо-запад в холмы: {quest:1738} – это светящееся дерево к северу от дороги к месту {area:413}. Если вы взяли задание {quest:65602}, {item:190309} лежит в доме среди деревьев к северу (ориентир: {area:413}) (26.6,22.0). Затем назад мимо места {area:415}. Цель: {area:1276}.",
	-- ["From {zone:1455}'s {npc:1573}"] = "У NPC {npc:1573} ({zone:1455})",
	-- ["Scorpashi venom"] = "Яд скорпаши",
	-- ["Take the boat to {area:442} from Menethil's docks."] = "Сядьте на корабль в порту (Гавань Менетилов). Цель: {area:442}.",
	-- ["Take the boat to {area:442} from Menethil's docks. {npc:3649} stands in {area:442}, north of the flight master."] = "Сядьте на корабль в порту (Гавань Менетилов). Цель: {area:442}. {npc:3649} стоит там ({area:442}) к северу от распорядителя полетов.",
	-- ["The Gizelton Caravan waits at {area:2407}."] = "Караван Гизлтона ждет здесь: {area:2407}.",
	-- ["The Hatefury satyrs hold the ruins of {area:603}, east of {area:608}."] = "Сатиры из племени Ярой Ненависти занимают руины ({area:603}) к востоку (ориентир: {area:608}).",
	-- ["The Kolkar roam the plains around {area:609}; their ears are for {npc:5752}."] = "Кентавры из племени Колкар бродят по равнинам вокруг места {area:609}; их уши – для NPC {npc:5752}.",
	-- ["The Scorpashi scorpids hunt the hills around {area:2407} on the road south."] = "Скорпиды скорпаши охотятся на холмах вокруг места {area:2407} на дороге к югу.",
	-- ["The {area:1276}"] = "{area:1276}",
	-- ["Use {npc:11596}'s {item:13892} on an {npc:4700} and walk the tamed kodo back to his camp, five times; Aged Kodos also drop the hides, and the Scorpashi Lashers that hunt around the graveyard carry the venom."] = "Используйте {item:13892} {npc:11596} на цели {npc:4700} и приведите прирученного кодо к его лагерю – пять раз; шкуры падают и со старых кодо, а яд несут хлестохвосты скорпаши, охотящиеся вокруг кладбища.",
	-- ["Use {npc:11596}'s {item:13892} on an {npc:4700} and walk the tamed kodo back to his camp, five times; Aged Kodos also drop the hides."] = "Используйте {item:13892} {npc:11596} на цели {npc:4700} и приведите прирученного кодо к его лагерю – пять раз; шкуры падают и со старых кодо.",
	-- ["Walk with the caravan south past {area:609}; Kolkar ambushers jump it on the way. Stay close until it stops at {area:2617}. The ambushers are 34-35 and come in waves: skip it if you are below 33."] = "Идите с караваном на юг мимо места {area:609}; по пути на него нападают душители из племени Колкар. Держитесь рядом, пока он не остановится ({area:2617}). Душители 34-35-го уровня нападают волнами: если ваш уровень ниже 33, пропустите это задание.",
	-- ["{item:190309}, north of {area:413}"] = "{item:190309}, к северу (ориентир: {area:413})",
	-- ["{npc:3649}: {item:279915}, from Sylessa in Menethil"] = "{npc:3649}: {item:279915} от Силессы (Гавань Менетилов)",
	-- ["{npc:5638}: the satchel lies off the north-west coast, on the south loop at the end of 30-40 (06-badlands): keep it"] = "{npc:5638}: сумка лежит у северо-западного побережья, на южном круге в конце 30-40 (06-badlands): сохраните ее",
	-- ["{npc:5644} hides inside the Burning Blade's fortress south-west of {area:608}."] = "{npc:5644} прячется в крепости клана Пылающего Клинка к юго-западу (ориентир: {area:608}).",
	-- ["{object:177787}, beside the chest: keep it, its keys and chest come on {zone:1443}'s south loop at the end of 30-40"] = "{object:177787} рядом с сундуком: сохраните их – ключи и сундук будут на южном круге зоны {zone:1443} в конце 30-40",
}
