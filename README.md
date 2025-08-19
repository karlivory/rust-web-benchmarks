# Rust web benchmarks

Responds "Hello, World!" to every request on "/" endpoint:

- [actix-web](benchmark/hello-world/actix-web/src/main.rs)
- [axum](benchmark/hello-world/axum/src/main.rs)
- [khttp](benchmark/hello-world/khttp/src/main.rs)
- [may_minihttp](benchmark/hello-world/may_minihttp/src/main.rs)
- [poem](benchmark/hello-world/poem/src/main.rs)

# Benchmark
`rewrk --threads 14 --connections 512 -d 30s -h http://127.0.0.1:3000`
## Comparisons

| Framework Name | Latency.Avg | Latency.Stdev | Latency.Min | Latency.Max | Request.Total | Request.Req/Sec | Transfer.Total | Transfer.Rate | Max. Memory Usage |
|---|---|---|---|---|---|---|---|---|---|
|actix-web|1.74ms|0.99ms|0.02ms|12.77ms|8834540|294482.41|1.07GB|36.51MB/Sec|11.8MB|
|axum|1.70ms|0.88ms|0.02ms|11.98ms|9011306|300391.76|1.09GB|37.24MB/Sec|16.7MB|
|khttp|1.44ms|0.72ms|0.02ms|11.24ms|10654993|355189.40|1.40GB|47.76MB/Sec|1.6MB|
|may_minihttp|1.45ms|0.88ms|0.02ms|17.11ms|10601768|353383.70|1.39GB|47.52MB/Sec|43.1MB|
|poem|1.82ms|0.95ms|0.02ms|14.28ms|8448862|281641.16|1.02GB|34.92MB/Sec|22.0MB|

---

# Benchmark
`rewrk --threads 14 --connections 256 -d 30s -h http://127.0.0.1:3000`
## Comparisons

| Framework Name | Latency.Avg | Latency.Stdev | Latency.Min | Latency.Max | Request.Total | Request.Req/Sec | Transfer.Total | Transfer.Rate | Max. Memory Usage |
|---|---|---|---|---|---|---|---|---|---|
|actix-web|0.76ms|0.48ms|0.02ms|6.53ms|10031938|334395.98|1.21GB|41.46MB/Sec|7.7MB|
|axum|0.87ms|0.44ms|0.02ms|5.14ms|8829165|294312.12|1.07GB|36.49MB/Sec|10.2MB|
|khttp|0.74ms|0.37ms|0.02ms|6.95ms|10407988|346929.36|1.37GB|46.65MB/Sec|1.7MB|
|may_minihttp|0.74ms|0.46ms|0.02ms|10.17ms|10318865|343981.35|1.36GB|46.25MB/Sec|26.2MB|
|poem|0.90ms|0.47ms|0.02ms|7.05ms|8498602|283294.12|1.03GB|35.12MB/Sec|13.8MB|

---

# Benchmark
`rewrk --threads 14 --connections 64 -d 30s -h http://127.0.0.1:3000`
## Comparisons

| Framework Name | Latency.Avg | Latency.Stdev | Latency.Min | Latency.Max | Request.Total | Request.Req/Sec | Transfer.Total | Transfer.Rate | Max. Memory Usage |
|---|---|---|---|---|---|---|---|---|---|
|actix-web|0.22ms|0.14ms|0.01ms|3.51ms|8722086|290740.10|1.06GB|36.05MB/Sec|4.8MB|
|axum|0.23ms|0.11ms|0.01ms|2.78ms|8412656|280429.48|1.02GB|34.77MB/Sec|5.7MB|
|khttp|0.21ms|0.09ms|0.02ms|3.47ms|9124382|304146.55|1.20GB|40.90MB/Sec|1.6MB|
|may_minihttp|0.21ms|0.15ms|0.01ms|4.30ms|9280547|309354.56|1.22GB|41.60MB/Sec|13.5MB|
|poem|0.24ms|0.11ms|0.01ms|2.70ms|8073649|269124.70|1000.95MB|33.37MB/Sec|7.9MB|

---

