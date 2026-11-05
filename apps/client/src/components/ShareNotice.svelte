<script lang="ts">
	// Said once while sharing is on (on by default for a player who never
	// chose, or chosen before this version): what is shared and why, where to
	// see exactly what was sent, and the one click that stops it. It sits at
	// the foot of the main column with the toasts, over the page and never in
	// the way of it, until Got it or Stop sharing.
	import { go } from '../lib/app.svelte';
	import { api, message } from '../lib/backend';
	import { CONTRACT_URL } from '../lib/copy';
	import { rise } from '../lib/motion';
	import { toast } from '../lib/toast.svelte';
	import Glyph from './Glyph.svelte';

	let busy = $state<'stop' | 'ok' | null>(null);

	async function act(which: 'stop' | 'ok') {
		busy = which;
		try {
			if (which === 'stop') {
				await api.setSharing(false);
				toast('Sharing is off: nothing more is sent. You can turn it back on in Settings any time.');
			} else {
				await api.dismissShareNotice();
			}
		} catch (e) {
			toast(message(e), 'warning');
		} finally {
			busy = null;
		}
	}
</script>

<section class="notice" aria-labelledby="share-notice-title" in:rise={{ y: 12, duration: 280 }} out:rise={{ y: 8, duration: 160 }}>
	<div class="head">
		<Glyph name="record" size={14} color="var(--success)" />
		<h2 id="share-notice-title">You're sharing your play with Polestar</h2>
	</div>
	<p>
		As you play, the Polestar Recorder notes the quests, places, creatures and vendors you meet, and Polestar Client sends them in with no character, realm or account names. Like any website, the server
		sees your IP address.
	</p>
	<p>It's how the guides and the Forever database get better for everyone. Thank you!</p>
	<p>
		To see exactly what is sent, open <button class="link" onclick={() => go('sending')}>What we send</button> or <button class="link" onclick={() => go('activity')}>Activity</button>.
		<button class="link" onclick={() => api.openLink(CONTRACT_URL)}>The full list</button> says what never is.
	</p>
	<div class="act">
		<button class="btn primary small" disabled={busy !== null} onclick={() => act('ok')}>{#if busy === 'ok'}<span class="spinner"></span>{/if}Got it</button>
		<button class="btn small" disabled={busy !== null} onclick={() => act('stop')}>{#if busy === 'stop'}<span class="spinner"></span>{/if}Stop sharing</button>
	</div>
</section>

<style>
	.notice {
		display: flex;
		flex-direction: column;
		gap: var(--s2);
		width: 100%;
		padding: 12px 14px 14px;
		background: var(--panel);
		border: 1px solid var(--border);
		box-shadow: var(--shadowWindow);
		pointer-events: auto;
	}
	.head {
		display: flex;
		align-items: center;
		gap: var(--s2);
	}
	h2 {
		margin: 0;
		font-size: 13px;
		font-weight: 600;
		line-height: 18px;
		color: var(--text);
	}
	p {
		margin: 0;
		font-size: 12px;
		line-height: 18px;
		color: var(--textDim);
	}
	.act {
		display: flex;
		gap: var(--s2);
		margin-top: var(--s1);
	}
</style>
