-- German (deDE): the guide forever/alliance/04-redridge-mountains (forever/alliance/04-redridge-mountains.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Boat to Stormwind Harbor
	-- {area:17203} Stormwind Harbor
	["Boat to {area:17203}"] = "",

	-- Step 2: Stormwind
	-- {area:442} Auberdine · {area:17203} Stormwind Harbor · {npc:1646} Baros Alexston · {area:12} Elwynn Forest
	["The {area:442} boat docks at {area:17203}. Walk up into the city for training and {npc:1646}, then leave by the main gate and follow the road east through {area:12}."] = "",
	["Level 18 and 20 spells"] = "Zauber der Stufen 18 und 20",
	-- {npc:1646} Baros Alexston · {area:442} Auberdine
	["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646}: Thundris' Brief aus {area:442}",
	-- {quest:97914} Expanding Horizons · {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["Only once {quest:97914} is handed in: for {npc:3649}, back in {area:442} (06-ashenvale)"] = "Erst wenn {quest:97914} abgegeben ist: für {npc:3649}, zurück in {area:442} (06-ashenvale)",

	-- Step 3: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Polearms from {npc:11867} ({object:2096}, 1 gold); two-handers level a Warrior fastest."] = "",

	-- Step 4: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Polearms from {npc:11867} ({object:2096}, 1 gold); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "",

	-- Step 5: Stormwind class quests
	-- {zone:1453} Stormwind
	["{zone:1453} class quests"] = "Klassenquests in {zone:1453}",
	-- {npc:332} Master Mathias Shaw · {object:2100} Old Town · {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:376} High Priestess Laurena
	["{npc:332} is at SI:7 in {object:2100}, {npc:6122} in the {object:2164}'s cellar in the {object:2101}, {npc:376} in the Cathedral of Light."] = "{npc:332} ist bei SI:7 in {object:2100}, {npc:6122} im Keller von {object:2164} in {object:2101}, {npc:376} in der Kathedrale des Lichts.",
	-- {npc:332} Master Mathias Shaw · {npc:7024} Agent Kearnen · {zone:1436} Westfall · {zone:1431} Duskwood
	["{npc:332}: {npc:7024} in {zone:1436} takes it, at the end of {zone:1431}"] = "{npc:332}: {npc:7024} in {zone:1436} nimmt sie an, am Ende von {zone:1431}",
	-- {npc:6122} Gakin the Darkbinder · {npc:6244} Takar the Seer · {zone:1413} Barrens
	["{npc:6122}: {npc:6244} in the {zone:1413} takes it, later"] = "{npc:6122}: {npc:6244} in {zone:1413} nimmt sie an, später",
	-- {npc:376} High Priestess Laurena · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["{npc:376}: {npc:11406} in {zone:1455} takes it, later"] = "{npc:376}: {npc:11406} in {zone:1455} nimmt sie an, später",
	-- {npc:376} High Priestess Laurena · {npc:258785} High Priestess Mims · {zone:1455} Ironforge
	["{npc:376}: {npc:258785} in {zone:1455} takes it, later"] = "{npc:376}: {npc:258785} in {zone:1455} nimmt sie an, später",
	-- {npc:376} High Priestess Laurena · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["{npc:376}: {npc:11401} in {zone:1457} takes it, later"] = "{npc:376}: {npc:11401} in {zone:1457} nimmt sie an, später",

	-- Step 6: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "",

	-- Step 7: Shaman training
	["Shaman training"] = "Schamanentraining",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back."] = "{zone:1453} hat keinen Schamanenlehrer: Nimm {area:2257} vom {object:28027} nach {zone:1455}, trainiere bei {npc:258098} und fahr dann mit der Bahn zurück.",

	-- Step 8: Fly to Sentinel Hill
	-- {area:108} Sentinel Hill
	["Fly to {area:108}"] = "",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "",

	-- Step 9: Half Pendant of Aquatic Endurance
	-- {area:108} Sentinel Hill · {object:177790} Strange Lockbox
	["Fly to {area:108} and head north-west to the coast: the {object:177790} lies on the sea floor off the shore. Then head east along the road through Elwynn to Redridge."] = "Flieg nach {area:108} und geh nach Nordwesten zur Küste: Die {object:177790} liegt vor dem Ufer auf dem Meeresboden. Geh dann östlich der Straße durch Elwynn nach Rotkammgebirge.",
	-- {item:15882} Half Pendant of Aquatic Endurance · {object:177790} Strange Lockbox
	["{item:15882}: the {object:177790}"] = "{item:15882}: {object:177790}",

	-- Step 10: Back to Elwynn Forest
	-- {area:12} Elwynn Forest
	["Back to {area:12}"] = "",

	-- Step 12: Theocritus
	["On the top floor"] = "",

	-- Step 14: Henze Faulk
	-- {area:91} Tower of Azora · {area:86} Stone Cairn Lake · {npc:6172} Henze Faulk · {item:6866} Symbol of Life · {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["On the road east, past the {area:91}, head north from the bridge to {area:86}. {npc:6172} lies south of the lake: use the {item:6866} on him. The Defias Rogue Wizards around him carry the {item:6846}."] = "",
	-- {item:6866} Symbol of Life · {npc:6172} Henze Faulk
	["Use the {item:6866} on {npc:6172}"] = "",
	-- {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["{item:6846}: Defias Rogue Wizards"] = "",

	-- Step 16: Three Corners
	-- {area:1002} Three Corners · {npc:464} Guard Parker · {zone:1431} Duskwood
	["The road from Elwynn enters Redridge at {area:1002}. {npc:464} stands where the roads to Redridge and {zone:1431} meet."] = "Die Straße aus dem Wald von Elwynn erreicht das Rotkammgebirge bei {area:1002}. {npc:464} steht dort, wo sich die Straßen ins Rotkammgebirge und nach {zone:1431} treffen.",
	-- {npc:464} Guard Parker · {area:1002} Three Corners
	["{npc:464} walks around {area:1002}: look inside the circle on the map"] = "",

	-- Step 17: Lakeridge Highway
	-- {area:68} Lake Everstill · {npc:1070} Deputy Feldon · {npc:903} Guard Howe
	["Follow the road along the south shore of {area:68} to the gryphon master. {npc:1070} and {npc:903} stand by the road next to her."] = "Folge der Straße am Südufer von {area:68} zur Greifenmeisterin. {npc:1070} und {npc:903} stehen neben ihr an der Straße.",

	-- Step 18: Lakeshire
	-- {npc:341} Foreman Oslow · {npc:382} Marshal Marris · {npc:900} Bailiff Conacher · {npc:381} Dockmaster Baren · {npc:266} Wiley the Black · {npc:343} Chef Breanna · {npc:342} Martie Jainrose
	["Cross the long bridge north into town. {npc:341} and {npc:382} stand at the north end of the bridge, {npc:900} in the town hall, {npc:381} and {npc:266} on the docks, {npc:343} at the inn, {npc:342} in her garden at the west end."] = "Überquere die lange Brücke nach Norden in den Ort. {npc:341} und {npc:382} stehen am Nordende der Brücke, {npc:900} im Rathaus, {npc:381} und {npc:266} an den Docks, {npc:343} im Gasthaus, {npc:342} in ihrem Garten am Westende.",
	-- {npc:900} Bailiff Conacher
	["{npc:900}, in the town hall"] = "",
	-- {npc:266} Wiley the Black
	["{npc:266}, by the docks; upstairs"] = "",
	["Inside"] = "",
	-- {npc:343} Chef Breanna
	["{npc:343}, inside"] = "",

	-- Step 19: Spotted Sunfish on the way
	-- {item:1467} Spotted Sunfish
	["{item:1467} on the way"] = "",

	-- Step 20: Sunken Chest
	-- {area:68} Lake Everstill
	["Swim east from the bridge into {area:68}; the chest lies on the lake bed."] = "Schwimm von der Brücke nach Osten in {area:68}; die Truhe liegt auf dem Seegrund.",
	-- {item:1309} Oslow's Toolbox
	["{item:1309}; underwater"] = "",

	-- Step 22: Lakeridge Highway: kill these as you meet them
	-- {area:1001} Lakeridge Highway
	["{area:1001}: kill these as you meet them"] = "",
	-- {area:1002} Three Corners
	-- plural, as words: Redridge Mongrels = {npc:423} Redridge Mongrel · Redridge Thrashers = {npc:712} Redridge Thrasher · Redridge Brutes = {npc:426} Redridge Brute · Iron Pikes = {item:2856} Iron Pike · Dire Condors = {npc:428} Dire Condor · Great Goretusks = {npc:547} Great Goretusk
	["Redridge Mongrels and other gnolls hold the hills east of {area:1002}, north of the road; Redridge Thrashers prowl among them, Poachers camp south of the road. Redridge Brutes, for the Iron Pikes and Rivets, hold the hills further north; Dire Condors and Great Goretusks roam the hills east of them."] = "",
	-- {item:280911} Spiked Collar
	-- plural, as words: Redridge Thrashers = {npc:712} Redridge Thrasher
	["{item:280911}: Redridge Thrashers"] = "{item:280911}: Hauer der Rotkammgnolle",

	-- Step 27: Lakeshire
	-- {npc:341} Foreman Oslow · {quest:89} The Everstill Bridge
	["{npc:341}: after {quest:89}"] = "{npc:341}: nach {quest:89}",

	-- Step 28: Lake Everstill: kill these as you meet them
	-- {area:68} Lake Everstill
	["{area:68}: kill these as you meet them"] = "",
	-- {item:1467} Spotted Sunfish
	-- plural, as words: Murloc Flesheaters = {npc:422} Murloc Flesheater · Greater Tarantulas = {npc:505} Greater Tarantula
	["Murloc Flesheaters and Tidecallers line the south shore east of the bridge. Any of them can carry a {item:1467} or a fin.\nGreater Tarantulas crawl on the slopes around the mill north-east of the lake."] = "",

	-- Step 29: Blackrock camps
	["Blackrock camps"] = "Blackrock-Lager",
	-- {area:1000} Galardell Valley · {area:2099} Stonewatch Keep · {zone:1431} Duskwood
	["South-east from the mill, west of {area:1000}'s gnolls, to the Blackrock camps east of {area:2099}. Renegades, Grunts and Outrunners fill them; keep east of the keep, whose orcs are elite. Weapon racks and swords lie about the camps; meat haunches, grain sacks and water barrels hold the supplies. Kill the camps' orcs until level 23: {area:1000}'s gnolls, next, are 22-25, and {zone:1431}'s quests start at 24."] = "",
	-- {item:280841} Stolen Weapon
	["{item:280841}: weapon racks and swords on the ground"] = "",
	-- {item:280839} Blackrock Supplies
	["{item:280839}: meat haunches, grain sacks, water barrels"] = "",

	-- Step 30: Galardell Valley
	-- {npc:703} Lieutenant Fangore · {area:2099} Stonewatch Keep
	["North up the valley's east side. Shadowhide gnolls fill it; {npc:703} (26) and his two guards stand at its north end: keep clear of them. Stay out of {area:2099} to the west: its orcs are elite."] = "",
	-- {item:1075} Shadowhide Pendant
	["{item:1075}: any Shadowhide gnoll"] = "",

	-- Step 31: A Watchful Eye
	-- {object:31} Old Lion Statue
	["The {object:31} stands at the valley's east edge."] = "",

	-- Step 32: Looking Further
	-- {area:2099} Stonewatch Keep
	["West to the intact watch tower beside {area:2099}: climb it and leave the Glyph in the empty jar at the top."] = "",

	-- Step 33: Back to Lakeshire
	-- {area:69} Lakeshire
	["Back to {area:69}"] = "Zurück nach {area:69}",

	-- Step 34: Bellygrub
	-- {npc:345} Bellygrub · {area:69} Lakeshire
	["{npc:345} (level 24) roots around the pen just west of {area:69}. Pull him away from the other boars and fight at full health."] = "",

	-- Step 36: Render's Valley
	-- {area:69} Lakeshire · {area:95} Redridge Canyons · {area:997} Render's Valley
	-- plural, as words: Blackrock Champions = {npc:435} Blackrock Champion
	["Head north out of {area:69} up the {area:95} to {area:997}. Blackrock Champions camp in the valley."] = "Geh von {area:69} nach Norden die {area:95} hinauf ins {area:997}. Helden der Blackrock lagern im Tal.",
	-- {npc:435} Blackrock Champion
	["{npc:435}, below ground"] = "",

	-- Step 37: Corporal Keeshan
	-- {zone:1428} Burning Steppes · {area:69} Lakeshire
	["Keeshan hides at the very north end of the valley, by the {zone:1428} border. Escort him down to {area:69}; Blackrock orcs ambush you on the way."] = "Keeshan versteckt sich ganz am Nordende des Tals, an der Grenze zu {zone:1428}. Eskortiere ihn hinunter nach {area:69}; Orcs der Blackrock lauern dir unterwegs auf.",
	-- {npc:349} Corporal Keeshan
	["{npc:349}, below ground"] = "",

	-- Step 38: Lakeshire
	-- {npc:903} Guard Howe
	["{npc:903}, by the gryphons south of the bridge"] = "{npc:903}, bei den Greifen südlich der Brücke",
	-- {zone:1431} Duskwood · {area:1002} Three Corners · {area:42} Darkshire
	["{zone:1431} is next: follow the road west to {area:1002}, then south to {area:42}."] = "Als Nächstes {zone:1431}: Folge der Straße nach Westen bis {area:1002}, dann nach Süden nach {area:42}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Bellygrub"] = "Stopfwanst",
	-- ["East past the mill and across the river. Shadowhide gnolls fill the valley; {npc:703} (26, well above you) leads them at its north end: clear his escort first and fight him at full health. Stay out of {area:2099} to the south: its orcs are elite."] = "Nach Osten an der Mühle vorbei und über den Fluss. Gnolle der Schattenfelle füllen das Tal; {npc:703} (26, deutlich über dir) führt sie an dessen Nordende an: Räum zuerst seine Begleiter weg und kämpfe mit voller Gesundheit gegen ihn. Bleib aus {area:2099} im Süden fern: Dessen Orcs sind Elite.",
	-- ["Fly to {area:108} and ride north-west to the coast: the {object:177790} lies on the sea floor off the shore. Then ride east along the road through Elwynn to Redridge."] = "Flieg nach {area:108} und reite nach Nordwesten zur Küste: {object:177790} liegt vor dem Ufer auf dem Meeresgrund. Reite dann auf der Straße nach Osten durch den Wald von Elwynn ins Rotkammgebirge.",
	-- ["For {npc:3649}, on the return to {area:442} (06-ashenvale)"] = "Für {npc:3649}, bei der Rückkehr nach {area:442} (06-ashenvale)",
	-- ["Gnolls toward {area:1002}"] = "Gnolle Richtung {area:1002}",
	-- ["Greater Tarantulas crawl on the slopes around the mill north-east of the lake."] = "Große Taranteln kriechen an den Hängen rund um die Mühle nordöstlich des Sees.",
	-- ["Greater Tarantulas crawl on the slopes around the mill north-east of the lake; Blackrock Renegades hold the mill itself."] = "Große Taranteln krabbeln an den Hängen um die Mühle nordöstlich des Sees; Renegaten der Blackrock halten die Mühle selbst.",
	-- ["Lake murlocs"] = "Murlocs am See",
	-- ["Murloc Flesheaters and Tidecallers line the south shore east of the bridge. Any of them can carry a {item:1467} or a fin."] = "Murlocfleischfresser und Murlocgezeitenrufer säumen das Südufer östlich der Brücke. Jeder von ihnen kann {item:1467} oder eine Flosse tragen.",
	-- ["Redridge Mongrels and other gnolls hold the hills east of {area:1002}, north of the road; Redridge Thrashers prowl among them, Poachers camp south of the road. Dire Condors and Great Goretusks roam the same hills."] = "Bastarde der Rotkammgnolle und andere Gnolle halten die Hügel östlich von {area:1002}, nördlich der Straße; Hauer der Rotkammgnolle streifen zwischen ihnen umher, Wilderer lagern südlich der Straße. Terrorkondore und Große Geiferzähne streifen durch dieselben Hügel.",
	-- ["Redridge Mongrels and other gnolls hold the hills east of {area:1002}, north of the road; Redridge Thrashers prowl among them, Poachers camp south of the road. Redridge Brutes, for the Iron Pikes and Rivets, hold the hills further north; Dire Condors and Great Goretusks roam the hills east of them."] = "Bastarde der Rotkammgnolle und andere Gnolle halten die Hügel östlich von {area:1002}, nördlich der Straße; Hauer der Rotkammgnolle streifen zwischen ihnen umher, Wilderer lagern südlich der Straße. Schläger der Rotkammgnolle, für die Eisenspitzen und Nieten, halten die Hügel weiter nördlich; Terrorkondore und Große Geiferzähne streifen durch die Hügel östlich davon.",
	-- ["South down the valley's east side to the Blackrock camps east of {area:2099}. Renegades, Grunts and Outrunners fill them; keep east of the keep, whose orcs are elite."] = "Südlich das Tal entlang seiner Ostseite zu den Blackrock-Lagern östlich von {area:2099}. Abtrünnige, Grunzer und Läufer füllen sie; halte dich östlich der Feste, deren Orcs Elite sind.",
	-- ["The Wanted poster by the inn: {npc:703}, in {area:1000}"] = "Der Steckbrief am Gasthaus: {npc:703}, im {area:1000}",
	-- ["The {area:442} boat docks at {area:17203}. Walk up into the city for training and {npc:1646}, then leave by the main gate and follow the road east through {zone:1429}."] = "Das Schiff aus {area:442} legt im {area:17203} an. Geh in die Stadt hinauf zum Training und zu {npc:1646}, verlass sie dann durchs Haupttor und folge der Straße nach Osten durch den {zone:1429}.",
	-- ["{item:1075}: any Shadowhide gnoll"] = "{item:1075}: jeder Gnoll der Schattenfelle",
	-- ["{item:3014}: any Blackrock orc"] = "{item:3014}: jeder Orc der Blackrock",
	-- ["{item:3014}: the Blackrock Renegades at the mill"] = "{item:3014}: die Renegaten der Blackrock bei der Mühle",
	-- ["{npc:266}, by the docks"] = "{npc:266}, an den Docks",
	-- ["{npc:344}, in the town hall"] = "{npc:344}, im Rathaus",
	-- ["{npc:345} (level 24) roots around the pen just west of {area:69}. Pull him away from the other boars and fight at full health."] = "{npc:345} (Stufe 24) wühlt am Pferch gleich westlich von {area:69}. Lock ihn von den anderen Ebern weg und kämpfe mit voller Gesundheit.",
}
