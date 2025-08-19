use std::io;

use may_minihttp::{HttpService, HttpServiceFactory, Request, Response};

#[derive(Clone)]
struct WebFramework;

impl HttpService for WebFramework {
    fn call(&mut self, req: Request, rsp: &mut Response) -> io::Result<()> {
        let method = req.method();
        // let path = req.path();
        let path = extract_path(req.path());

        match (method, path) {
            ("GET", "/") => {
                rsp.header("Content-Type: text/plain; charset=utf-8");
                rsp.status_code(200, "OK");
                rsp.body("Hello, World!");
            }
            _ => {
                rsp.status_code(404, "Not Found");
            }
        }

        Ok(())
    }
}

// every other framework correctly handles absolute-path vs origin-path
// so this is added just for the sake of fairness
fn extract_path(path: &str) -> &str {
    let mut path = path;
    if let Some(idx) = path.find("://") {
        if let Some(after_host) = path[idx + 3..].find('/') {
            path = &path[idx + 3 + after_host..];
        } else {
            path = "/";
        }
    }

    if let Some(idx) = path.find('?') {
        &path[..idx]
    } else {
        path
    }
}

struct HttpServer {}

impl HttpServiceFactory for HttpServer {
    type Service = WebFramework;

    fn new_service(&self, _: usize) -> Self::Service {
        WebFramework {}
    }
}

fn main() {
    let http_server = HttpServer {};
    let server = http_server.start("0.0.0.0:3000").unwrap();
    server.join().unwrap();
}
