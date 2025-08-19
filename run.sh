#!/usr/bin/env bash
set -euo pipefail

cd bench-bot || exit 1

DURATION=60
COOLDOWN=60
CONCURRENCY_LEVELS=(64 256 512)

for i in "${!CONCURRENCY_LEVELS[@]}"; do
  concurrency=${CONCURRENCY_LEVELS[$i]}

  cargo run --release -- -w ../benchmark -o ../result -c "$concurrency" -d "$DURATION" --cd "$COOLDOWN"

  if ((i < ${#CONCURRENCY_LEVELS[@]} - 1)); then
    sleep "$COOLDOWN"
  fi
done
