//! The HTTP API end to end against an in-memory database.

use std::sync::Arc;
use std::time::{SystemTime, UNIX_EPOCH};

use axum::body::Body;
use axum::http::{header, Method, Request, StatusCode};
use axum::Router;
use http_body_util::BodyExt;
use polestar_ingest::db::Db;
use polestar_ingest::{make_challenge, router, AppState, Config};
use polestar_recording::api::pow_solve;
use serde_json::{json, Value};
use tower::ServiceExt;

const KEY: &str = "0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef";
const SECRET: &str = "fedcba9876543210fedcba9876543210";
const BITS: u32 = 8;
const INSTALL: &str = "k3j9x0q2m7ab";
const IP_A: &str = "203.0.113.7";
const IP_B: &str = "198.51.100.20";

struct App {
	router: Router,
	state: Arc<AppState>,
}

fn app_with(allow_direct: bool) -> App {
	app_config(Config { allow_direct, ..Config::default() })
}

/// An app with `config`'s settings, the test keys and proof of work.
fn app_config(config: Config) -> App {
	let config = Config { maintainer_key: KEY.to_owned(), min_build: 70532, secret: SECRET.to_owned(), pow_bits: BITS, ..config };
	let state = AppState::new(Db::open_in_memory().unwrap(), config);
	App { router: router(state.clone()), state }
}

fn app() -> App {
	app_with(false)
}

fn now() -> i64 {
	SystemTime::now().duration_since(UNIX_EPOCH).unwrap().as_secs() as i64
}

/// A well-formed chunk an hour old: `chunk`, `session` (with `build`), a quest accepted and a kill.
fn chunk(seq: u64, build: u32) -> String {
	chunk_at_level(seq, build, 5)
}

fn chunk_at_level(seq: u64, build: u32, level: u32) -> String {
	let epoch = now() - 3600;
	[
		format!("chunk\t0\t{seq}\t{epoch}\tc0ffee1234"),
		format!("session\t1\tc0ffee1234\tScourge\tWARRIOR\tHorde\t2\t{level}\tenUS\t{build}\t11508\t1\t\t2.0.0\t0.9.0\tguide:undead"),
		"accept\t30\t364\tc\t1568\t1420\t3010\t6620\t5\t250\t0\t\t".to_owned(),
		"kill\t52\t1501\t2\tn\t1420\t3100\t6700\t40\t0\t0\t364:1".to_owned(),
	]
	.join("\n")
}

fn upload_body(chunks: &[(u64, String)]) -> String {
	json!({ "uploader": "0.1.0", "install": INSTALL, "chunks": chunks.iter().map(|(seq, text)| json!({ "seq": seq, "text": text })).collect::<Vec<_>>() }).to_string()
}

async fn send_from(app: &App, ip: Option<&str>, method: Method, uri: &str, token: Option<&str>, body: Option<String>) -> (StatusCode, String) {
	let mut req = Request::builder().method(method).uri(uri);
	if let Some(ip) = ip {
		req = req.header("CF-Connecting-IP", ip);
	}
	if let Some(t) = token {
		req = req.header(header::AUTHORIZATION, format!("Bearer {t}"));
	}
	if body.is_some() {
		req = req.header(header::CONTENT_TYPE, "application/json");
	}
	let response = app.router.clone().oneshot(req.body(body.map_or_else(Body::empty, Body::from)).unwrap()).await.unwrap();
	let status = response.status();
	let bytes = response.into_body().collect().await.unwrap().to_bytes();
	(status, String::from_utf8(bytes.to_vec()).unwrap())
}

async fn send(app: &App, method: Method, uri: &str, token: Option<&str>, body: Option<String>) -> (StatusCode, String) {
	send_from(app, Some(IP_A), method, uri, token, body).await
}

async fn send_json(app: &App, ip: &str, method: Method, uri: &str, token: Option<&str>, body: Option<Value>) -> (StatusCode, Value) {
	let (status, body) = send_from(app, Some(ip), method, uri, token, body.map(|b| b.to_string())).await;
	(status, serde_json::from_str(&body).unwrap_or(Value::String(body)))
}

async fn challenge(app: &App, ip: &str) -> (StatusCode, Value) {
	send_json(app, ip, Method::POST, "/v1/register", None, Some(json!({}))).await
}

async fn solve(app: &App, ip: &str, challenge: &str, solution: u64) -> (StatusCode, Value) {
	send_json(app, ip, Method::POST, "/v1/register", None, Some(json!({ "challenge": challenge, "solution": solution.to_string() }))).await
}

/// Registers from `ip` and returns the token.
async fn register(app: &App, ip: &str) -> String {
	let (status, c) = challenge(app, ip).await;
	assert_eq!(status, StatusCode::OK, "{c}");
	let challenge = c["challenge"].as_str().unwrap();
	let (status, body) = solve(app, ip, challenge, pow_solve(challenge, c["difficulty"].as_u64().unwrap() as u32)).await;
	assert_eq!(status, StatusCode::OK, "{body}");
	body["token"].as_str().unwrap().to_owned()
}

async fn upload(app: &App, token: &str, chunks: &[(u64, String)]) -> (StatusCode, Value) {
	let (status, body) = send(app, Method::POST, "/v1/upload", Some(token), Some(upload_body(chunks))).await;
	(status, serde_json::from_str(&body).unwrap_or(Value::String(body)))
}

fn export_lines(body: &str) -> Vec<Value> {
	body.lines().map(|l| serde_json::from_str(l).unwrap()).collect()
}

async fn export(app: &App, query: &str) -> Vec<Value> {
	let (status, body) = send(app, Method::GET, &format!("/v1/export{query}"), Some(KEY), None).await;
	assert_eq!(status, StatusCode::OK, "{body}");
	export_lines(&body)
}

async fn contributors(app: &App) -> Vec<Value> {
	let (status, body) = send_json(app, IP_A, Method::GET, "/v1/admin/contributors", Some(KEY), None).await;
	assert_eq!(status, StatusCode::OK, "{body}");
	body.as_array().unwrap().clone()
}

#[tokio::test]
async fn healthz() {
	assert_eq!(send_from(&app(), None, Method::GET, "/healthz", None, None).await, (StatusCode::OK, "ok".to_owned()));
	// Through the tunnel (Cloudflare sets CF-Connecting-IP) it is not there.
	assert_eq!(send_from(&app(), Some(IP_A), Method::GET, "/healthz", None, None).await.0, StatusCode::NOT_FOUND);
}

