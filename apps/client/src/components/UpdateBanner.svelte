<script lang="ts">
	// A Client update, said across the top of every page with the one click
	// that installs it. It sits in the window's 32px title strip over the
	// main column (over the whole window during setup), so it takes no room
	// from the page and is there whatever page is open; the strip around it
	// still drags the window. Update to <version> downloads, checks and
	// installs the update, then the app restarts on it. Settings > About keeps
	// the same button. Gone once this is the newest Client.
	import { api } from '../lib/backend';
	import { rise } from '../lib/motion';
	import { releaseUrl } from '../lib/notices';
	import { clientUpdate, installClientUpdate } from '../lib/update.svelte';
	import Glyph from './Glyph.svelte';
	import { MAC } from './TitleBar.svelte';

	let { version, shell }: { version: string; shell: boolean } = $props();
</script>

<div class="strip" class:shell class:mac={MAC}>
	<div class="banner" role="status" in:rise={{ y: -6, duration: 240 }}>
		<Glyph name="star" size={12} color="var(--accent)" />
		{#if clientUpdate.error}
			<span class="text warn selectable" title={clientUpdate.error}>The update didn't install: {clientUpdate.error}</span>
		{:else}
			<span class="text">A new Polestar Client is ready</span>
		{/if}
		<button class="link small" onclick={() => api.openLink(releaseUrl(version))}>What's new</button>
		<button class="btn primary small" disabled={clientUpdate.busy} onclick={installClientUpdate}>
			{#if clientUpdate.busy}<span class="spinner"></span>Updating…{:else if clientUpdate.error}Try again{:else}Update to {version}{/if}
		</button>
	</div>
</div>

<style>
	/* Over the title strip (TitleBar, z-index 50), clear of the window's controls at its right. */
	.strip {
		position: absolute;
		top: 0;
		left: 0;
		right: 88px;
		z-index: 51;
		display: flex;
		align-items: center;
		justify-content: center;
		height: var(--titlebar);
		padding: 0 var(--s2);
		pointer-events: none;
		transition: opacity var(--slow) var(--ease);
	}
	/* The intro (index.html, z-index 45) plays over the app: the banner waits for it to hand over. */
	:global(.intro) .strip {
		opacity: 0;
		visibility: hidden;
	}
	.strip.shell {
		left: 216px;
	}
	.strip.mac {
		right: 0;
		height: 28px;
	}
	.banner {
		display: flex;
		align-items: center;
		gap: var(--s2);
		min-width: 0;
		height: 26px;
		padding: 0 1px 0 10px;
		background: linear-gradient(var(--accentWash), var(--accentWash)), var(--panel);
		border: 1px solid var(--chipAccent);
		pointer-events: auto;
	}
	.text {
		min-width: 0;
		overflow: hidden;
		font-size: 12px;
		font-weight: 500;
		color: var(--text);
		text-overflow: ellipsis;
		white-space: nowrap;
	}
	.warn {
		color: var(--warning);
	}
	.link {
		flex: none;
	}
	.btn {
		flex: none;
	}
</style>
