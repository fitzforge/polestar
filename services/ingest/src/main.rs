//! `polestar-ingest`             serve (configuration from the environment, see README.md)
//! `polestar-ingest healthcheck` exit 0 when the local server answers `/healthz` (for the container healthcheck)

use std::io::{Read, Write};
use std::net::{SocketAddr, TcpStream};
use std::path::PathBuf;
use std::process::ExitCode;
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
	let db = env("INGEST_DB").map_or_else(|| PathBuf::from("/data/ingest.sqlite"), PathBuf::from);
	Ok((Config { maintainer_key, min_build, secret, pow_bits, allow_direct }, db, addr()?))
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
	if std::env::args().nth(1).as_deref() == Some("healthcheck") {
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
	let (min_build, pow_bits, allow_direct) = (config.min_build, config.pow_bits, config.allow_direct);
	let app = router(AppState::new(db, config));
	let listener = match tokio::net::TcpListener::bind(addr).await {
		Ok(l) => l,
		Err(e) => {
			eprintln!("polestar-ingest: binding {addr}: {e}");
			return ExitCode::FAILURE;
		}
	};
	tracing::info!("listening on {addr}, database {}, min build {min_build}, proof of work {pow_bits} bits, direct requests {}", db_path.display(), if allow_direct { "allowed" } else { "refused" });
	if let Err(e) = axum::serve(listener, app).with_graceful_shutdown(shutdown()).await {
		eprintln!("polestar-ingest: {e}");
		return ExitCode::FAILURE;
	}
	ExitCode::SUCCESS
}
