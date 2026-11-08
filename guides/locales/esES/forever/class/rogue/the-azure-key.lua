-- Spanish (Spain) (esES): the guide forever/class/rogue/the-azure-key (forever/class/rogue/the-azure-key.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ravenholdt reputation and experience at 50; Classic's item choice may be gone on Forever."] = "",
	["Ravenholdt reputation"] = "Reputación con Ravenholdt",

	-- Step 1: A Simple Request (Alliance)
	-- {quest:8233} A Simple Request
	["{quest:8233} (Alliance)"] = "{quest:8233} (Alianza)",
	-- {npc:918} Osborne the Night Man · {zone:1453} Stormwind · {object:2100} Old Town · {zone:1457} Darnassus · {npc:5165} Hulfdan Blackbeard · {zone:1455} Ironforge
	["At 50 {npc:918} in {zone:1453}'s {object:2100} has it; so do Syurna in {zone:1457} and {npc:5165} in {zone:1455}."] = "",

	-- Step 2: A Simple Request (Horde)
	-- {quest:8233} A Simple Request
	["{quest:8233} (Horde)"] = "{quest:8233} (Horda)",
	-- {npc:3328} Ormok · {object:172960} Cleft of Shadow · {npc:4583} Miles Dexter · {zone:1458} Undercity · {object:36073} Rogues' Quarter
	["At 50 {npc:3328} in the {object:172960} has it; so does {npc:4583} in the {zone:1458}'s {object:36073}."] = "A nivel 50, la tiene {npc:3328} en {object:172960}; también {npc:4583} en {object:36073} de {zone:1458}.",

	-- Step 3: Lord Jorach Ravenholdt
	-- {object:1772} Tarren Mill (no name in this language: may be words) · {object:1776} Durnholde Keep (no name in this language: may be words) · {zone:1416} Alterac Mountains
	["Ravenholdt Manor hides in the hills east of {object:1772}. Horde fly to {object:1772}, Alliance to Southshore. The trail starts behind the plateau north of {object:1776}, climbs into the hills and runs through a small tunnel into the {zone:1416}; Lord Jorach is inside the manor. Do not attack anyone at the manor: lost Ravenholdt reputation makes him refuse to speak to you."] = "",

	-- Step 4: Sealed Azure Bag
	-- {zone:1447} Azshara
	-- plural, as words: Timbermaw Shamans = {npc:6188} Timbermaw Shaman
	["Alliance fly to Talrendis Point, Horde to Valormok. Only the level 50-51 Timbermaw Shamans in the furbolg hills of northern {zone:1447} carry the bag (the level 47-49 furbolgs further south do not): about one kill in thirty drops it. Pick Pocket them instead and you lose no Timbermaw reputation; if you are Unfriendly or better with Timbermaw Hold, mark them At War in your reputation panel first. They cast Lightning Bolt and Lightning Cloud, heal each other and run at low health."] = "",

	-- Step 5: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo
	["{npc:8395}, camped below the cliffs just east of Valormok, teleports you up (dismount first); a trail leads to Xylem's tower."] = "",

	-- Step 6: Encoded Fragments
	-- {zone:1447} Azshara
	-- plural, as words: Forest Oozes = {npc:8766} Forest Ooze · Mistwing Ravagers = {npc:8764} Mistwing Ravager
	["The Forest Oozes (level 52-53, Diseased Slime up close) drop a fragment four times in five: the biggest group, seven of them, is in the Bitter Reaches hills of north-eastern {zone:1447}, four more south-east of Valormok. Pick their pockets before the kill for an extra fragment or two. Killing the Mistwing Ravagers and hippogryphs that share their spots makes more oozes appear."] = "",

	-- Step 7: Back to Xylem
	["Back to Xylem"] = "De vuelta con Xylem",

	-- Step 8: Morphaz in the Sunken Temple
	["Morphaz in the Sunken Temple"] = "",
	-- {npc:5710} Jammal'an the Prophet
	["Morphaz, a level 52 elite green drake, lives deep in the Sunken Temple: a group of five, level 50-54. The temple stands in the Pool of Tears; climb into the sunken building, swim down through it and follow the passage to the portal. Horde: fly to Stonard; Alliance: fly to Nethergarde Keep and ride on. He is not there when you arrive: first kill the six troll guardians (elites of 50-52) on the platforms around the upper ring, which opens the way down (the left-hand ramp from the entrance) to {npc:5710} in the Pit of Sacrifice. Jammal'an's death brings out two drakes, Weaver and Dreamscythe; when both are dead, Morphaz and Hazzas appear together and fight as a pair. Their Acid Breath is nature damage: nature protection potions help; poisons and Blind do not work on them. The key always drops. Hunters, Priests and Mages of 50 need Morphaz too: one clear serves them all."] = "",
	-- {item:20022} Azure Key
	["{item:20022}: Morphaz, inside the temple"] = "{item:20022}: Morphaz, dentro del templo",

	-- Step 9: Lord Ravenholdt
	["Lord Ravenholdt"] = "Lord Ravenholdt",
	-- {item:19982} Duskbat Drape · {item:19984} Ebon Mask · {item:20255} Whisperwalk Boots
	["Look at the reward window before you hand in: Classic offered the {item:19982}, the {item:19984} or the {item:20255}, and Forever's notes say the choice may be gone."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Alliance fly to {area:3137}, Horde to {area:1237}. The Timbermaw Shamans in {zone:1447}'s northern hills drop the bag, about one in thirty."] = "La Alianza vuela a {area:3137}; la Horda, a {area:1237}. Los chamanes Fauces de Madera de las colinas del norte de {zone:1447} sueltan la bolsa, más o menos uno de cada treinta.",
	-- ["At 50 {npc:918} in {zone:1453}'s {object:2100} has it; so do Syurna in {zone:1457} and {npc:5165} and Fenthwick in {zone:1455}."] = "A nivel 50, la tiene {npc:918} en {object:2100} de {zone:1453}; también Syurna en {zone:1457}, y {npc:5165} y Fenthwick en {zone:1455}.",
	-- ["Morphaz in the {area:1417}"] = "Morphaz en el {area:1417}",
	-- ["Morphaz, a green drake, is an elite boss deep in the {area:1417}, a level 50 dungeon: bring a group of five. The temple stands in the {area:74}; swim down to the entrance. Horde: fly to {area:75}; Alliance: fly to {area:1438} and ride on."] = "Morphaz, un draco verde, es un jefe de élite en lo más hondo del {area:1417}, una mazmorra de nivel 50: lleva un grupo de cinco. El templo está en {area:74}; bucea hasta la entrada. Horda: vuela a {area:75}. Alianza: vuela a {area:1438} y sigue cabalgando.",
	-- ["Ravenholdt reputation and experience at 50; Forever removed the Classic item choice."] = "Reputación con Ravenholdt y experiencia a nivel 50; Forever eliminó la elección de objeto de Classic.",
	-- ["The Forest Oozes of southern {zone:1447} drop the fragments."] = "Los mocos del bosque del sur de {zone:1447} sueltan los fragmentos.",
	-- ["{area:3486} hides in the hills east of {area:272}, up a path into the {zone:1416}. Horde fly to {area:272}, Alliance to {area:271}."] = "La {area:3486} se oculta en las colinas al este de {area:272}, subiendo por un sendero hacia {zone:1416}. La Horda vuela a {area:272}; la Alianza, a {area:271}.",
	-- ["{npc:6768}: no item choices in Forever"] = "{npc:6768}: sin elección de objeto en Forever",
}
