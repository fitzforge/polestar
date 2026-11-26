-- French (frFR): the guide forever/reputation/timbermaw-hold (forever/reputation/timbermaw-hold.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Timbermaw Hold Reputation"] = "Réputation : Les Grumegueules",
	["Safe passage through the tunnels, agility enchants and furbolg recipes; the trinket at Exalted."] = "Un passage sûr dans les tunnels, des enchantements d'agilité et des recettes furbolgs ; le bijou à Exalté.",
	["Recipes for Leatherworkers, Tailors, Enchanters and Alchemists from Friendly to Revered"] = "Des recettes pour travailleurs du cuir, tailleurs, enchanteurs et alchimistes, d'Amical à Révéré",

	-- Step 1: Grazle
	-- {faction:576} Timbermaw Hold · {npc:11554} Grazle · {npc:15395} Nafien · {npc:11556} Salfa · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["{faction:576} starts at Hostile (2,500 of 3,000), so its furbolgs attack you in their tunnels; {npc:11554}, {npc:15395} and {npc:11556} talk to everyone. {npc:11554} waits by the road in the south of {zone:1448}, near the {area:2479}. Every Deadwood and Winterfall furbolg you kill gives 5 reputation up to the last point of Honored, so the quests below pay twice. The Legacy perk Diplomat adds up to 10% to every gain."] = "{faction:576} commence à Hostile (2 500 sur 3 000) : ses furbolgs vous attaquent donc dans leurs tunnels ; {npc:11554}, {npc:15395} et {npc:11556} parlent à tout le monde. {npc:11554} attend au bord de la route dans le sud de {zone:1448}, près du {area:2479}. Chaque furbolg Mort-bois ou Tombe-hiver que vous tuez donne 5 de réputation jusqu'au dernier point d'Honoré : les quêtes ci-dessous rapportent donc deux fois. L'atout d'Héritage Diplomate ajoute jusqu'à 10 % à chaque gain.",

	-- Step 2: Deadwood Village
	-- {zone:1448} Felwood · {item:21377} Deadwood Headdress Feather · {npc:9464} Overlord Ror · {npc:14342} Ragepaw
	["The Deadwood furbolgs (level 48-50) hold the village at the south end of {zone:1448}. Keep every {item:21377}: they are worth 10 reputation each later and never stop counting. {npc:9464} (15 reputation) and the rare {npc:14342} (25) live here and count until Exalted. Forever pays quests in full at any level; in Classic grey mobs gave about a fifth, about 1 a kill for these furbolgs at 60. Do it while leveling if you can."] = "Les furbolgs Mort-bois (niveau 48-50) tiennent le village à l'extrémité sud de {zone:1448}. Gardez chaque {item:21377} : elles valent 10 de réputation chacune plus tard et comptent toujours. {npc:9464} (15 de réputation) et le rare {npc:14342} (25) vivent ici et comptent jusqu'à Exalté. Forever paie les quêtes en entier à tout niveau ; dans Classic, les monstres gris donnaient environ un cinquième, soit environ 1 par victime pour ces furbolgs au niveau 60. Faites-le pendant votre progression si vous pouvez.",
	-- {npc:14342} Ragepaw
	["{npc:14342}, rare"] = "{npc:14342}, rare",

	-- Step 3: Back to Grazle
	-- {npc:11554} Grazle
	["Back to {npc:11554}"] = "Retour à {npc:11554}",

	-- Step 4: Nafien
	-- {npc:15395} Nafien · {zone:1448} Felwood
	["{npc:15395} stands at the {zone:1448} mouth of the Timbermaw tunnel, at the top of the road in the north of {zone:1448}."] = "{npc:15395} se tient à l'entrée côté {zone:1448} du tunnel des Grumegueules, en haut de la route dans le nord de {zone:1448}.",

	-- Step 5: Felpaw Village
	-- {npc:9462} Chieftain Bloodmaw
	["The northern Deadwood (level 53-55) camp just south of the tunnel. They drop feathers about half the time: the best feather spot. {npc:9462} gives 15 until Exalted."] = "Les Mort-bois du nord (niveau 53-55) campent juste au sud du tunnel. Ils laissent des plumes environ une fois sur deux : le meilleur endroit pour les plumes. {npc:9462} donne 15 jusqu'à Exalté.",

	-- Step 6: Back to Nafien
	-- {npc:15395} Nafien
	["Back to {npc:15395}"] = "Retour à {npc:15395}",
	-- {quest:8460} Timbermaw Ally
	["These quests and their kills bring you just past Unfriendly (500 from the start). If {quest:8460} paid you less (at level 60 in Classic: 30), kill about 40 more northern Deadwood. From Unfriendly the Timbermaw in the tunnel leave you alone."] = "Ces quêtes et leurs victimes vous amènent juste au-delà d'Inamical (500 depuis le départ). Si {quest:8460} vous a rapporté moins (au niveau 60 dans Classic : 30), tuez environ 40 Mort-bois du nord de plus. À partir d'Inamical, les Grumegueules du tunnel vous laissent tranquille.",

	-- Step 7: Salfa
	-- {zone:1452} Winterspring · {npc:11556} Salfa
	["Walk through the tunnel to its {zone:1452} mouth; {npc:11556} stands just outside. Do not attack any Timbermaw: each one costs 25 reputation."] = "Traversez le tunnel jusqu'à sa sortie côté {zone:1452} ; {npc:11556} se tient juste dehors. N'attaquez aucun Grumegueule : chacun coûte 25 de réputation.",

	-- Step 8: Winterfall Village
	-- {area:2244} Winterfall Village · {zone:1452} Winterspring · {area:2255} Everlook · {item:21383} Winterfall Spirit Beads · {npc:10199} Grizzle Snowpaw · {npc:10738} High Chief Winterfall
	["{area:2244} lies in the east of {zone:1452}, just past {area:2255}. Keep every {item:21383} you loot (10 reputation each later). The Shamans, Den Watchers and Ursas share their spawn points, so kill every furbolg in the village to make the ones you need appear; more Ursas walk the ridge just south-west of the village. {npc:10199} (rare) and {npc:10738}, in the cave at the back, give 25 until Exalted. Alliance: the Wintersaber Trainers' Winterfall Intrusion asks for the same Shamans and Ursas."] = "Le {area:2244} se trouve dans l'est du {zone:1452}, juste après {area:2255}. Gardez toutes les {item:21383} que vous ramassez (10 de réputation chacune plus tard). Les Chamans, Protecteurs et Ursas partagent leurs points d'apparition : tuez tous les furbolgs du village pour faire apparaître ceux qu'il vous faut ; d'autres Ursas parcourent la crête juste au sud-ouest du village. {npc:10199} (rare) et {npc:10738}, dans la grotte du fond, donnent 25 jusqu'à Exalté. Alliance : L'incursion des Tombe-hiver des Éleveurs de sabres-d'hiver demande les mêmes Chamans et Ursas.",
	-- {npc:10199} Grizzle Snowpaw
	["{npc:10199}, rare"] = "{npc:10199}, rare",
	-- {npc:10738} High Chief Winterfall
	["{npc:10738}, elite"] = "{npc:10738}, élite",

	-- Step 9: Back to Salfa
	-- {npc:11556} Salfa
	["Back to {npc:11556}"] = "Retour à {npc:11556}",
	-- {quest:8466} Feathers for Grazle · {quest:8467} Feathers for Nafien · {quest:8469} Beads for Salfa
	["{quest:8466}, {quest:8467} and {quest:8469} are open now: 50 reputation for 5 feathers or 5 beads, as often as you like. Do not hand them in yet."] = "{quest:8466}, {quest:8467} et {quest:8469} sont maintenant disponibles : 50 de réputation pour 5 plumes ou 5 perles, autant de fois que vous voulez. Ne les rendez pas encore.",

	-- Step 10: Unfriendly to Neutral
	["Unfriendly to Neutral"] = "D'Inamical à Neutre",
	-- {zone:1448} Felwood · {area:2246} Frostfire Hot Springs · {area:2243} Timbermaw Post · {npc:11556} Salfa · {area:2244} Winterfall Village
	["Unfriendly to Neutral is 3,000: about 540 more kills after these quests. Three camps: the northern Deadwood by the {zone:1448} mouth of the tunnel; the Winterfall camps around {area:2246} and {area:2243}, just south and south-east of {npc:11556} (Pathfinders give 6 a kill, Den Watchers and Totemics 5, the shortest walk to a turn-in); and {area:2244} in the east. Pick the least crowded. Keep all feathers and beads."] = "D'Inamical à Neutre, il faut 3 000 : environ 540 victimes de plus après ces quêtes. Trois camps : les Mort-bois du nord près de l'entrée côté {zone:1448} du tunnel ; les camps Tombe-hiver autour des {area:2246} et du {area:2243}, juste au sud et au sud-est de {npc:11556} (les Guides donnent 6 par victime, les Protecteurs et Totémiques 5, le plus court trajet vers une remise) ; et le {area:2244} à l'est. Choisissez le moins fréquenté. Gardez toutes les plumes et perles.",
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["Deadwood Headdress Feathers: keep them"] = "{item:21377} : gardez-les",
	-- {item:21383} Winterfall Spirit Beads
	["{item:21383}: keep them"] = "{item:21383} : gardez-les",
	-- {area:2246} Frostfire Hot Springs
	-- plural, as words: Winterfall Pathfinders = {npc:7442} Winterfall Pathfinder
	["Winterfall Pathfinders, {area:2246}"] = "Guides Tombe-hiver, {area:2246}",

	-- Step 11: Deadwood Ritual Totem
	-- {quest:8470} Deadwood Ritual Totem · {npc:11558} Kernda · {zone:1448} Felwood
	-- plural, as words: Mana Potions = {item:3827} Mana Potion
	["The northern Deadwood rarely drop a {quest:8470} (about 3%). From Neutral, {npc:11558} takes it in the tunnel, on the {zone:1448} side: 150 reputation and two Major Healing and Mana Potions."] = "Les Mort-bois du nord laissent rarement un totem rituel ({quest:8470}, environ 3 %). À partir de Neutre, {npc:11558} le prend dans le tunnel, côté {zone:1448} : 150 de réputation et deux potions de soins majeures et de mana majeures.",

	-- Step 12: Kernda: the Deadwood totem
	-- {npc:11558} Kernda
	["{npc:11558}: the Deadwood totem"] = "{npc:11558} : le totem Deadwood",

	-- Step 13: Winterfall Ritual Totem
	-- {quest:8471} Winterfall Ritual Totem · {npc:11558} Kernda
	-- plural, as words: Mana Potions = {item:3827} Mana Potion
	["The Winterfall furbolgs rarely drop a {quest:8471} (3-4%). {npc:11558} takes it in the tunnel too: 150 reputation and three Major Healing and Mana Potions."] = "Les furbolgs Tombe-hiver laissent rarement un totem rituel ({quest:8471}, 3-4 %). {npc:11558} le prend aussi dans le tunnel : 150 de réputation et trois potions de soins majeures et de mana majeures.",

	-- Step 14: Kernda: the Winterfall totem
	-- {npc:11558} Kernda
	["{npc:11558}: the Winterfall totem"] = "{npc:11558} : le totem Winterfall",

	-- Step 15: To Azshara
	-- {zone:1447} Azshara
	["To {zone:1447}"] = "",
	-- {area:1225} Ursolan · {zone:1447} Azshara · {npc:11555} Gorn One Eye · {faction:576} Timbermaw Hold · {area:1237} Valormok · {area:3137} Talrendis Point · {npc:235903} Ekkal
	["Neutral opens {area:1225}, the camp of the Blackmaw furbolgs in northern {zone:1447}: their quests and {npc:11555}'s in {faction:576} are levels 53-55, about 50,000 experience below level 60, all outdoors. Below Neutral the Blackmaw attack you. The nearest flight masters are {area:1237} (Horde) and {area:3137} (Alliance); {npc:235903} camps by the road between them and {area:1225}."] = "",
	-- {npc:235903} Ekkal
	["{npc:235903}'s camp"] = "",

	-- Step 16: Ekkal
	-- {npc:235903} Ekkal · {zone:1447} Azshara · {area:1219} Legashi Encampment
	-- plural, as words: Legashi Satyrs = {npc:6200} Legashi Satyr
	["{npc:235903} camps by the road in the middle of {zone:1447}. His satyrs come first: the Legashi Satyrs, Rogues and Hellcallers (51-53) of the {area:1219}, north-east of him."] = "",

	-- Step 17: The Legashi Encampment
	-- {area:1219} Legashi Encampment
	["The {area:1219}"] = "",

	-- Step 20: Ursolan
	-- {area:1225} Ursolan · {npc:235909} Furze · {npc:236573} Gatekeeper Rageroar · {npc:235906} Elder Bramblesnap
	["Ride north up the road to {area:1225}. {npc:235909} sits on the camp's south-east side; {npc:236573} and {npc:235906} stand together on its west side."] = "",

	-- Step 21: The Legashi Cauldron
	-- {object:506307} Legashi Cauldron (no name in this language: may be words)
	["The {object:506307}"] = "",
	-- {area:1219} Legashi Encampment
	["Ride east to the {area:1219}: the satyrs' cauldron stands in the middle of their camp."] = "",

	-- Step 22: The Legashi Encampment
	["Any of the encampment's satyrs may carry the recipe."] = "",

	-- Step 24: Satyrweed
	-- plural, as words: Satyrweed Brambles = {object:507746} Satyrweed Bramble
	["The Satyrweed Brambles grow all around the encampment."] = "",

	-- Step 25: Korsa
	-- {area:16234} Legashi Stronghold · {npc:236770} Korsa
	["East to the {area:16234}: {npc:236770}, the missing Blackmaw scout, waits outside it."] = "",

	-- Step 26: Graal
	-- {npc:237007} Graal · {npc:235892} Prince Halanox
	["{npc:237007} is held at the north end of the stronghold: free {npc:237007} and see the breakout through. Careful: {npc:235892} (55, elite) stands just south of there, around 67,19."] = "",

	-- Step 27: The Legashi Stronghold: kill these as you meet them
	-- {area:16234} Legashi Stronghold
	["The {area:16234}: kill these as you meet them"] = "",
	-- {npc:235892} Prince Halanox
	["The Hellraisers, Soulstealers and Blackguards (53-54) hold the stronghold. Careful: {npc:235892} (55, elite) stands at its north-east end, around 67,19: leave him be."] = "",

	-- Step 28: Master Feardred
	-- {quest:86777} Master Feardred · {item:235471} Fel Mote
	["{quest:86777} (53) walks the stronghold's south side; the {item:235471} floats nearby."] = "",

	-- Step 30: The Legashi Cauldron
	["Back west to the cauldron."] = "",

	-- Step 31: Ursolan
	-- {area:1225} Ursolan
	["Back west to {area:1225}."] = "",
	-- {npc:11555} Gorn One Eye · {faction:576} Timbermaw Hold
	["For {npc:11555} in {faction:576}, at the end of this part"] = "",

	-- Step 32: Mosshoof Coursers
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers"] = "Coursiers Sabots-de-mousse",
	-- {area:1225} Ursolan · {item:221199} Satyrweed Tincture
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser · Thunderhead Skystormers = {npc:6378} Thunderhead Skystormer
	["The Mosshoof Coursers (52-53) and Thunderhead Skystormers (50-52) graze just east of {area:1225}: bring one low, then use the {item:221199} on it. Three times."] = "",

	-- Step 34: Furze
	-- {npc:235909} Furze
	["Give {npc:235909} the panacea."] = "",

	-- Step 36: To Timbermaw Hold
	-- {area:1769} Timbermaw Hold
	["To {area:1769}"] = "",
	-- {zone:1448} Felwood · {area:1997} Bloodvenom Post · {area:1998} Talonbranch Glade
	["Back to {zone:1448}: fly to {area:1997} (Horde) or {area:1998} (Alliance) and ride north up the road to the {zone:1448} mouth of the tunnel."] = "",

	-- Step 37: Gorn One Eye
	-- {npc:11555} Gorn One Eye · {npc:11558} Kernda · {npc:11557} Meilosh
	["{npc:11555} stands just inside the tunnel, by {npc:11558} and {npc:11557}."] = "",

	-- Step 38: Chieftain Bloodmaw
	-- {npc:9462} Chieftain Bloodmaw
	["{npc:9462} (55-56) leads the Deadwood of Felpaw Village, just west of the tunnel."] = "",

	-- Step 39: Gorn One Eye
	-- {zone:1447} Azshara · {npc:235892} Prince Halanox
	["His next task, Blackmaw Counter-Offensive, sends you back to {zone:1447} against {npc:235892}, a level 55 elite: bring a friend."] = "",

	-- Step 40: Neutral to Friendly
	["Neutral to Friendly"] = "De Neutre à Amical",
	["Neutral to Friendly is 3,000: 600 kills. Keep all feathers and beads."] = "De Neutre à Amical, il faut 3 000 : 600 victimes. Gardez toutes les plumes et perles.",

	-- Step 41: Meilosh
	-- {npc:11557} Meilosh · {zone:1448} Felwood · {item:13484} Recipe: Transmute Earth to Water · {item:22392} Formula: Enchant 2H Weapon - Agility · {item:20253} Pattern: Warbear Harness · {item:15065} Warbear Woolies · {quest:6031} Runecloth · {item:14342} Mooncloth · {item:15802} Mooncloth Boots
	["{npc:11557} stands in the tunnel, near its {zone:1448} mouth. From Friendly he sells: {item:13484} (1 gold 50 silver), {item:22392} (2 gold 50 silver), {item:20253} (1 gold 60 silver) and {item:15065} (2 gold). He also takes 30 {quest:6031} once for 100 reputation and a choice of shoulders or gauntlets, and Tailors with skill 290 can bring him 2 {item:14342} for 100 more and the {item:15802} pattern."] = "{npc:11557} se tient dans le tunnel, près de sa sortie côté {zone:1448}. À partir d'Amical, il vend : {item:13484} (1 po 50 pa), {item:22392} (2 po 50 pa), {item:20253} (1 po 60 pa) et {item:15065} (2 po). Il prend aussi une fois 30 étoffes runiques ({quest:6031}) pour 100 de réputation et des épaulières ou des gantelets au choix, et les tailleurs de compétence 290 peuvent lui apporter 2 {item:14342} pour 100 de plus et le patron des {item:15802}.",

	-- Step 42: Runecloth for Meilosh
	-- {quest:6031} Runecloth · {npc:11557} Meilosh
	["{quest:6031} for {npc:11557}"] = "{quest:6031} pour {npc:11557}",
	-- {quest:6031} Runecloth
	["{quest:6031} drops from the humanoids of the level 50-60 zones, the Deadwood and Winterfall furbolgs among them."] = "Cette étoffe ({quest:6031}) tombe sur les humanoïdes des zones de niveau 50-60, dont les furbolgs Mort-bois et Tombe-hiver.",

	-- Step 43: Sacred Cloth
	-- {npc:11557} Meilosh · {item:14342} Mooncloth · {item:15802} Mooncloth Boots
	["Tailors with skill 290: {npc:11557} takes 2 {item:14342} once for 100 reputation and teaches the {item:15802}."] = "Tailleurs de compétence 290 : {npc:11557} prend une fois 2 {item:14342} pour 100 de réputation et enseigne les {item:15802}.",

	-- Step 44: Friendly to Honored
	["Friendly to Honored"] = "D'Amical à Honoré",
	-- {npc:11557} Meilosh · {item:19445} Formula: Enchant Weapon - Agility · {item:19202} Pattern: Heavy Timbermaw Belt · {item:19044} Might of the Timbermaw · {skill:165} Leatherworking · {item:19047} Wisdom of the Timbermaw · {skill:197} Tailoring
	["Friendly to Honored is 6,000: 1,200 kills. Keep all feathers and beads. Honored opens at {npc:11557}: {item:19445} (3 gold), and for 2 gold 20 silver each {item:19202} and {item:19044} ({skill:165}) and {item:19047} ({skill:197})."] = "D'Amical à Honoré, il faut 6 000 : 1 200 victimes. Gardez toutes les plumes et perles. Honoré débloque chez {npc:11557} : {item:19445} (3 po), et pour 2 po 20 pa chacun, {item:19202} et {item:19044} ({skill:165}) et {item:19047} ({skill:197}).",

	-- Step 45: Honored to Revered
	["Honored to Revered"] = "D'Honoré à Révéré",
	["Honored to Revered is 12,000: 2,400 kills, the last ones that count. Kills stop at 11,999 of 12,000 Honored and never tip you into Revered: when they stop, hand in one set of 5 feathers or beads to cross over. Saving every feather and bead pays off now: about 4,800 kills from the start to the end of Honored leave you with about 2,100 feathers and beads, and that is all of Revered to Exalted. Turning them in early would cost you about 2,400 more kills."] = "D'Honoré à Révéré, il faut 12 000 : 2 400 victimes, les dernières qui comptent. Les victimes s'arrêtent à 11 999 sur 12 000 d'Honoré et ne vous font jamais passer Révéré : quand elles s'arrêtent, rendez un lot de 5 plumes ou perles pour passer le cap. Avoir gardé toutes les plumes et perles paie maintenant : environ 4 800 victimes du départ à la fin d'Honoré vous laissent environ 2 100 plumes et perles, soit tout le chemin de Révéré à Exalté. Les rendre plus tôt vous coûterait environ 2 400 victimes de plus.",
	-- {item:19445} Formula: Enchant Weapon - Agility · {skill:333} Enchanting
	["{item:19445} ({skill:333}), 3 gold"] = "{item:19445} ({skill:333}), 3 po",
	-- {quest:8467} Feathers for Nafien
	["{quest:8467}: once your kills stop, 5 feathers into Revered"] = "{quest:8467} : une fois les victimes arrêtées, 5 plumes pour passer Révéré",
	-- {quest:8469} Beads for Salfa
	["{quest:8469}: or 5 beads"] = "{quest:8469} : ou 5 perles",

	-- Step 46: Revered to Exalted
	["Revered to Exalted"] = "De Révéré à Exalté",
	-- {npc:15395} Nafien · {npc:11554} Grazle · {npc:11556} Salfa · {npc:14342} Ragepaw · {npc:10199} Grizzle Snowpaw · {npc:10738} High Chief Winterfall · {npc:11557} Meilosh · {item:19204} Pattern: Heavy Timbermaw Boots · {item:19049} Timbermaw Brawlers · {skill:165} Leatherworking · {item:19050} Mantle of the Timbermaw · {skill:197} Tailoring
	["Kills stopped at the end of Honored. Revered to Exalted is 21,000: 420 turn-ins, 2,100 feathers and beads. Hand in the feathers to {npc:15395} at the tunnel or {npc:11554} in the south, the beads to {npc:11556}, five at a time. The named furbolgs (Ror, Bloodmaw, {npc:14342}, {npc:10199}, {npc:10738}) still count. Revered opens at {npc:11557}, for 4 gold each: {item:19204} and {item:19049} ({skill:165}) and {item:19050} ({skill:197})."] = "Les victimes se sont arrêtées à la fin d'Honoré. De Révéré à Exalté, il faut 21 000 : 420 remises, 2 100 plumes et perles. Rendez les plumes à {npc:15395} au tunnel ou à {npc:11554} au sud, les perles à {npc:11556}, cinq à la fois. Les furbolgs nommés (Ror, Saignegueule, {npc:14342}, {npc:10199}, {npc:10738}) comptent toujours. Révéré débloque chez {npc:11557}, pour 4 po chacun : {item:19204} et {item:19049} ({skill:165}) et {item:19050} ({skill:197}).",
	-- {quest:8467} Feathers for Nafien
	["{quest:8467}: 5 feathers, 50 reputation"] = "{quest:8467} : 5 plumes, 50 de réputation",
	-- {quest:8466} Feathers for Grazle
	["{quest:8466}: 5 feathers, 50 reputation"] = "{quest:8466} : 5 plumes, 50 de réputation",
	-- {quest:8469} Beads for Salfa
	["{quest:8469}: 5 beads, 50 reputation"] = "{quest:8469} : 5 perles, 50 de réputation",

	-- Step 47: The Root of All Evil
	-- {npc:11555} Gorn One Eye · {npc:11557} Meilosh · {quest:8481} The Root of All Evil · {item:21144} Demon Summoning Torch · {npc:10738} High Chief Winterfall · {npc:15623} Xandivious · {item:21326} Defender of the Timbermaw
	["At Exalted, {npc:11555}, in the tunnel by {npc:11557}, gives {quest:8481}: plant his {item:21144} in the mouth of {npc:10738}'s cave and defeat the demon {npc:15623} (level 62, elite: bring a group). The reward is {item:21326}, a trinket that calls a Timbermaw ally, and 200 reputation."] = "À Exalté, {npc:11555}, dans le tunnel près de {npc:11557}, donne {quest:8481} : plantez sa {item:21144} à l'entrée de la grotte de {npc:10738} et vainquez le démon {npc:15623} (niveau 62, élite : venez en groupe). La récompense est {item:21326}, un bijou qui appelle un allié grumegueule, et 200 de réputation.",

	-- Step 48: Xandivious
	-- {area:2244} Winterfall Village · {npc:15623} Xandivious
	["{area:2244}, the cave at the back. Clear the furbolgs around the mouth first, plant the torch, kill {npc:15623} and loot the Essence from his Demon Bag."] = "{area:2244}, la grotte du fond. Nettoyez d'abord les furbolgs autour de l'entrée, plantez la torche, tuez {npc:15623} et prenez l'essence dans son sac démoniaque.",
	-- {npc:15623} Xandivious
	["{npc:15623}, 25 reputation"] = "{npc:15623}, 25 de réputation",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Alternate Deadwood feathers ({npc:15395}) and Winterfall beads ({npc:11556}), whichever camp is less crowded."] = "Alternez plumes Mort-bois ({npc:15395}) et perles Tombe-hiver ({npc:11556}), selon le camp le moins fréquenté.",
	-- ["Deadwood furbolgs (level 48-50) camp at the southern end of {zone:1448}. Keep every {item:21377} they drop: {npc:11554} and {npc:15395} take them later."] = "Les furbolgs Mort-bois (niveau 48-50) campent à l'extrémité sud de {zone:1448}. Gardez chaque {item:21377} qu'ils lâchent : {npc:11554} et {npc:15395} les prennent plus tard.",
	-- ["Feathers and beads to Friendly"] = "Plumes et perles jusqu'à Amical",
	-- ["Feathers for {npc:11554} and Feathers for {npc:15395} (Deadwood Headdress Feathers) and Beads for {npc:11556} ({item:21383}) repeat as often as you like; every Deadwood or Winterfall kill counts as well. {area:2244} is the densest bead spot."] = "Des plumes pour {npc:11554} et Des plumes pour {npc:15395} (Coiffures de plumes mort-bois) et Des perles pour {npc:11556} ({item:21383}) se répètent à volonté ; chaque Mort-bois ou Tombe-hiver tué compte aussi. Le {area:2244} est le meilleur endroit pour les perles.",
	-- ["Feathers to Honored"] = "Plumes jusqu'à Honoré",
	-- ["Go through {faction:576} to its {zone:1452} exit; {npc:11556} stands just outside. The quests and kills so far usually reach Unfriendly, and then the Timbermaw let you pass. If they still show red, kill more Deadwood by the tunnel first."] = "Traversez le territoire de {faction:576} jusqu'à la sortie de {zone:1452} ; {npc:11556} se tient juste dehors. Les quêtes et victimes jusqu'ici suffisent en général pour Inamical, et les Grumegueules vous laissent alors passer. S'ils apparaissent encore en rouge, tuez d'abord d'autres Mort-bois près du tunnel.",
	-- ["Keep turning in feathers and beads until Exalted."] = "Continuez à rendre plumes et perles jusqu'à Exalté.",
	-- ["The northern Deadwood (level 53-55) hold the camps just south of the tunnel. Keep their feathers too."] = "Les Mort-bois du nord (niveau 53-55) tiennent les camps juste au sud du tunnel. Gardez aussi leurs plumes.",
	-- ["The northern Deadwood camps by the tunnel are the densest feather spot (35% drop chance there). Hand feathers to {npc:15395} at the tunnel, or to {npc:11554} in the south."] = "Les camps Mort-bois du nord près du tunnel sont le meilleur endroit pour les plumes (35 % de chances de butin). Donnez les plumes à {npc:15395} au tunnel, ou à {npc:11554} au sud.",
	-- ["{area:2244} sits on the eastern side of {zone:1452}. Keep every {item:21383} you loot: {npc:11556} takes them."] = "Le {area:2244} est à l'est de {zone:1452}. Gardez chaque {item:21383} ramassée : {npc:11556} les prend.",
	-- ["{faction:576} starts out Hostile, and its furbolgs in the tunnels attack until you reach Unfriendly. Every Deadwood and Winterfall furbolg you kill raises it, so the quests below pay twice. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:576} commence Hostile, et ses furbolgs des tunnels attaquent jusqu'à ce que vous soyez Inamical. Chaque furbolg Mort-bois ou Tombe-hiver tué l'augmente : les quêtes ci-dessous rapportent donc deux fois. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",
	-- ["{faction:576} to Exalted"] = "{faction:576} jusqu'à Exalté",
	-- ["{faction:576} to Revered"] = "{faction:576} jusqu'à Révéré",
	-- ["{npc:11556}: Beads for {npc:11556}"] = "{npc:11556} : Des perles pour {npc:11556}",
	-- ["{npc:15395} waits in northern {zone:1448} at the tunnel into {faction:576}."] = "{npc:15395} attend au nord de {zone:1448}, au tunnel menant chez {faction:576}.",
	-- ["{npc:15395}: Feathers for {npc:15395}"] = "{npc:15395} : Des plumes pour {npc:15395}",
}
