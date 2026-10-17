-- German (deDE): the guide forever/collectibles/mounts/alliance/paladin-charger (forever/collectibles/mounts/alliance/paladin-charger.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Paladin Charger"] = "Paladin-Streitross",
	["Your epic mount at 60, summoned at will: the faster step up from the Warhorse."] = "Dein episches Reittier mit 60, jederzeit beschworen: die schnellere Stufe nach dem Schlachtross.",

	-- Step 1: Lord Grayson Shadowbreaker (Ironforge)
	-- {npc:5149} Brandur Ironhammer · {object:32362} Mystic Ward (no name in this language: may be words) · {quest:7638} Lord Grayson Shadowbreaker · {zone:1453} Stormwind
	["At 60 {npc:5149} in the {object:32362} sends you to {quest:7638} in {zone:1453}'s Cathedral of Light."] = "Mit 60 schickt dich {npc:5149} ({object:32362}) zu {quest:7638} in der Kathedrale des Lichts in {zone:1453}.",

	-- Step 2: Lord Grayson Shadowbreaker
	-- {spell:23214} Summon Charger · {area:2279} Stratholme · {area:2577} Dire Maul · {area:2057} Scholomance
	["The {spell:23214} chain is long: it takes you through {area:2279}, {area:2577} and {area:2057}, and costs about 350 gold in donations on top of the materials. Lord Grayson stands in the Cathedral of Light."] = "Die Questreihe für {spell:23214} ist lang: Sie führt dich durch {area:2279}, {area:2577} und {area:2057} und kostet zusätzlich zu den Materialien etwa 350 Gold an Spenden. Lord Grayson steht in der Kathedrale des Lichts.",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}, Cathedral of Light"] = "{npc:6171}, Kathedrale des Lichts",

	-- Step 3: High Priest Rohan
	-- {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words)
	["{npc:11406} is in {zone:1455}'s {object:32362}. Bring 150 gold: the censer is yours for a donation."] = "{npc:11406} ist in {zone:1455} ({object:32362}). Bring 150 Gold mit: Das Räuchergefäß bekommst du gegen eine Spende.",
	-- {npc:11406} High Priest Rohan
	["{npc:11406}: 150 gold"] = "{npc:11406}: 150 Gold",

	-- Step 4: Back to Lord Grayson
	["Back to Lord Grayson"] = "Zurück zu Lord Grayson",

	-- Step 5: Exorcising Terrordale
	-- {area:2627} Terrordale · {zone:1423} Eastern Plaguelands · {zone:1422} Western Plaguelands · {item:18752} Exorcism Censer
	["{area:2627} lies in the far north-west of the {zone:1423}, by the {zone:1422} border. Use the {item:18752} there to drive out the spirits, then defeat them."] = "{area:2627} liegt ganz im Nordwesten von {zone:1423}, an der Grenze zu {zone:1422}. Benutze dort {item:18752}, um die Geister auszutreiben, und besiege sie dann.",
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit
	["Terrordale Spirits"] = "Schreckenstalgeister",

	-- Step 7: Grimand Elmore
	-- {npc:1416} Grimand Elmore · {zone:1453} Stormwind · {object:28027} Dwarven District
	["{npc:1416} works in {zone:1453}'s {object:28027}."] = "{npc:1416} arbeitet in {zone:1453} ({object:28027}).",

	-- Step 8: Grimand Elmore's materials
	-- {npc:1416} Grimand Elmore
	["{npc:1416}'s materials"] = "{npc:1416}s Materialien",
	-- {item:14047} Runecloth · {item:8836} Arthas' Tears · {zone:1448} Felwood · {skill:171} Alchemy · {zone:1453} Stormwind · {object:2096} Trade District
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["{item:14047} drops from humanoids around level 50 and up; {item:8836} is an herb of the Plaguelands and {zone:1448}; Arcanite Bars are an {skill:171} transmute. The Auction House in {zone:1453}'s {object:2096} sells all three, and so do crafters."] = "{item:14047} droppt bei Humanoiden ab etwa Stufe 50; {item:8836} ist ein Kraut der Pestländer und von {zone:1448}; Arkanitbarren sind eine Transmutation der {skill:171}. Das Auktionshaus in {zone:1453} ({object:2096}) verkauft alle drei, ebenso Handwerker.",
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["Arcanite Bars: the Auction House"] = "Arkanitbarren: Auktionshaus",

	-- Step 9: Stratholme Holy Water
	-- {area:2279} Stratholme · {zone:1423} Eastern Plaguelands · {item:13180} Stratholme Holy Water
	-- plural, as words: Supply Crates = {item:4629} Supply Crate
	["{area:2279} is a group of five, level 58-60, at the north end of the {zone:1423}. The Supply Crates scattered through the city hold the {item:13180}."] = "{area:2279} ist ein Dungeon für fünf Spieler, Stufe 58-60, am Nordende von {zone:1423}. Die in der Stadt verteilten Vorratskisten enthalten {item:13180}.",
	-- plural, as words: Supply Crates = {item:4629} Supply Crate
	["Supply Crates, inside"] = "Vorratskisten, drinnen",

	-- Step 10: Grimand Elmore
	-- {npc:1416} Grimand Elmore
	["Bring 150 gold for {npc:1416} along with the materials."] = "Bring für {npc:1416} 150 Gold zusammen mit den Materialien mit.",
	-- {npc:1416} Grimand Elmore
	["{npc:1416}: 150 gold"] = "{npc:1416}: 150 Gold",

	-- Step 11: Lord Grayson Shadowbreaker
	-- {npc:928} Lord Grayson Shadowbreaker · {item:18753} Arcanite Barding
	["{npc:928}: the {item:18753}"] = "{npc:928}: {item:18753}",

	-- Step 12: Enriched Manna Biscuits
	-- plural, as words: Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Enriched Manna Biscuits"] = "Angereicherte Manakekse",
	-- {object:2160} The Argent Dawn · {object:92525} Argent Dawn · {npc:10857} Argent Quartermaster Lightspark · {area:3197} Chillwind Camp · {npc:11536} Quartermaster Miranda Breechlock · {area:2268} Light's Hope Chapel · {npc:10856} Argent Quartermaster Hasana · {area:813} Bulwark
	["{object:2160} quartermasters sell the biscuits in fives once the {object:92525} is Friendly with you: {npc:10857} at {area:3197}, {npc:11536} at {area:2268}, {npc:10856} at the {area:813}."] = "Rüstmeister von {object:2160} verkaufen die Kekse im Fünferpack, sobald du bei {object:92525} Freundlich bist: {npc:10857} im {area:3197}, {npc:11536} in der {area:2268}, {npc:10856} im {area:813}.",
	-- {npc:10857} Argent Quartermaster Lightspark · {area:3197} Chillwind Camp
	-- plural, as words: Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Enriched Manna Biscuits: {npc:10857}, {area:3197}"] = "Angereicherte Manakekse: {npc:10857}, {area:3197}",

	-- Step 13: Merideth Carlson
	-- {npc:2357} Merideth Carlson · {area:271} Southshore
	["{npc:2357} breeds horses in {area:271}. She also wants 50 gold."] = "{npc:2357} züchtet Pferde in {area:271}. Sie will außerdem 50 Gold.",

	-- Step 14: Dire Maul: Tendris Warpwood
	-- {area:2577} Dire Maul · {zone:1444} Feralas · {npc:11489} Tendris Warpwood · {quest:7643} Ancient Equine Spirit · {item:18775} Manna-Enriched Horse Feed · {item:18753} Arcanite Barding
	["{area:2577} lies in central {zone:1444}; {npc:11489} guards the start of the West wing. Defeat him to free the {quest:7643}, feed it the {item:18775} and hand it the {item:18753} to bless. Bring a group."] = "{area:2577} liegt im Zentrum von {zone:1444}; {npc:11489} bewacht den Anfang des Westflügels. Besiege ihn, um {quest:7643} zu befreien, füttere ihn mit {item:18775} und gib ihm {item:18753} zum Segnen. Nimm eine Gruppe mit.",
	-- {npc:11489} Tendris Warpwood
	["{npc:11489}, inside the West wing"] = "{npc:11489}, im Westflügel",

	-- Step 16: Two diamonds
	["Two diamonds"] = "Zwei Diamanten",
	-- {item:12800} Azerothian Diamond · {item:18335} Pristine Black Diamond · {zone:1422} Western Plaguelands
	["An {item:12800} comes from Thorium veins, a {item:18335} from the elites of the {zone:1422}, both rarely: the Auction House is the usual source."] = "{item:12800} stammt aus Thoriumadern, {item:18335} von den Elitegegnern in {zone:1422}, beide selten: Meist kaufst du sie im Auktionshaus.",

	-- Step 17: Lord Grayson Shadowbreaker
	-- {item:18746} Divination Scryer
	["he hands you the {item:18746}"] = "er gibt dir {item:18746}",

	-- Step 18: The Great Ossuary
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:18746} Divination Scryer · {object:179746} The Great Ossuary (no name in this language: may be words) · {npc:14516} Death Knight Darkreaver · {item:18799} Charger's Redeemed Soul · {item:18792} Blessed Arcanite Barding
	["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. Use the {item:18746} in the heart of the {object:179746}'s basement, defeat the spirits it calls and then {npc:14516}, and give his Fallen Charger the {item:18799} and the {item:18792}. All are elite: bring a group. If the attempt fails, Lord Grayson gives you a new scryer through Again Into the {object:179746}."] = "{area:2057} liegt unter {area:2298}, der Inselstadt im Südosten von {zone:1422}. Benutze {item:18746} mitten im Keller des Großen Ossuariums, besiege die gerufenen Geister und dann {npc:14516} und gib seinem gefallenen Streitross {item:18799} und {item:18792}. Alle sind Elite: Nimm eine Gruppe mit. Scheitert der Versuch, gibt dir Lord Grayson Schattenbruch mit Erneut im großen Ossuarium ein neues Wahrsagegerät.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. Use the {item:18746} in the heart of the {object:179746}'s basement, defeat the spirits it calls and then {npc:14516}, and give his Fallen Charger the {item:18799} and the {item:18792}. All are elite: bring a group. If the attempt fails, Lord Grayson gives you a new scryer through Again Into the {object:179746}."] = "{area:2057} liegt unter {area:2298}, der Inselstadt im Südosten von {zone:1422}. Benutze {item:18746} mitten im Keller von {object:179746}, besiege die gerufenen Geister und dann {npc:14516} und gib seinem gefallenen Streitross {item:18799} und {item:18792}. Alle sind Elite: Nimm eine Gruppe mit. Scheitert der Versuch, gibt dir Lord Grayson mit einer Quest, die dich erneut zu {object:179746} schickt, ein neues Wahrsagegerät.",
}
