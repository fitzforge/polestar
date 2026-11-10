-- Russian (ruRU): the guide forever/alliance/40-50/04-tanaris (forever/alliance/40-50/04-tanaris.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Mirage Raceway
	-- {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {zone:1441} Thousand Needles · {npc:4454} Fizzle Brassbolts · {npc:4709} Zamek
	["The {area:2240} lies on the {area:439} in south-east {zone:1441}: {npc:4454} is in the gnomes' camp beside the track, {npc:4709} by the goblin camp."] = "",
	-- {npc:4454} Fizzle Brassbolts · {quest:1137} News for Fizzle · {zone:1418} Badlands
	["{npc:4454}: {quest:1137}, from Martek in the {zone:1418}"] = "",
	["He runs off to keep Rizzle busy"] = "Он убегает отвлечь Риззла",

	-- Step 4: Gadgetzan
	-- {area:439} Shimmering Flats · {zone:1446} Tanaris · {area:976} Gadgetzan
	["Ride south-east off the {area:439} into {zone:1446}. {area:976} is just inside the border."] = "Езжайте на юго-восток из места {area:439} в {zone:1446}. {area:976} — сразу за границей.",
	-- {quest:2864} Tran'rek
	["{quest:2864}, north side of town"] = "{quest:2864}, северная часть городка",
	-- {npc:7407} Chief Engineer Bilgewhizzle
	["{npc:7407}, by the water tower"] = "{npc:7407}, у водонапорной башни",
	-- {npc:7408} Spigot Operator Luglunket
	["{npc:7408}, next to him"] = "{npc:7408}, рядом с ним",
	-- {npc:7763} Curgle Cranklehop · {area:702} Rut'theran Village
	["{npc:7763}: his crate goes to {area:702}, later"] = "{npc:7763}: его ящик едет в {area:702}, позже",

	-- Step 5: Steamwheedle Port
	["Ride east across the dunes to the goblin harbour on the north-east coast."] = "Езжайте на восток через дюны к гоблинской гавани на северо-восточном побережье.",
	["The Wanted poster beside him"] = "Плакат «Розыск!» рядом с ним",
	-- {npc:7847} Caliph Scorpidsting · {area:976} Gadgetzan
	["The same poster: {npc:7847} comes much later, after {area:976}"] = "То же объявление: {npc:7847} будет гораздо позже, после места {area:976}",
	-- {npc:7882} Security Chief Bilgewhizzle
	["{npc:7882}, inside"] = "",
	-- {npc:7881} Stoley
	["{npc:7881}, in the port's tavern; inside"] = "",

	-- Step 6: Noonshade Ruins: kill these as you meet them
	-- {area:1937} Noonshade Ruins
	["{area:1937}: kill these as you meet them"] = "",
	-- {area:976} Gadgetzan
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["Ride back west toward {area:976}. The Wastewander bandits and thieves hold the dunes on the way; any of them can carry a water pouch.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "",

	-- Step 8: Waterspring Field
	-- {area:976} Gadgetzan · {npc:7847} Caliph Scorpidsting
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["The tougher Wastewander rogues, shadow mages and assassins camp south-east of {area:976}, south of the bandits. Leave {npc:7847} in the middle of the southern camp for later.\nCareful: Wastewander Rogues keep Sneak up while out of combat, so hidden rogues can join a fight you start at a camp."] = "",

	-- Step 9: Lost Rigger Cove: kill these as you meet them
	-- {area:1336} Lost Rigger Cove
	["{area:1336}: kill these as you meet them"] = "",
	-- {npc:7883} Andre Firebeard · {npc:7881} Stoley
	["Follow the coast south to the pirate cove. Southsea pirates crowd the beach and the boats: work along the edge and pull one at a time. {npc:7883} stands on the far side; {npc:7881}'s stolen cargo lies in the camp.\nCareful: Two or three pirates stand with {npc:7883}, and many more pirates from the town join the fight once it starts."] = "",
	-- {quest:2873} Stoley's Shipment
	["{quest:2873}; upstairs"] = "",

	-- Step 10: Steamwheedle Port
	-- {npc:7881} Stoley
	["{npc:7881}, inside"] = "",
	-- {area:35} Booty Bay · {zone:1425} Hinterlands
	["\"Sea Wolf\" MacKinley in {area:35}: the route takes you there at the end of the {zone:1425} guide, keep it"] = "",

	-- Step 11: Noonshade Ruins
	["Careful: Thieves cast Disarm. Rogues stay hidden with Sneak. Assassins use Execute when your health is at 20% or lower."] = "",

	-- Step 13: The pool by Sandsorrow Watch
	-- {area:979} Sandsorrow Watch
	["The pool by {area:979}"] = "Пруд у места {area:979}",
	-- {area:979} Sandsorrow Watch · {item:8584} Untapped Dowsing Widget
	["Ride north-west to the Sandfury troll camp at {area:979}. Use the {item:8584} at the edge of its pool; the trolls stand close, so pull the nearest first."] = "Езжайте на северо-запад к лагерю троллей из племени Песчаной Бури: {area:979}. Используйте {item:8584} у края пруда; тролли стоят близко, так что выманивайте ближайших первыми.",
	-- {item:8585} Tapped Dowsing Widget
	["Gives the {item:8585}"] = "Дает: {item:8585}",
	-- {area:979} Sandsorrow Watch
	["Pool by {area:979}"] = "Пруд у места {area:979}",

	-- Step 15: The Broken Pillar
	-- {area:1938} Broken Pillar
	["The {area:1938}"] = "Место: {area:1938}",
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {quest:3161} Gahz'ridian
	["Ride south to the dig camp at the {area:1938}. {npc:7771} hands you a detector helm: wear it to see the {quest:3161} mounds, which lie thick in the sand around the camp and south-west toward the ogres."] = "Езжайте на юг к лагерю раскопок: {area:1938}. {npc:7771} дает вам шлем-детектор: наденьте его, чтобы видеть холмики ({quest:3161}); их много в песке вокруг лагеря и к юго-западу, в сторону огров.",

	-- Step 17: The Noxious Lair
	-- {npc:4196} Silithid Swarm
	-- plural, as words: Centipaar Swarmers = {npc:5457} Centipaar Swarmer
	["Ride north-west to the Centipaar hive in the dunes. Any Centipaar can drop insect parts.\nCareful: Centipaar Swarmers cast {npc:4196} both in and out of combat, which brings small adds that interrupt you."] = "",

	-- Step 18: Dunemaul Compound
	-- {npc:12046} Gor'marok the Ravager
	["Ride south-west to the ogre compound. Brutes and Enforcers (46-48) fill it; {npc:12046} (49) stands in the middle with guards around him: clear them first."] = "Езжайте на юго-запад к поселению огров. Там полно громил и головорезов (46-48); {npc:12046} (49) стоит в центре в окружении стражи: сначала разберитесь с ней.",
	-- {npc:12046} Gor'marok the Ravager
	["{npc:12046}, below ground"] = "",
	-- {npc:5474} Dunemaul Brute
	["grind on {npc:5474}"] = "",

	-- Step 19: Thistleshrub Valley: kill these as you meet them
	-- {quest:3362} Thistleshrub Valley
	["{quest:3362}: kill these as you meet them"] = "",
	-- {quest:3362} Thistleshrub Valley
	-- plural, as words: Gnarled Thistleshrubs = {npc:5490} Gnarled Thistleshrub
	["Ride south into {quest:3362}. The Dew Collectors drop the glands; only some are full, so keep the Laden one. Gnarled Thistleshrubs and Rootshapers share the valley. The Thistleshrubs are 48-50, above you: pull one at a time.\nCareful: The other thistleshrub mobs in the area are level 49-50 and wander a lot, so you can easily pull extra mobs."] = "",

	-- Step 20: Tooga's escort
	-- {npc:5955} Tooga
	["{npc:5955}'s escort"] = "Сопровождение: {npc:5955}",
	-- {npc:5955} Tooga · {npc:6015} Torta · {area:977} Steamwheedle Port
	["The little turtle {npc:5955} hides at the north end of the valley. Lead him home to his wife {npc:6015}, by the water just east of {area:977}: he walks slowly and the desert's beasts go for him, so keep him alive."] = "Маленький черепах {npc:5955} прячется в северной части долины. Отведите его домой к жене ({npc:6015}), у воды чуть восточнее места {area:977}: он идет медленно, и звери пустыни нападают на него, так что берегите его.",

	-- Step 21: Gadgetzan
	-- {area:976} Gadgetzan · {npc:11758} Andi Lynn
	["Ride back west to {area:976}: {npc:11758} stands on the east side of town, where you come in."] = "",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "",

	-- Step 22: Caliph Scorpidsting
	-- {area:985} Waterspring Field · {npc:7847} Caliph Scorpidsting
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["Ride south-east to {area:985}. {npc:7847} stands in the middle of the southern Wastewander camp: clear around him first.\nCareful: Two stealthed Wastewander Rogues travel with him wherever he goes. At his spawn camp, two shadowmages and their minions are close enough to join a fight with him. Out by the towers you can fight him without them."] = "",

	-- Step 23: The Gaping Chasm
	-- {area:1938} Broken Pillar · {area:981} The Gaping Chasm
	["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside.\nCareful: One bug guards the gear. Many bugs patrol the tunnels, some of them level 50, so fights often pull extra adds."] = "",
	-- {item:8593} Scrimshank's Surveying Gear
	["{item:8593}; below ground"] = "",

	-- Step 24: Gadgetzan
	-- {zone:1457} Darnassus
	["for {zone:1457}: the route takes you there at 47"] = "Для зоны {zone:1457}: маршрут приведет вас туда на 47-м уровне",

	-- Step 25: Fly to Theramore
	["Fly to Theramore"] = "Лететь на остров Терамор",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "",

	-- Step 26: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Корабль: {area:150}",

	-- Step 27: Fly to Aerie Peak
	-- {area:348} Aerie Peak
	["Fly to {area:348}"] = "",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "",

	-- Step 28: Aerie Peak
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, beside the flight master"] = "",
	-- {npc:7884} Fraggar Thundermantle
	["{npc:7884}, inside"] = "",

	-- Step 31: Sprinkle's Secret Ingredient
	["Underwater"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly from {area:976} to Theramore, take the boat to {area:150} and fly to {area:1537}. Train."] = "Летите из места {area:976} в Терамор, плывите на корабле в {area:150} и летите в {area:1537}. Обучитесь.",
	-- ["Fly to {area:348}. {zone:1425} guide starts here."] = "Летите в {area:348}. Здесь начинается гайд по зоне {zone:1425}.",
	-- ["Follow the coast south to the pirate cove. Southsea pirates crowd the beach and the boats: work along the edge and pull one at a time. {npc:7883} stands on the far side; {npc:7881}'s stolen cargo lies in the camp."] = "Идите вдоль побережья на юг к пиратской бухте. Пираты Южных морей заполонили пляж и корабли: двигайтесь по краю и выманивайте по одному. {npc:7883} стоит на дальней стороне; украденный груз ({npc:7881}) лежит в лагере.",
	-- ["From the {area:1108} dock, boat to Feathermoon and fly to {area:489}, then ride east through {zone:1441} to the {area:2240} on the {area:439}. {npc:4454} and {npc:4630} are in the camps beside the track; {npc:4709} stands by the goblin camp."] = "От причала ({area:1108}) плывите на корабле в Крепость Оперенной Луны и летите в {area:489}, затем езжайте на восток через {zone:1441} к месту {area:2240} ({area:439}). {npc:4454} и {npc:4630} — в лагерях у трассы; {npc:4709} стоит у лагеря гоблинов.",
	-- ["Hearth to {area:976}."] = "Используйте Камень возвращения: {area:976}.",
	-- ["Ride back west to {area:976}."] = "Езжайте обратно на запад в {area:976}.",
	-- ["Ride back west toward {area:976}. The Wastewander bandits and thieves hold the dunes on the way; any of them can carry a water pouch."] = "Езжайте обратно на запад к месту {area:976}. По пути дюны занимают бандиты и воры из шайки Скитальцев Пустыни; у любого из них может быть бурдюк с водой.",
	-- ["Ride north-west to the Centipaar hive in the dunes. Any Centipaar can drop insect parts."] = "Езжайте на северо-запад к улью сентипааров в дюнах. С любого сентипаара могут выпасть части насекомых.",
	-- ["Ride south into {quest:3362}. The Dew Collectors drop the glands; only some are full, so keep the Laden one. Gnarled Thistleshrubs and Rootshapers share the valley. The Thistleshrubs are 48-50, above you: pull one at a time."] = "Езжайте на юг: {quest:3362}. Железы падают с терновых собирателей росы; полные не все, так что сохраните насыщенную. В долине также бугристые шипокожи и терновые корнеплеты. Шипокожи 48-50 уровня, выше вас: выманивайте по одному.",
	-- ["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside."] = "Езжайте на юг мимо места {area:1938} к месту {area:981} – туннелям Хаззали; снаряжение Холстомера лежит глубоко внутри.",
	-- ["Ride south-east off the {area:439} into {area:440}. {area:976} is just inside the border."] = "Езжайте на юго-восток из места {area:439} в {area:440}. {area:976} — сразу за границей.",
	-- ["Ride south-east to {area:985}. {npc:7847} stands in the middle of the southern Wastewander camp: clear around him first."] = "Езжайте на юго-восток в {area:985}. {npc:7847} стоит в центре южного лагеря Скитальцев Пустыни: сначала зачистите все вокруг него.",
	-- ["Rizzle's plans"] = "Чертежи Риззла",
	-- ["The Wanted poster by {npc:7882}"] = "Плакат «Розыск!» у NPC {npc:7882}",
	-- ["The tougher Wastewander rogues, shadow mages and assassins camp south-east of {area:976}, south of the bandits. Leave {npc:7847} in the middle of the southern camp for later."] = "Более сильные разбойники, темные маги и убийцы из шайки Скитальцев Пустыни стоят лагерем к юго-востоку от места {area:976}, южнее бандитов. {npc:7847} в центре южного лагеря оставьте на потом.",
	-- ["Wastewander bandits"] = "Бандиты из шайки Скитальцев Пустыни",
	-- ["While {npc:4709} keeps Rizzle talking, his plans lie unguarded in the gnome camp across the track."] = "Пока {npc:4709} заговаривает Риззлу зубы, его чертежи лежат без охраны в лагере гномов по ту сторону трассы.",
	-- ["{npc:11758}, on the east side of town"] = "{npc:11758}, восточная часть городка",
	-- ["{npc:7583}'s next ingredient grows in the {zone:1425}, and the route never brings it back: skip it."] = "Следующий ингредиент ({npc:7583}) растет здесь: {zone:1425}, а маршрут никогда не приводит его обратно: пропустите.",
	-- ["{npc:7881}'s next delivery goes back to {area:35}: skip it."] = "Следующая доставка ({npc:7881}) ведет обратно в {area:35}: пропустите ее.",
	-- ["{npc:7881}, in the port's tavern"] = "{npc:7881}, в таверне порта",
}
