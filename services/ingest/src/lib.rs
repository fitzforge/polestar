//! Polestar's ingest server: hands out tokens behind a proof of work, receives Recorder chunks
//! from Polestar Client, validates them with the recording library and stores them for forge.
//! The API is specified in docs/RECORDING.md ("Upload API").
//!
//! The source is public, so nothing here relies on it being secret: tokens are made by the
//! server and cost a proof of work, registrations are capped per client IP, every chunk is
//! decoded and checked for plausibility, and the maintainer can shadow-ban a contributor.
//!
//! The database is one connection behind one mutex, held only for queries: uploads are read,
//! decoded and checked outside it, one chunk at a time, with at most [`UPLOAD_CONCURRENCY`]
//! uploads at once.

pub mod db;
pub mod limit;
pub mod recording;

use std::net::IpAddr;
use std::sync::{Arc, Mutex, MutexGuard, PoisonError};
use std::time::{Duration, Instant, SystemTime, UNIX_EPOCH};

use axum::body::{to_bytes, Body, Bytes};
use axum::extract::{DefaultBodyLimit, Path, Query, Request, State};
use axum::http::{header, HeaderMap, HeaderValue, Method, StatusCode};
use axum::middleware::{self, Next};
use axum::response::{IntoResponse, Response};
use axum::routing::{get, post};
use axum::{Extension, Json, Router};
use hmac::{Hmac, Mac};
use polestar_recording::api::{pow_ok, AdminContributor, RegisterChallenge, RegisterResponse, UploadRequest, UploadResponse, MAX_UPLOAD_CHUNKS};
use serde::Deserialize;
use sha2::{Digest, Sha256};
use subtle::ConstantTimeEq;
use tower_http::cors::{AllowOrigin, CorsLayer};
use tower_http::limit::RequestBodyLimitLayer;
use tower_http::trace::TraceLayer;

use crate::db::{Db, Moderation, Registration, Upload, UploadOutcome};
use crate::limit::RateLimiter;

/// Largest request body (2 MiB).
pub const MAX_BODY: usize = polestar_recording::api::MAX_UPLOAD_BYTES;
/// Largest `/v1/register` body.
pub const MAX_REGISTER_BODY: usize = 1024;
/// Bytes one contributor may send per UTC day.
pub const DAILY_BYTES: u64 = 20 * 1024 * 1024;
/// Requests one contributor may make per minute.
pub const REQUESTS_PER_MINUTE: u32 = 30;
/// Requests one client IP may make per minute, on every `/v1` route.
pub const IP_REQUESTS_PER_MINUTE: u32 = 120;
/// `/v1/register` requests one client IP may make per minute.
pub const REGISTER_REQUESTS_PER_MINUTE: u32 = 10;
/// Requests with an unknown token one client IP may make per minute.
pub const UNKNOWN_TOKENS_PER_MINUTE: u32 = 10;
/// Tokens one network (an IPv4 address, an IPv6 /48) may register per UTC day.
pub const REGISTRATIONS_PER_DAY: u32 = 3;
/// Uploads handled at once; more wait their turn.
pub const UPLOAD_CONCURRENCY: usize = 4;
/// How long a client may take to send a request body.
pub const BODY_TIMEOUT: Duration = Duration::from_secs(10);
/// How long `/healthz` waits for the database.
pub const HEALTH_TIMEOUT: Duration = Duration::from_secs(2);
/// How long a registration challenge stays valid.
pub const CHALLENGE_TTL: i64 = 600;
/// How long `/v1/stats` answers are reused.
pub const STATS_TTL: Duration = Duration::from_secs(60);
/// Export page size when none is asked for, and the most one page holds.
pub const EXPORT_DEFAULT: u32 = 500;
pub const EXPORT_MAX: u32 = 1000;
/// The header Cloudflare sets to the client's address; the tunnel is the only way in.
pub const CLIENT_IP_HEADER: &str = "cf-connecting-ip";

/// The Tauri uploader's origins on Windows, macOS and Linux.
const ORIGINS: [&str; 3] = ["tauri://localhost", "http://tauri.localhost", "https://tauri.localhost"];

const DAY: i64 = 86_400;

type HmacSha256 = Hmac<Sha256>;

