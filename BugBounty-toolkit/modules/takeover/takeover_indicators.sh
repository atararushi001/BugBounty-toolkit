#!/usr/bin/env bash
set -u
DOMAIN="$1"; OUT="$2"; D="$OUT/takeover"; mkdir -p "$D"
if command -v nuclei >/dev/null 2>&1; then
  nuclei -l "$OUT/http/live.txt" -tags takeover -silent -o "$D/nuclei_takeover.txt" 2>/dev/null || true
else
  echo "nuclei unavailable; review DNS/CNAME manually." > "$D/status.txt"
fi
if [[ -f "$OUT/dns/dnsx.txt" ]]; then
  grep -Ei 'CNAME|cloudfront|github|heroku|azure|fastly|netlify|vercel' "$OUT/dns/dnsx.txt" > "$D/cname_indicators.txt" 2>/dev/null || true
fi
