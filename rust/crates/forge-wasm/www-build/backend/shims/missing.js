// The node: modules the planner's code requires but the browser planner never calls (worker threads,
// child processes, sockets, zlib): any use throws, naming it.

const handler = {
	get(_, k) {
		if (k === '__esModule') return false;
		if (k === 'default') return proxy;
		if (k === 'constants') return {};
		return function missing() {
			throw new Error(`${String(k)}: a Node facility the browser planner does not have`);
		};
	},
};
const proxy = new Proxy({}, handler);
export default proxy;
