//! The HTTP clients, and the fallback ladder for a PC where the normal connection to the recording
//! server fails.
//!
//! Every request goes out the normal way first: the system's DNS, its certificate checks and its
//! proxy settings. Only requests to the recording server walk the ladder, and only when the normal
//! way cannot connect (DNS, the connection itself, or TLS): IPv4 only; Polestar Client's own list
//! of certificate authorities added to the system's (only when the server's certificate came from
//! an authority the system doesn't know: the system still checks it, revocation and distrust
//! included); its own DNS lookup of the Polestar hosts (DNS over HTTPS to Cloudflare and Google).
//! The first rung that connects is used for the rest of the run, for the recording server only
//! (the next start tries the normal way again). When the environment's proxy itself can't be
//! reached, that one request goes without it; that is never kept. Certificates are always checked.

use std::future::Future;
use std::net::SocketAddr;
use std::sync::atomic::{AtomicUsize, Ordering};
use std::sync::{Arc, Mutex};
use std::time::Duration;

use reqwest::dns::{Addrs, Name, Resolve, Resolving};
use reqwest::redirect::Policy;
use rustls::CertificateError;

/// One way of connecting to the recording server.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Rung {
	/// The system's DNS, certificate checks and proxy.
	Normal,
	/// Only IPv4 addresses (a PC whose IPv6 is broken).
	Ipv4,
	/// The bundled Mozilla certificate authorities added to the system's, which still checks the
	/// certificate (an old, odd or missing store).
	BundledRoots,
	/// DNS over HTTPS to Cloudflare and Google for the Polestar hosts (a PC whose own DNS fails).
	OwnDns,
}

pub const LADDER: [Rung; 4] = [Rung::Normal, Rung::Ipv4, Rung::BundledRoots, Rung::OwnDns];

impl Rung {
	/// What the status says while this rung is in use.
	pub fn note(self) -> Option<&'static str> {
		match self {
			Rung::Normal => None,
			Rung::Ipv4 => Some("Connected using IPv4 only: this PC's IPv6 connection doesn't reach the server."),
			Rung::BundledRoots => {
				Some("Connected with Polestar Client's own list of certificate authorities added to this PC's: this PC's list doesn't know the one that signed the server's certificate.")
			}
			Rung::OwnDns => Some("Connected using Polestar Client's own DNS lookup (DNS over HTTPS to Cloudflare and Google): this PC's DNS couldn't find the server."),
		}
	}
}

/// The kind of client: the recording server (no redirects, https only), addon releases and
/// updates on GitHub (https only), or the community site (redirects only within its origin).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Family {
	Server,
	Api,
	Packs,
}

/// Makes the recording server's client of a rung; `proxy` false: without the environment's proxy.
type Make = dyn Fn(Rung, bool) -> Result<reqwest::Client, String> + Send + Sync;

/// Whether the proxy the recording server's requests go through can't be reached at all.
type ProxyDead = dyn Fn() -> Option<std::pin::Pin<Box<dyn Future<Output = bool> + Send>>> + Send + Sync;

pub struct Net {
	/// The recording server's rung in use: an index in [`LADDER`].
	current: AtomicUsize,
	server: Mutex<[Option<reqwest::Client>; 4]>,
	/// The GitHub and community site clients (normal, or with the bundled authorities added when
	/// the system has none at all).
	others: Mutex<[Option<reqwest::Client>; 2]>,
	make: Box<Make>,
	/// None: no proxy of the environment's applies to the recording server.
	proxy_dead: Box<ProxyDead>,
}

impl Net {
	pub fn new() -> Net {
		Net::with(Box::new(|rung, proxy| build(rung, Family::Server, proxy)), Box::new(|| env_proxy().map(|p| Box::pin(proxy_unreachable(p)) as _)))
	}

	pub fn with(make: Box<Make>, proxy_dead: Box<ProxyDead>) -> Net {
		Net { current: AtomicUsize::new(0), server: Mutex::new(Default::default()), others: Mutex::new(Default::default()), make, proxy_dead }
	}

	/// The recording server's rung in use.
	pub fn rung(&self) -> Rung {
		LADDER[self.current.load(Ordering::Relaxed)]
	}

