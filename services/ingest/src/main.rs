//! `polestar-ingest`             serve (configuration from the environment, see README.md)
//! `polestar-ingest healthcheck` exit 0 when the local server answers `/healthz` (for the container healthcheck)
//! `polestar-ingest backup <path>` a gzipped online copy of the database (INGEST_DB) at `path`; keeps the newest 7

use std::io::{Read, Write};
use std::net::{SocketAddr, TcpStream};
use std::path::{Path, PathBuf};
use std::process::ExitCode;
use std::sync::Arc;
use std::time::Duration;

use polestar_ingest::db::Db;
use polestar_ingest::{router, AppState, Config};
use tracing_subscriber::EnvFilter;

fn env(name: &str) -> Option<String> {
	std::env::var(name).ok().filter(|v| !v.trim().is_empty())
}

fn addr() -> Result<SocketAddr, String> {
	let addr = env("INGEST_ADDR").unwrap_or_else(|| "0.0.0.0:8080".to_owned());
	addr.parse().map_err(|e| format!("INGEST_ADDR {addr:?}: {e}"))
}

fn healthcheck() -> Result<(), String> {
	let port = addr()?.port();
	let target = SocketAddr::from(([127, 0, 0, 1], port));
	let mut stream = TcpStream::connect_timeout(&target, Duration::from_secs(3)).map_err(|e| e.to_string())?;
	stream.set_read_timeout(Some(Duration::from_secs(3))).map_err(|e| e.to_string())?;
	stream.write_all(b"GET /healthz HTTP/1.1\r\nHost: localhost\r\nConnection: close\r\n\r\n").map_err(|e| e.to_string())?;
	let mut answer = String::new();
	stream.read_to_string(&mut answer).map_err(|e| e.to_string())?;
	if answer.starts_with("HTTP/1.1 200") && answer.ends_with("ok") {
		Ok(())
	} else {
		Err(format!("unexpected answer: {}", answer.lines().next().unwrap_or("")))
	}
}

fn config() -> Result<(Config, PathBuf, SocketAddr), String> {
	let maintainer_key = env("INGEST_MAINTAINER_KEY").ok_or("INGEST_MAINTAINER_KEY is not set")?;
	if maintainer_key.len() < 32 {
		return Err("INGEST_MAINTAINER_KEY is shorter than 32 characters".to_owned());
	}
	let min_build = match env("INGEST_MIN_BUILD") {
		Some(v) => v.trim().parse().map_err(|e| format!("INGEST_MIN_BUILD {v:?}: {e}"))?,
		None => 0,
	};
	let secret = env("INGEST_SECRET").ok_or("INGEST_SECRET is not set")?;
	if secret.len() < 32 {
		return Err("INGEST_SECRET is shorter than 32 characters".to_owned());
	}
	let pow_bits = match env("INGEST_POW_BITS") {
		Some(v) => v.trim().parse().ok().filter(|b| (1..=40).contains(b)).ok_or_else(|| format!("INGEST_POW_BITS {v:?}: expected 1..=40"))?,
		None => polestar_recording::api::POW_BITS,
	};
	let allow_direct = env("INGEST_ALLOW_DIRECT").as_deref() == Some("1");
	let number = |name: &str, default: u64| -> Result<u64, String> {
		match env(name) {
			Some(v) => v.trim().parse().ok().filter(|n| *n > 0).ok_or_else(|| format!("{name} {v:?}: expected a positive whole number")),
			None => Ok(default),
		}
	};
	let max_db_bytes = number("INGEST_MAX_DB_MB", polestar_ingest::MAX_DB_BYTES >> 20)?.saturating_mul(1 << 20);
	let min_free_bytes = number("INGEST_MIN_FREE_GB", polestar_ingest::MIN_FREE_BYTES >> 30)?.saturating_mul(1 << 30);
	let retain_days = i64::try_from(number("INGEST_RETAIN_DAYS", polestar_ingest::RETAIN_DAYS as u64)?).map_err(|e| e.to_string())?;
	let db = db_path();
	let data_dir = db.parent().map(Path::to_path_buf);
	Ok((Config { maintainer_key, min_build, secret, pow_bits, allow_direct, max_db_bytes, data_dir, min_free_bytes, retain_days }, db, addr()?))
}

