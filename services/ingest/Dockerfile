# The ingest server image. Build context: the repository root (or any copy
# holding services/ingest and rust/crates/polestar-recording at the same
# paths); see compose.yaml and deploy.sh. Base images are pinned by digest (tag in front for
# people): update the digests together, on purpose.
FROM rust:1.99.1-bookworm@sha256:48b7f435b8fc6378ce43b44f15e3a47fd8919b2825f835c39bd4bd3da50af5b8 AS build
WORKDIR /src
COPY rust/crates/polestar-recording rust/crates/polestar-recording
COPY services/ingest services/ingest
WORKDIR /src/services/ingest
RUN --mount=type=cache,target=/usr/local/cargo/registry \
	--mount=type=cache,target=/src/services/ingest/target \
	cargo build --release --locked \
	&& cp target/release/polestar-ingest /polestar-ingest \
	&& mkdir /data /backup

# No shell, no package manager; runs as uid 65532.
FROM gcr.io/distroless/cc-debian12:nonroot@sha256:9dac0a79194e45a7da0158a9c6da57b217585af0786db3845d1f0ec1a0dd182f
COPY --from=build /polestar-ingest /polestar-ingest
COPY --from=build --chown=65532:65532 /data /data
COPY --from=build --chown=65532:65532 /backup /backup
# SQLite's temporary files (VACUUM, large sorts) go to the writable data volume: the root
# filesystem is read-only.
ENV INGEST_DB=/data/ingest.sqlite INGEST_ADDR=0.0.0.0:8080 SQLITE_TMPDIR=/data
VOLUME /data /backup
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 CMD ["/polestar-ingest", "healthcheck"]
ENTRYPOINT ["/polestar-ingest"]
