-- German (deDE): the guide forever/reputation/hydraxian-waterlords (forever/reputation/hydraxian-waterlords.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Hydraxian Waterlords Reputation"] = "Ruf: Hydraxianer",
	-- {item:17333} Aqual Quintessence · {area:2717} Molten Core · {item:22754} Eternal Quintessence
	["{item:17333} to douse the {area:2717}'s runes, the reusable {item:22754} at Revered and a fire resistance ring."] = "{item:17333}, um die Runen des {area:2717} zu löschen, die wiederverwendbare {item:22754} bei Respektvoll und ein Feuerwiderstandsring.",

	-- Step 1: Duke Hydraxis
	-- {npc:13278} Duke Hydraxis · {zone:1447} Azshara · {area:2717} Molten Core
	["{npc:13278} stands on a small island off the east coast of {zone:1447}; swim out to him. Everyone starts Neutral with the Waterlords, and nearly all of their reputation comes from killing the servants of fire, air and earth: the quests themselves pay nothing until the last one. Take both quests: the chain goes on only when both are done. Everything past Honored happens in the {area:2717}, a raid of 40 that is not among the first raids Blizzard has announced for Forever; until it opens, Honored is as far as the Waterlords go. The numbers in this guide leave out the Legacy perk Diplomat, which adds up to 10%."] = "{npc:13278} steht auf einer kleinen Insel vor der Ostküste von {zone:1447}; schwimm zu ihm hinaus. Alle beginnen bei den Wasserherren Neutral, und fast ihr gesamter Ruf kommt vom Töten der Diener von Feuer, Luft und Erde: Die Quests selbst zahlen bis zur letzten nichts. Nimm beide Quests an: Die Kette geht nur weiter, wenn beide erledigt sind. Alles ab Wohlwollend findet im {area:2717} statt, einem Schlachtzug für 40, der nicht zu den ersten Schlachtzügen gehört, die Blizzard für Forever angekündigt hat; bis er öffnet, ist Wohlwollend das Ende der Wasserherren. Die Zahlen in diesem Guide lassen den Vermächtnis-Vorteil „Diplomat“ aus, der bis zu 10% hinzufügt.",

	-- Step 2: Stormers and Rumblers
	-- {area:2740} Crystal Vale · {zone:1451} Silithus
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["Dust Stormers and Desert Rumblers drift around the {area:2740} in the north-west of {zone:1451}. Each kill also pays 5 reputation while you are Neutral or Friendly, so stay if you mean to farm (next steps)."] = "Dust Stormers und Desert Rumblers treiben sich um {area:2740} im Nordwesten von {zone:1451} herum. Jeder Kill zahlt auch 5 Ruf, solange du Neutral oder Freundlich bist, bleib also, wenn du farmen willst (nächste Schritte).",

	-- Step 3: Poisoned Water
	-- {item:17310} Aspect of Neptulon · {npc:8521} Blighted Horror · {npc:8522} Plague Monstrosity · {npc:13279} Discordant Surge · {item:17309} Discordant Bracers
	["Use the {item:17310} on a {npc:8521} or a {npc:8522}: it turns into a {npc:13279}. Kill the surge and loot its {item:17309}. Twelve are needed, and the vial must still be in your bags at the turn-in."] = "Benutze die {item:17310} an einem {npc:8521} oder {npc:8522}: Er verwandelt sich in einen {npc:13279}. Töte die Woge und plündere ihr {item:17309}. Zwölf werden gebraucht, und die Phiole muss bei der Abgabe noch in deinen Taschen sein.",
	-- {item:17310} Aspect of Neptulon
	["{item:17310}, on the poisoned elementals"] = "{item:17310}, an den vergifteten Elementaren",

	-- Step 4: Back to Duke Hydraxis
	-- {npc:13278} Duke Hydraxis
	["Back to {npc:13278}"] = "Zurück zu {npc:13278}",

	-- Step 5: Eye of the Emberseer
	-- {npc:9816} Pyroguard Emberseer · {area:254} Blackrock Mountain · {item:12344} Seal of Ascension · {npc:9017} Lord Incendius · {area:1584} Blackrock Depths
	["{npc:9816} is a boss in Upper Blackrock Spire, inside {area:254}: a group of up to ten, and someone needs the {item:12344} to open the door. He drops the Eye and pays 50 reputation per kill up to 11,999 of 12,000 Honored. {npc:9017} in {area:1584} pays 15 the same way."] = "{npc:9816} ist ein Boss in der Oberen Schwarzfelsspitze, im {area:254}: eine Gruppe von bis zu zehn, und jemand braucht den {item:12344}, um die Tür zu öffnen. Er lässt das Auge fallen und zahlt 50 Ruf pro Kill bis 11.999 von 12.000 Wohlwollend. {npc:9017} in {area:1584} zahlt auf dieselbe Weise 15.",
	-- {quest:6821} Eye of the Emberseer
	["{quest:6821}: raid of ten"] = "{quest:6821}: Schlachtzug für zehn",

	-- Step 6: Attunement to the Core
	-- {npc:14387} Lothos Riftwaker · {area:254} Blackrock Mountain · {area:2717} Molten Core · {item:18412} Core Fragment · {area:1584} Blackrock Depths
	["{npc:14387} in {area:254} attunes you to the {area:2717}: bring him a {item:18412} from beside the {area:2717}'s portal at the bottom of {area:1584}. Once attuned, he can send you straight into the {area:2717}."] = "{npc:14387} im {area:254} stimmt dich auf den {area:2717} ein: Bring ihm einen {item:18412} vom Portal des {area:2717} am Fuß von {area:1584}. Bist du eingestimmt, kann er dich direkt in den {area:2717} schicken.",
	-- {item:18412} Core Fragment · {area:1584} Blackrock Depths
	["{item:18412}, at the portal in {area:1584}"] = "{item:18412}, am Portal in {area:1584}",

	-- Step 7: The Molten Core
	-- {quest:6822} The Molten Core · {npc:11658} Molten Giant · {npc:11668} Firelord · {npc:11673} Ancient Core Hound · {npc:12101} Lava Surger · {npc:13278} Duke Hydraxis · {npc:11988} Golemagg the Incinerator · {npc:11502} Ragnaros
	-- plural, as words: Firewalkers = {npc:11666} Firewalker · Flameguards = {npc:11667} Flameguard · Lava Elementals = {npc:12076} Lava Elemental · Lava Reavers = {npc:12100} Lava Reaver · Molten Destroyers = {npc:11659} Molten Destroyer · Firelords = {npc:11668} Firelord · Lava Surgers = {npc:12101} Lava Surger · Molten Giants = {npc:11658} Molten Giant · Ancient Core Hounds = {npc:11673} Ancient Core Hound
	["{quest:6822} is a raid of 40. Kill one {npc:11658}, {npc:11668}, {npc:11673} and {npc:12101} for {npc:13278}. Every elemental there pays: Firewalkers, Flameguards, Lava Elementals, Lava Reavers and Molten Destroyers 40, Firelords, Lava Surgers, Molten Giants and Ancient Core Hounds 20, up to 11,999 of 12,000 Honored; about 3,360 for a full clear of the trash. The bosses pay 100 each ({npc:11988} 150, {npc:11502} 200)."] = "{quest:6822} ist ein Schlachtzug für 40. Töte je einen {npc:11658}, {npc:11668}, {npc:11673} und {npc:12101} für {npc:13278}. Jedes Elementar dort zahlt: Firewalkers, Flameguards, Lava Elementals, Lava Reavers und Molten Destroyers 40, Firelords, Lava Surgers, Molten Giants und Ancient Core Hounds 20, bis 11.999 von 12.000 Wohlwollend; etwa 3.360 für ein vollständiges Räumen des Trashs. Die Bosse zahlen je 100 ({npc:11988} 150, {npc:11502} 200).",
	-- {npc:11658} Molten Giant
	["{npc:11658}: raid of 40"] = "{npc:11658}: Schlachtzug für 40",

	-- Step 8: Elementals to Honored
	["Elementals to Honored"] = "Elementare bis Wohlwollend",
	-- {quest:6823} Agent of Hydraxis · {area:2717} Molten Core · {npc:11744} Dust Stormer · {npc:11746} Desert Rumbler · {npc:7032} Greater Obsidian Elemental · {zone:1428} Burning Steppes · {npc:14478} Huricanian · {area:2740} Crystal Vale · {npc:9017} Lord Incendius · {object:174825} Black Anvil (no name in this language: may be words) · {area:1584} Blackrock Depths · {npc:9816} Pyroguard Emberseer
	["Neutral to Honored is 9,000 reputation, and {quest:6823} asks for Honored. One {area:2717} clear pays about 4,000 of it. Without a raid it comes from the elementals: 5 per {npc:11744}, {npc:11746} or {npc:7032} (the {zone:1428}), about 1,800 kills from Neutral. They stop at 5,999 of 6,000 Friendly, one point short, so the last point needs a kill that still counts there: {npc:14478}, a rare air elemental in the {area:2740} (25), or {npc:9017} at the {object:174825} in {area:1584} (15, a five-player dungeon). Those two and {npc:9816} keep paying through Honored as well."] = "Von Neutral bis Wohlwollend sind es 9.000 Ruf, und {quest:6823} verlangt Wohlwollend. Ein Durchgang durch den {area:2717} zahlt etwa 4.000 davon. Ohne Schlachtzug kommt er von den Elementaren: 5 pro {npc:11744}, {npc:11746} oder {npc:7032} (die {zone:1428}), ab Neutral etwa 1.800 Kills. Sie hören bei 5.999 von 6.000 Freundlich auf, einen Punkt zu früh, der letzte Punkt braucht also einen Kill, der dort noch zählt: {npc:14478}, ein seltenes Luftelementar bei {area:2740} (25), oder {npc:9017} am {object:174825} in {area:1584} (15, ein Dungeon für fünf). Diese beiden und {npc:9816} zahlen auch durch Wohlwollend weiter.",
	-- {npc:14478} Huricanian
	["{npc:14478}, rare, 25"] = "{npc:14478}, selten, 25",
	-- {npc:9017} Lord Incendius · {area:1584} Blackrock Depths
	["{npc:9017}, {area:1584}: 15, group up"] = "{npc:9017}, {area:1584}: 15, in der Gruppe",

	-- Step 9: Agent of Hydraxis
	-- {npc:13278} Duke Hydraxis · {quest:6823} Agent of Hydraxis
	["Back to {npc:13278}. {quest:6823} is done the moment you are Honored."] = "Zurück zu {npc:13278}. {quest:6823} ist erledigt, sobald du Wohlwollend bist.",

	-- Step 10: Hands of the Enemy
	-- {npc:12118} Lucifron · {npc:12259} Gehennas · {npc:12264} Shazzrah · {npc:12098} Sulfuron Harbinger · {area:2717} Molten Core
	["{npc:12118}, {npc:12259}, {npc:12264} and {npc:12098} are {area:2717} bosses: each drops his hand for the quest."] = "{npc:12118}, {npc:12259}, {npc:12264} und {npc:12098} sind Bosse des {area:2717}: Jeder lässt seine Hand für die Quest fallen.",
	-- {item:17332} Hand of Shazzrah
	["{item:17332}: raid of 40"] = "{item:17332}: Schlachtzug für 40",

	-- Step 11: A Hero's Reward
	-- {object:179551} Hydraxis' Coffer · {item:17333} Aqual Quintessence · {area:2717} Molten Core · {npc:12018} Majordomo Executus · {npc:11502} Ragnaros
	["Hand in the hands, then dive under the surf at the southern foot of the island: {object:179551} holds your ring and pays the only quest reputation the Waterlords give, 200. From now on, while you are Honored or better, the Duke hands you {item:17333}: pour it on a rune in the {area:2717} to douse it. With every rune doused, {npc:12018} comes out, and after him {npc:11502}."] = "Gib die Hände ab und tauche dann unter der Brandung am Südfuß der Insel: {object:179551} enthält deinen Ring und zahlt den einzigen Quest-Ruf, den die Wasserherren geben, 200. Ab jetzt gibt dir der Herzog, solange du Wohlwollend oder besser bist, {item:17333}: Gieße es auf eine Rune im {area:2717}, um sie zu löschen. Wenn jede Rune gelöscht ist, kommt {npc:12018} heraus, und nach ihm {npc:11502}.",
	-- {item:17333} Aqual Quintessence
	["{item:17333}, ask the Duke"] = "{item:17333}, frag den Herzog",

	-- Step 12: Molten Core to Revered
	-- {area:2717} Molten Core
	["{area:2717} to Revered"] = "{area:2717} bis Respektvoll",
	-- {npc:11988} Golemagg the Incinerator · {npc:11502} Ragnaros · {npc:9017} Lord Incendius · {npc:9816} Pyroguard Emberseer
	["Honored to Revered is 12,000 reputation. The trash still counts, so a full clear pays about 3,360 plus 700 from the seven bosses, 150 from {npc:11988} and 200 from {npc:11502}: about three clears. {npc:9017} (15) and {npc:9816} (50) count too while you are Honored. The trash stops at 11,999 of 12,000 Honored; the bosses carry you over."] = "Von Wohlwollend bis Respektvoll sind es 12.000 Ruf. Der Trash zählt weiter, ein vollständiger Durchgang zahlt also etwa 3.360 plus 700 von den sieben Bossen, 150 von {npc:11988} und 200 von {npc:11502}: etwa drei Durchgänge. {npc:9017} (15) und {npc:9816} (50) zählen auch, solange du Wohlwollend bist. Der Trash hört bei 11.999 von 12.000 Wohlwollend auf; die Bosse tragen dich darüber.",
	-- {npc:12118} Lucifron
	["{npc:12118} and the other bosses, 100: they carry you past 11,999"] = "{npc:12118} und die anderen Bosse, 100: Sie tragen dich über 11.999 hinaus",

	-- Step 13: The Eternal Quintessence
	-- {item:22754} Eternal Quintessence
	["The {item:22754}"] = "Die {item:22754}",
	-- {item:22754} Eternal Quintessence · {item:17333} Aqual Quintessence
	["At Revered the Duke gives you the {item:22754}: it does the {item:17333}'s work and is not used up, so you never come back for another vial."] = "Bei Respektvoll gibt dir der Herzog die {item:22754}: Sie leistet die Arbeit des {item:17333} und wird nicht verbraucht, du musst also nie wieder eine Phiole holen.",
	-- {item:22754} Eternal Quintessence
	["{item:22754}, ask the Duke"] = "{item:22754}, frag den Herzog",

	-- Step 14: Molten Core to Exalted
	-- {area:2717} Molten Core
	["{area:2717} to Exalted"] = "{area:2717} bis Ehrfürchtig",
	-- {npc:11988} Golemagg the Incinerator · {npc:11502} Ragnaros
	["Revered to Exalted is 21,000 reputation. The trash has stopped, but all nine bosses still pay while you are Revered: 100 each from the seven, 150 from {npc:11988} and 200 from {npc:11502}, 1,050 a clear: about 20 clears. The seven stop at 20,999 of 21,000 Revered, so the last point comes from {npc:11988} or {npc:11502}, and from Exalted on only those two pay."] = "Von Respektvoll bis Ehrfürchtig sind es 21.000 Ruf. Der Trash hat aufgehört, aber alle neun Bosse zahlen weiter, solange du Respektvoll bist: je 100 von den sieben, 150 von {npc:11988} und 200 von {npc:11502}, 1.050 pro Durchgang: etwa 20 Durchgänge. Die sieben hören bei 20.999 von 21.000 Respektvoll auf, der letzte Punkt kommt also von {npc:11988} oder {npc:11502}, und ab Ehrfürchtig zahlen nur noch diese beiden.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Both elementals roam north-western {zone:1451}; the Rumblers cluster a little further north."] = "Beide Elementare streifen durch den Nordwesten von {zone:1451}; die Wüstenrumpler sammeln sich etwas weiter nördlich.",
	-- ["Bring the Hands of Lucifron, Gehennas, Shazzrah and Sulfuron from the {area:2717}."] = "Bring die Hand von Lucifron, Gehennas, Shazzrah und Sulfuron aus dem {area:2717}.",
	-- ["Dust Stormers and Desert Rumblers"] = "Staubstürmer und Wüstenrumpler",
	-- ["Keep clearing the {area:2717} until Exalted."] = "Säubere weiter den {area:2717}, bis du ehrfürchtig bist.",
	-- ["Kill a {npc:11668}, a {npc:11658}, an {npc:11673} and a {npc:12101} in the {area:2717}. Every {area:2717} elemental and boss also counts toward the Waterlords."] = "Töte einen {npc:11668}, einen {npc:11658}, einen {npc:11673} und einen {npc:12101} im {area:2717}. Jeder Elementar und Boss im {area:2717} zählt auch für die Hydraxianer.",
	-- ["Use the {item:17310} on the poisoned water elementals of {zone:1423}, then loot their {item:17309} (12)."] = "Benutze {item:17310} an den vergifteten Wasserelementaren in den {zone:1423} und plündere dann ihre {item:17309} (12).",
	-- ["Use the {item:17310} on the poisoned water elementals of {zone:1423}, then loot their {item:17309} (12). Our data has no spawn points for those elementals."] = "Benutze {item:17310} an den vergifteten Wasserelementaren in den {zone:1423} und plündere dann ihre {item:17309} (12). Unsere Daten haben keine Fundorte für diese Elementare.",
	-- ["{area:2717} clears carry the rest. Bosses always count; in Classic, trash kills stop giving Waterlords reputation partway up, so late on the bosses do the work."] = "Den Rest bringen Säuberungen des {area:2717}. Bosse zählen immer; in Classic geben normale Gegner ab einer gewissen Stufe keinen Ruf bei den Hydraxianer mehr, später erledigen also die Bosse die Arbeit.",
	-- ["{faction:749} to Exalted"] = "{faction:749} bis Ehrfürchtig",
	-- ["{faction:749} to Revered"] = "{faction:749} bis Respektvoll",
	-- ["{npc:13278} stands on a small island off the eastern coast of {zone:1447}; swim or walk the shallows out to him. The {faction:749} start out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:13278} steht auf einer kleinen Insel vor der Ostküste von {zone:1447}; schwimm oder lauf durch das seichte Wasser zu ihm. Bei {faction:749} beginnst du neutral. Der Vermächtnis-Vorteil „Diplomat“ von Forever erhöht den Rufgewinn.",
	-- ["{npc:9816} in Upper Blackrock Spire drops the {quest:6821}. This needs a raid group."] = "{npc:9816} in der Oberen Blackrockspitze lässt {quest:6821} fallen. Dafür brauchst du eine Schlachtzugsgruppe.",
	-- ["{quest:6823} needs Honored. At Honored, {npc:13278} hands out {item:17333}, used to douse the runes in the {area:2717} that summon {npc:12018}; at Revered, the reusable {item:22754}."] = "{quest:6823} erfordert Wohlwollend. Bei Wohlwollend gibt {npc:13278} {item:17333} aus, mit der du die Runen im {area:2717} löschst, die {npc:12018} beschwören; bei Respektvoll die wiederverwendbare {item:22754}.",
}
