#!/usr/bin/env bash
set -u
DOMAIN="$1"; OUT="$2"; D="$OUT/crawl"; mkdir -p "$D"
INPUT="$OUT/http/live.txt"
if command -v katana >/dev/null 2>&1; then
  katana -list "$INPUT" -silent -jc -kf all -d 3 -o "$D/katana.txt" 2>/dev/null || true
else
  : > "$D/katana.txt"
fi
