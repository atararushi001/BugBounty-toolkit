#!/usr/bin/env bash
set -u
DOMAIN="$1"; OUT="$2"; D="$OUT/content"; mkdir -p "$D"
WORDLIST=""
for w in /usr/share/seclists/Discovery/Web-Content/common.txt /usr/share/wordlists/dirb/common.txt; do
  [[ -f "$w" ]] && WORDLIST="$w" && break
done
if command -v ffuf >/dev/null 2>&1 && [[ -n "$WORDLIST" ]]; then
  sed -E 's#(https?://[^/]+).*#\1#' "$OUT/http/live.txt" | sort -u | head -n 50 > "$D/targets.txt"
  : > "$D/results.txt"
  while IFS= read -r url; do
    tag="$(printf '%s' "$url" | sed 's#https\?://##;s#[/:]#_#g')"
    ffuf -u "${url%/}/FUZZ" -w "$WORDLIST" -mc 200,204,301,302,307,401,403 -t 20 -s \
      -of csv -o "$D/$tag.csv" 2>/dev/null || true
  done < "$D/targets.txt"
  cat "$D"/*.csv 2>/dev/null | sort -u > "$D/results.txt" || true
else
  echo "ffuf or a content wordlist is unavailable." > "$D/status.txt"
fi
