-- Russian (ruRU): the guide forever/horde/30-40/06-badlands (forever/horde/30-40/06-badlands.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into the Badlands
	-- {zone:1418} Badlands
	["Into the {zone:1418}"] = "В край {zone:1418}",
	-- {object:2673} Thandol Span (no name in this language: may be words) · {zone:1437} Wetlands · {object:1162} Menethil Harbor (no name in this language: may be words) · {zone:1432} Loch Modan · {zone:1418} Badlands
	["Head for the {object:2673}, the great bridge at Arathi's southern edge, cross it and go south through the {zone:1437} (keep clear of {object:1162}) and east into {zone:1432}; the road leaves {zone:1432} to the south into the {zone:1418}. Follow it south to the goblin camp in the Valley of Fangs."] = "",
	["Valley of Fangs"] = "",

	-- Step 2: Valley of Fangs
	-- {quest:1106} Martek the Exiled · {object:151976} Shimmering Flats (no name in this language: may be words)
	["{quest:1106}: Fizzle's letter from the {object:151976}"] = "",

	-- Step 3: The Dustbowl
	["The Dustbowl"] = "",
	-- {npc:2921} Lotwil Veriatus
	["Head west along the road towards Kargath; {npc:2921}'s camp sits in the Dustbowl halfway there."] = "",

	-- Step 4: Kargath
	["Kargath"] = "",
	-- {npc:5394} Neeka Bloodscar
	["Kargath is the Horde fortress built into the cliffs at the zone's western edge. {npc:5394} stands on Kargath's upper level, high above the flight master: take the ramps up, the arrow cannot tell the levels apart."] = "",
	["for Helgrum in Stonard, around level 42"] = "",
	-- {npc:6868} Jarkal Mossmeld
	["{npc:6868}, inside"] = "",

	-- Step 5: Lesser Rock Elementals
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["Lesser Rock Elementals"] = "Младшие каменные элементали",
	-- {npc:2921} Lotwil Veriatus · {npc:6868} Jarkal Mossmeld
	-- plural, as words: Rock Elemental Shards = {item:7848} Rock Elemental Shard
	["The small elementals drift across the flats between Kargath and {npc:2921}'s camp, on the road back east. Every rock elemental in the zone can drop {npc:6868}'s Rock Elemental Shards."] = "",

	-- Step 7: Badlands: kill these as you meet them
	-- {zone:1418} Badlands
	["{zone:1418}: kill these as you meet them"] = "",
	-- {npc:6868} Jarkal Mossmeld
	-- plural, as words: Elder Crag Coyotes = {npc:2729} Elder Crag Coyote · Giant Buzzards = {npc:2831} Giant Buzzard · Rock Elementals = {npc:92} Rock Elemental · Rock Elemental Shards = {item:7848} Rock Elemental Shard
	["The Elder Crag Coyotes and Giant Buzzards roam the basin south of the Dustbowl. Coyotes drop both the jawbones and the fangs; the Giant Buzzards drop the gizzards.\nThe bigger Rock Elementals stand on the slopes north-west of the Dustbowl; each one drops a slab. Every rock elemental can drop {npc:6868}'s Rock Elemental Shards."] = "",

	-- Step 9: Agmond's End
	["Agmond's End"] = "",
	["Theldurin sits among the dwarven ruins at Agmond's End, south of the Valley of Fangs."] = "",

	-- Step 10: Stonevault troggs
	["Stonevault troggs"] = "Трогги Каменного Свода",
	-- {npc:2817} Rigglefuzz
	["The Stonevault troggs dig around the cave mouths south of the Valley of Fangs, on the way to Agmond's End; the Bonesnappers and Shamans drop the flakes. The Buzzards for {npc:2817}'s wings circle the hills between the Valley of Fangs and Agmond's End."] = "",

	-- Step 11: Valley of Fangs
	-- {npc:2817} Rigglefuzz · {npc:4618} Martek the Exiled
	["The road north to Uldaman runs through the Valley of Fangs: {npc:2817} and {npc:4618} take the wings and the flakes on the way."] = "",

	-- Step 12: Ancient Chest
	["Keep north on the road; the chest lies in the Uldaman dig site, at the foot of the ruins north-west of the road."] = "",
	["Below ground"] = "",

	-- Step 13: Agmond's End
	["Head back south down the road, past the Valley of Fangs."] = "",

	-- Step 14: The Dustbowl: kill these as you meet them
	["The Dustbowl: kill these as you meet them"] = "",
	-- {zone:1418} Badlands · {npc:6868} Jarkal Mossmeld · {npc:2921} Lotwil Veriatus
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental · Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["Every rock elemental in the {zone:1418} drops {npc:6868}'s shards: the Lesser Rock Elementals (37) on the flats west of {npc:2921}'s camp are the safe ones, about one kill in five. Only the Greater Rock Elementals (42-44, well above you) in the south-western gulches drop {npc:2921}'s bracers, also about one kill in five: pull one at a time and rest between fights, or leave them. Keep killing coyotes and buzzards you still need on the way."] = "",

	-- Step 15: The Dustbowl
	-- {npc:2920} Lucien Tosselwrench · {item:2868} Patterned Bronze Bracers · {skill:164} Blacksmithing
	["{npc:2920}: only if you carry {item:2868} ({skill:164} or the Auction House)"] = "{npc:2920}: только если у вас есть {item:2868} ({skill:164} или аукцион)",

	-- Step 16: Kargath
	-- {npc:5394} Neeka Bloodscar
	["Head north back to Kargath. {npc:5394} stands on Kargath's upper level, high above the flight master: take the ramps up, the arrow cannot tell the levels apart."] = "",
	-- {object:3204} Booty Bay (no name in this language: may be words)
	["The next guide flies from Kargath to {object:3204}."] = "",
}
