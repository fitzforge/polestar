-- Chinese (traditional) (zhTW): the guide forever/professions/fishing-cooking (forever/professions/fishing-cooking.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Fishing and Cooking
	-- {skill:356} Fishing · {skill:185} Cooking
	["Learn {skill:356} and {skill:185}"] = "",
	-- {skill:356} Fishing · {skill:185} Cooking · {item:6256} Fishing Pole · {object:29784} Basic Campfire · {item:279981} Basic Campfire Kit · {item:4470} Simple Wood · {item:4471} Flint and Tinder · {item:279967} Fish Bowl
	["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} (1s) and any {skill:185} trainer Apprentice {skill:185} (1s), at any character level; the arrow picks the nearest of each, and every starting area has both. Buy a {item:6256} (23c) and equip it (you can only fish with a pole in your hands). Forever: every cook knows {object:29784}: a {item:279981} from one {item:4470} with {item:4471} lights a cooking fire anywhere, so you can cook beside the water. If you sat at your starting area's campfire for The Great Outdoors, its camping guide also offers Camping 101: {skill:356} (handed in at {skill:356} 20 for the {item:279967} recipe) and Camping 101: {skill:185}."] = "",

	-- Step 2: Recipes for Elwynn Forest (Cooking to 50)
	-- {zone:1429} Elwynn Forest · {skill:185} Cooking
	["Recipes for {zone:1429} ({skill:185} to 50)"] = "",
	-- {item:6325} Recipe: Brilliant Smallfish · {skill:185} Cooking · {npc:66} Tharynn Bouden · {zone:1429} Elwynn Forest
	["Before the round: {item:6325} ({skill:185} 1, 40c: {npc:66}, {zone:1429}). A recipe teaches itself when you use it from your bags."] = "",

	-- Step 3: Lures for Elwynn Forest
	-- {zone:1429} Elwynn Forest
	["Lures for {zone:1429}"] = "",
	-- {skill:356} Fishing · {item:6529} Shiny Bauble
	["This water loses fish below {skill:356} 25: a lure on the pole adds to your skill for ten minutes. {item:6529} (+25, 50c each) closes the gap from 1; three see you through."] = "",

	-- Step 4: Fishing: Elwynn Forest (1-75)
	-- {skill:356} Fishing · {item:6291} Raw Brilliant Smallfish · {item:6289} Raw Longjaw Mud Snapper
	["Fish the round until {skill:356} 75 and until your bags hold 50 {item:6291} for the cooking: about 80 catches (below 75 every catch raises the skill). The arrow leads stand to stand: stay while the fish bite (casting holds the arrow there), walk on when a pool is fished out or the spot is busy. What bites here (players' catches at these stands): {item:6291} (61%), {item:6289} (37%). This water loses fish below skill 25: keep a lure on the pole until then."] = "",

	-- Step 5: Fishing: Elwynn Forest (1-75)
	-- {skill:185} Cooking · {skill:356} Fishing
	["Your {skill:185} is past 50, so there are no fish to keep: fish the round until {skill:356} 75, about 70 catches."] = "",

	-- Step 6: Cook Brilliant Smallfish (1-50)
	-- {item:6290} Brilliant Smallfish
	["Cook {item:6290} (1-50)"] = "",
	-- {item:6290} Brilliant Smallfish · {item:6291} Raw Brilliant Smallfish · {object:29784} Basic Campfire
	["{item:6290} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50, 50 {item:6291}. Cook at any fire: a town hearth or your own {object:29784}. Short of fish: fish the round a little longer."] = "",

	-- Step 7: Journeyman Cooking
	-- {skill:185} Cooking
	["Journeyman {skill:185}"] = "中級{skill:185}",
	-- {skill:185} Cooking
	["Journeyman {skill:185} raises the cap to 150; it needs skill 50 and no character level, and costs 5s. The arrow picks the nearest {skill:185} trainer of your faction."] = "",

	-- Step 8: Recipes for Dun Morogh (Cooking to 50)
	-- {zone:1426} Dun Morogh · {skill:185} Cooking
	["Recipes for {zone:1426} ({skill:185} to 50)"] = "",
	-- {item:6325} Recipe: Brilliant Smallfish · {skill:185} Cooking · {npc:8508} Gretta Ganter · {zone:1426} Dun Morogh
	["Before the round: {item:6325} ({skill:185} 1, 40c: {npc:8508}, {zone:1426}). A recipe teaches itself when you use it from your bags."] = "",

	-- Step 9: Lures for Dun Morogh
	-- {zone:1426} Dun Morogh
	["Lures for {zone:1426}"] = "",

	-- Step 10: Fishing: Dun Morogh (1-75)
	-- {skill:356} Fishing · {item:6291} Raw Brilliant Smallfish · {item:6289} Raw Longjaw Mud Snapper
	["Fish the round until {skill:356} 75 and until your bags hold 50 {item:6291} for the cooking: about 80 catches (below 75 every catch raises the skill). What bites here (players' catches at these stands): {item:6291} (60%), {item:6289} (37%). This water loses fish below skill 25: keep a lure on the pole until then."] = "",

	-- Step 14: Recipes for Teldrassil (Cooking to 50)
	-- {zone:1438} Teldrassil · {skill:185} Cooking
	["Recipes for {zone:1438} ({skill:185} to 50)"] = "",
	-- {item:6326} Recipe: Slitherskin Mackerel · {skill:185} Cooking · {npc:10118} Nessa Shadowsong · {zone:1438} Teldrassil
	["Before the round: {item:6326} ({skill:185} 1, 40c: {npc:10118}, {zone:1438}). A recipe teaches itself when you use it from your bags."] = "",

	-- Step 15: Lures for Teldrassil
	-- {zone:1438} Teldrassil
	["Lures for {zone:1438}"] = "",

	-- Step 16: Fishing: Teldrassil (1-75)
	-- {skill:356} Fishing · {item:6303} Raw Slitherskin Mackerel · {object:2843} Battered Chest
	["Fish the round until {skill:356} 75 and until your bags hold 50 {item:6303} for the cooking: about 70 catches (below 75 every catch raises the skill). The arrow leads stand to stand: stay while the fish bite (casting holds the arrow there), walk on when a pool is fished out or the spot is busy. What bites here (players' catches at these stands): {item:6303} (96%), {object:2843} (4%). This water loses fish below skill 25: keep a lure on the pole until then."] = "",

	-- Step 18: Cook Slitherskin Mackerel (1-50)
	-- {item:787} Slitherskin Mackerel
	["Cook {item:787} (1-50)"] = "",
	-- {item:787} Slitherskin Mackerel · {item:6303} Raw Slitherskin Mackerel · {object:29784} Basic Campfire
	["{item:787} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50, 50 {item:6303}. Cook at any fire: a town hearth or your own {object:29784}. Short of fish: fish the round a little longer."] = "",

	-- Step 20: Recipes for Zephras Isle (Cooking to 50)
	-- {zone:2521} Zephras Isle · {skill:185} Cooking
	["Recipes for {zone:2521} ({skill:185} to 50)"] = "",
	-- {item:6325} Recipe: Brilliant Smallfish · {skill:185} Cooking · {npc:257006} Nyalah Brightfire · {zone:2521} Zephras Isle
	["Before the round: {item:6325} ({skill:185} 1, 40c: {npc:257006}, {zone:2521}). A recipe teaches itself when you use it from your bags."] = "",

	-- Step 21: Fishing: Zephras Isle (1-75)
	-- {skill:356} Fishing · {item:6291} Raw Brilliant Smallfish · {item:6289} Raw Longjaw Mud Snapper
	["Fish the round until {skill:356} 75 and until your bags hold 50 {item:6291} for the cooking: about 80 catches (below 75 every catch raises the skill). The arrow leads stand to stand: stay while the fish bite (casting holds the arrow there), walk on when a pool is fished out or the spot is busy. What bites here (players' catches at these stands): {item:6291} (59%), {item:6289} (39%)."] = "",

	-- Step 25: Recipes for Durotar (Cooking to 50)
	-- {zone:1411} Durotar · {skill:185} Cooking
	["Recipes for {zone:1411} ({skill:185} to 50)"] = "",
	-- {item:6326} Recipe: Slitherskin Mackerel · {skill:185} Cooking · {npc:5942} Zansoa · {zone:1411} Durotar
	["Before the round: {item:6326} ({skill:185} 1, 40c: {npc:5942}, {zone:1411}). A recipe teaches itself when you use it from your bags."] = "",

	-- Step 26: Lures for Durotar
	-- {zone:1411} Durotar
	["Lures for {zone:1411}"] = "",

	-- Step 27: Fishing: Durotar (1-75)
	-- {skill:356} Fishing · {item:6303} Raw Slitherskin Mackerel
	["Fish the round until {skill:356} 75 and until your bags hold 50 {item:6303} for the cooking: about 70 catches (below 75 every catch raises the skill). What bites here (players' catches at these stands): {item:6303} (98%). This water loses fish below skill 25: keep a lure on the pole until then."] = "",

	-- Step 31: Recipes for Mulgore (Cooking to 50)
	-- {zone:1412} Mulgore · {skill:185} Cooking
	["Recipes for {zone:1412} ({skill:185} to 50)"] = "",
	-- {item:6325} Recipe: Brilliant Smallfish · {skill:185} Cooking · {npc:5940} Harn Longcast · {zone:1412} Mulgore
	["Before the round: {item:6325} ({skill:185} 1, 40c: {npc:5940}, {zone:1412}). A recipe teaches itself when you use it from your bags."] = "",

	-- Step 32: Lures for Mulgore
	-- {zone:1412} Mulgore
	["Lures for {zone:1412}"] = "",

	-- Step 33: Fishing: Mulgore (1-75)
	-- {skill:356} Fishing · {item:6291} Raw Brilliant Smallfish · {item:6289} Raw Longjaw Mud Snapper
	["Fish the round until {skill:356} 75 and until your bags hold 50 {item:6291} for the cooking: about 80 catches (below 75 every catch raises the skill). What bites here (players' catches at these stands): {item:6291} (63%), {item:6289} (35%). This water loses fish below skill 25: keep a lure on the pole until then."] = "",

	-- Step 37: Recipes for Tirisfal Glades (Cooking to 50)
	-- {zone:1420} Tirisfal Glades · {skill:185} Cooking
	["Recipes for {zone:1420} ({skill:185} to 50)"] = "",
	-- {item:6325} Recipe: Brilliant Smallfish · {skill:185} Cooking · {npc:3550} Martine Tramblay · {zone:1420} Tirisfal Glades
	["Before the round: {item:6325} ({skill:185} 1, 40c: {npc:3550}, {zone:1420}). A recipe teaches itself when you use it from your bags."] = "",

	-- Step 38: Lures for Tirisfal Glades
	-- {zone:1420} Tirisfal Glades
	["Lures for {zone:1420}"] = "",

	-- Step 39: Fishing: Tirisfal Glades (1-75)
	-- {skill:356} Fishing · {item:6291} Raw Brilliant Smallfish · {item:6289} Raw Longjaw Mud Snapper · {item:6299} Sickly Looking Fish · {item:6297} Old Skull
	["Fish the round until {skill:356} 75 and until your bags hold 50 {item:6291} for the cooking: about 100 catches (below 75 every catch raises the skill). The arrow leads stand to stand: stay while the fish bite (casting holds the arrow there), walk on when a pool is fished out or the spot is busy. What bites here (players' catches at these stands): {item:6291} (48%), {item:6289} (29%), {item:6299} (15%), {item:6297} (5%). This water loses fish below skill 25: keep a lure on the pole until then."] = "",

	-- Step 43: Journeyman Fishing
	-- {skill:356} Fishing
	["Journeyman {skill:356}"] = "中級{skill:356}",
	-- {skill:356} Fishing
	["Journeyman {skill:356} raises the cap to 150; it needs skill 50 and character level 10 (Forever's trainer lists ask for that level), and costs 5s. The arrow picks the nearest {skill:356} trainer of your faction."] = "",

	-- Step 44: Recipes for Stormwind City (Cooking to 140)
	-- {zone:1453} Stormwind City · {skill:185} Cooking
	["Recipes for {zone:1453} ({skill:185} to 140)"] = "",
	-- {item:6328} Recipe: Longjaw Mud Snapper · {skill:185} Cooking · {npc:66} Tharynn Bouden · {zone:1429} Elwynn Forest · {npc:5162} Tansy Puddlefizz · {zone:1455} Ironforge · {item:6330} Recipe: Bristle Whisker Catfish · {npc:5494} Catherine Leland · {zone:1453} Stormwind City
	["Before the round: {item:6328} ({skill:185} 50, 4s: {npc:66}, {zone:1429}, or {npc:5162}, {zone:1455}) and {item:6330} ({skill:185} 100, 12s: {npc:5494}, {zone:1453}). A recipe teaches itself when you use it from your bags."] = "",

	-- Step 45: Fishing: Stormwind City (75-150)
	-- {skill:356} Fishing · {item:6289} Raw Longjaw Mud Snapper · {item:6308} Raw Bristle Whisker Catfish · {item:6291} Raw Brilliant Smallfish · {npc:267118} Gilbert Gray · {item:6529} Shiny Bauble · {item:6530} Nightcrawlers
	["Fish the round until {skill:356} 150 and until your bags hold 52 {item:6289} and 40 {item:6308} for the cooking: about 190 catches (from 75 a catch raises the skill less often: one in two by 100, one in seven by 225). The arrow leads stand to stand: stay while the fish bite (casting holds the arrow there), walk on when a pool is fished out or the spot is busy. What bites here (players' catches at these stands): {item:6289} (61%), {item:6308} (21%), {item:6291} (17%). From skill 75 this water loses no fish. From level 7, {npc:267118} at the harbor gives Fishin' Time: bring 1 {item:6529} and 3 {item:6530} for cooked fish."] = "",

	-- Step 46: Fishing: Stormwind City (75-150)
	-- {skill:185} Cooking · {skill:356} Fishing
	["Your {skill:185} is past 140, so there are no fish to keep: fish the round until {skill:356} 150, about 190 catches."] = "",

	-- Step 47: Cook Longjaw Mud Snapper (50-100)
	-- {item:4592} Longjaw Mud Snapper
	["Cook {item:4592} (50-100)"] = "",
	-- {item:4592} Longjaw Mud Snapper · {item:6289} Raw Longjaw Mud Snapper · {object:29784} Basic Campfire
	["{item:4592} is orange from 50 (yellow at 90, green at 110, grey at 130): about 52 crafts to 100, 52 {item:6289}. Cook at any fire: a town hearth or your own {object:29784}. Short of fish: fish the round a little longer."] = "",

	-- Step 48: Cook Bristle Whisker Catfish (100-140)
	-- {item:4593} Bristle Whisker Catfish
	["Cook {item:4593} (100-140)"] = "",
	-- {item:4593} Bristle Whisker Catfish · {item:6308} Raw Bristle Whisker Catfish · {object:29784} Basic Campfire
	["{item:4593} is orange from 100 (yellow at 140, green at 160, grey at 180): about 40 crafts to 140, 40 {item:6308}. Cook at any fire: a town hearth or your own {object:29784}. Short of fish: fish the round a little longer."] = "",

	-- Step 49: Recipes for Ironforge (Cooking to 140)
	-- {zone:1455} Ironforge · {skill:185} Cooking
	["Recipes for {zone:1455} ({skill:185} to 140)"] = "",
	-- {item:6328} Recipe: Longjaw Mud Snapper · {skill:185} Cooking · {npc:5162} Tansy Puddlefizz · {zone:1455} Ironforge · {item:6330} Recipe: Bristle Whisker Catfish · {npc:2383} Lindea Rabonne · {zone:1424} Hillsbrad Foothills · {npc:5494} Catherine Leland · {zone:1453} Stormwind City
	["Before the round: {item:6328} ({skill:185} 50, 4s: {npc:5162}, {zone:1455}) and {item:6330} ({skill:185} 100, 12s: {npc:2383}, {zone:1424}, or {npc:5494}, {zone:1453}). A recipe teaches itself when you use it from your bags."] = "",

	-- Step 50: Fishing: Ironforge (75-150)
	-- {skill:356} Fishing · {item:6289} Raw Longjaw Mud Snapper · {item:6308} Raw Bristle Whisker Catfish · {item:6291} Raw Brilliant Smallfish
	["Fish the round until {skill:356} 150 and until your bags hold 52 {item:6289} and 40 {item:6308} for the cooking: about 300 catches (from 75 a catch raises the skill less often: one in two by 100, one in seven by 225). What bites here (players' catches at these stands): {item:6289} (66%), {item:6291} (19%), {item:6308} (14%). From skill 75 this water loses no fish."] = "",

	-- Step 54: Recipes for Darnassus (Cooking to 140)
	-- {zone:1457} Darnassus · {skill:185} Cooking
	["Recipes for {zone:1457} ({skill:185} to 140)"] = "",
	-- {item:6328} Recipe: Longjaw Mud Snapper · {skill:185} Cooking · {npc:4265} Nyoma · {zone:1438} Teldrassil · {item:6330} Recipe: Bristle Whisker Catfish · {npc:3497} Kilxx · {zone:1413} The Barrens
	["Before the round: {item:6328} ({skill:185} 50, 4s: {npc:4265}, {zone:1438}) and {item:6330} ({skill:185} 100, 12s: {npc:3497}, {zone:1413}). A recipe teaches itself when you use it from your bags."] = "",

	-- Step 55: Fishing: Darnassus (75-150)
	-- {skill:356} Fishing · {item:6289} Raw Longjaw Mud Snapper · {item:6308} Raw Bristle Whisker Catfish · {item:6291} Raw Brilliant Smallfish
	["Fish the round until {skill:356} 150 and until your bags hold 52 {item:6289} and 40 {item:6308} for the cooking: about 190 catches (from 75 a catch raises the skill less often: one in two by 100, one in seven by 225). What bites here (players' catches at these stands): {item:6289} (62%), {item:6308} (22%), {item:6291} (16%). From skill 75 this water loses no fish."] = "",

	-- Step 59: Recipes for Orgrimmar (Cooking to 140)
	-- {zone:1454} Orgrimmar · {skill:185} Cooking
	["Recipes for {zone:1454} ({skill:185} to 140)"] = "",
	-- {item:6328} Recipe: Longjaw Mud Snapper · {skill:185} Cooking · {npc:3027} Naal Mistrunner · {zone:1456} Thunder Bluff · {npc:5940} Harn Longcast · {zone:1412} Mulgore · {item:6330} Recipe: Bristle Whisker Catfish · {npc:3497} Kilxx · {zone:1413} The Barrens · {npc:3029} Sewa Mistrunner
	["Before the round: {item:6328} ({skill:185} 50, 4s: {npc:3027}, {zone:1456}, or {npc:5940}, {zone:1412}) and {item:6330} ({skill:185} 100, 12s: {npc:3497}, {zone:1413}, or {npc:3029}, {zone:1456}). A recipe teaches itself when you use it from your bags."] = "",

	-- Step 60: Fishing: Orgrimmar (75-150)
	-- {skill:356} Fishing · {item:6289} Raw Longjaw Mud Snapper · {item:6308} Raw Bristle Whisker Catfish · {item:6291} Raw Brilliant Smallfish
	["Fish the round until {skill:356} 150 and until your bags hold 52 {item:6289} and 40 {item:6308} for the cooking: about 200 catches (from 75 a catch raises the skill less often: one in two by 100, one in seven by 225). The arrow leads stand to stand: stay while the fish bite (casting holds the arrow there), walk on when a pool is fished out or the spot is busy. What bites here (players' catches at these stands): {item:6289} (60%), {item:6308} (20%), {item:6291} (19%). From skill 75 this water loses no fish."] = "",

	-- Step 64: Recipes for Thunder Bluff (Cooking to 140)
	-- {zone:1456} Thunder Bluff · {skill:185} Cooking
	["Recipes for {zone:1456} ({skill:185} to 140)"] = "",
	-- {item:6328} Recipe: Longjaw Mud Snapper · {skill:185} Cooking · {npc:3027} Naal Mistrunner · {zone:1456} Thunder Bluff · {item:6330} Recipe: Bristle Whisker Catfish
	["Before the round: {item:6328} ({skill:185} 50, 4s: {npc:3027}, {zone:1456}) and {item:6330} ({skill:185} 100, 12s: {npc:3027}, {zone:1456}). A recipe teaches itself when you use it from your bags."] = "",

	-- Step 65: Fishing: Thunder Bluff (75-150)
	-- {skill:356} Fishing · {item:6289} Raw Longjaw Mud Snapper · {item:6308} Raw Bristle Whisker Catfish · {item:6291} Raw Brilliant Smallfish
	["Fish the round until {skill:356} 150 and until your bags hold 52 {item:6289} and 40 {item:6308} for the cooking: about 190 catches (from 75 a catch raises the skill less often: one in two by 100, one in seven by 225). The arrow leads stand to stand: stay while the fish bite (casting holds the arrow there), walk on when a pool is fished out or the spot is busy. What bites here (players' catches at these stands): {item:6289} (56%), {item:6308} (23%), {item:6291} (20%). From skill 75 this water loses no fish."] = "",

	-- Step 69: Recipes for Undercity (Cooking to 140)
	-- {zone:1458} Undercity · {skill:185} Cooking
	["Recipes for {zone:1458} ({skill:185} to 140)"] = "",
	-- {item:6328} Recipe: Longjaw Mud Snapper · {skill:185} Cooking · {npc:4574} Lizbeth Cromwell · {zone:1458} Undercity · {item:6330} Recipe: Bristle Whisker Catfish · {npc:4553} Ronald Burch
	["Before the round: {item:6328} ({skill:185} 50, 4s: {npc:4574}, {zone:1458}) and {item:6330} ({skill:185} 100, 12s: {npc:4553}, {zone:1458}). A recipe teaches itself when you use it from your bags."] = "",

	-- Step 70: Fishing: Undercity (75-150)
	-- {skill:356} Fishing · {item:6289} Raw Longjaw Mud Snapper · {item:6308} Raw Bristle Whisker Catfish · {item:6299} Sickly Looking Fish · {item:6297} Old Skull · {item:6291} Raw Brilliant Smallfish
	["Fish the round until {skill:356} 150 and until your bags hold 52 {item:6289} and 40 {item:6308} for the cooking: about 250 catches (from 75 a catch raises the skill less often: one in two by 100, one in seven by 225). The arrow leads stand to stand: stay while the fish bite (casting holds the arrow there), walk on when a pool is fished out or the spot is busy. What bites here (players' catches at these stands): {item:6289} (45%), {item:6299} (15%), {item:6308} (15%), {item:6297} (14%), {item:6291} (11%). From skill 75 this water loses no fish."] = "",

	-- Step 74: Expert Fishing
	-- {skill:356} Fishing
	["Expert {skill:356}"] = "高級{skill:356}",
	-- {skill:356} Fishing · {item:16083} Expert Fishing - The Bass and You · {npc:2626} Old Man Heming · {zone:1434} Stranglethorn Vale · {area:35} Booty Bay · {area:392} Ratchet · {zone:1413} The Barrens · {item:6532} Bright Baubles · {item:279965} Fishing Rack · {area:2797} Blackfathom Deeps
	["Expert {skill:356} (cap 225) is a book, not a trainer rank: {item:16083} (1g), {npc:2626} ({zone:1434}) sells it to both factions. Buy it and read it; it needs skill 125 and level 20. At level 20 the safe way to {area:35} is the boat from {area:392} in {zone:1413}. {npc:2626} also sells {item:6532} (+75 from skill 100, 2s 50c each), the lure for harder water. Forever's {item:279965} (a camping item, from {skill:356} 140) is a blueprint that drops from Gelihast in {area:2797}."] = "",
	-- {item:16083} Expert Fishing - The Bass and You · {skill:356} Fishing
	["Buy and read {item:16083} (Expert {skill:356})"] = "購買並閱讀{item:16083}（高級{skill:356}）",

	-- Step 75: Expert Cooking
	-- {skill:185} Cooking
	["Expert {skill:185}"] = "高級{skill:185}",
	-- {skill:185} Cooking · {item:16072} Expert Cookbook · {npc:3955} Shandrina · {zone:1440} Ashenvale · {npc:12033} Wulan · {zone:1443} Desolace
	["Expert {skill:185} (cap 225) is a book, not a trainer rank: {item:16072} (1g), sold by {npc:3955} ({zone:1440}) for the Alliance and {npc:12033} ({zone:1443}) for the Horde. Buy it and read it; it needs skill 125 and level 20."] = "",
	-- {item:16072} Expert Cookbook · {skill:185} Cooking
	["Buy and read {item:16072} (Expert {skill:185})"] = "購買並閱讀{item:16072}（高級{skill:185}）",

	-- Step 76: Fishing: Ashenvale (150-190)
	-- {skill:356} Fishing · {item:6308} Raw Bristle Whisker Catfish · {item:6289} Raw Longjaw Mud Snapper · {item:6361} Raw Rainbow Fin Albacore · {item:21071} Raw Sagefish · {item:6358} Oily Blackmouth · {object:180656} Sagefish School
	["Fish the round until {skill:356} 190 and until your bags hold 80 {item:6308} for the cooking: about 190 catches (from 75 a catch raises the skill less often: one in two by 100, one in seven by 225). The arrow leads stand to stand: stay while the fish bite (casting holds the arrow there), walk on when a pool is fished out or the spot is busy. What bites here (the zone's fishing loot): {item:6308} (42%), {item:6289} (23%), {item:6361} (15%), {item:21071} (9%), {item:6358} (6%). {skill:356} pools by the round: {object:180656}. From skill 150 this water loses no fish."] = "",

	-- Step 77: Fishing: Ashenvale (150-190)
	-- {skill:185} Cooking · {skill:356} Fishing
	["Your {skill:185} is past 175, so there are no fish to keep: fish the round until {skill:356} 190, about 190 catches."] = "",

	-- Step 78: Cook Bristle Whisker Catfish (140-175)
	-- {item:4593} Bristle Whisker Catfish
	["Cook {item:4593} (140-175)"] = "",
	-- {item:4593} Bristle Whisker Catfish · {item:6308} Raw Bristle Whisker Catfish · {object:29784} Basic Campfire
	["{item:4593} is yellow from 140 (yellow at 140, green at 160, grey at 180): about 80 crafts to 175, 80 {item:6308}. Cook at any fire: a town hearth or your own {object:29784}. Short of fish: fish the round a little longer."] = "",

	-- Step 79: Lures for Desolace
	-- {zone:1443} Desolace
	["Lures for {zone:1443}"] = "",
	-- {skill:356} Fishing · {item:6532} Bright Baubles
	["This water loses fish below {skill:356} 225: a lure on the pole adds to your skill for ten minutes. {item:6532} (+75 from skill 100, 2s 50c each) closes the gap from 150; three see you through."] = "",

	-- Step 80: Fishing: Desolace (150-190)
	-- {skill:356} Fishing · {item:6308} Raw Bristle Whisker Catfish · {item:8365} Raw Mithril Head Trout · {object:180657} Firefin Snapper School · {object:180662} Floating Wreckage · {object:180582} Oily Blackmouth School
	["Fish the round until {skill:356} 190 and until your bags hold 80 {item:6308} for the cooking: about 250 catches (from 75 a catch raises the skill less often: one in two by 100, one in seven by 225). The arrow leads stand to stand: stay while the fish bite (casting holds the arrow there), walk on when a pool is fished out or the spot is busy. What bites here (players' catches at these stands): {item:8365} (64%), {item:6308} (33%). {skill:356} pools by the round: {object:180657}, {object:180662} and {object:180582}. This water loses fish below skill 225: keep a lure on the pole until then."] = "",

	-- Step 83: Recipes for Stranglethorn Vale (Cooking to 225)
	-- {zone:1434} Stranglethorn Vale · {skill:185} Cooking
	["Recipes for {zone:1434} ({skill:185} to 225)"] = "",
	-- {item:17062} Recipe: Mithril Head Trout · {skill:185} Cooking · {npc:2664} Kelsey Yance · {zone:1434} Stranglethorn Vale
	["Before the round: {item:17062} ({skill:185} 175, 22s: {npc:2664}, {zone:1434}). A recipe teaches itself when you use it from your bags."] = "",

	-- Step 84: Lures for Stranglethorn Vale
	-- {zone:1434} Stranglethorn Vale
	["Lures for {zone:1434}"] = "",
	-- {skill:356} Fishing · {item:6530} Nightcrawlers
	["This water loses fish below {skill:356} 225: a lure on the pole adds to your skill for ten minutes. {item:6530} (+50 from skill 50, 1s each) closes the gap from 190; three see you through."] = "",

	-- Step 85: Fishing: Stranglethorn Vale (190-225)
	-- {skill:356} Fishing · {item:8365} Raw Mithril Head Trout · {item:21153} Raw Greater Sagefish · {item:6308} Raw Bristle Whisker Catfish · {item:3820} Stranglekelp · {item:21150} Iron Bound Trunk · {item:21151} Rumsey Rum Black Label · {object:180662} Floating Wreckage · {object:180684} Greater Sagefish School
	["Fish the round until {skill:356} 225 and until your bags hold 52 {item:8365} for the cooking: about 200 catches (from 75 a catch raises the skill less often: one in two by 100, one in seven by 225). The arrow leads stand to stand: stay while the fish bite (casting holds the arrow there), walk on when a pool is fished out or the spot is busy. What bites here (players' catches at these stands): {item:8365} (43%), {item:21153} (32%), {item:6308} (17%), {item:3820} (10%), {item:21150} (4%), {item:21151} (3%). {skill:356} pools by the round: {object:180662} and {object:180684}. This water loses fish below skill 225: keep a lure on the pole until then."] = "",

	-- Step 86: Fishing: Stranglethorn Vale (190-225)
	-- {skill:185} Cooking · {skill:356} Fishing
	["Your {skill:185} is past 225, so there are no fish to keep: fish the round until {skill:356} 225, about 200 catches."] = "",

	-- Step 87: Cook Mithril Headed Trout (175-225)
	-- {spell:20916} Mithril Headed Trout
	["Cook {spell:20916} (175-225)"] = "",
	-- {spell:20916} Mithril Headed Trout · {item:8365} Raw Mithril Head Trout · {object:29784} Basic Campfire
	["{spell:20916} is orange from 175 (yellow at 215, green at 235, grey at 255): about 52 crafts to 225, 52 {item:8365}. Cook at any fire: a town hearth or your own {object:29784}. Short of fish: fish the round a little longer."] = "",

	-- Step 88: Recipes for Desolace (Cooking to 225)
	-- {zone:1443} Desolace · {skill:185} Cooking
	["Recipes for {zone:1443} ({skill:185} to 225)"] = "",
	-- {item:17062} Recipe: Mithril Head Trout · {skill:185} Cooking · {npc:12033} Wulan · {zone:1443} Desolace
	["Before the round: {item:17062} ({skill:185} 175, 22s: {npc:12033}, {zone:1443}). A recipe teaches itself when you use it from your bags."] = "",

	-- Step 90: Fishing: Desolace (190-225)
	-- {skill:356} Fishing · {item:8365} Raw Mithril Head Trout · {item:6308} Raw Bristle Whisker Catfish · {item:6362} Raw Rockscale Cod · {object:180657} Firefin Snapper School · {object:180662} Floating Wreckage · {object:180582} Oily Blackmouth School
	["Fish the round until {skill:356} 225 and until your bags hold 52 {item:8365} for the cooking: about 200 catches (from 75 a catch raises the skill less often: one in two by 100, one in seven by 225). The arrow leads stand to stand: stay while the fish bite (casting holds the arrow there), walk on when a pool is fished out or the spot is busy. What bites here (players' catches at these stands): {item:8365} (59%), {item:6308} (31%), {item:6362} (4%). {skill:356} pools by the round: {object:180657}, {object:180662} and {object:180582}. This water loses fish below skill 225: keep a lure on the pole until then."] = "",

	-- Step 93: Nat Pagle, Angler Extreme
	-- {skill:356} Fishing · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh · {zone:1455} Ironforge
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1455} sends you to him; the quest needs skill 225 and level 35."] = "專家級{skill:356}（上限300）來自{zone:1445}的{npc:12919}。{zone:1455}的釣魚訓練師會派你去找他；任務需要技能225和等級35。",

	-- Step 94: Nat Pagle, Angler Extreme
	-- {skill:356} Fishing · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh · {zone:1454} Orgrimmar
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1454} sends you to him; the quest needs skill 225 and level 35."] = "專家級{skill:356}（上限300）來自{zone:1445}的{npc:12919}。{zone:1454}的釣魚訓練師會派你去找他；任務需要技能225和等級35。",

	-- Step 95: Nat Pagle
	-- {npc:12919} Nat Pagle
	["{npc:12919} fishes from the shore of a small island off the east coast, south of Theramore; swim over from the coast."] = "{npc:12919}在塞拉摩南邊、東海岸外一座小島的岸邊釣魚；從海岸游過去。",

	-- Step 96: Sar'theris Striker
	-- {zone:1443} Desolace · {area:598} Sar'theris Strand · {area:2408} Shadowprey Village · {item:16968} Sar'theris Striker
	["Fish along the coast of {zone:1443} ({area:598} in the north-west, or the shore west of {area:2408}) until you catch a {item:16968}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "在{zone:1443}海岸（西北的{area:598}，或{area:2408}以西的岸邊）釣魚，直到釣上{item:16968}：那裡約每五竿出一竿，別處不會咬鉤。技能225時這裡不會跑魚。",

	-- Step 98: Feralas Ahi
	-- {area:2521} Verdantis River · {zone:1444} Feralas · {area:2577} Dire Maul · {item:16967} Feralas Ahi · {item:6532} Bright Baubles
	["Fish along the {area:2521} in {zone:1444} (south-east of {area:2577}) until you catch a {item:16967}: about one catch in five there brings it up, and it bites nowhere else. This water loses fish below skill 300: at 225 most get away, so put {item:6532} (+75) on the pole first."] = "在{zone:1444}的{area:2521}（{area:2577}東南）釣魚，直到釣上{item:16967}：那裡約每五竿出一竿，別處不會咬鉤。這片水域在技能300以下會跑魚：225時大部分會跑掉，所以先給魚竿裝上{item:6532}（+75）。",

	-- Step 99: Savage Coast Blue Sailfin
	-- {zone:1434} Stranglethorn Vale · {area:301} Savage Coast · {item:16969} Savage Coast Blue Sailfin
	["Fish along {zone:1434}'s {area:301} (the west shore) until you catch a {item:16969}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "在{zone:1434}的{area:301}（西岸）釣魚，直到釣上{item:16969}：那裡約每五竿出一竿，別處不會咬鉤。技能225時這裡不會跑魚。",

	-- Step 101: Misty Reed Mahi Mahi
	-- {area:300} Misty Reed Strand · {zone:1435} Swamp of Sorrows · {item:16970} Misty Reed Mahi Mahi
	["Fish along the {area:300} (the east shore of {zone:1435}) until you catch a {item:16970}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "在{area:300}（{zone:1435}東岸）釣魚，直到釣上{item:16970}：那裡約每五竿出一竿，別處不會咬鉤。技能225時這裡不會跑魚。",

	-- Step 102: Nat Pagle
	-- {skill:356} Fishing
	["Artisan {skill:356}"] = "專家級{skill:356}",

	-- Step 103: Dirge Quikcleave
	-- {skill:185} Cooking · {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {zone:1446} Tanaris · {zone:1455} Ironforge
	["Artisan {skill:185} comes from {npc:8125} in {area:976} ({zone:1446}). The cooking trainer in {zone:1455} sends you; it needs skill 225 and level 35."] = "專家級{skill:185}由{area:976}（{zone:1446}）的{npc:8125}傳授。{zone:1455}的烹飪訓練師會派你去；需要技能225和等級35。",

	-- Step 104: Dirge Quikcleave
	-- {skill:185} Cooking · {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {zone:1446} Tanaris · {zone:1454} Orgrimmar
	["Artisan {skill:185} comes from {npc:8125} in {area:976} ({zone:1446}). The cooking trainer in {zone:1454} sends you; it needs skill 225 and level 35."] = "專家級{skill:185}由{area:976}（{zone:1446}）的{npc:8125}傳授。{zone:1454}的烹飪訓練師會派你去；需要技能225和等級35。",

	-- Step 105: Giant Eggs
	-- plural, as words: Giant Eggs = {item:12207} Giant Egg
	["Giant Eggs"] = "巨蛋",
	-- {quest:6610} Clamlette Surprise · {item:7974} Zesty Clam Meat · {item:8932} Alterac Swiss · {zone:1446} Tanaris · {zone:1425} The Hinterlands · {npc:2929} Savage Owlbeast
	-- plural, as words: Giant Eggs = {item:12207} Giant Egg
	["{quest:6610} asks for 12 Giant Eggs, 10 {item:7974} and 20 {item:8932}: bring all three before you go to {zone:1446}, so you make the trip once. Giant Eggs drop from the owlbeasts of {zone:1425}: {npc:2929} (54%)."] = "",

	-- Step 106: Alterac Swiss
	-- {item:8932} Alterac Swiss
	["Innkeepers and food vendors sell {item:8932}; the arrow picks the nearest."] = "旅店老闆和食品商人都出售{item:8932}；箭頭會指向最近的一位。",

	-- Step 107: Zesty Clam Meat
	-- {item:7974} Zesty Clam Meat · {zone:1445} Dustwallow Marsh · {zone:1446} Tanaris
	-- plural, as words: Big-mouth Clams = {item:7973} Big-mouth Clam · Steeljaw Snappers = {npc:14123} Steeljaw Snapper
	["{item:7974} comes from Big-mouth Clams: open each one, every clam holds one. The Muckshell crabs on the {zone:1445} coast south-west of Theramore drop a clam about seven kills in ten, so ten clams take about fifteen kills, on your way to {zone:1446}. The Steeljaw Snappers on {zone:1446}'s east coast drop them about one kill in three."] = "{item:7974}來自大嘴蛤蜊：每個都要開啟，每隻蛤蜊裡都有一個。塞拉摩西南{zone:1445}海岸的泥殼蟹約每十次擊殺掉落七次蛤蜊，所以十個蛤蜊約需十五次擊殺，正好在去{zone:1446}的路上。{zone:1446}東海岸的鋼顎鉗嘴龜約每三次擊殺掉一次。",

	-- Step 108: Clamlette Surprise
	-- {skill:185} Cooking
	["Artisan {skill:185}"] = "專家級{skill:185}",

	-- Step 109: Recipes for Tanaris (Cooking to 300)
	-- {zone:1446} Tanaris · {skill:185} Cooking
	["Recipes for {zone:1446} ({skill:185} to 300)"] = "",
	-- {item:13939} Recipe: Spotted Yellowtail · {skill:185} Cooking · {npc:8137} Gikkix · {zone:1446} Tanaris
	["Before the round: {item:13939} ({skill:185} 225, 1g 60s: {npc:8137}, {zone:1446}). A recipe teaches itself when you use it from your bags."] = "",

	-- Step 110: Lures for Tanaris
	-- {zone:1446} Tanaris
	["Lures for {zone:1446}"] = "",
	-- {skill:356} Fishing · {item:6532} Bright Baubles
	["This water loses fish below {skill:356} 300: a lure on the pole adds to your skill for ten minutes. {item:6532} (+75 from skill 100, 2s 50c each) closes the gap from 225; three see you through."] = "",

	-- Step 111: Fishing: Tanaris (225-300)
	-- {skill:356} Fishing · {item:4603} Raw Spotted Yellowtail · {item:13422} Stonescale Eel · {item:6359} Firefin Snapper · {item:13755} Raw Winter Squid · {item:7973} Big-mouth Clam · {item:6362} Raw Rockscale Cod · {object:180657} Firefin Snapper School · {object:180662} Floating Wreckage · {object:180582} Oily Blackmouth School · {object:180712} Stonescale Eel Swarm
	["Fish the round until {skill:356} 300 and until your bags hold 120 {item:4603} for the cooking: about 650 catches (from 75 a catch raises the skill less often: one in two by 100, one in seven by 225). The arrow leads stand to stand: stay while the fish bite (casting holds the arrow there), walk on when a pool is fished out or the spot is busy. What bites here (players' catches at these stands): {item:4603} (42%), {item:13422} (15%), {item:6359} (11%), {item:13755} (10%, in its season only), {item:7973} (9%), {item:6362} (9%). {skill:356} pools by the round: {object:180657}, {object:180662}, {object:180582} and {object:180712}. This water loses fish below skill 300: keep a lure on the pole until then."] = "",

	-- Step 112: Fishing: Tanaris (225-300)
	-- {skill:185} Cooking · {skill:356} Fishing
	["Your {skill:185} is past 300, so there are no fish to keep: fish the round until {skill:356} 300, about 650 catches."] = "",

	-- Step 113: Cook Spotted Yellowtail (225-300)
	-- {item:6887} Spotted Yellowtail
	["Cook {item:6887} (225-300)"] = "",
	-- {item:6887} Spotted Yellowtail · {item:4603} Raw Spotted Yellowtail · {object:29784} Basic Campfire
	["{item:6887} is orange from 225 (yellow at 265, green at 285, grey at 305): about 120 crafts to 300, 120 {item:4603}. Cook at any fire: a town hearth or your own {object:29784}. Short of fish: fish the round a little longer."] = "",
}
