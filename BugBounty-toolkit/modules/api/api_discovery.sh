#!/usr/bin/env bash
set -u
DOMAIN="$1"; OUT="$2"; D="$OUT/api"; mkdir -p "$D"
URLS="$OUT/urls/all.txt"
grep -Ei 'swagger|openapi|graphql|/api/|/v[0-9]+/|/docs|/redoc' "$URLS" |
  sort -u > "$D/api_candidates.txt" 2>/dev/null || true
for path in swagger.json openapi.json api/swagger.json api/openapi.json graphql; do
  for scheme in https http; do
    u="$scheme://$DOMAIN/$path"
    code="$(curl -ksL -o /dev/null -w '%{http_code}' --max-time 8 "$u" 2>/dev/null || true)"
    [[ "$code" =~ ^(200|204|301|302|401|403)$ ]] && echo "$code $u"
  done
done > "$D/common_api_paths.txt"
