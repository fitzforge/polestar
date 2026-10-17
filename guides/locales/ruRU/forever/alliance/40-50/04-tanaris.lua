-- Russian (ruRU): the guide forever/alliance/40-50/04-tanaris (forever/alliance/40-50/04-tanaris.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Mirage Raceway
	-- {area:1108} Forgotten Coast · {area:489} Thalanaar · {zone:1441} Thousand Needles · {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {npc:4454} Fizzle Brassbolts · {npc:4630} Pozzik · {npc:4709} Zamek
	["From the {area:1108} dock, boat to Feathermoon and fly to {area:489}, then ride east through {zone:1441} to the {area:2240} on the {area:439}. {npc:4454} and {npc:4630} are in the camps beside the track; {npc:4709} stands by the goblin camp."] = "От причала ({area:1108}) плывите на корабле в Крепость Оперенной Луны и летите в {area:489}, затем езжайте на восток через {zone:1441} к месту {area:2240} ({area:439}). {npc:4454} и {npc:4630} — в лагерях у трассы; {npc:4709} стоит у лагеря гоблинов.",
	["He runs off to keep Rizzle busy"] = "Он убегает отвлечь Риззла",

	-- Step 2: Rizzle's plans
	["Rizzle's plans"] = "Чертежи Риззла",
	-- {npc:4709} Zamek
	["While {npc:4709} keeps Rizzle talking, his plans lie unguarded in the gnome camp across the track."] = "Пока {npc:4709} заговаривает Риззлу зубы, его чертежи лежат без охраны в лагере гномов по ту сторону трассы.",

	-- Step 4: Gadgetzan
	-- {area:439} Shimmering Flats · {zone:1446} Tanaris · {area:976} Gadgetzan
	["Ride south-east off the {area:439} into {zone:1446}. {area:976} is just inside the border."] = "Езжайте на юго-восток из места {area:439} в {zone:1446}. {area:976} — сразу за границей.",
	-- {quest:2864} Tran'rek
	["{quest:2864}, north side of town"] = "{quest:2864}, северная часть городка",
	-- {npc:7407} Chief Engineer Bilgewhizzle
	["{npc:7407}, by the water tower"] = "{npc:7407}, у водонапорной башни",
	-- {npc:7408} Spigot Operator Luglunket
	["{npc:7408}, next to him"] = "{npc:7408}, рядом с ним",

	-- Step 5: Steamwheedle Port
	["Ride east across the dunes to the goblin harbour on the north-east coast."] = "Езжайте на восток через дюны к гоблинской гавани на северо-восточном побережье.",
	-- {npc:7881} Stoley
	["{npc:7881}, in the port's tavern"] = "{npc:7881}, в таверне порта",
	["The Wanted poster beside him"] = "Плакат «Розыск!» рядом с ним",
	-- {npc:7847} Caliph Scorpidsting · {area:976} Gadgetzan
	["The same poster: {npc:7847} comes much later, after {area:976}"] = "То же объявление: {npc:7847} будет гораздо позже, после места {area:976}",

	-- Step 6: Lost Rigger Cove
	-- {npc:7883} Andre Firebeard · {npc:7881} Stoley
	["Follow the coast south to the pirate cove. Southsea pirates crowd the beach and the boats: work along the edge and pull one at a time. {npc:7883} stands on the far side; {npc:7881}'s stolen cargo lies in the camp."] = "Идите вдоль побережья на юг к пиратской бухте. Пираты Южных морей заполонили пляж и корабли: двигайтесь по краю и выманивайте по одному. {npc:7883} стоит на дальней стороне; украденный груз ({npc:7881}) лежит в лагере.",

	-- Step 7: Steamwheedle Port
	-- {npc:7881} Stoley · {area:35} Booty Bay
	["{npc:7881}'s next delivery goes back to {area:35}: skip it."] = "Следующая доставка ({npc:7881}) ведет обратно в {area:35}: пропустите ее.",

	-- Step 8: Wastewander bandits
	["Wastewander bandits"] = "Бандиты из шайки Скитальцев Пустыни",
	-- {area:976} Gadgetzan
	["Ride back west toward {area:976}. The Wastewander bandits and thieves hold the dunes on the way; any of them can carry a water pouch."] = "Езжайте обратно на запад к месту {area:976}. По пути дюны занимают бандиты и воры из шайки Скитальцев Пустыни; у любого из них может быть бурдюк с водой.",

	-- Step 10: Waterspring Field
	-- {area:976} Gadgetzan · {npc:7847} Caliph Scorpidsting
	["The tougher Wastewander rogues, shadow mages and assassins camp south-east of {area:976}, south of the bandits. Leave {npc:7847} in the middle of the southern camp for later."] = "Более сильные разбойники, темные маги и убийцы из шайки Скитальцев Пустыни стоят лагерем к юго-востоку от места {area:976}, южнее бандитов. {npc:7847} в центре южного лагеря оставьте на потом.",

	-- Step 11: Gadgetzan
	-- {npc:7763} Curgle Cranklehop · {area:702} Rut'theran Village
	["{npc:7763}: his crate goes to {area:702}, later"] = "{npc:7763}: его ящик едет в {area:702}, позже",

	-- Step 12: The pool by Sandsorrow Watch
	-- {area:979} Sandsorrow Watch
	["The pool by {area:979}"] = "Пруд у места {area:979}",
	-- {area:979} Sandsorrow Watch · {item:8584} Untapped Dowsing Widget
	["Ride north-west to the Sandfury troll camp at {area:979}. Use the {item:8584} at the edge of its pool; the trolls stand close, so pull the nearest first."] = "Езжайте на северо-запад к лагерю троллей из племени Песчаной Бури: {area:979}. Используйте {item:8584} у края пруда; тролли стоят близко, так что выманивайте ближайших первыми.",
	-- {item:8585} Tapped Dowsing Widget
	["Gives the {item:8585}"] = "Дает: {item:8585}",
	-- {area:979} Sandsorrow Watch
	["Pool by {area:979}"] = "Пруд у места {area:979}",

	-- Step 14: The Broken Pillar
	-- {area:1938} Broken Pillar
	["The {area:1938}"] = "Место: {area:1938}",
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {quest:3161} Gahz'ridian
	["Ride south to the dig camp at the {area:1938}. {npc:7771} hands you a detector helm: wear it to see the {quest:3161} mounds, which lie thick in the sand around the camp and south-west toward the ogres."] = "Езжайте на юг к лагерю раскопок: {area:1938}. {npc:7771} дает вам шлем-детектор: наденьте его, чтобы видеть холмики ({quest:3161}); их много в песке вокруг лагеря и к юго-западу, в сторону огров.",

	-- Step 15: Dunemaul Compound
	-- {npc:12046} Gor'marok the Ravager
	["Ride south-west to the ogre compound. Brutes and Enforcers (46-48) fill it; {npc:12046} (49) stands in the middle with guards around him: clear them first."] = "Езжайте на юго-запад к поселению огров. Там полно громил и головорезов (46-48); {npc:12046} (49) стоит в центре в окружении стражи: сначала разберитесь с ней.",

	-- Step 16: The Noxious Lair
	["Ride north-west to the Centipaar hive in the dunes. Any Centipaar can drop insect parts."] = "Езжайте на северо-запад к улью сентипааров в дюнах. С любого сентипаара могут выпасть части насекомых.",

	-- Step 17: Thistleshrub Valley
	-- {quest:3362} Thistleshrub Valley
	-- plural, as words: Gnarled Thistleshrubs = {npc:5490} Gnarled Thistleshrub
	["Ride south into {quest:3362}. The Dew Collectors drop the glands; only some are full, so keep the Laden one. Gnarled Thistleshrubs and Rootshapers share the valley. The Thistleshrubs are 48-50, above you: pull one at a time."] = "Езжайте на юг: {quest:3362}. Железы падают с терновых собирателей росы; полные не все, так что сохраните насыщенную. В долине также бугристые шипокожи и терновые корнеплеты. Шипокожи 48-50 уровня, выше вас: выманивайте по одному.",

	-- Step 18: Tooga's escort
	-- {npc:5955} Tooga
	["{npc:5955}'s escort"] = "Сопровождение: {npc:5955}",
	-- {npc:5955} Tooga · {npc:6015} Torta · {area:977} Steamwheedle Port
	["The little turtle {npc:5955} hides at the north end of the valley. Lead him home to his wife {npc:6015}, by the water just east of {area:977}: he walks slowly and the desert's beasts go for him, so keep him alive."] = "Маленький черепах {npc:5955} прячется в северной части долины. Отведите его домой к жене ({npc:6015}), у воды чуть восточнее места {area:977}: он идет медленно, и звери пустыни нападают на него, так что берегите его.",

	-- Step 19: Gadgetzan
	-- {area:976} Gadgetzan
	["Ride back west to {area:976}."] = "Езжайте обратно на запад в {area:976}.",
	-- {npc:11758} Andi Lynn
	["{npc:11758}, on the east side of town"] = "{npc:11758}, восточная часть городка",
	-- {npc:7583} Sprinkle · {zone:1425} Hinterlands
	["{npc:7583}'s next ingredient grows in the {zone:1425}, and the route never brings it back: skip it."] = "Следующий ингредиент ({npc:7583}) растет здесь: {zone:1425}, а маршрут никогда не приводит его обратно: пропустите.",

	-- Step 20: Caliph Scorpidsting
	-- {area:985} Waterspring Field · {npc:7847} Caliph Scorpidsting
	["Ride south-east to {area:985}. {npc:7847} stands in the middle of the southern Wastewander camp: clear around him first."] = "Езжайте на юго-восток в {area:985}. {npc:7847} стоит в центре южного лагеря Скитальцев Пустыни: сначала зачистите все вокруг него.",

	-- Step 21: The Gaping Chasm
	-- {area:1938} Broken Pillar · {area:981} The Gaping Chasm
	["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside."] = "Езжайте на юг мимо места {area:1938} к месту {area:981} – туннелям Хаззали; снаряжение Холстомера лежит глубоко внутри.",

	-- Step 22: Gadgetzan
	-- {area:976} Gadgetzan
	["Hearth to {area:976}."] = "Используйте Камень возвращения: {area:976}.",
	-- {zone:1457} Darnassus
	["for {zone:1457}: the route takes you there at 47"] = "Для зоны {zone:1457}: маршрут приведет вас туда на 47-м уровне",

	-- Step 23: Ironforge
	-- {area:976} Gadgetzan · {area:150} Menethil Harbor · {area:1537} Ironforge
	["Fly from {area:976} to Theramore, take the boat to {area:150} and fly to {area:1537}. Train."] = "Летите из места {area:976} в Терамор, плывите на корабле в {area:150} и летите в {area:1537}. Обучитесь.",

	-- Step 24: Aerie Peak
	-- {area:348} Aerie Peak · {zone:1425} Hinterlands
	["Fly to {area:348}. {zone:1425} guide starts here."] = "Летите в {area:348}. Здесь начинается гайд по зоне {zone:1425}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly to {area:348}. {zone:1425} guide starts here."] = "Летите в {area:348}. Здесь начинается гайд по зоне {zone:1425}.",
	-- ["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside."] = "Езжайте на юг мимо места {area:1938} к месту {area:981}, туннелям Хаззали; снаряжение Холстомера лежит глубоко внутри.",
	-- ["The Wanted poster by {npc:7882}"] = "Плакат «Розыск!» у NPC {npc:7882}",
}
