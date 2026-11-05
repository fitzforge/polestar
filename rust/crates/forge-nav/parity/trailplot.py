"""Recorded trails against each backend's walk (trailcmp.js output): top-down lines over the trail, and height
along each line. python3 trailplot.py <cmp.json> <out dir>"""
import json, os, sys
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

rows = json.load(open(sys.argv[1]))
OUT = sys.argv[2]
STYLE = {
	"grid": ("#f0f0f0", 2.4, "-"),
	"leffe": ("#ff3b6b", 1.6, "-"),
	"hybrid": ("#ffd33d", 1.0, "--"),
	"v0.2.6": ("#29d3ff", 1.6, ":"),
	"next": ("#9b7bff", 1.2, "-."),
}


def xy(pts):
	a = np.array([[p[0], p[1]] for p in pts], float)
	return -a[:, 1], a[:, 0]  # east right, north up


for r in rows:
	fig, (ax, az) = plt.subplots(1, 2, figsize=(15, 7.5), gridspec_kw={"width_ratios": [1.15, 1]})
	for a in (ax, az):
		a.set_facecolor("#1b1b1b")
	X, Y = xy(r["trail"]["points"])
	ax.plot(X, Y, "o", ms=4, color="#34d058", label=f"Fitz's trail ({r['trail']['seconds']:.0f} s)", zorder=5)
	lines = []
	for name, s in r["backends"].items():
		col, lw, ls = STYLE.get(name, ("#aaaaaa", 1.2, "-"))
		if not s["ok"]:
			lines.append(f"{name}: no way ({s.get('reason')})")
			continue
		Xs, Ys = xy(s["pts"])
		ax.plot(Xs, Ys, color=col, lw=lw, ls=ls, label=name, alpha=0.95)
		d = np.concatenate([[0], np.cumsum(np.hypot(np.diff(Xs), np.diff(Ys)))])
		z = [p[2] if p[2] is not None else np.nan for p in s["pts"]]
		az.plot(d, z, color=col, lw=lw, ls=ls, label=name)
		via = f" ({s['via']})" if s.get("via") else ""
		lines.append(f"{name}{via}: {s['yards']:.0f} yd, {s['seconds']:.1f} s, {s['points']} pts, z {s['minZ']:.0f}-{s['maxZ']:.0f}, trail strays max {s['stray']['max']:.1f} yd (mean {s['stray']['mean']:.1f})")
	ax.plot(-r["from"][1], r["from"][0], marker="o", ms=10, mfc="#34d058", mec="k", zorder=6)
	ax.plot(-r["to"][1], r["to"][0], marker="*", ms=15, mfc="#ffd33d", mec="k", zorder=6)
	# Frame the trail, not the detours.
	pad = 25
	ax.set_xlim(min(X) - pad, max(X) + pad)
	ax.set_ylim(min(Y) - pad, max(Y) + pad)
	ax.set_aspect("equal")
	ax.set_xticks([]); ax.set_yticks([])
	ax.set_title("top-down (north up), framed on the trail", fontsize=9)
	ax.legend(loc="upper left", fontsize=8, facecolor="#333333", labelcolor="w")
	az.set_title("height along each line (yd)", fontsize=9)
	az.set_xlabel("yards along the line")
	az.set_xlim(0, max(150, r["trail"]["yards2d"] * 1.6))
	az.legend(loc="lower right", fontsize=8, facecolor="#333333", labelcolor="w")
	fig.suptitle(r["title"], fontsize=12, fontweight="bold")
	fig.text(0.5, 0.02, "\n".join(lines), ha="center", fontsize=8.5, family="monospace")
	fig.subplots_adjust(bottom=0.2, top=0.9, wspace=0.12)
	fig.savefig(os.path.join(OUT, r["id"] + ".png"), dpi=110)
	plt.close(fig)
print("wrote", len(rows))
