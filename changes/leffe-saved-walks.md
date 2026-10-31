---
section: forge
---
- Leffe's navigation maps are private: the data pack no longer carries
  them, and `forge data pack` refuses a pack that holds them. It carries the
  walks his maps answered instead (`walks/store-leffe-*.psbn`, with each
  place's zone on his maps), and `forge build` without his maps runs the
  hybrid on those saved walks, with our grid for the walks they lack and for
  the legs. `forge doctor` shows which you have.
- A release build (`forge build --strict`) refuses to walk on our grid alone,
  and every report's first line names the walking maps the build used.
