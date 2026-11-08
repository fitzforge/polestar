-- French (frFR): the guide forever/reputation/alterac-valley (forever/reputation/alterac-valley.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Alterac Valley Reputation"] = "Réputation : Vallée d'Alterac",
	["One-time quests worth 2,000 and big wins make it the quickest of the four; Exalted gives a Legacy Point."] = "Des quêtes uniques qui rapportent 2 000 et de grosses victoires en font la plus rapide des quatre ; Exalté donne un point d'héritage.",
	["Master of Alterac Valley: a Legacy Point at Exalted"] = "Master of Alterac Valley : un point d'héritage à Exalté",

	-- Step 1: Lieutenant Rotimer
	-- {zone:1459} Alterac Valley · {zone:1455} Ironforge · {npc:13843} Lieutenant Rotimer · {object:32372} Great Forge
	["{zone:1459} is a 40 against 40 battle for level 51 and up, and the fastest of the four battleground reputations: it has about 2,000 reputation of one-time quests, and a full win pays several hundred. The same one-time quests also pay 1,870 {zone:1455} reputation. {npc:13843} recruits outside the {object:32372}. Forever's Legacy Diplomat perk adds up to 10% to every number in this guide."] = "{zone:1459} est une bataille à 40 contre 40 pour le niveau 51 et plus, et la plus rapide des quatre réputations de champs de bataille : elle offre environ 2 000 de réputation en quêtes uniques, et une victoire complète rapporte plusieurs centaines. Les mêmes quêtes uniques rapportent aussi 1 870 de réputation avec {zone:1455}. {npc:13843} recrute devant la {object:32372}. L'atout Diplomate de l'Héritage de Forever ajoute jusqu'à 10 % à chaque chiffre de ce guide.",

	-- Step 2: Lieutenant Haggerdin
	-- {zone:1459} Alterac Valley · {zone:1416} Alterac Mountains
	["The Stormpike camp stands outside the {zone:1459} gate, on the {zone:1416} side above Hillsbrad. Take every quest here: they all pay 100 or more, once."] = "",
	-- {quest:7162} Proving Grounds · {item:17849} Stormpike Banner
	["{quest:7162}: the {item:17849} in Icewing Cavern, 100"] = "",
	-- {npc:13777} Sergeant Durgen Stormpike
	["{npc:13777}: assault a graveyard, 100"] = "{npc:13777} : attaquez un cimetière, 100",
	["destroy a tower or bunker banner, 100"] = "détruisez la bannière d'une tour ou d'un fortin, 100",
	["capture a mine, 100"] = "prenez une mine, 100",

	-- Step 3: Dun Baldar
	["Dun Baldar"] = "",
	["Queue at the gate, at any battlemaster or from the battleground screen; you enter at Dun Baldar in the north. Before the gates open, take the quests in the town: they are done during the battle."] = "",

	-- Step 4: Icewing Cavern
	["Icewing Cavern"] = "",
	-- {item:17849} Stormpike Banner
	["Icewing Cavern lies southwest of Dun Baldar. The {item:17849} stands at the back of the cave, past the yetis and harpies."] = "",

	-- Step 5: The battle
	["The battle"] = "La bataille",
	-- {npc:11946} Drek'Thar · {quest:7223} Armor Scraps · {npc:13154} Commander Louis Philips · {npc:13597} Frostwolf Explosives Expert · {quest:7301} Fallen Sky Lords · {npc:11947} Captain Galvangar
	["Most of this happens on the way to {npc:11946}. Loot {quest:7223} from Horde players and guards you kill. Assault the Snowfall Graveyard or any Horde graveyard, burn a Horde tower (click its banner), and take Coldtooth Mine. {npc:13154} stands at Tower Point; the {npc:13597} at Frostwolf Village. {quest:7301} asks you to find where the three wing commanders landed. In Classic every tower, graveyard or mine paid 12 reputation, {npc:11947} 125 and {npc:11946} about 300."] = "",
	["assault a graveyard"] = "attaquez un cimetière",
	["Iceblood Tower banner"] = "Bannière de la tour de Glace-sang",
	["Coldtooth Mine"] = "",
	-- {npc:13437} Wing Commander Ichman
	["{npc:13437}'s spot"] = "Emplacement de {npc:13437}",
	-- {npc:13439} Wing Commander Vipore
	["{npc:13439}'s spot"] = "Emplacement de {npc:13439}",
	-- {npc:13438} Wing Commander Slidore
	["{npc:13438}'s spot"] = "Emplacement de {npc:13438}",

	-- Step 6: Back in Dun Baldar
	["Back in Dun Baldar"] = "",

	-- Step 7: Back at the gate
	["Back at the gate"] = "De retour à l'entrée",
	-- {npc:15351} Alliance Brigadier General · {npc:13841} Lieutenant Haggerdin · {quest:8375} Remember Alterac Valley! · {zone:1459} Alterac Valley
	["Your first Alterac Valley Marks of Honor go to the {npc:15351} beside {npc:13841}: 150 the first time ({quest:8375}), then 100 for every 3 more. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1459} marks: hand in or spend them before you reach that."] = "Vos premières Marques d'honneur de la vallée d'Alterac vont au {npc:15351}, à côté de {npc:13841} : 150 la première fois ({quest:8375}), puis 100 pour chaque lot de 3 de plus. L'équipement JcJ de Forever coûte aussi des Marques d'honneur en plus de l'honneur : décidez de ce que vous voulez avant de les rendre. Vous pouvez porter au plus 30 marques de {zone:1459} : rendez-les ou dépensez-les avant d'atteindre ce nombre.",
	["Alterac Valley Marks of Honor: play games"] = "Marques d'honneur de la vallée d'Alterac : jouez des parties",

	-- Step 8: Stormpike Guard to Friendly
	-- {faction:730} Stormpike Guard
	["{faction:730} to Friendly"] = "{faction:730} : Amical",
	-- {npc:13816} Prospector Stonehewer · {npc:11946} Drek'Thar · {quest:8271} Hero of the Stormpike
	["{npc:13816} by the gate wants {npc:11946} dead: win a game in which your team kills him. Then he lets you pick a weapon ({quest:8271})."] = "{npc:13816}, près de l'entrée, veut la mort de {npc:11946} : gagnez une partie où votre équipe le tue. Il vous laisse ensuite choisir une arme ({quest:8271}).",
	-- {quest:8271} Hero of the Stormpike
	["{quest:8271}, 10 and a weapon"] = "{quest:8271}, 10 et une arme",

	-- Step 9: Rise and Be Recognized
	-- {npc:13841} Lieutenant Haggerdin · {item:17354} Master Ryson's All Seeing Eye · {npc:12159} Korrak the Bloodrager · {item:19032} Stormpike Battle Tabard · {npc:13217} Thanthaldis Snowgleam
	["Friendly lets {npc:13841} upgrade your insignia: 100 reputation. Friendly to Honored is 6000 reputation. In Classic a full win paid 300 to 700 with its 3 marks; the Brigadier General keeps taking 3 marks for 100. Inside, {item:17354} (75, from the Winterax caves) repeats every game; {npc:12159} (200, when he appears in the middle of the valley) goes back to {npc:13841} here. Friendly opens the {item:19032} (1g) and the Superior Healing and Mana Draughts (5s) at {npc:13217} beside him."] = "Amical permet à {npc:13841} d'améliorer votre insigne : 100 de réputation. D'Amical à Honoré, il faut 6000 de réputation. Dans Classic, une victoire complète rapportait 300 à 700 avec ses 3 marques ; le général de brigade continue de prendre 3 marques pour 100. À l'intérieur, l'{item:17354} (75, dans les grottes des Hache-d'hiver) se répète à chaque partie ; {npc:12159} (200, quand il apparaît au milieu de la vallée) se rend ici à {npc:13841}. Amical débloque le {item:19032} (1 po) et les Breuvages de soins et de mana supérieurs (5 pa) chez {npc:13217}, à côté de lui.",
	-- {item:19032} Stormpike Battle Tabard
	["{item:19032}, 1g"] = "{item:19032}, 1 po",
	-- {npc:15351} Alliance Brigadier General · {quest:8375} Remember Alterac Valley!
	["{npc:15351}: {quest:8375} again, 100 for 3 marks"] = "{npc:15351} : {quest:8375} à nouveau, 100 pour 3 marques",

	-- Step 10: Honored Amongst the Guard
	-- {npc:13217} Thanthaldis Snowgleam · {npc:13841} Lieutenant Haggerdin
	-- plural, as words: Sage's Cloaks = {item:6614} Sage's Cloak
	["Honored: insignia rank 3, 100 reputation. Honored to Revered is 12000 reputation. {npc:13217} beside {npc:13841} sells the Stormpike Soldier's and Sage's Cloaks and Pendants (about 7g each), the Stormpike belts (4g74s to 7g12s) and the Major Healing and Mana Draughts (10s)."] = "Honoré : insigne de grade 3, 100 de réputation. D'Honoré à Révéré, il faut 12000 de réputation. {npc:13217}, à côté de {npc:13841}, vend les Capes et Pendentifs de soldat foudrepique et de sage foudrepique (environ 7 po chacun), les ceintures foudrepiques (4 po 74 pa à 7 po 12 pa) et les Breuvages de soins et de mana majeurs (10 pa).",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: 100 for 3 marks"] = "{npc:15351} : 100 pour 3 marques",

	-- Step 11: Earned Reverence
	-- {npc:13217} Thanthaldis Snowgleam · {item:19100} Electrified Dagger · {item:19102} Crackling Staff · {item:19104} Stormstrike Hammer · {npc:14752} Stormpike Battle Standard · {zone:1459} Alterac Valley · {zone:1461} Arathi Basin · {zone:1460} Warsong Gulch
	["Revered: insignia rank 4, 150 reputation. Revered to Exalted is 21000 reputation, half the climb. Revered opens the weapons at {npc:13217}: {item:19100}, {item:19102} and {item:19104} (31g65s to 39g85s), and the {npc:14752} (5g). At 51 and up Concerted Efforts (3 marks each from {zone:1459}, {zone:1461} and {zone:1460}) pays 200 the first time and 150 after, plus reputation for the other two battlegrounds."] = "Révéré : insigne de grade 4, 150 de réputation. De Révéré à Exalté, il faut 21000 de réputation, la moitié de l'ascension. Révéré débloque les armes chez {npc:13217} : {item:19100}, {item:19102} et {item:19104} (31 po 65 pa à 39 po 85 pa), et l'{npc:14752} (5 po). Au niveau 51 et plus, Des efforts concertés (3 marques de chacun : {zone:1459}, {zone:1461} et {zone:1460}) rapporte 200 la première fois et 150 ensuite, plus de la réputation pour les deux autres champs de bataille.",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: Concerted Efforts"] = "{npc:15351} : Des efforts concertés",
	-- {npc:13217} Thanthaldis Snowgleam
	["{npc:13217}: Revered rewards"] = "{npc:13217} : récompenses Révéré",

	-- Step 12: Legendary Heroes
	-- {npc:13217} Thanthaldis Snowgleam · {item:19030} Stormpike Battle Charger · {item:19325} Don Julio's Band · {item:21563} Don Rodrigo's Band · {item:19323} The Unstoppable Force · {item:19321} The Immovable Object · {item:19324} The Lobotomizer
	["Exalted gives the Legacy Point \"Master of Alterac Valley\" and the last two insignia, 400 reputation that no longer counts for anything but the insignia. {npc:13217} sells the {item:19030} (200g, level 60; its own guide), {item:19325} and {item:21563} (75g56s), {item:19323} (156g49s), {item:19321} (79g53s), {item:19324} (125g66s) and the 50g tomes and off-hands."] = "Exalté donne le point d'héritage « Master of Alterac Valley » et les deux derniers insignes, 400 de réputation qui ne comptent plus que pour les insignes. {npc:13217} vend le {item:19030} (200 po, niveau 60 ; il a son propre guide), l'{item:19325} et l'{item:21563} (75 po 56 pa), {item:19323} (156 po 49 pa), {item:19321} (79 po 53 pa), {item:19324} (125 po 66 pa) et les tomes et objets en main gauche à 50 po.",
	-- {npc:13217} Thanthaldis Snowgleam
	["{npc:13217}: Exalted rewards"] = "{npc:13217} : récompenses Exalté",

	-- Step 13: Frostwolf Ambassador Rokhstrom
	-- {zone:1459} Alterac Valley · {zone:1454} Orgrimmar · {npc:13842} Frostwolf Ambassador Rokhstrom · {object:172982} Valley of Strength
	["{zone:1459} is a 40 against 40 battle for level 51 and up, and the fastest of the four battleground reputations: it has about 2,000 reputation of one-time quests, and a full win pays several hundred. The same one-time quests also pay 1,870 {zone:1454} reputation. {npc:13842} stands in the {object:172982}. Forever's Legacy Diplomat perk adds up to 10% to every number in this guide."] = "{zone:1459} est une bataille à 40 contre 40 pour le niveau 51 et plus, et la plus rapide des quatre réputations de champs de bataille : elle offre environ 2 000 de réputation en quêtes uniques, et une victoire complète rapporte plusieurs centaines. Les mêmes quêtes uniques rapportent aussi 1 870 de réputation avec {zone:1454}. {npc:13842} se tient dans la {object:172982}. L'atout Diplomate de l'Héritage de Forever ajoute jusqu'à 10 % à chaque chiffre de ce guide.",

	-- Step 14: Warmaster Laggrond
	-- {zone:1459} Alterac Valley · {zone:1416} Alterac Mountains
	["The Frostwolf camp stands outside the {zone:1459} gate in the {zone:1416}. Take every quest here: they all pay 100 or more, once."] = "Le camp Loup-de-givre se trouve devant l'entrée de {zone:1459}, dans les {zone:1416}. Prenez toutes les quêtes ici : elles rapportent toutes 100 ou plus, une seule fois.",
	-- {quest:7161} Proving Grounds · {item:17850} Frostwolf Banner
	["{quest:7161}: the {item:17850} in Wildpaw Cavern, 100"] = "",
	-- {npc:13776} Corporal Teeka Bloodsnarl
	["{npc:13776}: assault a graveyard, 100"] = "{npc:13776} : attaquez un cimetière, 100",
	["capture a tower or bunker, 100"] = "prenez une tour ou un fortin, 100",

	-- Step 15: Frostwolf Village
	["Frostwolf Village"] = "",
	["Queue at the gate, at any battlemaster or from the battleground screen; you enter at Frostwolf Village in the south. Before the gates open, take the quests in the village: they are done during the battle."] = "",

	-- Step 16: Wildpaw Cavern
	["Wildpaw Cavern"] = "",
	-- {item:17850} Frostwolf Banner
	["Wildpaw Cavern lies south of Frostwolf Keep. The {item:17850} stands at the back of the cave, past the gnolls."] = "",

	-- Step 17: The battle
	-- {npc:11948} Vanndar Stormpike · {item:17422} Armor Scraps · {npc:13320} Commander Karl Philips · {npc:13598} Stormpike Explosives Expert · {quest:7302} Fallen Sky Lords · {npc:11949} Captain Balinda Stonehearth
	["Most of this happens on the way to {npc:11948}. Loot {item:17422} from Alliance players and guards you kill. Assault the Snowfall Graveyard or any Alliance graveyard, burn an Alliance bunker (click its banner), and take Irondeep Mine. {npc:13320} stands at Icewing Bunker; the {npc:13598} in Dun Baldar. {quest:7302} asks you to find where the three wing commanders landed. In Classic every tower, graveyard or mine paid 12 reputation, {npc:11949} 125 and Vanndar about 300."] = "",
	["Stonehearth Bunker banner"] = "",
	["Irondeep Mine"] = "",
	-- {npc:13179} Wing Commander Guse
	["{npc:13179}'s spot"] = "Emplacement de {npc:13179}",
	-- {npc:13180} Wing Commander Jeztor
	["{npc:13180}'s spot"] = "Emplacement de {npc:13180}",
	-- {npc:13181} Wing Commander Mulverick
	["{npc:13181}'s spot"] = "Emplacement de {npc:13181}",

	-- Step 18: Back in Frostwolf Village
	["Back in Frostwolf Village"] = "",

	-- Step 19: Back at the gate
	-- {npc:15350} Horde Warbringer · {quest:8369} Invaders of Alterac Valley · {zone:1459} Alterac Valley
	["Your first Alterac Valley Marks of Honor go to the {npc:15350} by the gate: 150 the first time ({quest:8369}), then 100 for every 3 more. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1459} marks: hand in or spend them before you reach that."] = "Vos premières Marques d'honneur de la vallée d'Alterac vont au {npc:15350}, près de l'entrée : 150 la première fois ({quest:8369}), puis 100 pour chaque lot de 3 de plus. L'équipement JcJ de Forever coûte aussi des Marques d'honneur en plus de l'honneur : décidez de ce que vous voulez avant de les rendre. Vous pouvez porter au plus 30 marques de {zone:1459} : rendez-les ou dépensez-les avant d'atteindre ce nombre.",

	-- Step 20: Frostwolf Clan to Friendly
	-- {faction:729} Frostwolf Clan
	["{faction:729} to Friendly"] = "{faction:729} : Amical",
	-- {npc:13817} Voggah Deathgrip · {npc:11948} Vanndar Stormpike · {quest:8272} Hero of the Frostwolf
	["{npc:13817} by the gate wants {npc:11948} dead: win a game in which your team kills him. Then he lets you pick a weapon ({quest:8272})."] = "{npc:13817}, près de l'entrée, veut la mort de {npc:11948} : gagnez une partie où votre équipe le tue. Il vous laisse ensuite choisir une arme ({quest:8272}).",
	-- {quest:8272} Hero of the Frostwolf
	["{quest:8272}, 10 and a weapon"] = "{quest:8272}, 10 et une arme",

	-- Step 21: Rise and Be Recognized
	-- {npc:13840} Warmaster Laggrond · {item:17354} Master Ryson's All Seeing Eye · {item:19031} Frostwolf Battle Tabard · {npc:13219} Jekyll Flandring
	["Friendly lets {npc:13840} upgrade your insignia: 100 reputation. Friendly to Honored is 6000 reputation. In Classic a full win paid 300 to 700 with its 3 marks; the Warbringer keeps taking 3 marks for 100. Inside, {item:17354} (75, from the Winterax caves) repeats every game; The Legend of Korrak (200, when he appears in the middle of the valley) goes back to {npc:13840} here. Friendly opens the {item:19031} (1g) and the Superior Healing and Mana Draughts (5s) at {npc:13219} beside him."] = "Amical permet à {npc:13840} d'améliorer votre insigne : 100 de réputation. D'Amical à Honoré, il faut 6000 de réputation. Dans Classic, une victoire complète rapportait 300 à 700 avec ses 3 marques ; le Porteguerre continue de prendre 3 marques pour 100. À l'intérieur, l'{item:17354} (75, dans les grottes des Hache-d'hiver) se répète à chaque partie ; La légende de Korrak (200, quand il apparaît au milieu de la vallée) se rend ici à {npc:13840}. Amical débloque le {item:19031} (1 po) et les Breuvages de soins et de mana supérieurs (5 pa) chez {npc:13219}, à côté de lui.",
	-- {item:19031} Frostwolf Battle Tabard
	["{item:19031}, 1g"] = "{item:19031}, 1 po",
	-- {npc:15350} Horde Warbringer · {quest:8369} Invaders of Alterac Valley
	["{npc:15350}: {quest:8369} again, 100 for 3 marks"] = "{npc:15350} : {quest:8369} à nouveau, 100 pour 3 marques",

	-- Step 22: Honored Amongst the Clan
	-- {npc:13219} Jekyll Flandring · {npc:13840} Warmaster Laggrond · {npc:12051} Frostwolf Legionnaire
	["Honored: insignia rank 3, 100 reputation. Honored to Revered is 12000 reputation. {npc:13219} beside {npc:13840} sells the {npc:12051}'s and Advisor's Cloaks and Pendants (about 7g each), the Frostwolf belts (5g9s to 7g66s) and the Major Healing and Mana Draughts (10s)."] = "Honoré : insigne de grade 3, 100 de réputation. D'Honoré à Révéré, il faut 12000 de réputation. {npc:13219}, à côté de {npc:13840}, vend les Capes et Pendentifs de {npc:12051} et de conseiller loup-de-givre (environ 7 po chacun), les ceintures loup-de-givre (5 po 9 pa à 7 po 66 pa) et les Breuvages de soins et de mana majeurs (10 pa).",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: 100 for 3 marks"] = "{npc:15350} : 100 pour 3 marques",

	-- Step 23: Earned Reverence
	-- {npc:13219} Jekyll Flandring · {item:19099} Glacial Blade · {item:19101} Whiteout Staff · {npc:14751} Frostwolf Battle Standard · {zone:1459} Alterac Valley · {zone:1461} Arathi Basin · {zone:1460} Warsong Gulch
	["Revered: insignia rank 4, 150 reputation. Revered to Exalted is 21000 reputation, half the climb. Revered opens the weapons at {npc:13219}: {item:19099}, {item:19101} and Frostbite (31g53s to 39g71s), and the {npc:14751} (5g). At 51 and up For Great Honor (3 marks each from {zone:1459}, {zone:1461} and {zone:1460}) pays 200 the first time and 150 after, plus reputation for the other two battlegrounds."] = "Révéré : insigne de grade 4, 150 de réputation. De Révéré à Exalté, il faut 21000 de réputation, la moitié de l'ascension. Révéré débloque les armes chez {npc:13219} : {item:19099}, {item:19101} et Frimaire (31 po 53 pa à 39 po 71 pa), et l'{npc:14751} (5 po). Au niveau 51 et plus, Pour un grand honneur (3 marques de chacun : {zone:1459}, {zone:1461} et {zone:1460}) rapporte 200 la première fois et 150 ensuite, plus de la réputation pour les deux autres champs de bataille.",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: For Great Honor"] = "{npc:15350} : Pour un grand honneur",
	-- {npc:13219} Jekyll Flandring
	["{npc:13219}: Revered rewards"] = "{npc:13219} : récompenses Révéré",

	-- Step 24: Legendary Heroes
	-- {npc:13219} Jekyll Flandring · {item:19029} Horn of the Frostwolf Howler · {item:19325} Don Julio's Band · {item:21563} Don Rodrigo's Band · {item:19323} The Unstoppable Force · {item:19321} The Immovable Object · {item:19324} The Lobotomizer
	["Exalted gives the Legacy Point \"Master of Alterac Valley\" and the last two insignia, 400 reputation that no longer counts for anything but the insignia. {npc:13219} sells the {item:19029} (200g, level 60; its own guide), {item:19325} and {item:21563} (75g56s), {item:19323} (156g49s), {item:19321} (79g53s), {item:19324} (125g66s) and the 50g tomes and off-hands."] = "Exalté donne le point d'héritage « Master of Alterac Valley » et les deux derniers insignes, 400 de réputation qui ne comptent plus que pour les insignes. {npc:13219} vend la {item:19029} (200 po, niveau 60 ; elle a son propre guide), l'{item:19325} et l'{item:21563} (75 po 56 pa), {item:19323} (156 po 49 pa), {item:19321} (79 po 53 pa), {item:19324} (125 po 66 pa) et les tomes et objets en main gauche à 50 po.",
	-- {npc:13219} Jekyll Flandring
	["{npc:13219}: Exalted rewards"] = "{npc:13219} : récompenses Exalté",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back in {area:2959}"] = "De retour à {area:2959}",
	-- ["Back in {area:2961}"] = "De retour au {area:2961}",
	-- ["Exalted with the {faction:729} earns a Legacy Point."] = "Être exalté auprès du {faction:729} rapporte un point d'héritage.",
	-- ["Exalted with the {faction:730} earns a Legacy Point."] = "Être exalté auprès de la {faction:730} rapporte un point d'héritage.",
	-- ["Full games that kill {npc:11946} after the towers fall pay the most."] = "Les parties complètes où {npc:11946} meurt après la chute des tours rapportent le plus.",
	-- ["Full games that kill {npc:11948} after the towers fall pay the most."] = "Les parties complètes où {npc:11948} meurt après la chute des tours rapportent le plus.",
	-- ["Keep winning {zone:1459}. More Booty! ({npc:13176}), {item:17306} for {npc:13236} (it summons {npc:13256}) and Alterac Ram Hides for the {npc:13441} all repeat."] = "Continuez à gagner {zone:1459}. Plus de butin ! ({npc:13176}), {item:17306} pour {npc:13236} (il invoque {npc:13256}) et les Peaux de bélier d'Alterac ({item:17642}) pour {npc:13441} se répètent tous.",
	-- ["Keep winning {zone:1459}. More Booty! ({npc:13176}), {item:17306} for {npc:13236} (it summons {npc:13256}) and {npc:10990} Hides for the {npc:13441} all repeat."] = "Continuez à gagner {zone:1459}. Plus de butin ! ({npc:13176}), du {item:17306} pour {npc:13236} (il invoque {npc:13256}) et des peaux de {npc:10990} pour le {npc:13441} : tout cela se répète.",
	-- ["Keep winning {zone:1459}. More {quest:7223} ({npc:13257}), Storm Crystals for {npc:13442} (they summon {npc:13419}) and Frostwolf Hides for the {npc:13577} all repeat."] = "Continuez à gagner {zone:1459}. Encore des {quest:7223} ({npc:13257}), des Cristaux de tempête pour {npc:13442} (ils invoquent {npc:13419}) et des Peaux de loup des glaces pour le {npc:13577} : tout cela se répète.",
	-- ["Most of this happens on the way to {npc:11946}. Loot {quest:7223} from Horde players and guards you kill. Assault the {area:3301} or any Horde graveyard, burn a Horde tower (click its banner), and take {area:2963}. {npc:13154} stands at {area:2962}; the {npc:13597} at {area:2961}. {quest:7301} asks you to find where the three wing commanders landed. In Classic every tower, graveyard or mine paid 12 reputation, {npc:11947} 125 and {npc:11946} about 300."] = "L'essentiel se fait en route vers {npc:11946}. Ramassez des {quest:7223} sur les joueurs de la Horde et les gardes que vous tuez. Attaquez le {area:3301} ou n'importe quel cimetière de la Horde, brûlez une tour de la Horde (cliquez sur sa bannière) et prenez la {area:2963}. {npc:13154} se tient à la {area:2962} ; l'{npc:13597} au {area:2961}. {quest:7301} vous demande de trouver où les trois commandants d'escadrille se sont posés. Dans Classic, chaque tour, cimetière ou mine rapportait 12 de réputation, {npc:11947} 125 et {npc:11946} environ 300.",
	-- ["Most of this happens on the way to {npc:11948}. Loot {item:17422} from Alliance players and guards you kill. Assault the {area:3301} or any Alliance graveyard, burn an Alliance bunker (click its banner), and take {area:2957}. {npc:13320} stands at {area:3304}; the {npc:13598} in {area:2959}. {quest:7302} asks you to find where the three wing commanders landed. In Classic every tower, graveyard or mine paid 12 reputation, {npc:11949} 125 and Vanndar about 300."] = "L'essentiel se fait en route vers {npc:11948}. Ramassez des {item:17422} sur les joueurs de l'Alliance et les gardes que vous tuez. Attaquez le {area:3301} ou n'importe quel cimetière de l'Alliance, brûlez un fortin de l'Alliance (cliquez sur sa bannière) et prenez la {area:2957}. {npc:13320} se tient au {area:3304} ; l'{npc:13598} à {area:2959}. {quest:7302} vous demande de trouver où les trois commandants d'escadrille se sont posés. Dans Classic, chaque tour, cimetière ou mine rapportait 12 de réputation, {npc:11949} 125 et Vanndar environ 300.",
	-- ["Queue at the gate, at any battlemaster or from the battleground screen; you enter at {area:2959} in the north. Before the gates open, take the quests in the town: they are done during the battle."] = "Inscrivez-vous à l'entrée, auprès de n'importe quel maître de guerre ou depuis l'écran des champs de bataille ; vous entrez à {area:2959}, au nord. Avant l'ouverture des portes, prenez les quêtes de la ville : elles s'accomplissent pendant la bataille.",
	-- ["Queue at the gate, at any battlemaster or from the battleground screen; you enter at {area:2961} in the south. Before the gates open, take the quests in the village: they are done during the battle."] = "Inscrivez-vous à l'entrée, auprès de n'importe quel maître de guerre ou depuis l'écran des champs de bataille ; vous entrez au {area:2961}, au sud. Avant l'ouverture des portes, prenez les quêtes du village : elles s'accomplissent pendant la bataille.",
	-- ["The Stormpike camp stands outside the {zone:1459} gate, on the {zone:1416} side above {area:287}. Take every quest here: they all pay 100 or more, once."] = "Le camp Foudrepique se trouve devant l'entrée de {zone:1459}, du côté des {zone:1416}, au-dessus de {area:287}. Prenez toutes les quêtes ici : elles rapportent toutes 100 ou plus, une seule fois.",
	-- ["The {faction:729} holds {area:2978} in the south of {zone:1459}. Destroying towers, taking graveyards and mines, and killing captains and generals all pay reputation to the whole team. Loot {item:17422} from fallen enemies for {npc:13176}. Forever's Legacy Diplomat perk increases reputation gains."] = "Le {faction:729} tient {area:2978}, dans le sud de {zone:1459}. Détruire des tours, prendre des cimetières et des mines, et tuer capitaines et généraux rapportent de la réputation à toute l'équipe. Ramassez des {item:17422} sur les ennemis tombés pour {npc:13176}. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",
	-- ["The {faction:730} holds {area:2959} in the north of {zone:1459}. Destroying towers, taking graveyards and mines, and killing captains and generals all pay reputation to the whole team. Loot {quest:7223} from fallen enemies for {npc:13257}. Forever's Legacy Diplomat perk increases reputation gains."] = "La {faction:730} tient {area:2959}, dans le nord de {zone:1459}. Détruire des tours, prendre des cimetières et des mines, et tuer capitaines et généraux rapportent de la réputation à toute l'équipe. Ramassez des {quest:7223} sur les ennemis tombés pour {npc:13257}. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",
	-- ["{area:3058} lies southwest of {area:2959}. The {item:17849} stands at the back of the cave, past the yetis and harpies."] = "La {area:3058} se trouve au sud-ouest de {area:2959}. L'{item:17849} se dresse au fond de la grotte, après les yétis et les harpies.",
	-- ["{area:3305} banner"] = "Bannière du {area:3305}",
	-- ["{area:3337} lies south of {area:2978}. The {item:17850} stands at the back of the cave, past the gnolls."] = "La {area:3337} se trouve au sud du {area:2978}. L'{item:17850} se dresse au fond de la grotte, après les gnolls.",
	-- ["{faction:729} to Exalted"] = "{faction:729} : Exalté",
	-- ["{faction:729} to Honored"] = "{faction:729} : Honoré",
	-- ["{faction:729} to Revered"] = "{faction:729} : Révéré",
	-- ["{faction:730} to Exalted"] = "{faction:730} : Exalté",
	-- ["{faction:730} to Honored"] = "{faction:730} : Honoré",
	-- ["{faction:730} to Revered"] = "{faction:730} : Révéré",
	-- ["{npc:12096}: Irondeep and {item:17542} from the mines"] = "{npc:12096} : Fournitures de Gouffrefer et de Froide-dent ({item:17542}) des mines",
	-- ["{npc:12097}: Coldtooth and {item:17522} from the mines"] = "{npc:12097} : Fournitures de Froide-dent et de Gouffrefer ({item:17522}) des mines",
	-- ["{npc:13176}: More Booty!"] = "{npc:13176} : Plus de butin !",
	-- ["{npc:13236}: A Gallon of Blood"] = "{npc:13236} : Quelques litres de sang",
	-- ["{npc:13257}: More {quest:7223}"] = "{npc:13257} : encore des {quest:7223}",
	-- ["{npc:13442}: Crystal Cluster"] = "{npc:13442} : Grappes de cristaux",
	-- ["{quest:7161}: the {item:17850} in {area:3337}, 100"] = "{quest:7161} : l'{item:17850} dans la {area:3337}, 100",
	-- ["{quest:7162}: the {item:17849} in {area:3058}, 100"] = "{quest:7162} : l'{item:17849} dans la {area:3058}, 100",
}
