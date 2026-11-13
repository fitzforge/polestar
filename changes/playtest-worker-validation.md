---
section: contributors
---
- Playtests reject invalid worker counts instead of silently leaving guides
  unplayed. Explicit worker settings must be positive whole numbers, including
  `POLESTAR_PLAY_WORKERS`: empty, whitespace-only, zero, nonnumeric, negative,
  fractional and infinite values now fail instead of using a default or an
  invalid pool size. Leave the variable unset to use the default. Honest
  playtests use no workers and ignore this setting (thanks PRDesrochers, and shacklef00rd, #2146).
