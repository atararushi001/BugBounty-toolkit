#!/usr/bin/env bash
set -u
DOMAIN="$1"; OUT="$2"; D="$OUT/reports"; mkdir -p "$D"
{
  echo "# BugBounty Recon Report"
  echo
  echo "Target: $DOMAIN"
  echo "Date: $(date)"
  echo
  echo "## Counts"
  echo "- Subdomains: $(wc -l < "$OUT/subdomains/subdomains.txt" 2>/dev/null || echo 0)"
  echo "- Live URLs: $(wc -l < "$OUT/http/live.txt" 2>/dev/null || echo 0)"
  echo "- URLs: $(wc -l < "$OUT/urls/all.txt" 2>/dev/null || echo 0)"
  echo "- Parameterized URLs: $(wc -l < "$OUT/urls/parameterized.txt" 2>/dev/null || echo 0)"
  echo
  echo "## Key files"
  echo "- subdomains/subdomains.txt"
  echo "- http/httpx.txt"
  echo "- urls/all.txt"
  echo "- urls/parameterized.txt"
  echo "- javascript/js_endpoints.txt"
  echo "- api/api_candidates.txt"
  echo "- content/results.txt"
  echo "- security/disclosure_candidates.txt"
  echo "- nuclei/nuclei.txt"
  echo
  echo "Scanner results are leads requiring manual validation."
} > "$D/REPORT.md"