	pub fn note(&self) -> Option<&'static str> {
		self.rung().note()
	}

	fn server_at(&self, i: usize) -> Result<reqwest::Client, String> {
		let mut clients = self.server.lock().unwrap_or_else(|e| e.into_inner());
		if let Some(c) = &clients[i] {
			return Ok(c.clone());
		}
		let c = (self.make)(LADDER[i], true)?;
		clients[i] = Some(c.clone());
		Ok(c)
	}

	/// The GitHub (`Api`) or community site (`Packs`) client. They never take the recording
	/// server's rung; only a system without any certificate authority (where the normal client
	/// can't even be built) gets the bundled ones added.
	pub fn client(&self, family: Family) -> reqwest::Client {
		let slot = match family {
			Family::Api => 0,
			Family::Packs => 1,
			Family::Server => {
				return self.server_at(self.current.load(Ordering::Relaxed)).or_else(|_| build(Rung::BundledRoots, family, true)).expect("a client with the bundled certificate authorities")
			}
		};
		let mut clients = self.others.lock().unwrap_or_else(|e| e.into_inner());
		if let Some(c) = &clients[slot] {
			return c.clone();
		}
		let c = build(Rung::Normal, family, true).or_else(|_| build(Rung::BundledRoots, family, true)).expect("a client with the bundled certificate authorities");
		clients[slot] = Some(c.clone());
		c
	}

	/// Sends a request to the recording server (`request` makes it on a client) on the rung in
	/// use, and when it cannot connect, on the other rungs in ladder order; the first that connects
	/// is kept. An answer of any status is a connection: only failures to connect move down the
	/// ladder. [`Rung::BundledRoots`] is tried only after a certificate from an authority the
	/// system doesn't know, or where the system has none at all. When none connects and the
	/// environment's proxy itself can't be reached, the request goes once without it (never
	/// kept). When nothing connects, the error is the first rung's (a certificate the clock makes
	/// invalid wins, as no rung can fix that).
	pub async fn send(&self, request: impl Fn(&reqwest::Client) -> reqwest::RequestBuilder) -> Result<reqwest::Response, reqwest::Error> {
		let start = self.current.load(Ordering::Relaxed);
		let mut first: Option<reqwest::Error> = None;
		let mut unknown_issuer = false;
		let mut unbuilt = false;
		for i in std::iter::once(start).chain((0..LADDER.len()).filter(|&i| i != start)) {
			if LADDER[i] == Rung::BundledRoots && i != start && !(unknown_issuer || unbuilt) {
				continue;
			}
			let client = match self.server_at(i) {
				Ok(c) => c,
				Err(_) => {
					unbuilt = true;
					continue;
				}
			};
			match request(&client).send().await {
				Ok(response) => {
					if i != start {
						self.current.store(i, Ordering::Relaxed);
						eprintln!("connection: {:?} connects where {:?} did not", LADDER[i], LADDER[start]);
					}
					return Ok(response);
				}
				Err(e) if e.is_connect() => {
					unknown_issuer |= cert_error(&e).is_some_and(|c| matches!(c, CertificateError::UnknownIssuer));
					if first.as_ref().is_none_or(|f| !clock_wrong(f) && clock_wrong(&e)) {
						first = Some(e);
					}
				}
				Err(e) => return Err(e),
			}
		}
		if let Some(dead) = (self.proxy_dead)() {
			if dead.await {
				eprintln!("connection: the proxy can't be reached; this request goes without it");
				if let Ok(direct) = (self.make)(self.rung(), false) {
					match request(&direct).send().await {
						Ok(response) => return Ok(response),
						Err(e) if !e.is_connect() => return Err(e),
						Err(_) => {}
					}
				}
			}
		}
		match first {
			Some(e) => Err(e),
			None => request(&self.client(Family::Server)).send().await,
		}
	}
}

/// The environment's proxy for the recording server, as `host:port` (reqwest uses `HTTPS_PROXY`,
/// else `ALL_PROXY`, for https; `NO_PROXY` may exempt the server). On Windows and macOS the
/// system's proxy can't be seen here, so it is never gone around.
pub fn env_proxy() -> Option<String> {
	proxy_for_server(|v| std::env::var(v).ok())
}

pub fn proxy_for_server(var: impl Fn(&str) -> Option<String>) -> Option<String> {
	let get = |names: &[&str]| names.iter().find_map(|n| var(n).filter(|v| !v.trim().is_empty()));
	// NO_PROXY entries: `*`, a host, `.domain` or `*.domain`.
	let exempt = get(&["NO_PROXY", "no_proxy"])
		.is_some_and(|list| list.split(',').map(|e| e.trim().trim_start_matches("*.").trim_start_matches('.')).any(|e| e == "*" || e == "polestar.guide" || e == "data.polestar.guide"));
	if exempt {
		return None;
	}
	let url = get(&["HTTPS_PROXY", "https_proxy", "ALL_PROXY", "all_proxy"])?;
	let url = if url.contains("://") { url } else { format!("http://{url}") };
	let parsed = reqwest::Url::parse(&url).ok()?;
	let port = parsed.port_or_known_default()?;
	Some(format!("{}:{port}", parsed.host_str()?))
}

/// The proxy can't be reached: its name doesn't resolve, or nothing answers at its port within 5 s.
pub async fn proxy_unreachable(addr: String) -> bool {
	!matches!(tokio::time::timeout(Duration::from_secs(5), tokio::net::TcpStream::connect(addr)).await, Ok(Ok(_)))
}

fn base(family: Family) -> reqwest::ClientBuilder {
	let b = reqwest::Client::builder().user_agent(concat!("PolestarClient/", env!("CARGO_PKG_VERSION"))).connect_timeout(Duration::from_secs(15)).timeout(Duration::from_secs(90));
	match family {
		// The recording server never redirects; a debug build may use a local http one.
		Family::Server => b.redirect(Policy::none()).https_only(!cfg!(debug_assertions)),
		Family::Api => b.https_only(true),
		Family::Packs => b.redirect(crate::packs::redirect_policy()),
	}
}

