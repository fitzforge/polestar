//! The HTTP clients, and the fallback ladder for a PC where the normal connection fails.
//!
//! Every request goes out the normal way first: the system's DNS, its certificate authorities and
//! its proxy settings. Only when that cannot connect (DNS, the connection itself, or TLS) does
//! [`Net::send`] try the other rungs, in order: IPv4 only, Polestar Client's own list of
//! certificate authorities beside the system's, its own DNS lookup (DNS over HTTPS to Cloudflare
//! and Google), and, when a proxy is set, no proxy. The first rung that connects is used for the
//! rest of the run (the next start tries the normal way again). Certificates are always verified.

use std::net::SocketAddr;
use std::sync::atomic::{AtomicUsize, Ordering};
use std::sync::{Arc, LazyLock, Mutex};
use std::time::Duration;

use reqwest::dns::{Addrs, Name, Resolve, Resolving};

/// One way of connecting.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Rung {
	/// The system's DNS, certificate authorities and proxy.
	Normal,
	/// Only IPv4 addresses (a PC whose IPv6 is broken).
	Ipv4,
	/// The bundled Mozilla certificate authorities beside the system's (an old or odd store).
	BundledRoots,
	/// DNS over HTTPS to Cloudflare and Google (a PC whose own DNS fails).
	OwnDns,
	/// Without the proxy the environment sets.
	NoProxy,
}

pub const LADDER: [Rung; 5] = [Rung::Normal, Rung::Ipv4, Rung::BundledRoots, Rung::OwnDns, Rung::NoProxy];

impl Rung {
	/// What the status says while this rung is in use.
	pub fn note(self) -> Option<&'static str> {
		match self {
			Rung::Normal => None,
			Rung::Ipv4 => Some("Connected using IPv4 only: this PC's IPv6 connection doesn't reach the server."),
			Rung::BundledRoots => Some("Connected using Polestar Client's own list of certificate authorities: this PC's list couldn't check the server's certificate."),
			Rung::OwnDns => Some("Connected using Polestar Client's own DNS lookup (DNS over HTTPS): this PC's DNS couldn't find the server."),
			Rung::NoProxy => Some("Connected without this PC's proxy: the connection through it failed."),
		}
	}
}

/// The kind of client: the recording server, addon releases and updates, or the community site
/// (which follows redirects only within its origin).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Family {
	Api,
	Packs,
}

type Make = dyn Fn(Rung, Family) -> Result<reqwest::Client, String> + Send + Sync;

pub struct Net {
	/// The rung in use: an index in [`LADDER`].
	current: AtomicUsize,
	clients: Mutex<[[Option<reqwest::Client>; 2]; 5]>,
	make: Box<Make>,
	/// A proxy is configured: [`Rung::NoProxy`] is worth trying.
	proxy_set: bool,
}

impl Net {
	pub fn new() -> Net {
		Net::with(Box::new(build), proxy_configured())
	}

	pub fn with(make: Box<Make>, proxy_set: bool) -> Net {
		Net { current: AtomicUsize::new(0), clients: Mutex::new(Default::default()), make, proxy_set }
	}

	/// The rung in use.
	pub fn rung(&self) -> Rung {
		LADDER[self.current.load(Ordering::Relaxed)]
	}

	pub fn note(&self) -> Option<&'static str> {
		self.rung().note()
	}

	fn client_at(&self, i: usize, family: Family) -> Result<reqwest::Client, String> {
		let slot = family as usize;
		let mut clients = self.clients.lock().unwrap_or_else(|e| e.into_inner());
		if let Some(c) = &clients[i][slot] {
			return Ok(c.clone());
		}
		let c = (self.make)(LADDER[i], family)?;
		clients[i][slot] = Some(c.clone());
		Ok(c)
	}

	fn tried(&self, i: usize) -> bool {
		LADDER[i] != Rung::NoProxy || self.proxy_set
	}

	/// The client of the rung in use, for requests that do not walk the ladder themselves (addon
	/// downloads, update checks, the community site). A rung whose client cannot be built (no
	/// certificate authorities on the system at all) gives way to the next.
	pub fn client(&self, family: Family) -> reqwest::Client {
		let start = self.current.load(Ordering::Relaxed);
		for i in (start..LADDER.len()).chain(0..start) {
			if let Ok(c) = self.client_at(i, family) {
				return c;
			}
		}
		// The bundled certificate authorities always load.
		build(Rung::BundledRoots, family).expect("a client with the bundled certificate authorities")
	}

	/// Sends the request `request` makes on the rung in use, and when it cannot connect, on the
	/// other rungs in ladder order; the first that connects is kept. An answer of any status is a
	/// connection: only failures to connect move down the ladder. When none connects, the error is
	/// the first rung's (a certificate the clock makes invalid wins, as no rung can fix that).
	pub async fn send(&self, family: Family, request: impl Fn(&reqwest::Client) -> reqwest::RequestBuilder) -> Result<reqwest::Response, reqwest::Error> {
		let start = self.current.load(Ordering::Relaxed);
		let mut first: Option<reqwest::Error> = None;
		for i in std::iter::once(start).chain((0..LADDER.len()).filter(|&i| i != start)) {
			if !self.tried(i) {
				continue;
			}
			let Ok(client) = self.client_at(i, family) else {
				continue;
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
					if first.as_ref().is_none_or(|f| !clock_wrong(f) && clock_wrong(&e)) {
						first = Some(e);
					}
				}
				Err(e) => return Err(e),
			}
		}
		match first {
			Some(e) => Err(e),
			None => request(&self.client(family)).send().await,
		}
	}
}

