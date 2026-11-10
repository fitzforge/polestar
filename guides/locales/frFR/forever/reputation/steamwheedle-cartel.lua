-- French (frFR): the guide forever/reputation/steamwheedle-cartel (forever/reputation/steamwheedle-cartel.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Steamwheedle Cartel Reputation"] = "Réputation : Cartel Gentepression",
	-- {npc:14637} Zorbin Fandazzle · {npc:14338} Knot Thimblejack
	["Every goblin town at once: {npc:14637}'s zapped giants and {npc:14338}'s shackles, then five new quartermasters and their hats."] = "Toutes les villes gobelines à la fois : les géants rétrécis de {npc:14637} et les menottes de {npc:14338}, puis cinq nouveaux intendants et leurs chapeaux.",
	["Forever's goblin quartermasters: gear for levels 20 to 50 at Friendly and Honored"] = "Les intendants gobelins de Forever : de l'équipement des niveaux 20 à 50 à Amical et Honoré",

	-- Step 1: Zorbin Fandazzle
	-- {faction:470} Ratchet · {faction:21} Booty Bay · {faction:369} Gadgetzan · {faction:577} Everlook · {faction:2827} Powderfuse · {zone:2548} Riverglades · {npc:14637} Zorbin Fandazzle · {npc:4624} Booty Bay Bruiser · {zone:1444} Feralas
	["Five goblin towns share one reputation family, the Steamwheedle Cartel: {faction:470}, {faction:21}, {faction:369}, {faction:577} and Forever's new {faction:2827} in the {zone:2548}. Everyone starts each at Neutral (500 into it). A gain with one town gives the others half as much; a quest for the Cartel itself, like {npc:14637}'s, pays every town in full. Losses spread the same way: a {npc:4624} or any goblin of the towns costs 125 (half that with the other towns), and Bloodsail Buccaneers reputation is earned only that way. {npc:14637} camps on the road through central {zone:1444} and works for anyone, even players the goblins hate. His first two quests are level 48 and open his repeatables (level 55); Forever pays all of them in full at any level."] = "",
	-- {quest:7003} Zapped Giants
	["{quest:7003}: 150 to every town"] = "{quest:7003} : 150 pour chaque ville",
	-- {quest:7721} Fuel for the Zapping
	["{quest:7721}: 150 to every town"] = "{quest:7721} : 150 pour chaque ville",

	-- Step 2: Zapped giants
	["Zapped giants"] = "Géants rétrécis",
	-- {item:18904} Zorbin's Ultra-Shrinker · {npc:5357} Land Walker · {npc:5358} Cliff Giant · {npc:5361} Wave Strider · {item:18956} Miniaturization Residue
	-- plural, as words: Land Walkers = {npc:5357} Land Walker · Cliff Giants = {npc:5358} Cliff Giant
	["Use {item:18904} on a living giant ({npc:5357}, {npc:5358}, or a Shore, Deep or {npc:5361}, level 47-50) and it shrinks into a zapped version; kill that for its {item:18956}, one every time. The Land Walkers and Cliff Giants in the north-west hills are the thickest; the striders walk the coast and the shallows. The shrinker lasts two hours: if it runs out, abandon the quest and take it again."] = "Utilisez l'{item:18904} sur un géant vivant ({npc:5357}, {npc:5358}, ou un Marcheur des rivages, des profondeurs ou {npc:5361}, niveau 47-50) : il rétrécit en une version miniature ; tuez-la pour ses {item:18956}, à chaque fois. Les Marcheurs des terres et les Géants des falaises des collines du nord-ouest sont les plus nombreux ; les marcheurs arpentent la côte et les hauts-fonds. Le réducteur dure deux heures : s'il expire, abandonnez la quête et reprenez-la.",
	-- {item:18904} Zorbin's Ultra-Shrinker
	["{item:18904}, on a living giant"] = "{item:18904}, sur un géant vivant",
	-- {item:18956} Miniaturization Residue
	["{item:18956}, from the zapped giants"] = "{item:18956}, sur les géants rétrécis",

	-- Step 3: Sea Elementals and Sea Sprays
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["Sea Elementals and Sea Sprays"] = "Elémentaires marins et Embruns",
	-- {area:1108} Forgotten Coast · {item:18958} Water Elemental Core
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["The Sea Elementals and Sea Sprays (level 47-49) drift along the {area:1108} and in the shallows below the giants: about half drop a {item:18958}."] = "Les Elémentaires marins et les Embruns (niveau 47-49) dérivent le long de la {area:1108} et dans les hauts-fonds sous les géants : environ la moitié laisse un {item:18958}.",
	-- {item:18958} Water Elemental Core
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["{item:18958}: Sea Elementals and Sea Sprays"] = "{item:18958} : Elémentaires marins et Embruns",

	-- Step 4: Back to Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle
	["Back to {npc:14637}"] = "Retour auprès de {npc:14637}",
	-- {npc:14637} Zorbin Fandazzle · {quest:7725} Again With the Zapped Giants · {quest:7726} Refuel for the Zapping
	["From now on {npc:14637} offers {quest:7725} (10 residue) and {quest:7726} (6 cores), again and again: 25 reputation with every town each time."] = "Désormais, {npc:14637} propose {quest:7725} (10 résidus) et {quest:7726} (6 noyaux), encore et encore : 25 de réputation avec chaque ville à chaque fois.",

	-- Step 5: Lost Rigger Cove, below 56
	-- {area:1336} Lost Rigger Cove
	["{area:1336}, below 56"] = "{area:1336}, sous le niveau 56",
	-- {area:1336} Lost Rigger Cove · {zone:1446} Tanaris · {faction:369} Gadgetzan · {area:977} Steamwheedle Port · {quest:8366} Southsea Shakedown · {quest:8365} Pirate Hats Ahoy!
	-- plural, as words: Southsea Pirate Hats = {item:20519} Southsea Pirate Hat
	["The Southsea pirates of {area:1336} (level 44-45) on the east coast of {zone:1446} give {faction:369} 5 each up to the end of Honored, and the other towns half. Two quests at {area:977} pay 100 {faction:369} each: {quest:8366} (10 of each pirate) and {quest:8365} (20 Southsea Pirate Hats, one in ten pirates). From level 56 the pirates are grey and pay little: skip this step then."] = "Les pirates des Mers du Sud de {area:1336} (niveau 44-45), sur la côte est de {zone:1446}, donnent chacun 5 à {faction:369} jusqu'à la fin d'Honoré, et moitié aux autres villes. Deux quêtes au {area:977} paient chacune 100 de {faction:369} : {quest:8366} (10 de chaque pirate) et {quest:8365} (20 chapeaux de pirate des Mers du Sud, un pirate sur dix). À partir du niveau 56, les pirates sont gris et rapportent peu : passez alors cette étape.",

	-- Step 6: Tinkee Steamboil
	-- {npc:10267} Tinkee Steamboil · {area:251} Flame Crest · {zone:1428} Burning Steppes · {faction:577} Everlook · {item:12284} Draco-Incarcinatrix 900 · {quest:4726} Broodling Essence
	-- plural, as words: Scalding Broodlings = {npc:7048} Scalding Broodling · Flamescale Broodlings = {npc:7049} Flamescale Broodling · Black Broodlings = {npc:7047} Black Broodling
	["{npc:10267}, a goblin at {area:251} in the north of the {zone:1428}, has a chain that pays every town 150 and {faction:577} 150 more. Use her {item:12284} on a broodling, kill it while the device holds it, and pick up the {quest:4726} it leaves. The device takes only Black and Scalding Broodlings, not the Flamescale Broodlings of the west: Scalding Broodlings (level 53-54) roam just west and east of {area:251}, Black Broodlings (51-52) the north-east corner of the zone, the thickest group. They are few and spread out: the path passes both and ends among the Black Broodlings."] = "{npc:10267}, une gobeline à la {area:251} au nord des {zone:1428}, a une suite de quêtes qui paie 150 à chaque ville et 150 de plus à {faction:577}. Utilisez son {item:12284} sur un rejeton, tuez-le pendant que l'appareil le retient et ramassez l'essence ({quest:4726}) qu'il laisse. L'appareil ne prend que les Rejetons noirs et brûlants, pas les Rejetons Flammécaille de l'ouest : les Rejetons brûlants (niveau 53-54) rôdent juste à l'ouest et à l'est de la {area:251}, les Rejetons noirs (51-52) dans le coin nord-est de la zone, le groupe le plus dense. Ils sont peu nombreux et dispersés : le trajet passe par les deux et finit parmi les Rejetons noirs.",
	-- {area:251} Flame Crest
	-- plural, as words: Scalding Broodlings = {npc:7048} Scalding Broodling
	["Scalding Broodlings west of {area:251}"] = "Rejetons brûlants à l'ouest de la {area:251}",
	-- {area:251} Flame Crest
	-- plural, as words: Scalding Broodlings = {npc:7048} Scalding Broodling
	["Scalding Broodlings east of {area:251}"] = "Rejetons brûlants à l'est de la {area:251}",
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["Black Broodlings in the north-east"] = "Rejetons noirs au nord-est",
	-- {item:12284} Draco-Incarcinatrix 900 · {npc:7048} Scalding Broodling
	["{item:12284}, on a Black or {npc:7048}"] = "{item:12284}, sur un Rejeton noir ou un {npc:7048}",
	-- {quest:4726} Broodling Essence
	["{quest:4726}, left by the broodlings"] = "{quest:4726}, laissée par les rejetons",
	["100 to every town"] = "100 pour chaque ville",

	-- Step 7: Everlook: Felnok Steelspring
	-- {quest:4808} Felnok Steelspring · {faction:577} Everlook
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["{quest:4808} is in {faction:577}. The Chillwind Chimaeras (level 55-57) south-west of {faction:577} drop the horns one time in five."] = "{quest:4808} est à {faction:577}. Les Chimères Noroît (niveau 55-57) au sud-ouest de {faction:577} laissent les cornes une fois sur cinq.",
	-- {item:12444} Uncracked Chillwind Horn
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["{item:12444}: Chillwind Chimaeras"] = "{item:12444} : Chimères Noroît",

	-- Step 8: Back to Tinkee Steamboil
	-- {npc:10267} Tinkee Steamboil
	["Back to {npc:10267}"] = "Retour auprès de {npc:10267}",
	-- {quest:4810} Return to Tinkee
	["{quest:4810} gives 50 to every town. Her later quests, Egg Freezing (150 to every town) and Egg Collection (200), are done in the Rookery of Upper Blackrock Spire, a ten-player dungeon: take them up with your group."] = "{quest:4810} donne 50 à chaque ville. Ses quêtes suivantes, Un oeuf congelé (150 pour chaque ville) et La collecte d'oeufs (200), se font dans la couveuse du sommet du pic Rochenoire, un donjon à dix joueurs : faites-les avec votre groupe.",

	-- Step 9: Dire Maul North: Knot Thimblejack
	-- {npc:14338} Knot Thimblejack
	["Dire Maul North: {npc:14338}"] = "Hache-Tripes Nord : {npc:14338}",
	-- {npc:14338} Knot Thimblejack · {item:18250} Gordok Shackle Key · {npc:14321} Guard Fengus · {item:18258} Gordok Ogre Suit · {item:8170} Rugged Leather · {item:14341} Rune Thread · {item:18240} Ogre Tannin
	["{npc:14338} sits shackled in Dire Maul North, the Gordok ogres' wing (a five-player dungeon from level 57: group up). Every {item:18250} frees him once: 150 to every town, and he is shackled again on your next run. Gordok ogres drop the keys (about one in fifteen; {npc:14321} one in seven): a full run of the wing usually brings one. His {item:18258} pays 100 the first time and 50 after, for 4 Bolts of Runecloth, 8 {item:8170}, 2 {item:14341} and the {item:18240} from the basket in the wing. Under 57 when you get here? Unskip this step later."] = "{npc:14338} est enchaîné dans Hache-Tripes Nord, l'aile des ogres Gordok (un donjon à cinq joueurs dès le niveau 57 : formez un groupe). Chaque {item:18250} le libère une fois : 150 pour chaque ville, et il est de nouveau enchaîné à votre visite suivante. Les ogres Gordok laissent les clés (environ une sur quinze ; {npc:14321} une sur sept) : un tour complet de l'aile en donne généralement une. Sa {item:18258} rapporte 100 la première fois et 50 ensuite, contre 4 rouleaux d'étoffe runique, 8 {item:8170}, 2 {item:14341} et le {item:18240} du panier de l'aile. Moins de 57 en arrivant ici ? Réactivez cette étape plus tard.",
	-- {item:18250} Gordok Shackle Key
	["{item:18250}, Gordok ogres"] = "{item:18250}, ogres Gordok",
	-- {quest:5525} Free Knot!
	["{quest:5525}: 150 to every town"] = "{quest:5525} : 150 pour chaque ville",
	-- {quest:5525} Free Knot!
	["{quest:5525}, again on every later run: 150"] = "{quest:5525}, à nouveau à chaque visite suivante : 150",

	-- Step 10: Every town to Friendly
	["Every town to Friendly"] = "Chaque ville jusqu'à Amical",
	-- {npc:14637} Zorbin Fandazzle · {npc:10267} Tinkee Steamboil · {faction:470} Ratchet · {zone:1413} Barrens · {npc:3446} Mebok Mizzyrix · {faction:21} Booty Bay · {zone:1418} Badlands · {area:327} Faldir's Cove · {faction:369} Gadgetzan · {zone:1446} Tanaris · {item:8548} Divino-matic Rod · {faction:577} Everlook · {zone:1452} Winterspring · {npc:9298} Donova Snowden · {zone:1411} Durotar · {zone:1455} Ironforge
	["Neutral 500 to Friendly is 2,500 with each town. The quests above pay every town up to 700 ({npc:14637}'s two 300, {npc:10267}'s 150, the first Free Knot 150 and the first Ogre Suit 100); {npc:14637}'s repeatables do the rest, 25 to every town each: 10 residue (ten giants) or 6 cores (about twelve elementals). The towns' own quests count too, each giving the other towns half: {faction:470}'s in the {zone:1413} (levels 10-25, about 4,300: the Samophlange chain 625, {npc:3446}'s errands, the Wizzlecrank and Gilthares escorts 150 each), {faction:21}'s in Stranglethorn, Arathi and the {zone:1418} (30-50, about 6,500: the three OOX robot rescues 250 each, An OOX of Your Own 200, Stranglethorn Fever 200, Facing Negolash 200, the Sunken Treasure chain at {area:327}), {faction:369}'s in {zone:1446} (43-55, about 3,000: the {item:8548} 200, Wastewander Justice 100 each, the WANTED posters) and {faction:577}'s in {zone:1452} (52-60, about 1,450: {npc:9298}'s Winterfall chain, Umi's yeti quests). Forever adds a few low ones: A Simmering Storm and Stormy Potential in {zone:1411} and WANTED: Bruuz ({faction:470} 100 each), Important Heirlooms in {zone:1455} ({faction:369} 100). Forever pays them in full at any level. Kills help while they are not grey, 5 each: Southsea pirates in the {zone:1413} for {faction:470} and in {zone:1446} for {faction:369} and Stranglethorn's Venture Co. camps for {faction:21}, up to the end of Honored; Wastewander bandits for {faction:369} and Bloodsail pirates for {faction:21} only up to the end of Neutral. Friendly opens each quartermaster's first gear."] = "",
	-- {quest:7725} Again With the Zapped Giants
	["{quest:7725}: 10 residue"] = "{quest:7725} : 10 résidus",
	["25 to every town"] = "25 pour chaque ville",
	-- {quest:7726} Refuel for the Zapping
	["{quest:7726}: 6 cores"] = "{quest:7726} : 6 noyaux",

	-- Step 11: Every town to Honored
	["Every town to Honored"] = "Chaque ville jusqu'à Honoré",
	-- {npc:14637} Zorbin Fandazzle · {item:18250} Gordok Shackle Key
	["Friendly to Honored is 6,000: 240 of {npc:14637}'s turn-ins, or 40 Free Knot runs, or a mix. Nothing can be saved up: residue and cores drop only while their quest is in your log, and you can carry one {item:18250} at a time, so hand each in before the next run. Honored opens each quartermaster's blue items."] = "D'Amical à Honoré, il faut 6 000 : 240 remises à {npc:14637}, ou 40 visites Libérez Knot !, ou un mélange. Rien ne se met de côté : résidus et noyaux ne tombent que si leur quête est dans votre journal, et vous ne pouvez porter qu'une {item:18250} à la fois : rendez-la avant la visite suivante. Honoré débloque les objets bleus de chaque intendant.",

	-- Step 12: Every town to Revered
	["Every town to Revered"] = "Chaque ville jusqu'à Révéré",
	-- {npc:14637} Zorbin Fandazzle
	["Honored to Revered is 12,000 more: 480 of {npc:14637}'s turn-ins (4,800 residue) or 80 Free Knot runs. Revered opens the five cosmetic hats, the reason most players do this. Legacy Diplomat adds up to 10%."] = "D'Honoré à Révéré, il faut 12 000 de plus : 480 remises à {npc:14637} (4 800 résidus) ou 80 visites Libérez Knot !. Révéré débloque les cinq chapeaux cosmétiques, la raison pour laquelle la plupart des joueurs font tout cela. Diplomate de l'Héritage ajoute jusqu'à 10 %.",

	-- Step 13: Ratchet: Winklespark
	-- {npc:265574} Winklespark · {faction:470} Ratchet · {item:274740} Quilted Cloak · {item:274741} Rumpled Kilt · {item:274742} Ratchet Wristwraps · {item:274743} Defective Samophlange · {item:274744} Barrens Basher · {item:274021} Barrens Headband
	["{npc:265574}, {faction:470}'s quartermaster, by the docks. Friendly, level 20 gear: {item:274740} 41s (Stamina, Agility), {item:274741} 54s (Stamina, spell power), {item:274742} 34s (Intellect, Agility). Honored: {item:274743}, an off-hand, 66s (Intellect, Spirit); {item:274744}, a one-handed mace, 1g 65s (Stamina, Strength). Revered: the {item:274021}, a cosmetic hat, 2g."] = "{npc:265574}, l'intendant de {faction:470}, près des quais. Amical, équipement de niveau 20 : {item:274740} 41 pa (Endurance, Agilité), {item:274741} 54 pa (Endurance, puissance des sorts), {item:274742} 34 pa (Intelligence, Agilité). Honoré : {item:274743}, une main gauche, 66 pa (Intelligence, Esprit) ; {item:274744}, une masse à une main, 1 po 65 pa (Endurance, Force). Révéré : {item:274021}, un chapeau cosmétique, 2 po.",
	-- {item:274740} Quilted Cloak
	["{item:274740}, Friendly"] = "{item:274740}, Amical",
	-- {item:274741} Rumpled Kilt
	["{item:274741}, Friendly"] = "{item:274741}, Amical",
	-- {item:274742} Ratchet Wristwraps
	["{item:274742}, Friendly"] = "{item:274742}, Amical",
	-- {item:274743} Defective Samophlange
	["{item:274743}, Honored"] = "{item:274743}, Honoré",
	-- {item:274744} Barrens Basher
	["{item:274744}, Honored"] = "{item:274744}, Honoré",
	-- {item:274021} Barrens Headband
	["{item:274021}, Revered"] = "{item:274021}, Révéré",

	-- Step 14: Booty Bay: Gezzy Gunkgear
	-- {npc:265575} Gezzy Gunkgear · {faction:21} Booty Bay · {item:274745} Deckswabber's Mitts · {item:274746} Sea Giant's Toe Ring · {item:274747} Soggy Boots · {item:274748} Booty Bay Bruiser's Buckshot · {item:274749} Souvenir Sea Shell · {item:274022} Tough Guy's Eyepatch
	["{npc:265575}, {faction:21}'s quartermaster. Friendly, level 30 gear: {item:274745} 1g 10s (Strength, Agility), {item:274746} 1g 48s (healing and spell damage), {item:274747} 1g 3s (Intellect, Spirit). Honored: {item:274748}, a gun, 3g 11s (attack power, Stamina); {item:274749}, a necklace, 1g 66s (health regeneration, Stamina). Revered: {item:274022}, 5g."] = "",
	-- {item:274745} Deckswabber's Mitts
	["{item:274745}, Friendly"] = "{item:274745}, Amical",
	-- {item:274746} Sea Giant's Toe Ring
	["{item:274746}, Friendly"] = "{item:274746}, Amical",
	-- {item:274747} Soggy Boots
	["{item:274747}, Friendly"] = "{item:274747}, Amical",
	-- {item:274748} Booty Bay Bruiser's Buckshot
	["{item:274748}, Honored"] = "{item:274748}, Honoré",
	-- {item:274749} Souvenir Sea Shell
	["{item:274749}, Honored"] = "",
	-- {item:274022} Tough Guy's Eyepatch
	["{item:274022}, Revered"] = "{item:274022}, Révéré",

	-- Step 15: Gadgetzan: Rettrick
	-- {npc:265576} Rettrick · {faction:369} Gadgetzan · {item:274750} Reflective Wristguards · {item:274751} Sunburn Spaulders · {item:274752} Sandstorm Cover · {item:274753} Jhordy's Misplaced Screwdriver · {item:274754} Suspicious Spare Part · {item:274023} Stolen Wastewander Cowl
	["{npc:265576}, {faction:369}'s quartermaster. Friendly, level 40 gear: {item:274750} 2g 74s (Intellect, healing, spell damage), {item:274751} 2g 94s (Agility, attack power), {item:274752}, a cloak, 2g 36s (Spirit, spell power). Honored: {item:274753}, a one-handed weapon, 9g 46s (Strength, Agility); {item:274754}, a ring, 3g 80s (Strength, Stamina). Revered: the {item:274023}, 10g."] = "{npc:265576}, l'intendant de {faction:369}. Amical, équipement de niveau 40 : {item:274750} 2 po 74 pa (Intelligence, soins, dégâts des sorts), {item:274751} 2 po 94 pa (Agilité, puissance d'attaque), {item:274752}, une cape, 2 po 36 pa (Esprit, puissance des sorts). Honoré : {item:274753}, une arme à une main, 9 po 46 pa (Force, Agilité) ; {item:274754}, un anneau, 3 po 80 pa (Force, Endurance). Révéré : {item:274023}, 10 po.",
	-- {item:274750} Reflective Wristguards
	["{item:274750}, Friendly"] = "{item:274750}, Amical",
	-- {item:274751} Sunburn Spaulders
	["{item:274751}, Friendly"] = "{item:274751}, Amical",
	-- {item:274752} Sandstorm Cover
	["{item:274752}, Friendly"] = "{item:274752}, Amical",
	-- {item:274753} Jhordy's Misplaced Screwdriver
	["{item:274753}, Honored"] = "{item:274753}, Honoré",
	-- {item:274754} Suspicious Spare Part
	["{item:274754}, Honored"] = "{item:274754}, Honoré",
	-- {item:274023} Stolen Wastewander Cowl
	["{item:274023}, Revered"] = "{item:274023}, Révéré",

	-- Step 16: Everlook: Zippie Fizzbolt
	-- {npc:265577} Zippie Fizzbolt · {faction:577} Everlook · {item:274755} Steamwheedle Grips · {item:274756} Impractical Headwarmer · {item:274757} Substandard Belt Chain · {item:274758} Coldmetal Guard · {item:274759} Everlook Pathcarver · {item:274760} Everlook Delivery Bot · {item:274761} Parachute-Priest Pager · {item:274024} Fizzbolt's Fashionable Fedora
	["{npc:265577}, {faction:577}'s quartermaster. Friendly, level 50 gear: {item:274755} 3g 10s (Spirit, Intellect), {item:274756} 5g 84s (Agility, Stamina, frost resistance), {item:274757} 4g 68s (Agility, attack power), {item:274758}, a chest, 10g 96s (Strength, Stamina). Honored, three trinkets at about 7g 55s: {item:274759} (nature resistance), {item:274760} (frost resistance) and {item:274761} (shadow resistance), the last two with a use. Revered: {item:274024}, 25g."] = "{npc:265577}, l'intendante de {faction:577}. Amical, équipement de niveau 50 : {item:274755} 3 po 10 pa (Esprit, Intelligence), {item:274756} 5 po 84 pa (Agilité, Endurance, résistance au givre), {item:274757} 4 po 68 pa (Agilité, puissance d'attaque), {item:274758}, un torse, 10 po 96 pa (Force, Endurance). Honoré, trois bijoux à environ 7 po 55 pa : {item:274759} (résistance à la nature), {item:274760} (résistance au givre) et {item:274761} (résistance à l'ombre), les deux derniers avec un effet à l'utilisation. Révéré : {item:274024}, 25 po.",
	-- {item:274755} Steamwheedle Grips
	["{item:274755}, Friendly"] = "{item:274755}, Amical",
	-- {item:274756} Impractical Headwarmer
	["{item:274756}, Friendly"] = "{item:274756}, Amical",
	-- {item:274757} Substandard Belt Chain
	["{item:274757}, Friendly"] = "{item:274757}, Amical",
	-- {item:274758} Coldmetal Guard
	["{item:274758}, Friendly"] = "{item:274758}, Amical",
	-- {item:274759} Everlook Pathcarver
	["{item:274759}, Honored"] = "{item:274759}, Honoré",
	-- {item:274760} Everlook Delivery Bot
	["{item:274760}, Honored"] = "{item:274760}, Honoré",
	-- {item:274761} Parachute-Priest Pager
	["{item:274761}, Honored"] = "{item:274761}, Honoré",
	-- {item:274024} Fizzbolt's Fashionable Fedora
	["{item:274024}, Revered"] = "{item:274024}, Révéré",

	-- Step 17: Powderfuse: Friz Frazzlespark
	-- {npc:255897} Friz Frazzlespark · {faction:2827} Powderfuse · {area:16727} Powderfuse Port · {zone:2548} Riverglades · {item:276200} Crawler's Clackers · {item:276201} Misplaced Pantaloons · {item:276202} Disengagement Ring · {item:276203} Primitive Fishing Pole · {item:276204} Thrash's Trash · {item:276199} Haughty Fellow's Monocle
	["{npc:255897} sells {faction:2827}'s rewards in {area:16727}, on the east coast of the {zone:2548}, alongside general goods. Friendly, level 40 gear: {item:276200} 2g 74s (Stamina, attack power), {item:276201} 2g 94s (Intellect, Spirit), {item:276202} 2g 36s (Agility, Spirit). Honored: {item:276203}, a two-handed weapon, 9g 46s (Stamina, Strength, Agility); {item:276204}, a shield, 3g 80s (Stamina, spell damage, healing). Revered: {item:276199}, 10g."] = "{npc:255897} vend les récompenses de {faction:2827} à {area:16727}, sur la côte est de {zone:2548}, avec des fournitures générales. Amical, équipement de niveau 40 : {item:276200} 2 po 74 pa (Endurance, puissance d'attaque), {item:276201} 2 po 94 pa (Intelligence, Esprit), {item:276202} 2 po 36 pa (Agilité, Esprit). Honoré : {item:276203}, une arme à deux mains, 9 po 46 pa (Endurance, Force, Agilité) ; {item:276204}, un bouclier, 3 po 80 pa (Endurance, dégâts des sorts, soins). Révéré : {item:276199}, 10 po.",
	-- {item:276200} Crawler's Clackers
	["{item:276200}, Friendly"] = "{item:276200}, Amical",
	-- {item:276201} Misplaced Pantaloons
	["{item:276201}, Friendly"] = "{item:276201}, Amical",
	-- {item:276202} Disengagement Ring
	["{item:276202}, Friendly"] = "{item:276202}, Amical",
	-- {item:276203} Primitive Fishing Pole
	["{item:276203}, Honored"] = "{item:276203}, Honoré",
	-- {item:276204} Thrash's Trash
	["{item:276204}, Honored"] = "{item:276204}, Honoré",
	-- {item:276199} Haughty Fellow's Monocle
	["{item:276199}, Revered"] = "{item:276199}, Révéré",

	-- Step 18: Every town to Exalted
	["Every town to Exalted"] = "Chaque ville jusqu'à Exalté",
	-- {npc:14637} Zorbin Fandazzle
	["Revered to Exalted is 21,000 more with each town: 840 of {npc:14637}'s turn-ins or 140 Free Knot runs. No quartermaster sells anything for Exalted: this is for the title bar only."] = "De Révéré à Exalté, il faut 21 000 de plus avec chaque ville : 840 remises à {npc:14637} ou 140 visites Libérez Knot !. Aucun intendant ne vend quoi que ce soit à Exalté : c'est seulement pour la barre de réputation.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Five goblin towns share one reputation family, the Steamwheedle Cartel: {faction:470}, {faction:21}, {faction:369}, {faction:577} and Forever's new {faction:2827} in the {zone:2548}. Everyone starts each at Neutral (500 into it). A gain with one town gives the others half as much; a quest for the Cartel itself, like {npc:14637}'s, pays every town in full. Losses spread the same way: a {npc:4624} or any goblin of the towns costs 125 (half that with the other towns), and Bloodsail Buccaneers reputation is earned only that way. {npc:14637} camps on the road through central {zone:1444} and works for anyone, even players the goblins hate. His first two quests are level 48: in Classic they paid less once you were 6 or more levels above them (a fifth at 57 and up), but they open his repeatables, which are level 55 and pay in full at 60."] = "Cinq villes gobelines partagent une même famille de réputation, le Cartel Gentepression : {faction:470}, {faction:21}, {faction:369}, {faction:577} et la nouvelle {faction:2827} de Forever, dans {zone:2548}. Tout le monde commence chacune à Neutre (500 points dedans). Un gain avec une ville en donne moitié moins aux autres ; une quête pour le Cartel lui-même, comme celles de {npc:14637}, paie chaque ville en entier. Les pertes se répartissent de la même façon : un {npc:4624} ou n'importe quel gobelin des villes coûte 125 (moitié moins avec les autres villes), et c'est la seule façon de gagner de la réputation auprès de la Voile sanglante. {npc:14637} campe sur la route qui traverse le centre de {zone:1444} et travaille pour tout le monde, même pour les joueurs que les gobelins détestent. Ses deux premières quêtes sont de niveau 48 : dans Classic, elles rapportaient moins dès que vous aviez 6 niveaux ou plus au-dessus (un cinquième à partir de 57), mais elles débloquent ses quêtes répétables, de niveau 55, qui paient en entier au niveau 60.",
	-- ["Neutral 500 to Friendly is 2,500 with each town. The quests above pay every town up to 700 ({npc:14637}'s two 300, {npc:10267}'s 150, the first Free Knot 150 and the first Ogre Suit 100; less when you are well above their level); {npc:14637}'s repeatables do the rest, 25 to every town each: 10 residue (ten giants) or 6 cores (about twelve elementals). The towns' own quests count too, each giving the other towns half: {faction:470}'s in the {zone:1413} (levels 10-25, about 4,300: the Samophlange chain 625, {npc:3446}'s errands, the Wizzlecrank and Gilthares escorts 150 each), {faction:21}'s in Stranglethorn, Arathi and the {zone:1418} (30-50, about 6,500: the three OOX robot rescues 250 each, An OOX of Your Own 200, Stranglethorn Fever 200, Facing Negolash 200, the Sunken Treasure chain at {area:327}), {faction:369}'s in {zone:1446} (43-55, about 3,000: the {item:8548} 200, Wastewander Justice 100 each, the WANTED posters) and {faction:577}'s in {zone:1452} (52-60, about 1,450: {npc:9298}'s Winterfall chain, Umi's yeti quests). Forever adds a few low ones: A Simmering Storm and Stormy Potential in {zone:1411} and WANTED: Bruuz ({faction:470} 100 each), Important Heirlooms in {zone:1455} ({faction:369} 100). In Classic they pay in full only while at most 5 levels below you; past that each level takes a fifth off, down to a fifth. Kills help while they are not grey, 5 each: Southsea pirates in the {zone:1413} for {faction:470} and in {zone:1446} for {faction:369} and Stranglethorn's Venture Co. camps for {faction:21}, up to the end of Honored; Wastewander bandits for {faction:369} and Bloodsail pirates for {faction:21} only up to the end of Neutral. Friendly opens each quartermaster's first gear."] = "De Neutre 500 à Amical, il faut 2 500 avec chaque ville. Les quêtes ci-dessus paient chaque ville jusqu'à 700 (les deux de {npc:14637} 300, celles de {npc:10267} 150, le premier Libérez Knot ! 150 et la première tenue d'ogre 100 ; moins quand vous les dépassez largement en niveau) ; les répétables de {npc:14637} font le reste, 25 pour chaque ville à chaque fois : 10 résidus (dix géants) ou 6 noyaux (environ douze élémentaires). Les quêtes propres aux villes comptent aussi, chacune donnant moitié aux autres villes : celles de {faction:470} dans les {zone:1413} (niveaux 10-25, environ 4 300 : la suite du Samophlange 625, les courses de {npc:3446}, les escortes de Wizzlecrank et de Gilthares 150 chacune), celles de {faction:21} à Strangleronce, en Arathi et dans les {zone:1418} (30-50, environ 6 500 : les trois sauvetages de robots OOX 250 chacun, Un OOX rien que pour vous 200, La fièvre de Strangleronce 200, Face à Negolash 200, la suite Le trésor englouti à la {area:327}), celles de {faction:369} en {zone:1446} (43-55, environ 3 000 : le {item:8548} 200, Châtier les Bat-le-désert 100 chacune, les avis de recherche) et celles de {faction:577} au {zone:1452} (52-60, environ 1 450 : la suite Tombe-hiver de {npc:9298}, les quêtes de yétis d'Umi). Forever en ajoute quelques-unes de bas niveau : A Simmering Storm et Stormy Potential à {zone:1411} et WANTED: Bruuz ({faction:470} 100 chacune), Important Heirlooms à {zone:1455} ({faction:369} 100). Dans Classic, elles ne paient en entier que tant qu'elles sont au plus 5 niveaux sous le vôtre ; au-delà, chaque niveau retire un cinquième, jusqu'à un cinquième. Les victimes aident tant qu'elles ne sont pas grises, 5 chacune : les pirates des Mers du Sud dans les {zone:1413} pour {faction:470} et en {zone:1446} pour {faction:369}, et les camps de la KapitalRisk de Strangleronce pour {faction:21}, jusqu'à la fin d'Honoré ; les bandits Bat-le-désert pour {faction:369} et les pirates de la Voile sanglante pour {faction:21} seulement jusqu'à la fin de Neutre. Amical débloque le premier équipement de chaque intendant.",
	-- ["Souvenir Sea Shell, Honored"] = "Souvenir Sea Shell, Honoré",
	-- ["{npc:265575}, {faction:21}'s quartermaster. Friendly, level 30 gear: {item:274745} 1g 10s (Strength, Agility), {item:274746} 1g 48s (healing and spell damage), {item:274747} 1g 3s (Intellect, Spirit). Honored: {item:274748}, a gun, 3g 11s (attack power, Stamina); Souvenir Sea Shell, a necklace, 1g 66s (health regeneration, Stamina). Revered: {item:274022}, 5g."] = "{npc:265575}, l'intendant de {faction:21}. Amical, équipement de niveau 30 : {item:274745} 1 po 10 pa (Force, Agilité), {item:274746} 1 po 48 pa (soins et dégâts des sorts), {item:274747} 1 po 3 pa (Intelligence, Esprit). Honoré : {item:274748}, une arme à feu, 3 po 11 pa (puissance d'attaque, Endurance) ; Souvenir Sea Shell, un collier, 1 po 66 pa (régénération de vie, Endurance). Révéré : {item:274022}, 5 po.",
}
