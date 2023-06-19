# {{project-name}} 

Generate it with `cargo generate https://github.com/hube12/template_rs`

## Tooling

You can install `just` with `cargo install just`. Once done you will have the following command to your disposal:

- `just test <test_name> <manifest_path>` : Run a single test with root privilege on a specific manifest path (useful
  for workspace).
- `just tests` : Run all tests in the workspace sequentially and with root privilege.
- `just bench` : Run benchmark using criterion.
- `just lint` : Run rustfmt with nightly, useful to format everything before committing.
- `just cross` : Run cross test with docker/podman backend
- `just docker` : Run the dockerfile and extract the result in docker_out
- `just run <user>` : Run the repository as a specific user.
- `just build <user>` : Build the repository as a specific user.
- `just fullbuild` : Build all the workspace.
- `just audit` : Run the cargo audit on the repository (find known vulnerabilities).
- `just deny` : Run the cargo deny on the repository (find licenses issues)
- `just clean` : Clean the repository

We also provide you with an automatic git hook with rusty-hook, this will be installed the first time you build or test
this repository. It will format your repository as a pre-commit hook (but will not fail thus you can still commit and
see the result after).

## Testing

You can run a full suite of tests using simple tools by running `./scripts/run-local-ci.sh`.

## Fuzzing

We use two type of fuzzing, AFL and LibFuzzer. To start with fuzzing we recommend
reading [this book](https://rust-fuzz.github.io/book/).

You can then modify :

- AFL : `afl-fuzz/in-<name>/valid<N>` and `afl-fuzz/src/main.rs#main`
- LibFuzzer : `fuzz/fuzz_targets/fuzz_<name>.rs`

to add a new test.

Once done, you should enter the folder `afl-fuzz` or `fuzz` and run the script `run.sh`.

## License

<!-- TODO: insert license-->

