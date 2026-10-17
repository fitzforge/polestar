-- Spanish (Spain) (esES): Polestar Recorder's interface strings.
-- Keys are the English strings exactly as the code writes them; a key
-- missing here, or commented out, shows in English. Grouped by the file that
-- first uses each key. docs/TRANSLATING.md explains the rest.

local _, ns = ...
if not (GetLocale and GetLocale() == "esES") then return end
local L = ns.L

-- Commands.lua
L["this client exposes no talent tree API"] = "este cliente no ofrece API de árbol de talentos"
L["no active talent configuration (too low level?)"] = "no hay configuración de talentos activa (¿nivel demasiado bajo?)"
L["the talent configuration has no trees"] = "la configuración de talentos no tiene árboles"
L["the talent trees returned no nodes"] = "los árboles de talentos no devolvieron nodos"
L["recording %s"] = "grabación %s"
L["on"] = "activada"
L["off"] = "desactivada"
L["session %s: %d events (%d breadcrumbs), %d min"] = "sesión %s: %d eventos (%d migas de pan), %d min"
L["%d events dropped by the per-session caps"] = "%d eventos descartados por los límites por sesión"
L["no session yet"] = "aún no hay sesión"
L["%d sessions stored, %d maps dumped"] = "%d sesiones guardadas, %d mapas volcados"
L[", talents dumped"] = ", talentos volcados"
L["this session: %s"] = "esta sesión: %s"
L["commands: /psrec on | off | mark <text> | maps | talents | legacy | factions | skills | clear"] = "comandos: /psrec on | off | mark <texto> | maps | talents | legacy | factions | skills | clear"
L["usage: /psrec mark <text>"] = "uso: /psrec mark <texto>"
L["recording is off; /psrec on first"] = "la grabación está desactivada; primero /psrec on"
L["marked: %s"] = "marcado: %s"
L["mark not recorded (session cap reached)"] = "marca no grabada (límite de sesión alcanzado)"
L["recorded %d maps"] = "%d mapas grabados"
L["no maps found (C_Map unavailable)"] = "no se encontraron mapas (C_Map no disponible)"
L["talents not recorded: %s"] = "talentos no grabados: %s"
L["recorded %d talent nodes in %d tree(s) for %s"] = "%d nodos de talento grabados en %d árbol(es) para %s"
L["recorded %d achievements in %d categories, %d major factions (Legacy renown %s), %d Legacy tree nodes"] = "%d logros grabados en %d categorías, %d facciones principales (renombre de Legado %s), %d nodos del árbol de Legado"
L["factions not recorded: this client exposes no C_Reputation list"] = "facciones no grabadas: este cliente no ofrece lista de C_Reputation"
L["recorded %d factions"] = "%d facciones grabadas"
L["skills not recorded: this client exposes no C_SkillInfo list"] = "habilidades no grabadas: este cliente no ofrece lista de C_SkillInfo"
L["recorded %d skill lines"] = "%d líneas de habilidad grabadas"
L["all recordings cleared; new session %s"] = "todas las grabaciones borradas; nueva sesión %s"
L["this deletes every recorded session. Type |cffffd100/psrec clear confirm|r within %d seconds to proceed."] = "esto borra todas las sesiones grabadas. Escribe |cffffd100/psrec clear confirm|r en %d segundos para continuar."
L["unknown command: %s"] = "comando desconocido: %s"
L["factions"] = "facciones"
L["skills"] = "habilidades"
L["legacy"] = "legado"
