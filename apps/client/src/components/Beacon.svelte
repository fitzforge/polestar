<script lang="ts">
	// The recording status as one small light: a calm breathing ring while
	// sharing is on and all is well, a turning arc while sending, still and
	// amber when something needs the player, hollow when sharing is off.
	import type { StatusKind } from '../lib/types';

	let { kind, size = 8 }: { kind: StatusKind; size?: number } = $props();

	const tone = $derived(
		kind === 'watching' ? 'ok' : kind === 'uploading' ? 'busy' : kind === 'waiting' ? 'idle' : kind === 'off' ? 'off' : 'warn',
	);
</script>

<span class="beacon {tone}" style:--size="{size}px" aria-hidden="true">
	{#if tone === 'ok'}<span class="ring"></span>{/if}
	{#if tone === 'busy'}<span class="arc"></span>{/if}
	{#key tone}<span class="core"></span>{/key}
</span>

<style>
	.beacon {
		--c: var(--textDim);
		position: relative;
		display: inline-grid;
		place-items: center;
		flex: none;
		width: calc(var(--size) * 2.25);
		height: calc(var(--size) * 2.25);
	}
	.ok {
		--c: var(--success);
	}
	.busy {
		--c: var(--accent);
	}
	.warn {
		--c: var(--warning);
	}
	.off {
		--c: var(--textMuted);
	}
	.core {
		grid-area: 1 / 1;
		width: var(--size);
		height: var(--size);
		border-radius: 50%;
		background: var(--c);
		box-shadow: 0 0 calc(var(--size) * 0.9) color-mix(in srgb, var(--c) 45%, transparent);
		animation: settle var(--slow) var(--easePop);
	}
	.off .core {
		background: none;
		box-shadow: inset 0 0 0 1.5px var(--c);
	}
	.ring,
	.arc {
		grid-area: 1 / 1;
		border-radius: 50%;
	}
	.ring {
		width: var(--size);
		height: var(--size);
		border: 1px solid var(--c);
		animation: breathe 2800ms var(--ease) infinite;
	}
	.arc {
		width: calc(var(--size) * 2);
		height: calc(var(--size) * 2);
		border: 1.5px solid color-mix(in srgb, var(--c) 18%, transparent);
		border-top-color: var(--c);
		animation: turn 900ms linear infinite;
	}
	@keyframes breathe {
		from {
			opacity: 0.9;
			transform: scale(1);
		}
		to {
			opacity: 0;
			transform: scale(2.25);
		}
	}
	@keyframes turn {
		to {
			transform: rotate(360deg);
		}
	}
	:global(.moving) .ring,
	:global(.moving) .arc,
	:global(.intro) .ring,
	:global(.intro) .arc {
		animation-play-state: paused;
	}
	@keyframes settle {
		from {
			transform: scale(0.6);
			opacity: 0.4;
		}
	}
	@media (prefers-reduced-motion: reduce) {
		.ring {
			display: none;
		}
		.arc {
			animation: none;
			border-color: color-mix(in srgb, var(--c) 45%, transparent);
		}
		.core {
			animation: none;
		}
	}
</style>