fn db_path() -> PathBuf {
	env("INGEST_DB").map_or_else(|| PathBuf::from("/data/ingest.sqlite"), PathBuf::from)
}

/// Runs [`AppState::maintain`] now and every [`polestar_ingest::MAINTENANCE_EVERY`].
async fn maintenance(state: Arc<AppState>) {
	let mut every = tokio::time::interval(polestar_ingest::MAINTENANCE_EVERY);
	loop {
		every.tick().await;
		let s = state.clone();
		let now = std::time::SystemTime::now().duration_since(std::time::UNIX_EPOCH).map_or(0, |d| d.as_secs() as i64);
		match tokio::task::spawn_blocking(move || s.maintain(now)).await {
			Ok(Ok(0)) => {}
			Ok(Ok(n)) => tracing::info!("maintenance: {n} acknowledged chunk(s) past retention deleted"),
			Ok(Err(e)) => tracing::error!("maintenance: {e}"),
			Err(e) => tracing::error!("maintenance: {e}"),
		}
	}
}

async fn shutdown() {
	let ctrl_c = async {
		let _ = tokio::signal::ctrl_c().await;
	};
	#[cfg(unix)]
	let term = async {
		if let Ok(mut s) = tokio::signal::unix::signal(tokio::signal::unix::SignalKind::terminate()) {
			s.recv().await;
		}
	};
	#[cfg(not(unix))]
	let term = std::future::pending::<()>();
	tokio::select! {
		() = ctrl_c => {}
		() = term => {}
	}
}

#[tokio::main]
async fn main() -> ExitCode {
	let args: Vec<String> = std::env::args().skip(1).collect();
	if args.first().map(String::as_str) == Some("backup") {
		let [_, dest] = args.as_slice() else {
			eprintln!("usage: polestar-ingest backup <path>");
			return ExitCode::from(2);
		};
		return match polestar_ingest::backup::backup(&db_path(), Path::new(dest)) {
			Ok(size) => {
				println!("{dest}: {size} bytes");
				ExitCode::SUCCESS
			}
			Err(e) => {
				eprintln!("backup: {e}");
				ExitCode::FAILURE
			}
		};
	}
	if args.first().map(String::as_str) == Some("healthcheck") {
		return match healthcheck() {
			Ok(()) => ExitCode::SUCCESS,
			Err(e) => {
				eprintln!("healthcheck: {e}");
				ExitCode::FAILURE
			}
		};
	}
	tracing_subscriber::fmt().with_env_filter(EnvFilter::try_from_default_env().unwrap_or_else(|_| EnvFilter::new("info,tower_http=info"))).init();
	let (config, db_path, addr) = match config() {
		Ok(c) => c,
		Err(e) => {
			eprintln!("polestar-ingest: {e}");
			return ExitCode::FAILURE;
		}
	};
	let db = match Db::open(&db_path) {
		Ok(db) => db,
		Err(e) => {
			eprintln!("polestar-ingest: opening {}: {e}", db_path.display());
			return ExitCode::FAILURE;
		}
	};
	let (min_build, pow_bits, allow_direct, retain_days, max_db_mb) = (config.min_build, config.pow_bits, config.allow_direct, config.retain_days, config.max_db_bytes >> 20);
	let state = AppState::new(db, config);
	tokio::spawn(maintenance(state.clone()));
	let app = router(state);
	let listener = match tokio::net::TcpListener::bind(addr).await {
		Ok(l) => l,
		Err(e) => {
			eprintln!("polestar-ingest: binding {addr}: {e}");
			return ExitCode::FAILURE;
		}
	};
	tracing::info!(
		"listening on {addr}, database {} (cap {max_db_mb} MiB, acknowledged chunks kept {retain_days} days), min build {min_build}, proof of work {pow_bits} bits, direct requests {}",
		db_path.display(),
		if allow_direct { "allowed" } else { "refused" }
	);
	if let Err(e) = axum::serve(listener, app).with_graceful_shutdown(shutdown()).await {
		eprintln!("polestar-ingest: {e}");
		return ExitCode::FAILURE;
	}
	ExitCode::SUCCESS
}
