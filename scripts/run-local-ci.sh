#!/bin/bash

rustup --version
rustc --version

# Pre setup
rustup component add rustfmt clippy
cargo install cargo-audit cargo-tarpaulin cargo-deny cross

# Test
echo "Testing everything"
cargo test || exit 1
cargo test --all-features || exit 1
cargo test --workspace -- --test-threads=1 --nocapture || exit 1 # in-depth tests

# Clippy
echo "Checking clippy (known rust mistakes)"
cargo clippy -- -D warnings || exit 1

# Format
echo "Checking formatting"
cargo +nightly fmt -- --check || exit 1

# Audit
echo "Checking known vulnerabilities"
cargo audit --ignore RUSTSEC-2022-0013 || exit 1

# Deny
echo "Checking licenses"
cargo deny -L error check || exit 1

# Coverage
echo "Checking coverage"
cargo tarpaulin --ignore-tests || exit 1