pub struct Config {
	/// Bearer key for the export and the moderation routes.
	pub maintainer_key: String,
	/// Chunks whose `session` build is below this are stored flagged (0 accepts all builds).
	pub min_build: u32,
	/// Signs registration challenges.
	pub secret: String,
	/// Proof-of-work difficulty in leading zero bits.
	pub pow_bits: u32,
	/// Serve requests without `CF-Connecting-IP` (local development and tests only).
	pub allow_direct: bool,
}

/// The request's network as today's HMAC (see [`network`]), set by the client IP layer.
#[derive(Clone)]
struct ClientIp(String);

pub struct AppState {
	db: Mutex<Db>,
	maintainer_key_hash: [u8; 32],
	min_build: u32,
	challenge_key: [u8; 32],
	pow_bits: u32,
	allow_direct: bool,
	limiter: RateLimiter,
	ip_limiter: RateLimiter,
	register_limiter: RateLimiter,
	unknown_limiter: RateLimiter,
	uploads: tokio::sync::Semaphore,
	/// Today's salt for network HMACs: (day, salt), a copy of the one in the database.
	salt: Mutex<(i64, [u8; 32])>,
	stats_cache: Mutex<Option<(Instant, Bytes)>>,
}

/// A mutex's guard, also after a panic while it was held: every state behind these mutexes is
/// left consistent between statements (the database rolls back an unfinished transaction).
fn lock<T>(m: &Mutex<T>) -> MutexGuard<'_, T> {
	m.lock().unwrap_or_else(PoisonError::into_inner)
}

/// The network an address counts as, for the registration cap and cohorts: an IPv4 address
/// (also when IPv4-mapped), or an IPv6 /48, which is what one site is usually routed.
pub fn network(ip: IpAddr) -> String {
	match ip {
		IpAddr::V6(v6) => match v6.to_ipv4_mapped() {
			Some(v4) => v4.to_string(),
			None => format!("{}/48", std::net::Ipv6Addr::from(u128::from(v6) & !(u128::MAX >> 48))),
		},
		v4 => v4.to_string(),
	}
}

impl AppState {
	pub fn new(db: Db, config: Config) -> Arc<AppState> {
		Arc::new(AppState {
			db: Mutex::new(db),
			maintainer_key_hash: Sha256::digest(config.maintainer_key.as_bytes()).into(),
			min_build: config.min_build,
			challenge_key: hmac(config.secret.as_bytes(), &[b"polestar-ingest challenge"]),
			pow_bits: config.pow_bits,
			allow_direct: config.allow_direct,
			limiter: RateLimiter::new(REQUESTS_PER_MINUTE, Duration::from_secs(60)),
			ip_limiter: RateLimiter::new(IP_REQUESTS_PER_MINUTE, Duration::from_secs(60)),
			register_limiter: RateLimiter::new(REGISTER_REQUESTS_PER_MINUTE, Duration::from_secs(60)),
			unknown_limiter: RateLimiter::new(UNKNOWN_TOKENS_PER_MINUTE, Duration::from_secs(60)),
			uploads: tokio::sync::Semaphore::new(UPLOAD_CONCURRENCY),
			salt: Mutex::new((i64::MIN, [0; 32])),
			stats_cache: Mutex::new(None),
		})
	}

	fn db(&self) -> MutexGuard<'_, Db> {
		lock(&self.db)
	}

	/// The network's HMAC under today's salt. The salt lives in the database for that day only,
	/// so a restart keeps the day's registration counts and cohorts.
	async fn network_hash(self: &Arc<Self>, ip: IpAddr) -> Result<String, ApiError> {
		let today = now().div_euclid(DAY);
		let cached = { *lock(&self.salt) };
		let salt = if cached.0 == today {
			cached.1
		} else {
			let fresh = random()?;
			let s = self.clone();
			let salt = blocking(move || s.db().day_salt(today, fresh).map_err(internal)).await?;
			*lock(&self.salt) = (today, salt);
			salt
		};
		Ok(hex(&hmac(&salt, &[network(ip).as_bytes()])[..16]))
	}
}

fn hmac(key: &[u8], parts: &[&[u8]]) -> [u8; 32] {
	let mut mac = HmacSha256::new_from_slice(key).expect("HMAC takes any key length");
	for p in parts {
		mac.update(p);
	}
	mac.finalize().into_bytes().into()
}

fn random<const N: usize>() -> Result<[u8; N], ApiError> {
	let mut buf = [0; N];
	getrandom::fill(&mut buf).map_err(internal)?;
	Ok(buf)
}

