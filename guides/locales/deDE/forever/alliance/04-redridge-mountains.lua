-- German (deDE): the guide forever/alliance/04-redridge-mountains (forever/alliance/04-redridge-mountains.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Stormwind
	-- {zone:1429} Elwynn Forest · {quest:174} Look to the Stars · {area:42} Darkshire · {item:4371} Bronze Tube · {npc:3133} Herble Baubbletump · {object:2096} Trade District
	["Train, then leave by the main gate and follow the road east through {zone:1429}.\n{quest:174} in {area:42} needs a {item:4371}. Its vendors keep only one or two, and {npc:3133} in {area:42} is nearly always sold out: buy one at the Auction House in the {object:2096} on your way out. An engineer can make one too."] = "",
	["Level 18 and 20 spells"] = "Zauber der Stufen 18 und 20",
	-- {item:4371} Bronze Tube · {quest:174} Look to the Stars · {area:42} Darkshire
	["{item:4371}: the Auction House, for {quest:174} in {area:42}"] = "",

	-- Step 2: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Polearms from {npc:11867} ({object:2096}, 1 gold); two-handers level a Warrior fastest."] = "Wenn du schon hier bist: Lerne Stangenwaffen bei {npc:11867} ({object:2096}, 1 Gold); Zweihandwaffen leveln einen Krieger am schnellsten.",

	-- Step 3: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Polearms from {npc:11867} ({object:2096}, 1 gold); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "Wenn du schon hier bist: Lerne Stangenwaffen bei {npc:11867} ({object:2096}, 1 Gold); die Nahkampfwaffe eines Jägers besteht vor allem aus ihren Werten, und Zweihandwaffen haben davon am meisten.",

	-- Step 4: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "Tiefenbahn nach {zone:1455}",

	-- Step 5: Shaman training
	["Shaman training"] = "Schamanentraining",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back."] = "{zone:1453} hat keinen Schamanenlehrer: Nimm {area:2257} vom {object:28027} nach {zone:1455}, trainiere bei {npc:258098} und fahr dann mit der Bahn zurück.",

	-- Step 6: Fly to Sentinel Hill
	-- {area:108} Sentinel Hill
	["Fly to {area:108}"] = "Flieg nach {area:108}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Flugmeister von {zone:1453}",

	-- Step 7: Half Pendant of Aquatic Endurance
	-- {area:108} Sentinel Hill · {object:177790} Strange Lockbox
	["Fly to {area:108} and head north-west to the coast: the {object:177790} lies on the sea floor off the shore. Then head east along the road through Elwynn."] = "Flieg nach {area:108} und geh nach Nordwesten zur Küste: Die {object:177790} liegt auf dem Meeresgrund vor dem Ufer. Geh dann an der Straße entlang nach Osten durch den Wald von Elwynn.",
	-- {item:15882} Half Pendant of Aquatic Endurance · {object:177790} Strange Lockbox
	["{item:15882}: the {object:177790}"] = "{item:15882}: {object:177790}",

	-- Step 8: Back to Elwynn Forest
	-- {zone:1429} Elwynn Forest
	["Back to {zone:1429}"] = "Zurück nach {zone:1429}",
	-- {zone:1429} Elwynn Forest
	["The road into {zone:1429}"] = "Die Straße nach {zone:1429}",

	-- Step 9: Elwynn Forest
	-- {area:91} Tower of Azora
	["The {area:91}"] = "{area:91}",

	-- Step 10: Theocritus
	["On the top floor"] = "Im obersten Stockwerk",

	-- Step 11: Henze Faulk
	-- {area:91} Tower of Azora · {area:86} Stone Cairn Lake · {npc:6172} Henze Faulk · {item:6866} Symbol of Life · {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["On the road east, past the {area:91}, head north from the bridge to {area:86}. {npc:6172} lies south of the lake: use the {item:6866} on him. The Defias Rogue Wizards around him carry the {item:6846}."] = "Geh auf der Straße nach Osten am {area:91} vorbei und von der Brücke nach Norden zu {area:86}. {npc:6172} liegt südlich des Sees: Benutze den {item:6866} an ihm. Die Defias Rogue Wizards um ihn herum tragen das {item:6846}.",
	-- {item:6866} Symbol of Life · {npc:6172} Henze Faulk
	["Use the {item:6866} on {npc:6172}"] = "Benutze {item:6866} an {npc:6172}",
	-- {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["{item:6846}: Defias Rogue Wizards"] = "{item:6846}: Abtrünnige Hexer der Defias",

	-- Step 12: Three Corners
	-- {area:1002} Three Corners · {zone:1431} Duskwood
	["The road east through Elwynn crosses into Redridge at {area:1002}, where the roads to Redridge, {zone:1431} and Elwynn meet: south to {zone:1431} first."] = "Die Straße nach Osten durch den Wald von Elwynn führt bei {area:1002} nach Rotkammgebirge, wo sich die Straßen nach Rotkammgebirge, {zone:1431} und Elwynn treffen: Geh zuerst nach Süden in den {zone:1431}.",

	-- Step 14: Darkshire
	-- {area:1002} Three Corners · {zone:1431} Duskwood · {area:42} Darkshire · {item:4371} Bronze Tube · {quest:174} Look to the Stars · {npc:3133} Herble Baubbletump · {npc:276} Viktori Prism'Antras
	["Follow the road south from {area:1002} into {zone:1431}; {area:42} lies on the east side of the forest.\nNo {item:4371} for {quest:174}? {npc:3133}, in the house beside {npc:276}, is nearly always sold out. Without one, right-click the quest in the guide window and skip it."] = "",
	-- {npc:2409} Felicia Maline
	["{npc:2409}, at the north end of town"] = "{npc:2409}, am Nordende des Orts",
	-- {npc:265} Madame Eva
	["{npc:265}, in her house by the tavern; inside"] = "{npc:265}, in ihrem Haus bei der Taverne; drinnen",
	-- {npc:265} Madame Eva
	["{npc:265}, inside"] = "{npc:265}, drinnen",
	-- {npc:6790} Innkeeper Trelayne
	["{npc:6790}, Scarlet Raven Tavern"] = "{npc:6790}, Taverne Zum Scharlachroten Raben",
	-- {npc:267} Clerk Daltry
	["{npc:267}, in the town hall"] = "{npc:267}, im Rathaus",
	-- {npc:264} Commander Althea Ebonlocke
	["{npc:264}, in the town hall"] = "{npc:264}, im Rathaus",
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, in the house behind the town hall"] = "{npc:268}, im Haus hinter dem Rathaus",
	-- {npc:633} Elaine Carevin
	["{npc:633}, at the south end of town; inside"] = "{npc:633}, am Südende der Stadt; drinnen",
	-- {npc:633} Elaine Carevin · {npc:288} Jitters · {quest:163} Raven Hill
	["{npc:633}: {npc:288}, at {quest:163}"] = "{npc:633}: {npc:288}, bei {quest:163}",
	-- {npc:276} Viktori Prism'Antras
	["{npc:276}, inside"] = "{npc:276}, drinnen",
	-- {npc:302} Blind Mary
	["For {npc:302}, on the hill south-east of town"] = "Für {npc:302}, auf dem Hügel südöstlich der Stadt",

	-- Step 15: Tranquil Gardens Cemetery: kill these as you meet them
	-- {area:121} Tranquil Gardens Cemetery
	["{area:121}: kill these as you meet them"] = "{area:121}: Töte diese, wenn sie dir begegnen",
	-- {area:42} Darkshire · {npc:302} Blind Mary · {zone:1431} Duskwood · {item:2378} Skeleton Finger
	-- plural, as words: Skeletal Warriors = {npc:48} Skeletal Warrior · Skeletal Mages = {npc:203} Skeletal Mage
	["Skeletal Warriors and Skeletal Mages walk among the graves south-east of {area:42}, below {npc:302}'s house on the hill. Every skeleton in {zone:1431} can drop a {item:2378}.\nCareful: Because the skeletons stand near each other, running straight in tends to pull several at once."] = "Skeletal Warriors und Skeletal Mages laufen zwischen den Gräbern südöstlich von {area:42}, unterhalb des Hauses von {npc:302} auf dem Hügel. Jedes Skelett im {zone:1431} kann einen {item:2378} fallen lassen.\nVorsicht: Weil die Skelette nah beieinander stehen, zieht man beim direkten Hineinrennen oft mehrere auf einmal.",

	-- Step 16: Watcher Dodds
	-- {npc:888} Watcher Dodds · {area:245} Yorgen Farmstead
	["{npc:888} stands south of the road, at the {area:245}."] = "{npc:888} steht südlich der Straße, beim {area:245}.",

	-- Step 17: Raven Hill
	-- {quest:163} Raven Hill · {object:673515} Memory of Valor · {npc:288} Jitters
	["Continue west to {quest:163}. The {object:673515} glows by the ruined house south of the road; {npc:288} hides in the house at the west end of the village."] = "Geh weiter nach Westen zu {quest:163}. Die {object:673515} leuchtet beim zerstörten Haus südlich der Straße; {npc:288} versteckt sich im Haus am Westende des Dorfes.",
	-- {item:281046} Raven Hill Tome · {object:673515} Memory of Valor
	["{item:281046}, from the {object:673515}"] = "{item:281046}, von der {object:673515}",
	-- {npc:272} Chef Grual · {area:42} Darkshire
	["for {npc:272} in {area:42}"] = "für {npc:272} in {area:42}",

	-- Step 18: Sven's Camp
	-- {npc:311} Sven Yorgen · {npc:893} Lars
	["Follow the road north-west past the cemetery to {npc:311}'s camp on the far west edge of the forest. {npc:893} stands beside {npc:311}."] = "Folge der Straße nach Nordwesten am Friedhof vorbei zu {npc:311}s Lager am äußersten Westrand des Waldes. {npc:893} steht neben {npc:311}.",

	-- Step 19: The Hushed Bank: kill these as you meet them
	-- {area:1097} The Hushed Bank
	["{area:1097}: kill these as you meet them"] = "{area:1097}: Töte diese, wenn sie dir begegnen",
	-- {npc:289} Abercrombie · {area:1097} The Hushed Bank · {quest:163} Raven Hill · {npc:311} Sven Yorgen · {zone:1436} Westfall
	-- plural, as words: Pygmy Venom Web Spiders = {npc:539} Pygmy Venom Web Spider
	["Rabid Dire Wolves roam the woods around the cemetery and {npc:289}, Starving Dire Wolves the hills north-east of him. Pygmy Venom Web Spiders are the small spiders, and few: most crawl along the {area:1097} west of {quest:163}, fewer up north towards {npc:311}'s camp; they drop the venom too. Every ghoul of the cemetery's northern half can drop a fang. Wolves and the bigger spiders share the {zone:1436} border, so pull with care."] = "Rabid Dire Wolves streifen durch die Wälder um den Friedhof und {npc:289}, Starving Dire Wolves durch die Hügel nordöstlich von ihm. Pygmy Venom Web Spiders sind die kleinen Spinnen, und es gibt wenige: Die meisten krabbeln an der {area:1097} westlich von {quest:163}, weniger weiter nördlich Richtung Lager von {npc:311}; auch sie lassen das Gift fallen. Jeder Ghul in der nördlichen Hälfte des Friedhofs kann einen Fangzahn fallen lassen. Wölfe und die größeren Spinnen teilen sich die Grenze zu {zone:1436}, zieh also mit Vorsicht.",
	-- {item:1130} Vial of Spider Venom
	-- plural, as words: Pygmy Venom Web Spiders = {npc:539} Pygmy Venom Web Spider · Venom Web Spiders = {npc:217} Venom Web Spider · Green Recluses = {npc:569} Green Recluse
	["{item:1130}: Pygmy Venom Web Spiders, Venom Web Spiders and Green Recluses"] = "{item:1130}: Pygmy Venom Web Spiders, Venom Web Spiders und Green Recluses",
	-- {item:2251} Gooey Spider Leg · {npc:272} Chef Grual · {area:42} Darkshire
	["{item:2251}: keep the ones these spiders drop, for {npc:272} in {area:42}"] = "{item:2251}: Behalte die, die diese Spinnen fallen lassen, für {npc:272} in {area:42}",

	-- Step 20: Abercrombie
	-- {area:492} Raven Hill Cemetery
	["The hermit's shack stands in the woods north-east of the {area:492}."] = "Die Hütte des Einsiedlers steht im Wald nordöstlich des {area:492}.",

	-- Step 21: Raven Hill Cemetery: kill these as you meet them
	-- {area:492} Raven Hill Cemetery
	["{area:492}: kill these as you meet them"] = "{area:492}: Töte diese, wenn sie dir begegnen",
	-- {npc:522} Mor'Ladim
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Skeletal Fiends = {npc:531} Skeletal Fiend
	["The cemetery lies north of the village. Skeletal Horrors and Skeletal Fiends walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "Der Friedhof liegt nördlich des Dorfs. Skelettschrecken und Skelettsatanskreaturen wandeln in seiner südlichen Hälfte. {npc:522}, ein Elite, wandert zwischen den Gräbern: Halte dich von ihm fern.",

	-- Step 22: Watcher Dodds
	-- {area:245} Yorgen Farmstead
	["Head back east along the road to the {area:245}."] = "Geh zurück nach Osten entlang der Straße zum {area:245}.",

	-- Step 23: Yorgen Farmstead
	["The mound of loose dirt lies south of the farmhouse, by the old stump."] = "Der Haufen lockerer Erde liegt südlich des Bauernhauses, beim alten Baumstumpf.",

	-- Step 24: Darkshire
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, inside"] = "{npc:268}, drinnen",
	-- {npc:272} Chef Grual
	["{npc:272}, in the Scarlet Raven Tavern"] = "{npc:272}, in der Scarlet Raven Tavern",
	-- {npc:272} Chef Grual · {zone:1431} Duskwood
	-- plural, as words: Gooey Spider Legs = {item:2251} Gooey Spider Leg
	["{npc:272}: six Gooey Spider Legs, which {zone:1431}'s spiders drop even without the quest"] = "{npc:272}: sechs Gooey Spider Legs, die die Spinnen im {zone:1431} auch ohne die Quest fallen lassen",
	["Already carrying six? Hand them in now"] = "Schon sechs dabei? Gib sie jetzt ab",
	-- {npc:288} Jitters · {quest:163} Raven Hill · {zone:1431} Duskwood
	["For {npc:288}, at {quest:163} on the next {zone:1431} loop"] = "Für {npc:288}, bei {quest:163} auf der nächsten Runde durch den {zone:1431}",
	-- {npc:663} Calor
	["{npc:663}, by the town hall"] = "{npc:663}, beim Rathaus",

	-- Step 26: Redridge Mountains
	-- {area:42} Darkshire · {area:1002} Three Corners
	["Back north along the road from {area:42} to {area:1002}."] = "Zurück nach Norden auf der Straße von {area:42} nach {area:1002}.",

	-- Step 27: Lakeridge Highway
	-- {area:68} Lake Everstill · {npc:903} Guard Howe
	["Follow the road along the south shore of {area:68} to the gryphon master. {npc:903} stands by the road next to her."] = "Folge der Straße am Südufer von {area:68} entlang zum Greifenmeister. {npc:903} steht neben ihr an der Straße.",

	-- Step 28: Lake Everstill's murlocs: kill these as you meet them
	-- {area:68} Lake Everstill
	["{area:68}'s murlocs: kill these as you meet them"] = "Die Murlocs von {area:68}: Töte diese, wenn sie dir begegnen",
	-- {area:68} Lake Everstill
	-- plural, as words: Murloc Flesheaters = {npc:422} Murloc Flesheater
	["Murloc Flesheaters and Tidecallers line the south shore of {area:68}, just east of the gryphons and the bridge. Any of them can carry a fin."] = "Murloc Flesheaters und Tidecallers säumen das Südufer von {area:68}, direkt östlich der Greifen und der Brücke. Jeder von ihnen kann eine Flosse tragen.",

	-- Step 29: Lakeshire
	-- {npc:381} Dockmaster Baren · {npc:900} Bailiff Conacher · {npc:342} Martie Jainrose · {npc:382} Marshal Marris · {quest:98386} Alther's Mill
	["Cross the long bridge north into town: {npc:381} on the docks, {npc:900} in the town hall, {npc:342} in her garden at the west end. {npc:382}'s Blackrock quests and {quest:98386} came with you from your first Redridge visit."] = "Überquere die lange Brücke nach Norden in den Ort: {npc:381} an den Docks, {npc:900} im Rathaus, {npc:342} in ihrem Garten am Westende. {npc:382}s Blackrock-Quests und {quest:98386} hast du von deinem ersten Besuch im Rotkammgebirge mitgebracht.",
	-- {npc:415} Verner Osgood
	["{npc:415}, by the road at the north end of the bridge"] = "{npc:415}, an der Straße am Nordende der Brücke",
	-- {npc:900} Bailiff Conacher
	["{npc:900}, in the town hall"] = "{npc:900}, im Rathaus",
	["The Wanted poster by the inn"] = "Der Steckbrief beim Gasthaus",

	-- Step 30: Bellygrub
	-- {npc:345} Bellygrub · {area:69} Lakeshire · {npc:342} Martie Jainrose
	["{npc:345} (level 24) roots around the pen just west of {area:69}, beside {npc:342}'s garden. Pull him away from the other boars and fight at full health."] = "{npc:345} (Stufe 24) wühlt im Gehege direkt westlich von {area:69}, neben dem Garten von {npc:342}. Zieh ihn von den anderen Ebern weg und kämpfe mit voller Gesundheit.",

	-- Step 31: Martie Jainrose
	-- {npc:342} Martie Jainrose
	["{npc:342}'s garden is at the west end of town."] = "Der Garten von {npc:342} liegt am Westende der Stadt.",

	-- Step 32: Lakeshire
	-- {npc:342} Martie Jainrose
	["Back east through town from {npc:342}'s garden: two Wanted posters hang on the town hall doorway."] = "Zurück nach Osten durch die Stadt vom Garten von {npc:342}: Zwei Steckbriefe hängen am Eingang des Rathauses.",
	["The Wanted poster on the town hall doorway"] = "Der Steckbrief am Eingang des Rathauses",
	["The Wanted poster beside it"] = "Der Steckbrief daneben",

	-- Step 33: Alther's Mill
	-- {quest:98386} Alther's Mill
	-- plural, as words: Greater Tarantulas = {npc:505} Greater Tarantula · Tarantula Eggs = {object:673101} Tarantula Egg
	["Greater Tarantulas crawl on the slopes around {quest:98386}, north-east of the lake; their Tarantula Eggs lie on the ground among them: click six."] = "Greater Tarantulas krabbeln an den Hängen um {quest:98386}, nordöstlich des Sees; ihre Tarantula Eggs liegen zwischen ihnen auf dem Boden: Klick sechs an.",

	-- Step 34: Blackrock camps
	["Blackrock camps"] = "Blackrock-Lager",
	-- {area:1000} Galardell Valley · {area:2099} Stonewatch Keep
	["South-east from the mill, west of {area:1000}'s gnolls, to the Blackrock camps east of {area:2099}. Renegades, Grunts and Outrunners fill them; keep east of the keep, whose orcs are elite. Weapon racks and swords lie about the camps; meat haunches, grain sacks and water barrels hold the supplies."] = "Südöstlich von der Mühle, westlich der Gnolle von {area:1000}, zu den Blackrock-Lagern östlich von {area:2099}. Renegades, Grunts und Outrunners füllen sie; bleib östlich der Festung, deren Orcs Elite sind. Waffenständer und Schwerter liegen in den Lagern herum; Fleischkeulen, Getreidesäcke und Wasserfässer enthalten die Vorräte.",
	-- {item:280841} Stolen Weapon
	["{item:280841}: weapon racks and swords on the ground"] = "{item:280841}: Waffenständer und Schwerter auf dem Boden",
	-- {item:280839} Blackrock Supplies
	["{item:280839}: meat haunches, grain sacks, water barrels"] = "{item:280839}: Fleischkeulen, Getreidesäcke, Wasserfässer",

	-- Step 35: Incinerator Gar'im
	["Gar'im keeps to the cave at the camps' south end with his imp and two orcs. Elite: group up if you can; solo, pull the orcs at the mouth first and interrupt his fire cast."] = "Gar'im bleibt in der Höhle am Südende der Lager, mit seinem Wichtel und zwei Orcs. Elite: Bilde wenn möglich eine Gruppe; solo zieh zuerst die Orcs am Eingang und unterbrich seinen Feuerzauber.",

	-- Step 36: Galardell Valley
	-- {npc:703} Lieutenant Fangore · {area:2099} Stonewatch Keep
	["North up the valley's east side. Shadowhide gnolls fill it; {npc:703} (26) and his two guards stand at its north end: clear the gnolls around him first and fight at full health. Stay out of {area:2099} to the west until the watch tower: its orcs are elite."] = "Nach Norden an der Ostseite des Tals. Shadowhide-Gnolle füllen es; {npc:703} (26) und seine zwei Wachen stehen an seinem Nordende: Räum zuerst die Gnolle um ihn herum und kämpfe mit voller Gesundheit. Bleib bis zum Wachturm von {area:2099} im Westen fern: Seine Orcs sind Elite.",
	-- {item:1075} Shadowhide Pendant
	["{item:1075}: any Shadowhide gnoll"] = "{item:1075}: jeder Gnoll der Schattenfelle",

	-- Step 37: A Watchful Eye
	-- {object:31} Old Lion Statue
	["The {object:31} stands at the valley's east edge."] = "Der {object:31} steht am Ostrand des Tals.",

	-- Step 38: Looking Further
	-- {area:2099} Stonewatch Keep
	["West to the intact watch tower beside {area:2099}: climb it and leave the Glyph in the empty jar at the top."] = "Nach Westen zum unversehrten Wachturm neben {area:2099}: Klettere hinauf und lege das Glyph in das leere Gefäß oben.",

	-- Step 39: Stonewatch Keep
	-- {npc:334} Gath'Ilzogg
	-- plural, as words: Blackrock Shadowcasters = {npc:436} Blackrock Shadowcaster
	["The keep stands beside the tower. {npc:334} (elite) waits in the keep's top room with two guards and a dragon; Blackrock Shadowcasters (elite) and Sentries stand on its west side, so pull one at a time on the way in, and hug the right wall as you enter his room so you don't pull him at once. Elite: group up if you can."] = "Die Festung steht neben dem Turm. {npc:334} (Elite) wartet im obersten Raum der Festung mit zwei Wachen und einem Drachen; Blackrock Shadowcasters (Elite) und Sentries stehen auf ihrer Westseite, zieh also auf dem Weg hinein einen nach dem anderen, und halte dich beim Betreten seines Raums an die rechte Wand, damit du ihn nicht sofort ziehst. Elite: Bilde wenn möglich eine Gruppe.",

	-- Step 40: Yowler
	-- {area:95} Redridge Canyons · {area:997} Render's Valley · {npc:518} Yowler
	-- plural, as words: Redridge Alphas = {npc:445} Redridge Alpha
	["From the keep head back west along the lake's north shore and north up the {area:95}. Just south of {area:997}, {npc:518}, a level 25 gnoll, walks among the Redridge Alphas and Mystics."] = "Geh von der Festung zurück nach Westen am Nordufer des Sees entlang und nach Norden den {area:95} hinauf. Direkt südlich von {area:997} läuft {npc:518}, ein Gnoll der Stufe 25, zwischen den Redridge Alphas und Mystics umher.",

	-- Step 41: Render's Valley
	-- {area:95} Redridge Canyons · {area:997} Render's Valley · {area:69} Lakeshire
	-- plural, as words: Blackrock Champions = {npc:435} Blackrock Champion
	["From the keep head back west along the lake's north shore and north up the {area:95} to {area:997}; {area:69}'s hand-ins wait for Keeshan's escort, which ends there. Blackrock Champions camp in the valley."] = "Geh von der Festung zurück nach Westen am Nordufer des Sees entlang und nach Norden den {area:95} hinauf bis {area:997}; die Abgaben in {area:69} warten auf Keeshans Eskorte, die dort endet. Blackrock Champions lagern im Tal.",
	-- {npc:435} Blackrock Champion
	["{npc:435}, below ground"] = "{npc:435}, unter der Erde",

	-- Step 42: Corporal Keeshan
	-- {zone:1428} Burning Steppes · {area:69} Lakeshire
	["Keeshan hides at the very north end of the valley, by the {zone:1428} border. Escort him down to {area:69}; Blackrock orcs ambush you on the way."] = "Keeshan versteckt sich ganz am Nordende des Tals, an der Grenze zu {zone:1428}. Eskortiere ihn hinunter nach {area:69}; Orcs der Blackrock lauern dir unterwegs auf.",
	-- {npc:349} Corporal Keeshan
	["{npc:349}, below ground"] = "{npc:349}, unter der Erde",

	-- Step 43: Magistrate Solomon: Gath'Ilzogg
	-- {npc:344} Magistrate Solomon
	["{npc:344}, in the town hall"] = "{npc:344}, im Rathaus",

	-- Step 45: Back to Lakeshire
	-- {area:69} Lakeshire
	["Back to {area:69}"] = "Zurück nach {area:69}",
	-- {area:69} Lakeshire · {npc:900} Bailiff Conacher · {npc:344} Magistrate Solomon · {npc:382} Marshal Marris · {npc:341} Foreman Oslow · {npc:903} Guard Howe
	["Into {area:69} from the north with Keeshan: {npc:900} and {npc:344} in the town hall, {npc:382} and {npc:341} at the north end of the bridge, then over the bridge to {npc:903} and the gryphons."] = "Mit Keeshan von Norden nach {area:69}: {npc:900} und {npc:344} im Rathaus, {npc:382} und {npc:341} am Nordende der Brücke, dann über die Brücke zu {npc:903} und den Greifen.",
	-- {npc:415} Verner Osgood
	["{npc:415}, by the road on the way to the bridge"] = "{npc:415}, an der Straße auf dem Weg zur Brücke",
	-- {npc:903} Guard Howe
	["{npc:903}, by the gryphons south of the bridge"] = "{npc:903}, bei den Greifen südlich der Brücke",
	-- {area:42} Darkshire · {zone:1431} Duskwood
	["Next: the gryphon to {area:42} for {zone:1431}'s second loop (05-duskwood)."] = "Als Nächstes: der Greif nach {area:42} für die zweite Runde durch den {zone:1431} (05-duskwood).",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Bellygrub"] = "Stopfwanst",
	-- ["Cross the long bridge north into town. {npc:341} and {npc:382} stand at the north end of the bridge, {npc:900} in the town hall, {npc:381} and {npc:266} on the docks, {npc:343} at the inn, {npc:342} in her garden at the west end."] = "Überquere die lange Brücke nach Norden in den Ort. {npc:341} und {npc:382} stehen am Nordende der Brücke, {npc:900} im Rathaus, {npc:381} und {npc:266} an den Docks, {npc:343} im Gasthaus, {npc:342} in ihrem Garten am Westende.",
	-- ["East past the mill and across the river. Shadowhide gnolls fill the valley; {npc:703} (26, well above you) leads them at its north end: clear his escort first and fight him at full health. Stay out of {area:2099} to the south: its orcs are elite."] = "Nach Osten an der Mühle vorbei und über den Fluss. Gnolle der Schattenfelle füllen das Tal; {npc:703} (26, deutlich über dir) führt sie an dessen Nordende an: Räum zuerst seine Begleiter weg und kämpfe mit voller Gesundheit gegen ihn. Bleib aus {area:2099} im Süden fern: Dessen Orcs sind Elite.",
	-- ["Fly to {area:108} and head north-west to the coast: the {object:177790} lies on the sea floor off the shore. Then head east along the road through Elwynn to Redridge."] = "Flieg nach {area:108} und geh nach Nordwesten zur Küste: Die {object:177790} liegt vor dem Ufer auf dem Meeresboden. Geh dann östlich der Straße durch Elwynn nach Rotkammgebirge.",
	-- ["Fly to {area:108} and ride north-west to the coast: the {object:177790} lies on the sea floor off the shore. Then ride east along the road through Elwynn to Redridge."] = "Flieg nach {area:108} und reite nach Nordwesten zur Küste: {object:177790} liegt vor dem Ufer auf dem Meeresgrund. Reite dann auf der Straße nach Osten durch den Wald von Elwynn ins Rotkammgebirge.",
	-- ["Follow the road along the south shore of {area:68} to the gryphon master. {npc:1070} and {npc:903} stand by the road next to her."] = "Folge der Straße am Südufer von {area:68} zur Greifenmeisterin. {npc:1070} und {npc:903} stehen neben ihr an der Straße.",
	-- ["Follow the road south from {area:1002} into {zone:1431}; {area:42} lies on the east side of the forest.\nNo {item:4371} for Look to the Stars? {npc:3133}, in the house beside {npc:276}, is nearly always sold out. Without one, right-click the quest in the guide window and skip it."] = "Folge der Straße von {area:1002} nach Süden in den {zone:1431}; {area:42} liegt an der Ostseite des Waldes.\nKeine {item:4371} für Look to the Stars? {npc:3133}, im Haus neben {npc:276}, ist fast immer ausverkauft. Ohne eine klickst du im Guide-Fenster mit rechts auf die Quest und überspringst sie.",
	-- ["For {npc:3649}, on the return to {area:442} (06-ashenvale)"] = "Für {npc:3649}, bei der Rückkehr nach {area:442} (06-ashenvale)",
	-- ["Gnolls toward {area:1002}"] = "Gnolle Richtung {area:1002}",
	-- ["Greater Tarantulas crawl on the slopes around the mill north-east of the lake."] = "Große Taranteln kriechen an den Hängen rund um die Mühle nordöstlich des Sees.",
	-- ["Greater Tarantulas crawl on the slopes around the mill north-east of the lake; Blackrock Renegades hold the mill itself."] = "Große Taranteln krabbeln an den Hängen um die Mühle nordöstlich des Sees; Renegaten der Blackrock halten die Mühle selbst.",
	-- ["Head north out of {area:69} up the {area:95} to {area:997}. Blackrock Champions camp in the valley."] = "Geh von {area:69} nach Norden die {area:95} hinauf ins {area:997}. Helden der Blackrock lagern im Tal.",
	-- ["Lake murlocs"] = "Murlocs am See",
	-- ["Murloc Flesheaters and Tidecallers line the south shore east of the bridge. Any of them can carry a {item:1467} or a fin."] = "Murlocfleischfresser und Murlocgezeitenrufer säumen das Südufer östlich der Brücke. Jeder von ihnen kann {item:1467} oder eine Flosse tragen.",
	-- ["Only once {quest:97914} is handed in: for {npc:3649}, back in {area:442} (06-ashenvale)"] = "Erst wenn {quest:97914} abgegeben ist: für {npc:3649}, zurück in {area:442} (06-ashenvale)",
	-- ["Redridge Mongrels and other gnolls hold the hills east of {area:1002}, north of the road; Redridge Thrashers prowl among them, Poachers camp south of the road. Dire Condors and Great Goretusks roam the same hills."] = "Bastarde der Rotkammgnolle und andere Gnolle halten die Hügel östlich von {area:1002}, nördlich der Straße; Hauer der Rotkammgnolle streifen zwischen ihnen umher, Wilderer lagern südlich der Straße. Terrorkondore und Große Geiferzähne streifen durch dieselben Hügel.",
	-- ["Redridge Mongrels and other gnolls hold the hills east of {area:1002}, north of the road; Redridge Thrashers prowl among them, Poachers camp south of the road. Redridge Brutes, for the Iron Pikes and Rivets, hold the hills further north; Dire Condors and Great Goretusks roam the hills east of them."] = "Bastarde der Rotkammgnolle und andere Gnolle halten die Hügel östlich von {area:1002}, nördlich der Straße; Hauer der Rotkammgnolle streifen zwischen ihnen umher, Wilderer lagern südlich der Straße. Schläger der Rotkammgnolle, für die Eisenspitzen und Nieten, halten die Hügel weiter nördlich; Terrorkondore und Große Geiferzähne streifen durch die Hügel östlich davon.",
	-- ["South down the valley's east side to the Blackrock camps east of {area:2099}. Renegades, Grunts and Outrunners fill them; keep east of the keep, whose orcs are elite."] = "Südlich das Tal entlang seiner Ostseite zu den Blackrock-Lagern östlich von {area:2099}. Abtrünnige, Grunzer und Läufer füllen sie; halte dich östlich der Feste, deren Orcs Elite sind.",
	-- ["Swim east from the bridge into {area:68}; the chest lies on the lake bed."] = "Schwimm von der Brücke nach Osten in {area:68}; die Truhe liegt auf dem Seegrund.",
	-- ["The Wanted poster by the inn: {npc:703}, in {area:1000}"] = "Der Steckbrief am Gasthaus: {npc:703}, im {area:1000}",
	-- ["The road from Elwynn enters Redridge at {area:1002}. {npc:464} stands where the roads to Redridge and {zone:1431} meet."] = "Die Straße aus dem Wald von Elwynn erreicht das Rotkammgebirge bei {area:1002}. {npc:464} steht dort, wo sich die Straßen ins Rotkammgebirge und nach {zone:1431} treffen.",
	-- ["The {area:442} boat docks at {area:17203}. Walk up into the city for training and {npc:1646}, then leave by the main gate and follow the road east through {zone:1429}."] = "Das Schiff aus {area:442} legt im {area:17203} an. Geh in die Stadt hinauf zum Training und zu {npc:1646}, verlass sie dann durchs Haupttor und folge der Straße nach Osten durch den {zone:1429}.",
	-- ["Train, then leave by the main gate and follow the road east through {zone:1429}.\nLook to the Stars in {area:42} needs a {item:4371}. Its vendors keep only one or two, and {npc:3133} in {area:42} is nearly always sold out: buy one at the Auction House in the {object:2096} on your way out. An engineer can make one too."] = "Lerne bei den Lehrern, verlass dann die Stadt durch das Haupttor und folge der Straße nach Osten durch {zone:1429}.\nLook to the Stars in {area:42} braucht eine {item:4371}. Ihre Händler haben nur eine oder zwei, und {npc:3133} in {area:42} ist fast immer ausverkauft: Kauf eine im Auktionshaus im {object:2096} auf dem Weg hinaus. Ein Ingenieur kann auch eine herstellen.",
	-- ["{item:1075}: any Shadowhide gnoll"] = "{item:1075}: jeder Gnoll der Schattenfelle",
	-- ["{item:280911}: Redridge Thrashers"] = "{item:280911}: Hauer der Rotkammgnolle",
	-- ["{item:3014}: any Blackrock orc"] = "{item:3014}: jeder Orc der Blackrock",
	-- ["{item:3014}: the Blackrock Renegades at the mill"] = "{item:3014}: die Renegaten der Blackrock bei der Mühle",
	-- ["{item:4371}, from {npc:3133}, if you have none"] = "{item:4371}, von {npc:3133}, falls du keine hast",
	-- ["{item:4371}: the Auction House, for Look to the Stars in {area:42}"] = "{item:4371}: das Auktionshaus, für Look to the Stars in {area:42}",
	-- ["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646}: Thundris' Brief aus {area:442}",
	-- ["{npc:266}, by the docks"] = "{npc:266}, an den Docks",
	-- ["{npc:332} is at SI:7 in {object:2100}, {npc:6122} in the {object:2164}'s cellar in the {object:2101}, {npc:376} in the Cathedral of Light."] = "{npc:332} ist bei SI:7 in {object:2100}, {npc:6122} im Keller von {object:2164} in {object:2101}, {npc:376} in der Kathedrale des Lichts.",
	-- ["{npc:332}: {npc:7024} in {zone:1436} takes it, at the end of {zone:1431}"] = "{npc:332}: {npc:7024} in {zone:1436} nimmt sie an, am Ende von {zone:1431}",
	-- ["{npc:341}: after {quest:89}"] = "{npc:341}: nach {quest:89}",
	-- ["{npc:344}, in the town hall"] = "{npc:344}, im Rathaus",
	-- ["{npc:345} (level 24) roots around the pen just west of {area:69}. Pull him away from the other boars and fight at full health."] = "{npc:345} (Stufe 24) wühlt am Pferch gleich westlich von {area:69}. Lock ihn von den anderen Ebern weg und kämpfe mit voller Gesundheit.",
	-- ["{npc:376}: {npc:11401} in {zone:1457} takes it, later"] = "{npc:376}: {npc:11401} in {zone:1457} nimmt sie an, später",
	-- ["{npc:376}: {npc:11406} in {zone:1455} takes it, later"] = "{npc:376}: {npc:11406} in {zone:1455} nimmt sie an, später",
	-- ["{npc:376}: {npc:258785} in {zone:1455} takes it, later"] = "{npc:376}: {npc:258785} in {zone:1455} nimmt sie an, später",
	-- ["{npc:6122}: {npc:6244} in the {zone:1413} takes it, later"] = "{npc:6122}: {npc:6244} in {zone:1413} nimmt sie an, später",
	-- ["{zone:1431} is next: follow the road west to {area:1002}, then south to {area:42}."] = "Als Nächstes {zone:1431}: Folge der Straße nach Westen bis {area:1002}, dann nach Süden nach {area:42}.",
	-- ["{zone:1453} class quests"] = "Klassenquests in {zone:1453}",
}
