#!/usr/bin/env bash
set -u
DOMAIN="$1"; OUT="$2"; D="$OUT/security"; mkdir -p "$D"
: > "$D/headers.txt"
while IFS= read -r u; do
  echo "### $u" >> "$D/headers.txt"
  curl -ksI --max-time 10 "$u" 2>/dev/null |
    grep -Ei '^(HTTP/|server:|x-powered-by:|content-security-policy:|strict-transport-security:|x-frame-options:|x-content-type-options:|referrer-policy:|permissions-policy:)' >> "$D/headers.txt" || true
done < "$OUT/http/live.txt"
