# Route simulation

Polestar's routes are now made by **Polestar Forge**, the Rust pipeline: start at
[FORGE.md](FORGE.md).

| Was here | Now |
|---|---|
| the world model, solo filter, walks and travel | [forge/data.md](forge/data.md), [forge/nav.md](forge/nav.md) |
| the character and time model, parameters, robustness | [forge/model.md](forge/model.md) |
| search, route rules, the shared route, keeping the guides' fixes | [forge/routes.md](forge/routes.md) |
| writing guides from a route, scoring them | [forge/writer.md](forge/writer.md), [forge/judge.md](forge/judge.md) |

The description of the older JavaScript simulator (`node tools/polestar.js sim`, `tools/lib/sim/`),
which made the routes of releases up to 0.2.x and which the JavaScript code still refers to, is kept
unchanged in [legacy/SIMULATION-js.md](legacy/SIMULATION-js.md). Of its commands only `sim compare`
remains; the rest were retired for Forge (`forge sim`, `forge walks`, `forge judge`, `forge build`).
