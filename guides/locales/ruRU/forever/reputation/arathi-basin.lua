-- Russian (ruRU): the guide forever/reputation/arathi-basin (forever/reputation/arathi-basin.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Arathi Basin Reputation"] = "Репутация: Низина Арати",

	-- Step 1: League of Arathor to Friendly
	["League of Arathor to Friendly"] = "Лига Аратора до уровня «Дружелюбие»",
	-- {faction:509} The League of Arathor · {zone:1461} Arathi Basin · {area:320} Refuge Pointe
	["{faction:509} fights for {zone:1461} from {area:320}. Their reputation comes from the battleground: the resources your team gathers pay it to everyone, so holding more bases for longer pays more. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:509} сражается за зону {zone:1461}, база – {area:320}. Репутацию дает поле боя: ресурсы, собранные командой, приносят ее всем, так что чем больше баз и дольше, тем больше репутации. Встаньте в очередь у любого военачальника поля боя. Бонус наследия Forever «Дипломат» ускоряет рост репутации.",
	-- {npc:14983} Field Marshal Oslight · {zone:1461} Arathi Basin · {npc:14984} Sergeant Maclear
	-- plural, as words: Arathi Resource Crates = {item:19725} Arathi Resource Crate
	["{npc:14983}'s The Battle for {zone:1461}! (assault every base) and Control Four Bases / Control Five Bases are one-time quests; {npc:14984} beside him takes Arathi Resource Crates."] = "Задания от NPC {npc:14983} – «Битва за Низину Арати» ({zone:1461}; атакуйте каждую базу) и «Контроль над четырьмя базами» / «Контроль над пятью базами» – одноразовые; {npc:14984} рядом с ним принимает: {item:19725}.",

	-- Step 2: League of Arathor to Honored
	["League of Arathor to Honored"] = "Лига Аратора до уровня «Уважение»",
	-- {zone:1461} Arathi Basin · {npc:15351} Alliance Brigadier General
	["Keep playing {zone:1461}. On Call to Arms: {zone:1461} weekends the {npc:15351} in the capitals takes three Arathi Basin Marks of Honor for extra reputation."] = "Продолжайте играть: {zone:1461}. В выходные «К оружию!» ({zone:1461}) {npc:15351} в столицах принимает три почетных знака Низины Арати за дополнительную репутацию.",
	-- {npc:15127} Samuel Hawke
	["{npc:15127} hands out one Arathor care package by level"] = "{npc:15127} выдает по одному полевому комплекту Лиги Аратора за уровень",

	-- Step 3: League of Arathor to Revered
	["League of Arathor to Revered"] = "Лига Аратора до уровня «Почтение»",
	-- {zone:1461} Arathi Basin
	["Keep playing {zone:1461}; wins with many bases held pay the most."] = "Продолжайте играть: {zone:1461}; больше всего дают победы с множеством удержанных баз.",

	-- Step 4: League of Arathor to Exalted
	["League of Arathor to Exalted"] = "Лига Аратора до уровня «Превознесение»",
	["Exalted with the League of Arathor earns a Legacy Point."] = "Превознесение у Лиги Аратора дает очко наследия.",

	-- Step 5: The Defilers to Friendly
	-- {faction:510} The Defilers
	["{faction:510} to Friendly"] = "{faction:510} до уровня «Дружелюбие»",
	-- {faction:510} The Defilers · {zone:1461} Arathi Basin · {area:321} Hammerfall
	["{faction:510} fight for {zone:1461} from {area:321}. Their reputation comes from the battleground: the resources your team gathers pay it to everyone, so holding more bases for longer pays more. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:510} сражаются за зону {zone:1461}, база – {area:321}. Репутацию дает поле боя: ресурсы, собранные командой, приносят ее всем, так что чем больше баз и дольше, тем больше репутации. Встаньте в очередь у любого военачальника поля боя. Бонус наследия Forever «Дипломат» ускоряет рост репутации.",
	-- {npc:15021} Deathmaster Dwire · {zone:1461} Arathi Basin · {npc:15022} Deathstalker Mortis
	-- plural, as words: Arathi Resource Crates = {item:19725} Arathi Resource Crate
	["{npc:15021}'s The Battle for {zone:1461}! (assault every base) and Take Four Bases / Take Five Bases are one-time quests; {npc:15022} beside him takes Arathi Resource Crates."] = "Задания от NPC {npc:15021} – «Битва за Низину Арати» ({zone:1461}; атакуйте каждую базу) и «Захват четырех баз» / «Занять пять баз» – одноразовые; {npc:15022} рядом с ним принимает: {item:19725}.",

	-- Step 6: The Defilers to Honored
	-- {faction:510} The Defilers
	["{faction:510} to Honored"] = "{faction:510} до уровня «Уважение»",
	-- {zone:1461} Arathi Basin · {npc:15350} Horde Warbringer
	["Keep playing {zone:1461}. On Call to Arms: {zone:1461} weekends the {npc:15350} in the capitals takes three Arathi Basin Marks of Honor for extra reputation."] = "Продолжайте играть: {zone:1461}. В выходные «К оружию!» ({zone:1461}) {npc:15350} в столицах принимает три почетных знака Низины Арати за дополнительную репутацию.",
	-- {npc:15126} Rutherford Twing
	["{npc:15126} hands out one Defiler's care package by level"] = "{npc:15126} выдает по одному полевому комплекту Осквернителей за уровень",

	-- Step 7: The Defilers to Revered
	-- {faction:510} The Defilers
	["{faction:510} to Revered"] = "{faction:510} до уровня «Почтение»",

	-- Step 8: The Defilers to Exalted
	-- {faction:510} The Defilers
	["{faction:510} to Exalted"] = "{faction:510} до уровня «Превознесение»",
	-- {faction:510} The Defilers
	["Exalted with {faction:510} earns a Legacy Point."] = "Превознесение у фракции {faction:510} дает очко наследия.",
}
