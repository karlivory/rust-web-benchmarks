#!/bin/bash
set -euo pipefail

OUTPUT="README.md"

cat >"$OUTPUT" <<'EOF'
# Rust web benchmarks

Responds "Hello, World!" to every GET request on "/" endpoint:

- [actix-web](benchmark/hello-world/actix-web/src/main.rs)
- [axum](benchmark/hello-world/axum/src/main.rs)
- [khttp](benchmark/hello-world/khttp/src/main.rs)
- [may_minihttp](benchmark/hello-world/may_minihttp/src/main.rs)
- [poem](benchmark/hello-world/poem/src/main.rs)

## Benchmarks

**Specs**: Intel(R) Core(TM) Ultra 5 125U, 14 cpus.

EOF

RESULTS=(
  result/hello-world-64.md
  result/hello-world-256.md
  result/hello-world-512.md
)

{
  for file in "${RESULTS[@]}"; do
    [[ -f "$file" ]] || continue

    awk '
      BEGIN {
        in_table = 0
        table_started = 0
      }

      # command
      /^[[:space:]]*`[^`]*rewrk[^`]*`[[:space:]]*$/ {
        print
        print ""
        next
      }

      # start of table
      /^##[[:space:]]+Comparisons[[:space:]]*$/ {
        in_table = 1
        table_started = 0
        next
      }

      # in table
      in_table && /^[[:space:]]*\|/ {
        print
        table_started = 1
        next
      }

      # end of table
      in_table && table_started && !/^[[:space:]]*\|/ {
        in_table = 0
        next
      }

      { next }
    ' "$file"

    # Separate blocks with a blank line
    echo
  done
} >>"$OUTPUT"
