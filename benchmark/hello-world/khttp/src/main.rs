use std::sync::LazyLock;

use khttp::{Headers, Method, ServerBuilder};

static BASE_HEADERS: LazyLock<Headers<'static>> = LazyLock::new(|| {
    let mut headers = Headers::new();
    headers.add(Headers::CONTENT_TYPE, b"text/plain; charset=utf-8");
    headers.add("server", b"K");
    headers
});

fn main() {
    let mut app = ServerBuilder::new("127.0.0.1:3000").unwrap();

    app.route(Method::Get, "/", |_, res| {
        res.ok(&BASE_HEADERS, "Hello, World!".as_bytes())
    });

    app.build().serve_epoll().unwrap();
}
