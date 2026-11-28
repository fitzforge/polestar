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
	-- {skill:185} Cooking · {object:29784} Basic Campfire · {item:279981} Basic Campfire Kit · {item:4470} Simple Wood · {item:4471} Flint and Tinder · {skill:356} Fishing · {item:279967} Fish Bowl · {item:6256} Fishing Pole
	["Any {skill:185} trainer of your faction teaches Apprentice {skill:185} (1s) at any character level; the arrow picks the nearest, and every starting area has one. Forever: every cook knows {object:29784}: a {item:279981} from one {item:4470} with {item:4471} lights a cooking fire anywhere, so you can cook beside the water. If you sat at your starting area's campfire for The Great Outdoors, its camping guide also offers Camping 101: {skill:356} (handed in at {skill:356} 20 for the {item:279967} recipe) and Camping 101: {skill:185}. Learn Apprentice {skill:356} on the same trip: any {skill:356} trainer of your faction teaches it at any level, and the arrow picks the nearest. Buy a {item:6256} (23c) and equip it: you can only fish with a pole in your hands."] = "",

	-- Step 2: Lures for Fishing 1-75
	-- {skill:356} Fishing
	["Lures for {skill:356} 1-75"] = "",
	-- {skill:356} Fishing · {item:6529} Shiny Bauble
	["Some of these waters lose fish below {skill:356} 25: a lure on the pole adds to your skill for ten minutes. {item:6529} (+25, 50c each) closes the gap from 1: about 1 sees you to 25 (6 minutes of fishing)."] = "",

	-- Step 3: Fish Raw Brilliant Smallfish (Fishing 1-75)
	-- {item:6291} Raw Brilliant Smallfish · {skill:356} Fishing
	["Fish {item:6291} ({skill:356} 1-75)"] = "",
	-- {item:6291} Raw Brilliant Smallfish · {skill:185} Cooking · {item:6290} Brilliant Smallfish · {skill:356} Fishing
	["50 {item:6291} for {skill:185} 1-50: 50 {item:6290}. Fish 50 {item:6291} ({skill:356} 1 to 75), then craft 50 {item:6290} ({skill:185} 1 to 50). The arrow takes the {skill:356} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. At the water it leads stand to stand: stay while you catch fish (casting holds the arrow there), walk on when a pool is fished out or the spot is busy. Or buy them at the Auction House."] = "",

	-- Step 4: Cooking recipes at 1
	-- {skill:185} Cooking
	["{skill:185} recipes at 1"] = "",
	-- {item:6325} Recipe: Brilliant Smallfish · {item:6290} Brilliant Smallfish · {skill:185} Cooking · {npc:66} Tharynn Bouden · {zone:1429} Elwynn Forest · {npc:1684} Khara Deepwater · {zone:1432} Loch Modan · {npc:4265} Nyoma · {zone:1438} Teldrassil · {npc:3029} Sewa Mistrunner · {zone:1456} Thunder Bluff · {npc:3550} Martine Tramblay · {zone:1420} Tirisfal Glades · {npc:4574} Lizbeth Cromwell · {zone:1458} Undercity
	["{item:6325} teaches {item:6290} ({skill:185} 1, 40c). Sold by Alliance: {npc:66} ({zone:1429}), {npc:1684} ({zone:1432}) and {npc:4265} ({zone:1438}); Horde: {npc:3029} ({zone:1456}), {npc:3550} ({zone:1420}) and {npc:4574} ({zone:1458}). The arrow picks the nearest seller of your faction."] = "",

	-- Step 5: Brilliant Smallfish to 50
	-- {item:6290} Brilliant Smallfish
	["{item:6290} to 50"] = "",
	-- {item:6290} Brilliant Smallfish · {item:6291} Raw Brilliant Smallfish · {object:29784} Basic Campfire
	["{item:6290} is orange at 1 (yellow 45, green 65, grey 85): about 50 crafts to 50. Each takes 1 {item:6291}. Cook at any fire: a town hearth or your own {object:29784}."] = "",
	["from the recipe in your bags"] = "",

	-- Step 6: Journeyman Fishing
	-- {skill:356} Fishing
	["Journeyman {skill:356}"] = "中級{skill:356}",
	-- {skill:356} Fishing
	["Journeyman {skill:356} raises the cap to 150; it needs skill 50 and character level 10 (Forever's trainer lists ask for that level), and costs 5s. The arrow picks the nearest {skill:356} trainer of your faction."] = "",

	-- Step 7: Fish Raw Slitherskin Mackerel (Fishing 1-53)
	-- {item:6303} Raw Slitherskin Mackerel · {skill:356} Fishing
	["Fish {item:6303} ({skill:356} 1-53)"] = "",
	-- {item:6303} Raw Slitherskin Mackerel · {skill:185} Cooking · {item:787} Slitherskin Mackerel · {skill:356} Fishing · {zone:1438} Teldrassil
	["50 {item:6303} for {skill:185} 1-50: 50 {item:787}. Fish 50 {item:6303} ({skill:356} 1 to 53), then craft 50 {item:787} ({skill:185} 1 to 50). The arrow leads to the stand players fish them at in {zone:1438}: stay there until your bags hold them. Or buy them at the Auction House."] = "",

	-- Step 8: Cooking recipes at 1
	-- {item:6326} Recipe: Slitherskin Mackerel · {item:787} Slitherskin Mackerel · {skill:185} Cooking · {npc:4305} Kriggon Talsone · {zone:1436} Westfall · {npc:5162} Tansy Puddlefizz · {zone:1455} Ironforge · {npc:10118} Nessa Shadowsong · {zone:1438} Teldrassil
	["{item:6326} teaches {item:787} ({skill:185} 1, 40c). Sold by {npc:4305} ({zone:1436}), {npc:5162} ({zone:1455}) and {npc:10118} ({zone:1438}). The arrow picks the nearest seller of your faction."] = "",

	-- Step 9: Slitherskin Mackerel to 50
	-- {item:787} Slitherskin Mackerel
	["{item:787} to 50"] = "",
	-- {item:787} Slitherskin Mackerel · {item:6303} Raw Slitherskin Mackerel · {object:29784} Basic Campfire
	["{item:787} is orange at 1 (yellow 45, green 65, grey 85): about 50 crafts to 50. Each takes 1 {item:6303}. Cook at any fire: a town hearth or your own {object:29784}."] = "",

	-- Step 10: Fishing 53-75: Teldrassil's water
	-- {skill:356} Fishing · {zone:1438} Teldrassil
	["{skill:356} 53-75: {zone:1438}'s water"] = "",
	-- {skill:356} Fishing · {skill:185} Cooking · {item:6303} Raw Slitherskin Mackerel · {zone:1438} Teldrassil
	["{skill:356} 53 to 75 where you are: the next {skill:185} stretches' fish come from waters that ask {skill:356} 75. The loop also gives about 20 {item:6303}: keep them, the next stretches use them. The arrow leads to the stand players fish at in {zone:1438}: stay there while you catch fish."] = "",

	-- Step 12: Fish Raw Slitherskin Mackerel (Fishing 1-51)
	-- {item:6303} Raw Slitherskin Mackerel · {skill:356} Fishing
	["Fish {item:6303} ({skill:356} 1-51)"] = "",
	-- {item:6303} Raw Slitherskin Mackerel · {skill:185} Cooking · {item:787} Slitherskin Mackerel · {skill:356} Fishing · {zone:1411} Durotar
	["50 {item:6303} for {skill:185} 1-50: 50 {item:787}. Fish 50 {item:6303} ({skill:356} 1 to 51), then craft 50 {item:787} ({skill:185} 1 to 50). The arrow leads to the stand players fish them at in {zone:1411}: stay there until your bags hold them. Or buy them at the Auction House."] = "",

	-- Step 13: Cooking recipes at 1
	-- {item:6326} Recipe: Slitherskin Mackerel · {item:787} Slitherskin Mackerel · {skill:185} Cooking · {npc:3550} Martine Tramblay · {zone:1420} Tirisfal Glades · {npc:5942} Zansoa · {zone:1411} Durotar · {npc:257006} Nyalah Brightfire
	["{item:6326} teaches {item:787} ({skill:185} 1, 40c). Sold by {npc:3550} ({zone:1420}), {npc:5942} ({zone:1411}) and {npc:257006} (Zephras Isle). The arrow picks the nearest seller of your faction."] = "",

	-- Step 15: Fishing 51-75: Durotar's water
	-- {skill:356} Fishing · {zone:1411} Durotar
	["{skill:356} 51-75: {zone:1411}'s water"] = "",
	-- {skill:356} Fishing · {skill:185} Cooking · {item:6303} Raw Slitherskin Mackerel · {zone:1411} Durotar
	["{skill:356} 51 to 75 where you are: the next {skill:185} stretches' fish come from waters that ask {skill:356} 75. The loop also gives about 25 {item:6303}: keep them, the next stretches use them. The arrow leads to the stand players fish at in {zone:1411}: stay there while you catch fish."] = "",

	-- Step 17: Fish Raw Longjaw Mud Snapper (Fishing 75-102)
	-- {item:6289} Raw Longjaw Mud Snapper · {skill:356} Fishing
	["Fish {item:6289} ({skill:356} 75-102)"] = "",
	-- {item:6289} Raw Longjaw Mud Snapper · {skill:185} Cooking · {item:4592} Longjaw Mud Snapper · {skill:356} Fishing
	["25 {item:6289} for {skill:185} 50-75: 25 {item:4592}. Fish 25 {item:6289} ({skill:356} 75 to 102), then craft 25 {item:4592} ({skill:185} 50 to 75). The arrow takes the {skill:356} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. At the water it leads stand to stand: stay while you catch fish (casting holds the arrow there), walk on when a pool is fished out or the spot is busy. Or buy them at the Auction House."] = "",

	-- Step 18: Cooking recipes at 50
	-- {skill:185} Cooking
	["{skill:185} recipes at 50"] = "",
	-- {item:6328} Recipe: Longjaw Mud Snapper · {item:4592} Longjaw Mud Snapper · {skill:185} Cooking · {npc:66} Tharynn Bouden · {zone:1429} Elwynn Forest · {npc:1684} Khara Deepwater · {zone:1432} Loch Modan · {npc:4265} Nyoma · {zone:1438} Teldrassil · {npc:3027} Naal Mistrunner · {zone:1456} Thunder Bluff · {npc:4574} Lizbeth Cromwell · {zone:1458} Undercity · {npc:5748} Killian Sanatha · {zone:1421} Silverpine Forest
	["{item:6328} teaches {item:4592} ({skill:185} 50, 4s). Sold by Alliance: {npc:66} ({zone:1429}), {npc:1684} ({zone:1432}) and {npc:4265} ({zone:1438}); Horde: {npc:3027} ({zone:1456}), {npc:4574} ({zone:1458}) and {npc:5748} ({zone:1421}). The arrow picks the nearest seller of your faction."] = "",

	-- Step 19: Longjaw Mud Snapper to 75
	-- {item:4592} Longjaw Mud Snapper
	["{item:4592} to 75"] = "",
	-- {item:4592} Longjaw Mud Snapper · {item:6289} Raw Longjaw Mud Snapper · {object:29784} Basic Campfire · {npc:267118} Gilbert Gray · {zone:1453} Stormwind · {item:6529} Shiny Bauble · {item:6530} Nightcrawlers
	["{item:4592} is orange at 50 (yellow 90, green 110, grey 130): about 25 crafts to 75, a point every craft. Each takes 1 {item:6289}. Cook at any fire: a town hearth or your own {object:29784}. From level 7, {npc:267118} at the {zone:1453} harbor gives Fishin' Time: bring 1 {item:6529} and 3 {item:6530} for cooked fish."] = "",

	-- Step 20: Journeyman Cooking
	-- {skill:185} Cooking
	["Journeyman {skill:185}"] = "中級{skill:185}",
	-- {skill:185} Cooking
	["Journeyman {skill:185} raises the cap to 150; it needs skill 50 and no character level, and costs 5s. The arrow picks the nearest {skill:185} trainer of your faction."] = "",

	-- Step 21: Fishing 102-130: Raw Longjaw Mud Snapper and Raw Bristle Whisker Catfish water
	-- {skill:356} Fishing · {item:6289} Raw Longjaw Mud Snapper · {item:6308} Raw Bristle Whisker Catfish
	["{skill:356} 102-130: {item:6289} and {item:6308} water"] = "",
	-- {skill:356} Fishing · {item:4592} Longjaw Mud Snapper · {item:6289} Raw Longjaw Mud Snapper
	["Fish from {skill:356} 102 to 130 for {item:4592}: this loop gives {item:6289}, and the next one the rest from {skill:356} 130. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 22: Expert Fishing
	-- {skill:356} Fishing
	["Expert {skill:356}"] = "高級{skill:356}",
	-- {skill:356} Fishing · {item:16083} Expert Fishing - The Bass and You · {npc:2626} Old Man Heming · {zone:1434} Stranglethorn Vale · {area:35} Booty Bay · {area:392} Ratchet · {zone:1413} The Barrens · {item:6532} Bright Baubles · {item:279965} Fishing Rack · {area:2797} Blackfathom Deeps
	["Expert {skill:356} (cap 225) is a book, not a trainer rank: {item:16083} (1g), {npc:2626} ({zone:1434}) sells it to both factions. Buy it and read it; it needs skill 125 and level 20. At level 20 the safe way to {area:35} is the boat from {area:392} in {zone:1413}. {npc:2626} also sells {item:6532} (+75 from skill 100, 2s 50c each), the lure for harder water. Forever's {item:279965} (a camping item, from {skill:356} 140) is a blueprint that drops from Gelihast in {area:2797}."] = "",
	-- {item:16083} Expert Fishing - The Bass and You · {skill:356} Fishing
	["Buy and read {item:16083} (Expert {skill:356})"] = "購買並閱讀{item:16083}（高級{skill:356}）",

	-- Step 23: Fish Raw Longjaw Mud Snapper (Fishing 130-131)
	-- {item:6289} Raw Longjaw Mud Snapper · {skill:356} Fishing
	["Fish {item:6289} ({skill:356} 130-131)"] = "",
	-- {item:6289} Raw Longjaw Mud Snapper · {skill:185} Cooking · {item:4592} Longjaw Mud Snapper · {skill:356} Fishing
	["28 {item:6289} for {skill:185} 75-100: 28 {item:4592}. Fish 28 {item:6289} ({skill:356} 130 to 131), then craft 27 {item:4592} ({skill:185} 75 to 100). The arrow takes the {skill:356} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. At the water it leads stand to stand: stay while you catch fish (casting holds the arrow there), walk on when a pool is fished out or the spot is busy. Or buy them at the Auction House."] = "",

	-- Step 24: Longjaw Mud Snapper to 100
	-- {item:4592} Longjaw Mud Snapper
	["{item:4592} to 100"] = "",
	-- {item:4592} Longjaw Mud Snapper · {item:6289} Raw Longjaw Mud Snapper · {object:29784} Basic Campfire
	["{item:4592} is orange at 75 (yellow 90, green 110, grey 130): about 27 crafts to 100, up to 28 for 9 players in 10 (the fish above count that many). Each takes 1 {item:6289}. Cook at any fire: a town hearth or your own {object:29784}. If you got here without learning {item:4592}, learn it now: an earlier step teaches it."] = "",

	-- Step 25: Lures for Fishing 130-205
	-- {skill:356} Fishing
	["Lures for {skill:356} 130-205"] = "",
	-- {skill:356} Fishing · {item:6529} Shiny Bauble
	["Some of these waters lose fish below {skill:356} 150: a lure on the pole adds to your skill for ten minutes. {item:6529} (+25, 50c each) closes the gap from 130: about 2 see you to 150 (18 minutes of fishing)."] = "",

	-- Step 26: Fish Raw Bristle Whisker Catfish (Fishing 131-157)
	-- {item:6308} Raw Bristle Whisker Catfish · {skill:356} Fishing
	["Fish {item:6308} ({skill:356} 131-157)"] = "",
	-- {item:6308} Raw Bristle Whisker Catfish · {skill:185} Cooking · {item:4593} Bristle Whisker Catfish · {skill:356} Fishing
	["53 {item:6308} for {skill:185} 100-150: 53 {item:4593}; from your fishing on the way: 12 of 53 {item:6308}. Fish 41 {item:6308} ({skill:356} 131 to 157), then craft 52 {item:4593} ({skill:185} 100 to 150). The arrow takes the {skill:356} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. At the water it leads stand to stand: stay while you catch fish (casting holds the arrow there), walk on when a pool is fished out or the spot is busy. Or buy them at the Auction House."] = "",

	-- Step 27: Cooking recipes at 100
	-- {skill:185} Cooking
	["{skill:185} recipes at 100"] = "",
	-- {item:6330} Recipe: Bristle Whisker Catfish · {item:4593} Bristle Whisker Catfish · {skill:185} Cooking · {npc:2383} Lindea Rabonne · {zone:1424} Hillsbrad Foothills · {npc:3497} Kilxx · {zone:1413} The Barrens · {npc:5494} Catherine Leland · {zone:1453} Stormwind · {npc:2397} Derak Nightfall · {npc:3027} Naal Mistrunner · {zone:1456} Thunder Bluff · {npc:3029} Sewa Mistrunner
	["{item:6330} teaches {item:4593} ({skill:185} 100, 12s). Sold by Alliance: {npc:2383} ({zone:1424}), {npc:3497} ({zone:1413}) and {npc:5494} ({zone:1453}); Horde: {npc:2397} ({zone:1424}), {npc:3027} ({zone:1456}) and {npc:3029} ({zone:1456}). The arrow picks the nearest seller of your faction."] = "",

	-- Step 28: Bristle Whisker Catfish to 150
	-- {item:4593} Bristle Whisker Catfish
	["{item:4593} to 150"] = "",
	-- {item:4593} Bristle Whisker Catfish · {item:6308} Raw Bristle Whisker Catfish · {object:29784} Basic Campfire · {npc:267118} Gilbert Gray · {zone:1453} Stormwind · {item:6529} Shiny Bauble · {item:6530} Nightcrawlers
	["{item:4593} is orange at 100 (yellow 140, green 160, grey 180): about 52 crafts to 150, up to 53 for 9 players in 10 (the fish above count that many). Each takes 1 {item:6308}. Cook at any fire: a town hearth or your own {object:29784}. From level 7, {npc:267118} at the {zone:1453} harbor gives Fishin' Time: bring 1 {item:6529} and 3 {item:6530} for cooked fish."] = "",

	-- Step 29: Expert Cooking
	-- {skill:185} Cooking
	["Expert {skill:185}"] = "高級{skill:185}",
	-- {skill:185} Cooking · {item:16072} Expert Cookbook · {npc:3955} Shandrina · {zone:1440} Ashenvale · {npc:12033} Wulan · {zone:1443} Desolace
	["Expert {skill:185} (cap 225) is a book, not a trainer rank: {item:16072} (1g), sold by {npc:3955} ({zone:1440}) for the Alliance and {npc:12033} ({zone:1443}) for the Horde. Buy it and read it; it needs skill 125 and level 20."] = "",
	-- {item:16072} Expert Cookbook · {skill:185} Cooking
	["Buy and read {item:16072} (Expert {skill:185})"] = "購買並閱讀{item:16072}（高級{skill:185}）",

	-- Step 30: Fishing 157-205: Raw Bristle Whisker Catfish water
	-- {skill:356} Fishing · {item:6308} Raw Bristle Whisker Catfish
	["{skill:356} 157-205: {item:6308} water"] = "",
	-- {skill:356} Fishing · {item:4593} Bristle Whisker Catfish · {item:6308} Raw Bristle Whisker Catfish
	["Fish from {skill:356} 157 to 205 for {item:4593}: this loop gives {item:6308}, and the next one the rest from {skill:356} 205. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 31: Fish Raw Bristle Whisker Catfish (Fishing 205-211)
	-- {item:6308} Raw Bristle Whisker Catfish · {skill:356} Fishing
	["Fish {item:6308} ({skill:356} 205-211)"] = "",
	-- {item:6308} Raw Bristle Whisker Catfish · {skill:185} Cooking · {item:4593} Bristle Whisker Catfish · {skill:356} Fishing
	["86 {item:6308} for {skill:185} 150-175: 86 {item:4593}. Fish 86 {item:6308} ({skill:356} 205 to 211), then craft 69 {item:4593} ({skill:185} 150 to 175). The arrow takes the {skill:356} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. At the water it leads stand to stand: stay while you catch fish (casting holds the arrow there), walk on when a pool is fished out or the spot is busy. Or buy them at the Auction House."] = "",

	-- Step 32: Bristle Whisker Catfish to 175
	-- {item:4593} Bristle Whisker Catfish
	["{item:4593} to 175"] = "",
	-- {item:4593} Bristle Whisker Catfish · {item:6308} Raw Bristle Whisker Catfish · {object:29784} Basic Campfire
	["{item:4593} is yellow at 150 (yellow 140, green 160, grey 180): about 69 crafts to 175, up to 86 for 9 players in 10 (the fish above count that many). Each takes 1 {item:6308}. Cook at any fire: a town hearth or your own {object:29784}. If you got here without learning {item:4593}, learn it now: an earlier step teaches it."] = "",

	-- Step 33: Fish Raw Mithril Head Trout (Fishing 211-225)
	-- {item:8365} Raw Mithril Head Trout · {skill:356} Fishing
	["Fish {item:8365} ({skill:356} 211-225)"] = "",
	-- {item:8365} Raw Mithril Head Trout · {skill:185} Cooking · {spell:20916} Mithril Headed Trout · {skill:356} Fishing
	["53 {item:8365} for {skill:185} 175-225: 53 {spell:20916}; from your fishing on the way: 5 of 53 {item:8365}. Fish 49 {item:8365} ({skill:356} 211 to 225), then craft 52 {spell:20916} ({skill:185} 175 to 225). The arrow takes the {skill:356} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. At the water it leads stand to stand: stay while you catch fish (casting holds the arrow there), walk on when a pool is fished out or the spot is busy. Or buy them at the Auction House."] = "",

	-- Step 34: Cooking recipes at 175
	-- {skill:185} Cooking
	["{skill:185} recipes at 175"] = "",
	-- {item:17062} Recipe: Mithril Head Trout · {spell:20916} Mithril Headed Trout · {skill:185} Cooking · {npc:2383} Lindea Rabonne · {zone:1424} Hillsbrad Foothills · {npc:2664} Kelsey Yance · {zone:1434} Stranglethorn Vale · {npc:3178} Stuart Fleming · {zone:1437} Wetlands · {npc:3333} Shankys · {zone:1454} Orgrimmar · {npc:4574} Lizbeth Cromwell · {zone:1458} Undercity
	["{item:17062} teaches {spell:20916} ({skill:185} 175, 22s). Sold by Alliance: {npc:2383} ({zone:1424}), {npc:2664} ({zone:1434}) and {npc:3178} ({zone:1437}); Horde: {npc:2664} ({zone:1434}), {npc:3333} ({zone:1454}) and {npc:4574} ({zone:1458}). The arrow picks the nearest seller of your faction."] = "",

	-- Step 35: Mithril Headed Trout to 225
	-- {spell:20916} Mithril Headed Trout
	["{spell:20916} to 225"] = "",
	-- {spell:20916} Mithril Headed Trout · {item:8365} Raw Mithril Head Trout · {object:29784} Basic Campfire
	["{spell:20916} is orange at 175 (yellow 215, green 235, grey 255): about 52 crafts to 225, up to 53 for 9 players in 10 (the fish above count that many). Each takes 1 {item:8365}. Cook at any fire: a town hearth or your own {object:29784}."] = "",

	-- Step 36: Giant Eggs
	-- plural, as words: Giant Eggs = {item:12207} Giant Egg
	["Giant Eggs"] = "巨蛋",
	-- {quest:6610} Clamlette Surprise · {item:7974} Zesty Clam Meat · {item:8932} Alterac Swiss · {zone:1446} Tanaris · {zone:1425} The Hinterlands · {npc:2929} Savage Owlbeast
	-- plural, as words: Giant Eggs = {item:12207} Giant Egg
	["{quest:6610} asks for 12 Giant Eggs, 10 {item:7974} and 20 {item:8932}: bring all three before you go to {zone:1446}, so you make the trip once. Giant Eggs drop from the owlbeasts of {zone:1425}: {npc:2929} (54%)."] = "",

	-- Step 37: Alterac Swiss
	-- {item:8932} Alterac Swiss
	["Innkeepers and food vendors sell {item:8932}; the arrow picks the nearest."] = "旅店老闆和食品商人都出售{item:8932}；箭頭會指向最近的一位。",

	-- Step 38: Zesty Clam Meat
	-- {item:7974} Zesty Clam Meat · {zone:1445} Dustwallow Marsh · {zone:1446} Tanaris
	-- plural, as words: Big-mouth Clams = {item:7973} Big-mouth Clam · Steeljaw Snappers = {npc:14123} Steeljaw Snapper
	["{item:7974} comes from Big-mouth Clams: open each one, every clam holds one. The Muckshell crabs on the {zone:1445} coast south-west of Theramore drop a clam about seven kills in ten, so ten clams take about fifteen kills, on your way to {zone:1446}. The Steeljaw Snappers on {zone:1446}'s east coast drop them about one kill in three."] = "{item:7974}來自大嘴蛤蜊：每個都要開啟，每隻蛤蜊裡都有一個。塞拉摩西南{zone:1445}海岸的泥殼蟹約每十次擊殺掉落七次蛤蜊，所以十個蛤蜊約需十五次擊殺，正好在去{zone:1446}的路上。{zone:1446}東海岸的鋼顎鉗嘴龜約每三次擊殺掉一次。",

	-- Step 39: Lures for Fishing 255-300
	-- {skill:356} Fishing
	["Lures for {skill:356} 255-300"] = "",
	-- {skill:356} Fishing · {item:6530} Nightcrawlers
	["This water loses fish below {skill:356} 300: a lure on the pole adds to your skill for ten minutes. {item:6530} (+50 from skill 50, 1s each) closes the gap from 255: about 11 see you to 300 (102 minutes of fishing)."] = "",

	-- Step 40: Nat Pagle, Angler Extreme
	-- {skill:356} Fishing · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh · {zone:1455} Ironforge
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1455} sends you to him; the quest needs skill 225 and level 35."] = "專家級{skill:356}（上限300）來自{zone:1445}的{npc:12919}。{zone:1455}的釣魚訓練師會派你去找他；任務需要技能225和等級35。",

	-- Step 41: Nat Pagle, Angler Extreme
	-- {skill:356} Fishing · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh · {zone:1454} Orgrimmar
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1454} sends you to him; the quest needs skill 225 and level 35."] = "專家級{skill:356}（上限300）來自{zone:1445}的{npc:12919}。{zone:1454}的釣魚訓練師會派你去找他；任務需要技能225和等級35。",

	-- Step 42: Nat Pagle
	-- {npc:12919} Nat Pagle
	["{npc:12919} fishes from the shore of a small island off the east coast, south of Theramore; swim over from the coast."] = "{npc:12919}在塞拉摩南邊、東海岸外一座小島的岸邊釣魚；從海岸游過去。",

	-- Step 43: Sar'theris Striker
	-- {zone:1443} Desolace · {area:598} Sar'theris Strand · {area:2408} Shadowprey Village · {item:16968} Sar'theris Striker
	["Fish along the coast of {zone:1443} ({area:598} in the north-west, or the shore west of {area:2408}) until you catch a {item:16968}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "在{zone:1443}海岸（西北的{area:598}，或{area:2408}以西的岸邊）釣魚，直到釣上{item:16968}：那裡約每五竿出一竿，別處不會咬鉤。技能225時這裡不會跑魚。",

	-- Step 45: Feralas Ahi
	-- {area:2521} Verdantis River · {zone:1444} Feralas · {area:2577} Dire Maul · {item:16967} Feralas Ahi · {item:6532} Bright Baubles
	["Fish along the {area:2521} in {zone:1444} (south-east of {area:2577}) until you catch a {item:16967}: about one catch in five there brings it up, and it bites nowhere else. This water loses fish below skill 300: at 225 most get away, so put {item:6532} (+75) on the pole first."] = "在{zone:1444}的{area:2521}（{area:2577}東南）釣魚，直到釣上{item:16967}：那裡約每五竿出一竿，別處不會咬鉤。這片水域在技能300以下會跑魚：225時大部分會跑掉，所以先給魚竿裝上{item:6532}（+75）。",

	-- Step 46: Savage Coast Blue Sailfin
	-- {zone:1434} Stranglethorn Vale · {area:301} Savage Coast · {item:16969} Savage Coast Blue Sailfin
	["Fish along {zone:1434}'s {area:301} (the west shore) until you catch a {item:16969}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "在{zone:1434}的{area:301}（西岸）釣魚，直到釣上{item:16969}：那裡約每五竿出一竿，別處不會咬鉤。技能225時這裡不會跑魚。",

	-- Step 48: Misty Reed Mahi Mahi
	-- {area:300} Misty Reed Strand · {zone:1435} Swamp of Sorrows · {item:16970} Misty Reed Mahi Mahi
	["Fish along the {area:300} (the east shore of {zone:1435}) until you catch a {item:16970}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "在{area:300}（{zone:1435}東岸）釣魚，直到釣上{item:16970}：那裡約每五竿出一竿，別處不會咬鉤。技能225時這裡不會跑魚。",

	-- Step 49: Nat Pagle
	-- {skill:356} Fishing
	["Artisan {skill:356}"] = "專家級{skill:356}",

	-- Step 50: Fish Raw Mithril Head Trout (Fishing 225-248)
	-- {item:8365} Raw Mithril Head Trout · {skill:356} Fishing
	["Fish {item:8365} ({skill:356} 225-248)"] = "",
	-- {item:8365} Raw Mithril Head Trout · {skill:185} Cooking · {spell:20916} Mithril Headed Trout · {skill:356} Fishing
	["86 {item:8365} for {skill:185} 225-250: 86 {spell:20916}. Fish 86 {item:8365} ({skill:356} 225 to 248), then craft 69 {spell:20916} ({skill:185} 225 to 250). The arrow takes the {skill:356} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. At the water it leads stand to stand: stay while you catch fish (casting holds the arrow there), walk on when a pool is fished out or the spot is busy. Or buy them at the Auction House."] = "",

	-- Step 51: Dirge Quikcleave
	-- {skill:185} Cooking · {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {zone:1446} Tanaris · {zone:1455} Ironforge
	["Artisan {skill:185} comes from {npc:8125} in {area:976} ({zone:1446}). The cooking trainer in {zone:1455} sends you; it needs skill 225 and level 35."] = "專家級{skill:185}由{area:976}（{zone:1446}）的{npc:8125}傳授。{zone:1455}的烹飪訓練師會派你去；需要技能225和等級35。",

	-- Step 52: Dirge Quikcleave
	-- {skill:185} Cooking · {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {zone:1446} Tanaris · {zone:1454} Orgrimmar
	["Artisan {skill:185} comes from {npc:8125} in {area:976} ({zone:1446}). The cooking trainer in {zone:1454} sends you; it needs skill 225 and level 35."] = "專家級{skill:185}由{area:976}（{zone:1446}）的{npc:8125}傳授。{zone:1454}的烹飪訓練師會派你去；需要技能225和等級35。",

	-- Step 53: Clamlette Surprise
	-- {skill:185} Cooking
	["Artisan {skill:185}"] = "專家級{skill:185}",

	-- Step 54: Mithril Headed Trout to 250
	-- {spell:20916} Mithril Headed Trout
	["{spell:20916} to 250"] = "",
	-- {spell:20916} Mithril Headed Trout · {item:8365} Raw Mithril Head Trout · {object:29784} Basic Campfire
	["{spell:20916} is yellow at 225 (yellow 215, green 235, grey 255): about 69 crafts to 250, up to 86 for 9 players in 10 (the fish above count that many). Each takes 1 {item:8365}. Cook at any fire: a town hearth or your own {object:29784}. If you got here without learning {spell:20916}, learn it now: an earlier step teaches it."] = "",

	-- Step 55: Fishing 248-255: Raw Mithril Head Trout water
	-- {skill:356} Fishing · {item:8365} Raw Mithril Head Trout
	["{skill:356} 248-255: {item:8365} water"] = "",
	-- {skill:356} Fishing · {item:13930} Filet of Redgill · {item:13758} Raw Redgill · {item:6308} Raw Bristle Whisker Catfish · {item:8365} Raw Mithril Head Trout · {item:21153} Raw Greater Sagefish
	["{skill:356} 248 to 255 before {item:13930}: its {item:13758} come from {skill:356} 255. The loop also gives about 15 {item:6308}, 25 {item:8365} and 5 {item:21153}: keep them, the next stretches use them. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 56: Fish Raw Redgill (Fishing 255-264)
	-- {item:13758} Raw Redgill · {skill:356} Fishing
	["Fish {item:13758} ({skill:356} 255-264)"] = "",
	-- {item:13758} Raw Redgill · {skill:185} Cooking · {skill:356} Fishing
	["47 {item:13758} for {skill:185} 250-285: 47 Filets of Redgill. Fish 47 {item:13758} ({skill:356} 255 to 264), then craft 43 Filets of Redgill ({skill:185} 250 to 285). The arrow takes the {skill:356} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. At the water it leads stand to stand: stay while you catch fish (casting holds the arrow there), walk on when a pool is fished out or the spot is busy. Or buy them at the Auction House."] = "",

	-- Step 57: Cooking recipes at 250
	-- {skill:185} Cooking
	["{skill:185} recipes at 250"] = "",
	-- {item:13941} Recipe: Filet of Redgill · {item:13930} Filet of Redgill · {skill:185} Cooking · {npc:2664} Kelsey Yance · {zone:1434} Stranglethorn Vale
	["{item:13941} teaches {item:13930} ({skill:185} 225, 1g 60s). Sold by Alliance: {npc:2664} ({zone:1434}); Horde: {npc:2664} ({zone:1434}). The arrow picks the nearest seller of your faction."] = "",

	-- Step 58: Filet of Redgill to 285
	-- {item:13930} Filet of Redgill
	["{item:13930} to 285"] = "",
	-- {item:13930} Filet of Redgill · {item:13758} Raw Redgill · {object:29784} Basic Campfire
	["{item:13930} is orange at 250 (yellow 265, green 285, grey 305): about 43 crafts to 285, up to 47 for 9 players in 10 (the fish above count that many). Each takes 1 {item:13758}. Cook at any fire: a town hearth or your own {object:29784}."] = "",

	-- Step 59: Fish Raw Nightfin Snapper (Fishing 264-272)
	-- {item:13759} Raw Nightfin Snapper · {skill:356} Fishing
	["Fish {item:13759} ({skill:356} 264-272)"] = "",
	-- {item:13759} Raw Nightfin Snapper · {skill:185} Cooking · {skill:356} Fishing
	-- plural, as words: Nightfin Soups = {item:13931} Nightfin Soup
	["18 {item:13759} for {skill:185} 285-300: 18 Nightfin Soups; from your fishing on the way: 10 of 18 {item:13759}. Fish 9 {item:13759} ({skill:356} 264 to 272), then craft 17 Nightfin Soups ({skill:185} 285 to 300). The arrow takes the {skill:356} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. At the water it leads stand to stand: stay while you catch fish (casting holds the arrow there), walk on when a pool is fished out or the spot is busy. Or buy them at the Auction House."] = "",

	-- Step 60: Fishing 272-300: Raw Redgill and Raw Nightfin Snapper water
	-- {skill:356} Fishing · {item:13758} Raw Redgill · {item:13759} Raw Nightfin Snapper
	["{skill:356} 272-300: {item:13758} and {item:13759} water"] = "",
	-- {skill:356} Fishing · {skill:185} Cooking · {item:6358} Oily Blackmouth · {item:8365} Raw Mithril Head Trout · {item:13758} Raw Redgill · {item:13759} Raw Nightfin Snapper
	["{skill:356} 272 to 300 before the last stretch: the guide ends with {skill:185}, so finish {skill:356} here. The loop also gives about 25 {item:6358}, 30 {item:8365}, 140 {item:13758} and 30 {item:13759}: keep them, the next stretches use them. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 61: Cooking recipes at 285
	-- {skill:185} Cooking
	["{skill:185} recipes at 285"] = "",
	-- {item:13945} Recipe: Nightfin Soup · {item:13931} Nightfin Soup · {skill:185} Cooking · {item:159} Refreshing Spring Water · {npc:8137} Gikkix · {zone:1446} Tanaris
	["{item:13945} teaches {item:13931} ({skill:185} 250, 2g); 17 {item:159} for the crafts. Sold by Alliance: {npc:8137} ({zone:1446}); Horde: {npc:8137} ({zone:1446}). The arrow picks the nearest seller of your faction."] = "",

	-- Step 62: Nightfin Soup to 300
	-- {item:13931} Nightfin Soup
	["{item:13931} to 300"] = "",
	-- {item:13931} Nightfin Soup · {item:13759} Raw Nightfin Snapper · {item:159} Refreshing Spring Water · {object:29784} Basic Campfire
	["{item:13931} is orange at 285 (yellow 290, green 310, grey 330): about 17 crafts to 300, up to 18 for 9 players in 10 (the fish above count that many). Each takes 1 {item:13759} and 1 {item:159}. Cook at any fire: a town hearth or your own {object:29784}."] = "",
}
