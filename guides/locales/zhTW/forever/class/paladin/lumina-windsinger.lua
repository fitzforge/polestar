-- Chinese (traditional) (zhTW): the guide forever/class/paladin/lumina-windsinger (forever/class/paladin/lumina-windsinger.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:268484} Moonsilver Blade · {item:267369} Wolfsbane
	["{item:268484} and {item:267369} (Forsaken)"] = "",
	-- {quest:91862} Lumina Windsinger · {quest:95140} Old Fire-Eye
	["The Forsaken paladin's two-handed sword: rescue {quest:91862}, gather three parts, slay {quest:95140}."] = "",

	-- Step 1: Danitha Morr
	-- {npc:246378} Danitha Morr · {area:16602} Bandarion Keep · {area:156} Solliden Farmstead · {area:228} Sepulcher · {zone:1421} Silverpine Forest
	["At 18 {npc:246378}, inside {area:16602} on the bluffs north-west of the {area:156}, sends you south to the {area:228} in {zone:1421}."] = "",

	-- Step 2: Sepulcher
	-- {npc:248840} Trevan Rol · {area:228} Sepulcher · {npc:259611} Deathguard Baldren
	["{npc:248840} stands in the lower part of the {area:228}, below the surface; {npc:259611} keeps watch near the town's entrance."] = "",

	-- Step 3: The pyre on Fenris Isle
	-- {area:172} Fenris Isle
	["The pyre on {area:172}"] = "{area:172}上的火葬堆",
	-- {area:172} Fenris Isle · {area:228} Sepulcher · {object:566037} Charred Remains (no name in this language: may be words)
	["{area:172} lies in the lake north-east of the {area:228}. The gnolls' pyre, with the {object:566037}, is on its shore: click the remains to hand in, and click them again for the next quest. The body is a tauren's, not the elf's."] = "",
	-- {object:566037} Charred Remains (no name in this language: may be words)
	["from the {object:566037}"] = "來自{object:566037}",

	-- Step 4: Fenris Keep
	-- {quest:91862} Lumina Windsinger · {area:235} Fenris Keep · {item:267412} Fenris Isle Key · {npc:1944} Rot Hide Bruiser
	["{quest:91862} is caged in the basement of {area:235}, at the north end of the isle. The Rot Hide gnolls (level 18-19) fill the keep: they pull in big groups across floors and players report very fast respawns, so clear a path and keep moving. Any of them can carry the {item:267412} (often the first kill); the rare {npc:1944} (22) and Snarlmane (23) can too. If her cage is empty, another player is escorting her: wait for her to come back."] = "",
	-- {item:267412} Fenris Isle Key
	["{item:267412}, from the Rot Hide gnolls"] = "{item:267412}，來自腐皮豺狼人",

	-- Step 5: Free Lumina Windsinger
	-- {npc:248755} Lumina Windsinger
	["Free {npc:248755}"] = "救出{npc:248755}",
	-- {npc:248755} Lumina Windsinger · {area:228} Sepulcher
	["Hand in the key first: starting the escort before that gives the key quest no credit. Then open the cage: {npc:248755} walks out through the keep and its courtyard while the gnolls attack, then runs for the dock and makes her own way back to the {area:228}. Stay close and keep her alive; if she dies, take the quest again when she is back in her cage."] = "",

	-- Step 6: Back to the Sepulcher
	-- {area:228} Sepulcher
	["Back to the {area:228}"] = "返回{area:228}",
	-- {npc:259620} Lumina Windsinger · {npc:248840} Trevan Rol · {area:228} Sepulcher · {quest:95034} The Debt
	["{npc:259620} waits beside {npc:248840} in the {area:228} (a different {npc:259620} from the one you escorted). For {quest:95034}, click through every line of her story."] = "",
	-- {npc:259620} Lumina Windsinger · {area:228} Sepulcher
	["{npc:259620}, the {area:228}"] = "{npc:259620}，{area:228}",
	-- {npc:259620} Lumina Windsinger
	["{npc:259620}: hear her story to the end"] = "",

	-- Step 7: A Moon-Kissed Blade
	-- {npc:259620} Lumina Windsinger · {quest:95140} Old Fire-Eye · {npc:248840} Trevan Rol
	["At 20 {npc:259620} asks for a blade that can kill {quest:95140}. Talk to {npc:248840} beside her for his Weapon Notes, which list the parts, and keep them: he wants them back with the parts. Three parts, in any order: two from dungeons (a group of five each) and a gem from elite naga outside a third."] = "",
	-- {item:267454} Trevan's Weapon Notes · {npc:248840} Trevan Rol
	["{item:267454}: talk to {npc:248840}"] = "",

	-- Step 8: The Enchanted Silver Ingot
	-- {item:267361} Enchanted Silver Ingot
	["The {item:267361}"] = "",
	-- {area:236} Shadowfang Keep · {npc:4275} Archmage Arugal
	["{area:236} is the dungeon in south Silverpine, for a group of five in the low to mid 20s. The ingot sits on the table next to {npc:4275} at the very end. A friend's cleared instance works: walk in and run to the table."] = "",
	-- {item:267361} Enchanted Silver Ingot
	["{item:267361}, on Arugal's table"] = "",

	-- Step 9: Whitestone Oak Lumber
	-- {area:1581} The Deadmines · {area:20} Moonbrook · {zone:1436} Westfall · {zone:1458} Undercity · {object:3202} Grom'gol · {zone:1434} Stranglethorn Vale · {zone:1431} Duskwood
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["{area:1581} lies under {area:20} in {zone:1436}, Alliance land: a group of five at about 17-24. From the {zone:1458} take the zeppelin to {object:3202} in {zone:1434} and go north through {zone:1431} into {zone:1436}. The way in is the {area:20} mine. The Goblin Woodcarvers (elite, level 18-19) in Sneed's mast room drop the lumber every time."] = "",
	-- {area:1581} The Deadmines · {area:20} Moonbrook
	["{area:1581}, in the {area:20} mine"] = "{area:1581}，在{area:20}礦坑內",
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["Goblin Woodcarvers, inside"] = "哥布林木匠，副本內",

	-- Step 10: Ulric Frostveil
	-- {npc:259649} Ulric Frostveil · {area:2897} Zoram'gar Outpost · {zone:1440} Ashenvale · {object:3202} Grom'gol · {zone:1458} Undercity · {zone:1454} Orgrimmar · {zone:1413} Barrens
	["{npc:259649} waits at {area:2897} on {zone:1440}'s west coast: take the zeppelin from {object:3202} (or the {zone:1458}) to {zone:1454}, then go north through the {zone:1413} into {zone:1440} and west along the road. Andruk, the outpost's wind rider master, saves you the walk next time. Take {npc:259649}'s quest before you hunt the naga: the Kor Gem only drops while you have it."] = "",

	-- Step 11: The Corrupted Kor Gem
	-- {item:6995} Corrupted Kor Gem
	["The {item:6995}"] = "{item:6995}",
	-- {area:2797} Blackfathom Deeps · {item:6995} Corrupted Kor Gem · {spell:122} Frost Nova
	["The naga stand in the flooded ruins and passages around the {area:2797} entrance, just north of Zoram'gar: you do not need to enter the instance (its first naga drop the gem too). Tide Priestesses (level 20-21), Oracles (21-22) and Sea Witches (23-24) drop the {item:6995}, one in two. All are elite: grouping up is encouraged. Players solo them one at a time, with difficulty; a group of three makes it easy. They heal themselves, run for help at low health, and the Sea Witches cast {spell:122} up close. Some players report no drop while in a raid group."] = "",

	-- Step 12: The Purified Kor Gem
	-- {item:272448} Purified Kor Gem
	["The {item:272448}"] = "",
	-- {npc:259649} Ulric Frostveil · {item:272448} Purified Kor Gem · {npc:248840} Trevan Rol
	["Back to {npc:259649} at Zoram'gar: he cleanses the gem. Keep the {item:272448} for {npc:248840}."] = "",

	-- Step 13: Trevan Rol
	-- {npc:248840} Trevan Rol · {area:228} Sepulcher · {item:268192} Bundle of Blacksmithing Materials · {area:272} Tarren Mill
	["Bring the lumber, the ingot and the gem to {npc:248840} in the {area:228}. He gives you a {item:268192} for a smith in {area:272}: keep it in your bags."] = "",

	-- Step 14: Ott
	-- {npc:3539} Ott · {area:272} Tarren Mill · {zone:1424} Hillsbrad Foothills · {quest:95125} Ott's Masterwork
	["{npc:3539}, the weaponsmith, stands just south of {area:272} in {zone:1424}. Accepting {quest:95125} starts the forging: step back and wait near him until he is done."] = "",
	-- {npc:3539} Ott
	["Watch {npc:3539} forge the blade"] = "",
	-- {npc:3539} Ott · {quest:95125} Ott's Masterwork
	["{npc:3539} gives you {quest:95125}"] = "",

	-- Step 15: The Moonsilver Blade
	-- {npc:248840} Trevan Rol · {area:228} Sepulcher · {item:268484} Moonsilver Blade
	["Back to {npc:248840} in the {area:228}'s lower part: he hands you the {item:268484}, a two-handed sword."] = "",

	-- Step 16: Two-Handed Swords
	-- {npc:11870} Archibald · {zone:1458} Undercity · {object:36070} War Quarter · {spell:202} Two-Handed Swords
	["The blade is a two-handed sword, and you need the skill to hit a level 25 elite with it. {npc:11870}, the weapon master in the {zone:1458}'s {object:36070}, teaches {spell:202} for a small fee; then swing it on easy mobs until the skill is near its cap (five points per level)."] = "",

	-- Step 17: Old Fire-Eye
	-- {item:268484} Moonsilver Blade · {quest:95140} Old Fire-Eye · {area:228} Sepulcher · {area:17065} Gilneas
	["Equip the {item:268484}. {quest:95140}, the great worgen, roams the woods south of the {area:228} toward the gates of {area:17065}. He is elite (level 25): grouping up is encouraged; one player needed a second, another soloed him at 25. A purple shield guards him until your first swing with the blade lands: a message tells you it broke."] = "",
	-- {quest:95140} Old Fire-Eye · {item:268484} Moonsilver Blade
	["{quest:95140}, with the {item:268484} equipped"] = "",

	-- Step 18: Wolfsbane
	-- {npc:259620} Lumina Windsinger · {area:228} Sepulcher · {item:268484} Moonsilver Blade · {item:267369} Wolfsbane
	["Back to {npc:259620} in the {area:228} with the {item:268484} (the quest asks for it): she takes it and blesses it with the magic of her people into {item:267369}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Free her with the key, then stay close while she fights her way out of the keep."] = "用鑰匙救出她，然後在她殺出要塞時待在她身邊。",
	-- ["No item yet: a Forsaken paladin rescue story; its sequel, the {item:268484}, cannot be finished yet."] = "目前沒有物品：一段被遺忘者聖騎士的救援故事；它的續篇{item:268484}目前還無法完成。",
	-- ["Once she is clear of {area:235}, Lumina waits for you in the {area:228}. Speak with her again to hear what really happened on the road."] = "一旦她離開了{area:235}，露蜜娜會在{area:228}等你。再次與她交談，聽聽路上到底發生了什麼事。",
	-- ["Once she is clear of {area:235}, {npc:259620} waits for you in the {area:228}. Speak with her again to hear what really happened on the road."] = "一旦她離開了{area:235}，{npc:259620}會在{area:228}等你。再次與她交談，聽聽路上到底發生了什麼事。",
	-- ["Rescuing {quest:91862}"] = "營救{quest:91862}",
	-- ["Ride south through {zone:1421} to the {area:228}. {npc:248840} stands in the town; {npc:259611} keeps watch near its entrance."] = "向南騎過{zone:1421}前往{area:228}。{npc:248840}站在鎮上；{npc:259611}在入口附近守望。",
	-- ["{area:172} lies in the lake east of the {area:228}. The charred remains are on its shore."] = "{area:172}位於{area:228}東邊的湖中。燒焦的遺骸就在島的岸邊。",
	-- ["{npc:246378} leads the Paladins of Tyr's Watch from inside {area:16602}, on the bluffs north-west of the {area:156}."] = "{npc:246378}在{area:156}西北方崖頂上的{area:16602}內領導 Tyr's Watch 的聖騎士。",
	-- ["{quest:91862} is caged inside {area:235}, at the north end of the isle. The Rot Hide gnolls around her carry the key."] = "{quest:91862}被關在島北端的{area:235}裡。她周圍的腐皮豺狼人身上帶著鑰匙。",
	-- ["{zone:1458} and Earthen Ring reputation"] = "{zone:1458}與陶土議會聲望",
}
