-- French (frFR): the guide forever/collectibles/mounts/neutral/warlock-dreadsteed (forever/collectibles/mounts/neutral/warlock-dreadsteed.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Warlock Dreadsteed"] = "Destrier de l'effroi de démoniste",
	["Your epic mount at 60: summoned anywhere, with no gold spent on an epic horse."] = "Votre monture épique au niveau 60 : invoquée n'importe où, sans dépenser d'or pour un cheval épique.",

	-- Step 1: Mor'zul Bloodbringer (Stormwind)
	-- {npc:5520} Spackle Thornberry · {object:2164} Slaughtered Lamb · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5520} in the {object:2164} sends you to {quest:7562} in the {zone:1428}."] = "Au niveau 60, {npc:5520}, à {object:2164}, vous envoie voir {quest:7562} dans les {zone:1428}.",

	-- Step 2: Mor'zul Bloodbringer (Ironforge)
	-- {npc:6382} Jubahl Corpseseeker · {zone:1455} Ironforge · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:6382} in {zone:1455} sends you to {quest:7562} in the {zone:1428}."] = "Au niveau 60, {npc:6382}, à {zone:1455}, vous envoie voir {quest:7562} dans les {zone:1428}.",

	-- Step 3: Mor'zul Bloodbringer (Orgrimmar)
	-- {npc:5815} Kurgul · {object:172960} Cleft of Shadow · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5815} in the {object:172960} sends you to {quest:7562} in the {zone:1428}."] = "Au niveau 60, {npc:5815}, dans {object:172960}, vous envoie voir {quest:7562} dans les {zone:1428}.",

	-- Step 4: Mor'zul Bloodbringer (Undercity)
	-- {npc:5753} Martha Strain · {object:36082} Magic Quarter · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5753} in the {object:36082} sends you to {quest:7562} in the {zone:1428}."] = "Au niveau 60, {npc:5753}, dans le {object:36082}, vous envoie voir {quest:7562} dans les {zone:1428}.",

	-- Step 5: Mor'zul Bloodbringer
	-- {quest:7562} Mor'zul Bloodbringer · {npc:14437} Gorzeeki Wildeyes · {area:255} Altar of Storms · {zone:1428} Burning Steppes · {area:254} Blackrock Mountain
	["{quest:7562} and his goblin {npc:14437} camp at the {area:255}, in the north-west of the {zone:1428}, west of {area:254}. The chain is long, costs gold at {npc:14437}'s and ends in two dungeons."] = "{quest:7562} et son gobelin {npc:14437} campent à l'{area:255}, au nord-ouest des {zone:1428}, à l'ouest du {area:254}. La chaîne est longue, coûte de l'or chez {npc:14437} et se termine dans deux donjons.",

	-- Step 6: Raging Beast's Blood
	-- {zone:1452} Winterspring · {area:2255} Everlook · {spell:417141} Berserk
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["The owlbeasts of {zone:1452} drop the blood, about one in three: the Ragged and Raging Owlbeasts west of and around {area:2255}, the Crazed, Moontouched and {spell:417141} ones in the east. While you hunt, start on the materials of the next step: the Auction House has them all."] = "Les chouettards de {zone:1452} lâchent le sang, environ une fois sur trois : les Chouettards éreintés et enragés ({npc:7451}) à l'ouest et autour de {area:2255}, les affolés, lunaires et {spell:417141} à l'est. Pendant votre chasse, commencez les matériaux de l'étape suivante : l'hôtel des ventes les a tous.",

	-- Step 7: Wildeyes
	-- {npc:14436} Mor'zul Bloodbringer · {item:18591} Case of Blood · {npc:14437} Gorzeeki Wildeyes · {zone:1448} Felwood
	-- plural, as words: Shadowy Potions = {item:18802} Shadowy Potion
	["Back to {npc:14436}, then hand his {item:18591} to {npc:14437} beside him. {npc:14436} then asks for three ritual pieces and {npc:14437} sends you to {zone:1448}: buy two Shadowy Potions from {npc:14437} for that trip."] = "Retournez voir {npc:14436}, puis remettez son {item:18591} à {npc:14437}, à côté de lui. {npc:14436} demande ensuite trois éléments rituels et {npc:14437} vous envoie à {zone:1448} : achetez deux Potions des ténèbres à {npc:14437} pour ce voyage.",
	-- {item:18591} Case of Blood
	["he gives you the {item:18591}"] = "il vous donne {item:18591}",
	-- {item:18802} Shadowy Potion · {npc:14437} Gorzeeki Wildeyes
	["{item:18802}, from {npc:14437}"] = "{item:18802}, chez {npc:14437}",

	-- Step 8: The ritual pieces
	["The ritual pieces"] = "Les éléments rituels",
	-- {npc:14437} Gorzeeki Wildeyes · {skill:171} Alchemy · {skill:333} Enchanting · {item:11370} Dark Iron Ore · {skill:186} Mining · {area:1584} Blackrock Depths · {zone:1427} Searing Gorge · {skill:393} Skinning · {zone:1428} Burning Steppes
	-- plural, as words: Large Brilliant Shards = {item:14344} Large Brilliant Shard · Black Dragonscales = {item:15416} Black Dragonscale
	["{npc:14437} wants 10 Elixirs of Shadow Power ({skill:171}), 6 Large Brilliant Shards ({skill:333}), 25 {item:11370} ({skill:186}, in {area:1584} and the {zone:1427}) and 35 Black Dragonscales ({skill:393}, black dragonkin of the {zone:1428}). Make or gather what your professions allow; buy the rest at the Auction House."] = "{npc:14437} veut 10 Elixirs de Puissance de l'ombre ({skill:171}), 6 Grands éclats brillants ({skill:333}), 25 {item:11370} ({skill:186}, dans les {area:1584} et la {zone:1427}) et 35 Ecailles de dragon noir ({skill:393}, sur les draconiens noirs des {zone:1428}). Fabriquez ou récoltez ce que vos métiers permettent ; achetez le reste à l'hôtel des ventes.",

	-- Step 9: Arcanite
	-- {npc:14437} Gorzeeki Wildeyes
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["Hand the three pieces to {npc:14437}. He then wants 3 Arcanite Bars: alchemists transmute them, everyone else buys them at the Auction House."] = "Remettez les trois éléments à {npc:14437}. Il veut ensuite 3 Barres d'arcanite (L'arcanite) : les alchimistes les transmutent, les autres les achètent à l'hôtel des ventes.",

	-- Step 10: Lord Banehollow
	-- {area:1763} Jaedenar · {zone:1448} Felwood · {item:18802} Shadowy Potion · {quest:7623} Lord Banehollow · {area:1770} Shadow Hold
	["{area:1763} is in western {zone:1448}. Drink a {item:18802} before you go in: the Shadow Council cultists turn friendly for a while, the demons do not. {quest:7623} waits deep inside {area:1770}, the cave above {area:1763}, across a bridge in the great root chamber."] = "{area:1763} se trouve dans l'ouest de {zone:1448}. Buvez une {item:18802} avant d'entrer : les cultistes du Conseil des ombres deviennent amicaux un moment, pas les démons. {quest:7623} attend au fond du {area:1770}, la grotte au-dessus de {area:1763}, de l'autre côté d'un pont dans la grande salle des racines.",

	-- Step 11: Ulathek the Traitor
	-- {npc:14523} Ulathek · {npc:9516} Lord Banehollow
	["{npc:14523} waits in a side chamber by a bridge on the way back up. Speak to him and he and his four guards attack; none are elite. Take his heart back to {npc:9516}, drinking another potion if the first wore off."] = "{npc:14523} attend dans une salle latérale près d'un pont, sur le chemin du retour. Parlez-lui : lui et ses quatre gardes attaquent ; aucun n'est élite. Rapportez son cœur à {npc:9516}, en buvant une autre potion si la première s'est dissipée.",

	-- Step 12: Xorothian Stardust
	-- {npc:14522} Ur'dan · {quest:7623} Lord Banehollow · {item:18687} Xorothian Stardust · {item:18802} Shadowy Potion
	["{npc:14522}, beside {quest:7623}, sells the {item:18687}; he only deals with you while a {item:18802} is active. Bring plenty of gold."] = "{npc:14522}, à côté de {quest:7623}, vend {item:18687} ; il ne traite avec vous que sous l'effet d'une {item:18802}. Prévoyez beaucoup d'or.",
	-- {item:18687} Xorothian Stardust · {npc:14522} Ur'dan
	["{item:18687}, from {npc:14522}"] = "{item:18687}, chez {npc:14522}",

	-- Step 13: Imp Delivery
	-- {npc:14437} Gorzeeki Wildeyes · {item:18688} Imp in a Jar · {area:2057} Scholomance
	["Back to {npc:14437} with the stardust. He gives you the {item:18688} for the {area:2057}."] = "Retournez voir {npc:14437} avec la poussière d'étoile. Il vous donne {item:18688} pour {area:2057}.",

	-- Step 14: The Scholomance
	-- {area:2057} Scholomance
	["The {area:2057}"] = "{area:2057}",
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:13873} Viewing Room Key · {item:18688} Imp in a Jar · {npc:10508} Ras Frostwhisper · {npc:14500} J'eevee
	["The {area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}: you need its key or a rogue to open the door, and Rattlegore's {item:13873} to go deeper. Use the {item:18688} at the alchemy lab in {npc:10508}'s room; {npc:14500} makes the parchment. Bring a group."] = "{area:2057} se trouve sous {area:2298}, la ville insulaire du sud-est des {zone:1422} : il vous faut sa clé ou un voleur pour ouvrir la porte, et {item:13873} de Cliquettripes pour aller plus loin. Utilisez {item:18688} au laboratoire d'alchimie dans la salle de {npc:10508} ; {npc:14500} fabrique le parchemin. Venez en groupe.",
	-- {item:18688} Imp in a Jar
	["Use the {item:18688} at the alchemy lab"] = "Utilisez {item:18688} au laboratoire d'alchimie",

	-- Step 15: Dreadsteed of Xoroth
	-- {npc:14437} Gorzeeki Wildeyes · {npc:14436} Mor'zul Bloodbringer · {item:18663} J'eevee's Jar · {item:18629} Black Lodestone · {item:18670} Xorothian Glyphs
	-- plural, as words: Soul Shards = {item:6265} Soul Shard
	["Back to {npc:14437}, then {npc:14436} hands you his instructions for the ritual. Buy {item:18663}, the {item:18629} and the {item:18670} from {npc:14437}, and carry ten or more Soul Shards."] = "Retournez voir {npc:14437}, puis {npc:14436} vous remet ses instructions pour le rituel. Achetez {item:18663}, {item:18629} et {item:18670} à {npc:14437}, et emportez au moins dix Fragments d'âme.",

	-- Step 16: The ritual in Dire Maul
	-- {area:2577} Dire Maul
	["The ritual in {area:2577}"] = "Le rituel à {area:2577}",
	-- {area:2577} Dire Maul · {zone:1444} Feralas · {npc:11496} Immol'thar · {item:18249} Crescent Key · {item:18663} J'eevee's Jar · {item:18629} Black Lodestone · {item:6265} Soul Shard · {item:18670} Xorothian Glyphs · {npc:14502} Xorothian Dreadsteed · {npc:14504} Dreadsteed Spirit
	["{area:2577} stands in the ruins of central {zone:1444}; the ritual circle is in its west wing, past {npc:11496}, and the door needs the {item:18249} or a rogue. Use {item:18663} to start; when the bell, the wheel or the candle fades, click it with the {item:18629} (a {item:6265} each). When the demons stop coming, use the {item:18670}, defeat the {npc:14502} and its dreadlord master, and speak to the {npc:14504}. Bring a group."] = "{area:2577} se dresse dans les ruines du centre de {zone:1444} ; le cercle rituel est dans son aile ouest, après {npc:11496}, et la porte demande {item:18249} ou un voleur. Utilisez {item:18663} pour commencer ; quand la cloche, la roue ou la bougie faiblit, cliquez dessus avec {item:18629} (un {item:6265} à chaque fois). Quand les démons cessent d'arriver, utilisez {item:18670}, vainquez le {npc:14502} et son maître seigneur de l'effroi, puis parlez à l'{npc:14504}. Venez en groupe.",
	-- {npc:14504} Dreadsteed Spirit
	["{npc:14504}: it binds itself to you"] = "{npc:14504} : il se lie à vous",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Gorzeeki wants 10 Elixirs of {spell:5896} ({skill:171}), 6 Large Brilliant Shards ({skill:333}), 25 {item:11370} ({skill:186}, in {area:1584} and the {zone:1427}) and 35 Black Dragonscales ({skill:393}, black dragonkin of the {zone:1428}). Make or gather what your professions allow; buy the rest at the Auction House."] = "Gorzeeki veut 10 Elixirs de {spell:5896} ({skill:171}), 6 Grands éclats brillants ({item:14344}) ({skill:333}), 25 {item:11370} ({skill:186}, à {area:1584} et dans {zone:1427}) et 35 Ecailles de dragon noir ({item:15416}) ({skill:393}, sur les draconiens noirs de {zone:1428}). Fabriquez ou récoltez ce que vos métiers permettent ; achetez le reste à l'hôtel des ventes.",
}
