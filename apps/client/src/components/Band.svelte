<script lang="ts" module>
	// A few brighter stars that twinkle over the band's own, placed by a fixed
	// seed so they never move between launches. Positions in % of the width,
	// px from the top; brighter ones sit higher, as the band's stars thin downward.
	let seed = 7;
	const rand = () => ((seed = (seed * 16807) % 2147483647) - 1) / 2147483646;
	export const TWINKLES = Array.from({ length: 16 }, () => {
		const y = Math.pow(rand(), 1.6) * 92;
		return { x: rand() * 100, y, size: rand() < 0.25 ? 2 : 1.5, delay: rand() * -6, period: 3.2 + rand() * 3.6, peak: 0.35 + (1 - y / 92) * 0.5 };
	});
</script>

<script lang="ts">
	// The starlit header band (The Starlit Band Rule): the sky token through the
	// addon's band mask, its stars over it, both at 1:1 and cropped, never
	// stretched. `drift` turns the sky a little (px, transform only): the shell
	// passes the page's place in the sidebar, so moving between pages moves the
	// stars a touch, slower than the page itself (parallax).
	import type { Snippet } from 'svelte';
	import band from '../assets/ui/band.png';
	import stars from '../assets/ui/band-stars.png';

	let { height = 112, drift = 0, twinkle = true, children }: { height?: number; drift?: number; twinkle?: boolean; children?: Snippet } = $props();
</script>

<header class="band" style:height="{height}px" style:--mask="url({band})" style:--stars="url({stars})">
	<div class="sky" aria-hidden="true"></div>
	<div class="layer" aria-hidden="true" style:transform="translate3d({-drift}px, 0, 0)">
		<div class="stars"></div>
		{#if twinkle}
			{#each TWINKLES as s, i (i)}
				<span class="twinkle" style:left="{s.x}%" style:top="{s.y}px" style:--size="{s.size}px" style:--peak={s.peak} style:animation-delay="{s.delay}s" style:animation-duration="{s.period}s"></span>
			{/each}
		{/if}
	</div>
	{@render children?.()}
</header>

<style>
	.band {
		position: relative;
		flex: none;
		overflow: hidden;
	}
	.sky,
	.layer {
		position: absolute;
		inset: 0;
		pointer-events: none;
	}
	.sky {
		background: var(--sky);
		mask: var(--mask) 0 0 / 1024px 128px repeat-x;
		-webkit-mask: var(--mask) 0 0 / 1024px 128px repeat-x;
	}
	/* Wider than the band so a drift never shows an edge; its own GPU layer, so a
	   drift moves it without painting it again. */
	.layer {
		right: -240px;
		transition: transform 900ms var(--ease);
		will-change: transform;
	}
	.stars {
		position: absolute;
		inset: 0;
		background: var(--stars) 0 0 / 1024px 128px repeat-x;
	}
	/* A twinkling star: its glow drawn into a gradient (no shadow), its own
	   brightness set once, and only opacity animated, on the compositor. */
	.twinkle {
		position: absolute;
		width: calc(var(--size) * 4);
		height: calc(var(--size) * 4);
		margin: calc(var(--size) * -1.5) 0 0 calc(var(--size) * -1.5);
		opacity: var(--peak);
	}
	.twinkle::before {
		content: '';
		position: absolute;
		inset: 0;
		background: radial-gradient(circle, var(--star) 0 18%, rgba(219, 230, 255, 0.4) 26%, rgba(219, 230, 255, 0) 62%);
		opacity: 0.35;
		animation: twinkle ease-in-out infinite alternate;
		animation-delay: inherit;
		animation-duration: inherit;
	}
	@keyframes twinkle {
		to {
			opacity: 1;
		}
	}
	/* While a page changes or the intro plays over the app, only that moves. */
	:global(.moving) .twinkle::before,
	:global(.intro) .twinkle::before {
		animation-play-state: paused;
	}
	@media (prefers-reduced-motion: reduce) {
		.layer {
			transition: none;
		}
		.twinkle::before {
			animation: none;
			opacity: 0.7;
		}
	}
</style>
