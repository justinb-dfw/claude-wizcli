---
name: wizcli
description: Use when the user asks to "scan code", "scan directory", "scan container", "scan image",
  "scan IaC", "scan terraform", "scan dockerfile", "wizcli scan", "wiz scan", "security scan with wiz",
  "scan for secrets", "scan for vulnerabilities", or wants to run local security scans via Wiz CLI.
---

# Wiz CLI Security Scanner

Scan local code, directories, container images, and IaC files using wizcli.

## Authentication

Two methods supported — the wrapper script auto-detects which to use:

**Method 1: Service account (automatic, headless)**
If `~/.wiz-token` exists, credentials are read and exported automatically. No user interaction needed.

**Method 2: Device code OAuth (interactive)**
If no `~/.wiz-token` exists, wizcli uses its cached session. If not authenticated, the user must run once manually:
```bash
~/.claude/skills/wizcli/wizcli auth --use-device-code
```
This opens a browser for Wiz login. The session is cached and reused for subsequent scans.

## Wrapper Script

All commands go through the wrapper which handles auth automatically:

```bash
~/.claude/skills/wizcli/run-wizcli.sh <command> [args...]
```

## Scan Types

### Directory / Code Scan

Scan a local directory for vulnerabilities, secrets, misconfigurations, and malware:

```bash
~/.claude/skills/wizcli/run-wizcli.sh scan dir <path>
```

Options:
- `--no-publish` — local-only scan, don't upload results to Wiz portal
- `--policy <name>` — apply a specific Wiz policy
- `--disabled-scanners=<list>` — skip specific scanners (comma-separated: Vulnerability, SensitiveData, Misconfiguration, SoftwareSupplyChain, AIModels, SAST, Malware)
- `--format json` — output as JSON for parsing

### Container Image Scan

Scan a local or registry container image:

```bash
~/.claude/skills/wizcli/run-wizcli.sh scan image <image:tag>
```

### IaC Scan (Terraform, CloudFormation, Kubernetes)

Scan Infrastructure as Code files:

```bash
~/.claude/skills/wizcli/run-wizcli.sh scan iac --path <path>
```

### Docker Compose Scan

```bash
~/.claude/skills/wizcli/run-wizcli.sh scan docker-compose --file <path>
```

## Common Patterns

**Full scan of current directory:**
```bash
~/.claude/skills/wizcli/run-wizcli.sh scan dir . --no-publish
```

**Scan only for secrets:**
```bash
~/.claude/skills/wizcli/run-wizcli.sh scan dir . --disabled-scanners=Vulnerability,Misconfiguration,SoftwareSupplyChain,AIModels,SAST,Malware --no-publish
```

**Scan and publish to Wiz portal:**
```bash
~/.claude/skills/wizcli/run-wizcli.sh scan dir .
```

**JSON output for parsing:**
```bash
~/.claude/skills/wizcli/run-wizcli.sh scan dir . --no-publish --format json
```

## Limitations

- Large scans may take several minutes
- `--no-publish` recommended for local development; omit to send results to Wiz portal
- Device code OAuth requires a one-time browser login; service account auth is fully headless

## Installing wizcli

```bash
# Apple Silicon Mac
curl -Lo ~/.claude/skills/wizcli/wizcli https://downloads.wiz.io/v1/wizcli/latest/wizcli-darwin-arm64

# Intel Mac
curl -Lo ~/.claude/skills/wizcli/wizcli https://downloads.wiz.io/v1/wizcli/latest/wizcli-darwin-amd64

# Linux x86_64
curl -Lo ~/.claude/skills/wizcli/wizcli https://downloads.wiz.io/v1/wizcli/latest/wizcli-linux-amd64

# Linux ARM64
curl -Lo ~/.claude/skills/wizcli/wizcli https://downloads.wiz.io/v1/wizcli/latest/wizcli-linux-arm64

chmod +x ~/.claude/skills/wizcli/wizcli
```

## Updating wizcli

Same as install — re-download the latest binary and `chmod +x`.
