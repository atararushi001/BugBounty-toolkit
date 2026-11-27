#!/usr/bin/env bash
set -u
DOMAIN="$1"; OUT="$2"; D="$OUT/security"; mkdir -p "$D"
grep -Ei '/(login|signin|signup|register|auth|oauth|sso|admin|account|password|reset|2fa|mfa)(/|\\?|$)' \
  "$OUT/urls/all.txt" | sort -u > "$D/auth_candidates.txt" 2>/dev/null || true