#[tokio::test]
async fn register_happy_path() {
	let app = app();
	let (status, c) = challenge(&app, IP_A).await;
	assert_eq!(status, StatusCode::OK);
	let challenge = c["challenge"].as_str().unwrap();
	assert_eq!(challenge.len(), 32);
	assert_eq!(c["difficulty"], BITS);
	let expires = c["expires"].as_i64().unwrap();
	assert!((now() + 590..=now() + 600).contains(&expires), "{c}");
	let solution = pow_solve(challenge, BITS);
	let (status, body) = solve(&app, IP_A, challenge, solution).await;
	assert_eq!(status, StatusCode::OK, "{body}");
	let token = body["token"].as_str().unwrap();
	assert!(token.len() == 64 && token.bytes().all(|b| b.is_ascii_hexdigit()));
	// The token works; the challenge cannot be spent twice.
	assert_eq!(send(&app, Method::GET, "/v1/me", Some(token), None).await.0, StatusCode::OK);
	let (status, body) = solve(&app, IP_B, challenge, solution).await;
	assert_eq!((status, body), (StatusCode::BAD_REQUEST, json!({ "error": "challenge already used" })));
	// The contributor is listed from registration on, before any upload.
	let list = contributors(&app).await;
	assert_eq!(list.len(), 1);
	assert_eq!(list[0]["chunks"], 0);
}

#[tokio::test]
async fn wrong_solution_and_forged_challenge() {
	let app = app();
	let (_, c) = challenge(&app, IP_A).await;
	let challenge = c["challenge"].as_str().unwrap();
	let wrong = (0..).find(|n| !polestar_recording::api::pow_ok(challenge, *n, BITS)).unwrap();
	assert_eq!(solve(&app, IP_A, challenge, wrong).await, (StatusCode::BAD_REQUEST, json!({ "error": "wrong solution" })));
	// A challenge the server did not make (one hex digit changed).
	let mut forged = challenge.to_owned();
	let last = if forged.ends_with('0') { "1" } else { "0" };
	forged.replace_range(31.., last);
	assert_eq!(solve(&app, IP_A, &forged, pow_solve(&forged, BITS)).await, (StatusCode::BAD_REQUEST, json!({ "error": "bad challenge" })));
	let (status, _) = send_json(&app, IP_A, Method::POST, "/v1/register", None, Some(json!({ "challenge": challenge, "solution": "-1" }))).await;
	assert_eq!(status, StatusCode::BAD_REQUEST);
	let (status, _) = send_json(&app, IP_A, Method::POST, "/v1/register", None, Some(json!({ "challenge": challenge }))).await;
	assert_eq!(status, StatusCode::BAD_REQUEST);
	assert!(contributors(&app).await.is_empty());
}

#[tokio::test]
async fn expired_challenge() {
	let app = app();
	let challenge = make_challenge(&app.state, now() - 1).unwrap();
	assert_eq!(solve(&app, IP_A, &challenge, pow_solve(&challenge, BITS)).await, (StatusCode::BAD_REQUEST, json!({ "error": "challenge expired" })));
}

#[tokio::test]
async fn registrations_per_ip_per_day() {
	let app = app();
	for _ in 0..polestar_ingest::REGISTRATIONS_PER_DAY {
		register(&app, IP_A).await;
	}
	let (status, body) = challenge(&app, IP_A).await;
	assert_eq!(status, StatusCode::TOO_MANY_REQUESTS, "{body}");
	// Another address is unaffected; an IPv6 /48 counts as one address.
	register(&app, IP_B).await;
	for i in 0..polestar_ingest::REGISTRATIONS_PER_DAY {
		register(&app, &format!("2001:db8:1:{i}::{i}")).await;
	}
	assert_eq!(challenge(&app, "2001:db8:1:ffff::1").await.0, StatusCode::TOO_MANY_REQUESTS);
	assert_eq!(challenge(&app, "2001:db8:2::1").await.0, StatusCode::OK);
}

#[tokio::test]
async fn ipv6_registrations_are_also_capped_per_32() {
	let app = app();
	// One registration from each of many /48s in one /32 (a tunnel broker's, say).
	for i in 0..polestar_ingest::REGISTRATIONS_PER_DAY_V6_32 {
		register(&app, &format!("2001:db8:{i:x}::1")).await;
	}
	let (status, body) = challenge(&app, "2001:db8:ff::1").await;
	assert_eq!(status, StatusCode::TOO_MANY_REQUESTS, "{body}");
	// Another /32 and IPv4 are unaffected.
	register(&app, "2001:db9:1::1").await;
	register(&app, IP_A).await;
}

#[tokio::test]
async fn registration_counts_survive_a_restart() {
	let path = std::env::temp_dir().join(format!("polestar-ingest-test-{}-{}.sqlite", std::process::id(), now()));
	let open = || {
		let state = AppState::new(Db::open(&path).unwrap(), Config { maintainer_key: KEY.to_owned(), min_build: 0, secret: SECRET.to_owned(), pow_bits: BITS, ..Config::default() });
		App { router: router(state.clone()), state }
	};
	let first = open();
	for _ in 0..polestar_ingest::REGISTRATIONS_PER_DAY - 1 {
		register(&first, IP_A).await;
	}
	drop(first);
	let second = open();
	register(&second, IP_A).await;
	assert_eq!(challenge(&second, IP_A).await.0, StatusCode::TOO_MANY_REQUESTS, "the count is in the database");
	let cohorts: std::collections::BTreeSet<String> = {
		let a = register(&second, IP_B).await;
		upload(&second, &a, &[(1, chunk(1, 70532))]).await;
		export(&second, "").await.iter().map(|l| l["cohort"].as_str().unwrap().to_owned()).collect()
	};
	assert_eq!(cohorts.len(), 1);
	drop(second);
	for suffix in ["", "-wal", "-shm"] {
		let _ = std::fs::remove_file(format!("{}{suffix}", path.display()));
	}
}

#[tokio::test]
async fn cohorts_are_shared_per_network_and_month() {
	let app = app();
	let a1 = register(&app, IP_A).await;
	let a2 = register(&app, IP_A).await;
	let b = register(&app, IP_B).await;
	let v6a = register(&app, "2001:db8:7:1::1").await;
	let v6b = register(&app, "2001:db8:7:2::1").await;
	for t in [&a1, &a2, &b, &v6a, &v6b] {
		assert_eq!(upload(&app, t, &[(1, chunk(1, 70532))]).await.0, StatusCode::OK);
	}
	let lines = export(&app, "").await;
	let cohort = |i: usize| lines[i]["cohort"].as_str().unwrap().to_owned();
	assert!(lines.iter().all(|l| l["cohort"].as_str().unwrap().len() == 16));
	assert_eq!(cohort(0), cohort(1), "same address, same month");
	assert_ne!(cohort(0), cohort(2));
	assert_eq!(cohort(3), cohort(4), "same IPv6 /48");
	assert_ne!(lines[0]["contributor"], lines[1]["contributor"]);
	assert!(lines.iter().all(|l| l["cohort"] != l["contributor"]), "a cohort is not derived from the contributor");
}

