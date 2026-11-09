-- German (deDE): the guide forever/class/warrior/brutal-armor (forever/class/warrior/brutal-armor.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Starts now at 20 at your trainer; four armor pieces at 30 (hauberk, helm, gauntlets, legguards), a shield on the way."] = "Beginnt jetzt mit Stufe 20 bei deinem Lehrer; vier Rüstungsteile mit Stufe 30 (Brustpanzer, Helm, Handschuhe, Beinschienen), unterwegs ein Schild.",

	-- Step 1: Speak with Ruga (Orgrimmar)
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:3354} in the {object:172958} sends you to {npc:6394} in {area:378}."] = "Mit 20 schickt dich {npc:3354} im {object:172958} zu {npc:6394} in {area:378}.",

	-- Step 2: Speak with Ruga (Thunder Bluff)
	-- {npc:3041} Torm Ragetotem · {zone:1456} Thunder Bluff · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:3041}, the warrior trainer of {zone:1456}, sends you to {npc:6394} in {area:378}."] = "Mit 20 schickt dich {npc:3041}, der Kriegerlehrer von {zone:1456}, zu {npc:6394} in {area:378}.",

	-- Step 3: Speak with Ruga (Undercity)
	-- {npc:4595} Baltus Fowler · {zone:1458} Undercity · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:4595}, a warrior trainer of the {zone:1458}, sends you to {npc:6394} in {area:378}."] = "Mit 20 schickt dich {npc:4595}, ein Kriegerlehrer in {zone:1458}, zu {npc:6394} in {area:378}.",

	-- Step 4: Ruga Ragetotem
	-- {area:378} Camp Taurajo · {npc:6394} Ruga Ragetotem
	["Fly to {area:378}. {npc:6394} stands in the hut with the leatherworking and tailoring trainers."] = "Flieg nach {area:378}. {npc:6394} steht in der Hütte mit den Lehrern für Lederverarbeitung und Schneiderei.",

	-- Step 5: Trial at the Field of Giants
	-- {item:7119} Twitching Antenna · {area:390} Field of Giants · {area:378} Camp Taurajo · {item:7120} Ruga's Bulwark
	-- plural, as words: Silithid Mounds = {object:3685} Silithid Mound
	["You have 30 minutes, and each {item:7119} rots 15 minutes after you loot it, so take the quest only when ready (logging out does not stop the clock). The Silithid Mounds dot the {area:390} south of {area:378}; every silithid drops an antenna. Creepers (level 20-21) and Grubs are the easiest: Swarmers (21-22) call small swarms and Creepers lay eggs that hatch adds. The eastern part of the field has plenty of Creepers. {item:7120}, a shield, is the reward."] = "Du hast 30 Minuten, und jedes {item:7119} verrottet 15 Minuten, nachdem du es geplündert hast, nimm die Quest also nur an, wenn du bereit bist (Ausloggen hält die Uhr nicht an). Die Silithid Mounds sind über das {area:390} südlich von {area:378} verstreut; jeder Silithid lässt eine Antenne fallen. Creepers (Stufe 20-21) und Grubs sind am leichtesten: Swarmers (21-22) rufen kleine Schwärme und Creepers legen Eier, aus denen Adds schlüpfen. Im östlichen Teil des Feldes gibt es viele Creepers. Die Belohnung ist {item:7120}, ein Schild.",
	-- {item:7119} Twitching Antenna
	["{item:7119}, from the silithid"] = "{item:7119}, von den Silithiden",

	-- Step 6: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:1699} Thorn Hill · {quest:1838} Brutal Armor · {item:7587} Thun'grim's Instructions
	["{npc:5878}'s hut sits on top of {area:1699}, east of the Crossroads: climb the broad ridge on the north or east side. {quest:1838} is a level 30 quest; take it now and gather on the way. {item:7587} list where each material comes from."] = "Die Hütte von {npc:5878} sitzt auf {area:1699}, östlich der Crossroads: Steig den breiten Grat an der Nord- oder Ostseite hinauf. {quest:1838} ist eine Quest der Stufe 30; nimm sie jetzt an und sammle unterwegs. {item:7587} führt auf, woher jedes Material kommt.",

	-- Step 7: Roogug in Razorfen Kraul
	-- {area:1717} Razorfen Kraul
	["Roogug in {area:1717}"] = "Roogug in {area:1717}",
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {spell:403} Lightning Bolt
	["Roogug is an elite quilboar (level 28) inside {area:1717}, the dungeon at the south end of the {zone:1413}; a five-player dungeon: needs a group of five, his guards come with him. Inside take the left path at the first fork, cross the vine bridge over the pig pens, go past the room with the big cauldron: he waits in the room on the right. He casts {spell:403} and calls Earth Rumblers. The vial always drops."] = "Roogug ist ein Elite-Stacheleber (Stufe 28) in {area:1717}, dem Dungeon am Südende des {zone:1413}; ein Dungeon für fünf Spieler: Du brauchst eine Gruppe aus fünf, seine Wachen kommen mit ihm. Nimm drinnen an der ersten Gabelung den linken Weg, überquere die Rankenbrücke über den Schweinepferchen, geh am Raum mit dem großen Kessel vorbei: Er wartet im Raum rechts. Er wirkt {spell:403} und ruft Earth Rumblers. Das Fläschchen fällt immer.",
	-- {item:6841} Vial of Phlogiston
	["{item:6841}, from Roogug"] = "{item:6841}, von Roogug",

	-- Step 8: Windshear Mine
	-- {area:2160} Windshear Mine · {area:461} Windshear Crag · {area:460} Sun Rock Retreat · {spell:116} Frostbolt
	-- plural, as words: Smoky Iron Ingots = {item:7126} Smoky Iron Ingot
	["You need 15 Smoky Iron Ingots. The {area:2160} lies at the east end of {area:461}, east of {area:460}; every Windshear kobold (level 19-23) drops an ingot four kills in five. Stonecutters, Geomancers and Overlords run for help when low; Geomancers cast {spell:116}."] = "Du brauchst 15 Smoky Iron Ingots. {area:2160} liegt am Ostende von {area:461}, östlich von {area:460}; jeder Windshear-Kobold (Stufe 19-23) lässt bei vier von fünf Kills einen Barren fallen. Stonecutters, Geomancers und Overlords rufen bei niedriger Gesundheit um Hilfe; Geomancers wirken {spell:116}.",
	-- {item:7126} Smoky Iron Ingot
	["{item:7126}, from the Windshear kobolds"] = "{item:7126}, von den Windshear-Kobolden",

	-- Step 9: Hillsbrad Miners
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["Hillsbrad Miners"] = "Minenarbeiter von Hillsbrad",
	-- {item:7127} Powdered Azurite · {area:271} Southshore · {spell:71} Defensive Stance · {area:272} Tarren Mill
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["You need 10 {item:7127}. The Hillsbrad Miners (level 26-27) work the mine in the hills west of {area:271} and drop the azurite four kills in five; they fight in {spell:71}, sunder your armor and run for help at 30% health. Fly to {area:272} and head south-west."] = "Du brauchst 10 {item:7127}. Die Hillsbrad Miners (Stufe 26-27) arbeiten in der Mine in den Hügeln westlich von {area:271} und lassen den Azurit bei vier von fünf Kills fallen; sie kämpfen in {spell:71}, zerreißen deine Rüstung und rufen bei 30 % Gesundheit um Hilfe. Flieg nach {area:272} und geh nach Südwesten.",
	-- {item:7127} Powdered Azurite
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["{item:7127}, from the Hillsbrad Miners"] = "{item:7127}, von den Hillsbrad Miners",

	-- Step 10: Iron Bars
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Iron Bars"] = "Eisenbarren",
	-- {item:2772} Iron Ore · {spell:3307} Smelt Iron · {skill:186} Mining · {zone:1454} Orgrimmar
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["You need 10 Iron Bars. Miners smelt them from {item:2772} (one ore a bar, {spell:3307} at {skill:186} 125); everyone else buys them at the auction house in {zone:1454}."] = "Du brauchst 10 Eisenbarren. Bergbauer schmelzen sie aus {item:2772} (ein Erz pro Barren, {spell:3307} bei {skill:186} 125); alle anderen kaufen sie im Auktionshaus in {zone:1454}.",
	-- {npc:8673} Auctioneer Thathung
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Iron Bars: {npc:8673}"] = "Eisenbarren: {npc:8673}",

	-- Step 11: Brutal Hauberk
	-- {npc:5878} Thun'grim Firegaze · {area:1699} Thorn Hill · {quest:1848} Brutal Hauberk
	["Back to {npc:5878} on {area:1699}. {quest:1848} is the first piece; he then sends you to three crafters, one per piece: take all three."] = "Zurück zu {npc:5878} auf {area:1699}. {quest:1848} ist das erste Teil; danach schickt er dich zu drei Handwerkern, einer pro Teil: Nimm alle drei.",

	-- Step 12: Ula'elek
	-- {npc:6408} Ula'elek · {area:367} Sen'jin Village · {zone:1411} Durotar
	["{npc:6408} is in {area:367} on the {zone:1411} coast. He wants 7 Uncloven Satyr Hooves."] = "{npc:6408} ist in {area:367} an der Küste von {zone:1411}. Er will 7 Uncloven Satyr Hooves.",

	-- Step 13: Satyr Hooves
	-- {area:430} Satyrnaar · {area:431} Splintertree Post · {area:429} Xavian · {spell:6925} Gift of the Xavian
	-- plural, as words: Fireballs = {spell:133} Fireball
	["The satyrs of {area:430}, north-east of {area:431} ({area:429}, level 28-30), and the Felmusk satyrs north-west of the post (25-27) drop a hoof four kills in five. A {area:429} satyr at 15% health may cast {spell:6925} and heal to full: finish it fast or stun it. Hellcallers throw Fireballs from 40 yards; Felmusk satyrs reek in melee and run for help at 15%."] = "Die Satyrn von {area:430}, nordöstlich von {area:431} ({area:429}, Stufe 28-30), und die Felmusk-Satyrn nordwestlich des Postens (25-27) lassen bei vier von fünf Kills einen Huf fallen. Ein Satyr von {area:429} mit 15 % Gesundheit wirkt vielleicht {spell:6925} und heilt sich voll: Erledige ihn schnell oder betäube ihn. Hellcallers werfen aus 40 Metern Feuerbälle; Felmusk-Satyrn stinken im Nahkampf und rufen bei 15 % um Hilfe.",

	-- Step 15: Orm Stonehoof
	-- {npc:6410} Orm Stonehoof · {zone:1456} Thunder Bluff
	["{npc:6410} works on {zone:1456}'s lowest level, close to the blacksmith."] = "{npc:6410} arbeitet auf der untersten Ebene von {zone:1456}, nahe dem Schmied.",

	-- Step 16: Chimaeric Horn
	-- {npc:6167} Chimaera Matriarch · {area:465} Charred Vale · {zone:1443} Desolace · {item:6840} Galvanized Horn · {spell:3396} Corrosive Poison
	["The {npc:6167} (level 28, not elite, larger than the young ones around her) roams the south edge of the {area:465} in south-west Stonetalon, near the road to {zone:1443}. She is the only one: she returns 5 minutes after dying and drops the {item:6840} four kills in five. She spits {spell:3396} from 30 yards."] = "Die {npc:6167} (Stufe 28, kein Elite, größer als die Jungen um sie herum) streift am Südrand von {area:465} im Südwesten von Stonetalon, nahe der Straße nach {zone:1443}. Es gibt nur diese eine: Sie kommt 5 Minuten nach ihrem Tod zurück und lässt {item:6840} bei vier von fünf Kills fallen. Sie spuckt aus 30 Metern {spell:3396}.",
	-- {item:6840} Galvanized Horn · {npc:6167} Chimaera Matriarch
	["{item:6840}, from the {npc:6167}"] = "{item:6840}, von {npc:6167}",

	-- Step 18: Velora Nitely
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {npc:6411} Velora Nitely · {zone:1458} Undercity · {object:36078} Trade Quarter
	-- plural, as words: Sturdy Dragonmaw Shinbones = {item:7134} Sturdy Dragonmaw Shinbone
	["Take the zeppelin from {zone:1454} to {zone:1420}; {npc:6411} works in the {zone:1458}'s {object:36078}. She wants 8 Sturdy Dragonmaw Shinbones."] = "Nimm das Luftschiff von {zone:1454} nach {zone:1420}; {npc:6411} arbeitet im {object:36078} von {zone:1458}. Sie will 8 Sturdy Dragonmaw Shinbones.",

	-- Step 19: Dragonmaw Shinbones
	-- {zone:1437} Wetlands · {area:321} Hammerfall · {area:881} Thandol Span · {area:150} Menethil Harbor · {item:7131} Dragonmaw Shinbone · {spell:686} Shadow Bolt
	["The Dragonmaw orcs (level 26-30) camp in the middle of the {zone:1437}; from {area:321} in Arathi head south over the {area:881} ({area:150} is Alliance). Every Raider, Swamprunner, Centurion, Shadowwarder and Bonewarder drops a {item:7131}: right-click it to test it, and about one in four comes out sturdy, the rest break, so expect 30 or more kills for 8. You can test while moving or fighting. The orcs run for help at 15%; Raiders net you, Centurions shield-bash, Shadowwarders cast {spell:686}, Bonewarders raise skeletons."] = "Die Dragonmaw-Orcs (Stufe 26-30) lagern mitten in der {zone:1437}; geh von {area:321} in Arathi nach Süden über {area:881} ({area:150} gehört der Allianz). Jeder Raider, Swamprunner, Centurion, Shadowwarder und Bonewarder lässt {item:7131} fallen: Rechtsklick zum Testen, und etwa eines von vier erweist sich als stabil, der Rest zerbricht, rechne also mit 30 oder mehr Kills für 8. Du kannst auch in Bewegung oder im Kampf testen. Die Orcs rufen bei 15 % um Hilfe; Raiders werfen Netze, Centurions Schildschläge, Shadowwarders wirken {spell:686}, Bonewarders erwecken Skelette.",
	["from the Dragonmaw orcs: right-click to test it"] = "von den Dragonmaw-Orcs: Rechtsklick zum Testen",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:5878} beside the road east of the {area:380}. {quest:1848} is the first piece; he then sends you to three crafters for the rest."] = "Zurück zu {npc:5878} Firegaze an der Straße östlich vom {area:380}. {quest:1848} ist das erste Teil; danach schickt er dich für den Rest zu drei Handwerkern.",
	-- ["Fly to {area:378}. South of the camp the Silithid Mounds dot the {area:390}: the silithid there carry the Twitching Antennae."] = "Flieg nach {area:378}. Südlich des Lagers liegen die Silithid-Buckel verstreut auf dem {area:390}: Die Silithiden dort tragen die Zuckenden Fühler.",
	-- ["Four armor pieces at 30 (hauberk, helm, gauntlets, legguards) and a shield on the way."] = "Vier Rüstungsteile mit 30 (Halsberge, Helm, Stulpen, Beinschützer) und ein Schild unterwegs.",
	-- ["Miners smelt Iron Bars from {item:2772} ({skill:186} 125); everyone else buys them at the auction house in {zone:1454}."] = "Bergleute verhütten Eisenbarren aus {item:2772} ({skill:186} 125); alle anderen kaufen sie im Auktionshaus in {zone:1454}.",
	-- ["Roogug is an elite quilboar inside {area:1717}, the dungeon at the south end of the {zone:1413}; he drops the {item:6841}. {area:1717} is a dungeon: grouping up is advised."] = "Roogug ist ein Elite-Stacheleber in {area:1717}, dem Dungeon am Südende des {zone:1413}; er lässt {item:6841} fallen. {area:1717} ist ein Dungeon: Eine Gruppe wird empfohlen.",
	-- ["Smoky Iron Ingots from the Windshear kobolds"] = "Rauchige Eisenblöcke von den Kobolden der Scherwindmine",
	-- ["Sturdy Dragonmaw Shinbones"] = "Stabile Schienbeinknochen ({item:7134})",
	-- ["Take the zeppelin from {zone:1454} to {zone:1420}; the {zone:1458} lies below the {area:153}."] = "Nimm den Zeppelin von {zone:1454} nach {zone:1420}; {zone:1458} liegt unter den {area:153}.",
	-- ["The Dragonmaw orcs camp in the middle of the {zone:1437}, south of the road; Raiders, Swamprunners, Centurions, Shadowwarders and Bonewarders all drop the Sturdy Dragonmaw Shinbones."] = "Die Orcs der Dragonmaw lagern in der Mitte des {zone:1437}, südlich der Straße; Räuber, Sumpfläufer, Zenturios, Schattenwärter und Knochenwärter lassen alle die Stabilen Schienbeinknochen ({item:7134}) fallen.",
	-- ["The Hillsbrad Miners work the mine in the west of {zone:1424}; they drop the {item:7127}. Take the zeppelin from {zone:1454} to {zone:1420} and head south through {zone:1421}."] = "Die Minenarbeiter von Hillsbrad arbeiten in der Mine im Westen von {zone:1424}; sie lassen {item:7127} fallen. Nimm den Zeppelin von {zone:1454} nach {zone:1420} und geh nach Süden durch {zone:1421}.",
	-- ["The Hillsbrad Miners work the mine in the west of {zone:1424}; they drop the {item:7127}. Take the zeppelin from {zone:1454} to {zone:1420} and ride south through {zone:1421}."] = "Die Minenarbeiter von Hillsbrad arbeiten in der Mine im Westen von {zone:1424}; sie lassen {item:7127} fallen. Nimm den Zeppelin von {zone:1454} nach {zone:1420} und reite nach Süden durch {zone:1421}.",
	-- ["The {area:2160} lies at the east end of {area:461} in Stonetalon. Its kobolds drop the Smoky Iron Ingots."] = "{area:2160} liegt am Ostende von {area:461} im Steinkrallengebirge. Ihre Kobolde lassen die Rauchigen Eisenblöcke fallen.",
	-- ["The {area:429} satyrs camp in eastern {zone:1440}, with the Felmusk satyrs further west; both drop Uncloven Satyr Hooves."] = "Die Satyrn von {area:429} lagern im Osten von {zone:1440}, die Satyrn der Teufelshufe weiter westlich; beide lassen Ungespaltene Satyrhufe fallen.",
	-- ["The {npc:6167} roams the south-west of Stonetalon near the Fledgling and Young Chimaeras; she drops the {item:6840}."] = "{npc:6167} streift durch den Südwesten des Steinkrallengebirges nahe den Schimärenjungen und Jungen Schimären; sie lässt {item:6840} fallen.",
	-- ["Twitching Antennae from the silithid"] = "Zuckende Fühler von den Silithiden",
	-- ["Uncloven {quest:1842}"] = "Ungespaltene {quest:1842}",
	-- ["{item:6840} from the {npc:6167}"] = "{item:6840} von {npc:6167}",
	-- ["{item:7127} from the Hillsbrad Miners"] = "{item:7127} von den Minenarbeitern von Hillsbrad",
	-- ["{npc:5878} camps beside the road east of the {area:380}. {quest:1838} is a level 30 quest; you can take it now and gather for it on the way."] = "{npc:5878} Firegaze lagert an der Straße östlich vom {area:380}. {quest:1838} ist eine Quest der Stufe 30; du kannst sie jetzt annehmen und unterwegs dafür sammeln.",
	-- ["{npc:6408} is in {area:367} on the {zone:1411} coast."] = "{npc:6408} ist in {area:367} an der Küste von {zone:1411}.",
}
