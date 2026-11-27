#!/usr/bin/env bash
set -u
DOMAIN="$1"; OUT="$2"; D="$OUT/urls"; mkdir -p "$D"
if command -v gau >/dev/null 2>&1; then gau "$DOMAIN" --subs > "$D/gau.txt" 2>/dev/null || true; else : > "$D/gau.txt"; fi
if command -v waybackurls >/dev/null 2>&1; then printf '%s\n' "$DOMAIN" | waybackurls > "$D/waybackurls.txt" 2>/dev/null || true; else : > "$D/waybackurls.txt"; fi
