#!/usr/bin/env bash
set -u
DOMAIN="$1"; OUT="$2"; D="$OUT/vhosts"; mkdir -p "$D"
: > "$D/notes.txt"
echo "VHost discovery requires an in-scope base URL and a suitable wordlist." > "$D/notes.txt"
if command -v ffuf >/dev/null 2>&1; then
  echo "Example (review scope before use):" >> "$D/notes.txt"
  echo "ffuf -u https://TARGET/ -H 'Host: FUZZ.$DOMAIN' -w WORDLIST" >> "$D/notes.txt"
fi
