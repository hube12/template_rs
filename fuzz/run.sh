#!/usr/bin/env sh
# To be run in ./fuzz

rustup update nightly
cargo install cargo-fuzz
cargo +nightly fuzz run dummy