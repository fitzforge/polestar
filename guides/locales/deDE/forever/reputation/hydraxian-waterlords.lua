-- German (deDE): the guide forever/reputation/hydraxian-waterlords (forever/reputation/hydraxian-waterlords.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Hydraxian Waterlords Reputation"] = "Ruf: Hydraxianer",

	-- Step 1: Duke Hydraxis
	-- {npc:13278} Duke Hydraxis · {zone:1447} Azshara · {faction:749} Hydraxian Waterlords
	["{npc:13278} stands on a small island off the eastern coast of {zone:1447}; swim or walk the shallows out to him. The {faction:749} start out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:13278} steht auf einer kleinen Insel vor der Ostküste von {zone:1447}; schwimm oder lauf durch das seichte Wasser zu ihm. Bei {faction:749} beginnst du neutral. Der Vermächtnis-Vorteil „Diplomat“ von Forever erhöht den Rufgewinn.",

	-- Step 2: Dust Stormers and Desert Rumblers
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["Dust Stormers and Desert Rumblers"] = "Staubstürmer und Wüstenrumpler",
	-- {zone:1451} Silithus
	["Both elementals roam north-western {zone:1451}; the Rumblers cluster a little further north."] = "Beide Elementare streifen durch den Nordwesten von {zone:1451}; die Wüstenrumpler sammeln sich etwas weiter nördlich.",

	-- Step 3: Poisoned Water
	-- {item:17310} Aspect of Neptulon · {zone:1423} Eastern Plaguelands · {item:17309} Discordant Bracers
	["Use the {item:17310} on the poisoned water elementals of {zone:1423}, then loot their {item:17309} (12)."] = "Benutze {item:17310} an den vergifteten Wasserelementaren in den {zone:1423} und plündere dann ihre {item:17309} (12).",

	-- Step 4: Back to Duke Hydraxis
	-- {npc:13278} Duke Hydraxis
	["Back to {npc:13278}"] = "Zurück zu {npc:13278}",

	-- Step 5: Eye of the Emberseer
	-- {npc:9816} Pyroguard Emberseer · {quest:6821} Eye of the Emberseer
	["{npc:9816} in Upper Blackrock Spire drops the {quest:6821}. This needs a raid group."] = "{npc:9816} in der Oberen Blackrockspitze lässt {quest:6821} fallen. Dafür brauchst du eine Schlachtzugsgruppe.",

	-- Step 6: The Molten Core
	-- {npc:11668} Firelord · {npc:11658} Molten Giant · {npc:11673} Ancient Core Hound · {npc:12101} Lava Surger · {area:2717} Molten Core
	["Kill a {npc:11668}, a {npc:11658}, an {npc:11673} and a {npc:12101} in the {area:2717}. Every {area:2717} elemental and boss also counts toward the Waterlords."] = "Töte einen {npc:11668}, einen {npc:11658}, einen {npc:11673} und einen {npc:12101} im {area:2717}. Jeder Elementar und Boss im {area:2717} zählt auch für die Hydraxianer.",

	-- Step 7: Agent of Hydraxis
	-- {quest:6823} Agent of Hydraxis · {npc:13278} Duke Hydraxis · {item:17333} Aqual Quintessence · {area:2717} Molten Core · {npc:12018} Majordomo Executus · {item:22754} Eternal Quintessence
	["{quest:6823} needs Honored. At Honored, {npc:13278} hands out {item:17333}, used to douse the runes in the {area:2717} that summon {npc:12018}; at Revered, the reusable {item:22754}."] = "{quest:6823} erfordert Wohlwollend. Bei Wohlwollend gibt {npc:13278} {item:17333} aus, mit der du die Runen im {area:2717} löschst, die {npc:12018} beschwören; bei Respektvoll die wiederverwendbare {item:22754}.",

	-- Step 8: Hands of the Enemy
	-- {area:2717} Molten Core
	["Bring the Hands of Lucifron, Gehennas, Shazzrah and Sulfuron from the {area:2717}."] = "Bring die Hand von Lucifron, Gehennas, Shazzrah und Sulfuron aus dem {area:2717}.",

	-- Step 9: Hydraxian Waterlords to Revered
	-- {faction:749} Hydraxian Waterlords
	["{faction:749} to Revered"] = "{faction:749} bis Respektvoll",
	-- {area:2717} Molten Core
	["{area:2717} clears carry the rest. Bosses always count; in Classic, trash kills stop giving Waterlords reputation partway up, so late on the bosses do the work."] = "Den Rest bringen Säuberungen des {area:2717}. Bosse zählen immer; in Classic geben normale Gegner ab einer gewissen Stufe keinen Ruf bei den Hydraxianer mehr, später erledigen also die Bosse die Arbeit.",

	-- Step 10: Hydraxian Waterlords to Exalted
	-- {faction:749} Hydraxian Waterlords
	["{faction:749} to Exalted"] = "{faction:749} bis Ehrfürchtig",
	-- {area:2717} Molten Core
	["Keep clearing the {area:2717} until Exalted."] = "Säubere weiter den {area:2717}, bis du ehrfürchtig bist.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Use the {item:17310} on the poisoned water elementals of {zone:1423}, then loot their {item:17309} (12). Our data has no spawn points for those elementals."] = "Benutze {item:17310} an den vergifteten Wasserelementaren in den {zone:1423} und plündere dann ihre {item:17309} (12). Unsere Daten haben keine Fundorte für diese Elementare.",
}
