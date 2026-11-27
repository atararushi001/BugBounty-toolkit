#!/usr/bin/env bash
set -u
DOMAIN="$1"; OUT="$2"; D="$OUT/subdomains"; mkdir -p "$D"
: > "$D/all.txt"
for tool in subfinder assetfinder findomain; do
  if command -v "$tool" >/dev/null 2>&1; then
    case "$tool" in
      subfinder) subfinder -d "$DOMAIN" -silent >> "$D/$tool.txt" 2>/dev/null || true;;
      assetfinder) assetfinder --subs-only "$DOMAIN" > "$D/$tool.txt" 2>/dev/null || true;;
      findomain) findomain -t "$DOMAIN" -q > "$D/$tool.txt" 2>/dev/null || true;;
    esac
    cat "$D/$tool.txt" >> "$D/all.txt" 2>/dev/null || true
  fi
done
printf '%s\n' "$DOMAIN" >> "$D/all.txt"
sed 's/^\*\.//' "$D/all.txt" | tr '[:upper:]' '[:lower:]' |
  grep -E "(^|[.])$(printf '%s' "$DOMAIN" | sed 's/\./\\./g')$" |
  sort -u > "$D/subdomains.txt"
