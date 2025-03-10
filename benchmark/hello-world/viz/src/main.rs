#![deny(warnings)]

use std::net::SocketAddr;
use tokio::net::TcpListener;
use viz::{serve, Request, Result, Router};

async fn index(_: Request) -> Result<&'static str> {
    Ok("Hello, World!")
}

#[tokio::main]
async fn main() {
    let addr = SocketAddr::from(([127, 0, 0, 1], 3000));
    let listener = TcpListener::bind(addr).await.unwrap();

    let app = Router::new().get("/", index);

    serve(listener, app).await.unwrap();
}