#[tokio::test]
async fn register_requests_per_minute() {
	let app = app();
	for _ in 0..polestar_ingest::REGISTER_REQUESTS_PER_MINUTE {
		assert_eq!(challenge(&app, IP_A).await.0, StatusCode::OK);
	}
	assert_eq!(challenge(&app, IP_A).await.0, StatusCode::TOO_MANY_REQUESTS);
	assert_eq!(challenge(&app, IP_B).await.0, StatusCode::OK);
}

#[tokio::test]
async fn requests_per_ip_per_minute() {
	let app = app();
	for _ in 0..polestar_ingest::IP_REQUESTS_PER_MINUTE {
		assert_eq!(send(&app, Method::GET, "/v1/stats", None, None).await.0, StatusCode::OK);
	}
	assert_eq!(send(&app, Method::GET, "/v1/stats", None, None).await.0, StatusCode::TOO_MANY_REQUESTS);
	assert_eq!(send_from(&app, Some(IP_B), Method::GET, "/v1/stats", None, None).await.0, StatusCode::OK);
}

#[tokio::test]
async fn unknown_token_is_401() {
	let app = app();
	let unknown = "a".repeat(64);
	for (method, uri, body) in [(Method::POST, "/v1/upload", Some(upload_body(&[(1, chunk(1, 70532))]))), (Method::GET, "/v1/me", None), (Method::DELETE, "/v1/me", None)] {
		let (status, body) = send(&app, method, uri, Some(&unknown), body).await;
		assert_eq!((status, serde_json::from_str::<Value>(&body).unwrap()), (StatusCode::UNAUTHORIZED, json!({ "error": "unknown token" })), "{uri}");
	}
	assert_eq!(send(&app, Method::GET, "/v1/me", Some("short"), None).await.1, r#"{"error":"unknown token"}"#);
	// A deleted contributor's token is unknown from then on.
	let token = register(&app, IP_A).await;
	assert_eq!(send(&app, Method::DELETE, "/v1/me", Some(&token), None).await.0, StatusCode::OK);
	assert_eq!(send(&app, Method::GET, "/v1/me", Some(&token), None).await.0, StatusCode::UNAUTHORIZED);
}

#[tokio::test]
async fn missing_client_ip_is_refused() {
	let app = app();
	for (method, uri) in [(Method::GET, "/v1/stats"), (Method::POST, "/v1/register"), (Method::GET, "/v1/export")] {
		let (status, body) = send_from(&app, None, method, uri, None, Some("{}".to_owned())).await;
		assert_eq!(status, StatusCode::FORBIDDEN, "{uri} {body}");
	}
	assert_eq!(send_from(&app, Some("not an address"), Method::GET, "/v1/stats", None, None).await.0, StatusCode::BAD_REQUEST);
	// Allowed for local development.
	let direct = app_with(true);
	assert_eq!(send_from(&direct, None, Method::GET, "/v1/stats", None, None).await.0, StatusCode::OK);
}

#[tokio::test]
async fn accepts_then_reports_duplicates_and_rejects_malformed() {
	let app = app();
	let a = register(&app, IP_A).await;
	let b = register(&app, IP_B).await;
	let (status, body) = upload(&app, &a, &[(1, chunk(1, 70532)), (2, chunk(2, 70532))]).await;
	assert_eq!(status, StatusCode::OK, "{body}");
	assert_eq!(body, json!({ "accepted": [1, 2], "duplicate": [], "rejected": [] }));

	// The same (install, seq) again is a duplicate, also within one request.
	let malformed = chunk(4, 70532).replace("kill\t52\t1501", "kill\t52\tnot-a-number");
	let (status, body) = upload(&app, &a, &[(2, chunk(2, 70532)), (3, chunk(3, 70532)), (3, chunk(3, 70532)), (4, malformed), (5, chunk(6, 70532))]).await;
	assert_eq!(status, StatusCode::OK, "{body}");
	assert_eq!(body["accepted"], json!([3]));
	assert_eq!(body["duplicate"], json!([2, 3]));
	let rejected: Vec<u64> = body["rejected"].as_array().unwrap().iter().map(|r| r["seq"].as_u64().unwrap()).collect();
	assert_eq!(rejected, [4, 5], "{body}");
	assert!(body["rejected"].as_array().unwrap().iter().all(|r| !r["reason"].as_str().unwrap().is_empty()));

	// Another contributor's seq 1 is its own chunk.
	let (_, body) = upload(&app, &b, &[(1, chunk(1, 70532))]).await;
	assert_eq!(body["accepted"], json!([1]));

	let (status, me) = send(&app, Method::GET, "/v1/me", Some(&a), None).await;
	assert_eq!(status, StatusCode::OK);
	let me: Value = serde_json::from_str(&me).unwrap();
	assert_eq!(me["chunks"], 3);
	assert_eq!(me["records"]["accept"], 3);
	assert_eq!(me["records"]["kill"], 3);
	assert!(me["first_upload"].is_i64() && me["last_upload"].is_i64());

	let (status, stats) = send(&app, Method::GET, "/v1/stats", None, None).await;
	assert_eq!(status, StatusCode::OK);
	let stats: Value = serde_json::from_str(&stats).unwrap();
	assert_eq!(stats["contributors"], 2);
	assert_eq!(stats["chunks"], 4);
	assert_eq!(stats["quests"], 1);
	assert_eq!(stats["records"]["session"], 4);
	assert_eq!(stats["last30"][0]["chunks"], 4);

	// Every export line says how long the contributor has been around and how much it sent.
	let lines = export(&app, "").await;
	assert_eq!(lines.len(), 4);
	assert!(lines.iter().all(|l| l["contributorSince"].as_i64().unwrap() > now() - 60 && l.get("suspect").is_none()));
	assert_eq!(lines.iter().map(|l| l["contributorChunks"].as_u64().unwrap()).collect::<Vec<_>>(), [3, 3, 3, 1]);
}

#[tokio::test]
async fn bad_requests() {
	let app = app();
	let a = register(&app, IP_A).await;
	let (status, _) = send(&app, Method::POST, "/v1/upload", Some(&a), Some("{not json".to_owned())).await;
	assert_eq!(status, StatusCode::BAD_REQUEST);
	let bad_install = upload_body(&[(1, chunk(1, 70532))]).replace(INSTALL, "../etc");
	let (status, _) = send(&app, Method::POST, "/v1/upload", Some(&a), Some(bad_install)).await;
	assert_eq!(status, StatusCode::BAD_REQUEST);
	let (status, _) = send(&app, Method::GET, "/v1/export?include=everything", Some(KEY), None).await;
	assert_eq!(status, StatusCode::BAD_REQUEST);
}

#[tokio::test]
async fn old_builds_are_stored_flagged() {
	let app = app();
	let a = register(&app, IP_A).await;
	let (_, body) = upload(&app, &a, &[(1, chunk(1, 70000)), (2, chunk(2, 70532))]).await;
	assert_eq!(body["accepted"], json!([1, 2]));
	let lines = export(&app, "").await;
	assert_eq!(lines.iter().map(|l| l["flagged"].as_bool().unwrap()).collect::<Vec<_>>(), [true, false]);
}

#[tokio::test]
async fn suspect_chunks_are_accepted_but_left_out_of_the_export() {
	let app = app();
	let a = register(&app, IP_A).await;
	let (status, body) = upload(&app, &a, &[(1, chunk(1, 70532)), (2, chunk_at_level(2, 70532, 99))]).await;
	assert_eq!(status, StatusCode::OK);
	assert_eq!(body, json!({ "accepted": [1, 2], "duplicate": [], "rejected": [] }), "the sender is not told");
	let lines = export(&app, "").await;
	assert_eq!(lines.iter().map(|l| l["seq"].as_u64().unwrap()).collect::<Vec<_>>(), [1]);
	assert_eq!(lines[0]["contributorChunks"], 1, "suspect chunks do not count");
	let all = export(&app, "?include=suspect").await;
	assert_eq!(all.len(), 2);
	assert_eq!(all[1]["suspect"], true);
	assert_eq!(all[1]["suspectReasons"], json!(["level: session level 99"]));
	let list = contributors(&app).await;
	assert_eq!((list[0]["chunks"].as_u64(), list[0]["suspectChunks"].as_u64()), (Some(2), Some(1)));
	// A chunk too old for the addon to still hold is suspect too.
	let (_, body) = upload(&app, &a, &[(500, chunk(500, 70532)), (3, chunk(3, 70532))]).await;
	assert_eq!(body["accepted"], json!([500, 3]));
	assert_eq!(export(&app, "").await.iter().map(|l| l["seq"].as_u64().unwrap()).collect::<Vec<_>>(), [1, 500]);
}

#[tokio::test]
async fn blocked_contributors_are_shadow_banned() {
	let app = app();
	let a = register(&app, IP_A).await;
	let b = register(&app, IP_B).await;
	upload(&app, &a, &[(1, chunk(1, 70532))]).await;
	upload(&app, &b, &[(1, chunk(1, 70532))]).await;
	let lines = export(&app, "").await;
	let prefix = lines[0]["contributor"].as_str().unwrap().to_owned();
	let (status, body) = send_json(&app, IP_A, Method::POST, &format!("/v1/admin/contributors/{prefix}/block"), Some(KEY), None).await;
	assert_eq!(status, StatusCode::OK, "{body}");
	assert_eq!(body["blocked"], true);
	assert!(body["hash"].as_str().unwrap().starts_with(&prefix));

	// Answered like anyone's, duplicates and /v1/me included, but nothing of it is held: its
	// chunks leave the export (also with suspects) and the stats.
	let (status, body) = upload(&app, &a, &[(2, chunk(2, 70532)), (3, chunk(3, 70532).replace("kill\t52\t1501", "kill\t52\tx"))]).await;
	assert_eq!(status, StatusCode::OK);
	assert_eq!(body["accepted"], json!([2]));
	assert_eq!(body["rejected"][0]["seq"], 3);
	let (_, body) = upload(&app, &a, &[(2, chunk(2, 70532)), (1, chunk(1, 70532))]).await;
	assert_eq!(body, json!({ "accepted": [], "duplicate": [2, 1], "rejected": [] }));
	let (_, me) = send_json(&app, IP_A, Method::GET, "/v1/me", Some(&a), None).await;
	assert_eq!(me["chunks"], 2);
	for query in ["", "?include=suspect"] {
		let lines = export(&app, query).await;
		assert_eq!(lines.len(), 1);
		assert_ne!(lines[0]["contributor"], prefix.as_str());
	}
	let (_, stats) = send_json(&app, IP_B, Method::GET, "/v1/stats", None, None).await;
	assert_eq!((stats["contributors"].as_u64(), stats["chunks"].as_u64()), (Some(1), Some(1)));
	let list = contributors(&app).await;
	let blocked = list.iter().find(|c| c["hash"].as_str().unwrap().starts_with(&prefix)).unwrap();
	assert_eq!((blocked["blocked"].as_bool(), blocked["chunks"].as_u64()), (Some(true), Some(2)));
	let (status, body) = send(&app, Method::GET, "/v1/export/tombstones", Some(KEY), None).await;
	assert_eq!(status, StatusCode::OK);
	let tombs = export_lines(&body);
	assert_eq!((tombs.len(), tombs[0]["contributor"].as_str(), tombs[0]["why"].as_str()), (1, Some(prefix.as_str()), Some("blocked")));

	let (_, storage) = send_json(&app, IP_A, Method::GET, "/v1/admin/storage", Some(KEY), None).await;
	assert_eq!(storage["rows"]["chunks"], 1, "the block deleted its chunks and stored none since: {storage}");

	// Unblocked: what it held is gone for good; what it sends from now on is stored again.
	let (status, _) = send(&app, Method::POST, &format!("/v1/admin/contributors/{prefix}/unblock"), Some(KEY), None).await;
	assert_eq!(status, StatusCode::OK);
	assert_eq!(export(&app, "").await.len(), 1);
	assert_eq!(upload(&app, &a, &[(4, chunk(4, 70532))]).await.1["accepted"], json!([4]));
	assert_eq!(export(&app, "").await.len(), 2);
	let (_, body) = send(&app, Method::GET, "/v1/export/tombstones", Some(KEY), None).await;
	assert!(body.is_empty(), "the blocked tombstone goes on unblock: {body}");
	// A deleted contributor's tombstone stays whatever happens to others.
	assert_eq!(send(&app, Method::DELETE, "/v1/me", Some(&b), None).await.0, StatusCode::OK);
	send(&app, Method::POST, &format!("/v1/admin/contributors/{prefix}/block"), Some(KEY), None).await;
	send(&app, Method::POST, &format!("/v1/admin/contributors/{prefix}/unblock"), Some(KEY), None).await;
	let (_, body) = send(&app, Method::GET, "/v1/export/tombstones", Some(KEY), None).await;
	assert_eq!(export_lines(&body).iter().map(|t| t["why"].as_str().unwrap().to_owned()).collect::<Vec<_>>(), ["deleted"]);

	let (status, _) = send(&app, Method::POST, &format!("/v1/admin/contributors/{}/block", "0".repeat(16)), Some(KEY), None).await;
	assert_eq!(status, StatusCode::NOT_FOUND);
	let (status, _) = send(&app, Method::POST, "/v1/admin/contributors/abc/block", Some(KEY), None).await;
	assert_eq!(status, StatusCode::BAD_REQUEST);
}

#[tokio::test]
async fn admin_auth() {
	let app = app();
	let a = register(&app, IP_A).await;
	let prefix = "0".repeat(16);
	for (method, uri) in [
		(Method::GET, "/v1/export".to_owned()),
		(Method::GET, "/v1/admin/contributors".to_owned()),
		(Method::POST, format!("/v1/admin/contributors/{prefix}/block")),
		(Method::POST, format!("/v1/admin/contributors/{prefix}/unblock")),
	] {
		for key in [None, Some(a.as_str()), Some(&KEY[..63])] {
			assert_eq!(send(&app, method.clone(), &uri, key, None).await.0, StatusCode::UNAUTHORIZED, "{uri} {key:?}");
		}
	}
	assert_eq!(send(&app, Method::GET, "/v1/export", Some(KEY), None).await.0, StatusCode::OK);
	assert_eq!(send(&app, Method::GET, "/v1/admin/contributors", Some(KEY), None).await.0, StatusCode::OK);
}

#[tokio::test]
async fn body_over_two_mib_is_refused() {
	let app = app();
	let a = register(&app, IP_A).await;
	let big = "x".repeat(polestar_ingest::MAX_BODY);
	let (status, _) = send(&app, Method::POST, "/v1/upload", Some(&a), Some(upload_body(&[(1, big)]))).await;
	assert_eq!(status, StatusCode::PAYLOAD_TOO_LARGE);
	let (status, _) = send(&app, Method::POST, "/v1/register", None, Some(format!("{{\"challenge\":\"{}\"}}", "0".repeat(2000)))).await;
	assert_eq!(status, StatusCode::PAYLOAD_TOO_LARGE);
}

#[tokio::test]
async fn daily_cap() {
	let app = app();
	let a = register(&app, IP_A).await;
	let b = register(&app, IP_B).await;
	// Each body is just under 2 MiB; the chunk is junk (rejected) but its bytes still count.
	let junk = "x".repeat(polestar_ingest::MAX_BODY - 200);
	let per_request = upload_body(&[(1, junk.clone())]).len() as u64;
	let fits = polestar_ingest::DAILY_BYTES / per_request;
	for _ in 0..fits {
		let (status, _) = upload(&app, &a, &[(1, junk.clone())]).await;
		assert_eq!(status, StatusCode::OK);
	}
	let (status, body) = upload(&app, &a, &[(1, junk)]).await;
	assert_eq!(status, StatusCode::TOO_MANY_REQUESTS, "{body}");
	// Refused on the declared size alone, before the body is read.
	let req = Request::builder()
		.method(Method::POST)
		.uri("/v1/upload")
		.header("CF-Connecting-IP", IP_A)
		.header(header::AUTHORIZATION, format!("Bearer {a}"))
		.header(header::CONTENT_LENGTH, polestar_ingest::MAX_BODY.to_string())
		.body(Body::from_stream(futures_util::stream::pending::<Result<Vec<u8>, std::io::Error>>()))
		.unwrap();
	assert_eq!(app.router.clone().oneshot(req).await.unwrap().status(), StatusCode::TOO_MANY_REQUESTS);
	// Another contributor is unaffected.
	let (status, _) = upload(&app, &b, &[(1, chunk(1, 70532))]).await;
	assert_eq!(status, StatusCode::OK);
}

#[tokio::test(start_paused = true)]
async fn a_body_that_never_arrives_counts_against_the_daily_cap() {
	let app = app();
	let a = register(&app, IP_A).await;
	let stalled = || {
		Request::builder()
			.method(Method::POST)
			.uri("/v1/upload")
			.header("CF-Connecting-IP", IP_A)
			.header(header::AUTHORIZATION, format!("Bearer {a}"))
			.header(header::CONTENT_LENGTH, polestar_ingest::MAX_BODY.to_string())
			.body(Body::from_stream(futures_util::stream::pending::<Result<Vec<u8>, std::io::Error>>()))
			.unwrap()
	};
	for _ in 0..polestar_ingest::DAILY_BYTES / polestar_ingest::MAX_BODY as u64 {
		assert_eq!(app.router.clone().oneshot(stalled()).await.unwrap().status(), StatusCode::REQUEST_TIMEOUT);
	}
	let (status, body) = upload(&app, &a, &[(1, chunk(1, 70532))]).await;
	assert_eq!(status, StatusCode::TOO_MANY_REQUESTS, "{body}");
}

#[tokio::test]
async fn purge_deletes_a_contributor_for_good() {
	let app = app();
	let a = register(&app, IP_A).await;
	let b = register(&app, IP_B).await;
	upload(&app, &a, &[(1, chunk(1, 70532))]).await;
	upload(&app, &b, &[(1, chunk(1, 70532))]).await;
	let prefix = export(&app, "").await[0]["contributor"].as_str().unwrap().to_owned();
	let uri = format!("/v1/admin/contributors/{prefix}/purge");
	assert_eq!(send(&app, Method::POST, &uri, None, None).await.0, StatusCode::UNAUTHORIZED);
	let (status, body) = send_json(&app, IP_A, Method::POST, &uri, Some(KEY), None).await;
	assert_eq!((status, body["purged"].as_bool()), (StatusCode::OK, Some(true)), "{body}");
	assert_eq!(export(&app, "").await.len(), 1);
	assert_eq!(contributors(&app).await.len(), 1);
	assert_eq!(send(&app, Method::GET, "/v1/me", Some(&a), None).await.0, StatusCode::UNAUTHORIZED);
	let (_, body) = send(&app, Method::GET, "/v1/export/tombstones", Some(KEY), None).await;
	let tombs = export_lines(&body);
	assert_eq!((tombs.len(), tombs[0]["contributor"].as_str(), tombs[0]["why"].as_str()), (1, Some(prefix.as_str()), Some("deleted")));
	let (_, stats) = send_json(&app, IP_B, Method::GET, "/v1/stats", None, None).await;
	assert_eq!(stats["contributors"], 1);
	assert_eq!(send(&app, Method::POST, &uri, Some(KEY), None).await.0, StatusCode::NOT_FOUND);
}

#[tokio::test]
async fn rate_limit_per_token() {
	let app = app();
	let a = register(&app, IP_A).await;
	let b = register(&app, IP_B).await;
	for _ in 0..polestar_ingest::REQUESTS_PER_MINUTE {
		assert_eq!(send(&app, Method::GET, "/v1/me", Some(&a), None).await.0, StatusCode::OK);
	}
	assert_eq!(send(&app, Method::GET, "/v1/me", Some(&a), None).await.0, StatusCode::TOO_MANY_REQUESTS);
	assert_eq!(send(&app, Method::GET, "/v1/me", Some(&b), None).await.0, StatusCode::OK);
}

#[tokio::test]
async fn auth_failures() {
	let app = app();
	assert_eq!(send(&app, Method::POST, "/v1/upload", None, Some(upload_body(&[(1, chunk(1, 70532))]))).await.0, StatusCode::UNAUTHORIZED);
	assert_eq!(send(&app, Method::DELETE, "/v1/me", None, None).await.0, StatusCode::UNAUTHORIZED);
}

#[tokio::test]
async fn delete_removes_everything_from_that_token() {
	let app = app();
	let a = register(&app, IP_A).await;
	let b = register(&app, IP_B).await;
	upload(&app, &a, &[(1, chunk(1, 70532)), (2, chunk(2, 70532))]).await;
	upload(&app, &b, &[(1, chunk(1, 70532))]).await;
	let (status, body) = send(&app, Method::DELETE, "/v1/me", Some(&a), None).await;
	assert_eq!(status, StatusCode::OK);
	assert_eq!(serde_json::from_str::<Value>(&body).unwrap(), json!({ "deleted": 2 }));
	assert_eq!(export(&app, "").await.len(), 1, "only the other contributor's chunk is left");
	assert_eq!(contributors(&app).await.len(), 1);
	// Forge learns of it from the tombstones.
	let (status, body) = send(&app, Method::GET, "/v1/export/tombstones?after=0", Some(KEY), None).await;
	assert_eq!(status, StatusCode::OK);
	let tombs = export_lines(&body);
	assert_eq!(tombs.len(), 1);
	assert_eq!(tombs[0]["why"], "deleted");
	assert_eq!(tombs[0]["contributor"].as_str().unwrap().len(), 16);
	let at = tombs[0]["at"].as_i64().unwrap();
	let (_, body) = send(&app, Method::GET, &format!("/v1/export/tombstones?after={at}"), Some(KEY), None).await;
	assert!(body.is_empty());
	assert_eq!(send(&app, Method::GET, "/v1/export/tombstones", None, None).await.0, StatusCode::UNAUTHORIZED);
	// Uploading again takes a new registration.
	assert_eq!(upload(&app, &a, &[(1, chunk(1, 70532))]).await.0, StatusCode::UNAUTHORIZED);
	let a = register(&app, IP_A).await;
	let (_, body) = upload(&app, &a, &[(1, chunk(1, 70532))]).await;
	assert_eq!(body["accepted"], json!([1]));
}

#[tokio::test]
async fn export_pages() {
	let app = app();
	let a = register(&app, IP_A).await;
	upload(&app, &a, &(1..=5).map(|s| (s, chunk(s, 70532))).collect::<Vec<_>>()).await;
	let first = export(&app, "?limit=2").await;
	assert_eq!(first.len(), 2);
	assert_eq!(first[0]["contributor"].as_str().unwrap().len(), 16);
	assert_eq!(first[0]["install"], INSTALL);
	assert_eq!(first[0]["seq"], 1);
	assert!(first[0]["text"].as_str().unwrap().starts_with("chunk\t0\t1\t"));
	let after = first[1]["id"].as_i64().unwrap();
	let rest = export(&app, &format!("?after={after}&limit=10")).await;
	assert_eq!(rest.iter().map(|l| l["seq"].as_u64().unwrap()).collect::<Vec<_>>(), [3, 4, 5]);
	let last = rest[2]["id"].as_i64().unwrap();
	assert!(export(&app, &format!("?after={last}")).await.is_empty());
}

#[tokio::test]
async fn cors_allows_the_uploader_only() {
	let app = app();
	let preflight = |origin: &str| {
		Request::builder()
			.method(Method::OPTIONS)
			.uri("/v1/upload")
			.header(header::ORIGIN, origin)
			.header(header::ACCESS_CONTROL_REQUEST_METHOD, "POST")
			.header(header::ACCESS_CONTROL_REQUEST_HEADERS, "authorization,content-type")
			.body(Body::empty())
			.unwrap()
	};
	for origin in ["tauri://localhost", "http://tauri.localhost", "https://tauri.localhost"] {
		let response = app.router.clone().oneshot(preflight(origin)).await.unwrap();
		assert_eq!(response.headers().get(header::ACCESS_CONTROL_ALLOW_ORIGIN).unwrap(), origin);
	}
	let response = app.router.clone().oneshot(preflight("https://example.com")).await.unwrap();
	assert!(response.headers().get(header::ACCESS_CONTROL_ALLOW_ORIGIN).is_none());
}

#[tokio::test]
async fn upload_caps() {
	let app = app();
	let a = register(&app, IP_A).await;
	let many: Vec<_> = (1..=polestar_recording::api::MAX_UPLOAD_CHUNKS as u64 + 1).map(|s| (s, chunk(s, 70532))).collect();
	let (status, body) = upload(&app, &a, &many).await;
	assert_eq!(status, StatusCode::BAD_REQUEST, "{body}");
	assert!(export(&app, "").await.is_empty());
	let (status, body) = upload(&app, &a, &many[..polestar_recording::api::MAX_UPLOAD_CHUNKS]).await;
	assert_eq!(status, StatusCode::OK, "{body}");
	assert_eq!(body["accepted"].as_array().unwrap().len(), polestar_recording::api::MAX_UPLOAD_CHUNKS);
	// One chunk over 64 KiB, one over 4096 records: rejected, the rest of the upload stored.
	let big = format!("{}\n{}", chunk(300, 70532), "afk\t1\t1\n".repeat(9000));
	let long = format!("{}\n{}", chunk(301, 70532), "afk\t1\t1\n".repeat(polestar_recording::api::MAX_CHUNK_RECORDS));
	let (status, body) = upload(&app, &a, &[(300, big), (301, long), (302, chunk(302, 70532))]).await;
	assert_eq!(status, StatusCode::OK, "{body}");
	assert_eq!(body["accepted"], json!([302]));
	assert_eq!(body["rejected"].as_array().unwrap().iter().map(|r| r["seq"].as_u64().unwrap()).collect::<Vec<_>>(), [300, 301], "{body}");
}

#[tokio::test]
async fn export_pages_are_capped_by_bytes() {
	let app = app();
	let a = register(&app, IP_A).await;
	// About 50 KiB a chunk (known records): 8 MiB is about 160 of them.
	let fat = |s: u64| format!("{}\n{}", chunk(s, 70532), format!("zone\t5\t\t\t\t{}\t\n", "A".repeat(90)).repeat(480));
	for batch in 0..9u64 {
		let chunks: Vec<_> = (1..=20).map(|i| batch * 20 + i).map(|s| (s, fat(s))).collect();
		let (status, body) = upload(&app, &a, &chunks).await;
		assert_eq!(status, StatusCode::OK, "{body}");
		assert_eq!(body["accepted"].as_array().unwrap().len(), 20, "{body}");
	}
	let page = export(&app, "?limit=1000").await;
	let bytes: usize = page.iter().map(|l| l["text"].as_str().unwrap().len()).sum();
	assert!(page.len() < 180 && bytes <= polestar_ingest::db::EXPORT_MAX_BYTES, "{} lines, {bytes} bytes", page.len());
	let after = page.last().unwrap()["id"].as_i64().unwrap();
	assert_eq!(page.len() + export(&app, &format!("?after={after}&limit=1000")).await.len(), 180);
}

/// Many tiny chunks full of map records with distinct ids: bounded work, and the database
/// stays free for others meanwhile.
#[tokio::test]
async fn map_heavy_uploads_stay_cheap() {
	let app = app();
	let a = register(&app, IP_A).await;
	let maps = |seq: u64, from: u32| {
		let epoch = now() - 3600;
		let mut text = format!("chunk\t0\t{seq}\t{epoch}\tc0ffee1234\n");
		for id in from..from + 4000 {
			text.push_str(&format!("map\t0\t{}\t3\t\t\t0\t0\t1\t1\n", id % 99_999 + 1));
			if text.len() > 60 * 1024 {
				break;
			}
		}
		text
	};
	let started = std::time::Instant::now();
	for round in 0..4u64 {
		// Just under 2 MiB of JSON: 20 chunks of 60 KiB of map records.
		let chunks: Vec<_> = (1..=20).map(|i| round * 20 + i).map(|s| (s, maps(s, s as u32 * 3000))).collect();
		let (status, body) = upload(&app, &a, &chunks).await;
		assert_eq!(status, StatusCode::OK, "{body}");
		// And a 2 MiB body of tiny chunks: refused as a whole, unread past the chunk count.
		let tiny: Vec<_> = (1..=75_000u64).map(|s| (s, "c".to_owned())).collect();
		assert_eq!(upload(&app, &a, &tiny).await.0, StatusCode::BAD_REQUEST);
	}
	let took = started.elapsed();
	assert!(took < std::time::Duration::from_secs(if cfg!(debug_assertions) { 20 } else { 4 }), "{took:?}");
	assert_eq!(send_from(&app, None, Method::GET, "/healthz", None, None).await.0, StatusCode::OK);
}

#[tokio::test]
async fn chunk_text_round_trips_through_compression() {
	let app = app();
	let a = register(&app, IP_A).await;
	let text = format!("{}\nzone\t60\t\t\t\tÉtang de Rûne — ünïcode\t\n", chunk(1, 70532));
	assert_eq!(upload(&app, &a, &[(1, text.clone())]).await.1["accepted"], json!([1]));
	assert_eq!(export(&app, "").await[0]["text"], text.as_str());
}

async fn ack(app: &App, upto: i64) -> (StatusCode, Value) {
	send_json(app, IP_A, Method::POST, "/v1/export/ack", Some(KEY), Some(json!({ "upto": upto }))).await
}

#[tokio::test]
async fn acknowledged_chunks_are_pruned_after_the_retention_and_counts_stay() {
	let app = app();
	let a = register(&app, IP_A).await;
	let b = register(&app, IP_B).await;
	upload(&app, &a, &(1..=3).map(|s| (s, chunk(s, 70532))).collect::<Vec<_>>()).await;
	upload(&app, &b, &[(1, chunk(1, 70532))]).await;
	let lines = export(&app, "").await;
	let (_, me_before) = send_json(&app, IP_A, Method::GET, "/v1/me", Some(&a), None).await;

	// The maintainer key only; an ack prunes nothing younger than the retention.
	assert_eq!(send_json(&app, IP_A, Method::POST, "/v1/export/ack", Some(&a), Some(json!({ "upto": 9 }))).await.0, StatusCode::UNAUTHORIZED);
	let upto = lines[2]["id"].as_i64().unwrap();
	let (status, body) = ack(&app, upto).await;
	assert_eq!(status, StatusCode::OK, "{body}");
	assert_eq!((body["acked"].as_i64(), body["pruned"].as_u64(), body["held"].as_u64()), (Some(upto), Some(0), Some(4)));
	// A bogus ack past the last chunk is clamped, so later chunks are never pruned unpulled.
	assert_eq!(ack(&app, 1_000_000).await.1["acked"], lines[3]["id"]);

	// Past the retention: everything acknowledged goes (upto is the fourth line, b's).
	let (status, storage) = send_json(&app, IP_A, Method::GET, "/v1/admin/storage", Some(KEY), None).await;
	assert_eq!(status, StatusCode::OK, "{storage}");
	assert_eq!((storage["acked"].as_i64(), storage["rows"]["chunks"].as_u64(), storage["uploadsRefused"].is_null()), (lines[3]["id"].as_i64(), Some(4), true));
	assert!(storage["oldestUnackedAge"].is_null() && storage["oldestAge"].as_i64().unwrap() < 60 && storage["dbBytes"].as_u64().unwrap() > 0, "{storage}");
	assert_eq!(send(&app, Method::GET, "/v1/admin/storage", Some(&a), None).await.0, StatusCode::UNAUTHORIZED);
	let later = now() + polestar_ingest::RETAIN_DAYS * 86_400 + 60;
	assert_eq!(app.state.maintain(later).unwrap(), 4);
	assert!(export(&app, "").await.is_empty());
	// The counts are the same.
	let (_, me_after) = send_json(&app, IP_A, Method::GET, "/v1/me", Some(&a), None).await;
	assert_eq!(me_after, me_before);
	// (The first /v1/stats of this app: computed now, not cached from before.)
	let (_, stats) = send_json(&app, IP_B, Method::GET, "/v1/stats", None, None).await;
	assert_eq!((stats["contributors"].as_u64(), stats["chunks"].as_u64(), stats["quests"].as_u64()), (Some(2), Some(4), Some(1)));
	assert_eq!((stats["records"]["accept"].as_u64(), stats["last30"][0]["chunks"].as_u64(), stats["last30"][0]["contributors"].as_u64()), (Some(4), Some(4), Some(2)));
	// A pruned chunk sent again is a duplicate, not stored again; a new one exports with the
	// contributor's figures counting the pruned ones.
	let (_, body) = upload(&app, &a, &[(2, chunk(2, 70532)), (4, chunk(4, 70532))]).await;
	assert_eq!(body, json!({ "accepted": [4], "duplicate": [2], "rejected": [] }));
	let lines = export(&app, "").await;
	assert_eq!(lines.len(), 1);
	assert_eq!((lines[0]["seq"].as_u64(), lines[0]["contributorChunks"].as_u64()), (Some(4), Some(4)));
	// Not acknowledged yet: kept however old.
	assert_eq!(app.state.maintain(later + 30 * 86_400).unwrap(), 0);
	let mut chunks: Vec<u64> = contributors(&app).await.iter().map(|c| c["chunks"].as_u64().unwrap()).collect();
	chunks.sort();
	assert_eq!(chunks, [1, 4]);
	// Deleting still deletes everything, the counts too.
	let (_, body) = send_json(&app, IP_A, Method::DELETE, "/v1/me", Some(&a), None).await;
	assert_eq!(body, json!({ "deleted": 4 }));
	assert_eq!(contributors(&app).await.len(), 1);
}

#[tokio::test]
async fn uploads_get_503_when_the_database_or_the_disk_is_full() {
	for config in [Config { max_db_bytes: 1, ..Config::default() }, Config { data_dir: Some(std::env::temp_dir()), min_free_bytes: u64::MAX, ..Config::default() }] {
		let app = app_config(config);
		let a = register(&app, IP_A).await;
		let (status, body) = send(&app, Method::POST, "/v1/upload", Some(&a), Some(upload_body(&[(1, chunk(1, 70532))]))).await;
		assert_eq!((status, serde_json::from_str::<Value>(&body).unwrap()), (StatusCode::SERVICE_UNAVAILABLE, json!({ "error": "server busy, try later" })));
		let req = Request::builder()
			.method(Method::POST)
			.uri("/v1/upload")
			.header("CF-Connecting-IP", IP_A)
			.header(header::AUTHORIZATION, format!("Bearer {a}"))
			.body(Body::from(upload_body(&[(1, chunk(1, 70532))])))
			.unwrap();
		let response = app.router.clone().oneshot(req).await.unwrap();
		assert!(response.headers().get(header::RETRY_AFTER).is_some());
		// The rest still answers, and the maintainer sees why.
		assert_eq!(send(&app, Method::GET, "/v1/me", Some(&a), None).await.0, StatusCode::OK);
		let (_, storage) = send_json(&app, IP_A, Method::GET, "/v1/admin/storage", Some(KEY), None).await;
		assert!(storage["uploadsRefused"].is_string(), "{storage}");
	}
	// With room, the same upload goes through.
	let app = app_config(Config { data_dir: Some(std::env::temp_dir()), min_free_bytes: 1, ..Config::default() });
	let a = register(&app, IP_A).await;
	assert_eq!(upload(&app, &a, &[(1, chunk(1, 70532))]).await.0, StatusCode::OK);
}

#[tokio::test]
async fn backup_is_a_readable_copy_and_keeps_seven() {
	let dir = std::env::temp_dir().join(format!("polestar-ingest-backup-{}-{}", std::process::id(), now()));
	std::fs::create_dir_all(&dir).unwrap();
	let path = dir.join("ingest.sqlite");
	let state = AppState::new(Db::open(&path).unwrap(), Config { maintainer_key: KEY.to_owned(), secret: SECRET.to_owned(), pow_bits: BITS, ..Config::default() });
	let app = App { router: router(state.clone()), state };
	let a = register(&app, IP_A).await;
	upload(&app, &a, &[(1, chunk(1, 0))]).await;
	let out = dir.join("backups");
	std::fs::create_dir_all(&out).unwrap();
	for day in 1..=8 {
		std::fs::write(out.join(format!("ingest-2026-01-0{day}.sqlite.gz")), b"old").unwrap();
	}
	std::fs::write(out.join("other.txt"), b"not a backup").unwrap();
	let dest = out.join("ingest-2026-10-27.sqlite.gz");
	let size = polestar_ingest::backup::backup(&path, &dest).unwrap();
	assert!(size > 100);
	let mut names: Vec<String> = std::fs::read_dir(&out).unwrap().map(|e| e.unwrap().file_name().into_string().unwrap()).collect();
	names.sort();
	assert_eq!(names.len(), 8, "{names:?}");
	assert_eq!(names[0], "ingest-2026-01-03.sqlite.gz");
	assert!(names.contains(&"other.txt".to_owned()) && names.contains(&"ingest-2026-10-27.sqlite.gz".to_owned()));
	assert!(!names.iter().any(|n| n.starts_with('.')), "no temporary file left: {names:?}");
	#[cfg(unix)]
	{
		use std::os::unix::fs::PermissionsExt;
		assert_eq!(std::fs::metadata(&dest).unwrap().permissions().mode() & 0o777, 0o600);
	}
	// Gunzipped, it opens as the database with the chunk in it, without today's salt and
	// registration counts, and as a new instance.
	let instance = export(&app, "").await[0]["instance"].as_str().unwrap().to_owned();
	let restored = dir.join("restored.sqlite");
	let mut gz = flate2::read::GzDecoder::new(std::fs::File::open(&dest).unwrap());
	std::io::copy(&mut gz, &mut std::fs::File::create(&restored).unwrap()).unwrap();
	{
		let raw = rusqlite::Connection::open(&restored).unwrap();
		for table in ["day_salt", "registrations"] {
			assert_eq!(raw.query_row(&format!("SELECT COUNT(*) FROM {table}"), [], |r| r.get::<_, i64>(0)).unwrap(), 0, "{table}");
		}
		assert_eq!(raw.query_row("SELECT COUNT(*) FROM settings WHERE key = 'instance'", [], |r| r.get::<_, i64>(0)).unwrap(), 0);
	}
	let copy = Db::open(&restored).unwrap();
	let lines = copy.export(0, 10, false).unwrap();
	assert_eq!((lines.len(), lines[0].text.as_str()), (1, chunk(1, 0).as_str()));
	assert_ne!(lines[0].instance, instance);
	drop(copy);
	drop(app);
	std::fs::remove_dir_all(&dir).unwrap();
}
