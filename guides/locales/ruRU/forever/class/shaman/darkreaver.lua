-- Russian (ruRU): the guide forever/class/shaman/darkreaver (forever/class/shaman/darkreaver.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:2057} Scholomance · {item:20134} Skyfury Helm
	["A {area:2057} fight at 60 for Horde reputation; Forever removed the {item:20134}."] = "Бой в подземелье {area:2057} на 60-м уровне ради репутации у Орды; в Forever убрали предмет {item:20134}.",
	["200 Horde reputation"] = "200 очков репутации у Орды",

	-- Step 1: Sagorne Creststrider
	-- {npc:13417} Sagorne Creststrider · {object:172957} Valley of Wisdom
	["At 58 {npc:13417}, the shaman trainer in the {object:172957}, asks for two rare diamonds."] = "На 58-м уровне {npc:13417}, учитель шаманов ({object:172957}), просит два редких алмаза.",

	-- Step 2: Two diamonds
	["Two diamonds"] = "Два алмаза",
	-- {item:12800} Azerothian Diamond · {item:18335} Pristine Black Diamond · {zone:1422} Western Plaguelands
	["An {item:12800} comes from Thorium veins, a {item:18335} from the elites of the {zone:1422}, both rarely: buy them at the auction house if you can."] = "{item:12800} добывается из ториевых жил, {item:18335} — с элитных противников зоны {zone:1422}, оба редко: по возможности купите их на аукционе.",

	-- Step 3: Sagorne Creststrider
	-- {quest:7668} The Darkreaver Menace
	["{quest:7668} needs level 60."] = "Для задания {quest:7668} нужен 60-й уровень.",
	-- {item:18746} Divination Scryer
	["he hands you the {item:18746}"] = "он вручает вам {item:18746}",

	-- Step 4: The Great Ossuary
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:18746} Divination Scryer · {object:179746} The Great Ossuary (no name in this language: may be words) · {npc:14516} Death Knight Darkreaver
	["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. Use the {item:18746} in the heart of the {object:179746}'s basement, beat the spirits it calls, then {npc:14516}. All are elite: bring a group."] = "{area:2057} находится под местом {area:2298} — городком на острове на юго-востоке зоны {zone:1422}. Используйте {item:18746} в центре подвала Главного склепа, победите призванных духов, а затем: {npc:14516}. Все они элитные: возьмите группу.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}. Use the {item:18746} in the heart of the {object:179746}'s basement, beat the spirits it calls, then {npc:14516}. All are elite: bring a group."] = "{area:2057} находится под местом {area:2298} — городком на острове на юго-востоке зоны {zone:1422}. Используйте {item:18746} в центре подвала ({object:179746}), победите призванных духов, а затем: {npc:14516}. Все они элитные: возьмите группу.",
}
