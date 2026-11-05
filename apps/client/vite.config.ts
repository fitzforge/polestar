import { defineConfig } from 'vite';
import { svelte } from '@sveltejs/vite-plugin-svelte';
import { readFileSync } from 'node:fs';

const { version } = JSON.parse(readFileSync(new URL('./package.json', import.meta.url), 'utf8'));

// Tauri serves the built files itself; the dev server runs on a fixed port it knows.
export default defineConfig({
	plugins: [svelte()],
	// The intro plays in full on the first launch of each version (src/lib/intro.svelte.ts).
	define: { __APP_VERSION__: JSON.stringify(version) },
	clearScreen: false,
	server: { port: 5174, strictPort: true },
	build: { target: ['es2021', 'chrome105', 'safari15'], assetsInlineLimit: 4096 },
});
