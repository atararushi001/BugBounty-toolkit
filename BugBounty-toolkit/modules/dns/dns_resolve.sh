#!/usr/bin/env bash
set -u
DOMAIN="$1"; OUT="$2"; D="$OUT/dns"; mkdir -p "$D"
INPUT="$OUT/subdomains/subdomains.txt"
if command -v dnsx >/dev/null 2>&1; then
  dnsx -l "$INPUT" -silent -a -resp -o "$D/dnsx.txt" 2>/dev/null || true
else
  : > "$D/dnsx.txt"
  while IFS= read -r h; do
    ip="$(dig +short A "$h" 2>/dev/null | grep -E '^[0-9.]+$' | head -n1 || true)"
    [[ -n "$ip" ]] && printf '%s %s\n' "$h" "$ip"
  done < "$INPUT" > "$D/fallback.txt"
fi
