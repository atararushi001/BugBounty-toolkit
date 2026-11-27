#!/usr/bin/env bash
set -u
DOMAIN="$1"; OUT="$2"; D="$OUT/security"; mkdir -p "$D"
: > "$D/http_methods.txt"
while IFS= read -r u; do
  echo "### $u" >> "$D/http_methods.txt"
  curl -ksI --max-time 8 -X OPTIONS "$u" 2>/dev/null |
    grep -Ei '^(HTTP/|allow:|access-control-allow-methods:)' >> "$D/http_methods.txt" || true
done < "$OUT/http/live.txt"
