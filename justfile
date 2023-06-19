#!/usr/bin/env just --justfile

package_name := `sed -En 's/name[[:space:]]*=[[:space:]]*"([^"]+)"/\1/p' Cargo.toml | head -1`
package_version := `sed -En 's/version[[:space:]]*=[[:space:]]*"([^"]+)"/\1/p' Cargo.toml | head -1`

default: fmt lint tests

rtestp TEST PATH:
	sudo env "PATH=$PATH" cargo test {{TEST}} --manifest-path {{PATH}} -- --nocapture

rtest TEST:
	sudo env "PATH=$PATH" cargo test {{TEST}} -- --nocapture

rtests:
	sudo env "PATH=$PATH" cargo test --workspace -- --test-threads=1 --nocapture

testp TEST PATH:
	sudo cargo test {{TEST}} --manifest-path {{PATH}} -- --nocapture

test TEST:
	sudo cargo test {{TEST}} -- --nocapture

tests:
	sudo cargo test --workspace -- --test-threads=1 --nocapture

bench:
	cargo bench

lint:
	cargo clippy

fmt:
    cargo +nightly fmt --all

cross:
    ./scripts/cross_test.sh

docker:
    rm -rf docker_out
    docker build . -f Dockerfile --tag temp_rust_build:1.0
    docker create --name temp_rust_build temp_rust_build:1.0
    docker cp temp_rust_build:/build/target docker_out
    docker rm temp_rust_build

run USER:
    chmod +x ./scripts/run.sh
    ./scripts/run.sh {{USER}}

build USER:
    chmod +x ./scripts/build.sh
    ./scripts/build.sh {{USER}}

fullbuild:
    cargo build --release --workspace

audit:
    cargo install --locked cargo-audit && cargo audit

deny:
    cargo install --locked cargo-deny && cargo deny check

clean:
	cargo clean
	find . -type f -name "*.orig" -exec rm {} \;
	find . -type f -name "*.bk" -exec rm {} \;
	find . -type f -name ".*~" -exec rm {} \;

doc:
   cargo doc --open --no-deps