pub fn router(state: Arc<AppState>) -> Router {
	let cors = CorsLayer::new()
		.allow_origin(AllowOrigin::list(ORIGINS.map(HeaderValue::from_static)))
		.allow_methods([Method::GET, Method::POST, Method::DELETE])
		.allow_headers([header::AUTHORIZATION, header::CONTENT_TYPE])
		.max_age(Duration::from_secs(3600));
	let v1 = Router::new()
		.route("/v1/register", post(register))
		.route("/v1/upload", post(upload))
		.route("/v1/me", get(me).delete(delete_me))
		.route("/v1/stats", get(stats))
		.route("/v1/export", get(export))
		.route("/v1/export/tombstones", get(tombstones))
		.route("/v1/admin/contributors", get(admin_contributors))
		.route("/v1/admin/contributors/{hash}/block", post(block))
		.route("/v1/admin/contributors/{hash}/unblock", post(unblock))
		.route_layer(middleware::from_fn_with_state(state.clone(), client_ip));
	// `/healthz` is for the container healthcheck, which runs inside the container.
	Router::new()
		.route("/healthz", get(healthz))
		.merge(v1)
		.layer(DefaultBodyLimit::max(MAX_BODY))
		.layer(RequestBodyLimitLayer::new(MAX_BODY))
		.layer(cors)
		// Method, path and status only: never bodies, headers or addresses.
		.layer(TraceLayer::new_for_http())
		.with_state(state)
}

/// An error answer: a status and `{ "error": "..." }`.
#[derive(Debug)]
pub struct ApiError(StatusCode, String);

impl ApiError {
	fn new(status: StatusCode, message: impl Into<String>) -> ApiError {
		ApiError(status, message.into())
	}

	fn unknown_token() -> ApiError {
		ApiError::new(StatusCode::UNAUTHORIZED, "unknown token")
	}

	fn too_many() -> ApiError {
		ApiError::new(StatusCode::TOO_MANY_REQUESTS, "too many requests, try again in a minute")
	}

	fn over_daily_cap() -> ApiError {
		ApiError::new(StatusCode::TOO_MANY_REQUESTS, "daily upload limit (20 MiB) reached, try again tomorrow")
	}
}

impl IntoResponse for ApiError {
	fn into_response(self) -> Response {
		let mut response = (self.0, Json(serde_json::json!({ "error": self.1 }))).into_response();
		if self.0 == StatusCode::TOO_MANY_REQUESTS {
			response.headers_mut().insert(header::RETRY_AFTER, HeaderValue::from_static("60"));
		}
		response
	}
}

fn internal(e: impl std::fmt::Display) -> ApiError {
	tracing::error!("internal error: {e}");
	ApiError::new(StatusCode::INTERNAL_SERVER_ERROR, "internal error")
}

fn now() -> i64 {
	SystemTime::now().duration_since(UNIX_EPOCH).map(|d| d.as_secs() as i64).unwrap_or(0)
}

fn bearer(headers: &HeaderMap) -> Option<&str> {
	let value = headers.get(header::AUTHORIZATION)?.to_str().ok()?;
	let token = value.strip_prefix("Bearer ").or_else(|| value.strip_prefix("bearer "))?.trim();
	(!token.is_empty()).then_some(token)
}

fn is_hex(s: &str) -> bool {
	s.bytes().all(|b| matches!(b, b'0'..=b'9' | b'a'..=b'f'))
}

fn hex(bytes: &[u8]) -> String {
	use std::fmt::Write;
	bytes.iter().fold(String::with_capacity(bytes.len() * 2), |mut s, b| {
		let _ = write!(s, "{b:02x}");
		s
	})
}

fn unhex<const N: usize>(s: &str) -> Option<[u8; N]> {
	if s.len() != N * 2 || !is_hex(s) {
		return None;
	}
	let mut out = [0; N];
	for (i, b) in out.iter_mut().enumerate() {
		*b = u8::from_str_radix(&s[i * 2..i * 2 + 2], 16).ok()?;
	}
	Some(out)
}

async fn blocking<T: Send + 'static>(f: impl FnOnce() -> Result<T, ApiError> + Send + 'static) -> Result<T, ApiError> {
	tokio::task::spawn_blocking(f).await.map_err(internal)?
}

