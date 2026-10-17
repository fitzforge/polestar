-- French (frFR): Polestar Recorder's interface strings.
-- Keys are the English strings exactly as the code writes them; a key
-- missing here, or commented out, shows in English. Grouped by the file that
-- first uses each key. docs/TRANSLATING.md explains the rest.

local _, ns = ...
if not (GetLocale and GetLocale() == "frFR") then return end
local L = ns.L

-- Commands.lua
L["this client exposes no talent tree API"] = "ce client n'expose aucune API d'arbre de talents"
L["no active talent configuration (too low level?)"] = "aucune configuration de talents active (niveau trop bas ?)"
L["the talent configuration has no trees"] = "la configuration de talents n'a aucun arbre"
L["the talent trees returned no nodes"] = "les arbres de talents n'ont renvoyé aucun nœud"
L["recording %s"] = "enregistrement %s"
L["on"] = "activé"
L["off"] = "désactivé"
L["session %s: %d events (%d breadcrumbs), %d min"] = "session %s : %d événements (%d repères de parcours), %d min"
L["%d events dropped by the per-session caps"] = "%d événements ignorés à cause des limites par session"
L["no session yet"] = "aucune session pour l'instant"
L["%d sessions stored, %d maps dumped"] = "%d sessions stockées, %d cartes exportées"
L[", talents dumped"] = ", talents exportés"
L["this session: %s"] = "cette session : %s"
L["commands: /psrec on | off | mark <text> | maps | talents | legacy | factions | skills | clear"] = "commandes : /psrec on | off | mark <texte> | maps | talents | legacy | factions | skills | clear"
L["usage: /psrec mark <text>"] = "utilisation : /psrec mark <texte>"
L["recording is off; /psrec on first"] = "l'enregistrement est désactivé ; faites d'abord /psrec on"
L["marked: %s"] = "marqué : %s"
L["mark not recorded (session cap reached)"] = "marque non enregistrée (limite de session atteinte)"
L["recorded %d maps"] = "%d cartes enregistrées"
L["no maps found (C_Map unavailable)"] = "aucune carte trouvée (C_Map indisponible)"
L["talents not recorded: %s"] = "talents non enregistrés : %s"
L["recorded %d talent nodes in %d tree(s) for %s"] = "%d nœuds de talent enregistrés dans %d arbre(s) pour %s"
L["recorded %d achievements in %d categories, %d major factions (Legacy renown %s), %d Legacy tree nodes"] = "%d hauts faits enregistrés dans %d catégories, %d factions majeures (renom Héritage %s), %d nœuds de l'arbre Héritage"
L["factions not recorded: this client exposes no C_Reputation list"] = "factions non enregistrées : ce client n'expose aucune liste C_Reputation"
L["recorded %d factions"] = "%d factions enregistrées"
L["skills not recorded: this client exposes no C_SkillInfo list"] = "compétences non enregistrées : ce client n'expose aucune liste C_SkillInfo"
L["recorded %d skill lines"] = "%d lignes de compétence enregistrées"
L["all recordings cleared; new session %s"] = "tous les enregistrements effacés ; nouvelle session %s"
L["this deletes every recorded session. Type |cffffd100/psrec clear confirm|r within %d seconds to proceed."] = "ceci supprime toutes les sessions enregistrées. Tapez |cffffd100/psrec clear confirm|r dans les %d secondes pour continuer."
L["unknown command: %s"] = "commande inconnue : %s"
L["factions"] = "factions"
L["skills"] = "compétences"
L["legacy"] = "héritage"
