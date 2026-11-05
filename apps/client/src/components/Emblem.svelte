<script lang="ts">
	// The Polestar emblem (docs/assets/emblem.svg), in the accent.
	// `target`: where the launch intro's star lands (lib/intro.svelte.ts).
	let { size = 36, glow = false, target = false }: { size?: number; glow?: boolean; target?: boolean } = $props();
</script>

<svg class:glow data-intro-target={target ? '' : undefined} width={size} height={size} viewBox="0 0 128 128" aria-hidden="true">
	<path
		fill="var(--accent)"
		d="M71 19.24A45.3 45.3 0 0 1 71 108.76L71 106.12A42.7 42.7 0 0 0 71 21.88ZM57 19.24A45.3 45.3 0 0 0 57 108.76L57 106.12A42.7 42.7 0 0 1 57 21.88ZM64 4L71.5 56.5L94 64L71.5 71.5L64 124L56.5 71.5L34 64L56.5 56.5Z"
	/>
</svg>

<style>
	svg {
		flex: none;
		display: block;
	}
	/* The Starlight Rule: only the guiding marks glow. */
	.glow {
		filter: drop-shadow(0 0 10px rgba(230, 186, 102, 0.35));
	}
</style>
