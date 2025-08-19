#!/bin/bash
set -euo pipefail

OUTPUT="README.md"

cat >"$OUTPUT" <<'EOF'
# Rust web benchmarks

Responds "Hello, World!" to every request on "/" endpoint:

- [actix-web](benchmark/hello-world/actix-web/src/main.rs)
- [axum](benchmark/hello-world/axum/src/main.rs)
- [khttp](benchmark/hello-world/khttp/src/main.rs)
- [may_minihttp](benchmark/hello-world/may_minihttp/src/main.rs)
- [poem](benchmark/hello-world/poem/src/main.rs)

EOF

RESULTS=(
  result/hello-world-512.md
  result/hello-world-256.md
  result/hello-world-64.md
)

{
  for file in "${RESULTS[@]}"; do
    [[ -f "$file" ]] || continue

    awk '
      BEGIN {
        saw_bench = 0
        in_table = 0
        table_started = 0
      }

      /^# Benchmark$/ {
        print
        saw_bench = 1
        next
      }

      saw_bench && /^[[:space:]]*`/ {
        print
        saw_bench = 0
        next
      }

      saw_bench && /^[[:space:]]*$/ { next }

      /^##[[:space:]]+Comparisons[[:space:]]*$/ {
        print
        in_table = 1
        next
      }

      in_table && table_started == 0 && /^[[:space:]]*$/ { print; next }

      in_table && /^\|/ {
        print
        table_started = 1
        next
      }

      in_table && table_started == 1 && !/^\|/ { exit }
    ' "$file"

    echo
    echo '---'
    echo
  done
} >>"$OUTPUT"
