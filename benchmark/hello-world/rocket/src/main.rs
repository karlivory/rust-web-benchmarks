use rocket::{config::LogLevel, get, launch, routes, Config};

#[get("/")]
fn hello() -> &'static str {
    "Hello, world!"
}

#[launch]
fn rocket() -> _ {
    let config = Config {
        port: 3000,
        address: "127.0.0.1".parse().unwrap(),
        profile: Config::RELEASE_PROFILE,
        log_level: LogLevel::Critical,
        ..Config::debug_default()
    };
    rocket::custom(&config).mount("/", routes![hello])
}
