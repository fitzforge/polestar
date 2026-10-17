-- German (deDE): the guide forever/alliance/40-50/07-un-goro-crater (forever/alliance/40-50/07-un-goro-crater.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thelsamar
	-- {npc:6734} Innkeeper Hearthstove
	["{npc:6734}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6734}: Der letzte Guide bringt dich per Ruhestein hierher, daher ist das meist sofort abgehakt",

	-- Step 2: Gadgetzan
	-- {area:144} Thelsamar · {area:150} Menethil Harbor · {area:976} Gadgetzan · {npc:9619} Torwa Pathfinder
	["From {area:144} fly to {area:150}, take the boat to Theramore and fly on to {area:976}. {npc:9619}'s first quest in the crater needs level 48: finish the level here if you are short."] = "Flieg von {area:144} nach {area:150}, nimm das Boot nach Theramore und flieg weiter nach {area:976}. {npc:9619}s erste Quest im Krater erfordert Stufe 48: Mach die Stufe hier voll, falls dir etwas fehlt.",
	-- {area:976} Gadgetzan
	["grind on the Wastewanderers or Dunemaul ogres around {area:976}"] = "Grinde an den Wüstenläufern oder den Ogern der Dünenbrecher um {area:976}",

	-- Step 3: Torwa Pathfinder
	-- {area:976} Gadgetzan · {zone:1449} Un'Goro Crater · {npc:9619} Torwa Pathfinder
	["Ride west out of {area:976} to the long ramp down into {zone:1449}. {npc:9619} camps at the foot of the ramp, in the south-east corner of the crater."] = "Reite nach Westen aus {area:976} hinaus zur langen Rampe hinab in den {zone:1449}. {npc:9619} lagert am Fuß der Rampe, in der Südostecke des Kraters.",

	-- Step 4: Fresh Threshadon Carcass
	-- {npc:9619} Torwa Pathfinder
	["The dead Threshadon lies by the water north of {npc:9619}."] = "Der tote Dreschadon liegt am Wasser nördlich von {npc:9619}.",

	-- Step 6: Lar'korwi Mates and the raft
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["Lar'korwi Mates and the raft"] = "Lar'korwi-Weibchen und das Floß",
	-- {npc:9619} Torwa Pathfinder · {npc:8737} Linken · {item:11116} A Mangled Journal
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["The Lar'korwi Mates prowl the jungle west of {npc:9619}. The wrecked raft lies on the shore of the lake there; the small pack sits in the water beside it. Keep the compass, map and key for {npc:8737}. Any beast in the crater may drop {item:11116}: right-click it."] = "Die Lar'korwi-Weibchen streifen durch den Dschungel westlich von {npc:9619}. Das zerstörte Floß liegt dort am Seeufer; das kleine Bündel liegt daneben im Wasser. Behalte Kompass, Karte und Schlüssel für {npc:8737}. Jedes Wildtier im Krater kann {item:11116} fallen lassen: Rechtsklick darauf.",

	-- Step 8: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {object:157936} Un'Goro Dirt Pile
	["Ride north along the east side of the crater to {area:541}, the camp in the caves of the northern cliff. Give the elite devilsaurs and stegodons a wide berth. Pick up every Power Crystal and {object:157936} you pass from here on."] = "Reite an der Ostseite des Kraters nach Norden zu {area:541}, dem Lager in den Höhlen der Nordklippe. Mach einen großen Bogen um die Elite-Teufelssaurier und Stegodons. Sammle ab hier jeden Machtkristall und jede {object:157936} ein, an denen du vorbeikommst.",
	["Gryfe"] = "Gryfe",
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}: keep it"] = "Endet bei {npc:9298} in {zone:1452}: Behalte es",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, at the back of the cave"] = "{npc:9117}, hinten in der Höhle",

	-- Step 9: Karna Remtravel
	-- {npc:9618} Karna Remtravel
	["{npc:9618} stands just outside the refuge."] = "{npc:9618} steht gleich vor der Zuflucht.",

	-- Step 10: Fire Plume Ridge and the eastern jungle
	-- {area:537} Fire Plume Ridge
	["{area:537} and the eastern jungle"] = "{area:537} und der östliche Dschungel",
	-- {area:537} Fire Plume Ridge · {item:11113} Crate of Foodstuffs
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher
	["Ride south to {area:537} in the middle of the crater, then east into the eastern jungle. Crystal clusters stand all over the crater, many of them around {area:537}: take a few extra of each colour. Bloodpetal Lashers and Threshers drop the petals; the expedition's {item:11113} sits at an abandoned camp in the eastern jungle."] = "Reite nach Süden zum {area:537} in der Mitte des Kraters, dann nach Osten in den östlichen Dschungel. Kristallhaufen stehen überall im Krater, viele davon um den {area:537}: Nimm von jeder Farbe ein paar extra. Blutblütenpeitscher und Blutblütendrescher lassen die Blütenblätter fallen; die {item:11113} der Expedition liegt in einem verlassenen Lager im östlichen Dschungel.",

	-- Step 11: A-Me 01
	-- {area:1943} Ironstone Plateau
	["Ride north to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "Reite nach Norden zum {area:1943}, wo der Roboter zwischen den Gorillas steht. Bleib dort aus der tiefen Höhle fern.",

	-- Step 12: Zul'Farrak (optional)
	-- {area:978} Zul'Farrak
	["{area:978} (optional)"] = "{area:978} (optional)",
	-- {area:978} Zul'Farrak · {zone:1446} Tanaris · {area:976} Gadgetzan
	["Running {area:978} instead of grinding gets you there faster in a group. The troll city lies in the north-west of {zone:1446}, just north of {area:976}."] = "{area:978} statt Grinden bringt dich in einer Gruppe schneller ans Ziel. Die Trollstadt liegt im Nordwesten von {zone:1446}, gleich nördlich von {area:976}.",

	-- Step 13: Grind to 50
	["Grind to 50"] = "Grinde bis 50",
	-- {area:1943} Ironstone Plateau · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	["The gorillas of {area:1943} come in small groups and drop nothing for you yet; {npc:9619}'s pelt quest comes later. Stay out of the deepest cave: {npc:9622} is level 55."] = "Die Gorillas vom {area:1943} kommen in kleinen Gruppen und lassen für dich noch nichts fallen; {npc:9619}s Fellquest kommt später. Bleib aus der tiefsten Höhle fern: {npc:9622} ist Stufe 55.",
	-- {npc:6514} Un'Goro Gorilla · {area:1943} Ironstone Plateau · {zone:1449} Un'Goro Crater
	["grind on {npc:6514} at {area:1943}, {zone:1449}"] = "Grinde an {npc:6514} auf dem {area:1943}, {zone:1449}",

	-- Step 14: Marshal's Refuge
	["Ride west back to the refuge."] = "Reite nach Westen zurück zur Zuflucht.",
	-- {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["For {npc:7775} in {zone:1444}: keep it"] = "Für {npc:7775} in {zone:1444}: Behalte es",
	-- {npc:9997} Spraggle Frock
	["The wooden sign beside {npc:9997}"] = "Das Holzschild neben {npc:9997}",
	-- {npc:9998} Shizzle
	["{npc:9998}, at the refuge entrance"] = "{npc:9998}, am Eingang der Zuflucht",

	-- Step 15: Northern Pylon
	["Northern Pylon"] = "Nördlicher Kristallpylon",
	-- {npc:9166} Pterrordax · {npc:9997} Spraggle Frock · {npc:9998} Shizzle
	["The pylon stands on the slope east of the refuge. {npc:9166} circle the slopes around it: they count for {npc:9997} and drop {npc:9998}'s scales."] = "Der Pylon steht am Hang östlich der Zuflucht. {npc:9166} kreisen über den Hängen darum: Sie zählen für {npc:9997} und lassen die Schuppen für {npc:9998} fallen.",

	-- Step 16: The east side
	["The east side"] = "Die Ostseite",
	-- {npc:9165} Fledgling Pterrordax · {npc:9998} Shizzle
	-- plural, as words: Young Diemetradons = {npc:9162} Young Diemetradon
	["Ride south down the east side. Young Diemetradons graze the eastern jungle and {npc:9165} fly near the eastern cliffs; both drop {npc:9998}'s scales."] = "Reite an der Ostseite nach Süden. Junge Dimetrodons grasen im östlichen Dschungel, und {npc:9165} fliegen nahe den östlichen Klippen; beide lassen die Schuppen für {npc:9998} fallen.",

	-- Step 17: Eastern Pylon
	["Eastern Pylon"] = "Östlicher Kristallpylon",
	["The pylon stands on the eastern cliffs."] = "Der Pylon steht auf den östlichen Klippen.",

	-- Step 18: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Ride south along the eastern cliffs to {npc:9619} at the foot of the ramp."] = "Reite an den östlichen Klippen entlang nach Süden zu {npc:9619} am Fuß der Rampe.",
	["The pelts come after loop 2, on the gorilla plateau"] = "Die Felle kommen nach Runde 2, auf dem Gorillaplateau",

	-- Step 19: The Gorishi hive
	["The Gorishi hive"] = "Der Gorishi-Bau",
	-- {npc:9619} Torwa Pathfinder · {quest:3764} Un'Goro Soil · {npc:9166} Pterrordax
	["Ride west from {npc:9619}: the silithid hive fills the south of the crater. Use the Scraping Vial on a hatchery, a chamber with hanging larvae. Gorishi wasps and workers drop {quest:3764}; {npc:9166} nest on the southern cliffs if you still need kills."] = "Reite von {npc:9619} nach Westen: Der Silithidenbau füllt den Süden des Kraters. Benutze die Kratzphiole an einer Brutstätte, einer Kammer mit hängenden Larven. Wespen und Arbeiter der Gorishi lassen {quest:3764} fallen; {npc:9166} nisten an den Südklippen, falls dir noch Kills fehlen.",

	-- Step 20: Bones and equipment
	["Bones and equipment"] = "Knochen und Ausrüstung",
	-- {item:11112} Research Equipment
	-- plural, as words: Dinosaur Bones = {item:11114} Dinosaur Bone
	["Dinosaur Bones lie on the ground in the south-west, among the stegodons: those are elite, pick the bones up around them and take the rest from Diemetradons. The expedition's {item:11112} lies in the south-west jungle."] = "Dinosaurierknochen liegen im Südwesten auf dem Boden, zwischen den Stegodons: Die sind Elite, sammle die Knochen um sie herum auf und hol den Rest von Dimetrodons. Die {item:11112} der Expedition liegt im südwestlichen Dschungel.",

	-- Step 21: Western Pylon
	["Western Pylon"] = "Westlicher Kristallpylon",
	-- {npc:9167} Frenzied Pterrordax
	["The pylon stands on the western cliffs. {npc:9167} fly over the whole west side."] = "Der Pylon steht auf den westlichen Klippen. {npc:9167} fliegen über die ganze Westseite.",

	-- Step 22: Marshal's Refuge
	["Ride north along the western jungle back to the refuge."] = "Reite durch den westlichen Dschungel nach Norden zurück zur Zuflucht.",
	-- {npc:9998} Shizzle
	["{npc:9998}, at the refuge's entrance"] = "{npc:9998}, am Eingang der Zuflucht",

	-- Step 23: Spraggle Frock
	-- {npc:9997} Spraggle Frock · {npc:9999} Ringo
	["{npc:9997}'s friend {npc:9999} has gone missing."] = "{npc:9997}s Freund {npc:9999} wird vermisst.",

	-- Step 24: Ironstone Plateau
	-- {area:1943} Ironstone Plateau · {area:541} Marshal's Refuge · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55."] = "Die Gorillas leben auf dem {area:1943}, östlich von {area:541}. Behalte ihre Felle für {npc:9619}. Bleib aus der tiefsten Höhle fern: {npc:9622} ist Stufe 55.",

	-- Step 25: Ringo
	-- {npc:9999} Ringo · {area:537} Fire Plume Ridge
	["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999} sitzt am Südosthang des {area:537}, in der Mitte des Kraters.",

	-- Step 26: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "Eskortiere {npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Führ {npc:9999} nach Norden zu {area:541}. Wenn er ohnmächtig wird, benutze {item:11804} an ihm, um ihn zu wecken.",

	-- Step 28: Sunken Temple
	-- {area:1417} Sunken Temple
	["Running the {area:1417} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "Der {area:1417} statt Grinden bringt dich in einer Gruppe schneller ans Ziel. Überspring diesen Schritt, um allein zu grinden.",

	-- Step 29: Grind to 51
	["Grind to 51"] = "Grinde bis 51",
	-- {area:982} Noxious Lair · {zone:1446} Tanaris
	["The Centipaar silithid crawl around the {area:982} in western {zone:1446}, just east of the crater ramp. The Workers are the easiest pulls."] = "Die Silithiden der Centipaar krabbeln um die {area:982} im Westen von {zone:1446}, gleich östlich der Kraterrampe. Die Arbeiter sind am leichtesten zu ziehen.",
	-- {npc:5458} Centipaar Worker · {area:982} Noxious Lair · {zone:1446} Tanaris
	["grind on {npc:5458} at {area:982}, {zone:1446}"] = "Grinde an {npc:5458} bei {area:982}, {zone:1446}",

	-- Step 30: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "Reite die Rampe hinab in den Krater: {npc:9619} lagert an ihrem Fuß.",

	-- Step 31: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder · {item:11568} Torwa's Pouch
	["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "Der Bau von {npc:9684} liegt im Dschungel nördlich von {npc:9619}, unterhalb der östlichen Klippen: Benutze dort {item:11568}. {npc:9684} ist Stufe 56: Fang mit voller Gesundheit an.",

	-- Step 33: U'cha
	-- {npc:9622} U'cha
	["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "Reite an der Ostseite nach Norden zum Gorillaplateau. {npc:9622}, ein Gorilla der Stufe 55, sitzt in dessen tiefster Höhle: Säubere zuerst die Gorillas am Höhleneingang.",

	-- Step 34: Krakle
	-- {area:541} Marshal's Refuge · {area:543} Golakka Hot Springs · {npc:10302} Krakle
	["Ride west past {area:541} and south down the western side to {area:543}: {npc:10302} the goblin sits by the water."] = "Reite nach Westen an {area:541} vorbei und an der Westseite nach Süden zu {area:543}: {npc:10302}, der Goblin, sitzt am Wasser.",

	-- Step 35: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "Reite nach Osten zum {area:537}, klettere hinauf und benutze {npc:10541} an den Lavaschloten nahe dem Gipfel.",

	-- Step 37: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Cross the south of the crater to {npc:9619} by the ramp."] = "Durchquere den Süden des Kraters zu {npc:9619} an der Rampe.",

	-- Step 39: Ironforge
	-- {area:144} Thelsamar · {area:1537} Ironforge
	["Fly from {area:144} to {area:1537}."] = "Flieg von {area:144} nach {area:1537}.",

	-- Step 41: Tinker Town
	-- {npc:9616} Laris Geardawdle · {zone:1448} Felwood
	["{npc:9616}: the oozes are in {zone:1448}, keep it"] = "{npc:9616}: Die Schlammbestien sind in {zone:1448}, behalte es",

	-- Step 42: Mystic Ward
	-- {zone:1447} Azshara
	["Four rune rubbings in {zone:1447}: keep it"] = "Vier Runenabriebe in {zone:1447}: Behalte es",
	-- {npc:11406} High Priest Rohan · {zone:1447} Azshara
	["{npc:11406}: for Ogtinc in {zone:1447}, keep it"] = "{npc:11406}: für Ogtinc in {zone:1447}, behalte es",

	-- Step 43: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}."] = "Archesonus steht neben König Magni im {object:171709}.",
	-- {zone:1428} Burning Steppes
	["The relics are in the {zone:1428}: keep it"] = "Die Relikte sind in der {zone:1428}: Behalte es",

	-- Step 44: Bind and train
	["Bind and train"] = "Binden und trainieren",

	-- Step 45: Xiggs Fuselighter
	-- {object:32359} Military Ward (no name in this language: may be words)
	["Xiggs waits in the {object:32359}."] = "Xiggs wartet im {object:32359}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["grind on {npc:5458} at {area:982}, {zone:1446}"] = "Grinde an {npc:5458} bei der {area:982}, {zone:1446}",
}
