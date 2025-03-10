use ntex::web;

async fn index(_req: web::HttpRequest) -> &'static str {
    "Hello world!"
}

#[ntex::main]
async fn main() -> std::io::Result<()> {
    web::server(|| web::App::new().service(web::resource("/").to(index)))
        .bind("127.0.0.1:3000")?
        .run()
        .await
}
