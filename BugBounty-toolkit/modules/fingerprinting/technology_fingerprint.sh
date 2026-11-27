#!/usr/bin/env bash
set -u
DOMAIN="$1"; OUT="$2"; D="$OUT/fingerprints"; mkdir -p "$D"
if command -v whatweb >/dev/null 2>&1; then
  whatweb --no-errors -i "$OUT/http/live.txt" --log-verbose="$D/whatweb.txt" 2>/dev/null || true
else
  : > "$D/whatweb.txt"
fi
