-- German (deDE): the guide forever/reputation/cenarion-circle (forever/reputation/cenarion-circle.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Cenarion Circle Reputation"] = "Ruf: Zirkel des Cenarius",

	-- Step 1: Cenarion Hold
	-- {area:3425} Cenarion Hold · {zone:1451} Silithus · {npc:15270} Huum Wildmane · {faction:609} Cenarion Circle
	["{area:3425} is the walled town in north-central {zone:1451}. Bor and {npc:15270} stand together inside. The {faction:609} starts out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{area:3425} ist die ummauerte Stadt im nördlichen Zentrum von {zone:1451}. Bor und {npc:15270} stehen zusammen drinnen. Beim {faction:609} beginnst du mit Neutral. Forevers Vermächtnis-Vorteil „Diplomat“ erhöht den Rufgewinn.",
	-- {quest:8320} Twilight Geolords
	["{quest:8320} needs level 60"] = "{quest:8320} erfordert Stufe 60",

	-- Step 2: Twilight Base Camp
	-- {zone:1451} Silithus · {quest:8320} Twilight Geolords · {item:20404} Encrypted Twilight Text · {faction:609} Cenarion Circle
	["Twilight's Hammer cultists hold the camps in western {zone:1451}. {quest:8320} and Stonecallers mix here; any cultist can drop an {item:20404}. Every cultist kill also counts toward the {faction:609}. The Geolords count for {quest:8320} only if you are 60 and took it."] = "Kultisten des Twilight-Hammers halten die Lager im Westen von {zone:1451}. {quest:8320} und Steinrufer sind hier gemischt; jeder Kultist kann {item:20404} fallen lassen. Jeder getötete Kultist zählt auch für den {faction:609}. Die Geolords zählen nur für {quest:8320}, wenn du 60 bist und die Quest angenommen hast.",

	-- Step 3: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "Zurück nach {area:3425}",

	-- Step 4: Encrypted Twilight Texts to Friendly
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["Encrypted Twilight Texts to Friendly"] = "Verschlüsselte Texte der Twilight bis Freundlich",
	-- {npc:15306} Bor Wildmane
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["Encrypted Twilight Texts repeats: {npc:15306} takes more texts again and again. The cultist camps are the place to farm them."] = "Verschlüsselte Texte der Twilight ist wiederholbar: {npc:15306} nimmt immer wieder weitere Texte an. In den Kultistenlagern farmst du sie am besten.",
	-- {npc:15306} Bor Wildmane
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:15306}: Encrypted Twilight Texts"] = "{npc:15306}: Verschlüsselte Texte der Twilight",

	-- Step 5: Cenarion Circle to Honored
	-- {faction:609} Cenarion Circle
	["{faction:609} to Honored"] = "{faction:609} bis Wohlwollend",
	-- {npc:15282} Aurel Goldleaf · {npc:15306} Bor Wildmane
	-- plural, as words: Wind Stones = {object:180461} Wind Stone · Abyssal Crests = {item:20513} Abyssal Crest
	["Keep farming the Twilight camps. Wearing the Twilight Trappings (the Twilight cultist set plus a Medallion of Station, from {npc:15282}'s Medallion of Station quest) lets you summon Abyssal Templars at the Wind Stones; their Abyssal Crests go to {npc:15306}."] = "Farm weiter in den Twilight-Lagern. Mit der Twilight-Kultistenausrüstung (das Twilightkultisten-Set plus ein Standesmedaillon aus der Quest Das Standesmedallion von {npc:15282}) kannst du an den Windsteinen Abyssische Templer beschwören; ihre Abyssischen Wappen gehen an {npc:15306}.",

	-- Step 6: Cenarion Circle to Revered
	-- {faction:609} Cenarion Circle
	["{faction:609} to Revered"] = "{faction:609} bis Respektvoll",
	-- {area:3454} Ruins of Ahn'Qiraj
	["From here on, the {area:3454} raid and the Abyssal Council turn-ins (crests, signets, scepters) carry most of the reputation."] = "Ab hier bringen der Schlachtzug {area:3454} und die Abgaben für den Abyssischen Rat (Wappen, Siegel, Szepter) den meisten Ruf.",
	-- {npc:15306} Bor Wildmane
	-- plural, as words: Abyssal Crests = {item:20513} Abyssal Crest · Abyssal Signets = {item:20514} Abyssal Signet · Abyssal Scepters = {item:20515} Abyssal Scepter
	["Abyssal Crests, Abyssal Signets and Abyssal Scepters are repeatable at {npc:15306} once their opening quests are done."] = "Abyssische Wappen, Abyssische Siegel und Abyssische Szepter sind bei {npc:15306} wiederholbar, sobald ihre Einstiegsquests erledigt sind.",

	-- Step 7: Cenarion Circle to Exalted
	-- {faction:609} Cenarion Circle
	["{faction:609} to Exalted"] = "{faction:609} bis Ehrfürchtig",
	-- {area:3454} Ruins of Ahn'Qiraj
	["Keep running the {area:3454} and turning in Abyssal Council insignia until Exalted."] = "Lauf weiter {area:3454} und gib Insignien für den Abyssischen Rat ab, bis du Ehrfürchtig bist.",
}