/// A proxy is set: the environment's (Linux), or the system's (Windows, macOS, which reqwest
/// reads and which cannot be seen here).
pub fn proxy_configured() -> bool {
	cfg!(any(windows, target_os = "macos")) || ["HTTPS_PROXY", "https_proxy", "HTTP_PROXY", "http_proxy", "ALL_PROXY", "all_proxy"].iter().any(|v| std::env::var_os(v).is_some_and(|s| !s.is_empty()))
}

fn base(family: Family) -> reqwest::ClientBuilder {
	let b = reqwest::Client::builder().user_agent(concat!("PolestarClient/", env!("CARGO_PKG_VERSION"))).connect_timeout(Duration::from_secs(15)).timeout(Duration::from_secs(90));
	match family {
		Family::Api => b,
		Family::Packs => b.redirect(crate::packs::redirect_policy()),
	}
}

/// The production client of a rung.
pub fn build(rung: Rung, family: Family) -> Result<reqwest::Client, String> {
	with_rung(base(family), rung).build().map_err(|e| e.to_string())
}

/// A builder set up for `rung`.
pub fn with_rung(b: reqwest::ClientBuilder, rung: Rung) -> reqwest::ClientBuilder {
	match rung {
		Rung::Normal => b,
		Rung::Ipv4 => b.dns_resolver(Arc::new(Ipv4Only)),
		Rung::BundledRoots => b.tls_certs_only(all_roots().iter().cloned()),
		Rung::OwnDns => b.dns_resolver(Arc::new(Doh::new(DOH_SERVERS.iter().map(|s| s.to_string()).collect()))),
		Rung::NoProxy => b.no_proxy(),
	}
}

/// The system's certificate authorities (as many as load) and the bundled Mozilla ones.
pub fn all_roots() -> &'static [reqwest::Certificate] {
	&ROOTS
}

static ROOTS: LazyLock<Vec<reqwest::Certificate>> = LazyLock::new(|| {
	let system = rustls_native_certs::load_native_certs().certs;
	let bundled = webpki_root_certs::TLS_SERVER_ROOT_CERTS.iter();
	system.iter().chain(bundled).filter_map(|der| reqwest::Certificate::from_der(der.as_ref()).ok()).collect()
});

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

/// DNS over HTTPS (the JSON form) at addresses that need no DNS themselves.
pub const DOH_SERVERS: [&str; 3] = ["https://1.1.1.1/dns-query", "https://1.0.0.1/dns-query", "https://8.8.8.8/resolve"];
/// Largest DNS answer read, in bytes.
const DOH_MAX: usize = 64 * 1024;

/// A resolver asking DNS-over-HTTPS servers, in turn, for a name's A and AAAA records.
pub struct Doh {
	servers: Vec<String>,
	/// Its own client, or why it could not be built.
	http: Result<reqwest::Client, String>,
}

impl Doh {
	pub fn new(servers: Vec<String>) -> Doh {
		// The servers are IP addresses: no DNS. Their certificates are checked against the system's
		// and the bundled authorities.
		let http = reqwest::Client::builder().connect_timeout(Duration::from_secs(10)).timeout(Duration::from_secs(15)).tls_certs_only(all_roots().iter().cloned()).build().map_err(|e| e.to_string());
		Doh { servers, http }
	}