/// A request body of at most `limit` bytes, sent within [`BODY_TIMEOUT`].
async fn read_body(body: Body, limit: usize) -> Result<Bytes, ApiError> {
	match tokio::time::timeout(BODY_TIMEOUT, to_bytes(body, limit)).await {
		Err(_) => Err(ApiError::new(StatusCode::REQUEST_TIMEOUT, "request body too slow")),
		Ok(Err(_)) => Err(ApiError::new(StatusCode::PAYLOAD_TOO_LARGE, format!("body over {} KiB", limit / 1024))),
		Ok(Ok(bytes)) => Ok(bytes),
	}
}

/// Every `/v1` request: the client IP from `CF-Connecting-IP` (refused without one unless
/// direct requests are allowed), kept only as today's HMAC of its network, and the per-network
/// request limit.
async fn client_ip(State(state): State<Arc<AppState>>, mut request: Request, next: Next) -> Result<Response, ApiError> {
	let ip = match request.headers().get(CLIENT_IP_HEADER) {
		Some(value) => value.to_str().ok().and_then(|s| s.trim().parse::<IpAddr>().ok()).ok_or_else(|| ApiError::new(StatusCode::BAD_REQUEST, "bad client address"))?,
		None if state.allow_direct => IpAddr::from([127, 0, 0, 1]),
		None => return Err(ApiError::new(StatusCode::FORBIDDEN, "direct requests are not served")),
	};
	let hash = state.network_hash(ip).await?;
	if !state.ip_limiter.check(&hash, Instant::now()) {
		return Err(ApiError::too_many());
	}
	request.extensions_mut().insert(ClientIp(hash));
	Ok(next.run(request).await)
}

/// The contributor id a request claims: the hex SHA-256 of its bearer token.
fn token_hash(headers: &HeaderMap) -> Result<String, ApiError> {
	let token = bearer(headers).ok_or_else(|| ApiError::new(StatusCode::UNAUTHORIZED, "missing bearer token"))?;
	// Tokens are 32 random bytes in hex, made by `/v1/register`.
	if token.len() != 64 || !is_hex(token) {
		return Err(ApiError::unknown_token());
	}
	Ok(hex(&Sha256::digest(token.as_bytes())))
}

/// After a token was found unknown: counts it against the network's unknown-token limit.
fn unknown(state: &AppState, ip: &str) -> ApiError {
	if state.unknown_limiter.check(ip, Instant::now()) {
		ApiError::unknown_token()
	} else {
		ApiError::too_many()
	}
}

/// The per-contributor request limit, for a token found in the database (so made-up tokens
/// never get a bucket).
fn limit(state: &AppState, hash: &str) -> Result<(), ApiError> {
	if state.limiter.check(hash, Instant::now()) {
		Ok(())
	} else {
		Err(ApiError::too_many())
	}
}

/// [`token_hash`] for a registered contributor, after the request limits.
async fn contributor(state: &Arc<AppState>, headers: &HeaderMap, ip: &str) -> Result<String, ApiError> {
	let hash = token_hash(headers)?;
	let s = state.clone();
	let h = hash.clone();
	let known = blocking(move || s.db().contributor(&h).map_err(internal)).await?.is_some();
	if !known {
		return Err(unknown(state, ip));
	}
	limit(state, &hash)?;
	Ok(hash)
}

fn maintainer(state: &AppState, headers: &HeaderMap) -> Result<(), ApiError> {
	let key = bearer(headers).ok_or_else(|| ApiError::new(StatusCode::UNAUTHORIZED, "missing maintainer key"))?;
	let given: [u8; 32] = Sha256::digest(key.as_bytes()).into();
	if !bool::from(given.ct_eq(&state.maintainer_key_hash)) {
		return Err(ApiError::new(StatusCode::UNAUTHORIZED, "wrong maintainer key"));
	}
	Ok(())
}

/// `ok` when the database answers within [`HEALTH_TIMEOUT`], else 503 (and the container
/// healthcheck fails).
async fn healthz(State(state): State<Arc<AppState>>) -> Response {
	let check = tokio::task::spawn_blocking(move || {
		let deadline = Instant::now() + HEALTH_TIMEOUT;
		loop {
			match state.db.try_lock() {
				Ok(db) => return db.ping().is_ok(),
				Err(std::sync::TryLockError::Poisoned(e)) => return e.into_inner().ping().is_ok(),
				Err(std::sync::TryLockError::WouldBlock) if Instant::now() < deadline => std::thread::sleep(Duration::from_millis(20)),
				Err(std::sync::TryLockError::WouldBlock) => return false,
			}
		}
	});
	match check.await {
		Ok(true) => "ok".into_response(),
		_ => (StatusCode::SERVICE_UNAVAILABLE, "database busy").into_response(),
	}
}

