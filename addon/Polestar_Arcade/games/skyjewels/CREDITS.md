# Sky Jewels credits

RikyZ90 contributed Sky Jewels to Polestar, one of the games in Polestar's
Arcade (`Polestar_Arcade`). The original Sky Jewels contributions are
distributed under the GNU General Public License, version 3. See the
[repository licence](../../../../LICENSE), included with the main Polestar
addon.

- **Artwork.** The six jewels and six zone backdrops were created for Sky
  Jewels with OpenAI ImageGen and prepared for the game by RikyZ90. Under
  OpenAI's terms, the user owns the output as between the user and OpenAI to
  the extent permitted by applicable law. See the Content section of the
  [OpenAI Europe Terms of Use](https://openai.com/policies/eu-terms-of-use/).
- **Sound effects.** The four original chimes were synthesized for Sky Jewels
  from sine waves and envelopes, without samples from other works.

## Building the media

The editable PNGs are in `tools/media/art/sky-jewels/`. From the repository root,
run `node tools/polestar.js media sky-jewels` to write the 64×64 jewel textures
and 256×256 backdrops to `addon/Polestar_Arcade/games/skyjewels/Media/`.

Run `python tools/media/sky-jewels-audio.py` to synthesize the four editable
WAV sources in `data/local/sky-jewels-audio/`. To encode them for the addon
with FFmpeg (`libvorbis`), use this command for each of `match`, `bonus`,
`miss` and `win`:

```sh
ffmpeg -i data/local/sky-jewels-audio/match.wav -c:a libvorbis -q:a 4 \
  -fflags +bitexact addon/Polestar_Arcade/games/skyjewels/Media/match.ogg
```
