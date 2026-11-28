-- Portuguese (Brazil) (ptBR): the guide forever/professions/fishing-cooking (forever/professions/fishing-cooking.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Fishing and Cooking
	-- {skill:356} Fishing · {skill:185} Cooking
	["Learn {skill:356} and {skill:185}"] = "",
	-- {skill:185} Cooking · {object:29784} Basic Campfire · {item:279981} Basic Campfire Kit · {item:4470} Simple Wood · {item:4471} Flint and Tinder · {skill:356} Fishing · {item:279967} Fish Bowl · {item:6256} Fishing Pole
	["Any {skill:185} trainer of your faction teaches Apprentice {skill:185} (1s) at any character level; the arrow picks the nearest, and every starting area has one. Forever: every cook knows {object:29784}: a {item:279981} from one {item:4470} with {item:4471} lights a cooking fire anywhere, so you can cook beside the water. If you sat at your starting area's campfire for The Great Outdoors, its camping guide also offers Camping 101: {skill:356} (handed in at {skill:356} 20 for the {item:279967} recipe) and Camping 101: {skill:185}. Learn Apprentice {skill:356} on the same trip: any {skill:356} trainer of your faction teaches it at any level, and the arrow picks the nearest. Buy a {item:6256} (23c) and equip it: you can only fish with a pole in your hands."] = "",

	-- Step 2: Lures for Fishing 1-75
	-- {skill:356} Fishing
	["Lures for {skill:356} 1-75"] = "",
	-- {skill:356} Fishing · {item:6529} Shiny Bauble
	["Some of these waters lose fish below {skill:356} 25: a lure on the pole adds to your skill for ten minutes. {item:6529} (+25, 50c each) closes the gap from 1: about 1 sees you to 25 (6 minutes of fishing)."] = "",

	-- Step 3: Fish Raw Brilliant Smallfish (Fishing 1-75) · Fishing: Professions tab (K by default)
	-- {item:6291} Raw Brilliant Smallfish · {skill:356} Fishing
	["Fish {item:6291} ({skill:356} 1-75) · {skill:356}: Professions tab (K by default)"] = "",
	-- {item:6291} Raw Brilliant Smallfish · {skill:185} Cooking · {item:6290} Brilliant Smallfish · {skill:356} Fishing · {zone:1429} Elwynn Forest
	["50 {item:6291} for {skill:185} 1-50: 50 {item:6290}. Fish 50 {item:6291} ({skill:356} 1 to 75), then craft 50 {item:6290} ({skill:185} 1 to 50). The arrow leads to the stand players fish them at in {zone:1429}: stay there until your bags hold them."] = "",

	-- Step 4: Cooking recipes at 1
	-- {skill:185} Cooking
	["{skill:185} recipes at 1"] = "",
	-- {item:6325} Recipe: Brilliant Smallfish · {item:6290} Brilliant Smallfish · {skill:185} Cooking · {npc:66} Tharynn Bouden · {zone:1429} Elwynn Forest · {npc:1684} Khara Deepwater · {zone:1432} Loch Modan · {npc:4265} Nyoma · {zone:1438} Teldrassil
	["{item:6325} teaches {item:6290} ({skill:185} 1, 40c). Sold by {npc:66} ({zone:1429}), {npc:1684} ({zone:1432}) and {npc:4265} ({zone:1438}). The arrow picks the nearest seller of your faction."] = "",

	-- Step 5: Brilliant Smallfish to 50
	-- {item:6290} Brilliant Smallfish
	["{item:6290} to 50"] = "",
	-- {item:6290} Brilliant Smallfish · {item:6291} Raw Brilliant Smallfish · {object:29784} Basic Campfire
	["{item:6290} is orange at 1 (yellow 45, green 65, grey 85): about 50 crafts to 50. Each takes 1 {item:6291}. Cook at any fire: a town hearth or your own {object:29784}."] = "",
	["from the recipe in your bags"] = "",

	-- Step 6: Journeyman Fishing
	-- {skill:356} Fishing
	["Journeyman {skill:356}"] = "{skill:356} (Profissional)",
	-- {skill:356} Fishing
	["Journeyman {skill:356} raises the cap to 150; it needs skill 50 and character level 10 (Forever's trainer lists ask for that level), and costs 5s. The arrow picks the nearest {skill:356} trainer of your faction."] = "",

	-- Step 7: Fish Raw Brilliant Smallfish (Fishing 1-75) · Fishing: Professions tab (K by default)
	-- {item:6291} Raw Brilliant Smallfish · {skill:185} Cooking · {item:6290} Brilliant Smallfish · {skill:356} Fishing
	["50 {item:6291} for {skill:185} 1-50: 50 {item:6290}. Fish 50 {item:6291} ({skill:356} 1 to 75), then craft 50 {item:6290} ({skill:185} 1 to 50). The arrow takes the {skill:356} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. At the water it leads stand to stand: stay while you catch fish (casting holds the arrow there), walk on when a pool is fished out or the spot is busy."] = "",

	-- Step 8: Cooking recipes at 1
	-- {item:6325} Recipe: Brilliant Smallfish · {item:6290} Brilliant Smallfish · {skill:185} Cooking · {npc:66} Tharynn Bouden · {zone:1429} Elwynn Forest · {npc:1684} Khara Deepwater · {zone:1432} Loch Modan · {npc:4265} Nyoma · {zone:1438} Teldrassil · {npc:3029} Sewa Mistrunner · {zone:1456} Thunder Bluff · {npc:3550} Martine Tramblay · {zone:1420} Tirisfal Glades · {npc:4574} Lizbeth Cromwell · {zone:1458} Undercity
	["{item:6325} teaches {item:6290} ({skill:185} 1, 40c). Sold by Alliance: {npc:66} ({zone:1429}), {npc:1684} ({zone:1432}) and {npc:4265} ({zone:1438}); Horde: {npc:3029} ({zone:1456}), {npc:3550} ({zone:1420}) and {npc:4574} ({zone:1458}). The arrow picks the nearest seller of your faction."] = "",

	-- Step 11: Fish Raw Slitherskin Mackerel (Fishing 1-53) · Fishing: Professions tab (K by default)
	-- {item:6303} Raw Slitherskin Mackerel · {skill:356} Fishing
	["Fish {item:6303} ({skill:356} 1-53) · {skill:356}: Professions tab (K by default)"] = "",
	-- {item:6303} Raw Slitherskin Mackerel · {skill:185} Cooking · {item:787} Slitherskin Mackerel · {skill:356} Fishing · {zone:1438} Teldrassil
	["50 {item:6303} for {skill:185} 1-50: 50 {item:787}. Fish 50 {item:6303} ({skill:356} 1 to 53), then craft 50 {item:787} ({skill:185} 1 to 50). The arrow leads to the stand players fish them at in {zone:1438}: stay there until your bags hold them."] = "",

	-- Step 12: Cooking recipes at 1
	-- {item:6326} Recipe: Slitherskin Mackerel · {item:787} Slitherskin Mackerel · {skill:185} Cooking · {npc:4305} Kriggon Talsone · {zone:1436} Westfall · {npc:5162} Tansy Puddlefizz · {zone:1455} Ironforge · {npc:10118} Nessa Shadowsong · {zone:1438} Teldrassil
	["{item:6326} teaches {item:787} ({skill:185} 1, 40c). Sold by {npc:4305} ({zone:1436}), {npc:5162} ({zone:1455}) and {npc:10118} ({zone:1438}). The arrow picks the nearest seller of your faction."] = "",

	-- Step 13: Slitherskin Mackerel to 50
	-- {item:787} Slitherskin Mackerel
	["{item:787} to 50"] = "",
	-- {item:787} Slitherskin Mackerel · {item:6303} Raw Slitherskin Mackerel · {object:29784} Basic Campfire
	["{item:787} is orange at 1 (yellow 45, green 65, grey 85): about 50 crafts to 50. Each takes 1 {item:6303}. Cook at any fire: a town hearth or your own {object:29784}."] = "",

	-- Step 14: Fishing 53-75: Teldrassil's water · Fishing: Professions tab (K by default)
	-- {skill:356} Fishing · {zone:1438} Teldrassil
	["{skill:356} 53-75: {zone:1438}'s water · {skill:356}: Professions tab (K by default)"] = "",
	-- {skill:356} Fishing · {skill:185} Cooking · {item:6303} Raw Slitherskin Mackerel · {zone:1438} Teldrassil
	["{skill:356} 53 to 75 where you are: the next {skill:185} stretches' fish come from waters that ask {skill:356} 75. The loop also gives about 20 {item:6303}: keep them, the next stretches use them. The arrow leads to the stand players fish at in {zone:1438}: stay there while you catch fish."] = "",

	-- Step 16: Fish Raw Slitherskin Mackerel (Fishing 1-51) · Fishing: Professions tab (K by default)
	-- {item:6303} Raw Slitherskin Mackerel · {skill:356} Fishing
	["Fish {item:6303} ({skill:356} 1-51) · {skill:356}: Professions tab (K by default)"] = "",
	-- {item:6303} Raw Slitherskin Mackerel · {skill:185} Cooking · {item:787} Slitherskin Mackerel · {skill:356} Fishing · {zone:1411} Durotar
	["50 {item:6303} for {skill:185} 1-50: 50 {item:787}. Fish 50 {item:6303} ({skill:356} 1 to 51), then craft 50 {item:787} ({skill:185} 1 to 50). The arrow leads to the stand players fish them at in {zone:1411}: stay there until your bags hold them."] = "",

	-- Step 17: Cooking recipes at 1
	-- {item:6326} Recipe: Slitherskin Mackerel · {item:787} Slitherskin Mackerel · {skill:185} Cooking · {npc:3550} Martine Tramblay · {zone:1420} Tirisfal Glades · {npc:5942} Zansoa · {zone:1411} Durotar · {npc:257006} Nyalah Brightfire
	["{item:6326} teaches {item:787} ({skill:185} 1, 40c). Sold by {npc:3550} ({zone:1420}), {npc:5942} ({zone:1411}) and {npc:257006} (Zephras Isle). The arrow picks the nearest seller of your faction."] = "",

	-- Step 19: Fishing 51-75: Durotar's water · Fishing: Professions tab (K by default)
	-- {skill:356} Fishing · {zone:1411} Durotar
	["{skill:356} 51-75: {zone:1411}'s water · {skill:356}: Professions tab (K by default)"] = "",
	-- {skill:356} Fishing · {skill:185} Cooking · {item:6303} Raw Slitherskin Mackerel · {zone:1411} Durotar
	["{skill:356} 51 to 75 where you are: the next {skill:185} stretches' fish come from waters that ask {skill:356} 75. The loop also gives about 25 {item:6303}: keep them, the next stretches use them. The arrow leads to the stand players fish at in {zone:1411}: stay there while you catch fish."] = "",

	-- Step 21: Fishing 1-75: Raw Brilliant Smallfish and Raw Slitherskin Mackerel water · Fishing: Professions tab (K by default)
	-- {skill:356} Fishing · {item:6291} Raw Brilliant Smallfish · {item:6303} Raw Slitherskin Mackerel
	["{skill:356} 1-75: {item:6291} and {item:6303} water · {skill:356}: Professions tab (K by default)"] = "",
	-- {skill:356} Fishing
	["{skill:356} 75 first: the next loops need it. Most players are past it already from the steps above, and then this step is done."] = "",

	-- Step 22: Fish Raw Longjaw Mud Snapper (Fishing 75-94) · Fishing: Professions tab (K by default)
	-- {item:6289} Raw Longjaw Mud Snapper · {skill:356} Fishing
	["Fish {item:6289} ({skill:356} 75-94) · {skill:356}: Professions tab (K by default)"] = "",
	-- {item:6289} Raw Longjaw Mud Snapper · {skill:185} Cooking · {item:4592} Longjaw Mud Snapper · {skill:356} Fishing
	["25 {item:6289} for {skill:185} 50-75: 25 {item:4592}. Fish 25 {item:6289} ({skill:356} 75 to 94), then craft 25 {item:4592} ({skill:185} 50 to 75). The arrow takes the {skill:356} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. At the water it leads stand to stand: stay while you catch fish (casting holds the arrow there), walk on when a pool is fished out or the spot is busy."] = "",

	-- Step 23: Cooking recipes at 50
	-- {skill:185} Cooking
	["{skill:185} recipes at 50"] = "",
	-- {item:6328} Recipe: Longjaw Mud Snapper · {item:4592} Longjaw Mud Snapper · {skill:185} Cooking · {npc:66} Tharynn Bouden · {zone:1429} Elwynn Forest · {npc:1684} Khara Deepwater · {zone:1432} Loch Modan · {npc:4265} Nyoma · {zone:1438} Teldrassil · {npc:3027} Naal Mistrunner · {zone:1456} Thunder Bluff · {npc:4574} Lizbeth Cromwell · {zone:1458} Undercity · {npc:5748} Killian Sanatha · {zone:1421} Silverpine Forest
	["{item:6328} teaches {item:4592} ({skill:185} 50, 4s). Sold by Alliance: {npc:66} ({zone:1429}), {npc:1684} ({zone:1432}) and {npc:4265} ({zone:1438}); Horde: {npc:3027} ({zone:1456}), {npc:4574} ({zone:1458}) and {npc:5748} ({zone:1421}). The arrow picks the nearest seller of your faction."] = "",

	-- Step 24: Longjaw Mud Snapper to 75
	-- {item:4592} Longjaw Mud Snapper
	["{item:4592} to 75"] = "",
	-- {item:4592} Longjaw Mud Snapper · {item:6289} Raw Longjaw Mud Snapper · {object:29784} Basic Campfire · {npc:267118} Gilbert Gray · {zone:1453} Stormwind · {item:6529} Shiny Bauble · {item:6530} Nightcrawlers
	["{item:4592} is orange at 50 (yellow 90, green 110, grey 130): about 25 crafts to 75, a point every craft. Each takes 1 {item:6289}. Cook at any fire: a town hearth or your own {object:29784}. From level 7, {npc:267118} at the {zone:1453} harbor gives Fishin' Time: bring 1 {item:6529} and 3 {item:6530} for cooked fish."] = "",

	-- Step 25: Journeyman Cooking
	-- {skill:185} Cooking
	["Journeyman {skill:185}"] = "{skill:185} (Profissional)",
	-- {skill:185} Cooking
	["Journeyman {skill:185} raises the cap to 150; it needs skill 50 and no character level, and costs 5s. The arrow picks the nearest {skill:185} trainer of your faction."] = "",

	-- Step 26: Fish Raw Longjaw Mud Snapper (Fishing 94-117) · Fishing: Professions tab (K by default)
	-- {item:6289} Raw Longjaw Mud Snapper · {skill:356} Fishing
	["Fish {item:6289} ({skill:356} 94-117) · {skill:356}: Professions tab (K by default)"] = "",
	-- {item:6289} Raw Longjaw Mud Snapper · {skill:185} Cooking · {item:4592} Longjaw Mud Snapper · {skill:356} Fishing
	["28 {item:6289} for {skill:185} 75-100: 28 {item:4592}. Fish 28 {item:6289} ({skill:356} 94 to 117), then craft 27 {item:4592} ({skill:185} 75 to 100). The arrow takes the {skill:356} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. At the water it leads stand to stand: stay while you catch fish (casting holds the arrow there), walk on when a pool is fished out or the spot is busy."] = "",

	-- Step 27: Longjaw Mud Snapper to 100
	-- {item:4592} Longjaw Mud Snapper
	["{item:4592} to 100"] = "",
	-- {item:4592} Longjaw Mud Snapper · {item:6289} Raw Longjaw Mud Snapper · {object:29784} Basic Campfire
	["{item:4592} is orange at 75 (yellow 90, green 110, grey 130): about 27 crafts to 100, up to 28 for 9 players in 10 (the fish above count that many). Each takes 1 {item:6289}. Cook at any fire: a town hearth or your own {object:29784}. If you got here without learning {item:4592}, learn it now: an earlier step teaches it."] = "",

	-- Step 28: Fish Raw Bristle Whisker Catfish (Fishing 117-150) · Fishing: Professions tab (K by default)
	-- {item:6308} Raw Bristle Whisker Catfish · {skill:356} Fishing
	["Fish {item:6308} ({skill:356} 117-150) · {skill:356}: Professions tab (K by default)"] = "",
	-- {item:6308} Raw Bristle Whisker Catfish · {skill:185} Cooking · {item:4593} Bristle Whisker Catfish · {skill:356} Fishing
	["40 {item:6308} for {skill:185} 100-140: 40 {item:4593}; from your fishing on the way: 20 of 40 {item:6308}. Fish 20 {item:6308} ({skill:356} 117 to 150), then craft 40 {item:4593} ({skill:185} 100 to 140). The arrow takes the {skill:356} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. At the water it leads stand to stand: stay while you catch fish (casting holds the arrow there), walk on when a pool is fished out or the spot is busy."] = "",

	-- Step 29: Cooking recipes at 100
	-- {skill:185} Cooking
	["{skill:185} recipes at 100"] = "",
	-- {item:6330} Recipe: Bristle Whisker Catfish · {item:4593} Bristle Whisker Catfish · {skill:185} Cooking · {npc:2383} Lindea Rabonne · {zone:1424} Hillsbrad Foothills · {npc:3497} Kilxx · {zone:1413} The Barrens · {npc:5494} Catherine Leland · {zone:1453} Stormwind · {npc:2397} Derak Nightfall · {npc:3027} Naal Mistrunner · {zone:1456} Thunder Bluff · {npc:3029} Sewa Mistrunner
	["{item:6330} teaches {item:4593} ({skill:185} 100, 12s). Sold by Alliance: {npc:2383} ({zone:1424}), {npc:3497} ({zone:1413}) and {npc:5494} ({zone:1453}); Horde: {npc:2397} ({zone:1424}), {npc:3027} ({zone:1456}) and {npc:3029} ({zone:1456}). The arrow picks the nearest seller of your faction."] = "",

	-- Step 30: Bristle Whisker Catfish to 140
	-- {item:4593} Bristle Whisker Catfish
	["{item:4593} to 140"] = "",
	-- {item:4593} Bristle Whisker Catfish · {item:6308} Raw Bristle Whisker Catfish · {object:29784} Basic Campfire
	["{item:4593} is orange at 100 (yellow 140, green 160, grey 180): about 40 crafts to 140, a point every craft. Each takes 1 {item:6308}. Cook at any fire: a town hearth or your own {object:29784}."] = "",

	-- Step 31: Lures for Fishing 150-190
	-- {skill:356} Fishing
	["Lures for {skill:356} 150-190"] = "",
	-- {skill:356} Fishing · {item:6532} Bright Baubles
	["Some of these waters lose fish below {skill:356} 225: a lure on the pole adds to your skill for ten minutes. {item:6532} (+75 from skill 100, 2s 50c each) closes the gap from 150: about 5 see you to 190 (48 minutes of fishing)."] = "",

	-- Step 32: Expert Fishing
	-- {skill:356} Fishing
	["Expert {skill:356}"] = "{skill:356} (Perito)",
	-- {skill:356} Fishing · {item:16083} Expert Fishing - The Bass and You · {npc:2626} Old Man Heming · {zone:1434} Stranglethorn Vale · {area:35} Booty Bay · {area:392} Ratchet · {zone:1413} The Barrens · {item:6532} Bright Baubles · {item:279965} Fishing Rack · {area:2797} Blackfathom Deeps
	["Expert {skill:356} (cap 225) is a book, not a trainer rank: {item:16083} (1g), {npc:2626} ({zone:1434}) sells it to both factions. Buy it and read it; it needs skill 125 and level 20. At level 20 the safe way to {area:35} is the boat from {area:392} in {zone:1413}. {npc:2626} also sells {item:6532} (+75 from skill 100, 2s 50c each), the lure for harder water. Forever's {item:279965} (a camping item, from {skill:356} 140) is a blueprint that drops from Gelihast in {area:2797}."] = "",
	-- {item:16083} Expert Fishing - The Bass and You · {skill:356} Fishing
	["Buy and read {item:16083} (Expert {skill:356})"] = "Compre e leia {item:16083} ({skill:356} (Perito))",

	-- Step 33: Fishing 75-150: Raw Longjaw Mud Snapper and Raw Bristle Whisker Catfish water · Fishing: Professions tab (K by default)
	-- {skill:356} Fishing · {item:6289} Raw Longjaw Mud Snapper · {item:6308} Raw Bristle Whisker Catfish
	["{skill:356} 75-150: {item:6289} and {item:6308} water · {skill:356}: Professions tab (K by default)"] = "",
	-- {skill:356} Fishing
	["{skill:356} 150 first: the next loops need it. Most players are past it already from the steps above, and then this step is done."] = "",

	-- Step 34: Fish Raw Bristle Whisker Catfish (Fishing 150-157) · Fishing: Professions tab (K by default)
	-- {item:6308} Raw Bristle Whisker Catfish · {skill:356} Fishing
	["Fish {item:6308} ({skill:356} 150-157) · {skill:356}: Professions tab (K by default)"] = "",
	-- {item:6308} Raw Bristle Whisker Catfish · {skill:185} Cooking · {item:4593} Bristle Whisker Catfish · {skill:356} Fishing
	["13 {item:6308} for {skill:185} 140-150: 13 {item:4593}. Fish 13 {item:6308} ({skill:356} 150 to 157), then craft 12 {item:4593} ({skill:185} 140 to 150). The arrow takes the {skill:356} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. At the water it leads stand to stand: stay while you catch fish (casting holds the arrow there), walk on when a pool is fished out or the spot is busy."] = "",

	-- Step 35: Bristle Whisker Catfish to 150
	-- {item:4593} Bristle Whisker Catfish
	["{item:4593} to 150"] = "",
	-- {item:4593} Bristle Whisker Catfish · {item:6308} Raw Bristle Whisker Catfish · {object:29784} Basic Campfire · {npc:267118} Gilbert Gray · {zone:1453} Stormwind · {item:6529} Shiny Bauble · {item:6530} Nightcrawlers
	["{item:4593} is yellow at 140 (yellow 140, green 160, grey 180): about 12 crafts to 150, up to 13 for 9 players in 10 (the fish above count that many). Each takes 1 {item:6308}. Cook at any fire: a town hearth or your own {object:29784}. From level 7, {npc:267118} at the {zone:1453} harbor gives Fishin' Time: bring 1 {item:6529} and 3 {item:6530} for cooked fish."] = "",

	-- Step 36: Expert Cooking
	-- {skill:185} Cooking
	["Expert {skill:185}"] = "{skill:185} (Perito)",
	-- {skill:185} Cooking · {item:16072} Expert Cookbook · {npc:3955} Shandrina · {zone:1440} Ashenvale · {npc:12033} Wulan · {zone:1443} Desolace
	["Expert {skill:185} (cap 225) is a book, not a trainer rank: {item:16072} (1g), sold by {npc:3955} ({zone:1440}) for the Alliance and {npc:12033} ({zone:1443}) for the Horde. Buy it and read it; it needs skill 125 and level 20."] = "",
	-- {item:16072} Expert Cookbook · {skill:185} Cooking
	["Buy and read {item:16072} (Expert {skill:185})"] = "Compre e leia {item:16072} ({skill:185} (Perito))",

	-- Step 37: Fishing 157-190: Raw Bristle Whisker Catfish water · Fishing: Professions tab (K by default)
	-- {skill:356} Fishing · {item:6308} Raw Bristle Whisker Catfish
	["{skill:356} 157-190: {item:6308} water · {skill:356}: Professions tab (K by default)"] = "",
	-- {skill:356} Fishing · {item:4593} Bristle Whisker Catfish · {item:6308} Raw Bristle Whisker Catfish
	["Fish from {skill:356} 157 to 190 for {item:4593}: this loop gives {item:6308}, and the next one the rest from {skill:356} 190. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 38: Fish Raw Bristle Whisker Catfish (Fishing 190-215) · Fishing: Professions tab (K by default)
	-- {item:6308} Raw Bristle Whisker Catfish · {skill:356} Fishing
	["Fish {item:6308} ({skill:356} 190-215) · {skill:356}: Professions tab (K by default)"] = "",
	-- {item:6308} Raw Bristle Whisker Catfish · {skill:185} Cooking · {item:4593} Bristle Whisker Catfish · {skill:356} Fishing
	["86 {item:6308} for {skill:185} 150-175: 86 {item:4593}. Fish 86 {item:6308} ({skill:356} 190 to 215), then craft 69 {item:4593} ({skill:185} 150 to 175). The arrow takes the {skill:356} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. At the water it leads stand to stand: stay while you catch fish (casting holds the arrow there), walk on when a pool is fished out or the spot is busy."] = "",

	-- Step 39: Bristle Whisker Catfish to 175
	-- {item:4593} Bristle Whisker Catfish
	["{item:4593} to 175"] = "",
	-- {item:4593} Bristle Whisker Catfish · {item:6308} Raw Bristle Whisker Catfish · {object:29784} Basic Campfire
	["{item:4593} is yellow at 150 (yellow 140, green 160, grey 180): about 69 crafts to 175, up to 86 for 9 players in 10 (the fish above count that many). Each takes 1 {item:6308}. Cook at any fire: a town hearth or your own {object:29784}. If you got here without learning {item:4593}, learn it now: an earlier step teaches it."] = "",

	-- Step 40: Lures for Fishing 190-225
	-- {skill:356} Fishing
	["Lures for {skill:356} 190-225"] = "",
	-- {skill:356} Fishing · {item:6530} Nightcrawlers
	["Some of these waters lose fish below {skill:356} 225: a lure on the pole adds to your skill for ten minutes. {item:6530} (+50 from skill 50, 1s each) closes the gap from 190: about 6 see you to 225 (55 minutes of fishing)."] = "",

	-- Step 41: Fish Raw Rockscale Cod (Fishing 215-225) · Fishing: Professions tab (K by default)
	-- {item:6362} Raw Rockscale Cod · {skill:356} Fishing
	["Fish {item:6362} ({skill:356} 215-225) · {skill:356}: Professions tab (K by default)"] = "",
	-- {item:6362} Raw Rockscale Cod · {skill:185} Cooking · {item:4594} Rockscale Cod · {skill:356} Fishing
	["112 {item:6362} for {skill:185} 175-225: 112 {item:4594}; from your fishing on the way: 28 of 112 {item:6362}. Fish 85 {item:6362} ({skill:356} 215 to 225), then craft 95 {item:4594} ({skill:185} 175 to 225). The arrow takes the {skill:356} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. At the water it leads stand to stand: stay while you catch fish (casting holds the arrow there), walk on when a pool is fished out or the spot is busy."] = "",

	-- Step 42: Cooking recipes at 175
	-- {skill:185} Cooking
	["{skill:185} recipes at 175"] = "",
	-- {item:6369} Recipe: Rockscale Cod · {item:4594} Rockscale Cod · {skill:185} Cooking · {npc:2383} Lindea Rabonne · {zone:1424} Hillsbrad Foothills · {npc:2664} Kelsey Yance · {zone:1434} Stranglethorn Vale · {npc:3178} Stuart Fleming · {zone:1437} Wetlands
	["{item:6369} teaches {item:4594} ({skill:185} 175, 22s). Sold by {npc:2383} ({zone:1424}), {npc:2664} ({zone:1434}) and {npc:3178} ({zone:1437}). The arrow picks the nearest seller of your faction."] = "",

	-- Step 43: Rockscale Cod to 225
	-- {item:4594} Rockscale Cod
	["{item:4594} to 225"] = "",
	-- {item:4594} Rockscale Cod · {item:6362} Raw Rockscale Cod · {object:29784} Basic Campfire
	["{item:4594} is orange at 175 (yellow 190, green 210, grey 230): about 95 crafts to 225, up to 112 for 9 players in 10 (the fish above count that many). Each takes 1 {item:6362}. Cook at any fire: a town hearth or your own {object:29784}."] = "",

	-- Step 44: Nat Pagle, Angler Extreme · Fishing: Professions tab (K by default)
	-- {quest:6607} Nat Pagle, Angler Extreme · {skill:356} Fishing
	["{quest:6607} · {skill:356}: Professions tab (K by default)"] = "",
	-- {skill:356} Fishing · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh · {zone:1455} Ironforge
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1455} sends you to him; the quest needs skill 225 and level 35."] = "{skill:356} Artífice (limite 300) vem de {npc:12919}, em {zone:1445}. O instrutor de pesca de {zone:1455} manda você até ele; a missão exige perícia 225 e nível 35.",

	-- Step 45: Nat Pagle
	-- {npc:12919} Nat Pagle
	["{npc:12919} fishes from the shore of a small island off the east coast, south of Theramore; swim over from the coast."] = "{npc:12919} pesca na margem de uma ilha pequena na costa leste, ao sul de Theramore; chegue a nado desde a costa.",

	-- Step 46: Sar'theris Striker
	-- {zone:1443} Desolace · {area:598} Sar'theris Strand · {area:2408} Shadowprey Village · {item:16968} Sar'theris Striker
	["Fish along the coast of {zone:1443} ({area:598} in the north-west, or the shore west of {area:2408}) until you catch a {item:16968}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "Pesque ao longo da costa de {zone:1443} ({area:598} no noroeste, ou a margem a oeste de {area:2408}) até pescar um {item:16968}: cerca de uma captura em cinco o traz, e ele não morde em nenhum outro lugar. Na perícia 225 nenhum peixe escapa aqui.",

	-- Step 47: Feralas Ahi
	-- {area:2521} Verdantis River · {zone:1444} Feralas · {area:2577} Dire Maul · {item:16967} Feralas Ahi · {item:6532} Bright Baubles
	["Fish along the {area:2521} in {zone:1444} (south-east of {area:2577}) until you catch a {item:16967}: about one catch in five there brings it up, and it bites nowhere else. This water loses fish below skill 300: at 225 most get away, so put {item:6532} (+75) on the pole first."] = "Pesque ao longo de {area:2521} em {zone:1444} (a sudeste de {area:2577}) até pescar um {item:16967}: cerca de uma captura em cinco o traz, e ele não morde em nenhum outro lugar. Esta água perde peixes abaixo da perícia 300: em 225 a maioria escapa, então ponha {item:6532} (+75) na vara antes.",

	-- Step 48: Savage Coast Blue Sailfin
	-- {zone:1434} Stranglethorn Vale · {area:301} Savage Coast · {item:16969} Savage Coast Blue Sailfin
	["Fish along {zone:1434}'s {area:301} (the west shore) until you catch a {item:16969}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "Pesque ao longo de {area:301} de {zone:1434} (a margem oeste) até pescar um {item:16969}: cerca de uma captura em cinco o traz, e ele não morde em nenhum outro lugar. Na perícia 225 nenhum peixe escapa aqui.",

	-- Step 49: Misty Reed Mahi Mahi
	-- {area:300} Misty Reed Strand · {zone:1435} Swamp of Sorrows · {item:16970} Misty Reed Mahi Mahi
	["Fish along the {area:300} (the east shore of {zone:1435}) until you catch a {item:16970}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "Pesque ao longo de {area:300} (a margem leste de {zone:1435}) até pescar um {item:16970}: cerca de uma captura em cinco o traz, e ele não morde em nenhum outro lugar. Na perícia 225 nenhum peixe escapa aqui.",

	-- Step 50: Nat Pagle
	-- {skill:356} Fishing
	["Artisan {skill:356}"] = "{skill:356} (Artífice)",

	-- Step 51: Cooking recipes at 175
	-- {item:17062} Recipe: Mithril Head Trout · {spell:20916} Mithril Headed Trout · {skill:185} Cooking · {npc:2664} Kelsey Yance · {zone:1434} Stranglethorn Vale · {npc:3333} Shankys · {zone:1454} Orgrimmar · {npc:4574} Lizbeth Cromwell · {zone:1458} Undercity
	["{item:17062} teaches {spell:20916} ({skill:185} 175, 22s). Sold by {npc:2664} ({zone:1434}), {npc:3333} ({zone:1454}) and {npc:4574} ({zone:1458}). The arrow picks the nearest seller of your faction."] = "",

	-- Step 52: Mithril Headed Trout to 225
	-- {spell:20916} Mithril Headed Trout
	["{spell:20916} to 225"] = "",
	-- {spell:20916} Mithril Headed Trout · {item:8365} Raw Mithril Head Trout · {object:29784} Basic Campfire
	["{spell:20916} is orange at 175 (yellow 215, green 235, grey 255): about 52 crafts to 225, up to 53 for 9 players in 10 (the fish above count that many). Each takes 1 {item:8365}. Cook at any fire: a town hearth or your own {object:29784}."] = "",

	-- Step 53: Fishing 215-225: Raw Rockscale Cod and Raw Mithril Head Trout water · Fishing: Professions tab (K by default)
	-- {skill:356} Fishing · {item:6362} Raw Rockscale Cod · {item:8365} Raw Mithril Head Trout
	["{skill:356} 215-225: {item:6362} and {item:8365} water · {skill:356}: Professions tab (K by default)"] = "",
	-- {skill:356} Fishing · {skill:185} Cooking · {item:6308} Raw Bristle Whisker Catfish · {item:8365} Raw Mithril Head Trout · {item:21153} Raw Greater Sagefish
	["{skill:356} 215 to 225 where you are: the next {skill:185} stretches' fish come from waters that ask {skill:356} 225. The loop also gives about 15 {item:6308}, 30 {item:8365} and 5 {item:21153}: keep them, the next stretches use them. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 54: Nat Pagle, Angler Extreme · Fishing: Professions tab (K by default)
	-- {skill:356} Fishing · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh · {zone:1454} Orgrimmar
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1454} sends you to him; the quest needs skill 225 and level 35."] = "{skill:356} Artífice (limite 300) vem de {npc:12919}, em {zone:1445}. O instrutor de pesca de {zone:1454} manda você até ele; a missão exige perícia 225 e nível 35.",

	-- Step 61: Giant Eggs
	-- plural, as words: Giant Eggs = {item:12207} Giant Egg
	["Giant Eggs"] = "Ovos Gigantescos",
	-- {quest:6610} Clamlette Surprise · {item:7974} Zesty Clam Meat · {item:8932} Alterac Swiss · {zone:1446} Tanaris · {zone:1425} The Hinterlands · {npc:2929} Savage Owlbeast
	-- plural, as words: Giant Eggs = {item:12207} Giant Egg
	["{quest:6610} asks for 12 Giant Eggs, 10 {item:7974} and 20 {item:8932}: bring all three before you go to {zone:1446}, so you make the trip once. Giant Eggs drop from the owlbeasts of {zone:1425}: {npc:2929} (54%)."] = "",

	-- Step 62: Alterac Swiss
	-- {item:8932} Alterac Swiss
	["Innkeepers and food vendors sell {item:8932}; the arrow picks the nearest."] = "Estalajadeiros e vendedores de comida vendem {item:8932}; a seta escolhe o mais próximo.",

	-- Step 63: Zesty Clam Meat
	-- {item:7974} Zesty Clam Meat · {zone:1445} Dustwallow Marsh · {zone:1446} Tanaris
	-- plural, as words: Big-mouth Clams = {item:7973} Big-mouth Clam · Steeljaw Snappers = {npc:14123} Steeljaw Snapper
	["{item:7974} comes from Big-mouth Clams: open each one, every clam holds one. The Muckshell crabs on the {zone:1445} coast south-west of Theramore drop a clam about seven kills in ten, so ten clams take about fifteen kills, on your way to {zone:1446}. The Steeljaw Snappers on {zone:1446}'s east coast drop them about one kill in three."] = "{item:7974} vem de Mariscos Boca-grande: abra cada um, todo marisco tem um. Os caranguejos Conchalodo da costa de {zone:1445}, a sudoeste de Theramore, soltam um marisco em cerca de sete mortes de dez, então dez mariscos levam cerca de quinze mortes, no seu caminho até {zone:1446}. As Tartaliscas Maxilaço da costa leste de {zone:1446} soltam em cerca de uma morte de três.",

	-- Step 64: Fishing 190-225: Raw Rockscale Cod and Raw Mithril Head Trout water · Fishing: Professions tab (K by default)
	-- {skill:356} Fishing · {item:6362} Raw Rockscale Cod · {item:8365} Raw Mithril Head Trout
	["{skill:356} 190-225: {item:6362} and {item:8365} water · {skill:356}: Professions tab (K by default)"] = "",
	-- {skill:356} Fishing
	["{skill:356} 225 first: the next loops need it. Most players are past it already from the steps above, and then this step is done."] = "",

	-- Step 65: Fishing 225-300: Raw Spotted Yellowtail and Raw Glossy Mightfish water · Fishing: Professions tab (K by default)
	-- {skill:356} Fishing · {item:4603} Raw Spotted Yellowtail · {item:13754} Raw Glossy Mightfish
	["{skill:356} 225-300: {item:4603} and {item:13754} water · {skill:356}: Professions tab (K by default)"] = "",
	-- {skill:356} Fishing · {item:6887} Spotted Yellowtail · {item:4603} Raw Spotted Yellowtail
	["Fish from {skill:356} 225 to 300 for {item:6887}: this loop gives {item:4603}, and the next one the rest from {skill:356} 300. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 66: Fish Raw Spotted Yellowtail · Fishing: Professions tab (K by default)
	-- {item:4603} Raw Spotted Yellowtail · {skill:356} Fishing
	["Fish {item:4603} · {skill:356}: Professions tab (K by default)"] = "",
	-- {item:4603} Raw Spotted Yellowtail · {skill:185} Cooking · {item:6887} Spotted Yellowtail · {skill:356} Fishing
	["137 {item:4603} for {skill:185} 225-300: 137 {item:6887}; from your fishing on the way: 9 of 137 {item:4603}. Fish 129 {item:4603} ({skill:356} 300), then craft 120 {item:6887} ({skill:185} 225 to 300). The arrow takes the {skill:356} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. At the water it leads stand to stand: stay while you catch fish (casting holds the arrow there), walk on when a pool is fished out or the spot is busy."] = "",

	-- Step 67: Dirge Quikcleave
	-- {skill:185} Cooking · {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {zone:1446} Tanaris · {zone:1455} Ironforge
	["Artisan {skill:185} comes from {npc:8125} in {area:976} ({zone:1446}). The cooking trainer in {zone:1455} sends you; it needs skill 225 and level 35."] = "{skill:185} Artífice vem de {npc:8125} em {area:976} ({zone:1446}). O instrutor de culinária em {zone:1455} envia você; requer perícia 225 e nível 35.",

	-- Step 68: Dirge Quikcleave
	-- {skill:185} Cooking · {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {zone:1446} Tanaris · {zone:1454} Orgrimmar
	["Artisan {skill:185} comes from {npc:8125} in {area:976} ({zone:1446}). The cooking trainer in {zone:1454} sends you; it needs skill 225 and level 35."] = "{skill:185} Artífice vem de {npc:8125} em {area:976} ({zone:1446}). O instrutor de culinária em {zone:1454} envia você; requer perícia 225 e nível 35.",

	-- Step 69: Clamlette Surprise
	-- {skill:185} Cooking
	["Artisan {skill:185}"] = "{skill:185} (Artífice)",

	-- Step 70: Cooking recipes at 225
	-- {skill:185} Cooking
	["{skill:185} recipes at 225"] = "",
	-- {item:13939} Recipe: Spotted Yellowtail · {item:6887} Spotted Yellowtail · {skill:185} Cooking · {npc:8137} Gikkix · {zone:1446} Tanaris
	["{item:13939} teaches {item:6887} ({skill:185} 225, 1g 60s). Sold by Alliance: {npc:8137} ({zone:1446}); Horde: {npc:8137} ({zone:1446}). The arrow picks the nearest seller of your faction."] = "",

	-- Step 71: Spotted Yellowtail to 300
	-- {item:6887} Spotted Yellowtail
	["{item:6887} to 300"] = "",
	-- {item:6887} Spotted Yellowtail · {item:4603} Raw Spotted Yellowtail · {object:29784} Basic Campfire
	["{item:6887} is orange at 225 (yellow 265, green 285, grey 305): about 120 crafts to 300, up to 137 for 9 players in 10 (the fish above count that many). Each takes 1 {item:4603}. Cook at any fire: a town hearth or your own {object:29784}."] = "",
}
