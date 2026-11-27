# BugBounty-toolkit

Web-focused reconnaissance and security-audit toolkit for authorized bug-bounty,
CTF, lab, and penetration-testing scopes.

## Workflow

scope -> subdomains -> DNS -> HTTP -> ports -> crawling -> historical URLs
-> JS/API analysis -> VHosts -> content discovery -> security checks -> Nuclei
-> takeover indicators -> report

The toolkit is intentionally separated from the broader CPENT toolkit.
Automated modules perform reconnaissance and non-destructive checks; manual
testing remains a separate checklist.

## Main launcher

```bash
chmod +x recon.sh
./recon.sh example.com
./recon.sh example.com -o ./results --deep
```

Only test domains you own or are explicitly authorized to assess.
