#!/usr/bin/env bash
# BugBounty-toolkit master web reconnaissance runner.
set -u
set -o pipefail

DOMAIN=""
OUTBASE="./results"
DEEP=false
SKIP_NUCLEI=false
SKIP_CONTENT=false
SKIP_CRAWL=false

usage() {
cat <<'EOF'
Usage: ./recon.sh <domain> [options]
  -o, --output DIR
  --deep
  --no-nuclei
  --no-content
  --no-crawl
  -h, --help
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -o|--output) OUTBASE="${2:-}"; shift 2;;
    --deep) DEEP=true; shift;;
    --no-nuclei) SKIP_NUCLEI=true; shift;;
    --no-content) SKIP_CONTENT=true; shift;;
    --no-crawl) SKIP_CRAWL=true; shift;;
    -h|--help) usage; exit 0;;
    -*) echo "[!] Unknown option: $1"; usage; exit 1;;
    *) [[ -z "$DOMAIN" ]] && DOMAIN="$1" || { echo "[!] Extra argument: $1"; exit 1; }; shift;;
  esac
done

[[ -z "$DOMAIN" ]] && { usage; exit 1; }
DOMAIN="$(printf '%s' "$DOMAIN" | sed 's#https\?://##; s#/$##')"
SAFE="$(printf '%s' "$DOMAIN" | tr '/: ' '___' | tr -cd '[:alnum:]_.-')"
OUT="$OUTBASE/$SAFE"
mkdir -p "$OUT"

BLUE='\033[0;34m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
log(){ echo -e "${BLUE}[*]${NC} $1"; }
ok(){ echo -e "${GREEN}[+]${NC} $1"; }
warn(){ echo -e "${YELLOW}[!]${NC} $1"; }

exec > >(tee -a "$OUT/recon.log") 2>&1

echo "$DOMAIN" > "$OUT/scope.txt"

run() {
  local rel="$1"; shift
  local p="$PWD/$rel"
  [[ -x "$p" ]] || chmod +x "$p" 2>/dev/null || true
  if [[ -f "$p" ]]; then "$p" "$@"; else warn "Missing module: $rel"; fi
}

run modules/subdomains/subdomain_enum.sh "$DOMAIN" "$OUT"
run modules/dns/dns_resolve.sh "$DOMAIN" "$OUT"
run modules/http/httpx_probe.sh "$DOMAIN" "$OUT"
run modules/ports/naabu_scan.sh "$DOMAIN" "$OUT"

$SKIP_CRAWL || run modules/crawling/katana_crawl.sh "$DOMAIN" "$OUT"
run modules/urls/historical_urls.sh "$DOMAIN" "$OUT"
run modules/urls/url_normalize.sh "$DOMAIN" "$OUT"
run modules/javascript/js_extract.sh "$DOMAIN" "$OUT"
run modules/api/api_discovery.sh "$DOMAIN" "$OUT"
run modules/vhosts/vhost_discovery.sh "$DOMAIN" "$OUT"

$SKIP_CONTENT || run modules/content/content_discovery.sh "$DOMAIN" "$OUT"
run modules/security/security_headers.sh "$DOMAIN" "$OUT"
run modules/security/cors_check.sh "$DOMAIN" "$OUT"
run modules/security/http_methods.sh "$DOMAIN" "$OUT"
run modules/security/auth_surface.sh "$DOMAIN" "$OUT"
run modules/security/info_disclosure.sh "$DOMAIN" "$OUT"
run modules/takeover/takeover_indicators.sh "$DOMAIN" "$OUT"
run modules/fingerprinting/technology_fingerprint.sh "$DOMAIN" "$OUT"

$SKIP_NUCLEI || run modules/nuclei/nuclei_scan.sh "$DOMAIN" "$OUT"

run modules/reporting/build_report.sh "$DOMAIN" "$OUT"

ok "Bug-bounty reconnaissance completed: $OUT"
