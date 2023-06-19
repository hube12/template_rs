#!/usr/bin/env sh
# To be run in ./afl-fuzz

cargo install afl
RUSTFLAGS=-Zsanitizer=address cargo afl build --workspace
cargo afl fuzz -i afl-fuzz/in-dummy -o afl-fuzz/out-dummy target/debug/{{project-name}}