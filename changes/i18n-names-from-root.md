---
section: contributors
---
- `forge i18n guides check` and `sync`, and the guide compile's translation
  warnings, read which objects have a name in a language from the names addon
  of the checkout they work on (`--root`), not of the folder forge was built
  in. A forge built elsewhere (the post-merge gates' cached one) found no
  names there and failed every translation that writes an unnamed object as
  words.
