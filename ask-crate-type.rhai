let cratetype = variable::get("cratetype").to_lower();
while switch cratetype {
    "lib" => {
        debug("you selected to make a lib crate");
        file::delete("Cargo-bin.toml");
        file::delete("src/main.rs");
        file::rename("Cargo-lib.toml", "Cargo.toml");
        false
    }
    "bin" => {
        debug("you selected to make a bin crate");
        file::delete("Cargo-lib.toml");
        file::delete("src/lib.rs");
        file::rename("Cargo-bin.toml", "Cargo.toml");
        false
    }
    _ => true,
} {
    cratetype = variable::prompt("Which type of crate do you want to generate", "lib", ["lib", "bin"]);
}
variable::set("cratetype", cratetype);