-- German (deDE): the guide forever/collectibles/mounts/neutral/warlock-dreadsteed (forever/collectibles/mounts/neutral/warlock-dreadsteed.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Warlock Dreadsteed"] = "Hexenmeister-Schreckensross",
	["Your epic mount at 60: summoned anywhere, with no gold spent on an epic horse."] = "Dein episches Reittier mit 60: überall beschworen, ohne Gold für ein episches Pferd.",

	-- Step 1: Mor'zul Bloodbringer (Stormwind)
	-- {npc:5520} Spackle Thornberry · {object:2164} Slaughtered Lamb · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5520} in the {object:2164} sends you to {quest:7562} in the {zone:1428}."] = "Mit 60 schickt dich {npc:5520} ({object:2164}) zu {quest:7562} im Gebiet {zone:1428}.",

	-- Step 2: Mor'zul Bloodbringer (Ironforge)
	-- {npc:6382} Jubahl Corpseseeker · {zone:1455} Ironforge · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:6382} in {zone:1455} sends you to {quest:7562} in the {zone:1428}."] = "Mit 60 schickt dich {npc:6382} in {zone:1455} zu {quest:7562} im Gebiet {zone:1428}.",

	-- Step 3: Mor'zul Bloodbringer (Orgrimmar)
	-- {npc:5815} Kurgul · {object:172960} Cleft of Shadow · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5815} in the {object:172960} sends you to {quest:7562} in the {zone:1428}."] = "Mit 60 schickt dich {npc:5815} ({object:172960}) zu {quest:7562} im Gebiet {zone:1428}.",

	-- Step 4: Mor'zul Bloodbringer (Undercity)
	-- {npc:5753} Martha Strain · {object:36082} Magic Quarter · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5753} in the {object:36082} sends you to {quest:7562} in the {zone:1428}."] = "Mit 60 schickt dich {npc:5753} im {object:36082} zu {quest:7562} im Gebiet {zone:1428}.",

	-- Step 5: Mor'zul Bloodbringer
	-- {quest:7562} Mor'zul Bloodbringer · {npc:14437} Gorzeeki Wildeyes · {area:255} Altar of Storms · {zone:1428} Burning Steppes · {area:254} Blackrock Mountain
	["{quest:7562} and his goblin {npc:14437} camp at the {area:255}, in the north-west of the {zone:1428}, west of {area:254}. The chain is long, costs gold at {npc:14437}'s and ends in two dungeons."] = "{quest:7562} und sein Goblin {npc:14437} lagern am {area:255} im Nordwesten von {zone:1428}, westlich von {area:254}. Die Questreihe ist lang, kostet bei {npc:14437} Gold und endet in zwei Dungeons.",

	-- Step 6: Raging Beast's Blood
	-- {zone:1452} Winterspring · {area:2255} Everlook · {spell:417141} Berserk
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["The owlbeasts of {zone:1452} drop the blood, about one in three: the Ragged and Raging Owlbeasts west of and around {area:2255}, the Crazed, Moontouched and {spell:417141} ones in the east. While you hunt, start on the materials of the next step: the Auction House has them all."] = "Die Eulenbestien in {zone:1452} lassen das Blut fallen, etwa jede dritte: die Struppigen und Tobenden Eulenbestien westlich von und rund um {area:2255}, die Wahnsinnigen, Mondbestrahlten und {spell:417141}-Eulenbestien im Osten. Kümmere dich während der Jagd schon um die Materialien des nächsten Schritts: Das Auktionshaus hat sie alle.",

	-- Step 7: Wildeyes
	-- {npc:14436} Mor'zul Bloodbringer · {item:18591} Case of Blood · {npc:14437} Gorzeeki Wildeyes · {zone:1448} Felwood
	-- plural, as words: Shadowy Potions = {item:18802} Shadowy Potion
	["Back to {npc:14436}, then hand his {item:18591} to {npc:14437} beside him. {npc:14436} then asks for three ritual pieces and {npc:14437} sends you to {zone:1448}: buy two Shadowy Potions from {npc:14437} for that trip."] = "Zurück zu {npc:14436}, dann gib {item:18591} an {npc:14437} neben ihm. Danach verlangt {npc:14436} drei Ritualteile, und {npc:14437} schickt dich nach {zone:1448}: Kauf für diese Reise zwei Schattenhafte Tränke bei {npc:14437}.",
	-- {item:18591} Case of Blood
	["he gives you the {item:18591}"] = "er gibt dir {item:18591}",
	-- {item:18802} Shadowy Potion · {npc:14437} Gorzeeki Wildeyes
	["{item:18802}, from {npc:14437}"] = "{item:18802}, von {npc:14437}",

	-- Step 8: The ritual pieces
	["The ritual pieces"] = "Die Ritualteile",
	-- {npc:14437} Gorzeeki Wildeyes · {skill:171} Alchemy · {skill:333} Enchanting · {item:11370} Dark Iron Ore · {skill:186} Mining · {area:1584} Blackrock Depths · {zone:1427} Searing Gorge · {skill:393} Skinning · {zone:1428} Burning Steppes
	-- plural, as words: Large Brilliant Shards = {item:14344} Large Brilliant Shard · Black Dragonscales = {item:15416} Black Dragonscale
	["{npc:14437} wants 10 Elixirs of Shadow Power ({skill:171}), 6 Large Brilliant Shards ({skill:333}), 25 {item:11370} ({skill:186}, in {area:1584} and the {zone:1427}) and 35 Black Dragonscales ({skill:393}, black dragonkin of the {zone:1428}). Make or gather what your professions allow; buy the rest at the Auction House."] = "{npc:14437} will 10 Elixiere der Schattenmacht ({skill:171}), 6 Große glänzende Splitter ({skill:333}), 25 {item:11370} ({skill:186}, in {area:1584} und in der {zone:1427}) und 35 Schwarze Drachenschuppen ({skill:393}, schwarze Drachkin in der {zone:1428}). Stell her oder sammle, was deine Berufe erlauben; kauf den Rest im Auktionshaus.",

	-- Step 9: Arcanite
	-- {npc:14437} Gorzeeki Wildeyes
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["Hand the three pieces to {npc:14437}. He then wants 3 Arcanite Bars: alchemists transmute them, everyone else buys them at the Auction House."] = "Gib {npc:14437} die drei Teile. Danach will er 3 Arkanitbarren: Alchemisten transmutieren sie, alle anderen kaufen sie im Auktionshaus.",

	-- Step 10: Lord Banehollow
	-- {area:1763} Jaedenar · {zone:1448} Felwood · {item:18802} Shadowy Potion · {quest:7623} Lord Banehollow · {area:1770} Shadow Hold
	["{area:1763} is in western {zone:1448}. Drink a {item:18802} before you go in: the Shadow Council cultists turn friendly for a while, the demons do not. {quest:7623} waits deep inside {area:1770}, the cave above {area:1763}, across a bridge in the great root chamber."] = "{area:1763} liegt im Westen von {zone:1448}. Trink vor dem Betreten {item:18802}: Die Kultisten des Schattenrats werden eine Weile freundlich, die Dämonen nicht. {quest:7623} wartet tief in der {area:1770}, der Höhle oberhalb von {area:1763}, jenseits einer Brücke in der großen Wurzelkammer.",

	-- Step 11: Ulathek the Traitor
	-- {npc:14523} Ulathek · {npc:9516} Lord Banehollow
	["{npc:14523} waits in a side chamber by a bridge on the way back up. Speak to him and he and his four guards attack; none are elite. Take his heart back to {npc:9516}, drinking another potion if the first wore off."] = "{npc:14523} wartet auf dem Rückweg nach oben in einer Seitenkammer bei einer Brücke. Sprich ihn an, dann greifen er und seine vier Wachen an; keiner ist Elite. Bring sein Herz zu {npc:9516} zurück und trink einen weiteren Trank, falls der erste abgelaufen ist.",

	-- Step 12: Xorothian Stardust
	-- {npc:14522} Ur'dan · {quest:7623} Lord Banehollow · {item:18687} Xorothian Stardust · {item:18802} Shadowy Potion
	["{npc:14522}, beside {quest:7623}, sells the {item:18687}; he only deals with you while a {item:18802} is active. Bring plenty of gold."] = "{npc:14522} neben {quest:7623} verkauft {item:18687}; er handelt nur mit dir, solange {item:18802} wirkt. Bring reichlich Gold mit.",
	-- {item:18687} Xorothian Stardust · {npc:14522} Ur'dan
	["{item:18687}, from {npc:14522}"] = "{item:18687}, von {npc:14522}",

	-- Step 13: Imp Delivery
	-- {npc:14437} Gorzeeki Wildeyes · {item:18688} Imp in a Jar · {area:2057} Scholomance
	["Back to {npc:14437} with the stardust. He gives you the {item:18688} for the {area:2057}."] = "Zurück zu {npc:14437} mit dem Sternenstaub. Er gibt dir {item:18688} für {area:2057}.",
	-- {quest:7625} Xorothian Stardust · {npc:14522} Ur'dan
	["{quest:7625}, from {npc:14522}"] = "{quest:7625}, von {npc:14522}",

	-- Step 14: The Scholomance
	-- {area:2057} Scholomance
	["The {area:2057}"] = "{area:2057}",
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:13873} Viewing Room Key · {item:18688} Imp in a Jar · {npc:10508} Ras Frostwhisper · {npc:14500} J'eevee
	["The {area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}: you need its key or a rogue to open the door, and Rattlegore's {item:13873} to go deeper. Use the {item:18688} at the alchemy lab in {npc:10508}'s room; {npc:14500} makes the parchment. Bring a group."] = "{area:2057} liegt unter {area:2298}, der Inselstadt im Südosten von {zone:1422}: Für die Tür brauchst du ihren Schlüssel oder einen Schurken, und Blutrippes {item:13873}, um tiefer vorzudringen. Benutze {item:18688} am Alchemielabor im Raum von {npc:10508}; {npc:14500} fertigt das Pergament. Nimm eine Gruppe mit.",
	-- {item:18688} Imp in a Jar
	["Use the {item:18688} at the alchemy lab"] = "Benutze {item:18688} am Alchemielabor",

	-- Step 15: Dreadsteed of Xoroth
	-- {npc:14437} Gorzeeki Wildeyes · {npc:14436} Mor'zul Bloodbringer · {item:18663} J'eevee's Jar · {item:18629} Black Lodestone · {item:18670} Xorothian Glyphs
	-- plural, as words: Soul Shards = {item:6265} Soul Shard
	["Back to {npc:14437}, then {npc:14436} hands you his instructions for the ritual. Buy {item:18663}, the {item:18629} and the {item:18670} from {npc:14437}, and carry ten or more Soul Shards."] = "Zurück zu {npc:14437}, dann gibt dir {npc:14436} seine Anweisungen für das Ritual. Kauf {item:18663}, {item:18629} und {item:18670} bei {npc:14437} und trag mindestens zehn Seelensplitter bei dir.",

	-- Step 16: The ritual in Dire Maul
	-- {area:2577} Dire Maul
	["The ritual in {area:2577}"] = "Das Ritual in {area:2577}",
	-- {area:2577} Dire Maul · {zone:1444} Feralas · {npc:11496} Immol'thar · {item:18249} Crescent Key · {item:18663} J'eevee's Jar · {item:18629} Black Lodestone · {item:6265} Soul Shard · {item:18670} Xorothian Glyphs · {npc:14502} Xorothian Dreadsteed · {npc:14504} Dreadsteed Spirit
	["{area:2577} stands in the ruins of central {zone:1444}; the ritual circle is in its west wing, past {npc:11496}, and the door needs the {item:18249} or a rogue. Use {item:18663} to start; when the bell, the wheel or the candle fades, click it with the {item:18629} (a {item:6265} each). When the demons stop coming, use the {item:18670}, defeat the {npc:14502} and its dreadlord master, and speak to the {npc:14504}. Bring a group."] = "{area:2577} steht in den Ruinen im Zentrum von {zone:1444}; der Ritualkreis liegt im Westflügel hinter {npc:11496}, und die Tür braucht {item:18249} oder einen Schurken. Benutze zum Start {item:18663}; wenn die Glocke, das Rad oder die Kerze verblasst, klick sie mit {item:18629} an (je ein {item:6265}). Wenn keine Dämonen mehr kommen, benutze {item:18670}, besiege {npc:14502} und seinen Schreckenslord-Meister und sprich mit {npc:14504}. Nimm eine Gruppe mit.",
	-- {npc:14504} Dreadsteed Spirit
	["{npc:14504}: it binds itself to you"] = "{npc:14504}: Es bindet sich an dich",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Gorzeeki wants 10 Elixirs of {spell:5896} ({skill:171}), 6 Large Brilliant Shards ({skill:333}), 25 {item:11370} ({skill:186}, in {area:1584} and the {zone:1427}) and 35 Black Dragonscales ({skill:393}, black dragonkin of the {zone:1428}). Make or gather what your professions allow; buy the rest at the Auction House."] = "Gorzeeki will 10 Elixiere der {spell:5896} ({skill:171}), 6 Große glänzende Splitter ({skill:333}), 25 {item:11370} ({skill:186}, in {area:1584} und in der {zone:1427}) und 35 Schwarze Drachenschuppen ({skill:393}, schwarze Drachkin in der {zone:1428}). Stell her oder sammle, was deine Berufe erlauben; kauf den Rest im Auktionshaus.",
}