	pub async fn lookup(&self, host: &str) -> Result<Vec<SocketAddr>, String> {
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

/// The connection failed on a certificate that is expired or not valid yet: on a PC whose clock
/// is wrong, every certificate looks so.
pub fn clock_wrong(e: &(dyn std::error::Error + 'static)) -> bool {
	use rustls::CertificateError as C;
	let mut cur = Some(e);
	while let Some(err) = cur {
		// hyper-rustls hands rustls's error over inside an io::Error, whose source() skips it.
		let inner = err.downcast_ref::<std::io::Error>().and_then(|io| io.get_ref()).map(|i| i as &(dyn std::error::Error + 'static));
		for candidate in [Some(err), inner].into_iter().flatten() {
			if let Some(rustls::Error::InvalidCertificate(c)) = candidate.downcast_ref::<rustls::Error>() {
				if matches!(c, C::Expired | C::NotValidYet | C::ExpiredContext { .. } | C::NotValidYetContext { .. }) {
					return true;
				}
			}
		}
		cur = err.source();
	}
	false
}

/// What the status says when the clock looks wrong; `now` in unix seconds.
pub fn clock_message(now: i64) -> String {
	format!("Your PC's clock looks wrong (it says {}); fix the time and try again.", utc(now))
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
	use std::future::Future;
	use std::io::{Read, Write};
	use std::net::TcpListener;
	use std::sync::atomic::AtomicUsize;

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

	/// A ladder whose rungs reach `polestar.test` at `addr(rung)`.
	fn ladder(addr: impl Fn(Rung) -> SocketAddr + Send + Sync + 'static, proxy_set: bool) -> Net {
		Net::with(Box::new(move |rung, _| reqwest::Client::builder().resolve("polestar.test", addr(rung)).build().map_err(|e| e.to_string())), proxy_set)
	}

	fn get(net: &Net) -> Result<reqwest::StatusCode, reqwest::Error> {
		block(async { net.send(Family::Api, |c| c.get("http://polestar.test/v1/stats")).await.map(|r| r.status()) })
	}

	#[test]
	fn the_normal_way_is_used_while_it_connects() {
		let (live, hits) = server("200 OK", "{}");
		let net = ladder(move |_| live, true);
		assert_eq!(get(&net).unwrap(), 200);
		assert_eq!((net.rung(), net.note(), hits.load(Ordering::SeqCst)), (Rung::Normal, None, 1));
	}

	#[test]
	fn each_rung_is_found_when_only_it_connects_and_kept_for_the_run() {
		for target in LADDER {
			let (live, hits) = server("200 OK", "{}");
			let gone = dead();
			let net = ladder(move |r| if r == target { live } else { gone }, true);
			assert_eq!(get(&net).unwrap(), 200, "{target:?}");
			assert_eq!(net.rung(), target);
			assert_eq!(net.note(), target.note());
			// The next request goes straight to it.
			assert_eq!(get(&net).unwrap(), 200);
			assert_eq!(hits.load(Ordering::SeqCst), 2);
			assert_eq!(net.client(Family::Api).get("http://polestar.test/").build().is_ok(), true);
		}
	}

	#[test]
	fn a_kept_rung_that_stops_connecting_walks_the_ladder_again() {
		let (live, _) = server("200 OK", "{}");
		let gone = dead();
		let normal_works = Arc::new(std::sync::atomic::AtomicBool::new(false));
		let flag = normal_works.clone();
		let net = Net::with(
			Box::new(move |rung, _| {
				let ok = match rung {
					Rung::Normal => flag.load(Ordering::SeqCst),
					Rung::Ipv4 => !flag.load(Ordering::SeqCst),
					_ => false,
				};
				reqwest::Client::builder().resolve("polestar.test", if ok { live } else { gone }).build().map_err(|e| e.to_string())
			}),
			false,
		);
		assert_eq!(get(&net).unwrap(), 200);
		assert_eq!(net.rung(), Rung::Ipv4);
		// The clients are kept per rung: drop them so the closure is asked again.
		*net.clients.lock().unwrap() = Default::default();
		normal_works.store(true, Ordering::SeqCst);
		assert_eq!(get(&net).unwrap(), 200);
		assert_eq!(net.rung(), Rung::Normal);
	}

	#[test]
	fn without_a_proxy_the_no_proxy_rung_is_not_tried() {
		let (live, hits) = server("200 OK", "{}");
		let gone = dead();
		let net = ladder(move |r| if r == Rung::NoProxy { live } else { gone }, false);
		let e = get(&net).unwrap_err();
		assert!(e.is_connect(), "{e}");
		assert_eq!((net.rung(), hits.load(Ordering::SeqCst)), (Rung::Normal, 0));
	}

	#[test]
	fn an_answer_of_any_status_is_a_connection() {
		let (busy, _) = server("503 Service Unavailable", "{\"error\":\"server busy\"}");
		let (live, hits) = server("200 OK", "{}");
		let net = ladder(move |r| if r == Rung::Normal { busy } else { live }, true);
		assert_eq!(get(&net).unwrap(), 503);
		assert_eq!((net.rung(), hits.load(Ordering::SeqCst)), (Rung::Normal, 0));
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
		assert!(all_roots().len() >= webpki_root_certs::TLS_SERVER_ROOT_CERTS.len());
		assert!(build(Rung::BundledRoots, Family::Api).is_ok() && build(Rung::BundledRoots, Family::Packs).is_ok());
	}

	#[test]
	fn own_dns_asks_each_server_in_turn_for_a_and_aaaa() {
		provider();
		let (answer, _) = server(
			"200 OK",
			r#"{"Status":0,"Answer":[{"name":"data.polestar.guide","type":5,"data":"x.example."},{"name":"data.polestar.guide","type":1,"data":"127.0.0.1"},{"type":28,"data":"::1"}]}"#,
		);
		let gone = dead();
		let doh = Doh::new(vec![format!("http://{gone}/dns-query"), format!("http://{answer}/dns-query")]);
		let found = block(doh.lookup("data.polestar.guide")).unwrap();
		// The same answer for A and AAAA here: both addresses, from each query.
		assert!(found.contains(&"127.0.0.1:0".parse().unwrap()) && found.contains(&"[::1]:0".parse().unwrap()), "{found:?}");
		// Through a client: the URL's port, the resolver's address.
		let (live, hits) = server("200 OK", "{}");
		let client = reqwest::Client::builder().dns_resolver(Arc::new(Doh::new(vec![format!("http://{answer}/dns-query")]))).build().unwrap();
		let status = block(async { client.get(format!("http://data.polestar.guide:{}/v1/stats", live.port())).send().await.map(|r| r.status()) });
		assert_eq!((status.unwrap().as_u16(), hits.load(Ordering::SeqCst)), (200, 1));
		assert_eq!(doh_addresses(br#"{"Status":3}"#).unwrap(), vec![]);
		assert!(doh_addresses(br#"{"Status":2}"#).unwrap_err().contains("status 2"));
		assert!(block(Doh::new(vec![format!("http://{gone}/dns-query")]).lookup("data.polestar.guide")).unwrap_err().starts_with("DNS over HTTPS could not find data.polestar.guide"));
	}

	#[test]
	fn no_proxy_goes_around_a_proxy_that_fails() {
		provider();
		let (live, hits) = server("200 OK", "{}");
		let proxy = format!("http://{}", dead());
		let url = format!("http://{live}/v1/stats");
		let through = reqwest::Client::builder().proxy(reqwest::Proxy::all(&proxy).unwrap()).build().unwrap();
		assert!(block(through.get(&url).send()).unwrap_err().is_connect());
		let around = with_rung(reqwest::Client::builder().proxy(reqwest::Proxy::all(&proxy).unwrap()), Rung::NoProxy).build().unwrap();
		assert_eq!(block(around.get(&url).send()).unwrap().status(), 200);
		assert_eq!(hits.load(Ordering::SeqCst), 1);
	}

	/// Against the real recording server (network needed: `cargo test --lib -- --ignored net::`).
	#[test]
	#[ignore]
	fn every_production_rung_reaches_the_recording_server() {
		provider();
		for rung in LADDER {
			let client = build(rung, Family::Api).unwrap();
			let status = block(async { client.get("https://data.polestar.guide/v1/stats").send().await.map(|r| r.status()) });
			assert_eq!(status.map_err(|e| e.to_string()).unwrap(), 200, "{rung:?}");
		}
		let found = block(Doh::new(DOH_SERVERS.iter().map(|s| s.to_string()).collect()).lookup("data.polestar.guide")).unwrap();
		assert!(found.iter().any(SocketAddr::is_ipv4), "{found:?}");
	}

	/// A PC with no certificate authorities the system can find: run the test binary itself with
	/// `SSL_CERT_FILE=/nonexistent SSL_CERT_DIR=/nonexistent` and `--ignored net::tests::without`
	/// (0.1.4's client could not even be built there).
	#[test]
	#[ignore]
	fn without_system_authorities_the_ladder_still_connects() {
		provider();
		let net = Net::new();
		let status = block(net.send(Family::Api, |c| c.get("https://data.polestar.guide/v1/stats"))).map(|r| r.status());
		assert_eq!(status.map_err(|e| e.to_string()).unwrap(), 200);
		assert_eq!(net.rung(), Rung::BundledRoots);
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
	fn an_expired_or_not_yet_valid_certificate_means_the_clock_is_wrong() {
		use rustls::CertificateError as C;
		// As hyper-rustls hands it over: rustls's error inside an io::Error, inside the connector's.
		let wrap = |c: C| Wrapped(std::io::Error::new(std::io::ErrorKind::InvalidData, rustls::Error::InvalidCertificate(c)));
		assert!(clock_wrong(&wrap(C::Expired)) && clock_wrong(&wrap(C::NotValidYet)));
		assert!(!clock_wrong(&wrap(C::UnknownIssuer)));
		assert!(!clock_wrong(&std::io::Error::other("connection refused")));
		assert_eq!(clock_message(1_794_226_107), "Your PC's clock looks wrong (it says 2026-11-09 12:08 UTC); fix the time and try again.");
		assert_eq!(utc(951_782_400), "2000-02-29 00:00 UTC");
	}
}
