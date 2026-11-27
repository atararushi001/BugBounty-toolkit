#!/usr/bin/env bash
set -u
DOMAIN="$1"; OUT="$2"; D="$OUT/urls"; mkdir -p "$D"
cat "$OUT/http/live.txt" "$OUT/crawl/katana.txt" "$D/gau.txt" "$D/waybackurls.txt" 2>/dev/null |
  grep -E '^https?://' | sort -u > "$D/all.txt" || true
grep -E '\?.+=' "$D/all.txt" | sort -u > "$D/parameterized.txt" || true
grep -Ei '\.(js|json|php|asp|aspx|jsp)(\?|$)' "$D/all.txt" | sort -u > "$D/interesting_extensions.txt" || true
