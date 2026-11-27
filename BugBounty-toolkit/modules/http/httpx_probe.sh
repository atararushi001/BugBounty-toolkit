#!/usr/bin/env bash
set -u
DOMAIN="$1"; OUT="$2"; D="$OUT/http"; mkdir -p "$D"
INPUT="$OUT/subdomains/subdomains.txt"
if command -v httpx >/dev/null 2>&1; then
  httpx -l "$INPUT" -silent -follow-redirects -status-code -title -tech-detect \
    -web-server -ip -cname -location -o "$D/httpx.txt" 2>/dev/null || true
  awk '{print $1}' "$D/httpx.txt" | grep -E '^https?://' | sort -u > "$D/live.txt" || true
else
  : > "$D/httpx.txt"; : > "$D/live.txt"
fi
