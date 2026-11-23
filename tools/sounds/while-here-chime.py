#!/usr/bin/env python3
# The "While you're here" chime, addon/Polestar/Media/Sounds/while-here.ogg
# ("star twinkle"; UI/WhileHere.lua plays it). Made for Polestar: synthesized,
# no third-party source. Three quick rising glass-bell notes, E6, G#6 and B6,
# 75 ms apart, each with bell partials at 1, 2.76 and 5.4 times its pitch, and
# a light reverb, normalized to a -12 dB peak; then trimmed to 0.9 s with a
# soft fade, mono, 44.1 kHz Ogg Vorbis.
#
# Needs numpy and ffmpeg with libvorbis.
#   python3 tools/sounds/while-here-chime.py [out.ogg]
import os
import subprocess
import sys
import tempfile
import wave

import numpy as np

SR = 48000
ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
OUT = sys.argv[1] if len(sys.argv) > 1 else os.path.join(ROOT, "addon", "Polestar", "Media", "Sounds", "while-here.ogg")
LENGTH = 1.2  # seconds synthesized
TRIM, FADE = 0.9, 0.3  # seconds kept, and the fade-out ending them


def env(n, a=0.004, d=0.35):
	t = np.arange(n) / SR
	return np.minimum(1, t / a) * np.exp(-t / d)


def tone(f, dur, d=0.35, partials=((1, 1),)):
	n = int(SR * dur)
	t = np.arange(n) / SR
	s = np.zeros(n)
	for m, amp in partials:
		s += amp * np.sin(2 * np.pi * f * m * t)
	return s * env(n, d=d)


def place(buf, s, at):
	i = int(at * SR)
	buf[i:i + len(s)] += s[:len(buf) - i]
	return buf


def reverb(x, mix=0.25):
	y = x.copy()
	for dl, g in ((0.029, 0.5), (0.037, 0.45), (0.053, 0.35), (0.071, 0.3), (0.097, 0.2)):
		k = int(dl * SR)
		y[k:] += g * x[:-k]
	return (1 - mix) * x + mix * y


BELL = ((1, 1), (2.76, 0.35), (5.4, 0.12))

x = np.zeros(int(SR * LENGTH))
for i, f in enumerate((1318.5, 1661.2, 1975.5)):
	place(x, tone(f, 0.9, 0.28, BELL) * (0.8 + 0.1 * i), i * 0.075)
x = reverb(x, 0.35)
fade = int(0.05 * SR)
x[-fade:] *= np.linspace(1, 0, fade)
x = x / np.max(np.abs(x)) * 10 ** (-12 / 20)

with tempfile.TemporaryDirectory() as tmp:
	wav = os.path.join(tmp, "chime.wav")
	with wave.open(wav, "wb") as w:
		w.setnchannels(1)
		w.setsampwidth(2)
		w.setframerate(SR)
		w.writeframes((x * 32767).astype(np.int16).tobytes())
	subprocess.run(
		["ffmpeg", "-y", "-loglevel", "error", "-i", wav, "-af", f"atrim=0:{TRIM},afade=t=out:st={TRIM - FADE}:d={FADE}",
			"-ac", "1", "-ar", "44100", "-c:a", "libvorbis", "-q:a", "5", OUT],
		check=True,
	)
print(OUT)