#[derive(Deserialize)]
#[serde(deny_unknown_fields)]
struct RegisterBody {
	challenge: Option<String>,
	solution: Option<String>,
}

/// A challenge is 16 bytes: expiry (u32, big-endian unix seconds), a random nonce (4 bytes) and
/// the first 8 bytes of their HMAC with the server secret. The server keeps no state for it
/// until it is spent. Public for tests (an expired challenge).
pub fn make_challenge(state: &AppState, expires: i64) -> Result<String, ApiError> {
	let mut c = [0u8; 16];
	c[..4].copy_from_slice(&u32::try_from(expires).map_err(internal)?.to_be_bytes());
	c[4..8].copy_from_slice(&random::<4>()?);
	let mac = hmac(&state.challenge_key, &[&c[..8]]);
	c[8..].copy_from_slice(&mac[..8]);
	Ok(hex(&c))
}

/// The challenge's expiry when the server made it; None when it did not.
fn challenge_expiry(state: &AppState, challenge: &str) -> Option<i64> {
	let c: [u8; 16] = unhex(challenge)?;
	let mac = hmac(&state.challenge_key, &[&c[..8]]);
	if !bool::from(mac[..8].ct_eq(&c[8..])) {
		return None;
	}
	Some(i64::from(u32::from_be_bytes([c[0], c[1], c[2], c[3]])))
}

fn registration_cap() -> ApiError {
	ApiError::new(StatusCode::TOO_MANY_REQUESTS, "registration limit for today reached, try again tomorrow")
}

async fn register(State(state): State<Arc<AppState>>, Extension(ClientIp(ip)): Extension<ClientIp>, body: Body) -> Result<Response, ApiError> {
	if !state.register_limiter.check(&ip, Instant::now()) {
		return Err(ApiError::too_many());
	}
	let bytes = read_body(body, MAX_REGISTER_BODY).await?;
	let request: RegisterBody = serde_json::from_slice(&bytes).map_err(|_| ApiError::new(StatusCode::BAD_REQUEST, "bad register request"))?;
	let now = now();
	let today = now.div_euclid(DAY);
	let (s, network) = (state.clone(), ip.clone());
	if blocking(move || s.db().registrations(today, &network).map_err(internal)).await? >= REGISTRATIONS_PER_DAY {
		return Err(registration_cap());
	}
	let (challenge, solution) = match (request.challenge, request.solution) {
		(None, None) => {
			let expires = now + CHALLENGE_TTL;
			let challenge = make_challenge(&state, expires)?;
			return Ok(Json(RegisterChallenge { challenge, difficulty: state.pow_bits, expires }).into_response());
		}
		(Some(c), Some(s)) => (c, s),
		_ => return Err(ApiError::new(StatusCode::BAD_REQUEST, "send {} for a challenge, or challenge and solution")),
	};
	let expires = challenge_expiry(&state, &challenge).ok_or_else(|| ApiError::new(StatusCode::BAD_REQUEST, "bad challenge"))?;
	if expires < now {
		return Err(ApiError::new(StatusCode::BAD_REQUEST, "challenge expired"));
	}
	let solution: u64 = (solution.len() <= 20).then(|| solution.parse().ok()).flatten().ok_or_else(|| ApiError::new(StatusCode::BAD_REQUEST, "bad solution"))?;
	if !pow_ok(&challenge, solution, state.pow_bits) {
		return Err(ApiError::new(StatusCode::BAD_REQUEST, "wrong solution"));
	}
	let token = hex(&random::<32>()?);
	let hash = hex(&Sha256::digest(token.as_bytes()));
	let fresh_cohort = hex(&random::<8>()?);
	// Counted and stored in one transaction, so parallel solutions cannot pass the cap.
	match blocking(move || state.db().register(&hash, &challenge, expires, now, &ip, &fresh_cohort, REGISTRATIONS_PER_DAY).map_err(internal)).await? {
		Registration::Done(_) => Ok(Json(RegisterResponse { token }).into_response()),
		Registration::Spent => Err(ApiError::new(StatusCode::BAD_REQUEST, "challenge already used")),
		Registration::OverCap => Err(registration_cap()),
	}
}