/// The production client of a rung (`proxy` false: without the environment's proxy).
pub fn build(rung: Rung, family: Family, proxy: bool) -> Result<reqwest::Client, String> {
	let b = with_rung(base(family), rung);
	let b = if proxy { b } else { b.no_proxy() };
	b.build().map_err(|e| e.to_string())
}

/// A builder set up for `rung`.
pub fn with_rung(b: reqwest::ClientBuilder, rung: Rung) -> reqwest::ClientBuilder {
	match rung {
		Rung::Normal => b,
		Rung::Ipv4 => b.dns_resolver(Arc::new(Ipv4Only)),
		Rung::BundledRoots => b.tls_certs_merge(bundled_roots()),
		Rung::OwnDns => b.dns_resolver(Arc::new(Doh::new(DOH_SERVERS.iter().map(|s| s.to_string()).collect()))),
	}
}

/// The bundled Mozilla certificate authorities. Added to the system's platform verifier
/// (`tls_certs_merge`): it still makes every check of its own (revocation, distrust, policy).
pub fn bundled_roots() -> impl Iterator<Item = reqwest::Certificate> {
	webpki_root_certs::TLS_SERVER_ROOT_CERTS.iter().filter_map(|der| reqwest::Certificate::from_der(der.as_ref()).ok())
}

/// The system's addresses of a name, IPv4 only.
struct Ipv4Only;

impl Resolve for Ipv4Only {
	fn resolve(&self, name: Name) -> Resolving {
		let host = name.as_str().to_owned();
		Box::pin(async move {
			let found = ipv4_only(tokio::net::lookup_host((host.as_str(), 0)).await?);
			if found.is_empty() {
				return Err(format!("{host} has no IPv4 address").into());
			}
			Ok(Box::new(found.into_iter()) as Addrs)
		})
	}
}

pub fn ipv4_only(addrs: impl Iterator<Item = SocketAddr>) -> Vec<SocketAddr> {
	addrs.filter(SocketAddr::is_ipv4).collect()
}

/// DNS over HTTPS (the JSON form) at addresses that need no DNS themselves: Cloudflare and Google.
pub const DOH_SERVERS: [&str; 3] = ["https://1.1.1.1/dns-query", "https://1.0.0.1/dns-query", "https://8.8.8.8/resolve"];
/// The only names asked for over DNS over HTTPS.
pub const DOH_HOSTS: [&str; 2] = ["data.polestar.guide", "polestar.guide"];
/// Largest DNS answer read, in bytes.
const DOH_MAX: usize = 64 * 1024;

/// A resolver asking DNS-over-HTTPS servers, in turn, for a Polestar host's A and AAAA records.
pub struct Doh {
	servers: Vec<String>,
	/// Its own client, or why it could not be built.
	http: Result<reqwest::Client, String>,
}

impl Doh {
	pub fn new(servers: Vec<String>) -> Doh {
		// The servers are IP addresses: no DNS. Their certificates are checked by the system,
		// with the bundled authorities added; https only, no redirects.
		let http = reqwest::Client::builder()
			.connect_timeout(Duration::from_secs(10))
			.timeout(Duration::from_secs(15))
			.redirect(Policy::none())
			.https_only(true)
			.tls_certs_merge(bundled_roots())
			.build()
			.map_err(|e| e.to_string());
		Doh { servers, http }
	}

	/// With its own client (tests: plain http servers).
	pub fn with_client(servers: Vec<String>, http: reqwest::Client) -> Doh {
		Doh { servers, http: Ok(http) }
	}

	pub async fn lookup(&self, host: &str) -> Result<Vec<SocketAddr>, String> {
		if !DOH_HOSTS.contains(&host) {
			return Err(format!("DNS over HTTPS is only for the Polestar servers, not {host}"));
		}
		let mut why = String::from("no server answered");
		for server in &self.servers {
			let http = self.http.as_ref().map_err(|e| format!("DNS over HTTPS has no client: {e}"))?;
			match lookup_at(http, server, host).await {
				Ok(found) if !found.is_empty() => return Ok(found),
				Ok(_) => why = format!("{host} has no address"),
				Err(e) => why = e,
			}
		}
		Err(format!("DNS over HTTPS could not find {host}: {why}"))
	}
}

impl Resolve for Doh {
	fn resolve(&self, name: Name) -> Resolving {
		let (servers, http, host) = (self.servers.clone(), self.http.clone(), name.as_str().to_owned());
		Box::pin(async move {
			let found = Doh { servers, http }.lookup(&host).await?;
			Ok(Box::new(found.into_iter()) as Addrs)
		})
	}
}

