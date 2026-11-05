<script lang="ts">
	import { app, go, SCREENS } from './lib/app.svelte';
	import { diagnostics, showFrames } from './lib/diagnostics.svelte';
	import FrameMeter from './components/FrameMeter.svelte';
	import { fade, page } from './lib/motion';
	import Sidebar from './components/Sidebar.svelte';
	import Band from './components/Band.svelte';
	import TitleBar from './components/TitleBar.svelte';
	import Toaster from './components/Toaster.svelte';
	import Emblem from './components/Emblem.svelte';
	import Setup from './screens/Setup.svelte';
	import Addons from './screens/Addons.svelte';
	import Community from './screens/Community.svelte';
	import Home from './screens/Home.svelte';
	import Activity from './screens/Activity.svelte';
	import Sending from './screens/Sending.svelte';
	import Settings from './screens/Settings.svelte';
	import OptIn from './components/OptIn.svelte';
	import Glyph from './components/Glyph.svelte';

	/** The sky turns a little with each page down the sidebar. */
	const drift = $derived(SCREENS.indexOf(app.screen) * 48);

	/** An address's host, as the banner names it. */
	function host(url: string): string {
		try {
			return new URL(url).host || url;
		} catch {
			return url;
		}
	}
	/** Not the default community site or recording server: said on every page, and can't be dismissed. */
	const custom = $derived(
		app.snapshot
			? [
					app.snapshot.custom.community && `Using a custom community site: ${host(app.snapshot.custom.community)}`,
					app.snapshot.custom.server && `Sending recordings to a custom server: ${host(app.snapshot.custom.server)}`,
				].filter((line): line is string => !!line)
			: [],
	);
</script>

{#snippet pageFault(error: unknown, reset: () => void)}
	<div class="page-fault">
		<h1>This page hit a problem</h1>
		<p class="note">The rest of Polestar Client still works. Try the page again; if it keeps happening, copy the details into a report.</p>
		<pre class="selectable">{error instanceof Error ? `${error.message}\n\n${error.stack ?? ''}` : String(error)}</pre>
		<div><button class="btn primary" onclick={reset}>Try again</button></div>
	</div>
{/snippet}

<svelte:window
	onkeydown={(e) => {
		if (e.ctrlKey && e.shiftKey && e.key.toLowerCase() === 'f') {
			e.preventDefault();
			showFrames(!diagnostics.frames);
		}
	}}
/>

<TitleBar />
{#if diagnostics.frames}<FrameMeter />{/if}

<div class="frame">
{#if !app.snapshot}
	<div class="starting" out:fade={{ duration: 160 }}>
		<Band height={600} />
		<div class="starting-mark"><Emblem size={44} glow /></div>
	</div>
{:else if !app.snapshot.setupDone}
	<div class="whole" in:fade={{ duration: 200 }} out:fade={{ duration: 140 }}>
		<svelte:boundary failed={pageFault}><Setup snapshot={app.snapshot} /></svelte:boundary>
	</div>
{:else}
	<div class="shell" in:fade={{ duration: 240 }}>
		<Sidebar snapshot={app.snapshot} />
		<main>
			<div class="sky"><Band {drift} /></div>
			{#key app.screen}
				<div class="page" in:page={{ dir: app.dir }}>
					<svelte:boundary failed={pageFault}>
						{#if app.screen === 'addons'}
							<Addons snapshot={app.snapshot} />
						{:else if app.screen === 'community'}
							<Community snapshot={app.snapshot} />
						{:else if (app.screen === 'home' || app.screen === 'sending') && !app.snapshot.consent}
							<OptIn snapshot={app.snapshot} />
						{:else if app.screen === 'home'}
							<Home snapshot={app.snapshot} />
						{:else if app.screen === 'activity'}
							<Activity snapshot={app.snapshot} />
						{:else if app.screen === 'sending'}
							<Sending snapshot={app.snapshot} />
						{:else}
							<Settings snapshot={app.snapshot} />
						{/if}
					</svelte:boundary>
				</div>
			{/key}
			<Toaster />
		</main>
	</div>
{/if}
{#if custom.length > 0}
	<div class="custom" role="status">
		<Glyph name="info" size={13} color="var(--warning)" />
		<p class="small">{custom.join(' · ')}</p>
		{#if app.snapshot?.setupDone}
			<button class="link small" onclick={() => go('settings')}>Settings</button>
		{/if}
	</div>
{/if}
</div>

<style>
	.frame {
		display: flex;
		flex-direction: column;
		height: 100%;
	}
	.frame > :not(.custom) {
		flex: 1;
		min-height: 0;
	}
	.custom {
		display: flex;
		align-items: center;
		gap: var(--s2);
		flex: none;
		min-height: 28px;
		padding: 4px var(--s4);
		background: var(--chipWarning);
		border-top: 1px solid rgba(250, 191, 77, 0.3);
		color: var(--warning);
	}
	.custom p {
		flex: 1;
		min-width: 0;
		margin: 0;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}
	.shell {
		display: grid;
		grid-template-columns: 216px minmax(0, 1fr);
		height: 100%;
	}
	main {
		position: relative;
		min-width: 0;
		overflow: hidden;
		background: var(--bg);
	}
	.sky {
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
	}
	.page {
		position: absolute;
		inset: 0;
		display: flex;
		flex-direction: column;
		contain: layout paint style;
	}
	.whole {
		height: 100%;
	}
	.starting {
		position: relative;
		height: 100%;
		overflow: hidden;
	}
	.starting-mark {
		position: absolute;
		inset: 0;
		display: grid;
		place-items: center;
		animation: wake 1600ms var(--ease) infinite alternate;
	}
	:global(.intro) .starting-mark {
		animation-play-state: paused;
	}
	@keyframes wake {
		from {
			opacity: 0.45;
			transform: scale(0.96);
		}
	}
	.page-fault {
		display: flex;
		flex-direction: column;
		gap: 12px;
		height: 100%;
		padding: var(--band) var(--edge) var(--s6);
	}
	.page-fault h1 {
		margin: 0;
		font-size: 18px;
		font-weight: 600;
	}
	.page-fault p {
		margin: 0;
		max-width: 60ch;
	}
	.page-fault pre {
		flex: 1;
		margin: 0;
		padding: 12px 14px;
		overflow: auto;
		background: var(--inset);
		border: 1px solid var(--border);
		color: var(--textDim);
		font: 400 11.5px/1.55 ui-monospace, 'SF Mono', 'Cascadia Mono', 'DejaVu Sans Mono', monospace;
		white-space: pre-wrap;
		text-shadow: none;
	}
	@media (prefers-reduced-motion: reduce) {
		.starting-mark {
			animation: none;
		}
	}
</style>