async fn upload(State(state): State<Arc<AppState>>, Extension(ClientIp(ip)): Extension<ClientIp>, headers: HeaderMap, body: Body) -> Result<Json<UploadResponse>, ApiError> {
	let contributor = token_hash(&headers)?;
	// The contributor, its bytes today and the install are looked up once the body is read;
	// before, only whether the declared size is already over today's cap.
	let declared = headers.get(header::CONTENT_LENGTH).and_then(|v| v.to_str().ok()).and_then(|v| v.parse::<u64>().ok()).unwrap_or(0);
	let (s, c) = (state.clone(), contributor.clone());
	let used = blocking(move || s.db().install_context(&c, "", now()).map_err(internal)).await?;
	let Some(used) = used.map(|ctx| ctx.used_today) else { return Err(unknown(&state, &ip)) };
	limit(&state, &contributor)?;
	if used.saturating_add(declared) > DAILY_BYTES {
		return Err(ApiError::over_daily_cap());
	}
	let _permit = state.uploads.acquire().await.map_err(internal)?;
	let bytes = read_body(body, MAX_BODY).await?;
	let request: UploadRequest = serde_json::from_slice(&bytes).map_err(|e| ApiError::new(StatusCode::BAD_REQUEST, format!("bad upload: {e}")))?;
	let body_len = bytes.len() as u64;
	drop(bytes);
	if !polestar_recording::sv::valid_install(&request.install) {
		return Err(ApiError::new(StatusCode::BAD_REQUEST, "bad install id"));
	}
	if request.uploader.len() > 32 {
		return Err(ApiError::new(StatusCode::BAD_REQUEST, "bad uploader version"));
	}
	if request.chunks.len() > MAX_UPLOAD_CHUNKS {
		return Err(ApiError::new(StatusCode::BAD_REQUEST, format!("more than {MAX_UPLOAD_CHUNKS} chunks in one upload")));
	}
	let s = state.clone();
	let outcome = blocking(move || {
		let now = now();
		let install = s.db().install_context(&contributor, &request.install, now).map_err(internal)?.ok_or_else(ApiError::unknown_token)?;
		if install.used_today.saturating_add(body_len) > DAILY_BYTES {
			return Ok(UploadOutcome::OverDailyCap);
		}
		// Decoded and checked without the database lock.
		let mut ctx = polestar_recording::plausible::Context { now, highest: install.highest };
		let prepared: Vec<_> = request.chunks.into_iter().map(|c| recording::prepare(c, s.min_build, &mut ctx)).collect();
		let upload = Upload { contributor: &contributor, install: &request.install, uploader: &request.uploader, body_len, now };
		s.db().upload(upload, prepared, DAILY_BYTES).map_err(internal)
	})
	.await?;
	match outcome {
		UploadOutcome::Done(response) => Ok(Json(response)),
		UploadOutcome::OverDailyCap => Err(ApiError::over_daily_cap()),
		UploadOutcome::Unknown => Err(ApiError::unknown_token()),
	}
}

async fn me(State(state): State<Arc<AppState>>, Extension(ClientIp(ip)): Extension<ClientIp>, headers: HeaderMap) -> Result<Json<polestar_recording::api::MeResponse>, ApiError> {
	let contributor = contributor(&state, &headers, &ip).await?;
	let me = blocking(move || state.db().me(&contributor).map_err(internal)).await?;
	Ok(Json(me))
}

async fn delete_me(State(state): State<Arc<AppState>>, Extension(ClientIp(ip)): Extension<ClientIp>, headers: HeaderMap) -> Result<Json<serde_json::Value>, ApiError> {
	let contributor = contributor(&state, &headers, &ip).await?;
	let deleted = blocking(move || state.db().delete_contributor(&contributor, now()).map_err(internal)).await?;
	Ok(Json(serde_json::json!({ "deleted": deleted })))
}

async fn stats(State(state): State<Arc<AppState>>) -> Result<Response, ApiError> {
	let cached = lock(&state.stats_cache).as_ref().filter(|(at, _)| at.elapsed() < STATS_TTL).map(|(_, body)| body.clone());
	let body = match cached {
		Some(body) => body,
		None => {
			let s = state.clone();
			let body = Bytes::from(
				blocking(move || {
					let stats = s.db().stats(now()).map_err(internal)?;
					serde_json::to_string(&stats).map_err(internal)
				})
				.await?,
			);
			*lock(&state.stats_cache) = Some((Instant::now(), body.clone()));
			body
		}
	};
	Ok(([(header::CONTENT_TYPE, "application/json"), (header::CACHE_CONTROL, "public, max-age=60")], body).into_response())
}

