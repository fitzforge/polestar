-- Portuguese (Brazil) (ptBR): the guide forever/class/warrior/heirloom-weapon (forever/class/warrior/heirloom-weapon.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:71} Defensive Stance
	["{spell:71} and a Weapon (Horde)"] = "",
	-- {spell:71} Defensive Stance · {npc:5810} Uzzek
	["{spell:71} at 10 and a one-hand weapon of your choice: {npc:5810}'s road, Brill's crypt, or the Skybreaker shield."] = "",

	-- Step 1: Seena Skybreaker in Valanaar
	-- {npc:252377} Seena Skybreaker
	["{npc:252377} in Valanaar"] = "",
	-- {npc:252377} Seena Skybreaker · {npc:257196} Zaal Stormshield
	["At 10, {npc:252377} stands with the trainers by Valanaar's west gate. A cultist, {npc:257196}, holds her family's shield at the Shrine of Akir."] = "",

	-- Step 2: Zaal Stormshield
	-- {npc:257196} Zaal Stormshield · {item:263993} Skybreaker Bulwark
	["Head north-west from Valanaar to the Shrine of Akir. {npc:257196} stands west of the shrine's approach, among the cult's Guardians, Spiritcallers and Blademasters: pull them one at a time before you take him. He drops the {item:263993}."] = "",
	-- {item:263993} Skybreaker Bulwark · {npc:257196} Zaal Stormshield
	["{item:263993}, from {npc:257196}"] = "",

	-- Step 3: The Skybreaker Bulwark
	-- {npc:252377} Seena Skybreaker · {spell:71} Defensive Stance · {item:275290} Stormforged Protector · {npc:5810} Uzzek
	["Back to {npc:252377} in Valanaar. She teaches {spell:71} and gives you the {item:275290}, a shield to use it with. {npc:5810}'s road below still gives a weapon later, once you reach Kalimdor."] = "",

	-- Step 4: Veteran Uzzek (Razor Hill)
	-- {npc:3169} Tarshaw Jaggedscar · {object:3224} Razor Hill (no name in this language: may be words) · {npc:5810} Uzzek · {zone:1413} Barrens · {zone:1454} Orgrimmar · {object:172958} Valley of Honor (no name in this language: may be words) · {zone:1420} Tirisfal Glades · {npc:2131} Austil de Mon
	["At 10, {npc:3169}, the warrior trainer in the barracks of {object:3224}, sends you to {npc:5810} in the {zone:1413}. Sorek in {zone:1454}'s {object:172958} offers it too. Any Horde warrior may take one of the two roads, never both: heading to {zone:1420} at 10 anyway? {npc:2131} in Brill's inn offers the other: one fight by Brill's graveyard for the same stance, then the Agamand crypt for an heirloom weapon."] = "",

	-- Step 5: Veteran Uzzek (Mulgore)
	-- {npc:3063} Krang Stonehoof · {object:2968} Bloodhoof Village (no name in this language: may be words) · {npc:5810} Uzzek · {zone:1413} Barrens · {npc:3041} Torm Ragetotem · {zone:1456} Thunder Bluff
	["At 10, {npc:3063}, the warrior trainer of {object:2968}, sends you to {npc:5810} in the {zone:1413}. {npc:3041} in {zone:1456} offers it too."] = "",

	-- Step 6: Uzzek at Far Watch Post
	-- {npc:5810} Uzzek
	["{npc:5810} at Far Watch Post"] = "",
	-- {npc:5810} Uzzek · {zone:1411} Durotar · {zone:1412} Mulgore
	["{npc:5810} is easy to miss: he stands under a small canopy by a large tree just west of Far Watch Post, below the road's south side, with the post in sight to his east. Going straight south from the post does not lead to him. From {zone:1411} cross the bridge west; from {zone:1412} head north past the Crossroads."] = "",

	-- Step 7: Singed Scales in Thunder Ridge
	-- plural, as words: Singed Scales = {item:6486} Singed Scale
	["Singed Scales in Thunder Ridge"] = "",
	-- {zone:1411} Durotar · {zone:1454} Orgrimmar · {zone:1413} Barrens
	-- plural, as words: Singed Scales = {item:6486} Singed Scale · Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["You need five Singed Scales. Thunder Lizards (level 9-10) and Lightning Hides (10-11) live down in the Thunder Ridge crevasse in north-west {zone:1411}, south of {zone:1454}: from the {zone:1413} bridge turn left and follow the river north into it. Both drop a scale about four kills in five; both cast Lizard Bolt."] = "",
	-- {item:6486} Singed Scale
	["{item:6486}, from the lizards"] = "",

	-- Step 8: Path of Defense
	-- {npc:5810} Uzzek
	["Back to {npc:5810} under his tree west of Far Watch Post."] = "",

	-- Step 9: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze
	["{npc:5878}'s hut sits on top of Thorn Hill, east of the Crossroads. Most slopes are too steep: climb the broad ridge on the north or east side."] = "",

	-- Step 10: Forged Steel
	-- {object:58369} Stolen Iron Chest · {npc:5878} Thun'grim Firegaze
	["The {object:58369} stands by a broken wagon in the Razormane camp north-west of {npc:5878}, north-east of the Crossroads. Two Razormanes guard it and their hunters pull more quilboar: clear them one at a time, then open the chest (it refills within seconds, so a friend can loot it too)."] = "",
	-- {item:6534} Forged Steel Bars · {object:58369} Stolen Iron Chest
	["{item:6534}, from the {object:58369}"] = "",

	-- Step 11: Speak with Dillinger
	-- {npc:2131} Austil de Mon · {npc:1496} Deathguard Dillinger · {npc:5810} Uzzek · {quest:1505} Veteran Uzzek · {quest:1498} Path of Defense
	["At 10, {npc:2131}, the warrior trainer inside the inn of Brill, sends you to {npc:1496} by the graveyard on Brill's west edge. This road and {npc:5810}'s exclude each other: drop {quest:1505} or {quest:1498} from your log if you hold one."] = "",

	-- Step 12: Deathguard Dillinger
	-- {quest:1818} Speak with Dillinger · {npc:2131} Austil de Mon · {npc:5810} Uzzek
	["Dillinger stands by the graveyard on Brill's west edge. An Orc, Troll, Tauren or Skyborne who took {quest:1818} from {npc:2131} instead of {npc:5810}'s road is led through Brill from here."] = "",

	-- Step 13: Ulag the Cleaver
	-- {npc:6390} Ulag the Cleaver
	["{npc:6390} sleeps in the mausoleum in the graveyard just north of Dillinger. To wake him, click the flat skull plaque on the ground, left of the path to the mausoleum door; the seal lifts and {npc:6390} (level 11, not elite) walks out. Start at full health."] = "",

	-- Step 14: Coleman Farthing
	-- {npc:1500} Coleman Farthing
	["{npc:1500} is in the Gallows' End Tavern, the inn on Brill's east side."] = "",

	-- Step 15: The Agamand Family Crypt
	["The Agamand Family Crypt"] = "",
	-- {object:1631} Agamand Mills (no name in this language: may be words)
	-- plural, as words: Agamand Weapon Racks = {object:105169} Agamand Weapon Rack
	["The four Agamand Weapon Racks are inside the Agamand Family Crypt at the north end of {object:1631}, north of Brill, one rack per room: one in the lowest room, two in the pair of rooms up the stairs, one in the room above those. The axe rack stands in a dark corner. The crypt's undead come in packs of three or more and return quickly; the ones in the top room are not linked. The axe, dagger and mace racks take 15 minutes to refill after someone loots them."] = "",

	-- Step 16: Back to Coleman Farthing
	-- {npc:1500} Coleman Farthing
	["Back to {npc:1500}"] = "De volta a {npc:1500}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The four Agamand Weapon Racks stand among the buildings of {area:157}, north of {area:159}. The mills' undead attack on sight."] = "Os quatro Cavaletes de Armas dos Agamand ficam entre os prédios de {area:157}, ao norte de {area:159}. Os mortos-vivos dos moinhos atacam assim que veem você.",
	-- ["{npc:1496} stands in {area:159}. {npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "{npc:1496} fica em {area:159}. {npc:6390} espera no mausoléu na colina logo ao norte da cidade: abra o portão e enfrente-o.",
	-- ["{npc:1500} is in the inn, the {area:2119}, in {area:159}."] = "{npc:1500} está na estalagem, a {area:2119}, em {area:159}.",
	-- ["{spell:71} and a one-hand weapon of your choice at 10."] = "{spell:71} e uma arma de uma mão à sua escolha no nível 10.",
}
