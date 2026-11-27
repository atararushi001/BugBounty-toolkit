# Web Manual Testing Checklist

Use only against explicitly authorized scope.

## Recon
- [ ] Scope and exclusions confirmed
- [ ] Subdomains
- [ ] Live hosts
- [ ] Technologies and versions
- [ ] Interesting ports
- [ ] Historical URLs
- [ ] JavaScript endpoints
- [ ] API/OpenAPI/GraphQL
- [ ] VHosts

## Authentication
- [ ] Login
- [ ] Registration
- [ ] Password reset
- [ ] Session handling
- [ ] MFA/2FA
- [ ] OAuth/SSO
- [ ] Rate limiting

## Authorization
- [ ] IDOR/BOLA
- [ ] Horizontal access
- [ ] Vertical access
- [ ] Admin functions

## Input handling
- [ ] XSS
- [ ] SQL injection
- [ ] Command injection
- [ ] SSTI
- [ ] Path traversal
- [ ] LFI/RFI
- [ ] SSRF
- [ ] Open redirect

## Files
- [ ] Upload validation
- [ ] Download authorization
- [ ] Backup files
- [ ] Configuration exposure

## APIs
- [ ] Authentication
- [ ] Authorization
- [ ] Object-level authorization
- [ ] Excessive data exposure
- [ ] Rate limits
- [ ] GraphQL
- [ ] Swagger/OpenAPI

## Browser/security controls
- [ ] CORS
- [ ] CSRF
- [ ] Security headers
- [ ] WebSocket authorization

## Business logic
- [ ] Workflow bypass
- [ ] Race conditions
- [ ] Price/quantity manipulation
- [ ] State transitions
- [ ] Account linking
