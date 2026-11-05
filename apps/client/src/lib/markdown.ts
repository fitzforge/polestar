// Release notes as safe HTML: everything is escaped first, then a small set
// of Markdown (headings, lists, quotes, code, bold, italics, https links) is
// turned into tags this file writes itself. Links carry `data-link` and are
// opened through the backend, never by the page.

const ESC: Record<string, string> = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' };
const escape = (s: string) => s.replace(/[&<>"']/g, (c) => ESC[c]);

function inline(text: string): string {
	return escape(text)
		.replace(/`([^`]+)`/g, '<code>$1</code>')
		.replace(/\*\*([^*]+)\*\*/g, '<strong>$1</strong>')
		.replace(/(^|[\s(])[*_]([^*_\s][^*_]*)[*_]/g, '$1<em>$2</em>')
		.replace(/\[([^\]]+)\]\((?:&lt;)?(https:\/\/[^\s)]+?)(?:&gt;)?\)/g, '<a href="$2" data-link>$1</a>');
}

export function renderMarkdown(source: string): string {
	const out: string[] = [];
	let list: 'ul' | 'ol' | null = null;
	let paragraph: string[] = [];
	let code: string[] | null = null;
	const flush = () => {
		if (paragraph.length) out.push(`<p>${inline(paragraph.join(' '))}</p>`);
		paragraph = [];
	};
	const closeList = () => {
		if (list) out.push(`</${list}>`);
		list = null;
	};
	for (const raw of source.replace(/\r\n?/g, '\n').split('\n')) {
		if (code) {
			if (raw.trim().startsWith('```')) {
				out.push(`<pre><code>${escape(code.join('\n'))}</code></pre>`);
				code = null;
			} else code.push(raw);
			continue;
		}
		const line = raw.trimEnd();
		if (line.trim().startsWith('```')) {
			flush();
			closeList();
			code = [];
			continue;
		}
		const heading = /^(#{1,4})\s+(.*)$/.exec(line);
		const bullet = /^\s*[-*+]\s+(.*)$/.exec(line);
		const numbered = /^\s*\d+[.)]\s+(.*)$/.exec(line);
		const quote = /^>\s?(.*)$/.exec(line);
		if (!line.trim()) {
			flush();
			closeList();
		} else if (heading) {
			flush();
			closeList();
			const level = Math.min(4, heading[1].length + 1);
			out.push(`<h${level}>${inline(heading[2])}</h${level}>`);
		} else if (bullet || numbered) {
			flush();
			const kind = bullet ? 'ul' : 'ol';
			if (list !== kind) {
				closeList();
				out.push(`<${kind}>`);
				list = kind;
			}
			out.push(`<li>${inline((bullet ?? numbered)![1])}</li>`);
		} else if (quote) {
			flush();
			closeList();
			out.push(`<blockquote>${inline(quote[1])}</blockquote>`);
		} else if (list && /^\s{2,}\S/.test(raw)) {
			// A wrapped list item continues the last item.
			out[out.length - 1] = out[out.length - 1].replace(/<\/li>$/, ` ${inline(line.trim())}</li>`);
		} else {
			closeList();
			paragraph.push(line.trim());
		}
	}
	if (code) out.push(`<pre><code>${escape(code.join('\n'))}</code></pre>`);
	flush();
	closeList();
	return out.join('\n');
}