async fn lookup_at(http: &reqwest::Client, server: &str, host: &str) -> Result<Vec<SocketAddr>, String> {
	let mut out = Vec::new();
	for kind in ["A", "AAAA"] {
		let response = http.get(format!("{server}?name={host}&type={kind}")).header("accept", "application/dns-json").send().await.map_err(|e| e.to_string())?;
		if !response.status().is_success() {
			return Err(format!("{server} answered {}", response.status()));
		}
		let body = crate::packs::read_capped(response, DOH_MAX).await?;
		out.extend(doh_addresses(&body)?);
	}
	Ok(out)
}

/// The addresses in a DNS-over-HTTPS JSON answer (`Status` 0; `Answer` items of type 1 or 28).
pub fn doh_addresses(body: &[u8]) -> Result<Vec<SocketAddr>, String> {
	let v: serde_json::Value = serde_json::from_slice(body).map_err(|e| format!("unreadable answer: {e}"))?;
	match v.get("Status").and_then(serde_json::Value::as_u64) {
		Some(0) => {}
		Some(3) => return Ok(Vec::new()),
		other => return Err(format!("DNS status {}", other.map_or("missing".to_owned(), |s| s.to_string()))),
	}
	let answers = v.get("Answer").and_then(serde_json::Value::as_array).map(Vec::as_slice).unwrap_or_default();
	Ok(answers
		.iter()
		.filter(|a| matches!(a.get("type").and_then(serde_json::Value::as_u64), Some(1 | 28)))
		.filter_map(|a| a.get("data")?.as_str()?.parse::<std::net::IpAddr>().ok())
		.map(|ip| SocketAddr::new(ip, 0))
		.collect())
}