#[derive(Deserialize)]
struct ExportQuery {
	after: Option<i64>,
	limit: Option<u32>,
	/// `suspect` adds the chunks that failed the plausibility checks.
	include: Option<String>,
}

/// NDJSON of `items`, serialised line by line as the body is sent.
fn ndjson<T: serde::Serialize + Send + 'static>(items: Vec<T>) -> Response {
	let lines = futures_util::stream::iter(items.into_iter().map(|item| {
		let mut line = serde_json::to_vec(&item)?;
		line.push(b'\n');
		Ok::<_, serde_json::Error>(line)
	}));
	([(header::CONTENT_TYPE, "application/x-ndjson")], Body::from_stream(lines)).into_response()
}

async fn export(State(state): State<Arc<AppState>>, headers: HeaderMap, Query(query): Query<ExportQuery>) -> Result<Response, ApiError> {
	maintainer(&state, &headers)?;
	let after = query.after.unwrap_or(0);
	let limit = query.limit.unwrap_or(EXPORT_DEFAULT).clamp(1, EXPORT_MAX);
	let suspect = match query.include.as_deref() {
		None | Some("") => false,
		Some("suspect") => true,
		Some(_) => return Err(ApiError::new(StatusCode::BAD_REQUEST, "include takes only `suspect`")),
	};
	let lines = blocking(move || state.db().export(after, limit, suspect).map_err(internal)).await?;
	Ok(ndjson(lines))
}

#[derive(Deserialize)]
struct TombstoneQuery {
	after: Option<i64>,
}

async fn tombstones(State(state): State<Arc<AppState>>, headers: HeaderMap, Query(query): Query<TombstoneQuery>) -> Result<Response, ApiError> {
	maintainer(&state, &headers)?;
	let after = query.after.unwrap_or(0);
	Ok(ndjson(blocking(move || state.db().tombstones(after).map_err(internal)).await?))
}

async fn admin_contributors(State(state): State<Arc<AppState>>, headers: HeaderMap) -> Result<Json<Vec<AdminContributor>>, ApiError> {
	maintainer(&state, &headers)?;
	Ok(Json(blocking(move || state.db().contributors().map_err(internal)).await?))
}

async fn set_blocked(state: Arc<AppState>, headers: HeaderMap, prefix: String, blocked: bool) -> Result<Json<serde_json::Value>, ApiError> {
	maintainer(&state, &headers)?;
	// The export shows 16 hex digits of the hash; accept those or more.
	if !(16..=64).contains(&prefix.len()) || !is_hex(&prefix) {
		return Err(ApiError::new(StatusCode::BAD_REQUEST, "give at least 16 lowercase hex digits of the contributor hash"));
	}
	match blocking(move || state.db().set_blocked(&prefix, blocked, now()).map_err(internal)).await? {
		Moderation::Done(hash) => Ok(Json(serde_json::json!({ "hash": hash, "blocked": blocked }))),
		Moderation::NotFound => Err(ApiError::new(StatusCode::NOT_FOUND, "no such contributor")),
		Moderation::Ambiguous => Err(ApiError::new(StatusCode::CONFLICT, "more than one contributor has that prefix")),
	}
}

async fn block(State(state): State<Arc<AppState>>, headers: HeaderMap, Path(hash): Path<String>) -> Result<Json<serde_json::Value>, ApiError> {
	set_blocked(state, headers, hash, true).await
}

async fn unblock(State(state): State<Arc<AppState>>, headers: HeaderMap, Path(hash): Path<String>) -> Result<Json<serde_json::Value>, ApiError> {
	set_blocked(state, headers, hash, false).await
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn networks() {
		assert_eq!(network("203.0.113.7".parse().unwrap()), "203.0.113.7");
		assert_eq!(network("::ffff:203.0.113.7".parse().unwrap()), "203.0.113.7");
		assert_eq!(network("2001:db8:abcd:12:1::5".parse().unwrap()), "2001:db8:abcd::/48");
		assert_eq!(network("2001:db8:abcd:ffff::1".parse().unwrap()), network("2001:db8:abcd::9".parse().unwrap()));
	}
}
