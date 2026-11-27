#!/usr/bin/env bash
set -u
DOMAIN="$1"; OUT="$2"; D="$OUT/javascript"; mkdir -p "$D"
URLS="$OUT/urls/all.txt"
grep -Ei '\.js(\?|$)' "$URLS" | sort -u > "$D/js_urls.txt" 2>/dev/null || true
: > "$D/js_endpoints.txt"
: > "$D/js_secrets_review.txt"
while IFS= read -r u; do
  body="$(curl -ksL --max-time 10 "$u" 2>/dev/null || true)"
  printf '%s\n' "$body" | grep -Eo 'https?://[^"'\'' ]+|/[A-Za-z0-9_./-]+/[A-Za-z0-9_./?=&%-]*' |
    sort -u | sed "s#^#$u -> #" >> "$D/js_endpoints.txt" || true
  printf '%s\n' "$body" | grep -Ei 'api[_-]?key|secret|token|client[_-]?secret|password' |
    head -n 20 | sed "s#^#$u -> #" >> "$D/js_secrets_review.txt" || true
done < "$D/js_urls.txt"
sort -u "$D/js_endpoints.txt" -o "$D/js_endpoints.txt" 2>/dev/null || true
