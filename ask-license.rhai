let license = variable::get("license").to_lower();
while switch license {
    "none" => {
        debug("you selected to not use any license");
        file::delete("LICENSE-APACHE");
        file::delete("LICENSE-MIT");
        false
    }
    "MIT" => {
        debug("you selected to use the MIT license");
        file::delete("LICENSE-APACHE");
        file::rename("LICENSE-MIT", "LICENSE");
        false
    }
    "APACHE" => {
        debug("you selected to use the APACHE license");
        file::rename("LICENSE-APACHE", "LICENSE");
        file::delete("LICENSE-MIT");
        false
    }
    "MIT+APACHE" => {
        debug("you selected to use the MIT and APACHE license");
        false
    }
    _ => true,
} {
    license = variable::prompt("Which license do you want to use?", "none", ["none", "APACHE", "MIT", "MIT+APACHE"]);
}
variable::set("license", license);