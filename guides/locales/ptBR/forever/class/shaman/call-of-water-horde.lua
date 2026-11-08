-- Portuguese (Brazil) (ptBR): the guide forever/class/shaman/call-of-water-horde (forever/class/shaman/call-of-water-horde.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:63} Call of Water
	["{quest:63} (Horde)"] = "{quest:63} (Horda)",
	-- {item:5177} Water Totem · {spell:5394} Healing Stream Totem
	["The {item:5177} that lets you place water totems, and {spell:5394} with it."] = "O {item:5177}, que permite colocar totens de água, e com ele {spell:5394}.",

	-- Step 1: Searn Firewarder
	-- {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom (no name in this language: may be words) · {npc:5901} Islen Waterseer · {zone:1413} Barrens · {object:3224} Razor Hill (no name in this language: may be words)
	["At 20 {npc:5892} in the {object:172957} sends you to {npc:5901} in the {zone:1413}. (Swart in {object:3224} gives the same letter: carry either.)"] = "",

	-- Step 2: Xanis Flameweaver
	-- {npc:5906} Xanis Flameweaver · {object:50495} Spirit Rise (no name in this language: may be words) · {zone:1456} Thunder Bluff · {npc:5901} Islen Waterseer · {zone:1413} Barrens · {npc:3066} Narm Skychaser · {object:2968} Bloodhoof Village (no name in this language: may be words)
	["At 20 {npc:5906}, a shaman trainer on {object:50495} in {zone:1456}, sends you to {npc:5901} in the {zone:1413}. ({npc:3066} in {object:2968} gives the same letter: carry either.)"] = "",

	-- Step 3: Islen Waterseer
	-- {npc:5901} Islen Waterseer
	["{npc:5901} is not in Ratchet: take the small coast road south from Ratchet past the pirate camp and over a low hill; her fishing hut, with a shark strung up outside, stands by the water before the pirate ship. If you reach the ship you went too far."] = "",

	-- Step 4
	-- {npc:5901} Islen Waterseer · {npc:5892} Searn Firewarder
	["{npc:5901}: {npc:5892}'s letter"] = "",

	-- Step 5
	-- {npc:5901} Islen Waterseer · {npc:5906} Xanis Flameweaver
	["{npc:5901}: {npc:5906}' letter"] = "",

	-- Step 6
	-- {npc:5901} Islen Waterseer
	["{npc:5901}: Swart's letter"] = "",

	-- Step 7
	-- {npc:5901} Islen Waterseer
	["{npc:5901}: Narm's letter"] = "",

	-- Step 9: Brine
	-- {npc:5899} Brine · {zone:1413} Barrens
	["{npc:5899} lives in the southern {zone:1413}, south of Camp Taurajo: her hut sits on a hilltop of Blackthorn Ridge with a spinning windmill beside it, and the way up is the ridge by the lone tree. Quilboar camp all around the hill; Stormhides, thunderhawks and hyenas roam the plains on the way."] = "",

	-- Step 10: The Quilboar Watering Hole
	-- {object:107046} Quilboar Watering Hole (no name in this language: may be words)
	["The {object:107046}"] = "",
	-- {npc:5899} Brine · {item:7766} Empty Brown Waterskin · {npc:3456} Razormane Pathfinder
	["The muddy pond below {npc:5899}'s hut. Step right into the puddle before you use the {item:7766} (too far away and it refuses). Filling it calls a hostile {npc:3456} (level 20): kill it, and watch for the quilboar hunter by the pond, who may start shooting afterwards."] = "",
	-- {item:7766} Empty Brown Waterskin
	["{item:7766}, standing in the puddle"] = "",

	-- Step 12: The Spring Well
	-- {object:107045} Spring Well (no name in this language: may be words)
	["The {object:107045}"] = "{object:107045}",
	-- {object:107045} Spring Well (no name in this language: may be words) · {object:1772} Tarren Mill (no name in this language: may be words) · {zone:1413} Barrens · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1458} Undercity · {zone:1421} Silverpine Forest · {item:7768} Empty Red Waterskin
	["The {object:107045} stands in the middle of {object:1772}, just outside the church. From the {zone:1413}: the zeppelin from {zone:1454} to {zone:1420}, then south past the {zone:1458} and through {zone:1421} (or fly once you have the {object:1772} flight path). Hillsbrad is contested: Alliance players may attack. Stand beside the well and use the {item:7768}."] = "",
	-- {item:7768} Empty Red Waterskin
	["{item:7768}, beside the well"] = "",

	-- Step 14: The Ruins of Stardust
	["The Ruins of Stardust"] = "",
	-- {zone:1413} Barrens · {npc:12836} Wandering Protector · {zone:1440} Ashenvale · {item:7767} Empty Blue Waterskin
	["The right fountain stands in a ring of standing stones on the island of the small green lake south of Astranaar, west of Lake Mystral (not the island in Lake Mystral itself). From the {zone:1413} take the road north through the Mor'shan Rampart and on west. Water elementals and walking treants guard the lake and root you in place; an elite {npc:12836} roams {zone:1440} and can pass close by. Use the {item:7767} beside the fountain."] = "",
	-- {item:7767} Empty Blue Waterskin
	["{item:7767}, beside the fountain"] = "",

	-- Step 15: Brine
	-- {npc:5899} Brine · {item:7810} Vial of Purest Water · {npc:5901} Islen Waterseer
	["Back to {npc:5899}. She gives you the {item:7810} for {npc:5901}."] = "",
	-- {item:7810} Vial of Purest Water · {npc:5901} Islen Waterseer
	["the {item:7810}, for {npc:5901}"] = "a {item:7810}, para {npc:5901}",

	-- Step 16: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {item:6637} Water Sapta · {item:7811} Remaining Drops of Purest Water
	["{npc:5901} hands you the {item:6637} and the {item:7811}: take everything she offers before you leave for Silverpine, or you will be back for more."] = "",
	-- {npc:5901} Islen Waterseer · {item:6637} Water Sapta
	["{npc:5901}: your {item:6637}"] = "{npc:5901}: sua {item:6637}",

	-- Step 17: Lost the Water Sapta?
	-- {quest:972} Water Sapta
	["Lost the {quest:972}?"] = "",
	-- {quest:972} Water Sapta · {npc:5901} Islen Waterseer
	["Only if the {quest:972} is gone from your bags: {npc:5901} gives you another."] = "",
	-- {npc:5901} Islen Waterseer · {quest:972} Water Sapta
	["{npc:5901}: a new {quest:972}"] = "",

	-- Step 18: The Brazier of Everfount
	-- {object:113791} Brazier of Everfount
	["The {object:113791}"] = "{object:113791}",
	-- {item:6637} Water Sapta · {npc:5894} Corrupt Minor Manifestation of Water
	["Fly to the Sepulcher. The shrine lies in a hollow just south-west of it: go round the back of the crypt to the thick tree between the two hills, hop past it onto the rocks and drop west down the slope to the pool (each drop costs a little health). Drink the {item:6637} beside the tall standing stone by the pool: several water elementals appear, and only the corrupt one near the middle can be attacked (Tab picks it). The {npc:5894} is level 22 and casts Frost Shock and Frost Nova; if someone just killed it, it is back in about three minutes. Its bracers always drop."] = "",
	-- {item:6637} Water Sapta
	["{item:6637}, beside the standing stone"] = "",

	-- Step 19: The Minor Manifestation of Water
	-- {npc:5895} Minor Manifestation of Water
	["The {npc:5895}"] = "",
	-- {object:113791} Brazier of Everfount · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water · {npc:5901} Islen Waterseer · {quest:63} Call of Water · {quest:972} Water Sapta · {npc:7007} Tiev Mordune
	["Click the {object:113791} to place the bracers and the drops. A few seconds later the pure {npc:5895} rises on the stone in the middle of the pool: speak to it while the Sapta Sight lasts (drink again by the stone if it has worn off). It gives you the {item:7813} for {npc:5901}. Gone before you could speak to it? Back at {npc:5901} ask for {quest:63} (a fresh {quest:972} for {npc:7007}, who stands just west of the shrine): hand it to Tiev, stay close while he calls the spirit back, then speak to it."] = "",

	-- Step 20: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {item:5177} Water Totem
	["Back to {npc:5901} south of Ratchet. Keep the {item:5177} in your bags for good: every water totem needs it."] = "",
	-- {npc:5901} Islen Waterseer · {spell:5394} Healing Stream Totem · {item:5177} Water Totem
	["{npc:5901}: {spell:5394} and your {item:5177}"] = "{npc:5901}: {spell:5394} e seu {item:5177}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 20 {npc:5892} in the {object:172957} sends you to {npc:5901} in the {zone:1413}."] = "No nível 20, {npc:5892}, no {object:172957}, envia você a {npc:5901} nos {zone:1413}.",
	-- ["At 20 {npc:5906}, a shaman trainer in {zone:1456}, sends you to {npc:5901} in the {zone:1413}."] = "No nível 20, {npc:5906}, instrutor de xamãs em {zone:1456}, envia você a {npc:5901} nos {zone:1413}.",
	-- ["Fill the {item:7766} at the quilboar watering hole"] = "Encha o {item:7766} no bebedouro dos javaligs",
	-- ["Fill the {item:7767} at the fountain"] = "Encha o {item:7767} na fonte",
	-- ["Fill the {item:7768} at the {object:107045}"] = "Encha o {item:7768} em {object:107045}",
	-- ["Fly to the {area:228}: the {object:113791} stands on the hill just south-west of it. Drink the {item:6637} there, beat the {npc:5894} for its bracers and place them in the brazier, then speak to the {npc:5895} and keep the {item:7813} for {npc:5901}."] = "Voe até {area:228}: o {object:113791} fica na colina logo a sudoeste. Beba a {item:6637} lá, derrote a {npc:5894} para pegar as braçadeiras e coloque-as no braseiro; depois fale com a {npc:5895} e guarde o {item:7813} para {npc:5901}.",
	-- ["Take the zeppelin from {zone:1454} to {zone:1420} and travel south to {area:272}. The {object:107045} stands beside the inn."] = "Pegue o zepelim de {zone:1454} para {zone:1420} e viaje para o sul até {area:272}. {object:107045} fica ao lado da estalagem.",
	-- ["The fountain stands in the middle of the {area:418}, in south-western {zone:1440}."] = "A fonte fica no meio das {area:418}, no sudoeste de {zone:1440}.",
	-- ["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}."] = "A cabana de {npc:5899} fica na crista acima do bebedouro dos javaligs, ao sul do {area:378}.",
	-- ["{npc:5901} waits on the hill south of {area:392}."] = "{npc:5901} espera na colina ao sul de {area:392}.",
}
