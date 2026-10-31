<script lang="ts">
	// The frame-rate overlay: frames per second over the last second, the
	// slowest frame in it, how many frames were dropped (over 1.5× the display's
	// frame time), and how the window is drawn. It measures with
	// requestAnimationFrame only while it is shown.
	import { onMount } from 'svelte';
	import { api } from '../lib/backend';
	import { showFrames } from '../lib/diagnostics.svelte';
	import { intro } from '../lib/intro.svelte';
	import Glyph from './Glyph.svelte';

	let fps = $state(0);
	let worst = $state(0);
	let dropped = $state(0);
	let renderer = $state('…');
	let bars = $state<number[]>([]);

	onMount(() => {
		api.diagnostics().then(
			(d) => (renderer = d.renderer),
			() => (renderer = 'unknown'),
		);
		let raf = 0;
		let last = performance.now();
		let windowStart = last;
		let frames: number[] = [];
		const tick = (now: number) => {
			const dt = now - last;
			last = now;
			frames.push(dt);
			if (now - windowStart >= 1000) {
				const sorted = [...frames].sort((a, b) => a - b);
				const typical = sorted[Math.floor(sorted.length / 2)] || 16.7;
				fps = Math.round((frames.length * 1000) / (now - windowStart));
				worst = Math.round(sorted[sorted.length - 1] ?? 0);
				dropped = frames.filter((f) => f > typical * 1.5).length;
				bars = frames.slice(-60);
				frames = [];
				windowStart = now;
			}
			raf = requestAnimationFrame(tick);
		};
		raf = requestAnimationFrame(tick);
		return () => cancelAnimationFrame(raf);
	});
</script>

<div class="meter" role="status" aria-label="Frame rate">
	<div class="line">
		<span class="num big" class:bad={fps > 0 && fps < 50}>{fps}</span><span class="small muted">fps</span>
		<span class="small muted">worst</span><span class="num" class:bad={worst > 34}>{worst} ms</span>
		<span class="small muted">dropped</span><span class="num" class:bad={dropped > 2}>{dropped}</span>
		<button class="icon-btn" aria-label="Hide the frame rate" onclick={() => showFrames(false)}><Glyph name="close" size={10} /></button>
	</div>
	<svg class="graph" viewBox="0 0 60 24" preserveAspectRatio="none" aria-hidden="true">
		<line x1="0" x2="60" y1={24 - 16.7 / 2} y2={24 - 16.7 / 2} class="target" />
		{#each bars as b, i (i)}<rect x={i} width="0.8" y={24 - Math.min(24, b / 2)} height={Math.min(24, b / 2)} class:slow={b > 25} />{/each}
	</svg>
	{#if intro.stats}
		<div class="small muted intro">
			Intro ({intro.stats.mode}, {(intro.stats.ms / 1000).toFixed(1)} s): <span class="num" class:bad={intro.stats.fps < 50}>{intro.stats.fps}</span> fps, worst
			<span class="num" class:bad={intro.stats.worst > 34}>{intro.stats.worst} ms</span>, dropped <span class="num" class:bad={intro.stats.dropped > 2}>{intro.stats.dropped}</span>
		</div>
	{/if}
	<div class="small muted renderer" title={renderer}>{renderer}</div>
</div>

<style>
	.meter {
		position: fixed;
		left: 8px;
		bottom: 8px;
		z-index: 200;
		width: 260px;
		padding: 6px 8px 7px;
		background: rgba(5, 8, 15, 0.88);
		border: 1px solid var(--border);
		font-variant-numeric: tabular-nums;
		pointer-events: auto;
	}
	.line {
		display: flex;
		align-items: baseline;
		gap: 5px;
		white-space: nowrap;
	}
	.big {
		font-size: 15px;
	}
	.bad {
		color: var(--warning);
	}
	.icon-btn {
		width: 18px;
		height: 18px;
		margin-left: auto;
		font-size: 14px;
	}
	.graph {
		display: block;
		width: 100%;
		height: 24px;
		margin-top: 4px;
	}
	rect {
		fill: var(--success);
	}
	rect.slow {
		fill: var(--warning);
	}
	.target {
		stroke: var(--border);
		stroke-width: 0.3;
	}
	.intro {
		margin-top: 3px;
	}
	.intro .num {
		font-size: 11px;
		color: var(--text);
	}
	.renderer {
		margin-top: 3px;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}
</style>
