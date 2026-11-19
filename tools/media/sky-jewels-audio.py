#!/usr/bin/env python3
"""Synthesize editable WAV sources for the four Sky Jewels sound effects."""

import math
import struct
import wave
from pathlib import Path


OUTPUT = Path(__file__).resolve().parents[2] / "data" / "local" / "sky-jewels-audio"
RATE = 32000
EFFECTS = {
	"match": [(0, 0.15, 660), (0.047, 0.17, 880), (0.095, 0.19, 1109)],
	"bonus": [(0, 0.24, 524), (0.052, 0.23, 784), (0.105, 0.25, 1047), (0.157, 0.27, 1568)],
	"win": [(0, 0.26, 523), (0.09, 0.25, 659), (0.18, 0.28, 784), (0.285, 0.36, 1047), (0.285, 0.33, 1319)],
	"miss": [(0, 0.11, 312), (0.056, 0.15, 233)],
}


def synthesize(notes):
	length = max(offset + duration for offset, duration, _ in notes)
	samples = [0.0] * (round(RATE * length) + 1)
	for offset, duration, frequency in notes:
		start = round(offset * RATE)
		for i in range(round(RATE * duration)):
			time = i / RATE
			envelope = min(1, time / 0.008) * (1 - time / duration) ** 2.5
			phase = math.tau * frequency * time
			samples[start + i] += (0.135 * math.sin(phase) + 0.036 * math.sin(phase * 2.01)) * envelope
	return struct.pack(f"<{len(samples)}h", *(round(32767 * sample) for sample in samples))


def main():
	OUTPUT.mkdir(parents=True, exist_ok=True)
	for name, notes in EFFECTS.items():
		with wave.open(str(OUTPUT / f"{name}.wav"), "wb") as output:
			output.setnchannels(1)
			output.setsampwidth(2)
			output.setframerate(RATE)
			output.writeframes(synthesize(notes))


if __name__ == "__main__":
	main()
