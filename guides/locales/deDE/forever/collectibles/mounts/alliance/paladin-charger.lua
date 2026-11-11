-- German (deDE): the guide forever/collectibles/mounts/alliance/paladin-charger (forever/collectibles/mounts/alliance/paladin-charger.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {spell:23214} Summon Charger · {area:2279} Stratholme · {area:2057} Scholomance · {item:14047} Runecloth · {item:8836} Arthas' Tears · {npc:6171} Duthorian Rall
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["The {spell:23214} chain is long: {area:2279}, Dire Maul West and {area:2057} with a group, 350 gold in donations, and materials worth several hundred more (6 Arcanite Bars, 40 {item:14047}, 10 {item:8836}, two diamonds). Start saving early. Lord Grayson stands in the Cathedral of Light, {npc:6171} nearby."] = "Die Kette der {spell:23214} ist lang: {area:2279}, Düsterbruch West und {area:2057} mit einer Gruppe, 350 Gold an Spenden und Materialien für mehrere hundert weitere (6 Arkanitbarren, 40 {item:14047}, 10 {item:8836}, zwei Diamanten). Fang früh an zu sparen. Lord Grayson steht in der Kathedrale des Lichts, {npc:6171} in der Nähe.",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}, Cathedral of Light"] = "{npc:6171}, Kathedrale des Lichts",

	-- Step 3: High Priest Rohan
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words)
	["{npc:11406}, the priest trainer, walks about the {object:32386} in {zone:1455}'s {object:32362}. He gives you his censer for a donation of 150 gold, taken at the hand-in. Keep the censer."] = "{npc:11406}, der Priesterlehrer, geht in der {object:32362} von {zone:1455} um die {object:32386} herum. Er gibt dir sein Räuchergefäß für eine Spende von 150 Gold, die bei der Abgabe genommen wird. Behalte das Räuchergefäß.",
	-- {npc:11406} High Priest Rohan
	["{npc:11406}: 150 gold"] = "{npc:11406}: 150 Gold",

	-- Step 4: Back to Lord Grayson
	["Back to Lord Grayson"] = "Zurück zu Lord Grayson",
	-- {item:18752} Exorcism Censer · {area:2627} Terrordale
	["Lord Grayson blesses the censer into the {item:18752} for {area:2627}."] = "Lord Grayson segnet das Räuchergefäß zum {item:18752} für {area:2627}.",

	-- Step 5: Exorcising Terrordale
	-- {area:2627} Terrordale · {zone:1423} Eastern Plaguelands · {area:2279} Stratholme · {object:179747} Terrordale Haunting Spirit (no name in this language: may be words) · {item:18752} Exorcism Censer · {spell:7713} Wailing Dead · {spell:2878} Turn Undead
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit
	["{area:2627} lies in the far north-west of the {zone:1423}, west of the {area:2279} gates. Stand inside a green glowing patch on the ground (a {object:179747}; some are inside the ruined houses) and use the {item:18752}: up to three Terrordale Spirits (level 59-60) rise and attack. Their {spell:7713} lowers all your stats by 30%: fight them one at a time and use {spell:2878}. The patches come back quickly; several paladins can work side by side."] = "{area:2627} liegt im äußersten Nordwesten der {zone:1423}, westlich der Tore von {area:2279}. Stell dich in eine grün leuchtende Stelle am Boden (ein {object:179747}; manche liegen in den zerstörten Häusern) und benutze das {item:18752}: Bis zu drei Terrordale Spirits (Stufe 59-60) erheben sich und greifen an. Ihr {spell:7713} senkt alle deine Werte um 30%: Bekämpfe sie einzeln und benutze {spell:2878}. Die Stellen kehren schnell zurück; mehrere Paladine können Seite an Seite arbeiten.",
	-- {item:18752} Exorcism Censer
	["{item:18752}, inside a green patch"] = "{item:18752}, in einer grünen Stelle",
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit
	["Terrordale Spirits x25"] = "Terrordale Spirits x25",

	-- Step 6: Lord Grayson Shadowbreaker
	["Lord Grayson takes the censer back."] = "Lord Grayson nimmt das Räuchergefäß zurück.",

	-- Step 7: Grimand Elmore
	-- {npc:1416} Grimand Elmore · {zone:1453} Stormwind · {object:28027} Dwarven District · {item:18753} Arcanite Barding
	["{npc:1416} works in {zone:1453}'s {object:28027}. He forges the {item:18753} from your materials and 150 gold."] = "{npc:1416} arbeitet im {object:28027} von {zone:1453}. Er schmiedet aus deinen Materialien und 150 Gold die {item:18753}.",

	-- Step 8: Grimand Elmore's materials
	-- {npc:1416} Grimand Elmore
	["{npc:1416}'s materials"] = "{npc:1416}s Materialien",
	-- {item:14047} Runecloth · {area:2255} Everlook · {area:2577} Dire Maul · {item:8836} Arthas' Tears · {skill:182} Herbalism · {area:3197} Chillwind Camp · {item:12360} Arcanite Bar · {item:12359} Thorium Bar · {item:12363} Arcane Crystal
	["{item:14047} drops from humanoids of level 50 and up ({area:2255}'s Bruisers, the Scarlet Crusade in the Plaguelands, the {area:2577} ogres). {item:8836} is a Plaguelands herb ({skill:182} 220), common around {area:3197}. An {item:12360} is an alchemist's transmute from a {item:12359} and an {item:12363}, once every two days per alchemist: ask a guild alchemist early, or buy the bars. The Auction House sells all three."] = "{item:14047} fällt von Humanoiden ab Stufe 50 ({area:2255}s Schläger, den Scharlachroten im Pestland, den Ogern von {area:2577}). {item:8836} ist ein Kraut des Pestlands ({skill:182} 220), häufig um {area:3197}. Ein {item:12360} ist die Transmutation eines Alchemisten aus einem {item:12359} und einem {item:12363}, einmal alle zwei Tage pro Alchemist: Frag früh einen Gildenalchemisten oder kaufe die Barren. Das Auktionshaus verkauft alle drei.",
	-- {item:14047} Runecloth
	["{item:14047} x40"] = "{item:14047} x40",
	-- {item:8836} Arthas' Tears
	["{item:8836} x10"] = "{item:8836} x10",
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["Arcanite Bars x6: an alchemist, or the Trade District Auction House"] = "Arkanitbarren x6: ein Alchemist oder das Auktionshaus im Handelsdistrikt",

	-- Step 9: Stratholme Holy Water
	-- {area:2279} Stratholme · {zone:1423} Eastern Plaguelands
	-- plural, as words: Stratholme Supply Crates = {object:181085} Stratholme Supply Crate
	["{area:2279} is a dungeon for a group of five at 58-60, at the north end of the {zone:1423}. Stratholme Supply Crates along the streets of both halves hold the Holy Water, one to three each; they come back after three minutes. Some crates let out a swarm of plagued rats or maggots: be ready. The main gate (the Scarlet half) needs no key."] = "{area:2279} ist ein Dungeon für eine Gruppe von fünf auf Stufe 58-60 am nördlichen Ende der {zone:1423}. Stratholme Supply Crates in den Straßen beider Hälften enthalten das Weihwasser, je ein bis drei; sie kehren nach drei Minuten wieder. Manche Kisten lassen einen Schwarm verseuchter Ratten oder Maden frei: Sei darauf gefasst. Das Haupttor (die scharlachrote Hälfte) braucht keinen Schlüssel.",
	-- plural, as words: Stratholme Supply Crates = {object:181085} Stratholme Supply Crate
	["Stratholme Supply Crates, inside"] = "Stratholme Supply Crates, drinnen",

	-- Step 10: Grimand Elmore
	-- {npc:1416} Grimand Elmore · {item:18753} Arcanite Barding
	["Bring the materials and 150 gold, taken at the hand-in. {npc:1416} walks to his forge and hands you the {item:18753}."] = "Bring die Materialien und 150 Gold, die bei der Abgabe genommen werden. {npc:1416} geht zu seiner Schmiede und gibt dir die {item:18753}.",
	-- {npc:1416} Grimand Elmore
	["{npc:1416}: 150 gold"] = "{npc:1416}: 150 Gold",

	-- Step 11: Lord Grayson Shadowbreaker
	["Lord Grayson keeps the barding for now: you get it back with the next quest."] = "Lord Grayson behält die Pferderüstung vorerst: Du bekommst sie mit der nächsten Quest zurück.",
	-- {npc:928} Lord Grayson Shadowbreaker · {item:18753} Arcanite Barding
	["{npc:928}: the {item:18753}"] = "{npc:928}: {item:18753}",

	-- Step 12: Enriched Manna Biscuits
	-- plural, as words: Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Enriched Manna Biscuits"] = "Angereicherte Manakekse",
	-- {object:2160} The Argent Dawn · {object:92525} Argent Dawn · {npc:10857} Argent Quartermaster Lightspark · {area:3197} Chillwind Camp · {npc:11536} Quartermaster Miranda Breechlock · {area:2268} Light's Hope Chapel
	-- plural, as words: Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["{object:2160} quartermasters sell Enriched Manna Biscuits, five for 60 silver, once the {object:92525} is Friendly with you: {npc:10857} at {area:3197} or {npc:11536} at {area:2268}. Scourgestones and the Plaguelands quests raise the standing."] = "Die Rüstmeister von {object:2160} verkaufen Enriched Manna Biscuits, fünf für 60 Silber, sobald die {object:92525} dir freundlich gesinnt ist: {npc:10857} bei {area:3197} oder {npc:11536} bei {area:2268}. Scourgestones und die Quests im Pestland steigern den Ruf.",
	-- {npc:10857} Argent Quartermaster Lightspark · {area:3197} Chillwind Camp
	-- plural, as words: Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Enriched Manna Biscuits: {npc:10857}, {area:3197}"] = "Angereicherte Manakekse: {npc:10857}, {area:3197}",

	-- Step 13: Merideth Carlson
	-- {npc:2357} Merideth Carlson · {area:271} Southshore · {quest:7645} Manna-Enriched Horse Feed
	["{npc:2357} breeds horses in {area:271}'s stable. She makes the {quest:7645} from the 20 biscuits and 50 gold, taken at the hand-in."] = "{npc:2357} züchtet Pferde im Stall von {area:271}. Aus den 20 Keksen und 50 Gold, die bei der Abgabe genommen werden, macht sie die {quest:7645}.",

	-- Step 14: Dire Maul: Tendris Warpwood
	-- {area:2577} Dire Maul · {zone:1444} Feralas · {item:18249} Crescent Key · {npc:11489} Tendris Warpwood · {npc:11459} Ironbark Protector · {quest:7643} Ancient Equine Spirit · {item:18753} Arcanite Barding
	["{area:2577} lies in central {zone:1444}. From the gate at the foot of the ruins, walk up through the outer courtyards to the West wing's door at their north end; it needs a {item:18249} (from Pusillin in Dire Maul East) or a rogue's lockpicking. {npc:11489} (level 60 elite) stands at the far end of the West wing's first courtyard. Once attacked he calls every {npc:11459} still alive in the courtyard: kill them first. His death frees the {quest:7643}: talk to it to give it the horse feed and the {item:18753}, and it blesses the barding. A group of five at 60."] = "{area:2577} liegt im Zentrum von {zone:1444}. Geh vom Tor am Fuß der Ruinen durch die äußeren Höfe hinauf zur Tür des Westflügels an deren Nordende; sie braucht einen {item:18249} (von Pusillin in Düsterbruch Ost) oder das Schlossknacken eines Schurken. {npc:11489} (Elite der Stufe 60) steht am Ende des ersten Hofs des Westflügels. Sobald er angegriffen wird, ruft er jeden {npc:11459} im Hof, der noch lebt: Töte diese zuerst. Sein Tod befreit das {quest:7643}: Sprich es an, um ihm das Pferdefutter und die {item:18753} zu geben, und es segnet die Rüstung. Eine Gruppe von fünf auf Stufe 60.",
	["Dire Maul West's door"] = "Tür von Düsterbruch West",
	-- {npc:11489} Tendris Warpwood
	["{npc:11489}, inside the West wing"] = "{npc:11489}, im Westflügel",

	-- Step 16: Two diamonds
	["Two diamonds"] = "Zwei Diamanten",
	-- {item:12800} Azerothian Diamond · {item:18335} Pristine Black Diamond · {npc:14695} Lord Blackwood
	["An {item:12800} comes from Thorium veins and obsidian, about one vein in a hundred; a {item:18335} drops rarely from elites of level 59 and up (Revanchion and {npc:14695} about one kill in nine and one in a hundred). The Auction House is the usual source of both."] = "Ein {item:12800} stammt aus Thoriumadern und Obsidian, etwa eine Ader von hundert; ein {item:18335} fällt selten von Elites ab Stufe 59 (Revanchion und {npc:14695}, etwa bei jedem neunten und bei jedem hundertsten Kill). Das Auktionshaus ist die übliche Quelle für beide.",

	-- Step 17: Lord Grayson Shadowbreaker
	-- {item:18804} Lord Grayson's Satchel · {item:18746} Divination Scryer · {item:18792} Blessed Arcanite Barding
	["Lord Grayson hands you {item:18804}: open it for the {item:18746} and the {item:18792}. Keep both."] = "Lord Grayson gibt dir {item:18804}: Öffne es für den {item:18746} und die {item:18792}. Behalte beide.",
	-- {item:18792} Blessed Arcanite Barding
	["{item:18792}, from the satchel"] = "{item:18792}, aus der Tasche",

	-- Step 18: The Great Ossuary
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:13704} Skeleton Key · {object:179746} The Great Ossuary (no name in this language: may be words) · {item:18746} Divination Scryer · {spell:1105} Seal of Wisdom · {npc:14516} Death Knight Darkreaver · {item:18749} Charger's Lost Soul · {item:18792} Blessed Arcanite Barding · {npc:14568} Darkreaver's Fallen Charger
	["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}; the door needs the {item:13704} (The Key to {area:2057}). Clear the {object:179746}, Rattlegore's room in the basement, then use the {item:18746} at its centre. Four waves of spirits come, each ending with an Aspect: players judge them with {spell:1105}, Justice, Righteousness and then Light, which stuns them. {npc:14516} (level 62 elite) comes after the last; he mind-controls players. Loot the {item:18749}, use it inside the Ossuary to redeem it, and give it and the {item:18792} to {npc:14568}. If the group wipes, the gates lock and the scryer is gone: abandon the quest and take it again from Lord Grayson for a new satchel. A group of five at 60. Again Into the {object:179746}, after the mount, lets you fight him again."] = "{area:2057} liegt unter {area:2298}, der Inselstadt im Südosten der {zone:1422}; die Tür braucht den {item:13704} (Der Schlüssel zu {area:2057}). Räume den {object:179746}, Rattlegores Raum im Keller, und benutze dann den {item:18746} in dessen Mitte. Vier Wellen von Geistern kommen, jede endet mit einem Aspekt: Spieler richten sie mit {spell:1105}, Gerechtigkeit, Rechtschaffenheit und dann Licht, das sie betäubt. {npc:14516} (Elite der Stufe 62) kommt nach der letzten; er kontrolliert Spieler mental. Plündere den {item:18749}, benutze ihn im Ossuarium, um ihn einzulösen, und gib ihn mit der {item:18792} an {npc:14568}. Wenn die Gruppe stirbt, verriegeln sich die Tore und der Seher ist fort: Brich die Quest ab und nimm sie bei Lord Grayson erneut an, um eine neue Tasche zu bekommen. Eine Gruppe von fünf auf Stufe 60. Mit Again Into the {object:179746} kannst du ihn nach dem Reittier erneut bekämpfen.",
	-- {item:18749} Charger's Lost Soul · {object:179746} The Great Ossuary (no name in this language: may be words)
	["{item:18749}, inside the {object:179746}"] = "{item:18749}, im {object:179746}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["An {item:12800} comes from Thorium veins, a {item:18335} from the elites of the {zone:1422}, both rarely: the Auction House is the usual source."] = "{item:12800} stammt aus Thoriumadern, {item:18335} von den Elitegegnern in {zone:1422}, beide selten: Meist kaufst du sie im Auktionshaus.",
	-- ["Arcanite Bars: the Auction House"] = "Arkanitbarren: Auktionshaus",
	-- ["Bring 150 gold for {npc:1416} along with the materials."] = "Bring für {npc:1416} 150 Gold zusammen mit den Materialien mit.",
	-- ["Supply Crates, inside"] = "Vorratskisten, drinnen",
	-- ["Terrordale Spirits"] = "Schreckenstalgeister",
	-- ["The {spell:23214} chain is long: it takes you through {area:2279}, {area:2577} and {area:2057}, and costs about 350 gold in donations on top of the materials. Lord Grayson stands in the Cathedral of Light."] = "Die Questreihe für {spell:23214} ist lang: Sie führt dich durch {area:2279}, {area:2577} und {area:2057} und kostet zusätzlich zu den Materialien etwa 350 Gold an Spenden. Lord Grayson steht in der Kathedrale des Lichts.",
	-- ["he hands you the {item:18746}"] = "er gibt dir {item:18746}",
	-- ["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. Use the {item:18746} in the heart of the {object:179746}'s basement, defeat the spirits it calls and then {npc:14516}, and give his Fallen Charger the {item:18799} and the {item:18792}. All are elite: bring a group. If the attempt fails, Lord Grayson gives you a new scryer through Again Into the {object:179746}."] = "{area:2057} liegt unter {area:2298}, der Inselstadt im Südosten von {zone:1422}. Benutze {item:18746} mitten im Keller des Großen Ossuariums, besiege die gerufenen Geister und dann {npc:14516} und gib seinem gefallenen Streitross {item:18799} und {item:18792}. Alle sind Elite: Nimm eine Gruppe mit. Scheitert der Versuch, gibt dir Lord Grayson Schattenbruch mit Erneut im großen Ossuarium ein neues Wahrsagegerät.",
	-- ["{area:2279} is a group of five, level 58-60, at the north end of the {zone:1423}. The Supply Crates scattered through the city hold the {item:13180}."] = "{area:2279} ist ein Dungeon für fünf Spieler, Stufe 58-60, am Nordende von {zone:1423}. Die in der Stadt verteilten Vorratskisten enthalten {item:13180}.",
	-- ["{area:2577} lies in central {zone:1444}; {npc:11489} guards the start of the West wing. Defeat him to free the {quest:7643}, feed it the {item:18775} and hand it the {item:18753} to bless. Bring a group."] = "{area:2577} liegt im Zentrum von {zone:1444}; {npc:11489} bewacht den Anfang des Westflügels. Besiege ihn, um {quest:7643} zu befreien, füttere ihn mit {item:18775} und gib ihm {item:18753} zum Segnen. Nimm eine Gruppe mit.",
	-- ["{area:2627} lies in the far north-west of the {zone:1423}, by the {zone:1422} border. Use the {item:18752} there to drive out the spirits, then defeat them."] = "{area:2627} liegt ganz im Nordwesten von {zone:1423}, an der Grenze zu {zone:1422}. Benutze dort {item:18752}, um die Geister auszutreiben, und besiege sie dann.",
	-- ["{item:14047} drops from humanoids around level 50 and up; {item:8836} is an herb of the Plaguelands and {zone:1448}; Arcanite Bars are an {skill:171} transmute. The Auction House in {zone:1453}'s {object:2096} sells all three, and so do crafters."] = "{item:14047} droppt bei Humanoiden ab etwa Stufe 50; {item:8836} ist ein Kraut der Pestländer und von {zone:1448}; Arkanitbarren sind eine Transmutation der {skill:171}. Das Auktionshaus in {zone:1453} ({object:2096}) verkauft alle drei, ebenso Handwerker.",
	-- ["{npc:11406} is in {zone:1455}'s {object:32362}. Bring 150 gold: the censer is yours for a donation."] = "{npc:11406} ist in {zone:1455} ({object:32362}). Bring 150 Gold mit: Das Räuchergefäß bekommst du gegen eine Spende.",
	-- ["{npc:1416} works in {zone:1453}'s {object:28027}."] = "{npc:1416} arbeitet in {zone:1453} ({object:28027}).",
	-- ["{npc:2357} breeds horses in {area:271}. She also wants 50 gold."] = "{npc:2357} züchtet Pferde in {area:271}. Sie will außerdem 50 Gold.",
	-- ["{object:2160} quartermasters sell the biscuits in fives once the {object:92525} is Friendly with you: {npc:10857} at {area:3197}, {npc:11536} at {area:2268}, {npc:10856} at the {area:813}."] = "Rüstmeister von {object:2160} verkaufen die Kekse im Fünferpack, sobald du bei {object:92525} Freundlich bist: {npc:10857} im {area:3197}, {npc:11536} in der {area:2268}, {npc:10856} im {area:813}.",
}
