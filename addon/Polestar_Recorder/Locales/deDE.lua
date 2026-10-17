-- German (deDE): Polestar Recorder's interface strings.
-- Keys are the English strings exactly as the code writes them; a key
-- missing here, or commented out, shows in English. Grouped by the file that
-- first uses each key. docs/TRANSLATING.md explains the rest.

local _, ns = ...
if not (GetLocale and GetLocale() == "deDE") then return end
local L = ns.L

-- Commands.lua
L["this client exposes no talent tree API"] = "dieser Client bietet keine Talentbaum-API"
L["no active talent configuration (too low level?)"] = "keine aktive Talentkonfiguration (Stufe zu niedrig?)"
L["the talent configuration has no trees"] = "die Talentkonfiguration hat keine Bäume"
L["the talent trees returned no nodes"] = "die Talentbäume lieferten keine Knoten"
L["recording %s"] = "Aufzeichnung %s"
L["on"] = "an"
L["off"] = "aus"
L["session %s: %d events (%d breadcrumbs), %d min"] = "Sitzung %s: %d Ereignisse (%d Spurpunkte), %d Min."
L["%d events dropped by the per-session caps"] = "%d Ereignisse durch die Grenzen pro Sitzung verworfen"
L["no session yet"] = "noch keine Sitzung"
L["%d sessions stored, %d maps dumped"] = "%d Sitzungen gespeichert, %d Karten gesichert"
L[", talents dumped"] = ", Talente gesichert"
L["this session: %s"] = "diese Sitzung: %s"
L["commands: /psrec on | off | mark <text> | maps | talents | legacy | factions | skills | clear"] = "Befehle: /psrec on | off | mark <Text> | maps | talents | legacy | factions | skills | clear"
L["usage: /psrec mark <text>"] = "Verwendung: /psrec mark <Text>"
L["recording is off; /psrec on first"] = "Aufzeichnung ist aus; zuerst /psrec on"
L["marked: %s"] = "markiert: %s"
L["mark not recorded (session cap reached)"] = "Markierung nicht aufgezeichnet (Sitzungsgrenze erreicht)"
L["recorded %d maps"] = "%d Karten aufgezeichnet"
L["no maps found (C_Map unavailable)"] = "keine Karten gefunden (C_Map nicht verfügbar)"
L["talents not recorded: %s"] = "Talente nicht aufgezeichnet: %s"
L["recorded %d talent nodes in %d tree(s) for %s"] = "%d Talentknoten in %d Baum/Bäumen für %s aufgezeichnet"
L["recorded %d achievements in %d categories, %d major factions (Legacy renown %s), %d Legacy tree nodes"] = "%d Erfolge in %d Kategorien, %d große Fraktionen (Vermächtnis-Ruhm %s), %d Vermächtnis-Baumknoten aufgezeichnet"
L["factions not recorded: this client exposes no C_Reputation list"] = "Fraktionen nicht aufgezeichnet: Dieser Client bietet keine C_Reputation-Liste"
L["recorded %d factions"] = "%d Fraktionen aufgezeichnet"
L["skills not recorded: this client exposes no C_SkillInfo list"] = "Fertigkeiten nicht aufgezeichnet: Dieser Client bietet keine C_SkillInfo-Liste"
L["recorded %d skill lines"] = "%d Fertigkeitslinien aufgezeichnet"
L["all recordings cleared; new session %s"] = "alle Aufzeichnungen gelöscht; neue Sitzung %s"
L["this deletes every recorded session. Type |cffffd100/psrec clear confirm|r within %d seconds to proceed."] = "Das löscht jede aufgezeichnete Sitzung. Gib innerhalb von %d Sekunden |cffffd100/psrec clear confirm|r ein, um fortzufahren."
L["unknown command: %s"] = "unbekannter Befehl: %s"
L["factions"] = "Fraktionen"
L["skills"] = "Fertigkeiten"
L["legacy"] = "Vermächtnis"
