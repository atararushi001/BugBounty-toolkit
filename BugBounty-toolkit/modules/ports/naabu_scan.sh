#!/usr/bin/env bash
set -u
DOMAIN="$1"; OUT="$2"; D="$OUT/ports"; mkdir -p "$D"
INPUT="$OUT/subdomains/subdomains.txt"
if command -v naabu >/dev/null 2>&1; then
  naabu -list "$INPUT" -top-ports 100 -silent -o "$D/naabu.txt" 2>/dev/null || true
else
  : > "$D/naabu.txt"
fi
