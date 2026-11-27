#!/usr/bin/env bash
set -u
DOMAIN="$1"; OUT="$2"; D="$OUT/nuclei"; mkdir -p "$D"
if command -v nuclei >/dev/null 2>&1; then
  nuclei -l "$OUT/http/live.txt" -silent -severity low,medium,high,critical \
    -o "$D/nuclei.txt" 2>/dev/null || true
else
  echo "nuclei not installed." > "$D/status.txt"
fi
