#!/usr/bin/env bash
set -u
DOMAIN="$1"; OUT="$2"; D="$OUT/security"; mkdir -p "$D"
grep -Ei '(\.git/|\.env($|\?)|swagger|openapi|debug|trace|backup|\.bak($|\?)|\.old($|\?)|phpinfo|server-status)' \
  "$OUT/urls/all.txt" | sort -u > "$D/disclosure_candidates.txt" 2>/dev/null || true
