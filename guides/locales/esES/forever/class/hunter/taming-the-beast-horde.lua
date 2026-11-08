-- Spanish (Spain) (esES): the guide forever/class/hunter/taming-the-beast-horde (forever/class/hunter/taming-the-beast-horde.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:6061} Taming the Beast
	["{quest:6061} (Horde)"] = "",
	-- {item:15908} Taming Rod · {spell:1515} Tame Beast · {spell:5149} Beast Training
	["Your own pet at 10: three practice tames with a {item:15908} teach {spell:1515}, then {spell:5149}."] = "",

	-- Step 1: Thotar in Razor Hill
	-- {npc:3171} Thotar · {object:3224} Razor Hill (no name in this language: may be words)
	["{npc:3171} in {object:3224}"] = "",
	-- {npc:3171} Thotar · {object:3224} Razor Hill (no name in this language: may be words) · {npc:3407} Sian'dur · {zone:1454} Orgrimmar · {npc:11814} Kali Remik · {object:3276} Sen'jin Village (no name in this language: may be words) · {npc:3038} Kary Thunderhorn · {zone:1456} Thunder Bluff
	["At 10 go to {npc:3171}, the hunter trainer inside the barracks in {object:3224}. If {npc:3407} in {zone:1454}, {npc:11814} in {object:3276} or {npc:3038} in {zone:1456} hands you The Hunter's Path, take it and hand it to {npc:3171} for a little experience; it is only a pointer, and you can take the first rod without it."] = "",
	-- {npc:3171} Thotar · {item:15908} Taming Rod
	["{npc:3171}: the first {item:15908}"] = "",

	-- Step 2: Dire Mottled Boar
	-- {object:3224} Razor Hill (no name in this language: may be words) · {item:15908} Taming Rod · {npc:3171} Thotar
	-- plural, as words: Dire Mottled Boars = {npc:3099} Dire Mottled Boar
	["Dire Mottled Boars (level 6-7) roam just north and west of {object:3224}. How the rod works: target a living beast, use the {item:15908} from inside its range and stand still for the whole channel while the beast hits you. Moving, fighting back, a heal from someone else or anyone else hitting the beast breaks it and costs one of the rod's few charges; if they run out, destroy the rod, abandon the quest and take it again from {npc:3171}. The boars charge from 20 yards, so start with the rod, not Auto Shot. The tamed boar becomes your pet for practice. Keep each rod: it goes back to {npc:3171}."] = "",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living boar"] = "",
	-- {npc:3099} Dire Mottled Boar
	["Tame {npc:3099}"] = "",

	-- Step 3: Surf Crawler
	-- {object:3276} Sen'jin Village (no name in this language: may be words)
	-- plural, as words: Surf Crawlers = {npc:3107} Surf Crawler · Pygmy Surf Crawlers = {npc:3106} Pygmy Surf Crawler
	["First dismiss the boar (right-click your pet's portrait, Dismiss Pet): a released practice pet can turn on you. Surf Crawlers (level 7-8) walk the beaches around {object:3276} and the Echo Isles; the small Pygmy Surf Crawlers do not count. A crawler runs for help at 15% health, so do not hurt it."] = "",
	-- {item:15908} Taming Rod · {npc:3107} Surf Crawler
	["Use the {item:15908} on a living {npc:3107}"] = "",
	-- {npc:3107} Surf Crawler
	["Tame {npc:3107}"] = "",

	-- Step 4: Armored Scorpid
	-- {object:3224} Razor Hill (no name in this language: may be words)
	-- plural, as words: Armored Scorpids = {npc:3126} Armored Scorpid
	["Dismiss the crawler. Armored Scorpids (level 7-8) crawl the dry plains west and south-west of {object:3224}, some just south of the road west out of town; Track Beasts shows them. Their hits can break the channel: start at full health and keep still."] = "",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living scorpid"] = "",
	-- {npc:3126} Armored Scorpid
	["Tame {npc:3126}"] = "",

	-- Step 5: Ormak Grimshot in Orgrimmar
	-- {npc:3352} Ormak Grimshot · {zone:1454} Orgrimmar
	["{npc:3352} in {zone:1454}"] = "",
	-- {zone:1454} Orgrimmar · {npc:3352} Ormak Grimshot · {object:172958} Valley of Honor · {npc:10088} Xao'tsu
	["Follow the road north to {zone:1454}'s gate. {npc:3352} stands with the hunter trainers in the {object:172958}, up the ramp at the city's east side; {npc:10088}, the pet trainer, is a few steps north of him."] = "",

	-- Step 6: Yaw Sharpmane at Bloodhoof
	-- {npc:3065} Yaw Sharpmane
	["{npc:3065} at Bloodhoof"] = "",
	-- {npc:3065} Yaw Sharpmane · {object:2968} Bloodhoof Village (no name in this language: may be words) · {npc:3038} Kary Thunderhorn · {zone:1456} Thunder Bluff · {npc:3407} Sian'dur · {zone:1454} Orgrimmar · {npc:3171} Thotar · {object:3224} Razor Hill (no name in this language: may be words)
	["At 10 go to {npc:3065}, who stands at the north edge of {object:2968}. The Hunter's Path from {npc:3038} in {zone:1456}, {npc:3407} in {zone:1454} or {npc:3171} in {object:3224} also leads here, for a little experience; it is only a pointer."] = "",
	-- {npc:3065} Yaw Sharpmane · {item:15908} Taming Rod
	["{npc:3065}: the first {item:15908}"] = "",

	-- Step 7: Adult Plainstrider
	-- {object:2968} Bloodhoof Village (no name in this language: may be words) · {item:15908} Taming Rod
	-- plural, as words: Adult Plainstriders = {npc:2956} Adult Plainstrider
	["Adult Plainstriders (level 6-7) walk the plains south-west and north-west of {object:2968}. How the rod works: target a living beast, use the {item:15908} and stand still for the whole channel while it hits you; moving, fighting back or anyone else's help breaks it and costs one of the rod's few charges (out of charges: destroy the rod, abandon the quest, take it again). A plainstrider flees at 25% health, so do not damage it first. Keep each rod: it goes back to Yaw."] = "",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living plainstrider"] = "",
	-- {npc:2956} Adult Plainstrider
	["Tame {npc:2956}"] = "",

	-- Step 8: Prairie Stalker
	-- {object:2968} Bloodhoof Village (no name in this language: may be words)
	-- plural, as words: Prairie Stalkers = {npc:2959} Prairie Stalker
	["Dismiss the plainstrider first (right-click the pet portrait, Dismiss Pet): a released practice pet may attack you. Prairie Stalkers (level 7-8) roam the grass north of {object:2968}."] = "",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living stalker"] = "",
	-- {npc:2959} Prairie Stalker
	["Tame {npc:2959}"] = "",

	-- Step 9: Swoop
	-- {npc:2970} Swoop
	-- plural, as words: Swoops = {npc:2970} Swoop · Taloned Swoops = {npc:2971} Taloned Swoop
	["Dismiss the stalker. Swoops (level 7-9) glide over the plains north-west and north-east of Bloodhoof; the Taloned Swoops do not count. A {npc:2970}'s knockdown breaks the channel, but it lands only once per channel: start the rod just after it has used it."] = "",
	-- {item:15908} Taming Rod · {npc:2970} Swoop
	["Use the {item:15908} on a living {npc:2970}"] = "",
	-- {npc:2970} Swoop
	["Tame {npc:2970}"] = "",

	-- Step 10: Holt Thunderhorn in Thunder Bluff
	-- {npc:3039} Holt Thunderhorn · {zone:1456} Thunder Bluff
	["{npc:3039} in {zone:1456}"] = "",
	-- {zone:1456} Thunder Bluff · {npc:3039} Holt Thunderhorn · {object:50494} Hunter Rise (no name in this language: may be words) · {npc:10086} Hesuwa Thunderhorn
	["Head north to {zone:1456} and take a lift up. {npc:3039} stands with the hunter trainers on {object:50494}; {npc:10086}, the pet trainer, is nearby."] = "",

	-- Step 11: Elayaa Easewind
	-- {npc:254084} Elayaa Easewind · {zone:2521} Zephras Isle · {quest:94007} Taming the Beast
	["At 10, {npc:254084}, a hunter trainer on {zone:2521}, may send you on to Valanaar with {quest:94007}. It is only a pointer: skip it if you are already in Valanaar."] = "",

	-- Step 12: Quel'ana Quickgale in Valanaar
	-- {npc:252389} Quel'ana Quickgale
	["{npc:252389} in Valanaar"] = "",
	-- {npc:252389} Quel'ana Quickgale · {npc:254411} Quel'dora Quickgale
	["{npc:252389} stands with the trainers by Valanaar's west gate, {npc:254411} beside her."] = "",
	-- {npc:252389} Quel'ana Quickgale · {item:15908} Taming Rod
	["{npc:252389}: the first {item:15908}"] = "",

	-- Step 13: Windsong Crawler
	-- {item:15908} Taming Rod
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Windsong Crawlers live only by water: the nearest scuttle along the shore south-west of Valanaar, among the crabs. How the rod works: target a living crawler, use the {item:15908} and stand still for the whole channel while it hits you; moving, fighting back or anyone else's help breaks it and costs a charge. Killing one does not count."] = "",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living crawler"] = "",
	-- {npc:254588} Windsong Crawler
	["Tame {npc:254588}"] = "",

	-- Step 14: Ornery Galestrider
	-- plural, as words: Ornery Galestriders = {npc:251707} Ornery Galestrider
	["Dismiss the crawler first (right-click the pet portrait, Dismiss Pet). Ornery Galestriders graze in the Gustberry Lowlands, the fields a short walk west and south-west of Valanaar."] = "",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living galestrider"] = "",
	-- {npc:251707} Ornery Galestrider
	["Tame {npc:251707}"] = "",

	-- Step 15: Vuldren Alpha
	-- plural, as words: Vuldren Alphas = {npc:250874} Vuldren Alpha
	["Dismiss the galestrider. Vuldren Alphas hunt in the same Gustberry Lowlands, a little further south."] = "",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living alpha"] = "",
	-- {npc:250874} Vuldren Alpha
	["Tame {npc:250874}"] = "",
	-- {npc:254411} Quel'dora Quickgale · {spell:5149} Beast Training
	["{npc:254411}, beside her: {spell:5149}"] = "",

	-- Step 16: Your first pet
	["Your first pet"] = "",
	-- {spell:1515} Tame Beast
	["{spell:1515} works like the rod: a beast of your level or lower, a channel you must not move during, the beast hitting you all the while. A pet keeps the level you tame it at and levels up with you; it can never be above your level, so tame one close to yours. Each family has its own ability on Forever (a boar's Charge, for example). For levelling, a cat hits hardest (Claw and Bite) and a boar takes more punishment."] = "",
	["Tame a beast of your level to keep"] = "",
	-- {object:3224} Razor Hill (no name in this language: may be words) · {zone:1411} Durotar · {object:3276} Sen'jin Village (no name in this language: may be words) · {zone:1454} Orgrimmar · {zone:1413} Barrens
	-- plural, as words: Durotar Tigers = {npc:3121} Durotar Tiger · Venomtail Scorpids = {npc:3127} Venomtail Scorpid
	["Near {object:3224}: Durotar Tigers (cats, level 7-8) roam the south of {zone:1411}, from {object:3276} down the coast; Venomtail Scorpids (9-10) the north-west toward {zone:1454}; at 11-12, Savannah Huntresses (cats) prowl the plains around the Crossroads in the {zone:1413}."] = "",
	-- {zone:1412} Mulgore · {zone:1413} Barrens
	-- plural, as words: Flatland Prowlers = {npc:3566} Flatland Prowler · Prairie Wolf Alphas = {npc:2960} Prairie Wolf Alpha
	["Near Bloodhoof: Flatland Prowlers (cats, level 9) and Prairie Wolf Alphas (wolves, 9-10) roam the plains of northern {zone:1412}; at 11-12, Savannah Huntresses (cats) prowl around the Crossroads in the {zone:1413}."] = "",
	-- {zone:2521} Zephras Isle
	-- plural, as words: Vuldren Alphas = {npc:250874} Vuldren Alpha · Shriekling Matriarchs = {npc:253283} Shriekling Matriarch · Shadowgale Urseras = {npc:250927} Shadowgale Ursera
	["Near Valanaar: Vuldren Alphas (level 10), the beast of your last practice tame, hunt the Gustberry Lowlands; Shriekling Matriarchs (raptors, level 9) nest just west of Valanaar; Shadowgale Urseras (bears, 10-11) roam the north of {zone:2521}."] = "",
	-- {npc:6928} Innkeeper Grosk · {object:3224} Razor Hill (no name in this language: may be words) · {npc:3025} Kaga Mistrunner · {zone:1456} Thunder Bluff · {zone:2521} Zephras Isle
	["Feed Pet: open your spellbook, cast Feed Pet and click a food your pet's family eats (the pet's tooltip lists them: cats eat meat and fish, boars almost anything). Raw meat looted from beasts counts. To buy: Grimtak the butcher and {npc:6928} in {object:3224} sell meat, {npc:3025} in {zone:1456} and the innkeepers on {zone:2521} too; Bloodhoof's innkeeper and bakers sell bread. Food near the pet's level makes it happiest; much lower food gives about half. You cannot feed in combat."] = "",
	["Happiness: the face on the pet frame. An unhappy pet does three quarters of its damage, a happy one a quarter more. Happiness drains slowly, faster when the pet dies; a pet left unhappy too long can run away."] = "",
	-- {spell:5149} Beast Training
	["Loyalty grows with time and kills. Each loyalty rank raises the training points you spend in {spell:5149} (pet level times loyalty rank minus one)."] = "",
	-- {spell:5149} Beast Training · {npc:9987} Shoja'my · {object:3224} Razor Hill (no name in this language: may be words) · {npc:265756} Genn Fairweather · {zone:2521} Zephras Isle · {npc:9988} Xon'cha · {zone:1454} Orgrimmar
	["{spell:5149} (spellbook, General tab) teaches your current pet the abilities you know. To learn a new ability or rank: leave your pet with a stable master ({npc:9987} in {object:3224}, Seikwa at Bloodhoof, {npc:265756} on {zone:2521}, {npc:9988} in {zone:1454}), tame a beast that has it (its pet spellbook tab shows what it knows), use the ability in fights until the game says you learned it, then take your own pet back and teach it with {spell:5149}. A pet holds four active abilities at most."] = "",
	-- {object:3224} Razor Hill (no name in this language: may be words) · {npc:3688} Reban Freerunner · {npc:10088} Xao'tsu · {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {npc:10086} Hesuwa Thunderhorn · {zone:1456} Thunder Bluff · {object:50494} Hunter Rise (no name in this language: may be words) · {npc:254411} Quel'dora Quickgale · {object:3202} Grom'gol (no name in this language: may be words)
	["Pet trainers sell Growl ranks and resistances. Horde: Harruk in {object:3224}, {npc:3688} at Bloodhoof, {npc:10088} in {zone:1454}'s {object:172958}, {npc:10086} on {zone:1456}'s {object:50494}, {npc:254411} in Valanaar, later Grokor in Stonard and Zudd at {object:3202}."] = "",
	["Call Pet, Dismiss Pet and Revive Pet are in your spellbook now; Mend Pet comes from your trainer at 12. A dead pet needs Revive Pet; one that is away more than about 100 yards is dismissed and comes back with Call Pet."] = "",
}
