-- French (frFR): the guide forever/reputation/wintersaber-trainers (forever/reputation/wintersaber-trainers.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Wintersaber Trainers Reputation"] = "Réputation : Éleveurs de sabres-d'hiver",
	-- {spell:17229} Winterspring Frostsaber · {zone:1452} Winterspring
	["The {spell:17229}: 840 quest turn-ins in {zone:1452}, with Timbermaw reputation on the side."] = "Le {spell:17229} : 840 remises de quêtes au {zone:1452}, avec de la réputation Grumegueule en prime.",
	-- {area:1769} Timbermaw Hold · {item:21383} Winterfall Spirit Beads · {quest:5201} Winterfall Intrusion
	["{area:1769} reputation on the side: 50 and about 4 {item:21383} per {quest:5201}"] = "Réputation {area:1769} en prime : 50 et environ 4 {item:21383} par {quest:5201}",

	-- Step 1: Rivern Frostwind
	-- {npc:10618} Rivern Frostwind · {area:2241} Frostsaber Rock · {zone:1452} Winterspring · {faction:589} Wintersaber Trainers · {quest:4970} Frostsaber Provisions
	["{npc:10618} stands on top of {area:2241}, in the far north of {zone:1452}; the path winds up from the east side. Only the Alliance can earn the {faction:589}' favour, from Neutral, at level 58. All three of her quests pay 50 and repeat as often as you like: 840 turn-ins from Neutral to Exalted. The first one, {quest:4970}, is the only one open at the start."] = "{npc:10618} se tient au sommet du {area:2241}, tout au nord du {zone:1452} ; le chemin monte en lacets par le côté est. Seule l'Alliance peut gagner la faveur des {faction:589}, à partir de Neutre, au niveau 58. Ses trois quêtes rapportent 50 chacune et se répètent autant que vous voulez : 840 remises de Neutre à Exalté. La première, {quest:4970}, est la seule disponible au départ.",

	-- Step 2: Shardtooth and Chillwind meat
	["Shardtooth and Chillwind meat"] = "Viande de Croc acéré et de Noroît",
	-- {npc:7445} Elder Shardtooth · {area:2255} Everlook · {npc:7446} Rabid Shardtooth
	-- plural, as words: Chillwind Ravagers = {npc:7449} Chillwind Ravager · Chillwind Chimaeras = {npc:7448} Chillwind Chimaera · Shardtooth Bears = {npc:7444} Shardtooth Bear
	["The meat only drops while the quest is in your log, and a group shares no loot: farm it alone. The best droppers live right below the rock: {npc:7445} bears (about half the time) and Chillwind Ravagers (half the time) roam the snowfields east and south-east of it. Around {area:2255} the Chillwind Chimaeras drop it as often and the Shardtooth Bears a little less; the {npc:7446} by the giants' gorge in the south drop it most often (six in ten)."] = "La viande ne tombe que si la quête est dans votre journal, et un groupe ne partage pas le butin : farmez seul. Les meilleurs fournisseurs vivent juste sous le rocher : les ours {npc:7445} (environ une fois sur deux) et les Ravageurs Noroît (une fois sur deux) parcourent les champs de neige à l'est et au sud-est. Autour de {area:2255}, les Chimères Noroît en laissent aussi souvent et les Ours Crocs acérés un peu moins ; les {npc:7446} près de la gorge des géants, au sud, en laissent le plus souvent (six fois sur dix).",
	-- {item:12622} Shardtooth Meat
	["{item:12622}: the bears"] = "{item:12622} : les ours",
	-- {item:12623} Chillwind Meat
	["{item:12623}: the chimaeras"] = "{item:12623} : les chimères",

	-- Step 3: Back to Rivern Frostwind
	-- {npc:10618} Rivern Frostwind
	["Back to {npc:10618}"] = "Retour auprès de {npc:10618}",

	-- Step 4: Neutral to Friendly: Frostsaber Provisions, then Winterfall Intrusion
	-- {quest:4970} Frostsaber Provisions · {quest:5201} Winterfall Intrusion
	["Neutral to Friendly: {quest:4970}, then {quest:5201}"] = "De Neutre à Amical : {quest:4970}, puis {quest:5201}",
	-- {quest:4970} Frostsaber Provisions · {quest:5201} Winterfall Intrusion · {area:2244} Winterfall Village · {area:2255} Everlook
	-- plural, as words: Winterfall Shamans = {npc:7439} Winterfall Shaman · Winterfall Ursas = {npc:7438} Winterfall Ursa
	["Repeat {quest:4970}: 30 turn-ins reach Neutral 1,500, and then {quest:5201} opens: 5 Winterfall Shamans and 5 Winterfall Ursas in {area:2244}, just east of {area:2255}. The village has only a few Shamans, but every furbolg there shares their spawn points: kill all of them, not just the ones you need, and more Shamans and Ursas appear; more Ursas walk the ridge just south-west of the village. Take both quests on every trip: kill the furbolgs, pick up meat on the way back. Neutral to Friendly is 60 turn-ins."] = "Répétez {quest:4970} : 30 remises amènent à Neutre 1 500, puis {quest:5201} se débloque : 5 Chamans Tombe-hiver et 5 Ursas Tombe-hiver au {area:2244}, juste à l'est de {area:2255}. Le village n'a que quelques Chamans, mais tous les furbolgs du lieu partagent leurs points d'apparition : tuez-les tous, pas seulement ceux qu'il vous faut, et d'autres Chamans et Ursas apparaissent ; d'autres Ursas parcourent la crête juste au sud-ouest du village. Prenez les deux quêtes à chaque trajet : tuez les furbolgs, ramassez de la viande au retour. De Neutre à Amical, il faut 60 remises.",

	-- Step 5: Friendly to Honored
	["Friendly to Honored"] = "D'Amical à Honoré",
	-- {quest:5201} Winterfall Intrusion · {quest:4970} Frostsaber Provisions · {area:1769} Timbermaw Hold · {item:21383} Winterfall Spirit Beads · {faction:589} Wintersaber Trainers
	["Friendly to Honored is 6,000: 120 turn-ins. {quest:5201} is the quickest; do {quest:4970} when the village is crowded or you pass the bears and chimaeras anyway. Every Winterfall furbolg you kill counts for {area:1769} too: 50 Timbermaw reputation per {quest:5201} up to the end of Honored with them, and about four {item:21383}. Take Salfa's Winterfall Activity (the Timbermaw guide) the first time you are in the village, and keep the beads until your Timbermaw kills stop counting: then each 5 pay 50. You will reach Exalted with the Timbermaw long before the {faction:589}."] = "D'Amical à Honoré, il faut 6 000 : 120 remises. {quest:5201} est la plus rapide ; faites {quest:4970} quand le village est bondé ou si vous passez de toute façon près des ours et des chimères. Chaque furbolg Tombe-hiver que vous tuez compte aussi pour {area:1769} : 50 de réputation Grumegueule par {quest:5201} jusqu'à la fin d'Honoré avec eux, et environ quatre {item:21383}. Prenez Les Tombe-hiver s'agitent de Salfa (le guide des Grumegueules) la première fois que vous êtes au village, et gardez les perles jusqu'à ce que vos victimes ne comptent plus pour les Grumegueules : chaque lot de 5 rapporte alors 50. Vous serez Exalté auprès des Grumegueules bien avant les {faction:589}.",

	-- Step 6: Honored to Exalted: Rampaging Giants too
	-- {quest:5981} Rampaging Giants
	["Honored to Exalted: {quest:5981} too"] = "D'Honoré à Exalté : {quest:5981} aussi",
	-- {quest:5981} Rampaging Giants · {area:2249} Frostwhisper Gorge · {zone:1452} Winterspring · {area:2244} Winterfall Village · {npc:7446} Rabid Shardtooth · {item:12622} Shardtooth Meat
	-- plural, as words: Frostmaul Giants = {npc:7428} Frostmaul Giant · Frostmaul Preservers = {npc:7429} Frostmaul Preserver
	["At Honored Rivern Frostwind adds {quest:5981}: 4 Frostmaul Giants and 4 Frostmaul Preservers, elite giants in {area:2249} in the south-east of {zone:1452}; the path down into the gorge starts at its north-west end. Take it on a trip south with a friend or two, or when {area:2244} is crowded; the {npc:7446} by the gorge drop {item:12622} most often. Honored to Exalted is 33,000: 660 turn-ins."] = "À Honoré, Rivern Frostwind ajoute {quest:5981} : 4 Géants Cognegivre et 4 Protecteurs Cognegivre, des géants élites dans la {area:2249} au sud-est du {zone:1452} ; le chemin qui descend dans la gorge part de son extrémité nord-ouest. Faites-la lors d'un trajet vers le sud avec un ou deux amis, ou quand le {area:2244} est bondé ; les {npc:7446} près de la gorge laissent le plus souvent de la {item:12622}. D'Honoré à Exalté, il faut 33 000 : 660 remises.",
	-- {npc:7428} Frostmaul Giant
	["{npc:7428}, elite"] = "{npc:7428}, élite",
	-- {npc:7429} Frostmaul Preserver
	["{npc:7429}, elite"] = "{npc:7429}, élite",
}
