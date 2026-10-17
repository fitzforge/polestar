-- Russian (ruRU): the guide forever/reputation/cenarion-circle (forever/reputation/cenarion-circle.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Cenarion Circle Reputation"] = "Репутация: Круг Кенария",

	-- Step 1: Cenarion Hold
	-- {area:3425} Cenarion Hold · {zone:1451} Silithus · {npc:15270} Huum Wildmane · {faction:609} Cenarion Circle
	["{area:3425} is the walled town in north-central {zone:1451}. Bor and {npc:15270} stand together inside. The {faction:609} starts out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{area:3425} – обнесенный стеной городок в центре севера зоны {zone:1451}. Бор и {npc:15270} стоят внутри рядом. {faction:609}: начальная репутация – равнодушие. Бонус наследия Forever «Дипломат» ускоряет рост репутации.",
	-- {quest:8320} Twilight Geolords
	["{quest:8320} needs level 60"] = "{quest:8320}: нужен 60-й уровень",

	-- Step 2: Twilight Base Camp
	-- {zone:1451} Silithus · {quest:8320} Twilight Geolords · {item:20404} Encrypted Twilight Text · {faction:609} Cenarion Circle
	["Twilight's Hammer cultists hold the camps in western {zone:1451}. {quest:8320} and Stonecallers mix here; any cultist can drop an {item:20404}. Every cultist kill also counts toward the {faction:609}. The Geolords count for {quest:8320} only if you are 60 and took it."] = "Культисты Сумеречного Молота занимают лагеря на западе зоны {zone:1451}. Здесь вперемешку геолорды ({quest:8320}) и камнезовы; с любого культиста может упасть {item:20404}. Каждое убийство культиста также дает репутацию ({faction:609}). Геолорды засчитываются для задания {quest:8320}, только если вам 60 и вы его взяли.",

	-- Step 3: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "Вернитесь: {area:3425}",

	-- Step 4: Encrypted Twilight Texts to Friendly
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["Encrypted Twilight Texts to Friendly"] = "Зашифрованные тексты Сумеречных ({item:20404}) до уровня «Дружелюбие»",
	-- {npc:15306} Bor Wildmane
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["Encrypted Twilight Texts repeats: {npc:15306} takes more texts again and again. The cultist camps are the place to farm them."] = "Задание с текстами повторяется: {npc:15306} принимает: {item:20404} – снова и снова. Фармите их в лагерях культистов.",
	-- {npc:15306} Bor Wildmane
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:15306}: Encrypted Twilight Texts"] = "{npc:15306}: {item:20404}",

	-- Step 5: Cenarion Circle to Honored
	-- {faction:609} Cenarion Circle
	["{faction:609} to Honored"] = "{faction:609} до уровня «Уважение»",
	-- {npc:15282} Aurel Goldleaf · {npc:15306} Bor Wildmane
	-- plural, as words: Wind Stones = {object:180461} Wind Stone · Abyssal Crests = {item:20513} Abyssal Crest
	["Keep farming the Twilight camps. Wearing the Twilight Trappings (the Twilight cultist set plus a Medallion of Station, from {npc:15282}'s Medallion of Station quest) lets you summon Abyssal Templars at the Wind Stones; their Abyssal Crests go to {npc:15306}."] = "Продолжайте фармить лагеря Сумеречного Молота. В облачении культиста Сумеречного Молота и со станционным медальоном (задание «Станционный медальон» от NPC {npc:15282}) можно призывать храмовников у камней ветра ({object:180461}); {item:20513} с них сдавайте NPC {npc:15306}.",

	-- Step 6: Cenarion Circle to Revered
	-- {faction:609} Cenarion Circle
	["{faction:609} to Revered"] = "{faction:609} до уровня «Почтение»",
	-- {area:3454} Ruins of Ahn'Qiraj
	["From here on, the {area:3454} raid and the Abyssal Council turn-ins (crests, signets, scepters) carry most of the reputation."] = "Дальше основную репутацию дают рейд {area:3454} и сдача знаков Совета Бездны (талисманы, перстни, скипетры).",
	-- {npc:15306} Bor Wildmane
	-- plural, as words: Abyssal Crests = {item:20513} Abyssal Crest · Abyssal Signets = {item:20514} Abyssal Signet · Abyssal Scepters = {item:20515} Abyssal Scepter
	["Abyssal Crests, Abyssal Signets and Abyssal Scepters are repeatable at {npc:15306} once their opening quests are done."] = "{item:20513}, {item:20514} и {item:20515} можно сдавать NPC {npc:15306} повторно после вводных заданий.",

	-- Step 7: Cenarion Circle to Exalted
	-- {faction:609} Cenarion Circle
	["{faction:609} to Exalted"] = "{faction:609} до уровня «Превознесение»",
	-- {area:3454} Ruins of Ahn'Qiraj
	["Keep running the {area:3454} and turning in Abyssal Council insignia until Exalted."] = "Проходите {area:3454} и сдавайте знаки Совета Бездны до превознесения.",
}
