#!/usr/bin/env bash
set -u
DOMAIN="$1"; OUT="$2"; D="$OUT/security"; mkdir -p "$D"
: > "$D/cors.txt"
while IFS= read -r u; do
  echo "### $u" >> "$D/cors.txt"
  curl -ksI --max-time 8 -H 'Origin: https://example.invalid' "$u" 2>/dev/null |
    grep -Ei '^(HTTP/|access-control-)' >> "$D/cors.txt" || true
done < "$OUT/http/live.txt"