/// The certificate error a connection failed on, if any.
pub fn cert_error(e: &(dyn std::error::Error + 'static)) -> Option<CertificateError> {
	let mut cur = Some(e);
	while let Some(err) = cur {
		// hyper-rustls hands rustls's error over inside an io::Error, whose source() skips it.
		let inner = err.downcast_ref::<std::io::Error>().and_then(|io| io.get_ref()).map(|i| i as &(dyn std::error::Error + 'static));
		for candidate in [Some(err), inner].into_iter().flatten() {
			if let Some(rustls::Error::InvalidCertificate(c)) = candidate.downcast_ref::<rustls::Error>() {
				return Some(c.clone());
			}
		}
		cur = err.source();
	}
	None
}

/// The connection failed on a certificate that is expired or not valid yet: on a PC whose clock
/// is wrong, every certificate looks so.
pub fn clock_wrong(e: &(dyn std::error::Error + 'static)) -> bool {
	use CertificateError as C;
	cert_error(e).is_some_and(|c| matches!(c, C::Expired | C::NotValidYet | C::ExpiredContext { .. } | C::NotValidYetContext { .. }))
}

/// What the status says when the clock looks wrong; `now` in unix seconds.
pub fn clock_message(now: i64) -> String {
	format!("Your PC's clock looks wrong (it says {}); fix the time and try again.", utc(now))
}

/// An error with its chain of causes, which reqwest's own text ("error sending request for url
/// (…)") never names: "client error (Connect): dns error: No such host is known.", "client error
/// (Connect): tcp connect error: Connection refused", "client error (Connect): invalid peer
/// certificate: UnknownIssuer", "operation timed out". A reqwest error's own text is left out
/// (the causes say more) unless it has none, and so is a cause the text above it already holds.
pub fn cause(e: &(dyn std::error::Error + 'static)) -> String {
	let mut parts: Vec<String> = Vec::new();
	let mut cur = if e.is::<reqwest::Error>() { e.source() } else { Some(e) };
	while let Some(err) = cur {
		let text = err.to_string();
		if !parts.last().is_some_and(|p| p.contains(&text)) {
			parts.push(text);
		}
		cur = err.source();
	}
	if parts.is_empty() {
		e.to_string()
	} else {
		parts.join(": ")
	}
}

/// What a player reads when a request to `name` (the community site, GitHub) got no answer: the
/// cause, and, when nothing connected, what to try. A certificate the clock makes invalid is
/// named as a wrong clock.
pub fn unreachable(e: &reqwest::Error, name: &str) -> String {
	if clock_wrong(e) {
		let now = std::time::SystemTime::now().duration_since(std::time::UNIX_EPOCH).map_or(0, |d| d.as_secs() as i64);
		return clock_message(now);
	}
	match e.url() {
		Some(url) if e.is_connect() || e.is_timeout() => {
			format!("Could not reach {name} from this PC ({}). If your browser opens {url}, a firewall, antivirus, VPN or proxy is probably blocking Polestar Client: allow it there.", cause(e))
		}
		_ => format!("Could not reach {name} ({}).", cause(e)),
	}
}

/// `YYYY-MM-DD HH:MM UTC`.
fn utc(secs: i64) -> String {
	let (days, rem) = (secs.div_euclid(86_400), secs.rem_euclid(86_400));
	// Civil from days (H. Hinnant).
	let z = days + 719_468;
	let era = z.div_euclid(146_097);
	let doe = z - era * 146_097;
	let yoe = (doe - doe / 1460 + doe / 36_524 - doe / 146_096) / 365;
	let doy = doe - (365 * yoe + yoe / 4 - yoe / 100);
	let mp = (5 * doy + 2) / 153;
	let d = doy - (153 * mp + 2) / 5 + 1;
	let m = if mp < 10 { mp + 3 } else { mp - 9 };
	let y = yoe + era * 400 + i64::from(m <= 2);
	format!("{y:04}-{m:02}-{d:02} {:02}:{:02} UTC", rem / 3600, rem % 3600 / 60)
}

#[cfg(test)]
mod tests {
	use super::*;
	use std::io::{Read, Write};
	use std::net::TcpListener;
	use std::sync::atomic::AtomicBool;

	/// As lib.rs does at startup, before any client is built.
	fn provider() {
		let _ = rustls::crypto::ring::default_provider().install_default();
	}

	fn block<F: Future>(f: F) -> F::Output {
		provider();
		tauri::async_runtime::block_on(f)
	}

	/// A local HTTP server answering every request with `status` and `body`; its address and how
	/// many requests it got.
	fn server(status: &'static str, body: &'static str) -> (SocketAddr, Arc<AtomicUsize>) {
		let listener = TcpListener::bind("127.0.0.1:0").unwrap();
		let addr = listener.local_addr().unwrap();
		let hits = Arc::new(AtomicUsize::new(0));
		let count = hits.clone();
		std::thread::spawn(move || {
			for stream in listener.incoming() {
				let Ok(mut s) = stream else { continue };
				let mut buf = [0u8; 4096];
				let mut got = Vec::new();
				while !got.windows(4).any(|w| w == b"\r\n\r\n") {
					match s.read(&mut buf) {
						Ok(0) | Err(_) => break,
						Ok(n) => got.extend_from_slice(&buf[..n]),
					}
				}
				count.fetch_add(1, Ordering::SeqCst);
				let _ = write!(s, "HTTP/1.1 {status}\r\nContent-Type: application/json\r\nContent-Length: {}\r\nConnection: close\r\n\r\n{body}", body.len());
			}
		});
		(addr, hits)
	}

	/// An address nothing listens on: connections are refused.
	fn dead() -> SocketAddr {
		let l = TcpListener::bind("127.0.0.1:0").unwrap();
		l.local_addr().unwrap()
	}

	fn client_to(addr: SocketAddr) -> Result<reqwest::Client, String> {
		reqwest::Client::builder().resolve("polestar.test", addr).build().map_err(|e| e.to_string())
	}

	/// A ladder whose rungs reach `polestar.test` at `addr(rung)` (through the proxy), whose proxy
	/// is never found dead.
	fn ladder(addr: impl Fn(Rung) -> SocketAddr + Send + Sync + 'static) -> Net {
		Net::with(Box::new(move |rung, _| client_to(addr(rung))), Box::new(|| None))
	}

	fn get(net: &Net) -> Result<reqwest::StatusCode, reqwest::Error> {
		block(async { net.send(|c| c.get("http://polestar.test/v1/stats")).await.map(|r| r.status()) })
	}

	#[test]
	fn the_normal_way_is_used_while_it_connects() {
		let (live, hits) = server("200 OK", "{}");
		let net = ladder(move |_| live);
		assert_eq!(get(&net).unwrap(), 200);
		assert_eq!((net.rung(), net.note(), hits.load(Ordering::SeqCst)), (Rung::Normal, None, 1));
	}

	#[test]
	fn ipv4_and_own_dns_are_found_when_only_they_connect_and_kept_for_the_run() {
		for target in [Rung::Ipv4, Rung::OwnDns] {
			let (live, hits) = server("200 OK", "{}");
			let gone = dead();
			let net = ladder(move |r| if r == target { live } else { gone });
			assert_eq!(get(&net).unwrap(), 200, "{target:?}");
			assert_eq!((net.rung(), net.note()), (target, target.note()));
			// The next request goes straight to it.
			assert_eq!(get(&net).unwrap(), 200);
			assert_eq!(hits.load(Ordering::SeqCst), 2);
		}
	}

	#[test]
	fn the_bundled_authorities_are_tried_only_where_the_system_s_could_not_serve() {
		// A plain refused connection is no certificate problem: the rung is left alone.
		let (live, hits) = server("200 OK", "{}");
		let gone = dead();
		let net = ladder(move |r| if r == Rung::BundledRoots { live } else { gone });
		assert!(get(&net).unwrap_err().is_connect());
		assert_eq!((net.rung(), hits.load(Ordering::SeqCst)), (Rung::Normal, 0));
		// A system without any authority (its clients can't be built): it is used, and kept.
		let net = Net::with(Box::new(move |rung, _| if rung == Rung::BundledRoots { client_to(live) } else { Err("No CA certificates were loaded from the system".into()) }), Box::new(|| None));
		assert_eq!(get(&net).unwrap(), 200);
		assert_eq!(net.rung(), Rung::BundledRoots);
		assert_eq!(get(&net).unwrap(), 200);
		assert_eq!(hits.load(Ordering::SeqCst), 2);
	}

	#[test]
	fn a_kept_rung_that_stops_connecting_walks_the_ladder_again() {
		let (live, _) = server("200 OK", "{}");
		let gone = dead();
		let normal_works = Arc::new(AtomicBool::new(false));
		let flag = normal_works.clone();
		let net = Net::with(
			Box::new(move |rung, _| {
				let ok = match rung {
					Rung::Normal => flag.load(Ordering::SeqCst),
					Rung::Ipv4 => !flag.load(Ordering::SeqCst),
					_ => false,
				};
				client_to(if ok { live } else { gone })
			}),
			Box::new(|| None),
		);
		assert_eq!(get(&net).unwrap(), 200);
		assert_eq!(net.rung(), Rung::Ipv4);
		// The clients are kept per rung: drop them so the closure is asked again.
		*net.server.lock().unwrap() = Default::default();
		normal_works.store(true, Ordering::SeqCst);
		assert_eq!(get(&net).unwrap(), 200);
		assert_eq!(net.rung(), Rung::Normal);
	}

	#[test]
	fn an_answer_of_any_status_is_a_connection() {
		let (busy, _) = server("503 Service Unavailable", "{\"error\":\"server busy\"}");
		let (live, hits) = server("200 OK", "{}");
		let net = ladder(move |r| if r == Rung::Normal { busy } else { live });
		assert_eq!(get(&net).unwrap(), 503);
		assert_eq!((net.rung(), hits.load(Ordering::SeqCst)), (Rung::Normal, 0));
	}

	#[test]
	fn a_proxy_that_can_t_be_reached_is_gone_around_for_that_request_only() {
		let (live, hits) = server("200 OK", "{}");
		let gone = dead();
		let proxy_dead = Arc::new(AtomicBool::new(true));
		let asked = Arc::new(AtomicUsize::new(0));
		let (flag, count) = (proxy_dead.clone(), asked.clone());
		// Through the proxy nothing connects; without it, the server answers.
		let net = Net::with(
			Box::new(move |_, proxy| client_to(if proxy { gone } else { live })),
			Box::new(move || {
				count.fetch_add(1, Ordering::SeqCst);
				let dead = flag.load(Ordering::SeqCst);
				Some(Box::pin(async move { dead }) as _)
			}),
		);
		assert_eq!(get(&net).unwrap(), 200);
		assert_eq!((net.rung(), net.note(), hits.load(Ordering::SeqCst)), (Rung::Normal, None, 1), "never kept");
		// The proxy answers again: its failures stand, nothing goes around it.
		proxy_dead.store(false, Ordering::SeqCst);
		assert!(get(&net).unwrap_err().is_connect());
		assert_eq!((hits.load(Ordering::SeqCst), asked.load(Ordering::SeqCst)), (1, 2));
		// No proxy applies: never asked about, never gone around.
		let net = Net::with(Box::new(move |_, proxy| client_to(if proxy { gone } else { live })), Box::new(|| None));
		assert!(get(&net).unwrap_err().is_connect());
		assert_eq!(hits.load(Ordering::SeqCst), 1);
	}

	#[test]
	fn the_proxy_is_the_environment_s_for_https_unless_no_proxy_exempts_the_server() {
		let env = |pairs: &'static [(&'static str, &'static str)]| move |k: &str| pairs.iter().find(|(n, _)| *n == k).map(|(_, v)| v.to_string());
		assert_eq!(proxy_for_server(env(&[])), None);
		assert_eq!(proxy_for_server(env(&[("HTTP_PROXY", "http://only-http:3128")])), None, "http requests only");
		assert_eq!(proxy_for_server(env(&[("HTTPS_PROXY", "http://proxy.lan:3128")])), Some("proxy.lan:3128".into()));
		assert_eq!(proxy_for_server(env(&[("https_proxy", "proxy.lan:8080")])), Some("proxy.lan:8080".into()));
		assert_eq!(proxy_for_server(env(&[("ALL_PROXY", "socks5://127.0.0.1:1080")])), Some("127.0.0.1:1080".into()));
		assert_eq!(proxy_for_server(env(&[("HTTPS_PROXY", "http://proxy.lan")])), Some("proxy.lan:80".into()));
		for exempt in ["*", "localhost,.polestar.guide", "polestar.guide", "data.polestar.guide", "*.polestar.guide"] {
			assert_eq!(proxy_for_server(env(Box::leak(Box::new([("HTTPS_PROXY", "http://proxy.lan:3128"), ("NO_PROXY", exempt)])))), None, "{exempt}");
		}
		assert_eq!(proxy_for_server(env(&[("HTTPS_PROXY", "http://proxy.lan:3128"), ("NO_PROXY", "example.com,notpolestar.guide")])), Some("proxy.lan:3128".into()));
		// Unreachable: nothing at its port, or a name that doesn't resolve.
		let (live, _) = server("200 OK", "{}");
		assert!(!block(proxy_unreachable(live.to_string())));
		assert!(block(proxy_unreachable(dead().to_string())));
		assert!(block(proxy_unreachable("no-such-proxy.invalid:3128".into())));
	}

	#[test]
	fn the_recording_server_s_client_follows_no_redirect_and_github_s_is_https_only() {
		provider();
		let (moved, _) = server("308 Permanent Redirect\r\nLocation: http://elsewhere.test/v1/upload", "");
		let server_client = build(Rung::Normal, Family::Server, true).unwrap();
		let status = block(async { server_client.post(format!("http://{moved}/v1/upload")).body("chunks").send().await }).unwrap().status();
		assert_eq!(status, 308, "the redirect is the answer, nothing is sent again");
		let github = build(Rung::Normal, Family::Api, true).unwrap();
		assert!(block(async { github.get(format!("http://{moved}/")).send().await }).is_err(), "no plain http");
	}

	#[test]
	fn ipv4_only_keeps_the_ipv4_addresses_and_still_reaches_localhost() {
		provider();
		let v6: SocketAddr = "[2001:db8::1]:443".parse().unwrap();
		let v4: SocketAddr = "192.0.2.1:443".parse().unwrap();
		assert_eq!(ipv4_only([v6, v4, v6].into_iter()), vec![v4]);
		let (live, hits) = server("200 OK", "{}");
		let client = with_rung(reqwest::Client::builder(), Rung::Ipv4).build().unwrap();
		let status = block(async { client.get(format!("http://localhost:{}/", live.port())).send().await.map(|r| r.status()) });
		assert_eq!((status.unwrap().as_u16(), hits.load(Ordering::SeqCst)), (200, 1));
	}

	#[test]
	fn the_bundled_authorities_hold_the_server_s_roots_and_always_build() {
		provider();
		let has = |name: &[u8]| webpki_root_certs::TLS_SERVER_ROOT_CERTS.iter().any(|c| c.as_ref().windows(name.len()).any(|w| w == name));
		assert!(has(b"ISRG Root X1") && has(b"ISRG Root X2"), "Let's Encrypt's roots");
		assert_eq!(bundled_roots().count(), webpki_root_certs::TLS_SERVER_ROOT_CERTS.len());
		for family in [Family::Server, Family::Api, Family::Packs] {
			assert!(build(Rung::BundledRoots, family, true).is_ok(), "{family:?}");
		}
	}

	#[test]
	fn own_dns_asks_each_server_in_turn_for_a_and_aaaa_of_the_polestar_hosts_only() {
		provider();
		let (answer, asked) = server(
			"200 OK",
			r#"{"Status":0,"Answer":[{"name":"data.polestar.guide","type":5,"data":"x.example."},{"name":"data.polestar.guide","type":1,"data":"127.0.0.1"},{"type":28,"data":"::1"}]}"#,
		);
		let gone = dead();
		let doh = Doh::with_client(vec![format!("http://{gone}/dns-query"), format!("http://{answer}/dns-query")], reqwest::Client::new());
		let found = block(doh.lookup("data.polestar.guide")).unwrap();
		// The same answer for A and AAAA here: both addresses, from each query.
		assert!(found.contains(&"127.0.0.1:0".parse().unwrap()) && found.contains(&"[::1]:0".parse().unwrap()), "{found:?}");
		assert_eq!(asked.load(Ordering::SeqCst), 2);
		// Another host is never asked about.
		assert!(block(doh.lookup("api.github.com")).unwrap_err().contains("only for the Polestar servers"));
		assert_eq!(asked.load(Ordering::SeqCst), 2);
		// Through a client: the URL's port, the resolver's address.
		let (live, hits) = server("200 OK", "{}");
		let client = reqwest::Client::builder().dns_resolver(Arc::new(Doh::with_client(vec![format!("http://{answer}/dns-query")], reqwest::Client::new()))).build().unwrap();
		let status = block(async { client.get(format!("http://data.polestar.guide:{}/v1/stats", live.port())).send().await.map(|r| r.status()) });
		assert_eq!((status.unwrap().as_u16(), hits.load(Ordering::SeqCst)), (200, 1));
		assert_eq!(doh_addresses(br#"{"Status":3}"#).unwrap(), vec![]);
		assert!(doh_addresses(br#"{"Status":2}"#).unwrap_err().contains("status 2"));
		assert!(block(Doh::with_client(vec![format!("http://{gone}/dns-query")], reqwest::Client::new()).lookup("data.polestar.guide"))
			.unwrap_err()
			.starts_with("DNS over HTTPS could not find data.polestar.guide"));
		// The production client asks https servers only.
		assert!(block(Doh::new(vec![format!("http://{answer}/dns-query")]).lookup("data.polestar.guide")).is_err());
	}

	#[derive(Debug)]
	struct Wrapped(std::io::Error);
	impl std::fmt::Display for Wrapped {
		fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
			f.write_str("client error (Connect)")
		}
	}
	impl std::error::Error for Wrapped {
		fn source(&self) -> Option<&(dyn std::error::Error + 'static)> {
			Some(&self.0)
		}
	}

	#[test]
	fn certificate_errors_are_read_from_the_chain_and_a_wrong_clock_is_named() {
		use CertificateError as C;
		// As hyper-rustls hands it over: rustls's error inside an io::Error, inside the connector's.
		let wrap = |c: C| Wrapped(std::io::Error::new(std::io::ErrorKind::InvalidData, rustls::Error::InvalidCertificate(c)));
		assert!(clock_wrong(&wrap(C::Expired)) && clock_wrong(&wrap(C::NotValidYet)));
		assert!(!clock_wrong(&wrap(C::UnknownIssuer)));
		assert_eq!(cert_error(&wrap(C::UnknownIssuer)), Some(C::UnknownIssuer));
		assert_eq!(cert_error(&wrap(C::Revoked)), Some(C::Revoked));
		assert_eq!(cert_error(&std::io::Error::other("connection refused")), None);
		assert_eq!(clock_message(1_794_226_107), "Your PC's clock looks wrong (it says 2026-11-09 12:08 UTC); fix the time and try again.");
		assert_eq!(utc(951_782_400), "2000-02-29 00:00 UTC");
		// The certificate problem is in the cause, read through hyper-rustls's io::Error.
		assert_eq!(cause(&wrap(C::UnknownIssuer)), "client error (Connect): invalid peer certificate: UnknownIssuer");
	}

	/// 0.1.6 said only "Could not reach polestar.guide: error sending request for url (…)": reqwest's
	/// own text, which names no cause, so a player and we could only guess.
	#[test]
	fn a_request_that_gets_no_answer_says_why_and_what_to_try() {
		provider();
		// Refused: the cause, the address to try in a browser, what may block it.
		let url = format!("http://{}/api/v1/packs/index.json", dead());
		let e = block(async { reqwest::Client::new().get(&url).send().await.unwrap_err() });
		let text = unreachable(&e, "polestar.guide");
		assert!(text.starts_with("Could not reach polestar.guide from this PC (client error (Connect): tcp connect error: "), "{text}");
		assert!(text.to_lowercase().contains("refused") && text.contains(&url) && text.contains("firewall, antivirus, VPN or proxy"), "{text}");
		assert!(!text.contains("error sending request"), "{text}");
		// Connected, but no answer in time (a listener that never accepts).
		let silent = TcpListener::bind("127.0.0.1:0").unwrap();
		let addr = silent.local_addr().unwrap();
		let client = reqwest::Client::builder().timeout(Duration::from_millis(300)).build().unwrap();
		let e = block(async { client.get(format!("http://{addr}/")).send().await.unwrap_err() });
		assert!(e.is_timeout() && cause(&e).contains("timed out"), "{}", cause(&e));
		assert!(unreachable(&e, "polestar.guide").contains("If your browser opens"), "{}", unreachable(&e, "polestar.guide"));
		drop(silent);
		// A name that doesn't resolve (.invalid never does).
		let e = block(async { reqwest::Client::new().get("http://polestar.invalid/").send().await.unwrap_err() });
		assert!(cause(&e).contains("dns error"), "{}", cause(&e));
		// An error without causes is its own text.
		assert_eq!(cause(&std::io::Error::other("far bigger than expected")), "far bigger than expected");
	}

	/// Against the real recording server (network needed: `cargo test --lib -- --ignored net::`).
	#[test]
	#[ignore]
	fn every_production_rung_reaches_the_recording_server() {
		provider();
		for rung in LADDER {
			let client = build(rung, Family::Server, true).unwrap();
			let status = block(async { client.get("https://data.polestar.guide/v1/stats").send().await.map(|r| r.status()) });
			assert_eq!(status.map_err(|e| e.to_string()).unwrap(), 200, "{rung:?}");
		}
		let found = block(Doh::new(DOH_SERVERS.iter().map(|s| s.to_string()).collect()).lookup("data.polestar.guide")).unwrap();
		assert!(found.iter().any(SocketAddr::is_ipv4), "{found:?}");
		for family in [Family::Api, Family::Packs] {
			let url = if family == Family::Api { "https://api.github.com/" } else { "https://polestar.guide/" };
			assert!(block(async { Net::new().client(family).get(url).send().await }).is_ok(), "{family:?}");
		}
	}

	/// A PC with no certificate authorities the system can find: run the test binary itself with
	/// `SSL_CERT_FILE=/nonexistent SSL_CERT_DIR=/nonexistent` and `--ignored net::tests::without`
	/// (0.1.4's client could not even be built there).
	#[test]
	#[ignore]
	fn without_system_authorities_the_ladder_still_connects() {
		provider();
		let net = Net::new();
		let status = block(async { net.send(|c| c.get("https://data.polestar.guide/v1/stats")).await }).map(|r| r.status());
		assert_eq!(status.map_err(|e| e.to_string()).unwrap(), 200);
		assert_eq!(net.rung(), Rung::BundledRoots);
		assert!(block(async { net.client(Family::Api).get("https://api.github.com/").send().await }).is_ok(), "GitHub too, with the bundled authorities added");
	}
}
